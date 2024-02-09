Return-Path: <netdev+bounces-70676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FBB84FF65
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 23:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1A71281510
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 22:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0A01A70A;
	Fri,  9 Feb 2024 22:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="fRU33S40"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C8721345
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 22:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707516313; cv=none; b=doBtorROm4pm/+87/ZQtCGnescqRGfXGSmsFyuGwUcONyN887faxjPlKRHWa1GVk+ry5omh9vpAAvQqzdnzWo1yMkQ4FsgzRaUttCtuHzIPWWOPIxfSs+hzfP9GDt59DSoA/zfTqI6CKYVCfOvqOC0dGzqv4LgWUYiA6IKrHRwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707516313; c=relaxed/simple;
	bh=9wYOnqBiZG/MZRG7QIvBkgfIezcv5rb/nZOdNX3givo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BMwUYebgq81fgmFvGdnDpRBU9iFe3woGl6xjgPqAXW8pqSCdWUaNDexHiqQUsLr8np7haZHlOAjhAt004D7y0Tu9McOqtobKUisr0ND+r6xzketqHRO4vOBWg9LBoZFBi3Ihchfbl0EFZRwJKGtGIHyIUqZ40fsR+5z6WqZx2uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=fRU33S40; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1707516311; x=1739052311;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tcNjVA+VTv7D47fi4h9bovZRUorH7z95qn2NNVEjrqA=;
  b=fRU33S4076S+Rch9B5ZofTRQvXj269Z6B8EPTE1xJLp+wsAnfPJ+tLvr
   +Ib7auyJGmzN0MdG5qnk3k/RE4ziPUXXd9ZPYkGQaj8lWNQSIYu+HDjyD
   lkevUk7y1vqVcdr0g4S6fmuWcKLBAobsHtfteqPl1cuGoMwL9IMGMGKy9
   8=;
X-IronPort-AV: E=Sophos;i="6.05,257,1701129600"; 
   d="scan'208";a="637007905"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 22:05:09 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:9357]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.253:2525] with esmtp (Farcaster)
 id 295820c6-600d-4eb6-b13a-1d88a10f24fb; Fri, 9 Feb 2024 22:05:07 +0000 (UTC)
X-Farcaster-Flow-ID: 295820c6-600d-4eb6-b13a-1d88a10f24fb
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 9 Feb 2024 22:05:07 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.24) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 9 Feb 2024 22:05:04 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>,
	<syzbot+4fa4a2d1f5a5ee06f006@syzkaller.appspotmail.com>
Subject: [PATCH v1 net] af_unix: Fix task hung while purging oob_skb in GC.
Date: Fri, 9 Feb 2024 14:04:53 -0800
Message-ID: <20240209220453.96053-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC004.ant.amazon.com (10.13.139.229) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

syzbot reported a task hung; at the same time, GC was looping infinitely
in list_for_each_entry_safe() for OOB skb.  [0]

syzbot demonstrated that the list_for_each_entry_safe() was not actually
safe in this case.

A single skb could have references for multiple sockets.  If we free such
a skb in the list_for_each_entry_safe(), the current and next sockets could
be unlinked in a single iteration.

unix_notinflight() uses list_del_init() to unlink the socket, so the
prefetched next socket forms a loop itself and list_for_each_entry_safe()
never stops.

Here, we must use while() and make sure we always fetch the first socket.

[0]:
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 5065 Comm: syz-executor236 Not tainted 6.8.0-rc3-syzkaller-00136-g1f719a2f3fa6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
RIP: 0010:preempt_count arch/x86/include/asm/preempt.h:26 [inline]
RIP: 0010:check_kcov_mode kernel/kcov.c:173 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0xd/0x60 kernel/kcov.c:207
Code: cc cc cc cc 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 65 48 8b 14 25 40 c2 03 00 <65> 8b 05 b4 7c 78 7e a9 00 01 ff 00 48 8b 34 24 74 0f f6 c4 01 74
RSP: 0018:ffffc900033efa58 EFLAGS: 00000283
RAX: ffff88807b077800 RBX: ffff88807b077800 RCX: 1ffffffff27b1189
RDX: ffff88802a5a3b80 RSI: ffffffff8968488d RDI: ffff88807b077f70
RBP: ffffc900033efbb0 R08: 0000000000000001 R09: fffffbfff27a900c
R10: ffffffff93d48067 R11: ffffffff8ae000eb R12: ffff88807b077800
R13: dffffc0000000000 R14: ffff88807b077e40 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000564f4fc1e3a8 CR3: 000000000d57a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 unix_gc+0x563/0x13b0 net/unix/garbage.c:319
 unix_release_sock+0xa93/0xf80 net/unix/af_unix.c:683
 unix_release+0x91/0xf0 net/unix/af_unix.c:1064
 __sock_release+0xb0/0x270 net/socket.c:659
 sock_close+0x1c/0x30 net/socket.c:1421
 __fput+0x270/0xb80 fs/file_table.c:376
 task_work_run+0x14f/0x250 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa8a/0x2ad0 kernel/exit.c:871
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1020
 __do_sys_exit_group kernel/exit.c:1031 [inline]
 __se_sys_exit_group kernel/exit.c:1029 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1029
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd5/0x270 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f9d6cbdac09
Code: Unable to access opcode bytes at 0x7f9d6cbdabdf.
RSP: 002b:00007fff5952feb8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f9d6cbdac09
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 00007f9d6cc552b0 R08: ffffffffffffffb8 R09: 0000000000000006
R10: 0000000000000006 R11: 0000000000000246 R12: 00007f9d6cc552b0
R13: 0000000000000000 R14: 00007f9d6cc55d00 R15: 00007f9d6cbabe70
 </TASK>

Reported-by: syzbot+4fa4a2d1f5a5ee06f006@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=4fa4a2d1f5a5ee06f006
Fixes: 1279f9d9dec2 ("af_unix: Call kfree_skb() for dead unix_(sk)->oob_skb in GC.")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/garbage.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 8f63f0b4bf01..2ff7ddbaa782 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -315,10 +315,11 @@ void unix_gc(void)
 	__skb_queue_purge(&hitlist);
 
 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
-	list_for_each_entry_safe(u, next, &gc_candidates, link) {
-		struct sk_buff *skb = u->oob_skb;
+	while (!list_empty(&gc_candidates)) {
+		u = list_entry(gc_candidates.next, struct unix_sock, link);
+		if (u->oob_skb) {
+			struct sk_buff *skb = u->oob_skb;
 
-		if (skb) {
 			u->oob_skb = NULL;
 			kfree_skb(skb);
 		}
-- 
2.30.2


