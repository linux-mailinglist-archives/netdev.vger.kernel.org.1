Return-Path: <netdev+bounces-101759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D1B8FFFFC
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 11:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14F1C1F223EA
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 09:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B427515821E;
	Fri,  7 Jun 2024 09:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="fKCa+4Ss"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48EF157A63;
	Fri,  7 Jun 2024 09:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717754382; cv=none; b=ET3txcsA2av2T+mjU9NqQWrHFpGzQD1UDMJ0fFiGMfSGJDFt2QtGX1Vz1wLZtjXJMmjKDe2lFUi5ADuHgfgKXrUFpAsrgt28xtL+8LYTdj0emUBifmvIdGFMsQJlYt1AHoYtvNBqF/5qyV3Ug6PEgbVFOYauPff0mI3vAdrKq28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717754382; c=relaxed/simple;
	bh=NfENobSjjZu/edxc9pZ/OAha+c7uFyxOO8G6yUJuRpw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CVAnyLYdsJKSWV9xrWdXskEeLigK5yYi+9MxHA5dKsIuSz3oo+TwYxacO+J3VooUvahAZ7+3Q/n857Y0mB2hnJ3lv5G7RtJ6pxEpbYY4Dlkvfie+dK3LkDxuOboQZVweglPoI4DAQQp5NITWjmuRJytcMDWJB18AXMk7QvAXyGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=fKCa+4Ss; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45791o5I009563;
	Fri, 7 Jun 2024 11:59:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=JAo9VhVljDqD3AnfEaNOLd
	mWR82295ASpyQvM0nMAJI=; b=fKCa+4Ss6Y9hTE222KnxQ/+v4gVnTsygVVO55Q
	dzOu7o9FdFuVBurQraBiG4P+TXmeOvHz/3L+RV0iccp+sbxw0LtmzTCb4+DKJEZO
	G3mMO5pfj110OgDxl+gSbwKZdwUnxPIUMuSiqsbxZoaRSl2j9P5h82udnpGjaFDS
	gRr4XnM+jboXrr45lhUcy0K/00JrlFYWhMmQ2Kt0642LoKRvLJZPCYfSp67xW4RY
	0+tJDhlqdegNXT7H1z3JD4X3IST8qMyj087ZrLVmErzLwUR+x1JXGHn9cQTa3Idt
	07eGQRtO/TzR9BKA3TkytQOqZaa6suUci38RM9kuQRdTRFww==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yfw91swd0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 11:59:18 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 384E840044;
	Fri,  7 Jun 2024 11:59:14 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 60247214D04;
	Fri,  7 Jun 2024 11:58:00 +0200 (CEST)
Received: from localhost (10.252.19.205) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 7 Jun
 2024 11:57:59 +0200
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
Subject: [PATCH v5 00/12] Series to deliver Ethernet for STM32MP13
Date: Fri, 7 Jun 2024 11:57:42 +0200
Message-ID: <20240607095754.265105-1-christophe.roullier@foss.st.com>
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
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_04,2024-06-06_02,2024-05-17_01

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
V4: - Remark from Marek (remove max-speed, extra space in DT, update commit msg)
    - Remark from Rasmus (add sign-off, add base-commit)
    - Remark from Sai Krishna Gajula
V5: - Fix warning during build CHECK_DTBS
    - Remark from Marek (glue + DT update)
    - Remark from Krzysztof about YAML (Make it symmetric)

Christophe Roullier (7):
  dt-bindings: net: add STM32MP13 compatible in documentation for stm32
  net: stmmac: dwmac-stm32: Mask support for PMCR configuration
  net: stmmac: dwmac-stm32: add management of stm32mp13 for stm32
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

 .../devicetree/bindings/net/stm32-dwmac.yaml  |  43 ++++-
 arch/arm/boot/dts/st/stm32mp13-pinctrl.dtsi   |  71 +++++++
 arch/arm/boot/dts/st/stm32mp131.dtsi          |  38 ++++
 arch/arm/boot/dts/st/stm32mp133.dtsi          |  31 ++++
 arch/arm/boot/dts/st/stm32mp135f-dk.dts       |  23 +++
 arch/arm/configs/multi_v7_defconfig           |   1 +
 .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 174 +++++++++++++-----
 7 files changed, 333 insertions(+), 48 deletions(-)


base-commit: cb6cf0820f22ca36dc8f95cf1bd196e5ec24e69d
-- 
2.25.1


