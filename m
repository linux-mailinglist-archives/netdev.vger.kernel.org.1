Return-Path: <netdev+bounces-100621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1958FB5BF
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 16:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18D4A1F2182C
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 14:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C72146A6E;
	Tue,  4 Jun 2024 14:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="L8AK4ek+"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673A914658E;
	Tue,  4 Jun 2024 14:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717511910; cv=none; b=dgZV7acx5Lv/nRvOOdMCEWBYMnDHPTulhmCInRhZjmuQc6wN/BACaAE4wzl38i0izcuhbTB45Vpf2IOzMZXACffjUiJbPkK0I7x3N2L1PYfo7UEuJNhY3jKH9Fvrh7F7p06GgplZAfRLC/yEcS/mYZ8RuJtT+xGk3j+iXA0ZrEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717511910; c=relaxed/simple;
	bh=M+fVmHCFaPcyzs+u8Y7ZQVNcblX1uciwc4OMn2nzd0Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q7eBh/+y3XSP2xwxdKDAKllERBeoncK801EU58Ae16wpkklngmarq0y+OB4d68qm5/EYIsFLNI05JlE7ote4KOvNZq1/hJVfjIUyQYWXBN5WRI8v3PqUzxrZGJcJukZj0yQ8MRuDc0sKYqsCQ9aaiSnEBxL9f2mxAjAcL4hzI5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=L8AK4ek+; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 454Cbg8L017454;
	Tue, 4 Jun 2024 16:38:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	JuDY0iqj5TDTqcNiIz4Nr9QUlzV7muTWZdShmUmLed0=; b=L8AK4ek+8mwK/BjX
	EYzEf8BzZUBsVWubZDVy8U9YOay4EFJJNh5akkNuudi/1BAVrl+3sES4x3KgnVcQ
	IzivXbmlfX2Xr0Wvz7g5CH4z5B2IpSVZCzjw80MCLPIUhKmJgljRr+kYu8J55f+o
	PNJnkkoD6BAZjRD2kz8K3dyXfHs3VzxzyNvHHs1hAz13fd6RQwaH2JnFvKvg/zPH
	LmcIecF/KA2hG2XCCjAXHKIF1rk8U/chYA4s6QV+znbVHBuvsRB434AHLayh3fTa
	pOWnBJTmW8ciuEC4/ko+dvVqn7zsxSgqoaDvTwmI7NDFsFy1Oc3F+GKQlyHUgKQS
	eGQj7g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yfw91crq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 16:38:03 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 681AB40044;
	Tue,  4 Jun 2024 16:37:56 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A95FE2194C5;
	Tue,  4 Jun 2024 16:36:29 +0200 (CEST)
Received: from localhost (10.48.86.164) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 4 Jun
 2024 16:36:29 +0200
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
Subject: [PATCH v4 06/11] net: stmmac: dwmac-stm32: Fix Mhz to MHz
Date: Tue, 4 Jun 2024 16:34:57 +0200
Message-ID: <20240604143502.154463-7-christophe.roullier@foss.st.com>
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

Trivial, fix up the comments using 'Mhz' to 'MHz'.
No functional change.

Signed-off-by: Marek Vasut <marex@denx.de>
Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
index 75981ac2cbb56..bed2be129b2d2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
@@ -58,7 +58,7 @@
  * Below table summarizes the clock requirement and clock sources for
  * supported phy interface modes.
  * __________________________________________________________________________
- *|PHY_MODE | Normal | PHY wo crystal|   PHY wo crystal   |No 125Mhz from PHY|
+ *|PHY_MODE | Normal | PHY wo crystal|   PHY wo crystal   |No 125MHz from PHY|
  *|         |        |      25MHz    |        50MHz       |                  |
  * ---------------------------------------------------------------------------
  *|  MII    |	 -   |     eth-ck    |	      n/a	  |	  n/a        |
@@ -367,7 +367,7 @@ static int stm32mp1_parse_data(struct stm32_dwmac *dwmac,
 	/* Gigabit Ethernet 125MHz clock selection. */
 	dwmac->eth_clk_sel_reg = of_property_read_bool(np, "st,eth-clk-sel");
 
-	/* Ethernet 50Mhz RMII clock selection */
+	/* Ethernet 50MHz RMII clock selection */
 	dwmac->eth_ref_clk_sel_reg =
 		of_property_read_bool(np, "st,eth-ref-clk-sel");
 
-- 
2.25.1


