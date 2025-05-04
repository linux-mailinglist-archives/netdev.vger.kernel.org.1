Return-Path: <netdev+bounces-187644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2964AA886D
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 19:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D9F2175B8A
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 17:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525911EBA08;
	Sun,  4 May 2025 17:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Kvdv+AHA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767A31E5B9A
	for <netdev@vger.kernel.org>; Sun,  4 May 2025 17:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746379340; cv=none; b=fS+PSmjhWW34a0SnetoQxOWdpy7Jxgt0H7wMNPtcJlWBtMA6V9VPvBteFEpKjDLpcfDPQ+YMO1iB1hDCSeDeXZnHzUjZj/APozsYvb9tG33dQEDHCROHYJZVztLlaQg6vG1WodQFV0PUabTsnvTEGeho7MjhzXJCwcioDAgxEmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746379340; c=relaxed/simple;
	bh=w8xYAL4O7WSJDQlXqBUhYmX0qnXvCI/4YMOQDYuadHE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n1ULUcj422t9OB9BQiergbbbnkozj2PtARZoWnbCi4BrWpVk/U8kSgcxdGQVtidVavJS4bg26xqTAVOjyRQ160BSLH8ZinrV2pU/yeUng6Kj+mC9bjdZMgFcZhtb01LJSOrZD5d4UqQjnqLeJPcDqMw0Ho1tH4OJvIWtgH46zXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Kvdv+AHA; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1746379339; x=1777915339;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dlx77w/sdFMhcuYO3w82ycYHNJPApN9IbwvnsyNFaTI=;
  b=Kvdv+AHAYzVP7m/04a8AmOqtO+Dq0UuPA4QRObSHmPwQyfrOaiL60Vag
   +FpI4QnJT5epyw4QV9A6ibKkI/LWU3oC62X43MerHfktM8ajKfnab6sV4
   f83Ghfa0ve9XezCMjffEy5E4BuXMVrHCmWj76sZSmL35ENdQiA2NnW5la
   U=;
X-IronPort-AV: E=Sophos;i="6.15,262,1739836800"; 
   d="scan'208";a="517302254"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2025 17:22:12 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:44358]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.38.92:2525] with esmtp (Farcaster)
 id 3a02330a-54ac-4480-8cea-a9a3c4683eb9; Sun, 4 May 2025 17:22:11 +0000 (UTC)
X-Farcaster-Flow-ID: 3a02330a-54ac-4480-8cea-a9a3c4683eb9
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sun, 4 May 2025 17:22:11 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.38) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sun, 4 May 2025 17:22:08 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v3 net-next 15/15] ipv6: Get rid of RTNL for SIOCADDRT and RTM_NEWROUTE.
Date: Sun, 4 May 2025 10:20:48 -0700
Message-ID: <20250504172159.7358-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <CANn89i+r1cGacVC_6n3-A-WSkAa_Nr+pmxJ7Gt+oP-P9by2aGw@mail.gmail.com>
References: <CANn89i+r1cGacVC_6n3-A-WSkAa_Nr+pmxJ7Gt+oP-P9by2aGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D035UWA004.ant.amazon.com (10.13.139.109) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Sun, 4 May 2025 02:16:13 -0700
> On Thu, Apr 17, 2025 at 5:10 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > Now we are ready to remove RTNL from SIOCADDRT and RTM_NEWROUTE.
> >
> > The remaining things to do are
> >
> >   1. pass false to lwtunnel_valid_encap_type_attr()
> >   2. use rcu_dereference_rtnl() in fib6_check_nexthop()
> >   3. place rcu_read_lock() before ip6_route_info_create_nh().
> >
> > Let's complete the RTNL-free conversion.
> >
> > When each CPU-X adds 100000 routes on table-X in a batch
> > concurrently on c7a.metal-48xl EC2 instance with 192 CPUs,
> >
> > without this series:
> >
> >   $ sudo ./route_test.sh
> >   ...
> >   added 19200000 routes (100000 routes * 192 tables).
> >   time elapsed: 191577 milliseconds.
> >
> > with this series:
> >
> >   $ sudo ./route_test.sh
> >   ...
> >   added 19200000 routes (100000 routes * 192 tables).
> >   time elapsed: 62854 milliseconds.
> >
> > I changed the number of routes in each table (1000 ~ 100000)
> > and consistently saw it finish 3x faster with this series.
> >
> > Note that now every caller of lwtunnel_valid_encap_type() passes
> > false as the last argument, and this can be removed later.
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> >  net/ipv4/nexthop.c |  4 ++--
> >  net/ipv6/route.c   | 18 ++++++++++++------
> >  2 files changed, 14 insertions(+), 8 deletions(-)
> >
> > diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
> > index 6ba6cb1340c1..823e4a783d2b 100644
> > --- a/net/ipv4/nexthop.c
> > +++ b/net/ipv4/nexthop.c
> > @@ -1556,12 +1556,12 @@ int fib6_check_nexthop(struct nexthop *nh, struct fib6_config *cfg,
> >         if (nh->is_group) {
> >                 struct nh_group *nhg;
> >
> > -               nhg = rtnl_dereference(nh->nh_grp);
> > +               nhg = rcu_dereference_rtnl(nh->nh_grp);
> 
> Or add a condition about table lock being held ?

I think in this context the caller is more of an rcu reader
than a ipv6 route writer.



> 
> >                 if (nhg->has_v4)
> >                         goto no_v4_nh;
> >                 is_fdb_nh = nhg->fdb_nh;
> >         } else {
> > -               nhi = rtnl_dereference(nh->nh_info);
> > +               nhi = rcu_dereference_rtnl(nh->nh_info);
> >                 if (nhi->family == AF_INET)
> >                         goto no_v4_nh;
> >                 is_fdb_nh = nhi->fdb_nh;
> > diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> > index c8c1c75268e3..bb46e724db73 100644
> > --- a/net/ipv6/route.c
> > +++ b/net/ipv6/route.c
> > @@ -3902,12 +3902,16 @@ int ip6_route_add(struct fib6_config *cfg, gfp_t gfp_flags,
> >         if (IS_ERR(rt))
> >                 return PTR_ERR(rt);
> >
> > +       rcu_read_lock();
> 
> This looks bogus to me (and syzbot)
> 
> Holding rcu_read_lock() from writers is almost always wrong.

Yes, but I added it as a reader of netdev and nexthop to guarantee
that they won't go away.


> 
> In this case, this prevents any GFP_KERNEL allocations to happen
> (among other things)

Oh, I completely missed this path, thanks!

Fortunately, it seems all ->build_state() except for
ip_tun_build_state() use GFP_ATOMIC.

So, simply changing GFP_KERNEL to GFP_ATOMIC is acceptable ?


lwtunnel_state_alloc
  - kzalloc(GFP_ATOMIC)

ip_tun_build_state
  - dst_cache_init(GFP_KERNEL)

ip6_tun_build_state / mpls_build_state / xfrmi_build_state
-> no alloc other than lwtunnel_state_alloc()

bpf_build_state
  - bpf_parse_prog
    - nla_memdup(GFP_ATOMIC)

ila_build_state / ioam6_build_state / rpl_build_state / seg6_build_state
  - dst_cache_init(GFP_ATOMIC)

seg6_local_build_state
  - seg6_end_dt4_build / seg6_end_dt6_build / seg6_end_dt46_build
    -> no alloc other than lwtunnel_state_alloc()


> 
> [ BUG: Invalid wait context ]
> 6.15.0-rc4-syzkaller-00746-g836b313a14a3 #0 Tainted: G W
> -----------------------------
> syz-executor234/5832 is trying to lock:
> ffffffff8e021688 (pcpu_alloc_mutex){+.+.}-{4:4}, at:
> pcpu_alloc_noprof+0x284/0x16b0 mm/percpu.c:1782
> other info that might help us debug this:
> context-{5:5}
> 1 lock held by syz-executor234/5832:
> #0: ffffffff8df3b860 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire
> include/linux/rcupdate.h:331 [inline]
> #0: ffffffff8df3b860 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock
> include/linux/rcupdate.h:841 [inline]
> #0: ffffffff8df3b860 (rcu_read_lock){....}-{1:3}, at:
> ip6_route_add+0x4d/0x2f0 net/ipv6/route.c:3913
> stack backtrace:
> CPU: 0 UID: 0 PID: 5832 Comm: syz-executor234 Tainted: G W
> 6.15.0-rc4-syzkaller-00746-g836b313a14a3 #0 PREEMPT(full)
> Tainted: [W]=WARN
> Hardware name: Google Google Compute Engine/Google Compute Engine,
> BIOS Google 04/29/2025
> Call Trace:
> <TASK>
> dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
> print_lock_invalid_wait_context kernel/locking/lockdep.c:4831 [inline]
> check_wait_context kernel/locking/lockdep.c:4903 [inline]
> __lock_acquire+0xbcf/0xd20 kernel/locking/lockdep.c:5185
> lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5866
> __mutex_lock_common kernel/locking/mutex.c:601 [inline]
> __mutex_lock+0x182/0xe80 kernel/locking/mutex.c:746
> pcpu_alloc_noprof+0x284/0x16b0 mm/percpu.c:1782
> dst_cache_init+0x37/0xc0 net/core/dst_cache.c:145
> ip_tun_build_state+0x193/0x6b0 net/ipv4/ip_tunnel_core.c:687
> lwtunnel_build_state+0x381/0x4c0 net/core/lwtunnel.c:137
> fib_nh_common_init+0x129/0x460 net/ipv4/fib_semantics.c:635
> fib6_nh_init+0x15e4/0x2030 net/ipv6/route.c:3669
> ip6_route_info_create_nh+0x139/0x870 net/ipv6/route.c:3866
> ip6_route_add+0xf6/0x2f0 net/ipv6/route.c:3915
> inet6_rtm_newroute+0x284/0x1c50 net/ipv6/route.c:5732
> rtnetlink_rcv_msg+0x7cc/0xb70 net/core/rtnetlink.c:6955
> netlink_rcv_skb+0x219/0x490 net/netlink/af_netlink.c:2534
> netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
> netlink_unicast+0x758/0x8d0 net/netlink/af_netlink.c:1339
> netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1883
> sock_sendmsg_nosec net/socket.c:712 [inline]
> __sock_sendmsg+0x219/0x270 net/socket.c:727
> ____sys_sendmsg+0x505/0x830 net/socket.c:2566
> ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
> __sys_sendmsg net/socket.c:2652 [inline]
> __do_sys_sendmsg net/socket.c:2657 [inline]
> __se_sys_sendmsg net/socket.c:2655 [inline]
> __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2655
> do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94

