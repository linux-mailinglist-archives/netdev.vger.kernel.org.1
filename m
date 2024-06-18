Return-Path: <netdev+bounces-104593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A35390D949
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 18:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13D2CB31F62
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 15:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703F248CE0;
	Tue, 18 Jun 2024 15:44:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7058B44C76;
	Tue, 18 Jun 2024 15:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718725452; cv=none; b=a6JaYSEejxUD/BibkLvsrhDo64/GaemEeic0wewrWOh5C2JsML7U6OniG9AeRq3xrNtAdX9vGedHwY5DJNLSyJIOV0/tIC/mKZw2fIMbnMPla5oX5+LrfhhLFlmK+bPfQnqdN8FcCV9o1lJfWELFc56jv//BFL9r/pruJQmH7sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718725452; c=relaxed/simple;
	bh=/MBlto6Qqj2+ZTKzN6vAqeL+XR/qdgysFQsP413TV0M=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=E7aa9nVg18pmRYkmT7K0wKfZF6G27PchXRp8bb4XiHt5UCniWp0GCgXF3MarAjc71lCUoQ2waiVxgPJcG5/y3q9VMX3JbXBgJ2/Im7A9Fd7S2w8kkmzF3UDYDlmXiuC3lm8Esgau0jafd7/ss2jPRhWP0XCAP6ras7xb+YSZVwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=ovn.org; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ovn.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0C965E0006;
	Tue, 18 Jun 2024 15:44:05 +0000 (UTC)
Message-ID: <5c369615-1774-4dc5-87fc-d96ce3421ff8@ovn.org>
Date: Tue, 18 Jun 2024 17:44:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, netdev@vger.kernel.org, aconole@redhat.com,
 echaudro@redhat.com, horms@kernel.org, dev@openvswitch.org,
 Pravin B Shelar <pshelar@ovn.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 7/9] net: openvswitch: do not notify drops
 inside sample
To: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240603185647.2310748-1-amorenoz@redhat.com>
 <20240603185647.2310748-8-amorenoz@redhat.com>
 <8624ccf8-e9e2-4a95-a25c-7d3166bb3256@ovn.org>
 <f8050877-1728-4723-acb8-8a8ab7674470@ovn.org>
 <CAG=2xmPAwvCR4ky0cu7Yai29v3H592-ATXtNkhsNJ-vTwR4BVw@mail.gmail.com>
 <5f293bac-4117-4f93-8d3f-636d6ce236a4@ovn.org>
 <CAG=2xmPbpvYGy1rAkcLsK6PFxCx3bmZyXKX5RTag8XZBTxMZdg@mail.gmail.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <CAG=2xmPbpvYGy1rAkcLsK6PFxCx3bmZyXKX5RTag8XZBTxMZdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: i.maximets@ovn.org

On 6/18/24 12:50, Adrián Moreno wrote:
> On Tue, Jun 18, 2024 at 12:22:23PM GMT, Ilya Maximets wrote:
>> On 6/18/24 09:00, Adrián Moreno wrote:
>>> On Mon, Jun 17, 2024 at 02:10:37PM GMT, Ilya Maximets wrote:
>>>> On 6/17/24 13:55, Ilya Maximets wrote:
>>>>> On 6/3/24 20:56, Adrian Moreno wrote:
>>>>>> The OVS_ACTION_ATTR_SAMPLE action is, in essence,
>>>>>> observability-oriented.
>>>>>>
>>>>>> Apart from some corner case in which it's used a replacement of clone()
>>>>>> for old kernels, it's really only used for sFlow, IPFIX and now,
>>>>>> local emit_sample.
>>>>>>
>>>>>> With this in mind, it doesn't make much sense to report
>>>>>> OVS_DROP_LAST_ACTION inside sample actions.
>>>>>>
>>>>>> For instance, if the flow:
>>>>>>
>>>>>>   actions:sample(..,emit_sample(..)),2
>>>>>>
>>>>>> triggers a OVS_DROP_LAST_ACTION skb drop event, it would be extremely
>>>>>> confusing for users since the packet did reach its destination.
>>>>>>
>>>>>> This patch makes internal action execution silently consume the skb
>>>>>> instead of notifying a drop for this case.
>>>>>>
>>>>>> Unfortunately, this patch does not remove all potential sources of
>>>>>> confusion since, if the sample action itself is the last action, e.g:
>>>>>>
>>>>>>     actions:sample(..,emit_sample(..))
>>>>>>
>>>>>> we actually _should_ generate a OVS_DROP_LAST_ACTION event, but we aren't.
>>>>>>
>>>>>> Sadly, this case is difficult to solve without breaking the
>>>>>> optimization by which the skb is not cloned on last sample actions.
>>>>>> But, given explicit drop actions are now supported, OVS can just add one
>>>>>> after the last sample() and rewrite the flow as:
>>>>>>
>>>>>>     actions:sample(..,emit_sample(..)),drop
>>>>>>
>>>>>> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
>>>>>> ---
>>>>>>  net/openvswitch/actions.c | 13 +++++++++++--
>>>>>>  1 file changed, 11 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
>>>>>> index 33f6d93ba5e4..54fc1abcff95 100644
>>>>>> --- a/net/openvswitch/actions.c
>>>>>> +++ b/net/openvswitch/actions.c
>>>>>> @@ -82,6 +82,15 @@ static struct action_fifo __percpu *action_fifos;
>>>>>>  static struct action_flow_keys __percpu *flow_keys;
>>>>>>  static DEFINE_PER_CPU(int, exec_actions_level);
>>>>>>
>>>>>> +static inline void ovs_drop_skb_last_action(struct sk_buff *skb)
>>>>>> +{
>>>>>> +	/* Do not emit packet drops inside sample(). */
>>>>>> +	if (OVS_CB(skb)->probability)
>>>>>> +		consume_skb(skb);
>>>>>> +	else
>>>>>> +		ovs_kfree_skb_reason(skb, OVS_DROP_LAST_ACTION);
>>>>>> +}
>>>>>> +
>>>>>>  /* Make a clone of the 'key', using the pre-allocated percpu 'flow_keys'
>>>>>>   * space. Return NULL if out of key spaces.
>>>>>>   */
>>>>>> @@ -1061,7 +1070,7 @@ static int sample(struct datapath *dp, struct sk_buff *skb,
>>>>>>  	if ((arg->probability != U32_MAX) &&
>>>>>>  	    (!arg->probability || get_random_u32() > arg->probability)) {
>>>>>>  		if (last)
>>>>>> -			ovs_kfree_skb_reason(skb, OVS_DROP_LAST_ACTION);
>>>>>> +			ovs_drop_skb_last_action(skb);
>>>>
>>>> Always consuming the skb at this point makes sense, since having smaple()
>>>> as a last action is a reasonable thing to have.  But this looks more like
>>>> a fix for the original drop reason patch set.
>>>>
>>>
>>> I don't think consuming the skb at this point makes sense. It was very
>>> intentionally changed to a drop since a very common use-case for
>>> sampling is drop-sampling, i.e: replacing an empty action list (that
>>> triggers OVS_DROP_LAST_ACTION) with a sample(emit_sample()). Ideally,
>>> that replacement should not have any effect on the number of
>>> OVS_DROP_LAST_ACTION being reported as the packets are being treated in
>>> the same way (only observed in one case).
>>>
>>>
>>>>>>  		return 0;
>>>>>>  	}
>>>>>>
>>>>>> @@ -1579,7 +1588,7 @@ static int do_execute_actions(struct datapath *dp, struct sk_buff *skb,
>>>>>>  		}
>>>>>>  	}
>>>>>>
>>>>>> -	ovs_kfree_skb_reason(skb, OVS_DROP_LAST_ACTION);
>>>>>> +	ovs_drop_skb_last_action(skb);
>>>>>
>>>>> I don't think I agree with this one.  If we have a sample() action with
>>>>> a lot of different actions inside and we reached the end while the last
>>>>> action didn't consume the skb, then we should report that.  E.g.
>>>>> "sample(emit_sample(),push_vlan(),set(eth())),2"  should report that the
>>>>> cloned skb was dropped.  "sample(push_vlan(),emit_sample())" should not.
>>>>>
>>>
>>> What is the use case for such action list? Having an action branch
>>> executed randomly doesn't make sense to me if it's not some
>>> observability thing (which IMHO should not trigger drops).
>>
>> It is exactly my point.  A list of actions that doesn't end is some sort
>> of a terminal action (output, drop, etc) does not make a lot of sense and
>> hence should be signaled as an unexpected drop, so users can re-check the
>> pipeline in case they missed the terminal action somehow.
>>
>>>
>>>>> The only actions that are actually consuming the skb are "output",
>>>>> "userspace", "recirc" and now "emit_sample".  "output" and "recirc" are
>>>>> consuming the skb "naturally" by stealing it when it is the last action.
>>>>> "userspace" has an explicit check to consume the skb if it is the last
>>>>> action.  "emit_sample" should have the similar check.  It should likely
>>>>> be added at the point of action introduction instead of having a separate
>>>>> patch.
>>>>>
>>>
>>> Unlinke "output", "recirc", "userspace", etc. with emit_sample the
>>> packet does not continue it's way through the datapath.
>>
>> After "output" the packet leaves the datapath too, i.e. does not continue
>> it's way through OVS datapath.
>>
> 
> I meant a broader concept of "datapath". The packet continues. For the
> userspace action this is true only for the CONTROLLER ofp action but
> since the datapath does not know which action it's implementing, we
> cannot do better.

It's not only controller() action.  Packets can be brought to userspace
for various reason including just an explicit ask to execute some actions
in userspace.  In any case the packet sent to userspace kind of reached its
destination and it's not the "datapath drops the packet" situation.

> 
>>>
>>> It would be very confusing if OVS starts monitoring drops and adds a bunch
>>> of flows such as "actions:emit_sample()" and suddently it stops reporting such
>>> drops via standard kfree_skb_reason. Packets _are_ being dropped here,
>>> we are just observing them.
>>
>> This might make sense from the higher logic in user space application, but
>> it doesn't from the datapath perspective.  And also, if the user adds the
>> 'emit_sample' action for drop monitring, they already know where to find
>> packet samples, they don't need to use tools like dropwatch anymore.
>> This packet is not dropped from the datapath perspective, it is sampled.
>>
>>>
>>> And if we change emit_sample to trigger a drop if it's the last action,
>>> then "sample(50%, emit_sample()),2" will trigger a drop half of the times
>>> which is also terribly confusing.
>>
>> If emit_sample is the last action, then skb should be consumed silently.
>> The same as for "output" and "userspace".
>>
>>>
>>> I think we should try to be clear and informative with what we
>>> _actually_ drop and not require the user that is just running
>>> "dropwatch" to understand the internals of the OVS module.
>>
>> If someone is already using sampling to watch their packet drops, why would
>> they use dropwatch?
>>
>>>
>>> So if you don't want to accept the "observational" nature of sample(),
>>> the only other solution that does not bring even more confusion to OVS
>>> drops would be to have userspace add explicit drop actions. WDYT?
>>>
>>
>> These are not drops from the datapath perspective.  Users can add explicit
>> drop actions if they want to, but I'm really not sure why they would do that
>> if they are already capturing all these packets in psample, sFlow or IPFIX.
> 
> Because there is not a single "user". Tools and systems can be built on
> top of tracepoints and samples and they might not be coordinated between
> them. Some observability application can be always enabled and doing
> constant network monitoring or statistics while other lower level tools
> can be run at certain moments to troubleshoot issues.
> 
> In order to run dropwatch in a node you don't need to have rights to
> access the OpenFlow controller and ask it to change the OpenFlow rules
> or else dropwatch simply will not show actual packet drops.

The point is that these are not drops in this scenario.  The packet was
delivered to its destination and hence should not be reported as dropped.
In the observability use-case that you're describing even OpenFlow layer
in OVS doesn't know if these supposed to be treated as packet drops for
the user or if these are just samples with the sampling being the only
intended destination.  For OpenFlow and OVS userspace components these
two scenarios are indistinguishable.  Only the OpenFlow controller knows
that these rules were put in place because it was an ACL created by some
user or tool.  And since OVS in user space can't make such a distinction,
kernel can't make it either, and so shouldn't guess what the user two
levels of abstraction higher up meant.

> 
> To me it seems obvious that drop sampling (via emit_sample) "includes"
> drop reporting via emit_sample. In both cases you get the packet
> headers, but in one case you also get OFP controller metadata. Now even
> if there is a system that uses both, does it make sense to push to them
> the responsibility of dealing with them being mutually exclusive?
> 
> I think this makes debugging OVS datapath unnecessarily obscure when we
> know the packet is actually being dropped intentionally by OVS.

I don't think we know that we're in a drop sampling scenario.  We don't
have enough information even in OVS userspace to tell.

And having different behavior between "userspace" and "emit_sample" in
the kernel may cause even more confusion, because now two ways of sampling
packets will result in packets showing up in dropwatch in one case, but
not in the other.

> 
> What's the problem with having OVS write the following?
>     "sample(50%, emit_sample()),drop(0)"

It's a valid sequence of actions, but we shouldn't guess what the end
user meant by putting those actions into the kernel.  If we see such a
sequence in the kernel, then we should report an explicit drop.  If
there was only the "sample(50%, emit_sample())" then we should simply
consume the skb as it reached its destination in the psample.

For the question if OVS in user space should put explicit drop action
while preparing to emit sample, this doesn't sound reasonable for the
same reason - OVS in user space doesn't know what the intention was of
the user or tool that put the sampling action into OpenFlow pipeline.


I actually became more confused about what are we arguing about.
To recap:

                                     This patch     My proposal

1. emit_sample() is the last            consume        consume  
    inside the sample()

2. the end of the action list           consume        drop
    inside the sample()

3. emit_sample() is the last            drop           consume
    outside the sample()

4. the end of the action list           drop           drop
    outside the sample()

5. sample() is the last action          consume        consume
    and probability failed


I don't think cases 1 and 3 should differ, i.e. the behavior should
be the same regardless of emit_sample() being inside or outside of
the sample().  As a side point, OVS in user space will omit the 100%
rate sample() action and will just list inner actions instead.  This
means that 100% probability sampling will generate drops and 99% will
not.  Doesn't sound right.

Case 2 should likely never happen, but I'd like to see a drop reported
if that ever happens, because it is not a meaningful list of actions.

Best regards, Ilya Maximets.

