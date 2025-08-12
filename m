Return-Path: <netdev+bounces-213015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE73B22D66
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 18:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71D7A188B616
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 16:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B5F2F83BD;
	Tue, 12 Aug 2025 16:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ydk08GV4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0211223D7D4
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 16:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755015695; cv=none; b=c9FUc8M9HENCRtlLcshaGoLDGcShoMpis8KoKXAaFszGF14PAtU9NSAsITC7OoTdvjNVAHL/uU7NDpHm7uXRmSt6oMwrx45t/yEvmrNsUXIWXn6W2wIqNvsYbtRJ1KtE5rhxjvdTSl+CJUF/CNpEEjT5ygpoH1s1Mi2HmrSc5j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755015695; c=relaxed/simple;
	bh=+2c1sI2asU8V12zkDju8bdFDYCCHxtgOLf/bQwQhoEc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=b/WmVKDgCfH3JQWVP/PL/n7Wvt0a83DoJLxXyLa8tTO+1GdeRlv7xaja6Tf6BtgvMLLM8kTFYwq6xxaXmmJeq7EVGqa1ikGrs997hacAEMJFRnkbMUEhNzcU9BhvCkdC11mPjvynhxttX42Pk843zAY7Sii32/QeG5rEt3qJ7nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ydk08GV4; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31f74a64da9so6215206a91.2
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 09:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755015693; x=1755620493; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JFgrp1NHzqKg63hes8up32Hvag0Z2dcqZolmCPkVyYI=;
        b=Ydk08GV4KxALnmg9zif7cMJgzcMrVT4pWZGaQ5KXxAIu5y+ppdlz8bHVK1rGnml20h
         /dgYzeqE8snfOr7RsQgz4JdSLHMKVdCTDP6tBxR0pOiIF1qMk2TuCwsKIlF6EV1n2S6Y
         CpyM6pa78WAvaOfQeH9+fB+yFTmlP9bjdu5mWCal78q0bVZur7UFalEc4C1oD/lZWvYd
         IMRcbIgoIea3xisru+puzZiPCuFOA4DSn8qSPBHqT+wguQ5dBudMXvPIJvPj1OSRIbNy
         1QPcqCAfnoFJPEyEB7H1xI5We0vhPN7FpHphkdE7TerFuNEVv/YkehON3n1WJhd9+YMg
         mixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755015693; x=1755620493;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JFgrp1NHzqKg63hes8up32Hvag0Z2dcqZolmCPkVyYI=;
        b=wBS3Sn0qjyXtqXf6zePRfRyyDevlA0tu/aSZQBi2S65GpFkoiYxGtF6UlNKxM8L8cM
         RPeOwnhhf+nw7BD/oKzaFgFuMT1groSP3YkmzTC6zctdoAAbXZpBaR40rDeJFraqEQqZ
         owLfXs+TMN3hEXaH+eWnzmJc+GLa7nL8i56jTuk9wUrUYKwlNwS0jM/p0Sh6kaI/YWjG
         2crWUdQ4Tf6iLftAnlLW/r8Gs7koV+Q0yrfvHMOt/jIcX3cAEDuz0IXccrfejRdXArKY
         BPz3LJl0PFCCDkxaaTF0sTjYE4yTRsHB5U2+gd/tz4Y3NhrmscvuPDJzAhIryfIx6edi
         rp7w==
X-Forwarded-Encrypted: i=1; AJvYcCWUJ10ZTC9KsrR6p+ZSGJXd4/3GbryWhUL29vWh1U4SElAcgUEyHaVByh/vGFA3u30qAWuE4ss=@vger.kernel.org
X-Gm-Message-State: AOJu0YzklR3HJ8YJMQbvvU2ECASPsNzw1C3BmOur1rUobudkBP0bBvnx
	Ey3sIWyIeNafBIUvHe56mDSY0dxemeUE5lJdeKVLDl1arl3KFJLaHMmrM2LB5DxHWx0AU5/SWTN
	furb66w==
X-Google-Smtp-Source: AGHT+IHcR01WgyBw3S+GjDewM87RZyznLxXypvX33G0YuvGMLmphDhbNjgHwxV9zRgKQTbaWYhbdfW47n6Q=
X-Received: from pjzd15.prod.google.com ([2002:a17:90a:e28f:b0:312:151d:c818])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e7c2:b0:311:df4b:4b93
 with SMTP id 98e67ed59e1d1-321cf8a4b0dmr238520a91.7.1755015693210; Tue, 12
 Aug 2025 09:21:33 -0700 (PDT)
Date: Tue, 12 Aug 2025 16:21:26 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc0.205.g4a044479a3-goog
Message-ID: <20250812162130.4129322-1-kuniyu@google.com>
Subject: [PATCH v2 net] netdevsim: Fix wild pointer access in nsim_queue_free().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Breno Leitao <leitao@debian.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+8aa80c6232008f7b957d@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot reported the splat below. [0]

When nsim_queue_uninit() is called from nsim_init_netdevsim(),
register_netdevice() has not been called, thus dev->dstats has
not been allocated.

Let's not call dev_dstats_rx_dropped_add() in such a case.

[0]
BUG: unable to handle page fault for address: ffff88809782c020
 PF: supervisor write access in kernel mode
 PF: error_code(0x0002) - not-present page
PGD 1b401067 P4D 1b401067 PUD 0
Oops: Oops: 0002 [#1] SMP KASAN NOPTI
CPU: 3 UID: 0 PID: 8476 Comm: syz.1.251 Not tainted 6.16.0-syzkaller-06699-ge8d780dcd957 #0 PREEMPT(full)
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:local_add arch/x86/include/asm/local.h:33 [inline]
RIP: 0010:u64_stats_add include/linux/u64_stats_sync.h:89 [inline]
RIP: 0010:dev_dstats_rx_dropped_add include/linux/netdevice.h:3027 [inline]
RIP: 0010:nsim_queue_free+0xba/0x120 drivers/net/netdevsim/netdev.c:714
Code: 07 77 6c 4a 8d 3c ed 20 7e f1 8d 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 46 4a 03 1c ed 20 7e f1 8d <4c> 01 63 20 be 00 02 00 00 48 8d 3d 00 00 00 00 e8 61 2f 58 fa 48
RSP: 0018:ffffc900044af150 EFLAGS: 00010286
RAX: dffffc0000000000 RBX: ffff88809782c000 RCX: 00000000000079c3
RDX: 1ffffffff1be2fc7 RSI: ffffffff8c15f380 RDI: ffffffff8df17e38
RBP: ffff88805f59d000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000003 R14: ffff88806ceb3d00 R15: ffffed100dfd308e
FS:  0000000000000000(0000) GS:ffff88809782c000(0063) knlGS:00000000f505db40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: ffff88809782c020 CR3: 000000006fc6a000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 nsim_queue_uninit drivers/net/netdevsim/netdev.c:993 [inline]
 nsim_init_netdevsim drivers/net/netdevsim/netdev.c:1049 [inline]
 nsim_create+0xd0a/0x1260 drivers/net/netdevsim/netdev.c:1101
 __nsim_dev_port_add+0x435/0x7d0 drivers/net/netdevsim/dev.c:1438
 nsim_dev_port_add_all drivers/net/netdevsim/dev.c:1494 [inline]
 nsim_dev_reload_create drivers/net/netdevsim/dev.c:1546 [inline]
 nsim_dev_reload_up+0x5b8/0x860 drivers/net/netdevsim/dev.c:1003
 devlink_reload+0x322/0x7c0 net/devlink/dev.c:474
 devlink_nl_reload_doit+0xe31/0x1410 net/devlink/dev.c:584
 genl_family_rcv_msg_doit+0x206/0x2f0 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x55c/0x800 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x155/0x420 net/netlink/af_netlink.c:2552
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x5aa/0x870 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg net/socket.c:729 [inline]
 ____sys_sendmsg+0xa95/0xc70 net/socket.c:2614
 ___sys_sendmsg+0x134/0x1d0 net/socket.c:2668
 __sys_sendmsg+0x16d/0x220 net/socket.c:2700
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
 __do_fast_syscall_32+0x7c/0x3a0 arch/x86/entry/syscall_32.c:306
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/syscall_32.c:331
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf708e579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f505d55c EFLAGS: 00000296 ORIG_RAX: 0000000000000172
RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 0000000080000080
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000296 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
CR2: ffff88809782c020

Fixes: 2a68a22304f9 ("netdevsim: account dropped packet length in stats on queue free")
Reported-by: syzbot+8aa80c6232008f7b957d@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/688bb9ca.a00a0220.26d0e1.0050.GAE@google.com/
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2: Use qlen to avoid unnecessary stat change
v1: https://lore.kernel.org/all/20250731184829.1433735-1-kuniyu@google.com/
---
 drivers/net/netdevsim/netdev.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 39fe28af48b9..0178219f0db5 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -710,9 +710,13 @@ static struct nsim_rq *nsim_queue_alloc(void)
 static void nsim_queue_free(struct net_device *dev, struct nsim_rq *rq)
 {
 	hrtimer_cancel(&rq->napi_timer);
-	local_bh_disable();
-	dev_dstats_rx_dropped_add(dev, rq->skb_queue.qlen);
-	local_bh_enable();
+
+	if (rq->skb_queue.qlen) {
+		local_bh_disable();
+		dev_dstats_rx_dropped_add(dev, rq->skb_queue.qlen);
+		local_bh_enable();
+	}
+
 	skb_queue_purge_reason(&rq->skb_queue, SKB_DROP_REASON_QUEUE_PURGE);
 	kfree(rq);
 }
-- 
2.51.0.rc0.205.g4a044479a3-goog


