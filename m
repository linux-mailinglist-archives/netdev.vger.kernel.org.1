Return-Path: <netdev+bounces-173194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 314CCA57D42
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 19:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85348189323F
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 18:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176CD204C36;
	Sat,  8 Mar 2025 18:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDxT+ckF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C311DE4E7
	for <netdev@vger.kernel.org>; Sat,  8 Mar 2025 18:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741459072; cv=none; b=Fpa7w1aBhE8tSd9bwLzwMYEs7dR4a41r3Bd4ypU514osnbOQZnKvze8GZvBTwOGES6kLDDcvWauTNAlqoncpfOz2E1lAvhF0CT2701d4Vp9X/1cL2yEJ6LTXWwy/HYAMjHwpZ3ujIqhzj7XseC/58ZvCrHv0PbYJ5fmUU5E5wJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741459072; c=relaxed/simple;
	bh=hGH9H2Em6dUfz+FB+YUuYHtrIx+DdkgF+nnToxJLCQ8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=mfAhWDF+TM93uiXRGZKPtodam6Je+5czXaO1/uuvKaT7lzXDfd4go2r7xZgJWYG3dXQ+rBuW9ibbMGj9rFFfIQuDaBnSbXvxJUEKeh0UxtvK7rXxRiBnPzTXYeAhC6nyvWmKhwvqVx4ufhWksVYniEmQ0To/kDYZasYnYoaQlQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aDxT+ckF; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c2303a56d6so336782885a.3
        for <netdev@vger.kernel.org>; Sat, 08 Mar 2025 10:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741459067; x=1742063867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xyOnACLEBTEeVdGBu+r1oHAUEb0TZ6VD0nWGOA9Jr10=;
        b=aDxT+ckFfK+s/qRet+6WY2kL/pzbDpGIUaydGYJMkeNWiyOEAUCfJDj0IVLAkHjyGC
         Nak6GjQXe61vko8zyztvM1ElVqvSTCE1PV/lNcwE7dehvROXf8M4ijyU2btaeZ18aUIy
         LRqWhY3iT9CtqMcjwhHVaGLAhNTYby424Ke+oK7xXc2r6GaVsBlaAupTmrX6Vaw9/auv
         FAtJFPn1xkWzeCNyp4MvOWmXQ8ga4O/f/qHge86vAXJSuyywaMLVfSV7wpGBGOvz+1um
         ND00U89qdc+2JmYVmT8J46ZuEtH33I8wkd/kWCVMnP44x9/BFSPaA+T4Qgf8Z6n/vzO0
         SGJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741459067; x=1742063867;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xyOnACLEBTEeVdGBu+r1oHAUEb0TZ6VD0nWGOA9Jr10=;
        b=UF0qByIN6lnJ7Jc36kx5HnzGh4O0xVO+ey5JqXX2bWjHdh17vVcbT2zdF+Yo59hMNh
         MMD5v+a/DEpwEjG1FX7eekGhjYKgVPnmOWlRsY4sirKdOMUyAMsOwfO7BpjNEwWsf11D
         SGlPzpUZmZ/oNUqEHUHHhBagkLko2dJmoKkLIrCtpgjNRz2RbX5Foh4mAGIc5xpQSf2r
         z88tCcVys+f+APPCobmjPrT+DuyEY9KgqGwN20mURd6F4wMK8b+Z2frcxG1r6bg0XNna
         ZTDlhZpiWuFKZNHxyBhdGAULAGdxtTLPNJ9PLP5RsIuZLSkh0R6x+RPt4ppROgBTCHXl
         IlVg==
X-Forwarded-Encrypted: i=1; AJvYcCU35O3g+yjb9FdIQoZrxo/aDULPWKNWPvxFu5ve12YWY6rhwhA306/XV5zwL8/dtAlrYAo95KE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5A22J5uW2Shy35tmeEorxAAtegsOPsdUh6guCN4DyAx9DxIFe
	S5Tzj2fodIxMjvpJWjnP8qYJUzpESJEvVwGjTZCvf9C7JsFQaA0H
X-Gm-Gg: ASbGnctyOmlfun3qHTUBjbdgw51jQPa5zNREkU5mOKWgaqodsputjejIfIvczdRFBDU
	vR7xnj5Xpx7hErZKGAEg+JSNrYNHnpXoOFovwFUx9l9KGsQDWiv8ibjUedaiPTmbq2cpMUS0uBl
	kWFachiRq4cJQ5Sxmcz3ThsSUYQ3lh3gc+/qbKhNWamUHfNqkCmmKv8WjAmdaOPEjQcUA8TXTal
	ftk/21QuUilnoXACgZoqnITTb4GVgsG7mebqr5qB53e7AtuTvRUM5QkYUrhh2pzsh1UCPed9Rwd
	9dwTxXv0yR5avGtQat6DBK4/yYL1oo7BnuLT8OQr3VboSMo2MYpzNRddnDxPeAbNdEqBHfKjatF
	xiPhrya7J0MjK/2MISLISEw==
X-Google-Smtp-Source: AGHT+IHraQRFnuaPPk8GaHjdzS0xtXihHugsiEyhlfpqfX99P52lYxns1kd44tecQf6j6V5RushaFw==
X-Received: by 2002:a05:620a:2b96:b0:7c3:cc25:5109 with SMTP id af79cd13be357-7c4e61a91d3mr1279589985a.49.1741459066762;
        Sat, 08 Mar 2025 10:37:46 -0800 (PST)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e5511047sm401348385a.100.2025.03.08.10.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 10:37:45 -0800 (PST)
Date: Sat, 08 Mar 2025 13:37:45 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>
Message-ID: <67cc8e796ee81_14b9f929496@willemb.c.googlers.com.notmuch>
In-Reply-To: <800d15eb0bd55fd2863120147e497af36e61e3ca.1741338765.git.pabeni@redhat.com>
References: <cover.1741338765.git.pabeni@redhat.com>
 <800d15eb0bd55fd2863120147e497af36e61e3ca.1741338765.git.pabeni@redhat.com>
Subject: Re: [PATCH v2 net-next 1/2] udp_tunnel: create a fastpath GRO lookup.
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
> Most UDP tunnels bind a socket to a local port, with ANY address, no
> peer and no interface index specified.
> Additionally it's quite common to have a single tunnel device per
> namespace.
> 
> Track in each namespace the UDP tunnel socket respecting the above.
> When only a single one is present, store a reference in the netns.
> 
> When such reference is not NULL, UDP tunnel GRO lookup just need to
> match the incoming packet destination port vs the socket local port.
> 
> The tunnel socket never sets the reuse[port] flag[s]. When bound to no
> address and interface, no other socket can exist in the same netns
> matching the specified local port.
> 
> Note that the UDP tunnel socket reference is stored into struct
> netns_ipv4 for both IPv4 and IPv6 tunnels. That is intentional to keep
> all the fastpath-related netns fields in the same struct and allow
> cacheline-based optimization. Currently both the IPv4 and IPv6 socket
> pointer share the same cacheline as the `udp_table` field.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v1: v2:
>  - fix [1] -> [i] typo
>  - avoid replacing static_branch_dec(udp_encap_needed_key) with
>    udp_encap_disable() (no-op)
>  - move ipv6 cleanup after encap disable
>  - clarified the design choice in the commit message
> ---
>  include/linux/udp.h        | 16 ++++++++++++++++
>  include/net/netns/ipv4.h   | 11 +++++++++++
>  include/net/udp.h          |  1 +
>  include/net/udp_tunnel.h   | 18 ++++++++++++++++++
>  net/ipv4/udp.c             | 13 ++++++++++++-
>  net/ipv4/udp_offload.c     | 37 +++++++++++++++++++++++++++++++++++++
>  net/ipv4/udp_tunnel_core.c | 12 ++++++++++++
>  net/ipv6/udp.c             |  2 ++
>  net/ipv6/udp_offload.c     |  5 +++++
>  9 files changed, 114 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/udp.h b/include/linux/udp.h
> index 0807e21cfec95..895240177f4f4 100644
> --- a/include/linux/udp.h
> +++ b/include/linux/udp.h
> @@ -101,6 +101,13 @@ struct udp_sock {
>  
>  	/* Cache friendly copy of sk->sk_peek_off >= 0 */
>  	bool		peeking_with_offset;
> +
> +	/*
> +	 * Accounting for the tunnel GRO fastpath.
> +	 * Unprotected by compilers guard, as it uses space available in
> +	 * the last UDP socket cacheline.
> +	 */
> +	struct hlist_node	tunnel_list;
>  };
>  
>  #define udp_test_bit(nr, sk)			\
> @@ -219,4 +226,13 @@ static inline void udp_allow_gso(struct sock *sk)
>  
>  #define IS_UDPLITE(__sk) (__sk->sk_protocol == IPPROTO_UDPLITE)
>  
> +static inline struct sock *udp_tunnel_sk(const struct net *net, bool is_ipv6)
> +{
> +#if IS_ENABLED(CONFIG_NET_UDP_TUNNEL)
> +	return rcu_dereference(net->ipv4.udp_tunnel_gro[is_ipv6].sk);
> +#else
> +	return NULL;
> +#endif
> +}
> +
>  #endif	/* _LINUX_UDP_H */
> diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
> index 650b2dc9199f4..6373e3f17da84 100644
> --- a/include/net/netns/ipv4.h
> +++ b/include/net/netns/ipv4.h
> @@ -47,6 +47,11 @@ struct sysctl_fib_multipath_hash_seed {
>  };
>  #endif
>  
> +struct udp_tunnel_gro {
> +	struct sock __rcu *sk;
> +	struct hlist_head list;
> +};
> +
>  struct netns_ipv4 {
>  	/* Cacheline organization can be found documented in
>  	 * Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst.
> @@ -85,6 +90,11 @@ struct netns_ipv4 {
>  	struct inet_timewait_death_row tcp_death_row;
>  	struct udp_table *udp_table;
>  
> +#if IS_ENABLED(CONFIG_NET_UDP_TUNNEL)
> +	/* Not in a pernet subsys because need to be available at GRO stage */
> +	struct udp_tunnel_gro udp_tunnel_gro[2];
> +#endif
> +
>  #ifdef CONFIG_SYSCTL
>  	struct ctl_table_header	*forw_hdr;
>  	struct ctl_table_header	*frags_hdr;
> @@ -277,4 +287,5 @@ struct netns_ipv4 {
>  	struct hlist_head	*inet_addr_lst;
>  	struct delayed_work	addr_chk_work;
>  };
> +
>  #endif
> diff --git a/include/net/udp.h b/include/net/udp.h
> index 6e89520e100dc..a772510b2aa58 100644
> --- a/include/net/udp.h
> +++ b/include/net/udp.h
> @@ -290,6 +290,7 @@ static inline void udp_lib_init_sock(struct sock *sk)
>  	struct udp_sock *up = udp_sk(sk);
>  
>  	skb_queue_head_init(&up->reader_queue);
> +	INIT_HLIST_NODE(&up->tunnel_list);
>  	up->forward_threshold = sk->sk_rcvbuf >> 2;
>  	set_bit(SOCK_CUSTOM_SOCKOPT, &sk->sk_socket->flags);
>  }
> diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
> index a93dc51f6323e..eda0f3e2f65fa 100644
> --- a/include/net/udp_tunnel.h
> +++ b/include/net/udp_tunnel.h
> @@ -203,6 +203,24 @@ static inline void udp_tunnel_encap_enable(struct sock *sk)
>  	udp_encap_enable();
>  }
>  
> +#if IS_ENABLED(CONFIG_NET_UDP_TUNNEL)
> +void udp_tunnel_update_gro_lookup(struct net *net, struct sock *sk, bool add);
> +#else
> +static inline void udp_tunnel_update_gro_lookup(struct net *net,
> +						struct sock *sk, bool add) {}
> +#endif
> +
> +static inline void udp_tunnel_cleanup_gro(struct sock *sk)
> +{
> +	struct udp_sock *up = udp_sk(sk);
> +	struct net *net = sock_net(sk);
> +
> +	if (!up->tunnel_list.pprev)
> +		return;
> +
> +	udp_tunnel_update_gro_lookup(net, sk, false);
> +}
> +
>  #define UDP_TUNNEL_NIC_MAX_TABLES	4
>  
>  enum udp_tunnel_nic_info_flags {
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 17c7736d83494..ba6286fff077c 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -2891,8 +2891,10 @@ void udp_destroy_sock(struct sock *sk)
>  			if (encap_destroy)
>  				encap_destroy(sk);
>  		}
> -		if (udp_test_bit(ENCAP_ENABLED, sk))
> +		if (udp_test_bit(ENCAP_ENABLED, sk)) {
>  			static_branch_dec(&udp_encap_needed_key);
> +			udp_tunnel_cleanup_gro(sk);
> +		}
>  	}
>  }
>  
> @@ -3804,6 +3806,15 @@ static void __net_init udp_set_table(struct net *net)
>  
>  static int __net_init udp_pernet_init(struct net *net)
>  {
> +#if IS_ENABLED(CONFIG_NET_UDP_TUNNEL)
> +	int i;
> +
> +	/* No tunnel is configured */
> +	for (i = 0; i < ARRAY_SIZE(net->ipv4.udp_tunnel_gro); ++i) {
> +		INIT_HLIST_HEAD(&net->ipv4.udp_tunnel_gro[i].list);
> +		rcu_assign_pointer(net->ipv4.udp_tunnel_gro[i].sk, NULL);

nit: RCU_INIT_POINTER suffices

> +	}
> +#endif
>  	udp_sysctl_init(net);
>  	udp_set_table(net);
>  
> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> index 2c0725583be39..054d4d4a8927f 100644
> --- a/net/ipv4/udp_offload.c
> +++ b/net/ipv4/udp_offload.c
> @@ -12,6 +12,38 @@
>  #include <net/udp.h>
>  #include <net/protocol.h>
>  #include <net/inet_common.h>
> +#include <net/udp_tunnel.h>
> +
> +#if IS_ENABLED(CONFIG_NET_UDP_TUNNEL)
> +static DEFINE_SPINLOCK(udp_tunnel_gro_lock);
> +
> +void udp_tunnel_update_gro_lookup(struct net *net, struct sock *sk, bool add)
> +{
> +	bool is_ipv6 = sk->sk_family == AF_INET6;
> +	struct udp_sock *tup, *up = udp_sk(sk);
> +	struct udp_tunnel_gro *udp_tunnel_gro;
> +
> +	spin_lock(&udp_tunnel_gro_lock);
> +	udp_tunnel_gro = &net->ipv4.udp_tunnel_gro[is_ipv6];
> +	if (add)
> +		hlist_add_head(&up->tunnel_list, &udp_tunnel_gro->list);
> +	else
> +		hlist_del_init(&up->tunnel_list);
> +
> +	if (udp_tunnel_gro->list.first &&
> +	    !udp_tunnel_gro->list.first->next) {
> +		tup = hlist_entry(udp_tunnel_gro->list.first, struct udp_sock,
> +				  tunnel_list);
> +
> +		rcu_assign_pointer(udp_tunnel_gro->sk, (struct sock *)tup);

If the targeted case is a single tunnel, is it worth maintaining the list?

If I understand correctly, it is only there to choose a fall-back when the
current tup is removed. But complicates the code quite a bit.

Just curious: what does tup stand for?

> +	} else {
> +		rcu_assign_pointer(udp_tunnel_gro->sk, NULL);
> +	}
> +
> +	spin_unlock(&udp_tunnel_gro_lock);
> +}
> +EXPORT_SYMBOL_GPL(udp_tunnel_update_gro_lookup);
> +#endif
>  
>  static struct sk_buff *__skb_udp_tunnel_segment(struct sk_buff *skb,
>  	netdev_features_t features,
> @@ -635,8 +667,13 @@ static struct sock *udp4_gro_lookup_skb(struct sk_buff *skb, __be16 sport,
>  {
>  	const struct iphdr *iph = skb_gro_network_header(skb);
>  	struct net *net = dev_net_rcu(skb->dev);
> +	struct sock *sk;
>  	int iif, sdif;
>  
> +	sk = udp_tunnel_sk(net, false);
> +	if (sk && dport == htons(sk->sk_num))
> +		return sk;
> +
>  	inet_get_iif_sdif(skb, &iif, &sdif);
>  
>  	return __udp4_lib_lookup(net, iph->saddr, sport,
> diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
> index 619a53eb672da..b969c997c89c7 100644
> --- a/net/ipv4/udp_tunnel_core.c
> +++ b/net/ipv4/udp_tunnel_core.c
> @@ -58,6 +58,15 @@ int udp_sock_create4(struct net *net, struct udp_port_cfg *cfg,
>  }
>  EXPORT_SYMBOL(udp_sock_create4);
>  
> +static inline bool sk_saddr_any(struct sock *sk)
> +{
> +#if IS_ENABLED(CONFIG_IPV6)
> +	return ipv6_addr_any(&sk->sk_v6_rcv_saddr);
> +#else
> +	return !sk->sk_rcv_saddr;
> +#endif
> +}
> +
>  void setup_udp_tunnel_sock(struct net *net, struct socket *sock,
>  			   struct udp_tunnel_sock_cfg *cfg)
>  {
> @@ -80,6 +89,9 @@ void setup_udp_tunnel_sock(struct net *net, struct socket *sock,
>  	udp_sk(sk)->gro_complete = cfg->gro_complete;
>  
>  	udp_tunnel_encap_enable(sk);
> +
> +	if (!sk->sk_dport && !sk->sk_bound_dev_if && sk_saddr_any(sock->sk))
> +		udp_tunnel_update_gro_lookup(net, sock->sk, true);
>  }
>  EXPORT_SYMBOL_GPL(setup_udp_tunnel_sock);
>  
> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index 3a0d6c5a8286b..4701b0dee8c4e 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -46,6 +46,7 @@
>  #include <net/tcp_states.h>
>  #include <net/ip6_checksum.h>
>  #include <net/ip6_tunnel.h>
> +#include <net/udp_tunnel.h>
>  #include <net/xfrm.h>
>  #include <net/inet_hashtables.h>
>  #include <net/inet6_hashtables.h>
> @@ -1825,6 +1826,7 @@ void udpv6_destroy_sock(struct sock *sk)
>  		if (udp_test_bit(ENCAP_ENABLED, sk)) {
>  			static_branch_dec(&udpv6_encap_needed_key);
>  			udp_encap_disable();
> +			udp_tunnel_cleanup_gro(sk);
>  		}
>  	}
>  }
> diff --git a/net/ipv6/udp_offload.c b/net/ipv6/udp_offload.c
> index 404212dfc99ab..d8445ac1b2e43 100644
> --- a/net/ipv6/udp_offload.c
> +++ b/net/ipv6/udp_offload.c
> @@ -118,8 +118,13 @@ static struct sock *udp6_gro_lookup_skb(struct sk_buff *skb, __be16 sport,
>  {
>  	const struct ipv6hdr *iph = skb_gro_network_header(skb);
>  	struct net *net = dev_net_rcu(skb->dev);
> +	struct sock *sk;
>  	int iif, sdif;
>  
> +	sk = udp_tunnel_sk(net, true);
> +	if (sk && dport == htons(sk->sk_num))
> +		return sk;
> +
>  	inet6_get_iif_sdif(skb, &iif, &sdif);
>  
>  	return __udp6_lib_lookup(net, &iph->saddr, sport,
> -- 
> 2.48.1
> 



