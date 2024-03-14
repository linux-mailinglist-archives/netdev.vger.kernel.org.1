Return-Path: <netdev+bounces-79891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEE287BEB8
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 15:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60D8F1C20BBF
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 14:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6BF6FBB8;
	Thu, 14 Mar 2024 14:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CTePn8kx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9FD6FE06
	for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 14:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710425901; cv=none; b=ZyUChXooJxkO22iarFL4LNhGW0L721le6E+Sbc3NKt0bxsGWfyPAj0Oqq8pGrRmu2832hpeeVVmt+Fc/8PVLasdn3qW5DpjjOTKuofO331hf+11zB7xkBSryM5s0mGQDcES5KSfhdspoAN1JZME5xMaEBklPOPeovIxPOBqIxPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710425901; c=relaxed/simple;
	bh=pjP4WENKr8rRaajWGUR/ri4zzoAy8yOgOfShfJkKBWo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=EZVKKrF2vE1uesjTpeMnJUymKY7yr1C7+IQwdb9Bs7gkF8hQORjcu/aswSLapsJvPQBxqtwFWyHzr6k9Gupy32atmfjS5E1ZwhRng075xgwcKpH8XKEJmzsiURjDtObjY1bdZfp0Si8WPZczvA782AVXOzfbbe8bpFxJv/Iymjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CTePn8kx; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbf216080f5so1412273276.1
        for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 07:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710425898; x=1711030698; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BZp9l6e5lWy9HD+MMXNWuQUDngomkZLkCLaBGKO4JoY=;
        b=CTePn8kx3Shpm+vEBEzTN8rInAwEbqFWdiZojZPw2ji7O+JUIi262o0P6S2AbCeb4v
         5+75yqdvqLFEuSAm1CxdpNK/Rlagernv3HiEwuK3a9BhzsSgkax986AtgaDxDb/1kK8B
         gu8dnpwzDValht66yOrj47gKv7Lx01D+qsMAdz2zyeIOlvhXisY+gKigy2qcm2Qf8YO7
         MWSgLY1AfpCi2OpAK/+tIZC5hBL99hgUSGYxFF5SkOHddVq05jHTCU2yUEPHh5cICtJm
         h6uxqYhGIxX/cYnU01EdnkkYrQV8rKqTF3/MftauRr9Ok25aO0JEvtLNTxg5G8Lm3uLh
         GoFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710425898; x=1711030698;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BZp9l6e5lWy9HD+MMXNWuQUDngomkZLkCLaBGKO4JoY=;
        b=NdGqZJZCsVCl00FrJPhDI6AmtcF5Dc9Pfpp5VyrRQutXStR+xKmC2cNQoYs2SJlzQd
         RbWvHGLN6AHt9o4iydn/TPo+MGWYXs1d7xkSeY1u0/i5bRb3NurlUHvefV9KJWBGmeP5
         YO+W7VN4BsdaUi72H3wi2wr8HwYw6F6+e90dhD0+zZHKJ16Z0JDO4Nc5Zm38gYfzld9/
         VzPbkfMqUvjgFb4r8WVjJPi7BbrPmHJMB5+PxwMCfzB0KPfyGrfyUW7rZKzzCcsXNfgJ
         aCN85Nkhia6YmVmWqR6PFKa2NIiaSzhZYAzzNDiiYU+/moerW/HSYsVbKQA5yAKCjkrN
         bwiA==
X-Gm-Message-State: AOJu0YxN/s4REmFSthwXrp00JsOd8roGXoqJUm9MCjypWwCUC6VDQfsx
	w55ZfzTrwn2WtaNbH9zPrsolOW2kwrtOKHs7eGANz7pBxKKxJMOj6g84nbJ53NFUtCu8aBzFqAy
	nXP9STuyj5w==
X-Google-Smtp-Source: AGHT+IEZARZbi9Qxxiolg+9KvQPeuIJ7hIz8XeqNI/1nxlVaVS3zFkwGXh/Ae/yu+2fjv5QIy6o56fUCC2ZAVg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1026:b0:dc7:5aad:8965 with SMTP
 id x6-20020a056902102600b00dc75aad8965mr539575ybt.0.1710425898449; Thu, 14
 Mar 2024 07:18:18 -0700 (PDT)
Date: Thu, 14 Mar 2024 14:18:16 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240314141816.2640229-1-edumazet@google.com>
Subject: [PATCH net] packet: annotate data-races around ignore_outgoing
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+c669c1136495a2e7c31f@syzkaller.appspotmail.com, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"

ignore_outgoing is read locklessly from dev_queue_xmit_nit()
and packet_getsockopt()

Add appropriate READ_ONCE()/WRITE_ONCE() annotations.

syzbot reported:

BUG: KCSAN: data-race in dev_queue_xmit_nit / packet_setsockopt

write to 0xffff888107804542 of 1 bytes by task 22618 on cpu 0:
 packet_setsockopt+0xd83/0xfd0 net/packet/af_packet.c:4003
 do_sock_setsockopt net/socket.c:2311 [inline]
 __sys_setsockopt+0x1d8/0x250 net/socket.c:2334
 __do_sys_setsockopt net/socket.c:2343 [inline]
 __se_sys_setsockopt net/socket.c:2340 [inline]
 __x64_sys_setsockopt+0x66/0x80 net/socket.c:2340
 do_syscall_64+0xd3/0x1d0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

read to 0xffff888107804542 of 1 bytes by task 27 on cpu 1:
 dev_queue_xmit_nit+0x82/0x620 net/core/dev.c:2248
 xmit_one net/core/dev.c:3527 [inline]
 dev_hard_start_xmit+0xcc/0x3f0 net/core/dev.c:3547
 __dev_queue_xmit+0xf24/0x1dd0 net/core/dev.c:4335
 dev_queue_xmit include/linux/netdevice.h:3091 [inline]
 batadv_send_skb_packet+0x264/0x300 net/batman-adv/send.c:108
 batadv_send_broadcast_skb+0x24/0x30 net/batman-adv/send.c:127
 batadv_iv_ogm_send_to_if net/batman-adv/bat_iv_ogm.c:392 [inline]
 batadv_iv_ogm_emit net/batman-adv/bat_iv_ogm.c:420 [inline]
 batadv_iv_send_outstanding_bat_ogm_packet+0x3f0/0x4b0 net/batman-adv/bat_iv_ogm.c:1700
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0x465/0x990 kernel/workqueue.c:3335
 worker_thread+0x526/0x730 kernel/workqueue.c:3416
 kthread+0x1d1/0x210 kernel/kthread.c:388
 ret_from_fork+0x4b/0x60 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243

value changed: 0x00 -> 0x01

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 27 Comm: kworker/u8:1 Tainted: G        W          6.8.0-syzkaller-08073-g480e035fc4c7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Workqueue: bat_events batadv_iv_send_outstanding_bat_ogm_packet

Fixes: fa788d986a3a ("packet: add sockopt to ignore outgoing packets")
Reported-by: syzbot+c669c1136495a2e7c31f@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/CANn89i+Z7MfbkBLOv=p7KZ7=K1rKHO4P1OL5LYDCtBiyqsa9oQ@mail.gmail.com/T/#t
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
---
 net/core/dev.c         | 2 +-
 net/packet/af_packet.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 0766a245816bdf70f6609dc7b6d694ae81e7a9e5..722787c3275527f1652ec98623f61500ee753b45 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2245,7 +2245,7 @@ void dev_queue_xmit_nit(struct sk_buff *skb, struct net_device *dev)
 	rcu_read_lock();
 again:
 	list_for_each_entry_rcu(ptype, ptype_list, list) {
-		if (ptype->ignore_outgoing)
+		if (READ_ONCE(ptype->ignore_outgoing))
 			continue;
 
 		/* Never send packets back to the socket
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 61270826b9ac73e66f9011c3230d4668f0bf7c77..7cfc7d301508fcead214fbdb4e962b0553a17916 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -4000,7 +4000,7 @@ packet_setsockopt(struct socket *sock, int level, int optname, sockptr_t optval,
 		if (val < 0 || val > 1)
 			return -EINVAL;
 
-		po->prot_hook.ignore_outgoing = !!val;
+		WRITE_ONCE(po->prot_hook.ignore_outgoing, !!val);
 		return 0;
 	}
 	case PACKET_TX_HAS_OFF:
@@ -4134,7 +4134,7 @@ static int packet_getsockopt(struct socket *sock, int level, int optname,
 		       0);
 		break;
 	case PACKET_IGNORE_OUTGOING:
-		val = po->prot_hook.ignore_outgoing;
+		val = READ_ONCE(po->prot_hook.ignore_outgoing);
 		break;
 	case PACKET_ROLLOVER_STATS:
 		if (!po->rollover)
-- 
2.44.0.278.ge034bb2e1d-goog


