Return-Path: <netdev+bounces-65885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 062DE83C2D0
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 13:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B1471C22641
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 12:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6414F5F4;
	Thu, 25 Jan 2024 12:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gdsjhHND"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5BB4F5EC
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 12:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706186969; cv=none; b=uXrkeEuJn5YyGCYPD3POgCL2yXy8m8vWplUqw0LgzmRdyGeAnBTYYju1RO1ox8OcyWQGUcphtMyPVyFKrBzKhYCri9L5JCMDwgwZWoTsfZklVRff3lPdL369qJXhv6YHCUh1pT/6a7sS1NBF9hjuqaMn67hE3JphH1dfemZRwOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706186969; c=relaxed/simple;
	bh=VQdVFoi0gt9nEkcTJn4vcT1uCfZwtfWsRDWT0A0xvIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kWmFLc99JZEvSxhHnw4APy0VXGqzoyWDh6BVilv3eXxUC3up93n9lmvps6uCp59HyncbMoESPS398o7dUWmcV8SfVUZmR4Xip+aoa7rZwabNOvEKFVnDe0ImGXypIIXI2LwHnWkSeKaX34lt9dDbd52jtnyeTgjpwKuBpFlpI0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gdsjhHND; arc=none smtp.client-ip=192.55.52.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706186967; x=1737722967;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VQdVFoi0gt9nEkcTJn4vcT1uCfZwtfWsRDWT0A0xvIM=;
  b=gdsjhHNDF8daMa+6QNqHj1citeQjZwUq2+kAsPfEKhsDp3o6ZXLB7c8t
   wQsTWY08aCcyOnaRb09bxuivuOr45BAfCav0VSqJ2ikAqCeFJj2Ny259I
   aK6E1evCz4IW6k4nftcuwvQRUxRJU+2PwZx+O3zpP4/pExgkflMXHFA16
   YEVqolJUn0pQmYymg9QUq/ho3Wg6j0nlBn4FMQMBDCVrXfg2ZuH27Cbxl
   ppyIm7MsP5IO9B5NIvg6JfNed6Z4HOTYInF2EBqpic5VMZTzMwak0kWkF
   EttmCVgCtAt7pznNrfeg8fwMxeEI26IFf/5eEP3FfGzM28zpwVTo3Xv8c
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="399313544"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="399313544"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 04:49:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="905956695"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="905956695"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by fmsmga002.fm.intel.com with ESMTP; 25 Jan 2024 04:49:23 -0800
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	marcin.szycik@intel.com,
	wojciech.drewek@intel.com,
	sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: [iwl-next v1 7/8] ice: do switchdev slow-path Rx using PF VSI
Date: Thu, 25 Jan 2024 13:53:13 +0100
Message-ID: <20240125125314.852914-8-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240125125314.852914-1-michal.swiatkowski@linux.intel.com>
References: <20240125125314.852914-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 drivers/net/ethernet/intel/ice/ice_base.c     |  8 +++++
 drivers/net/ethernet/intel/ice/ice_eswitch.c  | 36 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_eswitch.h  |  9 +++++
 drivers/net/ethernet/intel/ice/ice_txrx.h     |  1 +
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c |  8 ++++-
 5 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 81081258bf13..df2e3eb87b2e 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -454,6 +454,14 @@ static int ice_setup_rx_ctx(struct ice_rx_ring *ring)
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
index b3379ff73674..4c57f5c0b979 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -364,6 +364,7 @@ struct ice_rx_ring {
 	u8 ptp_rx;
 #define ICE_RX_FLAGS_RING_BUILD_SKB	BIT(1)
 #define ICE_RX_FLAGS_CRC_STRIP_DIS	BIT(2)
+#define ICE_RX_FLAGS_MULTIDEV		BIT(3)
 	u8 flags;
 	/* CL5 - 5th cacheline starts here */
 	struct xdp_rxq_info xdp_rxq;
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
index f8f1d2bdc1be..0a6cdfd393b5 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
@@ -236,7 +236,13 @@ ice_process_skb_fields(struct ice_rx_ring *rx_ring,
 	ice_rx_hash_to_skb(rx_ring, rx_desc, skb, ptype);
 
 	/* modifies the skb - consumes the enet header */
-	skb->protocol = eth_type_trans(skb, rx_ring->netdev);
+	if (unlikely(rx_ring->flags & ICE_RX_FLAGS_MULTIDEV)) {
+		struct net_device *netdev = ice_eswitch_get_target(rx_ring,
+								   rx_desc);
+		skb->protocol = eth_type_trans(skb, netdev);
+	} else {
+		skb->protocol = eth_type_trans(skb, rx_ring->netdev);
+	}
 
 	ice_rx_csum(rx_ring, skb, rx_desc, ptype);
 
-- 
2.42.0


