Return-Path: <netdev+bounces-275585-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNB0NUaq02lukAcAu9opvQ
	(envelope-from <netdev+bounces-275585-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 14:42:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8AC3A35E2
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 14:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DDB13011F06
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 12:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E935734BA42;
	Mon,  6 Apr 2026 12:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GYDQhlhR"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E0434B19A;
	Mon,  6 Apr 2026 12:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775479360; cv=none; b=HENTrZs8wBS5MDAF1v47G/dD9FduMHAZMLlqGCN1REcS/Gvc5CIFIRdVLxkIgJMfK6PRTGAVDlgPpPh1CRS+BwS1CcnWiiteaqOWJgPs3oH5SIiJcxxREwA200BCapHqxUB6TWRbuD1TjqSDiHHxEqaWy6z+q35m1C8sxzZqMDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775479360; c=relaxed/simple;
	bh=Sv0A+sHdJ2RG8qbrDbw8lVNY4v8YEFz1J6FoU7pUpSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/GYFnPpa0VO3V0QzxcyzlLf0drxOygfKZ9+l+FWLo3+ACc/JG8FJKZFS9jUswI3j9YVpap6pParZ7lGOZIkdFdUFv6+vdDGyGWuHPDxW0UbGzEkY8t6lyxHYeZYhBr5ca4YZ2IO1QK+BRVEln0dD9RdRc7k7YOjIQmv5iovDPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GYDQhlhR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Pl89xt0XO0MVD2bqFFaXnKndIOOiqwaplxwOyuzmR+0=; b=GYDQhlhRXMtHU6pEEWhAabOk7O
	tQRg/t6VCr9oMOICTIFK0m6RC3M0inSbqgDVZ66rOCkxj5n4s30nPnl2W1MYjN6OHH34E2RUPAu2v
	sMmqKPIm9BVPQTXNIxJt2msZlgytIy1sMl2JdgS51xsqgGWn/xaR3JymsP9ZJ6Zz2ZSE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w9jHh-00EzCe-Qq; Mon, 06 Apr 2026 14:42:29 +0200
Date: Mon, 6 Apr 2026 14:42:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Carlo Szelinsky <github@szelinsky.de>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] net: mdio: treat PSE EPROBE_DEFER as
 non-fatal during PHY registration
Message-ID: <3597433c-ce26-43c6-9a5f-e942a3db5340@lunn.ch>
References: <6185f9d8-dabe-4190-b020-711e3a046e64@lunn.ch>
 <20260405185730.3937952-1-github@szelinsky.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260405185730.3937952-1-github@szelinsky.de>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275585-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[bootlin.com,pengutronix.de,lunn.ch,gmail.com,armlinux.org.uk,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Queue-Id: 5A8AC3A35E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 05, 2026 at 08:57:30PM +0200, Carlo Szelinsky wrote:
> Hi Andrew,
> 
> So I went and looked at whether we can just let EPROBE_DEFER do its
> thing here, like you suggested.
> 
> >From what I can tell, the issue is where it happens.
> fwnode_mdiobus_register_phy() gets called during the MDIO bus scan in
> __of_mdiobus_parse_phys(), and if any PHY returns -EPROBE_DEFER there,
> the whole scan bails out - none of the PHYs on that bus get registered.
> So you'd lose all networking on that bus just because one PHY's PSE
> controller isn't ready yet.

Something does not sounds correct here. The MDIO bus, and the devices
on the bus should have different life cycles.

If the MDIO bus itself is missing resources it needs, it can return
EPROBE_DEFFER. A typical example of this would be the MDIO bus reset,
which applies to all devices on the bus. If that GPIO is missing, the
probe of the MDIO bus will unwind.

I would expect PHYs on the bus to be just devices in the device
model. They can return EPROBE_DEFER, and the driver core will probe
them again later. This could be a per PHY reset signal, reset
controller, etc, or the PSE. If such a resource is missing, just the
PHY should fail probing, not the whole MDIO bus.

> I also dug into the timing question you raised. Correct me if I'm
> wrong, but from what I see the deferred probe timeout is 10s and
> regulator_late_cleanup fires at 30s, so the ordering would actually
> work out - the consumer would get to claim the regulator before
> cleanup kills it. It's more the bus level collateral damage that
> seemed like the real problem to me.

Your patch 0/X says:

> When a PSE controller driver is built as a module, it may not be
> probed yet when PHYs are registered on the MDIO bus. This causes
> of_pse_control_get() to return -EPROBE_DEFER, destroying the PHY
> device.  Later, regulator_late_cleanup disables the unclaimed PSE
> regulators, permanently killing PoE.

How are we getting to time t=30 without the PSE probing?

If the PSE controller is a module, and missing from the file system,
so cannot be loaded, then turning off the regulators actually seems
like a good safety policy. But if the module is there, but never gets
loaded, it sounds like we have a different sort of problem, some
cyclic dependency we need to break?

	Andrew

