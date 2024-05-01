Return-Path: <netdev+bounces-92674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C85E98B83BD
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 02:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52699284727
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 00:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84ABB1847;
	Wed,  1 May 2024 00:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aBA0hqWQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F2D8BFF
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 00:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714523509; cv=none; b=EEx6koxESScvAhp9cyxtVghSeL76l2iKCQE9YZiHfPBpBszIzC3U9zcpITqEEMdNOYK17qUGwpnaeskLPklMMeMbp72QaIRFejQXcIWTJIXowbkxj38TZEA9/4kJeciX+izO2gqXxqFZia7O7Ic/YFtzUXgyKuig5CCpWpG4lhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714523509; c=relaxed/simple;
	bh=cMyPFqkFuwstrdUF1NCwAUvrywlVY+Z9nMCQxPIdiCc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cfLWM43YBX1CAjS4eqrvnUcH7GX9Y5pQYsZFAcgGtADsz+AbHAQFHVEz4VcFiyyYcU0T0Cn0TmukEVlaesAZ28pPZvvjg3K8qTApjAwV9uhYnO1tql1l96HiwtwEqXp9+ROtKDxCTF1TEYMB97tvnzCWeKsTGHrlZfw2ZEARo0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aBA0hqWQ; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4347cbdb952so30087791cf.3
        for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 17:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1714523506; x=1715128306; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=E0WPM4xlTdKtuE2ZeS60MwKrswgj/zi3l94KqrLrpGM=;
        b=aBA0hqWQPCBm5nyBO/44+D2XF0WFkgDgpPCa78hMLGcso/elqaflshp5iSa4GGzBxq
         2k/49fwk+UUcD0QeMsafZ7HqY+l0jb+e1avhX1Ra2kXBOS98aG3QDDXPJ+F82pr38vAO
         ZEbdjjorSfWX0YHIEe2+pI+G4SQ9GxQlp0dXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714523506; x=1715128306;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E0WPM4xlTdKtuE2ZeS60MwKrswgj/zi3l94KqrLrpGM=;
        b=Xe16povbNU+piOSFblEM2GF3/WXlQ++J76EDNQ8qQCDR0vTBPIrP6amSjZCNfD/gwr
         myLby37K1bwOBiJiUpF54yFHu3/HXDveZ2/fba1GP3vZ4XjaF1I2sFE2Ec+xkSi+2Nyd
         evTjZ9OHXjQlyhe6xhk98kibhQ2ONP8BL1JqKaPbms/LKmFuyJUKLtImQ+8m2FM8fnHI
         pD5ddXNApPopqUqAZTsd95ZSgb5R5fmyCTLkXCVXXbOFZviLNAFTORc1Gx8+GoI6Er40
         sFfDsvWW5fTcxs/e3MvIazIzjDfn6xcG0xDpwcheNHmGucvol1J8KbxcPZcNwQEJsNUI
         CycQ==
X-Gm-Message-State: AOJu0Yw9IZw7OA8MTby6NRFmnyrxlFlYS8tMpM6pCrMuJoWouvtJC082
	GQIsgWrthc7H/ZfJeKPl4lb2DQOuFhcsiO8iPojKdA+CHvAFvRNZX8FnLuPIqA==
X-Google-Smtp-Source: AGHT+IHOpjUfngJpRTBz5e73I8KW3eSdfCuxFiap7lVIDS1HPvkqdekk3rN6oUPTkSy6OOG6PgLgKA==
X-Received: by 2002:a05:622a:190e:b0:439:d0c6:6165 with SMTP id w14-20020a05622a190e00b00439d0c66165mr1137371qtc.32.1714523506139;
        Tue, 30 Apr 2024 17:31:46 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id f15-20020ac8470f000000b0043a7cb47069sm4337935qtp.9.2024.04.30.17.31.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2024 17:31:45 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew.gospodarek@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Selvin Thyparampil Xavier <selvin.xavier@broadcom.com>,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>
Subject: [PATCH net-next v2 5/6] bnxt_en: Optimize recovery path ULP locking in the driver
Date: Tue, 30 Apr 2024 17:30:55 -0700
Message-Id: <20240501003056.100607-6-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20240501003056.100607-1-michael.chan@broadcom.com>
References: <20240501003056.100607-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000096ea8b0617599c3b"

--00000000000096ea8b0617599c3b
Content-Transfer-Encoding: 8bit

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

In the error recovery path (AER, firmware recovery, etc), the
driver notifies the RoCE driver via ULP_STOP before the reset
and via ULP_START after the reset, all under RTNL_LOCK.  The
RoCE driver can take a long time if there are a lot of QPs to
destroy, so it is not ideal to hold the global RTNL lock.

Rely on the new en_dev_lock mutex instead for ULP_STOP and
ULP_START.  For the most part, we move the ULP_STOP call before
we take the RTNL lock and move the ULP_START after RTNL unlock.
Note that SRIOV re-enablement must be done after ULP_START
or RoCE on the VFs will not resume properly after reset.

The one scenario in bnxt_hwrm_if_change() where the RTNL lock
is already taken in the .ndo_open() context requires the ULP
restart to be deferred to the bnxt_sp_task() workqueue.

Reviewed-by: Selvin Thyparampil Xavier <selvin.xavier@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 62 ++++++++++++-------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  1 +
 .../net/ethernet/broadcom/bnxt/bnxt_devlink.c |  7 ++-
 3 files changed, 44 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index a4ab1b09b27b..ccab7817c036 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11556,7 +11556,7 @@ static int bnxt_hwrm_if_change(struct bnxt *bp, bool up)
 		if (fw_reset) {
 			set_bit(BNXT_STATE_FW_RESET_DET, &bp->state);
 			if (!test_bit(BNXT_STATE_IN_FW_RESET, &bp->state))
-				bnxt_ulp_stop(bp);
+				bnxt_ulp_irq_stop(bp);
 			bnxt_free_ctx_mem(bp);
 			bnxt_dcb_free(bp);
 			rc = bnxt_fw_init_one(bp);
@@ -12111,10 +12111,9 @@ static int bnxt_open(struct net_device *dev)
 		bnxt_hwrm_if_change(bp, false);
 	} else {
 		if (test_and_clear_bit(BNXT_STATE_FW_RESET_DET, &bp->state)) {
-			if (!test_bit(BNXT_STATE_IN_FW_RESET, &bp->state)) {
-				bnxt_ulp_start(bp, 0);
-				bnxt_reenable_sriov(bp);
-			}
+			if (!test_bit(BNXT_STATE_IN_FW_RESET, &bp->state))
+				bnxt_queue_sp_work(bp,
+						   BNXT_RESTART_ULP_SP_EVENT);
 		}
 	}
 
@@ -13270,7 +13269,6 @@ static void bnxt_fw_fatal_close(struct bnxt *bp)
 
 static void bnxt_fw_reset_close(struct bnxt *bp)
 {
-	bnxt_ulp_stop(bp);
 	/* When firmware is in fatal state, quiesce device and disable
 	 * bus master to prevent any potential bad DMAs before freeing
 	 * kernel memory.
@@ -13351,6 +13349,7 @@ void bnxt_fw_exception(struct bnxt *bp)
 {
 	netdev_warn(bp->dev, "Detected firmware fatal condition, initiating reset\n");
 	set_bit(BNXT_STATE_FW_FATAL_COND, &bp->state);
+	bnxt_ulp_stop(bp);
 	bnxt_rtnl_lock_sp(bp);
 	bnxt_force_fw_reset(bp);
 	bnxt_rtnl_unlock_sp(bp);
@@ -13382,6 +13381,7 @@ static int bnxt_get_registered_vfs(struct bnxt *bp)
 
 void bnxt_fw_reset(struct bnxt *bp)
 {
+	bnxt_ulp_stop(bp);
 	bnxt_rtnl_lock_sp(bp);
 	if (test_bit(BNXT_STATE_OPEN, &bp->state) &&
 	    !test_bit(BNXT_STATE_IN_FW_RESET, &bp->state)) {
@@ -13506,6 +13506,12 @@ static void bnxt_fw_echo_reply(struct bnxt *bp)
 	hwrm_req_send(bp, req);
 }
 
+static void bnxt_ulp_restart(struct bnxt *bp)
+{
+	bnxt_ulp_stop(bp);
+	bnxt_ulp_start(bp, 0);
+}
+
 static void bnxt_sp_task(struct work_struct *work)
 {
 	struct bnxt *bp = container_of(work, struct bnxt, sp_task);
@@ -13517,6 +13523,11 @@ static void bnxt_sp_task(struct work_struct *work)
 		return;
 	}
 
+	if (test_and_clear_bit(BNXT_RESTART_ULP_SP_EVENT, &bp->sp_event)) {
+		bnxt_ulp_restart(bp);
+		bnxt_reenable_sriov(bp);
+	}
+
 	if (test_and_clear_bit(BNXT_RX_MASK_SP_EVENT, &bp->sp_event))
 		bnxt_cfg_rx_mode(bp);
 
@@ -13973,10 +13984,8 @@ static bool bnxt_fw_reset_timeout(struct bnxt *bp)
 static void bnxt_fw_reset_abort(struct bnxt *bp, int rc)
 {
 	clear_bit(BNXT_STATE_IN_FW_RESET, &bp->state);
-	if (bp->fw_reset_state != BNXT_FW_RESET_STATE_POLL_VF) {
-		bnxt_ulp_start(bp, rc);
+	if (bp->fw_reset_state != BNXT_FW_RESET_STATE_POLL_VF)
 		bnxt_dl_health_fw_status_update(bp, false);
-	}
 	bp->fw_reset_state = 0;
 	dev_close(bp->dev);
 }
@@ -14007,7 +14016,7 @@ static void bnxt_fw_reset_task(struct work_struct *work)
 				bp->fw_reset_state = 0;
 				netdev_err(bp->dev, "Firmware reset aborted, bnxt_get_registered_vfs() returns %d\n",
 					   n);
-				return;
+				goto ulp_start;
 			}
 			bnxt_queue_fw_reset_work(bp, HZ / 10);
 			return;
@@ -14017,7 +14026,7 @@ static void bnxt_fw_reset_task(struct work_struct *work)
 		if (test_bit(BNXT_STATE_ABORT_ERR, &bp->state)) {
 			bnxt_fw_reset_abort(bp, rc);
 			rtnl_unlock();
-			return;
+			goto ulp_start;
 		}
 		bnxt_fw_reset_close(bp);
 		if (bp->fw_cap & BNXT_FW_CAP_ERR_RECOVER_RELOAD) {
@@ -14110,7 +14119,7 @@ static void bnxt_fw_reset_task(struct work_struct *work)
 			netdev_err(bp->dev, "bnxt_open() failed during FW reset\n");
 			bnxt_fw_reset_abort(bp, rc);
 			rtnl_unlock();
-			return;
+			goto ulp_start;
 		}
 
 		if ((bp->fw_cap & BNXT_FW_CAP_ERROR_RECOVERY) &&
@@ -14122,10 +14131,6 @@ static void bnxt_fw_reset_task(struct work_struct *work)
 		/* Make sure fw_reset_state is 0 before clearing the flag */
 		smp_mb__before_atomic();
 		clear_bit(BNXT_STATE_IN_FW_RESET, &bp->state);
-		bnxt_ulp_start(bp, 0);
-		bnxt_reenable_sriov(bp);
-		bnxt_vf_reps_alloc(bp);
-		bnxt_vf_reps_open(bp);
 		bnxt_ptp_reapply_pps(bp);
 		clear_bit(BNXT_STATE_FW_ACTIVATE, &bp->state);
 		if (test_and_clear_bit(BNXT_STATE_RECOVER, &bp->state)) {
@@ -14133,6 +14138,12 @@ static void bnxt_fw_reset_task(struct work_struct *work)
 			bnxt_dl_health_fw_status_update(bp, true);
 		}
 		rtnl_unlock();
+		bnxt_ulp_start(bp, 0);
+		bnxt_reenable_sriov(bp);
+		rtnl_lock();
+		bnxt_vf_reps_alloc(bp);
+		bnxt_vf_reps_open(bp);
+		rtnl_unlock();
 		break;
 	}
 	return;
@@ -14148,6 +14159,8 @@ static void bnxt_fw_reset_task(struct work_struct *work)
 	rtnl_lock();
 	bnxt_fw_reset_abort(bp, rc);
 	rtnl_unlock();
+ulp_start:
+	bnxt_ulp_start(bp, rc);
 }
 
 static int bnxt_init_board(struct pci_dev *pdev, struct net_device *dev)
@@ -15534,8 +15547,9 @@ static int bnxt_suspend(struct device *device)
 	struct bnxt *bp = netdev_priv(dev);
 	int rc = 0;
 
-	rtnl_lock();
 	bnxt_ulp_stop(bp);
+
+	rtnl_lock();
 	if (netif_running(dev)) {
 		netif_device_detach(dev);
 		rc = bnxt_close(dev);
@@ -15590,10 +15604,10 @@ static int bnxt_resume(struct device *device)
 	}
 
 resume_exit:
+	rtnl_unlock();
 	bnxt_ulp_start(bp, rc);
 	if (!rc)
 		bnxt_reenable_sriov(bp);
-	rtnl_unlock();
 	return rc;
 }
 
@@ -15623,11 +15637,11 @@ static pci_ers_result_t bnxt_io_error_detected(struct pci_dev *pdev,
 
 	netdev_info(netdev, "PCI I/O error detected\n");
 
+	bnxt_ulp_stop(bp);
+
 	rtnl_lock();
 	netif_device_detach(netdev);
 
-	bnxt_ulp_stop(bp);
-
 	if (test_and_set_bit(BNXT_STATE_IN_FW_RESET, &bp->state)) {
 		netdev_err(bp->dev, "Firmware reset already in progress\n");
 		abort = true;
@@ -15763,13 +15777,13 @@ static void bnxt_io_resume(struct pci_dev *pdev)
 	if (!err && netif_running(netdev))
 		err = bnxt_open(netdev);
 
-	bnxt_ulp_start(bp, err);
-	if (!err) {
-		bnxt_reenable_sriov(bp);
+	if (!err)
 		netif_device_attach(netdev);
-	}
 
 	rtnl_unlock();
+	bnxt_ulp_start(bp, err);
+	if (!err)
+		bnxt_reenable_sriov(bp);
 }
 
 static const struct pci_error_handlers bnxt_err_handler = {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 631b0039d72b..1e15a25b77c7 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2440,6 +2440,7 @@ struct bnxt {
 #define BNXT_LINK_CFG_CHANGE_SP_EVENT	21
 #define BNXT_THERMAL_THRESHOLD_SP_EVENT	22
 #define BNXT_FW_ECHO_REQUEST_SP_EVENT	23
+#define BNXT_RESTART_ULP_SP_EVENT	24
 
 	struct delayed_work	fw_reset_task;
 	int			fw_reset_state;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
index d9ea6fa23923..4cb0fabf977e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
@@ -437,18 +437,20 @@ static int bnxt_dl_reload_down(struct devlink *dl, bool netns_change,
 
 	switch (action) {
 	case DEVLINK_RELOAD_ACTION_DRIVER_REINIT: {
+		bnxt_ulp_stop(bp);
 		rtnl_lock();
 		if (bnxt_sriov_cfg(bp)) {
 			NL_SET_ERR_MSG_MOD(extack,
 					   "reload is unsupported while VFs are allocated or being configured");
 			rtnl_unlock();
+			bnxt_ulp_start(bp, 0);
 			return -EOPNOTSUPP;
 		}
 		if (bp->dev->reg_state == NETREG_UNREGISTERED) {
 			rtnl_unlock();
+			bnxt_ulp_start(bp, 0);
 			return -ENODEV;
 		}
-		bnxt_ulp_stop(bp);
 		if (netif_running(bp->dev))
 			bnxt_close_nic(bp, true, true);
 		bnxt_vf_reps_free(bp);
@@ -516,7 +518,6 @@ static int bnxt_dl_reload_up(struct devlink *dl, enum devlink_reload_action acti
 		bnxt_vf_reps_alloc(bp);
 		if (netif_running(bp->dev))
 			rc = bnxt_open_nic(bp, true, true);
-		bnxt_ulp_start(bp, rc);
 		if (!rc) {
 			bnxt_reenable_sriov(bp);
 			bnxt_ptp_reapply_pps(bp);
@@ -570,6 +571,8 @@ static int bnxt_dl_reload_up(struct devlink *dl, enum devlink_reload_action acti
 		dev_close(bp->dev);
 	}
 	rtnl_unlock();
+	if (action == DEVLINK_RELOAD_ACTION_DRIVER_REINIT)
+		bnxt_ulp_start(bp, rc);
 	return rc;
 }
 
-- 
2.30.1


--00000000000096ea8b0617599c3b
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
OnaLEot1MoQO7BIe5S9H4AcCEXXcrJJiAtMCl47ARpyHmvQFQFFTrHgUYEd9V+9bOzY7MBIGSV1N
/JfsT1sZw6HT0lJkSQefhPGpBniAob62DJP3qr11tu8CAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU31rAyTdZweIF0tJTFYwfOv2w
L4QwDQYJKoZIhvcNAQELBQADggEBACcuyaGmk0NSZ7Kio7O7WSZ0j0f9xXcBnLbJvQXFYM7JI5uS
kw5ozATEN5gfmNIe0AHzqwoYjAf3x8Dv2w7HgyrxWdpjTKQFv5jojxa3A5LVuM8mhPGZfR/L5jSk
5xc3llsKqrWI4ov4JyW79p0E99gfPA6Waixoavxvv1CZBQ4Stu7N660kTu9sJrACf20E+hdKLoiU
hd5wiQXo9B2ncm5P3jFLYLBmPltIn/uzdiYpFj+E9kS9XYDd+boBZhN1Vh0296zLQZobLfKFzClo
E6IFyTTANonrXvCRgodKS+QJEH8Syu2jSKe023aVemkuZjzvPK7o9iU7BKkPG2pzLPgxggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxeQGjDntHGb2iaQkIw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIN4EaO9tl+irVtdhE8v2zAb+oVw8jgkt
f2V8LlbWIKlCMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDUw
MTAwMzE0NlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQCxUwHSDDjw/GdXmXe/Knrh5V5XtqvyQ2LxR67dhNoKrpC17IXt
MFAvnPHoanfHux/FQkuPthKmOTmw5x1il4LUmhxlCdYMcccWmyU+Ni4DEea9xaj84LBDsf1TKWdX
NZQHXbDxxgTcKWGeLtjI0GHQgnbpy80cGosglic95nZLoWXOF5F8wo0lQbpQd6G/yU6gvRgWVGpJ
f4Ua0AvVU00qXrC+VylmXQIgnKqO/6kWVgtMX4ZVmJJtLUAHUlGs+O15b+Cl+rg2rOzsSWgMm3V1
9txcNCwSdR/72n3KWld1g9Bbtc3EOF85sMmKrHyhQx0wSRDP160bQQ2VzZdjVRej
--00000000000096ea8b0617599c3b--

