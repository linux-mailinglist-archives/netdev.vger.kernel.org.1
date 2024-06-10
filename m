Return-Path: <netdev+bounces-102275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAD990233A
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 15:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 682451C2253E
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 13:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2F084FC4;
	Mon, 10 Jun 2024 13:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="z9bRYthr"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE3682D75;
	Mon, 10 Jun 2024 13:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718027507; cv=none; b=lPfEUQ7Im/haHT2LjRX/rO+Abp/SghM25WDF6YxYJASnfFfmqB9efyNHypDdaahsAfO7/MMpaVHZUocV5i9g69kei0qddi2T8Kl+Qj5BkucpEXdOfb6wU69omNYV5lqOJ0nRX+DdBuHWwbs9cJHGsQhyrDl9G1Qd+8uDwUnQ6QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718027507; c=relaxed/simple;
	bh=z6q7jyPj/z6RQLVJZxM1J27Mm3BoSUPWnn1OKfGRNgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=vDjLb3nDg0NomI3dlsG/Dar+kF/VDDjdB0iAnvVEKv5r3hq1xSavfS6dwSasATw6dRPQjDne/DGI7iv3uLF6ZxVnLlvIU9D0Cp2iaFU1SOnBrtnDyRfoIJTK5kDwdOzDyiGot21jD6XpQcXU2DAD07l3v+acnFFr0+9TNRJgHoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=z9bRYthr; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ACUjOe011470;
	Mon, 10 Jun 2024 15:51:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	i7o7N5B7+jfcvWuYAHwVeh2JCgEO5HfdPITsk4LeZr0=; b=z9bRYthrmDiTXApj
	hZJp31j8pmkI58wkwiYMwvJ6dh6cN3rCynpQ9QTFAvjM3MCCBgq8aFc+mfFihPdK
	EsUWEtdN5Q2ROL7KIJniKD6CHTXu6jH2oLfcgVTpLUrnvqKl/KB1x8n4z1nQlf2a
	kXCQAtY5+9PITZj1vmpy/9DBsZMHKC9h7aM7yk3zCpeo0OIUvrj3zw1b77hQ1+ED
	LyLHae/7asxFwA2ViqgzBQjVYJtuomxbYIjoUXROe+rYDVYn+0EAUSrOi+sNmK9e
	wJCEUcF+/upWIvYu446W/1gZCJGY5FcOHDumDCEIREoOTl2hPEA85kooQ4ICTkYp
	fXXc+A==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yme6d74q3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 15:51:19 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id DA57940046;
	Mon, 10 Jun 2024 15:51:13 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D0ECB2194EE;
	Mon, 10 Jun 2024 15:49:59 +0200 (CEST)
Received: from [10.48.86.164] (10.48.86.164) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 10 Jun
 2024 15:49:58 +0200
Message-ID: <91af5c61-f23f-4f72-a8c8-f32b2c368768@foss.st.com>
Date: Mon, 10 Jun 2024 15:49:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,PATCH v6 7/8] net: stmmac: dwmac-stm32: Mask support
 for PMCR configuration
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
References: <20240610071459.287500-1-christophe.roullier@foss.st.com>
 <20240610071459.287500-8-christophe.roullier@foss.st.com>
 <20139233-4e95-4fe5-84ca-734ee866afca@denx.de>
 <c5ea12e7-5ee6-4960-9141-e774ccd9977b@foss.st.com>
 <09105afe-1123-407a-96c3-2ea88602aad0@denx.de>
Content-Language: en-US
From: Christophe ROULLIER <christophe.roullier@foss.st.com>
In-Reply-To: <09105afe-1123-407a-96c3-2ea88602aad0@denx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_02,2024-06-10_01,2024-05-17_01


On 6/10/24 15:43, Marek Vasut wrote:
> On 6/10/24 1:45 PM, Christophe ROULLIER wrote:
>>
>> On 6/10/24 12:39, Marek Vasut wrote:
>>> On 6/10/24 9:14 AM, Christophe Roullier wrote:
>>>
>>> [...]
>>>
>>>>   static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
>>>> @@ -303,7 +307,7 @@ static int stm32mcu_set_mode(struct 
>>>> plat_stmmacenet_data *plat_dat)
>>>>       dev_dbg(dwmac->dev, "Mode %s", 
>>>> phy_modes(plat_dat->mac_interface));
>>>>         return regmap_update_bits(dwmac->regmap, reg,
>>>> -                 dwmac->ops->syscfg_eth_mask, val << 23);
>>>> +                 SYSCFG_MCU_ETH_MASK, val << 23);
>>>>   }
>>>>     static void stm32_dwmac_clk_disable(struct stm32_dwmac *dwmac, 
>>>> bool suspend)
>>>> @@ -348,8 +352,15 @@ static int stm32_dwmac_parse_data(struct 
>>>> stm32_dwmac *dwmac,
>>>>           return PTR_ERR(dwmac->regmap);
>>>>         err = of_property_read_u32_index(np, "st,syscon", 1, 
>>>> &dwmac->mode_reg);
>>>> -    if (err)
>>>> +    if (err) {
>>>>           dev_err(dev, "Can't get sysconfig mode offset (%d)\n", err);
>>>> +        return err;
>>>> +    }
>>>> +
>>>> +    dwmac->mode_mask = SYSCFG_MP1_ETH_MASK;
>>>> +    err = of_property_read_u32_index(np, "st,syscon", 2, 
>>>> &dwmac->mode_mask);
>>>> +    if (err)
>>>> +        dev_dbg(dev, "Warning sysconfig register mask not set\n");
>>>
>>> Isn't this an error , so dev_err() ?
>> No, it is only "warning" information, for MP1 the mask is not needed 
>> (and for backward compatibility is not planned to put mask parameter 
>> mandatory)
>
> Should this be an error for anything newer than MP15 then ?
For MP25, no need of mask, so for moment it is specific to MP13.

