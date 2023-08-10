Return-Path: <netdev+bounces-26255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DD7777577
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 12:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F03B282036
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 10:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD161ED30;
	Thu, 10 Aug 2023 10:10:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20C91E51F
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 10:10:08 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827EF83
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 03:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KJsaxTmwOTghnKuj4qhc4itefHqvWcqVj5YnmLVV9fc=; b=ghLfaIOVzI9dD6wWDAwgvy9yzr
	xm7M52Z2cpWR9Gb2jkYifjTDAi+pYklZC+jO3/3n4acT4K/G8yEIIhG4BHYuWeEqWrgLMqXXP/z4Z
	3RHvOdxjuLf6PioIjzPzElNDKpKZoN/q91KjWAXmnoA2UIPFJH5huQurOge0/wZoMg0TCUvE44Wwv
	qN77Ne8OQWalpGysLA4andHxJ1Fa5ZqUyvjThQKy+lA0tarRRtuzVLcoaXjvDvjybLOfDt+PRivjV
	dOvLW/oXomUaLRn6HxpjyZlcUvZYNiaDlJWJhh1TSShKp8wGR2OBye/nt+EuVkLxDIfQ/Z+vgdwHW
	aa4pWmWw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45274)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qU2cD-0003nJ-0d;
	Thu, 10 Aug 2023 11:10:01 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qU2cC-0001ge-A0; Thu, 10 Aug 2023 11:10:00 +0100
Date: Thu, 10 Aug 2023 11:10:00 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Marek Vasut <marex@denx.de>, Andrew Lunn <andrew@lunn.ch>,
	Wei Fang <wei.fang@nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Oleksij Rempel <linux@rempel-privat.de>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] net: phy: at803x: Improve hibernation support on start up
Message-ID: <ZNS3ePZssRCveaDd@shell.armlinux.org.uk>
References: <AM5PR04MB3139793206F9101A552FADA0880DA@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <45b1ee70-8330-0b18-2de1-c94ddd35d817@denx.de>
 <AM5PR04MB31392C770BA3101BDFBA80318812A@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <20230809043626.GG5736@pengutronix.de>
 <AM5PR04MB3139D8C0EBC9D2DFB0C778348812A@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <d8990f01-f6c8-4fec-b8b8-3d9fe82af51b@lunn.ch>
 <76131561-18d7-945e-cb52-3c96ed208638@denx.de>
 <18601814-68f6-4597-9d88-a1b4b69ad34f@lunn.ch>
 <36ee0fa9-040a-8f7e-0447-eb3704ab8e11@denx.de>
 <20230810043242.GB13300@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810043242.GB13300@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 10, 2023 at 06:32:42AM +0200, Oleksij Rempel wrote:
> On Thu, Aug 10, 2023 at 02:49:55AM +0200, Marek Vasut wrote:
> > On 8/10/23 00:06, Andrew Lunn wrote:
> > > On Wed, Aug 09, 2023 at 11:34:19PM +0200, Marek Vasut wrote:
> > > > On 8/9/23 15:40, Andrew Lunn wrote:
> > > > > > > Hm.. how about officially defining this PHY as the clock provider and disable
> > > > > > > PHY automatic hibernation as long as clock is acquired?
> > > > > > > 
> > > > > > Sorry, I don't know much about the clock provider/consumer, but I think there
> > > > > > will be more changes if we use clock provider/consume mechanism.
> > > > > 
> > > > > Less changes is not always best. What happens when a different PHY is
> > > > > used?
> > > > 
> > > > Then the system wouldn't be affected by this AR803x specific behavior.
> > > 
> > > Do you know it really is specific to the AR803x? Turning the clock off
> > > seams a reasonable thing to do when saving power, or when there is no
> > > link partner.
> > 
> > This hibernation behavior seem specific to this PHY, I haven't seen it on
> > another PHY connected to the EQoS so far.
> 
> Hm.. if I see it correctly I have right now kind of similar issues with
> Microchip KSZ9893 switch attached to EQoS. The switch is clock
> provider and I need to make sure that switch has CPU port enabled before
> probing the ethernet controller.

... and Cadence macb.

So, this is a thing, and we need to be able to cater for it.

Can we agree that:

(a) some ethernet MAC controllers need the RGMII receive clock to
function.

(b) IEEE 802.3 permits clocks to be disabled when entering EEE low
power state, and there is a defined control bit to allow this to
happen - so IEEE 802.3 _recognises_ that some MAC controllers need
this clock whereas others do not.

Therefore:

(c) Given that IEEE 802.3 appears to recognise this, we should add
some sort of control to phylib so that MACs can tell phylib that they
require the receive clock to always be present.

(d) We need to ensure that PHY drivers respect that bit and program
the hardware appropriately to ensure that where a MAC always needs
a receive clock, it is maintained.

(e) MACs that always need the receive clock enabled need to indicate
to phylib/phylink that this is the case.

My suggestion is to use a bit on the PHY device dev_flags (bit 30)
for this.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

