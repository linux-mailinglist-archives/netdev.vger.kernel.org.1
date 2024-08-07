Return-Path: <netdev+bounces-116339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E6E94A12B
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 08:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34597B25E11
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 06:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0961BB695;
	Wed,  7 Aug 2024 06:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="JSyPeB8G"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8A11B8EAD
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 06:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723013699; cv=none; b=Qx3L/Zkhy+ETGNRI1NVzZ9A/HHFgVhauiqyIeUeQG/QXR1wQP5wPyKJVCMW6of2lZjQNwXbpQ8zYf3flie8ZcsrYeJuwkMrRKaUz69WgGOX1r2xP8s9WxC1TYH2ZGc+nDl8DQp+cFo4PgN5bp0VivJLAFHovF66MhiofQ6Y3QBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723013699; c=relaxed/simple;
	bh=1yMTD/417RPcS+8ou5rLDaGBrAzPUbW5Q1Phth/46Ws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tB5AiHP8vMbczByxEiEvyQZ6mrsfpS4Wp372lZ5sM46UyvYjhhd/LczKxzCMd6NGMuuQzcg4GxmmIDNJYrz79c2QzfUx18FAqOv/a7sDaFCtQMKXb9rbMprZLcUfysVexQ7Qa+Ft6s6RKBa1s3x4/f1BA2wexpJV/2b5802sJQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=JSyPeB8G; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:9ea4:d72e:1b25:b4bf])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 6DD287DD0A;
	Wed,  7 Aug 2024 07:54:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1723013695; bh=1yMTD/417RPcS+8ou5rLDaGBrAzPUbW5Q1Phth/46Ws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20davem@davemloft.net,=0D=0A=09edumazet@google.co
	 m,=0D=0A=09kuba@kernel.org,=0D=0A=09pabeni@redhat.com,=0D=0A=09dsa
	 hern@kernel.org,=0D=0A=09tparkin@katalix.com,=0D=0A=09horms@kernel
	 .org,=0D=0A=09syzbot+0e85b10481d2f5478053@syzkaller.appspotmail.co
	 m|Subject:=20[PATCH=20v2=20net-next=209/9]=20l2tp:=20flush=20workq
	 ueue=20before=20draining=20it|Date:=20Wed,=20=207=20Aug=202024=200
	 7:54:52=20+0100|Message-Id:=20<2bdc4b63a4caea153f614c1f041f2ac3492
	 044ed.1723011569.git.jchapman@katalix.com>|In-Reply-To:=20<cover.1
	 723011569.git.jchapman@katalix.com>|References:=20<cover.172301156
	 9.git.jchapman@katalix.com>|MIME-Version:=201.0;
	b=JSyPeB8GP8iva0ZsETX22aq4+EsXv2xdQXM/vIGLZdBqVBR683UhxOtIi6nFrjR1a
	 NX92jpogoFdH/hyvHtAHkVTcy2MYJg56ZUPEIZ3ZW3tFb6ejXC1+/DgUc00fWnMOFo
	 nTfQ9fpYUiYPxHbH65P4aF7Fpu0V1qRZL9LYGGmsGYrJZ1oYrHBx8RG9wOH4yVFsNJ
	 XDsVEjpFersarsAQoZ3psU4SY6niXnmyO8UZHWg7Eom2+ICokcvVDx/YvOG2X8pz9O
	 V+8QpbUL+ArwDJWOISZ8fKM8RwqJKwfLZZtIceq8wb2ZVj9ysmjxYIbRbkEzU10UFj
	 utRhEE/fR0cdw==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	tparkin@katalix.com,
	horms@kernel.org,
	syzbot+0e85b10481d2f5478053@syzkaller.appspotmail.com
Subject: [PATCH v2 net-next 9/9] l2tp: flush workqueue before draining it
Date: Wed,  7 Aug 2024 07:54:52 +0100
Message-Id: <2bdc4b63a4caea153f614c1f041f2ac3492044ed.1723011569.git.jchapman@katalix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1723011569.git.jchapman@katalix.com>
References: <cover.1723011569.git.jchapman@katalix.com>
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

Address this by flushing the workqueue before drain_workqueue such
that all queued TUNNEL_DELETE work items run before drain_workqueue is
started. This will queue SESSION_DELETE work items for each session in
the tunnel, hence pppol2tp_release or other API requests won't queue
SESSION_DELETE requests once drain_workqueue is started.

  WARNING: CPU: 1 PID: 5467 at kernel/workqueue.c:2259 __queue_work+0xcd3/0xf50 kernel/workqueue.c:2258
  Modules linked in:
  CPU: 1 UID: 0 PID: 5467 Comm: syz.3.43 Not tainted 6.11.0-rc1-syzkaller-00247-g3608d6aca5e7 #0
  Hardware name: Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
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

Fixes: fc7ec7f554d7 ("l2tp: delete sessions using work queue")
Reported-by: syzbot+0e85b10481d2f5478053@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0e85b10481d2f5478053
Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: Tom Parkin <tparkin@katalix.com>
---
 net/l2tp/l2tp_core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 6ef1c80bb3bf..ddcf07d85877 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1844,8 +1844,16 @@ static __net_exit void l2tp_pre_exit_net(struct net *net)
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


