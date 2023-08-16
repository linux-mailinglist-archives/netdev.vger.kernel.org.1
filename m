Return-Path: <netdev+bounces-28223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3008D77EB25
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 22:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7230281C59
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 20:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAC51BF0D;
	Wed, 16 Aug 2023 20:54:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9B11BF0B
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 20:54:37 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D277E69
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 13:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692219276; x=1723755276;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XbmtA2C+RU2d+Qo1Lr06KVyu7ho2nS/z+wzXXqktiRs=;
  b=Toer0PEaaxQW8OvzFW6ohwzJDjBh+mCpn8bkTuuAm02fCuzHbQxktYjc
   4jpWUZzMrJuwXN/3K4/PWIIOvYKLf23aLAUbBSCUXij0n4L9LQicAzSbh
   9ck+GR8ue7ct7S0WPCoxl7CBM5nHE57gyH0xCHuJiEcIR6eoRG0CtYdgH
   pzQOJX7EJQim8/kgDqAZE6Qt9Qh7TgToCyqpeEdP+txTJ4/sPZwKzBV0O
   05tV5vDFPPlZ6W9qQREGsiNYuBqgpFrHvUK2uHGbyxXGhycNDWsPVZvN0
   va93n2/Z6Y9O9COiDS5OopwfIgUBrFyEHypgfyDr2lqXty4th1jXR+klT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="357604816"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="357604816"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 13:54:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="848626406"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="848626406"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga002.fm.intel.com with ESMTP; 16 Aug 2023 13:54:33 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	anthony.l.nguyen@intel.com,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 11/14] ice: drop two params from ice_aq_alloc_free_res()
Date: Wed, 16 Aug 2023 13:47:33 -0700
Message-Id: <20230816204736.1325132-12-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230816204736.1325132-1-anthony.l.nguyen@intel.com>
References: <20230816204736.1325132-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Drop @num_entries and @cd params, latter of which was always NULL.

Number of entities to alloc is passed in internal buffer, the outer layer
(that @num_entries was assigned to) meaning is closer to "the number of
requests", which was =1 in all cases.
ice_free_hw_res() was always called with 1 as its @num arg.

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 24 +++++++--------------
 drivers/net/ethernet/intel/ice/ice_common.h |  7 +++---
 drivers/net/ethernet/intel/ice/ice_lag.c    |  9 ++++----
 drivers/net/ethernet/intel/ice/ice_switch.c | 16 ++++++--------
 4 files changed, 22 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index a86255b529a0..80deca45ab59 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -2000,37 +2000,31 @@ void ice_release_res(struct ice_hw *hw, enum ice_aq_res_ids res)
 /**
  * ice_aq_alloc_free_res - command to allocate/free resources
  * @hw: pointer to the HW struct
- * @num_entries: number of resource entries in buffer
  * @buf: Indirect buffer to hold data parameters and response
  * @buf_size: size of buffer for indirect commands
  * @opc: pass in the command opcode
- * @cd: pointer to command details structure or NULL
  *
  * Helper function to allocate/free resources using the admin queue commands
  */
-int
-ice_aq_alloc_free_res(struct ice_hw *hw, u16 num_entries,
-		      struct ice_aqc_alloc_free_res_elem *buf, u16 buf_size,
-		      enum ice_adminq_opc opc, struct ice_sq_cd *cd)
+int ice_aq_alloc_free_res(struct ice_hw *hw,
+			  struct ice_aqc_alloc_free_res_elem *buf, u16 buf_size,
+			  enum ice_adminq_opc opc)
 {
 	struct ice_aqc_alloc_free_res_cmd *cmd;
 	struct ice_aq_desc desc;
 
 	cmd = &desc.params.sw_res_ctrl;
 
-	if (!buf)
-		return -EINVAL;
-
-	if (buf_size < flex_array_size(buf, elem, num_entries))
+	if (!buf || buf_size < flex_array_size(buf, elem, 1))
 		return -EINVAL;
 
 	ice_fill_dflt_direct_cmd_desc(&desc, opc);
 
 	desc.flags |= cpu_to_le16(ICE_AQ_FLAG_RD);
 
-	cmd->num_entries = cpu_to_le16(num_entries);
+	cmd->num_entries = cpu_to_le16(1);
 
-	return ice_aq_send_cmd(hw, &desc, buf, buf_size, cd);
+	return ice_aq_send_cmd(hw, &desc, buf, buf_size, NULL);
 }
 
 /**
@@ -2060,8 +2054,7 @@ ice_alloc_hw_res(struct ice_hw *hw, u16 type, u16 num, bool btm, u16 *res)
 	if (btm)
 		buf->res_type |= cpu_to_le16(ICE_AQC_RES_TYPE_FLAG_SCAN_BOTTOM);
 
-	status = ice_aq_alloc_free_res(hw, 1, buf, buf_len,
-				       ice_aqc_opc_alloc_res, NULL);
+	status = ice_aq_alloc_free_res(hw, buf, buf_len, ice_aqc_opc_alloc_res);
 	if (status)
 		goto ice_alloc_res_exit;
 
@@ -2095,8 +2088,7 @@ int ice_free_hw_res(struct ice_hw *hw, u16 type, u16 num, u16 *res)
 	buf->res_type = cpu_to_le16(type);
 	memcpy(buf->elem, res, sizeof(*buf->elem) * num);
 
-	status = ice_aq_alloc_free_res(hw, num, buf, buf_len,
-				       ice_aqc_opc_free_res, NULL);
+	status = ice_aq_alloc_free_res(hw, buf, buf_len, ice_aqc_opc_free_res);
 	if (status)
 		ice_debug(hw, ICE_DBG_SW, "CQ CMD Buffer:\n");
 
diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index 71b82cdf4a6d..226b81f97a92 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -38,10 +38,9 @@ int
 ice_alloc_hw_res(struct ice_hw *hw, u16 type, u16 num, bool btm, u16 *res);
 int
 ice_free_hw_res(struct ice_hw *hw, u16 type, u16 num, u16 *res);
-int
-ice_aq_alloc_free_res(struct ice_hw *hw, u16 num_entries,
-		      struct ice_aqc_alloc_free_res_elem *buf, u16 buf_size,
-		      enum ice_adminq_opc opc, struct ice_sq_cd *cd);
+int ice_aq_alloc_free_res(struct ice_hw *hw,
+			  struct ice_aqc_alloc_free_res_elem *buf, u16 buf_size,
+			  enum ice_adminq_opc opc);
 bool ice_is_sbq_supported(struct ice_hw *hw);
 struct ice_ctl_q_info *ice_get_sbq(struct ice_hw *hw);
 int
diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
index a68974c1aa38..4f39863b5537 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.c
+++ b/drivers/net/ethernet/intel/ice/ice_lag.c
@@ -983,9 +983,8 @@ ice_lag_set_swid(u16 primary_swid, struct ice_lag *local_lag,
 	/* if unlinnking need to free the shared resource */
 	if (!link && local_lag->bond_swid) {
 		buf->elem[0].e.sw_resp = cpu_to_le16(local_lag->bond_swid);
-		status = ice_aq_alloc_free_res(&local_lag->pf->hw, 1, buf,
-					       buf_len, ice_aqc_opc_free_res,
-					       NULL);
+		status = ice_aq_alloc_free_res(&local_lag->pf->hw, buf,
+					       buf_len, ice_aqc_opc_free_res);
 		if (status)
 			dev_err(ice_pf_to_dev(local_lag->pf), "Error freeing SWID during LAG unlink\n");
 		local_lag->bond_swid = 0;
@@ -1002,8 +1001,8 @@ ice_lag_set_swid(u16 primary_swid, struct ice_lag *local_lag,
 			cpu_to_le16(local_lag->pf->hw.port_info->sw_id);
 	}
 
-	status = ice_aq_alloc_free_res(&local_lag->pf->hw, 1, buf, buf_len,
-				       ice_aqc_opc_alloc_res, NULL);
+	status = ice_aq_alloc_free_res(&local_lag->pf->hw, buf, buf_len,
+				       ice_aqc_opc_alloc_res);
 	if (status)
 		dev_err(ice_pf_to_dev(local_lag->pf), "Error subscribing to SWID 0x%04X\n",
 			local_lag->bond_swid);
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 24c3f481848b..2f77b684ff76 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -1847,7 +1847,7 @@ ice_aq_alloc_free_vsi_list(struct ice_hw *hw, u16 *vsi_list_id,
 	if (opc == ice_aqc_opc_free_res)
 		sw_buf->elem[0].e.sw_resp = cpu_to_le16(*vsi_list_id);
 
-	status = ice_aq_alloc_free_res(hw, 1, sw_buf, buf_len, opc, NULL);
+	status = ice_aq_alloc_free_res(hw, sw_buf, buf_len, opc);
 	if (status)
 		goto ice_aq_alloc_free_vsi_list_exit;
 
@@ -2101,8 +2101,8 @@ int ice_alloc_recipe(struct ice_hw *hw, u16 *rid)
 	sw_buf->res_type = cpu_to_le16((ICE_AQC_RES_TYPE_RECIPE <<
 					ICE_AQC_RES_TYPE_S) |
 					ICE_AQC_RES_TYPE_FLAG_SHARED);
-	status = ice_aq_alloc_free_res(hw, 1, sw_buf, buf_len,
-				       ice_aqc_opc_alloc_res, NULL);
+	status = ice_aq_alloc_free_res(hw, sw_buf, buf_len,
+				       ice_aqc_opc_alloc_res);
 	if (!status)
 		*rid = le16_to_cpu(sw_buf->elem[0].e.sw_resp);
 	kfree(sw_buf);
@@ -4448,8 +4448,7 @@ ice_alloc_res_cntr(struct ice_hw *hw, u8 type, u8 alloc_shared, u16 num_items,
 	buf->res_type = cpu_to_le16(((type << ICE_AQC_RES_TYPE_S) &
 				      ICE_AQC_RES_TYPE_M) | alloc_shared);
 
-	status = ice_aq_alloc_free_res(hw, 1, buf, buf_len,
-				       ice_aqc_opc_alloc_res, NULL);
+	status = ice_aq_alloc_free_res(hw, buf, buf_len, ice_aqc_opc_alloc_res);
 	if (status)
 		goto exit;
 
@@ -4487,8 +4486,7 @@ ice_free_res_cntr(struct ice_hw *hw, u8 type, u8 alloc_shared, u16 num_items,
 				      ICE_AQC_RES_TYPE_M) | alloc_shared);
 	buf->elem[0].e.sw_resp = cpu_to_le16(counter_id);
 
-	status = ice_aq_alloc_free_res(hw, 1, buf, buf_len,
-				       ice_aqc_opc_free_res, NULL);
+	status = ice_aq_alloc_free_res(hw, buf, buf_len, ice_aqc_opc_free_res);
 	if (status)
 		ice_debug(hw, ICE_DBG_SW, "counter resource could not be freed\n");
 
@@ -4530,8 +4528,8 @@ int ice_share_res(struct ice_hw *hw, u16 type, u8 shared, u16 res_id)
 					    ~ICE_AQC_RES_TYPE_FLAG_SHARED);
 
 	buf->elem[0].e.sw_resp = cpu_to_le16(res_id);
-	status = ice_aq_alloc_free_res(hw, 1, buf, buf_len,
-				       ice_aqc_opc_share_res, NULL);
+	status = ice_aq_alloc_free_res(hw, buf, buf_len,
+				       ice_aqc_opc_share_res);
 	if (status)
 		ice_debug(hw, ICE_DBG_SW, "Could not set resource type %u id %u to %s\n",
 			  type, res_id, shared ? "SHARED" : "DEDICATED");
-- 
2.38.1


