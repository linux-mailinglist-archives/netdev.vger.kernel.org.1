Return-Path: <netdev+bounces-141583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1906F9BB8F3
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 16:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 698F3B25167
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 15:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DEB41BDA95;
	Mon,  4 Nov 2024 15:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E8IekvU/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4F61B6D14
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 15:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730733988; cv=none; b=ROaSbtGBmcSU5zgn5ej+aSJeEiRttOlN4IUCqxv44doQAkttPX6DYbpfxFRH0kfF/wKE8I0BEnB58NRlgDFV1rXy53fFgd60T2+/TPUiQ98982Lyo6dAlVYL/mo3N7RNNPQSwkqtKy3Xj6ej46RNRCx502Wd2c/eS/DqdSsfY5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730733988; c=relaxed/simple;
	bh=ajOWgRvQDGIFCdepcy+aB7Rg4hFqDUIwBw+wsNolWt0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qZ98scxENPu0YOpj/o6Ovc10sZ4H/HzynQdSDB+4MuPw0s0rLPWv4NmYOBq3ngLW4gfsUV0rifybvu0K9YseiCk/KHzahPjwIvU+pi0wdn6B5z7BE+v7aZolIAbbvX5tmrmd55lWRCueawIqTgpA+yJZd90h8dQZlaYshsis8A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E8IekvU/; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e29135d1d0cso7105381276.1
        for <netdev@vger.kernel.org>; Mon, 04 Nov 2024 07:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730733984; x=1731338784; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c2JQ9uIIEkClb4SWhkB1sYRCZyBlRVG/GX7SdltLJVo=;
        b=E8IekvU/9eL4CWbUr0F4wIGYUEbiQHmbQXZ5IUEGae9Bd0iR/rnZ3feVe1sD2ATp5T
         i79nJBBI6rdfvSgQFSMH1cmNkMlIkpFIt2Jk3eAtqGiiD9lkOhtWLt8c9uhZd7MBGzE6
         SNQHLX/WzK3dAkIvjyb4SgxgjGLtNymhh0y3Gq7ae2vwJOnSFRfZqEsg41SajOYcIKys
         9qvcLnl5z0BIERwzQGQXYbcwuwYHiXSeAEUFio4lnTidUYo1zRxgfK0691yOZ9augc77
         WgNMo2KEOmIo1qyCCeNcdO8b3EkTV05ufgJeoqzOGNKh9fHEw+AV7DPWEUq4Qho9j67W
         7Fuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730733985; x=1731338785;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c2JQ9uIIEkClb4SWhkB1sYRCZyBlRVG/GX7SdltLJVo=;
        b=d0dKl43JBYb+ULkrCLa8T2Hyl3Db1wrmlwD2Icx4jEhEsuhNAzzJwJQe/iUxnIyua/
         DF1blLEfcG+6xZgdY6FC2k/4dQ0FrYfk5G1FLYf2GwQT9v6e3BI/Hto0/Bo8Imix1kil
         pGpWLsefbeMRjCoVgki3kceX/NsUlOiJwhGEW1ij8fKSEfuKwDJsd2XAThh1F4MCtmow
         TQTHVbE12G/hPaSuNw0lNIatwyn24pQ8ZL2T8udh25tZBw0AO+B98GglrnzPV5WaOyWZ
         P5odmawDF+8fUjRSr43O8SWD2AMN4NZ9+dRZ0E8ZVvPaOsxH8AI+vNCotxoapWdFsNZA
         wKdw==
X-Gm-Message-State: AOJu0YwgalltawLvyUIUK6rqgEgU6BTOE06y0UDGdvBTwKqk6/OOtnWv
	pO4bueHQwjaTFiVe5mkYXIvw20JqDmgJPYIiy6r8E4LBZM3bInm6uZ0d8nwYViMLrOFy75lYuE0
	dsAj2SdRuYg==
X-Google-Smtp-Source: AGHT+IFvUv8BJpNyZ89NZaPoPBgaKRZfX/w9AO30D11PSrQb90dvQ9wWW7Humf338UVAWPnSYK8iCr7W0Skbug==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a25:83c7:0:b0:e20:2502:be14 with SMTP id
 3f1490d57ef6-e330356f9camr7941276.7.1730733984389; Mon, 04 Nov 2024 07:26:24
 -0800 (PST)
Date: Mon,  4 Nov 2024 15:26:22 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241104152622.3580037-1-edumazet@google.com>
Subject: [PATCH net-next] phonet: do not call synchronize_rcu() from phonet_route_del()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Remi Denis-Courmont <courmisch@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Calling synchronize_rcu() while holding rcu_read_lock() is not
permitted [1]

Move the synchronize_rcu() to route_doit().

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
 net/phonet/pn_dev.c     |  4 +++-
 net/phonet/pn_netlink.c | 10 ++++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/net/phonet/pn_dev.c b/net/phonet/pn_dev.c
index 19234d664c4fb537eba0267266efbb226cf103c3..578d935f2b11694fd1004c5f854ec344b846eeb2 100644
--- a/net/phonet/pn_dev.c
+++ b/net/phonet/pn_dev.c
@@ -406,7 +406,9 @@ int phonet_route_del(struct net_device *dev, u8 daddr)
 
 	if (!dev)
 		return -ENOENT;
-	synchronize_rcu();
+
+	/* Note : our caller must call synchronize_rcu() */
+
 	dev_put(dev);
 	return 0;
 }
diff --git a/net/phonet/pn_netlink.c b/net/phonet/pn_netlink.c
index ca1f04e4a2d9eb3b2a6d6cc5b299aee28d569b08..24930733ac572ed3ec5fd142d347c115346a28fa 100644
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
@@ -269,16 +270,21 @@ static int route_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
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
 
 	if (!err)
 		rtm_phonet_notify(net, nlh->nlmsg_type, ifindex, dst);
 
+	if (sync_needed)
+		synchronize_rcu();
 	return err;
 }
 
-- 
2.47.0.163.g1226f6d8fa-goog


