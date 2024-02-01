Return-Path: <netdev+bounces-68153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4874F845EF3
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 18:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27EA3B2BCDC
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 17:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038457C6E2;
	Thu,  1 Feb 2024 17:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J4LJ2awR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAED7C6D7
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 17:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706810008; cv=none; b=X3ghwtJxYeCkRxCoD4WC2GmvAaj+mQPg/5qeVLr8zcgZatFTVEGFXczGpmZ6h3OR8kuJaDgtE/9scNAluAIb41+AomM2n75P/oLBosriOHGT1BkHDPN7MJeqfIqgEYD+BWBX6y1ffIJhifJFfGYP2JcYvAULGdpaYTi8+yUunk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706810008; c=relaxed/simple;
	bh=Zk2ov1opgNHmx4vLZRgOl+nHfy0HQweiyoOa7ZkDcTM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lLbjAOM1Ux+8CB5eWDDM/ZjWAABBty9nKjNvDXQfa2jmj/3GciTHn/92w8sCoOpEJpVtAX//SXjxmwJamYlCsUkhrl04nUGizLUAgj4FbATw8GspKyvsYaYg6PpbRPBwBW7WfofjszjN+ijRj3VRp/tesZINwmb10Al31ZoewGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J4LJ2awR; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b2681571so1871480276.2
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 09:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706810006; x=1707414806; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hWruSwlom3lXdmwH02laiU8RsFEbcXFelwURYIcXPD8=;
        b=J4LJ2awRdIlzo4eF9vTqEUYGxuH3mVu180VFANJeynhw9ta2gP8stkfP9WaNkvlHm9
         naIQmbRl0jq2mKFQDsWg1VGswT3uL/QLUbKVdUZvXV5U5l+A0i9VUyez7vm+weyz1qfP
         +l49w3iCrE6eCZBd/NgZpNBXtvIaO2w0uvJMGpE1SKCEFK/0lRou96vbYulgajFNaA+L
         SGTDCuBJ/MzGiBLkm0jLImm2wdJb8O+EF3q69RwjnkJEPPnw1JrAHoOfnxsJL+ZsmpGD
         ofIxAGi2g582s+HdxRa16NoZBwL/jckYozXdF5UYo9vmoV3W/HXUcA4V2Hnw1wtb/Cx1
         yFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706810006; x=1707414806;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hWruSwlom3lXdmwH02laiU8RsFEbcXFelwURYIcXPD8=;
        b=WV6FZegbxIm/DygeDTM5tNDqhqh/IKPAaZt9SiWpgQb5wbnLTNGiMFJRVOjMX4Ah/3
         86Relf0AbHP3khGcSi0uV0AdiFUucKzto4prWEE+faL0LliitTTCYoJjWWAXmpFfQFQd
         yQdxdfD1afOmxKHEF5BksJvIRMs4wQADO/JnzIExl/w1lldCeaWZrCRvaaQ0vzaruxGQ
         ZYjSq0ak954eZdRAjetMkKHu0J6bTwCLqzmD6T5CabznwQNpM1S473GH4abXTnTvh1nY
         fB4xxPwaPFMHTeSctpCiwRe+sDaL5rS6wh4DYy93jVrD+3hVIugFr3xKQs/kgRwNXPdz
         y1Qg==
X-Gm-Message-State: AOJu0YxCtB6iABhy/KnLZ29ie9YNqNZgLgZWTfI6ch+nSKaDeyrsUq9M
	g9duYiMXJWohHeEgX5pksQxN5d/dfVab57iSyyKU+QqciBtZzlW+I6GAkP9sz7F8eKn2pee2gf/
	3KfGPnhShHQ==
X-Google-Smtp-Source: AGHT+IFxWgWYXAB/QRHek7Sdh2QC3KTM0gL9tsTQGMM0Fd3YkzkHuobjSIhG1SYOBOEDQyzIw+NbNKhwnLvqQQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:2384:b0:dc6:9f32:59ae with SMTP
 id dp4-20020a056902238400b00dc69f3259aemr103018ybb.12.1706810006339; Thu, 01
 Feb 2024 09:53:26 -0800 (PST)
Date: Thu,  1 Feb 2024 17:53:24 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240201175324.3752746-1-edumazet@google.com>
Subject: [PATCH net] netdevsim: avoid potential loop in nsim_dev_trap_report_work()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>, 
	Jiri Pirko <jiri@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

Many syzbot reports include the following trace [1]

If nsim_dev_trap_report_work() can not grab the mutex,
it should rearm itself at least one jiffie later.

[1]
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 32383 Comm: kworker/0:2 Not tainted 6.8.0-rc2-syzkaller-00031-g861c0981648f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Workqueue: events nsim_dev_trap_report_work
 RIP: 0010:bytes_is_nonzero mm/kasan/generic.c:89 [inline]
 RIP: 0010:memory_is_nonzero mm/kasan/generic.c:104 [inline]
 RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:129 [inline]
 RIP: 0010:memory_is_poisoned mm/kasan/generic.c:161 [inline]
 RIP: 0010:check_region_inline mm/kasan/generic.c:180 [inline]
 RIP: 0010:kasan_check_range+0x101/0x190 mm/kasan/generic.c:189
Code: 07 49 39 d1 75 0a 45 3a 11 b8 01 00 00 00 7c 0b 44 89 c2 e8 21 ed ff ff 83 f0 01 5b 5d 41 5c c3 48 85 d2 74 4f 48 01 ea eb 09 <48> 83 c0 01 48 39 d0 74 41 80 38 00 74 f2 eb b6 41 bc 08 00 00 00
RSP: 0018:ffffc90012dcf998 EFLAGS: 00000046
RAX: fffffbfff258af1e RBX: fffffbfff258af1f RCX: ffffffff8168eda3
RDX: fffffbfff258af1f RSI: 0000000000000004 RDI: ffffffff92c578f0
RBP: fffffbfff258af1e R08: 0000000000000000 R09: fffffbfff258af1e
R10: ffffffff92c578f3 R11: ffffffff8acbcbc0 R12: 0000000000000002
R13: ffff88806db38400 R14: 1ffff920025b9f42 R15: ffffffff92c578e8
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c00994e078 CR3: 000000002c250000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
  instrument_atomic_read include/linux/instrumented.h:68 [inline]
  atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
  queued_spin_is_locked include/asm-generic/qspinlock.h:57 [inline]
  debug_spin_unlock kernel/locking/spinlock_debug.c:101 [inline]
  do_raw_spin_unlock+0x53/0x230 kernel/locking/spinlock_debug.c:141
  __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:150 [inline]
  _raw_spin_unlock_irqrestore+0x22/0x70 kernel/locking/spinlock.c:194
  debug_object_activate+0x349/0x540 lib/debugobjects.c:726
  debug_work_activate kernel/workqueue.c:578 [inline]
  insert_work+0x30/0x230 kernel/workqueue.c:1650
  __queue_work+0x62e/0x11d0 kernel/workqueue.c:1802
  __queue_delayed_work+0x1bf/0x270 kernel/workqueue.c:1953
  queue_delayed_work_on+0x106/0x130 kernel/workqueue.c:1989
  queue_delayed_work include/linux/workqueue.h:563 [inline]
  schedule_delayed_work include/linux/workqueue.h:677 [inline]
  nsim_dev_trap_report_work+0x9c0/0xc80 drivers/net/netdevsim/dev.c:842
  process_one_work+0x886/0x15d0 kernel/workqueue.c:2633
  process_scheduled_works kernel/workqueue.c:2706 [inline]
  worker_thread+0x8b9/0x1290 kernel/workqueue.c:2787
  kthread+0x2c6/0x3a0 kernel/kthread.c:388
  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>

Fixes: 012ec02ae441 ("netdevsim: convert driver to use unlocked devlink API during init/fini")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Jiri Pirko <jiri@nvidia.com>
---
 drivers/net/netdevsim/dev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
index b4d3b9cde8bd685202f135cf9c845d1be76ef428..92a7a36b93ac0cc1b02a551b974fb390254ac484 100644
--- a/drivers/net/netdevsim/dev.c
+++ b/drivers/net/netdevsim/dev.c
@@ -835,14 +835,14 @@ static void nsim_dev_trap_report_work(struct work_struct *work)
 				      trap_report_dw.work);
 	nsim_dev = nsim_trap_data->nsim_dev;
 
-	/* For each running port and enabled packet trap, generate a UDP
-	 * packet with a random 5-tuple and report it.
-	 */
 	if (!devl_trylock(priv_to_devlink(nsim_dev))) {
-		schedule_delayed_work(&nsim_dev->trap_data->trap_report_dw, 0);
+		schedule_delayed_work(&nsim_dev->trap_data->trap_report_dw, 1);
 		return;
 	}
 
+	/* For each running port and enabled packet trap, generate a UDP
+	 * packet with a random 5-tuple and report it.
+	 */
 	list_for_each_entry(nsim_dev_port, &nsim_dev->port_list, list) {
 		if (!netif_running(nsim_dev_port->ns->netdev))
 			continue;
-- 
2.43.0.429.g432eaa2c6b-goog


