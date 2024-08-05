Return-Path: <netdev+bounces-115750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2327947A7E
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 13:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC8DD1F2215A
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 11:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E733B158A06;
	Mon,  5 Aug 2024 11:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="p9Dq5I5p"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DAB1547F2
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 11:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722857746; cv=none; b=jIpfze7D/xEns1ZRBzWTj1hVBbPU/AWyVNvEdQAQvVyn6jGeYKhmW8pw3J8CpfBwyyaY7hz0Pv4QHXlUjjjPvugsIbsdd3lgsq6aLz3jjRcoNKdQ8O3Ix142GGyg69RrmKEvqGvD6/21I6J9dGYhOe9s2n3+WZDMxY5Ob6BBck8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722857746; c=relaxed/simple;
	bh=YYn5wlExZH5dl+Dwy/SKf5yWn48LUILvsk3V6ozgQjY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W/0Dd+cSHj8RcBoEoMcLJzv9srWjB/YZ6Clc/GwOpYPF6xZRouger1zSaBRAPs0VfRMEtogAuI/1KP7YoFzSwXqZb2folZE40KRBspzDrsFFBvUWQDm9qEXsN0LwkjLU1iGxmdlyHFFdS3MynPNUqMzaOm6iEvG2hRj2v9uu4f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=p9Dq5I5p; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:326:9405:f27f:a659])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 52D077DD06;
	Mon,  5 Aug 2024 12:35:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1722857736; bh=YYn5wlExZH5dl+Dwy/SKf5yWn48LUILvsk3V6ozgQjY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20davem@davemloft.net,=0D=0A=09edumazet@google.co
	 m,=0D=0A=09kuba@kernel.org,=0D=0A=09pabeni@redhat.com,=0D=0A=09dsa
	 hern@kernel.org,=0D=0A=09tparkin@katalix.com,=0D=0A=09syzbot+0e85b
	 10481d2f5478053@syzkaller.appspotmail.com|Subject:=20[PATCH=20net-
	 next=209/9]=20l2tp:=20flush=20workqueue=20before=20draining=20it|D
	 ate:=20Mon,=20=205=20Aug=202024=2012:35:33=20+0100|Message-Id:=20<
	 8a3ec43a5a2c294fa04a320e00059c735a759128.1722856576.git.jchapman@k
	 atalix.com>|In-Reply-To:=20<cover.1722856576.git.jchapman@katalix.
	 com>|References:=20<cover.1722856576.git.jchapman@katalix.com>|MIM
	 E-Version:=201.0;
	b=p9Dq5I5pPaZ3xAJIWK/BPYRyui/6cBgfpCW9Yym4t+S83ClYZIpch+Xsy+oyaw1kD
	 d9VgZzpkP7AotVRcGCzeMg2IIgnYGNlR3zv7AqTHLHXsHJ7Oda7J6XtcGbLAWOYqG0
	 LOv1xv+b4GpYLUvO/yAQzBldBFEkEAB4pwo1EQb39tWIPX2NQfdOG/0dxs11vOtz58
	 VaVoyEe0ikJMNMXTsHXtSAj6kEd24euLam4zY8y1QsTnuFX+unxLXGt5yXl8uhQ7qL
	 RLyzCYlkhLEW+MOoFqEqfT2wjTE86p+sEgdWoO7lphcS1+NG1TgwJO4SI+oITQxdPp
	 Qu2J6QtJYZV+w==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	tparkin@katalix.com,
	syzbot+0e85b10481d2f5478053@syzkaller.appspotmail.com
Subject: [PATCH net-next 9/9] l2tp: flush workqueue before draining it
Date: Mon,  5 Aug 2024 12:35:33 +0100
Message-Id: <8a3ec43a5a2c294fa04a320e00059c735a759128.1722856576.git.jchapman@katalix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1722856576.git.jchapman@katalix.com>
References: <cover.1722856576.git.jchapman@katalix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot exposes a race where a net used by l2tp is removed while an
existing pppol2tp socket is closed. In l2tp_pre_exit_net, l2tp queues
TUNNEL_DELETE work items to close each tunnel in the net. When these
are run, new SESSION_DELETE work items are queued to delete each
session in the tunnel. This all happens in drain_workqueue. However,
drain_workqueue allows only new work items if they are queued by other
work items which are already in the queue. If pppol2tp_release runs
after drain_workqueue has started, it may queue a SESSION_DELETE work
item, which results in the warning below in drain_workqueue.

Fix this by flushing the workqueue before drain_workqueue such that
all queued TUNNEL_DELETE work items run before drain_workqueue is
started.

  WARNING: CPU: 1 PID: 5467 at kernel/workqueue.c:2259 __queue_work+0xcd3/0xf50 kernel/workqueue.c:2258
  Modules linked in:
  CPU: 1 UID: 0 PID: 5467 Comm: syz.3.43 Not tainted 6.11.0-rc1-syzkaller-00247-g3608d6aca5e7 #0
  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
  RIP: 0010:__queue_work+0xcd3/0xf50 kernel/workqueue.c:2258
  Code: ff e8 11 84 36 00 90 0f 0b 90 e9 1e fd ff ff e8 03 84 36 00 eb 13 e8 fc 83 36 00 eb 0c e8 f5 83 36 00 eb 05 e8 ee 83 36 00 90 <0f> 0b 90 48 83 c4 60 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc
  RSP: 0018:ffffc90004607b48 EFLAGS: 00010093
  RAX: ffffffff815ce274 RBX: ffff8880661fda00 RCX: ffff8880661fda00
  RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
  RBP: 0000000000000000 R08: ffffffff815cd6d4 R09: 0000000000000000
  R10: ffffc90004607c20 R11: fffff520008c0f85 R12: ffff88802ac33800
  R13: ffff88802ac339c0 R14: dffffc0000000000 R15: 0000000000000008
  FS:  00005555713eb500(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000000000008 CR3: 000000001eda6000 CR4: 00000000003506f0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  Call Trace:
   <TASK>
   queue_work_on+0x1c2/0x380 kernel/workqueue.c:2392
   pppol2tp_release+0x163/0x230 net/l2tp/l2tp_ppp.c:445
   __sock_release net/socket.c:659 [inline]
   sock_close+0xbc/0x240 net/socket.c:1421
   __fput+0x24a/0x8a0 fs/file_table.c:422
   task_work_run+0x24f/0x310 kernel/task_work.c:228
   resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
   exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
   exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
   __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
   syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
   do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
  RIP: 0033:0x7f061e9779f9
  Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
  RSP: 002b:00007ffff1c1fce8 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
  RAX: 0000000000000000 RBX: 000000000001017d RCX: 00007f061e9779f9
  RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
  RBP: 00007ffff1c1fdc0 R08: 0000000000000001 R09: 00007ffff1c1ffcf
  R10: 00007f061e800000 R11: 0000000000000246 R12: 0000000000000032
  R13: 00007ffff1c1fde0 R14: 00007ffff1c1fe00 R15: ffffffffffffffff
  </TASK>

Fixes: 5dfa598b249c ("l2tp: use pre_exit pernet hook to avoid rcu_barrier")
Reported-by: syzbot+0e85b10481d2f5478053@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0e85b10481d2f5478053
Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: Tom Parkin <tparkin@katalix.com>
---
 net/l2tp/l2tp_core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index b3ddaaef396a..ef7803281c90 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1851,8 +1851,16 @@ static __net_exit void l2tp_pre_exit_net(struct net *net)
 	}
 	rcu_read_unlock_bh();
 
-	if (l2tp_wq)
+	if (l2tp_wq) {
+		/* ensure that all TUNNEL_DELETE work items are run before
+		 * draining the work queue since TUNNEL_DELETE requests may
+		 * queue SESSION_DELETE work items for each session in the
+		 * tunnel. drain_workqueue may otherwise warn if SESSION_DELETE
+		 * requests are queued while the work queue is being drained.
+		 */
+		__flush_workqueue(l2tp_wq);
 		drain_workqueue(l2tp_wq);
+	}
 }
 
 static __net_exit void l2tp_exit_net(struct net *net)
-- 
2.34.1


