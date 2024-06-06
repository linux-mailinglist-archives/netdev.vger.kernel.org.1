Return-Path: <netdev+bounces-101367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A63F8FE4D8
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 13:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5654D1C214A5
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 11:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA32194AE3;
	Thu,  6 Jun 2024 11:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="X2/jq/PV"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6AB14E2C4;
	Thu,  6 Jun 2024 11:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717671886; cv=none; b=Z0biaJ0OmEbeBuVr2BT2BNByjhYsGS1VwpaZU6XPTJKw/6/NFmMQ64GjYZWrwlOaFcgoY+SFyil9MegofO4Vd9WS8zXQFZb+biZm29eUHm51Cz1Y+knmqNFcTS4W7+7uPZhSBToKyx36d9E7SXTkMY1+D1fwJUhcd4p8QPlHWM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717671886; c=relaxed/simple;
	bh=b0gFQ+ZcaE8T903rqwYT5HjMzjueTgVUhMcZGCtC+RM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Z5DOO+PXaQl7GQiyT4ARsoggAnjCpsdysLrHFVZLMKJiNXYfcaw6jbQRUFaAaEdiRsNLKLRlfXorPGoYOzKVM+GTu23S2ADxpxpBcfidt1b6DFxxU4f3pw9FlQHbDxjbn9uJB3Vwpyea6xbAyVThTgh+ZIVzvsyGsWDOvpcSyt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=X2/jq/PV; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 456B46Og100174;
	Thu, 6 Jun 2024 06:04:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717671846;
	bh=20X6I5VDlzPvydZWN+ufD39ZfcX3t7agcBykyGbFZcA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=X2/jq/PV/wz6I8IH7dSClKdOQ/skJn01ghoRGvShsTTV2ub54buEyx2JXCQw+nAa3
	 /8X77JRCI9y0dk/LDbT+sujWi/fa00Vep1Pq9IUhwiQs8cgHBcKSjJcDanNmO3TDfz
	 CLc93IsbTnBI2xl1mqaBkctgjIY8XvEy80qF1i5I=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 456B46XR059783
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 6 Jun 2024 06:04:06 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 6
 Jun 2024 06:04:06 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 6 Jun 2024 06:04:05 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 456B3xBx034871;
	Thu, 6 Jun 2024 06:04:00 -0500
Message-ID: <d5786231-b79d-46a0-bb4e-020efb805559@ti.com>
Date: Thu, 6 Jun 2024 16:33:58 +0530
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
References: <20240531044512.981587-3-danishanwar@ti.com>
 <20240531044512.981587-3-danishanwar@ti.com>
 <20240531135157.aaxgslyur5br6zkb@skbuf>
 <20240531044512.981587-1-danishanwar@ti.com>
 <20240531044512.981587-1-danishanwar@ti.com>
 <20240531044512.981587-3-danishanwar@ti.com>
 <20240531044512.981587-3-danishanwar@ti.com>
 <20240531135157.aaxgslyur5br6zkb@skbuf>
 <9bcc04a9-645a-4571-a679-ffe67300877a@ti.com>
 <9bcc04a9-645a-4571-a679-ffe67300877a@ti.com>
 <20240603135100.t57lr4u3j6h6zszd@skbuf>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20240603135100.t57lr4u3j6h6zszd@skbuf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Vladimir,

On 03/06/24 7:21 pm, Vladimir Oltean wrote:
> Hi Danish,
> 
> On Mon, Jun 03, 2024 at 05:42:06PM +0530, MD Danish Anwar wrote:
>>>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_qos.c b/drivers/net/ethernet/ti/icssg/icssg_qos.c
>>>> new file mode 100644
>>>> index 000000000000..5e93b1b9ca43
>>>> --- /dev/null
>>>> +++ b/drivers/net/ethernet/ti/icssg/icssg_qos.c
>>>> @@ -0,0 +1,288 @@
>>>> +static void tas_update_fw_list_pointers(struct prueth_emac *emac)
>>>> +{
>>>> +	struct tas_config *tas = &emac->qos.tas.config;
>>>> +
>>>> +	if ((readb(tas->active_list)) == TAS_LIST0) {
>>>
>>> Who and when updates tas->active_list from TAS_LIST0 to TAS_LIST1?
>>>
>>
>> ->emac_taprio_replace()
>> 	-> tas_update_oper_list()
>> 		-> tas_set_trigger_list_change()
>>
>> This API send a r30 command to firmware to trigger the list change
>> `emac_set_port_state(emac, ICSSG_EMAC_PORT_TAS_TRIGGER);`
>>
>> This once firmware recives this command, it swaps the active and shadow
>> list.
>>
>> emac_taprio_replace() calls tas_update_oper_list()
>>
>> In tas_update_oper_list() in the beginning active_list is 0 i.e.
>> TAS_LIST0, tas_update_fw_list_pointers() is called which configures the
>> active and shadow list pointers. TAS_LIST0 becomes the active_list and
>> TAS_LIST1 becomes the shadow list.
>>
>> Let's say before this API was called, active_list is TAS_LIST0 (0) and
>> shadow_list is TAS_LIST1.
>>
>> After getting the shadow_list we fill three different arrays,
>> 1. gate_mask_list[]
>> 2. win_end_time_list[]
>> 3. gate_close_time_list[][] - 2D array with size = num_entries * num_queues
>>
>> Driver only updates the shadow_list. Once shadow list is filled, we call
>> tas_set_trigger_list_change() and ask firmware to change the active
>> list. Now the shadow_list that we had filled (TAS_LIST1) will become
>> active list and vice versa. We will again update our pointers
>>
>> This is how list is changed by calling tas_update_fw_list_pointers.
>>
>>>> +	tas_update_fw_list_pointers(emac);
>>>
>>> Calling this twice in the same function? Explanation?
>>>
>>
>> As explained earlier tas_update_fw_list_pointers() is called in the
>> beginning to set the active and shadow_list. After that we fill the
>> shadow list and then send commmand to swap the active and shadow list.
>> As the list are swapped we will call tas_update_fw_list_pointers() to
>> update the list pointers.
> 
> Ok, but if icssg_qos_tas_init() already calls tas_update_fw_list_pointers()
> initially, I don't understand why the first tas_update_oper_list() call
> of tas_update_oper_list() is necessary, if only tas_set_trigger_list_change()
> swaps the active with the shadow list. There was no unaccounted list
> swap prior to the tas_update_oper_list() call, was there?
> 

You are right. This additional call to tas_update_fw_list_pointers() is
not needed. I will drop the call in the begining. The call should only
be made after the lists have been swapped.

>>>> +static void tas_reset(struct prueth_emac *emac)
>>>> +{
>>>> +	struct tas_config *tas = &emac->qos.tas.config;
>>>> +	int i;
>>>> +
>>>> +	for (i = 0; i < TAS_MAX_NUM_QUEUES; i++)
>>>> +		tas->max_sdu_table.max_sdu[i] = 2048;
>>>
>>> Macro + short comment for the magic number, please.
>>>
>>
>> Sure I will add it. Each elements in this array is a 2 byte value
>> showing the maximum length of frame to be allowed through each gate.
> 
> Is the queueMaxSDU[] array active even with the TAS being in the reset
> state? Does this configuration have any impact upon the device MTU?
> I don't know why 2048 was chosen.

I talked to the firmware team. The value of 248 is actually wrong. It
should be the device mtu only i.e. PRUETH_MAX_MTU.

> 
>>>> +static int tas_set_state(struct prueth_emac *emac, enum tas_state state)
>>>> +{
>>>> +	struct tas_config *tas = &emac->qos.tas.config;
>>>> +	int ret;
>>>> +
>>>> +	if (tas->state == state)
>>>> +		return 0;
>>>> +
>>>> +	switch (state) {
>>>> +	case TAS_STATE_RESET:
>>>> +		tas_reset(emac);
>>>> +		ret = emac_set_port_state(emac, ICSSG_EMAC_PORT_TAS_RESET);
>>>> +		tas->state = TAS_STATE_RESET;
>>>> +		break;
>>>> +	case TAS_STATE_ENABLE:
>>>> +		ret = emac_set_port_state(emac, ICSSG_EMAC_PORT_TAS_ENABLE);
>>>> +		tas->state = TAS_STATE_ENABLE;
>>>> +		break;
>>>> +	case TAS_STATE_DISABLE:
>>>> +		ret = emac_set_port_state(emac, ICSSG_EMAC_PORT_TAS_DISABLE);
>>>> +		tas->state = TAS_STATE_DISABLE;
>>>
>>> This can be expressed as just "tas->state = state" outside the switch statement.
>>> But probably shouldn't be, if "ret != 0".
>>
>> Yes we shouldn't do that as we are sending the r30 command to firmware
>> in each case.
> 
> I was saying that if there's a firmware error, we probably shouldn't
> update our tas->state as if there wasn't.
> 
> And that the tas->state = state assignment is common across all switch
> cases, so it's simpler to move it out.
> 

Understood, I will move this out of switch block and only set it if
emac_set_port_state() was a success.

>>>
>>>> +		break;
>>>> +	default:
>>>> +		netdev_err(emac->ndev, "%s: unsupported state\n", __func__);
>>>
>>> There are two levels of logging for this error, and this particular one
>>> isn't useful. We can infer it went through the "default" case when the
>>> printk below returned -EINVAL, because if that -EINVAL came from
>>> emac_set_port_state(), that would have printed, in turn, "invalid port command".
>>>
>>
>> But, the enum tas_state and enum icssg_port_state_cmd are not 1-1 mapped.
> 
> Correct, but you aren't printing the tas_state anyway, and there's no
> code path possible with a tas_state outside the well-defined values.
> 
>> emac_set_port_state() will only return -EINVAL when `cmd >=
>> ICSSG_EMAC_PORT_MAX_COMMANDS` which is 19. But a tas_state value of 3 is
>> also invalid as we only support value of 0,1 and 2 so I think this print
>> shoudl be okay
>>
>> enum tas_state {
>> 	TAS_STATE_DISABLE = 0,
>> 	TAS_STATE_ENABLE = 1,
>> 	TAS_STATE_RESET = 2,
>> };
>>
>>> I don't think that a "default" case is needed here, as long as all enum
>>> values are handled, and the input is sanitized everywhere (which it is).
>>>
>>
>> I think the default case should remain. Without default case the
>> function will return 0 even for invalid sates. By default ret = 0, in
>> the tas_state passed to API is not valid, none of the case will be
>> called, ret will remaing zero. No error will be printed and the function
>> will return 0. Keeping default case makes sure that the wrong state was
>> requested.
>>
> 
> Dead code is what it is. If a new enum tas_state value is added and it's
> not handled there, the _compiler_ will warn, rather than the Linux runtime.
> So it's actually easier for the developer to catch it, rather than the user.
> You don't need to protect against your own shadow.


Sure, I will drop the default case.

> 
>>>> +static int tas_set_trigger_list_change(struct prueth_emac *emac)
>>>> +{
>>>> +	struct tc_taprio_qopt_offload *admin_list = emac->qos.tas.taprio_admin;
>>>> +	struct tas_config *tas = &emac->qos.tas.config;
>>>> +	struct ptp_system_timestamp sts;
>>>> +	u32 change_cycle_count;
>>>> +	u32 cycle_time;
>>>> +	u64 base_time;
>>>> +	u64 cur_time;
>>>> +
>>>> +	/* IEP clock has a hardware errata due to which it wraps around exactly
>>>> +	 * once every taprio cycle. To compensate for that, adjust cycle time
>>>> +	 * by the wrap around time which is stored in emac->iep->def_inc
>>>> +	 */
>>>> +	cycle_time = admin_list->cycle_time - emac->iep->def_inc;
>>>> +	base_time = admin_list->base_time;
>>>> +	cur_time = prueth_iep_gettime(emac, &sts);
>>>> +
>>>> +	if (base_time > cur_time)
>>>> +		change_cycle_count = DIV_ROUND_UP_ULL(base_time - cur_time, cycle_time);
>>>> +	else
>>>> +		change_cycle_count = 1;
>>>> +
>>>> +	writel(cycle_time, emac->dram.va + TAS_ADMIN_CYCLE_TIME);
>>>> +	writel(change_cycle_count, emac->dram.va + TAS_CONFIG_CHANGE_CYCLE_COUNT);
>>>> +	writeb(admin_list->num_entries, emac->dram.va + TAS_ADMIN_LIST_LENGTH);
>>>> +
>>>> +	/* config_change cleared by f/w to ack reception of new shadow list */
>>>> +	writeb(1, &tas->config_list->config_change);
>>>> +	/* config_pending cleared by f/w when new shadow list is copied to active list */
>>>> +	writeb(1, &tas->config_list->config_pending);
>>>> +
>>>> +	return emac_set_port_state(emac, ICSSG_EMAC_PORT_TAS_TRIGGER);
>>>
>>> The call path here is:
>>>
>>> emac_taprio_replace()
>>> -> tas_update_oper_list()
>>>    -> tas_set_trigger_list_change()
>>>       -> emac_set_port_state(emac, ICSSG_EMAC_PORT_TAS_TRIGGER);
>>> -> tas_set_state(emac, TAS_STATE_ENABLE);
>>>    -> emac_set_port_state(emac, ICSSG_EMAC_PORT_TAS_ENABLE);
>>>
>>> I'm surprised by the calls to emac_set_port_state() in such a quick
>>> succession? Is there any firmware requirement for how much should the
>>> port stay in the TAS_TRIGGER state? Or is it not really a state, despite
>>> it being an argument to a function named emac_set_port_state()?
>>>
>>
>> ICSSG_EMAC_PORT_TAS_TRIGGER is not a state. emac_set_port_state() sends
>> a command to firmware, we call it r30 command. Driver then waits for the
>> response for some time. If a successfull response is recived the
>> function return 0 otherwise error.
>>
>> Here first `emac_set_port_state(emac, ICSSG_EMAC_PORT_TAS_TRIGGER)` is
>> called which will ask firmware to swap the active_list and shadow_list
>> as explained above.
>>
>> After that ICSSG_EMAC_PORT_TAS_ENABLE cmd is sent. Upon recievinig this
>> command firmware will Enable TAS for the particular port. (port is part
>> of emac structure).
>>
>> I can see how that can be confusing given the API name is
>> emac_set_port_state(). Some of the cmds infact triggers a state change
>> eg. ICSSG_EMAC_PORT_DISABLE, ICSSG_EMAC_PORT_BLOCK,
>> ICSSG_EMAC_PORT_FORWARD but some of the commands just triggers some
>> action on the firmware side. Based on the command firmware does some
>> actions.
> 
> If you're replacing an existing active schedule with a shadow one, the
> ICSSG_EMAC_PORT_TAS_ENABLE command isn't needed because the TAS is
> already enabled on the port, right? In fact it will be suppressed by
> tas_set_state() without even generating an emac_set_port_state() call,
> right?
> 

As this point TAS is not enabled. TAS is enabled on the port only when
ICSSG_EMAC_PORT_TAS_ENABLE is sent. Which happens at the end of
emac_taprio_replace().

>>>> +}
>>>
>>> There's something extremely elementary about this function which I still
>>> don't understand.
>>>
>>> When does the schedule actually _start_? Can that be controlled by the
>>> driver with the high (nanosecond) precision necessary in order for the
>>> ICSSG to synchronize with the schedule of other equipment in the LAN?
>>>
>>> You never pass the base time per se to the firmware. Just a number of
>>> cycles from now. I guess that number of cycles decides when the schedule
>>> starts, but what are those cycles relative to?
>>>
>>
>> Once the shadow list is updated, the trigger is set in the firmware and
>> for that API tas_set_trigger_list_change() is called.
>>
>> The following three offsets are configured in this function,
>> 1. TAS_ADMIN_CYCLE_TIME → admin cycle time
>> 2. TAS_CONFIG_CHANGE_CYCLE_COUNT → number of cycles after which the
>> admin list is taken as operating list.
>> This parameter is calculated based on the base_time, cur_time and
>> cycle_time. If the base_time is in past (already passed) the
>> TAS_CONFIG_CHANGE_CYCLE_COUNT is set to 1. If the base_time is in
>> future, TAS_CONFIG_CHANGE_CYCLE_COUNT is calculated using
>> DIV_ROUND_UP_ULL(base_time - cur_time, cycle_time)
>> 3. TAS_ADMIN_LIST_LENGTH → Number of window entries in the admin list.
>>
>> After configuring the above three parameters, the driver gives the
>> trigger signal to the firmware using the R30 command interface with
>> ICSSG_EMAC_PORT_TAS_TRIGGER command.
>>
>> The schedule starts based on TAS_CONFIG_CHANGE_CYCLE_COUNT. Those cycles
>> are relative to time remaining in the base_time from now i.e. base_time
>> - cur_time.
> 
> So you're saying that the firmware executes the schedule switch at
> 
> 	now                  +      TAS_ADMIN_CYCLE_TIME * TAS_CONFIG_CHANGE_CYCLE_COUNT ns
> 	~~~
> 	time of reception of
> 	ICSSG_EMAC_PORT_TAS_TRIGGER
> 	R30 command
> 
> ?
> 

I talked to the firmware team on this topic. Seems like this is actually
a bug in the firmware design. This *now* is very relative and it will
always introduce jitter as you have mentioned.

The firmware needs to change to handle the below two cases that you have
mentioned.

The schedule should start at base-time (given by user). Instead of
sending the cycle count from now to base-time to firmware. Driver should
send the absolute cycle count corresponding to the base-time. Firmware
can then check the curr cycle count and when it matches the count set by
driver firmware will start scheduling.

change_cycle_count = base-time / cycle-time;

This way the irregularity with *now* will be removed. Now even if we run
the same command on two different ICSSG devices(whose clocks are synced
with PTP), the scheduling will happen at same time.

As the change_cycle_count will be same for both of them. Since the
clocks are synced the current cycle count (read from
TIMESYNC_FW_WC_CYCLECOUNT_OFFSET) will also be same for both the devices

> I'm not really interested in how the driver calculates the cycle count,
> just in what are the primitives that the firmware ABI wants.
> 
> Does the readb_poll_timeout() call from tas_update_oper_list() actually
> wait until this whole time elapses? It is user space input, so it can
> keep a task waiting in the kernel, with rtnl_lock() acquired, for a very
> long time if the base_time is far away in the future.
> 

readb_poll_timeout() call from tas_update_oper_list() waits for exactly
10 msecs. Driver send the trigger_list_change command and sets
config_change register to 1 (details in tas_set_trigger_list_change()).
Driver waits for 10 ms for firmware to clear this register. If the
register is not cleared, list wasn't changed by firmware. Driver will
then return err.

> If my understanding is correct, then there are 2 things you cannot do
> (which IMO are very important) with the current firmware ABI:
> 
> 1. You cannot synchronize the schedules on two ICSSG devices to one
> another.
> 
> You are supposed to be able to run the same taprio command on the egress
> port of 2 chained switches in a LAN:
> 
> tc qdisc replace dev swp0 parent root taprio \
> 	num_tc 8 \
> 	map 0 1 2 3 4 5 6 7 \
> 	queues 1@0 1@1 1@2 1@3 1@4 1@5 1@6 1@7 \
> 	base-time 0 \
> 	sched-entry S 0x81 100000 \
> 	sched-entry S 0x01 900000 \
> 	flags 0x2 \
> 	max-sdu 0 0 0 0 0 0 0 79
> 
> and, assuming that the switches are synchronized by PTP, the gate events
> will be synchronized on the 2 switches.
> 
> But if the schedule change formula in the firmware is fundamentally
> dependant on a "now" that depends on when the Linux driver performed the
> TAS_TRIGGER action, the gate events will never be precisely synchronized.

As mentioned above, changing the implemntation in firmware and driver
can fix this. With the suggested new implementation the timing will not
be dependent on when the driver sends TAS_TRIGGER cmd.

> 
> Here, "base-time 0" means that the driver/firmware/hardware should
> advance the schedule start time into the closest moment in PTP time
> which is a multiple of the cycle-time (100000+900000=1000000). So for
> example, if the current PTP time is 1000.123456789, the closest start
> time would be 100.124000000.
> 

That would be handled. When base-time is 0, change_cycle_count would be
1 meaning firmware will start scheduling in the very next cycle.

> 2. You cannot apply a phase offset between the schedules on two ICSSG
> devices in the same network.
> 
> Since there is a PHY-dependent propagation delay on each link, network
> engineers typically delay the schedules on switch ports along the path
> of a stream.
> 
> Say for example there is a propagation delay of 800 ns on a switch with
> base-time 0. On the next switch, you could add the schedule like this:
> 
> tc qdisc replace dev swp0 parent root taprio \
> 	num_tc 8 \
> 	map 0 1 2 3 4 5 6 7 \
> 	queues 1@0 1@1 1@2 1@3 1@4 1@5 1@6 1@7 \
> 	base-time 800 \
> 	sched-entry S 0x81 100000 \
> 	sched-entry S 0x01 900000 \
> 	flags 0x2 \
> 	max-sdu 0 0 0 0 0 0 0 79
> 
> Same schedule, phase-shifted by 800 ns, so that if the packet goes
> through an open gate in the first switch, it will also go through an
> open gate through the second.
> 
> According to your own calculations and explanations, the firmware ABI
> makes no difference between base-time 0 and base-time 800.
> 

In the new implementation base-time 0 and base-time 800 will make a
difference. as the change_cycle_count will be different from both the cases.
In case of base-time 0, change_cycle_count will be 1. Implying schedule
will start on the very next cycle.

In case of base-time 800, change_cycle_count will be 800 / cycle-time.

> In this case they are probably both smaller than the current time, so
> TAS_CONFIG_CHANGE_CYCLE_COUNT will be set to the same "1" in both cases.
> 

If cycle-time is larger then both 0 and 800 then the change_cycle_count
would be 1 in both the cases.

> But even assuming a future base-time, it still will make no difference.
> The firmware seems to operate only on integer multiples of a cycle-time
> (here 1000000).

Yes, the firmware works only on multiple of cycle time. If the base-time
is not a multiple of cycle time, the scheduling will start on the next
cycle count.

i.e. change_cycle_count = ceil (base-time / cycle-time)

> 
> Summarized, the blocking problems I see are:
> 
> - For issue #2, the driver should not lie to the user space that it
>   applied a schedule with a base-time that isn't a precise multiple of
>   the cycle-time, because it doesn't do that.
> 

Yes, I acknowledge it's a limitation. Driver can print "requested
base-time is not multiple of cycle-time, secheduling will start on the
next available cycle from base-time". I agree the driver shouldn't lie
about this. Whenever driver encounters a base time which is not multiple
of cycle-time. It can still do the scheduling but throw a print so that
user is aware of this.

> - For issue #1, the bigger problem is that there is always a
>   software-induced jitter which makes whatever the user space has
>   requested irrelevant.
> 

As a I mentioned earlier, the new implementation will take care of this.

I will work with the firmware team to get this fixed. Once that's done I
will send a new revision.

Thanks for all the feedbacks. Please let me know if some more
clarification is needed.

> This is sufficiently bad that I don't think it's worth spending any more
> time on anything else until it is clear how you can make the firmware
> actually obey the requested base-time.
> 
>>>> +static int emac_taprio_replace(struct net_device *ndev,
>>>> +			       struct tc_taprio_qopt_offload *taprio)
>>>> +{
>>>> +	struct prueth_emac *emac = netdev_priv(ndev);
>>>> +	int ret;
>>>> +
>>>> +	if (taprio->cycle_time_extension) {
>>>> +		NL_SET_ERR_MSG_MOD(taprio->extack, "Cycle time extension not supported");
>>>> +		return -EOPNOTSUPP;
>>>> +	}
>>>> +
>>>> +	if (taprio->cycle_time < TAS_MIN_CYCLE_TIME) {
>>>> +		NL_SET_ERR_MSG_FMT_MOD(taprio->extack, "cycle_time %llu is less than min supported cycle_time %d",
>>>> +				       taprio->cycle_time, TAS_MIN_CYCLE_TIME);
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	if (taprio->num_entries > TAS_MAX_CMD_LISTS) {
>>>> +		NL_SET_ERR_MSG_FMT_MOD(taprio->extack, "num_entries %lu is more than max supported entries %d",
>>>> +				       taprio->num_entries, TAS_MAX_CMD_LISTS);
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	if (emac->qos.tas.taprio_admin)
>>>> +		taprio_offload_free(emac->qos.tas.taprio_admin);
>>>> +
>>>> +	emac->qos.tas.taprio_admin = taprio_offload_get(taprio);
>>>> +	ret = tas_update_oper_list(emac);
>>>
>>> If this fails and there was a previous emac->qos.tas.taprio_admin
>>> schedule present, you just broke it. In particular, the
>>> "if (admin_list->cycle_time > TAS_MAX_CYCLE_TIME)" bounds check really
>>> doesn't belong there; it should have been done much earlier, to avoid a
>>> complete offload breakage for such a silly thing (replacing a working
>>> taprio schedule with a new one that has too large cycle breaks the old
>>> schedule).
>>>
>>
>> Will adding the check "if (admin_list->cycle_time > TAS_MAX_CYCLE_TIME)"
>> in emac_taprio_replace() along with the all the checks be OK?
> 
> Yes, but "it will be ok" needs to be put in proper context (this small
> thing is OK doesn't mean everything is OK).

Understood. I know that the full code is still very far from being OK.

-- 
Thanks and Regards,
Danish

