Return-Path: <netdev+bounces-36787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 339397B1C4F
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 14:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id E38361C20A2C
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 12:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357FF38DE2;
	Thu, 28 Sep 2023 12:26:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8BD38DC5;
	Thu, 28 Sep 2023 12:26:19 +0000 (UTC)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C5D1A6;
	Thu, 28 Sep 2023 05:26:16 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38S8X9Cs030339;
	Thu, 28 Sep 2023 14:25:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=RBXVmwb6jNT2iUShZk/ZgEGot9S1AER/3jhHyMGTE+c=; b=6X
	IlU/PSF6bD1gmosvt9vRKIHyITYHMwGbdQA1LpguAGHGIq08NT8ZWBTsZ+AP3LBg
	MY9nvlp+mA98Dc+AawUYzTIlebNN5qAo5Ao7KJO1+qmt1JSe0o3slF0hwoHKYO+u
	arjJe4RTAW3IkZDrMaCWpN1IgMJ4oPPONGYfzrshM3hR9LpuaX40CX/QK/ufcqIC
	0PD/f3l2Z2JUkVbuOMuTeWE5yQ/9sB4/pRTjzsEFj5gj+273NNdmhan2ThD7OJ6U
	ok6UCnk1wtOzrgwQfODjnF+vFW/Qw5kQ/z2TbuJLF7indfDWfdAmtjJX5L4mtJeG
	C7Sww5vriUbszct0FIrw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3tcq63c40b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Sep 2023 14:25:49 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D99F9100057;
	Thu, 28 Sep 2023 14:25:47 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D1A7622F7B0;
	Thu, 28 Sep 2023 14:25:47 +0200 (CEST)
Received: from localhost (10.201.21.249) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 28 Sep
 2023 14:25:46 +0200
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
	<christophe.roullier@foss.st.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 06/12] net: ethernet: stmmac: stm32: update config management for phy wo cristal
Date: Thu, 28 Sep 2023 14:24:21 +0200
Message-ID: <20230928122427.313271-7-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230928122427.313271-1-christophe.roullier@foss.st.com>
References: <20230928122427.313271-1-christophe.roullier@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.21.249]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_11,2023-09-28_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Christophe Roullier <christophe.roullier@st.com>

Some cleaning because some Ethernet PHY configs do not need to add st,ext-phyclk property
Change print info message "No phy clock provided" only when debug

Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 27 ++++++++++---------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
index a071dc6ffc95b..1210062f0832a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
@@ -55,17 +55,17 @@
  *|         |        |      25MHz    |        50MHz       |                  |
  * ---------------------------------------------------------------------------
  *|  MII    |	 -   |     eth-ck    |	      n/a	  |	  n/a        |
- *|         |        | st,ext-phyclk |                    |		     |
+ *|         |        |	             |                    |		     |
  * ---------------------------------------------------------------------------
  *|  GMII   |	 -   |     eth-ck    |	      n/a	  |	  n/a        |
- *|         |        | st,ext-phyclk |                    |		     |
+ *|         |        |               |                    |		     |
  * ---------------------------------------------------------------------------
  *| RGMII   |	 -   |     eth-ck    |	      n/a	  |      eth-ck      |
- *|         |        | st,ext-phyclk |                    | st,eth-clk-sel or|
+ *|         |        |               |                    | st,eth-clk-sel or|
  *|         |        |               |                    | st,ext-phyclk    |
  * ---------------------------------------------------------------------------
  *| RMII    |	 -   |     eth-ck    |	    eth-ck        |	  n/a        |
- *|         |        | st,ext-phyclk | st,eth-ref-clk-sel |		     |
+ *|         |        |               | st,eth-ref-clk-sel |		     |
  *|         |        |               | or st,ext-phyclk   |		     |
  * ---------------------------------------------------------------------------
  *
@@ -180,23 +180,22 @@ static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
 	dwmac->enable_eth_ck = false;
 	switch (plat_dat->mac_interface) {
 	case PHY_INTERFACE_MODE_MII:
-		if (clk_rate == ETH_CK_F_25M && dwmac->ext_phyclk)
+		if (clk_rate == ETH_CK_F_25M)
 			dwmac->enable_eth_ck = true;
 		val = dwmac->ops->pmcsetr.eth1_selmii;
 		pr_debug("SYSCFG init : PHY_INTERFACE_MODE_MII\n");
 		break;
 	case PHY_INTERFACE_MODE_GMII:
 		val = SYSCFG_PMCR_ETH_SEL_GMII;
-		if (clk_rate == ETH_CK_F_25M &&
-		    (dwmac->eth_clk_sel_reg || dwmac->ext_phyclk)) {
+		if (clk_rate == ETH_CK_F_25M)
 			dwmac->enable_eth_ck = true;
-			val |= dwmac->ops->pmcsetr.eth1_clk_sel;
-		}
 		pr_debug("SYSCFG init : PHY_INTERFACE_MODE_GMII\n");
 		break;
 	case PHY_INTERFACE_MODE_RMII:
 		val = dwmac->ops->pmcsetr.eth1_sel_rmii | dwmac->ops->pmcsetr.eth2_sel_rmii;
-		if ((clk_rate == ETH_CK_F_25M || clk_rate == ETH_CK_F_50M) &&
+		if (clk_rate == ETH_CK_F_25M)
+			dwmac->enable_eth_ck = true;
+		if ((clk_rate == ETH_CK_F_50M) &&
 		    (dwmac->eth_ref_clk_sel_reg || dwmac->ext_phyclk)) {
 			dwmac->enable_eth_ck = true;
 			val |= dwmac->ops->pmcsetr.eth1_ref_clk_sel;
@@ -209,7 +208,9 @@ static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
 	case PHY_INTERFACE_MODE_RGMII_RXID:
 	case PHY_INTERFACE_MODE_RGMII_TXID:
 		val = dwmac->ops->pmcsetr.eth1_sel_rgmii | dwmac->ops->pmcsetr.eth2_sel_rgmii;
-		if ((clk_rate == ETH_CK_F_25M || clk_rate == ETH_CK_F_125M) &&
+		if (clk_rate == ETH_CK_F_25M)
+			dwmac->enable_eth_ck = true;
+		if ((clk_rate == ETH_CK_F_125M) &&
 		    (dwmac->eth_clk_sel_reg || dwmac->ext_phyclk)) {
 			dwmac->enable_eth_ck = true;
 			val |= dwmac->ops->pmcsetr.eth1_clk_sel;
@@ -225,7 +226,7 @@ static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
 	}
 
 	/* Need to update PMCCLRR (clear register) */
-	regmap_write(dwmac->regmap, reg + dwmac->ops->syscfg_clr_off,
+	regmap_write(dwmac->regmap, dwmac->ops->syscfg_clr_off,
 		     dwmac->mode_mask);
 
 	/* Update PMCSETR (set register) */
@@ -332,7 +333,7 @@ static int stm32mp1_parse_data(struct stm32_dwmac *dwmac,
 	/*  Get ETH_CLK clocks */
 	dwmac->clk_eth_ck = devm_clk_get(dev, "eth-ck");
 	if (IS_ERR(dwmac->clk_eth_ck)) {
-		dev_info(dev, "No phy clock provided...\n");
+		dev_dbg(dev, "No phy clock provided...\n");
 		dwmac->clk_eth_ck = NULL;
 	}
 
-- 
2.25.1


