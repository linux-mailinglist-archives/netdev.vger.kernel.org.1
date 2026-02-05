Return-Path: <netdev+bounces-256907-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KE7KLbL5g2nwwQMAu9opvQ
	(envelope-from <netdev+bounces-256907-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 03:00:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 219C0EDCFB
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 03:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 984CA30107EA
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 02:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993267262E;
	Thu,  5 Feb 2026 02:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MUH9WLJQ"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BA028371
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 02:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770256815; cv=none; b=Mz/EoFiDJPb4Cgv0Ydgbiu+JTNNkkqpyklfiwyaZcfoA43hM3GJJiuI2N+AjjrCA3Xdh9JplB5y9HgZ8J9UWmhw8jA3XK6vtju1Lc17C2WrA9h7BehbpDyUhoe9KlEMi0TYDfyJ8/ZA3uG8OjPkOKrzv3UrFTqrR4ug4ims4aDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770256815; c=relaxed/simple;
	bh=RPY8u6waJi/HuYW0mbeBd/xg1THWsE0hqysKYejDC5M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=S7JI2m+c/xInMBXlRu9mFc5+WFFs9VvkcHzP8q2a3hjxPMpGwYC/X2BwpuVIb1oDqH0rjkpuU2BRomuVKro+XnHm+g/n16eZ8tCcGls1q5KlKfApN4dSxNExktD2cYPjvLkweqEFeHScqMC7BqWwU1urps9zns5PmFEHRcM6ryQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MUH9WLJQ; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <73175419-adbe-4108-a734-ff409ea3d1d4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770256812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uaUjf5w0ZQtbrwKPtByMT35wS6Q+83Y2s3WdA59KCpI=;
	b=MUH9WLJQCOCKn277sZ389VrCKHFxwiqNCncv/7WwamG7jBrZ+LfrZGGgreP8fjYn2B6CGC
	0pN68r9eiRafkfpp4rK28nYR5H/RnUKtVUu18o6UvevDSnXpFc0dUUfbZn4IfQy/Uwu+OS
	lrxFt+g58o4BAGHJDXPCjjPHFZV2ofo=
Date: Wed, 4 Feb 2026 18:00:05 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf, sockmap: Fix af_unix null-ptr-deref in proto
 update
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Kuniyuki Iwashima <kuniyu@google.com>, Alexei Starovoitov <ast@kernel.org>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, jakub@cloudflare.com,
 john.fastabend@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 mhal@rbox.co, netdev@vger.kernel.org, pabeni@redhat.com
References: <0f8ec4c7-5de4-4e0b-a50e-cf4f8d59709b@linux.dev>
 <20260204211436.1821958-1-kuniyu@google.com>
 <bf498b0f-7bdb-4668-b2de-80dbf9b0397f@linux.dev>
Content-Language: en-US
In-Reply-To: <bf498b0f-7bdb-4668-b2de-80dbf9b0397f@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256907-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,iogearbox.net,davemloft.net,google.com,kernel.org,cloudflare.com,gmail.com,rbox.co,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 219C0EDCFB
X-Rspamd-Action: no action



On 2/4/26 4:55 PM, Martin KaFai Lau wrote:
> 
> 
> On 2/4/26 1:09 PM, Kuniyuki Iwashima wrote:
>> From: Martin KaFai Lau <martin.lau@linux.dev>
>> Date: Wed, 4 Feb 2026 11:34:55 -0800
>>> On 2/4/26 7:41 AM, Michal Luczaj wrote:
>>>>>>>>> If the concern is the bpf iterator prog may use a released 
>>>>>>>>> unix_peer(sk)
>>>>>>>>> pointer, it should be fine. The unix_peer(sk) pointer is not a 
>>>>>>>>> trusted
>>>>>>>>> pointer to the bpf prog, so nothing bad will happen other than
>>>>>>>>> potentially reading incorrect values.
>>>
>>> I misremembered that following unix->peer would be marked as
>>> (PTR_TO_BTF_ID | PTR_UNTRUSTED). I forgot there are some legacy supports
>>> on the PTR_TO_BTF_ID (i.e. without PTR_UNTRUSTED marking).
>>>
>>>>>>>>
>>>>>>>> But if the prog passes a released peer pointer to a bpf helper:
>>>>>>>>
>>>>>>>> BUG: KASAN: slab-use-after-free in bpf_skc_to_unix_sock+0x95/0xb0
>>>>>>>> Read of size 1 at addr ffff888110654c92 by task test_progs/1936
>>>>>>
>>>>>> hmm... bpf_skc_to_unix_sock is exposed to tracing. bpf_iter is a 
>>>>>> tracing
>>>>>> bpf prog.
>>>>>>
>>>>>>>
>>>>>>> Can you cook a patch for this ? probably like below
>>>>>>
>>>>>> This can help the bpf_iter but not the other tracing prog such as 
>>>>>> fentry.
>>>>>
>>>>> Oh well ... then bpf_skc_to_unix_sock() can be used even
>>>>> with SEQ_START_TOKEN at fentry of bpf_iter_unix_seq_show() ??
>>>
>>> It is fine. The type is void.
>>>
>>>>>
>>>>> How about adding notrace to all af_unix bpf iterator functions ?
>>>
>>> but right, other functions taking [unix_]sock pointer could be audited.
>>> I don't know af_unix well enough to assess the blast radius or whether
>>> some useful functions may become untraceable.
>>
>> Considering SOCK_DGRAM, the blast radus is much bigger than
>> I thought, so I'd avoid this way if possible by modifying
>> the verifier.
>>
>>
>>>
>>>>>
>>>>> The procfs iterator holds a spinlock of the hashtable from
>>>>> ->start/next() to ->stop() to prevent the race with 
>>>>> unix_release_sock().
>>>>>
>>>>> I think other (non-iterator) functions cannot do such racy
>>>>> access with tracing prog.
>>>>
>>>> But then there's SOCK_DGRAM where you can drop unix_peer(sk) without
>>>> releasing sk; see AF_UNSPEC in unix_dgram_connect(). I think Martin is
>>>> right, we can crash at many fentries.
>>>>
>>>> BUG: KASAN: slab-use-after-free in bpf_skc_to_unix_sock+0xa4/0xb0
>>>> Read of size 2 at addr ffff888147d38890 by task test_progs/2495
>>>> Call Trace:
>>>>    dump_stack_lvl+0x5d/0x80
>>>>    print_report+0x170/0x4f3
>>>>    kasan_report+0xe1/0x180
>>>>    bpf_skc_to_unix_sock+0xa4/0xb0
>>>>    bpf_prog_564a1c39c35d86a2_unix_shutdown_entry+0x8a/0x8e
>>>>    bpf_trampoline_6442564662+0x47/0xab
>>>>    unix_shutdown+0x9/0x880
>>>>    __sys_shutdown+0xe1/0x160
>>>>    __x64_sys_shutdown+0x52/0x90
>>>>    do_syscall_64+0x6b/0x3a0
>>>>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>
>>> This probably is the first case where reading a sk pointer requires a
>>> lock. I think it will need to be marked as PTR_UNTRUSTED in the verifier
>>> for the unix->peer access, so that it cannot be passed to a helper.
>>> There is a BTF_TYPE_SAFE_TRUSTED list. afaik, there is no untrusted 
>>> one now.
>>
>> Just skimmed the code, and I guess something like below would
>> do that ?  and if needed, we could add another helper to fetch
>> peer with a proper release function ?
>>
>> ---8<---
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 3135643d5695..ef8b4dd21923 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -7177,6 +7177,14 @@ static bool type_is_rcu_or_null(struct 
>> bpf_verifier_env *env,
>>       return btf_nested_type_is_trusted(&env->log, reg, field_name, 
>> btf_id, "__safe_rcu_or_null");
>>   }
>> +static bool type_is_untrusted(struct bpf_verifier_env *env,
>> +                  struct bpf_reg_state *reg,
>> +                  const char *field_name, u32 btf_id)
>> +{
>> +    /* TODO: return true if field_name and btf_id is unix_sock.peer. */
>> +    return false;
>> +}
>> +
>>   static bool type_is_trusted(struct bpf_verifier_env *env,
>>                   struct bpf_reg_state *reg,
>>                   const char *field_name, u32 btf_id)
>> @@ -7307,7 +7315,9 @@ static int check_ptr_to_btf_access(struct 
>> bpf_verifier_env *env,
>>            * A regular RCU-protected pointer with __rcu tag can also 
>> be deemed
>>            * trusted if we are in an RCU CS. Such pointer can be NULL.
>>            */
>> -        if (type_is_trusted(env, reg, field_name, btf_id)) {
>> +        if (type_is_untrusted(env, reg, field_name, btf_id)) {
>> +            flag |= PTR_UNTRUSTED;
> 
> Something like this but I think the PTR_UNTRUSTED marking should be done 
> right after the clear_trusted_flags() where it is for supporting the 
> depreciated PTR_TO_BTF_ID. Before that ...
> 
> Alexei, can you advise if we should change the verifier to mark 
> PTR_UNTRUSTED on unix_sock->peer or we can deprecate the bpf_skc_to_* 
> helper support from tracing and ask the user to switch to bpf_core_cast 
> (i.e. bpf_rdonly_cast) by using a WARN_ON_ONCE message?

After trying more, taking out bpf_skc_to_* is not enough. It still needs 
to reject passing unix->peer to bpf_setsockopt for bpf_iter, so 
PTR_UNTRUSTED mark is needed.

> 
> The problem is that the unix_sock->peer pointer is not always valid when 
> passing to the bpf_skc_to_* helpers, so it is a UAF.
> 


