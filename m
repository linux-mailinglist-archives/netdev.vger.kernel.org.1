Return-Path: <netdev+bounces-220929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC44B497E2
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 20:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFAFE446883
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 18:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FE4314B8F;
	Mon,  8 Sep 2025 18:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XzIpngx3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E423126D2;
	Mon,  8 Sep 2025 18:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757355072; cv=none; b=c92B86a82nPLPBDh0wnN83zQrHCqH+DqoD4zFQ4IW8OzPPcAmP4d4DOC9asCx9+2LiaCqqn5ZHSm69KN0RbBBvUDhMxqDAjxNozl2tLWIOb8HGv4lva5hXVWLkuwijkVs7mB3SVMCdfieGTaD1fANA56BCh1CnPdOHGw6J3ZQEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757355072; c=relaxed/simple;
	bh=YUfJQuKeoyvq69CqM4HMv+h2j8i7bzCRaIDADuqZWZs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RpiekrqocIBHfHdaRQCLfh1f4amcFykTtw9m0Wo+qPJ8mMkFzqXXSmjP95KS2VxZ4ZBGxCMvfPLx+hldNBt/drtSSB1xq8I5GQrnGmBtmcjAHXJZwnJzFiW4aCN1JWnYxIoJ/g4zSzcxK2lWuICQwRjzH3SXqDwABmIz9g1ju8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XzIpngx3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA7DC4CEF1;
	Mon,  8 Sep 2025 18:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757355071;
	bh=YUfJQuKeoyvq69CqM4HMv+h2j8i7bzCRaIDADuqZWZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XzIpngx3IOurLr5u3CusrdxOtDADL4yG88U6FwaDbjsa2CQ7EOXVk3Qw0TE35hot6
	 8nWPoZB0WyK/zuOyZMMlW76DxQDYoppnYpUR8Xu8Tkzea+1h0SXf07HEYiUL9PTP8l
	 eqG6URao5KK4rLnUcRbhHIgoR1eQ+Ps614o7I0tWGX379z7D4mFlBi9ZMjQIKfhpVs
	 nGc05XCBL5pm7cyDz23wc2Z/VzZdwZ3P8D1xpmNdyfy+m4F5jW/2xsHjCty/JDzIOX
	 TRc3bz/WI6p3DcpyV/OHrImsyxn0UHOlaXkaIBCP9jiGDXNmnfCX6BE4lAyslGDEUT
	 nVtJAI6B5dvug==
Received: by wens.tw (Postfix, from userid 1000)
	id 0CC6F5FC00; Tue, 09 Sep 2025 02:11:08 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH net-next v4 02/10] net: stmmac: Add support for Allwinner A523 GMAC200
Date: Tue,  9 Sep 2025 02:10:51 +0800
Message-Id: <20250908181059.1785605-3-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250908181059.1785605-1-wens@kernel.org>
References: <20250908181059.1785605-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

The Allwinner A523 SoC family has a second Ethernet controller, called
the GMAC200 in the BSP and T527 datasheet, and referred to as GMAC1 for
numbering. This controller, according to BSP sources, is fully
compatible with a slightly newer version of the Synopsys DWMAC core.
The glue layer around the controller is the same as found around older
DWMAC cores on Allwinner SoCs. The only slight difference is that since
this is the second controller on the SoC, the register for the clock
delay controls is at a different offset. Last, the integration includes
a dedicated clock gate for the memory bus and the whole thing is put in
a separately controllable power domain.

Add a new driver for this hardware supporting the integration layer.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
Changes since v3:
- Fixed printf format specifier warning

Changes since v2 (all suggested by Russell King):
- Include "ps" unit in "... must be multiple of ..." error message
- Use FIELD_FIT to check if delay value is in range and FIELD_MAX to get
  the maximum value
- Reword error message for delay value exceeding maximum
- Drop MASK_TO_VAL

Changes since v1:
- Switch to generic (tx|rx)-internal-delay-ps properties
- Change dev_err() + return to dev_err_probe()
- Check return value from syscon regmap write
- Change driver name to match file name
---
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  12 ++
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-sun55i.c    | 159 ++++++++++++++++++
 3 files changed, 172 insertions(+)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-sun55i.c

diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index 67fa879b1e52..38ce9a0cfb5b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -263,6 +263,18 @@ config DWMAC_SUN8I
 	  stmmac device driver. This driver is used for H3/A83T/A64
 	  EMAC ethernet controller.
 
+config DWMAC_SUN55I
+	tristate "Allwinner sun55i GMAC200 support"
+	default ARCH_SUNXI
+	depends on OF && (ARCH_SUNXI || COMPILE_TEST)
+	select MDIO_BUS_MUX
+	help
+	  Support for Allwinner A523/T527 GMAC200 ethernet controllers.
+
+	  This selects Allwinner SoC glue layer support for the
+	  stmmac device driver. This driver is used for A523/T527
+	  GMAC200 ethernet controller.
+
 config DWMAC_THEAD
 	tristate "T-HEAD dwmac support"
 	depends on OF && (ARCH_THEAD || COMPILE_TEST)
diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
index b591d93f8503..51e068e26ce4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Makefile
+++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
@@ -31,6 +31,7 @@ obj-$(CONFIG_DWMAC_STI)		+= dwmac-sti.o
 obj-$(CONFIG_DWMAC_STM32)	+= dwmac-stm32.o
 obj-$(CONFIG_DWMAC_SUNXI)	+= dwmac-sunxi.o
 obj-$(CONFIG_DWMAC_SUN8I)	+= dwmac-sun8i.o
+obj-$(CONFIG_DWMAC_SUN55I)	+= dwmac-sun55i.o
 obj-$(CONFIG_DWMAC_THEAD)	+= dwmac-thead.o
 obj-$(CONFIG_DWMAC_DWC_QOS_ETH)	+= dwmac-dwc-qos-eth.o
 obj-$(CONFIG_DWMAC_INTEL_PLAT)	+= dwmac-intel-plat.o
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun55i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun55i.c
new file mode 100644
index 000000000000..b34da76ac344
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun55i.c
@@ -0,0 +1,159 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * dwmac-sun55i.c - Allwinner sun55i GMAC200 specific glue layer
+ *
+ * Copyright (C) 2025 Chen-Yu Tsai <wens@csie.org>
+ *
+ * syscon parts taken from dwmac-sun8i.c, which is
+ *
+ * Copyright (C) 2017 Corentin Labbe <clabbe.montjoie@gmail.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/phy.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/stmmac.h>
+
+#include "stmmac.h"
+#include "stmmac_platform.h"
+
+#define SYSCON_REG		0x34
+
+/* RMII specific bits */
+#define SYSCON_RMII_EN		BIT(13) /* 1: enable RMII (overrides EPIT) */
+/* Generic system control EMAC_CLK bits */
+#define SYSCON_ETXDC_MASK		GENMASK(12, 10)
+#define SYSCON_ERXDC_MASK		GENMASK(9, 5)
+/* EMAC PHY Interface Type */
+#define SYSCON_EPIT			BIT(2) /* 1: RGMII, 0: MII */
+#define SYSCON_ETCS_MASK		GENMASK(1, 0)
+#define SYSCON_ETCS_MII		0x0
+#define SYSCON_ETCS_EXT_GMII	0x1
+#define SYSCON_ETCS_INT_GMII	0x2
+
+static int sun55i_gmac200_set_syscon(struct device *dev,
+				     struct plat_stmmacenet_data *plat)
+{
+	struct device_node *node = dev->of_node;
+	struct regmap *regmap;
+	u32 val, reg = 0;
+	int ret;
+
+	regmap = syscon_regmap_lookup_by_phandle(node, "syscon");
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap), "Unable to map syscon\n");
+
+	if (!of_property_read_u32(node, "tx-internal-delay-ps", &val)) {
+		if (val % 100)
+			return dev_err_probe(dev, -EINVAL,
+					     "tx-delay must be a multiple of 100ps\n");
+		val /= 100;
+		dev_dbg(dev, "set tx-delay to %x\n", val);
+		if (!FIELD_FIT(SYSCON_ETXDC_MASK, val))
+			return dev_err_probe(dev, -EINVAL,
+					     "TX clock delay exceeds maximum (%u00ps > %lu00ps)\n",
+					     val, FIELD_MAX(SYSCON_ETXDC_MASK));
+
+		reg |= FIELD_PREP(SYSCON_ETXDC_MASK, val);
+	}
+
+	if (!of_property_read_u32(node, "rx-internal-delay-ps", &val)) {
+		if (val % 100)
+			return dev_err_probe(dev, -EINVAL,
+					     "rx-delay must be a multiple of 100ps\n");
+		val /= 100;
+		dev_dbg(dev, "set rx-delay to %x\n", val);
+		if (!FIELD_FIT(SYSCON_ERXDC_MASK, val))
+			return dev_err_probe(dev, -EINVAL,
+					     "RX clock delay exceeds maximum (%u00ps > %lu00ps)\n",
+					     val, FIELD_MAX(SYSCON_ERXDC_MASK));
+
+		reg |= FIELD_PREP(SYSCON_ERXDC_MASK, val);
+	}
+
+	switch (plat->mac_interface) {
+	case PHY_INTERFACE_MODE_MII:
+		/* default */
+		break;
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		reg |= SYSCON_EPIT | SYSCON_ETCS_INT_GMII;
+		break;
+	case PHY_INTERFACE_MODE_RMII:
+		reg |= SYSCON_RMII_EN;
+		break;
+	default:
+		return dev_err_probe(dev, -EINVAL, "Unsupported interface mode: %s",
+				     phy_modes(plat->mac_interface));
+	}
+
+	ret = regmap_write(regmap, SYSCON_REG, reg);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to write to syscon\n");
+
+	return 0;
+}
+
+static int sun55i_gmac200_probe(struct platform_device *pdev)
+{
+	struct plat_stmmacenet_data *plat_dat;
+	struct stmmac_resources stmmac_res;
+	struct device *dev = &pdev->dev;
+	struct clk *clk;
+	int ret;
+
+	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
+	if (ret)
+		return ret;
+
+	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	if (IS_ERR(plat_dat))
+		return PTR_ERR(plat_dat);
+
+	/* BSP disables it */
+	plat_dat->flags |= STMMAC_FLAG_SPH_DISABLE;
+	plat_dat->host_dma_width = 32;
+
+	ret = sun55i_gmac200_set_syscon(dev, plat_dat);
+	if (ret)
+		return ret;
+
+	clk = devm_clk_get_enabled(dev, "mbus");
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk),
+				     "Failed to get or enable MBUS clock\n");
+
+	ret = devm_regulator_get_enable_optional(dev, "phy");
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get or enable PHY supply\n");
+
+	return devm_stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
+}
+
+static const struct of_device_id sun55i_gmac200_match[] = {
+	{ .compatible = "allwinner,sun55i-a523-gmac200" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sun55i_gmac200_match);
+
+static struct platform_driver sun55i_gmac200_driver = {
+	.probe  = sun55i_gmac200_probe,
+	.driver = {
+		.name           = "dwmac-sun55i",
+		.pm		= &stmmac_pltfr_pm_ops,
+		.of_match_table = sun55i_gmac200_match,
+	},
+};
+module_platform_driver(sun55i_gmac200_driver);
+
+MODULE_AUTHOR("Chen-Yu Tsai <wens@csie.org>");
+MODULE_DESCRIPTION("Allwinner sun55i GMAC200 specific glue layer");
+MODULE_LICENSE("GPL");
-- 
2.39.5


