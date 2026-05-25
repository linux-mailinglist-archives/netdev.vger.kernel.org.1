Return-Path: <netdev+bounces-291233-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FAcHXu+E2qyFQcAu9opvQ
	(envelope-from <netdev+bounces-291233-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 05:14:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5565C5883
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 05:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CAC3301348F
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 03:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992132D7D59;
	Mon, 25 May 2026 03:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dziHZ3HQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C5A2D661C
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 03:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779678810; cv=none; b=h0QkjVjyjpMjED92M+laPm5JmchqmBE9W59Yksdrx3foUPUjNaCqjT29I68xIHrBMMP/HMrJtMn3ebfzftPXBPkRf0kvGoUuzeL05ASsDKg2LHv6xJYEqm9xPTygXy0tO10QUZfQGou7GkVYC7W5YhE939pypu1fg70OZQPfjbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779678810; c=relaxed/simple;
	bh=KbCWJ56Ztr142YoKNAdVXlh/YvFieGfstI9Yb2Sqkrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a4PyFu7QL3fvXW72nZSLWcOIEaEUpH73zRUKym2jhjDa4/7N4dPubndWQO7utoStPTdw1MWYL34p5ECsh4+HjLV7CNYWH6zmpo2yltWC9cIt1gnB6Gp9LzbylVxiOHx8C2xf7FJOfLIS/VKmYV9ud158+qIWi2cHFFA3e97tOzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dziHZ3HQ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82faf871346so7109004b3a.0
        for <netdev@vger.kernel.org>; Sun, 24 May 2026 20:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779678808; x=1780283608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OwxZUNNLw1PFWW1oO7q8KXR63/wpofHqbMGlju32jag=;
        b=dziHZ3HQiJS2CYJQNWfaAAv0fRjST6sPpVLLsx6wgICuym214dd2PFYMo9kqJjKMSW
         fkuW8JmP3VrRw7fdiOMWFNw4HDKuXMDRIqIzdfBA8fiED8fWKGjZz6ZWRdHxCcOKw7JI
         t1LtNqgnCztFGeDcrmbG7X9TajFS/yCbPwCITD2xqLbGXqneD7e219eB6vrrZrTvSbdF
         jMQIntd14O/+MT1bE/GvYQmdA7kGjUZOv55Rr6NxLGwJ+3TY2S9i3t1tmBo9OPLCWaOz
         OhfQWrmL0K2aVFbFPZgpJR10cZgCN/Qmh6/uqEfUR0ygFTAzIQSjftWLqmhQ7M36nvpP
         sbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779678808; x=1780283608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OwxZUNNLw1PFWW1oO7q8KXR63/wpofHqbMGlju32jag=;
        b=ONoexYYDlNOaYtIViq3XJX//fl/2JcbLRyzefy23pKpdrBp65fiPv0I6q+bSS6KJRH
         eJ726hnIODmsFtzMuQAwuaIpL4TQV2de9kuNDZTKLX98fDCJfdhgKYkmX0aNzE8r4fDI
         8St92KM45P3tAAcAlyOGIvMyB1DPz9VT2BbGVQl5SX1+N83YeJJyhEjX2EYq+DWA1hXv
         4kr9k5ZvxQTf/ZJoDjaYLh3uFn/zPYXe7Rfr6v/HnCjGWKdgNa9zGURB4j/qFKC34g28
         qTrqqT3QGPc94D0sNzTQFxOMW7rLT7nDiWri2GtNpUQJXh/YgcM5jhh4EMYqrjmX2Mn0
         c3aw==
X-Gm-Message-State: AOJu0YzSWWiwiTHJLWLjfR/5ATvFVmwFKEVhPMw7Zkos8biCztcf8ubr
	vLdjX+35QClgtSAsWJC+HrbVdxlKxju5uuR2CCbQC8QAQbypgiRJJgqFGHw8gIOz
X-Gm-Gg: Acq92OGlmayfD9HAGLlWpMizhZvlA5gV5pyrSVNn83Lw5OI3GlYyva9w90VjLCVlUFx
	mIYgb31EpKgm7/I0Fpb8btJFAGEn0RpZx2BmhldRdijQ2ZIyUmyNrBngVU+qPXnuFhQxup80prg
	lu4yWGgtSA8dvttnHYHe1nmjeatX3zKPQetLSRFjQuKJo939hxgg87Rmz0ZTydibuMwq9CVz6g2
	LSWtJW+NDujr3bf7W/Yr+orFVAFSVoVGoM4rHn9qMHbJBrPikal72B3W3bEH+Yigh4Sf4D/C9PJ
	yLOUakiRvo0N9v16oPMkVnaoax4Disn23DG7qig/scUwOAkskM314ZulQAStIGhtIcZdYhSxHEi
	TcGkhU0+C9sJAkIeqpfZz96KZOWg9OJ0U1KpDxBrBQosyk0lgZVHWBb14KuHbwg2FX1UMQv7ZyS
	ue+Xcp+bR3auPbsKEmD6aW91yB1r3zMnTfDZm4yzQfZAWvYkZiOJTfVOXnhWPf
X-Received: by 2002:a05:6a00:188c:b0:835:6e77:1bbc with SMTP id d2e1a72fcca58-8415f61b465mr11516369b3a.36.1779678808333;
        Sun, 24 May 2026 20:13:28 -0700 (PDT)
Received: from u.. (61-222-64-201.hinet-ip.hinet.net. [61.222.64.201])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164ac9a42sm9134237b3a.8.2026.05.24.20.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 20:13:27 -0700 (PDT)
From: Tim JH Chen <tim770802@gmail.com>
X-Google-Original-From: Tim JH Chen <tim.jh.chen@wnc.com.tw>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	tim.jh.chen@wnc.com.tw,
	Chih.Hung.Huang@wnc.com.tw
Subject: [PATCH] net: wwan: t7xx: fix race between TX thread and system PM suspend
Date: Mon, 25 May 2026 11:13:20 +0800
Message-ID: <20260525031320.519435-1-tim.jh.chen@wnc.com.tw>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <5315a3b0-4fc8-4d74-8e27-d7b84bd794c9@redhat.com>
References: <5315a3b0-4fc8-4d74-8e27-d7b84bd794c9@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-291233-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tim770802@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CA5565C5883
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

v2: Address two concerns raised in AI-assisted code review of v1:

1. [High] t7xx_dpmaif_resume() was unconditionally restoring state to
   DPMAIF_STATE_PWRON regardless of the state before suspend.  If the
   modem had already been moved to DPMAIF_STATE_PWROFF by
   t7xx_dpmaif_md_state_callback() (MD_STATE_EXCEPTION or
   MD_STATE_STOPPED) prior to system suspend, resume would incorrectly
   re-arm the TX kthread guard, allowing TX HW writes against a modem
   the MD state machine considers stopped or in exception.

   Fix: save dpmaif_ctrl->state into pre_suspend_state at the start of
   t7xx_dpmaif_suspend() and restore that saved value in
   t7xx_dpmaif_resume(), so a pre-suspend PWROFF is preserved across
   the suspend/resume cycle.

2. [Medium] The v1 second state check before pm_runtime_resume_and_get()
   only narrowed the TOCTOU window -- it did not close it.  The state
   field was a plain enum read and written without any lock or
   READ_ONCE/WRITE_ONCE annotation.  After the check passed on one CPU,
   the suspend path on another CPU could still set state=PWROFF and
   begin PM teardown before the kthread reached pm_runtime_resume_and_get(),
   reproducing the deadlock.

   Fix: introduce tx_pm_lock (struct mutex) held by the kthread across
   the [state check -> pm_runtime_resume_and_get -> pm_runtime_put]
   sequence.  t7xx_dpmaif_suspend() acquires this lock before setting
   DPMAIF_STATE_PWROFF, which serialises with any in-progress kthread
   PM section and guarantees the kthread cannot enter
   pm_runtime_resume_and_get() after the state flag is set.
   READ_ONCE/WRITE_ONCE are added at every access point of the state
   flag that crosses the suspend/resume boundary to prevent
   compiler-visible tearing.

The original v1 description of the root cause and tested fix still
applies (deadlock between t7xx_dpmaif_tx_hw_push_thread calling
pm_runtime_resume_and_get() and the system PM suspend path, triggered
with ASPM L1 enabled after repeated suspend/resume cycles).

Tested: no soft lockup over 500+ suspend/resume cycles with SIM
registered and ASPM L1 enabled (previously triggered in < 300).

Fixes: 05f7e89ab ("Linux 6.19")
Signed-off-by: Tim JH Chen <tim.jh.chen@wnc.com.tw>
---
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif.c    |  6 ++++++
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif.h    |  3 +++
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c | 16 +++++++++++++---
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif.c b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif.c
index 7ff33c1d6ac7..e1f3eeb2c947 100644
--- a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif.c
+++ b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif.c
@@ -412,6 +412,11 @@ static int t7xx_dpmaif_suspend(struct t7xx_pci_dev *t7xx_dev, void *param)
 	struct dpmaif_ctrl *dpmaif_ctrl = param;
 
 	t7xx_dpmaif_tx_stop(dpmaif_ctrl);
+	dpmaif_ctrl->pre_suspend_state = READ_ONCE(dpmaif_ctrl->state);
+	mutex_lock(&dpmaif_ctrl->tx_pm_lock);
+	WRITE_ONCE(dpmaif_ctrl->state, DPMAIF_STATE_PWROFF);
+	mutex_unlock(&dpmaif_ctrl->tx_pm_lock);
+	wake_up(&dpmaif_ctrl->tx_wq);
 	t7xx_dpmaif_hw_stop_all_txq(&dpmaif_ctrl->hw_info);
 	t7xx_dpmaif_hw_stop_all_rxq(&dpmaif_ctrl->hw_info);
 	t7xx_dpmaif_disable_irq(dpmaif_ctrl);
@@ -451,6 +456,7 @@ static int t7xx_dpmaif_resume(struct t7xx_pci_dev *t7xx_dev, void *param)
 	if (!dpmaif_ctrl)
 		return 0;
 
+	WRITE_ONCE(dpmaif_ctrl->state, dpmaif_ctrl->pre_suspend_state);
 	t7xx_dpmaif_start_txrx_qs(dpmaif_ctrl);
 	t7xx_dpmaif_enable_irq(dpmaif_ctrl);
 	t7xx_dpmaif_unmask_dlq_intr(dpmaif_ctrl);
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
index 236d632cf591..197c0ab3fd39 100644
--- a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c
+++ b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c
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


