Return-Path: <netdev+bounces-255981-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOi8CN73gGmxDQMAu9opvQ
	(envelope-from <netdev+bounces-255981-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 20:15:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 34AA5D0705
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 20:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7F65D3004C9F
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 19:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B364A3002BA;
	Mon,  2 Feb 2026 19:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="esoSanGJ"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9CA2DA779
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 19:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770059736; cv=none; b=D40GuL0pcyZ0w1O9/6tzDg/dtVxi73+WztFXYkEypoz2TY6oiuPaCi6MZ1rGGK6dbEk223MUu5XXmKIcr0V3DsjB9FeV4ZurDf4Aec+2CKZ0BlX0J22LxP9jSZpv7p8IWkZl7KByBzcTDV/vSOSeBU9/g7GW4SzPPESAq24eMlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770059736; c=relaxed/simple;
	bh=9VFgvnb2SQG84MHF8K/s4Z/WcrfiHqwobIXEi8KC1Ps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QhQhx8b62I3rykIGV/Ck6CvreuYOxf3gmL4pmVumajktBtvx/oGye/SKbyQdI1IlJxLfrUwvxXirh/Q6Gxq7P9+iPWZQ+KWI+G/YdfRGRY1OIY/wdXdSgsIfiZgyN5r4eTxVt2KgUfj5siUPGG90vWdpU7YXkxSYJJB6sMsHpIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=esoSanGJ; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7603c0e6-cd5b-452b-b710-73b64bd9de26@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770059731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8hHhZlQCKZl589HvHnAQeer7frVqLGswU0Xq6rQMtMw=;
	b=esoSanGJ2W9A3cCIFUUCPOo/tfV5mwyZ0eNaUWaZx9LpwtlXoJVGuYrhPV0Q9VjsFeW/60
	3Md6Qh1JuBZL+0gfrVHa9tL/hBnthVwXtl9dSdyfA9GhWl5KJryMnUL+oJ7LrAh9h0/eHe
	u/9ta1mRXK+ukL/CGIwJyjn5IFEyxPw=
Date: Mon, 2 Feb 2026 11:15:25 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf, sockmap: Fix af_unix null-ptr-deref in proto
 update
To: Kuniyuki Iwashima <kuniyu@google.com>, Michal Luczaj <mhal@rbox.co>,
 Jakub Sitnicki <jakub@cloudflare.com>,
 John Fastabend <john.fastabend@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260129-unix-proto-update-null-ptr-deref-v1-1-e1daeb7012fd@rbox.co>
 <3fc5611f-394f-40db-b49d-2f26402e221a@linux.dev>
 <3362017f-9c3d-46cd-b3ce-cb750b565d5b@rbox.co>
 <612a9446-252f-4b14-8605-ae1af000cc41@linux.dev>
 <CAAVpQUAc3S+Ebx2qp-Pbg9qH-Zc=yHdzVJbchCu++V_4XF3DLg@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAAVpQUAc3S+Ebx2qp-Pbg9qH-Zc=yHdzVJbchCu++V_4XF3DLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255981-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[google.com,rbox.co,cloudflare.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 34AA5D0705
X-Rspamd-Action: no action

On 1/31/26 2:06 AM, Kuniyuki Iwashima wrote:
> On Fri, Jan 30, 2026 at 1:30 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 1/30/26 3:00 AM, Michal Luczaj wrote:
>>>>> Follow-up to discussion at
>>>>> https://lore.kernel.org/netdev/20240610174906.32921-1-kuniyu@amazon.com/.
>>>>
>>>> It is a long thread to dig. Please summarize the discussion in the
>>>> commit message.
>>>
>>> OK, there we go:
>>>
>>> The root cause of the null-ptr-deref is that unix_stream_connect() sets
>>> sk_state (`WRITE_ONCE(sk->sk_state, TCP_ESTABLISHED)`) _before_ it assigns
>>> a peer (`unix_peer(sk) = newsk`). sk_state == TCP_ESTABLISHED makes
>>> sock_map_sk_state_allowed() believe that socket is properly set up, which
>>> would include having a defined peer.
>>>
>>> In other words, there's a window when you can call
>>> unix_stream_bpf_update_proto() on socket which still has unix_peer(sk) == NULL.
>>>
>>> My initial idea was to simply move peer assignment _before_ the sk_state
>>> update, but the maintainer wasn't interested in changing the
>>> unix_stream_connect() hot path. He suggested taking care of it in the
>>> sockmap code.
> 
> Yes, we already have a memory barrier for unix_peer(sk) there
> (to save sock_hold()/sock_put() in sendmsg(), see 830a1e5c212fb)
> and another one just for sk->sk_state is not worth the unlikely
> case in sockmap by a buggy user.
> 
> 
>>>
>>> My understanding is that users are not supposed to put sockets in a sockmap
>>> when said socket is only half-way through connect() call. Hence `return
>>> -EINVAL` on a missing peer. Now, if users should be allowed to legally race
>>> connect() vs. sockmap update, then I guess we can wait for connect() to
>>> "finalize" e.g. by taking the unix_state_lock(), as discussed below.
> 
> If a user hit the issue, the user must have updated sockmap while the
> user knows connect() had not returned.  Such a user must prepare
> for failures since it could occur before sock_map_sk_state_allowed() too.
> 
> This is a subtle timing issue and I don't think the kernel should be
> friendly to such buggy users by waiting for connect() etc.

I don't have a use case for parallel connect and map update either. 
Also, I have no concern about returning -EINVAL in map_update for the 
not-yet-completed unix_stream_connect().

However, TCP/UDP (and probably vsock also?) do not have this racing 
issue because sock_map follows the lock usage in TCP/UDP as in other 
parts of the kernel. Why AF_UNIX is an exception and unix_state_lock() 
is not used in sock_map.

John and Jakub Stinicki, could this be an oversight?

>>>
>>>>    From looking at this commit message, if the existing lock_sock held by
>>>> update_elem is not useful for af_unix,
>>>
>>> Right, the existing lock_sock is not useful. update's lock_sock holds
>>> sock::sk_lock, while unix_state_lock() holds unix_sock::lock.
>>
>> It sounds like lock_sock is the incorrect lock to hold for af_unix. Is
>> taking lock_sock in sock_map doing anything useful for af_unix? Should
>> sock_map hold the unix_state_lock instead of lock_sock?
> 
> If sockmap code does not sleep, unix_state_lock can be used there.

afaik, bpf prog using the sockmap cannot sleep. Search for "if 
(prog->sleepable)" in "check_map_prog_compatibility()". The bpf prog 
attached to sock_map cannot sleep either, there is "can_be_sleepable()" 
check in the verifier.

>>>
>>>           if (!psock->sk_pair) {
>>> +               unix_state_lock(sk);
>>> +               unix_state_unlock(sk);
> 
> I don't like this... we had a similar one in recvmsg(MSG_PEEK) path
> for GC with a biiiiiig comment, which I removed in 118f457da9ed .

Me neither, for both empty critical section and big fat comment. This 
usually suggests something else is incorrect to begin with. I believe 
the wrong lock is taken in this case. Unless there is something 
prohibiting taking unix_state_lock in sock_map, fix it properly instead.

> 
> 
>>>                   sk_pair = unix_peer(sk);
>>>                   sock_hold(sk_pair);
>>
>> I don't have a strong opinion on waiting or checking NULL. imo, both are
>> not easy to understand. One is sk_state had already been checked earlier
>> under a lock_sock but still needs to check NULL on unix_peer(). Another
>> one is an empty unix_state_[un]lock(). If taking unix_state_lock, may as
>> well just use the existing unix_peer_get(sk).
> 
> Yes, unix_peer_get() can be safely used there (with extra sock_put()).

The sock_map needs to sock_hold(sk_pair) anyway and stores it in 
psock->sk_pair, so I don't think it needs an extra sock_put().

> 
> 
>> If its return value cannot
>> (?) be NULL, WARN_ON_ONCE() instead of having a special empty
> 
> I suggested WARN_ON_ONCE() because Michal reproduced it with
> mdelay() and I did not think it could occur in real life, but considering
> PREEMPT_RT, it could be real.  So, the current form in this patch looks
> good to me.

hmm... If unix_peer_get(sk) is used and it takes (and waits for) the 
unix_state_lock, it shouldn't be NULL? The above empty [un]lock idea 
does not check for NULL on unix_peer() either. Or am I missing something?

Regardless, if the proper lock is held, all this complication and 
reasoning will go away.


