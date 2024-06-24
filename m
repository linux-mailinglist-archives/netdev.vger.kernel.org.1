Return-Path: <netdev+bounces-106010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 898CA914342
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 09:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A68C51C22B3A
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 07:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BC83D393;
	Mon, 24 Jun 2024 07:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="dVF0nzWe"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BE2381A4;
	Mon, 24 Jun 2024 07:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719213173; cv=none; b=ZXIZ4MbzZdWEUGm76ZF0UEBzO+aRBW7tsss69RfW3uE2vW/jP1Vw1PdFbFXGTv8YkLMXaqHHMykWNqp4GkCWs0IF1RsscCUEgaNUgKlWYDq2/JAA10lCXEZ7C/fu9Pg/IOxt+0+pyOyLiTM+EegFyeW/mjC0a9h3Sa8K99h8sec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719213173; c=relaxed/simple;
	bh=8zeV6J/V6QGhl3Q54FH4tBrEMawJuvPCOhga5SvYw94=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fSrWB8QLui/3JPC51sGmKgJgzL6hl8qyEV0fTGkWzZzVh2UMZaKg3x/q9C8C8QY/IXpGx87PVYoB6CwrEOUcV1086/rsfp7z5bML9iC/0Cn/6sHS0VL12b8Mf7w6uB0Vph/nhNSiSS1ZOvg8d+ds6DfCmBFd2Bd4uinOeITp6To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=dVF0nzWe; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45NKSa8b021217;
	Mon, 24 Jun 2024 09:12:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	FfInngTJboIkP5t9ZhXSngJj6R6y0Dwxri0WZ4Omhyc=; b=dVF0nzWeoOzlYjZY
	OsZJStVpGDNP8FeDAAki95q29qTLN4wuAYPTM49HoYutCl6EdY/gkHqFALwC7LRG
	EU3WsqFMEgiAn/BRbcrl1jtoa4vTByDeIAC9jPDhJp7b/4VJQxb3WbgxHXk+GAaC
	cV1lLpAuY3zSSWLiIWk12fHZDiV39hjV7JI7PTklcDm3ao87paq/pjjVpTFLdI71
	vvVX2q5zFXWxKnFsGPtW4cEe4PmVZKSqIELDh2rcaibDJMvLFX9cWXlKZD++ifif
	bfOw7hjIIoQkM3Nefa1dAe+rvgsJ27XBzfjQCOg90WwxYefeBJB30OXbl8YdpVMS
	P01uDg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ywm1g5vrt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 09:12:23 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 45D564002D;
	Mon, 24 Jun 2024 09:12:16 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B20D52115FA;
	Mon, 24 Jun 2024 09:11:04 +0200 (CEST)
Received: from localhost (10.48.86.164) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 24 Jun
 2024 09:11:03 +0200
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
Subject: [net-next,PATCH v3 2/2] net: stmmac: dwmac-stm32: stm32: add management of stm32mp25 for stm32
Date: Mon, 24 Jun 2024 09:10:52 +0200
Message-ID: <20240624071052.118042-3-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240624071052.118042-1-christophe.roullier@foss.st.com>
References: <20240624071052.118042-1-christophe.roullier@foss.st.com>
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
 definitions=2024-06-24_06,2024-06-21_01,2024-05-17_01

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
Reviewed-by: Simon Horman <horms@kernel.org>
---
 .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 80 ++++++++++++++++++-
 1 file changed, 77 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
index b2db0e26c4e4..23cf0a5b047f 100644
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
 
@@ -277,8 +288,55 @@ static int stm32mp1_configure_pmcr(struct plat_stmmacenet_data *plat_dat)
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
+		/* ETH_REF_CLK_SEL bit in SYSCFG register is not applicable in MII mode */
+		break;
+	case PHY_INTERFACE_MODE_RMII:
+		val = SYSCFG_ETHCR_ETH_SEL_RMII;
+		if (dwmac->enable_eth_ck) {
+			/* Internal clock ETH_CLK of 50MHz from RCC is used */
+			val |= SYSCFG_ETHCR_ETH_REF_CLK_SEL;
+		}
+		break;
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		val = SYSCFG_ETHCR_ETH_SEL_RGMII;
+		fallthrough;
+	case PHY_INTERFACE_MODE_GMII:
+		if (dwmac->enable_eth_ck) {
+			/* Internal clock ETH_CLK of 125MHz from RCC is used */
+			val |= SYSCFG_ETHCR_ETH_CLK_SEL;
+		}
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
@@ -289,7 +347,10 @@ static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
 	if (ret)
 		return ret;
 
-	return stm32mp1_configure_pmcr(plat_dat);
+	if (!dwmac->ops->is_mp2)
+		return stm32mp1_configure_pmcr(plat_dat);
+	else
+		return stm32mp2_configure_syscfg(plat_dat);
 }
 
 static int stm32mcu_set_mode(struct plat_stmmacenet_data *plat_dat)
@@ -365,6 +426,9 @@ static int stm32_dwmac_parse_data(struct stm32_dwmac *dwmac,
 		return err;
 	}
 
+	if (dwmac->ops->is_mp2)
+		return 0;
+
 	dwmac->mode_mask = SYSCFG_MP1_ETH_MASK;
 	err = of_property_read_u32_index(np, "st,syscon", 2, &dwmac->mode_mask);
 	if (err) {
@@ -586,10 +650,20 @@ static struct stm32_ops stm32mp13_dwmac_data = {
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


