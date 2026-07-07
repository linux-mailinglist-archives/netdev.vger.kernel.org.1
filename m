Return-Path: <netdev+bounces-305302-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0IqJF1+hTGpQnQEAu9opvQ
	(envelope-from <netdev+bounces-305302-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 08:49:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EBE7181FC
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 08:49:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305302-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305302-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B1CEB30855FF
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 06:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D983AA4EB;
	Tue,  7 Jul 2026 06:43:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.eswincomputing.com (mail.eswincomputing.com [123.124.195.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83635226CF6;
	Tue,  7 Jul 2026 06:43:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783406594; cv=none; b=rGh6CKl1QbmI8K1FoUdmIVbD+2T5mYyo3jWJs7nBqvv4hOkoocj1IgnBtETp2bkwOdg3gq64atsh21DWtakjco0S4bDDllW5aUJb0r8A4xlKnDJAZIoUHvr/U5RP3W0UDP5F3AIvzvOsuMr5A19DzwzXoEGxhrfVNf6SOtjoRzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783406594; c=relaxed/simple;
	bh=NTOhPjNpdndJhT79CPrWjIgNfrPCvlosknceyDRJ0Ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OGMHiHnB2U9A7qwAeHbfkw4gWnTAqgLAEUjAl3QptYbtJ4mIvmAb/p1wSzsb3mdrzeihLNoBA+dbGL6qyKcLASR2tsS0m6F77GzqyhBqTJ4YDvpJJuPfegUkaytdrqy1WAkGEmn6yg/66HdnFllb/Y6UxEi+8iAisqoazLZptN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=123.124.195.78
Received: from E0004057DT.eswin.cn (unknown [10.11.96.26])
	by app2 (Coremail) with SMTP id TQJkCgCHnaDcn0xqpwAyAA--.41186S2;
	Tue, 07 Jul 2026 14:42:38 +0800 (CST)
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
	linux-kernel@vger.kernel.org,
	maxime.chevallier@bootlin.com
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com,
	pritesh.patel@einfochips.com,
	weishangjuan@eswincomputing.com,
	horms@kernel.org,
	Zhi Li <lizhi2@eswincomputing.com>
Subject: [PATCH net-next v10 4/4] net: stmmac: eic7700: add support for eth1 clock inversion variant
Date: Tue,  7 Jul 2026 14:42:32 +0800
Message-ID: <20260707064234.1333-1-lizhi2@eswincomputing.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260707064033.1265-1-lizhi2@eswincomputing.com>
References: <20260707064033.1265-1-lizhi2@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TQJkCgCHnaDcn0xqpwAyAA--.41186S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtw48CFy8tr1kWF18JF4Utwb_yoW3Aw4DpF
	W8CrW5KF4qqr1fK397JF4vva43tr4xKr4SyrWrKFsayas8tr98Xa40ya48JFy8JrW3Zr13
	Xw4jyFWxZa9F9rJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBG14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r4a6rW5MxkIecxEwVCm-wCF04
	k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4U
	JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRByxiUUUUU=
X-CM-SenderInfo: xol2xx2s6h245lqf0zpsxwx03jof0z/
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[lizhi2@eswincomputing.com,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[eswincomputing.com];
	FORGED_RECIPIENTS(0.00)[m:devicetree@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:rmk+kernel@armlinux.org.uk,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:maxime.chevallier@bootlin.com,m:ningyu@eswincomputing.com,m:linmin@eswincomputing.com,m:pinkesh.vaghela@einfochips.com,m:pritesh.patel@einfochips.com,m:weishangjuan@eswincomputing.com,m:horms@kernel.org,m:lizhi2@eswincomputing.com,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:mcoquelinstm32@gmail.com,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,st-md-mailman.stormreply.com,lists.infradead.org,bootlin.com];
	FORGED_SENDER(0.00)[lizhi2@eswincomputing.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-305302-lists,netdev=lfdr.de];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,eswincomputing.com:from_mime,eswincomputing.com:email,eswincomputing.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 81EBE7181FC

From: Zhi Li <lizhi2@eswincomputing.com>

The eth1 MAC exhibits silicon-inherent RX and TX timing behavior that
differs from the eth0 implementation.

At 1000Mbps, RX sampling requires clock inversion due to a fixed MAC
input skew that cannot be compensated by standard RGMII delay settings.

The TX path includes a fixed ~2ns internal delay introduced by the MAC
silicon. This delay is always present and is already accounted for in
the device tree tx-internal-delay-ps property as part of the effective
output timing.

The tx-internal-delay-ps property describes the effective delay seen at
the MAC output. Since the hardware register controls only the
programmable portion of the delay, the driver subtracts the fixed
silicon-inherent component before programming the delay register.

Use compatible-specific match data to identify the eth1 variant and
apply RX clock inversion only at 1000Mbps.

The PHY interface mode is adjusted via phy_fix_phy_mode_for_mac_delays()
to avoid double-application of RGMII delays when MAC-side delays are
already present.

Link speed dependency means RX sampling configuration is applied in the
fix_mac_speed callback after negotiation.

No behavior changes for the existing eth0 controller.

Signed-off-by: Zhi Li <lizhi2@eswincomputing.com>
---
 .../ethernet/stmicro/stmmac/dwmac-eic7700.c   | 111 ++++++++++++++++--
 1 file changed, 103 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c
index ec99b597aeaf..eab8c13fbdcc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c
@@ -28,11 +28,15 @@
 
 /*
  * TX/RX Clock Delay Bit Masks:
- * - TX Delay: bits [14:8] — TX_CLK delay (unit: 0.02ns per bit)
- * - RX Delay: bits [30:24] — RX_CLK delay (unit: 0.02ns per bit)
+ * - TX Delay: bits [14:8] - TX_CLK delay (unit: 0.02ns per bit)
+ * - TX Invert : bit  [15]
+ * - RX Delay: bits [30:24] - RX_CLK delay (unit: 0.02ns per bit)
+ * - RX Invert : bit  [31]
  */
 #define EIC7700_ETH_TX_ADJ_DELAY	GENMASK(14, 8)
 #define EIC7700_ETH_RX_ADJ_DELAY	GENMASK(30, 24)
+#define EIC7700_ETH_TX_INV_DELAY	BIT(15)
+#define EIC7700_ETH_RX_INV_DELAY	BIT(31)
 
 #define EIC7700_MAX_DELAY_STEPS		0x7F
 #define EIC7700_DELAY_STEP_PS		20
@@ -43,7 +47,14 @@ static const char * const eic7700_clk_names[] = {
 	"tx", "axi", "cfg",
 };
 
+struct eic7700_dwmac_data {
+	bool rgmii_rx_clk_invert;
+	bool has_internal_tx_delay;
+	u32 tx_clk_inherent_skew_ps;
+};
+
 struct eic7700_qos_priv {
+	struct device *dev;
 	struct plat_stmmacenet_data *plat_dat;
 	struct regmap *eic7700_hsp_regmap;
 	u32 eth_axi_lp_ctrl_offset;
@@ -54,6 +65,7 @@ struct eic7700_qos_priv {
 	u32 eth_clk_dly_param;
 	bool has_txd_offset;
 	bool has_rxd_offset;
+	bool eth_rx_clk_inv;
 };
 
 static int eic7700_clks_config(void *priv, bool enabled)
@@ -97,9 +109,6 @@ static int eic7700_dwmac_init(struct device *dev, void *priv)
 	if (dwc->has_rxd_offset)
 		regmap_write(dwc->eic7700_hsp_regmap, dwc->eth_rxd_offset, 0);
 
-	regmap_write(dwc->eic7700_hsp_regmap, dwc->eth_clk_offset,
-		     dwc->eth_clk_dly_param);
-
 	return 0;
 }
 
@@ -126,8 +135,38 @@ static int eic7700_dwmac_resume(struct device *dev, void *priv)
 	return ret;
 }
 
+/*
+ * eth1 requires RX clock inversion at 1000Mbps due to silicon-inherent
+ * RX sampling skew at MAC input.
+ *
+ * The configuration is updated in fix_mac_speed() because the required
+ * sampling behavior depends on the negotiated link speed.
+ */
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
+		dev_warn(dwc->dev, "unsupported speed %u\n", speed);
+		return;
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
@@ -148,6 +187,30 @@ static int eic7700_dwmac_probe(struct platform_device *pdev)
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
+	/*
+	 * The MAC silicon unconditionally adds ~2 ns TX delay; prevent
+	 * the PHY from also adding TX delay to avoid doubling it.
+	 *
+	 * DT specifies rgmii-id (TX from MAC silicon, RX from PHY);
+	 * override to rgmii-rxid so the PHY only adds its RX delay.
+	 */
+	if (data->has_internal_tx_delay) {
+		plat_dat->phy_interface =
+				 phy_fix_phy_mode_for_mac_delays(plat_dat->phy_interface,
+								 true, false);
+		if (plat_dat->phy_interface == PHY_INTERFACE_MODE_NA)
+			return dev_err_probe(&pdev->dev, -EINVAL,
+				"phy interface mode is NA\n");
+	}
+
 	/* Read rx-internal-delay-ps and update rx_clk delay */
 	if (!of_property_read_u32(pdev->dev.of_node,
 				  "rx-internal-delay-ps", &delay_ps)) {
@@ -167,7 +230,13 @@ static int eic7700_dwmac_probe(struct platform_device *pdev)
 				 FIELD_PREP(EIC7700_ETH_RX_ADJ_DELAY, val);
 	}
 
-	/* Read tx-internal-delay-ps and update tx_clk delay */
+	/* Read tx-internal-delay-ps and update tx_clk delay.
+	 *
+	 * For eswin,eic7700-qos-eth-clk-inversion, the DT property describes
+	 * the effective TX delay at the MAC output, including the inherent
+	 * silicon delay. Subtract the fixed component to obtain the
+	 * programmable delay value.
+	 */
 	if (!of_property_read_u32(pdev->dev.of_node,
 				  "tx-internal-delay-ps", &delay_ps)) {
 		if (delay_ps % EIC7700_DELAY_STEP_PS)
@@ -175,9 +244,16 @@ static int eic7700_dwmac_probe(struct platform_device *pdev)
 				"tx delay must be multiple of %dps\n",
 				EIC7700_DELAY_STEP_PS);
 
+		if (delay_ps < data->tx_clk_inherent_skew_ps)
+			return dev_err_probe(&pdev->dev, -EINVAL,
+				"tx delay %ups below inherent skew %ups\n",
+				delay_ps, data->tx_clk_inherent_skew_ps);
+
+		delay_ps -= data->tx_clk_inherent_skew_ps;
+
 		if (delay_ps > EIC7700_MAX_DELAY_PS)
 			return dev_err_probe(&pdev->dev, -EINVAL,
-				"tx delay out of range\n");
+				"tx delay out of programmable range\n");
 
 		val = delay_ps / EIC7700_DELAY_STEP_PS;
 
@@ -254,12 +330,31 @@ static int eic7700_dwmac_probe(struct platform_device *pdev)
 	plat_dat->exit = eic7700_dwmac_exit;
 	plat_dat->suspend = eic7700_dwmac_suspend;
 	plat_dat->resume = eic7700_dwmac_resume;
+	plat_dat->fix_mac_speed = eic7700_dwmac_fix_speed;
 
 	return devm_stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
 }
 
+static const struct eic7700_dwmac_data eic7700_dwmac_data = {
+	.rgmii_rx_clk_invert = false,
+	.has_internal_tx_delay = false,
+	.tx_clk_inherent_skew_ps = 0,
+};
+
+static const struct eic7700_dwmac_data eic7700_dwmac_data_clk_inversion = {
+	.rgmii_rx_clk_invert = true,
+	.has_internal_tx_delay = true,
+	.tx_clk_inherent_skew_ps = 2000,
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


