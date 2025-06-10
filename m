Return-Path: <netdev+bounces-195968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F37AD2F13
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 09:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56905188678E
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 07:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A4927FD50;
	Tue, 10 Jun 2025 07:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lOIHRSDg"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC4227A93A;
	Tue, 10 Jun 2025 07:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749541451; cv=none; b=WXlj6OHwbDGZQ0oq6XQoToNvCUwDTt2qbnFQeVuFux7vXX+AmkvXR7ms91ZhH2GDEf8BjXS9uFzrw44fMbUYo1YIFrIkrvfO5cgsZi0GJvYZfRQOLz3kudRw7WZyaQiQkKl8n7/dL7nwyVT/BXafYQpubGI1MY0i+kPhL9OYQns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749541451; c=relaxed/simple;
	bh=GPs4VwI2U5i8OoCpd+/wSuyPS02mqcIUAES+8JvevRQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=EhEiGSid7LjvyIlxfsMJtswL8fEgICQMiUKY1PuLUm8d5cGZwnQUmjjyab2bdFyDv2f4K6aSStUf6334HonUs4cqgXDiwm2+x5uWv+T3Nd3NXSktyz05uuqd/JLFIYTSAwNfax7BJHuA0fDSfm8863jP9qhm3lHa7XgOsQ1c2AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lOIHRSDg; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55A7hk4Y2222666;
	Tue, 10 Jun 2025 02:43:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1749541426;
	bh=/PBz8UPegQOn0D3yRInXOsNjObgy56E8YRqME4+wtDk=;
	h=Date:Subject:From:To:CC:References:In-Reply-To;
	b=lOIHRSDgxhpOUqtBAZ0USZStUQKX+SfLIvtsb7s12396AutRTpbxYXW1rixIu34d9
	 O357Cxikurhh9Fuap+iTSFbMyEokilGzgiLgAQblNm9OiIVK4XIBoF2WHM7a4F+OoY
	 lqGQg1EHXk0cz8PnpXNa+wSDMV7ph8nJMhp9gQtk=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55A7hjnU093402
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 10 Jun 2025 02:43:46 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 10
 Jun 2025 02:43:45 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 10 Jun 2025 02:43:45 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55A7hdsS2713905;
	Tue, 10 Jun 2025 02:43:39 -0500
Message-ID: <b05cc264-44f1-42e9-ba38-d2ef587763f5@ti.com>
Date: Tue, 10 Jun 2025 13:13:38 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10] net: ti: icssg-prueth: add TAPRIO offload
 support
From: MD Danish Anwar <danishanwar@ti.com>
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
Content-Language: en-US
In-Reply-To: <5e928ff0-e75b-4618-b84c-609138598801@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Vladimir,

On 15/05/25 4:24 pm, MD Danish Anwar wrote:
> Hi Vladimir,
> 
> On 06/05/25 9:16 pm, Vladimir Oltean wrote:
>> It has been a long time since the last posting, everything has been
>> swapped out from my memory. Sorry if some comments are repeated.
>>
> 
> Yes. It has been almost a year since my last revision.
> 
>> On Fri, May 02, 2025 at 04:12:35PM +0530, MD Danish Anwar wrote:
>>> From: Roger Quadros <rogerq@ti.com>
>>>
>>> The Time-Aware Shaper (TAS) is a key feature of the Enhanced Scheduled
>>> Traffic (EST) mechanism defined in IEEE 802.1Q-2018. This patch adds TAS
>>> support for the ICSSG driver by interacting with the ICSSG firmware to
>>> manage gate control lists, cycle times, and other TAS parameters.
>>>
>>> The firmware maintains active and shadow lists. The driver updates the
>>> operating list using API `tas_update_oper_list()` which,
>>> - Updates firmware list pointers via `tas_update_fw_list_pointers`.
>>> - Writes gate masks, window end times, and clears unused entries in the
>>>   shadow list.
>>> - Updates gate close times and Max SDU values for each queue.
>>> - Triggers list changes using `tas_set_trigger_list_change`, which
>>>   - Computes cycle count (base-time % cycle-time) and extend (base-time %
>>>     cycle-time)
>>
>> Please define the "cycle count" concept (local invention, not IEEE
> 
> cycle count here means number of cycles in the base-time.
> If base-time is 1747291156846086012 and cycle-time is 1000000 (1ms) then
> the cycle count is 1747291156846 where as extend will be 86012
> 
>> standard). Also, cross-checking with the code, base-time % cycle-time is
>> incorrect here, that's not how you calculate it.
> 
> That's actually a typo. It should be
> 
>  - Computes cycle count (base-time / cycle-time) and extend (base-time %
>    cycle-time)
> 
>>
>> I'm afraid you also need to define the "extend" concept. It is not at
>> all clear what it does and how it does it. Does it have any relationship
>> with the CycleTimeExtension variables as documented by IEEE 802.1Q annex
>> Q.5 definitions?
>>
>> A very compressed summary of the standard variable is this:
>> the CycleTimeExtension applies when:
>> - an Open schedule exists
>> - an Admin schedule is pending
>> - the AdminBaseTime is not an integer multiple of OperBaseTime + (N *
>>   OperCycleTime) - i.o.w. the admin schedule does not "line up" with the
>>   end of the oper schedule
>>
>> The misalignment of the oper vs admin schedules might cause the very
>> last oper cycle to be truncated to an undesirably short value. The
>> OperCycleTimeExtension variable exists to prevent this, as such:
>>
>> - If the length of the last oper cycle is < OperCycleTimeExtension,
>>   then this cycle does not execute at all. The gate states from the end
>>   of the next-to-last oper cycle remain in place (that cycle is extended)
>>   until the activation of the admin schedule at AdminBaseTime.
>>
>> - If the length of the last oper cycle is >= OperCycleTimeExtension,
>>   this last cycle is left to execute until AdminBaseTime, and is
>>   potentially truncated during the switchover event (unless it perfectly
>>   lines up). Extension of the next-to-last oper cycle does not take
>>   place.
>>
>> Is this the same functionality as the "extend" feature of the PRU
>> firmware - should I be reading the code and the commit message in this
>> key, in order to understand what it achieves?
> 
> 
> "extend" here is not same as `CycleTimeExtension`. The current firmware
> implementation always extends the next-to-last cycle so that it aligns
> with the new base-time.
> 
> Eg,
> existing schedule, base-time 125ms cycle-time 1ms
> New schedule, base-time 239.4ms cycle-time 1ms
> 
> Here the second-to-last cycle starts at 238ms and lasts for 1ms. The
> Last cycle starts at 239ms and is only lasting for 0.4ms.
> 
> In this case, the existing schedule will continue till 238ms. After that
> the next cycle will last for 1.4 ms instead of 1ms. And the new schedule
> will happen at 239.4 ms.
> 
> The extend variable can be anything between 0 to 1ms in this case and
> the second last cycle will be extended and the last cycle won't be
> executed at all.
> 
>>
>>>   - Writes cycle time, cycle count, and extend values to firmware memory.
>>>   - base-time being in past or base-time not being a multiple of
>>>     cycle-time is taken care by the firmware. Driver just writes these
>>>     variable for firmware and firmware takes care of the scheduling.
>>
>> "base-time not being a multiple of cycle-time is taken care by the firmware":
>> To what extent is this true? You don't actually pass the base-time to
>> the firmware, so how would it know that it's not a multiple of cycle-time?
>>
> 
> We pass cycle-count and extend. If extend is zero, it implies base-time
> is multiple of cycle-time. This way firmware knows whether base-time is
> multiple of cycle-time or not.
> 
>>>   - If base-time is not a multiple of cycle-time, the value of extend
>>>     (base-time % cycle-time) is used by the firmware to extend the last
>>>     cycle.
>>
>> I'm surprised to read this. Why does the firmware expect the base time
>> to be a multiple of the cycle time?
>>
> 
> Earlier the limitation was that firmware can only start schedules at
> multiple of cycle-times. If a base-time is not multiple of cycle-time
> then the schedule is started at next nearest multiple of cycle-time from
> the base-time. But now we have fix that, and schedule can be started at
> any time. No need for base-time to be multiple of cycle-time.
> 
>> Also, I don't understand what the workaround achieves. If the "extend"
>> feature is similar to CycleTimeExtension, then it applies at the _end_
>> of the cycle. I.o.w. if you never change the cycle, it never applies.
>> How does that help address a problem which exists since the very first
>> cycle of the schedule (that it may be shifted relative to integer
>> multiples of the cycle time)?
>>
>> And even assuming that a schedule change will take place - what's the
>> math that would suggest the "extend" feature does anything at all to
>> address the request to apply a phase-shifted schedule? The last cycle of
>> the oper schedule passes, the admin schedule becomes the new oper, and
>> then what? It still runs phase-aligned with its own cycle-time, but
>> misaligned with the user-provided base time, no?
>>
>> The expectation is for all cycles to be shifted relative to N *
>> base-time, not just the first or last one. It doesn't "sound" like you
>> can achieve that using CycleTimeExtension (assuming that's what this
> 
> Yes I understand that. All the cycles will be shifted not just the first
> or the last one. Let me explain with example.
> 
> Let's assume the existing schedule is as below,
> base-time 500ms cycle-time 1ms
> 
> The schedule will start at 500ms and keep going on. The cycles will
> start at 500ms, 501ms, 502ms ...
> 
> Now let's say new requested schedule is having base-time as 1000.821 ms
> and cycle-time as 1ms.
> 
> In this case the earlier schedule's second-to-last cycle will start at
> 999ms and end at 1000.821ms. The cycle gets extended by 0.821ms
> 
> It will look like this, 500ms, 501ms, 502ms ... 997ms, 998ms, 999ms,
> 1000.821ms.
> 
> Now our new schedule will start at 1000.821ms and continue with 1ms
> cycle-time.
> 
> The cycles will go on as 1000.821ms, 1001.821ms, 1002.821ms ......
> 
> Now in future some other schedule comes up with base-time as 1525.486ms
> then again the second last cycle of current schedule will extend.
> 
> So the cycles will be like 1000.821ms, 1001.821ms, 1002.821ms ...
> 1521.821ms, 1522.821ms, 1523.821ms, 1525.486ms. Here the second-to-last
> cycle will last for 1.665ms (extended by 0.665ms) where as all other
> cycles will be 1ms as requested by user.
> 
> Here all cycles are aligned with base-time (shifter by N*base-time).
> Only the last cycle is extended depending upon the base-time of new
> schedule.
> 
>> is), so better refuse those schedules which don't have the base-time you
>> need.
>>
> 
> That's what our first approach was. If it's okay with you I can drop all
> these changes and add below check in driver
> 
> if (taprio->base_time % taprio->cycle_time) {
> 	NL_SET_ERR_MSG_MOD(taprio->extack, "Base-time should be multiple of
> cycle-time");
> 	return -EOPNOTSUPP;
> }
> 
>>>   - Sets `config_change` and `config_pending` flags to notify firmware of
>>>     the new shadow list and its readiness for activation.
>>>   - Sends the `ICSSG_EMAC_PORT_TAS_TRIGGER` r30 command to ask firmware to
>>>     swap active and shadow lists.
>>> - Waits for the firmware to clear the `config_change` flag before
>>>   completing the update and returning successfully.
>>>
>>> This implementation ensures seamless TAS functionality by offloading
>>> scheduling complexities to the firmware.
>>>
>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>>> Reviewed-by: Simon Horman <horms@kernel.org>
>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>> ---
>>> Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
>>> v9 - v10:
>>> There has been significant changes since v9. I have tried to address all
>>> the comments given by Vladimir Oltean <vladimir.oltean@nxp.com> on v9
>>> *) Made the driver depend on NET_SCH_TAPRIO || NET_SCH_TAPRIO=n for TAS
>>> *) Used MACRO for max sdu size instead of magic number
>>> *) Kept `tas->state = state` outside of the switch case in `tas_set_state`
>>> *) Implemented TC_QUERY_CAPS case in `icssg_qos_ndo_setup_tc`
>>> *) Calling `tas_update_fw_list_pointers` only once in
>>>    `tas_update_oper_list` as the second call as unnecessary.
>>> *) Moved the check for TAS_MAX_CYCLE_TIME to beginning of
>>>    `emac_taprio_replace`
>>> *) Added `__packed` to structures in `icssg_qos.h`
>>> *) Modified implementation of `tas_set_trigger_list_change` to handle
>>>    cases where base-time isn't a multiple of cycle-time. For this a new
>>>    variable extend has to be calculated as base-time % cycle-time. This
>>>    variable is used by firmware to extend the last cycle.
>>> *) The API prueth_iep_gettime() and prueth_iep_settime() also needs to be
>>>    adjusted according to the cycle time extension. These changes are also
>>>    taken care in this patch.
>>
>> Why? Given the explanation of CycleTimeExtension above, it makes no
>> sense to me why you would alter the gettime() and settime() values.
>>
> 
> The Firmware has two counters
> 
> counter0 counts the number of miliseconds in current time
> counter1 counts the number of nanoseconds in the current ms.
> 
> Let's say the current time is 1747305807237749032 ns.
> counter0 will read 1747305807237 counter1 will read 749032.
> 
> The current time = counter0* 1ms + counter1
> 
> For taprio scheduling also counter0 is used. Now let's say below is are
> the cycles of a schedule
> 
> cycles   = 500ms 501ms 502ms ... 997ms, 998ms, 999ms, 1000.821ms
> counter0 = 500   501   502   ... 997    998    999    1000
> curr_time= 500*1, 501*1, 502*2...997*1, 998*1, 999*1, 1000*1
> 
> Here you see after the last cycle the time is 1000.821 however our above
> formula will give us 1000 as the time since last cycle was extended.
> 
> To compensate this, whatever extension firmware applies need to be added
> during current time calculation. Below is the code for that.
> 
>       ts += readl(prueth->shram.va + TIMESYNC_CYCLE_EXTN_TIME);
> 
> Now the current time becomes,
> 	counter0* 1ms + counter1 + EXTEND
> 
> This is why change to set/get_time() APIs are needed. This will not be
> needed if we drop this extends implementation.
> 
> Let me know if above explanation makes sense and if I should continue
> with this approach or drop the extend feature at all and just refuse the
> schedules?
> 

I am not sure if you got the change to review my replies to your initial
comments. Let me know if I should continue with this approach or just
refuse the schedules that don't have the base time that we need.

> Thanks for the feedback.
> 


-- 
Thanks and Regards,
Danish

