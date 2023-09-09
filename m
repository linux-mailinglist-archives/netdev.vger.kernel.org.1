Return-Path: <netdev+bounces-32709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BA6799897
	for <lists+netdev@lfdr.de>; Sat,  9 Sep 2023 15:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 969621C2094C
	for <lists+netdev@lfdr.de>; Sat,  9 Sep 2023 13:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD8E6AA2;
	Sat,  9 Sep 2023 13:20:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EE12919
	for <netdev@vger.kernel.org>; Sat,  9 Sep 2023 13:20:13 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE3519C;
	Sat,  9 Sep 2023 06:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NPPsMRf/c3Y0QKMacnqiqZtVlUhwrWdTTVxoj/DYNjQ=; b=E5Qmf9Hqbau+JPSQQJTjtHEfQc
	uoNX6XNmBEkoIfTxiz2nBJcraRn69CnXICc5G3IQMisYVNtE//B/w0b9mhn2Y4nJBjzzKnR+lFgTv
	ofoi1D2oCgfHqoG1ln8f9xyiu7LvyY50BkItTdF/ZNtL8WtYxy2rGJKdcBoR/bwnz2Js=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qexsb-0063rb-NF; Sat, 09 Sep 2023 15:20:05 +0200
Date: Sat, 9 Sep 2023 15:20:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	netdev@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	Michael Riesch <michael.riesch@wolfvision.net>
Subject: Re: [PATCH] net: phy: dp83867: Add support for hardware blinking LEDs
Message-ID: <a6c3fb7b-329a-459c-8c76-96da792b137d@lunn.ch>
References: <20230907084731.2181381-1-s.hauer@pengutronix.de>
 <2239338.iZASKD2KPV@steina-w>
 <6c8f5cc5-0b8b-42e0-ac86-91ddcb35389f@lunn.ch>
 <ZPwbmebLiUECCL+x@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPwbmebLiUECCL+x@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Sep 09, 2023 at 08:15:37AM +0100, Russell King (Oracle) wrote:
> On Sat, Sep 09, 2023 at 04:27:31AM +0200, Andrew Lunn wrote:
> > > This works as intended so far. Unfortunately this driver and the PHY LED 
> > > framework do not support active-low LEDs (yet).
> > 
> > Polarity is something which i've seen a few PHY devices have. It also
> > seems like a core LED concept, not something specific to PHY LEDs. So
> > i think this needs to be partially addressed in the LED core.
> 
> However, doesn't the LED layer deals with LED brightness, not by logic
> state? It certainly looks that way, and it's left up to the drivers
> themselves to deal with any polarity inversion - which makes sense if
> the core is just concerned about brightness.
> 
> Introducing inversion in the core means drivers will be passed a
> brightness of "100" for off and "0" for on which, do you not think,
> starts to get rather silly?

Documentation/devicetree/bindings/leds/leds-pwm.yaml has:

      active-low:
        description:
          For PWMs where the LED is wired to supply rather than ground.
        type: boolean

leds-pwm-multicolor.yaml and leds-bcm6358.txt uses the same
property. There is also one case of: irled/ir-spi-led.yaml

  led-active-low:
    type: boolean
    description:
      Output is negated with a NOT gate.

The implementation of the properties is repeated in each driver. So we
probably need to add the parsing of this property in phy_device.c, and
add a led_config() op to struct phy_device to pass polarity
information to the driver.

	Andrew

