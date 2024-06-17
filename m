Return-Path: <netdev+bounces-103996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0992B90ACE1
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 13:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88F7D1F2238C
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 11:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEDA194C66;
	Mon, 17 Jun 2024 11:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="ux4Jf4p+"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821851946BF;
	Mon, 17 Jun 2024 11:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718623485; cv=none; b=OLPJES9EeIOR0YHTsb6bKg4sCHcfD2TfmsHX8eu6mmktZ82FVO5yszlSdQnxa9XNFVMrUSQurfSFmCUxl2kHrRV4lIvKfutpkQncPkYgCJYbS230UDlpO4IaseoWLxNBJVupQJ9svr2fdN8GpmUlXoPAFvFoQYrZyf3+U0GYIcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718623485; c=relaxed/simple;
	bh=eaGIv4aNnjyodwJuzlJ/GaTpMfiWBxYzeoYrErNR4uQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IlMEgJUm2ygqFTy/IGqPH0G2AgicSgTFdxzrXPXa3RlmUqRs4+Gevc6RaYxExTkTj2m7K2cjNWYQqWAWVS+AgVvLb0Y58OtPyoPfGYNIn5eFcVZSyuDllxxsF/4AXqdDCulpsIQP8oMLkhj3p2qQyTgZcCJd1zPSbCH4zIaXCtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=ux4Jf4p+; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45H8QOdR013701;
	Mon, 17 Jun 2024 13:24:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	ihd8JZG+nI+ageiVBS3hq5sjCegkaeHknt9LK/X6/1M=; b=ux4Jf4p+Y3hysvf7
	F+iuZ1qR8apPHEwU+kNDncimJCJWMDlMnXr02oMQ83nzurKCa45K9GvP6sK52p/f
	GEVbbk4alTESbn8+x2X7+4bYe3HWryK/qhuhNn4TySFvDwIriF8CtdY0M5yrZ+AP
	zC/mOeiZcJskKOKcMSJsBDiBKxQ73YdmY711H92TpQU/4ydBMZpIU6w6xmTtg/U6
	76Sf6Muq/tjjb08ogee9FBt2Mg8VgdVM6Cch9LlPnvelW2urWGx+VT1/jkg6/VcA
	nPcvFkr/UyumtAlIrH1NHFvKpBqqWjyj3mAUMqeoNc+Mk5l+aOjlA52LO9Cv46yZ
	2hd+OA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ys035e84u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 13:24:11 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 0FA104002D;
	Mon, 17 Jun 2024 13:24:06 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 809252132CA;
	Mon, 17 Jun 2024 13:23:37 +0200 (CEST)
Received: from [10.48.86.164] (10.48.86.164) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 17 Jun
 2024 13:23:36 +0200
Message-ID: <09010b02-fb55-4c4b-9d0c-36bd0b370dc8@foss.st.com>
Date: Mon, 17 Jun 2024 13:23:35 +0200
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
Content-Language: en-US
From: Christophe ROULLIER <christophe.roullier@foss.st.com>
In-Reply-To: <4c2f1bac-4957-4814-bf62-816340bd9ff6@denx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_10,2024-06-17_01,2024-05-17_01

Hi Marek,

On 6/14/24 15:58, Marek Vasut wrote:
> On 6/14/24 3:08 PM, Christophe Roullier wrote:
>
> [...]
>
>> +static int stm32mp2_configure_syscfg(struct plat_stmmacenet_data 
>> *plat_dat)
>> +{
>> +    struct stm32_dwmac *dwmac = plat_dat->bsp_priv;
>> +    u32 reg = dwmac->mode_reg;
>> +    int val = 0;
>> +
>> +    switch (plat_dat->mac_interface) {
>> +    case PHY_INTERFACE_MODE_MII:
>> +        break;
>
> dwmac->enable_eth_ck does not apply to MII mode ? Why ?

It is like MP1 and MP13, nothing to set in syscfg register for case MII 
mode wo crystal.

>
>> +    case PHY_INTERFACE_MODE_GMII:
>> +        if (dwmac->enable_eth_ck)
>> +            val |= SYSCFG_ETHCR_ETH_CLK_SEL;
>> +        break;
>> +    case PHY_INTERFACE_MODE_RMII:
>> +        val = SYSCFG_ETHCR_ETH_SEL_RMII;
>> +        if (dwmac->enable_eth_ck)
>> +            val |= SYSCFG_ETHCR_ETH_REF_CLK_SEL;
>> +        break;
>> +    case PHY_INTERFACE_MODE_RGMII:
>> +    case PHY_INTERFACE_MODE_RGMII_ID:
>> +    case PHY_INTERFACE_MODE_RGMII_RXID:
>> +    case PHY_INTERFACE_MODE_RGMII_TXID:
>> +        val = SYSCFG_ETHCR_ETH_SEL_RGMII;
>> +        if (dwmac->enable_eth_ck)
>> +            val |= SYSCFG_ETHCR_ETH_CLK_SEL;
>> +        break;
>> +    default:
>> +        dev_err(dwmac->dev, "Mode %s not supported",
>> +            phy_modes(plat_dat->mac_interface));
>> +        /* Do not manage others interfaces */
>> +        return -EINVAL;
>> +    }
>> +
>> +    dev_dbg(dwmac->dev, "Mode %s", phy_modes(plat_dat->mac_interface));
>> +
>> +    /*  select PTP (IEEE1588) clock selection from RCC 
>> (ck_ker_ethxptp) */
>
> Drop extra leading space.
> Sentence starts with capital letter.
ok
>
>> +    val |= SYSCFG_ETHCR_ETH_PTP_CLK_SEL;
>> +
>> +    /* Update ETHCR (set register) */
>> +    return regmap_update_bits(dwmac->regmap, reg,
>> +                 SYSCFG_MP2_ETH_MASK, val);
>> +}
>> +
>>   static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
>>   {
>>       int ret;
>> @@ -292,6 +346,21 @@ static int stm32mp1_set_mode(struct 
>> plat_stmmacenet_data *plat_dat)
>>       return stm32mp1_configure_pmcr(plat_dat);
>>   }
>>   +static int stm32mp2_set_mode(struct plat_stmmacenet_data *plat_dat)
>> +{
>> +    int ret;
>> +
>> +    ret = stm32mp1_select_ethck_external(plat_dat);
>> +    if (ret)
>> +        return ret;
>> +
>> +    ret = stm32mp1_validate_ethck_rate(plat_dat);
>> +    if (ret)
>> +        return ret;
>
>
> Is it necessary to duplicate this entire function instead of some:
>
> if (is_mp2)
>   return stm32mp2_configure_syscfg(plat_dat);
> else
>   return stm32mp1_configure_syscfg(plat_dat);
>
> ?
ok I would like to avoid to use is_mp2 boolean but you are right it is 
simplify visibility of the code.
>
>> +    return stm32mp2_configure_syscfg(plat_dat);
>> +}
>> +
>>   static int stm32mcu_set_mode(struct plat_stmmacenet_data *plat_dat)
>>   {
>>       struct stm32_dwmac *dwmac = plat_dat->bsp_priv;
>> @@ -348,12 +417,6 @@ static int stm32_dwmac_parse_data(struct 
>> stm32_dwmac *dwmac,
>>           return PTR_ERR(dwmac->clk_rx);
>>       }
>>   -    if (dwmac->ops->parse_data) {
>> -        err = dwmac->ops->parse_data(dwmac, dev);
>> -        if (err)
>> -            return err;
>> -    }
>> -
>>       /* Get mode register */
>>       dwmac->regmap = syscon_regmap_lookup_by_phandle(np, "st,syscon");
>>       if (IS_ERR(dwmac->regmap))
>> @@ -365,20 +428,14 @@ static int stm32_dwmac_parse_data(struct 
>> stm32_dwmac *dwmac,
>>           return err;
>>       }
>>   -    dwmac->mode_mask = SYSCFG_MP1_ETH_MASK;
>> -    err = of_property_read_u32_index(np, "st,syscon", 2, 
>> &dwmac->mode_mask);
>> -    if (err) {
>> -        if (dwmac->ops->is_mp13)
>> -            dev_err(dev, "Sysconfig register mask must be set 
>> (%d)\n", err);
>> -        else
>> -            dev_dbg(dev, "Warning sysconfig register mask not set\n");
>> -    }
>> +    if (dwmac->ops->parse_data)
>> +        err = dwmac->ops->parse_data(dwmac, dev);
>
> Why is this change here ? What is the purpose ?
> This should be documented in commit message too.
>
> The indirect call is not necessary either, simply do
>
> if (is_mp2)
>   return err;
>
> ... do mp15/13 stuff here ...
>
> return err;
Right, with use of is_mp2 variable it is more simple
>
> [...]

