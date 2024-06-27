Return-Path: <netdev+bounces-107170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CCB91A28F
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 11:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD419286927
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 09:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729ED535BF;
	Thu, 27 Jun 2024 09:23:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE5B1864C
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 09:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719480203; cv=none; b=ZyH2XUh4ixekU/ditIgJQj0MF/bQRgwlHfHeBU+5uPBCsxKrplus5JRcJTi3d/RfWIIPa5fOyXob1H0QVksEfLgj3HVKnksvgbANKteiO/rvN1pHjGNeZPDTPwA6osNK46rnx/IP1Syrkuycrqk3VhEEh3x7sjsDSZTNyhffmiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719480203; c=relaxed/simple;
	bh=wEdMiPS/GjzdakS53WIhdNDgMaWRQJ5QjUqT4eNArTA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=A101XtEyll4rUabwBtG8tyS9TzD9UQ4cd2IZjZMBvplHPqHWkscOpuq6vtLSxSPjNPAxnmsPDfTJGaRotJMLV1nQf1OYtaAk0SA3Dc06YVj7p8z3vOJevzSQmMvesj20LFKEI4BLEdlvUVIc3EF0bapm0Z4TO3FHaG8ogXmojmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=ovn.org; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ovn.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1303724000C;
	Thu, 27 Jun 2024 09:23:09 +0000 (UTC)
Message-ID: <b42e503b-663d-4d44-86d1-ab93feec4593@ovn.org>
Date: Thu, 27 Jun 2024 11:23:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>,
 netdev@vger.kernel.org, aconole@redhat.com, horms@kernel.org,
 dev@openvswitch.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Pravin B Shelar <pshelar@ovn.org>
Subject: Re: [PATCH net-next v5 05/10] net: openvswitch: add emit_sample
 action
To: Eelco Chaudron <echaudro@redhat.com>
References: <20240625205204.3199050-1-amorenoz@redhat.com>
 <20240625205204.3199050-6-amorenoz@redhat.com>
 <EBFCD83F-D2AA-4D0E-A144-AC0975D22315@redhat.com>
 <CAG=2xmOnDZP3QtBbShoAqptY0uSywhFCGAwUYO+UuXfLkMXE7A@mail.gmail.com>
 <04D55CAD-0BFC-4B62-9827-C3D1A9B7792A@redhat.com>
 <CAG=2xmMThQvNaS30PRCFMjt1atODZQdyZ9jyVuWbeeXThs5UCg@mail.gmail.com>
 <617f9ff3-822e-4467-894c-f247fd9029ec@ovn.org>
 <DC37197E-BABA-425F-9BF2-D70F7B285527@redhat.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <DC37197E-BABA-425F-9BF2-D70F7B285527@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: i.maximets@ovn.org

On 6/27/24 11:14, Eelco Chaudron wrote:
> 
> 
> On 27 Jun 2024, at 10:36, Ilya Maximets wrote:
> 
>> On 6/27/24 09:52, Adrián Moreno wrote:
>>> On Thu, Jun 27, 2024 at 09:06:46AM GMT, Eelco Chaudron wrote:
>>>>
>>>>
>>>> On 26 Jun 2024, at 22:34, Adrián Moreno wrote:
>>>>
>>>>> On Wed, Jun 26, 2024 at 04:28:17PM GMT, Eelco Chaudron wrote:
>>>>>>
>>>>>>
>>>>>> On 25 Jun 2024, at 22:51, Adrian Moreno wrote:
>>>>>>
>>>>>>> Add support for a new action: emit_sample.
>>>>>>>
>>>>>>> This action accepts a u32 group id and a variable-length cookie and uses
>>>>>>> the psample multicast group to make the packet available for
>>>>>>> observability.
>>>>>>>
>>>>>>> The maximum length of the user-defined cookie is set to 16, same as
>>>>>>> tc_cookie, to discourage using cookies that will not be offloadable.
>>>>>>
>>>>>> I’ll add the same comment as I had in the user space part, and that
>>>>>> is that I feel from an OVS perspective this action should be called
>>>>>> emit_local() instead of emit_sample() to make it Datapath independent.
>>>>>> Or quoting the earlier comment:
>>>>>>
>>>>>>
>>>>>> “I’ll start the discussion again on the naming. The name "emit_sample()"
>>>>>> does not seem appropriate. This function's primary role is to copy the
>>>>>> packet and send it to a local collector, which varies depending on the
>>>>>> datapath. For the kernel datapath, this collector is psample, while for
>>>>>> userspace, it will likely be some kind of probe. This action is distinct
>>>>>> from the sample() action by design; it is a standalone action that can
>>>>>> be combined with others.
>>>>>>
>>>>>> Furthermore, the action itself does not involve taking a sample; it
>>>>>> consistently pushes the packet to the local collector. Therefore, I
>>>>>> suggest renaming "emit_sample()" to "emit_local()". This same goes for
>>>>>> all the derivative ATTR naming.”
>>>>>>
>>>>>
>>>>> This is a blurry semantic area.
>>>>> IMO, "sample" is the act of extracting (potentially a piece of)
>>>>> someting, in this case, a packet. It is common to only take some packets
>>>>> as samples, so this action usually comes with some kind of "rate", but
>>>>> even if the rate is 1, it's still sampling in this context.
>>>>>
>>>>> OTOH, OVS kernel design tries to be super-modular and define small
>>>>> combinable actions, so the rate or probability generation is done with
>>>>> another action which is (IMHO unfortunately) named "sample".
>>>>>
>>>>> With that interpretation of the term it would actually make more sense
>>>>> to rename "sample" to something like "random" (of course I'm not
>>>>> suggestion we do it). "sample" without any nested action that actually
>>>>> sends the packet somewhere is not sampling, it's just doing something or
>>>>> not based on a probability. Where as "emit_sample" is sampling even if
>>>>> it's not nested inside a "sample".
>>>>
>>>> You're assuming we are extracting a packet for sampling, but this function
>>>> can be used for various other purposes. For instance, it could handle the
>>>> packet outside of the OVS pipeline through an eBPF program (so we are not
>>>> taking a sample, but continue packet processing outside of the OVS
>>>> pipeline). Calling it emit_sampling() in such cases could be very
>>>> confusing.
>>
>> We can't change the implementation of the action once it is part of uAPI.
>> We have to document where users can find these packets and we can't just
>> change the destination later.
> 
> I'm not suggesting we change the uAPI implementation, but we could use the
> emit_xxx() action with an eBPF probe on the action to perform other tasks.
> This is just an example.

Yeah, but as Adrian said below, you could do that with any action and
this doesn't change the semantics of the action itself.

> 
>>> Well, I guess that would be clearly abusing the action. You could say
>>> that of anything really. You could hook into skb_consume and continue
>>> processing the skb but that doesn't change the intended behavior of the
>>> drop action.
>>>
>>> The intended behavior of the action is sampling, as is the intended
>>> behavior of "psample".
>>
>> The original OVS_ACTION_ATTR_SAMPLE "Probabilitically executes actions",
>> that is it takes some packets from the whole packet stream and executes
>> actions of them.  Without tying this to observability purposes the name
>> makes sense as the first definition of the word is "to take a representative
>> part or a single item from a larger whole or group".
>>
>> Now, our new action doesn't have this particular semantic in a way that
>> it doesn't take a part of a whole packet stream but rather using the
>> part already taken.  However, it is directly tied to the parent
>> OVS_ACTION_ATTR_SAMPLE action, since it reports probability of that parent
>> action.  If there is no parent, then probability is assumed to be 100%,
>> but that's just a corner case.  The name of a psample module has the
>> same semantics in its name, it doesn't sample on it's own, but it is
>> assuming that sampling was performed as it relays the rate of it.
>>
>> And since we're directly tied here with both OVS_ACTION_ATTR_SAMPLE and
>> the psample module, the emit_sample() name makes sense to me.
> 
> This is the part I don't like. emit_sample() should be treated as a
> standalone action. While it may have potential dependencies on
> OVS_ACTION_ATTR_SAMPLE, it should also be perfectly fine to use it
> independently.

It is fine to use it, we just assume implicit 100% sampling.

> 
>>>>> Having said that, I don't have a super strong favor for "emit_sample". I'm
>>>>> OK with "emit_local" or "emit_packet" or even just "emit".
>>
>> The 'local' or 'packet' variants are not descriptive enough on what we're
>> trying to achieve and do not explain why the probability is attached to
>> the action, i.e. do not explain the link between this action and the
>> OVS_ACTION_ATTR_SAMPLE.
>>
>> emit_Psample() would be overly specific, I agree, but making the name too
>> generic will also make it hard to add new actions.  If we use some overly
>> broad term for this one, we may have to deal with overlapping semantics in
>> the future.
>>
>>>>> I don't think any term will fully satisfy everyone so I hope we can find
>>>>> a reasonable compromise.
>>>>
>>>> My preference would be emit_local() as we hand it off to some local
>>>> datapath entity.
>>
>> What is "local datapath entity" ?  psample module is not part of OVS datapath.
>> And what is "local" ?  OpenFlow has the OFPP_LOCAL port that is represented
>> by a bridge port on a datapath level, that will be another source of confusion
>> as it can be interpreted as sending a packet via a local bridge port.
> 
> I guess I hinted at a local exit point in the specific netdev/netlink datapath,
> where exit is to the local host. So maybe we should call it emit_localhost?

For me sending to localhost means sending to a loopback interface or otherwise
sending the packet to the host networking stack.  And we're not doing that.

> 
>>> I'm OK removing the controversial term. Let's see what others think.
>>>
>>>>>>> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
>>>>>>> ---
>>>>>>>  Documentation/netlink/specs/ovs_flow.yaml | 17 +++++++++
>>>>>>>  include/uapi/linux/openvswitch.h          | 28 ++++++++++++++
>>>>>>>  net/openvswitch/Kconfig                   |  1 +
>>>>>>>  net/openvswitch/actions.c                 | 45 +++++++++++++++++++++++
>>>>>>>  net/openvswitch/flow_netlink.c            | 33 ++++++++++++++++-
>>>>>>>  5 files changed, 123 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/Documentation/netlink/specs/ovs_flow.yaml b/Documentation/netlink/specs/ovs_flow.yaml
>>>>>>> index 4fdfc6b5cae9..a7ab5593a24f 100644
>>>>>>> --- a/Documentation/netlink/specs/ovs_flow.yaml
>>>>>>> +++ b/Documentation/netlink/specs/ovs_flow.yaml
>>>>>>> @@ -727,6 +727,12 @@ attribute-sets:
>>>>>>>          name: dec-ttl
>>>>>>>          type: nest
>>>>>>>          nested-attributes: dec-ttl-attrs
>>>>>>> +      -
>>>>>>> +        name: emit-sample
>>>>>>> +        type: nest
>>>>>>> +        nested-attributes: emit-sample-attrs
>>>>>>> +        doc: |
>>>>>>> +          Sends a packet sample to psample for external observation.
>>>>>>>    -
>>>>>>>      name: tunnel-key-attrs
>>>>>>>      enum-name: ovs-tunnel-key-attr
>>>>>>> @@ -938,6 +944,17 @@ attribute-sets:
>>>>>>>        -
>>>>>>>          name: gbp
>>>>>>>          type: u32
>>>>>>> +  -
>>>>>>> +    name: emit-sample-attrs
>>>>>>> +    enum-name: ovs-emit-sample-attr
>>>>>>> +    name-prefix: ovs-emit-sample-attr-
>>>>>>> +    attributes:
>>>>>>> +      -
>>>>>>> +        name: group
>>>>>>> +        type: u32
>>>>>>> +      -
>>>>>>> +        name: cookie
>>>>>>> +        type: binary
>>>>>>>
>>>>>>>  operations:
>>>>>>>    name-prefix: ovs-flow-cmd-
>>>>>>> diff --git a/include/uapi/linux/openvswitch.h b/include/uapi/linux/openvswitch.h
>>>>>>> index efc82c318fa2..8cfa1b3f6b06 100644
>>>>>>> --- a/include/uapi/linux/openvswitch.h
>>>>>>> +++ b/include/uapi/linux/openvswitch.h
>>>>>>> @@ -914,6 +914,31 @@ struct check_pkt_len_arg {
>>>>>>>  };
>>>>>>>  #endif
>>>>>>>
>>>>>>> +#define OVS_EMIT_SAMPLE_COOKIE_MAX_SIZE 16
>>>>>>> +/**
>>>>>>> + * enum ovs_emit_sample_attr - Attributes for %OVS_ACTION_ATTR_EMIT_SAMPLE
>>>>>>> + * action.
>>>>>>> + *
>>>>>>> + * @OVS_EMIT_SAMPLE_ATTR_GROUP: 32-bit number to identify the source of the
>>>>>>> + * sample.
>>>>>>> + * @OVS_EMIT_SAMPLE_ATTR_COOKIE: A variable-length binary cookie that contains
>>>>>>> + * user-defined metadata. The maximum length is OVS_EMIT_SAMPLE_COOKIE_MAX_SIZE
>>>>>>> + * bytes.
>>>>>>> + *
>>>>>>> + * Sends the packet to the psample multicast group with the specified group and
>>>>>>> + * cookie. It is possible to combine this action with the
>>>>>>> + * %OVS_ACTION_ATTR_TRUNC action to limit the size of the packet being emitted.
>>>>>>
>>>>>> Although this include file is kernel-related, it will probably be re-used for
>>>>>> other datapaths, so should we be more general here?
>>>>>>
>>>>>
>>>>> The uAPI header documentation will be used for other datapaths? How so?
>>>>> At some point we should document what the action does from the kernel
>>>>> pov, right? Where should we do that if not here?
>>>>
>>>> Well you know how OVS works, all the data paths use the same netlink messages. Not sure how to solve this, but we could change the text a bit to be more general?
>>>>
>>>>  * For the Linux kernel it sends the packet to the psample multicast group
>>>>  * with the specified group and cookie. It is possible to combine this
>>>>  * action with the %OVS_ACTION_ATTR_TRUNC action to limit the size of the
>>>>  * packet being emitted.
>>>>
>>>
>>> I know we reuse the kernel attributes I don't think the uAPI
>>> documentation should be less expressive just because some userspace
>>> application decides to reuse parts of it.
>>>
>>> There are many kernel-specific terms all over the uAPI ("netdev",
>>> "netlink pid", "skb", even the action "userspace") that do not make
>>> sense in a non-kernel datapath.
>>
>> +1
>>
>> This is a kernel uAPI header it describes the behavior of the kernel.
>> Having parts like "For the Linux kernel" in here is awkward.
>>
>>>
>>> Maybe we can add such a comment in the copy of the header we store in
>>> the ovs tree?
>>
>> Makes sense to me.
>>
>> If we'll want to implement a similar action in userspace datapath,
>> we'll have to have a separate documentation for it anyway, since
>> the packets will end up in a different place for users to collect.
>>
>>>
>>>
>>>>>>> + */
>>>>>>> +enum ovs_emit_sample_attr {
>>>>>>> +	OVS_EMIT_SAMPLE_ATTR_GROUP = 1,	/* u32 number. */
>>>>>>> +	OVS_EMIT_SAMPLE_ATTR_COOKIE,	/* Optional, user specified cookie. */
>>>>>>
>>>>>> As we start a new set of attributes maybe it would be good starting it off in
>>>>>> alphabetical order?
>>>>>>
>>>>>
>>>>> Having an optional attribute before a mandatory one seems strange to me,
>>>>> wouldn't you agree?
>>>>
>>>> I don't mind, but I don't have a strong opinion on it. If others don't mind,
>>>> I would leave it as is.
>>>>
>>>
>>> I think I prefer to put mandatory attributes first.
>>
>> That's my thought as well.  Though that might be broken if we ever need
>> more attributes.  But we do not extend individual actions that often.
>>
>> Best regards, Ilya Maximets.
> 


