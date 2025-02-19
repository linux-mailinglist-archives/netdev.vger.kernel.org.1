Return-Path: <netdev+bounces-167628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D13A3B1A3
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 07:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C2FF7A293B
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 06:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD88B1BBBDD;
	Wed, 19 Feb 2025 06:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wIw3KPRA"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B420519D882;
	Wed, 19 Feb 2025 06:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739946530; cv=none; b=QnMK5xgElIDzOmEOPi85dacApJ48BsbZys4noUs1zLynzbteKmPX0V6LFAdv4isA7gI2o+9Eoag7p2a78K1m31E2r5LJcNstxpQYaptCHgMyf8dYPljQWHKiKttOzxtbDLl2hoPvgxCKYWNF0iy312Bwgcya5Rskso4jbAE6PTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739946530; c=relaxed/simple;
	bh=wRd9MxwjAKvHdz5YNG/3ydSOIM2uMQBUDKOW5lR1f4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=j225kEItBA1Yd9sacSrv22uIMLw97aArdv+vjKr5ivfDTu4iRz5+BYPZKljm1DpFniXIBRMjdPEVVzXYWYrL6FAtXrfasKwMC8a9m9EFLHsHQjOcnM89ReTWmh542YJM5SE6jr0sHUPjcGN0gek4C6CdzOwiEIHJC9s8ggrBf7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wIw3KPRA; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51J6SZ4Z212251
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 00:28:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1739946515;
	bh=c5uY6jQqkeSl7uiVV27dk2e2ndRObWC4Qz6fFQdPqYA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=wIw3KPRASNCXDogScJjdjJicLQXwLY1p9c6FSca/g2JoLV6dcfOTPC4ly5vOI9rSy
	 1gp3ekA0gcWHpGXxWYjisSmGLIQoSCYNCjAkMQf61qlT/czEovbNoQLyPGax3rxV2r
	 l3YI7HzoQ5HmrfHunL4iT79IoByDBv/wQlLhLnQg=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51J6SZdH003119
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 19 Feb 2025 00:28:35 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 19
 Feb 2025 00:28:35 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 19 Feb 2025 00:28:35 -0600
Received: from [172.24.20.199] (lt9560gk3.dhcp.ti.com [172.24.20.199])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51J6SUMb081700;
	Wed, 19 Feb 2025 00:28:31 -0600
Message-ID: <09b55ba7-d7a2-46dd-a64c-56f2c02c8552@ti.com>
Date: Wed, 19 Feb 2025 11:58:29 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH net 1/2] net: ti: icss-iep: Fix pwidth
 configuration for perout signal
To: Simon Horman <horms@kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>, <javier.carrasco.cruz@gmail.com>,
        <diogo.ivo@siemens.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
References: <20250211103527.923849-1-m-malladi@ti.com>
 <20250211103527.923849-2-m-malladi@ti.com>
 <3a979b56-e9d6-41c9-910b-63b5371b9631@redhat.com>
 <66f30c0f-dec8-4ad5-9578-a9dcc422355a@ti.com>
 <20250216161158.GH1615191@kernel.org>
Content-Language: en-US
From: "Malladi, Meghana" <m-malladi@ti.com>
In-Reply-To: <20250216161158.GH1615191@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Simon

On 2/16/2025 9:41 PM, Simon Horman wrote:
> On Fri, Feb 14, 2025 at 11:35:07AM +0530, Malladi, Meghana wrote:
>>
>>
>> On 2/13/2025 4:53 PM, Paolo Abeni wrote:
>>> On 2/11/25 11: 35 AM, Meghana Malladi wrote: > @@ -419,8 +426,9 @@
>>> static int icss_iep_perout_enable_hw(struct icss_iep *iep, >
>>> regmap_write(iep->map, ICSS_IEP_CMP1_REG0, lower_32_bits(cmp)); > if
>>> (iep->plat_data->flags &
>>> ZjQcmQRYFpfptBannerStart
>>> This message was sent from outside of Texas Instruments.
>>> Do not click links or open attachments unless you recognize the source
>>> of this email and know the content is safe.
>>> Report Suspicious
>>> <https://us-phishalarm-ewt.proofpoint.com/EWT/v1/G3vK! updqdzavl0dbisXOnfkDHxHqGlQUHEro3tgnljLa7x4DRPBIRKu8Nqm3bW1LeMtXFyqz6yM7_tLlrvUmslKj9m_IL0hUlNU$>
>>> ZjQcmQRYFpfptBannerEnd
>>>
>>> On 2/11/25 11:35 AM, Meghana Malladi wrote:
>>>> @@ -419,8 +426,9 @@ static int icss_iep_perout_enable_hw(struct icss_iep *iep,
>>>>   			regmap_write(iep->map, ICSS_IEP_CMP1_REG0, lower_32_bits(cmp));
>>>>   			if (iep->plat_data->flags & ICSS_IEP_64BIT_COUNTER_SUPPORT)
>>>>   				regmap_write(iep->map, ICSS_IEP_CMP1_REG1, upper_32_bits(cmp));
>>>> -			/* Configure SYNC, 1ms pulse width */
>>>> -			regmap_write(iep->map, ICSS_IEP_SYNC_PWIDTH_REG, 1000000);
>>>> +			/* Configure SYNC, based on req on width */
>>>> +			regmap_write(iep->map, ICSS_IEP_SYNC_PWIDTH_REG,
>>>> +				     (u32)(ns_width / iep->def_inc));
>>>
>>> This causes build errors on 32bits:
>>>
>>> ERROR: modpost: "__udivdi3" [drivers/net/ethernet/ti/icssg/icss_iep.ko]
>>> undefined!
>>> make[3]: *** [../scripts/Makefile.modpost:147: Module.symvers] Error 1
>>> make[2]: *** [/home/nipa/net/wt-0/Makefile:1944: modpost] Error 2
>>> make[1]: *** [/home/nipa/net/wt-0/Makefile:251: __sub-make] Error 2
>>> make: *** [Makefile:251: __sub-make] Error 2
>>> ERROR: modpost: "__udivdi3" [drivers/net/ethernet/ti/icssg/icss_iep.ko]
>>>
>>> You should use div_u64()
>>>
>>
>> I see, thanks.
>> Can you tell me how can I reproduce this on my end for 32 bits.
>> Will fix this in v2.
> 
> Hi Meghana,
> 
> FWIIW, I was able to reproduce this problem running the following
> on an x86_64 system:
> 
> ARCH=i386 make tinyconfig
> 
> echo CONFIG_COMPILE_TEST=y >> .config
> echo CONFIG_PCI=y >> .config
> echo CONFIG_SOC_TI=y >> .config
> echo CONFIG_TI_PRUSS=y >> .config
> echo CONFIG_NET=y >> .config
> echo CONFIG_NETDEVICES=y >> .config
> 
> yes "" | ARCH=i386 make oldconfig
> 
> ARCH=i386 make -j$(nproc)

Thanks for sharing this, I was able to reproduce and fix this locally.


