Return-Path: <netdev+bounces-297837-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NjHcJn/LKWrUdQMAu9opvQ
	(envelope-from <netdev+bounces-297837-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 22:39:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E547366CD92
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 22:39:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b="f72Xl6/l";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297837-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297837-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5067B30CCB4F
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 20:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2A947DD70;
	Wed, 10 Jun 2026 20:39:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA6E7DA66;
	Wed, 10 Jun 2026 20:39:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781123963; cv=none; b=acm/S2GSGaWxkN+c9TtVT6uJMk3Wg3HixvnGIKFxfLgbhXVeBNqFIN4QVhO4ZcNKVxYcmV7Ozk7yQ1pf/MkL02KPGSAb/QAxp4FWP6LjquYRArb/PIDUtupbB7+vzbwTHtMK7S6PyKQbyKFtuuVCwiSkV2SpVrfGrIOLcnPjlDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781123963; c=relaxed/simple;
	bh=1DaVFRtZrUGl9rPA68Kiv5B2qnc446EPNL3rTyf4hv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYkWGjLHqxncbiOrZp7cPHl2ZS62lJ8MU/WdHkfUopF6G2V18jvpwbXKM1h9nEf01bQrZ+HWxFiCoCnwHVN3voDEbzlbI68Oi5GITtDfEzOhcMxTrFhPi0WOF7+DGnG/0DRDthFLVsqsGYMDzWap/de9M0yEodzc/YSVWLbwPTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=f72Xl6/l; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AU64uaQHZcFSJ4Xtl6UtU7OVNwH3LkcB40Z3AcnH+bQ=; b=f72Xl6/l2UNtrQTxS1GwypweC7
	2RO0TIKXs2PtQ369AA2reUz3SIiUyJfrIMA1kOE29UCLyvePD/keT7oP887d2avvp+fqYP1iP8GrZ
	NtUmhFt/x5fwdH/nZc/E6RtlE4DLPeUSlL+cuUaihugtbTGZ/7UxwNODkO4qNnEFk8x4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wXPhg-007398-Ga; Wed, 10 Jun 2026 22:39:12 +0200
Date: Wed, 10 Jun 2026 22:39:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] net: phy: dp83869: Support 1000Base-X SFP
Message-ID: <6c4f54bf-383a-4ff8-8389-99592a8fcd16@lunn.ch>
References: <20251110-sfp-1000basex-v2-0-dd5e8c1f5652@bootlin.com>
 <20251110-sfp-1000basex-v2-3-dd5e8c1f5652@bootlin.com>
 <924891c9-fd34-4e7a-bca9-007c80bc327f@lunn.ch>
 <a5OAN5n1TlqpbApOWnEEjQ@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5OAN5n1TlqpbApOWnEEjQ@bootlin.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-297837-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:romain.gantois@bootlin.com,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:maxime.chevallier@bootlin.com,m:thomas.petazzoni@bootlin.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lunn.ch:dkim,lunn.ch:mid,lunn.ch:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E547366CD92

> > Why is it safe to call dp83869_configure_mode() without the lock, but
> > dp83869_config_aneg() does need the lock? And what are the
> > consequences of not being able to get the lock and so aneg is not
> > configured?
> > 
> > Some comments would be good here.
> 
> Since phy_port has been merged, I'm currently preparing a v3 for this but I'm 
> in need of some general guidance regarding this `mutex_trylock(&phydev->lock)` 
> which has (rightfully) sparked some concerns.
> 
> What data is supposed to be protected by the `phydev->lock` mutex? Is it every 
> field of the phydev struct + standard hardware registers + vendor registers? Or 
> only a subset of these?

The phydev lock should prevent two phylib operations happening at
once. It also protects the members of phylib which are accessed during
the callback when the link changes.

Phylib operations should include access to hwmon sensors and LEDs, if
there is a danger such access could upset things. Since LEDs come
through the phylib core, locking is done for that in the core. But
hwmon sensors are not part of the core.

Since PHYs are pretty simple, and MDIO operations take a lot of time,
it is better to hold the lock than not hold the lock.

	Andrew

