Return-Path: <netdev+bounces-108003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FE691D844
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 08:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2F1CB23329
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 06:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693CB56742;
	Mon,  1 Jul 2024 06:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="lvvNlN3e"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FDF10A0E;
	Mon,  1 Jul 2024 06:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719816654; cv=none; b=dfIvwt+/7i2piAHuED3k0qWfVC1+waMLx8839OTTBxBwQ9vlk1PxLd0q4DI8m65JY2C1SUG3BPEJJvtUztx7J8H1iHPGeuaDFbpZnEXKVAAYv6PstQUCgxMjTjjNrSkJfUc1bDxxF1g+1pv5JvMAHKtVhilMRFYlDV29afYt62A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719816654; c=relaxed/simple;
	bh=NjuVId+T/+0uIuZGXSQUp/Y81pe7XLRu/WRMn52WG3s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=piLq3yBE3zWVZZTkSOFnyg0K/P4OVAyCXkvBr0QPZqNpVxOcYDX7wZ/+TbO7pTDcx0saWRRL2uJvOaKTLzYcLqYVlwMj44UIOBArv+oP52tCjfaBAUGnOElIiTWGgU/2xCMG989CwFjjjPRXRY50cPIPhYcvCk7qnh0ncYx5aW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=lvvNlN3e; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45UJksoG012549;
	Mon, 1 Jul 2024 08:50:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	NQhzgLCE7X5eZ858QNKORAqLKmNLabnQ1nRwLmnzabs=; b=lvvNlN3erwy79GkA
	V8jJhO+cY2yGpDbDXRGU1PE9wThBtK4gAqh9J9X61toDKPfmI2eDqhep1e55HRUW
	6iQ7qRTnEOz6lJ2VbmnRGbcMUZX6xPQjDOSMRmQyHF8laEGfLvnpGzQS9A76pbj6
	6le5krawuLkh3PBkYOHoPfsoWf+31NeBWySk1GVs2iEePJf06qHOsnoyLhsLtoHO
	Zvwax2DHC1Wh9LnDu/GnewAq6cN9fRhgnkNpHjooi4PKrPfJ5zznu1Uxwn80fDRa
	WEaO7hyW8UfhdeqUqnIGRs38xTVhJN5pKx/AYBGT0MgxwGGgEbSje3rH3YJuDtW0
	IAjJqQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4029kwn8dc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 08:50:08 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 0BED140046;
	Mon,  1 Jul 2024 08:50:01 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AF9B0214D0C;
	Mon,  1 Jul 2024 08:48:48 +0200 (CEST)
Received: from localhost (10.48.86.164) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 1 Jul
 2024 08:48:45 +0200
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
Subject: [net-next,PATCH v2 1/2] net: stmmac: dwmac-stm32: Add test to verify if ETHCK is used before checking clk rate
Date: Mon, 1 Jul 2024 08:48:37 +0200
Message-ID: <20240701064838.425521-2-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240701064838.425521-1-christophe.roullier@foss.st.com>
References: <20240701064838.425521-1-christophe.roullier@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_05,2024-06-28_01,2024-05-17_01

When we want to use clock from RCC to clock Ethernet PHY (with ETHCK)
we need to check if value of clock rate is authorized.
If ETHCK is unused, the ETHCK frequency is 0Hz and validation fails.
It makes no sense to validate unused ETHCK, so skip the validation.

Fixes: 582ac134963e ("net: stmmac: dwmac-stm32: Separate out external clock rate validation")

Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
Reviewed-by: Marek Vasut <marex@denx.de>
Tested-by: Mark Brown <broonie@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
index 23cf0a5b047f..d6a268237ca1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
@@ -206,6 +206,9 @@ static int stm32mp1_validate_ethck_rate(struct plat_stmmacenet_data *plat_dat)
 	struct stm32_dwmac *dwmac = plat_dat->bsp_priv;
 	const u32 clk_rate = clk_get_rate(dwmac->clk_eth_ck);
 
+	if (!dwmac->enable_eth_ck)
+		return 0;
+
 	switch (plat_dat->mac_interface) {
 	case PHY_INTERFACE_MODE_MII:
 	case PHY_INTERFACE_MODE_GMII:
-- 
2.25.1


