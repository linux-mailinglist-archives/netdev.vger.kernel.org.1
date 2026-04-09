Return-Path: <netdev+bounces-276975-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IO6nOhSc12kUQQgAu9opvQ
	(envelope-from <netdev+bounces-276975-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 14:31:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E97D23CA70E
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 14:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0DD343005168
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 12:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8424F1E4AF;
	Thu,  9 Apr 2026 12:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2PCN4+3s"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6951423536B;
	Thu,  9 Apr 2026 12:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775737869; cv=none; b=O+qs1BYI2dPrZtkcVAEwdR48VwDZgWWWXa3d/OGdAS4Mb+rsGQhBbnc8pbE7E/8LJnJ7TbU2CwYXdHdDnGGYnONqj3D7xSpJXtShEOCQd/6MwhthKbjJyYOMMyHT+TdQb+YdIcZzPt8iyUnR7Yt6Wc5q2pmWU1sYPYcaE0L/7UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775737869; c=relaxed/simple;
	bh=9+PIWb+r/XJyHvD5AB7ksCJ7F5pmW4NtlYTw1Mx7NYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bm/0cnEJ8QEISY5Z3LSofZ/Rb0HU4UYawlGjQyj6md8g/A2T6v5vG4VCKc0YHxobcsYsXyRe1dke8vYVBM6Esgf27C+JQg6CShG0OIJqIq3GQriXOTnG06HWa3+Ot7OHnApQP/NhROYE9hB5Ny/mcs9hHjyznTHvoQe6pLtpAyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2PCN4+3s; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mykLelm6GbQK5MWiG89USsab2u+4YwgChbh1/WFRpJU=; b=2PCN4+3smvSEmqqHonyESL2UG3
	iLXQedHlx1HM0fotVCFla1ca+rOTBEghCLRmAAdb2p7r1ARlosC8iggDWFit5HcyxYwikM0fFdUrR
	hDMZE3cdKQyu3td1EbrfqR7VoDzi11uaPqe6fWbafvow4z4Z263xp8MVv2oXPZFupJ5Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wAoX7-00FQik-LR; Thu, 09 Apr 2026 14:30:53 +0200
Date: Thu, 9 Apr 2026 14:30:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Carlo Szelinsky <github@szelinsky.de>
Cc: o.rempel@pengutronix.de, kory.maincent@bootlin.com,
	andrew+netdev@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] net: mdio: treat PSE EPROBE_DEFER as
 non-fatal during PHY registration
Message-ID: <841e0a96-5e5c-4225-a426-24726163699f@lunn.ch>
References: <8e12f0ac-be0d-4664-a533-df3bd1efb34a@lunn.ch>
 <20260408210711.439068-1-github@szelinsky.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408210711.439068-1-github@szelinsky.de>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276975-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[pengutronix.de,bootlin.com,lunn.ch,gmail.com,armlinux.org.uk,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Queue-Id: E97D23CA70E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 11:07:11PM +0200, Carlo Szelinsky wrote:
> So I went ahead and tested the phy_probe() approach on my setup (RTL930x
> DSA switch with an I2C Hasivo HS104 PSE controller as module).
> 
> PoE itself works fine, but phydev->psec never gets set - ethtool just
> says "No PSE is attached" on all ports.
> 
> Took me a while to figure out what's going on. The problem is how DSA
> handles PHYs: when phy_probe() returns -EPROBE_DEFER because the PSE
> controller hasn't probed yet, the PHY device is registered but sits
> there unprobed. Then the DSA switch comes along, sets up its ports, and
> phy_attach_direct() force-binds the generic PHY driver with
> device_bind_driver(). Now the device already has a driver, so when the
> deferred probe retry kicks in it just skips it. phy_probe() never runs
> again and psec stays NULL.
> 
> What I'm seeing timing-wise:
>   - MDIO scan registers PHYs, phy_probe() defers (no PSE yet)
>   - DSA probes, phy_attach_direct() binds genphy
>   - t=17s: HS104 finally probes
>   - deferred retry: nope, driver already bound
>   - t=35s: regulator_late_cleanup (caught by admin_state_synced)
> 
> Not sure what the best path forward is here. Should we look at fixing
> phy_attach_direct() to handle this case, or go back to the non-fatal
> EPROBE_DEFER approach from v2 for now?

I thought about this some more. Looking at the phydev->drv might solve
it for DSA switches, but it is not a general solution for when the PSE
is used with a normal MAC, and the phylink_connect() happens in
open().

Now, the HS104 appears to be a quad device, intended for switches. So
maybe solving the issue only for DSA is O.K?

Otherwise, maybe we need the ability to associate the PSE controller
to the MAC? At a quick look, PSE and PHY are not tightly bound
together. So we could make the MAC driver call something similar to
of_pse_control_get() in its probe function, where it can return
EPRODE_DEFFER. net/ethtool/pse-pd.c would need some changes as well.

	Andrew

