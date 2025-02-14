Return-Path: <netdev+bounces-166467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD03A36180
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 16:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F292188DCCB
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 15:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B20B245B1B;
	Fri, 14 Feb 2025 15:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="wiDAEXVT"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B5C537FF;
	Fri, 14 Feb 2025 15:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739546460; cv=none; b=dZeha9xMMr+hCI7JYRPMCiLfYOfqy6t03W11AfSczgunx+sYLfmLHZjVOiIWYdABnNzXa8c2piENG+GlcafQl2Y4ZOXKuMNJo9Jy8vsg0VT4ytqyYtwJLXeynqbbd4BktJa8iqMlL0AwYvk+Wu7xd5gd04yD+jgfipnUbYae5j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739546460; c=relaxed/simple;
	bh=QB/zWRI4bEQVwfPTQoHn/BynRUEbzU2hRIo7s6wrREs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YJg1+nl4AvHQIIs/P5EIBOo9vH3RvN47cWBVo1TCix8Jtr7wh1XC+sdSSOOOGT1qd0gLqHO6QsKDdytkIzSOV9i2iwKMwTCGYQuvrq3mH0U6Tynj4v8Ir/TExzr0oojw0LJn/MUq83idlI40Tpk8YlpdQ0lSjL2UB4xTc0QAtI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=wiDAEXVT; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ECjkJC012402;
	Fri, 14 Feb 2025 16:20:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	XIGWT/hG4tpt7K0ywnil/ic7qyIjws86Nr7lEaaCFVs=; b=wiDAEXVTGHJtLkQr
	/TkMG3g8S+w7ayPRJsIpOHOijNJn8pAUEfAWlRbA4kvjev2Sn0QQ/UHbMTJ+fs0f
	VTAlenMa76krHFtcykdMbiFpKX/JPf9wxx4VZXsoy6kRXTXFjj599xsTYd0XWb02
	sLDjqZFkNE+weUcY8z5p71g8CGTD56ugaW/mF4DLCaeE6pH9+XRKs3ADj6V3lO/q
	1zfhNtcX6Bbcr++WJ4fcR2EAFtv1PtbXa5XKqA38+4KFtaMWTwxx6vJI+YaGMNp9
	x+B9zOy/c1nIRRP/c6G7qlbyt07yrWYJOpldbf5Js3zHvp92ZyI+YS6DUWh+RUZq
	PO/WxA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44rrfum80j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 16:20:39 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 03B9F40047;
	Fri, 14 Feb 2025 16:19:29 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 351DA2DC032;
	Fri, 14 Feb 2025 16:18:33 +0100 (CET)
Received: from [10.48.87.120] (10.48.87.120) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Feb
 2025 16:18:32 +0100
Message-ID: <e76829e9-26ee-44cc-8378-6e83f62eccd5@foss.st.com>
Date: Fri, 14 Feb 2025 16:18:31 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] arm64: dts: st: introduce stm32mp21 SoCs family
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>
References: <20250210-b4-stm32mp2_new_dts-v1-0-e8ef1e666c5e@foss.st.com>
 <20250210-b4-stm32mp2_new_dts-v1-8-e8ef1e666c5e@foss.st.com>
 <20250213-accurate-acoustic-mushroom-a0dfbd@krzk-bin>
Content-Language: en-US
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
In-Reply-To: <20250213-accurate-acoustic-mushroom-a0dfbd@krzk-bin>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_06,2025-02-13_01,2024-11-22_01

On 2/13/25 10:02, Krzysztof Kozlowski wrote:
> On Mon, Feb 10, 2025 at 04:21:02PM +0100, Amelie Delaunay wrote:
>> From: Alexandre Torgue <alexandre.torgue@foss.st.com>
>>
>> STM32MP21 family is composed of 3 SoCs defined as following:
>>
>> -STM32MP211: common part composed of 1*Cortex-A35, common peripherals
>> like SDMMC, UART, SPI, I2C, parallel display, 1*ETH ...
>>
>> -STM32MP213: STM32MP211 + a second ETH, CAN-FD.
>>
>> -STM32MP215: STM32MP213 + Display and CSI2.
>>
>> A second diversity layer exists for security features/ A35 frequency:
>> -STM32MP21xY, "Y" gives information:
>>   -Y = A means A35@1.2GHz + no cryp IP and no secure boot.
>>   -Y = C means A35@1.2GHz + cryp IP and secure boot.
>>   -Y = D means A35@1.5GHz + no cryp IP and no secure boot.
>>   -Y = F means A35@1.5GHz + cryp IP and secure boot.
>>
>> Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
>> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
>> ---
>>   arch/arm64/boot/dts/st/stm32mp211.dtsi  | 130 ++++++++++++++++++++++++++++++++
>>   arch/arm64/boot/dts/st/stm32mp213.dtsi  |   9 +++
>>   arch/arm64/boot/dts/st/stm32mp215.dtsi  |   9 +++
>>   arch/arm64/boot/dts/st/stm32mp21xc.dtsi |   8 ++
>>   arch/arm64/boot/dts/st/stm32mp21xf.dtsi |   8 ++
>>   5 files changed, 164 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/st/stm32mp211.dtsi b/arch/arm64/boot/dts/st/stm32mp211.dtsi
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..d384359e0ea16e2593795ff48d4a699324c8ca75
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/st/stm32mp211.dtsi
>> @@ -0,0 +1,130 @@
>> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
>> +/*
>> + * Copyright (C) STMicroelectronics 2025 - All Rights Reserved
>> + * Author: Alexandre Torgue <alexandre.torgue@foss.st.com> for STMicroelectronics.
>> + */
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +/ {
>> +	#address-cells = <2>;
>> +	#size-cells = <2>;
>> +
>> +	cpus {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		cpu0: cpu@0 {
>> +			compatible = "arm,cortex-a35";
>> +			device_type = "cpu";
>> +			reg = <0>;
>> +			enable-method = "psci";
>> +		};
>> +	};
>> +
>> +	arm-pmu {
>> +		compatible = "arm,cortex-a35-pmu";
>> +		interrupts = <GIC_SPI 368 IRQ_TYPE_LEVEL_HIGH>;
>> +		interrupt-affinity = <&cpu0>;
>> +		interrupt-parent = <&intc>;
>> +	};
>> +
>> +	arm_wdt: watchdog {
>> +		compatible = "arm,smc-wdt";
>> +		arm,smc-id = <0xbc000000>;
>> +		status = "disabled";
>> +	};
>> +
>> +	clocks {
>> +		ck_flexgen_08: ck-flexgen-08 {
>> +			#clock-cells = <0>;
>> +			compatible = "fixed-clock";
>> +			clock-frequency = <64000000>;
>> +		};
>> +
>> +		ck_flexgen_51: ck-flexgen-51 {
>> +			#clock-cells = <0>;
>> +			compatible = "fixed-clock";
>> +			clock-frequency = <200000000>;
>> +		};
>> +	};
>> +
>> +	firmware {
>> +		optee {
>> +			compatible = "linaro,optee-tz";
>> +			method = "smc";
>> +		};
>> +
>> +		scmi: scmi {
>> +			compatible = "linaro,scmi-optee";
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			linaro,optee-channel-id = <0>;
>> +
>> +			scmi_clk: protocol@14 {
>> +				reg = <0x14>;
>> +				#clock-cells = <1>;
>> +			};
>> +
>> +			scmi_reset: protocol@16 {
>> +				reg = <0x16>;
>> +				#reset-cells = <1>;
>> +			};
>> +		};
>> +	};
>> +
>> +	intc: interrupt-controller@4ac00000 {
> 
> MMIO nodes belong to the soc.
> 

Indeed.

>> +		compatible = "arm,cortex-a7-gic";
>> +		#interrupt-cells = <3>;
>> +		interrupt-controller;
>> +		reg = <0x0 0x4ac10000 0x0 0x1000>,
>> +		      <0x0 0x4ac20000 0x0 0x2000>,
>> +		      <0x0 0x4ac40000 0x0 0x2000>,
>> +		      <0x0 0x4ac60000 0x0 0x2000>;
>> +	};
>> +
>> +	psci {
>> +		compatible = "arm,psci-1.0";
>> +		method = "smc";
>> +	};
>> +
>> +	timer {
>> +		compatible = "arm,armv8-timer";
>> +		interrupt-parent = <&intc>;
>> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>;
>> +		arm,no-tick-in-suspend;
>> +	};
>> +
>> +	soc@0 {
>> +		compatible = "simple-bus";
>> +		#address-cells = <1>;
>> +		#size-cells = <2>;
>> +		interrupt-parent = <&intc>;
>> +		ranges = <0x0 0x0 0x0 0x0 0x80000000>;
> 
> ranges is the second property. See DTS coding style.
> 

Ok.

>> +		dma-ranges = <0x0 0x0 0x80000000 0x1 0x0>;
>> +
>> +		rifsc: bus@42080000 {
>> +			compatible = "simple-bus";
>> +			reg = <0x42080000 0x0 0x1000>;
>> +			#address-cells = <1>;
>> +			#size-cells = <2>;
>> +			ranges;
> 
> and here is third.
> 
>> +			dma-ranges;
>> +
>> +			usart2: serial@400e0000 {
> 
> Although addresses seem wrong. How bus could start at 0x4208 but device
> at 0x400e?
> 
>> +				compatible = "st,stm32h7-uart";
>> +				reg = <0x400e0000 0x0 0x400>;
>> +				interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
>> +				clocks = <&ck_flexgen_08>;
>> +				status = "disabled";
>> +			};
>> +		};
>> +
>> +		syscfg: syscon@44230000 {
>> +			compatible = "st,stm32mp25-syscfg", "syscon";
> 
> Which soc is this? DTSI says stm32mp211, commit STM32MP21, but
> compatible xxx25?
> 

Looks like a new compatible is needed, and I guess it is also true for 
stm32mp231.

>> +			reg = <0x44230000 0x0 0x10000>;
>> +		};
>> +	};
>> +};
>> diff --git a/arch/arm64/boot/dts/st/stm32mp213.dtsi b/arch/arm64/boot/dts/st/stm32mp213.dtsi
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..22cdedd9abbf4efac2334d497618daa6cc76727b
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/st/stm32mp213.dtsi
>> @@ -0,0 +1,9 @@
>> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
>> +/*
>> + * Copyright (C) STMicroelectronics 2024 - All Rights Reserved
>> + * Author: Alexandre Torgue <alexandre.torgue@foss.st.com> for STMicroelectronics.
>> + */
>> +#include "stm32mp211.dtsi"
>> +
>> +/ {
>> +};
>> diff --git a/arch/arm64/boot/dts/st/stm32mp215.dtsi b/arch/arm64/boot/dts/st/stm32mp215.dtsi
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..d2c63e92b3cc15ec64898374fd2e745a9c71eb6d
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/st/stm32mp215.dtsi
>> @@ -0,0 +1,9 @@
>> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
>> +/*
>> + * Copyright (C) STMicroelectronics 2024 - All Rights Reserved
>> + * Author: Alexandre Torgue <alexandre.torgue@foss.st.com> for STMicroelectronics.
>> + */
>> +#include "stm32mp213.dtsi"
>> +
>> +/ {
>> +};
> 
> What is the point of this file exactly?
> 

Skeleton file for upcoming second ethernet and can-fd peripherals, not 
available on stm32mp211.

>> diff --git a/arch/arm64/boot/dts/st/stm32mp21xc.dtsi b/arch/arm64/boot/dts/st/stm32mp21xc.dtsi
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..39507a7564c8488647a3276eb227eb5f446359e6
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/st/stm32mp21xc.dtsi
>> @@ -0,0 +1,8 @@
>> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
>> +/*
>> + * Copyright (C) STMicroelectronics 2024 - All Rights Reserved
>> + * Author: Alexandre Torgue <alexandre.torgue@foss.st.com> for STMicroelectronics.
>> + */
>> +
>> +/ {
>> +};
> 
> And this and others.
> 

Skeleton file for upcoming cryptographic support, not available on 
stm32mp21xa and stm32mp21xd.
As said previously, same split is used on other STM32 MPUs.

Regards,
Amelie

