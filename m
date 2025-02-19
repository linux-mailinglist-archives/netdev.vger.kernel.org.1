Return-Path: <netdev+bounces-167784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B6DA3C414
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 16:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84CAF1882C8C
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 15:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1DB1EFFAB;
	Wed, 19 Feb 2025 15:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wYl0ItI6"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B31A13CA8A;
	Wed, 19 Feb 2025 15:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739980086; cv=none; b=bvYc52DzuAnT8lTaerCVpp0xMbUkoCsVSpsbBgiPPGymHz2ZxvpLtGLBKy72mwx0lf3LcFPUGpkaYil4nSGXVO4pLo3VyWb2LIQAYJlgOFOqmuOxR/1a+zly0Zbe6g+C3Jtz2dsApe57M9nvW3FgXHUtffTvVb/oW3SSVOsS1hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739980086; c=relaxed/simple;
	bh=/Ak6AYaW+NREAHqINtVDyh4urTouMrWD675Mi2sSLPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=no/+dVLLpAmnKtZu1nC5RH/haSZmdkIjvfVTYNE7AyubtyN1pCEZMq/IqM4dkC/aLJ/ARWwunRiAemEP677H/Uct3YsO6inVEt4IHv8CRtQkCTF7SaAqXCUE6QOyPO4dbdqjP/t+kGYCA34veB8EmcgmZXUAtRzY64Sdgn9SyFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wYl0ItI6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Gzj0SwPRaTNirTrm9WLzsRKYWUJkOtFVhEJhOoLZ8NU=; b=wYl0ItI6OysoRYTR2q06G8db9m
	xrqJ+Qb/eBCyNzxAC5xNTOThx6DwY+l1zz0mkvDE1nW0Ef4+USboaTSwCkHkY62Awu71DRmFK/1lN
	ZevniaXm6WXfyNWd/Nkl6CoJLI5K/f0jqwUbV2h58AxxTTDnM7bXkibhpQg+41z6r/js=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tkmIh-00Ffmc-UA; Wed, 19 Feb 2025 16:47:51 +0100
Date: Wed, 19 Feb 2025 16:47:51 +0100
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
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Steven Liu <Steven.Liu@mediatek.com>
Subject: Re: [PATCH net-next v2 3/3] net: phy: mediatek: add driver for
 built-in 2.5G ethernet PHY on MT7988
Message-ID: <724eff11-c6d1-40e1-a99f-205f5426a07d@lunn.ch>
References: <20250219083910.2255981-1-SkyLake.Huang@mediatek.com>
 <20250219083910.2255981-4-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219083910.2255981-4-SkyLake.Huang@mediatek.com>

> +config MEDIATEK_2P5GE_PHY
> +	tristate "MediaTek 2.5Gb Ethernet PHYs"
> +	depends on (ARM64 && ARCH_MEDIATEK) || COMPILE_TEST
> +	select MTK_NET_PHYLIB
> +	help
> +	  Supports MediaTek SoC built-in 2.5Gb Ethernet PHYs.
> +
> +	  This will load necessary firmware and add appropriate time delay.
> +	  Accelerate this procedure through internal pbus instead of MDIO
> +	  bus. Certain link-up issues will also be fixed here.

Please keep the file sorted, this should be the first entry.

> diff --git a/drivers/net/phy/mediatek/Makefile b/drivers/net/phy/mediatek/Makefile
> index 814879d0abe5..c6db8abd2c9c 100644
> --- a/drivers/net/phy/mediatek/Makefile
> +++ b/drivers/net/phy/mediatek/Makefile
> @@ -2,3 +2,4 @@
>  obj-$(CONFIG_MTK_NET_PHYLIB)		+= mtk-phy-lib.o
>  obj-$(CONFIG_MEDIATEK_GE_PHY)		+= mtk-ge.o
>  obj-$(CONFIG_MEDIATEK_GE_SOC_PHY)	+= mtk-ge-soc.o
> +obj-$(CONFIG_MEDIATEK_2P5GE_PHY)	+= mtk-2p5ge.o

I suppose you could say this file is sorted in reverse order so is
correct?

> diff --git a/drivers/net/phy/mediatek/mtk-2p5ge.c b/drivers/net/phy/mediatek/mtk-2p5ge.c
> new file mode 100644
> index 000000000000..adb03df331ab
> --- /dev/null
> +++ b/drivers/net/phy/mediatek/mtk-2p5ge.c
> @@ -0,0 +1,346 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +#include <linux/bitfield.h>
> +#include <linux/firmware.h>
> +#include <linux/module.h>
> +#include <linux/nvmem-consumer.h>

Is this header needed?

> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +#include <linux/pinctrl/consumer.h>
> +#include <linux/phy.h>
> +#include <linux/pm_domain.h>
> +#include <linux/pm_runtime.h>

And these two? Please only use those that are needed.

> +static int mt798x_2p5ge_phy_load_fw(struct phy_device *phydev)
> +{
> +
> +	writew(reg & ~MD32_EN, mcu_csr_base + MD32_EN_CFG);
> +	writew(reg | MD32_EN, mcu_csr_base + MD32_EN_CFG);
> +	phy_set_bits(phydev, MII_BMCR, BMCR_RESET);
> +	/* We need a delay here to stabilize initialization of MCU */
> +	usleep_range(7000, 8000);

Does the reset bit clear when the MCU is ready? That is what 802.3
defines. phy_poll_reset() might do what you need.

> +	dev_info(dev, "Firmware loading/trigger ok.\n");

dev_dbg(), if at all. You have already spammed the log with the
firmware version, so this adds nothing useful.

> +		phydev->duplex = DUPLEX_FULL;
> +		/* FIXME:
> +		 * The current firmware always enables rate adaptation mode.
> +		 */
> +		phydev->rate_matching = RATE_MATCH_PAUSE;

Can we tell current firmware for future firmware? Is this actually
fixable?

> +	}
> +
> +	return 0;
> +}
> +



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

What do you mean by "original hardware"? 

You use PHY_ID_MATCH_MODEL(MTK_2P5GPHY_ID_MT7988), so do you mean
revision 0 is broken, but revision 1 fixed it?


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

The LEDs work without firmware?

    Andrew

---
pw-bot: cr

