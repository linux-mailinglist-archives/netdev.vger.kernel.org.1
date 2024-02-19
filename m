Return-Path: <netdev+bounces-73026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8856485AA4E
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 18:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40830284990
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 17:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC58445BE0;
	Mon, 19 Feb 2024 17:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="O/E1fKqc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C372747F55
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 17:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708364835; cv=none; b=CalQ4sD8mvlNXE0ZcTcapi4XHDeVHsSy0aP3lp2LAqMb3taT51WpLnBqlXF9XW0pBBhrnjk708CH0fry4WhoWiPXVq6joYkya+DSNg4sGHoCDmzWGKY8y5ATJvmQGb1KFGaOvhfl7STPsc8gz2eD7NXrv3CsmBjK2jj0WJaVLG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708364835; c=relaxed/simple;
	bh=xzzSMRh8+K2RMO6Yq2jQHFpuGqNGNi50pCCsQBg4L5c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d7WeJIfYK294lY3WVbXl9vDNi64pTqIMOzM18AOvEjxUZkzA1Q5VPTivxDObCAmWtiiBkHdpLwF5opKuOST6Dot5Xd7e+DYqy2ojReEgvvc6+TV1JcnNvejN27liL+HPW30rJmRfRoHDBWcvglfXNyQgO7LRb0HKdhliXNvMKlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=O/E1fKqc; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708364834; x=1739900834;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Os6a/5c1SXRSoPtr7B9Skt1ZCjfsyh5aaduBYFq8iYY=;
  b=O/E1fKqcnOd2If9M2Nef6TJpywfWplsoBKPeyJ4407RpnrqHqsVc7Uia
   hN2ShhWWL18kSLr/9xL+crvX4U4MfoRiz+jQpvi5rxko3JKh6zvRl0fvs
   T+oEyqYwsAiDQB5uPlnWPG0v1/mzitf10zxypUR3ra+VZEHJtToN4sJvB
   4=;
X-IronPort-AV: E=Sophos;i="6.06,170,1705363200"; 
   d="scan'208";a="387541816"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 17:47:11 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:34632]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.134:2525] with esmtp (Farcaster)
 id d2aff43e-001e-42da-89b6-f085f4004e2f; Mon, 19 Feb 2024 17:47:09 +0000 (UTC)
X-Farcaster-Flow-ID: d2aff43e-001e-42da-89b6-f085f4004e2f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 19 Feb 2024 17:47:09 +0000
Received: from 88665a182662.ant.amazon.com (10.94.72.56) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.40;
 Mon, 19 Feb 2024 17:47:07 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>,
	<syzbot+ecab4d36f920c3574bf9@syzkaller.appspotmail.com>
Subject: [PATCH v1 net] af_unix: Drop oob_skb ref before purging queue in GC.
Date: Mon, 19 Feb 2024 09:46:57 -0800
Message-ID: <20240219174657.6047-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA004.ant.amazon.com (10.13.139.91) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

syzbot reported another task hung in __unix_gc().  [0]

The current while loop assumes that all of the left candidates
have oob_skb and calling kfree_skb(oob_skb) releases the remaining
candidates.

However, I missed a case that oob_skb has self-referencing fd and
another fd and the latter sk is placed before the former in the
candidate list.  Then, the while loop never proceeds, resulting
the task hung.

__unix_gc() has the same loop just before purging the collected skb,
so we can call kfree_skb(oob_skb) there and let __skb_queue_purge()
release all inflight sockets.

[0]:
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 2784 Comm: kworker/u4:8 Not tainted 6.8.0-rc4-syzkaller-01028-g71b605d32017 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Workqueue: events_unbound __unix_gc
RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x70 kernel/kcov.c:200
Code: 89 fb e8 23 00 00 00 48 8b 3d 84 f5 1a 0c 48 89 de 5b e9 43 26 57 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <f3> 0f 1e fa 48 8b 04 24 65 48 8b 0d 90 52 70 7e 65 8b 15 91 52 70
RSP: 0018:ffffc9000a17fa78 EFLAGS: 00000287
RAX: ffffffff8a0a6108 RBX: ffff88802b6c2640 RCX: ffff88802c0b3b80
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
RBP: ffffc9000a17fbf0 R08: ffffffff89383f1d R09: 1ffff1100ee5ff84
R10: dffffc0000000000 R11: ffffed100ee5ff85 R12: 1ffff110056d84ee
R13: ffffc9000a17fae0 R14: 0000000000000000 R15: ffffffff8f47b840
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffef5687ff8 CR3: 0000000029b34000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 __unix_gc+0xe69/0xf40 net/unix/garbage.c:343
 process_one_work kernel/workqueue.c:2633 [inline]
 process_scheduled_works+0x913/0x1420 kernel/workqueue.c:2706
 worker_thread+0xa5f/0x1000 kernel/workqueue.c:2787
 kthread+0x2ef/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:242
 </TASK>

Reported-and-tested-by: syzbot+ecab4d36f920c3574bf9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ecab4d36f920c3574bf9
Fixes: 25236c91b5ab ("af_unix: Fix task hung while purging oob_skb in GC.")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/garbage.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 2ff7ddbaa782..2a81880dac7b 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -284,9 +284,17 @@ void unix_gc(void)
 	 * which are creating the cycle(s).
 	 */
 	skb_queue_head_init(&hitlist);
-	list_for_each_entry(u, &gc_candidates, link)
+	list_for_each_entry(u, &gc_candidates, link) {
 		scan_children(&u->sk, inc_inflight, &hitlist);
 
+#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
+		if (u->oob_skb) {
+			kfree_skb(u->oob_skb);
+			u->oob_skb = NULL;
+		}
+#endif
+	}
+
 	/* not_cycle_list contains those sockets which do not make up a
 	 * cycle.  Restore these to the inflight list.
 	 */
@@ -314,18 +322,6 @@ void unix_gc(void)
 	/* Here we are. Hitlist is filled. Die. */
 	__skb_queue_purge(&hitlist);
 
-#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
-	while (!list_empty(&gc_candidates)) {
-		u = list_entry(gc_candidates.next, struct unix_sock, link);
-		if (u->oob_skb) {
-			struct sk_buff *skb = u->oob_skb;
-
-			u->oob_skb = NULL;
-			kfree_skb(skb);
-		}
-	}
-#endif
-
 	spin_lock(&unix_gc_lock);
 
 	/* There could be io_uring registered files, just push them back to
-- 
2.30.2


