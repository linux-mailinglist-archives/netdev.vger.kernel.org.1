Return-Path: <netdev+bounces-231512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E1244BF9BE7
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 04:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8DFDD350DC1
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 02:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE521DE3C7;
	Wed, 22 Oct 2025 02:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="n/GWZS3a"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED73157493;
	Wed, 22 Oct 2025 02:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761100544; cv=none; b=fk96HMrWDGXWaQZW2ds0YBt9VBn7owyq8wcSVSSvZHJt95UXbmlu4FxH86HDj3nWpLs7GXDjX8cRdRUs4dkOqdaj1Ci38uTAuYxKXFg2gECh7E/JVHOz4ksXe6hr1QfoROVGrSUdVdcZHkfn2aR2vXwx3PjBI3e0DAscUx0QF5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761100544; c=relaxed/simple;
	bh=rUVDmSBAq9+UnHqJwHpqywoKXJXnQ8xt45b0rUZQmPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MAAAL+RpZlrqgNSx0SISy9HQ25+K+PoEnLHmi2Nm/5Vzt72tRLI7fssi63th3Jr1nkDHal4sCrR9PZrmfSjDmkKy4VwXk3qhf9lFpjEp66D4zBld9TQykOER+as/doYvH8qNXRl5QzOv/p8sR4B0CQJaEgT2XlVj6RV7hx8gHU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=n/GWZS3a; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9aS4v5r+DPrGhVErpC22FrMUKU+3Vgd8yP4YQQiNfRw=; b=n/GWZS3a9lNZ7VriE8SU2rKDt9
	5OstIsy0MUHxBGdZHqmUQtQNzizibuV0PNCnWaJGMjkyXv7QobmE0LGAs4McOhVVf6FVz5z/acBJo
	MOhT44pxDUtz7dqF5lZ7ts16/dEr6WuGqG85diQrAbBQ3mLINn6oEndqcFB1BNpaKOPM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vBOhE-00BhfN-6M; Wed, 22 Oct 2025 04:35:28 +0200
Date: Wed, 22 Oct 2025 04:35:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v3 3/7] net: dsa: lantiq_gswip: convert trivial
 accessor uses to regmap
Message-ID: <37673fb9-b40d-4fb6-aa7b-09cc1fcd2499@lunn.ch>
References: <cover.1760877626.git.daniel@makrotopia.org>
 <594cd080da549a1d8353642a40ad4630b75c7e33.1760877626.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <594cd080da549a1d8353642a40ad4630b75c7e33.1760877626.git.daniel@makrotopia.org>

On Sun, Oct 19, 2025 at 01:48:22PM +0100, Daniel Golle wrote:
> Use coccinelle semantic patch to convert all trivial uses of the register
> accessor functions to use the regmap API directly.
> 
> // Replace gswip_switch_w with regmap_write
> @@
> expression priv, val, offset;
> @@
> - gswip_switch_w(priv, val, offset)
> + regmap_write(priv->gswip, offset, val)
> 
> // Replace gswip_mdio_w with regmap_write
> @@
> expression priv, val, offset;
> @@
> - gswip_mdio_w(priv, val, offset)
> + regmap_write(priv->mdio, offset, val)
> 
> // Replace gswip_switch_r in simple assignment - only for u32
> @@
> expression priv, offset;
> u32 var;
> @@
> - var = gswip_switch_r(priv, offset)
> + regmap_read(priv->gswip, offset, &var)
> 
> // Replace gswip_switch_mask with regmap_set_bits when clear is 0
> @@
> expression priv, set, offset;
> @@
> - gswip_switch_mask(priv, 0, set, offset)
> + regmap_set_bits(priv->gswip, offset, set)
> 
> // Replace gswip_mdio_mask with regmap_set_bits when clear is 0
> @@
> expression priv, set, offset;
> @@
> - gswip_mdio_mask(priv, 0, set, offset)
> + regmap_set_bits(priv->mdio, offset, set)
> 
> // Replace gswip_switch_mask with regmap_clear_bits when set is 0
> @@
> expression priv, clear, offset;
> @@
> - gswip_switch_mask(priv, clear, 0, offset)
> + regmap_clear_bits(priv->gswip, offset, clear)
> 
> // Replace gswip_mdio_mask with regmap_clear_bits when set is 0
> @@
> expression priv, clear, offset;
> @@
> - gswip_mdio_mask(priv, clear, 0, offset)
> + regmap_clear_bits(priv->mdio, offset, clear)
> 
> Remove gswip_switch_w() and gswip_mdio_w() functions as they now no
> longer have any users.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

