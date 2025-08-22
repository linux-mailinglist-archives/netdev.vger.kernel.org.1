Return-Path: <netdev+bounces-215892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E384B30D0C
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 05:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17C7A3B5D11
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 03:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2150B288C22;
	Fri, 22 Aug 2025 03:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xk4nX2WJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9C9277007
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 03:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755834825; cv=none; b=McNOPUADhcoYSeI2VlQsI/MP5b9EmlyEBVTqvTSCaLci9pdqSuy+J8CBTEr/GsS3teBQoN5RAPB5J5Pj/kbeS1L8AOkB6c4CCYmtt7LCf7FtKAlyr+pgopLP0QjXwuTZVwZt0sexT3RKgPSCJXQDyUTSPB988ASA9DzWeCBSSnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755834825; c=relaxed/simple;
	bh=u8SNYrGup52raExP3z9rP7SKIxp+epvEHd3pHNXU0to=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=t2qPgcziWf6slipIj61igqoGEAEelYm/Tm7odzkExwE3dM+8+bI8jpSIAwtDbyIxrUk5LP7CR0K3jHx+JgQN9IN6PnO9UfDNbH12ZEb7WcGvEqdmbvdXgpx/cDnMJLqO0yA2UEpPV5ra229baNY0DpIpMbX6wdx7zD1E97u0Z0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xk4nX2WJ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755834823; x=1787370823;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=u8SNYrGup52raExP3z9rP7SKIxp+epvEHd3pHNXU0to=;
  b=Xk4nX2WJMw4hEZb0kV/iJQz3w+chReBeWDhaPdCNrqBXAlH7ob8Wl4nR
   B/wUB0G7nwtv0l4fQ3NcxE7AyM4sda8WqosVX7akOqZxNn6qjsjSb1aBT
   1s+RuNEIbWguHRTj7jZ7RYLMSEvDSAjdlhMGxztMFEBU66NBZSr04oYfW
   gRLs1D1eBH1gheyzuf43laDYsEs6qy6f0puPyNNUtD5PuSfmraNRSIwl9
   AbSM+DnZhv9ieUxNv4D2qX3OfxbdduEYycKZVoJofo4iFNsEfoLI90euG
   axfwRj39EaUmFzZratYNvesNwBYXIZfJ1eh8emaTAxYAx7XTQp41ozXy9
   Q==;
X-CSE-ConnectionGUID: ap8VzxYgSjy3I5fHqYnbGQ==
X-CSE-MsgGUID: jVvOS3VYQqq9E5VGJ4Owpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="69508577"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="69508577"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 20:53:41 -0700
X-CSE-ConnectionGUID: k8va8TyLRT6DS4pNs2lZyQ==
X-CSE-MsgGUID: sHVutkXBQRCYz/u/XC3qsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="192253212"
Received: from estantil-desk.jf.intel.com ([10.166.241.24])
  by fmviesa002.fm.intel.com with ESMTP; 21 Aug 2025 20:53:40 -0700
From: Emil Tantilov <emil.s.tantilov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Aleksandr.Loktionov@intel.com,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	decot@google.com,
	willemb@google.com,
	joshua.a.hay@intel.com,
	madhu.chittim@intel.com
Subject: [PATCH iwl-net 1/2] idpf: convert vport state to bitmap
Date: Thu, 21 Aug 2025 20:52:47 -0700
Message-Id: <20250822035248.22969-2-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20250822035248.22969-1-emil.s.tantilov@intel.com>
References: <20250822035248.22969-1-emil.s.tantilov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

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
---
 drivers/net/ethernet/intel/idpf/idpf.h        | 12 ++++------
 .../net/ethernet/intel/idpf/idpf_ethtool.c    | 10 ++++----
 drivers/net/ethernet/intel/idpf/idpf_lib.c    | 24 +++++++++----------
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   |  2 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  2 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  4 ++--
 6 files changed, 26 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index f4c0eaf9bde3..cfbf3a716f34 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -130,14 +130,12 @@ enum idpf_cap_field {
 
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
@@ -159,7 +157,7 @@ struct idpf_netdev_priv {
 	u32 link_speed_mbps;
 	u16 vport_idx;
 	u16 max_tx_hdr_size;
-	enum idpf_vport_state state;
+	DECLARE_BITMAP(state, IDPF_VPORT_STATE_NBITS);
 	struct rtnl_link_stats64 netstats;
 	spinlock_t stats_lock;
 };
diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
index 0eb812ac19c2..f84e247399a7 100644
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
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 513032cb5f08..89d30c395533 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -517,7 +517,7 @@ static int idpf_del_mac_filter(struct idpf_vport *vport,
 	}
 	spin_unlock_bh(&vport_config->mac_filter_list_lock);
 
-	if (np->state == __IDPF_VPORT_UP) {
+	if (test_bit(IDPF_VPORT_UP, np->state)) {
 		int err;
 
 		err = idpf_add_del_mac_filters(vport, np, false, async);
@@ -588,7 +588,7 @@ static int idpf_add_mac_filter(struct idpf_vport *vport,
 	if (err)
 		return err;
 
-	if (np->state == __IDPF_VPORT_UP)
+	if (test_bit(IDPF_VPORT_UP, np->state))
 		err = idpf_add_del_mac_filters(vport, np, true, async);
 
 	return err;
@@ -888,7 +888,7 @@ static void idpf_vport_stop(struct idpf_vport *vport)
 {
 	struct idpf_netdev_priv *np = netdev_priv(vport->netdev);
 
-	if (np->state <= __IDPF_VPORT_DOWN)
+	if (!test_bit(IDPF_VPORT_UP, np->state))
 		return;
 
 	netif_carrier_off(vport->netdev);
@@ -911,7 +911,7 @@ static void idpf_vport_stop(struct idpf_vport *vport)
 	idpf_vport_intr_deinit(vport);
 	idpf_vport_queues_rel(vport);
 	idpf_vport_intr_rel(vport);
-	np->state = __IDPF_VPORT_DOWN;
+	clear_bit(IDPF_VPORT_UP, np->state);
 }
 
 /**
@@ -1332,7 +1332,7 @@ static int idpf_up_complete(struct idpf_vport *vport)
 		netif_tx_start_all_queues(vport->netdev);
 	}
 
-	np->state = __IDPF_VPORT_UP;
+	set_bit(IDPF_VPORT_UP, np->state);
 
 	return 0;
 }
@@ -1377,7 +1377,7 @@ static int idpf_vport_open(struct idpf_vport *vport)
 	struct idpf_vport_config *vport_config;
 	int err;
 
-	if (np->state != __IDPF_VPORT_DOWN)
+	if (test_bit(IDPF_VPORT_UP, np->state))
 		return -EBUSY;
 
 	/* we do not allow interface up just yet */
@@ -1569,7 +1569,7 @@ void idpf_init_task(struct work_struct *work)
 
 	/* Once state is put into DOWN, driver is ready for dev_open */
 	np = netdev_priv(vport->netdev);
-	np->state = __IDPF_VPORT_DOWN;
+	clear_bit(IDPF_VPORT_UP, np->state);
 	if (test_and_clear_bit(IDPF_VPORT_UP_REQUESTED, vport_config->flags))
 		idpf_vport_open(vport);
 
@@ -1768,7 +1768,7 @@ static void idpf_set_vport_state(struct idpf_adapter *adapter)
 			continue;
 
 		np = netdev_priv(adapter->netdevs[i]);
-		if (np->state == __IDPF_VPORT_UP)
+		if (test_bit(IDPF_VPORT_UP, np->state))
 			set_bit(IDPF_VPORT_UP_REQUESTED,
 				adapter->vport_config[i]->flags);
 	}
@@ -1906,7 +1906,7 @@ int idpf_initiate_soft_reset(struct idpf_vport *vport,
 			     enum idpf_vport_reset_cause reset_cause)
 {
 	struct idpf_netdev_priv *np = netdev_priv(vport->netdev);
-	enum idpf_vport_state current_state = np->state;
+	bool vport_is_up = test_bit(IDPF_VPORT_UP, np->state);
 	struct idpf_adapter *adapter = vport->adapter;
 	struct idpf_vport *new_vport;
 	int err;
@@ -1957,7 +1957,7 @@ int idpf_initiate_soft_reset(struct idpf_vport *vport,
 		goto free_vport;
 	}
 
-	if (current_state <= __IDPF_VPORT_DOWN) {
+	if (!vport_is_up) {
 		idpf_send_delete_queues_msg(vport);
 	} else {
 		set_bit(IDPF_VPORT_DEL_QUEUES, vport->flags);
@@ -1990,7 +1990,7 @@ int idpf_initiate_soft_reset(struct idpf_vport *vport,
 	if (err)
 		goto err_open;
 
-	if (current_state == __IDPF_VPORT_UP)
+	if (vport_is_up)
 		err = idpf_vport_open(vport);
 
 	goto free_vport;
@@ -2000,7 +2000,7 @@ int idpf_initiate_soft_reset(struct idpf_vport *vport,
 				 vport->num_rxq, vport->num_bufq);
 
 err_open:
-	if (current_state == __IDPF_VPORT_UP)
+	if (vport_is_up)
 		idpf_vport_open(vport);
 
 free_vport:
diff --git a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
index b19b462e0bb6..06199fde3b57 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
@@ -571,7 +571,7 @@ static bool idpf_tx_singleq_clean(struct idpf_tx_queue *tx_q, int napi_budget,
 	np = netdev_priv(tx_q->netdev);
 	nq = netdev_get_tx_queue(tx_q->netdev, tx_q->idx);
 
-	dont_wake = np->state != __IDPF_VPORT_UP ||
+	dont_wake = !test_bit(IDPF_VPORT_UP, np->state) ||
 		    !netif_carrier_ok(tx_q->netdev);
 	__netif_txq_completed_wake(nq, ss.packets, ss.bytes,
 				   IDPF_DESC_UNUSED(tx_q), IDPF_TX_WAKE_THRESH,
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 68b3857c803b..b72d3e4d40f7 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -1868,7 +1868,7 @@ static bool idpf_tx_clean_complq(struct idpf_compl_queue *complq, int budget,
 		/* Update BQL */
 		nq = netdev_get_tx_queue(tx_q->netdev, tx_q->idx);
 
-		dont_wake = !complq_ok || np->state != __IDPF_VPORT_UP ||
+		dont_wake = !complq_ok || !test_bit(IDPF_VPORT_UP, np->state) ||
 			    !netif_carrier_ok(tx_q->netdev);
 		/* Check if the TXQ needs to and can be restarted */
 		__netif_txq_completed_wake(nq, tx_q->cleaned_pkts, tx_q->cleaned_bytes,
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 6330d4a0ae07..d751d40c4e46 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -68,7 +68,7 @@ static void idpf_handle_event_link(struct idpf_adapter *adapter,
 
 	vport->link_up = v2e->link_status;
 
-	if (np->state != __IDPF_VPORT_UP)
+	if (!test_bit(IDPF_VPORT_UP, np->state))
 		return;
 
 	if (vport->link_up) {
@@ -2432,7 +2432,7 @@ int idpf_send_get_stats_msg(struct idpf_vport *vport)
 
 
 	/* Don't send get_stats message if the link is down */
-	if (np->state <= __IDPF_VPORT_DOWN)
+	if (!test_bit(IDPF_VPORT_UP, np->state))
 		return 0;
 
 	stats_msg.vport_id = cpu_to_le32(vport->vport_id);
-- 
2.37.3


