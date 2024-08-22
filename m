Return-Path: <netdev+bounces-120967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E36C95B4D1
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 14:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B98EB2868F1
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 12:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C919D1C9429;
	Thu, 22 Aug 2024 12:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ReNxpoMH"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAF317E00F;
	Thu, 22 Aug 2024 12:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724328929; cv=none; b=ByLABEfUuxhImmp04Iq6Zhqq8IT5UMT7f1Wxs/BQCpDrP9BYtOTB3/ijB4ePGq2/uxHUOUyw3BpY//BmNnnXOr/iPSuDXP8P7KKXuv5WYFr927KfSnbBXiMrnUzI3kAmaZYbhDFlI0LXOMmZiDBHPmiNrPCWr7cHafpCLtpKjBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724328929; c=relaxed/simple;
	bh=/f5kHxv/qK38/VwCO46f6T1RghKua+/79bPaONA41XQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ExK+Swnd6QBILgCqZVAJO+wKbsnnW4CtSatabYjQu37iaaivNRmDEV34j5Dh0v6vrlVC1Ahk874CF4mr9EoZl5MMXbwc1kUW1dqHy9Ltr2Ge93DpfJRU83sg5I2OYSHxbqoLVwxmKyMLn7QHaNiLBFwEEOrqvPRK2K1GieZwlT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ReNxpoMH; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47MCEuiC062629;
	Thu, 22 Aug 2024 07:14:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724328896;
	bh=UDOd1zGVF6byxfuiey4IHC/bFKsyGbIAfpFqY9kh0cg=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=ReNxpoMHajC3pnzXUJ/iVd0KVYqRBmBbhRxZeQ/ZQtj3R7O8EeWaIgwUnhzqAm08/
	 61ksTLbz3bfSgRMverAT24grYtDBSCiCKYO4sVCO9F2RZJK1s9/Qhu6h1+IQ9V+D0/
	 u2rHSPEPwtHTrkIYLvSnb2Avku6OZD/EPEn21L/E=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47MCEuaS010685
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Aug 2024 07:14:56 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 Aug 2024 07:14:55 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 Aug 2024 07:14:55 -0500
Received: from [10.249.135.225] ([10.249.135.225])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47MCElSa086425;
	Thu, 22 Aug 2024 07:14:47 -0500
Message-ID: <59756906-bfbb-4e83-88fc-bc1363515711@ti.com>
Date: Thu, 22 Aug 2024 17:44:46 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 2/2] net: ti: icssg-prueth: Add support for PA
 Stats
To: Roger Quadros <rogerq@kernel.org>, MD Danish Anwar <danishanwar@ti.com>,
        Suman Anna <s-anna@ti.com>, Sai Krishna <saikrishnag@marvell.com>,
        Jan Kiszka
	<jan.kiszka@siemens.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Diogo Ivo
	<diogo.ivo@siemens.com>,
        Kory Maincent <kory.maincent@bootlin.com>,
        Heiner
 Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Simon Horman
	<horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski
	<kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Santosh
 Shilimkar <ssantosh@kernel.org>, Nishanth Menon <nm@ti.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
References: <20240820091657.4068304-1-danishanwar@ti.com>
 <20240820091657.4068304-3-danishanwar@ti.com>
 <03172556-8661-4804-8a3b-0252d91fdf46@kernel.org>
 <79dfc7d2-d738-4899-aadf-a6b4df338c23@ti.com>
 <42f29ba8-e341-474e-9e2a-59f55850803a@kernel.org>
Content-Language: en-US
From: "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <42f29ba8-e341-474e-9e2a-59f55850803a@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 8/22/2024 4:59 PM, Roger Quadros wrote:
> 
> 
> On 22/08/2024 08:28, MD Danish Anwar wrote:
>>
>>
>> On 21/08/24 6:05 pm, Roger Quadros wrote:
>>>
>>>
>>> On 20/08/2024 12:16, MD Danish Anwar wrote:
>>>> Add support for dumping PA stats registers via ethtool.
>>>> Firmware maintained stats are stored at PA Stats registers.
>>>> Also modify emac_get_strings() API to use ethtool_puts().
>>>>
>>>> This commit also renames the array icssg_all_stats to icssg_mii_g_rt_stats
>>>> and creates a new array named icssg_all_pa_stats for PA Stats.
>>>>
>>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>>> ---
>>
>> [ ... ]
>>
>>>> +
>>>>  #define ICSSG_STATS(field, stats_type)			\
>>>>  {							\
>>>>  	#field,						\
>>>> @@ -84,13 +98,24 @@ struct miig_stats_regs {
>>>>  	stats_type					\
>>>>  }
>>>>  
>>>> +#define ICSSG_PA_STATS(field)			\
>>>> +{						\
>>>> +	#field,					\
>>>> +	offsetof(struct pa_stats_regs, field),	\
>>>> +}
>>>> +
>>>>  struct icssg_stats {
>>>
>>> icssg_mii_stats?
>>>
>>
>> Sure Roger. I will name it icssg_miig_stats to be consistent with
>> 'struct miig_stats_regs'
>>
>>>>  	char name[ETH_GSTRING_LEN];
>>>>  	u32 offset;
>>>>  	bool standard_stats;
>>>>  };
>>>>  
>>>> -static const struct icssg_stats icssg_all_stats[] = {
>>>> +struct icssg_pa_stats {
>>>> +	char name[ETH_GSTRING_LEN];
>>>> +	u32 offset;
>>>> +};
>>>> +
>>>> +static const struct icssg_stats icssg_mii_g_rt_stats[] = {
>>>
>>> icssg_all_mii_stats? to be consistend with the newly added
>>> icssg_pa_stats and icssg_all_pa_stats.
>>>
>>> Could you please group all mii_stats data strucutres and arrays together
>>> followed by pa_stats data structures and arrays?
>>>
>>
>> Sure Roger, I will group all mii stats related data structures and
>> pa_stats related data structures together.
>>
>> The sequence and naming will be something like this,
>>
>> struct miig_stats_regs
>> #define ICSSG_MIIG_STATS(field, stats_type)
>> struct icssg_miig_stats
>> static const struct icssg_miig_stats icssg_all_miig_stats[]
>>
>> struct pa_stats_regs
>> #define ICSSG_PA_STATS(field)
>> struct icssg_pa_stats
>> static const struct icssg_pa_stats icssg_all_pa_stats[]
>>
>> Let me know if this looks ok to you.
> 
> This is good. Thanks!
> 

Sure I will post next version soon.

>>
>>>>  	/* Rx */
>>>>  	ICSSG_STATS(rx_packets, true),
>>>>  	ICSSG_STATS(rx_broadcast_frames, false),
>>>> @@ -155,4 +180,11 @@ static const struct icssg_stats icssg_all_stats[] = {
>>>>  	ICSSG_STATS(tx_bytes, true),t
>>>>  };
>>>>  
>>>> +static const struct icssg_pa_stats icssg_all_pa_stats[] = > +	ICSSG_PA_STATS(fw_rx_cnt),
>>>> +	ICSSG_PA_STATS(fw_tx_cnt),
>>>> +	ICSSG_PA_STATS(fw_tx_pre_overflow),
>>>> +	ICSSG_PA_STATS(fw_tx_exp_overflow),
>>>> +};
>>>> +
>>>>  #endif /* __NET_TI_ICSSG_STATS_H */
>>>
>>
> 

-- 
Thanks and Regards,
Md Danish Anwar

