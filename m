Return-Path: <netdev+bounces-264141-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oB4jGdzqqGnlygAAu9opvQ
	(envelope-from <netdev+bounces-264141-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 03:30:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C11DE20A33B
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 03:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76E573045210
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 02:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3EE7081A;
	Thu,  5 Mar 2026 02:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vIak2M76"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FED83368B6
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 02:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772677849; cv=none; b=f6EyhUvmptjU8Lozzz/AScL7Qpguf10qcHwzdrzWGkk9zuYN1xTYq50fY9m++TieCLajpLRQwuvAoVcLv3vCmNZIe1ZCeuWY5boq/irapTugGJBwYutzD8VWtUm5+p09cEtjvVLW3OcXud9nIKt/zlGFj6dmWEuB8UA9iLcshws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772677849; c=relaxed/simple;
	bh=KJrGWC9qcRPY59iBcTX6nUVjltKd5Md5FdfXV0UJjF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oYXx3441GQfNWwcz174f+6lt0k0wOzq2j6PPNa0PRgRjF6v9do6j9djh1ucefz2j7HPO/IoAjRBhqIqbUdF7lDegftolKwBcWo+7RfnO7xXKzKb66p2/0I9lwPkWAQvGUTBtbHgHkLUX7guzmUrgdpuTaaW8HHkvD0wo+h4WHUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vIak2M76; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 5 Mar 2026 10:30:26 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772677836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8IAhsCTPaaj49fw0EkRaGxHy6m09MppnBlqhQd5DSh4=;
	b=vIak2M76ZjO6Y/YCDIrXDHHXLMRoIWi/ffz1M/m/6MkMOTCad+3cwY0umDCtM39A+SSoup
	I3zERGx0GrX9XoodkyX6mf/iDwEYs7qX56EXh4uEs5cPOFWTS5zTO0vjMqsgpIqmIAxl1j
	sfgRgE7IN6r6tFi8NCyqWHvGSAssssA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: John Fastabend <john.fastabend@gmail.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	syzbot+9307c991a6d07ce6e6d8@syzkaller.appspotmail.com
Subject: Re: [PATCH v4 bpf/net 3/6] sockmap: Fix use-after-free in
 udp_bpf_recvmsg().
Message-ID: <g7ap5glmwfoyskarflvmuiurlm7atfbospmqp4hifumv2f4thc@bgb6vsmszzpf>
References: <20260221233234.3814768-1-kuniyu@google.com>
 <20260221233234.3814768-4-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260221233234.3814768-4-kuniyu@google.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: C11DE20A33B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264141-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,cloudflare.com,vger.kernel.org,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,9307c991a6d07ce6e6d8];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sat, Feb 21, 2026 at 11:30:50PM +0800, Kuniyuki Iwashima wrote:
> syzbot reported use-after-free of struct sk_msg in sk_msg_recvmsg(). [0]
> 
> sk_msg_recvmsg() peeks sk_msg from psock->ingress_msg under a lock,
> but its processing is lockless.
> 
> Thus, sk_msg_recvmsg() must be serialised by callers, otherwise
> multiple threads could touch the same sk_msg.
> 
> For example, TCP uses lock_sock(), and AF_UNIX uses unix_sk(sk)->iolock.
> 
> Initially, udp_bpf_recvmsg() had used lock_sock(), but the cited
> commit accidentally removed it.
> 
> Let's serialise sk_msg_recvmsg() with lock_sock() in udp_bpf_recvmsg().
> 
> Note that holding spin_lock_bh(&sk->sk_receive_queue.lock) is not
> an option due to copy_page_to_iter() in sk_msg_recvmsg().
> 
> [0]:
> BUG: KASAN: slab-use-after-free in sk_msg_recvmsg+0xb54/0xc30 net/core/skmsg.c:428
> Read of size 4 at addr ffff88814cdcf000 by task syz.0.24/6020
> 
> CPU: 1 UID: 0 PID: 6020 Comm: syz.0.24 Not tainted syzkaller #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/13/2026
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:378 [inline]
>  do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>

[...] 
> Fixes: 9f2470fbc4cb ("skmsg: Improve udp_bpf_recvmsg() accuracy")
> Reported-by: syzbot+9307c991a6d07ce6e6d8@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/69922ac9.a70a0220.2c38d7.00e0.GAE@google.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  net/ipv4/udp_bpf.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/net/ipv4/udp_bpf.c b/net/ipv4/udp_bpf.c
> index 779a3a03762f..b07774034a91 100644
> --- a/net/ipv4/udp_bpf.c
> +++ b/net/ipv4/udp_bpf.c
> @@ -52,7 +52,9 @@ static int udp_msg_wait_data(struct sock *sk, struct sk_psock *psock,
>  	sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
>  	ret = udp_msg_has_data(sk, psock);
>  	if (!ret) {
> +		release_sock(sk);
>  		wait_woken(&wait, TASK_INTERRUPTIBLE, timeo);
> +		lock_sock(sk);
>  		ret = udp_msg_has_data(sk, psock);
>  	}
>  	sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
> @@ -81,6 +83,7 @@ static int udp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>  		goto out;
>  	}
>  
> +	lock_sock(sk);
>  msg_bytes_ready:
>  	copied = sk_msg_recvmsg(sk, psock, msg, len, flags);
>  	if (!copied) {
> @@ -92,11 +95,17 @@ static int udp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>  		if (data) {
>  			if (psock_has_data(psock))
>  				goto msg_bytes_ready;
> +
> +			release_sock(sk);
> +
>  			ret = sk_udp_recvmsg(sk, msg, len, flags, addr_len);
>  			goto out;
>  		}
>  		copied = -EAGAIN;
>  	}
> +
> +	release_sock(sk);
> +
>  	ret = copied;
>  out:
>  	sk_psock_put(sk, psock);
> -- 
> 2.53.0.371.g1d285c8824-goog
> 

LGTM.

One minor observation for a possible follow-up:
psock_has_data() is checked before lock_sock(), which leaves a TOCTOU window.

If the BPF verdict path consumes the skb from the UDP receive queue and redirects it to
psock->ingress_msg between the check and sk_udp_recvmsg(), the thread may block in
__skb_recv_udp() while data is already available in the psock.

Moving lock_sock() before the psock_has_data() check (as the original code
did before 9f2470fbc4cb) would narrow this window, similar to how
__tcp_bpf_recvmsg() acquires lock_sock() upfront. But that can be a
separate patch.

