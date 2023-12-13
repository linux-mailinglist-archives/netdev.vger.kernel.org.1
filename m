Return-Path: <netdev+bounces-57061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A978811DE2
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 20:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32A251F213CF
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 19:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65F16168F;
	Wed, 13 Dec 2023 19:01:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED13E8;
	Wed, 13 Dec 2023 11:01:55 -0800 (PST)
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rDUUC-0004pP-1q;
	Wed, 13 Dec 2023 19:01:37 +0000
Date: Wed, 13 Dec 2023 19:01:29 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: skip LED triggers on PHYs on SFP modules
Message-ID: <ZXn_id6-XWYr2Seo@makrotopia.org>
References: <102a9dce38bdf00215735d04cd4704458273ad9c.1702339354.git.daniel@makrotopia.org>
 <20231212153512.67a7a35b@device.home>
 <ec909d14-e571-4a50-926d-fbef4f4f9e0a@lunn.ch>
 <ZXnNYJer0JrJxOsl@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXnNYJer0JrJxOsl@shell.armlinux.org.uk>

On Wed, Dec 13, 2023 at 03:27:28PM +0000, Russell King (Oracle) wrote:
> On Wed, Dec 13, 2023 at 10:08:25AM +0100, Andrew Lunn wrote:
> > On Tue, Dec 12, 2023 at 03:35:12PM +0100, Maxime Chevallier wrote:
> > > Hi Daniel
> > > 
> > > On Tue, 12 Dec 2023 00:05:35 +0000
> > > Daniel Golle <daniel@makrotopia.org> wrote:
> > > 
> > > > Calling led_trigger_register() when attaching a PHY located on an SFP
> > > > module potentially (and practically) leads into a deadlock.
> > > > Fix this by not calling led_trigger_register() for PHYs localted on SFP
> > > > modules as such modules actually never got any LEDs.
> > > 
> > > While I don't have a fix for this issue, I think your justification
> > > isn't good. This isn't about having LEDs on the module or not, but
> > > rather the PHY triggering LED events for LEDS that can be located
> > > somewhere else on the system (like the front pannel of a switch).
> > 
> > SFP LEDs are very unlikely to be on the front panel, since there is no
> > such pins on the SFP cage.
> > 
> > Russell, in your collection of SFPs do you have any with LEDs?
> 
> No, and we should _not_ mess around with the "LED" configuration on
> PHYs on SFPs. It's possible that the LED output is wired to the LOS
> pin on the module, and messing around with the configuration of that
> would be asking for trouble.
> 
> In any case, I thought we didn't drive the LED configuration on PHYs
> where the LED configuration isn't described by firmware - and as the
> PHY on SFP modules would never be described by firmware, hooking
> such a PHY up to the LED framework sounds like a waste of resources
> to me.

This was exactly my line of thought when posting the patch, however,
Maxime correctly pointed out that the issue with locking and also
what the patch prevents is registration of LED *triggers* rather than
the PHY-controlled LEDs themselves. And having the triggers available
is desirable even beyond the hardware offloaded case (which is probably
the aspect we both were dealing with the most recently and hence had in
mind). It is common to control another system SoC GPIO driven LED(s)
representing the link status and rx/tx traffic, for example.

So better we get to the core of it and fix the locking issue
(for example by registering LED trigger asynchronously using
delayed_work)...

