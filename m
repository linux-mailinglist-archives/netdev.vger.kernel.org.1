Return-Path: <netdev+bounces-87516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 991558A3604
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 20:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACB35B24198
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 18:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF00114F124;
	Fri, 12 Apr 2024 18:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QCOcRMLB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B72814F138
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 18:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712947906; cv=none; b=pQSfZsQ4aFiBbmo2FG3vAvmmviE6JIFciommx2RrzQNWVm+2hSBXrMEE07469Mg7/T8QWr35ueXwn2tLq0H0aSpfmFqHt3bA/B+4i4pbJb+Bh+uTOLtQ/V9oHr9rUHG3i3oolhvK2ePKmEVe0nHni8mHOw6Hzo29UmWAXTbVNvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712947906; c=relaxed/simple;
	bh=J2WNJ7Hq23BZAjlIqN40SdX+OMk9qInbm80Tg1CUr8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iC+Q0fblExAdFrEaAemwO48Nwim4reihGPF9UZac+EzVMI/Cx9NZcSCYMPyy3Ym8qChd/OQIzOCjU1BGbORdhG+DXA8CftAbbX7oq5cO1AeCukH6Nrf+TdNCHADW1qhAidD80fdNyvnaDu2HUb5S1ik5RTlwgkORubfYAx3ahj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QCOcRMLB; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712947905; x=1744483905;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J2WNJ7Hq23BZAjlIqN40SdX+OMk9qInbm80Tg1CUr8w=;
  b=QCOcRMLBmlIh6PDIxoVFl6oIxgUL1vIhi0BRCbbqz0tTGqNio5pw6JYF
   UOyBuxt2K2QZ8O/3JftNlIZtMOpfi4zusMsX0bRibdYmp15iOeT9hHPa8
   GcBVWMLOo2lMSNBOWnBqyp1ONeD8O67hxV7/X7Eur/yjO0bN/FO6b38SI
   Ci+yZOIoBnXJYUBfG0s2mRVi+fFmZTf0Dr22QFWdp0nDAhLxtVKCinuqn
   czHNF0U4SqJg/NBbLLA3x8hab5aQdra9C+zLmvgfYSkKhLHzZ3tS1ZS67
   7MwIH3/kS14LU9wfd5vobBzw5Pkc56d8NxNNyg3EC639fFcyaiDKZ764B
   Q==;
X-CSE-ConnectionGUID: zMIzPt1pTP6m4qdZh+EjKg==
X-CSE-MsgGUID: 8StdzXULS2WeztU3ZPtyag==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="8333640"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="8333640"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 11:51:42 -0700
X-CSE-ConnectionGUID: /9aQLv6aSJ2oDkypHFdkAQ==
X-CSE-MsgGUID: HnGHpt8zSTKiQvGMoKPQJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="26108564"
Received: from c3-1-server.sj.intel.com ([10.232.18.246])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 11:51:42 -0700
From: Anil Samal <anil.samal@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	jesse.brandeburg@intel.com,
	leszek.pepiak@intel.com,
	jacob.e.keller@intel.com,
	przemyslaw.kitszel@intel.com,
	lukasz.czapnik@intel.com,
	Anil Samal <anil.samal@intel.com>
Subject: [PATCH iwl-next 3/4] ice: Implement driver functionality to dump fec  statistics
Date: Fri, 12 Apr 2024 11:49:19 -0700
Message-ID: <20240412185135.297368-4-anil.samal@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412185135.297368-1-anil.samal@intel.com>
References: <20240412185135.297368-1-anil.samal@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To debug link issues in the field, it is paramount to
dump fec corrected/uncorrected block counts from firmware.

Extend ethtool option '--show-fec' to support fec statistics.
The IEEE standard mandates two sets of counters:
 - 30.5.1.1.17 aFECCorrectedBlocks
 - 30.5.1.1.18 aFECUncorrectableBlocks

Standard defines above statistics per lane but current
implementation supports total FEC statistics per port
i.e. sum of all lane per port. Find sample output below

 # ethtool -I --show-fec ens21f0np0
FEC parameters for ens21f0np0:
Supported/Configured FEC encodings: Auto RS BaseR
Active FEC encoding: RS
Statistics:
  corrected_blocks: 0
  uncorrectable_blocks: 0

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Anil Samal <anil.samal@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c  | 54 +++++++++++++
 drivers/net/ethernet/intel/ice/ice_common.h  | 24 ++++++
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 84 ++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_type.h    |  8 ++
 4 files changed, 170 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 9a0a533613ff..1a00efb1e51d 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -3299,6 +3299,60 @@ int ice_update_link_info(struct ice_port_info *pi)
 	return status;
 }
 
+#define FEC_REG_PORT(port) {	\
+	FEC_CORR_LOW_REG_PORT##port,		\
+	FEC_CORR_HIGH_REG_PORT##port,	\
+	FEC_UNCORR_LOW_REG_PORT##port,	\
+	FEC_UNCORR_HIGH_REG_PORT##port,	\
+}
+
+static const u32 fec_reg[][ICE_FEC_MAX] = {
+	FEC_REG_PORT(0),
+	FEC_REG_PORT(1),
+	FEC_REG_PORT(2),
+	FEC_REG_PORT(3)
+};
+
+/**
+ * ice_aq_get_fec_stats - reads fec stats from phy
+ * @hw: pointer to the HW struct
+ * @pcs_quad: represents pcsquad of user input serdes
+ * @pcs_port: represents the pcs port number part of above pcs quad
+ * @fec_type: represents FEC stats type
+ * @output: pointer to the caller-supplied buffer to return requested fec stats
+ *
+ * Returns non-zero status on error and 0 on success.
+ */
+int ice_aq_get_fec_stats(struct ice_hw *hw, u16 pcs_quad, u16 pcs_port,
+			 enum ice_fec_stats_types fec_type, u32 *output)
+{
+	u16 flag = (ICE_AQ_FLAG_RD | ICE_AQ_FLAG_BUF | ICE_AQ_FLAG_SI);
+	struct ice_sbq_msg_input msg = {};
+	u32 receiver_id, reg_offset;
+	int err = 0;
+
+	if (pcs_port > 3)
+		return -EINVAL;
+	reg_offset = fec_reg[pcs_port][fec_type];
+	if (pcs_quad == 0)
+		receiver_id = FEC_RECEIVER_ID_PCS0;
+	else if (pcs_quad == 1)
+		receiver_id = FEC_RECEIVER_ID_PCS1;
+	else
+		return -EINVAL;
+
+	msg.msg_addr_low = lower_16_bits(reg_offset);
+	msg.msg_addr_high = receiver_id;
+	msg.opcode = ice_sbq_msg_rd;
+	msg.dest_dev = rmn_0;
+	err = ice_sbq_rw_reg(hw, &msg, flag);
+	if (err)
+		return err;
+
+	*output = msg.data;
+	return 0;
+}
+
 /**
  * ice_cache_phy_user_req
  * @pi: port information structure
diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index 42cda1bbbaab..6b888efce593 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -17,6 +17,27 @@
 #define ICE_SQ_SEND_DELAY_TIME_MS	10
 #define ICE_SQ_SEND_MAX_EXECUTE		3
 
+#define FEC_REG_SHIFT 2
+#define FEC_RECV_ID_SHIFT 4
+#define FEC_CORR_LOW_REG_PORT0 (0x02 << FEC_REG_SHIFT)
+#define FEC_CORR_HIGH_REG_PORT0 (0x03 << FEC_REG_SHIFT)
+#define FEC_UNCORR_LOW_REG_PORT0 (0x04 << FEC_REG_SHIFT)
+#define FEC_UNCORR_HIGH_REG_PORT0 (0x05 << FEC_REG_SHIFT)
+#define FEC_CORR_LOW_REG_PORT1 (0x42 << FEC_REG_SHIFT)
+#define FEC_CORR_HIGH_REG_PORT1 (0x43 << FEC_REG_SHIFT)
+#define FEC_UNCORR_LOW_REG_PORT1 (0x44 << FEC_REG_SHIFT)
+#define FEC_UNCORR_HIGH_REG_PORT1 (0x45 << FEC_REG_SHIFT)
+#define FEC_CORR_LOW_REG_PORT2 (0x4A << FEC_REG_SHIFT)
+#define FEC_CORR_HIGH_REG_PORT2 (0x4B << FEC_REG_SHIFT)
+#define FEC_UNCORR_LOW_REG_PORT2 (0x4C << FEC_REG_SHIFT)
+#define FEC_UNCORR_HIGH_REG_PORT2 (0x4D << FEC_REG_SHIFT)
+#define FEC_CORR_LOW_REG_PORT3 (0x52 << FEC_REG_SHIFT)
+#define FEC_CORR_HIGH_REG_PORT3 (0x53 << FEC_REG_SHIFT)
+#define FEC_UNCORR_LOW_REG_PORT3 (0x54 << FEC_REG_SHIFT)
+#define FEC_UNCORR_HIGH_REG_PORT3 (0x55 << FEC_REG_SHIFT)
+#define FEC_RECEIVER_ID_PCS0 (0x33 << FEC_RECV_ID_SHIFT)
+#define FEC_RECEIVER_ID_PCS1 (0x34 << FEC_RECV_ID_SHIFT)
+
 int ice_init_hw(struct ice_hw *hw);
 void ice_deinit_hw(struct ice_hw *hw);
 int ice_check_reset(struct ice_hw *hw);
@@ -121,6 +142,9 @@ int
 ice_get_link_default_override(struct ice_link_default_override_tlv *ldo,
 			      struct ice_port_info *pi);
 bool ice_is_phy_caps_an_enabled(struct ice_aqc_get_phy_caps_data *caps);
+int
+ice_aq_get_fec_stats(struct ice_hw *hw, u16 pcs_quad, u16 pcs_port,
+		     enum ice_fec_stats_types fec_type, u32 *output);
 
 enum ice_fc_mode ice_caps_to_fc_mode(u8 caps);
 enum ice_fec_mode ice_caps_to_fec_mode(u8 caps, u8 fec_options);
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 6884b45c3b0a..732e402ed419 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -4562,6 +4562,89 @@ ice_get_module_eeprom(struct net_device *netdev,
 	return 0;
 }
 
+/**
+ * ice_get_port_fec_stats - returns FEC correctable, uncorrectable stats per
+ *                          pcsquad, pcsport
+ * @hw: pointer to the HW struct
+ * @pcs_quad: pcsquad for input port
+ * @pcs_port: pcsport for input port
+ * @fec_stats: buffer to hold FEC statistics for given port
+ *
+ * Returns FEC stats
+ */
+static int ice_get_port_fec_stats(struct ice_hw *hw, u16 pcs_quad, u16 pcs_port,
+				  struct ethtool_fec_stats *fec_stats)
+{
+	u32 fec_uncorr_low_val = 0, fec_uncorr_high_val = 0;
+	u32 fec_corr_low_val = 0, fec_corr_high_val = 0;
+	int err;
+
+	if (pcs_quad > 1 || pcs_port > 3)
+		return -EINVAL;
+
+	err = ice_aq_get_fec_stats(hw, pcs_quad, pcs_port, ICE_FEC_CORR_LOW,
+				   &fec_corr_low_val);
+	if (err)
+		return err;
+	err = ice_aq_get_fec_stats(hw, pcs_quad, pcs_port, ICE_FEC_CORR_HIGH,
+				   &fec_corr_high_val);
+	if (err)
+		return err;
+	err = ice_aq_get_fec_stats(hw, pcs_quad, pcs_port,
+				   ICE_FEC_UNCORR_LOW,
+				   &fec_uncorr_low_val);
+	if (err)
+		return err;
+	err = ice_aq_get_fec_stats(hw, pcs_quad, pcs_port,
+				   ICE_FEC_UNCORR_HIGH,
+				   &fec_uncorr_high_val);
+	if (err)
+		return err;
+
+	fec_stats->uncorrectable_blocks.total = (fec_corr_high_val << 16) +
+						 fec_corr_low_val;
+	fec_stats->corrected_blocks.total = (fec_uncorr_high_val << 16) +
+					     fec_uncorr_low_val;
+	return 0;
+}
+
+static void ice_get_fec_stats(struct net_device *netdev,
+			      struct ethtool_fec_stats *fec_stats)
+{
+	struct ice_netdev_priv *np = netdev_priv(netdev);
+	struct ice_port_topology port_topology;
+	struct ice_port_info *pi;
+	struct ice_pf *pf;
+	struct ice_hw *hw;
+	int err;
+
+	pf = np->vsi->back;
+	hw = &pf->hw;
+	pi = np->vsi->port_info;
+
+	if (!pi)
+		return;
+
+	/* Serdes parameters are not supported if not the PF VSI */
+	if (np->vsi->type != ICE_VSI_PF)
+		return;
+
+	err = ice_get_port_topology(hw, pi->lport, &port_topology);
+	if (err) {
+		netdev_info(netdev, "Extended register dump failed Lport %d\n",
+			    pi->lport);
+		return;
+	}
+
+	/* Get FEC correctable, uncorrectable counter */
+	err = ice_get_port_fec_stats(hw, port_topology.pcs_quad_select,
+				     port_topology.pcs_port, fec_stats);
+	if (err) {
+		netdev_info(netdev, "FEC stats get failed Lport %d Err %d\n",
+			    pi->lport, err);
+	}
+}
+
 static const struct ethtool_ops ice_ethtool_ops = {
 	.cap_rss_ctx_supported  = true,
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
@@ -4570,6 +4653,7 @@ static const struct ethtool_ops ice_ethtool_ops = {
 	.cap_rss_sym_xor_supported = true,
 	.get_link_ksettings	= ice_get_link_ksettings,
 	.set_link_ksettings	= ice_set_link_ksettings,
+	.get_fec_stats		= ice_get_fec_stats,
 	.get_drvinfo		= ice_get_drvinfo,
 	.get_regs_len		= ice_get_regs_len,
 	.get_regs		= ice_get_regs,
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index f0796a93f428..0aa17105dbdf 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -71,6 +71,14 @@ enum ice_aq_res_ids {
 	ICE_GLOBAL_CFG_LOCK_RES_ID
 };
 
+enum ice_fec_stats_types {
+	ICE_FEC_CORR_LOW,
+	ICE_FEC_CORR_HIGH,
+	ICE_FEC_UNCORR_LOW,
+	ICE_FEC_UNCORR_HIGH,
+	ICE_FEC_MAX
+};
+
 /* FW update timeout definitions are in milliseconds */
 #define ICE_NVM_TIMEOUT			180000
 #define ICE_CHANGE_LOCK_TIMEOUT		1000
-- 
2.44.0


