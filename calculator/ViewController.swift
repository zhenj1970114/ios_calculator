//
//  ViewController.swift
//  calculator
//
//  Created by Jia Zheng on 9/15/16.
//  Copyright © 2016 Jia Zheng. All rights reserved.
//

import UIKit

enum modes{ //enumeration, save you from having lots of if statement.defining cases
    
    case NOT_SET
    case ADDITION
    case SUBTRACTION
    
}
//keyword enum followed by the name of the enum
//case is different value in the enum

class ViewController: UIViewController {
    
    var labelString: String = "0"
    var currentMode:modes = modes.NOT_SET
    //create a new var, assign a value in the modes to the new var named currentMode
    var savedNum:Int = 0
    var lastButtonWasMode:Bool = false
    
    @IBOutlet weak var label: UILabel!

    @IBAction func tapped0(sender: AnyObject) {tappedNumber(0)}
    @IBAction func tapped1(sender: AnyObject) {tappedNumber(1)}
    @IBAction func tapped2(sender: AnyObject) {tappedNumber(2)}
    @IBAction func tapped3(sender: AnyObject) {tappedNumber(3)}
    @IBAction func tapped4(sender: AnyObject) {tappedNumber(4)}
    @IBAction func tapped5(sender: AnyObject) {tappedNumber(5)}
    @IBAction func tapped6(sender: AnyObject) {tappedNumber(6)}
    @IBAction func tapped7(sender: AnyObject) {tappedNumber(7)}
    @IBAction func tapped8(sender: AnyObject) {tappedNumber(8)}
    @IBAction func tapped9(sender: AnyObject) {tappedNumber(9)}

    
    @IBAction func tappedPlus(sender: AnyObject) {
        changeMode(modes.ADDITION)
    }

    @IBAction func tappedMinus(sender: AnyObject) {
        changeMode(modes.SUBTRACTION)
    }
    
    @IBAction func tappedEqual(sender: AnyObject) {
        guard let num:Int = Int(labelString) else{
            //if labelString is false, go to else
            //num is a let that we create in the guard function
        return
        }
        if lastButtonWasMode || currentMode == modes.NOT_SET{
        return
        }
        if currentMode == modes.ADDITION{
            savedNum += num
            
        }
        else if currentMode == modes.SUBTRACTION{
            savedNum -= num
        }
        currentMode = modes.NOT_SET
        labelString = "\(savedNum)"
        updateText()
        lastButtonWasMode = true
        
    }
    @IBAction func tappedClear(sender: AnyObject) {
        savedNum = 0
        labelString = "0"
        label.text = "0"
        currentMode = modes.NOT_SET
        lastButtonWasMode = false
    }
    
    func tappedNumber(num:Int){
        //capture the number that was pressed
        //append the number onto the existing string
        //update Text 
        
        if lastButtonWasMode{
        //if plus or minus was tabbed, the labelString needs to be back at 0
        lastButtonWasMode = false
        labelString = "0"
            
        }
        labelString = labelString.stringByAppendingString("\(num)")
        updateText()
    }
    
    
    func updateText(){
        guard let labelInt:Int = Int(labelString)else{
        label.text = "Int Conversion Failed"
        return
        }
        if currentMode == modes.NOT_SET{
        savedNum = labelInt
            //the number typed in the label is saved in savedNum until the plus or minus is pressed
      
        }
            //format a number, to time, to dollar amount
            //creating instance of NSNUmberFormatter
        
        let formatter:NSNumberFormatter = NSNumberFormatter()
            //start with 3CAP letter, it's a apple class
            //your own class start with 4CAP letter
        
        formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle // call instance
        let num:NSNumber = NSNumber(integer:labelInt)
        label.text = formatter.stringFromNumber(num)
            //guard statement can wrap a variable or a constant like a if statement
            //it will only percede if the conversion is successful
    
    }
    
    func changeMode(newMode:modes){
        
        if(savedNum == 0){
            return //exist out the method
        }
        currentMode = newMode
        lastButtonWasMode = true
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

