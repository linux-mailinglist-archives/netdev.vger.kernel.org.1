Return-Path: <netdev+bounces-266367-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIv3LkmZsGkukgIAu9opvQ
	(envelope-from <netdev+bounces-266367-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 23:20:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A269258DBA
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 23:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CE6F30AD48C
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 22:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEADA369223;
	Tue, 10 Mar 2026 22:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xau2eUuB"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284FC33A9DB
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 22:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773181255; cv=none; b=kIT3Z6sbdDPPIJBCOGNadNe53tgN4h8uH8Auh2vhYrbVLJEjs30karBj9V8SrMQp+LUK2n/NoO15hSasOnc6WzPe2B6+kh1NStSrZS2mJYtp6jEMzGctDgh5dvTAtF9xa4XeJbysTLrh58J//Yoo+9eD2PRRmBI65nLfS2SpIsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773181255; c=relaxed/simple;
	bh=avKNWTDhM6bAwEi61OcG+RVe1r6lZ8VLh2TjI3n/Zsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PD4YR5wyINbSDPdhrEkVejzmpG5qmviHc3+Rqe1h20W7v4npMGO9+CzvZl7k/vHwJzHEhuuVvfNKnwmQ2AF5CHzxMsELC6NSho6OvHqE5ry3vl2vN0BO98kDiGfH6gjgE50+CcsroeB1OrC5fY+xp3QRZEwj88EJ35EbT0wuZR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xau2eUuB; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b21fac4e-891b-481c-9734-e95290e49097@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773181242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=USTS8bgmtjRodpsAsHJK5v2/OgPARYxfKHdIFoQaapk=;
	b=xau2eUuBC5kEVoNphuT/ROBU0VOnrt1SDxk9ipiW/6Zmn/Y/PUn5p17FWCJbVsrIKLJvLH
	vg7vG/Ex3vGPJhr/9F51EwkuhTOwb1DeTTtGhBGjx1Tkgy3UCfddL3QivmJXEIDGPZITMX
	p4Oh4YC6B6ocaDYYH4XGsxnBHim1GQI=
Date: Tue, 10 Mar 2026 15:20:34 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v3 5/5] bpf, sockmap: Adapt for af_unix-specific lock
To: Michal Luczaj <mhal@rbox.co>, Jiayuan Chen <mrpre@163.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <b9a956dd-ebb2-47ca-8b49-ccbba6ff9b26@rbox.co>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 6A269258DBA
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
	TAGGED_FROM(0.00)[bounces-266367-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[rbox.co,163.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,cloudflare.com,google.com,redhat.com,davemloft.net,kernel.org,fb.com,iogearbox.net,linux.dev,fomichev.me,bytedance.com,vger.kernel.org];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action



On 3/6/26 6:09 AM, Michal Luczaj wrote:
> On 3/6/26 06:01, Jiayuan Chen wrote:
>>
>> On 3/6/26 7:30 AM, Michal Luczaj wrote:
>>> unix_stream_connect() sets sk_state (`WRITE_ONCE(sk->sk_state,
>>> TCP_ESTABLISHED)`) _before_ it assigns a peer (`unix_peer(sk) = newsk`).
>>> sk_state == TCP_ESTABLISHED makes sock_map_sk_state_allowed() believe that
>>> socket is properly set up, which would include having a defined peer. IOW,
>>> there's a window when unix_stream_bpf_update_proto() can be called on
>>> socket which still has unix_peer(sk) == NULL.
>>>
>>>             T0 bpf                            T1 connect
>>>             ------                            ----------
>>>
>>>                                   WRITE_ONCE(sk->sk_state, TCP_ESTABLISHED)
>>> sock_map_sk_state_allowed(sk)
>>> ...
>>> sk_pair = unix_peer(sk)
>>> sock_hold(sk_pair)
>>>                                   sock_hold(newsk)
>>>                                   smp_mb__after_atomic()
>>>                                   unix_peer(sk) = newsk
>>>
>>> BUG: kernel NULL pointer dereference, address: 0000000000000080
>>> RIP: 0010:unix_stream_bpf_update_proto+0xa0/0x1b0
>>> Call Trace:
>>>     sock_map_link+0x564/0x8b0
>>>     sock_map_update_common+0x6e/0x340
>>>     sock_map_update_elem_sys+0x17d/0x240
>>>     __sys_bpf+0x26db/0x3250
>>>     __x64_sys_bpf+0x21/0x30
>>>     do_syscall_64+0x6b/0x3a0
>>>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>
>>> Initial idea was to move peer assignment _before_ the sk_state update[1],
>>> but that involved an additional memory barrier, and changing the hot path
>>> was rejected. Then a check during proto update was considered[2], but a
>>> follow-up discussion[3] concluded the root cause is sockmap taking a wrong
>>> lock. Or, more specifically, an insufficient lock[4].
>>>
>>> Thus, teach sockmap about the af_unix-specific locking: af_unix protects
>>> critical sections under unix_state_lock() operating on unix_sock::lock.
>>>
>>> [1]: https://lore.kernel.org/netdev/ba5c50aa-1df4-40c2-ab33-a72022c5a32e@rbox.co/
>>> [2]: https://lore.kernel.org/netdev/20240610174906.32921-1-kuniyu@amazon.com/
>>> [3]: https://lore.kernel.org/netdev/7603c0e6-cd5b-452b-b710-73b64bd9de26@linux.dev/
>>> [4]: https://lore.kernel.org/netdev/CAAVpQUA+8GL_j63CaKb8hbxoL21izD58yr1NvhOhU=j+35+3og@mail.gmail.com/
>>>
>>> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
>>> Suggested-by: Martin KaFai Lau <martin.lau@linux.dev>
>>> Fixes: c63829182c37 ("af_unix: Implement ->psock_update_sk_prot()")
>>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>>> ---
>>>    net/core/sock_map.c | 35 +++++++++++++++++++++++++++++------
>>>    1 file changed, 29 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
>>> index 7ba6a7f24ccd..6109fbe6f99c 100644
>>> --- a/net/core/sock_map.c
>>> +++ b/net/core/sock_map.c
>>> @@ -12,6 +12,7 @@
>>>    #include <linux/list.h>
>>>    #include <linux/jhash.h>
>>>    #include <linux/sock_diag.h>
>>> +#include <net/af_unix.h>
>>>    #include <net/udp.h>
>>>    
>>>    struct bpf_stab {
>>> @@ -115,19 +116,43 @@ int sock_map_prog_detach(const union bpf_attr *attr, enum bpf_prog_type ptype)
>>>    }
>>>    
>>>    static void sock_map_sk_acquire(struct sock *sk)
>>> -	__acquires(&sk->sk_lock.slock)
>>>    {
>>>    	lock_sock(sk);
>>> +
>>> +	if (sk_is_unix(sk))
>>> +		unix_state_lock(sk);
>>> +
>>>    	rcu_read_lock();
>>>    }
>>>    
>>
>> This introduces a new ordering constraint: lock_sock() before
>> unix_state_lock(). Kuniyuki flagged in the v2 review that taking
>> lock_sock() inside unix_state_lock() in the future would create an
>> ABBA deadlock, which is exactly why the order was settled this way. However,
>> the thread did not reach a conclusion on whether that constraint should be
>> documented in the code.
>>
>> Since there is nothing enforcing this ordering mechanically, a brief comment
>> at sock_map_sk_acquire() would help future readers avoid introducing the
>> inverse ordering.
> 
> Sure, will do.
> 
>>>    static void sock_map_sk_release(struct sock *sk)
>>> -	__releases(&sk->sk_lock.slock)
>>>    {
>>>    	rcu_read_unlock();
>>> +
>>> +	if (sk_is_unix(sk))
>>> +		unix_state_unlock(sk);
>>> +
>>>    	release_sock(sk);
>>>    }
>>>    
>>> +static inline void sock_map_sk_acquire_fast(struct sock *sk)
>>> +{
>>> +	local_bh_disable();
>>> +	bh_lock_sock(sk);
>>> +
>>> +	if (sk_is_unix(sk))
>>> +		unix_state_lock(sk);
>>> +}
>>> +
>>
>>
>> v2 and v3 differ here in a way that deserves a closer look. In v2, AF_UNIX
>> sockets took only unix_state_lock() in the fast path, skipping
>> bh_lock_sock() entirely:
>>
>> /* v2 */
>> if (sk_is_unix(sk))
>>     unix_state_lock(sk);
>> else
>>     bh_lock_sock(sk);
>>
>> v3 takes both for AF_UNIX sockets.
>>
>> bh_lock_sock() protects sock::sk_lock.slock, whereas the state that
>> actually needs protection here — sk_state and unix_peer() — lives under
>> unix_sock::lock. Since unix_state_lock() is already sufficient to close
>> the race against unix_stream_connect(), is bh_lock_sock() still doing
>> anything useful for AF_UNIX sockets in this path?
> 
> Yeah, good point. I think I was just trying to keep the _fast variant
> aligned with the sleepy one. Which I agree might be unnecessary.

I hope the common use case should not be calling 
bpf_map_update_elem(sockmap) only.

Beside, from looking at the may_update_sockmap(), I don't know if it is 
even doable (or useful) to bpf_map_update_elem(unix_sk) in 
tc/flow_dissector/xdp. One possible path is the SOCK_FILTER when looking 
at unix_dgram_sendmsg() => sk_filter(). It was not the original use case 
when the bpf_map_update_elem(sockmap) support was added iirc.

The only path left is bpf_iter, which I believe was the primary use case 
when adding bpf_map_update_elem(sockmap) support [1]. It would be nice 
to avoid bh_lock_sock() when calling from all bpf_iter (tcp/udp/unix) 
where lock_sock() has already been done. It is more for 
reading-correctness though. This just came to my mind. 
has_current_bpf_ctx() can be used to check this. sockopt_lock_sock() has 
been using it to conditionally take lock_sock() or not. [ I would still 
keep patch 3 though. ]

[1]: https://lore.kernel.org/bpf/20200821102948.21918-1-lmb@cloudflare.com/

> 
> In a parallel thread I've asked Kuniyuki if it might be better to
> completely drop patch 2/5, which would change how we interact with
> sock_map_close(). Lets see how it goes.
> 

If patch 2 is dropped, lock_sock() is always needed for unix_sk?

