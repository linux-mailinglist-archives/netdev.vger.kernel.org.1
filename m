Return-Path: <netdev+bounces-190534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 172B6AB76F7
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 22:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94D8D17FAE1
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 20:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A81297132;
	Wed, 14 May 2025 20:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="MSQxLDw/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9683529672E
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 20:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747254073; cv=none; b=HR959CboVvRcUQQEYs53jdtPekRv1wwImJOVn+iHxaSq/Bn9hSs04soFJ73xSh1So/2Vvdieq1tXuAJRoMRIxPdYkDnpUSFvlbN8d99nBZaf7F5hxJMs+N86Pxi/llT/U0BJiujjZ2Kn8+Lhi/htU0Vqe0Mb+SbMHZ/w3ehapmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747254073; c=relaxed/simple;
	bh=TYU/98FvAD5Je949Nl8wCPpei4+Sn8jLiBieSRGq8To=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qC2+ehuFB8NfVP7efjhyyVixoyILxrEPLZJ/7He4s6QGBiHyeJqhj6vrl7VFESnOvEt563U6Q8Ud3PJ+zxtIBtV+QYxOPO2sLiU5Twk2UNzPyPvq886dvQEgnaX5B4Q9nbSj+6Mm2PP4Ntads1wCiBbAOUrZynWzvO4mAVq7rLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=MSQxLDw/; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747254072; x=1778790072;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1vMSRzEOQvVekQHm0r5JUQWBA+sMsD3a/GsWrp79Ohg=;
  b=MSQxLDw/0QqaLQXvm/GFgMGKsbRo3GDzFVNW8AlMmQnxZElnK+6aa1SV
   aaf6LAE5iTgDgKzzEqNemE6d8tnDjbJlEcNFJFDoCCdJT40h1bFj91j9G
   QIqqHV24SRzxdXD91UFQMY/A3sDbSn6XcqXB7kPNcZLwZLwKrf/CDH8+E
   VTnqKujh/JjoeUa7xSS8Mldeiq80E8Eh23MGrhKI/OzWmR0GWU7A50H/Z
   CRn5/NTuZf7BCClrT72+vbttrndPFkXgBGnjveeQMH/fQH/VWlviEBfv4
   gv2aSWkS8XGewl7bKMmXm6Uhdfsr8QderePQPR2lHJ8pgxghdNNi3mqDO
   w==;
X-IronPort-AV: E=Sophos;i="6.15,289,1739836800"; 
   d="scan'208";a="405316092"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 20:21:09 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:26130]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.61.52:2525] with esmtp (Farcaster)
 id 69cf36ec-3a8e-4940-a434-f459ddfb5e47; Wed, 14 May 2025 20:21:08 +0000 (UTC)
X-Farcaster-Flow-ID: 69cf36ec-3a8e-4940-a434-f459ddfb5e47
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 14 May 2025 20:21:07 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.171.38) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 14 May 2025 20:21:05 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>,
	<syzbot+bcc12d6799364500fbec@syzkaller.appspotmail.com>
Subject: [PATCH v1 net-next 3/7] ipv6: Narrow down RCU critical section in inet6_rtm_newroute().
Date: Wed, 14 May 2025 13:18:56 -0700
Message-ID: <20250514201943.74456-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514201943.74456-1-kuniyu@amazon.com>
References: <20250514201943.74456-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA003.ant.amazon.com (10.13.139.46) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Commit 169fd62799e8 ("ipv6: Get rid of RTNL for SIOCADDRT and
RTM_NEWROUTE.") added rcu_read_lock() covering
ip6_route_info_create_nh() and __ip6_ins_rt() to guarantee that
nexthop and netdev will not go away.

However, as reported by syzkaller [0], ip_tun_build_state() calls
dst_cache_init() with GFP_KERNEL during the RCU critical section.

ip6_route_info_create_nh() fetches nexthop or netdev depending on
whether RTA_NH_ID is set, and struct fib6_info holds a refcount
of either of them by nexthop_get() or netdev_get_by_index().

netdev_get_by_index() looks up a dev and calls dev_hold() under RCU.

So, we need RCU only around nexthop_find_by_id() and nexthop_get()
( and a few more nexthop code).

Let's add rcu_read_lock() there and remove rcu_read_lock() in
ip6_route_add() and ip6_route_multipath_add().

Now these functions called from fib6_add() need RCU:

  - inet6_rt_notify()
  - fib6_drop_pcpu_from() (via fib6_purge_rt())
  - rt6_flush_exceptions() (via fib6_purge_rt())

All callers of inet6_rt_notify() need RCU, so rcu_read_lock() is
added there.

[0]:
[ BUG: Invalid wait context ]
6.15.0-rc4-syzkaller-00746-g836b313a14a3 #0 Tainted: G W
syz-executor234/5832 is trying to lock:
ffffffff8e021688 (pcpu_alloc_mutex){+.+.}-{4:4}, at:
pcpu_alloc_noprof+0x284/0x16b0 mm/percpu.c:1782
other info that might help us debug this:
context-{5:5}
1 lock held by syz-executor234/5832:
 0: ffffffff8df3b860 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire
include/linux/rcupdate.h:331 [inline]
 0: ffffffff8df3b860 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock
include/linux/rcupdate.h:841 [inline]
 0: ffffffff8df3b860 (rcu_read_lock){....}-{1:3}, at:
ip6_route_add+0x4d/0x2f0 net/ipv6/route.c:3913
stack backtrace:
CPU: 0 UID: 0 PID: 5832 Comm: syz-executor234 Tainted: G W
6.15.0-rc4-syzkaller-00746-g836b313a14a3 #0 PREEMPT(full)
Tainted: [W]=WARN
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

Fixes: 169fd62799e8 ("ipv6: Get rid of RTNL for SIOCADDRT and RTM_NEWROUTE.")
Reported-by: syzbot+bcc12d6799364500fbec@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=bcc12d6799364500fbec
Reported-by: Eric Dumazet <edumazet@google.com>
Closes: https://lore.kernel.org/netdev/CANn89i+r1cGacVC_6n3-A-WSkAa_Nr+pmxJ7Gt+oP-P9by2aGw@mail.gmail.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv6/ip6_fib.c |  5 +++--
 net/ipv6/route.c   | 31 ++++++++++++++++++-------------
 2 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index 88770ecd2da1..e17b173625da 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -1027,8 +1027,9 @@ static void fib6_drop_pcpu_from(struct fib6_info *f6i,
 			.table = table
 		};
 
-		nexthop_for_each_fib6_nh(f6i->nh, fib6_nh_drop_pcpu_from,
-					 &arg);
+		rcu_read_lock();
+		nexthop_for_each_fib6_nh(f6i->nh, fib6_nh_drop_pcpu_from, &arg);
+		rcu_read_unlock();
 	} else {
 		struct fib6_nh *fib6_nh;
 
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 6baf177c529b..a87091dd06b1 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -1820,11 +1820,13 @@ static int rt6_nh_flush_exceptions(struct fib6_nh *nh, void *arg)
 
 void rt6_flush_exceptions(struct fib6_info *f6i)
 {
-	if (f6i->nh)
-		nexthop_for_each_fib6_nh(f6i->nh, rt6_nh_flush_exceptions,
-					 f6i);
-	else
+	if (f6i->nh) {
+		rcu_read_lock();
+		nexthop_for_each_fib6_nh(f6i->nh, rt6_nh_flush_exceptions, f6i);
+		rcu_read_unlock();
+	} else {
 		fib6_nh_flush_exceptions(f6i->fib6_nh, f6i);
+	}
 }
 
 /* Find cached rt in the hash table inside passed in rt
@@ -3841,6 +3843,8 @@ static int ip6_route_info_create_nh(struct fib6_info *rt,
 	if (cfg->fc_nh_id) {
 		struct nexthop *nh;
 
+		rcu_read_lock();
+
 		nh = nexthop_find_by_id(net, cfg->fc_nh_id);
 		if (!nh) {
 			err = -EINVAL;
@@ -3860,6 +3864,8 @@ static int ip6_route_info_create_nh(struct fib6_info *rt,
 
 		rt->nh = nh;
 		fib6_nh = nexthop_fib6_nh(rt->nh);
+
+		rcu_read_unlock();
 	} else {
 		int addr_type;
 
@@ -3895,6 +3901,7 @@ static int ip6_route_info_create_nh(struct fib6_info *rt,
 	fib6_info_release(rt);
 	return err;
 out_free:
+	rcu_read_unlock();
 	ip_fib_metrics_put(rt->fib6_metrics);
 	kfree(rt);
 	return err;
@@ -3910,16 +3917,12 @@ int ip6_route_add(struct fib6_config *cfg, gfp_t gfp_flags,
 	if (IS_ERR(rt))
 		return PTR_ERR(rt);
 
-	rcu_read_lock();
-
 	err = ip6_route_info_create_nh(rt, cfg, extack);
 	if (err)
-		goto unlock;
+		return err;
 
 	err = __ip6_ins_rt(rt, &cfg->fc_nlinfo, extack);
 	fib6_info_release(rt);
-unlock:
-	rcu_read_unlock();
 
 	return err;
 }
@@ -5534,8 +5537,6 @@ static int ip6_route_multipath_add(struct fib6_config *cfg,
 	if (err)
 		return err;
 
-	rcu_read_lock();
-
 	err = ip6_route_mpath_info_create_nh(&rt6_nh_list, extack);
 	if (err)
 		goto cleanup;
@@ -5627,8 +5628,6 @@ static int ip6_route_multipath_add(struct fib6_config *cfg,
 	}
 
 cleanup:
-	rcu_read_unlock();
-
 	list_for_each_entry_safe(nh, nh_safe, &rt6_nh_list, list) {
 		fib6_info_release(nh->fib6_info);
 		list_del(&nh->list);
@@ -6410,6 +6409,8 @@ void inet6_rt_notify(int event, struct fib6_info *rt, struct nl_info *info,
 	err = -ENOBUFS;
 	seq = info->nlh ? info->nlh->nlmsg_seq : 0;
 
+	rcu_read_lock();
+
 	skb = nlmsg_new(rt6_nlmsg_size(rt), GFP_ATOMIC);
 	if (!skb)
 		goto errout;
@@ -6422,10 +6423,14 @@ void inet6_rt_notify(int event, struct fib6_info *rt, struct nl_info *info,
 		kfree_skb(skb);
 		goto errout;
 	}
+
+	rcu_read_unlock();
+
 	rtnl_notify(skb, net, info->portid, RTNLGRP_IPV6_ROUTE,
 		    info->nlh, GFP_ATOMIC);
 	return;
 errout:
+	rcu_read_unlock();
 	rtnl_set_sk_err(net, RTNLGRP_IPV6_ROUTE, err);
 }
 
-- 
2.49.0


