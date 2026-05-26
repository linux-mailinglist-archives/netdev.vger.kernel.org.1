Return-Path: <netdev+bounces-291924-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EDRIiIHFmr/gwcAu9opvQ
	(envelope-from <netdev+bounces-291924-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 22:48:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4F65DC74A
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 22:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3EC3301E223
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 20:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3C9352C2B;
	Tue, 26 May 2026 20:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ieGZpX7a"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8136933C50D
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 20:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779828478; cv=none; b=Gztc6eeY9SoUI27rbE8DhNgLtvqoScXI3tLaJmb02X0HXCMwlGvZQSBP4P75YGijOnHyKBd4r07q6S+DyHUods4O4eMMXIfcAK2CshMn9AE008rUsWDnijgZLRqnWc+Q52x7t6Fqfgz9cMiNXsRMhtTQqAfVLpZcBibBG+mrnB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779828478; c=relaxed/simple;
	bh=V5ougp40DY1H9zXzFsmFHsm33ofsao/93epdVKnawqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNkojmPxgG/MU6Dp2C791i0hsxICli8fm30/1kicep/Vqx0DSu6ueteMmKDY1QpznqyAgbZvH6hCc9ESOZBjH1uO+b7sA4MpULWQUdK/KwrtahfIj1ZOcaEAd6hRJNYgxUDUWWrfgFH52eVm8nM7Z5dT3k3n7qiXvoTEIPSWJQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ieGZpX7a; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 26 May 2026 13:47:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779828464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KnCflD3IDljS85fEYVFf30i3uDGjT7cYAgP9fl0QajM=;
	b=ieGZpX7a/mWgXww4IgmhPHiQvNDaBwDPsD7pJYVTTd+HUn40TrxoquQgiXUFMY52eYCpBA
	F2ldPx5tHks9GxGqGWNemrylJFFLNA9ZMVNBts3Uguw9LwGic43703VYBDJxvwAWl+hVUI
	OhoJ8VNLUdQqj2SiLQBFbId+x5WtcSo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v3 bpf-next 10/11] bpf: tcp: Add SOCK_OPS rcvlowat hook.
Message-ID: <202652620435.m7WK.martin.lau@linux.dev>
References: <20260523083001.2911931-1-kuniyu@google.com>
 <20260523083001.2911931-11-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260523083001.2911931-11-kuniyu@google.com>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291924-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,berkeley.edu,vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bpf_sock_ops.data:url]
X-Rspamd-Queue-Id: 2E4F65DC74A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, May 23, 2026 at 08:29:39AM +0000, Kuniyuki Iwashima wrote:
> Now, it is time to add the new hooks for BPF_SOCK_OPS_RCVQ_CB.
> 
> Let's invoke the BPF SOCK_OPS prog when
> 
>   1. TCP stack enqueues skb to sk->sk_receive_queue
>      -> tcp_queue_rcv(), tcp_ofo_queue(), and tcp_fastopen_add_skb()
> 
>   2. TCP recvmsg() completes
>      -> __tcp_cleanup_rbuf()
> 
> This will allow the BPF prog to parse each skb and dynamically
> adjust sk->sk_rcvlowat to suppress unnecessary EPOLLIN wakeups
> until sufficient data (e.g., a full RPC frame) is available
> in the receive queue.
> 
> Note that the direct access to bpf_sock_ops.data is intentionally
> disabled by passing 0 as end_offset.
> 
> Instead, the BPF prog is supposed to use bpf_skb_load_bytes()
> with bpf_sock_ops because payload is not in the linear area
> with TCP header/data split on and skb may contain a RPC
> descriptor in skb frag.  This also simplifies the BPF prog.
> 
> The placement of tcp_bpf_rcvlowat() in tcp_ofo_queue() and
> tcp_fastopen_add_skb() is chosen to provide the same snapshot
> with tcp_queue_rcv().
> 
> For example, if tcp_bpf_rcvlowat() were called before updating
> TCP_SKB_CB(skb)->seq in tcp_fastopen_add_skb(), BPF prog would
> need to implement an unlikely if branch to strip SYN.
> 
> In addition, TCP stack can queue overlapping skb into recvq.
> Once rcv_nxt is updated with a new skb, BPF prog cannot infer
> the previous one from skb->len.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
> v2: Add explanation of tcp_bpf_rcvlowat() placement.
> ---
>  include/net/tcp.h       | 12 ++++++++++++
>  net/ipv4/tcp.c          |  2 ++
>  net/ipv4/tcp_fastopen.c |  2 ++
>  net/ipv4/tcp_input.c    | 10 ++++++++++
>  4 files changed, 26 insertions(+)
> 
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index bc95d8e7b62e..a409f2ea710f 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -2889,12 +2889,24 @@ static inline void bpf_skops_init_skb(struct bpf_sock_ops_kern *skops,
>  	skops->skb = skb;
>  	skops->skb_data_end = skb->data + end_offset;
>  }
> +
> +void bpf_skops_rcvlowat(struct sock *sk, struct sk_buff *skb);
> +
> +static inline void tcp_bpf_rcvlowat(struct sock *sk, struct sk_buff *skb)
> +{
> +	if (BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk), BPF_SOCK_OPS_RCVQ_CB_FLAG))
> +		bpf_skops_rcvlowat(sk, skb);
> +}
>  #else
>  static inline void bpf_skops_init_skb(struct bpf_sock_ops_kern *skops,
>  				      struct sk_buff *skb,
>  				      unsigned int end_offset)
>  {
>  }
> +
> +static inline void tcp_bpf_rcvlowat(struct sock *sk, struct sk_buff *skb)
> +{
> +}
>  #endif
>  
>  /* Call BPF_SOCK_OPS program that returns an int. If the return value
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 3afeb69a547a..f7e32891bb4e 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -1602,6 +1602,8 @@ void __tcp_cleanup_rbuf(struct sock *sk, int copied)
>  		tcp_mstamp_refresh(tp);
>  		tcp_send_ack(sk);
>  	}
> +
> +	tcp_bpf_rcvlowat(sk, NULL);

hmm... so NULL is a way for the bpf prog to tell where it is called?

With skb NULL, what does the bpf prog usually do?

