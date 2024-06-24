Return-Path: <netdev+bounces-106009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F80914340
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 09:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBB221C208DE
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 07:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0482D3B1A2;
	Mon, 24 Jun 2024 07:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="h39OGsl4"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F28138DD2;
	Mon, 24 Jun 2024 07:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719213172; cv=none; b=n3vWR8xmerycrUvfIvH4nEDkLaDsw8XlKXVCnnj5YXINArO7iJnyGpzUIqlFP8WbqTJEtDEciV049QmH8JdHI0RWKMQ5yRCLwAanDntWH2dlBTlDNQC8tB4ODFghLfPqzGxSM4c/QvZGF5yiw8g96Y5ok9xWNxGCucgKZeRZPOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719213172; c=relaxed/simple;
	bh=ysVdGXVwbK9d1RqZ8ZWbatKUBCtCvMEjP5Yl/BW6GV8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ApUJ4hR/LrekfAd6hRS/umngB5CCFfSgauMM0USkbbRnPeLFm2S2nv/AI2CzrUNQ27viyjM4KS3A8OcluXatagm8LurEMNjkfulF4I0/p+UYCN+IJW4/k881QCglNWXQk4iYqOZ/gTenlzSmlW1Cmg3NQLRJBgIPMffxICGpC+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=h39OGsl4; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45O2RW8G023858;
	Mon, 24 Jun 2024 09:12:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=nNIGmtMgBT00YHa1Om7OpG
	1INSl2T8JgnFkXIhnek2A=; b=h39OGsl4m/IoA3gjlVA/C+U6j4z/kDGzW/wzVg
	grIGSGO7cdcL5Rwp5cgOFLG/AMtEDjIb6/zwNta0BDX+I+PZDZdnLP5SosybIKcz
	uaiatV5T8Ac5LfYp4O6PIHiDm/Ha1Dzmf2co7JjldDkY4pgqsETb4cntILlEdozU
	ju0MiiRTl1KyMRmTfPg1ns9es5+Nmm/NVdlCNWe2RzkhFRu2AmCEleGDcLjVZyi4
	/gRsZJTGvrxhe5k9LYA101wZog7SLSV40KM7SL+MSLFJWOoSR/W93DBNeP+Y8b8u
	Vkl7C0FuSDJ5q7rhBCA7BueJ+6OcuCtAC3iygLgLHPyNec7A==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ywm1g5vrs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 09:12:22 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 4658640045;
	Mon, 24 Jun 2024 09:12:16 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 893D62115EF;
	Mon, 24 Jun 2024 09:11:02 +0200 (CEST)
Received: from localhost (10.48.86.164) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 24 Jun
 2024 09:11:02 +0200
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
Subject: [net-next,PATCH v3 0/2] Series to deliver Ethernet for STM32MP25
Date: Mon, 24 Jun 2024 09:10:50 +0200
Message-ID: <20240624071052.118042-1-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.25.1
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
 definitions=2024-06-24_06,2024-06-21_01,2024-05-17_01

STM32MP25 is STM32 SOC with 2 GMACs instances.
    GMAC IP version is SNPS 5.3x.
    GMAC IP configure with 2 RX and 4 TX queue.
    DMA HW capability register supported
    RX Checksum Offload Engine supported
    TX Checksum insertion supported
    Wake-Up On Lan supported
    TSO supported

V2: - Remark from Marek (sort compatible in YAML, change in glue to simplify)
V3: - Update from Simon Horman (replace "return err" with "return 0")
    - Update/remark from Marek (simplify and add comment in glue to be clearer)

Christophe Roullier (2):
  dt-bindings: net: add STM32MP25 compatible in documentation for stm32
  net: stmmac: dwmac-stm32: stm32: add management of stm32mp25 for stm32

 .../devicetree/bindings/net/stm32-dwmac.yaml  |  8 +-
 .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 80 ++++++++++++++++++-
 2 files changed, 84 insertions(+), 4 deletions(-)


base-commit: 84562f9953ec5f91a4922baa2bd4f2d4f64fac31
-- 
2.25.1


