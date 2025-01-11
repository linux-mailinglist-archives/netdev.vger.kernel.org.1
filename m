Return-Path: <netdev+bounces-157382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4D6A0A1D2
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 08:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 765277A7B87
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 07:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A8718E379;
	Sat, 11 Jan 2025 07:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gyMFXEec"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309061632F3
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 07:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736579625; cv=none; b=u8gDh5FKEQzFnnJJNhaPcduVMYc7uPBJP3QVvIxQJvnnVG8dJrSru0hF/FOFjpiONFwCe6mUY6vYB7cFgCjya62oljPKdSODDiB1n8UCfdskl7F342jOKRKr+rYa9xD+vFPBGv9WEcO2ip0fpR53NhXwI/Aa8lV5gx1pPT6luEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736579625; c=relaxed/simple;
	bh=tjOQooaPMspwaRUEYfQcXtavHOt+ybzJyw9fTnc+C3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bl/ZXsP8P1HlFENfJ7sRJ0ZlxFEkGhP01qDOmI90ws9d7FNzHj+m9StEhWTe6EIUm0EJGO4S/fcPpZYV4tb7ZrgdVtOhrw9eiZrYcU8fIGOqj/cY7YHmr0vY0WZPaBgvw4HJbIXy+iBA13msfMRWb1Z5KdhkS8NmF7KY/SRwxac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gyMFXEec; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42862C4CED2;
	Sat, 11 Jan 2025 07:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736579624;
	bh=tjOQooaPMspwaRUEYfQcXtavHOt+ybzJyw9fTnc+C3w=;
	h=From:To:Cc:Subject:Date:From;
	b=gyMFXEec7+RFPryObAhSPh7hTfy03yiwLbypUuZIxDQLI9in+cgYT8TGoynfMLluh
	 S2uA6XvV1DU64x55FCDHwAe/E8ilwCNGwMMTGBRFxVIz+4PfprDzfATl04oxvB8QwN
	 LxO9r456oPlWzT1mINQcBpkJiD5Yq3WSwf/Il8RIvA3K38lKV9qTDR0gqoo0zSGZoG
	 b6ryGO5iBnG+thTWfHL86GMTw2mWXLS4IDIFoFqiLFvmQnqWfOyOlnTN8wQVB812tO
	 4n4zy6AG5nqY0dTOnMOA/axrUeSRVLPgzRatrxhJhikV4tHbtCwlvoQdb1GeCWKZOE
	 kPOQrRik9pPTQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	intel-wired-lan@lists.osuosl.org
Subject: [PATCH net-next] eth: iavf: extend the netdev_lock usage
Date: Fri, 10 Jan 2025 23:13:39 -0800
Message-ID: <20250111071339.3709071-1-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iavf uses the netdev->lock already to protect shapers.
In an upcoming series we'll try to protect NAPI instances
with netdev->lock.

We need to modify the protection a bit. All NAPI related
calls in the driver need to be consistently under the lock.
This will allow us to easily switch to a "we already hold
the lock" NAPI API later.

register_netdevice(), OTOH, must not be called under
the netdev_lock() as we do not intend to have an
"already locked" version of this call.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Could someone with iavf-capable HW give this a quick whirl?
It if works for basic traffic test and up/down - it'd be great
if we could take it directly to net-next.

CC: anthony.l.nguyen@intel.com
CC: przemyslaw.kitszel@intel.com
CC: intel-wired-lan@lists.osuosl.org
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 53 +++++++++++++++++----
 1 file changed, 45 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index a9e54866ae6b..7740f446c73f 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1968,6 +1968,7 @@ static int iavf_reinit_interrupt_scheme(struct iavf_adapter *adapter, bool runni
 static void iavf_finish_config(struct work_struct *work)
 {
 	struct iavf_adapter *adapter;
+	bool netdev_released = false;
 	int pairs, err;
 
 	adapter = container_of(work, struct iavf_adapter, finish_config);
@@ -1988,7 +1989,16 @@ static void iavf_finish_config(struct work_struct *work)
 
 	switch (adapter->state) {
 	case __IAVF_DOWN:
+		/* Set the real number of queues when reset occurs while
+		 * state == __IAVF_DOWN
+		 */
+		pairs = adapter->num_active_queues;
+		netif_set_real_num_rx_queues(adapter->netdev, pairs);
+		netif_set_real_num_tx_queues(adapter->netdev, pairs);
+
 		if (adapter->netdev->reg_state != NETREG_REGISTERED) {
+			mutex_unlock(&adapter->netdev->lock);
+			netdev_released = true;
 			err = register_netdevice(adapter->netdev);
 			if (err) {
 				dev_err(&adapter->pdev->dev, "Unable to register netdev (%d)\n",
@@ -2003,11 +2013,7 @@ static void iavf_finish_config(struct work_struct *work)
 				goto out;
 			}
 		}
-
-		/* Set the real number of queues when reset occurs while
-		 * state == __IAVF_DOWN
-		 */
-		fallthrough;
+		break;
 	case __IAVF_RUNNING:
 		pairs = adapter->num_active_queues;
 		netif_set_real_num_rx_queues(adapter->netdev, pairs);
@@ -2020,7 +2026,8 @@ static void iavf_finish_config(struct work_struct *work)
 
 out:
 	mutex_unlock(&adapter->crit_lock);
-	mutex_unlock(&adapter->netdev->lock);
+	if (!netdev_released)
+		mutex_unlock(&adapter->netdev->lock);
 	rtnl_unlock();
 }
 
@@ -2713,12 +2720,16 @@ static void iavf_watchdog_task(struct work_struct *work)
 	struct iavf_adapter *adapter = container_of(work,
 						    struct iavf_adapter,
 						    watchdog_task.work);
+	struct net_device *netdev = adapter->netdev;
 	struct iavf_hw *hw = &adapter->hw;
 	u32 reg_val;
 
+	mutex_lock(&netdev->lock);
 	if (!mutex_trylock(&adapter->crit_lock)) {
-		if (adapter->state == __IAVF_REMOVE)
+		if (adapter->state == __IAVF_REMOVE) {
+			mutex_unlock(&netdev->lock);
 			return;
+		}
 
 		goto restart_watchdog;
 	}
@@ -2730,30 +2741,35 @@ static void iavf_watchdog_task(struct work_struct *work)
 	case __IAVF_STARTUP:
 		iavf_startup(adapter);
 		mutex_unlock(&adapter->crit_lock);
+		mutex_unlock(&netdev->lock);
 		queue_delayed_work(adapter->wq, &adapter->watchdog_task,
 				   msecs_to_jiffies(30));
 		return;
 	case __IAVF_INIT_VERSION_CHECK:
 		iavf_init_version_check(adapter);
 		mutex_unlock(&adapter->crit_lock);
+		mutex_unlock(&netdev->lock);
 		queue_delayed_work(adapter->wq, &adapter->watchdog_task,
 				   msecs_to_jiffies(30));
 		return;
 	case __IAVF_INIT_GET_RESOURCES:
 		iavf_init_get_resources(adapter);
 		mutex_unlock(&adapter->crit_lock);
+		mutex_unlock(&netdev->lock);
 		queue_delayed_work(adapter->wq, &adapter->watchdog_task,
 				   msecs_to_jiffies(1));
 		return;
 	case __IAVF_INIT_EXTENDED_CAPS:
 		iavf_init_process_extended_caps(adapter);
 		mutex_unlock(&adapter->crit_lock);
+		mutex_unlock(&netdev->lock);
 		queue_delayed_work(adapter->wq, &adapter->watchdog_task,
 				   msecs_to_jiffies(1));
 		return;
 	case __IAVF_INIT_CONFIG_ADAPTER:
 		iavf_init_config_adapter(adapter);
 		mutex_unlock(&adapter->crit_lock);
+		mutex_unlock(&netdev->lock);
 		queue_delayed_work(adapter->wq, &adapter->watchdog_task,
 				   msecs_to_jiffies(1));
 		return;
@@ -2765,6 +2781,7 @@ static void iavf_watchdog_task(struct work_struct *work)
 			 * as it can loop forever
 			 */
 			mutex_unlock(&adapter->crit_lock);
+			mutex_unlock(&netdev->lock);
 			return;
 		}
 		if (++adapter->aq_wait_count > IAVF_AQ_MAX_ERR) {
@@ -2773,6 +2790,7 @@ static void iavf_watchdog_task(struct work_struct *work)
 			adapter->flags |= IAVF_FLAG_PF_COMMS_FAILED;
 			iavf_shutdown_adminq(hw);
 			mutex_unlock(&adapter->crit_lock);
+			mutex_unlock(&netdev->lock);
 			queue_delayed_work(adapter->wq,
 					   &adapter->watchdog_task, (5 * HZ));
 			return;
@@ -2780,6 +2798,7 @@ static void iavf_watchdog_task(struct work_struct *work)
 		/* Try again from failed step*/
 		iavf_change_state(adapter, adapter->last_state);
 		mutex_unlock(&adapter->crit_lock);
+		mutex_unlock(&netdev->lock);
 		queue_delayed_work(adapter->wq, &adapter->watchdog_task, HZ);
 		return;
 	case __IAVF_COMM_FAILED:
@@ -2792,6 +2811,7 @@ static void iavf_watchdog_task(struct work_struct *work)
 			iavf_change_state(adapter, __IAVF_INIT_FAILED);
 			adapter->flags &= ~IAVF_FLAG_PF_COMMS_FAILED;
 			mutex_unlock(&adapter->crit_lock);
+			mutex_unlock(&netdev->lock);
 			return;
 		}
 		reg_val = rd32(hw, IAVF_VFGEN_RSTAT) &
@@ -2811,12 +2831,14 @@ static void iavf_watchdog_task(struct work_struct *work)
 		adapter->aq_required = 0;
 		adapter->current_op = VIRTCHNL_OP_UNKNOWN;
 		mutex_unlock(&adapter->crit_lock);
+		mutex_unlock(&netdev->lock);
 		queue_delayed_work(adapter->wq,
 				   &adapter->watchdog_task,
 				   msecs_to_jiffies(10));
 		return;
 	case __IAVF_RESETTING:
 		mutex_unlock(&adapter->crit_lock);
+		mutex_unlock(&netdev->lock);
 		queue_delayed_work(adapter->wq, &adapter->watchdog_task,
 				   HZ * 2);
 		return;
@@ -2847,6 +2869,7 @@ static void iavf_watchdog_task(struct work_struct *work)
 	case __IAVF_REMOVE:
 	default:
 		mutex_unlock(&adapter->crit_lock);
+		mutex_unlock(&netdev->lock);
 		return;
 	}
 
@@ -2858,12 +2881,14 @@ static void iavf_watchdog_task(struct work_struct *work)
 		dev_err(&adapter->pdev->dev, "Hardware reset detected\n");
 		iavf_schedule_reset(adapter, IAVF_FLAG_RESET_PENDING);
 		mutex_unlock(&adapter->crit_lock);
+		mutex_unlock(&netdev->lock);
 		queue_delayed_work(adapter->wq,
 				   &adapter->watchdog_task, HZ * 2);
 		return;
 	}
 
 	mutex_unlock(&adapter->crit_lock);
+	mutex_unlock(&netdev->lock);
 restart_watchdog:
 	if (adapter->state >= __IAVF_DOWN)
 		queue_work(adapter->wq, &adapter->adminq_task);
@@ -4340,14 +4365,17 @@ static int iavf_open(struct net_device *netdev)
 		return -EIO;
 	}
 
+	mutex_lock(&netdev->lock);
 	while (!mutex_trylock(&adapter->crit_lock)) {
 		/* If we are in __IAVF_INIT_CONFIG_ADAPTER state the crit_lock
 		 * is already taken and iavf_open is called from an upper
 		 * device's notifier reacting on NETDEV_REGISTER event.
 		 * We have to leave here to avoid dead lock.
 		 */
-		if (adapter->state == __IAVF_INIT_CONFIG_ADAPTER)
+		if (adapter->state == __IAVF_INIT_CONFIG_ADAPTER) {
+			mutex_unlock(&netdev->lock);
 			return -EBUSY;
+		}
 
 		usleep_range(500, 1000);
 	}
@@ -4396,6 +4424,7 @@ static int iavf_open(struct net_device *netdev)
 	iavf_irq_enable(adapter, true);
 
 	mutex_unlock(&adapter->crit_lock);
+	mutex_unlock(&netdev->lock);
 
 	return 0;
 
@@ -4408,6 +4437,7 @@ static int iavf_open(struct net_device *netdev)
 	iavf_free_all_tx_resources(adapter);
 err_unlock:
 	mutex_unlock(&adapter->crit_lock);
+	mutex_unlock(&netdev->lock);
 
 	return err;
 }
@@ -4429,10 +4459,12 @@ static int iavf_close(struct net_device *netdev)
 	u64 aq_to_restore;
 	int status;
 
+	mutex_lock(&netdev->lock);
 	mutex_lock(&adapter->crit_lock);
 
 	if (adapter->state <= __IAVF_DOWN_PENDING) {
 		mutex_unlock(&adapter->crit_lock);
+		mutex_unlock(&netdev->lock);
 		return 0;
 	}
 
@@ -4466,6 +4498,7 @@ static int iavf_close(struct net_device *netdev)
 	iavf_free_traffic_irqs(adapter);
 
 	mutex_unlock(&adapter->crit_lock);
+	mutex_unlock(&netdev->lock);
 
 	/* We explicitly don't free resources here because the hardware is
 	 * still active and can DMA into memory. Resources are cleared in
@@ -5342,6 +5375,7 @@ static int iavf_suspend(struct device *dev_d)
 
 	netif_device_detach(netdev);
 
+	mutex_lock(&netdev->lock);
 	mutex_lock(&adapter->crit_lock);
 
 	if (netif_running(netdev)) {
@@ -5353,6 +5387,7 @@ static int iavf_suspend(struct device *dev_d)
 	iavf_reset_interrupt_capability(adapter);
 
 	mutex_unlock(&adapter->crit_lock);
+	mutex_unlock(&netdev->lock);
 
 	return 0;
 }
@@ -5451,6 +5486,7 @@ static void iavf_remove(struct pci_dev *pdev)
 	if (netdev->reg_state == NETREG_REGISTERED)
 		unregister_netdev(netdev);
 
+	mutex_lock(&netdev->lock);
 	mutex_lock(&adapter->crit_lock);
 	dev_info(&adapter->pdev->dev, "Removing device\n");
 	iavf_change_state(adapter, __IAVF_REMOVE);
@@ -5487,6 +5523,7 @@ static void iavf_remove(struct pci_dev *pdev)
 	mutex_destroy(&hw->aq.asq_mutex);
 	mutex_unlock(&adapter->crit_lock);
 	mutex_destroy(&adapter->crit_lock);
+	mutex_unlock(&netdev->lock);
 
 	iounmap(hw->hw_addr);
 	pci_release_regions(pdev);
-- 
2.47.1


