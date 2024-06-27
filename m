Return-Path: <netdev+bounces-107151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6B291A1EE
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 10:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8B36283787
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 08:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6A812F59C;
	Thu, 27 Jun 2024 08:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="onYVcOHe"
X-Original-To: netdev@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D951BF3A;
	Thu, 27 Jun 2024 08:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719478368; cv=none; b=tEXpBcmfMZia0lrTB1JSbYOdF2XG494zVIFN8FrSiozcgmWmHEbtgXOlnw4zD9mIaRK8M1Z/M4k0FWr+va4xfHdI9eKtkp9pT6MZ0dThIHezGS4XUi9PEINfO1FUb53rx8aG91iMgk7Qg5jMOsZRMjx/EL20vPXqght/DJLWLgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719478368; c=relaxed/simple;
	bh=SsONSSD7pAnkGcOJLk3dkURzGX57lmCijAUlTKRAQFc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tr80HO1/nhxsn8+bP9BifrwF6ZaJexwTHuz93lzhQz0lMnFP1Z63+otqZXfs1uXErAviQ8mUqUkd7rpviKbTRB57UVUDd9flkPqtAp916qu0gKHPr8m1F4C/vdN7ibFDLp2faEtjZ5TGtQaXE542GtKUJ9OdYHvKW3INBdPTlYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=onYVcOHe; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45R7ohBg009985;
	Thu, 27 Jun 2024 10:50:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	kfYZ2gkK9VCqIVUh4OLEdbTiAXaU0YJT9q5BaZZNaJY=; b=onYVcOHekXslD15N
	+o4fkLSStepfc0dMbHrF5dgYaWpEN4nXMxRzBMrMK7Nbt8jkg5YffCbD0TzYuQk+
	Sl65HboCSrVL9BE9LrEDZ74Bfk3KYiZf8ZLUaAs9SNHAylLaBwNQGhJnLG0Fy1fA
	Z1OKmAI9ZxtECTT/2IDjH61q8NE5vlMKXi6gfgdMa5F2cmy9E8vSShLssd0e30sE
	RudZ9xnzxzPuT5U022sKuWGwk2OeH+Z/2B2ZuuSzH0SOpoKFNg5w22tc2eQEHKsT
	L/h3w82QzypTIJO97SqQ2w/1wpNk0cSxjbkmUN0yV+SxVjniLlwMItAh7G2vpikg
	LCUuFw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yx9jjhynh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 10:50:55 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 0FE9540055;
	Thu, 27 Jun 2024 10:50:41 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 30E022138EF;
	Thu, 27 Jun 2024 10:49:27 +0200 (CEST)
Received: from localhost (10.48.86.164) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 27 Jun
 2024 10:49:26 +0200
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
Subject: [net-next,PATCH 1/2] net: stmmac: dwmac-stm32: Add test to verify if ETHCK is used before checking clk rate
Date: Thu, 27 Jun 2024 10:49:16 +0200
Message-ID: <20240627084917.327592-2-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240627084917.327592-1-christophe.roullier@foss.st.com>
References: <20240627084917.327592-1-christophe.roullier@foss.st.com>
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
 definitions=2024-06-27_04,2024-06-25_01,2024-05-17_01

When we want to use clock from RCC to clock Ethernet PHY (with ETHCK)
we need to check if value of clock rate is authorized but we must add
test before to check if ETHCK is used.

Fixes: 582ac134963e ("net: stmmac: dwmac-stm32: Separate out external clock rate validation")

Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
index b2db0e26c4e4..8b85265ca6cf 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
@@ -195,6 +195,9 @@ static int stm32mp1_validate_ethck_rate(struct plat_stmmacenet_data *plat_dat)
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


