Return-Path: <netdev+bounces-86601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6765E89F45A
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 15:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2C761F217CD
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 13:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B6115ADBF;
	Wed, 10 Apr 2024 13:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DfNxFypJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102F615B140
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 13:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712755980; cv=none; b=jqIO2WfuJ7bD7IxrB8EG7O3RNE1a3BTXznxNvSW3zKzIieI3h/MVzwmxft6SoS4n5GV/QA35jKxEMh9bitNiGBt2uKqolEclSX8Y5qMbQkVmgSSfhqIEklNH0A3+ip/8LS/PZOOFqsNhu9+gx4X89Oe9RazE7UCwbHS0vKtanFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712755980; c=relaxed/simple;
	bh=bp14umFp5wIcfHcECiZ8yMelL8Bt3WZGGxjX/Ip+AZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D8kXxgmTWxXwUEFkvpWlJH9FJInuxDy/IUY5ZCEu3kv2WJQOJ9zfY1eGg5mVWixMxP0uNfmMWqrYUlBxzrIhxSm5Qdd7zD8Ah3NHRke/HN1w4IWUJLbR/O5AERjZ1YMvgTidhpuC5Uw1SCUJg5ljFJ14F4fH6sDsxuiUBRp4eYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DfNxFypJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712755976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v94gfPwisd6An8fRX0kscIjSM/ibORdquufHHAeWewo=;
	b=DfNxFypJnlrhRDp3y2dlC3mXkZsNTTe1auK+P2U6pmaM4Dqo8rkSzdMEGIm+M0W7k+7n1x
	GmbU8swujJ+O2SrC9SJflHyLNX2k7QZ2AEkx+d9gkfxsKYcdnb/kJMfQ1GF67V5wu+/zRy
	YrpqTDokPEn6R99m2eXAysg0BaZZEdg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-ruaf5Cq1PPWnou0vO-KC2Q-1; Wed, 10 Apr 2024 09:32:55 -0400
X-MC-Unique: ruaf5Cq1PPWnou0vO-KC2Q-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-430cff75f9bso88316501cf.2
        for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 06:32:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712755974; x=1713360774;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v94gfPwisd6An8fRX0kscIjSM/ibORdquufHHAeWewo=;
        b=q3F88tttiwO4zbMJ8pzh8psX3JzZBXEBznis8KQhLKjvg4LVT0GPqORGOBRfc8yoQ8
         YM5HRiJQ0sfrdV/ZorTFmhRaSVPVxiWBeZ6tyPf/sFUWjm1dPphBs6yG9ShWCZeho/wb
         smKCOTvTu56nM+GCZIiaog395wH6U0ZLAe5bKWv8pNkEqk8wRv/NwcCrJNlwp1Aur7GL
         Fpn4j3kF9G+pLu7QdLnMfAHQ6RQ5rbnewpLZDzrCTpHpSdQB2etnn70YV4yIhsExpcdQ
         nZIWgxYJjCiKdxHYHxDcoSgazeuBOSr2luKutPCUUfWmMu9Ov68DkY7L+qs89prcB+Gl
         et5A==
X-Forwarded-Encrypted: i=1; AJvYcCU/AVO2JyJJsiBRd1JyjV2LrA77rMUOzGejZIYu+hrWUqa+T8LwhXxMUZH+KCCBmTTDvnQVkG1q7itKQAcFdz5t5X345CJb
X-Gm-Message-State: AOJu0YzAbPvCTsBa4mAorlxqTgJyiIOI6z2jiZKQ4E9B2x852WJ1n1by
	Vo/HUF2CGZGP4PBv2LhJx3AvV6j1U9CsOPIMorWdmv1luFUivXLI2wQp+u26GbRO4DLSNWdO1NU
	Ua3uRyQ+Op6EUsCHOBC1BeUUXUF8YYDCnYymXwuEf19SR66pqCJ9aDg==
X-Received: by 2002:a05:622a:1a9a:b0:434:8117:f36b with SMTP id s26-20020a05622a1a9a00b004348117f36bmr3558078qtc.21.1712755973722;
        Wed, 10 Apr 2024 06:32:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvY2vJwQQUkpMlvTHN5qJhxtNarIt+Cq+oXtFN5nm+fl0kKtkUswhZmCeX/ZTBmBf2C1HZCA==
X-Received: by 2002:a05:622a:1a9a:b0:434:8117:f36b with SMTP id s26-20020a05622a1a9a00b004348117f36bmr3558053qtc.21.1712755973373;
        Wed, 10 Apr 2024 06:32:53 -0700 (PDT)
Received: from [192.168.1.132] ([193.177.208.51])
        by smtp.gmail.com with ESMTPSA id e8-20020ac86708000000b0043496bcfc2esm3309582qtp.12.2024.04.10.06.32.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 06:32:52 -0700 (PDT)
Message-ID: <143cf81c-d850-43c4-96b4-4fef840703b7@redhat.com>
Date: Wed, 10 Apr 2024 15:32:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next v2 2/5] net: psample: add multicast filtering on
 group_id
To: Aaron Conole <aconole@redhat.com>
Cc: Ilya Maximets <i.maximets@ovn.org>, netdev@vger.kernel.org,
 jiri@resnulli.us, xiyou.wangcong@gmail.com, cmi@nvidia.com,
 yotam.gi@gmail.com, echaudro@redhat.com, horms@kernel.org
References: <20240408125753.470419-1-amorenoz@redhat.com>
 <20240408125753.470419-3-amorenoz@redhat.com>
 <2b79ebe9-4e83-418a-ae40-93024a3fb433@ovn.org>
 <801ccf5c-5ac9-455f-8d9a-48517d7db614@redhat.com>
 <f7til0qmwar.fsf@redhat.com>
Content-Language: en-US
From: Adrian Moreno <amorenoz@redhat.com>
In-Reply-To: <f7til0qmwar.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/9/24 16:43, Aaron Conole wrote:
> Adrian Moreno <amorenoz@redhat.com> writes:
> 
>> On 4/8/24 15:18, Ilya Maximets wrote:
>>> [copying my previous reply since this version actually has netdev@ in Cc]
>>> On 4/8/24 14:57, Adrian Moreno wrote:
>>>> Packet samples can come from several places (e.g: different tc sample
>>>> actions), typically using the sample group (PSAMPLE_ATTR_SAMPLE_GROUP)
>>>> to differentiate them.
>>>>
>>>> Likewise, sample consumers that listen on the multicast group may only
>>>> be interested on a single group. However, they are currently forced to
>>>> receive all samples and discard the ones that are not relevant, causing
>>>> unnecessary overhead.
>>>>
>>>> Allow users to filter on the desired group_id by adding a new command
>>>> SAMPLE_FILTER_SET that can be used to pass the desired group id.
>>>> Store this filter on the per-socket private pointer and use it for
>>>> filtering multicasted samples.
>>>>
>>>> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
>>>> ---
>>>>    include/uapi/linux/psample.h |   1 +
>>>>    net/psample/psample.c        | 127 +++++++++++++++++++++++++++++++++--
>>>>    2 files changed, 122 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/include/uapi/linux/psample.h b/include/uapi/linux/psample.h
>>>> index e585db5bf2d2..5e0305b1520d 100644
>>>> --- a/include/uapi/linux/psample.h
>>>> +++ b/include/uapi/linux/psample.h
>>>> @@ -28,6 +28,7 @@ enum psample_command {
>>>>    	PSAMPLE_CMD_GET_GROUP,
>>>>    	PSAMPLE_CMD_NEW_GROUP,
>>>>    	PSAMPLE_CMD_DEL_GROUP,
>>>> +	PSAMPLE_CMD_SAMPLE_FILTER_SET,
>>> Other commands are names as PSAMPLE_CMD_VERB_NOUN, so this new one
>>> should be PSAMPLE_CMD_SET_FILTER.  (The SAMPLE part seems unnecessary.)
>>> Some functions/structures need to be renamed accordingly.
>>>
>>
>> Sure, I'll rename it when I sent the next version.
>>
>>>>    };
>>>>      enum psample_tunnel_key_attr {
>>>> diff --git a/net/psample/psample.c b/net/psample/psample.c
>>>> index a5d9b8446f77..a0cef63dfdec 100644
>>>> --- a/net/psample/psample.c
>>>> +++ b/net/psample/psample.c
>>>> @@ -98,13 +98,84 @@ static int psample_nl_cmd_get_group_dumpit(struct sk_buff *msg,
>>>>    	return msg->len;
>>>>    }
>>>>    -static const struct genl_small_ops psample_nl_ops[] = {
>>>> +struct psample_obj_desc {
>>>> +	struct rcu_head rcu;
>>>> +	u32 group_num;
>>>> +	bool group_num_valid;
>>>> +};
>>>> +
>>>> +struct psample_nl_sock_priv {
>>>> +	struct psample_obj_desc __rcu *flt;
>>> Can we call it 'fileter' ?  I find it hard to read the code with
>>> this unnecessary abbreviation.  Same for the lock below.
>>>
>>
>> Sure.
>>
>>>> +	spinlock_t flt_lock; /* Protects flt. */
>>>> +};
>>>> +
>>>> +static void psample_nl_sock_priv_init(void *priv)
>>>> +{
>>>> +	struct psample_nl_sock_priv *sk_priv = priv;
>>>> +
>>>> +	spin_lock_init(&sk_priv->flt_lock);
>>>> +}
>>>> +
>>>> +static void psample_nl_sock_priv_destroy(void *priv)
>>>> +{
>>>> +	struct psample_nl_sock_priv *sk_priv = priv;
>>>> +	struct psample_obj_desc *flt;
>>>> +
>>>> +	flt = rcu_dereference_protected(sk_priv->flt, true);
>>>> +	kfree_rcu(flt, rcu);
>>>> +}
>>>> +
>>>> +static int psample_nl_sample_filter_set_doit(struct sk_buff *skb,
>>>> +					     struct genl_info *info)
>>>> +{
>>>> +	struct psample_nl_sock_priv *sk_priv;
>>>> +	struct nlattr **attrs = info->attrs;
>>>> +	struct psample_obj_desc *flt;
>>>> +
>>>> +	flt = kzalloc(sizeof(*flt), GFP_KERNEL);
>>>> +
>>>> +	if (attrs[PSAMPLE_ATTR_SAMPLE_GROUP]) {
>>>> +		flt->group_num = nla_get_u32(attrs[PSAMPLE_ATTR_SAMPLE_GROUP]);
>>>> +		flt->group_num_valid = true;
>>>> +	}
>>>> +
>>>> +	if (!flt->group_num_valid) {
>>>> +		kfree(flt);
>>> Might be better to not allocate it in the first place.
>>>
>>
>> Absolutely.
>>
>>>> +		flt = NULL;
>>>> +	}
>>>> +
>>>> +	sk_priv = genl_sk_priv_get(&psample_nl_family, NETLINK_CB(skb).sk);
>>>> +	if (IS_ERR(sk_priv)) {
>>>> +		kfree(flt);
>>>> +		return PTR_ERR(sk_priv);
>>>> +	}
>>>> +
>>>> +	spin_lock(&sk_priv->flt_lock);
>>>> +	flt = rcu_replace_pointer(sk_priv->flt, flt,
>>>> +				  lockdep_is_held(&sk_priv->flt_lock));
>>>> +	spin_unlock(&sk_priv->flt_lock);
>>>> +	kfree_rcu(flt, rcu);
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static const struct nla_policy
>>>> +	psample_sample_filter_set_policy[PSAMPLE_ATTR_SAMPLE_GROUP + 1] = {
>>>> +	[PSAMPLE_ATTR_SAMPLE_GROUP] = { .type = NLA_U32, },
>>> This indentation is confusing, though I'm not sure what's a better
>>> way.
>>>
>>
>> I now! I'll try to move it around see if it improves things.
>>
>>>> +};
>>>> +
>>>> +static const struct genl_ops psample_nl_ops[] = {
>>>>    	{
>>>>    		.cmd = PSAMPLE_CMD_GET_GROUP,
>>>>    		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
>>>>    		.dumpit = psample_nl_cmd_get_group_dumpit,
>>>>    		/* can be retrieved by unprivileged users */
>>>> -	}
>>>> +	},
>>>> +	{
>>>> +		.cmd		= PSAMPLE_CMD_SAMPLE_FILTER_SET,
>>>> +		.doit		= psample_nl_sample_filter_set_doit,
>>>> +		.policy		= psample_sample_filter_set_policy,
>>>> +		.flags		= 0,
>>>> +	},
>>>>    };
>>>>      static struct genl_family psample_nl_family __ro_after_init = {
>>>> @@ -114,10 +185,13 @@ static struct genl_family psample_nl_family __ro_after_init = {
>>>>    	.netnsok	= true,
>>>>    	.module		= THIS_MODULE,
>>>>    	.mcgrps		= psample_nl_mcgrps,
>>>> -	.small_ops	= psample_nl_ops,
>>>> -	.n_small_ops	= ARRAY_SIZE(psample_nl_ops),
>>>> +	.ops		= psample_nl_ops,
>>>> +	.n_ops		= ARRAY_SIZE(psample_nl_ops),
>>>>    	.resv_start_op	= PSAMPLE_CMD_GET_GROUP + 1,
>>>>    	.n_mcgrps	= ARRAY_SIZE(psample_nl_mcgrps),
>>>> +	.sock_priv_size		= sizeof(struct psample_nl_sock_priv),
>>>> +	.sock_priv_init		= psample_nl_sock_priv_init,
>>>> +	.sock_priv_destroy	= psample_nl_sock_priv_destroy,
>>>>    };
>>>>      static void psample_group_notify(struct psample_group *group,
>>>> @@ -360,6 +434,42 @@ static int psample_tunnel_meta_len(struct ip_tunnel_info *tun_info)
>>>>    }
>>>>    #endif
>>>>    +static inline void psample_nl_obj_desc_init(struct
>>>> psample_obj_desc *desc,
>>>> +					    u32 group_num)
>>>> +{
>>>> +	memset(desc, 0, sizeof(*desc));
>>>> +	desc->group_num = group_num;
>>>> +	desc->group_num_valid = true;
>>>> +}
>>>> +
>>>> +static bool psample_obj_desc_match(struct psample_obj_desc *desc,
>>>> +				   struct psample_obj_desc *flt)
>>>> +{
>>>> +	if (desc->group_num_valid && flt->group_num_valid &&
>>>> +	    desc->group_num != flt->group_num)
>>>> +		return false;
>>>> +	return true;
>>> This fucntion returns 'true' if one of the arguments is not valid.
>>> I'd not expect such behavior from a 'match' function.
>>> I understand the intention that psample should sample everything
>>> to sockets that do not request filters, but that should not be part
>>> of the 'match' logic, or more appropriate function name should be
>>> chosen.  Also, if the group is not initialized, but the filter is,
>>> it should not match, logically.  The validity on filter and the
>>> current sample is not symmetric.
>>>
>>
>> The descriptor should always be initialized but I think double
>> checking should be OK as in the context of this particular function,
>> it might not be clear it is.
>>
>>> And I'm not really sure if the 'group_num_valid' is actually needed.
>>> Can the NULL pointer be used as an indicator?  If so, then maybe
>>> the whole psample_obj_desc structure is not needed as it will
>>> contain a single field.
>>
>> If we only filter on group_id, then yes. However, as I was writing
>> this, I thought maybe opening the door to filtering on more fields
>> such as the protocol in/out interfaces, etc. Now that I read this I
>> understand the current code is confusing: I should have left a comment
>> or mention it in the commit message.
> 
> If you want to have such filtering options, does it make sense to
> instead have the listening program send a set of bpf instructions for
> filtering instead?  I think the data should be available at the point
> where simple bpf is attached (SO_ATTACH_BPF to the psample socket, and
> the filter should run as part of the broadcast message IIRC since it
> populates the sk_filter field).
> 

That's a good point. I hope parsing the netlink messages won't be too cumbersome.
So let's limit it to group_ids. How about filtering on a number of group_ids? Is 
that worth it?


>>>
>>>> +}
>>>> +
>>>> +static int psample_nl_sample_filter(struct sock *dsk, struct sk_buff *skb,
>>>> +				    void *data)
>>>> +{
>>>> +	struct psample_obj_desc *desc = data;
>>>> +	struct psample_nl_sock_priv *sk_priv;
>>>> +	struct psample_obj_desc *flt;
>>>> +	int ret = 0;
>>>> +
>>>> +	rcu_read_lock();
>>>> +	sk_priv = __genl_sk_priv_get(&psample_nl_family, dsk);
>>>> +	if (!IS_ERR_OR_NULL(sk_priv)) {
>>>> +		flt = rcu_dereference(sk_priv->flt);
>>>> +		if (flt)
>>>> +			ret = !psample_obj_desc_match(desc, flt);
>>>> +	}
>>>> +	rcu_read_unlock();
>>>> +	return ret;
>>>> +}
>>>> +
>>>>    void psample_sample_packet(struct psample_group *group, struct sk_buff *skb,
>>>>    			   u32 sample_rate, const struct psample_metadata *md)
>>>>    {
>>>> @@ -370,6 +480,7 @@ void psample_sample_packet(struct psample_group *group, struct sk_buff *skb,
>>>>    #ifdef CONFIG_INET
>>>>    	struct ip_tunnel_info *tun_info;
>>>>    #endif
>>>> +	struct psample_obj_desc desc;
>>>>    	struct sk_buff *nl_skb;
>>>>    	int data_len;
>>>>    	int meta_len;
>>>> @@ -487,8 +598,12 @@ void psample_sample_packet(struct psample_group *group, struct sk_buff *skb,
>>>>    #endif
>>>>      	genlmsg_end(nl_skb, data);
>>>> -	genlmsg_multicast_netns(&psample_nl_family, group->net, nl_skb, 0,
>>>> -				PSAMPLE_NL_MCGRP_SAMPLE, GFP_ATOMIC);
>>>> +	psample_nl_obj_desc_init(&desc, group->group_num);
>>>> +	genlmsg_multicast_netns_filtered(&psample_nl_family,
>>>> +					 group->net, nl_skb, 0,
>>>> +					 PSAMPLE_NL_MCGRP_SAMPLE,
>>>> +					 GFP_ATOMIC, psample_nl_sample_filter,
>>>> +					 &desc);
>>>>      	return;
>>>>    error:
>>>
> 


