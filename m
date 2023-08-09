Return-Path: <netdev+bounces-26103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D7C776CB1
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 01:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D814C1C213CD
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 23:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7E41E506;
	Wed,  9 Aug 2023 23:15:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605921D2F0
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 23:15:22 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A44D1
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 16:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nhsyjxyXm6D1NvUK241dk4Pp+GVuES5XK5ThLEC8J2c=; b=fpc2Om5UFs8TL88bsh6qE2uNau
	T/ZbEVY7PQMVariiPLNymlQCecdH3GgqNFljNJQKUMlstWSwfnChinNtpRCMvRhyf2Bv2t7rWO57/
	q7sYWqLJDLehrs+P4robwyON2CdywCuwPRQNyNxljqyKDZiO3cs38HWHpdQIPSiHQAjLw7nFQ1AOk
	bYWkzuaAOwdkhDYwc7EQ5JQM9vGrsVEKaP9kvmKQxjQxu7ImGwcghFHzJgeIVL8/qkANgYTzzgYS+
	qEWyjR5fQ/ghUy/bFV+3wXlCH2bLVlYV4CkoKGbSQcdGWM9KQjDldWn+2/4d3qbavT2Wed4t4HWJv
	srlAY6+w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45046)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qTsOa-00038L-1N;
	Thu, 10 Aug 2023 00:15:16 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qTsOY-0001AD-Pu; Thu, 10 Aug 2023 00:15:14 +0100
Date: Thu, 10 Aug 2023 00:15:14 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Marek Vasut <marex@denx.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Wei Fang <wei.fang@nxp.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Oleksij Rempel <linux@rempel-privat.de>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] net: phy: at803x: Improve hibernation support on start up
Message-ID: <ZNQeAl9KYme8iItv@shell.armlinux.org.uk>
References: <20230804175842.209537-1-marex@denx.de>
 <AM5PR04MB3139793206F9101A552FADA0880DA@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <45b1ee70-8330-0b18-2de1-c94ddd35d817@denx.de>
 <AM5PR04MB31392C770BA3101BDFBA80318812A@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <20230809043626.GG5736@pengutronix.de>
 <AM5PR04MB3139D8C0EBC9D2DFB0C778348812A@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <d8990f01-f6c8-4fec-b8b8-3d9fe82af51b@lunn.ch>
 <76131561-18d7-945e-cb52-3c96ed208638@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76131561-18d7-945e-cb52-3c96ed208638@denx.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 09, 2023 at 11:34:19PM +0200, Marek Vasut wrote:
> On 8/9/23 15:40, Andrew Lunn wrote:
> > > > Hm.. how about officially defining this PHY as the clock provider and disable
> > > > PHY automatic hibernation as long as clock is acquired?
> > > > 
> > > Sorry, I don't know much about the clock provider/consumer, but I think there
> > > will be more changes if we use clock provider/consume mechanism.
> > 
> > Less changes is not always best. What happens when a different PHY is
> > used?
> 
> Then the system wouldn't be affected by this AR803x specific behavior.

I don't think it is AR803x specific behaviour. I think it is an
interesting stmmac behaviour, where it requires the clock from
the PHY in order to do even the most trivial things (like reset
itself.) That is a very interesting design decision.

how does stmmac hardware complete a power-on reset if it needs
the external clock from a PHY that itself might be in the process
of powering itself up and establishing its clocks...

There have been *hacks* to phylink requested over the years to
work around this peculiar behaviour by stmmac - and it seems that
it's not common behaviour.

This kind of thing might affect Cadence's macb driver as well, but
rather than it being a clock from the ethernet PHY, it seems to be
from the serdes PHY built in to the SoC - if I understand what's
reported in the proposed patch commit log (which I don't fully.)

In the case of stmmac, I don't think it's fair to blame the AR803x.
It's a hardware integration issue - the AR803x implementation which
works fine elsewhere has a problem with the stmmac implementation,
because design decisions made in both implementations end up being
incompatible with each other.

However, pair them with different implementations, and they're fine.

Given that stmmac requires a clock from the PHY, I'm of the opinion
that we need to have a way to tell phylib that "hey, this MAC must
always have a receive clock from the PHY, please arrange for that
to happen". AR803x needs to check that and arrange for the receive
clock to always be output. phylib can also use that to ensure that
when EEE mode is active in the PHY, clock-stop support is disabled...
and that's actually a key part to getting EEE properly implemented.

Clearly, the IEEE 802.3 folk catered for this issue when specifying
EEE, where some MACs must always be fed a receive clock, and so I
think phylib in Linux needs to recognise that this is A Thing that
it should allow MACs to specify.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

