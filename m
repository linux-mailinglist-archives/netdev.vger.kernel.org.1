Return-Path: <netdev+bounces-111292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8179307C5
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 00:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70442283010
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 22:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8B216F8E3;
	Sat, 13 Jul 2024 22:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b="GAsE3pfg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6507216D320
	for <netdev@vger.kernel.org>; Sat, 13 Jul 2024 22:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720910129; cv=none; b=d2wHX0S9/NZFjUHQKlG94ZkF1T/pQKhvZi4yfrUMzu6OyESO2h1eJb/7KNJ3MifbxqswlbILekDe0YNnqw46rm6J4nw+i8SxbDskqW8q0QVl4g1GKSBZ5HAxQHK+h1SNOWpialNcuNk/4zK03PkZf9zWQ3U1pH+JO1FW666RM1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720910129; c=relaxed/simple;
	bh=tdE5R90K36VC2kxTvGtxPVa23iCMoWWcby052N0PlRw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FhWdJTighPd+a5KlYFTOUPGv/9Ah60ONf6pGAiSahgcI6fjssJJoR+9/6kfDmFDe54PRmxn89FZnWyCx+QCKdx2wuNP8pg3xgVEej4lx2CXhvB+QNvHwhQ2TbRT126bmdFG8PIUjntzToslVoDdIXREseRskEgRFtdpJIf+4pTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com; spf=none smtp.mailfrom=pdp7.com; dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b=GAsE3pfg; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pdp7.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7035d5eec5aso1592121a34.1
        for <netdev@vger.kernel.org>; Sat, 13 Jul 2024 15:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20230601.gappssmtp.com; s=20230601; t=1720910125; x=1721514925; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KxcXi7NdNekPLYVDwNRh//Z2yxL04R6rwZHieCVOn5A=;
        b=GAsE3pfgrx4oHrqhNONQ0R5HHSM7yCdConBLw3IbUslbSUZTqGbjcgdaLD2UE/FCC/
         obOw/yi/W5iY9ruJsYyemQ9ROIh2KBElRpO1+03IfWQHcE+D7OsaPYSNw175+cYU2T2d
         bmEik3em5y7d0aApFYKRy4ATAvkBKVA1yIxzY3EuNRjrGL/0DYllmginVzSLmNi7SLuU
         64nGZgAJSveGv1k2U3lMrzQBg9TUcyVqTb7oUrnj88/IwFcwDzT5f4TV0EoRrUMN9Q+h
         70btlmkkptbTPwdHCc+cHFNgKcG70nV1WhVO0AaIimXGaHk9/SrtyzRFBRbTSQFCXM9Z
         M++A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720910125; x=1721514925;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KxcXi7NdNekPLYVDwNRh//Z2yxL04R6rwZHieCVOn5A=;
        b=hI1Uun/WwZKBd7l0plzSq6qSNWF/ZQWi5CKgsyhASpP5ZygW5klO4gxUd9vTOjfsVt
         BqmV6eOEjywbnmdigxWV2KW2SLEXoHES4htSQPZPwX87vRzNuQWw7lPSMbp9UHhAqzpw
         RaJVFgItjaPPoMieN2kcn7AEsDPMSlZYLXJwVbR2RTux/JTXNiphChMSKNAVPUubxrZ6
         Kai1NPe4Ygu0V6yLLZuTx0Tn6CrPzsQgDLgLR7GHvkqyQ6FdjKFqIZFP3txRs5rnntMK
         0UcTOPpyy7A7Ua2VLs4gWvX5dEWFNefQ9b2qeFAtSva4m+hT1NKrPh4wWTxfSFWjH7nb
         BkLw==
X-Gm-Message-State: AOJu0YwN6lWLsWIPbMXf5oV9q96f7G5oXwrsbTHT6CvFRqEZZvQKfLJp
	Kzldeni7Jwy+PFS8C4wqCuOX+gJ8kydp87VOAQC1qDXpV2HX8ymjETNR93bI014=
X-Google-Smtp-Source: AGHT+IGC6e6E4K6/IAZSwMYQqIInqL2PX4aVPcqzv6ekRwJScTIvLtBEafckxBXBT3eQrxK7SURAkA==
X-Received: by 2002:a05:6808:189b:b0:3d9:2b15:65d4 with SMTP id 5614622812f47-3d93c01937bmr17474047b6e.21.1720910125460;
        Sat, 13 Jul 2024 15:35:25 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1802:170:d7fc:57d0:ada6:13b7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc4d9d8sm14640025ad.264.2024.07.13.15.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 15:35:25 -0700 (PDT)
From: Drew Fustini <drew@pdp7.com>
Date: Sat, 13 Jul 2024 15:35:12 -0700
Subject: [PATCH RFC net-next 3/4] net: stmmac: add glue layer for T-HEAD
 TH1520 SoC
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240713-thead-dwmac-v1-3-81f04480cd31@tenstorrent.com>
References: <20240713-thead-dwmac-v1-0-81f04480cd31@tenstorrent.com>
In-Reply-To: <20240713-thead-dwmac-v1-0-81f04480cd31@tenstorrent.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Jose Abreu <joabreu@synopsys.com>, Jisheng Zhang <jszhang@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, Conor Dooley <conor@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720910119; l=11652;
 i=dfustini@tenstorrent.com; s=20230430; h=from:subject:message-id;
 bh=E3AC2G47Ix6UzDcEHy3fI7MDOIXOWOddF4EcXRil+6w=;
 b=elEsSv8/lccNPQbHia9lGD4uvQZFjLjPAAphiARVOcr+eKdlEEgWdBPpp39/Auusjasbg4+s1
 9JtIZk8LXAaBw1etvRt+vQzUzhAp5o0eCfKGACDGRlsrJg9dG6kCW/e
X-Developer-Key: i=dfustini@tenstorrent.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=

From: Jisheng Zhang <jszhang@kernel.org>

Add dwmac glue driver to support the dwmac on the T-HEAD TH1520 SoC.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Link: https://lore.kernel.org/r/20230827091710.1483-4-jszhang@kernel.org
[esmil: rename plat->interface -> plat->mac_interface,
        use devm_stmmac_probe_config_dt()]
Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
[drew: change apb registers from syscon to second reg of gmac node]
Signed-off-by: Drew Fustini <drew@pdp7.com>
---
 MAINTAINERS                                       |   1 +
 drivers/net/ethernet/stmicro/stmmac/Kconfig       |  11 +
 drivers/net/ethernet/stmicro/stmmac/Makefile      |   1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c | 300 ++++++++++++++++++++++
 4 files changed, 313 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c724c2c4e06c..11fc14e406c4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19322,6 +19322,7 @@ F:	Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
 F:	Documentation/devicetree/bindings/net/thead,dwmac.yaml
 F:	arch/riscv/boot/dts/thead/
 F:	drivers/clk/thead/clk-th1520-ap.c
+F:	drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
 F:	include/dt-bindings/clock/thead,th1520-clk-ap.h
 F:	drivers/pinctrl/pinctrl-th1520.c
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index 05cc07b8f48c..82030adaf16e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -228,6 +228,17 @@ config DWMAC_SUN8I
 	  stmmac device driver. This driver is used for H3/A83T/A64
 	  EMAC ethernet controller.
 
+config DWMAC_THEAD
+	tristate "T-HEAD dwmac support"
+	depends on OF && (ARCH_THEAD || COMPILE_TEST)
+	select MFD_SYSCON
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
index 000000000000..809e75dc51d5
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
@@ -0,0 +1,300 @@
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
+#include <linux/regmap.h>
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
+static const struct regmap_config regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+};
+
+struct thead_dwmac {
+	struct plat_stmmacenet_data *plat;
+	struct regmap *apb_regmap;
+	struct device *dev;
+	u32 rx_delay;
+	u32 tx_delay;
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
+	};
+
+	regmap_write(dwmac->apb_regmap, GMAC_INTF_CTRL, phyif);
+
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
+	};
+
+	regmap_write(dwmac->apb_regmap, GMAC_TXCLK_OEN, txclk_dir);
+
+	return 0;
+}
+
+static void thead_dwmac_fix_speed(void *priv, unsigned int speed, unsigned int mode)
+{
+	struct thead_dwmac *dwmac = priv;
+	struct plat_stmmacenet_data *plat = dwmac->plat;
+	unsigned long rate;
+	u32 div;
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
+		regmap_update_bits(dwmac->apb_regmap, GMAC_PLLCLK_DIV, GMAC_PLLCLK_DIV_EN, 0);
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
+		regmap_update_bits(dwmac->apb_regmap, GMAC_PLLCLK_DIV,
+				   GMAC_PLLCLK_DIV_MASK, GMAC_PLLCLK_DIV_NUM(div));
+
+		regmap_update_bits(dwmac->apb_regmap, GMAC_PLLCLK_DIV,
+				   GMAC_PLLCLK_DIV_EN, GMAC_PLLCLK_DIV_EN);
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
+		regmap_write(dwmac->apb_regmap, GMAC_GTXCLK_SEL, GMAC_GTXCLK_SEL_PLL);
+
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
+	regmap_write(dwmac->apb_regmap, GMAC_CLK_EN, reg);
+
+	return 0;
+}
+
+static int thead_dwmac_init(struct platform_device *pdev,
+			    struct plat_stmmacenet_data *plat)
+{
+	struct thead_dwmac *dwmac = plat->bsp_priv;
+	int ret;
+
+	ret = thead_dwmac_set_phy_if(plat);
+	if (ret)
+		return ret;
+
+	ret = thead_dwmac_set_txclk_dir(plat);
+	if (ret)
+		return ret;
+
+	regmap_write(dwmac->apb_regmap, GMAC_RXCLK_DELAY_CTRL,
+		     GMAC_RXCLK_DELAY_VAL(dwmac->rx_delay));
+	regmap_write(dwmac->apb_regmap, GMAC_TXCLK_DELAY_CTRL,
+		     GMAC_TXCLK_DELAY_VAL(dwmac->tx_delay));
+
+	thead_dwmac_fix_speed(dwmac, SPEED_1000, 0);
+
+	return thead_dwmac_enable_clk(plat);
+}
+
+static int thead_dwmac_probe(struct platform_device *pdev)
+{
+	struct plat_stmmacenet_data *plat;
+	struct stmmac_resources stmmac_res;
+	struct thead_dwmac *dwmac;
+	struct device_node *np = pdev->dev.of_node;
+	u32 delay_ps;
+	int ret;
+	void __iomem *apb;
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
+	if (!of_property_read_u32(np, "rx-internal-delay-ps", &delay_ps))
+		dwmac->rx_delay = delay_ps;
+	if (!of_property_read_u32(np, "tx-internal-delay-ps", &delay_ps))
+		dwmac->tx_delay = delay_ps;
+
+	apb = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(apb))
+		return dev_err_probe(&pdev->dev, PTR_ERR(apb),
+				     "Failed to remap gmac apb registers\n");
+
+	dwmac->apb_regmap = devm_regmap_init_mmio(&pdev->dev, apb, &regmap_config);
+	if (IS_ERR(dwmac->apb_regmap))
+		return dev_err_probe(&pdev->dev, PTR_ERR(dwmac->apb_regmap),
+				     "Failed to access gmac apb registers\n");
+
+	dwmac->dev = &pdev->dev;
+	dwmac->plat = plat;
+	plat->bsp_priv = dwmac;
+	plat->fix_mac_speed = thead_dwmac_fix_speed;
+
+	ret = thead_dwmac_init(pdev, plat);
+	if (ret)
+		return ret;
+
+	return stmmac_dvr_probe(&pdev->dev, plat, &stmmac_res);
+}
+
+static const struct of_device_id thead_dwmac_match[] = {
+	{ .compatible = "thead,th1520-dwmac" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, thead_dwmac_match);
+
+static struct platform_driver thead_dwmac_driver = {
+	.probe = thead_dwmac_probe,
+	.remove_new = stmmac_pltfr_remove,
+	.driver = {
+		.name = "thead-dwmac",
+		.pm = &stmmac_pltfr_pm_ops,
+		.of_match_table = thead_dwmac_match,
+	},
+};
+module_platform_driver(thead_dwmac_driver);
+
+MODULE_AUTHOR("T-HEAD");
+MODULE_AUTHOR("Jisheng Zhang <jszhang@kernel.org>");
+MODULE_DESCRIPTION("T-HEAD dwmac platform driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1


