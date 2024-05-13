Return-Path: <netdev+bounces-96033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9808C4105
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 14:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0873F287A66
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 12:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4833B1509B1;
	Mon, 13 May 2024 12:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="6EM+wPBH"
X-Original-To: netdev@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362A115099B;
	Mon, 13 May 2024 12:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715604635; cv=none; b=r8I6KMQJP15bax+M7VfTaTm62JGFrWaphpvwoH9pNEMRiLd8+J0tPzHY62i6HjIGZIRjPA2lFZkBnRb2dr1nwLE2T3c1IAjiBIPUBJ9/s7ZtD0fUL9gcBmpH1q+xRJACRFs4VzVAYrvGeN6GFZVQH39oOtZiucwvyH26FyPSWBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715604635; c=relaxed/simple;
	bh=FRB14+0j2v798cn6A5NFCMGFCYVwy17/xyTF2pSNCgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RJRX1dQ11389uFqWg0Q2Eo6KRMCaGJQiwvwqq43dR7FKuFpQHpwChNjy1mRHGx1chthkdqRCkoO2FgfpJy7JtVuX9N071Abpp0ZFJ3tNE2AtQJyLLGKaMc+1dueEJ0EWQ2aWMNGECJZ2DE+muDvMO9KvKHRak7ZFvyukvIgRzqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=6EM+wPBH; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44DBQd8F009156;
	Mon, 13 May 2024 14:49:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=jULG4BPSUFaHm0SKRBaAKf82JzLF2ZXIL0z6ooA0hNg=; b=6E
	M+wPBHTG9ST0T5Fws2x7VuO9e7bNBevGyZ2rVYrEKqwujVz2wJ+GaMRrP8wqj6Gx
	VEIORBcsNTRAFY7Vul4OQCvrCNiNyFQLeuclTaloTVn+HZjfa3nP9j408Sy6eCff
	Nza937rWANALuLSC/ii7BLd+uh1jgX5BM27P+iRckhH6wNU2kbQwRGrpbKBsQSoV
	8XA/x63SrdOTBjQIdui63HSWvAibBwxIoBi3T11R1SMo5157fqR0Ms+q7K8cnoPv
	AyqzxHAe9FVJpyPn0K70sXDWMXvkQ6nqQ9GQhY62qT7qJzhPuf7vnvVFTfBogCSR
	oYbFIP1yx4pk2WmsmQKA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3y2kmhmbyf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 14:49:52 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1F9694002D;
	Mon, 13 May 2024 14:49:45 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7AA2121B519;
	Mon, 13 May 2024 14:48:28 +0200 (CEST)
Received: from [10.48.86.164] (10.48.86.164) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 13 May
 2024 14:48:26 +0200
Message-ID: <4da0ce80-2120-4d67-aaaa-7dbf13b1da73@foss.st.com>
Date: Mon, 13 May 2024 14:48:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/11] net: stmmac: dwmac-stm32: rework glue to
 simplify management
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
References: <20240426125707.585269-1-christophe.roullier@foss.st.com>
 <20240426125707.585269-4-christophe.roullier@foss.st.com>
 <56f2d023-82d5-4910-8c4e-68e9d62bd1fe@denx.de>
Content-Language: en-US
From: Christophe ROULLIER <christophe.roullier@foss.st.com>
In-Reply-To: <56f2d023-82d5-4910-8c4e-68e9d62bd1fe@denx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_08,2024-05-10_02,2023-05-22_02

Hi

On 4/26/24 16:53, Marek Vasut wrote:
> On 4/26/24 2:56 PM, Christophe Roullier wrote:
>> Change glue to be more generic and manage easily next stm32 products.
>> The goal of this commit is to have one stm32mp1_set_mode function which
>> can manage different STM32 SOC. SOC can have different SYSCFG register
>> bitfields. so in pmcsetr we defined the bitfields corresponding to 
>> the SOC.
>>
>> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
>> ---
>>   .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 76 +++++++++++++------
>>   1 file changed, 51 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c 
>> b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
>> index c92dfc4ecf57..68a02de25ac7 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
>> @@ -23,10 +23,6 @@
>>     #define SYSCFG_MCU_ETH_MASK        BIT(23)
>>   #define SYSCFG_MP1_ETH_MASK        GENMASK(23, 16)
>> -#define SYSCFG_PMCCLRR_OFFSET        0x40
>> -
>> -#define SYSCFG_PMCR_ETH_CLK_SEL        BIT(16)
>> -#define SYSCFG_PMCR_ETH_REF_CLK_SEL    BIT(17)
>>     /* CLOCK feed to PHY*/
>>   #define ETH_CK_F_25M    25000000
>> @@ -46,9 +42,6 @@
>>    * RMII  |   1     |   0      |   0       |  n/a  |
>>    *------------------------------------------
>>    */
>> -#define SYSCFG_PMCR_ETH_SEL_MII        BIT(20)
>> -#define SYSCFG_PMCR_ETH_SEL_RGMII    BIT(21)
>> -#define SYSCFG_PMCR_ETH_SEL_RMII    BIT(23)
>>   #define SYSCFG_PMCR_ETH_SEL_GMII    0
>>   #define SYSCFG_MCU_ETH_SEL_MII        0
>>   #define SYSCFG_MCU_ETH_SEL_RMII        1
>> @@ -90,19 +83,33 @@ struct stm32_dwmac {
>>       int eth_ref_clk_sel_reg;
>>       int irq_pwr_wakeup;
>>       u32 mode_reg;         /* MAC glue-logic mode register */
>> +    u32 mode_mask;
>>       struct regmap *regmap;
>>       u32 speed;
>>       const struct stm32_ops *ops;
>>       struct device *dev;
>>   };
>>   +struct stm32_syscfg_pmcsetr {
>> +    u32 eth1_clk_sel;
>> +    u32 eth1_ref_clk_sel;
>> +    u32 eth1_selmii;
>> +    u32 eth1_sel_rgmii;
>> +    u32 eth1_sel_rmii;
>> +    u32 eth2_clk_sel;
>> +    u32 eth2_ref_clk_sel;
>> +    u32 eth2_sel_rgmii;
>> +    u32 eth2_sel_rmii;
>> +};
>
> [...]
>
>> @@ -487,8 +502,19 @@ static struct stm32_ops stm32mp1_dwmac_data = {
>>       .suspend = stm32mp1_suspend,
>>       .resume = stm32mp1_resume,
>>       .parse_data = stm32mp1_parse_data,
>> -    .syscfg_eth_mask = SYSCFG_MP1_ETH_MASK,
>> -    .clk_rx_enable_in_suspend = true
>> +    .clk_rx_enable_in_suspend = true,
>> +    .syscfg_clr_off = 0x44,
>> +    .pmcsetr = {
>> +        .eth1_clk_sel        = BIT(16),
>> +        .eth1_ref_clk_sel    = BIT(17),
>> +        .eth1_selmii        = BIT(20),
>> +        .eth1_sel_rgmii        = BIT(21),
>> +        .eth1_sel_rmii        = BIT(23),
>> +        .eth2_clk_sel        = 0,
>> +        .eth2_ref_clk_sel    = 0,
>> +        .eth2_sel_rgmii        = 0,
>> +        .eth2_sel_rmii        = 0
>> +    }
>>   };
>
> Is this structure really necessary ?
>
I prefer to keep this implementation for the moment, as it is working 
fine. Maybe at a later stage, I will send some optimizations.

> It seems the MP15 single ethernet config bitfield is at offset 16.
> MP13 has two bitfields, one at offset 16, the other at offset 24 .
>
> All you need to do is figure out which of the two MACs you are 
> configuring, and then shift the bitfield mask by 16 or 24, since the 
> bits are at the same offset for both bitfields.
>
> See the matching upstream U-Boot commit for how this shift can be done:
> a440d19c6c91 ("net: dwc_eth_qos: Add DT parsing for STM32MP13xx 
> platform")
>

