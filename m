Return-Path: <netdev+bounces-100142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 328138D7F51
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 11:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0032285CD7
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 09:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABF1823C3;
	Mon,  3 Jun 2024 09:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mSan70zK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFF97E0F1
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 09:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407936; cv=none; b=M9K2/3zJt/JbVNLAGLJLxfbqDiZvIvjxTcuVtfe5BKPmfj/4lPgee9WvvfeU/XzBRWcMoricVJyFunDbLmqOCvN270nv6HOTyjaOj42MfzEMN6i7IgNNzsMJcCpablCYK2/T6udHFfFPw9vEdcwNQpvAC5tjxHaYQacPioJfh1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407936; c=relaxed/simple;
	bh=FrM+LnPK5vpXv1EJj9dDklG9vqueGXra6+Gj7Mx/vJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jCd5svx9f1LHaO16jNQ3qCGnFzx9PJlbs3Z0c+hYc8edo03c2mMFQfYAQc7tX/79YmYFGiWXynKqwLpQAmSA1QkmAbhV6PFQXClOYdO1UkLfSc3qgDBUxNIeJrt+ZTpKVikMYRiPcy/MtbgwpJ9YnJuI7aE+yRPHQBpXkqXoJ/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mSan70zK; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717407935; x=1748943935;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FrM+LnPK5vpXv1EJj9dDklG9vqueGXra6+Gj7Mx/vJ4=;
  b=mSan70zKOriU4h+6GXj6MokA4UZvkykBL6h8201Z8O41joz05tk1Sn3F
   Z/NEElw2CKt0DDVU0sFr84nyjZlbnFVCevceRNxbaOHSk7/84vS/TVKvH
   EsSTkOImhRzeT5RkL8NqSMUio8HSTUtBTEr4fmdQu859zVu+24PNf3vY3
   Zvx1IT/alkHONtPmHzQ6dC9+/D+RtuxD0KvBPoICmpqhXYxcDfbwD+sOR
   C4ZBzSng9M2WaP9Q4j0jncb20CPhkU5etTfpt3fg4wsPK/dazoqTdo46X
   Dlh0BgNPJ5tuhOdKlA7aJ/5jK353J3eMKXwfzRhnffmVZjvUpAEakTboH
   A==;
X-CSE-ConnectionGUID: YzOQ1rg1SUy+Ev0pXffYuQ==
X-CSE-MsgGUID: jV8fG9+jSzegt+z6IxzHFw==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="17732660"
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; 
   d="scan'208";a="17732660"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 02:45:34 -0700
X-CSE-ConnectionGUID: iJhETCh/TmWb2ZcZEoR2OQ==
X-CSE-MsgGUID: lp5DYenDTUKc71VsxsLRUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; 
   d="scan'208";a="37448174"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by orviesa007.jf.intel.com with ESMTP; 03 Jun 2024 02:45:31 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	jacob.e.keller@intel.com,
	michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com,
	sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com,
	wojciech.drewek@intel.com,
	pio.raczynski@gmail.com,
	jiri@nvidia.com,
	mateusz.polchlopek@intel.com,
	shayd@nvidia.com,
	kalesh-anakkur.purayil@broadcom.com,
	horms@kernel.org
Subject: [iwl-next v4 02/15] ice: export ice ndo_ops functions
Date: Mon,  3 Jun 2024 11:50:12 +0200
Message-ID: <20240603095025.1395347-3-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240603095025.1395347-1-michal.swiatkowski@linux.intel.com>
References: <20240603095025.1395347-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Piotr Raczynski <piotr.raczynski@intel.com>

Make some of the netdevice_ops functions visible from outside for
another VSI type created netdev.

Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h      |  8 +++++
 drivers/net/ethernet/intel/ice/ice_lib.c  | 22 ++++++++++++++
 drivers/net/ethernet/intel/ice/ice_lib.h  |  1 +
 drivers/net/ethernet/intel/ice/ice_main.c | 37 ++++-------------------
 4 files changed, 37 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index da8c8afebc93..06e556884e3c 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -1002,6 +1002,14 @@ void ice_unload(struct ice_pf *pf);
 void ice_adv_lnk_speed_maps_init(void);
 int ice_init_dev(struct ice_pf *pf);
 void ice_deinit_dev(struct ice_pf *pf);
+int ice_change_mtu(struct net_device *netdev, int new_mtu);
+void ice_tx_timeout(struct net_device *netdev, unsigned int txqueue);
+int ice_xdp(struct net_device *dev, struct netdev_bpf *xdp);
+void ice_set_netdev_features(struct net_device *netdev);
+int ice_vlan_rx_add_vid(struct net_device *netdev, __be16 proto, u16 vid);
+int ice_vlan_rx_kill_vid(struct net_device *netdev, __be16 proto, u16 vid);
+void ice_get_stats64(struct net_device *netdev,
+		     struct rtnl_link_stats64 *stats);
 
 /**
  * ice_set_rdma_cap - enable RDMA support
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index be1e65bafe13..56bbc3ebf9dc 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2831,6 +2831,28 @@ void ice_vsi_set_napi_queues(struct ice_vsi *vsi)
 		ice_q_vector_set_napi_queues(vsi->q_vectors[i]);
 }
 
+/**
+ * ice_napi_add - register NAPI handler for the VSI
+ * @vsi: VSI for which NAPI handler is to be registered
+ *
+ * This function is only called in the driver's load path. Registering the NAPI
+ * handler is done in ice_vsi_alloc_q_vector() for all other cases (i.e. resume,
+ * reset/rebuild, etc.)
+ */
+void ice_napi_add(struct ice_vsi *vsi)
+{
+	int v_idx;
+
+	if (!vsi->netdev)
+		return;
+
+	ice_for_each_q_vector(vsi, v_idx) {
+		netif_napi_add(vsi->netdev, &vsi->q_vectors[v_idx]->napi,
+			       ice_napi_poll);
+		__ice_q_vector_set_napi_queues(vsi->q_vectors[v_idx], false);
+	}
+}
+
 /**
  * ice_vsi_release - Delete a VSI and free its resources
  * @vsi: the VSI being removed
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
index 94ce8964dda6..f9ee461c5c06 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_lib.h
@@ -53,6 +53,7 @@ void __ice_q_vector_set_napi_queues(struct ice_q_vector *q_vector, bool locked);
 void ice_q_vector_set_napi_queues(struct ice_q_vector *q_vector);
 
 void ice_vsi_set_napi_queues(struct ice_vsi *vsi);
+void ice_napi_add(struct ice_vsi *vsi);
 
 int ice_vsi_release(struct ice_vsi *vsi);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index d05a875b81fe..2529fbd11663 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3080,7 +3080,7 @@ static int ice_xdp_safe_mode(struct net_device __always_unused *dev,
  * @dev: netdevice
  * @xdp: XDP command
  */
-static int ice_xdp(struct net_device *dev, struct netdev_bpf *xdp)
+int ice_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 {
 	struct ice_netdev_priv *np = netdev_priv(dev);
 	struct ice_vsi *vsi = np->vsi;
@@ -3539,28 +3539,6 @@ static int ice_req_irq_msix_misc(struct ice_pf *pf)
 	return 0;
 }
 
-/**
- * ice_napi_add - register NAPI handler for the VSI
- * @vsi: VSI for which NAPI handler is to be registered
- *
- * This function is only called in the driver's load path. Registering the NAPI
- * handler is done in ice_vsi_alloc_q_vector() for all other cases (i.e. resume,
- * reset/rebuild, etc.)
- */
-static void ice_napi_add(struct ice_vsi *vsi)
-{
-	int v_idx;
-
-	if (!vsi->netdev)
-		return;
-
-	ice_for_each_q_vector(vsi, v_idx) {
-		netif_napi_add(vsi->netdev, &vsi->q_vectors[v_idx]->napi,
-			       ice_napi_poll);
-		__ice_q_vector_set_napi_queues(vsi->q_vectors[v_idx], false);
-	}
-}
-
 /**
  * ice_set_ops - set netdev and ethtools ops for the given netdev
  * @vsi: the VSI associated with the new netdev
@@ -3594,7 +3572,7 @@ static void ice_set_ops(struct ice_vsi *vsi)
  * ice_set_netdev_features - set features for the given netdev
  * @netdev: netdev instance
  */
-static void ice_set_netdev_features(struct net_device *netdev)
+void ice_set_netdev_features(struct net_device *netdev)
 {
 	struct ice_pf *pf = ice_netdev_to_pf(netdev);
 	bool is_dvm_ena = ice_is_dvm_ena(&pf->hw);
@@ -3776,8 +3754,7 @@ ice_lb_vsi_setup(struct ice_pf *pf, struct ice_port_info *pi)
  *
  * net_device_ops implementation for adding VLAN IDs
  */
-static int
-ice_vlan_rx_add_vid(struct net_device *netdev, __be16 proto, u16 vid)
+int ice_vlan_rx_add_vid(struct net_device *netdev, __be16 proto, u16 vid)
 {
 	struct ice_netdev_priv *np = netdev_priv(netdev);
 	struct ice_vsi_vlan_ops *vlan_ops;
@@ -3839,8 +3816,7 @@ ice_vlan_rx_add_vid(struct net_device *netdev, __be16 proto, u16 vid)
  *
  * net_device_ops implementation for removing VLAN IDs
  */
-static int
-ice_vlan_rx_kill_vid(struct net_device *netdev, __be16 proto, u16 vid)
+int ice_vlan_rx_kill_vid(struct net_device *netdev, __be16 proto, u16 vid)
 {
 	struct ice_netdev_priv *np = netdev_priv(netdev);
 	struct ice_vsi_vlan_ops *vlan_ops;
@@ -7079,7 +7055,6 @@ void ice_update_pf_stats(struct ice_pf *pf)
  * @netdev: network interface device structure
  * @stats: main device statistics structure
  */
-static
 void ice_get_stats64(struct net_device *netdev, struct rtnl_link_stats64 *stats)
 {
 	struct ice_netdev_priv *np = netdev_priv(netdev);
@@ -7752,7 +7727,7 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
  *
  * Returns 0 on success, negative on failure
  */
-static int ice_change_mtu(struct net_device *netdev, int new_mtu)
+int ice_change_mtu(struct net_device *netdev, int new_mtu)
 {
 	struct ice_netdev_priv *np = netdev_priv(netdev);
 	struct ice_vsi *vsi = np->vsi;
@@ -8176,7 +8151,7 @@ ice_bridge_setlink(struct net_device *dev, struct nlmsghdr *nlh,
  * @netdev: network interface device structure
  * @txqueue: Tx queue
  */
-static void ice_tx_timeout(struct net_device *netdev, unsigned int txqueue)
+void ice_tx_timeout(struct net_device *netdev, unsigned int txqueue)
 {
 	struct ice_netdev_priv *np = netdev_priv(netdev);
 	struct ice_tx_ring *tx_ring = NULL;
-- 
2.42.0


