Return-Path: <netdev+bounces-85896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F9F89CC5C
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 21:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 762F11C217B3
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 19:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307A8145332;
	Mon,  8 Apr 2024 19:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A0iYqdUe"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABCE1448E2
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 19:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712604267; cv=none; b=V1bFcysy7QD3JqxJO6fmvAtY4DJy9Cwl8pq7wA/wFMlDssjwDTTE1Y06T4SCo/TBnBZvDFtwcqhWP7XHousfjwkksTvCTuyxBQR96FHFMN2f4ERtOJsA1f1VnbkE5GZFMHDk28PX4pqHtwxeCCVY53vJ8yCylD6WCjaduXF4lpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712604267; c=relaxed/simple;
	bh=Qhg4o/7jj5SKVyMC4N262rLjaslkVnZZpBD2wN+ce3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OhQ7iqc2ZzlKwUTPrUS2Zm1HQwCEBgioKc9wxUKKPWr0wSgL4xxlZgLAQ5I9/hRBM7cA0QAnto7rGxZcMqI0K9OSYo6Bz+5KPVpqtF66FTV8+Z1FaNUAIZJf9QXLPhIKbVkeLma5uSkJT9ziMKXHgFC5Wq7WFvt8o7VFD4KYJbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A0iYqdUe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712604264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tOLT7F3ls0PNXZ/tGZkH3E9/Sc/vtl2hCpvoDAB6ELU=;
	b=A0iYqdUeSP6C6hVnb2CRWAH+nXQ/4fV8nnIYAUKoCaXDMHtHozbxcBeVr0rlfo1lclKpwL
	xswf+5GRyp7hqhjZkYwZBucUAZk8Uny98dY0+zkChoCYe2ytaLrvI5iG0c9HkepuBybqkj
	65w651KU2tM2ZVS3QmjIT+wNx32u9aA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-Usp4dMKfMOWDknj1YpiVcw-1; Mon, 08 Apr 2024 15:24:22 -0400
X-MC-Unique: Usp4dMKfMOWDknj1YpiVcw-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6963cd45fddso104108576d6.1
        for <netdev@vger.kernel.org>; Mon, 08 Apr 2024 12:24:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712604262; x=1713209062;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tOLT7F3ls0PNXZ/tGZkH3E9/Sc/vtl2hCpvoDAB6ELU=;
        b=r2Km/kupkwk+aagArtFlXdsgBMr+3vRIxCOrk9Xpl5yHJHwiOpwjmLLsUDvy8TnD9h
         3C31mtXx1PcyEkmXv9A+AtnONANEcf3anyCT0hgwtbOVnY9vqxD+TGK6KEJF89u+/jet
         l2swkZduOSpIRVZvXaKKeH9zPjISCQH17sIs5ZzQjeAPwUwIpz7AgjCdB5vbapdXclQU
         JVIW9tXbXxyIstvevilpljWZnxprQb1dv+iICbkSQAwDIBw5uGThn/gcfD45hJoiig5M
         tmBIWyuzFhuQZekFB/6Wd5zbGrNGxwJ/pdlF0WtVCV/YjQdCDEx5xAzbcBFbipTAbW5X
         o6xA==
X-Forwarded-Encrypted: i=1; AJvYcCUVPB7TJ4EbUKsV6+PjibAUkv4uN+XIeDmZP6in9T427QZFd2yR/SZDcxvl6ZyIxJm/rzSCF+dvOKVbmHkXYUHs+0sLy/tv
X-Gm-Message-State: AOJu0YziTCA2AfpOVOc6ELlNBAcCal526ahOIdmQd+grlK3SAJ0SHGAI
	H9HmaI+mB/vWuApCRUdMqNkmREjDrR54YHqCyVXxn3t0xuyEpssWnLYTKobR35d3JMHFt7cM6mr
	zIprUIKL+PdQPDqbLDassWTVeca9K4Tx5FfNW7s3Fvxr4ZmhIixHxnA==
X-Received: by 2002:a05:6214:3018:b0:699:2b22:ae13 with SMTP id ke24-20020a056214301800b006992b22ae13mr1150009qvb.12.1712604262065;
        Mon, 08 Apr 2024 12:24:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdfmfmLusppyPuRSwFcUAH83ctVy/bYKIEKS05X9qfeo2sTgZqDAGaFG2aCiQIy6HNxY+u3A==
X-Received: by 2002:a05:6214:3018:b0:699:2b22:ae13 with SMTP id ke24-20020a056214301800b006992b22ae13mr1149979qvb.12.1712604261719;
        Mon, 08 Apr 2024 12:24:21 -0700 (PDT)
Received: from [192.168.1.132] ([193.177.208.51])
        by smtp.gmail.com with ESMTPSA id dd17-20020ad45811000000b0069b1e63a79esm990457qvb.61.2024.04.08.12.24.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 12:24:21 -0700 (PDT)
Message-ID: <801ccf5c-5ac9-455f-8d9a-48517d7db614@redhat.com>
Date: Mon, 8 Apr 2024 21:24:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next v2 2/5] net: psample: add multicast filtering on
 group_id
To: Ilya Maximets <i.maximets@ovn.org>, netdev@vger.kernel.org
Cc: jiri@resnulli.us, xiyou.wangcong@gmail.com, cmi@nvidia.com,
 yotam.gi@gmail.com, aconole@redhat.com, echaudro@redhat.com, horms@kernel.org
References: <20240408125753.470419-1-amorenoz@redhat.com>
 <20240408125753.470419-3-amorenoz@redhat.com>
 <2b79ebe9-4e83-418a-ae40-93024a3fb433@ovn.org>
Content-Language: en-US
From: Adrian Moreno <amorenoz@redhat.com>
In-Reply-To: <2b79ebe9-4e83-418a-ae40-93024a3fb433@ovn.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/8/24 15:18, Ilya Maximets wrote:
> [copying my previous reply since this version actually has netdev@ in Cc]
> 
> On 4/8/24 14:57, Adrian Moreno wrote:
>> Packet samples can come from several places (e.g: different tc sample
>> actions), typically using the sample group (PSAMPLE_ATTR_SAMPLE_GROUP)
>> to differentiate them.
>>
>> Likewise, sample consumers that listen on the multicast group may only
>> be interested on a single group. However, they are currently forced to
>> receive all samples and discard the ones that are not relevant, causing
>> unnecessary overhead.
>>
>> Allow users to filter on the desired group_id by adding a new command
>> SAMPLE_FILTER_SET that can be used to pass the desired group id.
>> Store this filter on the per-socket private pointer and use it for
>> filtering multicasted samples.
>>
>> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
>> ---
>>   include/uapi/linux/psample.h |   1 +
>>   net/psample/psample.c        | 127 +++++++++++++++++++++++++++++++++--
>>   2 files changed, 122 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/uapi/linux/psample.h b/include/uapi/linux/psample.h
>> index e585db5bf2d2..5e0305b1520d 100644
>> --- a/include/uapi/linux/psample.h
>> +++ b/include/uapi/linux/psample.h
>> @@ -28,6 +28,7 @@ enum psample_command {
>>   	PSAMPLE_CMD_GET_GROUP,
>>   	PSAMPLE_CMD_NEW_GROUP,
>>   	PSAMPLE_CMD_DEL_GROUP,
>> +	PSAMPLE_CMD_SAMPLE_FILTER_SET,
> Other commands are names as PSAMPLE_CMD_VERB_NOUN, so this new one
> should be PSAMPLE_CMD_SET_FILTER.  (The SAMPLE part seems unnecessary.)
> Some functions/structures need to be renamed accordingly.
> 

Sure, I'll rename it when I sent the next version.

>>   };
>>   
>>   enum psample_tunnel_key_attr {
>> diff --git a/net/psample/psample.c b/net/psample/psample.c
>> index a5d9b8446f77..a0cef63dfdec 100644
>> --- a/net/psample/psample.c
>> +++ b/net/psample/psample.c
>> @@ -98,13 +98,84 @@ static int psample_nl_cmd_get_group_dumpit(struct sk_buff *msg,
>>   	return msg->len;
>>   }
>>   
>> -static const struct genl_small_ops psample_nl_ops[] = {
>> +struct psample_obj_desc {
>> +	struct rcu_head rcu;
>> +	u32 group_num;
>> +	bool group_num_valid;
>> +};
>> +
>> +struct psample_nl_sock_priv {
>> +	struct psample_obj_desc __rcu *flt;
> 
> Can we call it 'fileter' ?  I find it hard to read the code with
> this unnecessary abbreviation.  Same for the lock below.
> 

Sure.

>> +	spinlock_t flt_lock; /* Protects flt. */
>> +};
>> +
>> +static void psample_nl_sock_priv_init(void *priv)
>> +{
>> +	struct psample_nl_sock_priv *sk_priv = priv;
>> +
>> +	spin_lock_init(&sk_priv->flt_lock);
>> +}
>> +
>> +static void psample_nl_sock_priv_destroy(void *priv)
>> +{
>> +	struct psample_nl_sock_priv *sk_priv = priv;
>> +	struct psample_obj_desc *flt;
>> +
>> +	flt = rcu_dereference_protected(sk_priv->flt, true);
>> +	kfree_rcu(flt, rcu);
>> +}
>> +
>> +static int psample_nl_sample_filter_set_doit(struct sk_buff *skb,
>> +					     struct genl_info *info)
>> +{
>> +	struct psample_nl_sock_priv *sk_priv;
>> +	struct nlattr **attrs = info->attrs;
>> +	struct psample_obj_desc *flt;
>> +
>> +	flt = kzalloc(sizeof(*flt), GFP_KERNEL);
>> +
>> +	if (attrs[PSAMPLE_ATTR_SAMPLE_GROUP]) {
>> +		flt->group_num = nla_get_u32(attrs[PSAMPLE_ATTR_SAMPLE_GROUP]);
>> +		flt->group_num_valid = true;
>> +	}
>> +
>> +	if (!flt->group_num_valid) {
>> +		kfree(flt);
> 
> Might be better to not allocate it in the first place.
> 

Absolutely.

>> +		flt = NULL;
>> +	}
>> +
>> +	sk_priv = genl_sk_priv_get(&psample_nl_family, NETLINK_CB(skb).sk);
>> +	if (IS_ERR(sk_priv)) {
>> +		kfree(flt);
>> +		return PTR_ERR(sk_priv);
>> +	}
>> +
>> +	spin_lock(&sk_priv->flt_lock);
>> +	flt = rcu_replace_pointer(sk_priv->flt, flt,
>> +				  lockdep_is_held(&sk_priv->flt_lock));
>> +	spin_unlock(&sk_priv->flt_lock);
>> +	kfree_rcu(flt, rcu);
>> +	return 0;
>> +}
>> +
>> +static const struct nla_policy
>> +	psample_sample_filter_set_policy[PSAMPLE_ATTR_SAMPLE_GROUP + 1] = {
>> +	[PSAMPLE_ATTR_SAMPLE_GROUP] = { .type = NLA_U32, },
> 
> This indentation is confusing, though I'm not sure what's a better way.
> 

I now! I'll try to move it around see if it improves things.

>> +};
>> +
>> +static const struct genl_ops psample_nl_ops[] = {
>>   	{
>>   		.cmd = PSAMPLE_CMD_GET_GROUP,
>>   		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
>>   		.dumpit = psample_nl_cmd_get_group_dumpit,
>>   		/* can be retrieved by unprivileged users */
>> -	}
>> +	},
>> +	{
>> +		.cmd		= PSAMPLE_CMD_SAMPLE_FILTER_SET,
>> +		.doit		= psample_nl_sample_filter_set_doit,
>> +		.policy		= psample_sample_filter_set_policy,
>> +		.flags		= 0,
>> +	},
>>   };
>>   
>>   static struct genl_family psample_nl_family __ro_after_init = {
>> @@ -114,10 +185,13 @@ static struct genl_family psample_nl_family __ro_after_init = {
>>   	.netnsok	= true,
>>   	.module		= THIS_MODULE,
>>   	.mcgrps		= psample_nl_mcgrps,
>> -	.small_ops	= psample_nl_ops,
>> -	.n_small_ops	= ARRAY_SIZE(psample_nl_ops),
>> +	.ops		= psample_nl_ops,
>> +	.n_ops		= ARRAY_SIZE(psample_nl_ops),
>>   	.resv_start_op	= PSAMPLE_CMD_GET_GROUP + 1,
>>   	.n_mcgrps	= ARRAY_SIZE(psample_nl_mcgrps),
>> +	.sock_priv_size		= sizeof(struct psample_nl_sock_priv),
>> +	.sock_priv_init		= psample_nl_sock_priv_init,
>> +	.sock_priv_destroy	= psample_nl_sock_priv_destroy,
>>   };
>>   
>>   static void psample_group_notify(struct psample_group *group,
>> @@ -360,6 +434,42 @@ static int psample_tunnel_meta_len(struct ip_tunnel_info *tun_info)
>>   }
>>   #endif
>>   
>> +static inline void psample_nl_obj_desc_init(struct psample_obj_desc *desc,
>> +					    u32 group_num)
>> +{
>> +	memset(desc, 0, sizeof(*desc));
>> +	desc->group_num = group_num;
>> +	desc->group_num_valid = true;
>> +}
>> +
>> +static bool psample_obj_desc_match(struct psample_obj_desc *desc,
>> +				   struct psample_obj_desc *flt)
>> +{
>> +	if (desc->group_num_valid && flt->group_num_valid &&
>> +	    desc->group_num != flt->group_num)
>> +		return false;
>> +	return true;
> 
> This fucntion returns 'true' if one of the arguments is not valid.
> I'd not expect such behavior from a 'match' function.
> 
> I understand the intention that psample should sample everything
> to sockets that do not request filters, but that should not be part
> of the 'match' logic, or more appropriate function name should be
> chosen.  Also, if the group is not initialized, but the filter is,
> it should not match, logically.  The validity on filter and the
> current sample is not symmetric.
> 

The descriptor should always be initialized but I think double checking should 
be OK as in the context of this particular function, it might not be clear it is.

> And I'm not really sure if the 'group_num_valid' is actually needed.
> Can the NULL pointer be used as an indicator?  If so, then maybe
> the whole psample_obj_desc structure is not needed as it will
> contain a single field.

If we only filter on group_id, then yes. However, as I was writing this, I 
thought maybe opening the door to filtering on more fields such as the protocol 
in/out interfaces, etc. Now that I read this I understand the current code is 
confusing: I should have left a comment or mention it in the commit message.

> 
>> +}
>> +
>> +static int psample_nl_sample_filter(struct sock *dsk, struct sk_buff *skb,
>> +				    void *data)
>> +{
>> +	struct psample_obj_desc *desc = data;
>> +	struct psample_nl_sock_priv *sk_priv;
>> +	struct psample_obj_desc *flt;
>> +	int ret = 0;
>> +
>> +	rcu_read_lock();
>> +	sk_priv = __genl_sk_priv_get(&psample_nl_family, dsk);
>> +	if (!IS_ERR_OR_NULL(sk_priv)) {
>> +		flt = rcu_dereference(sk_priv->flt);
>> +		if (flt)
>> +			ret = !psample_obj_desc_match(desc, flt);
>> +	}
>> +	rcu_read_unlock();
>> +	return ret;
>> +}
>> +
>>   void psample_sample_packet(struct psample_group *group, struct sk_buff *skb,
>>   			   u32 sample_rate, const struct psample_metadata *md)
>>   {
>> @@ -370,6 +480,7 @@ void psample_sample_packet(struct psample_group *group, struct sk_buff *skb,
>>   #ifdef CONFIG_INET
>>   	struct ip_tunnel_info *tun_info;
>>   #endif
>> +	struct psample_obj_desc desc;
>>   	struct sk_buff *nl_skb;
>>   	int data_len;
>>   	int meta_len;
>> @@ -487,8 +598,12 @@ void psample_sample_packet(struct psample_group *group, struct sk_buff *skb,
>>   #endif
>>   
>>   	genlmsg_end(nl_skb, data);
>> -	genlmsg_multicast_netns(&psample_nl_family, group->net, nl_skb, 0,
>> -				PSAMPLE_NL_MCGRP_SAMPLE, GFP_ATOMIC);
>> +	psample_nl_obj_desc_init(&desc, group->group_num);
>> +	genlmsg_multicast_netns_filtered(&psample_nl_family,
>> +					 group->net, nl_skb, 0,
>> +					 PSAMPLE_NL_MCGRP_SAMPLE,
>> +					 GFP_ATOMIC, psample_nl_sample_filter,
>> +					 &desc);
>>   
>>   	return;
>>   error:
> 

-- 
Adrián Moreno


