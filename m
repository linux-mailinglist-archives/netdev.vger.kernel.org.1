Return-Path: <netdev+bounces-218335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 525D9B3C01A
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 17:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DD70161C66
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 15:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50484326D52;
	Fri, 29 Aug 2025 15:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bq8V1gjX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DED322C9C
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 15:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756483164; cv=none; b=ZYIIpePNkXKaY/gbKJ3L9duqpts0IhDcRj+sZjqVh9oDYosEzn3/zHdd7sSOs2J4RVlJfgcBRgWTTYJkE8rHAbHHMFIAmqxao4EtBJZ86w3AgGcPPxq7AIKYfEnhNbqWXPNNV4GLMgQsT6UWxAmEcAoLdBrxS88kv0Gcpc22DL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756483164; c=relaxed/simple;
	bh=uoQ2xAb52qfxyXqftTwYIMBhksOqI6yk9akjsG4e9Yo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ekhm33+1FYzS+CECleRELee0JGl6EbiD+Yj70L5DZhBxHR7HFT2aeQ64H1Bm0Z62QjFnkE7o1UMdcdWwcOFVxJrHPXiezG+NKF3d38hDmkFpa9ZtT9EqlABGd0sWqpA/G/D6AroLHTufX8FwSwnWsUc5umJDXHQQPcTu64b7pOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bq8V1gjX; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756483163; x=1788019163;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uoQ2xAb52qfxyXqftTwYIMBhksOqI6yk9akjsG4e9Yo=;
  b=Bq8V1gjXlTzhtEMhAMTob8sgNogtJx/ys6pKKqtT16GX+CzG3qgp3HZa
   wf3kW1oUqLAGKHAVjUh/2MuTp34RB0oMzYzUwBpLjAnWjGLg7Rq2UWqrB
   0xl8FX+dUQkRcl139oRtnR/ZFj99tQLSxvpApcZuFtYvFpWd5p+YSwFys
   lg4gIl0R0FMPRnP6/XaZF5tDl3djNu9S1lvtVRSyjDmptkBXldMOduGLq
   0UAE5ZuPlQ888yRDypAa6NlD4cA9zFOst6hZfwCqqd8Ga4tV1A/VAAQZW
   h/fFO0Xp2GoUoyuqn2zz8pwRJPbqS0brf2rDAEcWUD80+Q3M0hty8jsDl
   w==;
X-CSE-ConnectionGUID: Lh/MH3bDS06mV0Z+Y/L+gw==
X-CSE-MsgGUID: I4Iib1QeTSK6eqTPfrAn+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11537"; a="69480037"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="69480037"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 08:59:22 -0700
X-CSE-ConnectionGUID: RhBOPIPfTl2dYYb6yUKFyw==
X-CSE-MsgGUID: ibE3l8BnTiOhYcJX1xkpCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="174583492"
Received: from host59.igk.intel.com ([10.123.220.59])
  by orviesa003.jf.intel.com with ESMTP; 29 Aug 2025 08:59:19 -0700
From: Anton Nadezhdin <anton.nadezhdin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	Milena Olech <milena.olech@intel.com>,
	Anton Nadezhdin <anton.nadezhdin@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-next v3] idpf: add HW timestamping statistics
Date: Fri, 29 Aug 2025 13:57:33 -0400
Message-ID: <20250829175734.175963-1-anton.nadezhdin@intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Milena Olech <milena.olech@intel.com>

Add HW timestamping statistics support - through implementing get_ts_stats.
Timestamp statistics include correctly timestamped packets, discarded,
skipped and flushed during PTP release.

Most of the stats are collected per vport, only requests skipped due to
lack of free latch index are collected per Tx queue.

Statistics can be obtained using kernel ethtool since version 6.10
with:
ethtool -I -T <interface>

The output will include:
Statistics:
  tx_pkts: 15
  tx_lost: 0
  tx_err: 0

Signed-off-by: Milena Olech <milena.olech@intel.com>
Co-developed-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
Signed-off-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
Changelog:
v2: Add testing information
v3: Add check for port status to resolve driver crash during statistic
  read when port is down
---
 drivers/net/ethernet/intel/idpf/idpf.h        | 17 ++++++
 .../net/ethernet/intel/idpf/idpf_ethtool.c    | 56 +++++++++++++++++++
 drivers/net/ethernet/intel/idpf/idpf_ptp.c    | 11 +++-
 .../ethernet/intel/idpf/idpf_virtchnl_ptp.c   |  4 ++
 4 files changed, 87 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 6e79fa8556e9..6db6d6f0562a 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -256,6 +256,21 @@ enum idpf_vport_flags {
 	IDPF_VPORT_FLAGS_NBITS,
 };
 
+/**
+ * struct idpf_tstamp_stats - Tx timestamp statistics
+ * @stats_sync: See struct u64_stats_sync
+ * @packets: Number of packets successfully timestamped by the hardware
+ * @discarded: Number of Tx skbs discarded due to cached PHC
+ *	       being too old to correctly extend timestamp
+ * @flushed: Number of Tx skbs flushed due to interface closed
+ */
+struct idpf_tstamp_stats {
+	struct u64_stats_sync stats_sync;
+	u64_stats_t packets;
+	u64_stats_t discarded;
+	u64_stats_t flushed;
+};
+
 struct idpf_port_stats {
 	struct u64_stats_sync stats_sync;
 	u64_stats_t rx_hw_csum_err;
@@ -328,6 +343,7 @@ struct idpf_fsteer_fltr {
  * @tx_tstamp_caps: Capabilities negotiated for Tx timestamping
  * @tstamp_config: The Tx tstamp config
  * @tstamp_task: Tx timestamping task
+ * @tstamp_stats: Tx timestamping statistics
  */
 struct idpf_vport {
 	u16 num_txq;
@@ -386,6 +402,7 @@ struct idpf_vport {
 	struct idpf_ptp_vport_tx_tstamp_caps *tx_tstamp_caps;
 	struct kernel_hwtstamp_config tstamp_config;
 	struct work_struct tstamp_task;
+	struct idpf_tstamp_stats tstamp_stats;
 };
 
 /**
diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
index 0eb812ac19c2..786d0bacdd3c 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
@@ -1685,6 +1685,61 @@ static int idpf_get_ts_info(struct net_device *netdev,
 	return err;
 }
 
+/**
+ * idpf_get_ts_stats - Collect HW tstamping statistics
+ * @netdev: network interface device structure
+ * @ts_stats: HW timestamping stats structure
+ *
+ * Collect HW timestamping statistics including successfully timestamped
+ * packets, discarded due to illegal values, flushed during releasing PTP and
+ * skipped due to lack of the free index.
+ */
+static void idpf_get_ts_stats(struct net_device *netdev,
+			      struct ethtool_ts_stats *ts_stats)
+{
+	struct idpf_netdev_priv *np = netdev_priv(netdev);
+	struct idpf_vport *vport;
+	unsigned int start;
+
+	idpf_vport_ctrl_lock(netdev);
+	vport = idpf_netdev_to_vport(netdev);
+	do {
+		start = u64_stats_fetch_begin(&vport->tstamp_stats.stats_sync);
+		ts_stats->pkts = u64_stats_read(&vport->tstamp_stats.packets);
+		ts_stats->lost = u64_stats_read(&vport->tstamp_stats.flushed);
+		ts_stats->err = u64_stats_read(&vport->tstamp_stats.discarded);
+	} while (u64_stats_fetch_retry(&vport->tstamp_stats.stats_sync, start));
+
+	if (np->state != __IDPF_VPORT_UP)
+		goto exit;
+
+	for (u16 i = 0; i < vport->num_txq_grp; i++) {
+		struct idpf_txq_group *txq_grp = &vport->txq_grps[i];
+
+		for (u16 j = 0; j < txq_grp->num_txq; j++) {
+			struct idpf_tx_queue *txq = txq_grp->txqs[j];
+			struct idpf_tx_queue_stats *stats;
+			u64 ts;
+
+			if (!txq)
+				continue;
+
+			stats = &txq->q_stats;
+			do {
+				start = u64_stats_fetch_begin(&txq->stats_sync);
+
+				ts = u64_stats_read(&stats->tstamp_skipped);
+			} while (u64_stats_fetch_retry(&txq->stats_sync,
+						       start));
+
+			ts_stats->lost += ts;
+		}
+	}
+
+exit:
+	idpf_vport_ctrl_unlock(netdev);
+}
+
 static const struct ethtool_ops idpf_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_USE_ADAPTIVE,
@@ -1711,6 +1766,7 @@ static const struct ethtool_ops idpf_ethtool_ops = {
 	.set_ringparam		= idpf_set_ringparam,
 	.get_link_ksettings	= idpf_get_link_ksettings,
 	.get_ts_info		= idpf_get_ts_info,
+	.get_ts_stats		= idpf_get_ts_stats,
 };
 
 /**
diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
index 63a41e688733..3e1052d070cf 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ptp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
@@ -618,8 +618,13 @@ u64 idpf_ptp_extend_ts(struct idpf_vport *vport, u64 in_tstamp)
 
 	discard_time = ptp->cached_phc_jiffies + 2 * HZ;
 
-	if (time_is_before_jiffies(discard_time))
+	if (time_is_before_jiffies(discard_time)) {
+		u64_stats_update_begin(&vport->tstamp_stats.stats_sync);
+		u64_stats_inc(&vport->tstamp_stats.discarded);
+		u64_stats_update_end(&vport->tstamp_stats.stats_sync);
+
 		return 0;
+	}
 
 	return idpf_ptp_tstamp_extend_32b_to_64b(ptp->cached_phc_time,
 						 lower_32_bits(in_tstamp));
@@ -853,13 +858,17 @@ static void idpf_ptp_release_vport_tstamp(struct idpf_vport *vport)
 
 	/* Remove list with latches in use */
 	head = &vport->tx_tstamp_caps->latches_in_use;
+	u64_stats_update_begin(&vport->tstamp_stats.stats_sync);
 	list_for_each_entry_safe(ptp_tx_tstamp, tmp, head, list_member) {
+		u64_stats_inc(&vport->tstamp_stats.flushed);
+
 		list_del(&ptp_tx_tstamp->list_member);
 		if (ptp_tx_tstamp->skb)
 			consume_skb(ptp_tx_tstamp->skb);
 
 		kfree(ptp_tx_tstamp);
 	}
+	u64_stats_update_end(&vport->tstamp_stats.stats_sync);
 
 	spin_unlock_bh(&vport->tx_tstamp_caps->latches_lock);
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
index 688a6f4e0acc..61cedb6f2854 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
@@ -522,6 +522,10 @@ idpf_ptp_get_tstamp_value(struct idpf_vport *vport,
 	list_add(&ptp_tx_tstamp->list_member,
 		 &tx_tstamp_caps->latches_free);
 
+	u64_stats_update_begin(&vport->tstamp_stats.stats_sync);
+	u64_stats_inc(&vport->tstamp_stats.packets);
+	u64_stats_update_end(&vport->tstamp_stats.stats_sync);
+
 	return 0;
 }
 

base-commit: e9d3c152a5c44376d901100fac80858278acc3eb
-- 
2.42.0


