Return-Path: <netdev+bounces-204430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BED1AFA669
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 18:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2075188B377
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 16:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C555E199935;
	Sun,  6 Jul 2025 16:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rt2SMC+r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1661C39FD9
	for <netdev@vger.kernel.org>; Sun,  6 Jul 2025 16:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751818606; cv=none; b=vColLySDb/iyIGo75dhD08qXR5kvx/SIQaxZ+LcKpvhTUezMezEQOiDNLsA7en+ahSIIHcZkKfbx8O5/gYXMd0yposhxuVJsgSpy+fTeJzxGsoykjZn9nGtjMqi9aMsKlHw0hXXAcrkS1F+0wuk5HvlNAq/jBm9D+nGiVKR1VhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751818606; c=relaxed/simple;
	bh=XRQcMTQg/CiokDNienaTXx8Wpjqccl0/C6jgvhQmH1g=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=UeBXSX9B1eTRihdjYrrjGNjdTtl2nutL6fgcKhE+znM1eAFHh513AYD/mJcgZID1tzrNwPuzlkzfAn6TcXckjbsnxeh2PWtxXJuDhIs7JB3ATvBcW+vGVp4zn5f9OwMaCUkKJ7Jc9SYcIYuQVy8Kg8SLSxxc9dSivcwzEtL/dSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rt2SMC+r; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-711d4689084so21995157b3.0
        for <netdev@vger.kernel.org>; Sun, 06 Jul 2025 09:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751818604; x=1752423404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CwMUfN9bP/mkEhZ670HCSTETHUbtbRb2D3UD7+DEBp4=;
        b=Rt2SMC+rbsZLuVzTAdLJh9bb6VmiPbxxTpIX6jxieX8VZwfsKovtAuut8j9nvKIRNb
         TIYevr6g8DKmZn9AOEyOqyVra6QDcaWuDx0BUmy6Aqpent9mg2Y/UvaJZy7EZxvX+0ko
         jXmt4v2qNjJUO5242mw+J/NXFbjvX8o3/VIZ5zF7XEeLjX3gec2y+gx30yCb3TLyO3VI
         XM5fFVLO04RA9pA1S12I5lODZlsTBl/k8ADS832qmwSuDwsJ2b/GjoKD8ICt9/MqFpzb
         nPrJZyyKLgehCM7VJ6zNNEyFmbqx24usYg1OLJQFc7CwgKUGycDJ12GhFaaKArO/w+2d
         LeBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751818604; x=1752423404;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CwMUfN9bP/mkEhZ670HCSTETHUbtbRb2D3UD7+DEBp4=;
        b=TrnO1cLDcd+KTk8Qga/6GoC+ZjKfiQImxyIZoTApog/kHwDMiR8UkFHyHxxe8cYzCM
         4xW5/oPpckD3M9cmcfxAX6WTsmHdn4TEz1JBTGkKCj6ebWY9Od1JHstX2P1Sdvz5YgOH
         qtfq1ESEC901fzZmEUKvSUbWIEwAPXsIwc36A2OsNQkeig+TkYtw6sH3bHpNG3Mzyuar
         QvbeCk7WWYGstmYiQEmkgygLfhrrEQu0xNezCwKX2Kt0rubOJxrC0x1EN+EXWp9IxkTu
         YgwWPyPm7Bath0V1pG5zLOD/io0FVPa8n9klkNHL7we3ftImU/ZHHmJrCEfgWkiZEGIE
         0QIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUme1io9ZYET0zQui6idT5zEcdE9kfcVxD1UgLG3JixYR9AHechW5pPC2+uBSJQ638G/4BS2w8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCkQBdSKdswqlB1ypt3ClOCFfn2WRKzenOAelCz9063071Ew2I
	Fl42JaXPA/VWcJhXigNpFv8R64JyNIQU8akDwwMDNUPTInz/5NtB3WvIXd2zjg==
X-Gm-Gg: ASbGncs7WLXuseDdraeV+xzwbJYBSTED00qG5QTP/BOnfaDjhY5xbpmttTpwJddNcTf
	VAlqX+Bj7kjwouWbgq69XAMDdY2pL74SvIPv/Zt23NFTrwn6G5Q6vOdzFYIW6M0GL0yMs1nRWSJ
	uWC8kCl2PJkzA7oeHEpOODhJWE5SX8syd+G2he/v0P0BV/1hrY4tI52KZh9YzDh8N+gMoKsBM57
	GTTRNu42BZGFeP2Ash3Tgbep4UglKK8A57yvFcyrmyV+3v/im+PEaJjuDvZs/s0VTZ+vVcA0QoH
	gi+by+s7/B4wQbQUg5MqxuhViBjfl01QgDN2VIcOb0AigCjW4r8JmdUvj/yAPlJh/mhrVbCK92Y
	PLcYvkTjpBhOjJ1c6siN6wHOH7kG8oyHK9NV7o/Hvj6O/F6jYtw==
X-Google-Smtp-Source: AGHT+IHXuEehGSjI6bCCDsptVWdPF3vJGX1/q+oaxNSp6Se6p8HjFFoK3yuWBoz/henQwNJ7EKTcrQ==
X-Received: by 2002:a05:690c:b83:b0:70f:88e2:c4ae with SMTP id 00721157ae682-7176ccf24d9mr73968527b3.37.1751818603859;
        Sun, 06 Jul 2025 09:16:43 -0700 (PDT)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-71665b15315sm12727817b3.100.2025.07.06.09.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 09:16:43 -0700 (PDT)
Date: Sun, 06 Jul 2025 12:16:42 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>, 
 Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, 
 Boris Pismenny <borisp@nvidia.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, 
 David Ahern <dsahern@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, 
 Patrisious Haddad <phaddad@nvidia.com>, 
 Raed Salem <raeds@nvidia.com>, 
 Jianbo Liu <jianbol@nvidia.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 netdev@vger.kernel.org
Message-ID: <686aa16a9e5a7_3ad0f329432@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250702171326.3265825-5-daniel.zahka@gmail.com>
References: <20250702171326.3265825-1-daniel.zahka@gmail.com>
 <20250702171326.3265825-5-daniel.zahka@gmail.com>
Subject: Re: [PATCH v3 04/19] tcp: add datapath logic for PSP with inline key
 exchange
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Daniel Zahka wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> 
> Add validation points and state propagation to support PSP key
> exchange inline, on TCP connections. The expectation is that
> application will use some well established mechanism like TLS
> handshake to establish a secure channel over the connection and
> if both endpoints are PSP-capable - exchange and install PSP keys.
> Because the connection can existing in PSP-unsecured and PSP-secured
> state we need to make sure that there are no race conditions or
> retransmission leaks.
> 
> On Tx - mark packets with the skb->decrypted bit when PSP key
> is at the enqueue time. Drivers should only encrypt packets with
> this bit set. This prevents retransmissions getting encrypted when
> original transmission was not. Similarly to TLS, we'll use
> sk->sk_validate_xmit_skb to make sure PSP skbs can't "escape"
> via a PSP-unaware device without being encrypted.
> 
> On Rx - validation is done under socket lock. This moves the validation
> point later than xfrm, for example. Please see the documentation patch
> for more details on the flow of securing a connection, but for
> the purpose of this patch what's important is that we want to
> enforce the invariant that once connection is secured any skb
> in the receive queue has been encrypted with PSP.
> 
> Add trivialities like GRO and coalescing checks.
> 
> This change only adds the validation points, for ease of review.
> Subsequent change will add the ability to install keys, and flesh
> the enforcement logic out
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Co-developed-by: Daniel Zahka <daniel.zahka@gmail.com>
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>

>  /**
>   *	inet_twsk_bind_unhash - unhash a timewait socket from bind hash
> @@ -218,6 +218,7 @@ struct inet_timewait_sock *inet_twsk_alloc(const struct sock *sk,
>  		refcount_set(&tw->tw_refcnt, 0);
>  
>  		__module_get(tw->tw_prot->owner);
> +		psp_twsk_init(tw, (struct sock *)sk);

Is it possible to avoid the need for a cast here? Can psp_sk_assoc
take a const pointer?

> @@ -689,6 +690,7 @@ void tcp_skb_entail(struct sock *sk, struct sk_buff *skb)
>  	tcb->seq     = tcb->end_seq = tp->write_seq;
>  	tcb->tcp_flags = TCPHDR_ACK;
>  	__skb_header_release(skb);
> +	psp_enqueue_set_decrypted(sk, skb);

If touching the tcp hot path, maybe a static branch.

> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> index d0f49e6e3e35..79337028f3a5 100644
> --- a/net/ipv4/tcp_minisocks.c
> +++ b/net/ipv4/tcp_minisocks.c
> @@ -104,9 +104,12 @@ tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff *skb,
>  	struct tcp_timewait_sock *tcptw = tcp_twsk((struct sock *)tw);
>  	u32 rcv_nxt = READ_ONCE(tcptw->tw_rcv_nxt);
>  	struct tcp_options_received tmp_opt;
> +	enum skb_drop_reason psp_drop;
>  	bool paws_reject = false;
>  	int ts_recent_stamp;
>  
> +	psp_drop = psp_twsk_rx_policy_check(tw, skb);
> +

Why not return immediately here if the policy check fails, similar to
the non-timewait path?

>  	tmp_opt.saw_tstamp = 0;
>  	ts_recent_stamp = READ_ONCE(tcptw->tw_ts_recent_stamp);
>  	if (th->doff > (sizeof(*th) >> 2) && ts_recent_stamp) {
> @@ -124,6 +127,9 @@ tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff *skb,
>  	if (READ_ONCE(tw->tw_substate) == TCP_FIN_WAIT2) {
>  		/* Just repeat all the checks of tcp_rcv_state_process() */
>  
> +		if (psp_drop)
> +			goto out_put;
> +
>  		/* Out of window, send ACK */
>  		if (paws_reject ||
>  		    !tcp_in_window(TCP_SKB_CB(skb)->seq, TCP_SKB_CB(skb)->end_seq,
> @@ -194,6 +200,9 @@ tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff *skb,
>  	     (TCP_SKB_CB(skb)->seq == TCP_SKB_CB(skb)->end_seq || th->rst))) {
>  		/* In window segment, it may be only reset or bare ack. */
>  
> +		if (psp_drop)
> +			goto out_put;
> +
>  		if (th->rst) {
>  			/* This is TIME_WAIT assassination, in two flavors.
>  			 * Oh well... nobody has a sufficient solution to this
> @@ -247,6 +256,9 @@ tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff *skb,
>  		return TCP_TW_SYN;
>  	}
>  
> +	if (psp_drop)
> +		goto out_put;
> +
>  	if (paws_reject) {
>  		*drop_reason = SKB_DROP_REASON_TCP_RFC7323_TW_PAWS;
>  		__NET_INC_STATS(twsk_net(tw), LINUX_MIB_PAWS_TW_REJECTED);
> @@ -265,6 +277,8 @@ tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff *skb,
>  		return tcp_timewait_check_oow_rate_limit(
>  			tw, skb, LINUX_MIB_TCPACKSKIPPEDTIMEWAIT);
>  	}
> +
> +out_put:
>  	inet_twsk_put(tw);
>  	return TCP_TW_SUCCESS;
>  }

