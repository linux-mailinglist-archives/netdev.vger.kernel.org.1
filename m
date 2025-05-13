Return-Path: <netdev+bounces-190109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C58DAB5345
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 12:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 273AB3ABBF6
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 10:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA1D286D50;
	Tue, 13 May 2025 10:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e6kgcb8T"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34A918EFD4
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 10:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747133754; cv=none; b=VShy23BDqdCKvoypeaygv3vzywNcCBTbH0Bp4EH5+VCSWiB6gztbzxp7gbVT+6loxJnnXanCPa7ii7nYc80Rh/RNOVwYoQj3VtAsLDDTo3t2iYIAKxKu/VfbBcwbeqF9mMcV2Ho0bfqLHJ7Qe+Ok1ePhqDUyFnIcd0Xjbnc2pFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747133754; c=relaxed/simple;
	bh=jEuc8oG1zoj+1FvFFD0JTEeZGZF00r/3x6Ok+rnihfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X6WOJ2dLJEU5tC1LmCMUqXLSLRTAjRoBt5ImS73Uojxy1a5mY7I+KXlCJ/8QvqQbOXhHxEHKITs/T5ADnHOO5SVPfU6je2iZY17g3G6lNPCUIYB2z98Nvqbag+FxwWrhMU/Evc0Wrdcvo7yuGbbPExZmCMDJn8dwbwb/BcGYIVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e6kgcb8T; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747133753; x=1778669753;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jEuc8oG1zoj+1FvFFD0JTEeZGZF00r/3x6Ok+rnihfY=;
  b=e6kgcb8T6HXVr6tnrLX5159ThJSodfV7DQq+zKfwI5eKMH8zoryisd3w
   kfHFHwGXH19TvFwmyPdlGYWuJo3BwwoML/TtmiS4fOc7m6Kys2qsCOTz+
   BjJmQTW58vr+wNUbA54zPkB3SR+JR4ouU5wg4DhSCeBh9g0MCDmJPS9UA
   0PsrsxaGX5u8Fmt4ElBkwE9HrP38Pqfc3WEUMVugENzzJ6pZsAAzqsDlb
   WRVKuGvG4PZiv5Z8R7pUbuNBY1GjJkb25HFe7L7UwnCTG56FHjNF0SLLM
   80h8N6LFMUiHY4STi4OVtfBe9fkqBPtZ0Sjno6/KuBYO//fayPNJQr2m9
   w==;
X-CSE-ConnectionGUID: L91YQ2DfSSCfmKzqLbEqlw==
X-CSE-MsgGUID: T0WgJ2wgSW2+x26uDw7XOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="52630671"
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; 
   d="scan'208";a="52630671"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 03:55:53 -0700
X-CSE-ConnectionGUID: MyYthPTsQLOSfaqbAMY1eQ==
X-CSE-MsgGUID: YJMLCoLFQa24tJssWaxJRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; 
   d="scan'208";a="138600555"
Received: from gk3153-pr4-x299-22869.igk.intel.com (HELO localhost.igk.intel.com) ([10.102.21.130])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 03:55:50 -0700
From: Michal Kubiak <michal.kubiak@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: maciej.fijalkowski@intel.com,
	aleksander.lobakin@intel.com,
	przemyslaw.kitszel@intel.com,
	dawid.osuchowski@linux.intel.com,
	jacob.e.keller@intel.com,
	jbrandeburg@cloudflare.com,
	netdev@vger.kernel.org,
	Michal Kubiak <michal.kubiak@intel.com>
Subject: [PATCH iwl-net v3 2/3] ice: create new Tx scheduler nodes for new queues only
Date: Tue, 13 May 2025 12:55:28 +0200
Message-ID: <20250513105529.241745-3-michal.kubiak@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250513105529.241745-1-michal.kubiak@intel.com>
References: <20250513105529.241745-1-michal.kubiak@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current implementation of the Tx scheduler tree attempts
to create nodes for all Tx queues, ignoring the fact that some
queues may already exist in the tree. For example, if the VSI
already has 128 Tx queues and the user requests for 16 new queues,
the Tx scheduler will compute the tree for 272 queues (128 existing
queues + 144 new queues), instead of 144 queues (128 existing queues
and 16 new queues).
Fix that by modifying the node count calculation algorithm to skip
the queues that already exist in the tree.

Fixes: 5513b920a4f7 ("ice: Update Tx scheduler tree for VSI multi-Tx queue support")
Reviewed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_sched.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index 6ca13c5dcb14..6524875b34d3 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -1604,16 +1604,16 @@ ice_sched_get_agg_node(struct ice_port_info *pi, struct ice_sched_node *tc_node,
 /**
  * ice_sched_calc_vsi_child_nodes - calculate number of VSI child nodes
  * @hw: pointer to the HW struct
- * @num_qs: number of queues
+ * @num_new_qs: number of new queues that will be added to the tree
  * @num_nodes: num nodes array
  *
  * This function calculates the number of VSI child nodes based on the
  * number of queues.
  */
 static void
-ice_sched_calc_vsi_child_nodes(struct ice_hw *hw, u16 num_qs, u16 *num_nodes)
+ice_sched_calc_vsi_child_nodes(struct ice_hw *hw, u16 num_new_qs, u16 *num_nodes)
 {
-	u16 num = num_qs;
+	u16 num = num_new_qs;
 	u8 i, qgl, vsil;
 
 	qgl = ice_sched_get_qgrp_layer(hw);
@@ -1863,8 +1863,9 @@ ice_sched_update_vsi_child_nodes(struct ice_port_info *pi, u16 vsi_handle,
 			return status;
 	}
 
-	if (new_numqs)
-		ice_sched_calc_vsi_child_nodes(hw, new_numqs, new_num_nodes);
+	ice_sched_calc_vsi_child_nodes(hw, new_numqs - prev_numqs,
+				       new_num_nodes);
+
 	/* Keep the max number of queue configuration all the time. Update the
 	 * tree only if number of queues > previous number of queues. This may
 	 * leave some extra nodes in the tree if number of queues < previous
-- 
2.45.2


