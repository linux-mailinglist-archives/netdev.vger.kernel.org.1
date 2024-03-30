Return-Path: <netdev+bounces-83510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59895892BE6
	for <lists+netdev@lfdr.de>; Sat, 30 Mar 2024 16:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A0D82827D0
	for <lists+netdev@lfdr.de>; Sat, 30 Mar 2024 15:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BB038F84;
	Sat, 30 Mar 2024 15:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JpIRs6Pi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB301C0DEF
	for <netdev@vger.kernel.org>; Sat, 30 Mar 2024 15:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711814082; cv=none; b=PeZPqSrh73IQysY8ux6a+CyEFT0Vfr2jGSAD1w3AHzxrOoRaUEnmm61YXsEYaWeqPP0wqxFhv7+V04vlYwlZLFKIt9Mnd5GSZNNcVyAWF1ngWFN7QviawufMkCc4Ka1TvQolrMUQAkKlMsmeZMkdO8Aaw4Kq4DyNinvCHedxfXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711814082; c=relaxed/simple;
	bh=S68HL3CFOxnsPBzCmCkKy6vtamevZ5S1Jmc1PGM5ID4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=n3bEpkiyHxqJYsvPttxpU0EZ58keV22w97IpDXXifdYqio6wizBejb9Jpn+ZvMhV2U2GXz2gGlebS2v4i42TBMmO4YpKHZbfuPh9xZRjrF7+Wr4GDKJYeMrQMVIc7UhiX5j6qMC06zJ6XATjiAkeIOtcTMANk/RpyojRBJo6RDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JpIRs6Pi; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6148da519efso4191717b3.2
        for <netdev@vger.kernel.org>; Sat, 30 Mar 2024 08:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711814080; x=1712418880; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dBL/ljz5qtMkaFmqNOK6k+Oflk/0oSx1QZlDLwvmaAQ=;
        b=JpIRs6Pimkf2dMZEMEfUIf+JFbL//yiTsngXBbG7gZgrteUbOv9zgkTPgz5W0r2TIK
         F2KsyKl2HjDbvw5c0mSyXssW0DbnhqxUjjh8sdwckpWjMe4XZVJhomJ9W1x0Gr9KUuBg
         cIjblftMS38OX6H0Jsanrx/1tqCDXNEVPSSOgkR3fshEIUoFLxQZ2tZurGbdKbYuCWd8
         2t7n5727vumXdX1UonEIl2YeQsh/O+EMu0/RiunAhOxXllKGN2ynYt10eRnIe33nIL6K
         Zly2yo57vNs+NsfleELpi+dW8HLJhckkSuNViHd/pWTQBZi+eKkcoWpgy77K7nv74hx+
         xHag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711814080; x=1712418880;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dBL/ljz5qtMkaFmqNOK6k+Oflk/0oSx1QZlDLwvmaAQ=;
        b=Jwvv9aj9nOmdG/yUnbqe0+9PuW7I/10YQ+qx5Krs4Cj8KchQ9CoW8OP1xh+Cf29pdK
         7tr6TwtQnLP2ci/6fpbwwkDAmUDvRhd+KyXUcChhU00jWWOdAmHFZW7suHNDPMB3wPs7
         iQt71ROosITHNCMm25Sz9PlzvSNXRaqRcohr/lqaz/mtnG56Quagsd4/+Whu7GoIsFwa
         tRPeo6vFZOpbEGOiZNYLSOU9XC2pABcSPlAcqucia0ajn6ZFUjgCY5slNItrJKAIaLLl
         ACtaKbYS153zmdjGOatgokrriFtFMu2WeAW8gNgKs2EN5Qgd9FZ9k4zfwrU0NckAn5dI
         y6lA==
X-Gm-Message-State: AOJu0Yypg2WCuRdQJwTiU8ebd49wrVdbR48R8mb+4a/f37nuswSUWLG4
	9hKFSp6BF+hQR4QxO1kXZzRE95JrTJkO2iwX0Le6bRlsoM9mO7vJkfsYl7abWbg5W9/f/od+71z
	fYxFnOCYkPA==
X-Google-Smtp-Source: AGHT+IFnx49Ds8YEyIdrJP/ioajvFA9z+emTWuNzEowKInCbLKSzJ6doNusIZTz0GOEyLULBPObiTQAVgdWi9Q==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:260b:b0:dc6:dfd9:d423 with SMTP
 id dw11-20020a056902260b00b00dc6dfd9d423mr429635ybb.3.1711814079990; Sat, 30
 Mar 2024 08:54:39 -0700 (PDT)
Date: Sat, 30 Mar 2024 15:54:38 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240330155438.2462326-1-edumazet@google.com>
Subject: [PATCH net-next] batman-adv: bypass empty buckets in batadv_purge_orig_ref()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Marek Lindner <mareklindner@neomailbox.ch>, 
	Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>, 
	Sven Eckelmann <sven@narfation.org>
Content-Type: text/plain; charset="UTF-8"

Many syzbot reports are pointing to soft lockups in
batadv_purge_orig_ref() [1]

Root cause is unknown, but we can avoid spending too much
time there and perhaps get more interesting reports.

[1]

watchdog: BUG: soft lockup - CPU#0 stuck for 27s! [kworker/u4:6:621]
Modules linked in:
irq event stamp: 6182794
 hardirqs last  enabled at (6182793): [<ffff8000801dae10>] __local_bh_enable_ip+0x224/0x44c kernel/softirq.c:386
 hardirqs last disabled at (6182794): [<ffff80008ad66a78>] __el1_irq arch/arm64/kernel/entry-common.c:533 [inline]
 hardirqs last disabled at (6182794): [<ffff80008ad66a78>] el1_interrupt+0x24/0x68 arch/arm64/kernel/entry-common.c:551
 softirqs last  enabled at (6182792): [<ffff80008aab71c4>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
 softirqs last  enabled at (6182792): [<ffff80008aab71c4>] batadv_purge_orig_ref+0x114c/0x1228 net/batman-adv/originator.c:1287
 softirqs last disabled at (6182790): [<ffff80008aab61dc>] spin_lock_bh include/linux/spinlock.h:356 [inline]
 softirqs last disabled at (6182790): [<ffff80008aab61dc>] batadv_purge_orig_ref+0x164/0x1228 net/batman-adv/originator.c:1271
CPU: 0 PID: 621 Comm: kworker/u4:6 Not tainted 6.8.0-rc7-syzkaller-g707081b61156 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Workqueue: bat_events batadv_purge_orig
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : should_resched arch/arm64/include/asm/preempt.h:79 [inline]
 pc : __local_bh_enable_ip+0x228/0x44c kernel/softirq.c:388
 lr : __local_bh_enable_ip+0x224/0x44c kernel/softirq.c:386
sp : ffff800099007970
x29: ffff800099007980 x28: 1fffe00018fce1bd x27: dfff800000000000
x26: ffff0000d2620008 x25: ffff0000c7e70de8 x24: 0000000000000001
x23: 1fffe00018e57781 x22: dfff800000000000 x21: ffff80008aab71c4
x20: ffff0001b40136c0 x19: ffff0000c72bbc08 x18: 1fffe0001a817bb0
x17: ffff800125414000 x16: ffff80008032116c x15: 0000000000000001
x14: 1fffe0001ee9d610 x13: 0000000000000000 x12: 0000000000000003
x11: 0000000000000000 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : 00000000005e5789 x7 : ffff80008aab61dc x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000006 x1 : 0000000000000080 x0 : ffff800125414000
Call trace:
  __daif_local_irq_enable arch/arm64/include/asm/irqflags.h:27 [inline]
  arch_local_irq_enable arch/arm64/include/asm/irqflags.h:49 [inline]
  __local_bh_enable_ip+0x228/0x44c kernel/softirq.c:386
  __raw_spin_unlock_bh include/linux/spinlock_api_smp.h:167 [inline]
  _raw_spin_unlock_bh+0x3c/0x4c kernel/locking/spinlock.c:210
  spin_unlock_bh include/linux/spinlock.h:396 [inline]
  batadv_purge_orig_ref+0x114c/0x1228 net/batman-adv/originator.c:1287
  batadv_purge_orig+0x20/0x70 net/batman-adv/originator.c:1300
  process_one_work+0x694/0x1204 kernel/workqueue.c:2633
  process_scheduled_works kernel/workqueue.c:2706 [inline]
  worker_thread+0x938/0xef4 kernel/workqueue.c:2787
  kthread+0x288/0x310 kernel/kthread.c:388
  ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.8.0-rc7-syzkaller-g707081b61156 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : arch_local_irq_enable+0x8/0xc arch/arm64/include/asm/irqflags.h:51
 lr : default_idle_call+0xf8/0x128 kernel/sched/idle.c:103
sp : ffff800093a17d30
x29: ffff800093a17d30 x28: dfff800000000000 x27: 1ffff00012742fb4
x26: ffff80008ec9d000 x25: 0000000000000000 x24: 0000000000000002
x23: 1ffff00011d93a74 x22: ffff80008ec9d3a0 x21: 0000000000000000
x20: ffff0000c19dbc00 x19: ffff8000802d0fd8 x18: 1fffe00036804396
x17: ffff80008ec9d000 x16: ffff8000802d089c x15: 0000000000000001
x14: 1fffe00036805f10 x13: 0000000000000000 x12: 0000000000000003
x11: 0000000000000001 x10: 0000000000000003 x9 : 0000000000000000
x8 : 00000000000ce8d1 x7 : ffff8000804609e4 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000001 x3 : ffff80008ad6aac0
x2 : 0000000000000000 x1 : ffff80008aedea60 x0 : ffff800125436000
Call trace:
  __daif_local_irq_enable arch/arm64/include/asm/irqflags.h:27 [inline]
  arch_local_irq_enable+0x8/0xc arch/arm64/include/asm/irqflags.h:49
  cpuidle_idle_call kernel/sched/idle.c:170 [inline]
  do_idle+0x1f0/0x4e8 kernel/sched/idle.c:312
  cpu_startup_entry+0x5c/0x74 kernel/sched/idle.c:410
  secondary_start_kernel+0x198/0x1c0 arch/arm64/kernel/smp.c:272
  __secondary_switched+0xb8/0xbc arch/arm64/kernel/head.S:404

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Marek Lindner <mareklindner@neomailbox.ch>
Cc: Simon Wunderlich <sw@simonwunderlich.de>
Cc: Antonio Quartulli <a@unstable.cc>
Cc: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/originator.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 71c143d4b6d05f70acb9ef678b9313e06e3ed79e..ac74f6ead62d5ed4bd8b153153fa494c367fbff6 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -1266,6 +1266,8 @@ void batadv_purge_orig_ref(struct batadv_priv *bat_priv)
 	/* for all origins... */
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
+		if (hlist_empty(head))
+			continue;
 		list_lock = &hash->list_locks[i];
 
 		spin_lock_bh(list_lock);
-- 
2.44.0.478.gd926399ef9-goog


