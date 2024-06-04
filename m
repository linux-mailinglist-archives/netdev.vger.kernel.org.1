Return-Path: <netdev+bounces-100613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BEE8FB595
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 16:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B511628440A
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 14:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CD713CFA3;
	Tue,  4 Jun 2024 14:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="HkJWRbLp"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8486613C818;
	Tue,  4 Jun 2024 14:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717511833; cv=none; b=fNVgiyXmm+cJT16qU35S3fLrCFAsWLdRzDwrpAt1PdtxnCrf6M3aT4pcT6OT0VPEJooFy3CHyIVCSCxODL7LfU5g9QnJ2sHdVAvosNnxQ4v3kGPldQYDRO/jYjpwMfTtgiPiIyWQStQ2+bA5UebFamX5z/8gkxnIYXh1mWfVDDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717511833; c=relaxed/simple;
	bh=n99Ko5HaJO85F54ix4X1ovOI96Xl295WeZ0B5aVvtBk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rzaCDqcAYcJeudW0wQ45nbEDTev9cOEzjK6idh0hgI92kB50eniGxMC89MaBYIwRVVCiUe6rt+nB02O4Xtvc2BKw+qZRCSXW9p2xIczeBYr9QYISg2urjfvgBCw3erI/SqU5vvC8r+2hYIoFFZfdLdxPXp6HFieai2iHnR4mhyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=HkJWRbLp; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 454DOLvW012864;
	Tue, 4 Jun 2024 16:36:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=yc0Pxe2X2efIKfu9xwLwzE
	iOJ7Ub60FE7k6shR7hdK8=; b=HkJWRbLpSrB7odl14Y7bp7yJSnOKlN33STWeuG
	lJZPXdKc6VeCJ2FAfJFMvWMKpCkXnoRhqegpLYQgw0/BWuKWKg0KRRlRum8q3AW+
	TXqMW3BZ1AY6l6xH7WHfuBh0oRy8dVfXaHqiEl/eCRFUE6wzOmfiJe5AQ2CfwOeF
	rDE3vh0ngWbu7Dx1yBDtZXeRWehWDmzCTVG5pxXYZ9ABu+vjmuxl2PdPazNNandD
	saDo9OfBsJ40P9l5wWYQJWJ/EpTJA3gYI6YRqrqMIHL7hi3J43oRuxC5Y51DgjQt
	Ieohf9q8RY88WH8wYGen9SS8dwkVCN3lKS54jzmoANHB9VOQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yfw3wmp4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 16:36:37 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 90E9140045;
	Tue,  4 Jun 2024 16:36:30 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A9B1B221944;
	Tue,  4 Jun 2024 16:35:15 +0200 (CEST)
Received: from localhost (10.48.86.164) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 4 Jun
 2024 16:35:14 +0200
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
Subject: [PATCH v4 00/11] Series to deliver Ethernet for STM32MP13
Date: Tue, 4 Jun 2024 16:34:51 +0200
Message-ID: <20240604143502.154463-1-christophe.roullier@foss.st.com>
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
 definitions=2024-06-04_09,2024-06-04_01,2024-05-17_01

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

 .../devicetree/bindings/net/stm32-dwmac.yaml  |  41 ++++-
 arch/arm/boot/dts/st/stm32mp13-pinctrl.dtsi   |  71 ++++++++
 arch/arm/boot/dts/st/stm32mp131.dtsi          |  38 ++++
 arch/arm/boot/dts/st/stm32mp133.dtsi          |  31 ++++
 arch/arm/boot/dts/st/stm32mp135f-dk.dts       |  23 +++
 arch/arm/configs/multi_v7_defconfig           |   1 +
 .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 172 ++++++++++++++----
 7 files changed, 330 insertions(+), 47 deletions(-)


base-commit: cd0057ad75116bacf16fea82e48c1db642971136
-- 
2.25.1


