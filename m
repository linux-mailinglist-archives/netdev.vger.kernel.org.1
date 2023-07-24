Return-Path: <netdev+bounces-20467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF5275FA58
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 17:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38C7D1C20B1F
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 15:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19993D505;
	Mon, 24 Jul 2023 15:01:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080C9DDDA
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 15:01:50 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6817310F5
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 08:01:48 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qNx4E-0004s2-RH
	for netdev@vger.kernel.org; Mon, 24 Jul 2023 17:01:46 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 45F421F8A4E
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 15:01:46 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id BBE381F8A39;
	Mon, 24 Jul 2023 15:01:43 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 3ea39e95;
	Mon, 24 Jul 2023 15:01:43 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Eric Dumazet <edumazet@google.com>,
	syzbot <syzkaller@googlegroups.com>,
	Ziyang Xuan <william.xuanziyang@huawei.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 2/2] can: raw: fix lockdep issue in raw_release()
Date: Mon, 24 Jul 2023 17:01:41 +0200
Message-Id: <20230724150141.766047-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230724150141.766047-1-mkl@pengutronix.de>
References: <20230724150141.766047-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Eric Dumazet <edumazet@google.com>

syzbot complained about a lockdep issue [1]

Since raw_bind() and raw_setsockopt() first get RTNL
before locking the socket, we must adopt the same order in raw_release()

[1]
WARNING: possible circular locking dependency detected
6.5.0-rc1-syzkaller-00192-g78adb4bcf99e #0 Not tainted
------------------------------------------------------
syz-executor.0/14110 is trying to acquire lock:
ffff88804e4b6130 (sk_lock-AF_CAN){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1708 [inline]
ffff88804e4b6130 (sk_lock-AF_CAN){+.+.}-{0:0}, at: raw_bind+0xb1/0xab0 net/can/raw.c:435

but task is already holding lock:
ffffffff8e3df368 (rtnl_mutex){+.+.}-{3:3}, at: raw_bind+0xa7/0xab0 net/can/raw.c:434

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #1 (rtnl_mutex){+.+.}-{3:3}:
__mutex_lock_common kernel/locking/mutex.c:603 [inline]
__mutex_lock+0x181/0x1340 kernel/locking/mutex.c:747
raw_release+0x1c6/0x9b0 net/can/raw.c:391
__sock_release+0xcd/0x290 net/socket.c:654
sock_close+0x1c/0x20 net/socket.c:1386
__fput+0x3fd/0xac0 fs/file_table.c:384
task_work_run+0x14d/0x240 kernel/task_work.c:179
resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
exit_to_user_mode_prepare+0x210/0x240 kernel/entry/common.c:204
__syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:297
do_syscall_64+0x44/0xb0 arch/x86/entry/common.c:86
entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (sk_lock-AF_CAN){+.+.}-{0:0}:
check_prev_add kernel/locking/lockdep.c:3142 [inline]
check_prevs_add kernel/locking/lockdep.c:3261 [inline]
validate_chain kernel/locking/lockdep.c:3876 [inline]
__lock_acquire+0x2e3d/0x5de0 kernel/locking/lockdep.c:5144
lock_acquire kernel/locking/lockdep.c:5761 [inline]
lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5726
lock_sock_nested+0x3a/0xf0 net/core/sock.c:3492
lock_sock include/net/sock.h:1708 [inline]
raw_bind+0xb1/0xab0 net/can/raw.c:435
__sys_bind+0x1ec/0x220 net/socket.c:1792
__do_sys_bind net/socket.c:1803 [inline]
__se_sys_bind net/socket.c:1801 [inline]
__x64_sys_bind+0x72/0xb0 net/socket.c:1801
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

Possible unsafe locking scenario:

CPU0 CPU1
---- ----
lock(rtnl_mutex);
        lock(sk_lock-AF_CAN);
        lock(rtnl_mutex);
lock(sk_lock-AF_CAN);

*** DEADLOCK ***

1 lock held by syz-executor.0/14110:

stack backtrace:
CPU: 0 PID: 14110 Comm: syz-executor.0 Not tainted 6.5.0-rc1-syzkaller-00192-g78adb4bcf99e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
Call Trace:
<TASK>
__dump_stack lib/dump_stack.c:88 [inline]
dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
check_noncircular+0x311/0x3f0 kernel/locking/lockdep.c:2195
check_prev_add kernel/locking/lockdep.c:3142 [inline]
check_prevs_add kernel/locking/lockdep.c:3261 [inline]
validate_chain kernel/locking/lockdep.c:3876 [inline]
__lock_acquire+0x2e3d/0x5de0 kernel/locking/lockdep.c:5144
lock_acquire kernel/locking/lockdep.c:5761 [inline]
lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5726
lock_sock_nested+0x3a/0xf0 net/core/sock.c:3492
lock_sock include/net/sock.h:1708 [inline]
raw_bind+0xb1/0xab0 net/can/raw.c:435
__sys_bind+0x1ec/0x220 net/socket.c:1792
__do_sys_bind net/socket.c:1803 [inline]
__se_sys_bind net/socket.c:1801 [inline]
__x64_sys_bind+0x72/0xb0 net/socket.c:1801
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fd89007cb29
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd890d2a0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000031
RAX: ffffffffffffffda RBX: 00007fd89019bf80 RCX: 00007fd89007cb29
RDX: 0000000000000010 RSI: 0000000020000040 RDI: 0000000000000003
RBP: 00007fd8900c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fd89019bf80 R15: 00007ffebf8124f8
</TASK>

Fixes: ee8b94c8510c ("can: raw: fix receiver memory leak")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Ziyang Xuan <william.xuanziyang@huawei.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: stable@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Link: https://lore.kernel.org/all/20230720114438.172434-1-edumazet@google.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/raw.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/can/raw.c b/net/can/raw.c
index 2302e4882967..ba6b52b1d776 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -386,9 +386,9 @@ static int raw_release(struct socket *sock)
 	list_del(&ro->notifier);
 	spin_unlock(&raw_notifier_lock);
 
+	rtnl_lock();
 	lock_sock(sk);
 
-	rtnl_lock();
 	/* remove current filters & unregister */
 	if (ro->bound) {
 		if (ro->dev)
@@ -405,12 +405,13 @@ static int raw_release(struct socket *sock)
 	ro->dev = NULL;
 	ro->count = 0;
 	free_percpu(ro->uniq);
-	rtnl_unlock();
 
 	sock_orphan(sk);
 	sock->sk = NULL;
 
 	release_sock(sk);
+	rtnl_unlock();
+
 	sock_put(sk);
 
 	return 0;
-- 
2.40.1



