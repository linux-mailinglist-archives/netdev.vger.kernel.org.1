Return-Path: <netdev+bounces-130335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE4198A1F4
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 14:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1BBB1C2237C
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 12:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AC11922C4;
	Mon, 30 Sep 2024 12:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qkw4eEoP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E87A191F87
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 12:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727698244; cv=none; b=K0jSKHSXMpb+8YpMI795Qc4F4WFdYsCnNpkowa1s1uIa8AkV++y4zxw6Jrd3GPObRPQ6FF7TrsG/vOXvP6tDR7XQO8HScIp7BOwws7Y4Dgx/MeCJ6PhiQMdnO/av5L7J5ZEe1Kd0vU3E4tyPoKqMiawsQxrrWrjx8bCVMvWIGBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727698244; c=relaxed/simple;
	bh=ZJV8Tlz9StKSoK6ZtN2Dg+AWqHr48ypwb2sSLfvlL9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ca2AD90/IBppTG5PStVCNW+RX2nn9JhdiprrJy9dIWj0ESPcth36uuf/T/5ENvaE3lDQsOZV1le0e734KU7ztXDecwoX1T8ZZ36here4uIesA2+uNOUwGQb+Fic1PQaEQm+70yv7lkzRLdd7OApzm5+bDCsTP4NgnrIE5ZbeztQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qkw4eEoP; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727698243; x=1759234243;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZJV8Tlz9StKSoK6ZtN2Dg+AWqHr48ypwb2sSLfvlL9I=;
  b=Qkw4eEoP53GlID01q2Uer3llsqxd2rdIqdl5Bj1PUM+DPykIN4TOIKzI
   syPkNKfcvB9TJJ3FE8LQ8HRawRkTuSuOxkB3d4xk0c0y3BCpsVUNpJ/i7
   +a7Jx4MHTgdZbucqleAa8/+kb2R5JrBqGxbu/7RhyewLABiOhk57rSmqA
   2fb0nFCE+zF0dytpzkNBJzDxL7ZenNMuvHQONquHwqiXwF62KlLBUJ81l
   z6kJ308pgbdsBK2MnDrGbi8nVtyrw781FT4XZ7sd2CWCOQMEQSNONWpWh
   qn23cws0Lcmqb5vZEJklSvq0e76SEDypIqppTXS1HPadg0aGl1Q/AmA3Y
   Q==;
X-CSE-ConnectionGUID: Kyy2JFKlSZ2EYQRk+XLOWA==
X-CSE-MsgGUID: FHsBhzT6RHqTeWFATyLxbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="26736097"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="26736097"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 05:10:43 -0700
X-CSE-ConnectionGUID: gP3T805/SMW+q7XsPlGIEg==
X-CSE-MsgGUID: JNchkILfQcmCwO0bBd2zvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="78037030"
Received: from kkolacin-desk1.igk.intel.com ([10.217.160.108])
  by orviesa005.jf.intel.com with ESMTP; 30 Sep 2024 05:10:41 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Arkadiusz Kubalewski <Arkadiusz.kubalewski@intel.com>
Subject: [PATCH iwl-net 5/5] ice: Add correct PHY lane assignment
Date: Mon, 30 Sep 2024 14:08:43 +0200
Message-ID: <20240930121022.671217-6-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240930121022.671217-1-karol.kolacinski@intel.com>
References: <20240930121022.671217-1-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Driver always naively assumes, that for PTP purposes, PHY lane to
configure is corresponding to PF ID.

This is not true for some port configurations, e.g.:
- 2x50G per quad, where lanes used are 0 and 2 on each quad, but PF IDs
  are 0 and 1
- 100G per quad on 2 quads, where lanes used are 0 and 4, but PF IDs are
  0 and 1

Use correct PHY lane assignment by getting and parsing port options.
This is read from the NVM by the FW and provided to the driver with
the indication of active port split.

Remove ice_is_muxed_topo(), which is no longer needed.

Fixes: 4409ea1726cb ("ice: Adjust PTP init for 2x50G E825C devices")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Arkadiusz Kubalewski <Arkadiusz.kubalewski@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 40 +++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_common.h |  1 +
 drivers/net/ethernet/intel/ice/ice_main.c   |  6 ++--
 drivers/net/ethernet/intel/ice/ice_ptp.c    | 23 +++++-------
 drivers/net/ethernet/intel/ice/ice_ptp.h    |  4 +--
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 22 ------------
 drivers/net/ethernet/intel/ice/ice_type.h   |  1 -
 7 files changed, 55 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 0eb7f828ed3a..618259f8abdc 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -4065,6 +4065,46 @@ ice_aq_set_port_option(struct ice_hw *hw, u8 lport, u8 lport_valid,
 	return ice_aq_send_cmd(hw, &desc, NULL, 0, NULL);
 }
 
+/**
+ * ice_get_phy_lane_number - Get PHY lane number for current adapter
+ * @hw: pointer to the hw struct
+ *
+ * Return: PHY lane number on success, negative error code otherwise.
+ */
+int ice_get_phy_lane_number(struct ice_hw *hw)
+{
+	struct ice_aqc_get_port_options_elem *options __free(kfree);
+	unsigned int lport = 0;
+	unsigned int lane;
+	int err;
+
+	options = kcalloc(ICE_AQC_PORT_OPT_MAX, sizeof(*options), GFP_KERNEL);
+	if (!options)
+		return -ENOMEM;
+
+	for (lane = 0; lane < ICE_MAX_PORT_PER_PCI_DEV; lane++) {
+		u8 options_count = ICE_AQC_PORT_OPT_MAX;
+		bool active_valid, pending_valid;
+		u8 active_idx, pending_idx;
+
+		err = ice_aq_get_port_options(hw, options, &options_count, lane,
+					      true, &active_idx, &active_valid,
+					      &pending_idx, &pending_valid);
+		if (err)
+			return err;
+
+		if (!active_valid)
+			continue;
+
+		if (hw->pf_id == lport)
+			return lane;
+		lport++;
+	}
+
+	/* PHY lane not found */
+	return -ENXIO;
+}
+
 /**
  * ice_aq_sff_eeprom
  * @hw: pointer to the HW struct
diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index 27208a60cece..fe6f88cfd948 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -193,6 +193,7 @@ ice_aq_get_port_options(struct ice_hw *hw,
 int
 ice_aq_set_port_option(struct ice_hw *hw, u8 lport, u8 lport_valid,
 		       u8 new_option);
+int ice_get_phy_lane_number(struct ice_hw *hw);
 int
 ice_aq_sff_eeprom(struct ice_hw *hw, u16 lport, u8 bus_addr,
 		  u16 mem_addr, u8 page, u8 set_page, u8 *data, u8 length,
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 09d1a4eb5716..8863137e767e 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1162,7 +1162,7 @@ ice_link_event(struct ice_pf *pf, struct ice_port_info *pi, bool link_up,
 	if (link_up == old_link && link_speed == old_link_speed)
 		return 0;
 
-	ice_ptp_link_change(pf, pf->hw.pf_id, link_up);
+	ice_ptp_link_change(pf, link_up);
 
 	if (ice_is_dcb_active(pf)) {
 		if (test_bit(ICE_FLAG_DCB_ENA, pf->flags))
@@ -6760,7 +6760,7 @@ static int ice_up_complete(struct ice_vsi *vsi)
 		ice_print_link_msg(vsi, true);
 		netif_tx_start_all_queues(vsi->netdev);
 		netif_carrier_on(vsi->netdev);
-		ice_ptp_link_change(pf, pf->hw.pf_id, true);
+		ice_ptp_link_change(pf, true);
 	}
 
 	/* Perform an initial read of the statistics registers now to
@@ -7230,7 +7230,7 @@ int ice_down(struct ice_vsi *vsi)
 
 	if (vsi->netdev) {
 		vlan_err = ice_vsi_del_vlan_zero(vsi);
-		ice_ptp_link_change(vsi->back, vsi->back->hw.pf_id, false);
+		ice_ptp_link_change(vsi->back, false);
 		netif_carrier_off(vsi->netdev);
 		netif_tx_disable(vsi->netdev);
 	}
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 956d5e21e261..2eef72bf654a 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1454,10 +1454,9 @@ ice_ptp_port_phy_restart(struct ice_ptp_port *ptp_port)
 /**
  * ice_ptp_link_change - Reconfigure PTP after link status change
  * @pf: Board private structure
- * @port: Port for which the PHY start is set
  * @linkup: Link is up or down
  */
-void ice_ptp_link_change(struct ice_pf *pf, u8 port, bool linkup)
+void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
 {
 	struct ice_ptp_port *ptp_port;
 	struct ice_hw *hw = &pf->hw;
@@ -1465,14 +1464,7 @@ void ice_ptp_link_change(struct ice_pf *pf, u8 port, bool linkup)
 	if (pf->ptp.state != ICE_PTP_READY)
 		return;
 
-	if (WARN_ON_ONCE(port >= hw->ptp.num_lports))
-		return;
-
 	ptp_port = &pf->ptp.port;
-	if (ice_is_e825c(hw) && hw->ptp.is_2x50g_muxed_topo)
-		port *= 2;
-	if (WARN_ON_ONCE(ptp_port->port_num != port))
-		return;
 
 	/* Update cached link status for this port immediately */
 	ptp_port->link_up = linkup;
@@ -3339,10 +3331,17 @@ void ice_ptp_init(struct ice_pf *pf)
 {
 	struct ice_ptp *ptp = &pf->ptp;
 	struct ice_hw *hw = &pf->hw;
-	int err;
+	int lane_num, err;
 
 	ptp->state = ICE_PTP_INITIALIZING;
 
+	lane_num = ice_get_phy_lane_number(hw);
+	if (lane_num < 0) {
+		err = lane_num;
+		goto err;
+	}
+
+	ptp->port.port_num = (u8)lane_num;
 	ice_ptp_init_hw(hw);
 
 	ice_ptp_init_tx_interrupt_mode(pf);
@@ -3356,10 +3355,6 @@ void ice_ptp_init(struct ice_pf *pf)
 			goto err;
 	}
 
-	ptp->port.port_num = hw->pf_id;
-	if (ice_is_e825c(hw) && hw->ptp.is_2x50g_muxed_topo)
-		ptp->port.port_num = hw->pf_id * 2;
-
 	err = ice_ptp_init_port(pf, &ptp->port);
 	if (err)
 		goto err;
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index 3a61ea09f406..bc2992cac20f 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -330,7 +330,7 @@ void ice_ptp_prepare_for_reset(struct ice_pf *pf,
 			       enum ice_reset_req reset_type);
 void ice_ptp_init(struct ice_pf *pf);
 void ice_ptp_release(struct ice_pf *pf);
-void ice_ptp_link_change(struct ice_pf *pf, u8 port, bool linkup);
+void ice_ptp_link_change(struct ice_pf *pf, bool linkup);
 #else /* IS_ENABLED(CONFIG_PTP_1588_CLOCK) */
 static inline int ice_ptp_set_ts_config(struct ice_pf *pf, struct ifreq *ifr)
 {
@@ -378,7 +378,7 @@ static inline void ice_ptp_prepare_for_reset(struct ice_pf *pf,
 }
 static inline void ice_ptp_init(struct ice_pf *pf) { }
 static inline void ice_ptp_release(struct ice_pf *pf) { }
-static inline void ice_ptp_link_change(struct ice_pf *pf, u8 port, bool linkup)
+static inline void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
 {
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 4979633cab98..3fb26d8dbcc8 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -2674,26 +2674,6 @@ static int ice_get_phy_tx_tstamp_ready_eth56g(struct ice_hw *hw, u8 port,
 	return 0;
 }
 
-/**
- * ice_is_muxed_topo - detect breakout 2x50G topology for E825C
- * @hw: pointer to the HW struct
- *
- * Return: true if it's 2x50 breakout topology, false otherwise
- */
-static bool ice_is_muxed_topo(struct ice_hw *hw)
-{
-	u8 link_topo;
-	bool mux;
-	u32 val;
-
-	val = rd32(hw, GLGEN_SWITCH_MODE_CONFIG);
-	mux = FIELD_GET(GLGEN_SWITCH_MODE_CONFIG_25X4_QUAD_M, val);
-	val = rd32(hw, GLGEN_MAC_LINK_TOPO);
-	link_topo = FIELD_GET(GLGEN_MAC_LINK_TOPO_LINK_TOPO_M, val);
-
-	return (mux && link_topo == ICE_LINK_TOPO_UP_TO_2_LINKS);
-}
-
 /**
  * ice_ptp_init_phy_e825 - initialize PHY parameters
  * @hw: pointer to the HW struct
@@ -2717,8 +2697,6 @@ static void ice_ptp_init_phy_e825(struct ice_hw *hw)
 	err = ice_read_phy_eth56g(hw, hw->pf_id, PHY_REG_REVISION, &phy_rev);
 	if (err || phy_rev != PHY_REVISION_ETH56G)
 		ptp->phy_model = ICE_PHY_UNSUP;
-
-	ptp->is_2x50g_muxed_topo = ice_is_muxed_topo(hw);
 }
 
 /* E822 family functions
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 479227bdff75..609f31e0dfde 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -880,7 +880,6 @@ struct ice_ptp_hw {
 	union ice_phy_params phy;
 	u8 num_lports;
 	u8 ports_per_phy;
-	bool is_2x50g_muxed_topo;
 };
 
 /* Port hardware description */
-- 
2.46.1


