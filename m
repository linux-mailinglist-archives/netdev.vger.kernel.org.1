Return-Path: <netdev+bounces-229567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5215BBDE4E6
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 13:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C5DBA502A1D
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 11:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7653322555;
	Wed, 15 Oct 2025 11:41:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmja2lje4os43os4xodqa.icoremail.net (zg8tmja2lje4os43os4xodqa.icoremail.net [206.189.79.184])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FD6322549;
	Wed, 15 Oct 2025 11:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.79.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760528497; cv=none; b=mw2NFT1d+xrZjV7ujBga/+ioah7/qg7KkfjatDAxMpl12Ge7hZ2FsiHoqpbeHwka1ppmJxjv8uzzQECXR90R7INUk2AJKHMUPvHi4YoMNbOxpW0fdBIbveMHmxOYQs8aUN+uMEhbS5l88PMBu7V9ulL0YEwdomCIyuQYpNBxuaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760528497; c=relaxed/simple;
	bh=y4KRpmFExJi/t0jNgbv7Yd3AFoFTw1cdZS5HuRAc4AM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gIBxnxzv4b/zj52C1GJ5yffzh5lmJoOk4Br0bD2Gln3co3suu39d8mTIOyPqNJioH0Rf/4r2HPZRUmvC5tuH7+fc+XYSE4WN52la7fAf3P7qJTMgS3Xg3PaH9RlqHAjbCXqbqx6dEZPwCkQzY9cJ4yfJXe9wXcgZ5mwoAeNRgK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=206.189.79.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0005182LT.eswin.cn (unknown [10.12.96.155])
	by app2 (Coremail) with SMTP id TQJkCgAnxpRQiO9oaBMLAQ--.9206S2;
	Wed, 15 Oct 2025 19:41:06 +0800 (CST)
From: weishangjuan@eswincomputing.com
To: devicetree@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk,
	yong.liang.choong@linux.intel.com,
	vladimir.oltean@nxp.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	weishangjuan@eswincomputing.com,
	jan.petrous@oss.nxp.com,
	inochiama@gmail.com,
	jszhang@kernel.org,
	0x1207@gmail.com,
	boon.khai.ng@altera.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	lizhi2@eswincomputing.com,
	pinkesh.vaghela@einfochips.com,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v8 2/2] net: stmmac: add Eswin EIC7700 glue driver
Date: Wed, 15 Oct 2025 19:41:01 +0800
Message-Id: <20251015114101.1218-1-weishangjuan@eswincomputing.com>
X-Mailer: git-send-email 2.31.1.windows.1
In-Reply-To: <20251015113751.1114-1-weishangjuan@eswincomputing.com>
References: <20251015113751.1114-1-weishangjuan@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TQJkCgAnxpRQiO9oaBMLAQ--.9206S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuFWxKr4UZFWxGFykXw4UXFb_yoWDXr18pF
	WkAa4YqrnrJFyfK3yrJF40ka95Kw47KF1YkryfK3Zaqa90yryDXw4kta45tFWkJryDuw13
	ta1UCFWxuFn0k3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r4a6rW5MxkIecxEwVCm-wCF04
	k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1U
	MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I
	8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7sRiWrW5UUUUU==
X-CM-SenderInfo: pzhl2xxdqjy31dq6v25zlqu0xpsx3x1qjou0bp/

From: Shangjuan Wei <weishangjuan@eswincomputing.com>

Add Ethernet controller support for Eswin's eic7700 SoC. The driver
implements hardware initialization, clock configuration, delay
adjustment functions based on DWC Ethernet controller, and supports
device tree configuration and platform driver integration.

Signed-off-by: Zhi Li <lizhi2@eswincomputing.com>
Signed-off-by: Shangjuan Wei <weishangjuan@eswincomputing.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |   9 +
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-eic7700.c   | 235 ++++++++++++++++++
 3 files changed, 245 insertions(+)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c

diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index 9507131875b2..716daa51df7e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -67,6 +67,15 @@ config DWMAC_ANARION

 	  This selects the Anarion SoC glue layer support for the stmmac driver.

+config DWMAC_EIC7700
+	tristate "Support for Eswin eic7700 ethernet driver"
+	depends on OF && HAS_DMA && ARCH_ESWIN || COMPILE_TEST
+	help
+	  This driver supports the Eswin EIC7700 Ethernet controller,
+	  which integrates Synopsys DesignWare QoS features. It enables
+	  high-speed networking with DMA acceleration and is optimized
+	  for embedded systems.
+
 config DWMAC_INGENIC
 	tristate "Ingenic MAC support"
 	default MACH_INGENIC
diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
index 51e068e26ce4..ec56bcf2db62 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Makefile
+++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
@@ -14,6 +14,7 @@ stmmac-$(CONFIG_STMMAC_SELFTESTS) += stmmac_selftests.o
 # Ordering matters. Generic driver must be last.
 obj-$(CONFIG_STMMAC_PLATFORM)	+= stmmac-platform.o
 obj-$(CONFIG_DWMAC_ANARION)	+= dwmac-anarion.o
+obj-$(CONFIG_DWMAC_EIC7700)	+= dwmac-eic7700.o
 obj-$(CONFIG_DWMAC_INGENIC)	+= dwmac-ingenic.o
 obj-$(CONFIG_DWMAC_IPQ806X)	+= dwmac-ipq806x.o
 obj-$(CONFIG_DWMAC_LPC18XX)	+= dwmac-lpc18xx.o
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c
new file mode 100644
index 000000000000..1dcf2037001e
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c
@@ -0,0 +1,235 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Eswin DWC Ethernet linux driver
+ *
+ * Copyright 2025, Beijing ESWIN Computing Technology Co., Ltd.
+ *
+ * Authors:
+ *   Zhi Li <lizhi2@eswincomputing.com>
+ *   Shuang Liang <liangshuang@eswincomputing.com>
+ *   Shangjuan Wei <weishangjuan@eswincomputing.com>
+ */
+
+#include <linux/platform_device.h>
+#include <linux/mfd/syscon.h>
+#include <linux/pm_runtime.h>
+#include <linux/stmmac.h>
+#include <linux/regmap.h>
+#include <linux/of.h>
+
+#include "stmmac_platform.h"
+
+/* eth_phy_ctrl_offset eth0:0x100 */
+#define EIC7700_ETH_TX_CLK_SEL		BIT(16)
+#define EIC7700_ETH_PHY_INTF_SELI	BIT(0)
+
+/* eth_axi_lp_ctrl_offset eth0:0x108 */
+#define EIC7700_ETH_CSYSREQ_VAL		BIT(0)
+
+/*
+ * TX/RX Clock Delay Bit Masks:
+ * - TX Delay: bits [14:8] — TX_CLK delay (unit: 0.1ns per bit)
+ * - RX Delay: bits [30:24] — RX_CLK delay (unit: 0.1ns per bit)
+ */
+#define EIC7700_ETH_TX_ADJ_DELAY	GENMASK(14, 8)
+#define EIC7700_ETH_RX_ADJ_DELAY	GENMASK(30, 24)
+
+#define EIC7700_MAX_DELAY_UNIT 0x7F
+
+static const char * const eic7700_clk_names[] = {
+	"tx", "axi", "cfg",
+};
+
+struct eic7700_qos_priv {
+	struct plat_stmmacenet_data *plat_dat;
+};
+
+static int eic7700_clks_config(void *priv, bool enabled)
+{
+	struct eic7700_qos_priv *dwc = (struct eic7700_qos_priv *)priv;
+	struct plat_stmmacenet_data *plat = dwc->plat_dat;
+	int ret = 0;
+
+	if (enabled)
+		ret = clk_bulk_prepare_enable(plat->num_clks, plat->clks);
+	else
+		clk_bulk_disable_unprepare(plat->num_clks, plat->clks);
+
+	return ret;
+}
+
+static int eic7700_dwmac_init(struct platform_device *pdev, void *priv)
+{
+	struct eic7700_qos_priv *dwc = priv;
+
+	return eic7700_clks_config(dwc, true);
+}
+
+static void eic7700_dwmac_exit(struct platform_device *pdev, void *priv)
+{
+	struct eic7700_qos_priv *dwc = priv;
+
+	eic7700_clks_config(dwc, false);
+}
+
+static int eic7700_dwmac_suspend(struct device *dev, void *priv)
+{
+	return pm_runtime_force_suspend(dev);
+}
+
+static int eic7700_dwmac_resume(struct device *dev, void *priv)
+{
+	int ret;
+
+	ret = pm_runtime_force_resume(dev);
+	if (ret)
+		dev_err(dev, "%s failed: %d\n", __func__, ret);
+
+	return ret;
+}
+
+static int eic7700_dwmac_probe(struct platform_device *pdev)
+{
+	struct plat_stmmacenet_data *plat_dat;
+	struct stmmac_resources stmmac_res;
+	struct eic7700_qos_priv *dwc_priv;
+	struct regmap *eic7700_hsp_regmap;
+	u32 eth_axi_lp_ctrl_offset;
+	u32 eth_phy_ctrl_offset;
+	u32 eth_phy_ctrl_regset;
+	u32 eth_rxd_dly_offset;
+	u32 eth_dly_param = 0;
+	u32 delay_ps;
+	int i, ret;
+
+	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				"failed to get resources\n");
+
+	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	if (IS_ERR(plat_dat))
+		return dev_err_probe(&pdev->dev, PTR_ERR(plat_dat),
+				"dt configuration failed\n");
+
+	dwc_priv = devm_kzalloc(&pdev->dev, sizeof(*dwc_priv), GFP_KERNEL);
+	if (!dwc_priv)
+		return -ENOMEM;
+
+	/* Read rx-internal-delay-ps and update rx_clk delay */
+	if (!of_property_read_u32(pdev->dev.of_node,
+				  "rx-internal-delay-ps", &delay_ps)) {
+		u32 val = min(delay_ps / 100, EIC7700_MAX_DELAY_UNIT);
+
+		eth_dly_param &= ~EIC7700_ETH_RX_ADJ_DELAY;
+		eth_dly_param |= FIELD_PREP(EIC7700_ETH_RX_ADJ_DELAY, val);
+	} else {
+		return dev_err_probe(&pdev->dev, -EINVAL,
+			"missing required property rx-internal-delay-ps\n");
+	}
+
+	/* Read tx-internal-delay-ps and update tx_clk delay */
+	if (!of_property_read_u32(pdev->dev.of_node,
+				  "tx-internal-delay-ps", &delay_ps)) {
+		u32 val = min(delay_ps / 100, EIC7700_MAX_DELAY_UNIT);
+
+		eth_dly_param &= ~EIC7700_ETH_TX_ADJ_DELAY;
+		eth_dly_param |= FIELD_PREP(EIC7700_ETH_TX_ADJ_DELAY, val);
+	} else {
+		return dev_err_probe(&pdev->dev, -EINVAL,
+			"missing required property tx-internal-delay-ps\n");
+	}
+
+	eic7700_hsp_regmap = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
+							     "eswin,hsp-sp-csr");
+	if (IS_ERR(eic7700_hsp_regmap))
+		return dev_err_probe(&pdev->dev,
+				PTR_ERR(eic7700_hsp_regmap),
+				"Failed to get hsp-sp-csr regmap\n");
+
+	ret = of_property_read_u32_index(pdev->dev.of_node,
+					 "eswin,hsp-sp-csr",
+					 1, &eth_phy_ctrl_offset);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "can't get eth_phy_ctrl_offset\n");
+
+	regmap_read(eic7700_hsp_regmap, eth_phy_ctrl_offset,
+		    &eth_phy_ctrl_regset);
+	eth_phy_ctrl_regset |=
+		(EIC7700_ETH_TX_CLK_SEL | EIC7700_ETH_PHY_INTF_SELI);
+	regmap_write(eic7700_hsp_regmap, eth_phy_ctrl_offset,
+		     eth_phy_ctrl_regset);
+
+	ret = of_property_read_u32_index(pdev->dev.of_node,
+					 "eswin,hsp-sp-csr",
+					 2, &eth_axi_lp_ctrl_offset);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "can't get eth_axi_lp_ctrl_offset\n");
+
+	regmap_write(eic7700_hsp_regmap, eth_axi_lp_ctrl_offset,
+		     EIC7700_ETH_CSYSREQ_VAL);
+
+	ret = of_property_read_u32_index(pdev->dev.of_node,
+					 "eswin,hsp-sp-csr",
+					 3, &eth_rxd_dly_offset);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "can't get eth_rxd_dly_offset\n");
+
+	regmap_write(eic7700_hsp_regmap, eth_rxd_dly_offset,
+		     eth_dly_param);
+
+	plat_dat->num_clks = ARRAY_SIZE(eic7700_clk_names);
+	plat_dat->clks = devm_kcalloc(&pdev->dev,
+				      plat_dat->num_clks,
+				      sizeof(*plat_dat->clks),
+				      GFP_KERNEL);
+	if (!plat_dat->clks)
+		return -ENOMEM;
+
+	for (i = 0; i < ARRAY_SIZE(eic7700_clk_names); i++)
+		plat_dat->clks[i].id = eic7700_clk_names[i];
+
+	ret = devm_clk_bulk_get_optional(&pdev->dev,
+					 plat_dat->num_clks,
+					 plat_dat->clks);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Failed to get clocks\n");
+
+	plat_dat->clk_tx_i = stmmac_pltfr_find_clk(plat_dat, "tx");
+	plat_dat->set_clk_tx_rate = stmmac_set_clk_tx_rate;
+	plat_dat->clks_config = eic7700_clks_config;
+	plat_dat->bsp_priv = dwc_priv;
+	dwc_priv->plat_dat = plat_dat;
+	plat_dat->init = eic7700_dwmac_init;
+	plat_dat->exit = eic7700_dwmac_exit;
+	plat_dat->suspend = eic7700_dwmac_suspend;
+	plat_dat->resume = eic7700_dwmac_resume;
+
+	return devm_stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
+}
+
+static const struct of_device_id eic7700_dwmac_match[] = {
+	{ .compatible = "eswin,eic7700-qos-eth" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, eic7700_dwmac_match);
+
+static struct platform_driver eic7700_dwmac_driver = {
+	.probe  = eic7700_dwmac_probe,
+	.driver = {
+		.name           = "eic7700-eth-dwmac",
+		.pm             = &stmmac_pltfr_pm_ops,
+		.of_match_table = eic7700_dwmac_match,
+	},
+};
+module_platform_driver(eic7700_dwmac_driver);
+
+MODULE_AUTHOR("Zhi Li <lizhi2@eswincomputing.com>");
+MODULE_AUTHOR("Shuang Liang <liangshuang@eswincomputing.com>");
+MODULE_AUTHOR("Shangjuan Wei <weishangjuan@eswincomputing.com>");
+MODULE_DESCRIPTION("Eswin eic7700 qos ethernet driver");
+MODULE_LICENSE("GPL");
--
2.17.1


