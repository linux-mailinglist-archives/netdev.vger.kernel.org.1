Return-Path: <netdev+bounces-102506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CCD9036B1
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 10:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2485528B2B7
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 08:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDE9175541;
	Tue, 11 Jun 2024 08:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="cPXdHUPh"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAAD171070;
	Tue, 11 Jun 2024 08:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718095089; cv=none; b=b88vZzciV8V4SvEKxgXrHe/FFJbUDUl1/XZjq6Usy4FgKddqiHxx8hHwNISDc2FfxK8zT0/0LDfiARFjhLGqNY1OEaxp4RK0ts9maLMOFAZ99LIiASejDIHdmfyQag/17LvBw7cZAs+WU2Ia4CfaM1QmV4nxLX3NoEMZg3+6VRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718095089; c=relaxed/simple;
	bh=rGcaZ0VGv8udXfKFLKOy28TL4PVRCK+Ax7blDy7Y90o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GETGMDY4ZRYMj6k+lqZbLAc4FgR5xVEbgFeoKpx5HeOAHopht0y+9+cOh8qC7Lgn26i8Wdxiy444/QJz13LAfUqg5DvaBX27jOTPGzTSNxldKPZNiC53gNlXWlb2sbLi/wEZaT1FHfmjirRAlTeqrA6I6+e8Z16qxWznKHq4Hh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=cPXdHUPh; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45B7Xube012243;
	Tue, 11 Jun 2024 10:37:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	AmLKDPb0oT6lLe6SQe3GR2w8UgmNAhsCLM0PNSYGh9g=; b=cPXdHUPh1Ysy+xWh
	x69Gpz8FJl6JSBHL7auQ+lYzBcFY22aKxPcII0gmc6RqlqDK2NDKHH+HQ2M/IGqb
	z4mNR1QzGN4J7QyFCqlybD51OKu6k0OVsW/hrSmr1sZcb7zkOl4z4IS4PjOEi1de
	6/UfZjC9x5QAblLfdcriYA2WntYWW/pCopZGwspj9xmoBX9glZ1RKIdbsUKFyC8L
	Fk/tZVs89pL2Eq7pp+c7dHKkLCYPpHh1Pnmzl/YuQXMzr6bkDMYfYGMsG5LZZ9CB
	0cX0xuIePwonJkMOaGa1OMG3YzWbQBze6Ilm1HyO0uMPQ4Aa38jO9nin8H/69HmQ
	pKI6TA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ypbp3srxn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 10:37:39 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 4101F40046;
	Tue, 11 Jun 2024 10:37:34 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 618192115EF;
	Tue, 11 Jun 2024 10:36:21 +0200 (CEST)
Received: from localhost (10.48.86.164) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 11 Jun
 2024 10:36:20 +0200
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
Subject: [net-next,PATCH v7 3/8] net: stmmac: dwmac-stm32: Separate out external clock selector
Date: Tue, 11 Jun 2024 10:36:01 +0200
Message-ID: <20240611083606.733453-4-christophe.roullier@foss.st.com>
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

Pull the external clock selector into a separate function, to avoid
conflating it with external clock rate validation and clock mux
register configuration. This should make the code easier to read and
understand.

The dwmac->enable_eth_ck variable in the end indicates whether the MAC
clock are supplied by external oscillator (true) or internal RCC clock
IP (false). The dwmac->enable_eth_ck value is set based on multiple DT
properties, some of them deprecated, some of them specific to bus mode.

The following DT properties and variables are taken into account. In
each case, if the property is present or true, MAC clock is supplied
by external oscillator.
- "st,ext-phyclk", assigned to variable dwmac->ext_phyclk
  - Used in any mode (MII/RMII/GMII/RGMII)
  - The only non-deprecated DT property of the three
- "st,eth-clk-sel", assigned to variable dwmac->eth_clk_sel_reg
  - Valid only in GMII/RGMII mode
  - Deprecated property, backward compatibility only
- "st,eth-ref-clk-sel", assigned to variable dwmac->eth_ref_clk_sel_reg
  - Valid only in RMII mode
  - Deprecated property, backward compatibility only

The stm32mp1_select_ethck_external() function handles the aforementioned
DT properties and sets dwmac->enable_eth_ck accordingly.

The stm32mp1_set_mode() is adjusted to call stm32mp1_select_ethck_external()
first and then only use dwmac->enable_eth_ck to determine hardware clock mux
settings.

No functional change intended.

Signed-off-by: Marek Vasut <marex@denx.de>
Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 50 ++++++++++++++-----
 1 file changed, 38 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
index 2fd2620ebed69..767994061ea82 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
@@ -157,6 +157,37 @@ static int stm32_dwmac_init(struct plat_stmmacenet_data *plat_dat, bool resume)
 	return stm32_dwmac_clk_enable(dwmac, resume);
 }
 
+static int stm32mp1_select_ethck_external(struct plat_stmmacenet_data *plat_dat)
+{
+	struct stm32_dwmac *dwmac = plat_dat->bsp_priv;
+
+	switch (plat_dat->mac_interface) {
+	case PHY_INTERFACE_MODE_MII:
+		dwmac->enable_eth_ck = dwmac->ext_phyclk;
+		return 0;
+	case PHY_INTERFACE_MODE_GMII:
+		dwmac->enable_eth_ck = dwmac->eth_clk_sel_reg ||
+				       dwmac->ext_phyclk;
+		return 0;
+	case PHY_INTERFACE_MODE_RMII:
+		dwmac->enable_eth_ck = dwmac->eth_ref_clk_sel_reg ||
+				       dwmac->ext_phyclk;
+		return 0;
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		dwmac->enable_eth_ck = dwmac->eth_clk_sel_reg ||
+				       dwmac->ext_phyclk;
+		return 0;
+	default:
+		dwmac->enable_eth_ck = false;
+		dev_err(dwmac->dev, "Mode %s not supported",
+			phy_modes(plat_dat->mac_interface));
+		return -EINVAL;
+	}
+}
+
 static int stm32mp1_validate_ethck_rate(struct plat_stmmacenet_data *plat_dat)
 {
 	struct stm32_dwmac *dwmac = plat_dat->bsp_priv;
@@ -194,28 +225,25 @@ static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
 	u32 reg = dwmac->mode_reg;
 	int val, ret;
 
-	dwmac->enable_eth_ck = false;
+	ret = stm32mp1_select_ethck_external(plat_dat);
+	if (ret)
+		return ret;
+
 	switch (plat_dat->mac_interface) {
 	case PHY_INTERFACE_MODE_MII:
-		if (dwmac->ext_phyclk)
-			dwmac->enable_eth_ck = true;
 		val = SYSCFG_PMCR_ETH_SEL_MII;
 		pr_debug("SYSCFG init : PHY_INTERFACE_MODE_MII\n");
 		break;
 	case PHY_INTERFACE_MODE_GMII:
 		val = SYSCFG_PMCR_ETH_SEL_GMII;
-		if (dwmac->eth_clk_sel_reg || dwmac->ext_phyclk) {
-			dwmac->enable_eth_ck = true;
+		if (dwmac->enable_eth_ck)
 			val |= SYSCFG_PMCR_ETH_CLK_SEL;
-		}
 		pr_debug("SYSCFG init : PHY_INTERFACE_MODE_GMII\n");
 		break;
 	case PHY_INTERFACE_MODE_RMII:
 		val = SYSCFG_PMCR_ETH_SEL_RMII;
-		if (dwmac->eth_ref_clk_sel_reg || dwmac->ext_phyclk) {
-			dwmac->enable_eth_ck = true;
+		if (dwmac->enable_eth_ck)
 			val |= SYSCFG_PMCR_ETH_REF_CLK_SEL;
-		}
 		pr_debug("SYSCFG init : PHY_INTERFACE_MODE_RMII\n");
 		break;
 	case PHY_INTERFACE_MODE_RGMII:
@@ -223,10 +251,8 @@ static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
 	case PHY_INTERFACE_MODE_RGMII_RXID:
 	case PHY_INTERFACE_MODE_RGMII_TXID:
 		val = SYSCFG_PMCR_ETH_SEL_RGMII;
-		if (dwmac->eth_clk_sel_reg || dwmac->ext_phyclk) {
-			dwmac->enable_eth_ck = true;
+		if (dwmac->enable_eth_ck)
 			val |= SYSCFG_PMCR_ETH_CLK_SEL;
-		}
 		pr_debug("SYSCFG init : PHY_INTERFACE_MODE_RGMII\n");
 		break;
 	default:
-- 
2.25.1


