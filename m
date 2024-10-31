Return-Path: <netdev+bounces-140781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A639B8092
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 17:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 243AFB217D9
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 16:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F571BDAA4;
	Thu, 31 Oct 2024 16:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="TiuzZhAs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6A21465A5
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 16:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730393316; cv=none; b=PB30PFCOgaGKqPzX99mqwgoFP91KTg1S9vPv4VpslEQyy+vUkgZgRYtrSjy3B2bJcpTVx+18loPhuH5Admd5rm9z2zuRFio8xHGG/L6dth8ZgnrzuAaDx+MwIu9UEDa3rK+aQBUkGVPD71PVLeEq3VbfoD2TV4uBbjbzVxMVcaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730393316; c=relaxed/simple;
	bh=gvon8ClCqVnZZajuXEJveZr1G1KimOFFtcxjTTCS8hU=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GeTLZzYLaulU4KVQmawFxvjUWSJgW7rcAFfFeBhTiH/BYIS1F2pZeGgCsCR/m47cK0kPvTZi2E/l40RKQUuHXC8JdSGb5cB3MwXFrBk6kg7sQfbsC0txsCSfcrXBxyW3fRTlqKWoqvncpt5Cn1HyaREV5P/YzT+yI7w3+CHnQk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=TiuzZhAs; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0F29140F46
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 16:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1730393303;
	bh=6rD0z2KjUaSRPGMKlVLBitkGSyEg/HiSrNCotyBt3Ws=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=TiuzZhAsVbMFEou63HJAiPAm52sO3GPwwTwRExazu/eyeN/DxVwL07O7x5Fu0DGak
	 bf6xKyjwIwIFd7Way6irw23tSbZLzaFpKdYB2jWuBTL6ewZvsndK5aB0KJ4WgImbQG
	 iX0cuOYEiDCZbHRvVWzz0/2ycom1osQ1j6sjnFBc9aa1bBKCf/DiwkSOu3WnXq4lVk
	 tHKBJg2LTlqaIDob4fww3UYY3hfbWR3P8zSEnKNEet5ev1usXt1A5340F+4WRpsW35
	 Cz+L9L18vm5qVnsWj0vBJ2p2aEMjd1krG1L4kn7rmfvn+EjCcuyAOIxo+pgCx2onrH
	 V6W9igXya0ThA==
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-28879673bb1so935812fac.1
        for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 09:48:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730393301; x=1730998101;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6rD0z2KjUaSRPGMKlVLBitkGSyEg/HiSrNCotyBt3Ws=;
        b=VjuTMD0ssS18q7vYqGWSA4jBjsJufiChgxXpbzYIpdr6vC1DtVkdwAAQvkn9aY7k/M
         oT3I+V9/fW2z/ePsZtJcgiUyd5xOyvap3R+IyP40kblpKCMXQL0wCPn++tzjNzX6l1Qn
         iYczps78skrgkSpTyyzMAQZQRHE9cJb/Og2Aq6rZ6SpseI8eJs7j7B6ORHk3Dw1hGlAW
         j9STshhd5d8zISzXvksEasUeD3qPv6qe29Hui+N2w8wZZeS7kWEepHIjwKZTiJ41e2cI
         t5K1LVFluvwrbNCSpQDfibm65Th2dlK0rLzIXoHVw2hHqdgu8EjPDMpXNPwW2a88o4Q9
         raag==
X-Gm-Message-State: AOJu0YzrzDm/J7i5PZayQnfyfk8mRd1VzmBlz5jNkigLnvlyl/LfHv/V
	ltZNFe8BVtLk/5W6OIYCYtibw8ovY4tfdwu4WwInD4dMc9gC/nsQiiSkqAweB8pvzUCAW0T//u0
	FZGdISVLP7esQ7oMYMIAeElu3oO2BVchryEBLXpzeaugaIFSwA5hmoLlJhcgamOV6sUDPSjslAY
	bX9WvvmItjnrbdAHeLFx8BfEfhDTQy4QSAqyRrUO6KWOIO
X-Received: by 2002:a05:6870:3104:b0:260:e678:b653 with SMTP id 586e51a60fabf-2949f0b1c41mr310197fac.42.1730393301170;
        Thu, 31 Oct 2024 09:48:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcLWPA2sHrr6NrasPeNZw6K1Qi5CQGRqL6tW9K0s/YVklC0WVl3ghDGFgtxEGm8Vc8BVDTmxMlMQ225xy0QCI=
X-Received: by 2002:a05:6870:3104:b0:260:e678:b653 with SMTP id
 586e51a60fabf-2949f0b1c41mr310175fac.42.1730393300747; Thu, 31 Oct 2024
 09:48:20 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 31 Oct 2024 12:48:20 -0400
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20241030-th1520-gmac-v6-2-e48176d45116@tenstorrent.com>
References: <20241030-th1520-gmac-v6-0-e48176d45116@tenstorrent.com> <20241030-th1520-gmac-v6-2-e48176d45116@tenstorrent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Thu, 31 Oct 2024 12:48:20 -0400
Message-ID: <CAJM55Z-8hQXV+n9JH6qAJOxV=KXo4XmUB3MzFOgy9Fqip4x89g@mail.gmail.com>
Subject: Re: [PATCH net-next v6 2/2] net: stmmac: Add glue layer for T-HEAD
 TH1520 SoC
To: Drew Fustini <dfustini@tenstorrent.com>, Andrew Lunn <andrew@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, Jisheng Zhang <jszhang@kernel.org>, 
	Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Drew Fustini <drew@pdp7.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"

Drew Fustini wrote:
> From: Jisheng Zhang <jszhang@kernel.org>
>
> Add dwmac glue driver to support the DesignWare-based GMAC controllers
> on the T-HEAD TH1520 SoC.
>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> [esmil: rename plat->interface -> plat->mac_interface,
>         use devm_stmmac_probe_config_dt()]
> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> [drew: convert from stmmac_dvr_probe() to devm_stmmac_pltfr_probe(),
>        convert register access from regmap to regular mmio]
> Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
> ---
>  MAINTAINERS                                       |   1 +
>  drivers/net/ethernet/stmicro/stmmac/Kconfig       |  10 +
>  drivers/net/ethernet/stmicro/stmmac/Makefile      |   1 +
>  drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c | 268 ++++++++++++++++++++++
>  4 files changed, 280 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 72dee6d07ced..b53f9f6b3e04 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19830,6 +19830,7 @@ F:	Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
>  F:	Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml
>  F:	arch/riscv/boot/dts/thead/
>  F:	drivers/clk/thead/clk-th1520-ap.c
> +F:	drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
>  F:	include/dt-bindings/clock/thead,th1520-clk-ap.h
>
>  RNBD BLOCK DRIVERS
> diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> index 05cc07b8f48c..6658536a4e17 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
> +++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> @@ -228,6 +228,16 @@ config DWMAC_SUN8I
>  	  stmmac device driver. This driver is used for H3/A83T/A64
>  	  EMAC ethernet controller.
>
> +config DWMAC_THEAD
> +	tristate "T-HEAD dwmac support"
> +	depends on OF && (ARCH_THEAD || COMPILE_TEST)
> +	help
> +	  Support for ethernet controllers on T-HEAD RISC-V SoCs
> +
> +	  This selects the T-HEAD platform specific glue layer support for
> +	  the stmmac device driver. This driver is used for T-HEAD TH1520
> +	  ethernet controller.
> +
>  config DWMAC_IMX8
>  	tristate "NXP IMX8 DWMAC support"
>  	default ARCH_MXC
> diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
> index c2f0e91f6bf8..d065634c6223 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/Makefile
> +++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
> @@ -28,6 +28,7 @@ obj-$(CONFIG_DWMAC_STI)		+= dwmac-sti.o
>  obj-$(CONFIG_DWMAC_STM32)	+= dwmac-stm32.o
>  obj-$(CONFIG_DWMAC_SUNXI)	+= dwmac-sunxi.o
>  obj-$(CONFIG_DWMAC_SUN8I)	+= dwmac-sun8i.o
> +obj-$(CONFIG_DWMAC_THEAD)	+= dwmac-thead.o
>  obj-$(CONFIG_DWMAC_DWC_QOS_ETH)	+= dwmac-dwc-qos-eth.o
>  obj-$(CONFIG_DWMAC_INTEL_PLAT)	+= dwmac-intel-plat.o
>  obj-$(CONFIG_DWMAC_LOONGSON1)	+= dwmac-loongson1.o
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
> new file mode 100644
> index 000000000000..8c7ec156ebb0
> --- /dev/null
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
> @@ -0,0 +1,268 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * T-HEAD DWMAC platform driver
> + *
> + * Copyright (C) 2021 Alibaba Group Holding Limited.
> + * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
> + *
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/of_net.h>
> +#include <linux/platform_device.h>
> +
> +#include "stmmac_platform.h"
> +
> +#define GMAC_CLK_EN			0x00
> +#define  GMAC_TX_CLK_EN			BIT(1)
> +#define  GMAC_TX_CLK_N_EN		BIT(2)
> +#define  GMAC_TX_CLK_OUT_EN		BIT(3)
> +#define  GMAC_RX_CLK_EN			BIT(4)
> +#define  GMAC_RX_CLK_N_EN		BIT(5)
> +#define  GMAC_EPHY_REF_CLK_EN		BIT(6)
> +#define GMAC_RXCLK_DELAY_CTRL		0x04
> +#define  GMAC_RXCLK_BYPASS		BIT(15)
> +#define  GMAC_RXCLK_INVERT		BIT(14)
> +#define  GMAC_RXCLK_DELAY_MASK		GENMASK(4, 0)
> +#define  GMAC_RXCLK_DELAY_VAL(x)	FIELD_PREP(GMAC_RXCLK_DELAY_MASK, (x))

May I suggest you just do

#define GMAC_RXCLK_DELAY	GENMASK(4, 0)

..and then use FIELD_PREP(GMAC_RXCLK_DELAY, x) directly instead of wrapping it
in the GMAC_RXCLK_DELAY_VAL() macro.
This goes for GMAC_TXCLK_DELAY_{MASK,VAL} and GMAC_PLLCLK_DIV_{MASK,NUM} below
too.

> +#define GMAC_TXCLK_DELAY_CTRL		0x08
> +#define  GMAC_TXCLK_BYPASS		BIT(15)
> +#define  GMAC_TXCLK_INVERT		BIT(14)
> +#define  GMAC_TXCLK_DELAY_MASK		GENMASK(4, 0)
> +#define  GMAC_TXCLK_DELAY_VAL(x)	FIELD_PREP(GMAC_RXCLK_DELAY_MASK, (x))
> +#define GMAC_PLLCLK_DIV			0x0c
> +#define  GMAC_PLLCLK_DIV_EN		BIT(31)
> +#define  GMAC_PLLCLK_DIV_MASK		GENMASK(7, 0)
> +#define  GMAC_PLLCLK_DIV_NUM(x)		FIELD_PREP(GMAC_PLLCLK_DIV_MASK, (x))
> +#define GMAC_GTXCLK_SEL			0x18
> +#define  GMAC_GTXCLK_SEL_PLL		BIT(0)
> +#define GMAC_INTF_CTRL			0x1c
> +#define  PHY_INTF_MASK			BIT(0)
> +#define  PHY_INTF_RGMII			FIELD_PREP(PHY_INTF_MASK, 1)
> +#define  PHY_INTF_MII_GMII		FIELD_PREP(PHY_INTF_MASK, 0)
> +#define GMAC_TXCLK_OEN			0x20
> +#define  TXCLK_DIR_MASK			BIT(0)
> +#define  TXCLK_DIR_OUTPUT		FIELD_PREP(TXCLK_DIR_MASK, 0)
> +#define  TXCLK_DIR_INPUT		FIELD_PREP(TXCLK_DIR_MASK, 1)
> +
> +#define GMAC_GMII_RGMII_RATE	125000000
> +#define GMAC_MII_RATE		25000000
> +
> +struct thead_dwmac {
> +	struct plat_stmmacenet_data *plat;
> +	void __iomem *apb_base;
> +	struct device *dev;
> +};
> +
> +static int thead_dwmac_set_phy_if(struct plat_stmmacenet_data *plat)
> +{
> +	struct thead_dwmac *dwmac = plat->bsp_priv;
> +	u32 phyif;
> +
> +	switch (plat->mac_interface) {
> +	case PHY_INTERFACE_MODE_MII:
> +		phyif = PHY_INTF_MII_GMII;
> +		break;
> +	case PHY_INTERFACE_MODE_RGMII:
> +	case PHY_INTERFACE_MODE_RGMII_ID:
> +	case PHY_INTERFACE_MODE_RGMII_TXID:
> +	case PHY_INTERFACE_MODE_RGMII_RXID:
> +		phyif = PHY_INTF_RGMII;
> +		break;
> +	default:
> +		dev_err(dwmac->dev, "unsupported phy interface %d\n",
> +			plat->mac_interface);
> +		return -EINVAL;
> +	}
> +
> +	writel(phyif, dwmac->apb_base + GMAC_INTF_CTRL);
> +	return 0;
> +}
> +
> +static int thead_dwmac_set_txclk_dir(struct plat_stmmacenet_data *plat)
> +{
> +	struct thead_dwmac *dwmac = plat->bsp_priv;
> +	u32 txclk_dir;
> +
> +	switch (plat->mac_interface) {
> +	case PHY_INTERFACE_MODE_MII:
> +		txclk_dir = TXCLK_DIR_INPUT;
> +		break;
> +	case PHY_INTERFACE_MODE_RGMII:
> +	case PHY_INTERFACE_MODE_RGMII_ID:
> +	case PHY_INTERFACE_MODE_RGMII_TXID:
> +	case PHY_INTERFACE_MODE_RGMII_RXID:
> +		txclk_dir = TXCLK_DIR_OUTPUT;
> +		break;
> +	default:
> +		dev_err(dwmac->dev, "unsupported phy interface %d\n",
> +			plat->mac_interface);
> +		return -EINVAL;
> +	}
> +
> +	writel(txclk_dir, dwmac->apb_base + GMAC_TXCLK_OEN);
> +	return 0;
> +}
> +
> +static void thead_dwmac_fix_speed(void *priv, unsigned int speed, unsigned int mode)
> +{
> +	struct plat_stmmacenet_data *plat;
> +	struct thead_dwmac *dwmac = priv;
> +	unsigned long rate;
> +	u32 div, reg;
> +
> +	plat = dwmac->plat;
> +
> +	switch (plat->mac_interface) {
> +	/* For MII, rxc/txc is provided by phy */
> +	case PHY_INTERFACE_MODE_MII:
> +		return;
> +
> +	case PHY_INTERFACE_MODE_RGMII:
> +	case PHY_INTERFACE_MODE_RGMII_ID:
> +	case PHY_INTERFACE_MODE_RGMII_RXID:
> +	case PHY_INTERFACE_MODE_RGMII_TXID:
> +		rate = clk_get_rate(plat->stmmac_clk);
> +		if (!rate || rate % GMAC_GMII_RGMII_RATE != 0 ||
> +		    rate % GMAC_MII_RATE != 0) {
> +			dev_err(dwmac->dev, "invalid gmac rate %ld\n", rate);
> +			return;
> +		}
> +
> +		writel(FIELD_PREP(GMAC_PLLCLK_DIV_EN, 0), dwmac->apb_base + GMAC_PLLCLK_DIV);
> +
> +		switch (speed) {
> +		case SPEED_1000:
> +			div = rate / GMAC_GMII_RGMII_RATE;
> +			break;
> +		case SPEED_100:
> +			div = rate / GMAC_MII_RATE;
> +			break;
> +		case SPEED_10:
> +			div = rate * 10 / GMAC_MII_RATE;
> +			break;
> +		default:
> +			dev_err(dwmac->dev, "invalid speed %u\n", speed);
> +			return;
> +		}
> +
> +		reg = FIELD_PREP(GMAC_PLLCLK_DIV_EN, 1) |
> +		      FIELD_PREP(GMAC_PLLCLK_DIV_MASK, GMAC_PLLCLK_DIV_NUM(div));

..and here is an example why. You accidentally end up using
FIELD_PREP() twice here.

> +		writel(reg, dwmac->apb_base + GMAC_PLLCLK_DIV);
> +		break;
> +	default:
> +		dev_err(dwmac->dev, "unsupported phy interface %d\n",
> +			plat->mac_interface);
> +		return;
> +	}
> +}
> +
> +static int thead_dwmac_enable_clk(struct plat_stmmacenet_data *plat)
> +{
> +	struct thead_dwmac *dwmac = plat->bsp_priv;
> +	u32 reg;
> +
> +	switch (plat->mac_interface) {
> +	case PHY_INTERFACE_MODE_MII:
> +		reg = GMAC_RX_CLK_EN | GMAC_TX_CLK_EN;
> +		break;
> +
> +	case PHY_INTERFACE_MODE_RGMII:
> +	case PHY_INTERFACE_MODE_RGMII_ID:
> +	case PHY_INTERFACE_MODE_RGMII_RXID:
> +	case PHY_INTERFACE_MODE_RGMII_TXID:
> +		/* use pll */
> +		writel(GMAC_GTXCLK_SEL_PLL, dwmac->apb_base + GMAC_GTXCLK_SEL);
> +		reg = GMAC_TX_CLK_EN | GMAC_TX_CLK_N_EN | GMAC_TX_CLK_OUT_EN |
> +		      GMAC_RX_CLK_EN | GMAC_RX_CLK_N_EN;
> +		break;
> +
> +	default:
> +		dev_err(dwmac->dev, "unsupported phy interface %d\n",
> +			plat->mac_interface);
> +		return -EINVAL;
> +	}
> +
> +	writel(reg, dwmac->apb_base + GMAC_CLK_EN);
> +	return 0;
> +}
> +
> +static int thead_dwmac_init(struct platform_device *pdev, void *priv)
> +{
> +	struct thead_dwmac *dwmac = priv;
> +	int ret;
> +
> +	ret = thead_dwmac_set_phy_if(dwmac->plat);
> +	if (ret)
> +		return ret;
> +
> +	ret = thead_dwmac_set_txclk_dir(dwmac->plat);
> +	if (ret)
> +		return ret;
> +
> +	writel(GMAC_RXCLK_DELAY_VAL(0), dwmac->apb_base + GMAC_RXCLK_DELAY_CTRL);
> +	writel(GMAC_TXCLK_DELAY_VAL(0), dwmac->apb_base + GMAC_TXCLK_DELAY_CTRL);

I know Jisheng's original driver also did this too, but here you
unconditionally set both registers to 0 including the bypass and invert bits.
I'd suggest you either do

  writel(0, dwmac->apb_base + GMAC_RXCLK_DELAY_CTRL);
  writel(0, dwmac->apb_base + GMAC_TXCLK_DELAY_CTRL);

..to make this obvious, or do a proper read-modify-write to change just the
FIELD_PREP()'d bits.

> +
> +	return thead_dwmac_enable_clk(dwmac->plat);
> +}
> +
> +static int thead_dwmac_probe(struct platform_device *pdev)
> +{
> +	struct stmmac_resources stmmac_res;
> +	struct plat_stmmacenet_data *plat;
> +	struct thead_dwmac *dwmac;
> +	void __iomem *apb;
> +	int ret;
> +
> +	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "failed to get resources\n");

Here you're not capitalizing the error message.

> +
> +	plat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
> +	if (IS_ERR(plat))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(plat),
> +				     "dt configuration failed\n");
> +
> +	dwmac = devm_kzalloc(&pdev->dev, sizeof(*dwmac), GFP_KERNEL);
> +	if (!dwmac)
> +		return -ENOMEM;
> +
> +	apb = devm_platform_ioremap_resource(pdev, 1);
> +	if (IS_ERR(apb))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(apb),
> +				     "Failed to remap gmac apb registers\n");

..and here you are. Please be consistent in the whole driver.

> +
> +	dwmac->dev = &pdev->dev;
> +	dwmac->plat = plat;
> +	dwmac->apb_base = apb;
> +	plat->bsp_priv = dwmac;
> +	plat->fix_mac_speed = thead_dwmac_fix_speed;
> +	plat->init = thead_dwmac_init;
> +
> +	return devm_stmmac_pltfr_probe(pdev, plat, &stmmac_res);
> +}
> +
> +static const struct of_device_id thead_dwmac_match[] = {
> +	{ .compatible = "thead,th1520-gmac" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, thead_dwmac_match);
> +
> +static struct platform_driver thead_dwmac_driver = {
> +	.probe = thead_dwmac_probe,
> +	.driver = {
> +		.name = "thead-dwmac",
> +		.pm = &stmmac_pltfr_pm_ops,
> +		.of_match_table = thead_dwmac_match,
> +	},
> +};
> +module_platform_driver(thead_dwmac_driver);
> +
> +MODULE_AUTHOR("Jisheng Zhang <jszhang@kernel.org>");
> +MODULE_AUTHOR("Drew Fustini <drew@pdp7.com>");
> +MODULE_DESCRIPTION("T-HEAD DWMAC platform driver");
> +MODULE_LICENSE("GPL");
>
> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

