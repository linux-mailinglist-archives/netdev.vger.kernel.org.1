Return-Path: <netdev+bounces-254904-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNldJ+m3e2k0IAIAu9opvQ
	(envelope-from <netdev+bounces-254904-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 20:41:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B722B40CF
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 20:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1261B3010B82
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 19:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD08310774;
	Thu, 29 Jan 2026 19:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SHPFSb1e"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B501F09A8
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 19:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769715686; cv=none; b=azQGTqSCq31XKI3FHcvH07juOsUMrdlnhFsHgP4OgdZ7pVqInOA4f9bYCi33t1N/K3oBQ9/3Z6e9zwwvoCkNxKMTNSh89NIGPU2oxee3dUxpQR4Kf6tS44t51g7f3ecF8T7zZzN43Tileuy+pknDofJsPMxDPGkzcpMH2+sYyhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769715686; c=relaxed/simple;
	bh=uBatAwxamom+Rl7t0KhxXZt/c0P+ecqqDElQoI25Cnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TbQsj5M6qPBC6DpZxk5//GOKseRvgegUQ8xeIUevcyI/NPdUlNds9JOhqObiH2ZsZfw+5skA1Wtqc3DmnhD12micHfF3k1ctfF1P3GcA8joxy2r4FHSEjPFDaJ4WlLtX9wkZk/a9TcC8FnfjUZAO55ai2nik9WnSUaSPY6lHlKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SHPFSb1e; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3fc5611f-394f-40db-b49d-2f26402e221a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769715682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bk5LNsa/TyXTPv/I3Ufz7aUGlVl7nkzQOsi7WqYsTx0=;
	b=SHPFSb1eyvEX2fO4Te5XdOxJINSWanhSChLruufPfgIa1KE1qPut6+a8EROCApCGFTk98z
	THdfrupcfP5cy3of0RHR1aAqGnxGcNtkVgunPn81AkBLHgTxgOXdRkTk/Fd30PPntg6M64
	UchlfwzqQ+wIa+MZSbxlnExiwwVS+1w=
Date: Thu, 29 Jan 2026 11:41:17 -0800
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20260129-unix-proto-update-null-ptr-deref-v1-1-e1daeb7012fd@rbox.co>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254904-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,cloudflare.com,google.com,davemloft.net,kernel.org,redhat.com,iogearbox.net,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rbox.co:email]
X-Rspamd-Queue-Id: 1B722B40CF
X-Rspamd-Action: no action

On 1/29/26 8:47 AM, Michal Luczaj wrote:
> BPF_MAP_UPDATE_ELEM races unix_stream_connect(): when
> sock_map_sk_state_allowed() passes (sk_state == TCP_ESTABLISHED),
> unix_peer(sk) in unix_stream_bpf_update_proto() may still return NULL.
> 
> 	T0 bpf				T1 connect
> 	------				----------
> 
> 				WRITE_ONCE(sk->sk_state, TCP_ESTABLISHED)
> sock_map_sk_state_allowed(sk)
> ...
> sk_pair = unix_peer(sk)
> sock_hold(sk_pair)
> 				sock_hold(newsk)
> 				smp_mb__after_atomic()
> 				unix_peer(sk) = newsk
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000080
> RIP: 0010:unix_stream_bpf_update_proto+0xa0/0x1b0
> Call Trace:
>   sock_map_link+0x564/0x8b0
>   sock_map_update_common+0x6e/0x340
>   sock_map_update_elem_sys+0x17d/0x240
>   __sys_bpf+0x26db/0x3250
>   __x64_sys_bpf+0x21/0x30
>   do_syscall_64+0x6b/0x3a0
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Follow-up to discussion at
> https://lore.kernel.org/netdev/20240610174906.32921-1-kuniyu@amazon.com/.

It is a long thread to dig. Please summarize the discussion in the 
commit message.

 From looking at this commit message, if the existing lock_sock held by 
update_elem is not useful for af_unix, it is not clear why a new test 
"!sk_pair" on top of the existing WRITE_ONCE(sk->sk_state...) is a fix. 
A minor thing is sock_map_sk_state_allowed doesn't have 
READ_ONCE(sk->sk_state) for sk_is_stream_unix also.

If unix_stream_connect does not hold lock_sock, can unix_state_lock be 
used here? lock_sock has already been taken, update_elem should not be 
the hot path.

> 
> Fixes: 8866730aed51 ("bpf, sockmap: af_unix stream sockets need to hold ref for pair sock")
> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---
> Re-triggered while working on an unrelated selftest:
> https://lore.kernel.org/bpf/20260123-selftest-signal-on-connect-v1-0-b0256e7025b6@rbox.co/
> ---
>   net/unix/unix_bpf.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/net/unix/unix_bpf.c b/net/unix/unix_bpf.c
> index e0d30d6d22ac..57f3124c9d8d 100644
> --- a/net/unix/unix_bpf.c
> +++ b/net/unix/unix_bpf.c
> @@ -185,6 +185,9 @@ int unix_stream_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool r
>   	 */
>   	if (!psock->sk_pair) {
>   		sk_pair = unix_peer(sk);
> +		if (unlikely(!sk_pair))
> +			return -EINVAL;
> +
>   		sock_hold(sk_pair);
>   		psock->sk_pair = sk_pair;
>   	}
> 
> ---
> base-commit: 63804fed149a6750ffd28610c5c1c98cce6bd377
> change-id: 20260129-unix-proto-update-null-ptr-deref-6a2733bcbbf8
> 
> Best regards,


