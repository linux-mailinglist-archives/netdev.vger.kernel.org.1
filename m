Return-Path: <netdev+bounces-159566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C472CA15D77
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 15:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8957166B41
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 14:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A337192D8E;
	Sat, 18 Jan 2025 14:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Br3r16D7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E1C18FDBD
	for <netdev@vger.kernel.org>; Sat, 18 Jan 2025 14:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737211829; cv=none; b=dn0Orj8gt2n65TMWSsWXJ5Y7i3vRz+wxbQNBXfEtTqbloshquGyh+UNFQr8mQUC4BFqnljmlQUz7PAEKJcABhCGOqxQbeaEVZqBMKCgXOe7WAGxz8HAFSFj6RHmoRUZFSJTTm0M0+CH3q5+9bCzwQkOzpMu4RWHU4+uem8mVg3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737211829; c=relaxed/simple;
	bh=vc8nQrJMUBVdRKVAiTLUiDvimiPHAK4SpEmgfoMXdcE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mHa94A4vnTgpvFtfIe/hNyqXTCn41WarQ0w+9D39DEGH2FI+9HoYoUMnTq7fsngLHiUaerWSGyN6yxqiAASq94p20zEUkvCg6ueO/aORcIJbnbaDgBr/RjpUGn/cLXd3OxihGqDBLs3oOXQ7cFMblSAr3VZqkPOfrgZaj+hl45k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Br3r16D7; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d96944401dso5430990a12.0
        for <netdev@vger.kernel.org>; Sat, 18 Jan 2025 06:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1737211825; x=1737816625; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=UVZF3YDvzHz5/Dk51MXwSo0uaGYTS1HEavqkbVKNSLw=;
        b=Br3r16D7DQi5sorYQH+cyZSwmsHVZGxTe0B+QgorMWdSwxZV6tvZ4zdn2dbwdsVvq8
         mBAFtO0yiLWAJpOdUacbSwN26ykBzI527QEwbAHgeQiaD/WXi2D2kvjiEFJJMuKZoFx1
         dAgyWc3/fOCqXUGt+QEf9VQjdGrjfaeBDrZMMlMPEzq/8oAq/ROoXiDmAWgz3vUMpXVP
         I4Igurk9HO+UTaSR0U7aP9CL6zSdoLYhcE36a/UN9oq4illl6IAX49XpG4jJ4OHKAUie
         EmgY7XyUI67bT/WyFi+cNrNBWXThOclSDwWG05Uu8Wm7eaXUsNG56SFiGhKOpp6/nnkK
         u3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737211825; x=1737816625;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UVZF3YDvzHz5/Dk51MXwSo0uaGYTS1HEavqkbVKNSLw=;
        b=bUZ4v5SWVBTTXSvgaAhEmCxRcEvKnMDqsABsbwocswx9wXtKZe1l1p5sWySt+9npaq
         gvB3N/ftiHAsy/CrzBH2WX6ltgRm7FxuWRFyyeRkvOnQAp8zjboMV25a/jCjuWQtN+2X
         I/xvPgJJ7IlB9lD0FXLIvLI4sRpI1qknXprcdMFYbxXDhjwPLaoVrEMveewjmB9PuXjX
         j0zN8GLpeao9tOaZ5GrIJYPtbGO/ffWKKSOhU50uqOHrpdxSakeNMS7qjalvYUnTNslL
         Va99c0qdgbFEMV9o18/laRK0hc4uIop23kv3q7FBjzzcZMpiNceAp77jju8450GJ37MI
         Mfpg==
X-Forwarded-Encrypted: i=1; AJvYcCUCGWKXAvoQ7STBnzIJ/4hnT+Tbnct1OUmmeZiW6ytBv/P9T7dwdnjz9apxn04TNKJu7rsblQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD0+n7vMuVAJcfUEDlqMJ7jQ1LobyWcij4twQiVFlVgRkhXo4g
	kay8/tt774mhKRGWplcL2tIYSJyruTtkbjL/rjeqCJS51dJ4iAr0mh9QV7RmFts=
X-Gm-Gg: ASbGncs4jEeZBncQbSAup/gbLSbLhbW39vojz0miA3Ux8n0+k9LeOG7L4KCDcZZ+72W
	sHNHtn8rXTrerkjysrXJsZfAt7uWs6nNtd/5Xoc4ts9xzw84qBxHf8zug2s9D6EiVMbsB6m/AUG
	ltvkZrNH7lo7l+eR/EAq/bXs7dv7PnUVcjAF5k3sEtHQDnNLrSY4czHzGEoRU88uV5sbncKKV7U
	Owr1jO3/6HiN9rWQY2LJsCQQEU0g+rgxNkkRctndGuxcngWyLU9yh1OKsy2lbw=
X-Google-Smtp-Source: AGHT+IEs5Muzy7OrbHe4BeljhEvhPf1bcgCdAU37y5Gk2HHGSKXsHepGnBdzt3gGXYdFR9LZcidACQ==
X-Received: by 2002:a17:906:c108:b0:aa6:79fa:b47d with SMTP id a640c23a62f3a-ab38b0b8138mr604984566b.1.1737211825228;
        Sat, 18 Jan 2025 06:50:25 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:506b:2387::38a:14])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384ce2105sm349569666b.67.2025.01.18.06.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2025 06:50:24 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiayuan Chen <mrpre@163.com>
Cc: bpf@vger.kernel.org,  john.fastabend@gmail.com,  netdev@vger.kernel.org,
  martin.lau@linux.dev,  ast@kernel.org,  edumazet@google.com,
  davem@davemloft.net,  dsahern@kernel.org,  kuba@kernel.org,
  pabeni@redhat.com,  linux-kernel@vger.kernel.org,  song@kernel.org,
  andrii@kernel.org,  mhal@rbox.co,  yonghong.song@linux.dev,
  daniel@iogearbox.net,  xiyou.wangcong@gmail.com,  horms@kernel.org,
  corbet@lwn.net,  eddyz87@gmail.com,  cong.wang@bytedance.com,
  shuah@kernel.org,  mykolal@fb.com,  jolsa@kernel.org,  haoluo@google.com,
  sdf@fomichev.me,  kpsingh@kernel.org,  linux-doc@vger.kernel.org
Subject: Re: [PATCH bpf v7 2/5] bpf: fix wrong copied_seq calculation
In-Reply-To: <20250116140531.108636-3-mrpre@163.com> (Jiayuan Chen's message
	of "Thu, 16 Jan 2025 22:05:28 +0800")
References: <20250116140531.108636-1-mrpre@163.com>
	<20250116140531.108636-3-mrpre@163.com>
Date: Sat, 18 Jan 2025 15:50:22 +0100
Message-ID: <87ikqcdvm9.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jan 16, 2025 at 10:05 PM +08, Jiayuan Chen wrote:
> 'sk->copied_seq' was updated in the tcp_eat_skb() function when the
> action of a BPF program was SK_REDIRECT. For other actions, like SK_PASS,
> the update logic for 'sk->copied_seq' was moved to
> tcp_bpf_recvmsg_parser() to ensure the accuracy of the 'fionread' feature.
>
> It works for a single stream_verdict scenario, as it also modified
> 'sk_data_ready->sk_psock_verdict_data_ready->tcp_read_skb'
> to remove updating 'sk->copied_seq'.
>
> However, for programs where both stream_parser and stream_verdict are
> active(strparser purpose), tcp_read_sock() was used instead of
> tcp_read_skb() (sk_data_ready->strp_data_ready->tcp_read_sock)
> tcp_read_sock() now still update 'sk->copied_seq', leading to duplicated
> updates.
>
> In summary, for strparser + SK_PASS, copied_seq is redundantly calculated
> in both tcp_read_sock() and tcp_bpf_recvmsg_parser().
>
> The issue causes incorrect copied_seq calculations, which prevent
> correct data reads from the recv() interface in user-land.
>
> We do not want to add new proto_ops to implement a new version of
> tcp_read_sock, as this would introduce code complexity [1].
>
> We add new callback for strparser for customized read operation, also as
> a wrapper function it provides abstraction use psock.
>
> [1]: https://lore.kernel.org/bpf/20241218053408.437295-1-mrpre@163.com
> Fixes: e5c6de5fa025 ("bpf, sockmap: Incorrectly handling copied_seq")
> Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: Jiayuan Chen <mrpre@163.com>
> ---

[...]

> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index 47f65b1b70ca..6dcde3506a9b 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -646,6 +646,47 @@ static int tcp_bpf_assert_proto_ops(struct proto *ops)
>  	       ops->sendmsg  == tcp_sendmsg ? 0 : -ENOTSUPP;
>  }
>  
> +#if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
> +static int tcp_bpf_strp_read_sock(struct sock *sk, read_descriptor_t *desc,
> +				  sk_read_actor_t recv_actor)
> +{
> +	struct sk_psock *psock;
> +	struct tcp_sock *tp;
> +	int copied = 0;
> +
> +	tp = tcp_sk(sk);
> +	rcu_read_lock();
> +	psock = sk_psock(sk);
> +	if (WARN_ON(!psock)) {
> +		desc->error = -EINVAL;
> +		goto out;
> +	}
> +
> +	psock->ingress_bytes = 0;
> +	/* We could easily add copied_seq and noack into desc then call
> +	 * ops->read_sock without calling symbol directly. But unfortunately
> +	 * most descriptors used by other modules are not inited with zero.
> +	 * Also it not work by replacing ops->read_sock without introducing
> +	 * new ops as ops itself is located in rodata segment.
> +	 */
> +	copied = tcp_read_sock_noack(sk, desc, recv_actor, true,
> +				     &psock->copied_seq);
> +	if (copied < 0)
> +		goto out;
> +	/* recv_actor may redirect skb to another socket(SK_REDIRECT) or
> +	 * just put skb into ingress queue of current socket(SK_PASS).
> +	 * For SK_REDIRECT, we need 'ack' the frame immediately but for
> +	 * SK_PASS, the 'ack' was delay to tcp_bpf_recvmsg_parser()
> +	 */
> +	tp->copied_seq = psock->copied_seq - psock->ingress_bytes;
> +	tcp_rcv_space_adjust(sk);
> +	__tcp_cleanup_rbuf(sk, copied - psock->ingress_bytes);
> +out:
> +	rcu_read_unlock();
> +	return copied;
> +}
> +#endif /* CONFIG_BPF_STREAM_PARSER */
> +
>  int tcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
>  {
>  	int family = sk->sk_family == AF_INET6 ? TCP_BPF_IPV6 : TCP_BPF_IPV4;
> @@ -681,6 +722,12 @@ int tcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
>  
>  	/* Pairs with lockless read in sk_clone_lock() */
>  	sock_replace_proto(sk, &tcp_bpf_prots[family][config]);
> +#if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
> +	if (psock->progs.stream_parser && psock->progs.stream_verdict) {
> +		psock->copied_seq = tcp_sk(sk)->copied_seq;
> +		psock->read_sock = tcp_bpf_strp_read_sock;

Just directly set psock->strp.cb.read_sock to tcp_bpf_strp_read_sock.
Then we don't need this intermediate psock->read_sock callback, which
doesn't do anything useful.

> +	}
> +#endif
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(tcp_bpf_update_proto);

