Return-Path: <netdev+bounces-172150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE07CA50526
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 17:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A4F83A9697
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 16:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D661198E77;
	Wed,  5 Mar 2025 16:37:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDFB198842
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 16:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741192676; cv=none; b=E8VTxactg6NL1RY/z/Hb925BeliTDcvFj2KDtsw9TC0rS6jpWfZGTEIqTxoG4ZsMwynCWdeEkjnWwZCUi+uVA7aEuueTuru/7a58hCFZPh19BWj+oTVgVN9VzyAU8/sswSjNa8CuFJyxtlc/QgL8QXvd3nv2Ou3nor3HAb0DCL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741192676; c=relaxed/simple;
	bh=CwNPG6yvlvVNsySJa2Bv5Fzap2mVL8/8zEkmGNj5RDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V14cgYONgksr+ePUrAYOqwF7m6GHj0LxzzqT+4L/HGGNYnJoDYEs683PaLrxTJe6RsshkAIOkCF4uwn2IbYJZXmrFWHb39bmvvyHxntp/MRVCHMWi+BeF3y8pSsScy2+mz2sk3QGxIyvtwvqFbJrhjVnKMECpCCxklZxzvsZoHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ff615a114bso21607a91.0
        for <netdev@vger.kernel.org>; Wed, 05 Mar 2025 08:37:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741192672; x=1741797472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fSvhMmPhTUG4HtB5JKAuoPPGp4EVWT2Ia+6LltBaAsQ=;
        b=eThZkAZEdwXqjdC2gFHyMPD6bHYbTFFQNQnuj7Ot++Z9mM4f/Xi2zEn3a9hd9otBaT
         UFq6LssNqKb7/x60gjxZyS5H2LJBwjfBHVr0q/py3H5zOlgK4TEDEjZjxViO8oKqAc3K
         EOzorMYyRZIZ2wZDwudkau1inhg5IVn1H79hmu7nkVs7gjQHFH+N/UuruHJDpkklWCKH
         n3qS/WCa/RnJFFfbEi2qhWB/+q132J2f+Z6w/3Z0yuiN6aXsNrZ9Cfhw555XJhoc7TjN
         ZLFfyP8jx5CZOMkndcj9/QlOXqimvZoUlWLpn52yWSRbsiDu5zQc95goAs5hxVobYkqy
         Nkvw==
X-Gm-Message-State: AOJu0YxMOQaNcteStCHO/qH7RZZIt7CL8tQ+7HXfywLIpNDqFhP+gxlY
	Ka7nSk+5Z6a8fv7Bcyjz/Is5p+MQwMVQ4eeyo2A0K5eIKBXRyHauovRl
X-Gm-Gg: ASbGnctG4ZZKKPKc5T38Vox6N7CIH9IIhGkrA2Uy/pY7k8EamLh8MCCXT5OkeRlLw1T
	E660QXbB5rJb1GO2QQ+8sValcGfKwdpVC195JyeTAE6Lql5kg4uh/JqdVJ1cgMehhgzERxGw3VS
	rIshD9IwdqooDkb8SslZrHzxFbE+MakNQCq43y+kS0x5sIWmg1730AcDlRcnhPprZfjyXUiV9A1
	U91z337Kxsn0lUAzH/SlYMLJBLxGE8iu5C7AzfmdZ1jPBY7QfN+YK70S9yOGjObp4+DGWA68Zvo
	OXCQVghJ6FHGcBwbPFxep6dURz2oYKU+2qRKpa7BD8/4
X-Google-Smtp-Source: AGHT+IEdu+bhSldWfCmSK3DBeu7r7gIkMihzMhHzM8o8w9M7eubeXdMJ2q1rnC0dRqX7W0+9qo34/w==
X-Received: by 2002:a17:90b:570f:b0:2fa:603e:905c with SMTP id 98e67ed59e1d1-2ff33b7b188mr13118961a91.2.1741192671261;
        Wed, 05 Mar 2025 08:37:51 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-223504f715csm115489515ad.191.2025.03.05.08.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 08:37:50 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>,
	Michael Chan <michael.chan@broadcom.com>
Subject: [PATCH net-next v10 14/14] eth: bnxt: remove most dependencies on RTNL
Date: Wed,  5 Mar 2025 08:37:32 -0800
Message-ID: <20250305163732.2766420-15-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305163732.2766420-1-sdf@fomichev.me>
References: <20250305163732.2766420-1-sdf@fomichev.me>
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
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 117 +++++++++---------
 .../net/ethernet/broadcom/bnxt/bnxt_devlink.c |   9 ++
 .../net/ethernet/broadcom/bnxt/bnxt_sriov.c   |   6 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c |  16 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c |  18 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |   3 +-
 include/linux/netdevice.h                     |   5 +
 7 files changed, 101 insertions(+), 73 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index ead9fcaad6bd..1a1e6da77777 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -5246,8 +5246,10 @@ static void bnxt_free_ntp_fltrs(struct bnxt *bp, bool all)
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
@@ -12789,7 +12791,6 @@ static int __bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
 	return rc;
 }
 
-/* rtnl_lock held */
 int bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
 {
 	int rc = 0;
@@ -12805,9 +12806,9 @@ int bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
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
@@ -12842,8 +12843,8 @@ int bnxt_half_open_nic(struct bnxt *bp)
 	return rc;
 }
 
-/* rtnl_lock held, this call can only be made after a previous successful
- * call to bnxt_half_open_nic().
+/* netdev instance lock held, this call can only be made after a previous
+ * successful call to bnxt_half_open_nic().
  */
 void bnxt_half_close_nic(struct bnxt *bp)
 {
@@ -12952,10 +12953,11 @@ void bnxt_close_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
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
@@ -13046,7 +13048,7 @@ static int bnxt_hwrm_port_phy_write(struct bnxt *bp, u16 phy_addr, u16 reg,
 	return hwrm_req_send(bp, req);
 }
 
-/* rtnl_lock held */
+/* netdev instance lock held */
 static int bnxt_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 {
 	struct mii_ioctl_data *mdio = if_mii(ifr);
@@ -13965,30 +13967,31 @@ static void bnxt_timer(struct timer_list *t)
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
+	 * So we must clear BNXT_STATE_IN_SP_TASK before holding netdev
+	 * instance lock.
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
@@ -13996,9 +13999,9 @@ static void bnxt_rx_ring_reset(struct bnxt *bp)
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
@@ -14037,7 +14040,7 @@ static void bnxt_rx_ring_reset(struct bnxt *bp)
 	}
 	if (bp->flags & BNXT_FLAG_TPA)
 		bnxt_set_tpa(bp, true);
-	bnxt_rtnl_unlock_sp(bp);
+	bnxt_unlock_sp(bp);
 }
 
 static void bnxt_fw_fatal_close(struct bnxt *bp)
@@ -14093,7 +14096,7 @@ static bool is_bnxt_fw_ok(struct bnxt *bp)
 	return false;
 }
 
-/* rtnl_lock is acquired before calling this function */
+/* netdev instance lock is acquired before calling this function */
 static void bnxt_force_fw_reset(struct bnxt *bp)
 {
 	struct bnxt_fw_health *fw_health = bp->fw_health;
@@ -14136,9 +14139,9 @@ void bnxt_fw_exception(struct bnxt *bp)
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
@@ -14168,7 +14171,7 @@ static int bnxt_get_registered_vfs(struct bnxt *bp)
 void bnxt_fw_reset(struct bnxt *bp)
 {
 	bnxt_ulp_stop(bp);
-	bnxt_rtnl_lock_sp(bp);
+	bnxt_lock_sp(bp);
 	if (test_bit(BNXT_STATE_OPEN, &bp->state) &&
 	    !test_bit(BNXT_STATE_IN_FW_RESET, &bp->state)) {
 		struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
@@ -14214,7 +14217,7 @@ void bnxt_fw_reset(struct bnxt *bp)
 		bnxt_queue_fw_reset_work(bp, tmo);
 	}
 fw_reset_exit:
-	bnxt_rtnl_unlock_sp(bp);
+	bnxt_unlock_sp(bp);
 }
 
 static void bnxt_chk_missed_irq(struct bnxt *bp)
@@ -14413,7 +14416,7 @@ static void bnxt_sp_task(struct work_struct *work)
 static void _bnxt_get_max_rings(struct bnxt *bp, int *max_rx, int *max_tx,
 				int *max_cp);
 
-/* Under rtnl_lock */
+/* Under netdev instance lock */
 int bnxt_check_rings(struct bnxt *bp, int tx, int rx, bool sh, int tcs,
 		     int tx_xdp)
 {
@@ -14841,10 +14844,10 @@ static void bnxt_fw_reset_task(struct work_struct *work)
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
@@ -14855,7 +14858,7 @@ static void bnxt_fw_reset_task(struct work_struct *work)
 			bp->fw_reset_state = BNXT_FW_RESET_STATE_ENABLE_DEV;
 			tmo = bp->fw_reset_min_dsecs * HZ / 10;
 		}
-		rtnl_unlock();
+		netdev_unlock(bp->dev);
 		bnxt_queue_fw_reset_work(bp, tmo);
 		return;
 	}
@@ -14929,7 +14932,7 @@ static void bnxt_fw_reset_task(struct work_struct *work)
 		bp->fw_reset_state = BNXT_FW_RESET_STATE_OPENING;
 		fallthrough;
 	case BNXT_FW_RESET_STATE_OPENING:
-		while (!rtnl_trylock()) {
+		while (!netdev_trylock(bp->dev)) {
 			bnxt_queue_fw_reset_work(bp, HZ / 10);
 			return;
 		}
@@ -14937,7 +14940,7 @@ static void bnxt_fw_reset_task(struct work_struct *work)
 		if (rc) {
 			netdev_err(bp->dev, "bnxt_open() failed during FW reset\n");
 			bnxt_fw_reset_abort(bp, rc);
-			rtnl_unlock();
+			netdev_unlock(bp->dev);
 			goto ulp_start;
 		}
 
@@ -14956,13 +14959,13 @@ static void bnxt_fw_reset_task(struct work_struct *work)
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
@@ -14975,9 +14978,9 @@ static void bnxt_fw_reset_task(struct work_struct *work)
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
@@ -15069,13 +15072,14 @@ static int bnxt_init_board(struct pci_dev *pdev, struct net_device *dev)
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
 
@@ -15096,11 +15100,12 @@ static int bnxt_change_mac_addr(struct net_device *dev, void *p)
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
 
@@ -16257,7 +16262,7 @@ int bnxt_restore_pf_fw_resources(struct bnxt *bp)
 {
 	int rc;
 
-	ASSERT_RTNL();
+	netdev_ops_assert_locked(bp->dev);
 	bnxt_hwrm_func_qcaps(bp);
 
 	if (netif_running(bp->dev))
@@ -16657,7 +16662,7 @@ static void bnxt_shutdown(struct pci_dev *pdev)
 	if (!dev)
 		return;
 
-	rtnl_lock();
+	netdev_lock(dev);
 	bp = netdev_priv(dev);
 	if (!bp)
 		goto shutdown_exit;
@@ -16675,7 +16680,7 @@ static void bnxt_shutdown(struct pci_dev *pdev)
 	}
 
 shutdown_exit:
-	rtnl_unlock();
+	netdev_unlock(dev);
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -16687,7 +16692,7 @@ static int bnxt_suspend(struct device *device)
 
 	bnxt_ulp_stop(bp);
 
-	rtnl_lock();
+	netdev_lock(dev);
 	if (netif_running(dev)) {
 		netif_device_detach(dev);
 		rc = bnxt_close(dev);
@@ -16696,7 +16701,7 @@ static int bnxt_suspend(struct device *device)
 	bnxt_ptp_clear(bp);
 	pci_disable_device(bp->pdev);
 	bnxt_free_ctx_mem(bp, false);
-	rtnl_unlock();
+	netdev_unlock(dev);
 	return rc;
 }
 
@@ -16706,7 +16711,7 @@ static int bnxt_resume(struct device *device)
 	struct bnxt *bp = netdev_priv(dev);
 	int rc = 0;
 
-	rtnl_lock();
+	netdev_lock(dev);
 	rc = pci_enable_device(bp->pdev);
 	if (rc) {
 		netdev_err(dev, "Cannot re-enable PCI device during resume, err = %d\n",
@@ -16749,7 +16754,7 @@ static int bnxt_resume(struct device *device)
 	}
 
 resume_exit:
-	rtnl_unlock();
+	netdev_unlock(bp->dev);
 	bnxt_ulp_start(bp, rc);
 	if (!rc)
 		bnxt_reenable_sriov(bp);
@@ -16784,7 +16789,7 @@ static pci_ers_result_t bnxt_io_error_detected(struct pci_dev *pdev,
 
 	bnxt_ulp_stop(bp);
 
-	rtnl_lock();
+	netdev_lock(netdev);
 	netif_device_detach(netdev);
 
 	if (test_and_set_bit(BNXT_STATE_IN_FW_RESET, &bp->state)) {
@@ -16793,7 +16798,7 @@ static pci_ers_result_t bnxt_io_error_detected(struct pci_dev *pdev,
 	}
 
 	if (abort || state == pci_channel_io_perm_failure) {
-		rtnl_unlock();
+		netdev_unlock(netdev);
 		return PCI_ERS_RESULT_DISCONNECT;
 	}
 
@@ -16812,7 +16817,7 @@ static pci_ers_result_t bnxt_io_error_detected(struct pci_dev *pdev,
 	if (pci_is_enabled(pdev))
 		pci_disable_device(pdev);
 	bnxt_free_ctx_mem(bp, false);
-	rtnl_unlock();
+	netdev_unlock(netdev);
 
 	/* Request a slot slot reset. */
 	return PCI_ERS_RESULT_NEED_RESET;
@@ -16842,7 +16847,7 @@ static pci_ers_result_t bnxt_io_slot_reset(struct pci_dev *pdev)
 	    test_bit(BNXT_STATE_PCI_CHANNEL_IO_FROZEN, &bp->state))
 		msleep(900);
 
-	rtnl_lock();
+	netdev_lock(netdev);
 
 	if (pci_enable_device(pdev)) {
 		dev_err(&pdev->dev,
@@ -16897,7 +16902,7 @@ static pci_ers_result_t bnxt_io_slot_reset(struct pci_dev *pdev)
 reset_exit:
 	clear_bit(BNXT_STATE_IN_FW_RESET, &bp->state);
 	bnxt_clear_reservations(bp, true);
-	rtnl_unlock();
+	netdev_unlock(netdev);
 
 	return result;
 }
@@ -16916,7 +16921,7 @@ static void bnxt_io_resume(struct pci_dev *pdev)
 	int err;
 
 	netdev_info(bp->dev, "PCI Slot Resume\n");
-	rtnl_lock();
+	netdev_lock(netdev);
 
 	err = bnxt_hwrm_func_qcaps(bp);
 	if (!err) {
@@ -16929,7 +16934,7 @@ static void bnxt_io_resume(struct pci_dev *pdev)
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
index 2f8560a354ba..d206c9592b60 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2765,6 +2765,11 @@ static inline void netdev_lock(struct net_device *dev)
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


