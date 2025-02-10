Return-Path: <netdev+bounces-164886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8500CA2F87F
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 20:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A45C169513
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 19:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B128C2566F3;
	Mon, 10 Feb 2025 19:21:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E24D257AF6
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 19:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739215261; cv=none; b=fC3SlQy+XpS6+AqO0SXn4r1gCRoaPjKevfH90NqSPAK387yY3XOat7shdfNGsz/tUmKNmFig5OVFH5KSqlTb4CeBoYDetVDTclhkVEqj9im/7HM54U1Ui6bb/Yu/Il/bETq08tZENxL3RIVWUAZvbhlx+Do7aUKSZ070sA3wktQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739215261; c=relaxed/simple;
	bh=w4l8TyrwiM5on1LKrN+gisWqHic+1ki2Non/hEnv9h8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uS+QlMWzixVONt0bBNFycsIiMvK1gbQtQfagCzBrlNhgNXjC4uwyOU38I49QsobrN/0Xa4NWd2z8WSQfIu+aCMsYaVCPj4B6PVeJFm4raax+Hi8SHUYxb/MfNvgIIveSR4WjnSDENFEnAOcv5eldDZyDeO2EO+jJYdQ9FKlozzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2fa2eb7eb45so4841808a91.1
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 11:20:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739215258; x=1739820058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ooTcUbRGISBp669x5kM3U9vq5xrKJbHbuRzJJDtHroE=;
        b=pVOtP9i+2S1/M09HvXfrmywP/7t/ToHuyXsjDHE9TUBgFNVhHSja52lcv/4l99Ek+0
         X0pSOtdcy/m7VcqVRd1uJIvP6L0/BDm73soVRqPbSX6EYCot/bQsq3Mj2D+9T049E+IV
         hvspgIDXwJ4qwwW38D5RfF+WKUHzAbcnuEh7bZ/YUljkuLpPoKO7qVYDHu+L7f4bDroI
         yhDNpx+33h7UgaZCvuUlmaA6jKxxW1xPgIsFbyzbr5mQ3Ou6w2IqS1D5//O3KR9l92mT
         cYJxnC++82FsI77EX6V514WGlKYyhpVxnpMd2DpkKkZQJoG1/PaP7Zo+ZE/VhwehvksM
         1R2g==
X-Gm-Message-State: AOJu0Yx2HXy6inJYidboGmYgluO/5aBIZi0RcaDL5So/aE59BO5mqcEX
	MKRnTvOZbPRzI0LTpTS16gmc7/LdeHrkK6N3yMQ6vWQ3LquANxvxNv0w
X-Gm-Gg: ASbGncu8zfphHcCRFBGpaVHV8CprkSr8mGGHeploersQzcJ3YCUwm8vt4zBHUecui6O
	nJkIdD7luuvRjzGxb/w3GO3dyKYpP1cU6JxAuTgzz4FNObfQUFm3A8C88JopitpfinMhWisgui7
	rozPfFRH2Y/8mmCN3p7I8CPVho/fdpb6/1sfFY/0a732xojeWr4kWagJfQpM7yGt9rIGIp1X6AM
	xuLPNQWGyqtZEKasW35RPIBJ0qKzT0OkT/zXAb5Bxb8G86vLtr9HXy9sCnkD96heKjWYsynsI0v
	GLTHE9VErUqB7es=
X-Google-Smtp-Source: AGHT+IH69xT0evwawjcTFqFo0NHDHFCVhXMbMDX14gWJRwUkCULbE3dW55/Dw5AxlTSf40p/b4NtFg==
X-Received: by 2002:a17:90b:1d4d:b0:2ee:9661:eafb with SMTP id 98e67ed59e1d1-2faa0954497mr774567a91.12.1739215258245;
        Mon, 10 Feb 2025 11:20:58 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fa09a16e53sm8910809a91.11.2025.02.10.11.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 11:20:57 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: [PATCH net-next 11/11] eth: bnxt: remove most dependencies on RTNL
Date: Mon, 10 Feb 2025 11:20:43 -0800
Message-ID: <20250210192043.439074-12-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210192043.439074-1-sdf@fomichev.me>
References: <20250210192043.439074-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Only devlink and sriov paths are grabbing rtnl explicitly. The rest is
covered by netdev instance lock which the core now grabs, so there is
no need to manage rtnl in most places anymore.

On the core side we can now try to drop rtnl in some places
(do_setlink for example) for the drivers that signal non-rtnl
mode (TBD).

Boot-tested and with `ethtool -L eth1 combined 24` to trigger reset.

Cc: Saeed Mahameed <saeed@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 116 +++++++++---------
 .../net/ethernet/broadcom/bnxt/bnxt_devlink.c |   9 ++
 .../net/ethernet/broadcom/bnxt/bnxt_sriov.c   |   6 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c |  16 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c |  18 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |   3 +-
 include/linux/netdevice.h                     |   5 +
 7 files changed, 100 insertions(+), 73 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 082a6c2b5cca..a32dab09763b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -5236,8 +5236,10 @@ static void bnxt_free_ntp_fltrs(struct bnxt *bp, bool all)
 {
 	int i;
 
-	/* Under rtnl_lock and all our NAPIs have been disabled.  It's
-	 * safe to delete the hash table.
+	netdev_assert_locked(bp->dev);
+
+	/* Under netdev instance lock and all our NAPIs have been disabled.
+	 * It's safe to delete the hash table.
 	 */
 	for (i = 0; i < BNXT_NTP_FLTR_HASH_SIZE; i++) {
 		struct hlist_head *head;
@@ -12575,7 +12577,6 @@ static int __bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
 	return rc;
 }
 
-/* rtnl_lock held */
 int bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
 {
 	int rc = 0;
@@ -12591,9 +12592,9 @@ int bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
 	return rc;
 }
 
-/* rtnl_lock held, open the NIC half way by allocating all resources, but
- * NAPI, IRQ, and TX are not enabled.  This is mainly used for offline
- * self tests.
+/* netdev instance lock held, open the NIC half way by allocating all
+ * resources, but NAPI, IRQ, and TX are not enabled.  This is mainly used
+ * for offline self tests.
  */
 int bnxt_half_open_nic(struct bnxt *bp)
 {
@@ -12628,8 +12629,8 @@ int bnxt_half_open_nic(struct bnxt *bp)
 	return rc;
 }
 
-/* rtnl_lock held, this call can only be made after a previous successful
- * call to bnxt_half_open_nic().
+/* netdev instance lock held, this call can only be made after a previous
+ * successful call to bnxt_half_open_nic().
  */
 void bnxt_half_close_nic(struct bnxt *bp)
 {
@@ -12738,10 +12739,11 @@ void bnxt_close_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
 	if (test_bit(BNXT_STATE_IN_FW_RESET, &bp->state)) {
 		/* If we get here, it means firmware reset is in progress
 		 * while we are trying to close.  We can safely proceed with
-		 * the close because we are holding rtnl_lock().  Some firmware
-		 * messages may fail as we proceed to close.  We set the
-		 * ABORT_ERR flag here so that the FW reset thread will later
-		 * abort when it gets the rtnl_lock() and sees the flag.
+		 * the close because we are holding netdev instance lock.
+		 * Some firmware messages may fail as we proceed to close.
+		 * We set the ABORT_ERR flag here so that the FW reset thread
+		 * will later abort when it gets the netdev instance lock
+		 * and sees the flag.
 		 */
 		netdev_warn(bp->dev, "FW reset in progress during close, FW reset will be aborted\n");
 		set_bit(BNXT_STATE_ABORT_ERR, &bp->state);
@@ -12832,7 +12834,7 @@ static int bnxt_hwrm_port_phy_write(struct bnxt *bp, u16 phy_addr, u16 reg,
 	return hwrm_req_send(bp, req);
 }
 
-/* rtnl_lock held */
+/* netdev instance lock held */
 static int bnxt_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 {
 	struct mii_ioctl_data *mdio = if_mii(ifr);
@@ -13751,30 +13753,30 @@ static void bnxt_timer(struct timer_list *t)
 	mod_timer(&bp->timer, jiffies + bp->current_interval);
 }
 
-static void bnxt_rtnl_lock_sp(struct bnxt *bp)
+static void bnxt_lock_sp(struct bnxt *bp)
 {
 	/* We are called from bnxt_sp_task which has BNXT_STATE_IN_SP_TASK
 	 * set.  If the device is being closed, bnxt_close() may be holding
-	 * rtnl() and waiting for BNXT_STATE_IN_SP_TASK to clear.  So we
-	 * must clear BNXT_STATE_IN_SP_TASK before holding rtnl().
+	 * netdev instance lock and waiting for BNXT_STATE_IN_SP_TASK to clear.
+	 * So we must clear BNXT_STATE_IN_SP_TASK before holding rtnl().
 	 */
 	clear_bit(BNXT_STATE_IN_SP_TASK, &bp->state);
-	rtnl_lock();
+	netdev_lock(bp->dev);
 }
 
-static void bnxt_rtnl_unlock_sp(struct bnxt *bp)
+static void bnxt_unlock_sp(struct bnxt *bp)
 {
 	set_bit(BNXT_STATE_IN_SP_TASK, &bp->state);
-	rtnl_unlock();
+	netdev_unlock(bp->dev);
 }
 
 /* Only called from bnxt_sp_task() */
 static void bnxt_reset(struct bnxt *bp, bool silent)
 {
-	bnxt_rtnl_lock_sp(bp);
+	bnxt_lock_sp(bp);
 	if (test_bit(BNXT_STATE_OPEN, &bp->state))
 		bnxt_reset_task(bp, silent);
-	bnxt_rtnl_unlock_sp(bp);
+	bnxt_unlock_sp(bp);
 }
 
 /* Only called from bnxt_sp_task() */
@@ -13782,9 +13784,9 @@ static void bnxt_rx_ring_reset(struct bnxt *bp)
 {
 	int i;
 
-	bnxt_rtnl_lock_sp(bp);
+	bnxt_lock_sp(bp);
 	if (!test_bit(BNXT_STATE_OPEN, &bp->state)) {
-		bnxt_rtnl_unlock_sp(bp);
+		bnxt_unlock_sp(bp);
 		return;
 	}
 	/* Disable and flush TPA before resetting the RX ring */
@@ -13823,7 +13825,7 @@ static void bnxt_rx_ring_reset(struct bnxt *bp)
 	}
 	if (bp->flags & BNXT_FLAG_TPA)
 		bnxt_set_tpa(bp, true);
-	bnxt_rtnl_unlock_sp(bp);
+	bnxt_unlock_sp(bp);
 }
 
 static void bnxt_fw_fatal_close(struct bnxt *bp)
@@ -13879,7 +13881,7 @@ static bool is_bnxt_fw_ok(struct bnxt *bp)
 	return false;
 }
 
-/* rtnl_lock is acquired before calling this function */
+/* netdev instance lock is acquired before calling this function */
 static void bnxt_force_fw_reset(struct bnxt *bp)
 {
 	struct bnxt_fw_health *fw_health = bp->fw_health;
@@ -13922,9 +13924,9 @@ void bnxt_fw_exception(struct bnxt *bp)
 	netdev_warn(bp->dev, "Detected firmware fatal condition, initiating reset\n");
 	set_bit(BNXT_STATE_FW_FATAL_COND, &bp->state);
 	bnxt_ulp_stop(bp);
-	bnxt_rtnl_lock_sp(bp);
+	bnxt_lock_sp(bp);
 	bnxt_force_fw_reset(bp);
-	bnxt_rtnl_unlock_sp(bp);
+	bnxt_unlock_sp(bp);
 }
 
 /* Returns the number of registered VFs, or 1 if VF configuration is pending, or
@@ -13954,7 +13956,7 @@ static int bnxt_get_registered_vfs(struct bnxt *bp)
 void bnxt_fw_reset(struct bnxt *bp)
 {
 	bnxt_ulp_stop(bp);
-	bnxt_rtnl_lock_sp(bp);
+	bnxt_lock_sp(bp);
 	if (test_bit(BNXT_STATE_OPEN, &bp->state) &&
 	    !test_bit(BNXT_STATE_IN_FW_RESET, &bp->state)) {
 		struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
@@ -14000,7 +14002,7 @@ void bnxt_fw_reset(struct bnxt *bp)
 		bnxt_queue_fw_reset_work(bp, tmo);
 	}
 fw_reset_exit:
-	bnxt_rtnl_unlock_sp(bp);
+	bnxt_unlock_sp(bp);
 }
 
 static void bnxt_chk_missed_irq(struct bnxt *bp)
@@ -14199,7 +14201,7 @@ static void bnxt_sp_task(struct work_struct *work)
 static void _bnxt_get_max_rings(struct bnxt *bp, int *max_rx, int *max_tx,
 				int *max_cp);
 
-/* Under rtnl_lock */
+/* Under netdev instance lock */
 int bnxt_check_rings(struct bnxt *bp, int tx, int rx, bool sh, int tcs,
 		     int tx_xdp)
 {
@@ -14627,10 +14629,10 @@ static void bnxt_fw_reset_task(struct work_struct *work)
 			return;
 		}
 		bp->fw_reset_timestamp = jiffies;
-		rtnl_lock();
+		netdev_lock(bp->dev);
 		if (test_bit(BNXT_STATE_ABORT_ERR, &bp->state)) {
 			bnxt_fw_reset_abort(bp, rc);
-			rtnl_unlock();
+			netdev_unlock(bp->dev);
 			goto ulp_start;
 		}
 		bnxt_fw_reset_close(bp);
@@ -14641,7 +14643,7 @@ static void bnxt_fw_reset_task(struct work_struct *work)
 			bp->fw_reset_state = BNXT_FW_RESET_STATE_ENABLE_DEV;
 			tmo = bp->fw_reset_min_dsecs * HZ / 10;
 		}
-		rtnl_unlock();
+		netdev_unlock(bp->dev);
 		bnxt_queue_fw_reset_work(bp, tmo);
 		return;
 	}
@@ -14715,7 +14717,7 @@ static void bnxt_fw_reset_task(struct work_struct *work)
 		bp->fw_reset_state = BNXT_FW_RESET_STATE_OPENING;
 		fallthrough;
 	case BNXT_FW_RESET_STATE_OPENING:
-		while (!rtnl_trylock()) {
+		while (!netdev_trylock(bp->dev)) {
 			bnxt_queue_fw_reset_work(bp, HZ / 10);
 			return;
 		}
@@ -14723,7 +14725,7 @@ static void bnxt_fw_reset_task(struct work_struct *work)
 		if (rc) {
 			netdev_err(bp->dev, "bnxt_open() failed during FW reset\n");
 			bnxt_fw_reset_abort(bp, rc);
-			rtnl_unlock();
+			netdev_unlock(bp->dev);
 			goto ulp_start;
 		}
 
@@ -14742,13 +14744,13 @@ static void bnxt_fw_reset_task(struct work_struct *work)
 			bnxt_dl_health_fw_recovery_done(bp);
 			bnxt_dl_health_fw_status_update(bp, true);
 		}
-		rtnl_unlock();
+		netdev_unlock(bp->dev);
 		bnxt_ulp_start(bp, 0);
 		bnxt_reenable_sriov(bp);
-		rtnl_lock();
+		netdev_lock(bp->dev);
 		bnxt_vf_reps_alloc(bp);
 		bnxt_vf_reps_open(bp);
-		rtnl_unlock();
+		netdev_unlock(bp->dev);
 		break;
 	}
 	return;
@@ -14761,9 +14763,9 @@ static void bnxt_fw_reset_task(struct work_struct *work)
 		netdev_err(bp->dev, "fw_health_status 0x%x\n", sts);
 	}
 fw_reset_abort:
-	rtnl_lock();
+	netdev_lock(bp->dev);
 	bnxt_fw_reset_abort(bp, rc);
-	rtnl_unlock();
+	netdev_unlock(bp->dev);
 ulp_start:
 	bnxt_ulp_start(bp, rc);
 }
@@ -14855,13 +14857,14 @@ static int bnxt_init_board(struct pci_dev *pdev, struct net_device *dev)
 	return rc;
 }
 
-/* rtnl_lock held */
 static int bnxt_change_mac_addr(struct net_device *dev, void *p)
 {
 	struct sockaddr *addr = p;
 	struct bnxt *bp = netdev_priv(dev);
 	int rc = 0;
 
+	netdev_assert_locked(dev);
+
 	if (!is_valid_ether_addr(addr->sa_data))
 		return -EADDRNOTAVAIL;
 
@@ -14882,11 +14885,12 @@ static int bnxt_change_mac_addr(struct net_device *dev, void *p)
 	return rc;
 }
 
-/* rtnl_lock held */
 static int bnxt_change_mtu(struct net_device *dev, int new_mtu)
 {
 	struct bnxt *bp = netdev_priv(dev);
 
+	netdev_assert_locked(dev);
+
 	if (netif_running(dev))
 		bnxt_close_nic(bp, true, false);
 
@@ -16001,7 +16005,7 @@ int bnxt_restore_pf_fw_resources(struct bnxt *bp)
 {
 	int rc;
 
-	ASSERT_RTNL();
+	netdev_ops_assert_locked(bp->dev);
 	bnxt_hwrm_func_qcaps(bp);
 
 	if (netif_running(bp->dev))
@@ -16401,7 +16405,7 @@ static void bnxt_shutdown(struct pci_dev *pdev)
 	if (!dev)
 		return;
 
-	rtnl_lock();
+	netdev_lock(dev);
 	bp = netdev_priv(dev);
 	if (!bp)
 		goto shutdown_exit;
@@ -16419,7 +16423,7 @@ static void bnxt_shutdown(struct pci_dev *pdev)
 	}
 
 shutdown_exit:
-	rtnl_unlock();
+	netdev_unlock(dev);
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -16431,7 +16435,7 @@ static int bnxt_suspend(struct device *device)
 
 	bnxt_ulp_stop(bp);
 
-	rtnl_lock();
+	netdev_lock(dev);
 	if (netif_running(dev)) {
 		netif_device_detach(dev);
 		rc = bnxt_close(dev);
@@ -16440,7 +16444,7 @@ static int bnxt_suspend(struct device *device)
 	bnxt_ptp_clear(bp);
 	pci_disable_device(bp->pdev);
 	bnxt_free_ctx_mem(bp, false);
-	rtnl_unlock();
+	netdev_unlock(dev);
 	return rc;
 }
 
@@ -16450,7 +16454,7 @@ static int bnxt_resume(struct device *device)
 	struct bnxt *bp = netdev_priv(dev);
 	int rc = 0;
 
-	rtnl_lock();
+	netdev_lock(dev);
 	rc = pci_enable_device(bp->pdev);
 	if (rc) {
 		netdev_err(dev, "Cannot re-enable PCI device during resume, err = %d\n",
@@ -16493,7 +16497,7 @@ static int bnxt_resume(struct device *device)
 	}
 
 resume_exit:
-	rtnl_unlock();
+	netdev_unlock(bp->dev);
 	bnxt_ulp_start(bp, rc);
 	if (!rc)
 		bnxt_reenable_sriov(bp);
@@ -16528,7 +16532,7 @@ static pci_ers_result_t bnxt_io_error_detected(struct pci_dev *pdev,
 
 	bnxt_ulp_stop(bp);
 
-	rtnl_lock();
+	netdev_lock(netdev);
 	netif_device_detach(netdev);
 
 	if (test_and_set_bit(BNXT_STATE_IN_FW_RESET, &bp->state)) {
@@ -16537,7 +16541,7 @@ static pci_ers_result_t bnxt_io_error_detected(struct pci_dev *pdev,
 	}
 
 	if (abort || state == pci_channel_io_perm_failure) {
-		rtnl_unlock();
+		netdev_unlock(netdev);
 		return PCI_ERS_RESULT_DISCONNECT;
 	}
 
@@ -16556,7 +16560,7 @@ static pci_ers_result_t bnxt_io_error_detected(struct pci_dev *pdev,
 	if (pci_is_enabled(pdev))
 		pci_disable_device(pdev);
 	bnxt_free_ctx_mem(bp, false);
-	rtnl_unlock();
+	netdev_unlock(netdev);
 
 	/* Request a slot slot reset. */
 	return PCI_ERS_RESULT_NEED_RESET;
@@ -16586,7 +16590,7 @@ static pci_ers_result_t bnxt_io_slot_reset(struct pci_dev *pdev)
 	    test_bit(BNXT_STATE_PCI_CHANNEL_IO_FROZEN, &bp->state))
 		msleep(900);
 
-	rtnl_lock();
+	netdev_lock(netdev);
 
 	if (pci_enable_device(pdev)) {
 		dev_err(&pdev->dev,
@@ -16641,7 +16645,7 @@ static pci_ers_result_t bnxt_io_slot_reset(struct pci_dev *pdev)
 reset_exit:
 	clear_bit(BNXT_STATE_IN_FW_RESET, &bp->state);
 	bnxt_clear_reservations(bp, true);
-	rtnl_unlock();
+	netdev_unlock(netdev);
 
 	return result;
 }
@@ -16660,7 +16664,7 @@ static void bnxt_io_resume(struct pci_dev *pdev)
 	int err;
 
 	netdev_info(bp->dev, "PCI Slot Resume\n");
-	rtnl_lock();
+	netdev_lock(netdev);
 
 	err = bnxt_hwrm_func_qcaps(bp);
 	if (!err) {
@@ -16673,7 +16677,7 @@ static void bnxt_io_resume(struct pci_dev *pdev)
 	if (!err)
 		netif_device_attach(netdev);
 
-	rtnl_unlock();
+	netdev_unlock(netdev);
 	bnxt_ulp_start(bp, err);
 	if (!err)
 		bnxt_reenable_sriov(bp);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
index ef8288fd68f4..b06fcddfc81c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
@@ -439,14 +439,17 @@ static int bnxt_dl_reload_down(struct devlink *dl, bool netns_change,
 	case DEVLINK_RELOAD_ACTION_DRIVER_REINIT: {
 		bnxt_ulp_stop(bp);
 		rtnl_lock();
+		netdev_lock(bp->dev);
 		if (bnxt_sriov_cfg(bp)) {
 			NL_SET_ERR_MSG_MOD(extack,
 					   "reload is unsupported while VFs are allocated or being configured");
+			netdev_unlock(bp->dev);
 			rtnl_unlock();
 			bnxt_ulp_start(bp, 0);
 			return -EOPNOTSUPP;
 		}
 		if (bp->dev->reg_state == NETREG_UNREGISTERED) {
+			netdev_unlock(bp->dev);
 			rtnl_unlock();
 			bnxt_ulp_start(bp, 0);
 			return -ENODEV;
@@ -459,6 +462,7 @@ static int bnxt_dl_reload_down(struct devlink *dl, bool netns_change,
 			NL_SET_ERR_MSG_MOD(extack, "Failed to deregister");
 			if (netif_running(bp->dev))
 				dev_close(bp->dev);
+			netdev_unlock(bp->dev);
 			rtnl_unlock();
 			break;
 		}
@@ -479,7 +483,9 @@ static int bnxt_dl_reload_down(struct devlink *dl, bool netns_change,
 			return -EPERM;
 		}
 		rtnl_lock();
+		netdev_lock(bp->dev);
 		if (bp->dev->reg_state == NETREG_UNREGISTERED) {
+			netdev_unlock(bp->dev);
 			rtnl_unlock();
 			return -ENODEV;
 		}
@@ -493,6 +499,7 @@ static int bnxt_dl_reload_down(struct devlink *dl, bool netns_change,
 		if (rc) {
 			NL_SET_ERR_MSG_MOD(extack, "Failed to activate firmware");
 			clear_bit(BNXT_STATE_FW_ACTIVATE, &bp->state);
+			netdev_unlock(bp->dev);
 			rtnl_unlock();
 		}
 		break;
@@ -568,7 +575,9 @@ static int bnxt_dl_reload_up(struct devlink *dl, enum devlink_reload_action acti
 		}
 		*actions_performed |= BIT(action);
 	} else if (netif_running(bp->dev)) {
+		netdev_lock(bp->dev);
 		dev_close(bp->dev);
+		netdev_unlock(bp->dev);
 	}
 	rtnl_unlock();
 	if (action == DEVLINK_RELOAD_ACTION_DRIVER_REINIT)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
index 12b6ed51fd88..5ddddd89052f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
@@ -946,7 +946,9 @@ void bnxt_sriov_disable(struct bnxt *bp)
 
 	/* Reclaim all resources for the PF. */
 	rtnl_lock();
+	netdev_lock(bp->dev);
 	bnxt_restore_pf_fw_resources(bp);
+	netdev_unlock(bp->dev);
 	rtnl_unlock();
 }
 
@@ -956,17 +958,21 @@ int bnxt_sriov_configure(struct pci_dev *pdev, int num_vfs)
 	struct bnxt *bp = netdev_priv(dev);
 
 	rtnl_lock();
+	netdev_lock(dev);
 	if (!netif_running(dev)) {
 		netdev_warn(dev, "Reject SRIOV config request since if is down!\n");
+		netdev_unlock(dev);
 		rtnl_unlock();
 		return 0;
 	}
 	if (test_bit(BNXT_STATE_IN_FW_RESET, &bp->state)) {
 		netdev_warn(dev, "Reject SRIOV config request when FW reset is in progress\n");
+		netdev_unlock(dev);
 		rtnl_unlock();
 		return 0;
 	}
 	bp->sriov_cfg = true;
+	netdev_unlock(dev);
 	rtnl_unlock();
 
 	if (pci_vfs_assigned(bp->pdev)) {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
index e4a7f37036ed..a8e930d5dbb0 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
@@ -112,7 +112,7 @@ int bnxt_register_dev(struct bnxt_en_dev *edev,
 	struct bnxt_ulp *ulp;
 	int rc = 0;
 
-	rtnl_lock();
+	netdev_lock(dev);
 	mutex_lock(&edev->en_dev_lock);
 	if (!bp->irq_tbl) {
 		rc = -ENODEV;
@@ -138,7 +138,7 @@ int bnxt_register_dev(struct bnxt_en_dev *edev,
 	edev->flags |= BNXT_EN_FLAG_MSIX_REQUESTED;
 exit:
 	mutex_unlock(&edev->en_dev_lock);
-	rtnl_unlock();
+	netdev_unlock(dev);
 	return rc;
 }
 EXPORT_SYMBOL(bnxt_register_dev);
@@ -151,7 +151,7 @@ void bnxt_unregister_dev(struct bnxt_en_dev *edev)
 	int i = 0;
 
 	ulp = edev->ulp_tbl;
-	rtnl_lock();
+	netdev_lock(dev);
 	mutex_lock(&edev->en_dev_lock);
 	if (ulp->msix_requested)
 		edev->flags &= ~BNXT_EN_FLAG_MSIX_REQUESTED;
@@ -169,7 +169,7 @@ void bnxt_unregister_dev(struct bnxt_en_dev *edev)
 		i++;
 	}
 	mutex_unlock(&edev->en_dev_lock);
-	rtnl_unlock();
+	netdev_unlock(dev);
 	return;
 }
 EXPORT_SYMBOL(bnxt_unregister_dev);
@@ -309,12 +309,14 @@ void bnxt_ulp_irq_stop(struct bnxt *bp)
 		if (!ulp->msix_requested)
 			return;
 
-		ops = rtnl_dereference(ulp->ulp_ops);
+		netdev_lock(bp->dev);
+		ops = rcu_dereference(ulp->ulp_ops);
 		if (!ops || !ops->ulp_irq_stop)
 			return;
 		if (test_bit(BNXT_STATE_FW_RESET_DET, &bp->state))
 			reset = true;
 		ops->ulp_irq_stop(ulp->handle, reset);
+		netdev_unlock(bp->dev);
 	}
 }
 
@@ -333,7 +335,8 @@ void bnxt_ulp_irq_restart(struct bnxt *bp, int err)
 		if (!ulp->msix_requested)
 			return;
 
-		ops = rtnl_dereference(ulp->ulp_ops);
+		netdev_lock(bp->dev);
+		ops = rcu_dereference(ulp->ulp_ops);
 		if (!ops || !ops->ulp_irq_restart)
 			return;
 
@@ -345,6 +348,7 @@ void bnxt_ulp_irq_restart(struct bnxt *bp, int err)
 			bnxt_fill_msix_vecs(bp, ent);
 		}
 		ops->ulp_irq_restart(ulp->handle, ent);
+		netdev_unlock(bp->dev);
 		kfree(ent);
 	}
 }
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c
index 1467b94a6427..619f0844e778 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c
@@ -257,8 +257,7 @@ bool bnxt_dev_is_vf_rep(struct net_device *dev)
 
 /* Called when the parent PF interface is closed:
  * As the mode transition from SWITCHDEV to LEGACY
- * happens under the rtnl_lock() this routine is safe
- * under the rtnl_lock()
+ * happens under the netdev instance lock this routine is safe
  */
 void bnxt_vf_reps_close(struct bnxt *bp)
 {
@@ -278,8 +277,7 @@ void bnxt_vf_reps_close(struct bnxt *bp)
 
 /* Called when the parent PF interface is opened (re-opened):
  * As the mode transition from SWITCHDEV to LEGACY
- * happen under the rtnl_lock() this routine is safe
- * under the rtnl_lock()
+ * happen under the netdev instance lock this routine is safe
  */
 void bnxt_vf_reps_open(struct bnxt *bp)
 {
@@ -348,7 +346,7 @@ void bnxt_vf_reps_destroy(struct bnxt *bp)
 	/* Ensure that parent PF's and VF-reps' RX/TX has been quiesced
 	 * before proceeding with VF-rep cleanup.
 	 */
-	rtnl_lock();
+	netdev_lock(bp->dev);
 	if (netif_running(bp->dev)) {
 		bnxt_close_nic(bp, false, false);
 		closed = true;
@@ -365,10 +363,10 @@ void bnxt_vf_reps_destroy(struct bnxt *bp)
 		bnxt_open_nic(bp, false, false);
 		bp->eswitch_mode = DEVLINK_ESWITCH_MODE_SWITCHDEV;
 	}
-	rtnl_unlock();
+	netdev_unlock(bp->dev);
 
-	/* Need to call vf_reps_destroy() outside of rntl_lock
-	 * as unregister_netdev takes rtnl_lock
+	/* Need to call vf_reps_destroy() outside of netdev instance lock
+	 * as unregister_netdev takes it
 	 */
 	__bnxt_vf_reps_destroy(bp);
 }
@@ -376,7 +374,7 @@ void bnxt_vf_reps_destroy(struct bnxt *bp)
 /* Free the VF-Reps in firmware, during firmware hot-reset processing.
  * Note that the VF-Rep netdevs are still active (not unregistered) during
  * this process. As the mode transition from SWITCHDEV to LEGACY happens
- * under the rtnl_lock() this routine is safe under the rtnl_lock().
+ * under the netdev instance lock this routine is safe.
  */
 void bnxt_vf_reps_free(struct bnxt *bp)
 {
@@ -413,7 +411,7 @@ static int bnxt_alloc_vf_rep(struct bnxt *bp, struct bnxt_vf_rep *vf_rep,
 /* Allocate the VF-Reps in firmware, during firmware hot-reset processing.
  * Note that the VF-Rep netdevs are still active (not unregistered) during
  * this process. As the mode transition from SWITCHDEV to LEGACY happens
- * under the rtnl_lock() this routine is safe under the rtnl_lock().
+ * under the netdev instance lock this routine is safe.
  */
 int bnxt_vf_reps_alloc(struct bnxt *bp)
 {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index e6c64e4bd66c..0caf6e9bccb8 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -382,13 +382,14 @@ int bnxt_xdp_xmit(struct net_device *dev, int num_frames,
 	return nxmit;
 }
 
-/* Under rtnl_lock */
 static int bnxt_xdp_set(struct bnxt *bp, struct bpf_prog *prog)
 {
 	struct net_device *dev = bp->dev;
 	int tx_xdp = 0, tx_cp, rc, tc;
 	struct bpf_prog *old;
 
+	netdev_assert_locked(dev);
+
 	if (prog && !prog->aux->xdp_has_frags &&
 	    bp->dev->mtu > BNXT_MAX_PAGE_MODE_MTU) {
 		netdev_warn(dev, "MTU %d larger than %d without XDP frag support.\n",
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 59c7c35bae33..3f168ed35b69 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2705,6 +2705,11 @@ static inline void netdev_lock(struct net_device *dev)
 	mutex_lock(&dev->lock);
 }
 
+static inline bool netdev_trylock(struct net_device *dev)
+{
+	return mutex_trylock(&dev->lock);
+}
+
 static inline void netdev_unlock(struct net_device *dev)
 {
 	mutex_unlock(&dev->lock);
-- 
2.48.1


