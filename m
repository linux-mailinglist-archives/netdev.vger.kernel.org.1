Return-Path: <netdev+bounces-271751-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YE3sH25WxGljyAQAu9opvQ
	(envelope-from <netdev+bounces-271751-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 22:41:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D486432C90C
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 22:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8C9A306B0B0
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 21:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0DA390C89;
	Wed, 25 Mar 2026 21:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jaOYrq1S"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B78A199FB0
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 21:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774474628; cv=none; b=mkUrkHaF3XfoT2vJaqLoeI8IifboGz7H240DQxq90vKsjM0kyFxpT29ZeKLazJkb4nycUO1dzSxORqd39uWtQzPpWOFcVwSQwG3JjPhM3CYMKkjUrhir4gaSitpBeXZ7DFHWFIOHPcP8e4qPIdJ7Uy4N09r+DdAwLYF2Nk3NsVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774474628; c=relaxed/simple;
	bh=OFVLEXhp5PXnU9A8gBRB7BZuYWxqRHBjgOIczfMd1HI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GP6fPOLzqkGw/Ow53fFGheoeNgebk9SaUqA7InryUiMTFbETqOpqbc8Jqg/xuowWWWb8sJMbS1kl46vrPXMmRYifjVhaXR79Ol4axWC15llvKZPKgrN/RR9ZNzdHOYo8w5iQIjq5nlAm2To/q5hFAWOwY5L0VFyJtX0g3QXUavM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jaOYrq1S; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <44bc646b-9889-4dc0-9068-b07b6bb7193b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774474624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vU6ZrVdNBtcOZ1Y/s0Q07CZAHWnjdN91JHaS+MDCaME=;
	b=jaOYrq1SzjxlyMmSNFxrBww9T4UCBgkYZM1fVmE0efSE6BawU7F743APErBnBHmqKxAobb
	yzPVEqnD5PhtO7L9KWxBC4KaESZwmsnS2diechib58cGIMZ9LZTczAHNNBvDRQSElxOY2u
	9n5WpEBKGHdCu+4JgMoDatDwWIG9TKI=
Date: Wed, 25 Mar 2026 14:36:40 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 09/11 net-next v5] bpf: remove ipv6_bpf_stub completely
 and use direct function calls
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 Guillaume Nault <gnault@redhat.com>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20260325120928.15848-1-fmancera@suse.de>
 <20260325120928.15848-10-fmancera@suse.de>
 <1ff47530-44ee-4012-a013-0202182de208@linux.dev>
 <99c37135-a1cc-4eb9-a910-ca38e129b5b0@suse.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <99c37135-a1cc-4eb9-a910-ca38e129b5b0@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271751-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2600:3c0a:e001:db::12fc:5321:from];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_CC(0.00)[suse.com,iogearbox.net,davemloft.net,kernel.org,google.com,redhat.com,gmail.com,linux.dev,fomichev.me,nvidia.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D486432C90C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/25/26 1:29 PM, Fernando Fernandez Mancera wrote:
> On 3/25/26 8:11 PM, Martin KaFai Lau wrote:
>> On 3/25/26 5:08 AM, Fernando Fernandez Mancera wrote:
>>> As IPv6 is built-in only, the ipv6_bpf_stub can be removed completely.
>>>
>>> Convert all ipv6_bpf_stub usage to direct function calls instead. The
>>> fallback functions introduced previously will prevent linkage errors
>>> when CONFIG_IPV6 is disabled.
>>
>> Thanks for working on this.
>>
>>> @@ -6221,8 +6215,8 @@ static int bpf_ipv4_fib_lookup(struct net *net, 
>>> struct bpf_fib_lookup *params,
>>>       if (likely(nhc->nhc_gw_family != AF_INET6))
>>>           neigh = __ipv4_neigh_lookup_noref(dev,
>>>                             (__force u32)params->ipv4_dst);
>>> -    else
>>> -        neigh = __ipv6_neigh_lookup_noref_stub(dev, params->ipv6_dst);
>>> +    else if (IS_ENABLED(CONFIG_IPV6))
>>> +        neigh = __ipv6_neigh_lookup_noref(dev, params->ipv6_dst);
>>
>> Should it be ipv6_mod_enabled() instead of IS_ENABLED(CONFIG_IPV6)?
>> Is nd_tbl always initialized?
>>
> 
> Hi Martin,
> 
> I don't think so. The IS_ENABLED(CONFIG_IPV6) check here is just to 
> prevent an undefined reference when compiling with CONFIG_IPV6=n. Note 
> that this code isn't reachable when ipv6.disable=1 is set during 
> booting, as it would have crashed even before this change because 
> ipv6_stub->nd_tbl is NULL if the IPV6 is disabled since booting.
> 
> We addressed the vulnerable paths already during this series:
> 
> https://lore.kernel.org/netdev/20260307-net-nd_tbl_fixes-v4-0- 
> e2677e85628c@suse.com/#
> 
>>>       if (!neigh || !(READ_ONCE(neigh->nud_state) & NUD_VALID))
>>>           return BPF_FIB_LKUP_RET_NO_NEIGH;
>>> @@ -6290,12 +6284,11 @@ static int bpf_ipv6_fib_lookup(struct net 
>>> *net, struct bpf_fib_lookup *params,
>>>               params->tbid = 0;
>>>           }
>>> -        tb = ipv6_stub->fib6_get_table(net, tbid);
>>> +        tb = fib6_get_table(net, tbid);
>>>           if (unlikely(!tb))
>>>               return BPF_FIB_LKUP_RET_NOT_FWDED;
>>> -        err = ipv6_stub->fib6_table_lookup(net, tb, oif, &fl6, &res,
>>> -                           strict);
>>> +        err = fib6_table_lookup(net, tb, oif, &fl6, &res, strict);
>>
>> A similar question here and other changes in the patch.
>>
>> I think bpf_ipv6_fib_lookup() is fine because the earlier
>> "!idev" check should fail when ipv6 is disabled at boot time?
> 
> Yes, the !idev check prevents us to reach this path so it is safe to 
> call fib6_table_lookup().
> 
> While working on the series I have been trying to exploit these paths 
> (this one and other changes in the series), so far I didn't find anything.

Thanks for the explanation.

Reviewed-by: Martin KaFai Lau <martin.lau@kernel.org>


