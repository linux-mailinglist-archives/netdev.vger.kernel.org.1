Return-Path: <netdev+bounces-25685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EF577528B
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 08:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B797F281A60
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 06:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7E7468B;
	Wed,  9 Aug 2023 06:08:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECA320EC
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 06:08:48 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8986E61
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 23:08:46 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1qTcN5-0004LE-4Z; Wed, 09 Aug 2023 08:08:39 +0200
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1qTcN2-00083I-Ab; Wed, 09 Aug 2023 08:08:36 +0200
Date: Wed, 9 Aug 2023 08:08:36 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Wei Fang <wei.fang@nxp.com>
Cc: Marek Vasut <marex@denx.de>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, kernel@pengutronix.de,
	linux-clk@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH] net: phy: at803x: Improve hibernation support on start up
Message-ID: <20230809060836.GA13300@pengutronix.de>
References: <20230804175842.209537-1-marex@denx.de>
 <AM5PR04MB3139793206F9101A552FADA0880DA@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <45b1ee70-8330-0b18-2de1-c94ddd35d817@denx.de>
 <AM5PR04MB31392C770BA3101BDFBA80318812A@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <20230809043626.GG5736@pengutronix.de>
 <AM5PR04MB3139D8C0EBC9D2DFB0C778348812A@AM5PR04MB3139.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AM5PR04MB3139D8C0EBC9D2DFB0C778348812A@AM5PR04MB3139.eurprd04.prod.outlook.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

CCing clk folks in the loop.

On Wed, Aug 09, 2023 at 05:37:45AM +0000, Wei Fang wrote:
...
> > Hm.. how about officially defining this PHY as the clock provider and disable
> > PHY automatic hibernation as long as clock is acquired?
> > 
> Sorry, I don't know much about the clock provider/consumer, but I think there
> will be more changes if we use clock provider/consume mechanism.

Yes, more changes will be needed.

> Furthermore,
> we would expect the hibernation mode is enabled when the ethernet interface
> is brought up but the cable is not plugged, that is to say, we only need the PHY to
> provide the clock for a while to make the MAC reset successfully. 

Means, if external clock is not provided, MAC is not fully functional.
Correct?

What kind of MAC operation will fail in this case?
For example, if stmmac_open() fails without external clock, will
stmmac_release() work properly? Will we be able to do any configuration
on an interface which is opened, but without active link and hibernated
clock? How about self tests?

> Therefore, I think
> the current approach is more simple and effective, and it takes full advantage of the
> characteristics of the hardware (The PHY will continue to provide the clock about
> 10 seconds after hibernation mode is enabled when the cable is not plugged and
> automatically disable the clock after 10 seconds, so the 10 seconds is enough for
> the MAC to reset successfully).

If multiple independent operations are synchronized based on the
assumption that 10 seconds should be enough, bad thing happens.

If fully functional external clock provider is need to initialize the
MAC, just disabling this clock on already initialized HW without doing
proper re-initialization sequence is usually bad idea. HW may get some
glitch which will make troubleshooting a pain.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

