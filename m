Return-Path: <netdev+bounces-263051-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJSgJjN9pmnDQQAAu9opvQ
	(envelope-from <netdev+bounces-263051-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 07:18:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 155AC1E98B6
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 07:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C4F033030984
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 06:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9177A374E78;
	Tue,  3 Mar 2026 06:17:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB239374E7B;
	Tue,  3 Mar 2026 06:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772518652; cv=none; b=OaIKOmZgrnK7WuMFT1LwSLyZDc5V96ZDhuUfMbkl9c+56aDakxUd1YVktwDo/HbR9OD+nfSPheP/p8sucmBsrxtRo9+a/oxi2wpUIUDjkB5HuVNLfppbFGD+2PJPJUGOfx6fLh8FJqu6ZMRf55as3zbUtzQ4mngzxhA4JSwJVq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772518652; c=relaxed/simple;
	bh=E4A1RkES6Awdwz0UAVFiRs3N0ACyue9hl5/283LzBzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kCWPyB4tl7yPoj+KBjQltlZvVVBfKR4aYRDWgFsnU/3H2PAotY2RFQ/lpllEqAFkBawtwYLDqUHy1M5wTqKrMtDPwxZwN03YG2u34WGSyMljUlexpGALi0X8DZb0idAGcKsJlkfRHy2VIfX7yBnGEo4PKLAAeH5RGsk/6UxSZx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0004057DT.eswin.cn (unknown [10.11.96.26])
	by app1 (Coremail) with SMTP id TAJkCgAnyXLpfKZpiDoFAA--.23439S2;
	Tue, 03 Mar 2026 14:17:14 +0800 (CST)
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
	wens@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com,
	pritesh.patel@einfochips.com,
	weishangjuan@eswincomputing.com,
	Zhi Li <lizhi2@eswincomputing.com>
Subject: [PATCH net-next v3 2/3] net: stmmac: eic7700: enable clocks before syscon access and correct RX sampling timing
Date: Tue,  3 Mar 2026 14:17:08 +0800
Message-ID: <20260303061711.895-1-lizhi2@eswincomputing.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260303061525.846-1-lizhi2@eswincomputing.com>
References: <20260303061525.846-1-lizhi2@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TAJkCgAnyXLpfKZpiDoFAA--.23439S2
X-Coremail-Antispam: 1UD129KBjvPXoW5Cw47JFWxAFW3GFW8uFW3p5X_trWUGoWfKF
	13Xw1UJ34Uurs5K3WxKwnxWa1kArW7WF1ruw42y3Waq3Wjqr93J3ZIqa1aqrW5AFyDZrn5
	Jr13CFW7Aayrn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3AaLa
	J3UjIYCTnIWjp_UUUYN7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_
	Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M2
	8EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_
	Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7M4kE6xkIj40Ew7xC0wCY1x0262kKe7AKxVW8ZVWrXwCY02Avz4vE-syl42xK82
	IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
	0s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMI
	IF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI
	42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
	80aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRiWrW5UUUUU==
X-CM-SenderInfo: xol2xx2s6h245lqf0zpsxwx03jof0z/
X-Rspamd-Queue-Id: 155AC1E98B6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[lizhi2@eswincomputing.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[eswincomputing.com];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,dabbelt.com,eecs.berkeley.edu,ghiti.fr,lists.infradead.org,st-md-mailman.stormreply.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	TAGGED_FROM(0.00)[bounces-263051-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.827];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,eswincomputing.com:mid,eswincomputing.com:email]
X-Rspamd-Action: no action

From: Zhi Li <lizhi2@eswincomputing.com>

The second Ethernet controller (eth1) on the Eswin EIC7700 SoC may fail
to sample RX data correctly at Gigabit speed due to EIC7700-specific
receive clock to data skew at the MAC input in the silicon.

The existing internal delay configuration does not provide sufficient
adjustment range to compensate for this condition at 1000Mbps.
Update the EIC7700 DWMAC glue driver to apply EIC7700-specific clock
sampling inversion only during Gigabit operation on MAC instances
that require it.

TXD and RXD delay registers are explicitly cleared during initialization
to override any residual configuration left by the bootloader. All HSP
CSR register accesses are performed only after the required clocks are
enabled.

Fixes: ea77dbbdbc4e ("net: stmmac: add Eswin EIC7700 glue driver")
Signed-off-by: Zhi Li <lizhi2@eswincomputing.com>
---
 .../ethernet/stmicro/stmmac/dwmac-eic7700.c   | 180 +++++++++++++-----
 1 file changed, 137 insertions(+), 43 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c
index bcb8e000e720..acddea58cc6b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c
@@ -28,20 +28,40 @@
 
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
+#define EIC7700_MAX_DELAY_STEPS		0x7F
+#define EIC7700_DELAY_STEP_PS		20
+#define EIC7700_MAX_DELAY_PS	\
+	(EIC7700_MAX_DELAY_STEPS * EIC7700_DELAY_STEP_PS)
 
 static const char * const eic7700_clk_names[] = {
 	"tx", "axi", "cfg",
 };
 
+struct eic7700_dwmac_data {
+	bool rgmii_rx_clk_invert;
+};
+
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
+	bool eth_rx_clk_inv;
 };
 
 static int eic7700_clks_config(void *priv, bool enabled)
@@ -61,8 +81,26 @@ static int eic7700_clks_config(void *priv, bool enabled)
 static int eic7700_dwmac_init(struct device *dev, void *priv)
 {
 	struct eic7700_qos_priv *dwc = priv;
+	int ret;
+
+	ret = eic7700_clks_config(dwc, true);
+	if (ret)
+		return ret;
+
+	ret = regmap_set_bits(dwc->eic7700_hsp_regmap,
+			      dwc->eth_phy_ctrl_offset,
+			      EIC7700_ETH_TX_CLK_SEL |
+			      EIC7700_ETH_PHY_INTF_SELI);
+	if (ret)
+		return ret;
+
+	regmap_write(dwc->eic7700_hsp_regmap, dwc->eth_axi_lp_ctrl_offset,
+		     EIC7700_ETH_CSYSREQ_VAL);
 
-	return eic7700_clks_config(dwc, true);
+	regmap_write(dwc->eic7700_hsp_regmap, dwc->eth_txd_offset, 0);
+	regmap_write(dwc->eic7700_hsp_regmap, dwc->eth_rxd_offset, 0);
+
+	return 0;
 }
 
 static void eic7700_dwmac_exit(struct device *dev, void *priv)
@@ -88,18 +126,34 @@ static int eic7700_dwmac_resume(struct device *dev, void *priv)
 	return ret;
 }
 
+static void eic7700_dwmac_fix_speed(void *priv, int speed, unsigned int mode)
+{
+	struct eic7700_qos_priv *dwc = (struct eic7700_qos_priv *)priv;
+	u32 dly_param = dwc->eth_clk_dly_param;
+
+	switch (speed) {
+	case SPEED_1000:
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
+	const struct eic7700_dwmac_data *data;
 	struct plat_stmmacenet_data *plat_dat;
 	struct stmmac_resources stmmac_res;
 	struct eic7700_qos_priv *dwc_priv;
-	struct regmap *eic7700_hsp_regmap;
-	u32 eth_axi_lp_ctrl_offset;
-	u32 eth_phy_ctrl_offset;
-	u32 eth_phy_ctrl_regset;
-	u32 eth_rxd_dly_offset;
-	u32 eth_dly_param = 0;
-	u32 delay_ps;
+	u32 delay_ps, val;
 	int i, ret;
 
 	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
@@ -116,70 +170,95 @@ static int eic7700_dwmac_probe(struct platform_device *pdev)
 	if (!dwc_priv)
 		return -ENOMEM;
 
+	dwc_priv->dev = &pdev->dev;
+
+	data = device_get_match_data(&pdev->dev);
+	if (!data)
+		return dev_err_probe(&pdev->dev,
+				     -EINVAL, "no match data found\n");
+
+	dwc_priv->eth_rx_clk_inv = data->rgmii_rx_clk_invert;
+
 	/* Read rx-internal-delay-ps and update rx_clk delay */
 	if (!of_property_read_u32(pdev->dev.of_node,
 				  "rx-internal-delay-ps", &delay_ps)) {
-		u32 val = min(delay_ps / 100, EIC7700_MAX_DELAY_UNIT);
+		if (delay_ps % EIC7700_DELAY_STEP_PS)
+			return dev_err_probe(&pdev->dev, -EINVAL,
+				"rx delay must be multiple of %dps\n",
+				EIC7700_DELAY_STEP_PS);
 
-		eth_dly_param &= ~EIC7700_ETH_RX_ADJ_DELAY;
-		eth_dly_param |= FIELD_PREP(EIC7700_ETH_RX_ADJ_DELAY, val);
-	} else {
-		return dev_err_probe(&pdev->dev, -EINVAL,
-			"missing required property rx-internal-delay-ps\n");
+		if (delay_ps > EIC7700_MAX_DELAY_PS)
+			return dev_err_probe(&pdev->dev, -EINVAL,
+				"rx delay out of range\n");
+
+		val = delay_ps / EIC7700_DELAY_STEP_PS;
+
+		dwc_priv->eth_clk_dly_param &= ~EIC7700_ETH_RX_ADJ_DELAY;
+		dwc_priv->eth_clk_dly_param |=
+				 FIELD_PREP(EIC7700_ETH_RX_ADJ_DELAY, val);
 	}
 
 	/* Read tx-internal-delay-ps and update tx_clk delay */
 	if (!of_property_read_u32(pdev->dev.of_node,
 				  "tx-internal-delay-ps", &delay_ps)) {
-		u32 val = min(delay_ps / 100, EIC7700_MAX_DELAY_UNIT);
+		if (delay_ps % EIC7700_DELAY_STEP_PS)
+			return dev_err_probe(&pdev->dev, -EINVAL,
+				"tx delay must be multiple of %dps\n",
+				EIC7700_DELAY_STEP_PS);
+
+		if (delay_ps > EIC7700_MAX_DELAY_PS)
+			return dev_err_probe(&pdev->dev, -EINVAL,
+				"tx delay out of range\n");
 
-		eth_dly_param &= ~EIC7700_ETH_TX_ADJ_DELAY;
-		eth_dly_param |= FIELD_PREP(EIC7700_ETH_TX_ADJ_DELAY, val);
-	} else {
-		return dev_err_probe(&pdev->dev, -EINVAL,
-			"missing required property tx-internal-delay-ps\n");
+		val = delay_ps / EIC7700_DELAY_STEP_PS;
+
+		dwc_priv->eth_clk_dly_param &= ~EIC7700_ETH_TX_ADJ_DELAY;
+		dwc_priv->eth_clk_dly_param |=
+				 FIELD_PREP(EIC7700_ETH_TX_ADJ_DELAY, val);
 	}
 
-	eic7700_hsp_regmap = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
-							     "eswin,hsp-sp-csr");
-	if (IS_ERR(eic7700_hsp_regmap))
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
@@ -208,12 +287,27 @@ static int eic7700_dwmac_probe(struct platform_device *pdev)
 	plat_dat->exit = eic7700_dwmac_exit;
 	plat_dat->suspend = eic7700_dwmac_suspend;
 	plat_dat->resume = eic7700_dwmac_resume;
+	plat_dat->fix_mac_speed = eic7700_dwmac_fix_speed;
 
 	return devm_stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
 }
 
+static const struct eic7700_dwmac_data eic7700_dwmac_data = {
+	.rgmii_rx_clk_invert = false,
+};
+
+static const struct eic7700_dwmac_data eic7700_dwmac_data_clk_inversion = {
+	.rgmii_rx_clk_invert = true,
+};
+
 static const struct of_device_id eic7700_dwmac_match[] = {
-	{ .compatible = "eswin,eic7700-qos-eth" },
+	{	.compatible = "eswin,eic7700-qos-eth",
+		.data = &eic7700_dwmac_data,
+	},
+	{
+		.compatible = "eswin,eic7700-qos-eth-clk-inversion",
+		.data = &eic7700_dwmac_data_clk_inversion,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, eic7700_dwmac_match);
-- 
2.25.1


