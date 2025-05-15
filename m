Return-Path: <netdev+bounces-190792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6DAAB8CD5
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 18:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 338FF3B56E4
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 16:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7794253939;
	Thu, 15 May 2025 16:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eWRhzFdH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A430172638
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 16:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747327796; cv=none; b=CVu95ET7i3UlHhS2zJ3dIrPGKNXYd5mKqYu+WnBfKmgoNpV8V7tTV1JnM+3Z24k6EXjxKyg4ka658VoxInBxz42vdj0B/FKmAkuCleP64qCC45p/jlnYdc+9fTY4rgUy5CW+RCiBe0+9QMCn9UCddZvJH/ZWuGboLhV1RClHaoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747327796; c=relaxed/simple;
	bh=ROf/faDcYDrIlnCyFIktdk9dh5diHYQSaBpubvjR3T0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i5b7reEMNQDouOaJS6RM7YqXThtY3v9tXt3gdRKItLCBF7BRBz3eAurZwYpdYI2EBlPZmdsSrGZgKhvfwPI2Xw8JkM1E3ckqONXnzINVX0Yo2XEXUtIhea2NrsSj0w9nyc0+21h4uH1nA2ZkHhRNBYoqU4sJAZN2k1AdgS5jdPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eWRhzFdH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747327793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wR5e1hPZlXXDntxJiU1hYTltbnwj8swhiQE6W2J+aiA=;
	b=eWRhzFdH5ohxeUL/hHAua/Sdt23wu73cpHtgEA+020VKDFM18CoCpLaIP4K/HXIB9+QR8r
	h3oxHtWRm1QKTHrqjlZ/ZT1uosFopMNMsoumHsfpQTNWUoefxNLpy4FnXaLanZcVK8Igig
	Kqo3BmvSHiwqWR25UneAQyCs6pl3nHE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-DqquVxgFOP248vGiGGBXjQ-1; Thu,
 15 May 2025 12:49:49 -0400
X-MC-Unique: DqquVxgFOP248vGiGGBXjQ-1
X-Mimecast-MFC-AGG-ID: DqquVxgFOP248vGiGGBXjQ_1747327787
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 73D2C195608E;
	Thu, 15 May 2025 16:49:47 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.237])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9178818008F4;
	Thu, 15 May 2025 16:49:44 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Guoyu Yin <y04609127@gmail.com>
Subject: [PATCH net] mr: consolidate the ipmr_can_free_table() checks.
Date: Thu, 15 May 2025 18:49:26 +0200
Message-ID: <372dc261e1bf12742276e1b984fc5a071b7fc5a8.1747321903.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Guoyu Yin reported a splat in the ipmr netns cleanup path:

WARNING: CPU: 2 PID: 14564 at net/ipv4/ipmr.c:440 ipmr_free_table net/ipv4/ipmr.c:440 [inline]
WARNING: CPU: 2 PID: 14564 at net/ipv4/ipmr.c:440 ipmr_rules_exit+0x135/0x1c0 net/ipv4/ipmr.c:361
Modules linked in:
CPU: 2 UID: 0 PID: 14564 Comm: syz.4.838 Not tainted 6.14.0 #1
Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:ipmr_free_table net/ipv4/ipmr.c:440 [inline]
RIP: 0010:ipmr_rules_exit+0x135/0x1c0 net/ipv4/ipmr.c:361
Code: ff df 48 c1 ea 03 80 3c 02 00 75 7d 48 c7 83 60 05 00 00 00 00 00 00 5b 5d 41 5c 41 5d 41 5e e9 71 67 7f 00 e8 4c 2d 8a fd 90 <0f> 0b 90 eb 93 e8 41 2d 8a fd 0f b6 2d 80 54 ea 01 31 ff 89 ee e8
RSP: 0018:ffff888109547c58 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888108c12dc0 RCX: ffffffff83e09868
RDX: ffff8881022b3300 RSI: ffffffff83e098d4 RDI: 0000000000000005
RBP: ffff888104288000 R08: 0000000000000000 R09: ffffed10211825c9
R10: 0000000000000001 R11: ffff88801816c4a0 R12: 0000000000000001
R13: ffff888108c13320 R14: ffff888108c12dc0 R15: fffffbfff0b74058
FS:  00007f84f39316c0(0000) GS:ffff88811b100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f84f3930f98 CR3: 0000000113b56000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 ipmr_net_exit_batch+0x50/0x90 net/ipv4/ipmr.c:3160
 ops_exit_list+0x10c/0x160 net/core/net_namespace.c:177
 setup_net+0x47d/0x8e0 net/core/net_namespace.c:394
 copy_net_ns+0x25d/0x410 net/core/net_namespace.c:516
 create_new_namespaces+0x3f6/0xaf0 kernel/nsproxy.c:110
 unshare_nsproxy_namespaces+0xc3/0x180 kernel/nsproxy.c:228
 ksys_unshare+0x78d/0x9a0 kernel/fork.c:3342
 __do_sys_unshare kernel/fork.c:3413 [inline]
 __se_sys_unshare kernel/fork.c:3411 [inline]
 __x64_sys_unshare+0x31/0x40 kernel/fork.c:3411
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xa6/0x1a0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f84f532cc29
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f84f3931038 EFLAGS: 00000246 ORIG_RAX: 0000000000000110
RAX: ffffffffffffffda RBX: 00007f84f5615fa0 RCX: 00007f84f532cc29
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000040000400
RBP: 00007f84f53fba18 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f84f5615fa0 R15: 00007fff51c5f328
 </TASK>

The running kernel has CONFIG_IP_MROUTE_MULTIPLE_TABLES disabled, and
the sanity check for such build is still too loose.

Address the issue consolidating the relevant sanity check in a single
helper regardless of the kernel configuration. Also share it between
the ipv4 and ipv6 code.

Reported-by: Guoyu Yin <y04609127@gmail.com>
Fixes: 50b94204446e ("ipmr: tune the ipmr_can_free_table() checks.")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 include/linux/mroute_base.h |  5 +++++
 net/ipv4/ipmr.c             | 12 +-----------
 net/ipv6/ip6mr.c            | 12 +-----------
 3 files changed, 7 insertions(+), 22 deletions(-)

diff --git a/include/linux/mroute_base.h b/include/linux/mroute_base.h
index 58a2401e4b55..0075f6e5c3da 100644
--- a/include/linux/mroute_base.h
+++ b/include/linux/mroute_base.h
@@ -262,6 +262,11 @@ struct mr_table {
 	int			mroute_reg_vif_num;
 };
 
+static inline bool mr_can_free_table(struct net *net)
+{
+	return !check_net(net) || !net_initialized(net);
+}
+
 #ifdef CONFIG_IP_MROUTE_COMMON
 void vif_device_init(struct vif_device *v,
 		     struct net_device *dev,
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index a8b04d4abcaa..85dc208f32e9 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -120,11 +120,6 @@ static void ipmr_expire_process(struct timer_list *t);
 				lockdep_rtnl_is_held() ||		\
 				list_empty(&net->ipv4.mr_tables))
 
-static bool ipmr_can_free_table(struct net *net)
-{
-	return !check_net(net) || !net_initialized(net);
-}
-
 static struct mr_table *ipmr_mr_table_iter(struct net *net,
 					   struct mr_table *mrt)
 {
@@ -317,11 +312,6 @@ EXPORT_SYMBOL(ipmr_rule_default);
 #define ipmr_for_each_table(mrt, net) \
 	for (mrt = net->ipv4.mrt; mrt; mrt = NULL)
 
-static bool ipmr_can_free_table(struct net *net)
-{
-	return !check_net(net);
-}
-
 static struct mr_table *ipmr_mr_table_iter(struct net *net,
 					   struct mr_table *mrt)
 {
@@ -437,7 +427,7 @@ static void ipmr_free_table(struct mr_table *mrt)
 {
 	struct net *net = read_pnet(&mrt->net);
 
-	WARN_ON_ONCE(!ipmr_can_free_table(net));
+	WARN_ON_ONCE(!mr_can_free_table(net));
 
 	timer_shutdown_sync(&mrt->ipmr_expire_timer);
 	mroute_clean_tables(mrt, MRT_FLUSH_VIFS | MRT_FLUSH_VIFS_STATIC |
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index b413c9c8a21c..3276cde5ebd7 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -108,11 +108,6 @@ static void ipmr_expire_process(struct timer_list *t);
 				lockdep_rtnl_is_held() || \
 				list_empty(&net->ipv6.mr6_tables))
 
-static bool ip6mr_can_free_table(struct net *net)
-{
-	return !check_net(net) || !net_initialized(net);
-}
-
 static struct mr_table *ip6mr_mr_table_iter(struct net *net,
 					    struct mr_table *mrt)
 {
@@ -306,11 +301,6 @@ EXPORT_SYMBOL(ip6mr_rule_default);
 #define ip6mr_for_each_table(mrt, net) \
 	for (mrt = net->ipv6.mrt6; mrt; mrt = NULL)
 
-static bool ip6mr_can_free_table(struct net *net)
-{
-	return !check_net(net);
-}
-
 static struct mr_table *ip6mr_mr_table_iter(struct net *net,
 					    struct mr_table *mrt)
 {
@@ -416,7 +406,7 @@ static void ip6mr_free_table(struct mr_table *mrt)
 {
 	struct net *net = read_pnet(&mrt->net);
 
-	WARN_ON_ONCE(!ip6mr_can_free_table(net));
+	WARN_ON_ONCE(!mr_can_free_table(net));
 
 	timer_shutdown_sync(&mrt->ipmr_expire_timer);
 	mroute_clean_tables(mrt, MRT6_FLUSH_MIFS | MRT6_FLUSH_MIFS_STATIC |
-- 
2.49.0


