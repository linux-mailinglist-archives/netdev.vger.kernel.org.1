Return-Path: <netdev+bounces-158719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D48A130FD
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 02:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28C6D1885673
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 01:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C570149652;
	Thu, 16 Jan 2025 01:58:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D915BCA4E;
	Thu, 16 Jan 2025 01:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736992728; cv=none; b=uyTNqysUZh9Ha5plbhBIWgudBrO/wIbZiXQKurOl2CiixAEW3gl5YwzxaLaekm6e6ycPzfLwXTi4t0PajzOPo/Vl26AQoyT+SjgPwcS8SHOsz40sAoQtx7YQlH82ytMsYxNxAUegvBExX2o7HMGVq5MRNxnkrYo5s2AIpJQV4bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736992728; c=relaxed/simple;
	bh=TmMJtEfASvIwmYEqdahDMkZ/kYpz2LK+G0QK9J24s2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9J/wcLwgjZJpPXWRKvmKP8M1c8MqyOGlT9o8V26Ect8kmeZA1GxVZDwrH6y3V+3F0I+c6CfHixNuRBL8SF0eGPUQxIRyg1A9hjv10lrZV8r8E8ky647/39tyoHEkLJ5s1rfJLTinkjSJDQOv3/K7xGqLLHaVYuwRgYMRIrb+kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1tYF9Q-000000005g8-1tmN;
	Thu, 16 Jan 2025 01:58:28 +0000
Date: Thu, 16 Jan 2025 01:58:23 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Sky Huang <SkyLake.Huang@mediatek.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Qingfang Deng <dqfext@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Steven Liu <Steven.Liu@mediatek.com>
Subject: Re: [PATCH net-next 3/3] net: phy: mediatek: add driver for built-in
 2.5G ethernet PHY on MT7988
Message-ID: <Z4hnv2lzy8Ntd_Hp@makrotopia.org>
References: <20250116012159.3816135-1-SkyLake.Huang@mediatek.com>
 <20250116012159.3816135-4-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116012159.3816135-4-SkyLake.Huang@mediatek.com>

Hi Sky,

On Thu, Jan 16, 2025 at 09:21:58AM +0800, Sky Huang wrote:
> From: Sky Huang <skylake.huang@mediatek.com>
> 
> Add support for internal 2.5Gphy on MT7988. This driver will load
> necessary firmware and add appropriate time delay to make sure
> that firmware works stably. Also, certain control registers will
> be set to fix link-up issues.
> 
> Signed-off-by: Sky Huang <skylake.huang@mediatek.com>
> ---
>  MAINTAINERS                          |   1 +
>  drivers/net/phy/mediatek/Kconfig     |  11 +
>  drivers/net/phy/mediatek/Makefile    |   1 +
>  drivers/net/phy/mediatek/mtk-2p5ge.c | 343 +++++++++++++++++++++++++++
>  4 files changed, 356 insertions(+)
>  create mode 100644 drivers/net/phy/mediatek/mtk-2p5ge.c
> 
> [...]
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
> +		/* The original hardware only sets MDIO_DEVS_PMAPMD */
> +		phydev->c45_ids.mmds_present |= MDIO_DEVS_PCS |
> +						MDIO_DEVS_AN |
> +						MDIO_DEVS_VEND1 |
> +						MDIO_DEVS_VEND2;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	priv->fw_loaded = false;
> +	phydev->priv = priv;
> +
> +	mtk_phy_leds_state_init(phydev);

Calling mtk_phy_leds_state_init() can't work without also defining
led_hw_control_get() for that driver.

This is what mtk_phy_leds_state_init() does:
        for (i = 0; i < 2; ++i)
                phydev->drv->led_hw_control_get(phydev, i, NULL);

The driver lacking led_hw_control_get() method (see below) will make
this a call to a NULL function pointer.

Imho it's fine to add the driver without support for the LEDs for now
and add LED support later on. But in that case you also shouldn't call
mtk_phy_leds_state_init().

> +
> +	return 0;
> +}
> +
> +static struct phy_driver mtk_2p5gephy_driver[] = {
> +	{
> +		PHY_ID_MATCH_MODEL(MTK_2P5GPHY_ID_MT7988),
> +		.name = "MediaTek MT7988 2.5GbE PHY",
> +		.probe = mt798x_2p5ge_phy_probe,
> +		.config_init = mt798x_2p5ge_phy_config_init,
> +		.config_aneg = mt798x_2p5ge_phy_config_aneg,
> +		.get_features = mt798x_2p5ge_phy_get_features,
> +		.read_status = mt798x_2p5ge_phy_read_status,
> +		.get_rate_matching = mt798x_2p5ge_phy_get_rate_matching,
> +		.suspend = genphy_suspend,
> +		.resume = genphy_resume,
> +		.read_page = mtk_phy_read_page,
> +		.write_page = mtk_phy_write_page,
> +	},
> +};
> +
> +module_phy_driver(mtk_2p5gephy_driver);
> +
> +static struct mdio_device_id __maybe_unused mtk_2p5ge_phy_tbl[] = {
> +	{ PHY_ID_MATCH_VENDOR(0x00339c00) },
> +	{ }
> +};
> +
> +MODULE_DESCRIPTION("MediaTek 2.5Gb Ethernet PHY driver");
> +MODULE_AUTHOR("SkyLake Huang <SkyLake.Huang@mediatek.com>");
> +MODULE_LICENSE("GPL");
> +
> +MODULE_DEVICE_TABLE(mdio, mtk_2p5ge_phy_tbl);
> +MODULE_FIRMWARE(MT7988_2P5GE_PMB_FW);
> -- 
> 2.45.2
> 

