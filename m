Return-Path: <netdev+bounces-294900-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qV5wOH+HIGr04gAAu9opvQ
	(envelope-from <netdev+bounces-294900-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 21:58:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D8263B058
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 21:58:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=oAVYziE5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294900-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-294900-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DC52F3018144
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 19:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39103909A4;
	Wed,  3 Jun 2026 19:58:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD49739E9D5
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 19:58:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780516730; cv=none; b=RmAjNDjzW4ZhiYIYlNsyG2QlWio2zDBCmWhnFvYZGgvqKinwUkuUIsr7Q6QTz1mdhDv/ouiKO0CsUtIu+DCnA4IhnY3FfBh6dWfZzY44ktt538NG2USSIbfaRCh6gx7DPf7AKct6FX2Fe3PE/HswXElOLPa9nomLc7+4aVrSRt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780516730; c=relaxed/simple;
	bh=hJDm0TGcNDYbdbKcQRxv0dE0EdXmmALt5begQmD/AME=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nsxuquPPf7cknbEqTMCCglWrAuzjwG6LD0kZo8HfYkWCa/XOFYLw6of0jp1GYrolbD1AKXLYu6K5dd4FqcsDFTfkI7EWtlgAGpJ/TUqP2swUhAZa7J9u7JhT9ttXKV1B44vsOTyH0skWXZ4gymXrdXWy+Lr+pcOpE2EZFhMI/tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oAVYziE5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29121F00893;
	Wed,  3 Jun 2026 19:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780516729;
	bh=KKztiED9hy6zkgkyjZPTXiaI/GO9VpJlGOa695N0ZWE=;
	h=From:To:Cc:Subject:Date;
	b=oAVYziE5W1wbNvlzV45mJ+PLOEH684VD0+yfWLCJQdrHfCsnv1w69jaK3EcqoWiAI
	 LgYDT7+zwLazX2n7/JhWebbmCgEDgBP8g7eluttbVQ6rtd2x96zjhROUU1aWWdfAjL
	 WR3jwU9+/MFi05WUpUAcy9aIttdVxlddhfpu5YyQSUtHYDPG9UTqfc93DXtS8yfvSP
	 2tSEAMDOJBBlrUL7hGB6w1hRvCvU1+siUzB9IApJoTx7NWiZoQZwCvCwjCx8nHaP4U
	 Bt83jWV9G4jjpGYrDFRqVdMpS4lWDY+edv9K1DB3EjqbjFEKNDd6zErs4J4NuAbJ8I
	 i16CsdYfmXxlQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	sdf@fomichev.me,
	aleksandr.loktionov@intel.com
Subject: [PATCH net] Reapply "bnxt_en: bring back rtnl_lock() in the bnxt_open() path"
Date: Wed,  3 Jun 2026 12:58:45 -0700
Message-ID: <20260603195845.2574426-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:kuba@kernel.org,m:leitao@debian.org,m:michael.chan@broadcom.com,m:pavan.chebbi@broadcom.com,m:sdf@fomichev.me,m:aleksandr.loktionov@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-294900-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,fomichev.me:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D4D8263B058

This reverts commit 850d9248d2eac662f869c766a598c877690c74e5.
This reapplies commit 325eb217e41f ("bnxt_en: bring back rtnl_lock()
in the bnxt_open() path").

Breno reports a lockdep warning in bnxt. During FW reset the driver
may end up calling netif_set_real_num_tx_queues() (if queue count
changes), so calls to bnxt_open() still require rtnl_lock.

  net/sched/sch_generic.c:1416 suspicious rcu_dereference_protected() usage!

   dev_qdisc_change_real_num_tx+0x54/0xe0
   netif_set_real_num_tx_queues+0x4ed/0xa80
   __bnxt_open_nic+0x9cb/0x3490
   bnxt_open+0x1cb/0x370
   bnxt_fw_reset_task+0x80d/0x1e80
   process_scheduled_works+0x9c1/0x13b0

The reverted commit was just an optimization / experiment
so let's go back to taking the lock.

Reported-by: Breno Leitao <leitao@debian.org>
Link: https://lore.kernel.org/ah726OtFX-Qw3U-R@gmail.com
Fixes: 850d9248d2ea ("Revert "bnxt_en: bring back rtnl_lock() in the bnxt_open() path"")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: michael.chan@broadcom.com
CC: pavan.chebbi@broadcom.com
CC: sdf@fomichev.me
CC: aleksandr.loktionov@intel.com
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 36 ++++++++++++++++++-----
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 008c34cff7b4..35e1f8f663c7 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -14388,13 +14388,28 @@ static void bnxt_unlock_sp(struct bnxt *bp)
 	netdev_unlock(bp->dev);
 }
 
+/* Same as bnxt_lock_sp() with additional rtnl_lock */
+static void bnxt_rtnl_lock_sp(struct bnxt *bp)
+{
+	clear_bit(BNXT_STATE_IN_SP_TASK, &bp->state);
+	rtnl_lock();
+	netdev_lock(bp->dev);
+}
+
+static void bnxt_rtnl_unlock_sp(struct bnxt *bp)
+{
+	set_bit(BNXT_STATE_IN_SP_TASK, &bp->state);
+	netdev_unlock(bp->dev);
+	rtnl_unlock();
+}
+
 /* Only called from bnxt_sp_task() */
 static void bnxt_reset(struct bnxt *bp, bool silent)
 {
-	bnxt_lock_sp(bp);
+	bnxt_rtnl_lock_sp(bp);
 	if (test_bit(BNXT_STATE_OPEN, &bp->state))
 		bnxt_reset_task(bp, silent);
-	bnxt_unlock_sp(bp);
+	bnxt_rtnl_unlock_sp(bp);
 }
 
 /* Only called from bnxt_sp_task() */
@@ -14402,9 +14417,9 @@ static void bnxt_rx_ring_reset(struct bnxt *bp)
 {
 	int i;
 
-	bnxt_lock_sp(bp);
+	bnxt_rtnl_lock_sp(bp);
 	if (!test_bit(BNXT_STATE_OPEN, &bp->state)) {
-		bnxt_unlock_sp(bp);
+		bnxt_rtnl_unlock_sp(bp);
 		return;
 	}
 	/* Disable and flush TPA before resetting the RX ring */
@@ -14443,7 +14458,7 @@ static void bnxt_rx_ring_reset(struct bnxt *bp)
 	}
 	if (bp->flags & BNXT_FLAG_TPA)
 		bnxt_set_tpa(bp, true);
-	bnxt_unlock_sp(bp);
+	bnxt_rtnl_unlock_sp(bp);
 }
 
 static void bnxt_fw_fatal_close(struct bnxt *bp)
@@ -15358,15 +15373,17 @@ static void bnxt_fw_reset_task(struct work_struct *work)
 		bp->fw_reset_state = BNXT_FW_RESET_STATE_OPENING;
 		fallthrough;
 	case BNXT_FW_RESET_STATE_OPENING:
-		while (!netdev_trylock(bp->dev)) {
+		while (!rtnl_trylock()) {
 			bnxt_queue_fw_reset_work(bp, HZ / 10);
 			return;
 		}
+		netdev_lock(bp->dev);
 		rc = bnxt_open(bp->dev);
 		if (rc) {
 			netdev_err(bp->dev, "bnxt_open() failed during FW reset\n");
 			bnxt_fw_reset_abort(bp, rc);
 			netdev_unlock(bp->dev);
+			rtnl_unlock();
 			goto ulp_start;
 		}
 
@@ -15386,6 +15403,7 @@ static void bnxt_fw_reset_task(struct work_struct *work)
 			bnxt_dl_health_fw_status_update(bp, true);
 		}
 		netdev_unlock(bp->dev);
+		rtnl_unlock();
 		bnxt_ulp_start(bp);
 		bnxt_reenable_sriov(bp);
 		netdev_lock(bp->dev);
@@ -16379,7 +16397,7 @@ static int bnxt_queue_start(struct net_device *dev,
 		   rc);
 	napi_enable_locked(&bnapi->napi);
 	bnxt_db_nq_arm(bp, &cpr->cp_db, cpr->cp_raw_cons);
-	bnxt_reset_task(bp, true);
+	netif_close(dev);
 	return rc;
 }
 
@@ -17230,6 +17248,7 @@ static int bnxt_resume(struct device *device)
 	struct bnxt *bp = netdev_priv(dev);
 	int rc = 0;
 
+	rtnl_lock();
 	netdev_lock(dev);
 	rc = pci_enable_device(bp->pdev);
 	if (rc) {
@@ -17274,6 +17293,7 @@ static int bnxt_resume(struct device *device)
 
 resume_exit:
 	netdev_unlock(bp->dev);
+	rtnl_unlock();
 	if (!rc) {
 		bnxt_ulp_start(bp);
 		bnxt_reenable_sriov(bp);
@@ -17445,6 +17465,7 @@ static void bnxt_io_resume(struct pci_dev *pdev)
 	int err;
 
 	netdev_info(bp->dev, "PCI Slot Resume\n");
+	rtnl_lock();
 	netdev_lock(netdev);
 
 	err = bnxt_hwrm_func_qcaps(bp);
@@ -17462,6 +17483,7 @@ static void bnxt_io_resume(struct pci_dev *pdev)
 		netif_device_attach(netdev);
 
 	netdev_unlock(netdev);
+	rtnl_unlock();
 	if (!err) {
 		bnxt_ulp_start(bp);
 		bnxt_reenable_sriov(bp);
-- 
2.54.0


