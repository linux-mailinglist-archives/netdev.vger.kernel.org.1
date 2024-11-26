Return-Path: <netdev+bounces-147498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 060809D9E06
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 20:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 618AFB221D0
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 19:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F4F1DE4FF;
	Tue, 26 Nov 2024 19:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TjG8DyYk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F415191F8F
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 19:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732649312; cv=none; b=G/48+GDQicBNpBRoIz5fNlYaYHrXGbljDJepmeoL8JjhAi3ju19lST7W9+sXabecVudGWi3G+RNl8TzwwBgl22Nu7HvD+6sEdjfQLE8o3fcrW3sBDkXv3d/mQKq3NW3SqvEo3DsXapkAI+P0slJI47eAMtrS2CsGU5Dqs2/uomQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732649312; c=relaxed/simple;
	bh=zPVBn5qz78wBwinicBPXy3RJucu7XfdqJ7R6DFGdNZc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VsnAd6pjiIs08QvT7GxeR5FXoWFa7HBEfIZOGDQJNmQdUidZ5bibF6+/Wl/lc8XwNEkEPTCu1vqFTIPLMCl1IHQFIU4eQVMh6QXWGbeW3Rbe336F/DpD/nfRaAEck1/unpVR+r0lAkLlb1rPLfXTxUPDY8oXLROTC0ybxkmpLgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TjG8DyYk; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-6d40cc40d44so79099266d6.0
        for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 11:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732649309; x=1733254109; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HEK0PmFWw89vJjWfrxyqW79yTZBzGrMCnRc4z7fb2ZI=;
        b=TjG8DyYkvqfZNQYkP8GxbAH+h6q/71fWv81ycfwjKuAU7cvZlC6LhS+OOS3mZr23P9
         3AR0DQIo2sEB8lWw4o6RTNa5RfQPjv8tcENa8uAu//HxibH/JUyDDjrVyIV4tdOf3IhM
         m415Sc2xNpaikkZPXGTR1MkJhb3C9O9YNu489ygw7CZ77xnuh8ZbBD2ut8FiBiizje+/
         DtZk23+CS1LLQHJFtJSoPnZwMIe+6LZ0qlRBP6VlkXg75wVzwgXFPj4x4J/3GtWtJWcW
         i8brvZ9ZJqkAYOLeMmK56jKGfv4abrbVI6TLIJbwOuMDixKuE9RxxiiXqycTheIllkXJ
         4O7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732649309; x=1733254109;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HEK0PmFWw89vJjWfrxyqW79yTZBzGrMCnRc4z7fb2ZI=;
        b=WHXDPYPP/QAlR8K1K/hoeUOq+GZ6Dx6Sme+dphidzIjel0ImBB/LYBKXHdd5D+2luk
         oQ5wECOoFyGIxRdOQuJCR6N2edO8El+0J2qf1rMjIMy/JYsUg56c32Uf1MYnlnXY8K9f
         1RTcqTkV/uUBDcw0WhqLJiBRItJWyoBqOFTrjss6kblYfjxgLbELAvbwdwEl3HK/AXPS
         aGph1fIJNx6K4osWuSPTf2Z08GP7eru4j25sb/DFB6UAOgU9oTU0Ym8OsA6RqoJ3+HnH
         cO+c1TdDev3ZFS7QbupfrXviuJ5tft1JaSpIQSjZe11uhKi5qtn7kVAwKuXyABFunw3e
         ATFA==
X-Gm-Message-State: AOJu0YwFphRK6NQGn+EuOh6VHEIdA93F1N2Y8N9hVPM86bfXycXRbQ9o
	5sJwt3wMJ9SL3OnOVwO805KULwkRXU/nHXQOPt2o7rMvk5nuLjbaB4hYcnpS+J59WLtD1HXHsoq
	aAeB36S1pBg==
X-Google-Smtp-Source: AGHT+IH/eH2e5xlo03W3coBJoSBSIQPWUcwOT8GiCo/wL25b/DeZg4jXJxgKHhusRDT/XM+sDbAWAkSLZ0AJDA==
X-Received: from qvbqv4.prod.google.com ([2002:a05:6214:4784:b0:6d4:27d6:5d9b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:5ccd:0:b0:6d4:24f9:d930 with SMTP id 6a1803df08f44-6d864d20959mr4188046d6.16.1732649309504;
 Tue, 26 Nov 2024 11:28:29 -0800 (PST)
Date: Tue, 26 Nov 2024 19:28:27 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241126192827.797037-1-edumazet@google.com>
Subject: [PATCH net] ipv6: avoid possible NULL deref in modify_prefix_route()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+1de74b0794c40c8eb300@syzkaller.appspotmail.com, 
	Kui-Feng Lee <thinker.li@gmail.com>, David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"

syzbot found a NULL deref [1] in modify_prefix_route(), caused by one
fib6_info without a fib6_table pointer set.

This can happen for net->ipv6.fib6_null_entry

[1]
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000006: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
CPU: 1 UID: 0 PID: 5837 Comm: syz-executor888 Not tainted 6.12.0-syzkaller-09567-g7eef7e306d3c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
 RIP: 0010:__lock_acquire+0xe4/0x3c40 kernel/locking/lockdep.c:5089
Code: 08 84 d2 0f 85 15 14 00 00 44 8b 0d ca 98 f5 0e 45 85 c9 0f 84 b4 0e 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 0f 85 96 2c 00 00 49 8b 04 24 48 3d a0 07 7f 93 0f 84
RSP: 0018:ffffc900035d7268 EFLAGS: 00010006
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000006 RSI: 1ffff920006bae5f RDI: 0000000000000030
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff90608e17 R11: 0000000000000001 R12: 0000000000000030
R13: ffff888036334880 R14: 0000000000000000 R15: 0000000000000000
FS:  0000555579e90380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc59cc4278 CR3: 0000000072b54000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
  lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5849
  __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
  _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
  spin_lock_bh include/linux/spinlock.h:356 [inline]
  modify_prefix_route+0x30b/0x8b0 net/ipv6/addrconf.c:4831
  inet6_addr_modify net/ipv6/addrconf.c:4923 [inline]
  inet6_rtm_newaddr+0x12c7/0x1ab0 net/ipv6/addrconf.c:5055
  rtnetlink_rcv_msg+0x3c7/0xea0 net/core/rtnetlink.c:6920
  netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2541
  netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
  netlink_unicast+0x53c/0x7f0 net/netlink/af_netlink.c:1347
  netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1891
  sock_sendmsg_nosec net/socket.c:711 [inline]
  __sock_sendmsg net/socket.c:726 [inline]
  ____sys_sendmsg+0xaaf/0xc90 net/socket.c:2583
  ___sys_sendmsg+0x135/0x1e0 net/socket.c:2637
  __sys_sendmsg+0x16e/0x220 net/socket.c:2669
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd1dcef8b79
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc59cc4378 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fd1dcef8b79
RDX: 0000000000040040 RSI: 0000000020000140 RDI: 0000000000000004
RBP: 00000000000113fd R08: 0000000000000006 R09: 0000000000000006
R10: 0000000000000006 R11: 0000000000000246 R12: 00007ffc59cc438c
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>

Fixes: 5eb902b8e719 ("net/ipv6: Remove expired routes with a separated list of routes.")
Reported-by: syzbot+1de74b0794c40c8eb300@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/67461f7f.050a0220.1286eb.0021.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
CC: Kui-Feng Lee <thinker.li@gmail.com>
Cc: David Ahern <dsahern@kernel.org>
---
 net/ipv6/addrconf.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index c489a1e6aec9a8b05a46bcf36424c30d73ebc8f0..0e765466d7f79ecc13316204c4ffc29c7ea3a71b 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -4821,7 +4821,7 @@ inet6_rtm_deladdr(struct sk_buff *skb, struct nlmsghdr *nlh,
 			      ifm->ifa_prefixlen, extack);
 }
 
-static int modify_prefix_route(struct inet6_ifaddr *ifp,
+static int modify_prefix_route(struct net *net, struct inet6_ifaddr *ifp,
 			       unsigned long expires, u32 flags,
 			       bool modify_peer)
 {
@@ -4845,7 +4845,9 @@ static int modify_prefix_route(struct inet6_ifaddr *ifp,
 				      ifp->prefix_len,
 				      ifp->rt_priority, ifp->idev->dev,
 				      expires, flags, GFP_KERNEL);
-	} else {
+		return 0;
+	}
+	if (f6i != net->ipv6.fib6_null_entry) {
 		table = f6i->fib6_table;
 		spin_lock_bh(&table->tb6_lock);
 
@@ -4858,9 +4860,8 @@ static int modify_prefix_route(struct inet6_ifaddr *ifp,
 		}
 
 		spin_unlock_bh(&table->tb6_lock);
-
-		fib6_info_release(f6i);
 	}
+	fib6_info_release(f6i);
 
 	return 0;
 }
@@ -4939,7 +4940,7 @@ static int inet6_addr_modify(struct net *net, struct inet6_ifaddr *ifp,
 		int rc = -ENOENT;
 
 		if (had_prefixroute)
-			rc = modify_prefix_route(ifp, expires, flags, false);
+			rc = modify_prefix_route(net, ifp, expires, flags, false);
 
 		/* prefix route could have been deleted; if so restore it */
 		if (rc == -ENOENT) {
@@ -4949,7 +4950,7 @@ static int inet6_addr_modify(struct net *net, struct inet6_ifaddr *ifp,
 		}
 
 		if (had_prefixroute && !ipv6_addr_any(&ifp->peer_addr))
-			rc = modify_prefix_route(ifp, expires, flags, true);
+			rc = modify_prefix_route(net, ifp, expires, flags, true);
 
 		if (rc == -ENOENT && !ipv6_addr_any(&ifp->peer_addr)) {
 			addrconf_prefix_route(&ifp->peer_addr, ifp->prefix_len,
-- 
2.47.0.338.g60cca15819-goog


