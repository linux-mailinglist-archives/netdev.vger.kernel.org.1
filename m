Return-Path: <netdev+bounces-102170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA74901BB4
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 09:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CB61B2138D
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 07:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86423224DD;
	Mon, 10 Jun 2024 07:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="suWFUsIA"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88F220DC3;
	Mon, 10 Jun 2024 07:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718003893; cv=none; b=m7OMYU5NQyn2CUY+78s1oQBYT2qpB3VGiOYO73DBFDIa0aQM1tNsQFD+KZuvooc4UXgfTjevz/BTeYU7zaL/O4DLINaEB9guK5ovSiwTWMoUpFQ0PtGw6eyvLW0GeDdLMBXbFZ3MGhAC2tLudJduVy7QEMJA0gaMrxAL2GLzaeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718003893; c=relaxed/simple;
	bh=H8eiIzBHxQY9PUGjusuwqWX+XJdF4wVRO6RyxVH63Xs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UfZmAhl8+8sJda8y3f65b+g0oLXuEw2BO8rw608fnjbfGQZZFDXT4yZ5smRqFp7CfOS8NDIsRh9q3WzJ57L1bZQf+p6YupT9eEJ6FyAu2ODMGriUzoXsE3NU/ZuB3TBsqUdoYVeeBgtb1h7HRAShSOk0vQpLD5T/ilG1B+FCRqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=suWFUsIA; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 459MLNBQ004702;
	Mon, 10 Jun 2024 09:17:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	tKwMHB/a9GI7zhrFn6hxQvgCOtZi4d3e8K6lurTX/xA=; b=suWFUsIAjciD3kDi
	BkmN5cVoAt6KJE/d+LHRlg9qMHNJV/yUpGzzWMMI/T0wu3W930apulf8GwkHW6pj
	YtXQkep/nd/oFGaf0fcjjeZp8ixpqsiciFpPP6Ty1COIWDQICp01R8uthqtPfC1g
	PXydCFGGYnCOsWneqZGKGFyGr4yMZ+9d4C1s0Xtr4XQom3Qrklxei2x4S2PLpABC
	61k15YTnrlXMqBGcrLcAVKrw6sPljSch4PW+hc8rGBcvHKvQihsMCGnTFAbk5I37
	M0g1z61nd+UFt9HDNu0qgMiqGToflXSDgd8WjzNPDeNq1yPjc1lXSfv+n2qtADrq
	g8oq3w==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yn0v13bgv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 09:17:49 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 741A140045;
	Mon, 10 Jun 2024 09:17:45 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 32685210757;
	Mon, 10 Jun 2024 09:16:33 +0200 (CEST)
Received: from localhost (10.48.86.164) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 10 Jun
 2024 09:16:32 +0200
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
Subject: [net-next,PATCH v6 7/8] net: stmmac: dwmac-stm32: Mask support for PMCR configuration
Date: Mon, 10 Jun 2024 09:14:58 +0200
Message-ID: <20240610071459.287500-8-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240610071459.287500-1-christophe.roullier@foss.st.com>
References: <20240610071459.287500-1-christophe.roullier@foss.st.com>
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
 definitions=2024-06-10_02,2024-06-06_02,2024-05-17_01

Add possibility to have second argument in syscon property to manage
mask. This mask will be used to address right BITFIELDS of PMCR register.

Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 28 +++++++++++++------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
index bed2be129b2d2..09ff0be0bdcdc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
@@ -90,6 +90,7 @@ struct stm32_dwmac {
 	int eth_ref_clk_sel_reg;
 	int irq_pwr_wakeup;
 	u32 mode_reg;		 /* MAC glue-logic mode register */
+	u32 mode_mask;
 	struct regmap *regmap;
 	u32 speed;
 	const struct stm32_ops *ops;
@@ -102,8 +103,8 @@ struct stm32_ops {
 	void (*resume)(struct stm32_dwmac *dwmac);
 	int (*parse_data)(struct stm32_dwmac *dwmac,
 			  struct device *dev);
-	u32 syscfg_eth_mask;
 	bool clk_rx_enable_in_suspend;
+	u32 syscfg_clr_off;
 };
 
 static int stm32_dwmac_clk_enable(struct stm32_dwmac *dwmac, bool resume)
@@ -256,13 +257,16 @@ static int stm32mp1_configure_pmcr(struct plat_stmmacenet_data *plat_dat)
 
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
@@ -303,7 +307,7 @@ static int stm32mcu_set_mode(struct plat_stmmacenet_data *plat_dat)
 	dev_dbg(dwmac->dev, "Mode %s", phy_modes(plat_dat->mac_interface));
 
 	return regmap_update_bits(dwmac->regmap, reg,
-				 dwmac->ops->syscfg_eth_mask, val << 23);
+				 SYSCFG_MCU_ETH_MASK, val << 23);
 }
 
 static void stm32_dwmac_clk_disable(struct stm32_dwmac *dwmac, bool suspend)
@@ -348,8 +352,15 @@ static int stm32_dwmac_parse_data(struct stm32_dwmac *dwmac,
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
+		dev_dbg(dev, "Warning sysconfig register mask not set\n");
 
 	return err;
 }
@@ -540,8 +551,7 @@ static SIMPLE_DEV_PM_OPS(stm32_dwmac_pm_ops,
 	stm32_dwmac_suspend, stm32_dwmac_resume);
 
 static struct stm32_ops stm32mcu_dwmac_data = {
-	.set_mode = stm32mcu_set_mode,
-	.syscfg_eth_mask = SYSCFG_MCU_ETH_MASK
+	.set_mode = stm32mcu_set_mode
 };
 
 static struct stm32_ops stm32mp1_dwmac_data = {
@@ -549,7 +559,7 @@ static struct stm32_ops stm32mp1_dwmac_data = {
 	.suspend = stm32mp1_suspend,
 	.resume = stm32mp1_resume,
 	.parse_data = stm32mp1_parse_data,
-	.syscfg_eth_mask = SYSCFG_MP1_ETH_MASK,
+	.syscfg_clr_off = 0x44,
 	.clk_rx_enable_in_suspend = true
 };
 
-- 
2.25.1


