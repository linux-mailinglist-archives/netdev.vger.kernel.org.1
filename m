Return-Path: <netdev+bounces-202129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D039BAEC5D5
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 10:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B2D57A27D3
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 08:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B00D221FBD;
	Sat, 28 Jun 2025 08:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="qa0Ud+B+"
X-Original-To: netdev@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736271A727D;
	Sat, 28 Jun 2025 08:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751099629; cv=none; b=kernBs1PNDOKcAI6JPOU/2HVKjISUWWSWHLSwkFNsxlqRar7l3hEQf2AdR696HO4bEcDF3pJknTuFf9u1b+4oeugKVQlfCKuHjCCgafklwagJrE2+oey5x5VfcEkAtEWKvvvahRtsqj1SB0BeCohAcQO0UYa9ywubJnrWOu9muk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751099629; c=relaxed/simple;
	bh=b7u6Bwt2ZNSo2618uyhqFbiGYaGohf8fOBCJfzXeq9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWognonHVUNBYFCpCDZfRWIhqdt69j7N/timmXiE4k029jzuwZxbXtE+b8hXv1SWM4W13w/eNsJ3KtLlxh4npD/nqdojGmM4UroNeXGWy6LmSTAAGyfgh+V3J4IJ7umIIg19zpuPcLqLScZcThyfQolMnqae0psJwZti8WVDO0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=qa0Ud+B+; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1751099625;
	bh=b7u6Bwt2ZNSo2618uyhqFbiGYaGohf8fOBCJfzXeq9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qa0Ud+B+6b9dNWaEi9O95+hKP+rTkjJNpVCcAMW9KiKHVw2XrN7E5ApXmAFc7Tiya
	 qTSkyFNOLsK3HL9jCiH5ZDkh23GpMXuH0BuxHRLNSXAQ/neriRsm1CNKXlOEwYLDLu
	 ACKUuPkED8q09senM2ahGCO4A8ZRzYI1HQ8P2Rlo=
Date: Sat, 28 Jun 2025 10:33:44 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean <olteanv@gmail.com>, 
	Srinivas Kandagatla <srini@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "Chester A. Unal" <chester.a.unal@arinc9.com>, 
	Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, 
	Sean Wang <sean.wang@mediatek.com>, Simon Horman <horms@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v15 08/12] net: dsa: Add Airoha AN8855 5-Port
 Gigabit DSA Switch driver
Message-ID: <9f60809e-ad8c-4f97-961a-d13fa5031981@t-8ch.de>
References: <20250626212321.28114-1-ansuelsmth@gmail.com>
 <20250626212321.28114-9-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626212321.28114-9-ansuelsmth@gmail.com>

On 2025-06-26 23:23:07+0200, Christian Marangi wrote:
> Add Airoha AN8855 5-Port Gigabit DSA switch. Switch can support
> 10M, 100M, 1Gb, 2.5G and 5G Ethernet Speed but 5G is currently error out
> as it's not currently supported as requires additional configuration for
> the PCS.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/net/dsa/Kconfig  |    9 +
>  drivers/net/dsa/Makefile |    1 +
>  drivers/net/dsa/an8855.c | 2386 ++++++++++++++++++++++++++++++++++++++
>  drivers/net/dsa/an8855.h |  773 ++++++++++++
>  4 files changed, 3169 insertions(+)
>  create mode 100644 drivers/net/dsa/an8855.c
>  create mode 100644 drivers/net/dsa/an8855.h

<snip>

> +static int an8855_switch_probe(struct platform_device *pdev)
> +{
> +	struct an8855_priv *priv;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	/* Get regmap from MFD */
> +	priv->regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!priv->regmap)
> +		return -ENOENT;
> +
> +	priv->ds = devm_kzalloc(&pdev->dev, sizeof(*priv->ds), GFP_KERNEL);
> +	if (!priv->ds)
> +		return -ENOMEM;
> +
> +	priv->ds->dev = &pdev->dev;
> +	priv->ds->num_ports = AN8855_NUM_PORTS;
> +	priv->ds->priv = priv;
> +	priv->ds->ops = &an8855_switch_ops;
> +	devm_mutex_init(&pdev->dev, &priv->reg_mutex);

Check the return value of devm_mutex_init().
This will become a compile error soon.

> +	priv->ds->phylink_mac_ops = &an8855_phylink_mac_ops;
> +
> +	priv->pcs.ops = &an8855_pcs_ops;
> +	priv->pcs.poll = true;
> +
> +	dev_set_drvdata(&pdev->dev, priv);
> +
> +	return dsa_register_switch(priv->ds);
> +}

<snip>

