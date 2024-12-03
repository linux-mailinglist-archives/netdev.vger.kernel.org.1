Return-Path: <netdev+bounces-148427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 516A69E1841
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 10:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EDB5282E8B
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 09:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDCB1E0DA0;
	Tue,  3 Dec 2024 09:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C8L1A47w"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE59E1DF72C
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 09:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733219317; cv=none; b=QlmvTrBwcku6gBkNgrH9AKpeImVP/kx6acO1Bg2Avx4IAXo640mCK9HDeT0h+Ywa4Mageuo1ryC1vrseMfF9YMB+tIwhYqXUjWgfYuqyFEKGAcKpxcIbSHC44+dnEFQxBc8ftiq5ZtpPhCi4pBcJa28odJkbV1N3LsBRl6NyHtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733219317; c=relaxed/simple;
	bh=evytnyFwCLcOP9alHYwYG8wrVErhS7rxKkR+SICyTPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LxAFzTl5bj0vLe/umTgF0479kgJmdnWiRIf8AwSh0uPMAcCNQ0Scno0c5EZtKBBLQkfvxBmcVIpc1mc3IAB4dNz3PiPy4W7BGKu7U51xeoBz7bxC9H+DQP72DZ2EE1L/BI1N+gr9xxd9pXj6cnP8Xf0RgNfzjZqgYs8mVhu9DMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C8L1A47w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733219314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=93lPMqjLlAe8utbQo/1af0Hp1e9P75olgQIiueu0TPU=;
	b=C8L1A47wOA/9CGYFIImWvpIQg2ElKk84eNGZq1WEZLLEbo3JyvNpZs32lX7NJa4JbYfO2j
	i9misF193gVfDeJh6cf3LFRw+c9kxKwKLwyrLThjsNpy3tHxSxLeFcpJGtqH9w9ZfpE2fW
	H5+lg3FbguWJDIEejU/iPbmc0OH8uKA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-357-6MBi3qYeN7K3gfGFBaVSkw-1; Tue,
 03 Dec 2024 04:48:31 -0500
X-MC-Unique: 6MBi3qYeN7K3gfGFBaVSkw-1
X-Mimecast-MFC-AGG-ID: 6MBi3qYeN7K3gfGFBaVSkw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6C0991956048;
	Tue,  3 Dec 2024 09:48:30 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.27])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 486231956052;
	Tue,  3 Dec 2024 09:48:28 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH v3 net] ipmr: tune the ipmr_can_free_table() checks.
Date: Tue,  3 Dec 2024 10:48:15 +0100
Message-ID: <8bde975e21bbca9d9c27e36209b2dd4f1d7a3f00.1733212078.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Eric reported a syzkaller-triggered splat caused by recent ipmr changes:

WARNING: CPU: 2 PID: 6041 at net/ipv6/ip6mr.c:419
ip6mr_free_table+0xbd/0x120 net/ipv6/ip6mr.c:419
Modules linked in:
CPU: 2 UID: 0 PID: 6041 Comm: syz-executor183 Not tainted
6.12.0-syzkaller-10681-g65ae975e97d5 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:ip6mr_free_table+0xbd/0x120 net/ipv6/ip6mr.c:419
Code: 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c
02 00 75 58 49 83 bc 24 c0 0e 00 00 00 74 09 e8 44 ef a9 f7 90 <0f> 0b
90 e8 3b ef a9 f7 48 8d 7b 38 e8 12 a3 96 f7 48 89 df be 0f
RSP: 0018:ffffc90004267bd8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88803c710000 RCX: ffffffff89e4d844
RDX: ffff88803c52c880 RSI: ffffffff89e4d87c RDI: ffff88803c578ec0
RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffff88803c578000
R13: ffff88803c710000 R14: ffff88803c710008 R15: dead000000000100
FS: 00007f7a855ee6c0(0000) GS:ffff88806a800000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7a85689938 CR3: 000000003c492000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
<TASK>
ip6mr_rules_exit+0x176/0x2d0 net/ipv6/ip6mr.c:283
ip6mr_net_exit_batch+0x53/0xa0 net/ipv6/ip6mr.c:1388
ops_exit_list+0x128/0x180 net/core/net_namespace.c:177
setup_net+0x4fe/0x860 net/core/net_namespace.c:394
copy_net_ns+0x2b4/0x6b0 net/core/net_namespace.c:500
create_new_namespaces+0x3ea/0xad0 kernel/nsproxy.c:110
unshare_nsproxy_namespaces+0xc0/0x1f0 kernel/nsproxy.c:228
ksys_unshare+0x45d/0xa40 kernel/fork.c:3334
__do_sys_unshare kernel/fork.c:3405 [inline]
__se_sys_unshare kernel/fork.c:3403 [inline]
__x64_sys_unshare+0x31/0x40 kernel/fork.c:3403
do_syscall_x64 arch/x86/entry/common.c:52 [inline]
do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7a856332d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7a855ee238 EFLAGS: 00000246 ORIG_RAX: 0000000000000110
RAX: ffffffffffffffda RBX: 00007f7a856bd308 RCX: 00007f7a856332d9
RDX: 00007f7a8560f8c6 RSI: 0000000000000000 RDI: 0000000062040200
RBP: 00007f7a856bd300 R08: 00007fff932160a7 R09: 00007f7a855ee6c0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f7a856bd30c
R13: 0000000000000000 R14: 00007fff93215fc0 R15: 00007fff932160a8
</TASK>

The root cause is a network namespace creation failing after successful
initialization of the ipmr subsystem. Such a case is not currently
matched by the ipmr_can_free_table() helper.

New namespaces are zeroed on allocation and inserted into net ns list
only after successful creation; when deleting an ipmr table, the list
next pointer can be NULL only on netns initialization failure.

Update the ipmr_can_free_table() checks leveraging such condition.

Reported-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot+6e8cb445d4b43d006e0c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6e8cb445d4b43d006e0c
Fixes: 11b6e701bce9 ("ipmr: add debug check for mr table cleanup")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v2 -> v3:
 - add ONCE annotation and constify the helper

v1 -> v2:
 - move the netns init completed check in a new helper
---
 include/net/net_namespace.h | 5 +++++
 net/ipv4/ipmr.c             | 2 +-
 net/ipv6/ip6mr.c            | 2 +-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index 873c0f9fdac6..f943bd79ef03 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -325,6 +325,11 @@ static inline int check_net(const struct net *net)
 #define net_drop_ns NULL
 #endif
 
+/* Returns true if the netns initialization is completed successfully */
+static inline bool net_initialized(const struct net *net)
+{
+	return READ_ONCE(net->list.next);
+}
 
 static inline void __netns_tracker_alloc(struct net *net,
 					 netns_tracker *tracker,
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index c5b8ec5c0a8c..99d8faa508e5 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -122,7 +122,7 @@ static void ipmr_expire_process(struct timer_list *t);
 
 static bool ipmr_can_free_table(struct net *net)
 {
-	return !check_net(net) || !net->ipv4.mr_rules_ops;
+	return !check_net(net) || !net_initialized(net);
 }
 
 static struct mr_table *ipmr_mr_table_iter(struct net *net,
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 7f1902ac3586..578ff1336afe 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -110,7 +110,7 @@ static void ipmr_expire_process(struct timer_list *t);
 
 static bool ip6mr_can_free_table(struct net *net)
 {
-	return !check_net(net) || !net->ipv6.mr6_rules_ops;
+	return !check_net(net) || !net_initialized(net);
 }
 
 static struct mr_table *ip6mr_mr_table_iter(struct net *net,
-- 
2.45.2


