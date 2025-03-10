Return-Path: <netdev+bounces-173553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0613A59711
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 15:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F03E5164D97
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 14:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3109822A4C3;
	Mon, 10 Mar 2025 14:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="jY6+5yJF"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D04E11CBA;
	Mon, 10 Mar 2025 14:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741615695; cv=none; b=UoFeTQMUC9Jo3ma8XCFriQMmFR1VPbwgSNoILTyMs3sjRwxIv80Uvw8GDoZ2pIJObi3jMWp3lqiRddcxdlwv3HQCEf8SrmqgNiBrXPYybwkMXic250cMsRpNer4PXUpSlCw35QkkJQ2Bp5iqyLRky1Uq7wWhTyPYxNimuBNMP98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741615695; c=relaxed/simple;
	bh=wVQ0GrsA9V/xwQXnJN2Tvuh/J/kguCpINvjpvEksh7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gCzNjqSXpitwtZyG2VUEHk9UUUZlVIPd8QTknElZiUeeZyMuHx3IcYlQAF1J1tq2seNuh1J2k9D1hCjhrl0qSgNKWg1yV/AzBB7BlBJQNMquhZ1zIYKPeOgbUp+2Z/xc04WZCwlC1YDveC+a14JoVO4HjQNLDxRd3BLg8Bu6giE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=jY6+5yJF; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52ABsrVw030002;
	Mon, 10 Mar 2025 15:07:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	wHZLk8GMBYcp21rNrCan1n6xZhSfhobwhRSqB5Pb/MY=; b=jY6+5yJFskM7sedP
	xRJKKRvkjPeLpa/SWUjtjEHRHLKj/BIy1KhqyC1v9NxVheYl8L06KRzUeNRBaKlc
	PStW2gqgICRmIYHskEvQKFU4H780H2DIfO8kkRL6dP2IQAzV325OyOewUUgAI6hX
	8spLWZxJCAgTmfJL5cc/S0Qo7Zh2Ncxmc88cz1wfFdst/zMYVIcXWLV8M28rbSca
	x21yuHrHOtiYRvP8fZycl+pDzdcEIOdqJYR7sQ0/fL8S8imyR7TFo8iiSgYuut90
	o5Fk7twnByLML0apClcnGdkinnqUGGSILZxO40jNhMmuXAu6eWMGtpU7P+QzsGl/
	JN80ug==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 458ev648m8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 15:07:51 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 2E5BE4004B;
	Mon, 10 Mar 2025 15:06:37 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8419D4F631D;
	Mon, 10 Mar 2025 15:05:20 +0100 (CET)
Received: from [10.48.87.120] (10.48.87.120) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 15:05:19 +0100
Message-ID: <6f776853-65e9-4574-85c2-c2a0446addfe@foss.st.com>
Date: Mon, 10 Mar 2025 15:05:19 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/10] Expand STM32MP2 family with new SoC and boards
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
        <netdev@vger.kernel.org>, Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250225-b4-stm32mp2_new_dts-v2-0-1a628c1580c7@foss.st.com>
Content-Language: en-US
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
In-Reply-To: <20250225-b4-stm32mp2_new_dts-v2-0-1a628c1580c7@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_05,2025-03-07_03,2024-11-22_01

On 2/25/25 09:54, Amelie Delaunay wrote:
> Add STM32MP25 Discovery Kit board [1] STM32MP257F-DK. It is based on a
> different package of STM32MP257 SoC than STM32MP257F-EV1, and has 4GB of
> LPDDR4 instead of DDR4.
> Introduce two new SoC families [2] with Arm Cortex-A35 and Cortex-M33,
> in development:
> - STM32MP23x SoCs family, with STM32MP231 (single Arm Cortex-A35),
> STM32MP233 and STM32MP235 (dual Arm Cortex-A35) [3]. Add STM32MP235F-DK
> board to demonstrate the differences with STM32MP257F-DK board;
> - STM32MP21x SoCs family, based on Cortex-A35 single-core, with
> STM32MP211, STM32MP213 and STM32MP215. Add STM32MP215F-DK board based on
> STM32MP215 SoC, with 2GB of LPDDR4.
> 
> [1] https://www.st.com/en/evaluation-tools/stm32mp257f-dk.html
> [2] https://www.st.com/en/microcontrollers-microprocessors/stm32-arm-cortex-mpus.html
> [3] https://www.st.com/en/microcontrollers-microprocessors/stm32mp235.html
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
> ---
> Changes in v2:
> - Address Krzysztof's comments:
>    - squash arm64 Kconfig updates for STM32MP21 and STM32MP23
>    - add new compatibles st,stm32mp21-syscfg and st,stm32mp23-syscfg
>    - comply with DTS coding style
>    - move interrupt controller node under soc
>    - remove status property from button nodes
> - Link to v1: https://lore.kernel.org/r/20250210-b4-stm32mp2_new_dts-v1-0-e8ef1e666c5e@foss.st.com

Hi,

Gentle ping, are there any additional comments on this series?

Regards,
Amelie

> 
> ---
> Alexandre Torgue (3):
>        arm64: dts: st: add stm32mp257f-dk board support
>        arm64: dts: st: introduce stm32mp23 SoCs family
>        arm64: dts: st: introduce stm32mp21 SoCs family
> 
> Amelie Delaunay (7):
>        dt-bindings: stm32: document stm32mp257f-dk board
>        arm64: Kconfig: expand STM32 Armv8 SoC with STM32MP21/STM32MP23 SoCs family
>        dt-bindings: stm32: add STM32MP21 and STM32MP23 compatibles for syscon
>        dt-bindings: stm32: document stm32mp235f-dk board
>        arm64: dts: st: add stm32mp235f-dk board support
>        dt-bindings: stm32: document stm32mp215f-dk board
>        arm64: dts: st: add stm32mp215f-dk board support
> 
>   .../bindings/arm/stm32/st,stm32-syscon.yaml        |    2 +
>   .../devicetree/bindings/arm/stm32/stm32.yaml       |   13 +
>   arch/arm64/Kconfig.platforms                       |    4 +
>   arch/arm64/boot/dts/st/Makefile                    |    6 +-
>   arch/arm64/boot/dts/st/stm32mp211.dtsi             |  128 +++
>   arch/arm64/boot/dts/st/stm32mp213.dtsi             |    9 +
>   arch/arm64/boot/dts/st/stm32mp215.dtsi             |    9 +
>   arch/arm64/boot/dts/st/stm32mp215f-dk.dts          |   49 +
>   arch/arm64/boot/dts/st/stm32mp21xc.dtsi            |    8 +
>   arch/arm64/boot/dts/st/stm32mp21xf.dtsi            |    8 +
>   arch/arm64/boot/dts/st/stm32mp231.dtsi             | 1214 ++++++++++++++++++++
>   arch/arm64/boot/dts/st/stm32mp233.dtsi             |   94 ++
>   arch/arm64/boot/dts/st/stm32mp235.dtsi             |   16 +
>   arch/arm64/boot/dts/st/stm32mp235f-dk.dts          |  113 ++
>   arch/arm64/boot/dts/st/stm32mp23xc.dtsi            |    8 +
>   arch/arm64/boot/dts/st/stm32mp23xf.dtsi            |    8 +
>   arch/arm64/boot/dts/st/stm32mp257f-dk.dts          |  113 ++
>   17 files changed, 1801 insertions(+), 1 deletion(-)
> ---
> base-commit: 8c6d469f524960a0f97ec74f1d9ac737a39c3f1e
> change-id: 20250210-b4-stm32mp2_new_dts-8fddd389850a
> 
> Best regards,

