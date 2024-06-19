Return-Path: <netdev+bounces-104930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A25D90F2C5
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 17:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDDE21F27022
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 15:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02523154444;
	Wed, 19 Jun 2024 15:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="eXGjNNvc"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B887A1514EF;
	Wed, 19 Jun 2024 15:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718811738; cv=none; b=kFIXMsQJ+8Cp6TUWjXUIbs2VtWvWyng06yfnYpBTIoeQgUkf/5Dg9TsXuOGBnJQiYYow1gPKxs8GuNnQrHh+3w1TRK08F6WY6g6C9UUfUhj34ZZResDv0YTAEE0TToIxUlIxU/gTcjGXN7OpoV2lv1e2gRrUiNP0jBYaXQSTnNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718811738; c=relaxed/simple;
	bh=O9SvN5PDSrTOrdmyamPUNMeLQQeJVEqLKZx0ag1sbZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=G+sZwhIcF7cSVhkLMTc95PGdX/uBxuP11I1Zotm9UkMqdq4XaBHv6aVPVN0lHLg7V6t9bqW44ZpowqILz+qxvlvAETN0lZsG9utpj3RVEaa+OarsJpdC1DN8edbYWM11/rgVzOZ2UyeMSopK0w83nUn6YPdrJkiGQMQ4ZMAkUqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=eXGjNNvc; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45JClcrJ002573;
	Wed, 19 Jun 2024 17:41:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	67yqfpKh56AKrK0vIV+pIDS3OpXEowZR1XSlRO6rTac=; b=eXGjNNvcd2mXSjDp
	UWD9btAjEvQpIl3yBRvUBR8hSvsWtCfce/5+b6ro9bOFl5YMg4SHSly61PaMmlRJ
	odXbdM38FA9MQnHx/UanvJClFwxiKQX47XY00k3/x7CKZkzpOBmIcO40SyUZbVUS
	/ky3ZwZux2w1aIex5ruBccs8nGwxx3GdDsHSuD4ONWtugWdwqbLiQRsLa0w1JTi5
	Tsm80xBb93M5ZBA09XFjUv8RKa0Au8oHvjighR0Oj/jy1TpRwmyf/BmRFI/WnC/0
	DNWoSnGRrO9H7Oqgv/zN0/UT0ND0IB2rUUhH6hoCKqFWilOP/j2xD2mFqpI712c3
	qBPreg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yuj9n4av8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 17:41:49 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 74ADE4004B;
	Wed, 19 Jun 2024 17:41:43 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8A446221EB2;
	Wed, 19 Jun 2024 17:40:22 +0200 (CEST)
Received: from [10.48.86.164] (10.48.86.164) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 19 Jun
 2024 17:40:21 +0200
Message-ID: <01e435a5-3a69-49a5-9d5e-ab9af0a2af7b@foss.st.com>
Date: Wed, 19 Jun 2024 17:40:21 +0200
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
 <aee3f6d2-6a44-4de6-9348-f83c4107188f@foss.st.com>
 <c74f393d-7d0a-4a34-8e72-553ccf273a41@denx.de>
Content-Language: en-US
From: Christophe ROULLIER <christophe.roullier@foss.st.com>
In-Reply-To: <c74f393d-7d0a-4a34-8e72-553ccf273a41@denx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01


On 6/19/24 15:14, Marek Vasut wrote:
> On 6/19/24 9:41 AM, Christophe ROULLIER wrote:
>
> Hi,
>
>>>>>>>> +static int stm32mp2_configure_syscfg(struct 
>>>>>>>> plat_stmmacenet_data *plat_dat)
>>>>>>>> +{
>>>>>>>> +    struct stm32_dwmac *dwmac = plat_dat->bsp_priv;
>>>>>>>> +    u32 reg = dwmac->mode_reg;
>>>>>>>> +    int val = 0;
>>>>>>>> +
>>>>>>>> +    switch (plat_dat->mac_interface) {
>>>>>>>> +    case PHY_INTERFACE_MODE_MII:
>>>>>>>> +        break;
>>>>>>>
>>>>>>> dwmac->enable_eth_ck does not apply to MII mode ? Why ?
>>>>>>
>>>>>> It is like MP1 and MP13, nothing to set in syscfg register for 
>>>>>> case MII mode wo crystal.
>>>>>
>>>>> Have a look at STM32MP15xx RM0436 Figure 83. Peripheral clock 
>>>>> distribution for Ethernet.
>>>>>
>>>>> If RCC (top-left corner of the figure) generates 25 MHz MII clock 
>>>>> (yellow line) on eth_clk_fb (top-right corner), can I set 
>>>>> ETH_REF_CLK_SEL to position '1' and ETH_SEL[2] to '0' and feed ETH 
>>>>> (right side) clk_rx_i input with 25 MHz clock that way ?
>>>>>
>>>>> I seems like this should be possible, at least theoretically. Can 
>>>>> you check with the hardware/silicon people ?
>>>> No it is not possible (it will work if speed (and frequency) is 
>>>> fixed 25Mhz=100Mbps, but for speed 10Mbps (2,5MHz) it will not work.
>>>
>>> Could the pll4_p_ck or pll3_q_ck generate either 25 MHz or 2.5 MHz 
>>> as needed in that case ? Then it would work, right ?
>>
>> Yes you can set frequency you want for pll4 or pll3, if you set 25MHz 
>> and auto-negotiation of speed is 100Mbps it should work (pad ETH_CK 
>> of 25MHz clock the PHY and eth_clk_fb set to 25MHz for clk_RX)
>>
>> but if autoneg of speed is 10Mbps, then 2.5MHz is needed for clk_RX 
>> (you will provide 25Mhz)
>
> What if:
>
> - Aneg is 10 Mbps
> - PLL4_P_CK/PLL3_Q_CK = 2.5 MHz
> - ETH_REF_CLK_SEL = 1
> - ETH_SEL[2] = 0
>
> ?
>
> Then, clk_rx_i is 2.5 MHz, right ?
Yes that right
>
> Does this configuration work ?
For me no, because PHY Ethernet Oscillator/cristal need in PAD 25Mhz or 
50Mhz, I think it is does not work if oscillator frequency provided is 
2.5MHz (To my knowledge there is no Ethernet PHY which have oscillator 
working to 2.5MHz)
>
>> . For RMII case, frequency from pll (eth_clk_fb) is automatically 
>> adjust in function of speed value, thanks to diviser /2, /20 with 
>> mac_speed_o.

