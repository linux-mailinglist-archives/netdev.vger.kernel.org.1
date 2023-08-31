Return-Path: <netdev+bounces-31508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA8E78E765
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 09:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 144031C20627
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 07:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887216ADF;
	Thu, 31 Aug 2023 07:52:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721D01FCC
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 07:52:04 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868651A3
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 00:52:02 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1qbcSp-0007B2-OC; Thu, 31 Aug 2023 09:51:39 +0200
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1qbcSn-000504-7Z; Thu, 31 Aug 2023 09:51:37 +0200
Date: Thu, 31 Aug 2023 09:51:37 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Lukasz Majewski <lukma@denx.de>
Cc: Tristram.Ha@microchip.com, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
	Woojung Huh <woojung.huh@microchip.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Michael Walle <michael@walle.cc>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Oleksij Rempel <linux@rempel-privat.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net: phy: Provide Module 4 KSZ9477 errata
 (DS80000754C)
Message-ID: <20230831075137.GB17603@pengutronix.de>
References: <20230831072527.537839-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230831072527.537839-1-lukma@denx.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 31, 2023 at 09:25:27AM +0200, Lukasz Majewski wrote:
> The KSZ9477 errata points out (in 'Module 4') the link up/down problems
> when EEE (Energy Efficient Ethernet) is enabled in the device to which
> the KSZ9477 tries to auto negotiate.
> 
> The suggested workaround is to clear advertisement of EEE for PHYs in
> this chip driver.
> 
> To avoid regressions with other switch ICs the new MICREL_NO_EEE flag
> has been introduced.
> 
> Moreover, the in-register disablement of MMD_DEVICE_ID_EEE_ADV.MMD_EEE_ADV
> MMD register is removed, as this code is both; now executed too late
> (after previous rework of the PHY and DSA for KSZ switches) and not
> required as setting all members of eee_broken_modes bit field prevents
> the KSZ9477 from advertising EEE.
> 
> Fixes: 69d3b36ca045 ("net: dsa: microchip: enable EEE support") (for KSZ9477).
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
 
Tested-by: Oleksij Rempel <o.rempel@pengutronix.de>

Confirmed disabled EEE with oscilloscope.

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

