Return-Path: <netdev+bounces-275582-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKQCEtOl02nhjwcAu9opvQ
	(envelope-from <netdev+bounces-275582-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 14:23:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9764F3A3434
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 14:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99E173012C59
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 12:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726CF3321C1;
	Mon,  6 Apr 2026 12:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dPMij2wj"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA73D3358D3;
	Mon,  6 Apr 2026 12:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775478156; cv=none; b=csbreXqXLOjHoWK/yfdRd7k6Xh2MEYhyu3mHkb+tUhUPwGJ3f5PIekNy3dlMhdCjr7RaZhvfOAZkm+iX4AiwBjSJTz3GNwnAyQsUnfgkc6z2UKY0jVA8Jc/LsnHLtVZZBTYGaWaDviTOKdgkFmq8MejjsczWWkTcbdDAcGLaEag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775478156; c=relaxed/simple;
	bh=niqSk6DUVUH53+cqJA+2OKUrKWGCPZcO2zEBBVrc7cA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pc9IE0nVMq0xDIaYf0Tok3Z+KM9RJztg699Cmoc31ReDhuvAxjSkLKu0aWrXXzAb7OjamHvli2zXdQvStn5Dthnh5BKCQsOVtJmJJaofdb/bInIosykoXJHwUtbgcZm6so71T+7V4yS/3928sDE2CIwfhNiA9LE09TQI3O1k/z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dPMij2wj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=stuNshUU+XPaJJW5cjWHB5iVlXxdZbVruVS88gAZKBA=; b=dPMij2wj/002A82KiW7Q4dB0Ey
	p7Pk0anE4qHEGNUs7JqNdxiKSHwErigklADGZSFqvNN5XErAsMm2e9t5qMg9i5ZwhVG7SogpPivnu
	mazzWBcFo3aZaKg814So0EPUWbwrsEzpxrg3YeiKHqaIM5uTplzvqVl/7qdzom11SDLM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w9iy8-00Ez35-KE; Mon, 06 Apr 2026 14:22:16 +0200
Date: Mon, 6 Apr 2026 14:22:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Carlo Szelinsky <github@szelinsky.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
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
Message-ID: <1df8b470-2449-418d-a4a8-9cd929ced463@lunn.ch>
References: <6185f9d8-dabe-4190-b020-711e3a046e64@lunn.ch>
 <20260405185730.3937952-1-github@szelinsky.de>
 <adN9Ha5FgJ8sp6gj@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adN9Ha5FgJ8sp6gj@pengutronix.de>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[szelinsky.de,bootlin.com,lunn.ch,gmail.com,armlinux.org.uk,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-275582-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9764F3A3434
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> The core question, do we need PSE for PHY functionality?

I don't think the PHY should require PSE in order to send/receive
frames. If the PSE is not supplying power, the link peer is probably
off, but that is not so different from the cable being unplugged.

> We can make a step back and re-evaluate - what functionality and what
> order is actually required to find potentially better implementation.
> 
> We have a lot of current flowing over wires, budget and port
> prioritization issues, things which may damage HW if done not correctly.
> With other word, if we do not have properly operational environment
> providing system specific policies, it is better to run safe
> configuration - all ports/regulators are off.
> 
> This means:
> - PSE controller driver should be registered as early as possible,
>   without caring about existence of PHYs, ports or network interfaces.
>   And configure ports in to default safe operation - off. Accept we
>   have some controller/firmware which would care about safety.

Don't most PSE have I2C or SPI interfaces? So they have a different
life cycle to PHYs, ports or netdevs. Only PSEs which are embedded
within a PHY, on an MDIO bus, will have a closely linked life
cycle. But do such devices exist?

As soon as the PSE probes with all the resources it needs, and can
impose a safe default setting. And that can be independent of PHY and
netdev. I _think_ we only need the netdev for configuration, since
ethtool addresses netdev's.  There would only be issues with user
space listening to udev creation events, it knows the PSE exists, but
it has no way to access it until the netdev is created.

> - as soon as we have all needed components, we can start provide
>   controllable interfaces to serve external consumers.

Yep.

> If we decouple PSE and PHY registration (and we probably will need to do
> it some day), we would need to have own implementation of deferred
> probing in the PSE core.  Event driven or by polling - which sounds not
> like very good idea. Pick your poison...

I don't see why. Maybe i'm missing something. We have two cases:

1) PSE probes first. When the PHY looks up the PSE, it exists, and it
is passed a handle to the PSE.

2) PHY probes first. The PSE core returns EPROBE_DEFFER, and the PHY
will try again later.

I don't think there is any chicken/egg problems.

	Andrew

