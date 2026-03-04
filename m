Return-Path: <netdev+bounces-264031-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CP2LLX+QqGnZvgAAu9opvQ
	(envelope-from <netdev+bounces-264031-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 21:05:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 742E7207632
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 21:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1324830217CC
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 20:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B16537E31F;
	Wed,  4 Mar 2026 20:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uU7eZEMj"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9030E382F39
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 20:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772654712; cv=none; b=sGBh2auBbByI67bjJJ26naleRoGJesOBYbIpbBX7n/un4mPWLZaVLsf+uN3sw6WmpGpKEtWOXpqX+AefE//aTCiR2DMzAQdIDi2ZzX4dv/lifVUHluwav0thqM7/i/dJyQFb0Z/zcuXrR57ZLwDFqdbK46zXCM2D+sf8Xed7E1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772654712; c=relaxed/simple;
	bh=NpUFwyUgSuYBQmeGkwy9kAbvF8zBjoX3KWebaPZvTc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ijFDwB56AZycTyH4TTAXQGDwAEdJLxA3SDKxsUYIsZvI2mJzlyHbW8sRXCW4bvjE5d2EJYjVckUzr/7nPIwDHOKe7t3rjM1phtfb5qER+OabL2ZIF5N0N12bn1DTpDIEW76feNEwmDjcm3uDZlqrcHktnehbPvxCUgz0I6F6Qjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uU7eZEMj; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <88077a77-8b9e-4372-bb39-c7a638cfa3d4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772654698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qrx1k+j6Hc0CcsusWUFwKbAbMSjAEfYagm73wYyu458=;
	b=uU7eZEMjOirHuwe8RA/VBPljv7YfOgd2P9hVm+SVTvVCjbFOwfWsLaFRZgQdzH+SR96DAj
	1/AKaMZBaVOoIkrJmAgMCWjyMzi5FnMOEer4R8IW4aO1zCsIJvCCOLimbMz2+Elwz4v6kY
	bMW01zJK4Xc5+B5XAUyAM9WtF6Y1Qdg=
Date: Wed, 4 Mar 2026 12:04:50 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 bpf/net 6/6] sockmap: Fix broken memory accounting for
 UDP.
To: Kuniyuki Iwashima <kuniyu@google.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, Jiayuan Chen
 <jiayuan.chen@linux.dev>, Cong Wang <xiyou.wangcong@gmail.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, syzbot+5b3b7e51dda1be027b7a@syzkaller.appspotmail.com
References: <20260221233234.3814768-1-kuniyu@google.com>
 <20260221233234.3814768-7-kuniyu@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20260221233234.3814768-7-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 742E7207632
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264031-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[google.com,gmail.com,cloudflare.com,linux.dev];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,5b3b7e51dda1be027b7a];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 2/21/26 3:30 PM, Kuniyuki Iwashima wrote:
> syzbot reported imbalanced sk->sk_forward_alloc [0] and
> demonstrated that UDP memory accounting by SOCKMAP is broken.
> 
> The repro put a UDP sk into SOCKMAP and redirected skb to itself,
> where skb->truesize was 4240.
> 
> First, udp_rmem_schedule() set sk->sk_forward_alloc to 8192
> (2 * PAGE_SIZE), and skb->truesize was charged:
> 
>    sk->sk_forward_alloc = 0 + 8192 - 4240;  // => 3952
> 
> Then, udp_read_skb() dequeued the skb by skb_recv_udp(), which finally
> calls udp_rmem_release() and _partially_ reclaims sk->sk_forward_alloc
> because skb->truesize was larger than PAGE_SIZE:
> 
>    sk->sk_forward_alloc += 4240;  // => 8192 (PAGE_SIZE is reclaimable)
>    sk->sk_forward_alloc -= 4096;  // => 4096
> 
> Later, sk_psock_skb_ingress_self() called skb_set_owner_r() to
> charge the skb again, triggering an sk->sk_forward_alloc underflow:
> 
>    sk->sk_forward_alloc -= 4240   // => -144
> 
> Another problem is that UDP memory accounting is not performed
> under spin_lock_bh(&sk->sk_receive_queue.lock).
> 
> skb_set_owner_r() and sock_rfree() are called locklessly and
> corrupt sk->sk_forward_alloc, leading to the splat.
> 
> Let's not skip memory accounting for UDP and ensure the proper
> lock is held.
> 
> Note that UDP does not need msg->sk assignment, which is for TCP.
> 
> [0]:
> WARNING: net/ipv4/af_inet.c:157 at inet_sock_destruct+0x62d/0x740 net/ipv4/af_inet.c:157, CPU#0: ksoftirqd/0/15
> Modules linked in:
> CPU: 0 UID: 0 PID: 15 Comm: ksoftirqd/0 Not tainted syzkaller #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/13/2026
> RIP: 0010:inet_sock_destruct+0x62d/0x740 net/ipv4/af_inet.c:157
> Code: 0f 0b 90 e9 58 fe ff ff e8 40 55 b3 f7 90 0f 0b 90 e9 8b fe ff ff e8 32 55 b3 f7 90 0f 0b 90 e9 b1 fe ff ff e8 24 55 b3 f7 90 <0f> 0b 90 e9 d7 fe ff ff 89 f9 80 e1 07 80 c1 03 38 c1 0f 8c 95 fc
> RSP: 0018:ffffc90000147a48 EFLAGS: 00010246
> RAX: ffffffff8a1121dc RBX: dffffc0000000000 RCX: ffff88801d2c3d00
> RDX: 0000000000000100 RSI: 0000000000000f70 RDI: 0000000000000000
> RBP: 0000000000000f70 R08: ffff888030ce1327 R09: 1ffff1100619c264
> R10: dffffc0000000000 R11: ffffed100619c265 R12: ffff888030ce1080
> R13: dffffc0000000000 R14: ffff888030ce130c R15: ffffffff8fa87e00
> FS:  0000000000000000(0000) GS:ffff8881256f8000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000200000000700 CR3: 000000007200c000 CR4: 00000000003526f0
> Call Trace:
>   <TASK>
>   __sk_destruct+0x85/0x880 net/core/sock.c:2350
>   rcu_do_batch kernel/rcu/tree.c:2605 [inline]
>   rcu_core+0xc9e/0x1750 kernel/rcu/tree.c:2857
>   handle_softirqs+0x22a/0x7c0 kernel/softirq.c:622
>   run_ksoftirqd+0x36/0x60 kernel/softirq.c:1063
>   smpboot_thread_fn+0x541/0xa50 kernel/smpboot.c:160
>   kthread+0x726/0x8b0 kernel/kthread.c:463
>   ret_from_fork+0x51b/0xa40 arch/x86/kernel/process.c:158
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
>   </TASK>
> 
> Fixes: d7f571188ecf ("udp: Implement ->read_sock() for sockmap")

Cc: Cong Wang, who is the author of the quoted commit and also the 
author of the full UDP support in sockmap.

JakubS and JohnF who are the maintainers of sockmap and skmsg. Please 
take a look also.

Jiayuan Chen, you had submitted patches(/fixes) for sockmap/skmsg. It is 
a good chance to gain review credit.

> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index 96f43e0dbb17..dd9134a45663 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -7,6 +7,7 @@
>   
>   #include <net/sock.h>
>   #include <net/tcp.h>
> +#include <net/udp.h>
>   #include <net/tls.h>
>   #include <trace/events/sock.h>
>   
> @@ -576,6 +577,7 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
>   				u32 off, u32 len, bool take_ref)
>   {
>   	struct sock *sk = psock->sk;
> +	bool is_udp = sk_is_udp(sk);
>   	struct sk_msg *msg;
>   	int err = -EAGAIN;
>   
> @@ -583,13 +585,20 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
>   	if (!msg)
>   		goto out;
>   
> -	if (skb->sk != sk && take_ref) {
> +	if (is_udp) {
> +		if (unlikely(skb->destructor == udp_sock_rfree))

A quick question. This case happens when the earlier 
sk_psock_skb_ingress_enqueue() failed?

> +			goto enqueue;
> +
> +		spin_lock_bh(&sk->sk_receive_queue.lock);
> +	}
> +
> +	if (is_udp || (skb->sk != sk && take_ref)) {
>   		if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
> -			goto free;
> +			goto unlock;
>   
>   		if (!sk_rmem_schedule(sk, skb, skb->truesize))
> -			goto free;
> -	} else {
> +			goto unlock;
> +	} else if (skb->sk == sk || !take_ref) {
>   		/* This is used in tcp_bpf_recvmsg_parser() to determine whether the
>   		 * data originates from the socket's own protocol stack. No need to
>   		 * refcount sk because msg's lifetime is bound to sk via the ingress_msg.
> @@ -604,11 +613,23 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
>   	 * into user buffers.
>   	 */
>   	skb_set_owner_r(skb, sk);
> +
> +	if (is_udp) {
> +		spin_unlock_bh(&sk->sk_receive_queue.lock);
> +
> +		skb->destructor = udp_sock_rfree;
> +	}
> +
> +enqueue:
>   	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg, take_ref);
>   	if (err < 0)
>   		goto free;
>   out:
>   	return err;
> +
> +unlock:
> +	if (is_udp)
> +		spin_unlock_bh(&sk->sk_receive_queue.lock);
>   free:
>   	kfree(msg);
>   	goto out;

