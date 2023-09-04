Return-Path: <netdev+bounces-31926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B50A179172F
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 14:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECB0B1C208B2
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 12:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF29A924;
	Mon,  4 Sep 2023 12:34:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F96E8F73
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 12:34:22 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C013A1B7;
	Mon,  4 Sep 2023 05:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693830860; x=1725366860;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OamUofaSFnk4Lj5AHZy+Do0gP7t3e3jM/3c3+1xCt7Q=;
  b=MO25WD2Ig5DK5JnN19JkIjllQh1suc2nHnAvAouG6l5yi9X+7QtLRxDq
   9nO5bJfH6+C+flXHEMF2ZGxQjnEks2+7e4rCN28hq+GxDPPEH+FzS6Hm8
   cj7LAO7ak/LOCe+O/E9l6seZdxjnuGkkIGwpe0Hj+0c08FQQv6SBBl75T
   OsyM0AzPXdrHC6qSJGk85CLWdQtIwvAgqI9q6ASM0+H2nimn0IK3+zENu
   Qu5UJ/MAuF6zQ2+NzR/1OCZ7yIloxl4O1Shp8q5phDZW8fJMhGuOM/Fwj
   SpkFkVz+iTvqSO6W1jrm6At7Yiy+u3YL4/GQD4J9EbmXvsOzyG6GvCaX/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="373977143"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="373977143"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 05:34:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="740749746"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="740749746"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga002.jf.intel.com with ESMTP; 04 Sep 2023 05:34:16 -0700
Received: from pelor.igk.intel.com (pelor.igk.intel.com [10.123.220.13])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 7AD5A33EBF;
	Mon,  4 Sep 2023 13:34:15 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-hardening@vger.kernel.org,
	Steven Zou <steven.zou@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Anthony Nguyen <anthony.l.nguyen@intel.com>,
	David Laight <David.Laight@ACULAB.COM>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [RFC net-next v4 2/7] ice: ice_sched_remove_elems: replace 1 elem array param by u32
Date: Mon,  4 Sep 2023 08:31:02 -0400
Message-Id: <20230904123107.116381-3-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230904123107.116381-1-przemyslaw.kitszel@intel.com>
References: <20230904123107.116381-1-przemyslaw.kitszel@intel.com>
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

Replace array+size params of ice_sched_remove_elems:() by just single u32,
as all callers are using it with "1".

This enables moving from heap-based, to stack-based allocation, what is also
more elegant thanks to DEFINE_FLEX() macro.

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
add/remove: 2/2 grow/shrink: 0/2 up/down: 252/-388 (-136)
---
 drivers/net/ethernet/intel/ice/ice_sched.c | 26 ++++++++--------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index c0533d7b66b9..efa5cb202eac 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -229,37 +229,29 @@ ice_aq_delete_sched_elems(struct ice_hw *hw, u16 grps_req,
  * ice_sched_remove_elems - remove nodes from HW
  * @hw: pointer to the HW struct
  * @parent: pointer to the parent node
- * @num_nodes: number of nodes
- * @node_teids: array of node teids to be deleted
+ * @node_teid: node teid to be deleted
  *
  * This function remove nodes from HW
  */
 static int
 ice_sched_remove_elems(struct ice_hw *hw, struct ice_sched_node *parent,
-		       u16 num_nodes, u32 *node_teids)
+		       u32 node_teid)
 {
-	struct ice_aqc_delete_elem *buf;
-	u16 i, num_groups_removed = 0;
-	u16 buf_size;
+	DEFINE_FLEX(struct ice_aqc_delete_elem, buf, teid, 1);
+	u16 buf_size = __struct_size(buf);
+	u16 num_groups_removed = 0;
 	int status;
 
-	buf_size = struct_size(buf, teid, num_nodes);
-	buf = devm_kzalloc(ice_hw_to_dev(hw), buf_size, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
 	buf->hdr.parent_teid = parent->info.node_teid;
-	buf->hdr.num_elems = cpu_to_le16(num_nodes);
-	for (i = 0; i < num_nodes; i++)
-		buf->teid[i] = cpu_to_le32(node_teids[i]);
+	buf->hdr.num_elems = cpu_to_le16(1);
+	buf->teid[0] = cpu_to_le32(node_teid);
 
 	status = ice_aq_delete_sched_elems(hw, 1, buf, buf_size,
 					   &num_groups_removed, NULL);
 	if (status || num_groups_removed != 1)
 		ice_debug(hw, ICE_DBG_SCHED, "remove node failed FW error %d\n",
 			  hw->adminq.sq_last_status);
 
-	devm_kfree(ice_hw_to_dev(hw), buf);
 	return status;
 }
 
@@ -326,7 +318,7 @@ void ice_free_sched_node(struct ice_port_info *pi, struct ice_sched_node *node)
 	    node->info.data.elem_type != ICE_AQC_ELEM_TYPE_LEAF) {
 		u32 teid = le32_to_cpu(node->info.node_teid);
 
-		ice_sched_remove_elems(hw, node->parent, 1, &teid);
+		ice_sched_remove_elems(hw, node->parent, teid);
 	}
 	parent = node->parent;
 	/* root has no parent */
@@ -1193,7 +1185,7 @@ static void ice_rm_dflt_leaf_node(struct ice_port_info *pi)
 		int status;
 
 		/* remove the default leaf node */
-		status = ice_sched_remove_elems(pi->hw, node->parent, 1, &teid);
+		status = ice_sched_remove_elems(pi->hw, node->parent, teid);
 		if (!status)
 			ice_free_sched_node(pi, node);
 	}
-- 
2.40.1


