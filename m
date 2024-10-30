Return-Path: <netdev+bounces-140505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B02709B6A36
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 18:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C3AB1F213BB
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 17:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F75219C9A;
	Wed, 30 Oct 2024 16:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="Yl4o9Ji3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3136219482
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 16:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730307483; cv=none; b=eo+u29l2VDlooTUnd7f/pSiTDwvBfkGMM8X4EgOKrUitTre7cSkM2VWRepdk3eBVs1sTTWAV1BS5xMqTT5DDIbYTX9jac8YrFcC6xQNIspPuM5hQocd2u4EQdYJPH15VMutOi1wOHsIDzgNTxq5OnVjICwBQCCfYq2MMcah6Xcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730307483; c=relaxed/simple;
	bh=neXwPuNY2JHIeFvsve5uZTtDulaRq/OAudJCQheeq6Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nuyC7a6Ls7S0hgqHihS2J7CcxhQJH2/QXH2mt+GD5u7cZxd1PsGfvLyYDd05dFz2kR44BUmfRVXEHjFjLKZdNBl3mZBKY/fRQu17tVmESmsq1Q8YCpXJ+FiuEY/ncUaLw3YAN3LqGuvyZdlciBvk77aK7JsvgZapXjCQeHm1hgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=Yl4o9Ji3; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71ec12160f6so10794b3a.3
        for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 09:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1730307480; x=1730912280; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SQIDvZHJLlv2NnA/L5KGhQzE00s+QY4xZ6sZqZZ0iZs=;
        b=Yl4o9Ji3rpalIq03Ki+eDNCQpi3pIGjFYLgA9rRywR6k/xO43XkCEqBdu5gWVWPe20
         bPdeawlrdsg50THNGrqGLcKWmEQ0o6qnryjyCPoTHZ/PQe45NGYpJgTfn4vVtn8/BUW+
         0Rzp2O+gkrVB0gwULyoZELGFPKi2zryPq8Dq0bjgzrCIRNYXVTtPPFmVINTwdF/NnkBH
         sVxQzmOTB0O2SRS1rmA1iXWYej1w37Le3HkmHtFrfKJ9qcAaOFru/eImcW935t9PIbhD
         8Rx+L3a2H/7PvHmyrHV4IqfHBK9cK7mR7AZZo1ON7fMS3I7YeMIohJdgLrGbS0Yqqxb4
         QAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730307480; x=1730912280;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQIDvZHJLlv2NnA/L5KGhQzE00s+QY4xZ6sZqZZ0iZs=;
        b=IYLg3S4wx3A3gMS+i9YFlgmbc42k7C492D1q9kbgtRMfZYnGVq6PQAXLvUy2UPXpNi
         u4wuzjRmyosXoDFHqRHG9syBID1eumXm0ofXP3jsy0T6MTlsNKRmOouIEtQpIYEZKvP8
         O056I9V+KmZb6RjJ4NhLohVrGI92aih+n9WRLni10bd95Po7pER6v2lPbT2bnKv5jKid
         stzMsWCngEdEjgChDMqw7oKg9jvdHbXKbrEZ1P8Tsbw6wsWjom+TQDBa/RYzJusl3QoO
         cMjL32PQkzyKmxMkaJpOXbd1jqFKr68BZK1lYqkqDCDhygttPJse7rxceYb84aW3hO9X
         pK2Q==
X-Gm-Message-State: AOJu0YzF4N5Z1dCw9Q2ShoGduQz7qtlv2Syy3cHRAYasoUBkxFpQaG12
	USXgwqd490JpPo0MMYuBVpe8pbPUvU4ADLsf+pwDTwQfVsZZLSOvHof8lyjHTDw=
X-Google-Smtp-Source: AGHT+IFendjYryfYbhHPdbJiPH50n2zYBYX/Re9V2bpl5NUL9VcmlaAud6ZDSSBB5Y1WnNz8vlj0fg==
X-Received: by 2002:a05:6a00:1892:b0:71e:4c20:75fc with SMTP id d2e1a72fcca58-72062f67d62mr23111941b3a.10.1730307479822;
        Wed, 30 Oct 2024 09:57:59 -0700 (PDT)
Received: from [127.0.1.1] (71-34-69-82.ptld.qwest.net. [71.34.69.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a1f1ddsm9810776b3a.149.2024.10.30.09.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 09:57:59 -0700 (PDT)
From: Drew Fustini <dfustini@tenstorrent.com>
Date: Wed, 30 Oct 2024 09:57:45 -0700
Subject: [PATCH net-next v6 2/2] net: stmmac: Add glue layer for T-HEAD
 TH1520 SoC
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241030-th1520-gmac-v6-2-e48176d45116@tenstorrent.com>
References: <20241030-th1520-gmac-v6-0-e48176d45116@tenstorrent.com>
In-Reply-To: <20241030-th1520-gmac-v6-0-e48176d45116@tenstorrent.com>
To: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Jose Abreu <joabreu@synopsys.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Drew Fustini <drew@pdp7.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-riscv@lists.infradead.org, Drew Fustini <dfustini@tenstorrent.com>, 
 linux-stm32@st-md-mailman.stormreply.com
X-Mailer: b4 0.14.1

From: Jisheng Zhang <jszhang@kernel.org>

Add dwmac glue driver to support the DesignWare-based GMAC controllers
on the T-HEAD TH1520 SoC.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
[esmil: rename plat->interface -> plat->mac_interface,
        use devm_stmmac_probe_config_dt()]
Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
[drew: convert from stmmac_dvr_probe() to devm_stmmac_pltfr_probe(),
       convert register access from regmap to regular mmio]
Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
---
 MAINTAINERS                                       |   1 +
 drivers/net/ethernet/stmicro/stmmac/Kconfig       |  10 +
 drivers/net/ethernet/stmicro/stmmac/Makefile      |   1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c | 268 ++++++++++++++++++++++
 4 files changed, 280 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 72dee6d07ced..b53f9f6b3e04 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19830,6 +19830,7 @@ F:	Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
 F:	Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml
 F:	arch/riscv/boot/dts/thead/
 F:	drivers/clk/thead/clk-th1520-ap.c
+F:	drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
 F:	include/dt-bindings/clock/thead,th1520-clk-ap.h
 
 RNBD BLOCK DRIVERS
diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index 05cc07b8f48c..6658536a4e17 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -228,6 +228,16 @@ config DWMAC_SUN8I
 	  stmmac device driver. This driver is used for H3/A83T/A64
 	  EMAC ethernet controller.
 
+config DWMAC_THEAD
+	tristate "T-HEAD dwmac support"
+	depends on OF && (ARCH_THEAD || COMPILE_TEST)
+	help
+	  Support for ethernet controllers on T-HEAD RISC-V SoCs
+
+	  This selects the T-HEAD platform specific glue layer support for
+	  the stmmac device driver. This driver is used for T-HEAD TH1520
+	  ethernet controller.
+
 config DWMAC_IMX8
 	tristate "NXP IMX8 DWMAC support"
 	default ARCH_MXC
diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
index c2f0e91f6bf8..d065634c6223 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Makefile
+++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_DWMAC_STI)		+= dwmac-sti.o
 obj-$(CONFIG_DWMAC_STM32)	+= dwmac-stm32.o
 obj-$(CONFIG_DWMAC_SUNXI)	+= dwmac-sunxi.o
 obj-$(CONFIG_DWMAC_SUN8I)	+= dwmac-sun8i.o
+obj-$(CONFIG_DWMAC_THEAD)	+= dwmac-thead.o
 obj-$(CONFIG_DWMAC_DWC_QOS_ETH)	+= dwmac-dwc-qos-eth.o
 obj-$(CONFIG_DWMAC_INTEL_PLAT)	+= dwmac-intel-plat.o
 obj-$(CONFIG_DWMAC_LOONGSON1)	+= dwmac-loongson1.o
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
new file mode 100644
index 000000000000..8c7ec156ebb0
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
@@ -0,0 +1,268 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * T-HEAD DWMAC platform driver
+ *
+ * Copyright (C) 2021 Alibaba Group Holding Limited.
+ * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
+ *
+ */
+
+#include <linux/bitfield.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_net.h>
+#include <linux/platform_device.h>
+
+#include "stmmac_platform.h"
+
+#define GMAC_CLK_EN			0x00
+#define  GMAC_TX_CLK_EN			BIT(1)
+#define  GMAC_TX_CLK_N_EN		BIT(2)
+#define  GMAC_TX_CLK_OUT_EN		BIT(3)
+#define  GMAC_RX_CLK_EN			BIT(4)
+#define  GMAC_RX_CLK_N_EN		BIT(5)
+#define  GMAC_EPHY_REF_CLK_EN		BIT(6)
+#define GMAC_RXCLK_DELAY_CTRL		0x04
+#define  GMAC_RXCLK_BYPASS		BIT(15)
+#define  GMAC_RXCLK_INVERT		BIT(14)
+#define  GMAC_RXCLK_DELAY_MASK		GENMASK(4, 0)
+#define  GMAC_RXCLK_DELAY_VAL(x)	FIELD_PREP(GMAC_RXCLK_DELAY_MASK, (x))
+#define GMAC_TXCLK_DELAY_CTRL		0x08
+#define  GMAC_TXCLK_BYPASS		BIT(15)
+#define  GMAC_TXCLK_INVERT		BIT(14)
+#define  GMAC_TXCLK_DELAY_MASK		GENMASK(4, 0)
+#define  GMAC_TXCLK_DELAY_VAL(x)	FIELD_PREP(GMAC_RXCLK_DELAY_MASK, (x))
+#define GMAC_PLLCLK_DIV			0x0c
+#define  GMAC_PLLCLK_DIV_EN		BIT(31)
+#define  GMAC_PLLCLK_DIV_MASK		GENMASK(7, 0)
+#define  GMAC_PLLCLK_DIV_NUM(x)		FIELD_PREP(GMAC_PLLCLK_DIV_MASK, (x))
+#define GMAC_GTXCLK_SEL			0x18
+#define  GMAC_GTXCLK_SEL_PLL		BIT(0)
+#define GMAC_INTF_CTRL			0x1c
+#define  PHY_INTF_MASK			BIT(0)
+#define  PHY_INTF_RGMII			FIELD_PREP(PHY_INTF_MASK, 1)
+#define  PHY_INTF_MII_GMII		FIELD_PREP(PHY_INTF_MASK, 0)
+#define GMAC_TXCLK_OEN			0x20
+#define  TXCLK_DIR_MASK			BIT(0)
+#define  TXCLK_DIR_OUTPUT		FIELD_PREP(TXCLK_DIR_MASK, 0)
+#define  TXCLK_DIR_INPUT		FIELD_PREP(TXCLK_DIR_MASK, 1)
+
+#define GMAC_GMII_RGMII_RATE	125000000
+#define GMAC_MII_RATE		25000000
+
+struct thead_dwmac {
+	struct plat_stmmacenet_data *plat;
+	void __iomem *apb_base;
+	struct device *dev;
+};
+
+static int thead_dwmac_set_phy_if(struct plat_stmmacenet_data *plat)
+{
+	struct thead_dwmac *dwmac = plat->bsp_priv;
+	u32 phyif;
+
+	switch (plat->mac_interface) {
+	case PHY_INTERFACE_MODE_MII:
+		phyif = PHY_INTF_MII_GMII;
+		break;
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+		phyif = PHY_INTF_RGMII;
+		break;
+	default:
+		dev_err(dwmac->dev, "unsupported phy interface %d\n",
+			plat->mac_interface);
+		return -EINVAL;
+	}
+
+	writel(phyif, dwmac->apb_base + GMAC_INTF_CTRL);
+	return 0;
+}
+
+static int thead_dwmac_set_txclk_dir(struct plat_stmmacenet_data *plat)
+{
+	struct thead_dwmac *dwmac = plat->bsp_priv;
+	u32 txclk_dir;
+
+	switch (plat->mac_interface) {
+	case PHY_INTERFACE_MODE_MII:
+		txclk_dir = TXCLK_DIR_INPUT;
+		break;
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+		txclk_dir = TXCLK_DIR_OUTPUT;
+		break;
+	default:
+		dev_err(dwmac->dev, "unsupported phy interface %d\n",
+			plat->mac_interface);
+		return -EINVAL;
+	}
+
+	writel(txclk_dir, dwmac->apb_base + GMAC_TXCLK_OEN);
+	return 0;
+}
+
+static void thead_dwmac_fix_speed(void *priv, unsigned int speed, unsigned int mode)
+{
+	struct plat_stmmacenet_data *plat;
+	struct thead_dwmac *dwmac = priv;
+	unsigned long rate;
+	u32 div, reg;
+
+	plat = dwmac->plat;
+
+	switch (plat->mac_interface) {
+	/* For MII, rxc/txc is provided by phy */
+	case PHY_INTERFACE_MODE_MII:
+		return;
+
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		rate = clk_get_rate(plat->stmmac_clk);
+		if (!rate || rate % GMAC_GMII_RGMII_RATE != 0 ||
+		    rate % GMAC_MII_RATE != 0) {
+			dev_err(dwmac->dev, "invalid gmac rate %ld\n", rate);
+			return;
+		}
+
+		writel(FIELD_PREP(GMAC_PLLCLK_DIV_EN, 0), dwmac->apb_base + GMAC_PLLCLK_DIV);
+
+		switch (speed) {
+		case SPEED_1000:
+			div = rate / GMAC_GMII_RGMII_RATE;
+			break;
+		case SPEED_100:
+			div = rate / GMAC_MII_RATE;
+			break;
+		case SPEED_10:
+			div = rate * 10 / GMAC_MII_RATE;
+			break;
+		default:
+			dev_err(dwmac->dev, "invalid speed %u\n", speed);
+			return;
+		}
+
+		reg = FIELD_PREP(GMAC_PLLCLK_DIV_EN, 1) |
+		      FIELD_PREP(GMAC_PLLCLK_DIV_MASK, GMAC_PLLCLK_DIV_NUM(div));
+		writel(reg, dwmac->apb_base + GMAC_PLLCLK_DIV);
+		break;
+	default:
+		dev_err(dwmac->dev, "unsupported phy interface %d\n",
+			plat->mac_interface);
+		return;
+	}
+}
+
+static int thead_dwmac_enable_clk(struct plat_stmmacenet_data *plat)
+{
+	struct thead_dwmac *dwmac = plat->bsp_priv;
+	u32 reg;
+
+	switch (plat->mac_interface) {
+	case PHY_INTERFACE_MODE_MII:
+		reg = GMAC_RX_CLK_EN | GMAC_TX_CLK_EN;
+		break;
+
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		/* use pll */
+		writel(GMAC_GTXCLK_SEL_PLL, dwmac->apb_base + GMAC_GTXCLK_SEL);
+		reg = GMAC_TX_CLK_EN | GMAC_TX_CLK_N_EN | GMAC_TX_CLK_OUT_EN |
+		      GMAC_RX_CLK_EN | GMAC_RX_CLK_N_EN;
+		break;
+
+	default:
+		dev_err(dwmac->dev, "unsupported phy interface %d\n",
+			plat->mac_interface);
+		return -EINVAL;
+	}
+
+	writel(reg, dwmac->apb_base + GMAC_CLK_EN);
+	return 0;
+}
+
+static int thead_dwmac_init(struct platform_device *pdev, void *priv)
+{
+	struct thead_dwmac *dwmac = priv;
+	int ret;
+
+	ret = thead_dwmac_set_phy_if(dwmac->plat);
+	if (ret)
+		return ret;
+
+	ret = thead_dwmac_set_txclk_dir(dwmac->plat);
+	if (ret)
+		return ret;
+
+	writel(GMAC_RXCLK_DELAY_VAL(0), dwmac->apb_base + GMAC_RXCLK_DELAY_CTRL);
+	writel(GMAC_TXCLK_DELAY_VAL(0), dwmac->apb_base + GMAC_TXCLK_DELAY_CTRL);
+
+	return thead_dwmac_enable_clk(dwmac->plat);
+}
+
+static int thead_dwmac_probe(struct platform_device *pdev)
+{
+	struct stmmac_resources stmmac_res;
+	struct plat_stmmacenet_data *plat;
+	struct thead_dwmac *dwmac;
+	void __iomem *apb;
+	int ret;
+
+	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to get resources\n");
+
+	plat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	if (IS_ERR(plat))
+		return dev_err_probe(&pdev->dev, PTR_ERR(plat),
+				     "dt configuration failed\n");
+
+	dwmac = devm_kzalloc(&pdev->dev, sizeof(*dwmac), GFP_KERNEL);
+	if (!dwmac)
+		return -ENOMEM;
+
+	apb = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(apb))
+		return dev_err_probe(&pdev->dev, PTR_ERR(apb),
+				     "Failed to remap gmac apb registers\n");
+
+	dwmac->dev = &pdev->dev;
+	dwmac->plat = plat;
+	dwmac->apb_base = apb;
+	plat->bsp_priv = dwmac;
+	plat->fix_mac_speed = thead_dwmac_fix_speed;
+	plat->init = thead_dwmac_init;
+
+	return devm_stmmac_pltfr_probe(pdev, plat, &stmmac_res);
+}
+
+static const struct of_device_id thead_dwmac_match[] = {
+	{ .compatible = "thead,th1520-gmac" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, thead_dwmac_match);
+
+static struct platform_driver thead_dwmac_driver = {
+	.probe = thead_dwmac_probe,
+	.driver = {
+		.name = "thead-dwmac",
+		.pm = &stmmac_pltfr_pm_ops,
+		.of_match_table = thead_dwmac_match,
+	},
+};
+module_platform_driver(thead_dwmac_driver);
+
+MODULE_AUTHOR("Jisheng Zhang <jszhang@kernel.org>");
+MODULE_AUTHOR("Drew Fustini <drew@pdp7.com>");
+MODULE_DESCRIPTION("T-HEAD DWMAC platform driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1


