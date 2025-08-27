Return-Path: <netdev+bounces-217517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE68BB38F5C
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 01:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 119CC1C24099
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 23:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D4E21147B;
	Wed, 27 Aug 2025 23:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tmEt1cmU"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B847260A
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 23:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756338499; cv=none; b=Dge87AoDVGqoCl7rIPgMTGsyI/7DSYFESqjRNhkfPK0A4+0NZGkUqAeE8LrQyTqnYjbukAUimUTwcJ2KJvMmtajMJkbNQPgZwaqroJxiDrFyomrji5L+jQ5EZYg6l1F0j5QUbSY6A/Egonx6ezt0wT5vU0BPKvD5MB/boMH6MT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756338499; c=relaxed/simple;
	bh=f/Qiy73V/ZJ7zsraRhexgT97PVGlssecOmU8Hlg2jgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iJg6iMCtWtsU2LQGzI6rGwyZOnHu0S+NXspi+7yQKSY9H+gOIoeXVPJeVGkQFsBZuhkSArKSvzh3R8H/oO95jDetb7gVbhk0MOdudhskdFxFigXetZ5Rcnb9K6GDqwO+5EVbQA1153mCU6loFmCTxAbx2wAKdu0KpP7KGFP0qTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tmEt1cmU; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9919daa2-b6e0-4d5c-b349-39b055eaaed2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756338494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cR+n5ZWIx4K7+wW5JjUKJHp42I9G5jLg44eeFXN6wNs=;
	b=tmEt1cmUgyUNwyRWU3i+CndLkDJkC+2KVtOI+dGGBay2+RiMISjjHNsJdYSySttX1F36z+
	CjeKM+E1C/FOyAh/Dr4tNR+/hn3v7rJnhqOuUECemkLkyzxgemAigjiu7wfIR4yhZ1RnsP
	2Xqs+2WBw3aDCPXnxHQzEPZkdgrsv0U=
Date: Wed, 27 Aug 2025 16:48:07 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 bpf-next/net 3/5] bpf: Introduce SK_BPF_MEMCG_FLAGS and
 SK_BPF_MEMCG_SOCK_ISOLATED.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>,
 Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250826183940.3310118-1-kuniyu@google.com>
 <20250826183940.3310118-4-kuniyu@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250826183940.3310118-4-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/26/25 11:38 AM, Kuniyuki Iwashima wrote:
> The main targets are BPF_CGROUP_INET_SOCK_CREATE and
> BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB as demonstrated in the selftest.
> 
> Note that we do not support modifying the flag once sk->sk_memcg is set
> especially because UDP charges memory under sk->sk_receive_queue.lock
> instead of lock_sock().
> 

[ ... ]

> diff --git a/include/net/sock.h b/include/net/sock.h
> index 63a6a48afb48..d41a2f8f8b30 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -2596,10 +2596,39 @@ static inline gfp_t gfp_memcg_charge(void)
>   	return in_softirq() ? GFP_ATOMIC : GFP_KERNEL;
>   }
>   
> +#define SK_BPF_MEMCG_FLAG_MASK	(SK_BPF_MEMCG_FLAG_MAX - 1)
> +#define SK_BPF_MEMCG_PTR_MASK	~SK_BPF_MEMCG_FLAG_MASK
> +
>   #ifdef CONFIG_MEMCG
> +static inline void mem_cgroup_sk_set_flags(struct sock *sk, unsigned short flags)
> +{
> +	unsigned long val = (unsigned long)sk->sk_memcg;
> +
> +	val |= flags;
> +	sk->sk_memcg = (struct mem_cgroup *)val;
> +}
> +

[ ... ]

> +static int sk_bpf_set_get_memcg_flags(struct sock *sk, int *optval, bool getopt)
> +{
> +	if (!sk_has_account(sk))
> +		return -EOPNOTSUPP;
> +
> +	if (getopt) {
> +		*optval = mem_cgroup_sk_get_flags(sk);
> +		return 0;
> +	}
> +
> +	if (sock_owned_by_user_nocheck(sk) && mem_cgroup_from_sk(sk))

I still don't see how this can stop some of the bh bpf prog to set/clear the bit 
after mem_cgroup_sk_alloc() is done. For example, in BPF_SOCK_OPS_RETRANS_CB, 
bh_lock_sock() is held but not owned by user, so the bpf prog can continue to 
change the SK_BPF_MEMCG_FLAGS. What am I missing?

Passing some more args to __bpf_setsockopt() for caller context purpose is quite 
ugly which I think you also mentioned/tried earlier. May be it can check "if 
(in_softirq() && mem_cgroup_from_sk(sk)) return -EBUSY" but looks quite tricky 
together with the sock_owned_by_user_nocheck().

It seems this sk_memcg bit change is only needed for sock_ops hook and create 
hook? sock_ops already has its only func_proto bpf_sock_ops_setsockopt(). 
bpf_sock_ops_setsockopt can directly call sk_bpf_set_get_memcg_flags() but limit 
it to the BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB. Is it also safe to allow it for 
BPF_SOCK_OPS_TCP_LISTEN_CB? For the create hook, create a new func proto which 
can directly call sk_bpf_set_get_memcg_flags(). wdyt?

> +		return -EBUSY;
> +
> +	if (*optval <= 0 || *optval >= SK_BPF_MEMCG_FLAG_MAX)

It seems the bit cannot be cleared (the *optval <= 0 check). There could be 
multiple bpf progs running in a cgroup which want to clear this bit. e.g. the 
parent cgroup's prog may want to ensure this bit is not set.



