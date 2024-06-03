Return-Path: <netdev+bounces-100117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F18F8D7EB0
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 11:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41BDB1C21524
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 09:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAEC83CC7;
	Mon,  3 Jun 2024 09:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Mjt4/0x5"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7720D83CB9;
	Mon,  3 Jun 2024 09:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407005; cv=none; b=Og73ZQxbn1L53Q3t4DCJpkyu/y8bcPiaaT7pBUAiPWEvzJZEr0sTJMlAZnFAYOs4e6NFrLfT+ViFAX0KGTzpoaUW0ioCfYgADgCXODrM+eO6wLOIHW3nCnblcWeWyBE64UmYu2OIx5U75MDT4zXeChG9grP8Kml/SSKFXND4658=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407005; c=relaxed/simple;
	bh=rdJtfhph+hLZ2lYGpKFVOHQL4dRcHFL/cFGJNs9ogJ8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RmHXVfVam5kSSUW2q5rUSsXwYrvhL9G82EatVA2h+V2zLMSHfc4OvwgDcV5rFVfyCA51RtyS+0xM8rkxSAz1p2MDobEz1SDfvxPvTsDYk/w+6kI101PhOkjBUO+5ulfN7GbHK7MQAMfjXtq1CLitNgbQse9CkOgp12vjEAuOyAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Mjt4/0x5; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4537qiGh015946;
	Mon, 3 Jun 2024 11:29:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	lcAvsqELl6jUZPQHeRxSdcGy/zKpLDLoRCPQpNH9kEQ=; b=Mjt4/0x5JCUc7I7R
	ldFWP9DXUt3W0i+vMXZkj98IUzw7fQI3/hEg42xeX/ISuLowvmbY6mjkaK889amQ
	om1b1QUcB7I8XwlvDe428xKXnXnJMS+GgNU4+OKWGDvRhG7a0PNdivXFm4a4Ho4y
	qDkK05xDz1Eul+lo00MUEYsh8GDWiX3TIMJTwBPL3nEhDaHwHSwb+Zurd/vZT8Ze
	YL7I0a4al4+S2JvEVWREcwzyihqbjbGQ+K0WIEdlFKaIo2JqtbjKA4omHFhT4RlB
	ox7eJhcAsUuuiQieKYqeUeOA0ayiMWHAHK6uQKGVPhtb0v9WXaxiS6ldaWhJ9i1/
	kPd4Mg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ygd70mehe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 11:29:33 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A06874004C;
	Mon,  3 Jun 2024 11:29:29 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BD5FE216607;
	Mon,  3 Jun 2024 11:28:17 +0200 (CEST)
Received: from localhost (10.48.86.164) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 3 Jun
 2024 11:28:17 +0200
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
Subject: [PATCH v3 03/11] net: stmmac: dwmac-stm32: Separate out external clock selector
Date: Mon, 3 Jun 2024 11:27:49 +0200
Message-ID: <20240603092757.71902-4-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240603092757.71902-1-christophe.roullier@foss.st.com>
References: <20240603092757.71902-1-christophe.roullier@foss.st.com>
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
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_06,2024-05-30_01,2024-05-17_01

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
---
 .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 50 ++++++++++++++-----
 1 file changed, 38 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
index 43340a5573c64..e552cc25fb808 100644
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
@@ -197,28 +228,25 @@ static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
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
@@ -226,10 +254,8 @@ static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
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


