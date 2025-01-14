Return-Path: <netdev+bounces-157977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B31A0FFBD
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 04:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 922101620D7
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 03:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB842309A4;
	Tue, 14 Jan 2025 03:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6BieY7R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD519230985
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 03:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736826691; cv=none; b=nzOXKW38CmU/y6fuSJeNnfs5EoDyzyJ8hwrWG+4hTtBfXN3OStGDfRxcfoMQVQZaMkp5xDLuUpKMITBFRwkWANMmkCLPMF+sOxFAL5vfCflC1/vVETpzxLnv4X5Og9t9WwM94bT1vyRkQ7D+HCdTtsAl9CP3xlU/tOBPm9EXVAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736826691; c=relaxed/simple;
	bh=1cMjQBYAGQdst9IgSAnbXaq3v++n0uJW90xcc+ub/2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XOHMLtd0EplxMO/o9iVbOeSROnyrKIQdpybg64jYiL7VaZOWOIm1h37qV9yjjJtEodeiKhM+47wj0JNiCLcqN2yjZBAYH0MWm11563/YsgZ/7IFH17iIU3o+om41JWD+rKKp9zcaqlKhAqgjuCOGE48zneQz16buh1oOmskFeEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6BieY7R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB18C4CEE3;
	Tue, 14 Jan 2025 03:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736826690;
	bh=1cMjQBYAGQdst9IgSAnbXaq3v++n0uJW90xcc+ub/2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C6BieY7R5CCwcHsN0vGaV6m7b/0S4lmsXIAv5v07e/9umXEjMHMHb4LJ/RE8Xd+RB
	 af8BukeD/lwQ+NRwp9IP7y+BdqzI3JDv1Ha/IxRlA/4rZ74vWbmyN6QXloz3pLPo3e
	 qtSoVgxkweGzTHlWKny28EO0T2KOH8ivLgn/hfluFODqEVo2vxDs9RuOen6K8mJm5l
	 i1gercupCjIQuxH/poNYWLmq0VQeX90EWbQAUS3rPyu0ObpJdqP0BUlUIH44Spl9Y+
	 ZZoQSOBY/4EUdJzzZIa/HC6nJH/1RpZTTEz21Cu2FX6MUOMaCX5OHfwRcibVRFnjHo
	 UPnflrz0D/lKQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	jdamato@fastly.com,
	Jakub Kicinski <kuba@kernel.org>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	jiri@resnulli.us
Subject: [PATCH net-next 01/11] net: add netdev_lock() / netdev_unlock() helpers
Date: Mon, 13 Jan 2025 19:51:07 -0800
Message-ID: <20250114035118.110297-2-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250114035118.110297-1-kuba@kernel.org>
References: <20250114035118.110297-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add helpers for locking the netdev instance and use it in drivers
and the shaper code. This will make grepping for the lock usage
much easier, as we extend the lock to cover more fields.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: anthony.l.nguyen@intel.com
CC: przemyslaw.kitszel@intel.com
CC: jiri@resnulli.us
---
 include/linux/netdevice.h                   | 23 ++++++-
 drivers/net/ethernet/intel/iavf/iavf_main.c | 74 ++++++++++-----------
 drivers/net/netdevsim/ethtool.c             |  4 +-
 net/shaper/shaper.c                         |  6 +-
 4 files changed, 63 insertions(+), 44 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index dd8f6f8991fe..0e008ce9d5ee 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2444,8 +2444,12 @@ struct net_device {
 	u32			napi_defer_hard_irqs;
 
 	/**
-	 * @lock: protects @net_shaper_hierarchy, feel free to use for other
-	 * netdev-scope protection. Ordering: take after rtnl_lock.
+	 * @lock: netdev-scope lock, protects a small selection of fields.
+	 * Should always be taken using netdev_lock() / netdev_unlock() helpers.
+	 * Drivers are free to use it for other protection.
+	 *
+	 * Protects: @net_shaper_hierarchy.
+	 * Ordering: take after rtnl_lock.
 	 */
 	struct mutex		lock;
 
@@ -2671,6 +2675,21 @@ void netif_queue_set_napi(struct net_device *dev, unsigned int queue_index,
 			  enum netdev_queue_type type,
 			  struct napi_struct *napi);
 
+static inline void netdev_lock(struct net_device *dev)
+{
+	mutex_lock(&dev->lock);
+}
+
+static inline void netdev_unlock(struct net_device *dev)
+{
+	mutex_unlock(&dev->lock);
+}
+
+static inline void netdev_assert_locked(struct net_device *dev)
+{
+	lockdep_assert_held(&dev->lock);
+}
+
 static inline void netif_napi_set_irq(struct napi_struct *napi, int irq)
 {
 	napi->irq = irq;
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 7740f446c73f..ab908d620285 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1977,7 +1977,7 @@ static void iavf_finish_config(struct work_struct *work)
 	 * The dev->lock is needed to update the queue number
 	 */
 	rtnl_lock();
-	mutex_lock(&adapter->netdev->lock);
+	netdev_lock(adapter->netdev);
 	mutex_lock(&adapter->crit_lock);
 
 	if ((adapter->flags & IAVF_FLAG_SETUP_NETDEV_FEATURES) &&
@@ -1997,7 +1997,7 @@ static void iavf_finish_config(struct work_struct *work)
 		netif_set_real_num_tx_queues(adapter->netdev, pairs);
 
 		if (adapter->netdev->reg_state != NETREG_REGISTERED) {
-			mutex_unlock(&adapter->netdev->lock);
+			netdev_unlock(adapter->netdev);
 			netdev_released = true;
 			err = register_netdevice(adapter->netdev);
 			if (err) {
@@ -2027,7 +2027,7 @@ static void iavf_finish_config(struct work_struct *work)
 out:
 	mutex_unlock(&adapter->crit_lock);
 	if (!netdev_released)
-		mutex_unlock(&adapter->netdev->lock);
+		netdev_unlock(adapter->netdev);
 	rtnl_unlock();
 }
 
@@ -2724,10 +2724,10 @@ static void iavf_watchdog_task(struct work_struct *work)
 	struct iavf_hw *hw = &adapter->hw;
 	u32 reg_val;
 
-	mutex_lock(&netdev->lock);
+	netdev_lock(netdev);
 	if (!mutex_trylock(&adapter->crit_lock)) {
 		if (adapter->state == __IAVF_REMOVE) {
-			mutex_unlock(&netdev->lock);
+			netdev_unlock(netdev);
 			return;
 		}
 
@@ -2741,35 +2741,35 @@ static void iavf_watchdog_task(struct work_struct *work)
 	case __IAVF_STARTUP:
 		iavf_startup(adapter);
 		mutex_unlock(&adapter->crit_lock);
-		mutex_unlock(&netdev->lock);
+		netdev_unlock(netdev);
 		queue_delayed_work(adapter->wq, &adapter->watchdog_task,
 				   msecs_to_jiffies(30));
 		return;
 	case __IAVF_INIT_VERSION_CHECK:
 		iavf_init_version_check(adapter);
 		mutex_unlock(&adapter->crit_lock);
-		mutex_unlock(&netdev->lock);
+		netdev_unlock(netdev);
 		queue_delayed_work(adapter->wq, &adapter->watchdog_task,
 				   msecs_to_jiffies(30));
 		return;
 	case __IAVF_INIT_GET_RESOURCES:
 		iavf_init_get_resources(adapter);
 		mutex_unlock(&adapter->crit_lock);
-		mutex_unlock(&netdev->lock);
+		netdev_unlock(netdev);
 		queue_delayed_work(adapter->wq, &adapter->watchdog_task,
 				   msecs_to_jiffies(1));
 		return;
 	case __IAVF_INIT_EXTENDED_CAPS:
 		iavf_init_process_extended_caps(adapter);
 		mutex_unlock(&adapter->crit_lock);
-		mutex_unlock(&netdev->lock);
+		netdev_unlock(netdev);
 		queue_delayed_work(adapter->wq, &adapter->watchdog_task,
 				   msecs_to_jiffies(1));
 		return;
 	case __IAVF_INIT_CONFIG_ADAPTER:
 		iavf_init_config_adapter(adapter);
 		mutex_unlock(&adapter->crit_lock);
-		mutex_unlock(&netdev->lock);
+		netdev_unlock(netdev);
 		queue_delayed_work(adapter->wq, &adapter->watchdog_task,
 				   msecs_to_jiffies(1));
 		return;
@@ -2781,7 +2781,7 @@ static void iavf_watchdog_task(struct work_struct *work)
 			 * as it can loop forever
 			 */
 			mutex_unlock(&adapter->crit_lock);
-			mutex_unlock(&netdev->lock);
+			netdev_unlock(netdev);
 			return;
 		}
 		if (++adapter->aq_wait_count > IAVF_AQ_MAX_ERR) {
@@ -2790,7 +2790,7 @@ static void iavf_watchdog_task(struct work_struct *work)
 			adapter->flags |= IAVF_FLAG_PF_COMMS_FAILED;
 			iavf_shutdown_adminq(hw);
 			mutex_unlock(&adapter->crit_lock);
-			mutex_unlock(&netdev->lock);
+			netdev_unlock(netdev);
 			queue_delayed_work(adapter->wq,
 					   &adapter->watchdog_task, (5 * HZ));
 			return;
@@ -2798,7 +2798,7 @@ static void iavf_watchdog_task(struct work_struct *work)
 		/* Try again from failed step*/
 		iavf_change_state(adapter, adapter->last_state);
 		mutex_unlock(&adapter->crit_lock);
-		mutex_unlock(&netdev->lock);
+		netdev_unlock(netdev);
 		queue_delayed_work(adapter->wq, &adapter->watchdog_task, HZ);
 		return;
 	case __IAVF_COMM_FAILED:
@@ -2811,7 +2811,7 @@ static void iavf_watchdog_task(struct work_struct *work)
 			iavf_change_state(adapter, __IAVF_INIT_FAILED);
 			adapter->flags &= ~IAVF_FLAG_PF_COMMS_FAILED;
 			mutex_unlock(&adapter->crit_lock);
-			mutex_unlock(&netdev->lock);
+			netdev_unlock(netdev);
 			return;
 		}
 		reg_val = rd32(hw, IAVF_VFGEN_RSTAT) &
@@ -2831,14 +2831,14 @@ static void iavf_watchdog_task(struct work_struct *work)
 		adapter->aq_required = 0;
 		adapter->current_op = VIRTCHNL_OP_UNKNOWN;
 		mutex_unlock(&adapter->crit_lock);
-		mutex_unlock(&netdev->lock);
+		netdev_unlock(netdev);
 		queue_delayed_work(adapter->wq,
 				   &adapter->watchdog_task,
 				   msecs_to_jiffies(10));
 		return;
 	case __IAVF_RESETTING:
 		mutex_unlock(&adapter->crit_lock);
-		mutex_unlock(&netdev->lock);
+		netdev_unlock(netdev);
 		queue_delayed_work(adapter->wq, &adapter->watchdog_task,
 				   HZ * 2);
 		return;
@@ -2869,7 +2869,7 @@ static void iavf_watchdog_task(struct work_struct *work)
 	case __IAVF_REMOVE:
 	default:
 		mutex_unlock(&adapter->crit_lock);
-		mutex_unlock(&netdev->lock);
+		netdev_unlock(netdev);
 		return;
 	}
 
@@ -2881,14 +2881,14 @@ static void iavf_watchdog_task(struct work_struct *work)
 		dev_err(&adapter->pdev->dev, "Hardware reset detected\n");
 		iavf_schedule_reset(adapter, IAVF_FLAG_RESET_PENDING);
 		mutex_unlock(&adapter->crit_lock);
-		mutex_unlock(&netdev->lock);
+		netdev_unlock(netdev);
 		queue_delayed_work(adapter->wq,
 				   &adapter->watchdog_task, HZ * 2);
 		return;
 	}
 
 	mutex_unlock(&adapter->crit_lock);
-	mutex_unlock(&netdev->lock);
+	netdev_unlock(netdev);
 restart_watchdog:
 	if (adapter->state >= __IAVF_DOWN)
 		queue_work(adapter->wq, &adapter->adminq_task);
@@ -3015,12 +3015,12 @@ static void iavf_reset_task(struct work_struct *work)
 	/* When device is being removed it doesn't make sense to run the reset
 	 * task, just return in such a case.
 	 */
-	mutex_lock(&netdev->lock);
+	netdev_lock(netdev);
 	if (!mutex_trylock(&adapter->crit_lock)) {
 		if (adapter->state != __IAVF_REMOVE)
 			queue_work(adapter->wq, &adapter->reset_task);
 
-		mutex_unlock(&netdev->lock);
+		netdev_unlock(netdev);
 		return;
 	}
 
@@ -3068,7 +3068,7 @@ static void iavf_reset_task(struct work_struct *work)
 			reg_val);
 		iavf_disable_vf(adapter);
 		mutex_unlock(&adapter->crit_lock);
-		mutex_unlock(&netdev->lock);
+		netdev_unlock(netdev);
 		return; /* Do not attempt to reinit. It's dead, Jim. */
 	}
 
@@ -3209,7 +3209,7 @@ static void iavf_reset_task(struct work_struct *work)
 
 	wake_up(&adapter->reset_waitqueue);
 	mutex_unlock(&adapter->crit_lock);
-	mutex_unlock(&netdev->lock);
+	netdev_unlock(netdev);
 
 	return;
 reset_err:
@@ -3220,7 +3220,7 @@ static void iavf_reset_task(struct work_struct *work)
 	iavf_disable_vf(adapter);
 
 	mutex_unlock(&adapter->crit_lock);
-	mutex_unlock(&netdev->lock);
+	netdev_unlock(netdev);
 	dev_err(&adapter->pdev->dev, "failed to allocate resources during reinit\n");
 }
 
@@ -3692,10 +3692,10 @@ static int __iavf_setup_tc(struct net_device *netdev, void *type_data)
 	if (test_bit(__IAVF_IN_REMOVE_TASK, &adapter->crit_section))
 		return 0;
 
-	mutex_lock(&netdev->lock);
+	netdev_lock(netdev);
 	netif_set_real_num_rx_queues(netdev, total_qps);
 	netif_set_real_num_tx_queues(netdev, total_qps);
-	mutex_unlock(&netdev->lock);
+	netdev_unlock(netdev);
 
 	return ret;
 }
@@ -4365,7 +4365,7 @@ static int iavf_open(struct net_device *netdev)
 		return -EIO;
 	}
 
-	mutex_lock(&netdev->lock);
+	netdev_lock(netdev);
 	while (!mutex_trylock(&adapter->crit_lock)) {
 		/* If we are in __IAVF_INIT_CONFIG_ADAPTER state the crit_lock
 		 * is already taken and iavf_open is called from an upper
@@ -4373,7 +4373,7 @@ static int iavf_open(struct net_device *netdev)
 		 * We have to leave here to avoid dead lock.
 		 */
 		if (adapter->state == __IAVF_INIT_CONFIG_ADAPTER) {
-			mutex_unlock(&netdev->lock);
+			netdev_unlock(netdev);
 			return -EBUSY;
 		}
 
@@ -4424,7 +4424,7 @@ static int iavf_open(struct net_device *netdev)
 	iavf_irq_enable(adapter, true);
 
 	mutex_unlock(&adapter->crit_lock);
-	mutex_unlock(&netdev->lock);
+	netdev_unlock(netdev);
 
 	return 0;
 
@@ -4437,7 +4437,7 @@ static int iavf_open(struct net_device *netdev)
 	iavf_free_all_tx_resources(adapter);
 err_unlock:
 	mutex_unlock(&adapter->crit_lock);
-	mutex_unlock(&netdev->lock);
+	netdev_unlock(netdev);
 
 	return err;
 }
@@ -4459,12 +4459,12 @@ static int iavf_close(struct net_device *netdev)
 	u64 aq_to_restore;
 	int status;
 
-	mutex_lock(&netdev->lock);
+	netdev_lock(netdev);
 	mutex_lock(&adapter->crit_lock);
 
 	if (adapter->state <= __IAVF_DOWN_PENDING) {
 		mutex_unlock(&adapter->crit_lock);
-		mutex_unlock(&netdev->lock);
+		netdev_unlock(netdev);
 		return 0;
 	}
 
@@ -4498,7 +4498,7 @@ static int iavf_close(struct net_device *netdev)
 	iavf_free_traffic_irqs(adapter);
 
 	mutex_unlock(&adapter->crit_lock);
-	mutex_unlock(&netdev->lock);
+	netdev_unlock(netdev);
 
 	/* We explicitly don't free resources here because the hardware is
 	 * still active and can DMA into memory. Resources are cleared in
@@ -5375,7 +5375,7 @@ static int iavf_suspend(struct device *dev_d)
 
 	netif_device_detach(netdev);
 
-	mutex_lock(&netdev->lock);
+	netdev_lock(netdev);
 	mutex_lock(&adapter->crit_lock);
 
 	if (netif_running(netdev)) {
@@ -5387,7 +5387,7 @@ static int iavf_suspend(struct device *dev_d)
 	iavf_reset_interrupt_capability(adapter);
 
 	mutex_unlock(&adapter->crit_lock);
-	mutex_unlock(&netdev->lock);
+	netdev_unlock(netdev);
 
 	return 0;
 }
@@ -5486,7 +5486,7 @@ static void iavf_remove(struct pci_dev *pdev)
 	if (netdev->reg_state == NETREG_REGISTERED)
 		unregister_netdev(netdev);
 
-	mutex_lock(&netdev->lock);
+	netdev_lock(netdev);
 	mutex_lock(&adapter->crit_lock);
 	dev_info(&adapter->pdev->dev, "Removing device\n");
 	iavf_change_state(adapter, __IAVF_REMOVE);
@@ -5523,7 +5523,7 @@ static void iavf_remove(struct pci_dev *pdev)
 	mutex_destroy(&hw->aq.asq_mutex);
 	mutex_unlock(&adapter->crit_lock);
 	mutex_destroy(&adapter->crit_lock);
-	mutex_unlock(&netdev->lock);
+	netdev_unlock(netdev);
 
 	iounmap(hw->hw_addr);
 	pci_release_regions(pdev);
diff --git a/drivers/net/netdevsim/ethtool.c b/drivers/net/netdevsim/ethtool.c
index 5fe1eaef99b5..3f44a11aec83 100644
--- a/drivers/net/netdevsim/ethtool.c
+++ b/drivers/net/netdevsim/ethtool.c
@@ -103,10 +103,10 @@ nsim_set_channels(struct net_device *dev, struct ethtool_channels *ch)
 	struct netdevsim *ns = netdev_priv(dev);
 	int err;
 
-	mutex_lock(&dev->lock);
+	netdev_lock(dev);
 	err = netif_set_real_num_queues(dev, ch->combined_count,
 					ch->combined_count);
-	mutex_unlock(&dev->lock);
+	netdev_unlock(dev);
 	if (err)
 		return err;
 
diff --git a/net/shaper/shaper.c b/net/shaper/shaper.c
index 15463062fe7b..7101a48bce54 100644
--- a/net/shaper/shaper.c
+++ b/net/shaper/shaper.c
@@ -40,7 +40,7 @@ static void net_shaper_lock(struct net_shaper_binding *binding)
 {
 	switch (binding->type) {
 	case NET_SHAPER_BINDING_TYPE_NETDEV:
-		mutex_lock(&binding->netdev->lock);
+		netdev_lock(binding->netdev);
 		break;
 	}
 }
@@ -49,7 +49,7 @@ static void net_shaper_unlock(struct net_shaper_binding *binding)
 {
 	switch (binding->type) {
 	case NET_SHAPER_BINDING_TYPE_NETDEV:
-		mutex_unlock(&binding->netdev->lock);
+		netdev_unlock(binding->netdev);
 		break;
 	}
 }
@@ -1398,7 +1398,7 @@ void net_shaper_set_real_num_tx_queues(struct net_device *dev,
 	/* Only drivers implementing shapers support ensure
 	 * the lock is acquired in advance.
 	 */
-	lockdep_assert_held(&dev->lock);
+	netdev_assert_locked(dev);
 
 	/* Take action only when decreasing the tx queue number. */
 	for (i = txq; i < dev->real_num_tx_queues; ++i) {
-- 
2.47.1


