Return-Path: <netdev+bounces-100618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB708FB5AC
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 16:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2098C1F20F93
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 14:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A53C13D24C;
	Tue,  4 Jun 2024 14:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="VXp98KhR"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3298813C8F3;
	Tue,  4 Jun 2024 14:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717511856; cv=none; b=Zi8w8H+YApE4Dwonm6HvHxMfFuH+/vuBjpONOcAij8aUnivrA1a1FhHnSZ6JHsIh0vHKGaQWlfBQ8vk6E418PepioaUjIzJc8lIKamqmnv/uz0D54JUatU9rE1eoNHBpovKM8ChFnra7rV4CjPZgUS4lOYve8y89f+zZXuFWGEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717511856; c=relaxed/simple;
	bh=UlOy0p3j7pmL5fh20BICP2fhsl7bEwrzMBTtDA+Ipb4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SU7lMZfyIE/P9FSdYEKDJb2JlqeYywfs5iwdGzIIyoF4I9VZhfMNUbiaOV/mua8dCB7P0hFfe1l2sXH2PUzCZW5QYgqiYg73l4Y3CJlldeTG0R1ZqWwMiqdX7KY2ubNzMKyI2dedm52afQZgY4zGvjwvQ7pcFgwfV+1tZN1xcuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=VXp98KhR; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 454Ce4ai017323;
	Tue, 4 Jun 2024 16:37:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	Qtsi51OkD95orXuJ7BP71gj2KP4t95Re8jm7bAaIAtM=; b=VXp98KhRRExmdjYq
	OnLaMBvMgVqN+tWCl/yLgcLPBcvneMEbAD8ESJ2nhotSf0K0/6VT7a6eFwM0EFWt
	cyF3Ju6sAKB2dE+o91k7RI+SccdRQqOIV+FyB1gNNF10RCdyUwFTGY52ZagBjwDl
	+4VJw5zUUefhWwJDWi9lje5RH67OJKkEnPKmmZd9QvsXw3fstLrTvVMLx7RKsL76
	QsRIaGKi+lHA8AewZAMP8BJHQ8qEXxmQWczwzHt22bNdmM4P2y6hECROyOOG9A82
	fAP4ccXtZT43Z0k6Udc6dayRvqasexaobZkgrQkg6nRX+ZpNYsbhN5nhKlduOm/U
	LbmlvA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yfw91crjy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 16:37:12 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 10D7740048;
	Tue,  4 Jun 2024 16:37:08 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 67BCD2194C7;
	Tue,  4 Jun 2024 16:36:30 +0200 (CEST)
Received: from localhost (10.48.86.164) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 4 Jun
 2024 16:36:30 +0200
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
Subject: [PATCH v4 07/11] net: ethernet: stmmac: add management of stm32mp13 for stm32
Date: Tue, 4 Jun 2024 16:34:58 +0200
Message-ID: <20240604143502.154463-8-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240604143502.154463-1-christophe.roullier@foss.st.com>
References: <20240604143502.154463-1-christophe.roullier@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_01,2024-05-17_01

Add Ethernet support for STM32MP13.
STM32MP13 is STM32 SOC with 2 GMACs instances.
GMAC IP version is SNPS 4.20.
GMAC IP configure with 1 RX and 1 TX queue.
DMA HW capability register supported
RX Checksum Offload Engine supported
TX Checksum insertion supported
Wake-Up On Lan supported
TSO supported

Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 50 +++++++++++++++----
 1 file changed, 40 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
index bed2be129b2d2..e59f8a845e01e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
@@ -84,12 +84,14 @@ struct stm32_dwmac {
 	struct clk *clk_eth_ck;
 	struct clk *clk_ethstp;
 	struct clk *syscfg_clk;
+	bool is_mp13;
 	int ext_phyclk;
 	int enable_eth_ck;
 	int eth_clk_sel_reg;
 	int eth_ref_clk_sel_reg;
 	int irq_pwr_wakeup;
 	u32 mode_reg;		 /* MAC glue-logic mode register */
+	u32 mode_mask;
 	struct regmap *regmap;
 	u32 speed;
 	const struct stm32_ops *ops;
@@ -102,8 +104,8 @@ struct stm32_ops {
 	void (*resume)(struct stm32_dwmac *dwmac);
 	int (*parse_data)(struct stm32_dwmac *dwmac,
 			  struct device *dev);
-	u32 syscfg_eth_mask;
 	bool clk_rx_enable_in_suspend;
+	u32 syscfg_clr_off;
 };
 
 static int stm32_dwmac_clk_enable(struct stm32_dwmac *dwmac, bool resume)
@@ -227,7 +229,14 @@ static int stm32mp1_configure_pmcr(struct plat_stmmacenet_data *plat_dat)
 
 	switch (plat_dat->mac_interface) {
 	case PHY_INTERFACE_MODE_MII:
-		val = SYSCFG_PMCR_ETH_SEL_MII;
+		/*
+		 * STM32MP15xx supports both MII and GMII, STM32MP13xx MII only.
+		 * SYSCFG_PMCSETR ETH_SELMII is present only on STM32MP15xx and
+		 * acts as a selector between 0:GMII and 1:MII. As STM32MP13xx
+		 * supports only MII, ETH_SELMII is not present.
+		 */
+		if (!dwmac->is_mp13)	/* Select MII mode on STM32MP15xx */
+			val |= SYSCFG_PMCR_ETH_SEL_MII;
 		break;
 	case PHY_INTERFACE_MODE_GMII:
 		val = SYSCFG_PMCR_ETH_SEL_GMII;
@@ -256,13 +265,16 @@ static int stm32mp1_configure_pmcr(struct plat_stmmacenet_data *plat_dat)
 
 	dev_dbg(dwmac->dev, "Mode %s", phy_modes(plat_dat->mac_interface));
 
+	/* Shift value at correct ethernet MAC offset in SYSCFG_PMCSETR */
+	val <<= ffs(dwmac->mode_mask) - ffs(SYSCFG_MP1_ETH_MASK);
+
 	/* Need to update PMCCLRR (clear register) */
-	regmap_write(dwmac->regmap, reg + SYSCFG_PMCCLRR_OFFSET,
-		     dwmac->ops->syscfg_eth_mask);
+	regmap_write(dwmac->regmap, dwmac->ops->syscfg_clr_off,
+		     dwmac->mode_mask);
 
 	/* Update PMCSETR (set register) */
 	return regmap_update_bits(dwmac->regmap, reg,
-				 dwmac->ops->syscfg_eth_mask, val);
+				 dwmac->mode_mask, val);
 }
 
 static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
@@ -303,7 +315,7 @@ static int stm32mcu_set_mode(struct plat_stmmacenet_data *plat_dat)
 	dev_dbg(dwmac->dev, "Mode %s", phy_modes(plat_dat->mac_interface));
 
 	return regmap_update_bits(dwmac->regmap, reg,
-				 dwmac->ops->syscfg_eth_mask, val << 23);
+				 SYSCFG_MCU_ETH_MASK, val << 23);
 }
 
 static void stm32_dwmac_clk_disable(struct stm32_dwmac *dwmac, bool suspend)
@@ -348,8 +360,15 @@ static int stm32_dwmac_parse_data(struct stm32_dwmac *dwmac,
 		return PTR_ERR(dwmac->regmap);
 
 	err = of_property_read_u32_index(np, "st,syscon", 1, &dwmac->mode_reg);
-	if (err)
+	if (err) {
 		dev_err(dev, "Can't get sysconfig mode offset (%d)\n", err);
+		return err;
+	}
+
+	dwmac->mode_mask = SYSCFG_MP1_ETH_MASK;
+	err = of_property_read_u32_index(np, "st,syscon", 2, &dwmac->mode_mask);
+	if (err)
+		pr_debug("Warning sysconfig register mask not set\n");
 
 	return err;
 }
@@ -361,6 +380,8 @@ static int stm32mp1_parse_data(struct stm32_dwmac *dwmac,
 	struct device_node *np = dev->of_node;
 	int err = 0;
 
+	dwmac->is_mp13 = of_device_is_compatible(np, "st,stm32mp13-dwmac");
+
 	/* Ethernet PHY have no crystal */
 	dwmac->ext_phyclk = of_property_read_bool(np, "st,ext-phyclk");
 
@@ -540,8 +561,7 @@ static SIMPLE_DEV_PM_OPS(stm32_dwmac_pm_ops,
 	stm32_dwmac_suspend, stm32_dwmac_resume);
 
 static struct stm32_ops stm32mcu_dwmac_data = {
-	.set_mode = stm32mcu_set_mode,
-	.syscfg_eth_mask = SYSCFG_MCU_ETH_MASK
+	.set_mode = stm32mcu_set_mode
 };
 
 static struct stm32_ops stm32mp1_dwmac_data = {
@@ -549,13 +569,23 @@ static struct stm32_ops stm32mp1_dwmac_data = {
 	.suspend = stm32mp1_suspend,
 	.resume = stm32mp1_resume,
 	.parse_data = stm32mp1_parse_data,
-	.syscfg_eth_mask = SYSCFG_MP1_ETH_MASK,
+	.syscfg_clr_off = 0x44,
+	.clk_rx_enable_in_suspend = true
+};
+
+static struct stm32_ops stm32mp13_dwmac_data = {
+	.set_mode = stm32mp1_set_mode,
+	.suspend = stm32mp1_suspend,
+	.resume = stm32mp1_resume,
+	.parse_data = stm32mp1_parse_data,
+	.syscfg_clr_off = 0x08,
 	.clk_rx_enable_in_suspend = true
 };
 
 static const struct of_device_id stm32_dwmac_match[] = {
 	{ .compatible = "st,stm32-dwmac", .data = &stm32mcu_dwmac_data},
 	{ .compatible = "st,stm32mp1-dwmac", .data = &stm32mp1_dwmac_data},
+	{ .compatible = "st,stm32mp13-dwmac", .data = &stm32mp13_dwmac_data},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, stm32_dwmac_match);
-- 
2.25.1


