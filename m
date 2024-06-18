Return-Path: <netdev+bounces-104437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C89D90C829
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 13:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A456B23DA8
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 11:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA8D20011A;
	Tue, 18 Jun 2024 09:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="l9wP0ruu"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C4B1581EE;
	Tue, 18 Jun 2024 09:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718703535; cv=none; b=RZ3q7MUsqX0SIL2Rd/AqqGXIgsfQUUaopFMJjo2BsUf+19Xuvp3y0x0ezIYwhghpgV7BjsGi0edWb/Zh74c+6TWtRH/eXLK4AT7UAYHKkzdNBqmTMuR3F8AfPylETzLGV+YvgdZilu64tWzSYV9FhA5io+TPXtxTN2IWSQlUwdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718703535; c=relaxed/simple;
	bh=nhjVr4cevvuOqH8B6Da8Fdh5LOC0w2bNsEcw/InfHUw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jzRNOxd+sddzGNumbV0Aw8QMXKFvP6o9mK2vZHhW74nG/o9YOkDlyMmvfnhAB3aUWAPmeJApf7XkEtL6EHXrh6X+eWmsHNeE27Ddz40NM2TCPPNrq2Wp8Kru+9qutHNSDBfE/Y930rPRG2AJuJAzq+owZXp4bjNamAQqpBQ/8zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=l9wP0ruu; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45I6WpPp014186;
	Tue, 18 Jun 2024 11:38:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=ly0QQHKw/UbAz9gVk1FA6b
	NuTihqIRCOIk67BFECjqI=; b=l9wP0ruuSKDP00BNR9W2kx7dFPXfZpnjZtZ5BO
	CmsFoK4ZdXeKi2eMguq6n6FUDXxeYkY6nBsDNw/3JvyNg9n09vqw8NgKZT7WQMpy
	4qJFxWUICcddvNenjDz2+mpO4+T41WX2eAP38oPhsQqyJwmj20jZ4triPRi68UMg
	lC810NVCnNoLhYsPg3a/Rib69Ps9MnKUGXqQiLMUK6syjK5VsGSQVp3iM7P7Wnxd
	CiXZM3ryVf5Jlu6WtYgaYGmISdRqmYXh5ZtsfpTkefnUvcoHm24BDY0GhWJpP5sN
	+3evXgCVs9h2HV5a27TBLIQeAYpzKDv1/2FCuhvLisqPFIEw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ys035jee4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 11:38:18 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C149E40045;
	Tue, 18 Jun 2024 11:36:52 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2E1AC2138DC;
	Tue, 18 Jun 2024 11:35:38 +0200 (CEST)
Received: from localhost (10.48.86.164) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 18 Jun
 2024 11:35:35 +0200
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
Subject: [PATCH 0/3] Series DTs to deliver Ethernet for STM32MP25
Date: Tue, 18 Jun 2024 11:35:24 +0200
Message-ID: <20240618093527.318239-1-christophe.roullier@foss.st.com>
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
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01

STM32MP25 is STM32 SOC with 2 GMACs instances.
    GMAC IP version is SNPS 5.3x.
    GMAC IP configure with 2 RX and 4 TX queue.
    DMA HW capability register supported
    RX Checksum Offload Engine supported
    TX Checksum insertion supported
    Wake-Up On Lan supported
    TSO supported

Delivered Ethernet2 instance for board EV1 which is connected 
to Realtek PHY in RGMII mode.
Ethernet1 instance will be delivered in next step.

Christophe Roullier (3):
  arm64: dts: st: add ethernet1 and ethernet2 support on stm32mp25
  arm64: dts: st: add eth2 pinctrl entries in stm32mp25-pinctrl.dtsi
  arm64: dts: st: enable Ethernet2 on stm32mp257f-ev1 board

 arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi | 59 +++++++++++++++++++
 arch/arm64/boot/dts/st/stm32mp251.dtsi        | 49 +++++++++++++++
 arch/arm64/boot/dts/st/stm32mp253.dtsi        | 51 ++++++++++++++++
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts    | 24 ++++++++
 4 files changed, 183 insertions(+)


base-commit: efb459303dd5dd6e198a0d58322dc04c3356dc23
-- 
2.25.1


