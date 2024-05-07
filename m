Return-Path: <netdev+bounces-94144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2B08BE5B3
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 16:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAE371F26156
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 14:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8551015FCE1;
	Tue,  7 May 2024 14:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BTtewwa/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEE815FCE8
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 14:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715091491; cv=none; b=UEU2SyDoT4YbbUji3Ur2tNr0CqpHIUlKxv7ohih9cXW86g2gomP2/ZCVPKDxK98Wdusjojee2wV3Pg9AWpLMhzvzDn3lnzWx3Nht4KViMD9n9plWqS2R/q8CKplemjO8/cO443si84xv8JEKSoH1adYA6/7iVn7nKK/PGn5Ssqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715091491; c=relaxed/simple;
	bh=GEOUBCkdWdkVUanW3YXKSTvCsEN166531Bdu8wFoqAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fVlRDjvpQ7LA4NdS3SAs53m55AIX87+lf7RDWvnIUa+jXrxWxEgoHGMbKrHFuUM8RtIbhcEHBGVyNUyx/F+MVvD9hPOpnMvPD9uKva6OS5xvvGBQFWAAEvpHjeDmAe59MBjGP6C0TcTduaLWjUWRdv9OsMiuXo+lwZdSLAw+53o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BTtewwa/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715091488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LcAsqHQw/OCz7FQ6iOt/s7wDjmqYvAKgLsN/DOzRL8E=;
	b=BTtewwa/lSga0fMJdCLbIO1Dsc/joNr8jL6DdpWdgPh77rQWmZHrVjRP+Bbxft+q+1OKx7
	1uH8JtF02ZINQl2a2jq1pJi2mxyJ3qpmqqFydnis/cr4ptDk9eupxB+95DD761WmxiOCJP
	G50SKduuCFXoMWGnbcXPAd7/BbIL0S4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-8p_emOnjPhmBS-5vGe9eiA-1; Tue, 07 May 2024 10:18:07 -0400
X-MC-Unique: 8p_emOnjPhmBS-5vGe9eiA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-34d91608deaso2210361f8f.0
        for <netdev@vger.kernel.org>; Tue, 07 May 2024 07:18:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715091486; x=1715696286;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LcAsqHQw/OCz7FQ6iOt/s7wDjmqYvAKgLsN/DOzRL8E=;
        b=cPMG9YBvBO8icQrF5FRtfAVpDuVi7VSOTaYmqbohgkqQzrLzV+2OeWZYbibgi3p530
         fhJBS8gh9t7GOkZepI6gAjsbJwoTw8uWPshrdHrWiQYUPbvdqBPV7mQ0wPHb+DZ+jGOf
         MutP+PtNbCXHhCR1CtyT7+ympMcz6vOq2NNmqLiNhEFklzcA/lmbm0RWcSpHPN5VM7HV
         OXsUoxNO0O2nxityC4TB1NHnX/5F2nTBeeVQOH7Uh/5dGG0zoNqBZBcdUpClB1PsLThg
         xraQ5+xZTgC3MeEiPmzrtS0m7Db7xtNcxJ75ndcq6yWSgW4bLfAkFlesvhz2HgaC8lj1
         iPCw==
X-Gm-Message-State: AOJu0Yx1V0A6ky+ZaJ1lBAt+Crryy6xtsdMBpl6JDF8Jv8kx6hz9vTh6
	PzZJwsp/ufizFvqBcOEp67Me+3qLihdlznYADjB0ZaiT67JdIReMrK5dK3+oy9pHKT7D9qScwzq
	NULWAbhuv64HgyMS7jF/YQWroyJwaZ5AsHiKf3JDOhgcpV/EFTqicIg==
X-Received: by 2002:a5d:5708:0:b0:346:85a0:20a4 with SMTP id a8-20020a5d5708000000b0034685a020a4mr10414568wrv.34.1715091485678;
        Tue, 07 May 2024 07:18:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF98SBdbi8rahP4j7Ag6Gr2b7Ye9zOX3rnV9z+K4NUk511IhvJFk+Tj5zTFA3oi/L1O0eR+NQ==
X-Received: by 2002:a5d:5708:0:b0:346:85a0:20a4 with SMTP id a8-20020a5d5708000000b0034685a020a4mr10414549wrv.34.1715091485170;
        Tue, 07 May 2024 07:18:05 -0700 (PDT)
Received: from [192.168.1.137] ([193.177.210.114])
        by smtp.gmail.com with ESMTPSA id c16-20020adffb10000000b0034f0633e322sm5973731wrr.38.2024.05.07.07.18.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 07:18:04 -0700 (PDT)
Message-ID: <5f516a72-d406-49bf-98a0-0f1ade8a0d50@redhat.com>
Date: Tue, 7 May 2024 16:18:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 6/8] net:openvswitch: add psample support
To: Eelco Chaudron <echaudro@redhat.com>
Cc: netdev@vger.kernel.org, aconole@redhat.com, horms@kernel.org,
 i.maximets@ovn.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Pravin B Shelar <pshelar@ovn.org>,
 Donald Hunter <donald.hunter@gmail.com>, linux-kernel@vger.kernel.org,
 dev@openvswitch.org
References: <20240424135109.3524355-1-amorenoz@redhat.com>
 <20240424135109.3524355-7-amorenoz@redhat.com>
 <72F692D6-621D-4E02-AAE2-AC63CC99FEBE@redhat.com>
Content-Language: en-US
From: Adrian Moreno <amorenoz@redhat.com>
In-Reply-To: <72F692D6-621D-4E02-AAE2-AC63CC99FEBE@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/3/24 11:43 AM, Eelco Chaudron wrote:
> 
> 
> On 24 Apr 2024, at 15:50, Adrian Moreno wrote:
> 
>> Add support for psample sampling via two new attributes to the
>> OVS_ACTION_ATTR_SAMPLE action.
>>
>> OVS_SAMPLE_ATTR_PSAMPLE_GROUP used to pass an integer psample group_id.
>> OVS_SAMPLE_ATTR_PSAMPLE_COOKIE used to pass a variable-length binary
>> cookie that will be forwared to psample.
>>
>> The maximum length of the user-defined cookie is set to 16, same as
>> tc_cookie, to discourage using cookies that will not be offloadable.
>>
>> In order to simplify the internal processing of the action and given the
>> maximum size of the cookie is relatively small, add both fields to the
>> internal-only struct sample_arg.
>>
>> The presence of a group_id mandates that the action shall called the
>> psample module to multicast the packet with such group_id and the
>> user-provided cookie if present. This behavior is orthonogal to
>> also executing the nested actions if present.
>>
>> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> 
> This is not a full review yet. Just some comments, as I’m looking at the user-space patch first and added similar comments.
> 
> I’ll do a proper review of this series once I’m done with user-space part.
> 
> //Eelco
> 
>> ---
>>   Documentation/netlink/specs/ovs_flow.yaml |  6 ++
>>   include/uapi/linux/openvswitch.h          | 49 ++++++++++----
>>   net/openvswitch/actions.c                 | 51 +++++++++++++--
>>   net/openvswitch/flow_netlink.c            | 80 ++++++++++++++++++-----
>>   4 files changed, 153 insertions(+), 33 deletions(-)
>>
>> diff --git a/Documentation/netlink/specs/ovs_flow.yaml b/Documentation/netlink/specs/ovs_flow.yaml
>> index 4fdfc6b5cae9..5543c2937225 100644
>> --- a/Documentation/netlink/specs/ovs_flow.yaml
>> +++ b/Documentation/netlink/specs/ovs_flow.yaml
>> @@ -825,6 +825,12 @@ attribute-sets:
>>           name: actions
>>           type: nest
>>           nested-attributes: action-attrs
>> +      -
>> +        name: psample_group
>> +        type: u32
>> +      -
>> +        name: psample_cookie
>> +        type: binary
>>     -
>>       name: userspace-attrs
>>       enum-name: ovs-userspace-attr
>> diff --git a/include/uapi/linux/openvswitch.h b/include/uapi/linux/openvswitch.h
>> index efc82c318fa2..e9cd6f3a952d 100644
>> --- a/include/uapi/linux/openvswitch.h
>> +++ b/include/uapi/linux/openvswitch.h
>> @@ -639,6 +639,7 @@ enum ovs_flow_attr {
>>   #define OVS_UFID_F_OMIT_MASK     (1 << 1)
>>   #define OVS_UFID_F_OMIT_ACTIONS  (1 << 2)
>>
>> +#define OVS_PSAMPLE_COOKIE_MAX_SIZE 16
>>   /**
>>    * enum ovs_sample_attr - Attributes for %OVS_ACTION_ATTR_SAMPLE action.
>>    * @OVS_SAMPLE_ATTR_PROBABILITY: 32-bit fraction of packets to sample with
>> @@ -646,15 +647,27 @@ enum ovs_flow_attr {
>>    * %UINT32_MAX samples all packets and intermediate values sample intermediate
>>    * fractions of packets.
>>    * @OVS_SAMPLE_ATTR_ACTIONS: Set of actions to execute in sampling event.
>> - * Actions are passed as nested attributes.
>> + * Actions are passed as nested attributes. Optional if
>> + * OVS_SAMPLE_ATTR_PSAMPLE_GROUP is set.
>> + * @OVS_SAMPLE_ATTR_PSAMPLE_GROUP: A 32-bit number to be used as psample group.
>> + * Optional if OVS_SAMPLE_ATTR_ACTIONS is set.
>> + * @OVS_SAMPLE_ATTR_PSAMPLE_COOKIE: A variable-length binary cookie that, if
>> + * provided, will be copied to the psample cookie.
> 
> As there is a limit of to the cookie should we mention it here?
> 

I thought OVS_PSAMPLE_COOKIE_MAX_SIZE was expressive enough but sure, we can 
also mention it here.

>>    *
>> - * Executes the specified actions with the given probability on a per-packet
>> - * basis.
>> + * Either OVS_SAMPLE_ATTR_PSAMPLE_GROUP or OVS_SAMPLE_ATTR_ACTIONS must be
>> + * specified.
>> + *
>> + * Executes the specified actions and/or sends the packet to psample
>> + * with the given probability on a per-packet basis.
>>    */
>>   enum ovs_sample_attr {
>>   	OVS_SAMPLE_ATTR_UNSPEC,
>> -	OVS_SAMPLE_ATTR_PROBABILITY, /* u32 number */
>> -	OVS_SAMPLE_ATTR_ACTIONS,     /* Nested OVS_ACTION_ATTR_* attributes. */
>> +	OVS_SAMPLE_ATTR_PROBABILITY,	/* u32 number */
>> +	OVS_SAMPLE_ATTR_ACTIONS,	/* Nested OVS_ACTION_ATTR_
> 
> Missing * after OVS_ACTION_ATTR_

As a matter of fact, adding an * makes checkpatch generate a warning IIRC. 
That's why I initially removed it. I can look at fixing checkpatch instead.

> 
>> +					 * attributes.
>> +					 */
>> +	OVS_SAMPLE_ATTR_PSAMPLE_GROUP,	/* u32 number */
>> +	OVS_SAMPLE_ATTR_PSAMPLE_COOKIE,	/* binary */
> 
> As these are general sample options, I would not add the PSAMPLE reference. Other data paths could use a different implementation. So I guess OVS_SAMPLE_ATTR_GROUP_ID and OVS_SAMPLE_ATTR_COOKIE would be enough.
> 

OK. But isn't the API already psample-ish? I mean that the group_id is something 
specific to psample that might not be present in other datapath implementation.


>>   	__OVS_SAMPLE_ATTR_MAX,
>>
>>   #ifdef __KERNEL__
>> @@ -665,13 +678,27 @@ enum ovs_sample_attr {
>>   #define OVS_SAMPLE_ATTR_MAX (__OVS_SAMPLE_ATTR_MAX - 1)
>>
>>   #ifdef __KERNEL__
>> +
>> +/* Definition for flags in struct sample_arg. */
>> +enum {
>> +	/* When set, actions in sample will not change the flows. */
>> +	OVS_SAMPLE_ARG_FLAG_EXEC = 1 << 0,
>> +	/* When set, the packet will be sent to psample. */
>> +	OVS_SAMPLE_ARG_FLAG_PSAMPLE = 1 << 1,
>> +};
>> +
>>   struct sample_arg {
>> -	bool exec;                   /* When true, actions in sample will not
>> -				      * change flow keys. False otherwise.
>> -				      */
>> -	u32  probability;            /* Same value as
>> -				      * 'OVS_SAMPLE_ATTR_PROBABILITY'.
>> -				      */
> 
> 
> Not sure if you can actually do this, you are changing a structure that is part of the UAPI. This change breaks backwards compatibility.
> 

Hmmm... this the internal argument structure protected by #ifdef __KERNEL__. It 
is used in several actions to optimize the internal action handling (i.e: using 
a compact struct instead of a list of netlink attributes). I guess the reason 
for having it in this file is because the attribute enum is being reused, but I 
wouldn't think of this struct as part of the uAPI.

If the (#ifdef __KERNEL__) does not exclude this struct from the uAPI I think we 
should move it (all of them actually) to some internal file.


> 
>> +	u16 flags;		/* Flags that modify the behavior of the
>> +				 * action. See SAMPLE_ARG_FLAG_*.
>> +				 */
>> +	u32  probability;       /* Same value as
>> +				 * 'OVS_SAMPLE_ATTR_PROBABILITY'.
>> +				 */
>> +	u32  group_id;		/* Same value as
>> +				 * 'OVS_SAMPLE_ATTR_PSAMPLE_GROUP'.
>> +				 */
>> +	u8  cookie_len;		/* Length of psample cookie. */
>> +	char cookie[OVS_PSAMPLE_COOKIE_MAX_SIZE]; /* psample cookie data. */
> 
> Would it make sense for the cookie also to be u8?
> 

Yes, probably.

>>   };
>>   #endif
>>
>> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
>> index 6fcd7e2ca81f..eb3166986fd2 100644
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
>> @@ -1025,6 +1026,34 @@ static int dec_ttl_exception_handler(struct datapath *dp, struct sk_buff *skb,
>>   	return 0;
>>   }
>>
>> +static int ovs_psample_packet(struct datapath *dp, struct sw_flow_key *key,
>> +			      const struct sample_arg *arg,
>> +			      struct sk_buff *skb)
>> +{
>> +	struct psample_group psample_group = {};
>> +	struct psample_metadata md = {};
>> +	struct vport *input_vport;
>> +	u32 rate;
>> +
>> +	psample_group.group_num = arg->group_id;
>> +	psample_group.net = ovs_dp_get_net(dp);
>> +
>> +	input_vport = ovs_vport_rcu(dp, key->phy.in_port);
>> +	if (!input_vport)
>> +		input_vport = ovs_vport_rcu(dp, OVSP_LOCAL);
>> +
>> +	md.in_ifindex = input_vport->dev->ifindex;
>> +	md.user_cookie = arg->cookie_len ? &arg->cookie[0] : NULL;
>> +	md.user_cookie_len = arg->cookie_len;
>> +	md.trunc_size = skb->len;
>> +
>> +	rate = arg->probability ? U32_MAX / arg->probability : 0;
>> +
>> +	psample_sample_packet(&psample_group, skb, rate, &md);
> 
> Does this mean now the ovs module, now is dependent on the presence of psample? I think we should only support sampling to psample if the module exists, else we should return an error. There might be distributions not including psample by default.

Agree. I'll add some compile-time checks the same way we do with nf_nat.

> 
>> +
>> +	return 0;
>> +}
>> +
>>   /* When 'last' is true, sample() should always consume the 'skb'.
>>    * Otherwise, sample() should keep 'skb' intact regardless what
>>    * actions are executed within sample().
>> @@ -1033,11 +1062,12 @@ static int sample(struct datapath *dp, struct sk_buff *skb,
>>   		  struct sw_flow_key *key, const struct nlattr *attr,
>>   		  bool last)
>>   {
>> -	struct nlattr *actions;
>> +	const struct sample_arg *arg;
>>   	struct nlattr *sample_arg;
>>   	int rem = nla_len(attr);
>> -	const struct sample_arg *arg;
>> +	struct nlattr *actions;
>>   	bool clone_flow_key;
>> +	int ret;
>>
>>   	/* The first action is always 'OVS_SAMPLE_ATTR_ARG'. */
>>   	sample_arg = nla_data(attr);
>> @@ -1051,9 +1081,20 @@ static int sample(struct datapath *dp, struct sk_buff *skb,
>>   		return 0;
>>   	}
>>
>> -	clone_flow_key = !arg->exec;
>> -	return clone_execute(dp, skb, key, 0, actions, rem, last,
>> -			     clone_flow_key);
>> +	if (arg->flags & OVS_SAMPLE_ARG_FLAG_PSAMPLE) {
>> +		ret = ovs_psample_packet(dp, key, arg, skb);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	if (nla_ok(actions, rem)) {
>> +		clone_flow_key = !(arg->flags & OVS_SAMPLE_ARG_FLAG_EXEC);
>> +		ret = clone_execute(dp, skb, key, 0, actions, rem, last,
>> +				    clone_flow_key);
>> +	} else if (last) {
>> +		ovs_kfree_skb_reason(skb, OVS_DROP_LAST_ACTION);
>> +	}
>> +	return ret;
>>   }
>>
>>   /* When 'last' is true, clone() should always consume the 'skb'.
>> diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netlink.c
>> index f224d9bcea5e..1a348d3905fc 100644
>> --- a/net/openvswitch/flow_netlink.c
>> +++ b/net/openvswitch/flow_netlink.c
>> @@ -2561,6 +2561,9 @@ static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
>>   				  u32 mpls_label_count, bool log,
>>   				  u32 depth);
>>
>> +static int copy_action(const struct nlattr *from,
>> +		       struct sw_flow_actions **sfa, bool log);
>> +
>>   static int validate_and_copy_sample(struct net *net, const struct nlattr *attr,
>>   				    const struct sw_flow_key *key,
>>   				    struct sw_flow_actions **sfa,
>> @@ -2569,10 +2572,10 @@ static int validate_and_copy_sample(struct net *net, const struct nlattr *attr,
>>   				    u32 depth)
>>   {
>>   	const struct nlattr *attrs[OVS_SAMPLE_ATTR_MAX + 1];
>> -	const struct nlattr *probability, *actions;
>> +	const struct nlattr *probability, *actions, *group, *cookie;
>> +	struct sample_arg arg = {};
>>   	const struct nlattr *a;
>>   	int rem, start, err;
>> -	struct sample_arg arg;
>>
>>   	memset(attrs, 0, sizeof(attrs));
>>   	nla_for_each_nested(a, attr, rem) {
>> @@ -2589,7 +2592,19 @@ static int validate_and_copy_sample(struct net *net, const struct nlattr *attr,
>>   		return -EINVAL;
>>
>>   	actions = attrs[OVS_SAMPLE_ATTR_ACTIONS];
>> -	if (!actions || (nla_len(actions) && nla_len(actions) < NLA_HDRLEN))
>> +	if (actions && (!nla_len(actions) || nla_len(actions) < NLA_HDRLEN))
>> +		return -EINVAL;
>> +
>> +	group = attrs[OVS_SAMPLE_ATTR_PSAMPLE_GROUP];
>> +	if (group && nla_len(group) != sizeof(u32))
>> +		return -EINVAL;
>> +
>> +	cookie = attrs[OVS_SAMPLE_ATTR_PSAMPLE_COOKIE];
>> +	if (cookie &&
>> +	    (!group || nla_len(cookie) > OVS_PSAMPLE_COOKIE_MAX_SIZE))
>> +		return -EINVAL;
>> +
>> +	if (!group && !actions)
>>   		return -EINVAL;
>>
>>   	/* validation done, copy sample action. */
>> @@ -2608,7 +2623,19 @@ static int validate_and_copy_sample(struct net *net, const struct nlattr *attr,
>>   	 * If the sample is the last action, it can always be excuted
>>   	 * rather than deferred.
>>   	 */
>> -	arg.exec = last || !actions_may_change_flow(actions);
>> +	if (actions && (last || !actions_may_change_flow(actions)))
>> +		arg.flags |= OVS_SAMPLE_ARG_FLAG_EXEC;
>> +
>> +	if (group) {
>> +		arg.flags |= OVS_SAMPLE_ARG_FLAG_PSAMPLE;
>> +		arg.group_id = nla_get_u32(group);
>> +	}
>> +
>> +	if (cookie) {
>> +		memcpy(&arg.cookie[0], nla_data(cookie), nla_len(cookie));
>> +		arg.cookie_len = nla_len(cookie);
>> +	}
>> +
>>   	arg.probability = nla_get_u32(probability);
>>
>>   	err = ovs_nla_add_action(sfa, OVS_SAMPLE_ATTR_ARG, &arg, sizeof(arg),
>> @@ -2616,12 +2643,13 @@ static int validate_and_copy_sample(struct net *net, const struct nlattr *attr,
>>   	if (err)
>>   		return err;
>>
>> -	err = __ovs_nla_copy_actions(net, actions, key, sfa,
>> -				     eth_type, vlan_tci, mpls_label_count, log,
>> -				     depth + 1);
>> -
>> -	if (err)
>> -		return err;
>> +	if (actions) {
>> +		err = __ovs_nla_copy_actions(net, actions, key, sfa,
>> +					     eth_type, vlan_tci,
>> +					     mpls_label_count, log, depth + 1);
>> +		if (err)
>> +			return err;
>> +	}
>>
>>   	add_nested_action_end(*sfa, start);
>>
>> @@ -3553,20 +3581,38 @@ static int sample_action_to_attr(const struct nlattr *attr,
>>   		goto out;
>>   	}
>>
>> -	ac_start = nla_nest_start_noflag(skb, OVS_SAMPLE_ATTR_ACTIONS);
>> -	if (!ac_start) {
>> -		err = -EMSGSIZE;
>> -		goto out;
>> +	if (arg->flags & OVS_SAMPLE_ARG_FLAG_PSAMPLE) {
>> +		if (nla_put_u32(skb, OVS_SAMPLE_ATTR_PSAMPLE_GROUP,
>> +				arg->group_id)) {
>> +			err = -EMSGSIZE;
>> +			goto out;
>> +		}
>> +
>> +		if (arg->cookie_len &&
>> +		    nla_put(skb, OVS_SAMPLE_ATTR_PSAMPLE_COOKIE,
>> +			    arg->cookie_len, &arg->cookie[0])) {
>> +			err = -EMSGSIZE;
>> +			goto out;
>> +		}
>>   	}
>>
>> -	err = ovs_nla_put_actions(actions, rem, skb);
>> +	if (nla_ok(actions, rem)) {
>> +		ac_start = nla_nest_start_noflag(skb, OVS_SAMPLE_ATTR_ACTIONS);
>> +		if (!ac_start) {
>> +			err = -EMSGSIZE;
>> +			goto out;
>> +		}
>> +		err = ovs_nla_put_actions(actions, rem, skb);
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
>> -- 
>> 2.44.0
> 


