Return-Path: <netdev+bounces-57569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 103808136F1
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 17:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAE2B1F210FB
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 16:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C250961696;
	Thu, 14 Dec 2023 16:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="njbDHnBX"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB70013A;
	Thu, 14 Dec 2023 08:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=M7C3YssKmJsxGBEluHaWA69lXkTVL4pmL4B1VN2PfJM=; b=njbDHnBXo/4CZ5TW/9QHjgP+op
	O1DvEWpirBBAprMPXTd3TcCJmpQnLPbdj15PY9aUhGLioRC4nQq48hNirJW/InQzbdarjXzlmkpCX
	rPpUa4pNqBQgKMIY5OdmE5Mymzvzt4YoaHV9lfINAS/fQQYZgdijYXqVCjm3Atpjz4FP24V5C1n2l
	FebFjYxAAqodAWtAZFIl1fvGuz+qu2H8+hDMFqrRa6EUUHZNRIazfxTEF+qLF2iV3PxjG+0gfIdHa
	4UHlE7Igpmk9pvZeTKZgZ08MwBLsdeeT7yXDOCHASmq6O3wgL9flf2CZpt/ptkHmJ88GQTwqy5RGJ
	mnz7CgXA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48364)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rDowR-0001hc-16;
	Thu, 14 Dec 2023 16:52:07 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rDowR-0002hF-MG; Thu, 14 Dec 2023 16:52:07 +0000
Date: Thu, 14 Dec 2023 16:52:07 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: skip LED triggers on PHYs on SFP modules
Message-ID: <ZXsyt+msigtNiLN9@shell.armlinux.org.uk>
References: <102a9dce38bdf00215735d04cd4704458273ad9c.1702339354.git.daniel@makrotopia.org>
 <20231212153512.67a7a35b@device.home>
 <ec909d14-e571-4a50-926d-fbef4f4f9e0a@lunn.ch>
 <ZXnNYJer0JrJxOsl@shell.armlinux.org.uk>
 <ZXn_id6-XWYr2Seo@makrotopia.org>
 <6dd8d8b62d6db979d6c2197a4091ebc768e6610a.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6dd8d8b62d6db979d6c2197a4091ebc768e6610a.camel@redhat.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Dec 14, 2023 at 10:48:10AM +0100, Paolo Abeni wrote:
> On Wed, 2023-12-13 at 19:01 +0000, Daniel Golle wrote:
> > On Wed, Dec 13, 2023 at 03:27:28PM +0000, Russell King (Oracle) wrote:
> > > On Wed, Dec 13, 2023 at 10:08:25AM +0100, Andrew Lunn wrote:
> > > > On Tue, Dec 12, 2023 at 03:35:12PM +0100, Maxime Chevallier wrote:
> > > > > Hi Daniel
> > > > > 
> > > > > On Tue, 12 Dec 2023 00:05:35 +0000
> > > > > Daniel Golle <daniel@makrotopia.org> wrote:
> > > > > 
> > > > > > Calling led_trigger_register() when attaching a PHY located on an SFP
> > > > > > module potentially (and practically) leads into a deadlock.
> > > > > > Fix this by not calling led_trigger_register() for PHYs localted on SFP
> > > > > > modules as such modules actually never got any LEDs.
> > > > > 
> > > > > While I don't have a fix for this issue, I think your justification
> > > > > isn't good. This isn't about having LEDs on the module or not, but
> > > > > rather the PHY triggering LED events for LEDS that can be located
> > > > > somewhere else on the system (like the front pannel of a switch).
> > > > 
> > > > SFP LEDs are very unlikely to be on the front panel, since there is no
> > > > such pins on the SFP cage.
> > > > 
> > > > Russell, in your collection of SFPs do you have any with LEDs?
> > > 
> > > No, and we should _not_ mess around with the "LED" configuration on
> > > PHYs on SFPs. It's possible that the LED output is wired to the LOS
> > > pin on the module, and messing around with the configuration of that
> > > would be asking for trouble.
> > > 
> > > In any case, I thought we didn't drive the LED configuration on PHYs
> > > where the LED configuration isn't described by firmware - and as the
> > > PHY on SFP modules would never be described by firmware, hooking
> > > such a PHY up to the LED framework sounds like a waste of resources
> > > to me.
> > 
> > This was exactly my line of thought when posting the patch, however,
> > Maxime correctly pointed out that the issue with locking and also
> > what the patch prevents is registration of LED *triggers* rather than
> > the PHY-controlled LEDs themselves. And having the triggers available
> > is desirable even beyond the hardware offloaded case (which is probably
> > the aspect we both were dealing with the most recently and hence had in
> > mind). It is common to control another system SoC GPIO driven LED(s)
> > representing the link status and rx/tx traffic, for example.
> > 
> > So better we get to the core of it and fix the locking issue
> > (for example by registering LED trigger asynchronously using
> > delayed_work)...
> 
> I understand you are looking for a different solution, so let me mark
> this patch accordingly.
> 
> --
> pw-bot: cr

I disagree with that - analysing the locking and coming up with a fix
is likely going to be a lengthy affair, meanwhile the mainline kernel
will deadlock on this. This patch prevents that deadlock at the
expense of removing the LED triggers for the PHY-on-SFP which I don't
think is a big deal considering the age of the PHY-based LED triggers.

So I personally would prefer this patch to be merged while a
different solution (that we have little idea at this point what it
would look like) is sought.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

