Return-Path: <netdev+bounces-289204-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wO0nNFqnC2p2KgUAu9opvQ
	(envelope-from <netdev+bounces-289204-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 01:57:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2C6575485
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 01:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 087A4302DA2B
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 23:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9409732C302;
	Mon, 18 May 2026 23:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DuRJxMCK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7109126738C
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 23:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779148507; cv=none; b=ef+sEsqFXjtAzmWGJucdYLDXlcmzug3Cyep5unGkY0rc+TYIHljnpz1xCZZyNFcn2d3+GPn5Jbm8DZohZjmacqXcfA4HW/ZSXRbbNqyGDVsVlOQzV2+b3m0918XL0MPl+ZKAbpTSKeDjwahrEI8zbYS84NAHM99oGTIWMlCsAQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779148507; c=relaxed/simple;
	bh=I6M7p5pdOxiaohQqJSbBC6DhwcWC7iEjgP4hkiscRvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CHFuXvfCrUMthhMh7IIJNazdLo4tM9xPXdVopE8gB9BRcEsvI1H/mq8FW4lqW1KyZKZKBxhTmyvKdMDRjY8sqzmpayW4w8+hUPB2nTkr1BtT3wz3NmfdY5GkKrGUI7rPbWOJhW/LCUwSCYWo/1/gqy4jsY4c2BsQsIm1TU/rkmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DuRJxMCK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 945BAC2BCB7;
	Mon, 18 May 2026 23:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779148507;
	bh=I6M7p5pdOxiaohQqJSbBC6DhwcWC7iEjgP4hkiscRvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DuRJxMCKnPK0d2oIWnCixXYrLwAATPQW41mcbpEA9ldHa+KAFJWALo1NCChMiHmGJ
	 EGNwDKcgjy3gGIHn1EMt2AmK2T4K+BcjcQhHdem4NUZyeM4KmYTyxS43R0bwUrqiLl
	 A4KiZZ1QyZWOTutcGFNdQzu12y7LiNh8O81zWGgvh8r4tlOQdinJXqscmSWS7RozrZ
	 VrAsaO7JQiY6gardeydZvmOMJ86zb881ZuMrl5sVUICglFc4sm/Hw2U3dLTcu5EpWE
	 EyBygd+WZZG0TtzZWBJncymsOqabBkUMq5HrIxpypMogo+Gd2/vy7869CCVBdMnN7N
	 tvBdvdDdUjdDA==
From: Jakub Kicinski <kuba@kernel.org>
To: edumazet@google.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	pabeni@redhat.com,
	horms@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	netdev@vger.kernel.org,
	eric.dumazet@gmail.com,
	clm@meta.com
Subject: Re: [PATCH v3 net] tcp: fix stale per-CPU tcp_tw_isn leak enabling ISN prediction
Date: Mon, 18 May 2026 16:55:02 -0700
Message-ID: <20260518235502.3204931-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515073859.957056-1-edumazet@google.com>
References: <20260515073859.957056-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,redhat.com,google.com,vger.kernel.org,gmail.com,meta.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289204-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3E2C6575485
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
tcp: fix stale per-CPU tcp_tw_isn leak enabling ISN prediction

The patch attempts to fix a per-CPU tcp_tw_isn leak by moving the
TIME_WAIT-derived ISN into the sk_buff structure. It unions tcp_tw_isn with
skb->mark and skb->reserved_tailroom, assuming these fields are unused in
the TCP receive path.

> Instead, union it with skb->mark / skb->reserved_tailroom which
> are unused in TCP receive path.

Is this description accurate?

> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 2bcf78a4de7b9..8a5082685b822 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
[ ... ]
> @@ -1066,6 +1067,7 @@ struct sk_buff {
>  	union {
>  		__u32		mark;
>  		__u32		reserved_tailroom;
> +		u32		tcp_tw_isn;
>  	};

> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index c0526cc039804..719cfab3cd029 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
[ ... ]
> @@ -2198,6 +2197,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
>  		}
>  	}
>  
> +	skb->tcp_tw_isn = 0;
>  process:
>  	if (static_branch_unlikely(&ip4_min_ttl)) {
>  		/* min_ttl can be changed concurrently from do_ip_setsockopt() */

Since tcp_tw_isn shares memory with skb->mark, doesn't clearing it here
destroy any packet marks assigned earlier by Netfilter or ingress TC?

Immediately following the zeroing, the code executes xfrm4_policy_check()
and tcp_filter(). It appears IPsec policies and BPF socket filters will now
evaluate against a mark of 0, potentially bypassing security boundaries and
breaking policy routing.

> @@ -2299,7 +2299,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
>  		goto csum_error;
>  	}
>  
> -	tw_status = tcp_timewait_state_process(inet_twsk(sk), skb, th, &isn,
> +	tw_status = tcp_timewait_state_process(inet_twsk(sk), skb, th,
>  					       &drop_reason);
>  	switch (tw_status) {
>  	case TCP_TW_SYN: {
> @@ -2313,7 +2313,6 @@ int tcp_v4_rcv(struct sk_buff *skb)
>  			sk = sk2;
>  			tcp_v4_restore_cb(skb);
>  			refcounted = false;
> -			__this_cpu_write(tcp_tw_isn, isn);
>  			goto process;
>  		}

If the packet maps to a TIME_WAIT socket, tcp_timewait_state_process()
generates an ISN and assigns it to skb->tcp_tw_isn. When the code jumps
back to the process label, won't this pseudo-random 32-bit ISN be passed
into IPsec and BPF as skb->mark?

This also corrupts skb->reserved_tailroom, which could lead to
out-of-bounds writes if skb_tailroom() is subsequently evaluated.

Furthermore, if an eBPF program executed via tcp_filter() legitimately sets
skb->mark, won't it inadvertently modify skb->tcp_tw_isn?

> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index d5c9e65d97606..203660dc94efd 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
[ ... ]
> @@ -7594,25 +7594,22 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
>  	struct net *net = sock_net(sk);
>  	struct sock *fastopen_sk = NULL;
>  	union tcp_seq_and_ts_off st;
> +	u32 isn = skb->tcp_tw_isn;
>  	struct request_sock *req;
>  	bool want_cookie = false;
>  	struct dst_entry *dst;
>  	struct flowi fl;
>  	u8 syncookies;
> -	u32 isn;
>  
>  #ifdef CONFIG_TCP_AO
>  	const struct tcp_ao_hdr *aoh;
>  #endif
>  
> -	isn = __this_cpu_read(tcp_tw_isn);
> -	if (isn) {
> -		/* TW buckets are converted to open requests without
> -		 * limitations, they conserve resources and peer is
> -		 * evidently real one.
> -		 */
> -		__this_cpu_write(tcp_tw_isn, 0);
> -	} else {
> +	/* TW buckets are converted to open requests without
> +	 * limitations, they conserve resources and peer is
> +	 * evidently real one.
> +	 */
> +	if (!isn) {
>  		syncookies = READ_ONCE(net->ipv4.sysctl_tcp_syncookies);
>  
>  		if (syncookies == 2 || inet_csk_reqsk_queue_is_full(sk)) {

If a BPF program sets skb->mark to a non-zero value, tcp_conn_request()
will read it into isn. Since isn is now non-zero, won't this skip SYN
cookie flood protection and use the mark value as the TCP connection's
Initial Sequence Number?

Could this regression eliminate ISN randomization and allow TCP sequence
prediction?

