Return-Path: <netdev+bounces-173195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EC9A57D52
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 19:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 405E93B5478
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 18:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D494F21323B;
	Sat,  8 Mar 2025 18:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZb5D4Cz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CCE1B87CB
	for <netdev@vger.kernel.org>; Sat,  8 Mar 2025 18:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741459253; cv=none; b=ST4mfuwa33DsET4dd6aIumZ+QAS2fO2kDjDrf7wMs1fKQm9qKlyFT69GcWTofI2rrPdrnAEQaHabZSW6pEdP53C5hhi3ZTfah2lH89cfS7D4ltfE/pxsPSF7M4zO3Nubuv4Ojahy4IZa+gQYvly46Ej4azFAZwv5EDl8eJ/g+ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741459253; c=relaxed/simple;
	bh=3V03qA1mZJ3Zr+f6jiCLYQ4jSmmKnnbwQXfHqS7pD6s=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=MfOUjZHWHus6Yo9O9iYl6868kd/zgC21wVMLxiiux/jsgTyfBD6pjxOEjKEYnrTxVjDaW768w9Sn71opTOj7m0uk6cTjVQTkqGoEQ9U6fH7X4WW/kfwqreHyNaskC5L1f2UhrqshWSrvjD+eUPg19tc+bRwET2xT+30DaNMhTMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZb5D4Cz; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c3b44dabe0so323427985a.1
        for <netdev@vger.kernel.org>; Sat, 08 Mar 2025 10:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741459251; x=1742064051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3UwaKh+XS6vpNccvBLeNArdTONYxmecJQsrWH9z6P2A=;
        b=WZb5D4Cz5wdpzjcph7tIgzDAeGnX+SDZwNU1ZH7taqH595ZAOb93FQuYhzDtBiYA9+
         ptkX4tfZDxxewATELsnEZ+Ck/+ULex73+tA9aJYTfnUZRUJagPrKL7Qi4UKSvNvraDgA
         zXXNsRlaSTiO5hpfNot1pAUrTu2OkueUb4UL0PE6yV1OZWZDd6tbulxnT5WktF14NGUS
         2fUgFwjR46fuURyckZ76Vmz4vjR8581IonW68V+XHP7sKy1ZK4GTC/g8kJK7alplYvYo
         STe0HuO9fqQsQdijTlmoi4ZD18a9/ykNb8mjbRazPRVps53yjJolGHiTZoDTDOIiQCYG
         SaUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741459251; x=1742064051;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3UwaKh+XS6vpNccvBLeNArdTONYxmecJQsrWH9z6P2A=;
        b=vNHCpxaVW5j8s4ZIrBDcnqjcbI9sEMK4ZeURQ0NU22RN6eqitq/qfp3PMS5EBftmzk
         0pFva5wzCz0thb1YymsCQFYQ98g2u470VLBqCDlpa+kknR3wrqPqmUffzq1F+HhGEmxD
         DFedB+elpdl8LTkA/8dTihRCS9voKPOKegxyP4sdunCiJ5zSiPnC30ayLqcDf89CvM1j
         w/MZTp/ZEzTMPCh7uyXQhOHMm8AEIx/PmWugVW1SbnbW5kybtGcxjbye0Bg8UQq98ec4
         ViHjY5n5clAcqwDjkUTcmItmgtAtAhwOEnq8/hduNy1Nn7TiwFDbm1zzK4jL7R1SvEf3
         UT4w==
X-Forwarded-Encrypted: i=1; AJvYcCV342Xloqur0DUG6M12Ak6+gdnLiloU9MqryqKV4ZWG6M17A0qyc4Js4yZCBueGKMX5F+4HRV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YysugrZ9b2FuxCR3lKw8HmS7mGALXvDWB4Tf6E3dh4uQhkXaH04
	DCKXYLTB857dTN5DvQjkCE6L5DGzvEGKW7APEliZlMIKsK5ti61X
X-Gm-Gg: ASbGnctpGYj7DnrjKXhhEnJVXNdb4PbOj0unA4YYut3d1aklmruDQLGn7WM0jLNtvdF
	Z2PDaCNa0DjS1JuuoWS/wFHUwGtQYlAmwrq9/Ywk90IlhV5nJUdZmKExcUkb/MAd7ak6fhOhaoG
	1BQrLXWSt5eXBQMlCB2Ji4dsg8qubOwaaXjY1tbW/LZfsXELWFwB3bacA+9WDgUriz1SyUP6Aok
	qcVsDpfDrn5jfh18QtjXkkSzEf3On2CVVkyvOksQ2cQ6yP78HxYxGz2ZHxJN1OytJP57MREJk8E
	+gw0JitOuQnOxM3PkJxhRGYQPRKqkEwEsn4fXCZJNTrOsAzm9CfVjkrlbEiuL/dDUDifedyfycn
	BF76ETiRs1hlkFJ8V2xkySSXNByaNNYgD
X-Google-Smtp-Source: AGHT+IGb3eF7NxHb/A/Qdoq5KsNRcAO1jyAeHce+Nx4KOnCUTP8VL5RazUDNkH17OrTC1oujS91leg==
X-Received: by 2002:a05:620a:27cc:b0:7c3:d5bc:b76b with SMTP id af79cd13be357-7c4e6107c65mr1194025885a.32.1741459250759;
        Sat, 08 Mar 2025 10:40:50 -0800 (PST)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c53d66f43dsm132060985a.20.2025.03.08.10.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 10:40:50 -0800 (PST)
Date: Sat, 08 Mar 2025 13:40:49 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>
Message-ID: <67cc8f317e5e0_14b9f9294b5@willemb.c.googlers.com.notmuch>
In-Reply-To: <8c8263ab59b1e9366f245eec4dfdccd368496e3d.1741338765.git.pabeni@redhat.com>
References: <cover.1741338765.git.pabeni@redhat.com>
 <8c8263ab59b1e9366f245eec4dfdccd368496e3d.1741338765.git.pabeni@redhat.com>
Subject: Re: [PATCH v2 net-next 2/2] udp_tunnel: use static call for GRO hooks
 when possible
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Paolo Abeni wrote:
> It's quite common to have a single UDP tunnel type active in the
> whole system. In such a case we can replace the indirect call for
> the UDP tunnel GRO callback with a static call.
> 
> Add the related accounting in the control path and switch to static
> call when possible. To keep the code simple use a static array for
> the registered tunnel types, and size such array based on the kernel
> config.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v1 -> v2:
>  - fix UDP_TUNNEL=n build
> ---
>  include/net/udp_tunnel.h   |   4 ++
>  net/ipv4/udp_offload.c     | 140 ++++++++++++++++++++++++++++++++++++-
>  net/ipv4/udp_tunnel_core.c |   2 +
>  3 files changed, 145 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
> index eda0f3e2f65fa..a7b230867eb14 100644
> --- a/include/net/udp_tunnel.h
> +++ b/include/net/udp_tunnel.h
> @@ -205,9 +205,11 @@ static inline void udp_tunnel_encap_enable(struct sock *sk)
>  
>  #if IS_ENABLED(CONFIG_NET_UDP_TUNNEL)
>  void udp_tunnel_update_gro_lookup(struct net *net, struct sock *sk, bool add);
> +void udp_tunnel_update_gro_rcv(struct sock *sk, bool add);
>  #else
>  static inline void udp_tunnel_update_gro_lookup(struct net *net,
>  						struct sock *sk, bool add) {}
> +static inline void udp_tunnel_update_gro_rcv(struct sock *sk, bool add) {}
>  #endif
>  
>  static inline void udp_tunnel_cleanup_gro(struct sock *sk)
> @@ -215,6 +217,8 @@ static inline void udp_tunnel_cleanup_gro(struct sock *sk)
>  	struct udp_sock *up = udp_sk(sk);
>  	struct net *net = sock_net(sk);
>  
> +	udp_tunnel_update_gro_rcv(sk, false);
> +
>  	if (!up->tunnel_list.pprev)
>  		return;
>  
> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> index 054d4d4a8927f..f06dd82d28562 100644
> --- a/net/ipv4/udp_offload.c
> +++ b/net/ipv4/udp_offload.c
> @@ -15,6 +15,39 @@
>  #include <net/udp_tunnel.h>
>  
>  #if IS_ENABLED(CONFIG_NET_UDP_TUNNEL)
> +
> +/*
> + * Dummy GRO tunnel callback; should never be invoked, exists
> + * mainly to avoid dangling/NULL values for the udp tunnel
> + * static call.
> + */
> +static struct sk_buff *dummy_gro_rcv(struct sock *sk,
> +				     struct list_head *head,
> +				     struct sk_buff *skb)
> +{
> +	WARN_ON_ONCE(1);
> +	NAPI_GRO_CB(skb)->flush = 1;
> +	return NULL;
> +}
> +
> +typedef struct sk_buff *(*udp_tunnel_gro_rcv_t)(struct sock *sk,
> +						struct list_head *head,
> +						struct sk_buff *skb);
> +
> +struct udp_tunnel_type_entry {
> +	udp_tunnel_gro_rcv_t gro_receive;
> +	refcount_t count;
> +};
> +
> +#define UDP_MAX_TUNNEL_TYPES (IS_ENABLED(CONFIG_GENEVE) + \
> +			      IS_ENABLED(CONFIG_VXLAN) * 2 + \
> +			      IS_ENABLED(CONFIG_FOE) * 2)

CONFIG_BAREUDP

> +
> +DEFINE_STATIC_CALL(udp_tunnel_gro_rcv, dummy_gro_rcv);
> +static DEFINE_STATIC_KEY_FALSE(udp_tunnel_static_call);
> +static struct mutex udp_tunnel_gro_type_lock;
> +static struct udp_tunnel_type_entry udp_tunnel_gro_types[UDP_MAX_TUNNEL_TYPES];
> +static unsigned int udp_tunnel_gro_type_nr;
>  static DEFINE_SPINLOCK(udp_tunnel_gro_lock);
>  
>  void udp_tunnel_update_gro_lookup(struct net *net, struct sock *sk, bool add)
> @@ -43,6 +76,109 @@ void udp_tunnel_update_gro_lookup(struct net *net, struct sock *sk, bool add)
>  	spin_unlock(&udp_tunnel_gro_lock);
>  }
>  EXPORT_SYMBOL_GPL(udp_tunnel_update_gro_lookup);
> +
> +void udp_tunnel_update_gro_rcv(struct sock *sk, bool add)
> +{
> +	struct udp_tunnel_type_entry *cur = NULL, *avail = NULL;
> +	struct udp_sock *up = udp_sk(sk);
> +	bool enabled, old_enabled;
> +	int i;
> +
> +	if (!up->gro_receive)
> +		return;
> +
> +	mutex_lock(&udp_tunnel_gro_type_lock);
> +	for (i = 0; i < UDP_MAX_TUNNEL_TYPES; i++) {
> +		if (!refcount_read(&udp_tunnel_gro_types[i].count))
> +			avail = &udp_tunnel_gro_types[i];
> +		else if (udp_tunnel_gro_types[i].gro_receive == up->gro_receive)
> +			cur = &udp_tunnel_gro_types[i];
> +	}
> +	old_enabled = udp_tunnel_gro_type_nr == 1;
> +	if (add) {
> +		/*
> +		 * Update the matching entry, if found, or add a new one
> +		 * if needed
> +		 */
> +		if (cur) {
> +			refcount_inc(&cur->count);
> +			goto out;
> +		}
> +
> +		if (unlikely(!avail)) {
> +			/* Ensure static call will never be enabled */
> +			pr_err_once("Unexpected amount of UDP tunnel types, please update UDP_MAX_TUNNEL_TYPES\n");
> +			udp_tunnel_gro_type_nr = UDP_MAX_TUNNEL_TYPES + 1;
> +			goto out;
> +		}
> +
> +		refcount_set(&avail->count, 1);
> +		avail->gro_receive = up->gro_receive;
> +		udp_tunnel_gro_type_nr++;
> +	} else {
> +		/*
> +		 * The stack cleanups only successfully added tunnel, the
> +		 * lookup on removal should never fail.
> +		 */
> +		if (WARN_ON_ONCE(!cur))
> +			goto out;
> +
> +		if (!refcount_dec_and_test(&cur->count))
> +			goto out;
> +		udp_tunnel_gro_type_nr--;
> +	}
> +
> +	/* Update the static call only when switching status */
> +	enabled = udp_tunnel_gro_type_nr == 1;
> +	if (enabled && !old_enabled) {
> +		for (i = 0; i < UDP_MAX_TUNNEL_TYPES; i++) {
> +			cur = &udp_tunnel_gro_types[i];
> +			if (refcount_read(&cur->count)) {
> +				static_call_update(udp_tunnel_gro_rcv,
> +						   cur->gro_receive);
> +				static_branch_enable(&udp_tunnel_static_call);
> +			}
> +		}
> +	} else if (!enabled && old_enabled) {
> +		static_branch_disable(&udp_tunnel_static_call);
> +		static_call_update(udp_tunnel_gro_rcv, dummy_gro_rcv);
> +	}

Same is patch 1: is the added complexity of tracking all tunnels warranted,
over just optimistically claiming the static_call for the first tunnel and
leaving it NULL when that is removed, even if other tunnels were added in
the meantime.
> +
> +out:
> +	mutex_unlock(&udp_tunnel_gro_type_lock);
> +}
> +EXPORT_SYMBOL_GPL(udp_tunnel_update_gro_rcv);
> +
> +static void udp_tunnel_gro_init(void)
> +{
> +	mutex_init(&udp_tunnel_gro_type_lock);
> +}
> +
> +static struct sk_buff *udp_tunnel_gro_rcv(struct sock *sk,
> +					  struct list_head *head,
> +					  struct sk_buff *skb)
> +{
> +	if (static_branch_likely(&udp_tunnel_static_call)) {
> +		if (unlikely(gro_recursion_inc_test(skb))) {
> +			NAPI_GRO_CB(skb)->flush |= 1;
> +			return NULL;
> +		}
> +		return static_call(udp_tunnel_gro_rcv)(sk, head, skb);
> +	}
> +	return call_gro_receive_sk(udp_sk(sk)->gro_receive, sk, head, skb);
> +}
> +
> +#else
> +
> +static void udp_tunnel_gro_init(void) {}
> +
> +static struct sk_buff *udp_tunnel_gro_rcv(struct sock *sk,
> +					  struct list_head *head,
> +					  struct sk_buff *skb)
> +{
> +	return call_gro_receive_sk(udp_sk(sk)->gro_receive, sk, head, skb);
> +}
> +
>  #endif
>  
>  static struct sk_buff *__skb_udp_tunnel_segment(struct sk_buff *skb,
> @@ -654,7 +790,7 @@ struct sk_buff *udp_gro_receive(struct list_head *head, struct sk_buff *skb,
>  
>  	skb_gro_pull(skb, sizeof(struct udphdr)); /* pull encapsulating udp header */
>  	skb_gro_postpull_rcsum(skb, uh, sizeof(struct udphdr));
> -	pp = call_gro_receive_sk(udp_sk(sk)->gro_receive, sk, head, skb);
> +	pp = udp_tunnel_gro_rcv(sk, head, skb);
>  
>  out:
>  	skb_gro_flush_final(skb, pp, flush);
> @@ -804,5 +940,7 @@ int __init udpv4_offload_init(void)
>  			.gro_complete =	udp4_gro_complete,
>  		},
>  	};
> +
> +	udp_tunnel_gro_init();
>  	return inet_add_offload(&net_hotdata.udpv4_offload, IPPROTO_UDP);
>  }
> diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
> index b969c997c89c7..1ebc5daff5bc8 100644
> --- a/net/ipv4/udp_tunnel_core.c
> +++ b/net/ipv4/udp_tunnel_core.c
> @@ -90,6 +90,8 @@ void setup_udp_tunnel_sock(struct net *net, struct socket *sock,
>  
>  	udp_tunnel_encap_enable(sk);
>  
> +	udp_tunnel_update_gro_rcv(sock->sk, true);
> +
>  	if (!sk->sk_dport && !sk->sk_bound_dev_if && sk_saddr_any(sock->sk))
>  		udp_tunnel_update_gro_lookup(net, sock->sk, true);
>  }
> -- 
> 2.48.1
> 



