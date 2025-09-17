Return-Path: <netdev+bounces-224028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02165B7F1AA
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 15:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1572B32600A
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 13:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C9D33B48A;
	Wed, 17 Sep 2025 13:00:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A2C33B47C
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 13:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758114031; cv=none; b=HT6Ukxf4GXq/t0DKFv73qbdlugOV1jXA+oLtSqKESNDmQA4+LkmIKw2tH2rjbfhf6QaKxd93S83usXwtQSOo6TKE82qfGA3AZvOP4wxhuSo3HF+AD0T+bodtkw6LWAZ1uH51++JefkQAsz2NhYnMIumaZcoc4FwAuXv2FLKCGWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758114031; c=relaxed/simple;
	bh=t5wDfKI8ueIOw6uWaPpRM/5Of4iVvIdpItVCXVEyTIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJ7ayp4o95m7JaOHlEE7CrYs5J2t+B+T4faox6fe9jjDnLe8W5V/1Ru1RA2GKAuC3LIy6tTUTTdtWcR84GRbAr8chLJpLUxIyM8WHMQG5Hp8RyyJu5rPyzyH6SDOtdxmKT/9jj/xrMvSUxQJulxd0Ckc03bu1ZnV5za2BeJMtRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uyrli-0007aq-BS; Wed, 17 Sep 2025 15:00:18 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uyrlh-001lSo-05;
	Wed, 17 Sep 2025 15:00:17 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uyrlg-00Dhy1-2x;
	Wed, 17 Sep 2025 15:00:16 +0200
Date: Wed, 17 Sep 2025 15:00:16 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	Andre Edich <andre.edich@microchip.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH net v4 0/3] net: phy: smsc: use IRQ + relaxed polling to
 fix missed link-up
Message-ID: <aMqw4LuoTTRspqfA@pengutronix.de>
References: <20250714095240.2807202-1-o.rempel@pengutronix.de>
 <657997b5-1c20-4008-8b70-dc7a7f56c352@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <657997b5-1c20-4008-8b70-dc7a7f56c352@lunn.ch>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Andrew,

On Fri, Jul 18, 2025 at 03:58:56PM +0200, Andrew Lunn wrote:
> On Mon, Jul 14, 2025 at 11:52:37AM +0200, Oleksij Rempel wrote:
> > This series makes the SMSC LAN8700 (as used in LAN9512 and similar USB
> > adapters) reliable again in configurations where it is forced to 10 Mb/s
> > and the link partner still advertises autonegotiation.
> 
> I've seen a comment from another Maintainer that thinks this is rather
> hackish. I tend to agree, you are adding complexity to the core to
> handle one broken PHY, and a corner case in that PHY. It would be
> better to hide as much of this in the PHY driver.
> 
> I'm wondering if there is a much simpler solution, which does not need
> the core changing. Have the driver dynamically flip between interrupts
> and polling, depending on the link mode.
> 
> Start up in the usual way. If the platform supports interrupts, let
> the core get the interrupt, install the handler and use
> interrupts. Otherwise do polling.
> 
> If .config_aneg() puts the PHY into the broken state, forced to 10
> Mb/s, and interrupts are used, set phydev->irq = PHY_POLL, and call
> phy_trigger_machine() to kick off polling.
> 
> If .config_aneg() is called to take it out of the broken state,
> restore phydev->irq. An additional poll up to one second later should
> not cause any issues.
> 
> I don't think this needs any core code changes.
> 
> Maybe there is an issue with phy_free_interrupt() being called while
> irq has been set to polling? You might be able to use the
> phy_driver.remove() to handle that?

I tried to go this way, but it feels even dirtier. The driver would need
to overwrite phydev->irq and phydev->interrupts, and also care about
proper interrupt (re)configuration. On disconnect, phy_disconnect()
unconditionally calls phy_free_interrupt() if phy_interrupt_is_valid(),
but phy_driver.remove() is invoked too late. This leads to warnings
like:
removing non-empty directory 'irq/210', leaking at least 'usb-001:003:01'

So the driver ends up fighting with core assumptions about IRQ lifetime.

How about a minimal change instead: conditionally call
phy_queue_state_machine() from lan87xx_config_aneg()? That would trigger
a poll in the broken mode without touching phydev->irq or core teardown
paths. Seems less intrusive than rewriting IRQ handling.

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

