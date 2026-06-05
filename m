Return-Path: <netdev+bounces-295786-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JKmSDTOyImoWcQEAu9opvQ
	(envelope-from <netdev+bounces-295786-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 13:25:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AB5647B27
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 13:25:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=SVMH6nL9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295786-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295786-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 615A530056D5
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 11:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68B131F9B3;
	Fri,  5 Jun 2026 11:16:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C0D4D2EE3
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 11:16:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780658206; cv=none; b=OU7a9dv9z0U6erkdRwfkS8ZNzvP4+QCGsMrEkpLwUQQzCOpOqwkzqQcdRbCyCdsY80pt+OPzSECQvUl2kEG0Mz+oGpoZ+wtI6f1BrwEPxBlATnII0BaDC+ghB06wysmUiBv+u8TswdIRZdotvf3YK0pNJTCrmN3cSXFU86aR3gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780658206; c=relaxed/simple;
	bh=hY2dkKZdaw5KDnLwG6KL0YJAym/kj9aoWwirD08atPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YYIp2wWoU2sXOSQt97mReqBSB3kjwyloawnt7nS255ohm+nGc6mMW3RXRKUuFzA46lpVb9kdrGYggSyVpmXy5OO17zVKw8f32ZXsWwhdHjyvHM1k1taYgG99gb1skO6cnml6h2lhpcJ+4bEZOkNcySXl1IbZzYmeeDb73+WgEPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SVMH6nL9; arc=none smtp.client-ip=95.215.58.171
Message-ID: <b8f1b021-a255-4464-b1fa-559e8d961bb9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780658202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eRi6sWFcubB1ojJimFMtoX8Dt81siLGPz4iTPkPpfDo=;
	b=SVMH6nL9j0dn8Y1fG51izBEhOyssE7us5u35W9iPZzvYVmsw53qGEhQkkHR4TUIMszMf+f
	fFpDoBo8qImdJGFx51l53m6EDR7tgyKhaYfdgkG2AtVEx7EOoZYY0j/GUqoUSOwFHyRjga
	ykxFIKDafnvJHPz25U4aOwMeCwaRhZY=
Date: Fri, 5 Jun 2026 19:16:26 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] tcp: clear sock_ops cb flags before force-closing a
 child socket
To: Sechang Lim <rhkrqnwk98@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Neal Cardwell <ncardwell@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>,
 Lawrence Brakmo <brakmo@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20260605094954.1374489-1-rhkrqnwk98@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260605094954.1374489-1-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rhkrqnwk98@gmail.com,m:edumazet@google.com,m:ncardwell@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:kuniyu@google.com,m:horms@kernel.org,m:brakmo@fb.com,m:ast@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-295786-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[gmail.com,google.com,davemloft.net,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:from_mime,linux.dev:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 87AB5647B27


On 6/5/26 5:49 PM, Sechang Lim wrote:
> A child socket inherits the listener's bpf_sock_ops_cb_flags via
> sk_clone_lock(). If its setup fails in tcp_v4_syn_recv_sock() /
> tcp_v6_syn_recv_sock(), the child is freed through put_and_exit, where
> inet_csk_prepare_forced_close() drops the socket lock and tcp_done() runs
> without it.
>
> If BPF_SOCK_OPS_STATE_CB_FLAG was inherited, tcp_done() -> tcp_set_state()
> calls tcp_call_bpf(), which expects the lock and trips sock_owned_by_me():
>
>    WARNING: include/net/sock.h:1799 at tcp_set_state+0x433/0x550
>    RIP: 0010:tcp_set_state+0x433/0x550 include/net/sock.h:1799
>    Call Trace:
>     <IRQ>
>     tcp_done+0xba/0x250 net/ipv4/tcp.c:5095
>     tcp_v4_syn_recv_sock+0x850/0xa50 net/ipv4/tcp_ipv4.c:1787
>     tcp_check_req+0xf30/0x1360 net/ipv4/tcp_minisocks.c:926
>     tcp_v4_rcv+0x1047/0x1b50 net/ipv4/tcp_ipv4.c:2164
>     </IRQ>
>
> The child is freed before it is ever established, so it should run no
> sock_ops callback. Clear its cb flags before the forced close.
>
> Fixes: d44874910a26 ("bpf: Add BPF_SOCK_OPS_STATE_CB")
> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
> ---
>   include/net/tcp.h   | 7 +++++++
>   net/ipv4/tcp_ipv4.c | 1 +
>   net/ipv6/tcp_ipv6.c | 1 +
>   3 files changed, 9 insertions(+)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 98848db62894..97eac5fa341c 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -2942,6 +2942,11 @@ static inline int tcp_call_bpf_3arg(struct sock *sk, int op, u32 arg1, u32 arg2,
>   	return tcp_call_bpf(sk, op, 3, args);
>   }
>   
> +static inline void tcp_clear_sock_ops_cb_flags(struct sock *sk)
> +{
> +	tcp_sk(sk)->bpf_sock_ops_cb_flags = 0;
> +}
> +
>   #else
>   static inline int tcp_call_bpf(struct sock *sk, int op, u32 nargs, u32 *args)
>   {
> @@ -2959,6 +2964,8 @@ static inline int tcp_call_bpf_3arg(struct sock *sk, int op, u32 arg1, u32 arg2,
>   	return -EPERM;
>   }
>   
> +static inline void tcp_clear_sock_ops_cb_flags(struct sock *sk) {}
> +
>   #endif
>   
>   static inline u32 tcp_timeout_init(struct sock *sk)
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index fdc81150ff6c..7748668dba82 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -1783,6 +1783,7 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
>   	return NULL;
>   put_and_exit:
>   	newinet->inet_opt = NULL;
> +	tcp_clear_sock_ops_cb_flags(newsk);
>   	inet_csk_prepare_forced_close(newsk);


I prefer clearing the bit in inet_csk_prepare_forced_close(), since it 
looks like inet_csk_prepare_forced_close()
is already a TCP-specific function.

Let's wait for the TCP maintainer's.


>   	tcp_done(newsk);
>   	goto exit;
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index 36d75fb50a70..493477b786db 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -1531,6 +1531,7 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
>   	tcp_listendrop(sk);
>   	return NULL;
>   put_and_exit:
> +	tcp_clear_sock_ops_cb_flags(newsk);
>   	inet_csk_prepare_forced_close(newsk);
>   	tcp_done(newsk);
>   	goto exit;

