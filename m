Return-Path: <netdev+bounces-86172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB56289DD17
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 16:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F5E02839A8
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 14:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3044A130E2E;
	Tue,  9 Apr 2024 14:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IE9oYGBn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE1850275
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 14:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712673796; cv=none; b=umRdoPiJRPGJ5Qeb+MIOt69X+bVggdI8AxiuzVTGrQdtyYW/uby6yQzb/YhRtZCyvwo9sLCBKThKVPrZTgyhhf9P4OL7N555lV3/YdzCQYlZii3tSfuaHOkDDQMSishCg/PyfdIdEEp7Fk+HP/gtmy0o4ZXAqMf39xYPy9gLv2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712673796; c=relaxed/simple;
	bh=xYvbLyqnvDTM8173lluuVdBXKzaAM+04axcQIK+9sBQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=hUmLvf6xpszWOiCyseArprTI7uRs5WTKI5GdLXeHcO7/1A8rYUEqgn0bxxsGKwDreBsZIAnRM7tAoOIDthNWURL3Ro7YbidrkybGt7VkRjSOt2/3z72OyJ0ELyo9hYq5XBRm+KD/11cKEITHmbt4louBfoiPE/OZ6Dqyyzz66OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IE9oYGBn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712673793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fhOSJsio7Y05Zi/cvlHB81uhNVYoOCf165mU3ruAKFc=;
	b=IE9oYGBnG3l7qI3uOl0F3o1nu7k0ZPp+TJ34idnE0YmSniirIi7GHvnywxP/GHch+j8An2
	0loVPl8dYXnEu0dmm0DC6qL4NDf3t9UnA04plE0D8dnknJYfE04P3G6N2ocJ1B4n9Ufy87
	la9qsjs8UYQS+FOvjvlkFj786OyTL4o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-4JECR4DiPgScIcy0Q97ZGQ-1; Tue, 09 Apr 2024 10:43:09 -0400
X-MC-Unique: 4JECR4DiPgScIcy0Q97ZGQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 75738104B508;
	Tue,  9 Apr 2024 14:43:09 +0000 (UTC)
Received: from RHTPC1VM0NT (dhcp-17-72.bos.redhat.com [10.18.17.72])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 330FF1C0666D;
	Tue,  9 Apr 2024 14:43:09 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: Ilya Maximets <i.maximets@ovn.org>,  netdev@vger.kernel.org,
  jiri@resnulli.us,  xiyou.wangcong@gmail.com,  cmi@nvidia.com,
  yotam.gi@gmail.com,  echaudro@redhat.com,  horms@kernel.org
Subject: Re: [RFC net-next v2 2/5] net: psample: add multicast filtering on
 group_id
References: <20240408125753.470419-1-amorenoz@redhat.com>
	<20240408125753.470419-3-amorenoz@redhat.com>
	<2b79ebe9-4e83-418a-ae40-93024a3fb433@ovn.org>
	<801ccf5c-5ac9-455f-8d9a-48517d7db614@redhat.com>
Date: Tue, 09 Apr 2024 10:43:08 -0400
In-Reply-To: <801ccf5c-5ac9-455f-8d9a-48517d7db614@redhat.com> (Adrian
	Moreno's message of "Mon, 8 Apr 2024 21:24:17 +0200")
Message-ID: <f7til0qmwar.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Adrian Moreno <amorenoz@redhat.com> writes:

> On 4/8/24 15:18, Ilya Maximets wrote:
>> [copying my previous reply since this version actually has netdev@ in Cc]
>> On 4/8/24 14:57, Adrian Moreno wrote:
>>> Packet samples can come from several places (e.g: different tc sample
>>> actions), typically using the sample group (PSAMPLE_ATTR_SAMPLE_GROUP)
>>> to differentiate them.
>>>
>>> Likewise, sample consumers that listen on the multicast group may only
>>> be interested on a single group. However, they are currently forced to
>>> receive all samples and discard the ones that are not relevant, causing
>>> unnecessary overhead.
>>>
>>> Allow users to filter on the desired group_id by adding a new command
>>> SAMPLE_FILTER_SET that can be used to pass the desired group id.
>>> Store this filter on the per-socket private pointer and use it for
>>> filtering multicasted samples.
>>>
>>> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
>>> ---
>>>   include/uapi/linux/psample.h |   1 +
>>>   net/psample/psample.c        | 127 +++++++++++++++++++++++++++++++++--
>>>   2 files changed, 122 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/include/uapi/linux/psample.h b/include/uapi/linux/psample.h
>>> index e585db5bf2d2..5e0305b1520d 100644
>>> --- a/include/uapi/linux/psample.h
>>> +++ b/include/uapi/linux/psample.h
>>> @@ -28,6 +28,7 @@ enum psample_command {
>>>   	PSAMPLE_CMD_GET_GROUP,
>>>   	PSAMPLE_CMD_NEW_GROUP,
>>>   	PSAMPLE_CMD_DEL_GROUP,
>>> +	PSAMPLE_CMD_SAMPLE_FILTER_SET,
>> Other commands are names as PSAMPLE_CMD_VERB_NOUN, so this new one
>> should be PSAMPLE_CMD_SET_FILTER.  (The SAMPLE part seems unnecessary.)
>> Some functions/structures need to be renamed accordingly.
>> 
>
> Sure, I'll rename it when I sent the next version.
>
>>>   };
>>>     enum psample_tunnel_key_attr {
>>> diff --git a/net/psample/psample.c b/net/psample/psample.c
>>> index a5d9b8446f77..a0cef63dfdec 100644
>>> --- a/net/psample/psample.c
>>> +++ b/net/psample/psample.c
>>> @@ -98,13 +98,84 @@ static int psample_nl_cmd_get_group_dumpit(struct sk_buff *msg,
>>>   	return msg->len;
>>>   }
>>>   -static const struct genl_small_ops psample_nl_ops[] = {
>>> +struct psample_obj_desc {
>>> +	struct rcu_head rcu;
>>> +	u32 group_num;
>>> +	bool group_num_valid;
>>> +};
>>> +
>>> +struct psample_nl_sock_priv {
>>> +	struct psample_obj_desc __rcu *flt;
>> Can we call it 'fileter' ?  I find it hard to read the code with
>> this unnecessary abbreviation.  Same for the lock below.
>> 
>
> Sure.
>
>>> +	spinlock_t flt_lock; /* Protects flt. */
>>> +};
>>> +
>>> +static void psample_nl_sock_priv_init(void *priv)
>>> +{
>>> +	struct psample_nl_sock_priv *sk_priv = priv;
>>> +
>>> +	spin_lock_init(&sk_priv->flt_lock);
>>> +}
>>> +
>>> +static void psample_nl_sock_priv_destroy(void *priv)
>>> +{
>>> +	struct psample_nl_sock_priv *sk_priv = priv;
>>> +	struct psample_obj_desc *flt;
>>> +
>>> +	flt = rcu_dereference_protected(sk_priv->flt, true);
>>> +	kfree_rcu(flt, rcu);
>>> +}
>>> +
>>> +static int psample_nl_sample_filter_set_doit(struct sk_buff *skb,
>>> +					     struct genl_info *info)
>>> +{
>>> +	struct psample_nl_sock_priv *sk_priv;
>>> +	struct nlattr **attrs = info->attrs;
>>> +	struct psample_obj_desc *flt;
>>> +
>>> +	flt = kzalloc(sizeof(*flt), GFP_KERNEL);
>>> +
>>> +	if (attrs[PSAMPLE_ATTR_SAMPLE_GROUP]) {
>>> +		flt->group_num = nla_get_u32(attrs[PSAMPLE_ATTR_SAMPLE_GROUP]);
>>> +		flt->group_num_valid = true;
>>> +	}
>>> +
>>> +	if (!flt->group_num_valid) {
>>> +		kfree(flt);
>> Might be better to not allocate it in the first place.
>> 
>
> Absolutely.
>
>>> +		flt = NULL;
>>> +	}
>>> +
>>> +	sk_priv = genl_sk_priv_get(&psample_nl_family, NETLINK_CB(skb).sk);
>>> +	if (IS_ERR(sk_priv)) {
>>> +		kfree(flt);
>>> +		return PTR_ERR(sk_priv);
>>> +	}
>>> +
>>> +	spin_lock(&sk_priv->flt_lock);
>>> +	flt = rcu_replace_pointer(sk_priv->flt, flt,
>>> +				  lockdep_is_held(&sk_priv->flt_lock));
>>> +	spin_unlock(&sk_priv->flt_lock);
>>> +	kfree_rcu(flt, rcu);
>>> +	return 0;
>>> +}
>>> +
>>> +static const struct nla_policy
>>> +	psample_sample_filter_set_policy[PSAMPLE_ATTR_SAMPLE_GROUP + 1] = {
>>> +	[PSAMPLE_ATTR_SAMPLE_GROUP] = { .type = NLA_U32, },
>> This indentation is confusing, though I'm not sure what's a better
>> way.
>> 
>
> I now! I'll try to move it around see if it improves things.
>
>>> +};
>>> +
>>> +static const struct genl_ops psample_nl_ops[] = {
>>>   	{
>>>   		.cmd = PSAMPLE_CMD_GET_GROUP,
>>>   		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
>>>   		.dumpit = psample_nl_cmd_get_group_dumpit,
>>>   		/* can be retrieved by unprivileged users */
>>> -	}
>>> +	},
>>> +	{
>>> +		.cmd		= PSAMPLE_CMD_SAMPLE_FILTER_SET,
>>> +		.doit		= psample_nl_sample_filter_set_doit,
>>> +		.policy		= psample_sample_filter_set_policy,
>>> +		.flags		= 0,
>>> +	},
>>>   };
>>>     static struct genl_family psample_nl_family __ro_after_init = {
>>> @@ -114,10 +185,13 @@ static struct genl_family psample_nl_family __ro_after_init = {
>>>   	.netnsok	= true,
>>>   	.module		= THIS_MODULE,
>>>   	.mcgrps		= psample_nl_mcgrps,
>>> -	.small_ops	= psample_nl_ops,
>>> -	.n_small_ops	= ARRAY_SIZE(psample_nl_ops),
>>> +	.ops		= psample_nl_ops,
>>> +	.n_ops		= ARRAY_SIZE(psample_nl_ops),
>>>   	.resv_start_op	= PSAMPLE_CMD_GET_GROUP + 1,
>>>   	.n_mcgrps	= ARRAY_SIZE(psample_nl_mcgrps),
>>> +	.sock_priv_size		= sizeof(struct psample_nl_sock_priv),
>>> +	.sock_priv_init		= psample_nl_sock_priv_init,
>>> +	.sock_priv_destroy	= psample_nl_sock_priv_destroy,
>>>   };
>>>     static void psample_group_notify(struct psample_group *group,
>>> @@ -360,6 +434,42 @@ static int psample_tunnel_meta_len(struct ip_tunnel_info *tun_info)
>>>   }
>>>   #endif
>>>   +static inline void psample_nl_obj_desc_init(struct
>>> psample_obj_desc *desc,
>>> +					    u32 group_num)
>>> +{
>>> +	memset(desc, 0, sizeof(*desc));
>>> +	desc->group_num = group_num;
>>> +	desc->group_num_valid = true;
>>> +}
>>> +
>>> +static bool psample_obj_desc_match(struct psample_obj_desc *desc,
>>> +				   struct psample_obj_desc *flt)
>>> +{
>>> +	if (desc->group_num_valid && flt->group_num_valid &&
>>> +	    desc->group_num != flt->group_num)
>>> +		return false;
>>> +	return true;
>> This fucntion returns 'true' if one of the arguments is not valid.
>> I'd not expect such behavior from a 'match' function.
>> I understand the intention that psample should sample everything
>> to sockets that do not request filters, but that should not be part
>> of the 'match' logic, or more appropriate function name should be
>> chosen.  Also, if the group is not initialized, but the filter is,
>> it should not match, logically.  The validity on filter and the
>> current sample is not symmetric.
>> 
>
> The descriptor should always be initialized but I think double
> checking should be OK as in the context of this particular function,
> it might not be clear it is.
>
>> And I'm not really sure if the 'group_num_valid' is actually needed.
>> Can the NULL pointer be used as an indicator?  If so, then maybe
>> the whole psample_obj_desc structure is not needed as it will
>> contain a single field.
>
> If we only filter on group_id, then yes. However, as I was writing
> this, I thought maybe opening the door to filtering on more fields
> such as the protocol in/out interfaces, etc. Now that I read this I
> understand the current code is confusing: I should have left a comment
> or mention it in the commit message.

If you want to have such filtering options, does it make sense to
instead have the listening program send a set of bpf instructions for
filtering instead?  I think the data should be available at the point
where simple bpf is attached (SO_ATTACH_BPF to the psample socket, and
the filter should run as part of the broadcast message IIRC since it
populates the sk_filter field).

>> 
>>> +}
>>> +
>>> +static int psample_nl_sample_filter(struct sock *dsk, struct sk_buff *skb,
>>> +				    void *data)
>>> +{
>>> +	struct psample_obj_desc *desc = data;
>>> +	struct psample_nl_sock_priv *sk_priv;
>>> +	struct psample_obj_desc *flt;
>>> +	int ret = 0;
>>> +
>>> +	rcu_read_lock();
>>> +	sk_priv = __genl_sk_priv_get(&psample_nl_family, dsk);
>>> +	if (!IS_ERR_OR_NULL(sk_priv)) {
>>> +		flt = rcu_dereference(sk_priv->flt);
>>> +		if (flt)
>>> +			ret = !psample_obj_desc_match(desc, flt);
>>> +	}
>>> +	rcu_read_unlock();
>>> +	return ret;
>>> +}
>>> +
>>>   void psample_sample_packet(struct psample_group *group, struct sk_buff *skb,
>>>   			   u32 sample_rate, const struct psample_metadata *md)
>>>   {
>>> @@ -370,6 +480,7 @@ void psample_sample_packet(struct psample_group *group, struct sk_buff *skb,
>>>   #ifdef CONFIG_INET
>>>   	struct ip_tunnel_info *tun_info;
>>>   #endif
>>> +	struct psample_obj_desc desc;
>>>   	struct sk_buff *nl_skb;
>>>   	int data_len;
>>>   	int meta_len;
>>> @@ -487,8 +598,12 @@ void psample_sample_packet(struct psample_group *group, struct sk_buff *skb,
>>>   #endif
>>>     	genlmsg_end(nl_skb, data);
>>> -	genlmsg_multicast_netns(&psample_nl_family, group->net, nl_skb, 0,
>>> -				PSAMPLE_NL_MCGRP_SAMPLE, GFP_ATOMIC);
>>> +	psample_nl_obj_desc_init(&desc, group->group_num);
>>> +	genlmsg_multicast_netns_filtered(&psample_nl_family,
>>> +					 group->net, nl_skb, 0,
>>> +					 PSAMPLE_NL_MCGRP_SAMPLE,
>>> +					 GFP_ATOMIC, psample_nl_sample_filter,
>>> +					 &desc);
>>>     	return;
>>>   error:
>> 


