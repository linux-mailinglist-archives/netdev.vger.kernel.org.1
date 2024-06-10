Return-Path: <netdev+bounces-102263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0D09021F3
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 14:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24F3C1C20E17
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 12:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF7780C07;
	Mon, 10 Jun 2024 12:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="T19j8tbm"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C98D80637;
	Mon, 10 Jun 2024 12:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718023774; cv=none; b=Wk4d+IAdHVGfayroWieQjvrVLkiRF4SUJ3uRKg+KpGFbTQk9T6DPpyU6mzgFTYloZCtnErqTuE8jSpVisJ1iR4p06+sWoLICuVQgjMhaA+xW7ukE3g6Nxbko9sGYeWngogB6+EpW55Zw4ugqHzhRxRwPTxCFrHqyoS3YuZ1o+O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718023774; c=relaxed/simple;
	bh=5gClVd7Hxm0FgBkjvQhHCXMpiq9XWfBlxTHw2Fl17mA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PF1ibXnzvyNZ34BgPDfI/DsEnkfhaHHclAjwyhNhmeViLdcwa73HKK0ksVWFgNJgCPSNsF27MHAPIXaSS0WAU+vm/ldNGPwjBNIbVAV4mvoLDOkyDsSELcsXoqIuqfias9oJzIp9AcqM7Q1KgObkEPksEdJD0fv5KL+8GtjjDCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=T19j8tbm; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ACUjv2011463;
	Mon, 10 Jun 2024 14:49:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	DlvjTDhAewRmsQzkTjZ5kyD/9jV9SyUh5OV0cymIvvM=; b=T19j8tbmVLhAfEEL
	LtDZjXBORaDCTSc8L8BKpVn8kvicYFTsql8dTHE0wnCOAkKpKOo+vYFqxkpeZXSU
	iqR1lBF9/Q5mS4lqDN7LffB7KBfxRlyQ8bZ8Bo8lSumCPBlpY4ePny05h5k19Jjs
	+A1iUBeE5U5Qgf14sc4dkA2/ZErzOidxl1KtOtp2BoIFxENRfISU3MVEhT6LMkIr
	nY5FhDQDy6OI/kBOHxCbLD1l3b1jBsiqyCCaYNP2hv4NumZ3nk1FNFblSWVMfA00
	SdqOgElYVE6Nujzkg6YAnyDXnfaz9nn6GVgzBj1lXzozApI9gHuDuyQys4xk8kLD
	tKNagA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yme6d6vm3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 14:49:01 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 32E954004D;
	Mon, 10 Jun 2024 14:48:54 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0C63D217B83;
	Mon, 10 Jun 2024 14:47:52 +0200 (CEST)
Received: from [10.48.86.79] (10.48.86.79) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 10 Jun
 2024 14:47:51 +0200
Message-ID: <be1e4321-2aa1-455b-a373-8c9e1f69b33f@foss.st.com>
Date: Mon, 10 Jun 2024 14:47:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/12] ARM: dts: stm32: add ethernet1 and ethernet2
 support on stm32mp13
To: Marek Vasut <marex@denx.de>,
        Christophe Roullier
	<christophe.roullier@foss.st.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Richard
 Cochran <richardcochran@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240607095754.265105-1-christophe.roullier@foss.st.com>
 <20240607095754.265105-10-christophe.roullier@foss.st.com>
 <6d60bbc6-5ed3-4bb1-ad72-18a2be140b81@denx.de>
 <036c9f0d-681d-461d-b839-f781fa220e94@foss.st.com>
 <c5cb092d-dccd-48a4-b1da-4f057581618e@denx.de>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <c5cb092d-dccd-48a4-b1da-4f057581618e@denx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_02,2024-06-10_01,2024-05-17_01



On 6/10/24 12:37, Marek Vasut wrote:
> On 6/10/24 10:06 AM, Alexandre TORGUE wrote:
>> Hi Marek
> 
> Hi,
> 
>> On 6/7/24 14:48, Marek Vasut wrote:
>>> On 6/7/24 11:57 AM, Christophe Roullier wrote:
>>>
>>> [...]
>>>
>>>> @@ -1505,6 +1511,38 @@ sdmmc2: mmc@58007000 {
>>>>                   status = "disabled";
>>>>               };
>> no space here ?
>>>> +            ethernet1: ethernet@5800a000 {
>>>> +                compatible = "st,stm32mp13-dwmac", "snps,dwmac-4.20a";
>>>> +                reg = <0x5800a000 0x2000>;
>>>> +                reg-names = "stmmaceth";
>>>> +                interrupts-extended = <&intc GIC_SPI 62 
>>>> IRQ_TYPE_LEVEL_HIGH>,
>>>> +                              <&exti 68 1>;
>>>> +                interrupt-names = "macirq", "eth_wake_irq";
>>>> +                clock-names = "stmmaceth",
>>>> +                          "mac-clk-tx",
>>>> +                          "mac-clk-rx",
>>>> +                          "ethstp",
>>>> +                          "eth-ck";
>>>> +                clocks = <&rcc ETH1MAC>,
>>>> +                     <&rcc ETH1TX>,
>>>> +                     <&rcc ETH1RX>,
>>>> +                     <&rcc ETH1STP>,
>>>> +                     <&rcc ETH1CK_K>;
>>>> +                st,syscon = <&syscfg 0x4 0xff0000>;
>>>> +                snps,mixed-burst;
>>>> +                snps,pbl = <2>;
>>>> +                snps,axi-config = <&stmmac_axi_config_1>;
>>>> +                snps,tso;
>>>> +                access-controllers = <&etzpc 48>;
>>>
>>> Keep the list sorted.
>>
>> The list is currently not sorted. I agree that it is better to have a 
>> common rule to easy the read but it should be applied to all the nodes 
>> for the whole STM32 family. Maybe to address by another series. For 
>> the time being we can keep it as it is.
> 
> Why is the st,... and snps,... swapped anyway ? That can be fixed right 
> here.

I agree.

> 
> Why is the access-controllers at the end ? That can be fixed in separate 
> series, since that seems to have proliferated considerably.

Yes for all other nodes using this bus firewall binding  but in a 
separate series





