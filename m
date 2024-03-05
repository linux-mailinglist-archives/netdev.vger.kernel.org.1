Return-Path: <netdev+bounces-77610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 520AB872536
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 18:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2F1D1F26196
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 17:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7E0DDDA;
	Tue,  5 Mar 2024 17:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T6Kjqfph"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DA0944F
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 17:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709658511; cv=none; b=qbz8P0PE18x1lV3nkeH3Y0Ib4CoKpj8LWGfXLT7cYZoxqUyyQ8CDvC+00YrfUolnnyFNk+K5USOwjS+ZIv/MniFYH6npq6xLJ/SMThy6DM448dXUT/UPbw/KmC9sSiVwJrY7OeshzuK981kn4F5iLP4aS9wIbbl3H5HZBZ6qkXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709658511; c=relaxed/simple;
	bh=ItqS37fU+v81Q0NRgtcbe6Oz9zccNe4LhvENtywP1cI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HuitJDqL40mk6pbqXfhBry4SnY3EOsOTsUv00gOAnac1Ie5iKqFHmjXd4tlKwR1BWhdQxluoagL9jsIaARgaqLau7eV9KzgVIAdii8eb5oolZ0mtxqDfa17Dgs4o2f8/GLsg7rPZooeofk8vYuxh06Cp/+7h7Fq3ylVLsw0UA1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T6Kjqfph; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709658510; x=1741194510;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ItqS37fU+v81Q0NRgtcbe6Oz9zccNe4LhvENtywP1cI=;
  b=T6Kjqfphl5iwdw6Q0oQqf8C6XFszPwssKgsyBZfHlSgB4ZZvyTPXMF2h
   0T4yM/+icCZFBeVy2GqgokOEuSIUwNCceQRnmYK6Kt9X9i/ii0rQf5WBC
   IyeonsJ9hIMyyc+Gt1jtX4Y94HaYamJQFtCbA2+fWqpN4zYHRLW4wRXEK
   y31khOip/Jf5NUfHjWllSpfkWNqdlxw0RzglIObfhOLlh2841B5jznOC9
   0emZ2JYQZZ7wbigcwXKpt6rTgufizuX6SIEYC0NpXLMTTmUXioNCXJy7F
   6cbkqKrvo5qvv9VZ38VLB3EgrHTbTrAOd7z00BJ/S46y5TnYmztbHUQ5x
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4084872"
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="4084872"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 09:07:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="40323603"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa002.jf.intel.com with ESMTP; 05 Mar 2024 09:07:34 -0800
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 3D30A38197;
	Tue,  5 Mar 2024 14:47:50 +0000 (GMT)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	kuba@kernel.org,
	jiri@resnulli.us,
	horms@kernel.org,
	przemyslaw.kitszel@intel.com,
	andrew@lunn.ch,
	victor.raj@intel.com,
	michal.wilczynski@intel.com,
	lukasz.czapnik@intel.com,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-next v6 2/6] ice: Support 5 layer topology
Date: Tue,  5 Mar 2024 09:39:38 -0500
Message-Id: <20240305143942.23757-3-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240305143942.23757-1-mateusz.polchlopek@intel.com>
References: <20240305143942.23757-1-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Raj Victor <victor.raj@intel.com>

There is a performance issue when the number of VSIs are not multiple
of 8. This is caused due to the max children limitation per node(8) in
9 layer topology. The BW credits are shared evenly among the children
by default. Assume one node has 8 children and the other has 1.
The parent of these nodes share the BW credit equally among them.
Apparently this causes a problem for the first node which has 8 children.
The 9th VM get more BW credits than the first 8 VMs.

Example:

1) With 8 VM's:
for x in 0 1 2 3 4 5 6 7;
do taskset -c ${x} netperf -P0 -H 172.68.169.125 &  sleep .1 ; done

tx_queue_0_packets: 23283027
tx_queue_1_packets: 23292289
tx_queue_2_packets: 23276136
tx_queue_3_packets: 23279828
tx_queue_4_packets: 23279828
tx_queue_5_packets: 23279333
tx_queue_6_packets: 23277745
tx_queue_7_packets: 23279950
tx_queue_8_packets: 0

2) With 9 VM's:
for x in 0 1 2 3 4 5 6 7 8;
do taskset -c ${x} netperf -P0 -H 172.68.169.125 &  sleep .1 ; done

tx_queue_0_packets: 24163396
tx_queue_1_packets: 24164623
tx_queue_2_packets: 24163188
tx_queue_3_packets: 24163701
tx_queue_4_packets: 24163683
tx_queue_5_packets: 24164668
tx_queue_6_packets: 23327200
tx_queue_7_packets: 24163853
tx_queue_8_packets: 91101417

So on average queue 8 statistics show that 3.7 times more packets were
send there than to the other queues.

The FW starting with version 3.20, has increased the max number of
children per node by reducing the number of layers from 9 to 5. Reflect
this on driver side.

Signed-off-by: Raj Victor <victor.raj@intel.com>
Co-developed-by: Michal Wilczynski <michal.wilczynski@intel.com>
Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
---
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  23 ++
 drivers/net/ethernet/intel/ice/ice_common.c   |   5 +
 drivers/net/ethernet/intel/ice/ice_ddp.c      | 199 ++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_ddp.h      |   2 +
 drivers/net/ethernet/intel/ice/ice_sched.h    |   3 +
 drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
 6 files changed, 233 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 540c0bdca936..0487c425ae24 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -121,6 +121,7 @@ struct ice_aqc_list_caps_elem {
 #define ICE_AQC_CAPS_PCIE_RESET_AVOIDANCE		0x0076
 #define ICE_AQC_CAPS_POST_UPDATE_RESET_RESTRICT		0x0077
 #define ICE_AQC_CAPS_NVM_MGMT				0x0080
+#define ICE_AQC_CAPS_TX_SCHED_TOPO_COMP_MODE		0x0085
 #define ICE_AQC_CAPS_FW_LAG_SUPPORT			0x0092
 #define ICE_AQC_BIT_ROCEV2_LAG				0x01
 #define ICE_AQC_BIT_SRIOV_LAG				0x02
@@ -810,6 +811,23 @@ struct ice_aqc_get_topo {
 	__le32 addr_low;
 };
 
+/* Get/Set Tx Topology (indirect 0x0418/0x0417) */
+struct ice_aqc_get_set_tx_topo {
+	u8 set_flags;
+#define ICE_AQC_TX_TOPO_FLAGS_CORRER		BIT(0)
+#define ICE_AQC_TX_TOPO_FLAGS_SRC_RAM		BIT(1)
+#define ICE_AQC_TX_TOPO_FLAGS_LOAD_NEW		BIT(4)
+#define ICE_AQC_TX_TOPO_FLAGS_ISSUED		BIT(5)
+
+	u8 get_flags;
+#define ICE_AQC_TX_TOPO_GET_RAM		2
+
+	__le16 reserved1;
+	__le32 reserved2;
+	__le32 addr_high;
+	__le32 addr_low;
+};
+
 /* Update TSE (indirect 0x0403)
  * Get TSE (indirect 0x0404)
  * Add TSE (indirect 0x0401)
@@ -2538,6 +2556,7 @@ struct ice_aq_desc {
 		struct ice_aqc_get_link_topo get_link_topo;
 		struct ice_aqc_i2c read_write_i2c;
 		struct ice_aqc_read_i2c_resp read_i2c_resp;
+		struct ice_aqc_get_set_tx_topo get_set_tx_topo;
 	} params;
 };
 
@@ -2644,6 +2663,10 @@ enum ice_adminq_opc {
 	ice_aqc_opc_query_sched_res			= 0x0412,
 	ice_aqc_opc_remove_rl_profiles			= 0x0415,
 
+	/* tx topology commands */
+	ice_aqc_opc_set_tx_topo				= 0x0417,
+	ice_aqc_opc_get_tx_topo				= 0x0418,
+
 	/* PHY commands */
 	ice_aqc_opc_get_phy_caps			= 0x0600,
 	ice_aqc_opc_set_phy_cfg				= 0x0601,
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index f4ac3c30b124..b11f52b10edf 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1617,6 +1617,8 @@ ice_aq_send_cmd(struct ice_hw *hw, struct ice_aq_desc *desc, void *buf,
 	case ice_aqc_opc_set_port_params:
 	case ice_aqc_opc_get_vlan_mode_parameters:
 	case ice_aqc_opc_set_vlan_mode_parameters:
+	case ice_aqc_opc_set_tx_topo:
+	case ice_aqc_opc_get_tx_topo:
 	case ice_aqc_opc_add_recipe:
 	case ice_aqc_opc_recipe_to_profile:
 	case ice_aqc_opc_get_recipe:
@@ -2173,6 +2175,9 @@ ice_parse_common_caps(struct ice_hw *hw, struct ice_hw_common_caps *caps,
 		ice_debug(hw, ICE_DBG_INIT, "%s: sriov_lag = %u\n",
 			  prefix, caps->sriov_lag);
 		break;
+	case ICE_AQC_CAPS_TX_SCHED_TOPO_COMP_MODE:
+		caps->tx_sched_topo_comp_mode_en = (number == 1);
+		break;
 	default:
 		/* Not one of the recognized common capabilities */
 		found = false;
diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.c b/drivers/net/ethernet/intel/ice/ice_ddp.c
index 7532d11ad7f3..766437944774 100644
--- a/drivers/net/ethernet/intel/ice/ice_ddp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ddp.c
@@ -4,6 +4,7 @@
 #include "ice_common.h"
 #include "ice.h"
 #include "ice_ddp.h"
+#include "ice_sched.h"
 
 /* For supporting double VLAN mode, it is necessary to enable or disable certain
  * boost tcam entries. The metadata labels names that match the following
@@ -2263,3 +2264,201 @@ enum ice_ddp_state ice_copy_and_init_pkg(struct ice_hw *hw, const u8 *buf,
 
 	return state;
 }
+
+/**
+ * ice_get_set_tx_topo - get or set Tx topology
+ * @hw: pointer to the HW struct
+ * @buf: pointer to Tx topology buffer
+ * @buf_size: buffer size
+ * @cd: pointer to command details structure or NULL
+ * @flags: pointer to descriptor flags
+ * @set: 0-get, 1-set topology
+ *
+ * The function will get or set Tx topology
+ */
+static int
+ice_get_set_tx_topo(struct ice_hw *hw, u8 *buf, u16 buf_size,
+		    struct ice_sq_cd *cd, u8 *flags, bool set)
+{
+	struct ice_aqc_get_set_tx_topo *cmd;
+	struct ice_aq_desc desc;
+	int status;
+
+	cmd = &desc.params.get_set_tx_topo;
+	if (set) {
+		ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_set_tx_topo);
+		cmd->set_flags = ICE_AQC_TX_TOPO_FLAGS_ISSUED;
+		/* requested to update a new topology, not a default topology */
+		if (buf)
+			cmd->set_flags |= ICE_AQC_TX_TOPO_FLAGS_SRC_RAM |
+					  ICE_AQC_TX_TOPO_FLAGS_LOAD_NEW;
+	} else {
+		ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_get_tx_topo);
+		cmd->get_flags = ICE_AQC_TX_TOPO_GET_RAM;
+	}
+	desc.flags |= cpu_to_le16(ICE_AQ_FLAG_RD);
+	status = ice_aq_send_cmd(hw, &desc, buf, buf_size, cd);
+	if (status)
+		return status;
+	/* read the return flag values (first byte) for get operation */
+	if (!set && flags)
+		*flags = desc.params.get_set_tx_topo.set_flags;
+
+	return 0;
+}
+
+/**
+ * ice_cfg_tx_topo - Initialize new Tx topology if available
+ * @hw: pointer to the HW struct
+ * @buf: pointer to Tx topology buffer
+ * @len: buffer size
+ *
+ * The function will apply the new Tx topology from the package buffer
+ * if available.
+ */
+int ice_cfg_tx_topo(struct ice_hw *hw, u8 *buf, u32 len)
+{
+	u8 *current_topo, *new_topo = NULL;
+	struct ice_run_time_cfg_seg *seg;
+	struct ice_buf_hdr *section;
+	struct ice_pkg_hdr *pkg_hdr;
+	enum ice_ddp_state state;
+	u16 offset, size = 0;
+	u32 reg = 0;
+	int status;
+	u8 flags;
+
+	if (!buf || !len)
+		return -EINVAL;
+
+	/* Does FW support new Tx topology mode ? */
+	if (!hw->func_caps.common_cap.tx_sched_topo_comp_mode_en) {
+		ice_debug(hw, ICE_DBG_INIT, "FW doesn't support compatibility mode\n");
+		return -EOPNOTSUPP;
+	}
+
+	current_topo = kzalloc(ICE_AQ_MAX_BUF_LEN, GFP_KERNEL);
+	if (!current_topo)
+		return -ENOMEM;
+
+	/* Get the current Tx topology */
+	status = ice_get_set_tx_topo(hw, current_topo, ICE_AQ_MAX_BUF_LEN, NULL,
+				     &flags, false);
+
+	kfree(current_topo);
+
+	if (status) {
+		ice_debug(hw, ICE_DBG_INIT, "Get current topology is failed\n");
+		return status;
+	}
+
+	/* Is default topology already applied ? */
+	if (!(flags & ICE_AQC_TX_TOPO_FLAGS_LOAD_NEW) &&
+	    hw->num_tx_sched_layers == ICE_SCHED_9_LAYERS) {
+		ice_debug(hw, ICE_DBG_INIT, "Default topology already applied\n");
+		return -EEXIST;
+	}
+
+	/* Is new topology already applied ? */
+	if ((flags & ICE_AQC_TX_TOPO_FLAGS_LOAD_NEW) &&
+	    hw->num_tx_sched_layers == ICE_SCHED_5_LAYERS) {
+		ice_debug(hw, ICE_DBG_INIT, "New topology already applied\n");
+		return -EEXIST;
+	}
+
+	/* Setting topology already issued? */
+	if (flags & ICE_AQC_TX_TOPO_FLAGS_ISSUED) {
+		ice_debug(hw, ICE_DBG_INIT, "Update Tx topology was done by another PF\n");
+		/* Add a small delay before exiting */
+		msleep(2000);
+		return -EEXIST;
+	}
+
+	/* Change the topology from new to default (5 to 9) */
+	if (!(flags & ICE_AQC_TX_TOPO_FLAGS_LOAD_NEW) &&
+	    hw->num_tx_sched_layers == ICE_SCHED_5_LAYERS) {
+		ice_debug(hw, ICE_DBG_INIT, "Change topology from 5 to 9 layers\n");
+		goto update_topo;
+	}
+
+	pkg_hdr = (struct ice_pkg_hdr *)buf;
+	state = ice_verify_pkg(pkg_hdr, len);
+	if (state) {
+		ice_debug(hw, ICE_DBG_INIT, "Failed to verify pkg (err: %d)\n",
+			  state);
+		return -EIO;
+	}
+
+	/* Find runtime configuration segment */
+	seg = (struct ice_run_time_cfg_seg *)
+	      ice_find_seg_in_pkg(hw, SEGMENT_TYPE_ICE_RUN_TIME_CFG, pkg_hdr);
+	if (!seg) {
+		ice_debug(hw, ICE_DBG_INIT, "5 layer topology segment is missing\n");
+		return -EIO;
+	}
+
+	if (le32_to_cpu(seg->buf_table.buf_count) < ICE_MIN_S_COUNT) {
+		ice_debug(hw, ICE_DBG_INIT, "5 layer topology segment count(%d) is wrong\n",
+			  seg->buf_table.buf_count);
+		return -EIO;
+	}
+
+	section = ice_pkg_val_buf(seg->buf_table.buf_array);
+	if (!section || le32_to_cpu(section->section_entry[0].type) !=
+		ICE_SID_TX_5_LAYER_TOPO) {
+		ice_debug(hw, ICE_DBG_INIT, "5 layer topology section type is wrong\n");
+		return -EIO;
+	}
+
+	size = le16_to_cpu(section->section_entry[0].size);
+	offset = le16_to_cpu(section->section_entry[0].offset);
+	if (size < ICE_MIN_S_SZ || size > ICE_MAX_S_SZ) {
+		ice_debug(hw, ICE_DBG_INIT, "5 layer topology section size is wrong\n");
+		return -EIO;
+	}
+
+	/* Make sure the section fits in the buffer */
+	if (offset + size > ICE_PKG_BUF_SIZE) {
+		ice_debug(hw, ICE_DBG_INIT, "5 layer topology buffer > 4K\n");
+		return -EIO;
+	}
+
+	/* Get the new topology buffer */
+	new_topo = ((u8 *)section) + offset;
+
+update_topo:
+	/* Acquire global lock to make sure that set topology issued
+	 * by one PF.
+	 */
+	status = ice_acquire_res(hw, ICE_GLOBAL_CFG_LOCK_RES_ID, ICE_RES_WRITE,
+				 ICE_GLOBAL_CFG_LOCK_TIMEOUT);
+	if (status) {
+		ice_debug(hw, ICE_DBG_INIT, "Failed to acquire global lock\n");
+		return status;
+	}
+
+	/* Check if reset was triggered already. */
+	reg = rd32(hw, GLGEN_RSTAT);
+	if (reg & GLGEN_RSTAT_DEVSTATE_M) {
+		/* Reset is in progress, re-init the HW again */
+		ice_debug(hw, ICE_DBG_INIT, "Reset is in progress. Layer topology might be applied already\n");
+		ice_check_reset(hw);
+		return 0;
+	}
+
+	/* Set new topology */
+	status = ice_get_set_tx_topo(hw, new_topo, size, NULL, NULL, true);
+	if (status) {
+		ice_debug(hw, ICE_DBG_INIT, "Failed setting Tx topology\n");
+		return status;
+	}
+
+	/* New topology is updated, delay 1 second before issuing the CORER */
+	msleep(1000);
+	ice_reset(hw, ICE_RESET_CORER);
+	/* CORER will clear the global lock, so no explicit call
+	 * required for release.
+	 */
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.h b/drivers/net/ethernet/intel/ice/ice_ddp.h
index ff66c2ffb1a2..622543f08b43 100644
--- a/drivers/net/ethernet/intel/ice/ice_ddp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ddp.h
@@ -454,4 +454,6 @@ u16 ice_pkg_buf_get_active_sections(struct ice_buf_build *bld);
 void *ice_pkg_enum_section(struct ice_seg *ice_seg, struct ice_pkg_enum *state,
 			   u32 sect_type);
 
+int ice_cfg_tx_topo(struct ice_hw *hw, u8 *buf, u32 len);
+
 #endif
diff --git a/drivers/net/ethernet/intel/ice/ice_sched.h b/drivers/net/ethernet/intel/ice/ice_sched.h
index 1aef05ea5a57..9baff6a857d8 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.h
+++ b/drivers/net/ethernet/intel/ice/ice_sched.h
@@ -6,6 +6,9 @@
 
 #include "ice_common.h"
 
+#define ICE_SCHED_5_LAYERS	5
+#define ICE_SCHED_9_LAYERS	9
+
 #define SCHED_NODE_NAME_MAX_LEN 32
 
 #define ICE_QGRP_LAYER_OFFSET	2
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 370e9bf5df2f..620ff1d87c2e 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -296,6 +296,7 @@ struct ice_hw_common_caps {
 	bool pcie_reset_avoidance;
 	/* Post update reset restriction */
 	bool reset_restrict_support;
+	bool tx_sched_topo_comp_mode_en;
 };
 
 /* IEEE 1588 TIME_SYNC specific info */
-- 
2.38.1


