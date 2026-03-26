Return-Path: <netdev+bounces-271854-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cL+ON6jRxGmw4AQAu9opvQ
	(envelope-from <netdev+bounces-271854-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 07:26:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DC532FC1B
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 07:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0D1E1302067A
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 06:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3843AD51C;
	Thu, 26 Mar 2026 06:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ozHe/Rpm"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3477E38F239
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 06:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774506402; cv=none; b=DeLqwBjNeZUDHk33fMNUMdT18t3vExNJP5ZIZIMbv9Fsdm0BagCotEfKwQKB7/Yhc3ZGqLB7LkXYwMpb0lFOpbUkkRCD1joTVkQuo4IFxZsgDVepZE0UTCw8/dTIL+6PWJYkGQz9MpSzV4dhB/n4BUBKsAaeDAYidayJUdjtkAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774506402; c=relaxed/simple;
	bh=DnRIzX0hBwXd/Ulw6QVfouiLtToEjZ9H2jhzh+wlpIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QOYn+R7Fix6p6gJ4UdBqr0hkuO79Fi9MRR8Em6DGcCpvaaa/V6v9WoWQLta5JAgGOU/vxfkdTnstcmRi+gtYONOH8XpGsMST6W8F3Tix3uIo7tMKrmLwX8sgZM4a54+EUBNI0bPmigUUfacE50HP6wRLyR+Xlfl2xHZt9F1q8h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ozHe/Rpm; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dd043c69-4d03-46fe-8325-8f97101435cf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774506398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=478mCIfLG4518iPcZWZwANHxYmr9jmXXnsrIUimPqK8=;
	b=ozHe/Rpm44EqYiJeysKFASSSwPol+29egozoRPNBanzav/uZEANKyasiE2SjVOx6cwHEQB
	0ou1Wd85s/v09o0wtfnpJxDx9EAiiSpprF2jFADCdXOH9NioXAZLfiTNWLu8PSEykSe/L4
	dWYKhOJpfRw5/yZVcKsEXCpKcFRrY24=
Date: Wed, 25 Mar 2026 23:26:30 -0700
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <fa818820-c0c9-48dc-8ebc-661cb3349935@rbox.co>
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
	TAGGED_FROM(0.00)[bounces-271854-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 12DC532FC1B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/15/26 4:58 PM, Michal Luczaj wrote:
>> Beside, from looking at the may_update_sockmap(), I don't know if it is
>> even doable (or useful) to bpf_map_update_elem(unix_sk) in
>> tc/flow_dissector/xdp. One possible path is the SOCK_FILTER when looking
>> at unix_dgram_sendmsg() => sk_filter(). It was not the original use case
>> when the bpf_map_update_elem(sockmap) support was added iirc.
> 
> What about a situation when unix_sk is stored in a sockmap, then tc prog
> looks it up and invokes bpf_map_update_elem(unix_sk)? I'm not sure it's
> useful, but seems doable.

[ Sorry for the late reply ]

It is a bummer that the bpf_map_update_elem(unix_sk) path is possible 
from tc :(

Then unix_state_lock() in its current form cannot be safely acquired in 
sock_map_update_elem(). It is currently a spin_lock() instead of 
spin_lock_bh().

> 
>> The only path left is bpf_iter, which I believe was the primary use case
>> when adding bpf_map_update_elem(sockmap) support [1]. It would be nice
>> to avoid bh_lock_sock() when calling from all bpf_iter (tcp/udp/unix)
>> where lock_sock() has already been done. It is more for
>> reading-correctness though. This just came to my mind.
>> has_current_bpf_ctx() can be used to check this. sockopt_lock_sock() has
>> been using it to conditionally take lock_sock() or not.
> 
> [ One clarification: bh_lock_sock() is a sock_map_update_elem() thing,
> which can only be called by a bpf prog. IOW, has_current_bpf_ctx() is
> always `true` in sock_map_update_elem(), right? ]

For all the bpf prog types allowed by may_update_sockmap() to do 
bpf_map_update_elem(sockmap), only BPF_TRACE_ITER should have 
has_current_bpf_ctx() == true. The tc prog (and others allowed in 
may_update_sockmap()) will have has_current_bpf_ctx() == false when 
calling sock_map_update_elem().

The tc case of bpf_map_update_elem(unix_sk) is unfortunate and requires 
going back to the drawing board. I think checking unix_peer(sk) for NULL 
without acquiring unix_state_lock() is needed for the 
sock_map_update_elem() path, since changing unix_state_lock() for this 
unknown use case seems overkill.

Whether sock_map_update_elem_"sys"() needs unix_state_lock() is up for 
debate.

For bpf_iter_unix_seq_show(), one thought is to add unix_state_lock() 
there before running the bpf iter prog. iiuc, it is what Kuniyuki has in 
mind also to allow bpf iter prog having a stable view of unix_sock. This 
could be a followup.
[fwiw, it was why I first thought of has_current_bpf_ctx() to avoid 
sock_map_update_elem() taking unix_state_lock() again if 
bpf_iter_unix_seq_show() acquires unix_state_lock() earlier. I later 
concluded (but proved to be incorrect) that tc cannot call 
bpf_map_update_elem(unix_sk).]

> 
> Let me know if I'm correctly rephrasing your idea: assume all bpf-context
> callers hold the socket locked or keep it "stable" (meaning: "sk won't
> surprise sockmap update by some breaking state change coming from another
> thread"). As you said, most bpf iters already take the sock_lock(), and I

Right, all bpf iter (udp, tcp, unix) has acquired the lock_sock() before 
running the bpf iter prog. afaik, the only exception is netlink bpf iter 
but it cannot be added to sock_map afaik.

> have a patch that fixes sock_{map,hash}_seq_show(). Then we could try
> dropping that bh_lock_sock().
> 
>> [ I would still keep patch 3 though. ]
> 
> Right.
> 
>> [1]: https://lore.kernel.org/bpf/20200821102948.21918-1-lmb@cloudflare.com/
>>
>>>
>>> In a parallel thread I've asked Kuniyuki if it might be better to
>>> completely drop patch 2/5, which would change how we interact with
>>> sock_map_close(). Lets see how it goes.
>>>
>>
>> If patch 2 is dropped, lock_sock() is always needed for unix_sk?
> 
> For sock_map_update_elem_sys() I wanted to lock_sock()+unix_state_lock()
> following Kuniyuki's suggestion to keep locking pattern/order (that repeats
> when unix bpf iter prog invokes bpf_map_update_elem() ->
> sock_map_update_elem()). For sock_map_update_elem() not, we can't sleep there.


