Return-Path: <netdev+bounces-100115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A75AE8D7EA9
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 11:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FE3EB21B7E
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 09:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5557EEE7;
	Mon,  3 Jun 2024 09:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="vzcIOIxy"
X-Original-To: netdev@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30223823AF;
	Mon,  3 Jun 2024 09:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717406979; cv=none; b=gD9y13xyYHYZ4pDw+U8Jq0y3vZNNhY2UHN9XZY22fMjNHfps/YMIGUc8oeg6jN6QRzFoiVR6ON3+NvANHbzvJT8fMFerHIgtgkCSACoz6Rc8WruIiPQLg6re6s7r1yOB8HXA+hW7/ojk49ODt7S8MqtBwklI1fF/HawCgtunh/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717406979; c=relaxed/simple;
	bh=/RwLt37mZinhQXbN/cqOQ0+EvPSbkY9p9MAGa8qCzqM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LtAqAREfQy4BrFttLCFVpF/LWt4Yx3Dsk20/NvU5g50qyDhXyffTTSML46EPok4UiVeXa2Sa2TrFZjUj/QFnwI83+tOkG6xEcJoR3ZOy8kaFbR65OMTkVgXaBlI3DVulxQ8LQ0ifoLbuX7VaOwg8dtoYuMZAx10YXFoN1v5iAsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=vzcIOIxy; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4537cWVc004745;
	Mon, 3 Jun 2024 11:28:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=W4T/YoU6NKIK7mMSN7BvQl
	A9NuSsgbgmhksWstWhGaA=; b=vzcIOIxyNo5aha17vMDuOfTuxg5AqMKs+ePYLr
	ez7TccT5jAlFE0GQnS9DSIxgdhPYPVFzsOXgwu1g2bLS7nxSK9EEHvCm99HSbhQ3
	L5TmntEfcF9UhPXrDcnTYiDNGPavJ0mNzeaKLfWjI9FnvZMo9pZWgIG66gNBIekw
	cw1Mp3TpdL9iX4+JHUQAzP8GndyTuJ6wuwht2Er+gPIvldqdR65xm23joKcpKWrE
	aaYPZY4V4ZIb6H0y6cCcpL+HZZsiecr4K7CUZOXLujdxpRaXEgGCY6SfH8KQk9b4
	aAtPBlNjkeAwx7IPsmuGYAI3xr9xgPGZiZ7m/6ETs9iGt/4w==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ygekhm92p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 11:28:42 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 14CCE4005D;
	Mon,  3 Jun 2024 11:28:15 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3EE222165E7;
	Mon,  3 Jun 2024 11:28:15 +0200 (CEST)
Received: from localhost (10.48.86.164) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 3 Jun
 2024 11:28:14 +0200
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
Subject: [PATCH v3 00/11] Series to deliver Ethernet for STM32MP13
Date: Mon, 3 Jun 2024 11:27:46 +0200
Message-ID: <20240603092757.71902-1-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.25.1
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

STM32MP13 is STM32 SOC with 2 GMACs instances
    GMAC IP version is SNPS 4.20.
    GMAC IP configure with 1 RX and 1 TX queue.
    DMA HW capability register supported
    RX Checksum Offload Engine supported
    TX Checksum insertion supported
    Wake-Up On Lan supported
    TSO supported
Rework dwmac glue to simplify management for next stm32 (integrate RFC from Marek)

V2: - Remark from Rob Herring (add Krzysztof's ack in patch 02/11, update in yaml)
      Remark from Serge Semin (upate commits msg)
V3: - Remove PHY regulator patch and Ethernet2 DT because need to clarify how to
      manage PHY regulator (in glue or PHY side)
    - Integrate RFC from Marek
    - Remark from Rob Herring in YAML documentation

Christophe Roullier (6):
  dt-bindings: net: add STM32MP13 compatible in documentation for stm32
  net: ethernet: stmmac: add management of stm32mp13 for stm32
  ARM: dts: stm32: add ethernet1 and ethernet2 support on stm32mp13
  ARM: dts: stm32: add ethernet1/2 RMII pins for STM32MP13F-DK board
  ARM: dts: stm32: add ethernet1 for STM32MP135F-DK board
  ARM: multi_v7_defconfig: Add MCP23S08 pinctrl support

Marek Vasut (5):
  net: stmmac: dwmac-stm32: Separate out external clock rate validation
  net: stmmac: dwmac-stm32: Separate out external clock selector
  net: stmmac: dwmac-stm32: Extract PMCR configuration
  net: stmmac: dwmac-stm32: Clean up the debug prints
  net: stmmac: dwmac-stm32: Fix Mhz to MHz

 .../devicetree/bindings/net/stm32-dwmac.yaml  |  41 +++-
 arch/arm/boot/dts/st/stm32mp13-pinctrl.dtsi   |  71 +++++++
 arch/arm/boot/dts/st/stm32mp131.dtsi          |  31 +++
 arch/arm/boot/dts/st/stm32mp133.dtsi          |  30 +++
 arch/arm/boot/dts/st/stm32mp135f-dk.dts       |  24 +++
 arch/arm/configs/multi_v7_defconfig           |   1 +
 .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 176 ++++++++++++++----
 7 files changed, 327 insertions(+), 47 deletions(-)

-- 
2.25.1


