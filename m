Return-Path: <netdev+bounces-34823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 156617A5516
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 23:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C30B5282009
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 21:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE9531A6B;
	Mon, 18 Sep 2023 21:28:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E541E2AB3D
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 21:28:50 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92314119
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 14:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695072528; x=1726608528;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SCV90KSJA2aF+Je+BSBKLye8flYVz5LWBWHjo/Ct7wM=;
  b=TJUXbXfDoWbIGLW56kN8bA6g9PFVPRqIqxE76cJmVsAAVw2j2n9uYz8F
   l6rYaIbVd+mR6v7q8GQzbfzbkSpzWEhqYGAJbABxkf8RGtDCsY0eP4baX
   gKPiE09gKsRmvdS7PTeDZd4M8nwZOpiBcnfp8JLEHBdw2KGnP1VWnksDy
   K+Rr/s1o8BL4OEYu93HRA/U0Fa/poYLEjKiccOYLtX6wmfb5Fnzm8lYkV
   2A/t2CFiCxtUJLJ1THody6WApM8xDSFTlqJW6vi/enxd2Yerc2RRp6+p8
   DznrEWu1oXETUA95ffIL/qu4H5iniJa8LZEJLOvBgaJEo4KmqXVugfgkp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="359187292"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; 
   d="scan'208";a="359187292"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 14:28:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="749186244"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; 
   d="scan'208";a="749186244"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga007.fm.intel.com with ESMTP; 18 Sep 2023 14:28:46 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	Sunitha Mekala <sunithax.d.mekala@intel.com>
Subject: [PATCH net-next v2 11/11] ice: check netlist before enabling ICE_F_GNSS
Date: Mon, 18 Sep 2023 14:28:14 -0700
Message-Id: <20230918212814.435688-12-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230918212814.435688-1-anthony.l.nguyen@intel.com>
References: <20230918212814.435688-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jacob Keller <jacob.e.keller@intel.com>

Similar to the change made for ICE_F_SMA_CTRL, check the netlist before
enabling support for ICE_F_GNSS. This ensures that the driver only enables
the GNSS feature on devices which actually have the feature enabled in the
firmware device configuration.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h |  2 ++
 drivers/net/ethernet/intel/ice/ice_common.c     | 15 +++++++++++++++
 drivers/net/ethernet/intel/ice/ice_common.h     |  1 +
 drivers/net/ethernet/intel/ice/ice_gnss.c       |  3 +++
 4 files changed, 21 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index b20241df4d3f..24293f52f2d1 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -1393,6 +1393,7 @@ struct ice_aqc_link_topo_params {
 #define ICE_AQC_LINK_TOPO_NODE_TYPE_ID_EEPROM	8
 #define ICE_AQC_LINK_TOPO_NODE_TYPE_CLK_CTRL	9
 #define ICE_AQC_LINK_TOPO_NODE_TYPE_CLK_MUX	10
+#define ICE_AQC_LINK_TOPO_NODE_TYPE_GPS		11
 #define ICE_AQC_LINK_TOPO_NODE_CTX_S		4
 #define ICE_AQC_LINK_TOPO_NODE_CTX_M		\
 				(0xF << ICE_AQC_LINK_TOPO_NODE_CTX_S)
@@ -1435,6 +1436,7 @@ struct ice_aqc_get_link_topo {
 #define ICE_AQC_GET_LINK_TOPO_NODE_NR_E822_PHY		0x30
 #define ICE_AQC_GET_LINK_TOPO_NODE_NR_C827		0x31
 #define ICE_AQC_GET_LINK_TOPO_NODE_NR_GEN_CLK_MUX	0x47
+#define ICE_AQC_GET_LINK_TOPO_NODE_NR_GEN_GPS		0x48
 	u8 rsvd[9];
 };
 
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 089558b3b1ae..8f31ae449948 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -2764,6 +2764,21 @@ bool ice_is_pf_c827(struct ice_hw *hw)
 	return false;
 }
 
+/**
+ * ice_is_gps_in_netlist
+ * @hw: pointer to the hw struct
+ *
+ * Check if the GPS generic device is present in the netlist
+ */
+bool ice_is_gps_in_netlist(struct ice_hw *hw)
+{
+	if (ice_find_netlist_node(hw, ICE_AQC_LINK_TOPO_NODE_TYPE_GPS,
+				  ICE_AQC_GET_LINK_TOPO_NODE_NR_GEN_GPS, NULL))
+		return false;
+
+	return true;
+}
+
 /**
  * ice_aq_list_caps - query function/device capabilities
  * @hw: pointer to the HW struct
diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index 74e44b450de4..47a75651ca38 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -93,6 +93,7 @@ ice_aq_get_phy_caps(struct ice_port_info *pi, bool qual_mods, u8 report_mode,
 		    struct ice_aqc_get_phy_caps_data *caps,
 		    struct ice_sq_cd *cd);
 bool ice_is_pf_c827(struct ice_hw *hw);
+bool ice_is_gps_in_netlist(struct ice_hw *hw);
 int
 ice_find_netlist_node(struct ice_hw *hw, u8 node_type_ctx, u8 node_part_number,
 		      u16 *node_handle);
diff --git a/drivers/net/ethernet/intel/ice/ice_gnss.c b/drivers/net/ethernet/intel/ice/ice_gnss.c
index 75c9de675f20..c8ea1af51ad3 100644
--- a/drivers/net/ethernet/intel/ice/ice_gnss.c
+++ b/drivers/net/ethernet/intel/ice/ice_gnss.c
@@ -389,6 +389,9 @@ bool ice_gnss_is_gps_present(struct ice_hw *hw)
 	if (!hw->func_caps.ts_func_info.src_tmr_owned)
 		return false;
 
+	if (!ice_is_gps_in_netlist(hw))
+		return false;
+
 #if IS_ENABLED(CONFIG_PTP_1588_CLOCK)
 	if (ice_is_e810t(hw)) {
 		int err;
-- 
2.38.1


