Return-Path: <netdev+bounces-293492-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONAHCWHmHGrKTwkAu9opvQ
	(envelope-from <netdev+bounces-293492-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 03:54:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F08E618B17
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 03:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87F1A303D319
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 01:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239EE1B142D;
	Mon,  1 Jun 2026 01:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GT+2pmhK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846701A681B
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 01:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780278769; cv=none; b=H11F7ckP/TgCR/LZU898G5cphYsjfA7eaXuIzIAAwytjUovN/4oUPJ7F+jUAiW7tGHBlNRYQKzFEv064nbDTE3n4Mkap+3ncgWhQtR57I7zUGI+egx1LRO3REaUPROu/PpqhlrXTjCtsaJUBaeHKBXeBUDWSqlWbkDEiukRiJXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780278769; c=relaxed/simple;
	bh=96ARyzPfhfRo6MzSQYdf9+SIgqcfAHdfmIgw1cJ3tiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iYKDWgYC3Krba1KwvRcFglIWuz+wCTy6omKnkhTZtP3a++on9rkfVS+2WZqJX+bCSjtwC98C1WGihhMKl6u/yP1hWfUdsE2QxwEiCddgZ8D72Q1KDGlUCgKVdQj9QctEYl8kHgiHgNlsOWmq7K8VeBxPDrhGTuFTxMnzGGZ+lLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GT+2pmhK; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84232e83ca9so347683b3a.2
        for <netdev@vger.kernel.org>; Sun, 31 May 2026 18:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780278767; x=1780883567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ktDMM0rgR5BCs+kFb4cZjawFjqwuxm/udQlAT/C8G1A=;
        b=GT+2pmhK/kpIZUYrm8r93GHDfkQUku1hwA2jAd7iGfyDY2eJI3d2eDWw/SyZ0jQdC5
         kutiVijI/1Yss1MepGFaeDE63xFEwsvgMa5IzTJ4dIBa7qxwazUwTj8gmUCrfdJHJE+z
         jvNt7yirbPBQCfw33M0p4tu16Ib4AVSLQSXRM/qOKRQXVuuSHQFitm0nPA7Tl4LUQOzR
         7ZBfKJFND4bh7WmWXc9S4gjDmK4gnrdVy1fmkANLKicaWzFvnQTuQMqTagqYqUYIHMdI
         XnIHcmXK93c3+CVo8gnsliz2MnrOnK/9T+G/NDIVcLPOjrkCpZ9hdJEUBlYjqG1qqKAg
         qAaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780278767; x=1780883567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ktDMM0rgR5BCs+kFb4cZjawFjqwuxm/udQlAT/C8G1A=;
        b=rXqRKC6CxdXAfcFxotUQeptgvKJbe98nbe96+kSW/is+SvvoJ8JZReRIJcfqG/tWzC
         V80Ufun5YfF6LsK3rFdTdsXl0F+to5YXYCrUrOTmMupdverHJL1PTSITgGdJuypHWT+a
         0kiLWisKZ4lcEb8wfGd9uLE9YHPGrNujM5y5xgNBoCUmzMb93xrBzN8fdo9qvInUVhRB
         +eKHJenn/Fxu/SdtkqYvSJJBAICf/+a0KOZDwc7u7v2WHphij0m8ogDI3kCmlamKaKIX
         yBXCM1ReeqlYGu+/Ht2u4UMeWvb2ZzKXPIsMq3xc6CZtdYRsQtbXufPBYpAx0aPieIZ7
         Yz2Q==
X-Gm-Message-State: AOJu0YzAM27jYIuWE85N10mZBlR9822HvCGsf4nB0Rg7+WBr3L8aH6cJ
	2vqWf6WaJ/m9O5ja36e08j0oTRHs4xXtw/MEy1RQHjY/+rapPsCP+YoMExD56Mgj
X-Gm-Gg: Acq92OHiTMq2lm4NaTtXuH7bW6eU0I0WhDhgAz8qISusCcqzF0OqGHl4H8tWuBZ4Pkg
	M2XWRognZsmdGFjqJgRlkQS6r0qQ8ejuqmCUIbOm3gjUCREAW+gXf7778+9noB0n4QvqNaC2top
	1JgUDpX8cjfkN+YFt0jALBVaQaySqWswOQOyvYq73eGlObZjeqRR4sUK+DCYEjqAL2Vt/R5JOTW
	lJ/03P0IhBFg5TBXVdS3BF3qVbG6VzqlUU1es/Y4cAQwYDATMdm4FDTHJ0VbMoUleHa//wbRMVe
	9lQr+oHB4Dg9815+ZBN1UPUsr2J7o8v1hx83Wxrd59Wb70jAMFIEQtbfa6k1ARhcCAMsu64QaTz
	atnC2fMj4olixBA8/lQDpLTUqDTtFbs14vCT9ckBwkC2KITx+GACJU74E68+Css3IxJdY+P5x1w
	IPF1vVThz2yr4x91RI5gLtDvfKAVBR2BKaIHc6hYdyJOHA8qoeJbfakJFIs6Az
X-Received: by 2002:a05:6a00:4f93:b0:842:5a8d:3035 with SMTP id d2e1a72fcca58-8425a8d40b9mr621211b3a.22.1780278766531;
        Sun, 31 May 2026 18:52:46 -0700 (PDT)
Received: from u.. (61-222-64-201.hinet-ip.hinet.net. [61.222.64.201])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214d018fcsm8139010b3a.60.2026.05.31.18.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 18:52:45 -0700 (PDT)
From: Tim JH Chen <tim770802@gmail.com>
X-Google-Original-From: Tim JH Chen <tim.jh.chen@wnc.com.tw>
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
	Chih.Hung.Huang@wnc.com.tw
Subject: [PATCH] net: wwan: t7xx: fix race between TX thread and system PM suspend
Date: Mon,  1 Jun 2026 09:52:31 +0800
Message-ID: <20260601015231.3211764-1-tim.jh.chen@wnc.com.tw>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2f9c5f6b-1d8d-4c8b-815d-77a40aa76e23@redhat.com>
References: <2f9c5f6b-1d8d-4c8b-815d-77a40aa76e23@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,mediatek.com,intel.com,linux.intel.com,oss.qualcomm.com,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,kernel.org,vger.kernel.org,wnc.com.tw];
	TAGGED_FROM(0.00)[bounces-293492-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tim770802@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,wnc.com.tw:mid,wnc.com.tw:email]
X-Rspamd-Queue-Id: 6F08E618B17
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When system suspend is triggered while the DPMAIF TX kthread
(t7xx_dpmaif_tx_hw_push_thread) is running, a deadlock can occur
leading to a CPU soft lockup.

The root cause is two-fold:

1. t7xx_dpmaif_suspend() calls t7xx_dpmaif_tx_stop() which only stops
   the TX work-queue items (by clearing txq->que_started and waiting on
   txq->tx_processing). It does NOT signal the kthread and does NOT
   update dpmaif_ctrl->state, which stays DPMAIF_STATE_PWRON.

2. The kthread's state guard is only checked at the top of each loop
   iteration. If the thread already passed this guard, it proceeds
   unconditionally to call pm_runtime_resume_and_get() — which tries to
   acquire dev->power.lock also contended by the system PM suspend path.

The result is a spinlock deadlock observed as:

  watchdog: BUG: soft lockup - CPU#N stuck for 26s! [dpmaif_tx_hw_pu]
  RIP: _raw_spin_unlock_irqrestore
  Call Trace:
    __pm_runtime_resume+0x5b/0x80
    t7xx_dpmaif_tx_hw_push_thread+0xc4 [mtk_t7xx]

The condition requires ASPM L1 enabled on the endpoint (which extends
the time pm_runtime_resume_and_get() holds dev->power.lock during L1.2
link retraining) and hundreds of repeated suspend/resume cycles to
trigger reliably.

Fix by introducing tx_pm_lock (struct mutex) and several coordinated
changes:

t7xx_dpmaif_suspend():
  After t7xx_dpmaif_tx_stop(), acquire tx_pm_lock. Under the lock,
  snapshot dpmaif_ctrl->state into pre_suspend_state (capturing the
  modem state atomically with respect to the kthread's PM section),
  then set DPMAIF_STATE_PWROFF via WRITE_ONCE(). Release the lock
  and call wake_up() so any sleeping kthread re-evaluates the
  wait_event condition and exits.

  t7xx_dpmaif_suspend() acquires tx_pm_lock without holding any PM
  lock. While it waits, the kthread may call pm_runtime_resume_and_get()
  which briefly takes and releases dev->power.lock independently.
  Because the suspend callback does not compete for dev->power.lock at
  this point, the original spinlock deadlock cannot occur. Suspend
  latency increases by at most one TX burst drain time, which is
  bounded by the DRB ring depth.

t7xx_dpmaif_resume():
  When pre_suspend_state is DPMAIF_STATE_PWRON, re-arm the HW fully
  (start_txrx_qs, enable_irq, unmask_dlq_intr, start_hw) before
  publishing the new state. This ensures the kthread cannot issue
  ul_update_hw_drb_cnt() MMIO writes before UL_ALL_Q_EN is set by
  t7xx_dpmaif_start_hw(). Publish the restored state under tx_pm_lock
  to serialise with the kthread's under-lock state check. Wake up the
  kthread only after HW and state are both consistent.

  When pre_suspend_state is DPMAIF_STATE_PWROFF (modem was already
  stopped or in exception before suspend), skip HW re-arming entirely
  to avoid leaving DMA engines running while the MD state machine
  considers the modem inactive.

t7xx_dpmaif_tx_hw_push_thread():
  Hold tx_pm_lock across the [state check -> pm_runtime_resume_and_get
  -> pm_runtime_put_autosuspend] sequence. A second READ_ONCE() state
  check under the lock closes the TOCTOU window between the wait_event
  guard at the loop top and the pm_runtime call. READ_ONCE() is used
  in all unguarded state reads in this function.

t7xx_dpmaif_start() / t7xx_dpmaif_stop():
  Use WRITE_ONCE() for state writes to match the READ_ONCE() reads
  used throughout the driver and prevent compiler optimisations from
  obscuring concurrent access.

t7xx_do_tx_hw_push():
  Use READ_ONCE() in the do/while termination condition to match the
  WRITE_ONCE() annotations on the write side.

t7xx_dpmaif_tx_thread_init():
  Initialise tx_pm_lock with mutex_init().

Note: t7xx_dpmaif_start() and t7xx_dpmaif_stop() (called from the
MD-FSM kthread via t7xx_dpmaif_md_state_callback()) do not hold
tx_pm_lock. A race where the FSM transitions the modem to
DPMAIF_STATE_PWROFF concurrently with the TX kthread's last burst is
pre-existing and not introduced by this patch; the do/while condition
in t7xx_do_tx_hw_push() now re-checks state with READ_ONCE() at each
iteration boundary, limiting exposure to at most one burst.

Tested: no soft lockup observed over 500+ suspend/resume cycles with
SIM registered and ASPM L1 enabled (previously triggered in < 300).

Fixes: 46e8f49ed7b3 ("net: wwan: t7xx: Introduce power management")
Signed-off-by: Tim JH Chen <tim.jh.chen@wnc.com.tw>
---
v2 -> v3:
  Process fixes (per Documentation/process/maintainer-netdev.rst):
  - Add target tree (net) and revision (v3) to subject prefix
  - Fix Fixes tag to point to 46e8f49ed7b3 ("net: wwan: t7xx:
    Introduce power management") instead of a kernel release tag
  - Move version changelog after '---' separator

  Code fixes (addressing AI-assisted code review of v2):
  - Capture pre_suspend_state inside tx_pm_lock (was outside the lock
    in v2), closing a race where a concurrent t7xx_dpmaif_stop() from
    the MD-FSM kthread could flip state between the snapshot and the
    mutex acquisition, causing resume to incorrectly restore PWRON
  - In resume, re-arm HW before publishing state under tx_pm_lock; in
    v2 state was published before t7xx_dpmaif_start_hw(), allowing the
    TX kthread to call ul_update_hw_drb_cnt() while UL_ALL_Q_EN=0
  - Skip HW re-arming in resume when pre_suspend_state==PWROFF, to
    avoid leaving DMA engines and IRQs live when the MD state machine
    considers the modem stopped or in exception
  - Add WRITE_ONCE() to t7xx_dpmaif_start()/stop() state writes and
    READ_ONCE() to t7xx_do_tx_hw_push() while condition
  - Document why pm_runtime_resume_and_get() under tx_pm_lock cannot
    cause a new deadlock against the suspend path
  - Document the pre-existing MD-FSM kthread / TX kthread race

v1 -> v2:
  - Resume no longer unconditionally restores DPMAIF_STATE_PWRON;
    pre_suspend_state saves the pre-suspend modem state across the cycle
  - Replace the second plain state check with mutex (tx_pm_lock) that
    wraps the full pm_runtime section, eliminating the TOCTOU window
    rather than narrowing it
  - Add READ_ONCE/WRITE_ONCE at state accesses crossing the
    suspend/resume boundary

Signed-off-by: Tim JH Chen <tim.jh.chen@wnc.com.tw>
---
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif.c    | 25 ++++++++++++++++------
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif.h    |  3 +++
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c | 18 ++++++++++++----
 3 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif.c b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif.c
index 7ff33c1d6ac7..845a42fdf507 100644
--- a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif.c
+++ b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif.c
@@ -363,7 +363,7 @@ static int t7xx_dpmaif_start(struct dpmaif_ctrl *dpmaif_ctrl)
 
 	t7xx_dpmaif_ul_clr_all_intr(hw_info);
 	t7xx_dpmaif_dl_clr_all_intr(hw_info);
-	dpmaif_ctrl->state = DPMAIF_STATE_PWRON;
+	WRITE_ONCE(dpmaif_ctrl->state, DPMAIF_STATE_PWRON);
 	t7xx_dpmaif_enable_irq(dpmaif_ctrl);
 	wake_up(&dpmaif_ctrl->tx_wq);
 	return 0;
@@ -400,7 +400,7 @@ static int t7xx_dpmaif_stop(struct dpmaif_ctrl *dpmaif_ctrl)
 		return -EFAULT;
 
 	t7xx_dpmaif_disable_irq(dpmaif_ctrl);
-	dpmaif_ctrl->state = DPMAIF_STATE_PWROFF;
+	WRITE_ONCE(dpmaif_ctrl->state, DPMAIF_STATE_PWROFF);
 	t7xx_dpmaif_stop_sw(dpmaif_ctrl);
 	t7xx_dpmaif_tx_clear(dpmaif_ctrl);
 	t7xx_dpmaif_rx_clear(dpmaif_ctrl);
@@ -412,6 +412,11 @@ static int t7xx_dpmaif_suspend(struct t7xx_pci_dev *t7xx_dev, void *param)
 	struct dpmaif_ctrl *dpmaif_ctrl = param;
 
 	t7xx_dpmaif_tx_stop(dpmaif_ctrl);
+	mutex_lock(&dpmaif_ctrl->tx_pm_lock);
+	dpmaif_ctrl->pre_suspend_state = READ_ONCE(dpmaif_ctrl->state);
+	WRITE_ONCE(dpmaif_ctrl->state, DPMAIF_STATE_PWROFF);
+	mutex_unlock(&dpmaif_ctrl->tx_pm_lock);
+	wake_up(&dpmaif_ctrl->tx_wq);
 	t7xx_dpmaif_hw_stop_all_txq(&dpmaif_ctrl->hw_info);
 	t7xx_dpmaif_hw_stop_all_rxq(&dpmaif_ctrl->hw_info);
 	t7xx_dpmaif_disable_irq(dpmaif_ctrl);
@@ -451,11 +456,17 @@ static int t7xx_dpmaif_resume(struct t7xx_pci_dev *t7xx_dev, void *param)
 	if (!dpmaif_ctrl)
 		return 0;
 
-	t7xx_dpmaif_start_txrx_qs(dpmaif_ctrl);
-	t7xx_dpmaif_enable_irq(dpmaif_ctrl);
-	t7xx_dpmaif_unmask_dlq_intr(dpmaif_ctrl);
-	t7xx_dpmaif_start_hw(&dpmaif_ctrl->hw_info);
-	wake_up(&dpmaif_ctrl->tx_wq);
+	if (dpmaif_ctrl->pre_suspend_state == DPMAIF_STATE_PWRON) {
+		t7xx_dpmaif_start_txrx_qs(dpmaif_ctrl);
+		t7xx_dpmaif_enable_irq(dpmaif_ctrl);
+		t7xx_dpmaif_unmask_dlq_intr(dpmaif_ctrl);
+		t7xx_dpmaif_start_hw(&dpmaif_ctrl->hw_info);
+	}
+	mutex_lock(&dpmaif_ctrl->tx_pm_lock);
+	WRITE_ONCE(dpmaif_ctrl->state, dpmaif_ctrl->pre_suspend_state);
+	mutex_unlock(&dpmaif_ctrl->tx_pm_lock);
+	if (dpmaif_ctrl->pre_suspend_state == DPMAIF_STATE_PWRON)
+		wake_up(&dpmaif_ctrl->tx_wq);
 	return 0;
 }
 
diff --git a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif.h b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif.h
index 0ce4505e813d..670ed2cca761 100644
--- a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif.h
+++ b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif.h
@@ -20,6 +20,7 @@
 
 #include <linux/bitmap.h>
 #include <linux/mm_types.h>
+#include <linux/mutex.h>
 #include <linux/netdevice.h>
 #include <linux/sched.h>
 #include <linux/skbuff.h>
@@ -172,6 +173,8 @@ struct dpmaif_ctrl {
 	struct t7xx_pci_dev		*t7xx_dev;
 	struct md_pm_entity		dpmaif_pm_entity;
 	enum dpmaif_state		state;
+	enum dpmaif_state		pre_suspend_state;
+	struct mutex			tx_pm_lock;
 	bool				dpmaif_sw_init_done;
 	struct dpmaif_hw_info		hw_info;
 	struct dpmaif_tx_queue		txq[DPMAIF_TXQ_NUM];
diff --git a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c
index 236d632cf591..e278e9703c69 100644
--- a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c
+++ b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c
@@ -439,7 +439,7 @@ static void t7xx_do_tx_hw_push(struct dpmaif_ctrl *dpmaif_ctrl)
 
 		cond_resched();
 	} while (!t7xx_tx_lists_are_all_empty(dpmaif_ctrl) && !kthread_should_stop() &&
-		 (dpmaif_ctrl->state == DPMAIF_STATE_PWRON));
+		 READ_ONCE(dpmaif_ctrl->state) == DPMAIF_STATE_PWRON);
 }
 
 static int t7xx_dpmaif_tx_hw_push_thread(void *arg)
@@ -449,10 +449,10 @@ static int t7xx_dpmaif_tx_hw_push_thread(void *arg)
 
 	while (!kthread_should_stop()) {
 		if (t7xx_tx_lists_are_all_empty(dpmaif_ctrl) ||
-		    dpmaif_ctrl->state != DPMAIF_STATE_PWRON) {
+		    READ_ONCE(dpmaif_ctrl->state) != DPMAIF_STATE_PWRON) {
 			if (wait_event_interruptible(dpmaif_ctrl->tx_wq,
 						     (!t7xx_tx_lists_are_all_empty(dpmaif_ctrl) &&
-						     dpmaif_ctrl->state == DPMAIF_STATE_PWRON) ||
+						     READ_ONCE(dpmaif_ctrl->state) == DPMAIF_STATE_PWRON) ||
 						     kthread_should_stop()))
 				continue;
 
@@ -460,14 +460,23 @@ static int t7xx_dpmaif_tx_hw_push_thread(void *arg)
 				break;
 		}
 
+		mutex_lock(&dpmaif_ctrl->tx_pm_lock);
+		if (READ_ONCE(dpmaif_ctrl->state) != DPMAIF_STATE_PWRON) {
+			mutex_unlock(&dpmaif_ctrl->tx_pm_lock);
+			continue;
+		}
+
 		ret = pm_runtime_resume_and_get(dpmaif_ctrl->dev);
-		if (ret < 0 && ret != -EACCES)
+		if (ret < 0 && ret != -EACCES) {
+			mutex_unlock(&dpmaif_ctrl->tx_pm_lock);
 			return ret;
+		}
 
 		t7xx_pci_disable_sleep(dpmaif_ctrl->t7xx_dev);
 		t7xx_do_tx_hw_push(dpmaif_ctrl);
 		t7xx_pci_enable_sleep(dpmaif_ctrl->t7xx_dev);
 		pm_runtime_put_autosuspend(dpmaif_ctrl->dev);
+		mutex_unlock(&dpmaif_ctrl->tx_pm_lock);
 	}
 
 	return 0;
@@ -475,6 +484,7 @@ static int t7xx_dpmaif_tx_hw_push_thread(void *arg)
 
 int t7xx_dpmaif_tx_thread_init(struct dpmaif_ctrl *dpmaif_ctrl)
 {
+	mutex_init(&dpmaif_ctrl->tx_pm_lock);
 	init_waitqueue_head(&dpmaif_ctrl->tx_wq);
 	dpmaif_ctrl->tx_thread = kthread_run(t7xx_dpmaif_tx_hw_push_thread,
 					     dpmaif_ctrl, "dpmaif_tx_hw_push");
-- 
2.43.0


