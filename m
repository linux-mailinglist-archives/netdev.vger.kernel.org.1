Return-Path: <netdev+bounces-134783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A4799B29D
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 11:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4031283E9C
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 09:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A3E14D456;
	Sat, 12 Oct 2024 09:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dhK2TqIf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B81913D516
	for <netdev@vger.kernel.org>; Sat, 12 Oct 2024 09:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728726155; cv=none; b=gomyxwJ16V+GxBxTBejSIHHC1NnMtjCWhWDrJAy6R4x4RbiTBt5Z2F6isYawrrzl12JFNaTCDrzzXDGVTiMneL6FBO9+8Sm60VE75Jcr8C0769GbnTYNsNjKE9lRJ7E46NgMpfJgDWSyOV5s8I0b5h9k0sTNTSSPaC1rGY/cIqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728726155; c=relaxed/simple;
	bh=sNZA4QEj08ITujOD3JcOqxVRAAgeAKyXe4h9RjkGnOQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hVkW9okaQtYu60TfEpjkitm3Z3BAyyf/cbI32bmnGszaFo85ncmAhdia+mU9Z+CjrPXVHskBvnRKW/yTXkoquco1f+4vJiwce/d7PzmtBU8zc+REGnN40QU/fLWJ9aOezFZYZyFChNBWCzvmARIciKX9WOL2Z9O2X2goubEALeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dhK2TqIf; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0353b731b8so4038004276.2
        for <netdev@vger.kernel.org>; Sat, 12 Oct 2024 02:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728726152; x=1729330952; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LRajK1QyGeiaRLdjHp1c2/sm7cWj+FAUOqBOp/8ygyw=;
        b=dhK2TqIfHm2NKZQMUlQh/TON1eFx4by0lRlGhlBEeUmfEBbCewJZ/Yfo6yd8M48UZS
         QZOQ9zpxRGcelc1sZpzDJF+pl4tYCrDFQWpb6eqtMiXwf1zn8eSjeI+8TXwdF1bMIZgC
         BxPsm0ZQfAXXH8tdIDU2bV3TYrIx/VpjHxLaW43C6SqklF/UOM34f+NMVGwmKCqNdBVD
         G3XqWgRdKLx0rVa2obMFp4OC/DDQFtyQc+0zJ5dAOmBMhiBy14fPAt4/E1oqgB32mAVD
         NNUp7W5+w16cU9H50PUDpxjFbE3Ev/LCQWQlFkI9W8Wv69kUAZpkPClSGxwyf3BYbRx2
         n7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728726152; x=1729330952;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LRajK1QyGeiaRLdjHp1c2/sm7cWj+FAUOqBOp/8ygyw=;
        b=FxRqoUubKbstNhEsIuq1KbZr817gy55PZHLdF7EijOEwqrNKtlVmGAP1zyuSy7N4GI
         J7SxNC19elFeVeH9IX6kvPB5/ww7qFsg6JHJe8h08asYB2GvpFWINa6+Vbaf+CoCWGNJ
         EqnSSyb1whQSc68a2tfr7AIXSuPpYTBQJjDTbT0FMNpuGgL10DT2VxFMwC0DPh7mvuu9
         v3WxlgrKwbugf/Rk5yvg0zkivy+KeJ4TERGg5yukEo1+CZh8AJrEIWxgLjyHFMrQllpH
         XMf2ny+phRi1ojsmBkUrqBA5i3EqSUhIDFn1iwni1dZh37+MFPQ3nSFvtNAZvU91Moyo
         8qLQ==
X-Gm-Message-State: AOJu0YxJsPePWBSNxbmMkEgRLKZ3OMtDSTkvtpLDoffbm9fMEI9VAnvB
	IrMywelf1HRhB5Efb/CH3B+23KfuVl1l/PBjPJSh9G5K3M7ar2QOtsIdCFKfoqbu+KPrnhPeamC
	/Rh33V3fvYQ==
X-Google-Smtp-Source: AGHT+IEJkAt8pUTXwmO4JmH2Vxd81xlz/PccHpnk7cXfkLK7gi9Q84Bp5McuL0i+uEd3OgGpQcUdwG9VLUTynw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a25:b810:0:b0:e25:17cb:352e with SMTP id
 3f1490d57ef6-e2919ff850emr3262276.9.1728726152026; Sat, 12 Oct 2024 02:42:32
 -0700 (PDT)
Date: Sat, 12 Oct 2024 09:42:30 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241012094230.3893510-1-edumazet@google.com>
Subject: [PATCH v2 net] netdevsim: use cond_resched() in nsim_dev_trap_report_work()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+d383dc9579a76f56c251@syzkaller.appspotmail.com, 
	syzbot+c596faae21a68bf7afd0@syzkaller.appspotmail.com, 
	Jiri Pirko <jiri@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

I am still seeing many syzbot reports hinting that syzbot
might fool nsim_dev_trap_report_work() with hundreds of ports [1]

Lets use cond_resched(), and system_unbound_wq
instead of implicit system_wq.

[1]
INFO: task syz-executor:20633 blocked for more than 143 seconds.
      Not tainted 6.12.0-rc2-syzkaller-00205-g1d227fcc7222 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:25856 pid:20633 tgid:20633 ppid:1      flags:0x00004006
...
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 16760 Comm: kworker/1:0 Not tainted 6.12.0-rc2-syzkaller-00205-g1d227fcc7222 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: events nsim_dev_trap_report_work
 RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x70 kernel/kcov.c:210
Code: 89 fb e8 23 00 00 00 48 8b 3d 04 fb 9c 0c 48 89 de 5b e9 c3 c7 5d 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <f3> 0f 1e fa 48 8b 04 24 65 48 8b 0c 25 c0 d7 03 00 65 8b 15 60 f0
RSP: 0018:ffffc90000a187e8 EFLAGS: 00000246
RAX: 0000000000000100 RBX: ffffc90000a188e0 RCX: ffff888027d3bc00
RDX: ffff888027d3bc00 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff88804a2e6000 R08: ffffffff8a4bc495 R09: ffffffff89da3577
R10: 0000000000000004 R11: ffffffff8a4bc2b0 R12: dffffc0000000000
R13: ffff88806573b503 R14: dffffc0000000000 R15: ffff8880663cca00
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc90a747f98 CR3: 000000000e734000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 000000000000002b DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
  __local_bh_enable_ip+0x1bb/0x200 kernel/softirq.c:382
  spin_unlock_bh include/linux/spinlock.h:396 [inline]
  nsim_dev_trap_report drivers/net/netdevsim/dev.c:820 [inline]
  nsim_dev_trap_report_work+0x75d/0xaa0 drivers/net/netdevsim/dev.c:850
  process_one_work kernel/workqueue.c:3229 [inline]
  process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
  worker_thread+0x870/0xd30 kernel/workqueue.c:3391
  kthread+0x2f0/0x390 kernel/kthread.c:389
  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Fixes: ba5e1272142d ("netdevsim: avoid potential loop in nsim_dev_trap_report_work()")
Reported-by: syzbot+d383dc9579a76f56c251@syzkaller.appspotmail.com
Reported-by: syzbot+c596faae21a68bf7afd0@syzkaller.appspotmail.com
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Jiri Pirko <jiri@nvidia.com>
---
v2: Addressed Jakub feedback
   https://lore.kernel.org/netdev/20241011085911.601bad62@kernel.org/

 drivers/net/netdevsim/dev.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
index 92a7a36b93ac0cc1b02a551b974fb390254ac484..3e0b61202f0c9824952040c8d4c79eb8775954c6 100644
--- a/drivers/net/netdevsim/dev.c
+++ b/drivers/net/netdevsim/dev.c
@@ -836,7 +836,8 @@ static void nsim_dev_trap_report_work(struct work_struct *work)
 	nsim_dev = nsim_trap_data->nsim_dev;
 
 	if (!devl_trylock(priv_to_devlink(nsim_dev))) {
-		schedule_delayed_work(&nsim_dev->trap_data->trap_report_dw, 1);
+		queue_delayed_work(system_unbound_wq,
+				   &nsim_dev->trap_data->trap_report_dw, 1);
 		return;
 	}
 
@@ -848,11 +849,12 @@ static void nsim_dev_trap_report_work(struct work_struct *work)
 			continue;
 
 		nsim_dev_trap_report(nsim_dev_port);
+		cond_resched();
 	}
 	devl_unlock(priv_to_devlink(nsim_dev));
-
-	schedule_delayed_work(&nsim_dev->trap_data->trap_report_dw,
-			      msecs_to_jiffies(NSIM_TRAP_REPORT_INTERVAL_MS));
+	queue_delayed_work(system_unbound_wq,
+			   &nsim_dev->trap_data->trap_report_dw,
+			   msecs_to_jiffies(NSIM_TRAP_REPORT_INTERVAL_MS));
 }
 
 static int nsim_dev_traps_init(struct devlink *devlink)
@@ -907,8 +909,9 @@ static int nsim_dev_traps_init(struct devlink *devlink)
 
 	INIT_DELAYED_WORK(&nsim_dev->trap_data->trap_report_dw,
 			  nsim_dev_trap_report_work);
-	schedule_delayed_work(&nsim_dev->trap_data->trap_report_dw,
-			      msecs_to_jiffies(NSIM_TRAP_REPORT_INTERVAL_MS));
+	queue_delayed_work(system_unbound_wq,
+			   &nsim_dev->trap_data->trap_report_dw,
+			   msecs_to_jiffies(NSIM_TRAP_REPORT_INTERVAL_MS));
 
 	return 0;
 
-- 
2.47.0.rc1.288.g06298d1525-goog


