Return-Path: <netdev+bounces-102791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B2F904B4C
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 08:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 525AD1F230C1
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 06:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D4B132127;
	Wed, 12 Jun 2024 06:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYd8gzD4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCEA56458
	for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 06:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718172303; cv=none; b=bnE/qMyorWnU2qmSMAFVmX3fw4pG4ZUmbbH4OX0S/mL0xJyRSYbuMwLFuNETOWbYrKLF0mrT0O9rr1IkyP61JYdvKtjHKFWDrqVYjxwo5ZpnyQQERLg9iMRomHi4/XrZWZ6+ZJRMhNRUaKirxMK8YrS+g0lyESHbUXrmfhWBsR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718172303; c=relaxed/simple;
	bh=HmqYsLtEUXj2qybOXyBAF0G3jHgtgasQ0IDl083A9wU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Emr7LZkElJCkW6lFhJUccb8uhZuQmkMAK8mh4msKd6W1hEkYx31UvIvnhtsMsULtdoXers151RHBH0Qlpt71OF+gqKsbUemIsFfIYPUz2Khs0tSV66pLdVHr2nR/03GaAkvmQKtLL7luUWG+aigC9EhAlqYzhydLmvnXZL4bfdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYd8gzD4; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f70c457823so21919475ad.3
        for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 23:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718172301; x=1718777101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HnhYMF/qfzt39DUGTzbb4nRd15Wmw09z1LJEukUGhF0=;
        b=LYd8gzD49Rk/ef6fCiRBY9Vdptxw+sStX6zg10/LFSWhas2l0bV3zqcIiK3Zh/M3GO
         rIj8poRrv46Zc3T7veTcb0TP2Rw2VyW+jwp3tXxSi89xYvHnfNy8F0Uq1dUqD6o9PaQh
         r4tbELg5W1PuBCImwwPlGJub3O9pnKXrVUhuVdI7PQk0BqPKI0itGNGBTIrczmW6A8H5
         00n+jeV3fH9dek1R4EKWHbzQe1G4xlIYtDOeV3aOKPjcm7PbtuAPVZLcVKpfowfm+M7h
         if+7XaPcmhaZ6E7jbm8ow9h+ic1YCYPTkRNqE8UZvuL5bcyfFfpl0OB/k3vIvsr43KSs
         fz8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718172301; x=1718777101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HnhYMF/qfzt39DUGTzbb4nRd15Wmw09z1LJEukUGhF0=;
        b=KYrvxxolf9OgLkC+70JqiGWxCqEdvYCWk9a7mzDrcWlRvQ2lNnvlaiolgrFl5Q25Sf
         4j1VYRYTsP4uFoQeDqjg2/oxzpaFDrNQg1R001Y5avds1/cyGchYgNAdkW3TKRjEVXxr
         zxl/pUYIJa7sgufSqFYbisU4J65qPkZAQ63ymLYb4sqxfFTi/d78YNfs5iG/ZlqRhJs5
         SsVoPegglGZzsR9AHCS1Mq4lnXi97Jitpee4aOE847nkG+3hGolDeCxiZ0JJxgvxS/oa
         vt38u6E6UaLFLt6aonX743fkt0YondcRR23IHv0zXX7G1VhXxFdXodVuY3GBNTmLkMmW
         vhUw==
X-Forwarded-Encrypted: i=1; AJvYcCWP1gWOzkxNwfe65nUgyM0iPdgztSns7Dllg+UIH0BKf3JppBC10HIH/zbLMDN3eTpz7UzE8RCRFpzr6e0DpNCW2/UirX5t
X-Gm-Message-State: AOJu0YyU1tlIu0O++Si+DYb9z1jT/Kg3h484ylcbyd9WRWM/A+bJ+dU5
	FWoJxP7fmgcG0rPQeTLIMcqRy7ZFhNj8/2MLuV2z8vJWcD1f5th4
X-Google-Smtp-Source: AGHT+IF6jHTuSJGgX2oENnrzif9oOIVwc+WC0Waik/9dbY7HQ5yIYtFhDHLb8lkGH3THXi7NObx1Tw==
X-Received: by 2002:a17:902:da92:b0:1f4:7713:8f6 with SMTP id d9443c01a7336-1f83b7164b3mr10986765ad.52.1718172296644;
        Tue, 11 Jun 2024 23:04:56 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd75ef35sm114036175ad.56.2024.06.11.23.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 23:04:55 -0700 (PDT)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	shannon.nelson@amd.com,
	brett.creeley@amd.com,
	drivers@pensando.io,
	netdev@vger.kernel.org
Cc: ap420073@gmail.com,
	jacob.e.keller@intel.com
Subject: [PATCH net v2] ionic: fix use after netif_napi_del()
Date: Wed, 12 Jun 2024 06:04:46 +0000
Message-Id: <20240612060446.1754392-1-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When queues are started, netif_napi_add() and napi_enable() are called.
If there are 4 queues and only 3 queues are used for the current
configuration, only 3 queues' napi should be registered and enabled.
The ionic_qcq_enable() checks whether the .poll pointer is not NULL for
enabling only the using queue' napi. Unused queues' napi will not be
registered by netif_napi_add(), so the .poll pointer indicates NULL.
But it couldn't distinguish whether the napi was unregistered or not
because netif_napi_del() doesn't reset the .poll pointer to NULL.
So, ionic_qcq_enable() calls napi_enable() for the queue, which was
unregistered by netif_napi_del().

Reproducer:
   ethtool -L <interface name> rx 1 tx 1 combined 0
   ethtool -L <interface name> rx 0 tx 0 combined 1
   ethtool -L <interface name> rx 0 tx 0 combined 4

Splat looks like:
kernel BUG at net/core/dev.c:6666!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
CPU: 3 PID: 1057 Comm: kworker/3:3 Not tainted 6.10.0-rc2+ #16
Workqueue: events ionic_lif_deferred_work [ionic]
RIP: 0010:napi_enable+0x3b/0x40
Code: 48 89 c2 48 83 e2 f6 80 b9 61 09 00 00 00 74 0d 48 83 bf 60 01 00 00 00 74 03 80 ce 01 f0 4f
RSP: 0018:ffffb6ed83227d48 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff97560cda0828 RCX: 0000000000000029
RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff97560cda0a28
RBP: ffffb6ed83227d50 R08: 0000000000000400 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
R13: ffff97560ce3c1a0 R14: 0000000000000000 R15: ffff975613ba0a20
FS:  0000000000000000(0000) GS:ffff975d5f780000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8f734ee200 CR3: 0000000103e50000 CR4: 00000000007506f0
PKRU: 55555554
Call Trace:
 <TASK>
 ? die+0x33/0x90
 ? do_trap+0xd9/0x100
 ? napi_enable+0x3b/0x40
 ? do_error_trap+0x83/0xb0
 ? napi_enable+0x3b/0x40
 ? napi_enable+0x3b/0x40
 ? exc_invalid_op+0x4e/0x70
 ? napi_enable+0x3b/0x40
 ? asm_exc_invalid_op+0x16/0x20
 ? napi_enable+0x3b/0x40
 ionic_qcq_enable+0xb7/0x180 [ionic 59bdfc8a035436e1c4224ff7d10789e3f14643f8]
 ionic_start_queues+0xc4/0x290 [ionic 59bdfc8a035436e1c4224ff7d10789e3f14643f8]
 ionic_link_status_check+0x11c/0x170 [ionic 59bdfc8a035436e1c4224ff7d10789e3f14643f8]
 ionic_lif_deferred_work+0x129/0x280 [ionic 59bdfc8a035436e1c4224ff7d10789e3f14643f8]
 process_one_work+0x145/0x360
 worker_thread+0x2bb/0x3d0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0xcc/0x100
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x2d/0x50
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30

Fixes: 0f3154e6bcb3 ("ionic: Add Tx and Rx handling")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---
 v2:
  - Use ionic flag instead of napi flag.

 drivers/net/ethernet/pensando/ionic/ionic_lif.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 24870da3f484..1934e9d6d9e4 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -304,10 +304,8 @@ static int ionic_qcq_enable(struct ionic_qcq *qcq)
 	if (ret)
 		return ret;
 
-	if (qcq->napi.poll)
-		napi_enable(&qcq->napi);
-
 	if (qcq->flags & IONIC_QCQ_F_INTR) {
+		napi_enable(&qcq->napi);
 		irq_set_affinity_hint(qcq->intr.vector,
 				      &qcq->intr.affinity_mask);
 		ionic_intr_mask(idev->intr_ctrl, qcq->intr.index,
-- 
2.34.1


