Return-Path: <netdev+bounces-102792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC2B904B5E
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 08:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFB0E2845AD
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 06:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A87A13CF84;
	Wed, 12 Jun 2024 06:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="4YEtz0TZ"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8169E12D1FE;
	Wed, 12 Jun 2024 06:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718172547; cv=none; b=LsxKX8ZnveJ1JXsmhhAVK8DBeccVTGFBCCkLig3jVeVjI0soLatujcZNSIiSHJJ1xUX92mkfP7+zyMwv7VQgOYrE3h2B4kHgDZu/pVG59OW+rjh01OpO4hU690ye15hVRmhUX8+kQcaccbMh23PuzLWN43JjFAEo4Cf0D0SnkFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718172547; c=relaxed/simple;
	bh=aFKK6Fmj0B8bfmIey09h/A+tBxReA/yVx5zmhonz0PU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bG2pfHONzzKFlcbCCgushH6EzsTUBTJE2eQxnViuTR43qfjQcFLC/fs5bwGfjqDVRZCD2QqfqPj3X1t2/5URZnPRHw6heFDyttvZ+soniKFPVQ5uYdGUuNm4vFnR1Mhb7MyTzpNrLtiMl1ByKlhtZyLU692mbR4+MucDzdRFIBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=4YEtz0TZ; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45C66ALM015571;
	Wed, 12 Jun 2024 08:08:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	4BuUrXtJ8nfNNbqSYjYdRBD5SKv01tJO1QN5QZpZwhI=; b=4YEtz0TZAySLCvkt
	xsYGrK2KlgXBA3ZTzl8DpJTicjrfPqgOYmBaMOUedIFtNJf3CAacwbg32SjpFPj5
	FjFU2V6dc5LjbUibIwq2t7clfaqY19tzoAPYAbN2+coabAB2BslmoUzPJ7ZOUKlf
	E8XUu1aUAOl6fCU1PnSs6BWA/VigR0sHEUybaUD5GmcK0lFFafQwPHYIXutQr+hh
	93VQ4jZxw9uC0LV+7orKpX1I99B8vNmYaBO3+DRsGCs7iJxo1Mt0K+iFn1+ycRfM
	G7Z9HeUp0dZHOFLInm8yH6MvG3mF5keqLLi1QpdCjTR3v9d3lriOJS9FK8o18gwr
	aoD9CA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ypub39r2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 08:08:28 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id B2BCA40044;
	Wed, 12 Jun 2024 08:08:23 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 90E0420D41D;
	Wed, 12 Jun 2024 08:07:10 +0200 (CEST)
Received: from [10.48.86.164] (10.48.86.164) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 12 Jun
 2024 08:07:09 +0200
Message-ID: <1f5000c4-30cd-40fd-b610-24366a15fd6c@foss.st.com>
Date: Wed, 12 Jun 2024 08:07:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,PATCH v7 7/8] net: stmmac: dwmac-stm32: Mask support
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
References: <20240611083606.733453-1-christophe.roullier@foss.st.com>
 <20240611083606.733453-8-christophe.roullier@foss.st.com>
 <ee101ca5-4444-4610-9473-1a725a542c91@denx.de>
 <7999f3df-da1e-4902-b58a-6bb58546a634@foss.st.com>
 <e0b9b074-3aad-4b2d-9f4e-99ad2eebbb6b@denx.de>
Content-Language: en-US
From: Christophe ROULLIER <christophe.roullier@foss.st.com>
In-Reply-To: <e0b9b074-3aad-4b2d-9f4e-99ad2eebbb6b@denx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_02,2024-06-11_01,2024-05-17_01

Hi Marek,

On 6/11/24 18:16, Marek Vasut wrote:
> On 6/11/24 3:32 PM, Christophe ROULLIER wrote:
>>
>> On 6/11/24 15:07, Marek Vasut wrote:
>>> On 6/11/24 10:36 AM, Christophe Roullier wrote:
>>>
>>> [...]
>>>
>>>>   static void stm32_dwmac_clk_disable(struct stm32_dwmac *dwmac, 
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
>>> My comment on V6 was not addressed I think ?
>>
>> Hi Marek,
>>
>> I put the modification in patch which introduce MP13 (V7 8/8) ;-)
>>
>>       err = of_property_read_u32_index(np, "st,syscon", 2, 
>> &dwmac->mode_mask);
>> -    if (err)
>> -        dev_dbg(dev, "Warning sysconfig register mask not set\n");
>> +    if (err) {
>> +        if (dwmac->ops->is_mp13)
>> +            dev_err(dev, "Sysconfig register mask must be set 
>> (%d)\n", err);
>> +        else
>> +            dev_dbg(dev, "Warning sysconfig register mask not set\n");
>> +    }
>
> That isn't right, is it ?
>
> For MP2 , this still checks the presence of syscon , which shouldn't 
> be checked at all for MP2 as far as I understand it ?

When I will push MP2 serie, I will bypass the check of mask syscfg. I 
will push MP2 after MP13 ack.

Thanks


