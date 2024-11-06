Return-Path: <netdev+bounces-142446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6517F9BF313
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 17:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29601281CCF
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 16:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E70320371C;
	Wed,  6 Nov 2024 16:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XN9UEv20"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487401E04AC;
	Wed,  6 Nov 2024 16:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730909961; cv=none; b=pe6mRKVUY6i1volxurdZulKaWjcvh4PPT47pxVUI4HKdC+Dv/gEeiV1WVRWCRoQTk9fLW9SCbhoUb+iYO3GxI8tij4jJMMNvZIPCjRfHpB0wiGPvB1Cpc02L8aQ2xIuRG2VCslQyOLkv0RKe/qXPADHNmuEy8T6KpFBhYzxpEVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730909961; c=relaxed/simple;
	bh=lf4KBp9perbI55+A88ydAA2j217WM3Kc13Bf8ITCs+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G07E8kM0Y4FeLnMkKg/7C4BCRm6VHUAtxCDA5YvT1t0dUFqxyTy3I1A81swCop3yiVn8U/XfNBJ5YiFy5F5x6Jqm997K8atYpS1iqSA1r9w9UHeMXNkm8D1GZzXI+ozWJa6SH8/By8XPNkv2MhW42iJW0vLpYtdPPXWOvosr5lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XN9UEv20; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iRksn2dUlyxiQY8SsSzJ+k2N22EHq4iZeBjynZBsjnQ=; b=XN9UEv20YjYFCljP87EAFs6m7W
	IHXMmKKdxArReUb359DJLKSM4vEoyXzl7VtO0bRnoCDrG+6VZ/h9acwsCFwrncYruVE3q+p8Gthna
	6cuOCIJA5v+S8QPUvRpIyuIwBsDH551uD2D8CFqR8QDFEo3M1aMwkFbyw8CBLw7jvUHM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t8ikJ-00CMAP-55; Wed, 06 Nov 2024 17:19:03 +0100
Date: Wed, 6 Nov 2024 17:19:03 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v3 3/3] net: phy: Add Airoha AN8855 Internal
 Switch Gigabit PHY
Message-ID: <8e5fd144-2325-43ff-b2b8-92d7f5910392@lunn.ch>
References: <20241106122254.13228-1-ansuelsmth@gmail.com>
 <20241106122254.13228-4-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106122254.13228-4-ansuelsmth@gmail.com>

> +static const u8 dsa_r50ohm_table[] = {
> +	127, 127, 127, 127, 127, 127, 127, 127, 127, 127,
> +	127, 127, 127, 127, 127, 127, 127, 126, 122, 117,
> +	112, 109, 104, 101,  97,  94,  90,  88,  84,  80,
> +	78,  74,  72,  68,  66,  64,  61,  58,  56,  53,
> +	51,  48,  47,  44,  42,  40,  38,  36,  34,  32,
> +	31,  28,  27,  24,  24,  22,  20,  18,  16,  16,
> +	14,  12,  11,   9
> +};
> +
> +static int en8855_get_r50ohm_val(struct device *dev, const char *calib_name,
> +				 u8 *dest)
> +{
> +	u32 shift_sel, val;
> +	int ret;
> +	int i;
> +
> +	ret = nvmem_cell_read_u32(dev, calib_name, &val);
> +	if (ret)
> +		return ret;
> +
> +	shift_sel = FIELD_GET(AN8855_SWITCH_EFUSE_R50O, val);
> +	for (i = 0; i < ARRAY_SIZE(dsa_r50ohm_table); i++)
> +		if (dsa_r50ohm_table[i] == shift_sel)
> +			break;

Is an exact match expected? Should this be >= so the nearest match is
found?

> +
> +	if (i < 8 || i >= ARRAY_SIZE(dsa_r50ohm_table))
> +		*dest = dsa_r50ohm_table[25];
> +	else
> +		*dest = dsa_r50ohm_table[i - 8];
> +
> +	return 0;
> +}
> +
> +static int an8855_probe(struct phy_device *phydev)
> +{
> +	struct device *dev = &phydev->mdio.dev;
> +	struct device_node *node = dev->of_node;
> +	struct air_an8855_priv *priv;
> +	int ret;
> +
> +	/* If we don't have a node, skip get calib */
> +	if (!node)
> +		return 0;

phydev->priv will be a NULL pointer, causing problems in
an8855_config_init()

	Andrew

