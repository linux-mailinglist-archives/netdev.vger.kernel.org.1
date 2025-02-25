Return-Path: <netdev+bounces-169335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5D9A43886
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 10:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11B41188FFC2
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 08:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB79262D33;
	Tue, 25 Feb 2025 08:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="zYOca+G5"
X-Original-To: netdev@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC978260A29;
	Tue, 25 Feb 2025 08:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740473846; cv=none; b=eClgSGEoRal9djfdnHJa9IYriSCWWSDnhlp9rQHw7umSKl+16att/c8gULQ05tA2tVqxWs7mPGnUsvHIod6jXxKECvrKcs6QnWZBVo2t0nYVFJGmAS1HQ3MLxu6e8bIhts7SO7IekQ9T8LtJQHvApmpFJw4vNXg1Q3+lMPVL5FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740473846; c=relaxed/simple;
	bh=e79GzWqryzQGwMXGQ8SKbWih4WKwvVqjud8BwZt3p2c=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=ebVC9jvlxJawlsDiWuSthWae4ZaoPCSBj3sBk6wHtWJwWCb8xJ+meSR/YK6TACp+7EmESoXw2T/ALFHU0j8wf93OiggSsw3esQEl/xbqzud9f5HHmKtihqi1pPg5VaEtaqJpr8y3GwiqeNEv5IK7iits9rH1KYt94T0VOZ/U8Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=zYOca+G5; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P7jke2002965;
	Tue, 25 Feb 2025 09:57:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=oofpzS28s5ufquqWyj4LID
	DS9CpvobWf/hARVzzFx0s=; b=zYOca+G592xWg2ybO3oaJi/GuYWP/st7ZyNGEc
	HlRwYPhS51hKzgVjYFUDPEachDYjuX6AecHig0IYyYgjjvHaF/Bt8jraPyWP+i8+
	HhZlsYw9yQzPBNNaij42iE0xdwvg2AjvvMI4Ke9+l33dOrlIf3ntn3m6ERWMmKp3
	ewzAXLZhIBahLW51tw9l+pUynHe1dB7Ap3YuT2U0DeahN2WeHgsqsbxJfaQT85Ta
	duaaY+mh91xx+9asgbFHhcf+jE8CGSW5nPmPXxDv8PO1TlkVQY4dwzawtBuxERjh
	qvCdP+eyyVRrM1sei7lmKMUVTu3JRpnkVBSUAM6z8ijQ/EIQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4512sp9shj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 09:57:07 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id B0BE44006C;
	Tue, 25 Feb 2025 09:55:48 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 99069425496;
	Tue, 25 Feb 2025 09:54:29 +0100 (CET)
Received: from localhost (10.48.87.120) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 09:54:29 +0100
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: [PATCH v2 00/10] Expand STM32MP2 family with new SoC and boards
Date: Tue, 25 Feb 2025 09:54:03 +0100
Message-ID: <20250225-b4-stm32mp2_new_dts-v2-0-1a628c1580c7@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACuFvWcC/32NQQ6CMBBFr0JmbUk7CKmuvIchBOlUuoCSTlM1p
 He3cgCX7yX//R2YgiOGa7VDoOTY+bUAniqY5nF9knCmMKDEVqKS4nEWHJcGlw2HlV6DiSy0NcY
 0+qJbOUJZboGsex/Ve194dhx9+BwnSf3s/15SQgrSZBV1XTe1dLOeueZYT36BPuf8BU5J5Gu4A
 AAA
X-Change-ID: 20250210-b4-stm32mp2_new_dts-8fddd389850a
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Christophe Roullier
	<christophe.roullier@foss.st.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_03,2025-02-24_02,2024-11-22_01

Add STM32MP25 Discovery Kit board [1] STM32MP257F-DK. It is based on a
different package of STM32MP257 SoC than STM32MP257F-EV1, and has 4GB of
LPDDR4 instead of DDR4.
Introduce two new SoC families [2] with Arm Cortex-A35 and Cortex-M33,
in development:
- STM32MP23x SoCs family, with STM32MP231 (single Arm Cortex-A35),
STM32MP233 and STM32MP235 (dual Arm Cortex-A35) [3]. Add STM32MP235F-DK
board to demonstrate the differences with STM32MP257F-DK board;
- STM32MP21x SoCs family, based on Cortex-A35 single-core, with
STM32MP211, STM32MP213 and STM32MP215. Add STM32MP215F-DK board based on
STM32MP215 SoC, with 2GB of LPDDR4.

[1] https://www.st.com/en/evaluation-tools/stm32mp257f-dk.html
[2] https://www.st.com/en/microcontrollers-microprocessors/stm32-arm-cortex-mpus.html
[3] https://www.st.com/en/microcontrollers-microprocessors/stm32mp235.html

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
Changes in v2:
- Address Krzysztof's comments:
  - squash arm64 Kconfig updates for STM32MP21 and STM32MP23
  - add new compatibles st,stm32mp21-syscfg and st,stm32mp23-syscfg
  - comply with DTS coding style
  - move interrupt controller node under soc
  - remove status property from button nodes
- Link to v1: https://lore.kernel.org/r/20250210-b4-stm32mp2_new_dts-v1-0-e8ef1e666c5e@foss.st.com

---
Alexandre Torgue (3):
      arm64: dts: st: add stm32mp257f-dk board support
      arm64: dts: st: introduce stm32mp23 SoCs family
      arm64: dts: st: introduce stm32mp21 SoCs family

Amelie Delaunay (7):
      dt-bindings: stm32: document stm32mp257f-dk board
      arm64: Kconfig: expand STM32 Armv8 SoC with STM32MP21/STM32MP23 SoCs family
      dt-bindings: stm32: add STM32MP21 and STM32MP23 compatibles for syscon
      dt-bindings: stm32: document stm32mp235f-dk board
      arm64: dts: st: add stm32mp235f-dk board support
      dt-bindings: stm32: document stm32mp215f-dk board
      arm64: dts: st: add stm32mp215f-dk board support

 .../bindings/arm/stm32/st,stm32-syscon.yaml        |    2 +
 .../devicetree/bindings/arm/stm32/stm32.yaml       |   13 +
 arch/arm64/Kconfig.platforms                       |    4 +
 arch/arm64/boot/dts/st/Makefile                    |    6 +-
 arch/arm64/boot/dts/st/stm32mp211.dtsi             |  128 +++
 arch/arm64/boot/dts/st/stm32mp213.dtsi             |    9 +
 arch/arm64/boot/dts/st/stm32mp215.dtsi             |    9 +
 arch/arm64/boot/dts/st/stm32mp215f-dk.dts          |   49 +
 arch/arm64/boot/dts/st/stm32mp21xc.dtsi            |    8 +
 arch/arm64/boot/dts/st/stm32mp21xf.dtsi            |    8 +
 arch/arm64/boot/dts/st/stm32mp231.dtsi             | 1214 ++++++++++++++++++++
 arch/arm64/boot/dts/st/stm32mp233.dtsi             |   94 ++
 arch/arm64/boot/dts/st/stm32mp235.dtsi             |   16 +
 arch/arm64/boot/dts/st/stm32mp235f-dk.dts          |  113 ++
 arch/arm64/boot/dts/st/stm32mp23xc.dtsi            |    8 +
 arch/arm64/boot/dts/st/stm32mp23xf.dtsi            |    8 +
 arch/arm64/boot/dts/st/stm32mp257f-dk.dts          |  113 ++
 17 files changed, 1801 insertions(+), 1 deletion(-)
---
base-commit: 8c6d469f524960a0f97ec74f1d9ac737a39c3f1e
change-id: 20250210-b4-stm32mp2_new_dts-8fddd389850a

Best regards,
-- 
Amelie Delaunay <amelie.delaunay@foss.st.com>


