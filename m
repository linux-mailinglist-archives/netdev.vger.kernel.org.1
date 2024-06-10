Return-Path: <netdev+bounces-102173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6096901BBE
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 09:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE4DE1C2042A
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 07:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB2746BA0;
	Mon, 10 Jun 2024 07:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="VkwcAgse"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2964545022;
	Mon, 10 Jun 2024 07:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718003911; cv=none; b=oxQ5KjKkDIe4D3jxh/1dlbX1al1SnTzrFjgq3pM8G4Unqe9P3kGFsLOQXVEbTLI4/san8PfU+zRa28/010swDCg8qoC/5MgXpmRY1b8IXYQtQsHyA4MhqJ4bOFx9hBbvQCOxhAZ3FYAyaJqIZ0slFlX9/WudYHeRv9iNP6wiglY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718003911; c=relaxed/simple;
	bh=M+fVmHCFaPcyzs+u8Y7ZQVNcblX1uciwc4OMn2nzd0Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AseSvoFAPL9bbuHQo5LcmxfJQxQAZZKV/LmqbUY+7u+QCvYqV9hw6o+gw14ds92wp7INFRzEk1Pb0d7GALR0elAz1X43b/iVgW40gC59OdHm6C5vM8VDi/Z0CSN4t5cR/9HBk+HJBpVQDWRMbaX1rgeagAK6MZLxfldXLcqzaIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=VkwcAgse; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 459KxQV9013767;
	Mon, 10 Jun 2024 09:18:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	JuDY0iqj5TDTqcNiIz4Nr9QUlzV7muTWZdShmUmLed0=; b=VkwcAgseU7tSzI38
	Eb0UqxHRuNa5rqQ0q64ixRkPjw3Vd41U9pTJLlcq8dKigJcfcwWftQNdqdAgAVZ8
	nU8daKRATo+emuITJbr42Oxo9t6tTHkO9yAMuq/LMM0B1jz6+3Z9N+1NqxIgy6d4
	/FlVXQ7bRSuO11EUXojzEfjJJ//PNUz5kQCLs7Pk/gX0e0nzuittKJ//Sc3Eza8g
	bbgwgkmcXQtPnU4sbAnWh7J1iZA8iIJ8L87mmoGf7ovpdevl/S/IVU46Pfp/fiAy
	itXsEM9CjVkh0ouzuLjQBX7vfewfp2eUJDJ48NhyGGuVWCXjahZHoze3oboWEkHI
	1htjrQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ymemxnfdg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 09:18:01 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id E501A40047;
	Mon, 10 Jun 2024 09:17:45 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7736420E69F;
	Mon, 10 Jun 2024 09:16:32 +0200 (CEST)
Received: from localhost (10.48.86.164) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 10 Jun
 2024 09:16:32 +0200
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
Subject: [net-next,PATCH v6 6/8] net: stmmac: dwmac-stm32: Fix Mhz to MHz
Date: Mon, 10 Jun 2024 09:14:57 +0200
Message-ID: <20240610071459.287500-7-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240610071459.287500-1-christophe.roullier@foss.st.com>
References: <20240610071459.287500-1-christophe.roullier@foss.st.com>
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
 definitions=2024-06-10_02,2024-06-06_02,2024-05-17_01

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


