//
//  QuestionViewController.swift
//  wordlist
//
//  Created by Yuma Ikeda on 2021/05/09.
//

import UIKit

class QuestionViewController: UIViewController {

    @IBOutlet var anwsweLabel: UILabel!
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var nextButton: UIButton!
    
    var isAnswered: Bool = false //回答したか・次の質問へ行くかの判定
    
    var wordArray: [Dictionary<String, String>] = []//配列
    
    var nowNumber: Int = 0//現在の回答数
    let saveData = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        anwsweLabel.text = ""

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        wordArray = saveData.array(forKey: "WORD")as! [Dictionary<String, String>]
        
        //問題をシャッフルする
        wordArray.shuffle()
        questionLabel.text = wordArray[nowNumber]["english"]
    }
    
    @IBAction func nextButtonTapped(){
        //回答したか
        if isAnswered{
            nowNumber += 1 //次へ
            anwsweLabel.text = ""
            
                //次の問題を表示するか
            if nowNumber < wordArray.count{
                //次を表示
                questionLabel.text = wordArray[nowNumber]["english"]
                
                //ifAnsweredをfalseに
                isAnswered = false
                
                //ボタンのタイトルを変更
                nextButton.setTitle("答えを表示", for: .normal)
            }else{
                nowNumber = 0
                performSegue(withIdentifier: "toFinishView", sender: nil)
            }
        }else{
            anwsweLabel.text = wordArray[nowNumber]["japanese"]
            isAnswered = true
            nextButton.setTitle("次へ", for: .normal)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
