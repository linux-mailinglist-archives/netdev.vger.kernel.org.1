Return-Path: <netdev+bounces-97199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FE28C9E42
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 15:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 429F5281649
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 13:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD2113664A;
	Mon, 20 May 2024 13:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0Fn4CyZ6"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BCD53E07;
	Mon, 20 May 2024 13:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716212143; cv=none; b=Qr50qylBMQvoVqKPeMIX/Psy+j5tu8/WuedcYQfysci+wsgd5bcfZUgJocfdLjDSyy7E0YULc0fdGQnggPQDjJCYw4dSfqeH/pibmrNFM0RJYhq2dg9ejQCy4KUayPcBXGK/GrsPpn2GuaXSy5VSr3IG8jbi+EfHxN1zxLcdHek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716212143; c=relaxed/simple;
	bh=eKlD1ITrUAqbOoU46mxHGdH230qRNZ71RdpMuz1QTt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JANN4CS080eNDW8Osi8UpJKqQiqg1qohXb0VjN+vUwsLA/0yrHqR4SmyfhCMNVQsrav7M6m4ka8Vugej7owKDq1eNCxhXhDgLANUmVb81+qHZlE1unPUwJN+ZQUuPZ6ohhFxtqImrMIu+N5cdtGN+CdPVLbONTCTeBXH7PmJL4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0Fn4CyZ6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KvdEIYYYkIBNIphyeovfwOBCnQAQsyfyDCazfo+ptac=; b=0Fn4CyZ6sIsex8ug8E1lVRfHYM
	YkjjrNDxDIKdB/4AtWOLmYn6AnYCNtklor1/x1VLM6sxaJhP1EZTdAqOlbAEeVtl34e4HAaLh0cMY
	wLzTG2KfwRUcL5He7OG3DbvllFMTk+6EdFh1KOKztgR+VVLJu2ksMJPYYVIXUO1MvRI4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s93Ao-00FhQJ-Ld; Mon, 20 May 2024 15:35:30 +0200
Date: Mon, 20 May 2024 15:35:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sky Huang <SkyLake.Huang@mediatek.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Steven Liu <Steven.Liu@mediatek.com>
Subject: Re: [PATCH net-next v3 5/5] net: phy: add driver for built-in 2.5G
 ethernet PHY on MT7988
Message-ID: <1158a657-1b95-4d7f-9371-41eec5388441@lunn.ch>
References: <20240520113456.21675-1-SkyLake.Huang@mediatek.com>
 <20240520113456.21675-6-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520113456.21675-6-SkyLake.Huang@mediatek.com>

> +static int mt798x_2p5ge_phy_config_init(struct phy_device *phydev)
> +{
> +	struct mtk_i2p5ge_phy_priv *priv = phydev->priv;
> +	struct device *dev = &phydev->mdio.dev;
> +	const struct firmware *fw;
> +	struct pinctrl *pinctrl;
> +	int ret, i;
> +	u16 reg;
> +
> +	if (!priv->fw_loaded) {
> +		if (!priv->md32_en_cfg_base || !priv->pmb_addr) {
> +			dev_err(dev, "MD32_EN_CFG base & PMB addresses aren't valid\n");
> +			return -EINVAL;
> +		}

...

> +static int mt798x_2p5ge_phy_probe(struct phy_device *phydev)
> +{
> +	struct mtk_i2p5ge_phy_priv *priv;
> +
> +	priv = devm_kzalloc(&phydev->mdio.dev,
> +			    sizeof(struct mtk_i2p5ge_phy_priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	switch (phydev->drv->phy_id) {
> +	case MTK_2P5GPHY_ID_MT7988:
> +		priv->pmb_addr = ioremap(MT7988_2P5GE_PMB_BASE, MT7988_2P5GE_PMB_LEN);
> +		if (!priv->pmb_addr)
> +			return -ENOMEM;
> +		priv->md32_en_cfg_base = ioremap(MT7988_2P5GE_MD32_EN_CFG_BASE,
> +						 MT7988_2P5GE_MD32_EN_CFG_LEN);
> +		if (!priv->md32_en_cfg_base)
> +			return -ENOMEM;
> +
> +		/* The original hardware only sets MDIO_DEVS_PMAPMD */
> +		phydev->c45_ids.mmds_present |= (MDIO_DEVS_PCS | MDIO_DEVS_AN |
> +						 MDIO_DEVS_VEND1 | MDIO_DEVS_VEND2);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}

How can priv->md32_en_cfg_base or priv->pmb_addr not be set in
mt798x_2p5ge_phy_config_init()

	Andrew

