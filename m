Return-Path: <netdev+bounces-166307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F530A356B7
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 07:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E82DA3AD24F
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 06:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4541DB92A;
	Fri, 14 Feb 2025 06:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Ho/Sxa1b"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1A21DA2E5;
	Fri, 14 Feb 2025 06:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739513144; cv=none; b=Gqv6CTVTu8FJOAIamak6jNREvJ5FKRolsqVX4INxUH2PJuoAMOhzAW5K4X5Kx2B6J9aLyA7RABGP4UCiP4Er2Rng6IC5ScY1kfSt738QWTnhGo7dqR6tIEmBgFl7qduWYKbRskshD9khzWFEKlejlgERvPEAbZwLsjpznktZRvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739513144; c=relaxed/simple;
	bh=VgutWXKUxrpUBj1Z0jT3oDJdo2f6anV/Udr1h+4FdEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YnViGrF4T+xjI5zxWXeKjJGQ5tTfMgXb9YaoB1FNsa4yAfydfm/Cf+wEyB/zHBXRmDwG20aL54i7Hr7jAYcXSSR0mKU4VR0VtY8ib7C5YQCYPvHNPbaFwwUHcxCm2RuQggZJAxcpcHrAE3BQZr2onaeqtP7bl/UeI9ddpyrr3+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Ho/Sxa1b; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51E65E9V4158044
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Feb 2025 00:05:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1739513114;
	bh=Qw7XIK846oCUWiLOfnk5Jrq4uCGhW+CbWo1jUtxsbSc=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Ho/Sxa1bQv3IKJlC684wTKz5EGQBl7q/G4t7WCcZ2uoZ2OesrcT78b/ESjjagB28v
	 r33YtHlV7Yp6EVrK9QTfMndgoyTHkrh38aJAY4zRDwTzLgmOviK11/T8qgY7g8kt0H
	 +JQOCqwyESXT09/V14jVNF7f5cgGZ/mYS6ZwegJE=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51E65EVo053089
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 14 Feb 2025 00:05:14 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Feb 2025 00:05:13 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Feb 2025 00:05:13 -0600
Received: from [10.249.140.156] ([10.249.140.156])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51E658er104524;
	Fri, 14 Feb 2025 00:05:09 -0600
Message-ID: <66f30c0f-dec8-4ad5-9578-a9dcc422355a@ti.com>
Date: Fri, 14 Feb 2025 11:35:07 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH net 1/2] net: ti: icss-iep: Fix pwidth
 configuration for perout signal
To: Paolo Abeni <pabeni@redhat.com>, <javier.carrasco.cruz@gmail.com>,
        <diogo.ivo@siemens.com>, <horms@kernel.org>, <kuba@kernel.org>,
        <edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
References: <20250211103527.923849-1-m-malladi@ti.com>
 <20250211103527.923849-2-m-malladi@ti.com>
 <3a979b56-e9d6-41c9-910b-63b5371b9631@redhat.com>
Content-Language: en-US
From: "Malladi, Meghana" <m-malladi@ti.com>
In-Reply-To: <3a979b56-e9d6-41c9-910b-63b5371b9631@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 2/13/2025 4:53 PM, Paolo Abeni wrote:
> On 2/11/25 11: 35 AM, Meghana Malladi wrote: > @@ -419,8 +426,9 @@ 
> static int icss_iep_perout_enable_hw(struct icss_iep *iep, > 
> regmap_write(iep->map, ICSS_IEP_CMP1_REG0, lower_32_bits(cmp)); > if 
> (iep->plat_data->flags &
> ZjQcmQRYFpfptBannerStart
> This message was sent from outside of Texas Instruments.
> Do not click links or open attachments unless you recognize the source 
> of this email and know the content is safe.
> Report Suspicious
> <https://us-phishalarm-ewt.proofpoint.com/EWT/v1/G3vK! 
> updqdzavl0dbisXOnfkDHxHqGlQUHEro3tgnljLa7x4DRPBIRKu8Nqm3bW1LeMtXFyqz6yM7_tLlrvUmslKj9m_IL0hUlNU$>
> ZjQcmQRYFpfptBannerEnd
> 
> On 2/11/25 11:35 AM, Meghana Malladi wrote:
>> @@ -419,8 +426,9 @@ static int icss_iep_perout_enable_hw(struct icss_iep *iep,
>>  			regmap_write(iep->map, ICSS_IEP_CMP1_REG0, lower_32_bits(cmp));
>>  			if (iep->plat_data->flags & ICSS_IEP_64BIT_COUNTER_SUPPORT)
>>  				regmap_write(iep->map, ICSS_IEP_CMP1_REG1, upper_32_bits(cmp));
>> -			/* Configure SYNC, 1ms pulse width */
>> -			regmap_write(iep->map, ICSS_IEP_SYNC_PWIDTH_REG, 1000000);
>> +			/* Configure SYNC, based on req on width */
>> +			regmap_write(iep->map, ICSS_IEP_SYNC_PWIDTH_REG,
>> +				     (u32)(ns_width / iep->def_inc));
> 
> This causes build errors on 32bits:
> 
> ERROR: modpost: "__udivdi3" [drivers/net/ethernet/ti/icssg/icss_iep.ko]
> undefined!
> make[3]: *** [../scripts/Makefile.modpost:147: Module.symvers] Error 1
> make[2]: *** [/home/nipa/net/wt-0/Makefile:1944: modpost] Error 2
> make[1]: *** [/home/nipa/net/wt-0/Makefile:251: __sub-make] Error 2
> make: *** [Makefile:251: __sub-make] Error 2
> ERROR: modpost: "__udivdi3" [drivers/net/ethernet/ti/icssg/icss_iep.ko]
> 
> You should use div_u64()
> 

I see, thanks.
Can you tell me how can I reproduce this on my end for 32 bits.
Will fix this in v2.

> /P
> 


