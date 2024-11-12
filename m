Return-Path: <netdev+bounces-144088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DD69C58C7
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 14:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1774E1F21D11
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 13:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3DA140E5F;
	Tue, 12 Nov 2024 13:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XlsyByGW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D525142AA4;
	Tue, 12 Nov 2024 13:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731417434; cv=none; b=YcW9ezv5RsmCN082NnJpss5riaeCZOCfc3FiNxj4gWMiOxcWbJS2ZqVxEGidqNgyq0+hlh8T0mEKG9XCUzxUM9ijZf9qZw4ydCK7aUkofWdTI1G6oatdfm0oXCnUXlqQ9TG5dW7M4gM0/EdvpbOtE5KeMMiKjeAQqCZf3/O9eck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731417434; c=relaxed/simple;
	bh=bQbs1NAEcYo8+Js/A0LgSfHJ0MSgGorRyKV7H81F7xs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SNPA5vteNNHmTSwV26bmK5vmruy//dHg8dODNt/uRL0BCs3OKBHLDHY1k3P/7d9h006rbvF+07LATofeZHZCJRtTxA7lyGjcqsURGM4ni/0/jn1nEZg0zUNo0mM6muWlJAwnh53zNzt9LjOgap8sRKTh939rlBDASkiBA7xH5CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XlsyByGW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A836C4CECD;
	Tue, 12 Nov 2024 13:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731417434;
	bh=bQbs1NAEcYo8+Js/A0LgSfHJ0MSgGorRyKV7H81F7xs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XlsyByGWX50FnVkBEZVH5pbvxsXfoiib0TlOyLKQoVmNEFH6lzZSgdArY4kPOXz6/
	 qiaNs7nV/x+i8Je3ea/uxNbmRNIs4LDpmz4DKeOxnm3ZWzrPO57kr7wAr/+WIu845+
	 FNAkpTTkAkn8a9rL1ovQaESmFEKo3A12xcqoVtswH39cBqNoI7B0PTMpdaBuTw5swi
	 sFFZguwV7XtkRnBgcMB9kYXz7tVKun/8rQg9NSFwhHpqJY+DUKOYxlBQXSH4aMt7hR
	 8OhV8iN6geYzCm7TWCehsLCiyAtq9DwN9Q5QecnstY+2vSrvHFx0ZdTkQ4p7AdZJQm
	 RGbFHeJmrC5hw==
Message-ID: <ee3aeadb-9897-428c-83e2-3e208f095d1d@kernel.org>
Date: Tue, 12 Nov 2024 15:17:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] net: ti: icssg-prueth: Fix clearing of
 IEP_CMP_CFG registers during iep_init
To: Meghana Malladi <m-malladi@ti.com>, vigneshr@ti.com, m-karicheri2@ti.com,
 jan.kiszka@siemens.com, javier.carrasco.cruz@gmail.com,
 jacob.e.keller@intel.com, horms@kernel.org, diogo.ivo@siemens.com,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com, danishanwar@ti.com
References: <20241106074040.3361730-1-m-malladi@ti.com>
 <20241106074040.3361730-3-m-malladi@ti.com>
 <f28bf97c-783d-489c-9549-0dd0f576497e@kernel.org>
 <db77a358-a4d3-444e-971e-aa348ad8c8b7@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <db77a358-a4d3-444e-971e-aa348ad8c8b7@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12/11/2024 11:04, Meghana Malladi wrote:
> 
> On 11/11/24 19:23, Roger Quadros wrote:
>> Hi,
>>
>> On 06/11/2024 09:40, Meghana Malladi wrote:
>>> When ICSSG interfaces are brought down and brought up again, the
>>> pru cores are shut down and booted again, flushing out all the memories
>>> and start again in a clean state. Hence it is expected that the
>>> IEP_CMP_CFG register needs to be flushed during iep_init() to ensure
>>> that the existing residual configuration doesn't cause any unusual
>>> behavior. If the register is not cleared, existing IEP_CMP_CFG set for
>>> CMP1 will result in SYNC0_OUT signal based on the SYNC_OUT register values.
>>>
>>> After bringing the interface up, calling PPS enable doesn't work as
>>> the driver believes PPS is already enabled, (iep->pps_enabled is not
>>> cleared during interface bring down) and driver  will just return true
>>> even though there is no signal. Fix this by setting the iep->pps_enable
>>> and iep->perout_enable flags to false during the link down.
>>>
>>> Fixes: c1e0230eeaab ("net: ti: icss-iep: Add IEP driver")
>>> Signed-off-by: Meghana Malladi <m-malladi@ti.com>
>>> ---
>>>   drivers/net/ethernet/ti/icssg/icss_iep.c | 10 ++++++++++
>>>   1 file changed, 10 insertions(+)
>>>
>>> diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.c b/drivers/net/ethernet/ti/icssg/icss_iep.c
>>> index 5d6d1cf78e93..03abc25ced12 100644
>>> --- a/drivers/net/ethernet/ti/icssg/icss_iep.c
>>> +++ b/drivers/net/ethernet/ti/icssg/icss_iep.c
>>> @@ -195,6 +195,12 @@ static void icss_iep_enable_shadow_mode(struct icss_iep *iep)
>>>         icss_iep_disable(iep);
>>>   +    /* clear compare config */
>>> +    for (cmp = IEP_MIN_CMP; cmp < IEP_MAX_CMP; cmp++) {
>>> +        regmap_update_bits(iep->map, ICSS_IEP_CMP_CFG_REG,
>>> +                   IEP_CMP_CFG_CMP_EN(cmp), 0);
>>> +    }
>>> +
>>
>> A bit later we are clearing compare status. Can clearing CMP be done in same for loop?
>>
> 
> Yes it can be done in the same loop, I will update that.
> 
>>>       /* disable shadow mode */
>>>       regmap_update_bits(iep->map, ICSS_IEP_CMP_CFG_REG,
>>>                  IEP_CMP_CFG_SHADOW_EN, 0);
>>> @@ -778,6 +784,10 @@ int icss_iep_exit(struct icss_iep *iep)
>>>           ptp_clock_unregister(iep->ptp_clock);
>>>           iep->ptp_clock = NULL;
>>>       }
>>> +
>>> +    iep->pps_enabled = false;
>>> +    iep->perout_enabled = false;
>>> +
>>
>> But how do you keep things in sync with user space?
>> User might have enabled PPS or PEROUT and then put SLICE0 interface down.
>> Then if SLICE0 is brought up should PPS/PEROUT keep working like before?
> 
> No, why? Because either both SLICE0 and SLICE1 run when atleast one interface is up and both SLICE0 and SLICE1 are stopped when both the interfaces are brought down. So when SLICE0 is brought down, SLICE1 is also brought down. Next time you bring an interface up, it is a fresh boot for both SLICE1 and SLICE0. In this case, just like how we register for ptp clock (this is handled by the driver in icss_iep_init(),
> pps also needs to be enabled (this has to be done by the user).

I just checked that PPS/PEROUT sysfs don't implement the show hook. So there
is nothing to be in sync with user space.

> 
>> We did call ptp_clock_unregister() so it should unregister the PPS as well.
>> What I'm not sure is if it calls the ptp->enable() hook to disable the PPS/PEROUT.
>>
>> If yes then that should take care of the flags as well.
>>
> 
> No, ptp_clock_unregister() doesn't unregister PPS.
> 
>> If not then you need to call the relevant hooks explicitly but just after
>> ptp_clock_unregister().
>> e.g.
>>     if (iep->pps_enabled)
>>         icss_iep_pps_enable(iep, false);
>>     else if (iep->perout_enabled)
>>         icss_iep_perout_enable(iep, NULL, false);
>>
> 
> This doesn't work because if pps_enabled is already true, it goes to icss_iep_pps_enable(), but inside it checks if pps_enabled is true, if so it returns 0, without acutally enabling pps. Which is why we need to set pps_enable and perout_enable to false.

Note that we are passing false in the last argument. i.e. we want to disable PPS/PEROUT.
I don't see why it won't work.

> 
>> But this means that user has to again setup PPS/PEROUT.   
>>
> 
> So yes, this is the expected behavior for user to setup PPS/PEROUT after bringing up an interface. To clarify when user needs to again setup PPS:
> 
> 1. eth1 and eth2 are up, and one interface is brought down -> PPS/PEROUT will be working the same
> 2. No interface is up, and one interface is brought up -> PPS/PEROUT needs to be enabled

OK.

> 
>>>       icss_iep_disable(iep);
>>>         return 0;
>>

-- 
cheers,
-roger

