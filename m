Return-Path: <netdev+bounces-175822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E75A5A678DB
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 17:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5580542471F
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 16:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E06D2116F4;
	Tue, 18 Mar 2025 16:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JnmLMvwQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49CA211282
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 16:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742314430; cv=none; b=YFs3D+zZTqgCRp5r5u8WoqRwODjMtr8BfXyF4LMjGEfzEJKq6Jm+vbLvLtplhVUhOLYP1Fd7YCFVDA7cFwVMU1fQNqeXkTiAioDTVpjzPf5rqFAmce94P8SjHRrA5hGnSyqM2r5jytbk/77TB2YNXhTJLx8x2RTN4vbtT7OlAFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742314430; c=relaxed/simple;
	bh=9VptalQvmstRZHW7Fv4oQ2wBKPlQ7I921u+iPavmPRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VGIMiXl7iEHE50kFW2Ltl5ysV0B+lu8oeDVZpoeayaMV00jJf/uC/Ul/+KFFA/33jqN4G7W5uBGIjjl4W+E7TnbKLSLqUQRZlwucNG9uTpEJAEC2za5g0RxH8cRXN1L/avys16VvAmjtG5sjvHVYpDQw38/9JNZPOR+9JZUTYb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JnmLMvwQ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742314428; x=1773850428;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9VptalQvmstRZHW7Fv4oQ2wBKPlQ7I921u+iPavmPRA=;
  b=JnmLMvwQEvw92jPQdIPwyL+rWzObHh1R0KSgFsusRJZZ6s6mNXeXYRfg
   eW9f5Pjbfc+aO7WJATzI7UtjaE3yBuDSvbpVQvMjnIaCmdj3Zdnubv0ru
   HucLZ9rCFmOKiAz8aPVMDghrF5zDvaZhlNWI/QvfbKemsZjQ7OH90JpK4
   TeOB/ThBIvrUpU06FEpwhlCueSS/q4y3oY0XGQGw5mfLuOs5rXs2ve9+h
   98d5UyzIp25qV344rLU+TrPQDnMy7zvGFL7j+brxfImWEqh1WzaHtFNuQ
   DPuBgxNBofc2OGV1gej9rjNDnDopP4JUbqpt7pOT8ZQOeGMaApMIse6Tx
   w==;
X-CSE-ConnectionGUID: DuPdl7rvRD6Pe9wfslaOhQ==
X-CSE-MsgGUID: 6XjOIpgOSyiM/TOnHNHMxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="54458858"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="54458858"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 09:13:34 -0700
X-CSE-ConnectionGUID: RL8boWoiR+W11bVDmruwHQ==
X-CSE-MsgGUID: RX2EcoRAS32nbwbenf4T/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="122041970"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa009.jf.intel.com with ESMTP; 18 Mar 2025 09:13:35 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Milena Olech <milena.olech@intel.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	karol.kolacinski@intel.com,
	richardcochran@gmail.com,
	YiFei Zhu <zhuyifei@google.com>,
	Mina Almasry <almasrymina@google.com>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net-next 09/10] idpf: add support for Rx timestamping
Date: Tue, 18 Mar 2025 09:13:24 -0700
Message-ID: <20250318161327.2532891-10-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250318161327.2532891-1-anthony.l.nguyen@intel.com>
References: <20250318161327.2532891-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Milena Olech <milena.olech@intel.com>

Add Rx timestamp function when the Rx timestamp value is read directly
from the Rx descriptor. In order to extend the Rx timestamp value to 64
bit in hot path, the PHC time is cached in the receive groups.
Add supported Rx timestamp modes.

Tested-by: YiFei Zhu <zhuyifei@google.com>
Tested-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Milena Olech <milena.olech@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../net/ethernet/intel/idpf/idpf_ethtool.c    |  1 +
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  6 +-
 drivers/net/ethernet/intel/idpf/idpf_ptp.c    | 89 ++++++++++++++++++-
 drivers/net/ethernet/intel/idpf/idpf_ptp.h    | 21 +++++
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 30 +++++++
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  7 +-
 6 files changed, 150 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
index ec4183a609c4..7a4793749bc5 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
@@ -1333,6 +1333,7 @@ static void idpf_get_timestamp_filters(const struct idpf_vport *vport,
 				SOF_TIMESTAMPING_RAW_HARDWARE;
 
 	info->tx_types = BIT(HWTSTAMP_TX_OFF);
+	info->rx_filters = BIT(HWTSTAMP_FILTER_NONE) | BIT(HWTSTAMP_FILTER_ALL);
 
 	if (!vport->tx_tstamp_caps ||
 	    vport->adapter->ptp->tx_tstamp_access == IDPF_PTP_NONE)
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index b4752de5f091..177bde44baa2 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -2361,7 +2361,8 @@ static int idpf_hwtstamp_set(struct net_device *netdev,
 		return -EPERM;
 	}
 
-	if (!idpf_ptp_is_vport_tx_tstamp_ena(vport)) {
+	if (!idpf_ptp_is_vport_tx_tstamp_ena(vport) &&
+	    !idpf_ptp_is_vport_rx_tstamp_ena(vport)) {
 		idpf_vport_ctrl_unlock(netdev);
 		return -EOPNOTSUPP;
 	}
@@ -2386,7 +2387,8 @@ static int idpf_hwtstamp_get(struct net_device *netdev,
 		return -EPERM;
 	}
 
-	if (!idpf_ptp_is_vport_tx_tstamp_ena(vport)) {
+	if (!idpf_ptp_is_vport_tx_tstamp_ena(vport) &&
+	    !idpf_ptp_is_vport_rx_tstamp_ena(vport)) {
 		idpf_vport_ctrl_unlock(netdev);
 		return 0;
 	}
diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
index 36bff5afa474..85a9a25c44d6 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ptp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
@@ -317,12 +317,41 @@ static int idpf_ptp_gettimex64(struct ptp_clock_info *info,
 	return 0;
 }
 
+/**
+ * idpf_ptp_update_phctime_rxq_grp - Update the cached PHC time for a given Rx
+ *				     queue group.
+ * @grp: receive queue group in which Rx timestamp is enabled
+ * @split: Indicates whether the queue model is split or single queue
+ * @systime: Cached system time
+ */
+static void
+idpf_ptp_update_phctime_rxq_grp(const struct idpf_rxq_group *grp, bool split,
+				u64 systime)
+{
+	struct idpf_rx_queue *rxq;
+	u16 i;
+
+	if (!split) {
+		for (i = 0; i < grp->singleq.num_rxq; i++) {
+			rxq = grp->singleq.rxqs[i];
+			if (rxq)
+				WRITE_ONCE(rxq->cached_phc_time, systime);
+		}
+	} else {
+		for (i = 0; i < grp->splitq.num_rxq_sets; i++) {
+			rxq = &grp->splitq.rxq_sets[i]->rxq;
+			if (rxq)
+				WRITE_ONCE(rxq->cached_phc_time, systime);
+		}
+	}
+}
+
 /**
  * idpf_ptp_update_cached_phctime - Update the cached PHC time values
  * @adapter: Driver specific private structure
  *
  * This function updates the system time values which are cached in the adapter
- * structure.
+ * structure and the Rx queues.
  *
  * This function must be called periodically to ensure that the cached value
  * is never more than 2 seconds old.
@@ -345,6 +374,21 @@ static int idpf_ptp_update_cached_phctime(struct idpf_adapter *adapter)
 	WRITE_ONCE(adapter->ptp->cached_phc_time, systime);
 	WRITE_ONCE(adapter->ptp->cached_phc_jiffies, jiffies);
 
+	idpf_for_each_vport(adapter, vport) {
+		bool split;
+
+		if (!vport || !vport->rxq_grps)
+			continue;
+
+		split = idpf_is_queue_model_split(vport->rxq_model);
+
+		for (u16 i = 0; i < vport->num_rxq_grp; i++) {
+			struct idpf_rxq_group *grp = &vport->rxq_grps[i];
+
+			idpf_ptp_update_phctime_rxq_grp(grp, split, systime);
+		}
+	}
+
 	return 0;
 }
 
@@ -608,6 +652,48 @@ int idpf_ptp_request_ts(struct idpf_tx_queue *tx_q, struct sk_buff *skb,
 	return 0;
 }
 
+/**
+ * idpf_ptp_set_rx_tstamp - Enable or disable Rx timestamping
+ * @vport: Virtual port structure
+ * @rx_filter: bool value for whether timestamps are enabled or disabled
+ */
+static void idpf_ptp_set_rx_tstamp(struct idpf_vport *vport, int rx_filter)
+{
+	bool enable = true, splitq;
+
+	splitq = idpf_is_queue_model_split(vport->rxq_model);
+
+	if (rx_filter == HWTSTAMP_FILTER_NONE) {
+		enable = false;
+		vport->tstamp_config.rx_filter = HWTSTAMP_FILTER_NONE;
+	} else {
+		vport->tstamp_config.rx_filter = HWTSTAMP_FILTER_ALL;
+	}
+
+	for (u16 i = 0; i < vport->num_rxq_grp; i++) {
+		struct idpf_rxq_group *grp = &vport->rxq_grps[i];
+		struct idpf_rx_queue *rx_queue;
+		u16 j, num_rxq;
+
+		if (splitq)
+			num_rxq = grp->splitq.num_rxq_sets;
+		else
+			num_rxq = grp->singleq.num_rxq;
+
+		for (j = 0; j < num_rxq; j++) {
+			if (splitq)
+				rx_queue = &grp->splitq.rxq_sets[j]->rxq;
+			else
+				rx_queue = grp->singleq.rxqs[j];
+
+			if (enable)
+				idpf_queue_set(PTP, rx_queue);
+			else
+				idpf_queue_clear(PTP, rx_queue);
+		}
+	}
+}
+
 /**
  * idpf_ptp_set_timestamp_mode - Setup driver for requested timestamp mode
  * @vport: Virtual port structure
@@ -630,6 +716,7 @@ int idpf_ptp_set_timestamp_mode(struct idpf_vport *vport,
 	}
 
 	vport->tstamp_config.tx_type = config->tx_type;
+	idpf_ptp_set_rx_tstamp(vport, config->rx_filter);
 	*config = vport->tstamp_config;
 
 	return 0;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.h b/drivers/net/ethernet/intel/idpf/idpf_ptp.h
index 5cb7b68085b6..c3ad2c578868 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ptp.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.h
@@ -234,6 +234,27 @@ static inline bool idpf_ptp_is_vport_tx_tstamp_ena(struct idpf_vport *vport)
 		return true;
 }
 
+/**
+ * idpf_ptp_is_vport_rx_tstamp_ena - Verify the Rx timestamping enablement for
+ *				     a given vport.
+ * @vport: Virtual port structure
+ *
+ * Rx timestamp feature is enabled if the PTP clock for the adapter is created
+ * and it is possible to read the value of the device clock. The second
+ * assumption comes from the need to extend the Rx timestamp value to 64 bit
+ * based on the current device clock time.
+ *
+ * Return: true if the Rx timestamping is enabled, false otherwise.
+ */
+static inline bool idpf_ptp_is_vport_rx_tstamp_ena(struct idpf_vport *vport)
+{
+	if (!vport->adapter->ptp ||
+	    vport->adapter->ptp->get_dev_clk_time_access == IDPF_PTP_NONE)
+		return false;
+	else
+		return true;
+}
+
 #if IS_ENABLED(CONFIG_PTP_1588_CLOCK)
 int idpf_ptp_init(struct idpf_adapter *adapter);
 void idpf_ptp_release(struct idpf_adapter *adapter);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 0aa0680e57ad..5137e9d15adb 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -3170,6 +3170,33 @@ static int idpf_rx_rsc(struct idpf_rx_queue *rxq, struct sk_buff *skb,
 	return 0;
 }
 
+/**
+ * idpf_rx_hwtstamp - check for an RX timestamp and pass up the stack
+ * @rxq: pointer to the rx queue that receives the timestamp
+ * @rx_desc: pointer to rx descriptor containing timestamp
+ * @skb: skb to put timestamp in
+ */
+static void
+idpf_rx_hwtstamp(const struct idpf_rx_queue *rxq,
+		 const struct virtchnl2_rx_flex_desc_adv_nic_3 *rx_desc,
+		 struct sk_buff *skb)
+{
+	u64 cached_time, ts_ns;
+	u32 ts_high;
+
+	if (!(rx_desc->ts_low & VIRTCHNL2_RX_FLEX_TSTAMP_VALID))
+		return;
+
+	cached_time = READ_ONCE(rxq->cached_phc_time);
+
+	ts_high = le32_to_cpu(rx_desc->ts_high);
+	ts_ns = idpf_ptp_tstamp_extend_32b_to_64b(cached_time, ts_high);
+
+	*skb_hwtstamps(skb) = (struct skb_shared_hwtstamps) {
+		.hwtstamp = ns_to_ktime(ts_ns),
+	};
+}
+
 /**
  * idpf_rx_process_skb_fields - Populate skb header fields from Rx descriptor
  * @rxq: Rx descriptor ring packet is being transacted on
@@ -3195,6 +3222,9 @@ idpf_rx_process_skb_fields(struct idpf_rx_queue *rxq, struct sk_buff *skb,
 	/* process RSS/hash */
 	idpf_rx_hash(rxq, skb, rx_desc, decoded);
 
+	if (idpf_queue_has(PTP, rxq))
+		idpf_rx_hwtstamp(rxq, rx_desc, skb);
+
 	skb->protocol = eth_type_trans(skb, rxq->netdev);
 	skb_record_rx_queue(skb, rxq->idx);
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 9b7aa72e1f32..c779fe71df99 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -290,6 +290,8 @@ struct idpf_ptype_state {
  * @__IDPF_Q_POLL_MODE: Enable poll mode
  * @__IDPF_Q_CRC_EN: enable CRC offload in singleq mode
  * @__IDPF_Q_HSPLIT_EN: enable header split on Rx (splitq)
+ * @__IDPF_Q_PTP: indicates whether the Rx timestamping is enabled for the
+ *		  queue
  * @__IDPF_Q_FLAGS_NBITS: Must be last
  */
 enum idpf_queue_flags_t {
@@ -300,6 +302,7 @@ enum idpf_queue_flags_t {
 	__IDPF_Q_POLL_MODE,
 	__IDPF_Q_CRC_EN,
 	__IDPF_Q_HSPLIT_EN,
+	__IDPF_Q_PTP,
 
 	__IDPF_Q_FLAGS_NBITS,
 };
@@ -496,6 +499,7 @@ struct idpf_txq_stash {
  * @next_to_alloc: RX buffer to allocate at
  * @skb: Pointer to the skb
  * @truesize: data buffer truesize in singleq
+ * @cached_phc_time: Cached PHC time for the Rx queue
  * @stats_sync: See struct u64_stats_sync
  * @q_stats: See union idpf_rx_queue_stats
  * @q_id: Queue id
@@ -543,6 +547,7 @@ struct idpf_rx_queue {
 
 	struct sk_buff *skb;
 	u32 truesize;
+	u64 cached_phc_time;
 
 	struct u64_stats_sync stats_sync;
 	struct idpf_rx_queue_stats q_stats;
@@ -562,7 +567,7 @@ struct idpf_rx_queue {
 	__cacheline_group_end_aligned(cold);
 };
 libeth_cacheline_set_assert(struct idpf_rx_queue, 64,
-			    80 + sizeof(struct u64_stats_sync),
+			    88 + sizeof(struct u64_stats_sync),
 			    32);
 
 /**
-- 
2.47.1


