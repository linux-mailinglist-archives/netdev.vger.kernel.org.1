Return-Path: <netdev+bounces-18382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEA4756B20
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 20:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE7E91C20854
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 18:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12823C15F;
	Mon, 17 Jul 2023 17:58:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08445C13A
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 17:58:21 +0000 (UTC)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D8599
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 10:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689616699; x=1721152699;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QfSOshIC7RabHDTzn9nC3vNN+3yDbpg9Brlqmxtuli8=;
  b=FBC9C2GkK3912BdjEUw7AtZ8n/8BcZLRiA3Ea+udNcJZK61LzRSVRsGb
   2JvEdDVM6MzeCnh+sISeiiFu1bl2bRUA0c1ngjUSX93D94wpe+LQp3jgA
   J/ox3KNfhpmP5BD+FWOXXVifGxHr7PV5mOPYMLRKNUTujn5u/kzod7vpV
   M6nZMcRKp0l21dfu88Q3mH7i2a1+xPUQqqzYqFgzJOubhCdUHO3jvVEZE
   0vLLKMqC1YCMT4UAZvGaEKumOFLGBB5Oc6870k/8SxCacVL2GCW1+wIqv
   E+EG8iTktdW101hdWm9lmPeQHWD9Tcl+Ylc4XEulHhMYE8pt61yiUg5At
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="432172707"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="432172707"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 10:58:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="723294589"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="723294589"
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
Subject: [PATCH net 8/8] iavf: fix reset task race with iavf_remove()
Date: Mon, 17 Jul 2023 10:52:05 -0700
Message-Id: <20230717175205.3217774-9-anthony.l.nguyen@intel.com>
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

The reset task is currently scheduled from the watchdog or adminq tasks.
First, all direct calls to schedule the reset task are replaced with the
iavf_schedule_reset(), which is modified to accept the flag showing the
type of reset.

To prevent the reset task from starting once iavf_remove() starts, we need
to check the __IAVF_IN_REMOVE_TASK bit before we schedule it. This is now
easily added to iavf_schedule_reset().

Finally, remove the check for IAVF_FLAG_RESET_NEEDED in the watchdog task.
It is redundant since all callers who set the flag immediately schedules
the reset task.

Fixes: 3ccd54ef44eb ("iavf: Fix init state closure on remove")
Fixes: 14756b2ae265 ("iavf: Fix __IAVF_RESETTING state usage")
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf.h        |  2 +-
 .../net/ethernet/intel/iavf/iavf_ethtool.c    |  8 ++---
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 32 +++++++------------
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   |  3 +-
 4 files changed, 16 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index bf5e3c8e97e0..8cbdebc5b698 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -520,7 +520,7 @@ int iavf_up(struct iavf_adapter *adapter);
 void iavf_down(struct iavf_adapter *adapter);
 int iavf_process_config(struct iavf_adapter *adapter);
 int iavf_parse_vf_resource_msg(struct iavf_adapter *adapter);
-void iavf_schedule_reset(struct iavf_adapter *adapter);
+void iavf_schedule_reset(struct iavf_adapter *adapter, u64 flags);
 void iavf_schedule_request_stats(struct iavf_adapter *adapter);
 void iavf_schedule_finish_config(struct iavf_adapter *adapter);
 void iavf_reset(struct iavf_adapter *adapter);
diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index b7141c2a941d..2f47cfa7f06e 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -532,8 +532,7 @@ static int iavf_set_priv_flags(struct net_device *netdev, u32 flags)
 	/* issue a reset to force legacy-rx change to take effect */
 	if (changed_flags & IAVF_FLAG_LEGACY_RX) {
 		if (netif_running(netdev)) {
-			adapter->flags |= IAVF_FLAG_RESET_NEEDED;
-			queue_work(adapter->wq, &adapter->reset_task);
+			iavf_schedule_reset(adapter, IAVF_FLAG_RESET_NEEDED);
 			ret = iavf_wait_for_reset(adapter);
 			if (ret)
 				netdev_warn(netdev, "Changing private flags timeout or interrupted waiting for reset");
@@ -676,8 +675,7 @@ static int iavf_set_ringparam(struct net_device *netdev,
 	}
 
 	if (netif_running(netdev)) {
-		adapter->flags |= IAVF_FLAG_RESET_NEEDED;
-		queue_work(adapter->wq, &adapter->reset_task);
+		iavf_schedule_reset(adapter, IAVF_FLAG_RESET_NEEDED);
 		ret = iavf_wait_for_reset(adapter);
 		if (ret)
 			netdev_warn(netdev, "Changing ring parameters timeout or interrupted waiting for reset");
@@ -1860,7 +1858,7 @@ static int iavf_set_channels(struct net_device *netdev,
 
 	adapter->num_req_queues = num_req;
 	adapter->flags |= IAVF_FLAG_REINIT_ITR_NEEDED;
-	iavf_schedule_reset(adapter);
+	iavf_schedule_reset(adapter, IAVF_FLAG_RESET_NEEDED);
 
 	ret = iavf_wait_for_reset(adapter);
 	if (ret)
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 2a2ae3c4337b..3a88d413ddee 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -301,12 +301,14 @@ static int iavf_lock_timeout(struct mutex *lock, unsigned int msecs)
 /**
  * iavf_schedule_reset - Set the flags and schedule a reset event
  * @adapter: board private structure
+ * @flags: IAVF_FLAG_RESET_PENDING or IAVF_FLAG_RESET_NEEDED
  **/
-void iavf_schedule_reset(struct iavf_adapter *adapter)
+void iavf_schedule_reset(struct iavf_adapter *adapter, u64 flags)
 {
-	if (!(adapter->flags &
-	      (IAVF_FLAG_RESET_PENDING | IAVF_FLAG_RESET_NEEDED))) {
-		adapter->flags |= IAVF_FLAG_RESET_NEEDED;
+	if (!test_bit(__IAVF_IN_REMOVE_TASK, &adapter->crit_section) &&
+	    !(adapter->flags &
+	    (IAVF_FLAG_RESET_PENDING | IAVF_FLAG_RESET_NEEDED))) {
+		adapter->flags |= flags;
 		queue_work(adapter->wq, &adapter->reset_task);
 	}
 }
@@ -334,7 +336,7 @@ static void iavf_tx_timeout(struct net_device *netdev, unsigned int txqueue)
 	struct iavf_adapter *adapter = netdev_priv(netdev);
 
 	adapter->tx_timeout_count++;
-	iavf_schedule_reset(adapter);
+	iavf_schedule_reset(adapter, IAVF_FLAG_RESET_NEEDED);
 }
 
 /**
@@ -2478,7 +2480,7 @@ int iavf_parse_vf_resource_msg(struct iavf_adapter *adapter)
 			adapter->vsi_res->num_queue_pairs);
 		adapter->flags |= IAVF_FLAG_REINIT_MSIX_NEEDED;
 		adapter->num_req_queues = adapter->vsi_res->num_queue_pairs;
-		iavf_schedule_reset(adapter);
+		iavf_schedule_reset(adapter, IAVF_FLAG_RESET_NEEDED);
 
 		return -EAGAIN;
 	}
@@ -2775,14 +2777,6 @@ static void iavf_watchdog_task(struct work_struct *work)
 	if (adapter->flags & IAVF_FLAG_PF_COMMS_FAILED)
 		iavf_change_state(adapter, __IAVF_COMM_FAILED);
 
-	if (adapter->flags & IAVF_FLAG_RESET_NEEDED) {
-		adapter->aq_required = 0;
-		adapter->current_op = VIRTCHNL_OP_UNKNOWN;
-		mutex_unlock(&adapter->crit_lock);
-		queue_work(adapter->wq, &adapter->reset_task);
-		return;
-	}
-
 	switch (adapter->state) {
 	case __IAVF_STARTUP:
 		iavf_startup(adapter);
@@ -2910,11 +2904,10 @@ static void iavf_watchdog_task(struct work_struct *work)
 	/* check for hw reset */
 	reg_val = rd32(hw, IAVF_VF_ARQLEN1) & IAVF_VF_ARQLEN1_ARQENABLE_MASK;
 	if (!reg_val) {
-		adapter->flags |= IAVF_FLAG_RESET_PENDING;
 		adapter->aq_required = 0;
 		adapter->current_op = VIRTCHNL_OP_UNKNOWN;
 		dev_err(&adapter->pdev->dev, "Hardware reset detected\n");
-		queue_work(adapter->wq, &adapter->reset_task);
+		iavf_schedule_reset(adapter, IAVF_FLAG_RESET_PENDING);
 		mutex_unlock(&adapter->crit_lock);
 		queue_delayed_work(adapter->wq,
 				   &adapter->watchdog_task, HZ * 2);
@@ -3288,9 +3281,7 @@ static void iavf_adminq_task(struct work_struct *work)
 	} while (pending);
 	mutex_unlock(&adapter->crit_lock);
 
-	if ((adapter->flags &
-	     (IAVF_FLAG_RESET_PENDING | IAVF_FLAG_RESET_NEEDED)) ||
-	    adapter->state == __IAVF_RESETTING)
+	if (iavf_is_reset_in_progress(adapter))
 		goto freedom;
 
 	/* check for error indications */
@@ -4387,8 +4378,7 @@ static int iavf_change_mtu(struct net_device *netdev, int new_mtu)
 	}
 
 	if (netif_running(netdev)) {
-		adapter->flags |= IAVF_FLAG_RESET_NEEDED;
-		queue_work(adapter->wq, &adapter->reset_task);
+		iavf_schedule_reset(adapter, IAVF_FLAG_RESET_NEEDED);
 		ret = iavf_wait_for_reset(adapter);
 		if (ret < 0)
 			netdev_warn(netdev, "MTU change interrupted waiting for reset");
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 073ac29ed84c..be3c007ce90a 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -1961,9 +1961,8 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 		case VIRTCHNL_EVENT_RESET_IMPENDING:
 			dev_info(&adapter->pdev->dev, "Reset indication received from the PF\n");
 			if (!(adapter->flags & IAVF_FLAG_RESET_PENDING)) {
-				adapter->flags |= IAVF_FLAG_RESET_PENDING;
 				dev_info(&adapter->pdev->dev, "Scheduling reset task\n");
-				queue_work(adapter->wq, &adapter->reset_task);
+				iavf_schedule_reset(adapter, IAVF_FLAG_RESET_PENDING);
 			}
 			break;
 		default:
-- 
2.38.1


