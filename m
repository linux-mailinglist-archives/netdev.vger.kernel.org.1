Return-Path: <netdev+bounces-32906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B67C479AAC6
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 20:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F19C2812D3
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 18:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63AD16411;
	Mon, 11 Sep 2023 18:11:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904A21643E
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 18:11:08 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2391D106
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 11:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694455867; x=1725991867;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3oB55aovZDO2/a0qTC+MFKzRyujMP/61YytCkGWpZl8=;
  b=fp12jUWCgwIT3JdQqzItpURLhkGWNGd4du3YqfdQp7sBUAZ2qcaIn5cV
   iaSQyVxQRCFyeWc9Rjc8iJfSdVyCghTpD9lgEQo+bzQyYfrjKxkzn0kYt
   OnPAHfLjm3i2HSqL6nUbU96nVs7k5SzrkTONvUXVp/xyPnFOVpoMk2aoc
   88MjBX0e8Xd2Hmukl9DrWm6O6/f5z00GVulvmJEY/AWvHZlVpwZpOIkFp
   LKciKGAgsqch11KEBVaGV2iYYe6vy/1T4qRB/6LOkrZ59+ncXjFLcjW4s
   b+CV4z/7/oc+yhIcGtFtxGLzL2jDUQghJDkK8IxGFKRBJpqFLRugyrlFk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="378075683"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="378075683"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 11:11:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="917129959"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="917129959"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga005.jf.intel.com with ESMTP; 11 Sep 2023 11:11:02 -0700
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
Subject: [PATCH net-next 12/13] ice: check the netlist before enabling ICE_F_SMA_CTRL
Date: Mon, 11 Sep 2023 11:03:13 -0700
Message-Id: <20230911180314.4082659-13-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230911180314.4082659-1-anthony.l.nguyen@intel.com>
References: <20230911180314.4082659-1-anthony.l.nguyen@intel.com>
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

Currently, the ice driver unconditionally enables ICE_F_SMA_CTRL for all
E810-T based devices. In some cases, the SMA control access is not
available in the netlist firmware component. In such a case, the driver
will fail to setup the SMA pins. When this happens, the driver prints
"Failed to configure E810-T SMA pin control" and forcibly disables all PTP
pin configuration support.

This results in failure to use even the fixed pin capabilities of standard
E810 devices, resulting in reduced functionality.

To avoid this, check the netlist for the SMA control module before enabling
the ICE_F_SMA_CTRL feature. If the netlist lacks this module, then the
feature will not be enabled. In this case, the driver flow for enabling
periodic outputs and external timestamps will fall back to the standard
fixed pin configuration.

This allows supporting the software defined pins on a wider array of
platforms.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  6 +-
 drivers/net/ethernet/intel/ice/ice_common.c   | 62 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_common.h   |  1 +
 drivers/net/ethernet/intel/ice/ice_lib.c      |  3 +-
 4 files changed, 69 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 29f7a9852aec..674be406cc7a 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -1367,6 +1367,7 @@ struct ice_aqc_link_topo_params {
 #define ICE_AQC_LINK_TOPO_NODE_TYPE_CAGE	6
 #define ICE_AQC_LINK_TOPO_NODE_TYPE_MEZZ	7
 #define ICE_AQC_LINK_TOPO_NODE_TYPE_ID_EEPROM	8
+#define ICE_AQC_LINK_TOPO_NODE_TYPE_CLK_MUX	10
 #define ICE_AQC_LINK_TOPO_NODE_CTX_S		4
 #define ICE_AQC_LINK_TOPO_NODE_CTX_M		\
 				(0xF << ICE_AQC_LINK_TOPO_NODE_CTX_S)
@@ -1403,8 +1404,9 @@ struct ice_aqc_link_topo_addr {
 struct ice_aqc_get_link_topo {
 	struct ice_aqc_link_topo_addr addr;
 	u8 node_part_num;
-#define ICE_AQC_GET_LINK_TOPO_NODE_NR_PCA9575	0x21
-#define ICE_AQC_GET_LINK_TOPO_NODE_NR_C827	0x31
+#define ICE_AQC_GET_LINK_TOPO_NODE_NR_PCA9575			0x21
+#define ICE_AQC_GET_LINK_TOPO_NODE_NR_C827			0x31
+#define ICE_AQC_GET_LINK_TOPO_NODE_NR_GEN_CLK_MUX		0x47
 	u8 rsvd[9];
 };
 
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 80deca45ab59..e38feb61492c 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -2715,6 +2715,68 @@ bool ice_is_pf_c827(struct ice_hw *hw)
 	return false;
 }
 
+#define MAX_NETLIST_SIZE 10
+/**
+ * ice_find_netlist_node
+ * @hw: pointer to the hw struct
+ * @node_type_ctx: type of netlist node to look for
+ * @node_part_number: node part number to look for
+ * @node_handle: output parameter if node found - optional
+ *
+ * Scan the netlist for a node handle of the given node type and part number.
+ *
+ * If node_handle is non-NULL it will be modified on function exit. It is only
+ * valid if the function returns zero, and should be ignored on any non-zero
+ * return value.
+ *
+ * Returns: 0 if the node is found, -ENOENT if no handle was found, and
+ * a negative error code on failure to access the AQ.
+ */
+static int
+ice_find_netlist_node(struct ice_hw *hw, u8 node_type_ctx, u8 node_part_number,
+		      u16 *node_handle)
+{
+	u8 idx;
+
+	for (idx = 0; idx < MAX_NETLIST_SIZE; idx++) {
+		struct ice_aqc_get_link_topo cmd = {};
+		u8 rec_node_part_number;
+		int status;
+
+		cmd.addr.topo_params.node_type_ctx =
+			FIELD_PREP(ICE_AQC_LINK_TOPO_NODE_TYPE_M,
+				   node_type_ctx);
+		cmd.addr.topo_params.index = idx;
+
+		status = ice_aq_get_netlist_node(hw, &cmd,
+						 &rec_node_part_number,
+						 node_handle);
+		if (status)
+			return status;
+
+		if (rec_node_part_number == node_part_number)
+			return 0;
+	}
+
+	return -ENOENT;
+}
+
+/**
+ * ice_is_clock_mux_in_netlist
+ * @hw: pointer to the hw struct
+ *
+ * Check if the Clock Multiplexer device is present in the netlist
+ */
+bool ice_is_clock_mux_in_netlist(struct ice_hw *hw)
+{
+	if (ice_find_netlist_node(hw, ICE_AQC_LINK_TOPO_NODE_TYPE_CLK_MUX,
+				  ICE_AQC_GET_LINK_TOPO_NODE_NR_GEN_CLK_MUX,
+				  NULL))
+		return false;
+
+	return true;
+}
+
 /**
  * ice_aq_list_caps - query function/device capabilities
  * @hw: pointer to the HW struct
diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index 226b81f97a92..52bb7f4bbb74 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -93,6 +93,7 @@ ice_aq_get_phy_caps(struct ice_port_info *pi, bool qual_mods, u8 report_mode,
 		    struct ice_aqc_get_phy_caps_data *caps,
 		    struct ice_sq_cd *cd);
 bool ice_is_pf_c827(struct ice_hw *hw);
+bool ice_is_clock_mux_in_netlist(struct ice_hw *hw);
 int
 ice_aq_list_caps(struct ice_hw *hw, void *buf, u16 buf_size, u32 *cap_count,
 		 enum ice_adminq_opc opc, struct ice_sq_cd *cd);
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index f29ff54383b5..b8849518120d 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -3989,8 +3989,9 @@ void ice_init_feature_support(struct ice_pf *pf)
 		/* If we don't own the timer - don't enable other caps */
 		if (!ice_pf_src_tmr_owned(pf))
 			break;
-		if (ice_is_e810t(&pf->hw)) {
+		if (ice_is_clock_mux_in_netlist(&pf->hw))
 			ice_set_feature_support(pf, ICE_F_SMA_CTRL);
+		if (ice_is_e810t(&pf->hw)) {
 			if (ice_gnss_is_gps_present(&pf->hw))
 				ice_set_feature_support(pf, ICE_F_GNSS);
 		}
-- 
2.38.1


