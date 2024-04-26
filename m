Return-Path: <netdev+bounces-91572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 505498B3161
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 09:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EC3D1C2251C
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 07:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA4413C3DF;
	Fri, 26 Apr 2024 07:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HJSTZU7j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4160013C3C3
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 07:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714116746; cv=none; b=G7i9RgP8Qo8CaqK2QXnqA7EnwCtDZTvjd0c8LL1YnymftzyVWyR74YI3ER5L9Ot+DT3hoJdtWVGqBRQjNafJYV98CMA0dSzddavN4XYt9BhMDlJo2vnwLgSP0zz4l2r5JBmFZSmb5AMq6kFMWgSk4aU4d4EMMLHk5I4vf2m0LVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714116746; c=relaxed/simple;
	bh=huZdh8GW0EXWSaQhXBQtDCOGAUHcTkfS3ydWBvzJTfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R6NqizkKDmMaKrXQaBKQ6MSj4S6EfaCl/hxEzdOkBAo1GEjnEz4wac7h6d9F1ZWzePh/a8Q5Y327hX/uVbK/Xr1gSgBkIceyxuEBjk8zuDs+IHBCHHD3uXzTY10Ouiqo/SWzwAdfXbYfd00tp6bhvUzlsC77xozqHTLgsivdZOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HJSTZU7j; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-571e13cd856so9204a12.0
        for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 00:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714116742; x=1714721542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55aGktq7fs+SXar6JRKvBBqXiEBqzDHYlydi7Q0XdwU=;
        b=HJSTZU7j+4tZ/XgJccHtoLutXeJL0szwCVMk0kOv5/nyKUPJzzW0dw+V1WX0hVng9h
         FM5aX2LcP5SbLPpS1oeH+KtpuYNgIPi1CZkCIsZoeeLqZTkjKh159YqmOl2G4C87WU2a
         qqukPDrzrTkgD8UDpBtFqi1CE6y3SmE05k/rdbH3R+sjGKSwdwh88i9q8rhFDdw9+ymB
         KIJFtVY85ECnRtQ+0L3xK8KzcezYiJZbBGFE9xJWmpPJA+GCXkmpi0A+5LQP3uLMl92y
         G1UjxgaWTqTuzjgX6vOnKFshhqdYASpNPvjeHpEj/SIyrbhs2OO7unZqX/KouOkJRU8N
         ZedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714116742; x=1714721542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=55aGktq7fs+SXar6JRKvBBqXiEBqzDHYlydi7Q0XdwU=;
        b=fnDxBQZSduRaSSwQiPfYcup9cfqzJGZKLOHHJqV7MqSPZ15JVSEvGkOT49WahjciId
         VxE3OonIKgDRjeca5oZ/tIcFzWEwPgrVYuRLIEbslXgNrGy1IKsw/IX8oK2CJZ0QNgqz
         QNMZk0JQjr4/cO6ZM1Pq5EjE4qNOgRMAjXCtQhoF0j47VkGR5EJpLkeRAhDaz66O4eq2
         qf93v+xC+rWRbIrivNw+Jm9A4B0eeYkeIonrpPWPd7hPnTOvbmMEE7nUg17tJ4wKwesc
         dHRq8P9c6ffn7sDU3qR5RQPrvPLjGnfx3X2NFQjEvJuPBN2Ctw8FWcHENL7LKq1byiwT
         b4FA==
X-Gm-Message-State: AOJu0YwtNDLc+Od6rPxz4yvUXsP16IMzZWygFfKMD4xAHO2wsQ4Ipc87
	xrVWHSzrJH482qIDliYs42N8t83MQIekR8yyaVjpaO61jf3VtOpUrSZNowT22ZmvS1kFV+FqDTf
	SJLZ/VdSyQDyB5u1jnHoDbJg9FkA7J6JW6wIt
X-Google-Smtp-Source: AGHT+IEmW9ouiJCqwPAVRnOSQEoBVj2s2LXB1190cNP9r+cvXOG1N7u66gEYNrtBxCX5nVZ0R/5anNWPcQRBeuT7d1k=
X-Received: by 2002:a05:6402:2285:b0:570:49e3:60a8 with SMTP id
 cw5-20020a056402228500b0057049e360a8mr70016edb.7.1714116742251; Fri, 26 Apr
 2024 00:32:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426065143.4667-1-nbd@nbd.name> <20240426065143.4667-7-nbd@nbd.name>
In-Reply-To: <20240426065143.4667-7-nbd@nbd.name>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 26 Apr 2024 09:32:11 +0200
Message-ID: <CANn89i+n76MEoQPbj8oxMMEw5N6T8KAP4Xp2YsUYb32fUzAJNg@mail.gmail.com>
Subject: Re: [PATCH v3 net-next v3 6/6] net: add heuristic for enabling TCP
 fraglist GRO
To: Felix Fietkau <nbd@nbd.name>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	willemdebruijn.kernel@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 8:51=E2=80=AFAM Felix Fietkau <nbd@nbd.name> wrote:
>
> When forwarding TCP after GRO, software segmentation is very expensive,
> especially when the checksum needs to be recalculated.
> One case where that's currently unavoidable is when routing packets over
> PPPoE. Performance improves significantly when using fraglist GRO
> implemented in the same way as for UDP.
>
> When NETIF_F_GRO_FRAGLIST is enabled, perform a lookup for an established
> socket in the same netns as the receiving device. While this may not
> cover all relevant use cases in multi-netns configurations, it should be
> good enough for most configurations that need this.
>
> Here's a measurement of running 2 TCP streams through a MediaTek MT7622
> device (2-core Cortex-A53), which runs NAT with flow offload enabled from
> one ethernet port to PPPoE on another ethernet port + cake qdisc set to
> 1Gbps.
>
> rx-gro-list off: 630 Mbit/s, CPU 35% idle
> rx-gro-list on:  770 Mbit/s, CPU 40% idle
>
> Signe-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  net/ipv4/tcp_offload.c   | 30 ++++++++++++++++++++++++++++++
>  net/ipv6/tcpv6_offload.c | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 63 insertions(+)
>
> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> index ee5403760775..2ae83f4394dc 100644
> --- a/net/ipv4/tcp_offload.c
> +++ b/net/ipv4/tcp_offload.c
> @@ -406,6 +406,34 @@ void tcp_gro_complete(struct sk_buff *skb)
>  }
>  EXPORT_SYMBOL(tcp_gro_complete);
>
> +static void tcp4_check_fraglist_gro(struct list_head *head, struct sk_bu=
ff *skb,
> +                                   struct tcphdr *th)
> +{
> +       const struct iphdr *iph =3D skb_gro_network_header(skb);
> +       struct net *net =3D dev_net(skb->dev);

Could you defer the initializations of iph and net after the
NETIF_F_GRO_FRAGLIST check ?

dev_net() has an implicit READ_ONCE() ...

> +       struct sk_buff *p;
> +       struct sock *sk;
> +       int iif, sdif;
> +
> +       if (!(skb->dev->features & NETIF_F_GRO_FRAGLIST))
> +               return;
> +
> +       p =3D tcp_gro_lookup(head, th);
> +       if (p) {
> +               NAPI_GRO_CB(skb)->is_flist =3D NAPI_GRO_CB(p)->is_flist;
> +               return;
> +       }
> +
> +       inet_get_iif_sdif(skb, &iif, &sdif);
> +       sk =3D __inet_lookup_established(net, net->ipv4.tcp_death_row.has=
hinfo,
> +                                      iph->saddr, th->source,
> +                                      iph->daddr, ntohs(th->dest),
> +                                      iif, sdif);
> +       NAPI_GRO_CB(skb)->is_flist =3D !sk;
> +       if (sk)
> +               sock_put(sk);
> +}
> +
>  INDIRECT_CALLABLE_SCOPE
>  struct sk_buff *tcp4_gro_receive(struct list_head *head, struct sk_buff =
*skb)
>  {
> @@ -421,6 +449,8 @@ struct sk_buff *tcp4_gro_receive(struct list_head *he=
ad, struct sk_buff *skb)
>         if (!th)
>                 goto flush;
>
> +       tcp4_check_fraglist_gro(head, skb, th);
> +
>         return tcp_gro_receive(head, skb, th);
>
>  flush:
> diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
> index c01ace2e9ff0..1ab45cca3936 100644
> --- a/net/ipv6/tcpv6_offload.c
> +++ b/net/ipv6/tcpv6_offload.c
> @@ -7,12 +7,43 @@
>   */
>  #include <linux/indirect_call_wrapper.h>
>  #include <linux/skbuff.h>
> +#include <net/inet6_hashtables.h>
>  #include <net/gro.h>
>  #include <net/protocol.h>
>  #include <net/tcp.h>
>  #include <net/ip6_checksum.h>
>  #include "ip6_offload.h"
>
> +static void tcp6_check_fraglist_gro(struct list_head *head, struct sk_bu=
ff *skb,
> +                                   struct tcphdr *th)
> +{
> +#if IS_ENABLED(CONFIG_IPV6)
> +       const struct ipv6hdr *hdr =3D skb_gro_network_header(skb);
> +       struct net *net =3D dev_net(skb->dev);

Same remark here.

> +       struct sk_buff *p;
> +       struct sock *sk;
> +       int iif, sdif;
> +
> +       if (!(skb->dev->features & NETIF_F_GRO_FRAGLIST))
> +               return;
> +
> +       p =3D tcp_gro_lookup(head, th);
> +       if (p) {
> +               NAPI_GRO_CB(skb)->is_flist =3D NAPI_GRO_CB(p)->is_flist;
> +               return;
> +       }
> +
> +       inet6_get_iif_sdif(skb, &iif, &sdif);
> +       sk =3D __inet6_lookup_established(net, net->ipv4.tcp_death_row.ha=
shinfo,
> +                                       &hdr->saddr, th->source,
> +                                       &hdr->daddr, ntohs(th->dest),
> +                                       iif, sdif);
> +       NAPI_GRO_CB(skb)->is_flist =3D !sk;
> +       if (sk)
> +               sock_put(sk);
> +#endif /* IS_ENABLED(CONFIG_IPV6) */
> +}
> +
>  INDIRECT_CALLABLE_SCOPE
>  struct sk_buff *tcp6_gro_receive(struct list_head *head, struct sk_buff =
*skb)
>  {
> @@ -28,6 +59,8 @@ struct sk_buff *tcp6_gro_receive(struct list_head *head=
, struct sk_buff *skb)
>         if (!th)
>                 goto flush;
>
> +       tcp6_check_fraglist_gro(head, skb, th);
> +
>         return tcp_gro_receive(head, skb, th);
>
>  flush:
> --
> 2.44.0
>

