Return-Path: <netdev+bounces-237998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D75C52884
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 14:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C30E2189F8DE
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 13:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABA5338918;
	Wed, 12 Nov 2025 13:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vPdtkqSz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5F933556A
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 13:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762954984; cv=none; b=YzpnkYWOQCKSV6lCGlHCxpfx7QXpWmXUo8QGY266GqkbJnl7/JcSHsFHG93KppPcJ8RAqBmFIlQyXf5GSKWAZ/1Gdy0YoHNt+i7EWicKzBJSRts6q5Lm0WU1ee+UsjvaOafqraTxZXM0n9mp8ONMhOAu5onpioPy/Xt62WwFuw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762954984; c=relaxed/simple;
	bh=YbNjBmLeDztRBjSLMAR5mFqC7dnHwSe4jcl96qKEfv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W63Jo+FeaBBXbqJZaBeRdi9X9CZzTZ5GBib9ShDZNPsMn2U+ntYas6ySG9XFy4UUsXlZXup6cK0XhDHMo+ZbAoH1mBNn215JWwoQ9uDPcjUCA2G6KeO7WzAIeJKzuCcTV7h8YcbSKpcQ34d/gGNJe9LQlWw+kmXJdK7onB5T9T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vPdtkqSz; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4eda77e2358so7069271cf.1
        for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 05:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762954980; x=1763559780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=totqEFwJGILm4yNDXgBaeue7zbrbrbW6OMu6We6QgFU=;
        b=vPdtkqSzI8Or/tpLcJUWOK8QTWS3jZrdwPcGjizFvtGKRfCZ9N4QMzPQlqQcXlD2xx
         HNLchHH2EVJVo2e8w23NA+pDu5zkq5r/L5zZVMhQDNM3b4xsLErdJZyJl8ZdF9nm5AiM
         6OHptXbcPsyLuXXs8w3ld3XH0aL08xigxVC6M0HPpVkGyfqgYjDZxeDUh5GpnAqU51W3
         XgqqdDfq88kC+knr3DyKBDcVXPvmbrX1h0k/RAhbYj7f+OeHsADkAg70crsIscyvhBLv
         zW2f8Q2dkYz+LpqzvCsjmJv6sw0UidT8Gnaw/b88HcrJb2WqhaUxoiOnIVQT9V/AH1sT
         V4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762954980; x=1763559780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=totqEFwJGILm4yNDXgBaeue7zbrbrbW6OMu6We6QgFU=;
        b=p54hSWAD7YA0VYYfLUMfUT8fSwl+KcZcCU8jYBG5TUbdWxA9r9Uimbr4+0aColTKHM
         rFn26lxgeLg5lDgPjY/KVbqyivBZ0fNKEAyTrybi9VJFc9v3FKdXN1EGYnLt9+gT5m5r
         Lq4/cordwLL6aRKhMR5d+JrkBM7oE/j0c/o7hT2RyBK4CNuceiEdjrG8lTeDP8zFQ+zU
         D/8MT05FqC9Fu49XUXI8hrEx8B9+wvFXleDJZff0lskySQOFa+1qv2c1UAf5BIKRQ4So
         /F4kU12x9O6aAP2/n+pEQ/2vKQU5ruoP3h3sf/YPAmLzKdS/JnkdQRN89SyUYeRw5QUx
         qjHg==
X-Forwarded-Encrypted: i=1; AJvYcCUJZWTqMUZ8DoGvpJo7yDAynxC3UeWyI11cbwncFJVk1xGJrZvDiZvaDciZ0z8vW5xpOpQke58=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4odZqJz66Q3jba7S2sZg+hhoqzNkbT+g1xXfMabr/ZaskYiM+
	KIbJvoS3nJyWutnbWh9DfuoBEmKbX497SMiDDHjUh0Zbl4t3bXTOQfSiG3sW+rdNHjpfU1XzUNl
	IYzpbW3DT9q299OHtSpZ0LoKx61oiEosv2wpvV80t
X-Gm-Gg: ASbGncu7BJVkcwP3/M3kScQVMogcVUOvSrhkMl0XrqrkyiaUj7K99dKJfB5BzuyIkDF
	SwmoGwGx5rJkexRDrI4zv7VDz880yMQ/ofIjNJwoq67b3IjV/mOhll3gBJRDtvn+VCn8xFtCziF
	va7u2tvA5xnarA8eknvderjiygfyTrlBrNb4h9vRn3shdtFaw/FTbVLFzbuLfnhscfRYZnGP4sj
	BV6KOosRsLER0bke4jQ4qipxXsBS99WEBW79U1XCVr34QyATvjjv2gd3zgk8A2SSsa8NEu5Hh7+
	P/3RAP8=
X-Google-Smtp-Source: AGHT+IE/ryyuZUHWgaoRdvK85nLrC2c6GEij1NJeVdVfLC40QeF9fvn1igeYC6O6FIq3KMHL7HG0Dfa+fq/TfkzOgFE=
X-Received: by 2002:a05:622a:201:b0:4eb:a1a1:7c0b with SMTP id
 d75a77b69052e-4eddbddb4c4mr33252871cf.78.1762954979833; Wed, 12 Nov 2025
 05:42:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112132514.17364-1-m.lobanov@rosa.ru>
In-Reply-To: <20251112132514.17364-1-m.lobanov@rosa.ru>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 12 Nov 2025 05:42:48 -0800
X-Gm-Features: AWmQ_blW6Kq_leNStGIHF6DF9pln_OBwDouDdrpHj72wVff9GaTWO3A9lX8KCas
Message-ID: <CANn89iLapT==AAgNqnzAy-pYZySD3YSSmjGOpPt3mnKs0Zk2Mw@mail.gmail.com>
Subject: Re: [PATCH net v2] l2tp: fix double dst_release() on sk_dst_cache race
To: Mikhail Lobanov <m.lobanov@rosa.ru>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	James Chapman <jchapman@katalix.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 5:25=E2=80=AFAM Mikhail Lobanov <m.lobanov@rosa.ru>=
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
240 lib/rcuref.c:266
> Modules linked in:
> CPSocket connected tcp:127.0.0.1:48148,server=3Don <-> 127.0.0.1:33750
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian=
-1.16.3-2 04/01/2014
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
> The fix is applied locally in L2TP=E2=80=99s IPv6 transmit path before ca=
lling
> inet6_csk_xmit(). First, it performs a lockless pre-validation of the
> socket route cache via sk_dst_check(), so that any obsolete cached dst
> is atomically removed from sk->sk_dst_cache by the lockless helper
> (through its xchg() path); this prevents the locked __sk_dst_check()
> inside inet6_csk_xmit() from issuing a second dst_release() on the same
> cache-owned reference. Second, it takes an additional reference to the
> current cached dst with sk_dst_get() and drops it after inet6_csk_xmit()
> returns, ensuring the dst lifetime is guarded while L2TP transmits, even
> if the cache is concurrently updated. Together these steps eliminate the
> double-release race without changing sock-core semantics.
>
> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
>
> Fixes: d14730b8e911 ("ipv6: use RCU in inet6_csk_xmit()")

This is a wrong Fixes tag. This commit had nothing to do with l2tp.

> Signed-off-by: Mikhail Lobanov <m.lobanov@rosa.ru>
> ---
> v2: move fix to L2TP as suggested by Eric Dumazet.
>
>  net/l2tp/l2tp_core.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
> index 369a2f2e459c..93dafac9117f 100644
> --- a/net/l2tp/l2tp_core.c
> +++ b/net/l2tp/l2tp_core.c
> @@ -1210,9 +1210,17 @@ static int l2tp_xmit_queue(struct l2tp_tunnel *tun=
nel, struct sk_buff *skb, stru
>         skb->ignore_df =3D 1;
>         skb_dst_drop(skb);
>  #if IS_ENABLED(CONFIG_IPV6)
> -       if (l2tp_sk_is_v6(tunnel->sock))
> +       if (l2tp_sk_is_v6(tunnel->sock)) {
> +               struct dst_entry *pre_dst, *hold_dst;
> +
> +               pre_dst =3D sk_dst_check(tunnel->sock, 0);
> +               if (pre_dst)
> +                       dst_release(pre_dst);

This is not a fix, just adding other races.

I would suggest you wait 24 hours before sending a new version, as
instructed in:

Documentation/process/maintainer-netdev.rst

