Return-Path: <netdev+bounces-100615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F5F8FB59C
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 16:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 682381F24BC7
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 14:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE927144D22;
	Tue,  4 Jun 2024 14:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="td2IdJDb"
X-Original-To: netdev@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B320513A3F7;
	Tue,  4 Jun 2024 14:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717511833; cv=none; b=h7Q0XX7ykTppE8aSHS9Alv+JNy0AjBkZ+N2cQlJ1W4nTp5YdmIzxUATfdX9R1k0Mx+i1MQieZGKZKFa1PcoFT2bE+UkRqgUWVGM0QvB4vi0fCFGISM3Tp9VKH8cIJ9/uCQKG2X+uBNXavsvdutaxBaOTWszXhc48QL6Igc7FKzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717511833; c=relaxed/simple;
	bh=CzcWoMBzn29QzER+PxKqVEeUMc90IdZvWfmL2zf9o+A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rPdkFFsd+V5vL8C5TQr7ZyPeqsJHoEbd2n8ZOLQj818SYcJ55e9XcWIkFiI03MjhsVZkIf2yZ88VKqchc9BPJeRxZRE5Z7CJEPG2MSkzWV8pEj0pkI8WOTk7k8tlK3vhIWcHSqVY/KfytB1ugJ5HS2yhCEh1fDGel4gGVCTbQLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=td2IdJDb; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 454CFHsB018450;
	Tue, 4 Jun 2024 16:36:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	hN/g428LiD5uWJnzYnUfLINd1g5a/rCwKHJfJu6r5Uo=; b=td2IdJDbQSaXLUNz
	MwzdSbTLeSns5H83J58/7JsGWzCIo+pgbUlvIlRMvWt92vKqlFp/FTcxlNOFoqip
	qlAWlw78v/rT+il1lVgAWJLxY0GM9WaMfgQEuHDi/G22lGTuaOWKfHIrLUMi+X6H
	o3RoBtt+tnNBnBZTQPbOMv2Q71IvMyBCpvgBdjurBhwYrvX/0xNUGy+u/x0xiYb1
	s9TR7ZySO5iL1nUESNFDLrzQoMo1ouIooQhObmbEzT0jx1awe0OG754WP2BXyGP2
	c3VfshEVDhkT/gVfNvsRVC6mB6jCAKvVzZ/Gf8vqW+BSLJoNEs3z/nqBjTaSnegi
	eGv5YA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ygekhu0u7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 16:36:38 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 0F8EF40049;
	Tue,  4 Jun 2024 16:36:34 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 37223221951;
	Tue,  4 Jun 2024 16:35:19 +0200 (CEST)
Received: from localhost (10.48.86.164) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 4 Jun
 2024 16:35:16 +0200
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
Subject: [PATCH v4 02/11] net: stmmac: dwmac-stm32: Separate out external clock rate validation
Date: Tue, 4 Jun 2024 16:34:53 +0200
Message-ID: <20240604143502.154463-3-christophe.roullier@foss.st.com>
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


