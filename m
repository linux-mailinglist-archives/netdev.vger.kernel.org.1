Return-Path: <netdev+bounces-297459-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6fDJJuL/KGqcOgMAu9opvQ
	(envelope-from <netdev+bounces-297459-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:10:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1C4666191
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:10:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=QFHBvOZL;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297459-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297459-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A5EE83004D29
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 06:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C061D368D4D;
	Wed, 10 Jun 2026 06:10:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC533438BD
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 06:10:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781071840; cv=none; b=gt+28LldtDfG09c+tpYQyTGvaM7vY63lNZM0cWO/qZn4a78HN0EPQ1s3jncZ4ErSLMp64MsFv6tisUO2XJQchvzbKvCLF9hzJUsxCkROIjEzspGHMRMZB9I1fKxf6mtaKWQiyPvuBKERtKJpo8L9dMT2TlaifrBeIXEDysW6FlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781071840; c=relaxed/simple;
	bh=OCQdBXoDSb4fCepkGt69ySpGBZk4iWiO7cyuGHBbhbc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hZUcPONU7TgBzyL6orNemqAuxw1tpnJHxJMtTR5Vebw4Fdgmzoh9aN99oLVwVhC1JdJHrGXychqMGngT2E7pUBhLx7yPix6y214msp2EzCR1GvKMihKrvRB5TCDEF2UR/U/hZWW2TkR9m6/CYgr6gpUrrWrHCBrTgH/kixil8GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFHBvOZL; arc=none smtp.client-ip=209.85.214.180
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c0c2c7d45eso57290645ad.1
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 23:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781071839; x=1781676639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+4pbB1lM848qPCE+KNCDf3oWy2wh4uzVZdAR4OE3Duo=;
        b=QFHBvOZLb7vGNu+AVbAPFPX0E1CLCBis4TekDE4sZqaS6wtwJJB4FJM7Sq38pEyOE4
         HiWa3dF2wjVVE6T9Fn3LhJ9CGJod5ZZtdTCB69ZKRoskfrH2ODWFt87vOe2xMMjyhcp9
         5+XZby2tPqPm4YHTed2/nEOJYfvplq4S6BTdl4sJ9j5Hk8pCRnZdQCObunkXBgBDeWk6
         AsnodAL3H8uufQJ9P4vk50vmuM3ccvyCx5nS6JQyl2+inom/lOENnQ+H/R5zGPypRgB9
         izJdXnUzdIoBOC5crH/Z+PcaD8eHuOG8e0u5MP/3b9G2v0W/L//W6mK4spkP/1r2ELMC
         YbPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781071839; x=1781676639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4pbB1lM848qPCE+KNCDf3oWy2wh4uzVZdAR4OE3Duo=;
        b=U1ERJEhnop9SFbtjrjvu1gSNdd4V1axtXhbfxKxv6bA8xHakTFO/TZnkoJdTmOIVnL
         OQBrbyjdBqIKg40Y96GjJ4gP9iUSGzmkTksEmHdCs3/34qcmWO8wkEs2Cd9Eu8HRQxeb
         pmEDdblRjvlFq4mvhTviYD2aLq8fiv79pWfgvZEMfYFvbTUh5yVMITgsc2wFGVhbQhD4
         0WnjtTXZ5aTL2l/g5AcNtU5OtvJn8lwM1deSUXuT8ZbmO7WPnqUmITa5bmjE5aZ4B06G
         Ys6eDCuysWwjhhQyeMY6yCDkD/Vr3RQCOIVoQ5qw/k+rJfp8EhA4NAUAgeA0QBZocHq5
         5nfA==
X-Gm-Message-State: AOJu0Yy5FAr4gKg+CbUxpOLJ3clXQsKnBp22GMR9LDHR+d15s7X7fnaD
	CEz+zbFCUlC2DM+Ji2gqREkE1pj/xjSeEQSCBdV5uxvhohbCHS76ll2Doy8Ks/qv
X-Gm-Gg: Acq92OFCXPIEkcNz2NX8MeqMQAFSpMQY6zmcCrybKBXf+UZbYLQ3SssCa7PHn2ScSXU
	5kDmxaW/ZyaHfwv3llUuJej3KAzC2pYmwExqor7zz7x00UKKVDJdDsvhymIrsOBv4Sei+Yu03O/
	KHQBPQd5tihzgWYDnWzCIVvfZrD4LEPdS3x7WVWJyivj9w/al1JPSu1MqL1snc5RqeOP21E4Cex
	gadBnjEHNGeGKiJ0dZ2/GrVaOHxidWFHcbBbiwnD2D4DZqAdSEJFTSBIumq358WIa4I1Fooaa4m
	mUvnVSAN912lNQ8dFK6vVPsQjHNxQ5ILupBX1HNWMJnSpFFfXNIXOz62Lyp+0PUW961VTQ+4krx
	BvMBy+8A5yLTytq8sRf2jRIBnd1uR7h5F6BqwKZS3LRkXT7cTCQZDnIz15Tf+XPbR72eEw27GFr
	vSu5qxhnjDnPN5h+2PBpurD3myd0ie0bJd9hT/urzO8o970hGzQe++WIG1hIU6I+unDZQ=
X-Received: by 2002:a17:903:1247:b0:2c0:b35d:ed54 with SMTP id d9443c01a7336-2c1e85e04c7mr275580875ad.35.1781071838564;
        Tue, 09 Jun 2026 23:10:38 -0700 (PDT)
Received: from u.. (61-222-64-201.hinet-ip.hinet.net. [61.222.64.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d211sm237768935ad.3.2026.06.09.23.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 23:10:37 -0700 (PDT)
From: Tim JH Chen <tim770802@gmail.com>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	haijun.liu@mediatek.com,
	chandrashekar.devegowda@intel.com,
	ricardo.martinez@linux.intel.com,
	loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	tim.jh.chen@wnc.com.tw,
	Chih.Hung.Huang@wnc.com.tw,
	Tim JH Chen <tim770802@gmail.com>
Subject: [PATCH net v4] net: wwan: t7xx: fix race between TX path and system PM suspend
Date: Wed, 10 Jun 2026 14:10:14 +0800
Message-ID: <20260610061014.597533-1-tim770802@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297459-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[tim770802@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[redhat.com,mediatek.com,intel.com,linux.intel.com,oss.qualcomm.com,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,kernel.org,vger.kernel.org,wnc.com.tw];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:haijun.liu@mediatek.com,m:chandrashekar.devegowda@intel.com,m:ricardo.martinez@linux.intel.com,m:loic.poulain@oss.qualcomm.com,m:ryazanov.s.a@gmail.com,m:johannes@sipsolutions.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:tim.jh.chen@wnc.com.tw,m:Chih.Hung.Huang@wnc.com.tw,m:tim770802@gmail.com,m:ryazanovsa@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tim770802@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2D1C4666191

Two DPMAIF TX contexts run pm_runtime_resume_and_get() followed by MMIO
independently of the PM core: the TX push kthread
(t7xx_dpmaif_tx_hw_push_thread) and the TX-done work
(t7xx_dpmaif_tx_done). Neither is stopped during a system suspend
transition, and system suspend does not honour the runtime PM reference
they hold, so they can touch the hardware while t7xx_dpmaif_suspend()
tears it down. With ASPM L1 enabled and repeated suspend/resume cycles
this ends in a CPU soft lockup:

  watchdog: BUG: soft lockup - CPU#N stuck for 26s! [dpmaif_tx_hw_pu]
    __pm_runtime_resume+0x5b/0x80
    t7xx_dpmaif_tx_hw_push_thread+0xc4 [mtk_t7xx]

Runtime suspend is already safe: while either context holds its PM
reference the runtime suspend callback cannot run. Only system suspend,
which ignores that reference, is exposed.

Quiesce both contexts with the PM freezer, which runs before dpm_suspend()
invokes the device suspend callbacks:

  - The push kthread is made freezable: set_freezable() and
    wait_event_freezable() for the idle wait, plus try_to_freeze() before
    the pm_runtime section so it also reaches a freeze point under
    continuous TX traffic.
  - The TX-done workqueue is marked WQ_FREEZABLE so the workqueue freezer
    drains it before suspend; this also parks its self-requeue until thaw.

Tasks are thawed only after the resume callbacks have re-armed the
hardware, so neither context can issue MMIO against a torn-down or
not-yet-rearmed device. No lock is shared with the PM callbacks, so this
cannot deadlock.

Tested with 500+ suspend/resume cycles, SIM registered and ASPM L1 enabled.

Fixes: 46e8f49ed7b3 ("net: wwan: t7xx: Introduce power management")
Signed-off-by: Tim JH Chen <tim770802@gmail.com>
---
v3 -> v4:
  - Drop the tx_pm_lock / state-snapshot approach entirely and use the PM
    freezer for both TX contexts instead. The previous approach deadlocked
    through the runtime PM wait queue (t7xx_dpmaif_suspend() is also the
    .runtime_suspend callback) and opened ISR windows by writing
    dpmaif_ctrl->state in suspend/resume.
  - Also cover t7xx_dpmaif_tx_done() (WQ_FREEZABLE), which has the same
    pm_runtime + MMIO pattern as the kthread.
  - Trim the changelog/commit message.
v2 -> v3: process fixes (Fixes tag, changelog placement).
v1 -> v2: save/restore pre-suspend state; wrap pm_runtime with a mutex.

 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c
index 236d632cf591..804bd730c40f 100644
--- a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c
+++ b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c
@@ -22,6 +22,7 @@
 #include <linux/dma-direction.h>
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
+#include <linux/freezer.h>
 #include <linux/gfp.h>
 #include <linux/kernel.h>
 #include <linux/kthread.h>
@@ -447,19 +448,28 @@ static int t7xx_dpmaif_tx_hw_push_thread(void *arg)
 	struct dpmaif_ctrl *dpmaif_ctrl = arg;
 	int ret;
 
+	set_freezable();
+
 	while (!kthread_should_stop()) {
 		if (t7xx_tx_lists_are_all_empty(dpmaif_ctrl) ||
 		    dpmaif_ctrl->state != DPMAIF_STATE_PWRON) {
-			if (wait_event_interruptible(dpmaif_ctrl->tx_wq,
-						     (!t7xx_tx_lists_are_all_empty(dpmaif_ctrl) &&
-						     dpmaif_ctrl->state == DPMAIF_STATE_PWRON) ||
-						     kthread_should_stop()))
+			if (wait_event_freezable(dpmaif_ctrl->tx_wq,
+						 (!t7xx_tx_lists_are_all_empty(dpmaif_ctrl) &&
+						  dpmaif_ctrl->state == DPMAIF_STATE_PWRON) ||
+						 kthread_should_stop()))
 				continue;
 
 			if (kthread_should_stop())
 				break;
 		}
 
+		/* Freeze here, outside the runtime-PM and MMIO section below, so
+		 * the system suspend freezer parks this thread before the device
+		 * suspend callbacks tear the DPMAIF hardware down.
+		 */
+		if (try_to_freeze())
+			continue;
+
 		ret = pm_runtime_resume_and_get(dpmaif_ctrl->dev);
 		if (ret < 0 && ret != -EACCES)
 			return ret;
@@ -617,7 +627,7 @@ int t7xx_dpmaif_txq_init(struct dpmaif_tx_queue *txq)
 	}
 
 	txq->worker = alloc_ordered_workqueue("md_dpmaif_tx%d_worker",
-				WQ_MEM_RECLAIM | (txq->index ? 0 : WQ_HIGHPRI),
+				WQ_MEM_RECLAIM | WQ_FREEZABLE | (txq->index ? 0 : WQ_HIGHPRI),
 				txq->index);
 	if (!txq->worker)
 		return -ENOMEM;
-- 
2.43.0


