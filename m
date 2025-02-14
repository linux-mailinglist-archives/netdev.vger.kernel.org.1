Return-Path: <netdev+bounces-166442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7F9A36011
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 15:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE15816D6E5
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 14:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DAA264FB9;
	Fri, 14 Feb 2025 14:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="mDeX57ug"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F9024166E;
	Fri, 14 Feb 2025 14:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739542589; cv=none; b=lRrm3T+q8rEpw+6CI9ouJWZhUl1eTR12ozcw7FSQx6P3daWXOfrGrYiXiiR7bKtcK+vF03Ax8UbWC6L6LuEh976mOyDiSv4IQKMTMoOwnn4XWRB9JtFiUbY2XETtszFYeeYlFSL2Y7OhEL1VYYjBF5wiyA6mAGkIxrGzKgZO9c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739542589; c=relaxed/simple;
	bh=QIMA8HSuryzyn1y+ASb9er9Vg5M2gtiAh7i6VC48zzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MtX+Wg8unGrOKNemqSQu03YNT6K06k1witrBdTO2HhOgdlClVrF11cGrn63kCQQXKEW69QBU6Fn0D4AQYkMc4rVFZJ/19tJyUIXnVM7SM0ITU2p83SHpGZL8wCuiCjATIZpUpqnRd54yq2oTwUZurhTHFBbPz+VxXNIFO/ELqGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=mDeX57ug; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ECk2If002159;
	Fri, 14 Feb 2025 15:15:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	wwHVwCdc4/Na+JqMuJs/rM97AN1e37TSauY+tsEiMZg=; b=mDeX57ugP7b3YAfT
	oj7mOSZi/VqovNPGLChvfywQBemHEZ6ypH3glLTI6nkIraIIsWq/uFV7/7LJuUgu
	EVsNUaC4hepUTX/Qbu6vSkG0jyRHq0Ul50PNWwY0mfYVWi+9gJeZsa/Zt3TovvMl
	zPKAc953mE9PMnJ0DsUnyd5s2HpOa0mi7zC/NP3EZ4ui1NxvchupqLHLC/xEgQUu
	GLZ5T2yTLUEhJZ5c5dRrGIuOdB6DmPBMkzFivir5NE0wX8Ca6nG+TIk9/xvMZzNU
	pjSoPabQI/YjtEFNvna3fKMutO8Vazcr8z43C5SwLxoCxojzt50cL3BTckybHA5e
	Yv0W5A==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44p0q0bgt7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 15:15:54 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1E12740048;
	Fri, 14 Feb 2025 15:14:58 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 956D02CF588;
	Fri, 14 Feb 2025 15:13:58 +0100 (CET)
Received: from [10.48.87.120] (10.48.87.120) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Feb
 2025 15:13:57 +0100
Message-ID: <e3d320a4-9e8e-438f-b85f-47cfa1219684@foss.st.com>
Date: Fri, 14 Feb 2025 15:13:57 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] arm64: dts: st: add stm32mp235f-dk board support
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
 <20250210-b4-stm32mp2_new_dts-v1-6-e8ef1e666c5e@foss.st.com>
 <20250213-truthful-accurate-gaur-bd118f@krzk-bin>
Content-Language: en-US
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
In-Reply-To: <20250213-truthful-accurate-gaur-bd118f@krzk-bin>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_06,2025-02-13_01,2024-11-22_01

On 2/13/25 10:03, Krzysztof Kozlowski wrote:
> On Mon, Feb 10, 2025 at 04:21:00PM +0100, Amelie Delaunay wrote:
>> Add STM32MP235F Discovery Kit board support. It embeds a STM32MP235FAK
>> SoC, with 4GB of LPDDR4, 2*USB typeA, 1*USB3 typeC, 1*ETH, wifi/BT
>> combo, DSI HDMI, LVDS connector ...
>>
>> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
>> ---
>>   arch/arm64/boot/dts/st/Makefile           |   1 +
>>   arch/arm64/boot/dts/st/stm32mp235f-dk.dts | 115 ++++++++++++++++++++++++++++++
>>   2 files changed, 116 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/st/Makefile b/arch/arm64/boot/dts/st/Makefile
>> index 0cc12f2b1dfeea6510793ea26f599f767df77749..06364152206997863d0991c25589de73c63494fb 100644
>> --- a/arch/arm64/boot/dts/st/Makefile
>> +++ b/arch/arm64/boot/dts/st/Makefile
>> @@ -1,4 +1,5 @@
>>   # SPDX-License-Identifier: GPL-2.0-only
>>   dtb-$(CONFIG_ARCH_STM32) += \
>> +	stm32mp235f-dk.dtb \
>>   	stm32mp257f-dk.dtb \
>>   	stm32mp257f-ev1.dtb
>> diff --git a/arch/arm64/boot/dts/st/stm32mp235f-dk.dts b/arch/arm64/boot/dts/st/stm32mp235f-dk.dts
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..08e330d310749506c5b0e7a1fb2f80dfa134400a
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/st/stm32mp235f-dk.dts
>> @@ -0,0 +1,115 @@
>> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
>> +/*
>> + * Copyright (C) STMicroelectronics 2025 - All Rights Reserved
>> + * Author: Amelie Delaunay <amelie.delaunay@foss.st.com> for STMicroelectronics.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/input/input.h>
>> +#include <dt-bindings/leds/common.h>
>> +#include "stm32mp235.dtsi"
>> +#include "stm32mp23xf.dtsi"
>> +#include "stm32mp25-pinctrl.dtsi"
>> +#include "stm32mp25xxak-pinctrl.dtsi"
>> +
>> +/ {
>> +	model = "STMicroelectronics STM32MP235F-DK Discovery Board";
>> +	compatible = "st,stm32mp235f-dk", "st,stm32mp235";
>> +
>> +	aliases {
>> +		serial0 = &usart2;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = "serial0:115200n8";
>> +	};
>> +
>> +	gpio-keys {
>> +		compatible = "gpio-keys";
>> +
>> +		button-user-1 {
>> +			label = "User-1";
>> +			linux,code = <BTN_1>;
>> +			gpios = <&gpioc 5 GPIO_ACTIVE_HIGH>;
>> +			status = "okay";
> 
> Where is it disabled?
> 
>> +		};
>> +
>> +		button-user-2 {
>> +			label = "User-2";
>> +			linux,code = <BTN_2>;
>> +			gpios = <&gpioc 11 GPIO_ACTIVE_HIGH>;
>> +			status = "okay";
> 
> Same question
> 
>> +		};
>> +	};
> 
> Best regards,
> Krzysztof
> 

Will drop status property.

Regards,
Amelie

