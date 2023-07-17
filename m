Return-Path: <netdev+bounces-18383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C4D756B21
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 20:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59B13281216
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 18:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A0AC2CE;
	Mon, 17 Jul 2023 17:58:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476BAC2CB
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 17:58:21 +0000 (UTC)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB6E8E
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 10:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689616699; x=1721152699;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GEoNRHpLr5bZdr2X/8hL0xtxrKVNTUJHV0m/HFqJBEY=;
  b=eZj5yBgpgNzrzWcOzT3EO5yH5rcR5crd5l04/LcpE/f2ozHXLs74npQ7
   zEFFTI4kQELHFLAb7wFWx6aCljum7Bb/YbPNC8UpviTZM4c+hhyq6wCWu
   TG6+M25842d7kXHt2y+nN3A84eU4l0etSEVDCoUCbKcSqSYjCIeLvzuLd
   C8CsiJNm+LNzIIL44tvGL5xCO9S1hEvWLZECc6zCXbdbYKSo1zfetPOiS
   SDBfNQ2+5sIY0UDsVq62FuJasj04KxFIO+/cRKMUHIP4erYCax4K5DZeH
   j2Q3KGLawt+5JjUWWSBEp6YH6dS9DObJ93fkepaGlfbHSdVdyag3dXlus
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="432172695"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="432172695"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 10:58:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="723294584"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="723294584"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga002.jf.intel.com with ESMTP; 17 Jul 2023 10:58:00 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Ahmed Zaki <ahmed.zaki@intel.com>,
	anthony.l.nguyen@intel.com,
	ivecera@redhat.com,
	sassmann@kpanic.de,
	Mateusz Palczewski <mateusz.palczewski@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 7/8] iavf: fix a deadlock caused by rtnl and driver's lock circular dependencies
Date: Mon, 17 Jul 2023 10:52:04 -0700
Message-Id: <20230717175205.3217774-8-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230717175205.3217774-1-anthony.l.nguyen@intel.com>
References: <20230717175205.3217774-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Ahmed Zaki <ahmed.zaki@intel.com>

A driver's lock (crit_lock) is used to serialize all the driver's tasks.
Lockdep, however, shows a circular dependency between rtnl and
crit_lock. This happens when an ndo that already holds the rtnl requests
the driver to reset, since the reset task (in some paths) tries to grab
rtnl to either change real number of queues of update netdev features.

  [566.241851] ======================================================
  [566.241893] WARNING: possible circular locking dependency detected
  [566.241936] 6.2.14-100.fc36.x86_64+debug #1 Tainted: G           OE
  [566.241984] ------------------------------------------------------
  [566.242025] repro.sh/2604 is trying to acquire lock:
  [566.242061] ffff9280fc5ceee8 (&adapter->crit_lock){+.+.}-{3:3}, at: iavf_close+0x3c/0x240 [iavf]
  [566.242167]
               but task is already holding lock:
  [566.242209] ffffffff9976d350 (rtnl_mutex){+.+.}-{3:3}, at: iavf_remove+0x6b5/0x730 [iavf]
  [566.242300]
               which lock already depends on the new lock.

  [566.242353]
               the existing dependency chain (in reverse order) is:
  [566.242401]
               -> #1 (rtnl_mutex){+.+.}-{3:3}:
  [566.242451]        __mutex_lock+0xc1/0xbb0
  [566.242489]        iavf_init_interrupt_scheme+0x179/0x440 [iavf]
  [566.242560]        iavf_watchdog_task+0x80b/0x1400 [iavf]
  [566.242627]        process_one_work+0x2b3/0x560
  [566.242663]        worker_thread+0x4f/0x3a0
  [566.242696]        kthread+0xf2/0x120
  [566.242730]        ret_from_fork+0x29/0x50
  [566.242763]
               -> #0 (&adapter->crit_lock){+.+.}-{3:3}:
  [566.242815]        __lock_acquire+0x15ff/0x22b0
  [566.242869]        lock_acquire+0xd2/0x2c0
  [566.242901]        __mutex_lock+0xc1/0xbb0
  [566.242934]        iavf_close+0x3c/0x240 [iavf]
  [566.242997]        __dev_close_many+0xac/0x120
  [566.243036]        dev_close_many+0x8b/0x140
  [566.243071]        unregister_netdevice_many_notify+0x165/0x7c0
  [566.243116]        unregister_netdevice_queue+0xd3/0x110
  [566.243157]        iavf_remove+0x6c1/0x730 [iavf]
  [566.243217]        pci_device_remove+0x33/0xa0
  [566.243257]        device_release_driver_internal+0x1bc/0x240
  [566.243299]        pci_stop_bus_device+0x6c/0x90
  [566.243338]        pci_stop_and_remove_bus_device+0xe/0x20
  [566.243380]        pci_iov_remove_virtfn+0xd1/0x130
  [566.243417]        sriov_disable+0x34/0xe0
  [566.243448]        ice_free_vfs+0x2da/0x330 [ice]
  [566.244383]        ice_sriov_configure+0x88/0xad0 [ice]
  [566.245353]        sriov_numvfs_store+0xde/0x1d0
  [566.246156]        kernfs_fop_write_iter+0x15e/0x210
  [566.246921]        vfs_write+0x288/0x530
  [566.247671]        ksys_write+0x74/0xf0
  [566.248408]        do_syscall_64+0x58/0x80
  [566.249145]        entry_SYSCALL_64_after_hwframe+0x72/0xdc
  [566.249886]
                 other info that might help us debug this:

  [566.252014]  Possible unsafe locking scenario:

  [566.253432]        CPU0                    CPU1
  [566.254118]        ----                    ----
  [566.254800]   lock(rtnl_mutex);
  [566.255514]                                lock(&adapter->crit_lock);
  [566.256233]                                lock(rtnl_mutex);
  [566.256897]   lock(&adapter->crit_lock);
  [566.257388]
                  *** DEADLOCK ***

The deadlock can be triggered by a script that is continuously resetting
the VF adapter while doing other operations requiring RTNL, e.g:

	while :; do
		ip link set $VF up
		ethtool --set-channels $VF combined 2
		ip link set $VF down
		ip link set $VF up
		ethtool --set-channels $VF combined 4
		ip link set $VF down
	done

Any operation that triggers a reset can substitute "ethtool --set-channles"

As a fix, add a new task "finish_config" that do all the work which
needs rtnl lock. With the exception of iavf_remove(), all work that
require rtnl should be called from this task.

As for iavf_remove(), at the point where we need to call
unregister_netdevice() (and grab rtnl_lock), we make sure the finish_config
task is not running (cancel_work_sync()) to safely grab rtnl. Subsequent
finish_config work cannot restart after that since the task is guarded
by the __IAVF_IN_REMOVE_TASK bit in iavf_schedule_finish_config().

Fixes: 5ac49f3c2702 ("iavf: use mutexes for locking of critical sections")
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf.h        |   2 +
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 114 +++++++++++++-----
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   |   1 +
 3 files changed, 85 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index a5cab19eb6a8..bf5e3c8e97e0 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -255,6 +255,7 @@ struct iavf_adapter {
 	struct workqueue_struct *wq;
 	struct work_struct reset_task;
 	struct work_struct adminq_task;
+	struct work_struct finish_config;
 	struct delayed_work client_task;
 	wait_queue_head_t down_waitqueue;
 	wait_queue_head_t reset_waitqueue;
@@ -521,6 +522,7 @@ int iavf_process_config(struct iavf_adapter *adapter);
 int iavf_parse_vf_resource_msg(struct iavf_adapter *adapter);
 void iavf_schedule_reset(struct iavf_adapter *adapter);
 void iavf_schedule_request_stats(struct iavf_adapter *adapter);
+void iavf_schedule_finish_config(struct iavf_adapter *adapter);
 void iavf_reset(struct iavf_adapter *adapter);
 void iavf_set_ethtool_ops(struct net_device *netdev);
 void iavf_update_stats(struct iavf_adapter *adapter);
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 0c12a752429c..2a2ae3c4337b 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1690,10 +1690,10 @@ static int iavf_set_interrupt_capability(struct iavf_adapter *adapter)
 		adapter->msix_entries[vector].entry = vector;
 
 	err = iavf_acquire_msix_vectors(adapter, v_budget);
+	if (!err)
+		iavf_schedule_finish_config(adapter);
 
 out:
-	netif_set_real_num_rx_queues(adapter->netdev, pairs);
-	netif_set_real_num_tx_queues(adapter->netdev, pairs);
 	return err;
 }
 
@@ -1913,9 +1913,7 @@ static int iavf_init_interrupt_scheme(struct iavf_adapter *adapter)
 		goto err_alloc_queues;
 	}
 
-	rtnl_lock();
 	err = iavf_set_interrupt_capability(adapter);
-	rtnl_unlock();
 	if (err) {
 		dev_err(&adapter->pdev->dev,
 			"Unable to setup interrupt capabilities\n");
@@ -2001,6 +1999,78 @@ static int iavf_reinit_interrupt_scheme(struct iavf_adapter *adapter, bool runni
 	return err;
 }
 
+/**
+ * iavf_finish_config - do all netdev work that needs RTNL
+ * @work: our work_struct
+ *
+ * Do work that needs both RTNL and crit_lock.
+ **/
+static void iavf_finish_config(struct work_struct *work)
+{
+	struct iavf_adapter *adapter;
+	int pairs, err;
+
+	adapter = container_of(work, struct iavf_adapter, finish_config);
+
+	/* Always take RTNL first to prevent circular lock dependency */
+	rtnl_lock();
+	mutex_lock(&adapter->crit_lock);
+
+	if ((adapter->flags & IAVF_FLAG_SETUP_NETDEV_FEATURES) &&
+	    adapter->netdev_registered &&
+	    !test_bit(__IAVF_IN_REMOVE_TASK, &adapter->crit_section)) {
+		netdev_update_features(adapter->netdev);
+		adapter->flags &= ~IAVF_FLAG_SETUP_NETDEV_FEATURES;
+	}
+
+	switch (adapter->state) {
+	case __IAVF_DOWN:
+		if (!adapter->netdev_registered) {
+			err = register_netdevice(adapter->netdev);
+			if (err) {
+				dev_err(&adapter->pdev->dev, "Unable to register netdev (%d)\n",
+					err);
+
+				/* go back and try again.*/
+				iavf_free_rss(adapter);
+				iavf_free_misc_irq(adapter);
+				iavf_reset_interrupt_capability(adapter);
+				iavf_change_state(adapter,
+						  __IAVF_INIT_CONFIG_ADAPTER);
+				goto out;
+			}
+			adapter->netdev_registered = true;
+		}
+
+		/* Set the real number of queues when reset occurs while
+		 * state == __IAVF_DOWN
+		 */
+		fallthrough;
+	case __IAVF_RUNNING:
+		pairs = adapter->num_active_queues;
+		netif_set_real_num_rx_queues(adapter->netdev, pairs);
+		netif_set_real_num_tx_queues(adapter->netdev, pairs);
+		break;
+
+	default:
+		break;
+	}
+
+out:
+	mutex_unlock(&adapter->crit_lock);
+	rtnl_unlock();
+}
+
+/**
+ * iavf_schedule_finish_config - Set the flags and schedule a reset event
+ * @adapter: board private structure
+ **/
+void iavf_schedule_finish_config(struct iavf_adapter *adapter)
+{
+	if (!test_bit(__IAVF_IN_REMOVE_TASK, &adapter->crit_section))
+		queue_work(adapter->wq, &adapter->finish_config);
+}
+
 /**
  * iavf_process_aq_command - process aq_required flags
  * and sends aq command
@@ -2638,22 +2708,8 @@ static void iavf_init_config_adapter(struct iavf_adapter *adapter)
 
 	netif_carrier_off(netdev);
 	adapter->link_up = false;
-
-	/* set the semaphore to prevent any callbacks after device registration
-	 * up to time when state of driver will be set to __IAVF_DOWN
-	 */
-	rtnl_lock();
-	if (!adapter->netdev_registered) {
-		err = register_netdevice(netdev);
-		if (err) {
-			rtnl_unlock();
-			goto err_register;
-		}
-	}
-
-	adapter->netdev_registered = true;
-
 	netif_tx_stop_all_queues(netdev);
+
 	if (CLIENT_ALLOWED(adapter)) {
 		err = iavf_lan_add_device(adapter);
 		if (err)
@@ -2666,7 +2722,6 @@ static void iavf_init_config_adapter(struct iavf_adapter *adapter)
 
 	iavf_change_state(adapter, __IAVF_DOWN);
 	set_bit(__IAVF_VSI_DOWN, adapter->vsi.state);
-	rtnl_unlock();
 
 	iavf_misc_irq_enable(adapter);
 	wake_up(&adapter->down_waitqueue);
@@ -2686,10 +2741,11 @@ static void iavf_init_config_adapter(struct iavf_adapter *adapter)
 		/* request initial VLAN offload settings */
 		iavf_set_vlan_offload_features(adapter, 0, netdev->features);
 
+	iavf_schedule_finish_config(adapter);
 	return;
+
 err_mem:
 	iavf_free_rss(adapter);
-err_register:
 	iavf_free_misc_irq(adapter);
 err_sw_init:
 	iavf_reset_interrupt_capability(adapter);
@@ -2716,15 +2772,6 @@ static void iavf_watchdog_task(struct work_struct *work)
 		goto restart_watchdog;
 	}
 
-	if ((adapter->flags & IAVF_FLAG_SETUP_NETDEV_FEATURES) &&
-	    adapter->netdev_registered &&
-	    !test_bit(__IAVF_IN_REMOVE_TASK, &adapter->crit_section) &&
-	    rtnl_trylock()) {
-		netdev_update_features(adapter->netdev);
-		rtnl_unlock();
-		adapter->flags &= ~IAVF_FLAG_SETUP_NETDEV_FEATURES;
-	}
-
 	if (adapter->flags & IAVF_FLAG_PF_COMMS_FAILED)
 		iavf_change_state(adapter, __IAVF_COMM_FAILED);
 
@@ -4942,6 +4989,7 @@ static int iavf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	INIT_WORK(&adapter->reset_task, iavf_reset_task);
 	INIT_WORK(&adapter->adminq_task, iavf_adminq_task);
+	INIT_WORK(&adapter->finish_config, iavf_finish_config);
 	INIT_DELAYED_WORK(&adapter->watchdog_task, iavf_watchdog_task);
 	INIT_DELAYED_WORK(&adapter->client_task, iavf_client_task);
 	queue_delayed_work(adapter->wq, &adapter->watchdog_task,
@@ -5084,13 +5132,15 @@ static void iavf_remove(struct pci_dev *pdev)
 		usleep_range(500, 1000);
 	}
 	cancel_delayed_work_sync(&adapter->watchdog_task);
+	cancel_work_sync(&adapter->finish_config);
 
+	rtnl_lock();
 	if (adapter->netdev_registered) {
-		rtnl_lock();
 		unregister_netdevice(netdev);
 		adapter->netdev_registered = false;
-		rtnl_unlock();
 	}
+	rtnl_unlock();
+
 	if (CLIENT_ALLOWED(adapter)) {
 		err = iavf_lan_del_device(adapter);
 		if (err)
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 1bab896aaf40..073ac29ed84c 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -2237,6 +2237,7 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 
 		iavf_process_config(adapter);
 		adapter->flags |= IAVF_FLAG_SETUP_NETDEV_FEATURES;
+		iavf_schedule_finish_config(adapter);
 
 		iavf_set_queue_vlan_tag_loc(adapter);
 
-- 
2.38.1


