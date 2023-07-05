Return-Path: <netdev+bounces-15650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8C5748EE1
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 22:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA3A91C20BDF
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 20:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35BF15AE5;
	Wed,  5 Jul 2023 20:24:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C734B15AC7
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 20:24:47 +0000 (UTC)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1584F1989
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 13:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688588686; x=1720124686;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=liAJh2K6d8eJY0C1BeS/mc8bJySJrf0eYHoW2f+3z7I=;
  b=Gdz4f8UWFwDdHkFMWlI7ufY0XyIfJZcFudKlOopE1ReOjjzf/J7tXMqV
   GF+fgf1aK0evSvVyvLsVmmlCPkKCsYEaBQ7MclWM0LV7CqgxUUH46nMYD
   Mc02rYjp4cBCDPb8G0nKSO3+OE7gktGg/EOZuETU1KSIabM1HZHT5lLcy
   Atbgxhlcfho4pQZGe/mGgT1rETuk8gmohnoKCwZGNIanQdTOyXTI0Gia8
   O+aEVCTYzFJycnWTJXC+7XMHzrhz6ZMJhDEP1JSaaNGMdG9n92vKFRoBX
   saKgHQ8v8rF8447Fj8iqU++HnwpIySoe72gJqpw+UKp8NmGbmM37XoNMR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="362303228"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="362303228"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 13:24:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="809380434"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="809380434"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Jul 2023 13:24:39 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
	anthony.l.nguyen@intel.com,
	sasha.neftin@intel.com,
	richardcochran@gmail.com,
	Tan Tee Min <tee.min.tan@linux.intel.com>,
	Chwee Lin Choong <chwee.lin.choong@intel.com>,
	Naama Meir <naamax.meir@linux.intel.com>
Subject: [PATCH net 3/6] igc: Fix TX Hang issue when QBV Gate is closed
Date: Wed,  5 Jul 2023 13:19:02 -0700
Message-Id: <20230705201905.49570-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230705201905.49570-1-anthony.l.nguyen@intel.com>
References: <20230705201905.49570-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>

If a user schedules a Gate Control List (GCL) to close one of
the QBV gates while also transmitting a packet to that closed gate,
TX Hang will be happen. HW would not drop any packet when the gate
is closed and keep queuing up in HW TX FIFO until the gate is re-opened.
This patch implements the solution to drop the packet for the closed
gate.

This patch will also reset the adapter to perform SW initialization
for each 1st Gate Control List (GCL) to avoid hang.
This is due to the HW design, where changing to TSN transmit mode
requires SW initialization. Intel Discrete I225/6 transmit mode
cannot be changed when in dynamic mode according to Software User
Manual Section 7.5.2.1. Subsequent Gate Control List (GCL) operations
will proceed without a reset, as they already are in TSN Mode.

Step to reproduce:

DUT:
1) Configure GCL List with certain gate close.

BASE=$(date +%s%N)
tc qdisc replace dev $IFACE parent root handle 100 taprio \
    num_tc 4 \
    map 0 1 2 3 3 3 3 3 3 3 3 3 3 3 3 3 \
    queues 1@0 1@1 1@2 1@3 \
    base-time $BASE \
    sched-entry S 0x8 500000 \
    sched-entry S 0x4 500000 \
    flags 0x2

2) Transmit the packet to closed gate. You may use udp_tai
application to transmit UDP packet to any of the closed gate.

./udp_tai -i <interface> -P 100000 -p 90 -c 1 -t <0/1> -u 30004

Fixes: ec50a9d437f0 ("igc: Add support for taprio offloading")
Co-developed-by: Tan Tee Min <tee.min.tan@linux.intel.com>
Signed-off-by: Tan Tee Min <tee.min.tan@linux.intel.com>
Tested-by: Chwee Lin Choong <chwee.lin.choong@intel.com>
Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h      |  6 +++
 drivers/net/ethernet/intel/igc/igc_main.c | 58 +++++++++++++++++++++--
 drivers/net/ethernet/intel/igc/igc_tsn.c  | 41 ++++++++++------
 3 files changed, 87 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index aa5ceab0d371..639a50c02537 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -14,6 +14,7 @@
 #include <linux/timecounter.h>
 #include <linux/net_tstamp.h>
 #include <linux/bitfield.h>
+#include <linux/hrtimer.h>
 
 #include "igc_hw.h"
 
@@ -101,6 +102,8 @@ struct igc_ring {
 	u32 start_time;
 	u32 end_time;
 	u32 max_sdu;
+	bool oper_gate_closed;		/* Operating gate. True if the TX Queue is closed */
+	bool admin_gate_closed;		/* Future gate. True if the TX Queue will be closed */
 
 	/* CBS parameters */
 	bool cbs_enable;                /* indicates if CBS is enabled */
@@ -160,6 +163,7 @@ struct igc_adapter {
 	struct timer_list watchdog_timer;
 	struct timer_list dma_err_timer;
 	struct timer_list phy_info_timer;
+	struct hrtimer hrtimer;
 
 	u32 wol;
 	u32 en_mng_pt;
@@ -189,6 +193,8 @@ struct igc_adapter {
 	ktime_t cycle_time;
 	bool qbv_enable;
 	u32 qbv_config_change_errors;
+	bool qbv_transition;
+	unsigned int qbv_count;
 
 	/* OS defined structs */
 	struct pci_dev *pdev;
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 7e22204822ea..e5bfc4000658 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1572,6 +1572,9 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
 	first->bytecount = skb->len;
 	first->gso_segs = 1;
 
+	if (adapter->qbv_transition || tx_ring->oper_gate_closed)
+		goto out_drop;
+
 	if (tx_ring->max_sdu > 0) {
 		u32 max_sdu = 0;
 
@@ -3011,8 +3014,8 @@ static bool igc_clean_tx_irq(struct igc_q_vector *q_vector, int napi_budget)
 		    time_after(jiffies, tx_buffer->time_stamp +
 		    (adapter->tx_timeout_factor * HZ)) &&
 		    !(rd32(IGC_STATUS) & IGC_STATUS_TXOFF) &&
-		    (rd32(IGC_TDH(tx_ring->reg_idx)) !=
-		     readl(tx_ring->tail))) {
+		    (rd32(IGC_TDH(tx_ring->reg_idx)) != readl(tx_ring->tail)) &&
+		    !tx_ring->oper_gate_closed) {
 			/* detected Tx unit hang */
 			netdev_err(tx_ring->netdev,
 				   "Detected Tx Unit Hang\n"
@@ -6102,6 +6105,8 @@ static int igc_tsn_clear_schedule(struct igc_adapter *adapter)
 	adapter->base_time = 0;
 	adapter->cycle_time = NSEC_PER_SEC;
 	adapter->qbv_config_change_errors = 0;
+	adapter->qbv_transition = false;
+	adapter->qbv_count = 0;
 
 	for (i = 0; i < adapter->num_tx_queues; i++) {
 		struct igc_ring *ring = adapter->tx_ring[i];
@@ -6109,6 +6114,8 @@ static int igc_tsn_clear_schedule(struct igc_adapter *adapter)
 		ring->start_time = 0;
 		ring->end_time = NSEC_PER_SEC;
 		ring->max_sdu = 0;
+		ring->oper_gate_closed = false;
+		ring->admin_gate_closed = false;
 	}
 
 	return 0;
@@ -6120,6 +6127,7 @@ static int igc_save_qbv_schedule(struct igc_adapter *adapter,
 	bool queue_configured[IGC_MAX_TX_QUEUES] = { };
 	struct igc_hw *hw = &adapter->hw;
 	u32 start_time = 0, end_time = 0;
+	struct timespec64 now;
 	size_t n;
 	int i;
 
@@ -6149,6 +6157,8 @@ static int igc_save_qbv_schedule(struct igc_adapter *adapter,
 	adapter->cycle_time = qopt->cycle_time;
 	adapter->base_time = qopt->base_time;
 
+	igc_ptp_read(adapter, &now);
+
 	for (n = 0; n < qopt->num_entries; n++) {
 		struct tc_taprio_sched_entry *e = &qopt->entries[n];
 
@@ -6183,7 +6193,10 @@ static int igc_save_qbv_schedule(struct igc_adapter *adapter,
 				ring->start_time = start_time;
 			ring->end_time = end_time;
 
-			queue_configured[i] = true;
+			if (ring->start_time >= adapter->cycle_time)
+				queue_configured[i] = false;
+			else
+				queue_configured[i] = true;
 		}
 
 		start_time += e->interval;
@@ -6193,8 +6206,20 @@ static int igc_save_qbv_schedule(struct igc_adapter *adapter,
 	 * If not, set the start and end time to be end time.
 	 */
 	for (i = 0; i < adapter->num_tx_queues; i++) {
+		struct igc_ring *ring = adapter->tx_ring[i];
+
+		if (!is_base_time_past(qopt->base_time, &now)) {
+			ring->admin_gate_closed = false;
+		} else {
+			ring->oper_gate_closed = false;
+			ring->admin_gate_closed = false;
+		}
+
 		if (!queue_configured[i]) {
-			struct igc_ring *ring = adapter->tx_ring[i];
+			if (!is_base_time_past(qopt->base_time, &now))
+				ring->admin_gate_closed = true;
+			else
+				ring->oper_gate_closed = true;
 
 			ring->start_time = end_time;
 			ring->end_time = end_time;
@@ -6575,6 +6600,27 @@ static const struct xdp_metadata_ops igc_xdp_metadata_ops = {
 	.xmo_rx_timestamp		= igc_xdp_rx_timestamp,
 };
 
+static enum hrtimer_restart igc_qbv_scheduling_timer(struct hrtimer *timer)
+{
+	struct igc_adapter *adapter = container_of(timer, struct igc_adapter,
+						   hrtimer);
+	unsigned int i;
+
+	adapter->qbv_transition = true;
+	for (i = 0; i < adapter->num_tx_queues; i++) {
+		struct igc_ring *tx_ring = adapter->tx_ring[i];
+
+		if (tx_ring->admin_gate_closed) {
+			tx_ring->admin_gate_closed = false;
+			tx_ring->oper_gate_closed = true;
+		} else {
+			tx_ring->oper_gate_closed = false;
+		}
+	}
+	adapter->qbv_transition = false;
+	return HRTIMER_NORESTART;
+}
+
 /**
  * igc_probe - Device Initialization Routine
  * @pdev: PCI device information struct
@@ -6753,6 +6799,9 @@ static int igc_probe(struct pci_dev *pdev,
 	INIT_WORK(&adapter->reset_task, igc_reset_task);
 	INIT_WORK(&adapter->watchdog_task, igc_watchdog_task);
 
+	hrtimer_init(&adapter->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	adapter->hrtimer.function = &igc_qbv_scheduling_timer;
+
 	/* Initialize link properties that are user-changeable */
 	adapter->fc_autoneg = true;
 	hw->mac.autoneg = true;
@@ -6856,6 +6905,7 @@ static void igc_remove(struct pci_dev *pdev)
 
 	cancel_work_sync(&adapter->reset_task);
 	cancel_work_sync(&adapter->watchdog_task);
+	hrtimer_cancel(&adapter->hrtimer);
 
 	/* Release control of h/w to f/w.  If f/w is AMT enabled, this
 	 * would have already happened in close and is redundant.
diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
index 6b299b83e7ef..3cdb0c988728 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -114,7 +114,6 @@ static int igc_tsn_disable_offload(struct igc_adapter *adapter)
 static int igc_tsn_enable_offload(struct igc_adapter *adapter)
 {
 	struct igc_hw *hw = &adapter->hw;
-	bool tsn_mode_reconfig = false;
 	u32 tqavctrl, baset_l, baset_h;
 	u32 sec, nsec, cycle;
 	ktime_t base_time, systim;
@@ -228,11 +227,10 @@ static int igc_tsn_enable_offload(struct igc_adapter *adapter)
 
 	tqavctrl = rd32(IGC_TQAVCTRL) & ~IGC_TQAVCTRL_FUTSCDDIS;
 
-	if (tqavctrl & IGC_TQAVCTRL_TRANSMIT_MODE_TSN)
-		tsn_mode_reconfig = true;
-
 	tqavctrl |= IGC_TQAVCTRL_TRANSMIT_MODE_TSN | IGC_TQAVCTRL_ENHANCED_QAV;
 
+	adapter->qbv_count++;
+
 	cycle = adapter->cycle_time;
 	base_time = adapter->base_time;
 
@@ -250,17 +248,28 @@ static int igc_tsn_enable_offload(struct igc_adapter *adapter)
 		 */
 		if ((rd32(IGC_BASET_H) || rd32(IGC_BASET_L)) &&
 		    (adapter->tc_setup_type == TC_SETUP_QDISC_TAPRIO) &&
-		    tsn_mode_reconfig)
+		    (adapter->qbv_count > 1))
 			adapter->qbv_config_change_errors++;
 	} else {
-		/* According to datasheet section 7.5.2.9.3.3, FutScdDis bit
-		 * has to be configured before the cycle time and base time.
-		 * Tx won't hang if there is a GCL is already running,
-		 * so in this case we don't need to set FutScdDis.
-		 */
-		if (igc_is_device_id_i226(hw) &&
-		    !(rd32(IGC_BASET_H) || rd32(IGC_BASET_L)))
-			tqavctrl |= IGC_TQAVCTRL_FUTSCDDIS;
+		if (igc_is_device_id_i226(hw)) {
+			ktime_t adjust_time, expires_time;
+
+		       /* According to datasheet section 7.5.2.9.3.3, FutScdDis bit
+			* has to be configured before the cycle time and base time.
+			* Tx won't hang if a GCL is already running,
+			* so in this case we don't need to set FutScdDis.
+			*/
+			if (!(rd32(IGC_BASET_H) || rd32(IGC_BASET_L)))
+				tqavctrl |= IGC_TQAVCTRL_FUTSCDDIS;
+
+			nsec = rd32(IGC_SYSTIML);
+			sec = rd32(IGC_SYSTIMH);
+			systim = ktime_set(sec, nsec);
+
+			adjust_time = adapter->base_time;
+			expires_time = ktime_sub_ns(adjust_time, systim);
+			hrtimer_start(&adapter->hrtimer, expires_time, HRTIMER_MODE_REL);
+		}
 	}
 
 	wr32(IGC_TQAVCTRL, tqavctrl);
@@ -306,7 +315,11 @@ int igc_tsn_offload_apply(struct igc_adapter *adapter)
 {
 	struct igc_hw *hw = &adapter->hw;
 
-	if (netif_running(adapter->netdev) && igc_is_device_id_i225(hw)) {
+	/* Per I225/6 HW Design Section 7.5.2.1, transmit mode
+	 * cannot be changed dynamically. Require reset the adapter.
+	 */
+	if (netif_running(adapter->netdev) &&
+	    (igc_is_device_id_i225(hw) || !adapter->qbv_count)) {
 		schedule_work(&adapter->reset_task);
 		return 0;
 	}
-- 
2.38.1


