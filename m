Return-Path: <netdev+bounces-104773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0810990E4C6
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 09:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74B861F26527
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 07:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC089770F0;
	Wed, 19 Jun 2024 07:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="bQYIK2BV"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A536473514;
	Wed, 19 Jun 2024 07:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718783013; cv=none; b=Q8Yq0vrY1tb1FxNoyKwoLDu4bv07TPsiV4KcNR5FjG2dp2l9YSTmHMAufJ+K9XXCBQyakz22H5ikt7mHy2ZPy5+9xgtnmRd36WzFHObYpVasV/z/5xjatZB1UKcnqf6Uj4O4a+4n4J+bwrb2YxJsEx21xU35BsreHLiy7xjU2Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718783013; c=relaxed/simple;
	bh=Kk0tvkTiO2T3b876bdyv7dDPKT0iSXVPQDtbWjD4hA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UNlGJRx30w08sRVb/s4i15Vb7gmjmVDBO8k8cAE29UklDzEuohkUEsCuG1S0zRaawUTNIdj+m9pDNcYESlHSDM3O8RuEVVo58hdSr1y56FxyX8BjG1s+ly2njiK3oHx7ShlRVtC1BxVC6d/2Mbi/RUS3y5AUReW92G1AS3uarIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=bQYIK2BV; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45J7QKhf006854;
	Wed, 19 Jun 2024 09:43:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	di+SFQRmDgPvKMWT6Avy9+LOTjR2HwG3kwmIyd/HWss=; b=bQYIK2BVaJri3TYl
	Mx9sEnwEywh9t7P2P9uEBpVr9z0M2NJ8+BqVkU4DX3Yd0O4nuuiuiN/gbbsujcmz
	PFJMEPSU1RyqjHdHjVrOQl6Wi/nwyh6rpyhcZ1+ojawgwQ2NSXo+9LoumV7TaG+n
	kPuvrorX22uMVDsct3j7jaW9F+qOeCdYWylExJKWRhE4vJs/K3lv4aqWVUkbG0yI
	CSL1HfPRS9vRRPN5CJIwwiO/m6g45zD8TQ2qHY9O9hOEBHIwhQcTwdBHqWtYLYH5
	DpIjOLBgrNUc1P0abkwJ53f7R1W9NL4JGDbt0yfTxlKjeqjKx3onsE/EWHlABaz3
	4crI/Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yuj9t1u0k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 09:43:00 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9017D40048;
	Wed, 19 Jun 2024 09:42:54 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C3253210F6D;
	Wed, 19 Jun 2024 09:41:42 +0200 (CEST)
Received: from [10.48.86.164] (10.48.86.164) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 19 Jun
 2024 09:41:39 +0200
Message-ID: <aee3f6d2-6a44-4de6-9348-f83c4107188f@foss.st.com>
Date: Wed, 19 Jun 2024 09:41:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,PATCH 2/2] net: stmmac: dwmac-stm32: stm32: add
 management of stm32mp25 for stm32
To: Marek Vasut <marex@denx.de>, "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre
 Torgue <alexandre.torgue@foss.st.com>,
        Richard Cochran
	<richardcochran@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240614130812.72425-1-christophe.roullier@foss.st.com>
 <20240614130812.72425-3-christophe.roullier@foss.st.com>
 <4c2f1bac-4957-4814-bf62-816340bd9ff6@denx.de>
 <09010b02-fb55-4c4b-9d0c-36bd0b370dc8@foss.st.com>
 <39d35f6d-4f82-43af-883b-a574b8a67a1a@denx.de>
 <8c3f1696-d67c-4960-ad3a-90461c896aa5@foss.st.com>
 <3dee3c8a-12f0-42bd-acdf-8008da795467@denx.de>
Content-Language: en-US
From: Christophe ROULLIER <christophe.roullier@foss.st.com>
In-Reply-To: <3dee3c8a-12f0-42bd-acdf-8008da795467@denx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-17_01,2024-05-17_01

Hi Marek,

On 6/18/24 17:00, Marek Vasut wrote:
> On 6/18/24 11:09 AM, Christophe ROULLIER wrote:
>
> Hi,
>
>>>>>> +static int stm32mp2_configure_syscfg(struct plat_stmmacenet_data 
>>>>>> *plat_dat)
>>>>>> +{
>>>>>> +    struct stm32_dwmac *dwmac = plat_dat->bsp_priv;
>>>>>> +    u32 reg = dwmac->mode_reg;
>>>>>> +    int val = 0;
>>>>>> +
>>>>>> +    switch (plat_dat->mac_interface) {
>>>>>> +    case PHY_INTERFACE_MODE_MII:
>>>>>> +        break;
>>>>>
>>>>> dwmac->enable_eth_ck does not apply to MII mode ? Why ?
>>>>
>>>> It is like MP1 and MP13, nothing to set in syscfg register for case 
>>>> MII mode wo crystal.
>>>
>>> Have a look at STM32MP15xx RM0436 Figure 83. Peripheral clock 
>>> distribution for Ethernet.
>>>
>>> If RCC (top-left corner of the figure) generates 25 MHz MII clock 
>>> (yellow line) on eth_clk_fb (top-right corner), can I set 
>>> ETH_REF_CLK_SEL to position '1' and ETH_SEL[2] to '0' and feed ETH 
>>> (right side) clk_rx_i input with 25 MHz clock that way ?
>>>
>>> I seems like this should be possible, at least theoretically. Can 
>>> you check with the hardware/silicon people ?
>> No it is not possible (it will work if speed (and frequency) is fixed 
>> 25Mhz=100Mbps, but for speed 10Mbps (2,5MHz) it will not work.
>
> Could the pll4_p_ck or pll3_q_ck generate either 25 MHz or 2.5 MHz as 
> needed in that case ? Then it would work, right ?

Yes you can set frequency you want for pll4 or pll3, if you set 25MHz 
and auto-negotiation of speed is 100Mbps it should work (pad ETH_CK of 
25MHz clock the PHY and eth_clk_fb set to 25MHz for clk_RX)

but if autoneg of speed is 10Mbps, then 2.5MHz is needed for clk_RX (you 
will provide 25Mhz). For RMII case, frequency from pll (eth_clk_fb) is 
automatically adjust in function of speed value, thanks to diviser /2, 
/20 with mac_speed_o.

>
>> (you can see than diviser are only for RMII mode)
>
> Do you refer to /2 and /20 dividers to the left of mac_speed_o[0] ?

