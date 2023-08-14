Return-Path: <netdev+bounces-27419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3142D77BEA1
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 19:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34B5A1C20AC6
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 17:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A78C2FC;
	Mon, 14 Aug 2023 17:05:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3DEC2D9
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 17:05:35 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E616CD1
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 10:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TyyrXIQYHUbbkBSDSd5D0RlmLkxuMe+vCHTkUlZd/6E=; b=Q4RXoKJRvqhgRQUl2AvmaCgi4/
	S1FJLN0ZFOzxYO0l4KvERiTnyPNWQEFl9CrooViCqI3Y2vrbk78mlpnAksVJPoirlE+3zbnYfRWex
	x6UP3TI/WZq4v13OmT1ifcmebireEn3ZPp8M0W0oMLjdSVDOhkxKvDMccoHpTg/wAvA8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qVb0J-0044fd-QO; Mon, 14 Aug 2023 19:05:19 +0200
Date: Mon, 14 Aug 2023 19:05:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: mark parsed interface mode for legacy
 switch drivers
Message-ID: <8687110a-5ce8-474c-8c20-ca682a98a94c@lunn.ch>
References: <20230808123901.3jrqsx7pe357hwkh@skbuf>
 <ZNI7x9uMe6UP2Xhr@shell.armlinux.org.uk>
 <20230808135215.tqhw4mmfwp2c3zy2@skbuf>
 <ZNJO6JQm2g+hv/EX@shell.armlinux.org.uk>
 <20230810151617.wv5xt5idbfu7wkyn@skbuf>
 <ZNd4AJlLLmszeOxg@shell.armlinux.org.uk>
 <20230814145948.u6ul5dgjpl5bnasp@skbuf>
 <ZNpEaMJjmDqhK1dW@shell.armlinux.org.uk>
 <055be6c4-3c28-459d-bb52-5ac2ee24f1f1@lunn.ch>
 <ZNpWAsdS8tDv9qKp@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNpWAsdS8tDv9qKp@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> > RGMII on both ends is unlikely to work, so probably one is
> > wrong. Probably the switch has strapping to set it to rgmii-id, but we
> > don't actually know that. And i guess we have no ability to find out
> > the truth?
> 
> "rgmii" on both ends _can_ work - from our own documentation:
> 
> * PHY_INTERFACE_MODE_RGMII: the PHY is not responsible for inserting any
>   internal delay by itself, it assumes that either the Ethernet MAC (if capable)
>   or the PCB traces insert the correct 1.5-2ns delay
>      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> So, if the board is correctly laid out to include this delay, then RGMII
> on both ends can work.

Yes, which is why is said 'unlikely', not 'will not'. I've not come
across many boards which do have extra long clock tracks, so it is
unlikely this board has them. It is much more likely to be strapped to
do rgmii-id.

> Next, we have no ability to find anything out - we have no hardware.
> LinusW does, but I have no idea whether Linus can read the state of the
> pin strapping. I can see from the RTL8366 info I found that there is
> a register that the delay settings can be read from, but this is not
> the RTL8366, it's RTL8366RB, which Linus already pointed out is
> revision B and is different. So, I would defer to Linus for anything on
> this, and without input from Linus, all we have to go on is what we
> have in the kernel sources.
> 
> > So a narrow definition seems reasonable at the moment, to raise a red
> > warning flag if somebody does try to use rgmii-id which is not
> > actually implemented in the driver. And that user then gets to sort
> > out the problem.
> 
> I think Vladimir will be having a party, because that's now two of us
> who've made the mistake of infering that "phy-mode" changes the
> configuration at the end that has that specified (I can hear the
> baloons being inflated!)
> 
> Of course it shouldn't, as per our documentation on RGMII delays in
> Documentation/networking/phy.rst that was added by Florian back in
> November 2016.

It might not be documented, but there are a couple of DSA drivers
which do react on this property and set their RGMII delays based on
this for their CPU port. mv88e6xxx is one of them, and it also does so
for DSA ports. 

> This brings up the obvious question: does anyone deal with the RGMII
> delays with DSA switches in software, or is it all done by hardware
> pin strapping, hardware defaults, and/or a correctly laid out PCB?

arch/arm/boot/dts/nxp/vf/vf610-zii-dev-rev-b.dts:
                                       switch0port5: port@5 {
                                                reg = <5>;
                                                label = "dsa";
                                                phy-mode = "rgmii-txid";
                                                link = <&switch1port6
                                                        &switch2port9>;
                                                fixed-link {
                                                        speed = <1000>;
                                                        full-duplex;
                                                };
                                        };

and the other end of this link:

                                        switch1port6: port@6 {
                                                reg = <6>;
                                                label = "dsa";
                                                phy-mode = "rgmii-txid";
                                                link = <&switch0port5>;
                                                fixed-link {
                                                        speed = <1000>;
                                                        full-duplex;
                                                };
                                        };

imx7d-zii-rpu2.dts:
                                port@5 {
                                        reg = <5>;
                                        label = "cpu";
                                        ethernet = <&fec1>;
                                        phy-mode = "rgmii-id";

                                        fixed-link {
                                                speed = <1000>;
                                                full-duplex;
                                        };
                                };

With the 'cpu' case, it is clearly acting like a PHY to the SoCs MAC,
so it does not seem too unreasonable for it to act upon it. For a DSA
link there is not a clear MAC-PHY relationship, but we do somehow need
to specify delays.

	Andrew

