Return-Path: <netdev+bounces-211259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C2CB17632
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 20:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C1757B8048
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 18:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CF724FBFF;
	Thu, 31 Jul 2025 18:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QBXuyeu1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5903119BBA
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 18:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753987714; cv=none; b=PuCGc2OEGWO/z/s9aHNGfI7SlS1+iJM7+ThicQCkorILL/p5MhcPHyfBqrPVZ2Z0a8ajgV2cHXT9v3l/qwoCXXzY7l+BCYVWG3RJO+3SEu4bF0zXp8rOPhLH5vstc72SKHFcAupnWyOoz04x/Bf4XZXdL3JE5TPjqgmdpBcALnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753987714; c=relaxed/simple;
	bh=a+x32HW6VeZ/KqvfD2x5JZClclUI+LztLiF6MfDNQm4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZLl0hnx+J5BhpKh+CnWDtLUp8X/Djz2CXK/00NSwlC87ZJhWB9rb+VaZZ/aXVS4pCMR52Gcjdto4YWgnAtW6ycUGG18mS4dV7Jx2+0hY6zjmgperH1odsXFhSzX8SwyZQmxTCrMNMs6806F3yY1zpda7WyFtzorcMJqT2ho3tuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QBXuyeu1; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b321087b1cdso1128120a12.2
        for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 11:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753987712; x=1754592512; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EcXl82IVDw8rOkSN5ix4c/KJz7UE6+CFMqsrXqYNCUM=;
        b=QBXuyeu1wrgQa2K44xLjAMhg6NQOEItTa9Jfs7+Or6O7bSo2ci4ENBTxerq3wE4kVh
         NPPqrFR4bfeXQWqzf0RDSH8wMJ1WU2vZrBZCm2DZMZRDWUn2qcCus0rqB057thQE3gSc
         tUOF7oocsnkCG+Hx/ouJbBgQ1o0iy2rIjRqVlX0rmJCkkxATHsDJcJZfBJ/2okyGJqOZ
         5JN8X6y2osHKyCKFz9mHS7cl+66KLRLn11C2TlT6cgpRvYKx5On0zLsp4QB4cBzT0QbK
         p1W7Hh3+s/qa9WBfDVnaWM5jXHujH7lWQH8wcaHBXnd0wAG/5ChMhd00jet/sHmTaAYQ
         ajpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753987712; x=1754592512;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EcXl82IVDw8rOkSN5ix4c/KJz7UE6+CFMqsrXqYNCUM=;
        b=D81kLn/sZcI5/CTHYjfyNDzXLkpOgaVI6VmOs0P7O3hz8cZT2OdYK2fG9nqxjgIU05
         Al/Fnu0rnofj4CC0TZK++laTCdbcT6rn2+oq7ptBZp07iJIlFG9CinC/HaJmzhQXF8rq
         LNjfN4hyLVqWIyQUQHvsneb5LooBYKOkKrzygmgRPZreztkqivw7b/aGUKXmQ4Z7FgOX
         xP519kkOZc6QwFpNbXpE3grB3RqbbxRvzPGu4npX+ap/64hC60ogXT5nYN5LNNZNwmKx
         SvOPRQf09yb6rIeTdXcXIABNouNHc2MGW0UoTmV2BtWqO74p4qb6xfOOGf/GPNJf0dgi
         cqFg==
X-Forwarded-Encrypted: i=1; AJvYcCV7EEYhQi5haUi93Cpr0fyBcAMe9KBhhXXV90wgp0aE2C/IEcyHBWRXET+9rhRbJEOc/ZL0bDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxylkVCwavG8cKFqIhdzknWKFWp+mbiZ1XfWFoZgpwne5Ku8wkc
	Ha8OND6PcQkFf6Ng80oZGNco2IK9i+yBGS3mqN5x8IxP0U5Ctxoh5Z5to877LsnvuI7ho2e5nLK
	lADduAA==
X-Google-Smtp-Source: AGHT+IFKj+XYitACTdfG95FHlFbKi73x48vr5ewgG7Ra8S3ZmXaJrYZnBmifni2dlCH6doCW8V+tMTKc1ac=
X-Received: from pfck16-n1.prod.google.com ([2002:a05:6a00:a050:10b0:746:1a2e:b29b])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7f93:b0:215:d611:5d9b
 with SMTP id adf61e73a8af0-23dc0d7870fmr11525094637.12.1753987712600; Thu, 31
 Jul 2025 11:48:32 -0700 (PDT)
Date: Thu, 31 Jul 2025 18:48:13 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250731184829.1433735-1-kuniyu@google.com>
Subject: [PATCH v1 net] netdevsim: Fix wild pointer access in nsim_queue_free().
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
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/net/netdevsim/netdev.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 39fe28af48b9..5cbc005136d8 100644
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
+	if (likely(dev->reg_state != NETREG_UNINITIALIZED)) {
+		local_bh_disable();
+		dev_dstats_rx_dropped_add(dev, rq->skb_queue.qlen);
+		local_bh_enable();
+	}
+
 	skb_queue_purge_reason(&rq->skb_queue, SKB_DROP_REASON_QUEUE_PURGE);
 	kfree(rq);
 }
-- 
2.50.1.565.gc32cd1483b-goog


