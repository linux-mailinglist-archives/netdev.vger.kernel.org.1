Return-Path: <netdev+bounces-81771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5C488B153
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 21:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFBD41FA0388
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 20:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB56548F0;
	Mon, 25 Mar 2024 20:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SzJ+SQZT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0509524DC
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 20:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711398398; cv=none; b=DxGWGpABgg+hHK6S314HLLCSrJnuEBm39d09zdtMRG0le18yQ1tjk5BWq6r9dw65aCy/zY6958/KdP2wpI1Pxa52ggxGO0Jh+BXm1paafQsGKh+eGp8wu1FhJCXh/5Iwh2qtM6q/xZjaxMg6NqvkKlNsX+ZwKXW+h2aD6oQ1JjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711398398; c=relaxed/simple;
	bh=sYhQrUjvIUPEh/tpZGn6dL1DPKyA3rRCX7jE9td8FLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IKrD78Qb6xx1/XPMTRbsZS3J5qYinvAkt/CAprJ3FwpxM1DKU29b8Ai62D3D5u9+94NSTh5wedXtxj9Wo886/4Ik5VzsE27ghdvE/KxEUS4XfCzcVGxTQItANmjGxS27Waet6opsufeDQigLjo9vBlgPLBNWn7SjfW4Fupr19kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SzJ+SQZT; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711398397; x=1742934397;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sYhQrUjvIUPEh/tpZGn6dL1DPKyA3rRCX7jE9td8FLQ=;
  b=SzJ+SQZTpd6V7CAwLhMdOOp+O5D2r+L35h8cbwqg/x+GKkOdJAdfxhfP
   Zijm1KO8nqwIWAN02GJ8HWT/tgiHQWOKy2AOL/LhwTz7zT9bM63oOSvab
   iMMSO+ISKzEwMHvdm6PxU1iM5eJ5VZ4cMCcQq44U4Z7w5ns0TeVxFLN5H
   2N1fpATZjx00BvGhHTe2rSbHxDS2yWkBjwyx7WtyiPpllSZWkEsNqqf7H
   UbEawfGPMawkLgAgbOOvFSZOFyue9hPmLC6hWk9kqBVk5dfV/r9vix0sK
   ZM1TvNalnpFBz5s+S69ThtWisd7TpOXg3KOP171jIxtJYfd0Fy5p3y/aE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="10219668"
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="10219668"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 13:26:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="15787384"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 25 Mar 2024 13:26:32 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net-next 7/8] ice: do switchdev slow-path Rx using PF VSI
Date: Mon, 25 Mar 2024 13:26:15 -0700
Message-ID: <20240325202623.1012287-8-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240325202623.1012287-1-anthony.l.nguyen@intel.com>
References: <20240325202623.1012287-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Add an ICE_RX_FLAG_MULTIDEV flag to Rx ring.

If it is set try to find correct port representor. Do it based on
src_vsi value stored in flex descriptor. Ids of representor pointers
stored in xarray are equal to corresponding src_vsi value. Thanks to
that we can directly get correct representor if we have src_vsi value.

Set multidev flag during ring configuration.

If the mode is switchdev, change the ring descriptor to the one that
contains src_vsi value.

PF netdev should be reconfigured, do it by calling ice_down() and
ice_up() if the netdev was up before configuring switchdev.

Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_base.c     |  8 +++++
 drivers/net/ethernet/intel/ice/ice_eswitch.c  | 36 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_eswitch.h  |  9 +++++
 drivers/net/ethernet/intel/ice/ice_txrx.h     |  1 +
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c |  9 ++++-
 5 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 8ffae7fe894f..662fc395edcc 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -452,6 +452,14 @@ static int ice_setup_rx_ctx(struct ice_rx_ring *ring)
 	/* Rx queue threshold in units of 64 */
 	rlan_ctx.lrxqthresh = 1;
 
+	/* PF acts as uplink for switchdev; set flex descriptor with src_vsi
+	 * metadata and flags to allow redirecting to PR netdev
+	 */
+	if (ice_is_eswitch_mode_switchdev(vsi->back)) {
+		ring->flags |= ICE_RX_FLAGS_MULTIDEV;
+		rxdid = ICE_RXDID_FLEX_NIC_2;
+	}
+
 	/* Enable Flexible Descriptors in the queue context which
 	 * allows this driver to select a specific receive descriptor format
 	 * increasing context priority to pick up profile ID; default is 0x01;
diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index 5eba8dec9f94..86a6d58ad3ec 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -21,8 +21,13 @@ static int ice_eswitch_setup_env(struct ice_pf *pf)
 {
 	struct ice_vsi *uplink_vsi = pf->eswitch.uplink_vsi;
 	struct net_device *netdev = uplink_vsi->netdev;
+	bool if_running = netif_running(netdev);
 	struct ice_vsi_vlan_ops *vlan_ops;
 
+	if (if_running && !test_and_set_bit(ICE_VSI_DOWN, uplink_vsi->state))
+		if (ice_down(uplink_vsi))
+			return -ENODEV;
+
 	ice_remove_vsi_fltr(&pf->hw, uplink_vsi->idx);
 
 	netif_addr_lock_bh(netdev);
@@ -51,8 +56,13 @@ static int ice_eswitch_setup_env(struct ice_pf *pf)
 	if (ice_vsi_update_local_lb(uplink_vsi, true))
 		goto err_override_local_lb;
 
+	if (if_running && ice_up(uplink_vsi))
+		goto err_up;
+
 	return 0;
 
+err_up:
+	ice_vsi_update_local_lb(uplink_vsi, false);
 err_override_local_lb:
 	ice_vsi_update_security(uplink_vsi, ice_vsi_ctx_clear_allow_override);
 err_override_uplink:
@@ -69,6 +79,9 @@ static int ice_eswitch_setup_env(struct ice_pf *pf)
 	ice_fltr_add_mac_and_broadcast(uplink_vsi,
 				       uplink_vsi->port_info->mac.perm_addr,
 				       ICE_FWD_TO_VSI);
+	if (if_running)
+		ice_up(uplink_vsi);
+
 	return -ENODEV;
 }
 
@@ -493,3 +506,26 @@ void ice_eswitch_rebuild(struct ice_pf *pf)
 	xa_for_each(&pf->eswitch.reprs, id, repr)
 		ice_eswitch_detach(pf, repr->vf);
 }
+
+/**
+ * ice_eswitch_get_target - get netdev based on src_vsi from descriptor
+ * @rx_ring: ring used to receive the packet
+ * @rx_desc: descriptor used to get src_vsi value
+ *
+ * Get src_vsi value from descriptor and load correct representor. If it isn't
+ * found return rx_ring->netdev.
+ */
+struct net_device *ice_eswitch_get_target(struct ice_rx_ring *rx_ring,
+					  union ice_32b_rx_flex_desc *rx_desc)
+{
+	struct ice_eswitch *eswitch = &rx_ring->vsi->back->eswitch;
+	struct ice_32b_rx_flex_desc_nic_2 *desc;
+	struct ice_repr *repr;
+
+	desc = (struct ice_32b_rx_flex_desc_nic_2 *)rx_desc;
+	repr = xa_load(&eswitch->reprs, le16_to_cpu(desc->src_vsi));
+	if (!repr)
+		return rx_ring->netdev;
+
+	return repr->netdev;
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.h b/drivers/net/ethernet/intel/ice/ice_eswitch.h
index baad68507471..e2e5c0c75e7d 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.h
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.h
@@ -26,6 +26,8 @@ void ice_eswitch_set_target_vsi(struct sk_buff *skb,
 				struct ice_tx_offload_params *off);
 netdev_tx_t
 ice_eswitch_port_start_xmit(struct sk_buff *skb, struct net_device *netdev);
+struct net_device *ice_eswitch_get_target(struct ice_rx_ring *rx_ring,
+					  union ice_32b_rx_flex_desc *rx_desc);
 #else /* CONFIG_ICE_SWITCHDEV */
 static inline void ice_eswitch_detach(struct ice_pf *pf, struct ice_vf *vf) { }
 
@@ -76,5 +78,12 @@ ice_eswitch_port_start_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
 	return NETDEV_TX_BUSY;
 }
+
+static inline struct net_device *
+ice_eswitch_get_target(struct ice_rx_ring *rx_ring,
+		       union ice_32b_rx_flex_desc *rx_desc)
+{
+	return rx_ring->netdev;
+}
 #endif /* CONFIG_ICE_SWITCHDEV */
 #endif /* _ICE_ESWITCH_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index af955b0e5dc5..feba314a3fe4 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -365,6 +365,7 @@ struct ice_rx_ring {
 	u8 ptp_rx;
 #define ICE_RX_FLAGS_RING_BUILD_SKB	BIT(1)
 #define ICE_RX_FLAGS_CRC_STRIP_DIS	BIT(2)
+#define ICE_RX_FLAGS_MULTIDEV		BIT(3)
 	u8 flags;
 	/* CL5 - 5th cacheline starts here */
 	struct xdp_rxq_info xdp_rxq;
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
index f8f1d2bdc1be..676c00e1554c 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
@@ -236,7 +236,14 @@ ice_process_skb_fields(struct ice_rx_ring *rx_ring,
 	ice_rx_hash_to_skb(rx_ring, rx_desc, skb, ptype);
 
 	/* modifies the skb - consumes the enet header */
-	skb->protocol = eth_type_trans(skb, rx_ring->netdev);
+	if (unlikely(rx_ring->flags & ICE_RX_FLAGS_MULTIDEV)) {
+		struct net_device *netdev = ice_eswitch_get_target(rx_ring,
+								   rx_desc);
+
+		skb->protocol = eth_type_trans(skb, netdev);
+	} else {
+		skb->protocol = eth_type_trans(skb, rx_ring->netdev);
+	}
 
 	ice_rx_csum(rx_ring, skb, rx_desc, ptype);
 
-- 
2.41.0


