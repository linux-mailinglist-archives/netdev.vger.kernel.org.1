Return-Path: <netdev+bounces-217223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2433B37D5A
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 10:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFEEB5E08C7
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 08:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7EC3112B7;
	Wed, 27 Aug 2025 08:15:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eswincomputing.com (mail.eswincomputing.com [123.124.195.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDBF273800;
	Wed, 27 Aug 2025 08:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.124.195.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756282543; cv=none; b=gFAodB38jstwHrscihZEzinBfveFl/lo6JbdsyRua+aZchoA9GndybZI0Bq049ppHLQ79CtKvmkbjAdFFw9hknjRB45jH3YuO2lpRKNzJ/3UeAyfshEpvzw5GAvnpVrkYljY9c6BA0IoqCrajwfdZmfryWSPTPn76Lo59ucjGUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756282543; c=relaxed/simple;
	bh=S9FbG1F9p7hd78sfwJ4pqFn3DG1vWBNXnxhtlo+nslk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ztyu6N/O/kYWgCEtQd9TmwfJ6Nv5nucw6SdTsd913MjI9ZfEtj15LD2q7psedQjxj8yxbTgcObdKZKJFHnFLz1H0OKLc5yOpvKl+wpc7kqB4Xwl7TK99cpE7BjMg3of5wTmnVHWcNaNNAbRiTB2s8ibXo7Bv7NM8aiI4QS9qvD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=123.124.195.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0005182LT.eswin.cn (unknown [10.12.96.155])
	by app1 (Coremail) with SMTP id TAJkCgBXexFdvq5opjTEAA--.3118S2;
	Wed, 27 Aug 2025 16:14:24 +0800 (CST)
From: weishangjuan@eswincomputing.com
To: devicetree@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	yong.liang.choong@linux.intel.com,
	vladimir.oltean@nxp.com,
	rmk+kernel@armlinux.org.uk,
	faizal.abdul.rahim@linux.intel.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	inochiama@gmail.com,
	jan.petrous@oss.nxp.com,
	jszhang@kernel.org,
	p.zabel@pengutronix.de,
	boon.khai.ng@altera.com,
	0x1207@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	lizhi2@eswincomputing.com,
	Shangjuan Wei <weishangjuan@eswincomputing.com>
Subject: [PATCH v4 2/2] ethernet: eswin: Add eic7700 ethernet driver
Date: Wed, 27 Aug 2025 16:14:17 +0800
Message-Id: <20250827081418.2347-1-weishangjuan@eswincomputing.com>
X-Mailer: git-send-email 2.31.1.windows.1
In-Reply-To: <20250827081135.2243-1-weishangjuan@eswincomputing.com>
References: <20250827081135.2243-1-weishangjuan@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=yes
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TAJkCgBXexFdvq5opjTEAA--.3118S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUO77AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2js
	IEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wASzI0E04IjxsIE14AK
	x2xKxwAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4
	A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F
	5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lw4CEc2x0rVAKj4xxM4
	kE6I8I3I0E14AKx2xKxVC2ax8xMxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCFx2IqxVCF
	s4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r1j6r
	18MI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
	JVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_
	Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUH6wZUUUUU=
X-CM-SenderInfo: pzhl2xxdqjy31dq6v25zlqu0xpsx3x1qjou0bp/

From: Shangjuan Wei <weishangjuan@eswincomputing.com>

Add Ethernet controller support for Eswin's eic7700 SoC. The driver
provides management and control of Ethernet signals for the eiC7700
series chips.

Signed-off-by: Zhi Li <lizhi2@eswincomputing.com>
Signed-off-by: Shangjuan Wei <weishangjuan@eswincomputing.com>
---
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 +
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-eic7700.c   | 270 ++++++++++++++++++
 3 files changed, 282 insertions(+)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c

diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index 67fa879b1e52..a13b15ce1abd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -67,6 +67,17 @@ config DWMAC_ANARION

 	  This selects the Anarion SoC glue layer support for the stmmac driver.

+config DWMAC_EIC7700
+	tristate "Support for Eswin eic7700 ethernet driver"
+	select CRC32
+	select MII
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
index b591d93f8503..f4ec5fc16571 100644
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
index 000000000000..8b2082126a42
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c
@@ -0,0 +1,270 @@
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
+struct eic7700_qos_priv {
+	struct device *dev;
+	struct regmap *hsp_regmap;
+	struct clk *clk_tx;
+	struct clk *clk_axi;
+	struct clk *clk_cfg;
+	u32 tx_delay_ps;
+	u32 rx_delay_ps;
+};
+
+/**
+ * eic7700_apply_delay - Update TX or RX delay bits in delay parameter value.
+ * @delay_ps: Delay in picoseconds (capped at 12.7ns).
+ * @reg:      Pointer to register value to modify.
+ * @is_rx:    True for RX delay (bits 30:24), false for TX delay (bits 14:8).
+ *
+ * Converts delay to 0.1ns units, caps at 0x7F, and sets appropriate bits.
+ * Only RX or TX bits are updated; other bits remain unchanged.
+ */
+static inline void eic7700_apply_delay(u32 delay_ps, u32 *reg, bool is_rx)
+{
+	if (!reg)
+		return;
+
+	u32 val = min(delay_ps / 100, EIC7700_MAX_DELAY_UNIT);
+
+	if (is_rx) {
+		*reg &= ~EIC7700_ETH_RX_ADJ_DELAY;
+		*reg |= (val << 24) & EIC7700_ETH_RX_ADJ_DELAY;
+	} else {
+		*reg &= ~EIC7700_ETH_TX_ADJ_DELAY;
+		*reg |= (val << 8) & EIC7700_ETH_TX_ADJ_DELAY;
+	}
+}
+
+static int eic7700_clks_config(void *priv, bool enabled)
+{
+	struct eic7700_qos_priv *dwc = (struct eic7700_qos_priv *)priv;
+	int ret = 0;
+
+	if (enabled) {
+		ret = clk_prepare_enable(dwc->clk_tx);
+		if (ret < 0) {
+			dev_err(dwc->dev, "Failed to enable tx clock: %d\n",
+				ret);
+			goto err;
+		}
+
+		ret = clk_prepare_enable(dwc->clk_axi);
+		if (ret < 0) {
+			dev_err(dwc->dev, "Failed to enable axi clock: %d\n",
+				ret);
+			goto err_tx;
+		}
+
+		ret = clk_prepare_enable(dwc->clk_cfg);
+		if (ret < 0) {
+			dev_err(dwc->dev, "Failed to enable cfg clock: %d\n",
+				ret);
+			goto err_axi;
+		}
+	} else {
+		clk_disable_unprepare(dwc->clk_tx);
+		clk_disable_unprepare(dwc->clk_axi);
+		clk_disable_unprepare(dwc->clk_cfg);
+	}
+	return ret;
+
+err_axi:
+	clk_disable_unprepare(dwc->clk_axi);
+err_tx:
+	clk_disable_unprepare(dwc->clk_tx);
+err:
+	return ret;
+}
+
+static int eic7700_dwmac_probe(struct platform_device *pdev)
+{
+	struct plat_stmmacenet_data *plat_dat;
+	struct stmmac_resources stmmac_res;
+	struct eic7700_qos_priv *dwc_priv;
+	u32 eth_axi_lp_ctrl_offset;
+	u32 eth_phy_ctrl_offset;
+	u32 eth_phy_ctrl_regset;
+	u32 eth_rxd_dly_offset;
+	u32 eth_dly_param = 0;
+	int ret;
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
+	dwc_priv->dev = &pdev->dev;
+
+	/* Read rx-internal-delay-ps and update rx_clk delay */
+	if (!of_property_read_u32(pdev->dev.of_node,
+				  "rx-internal-delay-ps",
+				  &dwc_priv->rx_delay_ps)) {
+		eic7700_apply_delay(dwc_priv->rx_delay_ps,
+				    &eth_dly_param, true);
+	} else {
+		dev_warn(&pdev->dev, "can't get rx-internal-delay-ps\n");
+	}
+
+	/* Read tx-internal-delay-ps and update tx_clk delay */
+	if (!of_property_read_u32(pdev->dev.of_node,
+				  "tx-internal-delay-ps",
+				  &dwc_priv->tx_delay_ps)) {
+		eic7700_apply_delay(dwc_priv->tx_delay_ps,
+				    &eth_dly_param, false);
+	} else {
+		dev_warn(&pdev->dev, "can't get tx-internal-delay-ps\n");
+	}
+
+	dwc_priv->hsp_regmap =
+		syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
+						"eswin,hsp-sp-csr");
+	if (IS_ERR(dwc_priv->hsp_regmap))
+		return dev_err_probe(&pdev->dev,
+				PTR_ERR(dwc_priv->hsp_regmap),
+				"Failed to get hsp-sp-csr regmap\n");
+
+	ret = of_property_read_u32_index(pdev->dev.of_node,
+					 "eswin,hsp-sp-csr",
+					 1, &eth_phy_ctrl_offset);
+	if (ret)
+		return dev_err_probe(&pdev->dev,
+				ret,
+				"can't get eth_phy_ctrl_offset\n");
+
+	regmap_read(dwc_priv->hsp_regmap, eth_phy_ctrl_offset,
+		    &eth_phy_ctrl_regset);
+	eth_phy_ctrl_regset |=
+		(EIC7700_ETH_TX_CLK_SEL | EIC7700_ETH_PHY_INTF_SELI);
+	regmap_write(dwc_priv->hsp_regmap, eth_phy_ctrl_offset,
+		     eth_phy_ctrl_regset);
+
+	ret = of_property_read_u32_index(pdev->dev.of_node,
+					 "eswin,hsp-sp-csr",
+					 2, &eth_axi_lp_ctrl_offset);
+	if (ret)
+		return dev_err_probe(&pdev->dev,
+				ret,
+				"can't get eth_axi_lp_ctrl_offset\n");
+
+	regmap_write(dwc_priv->hsp_regmap, eth_axi_lp_ctrl_offset,
+		     EIC7700_ETH_CSYSREQ_VAL);
+
+	ret = of_property_read_u32_index(pdev->dev.of_node,
+					 "eswin,hsp-sp-csr",
+					 3, &eth_rxd_dly_offset);
+	if (ret)
+		return dev_err_probe(&pdev->dev,
+				ret,
+				"can't get eth_rxd_dly_offset\n");
+
+	regmap_write(dwc_priv->hsp_regmap, eth_rxd_dly_offset,
+		     eth_dly_param);
+
+	dwc_priv->clk_tx = devm_clk_get(&pdev->dev, "tx");
+	if (IS_ERR(dwc_priv->clk_tx))
+		return dev_err_probe(&pdev->dev,
+				PTR_ERR(dwc_priv->clk_tx),
+				"error getting tx clock\n");
+
+	dwc_priv->clk_axi = devm_clk_get(&pdev->dev, "axi");
+	if (IS_ERR(dwc_priv->clk_axi))
+		return dev_err_probe(&pdev->dev,
+				PTR_ERR(dwc_priv->clk_axi),
+				"error getting axi clock\n");
+
+	dwc_priv->clk_cfg = devm_clk_get(&pdev->dev, "cfg");
+	if (IS_ERR(dwc_priv->clk_cfg))
+		return dev_err_probe(&pdev->dev,
+				PTR_ERR(dwc_priv->clk_cfg),
+				"error getting cfg clock\n");
+
+	ret = eic7700_clks_config(dwc_priv, true);
+	if (ret)
+		return dev_err_probe(&pdev->dev,
+				ret,
+				"error enable clock\n");
+
+	plat_dat->clk_tx_i = dwc_priv->clk_tx;
+	plat_dat->set_clk_tx_rate = stmmac_set_clk_tx_rate;
+	plat_dat->bsp_priv = dwc_priv;
+	plat_dat->clks_config = eic7700_clks_config;
+
+	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
+	if (ret) {
+		eic7700_clks_config(dwc_priv, false);
+		return dev_err_probe(&pdev->dev,
+				ret,
+				"Failed to driver probe\n");
+	}
+
+	return ret;
+}
+
+static void eic7700_dwmac_remove(struct platform_device *pdev)
+{
+	struct eic7700_qos_priv *dwc_priv = get_stmmac_bsp_priv(&pdev->dev);
+
+	stmmac_pltfr_remove(pdev);
+	eic7700_clks_config(dwc_priv, false);
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
+	.remove = eic7700_dwmac_remove,
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


