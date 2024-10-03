Return-Path: <netdev+bounces-131477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B0798E989
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 07:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67BD21F241B1
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 05:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C8342049;
	Thu,  3 Oct 2024 05:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="E23+LeT1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C161F5FF
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 05:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727934763; cv=none; b=BYHKlbcLlZX+l2uD47DNvX1LhLy7vKRmOEw4ziDwILlbpK21czcwmBKD0eldh3wqJRGLWz62NBV4ImCychalVPUHhJ2s2XJPYrao0mNnsInzZDIVV7l7ftP0SMi3inygdIcdVYsmd4HuM8nvtVxArAztIblnF33bluDrMs02WAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727934763; c=relaxed/simple;
	bh=oYdBANUQi6m9BQzHBhUpP00s5QK9lKhkLrD1z7fyiis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1FrccAuXfp3uTNIjIEcL4eaTra3wqTOLT2BgUEGHrnkiSsW/9dSg9yIfjrKxzOke1DmNGSeu3fizsvh8fYtGXTObGHLhheNdFcbPHYZN4+ePi6RrbYC993fVYJpmwaSAA2jEXohGCbOl+l9mvk/ui70kJ+qZOHRFf7heT6Okv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=E23+LeT1; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20ba8d92af9so3249305ad.3
        for <netdev@vger.kernel.org>; Wed, 02 Oct 2024 22:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1727934761; x=1728539561; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PWqERqg3U39KNd0HaWAEa6vnW1C/QZVmIPIZ8zAz/+s=;
        b=E23+LeT16JCDhHYVglTaOXxbLSyVbJ7cOGYyKdVC6OUhv7OnaxsyhJ7ea4aGdSlliw
         NKY98BappRxIoeZLVr032hEIuZNkea5M6rVdtawE1sBmOPpR/z7qCUlaR35Wazf3d5UO
         zpRmLACRWS9uNjQZxbHvAgwzm8q7CDy1m57Z8kW6cqv7lOrJIidKHwuNRZMn7JwnWYxa
         bGZov2OZcfY/gWuT/W9vMWQkYb/3C1enRUfqYcSjKCHxPiZCBPfzKHesKU2lAWDlE651
         MP0bFC7vXWiJ0FQkCt6WjsxboiHOB60LiEq0PusyVbVmlZvI6myrK98tPMst+rUefSDW
         fbSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727934761; x=1728539561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PWqERqg3U39KNd0HaWAEa6vnW1C/QZVmIPIZ8zAz/+s=;
        b=KRrzw3ppiasGRS8dQEqLtfxsuiBKVpyhN4t4n4+OtHy1kTfODgWmomcIeUdAgucmLL
         r5DmBzBX2ReF31j+wiTS9rm3pltvxxU/kGFWmueLmFZN1wdO0Olg+dZy9vt34mCawwFG
         v16Dmm84aDPTVen17KWak0/yC4jZvDaF7BMPPamuHVpkb3nL2hdrwrEJgD7X4ojQLBjT
         MKLROIahtwfb8I/eHJsJSKfQ2Z6SSi1KI7whAqZPzeVJPTXP2ryXh5cqxvAknZICq7EK
         1UR5AKU8IlKhMzjunPaXb+AemcGh3MS/5FLrFaNSmZjmYIcvmo4AwmIVbEOyfln9/XXR
         5VMg==
X-Forwarded-Encrypted: i=1; AJvYcCUQkaEctmIIyCMFFjBf85UjDzb9YgvUnScnElkTNQUyPNO5FeS+avzkb6WgKuKg/4UNxOWgbm4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr3y6LF6i6wp84iyDo8gwXJPN8EGWPcdItKFJcww3UEYrBkazg
	cOEPUzOIfeoVysqm0CM2JOYjb/0LUeJH/Z/HsctuhHuvDRwZGxSKrf7bVTTaJ4w=
X-Google-Smtp-Source: AGHT+IHwG+qEvOVXqNgTsAzSqC6vFZ7T7Hg9FDqIn4lMxAVd8/F6MYaOVHqMKlTTCKJ0rlJTtIqTqA==
X-Received: by 2002:a17:902:c947:b0:20b:7388:f74 with SMTP id d9443c01a7336-20bc59f06a6mr79326325ad.12.1727934760837;
        Wed, 02 Oct 2024 22:52:40 -0700 (PDT)
Received: from x1 (71-34-69-82.ptld.qwest.net. [71.34.69.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20bef70706esm2181765ad.291.2024.10.02.22.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 22:52:40 -0700 (PDT)
Date: Wed, 2 Oct 2024 22:52:38 -0700
From: Drew Fustini <dfustini@tenstorrent.com>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Conor Dooley <conor@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 2/3] net: stmmac: Add glue layer for T-HEAD TH1520 SoC
Message-ID: <Zv4xJge/rmMNzLAY@x1>
References: <20240930-th1520-dwmac-v3-0-ae3e03c225ab@tenstorrent.com>
 <20240930-th1520-dwmac-v3-2-ae3e03c225ab@tenstorrent.com>
 <CAJM55Z-+-Ca3kNuNkTpfea8jYEDTdojhx=gM__MScVyT3Yomog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJM55Z-+-Ca3kNuNkTpfea8jYEDTdojhx=gM__MScVyT3Yomog@mail.gmail.com>

On Tue, Oct 01, 2024 at 02:48:13AM -0700, Emil Renner Berthing wrote:
> Drew Fustini wrote:
> > From: Jisheng Zhang <jszhang@kernel.org>
> >
> > Add dwmac glue driver to support the DesignWare-based GMAC controllers
> > on the T-HEAD TH1520 SoC.
> >
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > [esmil: rename plat->interface -> plat->mac_interface,
> >         use devm_stmmac_probe_config_dt()]
> > Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> > [drew: convert from stmmac_dvr_probe() to devm_stmmac_pltfr_probe()]
> > Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
> > ---
> >  MAINTAINERS                                       |   1 +
> >  drivers/net/ethernet/stmicro/stmmac/Kconfig       |  11 +
> >  drivers/net/ethernet/stmicro/stmmac/Makefile      |   1 +
> >  drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c | 291 ++++++++++++++++++++++
> >  4 files changed, 304 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 9e50107efb37..1d24863c01df 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -19946,6 +19946,7 @@ F:	Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml
> >  F:	Documentation/devicetree/bindings/pinctrl/thead,th1520-pinctrl.yaml
> >  F:	arch/riscv/boot/dts/thead/
> >  F:	drivers/clk/thead/clk-th1520-ap.c
> > +F:	drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
> >  F:	drivers/pinctrl/pinctrl-th1520.c
> >  F:	include/dt-bindings/clock/thead,th1520-clk-ap.h
> >
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> > index 05cc07b8f48c..82030adaf16e 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
> > +++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> > @@ -228,6 +228,17 @@ config DWMAC_SUN8I
> >  	  stmmac device driver. This driver is used for H3/A83T/A64
> >  	  EMAC ethernet controller.
> >
> > +config DWMAC_THEAD
> > +	tristate "T-HEAD dwmac support"
> > +	depends on OF && (ARCH_THEAD || COMPILE_TEST)
> > +	select MFD_SYSCON
> > +	help
> > +	  Support for ethernet controllers on T-HEAD RISC-V SoCs
> > +
> > +	  This selects the T-HEAD platform specific glue layer support for
> > +	  the stmmac device driver. This driver is used for T-HEAD TH1520
> > +	  ethernet controller.
> > +
> >  config DWMAC_IMX8
> >  	tristate "NXP IMX8 DWMAC support"
> >  	default ARCH_MXC
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
> > index c2f0e91f6bf8..d065634c6223 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/Makefile
> > +++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
> > @@ -28,6 +28,7 @@ obj-$(CONFIG_DWMAC_STI)		+= dwmac-sti.o
> >  obj-$(CONFIG_DWMAC_STM32)	+= dwmac-stm32.o
> >  obj-$(CONFIG_DWMAC_SUNXI)	+= dwmac-sunxi.o
> >  obj-$(CONFIG_DWMAC_SUN8I)	+= dwmac-sun8i.o
> > +obj-$(CONFIG_DWMAC_THEAD)	+= dwmac-thead.o
> >  obj-$(CONFIG_DWMAC_DWC_QOS_ETH)	+= dwmac-dwc-qos-eth.o
> >  obj-$(CONFIG_DWMAC_INTEL_PLAT)	+= dwmac-intel-plat.o
> >  obj-$(CONFIG_DWMAC_LOONGSON1)	+= dwmac-loongson1.o
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
> > new file mode 100644
> > index 000000000000..f2f94539c0d2
> > --- /dev/null
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
> > @@ -0,0 +1,291 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * T-HEAD DWMAC platform driver
> > + *
> > + * Copyright (C) 2021 Alibaba Group Holding Limited.
> > + * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
> > + *
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +#include <linux/of_net.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +
> > +#include "stmmac_platform.h"
> > +
> > +#define GMAC_CLK_EN			0x00
> > +#define  GMAC_TX_CLK_EN			BIT(1)
> > +#define  GMAC_TX_CLK_N_EN		BIT(2)
> > +#define  GMAC_TX_CLK_OUT_EN		BIT(3)
> > +#define  GMAC_RX_CLK_EN			BIT(4)
> > +#define  GMAC_RX_CLK_N_EN		BIT(5)
> > +#define  GMAC_EPHY_REF_CLK_EN		BIT(6)
> > +#define GMAC_RXCLK_DELAY_CTRL		0x04
> > +#define  GMAC_RXCLK_BYPASS		BIT(15)
> > +#define  GMAC_RXCLK_INVERT		BIT(14)
> > +#define  GMAC_RXCLK_DELAY_MASK		GENMASK(4, 0)
> > +#define  GMAC_RXCLK_DELAY_VAL(x)	FIELD_PREP(GMAC_RXCLK_DELAY_MASK, (x))
> > +#define GMAC_TXCLK_DELAY_CTRL		0x08
> > +#define  GMAC_TXCLK_BYPASS		BIT(15)
> > +#define  GMAC_TXCLK_INVERT		BIT(14)
> > +#define  GMAC_TXCLK_DELAY_MASK		GENMASK(4, 0)
> > +#define  GMAC_TXCLK_DELAY_VAL(x)	FIELD_PREP(GMAC_RXCLK_DELAY_MASK, (x))
> > +#define GMAC_PLLCLK_DIV			0x0c
> > +#define  GMAC_PLLCLK_DIV_EN		BIT(31)
> > +#define  GMAC_PLLCLK_DIV_MASK		GENMASK(7, 0)
> > +#define  GMAC_PLLCLK_DIV_NUM(x)		FIELD_PREP(GMAC_PLLCLK_DIV_MASK, (x))
> > +#define GMAC_GTXCLK_SEL			0x18
> > +#define  GMAC_GTXCLK_SEL_PLL		BIT(0)
> > +#define GMAC_INTF_CTRL			0x1c
> > +#define  PHY_INTF_MASK			BIT(0)
> > +#define  PHY_INTF_RGMII			FIELD_PREP(PHY_INTF_MASK, 1)
> > +#define  PHY_INTF_MII_GMII		FIELD_PREP(PHY_INTF_MASK, 0)
> > +#define GMAC_TXCLK_OEN			0x20
> > +#define  TXCLK_DIR_MASK			BIT(0)
> > +#define  TXCLK_DIR_OUTPUT		FIELD_PREP(TXCLK_DIR_MASK, 0)
> > +#define  TXCLK_DIR_INPUT		FIELD_PREP(TXCLK_DIR_MASK, 1)
> > +
> > +#define GMAC_GMII_RGMII_RATE	125000000
> > +#define GMAC_MII_RATE		25000000
> > +
> > +static const struct regmap_config regmap_config = {
> > +	.reg_bits = 32,
> > +	.val_bits = 32,
> > +	.reg_stride = 4,
> > +};
> > +
> > +struct thead_dwmac {
> > +	struct plat_stmmacenet_data *plat;
> > +	struct regmap *apb_regmap;
> > +	struct device *dev;
> > +};
> > +
> > +static int thead_dwmac_set_phy_if(struct plat_stmmacenet_data *plat)
> > +{
> > +	struct thead_dwmac *dwmac = plat->bsp_priv;
> > +	u32 phyif;
> > +
> > +	switch (plat->mac_interface) {
> > +	case PHY_INTERFACE_MODE_MII:
> > +		phyif = PHY_INTF_MII_GMII;
> > +		break;
> > +	case PHY_INTERFACE_MODE_RGMII:
> > +	case PHY_INTERFACE_MODE_RGMII_ID:
> > +	case PHY_INTERFACE_MODE_RGMII_TXID:
> > +	case PHY_INTERFACE_MODE_RGMII_RXID:
> > +		phyif = PHY_INTF_RGMII;
> > +		break;
> > +	default:
> > +		dev_err(dwmac->dev, "unsupported phy interface %d\n",
> > +			plat->mac_interface);
> > +		return -EINVAL;
> > +	};
> > +
> > +	return regmap_write(dwmac->apb_regmap, GMAC_INTF_CTRL, phyif);
> > +}
> > +
> > +static int thead_dwmac_set_txclk_dir(struct plat_stmmacenet_data *plat)
> > +{
> > +	struct thead_dwmac *dwmac = plat->bsp_priv;
> > +	u32 txclk_dir;
> > +
> > +	switch (plat->mac_interface) {
> > +	case PHY_INTERFACE_MODE_MII:
> > +		txclk_dir = TXCLK_DIR_INPUT;
> > +		break;
> > +	case PHY_INTERFACE_MODE_RGMII:
> > +	case PHY_INTERFACE_MODE_RGMII_ID:
> > +	case PHY_INTERFACE_MODE_RGMII_TXID:
> > +	case PHY_INTERFACE_MODE_RGMII_RXID:
> > +		txclk_dir = TXCLK_DIR_OUTPUT;
> > +		break;
> > +	default:
> > +		dev_err(dwmac->dev, "unsupported phy interface %d\n",
> > +			plat->mac_interface);
> > +		return -EINVAL;
> > +	};
> > +
> > +	return regmap_write(dwmac->apb_regmap, GMAC_TXCLK_OEN, txclk_dir);
> > +}
> > +
> > +static void thead_dwmac_fix_speed(void *priv, unsigned int speed, unsigned int mode)
> > +{
> > +	struct plat_stmmacenet_data *plat;
> > +	struct thead_dwmac *dwmac = priv;
> > +	unsigned long rate;
> > +	u32 div;
> > +
> > +	plat = dwmac->plat;
> > +
> > +	switch (plat->mac_interface) {
> > +	/* For MII, rxc/txc is provided by phy */
> > +	case PHY_INTERFACE_MODE_MII:
> > +		return;
> > +
> > +	case PHY_INTERFACE_MODE_RGMII:
> > +	case PHY_INTERFACE_MODE_RGMII_ID:
> > +	case PHY_INTERFACE_MODE_RGMII_RXID:
> > +	case PHY_INTERFACE_MODE_RGMII_TXID:
> > +		rate = clk_get_rate(plat->stmmac_clk);
> > +		if (!rate || rate % GMAC_GMII_RGMII_RATE != 0 ||
> > +		    rate % GMAC_MII_RATE != 0) {
> > +			dev_err(dwmac->dev, "invalid gmac rate %ld\n", rate);
> > +			return;
> > +		}
> > +
> > +		regmap_update_bits(dwmac->apb_regmap, GMAC_PLLCLK_DIV, GMAC_PLLCLK_DIV_EN, 0);
> > +
> > +		switch (speed) {
> > +		case SPEED_1000:
> > +			div = rate / GMAC_GMII_RGMII_RATE;
> > +			break;
> > +		case SPEED_100:
> > +			div = rate / GMAC_MII_RATE;
> > +			break;
> > +		case SPEED_10:
> > +			div = rate * 10 / GMAC_MII_RATE;
> > +			break;
> > +		default:
> > +			dev_err(dwmac->dev, "invalid speed %u\n", speed);
> > +			return;
> > +		}
> > +		regmap_update_bits(dwmac->apb_regmap, GMAC_PLLCLK_DIV,
> > +				   GMAC_PLLCLK_DIV_MASK, GMAC_PLLCLK_DIV_NUM(div));
> > +
> > +		regmap_update_bits(dwmac->apb_regmap, GMAC_PLLCLK_DIV,
> > +				   GMAC_PLLCLK_DIV_EN, GMAC_PLLCLK_DIV_EN);
> > +		break;
> > +	default:
> > +		dev_err(dwmac->dev, "unsupported phy interface %d\n",
> > +			plat->mac_interface);
> > +		return;
> > +	}
> > +}
> > +
> > +static int thead_dwmac_enable_clk(struct plat_stmmacenet_data *plat)
> > +{
> > +	struct thead_dwmac *dwmac = plat->bsp_priv;
> > +	int err;
> > +	u32 reg;
> > +
> > +	switch (plat->mac_interface) {
> > +	case PHY_INTERFACE_MODE_MII:
> > +		reg = GMAC_RX_CLK_EN | GMAC_TX_CLK_EN;
> > +		break;
> > +
> > +	case PHY_INTERFACE_MODE_RGMII:
> > +	case PHY_INTERFACE_MODE_RGMII_ID:
> > +	case PHY_INTERFACE_MODE_RGMII_RXID:
> > +	case PHY_INTERFACE_MODE_RGMII_TXID:
> > +		/* use pll */
> > +		err = regmap_write(dwmac->apb_regmap, GMAC_GTXCLK_SEL, GMAC_GTXCLK_SEL_PLL);
> > +		if (err)
> > +			return dev_err_probe(dwmac->dev, err,
> > +					     "failed to set phy interface\n");
> > +
> > +		reg = GMAC_TX_CLK_EN | GMAC_TX_CLK_N_EN | GMAC_TX_CLK_OUT_EN |
> > +		      GMAC_RX_CLK_EN | GMAC_RX_CLK_N_EN;
> > +		break;
> > +
> > +	default:
> > +		dev_err(dwmac->dev, "unsupported phy interface %d\n",
> > +			plat->mac_interface);
> > +		return -EINVAL;
> > +	}
> > +
> > +	return regmap_write(dwmac->apb_regmap, GMAC_CLK_EN, reg);
> > +}
> > +
> > +static int thead_dwmac_init(struct platform_device *pdev, void *priv)
> > +{
> > +	struct thead_dwmac *dwmac = priv;
> > +	int ret;
> > +
> > +	ret = thead_dwmac_set_phy_if(dwmac->plat);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = thead_dwmac_set_txclk_dir(dwmac->plat);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = regmap_write(dwmac->apb_regmap, GMAC_RXCLK_DELAY_CTRL,
> > +			   GMAC_RXCLK_DELAY_VAL(0));
> > +	if (ret)
> > +		return dev_err_probe(dwmac->dev, ret,
> > +				     "failed to set GMAC RX clock delay\n");
> > +
> > +	ret = regmap_write(dwmac->apb_regmap, GMAC_TXCLK_DELAY_CTRL,
> > +			   GMAC_TXCLK_DELAY_VAL(0));
> > +	if (ret)
> > +		return dev_err_probe(dwmac->dev, ret,
> > +				     "failed to set GMAC TX clock delay\n");
> > +
> > +	return thead_dwmac_enable_clk(dwmac->plat);
> > +}
> > +
> > +static int thead_dwmac_probe(struct platform_device *pdev)
> > +{
> > +	struct stmmac_resources stmmac_res;
> > +	struct plat_stmmacenet_data *plat;
> > +	struct thead_dwmac *dwmac;
> > +	void __iomem *apb;
> > +	int ret;
> > +
> > +	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
> > +	if (ret)
> > +		return dev_err_probe(&pdev->dev, ret,
> > +				     "failed to get resources\n");
> > +
> > +	plat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
> > +	if (IS_ERR(plat))
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(plat),
> > +				     "dt configuration failed\n");
> > +
> > +	dwmac = devm_kzalloc(&pdev->dev, sizeof(*dwmac), GFP_KERNEL);
> > +	if (!dwmac)
> > +		return -ENOMEM;
> > +
> > +	apb = devm_platform_ioremap_resource(pdev, 1);
> > +	if (IS_ERR(apb))
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(apb),
> > +				     "Failed to remap gmac apb registers\n");
> > +
> > +	dwmac->apb_regmap = devm_regmap_init_mmio(&pdev->dev, apb, &regmap_config);
> > +	if (IS_ERR(dwmac->apb_regmap))
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(dwmac->apb_regmap),
> > +				     "Failed to access gmac apb registers\n");
> 
> Why do you need to convert the APB range to a regmap? As far as I can tell it's
> just regular 32bit memory mapped registers, so should work fine with just
> readl()/writel()

Good point, I don't think there is any benefit to using regmap. I will
change the next revision to use writel() instead. I just tested this and
the network interface still works okay.

Thanks,
Drew

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
index f2f94539c0d2..df2fe0fdd128 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
@@ -13,7 +13,6 @@
 #include <linux/of_device.h>
 #include <linux/of_net.h>
 #include <linux/platform_device.h>
-#include <linux/regmap.h>
 
 #include "stmmac_platform.h"
 
@@ -52,15 +51,9 @@
 #define GMAC_GMII_RGMII_RATE	125000000
 #define GMAC_MII_RATE		25000000
 
-static const struct regmap_config regmap_config = {
-	.reg_bits = 32,
-	.val_bits = 32,
-	.reg_stride = 4,
-};
-
 struct thead_dwmac {
 	struct plat_stmmacenet_data *plat;
-	struct regmap *apb_regmap;
+	void __iomem *apb_base;
 	struct device *dev;
 };
 
@@ -85,7 +78,8 @@ static int thead_dwmac_set_phy_if(struct plat_stmmacenet_data *plat)
 		return -EINVAL;
 	};
 
-	return regmap_write(dwmac->apb_regmap, GMAC_INTF_CTRL, phyif);
+	writel(phyif, dwmac->apb_base + GMAC_INTF_CTRL);
+	return 0;
 }
 
 static int thead_dwmac_set_txclk_dir(struct plat_stmmacenet_data *plat)
@@ -109,7 +103,8 @@ static int thead_dwmac_set_txclk_dir(struct plat_stmmacenet_data *plat)
 		return -EINVAL;
 	};
 
-	return regmap_write(dwmac->apb_regmap, GMAC_TXCLK_OEN, txclk_dir);
+	writel(txclk_dir, dwmac->apb_base + GMAC_TXCLK_OEN);
+	return 0;
 }
 
 static void thead_dwmac_fix_speed(void *priv, unsigned int speed, unsigned int mode)
@@ -117,7 +112,7 @@ static void thead_dwmac_fix_speed(void *priv, unsigned int speed, unsigned int m
 	struct plat_stmmacenet_data *plat;
 	struct thead_dwmac *dwmac = priv;
 	unsigned long rate;
-	u32 div;
+	u32 div, reg;
 
 	plat = dwmac->plat;
 
@@ -137,7 +132,7 @@ static void thead_dwmac_fix_speed(void *priv, unsigned int speed, unsigned int m
 			return;
 		}
 
-		regmap_update_bits(dwmac->apb_regmap, GMAC_PLLCLK_DIV, GMAC_PLLCLK_DIV_EN, 0);
+		writel(FIELD_PREP(GMAC_PLLCLK_DIV_EN, 0), dwmac->apb_base + GMAC_PLLCLK_DIV);
 
 		switch (speed) {
 		case SPEED_1000:
@@ -153,11 +148,10 @@ static void thead_dwmac_fix_speed(void *priv, unsigned int speed, unsigned int m
 			dev_err(dwmac->dev, "invalid speed %u\n", speed);
 			return;
 		}
-		regmap_update_bits(dwmac->apb_regmap, GMAC_PLLCLK_DIV,
-				   GMAC_PLLCLK_DIV_MASK, GMAC_PLLCLK_DIV_NUM(div));
 
-		regmap_update_bits(dwmac->apb_regmap, GMAC_PLLCLK_DIV,
-				   GMAC_PLLCLK_DIV_EN, GMAC_PLLCLK_DIV_EN);
+		reg = FIELD_PREP(GMAC_PLLCLK_DIV_EN, 1) |
+		      FIELD_PREP(GMAC_PLLCLK_DIV_MASK, GMAC_PLLCLK_DIV_NUM(div));
+		writel(reg, dwmac->apb_base + GMAC_PLLCLK_DIV);
 		break;
 	default:
 		dev_err(dwmac->dev, "unsupported phy interface %d\n",
@@ -169,7 +163,6 @@ static void thead_dwmac_fix_speed(void *priv, unsigned int speed, unsigned int m
 static int thead_dwmac_enable_clk(struct plat_stmmacenet_data *plat)
 {
 	struct thead_dwmac *dwmac = plat->bsp_priv;
-	int err;
 	u32 reg;
 
 	switch (plat->mac_interface) {
@@ -182,11 +175,7 @@ static int thead_dwmac_enable_clk(struct plat_stmmacenet_data *plat)
 	case PHY_INTERFACE_MODE_RGMII_RXID:
 	case PHY_INTERFACE_MODE_RGMII_TXID:
 		/* use pll */
-		err = regmap_write(dwmac->apb_regmap, GMAC_GTXCLK_SEL, GMAC_GTXCLK_SEL_PLL);
-		if (err)
-			return dev_err_probe(dwmac->dev, err,
-					     "failed to set phy interface\n");
-
+		writel(GMAC_GTXCLK_SEL_PLL, dwmac->apb_base + GMAC_GTXCLK_SEL);
 		reg = GMAC_TX_CLK_EN | GMAC_TX_CLK_N_EN | GMAC_TX_CLK_OUT_EN |
 		      GMAC_RX_CLK_EN | GMAC_RX_CLK_N_EN;
 		break;
@@ -197,7 +186,8 @@ static int thead_dwmac_enable_clk(struct plat_stmmacenet_data *plat)
 		return -EINVAL;
 	}
 
-	return regmap_write(dwmac->apb_regmap, GMAC_CLK_EN, reg);
+	writel(reg, dwmac->apb_base + GMAC_CLK_EN);
+	return 0;
 }
 
 static int thead_dwmac_init(struct platform_device *pdev, void *priv)
@@ -213,17 +203,8 @@ static int thead_dwmac_init(struct platform_device *pdev, void *priv)
 	if (ret)
 		return ret;
 
-	ret = regmap_write(dwmac->apb_regmap, GMAC_RXCLK_DELAY_CTRL,
-			   GMAC_RXCLK_DELAY_VAL(0));
-	if (ret)
-		return dev_err_probe(dwmac->dev, ret,
-				     "failed to set GMAC RX clock delay\n");
-
-	ret = regmap_write(dwmac->apb_regmap, GMAC_TXCLK_DELAY_CTRL,
-			   GMAC_TXCLK_DELAY_VAL(0));
-	if (ret)
-		return dev_err_probe(dwmac->dev, ret,
-				     "failed to set GMAC TX clock delay\n");
+	writel(GMAC_RXCLK_DELAY_VAL(0), dwmac->apb_base + GMAC_RXCLK_DELAY_CTRL);
+	writel(GMAC_TXCLK_DELAY_VAL(0), dwmac->apb_base + GMAC_TXCLK_DELAY_CTRL);
 
 	return thead_dwmac_enable_clk(dwmac->plat);
 }
@@ -255,13 +236,9 @@ static int thead_dwmac_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(apb),
 				     "Failed to remap gmac apb registers\n");
 
-	dwmac->apb_regmap = devm_regmap_init_mmio(&pdev->dev, apb, &regmap_config);
-	if (IS_ERR(dwmac->apb_regmap))
-		return dev_err_probe(&pdev->dev, PTR_ERR(dwmac->apb_regmap),
-				     "Failed to access gmac apb registers\n");
-
 	dwmac->dev = &pdev->dev;
 	dwmac->plat = plat;
+	dwmac->apb_base = apb;
 	plat->bsp_priv = dwmac;
 	plat->fix_mac_speed = thead_dwmac_fix_speed;
 	plat->init = thead_dwmac_init;

