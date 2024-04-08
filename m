Return-Path: <netdev+bounces-85904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1DB89CCA0
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 21:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD445B266AC
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 19:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3456146000;
	Mon,  8 Apr 2024 19:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ux9WjuOP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AAD1DDD6
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 19:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712605716; cv=none; b=NQ8K+QHXqEYa1VUJRSOSciYNzE0ylnbD5VwddPDG61HmgcNLhVwCYHCT9OgH7wkCou3Hj4I7VcYbJEu12RZpSfFUf5RQxd8QFAUFun9W74k8f/pdFwS/HyllzQLZFaQENGBXldJ3mTihacSdW9UP8RqpiKafS1Ff/aj87Ed8euE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712605716; c=relaxed/simple;
	bh=FH96xakutQrt/hE48IIQLH8wa97XL8YcQANshoyrJmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OS6OZtHZ8Dt/DNa7iqffql8XzWnUgalqi1Oz37qf7wHZhlh9aQWJ/EACXsiTclsFmtPsgZzIl4DzUzjQshvo7mwlbOIq+G5nzdiHRQckB6oGPJtBStOj+hdNG49zKJYxNzH6BaHY028CFZBoCARlgGTGvsTODvIFS/N+/XkS6Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ux9WjuOP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712605713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u5YDi/UIRPWkpg0jbe0Q0OfCIdJAnE7CR/u5EdRlVOM=;
	b=Ux9WjuOPpdo1NZkSBE44qh6GMqaA+Uqqp03gSEmKfM1StWzMdtkpelikKfYrYUCb9HtYzq
	JXPyEy1e5+ZCOMmfhJkTBY3cOccWUkNBPYFedi9vukUouNM+o313kYPYc2rwVU2plno0lI
	BDuvaglDQKH2F93GOI6CMvkqQ0y+Gmo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-vGioAJgFOQur00is84KGsQ-1; Mon, 08 Apr 2024 15:48:31 -0400
X-MC-Unique: vGioAJgFOQur00is84KGsQ-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-78a280c9422so554833285a.2
        for <netdev@vger.kernel.org>; Mon, 08 Apr 2024 12:48:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712605711; x=1713210511;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u5YDi/UIRPWkpg0jbe0Q0OfCIdJAnE7CR/u5EdRlVOM=;
        b=bjf0T/YuIS14LYb3JPbnG8+MppDvp+j1wUBy9LyPbuSpjr4DyFMrjez4bZjB3B8P1O
         3FlmGBEnpDGLOeVYQDE6/O1kMT6oKVHyvo2/fAzx52w1LBH85Ubn6dg9ThJJT7cCdZeo
         5prfmBen3qY20/sJx7fn7w2rqDIE+nnhpeyTWlY7YQq15Ss0rs1AHXk6bq0S69LInIJh
         C5SG+DHfYqZUOXNWnJram3cZpdJEWfEuGAei6TfteYwZL79e7s9p4IX37IHsNCBJzicI
         MJsFkYUonMZs1RlB+jbCXRkN2Y1Rz3zXUuHdRMFbmLNUrYNYlel8256HY9nrvxHRr1by
         4uWg==
X-Forwarded-Encrypted: i=1; AJvYcCWnfkCWQS8IJXN+BoZpr23hl+LudvIaQu1KZcGn5Fpi9mfgtRnlL2QkvHawA+jR2nGRATn+wTU6J6GS0qDkF40wzYxKDMG9
X-Gm-Message-State: AOJu0YweC8wsB2YWhu2mwYW7myhCHmMm6L0xKlbhgNB2ulJGCcZZCYNf
	6WGIAr6kSaxFZuX0WgubMwaf14VBxGe3ArAcJ1lPGlq3/UATWscBVGAeqgKgCqIxms/WVAw8Ce2
	F6zAOcjQXY+WKvRDS8agWpSKiV2fEnOYTv293Fm0FWCPqg75AvrvKgw==
X-Received: by 2002:a05:620a:1a1b:b0:78d:66d9:8ffa with SMTP id bk27-20020a05620a1a1b00b0078d66d98ffamr4122896qkb.26.1712605710965;
        Mon, 08 Apr 2024 12:48:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEE0bAe6+W//PR3QKtt3RSQxPAn8cyVGOznYv9BQmVdOFAl9pUFapF/mq+7tIXvwq0pjJduQ==
X-Received: by 2002:a05:620a:1a1b:b0:78d:66d9:8ffa with SMTP id bk27-20020a05620a1a1b00b0078d66d98ffamr4122871qkb.26.1712605710359;
        Mon, 08 Apr 2024 12:48:30 -0700 (PDT)
Received: from [192.168.1.132] ([193.177.208.51])
        by smtp.gmail.com with ESMTPSA id 3-20020a05620a04c300b0078d60ef9843sm1935288qks.116.2024.04.08.12.48.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 12:48:30 -0700 (PDT)
Message-ID: <ad55dd2d-c07e-4396-a32c-92d7aefe2ef0@redhat.com>
Date: Mon, 8 Apr 2024 21:48:25 +0200
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
Content-Language: en-US
From: Adrian Moreno <amorenoz@redhat.com>
In-Reply-To: <eb44af1d-7514-4084-b022-56f1845b109e@ovn.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/8/24 15:37, Ilya Maximets wrote:
> On 4/8/24 14:57, Adrian Moreno wrote:
>> Add a new attribute to the sample action, called
>> OVS_SAMPLE_ATTR_PSAMPLE to allow userspace to pass a group_id and a
>> user-defined cookie.
>>
>> The maximum length of the user-defined cookie is set to 16, same as
>> tc_cookie to discourage using cookies that will not be offloadable.
>>
>> When set, the sample action will use psample to multicast the sample.
>>
>> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
>> ---
>>   include/uapi/linux/openvswitch.h | 22 +++++++--
>>   net/openvswitch/actions.c        | 52 ++++++++++++++++++---
>>   net/openvswitch/datapath.c       |  2 +-
>>   net/openvswitch/flow_netlink.c   | 78 +++++++++++++++++++++++++-------
>>   4 files changed, 127 insertions(+), 27 deletions(-)
> 
> This cpatch is missing a few bits:
>   - Update for Documentation/netlink/specs/ovs_flow.yaml
>   - Maybe update for tools/testing/selftests/net/openvswitch/ovs-dpctl.py
>   - Maybe some basic selftests.
> 

Absolutely. I surely plan to add it on the first non-rfc version.

>>
>> diff --git a/include/uapi/linux/openvswitch.h b/include/uapi/linux/openvswitch.h
>> index efc82c318fa2..a5a32588f582 100644
>> --- a/include/uapi/linux/openvswitch.h
>> +++ b/include/uapi/linux/openvswitch.h
>> @@ -646,15 +646,24 @@ enum ovs_flow_attr {
>>    * %UINT32_MAX samples all packets and intermediate values sample intermediate
>>    * fractions of packets.
>>    * @OVS_SAMPLE_ATTR_ACTIONS: Set of actions to execute in sampling event.
>> - * Actions are passed as nested attributes.
>> + * Actions are passed as nested attributes. Optional if OVS_SAMPLE_ATTR_PSAMPLE
>> + * is not set.
> 
> 'is set' probably. >
>> + * @OVS_SAMPLE_ATTR_PSAMPLE: Arguments to be passed to psample. Optional if
>> + * OVS_SAMPLE_ATTR_ACTIONS is not set.
> 
> Same here.
>

Good catch, I rewrote those comments a bunch of times and the were left 
expressing the exact opposite!


>>    *
>> - * Executes the specified actions with the given probability on a per-packet
>> - * basis.
>> + * Either OVS_SAMPLE_ATTR_USER_COOKIE or OVS_SAMPLE_ATTR_USER_COOKIE must be
>> + * specified.
>> + *
>> + * Executes the specified actions and/or sends the packet to psample
>> + * with the given probability on a per-packet basis.
>>    */
>>   enum ovs_sample_attr {
>>   	OVS_SAMPLE_ATTR_UNSPEC,
>>   	OVS_SAMPLE_ATTR_PROBABILITY, /* u32 number */
>>   	OVS_SAMPLE_ATTR_ACTIONS,     /* Nested OVS_ACTION_ATTR_* attributes. */
>> +	OVS_SAMPLE_ATTR_PSAMPLE,     /* struct ovs_psample followed
>> +				      * by the user-provided cookie.
>> +				      */
>>   	__OVS_SAMPLE_ATTR_MAX,
>>   
>>   #ifdef __KERNEL__
>> @@ -675,6 +684,13 @@ struct sample_arg {
>>   };
>>   #endif
>>   
>> +#define OVS_PSAMPLE_COOKIE_MAX_SIZE 16
>> +struct ovs_psample {
>> +	__u32 group_id;		/* The group used for packet sampling. */
>> +	__u32 user_cookie_len;	/* The length of the user-provided cookie. */
>> +	__u8 user_cookie[];	/* The user-provided cookie. */
>> +};
> 
> Structures are not a good approach for modern netlink.
> use nested attributes instead.  This way we can also
> eliminate the need for variable-length array and the
> length field, if the length can be taken from a netlink
> attribute directly, e.g. similar to NLA_BINARY in tc.
> 
> If necessary, there could be a structure in the private
> header to store the data for internal use.
> 

Interesting. Thanks for the suggestion. I think it will also help action validation.

>> +
>>   /**
>>    * enum ovs_userspace_attr - Attributes for %OVS_ACTION_ATTR_USERSPACE action.
>>    * @OVS_USERSPACE_ATTR_PID: u32 Netlink PID to which the %OVS_PACKET_CMD_ACTION
>> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
>> index 6fcd7e2ca81f..45d2b325b76a 100644
>> --- a/net/openvswitch/actions.c
>> +++ b/net/openvswitch/actions.c
>> @@ -24,6 +24,7 @@
>>   #include <net/checksum.h>
>>   #include <net/dsfield.h>
>>   #include <net/mpls.h>
>> +#include <net/psample.h>
>>   #include <net/sctp/checksum.h>
>>   
>>   #include "datapath.h"
>> @@ -1025,6 +1026,31 @@ static int dec_ttl_exception_handler(struct datapath *dp, struct sk_buff *skb,
>>   	return 0;
>>   }
>>   
>> +static int ovs_psample_packet(struct datapath *dp, struct sw_flow_key *key,
>> +			      struct ovs_psample *psample, struct sk_buff *skb,
>> +			      u32 rate)
>> +{
>> +	struct psample_group psample_group = {};
>> +	struct psample_metadata md = {};
>> +	struct vport *input_vport;
>> +
>> +	psample_group.group_num = psample->group_id;
>> +	psample_group.net = ovs_dp_get_net(dp);
>> +
>> +	input_vport = ovs_vport_rcu(dp, key->phy.in_port);
>> +	if (!input_vport)
>> +		input_vport = ovs_vport_rcu(dp, OVSP_LOCAL);
>> +
>> +	md.in_ifindex = input_vport->dev->ifindex;
>> +	md.user_cookie = psample->user_cookie;
>> +	md.user_cookie_len = psample->user_cookie_len;
>> +	md.trunc_size = skb->len;
>> +
>> +	psample_sample_packet(&psample_group, skb, rate, &md);
>> +
>> +	return 0;
>> +}
>> +
>>   /* When 'last' is true, sample() should always consume the 'skb'.
>>    * Otherwise, sample() should keep 'skb' intact regardless what
>>    * actions are executed within sample().
>> @@ -1033,16 +1059,17 @@ static int sample(struct datapath *dp, struct sk_buff *skb,
>>   		  struct sw_flow_key *key, const struct nlattr *attr,
>>   		  bool last)
>>   {
>> -	struct nlattr *actions;
>> +	const struct sample_arg *arg;
>>   	struct nlattr *sample_arg;
>>   	int rem = nla_len(attr);
>> -	const struct sample_arg *arg;
>> +	struct nlattr *next;
>>   	bool clone_flow_key;
>> +	int ret;
>>   
>>   	/* The first action is always 'OVS_SAMPLE_ATTR_ARG'. */
>>   	sample_arg = nla_data(attr);
>>   	arg = nla_data(sample_arg);
>> -	actions = nla_next(sample_arg, &rem);
>> +	next = nla_next(sample_arg, &rem);
>>   
>>   	if ((arg->probability != U32_MAX) &&
>>   	    (!arg->probability || get_random_u32() > arg->probability)) {
>> @@ -1051,9 +1078,22 @@ static int sample(struct datapath *dp, struct sk_buff *skb,
>>   		return 0;
>>   	}
>>   
>> -	clone_flow_key = !arg->exec;
>> -	return clone_execute(dp, skb, key, 0, actions, rem, last,
>> -			     clone_flow_key);
>> +	if (next->nla_type == OVS_SAMPLE_ATTR_PSAMPLE) {
> 
> Maybe add a commnet that OVS_SAMPLE_ATTR_PSAMPLE is always a sencond
> argument when present.
> 
> Is there a better way to handle this?
> 

I also dislike it. The fact that actions are not nested but concatenated to 
makes the internal representation a bit flaky.

The alternative I considered was adding the group_id and cookie to the 
internal-only OVS_SAMPLE_ATTR_ARG. However, now I wonder:
- Should we also use nested attributes instead of structs for this internal one?

And, probably off-topic: what's the story behind using netlink attributes to 
store action arguments internally? Has it ever been discussed using a union for 
instance?

>> +		ret = ovs_psample_packet(dp, key, nla_data(next), skb,
>> +					 arg->probability);
>> +		if (last)
>> +			ovs_kfree_skb_reason(skb, OVS_DROP_LAST_ACTION);
>> +		if (ret)
>> +			return ret;
>> +		next = nla_next(next, &rem);
>> +	}
>> +
>> +	if (nla_ok(next, rem)) {
>> +		clone_flow_key = !arg->exec;
>> +		ret = clone_execute(dp, skb, key, 0, next, rem, last,
>> +				    clone_flow_key);
>> +	}
>> +	return ret;
>>   }
>>   
>>   /* When 'last' is true, clone() should always consume the 'skb'.
>> diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
>> index 99d72543abd3..b5b560c2e74b 100644
>> --- a/net/openvswitch/datapath.c
>> +++ b/net/openvswitch/datapath.c
>> @@ -976,7 +976,7 @@ static int ovs_flow_cmd_new(struct sk_buff *skb, struct genl_info *info)
>>   	struct sw_flow_match match;
>>   	u32 ufid_flags = ovs_nla_get_ufid_flags(a[OVS_FLOW_ATTR_UFID_FLAGS]);
>>   	int error;
>> -	bool log = !a[OVS_FLOW_ATTR_PROBE];
>> +	bool log = true;
> 
> Debugging artifact?
> 

Yep, sorry.

>>   
>>   	/* Must have key and actions. */
>>   	error = -EINVAL;
>> diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netlink.c
>> index f224d9bcea5e..f540686271b7 100644
>> --- a/net/openvswitch/flow_netlink.c
>> +++ b/net/openvswitch/flow_netlink.c
>> @@ -2381,8 +2381,12 @@ static void ovs_nla_free_sample_action(const struct nlattr *action)
>>   
>>   	switch (nla_type(a)) {
>>   	case OVS_SAMPLE_ATTR_ARG:
>> -		/* The real list of actions follows this attribute. */
> 
> Please, don't remove this comment.  Maybe extend it instead.
> 
>>   		a = nla_next(a, &rem);
>> +
>> +		/* OVS_SAMPLE_ATTR_PSAMPLE may be present. */
>> +		if (nla_type(a) == OVS_SAMPLE_ATTR_PSAMPLE)
>> +			a = nla_next(a, &rem);
>> +
>>   		ovs_nla_free_nested_actions(a, rem);
>>   		break;
>>   	}
>> @@ -2561,6 +2565,9 @@ static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
>>   				  u32 mpls_label_count, bool log,
>>   				  u32 depth);
>>   
>> +static int copy_action(const struct nlattr *from,
>> +		       struct sw_flow_actions **sfa, bool log);
>> +
>>   static int validate_and_copy_sample(struct net *net, const struct nlattr *attr,
>>   				    const struct sw_flow_key *key,
>>   				    struct sw_flow_actions **sfa,
>> @@ -2569,10 +2576,10 @@ static int validate_and_copy_sample(struct net *net, const struct nlattr *attr,
>>   				    u32 depth)
>>   {
>>   	const struct nlattr *attrs[OVS_SAMPLE_ATTR_MAX + 1];
>> -	const struct nlattr *probability, *actions;
>> +	const struct nlattr *probability, *actions, *psample;
>>   	const struct nlattr *a;
>> -	int rem, start, err;
>>   	struct sample_arg arg;
>> +	int rem, start, err;
>>   
>>   	memset(attrs, 0, sizeof(attrs));
>>   	nla_for_each_nested(a, attr, rem) {
>> @@ -2589,7 +2596,23 @@ static int validate_and_copy_sample(struct net *net, const struct nlattr *attr,
>>   		return -EINVAL;
>>   
>>   	actions = attrs[OVS_SAMPLE_ATTR_ACTIONS];
>> -	if (!actions || (nla_len(actions) && nla_len(actions) < NLA_HDRLEN))
>> +	if (actions && (!nla_len(actions) || nla_len(actions) < NLA_HDRLEN))
>> +		return -EINVAL;
>> +
>> +	psample = attrs[OVS_SAMPLE_ATTR_PSAMPLE];
>> +	if (psample) {
>> +		struct ovs_psample *ovs_ps;
>> +
>> +		if (!nla_len(psample) || nla_len(psample) < sizeof(*ovs_ps))
>> +			return -EINVAL;
>> +
>> +		ovs_ps = nla_data(psample);
>> +		if (ovs_ps->user_cookie_len > OVS_PSAMPLE_COOKIE_MAX_SIZE ||
>> +		    nla_len(psample) != sizeof(*ovs_ps) + ovs_ps->user_cookie_len)
>> +			return -EINVAL;
>> +	}
>> +
>> +	if (!psample && !actions)
>>   		return -EINVAL;
>>   
>>   	/* validation done, copy sample action. */
>> @@ -2608,7 +2631,9 @@ static int validate_and_copy_sample(struct net *net, const struct nlattr *attr,
>>   	 * If the sample is the last action, it can always be excuted
>>   	 * rather than deferred.
>>   	 */
>> -	arg.exec = last || !actions_may_change_flow(actions);
>> +	if (actions)
>> +		arg.exec = last || !actions_may_change_flow(actions);
> 
> 'arg.exec' will remain uninitialized.
> 

Yes. I just wanted to avoid the call to actions_may_change_flow(NULL) in which 
case arg.exec is not used. I'll make sure to zero-initialize it nevertheless.

>> +
>>   	arg.probability = nla_get_u32(probability);
>>   
>>   	err = ovs_nla_add_action(sfa, OVS_SAMPLE_ATTR_ARG, &arg, sizeof(arg),
>> @@ -2616,10 +2641,17 @@ static int validate_and_copy_sample(struct net *net, const struct nlattr *attr,
>>   	if (err)
>>   		return err;
>>   
>> -	err = __ovs_nla_copy_actions(net, actions, key, sfa,
>> -				     eth_type, vlan_tci, mpls_label_count, log,
>> -				     depth + 1);
>> +	if (psample)
>> +		err = ovs_nla_add_action(sfa, OVS_SAMPLE_ATTR_PSAMPLE,
>> +					 nla_data(psample), nla_len(psample),
>> +					 log);
>> +	if (err)
> 
> Can be used uninitialized.
> 

You're right, it should be inside the if above, although err should have been 
initialized to output of ovs_nla_add_action.

>> +		return err;
>>   
>> +	if (actions)
>> +		err = __ovs_nla_copy_actions(net, actions, key, sfa,
>> +					     eth_type, vlan_tci,
>> +					     mpls_label_count, log, depth + 1);
>>   	if (err)
>>   		return err;
>>   
>> @@ -3538,7 +3570,7 @@ static int sample_action_to_attr(const struct nlattr *attr,
>>   	struct nlattr *start, *ac_start = NULL, *sample_arg;
>>   	int err = 0, rem = nla_len(attr);
>>   	const struct sample_arg *arg;
>> -	struct nlattr *actions;
>> +	struct nlattr *next;
>>   
>>   	start = nla_nest_start_noflag(skb, OVS_ACTION_ATTR_SAMPLE);
>>   	if (!start)
>> @@ -3546,27 +3578,39 @@ static int sample_action_to_attr(const struct nlattr *attr,
>>   
>>   	sample_arg = nla_data(attr);
>>   	arg = nla_data(sample_arg);
>> -	actions = nla_next(sample_arg, &rem);
>> +	next = nla_next(sample_arg, &rem);
>>   
>>   	if (nla_put_u32(skb, OVS_SAMPLE_ATTR_PROBABILITY, arg->probability)) {
>>   		err = -EMSGSIZE;
>>   		goto out;
>>   	}
>>   
>> -	ac_start = nla_nest_start_noflag(skb, OVS_SAMPLE_ATTR_ACTIONS);
>> -	if (!ac_start) {
>> -		err = -EMSGSIZE;
>> -		goto out;
>> +	if (nla_type(next) == OVS_SAMPLE_ATTR_PSAMPLE) {
>> +		if (nla_put(skb, OVS_SAMPLE_ATTR_PSAMPLE, nla_len(next),
>> +			    nla_data(next))) {
>> +			err = -EMSGSIZE;
>> +			goto out;
>> +		}
>> +		next = nla_next(next, &rem);
>>   	}
>>   
>> -	err = ovs_nla_put_actions(actions, rem, skb);
>> +	if (nla_ok(next, rem)) {
>> +		ac_start = nla_nest_start_noflag(skb, OVS_SAMPLE_ATTR_ACTIONS);
>> +		if (!ac_start) {
>> +			err = -EMSGSIZE;
>> +			goto out;
>> +		}
>> +		err = ovs_nla_put_actions(next, rem, skb);
>> +	}
>>   
>>   out:
>>   	if (err) {
>> -		nla_nest_cancel(skb, ac_start);
>> +		if (ac_start)
>> +			nla_nest_cancel(skb, ac_start);
>>   		nla_nest_cancel(skb, start);
>>   	} else {
>> -		nla_nest_end(skb, ac_start);
>> +		if (ac_start)
>> +			nla_nest_end(skb, ac_start);
>>   		nla_nest_end(skb, start);
>>   	}
>>   
> 

-- 
Adrián Moreno


