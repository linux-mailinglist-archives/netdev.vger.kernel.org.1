Return-Path: <netdev+bounces-71198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D958529BC
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 08:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2084E1F23CD0
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 07:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53019175AC;
	Tue, 13 Feb 2024 07:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YgUoflYO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB501774C
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 07:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707808999; cv=none; b=HiwG2b1HT0gK1yAi+zcwUAKddm2YMfCYYz3XVS+ghq4fYZ7nlnwCcpC0qbOcwTLSnc+V9kdaEpwg3t936lIq1J2pvkw/fS1OyQ22ziTJ80sCCrMumceiffSH68zY/AW5IZuPIDi1dy5ptVTJKaIPv4lZQgmJk3zAnIeVdPuwAlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707808999; c=relaxed/simple;
	bh=FuuWI0Rx75drGyeFBtXL3ZGV/i870mvEkoffL+SClWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hUW98GWQXJ/JiACaBcajncZOCFL2AQh0wn+yicIBt2kAg0w1Of9jWXnUep388O0pPt3SlVNtI4MhP+KEb0xA9Zl2tUTkY9MK1WyPaX0cJhT7Q3rTV5PdUpMDIuOJTiXW9+XoBqHo4Lr4D5o1fc1FOrkHykSBiP6JwjBwgdzmxCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YgUoflYO; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707808997; x=1739344997;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FuuWI0Rx75drGyeFBtXL3ZGV/i870mvEkoffL+SClWs=;
  b=YgUoflYOpUMPZF7w087fABs1KN6weAKMI9mm0L2JiP7bqQb0APz5IShB
   QoD9CwFY1SKUa2WiQp6gC4daTqhrup6VnbV2HswvnHUfrUdKSQpDgXsPL
   kC9DH/gdy4KeoHOH3vkp7CY9L7r0pKyZQrOe1Ti0+UTb/MtTpcWAyx86t
   b3TNfV1TSNgZlVcW/lYsJRQRODgeg0tctZ21odGzHB8z/ZI8gbHHIUJgp
   +eikJCsakt1/MtR4sOJjcae3lTheI6bfcR9dhqq/JEVRr28Vxl+zDaRb7
   5e0bltSH5SKxpggixx4OZMyDdAtCZxkNnVUE9buQwp8ciO67xu/7vc5IS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="27247945"
X-IronPort-AV: E=Sophos;i="6.06,156,1705392000"; 
   d="scan'208";a="27247945"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 23:23:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,156,1705392000"; 
   d="scan'208";a="7385222"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by fmviesa003.fm.intel.com with ESMTP; 12 Feb 2024 23:23:14 -0800
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
	Piotr Raczynski <piotr.raczynski@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [iwl-next v1 03/15] ice: export ice ndo_ops functions
Date: Tue, 13 Feb 2024 08:27:12 +0100
Message-ID: <20240213072724.77275-4-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240213072724.77275-1-michal.swiatkowski@linux.intel.com>
References: <20240213072724.77275-1-michal.swiatkowski@linux.intel.com>
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
index c4127d5f2be3..c40fc339a604 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -979,6 +979,14 @@ void ice_unload(struct ice_pf *pf);
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
index 572d9b345f66..8706d0589caa 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2812,6 +2812,28 @@ void ice_vsi_set_napi_queues(struct ice_vsi *vsi, bool locked)
 		ice_q_vector_set_napi_queues(vsi->q_vectors[i], locked);
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
+		ice_q_vector_set_napi_queues(vsi->q_vectors[v_idx], false);
+	}
+}
+
 /**
  * ice_vsi_release - Delete a VSI and free its resources
  * @vsi: the VSI being removed
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
index 0c77d581416a..aa3a85d31f95 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_lib.h
@@ -84,6 +84,7 @@ ice_vsi_setup(struct ice_pf *pf, struct ice_vsi_cfg_params *params);
 void ice_q_vector_set_napi_queues(struct ice_q_vector *q_vector, bool locked);
 
 void ice_vsi_set_napi_queues(struct ice_vsi *vsi, bool locked);
+void ice_napi_add(struct ice_vsi *vsi);
 
 int ice_vsi_release(struct ice_vsi *vsi);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index ebab03b16596..b0f6a11ae744 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3024,7 +3024,7 @@ static int ice_xdp_safe_mode(struct net_device __always_unused *dev,
  * @dev: netdevice
  * @xdp: XDP command
  */
-static int ice_xdp(struct net_device *dev, struct netdev_bpf *xdp)
+int ice_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 {
 	struct ice_netdev_priv *np = netdev_priv(dev);
 	struct ice_vsi *vsi = np->vsi;
@@ -3483,28 +3483,6 @@ static int ice_req_irq_msix_misc(struct ice_pf *pf)
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
-		ice_q_vector_set_napi_queues(vsi->q_vectors[v_idx], false);
-	}
-}
-
 /**
  * ice_set_ops - set netdev and ethtools ops for the given netdev
  * @vsi: the VSI associated with the new netdev
@@ -3538,7 +3516,7 @@ static void ice_set_ops(struct ice_vsi *vsi)
  * ice_set_netdev_features - set features for the given netdev
  * @netdev: netdev instance
  */
-static void ice_set_netdev_features(struct net_device *netdev)
+void ice_set_netdev_features(struct net_device *netdev)
 {
 	struct ice_pf *pf = ice_netdev_to_pf(netdev);
 	bool is_dvm_ena = ice_is_dvm_ena(&pf->hw);
@@ -3720,8 +3698,7 @@ ice_lb_vsi_setup(struct ice_pf *pf, struct ice_port_info *pi)
  *
  * net_device_ops implementation for adding VLAN IDs
  */
-static int
-ice_vlan_rx_add_vid(struct net_device *netdev, __be16 proto, u16 vid)
+int ice_vlan_rx_add_vid(struct net_device *netdev, __be16 proto, u16 vid)
 {
 	struct ice_netdev_priv *np = netdev_priv(netdev);
 	struct ice_vsi_vlan_ops *vlan_ops;
@@ -3783,8 +3760,7 @@ ice_vlan_rx_add_vid(struct net_device *netdev, __be16 proto, u16 vid)
  *
  * net_device_ops implementation for removing VLAN IDs
  */
-static int
-ice_vlan_rx_kill_vid(struct net_device *netdev, __be16 proto, u16 vid)
+int ice_vlan_rx_kill_vid(struct net_device *netdev, __be16 proto, u16 vid)
 {
 	struct ice_netdev_priv *np = netdev_priv(netdev);
 	struct ice_vsi_vlan_ops *vlan_ops;
@@ -6945,7 +6921,6 @@ void ice_update_pf_stats(struct ice_pf *pf)
  * @netdev: network interface device structure
  * @stats: main device statistics structure
  */
-static
 void ice_get_stats64(struct net_device *netdev, struct rtnl_link_stats64 *stats)
 {
 	struct ice_netdev_priv *np = netdev_priv(netdev);
@@ -7574,7 +7549,7 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
  *
  * Returns 0 on success, negative on failure
  */
-static int ice_change_mtu(struct net_device *netdev, int new_mtu)
+int ice_change_mtu(struct net_device *netdev, int new_mtu)
 {
 	struct ice_netdev_priv *np = netdev_priv(netdev);
 	struct ice_vsi *vsi = np->vsi;
@@ -7999,7 +7974,7 @@ ice_bridge_setlink(struct net_device *dev, struct nlmsghdr *nlh,
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


