Return-Path: <netdev+bounces-286821-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uG/uG8M6AmqYpQEAu9opvQ
	(envelope-from <netdev+bounces-286821-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 22:23:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA37515C6C
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 22:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AC73F300B472
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C31F37EFF1;
	Mon, 11 May 2026 20:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOS1qK8i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28184372B2A
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 20:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778531007; cv=none; b=eTo8aP5ohyryG5eSzaaAmnIHvU56CFS907gFfm6hfGAhOHWejIp+nkt2U2VpfENal6ubmJ9gfFyrocEHAAvM/LcYOnwInsZOosm5ZHCzu9s6+Q/yl2cLAavkfsWcCbiM0uPUFmonW3viC2m5XP84nf5gGCrR1XciNBE7UNbuldc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778531007; c=relaxed/simple;
	bh=biGrra37/6WF/GRF8hZoLCEn+YV1frIrB7tsmZlTk7E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VNuOzGsiciROe7j00hD3oeTv3Vim/hZA6X9cFeA4GYF+umuFvgn+9m8YR4lDpFyC0Mq/1etXDF0DJkC7/FRkgJyK28S8np8FvnVK2pWPgsceLkxP4Wqadxd9WoJL5RdX6VWjH6Hqnr9BepzqpKpc1LnSCgt/aZZB/GAZyW+rCC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOS1qK8i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1606FC2BCF5;
	Mon, 11 May 2026 20:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778531006;
	bh=biGrra37/6WF/GRF8hZoLCEn+YV1frIrB7tsmZlTk7E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iOS1qK8ik2zJdCL7DxR9RR2SVtsk+4/x9arDUgZgDiwKKTEQDhOTQaJ/v/5Av8ift
	 a8Y/iSLP7wmaXTCO7EmAlRLQbi5waWShDWRh0tOqmXDOTNEWJCMz9Y7xSl6xucw/gW
	 FOZE2orGHidGvxD1Mr8HJ+Gz1SIbC0cqcitReW8ySJoD9oTeXCSmdop8Gqo3271Ruz
	 fa8jLXGYxxyG+cPTxZ0JwoAz6CMCAblRzofzgr6KmbUNIGuOdjZUZiVn12L/vvokzU
	 F7IEV/PXZVPF0gFuvSwRHgO3fvlaneLw08Rd7npM898Q04huF6gLszumxfLX8XGxpo
	 5rEKNIAIEor+g==
Date: Mon, 11 May 2026 13:23:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Neal Cardwell
 <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net] tcp: fix stale per-CPU tcp_tw_isn leak enabling ISN
 prediction
Message-ID: <20260511132325.54be1fe7@kernel.org>
In-Reply-To: <20260511151559.1916614-1-edumazet@google.com>
References: <20260511151559.1916614-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4EA37515C6C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-286821-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, 11 May 2026 15:15:59 +0000 Eric Dumazet wrote:
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index d13d49bfef19457cc5902cb556605a80f4c0ab2c..079f2324a3a777cfe30dd59777c9d3d6d9a6bae0 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -1641,6 +1641,7 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
>  reset:
>  	tcp_v6_send_reset(sk, skb, sk_rst_convert_drop_reason(reason));
>  discard:
> +	__this_cpu_write(tcp_tw_isn, 0);
>  	if (opt_skb)
>  		__kfree_skb(opt_skb);
>  	sk_skb_reason_drop(sk, skb, reason);
> @@ -1839,6 +1840,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
>  		}
>  	}
>  
> +	DEBUG_NET_WARN_ON_ONCE(__this_cpu_read(tcp_tw_isn));
>  process:
>  	if (static_branch_unlikely(&ip6_min_hopcount)) {
>  		/* min_hopcount can be changed concurrently from do_ipv6_setsockopt() */
> @@ -1913,6 +1915,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
>  	}
>  
>  discard_it:
> +	__this_cpu_write(tcp_tw_isn, 0);
>  	SKB_DR_OR(drop_reason, NOT_SPECIFIED);
>  	sk_skb_reason_drop(sk, skb, drop_reason);
>  	return 0;

CI says:

[  288.637769][ T3492] BUG: using __this_cpu_write() in preemptible [00000000] code: python3/3492
[  288.638116][ T3492] caller is tcp_v6_do_rcv+0x204/0x1cb0
[  288.638240][ T3492] CPU: 1 UID: 0 PID: 3492 Comm: python3 Not tainted 7.1.0-rc2-virtme #1 PREEMPT(full) 
[  288.638245][ T3492] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[  288.638247][ T3492] Call Trace:
[  288.638248][ T3492]  <TASK>
[  288.638250][ T3492]  dump_stack_lvl+0x6f/0xa0
[  288.638257][ T3492]  check_preemption_disabled+0xdb/0xf0
[  288.638261][ T3492]  tcp_v6_do_rcv+0x204/0x1cb0
[  288.638265][ T3492]  __release_sock+0x135/0x3a0
[  288.638272][ T3492]  release_sock+0x19c/0x240
[  288.638275][ T3492]  tcp_sendmsg+0x39/0x50
[  288.638279][ T3492]  __sys_sendto+0x2c9/0x400
[  288.638282][ T3492]  ? __ia32_sys_getpeername+0xd0/0xd0
[  288.638288][ T3492]  ? sock_ioctl+0x3cb/0x5f0
[  288.638294][ T3492]  ? find_held_lock+0x2b/0x80
[  288.638299][ T3492]  ? __lock_release.isra.0+0x6b/0x1a0
[  288.638302][ T3492]  __x64_sys_sendto+0xe4/0x1f0
[  288.638304][ T3492]  ? trace_irq_enable.constprop.0+0x9b/0x180
[  288.638308][ T3492]  ? lockdep_hardirqs_on+0x8c/0x130
[  288.638310][ T3492]  ? do_syscall_64+0x82/0xfc0
[  288.638312][ T3492]  do_syscall_64+0x117/0xfc0
[  288.638314][ T3492]  ? irq_exit_rcu+0x1a/0x30
[  288.638318][ T3492]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  288.638321][ T3492] RIP: 0033:0x7f895f8fe08e

