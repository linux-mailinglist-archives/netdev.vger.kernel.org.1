Return-Path: <netdev+bounces-84612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 397E58979AF
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 22:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51B521C21252
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 20:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893F11552E2;
	Wed,  3 Apr 2024 20:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="SfzuROoM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AD615574F
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 20:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712175455; cv=none; b=L5Wol2YOLbsSLFmPNlw8cdGS7rvjkbbAAkLex8w8k6mrbGED1A0tL+NlGjilg7VQL0gf2O88tpdKvYuiqCoaL4XemPstOp1rw6mnh4kzfaV1rFrcOWbyymJ6xamqgiG6kOS2CQW6hAauF9WN9zUYYPB4qfJzcPQ9S2LcCxx3wlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712175455; c=relaxed/simple;
	bh=yIBKnS5wDOWpVzO73GXB/1Kd4Yko5ydjfulqVtMyzW8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fJP0B26ta5Qt1o0rYPu4ZwS4CfIt4JzwspEgvEg9/HaiTT2IldAVsDrCDLuu0OQp7Oj57kxkrPDaTNTXQj8CqgwkZHsVs9O64qwbH2ErdkRitJr1sB1M8STPHijIsRCYOFLza5BfVQjznxjxXB3jWI+UeaVYESyik9H1Qgnfvr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=SfzuROoM; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712175454; x=1743711454;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0ENQRHQt76YwXo0NwaiM/VRLke7KfrJym235PVIDRuk=;
  b=SfzuROoM0Gq4lemfuFPg9FLOoNvzKjADci7RjL66C8/yg5Oi23tPhSYM
   llJQobJtZhvRri6e9GISrNoUa3W8rfgznsW171Gix1X4gPS/oZ9nEjNF9
   3J7LuXnWQrG0vbGmOBg0DHLuyEgJdhxo0HxLeG9bafqBPcCQUiDbjVpJ6
   E=;
X-IronPort-AV: E=Sophos;i="6.07,177,1708387200"; 
   d="scan'208";a="387379345"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 20:17:30 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:19846]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.3.54:2525] with esmtp (Farcaster)
 id 3c055098-b58c-4a31-84de-57a11eb65984; Wed, 3 Apr 2024 20:17:29 +0000 (UTC)
X-Farcaster-Flow-ID: 3c055098-b58c-4a31-84de-57a11eb65984
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 3 Apr 2024 20:17:28 +0000
Received: from 88665a182662.ant.amazon.com (10.142.160.235) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 3 Apr 2024 20:17:26 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next] ref_tracker: Print allocator task name.
Date: Wed, 3 Apr 2024 13:17:15 -0700
Message-ID: <20240403201715.33883-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA001.ant.amazon.com (10.13.139.103) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Even after syzkaller has triggered a bug, it often takes a long time
to find a repro.  In such a case, I usually try to find a repro with
syz-prog2c based on the syz-lang program in the log.

When ref_tracker detects a leaked reference, it shows a stack trace
where the tracker is allocated.  However, the stack trace does not
include the process name.

If a stack trace prints the allocator name, it would be easier to
salvage one syz-executor.X out of several candidates.

  20:58:00 executing program 5:
  ...
  [ 2792.008275][T406785] CPU: 0 PID: 406785 Comm: syz-executor.5

To make debug easier, let's save the task name to ref_tracker and
print it with the stack trace.

Tested with a buggy module [0]:

  # unshare -n insmod ./kern_sk.ko
  kern_sk: loading out-of-tree module taints kernel.
  ref_tracker: net notrefcnt@0000000019e0eaac was allocated by insmod and has 1/1 users at
       sk_alloc+0x498/0x4c0
       inet_create+0x128/0x530
       __sock_create+0x17a/0x3a0
       do_one_initcall+0x57/0x2a0
       do_init_module+0x5f/0x210
       init_module_from_file+0x86/0xc0
       idempotent_init_module+0x178/0x230
       __x64_sys_finit_module+0x56/0x90
       do_syscall_64+0xc4/0x1d0
       entry_SYSCALL_64_after_hwframe+0x46/0x4e

  ------------[ cut here ]------------
  WARNING: CPU: 2 PID: 48 at lib/ref_tracker.c:184 ref_tracker_dir_exit+0xfb/0x160
  Modules linked in: kern_sk(O)
  CPU: 2 PID: 48 Comm: kworker/u16:2 Tainted: G           O       6.9.0-rc1-00371-g48dca48885cd-dirty #8

Link: https://lore.kernel.org/netdev/20221021170154.88207-1-kuniyu@amazon.com/ [0]
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 lib/ref_tracker.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/lib/ref_tracker.c b/lib/ref_tracker.c
index cf5609b1ca79..91c73725acf5 100644
--- a/lib/ref_tracker.c
+++ b/lib/ref_tracker.c
@@ -5,6 +5,7 @@
 #include <linux/export.h>
 #include <linux/list_sort.h>
 #include <linux/ref_tracker.h>
+#include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/stacktrace.h>
 #include <linux/stackdepot.h>
@@ -17,6 +18,7 @@ struct ref_tracker {
 	bool			dead;
 	depot_stack_handle_t	alloc_stack_handle;
 	depot_stack_handle_t	free_stack_handle;
+	char			comm[TASK_COMM_LEN];
 };
 
 struct ref_tracker_dir_stats {
@@ -25,6 +27,7 @@ struct ref_tracker_dir_stats {
 	struct {
 		depot_stack_handle_t stack_handle;
 		unsigned int count;
+		char comm[TASK_COMM_LEN];
 	} stacks[];
 };
 
@@ -54,6 +57,7 @@ ref_tracker_get_stats(struct ref_tracker_dir *dir, unsigned int limit)
 		if (i >= stats->count) {
 			stats->stacks[i].stack_handle = stack;
 			stats->stacks[i].count = 0;
+			memcpy(stats->stacks[i].comm, tracker->comm, TASK_COMM_LEN);
 			++stats->count;
 		}
 		++stats->stacks[i].count;
@@ -107,7 +111,8 @@ __ref_tracker_dir_pr_ostream(struct ref_tracker_dir *dir,
 		stack = stats->stacks[i].stack_handle;
 		if (sbuf && !stack_depot_snprint(stack, sbuf, STACK_BUF_SIZE, 4))
 			sbuf[0] = 0;
-		pr_ostream(s, "%s@%pK has %d/%d users at\n%s\n", dir->name, dir,
+		pr_ostream(s, "%s@%pK was allocated by %s and has %d/%d users at\n%s\n",
+			   dir->name, dir, stats->stacks[i].comm,
 			   stats->stacks[i].count, stats->total, sbuf);
 		skipped -= stats->stacks[i].count;
 	}
@@ -208,6 +213,8 @@ int ref_tracker_alloc(struct ref_tracker_dir *dir,
 	}
 	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 1);
 	tracker->alloc_stack_handle = stack_depot_save(entries, nr_entries, gfp);
+	if (in_task())
+		get_task_comm(tracker->comm, current);
 
 	spin_lock_irqsave(&dir->lock, flags);
 	list_add(&tracker->head, &dir->list);
@@ -244,7 +251,7 @@ int ref_tracker_free(struct ref_tracker_dir *dir,
 	if (tracker->dead) {
 		pr_err("reference already released.\n");
 		if (tracker->alloc_stack_handle) {
-			pr_err("allocated in:\n");
+			pr_err("allocated by %s in:\n", tracker->comm);
 			stack_depot_print(tracker->alloc_stack_handle);
 		}
 		if (tracker->free_stack_handle) {
-- 
2.30.2


