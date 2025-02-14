Return-Path: <netdev+bounces-166465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAC9A360FC
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 16:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47CBB3AA833
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 15:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3476266579;
	Fri, 14 Feb 2025 15:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="GzC2Xguz"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F5D263F5F;
	Fri, 14 Feb 2025 15:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739545730; cv=none; b=mKbd4agPGElijUnbAcMSDyAtO7zlOvMeMlUwetSrov61+BLobX12V5rRnQaE4dy/jYNM9vKJ3VdWPSfe++oaSPLhAH3eGfUWoLlM6DAau9gqOzbxppwflVH9oBZCx8m0TVQQhiLY6iaq33cXOE7OMWF9z+7A8c/KOxAfZgLRutA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739545730; c=relaxed/simple;
	bh=LKmJYpF6Ms1YYPsbwTNlYp8uGcun5qCX0fO2WBelQFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ydile4X9n7Euhp07OMnIC4gFF8IqO51cRsbp74+zb0FXBH5YCPswoocOe8MfG8yHQKZo9N/z7PB1Ee6AHUsk1qZyLGqmEN7tBzyeFRTsvBloHwnihJDOo528fFjiIUVRIffWIO2+ihoPekE9TLV6u7Phci7p3GijN3gX1UB7Vd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=GzC2Xguz; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ECjotE010500;
	Fri, 14 Feb 2025 16:08:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	YXS1HGsTHr9/1Ngx2AF+DGBdFhZg7bub1m4HSTPuIuc=; b=GzC2Xguz8yBpUIFF
	RI+aUtN4T9Bu5IcWJFA7srIVliH9g502kTSXOpj5TcB1vaVujiMXGWT1U1Udz6TL
	kF0YOJVywNexGSdQ4wOypyYaSiXoTXXXd9+OgkGfD5L6qWjNXTXKdiigY256aWgI
	KmdUlXRh3dlXsKs8Bf1hNHSq0IEyKpADMBVSY2ijAd9YAAkkB+MSNjvbM2fLtq6Z
	5jRfdYkTttU+MRuwACRlGwyOFV9p5nFkZ29vT8YtVfVgTfuqEB1LrDhMpOLPzP/i
	LC4Y6qkrwwqd6/blvFlPjuGbINnAsuXkER1ht2L1mjbOBbdK7ux0k7skdjbXq+gG
	bxYN4A==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44rrh3uwgf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 16:08:19 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 775EC4002D;
	Fri, 14 Feb 2025 16:07:10 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AAADE2DB172;
	Fri, 14 Feb 2025 16:06:16 +0100 (CET)
Received: from [10.48.87.120] (10.48.87.120) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Feb
 2025 16:06:15 +0100
Message-ID: <450d2efa-f38b-4f3a-b308-f2fb01fdb8f7@foss.st.com>
Date: Fri, 14 Feb 2025 16:06:15 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] arm64: Kconfig: expand STM32 Armv8 SoC with
 STM32MP21 SoCs family
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
 <20250210-b4-stm32mp2_new_dts-v1-7-e8ef1e666c5e@foss.st.com>
 <20250213-polite-spiked-dingo-ce0f3a@krzk-bin>
Content-Language: en-US
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
In-Reply-To: <20250213-polite-spiked-dingo-ce0f3a@krzk-bin>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_06,2025-02-13_01,2024-11-22_01

On 2/13/25 10:02, Krzysztof Kozlowski wrote:
> On Mon, Feb 10, 2025 at 04:21:01PM +0100, Amelie Delaunay wrote:
>> Expand config ARCH_STM32 with the new STM32MP21 SoCs family which is
>> composed of STM32MP211, STM32MP213 and STM32MP215 SoCs.
>>
>> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
>> ---
>>   arch/arm64/Kconfig.platforms | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
>> index 844a39620cfea8bfc031a545d85e33894ef20994..f788dbc09c9eb6f5801758ccf6b0ffe50a96090e 100644
>> --- a/arch/arm64/Kconfig.platforms
>> +++ b/arch/arm64/Kconfig.platforms
>> @@ -325,6 +325,8 @@ config ARCH_STM32
>>   			- STM32MP251, STM32MP253, STM32MP255 and STM32MP257.
>>   		- STM32MP23:
>>   			- STM32MP231, STM32MP233, STM32MP235.
>> +		- STM32MP21:
> 
> Squash it with previous patch and keep some sort of order.
>

Ok for squashing with patch 3.
Do you mean to keep the current chronological order used here or to 
change the order because "chronological" is not an appropriate order? In 
this case, would the alphanumeric order be fine?

>> +			- STM32MP211, STM32MP213, STM32MP215.
>>   
>>   config ARCH_SYNQUACER
>>   	bool "Socionext SynQuacer SoC Family"
>>
>> -- 
>> 2.25.1
>>

Regards,
Amelie

