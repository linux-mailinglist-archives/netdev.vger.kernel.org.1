Return-Path: <netdev+bounces-108364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6B5923854
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 10:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C5F0B242A9
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 08:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4EB14F9FA;
	Tue,  2 Jul 2024 08:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HkF+fjah"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F99E14F9EA;
	Tue,  2 Jul 2024 08:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719909917; cv=none; b=Uu5YuqbtOCz8qByyMuohCFNhefkXb5+M3ZX4emNODiHdjbGroHSLUBgoOYlBRvdlEfj3DyCRmUjr6neEffl9r1VDecBu347746iDa3jQBucd3TBZVSpEX3gboXofL0zmbjFMZBKC1oHszJoP0joK7NcYm1GWtMQqFgLsbdE6jEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719909917; c=relaxed/simple;
	bh=kS3KHcziM0kdwu5L25OpvQZQWNawNvkjuIS1hD3LWiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KYPUBtT8smyyHkIX353FSVUDFJd1mKVVELDEr56dIuczcKSNjUfrQDFhSRufHAoQvg4hZATVAzm17V9dWJO7x5dKqcCGu8CJjK9hJd2rQwI8cmH5u8+G6XS8tglpTZJbStp1qsPOSBK7J6n+6Q16Gp/xkRl1kX4Yag3pq9qU8Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HkF+fjah; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B3A161C0003;
	Tue,  2 Jul 2024 08:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719909907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WKZjs/mX8vI13IJJrFcwrALX3bFcyicIzGyymtB+Xr0=;
	b=HkF+fjahWP2SFwW5hCuEFx9X1FBKIfu9agCDZ64cq8hJu/mgGSGnsscJh/1uersOyWUjVf
	y6ICx1O2qVbXNyj8f4MgBxo1F9YItx5OEqCIR8ee8hc/IOr2H7P2Rly8qTRcGplDOcrUtl
	XTggOx6pRLBk/gZOQnr3g2cp+X1aGisVDzpe714rmeXFahpn+vrQ5vHcwcTGu59vBeLVuA
	URmKW1FDTPdzd9qeWuIuHpmBXTjYxDjy7c6UvYTd3+pfO4hBX4cNLPm9B/vYm0m2ZiQy++
	wePtj+q2rhdn81cUIVpVWP/QKQXw4wQP3YGUxapiW057AI7RJhvG4kOrYy+zAw==
From: Romain Gantois <romain.gantois@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH net-next 2/6] net: phy: dp83869: Perform software restart after
 configuring op mode
Date: Tue, 02 Jul 2024 10:45:52 +0200
Message-ID: <9301598.CDJkKcVGEf@fw-rgant>
In-Reply-To: <ba1ac5bb-ee58-406b-9f49-54327696a6a8@lunn.ch>
References:
 <20240701-b4-dp83869-sfp-v1-0-a71d6d0ad5f8@bootlin.com>
 <20240701-b4-dp83869-sfp-v1-2-a71d6d0ad5f8@bootlin.com>
 <ba1ac5bb-ee58-406b-9f49-54327696a6a8@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-GND-Sasl: romain.gantois@bootlin.com

On lundi 1 juillet 2024 18:44:33 UTC+2 Andrew Lunn wrote:
> On Mon, Jul 01, 2024 at 10:51:04AM +0200, Romain Gantois wrote:
> > The DP83869 PHY requires a software restart after OP_MODE is changed in
> > the
> > OP_MODE_DECODE register.
> > 
> > Add this restart in dp83869_configure_mode().
> > 
> > Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
> > ---
> > 
> >  drivers/net/phy/dp83869.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/net/phy/dp83869.c b/drivers/net/phy/dp83869.c
> > index f6b05e3a3173e..6bb9bb1c0e962 100644
> > --- a/drivers/net/phy/dp83869.c
> > +++ b/drivers/net/phy/dp83869.c
> > @@ -786,6 +786,10 @@ static int dp83869_configure_mode(struct phy_device
> > *phydev,
> Not directly this patch, but dp83869_configure_mode() has:
> 
> ret = phy_write(phydev, MII_BMCR, MII_DP83869_BMCR_DEFAULT);
> 
> where #define MII_DP83869_BMCR_DEFAULT	(BMCR_ANENABLE | \
> 					 BMCR_FULLDPLX | \
> 					 BMCR_SPEED1000)
> 
> When considering the previous patch, maybe BMCR_ANENABLE should be
> conditional on the mode being selected?

Indeed, this would definitely make sense.

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com




