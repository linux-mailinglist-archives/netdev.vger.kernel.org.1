Return-Path: <netdev+bounces-236487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7216C3CFCC
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 19:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 655123A1C68
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 17:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB10343D71;
	Thu,  6 Nov 2025 17:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OOlJPf4Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F343314DB
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 17:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762451970; cv=none; b=X33UlbVZ2aFm5rv+jWE2cDBwPv4xu7JQb9vj8ghVQS53dZWdNP77JHhtHEjHYp64QTN/c0UYMmBxonC8IMYgHTuhnyALL1sg80iocifvAnPRuvgNL3mA+IaSw5B36Nyyiv/2ZOjSWudpoGeDMHxtBs8HpQEAqRT3zngbbaEaSJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762451970; c=relaxed/simple;
	bh=xSVGRPx3y1VkSRnywmF7Wg5iYBXo/Kvvd1CAtmdbmVU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cZFqBCIzTjvUEFCGei44bCF0cuYXvon5wL2lyjMccV/zzoQR3PkFMVyMHZaBAMpL2cklqN3UY+y4oekCrQ0IefHHeA3fMlPn9dk0IPsVb3ZmAuofP8gUb59Tcp2luN0EfScZDHz+u4OdElOaOKf5zBKMSOKdnYO730LiUdF2dzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OOlJPf4Q; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2956a694b47so18265255ad.1
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 09:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762451968; x=1763056768; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vlK4zA0L4la+hUwKhdxukg4u3+leU5PJEuHeams2xYc=;
        b=OOlJPf4Qhs7/iCq1tX6pitt3U42T4xeia/IgRT1N8YADgmlkMhhr1fXiuNX3PLRxYx
         Qb8qTa7+eJVjyYRJrQ29sJzzWiSz9mOHKSd0wKiX+Bwl+kyuvmFVR1vyKZDpeP0hRA1t
         nJ0MQExuD9YPjFGamcnLO0v/1sk+qnz+7P80SoHwh77lXfGO9eKnTpswb5Wlmxz/IEzA
         pyHS2cZXOaU0P87hPfgHtDwjNN7j0T7dOB4pFlrXxq4gJUXC8E+seX1pH/aMekLLjbJd
         KQKvQ0pw3IjOxovXnlt9vPJLukseaU5R0Bf0wCsVX73yZbn/c/j5FupTnV6gJYwvveGW
         4oEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762451968; x=1763056768;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vlK4zA0L4la+hUwKhdxukg4u3+leU5PJEuHeams2xYc=;
        b=vRoMvD+w4+I6Me3tXFffpt3Q7gnjfydHrrj0D1eSUK1pN4QKVGEDfXH/dD6TBCsE9N
         ffz4LQcdayqHwC0w59rvjIssnxU+PzuYwvn6U2rqF69DT0QhTbCu8kzVhP/TlN+PSHGt
         TkK3d7z+Onc2Y0MB0Y2Mv5Eieo4lXRMm9JHur+tQWH2jUUuTXhVWErcf76zi0rxhFfh8
         +pZqgAZW+xCbMnBR65sYjBkcb6+GGAmAojkEug1CTzJ/oLlOwxRia4w+9cCsInPPn+nm
         G14qNPt7ZeXwIIEGqYHFB/gtNWfe+seCQ55w2NiJVQ277mpSSh1yCyWfP0+iwvSxpQLp
         3hfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXM3vqboSnRqdxhfWi/wgfteSnb/GmtISadMI887PgUW7quZvUlm5n5pNnZEisNH9B6b5TJkZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ50CinOyou6OLlGAwJVOauucE9LiHZBngATmDUfT578St4KA6
	fJK7Q2yGR9sXZzit7J4n0jceNDAESewKzXP/5eg8MDsiyI5IOhfWYyWLmfKKiKBEukmmPnC5CZ7
	+rxpRQg==
X-Google-Smtp-Source: AGHT+IHYgX3mamcW6m7/cjCmJ0bMP247Tz2g55dHDPwjBo8YXouwntVi6jG9ucj4Q3XXuB7YD3dZNuqmZSU=
X-Received: from plqt4.prod.google.com ([2002:a17:902:a5c4:b0:290:28e2:ce54])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e84f:b0:295:64f8:d9cd
 with SMTP id d9443c01a7336-297c03ea736mr4913255ad.15.1762451967878; Thu, 06
 Nov 2025 09:59:27 -0800 (PST)
Date: Thu,  6 Nov 2025 17:59:17 +0000
In-Reply-To: <690c6ca9.050a0220.1e8caa.00d2.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <690c6ca9.050a0220.1e8caa.00d2.GAE@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251106175926.686885-1-kuniyu@google.com>
Subject: [syzbot ci] Re: tipc: Fix use-after-free in tipc_mon_reinit_self().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: syzbot+cif2d6d318f7e85f0b@syzkaller.appspotmail.com
Cc: davem@davemloft.net, edumazet@google.com, hoang.h.le@dektech.com.au, 
	horms@kernel.org, jmaloy@redhat.com, kuba@kernel.org, kuni1840@gmail.com, 
	kuniyu@google.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzbot@lists.linux.dev, syzbot@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com, tipc-discussion@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"

From: syzbot ci <syzbot+cif2d6d318f7e85f0b@syzkaller.appspotmail.com>
Date: Thu, 06 Nov 2025 01:38:49 -0800
> syzbot ci has tested the following series
> 
> [v1] tipc: Fix use-after-free in tipc_mon_reinit_self().
> https://lore.kernel.org/all/20251106053309.401275-1-kuniyu@google.com
> * [PATCH v1 net] tipc: Fix use-after-free in tipc_mon_reinit_self().
> 
> and found the following issue:
> possible deadlock in tipc_mon_reinit_self
> 
> Full report is available here:
> https://ci.syzbot.org/series/bfabf013-65e3-4ca9-8f54-0c7eef8be01a
> 
> ***
> 
> possible deadlock in tipc_mon_reinit_self
> 
> tree:      net
> URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/netdev/net.git
> base:      3d18a84eddde169d6dbf3c72cc5358b988c347d0
> arch:      amd64
> compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> config:    https://ci.syzbot.org/builds/b2774856-e331-420e-a340-5107ec4b06f9/config
> C repro:   https://ci.syzbot.org/findings/1f0a4298-b797-4217-8d6d-15f98c0ffd38/c_repro
> syz repro: https://ci.syzbot.org/findings/1f0a4298-b797-4217-8d6d-15f98c0ffd38/syz_repro
> 
> tipc: Started in network mode
> tipc: Node identity 4, cluster identity 4711
> tipc: Node number set to 4
> ============================================
> WARNING: possible recursive locking detected
> syzkaller #0 Not tainted
> --------------------------------------------
> syz.0.17/5963 is trying to acquire lock:
> ffffffff8f2cb1c8 (rtnl_mutex){+.+.}-{4:4}, at: tipc_mon_reinit_self+0x25/0x360 net/tipc/monitor.c:714
> 
> but task is already holding lock:
> ffffffff8f2cb1c8 (rtnl_mutex){+.+.}-{4:4}, at: __tipc_nl_compat_doit net/tipc/netlink_compat.c:358 [inline]
> ffffffff8f2cb1c8 (rtnl_mutex){+.+.}-{4:4}, at: tipc_nl_compat_doit+0x1fd/0x5f0 net/tipc/netlink_compat.c:393
> 
> other info that might help us debug this:
>  Possible unsafe locking scenario:
> 
>        CPU0
>        ----
>   lock(rtnl_mutex);
>   lock(rtnl_mutex);
> 
>  *** DEADLOCK ***
> 
>  May be due to missing lock nesting notation
> 
> 3 locks held by syz.0.17/5963:
>  #0: ffffffff8f331050 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
>  #1: ffffffff8f330e68 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
>  #1: ffffffff8f330e68 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
>  #1: ffffffff8f330e68 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x10d/0x790 net/netlink/genetlink.c:1209
>  #2: ffffffff8f2cb1c8 (rtnl_mutex){+.+.}-{4:4}, at: __tipc_nl_compat_doit net/tipc/netlink_compat.c:358 [inline]
>  #2: ffffffff8f2cb1c8 (rtnl_mutex){+.+.}-{4:4}, at: tipc_nl_compat_doit+0x1fd/0x5f0 net/tipc/netlink_compat.c:393
> 
> stack backtrace:
> CPU: 1 UID: 0 PID: 5963 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>  print_deadlock_bug+0x28b/0x2a0 kernel/locking/lockdep.c:3041
>  check_deadlock kernel/locking/lockdep.c:3093 [inline]
>  validate_chain+0x1a3f/0x2140 kernel/locking/lockdep.c:3895
>  __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
>  lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
>  __mutex_lock_common kernel/locking/mutex.c:598 [inline]
>  __mutex_lock+0x187/0x1350 kernel/locking/mutex.c:760
>  tipc_mon_reinit_self+0x25/0x360 net/tipc/monitor.c:714
>  tipc_net_finalize+0x115/0x190 net/tipc/net.c:140
>  tipc_net_init+0x104/0x190 net/tipc/net.c:122
>  __tipc_nl_net_set+0x3b9/0x5a0 net/tipc/net.c:263

I missed another path calling tipc_net_finalize under RTNL.

I'll change v2 this way.

---8<---
diff --git a/net/tipc/monitor.c b/net/tipc/monitor.c
index 46c8814c3ee6..be1e51efc445 100644
--- a/net/tipc/monitor.c
+++ b/net/tipc/monitor.c
@@ -706,12 +706,13 @@ void tipc_mon_delete(struct net *net, int bearer_id)
 	kfree(mon);
 }
 
-void tipc_mon_reinit_self(struct net *net)
+void tipc_mon_reinit_self(struct net *net, bool rtnl_held)
 {
 	struct tipc_monitor *mon;
 	int bearer_id;
 
-	rtnl_lock();
+	if (!rtnl_held)
+		rtnl_lock();
 
 	for (bearer_id = 0; bearer_id < MAX_BEARERS; bearer_id++) {
 		mon = tipc_monitor(net, bearer_id);
@@ -723,7 +724,8 @@ void tipc_mon_reinit_self(struct net *net)
 		write_unlock_bh(&mon->lock);
 	}
 
-	rtnl_unlock();
+	if (!rtnl_held)
+		rtnl_unlock();
 }
 
 int tipc_nl_monitor_set_threshold(struct net *net, u32 cluster_size)
diff --git a/net/tipc/net.c b/net/tipc/net.c
index 0e95572e56b4..56527f6f548c 100644
--- a/net/tipc/net.c
+++ b/net/tipc/net.c
@@ -119,11 +119,11 @@ int tipc_net_init(struct net *net, u8 *node_id, u32 addr)
 	if (node_id)
 		tipc_set_node_id(net, node_id);
 	if (addr)
-		tipc_net_finalize(net, addr);
+		tipc_net_finalize(net, addr, true);
 	return 0;
 }
 
-static void tipc_net_finalize(struct net *net, u32 addr)
+static void tipc_net_finalize(struct net *net, u32 addr, bool rtnl_held)
 {
 	struct tipc_net *tn = tipc_net(net);
 	struct tipc_socket_addr sk = {0, addr};
@@ -137,7 +137,7 @@ static void tipc_net_finalize(struct net *net, u32 addr)
 	tipc_set_node_addr(net, addr);
 	tipc_named_reinit(net);
 	tipc_sk_reinit(net);
-	tipc_mon_reinit_self(net);
+	tipc_mon_reinit_self(net, rtnl_held);
 	tipc_nametbl_publish(net, &ua, &sk, addr);
 }
 
@@ -145,7 +145,7 @@ void tipc_net_finalize_work(struct work_struct *work)
 {
 	struct tipc_net *tn = container_of(work, struct tipc_net, work);
 
-	tipc_net_finalize(tipc_link_net(tn->bcl), tn->trial_addr);
+	tipc_net_finalize(tipc_link_net(tn->bcl), tn->trial_addr, false);
 }
 
 void tipc_net_stop(struct net *net)
---8<---

