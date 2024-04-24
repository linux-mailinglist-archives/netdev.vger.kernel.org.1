Return-Path: <netdev+bounces-90735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E998AFDD0
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 03:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC96C1F213B0
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 01:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326D56112;
	Wed, 24 Apr 2024 01:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="kyrqHui2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D9D1BF2B
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 01:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713922029; cv=none; b=SoJhGu5Rj1G3ZSPtas6AsOXa+MPj5Ws+2VdRl996TPGswhcXziDJw3DESWoplOV+5g/jc8agjfyaC9KMiAEy50u6jHB9/uD7u7hty20J3HR8iH1ZCDhMpR+kpdRnwfKqFpDOHELgP6g+nn77yHqkWY3aH2OLt3sZRuKvRbXZWL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713922029; c=relaxed/simple;
	bh=jrmH7ajdxZ7Q2wiqxFjY9Tj/yKzJZakkbbjUAo5vkOk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H0xldN48yEE4uT37orSpsMOW9VS3XSvZ9dJVIbrI1lwWScakrsWB9skfp3mpluqIxN2sjnLqj6geU/Ba8cIXEI8KLFNr5U++Yr3iVhPSpy+n5fYQJmrTHVkCameYMHmvB1GwsmeZee7SYqS/H70DtFRKHEpKgYuW+5XsBWKQs0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=kyrqHui2; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1713922028; x=1745458028;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KTPBHs47G4Fp/38NBIdkwsWKHLYagvcARF9irqGfNfo=;
  b=kyrqHui2ntHwdaqm++K4b20uVMHHQE2HywUdSZp9Qg8X4QUsDOZhmSns
   cJ8dab3uS708ab0MoTNujhpK69d1NXR62I+zInoKyO4qQ944k0ykc44U/
   8/NvVGg6KndFPrihmWGMRNPmrKSpSyPbzUs9i8zyiZ2m0p6A3bifibFst
   c=;
X-IronPort-AV: E=Sophos;i="6.07,222,1708387200"; 
   d="scan'208";a="721065259"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 01:27:02 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:43792]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.56:2525] with esmtp (Farcaster)
 id e71157f1-4211-4f76-9f99-fcee1bf6af40; Wed, 24 Apr 2024 01:27:01 +0000 (UTC)
X-Farcaster-Flow-ID: e71157f1-4211-4f76-9f99-fcee1bf6af40
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 24 Apr 2024 01:27:00 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.62) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 24 Apr 2024 01:26:58 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Michal Luczaj <mhal@rbox.co>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>,
	<syzbot+fa379358c28cc87cc307@syzkaller.appspotmail.com>
Subject: [PATCH v1 net-next] af_unix: Suppress false-positive lockdep splat for spin_lock() in __unix_gc().
Date: Tue, 23 Apr 2024 18:26:48 -0700
Message-ID: <20240424012648.15553-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA002.ant.amazon.com (10.13.139.113) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

syzbot reported a lockdep splat regarding unix_gc_lock() and
unix_state_lock().

One is called from recvmsg() for a connected socket, and another
is called from GC for TCP_LISTEN socket.

So, the splat is false-positive.

Let's add a dedicated lock class for the latter to suppress the splat.

Note that this change is not necessary for net-next.git as the issue
is only applied to the old GC impl.

[0]:
WARNING: possible circular locking dependency detected
6.9.0-rc5-syzkaller-00007-g4d2008430ce8 #0 Not tainted
 -----------------------------------------------------
kworker/u8:1/11 is trying to acquire lock:
ffff88807cea4e70 (&u->lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
ffff88807cea4e70 (&u->lock){+.+.}-{2:2}, at: __unix_gc+0x40e/0xf70 net/unix/garbage.c:302

but task is already holding lock:
ffffffff8f6ab638 (unix_gc_lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
ffffffff8f6ab638 (unix_gc_lock){+.+.}-{2:2}, at: __unix_gc+0x117/0xf70 net/unix/garbage.c:261

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

 -> #1 (unix_gc_lock){+.+.}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
       _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
       spin_lock include/linux/spinlock.h:351 [inline]
       unix_notinflight+0x13d/0x390 net/unix/garbage.c:140
       unix_detach_fds net/unix/af_unix.c:1819 [inline]
       unix_destruct_scm+0x221/0x350 net/unix/af_unix.c:1876
       skb_release_head_state+0x100/0x250 net/core/skbuff.c:1188
       skb_release_all net/core/skbuff.c:1200 [inline]
       __kfree_skb net/core/skbuff.c:1216 [inline]
       kfree_skb_reason+0x16d/0x3b0 net/core/skbuff.c:1252
       kfree_skb include/linux/skbuff.h:1262 [inline]
       manage_oob net/unix/af_unix.c:2672 [inline]
       unix_stream_read_generic+0x1125/0x2700 net/unix/af_unix.c:2749
       unix_stream_splice_read+0x239/0x320 net/unix/af_unix.c:2981
       do_splice_read fs/splice.c:985 [inline]
       splice_file_to_pipe+0x299/0x500 fs/splice.c:1295
       do_splice+0xf2d/0x1880 fs/splice.c:1379
       __do_splice fs/splice.c:1436 [inline]
       __do_sys_splice fs/splice.c:1652 [inline]
       __se_sys_splice+0x331/0x4a0 fs/splice.c:1634
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

 -> #0 (&u->lock){+.+.}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
       _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
       spin_lock include/linux/spinlock.h:351 [inline]
       __unix_gc+0x40e/0xf70 net/unix/garbage.c:302
       process_one_work kernel/workqueue.c:3254 [inline]
       process_scheduled_works+0xa10/0x17c0 kernel/workqueue.c:3335
       worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
       kthread+0x2f0/0x390 kernel/kthread.c:388
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(unix_gc_lock);
                               lock(&u->lock);
                               lock(unix_gc_lock);
  lock(&u->lock);

 *** DEADLOCK ***

3 locks held by kworker/u8:1/11:
 #0: ffff888015089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3229 [inline]
 #0: ffff888015089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x8e0/0x17c0 kernel/workqueue.c:3335
 #1: ffffc90000107d00 (unix_gc_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3230 [inline]
 #1: ffffc90000107d00 (unix_gc_work){+.+.}-{0:0}, at: process_scheduled_works+0x91b/0x17c0 kernel/workqueue.c:3335
 #2: ffffffff8f6ab638 (unix_gc_lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #2: ffffffff8f6ab638 (unix_gc_lock){+.+.}-{2:2}, at: __unix_gc+0x117/0xf70 net/unix/garbage.c:261

stack backtrace:
CPU: 0 PID: 11 Comm: kworker/u8:1 Not tainted 6.9.0-rc5-syzkaller-00007-g4d2008430ce8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: events_unbound __unix_gc
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 __unix_gc+0x40e/0xf70 net/unix/garbage.c:302
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa10/0x17c0 kernel/workqueue.c:3335
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Fixes: 47d8ac011fe1 ("af_unix: Fix garbage collector racing against connect()")
Reported-and-tested-by: syzbot+fa379358c28cc87cc307@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fa379358c28cc87cc307
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/af_unix.h | 3 +++
 net/unix/garbage.c    | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 627ea8e2d915..3dee0b2721aa 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -85,6 +85,9 @@ enum unix_socket_lock_class {
 	U_LOCK_NORMAL,
 	U_LOCK_SECOND,	/* for double locking, see unix_state_double_lock(). */
 	U_LOCK_DIAG, /* used while dumping icons, see sk_diag_dump_icons(). */
+	U_LOCK_GC_LISTENER, /* used for listening socket while determining gc
+			     * candidates to close a small race window.
+			     */
 };
 
 static inline void unix_state_lock_nested(struct sock *sk,
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 6433a414acf8..0104be9d4704 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -299,7 +299,7 @@ static void __unix_gc(struct work_struct *work)
 			__set_bit(UNIX_GC_MAYBE_CYCLE, &u->gc_flags);
 
 			if (sk->sk_state == TCP_LISTEN) {
-				unix_state_lock(sk);
+				unix_state_lock_nested(sk, U_LOCK_GC_LISTENER);
 				unix_state_unlock(sk);
 			}
 		}
-- 
2.30.2


