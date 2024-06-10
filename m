Return-Path: <netdev+bounces-102230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BBF9020A1
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 13:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88A081F21F45
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 11:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B15D7D088;
	Mon, 10 Jun 2024 11:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="p2PN4/Ps"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35A97C6EB;
	Mon, 10 Jun 2024 11:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718020018; cv=none; b=fu5MXgC0/rlLHy4wykm9xb/72+3HHRG5uwEwJgji9Htm9FP6m6YI31XSH/HeMpTGfPqAlDyB3s3TQKLYX8+/mnSpiPCOwIIyrdocpxEabEwDfK5mKHSkNfg9u1DuGNuFo8wftr5o5DuBA2EU2v3RUIqJW/Hxuu81IZlAhjt8vy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718020018; c=relaxed/simple;
	bh=cO/r8Z4NMLMNKUw5RcGGIRel+4bcO3Tor7T1qEhGYiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rKU2A11SSlCp4KAwxZnSSqHS80Ss+kbFJXipjsn8Bi9HIWbAxI3CL1mwkkiqco/wMW+gHFCFTdllwx29Kla1CjZLrb0AsnMtBcHWldJGafE5jXVJNSOw7tgQdlT/SwbPPv7MgHMaXaMW7VY3QYPq6kTsIsAy7WuXrwpxTuaoYik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=p2PN4/Ps; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45A8Csfe015503;
	Mon, 10 Jun 2024 13:46:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	NLGY4SlIiBcaxzvgC7IKiZv6Lsi5LnhvOHDsDuCMGlE=; b=p2PN4/PsKalzGyRM
	Ys5q/WeS7Co31Z8hBg0ERHW4EZBE0sRg3sgHdLNvt51bIHkbR9JSjCBbmkR1R9In
	UMQovCBBoQuB40rOsd8ZwlJyh7KWm2V6VGxhBDCG5MAvFjTuxBzjoCLCMvCzM6Uo
	B2bI91W1wst4k6YO1rd2vNfDl6mE0FpgHTgQ4OfS7R1CiOnhYaOrxMuRxDrhuGuC
	rjXxxDM2vP9t0iO8LadmjDTEM4WzY4OIvsYWHLATXJwG4U+5nyBfROskg24u9rY2
	gyIMpz5YO1GQivUykDetLUf3DbhsbTwvPD6OAXOU+7G727qM60LeS/iRuEoUITDk
	1vB+WA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ymemxppqp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 13:46:28 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 12CF040047;
	Mon, 10 Jun 2024 13:46:22 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 90B9D21684A;
	Mon, 10 Jun 2024 13:45:10 +0200 (CEST)
Received: from [10.48.86.164] (10.48.86.164) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 10 Jun
 2024 13:45:09 +0200
Message-ID: <c5ea12e7-5ee6-4960-9141-e774ccd9977b@foss.st.com>
Date: Mon, 10 Jun 2024 13:45:08 +0200
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
Content-Language: en-US
From: Christophe ROULLIER <christophe.roullier@foss.st.com>
In-Reply-To: <20139233-4e95-4fe5-84ca-734ee866afca@denx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_02,2024-06-10_01,2024-05-17_01


On 6/10/24 12:39, Marek Vasut wrote:
> On 6/10/24 9:14 AM, Christophe Roullier wrote:
>
> [...]
>
>>   static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
>> @@ -303,7 +307,7 @@ static int stm32mcu_set_mode(struct 
>> plat_stmmacenet_data *plat_dat)
>>       dev_dbg(dwmac->dev, "Mode %s", 
>> phy_modes(plat_dat->mac_interface));
>>         return regmap_update_bits(dwmac->regmap, reg,
>> -                 dwmac->ops->syscfg_eth_mask, val << 23);
>> +                 SYSCFG_MCU_ETH_MASK, val << 23);
>>   }
>>     static void stm32_dwmac_clk_disable(struct stm32_dwmac *dwmac, 
>> bool suspend)
>> @@ -348,8 +352,15 @@ static int stm32_dwmac_parse_data(struct 
>> stm32_dwmac *dwmac,
>>           return PTR_ERR(dwmac->regmap);
>>         err = of_property_read_u32_index(np, "st,syscon", 1, 
>> &dwmac->mode_reg);
>> -    if (err)
>> +    if (err) {
>>           dev_err(dev, "Can't get sysconfig mode offset (%d)\n", err);
>> +        return err;
>> +    }
>> +
>> +    dwmac->mode_mask = SYSCFG_MP1_ETH_MASK;
>> +    err = of_property_read_u32_index(np, "st,syscon", 2, 
>> &dwmac->mode_mask);
>> +    if (err)
>> +        dev_dbg(dev, "Warning sysconfig register mask not set\n");
>
> Isn't this an error , so dev_err() ?
No, it is only "warning" information, for MP1 the mask is not needed 
(and for backward compatibility is not planned to put mask parameter 
mandatory)
>
> Include the err variable in the error message, see the dev_err() above 
> for an example. That way the log already contains useful information 
> (the error code) that can be used to narrow down the problem.

