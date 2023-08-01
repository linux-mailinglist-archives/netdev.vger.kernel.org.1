Return-Path: <netdev+bounces-23369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C928876BB79
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 19:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB64F1C2109A
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 17:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417B325150;
	Tue,  1 Aug 2023 17:37:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A2325149
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 17:37:48 +0000 (UTC)
Received: from mgamail.intel.com (unknown [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE6310F0
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 10:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690911465; x=1722447465;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=47YDn+GObKHM6rdh8xqrLvqwSXTpRzZhU8ka5EHyPlI=;
  b=lDUNTfKE9WBZo5yUBVrbpx0Eq5LGpKGMQnGp9dzP9hAsEU59EmRovlqt
   7GcGVlsmv04Hyr22I7OYssSfJIEoQeSEGc8kkSV+v8t5jnjkiBPP/0Ok4
   duaAYvNm3EA2pJbZh2qK+kjzb0ghOJGfoEcqYIDhQHLQHqCjCYR4T/lYC
   vDB2IHIdjD5TSu9AJB6ll5dnp7XEsEb+hByB7O8wQ3pXhk9q3OoiwYvcp
   rxw/OCP181aDnxI7tAEX/QKC3P+x+s9A+PKwu15/CvJZs/jeI+S0tbZBs
   qnJyCdxjUqXk+VJGBwBzWGDVGLt4M47cZOOJ3hMZo5ED1ucR+q06U+s5L
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="455740691"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="455740691"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 10:37:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="798769703"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="798769703"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga004.fm.intel.com with ESMTP; 01 Aug 2023 10:37:35 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Karol Kolacinski <karol.kolacinski@intel.com>,
	anthony.l.nguyen@intel.com,
	Michal Michalik <michal.michalik@intel.com>,
	Jan Sokolowski <jan.sokolowski@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 5/7] ice: Add get C827 PHY index function
Date: Tue,  1 Aug 2023 10:31:10 -0700
Message-Id: <20230801173112.3625977-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230801173112.3625977-1-anthony.l.nguyen@intel.com>
References: <20230801173112.3625977-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Karol Kolacinski <karol.kolacinski@intel.com>

Add a function to find the C827 PHY node handle and return C827 PHY
index for the E810 products.

In order to bring this function to full functionality, some
helpers for this were written by Michal Michalik.

Co-developed-by: Michal Michalik <michal.michalik@intel.com>
Signed-off-by: Michal Michalik <michal.michalik@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  1 +
 drivers/net/ethernet/intel/ice/ice_common.c   | 62 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_common.h   |  5 ++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  3 +
 4 files changed, 71 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index c0ad34b42531..1ad92f95d6bd 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -1404,6 +1404,7 @@ struct ice_aqc_get_link_topo {
 	struct ice_aqc_link_topo_addr addr;
 	u8 node_part_num;
 #define ICE_AQC_GET_LINK_TOPO_NODE_NR_PCA9575	0x21
+#define ICE_AQC_GET_LINK_TOPO_NODE_NR_C827	0x31
 	u8 rsvd[9];
 };
 
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index dade0a50299c..97db71556b08 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -5,6 +5,7 @@
 #include "ice_sched.h"
 #include "ice_adminq_cmd.h"
 #include "ice_flow.h"
+#include "ice_ptp_hw.h"
 
 #define ICE_PF_RESET_WAIT_COUNT	300
 
@@ -2661,6 +2662,67 @@ ice_parse_dev_caps(struct ice_hw *hw, struct ice_hw_dev_caps *dev_p,
 	ice_recalc_port_limited_caps(hw, &dev_p->common_cap);
 }
 
+/**
+ * ice_aq_get_netlist_node
+ * @hw: pointer to the hw struct
+ * @cmd: get_link_topo AQ structure
+ * @node_part_number: output node part number if node found
+ * @node_handle: output node handle parameter if node found
+ */
+int
+ice_aq_get_netlist_node(struct ice_hw *hw, struct ice_aqc_get_link_topo *cmd,
+			u8 *node_part_number, u16 *node_handle)
+{
+	struct ice_aq_desc desc;
+
+	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_get_link_topo);
+	desc.params.get_link_topo = *cmd;
+
+	if (ice_aq_send_cmd(hw, &desc, NULL, 0, NULL))
+		return -EIO;
+
+	if (node_handle)
+		*node_handle = le16_to_cpu(desc.params.get_link_topo.addr.handle);
+	if (node_part_number)
+		*node_part_number = desc.params.get_link_topo.node_part_num;
+
+	return 0;
+}
+
+/**
+ * ice_is_pf_c827 - check if pf contains c827 phy
+ * @hw: pointer to the hw struct
+ */
+bool ice_is_pf_c827(struct ice_hw *hw)
+{
+	struct ice_aqc_get_link_topo cmd = {};
+	u8 node_part_number;
+	u16 node_handle;
+	int status;
+
+	if (hw->mac_type != ICE_MAC_E810)
+		return false;
+
+	if (hw->device_id != ICE_DEV_ID_E810C_QSFP)
+		return true;
+
+	cmd.addr.topo_params.node_type_ctx =
+		FIELD_PREP(ICE_AQC_LINK_TOPO_NODE_TYPE_M, ICE_AQC_LINK_TOPO_NODE_TYPE_PHY) |
+		FIELD_PREP(ICE_AQC_LINK_TOPO_NODE_CTX_M, ICE_AQC_LINK_TOPO_NODE_CTX_PORT);
+	cmd.addr.topo_params.index = 0;
+
+	status = ice_aq_get_netlist_node(hw, &cmd, &node_part_number,
+					 &node_handle);
+
+	if (status || node_part_number != ICE_AQC_GET_LINK_TOPO_NODE_NR_C827)
+		return false;
+
+	if (node_handle == E810C_QSFP_C827_0_HANDLE || node_handle == E810C_QSFP_C827_1_HANDLE)
+		return true;
+
+	return false;
+}
+
 /**
  * ice_aq_list_caps - query function/device capabilities
  * @hw: pointer to the HW struct
diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index df12a9d8d28c..2e6a0bb6b89e 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -16,6 +16,7 @@
 #define ICE_SQ_SEND_DELAY_TIME_MS	10
 #define ICE_SQ_SEND_MAX_EXECUTE		3
 
+bool ice_is_pf_c827(struct ice_hw *hw);
 int ice_init_hw(struct ice_hw *hw);
 void ice_deinit_hw(struct ice_hw *hw);
 int ice_check_reset(struct ice_hw *hw);
@@ -94,6 +95,10 @@ ice_aq_get_phy_caps(struct ice_port_info *pi, bool qual_mods, u8 report_mode,
 		    struct ice_aqc_get_phy_caps_data *caps,
 		    struct ice_sq_cd *cd);
 int
+ice_aq_get_netlist_node(struct ice_hw *hw, struct ice_aqc_get_link_topo *cmd,
+			u8 *node_part_number, u16 *node_handle);
+bool ice_is_pf_c827(struct ice_hw *hw);
+int
 ice_aq_list_caps(struct ice_hw *hw, void *buf, u16 buf_size, u32 *cap_count,
 		 enum ice_adminq_opc opc, struct ice_sq_cd *cd);
 int
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 3b68cb91bd81..1969425f0084 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -112,6 +112,9 @@ struct ice_cgu_pll_params_e822 {
 extern const struct
 ice_cgu_pll_params_e822 e822_cgu_params[NUM_ICE_TIME_REF_FREQ];
 
+#define E810C_QSFP_C827_0_HANDLE 2
+#define E810C_QSFP_C827_1_HANDLE 3
+
 /* Table of constants related to possible TIME_REF sources */
 extern const struct ice_time_ref_info_e822 e822_time_ref[NUM_ICE_TIME_REF_FREQ];
 
-- 
2.38.1


