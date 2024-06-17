Return-Path: <netdev+bounces-103997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6546A90ACE7
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 13:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D73871F21E16
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 11:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FAF194A6C;
	Mon, 17 Jun 2024 11:26:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FEF1946BF;
	Mon, 17 Jun 2024 11:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718623607; cv=none; b=hHxG1jjtiQFd79LmiC12mriNt24vtHzjCj6fw5nYZU2onCdSV5i16UO6oFisKBNvxWwkl9h4cc0h1OrezgutXD16v6WGS2mwtOZU/LkHWhR9UQevjbUjgGWOAL/ac6ceWfr5tcAb7tlk/T4rVTxibJkphGK7b1XjABxAI5Hn0EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718623607; c=relaxed/simple;
	bh=qDoehNgsCMI5e8Bmm8e24nEVyoue9Gc45pm+i84hRAU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EmWGRvFm340CKulEIB4Kv8ASkHT/ze7fZiTlXzhjbVuN/Ma7m4JagPkSUW6r2Yvcb3HHFDsIZWimFUbGRhWSX+Uds90lyOdZxGZq1GAL8Y/QWZYuGRhTlXFg1yXnZ+jIJ0ptNjaAXfVx7mR2GDDSEiwQf0avTK7/qUTnSinb1j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=ovn.org; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ovn.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2964D24000A;
	Mon, 17 Jun 2024 11:26:40 +0000 (UTC)
Message-ID: <c96f6b5e-f72d-4aa2-af67-41a5026e7053@ovn.org>
Date: Mon, 17 Jun 2024 13:26:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, netdev@vger.kernel.org, echaudro@redhat.com,
 horms@kernel.org, dev@openvswitch.org, Pravin B Shelar <pshelar@ovn.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 6/9] net: openvswitch: store sampling
 probability in cb.
To: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>,
 Aaron Conole <aconole@redhat.com>
References: <20240603185647.2310748-1-amorenoz@redhat.com>
 <20240603185647.2310748-7-amorenoz@redhat.com> <f7t4j9vo44g.fsf@redhat.com>
 <CAG=2xmPW=1HzojWhHaE3z_x5u_Dv1zPVmMn4cSmV6DF4fzq5KA@mail.gmail.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <CAG=2xmPW=1HzojWhHaE3z_x5u_Dv1zPVmMn4cSmV6DF4fzq5KA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: i.maximets@ovn.org

On 6/17/24 09:08, Adrián Moreno wrote:
> On Fri, Jun 14, 2024 at 12:55:59PM GMT, Aaron Conole wrote:
>> Adrian Moreno <amorenoz@redhat.com> writes:
>>
>>> The behavior of actions might not be the exact same if they are being
>>> executed inside a nested sample action. Store the probability of the
>>> parent sample action in the skb's cb area.
>>
>> What does that mean?
>>
> 
> Emit action, for instance, needs the probability so that psample
> consumers know what was the sampling rate applied. Also, the way we
> should inform about packet drops (via kfree_skb_reason) changes (see
> patch 7/9).
> 
>>> Use the probability in emit_sample to pass it down to psample.
>>>
>>> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
>>> ---
>>>  include/uapi/linux/openvswitch.h |  3 ++-
>>>  net/openvswitch/actions.c        | 25 ++++++++++++++++++++++---
>>>  net/openvswitch/datapath.h       |  3 +++
>>>  net/openvswitch/vport.c          |  1 +
>>>  4 files changed, 28 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/include/uapi/linux/openvswitch.h b/include/uapi/linux/openvswitch.h
>>> index a0e9dde0584a..9d675725fa2b 100644
>>> --- a/include/uapi/linux/openvswitch.h
>>> +++ b/include/uapi/linux/openvswitch.h
>>> @@ -649,7 +649,8 @@ enum ovs_flow_attr {
>>>   * Actions are passed as nested attributes.
>>>   *
>>>   * Executes the specified actions with the given probability on a per-packet
>>> - * basis.
>>> + * basis. Nested actions will be able to access the probability value of the
>>> + * parent @OVS_ACTION_ATTR_SAMPLE.
>>>   */
>>>  enum ovs_sample_attr {
>>>  	OVS_SAMPLE_ATTR_UNSPEC,
>>> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
>>> index 3b4dba0ded59..33f6d93ba5e4 100644
>>> --- a/net/openvswitch/actions.c
>>> +++ b/net/openvswitch/actions.c
>>> @@ -1048,12 +1048,15 @@ static int sample(struct datapath *dp, struct sk_buff *skb,
>>>  	struct nlattr *sample_arg;
>>>  	int rem = nla_len(attr);
>>>  	const struct sample_arg *arg;
>>> +	u32 init_probability;
>>>  	bool clone_flow_key;
>>> +	int err;
>>>
>>>  	/* The first action is always 'OVS_SAMPLE_ATTR_ARG'. */
>>>  	sample_arg = nla_data(attr);
>>>  	arg = nla_data(sample_arg);
>>>  	actions = nla_next(sample_arg, &rem);
>>> +	init_probability = OVS_CB(skb)->probability;
>>>
>>>  	if ((arg->probability != U32_MAX) &&
>>>  	    (!arg->probability || get_random_u32() > arg->probability)) {
>>> @@ -1062,9 +1065,21 @@ static int sample(struct datapath *dp, struct sk_buff *skb,
>>>  		return 0;
>>>  	}
>>>
>>> +	if (init_probability) {
>>> +		OVS_CB(skb)->probability = ((u64)OVS_CB(skb)->probability *
>>> +					    arg->probability / U32_MAX);
>>> +	} else {
>>> +		OVS_CB(skb)->probability = arg->probability;
>>> +	}
>>> +
>>
>> I'm confused by this.  Eventually, integer arithmetic will practically
>> guarantee that nested sample() calls will go to 0.  So eventually, the
>> test above will be impossible to meet mathematically.
>>
>> OTOH, you could argue that a 1% of 50% is low anyway, but it still would
>> have a positive probability count, and still be possible for
>> get_random_u32() call to match.
>>
> 
> Using OVS's probability semantics, we can express probabilities as low
> as (100/U32_MAX)% which is pretty low indeed. However, just because the
> probability of executing the action is low I don't think we should not
> report it.
> 
> Rethinking the integer arithmetics, it's true that we should avoid
> hitting zero on the division, eg: nesting 6x 1% sampling rates will make
> the result be zero which will make probability restoration fail on the
> way back. Threrefore, the new probability should be at least 1.
> 
> 
>> I'm not sure about this particular change.  Why do we need it?
>>
> 
> Why do we need to propagate the probability down to nested "sample"
> actions? or why do we need to store the probability in the cb area in
> the first place?
> 
> The former: Just for correctness as only storing the last one would be
> incorrect. Although I don't know of any use for nested "sample" actions.

I think, we can drop this for now.  All the user interfaces specify
the probability per action.  So, it should be fine to report the
probability of the action that emitted the sample without taking into
account the whole timeline of that packet.  Besides, packet can leave
OVS and go back loosing the metadata, so it will not actually be a
full solution anyway.  Single-action metadata is easier to define.

> The latter: To pass it down to psample so that sample receivers know how
> the sampling rate applied (and, e.g: do throughput estimations like OVS
> does with IPFIX).
> 
> 
>>>  	clone_flow_key = !arg->exec;
>>> -	return clone_execute(dp, skb, key, 0, actions, rem, last,
>>> -			     clone_flow_key);
>>> +	err = clone_execute(dp, skb, key, 0, actions, rem, last,
>>> +			    clone_flow_key);
>>> +
>>> +	if (!last)
>>
>> Is this right?  Don't we only want to set the probability on the last
>> action?  Should the test be 'if (last)'?
>>
> 
> This is restoring the parent's probability after the actions in the
> current sample action have been executed.
> 
> If it was the last action there is no need to restore the probability
> back to the parent's (or zero if it's there's only one level) since no
> further action will require it. And more importantly, if it's the last
> action, the packet gets free'ed inside that "branch" so we must not
> access its memory.
> 
> 
>>> +		OVS_CB(skb)->probability = init_probability;
>>> +
>>> +	return err;
>>>  }
>>>
>>>  /* When 'last' is true, clone() should always consume the 'skb'.
>>> @@ -1313,6 +1328,7 @@ static int execute_emit_sample(struct datapath *dp, struct sk_buff *skb,
>>>  	struct psample_metadata md = {};
>>>  	struct vport *input_vport;
>>>  	const struct nlattr *a;
>>> +	u32 rate;
>>>  	int rem;
>>>
>>>  	for (a = nla_data(attr), rem = nla_len(attr); rem > 0;
>>> @@ -1337,8 +1353,11 @@ static int execute_emit_sample(struct datapath *dp, struct sk_buff *skb,
>>>
>>>  	md.in_ifindex = input_vport->dev->ifindex;
>>>  	md.trunc_size = skb->len - OVS_CB(skb)->cutlen;
>>> +	md.rate_as_probability = 1;
>>> +
>>> +	rate = OVS_CB(skb)->probability ? OVS_CB(skb)->probability : U32_MAX;
>>>
>>> -	psample_sample_packet(&psample_group, skb, 0, &md);
>>> +	psample_sample_packet(&psample_group, skb, rate, &md);
>>>  #endif
>>>
>>>  	return 0;
>>> diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapath.h
>>> index 0cd29971a907..9ca6231ea647 100644
>>> --- a/net/openvswitch/datapath.h
>>> +++ b/net/openvswitch/datapath.h
>>> @@ -115,12 +115,15 @@ struct datapath {
>>>   * fragmented.
>>>   * @acts_origlen: The netlink size of the flow actions applied to this skb.
>>>   * @cutlen: The number of bytes from the packet end to be removed.
>>> + * @probability: The sampling probability that was applied to this skb; 0 means
>>> + * no sampling has occurred; U32_MAX means 100% probability.
>>>   */
>>>  struct ovs_skb_cb {
>>>  	struct vport		*input_vport;
>>>  	u16			mru;
>>>  	u16			acts_origlen;
>>>  	u32			cutlen;
>>> +	u32			probability;
>>>  };
>>>  #define OVS_CB(skb) ((struct ovs_skb_cb *)(skb)->cb)
>>>
>>> diff --git a/net/openvswitch/vport.c b/net/openvswitch/vport.c
>>> index 972ae01a70f7..8732f6e51ae5 100644
>>> --- a/net/openvswitch/vport.c
>>> +++ b/net/openvswitch/vport.c
>>> @@ -500,6 +500,7 @@ int ovs_vport_receive(struct vport *vport, struct sk_buff *skb,
>>>  	OVS_CB(skb)->input_vport = vport;
>>>  	OVS_CB(skb)->mru = 0;
>>>  	OVS_CB(skb)->cutlen = 0;
>>> +	OVS_CB(skb)->probability = 0;
>>>  	if (unlikely(dev_net(skb->dev) != ovs_dp_get_net(vport->dp))) {
>>>  		u32 mark;
>>
> 


