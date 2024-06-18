Return-Path: <netdev+bounces-104431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AEB90C7B3
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 12:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FF8D284D90
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 10:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7520F155CAE;
	Tue, 18 Jun 2024 09:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="G9NxefmJ"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647AE155385;
	Tue, 18 Jun 2024 09:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718701905; cv=none; b=bIbZKUo9oc6NKZPwywGYiZwznG7CGK1+axYVVpCF6KwwA7xVnGtlSTnBN9aZIflPWV7WdH5lKBw+X6lBB1pWzj0nAECTUodUbo8XR0axoRVdSRlQciHErx4h9LRkRO8QJ67mjlWsnQARTA9JuY5sfQr+BpuXJcLokEKf2gblbQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718701905; c=relaxed/simple;
	bh=aTKh7qoNC6ncYKFdcn3vrsfsJi4IWy5Xroe9fbCuJ70=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Z4QHCIxWoDZP7luXf4PwDKRlk6AGXsHVSIpnoYBrT6cD9vi11rcxtrwEoN8ziOMgGW8xCiQzCyIiwhHhkSJVvZXoeIK42U+/lYmBujOtac18fR+//Ka9Cj8KLOdI/cGNU3YmTYEE+T72NpmFY1I359mWQLCX9DuJbNPrenElxHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=G9NxefmJ; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45I6Z9Yu004223;
	Tue, 18 Jun 2024 11:10:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	mZ2gz1uO27QN7pXr1aHkYNUz1eKbUVDgHMdiHyPJKlI=; b=G9NxefmJuyB0GvV2
	KOENsiD6laEfu4yo/CqfY466TRBnafFJnl8yv6Ayhuq5CpMuYk8gzgb3LWd3VTRj
	/pYT7B20oQsadjXWZi3BFK/PYgi6oI4ZR0NUe6DvhJR96U3MtkKuphMM3xWBKSvs
	mLotnNBd/J5amNgQQ8BYkqgaVoZR5FewmNYgwcOy1JnvKJxcOB/nU5ZVowA7lEEp
	qRofcPWgCuG8JPw9NlvDdyiQcUBEhv5Tq7NJ9n2zI/wx3PC/A44s0O0BBZZ7I39r
	d17IWMBDBxSnT3nWbE1AZBny1FFqgActjbdpirhhLm6jsb+saN4ViiNF5BXz5255
	TQX9Gg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ys1uct15y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 11:10:52 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 2A8894002D;
	Tue, 18 Jun 2024 11:10:45 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 10A4D212FD7;
	Tue, 18 Jun 2024 11:09:38 +0200 (CEST)
Received: from [10.48.86.164] (10.48.86.164) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 18 Jun
 2024 11:09:37 +0200
Message-ID: <8c3f1696-d67c-4960-ad3a-90461c896aa5@foss.st.com>
Date: Tue, 18 Jun 2024 11:09:36 +0200
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
Content-Language: en-US
From: Christophe ROULLIER <christophe.roullier@foss.st.com>
In-Reply-To: <39d35f6d-4f82-43af-883b-a574b8a67a1a@denx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01

Hi Marek,

On 6/17/24 17:57, Marek Vasut wrote:
> On 6/17/24 1:23 PM, Christophe ROULLIER wrote:
>
> Hi,
>
>>>> +static int stm32mp2_configure_syscfg(struct plat_stmmacenet_data 
>>>> *plat_dat)
>>>> +{
>>>> +    struct stm32_dwmac *dwmac = plat_dat->bsp_priv;
>>>> +    u32 reg = dwmac->mode_reg;
>>>> +    int val = 0;
>>>> +
>>>> +    switch (plat_dat->mac_interface) {
>>>> +    case PHY_INTERFACE_MODE_MII:
>>>> +        break;
>>>
>>> dwmac->enable_eth_ck does not apply to MII mode ? Why ?
>>
>> It is like MP1 and MP13, nothing to set in syscfg register for case 
>> MII mode wo crystal.
>
> Have a look at STM32MP15xx RM0436 Figure 83. Peripheral clock 
> distribution for Ethernet.
>
> If RCC (top-left corner of the figure) generates 25 MHz MII clock 
> (yellow line) on eth_clk_fb (top-right corner), can I set 
> ETH_REF_CLK_SEL to position '1' and ETH_SEL[2] to '0' and feed ETH 
> (right side) clk_rx_i input with 25 MHz clock that way ?
>
> I seems like this should be possible, at least theoretically. Can you 
> check with the hardware/silicon people ?
No it is not possible (it will work if speed (and frequency) is fixed  
25Mhz=100Mbps, but for speed 10Mbps (2,5MHz) it will not work. (you can 
see than diviser are only for RMII mode)
>
> As a result, the MII/RMII mode would behave in a very similar way, and 
> so would GMII/RGMII mode behave in a very similar way. Effectively you 
> would end up with this (notice the fallthrough statements):
>
> +    case PHY_INTERFACE_MODE_RMII:
> +        val = SYSCFG_ETHCR_ETH_SEL_RMII;
> +        fallthrough;
> +    case PHY_INTERFACE_MODE_MII:
> +        if (dwmac->enable_eth_ck)
> +            val |= SYSCFG_ETHCR_ETH_REF_CLK_SEL;
> +        break;
> +
> +    case PHY_INTERFACE_MODE_RGMII:
> +    case PHY_INTERFACE_MODE_RGMII_ID:
> +    case PHY_INTERFACE_MODE_RGMII_RXID:
> +    case PHY_INTERFACE_MODE_RGMII_TXID:
> +        val = SYSCFG_ETHCR_ETH_SEL_RGMII;
> +        fallthrough;
> +    case PHY_INTERFACE_MODE_GMII:
> +        if (dwmac->enable_eth_ck)
> +            val |= SYSCFG_ETHCR_ETH_CLK_SEL;
> +        break;
>
> [...]

