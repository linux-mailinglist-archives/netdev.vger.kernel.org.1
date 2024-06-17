Return-Path: <netdev+bounces-104158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C92690B58E
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 18:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B621D1C212F1
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 16:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE8A14D45D;
	Mon, 17 Jun 2024 15:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="OH5Bnefq"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EF3EAC5;
	Mon, 17 Jun 2024 15:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718639331; cv=none; b=FSDqtcQVZkjjvHrm5io0TLv7NP/W/hPK8k7kbUWS3j9icJOsJhOKQ6BcoKsVRu8esqRxZl+cSood4Lwcg95DAAJQJKTCvlBYVxL8unau0QzoCyv8MzwYpagIihIDMAg+gg9n2l6Wcw05HOUEuogKg00pakXCyMc0SArXUwSGc0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718639331; c=relaxed/simple;
	bh=JYHC8AUX5dsK1Y0iin1rim0E052aWvM9punxPGktQ6o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qRoXTpqQdAqmQwnc6sJvsfVvmHpIKq1IqTq2zQlEaNg/xZUX6izfX+OiDLtZLov6WjklWXBSuK4WaewQS5VH6Y1kHmgraUsWOg6aUb2vNZenGSXbzbUuuUZGCez6LVbN/6Odj+Yo193vGYfTLFbLtGkNR8FxQpU+pAL0AYLnUIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=OH5Bnefq; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HDfddI029273;
	Mon, 17 Jun 2024 17:48:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	zXt1rSU3DkADXbF83KHvvo2zbVA+9Tk+x9InX+d5Cx8=; b=OH5BnefqPKNAuIsA
	Gtkr4VX3RDwCNZ5qf6Swx52KnozAhSn1IKMt7CmVkPSDgTtA8BK8e8okVOAlGfOu
	gq2VMFPJJjKkvyOhb8yfXO9uGI/PaxrSu3UvV7wVc6Q/hIPp2iSdgOI4pFwmvKP7
	tYYGp6wGHdozY45bZjdJFCaxcflTh3Zq+6OR5dhAm/YUAld+qLXLdbtjGXxc+U8X
	ayZZCW1sfmr18HmZeIJrQ6h0Ue+L2+4ia3M5yL60AY/3Z1GshC7iSxkHu7caAz5C
	J7tauD+8c5Aj21Ft1MrNREZBe/sP2F2Q1w7ExvRKe4m21kiNUFVavofs0yMhMeSg
	gYnpHA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ys29xy844-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 17:48:12 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id EA37140047;
	Mon, 17 Jun 2024 17:46:44 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 74F1320B60C;
	Mon, 17 Jun 2024 17:45:32 +0200 (CEST)
Received: from localhost (10.48.86.164) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 17 Jun
 2024 17:45:31 +0200
From: Christophe Roullier <christophe.roullier@foss.st.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark
 Brown <broonie@kernel.org>,
        Christophe Roullier
	<christophe.roullier@foss.st.com>,
        Marek Vasut <marex@denx.de>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [net-next,PATCH v2 2/2] net: stmmac: dwmac-stm32: stm32: add management of stm32mp25 for stm32
Date: Mon, 17 Jun 2024 17:45:16 +0200
Message-ID: <20240617154516.277205-3-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240617154516.277205-1-christophe.roullier@foss.st.com>
References: <20240617154516.277205-1-christophe.roullier@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_14,2024-06-17_01,2024-05-17_01

Add Ethernet support for STM32MP25.
STM32MP25 is STM32 SOC with 2 GMACs instances.
GMAC IP version is SNPS 5.3x.
GMAC IP configure with 2 RX and 4 TX queue.
DMA HW capability register supported
RX Checksum Offload Engine supported
TX Checksum insertion supported
Wake-Up On Lan supported
TSO supported

Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 77 ++++++++++++++++++-
 1 file changed, 74 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
index b2db0e26c4e4..71a187b4b5b1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
@@ -53,7 +53,18 @@
 #define SYSCFG_MCU_ETH_SEL_MII		0
 #define SYSCFG_MCU_ETH_SEL_RMII		1
 
-/* STM32MP1 register definitions
+/* STM32MP2 register definitions */
+#define SYSCFG_MP2_ETH_MASK		GENMASK(31, 0)
+
+#define SYSCFG_ETHCR_ETH_PTP_CLK_SEL	BIT(2)
+#define SYSCFG_ETHCR_ETH_CLK_SEL	BIT(1)
+#define SYSCFG_ETHCR_ETH_REF_CLK_SEL	BIT(0)
+
+#define SYSCFG_ETHCR_ETH_SEL_MII	0
+#define SYSCFG_ETHCR_ETH_SEL_RGMII	BIT(4)
+#define SYSCFG_ETHCR_ETH_SEL_RMII	BIT(6)
+
+/* STM32MPx register definitions
  *
  * Below table summarizes the clock requirement and clock sources for
  * supported phy interface modes.
@@ -104,7 +115,7 @@ struct stm32_ops {
 	int (*parse_data)(struct stm32_dwmac *dwmac,
 			  struct device *dev);
 	bool clk_rx_enable_in_suspend;
-	bool is_mp13;
+	bool is_mp13, is_mp2;
 	u32 syscfg_clr_off;
 };
 
@@ -277,8 +288,52 @@ static int stm32mp1_configure_pmcr(struct plat_stmmacenet_data *plat_dat)
 				 dwmac->mode_mask, val);
 }
 
+static int stm32mp2_configure_syscfg(struct plat_stmmacenet_data *plat_dat)
+{
+	struct stm32_dwmac *dwmac = plat_dat->bsp_priv;
+	u32 reg = dwmac->mode_reg;
+	int val = 0;
+
+	switch (plat_dat->mac_interface) {
+	case PHY_INTERFACE_MODE_MII:
+		break;
+	case PHY_INTERFACE_MODE_GMII:
+		if (dwmac->enable_eth_ck)
+			val |= SYSCFG_ETHCR_ETH_CLK_SEL;
+		break;
+	case PHY_INTERFACE_MODE_RMII:
+		val = SYSCFG_ETHCR_ETH_SEL_RMII;
+		if (dwmac->enable_eth_ck)
+			val |= SYSCFG_ETHCR_ETH_REF_CLK_SEL;
+		break;
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		val = SYSCFG_ETHCR_ETH_SEL_RGMII;
+		if (dwmac->enable_eth_ck)
+			val |= SYSCFG_ETHCR_ETH_CLK_SEL;
+		break;
+	default:
+		dev_err(dwmac->dev, "Mode %s not supported",
+			phy_modes(plat_dat->mac_interface));
+		/* Do not manage others interfaces */
+		return -EINVAL;
+	}
+
+	dev_dbg(dwmac->dev, "Mode %s", phy_modes(plat_dat->mac_interface));
+
+	/* Select PTP (IEEE1588) clock selection from RCC (ck_ker_ethxptp) */
+	val |= SYSCFG_ETHCR_ETH_PTP_CLK_SEL;
+
+	/* Update ETHCR (set register) */
+	return regmap_update_bits(dwmac->regmap, reg,
+				 SYSCFG_MP2_ETH_MASK, val);
+}
+
 static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
 {
+	struct stm32_dwmac *dwmac = plat_dat->bsp_priv;
 	int ret;
 
 	ret = stm32mp1_select_ethck_external(plat_dat);
@@ -289,7 +344,10 @@ static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
 	if (ret)
 		return ret;
 
-	return stm32mp1_configure_pmcr(plat_dat);
+	if (!dwmac->ops->is_mp2)
+		return stm32mp1_configure_pmcr(plat_dat);
+	else
+		return stm32mp2_configure_syscfg(plat_dat);
 }
 
 static int stm32mcu_set_mode(struct plat_stmmacenet_data *plat_dat)
@@ -365,6 +423,9 @@ static int stm32_dwmac_parse_data(struct stm32_dwmac *dwmac,
 		return err;
 	}
 
+	if (dwmac->ops->is_mp2)
+		return err;
+
 	dwmac->mode_mask = SYSCFG_MP1_ETH_MASK;
 	err = of_property_read_u32_index(np, "st,syscon", 2, &dwmac->mode_mask);
 	if (err) {
@@ -586,10 +647,20 @@ static struct stm32_ops stm32mp13_dwmac_data = {
 	.clk_rx_enable_in_suspend = true
 };
 
+static struct stm32_ops stm32mp25_dwmac_data = {
+	.set_mode = stm32mp1_set_mode,
+	.suspend = stm32mp1_suspend,
+	.resume = stm32mp1_resume,
+	.parse_data = stm32mp1_parse_data,
+	.is_mp2 = true,
+	.clk_rx_enable_in_suspend = true
+};
+
 static const struct of_device_id stm32_dwmac_match[] = {
 	{ .compatible = "st,stm32-dwmac", .data = &stm32mcu_dwmac_data},
 	{ .compatible = "st,stm32mp1-dwmac", .data = &stm32mp1_dwmac_data},
 	{ .compatible = "st,stm32mp13-dwmac", .data = &stm32mp13_dwmac_data},
+	{ .compatible = "st,stm32mp25-dwmac", .data = &stm32mp25_dwmac_data},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, stm32_dwmac_match);
-- 
2.25.1


