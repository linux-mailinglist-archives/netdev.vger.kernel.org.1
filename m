Return-Path: <netdev+bounces-215247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFCBB2DC2B
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 14:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64B1B7A21FD
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 12:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5F52E7179;
	Wed, 20 Aug 2025 12:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LpUZAaqD"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5DF26056E;
	Wed, 20 Aug 2025 12:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755691934; cv=none; b=HwpVtWNILTeWvV4zDoWRZtlUlcymZzwXcPSJz1AlPN0gH3IuO8ALf11eSsEoFtgkMTDrhgOfMWyOeF+wERLoGJBuZICk9QFCqEHcX1E1qmy+BABteHUfuxku55xXtZPlHmBgHzXdX3eM39lbG5NNXrdlOtMHJtqmLF9o/cIwPJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755691934; c=relaxed/simple;
	bh=bQ5B2Q2m0laiZkfULP0x9I44yylDqllMoUcnwmd0l50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fHpK3/xlmEG0Zq+hGw2c4X3yd+Qo82ya5Od53XvLHFthxMg9Dpaiagq9jvvxjmCWYH+Jn6bS2TgqFzSs7ZKhTkhcjol7acIcnHm02K6hfRvjBk/EN4qxETdY9KdbW84GEqMvK5z/bl1xsheIttarNvzccAiNFLC6GchKl+iOEDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LpUZAaqD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=sCY9EmTR6BVl/VOfxS38fNAY0QK7jbYuJgUD4YXkdRw=; b=LpUZAaqDgLJ/PVde3O/o9Ay4pw
	7oD+6g6b89iREJ76gCpmivOylgXU62n2KPKY7zwugF17Wfhh6iglUxoxq4g6wKZA2fz0S1sMQ0M65
	TeBlE1dQhjQbeRftcAkDSDaVx1eBJXBZ6sT6YN1CH8fnsBPLKbW23BTtob+1yCpl/3xo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uohfZ-005Jmh-30; Wed, 20 Aug 2025 14:11:57 +0200
Date: Wed, 20 Aug 2025 14:11:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Nishanth Menon <nm@ti.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, linux-doc@vger.kernel.org,
	Michal Kubecek <mkubecek@suse.cz>, Roan van Dijk <roan@protonic.nl>
Subject: Re: [PATCH net-next v2 5/5] net: phy: dp83td510: add MSE interface
 support for 10BASE-T1L
Message-ID: <94745663-b68c-4a4c-95d8-36933c305e34@lunn.ch>
References: <20250815063509.743796-1-o.rempel@pengutronix.de>
 <20250815063509.743796-6-o.rempel@pengutronix.de>
 <1df-68a2e100-1-20bf1840@149731379>
 <aKLwdrqn-_9KqMaA@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKLwdrqn-_9KqMaA@pengutronix.de>

> > The doc in patch 1 says :
> > 
> >   > + * Link-wide mode:
> >   > + *  - Some PHYs only expose a link-wide aggregate MSE, or cannot map their
> >   > + *    measurement to a specific channel/pair (e.g. 100BASE-TX when MDI/MDI-X
> >   > + *    resolution is unknown). In that case, callers must use the LINK selector.
> > 
> > The way I understand that is that PHYs will report either channel-specific values or
> > link-wide values. Is that correct or are both valid ? In BaseT1 this is the same thing,
> > but maybe for consistency, we should report either channel values or link-wide values ?
> 
> for 100Base-T1 the LINK and channel-A selectors are effectively the
> same, since the PHY only has a single channel. In this case both are
> valid, and the driver will return the same answer for either request.
> 
> I decided to expose both for consistency:
> - on one side, the driver already reports pair_A information for the
>   cable test, so it makes sense to allow channel-A here as well;
> - on the other side, if a caller such as a generic link-status/health
>   request asks for LINK, we can also provide that without special
>   casing.
> 
> So the driver just answers what it can. For this PHY, LINK and
> channel-A map to the same hardware register, and all other selectors
> return -EOPNOTSUPP.

The document you referenced explicitly says it is for 100BASE-T1.  Are
there other Open Alliance documents which extend the concept to -T2
and -T4 links? Do you have access to -T2 or -T4 PHYs which implement
the concept for multiple pairs?

I think it is good you are thinking about the API, how it could work
with -T2 and -T4, but do we need this complexity now?

	Andrew

