Return-Path: <netdev+bounces-85994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB4B89D400
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 10:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3552283FD8
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 08:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A2E7E59F;
	Tue,  9 Apr 2024 08:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZH+MAXwk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DD37E119
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 08:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712650620; cv=none; b=PuAtqXdLdQFsi8rH4u6l5l8F9a8JG27ATgR40t4ma3FGnljdrJnfOJu/ai9LLEzfL4c5BDUdMNKfukDkjTShakiCphBcWQXN7aiydnvDWg3czu8L65sE8f1qJbz8+C6FH4FvXM2LUyb7/Tek738ZkgGAKEE4tgd3FNlfSOgDqPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712650620; c=relaxed/simple;
	bh=W43FOC6xZOPiz9USqVJgI/Ex4roe8JcORBPYrFrzPaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZFZrNE4SKloHhg9WTNxgXBNkQa7kfoL4DkyK9+gba0Qsly9oSnZuUJ9KJ3mBdMGYCwpAtH45eZdQc/Z+9QgSF/XPHFcrRb0hSNFOXUTsvQN6845do9aXFC1Fv36QEAsn3KyWfp3wVVK1e7TaFYjWQSWc6/GZ3BaXA5FGjFlPIEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZH+MAXwk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712650617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nf6jpGtTtpOG8QUAUOTzZ6YC7yjKl6zrYU88i8sHRQM=;
	b=ZH+MAXwkIRNZg7VpxA+p7Q7sC4wyfttG5E9aQjikaTI98ph8lz4xeiUXqR9bJsOuSwxA3z
	vFsLym3NcgSKxut3QMiO/knZ98RTEUrORztn1ogkrAfnhDVHciDJnUPTHbNN0ZsJYQ529h
	AlqsqrBO5Rx2eyXQafgIdz0yTi91/1s=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-sdAkqnmzN0ONl5Wj4LNthQ-1; Tue, 09 Apr 2024 04:16:55 -0400
X-MC-Unique: sdAkqnmzN0ONl5Wj4LNthQ-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-69b123bfbd9so24827546d6.1
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 01:16:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712650615; x=1713255415;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nf6jpGtTtpOG8QUAUOTzZ6YC7yjKl6zrYU88i8sHRQM=;
        b=mgIMChxzaC8Z3Q+JFkUFhMalMUv1VDFQUnQAxDMBAEIvg7TpHzCix1l1ercuuSlxrV
         Ne3IPYUDV5dglDWrEqPMdGUBls4Y1A5kL1If0O0H9lS0v/XrcbQgZCUEkiGfwfeawrqd
         3KARKnKgoWKi+NZ1eFSJyoibmmbki+4BsfuiMEz9ImdnWKJfJZdcGWIY/qwXQ7Z0Bpmd
         1JbIlQm/Q/PFIZajDJB4g1zNbpbLGB+/bdEhqkNJ1l2C3OqKxX7rLVzH1+TWYQmhJQJA
         WO2eB5/cRDys8iSK45pnpFJrnrkZCAaNZYIRIr4jCP7LwlLmrfhgjq/EUk4rfIE/wFi9
         tCng==
X-Forwarded-Encrypted: i=1; AJvYcCU8q6Br7QAhvHagWAKrxKapxgL8Jah710Rn/V/MgI0mUeujq3TJeRatslxnskwwaOPlSksiZ8tSg9H2A6vVHTp5l0HFhefN
X-Gm-Message-State: AOJu0YzsEIWyOin8SuvLhSvnaFRd6cpCjaU9+2pfuaPOf2B+WrpursAk
	6B6KgGiED/ZBhJ2D7hWdEPkGiJlGVgtYnDBxjawtmvBzmBLsGhI5dAxdRu8ZbRB3GGLknLZ+I2S
	QdF1OBXzPcnScho/MxwnSe2zbYpQL7yAgsVqqQ+AwEs0aVB2GldVmBw==
X-Received: by 2002:ad4:5e89:0:b0:69b:1615:160e with SMTP id jl9-20020ad45e89000000b0069b1615160emr8652823qvb.38.1712650615312;
        Tue, 09 Apr 2024 01:16:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkK3Vza6YiEfSW5EM8F8yQAy4fgUlkTfHGQuYRpGXFW0PXQHYNJqprCYAuA/pLbYDW79aheA==
X-Received: by 2002:ad4:5e89:0:b0:69b:1615:160e with SMTP id jl9-20020ad45e89000000b0069b1615160emr8652803qvb.38.1712650614944;
        Tue, 09 Apr 2024 01:16:54 -0700 (PDT)
Received: from [192.168.1.132] ([193.177.208.51])
        by smtp.gmail.com with ESMTPSA id l15-20020a0ce08f000000b006986c3f3d21sm3822355qvk.116.2024.04.09.01.16.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 01:16:54 -0700 (PDT)
Message-ID: <01898b85-d950-4e56-99b3-5a366dddb383@redhat.com>
Date: Tue, 9 Apr 2024 10:16:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next v2 5/5] net:openvswitch: add psample support
To: Ilya Maximets <i.maximets@ovn.org>, netdev@vger.kernel.org
Cc: jiri@resnulli.us, xiyou.wangcong@gmail.com, cmi@nvidia.com,
 yotam.gi@gmail.com, aconole@redhat.com, echaudro@redhat.com, horms@kernel.org
References: <20240408125753.470419-1-amorenoz@redhat.com>
 <20240408125753.470419-6-amorenoz@redhat.com>
 <eb44af1d-7514-4084-b022-56f1845b109e@ovn.org>
 <ad55dd2d-c07e-4396-a32c-92d7aefe2ef0@redhat.com>
 <4a86e5bb-f176-42fc-a2b1-f21dea943626@ovn.org>
Content-Language: en-US
From: Adrian Moreno <amorenoz@redhat.com>
In-Reply-To: <4a86e5bb-f176-42fc-a2b1-f21dea943626@ovn.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/8/24 22:40, Ilya Maximets wrote:
> On 4/8/24 21:48, Adrian Moreno wrote:
>>
>>
>> On 4/8/24 15:37, Ilya Maximets wrote:
>>> On 4/8/24 14:57, Adrian Moreno wrote:
>>>> Add a new attribute to the sample action, called
>>>> OVS_SAMPLE_ATTR_PSAMPLE to allow userspace to pass a group_id and a
>>>> user-defined cookie.
>>>>
>>>> The maximum length of the user-defined cookie is set to 16, same as
>>>> tc_cookie to discourage using cookies that will not be offloadable.
>>>>
>>>> When set, the sample action will use psample to multicast the sample.
>>>>
>>>> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
>>>> ---
>>>>    include/uapi/linux/openvswitch.h | 22 +++++++--
>>>>    net/openvswitch/actions.c        | 52 ++++++++++++++++++---
>>>>    net/openvswitch/datapath.c       |  2 +-
>>>>    net/openvswitch/flow_netlink.c   | 78 +++++++++++++++++++++++++-------
>>>>    4 files changed, 127 insertions(+), 27 deletions(-)
>>>
>>> This cpatch is missing a few bits:
>>>    - Update for Documentation/netlink/specs/ovs_flow.yaml
>>>    - Maybe update for tools/testing/selftests/net/openvswitch/ovs-dpctl.py
>>>    - Maybe some basic selftests.
>>>
>>
>> Absolutely. I surely plan to add it on the first non-rfc version.
>>
>>>>
>>>> diff --git a/include/uapi/linux/openvswitch.h b/include/uapi/linux/openvswitch.h
>>>> index efc82c318fa2..a5a32588f582 100644
>>>> --- a/include/uapi/linux/openvswitch.h
>>>> +++ b/include/uapi/linux/openvswitch.h
>>>> @@ -646,15 +646,24 @@ enum ovs_flow_attr {
>>>>     * %UINT32_MAX samples all packets and intermediate values sample intermediate
>>>>     * fractions of packets.
>>>>     * @OVS_SAMPLE_ATTR_ACTIONS: Set of actions to execute in sampling event.
>>>> - * Actions are passed as nested attributes.
>>>> + * Actions are passed as nested attributes. Optional if OVS_SAMPLE_ATTR_PSAMPLE
>>>> + * is not set.
>>>
>>> 'is set' probably. >
>>>> + * @OVS_SAMPLE_ATTR_PSAMPLE: Arguments to be passed to psample. Optional if
>>>> + * OVS_SAMPLE_ATTR_ACTIONS is not set.
>>>
>>> Same here.
>>>
>>
>> Good catch, I rewrote those comments a bunch of times and the were left
>> expressing the exact opposite!
>>
>>
>>>>     *
>>>> - * Executes the specified actions with the given probability on a per-packet
>>>> - * basis.
>>>> + * Either OVS_SAMPLE_ATTR_USER_COOKIE or OVS_SAMPLE_ATTR_USER_COOKIE must be
>>>> + * specified.
>>>> + *
>>>> + * Executes the specified actions and/or sends the packet to psample
>>>> + * with the given probability on a per-packet basis.
>>>>     */
>>>>    enum ovs_sample_attr {
>>>>    	OVS_SAMPLE_ATTR_UNSPEC,
>>>>    	OVS_SAMPLE_ATTR_PROBABILITY, /* u32 number */
>>>>    	OVS_SAMPLE_ATTR_ACTIONS,     /* Nested OVS_ACTION_ATTR_* attributes. */
>>>> +	OVS_SAMPLE_ATTR_PSAMPLE,     /* struct ovs_psample followed
>>>> +				      * by the user-provided cookie.
>>>> +				      */
>>>>    	__OVS_SAMPLE_ATTR_MAX,
>>>>    
>>>>    #ifdef __KERNEL__
>>>> @@ -675,6 +684,13 @@ struct sample_arg {
>>>>    };
>>>>    #endif
>>>>    
>>>> +#define OVS_PSAMPLE_COOKIE_MAX_SIZE 16
>>>> +struct ovs_psample {
>>>> +	__u32 group_id;		/* The group used for packet sampling. */
>>>> +	__u32 user_cookie_len;	/* The length of the user-provided cookie. */
> 
> Here as well, not sure if u32 makes sense as userspace can't
> actually supply a cookie this large via netlink.
> 
>>>> +	__u8 user_cookie[];	/* The user-provided cookie. */
>>>> +};
>>>
>>> Structures are not a good approach for modern netlink.
>>> use nested attributes instead.  This way we can also
>>> eliminate the need for variable-length array and the
>>> length field, if the length can be taken from a netlink
>>> attribute directly, e.g. similar to NLA_BINARY in tc.
>>>
>>> If necessary, there could be a structure in the private
>>> header to store the data for internal use.
>>>
>>
>> Interesting. Thanks for the suggestion. I think it will also help action validation.
>>
>>>> +
>>>>    /**
>>>>     * enum ovs_userspace_attr - Attributes for %OVS_ACTION_ATTR_USERSPACE action.
>>>>     * @OVS_USERSPACE_ATTR_PID: u32 Netlink PID to which the %OVS_PACKET_CMD_ACTION
>>>> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
>>>> index 6fcd7e2ca81f..45d2b325b76a 100644
>>>> --- a/net/openvswitch/actions.c
>>>> +++ b/net/openvswitch/actions.c
>>>> @@ -24,6 +24,7 @@
>>>>    #include <net/checksum.h>
>>>>    #include <net/dsfield.h>
>>>>    #include <net/mpls.h>
>>>> +#include <net/psample.h>
>>>>    #include <net/sctp/checksum.h>
>>>>    
>>>>    #include "datapath.h"
>>>> @@ -1025,6 +1026,31 @@ static int dec_ttl_exception_handler(struct datapath *dp, struct sk_buff *skb,
>>>>    	return 0;
>>>>    }
>>>>    
>>>> +static int ovs_psample_packet(struct datapath *dp, struct sw_flow_key *key,
>>>> +			      struct ovs_psample *psample, struct sk_buff *skb,
>>>> +			      u32 rate)
>>>> +{
>>>> +	struct psample_group psample_group = {};
>>>> +	struct psample_metadata md = {};
>>>> +	struct vport *input_vport;
>>>> +
>>>> +	psample_group.group_num = psample->group_id;
>>>> +	psample_group.net = ovs_dp_get_net(dp);
>>>> +
>>>> +	input_vport = ovs_vport_rcu(dp, key->phy.in_port);
>>>> +	if (!input_vport)
>>>> +		input_vport = ovs_vport_rcu(dp, OVSP_LOCAL);
>>>> +
>>>> +	md.in_ifindex = input_vport->dev->ifindex;
>>>> +	md.user_cookie = psample->user_cookie;
>>>> +	md.user_cookie_len = psample->user_cookie_len;
>>>> +	md.trunc_size = skb->len;
>>>> +
>>>> +	psample_sample_packet(&psample_group, skb, rate, &md);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>>    /* When 'last' is true, sample() should always consume the 'skb'.
>>>>     * Otherwise, sample() should keep 'skb' intact regardless what
>>>>     * actions are executed within sample().
>>>> @@ -1033,16 +1059,17 @@ static int sample(struct datapath *dp, struct sk_buff *skb,
>>>>    		  struct sw_flow_key *key, const struct nlattr *attr,
>>>>    		  bool last)
>>>>    {
>>>> -	struct nlattr *actions;
>>>> +	const struct sample_arg *arg;
>>>>    	struct nlattr *sample_arg;
>>>>    	int rem = nla_len(attr);
>>>> -	const struct sample_arg *arg;
>>>> +	struct nlattr *next;
>>>>    	bool clone_flow_key;
>>>> +	int ret;
>>>>    
>>>>    	/* The first action is always 'OVS_SAMPLE_ATTR_ARG'. */
>>>>    	sample_arg = nla_data(attr);
>>>>    	arg = nla_data(sample_arg);
>>>> -	actions = nla_next(sample_arg, &rem);
>>>> +	next = nla_next(sample_arg, &rem);
>>>>    
>>>>    	if ((arg->probability != U32_MAX) &&
>>>>    	    (!arg->probability || get_random_u32() > arg->probability)) {
>>>> @@ -1051,9 +1078,22 @@ static int sample(struct datapath *dp, struct sk_buff *skb,
>>>>    		return 0;
>>>>    	}
>>>>    
>>>> -	clone_flow_key = !arg->exec;
>>>> -	return clone_execute(dp, skb, key, 0, actions, rem, last,
>>>> -			     clone_flow_key);
>>>> +	if (next->nla_type == OVS_SAMPLE_ATTR_PSAMPLE) {
>>>
>>> Maybe add a commnet that OVS_SAMPLE_ATTR_PSAMPLE is always a sencond
>>> argument when present.
>>>
>>> Is there a better way to handle this?
>>>
>>
>> I also dislike it. The fact that actions are not nested but concatenated to
>> makes the internal representation a bit flaky.
>>
>> The alternative I considered was adding the group_id and cookie to the
>> internal-only OVS_SAMPLE_ATTR_ARG. However, now I wonder:
>> - Should we also use nested attributes instead of structs for this internal one?
>>
>> And, probably off-topic: what's the story behind using netlink attributes to
>> store action arguments internally? Has it ever been discussed using a union for
>> instance?
> 
> I'm not sure why it was originally done this way, but it is probably
> the most efficient of convenient ways to pack a tree-like structure.
> If we had a union, we would likely need a tree of actions with each
> action bing a separately allocated node, since we have clone() and
> even check_pkt_len() or other actions that can fork the pipeline.
> Or we'll need to use some dummy actions as parethesis, prectically
> emulating what we already have with netlink, but with structures.
> 
> Netlink format is fast to scan, since it's in a single liner chunk
> of memory.  Tree or list structure may have higher memory footprint
> and be slower to iterate due to cache misses.
> 

That's true. Iteration over a number of actions is easy in netlink. And nesting 
easily enables tree-like actions. But in the context of:

 > Structures are not a good approach for modern netlink. use nested attributes 
instead.

If we try to implement all our actions following this way, and we keep just 
copying the incoming actions into the internal representation, we incur in 
unnecessary memory overhead (e.g: storing 2x struct nlaattr + padding of extra 
memory to store 2 integers).

I don't want to derail the discussion into historical or futuristic changes, 
just saying that the approach taken in the SAMPLE action (not including this 
patch) of exposing arguments as attributes but having a kernel-only struct to 
store them seems to me a good compromise.


> There might be a better way to store all this for sure, but will
> require some careful performance and memory consumption testing.
> 
>>
>>>> +		ret = ovs_psample_packet(dp, key, nla_data(next), skb,
>>>> +					 arg->probability);
>>>> +		if (last)
>>>> +			ovs_kfree_skb_reason(skb, OVS_DROP_LAST_ACTION);
>>>> +		if (ret)
>>>> +			return ret;
>>>> +		next = nla_next(next, &rem);
>>>> +	}
>>>> +
>>>> +	if (nla_ok(next, rem)) {
>>>> +		clone_flow_key = !arg->exec;
>>>> +		ret = clone_execute(dp, skb, key, 0, next, rem, last,
>>>> +				    clone_flow_key);
>>>> +	}
>>>> +	return ret;
>>>>    }
>>>>    
>>>>    /* When 'last' is true, clone() should always consume the 'skb'.
>>>> diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
>>>> index 99d72543abd3..b5b560c2e74b 100644
>>>> --- a/net/openvswitch/datapath.c
>>>> +++ b/net/openvswitch/datapath.c
>>>> @@ -976,7 +976,7 @@ static int ovs_flow_cmd_new(struct sk_buff *skb, struct genl_info *info)
>>>>    	struct sw_flow_match match;
>>>>    	u32 ufid_flags = ovs_nla_get_ufid_flags(a[OVS_FLOW_ATTR_UFID_FLAGS]);
>>>>    	int error;
>>>> -	bool log = !a[OVS_FLOW_ATTR_PROBE];
>>>> +	bool log = true;
>>>
>>> Debugging artifact?
>>>
>>
>> Yep, sorry.
>>
>>>>    
>>>>    	/* Must have key and actions. */
>>>>    	error = -EINVAL;
>>>> diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netlink.c
>>>> index f224d9bcea5e..f540686271b7 100644
>>>> --- a/net/openvswitch/flow_netlink.c
>>>> +++ b/net/openvswitch/flow_netlink.c
>>>> @@ -2381,8 +2381,12 @@ static void ovs_nla_free_sample_action(const struct nlattr *action)
>>>>    
>>>>    	switch (nla_type(a)) {
>>>>    	case OVS_SAMPLE_ATTR_ARG:
>>>> -		/* The real list of actions follows this attribute. */
>>>
>>> Please, don't remove this comment.  Maybe extend it instead.
>>>
>>>>    		a = nla_next(a, &rem);
>>>> +
>>>> +		/* OVS_SAMPLE_ATTR_PSAMPLE may be present. */
>>>> +		if (nla_type(a) == OVS_SAMPLE_ATTR_PSAMPLE)
>>>> +			a = nla_next(a, &rem);
>>>> +
>>>>    		ovs_nla_free_nested_actions(a, rem);
>>>>    		break;
>>>>    	}
>>>> @@ -2561,6 +2565,9 @@ static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
>>>>    				  u32 mpls_label_count, bool log,
>>>>    				  u32 depth);
>>>>    
>>>> +static int copy_action(const struct nlattr *from,
>>>> +		       struct sw_flow_actions **sfa, bool log);
>>>> +
>>>>    static int validate_and_copy_sample(struct net *net, const struct nlattr *attr,
>>>>    				    const struct sw_flow_key *key,
>>>>    				    struct sw_flow_actions **sfa,
>>>> @@ -2569,10 +2576,10 @@ static int validate_and_copy_sample(struct net *net, const struct nlattr *attr,
>>>>    				    u32 depth)
>>>>    {
>>>>    	const struct nlattr *attrs[OVS_SAMPLE_ATTR_MAX + 1];
>>>> -	const struct nlattr *probability, *actions;
>>>> +	const struct nlattr *probability, *actions, *psample;
>>>>    	const struct nlattr *a;
>>>> -	int rem, start, err;
>>>>    	struct sample_arg arg;
>>>> +	int rem, start, err;
>>>>    
>>>>    	memset(attrs, 0, sizeof(attrs));
>>>>    	nla_for_each_nested(a, attr, rem) {
>>>> @@ -2589,7 +2596,23 @@ static int validate_and_copy_sample(struct net *net, const struct nlattr *attr,
>>>>    		return -EINVAL;
>>>>    
>>>>    	actions = attrs[OVS_SAMPLE_ATTR_ACTIONS];
>>>> -	if (!actions || (nla_len(actions) && nla_len(actions) < NLA_HDRLEN))
>>>> +	if (actions && (!nla_len(actions) || nla_len(actions) < NLA_HDRLEN))
>>>> +		return -EINVAL;
>>>> +
>>>> +	psample = attrs[OVS_SAMPLE_ATTR_PSAMPLE];
>>>> +	if (psample) {
>>>> +		struct ovs_psample *ovs_ps;
>>>> +
>>>> +		if (!nla_len(psample) || nla_len(psample) < sizeof(*ovs_ps))
>>>> +			return -EINVAL;
>>>> +
>>>> +		ovs_ps = nla_data(psample);
>>>> +		if (ovs_ps->user_cookie_len > OVS_PSAMPLE_COOKIE_MAX_SIZE ||
>>>> +		    nla_len(psample) != sizeof(*ovs_ps) + ovs_ps->user_cookie_len)
>>>> +			return -EINVAL;
>>>> +	}
>>>> +
>>>> +	if (!psample && !actions)
>>>>    		return -EINVAL;
>>>>    
>>>>    	/* validation done, copy sample action. */
>>>> @@ -2608,7 +2631,9 @@ static int validate_and_copy_sample(struct net *net, const struct nlattr *attr,
>>>>    	 * If the sample is the last action, it can always be excuted
>>>>    	 * rather than deferred.
>>>>    	 */
>>>> -	arg.exec = last || !actions_may_change_flow(actions);
>>>> +	if (actions)
>>>> +		arg.exec = last || !actions_may_change_flow(actions);
>>>
>>> 'arg.exec' will remain uninitialized.
>>>
>>
>> Yes. I just wanted to avoid the call to actions_may_change_flow(NULL) in which
>> case arg.exec is not used. I'll make sure to zero-initialize it nevertheless.
>>
>>>> +
>>>>    	arg.probability = nla_get_u32(probability);
>>>>    
>>>>    	err = ovs_nla_add_action(sfa, OVS_SAMPLE_ATTR_ARG, &arg, sizeof(arg),
>>>> @@ -2616,10 +2641,17 @@ static int validate_and_copy_sample(struct net *net, const struct nlattr *attr,
>>>>    	if (err)
>>>>    		return err;
>>>>    
>>>> -	err = __ovs_nla_copy_actions(net, actions, key, sfa,
>>>> -				     eth_type, vlan_tci, mpls_label_count, log,
>>>> -				     depth + 1);
>>>> +	if (psample)
>>>> +		err = ovs_nla_add_action(sfa, OVS_SAMPLE_ATTR_PSAMPLE,
>>>> +					 nla_data(psample), nla_len(psample),
>>>> +					 log);
>>>> +	if (err)
>>>
>>> Can be used uninitialized.
>>>
>>
>> You're right, it should be inside the if above, although err should have been
>> initialized to output of ovs_nla_add_action.
> 
> Ah, I missed the previous assingnent.  But yes, it is still a little strange
> to handle errors this way.
> 
>>
>>>> +		return err;
>>>>    
>>>> +	if (actions)
>>>> +		err = __ovs_nla_copy_actions(net, actions, key, sfa,
>>>> +					     eth_type, vlan_tci,
>>>> +					     mpls_label_count, log, depth + 1);
>>>>    	if (err)
>>>>    		return err;
>>>>    
>>>> @@ -3538,7 +3570,7 @@ static int sample_action_to_attr(const struct nlattr *attr,
>>>>    	struct nlattr *start, *ac_start = NULL, *sample_arg;
>>>>    	int err = 0, rem = nla_len(attr);
>>>>    	const struct sample_arg *arg;
>>>> -	struct nlattr *actions;
>>>> +	struct nlattr *next;
>>>>    
>>>>    	start = nla_nest_start_noflag(skb, OVS_ACTION_ATTR_SAMPLE);
>>>>    	if (!start)
>>>> @@ -3546,27 +3578,39 @@ static int sample_action_to_attr(const struct nlattr *attr,
>>>>    
>>>>    	sample_arg = nla_data(attr);
>>>>    	arg = nla_data(sample_arg);
>>>> -	actions = nla_next(sample_arg, &rem);
>>>> +	next = nla_next(sample_arg, &rem);
>>>>    
>>>>    	if (nla_put_u32(skb, OVS_SAMPLE_ATTR_PROBABILITY, arg->probability)) {
>>>>    		err = -EMSGSIZE;
>>>>    		goto out;
>>>>    	}
>>>>    
>>>> -	ac_start = nla_nest_start_noflag(skb, OVS_SAMPLE_ATTR_ACTIONS);
>>>> -	if (!ac_start) {
>>>> -		err = -EMSGSIZE;
>>>> -		goto out;
>>>> +	if (nla_type(next) == OVS_SAMPLE_ATTR_PSAMPLE) {
>>>> +		if (nla_put(skb, OVS_SAMPLE_ATTR_PSAMPLE, nla_len(next),
>>>> +			    nla_data(next))) {
>>>> +			err = -EMSGSIZE;
>>>> +			goto out;
>>>> +		}
>>>> +		next = nla_next(next, &rem);
>>>>    	}
>>>>    
>>>> -	err = ovs_nla_put_actions(actions, rem, skb);
>>>> +	if (nla_ok(next, rem)) {
>>>> +		ac_start = nla_nest_start_noflag(skb, OVS_SAMPLE_ATTR_ACTIONS);
>>>> +		if (!ac_start) {
>>>> +			err = -EMSGSIZE;
>>>> +			goto out;
>>>> +		}
>>>> +		err = ovs_nla_put_actions(next, rem, skb);
>>>> +	}
>>>>    
>>>>    out:
>>>>    	if (err) {
>>>> -		nla_nest_cancel(skb, ac_start);
>>>> +		if (ac_start)
>>>> +			nla_nest_cancel(skb, ac_start);
>>>>    		nla_nest_cancel(skb, start);
>>>>    	} else {
>>>> -		nla_nest_end(skb, ac_start);
>>>> +		if (ac_start)
>>>> +			nla_nest_end(skb, ac_start);
>>>>    		nla_nest_end(skb, start);
>>>>    	}
>>>>    
>>>
>>
> 


