Return-Path: <netdev+bounces-187627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E25AA855E
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 11:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CC40189A66D
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 09:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0193E183098;
	Sun,  4 May 2025 09:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2Xkw/V53"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDFA2BAF8
	for <netdev@vger.kernel.org>; Sun,  4 May 2025 09:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746350187; cv=none; b=o4pJZTndAxy426HN80Xs7bCLWBdK/7HI0CpnbV92JFLQDI5hiQusKKKjK6F2c0FNl4MjMZewHZE5Xiv77ktFzA7+63ImKxVrr8gUjkWUXGrqJqFMmYA2nIb1JZaszWBORehjzXGiM+PLQ4nffcCEGpBAGuC8/8uInu63dwrQ32M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746350187; c=relaxed/simple;
	bh=aoOts0sC2xQvKwopWph/fard4PufYq766QYx8YGCLTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ngDEqd1uI+faEyY817RhQFTUsiGQn8L2UzKI8X9P1w1OiBvxc/4rxTeW8XFQ3pRK1sxpO3K+f31FdKLFQa9bTTaxy2fe1KxKGXQ4jwrhT5U/YUBpnUBmgtulMVGX+vpkfDKWN8Ye0uQwxvms3hiZFNYyups/fgOHCXh4yCL2sGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2Xkw/V53; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4766cb762b6so41296581cf.0
        for <netdev@vger.kernel.org>; Sun, 04 May 2025 02:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746350184; x=1746954984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=62y0LZ3Q9k2qzrgdo0KuOivTwma15+lapowFW688y7U=;
        b=2Xkw/V53wukrP21LhVNXaIZ6W/5hL0lUDAbh5ieJCbYr/NsDtG6dsXISpkYVnhhnm8
         dTquiTk1iBf8pdu1YyaXMxLnQ3D1x716iL9iYnt6sUewHrtxbOtPeIZanRSRfmZinlNT
         58pRmv5TmNZP600QUiszjezclLzNn31g0xc0fxvj55m0dNFxk3HSzS5zhMsDeK4soPhC
         7eGDZZuMK2BxVtXc4q8ZSX9rXNnvRzBNe5cNvGUGQGzMezBCm3E8HhEzc7wyXkuH9+04
         rw76oHc7ANWUp7gI8b5gd3YFBeZ9TRXmmWQJV5DB2gdPS1R5nxKivAS31cU3MIbsHQo+
         Qy2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746350184; x=1746954984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=62y0LZ3Q9k2qzrgdo0KuOivTwma15+lapowFW688y7U=;
        b=Lk24P/4yRr4wL2th9LYpFdPfGsKZAzJthwHa8YawHch0ErBqWTB6sgfvb/LTolJIKj
         RaEyEkaSyUHXyE+KmtY6Ul9aE76nABU8YxMZlX96elDxTD4krABYhcCn3Qy2vNlNus1X
         lbtJDh9YXC8TZ5dDQWKNIpoATllaDSV/oPSAnwvyw+6JV+pRkx+KVx2LfPBxWBoUQEpA
         HBuNdPLamRw7AYtfs4zgLTMgZ4RPdag7rCZZgkGrfj5x+6cNYqNBaIkx7uYbjS39S96l
         0Ra3CnQZoPl+LI6owcyxAJA45CCRMpHbU/G5P2vsD8RUn2Ys/XrFvY0On22vnv9LIzos
         rTHA==
X-Forwarded-Encrypted: i=1; AJvYcCVS9b/vfK714obxD/lRwiu8Xky2WFrLSrB7xmymZMva4HxwqZmXbikab9yNxRHRedg6/E8cj28=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmIDm8DQkbeDGIKcWxfCTdM+/MT2AAkI11M2qESUiClethlOgP
	7KI5UcBMtBJMmMEVsVTF2hf+9xNFgxeKH1bNvbmSgEYt4SfiFnhKfg2y9E6+fVo2WLU42PMHib6
	PClQbMq+TOFYLCBPMugQIURYQTwb7KyGNM2Vi
X-Gm-Gg: ASbGncsMvZMwj/XgV1PcmYkACTkfsvJ45A24ZB1SEqHebSMixt0oxyOged9qbWyTT5J
	tmXK3zJ5gXxlnQNLj4FYP0ACXBwkRezl2yslfcr8LuE1BmUVzaCFMlYGM/eJJN7kZ+FuywslwOZ
	Maota77qpo+Qv6T7HAs2K0X+E=
X-Google-Smtp-Source: AGHT+IEwqNgJxKe6Yd0El8IFg9VB77Mi2t7FezkU2x8BKKP1X/KLLLY4tuM6nSxs594Yrl6xxkFcapqwhJOuud/4bH8=
X-Received: by 2002:a05:622a:1487:b0:48e:9b67:d52a with SMTP id
 d75a77b69052e-48e9b67d639mr21402981cf.24.1746350184195; Sun, 04 May 2025
 02:16:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418000443.43734-1-kuniyu@amazon.com> <20250418000443.43734-16-kuniyu@amazon.com>
In-Reply-To: <20250418000443.43734-16-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 4 May 2025 02:16:13 -0700
X-Gm-Features: ATxdqUH0U6sOn1bGAaTj7CvD1NYvzPR2t_5IEsuSt31NS67TtrtN-TiJs3oOM-Y
Message-ID: <CANn89i+r1cGacVC_6n3-A-WSkAa_Nr+pmxJ7Gt+oP-P9by2aGw@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 15/15] ipv6: Get rid of RTNL for SIOCADDRT and RTM_NEWROUTE.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 5:10=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> Now we are ready to remove RTNL from SIOCADDRT and RTM_NEWROUTE.
>
> The remaining things to do are
>
>   1. pass false to lwtunnel_valid_encap_type_attr()
>   2. use rcu_dereference_rtnl() in fib6_check_nexthop()
>   3. place rcu_read_lock() before ip6_route_info_create_nh().
>
> Let's complete the RTNL-free conversion.
>
> When each CPU-X adds 100000 routes on table-X in a batch
> concurrently on c7a.metal-48xl EC2 instance with 192 CPUs,
>
> without this series:
>
>   $ sudo ./route_test.sh
>   ...
>   added 19200000 routes (100000 routes * 192 tables).
>   time elapsed: 191577 milliseconds.
>
> with this series:
>
>   $ sudo ./route_test.sh
>   ...
>   added 19200000 routes (100000 routes * 192 tables).
>   time elapsed: 62854 milliseconds.
>
> I changed the number of routes in each table (1000 ~ 100000)
> and consistently saw it finish 3x faster with this series.
>
> Note that now every caller of lwtunnel_valid_encap_type() passes
> false as the last argument, and this can be removed later.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  net/ipv4/nexthop.c |  4 ++--
>  net/ipv6/route.c   | 18 ++++++++++++------
>  2 files changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
> index 6ba6cb1340c1..823e4a783d2b 100644
> --- a/net/ipv4/nexthop.c
> +++ b/net/ipv4/nexthop.c
> @@ -1556,12 +1556,12 @@ int fib6_check_nexthop(struct nexthop *nh, struct=
 fib6_config *cfg,
>         if (nh->is_group) {
>                 struct nh_group *nhg;
>
> -               nhg =3D rtnl_dereference(nh->nh_grp);
> +               nhg =3D rcu_dereference_rtnl(nh->nh_grp);

Or add a condition about table lock being held ?

>                 if (nhg->has_v4)
>                         goto no_v4_nh;
>                 is_fdb_nh =3D nhg->fdb_nh;
>         } else {
> -               nhi =3D rtnl_dereference(nh->nh_info);
> +               nhi =3D rcu_dereference_rtnl(nh->nh_info);
>                 if (nhi->family =3D=3D AF_INET)
>                         goto no_v4_nh;
>                 is_fdb_nh =3D nhi->fdb_nh;
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index c8c1c75268e3..bb46e724db73 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -3902,12 +3902,16 @@ int ip6_route_add(struct fib6_config *cfg, gfp_t =
gfp_flags,
>         if (IS_ERR(rt))
>                 return PTR_ERR(rt);
>
> +       rcu_read_lock();

This looks bogus to me (and syzbot)

Holding rcu_read_lock() from writers is almost always wrong.

In this case, this prevents any GFP_KERNEL allocations to happen
(among other things)

[ BUG: Invalid wait context ]
6.15.0-rc4-syzkaller-00746-g836b313a14a3 #0 Tainted: G W
-----------------------------
syz-executor234/5832 is trying to lock:
ffffffff8e021688 (pcpu_alloc_mutex){+.+.}-{4:4}, at:
pcpu_alloc_noprof+0x284/0x16b0 mm/percpu.c:1782
other info that might help us debug this:
context-{5:5}
1 lock held by syz-executor234/5832:
#0: ffffffff8df3b860 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire
include/linux/rcupdate.h:331 [inline]
#0: ffffffff8df3b860 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock
include/linux/rcupdate.h:841 [inline]
#0: ffffffff8df3b860 (rcu_read_lock){....}-{1:3}, at:
ip6_route_add+0x4d/0x2f0 net/ipv6/route.c:3913
stack backtrace:
CPU: 0 UID: 0 PID: 5832 Comm: syz-executor234 Tainted: G W
6.15.0-rc4-syzkaller-00746-g836b313a14a3 #0 PREEMPT(full)
Tainted: [W]=3DWARN
Hardware name: Google Google Compute Engine/Google Compute Engine,
BIOS Google 04/29/2025
Call Trace:
<TASK>
dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
print_lock_invalid_wait_context kernel/locking/lockdep.c:4831 [inline]
check_wait_context kernel/locking/lockdep.c:4903 [inline]
__lock_acquire+0xbcf/0xd20 kernel/locking/lockdep.c:5185
lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5866
__mutex_lock_common kernel/locking/mutex.c:601 [inline]
__mutex_lock+0x182/0xe80 kernel/locking/mutex.c:746
pcpu_alloc_noprof+0x284/0x16b0 mm/percpu.c:1782
dst_cache_init+0x37/0xc0 net/core/dst_cache.c:145
ip_tun_build_state+0x193/0x6b0 net/ipv4/ip_tunnel_core.c:687
lwtunnel_build_state+0x381/0x4c0 net/core/lwtunnel.c:137
fib_nh_common_init+0x129/0x460 net/ipv4/fib_semantics.c:635
fib6_nh_init+0x15e4/0x2030 net/ipv6/route.c:3669
ip6_route_info_create_nh+0x139/0x870 net/ipv6/route.c:3866
ip6_route_add+0xf6/0x2f0 net/ipv6/route.c:3915
inet6_rtm_newroute+0x284/0x1c50 net/ipv6/route.c:5732
rtnetlink_rcv_msg+0x7cc/0xb70 net/core/rtnetlink.c:6955
netlink_rcv_skb+0x219/0x490 net/netlink/af_netlink.c:2534
netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
netlink_unicast+0x758/0x8d0 net/netlink/af_netlink.c:1339
netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1883
sock_sendmsg_nosec net/socket.c:712 [inline]
__sock_sendmsg+0x219/0x270 net/socket.c:727
____sys_sendmsg+0x505/0x830 net/socket.c:2566
___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
__sys_sendmsg net/socket.c:2652 [inline]
__do_sys_sendmsg net/socket.c:2657 [inline]
__se_sys_sendmsg net/socket.c:2655 [inline]
__x64_sys_sendmsg+0x19b/0x260 net/socket.c:2655
do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94

