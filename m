Return-Path: <netdev+bounces-184238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 880BBA93F8F
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 23:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B66B38E0711
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 21:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8998C231C9F;
	Fri, 18 Apr 2025 21:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="RDCUMwXD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26451ADC8D
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 21:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745013046; cv=none; b=DLUxgwKevwwDfFxv9OrN0g0eQ5qBlwiZv0YV32hz6si+CyRQ14O5L4crMnmbPbNIvZ75ptNXs6zPj21XZmxM9NZHzwBHFlAoozqD4teqYVYTrV8TrAqXlh2tuHJCKYcYWDYZtmXyiespFEBQKTEWyx0irkzH/lkXEld7w4g8EYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745013046; c=relaxed/simple;
	bh=HagFl7z6xN8I9f+XuudThD+InMc6LpD5Ka4Ma5t57WY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bBEKymCdAXOv1RCJQLWxHyGwTuRTgszhonJWVp5wQXlAQqE3bYFD5knmuRrPJySUmGZmxZ5tyShQAnLu7Bkm1/F0KVgvwLI5ajoK40UH6LZhI8YPi6iBLim/an7FED0Pqjvr1AfsggqkrYOTmkNdP/e946A80yYGmv/K50LVZVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=RDCUMwXD; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1745013041; x=1776549041;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GYDwI99I0Sbxp92gh+m023OrF6q+/dC+bfsOrz7jKeE=;
  b=RDCUMwXDWUSZ4zhq+apuOyFDQGc4G5JCprhU1M+RhsYCy+j8VCXgG5Dm
   Xz0QIdbl20XY498ry1MP1WG+ofSS2VkmTDMQ6WZnVfW/ay3yCX6+ulyEV
   db665nNI5x6UHqtCinmZ2yVbDD7Iadhf4Qb3gLZj6LOJkFcGx0WQGqHEl
   Y=;
X-IronPort-AV: E=Sophos;i="6.15,222,1739836800"; 
   d="scan'208";a="192394243"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 21:50:38 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:51815]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.65:2525] with esmtp (Farcaster)
 id 65b40efd-3af0-438a-9e28-54f2cee39ac7; Fri, 18 Apr 2025 21:50:38 +0000 (UTC)
X-Farcaster-Flow-ID: 65b40efd-3af0-438a-9e28-54f2cee39ac7
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 18 Apr 2025 21:50:38 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.39) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 18 Apr 2025 21:50:35 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>, "kernel
 test robot" <oliver.sang@intel.com>
Subject: [PATCH v1 net-next] net: Fix wild-memory-access in __register_pernet_operations() when CONFIG_NET_NS=n.
Date: Fri, 18 Apr 2025 14:50:20 -0700
Message-ID: <20250418215025.87871-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC003.ant.amazon.com (10.13.139.198) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

kernel test robot reported the splat below. [0]

Before commit fed176bf3143 ("net: Add ops_undo_single for module
load/unload."), if CONFIG_NET_NS=n, ops was linked to pernet_list
only when init_net had not been initialised, and ops was unlinked
from pernet_list only under the same condition.

Let's say an ops is loaded before the init_net setup but unloaded
after that.  Then, the ops remains in pernet_list, which seems odd.

The cited commit added ops_undo_single(), which calls list_add() for
ops to link it to a temporary list, so a minor change was added to
__register_pernet_operations() and __unregister_pernet_operations()
under CONFIG_NET_NS=n to avoid the pernet_list corruption.

However, the corruption must have been left as is.

When CONFIG_NET_NS=n, pernet_list was used to keep ops registered
before the init_net setup, and after that, pernet_list was not used
at all.

This was because some ops annotated with __net_initdata are cleared
out of memory at some point during boot.

Then, such ops is initialised by POISON_FREE_INITMEM (0xcc), resulting
in that ops->list.{next,prev} suddenly switches from a valid pointer
to a weird value, 0xcccccccccccccccc.

To avoid such wild memory access, let's allow the pernet_list
corruption for CONFIG_NET_NS=n.

[0]:
Oops: general protection fault, probably for non-canonical address 0xf999959999999999: 0000 [#1] SMP KASAN NOPTI
KASAN: maybe wild-memory-access in range [0xccccccccccccccc8-0xcccccccccccccccf]
CPU: 2 UID: 0 PID: 346 Comm: modprobe Not tainted 6.15.0-rc1-00294-ga4cba7e98e35 #85 PREEMPT(voluntary)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
RIP: 0010:__list_add_valid_or_report (lib/list_debug.c:32)
Code: 48 c1 ea 03 80 3c 02 00 0f 85 5a 01 00 00 49 39 74 24 08 0f 85 83 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 1f 01 00 00 4c 39 26 0f 85 ab 00 00 00 4c 39 ee
RSP: 0018:ff11000135b87830 EFLAGS: 00010a07
RAX: dffffc0000000000 RBX: ffffffffc02223c0 RCX: ffffffff8406fcc2
RDX: 1999999999999999 RSI: cccccccccccccccc RDI: ffffffffc02223c0
RBP: ffffffff86064e40 R08: 0000000000000001 R09: fffffbfff0a9f5b5
R10: ffffffff854fadaf R11: 676552203a54454e R12: ffffffff86064e40
R13: ffffffffc02223c0 R14: ffffffff86064e48 R15: 0000000000000021
FS:  00007f6fb0d9e1c0(0000) GS:ff11000858ea0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6fb0eda580 CR3: 0000000122fec005 CR4: 0000000000771ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <TASK>
 register_pernet_operations (./include/linux/list.h:150 (discriminator 5) ./include/linux/list.h:183 (discriminator 5) net/core/net_namespace.c:1315 (discriminator 5) net/core/net_namespace.c:1359 (discriminator 5))
 register_pernet_subsys (net/core/net_namespace.c:1401)
 inet6_init (net/ipv6/af_inet6.c:535) ipv6
 do_one_initcall (init/main.c:1257)
 do_init_module (kernel/module/main.c:2942)
 load_module (kernel/module/main.c:3409)
 init_module_from_file (kernel/module/main.c:3599)
 idempotent_init_module (kernel/module/main.c:3611)
 __x64_sys_finit_module (./include/linux/file.h:62 ./include/linux/file.h:83 kernel/module/main.c:3634 kernel/module/main.c:3621 kernel/module/main.c:3621)
 do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
 RIP: 0033:0x7f6fb0df7e5d
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 73 9f 1b 00 f7 d8 64 89 01 48
RSP: 002b:00007fffdc6a8968 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
RAX: ffffffffffffffda RBX: 000055b535721b70 RCX: 00007f6fb0df7e5d
RDX: 0000000000000000 RSI: 000055b51e44aa2a RDI: 0000000000000004
RBP: 0000000000040000 R08: 0000000000000000 R09: 000055b535721b30
R10: 0000000000000004 R11: 0000000000000246 R12: 000055b51e44aa2a
R13: 000055b535721bf0 R14: 000055b5357220b0 R15: 0000000000000000
 </TASK>
Modules linked in: ipv6(+) crc_ccitt

Fixes: fed176bf3143 ("net: Add ops_undo_single for module load/unload.")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202504181511.1c3f23e4-lkp@intel.com
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/net_namespace.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 48dd6dc603c9..42ee7fce3d95 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -1314,19 +1314,19 @@ static void __unregister_pernet_operations(struct pernet_operations *ops)
 static int __register_pernet_operations(struct list_head *list,
 					struct pernet_operations *ops)
 {
-	list_add_tail(&ops->list, list);
-
-	if (!init_net_initialized)
+	if (!init_net_initialized) {
+		list_add_tail(&ops->list, list);
 		return 0;
+	}
 
 	return ops_init(ops, &init_net);
 }
 
 static void __unregister_pernet_operations(struct pernet_operations *ops)
 {
-	list_del(&ops->list);
-
-	if (init_net_initialized) {
+	if (!init_net_initialized) {
+		list_del(&ops->list);
+	} else {
 		LIST_HEAD(net_exit_list);
 
 		list_add(&init_net.exit_list, &net_exit_list);
-- 
2.49.0


