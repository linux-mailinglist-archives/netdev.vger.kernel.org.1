Return-Path: <netdev+bounces-242293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3596EC8E687
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 14:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9EC43AC5DB
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 13:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC75523F413;
	Thu, 27 Nov 2025 13:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lWbM5KIG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EA813A244
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 13:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764249502; cv=none; b=btCQKpHZVHXx66f6T/efGuUL69EDFS6AmQrdUZK/1ZSpFx4QHXF6tY9nmzSV5JMPH4jAZqijILaCnN87Z4QTltIw175udXdmkBzj6kcOJo/csjpZsS6q5sBCpNQDIXd3GxwUt5E745FXCMoBGVJdGOhZrluHh2LuF4zBUFqscbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764249502; c=relaxed/simple;
	bh=8mcctqvHpKRSeBkeS1TmhdGwI4zgMWBK4EheMovzRy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BX3uFg9w+LNzxsS5E/SwQN6eHY+wiJ7LGBfvyXtLVwnOk0OX0aCKTVNLwVxQyrF6QqPLH54x2/wq/kxvOqetdmYAdpv5soGOX/li1E1bG/VOjEaS/j8E3R+0jS7jC1vK68kR3BNJL1gpiY3H2VYY43ccAir44TNRgjbQ+db1SK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lWbM5KIG; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ee1939e70bso8101941cf.3
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 05:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764249499; x=1764854299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pOxQNhJxm0xD0VRBn/GmRc0h7zk3Vu0Sc6bZSUNrkhc=;
        b=lWbM5KIGAZl3IuKIZN3hJ5+Y+ih2TWg6Ge2PObUHom6jJcI29krP2yXeWNdlmZ622t
         IHhqfgslHIBEs5VNd1o4F43ZaRFpyHkhEZv/ev8eXVHOn1ntYxQGkPE/poC5f+RBMKED
         YZfomg0yes5qOOg69F8d6t8iUsgs0iSCqXasXknp5SRhVjKq5YMqnKEEZ/vmV26XKXa0
         94a60xjvxvq839UYmmt/A2nY8fHMtoln824V7tjCZSDPVOvg7Ic+hmkaLGapKVa5QGwi
         8hxJCPtoUS/bkznDoUK+nYovVXnguLU2gYewHZ0ZeiMkaKC6ZhE0qqMH2l7F9bHWT/Fz
         b1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764249499; x=1764854299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pOxQNhJxm0xD0VRBn/GmRc0h7zk3Vu0Sc6bZSUNrkhc=;
        b=YvrHg0P3L5R//C2Nj9Va2UjKm0U4//K7A2kOzgcGhrRSPPtLXqIjRO7gLdowZHncbt
         41hK+NxcebyVKeuAKC6/3PEVlXLfxbtO3RxuFTwOg2LU87SmUOidXAQyqt7KGKBsDmWB
         IRzXOZdAiairnXXT+lJ2Zof1mDvy5tXGygXmpaIOHfNmZ+ORA8/wEk5MGG5RVnmCpdbR
         1DwHpJJJFvTIu0S5EcDlwY26vFioGPZIOARcgEhmePQdDSR9SBCGwMCE5SBTyZExKYJG
         jfkBpazDMJfL5MKWhU1Vtgx8/2bm/x0aLFNJp2SJ/PlFK0c1ojL2U1JxwKZa/odusilE
         qWUA==
X-Forwarded-Encrypted: i=1; AJvYcCVvOmOb/AvBgpV7sgTsCLOKjuc5lIe/PIv855QzHK042e+EahNg/Tcj+TCOPExrDm1Pu+joMmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBl5L1hnf54SArIqw+tK9A40CNkNVWoeWBelNGHrexQwZwZh3C
	1QyuGs2mYRbjpRCIuKVxfLjD2Yp4rO6nEyBcctYrEud4gw5db8a7rO4aP/PkvEXrxYjXXGCKivV
	N1IG5sVGOCQDdFd36edRMJuhosHliRMbdxb1FhhiZ
X-Gm-Gg: ASbGncu2wXkA385M6e54MNk+cgqaD4wUUL52J3qaqM6cGgPw/ya7387sb1y4JwXqRHa
	yIuh4Y1udlpprFnKw//SEqZzGPrNYC39/cToc3HEQYJo7Dp/KTHAIdobU5Ay0hit4ErB2Q3G/On
	U3AbAlV9S5+UbBewjEuTjt/KRO892QY3Jj68sBlwJsqk7VGA4Z3hrhfEUJZk3XC/GMgq4uqnda1
	WyQl/w0A5s6at/4HkBKfNHxAAW0ikuVfh+1WS0GIvmSNpTxiV1AlYPvHy3BJueUA6srXxw=
X-Google-Smtp-Source: AGHT+IGIQZiedtkwXSkodquJ0eB3Pxiuobgl32k+6+irOBO2xh1Rj1NnX2jaGW+g9EtkLMXFZWInyCr25VFvNlCEDnQ=
X-Received: by 2002:ac8:7fcf:0:b0:4ed:b82b:19a3 with SMTP id
 d75a77b69052e-4ee58833771mr322134821cf.32.1764249499130; Thu, 27 Nov 2025
 05:18:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127130607.579916-1-m.lobanov@rosa.ru>
In-Reply-To: <20251127130607.579916-1-m.lobanov@rosa.ru>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 27 Nov 2025 05:18:07 -0800
X-Gm-Features: AWmQ_blRap-YNcSlQTzcHXtlFB11vM3PX0BGXiNSnuF-tIlCmFE6qG6ami2XYQQ
Message-ID: <CANn89iJPqqUB=uh8nhhAtkD7H7n6o6E-dc6G1PnFpwy6FzyNtw@mail.gmail.com>
Subject: Re: [PATCH net-next v4] l2tp: fix double dst_release() on
 sk_dst_cache race
To: Mikhail Lobanov <m.lobanov@rosa.ru>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Bauer <mail@david-bauer.net>, 
	James Chapman <jchapman@katalix.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 5:06=E2=80=AFAM Mikhail Lobanov <m.lobanov@rosa.ru>=
 wrote:
>
> A reproducible rcuref - imbalanced put() warning is observed under
> IPv6 L2TP (pppol2tp) traffic with blackhole routes, indicating an
> imbalance in dst reference counting for routes cached in
> sk->sk_dst_cache and pointing to a subtle lifetime/synchronization
> issue between the helpers that validate and drop cached dst entries.
>
> rcuref - imbalanced put()
> WARNING: CPU: 0 PID: 899 at lib/rcuref.c:266 rcuref_put_slowpath+0x1ce/0x=
240 lib/rcuref.>
> Modules linked in:
> CPSocket connected tcp:127.0.0.1:48148,server=3Don <-> 127.0.0.1:33750
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian=
-1.16.3-2 04/01>
> RIP: 0010:rcuref_put_slowpath+0x1ce/0x240 lib/rcuref.c:266
>
> Call Trace:
>  <TASK>
>  __rcuref_put include/linux/rcuref.h:97 [inline]
>  rcuref_put include/linux/rcuref.h:153 [inline]
>  dst_release+0x291/0x310 net/core/dst.c:167
>  __sk_dst_check+0x2d4/0x350 net/core/sock.c:604
>  __inet6_csk_dst_check net/ipv6/inet6_connection_sock.c:76 [inline]
>  inet6_csk_route_socket+0x6ed/0x10c0 net/ipv6/inet6_connection_sock.c:104
>  inet6_csk_xmit+0x12f/0x740 net/ipv6/inet6_connection_sock.c:121
>  l2tp_xmit_queue net/l2tp/l2tp_core.c:1214 [inline]
>  l2tp_xmit_core net/l2tp/l2tp_core.c:1309 [inline]
>  l2tp_xmit_skb+0x1404/0x1910 net/l2tp/l2tp_core.c:1325
>  pppol2tp_sendmsg+0x3ca/0x550 net/l2tp/l2tp_ppp.c:302
>  sock_sendmsg_nosec net/socket.c:729 [inline]
>  __sock_sendmsg net/socket.c:744 [inline]
>  ____sys_sendmsg+0xab2/0xc70 net/socket.c:2609
>  ___sys_sendmsg+0x11d/0x1c0 net/socket.c:2663
>  __sys_sendmmsg+0x188/0x450 net/socket.c:2749
>  __do_sys_sendmmsg net/socket.c:2778 [inline]
>  __se_sys_sendmmsg net/socket.c:2775 [inline]
>  __x64_sys_sendmmsg+0x98/0x100 net/socket.c:2775
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0x64/0x140 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> RIP: 0033:0x7fe6960ec719
>  </TASK>
>
> The race occurs between the lockless UDPv6 transmit path
> (udpv6_sendmsg() -> sk_dst_check()) and the locked L2TP/pppol2tp
> transmit path (pppol2tp_sendmsg() -> l2tp_xmit_skb() ->
> ... -> inet6_csk_xmit() =E2=86=92 __sk_dst_check()), when both handle
> the same obsolete dst from sk->sk_dst_cache: the UDPv6 side takes
> an extra reference and atomically steals and releases the cached
> dst, while the L2TP side, using a stale cached pointer, still
> calls dst_release() on it, and together these updates produce
> an extra final dst_release() on that dst, triggering
> rcuref - imbalanced put().
>
> The Race Condition:
>
> Initial:
>   sk->sk_dst_cache =3D dst
>   ref(dst) =3D 1
>
> Thread 1: sk_dst_check()                Thread 2: __sk_dst_check()
> ------------------------               ----------------------------
> sk_dst_get(sk):
>   rcu_read_lock()
>   dst =3D rcu_dereference(sk->sk_dst_cache)
>   rcuref_get(dst) succeeds
>   rcu_read_unlock()
>   // ref =3D 2
>
>                                             dst =3D __sk_dst_get(sk)
>                                     // reads same dst from sk_dst_cache
>                                     // ref still =3D 2 (no extra get)
>
> [both see dst obsolete & check() =3D=3D NULL]
>
> sk_dst_reset(sk):
>   old =3D xchg(&sk->sk_dst_cache, NULL)
>     // old =3D dst
>   dst_release(old)
>     // drop cached ref
>     // ref: 2 -> 1
>
>                                   RCU_INIT_POINTER(sk->sk_dst_cache, NULL=
)
>                                   // cache already NULL after xchg
>                                             dst_release(dst)
>                                               // ref: 1 -> 0
>
>   dst_release(dst)
>   // tries to drop its own ref after final put
>   // rcuref_put_slowpath() -> "rcuref - imbalanced put()"
>
> Make L2TP=E2=80=99s IPv6 transmit path stop using inet6_csk_xmit()
> (and thus __sk_dst_check()) and instead open-code the same
> routing and transmit sequence using ip6_sk_dst_lookup_flow()
> and ip6_xmit(). The new code builds a flowi6 from the socket
> fields in the same way as inet6_csk_route_socket(), then calls
> ip6_sk_dst_lookup_flow(), which internally relies on the lockless
> sk_dst_check()/sk_dst_reset() pattern shared with UDPv6, and
> attaches the resulting dst to the skb before invoking ip6_xmit().
> This makes both the UDPv6 and L2TP IPv6 paths use the same
> dst-cache handling logic for a given socket and removes the
> possibility that sk_dst_check() and __sk_dst_check() concurrently
> drop the same cached dst and trigger the rcuref - imbalanced put()
> warning under concurrent traffic.
>
> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
>
> Fixes: b0270e91014d ("ipv4: add a sock pointer to ip_queue_xmit()")
> Signed-off-by: Mikhail Lobanov <m.lobanov@rosa.ru>
> ---
> v2: move fix to L2TP as suggested by Eric Dumazet.
> v3: dropped the lockless sk_dst_check() pre-validation
> and the extra sk_dst_get() reference; instead, under
> the socket lock, mirror __sk_dst_check()=E2=80=99s condition
> and invalidate the cached dst via sk_dst_reset(sk) so
> the cache-owned ref is released exactly once via the
> xchg-based helper.
> v4: switch L2TP IPv6 xmit to open-coded (using sk_dst_check())
> and test with tools/testing/selftests/net/l2tp.sh.
> https://lore.kernel.org/netdev/a601c049-0926-418b-aa54-31686eea0a78@redha=
t.com/T/#t
>
>  net/l2tp/l2tp_core.c | 48 ++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 44 insertions(+), 4 deletions(-)
>
> diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
> index 0710281dd95a..72a43cbd4569 100644
> --- a/net/l2tp/l2tp_core.c
> +++ b/net/l2tp/l2tp_core.c
> @@ -1206,15 +1206,55 @@ static int l2tp_build_l2tpv3_header(struct l2tp_s=
ession *session, void *buf)
>  static int l2tp_xmit_queue(struct l2tp_tunnel *tunnel, struct sk_buff *s=
kb, struct flowi *fl)
>  {
>         int err;
> +       struct sock *sk =3D tunnel->sock;
>
>         skb->ignore_df =3D 1;
>         skb_dst_drop(skb);
>  #if IS_ENABLED(CONFIG_IPV6)
> -       if (l2tp_sk_is_v6(tunnel->sock))
> -               err =3D inet6_csk_xmit(tunnel->sock, skb, NULL);
> -       else
> +       if (l2tp_sk_is_v6(sk)) {
> +               struct ipv6_pinfo *np =3D inet6_sk(sk);
> +               struct inet_sock *inet =3D inet_sk(sk);
> +               struct flowi6 fl6;
> +               struct dst_entry *dst;
> +               struct in6_addr *final_p, final;
> +               struct ipv6_txoptions *opt;
> +
> +               memset(&fl6, 0, sizeof(fl6));
> +               fl6.flowi6_proto =3D sk->sk_protocol;
> +               fl6.daddr        =3D sk->sk_v6_daddr;
> +               fl6.saddr        =3D np->saddr;
> +               fl6.flowlabel    =3D np->flow_label;
> +               IP6_ECN_flow_xmit(sk, fl6.flowlabel);
> +
> +               fl6.flowi6_oif   =3D sk->sk_bound_dev_if;
> +               fl6.flowi6_mark  =3D sk->sk_mark;
> +               fl6.fl6_sport    =3D inet->inet_sport;
> +               fl6.fl6_dport    =3D inet->inet_dport;
> +               fl6.flowi6_uid   =3D sk->sk_uid;

Please use sk_uid(sk)

> +
> +               security_sk_classify_flow(sk, flowi6_to_flowi_common(&fl6=
));
> +
> +               rcu_read_lock();
> +               opt =3D rcu_dereference(np->opt);
> +               final_p =3D fl6_update_dst(&fl6, opt, &final);
> +
> +               dst =3D ip6_sk_dst_lookup_flow(sk, &fl6, final_p, true);
> +               if (IS_ERR(dst)) {
> +                       rcu_read_unlock();
> +                       kfree_skb(skb);
> +                       return NET_XMIT_DROP;
> +               }
> +
> +               skb_dst_set(skb, dst);
> +               fl6.daddr =3D sk->sk_v6_daddr;
> +
> +               err =3D ip6_xmit(sk, skb, &fl6, sk->sk_mark,
> +                              opt, np->tclass,
> +                              READ_ONCE(sk->sk_priority));

It is a bit strange you have a READ_ONCE(sk->sk_priority) but no
READ_ONCE() on sk->sk_mark, sk->sk_bound_dev_if.

Please add them.

> +               rcu_read_unlock();
> +       } else
>  #endif
> -               err =3D ip_queue_xmit(tunnel->sock, skb, fl);
> +               err =3D ip_queue_xmit(sk, skb, fl);
>
>         return err >=3D 0 ? NET_XMIT_SUCCESS : NET_XMIT_DROP;
>  }
> --
> 2.47.2
>

