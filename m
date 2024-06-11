Return-Path: <netdev+bounces-102509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C89F9036F3
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 10:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B611B22FC9
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 08:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375A7176234;
	Tue, 11 Jun 2024 08:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="m43vXEX5"
X-Original-To: netdev@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50779174EE4;
	Tue, 11 Jun 2024 08:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718095090; cv=none; b=KJ6uVwIbY+k/ikOma2KIanJRalQpVxtGGJxkHf1lAl9gsa+N6kC2YqpcSUv4NlkYInddxBhZ02ZTJtuqrF4xZqBsM9L05vsdZfc3xRVA7ViFMisd6oj1F8SpcNmXZSS43fJXEvVczXXItHZ10uHMNVny+FlrJbPs/DolRw3g9H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718095090; c=relaxed/simple;
	bh=CzcWoMBzn29QzER+PxKqVEeUMc90IdZvWfmL2zf9o+A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GntuZsjUcAGap3NbAS0TQAdnu5fONKUxqbD4sXCQpINZbUxTIG88Zr6iCgdtU/MIuaaX/UddCXicsLuBlSq+w08tTb4P66ubCVL07bWbIxFT8XkLA2Mb/CqLR9ASDnDYjDW4b7QKswPzqvQePmoEljOSvpDPg0MoTmGszzwikQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=m43vXEX5; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45B7UUwQ027884;
	Tue, 11 Jun 2024 10:37:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	hN/g428LiD5uWJnzYnUfLINd1g5a/rCwKHJfJu6r5Uo=; b=m43vXEX5fHBVEBz6
	q5KhhdR1U2YTkLbBD4NX++e0XdIInSkh0wQlYrZPZDRSP0ndK4PwY+5KY7/M25au
	fXAu1fA2sgZr8Rn1FGSavbKbFvCXizpfnxGjo4dcEHdv5FV4yLYhy5bxx798G347
	/kKR6LBgF6q/erHFzUlg8MU0D0lF+dF3pMXJpgPQOomAZ4+h+kQVwAxbx765REHP
	pA0225GXTw57s55yeS2ByJwSJdBnzQyEjCiSqJ2L05EsucYHlw1j/TrkxBmWlS1c
	nXULGxxwKjPRzIr/+1NgLgiuGYTgAru772VpIkm0Q/XJy+Rv0CQ59+KxATaEA+91
	T2hTWQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ypbp29s3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 10:37:39 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 7385640047;
	Tue, 11 Jun 2024 10:37:34 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9C64D210F73;
	Tue, 11 Jun 2024 10:36:20 +0200 (CEST)
Received: from localhost (10.48.86.164) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 11 Jun
 2024 10:36:19 +0200
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
Subject: [net-next,PATCH v7 2/8] net: stmmac: dwmac-stm32: Separate out external clock rate validation
Date: Tue, 11 Jun 2024 10:36:00 +0200
Message-ID: <20240611083606.733453-3-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240611083606.733453-1-christophe.roullier@foss.st.com>
References: <20240611083606.733453-1-christophe.roullier@foss.st.com>
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
 definitions=2024-06-11_04,2024-06-11_01,2024-05-17_01

From: Marek Vasut <marex@denx.de>

Pull the external clock frequency validation into a separate function,
to avoid conflating it with external clock DT property decoding and
clock mux register configuration. This should make the code easier to
read and understand.

This does change the code behavior slightly. The clock mux PMCR register
setting now depends solely on the DT properties which configure the clock
mux between external clock and internal RCC generated clock. The mux PMCR
register settings no longer depend on the supplied clock frequency, that
supplied clock frequency is now only validated, and if the clock frequency
is invalid for a mode, it is rejected.

Previously, the code would switch the PMCR register clock mux to internal
RCC generated clock if external clock couldn't provide suitable frequency,
without checking whether the RCC generated clock frequency is correct. Such
behavior is risky at best, user should have configured their clock correctly
in the first place, so this behavior is removed here.

Signed-off-by: Marek Vasut <marex@denx.de>
Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 51 +++++++++++++++----
 1 file changed, 41 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
index c92dfc4ecf570..2fd2620ebed69 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
@@ -157,25 +157,54 @@ static int stm32_dwmac_init(struct plat_stmmacenet_data *plat_dat, bool resume)
 	return stm32_dwmac_clk_enable(dwmac, resume);
 }
 
+static int stm32mp1_validate_ethck_rate(struct plat_stmmacenet_data *plat_dat)
+{
+	struct stm32_dwmac *dwmac = plat_dat->bsp_priv;
+	const u32 clk_rate = clk_get_rate(dwmac->clk_eth_ck);
+
+	switch (plat_dat->mac_interface) {
+	case PHY_INTERFACE_MODE_MII:
+	case PHY_INTERFACE_MODE_GMII:
+		if (clk_rate == ETH_CK_F_25M)
+			return 0;
+		break;
+	case PHY_INTERFACE_MODE_RMII:
+		if (clk_rate == ETH_CK_F_25M || clk_rate == ETH_CK_F_50M)
+			return 0;
+		break;
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		if (clk_rate == ETH_CK_F_25M || clk_rate == ETH_CK_F_125M)
+			return 0;
+		break;
+	default:
+		break;
+	}
+
+	dev_err(dwmac->dev, "Mode %s does not match eth-ck frequency %d Hz",
+		phy_modes(plat_dat->mac_interface), clk_rate);
+	return -EINVAL;
+}
+
 static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
 {
 	struct stm32_dwmac *dwmac = plat_dat->bsp_priv;
-	u32 reg = dwmac->mode_reg, clk_rate;
-	int val;
+	u32 reg = dwmac->mode_reg;
+	int val, ret;
 
-	clk_rate = clk_get_rate(dwmac->clk_eth_ck);
 	dwmac->enable_eth_ck = false;
 	switch (plat_dat->mac_interface) {
 	case PHY_INTERFACE_MODE_MII:
-		if (clk_rate == ETH_CK_F_25M && dwmac->ext_phyclk)
+		if (dwmac->ext_phyclk)
 			dwmac->enable_eth_ck = true;
 		val = SYSCFG_PMCR_ETH_SEL_MII;
 		pr_debug("SYSCFG init : PHY_INTERFACE_MODE_MII\n");
 		break;
 	case PHY_INTERFACE_MODE_GMII:
 		val = SYSCFG_PMCR_ETH_SEL_GMII;
-		if (clk_rate == ETH_CK_F_25M &&
-		    (dwmac->eth_clk_sel_reg || dwmac->ext_phyclk)) {
+		if (dwmac->eth_clk_sel_reg || dwmac->ext_phyclk) {
 			dwmac->enable_eth_ck = true;
 			val |= SYSCFG_PMCR_ETH_CLK_SEL;
 		}
@@ -183,8 +212,7 @@ static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
 		break;
 	case PHY_INTERFACE_MODE_RMII:
 		val = SYSCFG_PMCR_ETH_SEL_RMII;
-		if ((clk_rate == ETH_CK_F_25M || clk_rate == ETH_CK_F_50M) &&
-		    (dwmac->eth_ref_clk_sel_reg || dwmac->ext_phyclk)) {
+		if (dwmac->eth_ref_clk_sel_reg || dwmac->ext_phyclk) {
 			dwmac->enable_eth_ck = true;
 			val |= SYSCFG_PMCR_ETH_REF_CLK_SEL;
 		}
@@ -195,8 +223,7 @@ static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
 	case PHY_INTERFACE_MODE_RGMII_RXID:
 	case PHY_INTERFACE_MODE_RGMII_TXID:
 		val = SYSCFG_PMCR_ETH_SEL_RGMII;
-		if ((clk_rate == ETH_CK_F_25M || clk_rate == ETH_CK_F_125M) &&
-		    (dwmac->eth_clk_sel_reg || dwmac->ext_phyclk)) {
+		if (dwmac->eth_clk_sel_reg || dwmac->ext_phyclk) {
 			dwmac->enable_eth_ck = true;
 			val |= SYSCFG_PMCR_ETH_CLK_SEL;
 		}
@@ -209,6 +236,10 @@ static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
 		return -EINVAL;
 	}
 
+	ret = stm32mp1_validate_ethck_rate(plat_dat);
+	if (ret)
+		return ret;
+
 	/* Need to update PMCCLRR (clear register) */
 	regmap_write(dwmac->regmap, reg + SYSCFG_PMCCLRR_OFFSET,
 		     dwmac->ops->syscfg_eth_mask);
-- 
2.25.1


