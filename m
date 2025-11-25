Return-Path: <netdev+bounces-241685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55755C87594
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 23:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A50A33B635F
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 22:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F5D33C190;
	Tue, 25 Nov 2025 22:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MXE+iFSx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CB633B6DC
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 22:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764110202; cv=none; b=FDDdA6EK/Xsg8CtnYPylMJKD3aAJyYZaYMpUuRPYIgCGc3acIv7bakrNEI0KKkcNyAPoKsrZ0ctceddHLm6qbXNuMr87X+N/2emRXt7sYWZO5cQWEPGLzTTNiUcsb7aljorEuVTlGeWR7o9ApqvJA6TPQy3OqjdDzagjbkR5uT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764110202; c=relaxed/simple;
	bh=HhYsipACQpHuH64SfFWQ+OIQGOgWEMFjLqjSI/LYqHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z+Qe4CuK3nXW+J8mcXHYXgt7kc9nsYBJtkX/T6Wsy9Nd4hX5pqWTrJIwItKCjEeq63xEQy+htjiYHFh+ZhcXrwJMKInjYZ+8EtsxhtwYD/JIuiqxwdcLaGg+gK2tF9PrO68ZwrR6TbnDHoby1vsknBcTWQRX+MfHxmFUuiHbSoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MXE+iFSx; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764110201; x=1795646201;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HhYsipACQpHuH64SfFWQ+OIQGOgWEMFjLqjSI/LYqHM=;
  b=MXE+iFSxCIaWVdnT/JUZCxcVRChkcjgVUWZiMs5qpe/Gn+XprOl7qcnE
   CREBdPWEGFb+fWqHdMPtFvp0lP/i/OkMa2kr2v5RbJq5TFwTl/DRwHOK+
   Bu3kHHm2PXNRVbGNiF1FtrVM4xoXUN2wWCw6B38rjtEy02/XKmnbcG+Nv
   UxaZ84yMSP1ZMdJHIxiaZdZ8+Ks+OW9N7ecydHjRB6Ks13P50PTjLs/TH
   Ej2qHMLMsEaisVzQFS4h/uZvPeaLBl7wLfw9w3GcegVswSk2VdLiPeKbv
   kZjUBgqsDXWnJWH02kqF1a9OB0m4xcf214FsodDKHFQVupWJfgWyJQLXG
   g==;
X-CSE-ConnectionGUID: ZRZBQWjLSN6KxZuWWIOFaw==
X-CSE-MsgGUID: 9wQ6CGSxQC2RN7v+SoHDsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="68729895"
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="68729895"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 14:36:40 -0800
X-CSE-ConnectionGUID: 3YgvmtItQ0m+ciaAtIkq4w==
X-CSE-MsgGUID: M+OKU7/xQSGrfqZ5q93tXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="193209558"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 25 Nov 2025 14:36:39 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Emil Tantilov <emil.s.tantilov@intel.com>,
	anthony.l.nguyen@intel.com,
	willemb@google.com,
	decot@google.com,
	joshua.a.hay@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Chittim Madhu <madhu.chittim@intel.com>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net-next 05/11] idpf: convert vport state to bitmap
Date: Tue, 25 Nov 2025 14:36:24 -0800
Message-ID: <20251125223632.1857532-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251125223632.1857532-1-anthony.l.nguyen@intel.com>
References: <20251125223632.1857532-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emil Tantilov <emil.s.tantilov@intel.com>

Convert vport state to a bitmap and remove the DOWN state which is
redundant in the existing logic. There are no functional changes aside
from the use of bitwise operations when setting and checking the states.
Removed the double underscore to be consistent with the naming of other
bitmaps in the header and renamed current_state to vport_is_up to match
the meaning of the new variable.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Chittim Madhu <madhu.chittim@intel.com>
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h        | 12 ++++------
 .../net/ethernet/intel/idpf/idpf_ethtool.c    | 12 +++++-----
 drivers/net/ethernet/intel/idpf/idpf_lib.c    | 24 +++++++++----------
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   |  2 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  2 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  4 ++--
 drivers/net/ethernet/intel/idpf/xdp.c         |  2 +-
 7 files changed, 28 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 50fa7be0c00d..8cfc68cbfa06 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -131,14 +131,12 @@ enum idpf_cap_field {
 
 /**
  * enum idpf_vport_state - Current vport state
- * @__IDPF_VPORT_DOWN: Vport is down
- * @__IDPF_VPORT_UP: Vport is up
- * @__IDPF_VPORT_STATE_LAST: Must be last, number of states
+ * @IDPF_VPORT_UP: Vport is up
+ * @IDPF_VPORT_STATE_NBITS: Must be last, number of states
  */
 enum idpf_vport_state {
-	__IDPF_VPORT_DOWN,
-	__IDPF_VPORT_UP,
-	__IDPF_VPORT_STATE_LAST,
+	IDPF_VPORT_UP,
+	IDPF_VPORT_STATE_NBITS
 };
 
 /**
@@ -162,7 +160,7 @@ struct idpf_netdev_priv {
 	u16 vport_idx;
 	u16 max_tx_hdr_size;
 	u16 tx_max_bufs;
-	enum idpf_vport_state state;
+	DECLARE_BITMAP(state, IDPF_VPORT_STATE_NBITS);
 	struct rtnl_link_stats64 netstats;
 	spinlock_t stats_lock;
 };
diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
index a5a1eec9ade8..eed166bc46f3 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
@@ -386,7 +386,7 @@ static int idpf_get_rxfh(struct net_device *netdev,
 	}
 
 	rss_data = &adapter->vport_config[np->vport_idx]->user_config.rss_data;
-	if (np->state != __IDPF_VPORT_UP)
+	if (!test_bit(IDPF_VPORT_UP, np->state))
 		goto unlock_mutex;
 
 	rxfh->hfunc = ETH_RSS_HASH_TOP;
@@ -436,7 +436,7 @@ static int idpf_set_rxfh(struct net_device *netdev,
 	}
 
 	rss_data = &adapter->vport_config[vport->idx]->user_config.rss_data;
-	if (np->state != __IDPF_VPORT_UP)
+	if (!test_bit(IDPF_VPORT_UP, np->state))
 		goto unlock_mutex;
 
 	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
@@ -1167,7 +1167,7 @@ static void idpf_get_ethtool_stats(struct net_device *netdev,
 	idpf_vport_ctrl_lock(netdev);
 	vport = idpf_netdev_to_vport(netdev);
 
-	if (np->state != __IDPF_VPORT_UP) {
+	if (!test_bit(IDPF_VPORT_UP, np->state)) {
 		idpf_vport_ctrl_unlock(netdev);
 
 		return;
@@ -1319,7 +1319,7 @@ static int idpf_get_q_coalesce(struct net_device *netdev,
 	idpf_vport_ctrl_lock(netdev);
 	vport = idpf_netdev_to_vport(netdev);
 
-	if (np->state != __IDPF_VPORT_UP)
+	if (!test_bit(IDPF_VPORT_UP, np->state))
 		goto unlock_mutex;
 
 	if (q_num >= vport->num_rxq && q_num >= vport->num_txq) {
@@ -1507,7 +1507,7 @@ static int idpf_set_coalesce(struct net_device *netdev,
 	idpf_vport_ctrl_lock(netdev);
 	vport = idpf_netdev_to_vport(netdev);
 
-	if (np->state != __IDPF_VPORT_UP)
+	if (!test_bit(IDPF_VPORT_UP, np->state))
 		goto unlock_mutex;
 
 	for (i = 0; i < vport->num_txq; i++) {
@@ -1710,7 +1710,7 @@ static void idpf_get_ts_stats(struct net_device *netdev,
 		ts_stats->err = u64_stats_read(&vport->tstamp_stats.discarded);
 	} while (u64_stats_fetch_retry(&vport->tstamp_stats.stats_sync, start));
 
-	if (np->state != __IDPF_VPORT_UP)
+	if (!test_bit(IDPF_VPORT_UP, np->state))
 		goto exit;
 
 	for (u16 i = 0; i < vport->num_txq_grp; i++) {
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 8a941f0fb048..7a7e101afeb6 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -519,7 +519,7 @@ static int idpf_del_mac_filter(struct idpf_vport *vport,
 	}
 	spin_unlock_bh(&vport_config->mac_filter_list_lock);
 
-	if (np->state == __IDPF_VPORT_UP) {
+	if (test_bit(IDPF_VPORT_UP, np->state)) {
 		int err;
 
 		err = idpf_add_del_mac_filters(vport, np, false, async);
@@ -590,7 +590,7 @@ static int idpf_add_mac_filter(struct idpf_vport *vport,
 	if (err)
 		return err;
 
-	if (np->state == __IDPF_VPORT_UP)
+	if (test_bit(IDPF_VPORT_UP, np->state))
 		err = idpf_add_del_mac_filters(vport, np, true, async);
 
 	return err;
@@ -894,7 +894,7 @@ static void idpf_vport_stop(struct idpf_vport *vport, bool rtnl)
 {
 	struct idpf_netdev_priv *np = netdev_priv(vport->netdev);
 
-	if (np->state <= __IDPF_VPORT_DOWN)
+	if (!test_bit(IDPF_VPORT_UP, np->state))
 		return;
 
 	if (rtnl)
@@ -921,7 +921,7 @@ static void idpf_vport_stop(struct idpf_vport *vport, bool rtnl)
 	idpf_xdp_rxq_info_deinit_all(vport);
 	idpf_vport_queues_rel(vport);
 	idpf_vport_intr_rel(vport);
-	np->state = __IDPF_VPORT_DOWN;
+	clear_bit(IDPF_VPORT_UP, np->state);
 
 	if (rtnl)
 		rtnl_unlock();
@@ -1345,7 +1345,7 @@ static int idpf_up_complete(struct idpf_vport *vport)
 		netif_tx_start_all_queues(vport->netdev);
 	}
 
-	np->state = __IDPF_VPORT_UP;
+	set_bit(IDPF_VPORT_UP, np->state);
 
 	return 0;
 }
@@ -1391,7 +1391,7 @@ static int idpf_vport_open(struct idpf_vport *vport, bool rtnl)
 	struct idpf_vport_config *vport_config;
 	int err;
 
-	if (np->state != __IDPF_VPORT_DOWN)
+	if (test_bit(IDPF_VPORT_UP, np->state))
 		return -EBUSY;
 
 	if (rtnl)
@@ -1602,7 +1602,7 @@ void idpf_init_task(struct work_struct *work)
 
 	/* Once state is put into DOWN, driver is ready for dev_open */
 	np = netdev_priv(vport->netdev);
-	np->state = __IDPF_VPORT_DOWN;
+	clear_bit(IDPF_VPORT_UP, np->state);
 	if (test_and_clear_bit(IDPF_VPORT_UP_REQUESTED, vport_config->flags))
 		idpf_vport_open(vport, true);
 
@@ -1801,7 +1801,7 @@ static void idpf_set_vport_state(struct idpf_adapter *adapter)
 			continue;
 
 		np = netdev_priv(adapter->netdevs[i]);
-		if (np->state == __IDPF_VPORT_UP)
+		if (test_bit(IDPF_VPORT_UP, np->state))
 			set_bit(IDPF_VPORT_UP_REQUESTED,
 				adapter->vport_config[i]->flags);
 	}
@@ -1939,7 +1939,7 @@ int idpf_initiate_soft_reset(struct idpf_vport *vport,
 			     enum idpf_vport_reset_cause reset_cause)
 {
 	struct idpf_netdev_priv *np = netdev_priv(vport->netdev);
-	enum idpf_vport_state current_state = np->state;
+	bool vport_is_up = test_bit(IDPF_VPORT_UP, np->state);
 	struct idpf_adapter *adapter = vport->adapter;
 	struct idpf_vport *new_vport;
 	int err;
@@ -1990,7 +1990,7 @@ int idpf_initiate_soft_reset(struct idpf_vport *vport,
 		goto free_vport;
 	}
 
-	if (current_state <= __IDPF_VPORT_DOWN) {
+	if (!vport_is_up) {
 		idpf_send_delete_queues_msg(vport);
 	} else {
 		set_bit(IDPF_VPORT_DEL_QUEUES, vport->flags);
@@ -2023,7 +2023,7 @@ int idpf_initiate_soft_reset(struct idpf_vport *vport,
 	if (err)
 		goto err_open;
 
-	if (current_state == __IDPF_VPORT_UP)
+	if (vport_is_up)
 		err = idpf_vport_open(vport, false);
 
 	goto free_vport;
@@ -2033,7 +2033,7 @@ int idpf_initiate_soft_reset(struct idpf_vport *vport,
 				 vport->num_rxq, vport->num_bufq);
 
 err_open:
-	if (current_state == __IDPF_VPORT_UP)
+	if (vport_is_up)
 		idpf_vport_open(vport, false);
 
 free_vport:
diff --git a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
index 61e613066140..e3ddf18dcbf5 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
@@ -570,7 +570,7 @@ static bool idpf_tx_singleq_clean(struct idpf_tx_queue *tx_q, int napi_budget,
 	np = netdev_priv(tx_q->netdev);
 	nq = netdev_get_tx_queue(tx_q->netdev, tx_q->idx);
 
-	dont_wake = np->state != __IDPF_VPORT_UP ||
+	dont_wake = !test_bit(IDPF_VPORT_UP, np->state) ||
 		    !netif_carrier_ok(tx_q->netdev);
 	__netif_txq_completed_wake(nq, ss.packets, ss.bytes,
 				   IDPF_DESC_UNUSED(tx_q), IDPF_TX_WAKE_THRESH,
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 828f7c444d30..1993a3b0da59 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -2275,7 +2275,7 @@ static bool idpf_tx_clean_complq(struct idpf_compl_queue *complq, int budget,
 		/* Update BQL */
 		nq = netdev_get_tx_queue(tx_q->netdev, tx_q->idx);
 
-		dont_wake = !complq_ok || np->state != __IDPF_VPORT_UP ||
+		dont_wake = !complq_ok || !test_bit(IDPF_VPORT_UP, np->state) ||
 			    !netif_carrier_ok(tx_q->netdev);
 		/* Check if the TXQ needs to and can be restarted */
 		__netif_txq_completed_wake(nq, tx_q->cleaned_pkts, tx_q->cleaned_bytes,
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index cbb5fa30f5a0..44cd4b466c48 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -68,7 +68,7 @@ static void idpf_handle_event_link(struct idpf_adapter *adapter,
 
 	vport->link_up = v2e->link_status;
 
-	if (np->state != __IDPF_VPORT_UP)
+	if (!test_bit(IDPF_VPORT_UP, np->state))
 		return;
 
 	if (vport->link_up) {
@@ -2755,7 +2755,7 @@ int idpf_send_get_stats_msg(struct idpf_vport *vport)
 
 
 	/* Don't send get_stats message if the link is down */
-	if (np->state <= __IDPF_VPORT_DOWN)
+	if (!test_bit(IDPF_VPORT_UP, np->state))
 		return 0;
 
 	stats_msg.vport_id = cpu_to_le32(vport->vport_id);
diff --git a/drivers/net/ethernet/intel/idpf/xdp.c b/drivers/net/ethernet/intel/idpf/xdp.c
index 21ce25b0567f..958d16f87424 100644
--- a/drivers/net/ethernet/intel/idpf/xdp.c
+++ b/drivers/net/ethernet/intel/idpf/xdp.c
@@ -418,7 +418,7 @@ static int idpf_xdp_setup_prog(struct idpf_vport *vport,
 	if (test_bit(IDPF_REMOVE_IN_PROG, vport->adapter->flags) ||
 	    !test_bit(IDPF_VPORT_REG_NETDEV, cfg->flags) ||
 	    !!vport->xdp_prog == !!prog) {
-		if (np->state == __IDPF_VPORT_UP)
+		if (test_bit(IDPF_VPORT_UP, np->state))
 			idpf_xdp_copy_prog_to_rqs(vport, prog);
 
 		old = xchg(&vport->xdp_prog, prog);
-- 
2.47.1


