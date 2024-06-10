Return-Path: <netdev+bounces-102148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 147719019A7
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 06:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E787E1C20D0B
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 04:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D756FC7;
	Mon, 10 Jun 2024 04:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKXoZAtn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5142E2901
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 04:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717992438; cv=none; b=L6r8SiWV75sK4Bb0X4d1zq0CFyHEraCQESjFf9viHL3cRIEetJcFP/mjbRT/b1mQHhPLPsEbjteFZVidvJJCDLaBHwl/+IX+lee+kBF4ArtpCKhTtvrFSLpHxYtXFwLNcevsGzXzaAmuEN2cuDF0U3BbI8WQPo2QSrH4SymsSv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717992438; c=relaxed/simple;
	bh=T0nm3FRq9DrWMY8tfBGebXMruXtWooQbVspp64vsRQg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=okDsVwPgnezO0lvBcWIHgvEQvmoljtvXg/XuvEdo87QyGQZaqaxbEeGiRyY1cvwYgkf6wqyq6S6aMrhgvYAmIJetFk+fElfbb3oZUE6EKC9/CiBvy1pJqHpASq7Y69U+ApsGCl23XTzGyhEDacWLxjCF28m+yh6sqqQbm4kS2Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DKXoZAtn; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2bfff08fc29so3312034a91.1
        for <netdev@vger.kernel.org>; Sun, 09 Jun 2024 21:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717992436; x=1718597236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2SSX/7We+MBs16amF+tjvRRQMsff4tgeFCcqSIpK4QM=;
        b=DKXoZAtnMXHHCnAKISVXTGkFAPEy4bnPMITv0WEv17KEEwwt8qUwgCVwuAnESRzV/O
         xxfcAag/DmNenQZqWCT4meaqQKlfgHbEUsm9atJDuxFd5CHv+SQALJ+CZFF9Ocb9KmCY
         0KXJR5RH2GKKYRMNYADbqJsBpOa9oHDq/RXllGC7DjyTyV/nqwrkxwMAdpoq7z4VZ/1n
         x/5XFWQuAgg6SScWjRTnHeIynfGF5Ro5yCtwj4+jodvSVgUqBYUI6ELQGptdnaYqXnuO
         opkttidgmdsDlLVv8aEG6B5o6NrHfqYWcJ2UEC5BWu0r6Dum5J6nC+jDE8lV9bRKT69C
         01pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717992436; x=1718597236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2SSX/7We+MBs16amF+tjvRRQMsff4tgeFCcqSIpK4QM=;
        b=N+F+j6jnEdTf9ZbLFB9ERPUW2fP5xrxpxiZXJG8HRk33tRthEoYJKUAWKBc23wcvtJ
         3cPmNykvck+ZSJrjgoSRFsM+eDO4kE6EpUv+V/Yz5I865dr7AdzY/3ggf+pjkh3Tklsh
         hSPWh2C1+I/TDnHD7Yiv489sbPOWLWC8QEtzvWj31jUFVlBfWGvMxGuHi8He5352vLhx
         ugmC9tMm6XcY+IKe5P9AInrjCPkoOQ7wm/hg4ZydBy2R0sDkIFgrkXeJL4ImEtiqZzl+
         D0TYdzyK/G5Hy0CczahfuAzkkgLQxApwEGniMss3RwiLX2kTX8JE7iwKcWrD0E5ZYwXk
         O+Pw==
X-Forwarded-Encrypted: i=1; AJvYcCUwQppiLoIApI1bopRwrcJQRxQEW4Jln86Kr4ZPKjx71TaeN5yir5QJ/qOcotfX9hm08Rt49By24AMw0+UAzWkOeYw2zI9d
X-Gm-Message-State: AOJu0Yye5PFXW+BQQ6BLYFboGHVAwZm5Bd6L9vjJ6/NjoRm0b2AcK0rD
	pikoNOpNGRNJMvEGS673gjYErb8YTJvUS0o5QjxnGk+07dYRjZ+7
X-Google-Smtp-Source: AGHT+IEh8lF9/8nodH7H7OcUDz5kQnHzUk/8now69uRiXq/O3OUtQeCScNDWPnfGo6yvy60hCYBJMA==
X-Received: by 2002:a17:90b:4f90:b0:2bf:8fbf:e4c7 with SMTP id 98e67ed59e1d1-2c2bcafac1bmr7840339a91.16.1717992436489;
        Sun, 09 Jun 2024 21:07:16 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c3094cfe3dsm1038575a91.15.2024.06.09.21.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 21:07:15 -0700 (PDT)
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
	jacob.e.keller@intel.com,
	nitya.sunkad@amd.com
Subject: [PATCH net] ionic: fix use after netif_napi_del()
Date: Mon, 10 Jun 2024 04:07:06 +0000
Message-Id: <20240610040706.1385890-1-ap420073@gmail.com>
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
 drivers/net/ethernet/pensando/ionic/ionic_lif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 24870da3f484..b66c907d88e6 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -304,7 +304,7 @@ static int ionic_qcq_enable(struct ionic_qcq *qcq)
 	if (ret)
 		return ret;
 
-	if (qcq->napi.poll)
+	if (test_bit(NAPI_STATE_LISTED, &qcq->napi.state))
 		napi_enable(&qcq->napi);
 
 	if (qcq->flags & IONIC_QCQ_F_INTR) {
-- 
2.34.1


