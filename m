Return-Path: <netdev+bounces-248390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDB1D07BA0
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 09:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA6D43005090
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 08:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC722FC876;
	Fri,  9 Jan 2026 08:09:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12B02E22AA;
	Fri,  9 Jan 2026 08:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.78.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767946199; cv=none; b=irEUyskE7TKZRPW3IwZbhECbpCoYwMbbCmKUapRX8OC0tFmqHDszANP4JXpiXXTllU6jZMkpIJhmaDrtheS8U9HPpvwIhF7eOV63zq1XfwvN7Yc0j9J+prhQvDiA/m+FdxeT830gzgirnYqlYRgAKPYZuD6/WHaWhd2/GcfGOwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767946199; c=relaxed/simple;
	bh=vMd0fjHx08FFrjZifFKAG+Ky6J9KcXzgr1/KAXKrlSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IWYbRZg1f9Yz6LEf7pJEL95KnX5iDFSNJWVAXo7A++Ah2ZEP0QSmCdu/OaKoIYgeDp9Eh63mBZDlWTj0gNH7+IF1XzxT7Ur1b0G46uRvxxjC1RGDA7HYCL+oZXr96jHBAzwtN6QD1hizEJiNA2ifmTYsRwtu3vjnfz3uEguFKwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=13.76.78.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0004057DT.eswin.cn (unknown [10.11.96.26])
	by app2 (Coremail) with SMTP id TQJkCgB3uay7t2BpiWySAA--.23182S2;
	Fri, 09 Jan 2026 16:09:32 +0800 (CST)
From: lizhi2@eswincomputing.com
To: devicetree@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com,
	weishangjuan@eswincomputing.com,
	Zhi Li <lizhi2@eswincomputing.com>
Subject: [PATCH v1 2/2] net: stmmac: eic7700: enable clocks before syscon access and correct RX sampling timing
Date: Fri,  9 Jan 2026 16:09:26 +0800
Message-ID: <20260109080929.1308-1-lizhi2@eswincomputing.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260109080601.1262-1-lizhi2@eswincomputing.com>
References: <20260109080601.1262-1-lizhi2@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TQJkCgB3uay7t2BpiWySAA--.23182S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKw4kKr45AF47XF15tFy7ZFb_yoWfWF17pF
	WkCFyYqr1jqF1fG3yvyF40q34Fkw47WF1fCryftFn2yF9xtrs8Xayqya4akFy5Gry7Za13
	J3yUJFyxu3W29rJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBm14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r4a6rW5MxkIecxEwVCm-wCF04
	k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1U
	MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I
	8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRNSdgDUUUU
X-CM-SenderInfo: xol2xx2s6h245lqf0zpsxwx03jof0z/

From: Zhi Li <lizhi2@eswincomputing.com>

The second Ethernet controller (eth1) on the Eswin EIC7700 SoC may fail
to sample RX data correctly at Gigabit speed due to EIC7700-specific
receive clock to data skew at the MAC input.

The existing internal delay configuration does not provide sufficient
adjustment range to compensate for this condition. Update the EIC7700
DWMAC glue driver to optionally apply EIC7700-specific clock sampling
inversion for Gigabit operation.

TXD and RXD delay registers are explicitly cleared during initialization
to override any residual configuration left by the bootloader. All HSP
CSR register accesses are performed only after the required clocks are
enabled.

Fixes: ea77dbbdbc4e ("net: stmmac: add Eswin EIC7700 glue driver")
Signed-off-by: Zhi Li <lizhi2@eswincomputing.com>
---
 .../ethernet/stmicro/stmmac/dwmac-eic7700.c   | 132 +++++++++++++-----
 1 file changed, 97 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c
index bcb8e000e720..68c476612af9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c
@@ -28,20 +28,34 @@
 
 /*
  * TX/RX Clock Delay Bit Masks:
- * - TX Delay: bits [14:8] — TX_CLK delay (unit: 0.1ns per bit)
- * - RX Delay: bits [30:24] — RX_CLK delay (unit: 0.1ns per bit)
+ * - TX Delay: bits [14:8] — TX_CLK delay (unit: 0.02ns per bit)
+ * - TX Invert : bit  [15]
+ * - RX Delay: bits [30:24] — RX_CLK delay (unit: 0.02ns per bit)
+ * - RX Invert : bit  [31]
  */
 #define EIC7700_ETH_TX_ADJ_DELAY	GENMASK(14, 8)
 #define EIC7700_ETH_RX_ADJ_DELAY	GENMASK(30, 24)
+#define EIC7700_ETH_TX_INV_DELAY	BIT(15)
+#define EIC7700_ETH_RX_INV_DELAY	BIT(31)
 
-#define EIC7700_MAX_DELAY_UNIT 0x7F
+#define EIC7700_MAX_DELAY_STEPS 0x7F
 
 static const char * const eic7700_clk_names[] = {
 	"tx", "axi", "cfg",
 };
 
 struct eic7700_qos_priv {
+	struct device *dev;
 	struct plat_stmmacenet_data *plat_dat;
+	struct regmap *eic7700_hsp_regmap;
+	u32 eth_axi_lp_ctrl_offset;
+	u32 eth_phy_ctrl_offset;
+	u32 eth_txd_offset;
+	u32 eth_clk_offset;
+	u32 eth_rxd_offset;
+	u32 eth_clk_dly_param;
+	bool eth_tx_clk_inv;
+	bool eth_rx_clk_inv;
 };
 
 static int eic7700_clks_config(void *priv, bool enabled)
@@ -61,8 +75,27 @@ static int eic7700_clks_config(void *priv, bool enabled)
 static int eic7700_dwmac_init(struct device *dev, void *priv)
 {
 	struct eic7700_qos_priv *dwc = priv;
+	u32 eth_phy_ctrl_regset;
+	int ret = 0;
 
-	return eic7700_clks_config(dwc, true);
+	ret = eic7700_clks_config(dwc, true);
+	if (ret)
+		return ret;
+
+	regmap_read(dwc->eic7700_hsp_regmap, dwc->eth_phy_ctrl_offset,
+		    &eth_phy_ctrl_regset);
+	eth_phy_ctrl_regset |=
+		(EIC7700_ETH_TX_CLK_SEL | EIC7700_ETH_PHY_INTF_SELI);
+	regmap_write(dwc->eic7700_hsp_regmap, dwc->eth_phy_ctrl_offset,
+		     eth_phy_ctrl_regset);
+
+	regmap_write(dwc->eic7700_hsp_regmap, dwc->eth_axi_lp_ctrl_offset,
+		     EIC7700_ETH_CSYSREQ_VAL);
+
+	regmap_write(dwc->eic7700_hsp_regmap, dwc->eth_txd_offset, 0);
+	regmap_write(dwc->eic7700_hsp_regmap, dwc->eth_rxd_offset, 0);
+
+	return ret;
 }
 
 static void eic7700_dwmac_exit(struct device *dev, void *priv)
@@ -88,17 +121,34 @@ static int eic7700_dwmac_resume(struct device *dev, void *priv)
 	return ret;
 }
 
+static void eic7700_dwmac_fix_speed(void *priv, int speed, unsigned int mode)
+{
+	struct eic7700_qos_priv *dwc = (struct eic7700_qos_priv *)priv;
+	u32 dly_param = dwc->eth_clk_dly_param;
+
+	switch (speed) {
+	case SPEED_1000:
+		if (dwc->eth_tx_clk_inv)
+			dly_param |= EIC7700_ETH_TX_INV_DELAY;
+		if (dwc->eth_rx_clk_inv)
+			dly_param |= EIC7700_ETH_RX_INV_DELAY;
+		break;
+	case SPEED_100:
+	case SPEED_10:
+		break;
+	default:
+		dev_err(dwc->dev, "invalid speed %u\n", speed);
+		break;
+	}
+
+	regmap_write(dwc->eic7700_hsp_regmap, dwc->eth_clk_offset, dly_param);
+}
+
 static int eic7700_dwmac_probe(struct platform_device *pdev)
 {
 	struct plat_stmmacenet_data *plat_dat;
 	struct stmmac_resources stmmac_res;
 	struct eic7700_qos_priv *dwc_priv;
-	struct regmap *eic7700_hsp_regmap;
-	u32 eth_axi_lp_ctrl_offset;
-	u32 eth_phy_ctrl_offset;
-	u32 eth_phy_ctrl_regset;
-	u32 eth_rxd_dly_offset;
-	u32 eth_dly_param = 0;
 	u32 delay_ps;
 	int i, ret;
 
@@ -116,13 +166,16 @@ static int eic7700_dwmac_probe(struct platform_device *pdev)
 	if (!dwc_priv)
 		return -ENOMEM;
 
+	dwc_priv->dev = &pdev->dev;
+
 	/* Read rx-internal-delay-ps and update rx_clk delay */
 	if (!of_property_read_u32(pdev->dev.of_node,
 				  "rx-internal-delay-ps", &delay_ps)) {
-		u32 val = min(delay_ps / 100, EIC7700_MAX_DELAY_UNIT);
+		u32 val = min(delay_ps / 20, EIC7700_MAX_DELAY_STEPS);
 
-		eth_dly_param &= ~EIC7700_ETH_RX_ADJ_DELAY;
-		eth_dly_param |= FIELD_PREP(EIC7700_ETH_RX_ADJ_DELAY, val);
+		dwc_priv->eth_clk_dly_param &= ~EIC7700_ETH_RX_ADJ_DELAY;
+		dwc_priv->eth_clk_dly_param |=
+				 FIELD_PREP(EIC7700_ETH_RX_ADJ_DELAY, val);
 	} else {
 		return dev_err_probe(&pdev->dev, -EINVAL,
 			"missing required property rx-internal-delay-ps\n");
@@ -131,55 +184,63 @@ static int eic7700_dwmac_probe(struct platform_device *pdev)
 	/* Read tx-internal-delay-ps and update tx_clk delay */
 	if (!of_property_read_u32(pdev->dev.of_node,
 				  "tx-internal-delay-ps", &delay_ps)) {
-		u32 val = min(delay_ps / 100, EIC7700_MAX_DELAY_UNIT);
+		u32 val = min(delay_ps / 20, EIC7700_MAX_DELAY_STEPS);
 
-		eth_dly_param &= ~EIC7700_ETH_TX_ADJ_DELAY;
-		eth_dly_param |= FIELD_PREP(EIC7700_ETH_TX_ADJ_DELAY, val);
+		dwc_priv->eth_clk_dly_param &= ~EIC7700_ETH_TX_ADJ_DELAY;
+		dwc_priv->eth_clk_dly_param |=
+				 FIELD_PREP(EIC7700_ETH_TX_ADJ_DELAY, val);
 	} else {
 		return dev_err_probe(&pdev->dev, -EINVAL,
 			"missing required property tx-internal-delay-ps\n");
 	}
 
-	eic7700_hsp_regmap = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
-							     "eswin,hsp-sp-csr");
-	if (IS_ERR(eic7700_hsp_regmap))
+	dwc_priv->eth_tx_clk_inv =
+	    of_property_read_bool(pdev->dev.of_node, "eswin,tx-clk-invert");
+	dwc_priv->eth_rx_clk_inv =
+	    of_property_read_bool(pdev->dev.of_node, "eswin,rx-clk-invert");
+
+	dwc_priv->eic7700_hsp_regmap =
+			syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
+							"eswin,hsp-sp-csr");
+	if (IS_ERR(dwc_priv->eic7700_hsp_regmap))
 		return dev_err_probe(&pdev->dev,
-				PTR_ERR(eic7700_hsp_regmap),
+				PTR_ERR(dwc_priv->eic7700_hsp_regmap),
 				"Failed to get hsp-sp-csr regmap\n");
 
 	ret = of_property_read_u32_index(pdev->dev.of_node,
 					 "eswin,hsp-sp-csr",
-					 1, &eth_phy_ctrl_offset);
+					 1, &dwc_priv->eth_phy_ctrl_offset);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret,
 				     "can't get eth_phy_ctrl_offset\n");
 
-	regmap_read(eic7700_hsp_regmap, eth_phy_ctrl_offset,
-		    &eth_phy_ctrl_regset);
-	eth_phy_ctrl_regset |=
-		(EIC7700_ETH_TX_CLK_SEL | EIC7700_ETH_PHY_INTF_SELI);
-	regmap_write(eic7700_hsp_regmap, eth_phy_ctrl_offset,
-		     eth_phy_ctrl_regset);
-
 	ret = of_property_read_u32_index(pdev->dev.of_node,
 					 "eswin,hsp-sp-csr",
-					 2, &eth_axi_lp_ctrl_offset);
+					 2, &dwc_priv->eth_axi_lp_ctrl_offset);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret,
 				     "can't get eth_axi_lp_ctrl_offset\n");
 
-	regmap_write(eic7700_hsp_regmap, eth_axi_lp_ctrl_offset,
-		     EIC7700_ETH_CSYSREQ_VAL);
+	ret = of_property_read_u32_index(pdev->dev.of_node,
+					 "eswin,hsp-sp-csr",
+					 3, &dwc_priv->eth_txd_offset);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "can't get eth_txd_offset\n");
 
 	ret = of_property_read_u32_index(pdev->dev.of_node,
 					 "eswin,hsp-sp-csr",
-					 3, &eth_rxd_dly_offset);
+					 4, &dwc_priv->eth_clk_offset);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret,
-				     "can't get eth_rxd_dly_offset\n");
+				     "can't get eth_clk_offset\n");
 
-	regmap_write(eic7700_hsp_regmap, eth_rxd_dly_offset,
-		     eth_dly_param);
+	ret = of_property_read_u32_index(pdev->dev.of_node,
+					 "eswin,hsp-sp-csr",
+					 5, &dwc_priv->eth_rxd_offset);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "can't get eth_rxd_offset\n");
 
 	plat_dat->num_clks = ARRAY_SIZE(eic7700_clk_names);
 	plat_dat->clks = devm_kcalloc(&pdev->dev,
@@ -208,6 +269,7 @@ static int eic7700_dwmac_probe(struct platform_device *pdev)
 	plat_dat->exit = eic7700_dwmac_exit;
 	plat_dat->suspend = eic7700_dwmac_suspend;
 	plat_dat->resume = eic7700_dwmac_resume;
+	plat_dat->fix_mac_speed = eic7700_dwmac_fix_speed;
 
 	return devm_stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
 }
-- 
2.25.1


