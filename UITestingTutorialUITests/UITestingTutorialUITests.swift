//
//  UITestingTutorialUITests.swift
//  UITestingTutorialUITests
//
//  Created by 田川　裕隆 on 2021/06/22.
//  Copyright © 2021 Code Pro. All rights reserved.
//

import XCTest

class UITestingTutorialUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInvalidLogin_progressSpinnerIsHidden() {
        
        let app = XCUIApplication()
        app.navigationBars["Mockify Music"].buttons["Profile"].tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Login"]/*[[".buttons[\"Login\"].staticTexts[\"Login\"]",".staticTexts[\"Login\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.alerts["Missing Credentials"].scrollViews.otherElements.buttons["Ok"].tap()
        
        let activityIndecatorView = app.activityIndicators["In progress"]
        XCTAssertFalse(activityIndecatorView.exists)
                
    }
    
    func testInvalidLogin_missingCredentialsAlertIsShown() {
        
        let app = XCUIApplication()
        app.navigationBars["Mockify Music"].buttons["Profile"].tap()
        app.textFields["Username"].tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Login"]/*[[".buttons[\"Login\"].staticTexts[\"Login\"]",".staticTexts[\"Login\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let alertDialog = app.alerts["Missing Credentials"]
        
        XCTAssertTrue(alertDialog.exists)
        
        alertDialog.buttons["Ok"].tap()
    }

    func testValidLoginSuccess() {
        
        let validPassword = "abc123"
        let validUserName = "CodePro"
        
        let app = XCUIApplication()
        app.navigationBars["Mockify Music"].buttons["Profile"].tap()
        
        let usernameTextField = app.textFields["Username"]
        XCTAssertTrue(usernameTextField.exists)
        usernameTextField.tap()
        usernameTextField.typeText(validUserName)
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        XCTAssertTrue(passwordSecureTextField.exists)
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText(validPassword)
        
        app/*@START_MENU_TOKEN@*/.staticTexts["Login"]/*[[".buttons[\"Login\"].staticTexts[\"Login\"]",".staticTexts[\"Login\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let downloadsCell = app.tables.staticTexts["My Downloads"]
        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: downloadsCell, handler: nil)
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
