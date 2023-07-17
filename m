Return-Path: <netdev+bounces-18380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC57B756B1A
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 19:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92D592812D1
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 17:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32ECC134;
	Mon, 17 Jul 2023 17:58:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68D9C130
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 17:58:19 +0000 (UTC)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66653E52
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 10:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689616698; x=1721152698;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pgmFeS7IdJay19qYISQrlZyxTIZckd2AdC0d32icpn8=;
  b=Pwl7Pb/WhDg7v8jLQ7ua5cv/wU/ve0YoQj4tuedsqBvSNV9+KeWBBfdi
   WTjUuvJVDQUe5PqKPU0/bTW3CeLi5fRE9ZWCvU8URbGaQqTE3YNfNt2EZ
   5+EDNZC9OmFouBPy02HGKiJkGxVCUiFIenhzgOv7O2hIL0pbl9ATPFh0H
   LgxHyupWm1BViFjneuKG92GntuLBEFyfta2eYhSnCyT2/DyH33rddy47u
   +JzZDh1BH1MVph4IUxQpTalQrEis5rg4SUHrXUZRvy50W0CyNQ48f2FWL
   tw8RwX4LWABBiIVICmbURm/D/rjI6XLb3t1cYqEVEp/ePy5DjqKQ/5vfo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="432172673"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="432172673"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 10:58:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="723294566"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="723294566"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga002.jf.intel.com with ESMTP; 17 Jul 2023 10:57:59 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Marcin Szycik <marcin.szycik@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	ivecera@redhat.com,
	sassmann@kpanic.de,
	Dawid Wesierski <dawidx.wesierski@intel.com>,
	Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>,
	Kamil Maziarz <kamil.maziarz@intel.com>,
	Mateusz Palczewski <mateusz.palczewski@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 4/8] iavf: Wait for reset in callbacks which trigger it
Date: Mon, 17 Jul 2023 10:52:01 -0700
Message-Id: <20230717175205.3217774-5-anthony.l.nguyen@intel.com>
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

From: Marcin Szycik <marcin.szycik@linux.intel.com>

There was a fail when trying to add the interface to bonding
right after changing the MTU on the interface. It was caused
by bonding interface unable to open the interface due to
interface being in __RESETTING state because of MTU change.

Add new reset_waitqueue to indicate that reset has finished.

Add waiting for reset to finish in callbacks which trigger hw reset:
iavf_set_priv_flags(), iavf_change_mtu() and iavf_set_ringparam().
We use a 5000ms timeout period because on Hyper-V based systems,
this operation takes around 3000-4000ms. In normal circumstances,
it doesn't take more than 500ms to complete.

Add a function iavf_wait_for_reset() to reuse waiting for reset code and
use it also in iavf_set_channels(), which already waits for reset.
We don't use error handling in iavf_set_channels() as this could
cause the device to be in incorrect state if the reset was scheduled
but hit timeout or the waitng function was interrupted by a signal.

Fixes: 4e5e6b5d9d13 ("iavf: Fix return of set the new channel count")
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Co-developed-by: Dawid Wesierski <dawidx.wesierski@intel.com>
Signed-off-by: Dawid Wesierski <dawidx.wesierski@intel.com>
Signed-off-by: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
Signed-off-by: Kamil Maziarz <kamil.maziarz@intel.com>
Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf.h        |  2 +
 .../net/ethernet/intel/iavf/iavf_ethtool.c    | 31 ++++++-----
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 51 ++++++++++++++++++-
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   |  1 +
 4 files changed, 68 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index f80f2735e688..a5cab19eb6a8 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -257,6 +257,7 @@ struct iavf_adapter {
 	struct work_struct adminq_task;
 	struct delayed_work client_task;
 	wait_queue_head_t down_waitqueue;
+	wait_queue_head_t reset_waitqueue;
 	wait_queue_head_t vc_waitqueue;
 	struct iavf_q_vector *q_vectors;
 	struct list_head vlan_filter_list;
@@ -582,4 +583,5 @@ void iavf_add_adv_rss_cfg(struct iavf_adapter *adapter);
 void iavf_del_adv_rss_cfg(struct iavf_adapter *adapter);
 struct iavf_mac_filter *iavf_add_filter(struct iavf_adapter *adapter,
 					const u8 *macaddr);
+int iavf_wait_for_reset(struct iavf_adapter *adapter);
 #endif /* _IAVF_H_ */
diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index 92443f8e9fbd..b7141c2a941d 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -484,6 +484,7 @@ static int iavf_set_priv_flags(struct net_device *netdev, u32 flags)
 {
 	struct iavf_adapter *adapter = netdev_priv(netdev);
 	u32 orig_flags, new_flags, changed_flags;
+	int ret = 0;
 	u32 i;
 
 	orig_flags = READ_ONCE(adapter->flags);
@@ -533,10 +534,13 @@ static int iavf_set_priv_flags(struct net_device *netdev, u32 flags)
 		if (netif_running(netdev)) {
 			adapter->flags |= IAVF_FLAG_RESET_NEEDED;
 			queue_work(adapter->wq, &adapter->reset_task);
+			ret = iavf_wait_for_reset(adapter);
+			if (ret)
+				netdev_warn(netdev, "Changing private flags timeout or interrupted waiting for reset");
 		}
 	}
 
-	return 0;
+	return ret;
 }
 
 /**
@@ -627,6 +631,7 @@ static int iavf_set_ringparam(struct net_device *netdev,
 {
 	struct iavf_adapter *adapter = netdev_priv(netdev);
 	u32 new_rx_count, new_tx_count;
+	int ret = 0;
 
 	if ((ring->rx_mini_pending) || (ring->rx_jumbo_pending))
 		return -EINVAL;
@@ -673,9 +678,12 @@ static int iavf_set_ringparam(struct net_device *netdev,
 	if (netif_running(netdev)) {
 		adapter->flags |= IAVF_FLAG_RESET_NEEDED;
 		queue_work(adapter->wq, &adapter->reset_task);
+		ret = iavf_wait_for_reset(adapter);
+		if (ret)
+			netdev_warn(netdev, "Changing ring parameters timeout or interrupted waiting for reset");
 	}
 
-	return 0;
+	return ret;
 }
 
 /**
@@ -1830,7 +1838,7 @@ static int iavf_set_channels(struct net_device *netdev,
 {
 	struct iavf_adapter *adapter = netdev_priv(netdev);
 	u32 num_req = ch->combined_count;
-	int i;
+	int ret = 0;
 
 	if ((adapter->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_ADQ) &&
 	    adapter->num_tc) {
@@ -1854,20 +1862,11 @@ static int iavf_set_channels(struct net_device *netdev,
 	adapter->flags |= IAVF_FLAG_REINIT_ITR_NEEDED;
 	iavf_schedule_reset(adapter);
 
-	/* wait for the reset is done */
-	for (i = 0; i < IAVF_RESET_WAIT_COMPLETE_COUNT; i++) {
-		msleep(IAVF_RESET_WAIT_MS);
-		if (adapter->flags & IAVF_FLAG_RESET_PENDING)
-			continue;
-		break;
-	}
-	if (i == IAVF_RESET_WAIT_COMPLETE_COUNT) {
-		adapter->flags &= ~IAVF_FLAG_REINIT_ITR_NEEDED;
-		adapter->num_req_queues = 0;
-		return -EOPNOTSUPP;
-	}
+	ret = iavf_wait_for_reset(adapter);
+	if (ret)
+		netdev_warn(netdev, "Changing channel count timeout or interrupted waiting for reset");
 
-	return 0;
+	return ret;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 058e19c6f94a..b89933aa5bfe 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -166,6 +166,45 @@ static struct iavf_adapter *iavf_pdev_to_adapter(struct pci_dev *pdev)
 	return netdev_priv(pci_get_drvdata(pdev));
 }
 
+/**
+ * iavf_is_reset_in_progress - Check if a reset is in progress
+ * @adapter: board private structure
+ */
+static bool iavf_is_reset_in_progress(struct iavf_adapter *adapter)
+{
+	if (adapter->state == __IAVF_RESETTING ||
+	    adapter->flags & (IAVF_FLAG_RESET_PENDING |
+			      IAVF_FLAG_RESET_NEEDED))
+		return true;
+
+	return false;
+}
+
+/**
+ * iavf_wait_for_reset - Wait for reset to finish.
+ * @adapter: board private structure
+ *
+ * Returns 0 if reset finished successfully, negative on timeout or interrupt.
+ */
+int iavf_wait_for_reset(struct iavf_adapter *adapter)
+{
+	int ret = wait_event_interruptible_timeout(adapter->reset_waitqueue,
+					!iavf_is_reset_in_progress(adapter),
+					msecs_to_jiffies(5000));
+
+	/* If ret < 0 then it means wait was interrupted.
+	 * If ret == 0 then it means we got a timeout while waiting
+	 * for reset to finish.
+	 * If ret > 0 it means reset has finished.
+	 */
+	if (ret > 0)
+		return 0;
+	else if (ret < 0)
+		return -EINTR;
+	else
+		return -EBUSY;
+}
+
 /**
  * iavf_allocate_dma_mem_d - OS specific memory alloc for shared code
  * @hw:   pointer to the HW structure
@@ -3149,6 +3188,7 @@ static void iavf_reset_task(struct work_struct *work)
 
 	adapter->flags &= ~IAVF_FLAG_REINIT_ITR_NEEDED;
 
+	wake_up(&adapter->reset_waitqueue);
 	mutex_unlock(&adapter->client_lock);
 	mutex_unlock(&adapter->crit_lock);
 
@@ -4313,6 +4353,7 @@ static int iavf_close(struct net_device *netdev)
 static int iavf_change_mtu(struct net_device *netdev, int new_mtu)
 {
 	struct iavf_adapter *adapter = netdev_priv(netdev);
+	int ret = 0;
 
 	netdev_dbg(netdev, "changing MTU from %d to %d\n",
 		   netdev->mtu, new_mtu);
@@ -4325,9 +4366,14 @@ static int iavf_change_mtu(struct net_device *netdev, int new_mtu)
 	if (netif_running(netdev)) {
 		adapter->flags |= IAVF_FLAG_RESET_NEEDED;
 		queue_work(adapter->wq, &adapter->reset_task);
+		ret = iavf_wait_for_reset(adapter);
+		if (ret < 0)
+			netdev_warn(netdev, "MTU change interrupted waiting for reset");
+		else if (ret)
+			netdev_warn(netdev, "MTU change timed out waiting for reset");
 	}
 
-	return 0;
+	return ret;
 }
 
 #define NETIF_VLAN_OFFLOAD_FEATURES	(NETIF_F_HW_VLAN_CTAG_RX | \
@@ -4928,6 +4974,9 @@ static int iavf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* Setup the wait queue for indicating transition to down status */
 	init_waitqueue_head(&adapter->down_waitqueue);
 
+	/* Setup the wait queue for indicating transition to running state */
+	init_waitqueue_head(&adapter->reset_waitqueue);
+
 	/* Setup the wait queue for indicating virtchannel events */
 	init_waitqueue_head(&adapter->vc_waitqueue);
 
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 7c0578b5457b..1bab896aaf40 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -2285,6 +2285,7 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 	case VIRTCHNL_OP_ENABLE_QUEUES:
 		/* enable transmits */
 		iavf_irq_enable(adapter, true);
+		wake_up(&adapter->reset_waitqueue);
 		adapter->flags &= ~IAVF_FLAG_QUEUES_DISABLED;
 		break;
 	case VIRTCHNL_OP_DISABLE_QUEUES:
-- 
2.38.1


