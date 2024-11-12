Return-Path: <netdev+bounces-144123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C5A9C5AB4
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 15:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0F97B2DE0C
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 14:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC751FF038;
	Tue, 12 Nov 2024 14:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PhBksXze"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB871FCC50;
	Tue, 12 Nov 2024 14:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731422209; cv=none; b=eWb5j/Juxj/0xQuoajci8mBRcpj1tAAm0JGjJ707CaAoc4TQZRUE+6KjWRV37JDQvahHPOYTLUK3qmiOq9c6oRwAqTOltALYknjyFxCz+3H/yDnDr8f3UYjHWTME3s+4ZHQ9H2h18wAAfin7kG+W/nJz6WxFS5Trb4Yhj/t6FaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731422209; c=relaxed/simple;
	bh=5hjTkMNjb3O6ASwW8LoDjAWSFytKM+PMu6z1Tq9qPpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nQC+Ygpdv1/KfRsW2v/4qvYoaFL+SdDAlSpp+bbB81qDfIvV8VIMusT9jl8sn2y8l03cBK1iMe7UksLA8hVnOKsZ74zK7zVUUAeQT6vRXvIjiKKKn4H7LLaEOhd3rAoPilydcyb25B3LxFV/Xb3gUNE7y0DZ8uJakpNpDVDy9G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PhBksXze; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4ACEaGiT042166;
	Tue, 12 Nov 2024 08:36:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1731422176;
	bh=jBVDDEfe2NJA7Dck/V0fwYhzTcJE8DfuUO5x0gs/GXI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=PhBksXze6nYjV9YXpFQ72gvZRkf9jcNUR2F5/2uA45mJ3cZfb1nqFRNsGMFzJPVCA
	 ilM2BxuMV4d/gRHtWYao70lAV/BkW8g5pPe2SU7JxKbLsqTak+wsf1KQSPOPfInGwY
	 YsOBblBDH0PFUKO+0t8f78+0zlPJmMzB339gG+jE=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4ACEaGSd033999;
	Tue, 12 Nov 2024 08:36:16 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Nov 2024 08:36:15 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Nov 2024 08:36:15 -0600
Received: from [10.24.69.13] (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4ACEaAGH047110;
	Tue, 12 Nov 2024 08:36:11 -0600
Message-ID: <bd0e6e92-820e-45ca-8dcf-7194bdd2e510@ti.com>
Date: Tue, 12 Nov 2024 20:06:10 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] net: ti: icssg-prueth: Fix clearing of
 IEP_CMP_CFG registers during iep_init
To: Roger Quadros <rogerq@kernel.org>, <vigneshr@ti.com>,
        <m-karicheri2@ti.com>, <jan.kiszka@siemens.com>,
        <javier.carrasco.cruz@gmail.com>, <jacob.e.keller@intel.com>,
        <horms@kernel.org>, <diogo.ivo@siemens.com>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
        <andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <danishanwar@ti.com>
References: <20241106074040.3361730-1-m-malladi@ti.com>
 <20241106074040.3361730-3-m-malladi@ti.com>
 <f28bf97c-783d-489c-9549-0dd0f576497e@kernel.org>
 <db77a358-a4d3-444e-971e-aa348ad8c8b7@ti.com>
 <ee3aeadb-9897-428c-83e2-3e208f095d1d@kernel.org>
Content-Language: en-US
From: Meghana Malladi <m-malladi@ti.com>
In-Reply-To: <ee3aeadb-9897-428c-83e2-3e208f095d1d@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 12/11/24 18:47, Roger Quadros wrote:
> 
> 
> On 12/11/2024 11:04, Meghana Malladi wrote:
>>
>> On 11/11/24 19:23, Roger Quadros wrote:
>>> Hi,
>>>
>>> On 06/11/2024 09:40, Meghana Malladi wrote:
>>>> When ICSSG interfaces are brought down and brought up again, the
>>>> pru cores are shut down and booted again, flushing out all the memories
>>>> and start again in a clean state. Hence it is expected that the
>>>> IEP_CMP_CFG register needs to be flushed during iep_init() to ensure
>>>> that the existing residual configuration doesn't cause any unusual
>>>> behavior. If the register is not cleared, existing IEP_CMP_CFG set for
>>>> CMP1 will result in SYNC0_OUT signal based on the SYNC_OUT register values.
>>>>
>>>> After bringing the interface up, calling PPS enable doesn't work as
>>>> the driver believes PPS is already enabled, (iep->pps_enabled is not
>>>> cleared during interface bring down) and driver  will just return true
>>>> even though there is no signal. Fix this by setting the iep->pps_enable
>>>> and iep->perout_enable flags to false during the link down.
>>>>
>>>> Fixes: c1e0230eeaab ("net: ti: icss-iep: Add IEP driver")
>>>> Signed-off-by: Meghana Malladi <m-malladi@ti.com>
>>>> ---
>>>>    drivers/net/ethernet/ti/icssg/icss_iep.c | 10 ++++++++++
>>>>    1 file changed, 10 insertions(+)
>>>>
>>>> diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.c b/drivers/net/ethernet/ti/icssg/icss_iep.c
>>>> index 5d6d1cf78e93..03abc25ced12 100644
>>>> --- a/drivers/net/ethernet/ti/icssg/icss_iep.c
>>>> +++ b/drivers/net/ethernet/ti/icssg/icss_iep.c
>>>> @@ -195,6 +195,12 @@ static void icss_iep_enable_shadow_mode(struct icss_iep *iep)
>>>>          icss_iep_disable(iep);
>>>>    +    /* clear compare config */
>>>> +    for (cmp = IEP_MIN_CMP; cmp < IEP_MAX_CMP; cmp++) {
>>>> +        regmap_update_bits(iep->map, ICSS_IEP_CMP_CFG_REG,
>>>> +                   IEP_CMP_CFG_CMP_EN(cmp), 0);
>>>> +    }
>>>> +
>>>
>>> A bit later we are clearing compare status. Can clearing CMP be done in same for loop?
>>>
>>
>> Yes it can be done in the same loop, I will update that.
>>
>>>>        /* disable shadow mode */
>>>>        regmap_update_bits(iep->map, ICSS_IEP_CMP_CFG_REG,
>>>>                   IEP_CMP_CFG_SHADOW_EN, 0);
>>>> @@ -778,6 +784,10 @@ int icss_iep_exit(struct icss_iep *iep)
>>>>            ptp_clock_unregister(iep->ptp_clock);
>>>>            iep->ptp_clock = NULL;
>>>>        }
>>>> +
>>>> +    iep->pps_enabled = false;
>>>> +    iep->perout_enabled = false;
>>>> +
>>>
>>> But how do you keep things in sync with user space?
>>> User might have enabled PPS or PEROUT and then put SLICE0 interface down.
>>> Then if SLICE0 is brought up should PPS/PEROUT keep working like before?
>>
>> No, why? Because either both SLICE0 and SLICE1 run when atleast one interface is up and both SLICE0 and SLICE1 are stopped when both the interfaces are brought down. So when SLICE0 is brought down, SLICE1 is also brought down. Next time you bring an interface up, it is a fresh boot for both SLICE1 and SLICE0. In this case, just like how we register for ptp clock (this is handled by the driver in icss_iep_init(),
>> pps also needs to be enabled (this has to be done by the user).
> 
> I just checked that PPS/PEROUT sysfs don't implement the show hook. So there
> is nothing to be in sync with user space.
> 

I see, thanks for confirming this.

>>
>>> We did call ptp_clock_unregister() so it should unregister the PPS as well.
>>> What I'm not sure is if it calls the ptp->enable() hook to disable the PPS/PEROUT.
>>>
>>> If yes then that should take care of the flags as well.
>>>
>>
>> No, ptp_clock_unregister() doesn't unregister PPS.
>>
>>> If not then you need to call the relevant hooks explicitly but just after
>>> ptp_clock_unregister().
>>> e.g.
>>>      if (iep->pps_enabled)
>>>          icss_iep_pps_enable(iep, false);
>>>      else if (iep->perout_enabled)
>>>          icss_iep_perout_enable(iep, NULL, false);
>>>
>>
>> This doesn't work because if pps_enabled is already true, it goes to icss_iep_pps_enable(), but inside it checks if pps_enabled is true, if so it returns 0, without acutally enabling pps. Which is why we need to set pps_enable and perout_enable to false.
> 
> Note that we are passing false in the last argument. i.e. we want to disable PPS/PEROUT.
> I don't see why it won't work.
> 

I think I overlooked the false part, my bad. Setting pps_enable and 
perout_enable to false and calling relevant hooks - 
icss_iep_pps_enable()/icss_iep_perout_enable(). In both the cases the 
output behavior is same, but the later one is a cleaner approach. I will 
update it.

>>
>>> But this means that user has to again setup PPS/PEROUT.
>>>
>>
>> So yes, this is the expected behavior for user to setup PPS/PEROUT after bringing up an interface. To clarify when user needs to again setup PPS:
>>
>> 1. eth1 and eth2 are up, and one interface is brought down -> PPS/PEROUT will be working the same
>> 2. No interface is up, and one interface is brought up -> PPS/PEROUT needs to be enabled
> 
> OK.
> 
>>
>>>>        icss_iep_disable(iep);
>>>>          return 0;
>>>
> 

