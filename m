Return-Path: <netdev+bounces-42752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 867007D009A
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 19:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EE431C20FC1
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 17:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C21374DB;
	Thu, 19 Oct 2023 17:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EaCLu0G8"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B24F354F2
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 17:32:39 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2EB130
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 10:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697736758; x=1729272758;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4/mJlxuHqWL9K/pur/wQEhxUvbWJnAf1mW1lZXzTFlw=;
  b=EaCLu0G8q1sFtJiVayvIrvhCLGlF7+caT6vyqSOOEGhwFJsoqDmJqTtS
   alNQ5KoVr4SvZmXNJeCKeWZc1PtE0CXtshQGjCT6DKuypnRwjnjsg1i+P
   EJZUjZE9HsIwb0+XoChnY+5bHsuHehWbItRA0y/WO3qT/AzA7Qh3wgi80
   2bQ42WtEOPfLlVdGWTKmJPgyiYE3WpTQtelV+wschgpEVLEpc08KkX2lu
   XiKKdO19RJC2OH2ME9hmSr+cPVSRevMk3HMcQFNx4b1OJ9ges3PDoCA+l
   KdHzQdEBpmb3kRUGtP+kXyZGewunoUDoBj061q6AVfqN9pQil2UzdfjP2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="389183715"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="389183715"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 10:32:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="760722703"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="760722703"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 10:32:36 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH net-next 09/11] ice: cleanup ice_find_netlist_node
Date: Thu, 19 Oct 2023 10:32:25 -0700
Message-ID: <20231019173227.3175575-10-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019173227.3175575-1-jacob.e.keller@intel.com>
References: <20231019173227.3175575-1-jacob.e.keller@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ice_find_netlist_node function was introduced in commit 8a3a565ff210
("ice: add admin commands to access cgu configuration"). Variations of this
function were reviewed concurrently on both intel-wired-lan[1][2], and
netdev [3][4]

[1]: https://lore.kernel.org/intel-wired-lan/20230913204943.1051233-7-vadim.fedorenko@linux.dev/
[2]: https://lore.kernel.org/intel-wired-lan/20230817000058.2433236-5-jacob.e.keller@intel.com/
[3]: https://lore.kernel.org/netdev/20230918212814.435688-1-anthony.l.nguyen@intel.com/
[4]: https://lore.kernel.org/netdev/20230913204943.1051233-7-vadim.fedorenko@linux.dev/

The variant I posted had a few changes due to review feedback which were
never incorporated into the DPLL series:

* Replace the references to ancient and long removed ICE_SUCCESS and
  ICE_ERR_DOES_NOT_EXIST status codes in the function comment.

* Return -ENOENT instead of -ENOTBLK, as a more common way to indicate that
  an entry doesn't exist.

* Avoid the use of memset() and use simple static initialization for the
  cmd variable.

* Use FIELD_PREP to assign the node_type_ctx.

* Remove an unnecessary local variable to keep track of rec_node_handle,
  just pass the node_handle pointer directly into ice_aq_get_netlist_node.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 30 ++++++++++-----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 8cbe63401378..377fae41bbae 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -473,41 +473,41 @@ ice_aq_get_netlist_node(struct ice_hw *hw, struct ice_aqc_get_link_topo *cmd,
  * @node_part_number: node part number to look for
  * @node_handle: output parameter if node found - optional
  *
- * Find and return the node handle for a given node type and part number in the
- * netlist. When found ICE_SUCCESS is returned, ICE_ERR_DOES_NOT_EXIST
- * otherwise. If node_handle provided, it would be set to found node handle.
+ * Scan the netlist for a node handle of the given node type and part number.
+ *
+ * If node_handle is non-NULL it will be modified on function exit. It is only
+ * valid if the function returns zero, and should be ignored on any non-zero
+ * return value.
+ *
+ * Returns: 0 if the node is found, -ENOENT if no handle was found, and
+ * a negative error code on failure to access the AQ.
  */
 static int ice_find_netlist_node(struct ice_hw *hw, u8 node_type_ctx,
 				 u8 node_part_number, u16 *node_handle)
 {
-	struct ice_aqc_get_link_topo cmd;
-	u8 rec_node_part_number;
-	u16 rec_node_handle;
 	u8 idx;
 
 	for (idx = 0; idx < ICE_MAX_NETLIST_SIZE; idx++) {
+		struct ice_aqc_get_link_topo cmd = {};
+		u8 rec_node_part_number;
 		int status;
 
-		memset(&cmd, 0, sizeof(cmd));
-
 		cmd.addr.topo_params.node_type_ctx =
-			(node_type_ctx << ICE_AQC_LINK_TOPO_NODE_TYPE_S);
+			FIELD_PREP(ICE_AQC_LINK_TOPO_NODE_TYPE_M,
+				   node_type_ctx);
 		cmd.addr.topo_params.index = idx;
 
 		status = ice_aq_get_netlist_node(hw, &cmd,
 						 &rec_node_part_number,
-						 &rec_node_handle);
+						 node_handle);
 		if (status)
 			return status;
 
-		if (rec_node_part_number == node_part_number) {
-			if (node_handle)
-				*node_handle = rec_node_handle;
+		if (rec_node_part_number == node_part_number)
 			return 0;
-		}
 	}
 
-	return -ENOTBLK;
+	return -ENOENT;
 }
 
 /**
-- 
2.41.0


