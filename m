Return-Path: <netdev+bounces-231513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C05BF9BF0
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 04:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D43019C485F
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 02:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC46820E704;
	Wed, 22 Oct 2025 02:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UoyoDwFs"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32181153BED;
	Wed, 22 Oct 2025 02:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761100632; cv=none; b=V0Wxfr4Oc5Np5WnwErWTYr5erPDp7QRW5SCC2izExT0VUsnjkEcH/eX3nDj2PULAc7omdwuUbUmnxHb0DgNnpcFpO63Jy1vdLVcNnKt0w1tCpP6w02rVfdOoGrQGZYmSascWDbfALIrWzxx+DaM6L5oMSbh2h0HhmFeSmXvEqgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761100632; c=relaxed/simple;
	bh=XhyYllBfwHf72vSC18rS/Cm87Saoovo31wHcPD36wlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o64KoajkbRZYjmlVP9XYJdGrXCilmIbPZgEYqSXijGEeJ19ORNHvsiYgHiTm2rgIKivDdLVi+X47DR1HrxJhifrmWob1QhsqWiXxZDEz5RhOzL9AToZU5Xkb4sOIxdGLiXYkO95D/FJGJxJPXS9mZkTK2pTvNVkwacenWGH/9fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UoyoDwFs; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XfctmnZLfrlop/d15JrrVkXBGMbnmekiyc6xg+1wABw=; b=UoyoDwFs9etYeDMMLLtSnNHExS
	g9rTXhzqWXFOS5U1MFw1G6zwBZtqRu/iCO2I8jzjj5hTM27eqQ741MAyNHrHMOHoxkp25UB+PYL8c
	QI3S3MnBIXUIQdu1CL7SaaKALe8xVTLcRka29pg1uiqWSfEnNHg7WYaB4eeIu+sT0hkg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vBOie-00BhgU-0x; Wed, 22 Oct 2025 04:36:56 +0200
Date: Wed, 22 Oct 2025 04:36:56 +0200
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
Subject: Re: [PATCH net-next v3 5/7] net: dsa: lantiq_gswip: replace *_mask()
 functions with regmap API
Message-ID: <cf92b303-33c0-4e53-9406-0a9d33d05e21@lunn.ch>
References: <cover.1760877626.git.daniel@makrotopia.org>
 <f7726b479ee82457823260280d5b6057c19188a7.1760877626.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7726b479ee82457823260280d5b6057c19188a7.1760877626.git.daniel@makrotopia.org>

On Sun, Oct 19, 2025 at 01:48:43PM +0100, Daniel Golle wrote:
> Use coccinelle to replace all uses of *_mask() with an equivalent call
> to regmap_write_bits().
> 
> // Replace gswip_switch_mask with regmap_write_bits
> @@
> expression priv, clear, set, offset;
> @@
> - gswip_switch_mask(priv, clear, set, offset)
> + regmap_write_bits(priv->gswip, offset, clear | set, set)
> 
> // Replace gswip_mdio_mask with regmap_write_bits
> @@
> expression priv, clear, set, offset;
> @@
> - gswip_mdio_mask(priv, clear, set, offset)
> + regmap_write_bits(priv->mdio, offset, clear | set, set)
> 
> // Replace gswip_mii_mask with regmap_write_bits
> @@
> expression priv, clear, set, offset;
> @@
> - gswip_mii_mask(priv, clear, set, offset)
> + regmap_write_bits(priv->mii, offset, clear | set, set)
> 
> Remove the new unused *_mask() functions.
> This naive approach will be further optmized manually in the next commit.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

