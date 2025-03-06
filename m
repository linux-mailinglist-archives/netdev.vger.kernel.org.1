Return-Path: <netdev+bounces-172517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50389A55180
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 17:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C4AF16CE48
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 16:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B1A22154B;
	Thu,  6 Mar 2025 16:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oi300y3A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A1E2206B1
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 16:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741278954; cv=none; b=jIAs7dmzOYwgBCGwkD437bB1shsWf+YY8BpKAK863B9FvZP5MvHQTjBsBfc25J8FAn/mEcgWp4efRydJbH31BWL36r/kMI9+5r/KPzbCNbNBOUxlCuqbm+YAj80fHdIetIICoL58rIdWprJ38dllsAKcTtneJufR1Fj6TUtLr0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741278954; c=relaxed/simple;
	bh=tMGEurWJIi/qxqiIhOsWLBSdyEa6ZqUlBA4j8hRutuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UbXuJ2NBhyQP112E8kgz8hvaut7yWDyFeQuYsVxFu/ft3c7ONAjNMsE6c+lUL3FsLix9QONltZlYG4F2yIRj1Nt3yI3516ydQLMvZp8t3J82V6v1eQTrXLj0F2vTfOjkD5KkNqME603ceL1iegJwm+MgSm1qIlvoXnxcQxR1g30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Oi300y3A; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4750c3b0097so7342371cf.0
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 08:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741278952; x=1741883752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bngjpQZ5regs6A4j+T81CJzi15FiXmLcpqhCfp3JsAM=;
        b=Oi300y3AbzDYMCQ2dzMPhQwI6EUEKxDdtczcqr2audB6h+fj+4REIvlWAEMJvFAOJC
         6mKqTz51VoNNscHMWyKeKIkNXtXacAwJ84QiB2BVjlrhyabXOqmfu7TPBFdwtrEwxK9X
         cGFkanyPo8O52xXhJXwgAZpN1Jv89al+zYHvrDO/h2DoP5C1s3WspsSJUOKJMH1UC/UJ
         avJJf9/ww+D4BitzBqetD135WU9JYdnAuGbGKpSoHo/IQBx2kMqf3zWGGbf2NA0Q+bdZ
         Qcot/iR32rS80ciQX+UxX1e27w4e3DgLhJUzdPNiFg1JMdrkVEosWKFelDJ/5p1tZ9fu
         SpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741278952; x=1741883752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bngjpQZ5regs6A4j+T81CJzi15FiXmLcpqhCfp3JsAM=;
        b=A9QobnT/UuH/fnNEmAiMngRP/bp1ZdAUo5jRWmdSmFTzLkT5mrV/5iGjomzWck0ZdR
         Z+deoO615ywZLp304Qhlkkg1PdgxALzR7NnZxkIzc3GLgJhCpyb0NN5DWyhx7BrWj9aO
         VirKM1WAJMhI6xWIeVtgnvp+bnAzymitEJCbllcSBBByIpKaMFjFATvse51FAxi/rgAO
         u3VOAzmWzgy6q01meaQ/gG/2q5FXrh6PhAUOm5wdD7FpUQCm3NfARSoWZNKDzFFehJZv
         3jQBdh2lLe8vzhPKXRn4rB8jYXjVpL5luSc2SSyjIkqUE6F1oojT0wyiOKLDh8029rmT
         7t7w==
X-Gm-Message-State: AOJu0YygMvBXjgN9CIUO19nBv21xCunnR3GnD/0XSgOWi2S8ccgh8//r
	h+jNYJQMG/tEI56OGfY5owPqJjodFGpQheiF0LYDzN+C0vlx+1lsWX3QPugLSmPYsVEnJyRNtLS
	j+KL7OsSFVHZhCoPP6GaX/gZ2THScP4yFUPDfEXq53VxgXKeCwtLcOO8=
X-Gm-Gg: ASbGncs21p/5Vn2MldL8tIpCb9AiBbyB3YDy/8GTpa/ZetZrhs7VbCIzNWAHDTeYbqu
	fiuQvC2qEZYaXaeR2xtUCekAefiZ7Y8qEcLrc/PJu2kr/dmUWP4XNJ676BAUEQemQLewOaCOaGU
	MVql6h80OCP3rzDSMfkTlaM/pLVMg=
X-Google-Smtp-Source: AGHT+IEZa4yFyRjX1gRTrI29KfSSm9HHDHRHVzyOwLQXUdvlVBnS4hXj1vH16mZ/fs5+gjuSzxMkTfo9ZvdqhbuKmt0=
X-Received: by 2002:a05:622a:1348:b0:474:fa6e:ff54 with SMTP id
 d75a77b69052e-4750b4e7deamr95766051cf.49.1741278951524; Thu, 06 Mar 2025
 08:35:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1741275846.git.pabeni@redhat.com> <ef5aa34bd772ec9b6759cf0fde2d2854b3e98913.1741275846.git.pabeni@redhat.com>
In-Reply-To: <ef5aa34bd772ec9b6759cf0fde2d2854b3e98913.1741275846.git.pabeni@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 6 Mar 2025 17:35:40 +0100
X-Gm-Features: AQ5f1Jp152Tl0OyWOyJLoOcKQ4vKABiD2TA5_V-9Iy_JghJEAdsbVF5h0vzLjgQ
Message-ID: <CANn89iL3YFsZoOJpe=wp2uNiSvKFNbj8Kbxj11_iwk=8Sh0uuw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] udp_tunnel: create a fast-path GRO lookup.
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 4:57=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
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
> The tunnel socket never set the reuse[port] flag[s], when bound to no
> address and interface, no other socket can exist in the same netns
> matching the specified local port.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---

...

>  static int __net_init udp_pernet_init(struct net *net)
>  {
> +#if IS_ENABLED(CONFIG_NET_UDP_TUNNEL)
> +       int i;
> +
> +       /* No tunnel is configured */
> +       for (i =3D 0; i < ARRAY_SIZE(net->ipv4.udp_tunnel_gro); ++i) {
> +               INIT_HLIST_HEAD(&net->ipv4.udp_tunnel_gro[i].list);
> +               rcu_assign_pointer(net->ipv4.udp_tunnel_gro[1].sk, NULL);

typo : [i] is what you meant (instead of [1])

> +       }
> +#endif
>         udp_sysctl_init(net);
>         udp_set_table(net);
>
> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> index c1a85b300ee87..ac6dd2703190e 100644
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
> +void udp_tunnel_update_gro_lookup(struct net *net, struct sock *sk, bool=
 add)
> +{
> +       bool is_ipv6 =3D sk->sk_family =3D=3D AF_INET6;
> +       struct udp_sock *tup, *up =3D udp_sk(sk);
> +       struct udp_tunnel_gro *udp_tunnel_gro;
> +
> +       spin_lock(&udp_tunnel_gro_lock);
> +       udp_tunnel_gro =3D &net->ipv4.udp_tunnel_gro[is_ipv6];
> +       if (add)
> +               hlist_add_head(&up->tunnel_list, &udp_tunnel_gro->list);
> +       else
> +               hlist_del_init(&up->tunnel_list);
> +
> +       if (udp_tunnel_gro->list.first &&
> +           !udp_tunnel_gro->list.first->next) {
> +               tup =3D hlist_entry(udp_tunnel_gro->list.first, struct ud=
p_sock,
> +                                 tunnel_list);
> +
> +               rcu_assign_pointer(udp_tunnel_gro->sk, (struct sock *)tup=
);
> +       } else {
> +               rcu_assign_pointer(udp_tunnel_gro->sk, NULL);
> +       }
> +
> +       spin_unlock(&udp_tunnel_gro_lock);
> +}
> +EXPORT_SYMBOL_GPL(udp_tunnel_update_gro_lookup);
> +#endif
>
>  static struct sk_buff *__skb_udp_tunnel_segment(struct sk_buff *skb,
>         netdev_features_t features,
> @@ -631,8 +663,13 @@ static struct sock *udp4_gro_lookup_skb(struct sk_bu=
ff *skb, __be16 sport,
>  {
>         const struct iphdr *iph =3D skb_gro_network_header(skb);
>         struct net *net =3D dev_net_rcu(skb->dev);
> +       struct sock *sk;
>         int iif, sdif;
>
> +       sk =3D udp_tunnel_sk(net, false);
> +       if (sk && dport =3D=3D htons(sk->sk_num))
> +               return sk;
> +
>         inet_get_iif_sdif(skb, &iif, &sdif);
>
>         return __udp4_lib_lookup(net, iph->saddr, sport,
> diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
> index 619a53eb672da..b969c997c89c7 100644
> --- a/net/ipv4/udp_tunnel_core.c
> +++ b/net/ipv4/udp_tunnel_core.c
> @@ -58,6 +58,15 @@ int udp_sock_create4(struct net *net, struct udp_port_=
cfg *cfg,
>  }
>  EXPORT_SYMBOL(udp_sock_create4);
>
> +static inline bool sk_saddr_any(struct sock *sk)
> +{
> +#if IS_ENABLED(CONFIG_IPV6)
> +       return ipv6_addr_any(&sk->sk_v6_rcv_saddr);
> +#else
> +       return !sk->sk_rcv_saddr;
> +#endif
> +}
> +
>  void setup_udp_tunnel_sock(struct net *net, struct socket *sock,
>                            struct udp_tunnel_sock_cfg *cfg)
>  {
> @@ -80,6 +89,9 @@ void setup_udp_tunnel_sock(struct net *net, struct sock=
et *sock,
>         udp_sk(sk)->gro_complete =3D cfg->gro_complete;
>
>         udp_tunnel_encap_enable(sk);
> +
> +       if (!sk->sk_dport && !sk->sk_bound_dev_if && sk_saddr_any(sock->s=
k))
> +               udp_tunnel_update_gro_lookup(net, sock->sk, true);
>  }
>  EXPORT_SYMBOL_GPL(setup_udp_tunnel_sock);
>
> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index 3a0d6c5a8286b..3087022d18a55 100644
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
> @@ -1824,6 +1825,7 @@ void udpv6_destroy_sock(struct sock *sk)
>                 }
>                 if (udp_test_bit(ENCAP_ENABLED, sk)) {
>                         static_branch_dec(&udpv6_encap_needed_key);

In ipv4, you removed the static_branch_dec(&udp_encap_needed_key);

> +                       udp_tunnel_cleanup_gro(sk);
>                         udp_encap_disable();
>                 }
>         }
> diff --git a/net/ipv6/udp_offload.c b/net/ipv6/udp_offload.c
> index 404212dfc99ab..d8445ac1b2e43 100644
> --- a/net/ipv6/udp_offload.c
> +++ b/net/ipv6/udp_offload.c
> @@ -118,8 +118,13 @@ static struct sock *udp6_gro_lookup_skb(struct sk_bu=
ff *skb, __be16 sport,
>  {
>         const struct ipv6hdr *iph =3D skb_gro_network_header(skb);
>         struct net *net =3D dev_net_rcu(skb->dev);
> +       struct sock *sk;
>         int iif, sdif;
>
> +       sk =3D udp_tunnel_sk(net, true);
> +       if (sk && dport =3D=3D htons(sk->sk_num))
> +               return sk;
> +
>         inet6_get_iif_sdif(skb, &iif, &sdif);
>
>         return __udp6_lib_lookup(net, &iph->saddr, sport,
> --
> 2.48.1
>

