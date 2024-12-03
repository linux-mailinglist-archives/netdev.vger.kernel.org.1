Return-Path: <netdev+bounces-148693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B11219E2F6B
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 00:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9ABCEB3C596
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 21:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD8420B808;
	Tue,  3 Dec 2024 21:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cTS+jLCy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA6B20A5C2
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 21:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733262932; cv=none; b=Xb0og/dvrSOYeoEP/ThUtdGA3G2l2WYV7SVqIuVywdrPK3TjYDzN7aMVkvzU3Y7f+wFrLkYeGSZujuXay5k5bYkf9ARGLQ6Nk+2JBc0Q5RJjSo/25yVVL7rJMZZeT8jCWQVKReFe+iTtsfubh0SkE28hcDkOQ2udCFtjtwzrAvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733262932; c=relaxed/simple;
	bh=PvvJzR4B5qMPuIDfMD4TNsJDp2Tw1/PM/ZMFomPXBPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AswSF8KltHPZQlEnh9allp6JHh8GWkXpvuMaI0cJSxylng0LgRJStB4A3qX//Ml6gHCQ1HjZbOHU5Yh0nIPJD0hm3sgnqoz4fvII2QK4noLW5NX71v2Adf6SUID95064nUxYp15KEJRAa8a78zdMy7W9RiIbIF+++CunMXTCBWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cTS+jLCy; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733262931; x=1764798931;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PvvJzR4B5qMPuIDfMD4TNsJDp2Tw1/PM/ZMFomPXBPI=;
  b=cTS+jLCyKq1hAfpiYkk7tmrWgLRBS5h6QtGwJuMFPbGp4p+LZgUanbcc
   J+evXMP6eaNR2eem7wQ8M6efDGRrz/u2Q2XEdWIdQ3wx1GnXqQWFKIV3x
   w/dnNX/c1tN1wxMz7P2ZB7KfxLWNuOUkI7HN3GcvTlSqf7rXrIoAzmrvO
   /9VzNv/pcAEPMxr37JtcGSsA6dkHUaO0r0zrcMxHLb06oMp6bn1Y+1CAn
   /5wYNdwvxM7Q1TlKz6Htw0S52fY35bj4lgV2K416PTp8RuJL2XYqpzB0K
   aM9lZduOXfy6FVge0ktMn2UIWpmkaKVQ03Fw5H1xBSlBrRdKJQqudouzk
   Q==;
X-CSE-ConnectionGUID: YZBBa6u7R0uUpJvUpzVTXw==
X-CSE-MsgGUID: T7SoxdoqQOCmbihWIMSNiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="21087111"
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="21087111"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 13:55:29 -0800
X-CSE-ConnectionGUID: DrMLAZQCRryuPQbUPn8QCg==
X-CSE-MsgGUID: pYkXzYxCTKm5wzdTK9+IFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="98578867"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa003.jf.intel.com with ESMTP; 03 Dec 2024 13:55:29 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	horms@kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net 1/9] ice: fix PHY Clock Recovery availability check
Date: Tue,  3 Dec 2024 13:55:10 -0800
Message-ID: <20241203215521.1646668-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20241203215521.1646668-1-anthony.l.nguyen@intel.com>
References: <20241203215521.1646668-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

To check if PHY Clock Recovery mechanic is available for a device, there
is a need to verify if given PHY is available within the netlist, but the
netlist node type used for the search is wrong, also the search context
shall be specified.

Modify the search function to allow specifying the context in the
search.

Use the PHY node type instead of CLOCK CONTROLLER type, also use proper
search context which for PHY search is PORT, as defined in E810
Datasheet [1] ('3.3.8.2.4 Node Part Number and Node Options (0x0003)' and
'Table 3-105. Program Topology Device NVM Admin Command').

[1] https://cdrdv2.intel.com/v1/dl/getContent/613875?explicitVersion=true

Fixes: 91e43ca0090b ("ice: fix linking when CONFIG_PTP_1588_CLOCK=n")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 25 ++++++++++++++-------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index b22e71dc59d4..496d86cbd13f 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -542,7 +542,8 @@ ice_aq_get_netlist_node(struct ice_hw *hw, struct ice_aqc_get_link_topo *cmd,
 /**
  * ice_find_netlist_node
  * @hw: pointer to the hw struct
- * @node_type_ctx: type of netlist node to look for
+ * @node_type: type of netlist node to look for
+ * @ctx: context of the search
  * @node_part_number: node part number to look for
  * @node_handle: output parameter if node found - optional
  *
@@ -552,10 +553,12 @@ ice_aq_get_netlist_node(struct ice_hw *hw, struct ice_aqc_get_link_topo *cmd,
  * valid if the function returns zero, and should be ignored on any non-zero
  * return value.
  *
- * Returns: 0 if the node is found, -ENOENT if no handle was found, and
- * a negative error code on failure to access the AQ.
+ * Return:
+ * * 0 if the node is found,
+ * * -ENOENT if no handle was found,
+ * * negative error code on failure to access the AQ.
  */
-static int ice_find_netlist_node(struct ice_hw *hw, u8 node_type_ctx,
+static int ice_find_netlist_node(struct ice_hw *hw, u8 node_type, u8 ctx,
 				 u8 node_part_number, u16 *node_handle)
 {
 	u8 idx;
@@ -566,8 +569,8 @@ static int ice_find_netlist_node(struct ice_hw *hw, u8 node_type_ctx,
 		int status;
 
 		cmd.addr.topo_params.node_type_ctx =
-			FIELD_PREP(ICE_AQC_LINK_TOPO_NODE_TYPE_M,
-				   node_type_ctx);
+			FIELD_PREP(ICE_AQC_LINK_TOPO_NODE_TYPE_M, node_type) |
+			FIELD_PREP(ICE_AQC_LINK_TOPO_NODE_CTX_M, ctx);
 		cmd.addr.topo_params.index = idx;
 
 		status = ice_aq_get_netlist_node(hw, &cmd,
@@ -2747,9 +2750,11 @@ bool ice_is_pf_c827(struct ice_hw *hw)
  */
 bool ice_is_phy_rclk_in_netlist(struct ice_hw *hw)
 {
-	if (ice_find_netlist_node(hw, ICE_AQC_LINK_TOPO_NODE_TYPE_CLK_CTRL,
+	if (ice_find_netlist_node(hw, ICE_AQC_LINK_TOPO_NODE_TYPE_PHY,
+				  ICE_AQC_LINK_TOPO_NODE_CTX_PORT,
 				  ICE_AQC_GET_LINK_TOPO_NODE_NR_C827, NULL) &&
-	    ice_find_netlist_node(hw, ICE_AQC_LINK_TOPO_NODE_TYPE_CLK_CTRL,
+	    ice_find_netlist_node(hw, ICE_AQC_LINK_TOPO_NODE_TYPE_PHY,
+				  ICE_AQC_LINK_TOPO_NODE_CTX_PORT,
 				  ICE_AQC_GET_LINK_TOPO_NODE_NR_E822_PHY, NULL))
 		return false;
 
@@ -2765,6 +2770,7 @@ bool ice_is_phy_rclk_in_netlist(struct ice_hw *hw)
 bool ice_is_clock_mux_in_netlist(struct ice_hw *hw)
 {
 	if (ice_find_netlist_node(hw, ICE_AQC_LINK_TOPO_NODE_TYPE_CLK_MUX,
+				  ICE_AQC_LINK_TOPO_NODE_CTX_GLOBAL,
 				  ICE_AQC_GET_LINK_TOPO_NODE_NR_GEN_CLK_MUX,
 				  NULL))
 		return false;
@@ -2785,12 +2791,14 @@ bool ice_is_clock_mux_in_netlist(struct ice_hw *hw)
 bool ice_is_cgu_in_netlist(struct ice_hw *hw)
 {
 	if (!ice_find_netlist_node(hw, ICE_AQC_LINK_TOPO_NODE_TYPE_CLK_CTRL,
+				   ICE_AQC_LINK_TOPO_NODE_CTX_GLOBAL,
 				   ICE_AQC_GET_LINK_TOPO_NODE_NR_ZL30632_80032,
 				   NULL)) {
 		hw->cgu_part_number = ICE_AQC_GET_LINK_TOPO_NODE_NR_ZL30632_80032;
 		return true;
 	} else if (!ice_find_netlist_node(hw,
 					  ICE_AQC_LINK_TOPO_NODE_TYPE_CLK_CTRL,
+					  ICE_AQC_LINK_TOPO_NODE_CTX_GLOBAL,
 					  ICE_AQC_GET_LINK_TOPO_NODE_NR_SI5383_5384,
 					  NULL)) {
 		hw->cgu_part_number = ICE_AQC_GET_LINK_TOPO_NODE_NR_SI5383_5384;
@@ -2809,6 +2817,7 @@ bool ice_is_cgu_in_netlist(struct ice_hw *hw)
 bool ice_is_gps_in_netlist(struct ice_hw *hw)
 {
 	if (ice_find_netlist_node(hw, ICE_AQC_LINK_TOPO_NODE_TYPE_GPS,
+				  ICE_AQC_LINK_TOPO_NODE_CTX_GLOBAL,
 				  ICE_AQC_GET_LINK_TOPO_NODE_NR_GEN_GPS, NULL))
 		return false;
 
-- 
2.42.0


