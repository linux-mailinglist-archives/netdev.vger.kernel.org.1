Return-Path: <netdev+bounces-80071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C4B87CE2E
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 14:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C2921C213E5
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 13:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE62D2CCD3;
	Fri, 15 Mar 2024 13:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WPdpgSLE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BC626288
	for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 13:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710509896; cv=none; b=mvP+OhxFl/D0Li6kj8uT6SHq/AZ5dO5taIZNK3Z7rGEyT2eZpBI/hCVbG06Uer2xaEY57FCmPxW0ukcJsdcm8krCB6OvgS4eKaMBpT0lHc0OeYlB0/hnppWocbDyedGw0MKe4e0bhqQnbMC2ydX/VP+cZdn1w7W1L/403Y3SE0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710509896; c=relaxed/simple;
	bh=1qcMzHfiGpjmHDfWZUqRqmBar0r1sOkOTtHAbu7zvvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ADEuuruF6oR7fJr4JTBH0jp5mYoAc4fzaSMGMWjwdsAeaP3jE0a6WGw/Gil2CF/T0cAe8E1JXDxcPXpPtOxr539QrtRANVdHFvfi/bj71kc1S13qysaLowZSABy/YYIbVviLdiLnzZID+rHiw+Y3cAaaIjfnRC+AgYgBpIAF/hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WPdpgSLE; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-568898e47e2so14416a12.0
        for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 06:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710509892; x=1711114692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U3bFJ0R8PaQgJ1Og/AejVqX9GHKhfPt5iaRycZ3sn48=;
        b=WPdpgSLEJ4qr41CT+hO9nI9tZ6SMHw4hEghtvrzoPYJ0tm+FDAYFcbLGc7cYVWk8NY
         /C3qN0sZHXhk9G7XJBGYlwLBh25Zrbc1VD5kGqyuGlbdgkO2doEL1s5NLjLgDwb+i/5k
         1xW7z05LnBzZt8VCvqCfE+Rzd6mH7SuXmAg7RYwmmMxHWlLCEVPgAQSf07DBpsFcCfJn
         Rsk0VAu7hp6/TB2iyp5ZGpFqeT+xWNOz3N4dPAP2ATc5PRiSqOiFGEnP/EFU4710AsAn
         HGVNq3pyLIu9Aa5LirEk6P3lUood313w5e8gHGUkWePo+FYyWYbVHcjZk8ibYEYGqPso
         1UiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710509892; x=1711114692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U3bFJ0R8PaQgJ1Og/AejVqX9GHKhfPt5iaRycZ3sn48=;
        b=Q3NriOztnV4a4tulp0FaMVRS1zgWFn6HN5GLTGsUIMa5s7sYI5DYW48eGfRU0fiJuH
         hYF1U6XifxuLUZetp3i9ifRYEYl/sDcPpx1gRVueCqiSDEno2dEhIKZphDPEIqfOMzdZ
         SlfW2k8CmsB220jNF5njefWbCkWP4wImXkftjpDNg5liaEOS5NXdXehIr5VMNmD2lCJb
         LnMmcOpVUqAwsOdkGBHi1J0p45BKxKnalbffJCwS//Z5Vx+ySdLKmRW1xuPP79kYF9l0
         HLWaoHYlIFEggeKX6v03SvYlUM5Q+fAfhD83PXXEb6W4tDkLpbI8epr8OAivF8cBUJTV
         odyQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0wVzz6VfaRIjE6wsYXrvEHsnF+0pMfkJCRW1hJ/QiNPGgUN3JI0Z/32b1ISHD5PPhcEF7XFraiCD2ytup3W8Rk7AtsGhN
X-Gm-Message-State: AOJu0Yw74V67EbLicydHH2ihRPcbFwefsIjPlnbRCafw5V2KwEFdpDDw
	tGjjTpD0tCww5sMYfxe+INmbhmGvB5E60NapWT9CY7t605FZoqHycFlQPSMxNR0P02gAXzgMy9N
	FsOUos4+HJvqxvarmsGJHAUrpYbZ56qvKlLHG
X-Google-Smtp-Source: AGHT+IFuT/1SgoR2KAZODZY3ZftzGPV9imxBX5OOT1fgTRgtkxhx6aba00ep0bxXeNmt4Hg0znYng3Esb2elWXjm4Oc=
X-Received: by 2002:a05:6402:1212:b0:568:551d:9e09 with SMTP id
 c18-20020a056402121200b00568551d9e09mr143571edw.6.1710509892087; Fri, 15 Mar
 2024 06:38:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115205514.68364-1-kuniyu@amazon.com> <20240115205514.68364-5-kuniyu@amazon.com>
In-Reply-To: <20240115205514.68364-5-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 15 Mar 2024 14:37:57 +0100
Message-ID: <CANn89iKdN9c+C_2JAUbc+VY3DDQjAQukMtiBbormAmAk9CdvQA@mail.gmail.com>
Subject: Re: [PATCH v8 bpf-next 4/6] bpf: tcp: Handle BPF SYN Cookie in cookie_v[46]_check().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 9:57=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> We will support arbitrary SYN Cookie with BPF in the following
> patch.
>
> If BPF prog validates ACK and kfunc allocates a reqsk, it will
> be carried to cookie_[46]_check() as skb->sk.  If skb->sk is not
> NULL, we call cookie_bpf_check().
>
> Then, we clear skb->sk and skb->destructor, which are needed not
> to hold refcnt for reqsk and the listener.  See the following patch
> for details.
>
> After that, we finish initialisation for the remaining fields with
> cookie_tcp_reqsk_init().
>
> Note that the server side WScale is set only for non-BPF SYN Cookie.

So the difference between BPF and non-BPF is using a req->syncookie
which had a prior meaning ?

This is very confusing, and needs documentation/comments.


>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  include/net/tcp.h     | 20 ++++++++++++++++++++
>  net/ipv4/syncookies.c | 31 +++++++++++++++++++++++++++----
>  net/ipv6/syncookies.c | 13 +++++++++----
>  3 files changed, 56 insertions(+), 8 deletions(-)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 114000e71a46..dfe99a084a71 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -599,6 +599,26 @@ static inline bool cookie_ecn_ok(const struct net *n=
et, const struct dst_entry *
>                 dst_feature(dst, RTAX_FEATURE_ECN);
>  }
>
> +#if IS_ENABLED(CONFIG_BPF)
> +static inline bool cookie_bpf_ok(struct sk_buff *skb)
> +{
> +       return skb->sk;
> +}
> +
> +struct request_sock *cookie_bpf_check(struct sock *sk, struct sk_buff *s=
kb);
> +#else
> +static inline bool cookie_bpf_ok(struct sk_buff *skb)
> +{
> +       return false;
> +}
> +
> +static inline struct request_sock *cookie_bpf_check(struct net *net, str=
uct sock *sk,
> +                                                   struct sk_buff *skb)
> +{
> +       return NULL;
> +}
> +#endif
> +
>  /* From net/ipv6/syncookies.c */
>  int __cookie_v6_check(const struct ipv6hdr *iph, const struct tcphdr *th=
);
>  struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb);
> diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> index 981944c22820..be88bf586ff9 100644
> --- a/net/ipv4/syncookies.c
> +++ b/net/ipv4/syncookies.c
> @@ -295,6 +295,24 @@ static int cookie_tcp_reqsk_init(struct sock *sk, st=
ruct sk_buff *skb,
>         return 0;
>  }
>
> +#if IS_ENABLED(CONFIG_BPF)
> +struct request_sock *cookie_bpf_check(struct sock *sk, struct sk_buff *s=
kb)
> +{
> +       struct request_sock *req =3D inet_reqsk(skb->sk);
> +
> +       skb->sk =3D NULL;
> +       skb->destructor =3D NULL;
> +
> +       if (cookie_tcp_reqsk_init(sk, skb, req)) {
> +               reqsk_free(req);
> +               req =3D NULL;
> +       }
> +
> +       return req;
> +}
> +EXPORT_SYMBOL_GPL(cookie_bpf_check);
> +#endif
> +
>  struct request_sock *cookie_tcp_reqsk_alloc(const struct request_sock_op=
s *ops,
>                                             struct sock *sk, struct sk_bu=
ff *skb,
>                                             struct tcp_options_received *=
tcp_opt,
> @@ -395,9 +413,13 @@ struct sock *cookie_v4_check(struct sock *sk, struct=
 sk_buff *skb)
>             !th->ack || th->rst)
>                 goto out;
>
> -       req =3D cookie_tcp_check(net, sk, skb);
> -       if (IS_ERR(req))
> -               goto out;
> +       if (cookie_bpf_ok(skb)) {
> +               req =3D cookie_bpf_check(sk, skb);
> +       } else {
> +               req =3D cookie_tcp_check(net, sk, skb);
> +               if (IS_ERR(req))
> +                       goto out;
> +       }
>         if (!req)
>                 goto out_drop;
>
> @@ -445,7 +467,8 @@ struct sock *cookie_v4_check(struct sock *sk, struct =
sk_buff *skb)
>                                   ireq->wscale_ok, &rcv_wscale,
>                                   dst_metric(&rt->dst, RTAX_INITRWND));
>
> -       ireq->rcv_wscale  =3D rcv_wscale;
> +       if (!req->syncookie)
> +               ireq->rcv_wscale =3D rcv_wscale;
>         ireq->ecn_ok &=3D cookie_ecn_ok(net, &rt->dst);
>
>         ret =3D tcp_get_cookie_sock(sk, skb, req, &rt->dst);
> diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
> index c8d2ca27220c..6b9c69278819 100644
> --- a/net/ipv6/syncookies.c
> +++ b/net/ipv6/syncookies.c
> @@ -182,9 +182,13 @@ struct sock *cookie_v6_check(struct sock *sk, struct=
 sk_buff *skb)
>             !th->ack || th->rst)
>                 goto out;
>
> -       req =3D cookie_tcp_check(net, sk, skb);
> -       if (IS_ERR(req))
> -               goto out;
> +       if (cookie_bpf_ok(skb)) {
> +               req =3D cookie_bpf_check(sk, skb);
> +       } else {
> +               req =3D cookie_tcp_check(net, sk, skb);
> +               if (IS_ERR(req))
> +                       goto out;
> +       }
>         if (!req)
>                 goto out_drop;
>
> @@ -247,7 +251,8 @@ struct sock *cookie_v6_check(struct sock *sk, struct =
sk_buff *skb)
>                                   ireq->wscale_ok, &rcv_wscale,
>                                   dst_metric(dst, RTAX_INITRWND));
>
> -       ireq->rcv_wscale =3D rcv_wscale;
> +       if (!req->syncookie)
> +               ireq->rcv_wscale =3D rcv_wscale;

I think a comment is deserved. I do not understand this.

cookie_v6_check() is dealing with syncookie, unless I am mistaken.

Also syzbot is not happy, req->syncookie might be uninitialized here.

BUG: KMSAN: uninit-value in cookie_v4_check+0x22b7/0x29e0
net/ipv4/syncookies.c:477
cookie_v4_check+0x22b7/0x29e0 net/ipv4/syncookies.c:477
tcp_v4_cookie_check net/ipv4/tcp_ipv4.c:1855 [inline]
tcp_v4_do_rcv+0xb17/0x10b0 net/ipv4/tcp_ipv4.c:1914
tcp_v4_rcv+0x4ce4/0x5420 net/ipv4/tcp_ipv4.c:2322
ip_protocol_deliver_rcu+0x2a3/0x13d0 net/ipv4/ip_input.c:205
ip_local_deliver_finish+0x332/0x500 net/ipv4/ip_input.c:233
NF_HOOK include/linux/netfilter.h:314 [inline]
ip_local_deliver+0x21f/0x490 net/ipv4/ip_input.c:254
dst_input include/net/dst.h:460 [inline]
ip_rcv_finish+0x4a2/0x520 net/ipv4/ip_input.c:449
NF_HOOK include/linux/netfilter.h:314 [inline]
ip_rcv+0xcd/0x380 net/ipv4/ip_input.c:569
__netif_receive_skb_one_core net/core/dev.c:5538 [inline]
__netif_receive_skb+0x319/0x9e0 net/core/dev.c:5652
process_backlog+0x480/0x8b0 net/core/dev.c:5981
__napi_poll+0xe7/0x980 net/core/dev.c:6632
napi_poll net/core/dev.c:6701 [inline]
net_rx_action+0x89d/0x1820 net/core/dev.c:6813
__do_softirq+0x1c0/0x7d7 kernel/softirq.c:554
do_softirq+0x9a/0x100 kernel/softirq.c:455
__local_bh_enable_ip+0x9f/0xb0 kernel/softirq.c:382
local_bh_enable include/linux/bottom_half.h:33 [inline]
rcu_read_unlock_bh include/linux/rcupdate.h:820 [inline]
__dev_queue_xmit+0x2776/0x52c0 net/core/dev.c:4362
dev_queue_xmit include/linux/netdevice.h:3091 [inline]
neigh_hh_output include/net/neighbour.h:526 [inline]
neigh_output include/net/neighbour.h:540 [inline]
ip_finish_output2+0x187a/0x1b70 net/ipv4/ip_output.c:235
__ip_finish_output+0x287/0x810
ip_finish_output+0x4b/0x550 net/ipv4/ip_output.c:323
NF_HOOK_COND include/linux/netfilter.h:303 [inline]
ip_output+0x15f/0x3f0 net/ipv4/ip_output.c:433
dst_output include/net/dst.h:450 [inline]
ip_local_out net/ipv4/ip_output.c:129 [inline]
__ip_queue_xmit+0x1e93/0x2030 net/ipv4/ip_output.c:535
ip_queue_xmit+0x60/0x80 net/ipv4/ip_output.c:549
__tcp_transmit_skb+0x3c70/0x4890 net/ipv4/tcp_output.c:1462
tcp_transmit_skb net/ipv4/tcp_output.c:1480 [inline]
tcp_write_xmit+0x3ee1/0x8900 net/ipv4/tcp_output.c:2792
__tcp_push_pending_frames net/ipv4/tcp_output.c:2977 [inline]
tcp_send_fin+0xa90/0x12e0 net/ipv4/tcp_output.c:3578
tcp_shutdown+0x198/0x1f0 net/ipv4/tcp.c:2716
inet_shutdown+0x33f/0x5b0 net/ipv4/af_inet.c:923
__sys_shutdown_sock net/socket.c:2425 [inline]
__sys_shutdown net/socket.c:2437 [inline]
__do_sys_shutdown net/socket.c:2445 [inline]
__se_sys_shutdown+0x2a4/0x440 net/socket.c:2443
__x64_sys_shutdown+0x6c/0xa0 net/socket.c:2443
do_syscall_64+0xd5/0x1f0
entry_SYSCALL_64_after_hwframe+0x6d/0x75

Uninit was stored to memory at:
reqsk_alloc include/net/request_sock.h:148 [inline]
inet_reqsk_alloc+0x651/0x7a0 net/ipv4/tcp_input.c:6978
cookie_tcp_reqsk_alloc+0xd4/0x900 net/ipv4/syncookies.c:328
cookie_tcp_check net/ipv4/syncookies.c:388 [inline]
cookie_v4_check+0x289f/0x29e0 net/ipv4/syncookies.c:420
tcp_v4_cookie_check net/ipv4/tcp_ipv4.c:1855 [inline]
tcp_v4_do_rcv+0xb17/0x10b0 net/ipv4/tcp_ipv4.c:1914
tcp_v4_rcv+0x4ce4/0x5420 net/ipv4/tcp_ipv4.c:2322
ip_protocol_deliver_rcu+0x2a3/0x13d0 net/ipv4/ip_input.c:205
ip_local_deliver_finish+0x332/0x500 net/ipv4/ip_input.c:233
NF_HOOK include/linux/netfilter.h:314 [inline]
ip_local_deliver+0x21f/0x490 net/ipv4/ip_input.c:254
dst_input include/net/dst.h:460 [inline]
ip_rcv_finish+0x4a2/0x520 net/ipv4/ip_input.c:449
NF_HOOK include/linux/netfilter.h:314 [inline]
ip_rcv+0xcd/0x380 net/ipv4/ip_input.c:569
__netif_receive_skb_one_core net/core/dev.c:5538 [inline]
__netif_receive_skb+0x319/0x9e0 net/core/dev.c:5652
process_backlog+0x480/0x8b0 net/core/dev.c:5981
__napi_poll+0xe7/0x980 net/core/dev.c:6632
napi_poll net/core/dev.c:6701 [inline]
net_rx_action+0x89d/0x1820 net/core/dev.c:6813
__do_softirq+0x1c0/0x7d7 kernel/softirq.c:554

Uninit was created at:
__alloc_pages+0x9a7/0xe00 mm/page_alloc.c:4592
__alloc_pages_node include/linux/gfp.h:238 [inline]
alloc_pages_node include/linux/gfp.h:261 [inline]
alloc_slab_page mm/slub.c:2175 [inline]
allocate_slab mm/slub.c:2338 [inline]
new_slab+0x2de/0x1400 mm/slub.c:2391
___slab_alloc+0x1184/0x33d0 mm/slub.c:3525
__slab_alloc mm/slub.c:3610 [inline]
__slab_alloc_node mm/slub.c:3663 [inline]
slab_alloc_node mm/slub.c:3835 [inline]
kmem_cache_alloc+0x6d3/0xbe0 mm/slub.c:3852
reqsk_alloc include/net/request_sock.h:131 [inline]
inet_reqsk_alloc+0x66/0x7a0 net/ipv4/tcp_input.c:6978
tcp_conn_request+0x484/0x44e0 net/ipv4/tcp_input.c:7135
tcp_v4_conn_request+0x16f/0x1d0 net/ipv4/tcp_ipv4.c:1716
tcp_rcv_state_process+0x2e5/0x4bb0 net/ipv4/tcp_input.c:6655
tcp_v4_do_rcv+0xbfd/0x10b0 net/ipv4/tcp_ipv4.c:1929
tcp_v4_rcv+0x4ce4/0x5420 net/ipv4/tcp_ipv4.c:2322
ip_protocol_deliver_rcu+0x2a3/0x13d0 net/ipv4/ip_input.c:205
ip_local_deliver_finish+0x332/0x500 net/ipv4/ip_input.c:233
NF_HOOK include/linux/netfilter.h:314 [inline]
ip_local_deliver+0x21f/0x490 net/ipv4/ip_input.c:254
dst_input include/net/dst.h:460 [inline]
ip_sublist_rcv_finish net/ipv4/ip_input.c:580 [inline]
ip_list_rcv_finish net/ipv4/ip_input.c:631 [inline]
ip_sublist_rcv+0x15f3/0x17f0 net/ipv4/ip_input.c:639
ip_list_rcv+0x9ef/0xa40 net/ipv4/ip_input.c:674
__netif_receive_skb_list_ptype net/core/dev.c:5581 [inline]
__netif_receive_skb_list_core+0x15c5/0x1670 net/core/dev.c:5629
__netif_receive_skb_list net/core/dev.c:5681 [inline]
netif_receive_skb_list_internal+0x106c/0x16f0 net/core/dev.c:5773
gro_normal_list include/net/gro.h:438 [inline]
napi_complete_done+0x425/0x880 net/core/dev.c:6113
virtqueue_napi_complete drivers/net/virtio_net.c:465 [inline]
virtnet_poll+0x149d/0x2240 drivers/net/virtio_net.c:2211
__napi_poll+0xe7/0x980 net/core/dev.c:6632
napi_poll net/core/dev.c:6701 [inline]
net_rx_action+0x89d/0x1820 net/core/dev.c:6813
__do_softirq+0x1c0/0x7d7 kernel/softirq.c:554

CPU: 0 PID: 16792 Comm: syz-executor.2 Not tainted
6.8.0-syzkaller-05562-g61387b8dcf1d #0
Hardware name: Google Google Compute Engine/Google Compute Engine,
BIOS Google 02/29/2024

