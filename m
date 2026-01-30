Return-Path: <netdev+bounces-255265-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yP4fCvEifWnPQQIAu9opvQ
	(envelope-from <netdev+bounces-255265-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 22:30:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B09BECD7
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 22:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86F76301573C
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 21:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D54C3328ED;
	Fri, 30 Jan 2026 21:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QAit1qa1"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1952E2E888A
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 21:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769808603; cv=none; b=Q6w4ej+HCtxGyrWcM0Yx9zyLcMlkXxyl2zntJQ3lDzwchcC4DGFSJNzjz6omPRF0VzUIRe5Pd3bXOhIImToNRH2/QLrIbLE94vmBL0k2NrPX6uQdH+En9AqsuIa9Kv+O558mtM8XbjsElBTaicpNzSrdOBcmYhdfMlmWMQ/lh9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769808603; c=relaxed/simple;
	bh=b+vwJ9y30rUaQsDIpqZJs8VFgrKQ3ws6Xm10+oYFD20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VzFd6b+lraF99HohgrqenFibJDsn5QVcCnnBuxtdghVO02oyLXD8Wj9/NZduBhB7l2czghoU13tPEieCGldbz2lvXCCT7gMFiSrd8cg8N/nICmZZfkvXs6ZTERp1veytorKyAkZgdNlTkYd6mlsDelmuP9kJv3IuLmbdeIGt4Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QAit1qa1; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <612a9446-252f-4b14-8605-ae1af000cc41@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769808590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E/fSgabw+7+o6zSM1t5+SlD+OpWpaotw1m3TFeXRHAo=;
	b=QAit1qa1XRfuS5NlnGz0ACxb91GrlF/N1yOL9KlYhxlnN+7r2Lh4eaeC3Ds+CWvimISqA1
	fEooa8tWAD0Y1hZnIerWQyQSec859ooeskaqw/cFaG1sZiWk2RvbR2Ie5nPhCXTTTKsSuG
	pcbC/H7gnnKyCnzlyglTyb+dJV9TiFo=
Date: Fri, 30 Jan 2026 13:29:44 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf, sockmap: Fix af_unix null-ptr-deref in proto
 update
To: Michal Luczaj <mhal@rbox.co>
Cc: John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, Kuniyuki Iwashima
 <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260129-unix-proto-update-null-ptr-deref-v1-1-e1daeb7012fd@rbox.co>
 <3fc5611f-394f-40db-b49d-2f26402e221a@linux.dev>
 <3362017f-9c3d-46cd-b3ce-cb750b565d5b@rbox.co>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <3362017f-9c3d-46cd-b3ce-cb750b565d5b@rbox.co>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,cloudflare.com,google.com,davemloft.net,kernel.org,redhat.com,iogearbox.net,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-255265-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 87B09BECD7
X-Rspamd-Action: no action

On 1/30/26 3:00 AM, Michal Luczaj wrote:
>>> Follow-up to discussion at
>>> https://lore.kernel.org/netdev/20240610174906.32921-1-kuniyu@amazon.com/.
>>
>> It is a long thread to dig. Please summarize the discussion in the
>> commit message.
> 
> OK, there we go:
> 
> The root cause of the null-ptr-deref is that unix_stream_connect() sets
> sk_state (`WRITE_ONCE(sk->sk_state, TCP_ESTABLISHED)`) _before_ it assigns
> a peer (`unix_peer(sk) = newsk`). sk_state == TCP_ESTABLISHED makes
> sock_map_sk_state_allowed() believe that socket is properly set up, which
> would include having a defined peer.
> 
> In other words, there's a window when you can call
> unix_stream_bpf_update_proto() on socket which still has unix_peer(sk) == NULL.
> 
> My initial idea was to simply move peer assignment _before_ the sk_state
> update, but the maintainer wasn't interested in changing the
> unix_stream_connect() hot path. He suggested taking care of it in the
> sockmap code.
> 
> My understanding is that users are not supposed to put sockets in a sockmap
> when said socket is only half-way through connect() call. Hence `return
> -EINVAL` on a missing peer. Now, if users should be allowed to legally race
> connect() vs. sockmap update, then I guess we can wait for connect() to
> "finalize" e.g. by taking the unix_state_lock(), as discussed below.
> 
>>   From looking at this commit message, if the existing lock_sock held by
>> update_elem is not useful for af_unix,
> 
> Right, the existing lock_sock is not useful. update's lock_sock holds
> sock::sk_lock, while unix_state_lock() holds unix_sock::lock.

It sounds like lock_sock is the incorrect lock to hold for af_unix. Is 
taking lock_sock in sock_map doing anything useful for af_unix? Should 
sock_map hold the unix_state_lock instead of lock_sock?

Other than update_elem, do other lock_sock() usages in sock_map have a 
similar issue for af_unix?

> 
>> it is not clear why a new test
>> "!sk_pair" on top of the existing WRITE_ONCE(sk->sk_state...) is a fix.
> 
> "On top"? Just to make sure we're looking at the same thing: above I was
> trying to show two parallel flows with unix_peer() fetch in thread-0 and
> WRITE_ONCE(sk->sk_state...) and `unix_peer(sk) = newsk` in thread-1.
> 
> It fixes the problem because now update_proto won't call sock_hold(NULL).
> 
>> A minor thing is sock_map_sk_state_allowed doesn't have
>> READ_ONCE(sk->sk_state) for sk_is_stream_unix also.
> 
> Ok, I'll add this as a separate patch in v2. Along with the !tcp case of
> sock_map_redirect_allowed()?

sgtm. thanks.

> 
>> If unix_stream_connect does not hold lock_sock, can unix_state_lock be
>> used here? lock_sock has already been taken, update_elem should not be
>> the hot path.
> 
> Yes, it can be used, it was proposed in the old thread. In fact, critical
> section can be empty; only used to wait for unix_stream_connect() to
> release the lock, which would guarantee unix_peer(sk) != NULL by then.
> 
>          if (!psock->sk_pair) {
> +               unix_state_lock(sk);
> +               unix_state_unlock(sk);
>                  sk_pair = unix_peer(sk);
>                  sock_hold(sk_pair);

I don't have a strong opinion on waiting or checking NULL. imo, both are 
not easy to understand. One is sk_state had already been checked earlier 
under a lock_sock but still needs to check NULL on unix_peer(). Another 
one is an empty unix_state_[un]lock(). If taking unix_state_lock, may as 
well just use the existing unix_peer_get(sk). If its return value cannot 
(?) be NULL, WARN_ON_ONCE() instead of having a special empty 
lock/unlock pattern here. If the correct lock (unix_state_lock) was held 
earlier in update_elem, all these would go away.

Also, it is not immediately clear why a non-NULL unix_peer(sk) is safe 
here. From looking around af_unix.c, is it because the sk refcnt is held 
earlier in update_elem? For unix_stream, unix_peer(sk) will stay valid 
until unix_release_sock(sk). Am I reading it correctly?


