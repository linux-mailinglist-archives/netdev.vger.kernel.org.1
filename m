Return-Path: <netdev+bounces-100116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BFA8D7EAC
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 11:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2C342835E3
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 09:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E2B8288D;
	Mon,  3 Jun 2024 09:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="NCnaNjZX"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA967F7D1;
	Mon,  3 Jun 2024 09:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717406997; cv=none; b=YoypdNf6IUGOiizCAJkqy9YRC1Z8rjAEMwh7/UiFeDSBHyVNqNe+MvTQPHz8nDEy9yBImkI2NweZ0zvDyUi/9+7RDYgARNcOaLVnL9RsLqOl7l1c0CTtthrO5Vi3/CKwmKA/QAySWhuNEFAuXng5hXzxPYjTYRfDnUWRTtkdKrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717406997; c=relaxed/simple;
	bh=zZpUxLIarKYONqj/ZMVX9yq5C5SdLObwN5DcN2J1M/w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RrhA4NB8TCmtiXhXgOZp+KF0tIsVNfn8z3zk5B+s5mhtFjL0ueR5e4Y7ka/FeBfhvhHNFsvZXc48m6SmunsnTdZDcw7v9CN5UB1MHnK6idKN6cK0/2wsKiyLPXESZi5/3AbWoeGyt4xohmb0V+TQHZzsRhbaSHZmimOo9fIRUw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=NCnaNjZX; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45383drX004820;
	Mon, 3 Jun 2024 11:29:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	HglNv9xGA0NA77G9PJv3ku4Y5ttFUl9hYKGQ1P8OTOw=; b=NCnaNjZXSaGFNhmL
	YzedDmLANby/w06kvwULu7NcydhqLbKLF8usuHPUXHvtxxvyQWC0WUOylJgxCfFl
	+F2GWceH1qTugPmGCUPvn70jeiUNpTjcyAmSRWMAZJzGYN4//ZLWhxPUjpjRCHn9
	rpVXKKCp6XhHaFx+846IpUTwKsrUtiy12wBQ2INT6lTxmstw0NaMbgVkGszg/1DR
	w4rYDvdJnUlf7bKL6XU4lMNqUKau5pT6ar8YXOURgu5xYMrtqatE2AChStr3zU6g
	QvAT6TDXvr5BVkf2K33/ZPe6tfvAUTKJwRSvqayVaW564A6HKxvvAkChRDEJWBqM
	81GxpQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yfw305ytj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 11:29:33 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9FE4940046;
	Mon,  3 Jun 2024 11:29:29 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 85D83216606;
	Mon,  3 Jun 2024 11:28:17 +0200 (CEST)
Received: from localhost (10.48.86.164) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 3 Jun
 2024 11:28:16 +0200
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
Subject: [PATCH v3 02/11] net: stmmac: dwmac-stm32: Separate out external clock rate validation
Date: Mon, 3 Jun 2024 11:27:48 +0200
Message-ID: <20240603092757.71902-3-christophe.roullier@foss.st.com>
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
---
 .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 54 +++++++++++++++----
 1 file changed, 44 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
index c92dfc4ecf570..43340a5573c64 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
@@ -157,25 +157,57 @@ static int stm32_dwmac_init(struct plat_stmmacenet_data *plat_dat, bool resume)
 	return stm32_dwmac_clk_enable(dwmac, resume);
 }
 
+static int stm32mp1_validate_ethck_rate(struct plat_stmmacenet_data *plat_dat)
+{
+	struct stm32_dwmac *dwmac = plat_dat->bsp_priv;
+	const u32 clk_rate = clk_get_rate(dwmac->clk_eth_ck);
+
+	switch (plat_dat->mac_interface) {
+	case PHY_INTERFACE_MODE_MII:
+		if (clk_rate == ETH_CK_F_25M)
+			return 0;
+		break;
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
@@ -183,8 +215,7 @@ static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
 		break;
 	case PHY_INTERFACE_MODE_RMII:
 		val = SYSCFG_PMCR_ETH_SEL_RMII;
-		if ((clk_rate == ETH_CK_F_25M || clk_rate == ETH_CK_F_50M) &&
-		    (dwmac->eth_ref_clk_sel_reg || dwmac->ext_phyclk)) {
+		if (dwmac->eth_ref_clk_sel_reg || dwmac->ext_phyclk) {
 			dwmac->enable_eth_ck = true;
 			val |= SYSCFG_PMCR_ETH_REF_CLK_SEL;
 		}
@@ -195,8 +226,7 @@ static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
 	case PHY_INTERFACE_MODE_RGMII_RXID:
 	case PHY_INTERFACE_MODE_RGMII_TXID:
 		val = SYSCFG_PMCR_ETH_SEL_RGMII;
-		if ((clk_rate == ETH_CK_F_25M || clk_rate == ETH_CK_F_125M) &&
-		    (dwmac->eth_clk_sel_reg || dwmac->ext_phyclk)) {
+		if (dwmac->eth_clk_sel_reg || dwmac->ext_phyclk) {
 			dwmac->enable_eth_ck = true;
 			val |= SYSCFG_PMCR_ETH_CLK_SEL;
 		}
@@ -209,6 +239,10 @@ static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
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


