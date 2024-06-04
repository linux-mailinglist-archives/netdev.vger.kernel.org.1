Return-Path: <netdev+bounces-100622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2E98FB5C1
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 16:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E25221F25999
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 14:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57EDE149C60;
	Tue,  4 Jun 2024 14:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="2ICBHBlk"
X-Original-To: netdev@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9343F146598;
	Tue,  4 Jun 2024 14:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717511910; cv=none; b=kG7erd3xqgm2x8oEFn9jOWMepeneq3OJzaqRdTpn97OP9DR5mwdWXD3O1aJgw2rbAbodXsBfiDi/wyGVA7OFdwOwKzFn/Z7OK/NMOjQFYUox7tmm7+wKEd/XDS1VMz++/UIgLjXLUTalhBZ8jXCdnQHnoDm1KlkAizAgz6kILAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717511910; c=relaxed/simple;
	bh=Wz7+F3RX2ErVq2AoH1Oy/dBnTV8neAuhbUlnFn1Nr6k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QuI4r8aa5bFBfhHA5XG+3PYn1ByBRd4HVSO4EGTTs2eZcXH5KX6WUPiktbdwtZ38/zqcitsGPQa3unUECGz8H6z88m8tZ4khEahobKeQG3T72eIMpGcM0WMg7QMie0GltM3IUmnIOKKEjFPx4BvAVdm24ajChB0CwM7/O9ds5tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=2ICBHBlk; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 454CGpiK018410;
	Tue, 4 Jun 2024 16:38:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	oZt3ANozAyCi4RMnooDgV1ukrsEF0MYMZVmMcPQZSJw=; b=2ICBHBlkKudSvwP7
	+VK/8llMHYrnFFcCvOaDMpvq5YxrEHIR4dbEK0gnff5EEF4Tx0r+GbXtrAcIt8uS
	yG5EOhOdOSpfNd4+8MB4RSE8+mFJck1wW7GJcIAHEUH8Ic8Lh8wFv/EB/UFzj/+d
	1qKHOckC45t1oYRxBWALpTkvzVJ2Arhbt7Kc+jj1iLRJDyQRVS3A3YVwpfC64eaL
	zaoAMSoSahzM0TaWNSNBkzSt0wofZ05d1wqRhPOHWrZbp7YnLQPWioyULMeWs9kf
	3ozEYWEQGRR1+M6mScR9DDe2twcmCuo4EEa5/Bme2HhB02GN4j4yi3JyDeBa+2t6
	2MjTTA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ygekhu10u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 16:38:00 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6BF1A40045;
	Tue,  4 Jun 2024 16:37:56 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E0D4621863F;
	Tue,  4 Jun 2024 16:36:28 +0200 (CEST)
Received: from localhost (10.48.86.164) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 4 Jun
 2024 16:36:28 +0200
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
Subject: [PATCH v4 05/11] net: stmmac: dwmac-stm32: Clean up the debug prints
Date: Tue, 4 Jun 2024 16:34:56 +0200
Message-ID: <20240604143502.154463-6-christophe.roullier@foss.st.com>
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

Use dev_err()/dev_dbg() and phy_modes() to print PHY mode instead of
pr_debug() and hand-written PHY mode decoding. This way, each debug
print has associated device with it and duplicated mode decoding is
removed.

Signed-off-by: Marek Vasut <marex@denx.de>
Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-stm32.c  | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
index aa413edd1ef71..75981ac2cbb56 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
@@ -228,19 +228,16 @@ static int stm32mp1_configure_pmcr(struct plat_stmmacenet_data *plat_dat)
 	switch (plat_dat->mac_interface) {
 	case PHY_INTERFACE_MODE_MII:
 		val = SYSCFG_PMCR_ETH_SEL_MII;
-		pr_debug("SYSCFG init : PHY_INTERFACE_MODE_MII\n");
 		break;
 	case PHY_INTERFACE_MODE_GMII:
 		val = SYSCFG_PMCR_ETH_SEL_GMII;
 		if (dwmac->enable_eth_ck)
 			val |= SYSCFG_PMCR_ETH_CLK_SEL;
-		pr_debug("SYSCFG init : PHY_INTERFACE_MODE_GMII\n");
 		break;
 	case PHY_INTERFACE_MODE_RMII:
 		val = SYSCFG_PMCR_ETH_SEL_RMII;
 		if (dwmac->enable_eth_ck)
 			val |= SYSCFG_PMCR_ETH_REF_CLK_SEL;
-		pr_debug("SYSCFG init : PHY_INTERFACE_MODE_RMII\n");
 		break;
 	case PHY_INTERFACE_MODE_RGMII:
 	case PHY_INTERFACE_MODE_RGMII_ID:
@@ -249,15 +246,16 @@ static int stm32mp1_configure_pmcr(struct plat_stmmacenet_data *plat_dat)
 		val = SYSCFG_PMCR_ETH_SEL_RGMII;
 		if (dwmac->enable_eth_ck)
 			val |= SYSCFG_PMCR_ETH_CLK_SEL;
-		pr_debug("SYSCFG init : PHY_INTERFACE_MODE_RGMII\n");
 		break;
 	default:
-		pr_debug("SYSCFG init :  Do not manage %d interface\n",
-			 plat_dat->mac_interface);
+		dev_err(dwmac->dev, "Mode %s not supported",
+			phy_modes(plat_dat->mac_interface));
 		/* Do not manage others interfaces */
 		return -EINVAL;
 	}
 
+	dev_dbg(dwmac->dev, "Mode %s", phy_modes(plat_dat->mac_interface));
+
 	/* Need to update PMCCLRR (clear register) */
 	regmap_write(dwmac->regmap, reg + SYSCFG_PMCCLRR_OFFSET,
 		     dwmac->ops->syscfg_eth_mask);
@@ -291,19 +289,19 @@ static int stm32mcu_set_mode(struct plat_stmmacenet_data *plat_dat)
 	switch (plat_dat->mac_interface) {
 	case PHY_INTERFACE_MODE_MII:
 		val = SYSCFG_MCU_ETH_SEL_MII;
-		pr_debug("SYSCFG init : PHY_INTERFACE_MODE_MII\n");
 		break;
 	case PHY_INTERFACE_MODE_RMII:
 		val = SYSCFG_MCU_ETH_SEL_RMII;
-		pr_debug("SYSCFG init : PHY_INTERFACE_MODE_RMII\n");
 		break;
 	default:
-		pr_debug("SYSCFG init :  Do not manage %d interface\n",
-			 plat_dat->mac_interface);
+		dev_err(dwmac->dev, "Mode %s not supported",
+			phy_modes(plat_dat->mac_interface));
 		/* Do not manage others interfaces */
 		return -EINVAL;
 	}
 
+	dev_dbg(dwmac->dev, "Mode %s", phy_modes(plat_dat->mac_interface));
+
 	return regmap_update_bits(dwmac->regmap, reg,
 				 dwmac->ops->syscfg_eth_mask, val << 23);
 }
-- 
2.25.1


