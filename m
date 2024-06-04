Return-Path: <netdev+bounces-100617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9158FB5AA
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 16:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71C251F217E4
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 14:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BAA13CABB;
	Tue,  4 Jun 2024 14:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="o+mGrcWR"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE40713C8F3;
	Tue,  4 Jun 2024 14:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717511846; cv=none; b=muen7ZnU4v3C4mex7BSo4ekIUUtGeYzLOgTvJo0WoGFHIzQAaiCxxMwjlZzqzk4LZWYcQC40nXrPOynPY98vAkGSRBFbbaZap6NKQwZmMbjOz5BjPFwhTV4dM/PO3gR/B7fsXB5LwvuCxdi6igKQF3RTlAfe0o7F2NImCKdCtU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717511846; c=relaxed/simple;
	bh=4ReEvZ3YMTsel2O+pdyqhEIiXDnQjJL5tEslUc8t7uc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gSLphRFKTlgxUdhO99YzIVN5/M+JnTakiVOTEeG6klxuYn3/3k0641ksqbT8ArA1qxKbEUHRlfxNvtYp3HKO6U3w3IhMxTPkxbXeFpRF4nodqp8xCZ9tvppWZhSelyn0BbDNqIkfNNyV36Ws0AoW6tLYpCuUerBefLXIkNbfrUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=o+mGrcWR; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 454D3WVP013277;
	Tue, 4 Jun 2024 16:36:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	/OmtwMsCMco5+OxoVhTDHTBCpJiZ7k0ipDGHWcZBqQI=; b=o+mGrcWRe+5AwoKW
	7J07ja4rbuVnr4bSQWMDs+qXCm8Q6EsGnz9Ib9RydvFbCcP7gjwhqxPr0uQ2i4nA
	JlxCNfn+bHDiBEXI081wald72XoJeBByuL/uA/xvNQ1BUKJyXqNzUwTDKCr4EUnB
	VBgPsoZ9lNDOjgbCnGG6vWKoP4LTMfgEx+ljZ/XgohUnsxDO806dee8z6LZOnTzl
	9r4gPSi0FNdZXvcpcewDONdynz254md/Q3TtmFpBawhjTcIVs3tYLVkyGH58ONLp
	Dzl1YaT1Ri0qinE4PcuzONJbrTky0haQy9DWTQ4xRniADb3rZMbkBGaz9HDJZnvi
	SMWI3g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yfw30ceuh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 16:36:37 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id AC0AD40048;
	Tue,  4 Jun 2024 16:36:31 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B3ECD221950;
	Tue,  4 Jun 2024 16:35:18 +0200 (CEST)
Received: from localhost (10.48.86.164) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 4 Jun
 2024 16:35:17 +0200
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
Subject: [PATCH v4 04/11] net: stmmac: dwmac-stm32: Extract PMCR configuration
Date: Tue, 4 Jun 2024 16:34:55 +0200
Message-ID: <20240604143502.154463-5-christophe.roullier@foss.st.com>
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

Pull the PMCR clock mux configuration into a separate function. This is
the final change of three, which moves external clock rate validation,
external clock selector decoding, and clock mux configuration into
separate functions. This should make the code easier to undrestand.
No functional change intended.

Signed-off-by: Marek Vasut <marex@denx.de>
Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 27 ++++++++++++-------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
index 767994061ea82..aa413edd1ef71 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
@@ -219,15 +219,11 @@ static int stm32mp1_validate_ethck_rate(struct plat_stmmacenet_data *plat_dat)
 	return -EINVAL;
 }
 
-static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
+static int stm32mp1_configure_pmcr(struct plat_stmmacenet_data *plat_dat)
 {
 	struct stm32_dwmac *dwmac = plat_dat->bsp_priv;
 	u32 reg = dwmac->mode_reg;
-	int val, ret;
-
-	ret = stm32mp1_select_ethck_external(plat_dat);
-	if (ret)
-		return ret;
+	int val;
 
 	switch (plat_dat->mac_interface) {
 	case PHY_INTERFACE_MODE_MII:
@@ -262,10 +258,6 @@ static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
 		return -EINVAL;
 	}
 
-	ret = stm32mp1_validate_ethck_rate(plat_dat);
-	if (ret)
-		return ret;
-
 	/* Need to update PMCCLRR (clear register) */
 	regmap_write(dwmac->regmap, reg + SYSCFG_PMCCLRR_OFFSET,
 		     dwmac->ops->syscfg_eth_mask);
@@ -275,6 +267,21 @@ static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
 				 dwmac->ops->syscfg_eth_mask, val);
 }
 
+static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
+{
+	int ret;
+
+	ret = stm32mp1_select_ethck_external(plat_dat);
+	if (ret)
+		return ret;
+
+	ret = stm32mp1_validate_ethck_rate(plat_dat);
+	if (ret)
+		return ret;
+
+	return stm32mp1_configure_pmcr(plat_dat);
+}
+
 static int stm32mcu_set_mode(struct plat_stmmacenet_data *plat_dat)
 {
 	struct stm32_dwmac *dwmac = plat_dat->bsp_priv;
-- 
2.25.1


