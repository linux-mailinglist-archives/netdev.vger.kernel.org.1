Return-Path: <netdev+bounces-141989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAB29BCDC1
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 14:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20073B21AFC
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 13:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942911D5ADD;
	Tue,  5 Nov 2024 13:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bAwH+6IK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD41A70837
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 13:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730813218; cv=none; b=rpf8JTrTllrPgoULgqfSFk4W6umZR2BWsAtwV6SWN5LUW3XjPQCGbZmWiYabR9XL5mLFFZ5WDaCaHOuKFG/MFdNRYHEtYKDk3bzLyarNDDfLnSTP5a/yi0UMQcwI1/kKSub7Zv126TgBZDbRNTNicQZ/QKG3fGaUAZMJGvQ1Fo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730813218; c=relaxed/simple;
	bh=dh42vq0Cqb+ZCOSgDX/8+8FJHtfSFQtLCLjqr00gu3U=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OCIAHNorUpVLd+depX6gCWJQ7LLaT4ynCR9kgVFjNjzhRyAbOpF6Rpphum91LtcP+24wrZirimWQg4mXAgC7dRzzMhhSwU6Q+7zkvDNTzhIKVVmDmqHjIpDJqfVN1Z6lyH5X/GzJiUzJ4Ze0d2PHPM3R2UD8olEuqZkcQPtjC/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bAwH+6IK; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e30daaf5928so10334713276.1
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 05:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730813216; x=1731418016; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t1pjRe8Y5dIIiOTSGCw6G493FCJZ/doxtEwp07yFy8k=;
        b=bAwH+6IKM7zBu8+lHKFalM77n8n/caQ9LUdnI0nLB3D7WjhZSsPSCBkaLd0sEWjmC0
         Rs7o6teYvLeHhQkYPL5i3OG7jZyNY9B/k1AtJ9S4rTngjmFY2pdSHQ5609pOL+BI+MDM
         Ot02YrlDfH44ywc/Y+VeXn4YLPKpfjCMscmQy9winUv98rFSCc+2rW8f7Mh9YF8uBm4h
         6rRLBCJZIR422FQXj0SALAC4zlHzKHY2SGUISPKpmn19O3q3QZLlEbuZ4JhQwVgQc3GX
         odLSSxUExWdkSImMnra8UkD7Mc7BxxwTuuWUBfN8x7z2qzTyege5d3BhjV36nkZrFnB2
         wHwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730813216; x=1731418016;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t1pjRe8Y5dIIiOTSGCw6G493FCJZ/doxtEwp07yFy8k=;
        b=UPGijf83fXriX0YH9/QGg2hXFdpRV9stSY4maqJEU24ytHlz6Dr4uUszNp7oC5ttcE
         xDImWv0I1tUqCCzxaDGJEJPonuWYXEDJgnbQ9itb9BZsywUz7bE1D1Um6ysQLATrqFt1
         F9JrnHJlxzd4c8FgpXSpo6tmVYZWqj4sthL84p6+xO9hgN8/0kXJG9jQjIaSNJpZKw3d
         SqD96GXr9wxWTUecsXO95CDl3rLFcTSrVXaiEPRbotYEznksiOrlAvHwLaGiXm8H8P4x
         Z3g6BwAec5E4TcJb4VkEpxgD3zR7fxYz+xuJ07AvoMTmrBzN/hDOhBC/k3zGu2TApPoG
         6m1A==
X-Gm-Message-State: AOJu0YxzBD1ODCT62KMv4/jNYale0XHsspamKkpyO6gwuNzEjkN0on03
	RnjqdbcdPH8hArnZwc0vMaHBGS+zu7Nq9ODHnXM6jOZr5UuNe1fnzH5UcGbV3SRRV5l3hY50hIo
	OQx2Vq0hI8Q==
X-Google-Smtp-Source: AGHT+IFpoGTOV55fTr9hY+EZRWHlntm06o2KKCwq9kgw2VKZclUzqPmMN+iApFgUVNoS/vWpIxUCD7wY15hSrw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a25:a549:0:b0:e30:c6ce:1165 with SMTP id
 3f1490d57ef6-e30c6ce1d94mr47121276.1.1730813215738; Tue, 05 Nov 2024 05:26:55
 -0800 (PST)
Date: Tue,  5 Nov 2024 13:26:45 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241105132645.654244-1-edumazet@google.com>
Subject: [PATCH v2 net] phonet: do not call synchronize_rcu() from phonet_route_del()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Remi Denis-Courmont <courmisch@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Calling synchronize_rcu() while holding rcu_read_lock() is not
permitted [1]

Move the synchronize_rcu() + dev_put() to route_doit().

Alternative would be to not use rcu_read_lock() in route_doit().

[1]
WARNING: suspicious RCU usage
6.12.0-rc5-syzkaller-01056-gf07a6e6ceb05 #0 Not tainted
-----------------------------
kernel/rcu/tree.c:4092 Illegal synchronize_rcu() in RCU read-side critical section!

other info that might help us debug this:

rcu_scheduler_active = 2, debug_locks = 1
1 lock held by syz-executor427/5840:
  #0: ffffffff8e937da0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
  #0: ffffffff8e937da0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
  #0: ffffffff8e937da0 (rcu_read_lock){....}-{1:2}, at: route_doit+0x3d6/0x640 net/phonet/pn_netlink.c:264

stack backtrace:
CPU: 1 UID: 0 PID: 5840 Comm: syz-executor427 Not tainted 6.12.0-rc5-syzkaller-01056-gf07a6e6ceb05 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
  __dump_stack lib/dump_stack.c:94 [inline]
  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
  lockdep_rcu_suspicious+0x226/0x340 kernel/locking/lockdep.c:6821
  synchronize_rcu+0xea/0x360 kernel/rcu/tree.c:4089
  phonet_route_del+0xc6/0x140 net/phonet/pn_dev.c:409
  route_doit+0x514/0x640 net/phonet/pn_netlink.c:275
  rtnetlink_rcv_msg+0x791/0xcf0 net/core/rtnetlink.c:6790
  netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2551
  netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
  netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
  netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
  sock_sendmsg_nosec net/socket.c:729 [inline]
  __sock_sendmsg+0x221/0x270 net/socket.c:744
  sock_write_iter+0x2d7/0x3f0 net/socket.c:1165
  new_sync_write fs/read_write.c:590 [inline]
  vfs_write+0xaeb/0xd30 fs/read_write.c:683
  ksys_write+0x183/0x2b0 fs/read_write.c:736
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: 17a1ac0018ae ("phonet: Don't hold RTNL for route_doit().")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Remi Denis-Courmont <courmisch@gmail.com>
---
v2: also move dev_put() to keep it after synchronize_rcu()

 net/phonet/pn_dev.c     |  5 +++--
 net/phonet/pn_netlink.c | 12 ++++++++++--
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/net/phonet/pn_dev.c b/net/phonet/pn_dev.c
index 19234d664c4fb537eba0267266efbb226cf103c3..5c36bae37b8fa85d2e97bf11d099c6c8599dcc5f 100644
--- a/net/phonet/pn_dev.c
+++ b/net/phonet/pn_dev.c
@@ -406,8 +406,9 @@ int phonet_route_del(struct net_device *dev, u8 daddr)
 
 	if (!dev)
 		return -ENOENT;
-	synchronize_rcu();
-	dev_put(dev);
+
+	/* Note : our caller must call synchronize_rcu() and dev_put(dev) */
+
 	return 0;
 }
 
diff --git a/net/phonet/pn_netlink.c b/net/phonet/pn_netlink.c
index ca1f04e4a2d9eb3b2a6d6cc5b299aee28d569b08..b9043c92dc246f8c5c313b262eb3ec4afad47ecb 100644
--- a/net/phonet/pn_netlink.c
+++ b/net/phonet/pn_netlink.c
@@ -233,6 +233,7 @@ static int route_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 {
 	struct net *net = sock_net(skb->sk);
 	struct nlattr *tb[RTA_MAX+1];
+	bool sync_needed = false;
 	struct net_device *dev;
 	struct rtmsg *rtm;
 	u32 ifindex;
@@ -269,13 +270,20 @@ static int route_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 		return -ENODEV;
 	}
 
-	if (nlh->nlmsg_type == RTM_NEWROUTE)
+	if (nlh->nlmsg_type == RTM_NEWROUTE) {
 		err = phonet_route_add(dev, dst);
-	else
+	} else {
 		err = phonet_route_del(dev, dst);
+		if (!err)
+			sync_needed = true;
+	}
 
 	rcu_read_unlock();
 
+	if (sync_needed) {
+		synchronize_rcu();
+		dev_put(dev);
+	}
 	if (!err)
 		rtm_phonet_notify(net, nlh->nlmsg_type, ifindex, dst);
 
-- 
2.47.0.199.ga7371fff76-goog


