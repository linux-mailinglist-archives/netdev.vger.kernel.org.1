Return-Path: <netdev+bounces-89546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 843C68AA9F9
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 10:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A85051C21C9B
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 08:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9862D4EB58;
	Fri, 19 Apr 2024 08:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CC2AoSKK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03474DA0D
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 08:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713514724; cv=none; b=MnUYYREhyyXEit2O4H9RCQ99aKwH6BfJXaWQNb/K0s/0CAhDYj7MPrr2KtYU2mvw3gY4aO6dfvTixrb5licMPvZG37/abuxj/FTA6xK2P15NCsg5GnsQabPXEBWjqCQ8o1ELikNucCPOZ7otGt0DHbVSAWTUcOJK3EXaNEixznM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713514724; c=relaxed/simple;
	bh=ZevRkRJLYEHJyzXLayGGrM0HydhLjOyHP7tmDSo89wc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l8uZuI50hRNwz6Y5dJS/ZfJl1YKA3ZgJ5/3GiWrJZfaGtw1oGsi9pm83OODSt2QhFeVxCe0UOE/LBxlYlNCZECYs33BuEnAxrQlTbSrK2BTbVX3wPMTnjQP+Uzy1oIoDT+d++G0Q44PsLOS17Z+PgfdIuSdgLnUcOXD66tRjCMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CC2AoSKK; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713514724; x=1745050724;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZevRkRJLYEHJyzXLayGGrM0HydhLjOyHP7tmDSo89wc=;
  b=CC2AoSKKy4bFCboLNkCiolXwIavFxvQtyJn5+5PtBDaB7uRZ9fydnd9m
   sAVirGzDqfCFVrwEKx7UHxDAbv76aYJmW5SQEXjZKzEndy6YQC0/pqKka
   B94QCfReHIwSTXC1+9QvQK02J8f0N98P9WoWgNq/YM8vz3EyCa9lplD3k
   FjbuL83YINPiF5LcY/KhJa72MI6lqz4oiiSNJgrlyb5lJOuDCoZ/l/ey8
   EDuoy8kAlprB9W4VOhHOWm/MVreZ55y2mc7dq0ZOHWZK/cUUVKt/Bz2ZL
   h5bHuVB3ordbFkF1sznLc6m0Wfux9MTUDlZ8JGShmWG98d3TMpxi0hS2a
   A==;
X-CSE-ConnectionGUID: nHqFe2LCQ4mG94zKOgJLJw==
X-CSE-MsgGUID: swXZBEXxQhaMc59h4zYbZA==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="9028082"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="9028082"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 01:18:43 -0700
X-CSE-ConnectionGUID: XQ8G9hV/SN6tSCqx0mmLxw==
X-CSE-MsgGUID: 8oiL1LypRVe5SD7TqMzpTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="23244464"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa009.jf.intel.com with ESMTP; 19 Apr 2024 01:18:39 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id F029028195;
	Fri, 19 Apr 2024 09:18:26 +0100 (IST)
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
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [Intel-wired-lan] [PATCH net-next v10 3/6] ice: Adjust the VSI/Aggregator layers
Date: Fri, 19 Apr 2024 04:08:51 -0400
Message-Id: <20240419080854.10000-4-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240419080854.10000-1-mateusz.polchlopek@intel.com>
References: <20240419080854.10000-1-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Raj Victor <victor.raj@intel.com>

Adjust the VSI/Aggregator layers based on the number of logical layers
supported by the FW. Currently the VSI and Aggregator layers are
fixed based on the 9 layer scheduler tree layout. Due to performance
reasons the number of layers of the scheduler tree is changing from
9 to 5. It requires a readjustment of these VSI/Aggregator layer values.

Signed-off-by: Raj Victor <victor.raj@intel.com>
Co-developed-by: Michal Wilczynski <michal.wilczynski@intel.com>
Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_sched.c | 37 +++++++++++-----------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index a1525992d14b..ecf8f5d60292 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -1128,12 +1128,11 @@ u8 ice_sched_get_vsi_layer(struct ice_hw *hw)
 	 *     5 or less       sw_entry_point_layer
 	 */
 	/* calculate the VSI layer based on number of layers. */
-	if (hw->num_tx_sched_layers > ICE_VSI_LAYER_OFFSET + 1) {
-		u8 layer = hw->num_tx_sched_layers - ICE_VSI_LAYER_OFFSET;
-
-		if (layer > hw->sw_entry_point_layer)
-			return layer;
-	}
+	if (hw->num_tx_sched_layers == ICE_SCHED_9_LAYERS)
+		return hw->num_tx_sched_layers - ICE_VSI_LAYER_OFFSET;
+	else if (hw->num_tx_sched_layers == ICE_SCHED_5_LAYERS)
+		/* qgroup and VSI layers are same */
+		return hw->num_tx_sched_layers - ICE_QGRP_LAYER_OFFSET;
 	return hw->sw_entry_point_layer;
 }
 
@@ -1150,13 +1149,10 @@ u8 ice_sched_get_agg_layer(struct ice_hw *hw)
 	 *     7 or less       sw_entry_point_layer
 	 */
 	/* calculate the aggregator layer based on number of layers. */
-	if (hw->num_tx_sched_layers > ICE_AGG_LAYER_OFFSET + 1) {
-		u8 layer = hw->num_tx_sched_layers - ICE_AGG_LAYER_OFFSET;
-
-		if (layer > hw->sw_entry_point_layer)
-			return layer;
-	}
-	return hw->sw_entry_point_layer;
+	if (hw->num_tx_sched_layers == ICE_SCHED_9_LAYERS)
+		return hw->num_tx_sched_layers - ICE_AGG_LAYER_OFFSET;
+	else
+		return hw->sw_entry_point_layer;
 }
 
 /**
@@ -1510,10 +1506,11 @@ ice_sched_get_free_qparent(struct ice_port_info *pi, u16 vsi_handle, u8 tc,
 {
 	struct ice_sched_node *vsi_node, *qgrp_node;
 	struct ice_vsi_ctx *vsi_ctx;
+	u8 qgrp_layer, vsi_layer;
 	u16 max_children;
-	u8 qgrp_layer;
 
 	qgrp_layer = ice_sched_get_qgrp_layer(pi->hw);
+	vsi_layer = ice_sched_get_vsi_layer(pi->hw);
 	max_children = pi->hw->max_children[qgrp_layer];
 
 	vsi_ctx = ice_get_vsi_ctx(pi->hw, vsi_handle);
@@ -1524,6 +1521,12 @@ ice_sched_get_free_qparent(struct ice_port_info *pi, u16 vsi_handle, u8 tc,
 	if (!vsi_node)
 		return NULL;
 
+	/* If the queue group and VSI layer are same then queues
+	 * are all attached directly to VSI
+	 */
+	if (qgrp_layer == vsi_layer)
+		return vsi_node;
+
 	/* get the first queue group node from VSI sub-tree */
 	qgrp_node = ice_sched_get_first_node(pi, vsi_node, qgrp_layer);
 	while (qgrp_node) {
@@ -3199,7 +3202,7 @@ ice_sched_add_rl_profile(struct ice_port_info *pi,
 	u8 profile_type;
 	int status;
 
-	if (layer_num >= ICE_AQC_TOPO_MAX_LEVEL_NUM)
+	if (!pi || layer_num >= pi->hw->num_tx_sched_layers)
 		return NULL;
 	switch (rl_type) {
 	case ICE_MIN_BW:
@@ -3215,8 +3218,6 @@ ice_sched_add_rl_profile(struct ice_port_info *pi,
 		return NULL;
 	}
 
-	if (!pi)
-		return NULL;
 	hw = pi->hw;
 	list_for_each_entry(rl_prof_elem, &pi->rl_prof_list[layer_num],
 			    list_entry)
@@ -3446,7 +3447,7 @@ ice_sched_rm_rl_profile(struct ice_port_info *pi, u8 layer_num, u8 profile_type,
 	struct ice_aqc_rl_profile_info *rl_prof_elem;
 	int status = 0;
 
-	if (layer_num >= ICE_AQC_TOPO_MAX_LEVEL_NUM)
+	if (layer_num >= pi->hw->num_tx_sched_layers)
 		return -EINVAL;
 	/* Check the existing list for RL profile */
 	list_for_each_entry(rl_prof_elem, &pi->rl_prof_list[layer_num],
-- 
2.38.1


