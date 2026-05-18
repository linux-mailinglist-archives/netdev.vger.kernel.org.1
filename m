Return-Path: <netdev+bounces-288905-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPVsImrGCmqg8AQAu9opvQ
	(envelope-from <netdev+bounces-288905-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 09:57:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F184D568405
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 09:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 86D6D3077C9A
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 07:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886283E122B;
	Mon, 18 May 2026 07:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpVSU/on"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530513E0724
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 07:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779090649; cv=none; b=C++Rwg9RZYqaiJlaEPuGp0Hj7sAGr3Y/w7qIOFITMGRb5HFizk3MokiaY0I/fh3v2tyNm+MbPWv0b83FSogn/LrAzFKry95U7Vx2Woa7IiORjIA2ojxpjmgsx8v/p5cdgGZnFt+HTrl/jSONw+anvWVQrgQaVQcIcdFpsnx9S8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779090649; c=relaxed/simple;
	bh=7jIebGwmF0iENb0ALG6d7MlUOZ/qqAzxPqxbRGSUgXU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UMzu9Eke7TFUnAwE12L+pdHVKV71icVJumFOvKimWhjx2ZW2kWgpPWAv7WlszRew74ssKJZdODum+VDcNTk2QRtURJHxn7JRFzOan2IuEbhSD5tDQDc3k6tmhQPkv8g9IVgFbfDv+HHRAUhWPmvkPLo4MDH5Ah9khfzwIcXIuLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dpVSU/on; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-36974221f93so756464a91.2
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 00:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779090644; x=1779695444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tzisouNi0YPd87k664ptzNj9xQbIRLyhwzkMQ6zJ85Y=;
        b=dpVSU/on/vo+fSBcS+hP4T+BfGkqlrTwK8GNJqxNaQKd4q7Iig76Nj8weE63adxCTV
         uksMVYsAMWqH9cpqqgbKisgbMUfeOaRNRs7kmWfBYwJZrJc1c/IXeeOwm05aIPMu0dMT
         iodfZ83m4NBhX+a8NnimM72kPGWOJy33KxlHxKDYEXkDTX0wK996etAlaeH+BDd4+bXU
         5w2HSYGlqe81sgdtQXctLkVx73MMI6tfQO8DqhE1F1GmKvq0fm3LTKzcEssYbC+1Dtnk
         6TD0U2zbVMKCRe4P/5PtHiYh36+T2p2Tn7Itoo+yHLPMP3SGsuHaPZn0RWzLUzxKOm6L
         sKuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779090644; x=1779695444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tzisouNi0YPd87k664ptzNj9xQbIRLyhwzkMQ6zJ85Y=;
        b=iFSsFZOiWKiKTYuf7EMiceRsmZcFUsWNAdLU5oLdHSRGqPcTMOJmgsiV1BV2rOanaa
         +kFMLN3IeezE45AJVO93ru32UOa4NhOzZg2v8LyfE95D6wEG8fXKOAmcd+xjP6Rwn+jo
         I8xAMADiWW+6Rv4Wu6UMogjfSebDnWZaol9laFTWuyYlB+jg3SKfLec+DOYptC/pRkGC
         Uuz7wKkZpU9JH90ZX0MePVILdxTa3DH6JbmCYpNi6obl7C+4T83pQCc1I76UdGaRLF0m
         MfieFhxKs1E0+XO3JgU/h4YznxGNX+rjOlHYzsfsWJIAwG/OGuhDxY6B5gYTmt8jP+7w
         RKBw==
X-Gm-Message-State: AOJu0YyoNaqkX+bPIyR7sRIl58jOFgoUf5ez+yzEU4Uro4DZyqjof34F
	6zWkaZYnKS4BK1xuGwSTNqP2NYbdGs8cFbH0Egg4iAlvxC6N1OlzKiE6M2exKXyg
X-Gm-Gg: Acq92OFxZ0TCY/xenjLCsuWueTcbQjTjS/MXLTUcEW51TKw/dXPkpHoVQ6XGVcz/GjK
	51sGwc8kF+S7U+reS8N9mphy/6yGEku7DoNc6F+VLVDCkZ2j1nSW6wxmPfMWZMAp7PPAwUVORVB
	d83bgHoQak93Qlkpb3bm7cyddDz5FbiLWdVYhQe4MVJxp/L0OArDjpzAWGm90cyiWjpGmfH9v8A
	+2vE0TJx0DkhGyJGu2yjr7ijRjEeyRLBvDzsNj0RScNXlakgow7XRfATFSgqPS4e/7CEp/nqJlf
	sAYNJWeJeFoJKukr9dH5+5DtxWx2yurwn9I796qLwqUGFPI7WW3bueOqo+zy4/F/QSnOKjIYDdw
	yVzpt9iA0neZxL498vaJMIUadvpkRaiduotJ+HmhVDQ9jRUFjkBfwrsxkJZJxjJDnTFHFNXbZth
	/9EZ/u3cllPCFwFz/vx0nBXBhpqY5TemNwUzTkDDuPvDcmFbLntg==
X-Received: by 2002:a17:90b:57e4:b0:367:b819:2214 with SMTP id 98e67ed59e1d1-36951b82d4dmr14219312a91.13.1779090643586;
        Mon, 18 May 2026 00:50:43 -0700 (PDT)
Received: from u.. (61-222-64-201.hinet-ip.hinet.net. [61.222.64.201])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36970422515sm3361487a91.4.2026.05.18.00.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 00:50:43 -0700 (PDT)
From: Tim JH Chen <tim770802@gmail.com>
X-Google-Original-From: Tim JH Chen <tim.jh.chen@wnc.com.tw>
To: netdev@vger.kernel.org
Cc: Tim JH Chen <tim.jh.chen@wnc.com.tw>,
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
	Liu Haijun <haijun.liu@mediatek.com>,
	Ricardo Martinez <ricardo.martinez@linux.intel.com>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] net: wwan: t7xx: fix race between TX thread and system PM suspend
Date: Mon, 18 May 2026 15:50:33 +0800
Message-ID: <20260518075033.58996-1-tim.jh.chen@wnc.com.tw>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F184D568405
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288905-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[wnc.com.tw,intel.com,mediatek.com,linux.intel.com,oss.qualcomm.com,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tim770802@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,wnc.com.tw:email,wnc.com.tw:mid]
X-Rspamd-Action: no action

When system suspend is triggered while the DPMAIF TX kthread
(t7xx_dpmaif_tx_hw_push_thread) is running, a deadlock can occur
leading to a CPU soft lockup.

The root cause is two-fold:

1. t7xx_dpmaif_suspend() calls t7xx_dpmaif_tx_stop() which only stops
   the TX work-queue items (by clearing txq->que_started and waiting on
   txq->tx_processing). It does NOT signal the kthread and does NOT
   update dpmaif_ctrl->state, which stays DPMAIF_STATE_PWRON.

2. The kthread's state guard (line: "if ... state != DPMAIF_STATE_PWRON")
   is only checked at the top of each loop iteration. If the thread
   already passed this guard, it proceeds unconditionally to call
   pm_runtime_resume_and_get() — which tries to acquire the PM spinlock
   also held (or contended) by the system PM suspend path.

The result is a spinlock deadlock observed as:

  watchdog: BUG: soft lockup - CPU#N stuck for 26s! [dpmaif_tx_hw_pu]
  RIP: _raw_spin_unlock_irqrestore
  Call Trace:
    __pm_runtime_resume+0x5b/0x80
    t7xx_dpmaif_tx_hw_push_thread+0xc4 [mtk_t7xx]

The condition requires ASPM L1 enabled on the endpoint (which extends
the time pm_runtime_resume_and_get() holds the PM lock during L1.2
link retraining) and hundreds of repeated suspend/resume cycles to
trigger reliably.

Fix by three coordinated changes:

- In t7xx_dpmaif_suspend(): immediately set state to DPMAIF_STATE_PWROFF
  after stopping the TX queue, then call wake_up() so any sleeping thread
  re-evaluates the wait_event condition and stops.

- In t7xx_dpmaif_resume(): restore state to DPMAIF_STATE_PWRON before
  re-enabling the TX queues, symmetric with the suspend change.
  Without this the kthread would never wake up after resume.

- In t7xx_dpmaif_tx_hw_push_thread(): add a second state check
  immediately before pm_runtime_resume_and_get() to close the TOCTOU
  window between the wait_event guard and the pm call.

Tested: no soft lockup observed over 500+ suspend/resume cycles with
SIM registered and ASPM L1 enabled (previously triggered in < 300).

Signed-off-by: Tim JH Chen <tim.jh.chen@wnc.com.tw>
---
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif.c    | 3 +++
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif.c b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif.c
index 7ff33c1d6..315a77e24 100644
--- a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif.c
+++ b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif.c
@@ -412,6 +412,8 @@ static int t7xx_dpmaif_suspend(struct t7xx_pci_dev *t7xx_dev, void *param)
 	struct dpmaif_ctrl *dpmaif_ctrl = param;
 
 	t7xx_dpmaif_tx_stop(dpmaif_ctrl);
+	dpmaif_ctrl->state = DPMAIF_STATE_PWROFF;
+	wake_up(&dpmaif_ctrl->tx_wq);
 	t7xx_dpmaif_hw_stop_all_txq(&dpmaif_ctrl->hw_info);
 	t7xx_dpmaif_hw_stop_all_rxq(&dpmaif_ctrl->hw_info);
 	t7xx_dpmaif_disable_irq(dpmaif_ctrl);
@@ -451,6 +453,7 @@ static int t7xx_dpmaif_resume(struct t7xx_pci_dev *t7xx_dev, void *param)
 	if (!dpmaif_ctrl)
 		return 0;
 
+	dpmaif_ctrl->state = DPMAIF_STATE_PWRON;
 	t7xx_dpmaif_start_txrx_qs(dpmaif_ctrl);
 	t7xx_dpmaif_enable_irq(dpmaif_ctrl);
 	t7xx_dpmaif_unmask_dlq_intr(dpmaif_ctrl);
diff --git a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c
index 236d632cf..d5a5befec 100644
--- a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c
+++ b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c
@@ -460,6 +460,9 @@ static int t7xx_dpmaif_tx_hw_push_thread(void *arg)
 				break;
 		}
 
+		if (dpmaif_ctrl->state != DPMAIF_STATE_PWRON)
+			continue;
+
 		ret = pm_runtime_resume_and_get(dpmaif_ctrl->dev);
 		if (ret < 0 && ret != -EACCES)
 			return ret;
-- 
2.25.1


