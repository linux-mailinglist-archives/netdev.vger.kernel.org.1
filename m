Return-Path: <netdev+bounces-102841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C908790503D
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 12:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5341F1F224A1
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 10:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFC8145FE9;
	Wed, 12 Jun 2024 10:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="l16fhzwY"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075E4110A;
	Wed, 12 Jun 2024 10:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718187432; cv=none; b=YB4dBNi1FziEIuLmhDPxKEwKmX7wuxODLv8omWfA5P9/+EqRbcvIQm91AwsVe4eSzhgUxE5XSyj0hyhGcy7rlSDHoQmq4yBkhLZ60WmdRiog93/ShzrIZUtj0h795/4M4nHyVZCAtV40nKb1JBcBLIQCFgzzLpKQMQORzyfXWtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718187432; c=relaxed/simple;
	bh=Rrf/0OEe91PyXmXpZmQBXc76141j12WNVET1gzJ+GEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=me0tUhRMjczKNH+VS3zp7vaK2ppctWCdfHlrezlrZInXsSa5In9DVVLNrAxV/jXxV9f6u5mwDwzkBEpSnaw8iiHYuWDPffdARsXn1VDt5k9Zw5mtCxl96zoNyQCamk8eLrNBywQpfvQZ/RzJX7E5cqQOnx4qwg3Cj+pEBcOYZgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=l16fhzwY; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45CAFQZ4014801;
	Wed, 12 Jun 2024 05:15:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718187326;
	bh=6PYNTaf4bBC1gHSa8xOkQZDHIzU4NmE0UgHp94stOrU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=l16fhzwYcI6dYNLLGfVvnlmcqmPX1Q5TUP2YvinKpdmOwyiT7WdSGY2VqAsKK7xPG
	 e8B0x9NCKean3l+JQndyH9P8m3+a4NkFyB77ZNnHC0trm0F//xuaHeyWj7DKD9DdNi
	 AVKGispoTnMVwF1jSx7NgkWMZS+umXAl2yUO0EUQ=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45CAFQTn105017
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Jun 2024 05:15:26 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Jun 2024 05:15:26 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Jun 2024 05:15:26 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45CAFJeX032469;
	Wed, 12 Jun 2024 05:15:20 -0500
Message-ID: <69f01921-545a-4ddd-85ee-d1b7fc635df5@ti.com>
Date: Wed, 12 Jun 2024 15:45:18 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 2/2] net: ti: icssg_prueth: add TAPRIO offload
 support
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Jan Kiszka <jan.kiszka@siemens.com>,
        Dan Carpenter
	<dan.carpenter@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>, Simon Horman
	<horms@kernel.org>,
        Diogo Ivo <diogo.ivo@siemens.com>,
        Wolfram Sang
	<wsa+renesas@sang-engineering.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Roger Quadros
	<rogerq@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski
	<kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>,
        Jacob
 Keller <jacob.e.keller@intel.com>,
        Roger Quadros <rogerq@ti.com>
References: <20240531135157.aaxgslyur5br6zkb@skbuf>
 <20240531044512.981587-1-danishanwar@ti.com>
 <20240531044512.981587-1-danishanwar@ti.com>
 <20240531044512.981587-3-danishanwar@ti.com>
 <20240531044512.981587-3-danishanwar@ti.com>
 <20240531135157.aaxgslyur5br6zkb@skbuf>
 <9bcc04a9-645a-4571-a679-ffe67300877a@ti.com>
 <9bcc04a9-645a-4571-a679-ffe67300877a@ti.com>
 <20240603135100.t57lr4u3j6h6zszd@skbuf>
 <d5786231-b79d-46a0-bb4e-020efb805559@ti.com>
 <20240606141759.pzug3gezeuabrxzm@skbuf>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20240606141759.pzug3gezeuabrxzm@skbuf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 06/06/24 7:47 pm, Vladimir Oltean wrote:
> On Thu, Jun 06, 2024 at 04:33:58PM +0530, MD Danish Anwar wrote:
>>>>>> +static void tas_reset(struct prueth_emac *emac)
>>>>>> +{
>>>>>> +	struct tas_config *tas = &emac->qos.tas.config;
>>>>>> +	int i;
>>>>>> +
>>>>>> +	for (i = 0; i < TAS_MAX_NUM_QUEUES; i++)
>>>>>> +		tas->max_sdu_table.max_sdu[i] = 2048;
>>>>>
>>>>> Macro + short comment for the magic number, please.
>>>>>
>>>>
>>>> Sure I will add it. Each elements in this array is a 2 byte value
>>>> showing the maximum length of frame to be allowed through each gate.
>>>
>>> Is the queueMaxSDU[] array active even with the TAS being in the reset
>>> state? Does this configuration have any impact upon the device MTU?
>>> I don't know why 2048 was chosen.
>>
>> I talked to the firmware team. The value of 248 is actually wrong. It
>> should be the device mtu only i.e. PRUETH_MAX_MTU.
> 
> There was another comment about the value of 0, sent separately.
> 

Yes, I have replied to that.

>>> If you're replacing an existing active schedule with a shadow one, the
>>> ICSSG_EMAC_PORT_TAS_ENABLE command isn't needed because the TAS is
>>> already enabled on the port, right? In fact it will be suppressed by
>>> tas_set_state() without even generating an emac_set_port_state() call,
>>> right?
>>>
>>
>> As this point TAS is not enabled. TAS is enabled on the port only when
>> ICSSG_EMAC_PORT_TAS_ENABLE is sent. Which happens at the end of
>> emac_taprio_replace().
> 
> "If you're replacing an existing active schedule" => emac_taprio_replace()
> was already called once, and we're calling it again, with no emac_taprio_destroy()
> in between.
> 
> This is done using the "tc qdisc replace" command. You can keep the
> mqprio parameters the same, just change the schedule parameters.
> The transition from the old to the new schedule is supposed to be
> seamless and at a well-defined time, according to the IEEE definitions.
> 

I talked with the FW team. During "tc qdisc replace" there is no need to
send ICSSG_EMAC_PORT_TAS_ENABLE as it is already enabled. I'll fix it.

>>>> The following three offsets are configured in this function,
>>>> 1. TAS_ADMIN_CYCLE_TIME → admin cycle time
>>>> 2. TAS_CONFIG_CHANGE_CYCLE_COUNT → number of cycles after which the
>>>> admin list is taken as operating list.
>>>> This parameter is calculated based on the base_time, cur_time and
>>>> cycle_time. If the base_time is in past (already passed) the
>>>> TAS_CONFIG_CHANGE_CYCLE_COUNT is set to 1. If the base_time is in
>>>> future, TAS_CONFIG_CHANGE_CYCLE_COUNT is calculated using
>>>> DIV_ROUND_UP_ULL(base_time - cur_time, cycle_time)
>>>> 3. TAS_ADMIN_LIST_LENGTH → Number of window entries in the admin list.
>>>>
>>>> After configuring the above three parameters, the driver gives the
>>>> trigger signal to the firmware using the R30 command interface with
>>>> ICSSG_EMAC_PORT_TAS_TRIGGER command.
>>>>
>>>> The schedule starts based on TAS_CONFIG_CHANGE_CYCLE_COUNT. Those cycles
>>>> are relative to time remaining in the base_time from now i.e. base_time
>>>> - cur_time.
>>>
>>> So you're saying that the firmware executes the schedule switch at
>>>
>>> 	now                  +      TAS_ADMIN_CYCLE_TIME * TAS_CONFIG_CHANGE_CYCLE_COUNT ns
>>> 	~~~
>>> 	time of reception of
>>> 	ICSSG_EMAC_PORT_TAS_TRIGGER
>>> 	R30 command
>>>
>>> ?
>>>
>>
>> I talked to the firmware team on this topic. Seems like this is actually
>> a bug in the firmware design. This *now* is very relative and it will
>> always introduce jitter as you have mentioned.
>>
>> The firmware needs to change to handle the below two cases that you have
>> mentioned.
>>
>> The schedule should start at base-time (given by user). Instead of
>> sending the cycle count from now to base-time to firmware. Driver should
>> send the absolute cycle count corresponding to the base-time. Firmware
>> can then check the curr cycle count and when it matches the count set by
>> driver firmware will start scheduling.
>>
>> change_cycle_count = base-time / cycle-time;
>>
>> This way the irregularity with *now* will be removed. Now even if we run
>> the same command on two different ICSSG devices(whose clocks are synced
>> with PTP), the scheduling will happen at same time.
>>
>> As the change_cycle_count will be same for both of them. Since the
>> clocks are synced the current cycle count (read from
>> TIMESYNC_FW_WC_CYCLECOUNT_OFFSET) will also be same for both the devices
> 
> You could pass the actual requested base-time to the firmware, and let
> the firmware calculate a cycle count or whatever the hardware needs.
> Otherwise, you advance the base-time in the driver into what was the
> future at the time, but by the time the r30 command reaches the
> firmware, the passed number of cycles has already elapsed.
> 

Yes that would work too.

>>> I'm not really interested in how the driver calculates the cycle count,
>>> just in what are the primitives that the firmware ABI wants.
>>>
>>> Does the readb_poll_timeout() call from tas_update_oper_list() actually
>>> wait until this whole time elapses? It is user space input, so it can
>>> keep a task waiting in the kernel, with rtnl_lock() acquired, for a very
>>> long time if the base_time is far away in the future.
>>>
>>
>> readb_poll_timeout() call from tas_update_oper_list() waits for exactly
>> 10 msecs. Driver send the trigger_list_change command and sets
>> config_change register to 1 (details in tas_set_trigger_list_change()).
>> Driver waits for 10 ms for firmware to clear this register. If the
>> register is not cleared, list wasn't changed by firmware. Driver will
>> then return err.
> 
> And the firmware clears this register when? Quickly upon reception of
> the TAS_TRIGGER command, or after the TAS is actually triggered (after
> change_cycle_count cycles)?
> 

tas->config_list->config_change is set to 1 by driver in
tas_set_trigger_list_change() before sending the TAS_TRIGGER command.
tas->config_list->config_change indicates that the driver has filled the
shadow list.

Firmware then receives the TAS_TRIGGER command and clears
`tas->config_list->config_change` as soon as new shadow list is received.

Firmware then goes on to copy the shadow list to active list and once
that is done, firmware clears `tas->config_list->config_pending`
register. After this TAS is actually triggered when change_cycle_count
cycles have passed.

>>> 2. You cannot apply a phase offset between the schedules on two ICSSG
>>> devices in the same network.
>>>
>>> Since there is a PHY-dependent propagation delay on each link, network
>>> engineers typically delay the schedules on switch ports along the path
>>> of a stream.
>>>
>>> Say for example there is a propagation delay of 800 ns on a switch with
>>> base-time 0. On the next switch, you could add the schedule like this:
>>>
>>> tc qdisc replace dev swp0 parent root taprio \
>>> 	num_tc 8 \
>>> 	map 0 1 2 3 4 5 6 7 \
>>> 	queues 1@0 1@1 1@2 1@3 1@4 1@5 1@6 1@7 \
>>> 	base-time 800 \
>>> 	sched-entry S 0x81 100000 \
>>> 	sched-entry S 0x01 900000 \
>>> 	flags 0x2 \
>>> 	max-sdu 0 0 0 0 0 0 0 79
>>>
>>> Same schedule, phase-shifted by 800 ns, so that if the packet goes
>>> through an open gate in the first switch, it will also go through an
>>> open gate through the second.
>>>
>>> According to your own calculations and explanations, the firmware ABI
>>> makes no difference between base-time 0 and base-time 800.
>>>
>>
>> In the new implementation base-time 0 and base-time 800 will make a
>> difference. as the change_cycle_count will be different from both the cases.
>> In case of base-time 0, change_cycle_count will be 1. Implying schedule
>> will start on the very next cycle.
>>
>> In case of base-time 800, change_cycle_count will be 800 / cycle-time.
> 
> In this example, cycle-time is (much) larger than 800 ns, so 800 / cycle-time is 0.
> Simply put, base-time 0 and base-time 800 will still be treated equally,
> if the firmware only starts the schedule upon integer multiples of the
> cycle time. A use case is offsetting schedules by a small value, smaller
> than the cycle time.
> 
> The base-time value of 800 should be advanced by the smallest integer
> multiple of the cycle-time that satisfies the inequality
> new-base-time = (base-time + N * cycle-time) >= now.
> 
> You can see that for the same value of N and cycle-time, new-base-time
> will different when base-time = 0 vs when base-time = 800. Taprio
> expects that difference to be reflected into the schedule.
> 
>>> In this case they are probably both smaller than the current time, so
>>> TAS_CONFIG_CHANGE_CYCLE_COUNT will be set to the same "1" in both cases.
>>>
>>
>> If cycle-time is larger then both 0 and 800 then the change_cycle_count
>> would be 1 in both the cases.
>>
>>> But even assuming a future base-time, it still will make no difference.
>>> The firmware seems to operate only on integer multiples of a cycle-time
>>> (here 1000000).
>>
>> Yes, the firmware works only on multiple of cycle time. If the base-time
>> is not a multiple of cycle time, the scheduling will start on the next
>> cycle count.
>>
>> i.e. change_cycle_count = ceil (base-time / cycle-time)
>>> Summarized, the blocking problems I see are:
>>>
>>> - For issue #2, the driver should not lie to the user space that it
>>>   applied a schedule with a base-time that isn't a precise multiple of
>>>   the cycle-time, because it doesn't do that.
>>>
>>
>> Yes, I acknowledge it's a limitation. Driver can print "requested
>> base-time is not multiple of cycle-time, secheduling will start on the
>> next available cycle from base-time". I agree the driver shouldn't lie
>> about this. Whenever driver encounters a base time which is not multiple
>> of cycle-time. It can still do the scheduling but throw a print so that
>> user is aware of this.
> 
> Is that a firmware or a hardware limitation? You're making it sound as
> if we shouldn't be expecting for it to be lifted.
> 

It is a firmware limitation and I have conveyed this issue to the
firmware team. They are working on fixing this as well. In my earlier
reply I meant to say that if this is not fixed or if it takes very long
to fix this, we can still go ahead with the driver by mentioning this
limitation by a print.

>>> - For issue #1, the bigger problem is that there is always a
>>>   software-induced jitter which makes whatever the user space has
>>>   requested irrelevant.
>>>
>>
>> As a I mentioned earlier, the new implementation will take care of this.
>>
>> I will work with the firmware team to get this fixed. Once that's done I
>> will send a new revision.
>>
>> Thanks for all the feedbacks. Please let me know if some more
>> clarification is needed.
> 
> Ok, so we're waiting for a new firmware release, and a check in the
> driver that the firmware version >= some minimum requirement, else
> -EOPNOTSUPP?

Yes, we are waiting on a new firmware release. The check however might
not be necessary as ICSSG firmware is not yet public. It's not part of
Linux-firmware. We are planning on integrating the ICSSG firmware with
Linux-firmware. However as of now it's not public. Since the firmware is
not public yet and the first public version will most probably be after
this things are fixed and driver support is upstream-ed, I don't think
version check will be needed.

Once the firmware is public and the some change is done in driver that
depends on firmware versions then the check will be necessary.

-- 
Thanks and Regards,
Danish

