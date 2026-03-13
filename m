Return-Path: <netdev+bounces-267320-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Ea8E/fCs2mEagAAu9opvQ
	(envelope-from <netdev+bounces-267320-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 08:55:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E682027F0FA
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 08:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AF6A4303ED8E
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 07:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69138372EE2;
	Fri, 13 Mar 2026 07:54:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38EF372675;
	Fri, 13 Mar 2026 07:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773388480; cv=none; b=AHX8b5MB3hvR18XrJ5dGByJ2ftcjrWorRIA4Y1fYtFdzz5bFaS3CA+SpnsX/OA7nUPmtv+3xeZm7w2/Mm7uACxW93iNxAnvaBUabyfRBfrs7gX8JOgwgPdBmTjm4YbHAr9JDlS98flaWKT2Mp8Lcszk+a1OMnVGNANlZ54zU4ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773388480; c=relaxed/simple;
	bh=ON5qrvSu69qBfuKQQVLLcjgQoiXIbyf2EtxBwPib0js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fMEnrVaKRmQSJpnD59ub0csFhX9bCNVKVP1b8sXSyACh8PmRtUhYB0Mwm3p3XNG1KWk0NrA+6ICqxr2sARo7PwCz4fxmE7fihPAQP8mDFkNEbS3HHFkpRWFxuQeTkCFyctXXSgd5P0yajZFizIYqNbao4ErviGokyLw1hygPtVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0004057DT.eswin.cn (unknown [10.11.96.26])
	by app2 (Coremail) with SMTP id TQJkCgDX7J+uwrNpDBYIAA--.10081S2;
	Fri, 13 Mar 2026 15:54:23 +0800 (CST)
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
Subject: [PATCH net-next v4 2/3] net: stmmac: eic7700: enable clocks before syscon access and correct RX sampling timing
Date: Fri, 13 Mar 2026 15:54:13 +0800
Message-ID: <20260313075416.1607-1-lizhi2@eswincomputing.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260313075234.1567-1-lizhi2@eswincomputing.com>
References: <20260313075234.1567-1-lizhi2@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TQJkCgDX7J+uwrNpDBYIAA--.10081S2
X-Coremail-Antispam: 1UD129KBjvDXoW8Jry5Wr4xJw1ktr4fZoXrpw1rXFX_uw47Zr
	yDJrn8JFW0gwsrCw4qvrZ7KF1rArW7WFWkA3ZrZ34DJ34Y9rnFv3s7Z34rXF13JFyjgr1U
	ZF4fAFn3WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT9fnU
	UIcSsGvfJTRUUUbhkFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj
	6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4
	x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4U
	JwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3w
	AS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IY
	x2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4
	x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwAKzVCY07xG64k0F24lc7CjxVAaw2AFwI0_GFv_Wrylc2xSY4AK6svPMxAIw28Icx
	kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAI
	cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
	IEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRdWrXUUUUU=
X-CM-SenderInfo: xol2xx2s6h245lqf0zpsxwx03jof0z/
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
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
	TAGGED_FROM(0.00)[bounces-267320-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.908];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,eswincomputing.com:email,eswincomputing.com:mid]
X-Rspamd-Queue-Id: E682027F0FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 .../ethernet/stmicro/stmmac/dwmac-eic7700.c   | 181 +++++++++++++-----
 1 file changed, 138 insertions(+), 43 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c
index bcb8e000e720..b230bc5b902a 100644
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
@@ -88,18 +126,35 @@ static int eic7700_dwmac_resume(struct device *dev, void *priv)
 	return ret;
 }
 
+static void eic7700_dwmac_fix_speed(void *priv, phy_interface_t interface,
+				    int speed, unsigned int mode)
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
@@ -116,70 +171,95 @@ static int eic7700_dwmac_probe(struct platform_device *pdev)
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
+					 3, &dwc_priv->eth_clk_offset);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "can't get eth_clk_offset\n");
 
 	ret = of_property_read_u32_index(pdev->dev.of_node,
 					 "eswin,hsp-sp-csr",
-					 3, &eth_rxd_dly_offset);
+					 4, &dwc_priv->eth_txd_offset);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret,
-				     "can't get eth_rxd_dly_offset\n");
+				     "can't get eth_txd_offset\n");
 
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
@@ -208,12 +288,27 @@ static int eic7700_dwmac_probe(struct platform_device *pdev)
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


