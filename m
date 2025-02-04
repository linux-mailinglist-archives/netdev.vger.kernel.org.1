Return-Path: <netdev+bounces-162798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 477C3A27F2D
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 00:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 895FE1887E7A
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 23:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177B221ADC3;
	Tue,  4 Feb 2025 23:01:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0368021CA0D
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 23:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738710068; cv=none; b=PbXfcyKtLgl0d/v5nYK+MDMXIsf9NI60f7cwtWy3WcpDpLzCLIBW2kqAqXMcXC8iLvzNTwnkxoir2JiW995UYS8j0fYqBz6M4DMB/0VX2Dc+x2oyDgsPV6p5EsVkwfKGf2FhNzUB5m3odygiZIItLeKijysTRssfX6EWsHA8hsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738710068; c=relaxed/simple;
	bh=pxdVJHsG5TtOmh2bYZk5tIk5Iyn/1I/7rQjtXEILnL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YGT7ICNCSOzqvdmsAlyi6gEpqtQjTSMqd9Kia2e48N/tQh4zck+o4nxXeYDY3f8IABIQyU+ziNb1hGOhRNc1959bND20HaMsW09A+FEvbFjkWbxKJv+TOAIoTOzyG/7kno21DvYg7b+WAoInTdTG4iSLrkYq9SAHHrtJozpe11w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2f42992f608so8563800a91.0
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 15:01:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738710064; x=1739314864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJTU5+TDbGyMnNZqTELfGW3+4rhP8OcNS2sTQLWkPv8=;
        b=bJi7C1Qkyl2JMJKLe9+FZzGyrVv50PhWt0N3YiDSDVZ3aQcP6ofvYqVcM8JaSV1ogQ
         FDp/DZPyw1KblGXeD9r+L0N90ctw3XR7ZDzBGnYEAm0jwgON7IMH8hElcTJEAub7P7aU
         gkWc7QTTkWCoYRC0K1HonktaJxQpWQUyhQ1icGAW2O2Ja0r4MmXEfZ+5k4HidKNdMV8I
         HyK2t4ffmIZ6YLMHhlU5JXulSZu0+WMCJdZu8U1BywR/L+sTOB7pge7HFph1IzC73mYE
         9PUh2Q7gGDQ+eUGzVEB4EqYZEKE8KE/8E2d8Atqe/KWFHZ32wWfUYbolvnG47RoJVCK8
         9Ynw==
X-Gm-Message-State: AOJu0Yy6ZG20lyw9wl30FTEzzsFK6IjpXFUYpHIk0PJE51rRDCI3ISI4
	ODI2ZVP6EuPH9kxgGv2rFMQBd+pbXwyz3gOofe8s0dV263UZTcOWS3kD
X-Gm-Gg: ASbGncvYf1gGpiKhctJB2x39SxskGTlKpbp0I5Aq569TXZNlTdTQecOCEj5/fW+DgfX
	KuGPlX/I0tbFr2Scurz4HwCeRoTs7t0vZlIsLU4CN/XxvGrC31AZZ2mj0onctEJ8+/bqh2sSBKO
	wtjgQHx1WxoR8qdNu0DTTs/YDoBhKt3Q0XKN8ZeAJfzW/1U8TFC4xnraIv/lUywzymoKWMmxam5
	mu/NqSvdjGFsgq6/s8VjEQ409abSDjkQgfGtf2hnY0tT3Vb8NvEWgmyVkLMZZxs9zygWxwkw4Iz
	mLkX25rh6nNnI+c=
X-Google-Smtp-Source: AGHT+IEkF9OBWZJAFJueqBdExBP07IO57fbf+X/X1duuDeT86AKv7csyml6Xt21vjNjk3QeEf2xQZQ==
X-Received: by 2002:a17:90b:3557:b0:2f4:434d:c7f0 with SMTP id 98e67ed59e1d1-2f9e076271fmr1034338a91.12.1738710063799;
        Tue, 04 Feb 2025 15:01:03 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2f9e1d60f72sm94231a91.3.2025.02.04.15.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 15:01:03 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: [RFC net-next 4/4] net: Hold netdev instance lock during queue operations
Date: Tue,  4 Feb 2025 15:00:57 -0800
Message-ID: <20250204230057.1270362-5-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204230057.1270362-1-sdf@fomichev.me>
References: <20250204230057.1270362-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For the drivers that use queue management API, switch to the mode where
core stack holds the netdev instance lock. This affects the following drivers:
- bnxt
- gve
- netdevsim

Originally I locked only start/stop, but switched to holding the
lock over all iterations to make them look atomic to the device
(feels like it should be easier to reason about).

Cc: Saeed Mahameed <saeed@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 Documentation/networking/netdevices.rst       | 30 ++++++++---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 54 +++++++++++++++----
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 11 ++--
 .../net/ethernet/broadcom/bnxt/bnxt_sriov.c   |  2 +
 drivers/net/ethernet/google/gve/gve_main.c    |  8 +--
 drivers/net/ethernet/google/gve/gve_utils.c   |  8 +--
 drivers/net/netdevsim/netdev.c                | 22 ++++----
 include/linux/netdevice.h                     |  2 +-
 net/core/netdev_rx_queue.c                    |  5 ++
 9 files changed, 103 insertions(+), 39 deletions(-)

diff --git a/Documentation/networking/netdevices.rst b/Documentation/networking/netdevices.rst
index 3ed1bf322a5c..1ebd3bf011f3 100644
--- a/Documentation/networking/netdevices.rst
+++ b/Documentation/networking/netdevices.rst
@@ -211,18 +211,18 @@ struct net_device synchronization rules
 =======================================
 ndo_open:
 	Synchronization: rtnl_lock() semaphore. In addition, netdev instance
-	lock if the driver implements shaper API.
+	lock if the driver implements queue management or shaper API.
 	Context: process
 
 ndo_stop:
 	Synchronization: rtnl_lock() semaphore. In addition, netdev instance
-	lock if the driver implements shaper API.
+	lock if the driver implements queue management or shaper API.
 	Context: process
 	Note: netif_running() is guaranteed false
 
 ndo_do_ioctl:
 	Synchronization: rtnl_lock() semaphore. In addition, netdev instance
-	lock if the driver implements shaper API.
+	lock if the driver implements queue management or shaper API.
 	Context: process
 
 	This is only called by network subsystems internally,
@@ -231,7 +231,7 @@ struct net_device synchronization rules
 
 ndo_siocbond:
 	Synchronization: rtnl_lock() semaphore. In addition, netdev instance
-	lock if the driver implements shaper API.
+	lock if the driver implements queue management or shaper API.
         Context: process
 
 	Used by the bonding driver for the SIOCBOND family of
@@ -239,7 +239,7 @@ struct net_device synchronization rules
 
 ndo_siocwandev:
 	Synchronization: rtnl_lock() semaphore. In addition, netdev instance
-	lock if the driver implements shaper API.
+	lock if the driver implements queue management or shaper API.
 	Context: process
 
 	Used by the drivers/net/wan framework to handle
@@ -247,7 +247,7 @@ struct net_device synchronization rules
 
 ndo_siocdevprivate:
 	Synchronization: rtnl_lock() semaphore. In addition, netdev instance
-	lock if the driver implements shaper API.
+	lock if the driver implements queue management or shaper API.
 	Context: process
 
 	This is used to implement SIOCDEVPRIVATE ioctl helpers.
@@ -255,7 +255,7 @@ struct net_device synchronization rules
 
 ndo_eth_ioctl:
 	Synchronization: rtnl_lock() semaphore. In addition, netdev instance
-	lock if the driver implements shaper API.
+	lock if the driver implements queue management or shaper API.
 	Context: process
 
 ndo_get_stats:
@@ -265,7 +265,7 @@ struct net_device synchronization rules
 
 ndo_setup_tc:
 	Synchronization: rtnl_lock() semaphore. In addition, netdev instance
-	lock if the driver implements shaper API.
+	lock if the driver implements queue management or shaper API.
 
 ndo_start_xmit:
 	Synchronization: __netif_tx_lock spinlock.
@@ -310,6 +310,20 @@ struct napi_struct synchronization rules
 		 softirq
 		 will be called with interrupts disabled by netconsole.
 
+struct netdev_queue_mgmt_ops synchronization rules
+==================================================
+ndo_queue_mem_alloc:
+	Synchronization: Netdev instance lock.
+
+ndo_queue_mem_free:
+	Synchronization: Netdev instance lock.
+
+ndo_queue_start:
+	Synchronization: Netdev instance lock.
+
+ndo_queue_stop:
+	Synchronization: Netdev instance lock.
+
 NETDEV_INTERNAL symbol namespace
 ================================
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 7b8b5b39c7bb..a16dcccfb482 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11301,7 +11301,7 @@ static int bnxt_request_irq(struct bnxt *bp)
 		if (rc)
 			break;
 
-		netif_napi_set_irq(&bp->bnapi[i]->napi, irq->vector);
+		netif_napi_set_irq_locked(&bp->bnapi[i]->napi, irq->vector);
 		irq->requested = 1;
 
 		if (zalloc_cpumask_var(&irq->cpu_mask, GFP_KERNEL)) {
@@ -11337,9 +11337,9 @@ static void bnxt_del_napi(struct bnxt *bp)
 	for (i = 0; i < bp->cp_nr_rings; i++) {
 		struct bnxt_napi *bnapi = bp->bnapi[i];
 
-		__netif_napi_del(&bnapi->napi);
+		__netif_napi_del_locked(&bnapi->napi);
 	}
-	/* We called __netif_napi_del(), we need
+	/* We called __netif_napi_del_locked(), we need
 	 * to respect an RCU grace period before freeing napi structures.
 	 */
 	synchronize_net();
@@ -11352,18 +11352,20 @@ static void bnxt_init_napi(struct bnxt *bp)
 	struct bnxt_napi *bnapi;
 	int i;
 
+	netdev_assert_locked(bp->dev);
+
 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 		poll_fn = bnxt_poll_p5;
 	else if (BNXT_CHIP_TYPE_NITRO_A0(bp))
 		cp_nr_rings--;
 	for (i = 0; i < cp_nr_rings; i++) {
 		bnapi = bp->bnapi[i];
-		netif_napi_add_config(bp->dev, &bnapi->napi, poll_fn,
-				      bnapi->index);
+		netif_napi_add_config_locked(bp->dev, &bnapi->napi, poll_fn,
+					     bnapi->index);
 	}
 	if (BNXT_CHIP_TYPE_NITRO_A0(bp)) {
 		bnapi = bp->bnapi[cp_nr_rings];
-		netif_napi_add(bp->dev, &bnapi->napi, bnxt_poll_nitroa0);
+		netif_napi_add_locked(bp->dev, &bnapi->napi, bnxt_poll_nitroa0);
 	}
 }
 
@@ -11375,6 +11377,8 @@ static void bnxt_disable_napi(struct bnxt *bp)
 	    test_and_set_bit(BNXT_STATE_NAPI_DISABLED, &bp->state))
 		return;
 
+	netdev_assert_locked(bp->dev);
+
 	for (i = 0; i < bp->cp_nr_rings; i++) {
 		struct bnxt_napi *bnapi = bp->bnapi[i];
 		struct bnxt_cp_ring_info *cpr;
@@ -11384,7 +11388,7 @@ static void bnxt_disable_napi(struct bnxt *bp)
 			cpr->sw_stats->tx.tx_resets++;
 		if (bnapi->in_reset)
 			cpr->sw_stats->rx.rx_resets++;
-		napi_disable(&bnapi->napi);
+		napi_disable_locked(&bnapi->napi);
 	}
 }
 
@@ -11392,6 +11396,8 @@ static void bnxt_enable_napi(struct bnxt *bp)
 {
 	int i;
 
+	netdev_assert_locked(bp->dev);
+
 	clear_bit(BNXT_STATE_NAPI_DISABLED, &bp->state);
 	for (i = 0; i < bp->cp_nr_rings; i++) {
 		struct bnxt_napi *bnapi = bp->bnapi[i];
@@ -11406,7 +11412,7 @@ static void bnxt_enable_napi(struct bnxt *bp)
 			INIT_WORK(&cpr->dim.work, bnxt_dim_work);
 			cpr->dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_EQE;
 		}
-		napi_enable(&bnapi->napi);
+		napi_enable_locked(&bnapi->napi);
 	}
 }
 
@@ -13291,11 +13297,17 @@ static netdev_features_t bnxt_fix_features(struct net_device *dev,
 static int bnxt_reinit_features(struct bnxt *bp, bool irq_re_init,
 				bool link_re_init, u32 flags, bool update_tpa)
 {
+	int rc;
+
+	netdev_lock(bp->dev);
 	bnxt_close_nic(bp, irq_re_init, link_re_init);
 	bp->flags = flags;
 	if (update_tpa)
 		bnxt_set_ring_params(bp);
-	return bnxt_open_nic(bp, irq_re_init, link_re_init);
+	rc = bnxt_open_nic(bp, irq_re_init, link_re_init);
+	netdev_unlock(bp->dev);
+
+	return rc;
 }
 
 static int bnxt_set_features(struct net_device *dev, netdev_features_t features)
@@ -13754,11 +13766,13 @@ static void bnxt_rtnl_lock_sp(struct bnxt *bp)
 	 */
 	clear_bit(BNXT_STATE_IN_SP_TASK, &bp->state);
 	rtnl_lock();
+	netdev_lock(bp->dev);
 }
 
 static void bnxt_rtnl_unlock_sp(struct bnxt *bp)
 {
 	set_bit(BNXT_STATE_IN_SP_TASK, &bp->state);
+	netdev_unlock(bp->dev);
 	rtnl_unlock();
 }
 
@@ -14622,8 +14636,10 @@ static void bnxt_fw_reset_task(struct work_struct *work)
 		}
 		bp->fw_reset_timestamp = jiffies;
 		rtnl_lock();
+		netdev_lock(bp->dev);
 		if (test_bit(BNXT_STATE_ABORT_ERR, &bp->state)) {
 			bnxt_fw_reset_abort(bp, rc);
+			netdev_unlock(bp->dev);
 			rtnl_unlock();
 			goto ulp_start;
 		}
@@ -14635,6 +14651,7 @@ static void bnxt_fw_reset_task(struct work_struct *work)
 			bp->fw_reset_state = BNXT_FW_RESET_STATE_ENABLE_DEV;
 			tmo = bp->fw_reset_min_dsecs * HZ / 10;
 		}
+		netdev_unlock(bp->dev);
 		rtnl_unlock();
 		bnxt_queue_fw_reset_work(bp, tmo);
 		return;
@@ -14713,7 +14730,9 @@ static void bnxt_fw_reset_task(struct work_struct *work)
 			bnxt_queue_fw_reset_work(bp, HZ / 10);
 			return;
 		}
+		netdev_lock(dev);
 		rc = bnxt_open(bp->dev);
+		netdev_unlock(dev);
 		if (rc) {
 			netdev_err(bp->dev, "bnxt_open() failed during FW reset\n");
 			bnxt_fw_reset_abort(bp, rc);
@@ -14868,10 +14887,12 @@ static int bnxt_change_mac_addr(struct net_device *dev, void *p)
 
 	eth_hw_addr_set(dev, addr->sa_data);
 	bnxt_clear_usr_fltrs(bp, true);
+	netdev_lock(dev);
 	if (netif_running(dev)) {
 		bnxt_close_nic(bp, false, false);
 		rc = bnxt_open_nic(bp, false, false);
 	}
+	netdev_unlock(dev);
 
 	return rc;
 }
@@ -14880,6 +14901,9 @@ static int bnxt_change_mac_addr(struct net_device *dev, void *p)
 static int bnxt_change_mtu(struct net_device *dev, int new_mtu)
 {
 	struct bnxt *bp = netdev_priv(dev);
+	int rc = 0;
+
+	netdev_lock(dev);
 
 	if (netif_running(dev))
 		bnxt_close_nic(bp, true, false);
@@ -14896,9 +14920,11 @@ static int bnxt_change_mtu(struct net_device *dev, int new_mtu)
 	bnxt_set_ring_params(bp);
 
 	if (netif_running(dev))
-		return bnxt_open_nic(bp, true, false);
+		rc = bnxt_open_nic(bp, true, false);
 
-	return 0;
+	netdev_unlock(dev);
+
+	return rc;
 }
 
 int bnxt_setup_mq_tc(struct net_device *dev, u8 tc)
@@ -16426,6 +16452,7 @@ static int bnxt_suspend(struct device *device)
 	bnxt_ulp_stop(bp);
 
 	rtnl_lock();
+	netdev_lock(dev);
 	if (netif_running(dev)) {
 		netif_device_detach(dev);
 		rc = bnxt_close(dev);
@@ -16434,6 +16461,7 @@ static int bnxt_suspend(struct device *device)
 	bnxt_ptp_clear(bp);
 	pci_disable_device(bp->pdev);
 	bnxt_free_ctx_mem(bp, false);
+	netdev_unlock(dev);
 	rtnl_unlock();
 	return rc;
 }
@@ -16445,6 +16473,7 @@ static int bnxt_resume(struct device *device)
 	int rc = 0;
 
 	rtnl_lock();
+	netdev_lock(dev);
 	rc = pci_enable_device(bp->pdev);
 	if (rc) {
 		netdev_err(dev, "Cannot re-enable PCI device during resume, err = %d\n",
@@ -16487,6 +16516,7 @@ static int bnxt_resume(struct device *device)
 	}
 
 resume_exit:
+	netdev_unlock(dev);
 	rtnl_unlock();
 	bnxt_ulp_start(bp, rc);
 	if (!rc)
@@ -16655,6 +16685,7 @@ static void bnxt_io_resume(struct pci_dev *pdev)
 
 	netdev_info(bp->dev, "PCI Slot Resume\n");
 	rtnl_lock();
+	netdev_lock(dev);
 
 	err = bnxt_hwrm_func_qcaps(bp);
 	if (!err) {
@@ -16667,6 +16698,7 @@ static void bnxt_io_resume(struct pci_dev *pdev)
 	if (!err)
 		netif_device_attach(netdev);
 
+	netdev_unlock(dev);
 	rtnl_unlock();
 	bnxt_ulp_start(bp, err);
 	if (!err)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 9c5820839514..2246afcdcea2 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -4929,10 +4929,12 @@ static void bnxt_self_test(struct net_device *dev, struct ethtool_test *etest,
 		return;
 	}
 
+	netdev_lock(dev);
+
 	memset(buf, 0, sizeof(u64) * bp->num_tests);
 	if (!netif_running(dev)) {
 		etest->flags |= ETH_TEST_FL_FAILED;
-		return;
+		goto unlock;
 	}
 
 	if ((etest->flags & ETH_TEST_FL_EXTERNAL_LB) &&
@@ -4943,7 +4945,7 @@ static void bnxt_self_test(struct net_device *dev, struct ethtool_test *etest,
 		if (bp->pf.active_vfs || !BNXT_SINGLE_PF(bp)) {
 			etest->flags |= ETH_TEST_FL_FAILED;
 			netdev_warn(dev, "Offline tests cannot be run with active VFs or on shared PF\n");
-			return;
+			goto unlock;
 		}
 		offline = true;
 	}
@@ -4965,7 +4967,7 @@ static void bnxt_self_test(struct net_device *dev, struct ethtool_test *etest,
 		rc = bnxt_half_open_nic(bp);
 		if (rc) {
 			etest->flags |= ETH_TEST_FL_FAILED;
-			return;
+			goto unlock;
 		}
 		buf[BNXT_MACLPBK_TEST_IDX] = 1;
 		if (bp->mac_flags & BNXT_MAC_FL_NO_MAC_LPBK)
@@ -5017,6 +5019,9 @@ static void bnxt_self_test(struct net_device *dev, struct ethtool_test *etest,
 			etest->flags |= ETH_TEST_FL_FAILED;
 		}
 	}
+
+unlock:
+	netdev_unlock(dev);
 }
 
 static int bnxt_reset(struct net_device *dev, u32 *flags)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
index 12b6ed51fd88..dc61cf63fe3f 100644
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
 
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 533e659b15b3..cf9bd08d04b2 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1886,7 +1886,7 @@ static void gve_turndown(struct gve_priv *priv)
 			netif_queue_set_napi(priv->dev, idx,
 					     NETDEV_QUEUE_TYPE_TX, NULL);
 
-		napi_disable(&block->napi);
+		napi_disable_locked(&block->napi);
 	}
 	for (idx = 0; idx < priv->rx_cfg.num_queues; idx++) {
 		int ntfy_idx = gve_rx_idx_to_ntfy(priv, idx);
@@ -1897,7 +1897,7 @@ static void gve_turndown(struct gve_priv *priv)
 
 		netif_queue_set_napi(priv->dev, idx, NETDEV_QUEUE_TYPE_RX,
 				     NULL);
-		napi_disable(&block->napi);
+		napi_disable_locked(&block->napi);
 	}
 
 	/* Stop tx queues */
@@ -1925,7 +1925,7 @@ static void gve_turnup(struct gve_priv *priv)
 		if (!gve_tx_was_added_to_block(priv, idx))
 			continue;
 
-		napi_enable(&block->napi);
+		napi_enable_locked(&block->napi);
 
 		if (idx < priv->tx_cfg.num_queues)
 			netif_queue_set_napi(priv->dev, idx,
@@ -1953,7 +1953,7 @@ static void gve_turnup(struct gve_priv *priv)
 		if (!gve_rx_was_added_to_block(priv, idx))
 			continue;
 
-		napi_enable(&block->napi);
+		napi_enable_locked(&block->napi);
 		netif_queue_set_napi(priv->dev, idx, NETDEV_QUEUE_TYPE_RX,
 				     &block->napi);
 
diff --git a/drivers/net/ethernet/google/gve/gve_utils.c b/drivers/net/ethernet/google/gve/gve_utils.c
index 30fef100257e..fa21d240806b 100644
--- a/drivers/net/ethernet/google/gve/gve_utils.c
+++ b/drivers/net/ethernet/google/gve/gve_utils.c
@@ -110,13 +110,15 @@ void gve_add_napi(struct gve_priv *priv, int ntfy_idx,
 {
 	struct gve_notify_block *block = &priv->ntfy_blocks[ntfy_idx];
 
-	netif_napi_add(priv->dev, &block->napi, gve_poll);
-	netif_napi_set_irq(&block->napi, block->irq);
+	netdev_assert_locked(priv->dev);
+	netif_napi_add_locked(priv->dev, &block->napi, gve_poll);
+	netif_napi_set_irq_locked(&block->napi, block->irq);
 }
 
 void gve_remove_napi(struct gve_priv *priv, int ntfy_idx)
 {
 	struct gve_notify_block *block = &priv->ntfy_blocks[ntfy_idx];
 
-	netif_napi_del(&block->napi);
+	netdev_assert_locked(priv->dev);
+	netif_napi_del_locked(&block->napi);
 }
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index efec03b34c9f..8faa5d22289c 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -661,7 +661,7 @@ nsim_queue_mem_alloc(struct net_device *dev, void *per_queue_mem, int idx)
 		goto err_free;
 
 	if (!ns->rq_reset_mode)
-		netif_napi_add_config(dev, &qmem->rq->napi, nsim_poll, idx);
+		netif_napi_add_config_locked(dev, &qmem->rq->napi, nsim_poll, idx);
 
 	return 0;
 
@@ -678,7 +678,7 @@ static void nsim_queue_mem_free(struct net_device *dev, void *per_queue_mem)
 	page_pool_destroy(qmem->pp);
 	if (qmem->rq) {
 		if (!ns->rq_reset_mode)
-			netif_napi_del(&qmem->rq->napi);
+			netif_napi_del_locked(&qmem->rq->napi);
 		page_pool_destroy(qmem->rq->page_pool);
 		nsim_queue_free(qmem->rq);
 	}
@@ -690,9 +690,11 @@ nsim_queue_start(struct net_device *dev, void *per_queue_mem, int idx)
 	struct nsim_queue_mem *qmem = per_queue_mem;
 	struct netdevsim *ns = netdev_priv(dev);
 
+	netdev_assert_locked(dev);
+
 	if (ns->rq_reset_mode == 1) {
 		ns->rq[idx]->page_pool = qmem->pp;
-		napi_enable(&ns->rq[idx]->napi);
+		napi_enable_locked(&ns->rq[idx]->napi);
 		return 0;
 	}
 
@@ -700,15 +702,15 @@ nsim_queue_start(struct net_device *dev, void *per_queue_mem, int idx)
 	 * here we want to test various call orders.
 	 */
 	if (ns->rq_reset_mode == 2) {
-		netif_napi_del(&ns->rq[idx]->napi);
-		netif_napi_add_config(dev, &qmem->rq->napi, nsim_poll, idx);
+		netif_napi_del_locked(&ns->rq[idx]->napi);
+		netif_napi_add_config_locked(dev, &qmem->rq->napi, nsim_poll, idx);
 	} else if (ns->rq_reset_mode == 3) {
-		netif_napi_add_config(dev, &qmem->rq->napi, nsim_poll, idx);
-		netif_napi_del(&ns->rq[idx]->napi);
+		netif_napi_add_config_locked(dev, &qmem->rq->napi, nsim_poll, idx);
+		netif_napi_del_locked(&ns->rq[idx]->napi);
 	}
 
 	ns->rq[idx] = qmem->rq;
-	napi_enable(&ns->rq[idx]->napi);
+	napi_enable_locked(&ns->rq[idx]->napi);
 
 	return 0;
 }
@@ -718,7 +720,9 @@ static int nsim_queue_stop(struct net_device *dev, void *per_queue_mem, int idx)
 	struct nsim_queue_mem *qmem = per_queue_mem;
 	struct netdevsim *ns = netdev_priv(dev);
 
-	napi_disable(&ns->rq[idx]->napi);
+	netdev_assert_locked(dev);
+
+	napi_disable_locked(&ns->rq[idx]->napi);
 
 	if (ns->rq_reset_mode == 1) {
 		qmem->pp = ns->rq[idx]->page_pool;
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index e49b818054b9..cafa587233fd 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2719,7 +2719,7 @@ static inline void netdev_assert_locked_or_invisible(struct net_device *dev)
 
 static inline bool need_netdev_ops_lock(struct net_device *dev)
 {
-	bool ret = false;
+	bool ret = !!(dev)->queue_mgmt_ops;
 
 #if IS_ENABLED(CONFIG_NET_SHAPER)
 	ret |= !!(dev)->netdev_ops->net_shaper_ops;
diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index db82786fa0c4..04a681aef907 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -30,6 +30,8 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 		goto err_free_new_mem;
 	}
 
+	netdev_lock(dev);
+
 	err = dev->queue_mgmt_ops->ndo_queue_mem_alloc(dev, new_mem, rxq_idx);
 	if (err)
 		goto err_free_old_mem;
@@ -48,6 +50,8 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 
 	dev->queue_mgmt_ops->ndo_queue_mem_free(dev, old_mem);
 
+	netdev_unlock(dev);
+
 	kvfree(old_mem);
 	kvfree(new_mem);
 
@@ -72,6 +76,7 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 	dev->queue_mgmt_ops->ndo_queue_mem_free(dev, new_mem);
 
 err_free_old_mem:
+	netdev_unlock(dev);
 	kvfree(old_mem);
 
 err_free_new_mem:
-- 
2.48.1


