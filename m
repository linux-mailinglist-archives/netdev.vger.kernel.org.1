Return-Path: <netdev+bounces-257640-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBgILHsqhmm1KAQAu9opvQ
	(envelope-from <netdev+bounces-257640-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 18:52:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CED1017E0
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 18:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E108F300FEC1
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 17:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F75426D1B;
	Fri,  6 Feb 2026 17:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TPqykP6N"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AC5426682;
	Fri,  6 Feb 2026 17:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770400158; cv=none; b=qI0eIG15X5J7e5lG6jlC1sbd/cHBa8kPdpycysI/e0k4bUL+xaJ7NxYVzTvnidaUm5RA4nYJ3uR1gCzmeEm/g/BxPTunmyVV43DOsk3qQZe4U7VxmaJ7X3jUDJqHwwp8ObYYmFFraMli5Go4jF6//pfvHD5DmWn3dpPw+hB6aBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770400158; c=relaxed/simple;
	bh=OZM+zQ7qxeMuShjql7IXVFPhyJFwF0yFWS0NvowNTXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DnCtRw6/cde2II/QRQkGLjVIbT28garfuq+avQHjkQhoCAwrTezOKU0oCwQVa8jCAoVpZEgxFMn3Qe72ZuWS6TZ4MOna/MLOTG38SgP3S/SlpVMLW2sJQnQrqzpuGrFlMvYMHP7Y6rXi8HyI0FiHkeWXRfOJr5YccIGoHTLZvx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TPqykP6N; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770400159; x=1801936159;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OZM+zQ7qxeMuShjql7IXVFPhyJFwF0yFWS0NvowNTXY=;
  b=TPqykP6NCYy06uCwHEQrUSvpJhhUyUSKg/5jBeuJ14MGub1EVM4sZ2tr
   mgQSjsPZDx+0Ktthb4uslsUM2WF8G+o13s/kWJcbk9TH/h4wZZo+ZzL38
   0GPsT4uY3qaO4P51rpkCOg9zxHcIwZv/WVGzhJwGPDbnGOD/cYhvuiUp5
   SzDI5IEHLrZWFH8Bu7/5Xkc4h0Aei2rmdV4jf0XNoqly6MzyRiWHYKrE0
   gVEeatRcXoQZNVOd+YQKKhZoOp45UJ/nGGeruTFLpdF1mL9KNbfSbEuJB
   C1V6mWdCrE/D9WkYAH62NoiLj6gfVTartCcEZ7KdiANseje8PmAyQLj1Y
   w==;
X-CSE-ConnectionGUID: pIiXopIJSIm3GujlH0LWqg==
X-CSE-MsgGUID: N40DnUtwTcymVe2TtzX3Gw==
X-IronPort-AV: E=McAfee;i="6800,10657,11693"; a="71793114"
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; 
   d="scan'208";a="71793114"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 09:49:18 -0800
X-CSE-ConnectionGUID: sWd6tsIYRP621hX5W18OEQ==
X-CSE-MsgGUID: GSvWiWLoQJa/PELDRHhxXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; 
   d="scan'208";a="215495402"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 06 Feb 2026 09:49:17 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	nxne.cnse.osdt.itp.upstreaming@intel.com,
	horms@kernel.org,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	bpf@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Alexander Nowlin <alexander.nowlin@intel.com>
Subject: [PATCH net-next 3/9] ice: migrate to netdev ops lock
Date: Fri,  6 Feb 2026 09:49:00 -0800
Message-ID: <20260206174910.4066255-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260206174910.4066255-1-anthony.l.nguyen@intel.com>
References: <20260206174910.4066255-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-257640-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 10CED1017E0
X-Rspamd-Action: no action

From: Alexander Lobakin <aleksander.lobakin@intel.com>

Queue management ops unconditionally enable netdev locking. The same
lock is taken by default by several NAPI configuration functions,
such as napi_enable() and netif_napi_set_irq().
Request ops locking in advance and make sure we use the _locked
counterparts of those functions to avoid deadlocks, taking the lock
manually where needed (suspend/resume, queue rebuild and resets).

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_base.c   |  63 ++++++--
 drivers/net/ethernet/intel/ice/ice_base.h   |   2 +
 drivers/net/ethernet/intel/ice/ice_lib.c    | 150 +++++++++++++++++---
 drivers/net/ethernet/intel/ice/ice_lib.h    |   7 +-
 drivers/net/ethernet/intel/ice/ice_main.c   |  54 ++++---
 drivers/net/ethernet/intel/ice/ice_sf_eth.c |   1 +
 drivers/net/ethernet/intel/ice/ice_xsk.c    |   4 +-
 7 files changed, 225 insertions(+), 56 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 1b7d10fad4f2..f084b1c48e5d 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -153,8 +153,8 @@ static int ice_vsi_alloc_q_vector(struct ice_vsi *vsi, u16 v_idx)
 	 * handler here (i.e. resume, reset/rebuild, etc.)
 	 */
 	if (vsi->netdev)
-		netif_napi_add_config(vsi->netdev, &q_vector->napi,
-				      ice_napi_poll, v_idx);
+		netif_napi_add_config_locked(vsi->netdev, &q_vector->napi,
+					     ice_napi_poll, v_idx);
 
 out:
 	/* tie q_vector and VSI together */
@@ -196,7 +196,7 @@ static void ice_free_q_vector(struct ice_vsi *vsi, int v_idx)
 
 	/* only VSI with an associated netdev is set up with NAPI */
 	if (vsi->netdev)
-		netif_napi_del(&q_vector->napi);
+		netif_napi_del_locked(&q_vector->napi);
 
 	/* release MSIX interrupt if q_vector had interrupt allocated */
 	if (q_vector->irq.index < 0)
@@ -896,13 +896,15 @@ int ice_vsi_wait_one_rx_ring(struct ice_vsi *vsi, bool ena, u16 rxq_idx)
 }
 
 /**
- * ice_vsi_alloc_q_vectors - Allocate memory for interrupt vectors
+ * ice_vsi_alloc_q_vectors_locked - Allocate memory for interrupt vectors
  * @vsi: the VSI being configured
  *
- * We allocate one q_vector per queue interrupt. If allocation fails we
- * return -ENOMEM.
+ * Should be called only under the netdev lock.
+ * We allocate one q_vector per queue interrupt.
+ *
+ * Return: 0 on success, -ENOMEM if allocation fails.
  */
-int ice_vsi_alloc_q_vectors(struct ice_vsi *vsi)
+int ice_vsi_alloc_q_vectors_locked(struct ice_vsi *vsi)
 {
 	struct device *dev = ice_pf_to_dev(vsi->back);
 	u16 v_idx;
@@ -929,6 +931,30 @@ int ice_vsi_alloc_q_vectors(struct ice_vsi *vsi)
 	return v_idx ? 0 : err;
 }
 
+/**
+ * ice_vsi_alloc_q_vectors - Allocate memory for interrupt vectors
+ * @vsi: the VSI being configured
+ *
+ * We allocate one q_vector per queue interrupt.
+ *
+ * Return: 0 on success, -ENOMEM if allocation fails.
+ */
+int ice_vsi_alloc_q_vectors(struct ice_vsi *vsi)
+{
+	struct net_device *dev = vsi->netdev;
+	int ret;
+
+	if (dev)
+		netdev_lock(dev);
+
+	ret = ice_vsi_alloc_q_vectors_locked(vsi);
+
+	if (dev)
+		netdev_unlock(dev);
+
+	return ret;
+}
+
 /**
  * ice_vsi_map_rings_to_vectors - Map VSI rings to interrupt vectors
  * @vsi: the VSI being configured
@@ -992,10 +1018,12 @@ void ice_vsi_map_rings_to_vectors(struct ice_vsi *vsi)
 }
 
 /**
- * ice_vsi_free_q_vectors - Free memory allocated for interrupt vectors
+ * ice_vsi_free_q_vectors_locked - Free memory allocated for interrupt vectors
  * @vsi: the VSI having memory freed
+ *
+ * Should be called only under the netdev lock.
  */
-void ice_vsi_free_q_vectors(struct ice_vsi *vsi)
+void ice_vsi_free_q_vectors_locked(struct ice_vsi *vsi)
 {
 	int v_idx;
 
@@ -1005,6 +1033,23 @@ void ice_vsi_free_q_vectors(struct ice_vsi *vsi)
 	vsi->num_q_vectors = 0;
 }
 
+/**
+ * ice_vsi_free_q_vectors - Free memory allocated for interrupt vectors
+ * @vsi: the VSI having memory freed
+ */
+void ice_vsi_free_q_vectors(struct ice_vsi *vsi)
+{
+	struct net_device *dev = vsi->netdev;
+
+	if (dev)
+		netdev_lock(dev);
+
+	ice_vsi_free_q_vectors_locked(vsi);
+
+	if (dev)
+		netdev_unlock(dev);
+}
+
 /**
  * ice_cfg_tstamp - Configure Tx time stamp queue
  * @tx_ring: Tx ring to be configured with timestamping
diff --git a/drivers/net/ethernet/intel/ice/ice_base.h b/drivers/net/ethernet/intel/ice/ice_base.h
index d28294247599..99b2c7232829 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.h
+++ b/drivers/net/ethernet/intel/ice/ice_base.h
@@ -12,8 +12,10 @@ int __ice_vsi_get_qs(struct ice_qs_cfg *qs_cfg);
 int
 ice_vsi_ctrl_one_rx_ring(struct ice_vsi *vsi, bool ena, u16 rxq_idx, bool wait);
 int ice_vsi_wait_one_rx_ring(struct ice_vsi *vsi, bool ena, u16 rxq_idx);
+int ice_vsi_alloc_q_vectors_locked(struct ice_vsi *vsi);
 int ice_vsi_alloc_q_vectors(struct ice_vsi *vsi);
 void ice_vsi_map_rings_to_vectors(struct ice_vsi *vsi);
+void ice_vsi_free_q_vectors_locked(struct ice_vsi *vsi);
 void ice_vsi_free_q_vectors(struct ice_vsi *vsi);
 int ice_vsi_cfg_single_txq(struct ice_vsi *vsi, struct ice_tx_ring **tx_rings,
 			   u16 q_idx);
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index d921269e1fe7..98009de08bfb 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2308,10 +2308,14 @@ static int ice_vsi_cfg_tc_lan(struct ice_pf *pf, struct ice_vsi *vsi)
 }
 
 /**
- * ice_vsi_cfg_def - configure default VSI based on the type
+ * ice_vsi_cfg_def_locked - configure default VSI based on the type
  * @vsi: pointer to VSI
+ *
+ * Should be called only with the netdev lock taken.
+ *
+ * Return: 0 on success, -errno on failure.
  */
-static int ice_vsi_cfg_def(struct ice_vsi *vsi)
+static int ice_vsi_cfg_def_locked(struct ice_vsi *vsi)
 {
 	struct device *dev = ice_pf_to_dev(vsi->back);
 	struct ice_pf *pf = vsi->back;
@@ -2354,7 +2358,7 @@ static int ice_vsi_cfg_def(struct ice_vsi *vsi)
 	case ICE_VSI_CTRL:
 	case ICE_VSI_SF:
 	case ICE_VSI_PF:
-		ret = ice_vsi_alloc_q_vectors(vsi);
+		ret = ice_vsi_alloc_q_vectors_locked(vsi);
 		if (ret)
 			goto unroll_vsi_init;
 
@@ -2404,7 +2408,7 @@ static int ice_vsi_cfg_def(struct ice_vsi *vsi)
 		 * creates a VSI and corresponding structures for bookkeeping
 		 * purpose
 		 */
-		ret = ice_vsi_alloc_q_vectors(vsi);
+		ret = ice_vsi_alloc_q_vectors_locked(vsi);
 		if (ret)
 			goto unroll_vsi_init;
 
@@ -2460,6 +2464,28 @@ static int ice_vsi_cfg_def(struct ice_vsi *vsi)
 	return ret;
 }
 
+/**
+ * ice_vsi_cfg_def - configure default VSI based on the type
+ * @vsi: pointer to VSI
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+static int ice_vsi_cfg_def(struct ice_vsi *vsi)
+{
+	struct net_device *dev = vsi->netdev;
+	int ret;
+
+	if (dev)
+		netdev_lock(dev);
+
+	ret = ice_vsi_cfg_def_locked(vsi);
+
+	if (dev)
+		netdev_unlock(dev);
+
+	return ret;
+}
+
 /**
  * ice_vsi_cfg - configure a previously allocated VSI
  * @vsi: pointer to VSI
@@ -2494,10 +2520,12 @@ int ice_vsi_cfg(struct ice_vsi *vsi)
 }
 
 /**
- * ice_vsi_decfg - remove all VSI configuration
+ * ice_vsi_decfg_locked - remove all VSI configuration
  * @vsi: pointer to VSI
+ *
+ * Should be called only under the netdev lock.
  */
-void ice_vsi_decfg(struct ice_vsi *vsi)
+static void ice_vsi_decfg_locked(struct ice_vsi *vsi)
 {
 	struct ice_pf *pf = vsi->back;
 	int err;
@@ -2515,7 +2543,7 @@ void ice_vsi_decfg(struct ice_vsi *vsi)
 		ice_destroy_xdp_rings(vsi, ICE_XDP_CFG_PART);
 
 	ice_vsi_clear_rings(vsi);
-	ice_vsi_free_q_vectors(vsi);
+	ice_vsi_free_q_vectors_locked(vsi);
 	ice_vsi_put_qs(vsi);
 	ice_vsi_free_arrays(vsi);
 
@@ -2530,6 +2558,23 @@ void ice_vsi_decfg(struct ice_vsi *vsi)
 		vsi->agg_node->num_vsis--;
 }
 
+/**
+ * ice_vsi_decfg - remove all VSI configuration
+ * @vsi: pointer to VSI
+ */
+void ice_vsi_decfg(struct ice_vsi *vsi)
+{
+	struct net_device *dev = vsi->netdev;
+
+	if (dev)
+		netdev_lock(dev);
+
+	ice_vsi_decfg_locked(vsi);
+
+	if (dev)
+		netdev_unlock(dev);
+}
+
 /**
  * ice_vsi_setup - Set up a VSI by a given type
  * @pf: board private structure
@@ -2703,7 +2748,7 @@ void ice_vsi_close(struct ice_vsi *vsi)
 	if (!test_and_set_bit(ICE_VSI_DOWN, vsi->state))
 		ice_down(vsi);
 
-	ice_vsi_clear_napi_queues(vsi);
+	ice_vsi_clear_napi_queues_locked(vsi);
 	ice_vsi_free_irq(vsi);
 	ice_vsi_free_tx_rings(vsi);
 	ice_vsi_free_rx_rings(vsi);
@@ -2772,12 +2817,13 @@ void ice_dis_vsi(struct ice_vsi *vsi, bool locked)
 }
 
 /**
- * ice_vsi_set_napi_queues - associate netdev queues with napi
+ * ice_vsi_set_napi_queues_locked - associate netdev queues with napi
  * @vsi: VSI pointer
  *
  * Associate queue[s] with napi for all vectors.
+ * Must be called only with the netdev_lock taken.
  */
-void ice_vsi_set_napi_queues(struct ice_vsi *vsi)
+void ice_vsi_set_napi_queues_locked(struct ice_vsi *vsi)
 {
 	struct net_device *netdev = vsi->netdev;
 	int q_idx, v_idx;
@@ -2785,7 +2831,6 @@ void ice_vsi_set_napi_queues(struct ice_vsi *vsi)
 	if (!netdev)
 		return;
 
-	ASSERT_RTNL();
 	ice_for_each_rxq(vsi, q_idx)
 		if (vsi->rx_rings[q_idx] && vsi->rx_rings[q_idx]->q_vector)
 			netif_queue_set_napi(netdev, q_idx, NETDEV_QUEUE_TYPE_RX,
@@ -2799,17 +2844,37 @@ void ice_vsi_set_napi_queues(struct ice_vsi *vsi)
 	ice_for_each_q_vector(vsi, v_idx) {
 		struct ice_q_vector *q_vector = vsi->q_vectors[v_idx];
 
-		netif_napi_set_irq(&q_vector->napi, q_vector->irq.virq);
+		netif_napi_set_irq_locked(&q_vector->napi, q_vector->irq.virq);
 	}
 }
 
 /**
- * ice_vsi_clear_napi_queues - dissociate netdev queues from napi
+ * ice_vsi_set_napi_queues - associate VSI queues with NAPIs
  * @vsi: VSI pointer
  *
+ * Version of ice_vsi_set_napi_queues_locked() that takes the netdev_lock,
+ * to use it outside of the net_device_ops context.
+ */
+void ice_vsi_set_napi_queues(struct ice_vsi *vsi)
+{
+	struct net_device *netdev = vsi->netdev;
+
+	if (!netdev)
+		return;
+
+	netdev_lock(netdev);
+	ice_vsi_set_napi_queues_locked(vsi);
+	netdev_unlock(netdev);
+}
+
+/**
+ * ice_vsi_clear_napi_queues_locked - dissociate netdev queues from napi
+ * @vsi: VSI to process
+ *
  * Clear the association between all VSI queues queue[s] and napi.
+ * Must be called only with the netdev_lock taken.
  */
-void ice_vsi_clear_napi_queues(struct ice_vsi *vsi)
+void ice_vsi_clear_napi_queues_locked(struct ice_vsi *vsi)
 {
 	struct net_device *netdev = vsi->netdev;
 	int q_idx, v_idx;
@@ -2817,12 +2882,11 @@ void ice_vsi_clear_napi_queues(struct ice_vsi *vsi)
 	if (!netdev)
 		return;
 
-	ASSERT_RTNL();
 	/* Clear the NAPI's interrupt number */
 	ice_for_each_q_vector(vsi, v_idx) {
 		struct ice_q_vector *q_vector = vsi->q_vectors[v_idx];
 
-		netif_napi_set_irq(&q_vector->napi, -1);
+		netif_napi_set_irq_locked(&q_vector->napi, -1);
 	}
 
 	ice_for_each_txq(vsi, q_idx)
@@ -2832,6 +2896,25 @@ void ice_vsi_clear_napi_queues(struct ice_vsi *vsi)
 		netif_queue_set_napi(netdev, q_idx, NETDEV_QUEUE_TYPE_RX, NULL);
 }
 
+/**
+ * ice_vsi_clear_napi_queues - dissociate VSI queues from NAPIs
+ * @vsi: VSI to process
+ *
+ * Version of ice_vsi_clear_napi_queues_locked() that takes the netdev lock,
+ * to use it outside of the net_device_ops context.
+ */
+void ice_vsi_clear_napi_queues(struct ice_vsi *vsi)
+{
+	struct net_device *netdev = vsi->netdev;
+
+	if (!netdev)
+		return;
+
+	netdev_lock(netdev);
+	ice_vsi_clear_napi_queues_locked(vsi);
+	netdev_unlock(netdev);
+}
+
 /**
  * ice_napi_add - register NAPI handler for the VSI
  * @vsi: VSI for which NAPI handler is to be registered
@@ -3069,16 +3152,17 @@ ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi)
 }
 
 /**
- * ice_vsi_rebuild - Rebuild VSI after reset
+ * ice_vsi_rebuild_locked - Rebuild VSI after reset
  * @vsi: VSI to be rebuild
  * @vsi_flags: flags used for VSI rebuild flow
  *
  * Set vsi_flags to ICE_VSI_FLAG_INIT to initialize a new VSI, or
  * ICE_VSI_FLAG_NO_INIT to rebuild an existing VSI in hardware.
+ * Should be called only under the netdev lock.
  *
  * Returns 0 on success and negative value on failure
  */
-int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags)
+int ice_vsi_rebuild_locked(struct ice_vsi *vsi, u32 vsi_flags)
 {
 	struct ice_coalesce_stored *coalesce;
 	int prev_num_q_vectors;
@@ -3099,8 +3183,8 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags)
 	if (ret)
 		goto unlock;
 
-	ice_vsi_decfg(vsi);
-	ret = ice_vsi_cfg_def(vsi);
+	ice_vsi_decfg_locked(vsi);
+	ret = ice_vsi_cfg_def_locked(vsi);
 	if (ret)
 		goto unlock;
 
@@ -3137,6 +3221,32 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags)
 	return ret;
 }
 
+/**
+ * ice_vsi_rebuild - Rebuild VSI after reset
+ * @vsi: VSI to be rebuild
+ * @vsi_flags: flags used for VSI rebuild flow
+ *
+ * Set vsi_flags to ICE_VSI_FLAG_INIT to initialize a new VSI, or
+ * ICE_VSI_FLAG_NO_INIT to rebuild an existing VSI in hardware.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags)
+{
+	struct net_device *dev = vsi->netdev;
+	int ret;
+
+	if (dev)
+		netdev_lock(dev);
+
+	ret = ice_vsi_rebuild_locked(vsi, vsi_flags);
+
+	if (dev)
+		netdev_unlock(dev);
+
+	return ret;
+}
+
 /**
  * ice_is_reset_in_progress - check for a reset in progress
  * @state: PF state field
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
index 49454d98dcfe..e55b72db72c4 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_lib.h
@@ -53,9 +53,11 @@ struct ice_vsi *
 ice_vsi_setup(struct ice_pf *pf, struct ice_vsi_cfg_params *params);
 
 void ice_vsi_set_napi_queues(struct ice_vsi *vsi);
-void ice_napi_add(struct ice_vsi *vsi);
-
+void ice_vsi_set_napi_queues_locked(struct ice_vsi *vsi);
 void ice_vsi_clear_napi_queues(struct ice_vsi *vsi);
+void ice_vsi_clear_napi_queues_locked(struct ice_vsi *vsi);
+
+void ice_napi_add(struct ice_vsi *vsi);
 
 int ice_vsi_release(struct ice_vsi *vsi);
 
@@ -66,6 +68,7 @@ int ice_ena_vsi(struct ice_vsi *vsi, bool locked);
 void ice_vsi_decfg(struct ice_vsi *vsi);
 void ice_dis_vsi(struct ice_vsi *vsi, bool locked);
 
+int ice_vsi_rebuild_locked(struct ice_vsi *vsi, u32 vsi_flags);
 int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags);
 int ice_vsi_cfg(struct ice_vsi *vsi);
 struct ice_vsi *ice_vsi_alloc(struct ice_pf *pf);
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 4da37caa3ec9..27ee7c1ee19c 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3525,6 +3525,7 @@ static void ice_set_ops(struct ice_vsi *vsi)
 	}
 
 	netdev->netdev_ops = &ice_netdev_ops;
+	netdev->request_ops_lock = true;
 	netdev->udp_tunnel_nic_info = &pf->hw.udp_tunnel_nic;
 	netdev->xdp_metadata_ops = &ice_xdp_md_ops;
 	ice_set_ethtool_ops(netdev);
@@ -4131,6 +4132,7 @@ bool ice_is_wol_supported(struct ice_hw *hw)
  * @locked: is adev device_lock held
  *
  * Only change the number of queues if new_tx, or new_rx is non-0.
+ * Note that it should be called only with the netdev lock taken.
  *
  * Returns 0 on success.
  */
@@ -4156,7 +4158,7 @@ int ice_vsi_recfg_qs(struct ice_vsi *vsi, int new_rx, int new_tx, bool locked)
 
 	/* set for the next time the netdev is started */
 	if (!netif_running(vsi->netdev)) {
-		err = ice_vsi_rebuild(vsi, ICE_VSI_FLAG_NO_INIT);
+		err = ice_vsi_rebuild_locked(vsi, ICE_VSI_FLAG_NO_INIT);
 		if (err)
 			goto rebuild_err;
 		dev_dbg(ice_pf_to_dev(pf), "Link is down, queue count change happens when link is brought up\n");
@@ -4164,7 +4166,7 @@ int ice_vsi_recfg_qs(struct ice_vsi *vsi, int new_rx, int new_tx, bool locked)
 	}
 
 	ice_vsi_close(vsi);
-	err = ice_vsi_rebuild(vsi, ICE_VSI_FLAG_NO_INIT);
+	err = ice_vsi_rebuild_locked(vsi, ICE_VSI_FLAG_NO_INIT);
 	if (err)
 		goto rebuild_err;
 
@@ -5534,16 +5536,17 @@ static int ice_reinit_interrupt_scheme(struct ice_pf *pf)
 
 	/* Remap vectors and rings, after successful re-init interrupts */
 	ice_for_each_vsi(pf, v) {
-		if (!pf->vsi[v])
+		struct ice_vsi *vsi = pf->vsi[v];
+
+		if (!vsi)
 			continue;
 
-		ret = ice_vsi_alloc_q_vectors(pf->vsi[v]);
+		ret = ice_vsi_alloc_q_vectors(vsi);
 		if (ret)
 			goto err_reinit;
-		ice_vsi_map_rings_to_vectors(pf->vsi[v]);
-		rtnl_lock();
-		ice_vsi_set_napi_queues(pf->vsi[v]);
-		rtnl_unlock();
+
+		ice_vsi_map_rings_to_vectors(vsi);
+		ice_vsi_set_napi_queues(vsi);
 	}
 
 	ret = ice_req_irq_msix_misc(pf);
@@ -5556,13 +5559,15 @@ static int ice_reinit_interrupt_scheme(struct ice_pf *pf)
 	return 0;
 
 err_reinit:
-	while (v--)
-		if (pf->vsi[v]) {
-			rtnl_lock();
-			ice_vsi_clear_napi_queues(pf->vsi[v]);
-			rtnl_unlock();
-			ice_vsi_free_q_vectors(pf->vsi[v]);
-		}
+	while (v--) {
+		struct ice_vsi *vsi = pf->vsi[v];
+
+		if (!vsi)
+			continue;
+
+		ice_vsi_clear_napi_queues(vsi);
+		ice_vsi_free_q_vectors(vsi);
+	}
 
 	return ret;
 }
@@ -5624,14 +5629,17 @@ static int ice_suspend(struct device *dev)
 	 * to CPU0.
 	 */
 	ice_free_irq_msix_misc(pf);
+
 	ice_for_each_vsi(pf, v) {
-		if (!pf->vsi[v])
+		struct ice_vsi *vsi = pf->vsi[v];
+
+		if (!vsi)
 			continue;
-		rtnl_lock();
-		ice_vsi_clear_napi_queues(pf->vsi[v]);
-		rtnl_unlock();
-		ice_vsi_free_q_vectors(pf->vsi[v]);
+
+		ice_vsi_clear_napi_queues(vsi);
+		ice_vsi_free_q_vectors(vsi);
 	}
+
 	ice_clear_interrupt_scheme(pf);
 
 	pci_save_state(pdev);
@@ -6759,7 +6767,7 @@ static void ice_napi_enable_all(struct ice_vsi *vsi)
 		ice_init_moderation(q_vector);
 
 		if (q_vector->rx.rx_ring || q_vector->tx.tx_ring)
-			napi_enable(&q_vector->napi);
+			napi_enable_locked(&q_vector->napi);
 	}
 }
 
@@ -7258,7 +7266,7 @@ static void ice_napi_disable_all(struct ice_vsi *vsi)
 		struct ice_q_vector *q_vector = vsi->q_vectors[q_idx];
 
 		if (q_vector->rx.rx_ring || q_vector->tx.tx_ring)
-			napi_disable(&q_vector->napi);
+			napi_disable_locked(&q_vector->napi);
 
 		cancel_work_sync(&q_vector->tx.dim.work);
 		cancel_work_sync(&q_vector->rx.dim.work);
@@ -7558,7 +7566,7 @@ int ice_vsi_open(struct ice_vsi *vsi)
 		if (err)
 			goto err_set_qs;
 
-		ice_vsi_set_napi_queues(vsi);
+		ice_vsi_set_napi_queues_locked(vsi);
 	}
 
 	err = ice_up_complete(vsi);
diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.c b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
index 1a2c94375ca7..2c3db1b03055 100644
--- a/drivers/net/ethernet/intel/ice/ice_sf_eth.c
+++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
@@ -58,6 +58,7 @@ static int ice_sf_cfg_netdev(struct ice_dynamic_port *dyn_port,
 	eth_hw_addr_set(netdev, dyn_port->hw_addr);
 	ether_addr_copy(netdev->perm_addr, dyn_port->hw_addr);
 	netdev->netdev_ops = &ice_sf_netdev_ops;
+	netdev->request_ops_lock = true;
 	SET_NETDEV_DEVLINK_PORT(netdev, devlink_port);
 
 	err = register_netdev(netdev);
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 953e68ed0f9a..6d08a11a86a8 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -33,9 +33,9 @@ ice_qvec_toggle_napi(struct ice_vsi *vsi, struct ice_q_vector *q_vector,
 		return;
 
 	if (enable)
-		napi_enable(&q_vector->napi);
+		napi_enable_locked(&q_vector->napi);
 	else
-		napi_disable(&q_vector->napi);
+		napi_disable_locked(&q_vector->napi);
 }
 
 /**
-- 
2.47.1


