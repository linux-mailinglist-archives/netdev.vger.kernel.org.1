Return-Path: <netdev+bounces-129460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A08984065
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 10:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2354B282617
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 08:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C7014B084;
	Tue, 24 Sep 2024 08:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PIz8Nf8x"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA551487FE;
	Tue, 24 Sep 2024 08:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727166280; cv=none; b=LMCCYfm/8Rcdvi0dDzxUw28uCKn3qAnAxzXliLklYVR6BGj9rMenNIaTmYhIvbUzYNl6sl6cf4+2042hV3ZC1WT9/5ixymgFuuyVdPCPrqwUfXh6VEvpNwLDgBi6jG7QDqCrCI8fTF/2a8+9coZ5xV/IziTcU5LaEf6J5X1IrE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727166280; c=relaxed/simple;
	bh=8n4bFA7B09ewyZG9CasQI/4MG5NrHJPqk7S5bX5HMWw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=odBDtGkBk3NvJEF0iG2e8yQazCaN+TOCuso2wBcUC22fNDijhGsGHZwsw69brFe2VAcBn+4liFoJjkSfMLhsGo7YvGO5f/xJM+BrWHb8F2e5MkVO+cXsnS5tX0Ow4NbRCiVr3pJPh9Fn3BctwsMjs2984rkHxZYii9Yiq7L6a1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PIz8Nf8x; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EBCB620010;
	Tue, 24 Sep 2024 08:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727166276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IcDW4eTOaeETu4pAyez9dh+cUFxrnVtz3FhQ7oyz6SE=;
	b=PIz8Nf8xW69GnpbsvQYe4sR5AWrwNNGLuEn1w+amNu2mq+tXm6+FHAkb29CbgikoIPymil
	L3GfmeWvhkA5IcK7sR5p5MIshn+P+2dQlq8vCt8b2bKek++k3X0k+Hqvn1sa42WuRIfEwk
	yg3cgqpEstq658H7PmDoox800SWWb0Jm3epxP91VixEOz4CQGpt8F/jC/pSa12qj183eRN
	Cl7Wf0I2+1UlDPNra21Ovm4GwJSOPEsZzhSloWBuavgsQNj13G9MD+zLUACR/pXuZxtNXJ
	mwp++oVHIB0i612x68a/bRlu+QlEK8ROgESjnPu5+2nzsZPF3kjyU6ZT1I/mAQ==
Date: Tue, 24 Sep 2024 10:24:33 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Abhishek Chauhan <quic_abchauha@quicinc.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Halaney <ahalaney@redhat.com>, "Russell King (Oracle)"
 <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, Bartosz Golaszewski
 <bartosz.golaszewski@linaro.org>, "linux-tegra@vger.kernel.org"
 <linux-tegra@vger.kernel.org>, Brad Griffis <bgriffis@nvidia.com>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Jon Hunter <jonathanh@nvidia.com>,
 kernel@quicinc.com
Subject: Re: [PATCH net v2] net: phy: aquantia: Introduce custom
 get_features
Message-ID: <20240924102433.3ff11d20@fedora.home>
In-Reply-To: <20240924055251.3074850-1-quic_abchauha@quicinc.com>
References: <20240924055251.3074850-1-quic_abchauha@quicinc.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi,

On Mon, 23 Sep 2024 22:52:51 -0700
Abhishek Chauhan <quic_abchauha@quicinc.com> wrote:

> Remove the use of phy_set_max_speed in phy driver as the
> function is mainly used in MAC driver to set the max
> speed.
> 
> Introduce custom get_features for AQR family of chipsets
> 
> 1. such as AQR111/B0/114c which supports speeds up to 5Gbps
> 2. such as AQR115c/AQCS109 which supports speeds up to 2.5Gbps
> 
> Fixes: 038ba1dc4e54 ("net: phy: aquantia: add AQR111 and AQR111B0 PHY ID")
> Fixes: 0974f1f03b07 ("net: phy: aquantia: remove false 5G and 10G speed ability for AQCS109")
> Fixes: c278ec644377 ("net: phy: aquantia: add support for AQR114C PHY ID")
> Fixes: 0ebc581f8a4b ("net: phy: aquantia: add support for aqr115c")
> Link: https://lore.kernel.org/all/20240913011635.1286027-1-quic_abchauha@quicinc.com/T/
> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
> ---
> Changes since v1 
> 1. remove usage of phy_set_max_speed in the aquantia driver code.
> 2. Introduce aqr_custom_get_feature which checks for the phy id and
>    takes necessary actions based on max_speed supported by the phy
> 3. remove aqr111_config_init as it is just a wrapper function. 
> 
> output from my device looks like :- 
> 1. Link is up with 2.5Gbps with 2500BaseX with autoneg on.
> 
> 
> Settings for eth0:
>         Supported ports: [ TP    FIBRE ]
>         Supported link modes:   10baseT/Full
>                                 100baseT/Full
>                                 1000baseT/Full
>                                 2500baseX/Full
>                                 2500baseT/Full
>         Supported pause frame use: Symmetric Receive-only
>         Supports auto-negotiation: Yes
>         Supported FEC modes: Not reported
>         Advertised link modes:  10baseT/Full
>                                 100baseT/Full
>                                 1000baseT/Full
>                                 2500baseX/Full
>                                 2500baseT/Full
> 

 [...]

> +static void aqr_supported_speed(struct phy_device *phydev, u32 max_speed)
> +{
> +	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported) = { 0, };
> +
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT, supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_FIBRE_BIT, supported);

Can this PHY actually support FIBRE ports ? What you must list here are
the modes that the PHY can support on the LP side. I'm not familiar
with this PHY, but from what I can see from the current driver, there's
no such support yet in the driver.

> +	linkmode_set_bit(ETHTOOL_LINK_MODE_TP_BIT, supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT, supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT, supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT, supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT, supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Half_BIT, supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, supported);
> +
> +	if (max_speed == SPEED_2500) {
> +		linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseX_Full_BIT, supported);

If the PHY is strictly BaseT, then you shouldn't specify 2500BaseX as
supported

> +		linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, supported);
> +	} else if (max_speed == SPEED_5000) {
> +		linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseX_Full_BIT, supported);

Same here

> +		linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, supported);
> +		linkmode_set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT, supported);
> +	}
> +
> +	linkmode_copy(phydev->supported, supported);
> +}
> +
> +static int aqr_custom_get_feature(struct phy_device *phydev)
> +{
> +	switch (phydev->drv->phy_id) {
> +	case PHY_ID_AQR115C:
> +	case PHY_ID_AQCS109:
> +		aqr_supported_speed(phydev, SPEED_2500);
> +	break;
> +	case PHY_ID_AQR111:
> +	case PHY_ID_AQR111B0:
> +	case PHY_ID_AQR114C:
> +		aqr_supported_speed(phydev, SPEED_5000);
> +	break;
> +	}
> +	return 0;
> +}

You could define one .get_feature for the 2.5G PHYs and another for the
5G phys, that would avoid having to modify this single helper for each
new PHY.

Thanks,

Maxime

