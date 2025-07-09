Return-Path: <netdev+bounces-205465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A69F3AFEDA1
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 17:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31D134802A7
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 15:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4F82E7622;
	Wed,  9 Jul 2025 15:23:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5778E2E7195
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 15:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752074617; cv=none; b=NO/f7VQgBGJUfZYBrzL8obbbqZ4LSXPKzW6X3wQKgBex32dQrQ2QOKqe+2W+mTI5L89vH5Z29c7SGk23kv9LZCcENRWTsD4qWRDjUVsKb9wAbj9Lrp6ox/t0dGmAGO8hl9s1omtkaQkaupjBBIO6DoH9p6aOXuiwey0UaCdME9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752074617; c=relaxed/simple;
	bh=jA466shT9OcyRSzYxq4e6vbv5RenQ1Yaspaa8D0m1kI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=scXJXTBIrrM9neuGJwIG/ly4M/C0aA+nKaIsKzP+ydvGURloBa9Y1TuDGOov2f0TisTDjqxviBRG4jwUBaK/7x4xyXgj4DcTTnXQvRf+eBogtdPtW8B36ZmKLy8if9BaHD8tOZqA18iLNvhXemCGVMZut0/FE2PbVDFJVoA+N9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uZWdq-0000kp-8l; Wed, 09 Jul 2025 17:23:26 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uZWdo-007beD-0I;
	Wed, 09 Jul 2025 17:23:24 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uZWdn-009ymh-39;
	Wed, 09 Jul 2025 17:23:23 +0200
Date: Wed, 9 Jul 2025 17:23:23 +0200
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
Subject: Re: [PATCH net v2 2/3] net: phy: allow drivers to disable polling
 via get_next_update_time()
Message-ID: <aG6Ja_Y9JNKkEon6@pengutronix.de>
References: <20250709104210.3807203-1-o.rempel@pengutronix.de>
 <20250709104210.3807203-3-o.rempel@pengutronix.de>
 <e0b00f28-051e-4af6-afcb-7cdb5dc76549@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e0b00f28-051e-4af6-afcb-7cdb5dc76549@lunn.ch>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Wed, Jul 09, 2025 at 04:10:48PM +0200, Andrew Lunn wrote:
> >  	/* Only re-schedule a PHY state machine change if we are polling the
> > -	 * PHY, if PHY_MAC_INTERRUPT is set, then we will be moving
> > -	 * between states from phy_mac_interrupt().
> > +	 * PHY. If PHY_MAC_INTERRUPT is set or get_next_update_time() returns
> > +	 * PHY_STATE_IRQ, then we rely on interrupts for state changes.
> >  	 *
> >  	 * In state PHY_HALTED the PHY gets suspended, so rescheduling the
> >  	 * state machine would be pointless and possibly error prone when
> >  	 * called from phy_disconnect() synchronously.
> >  	 */
> > -	if (phy_polling_mode(phydev) && phy_is_started(phydev))
> > -		phy_queue_state_machine(phydev,
> > -					phy_get_next_update_time(phydev));
> > +	if (phy_polling_mode(phydev) && phy_is_started(phydev)) {
> > +		unsigned int next_time = phy_get_next_update_time(phydev);
> > +
> > +		/* Drivers returning PHY_STATE_IRQ opt out of polling.
> > +		 * Use IRQ-only mode by not re-queuing the state machine.
> > +		 */
> > +		if (next_time != PHY_STATE_IRQ)
> > +			phy_queue_state_machine(phydev, next_time);
> > +	}
> 
> How does this interact with update_stats()?
> 
> phy_polling_mode() returns true because the update_stats() op is
> implemented. phy_get_next_update_time() returns PHY_STATE_IRQ, because
> the PHY is in a state where interrupts works, and then the statistics
> overflow.
> 
> It seems like this code needs to be somehow made part of
> phy_polling_mode(), so that it has the full picture of why polling is
> being used.

Ah, good point! I forgot about it.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

