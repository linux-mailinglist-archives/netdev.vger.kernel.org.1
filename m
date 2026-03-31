Return-Path: <netdev+bounces-273403-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCl1O1kTy2nsDgYAu9opvQ
	(envelope-from <netdev+bounces-273403-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 02:20:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF853629DF
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 02:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 752B6300BC75
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFC1199FAC;
	Tue, 31 Mar 2026 00:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qmpOb70Q"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A149119E992
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 00:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774916436; cv=none; b=C8K9lRoTFDJ7qAho2a88gDZnHjDLgr1TnRahl4dZt9SQBpqUNlVRAahGQrqfJMVgJI1LQxYoiZmrm13/rANahFK6IeNRh4kUuZ1WzVTdoa9/hSb/klWDoyHM7U3X9pOS4ozxPixUQxfDPfUTMTRegQa7vPTFyi2tiljyOgikZ7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774916436; c=relaxed/simple;
	bh=L2uLLXPaR8dsFwaj0M/VqP16tI9GfgjDnm6HAXw1oyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dKPD9AE7aIAQ1iPbxeDUfgjx/CIs1GIqBJ8UiMUNJG6Fs7Rz8NcGdqDaaF6rcaMFDuwlvWvn+LVh03IsMKTDnFnQm3CRqZ29iZQtGG5rz9lS4vr7ESS1Z5t2rrSqbAmvlcv1/+Nrp4qOgcZtvRJ71KIrDxshpMzhZpPqtbtk4JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qmpOb70Q; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ae86a1e5-769c-44d8-ad7e-ad724800e9e4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774916430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Bz8w74PmbsgI9Uedv6J256JzSoyommswdXAjHRd59I=;
	b=qmpOb70QRGs7gvusJS+sGUC9jM/NNXyorjbHR4eLo6P+ev+i7drne7q9OdIjKTbCWHdYWB
	YKV6QjQTWzdt7cT7aAd3cyY5nImw0s8v6crA1Sq2Tf+e2F99ZGRcNCDHYwkhKZY04AwRln
	P6kgiKIr6hdNNFPtOUR7Qv50SM/llyY=
Date: Mon, 30 Mar 2026 17:20:21 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v3 5/5] bpf, sockmap: Adapt for af_unix-specific lock
To: Michal Luczaj <mhal@rbox.co>
Cc: Jiayuan Chen <mrpre@163.com>, John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, Eric Dumazet <edumazet@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemb@google.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Yonghong Song <yhs@fb.com>,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Cong Wang <cong.wang@bytedance.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260306-unix-proto-update-null-ptr-deref-v3-0-2f0c7410c523@rbox.co>
 <20260306-unix-proto-update-null-ptr-deref-v3-5-2f0c7410c523@rbox.co>
 <2192e9ef-894f-4826-b296-4f90e973a31b@163.com>
 <b9a956dd-ebb2-47ca-8b49-ccbba6ff9b26@rbox.co>
 <b21fac4e-891b-481c-9734-e95290e49097@linux.dev>
 <fa818820-c0c9-48dc-8ebc-661cb3349935@rbox.co>
 <dd043c69-4d03-46fe-8325-8f97101435cf@linux.dev>
 <27fa6e91-02a5-46cd-8c95-b75fd2c5fa08@rbox.co>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <27fa6e91-02a5-46cd-8c95-b75fd2c5fa08@rbox.co>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273403-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[163.com,gmail.com,cloudflare.com,google.com,redhat.com,davemloft.net,kernel.org,fb.com,iogearbox.net,linux.dev,fomichev.me,bytedance.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 8DF853629DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/30/26 4:03 PM, Michal Luczaj wrote:
> On 3/26/26 07:26, Martin KaFai Lau wrote:
>> On 3/15/26 4:58 PM, Michal Luczaj wrote:
>>>> Beside, from looking at the may_update_sockmap(), I don't know if it is
>>>> even doable (or useful) to bpf_map_update_elem(unix_sk) in
>>>> tc/flow_dissector/xdp. One possible path is the SOCK_FILTER when looking
>>>> at unix_dgram_sendmsg() => sk_filter(). It was not the original use case
>>>> when the bpf_map_update_elem(sockmap) support was added iirc.
>>>
>>> What about a situation when unix_sk is stored in a sockmap, then tc prog
>>> looks it up and invokes bpf_map_update_elem(unix_sk)? I'm not sure it's
>>> useful, but seems doable.
>>
>> [ Sorry for the late reply ]
>>
>> It is a bummer that the bpf_map_update_elem(unix_sk) path is possible
>> from tc :(
>>
>> Then unix_state_lock() in its current form cannot be safely acquired in
>> sock_map_update_elem(). It is currently a spin_lock() instead of
>> spin_lock_bh().
> 
> Is there a specific deadlock you have in your mind?

e.g. unix_stream_connect() is taking unix_state_lock(). Can a tc's 
ingress bpf prog call unix_state_lock()?

> 
>>>> The only path left is bpf_iter, which I believe was the primary use case
>>>> when adding bpf_map_update_elem(sockmap) support [1]. It would be nice
>>>> to avoid bh_lock_sock() when calling from all bpf_iter (tcp/udp/unix)
>>>> where lock_sock() has already been done. It is more for
>>>> reading-correctness though. This just came to my mind.
>>>> has_current_bpf_ctx() can be used to check this. sockopt_lock_sock() has
>>>> been using it to conditionally take lock_sock() or not.
>>>
>>> [ One clarification: bh_lock_sock() is a sock_map_update_elem() thing,
>>> which can only be called by a bpf prog. IOW, has_current_bpf_ctx() is
>>> always `true` in sock_map_update_elem(), right? ]
>>
>> For all the bpf prog types allowed by may_update_sockmap() to do
>> bpf_map_update_elem(sockmap), only BPF_TRACE_ITER should have
>> has_current_bpf_ctx() == true. The tc prog (and others allowed in
>> may_update_sockmap()) will have has_current_bpf_ctx() == false when
>> calling sock_map_update_elem().
> 
> OK, so let's take test_sockmap_update.c:copy_sock_map(). It is a tc prog
> and it calls bpf_map_update_elem() -> sock_map_update_elem(), right? But
> running `test_progs -t "sockmap_basic/sockmap update"` shows (pr_warn() in
> sock_map_update_elem()) that has_current_bpf_ctx() == true. That's expected

I think it is because of the bpf_prog_test_run_skb() code path used by 
the test_sockmap_update() test. This would need to be addressed if 
has_current_bpf_ctx() was used in sock_map_update_elem().

> and has_current_bpf_ctx() would be false if sock_map_update_elem() was ran
> via a hook?

It should be false when the bpf prog is run by tc instead of 
bpf_prog_test_run_skb().

>>> Let me know if I'm correctly rephrasing your idea: assume all bpf-context
>>> callers hold the socket locked or keep it "stable" (meaning: "sk won't
>>> surprise sockmap update by some breaking state change coming from another
>>> thread"). As you said, most bpf iters already take the sock_lock(), and I
>>
>> Right, all bpf iter (udp, tcp, unix) has acquired the lock_sock() before
>> running the bpf iter prog. afaik, the only exception is netlink bpf iter
>> but it cannot be added to sock_map afaik.
> 
> And sock_{map,hash}_seq_show() (being a part of bpf iter machinery) needs
> to take lock_sock() just as well? Would that require a special-casing
> (unix_state_lock()) for af_unix?

I would think so for lock_sock() considering the current bh_lock_sock 
without !sock_owned_by_user() usage is incorrect in 
sock_map_update_elem(). [ this probably should be a separate issue for 
another patch ]

Some more side-tracking... from looking at the code, the bpf_iter of 
sock_{map,hash} can do bpf_map_lookup_elem(&sock_map, ...). This 
bpr_iter program probably will be failed to load because the 
bpf_sk_release() is not available.

I still don't have good idea what to do with the tc's prog calling 
sock_map_update_elem().


