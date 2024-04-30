Return-Path: <netdev+bounces-92634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5408B82BC
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 00:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 757731C20BAA
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 22:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E60738DC3;
	Tue, 30 Apr 2024 22:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="P/hKvwk7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65592219FF
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 22:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714517183; cv=none; b=jEdj6sn8JtbfgWXJpCw7nCI5sds3lsKlxDUizXpsDf4jDRqR7JuXIO4J1p22EEBkt81G1fgMUkj41BrMLdZ7PCcbAxKXD7uN5YFv1S0AagFWbqsVsm7VUi8iI1aUVChca6fFucLK2dUbqRqDS1dU4yCIPdjx1/TXP+esZGW6ytc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714517183; c=relaxed/simple;
	bh=77zKzFjG2CTQIAkel9LrKBEyMLeh7H2qYAPCNTN663U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BRxl6KNSH6QP/uqFx0ZX3tyyK1IOzTYvMW8y15oDOAgcHdF5CqYi1ZLXK15hywTT6LZskyunkLFjbXtrml6pafwUB1YbLvBI+p+CB6uHiYPhB6rGKKpN2McusSXemwbW/2wtpfYsGyfTUg0acQoLT67e+2xqv8CAJzW+RqHRHoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=P/hKvwk7; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1ec69e3dbe5so7780255ad.0
        for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 15:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1714517180; x=1715121980; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9egGFzew9U8bi31/23yU44dJ+Tw23C/cwmi30lF79/s=;
        b=P/hKvwk7qPKGhe+rcUxFx5EIodDXNNvv/9Q6XUogLDqBYQ8ZhREB0lWSUWvqC6n/PS
         FbROrNgavhrvk8jZ06qhbpqy6VfiUJhNT8A+T506uVtVxIYAR6Bpif1UqNkxsg9ufrnu
         4SBxuLN1MA766vcMWs5wZFIfTch3kFYfg3GCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714517180; x=1715121980;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9egGFzew9U8bi31/23yU44dJ+Tw23C/cwmi30lF79/s=;
        b=p7PnkEqX71JXlpbnftLoAa8LbFvDXTjb4rAtr/usg8+KYNzGATzRtVXMIe6qWTV8s1
         aTHTV+nm4pZG32sDq87cTjZdqM5aowAWZsGM1/eD9/ngAkDGQi/t5thcTgOeI29dRTbC
         6aacl41dxQJ080y/W/27o40sftmLCog3Yl3zPGBheimPUk6v3ZUZHU6KAR0Oifg/126B
         d0oco4pohSt/7Li9ZLC8HFiHDkrug8U7DLCHRxaRNPbpPq/ksCOnLPb2b+qqRVIycVDF
         cqm1R+JPHh8NA2uZ1ipPXD/WimNOcX9je3w+9WzvylsnkRYJkJtSC8GwPHJROk4+hROF
         9m2Q==
X-Gm-Message-State: AOJu0YyT1ZVk+QRIvdEzQkFVl4Xbl+O6NunFk6s97tflgp3+BS1PR5ph
	VR3zTrPuXqe00t+2NZJF+WPpPn2IYIyCh9Pq9JoFotzalSkSCJ/jn2Nr9F0UtQ==
X-Google-Smtp-Source: AGHT+IEjomUpI/KmMGFi7D4k7mjJLlp4GHtilnNB2HKmKxw9d/eCefGYBEXyf6FNB+U4/ETElIzJgA==
X-Received: by 2002:a17:903:234e:b0:1e2:3e1e:3d9 with SMTP id c14-20020a170903234e00b001e23e1e03d9mr920536plh.63.1714517180388;
        Tue, 30 Apr 2024 15:46:20 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id s11-20020a170902a50b00b001eb2fb28eabsm7836476plq.227.2024.04.30.15.46.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2024 15:46:19 -0700 (PDT)
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
Subject: [PATCH net-next 6/7] bnxt_en: Optimize recovery path ULP locking in the driver
Date: Tue, 30 Apr 2024 15:44:37 -0700
Message-Id: <20240430224438.91494-7-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20240430224438.91494-1-michael.chan@broadcom.com>
References: <20240430224438.91494-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000088041406175823ba"

--00000000000088041406175823ba
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
index 4d7b4eabe0af..67294835e10e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11552,7 +11552,7 @@ static int bnxt_hwrm_if_change(struct bnxt *bp, bool up)
 		if (fw_reset) {
 			set_bit(BNXT_STATE_FW_RESET_DET, &bp->state);
 			if (!test_bit(BNXT_STATE_IN_FW_RESET, &bp->state))
-				bnxt_ulp_stop(bp);
+				bnxt_ulp_irq_stop(bp);
 			bnxt_free_ctx_mem(bp);
 			bnxt_dcb_free(bp);
 			rc = bnxt_fw_init_one(bp);
@@ -12107,10 +12107,9 @@ static int bnxt_open(struct net_device *dev)
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
 
@@ -13266,7 +13265,6 @@ static void bnxt_fw_fatal_close(struct bnxt *bp)
 
 static void bnxt_fw_reset_close(struct bnxt *bp)
 {
-	bnxt_ulp_stop(bp);
 	/* When firmware is in fatal state, quiesce device and disable
 	 * bus master to prevent any potential bad DMAs before freeing
 	 * kernel memory.
@@ -13347,6 +13345,7 @@ void bnxt_fw_exception(struct bnxt *bp)
 {
 	netdev_warn(bp->dev, "Detected firmware fatal condition, initiating reset\n");
 	set_bit(BNXT_STATE_FW_FATAL_COND, &bp->state);
+	bnxt_ulp_stop(bp);
 	bnxt_rtnl_lock_sp(bp);
 	bnxt_force_fw_reset(bp);
 	bnxt_rtnl_unlock_sp(bp);
@@ -13378,6 +13377,7 @@ static int bnxt_get_registered_vfs(struct bnxt *bp)
 
 void bnxt_fw_reset(struct bnxt *bp)
 {
+	bnxt_ulp_stop(bp);
 	bnxt_rtnl_lock_sp(bp);
 	if (test_bit(BNXT_STATE_OPEN, &bp->state) &&
 	    !test_bit(BNXT_STATE_IN_FW_RESET, &bp->state)) {
@@ -13502,6 +13502,12 @@ static void bnxt_fw_echo_reply(struct bnxt *bp)
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
@@ -13513,6 +13519,11 @@ static void bnxt_sp_task(struct work_struct *work)
 		return;
 	}
 
+	if (test_and_clear_bit(BNXT_RESTART_ULP_SP_EVENT, &bp->sp_event)) {
+		bnxt_ulp_restart(bp);
+		bnxt_reenable_sriov(bp);
+	}
+
 	if (test_and_clear_bit(BNXT_RX_MASK_SP_EVENT, &bp->sp_event))
 		bnxt_cfg_rx_mode(bp);
 
@@ -13969,10 +13980,8 @@ static bool bnxt_fw_reset_timeout(struct bnxt *bp)
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
@@ -14003,7 +14012,7 @@ static void bnxt_fw_reset_task(struct work_struct *work)
 				bp->fw_reset_state = 0;
 				netdev_err(bp->dev, "Firmware reset aborted, bnxt_get_registered_vfs() returns %d\n",
 					   n);
-				return;
+				goto ulp_start;
 			}
 			bnxt_queue_fw_reset_work(bp, HZ / 10);
 			return;
@@ -14013,7 +14022,7 @@ static void bnxt_fw_reset_task(struct work_struct *work)
 		if (test_bit(BNXT_STATE_ABORT_ERR, &bp->state)) {
 			bnxt_fw_reset_abort(bp, rc);
 			rtnl_unlock();
-			return;
+			goto ulp_start;
 		}
 		bnxt_fw_reset_close(bp);
 		if (bp->fw_cap & BNXT_FW_CAP_ERR_RECOVER_RELOAD) {
@@ -14106,7 +14115,7 @@ static void bnxt_fw_reset_task(struct work_struct *work)
 			netdev_err(bp->dev, "bnxt_open() failed during FW reset\n");
 			bnxt_fw_reset_abort(bp, rc);
 			rtnl_unlock();
-			return;
+			goto ulp_start;
 		}
 
 		if ((bp->fw_cap & BNXT_FW_CAP_ERROR_RECOVERY) &&
@@ -14118,10 +14127,6 @@ static void bnxt_fw_reset_task(struct work_struct *work)
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
@@ -14129,6 +14134,12 @@ static void bnxt_fw_reset_task(struct work_struct *work)
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
@@ -14144,6 +14155,8 @@ static void bnxt_fw_reset_task(struct work_struct *work)
 	rtnl_lock();
 	bnxt_fw_reset_abort(bp, rc);
 	rtnl_unlock();
+ulp_start:
+	bnxt_ulp_start(bp, rc);
 }
 
 static int bnxt_init_board(struct pci_dev *pdev, struct net_device *dev)
@@ -15530,8 +15543,9 @@ static int bnxt_suspend(struct device *device)
 	struct bnxt *bp = netdev_priv(dev);
 	int rc = 0;
 
-	rtnl_lock();
 	bnxt_ulp_stop(bp);
+
+	rtnl_lock();
 	if (netif_running(dev)) {
 		netif_device_detach(dev);
 		rc = bnxt_close(dev);
@@ -15586,10 +15600,10 @@ static int bnxt_resume(struct device *device)
 	}
 
 resume_exit:
+	rtnl_unlock();
 	bnxt_ulp_start(bp, rc);
 	if (!rc)
 		bnxt_reenable_sriov(bp);
-	rtnl_unlock();
 	return rc;
 }
 
@@ -15619,11 +15633,11 @@ static pci_ers_result_t bnxt_io_error_detected(struct pci_dev *pdev,
 
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
@@ -15759,13 +15773,13 @@ static void bnxt_io_resume(struct pci_dev *pdev)
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
index 003c00b229f2..c62bdbb7249f 100644
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


--00000000000088041406175823ba
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIJxrOLnYQLOucufi2TQmLVbd9gUlVUG6
j74tQGGv0yLjMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDQz
MDIyNDYyMFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQAkQ6qJkDgFq1ysNaQMNb+ooRohJk4HdfWgWIlje4dJAIDPSiGt
tdQ/AnIazUOrlVsE+DSp87iFy3jzLh3IvH0G1BeBySvWUZaVU+h2P4MXtePPtIvrd8LjJfQ+HRd/
jWsOyQ3hPYYsEMpawMUiJJMk5z3FgCmy8E10QvZ2PQseN3TRv9U91kMPUb9j2fFSG/fPX8O5f5Dr
+ujVPJYA1vjpNZ4XPcBdCeckWQtRe4CgzeJtRrhO+bwTk8+0eequVrZY9B53SwzF9l9dFMmwwHy+
SyQx+xdBGKXN+f8b6BY0MHn5PaRkTn8xBsbrPjph1PBGihJDVf3pDbQxCQ8N7JQr
--00000000000088041406175823ba--

