Return-Path: <netdev+bounces-196038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1818CAD33E9
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 12:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DADAE3A5762
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 10:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADB328CF4D;
	Tue, 10 Jun 2025 10:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UMqgVi30"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C067128CF44;
	Tue, 10 Jun 2025 10:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749552302; cv=none; b=j3hDqeje4jW4ONMTJzRE0n52JQtH9Wh+PMvK1sWhbgxIWXWLg0Ld/vc476C2QZxrlrWzo7JLl7kJRqE1birnJpucGB/6JS5MCrmWRGgSW1pEs4HeXYik2Wck8+rKTBkAQ1utnoQOobXjVzK5UZXh4qbFS0db5+7dQ0SbOudd1I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749552302; c=relaxed/simple;
	bh=P5BY5mFiZ77AfufvHXVGQSunk2ah/MKncyuSAjtxeKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=V8hpw//VX00X0uOLSf4SxR/LJ/H3yvQOyrbbbvpRbfE9Uu2/AI6X1TRRUUS4NiXKU8vbsxRe+79dQ2Cw4/kR9aLiwSyWRWYposh39aKVCZn0lGRbdIVl82eCW180kLtpblY0ZBOk3MbZjzVX+PHz+UYmydnNBjyRWrPwqtoUkss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=UMqgVi30; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55AAibDU2256589;
	Tue, 10 Jun 2025 05:44:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1749552277;
	bh=NvBM4V9/9hMq0UaRaS38sgUxrh2iArVTVYSMLCcmD2U=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=UMqgVi30U9rF8+wHFJ42sNslWnaPXiMyHI5NASWmqEMPuFJOacJqYchmsXlFFCfcI
	 5+VF5OiU99zlOl2nCdkWMvneI5osnfHDtANT4Uin5ebu8by+AdfldyATbIlLVkTyW9
	 l4QrqdJXmLHyWw6J2HyusQZFwPQVHLG/+EKyiCdY=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55AAia9c197631
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 10 Jun 2025 05:44:36 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 10
 Jun 2025 05:44:36 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 10 Jun 2025 05:44:35 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55AAiTKp2778032;
	Tue, 10 Jun 2025 05:44:30 -0500
Message-ID: <1cee4cab-c88f-4bd8-bd71-62cd06901b3b@ti.com>
Date: Tue, 10 Jun 2025 16:14:29 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10] net: ti: icssg-prueth: add TAPRIO offload
 support
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Meghana Malladi <m-malladi@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Simon Horman <horms@kernel.org>,
        Guillaume La Roque <glaroque@baylibre.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Roger Quadros <rogerq@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, Eric
 Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>,
        Roger
 Quadros <rogerq@ti.com>
References: <20250502104235.492896-1-danishanwar@ti.com>
 <20250506154631.gvzt75gl2saqdpqj@skbuf>
 <5e928ff0-e75b-4618-b84c-609138598801@ti.com>
 <b05cc264-44f1-42e9-ba38-d2ef587763f5@ti.com>
 <20250610085001.3upkj2wbmoasdcel@skbuf>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20250610085001.3upkj2wbmoasdcel@skbuf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Vladimir,

On 10/06/25 2:20 pm, Vladimir Oltean wrote:
> Hi Danish,
> 
> On Tue, Jun 10, 2025 at 01:13:38PM +0530, MD Danish Anwar wrote:
>>>> Please define the "cycle count" concept (local invention, not IEEE
>>>
>>> cycle count here means number of cycles in the base-time.
>>> If base-time is 1747291156846086012 and cycle-time is 1000000 (1ms) then
>>> the cycle count is 1747291156846 where as extend will be 86012
>>>
>>>> standard). Also, cross-checking with the code, base-time % cycle-time is
>>>> incorrect here, that's not how you calculate it.
>>>
>>> That's actually a typo. It should be
>>>
>>>  - Computes cycle count (base-time / cycle-time) and extend (base-time %
>>>    cycle-time)
>>>
>>>>
>>>> I'm afraid you also need to define the "extend" concept. It is not at
>>>> all clear what it does and how it does it. Does it have any relationship
>>>> with the CycleTimeExtension variables as documented by IEEE 802.1Q annex
>>>> Q.5 definitions?
>>>>
>>> "extend" here is not same as `CycleTimeExtension`. The current firmware
>>> implementation always extends the next-to-last cycle so that it aligns
>>> with the new base-time.
>>>
>>> Eg,
>>> existing schedule, base-time 125ms cycle-time 1ms
>>> New schedule, base-time 239.4ms cycle-time 1ms
>>>
>>> Here the second-to-last cycle starts at 238ms and lasts for 1ms. The
>>> Last cycle starts at 239ms and is only lasting for 0.4ms.
>>>
>>> In this case, the existing schedule will continue till 238ms. After that
>>> the next cycle will last for 1.4 ms instead of 1ms. And the new schedule
>>> will happen at 239.4 ms.
>>>
>>> The extend variable can be anything between 0 to 1ms in this case and
>>> the second last cycle will be extended and the last cycle won't be
>>> executed at all.
> 
> Thanks for the explanation. It sounds like a custom spin on CycleTimeExtension.
> 
> In your example above, "extend", when specified as part of the "new" schedule,
> applies to the "existing" schedule. Whereas CycleTimeExtension extends
> the next-to-last cycle of the same schedule as the one it was applied to.
> 
> Questions based on the above:
> 
> 1. If there is no "existing" schedule, what does the "extend" variable
>    extend? The custom base-time mechanism has to work even for the first
>    taprio schedule. (this is an unanswered pre-existing question)
> 

The firmware has a cycle-time of 1ms even if there is no schedule. Every
1ms, firmware updates a counter. The curr_time is calculated as
CounterValue * 1ms.

Even if there are no schedule, the default cycle-time will remain 1ms.
Let's say the first schedule has a base-time of 20.5ms then the default
cycle will be extended by 0.5 ms and then the schedule will apply. This
is the reason, the extend feature is also impacting get/set_time
calculations.

> 2. Can you give me another (valid, i.e. confirmed working) example of
>    extension, where the cycle-time of the existing schedule is different
>    from the cycle-time of the new one? You calculate the extension of
>    the next-to-last cycle of the existing schedule based on the cycle
>    length of the new schedule. It is not obvious to me why that would be
>    correct.
> 

You are correct. This implementation may fail when the operating
schedule and new schedule have different cycle-times. I checked with the
firmware team and they have a limitation / bug. They only support
cycle-time = 1ms. Any other cycle-time is not supported by the firmware.

Because of this, the current implementation works as AdminBaseTime %
OperCycleTime is same as AdminBaseTime % AdminCycleTime since
OperCycleTime and AdminCycleTime are always going to be same (1ms)



>>>>>   - Writes cycle time, cycle count, and extend values to firmware memory.
>>>>>   - base-time being in past or base-time not being a multiple of
>>>>>     cycle-time is taken care by the firmware. Driver just writes these
>>>>>     variable for firmware and firmware takes care of the scheduling.
>>>>
>>>> "base-time not being a multiple of cycle-time is taken care by the firmware":
>>>> To what extent is this true? You don't actually pass the base-time to
>>>> the firmware, so how would it know that it's not a multiple of cycle-time?
>>>>
>>>
>>> We pass cycle-count and extend. If extend is zero, it implies base-time
>>> is multiple of cycle-time. This way firmware knows whether base-time is
>>> multiple of cycle-time or not.
>>>
>>>>>   - If base-time is not a multiple of cycle-time, the value of extend
>>>>>     (base-time % cycle-time) is used by the firmware to extend the last
>>>>>     cycle.
>>>>
>>>> I'm surprised to read this. Why does the firmware expect the base time
>>>> to be a multiple of the cycle time?
>>>>
>>>
>>> Earlier the limitation was that firmware can only start schedules at
>>> multiple of cycle-times. If a base-time is not multiple of cycle-time
>>> then the schedule is started at next nearest multiple of cycle-time from
>>> the base-time. But now we have fix that, and schedule can be started at
>>> any time. No need for base-time to be multiple of cycle-time.
>>>
>>>> Also, I don't understand what the workaround achieves. If the "extend"
>>>> feature is similar to CycleTimeExtension, then it applies at the _end_
>>>> of the cycle. I.o.w. if you never change the cycle, it never applies.
>>>> How does that help address a problem which exists since the very first
>>>> cycle of the schedule (that it may be shifted relative to integer
>>>> multiples of the cycle time)?
>>>>
>>>> And even assuming that a schedule change will take place - what's the
>>>> math that would suggest the "extend" feature does anything at all to
>>>> address the request to apply a phase-shifted schedule? The last cycle of
>>>> the oper schedule passes, the admin schedule becomes the new oper, and
>>>> then what? It still runs phase-aligned with its own cycle-time, but
>>>> misaligned with the user-provided base time, no?
>>>>
>>>> The expectation is for all cycles to be shifted relative to N *
>>>> base-time, not just the first or last one. It doesn't "sound" like you
>>>> can achieve that using CycleTimeExtension (assuming that's what this
>>>
>>> Yes I understand that. All the cycles will be shifted not just the first
>>> or the last one. Let me explain with example.
>>>
>>> Let's assume the existing schedule is as below,
>>> base-time 500ms cycle-time 1ms
>>>
>>> The schedule will start at 500ms and keep going on. The cycles will
>>> start at 500ms, 501ms, 502ms ...
>>>
>>> Now let's say new requested schedule is having base-time as 1000.821 ms
>>> and cycle-time as 1ms.
>>>
>>> In this case the earlier schedule's second-to-last cycle will start at
>>> 999ms and end at 1000.821ms. The cycle gets extended by 0.821ms
>>>
>>> It will look like this, 500ms, 501ms, 502ms ... 997ms, 998ms, 999ms,
>>> 1000.821ms.
>>>
>>> Now our new schedule will start at 1000.821ms and continue with 1ms
>>> cycle-time.
>>>
>>> The cycles will go on as 1000.821ms, 1001.821ms, 1002.821ms ......
>>>
>>> Now in future some other schedule comes up with base-time as 1525.486ms
>>> then again the second last cycle of current schedule will extend.
>>>
>>> So the cycles will be like 1000.821ms, 1001.821ms, 1002.821ms ...
>>> 1521.821ms, 1522.821ms, 1523.821ms, 1525.486ms. Here the second-to-last
>>> cycle will last for 1.665ms (extended by 0.665ms) where as all other
>>> cycles will be 1ms as requested by user.
>>>
>>> Here all cycles are aligned with base-time (shifter by N*base-time).
>>> Only the last cycle is extended depending upon the base-time of new
>>> schedule.
>>>
>>>> is), so better refuse those schedules which don't have the base-time you
>>>> need.
>>>>
>>>
>>> That's what our first approach was. If it's okay with you I can drop all
>>> these changes and add below check in driver
>>>
>>> if (taprio->base_time % taprio->cycle_time) {
>>> 	NL_SET_ERR_MSG_MOD(taprio->extack, "Base-time should be multiple of
>>> cycle-time");
>>> 	return -EOPNOTSUPP;
>>> }
> 
> I don't want to make a definitive statement on this just yet, I don't
> fully understand what was implemented in the firmware and what was the
> thinking.
> 

The firmware always expects cycle-time of 1ms and base-time to multiple
of cycle-time i.e. base-time to be multiple of 1ms.

This way all the schedules will be aligned and that's what current
implementation is.

To add support for base-time that are not multiple of cycle-time we
added "extend". However that will also only work as long as cycle-time
is 1ms. cycle-time other than 1ms is not supported by firmware as of
now. This is something we discovered recently.

We have a check for TAS_MIN_CYCLE_TIME and TAS_MAX_CYCLE_TIME and they
are defined as,

/* Minimum cycle time supported by implementation (in ns) */
#define TAS_MIN_CYCLE_TIME  (1000000)

/* Minimum cycle time supported by implementation (in ns) */
#define TAS_MAX_CYCLE_TIME  (4000000000)

But it is wrong. As per current firmware implementation,
	TAS_MIN_CYCLE_TIME = TAS_MAX_CYCLE_TIME = 1ms


The ideal use case will be to support,
1. Different cycle times
2. Different base times which may or may not be multiple of cycle-times.

With the current implementation, we are able to support #2 however #1 is
still a limitation. Once support for #1 is added, the implementation
will need to be changed.

>>>>>   - Sets `config_change` and `config_pending` flags to notify firmware of
>>>>>     the new shadow list and its readiness for activation.
>>>>>   - Sends the `ICSSG_EMAC_PORT_TAS_TRIGGER` r30 command to ask firmware to
>>>>>     swap active and shadow lists.
>>>>> - Waits for the firmware to clear the `config_change` flag before
>>>>>   completing the update and returning successfully.
>>>>>
>>>>> This implementation ensures seamless TAS functionality by offloading
>>>>> scheduling complexities to the firmware.
>>>>>
>>>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>>>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>>>>> Reviewed-by: Simon Horman <horms@kernel.org>
>>>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>>>> ---
>>>>> Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
>>>>> v9 - v10:
>>>>> There has been significant changes since v9. I have tried to address all
>>>>> the comments given by Vladimir Oltean <vladimir.oltean@nxp.com> on v9
>>>>> *) Made the driver depend on NET_SCH_TAPRIO || NET_SCH_TAPRIO=n for TAS
>>>>> *) Used MACRO for max sdu size instead of magic number
>>>>> *) Kept `tas->state = state` outside of the switch case in `tas_set_state`
>>>>> *) Implemented TC_QUERY_CAPS case in `icssg_qos_ndo_setup_tc`
>>>>> *) Calling `tas_update_fw_list_pointers` only once in
>>>>>    `tas_update_oper_list` as the second call as unnecessary.
>>>>> *) Moved the check for TAS_MAX_CYCLE_TIME to beginning of
>>>>>    `emac_taprio_replace`
>>>>> *) Added `__packed` to structures in `icssg_qos.h`
>>>>> *) Modified implementation of `tas_set_trigger_list_change` to handle
>>>>>    cases where base-time isn't a multiple of cycle-time. For this a new
>>>>>    variable extend has to be calculated as base-time % cycle-time. This
>>>>>    variable is used by firmware to extend the last cycle.
>>>>> *) The API prueth_iep_gettime() and prueth_iep_settime() also needs to be
>>>>>    adjusted according to the cycle time extension. These changes are also
>>>>>    taken care in this patch.
>>>>
>>>> Why? Given the explanation of CycleTimeExtension above, it makes no
>>>> sense to me why you would alter the gettime() and settime() values.
>>>>
>>>
>>> The Firmware has two counters
>>>
>>> counter0 counts the number of miliseconds in current time
>>> counter1 counts the number of nanoseconds in the current ms.
>>>
>>> Let's say the current time is 1747305807237749032 ns.
>>> counter0 will read 1747305807237 counter1 will read 749032.
>>>
>>> The current time = counter0* 1ms + counter1
>>>
>>> For taprio scheduling also counter0 is used.
> 
> "Used" in the sense that taprio needs to know the current time, correct?
> But by that logic, taprio equally uses counter0 and counter1, no? For
> example, for a cycle-time of 1.23 ms.
> 

Counter0 is updated after every cycle. Since the last cycle below is
1.821 ms, counter0 will be incremented by 1 after 1.821 ms and 0.821ms
will not be written to couter1. This is compensated by the extend
variable in get/set_time APIs.

>>> Now let's say below are the cycles of a schedule
>>>
>>> cycles   = 500ms 501ms 502ms ... 997ms, 998ms, 999ms, 1000.821ms
>>> counter0 = 500   501   502   ... 997    998    999    1000
>>> curr_time= 500*1, 501*1, 502*2...997*1, 998*1, 999*1, 1000*1
>>>
>>> Here you see after the last cycle the time is 1000.821 however our above
>>> formula will give us 1000 as the time since last cycle was extended.
> 
> Wait a second. You compensate the time in prueth_iep_gettime(), which is
> called, among other places, from icss_iep_ptp_gettimeex() (aka struct
> ptp_clock_info :: gettimex64()).
> 
> I don't know about the other call paths, but ptp_clock_info :: gettimex64()
> doesn't answer the question "what was the last time that a taprio cycle
> ended at?" but rather "what time is it according this clock, now?"
> 
> I still fail to see why the taprio cycle extension would affect the
> current time. Or does TIMESYNC_CYCLE_EXTN_TIME extend the length of the
> millisecond?
> 

As I explained earlier, firmware only has one counter that it increases
post every cycle. By default that is 1ms. If a cycle is extended to
1.5ms, the counter still only increases by 1 and the 0.5 ms doesn't get
written to counter1. This is handled by TIMESYNC_CYCLE_EXTN_TIME.

>>> To compensate this, whatever extension firmware applies need to be added
>>> during current time calculation. Below is the code for that.
>>>
>>>       ts += readl(prueth->shram.va + TIMESYNC_CYCLE_EXTN_TIME);
>>>
>>> Now the current time becomes,
>>> 	counter0* 1ms + counter1 + EXTEND
>>>
>>> This is why change to set/get_time() APIs are needed. This will not be
>>> needed if we drop this extends implementation.
> 
> What if the cycle that has to be extended has not arrived yet (is in the
> future)? Why is the current time compensated in that case?
> 

I don't think it will compensate for those. It will only compensate for
the cycles that have already been extended not for those that are yet to
be extended.

Firmware writes what ever extensions it has done till now at
TIMESYNC_CYCLE_EXTN_TIME. During get time we read that and add it to
current time.

>>> Let me know if above explanation makes sense and if I should continue
>>> with this approach or drop the extend feature at all and just refuse the
>>> schedules?
>>>
>>
>> I am not sure if you got the change to review my replies to your initial
>> comments. Let me know if I should continue with this approach or just
>> refuse the schedules that don't have the base time that we need.
>>
>>> Thanks for the feedback.
>>>
>>
>>
>> -- 
>> Thanks and Regards,
>> Danish
> 
> As you can see, I still have trouble understanding the concepts proposed
> by the firmware.

I understand that. I hope this makes it a bit more clear. Let me know
what needs to be done now.

-- 
Thanks and Regards,
Danish

