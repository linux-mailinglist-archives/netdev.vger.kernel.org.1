Return-Path: <netdev+bounces-85671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC51D89BD0C
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 12:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4469D1F22DAA
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 10:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0CB537E0;
	Mon,  8 Apr 2024 10:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B1Wd4xKE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEE4535C8
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 10:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712571989; cv=none; b=leKtRL6PMMqikd5lIbzxAWA/asxCvg9+AOByolAC9wui5GRxzOSnVPJPPL6UkUWPZLoO3ghkwQ6MP87UPKvFyxB/QEp0utBTn76fYP+ZWV9euPBYuJv+VgedJ9lGgFyGh5IemlOm2D3OgV3o/qMM40Qnu11hdOol2Iy55+6BLXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712571989; c=relaxed/simple;
	bh=DmHCHej35FjKJFaofsoziev1DDoRSek/JObUPUMPKT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KRPPdd+36gSD5+LiTzEwZq1/Zhs/CvH+bopUCgbGbDnPKQiEQj5oVXnf9Q63yhrMqitPhzTcebBL2zE6ZnqYDcRGoD8nGKF/U/ZunfVr5J7q7XaONcoEa2Ck3bdECgEIy1Dh9Hxztf9Xi0312IyH+Qe4AT6Iy7F5IjBp11rup9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B1Wd4xKE; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712571987; x=1744107987;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DmHCHej35FjKJFaofsoziev1DDoRSek/JObUPUMPKT8=;
  b=B1Wd4xKEQOI5oWncdIBRc3nPRa9MLU/BC1qCgCIl2AA7Im89526u7hmO
   8p2kPmZ2DcoGWDiS49+TTGPjR38AfLlrOAfrYhfrHmeE7qoZNrsFtgyEN
   275WAqX9WaQIWr415MMDyNAtspxLqEKiwVEVGMJBM38/apZKOUHQMWXTg
   3pG222mIZh/B6NoIpphoIumLM4s0qE4JwrS776ABD0G+1GvhthTMUMdUs
   jsW+QR+iGOAnpBY6p3hpdBgMh5RZ5yn00FbWAe42a3KGxUYkW6mmUgMog
   Sdt/cjSe157YGP/pv6ADZJDkCM2OzKkrd8MaS73lzkQX7DzWXEOlrkXMV
   g==;
X-CSE-ConnectionGUID: LqoowaXyS0ijwKcLyzfa4g==
X-CSE-MsgGUID: sxFvCkQER3+ajQhZ2D+4WQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="7944147"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="7944147"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 03:26:27 -0700
X-CSE-ConnectionGUID: 9KbS35IsR4WejakIgWyKNg==
X-CSE-MsgGUID: Ue+QjBNVQGWvD6iyhXacqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="19758537"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by orviesa009.jf.intel.com with ESMTP; 08 Apr 2024 03:26:25 -0700
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
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	Piotr Raczynski <piotr.raczynski@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [iwl-next v1 2/7] ice: export ice ndo_ops functions
Date: Mon,  8 Apr 2024 12:30:44 +0200
Message-ID: <20240408103049.19445-3-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240408103049.19445-1-michal.swiatkowski@linux.intel.com>
References: <20240408103049.19445-1-michal.swiatkowski@linux.intel.com>
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
index 67a3236ab1fc..5f7757a44b72 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -982,6 +982,14 @@ void ice_unload(struct ice_pf *pf);
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
index 06909bf3b517..cff0bb6ba428 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2846,6 +2846,28 @@ void ice_vsi_set_napi_queues(struct ice_vsi *vsi)
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
index 9cd23afe5f15..a57213062b7f 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_lib.h
@@ -90,6 +90,7 @@ void __ice_q_vector_set_napi_queues(struct ice_q_vector *q_vector, bool locked);
 void ice_q_vector_set_napi_queues(struct ice_q_vector *q_vector);
 
 void ice_vsi_set_napi_queues(struct ice_vsi *vsi);
+void ice_napi_add(struct ice_vsi *vsi);
 
 int ice_vsi_release(struct ice_vsi *vsi);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 8a4d9029434f..058d2a8836b0 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3059,7 +3059,7 @@ static int ice_xdp_safe_mode(struct net_device __always_unused *dev,
  * @dev: netdevice
  * @xdp: XDP command
  */
-static int ice_xdp(struct net_device *dev, struct netdev_bpf *xdp)
+int ice_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 {
 	struct ice_netdev_priv *np = netdev_priv(dev);
 	struct ice_vsi *vsi = np->vsi;
@@ -3518,28 +3518,6 @@ static int ice_req_irq_msix_misc(struct ice_pf *pf)
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
@@ -3573,7 +3551,7 @@ static void ice_set_ops(struct ice_vsi *vsi)
  * ice_set_netdev_features - set features for the given netdev
  * @netdev: netdev instance
  */
-static void ice_set_netdev_features(struct net_device *netdev)
+void ice_set_netdev_features(struct net_device *netdev)
 {
 	struct ice_pf *pf = ice_netdev_to_pf(netdev);
 	bool is_dvm_ena = ice_is_dvm_ena(&pf->hw);
@@ -3755,8 +3733,7 @@ ice_lb_vsi_setup(struct ice_pf *pf, struct ice_port_info *pi)
  *
  * net_device_ops implementation for adding VLAN IDs
  */
-static int
-ice_vlan_rx_add_vid(struct net_device *netdev, __be16 proto, u16 vid)
+int ice_vlan_rx_add_vid(struct net_device *netdev, __be16 proto, u16 vid)
 {
 	struct ice_netdev_priv *np = netdev_priv(netdev);
 	struct ice_vsi_vlan_ops *vlan_ops;
@@ -3818,8 +3795,7 @@ ice_vlan_rx_add_vid(struct net_device *netdev, __be16 proto, u16 vid)
  *
  * net_device_ops implementation for removing VLAN IDs
  */
-static int
-ice_vlan_rx_kill_vid(struct net_device *netdev, __be16 proto, u16 vid)
+int ice_vlan_rx_kill_vid(struct net_device *netdev, __be16 proto, u16 vid)
 {
 	struct ice_netdev_priv *np = netdev_priv(netdev);
 	struct ice_vsi_vlan_ops *vlan_ops;
@@ -7052,7 +7028,6 @@ void ice_update_pf_stats(struct ice_pf *pf)
  * @netdev: network interface device structure
  * @stats: main device statistics structure
  */
-static
 void ice_get_stats64(struct net_device *netdev, struct rtnl_link_stats64 *stats)
 {
 	struct ice_netdev_priv *np = netdev_priv(netdev);
@@ -7725,7 +7700,7 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
  *
  * Returns 0 on success, negative on failure
  */
-static int ice_change_mtu(struct net_device *netdev, int new_mtu)
+int ice_change_mtu(struct net_device *netdev, int new_mtu)
 {
 	struct ice_netdev_priv *np = netdev_priv(netdev);
 	struct ice_vsi *vsi = np->vsi;
@@ -8149,7 +8124,7 @@ ice_bridge_setlink(struct net_device *dev, struct nlmsghdr *nlh,
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


