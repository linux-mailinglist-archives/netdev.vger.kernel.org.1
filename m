Return-Path: <netdev+bounces-25133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0261B7730BF
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 22:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0E74281590
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 20:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FF81642E;
	Mon,  7 Aug 2023 20:58:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA61C4435
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 20:58:07 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B96EE50
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 13:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691441886; x=1722977886;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=C9tSOKFviJKvtuz8r0ZDE/sFatJvKErJzZrFRcHjmTU=;
  b=Xz/n22l23XHxPpgBcyIFvpJZVIqixbDlLy6AxHuqSQVnny3rwcsl2Xzv
   p4ooBLlGupAWgUQkjtxdNC4ESQ7nCFEyrSoX762cL8zI6BLv4P4cfQOuw
   uBCDUENUs0eJenth/a4j/kmAVHgWqnVtWTzyyNySGrbK0/VidriD2Mxao
   Jm25pzv4Qdd72zL+az1lRnsHMSpCDG8wd6rxydg1UFY6z4lDbK5GiOwhK
   JRaXdHOUld9+6dkqDhpXB8m0Xus3CC6WTWd1tvFvzzodQdG1rmJsfkTC7
   QCq3yKcKbnFmvMxGzv9EIBryNfa1n1lUEymmu8bYxKLKAllcuEoZr14GJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="350952908"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="350952908"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 13:58:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="708015962"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="708015962"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga006.jf.intel.com with ESMTP; 07 Aug 2023 13:58:05 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Naama Meir <naamax.meir@linux.intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net] igc: Add lock to safeguard global Qbv variables
Date: Mon,  7 Aug 2023 13:51:29 -0700
Message-Id: <20230807205129.3129346-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>

Access to shared variables through hrtimer requires locking in order
to protect the variables because actions to write into these variables
(oper_gate_closed, admin_gate_closed, and qbv_transition) might potentially
occur simultaneously. This patch provides a locking mechanisms to avoid
such scenarios.

Fixes: 175c241288c0 ("igc: Fix TX Hang issue when QBV Gate is closed")
Suggested-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h      |  4 +++
 drivers/net/ethernet/intel/igc/igc_main.c | 34 +++++++++++++++++++++--
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 9db384f66a8e..38901d2a4680 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -195,6 +195,10 @@ struct igc_adapter {
 	u32 qbv_config_change_errors;
 	bool qbv_transition;
 	unsigned int qbv_count;
+	/* Access to oper_gate_closed, admin_gate_closed and qbv_transition
+	 * are protected by the qbv_tx_lock.
+	 */
+	spinlock_t qbv_tx_lock;
 
 	/* OS defined structs */
 	struct pci_dev *pdev;
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index bdeb36790d77..6f557e843e49 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -4801,6 +4801,7 @@ static int igc_sw_init(struct igc_adapter *adapter)
 	adapter->nfc_rule_count = 0;
 
 	spin_lock_init(&adapter->stats64_lock);
+	spin_lock_init(&adapter->qbv_tx_lock);
 	/* Assume MSI-X interrupts, will be checked during IRQ allocation */
 	adapter->flags |= IGC_FLAG_HAS_MSIX;
 
@@ -6119,15 +6120,15 @@ static int igc_tsn_enable_launchtime(struct igc_adapter *adapter,
 	return igc_tsn_offload_apply(adapter);
 }
 
-static int igc_tsn_clear_schedule(struct igc_adapter *adapter)
+static int igc_qbv_clear_schedule(struct igc_adapter *adapter)
 {
+	unsigned long flags;
 	int i;
 
 	adapter->base_time = 0;
 	adapter->cycle_time = NSEC_PER_SEC;
 	adapter->taprio_offload_enable = false;
 	adapter->qbv_config_change_errors = 0;
-	adapter->qbv_transition = false;
 	adapter->qbv_count = 0;
 
 	for (i = 0; i < adapter->num_tx_queues; i++) {
@@ -6136,10 +6137,28 @@ static int igc_tsn_clear_schedule(struct igc_adapter *adapter)
 		ring->start_time = 0;
 		ring->end_time = NSEC_PER_SEC;
 		ring->max_sdu = 0;
+	}
+
+	spin_lock_irqsave(&adapter->qbv_tx_lock, flags);
+
+	adapter->qbv_transition = false;
+
+	for (i = 0; i < adapter->num_tx_queues; i++) {
+		struct igc_ring *ring = adapter->tx_ring[i];
+
 		ring->oper_gate_closed = false;
 		ring->admin_gate_closed = false;
 	}
 
+	spin_unlock_irqrestore(&adapter->qbv_tx_lock, flags);
+
+	return 0;
+}
+
+static int igc_tsn_clear_schedule(struct igc_adapter *adapter)
+{
+	igc_qbv_clear_schedule(adapter);
+
 	return 0;
 }
 
@@ -6150,6 +6169,7 @@ static int igc_save_qbv_schedule(struct igc_adapter *adapter,
 	struct igc_hw *hw = &adapter->hw;
 	u32 start_time = 0, end_time = 0;
 	struct timespec64 now;
+	unsigned long flags;
 	size_t n;
 	int i;
 
@@ -6217,6 +6237,8 @@ static int igc_save_qbv_schedule(struct igc_adapter *adapter,
 		start_time += e->interval;
 	}
 
+	spin_lock_irqsave(&adapter->qbv_tx_lock, flags);
+
 	/* Check whether a queue gets configured.
 	 * If not, set the start and end time to be end time.
 	 */
@@ -6241,6 +6263,8 @@ static int igc_save_qbv_schedule(struct igc_adapter *adapter,
 		}
 	}
 
+	spin_unlock_irqrestore(&adapter->qbv_tx_lock, flags);
+
 	for (i = 0; i < adapter->num_tx_queues; i++) {
 		struct igc_ring *ring = adapter->tx_ring[i];
 		struct net_device *dev = adapter->netdev;
@@ -6619,8 +6643,11 @@ static enum hrtimer_restart igc_qbv_scheduling_timer(struct hrtimer *timer)
 {
 	struct igc_adapter *adapter = container_of(timer, struct igc_adapter,
 						   hrtimer);
+	unsigned long flags;
 	unsigned int i;
 
+	spin_lock_irqsave(&adapter->qbv_tx_lock, flags);
+
 	adapter->qbv_transition = true;
 	for (i = 0; i < adapter->num_tx_queues; i++) {
 		struct igc_ring *tx_ring = adapter->tx_ring[i];
@@ -6633,6 +6660,9 @@ static enum hrtimer_restart igc_qbv_scheduling_timer(struct hrtimer *timer)
 		}
 	}
 	adapter->qbv_transition = false;
+
+	spin_unlock_irqrestore(&adapter->qbv_tx_lock, flags);
+
 	return HRTIMER_NORESTART;
 }
 
-- 
2.38.1


