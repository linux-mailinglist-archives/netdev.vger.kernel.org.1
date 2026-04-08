Return-Path: <netdev+bounces-276724-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLdLBEXP1mnAIggAu9opvQ
	(envelope-from <netdev+bounces-276724-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 23:57:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2313C43DE
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 23:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D593F301BEDD
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 21:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98B936BCDA;
	Wed,  8 Apr 2026 21:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XKiqBoUt"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C67D364924;
	Wed,  8 Apr 2026 21:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775685393; cv=none; b=etTloFv2HwMxfJcz/XM0lg5rDLH83duZqoF8UKS9sg73meHoq4qa6IU3lZpYC70CeMSr6Wfso6K+xwGkuFzxLUrgu4pPWYFWthbB2gXes0b0xxwC3bpLPja2m138jUv7zi2fCOC6O6EUZYfD0WdQK21P2TGboo0Bx4PQKifzNxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775685393; c=relaxed/simple;
	bh=pkao1uvOW3VUb/EUvTGY76yedrKut2/T79ebeG01uDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NhzDArxcOHKP31e25xNzXdv98ixmnpfIUpMjyYpiMdHEavtn/hSsCyBwtBaSWZk0efmbrHgdFrbSQS3FnndwxiXsc1uAvcHdn31uwDyPQKNJQfNwOqSbbhpIS03q6rydWf/HhgP01Nhe0oMM7qgVHsJqu0K8LQJxwGiNpGWqRcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XKiqBoUt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0b/Pn/Q8F61gz9Ax6pk5TexCT91L0UeleBI1sx5tgf0=; b=XKiqBoUt+2dnLS9CcwX1eefIXK
	O8/v5saPr0D1IQ8/nJiLlHSjojp/4DzyvBCMAjx0jqOlPU2QPSQeXtKeOv9s8mLBchHwsFFEa8ohj
	4kyGRj2TLUg/jwO5D7nYriR9nsLUvA9IznU/N39ypxAhf5RMfsLcMDbbxdXeMFsapbsE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wAasb-00FLWj-02; Wed, 08 Apr 2026 23:56:09 +0200
Date: Wed, 8 Apr 2026 23:56:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Carlo Szelinsky <github@szelinsky.de>
Cc: o.rempel@pengutronix.de, kory.maincent@bootlin.com,
	andrew+netdev@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] net: mdio: treat PSE EPROBE_DEFER as
 non-fatal during PHY registration
Message-ID: <1e11c5d7-fcda-41d3-b680-8e8c92f07bda@lunn.ch>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276724-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[pengutronix.de,bootlin.com,lunn.ch,gmail.com,armlinux.org.uk,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Queue-Id: 7F2313C43DE
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
> device_bind_driver().

Yes, this is a known issue with phylib.

> What I'm seeing timing-wise:
>   - MDIO scan registers PHYs, phy_probe() defers (no PSE yet)
>   - DSA probes, phy_attach_direct() binds genphy
>   - t=17s: HS104 finally probes

That is a long time. Does it actually start probing much earlier, but
it is busy download firmware, and the probe completes after 17
seconds.

>   - deferred retry: nope, driver already bound
>   - t=35s: regulator_late_cleanup (caught by admin_state_synced)
> 
> Not sure what the best path forward is here. Should we look at fixing
> phy_attach_direct() to handle this case.

It is not easy to fix, because generally drivers call
phy_attach_direct() in their open() function, not probe().  It is too
late to return EPROBE_DEFFER, you can only do that in probe. phylib
knows the device exists, but it sees there is no driver, so it does
not have much choice. It can either use genphy, or it can error out
phy_attach_direct().

DSA is however atypical, and does phylink_connect() early. So there
might be a way out. In dsa_user_phy_connect() once you have the
phydev, you could look at phydev->drv and return EPROBE_DEFFER if it
is NULL. Ugly. And a bit of a layering violation. Maybe a helper in
phylib, phy_is_driver_bound() ?

   Andrew

