Return-Path: <netdev+bounces-204058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9198DAF8BB7
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 10:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3822E76476D
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 08:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA6A309DBE;
	Fri,  4 Jul 2025 08:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="V8jzDXZy"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E959309DB7;
	Fri,  4 Jul 2025 08:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751616985; cv=none; b=gnFGUGCtsXFhgfNCKiYaOl01IQB9DSTD2wMngDLPrVq6udCoLjFUhThx8tJWYbp9V6kzHs0fSKVsqCTMAWs34iHI4/7TNjIZ6l6Gz8fCD2ME7TgaXJjk96amAaRHvOUoJH4ua9PJDs7ASDBgYhdT8mZwVmFoA4YhSHHP1TTuiMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751616985; c=relaxed/simple;
	bh=FmEScJJtDiR5EC91e3JJpMlUWgBrFNK/IOQMLkXY8A4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EsdIU2qk5+VOezAWKPJulz7zgosBbwizpGV7WiAMDo/2V/3YpvrS9IHgBlfa8HA2mn2wueORvy/wM3T+AulTz0mI4l0FIPd/dDjknHy+L/fuudIL2QT3gn4nYbwP0OIzzqtE4K80GBmC5TgFmampmWS/6/7vvw0FMuCogK6vRto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=V8jzDXZy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5hgLMUjtMWdFSYSDwSph8mH2JAMp8Kj0KGfpI3vdp/I=; b=V8jzDXZyHTLiYs0km7TJJ+IFul
	soxASJuHloewfWsAUQzCH/NPFMARfCTgPy0BHDM8P8Pu+p5/nDdjYFAbArZZBnHUqwufIl4L0Kl6K
	dIDBiEV200RGWTZjDBe3Jf25rEELiUpTR0p1gHzB8VSz30V+eJBPnN04txwbKubGQctc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uXbaV-000BNF-0f; Fri, 04 Jul 2025 10:16:03 +0200
Date: Fri, 4 Jul 2025 10:16:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andre Edich <andre.edich@microchip.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH net v2 2/3] net: phy: smsc: Force predictable MDI-X state
 on LAN87xx
Message-ID: <49b49005-e857-445e-8b63-e84cbfdae17b@lunn.ch>
References: <20250703114941.3243890-1-o.rempel@pengutronix.de>
 <20250703114941.3243890-3-o.rempel@pengutronix.de>
 <20250704100031.19f95d3e@fedora.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704100031.19f95d3e@fedora.home>

> The patch looks good to me, but I have a few questions.  As this
> overrides some configuration on existing HW, and I'm not utra familiar
> with auto-mdix, is there any chance this could cause regressions ?
> 
> Especially regarding your patch 3, is there any chance that the PHY is
> strapped in a fixed MDIX mode to address the broken autoneg off mode ? 
> 
> I'm not saying that strapping is a good solution for that ofc :) it's a
> shame we can't read the strap config :/

This might technically be considered a behaviour change. However there
are few systems which don't support it. It is also independent of
auto-neg, so autoneg off should not be an issue.

I think this is reasonably safe, and if somebody does report a
regression, we can revert the patch.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

