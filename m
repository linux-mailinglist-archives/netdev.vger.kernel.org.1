Return-Path: <netdev+bounces-172642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79761A559BA
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 23:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2C2F18961EC
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 22:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D422627C850;
	Thu,  6 Mar 2025 22:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aEbE1vfv"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4512B27C84F;
	Thu,  6 Mar 2025 22:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741299944; cv=none; b=N65FP0NwqnhGnthyjtq5o0m4hsErO5661JeSkGy9aOCrHDhsunfaMfkyh8aBWt1lcjqIISLEBLoSMu86cfFhL1dDgAlzVSNGOI9QmiZia85aYggvJ7vOLZEiplDc49wRfuKpV5F/L8cpC8bnAymMCj3g+rgSBbIX5bf+qhxqDMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741299944; c=relaxed/simple;
	bh=ODNkFsouAB0zbMg27325e5pEmsJgKLlSe0Vl9ayg0pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=asUV6rlNrTiQF//G4Brv6G2Zpq4aZbmM7vLtlmFNEvzNATWnaydvVJ5IIeVLIEQYDyYOjPIUoeCNgBCfrwIRIyMC3q6MAZsYv4H+wnZWXFeak6lolZh9+aeVjIb1U4fuGaYc6umr8Gqx51dBl53/EIYwqErIXO5RN1SvqmyoWvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=aEbE1vfv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bRSDAzfZLY2i8MApo1JUO6NM3IHVWAv/taEIFNyzysc=; b=aEbE1vfv1e3AU8SHMntOcjLfhO
	o4jRVQLRSpwkGCUp9Ka9Ne7bx/lv00Lx+rnidJ1w5Twskz7BRBRgip3wtBDguPkSh4Ttw8HPM4it1
	VbDb6vldTX9eINY76jtGbL99YaW2g9QycS+Br/QGig7TFoO/MSJjV019m3VjwxztKinY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tqJeV-002w7o-Cf; Thu, 06 Mar 2025 23:25:15 +0100
Date: Thu, 6 Mar 2025 23:25:15 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Wadim Egorov <w.egorov@phytec.de>, netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 1/3] net: stmmac: dwmac-rk: Use DELAY_ENABLE macro for
 RK3328
Message-ID: <d6b15dc2-f6b2-4703-a4da-07618eaed4db@lunn.ch>
References: <20250306203858.1677595-1-jonas@kwiboo.se>
 <20250306203858.1677595-2-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306203858.1677595-2-jonas@kwiboo.se>

On Thu, Mar 06, 2025 at 08:38:52PM +0000, Jonas Karlman wrote:
> Support for Rockchip RK3328 GMAC and addition of the DELAY_ENABLE macro
> was merged in the same merge window. This resulted in RK3328 not being
> converted to use the new DELAY_ENABLE macro.
> 
> Change to use the DELAY_ENABLE macro to help disable MAC delay when
> RGMII_ID/RXID/TXID is used.
> 
> Fixes: eaf70ad14cbb ("net: stmmac: dwmac-rk: Add handling for RGMII_ID/RXID/TXID")

Please add a description of the broken behaviour. How would i know i
need this fix? What would i see?

We also need to be careful with backwards compatibility. Is there the
potential for double bugs cancelling each other out? A board which has
the wrong phy-mode in DT, but because of this bug, the wrong register
is written and it actually works because of reset defaults?

    Andrew

---
pw-bot: cr

