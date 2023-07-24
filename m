Return-Path: <netdev+bounces-20492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4996675FBCC
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 18:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3F0E28146F
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 16:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0920F9E0;
	Mon, 24 Jul 2023 16:18:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0819FC03
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 16:18:53 +0000 (UTC)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EECA10C8
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 09:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690215531; x=1721751531;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bc1xevzgqUbNSIfYQ7F8RzlL+I18qui2wyFasL9QRJE=;
  b=H5RmsopIqIm+UiYAIUBzXaNXBSdZr5Wue3BHi9I/m+ntALtPhAZliSBq
   fG+QMtZeHyvUQhf28FinENqSv+52O2Vi0Zq70oeNSpbctrMW/yMakTCVv
   4Qj5QvqsTVdhkHc9b1SVVqKdAp3PiP/EXbLmFGvTED5RuEn0m/bRqdx+j
   gdSanba8N9UJEtOVMMztaJzlk1fZlczHsszKZpl3k6zcj0IV3FK0T+H5Q
   oHe0OUtTewGvr0bHaeGjKXg5gWB2jjrsOWmaLTnrht8qm1fRMtqgU4kqQ
   +q+gwMvCuhxcG9kkLs1+v0Tw+G9z3UQ4BNwV2C8Awfex5row7rPOmVoWA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="398394147"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="398394147"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 09:18:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="899546014"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="899546014"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga005.jf.intel.com with ESMTP; 24 Jul 2023 09:18:09 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Marcin Szycik <marcin.szycik@intel.com>,
	anthony.l.nguyen@intel.com,
	jiri@resnulli.us,
	ivecera@redhat.com,
	simon.horman@corigine.com,
	vladbu@nvidia.com,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net-next v2 08/12] ice: Add guard rule when creating FDB in switchdev
Date: Mon, 24 Jul 2023 09:11:48 -0700
Message-Id: <20230724161152.2177196-9-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230724161152.2177196-1-anthony.l.nguyen@intel.com>
References: <20230724161152.2177196-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Marcin Szycik <marcin.szycik@intel.com>

Introduce new "guard" rule upon FDB entry creation.

It matches on src_mac, has valid bit unset, allow_pass_l2 set
and has a nop action.

Previously introduced "forward" rule matches on dst_mac, has valid
bit set, need_pass_l2 set and has a forward action.

With these rules, a packet will be offloaded only if FDB exists in both
directions (RX and TX).

Let's assume link partner sends a packet to VF1: src_mac = LP_MAC,
dst_mac = is VF1_MAC. Bridge adds FDB, two rules are created:
1. Guard rule matching on src_mac == LP_MAC
2. Forward rule matching on dst_mac == LP_MAC
Now VF1 responds with src_mac = VF1_MAC, dst_mac = LP_MAC. Before this
change, only one rule with dst_mac == LP_MAC would have existed, and the
packet would have been offloaded, meaning the bridge wouldn't add FDB in
the opposite direction. Now, the forward rule matches (dst_mac == LP_MAC),
but it has need_pass_l2 set an there is no guard rule with
src_mac == VF1_MAC, so the packet goes through slow-path and the bridge
adds FDB. Two rules are created:
1. Guard rule matching on src_mac == VF1_MAC
2. Forward rule matching on dst_mac == VF1_MAC
Further packets in both directions will be offloaded.

The same example is true in opposite direction (i.e. VF1 is the first to
send a packet out).

Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Marcin Szycik <marcin.szycik@intel.com>
Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../net/ethernet/intel/ice/ice_eswitch_br.c   | 64 +++++++++++-
 .../net/ethernet/intel/ice/ice_eswitch_br.h   |  1 +
 drivers/net/ethernet/intel/ice/ice_switch.c   | 97 ++++++++++++-------
 drivers/net/ethernet/intel/ice/ice_switch.h   |  5 +
 drivers/net/ethernet/intel/ice/ice_type.h     |  1 +
 5 files changed, 132 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c b/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
index 49b3ca5e956e..297d0eb45dde 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
@@ -107,6 +107,8 @@ ice_eswitch_br_fwd_rule_create(struct ice_hw *hw, int vsi_idx, int port_type,
 	ether_addr_copy(list[0].h_u.eth_hdr.dst_addr, mac);
 	eth_broadcast_addr(list[0].m_u.eth_hdr.dst_addr);
 
+	rule_info.need_pass_l2 = true;
+
 	rule_info.sw_act.fltr_act = ICE_FWD_TO_VSI;
 
 	err = ice_add_adv_rule(hw, list, lkups_cnt, &rule_info, rule);
@@ -125,11 +127,54 @@ ice_eswitch_br_fwd_rule_create(struct ice_hw *hw, int vsi_idx, int port_type,
 	return ERR_PTR(err);
 }
 
+static struct ice_rule_query_data *
+ice_eswitch_br_guard_rule_create(struct ice_hw *hw, u16 vsi_idx,
+				 const unsigned char *mac)
+{
+	struct ice_adv_rule_info rule_info = { 0 };
+	struct ice_rule_query_data *rule;
+	struct ice_adv_lkup_elem *list;
+	const u16 lkups_cnt = 1;
+	int err = -ENOMEM;
+
+	rule = kzalloc(sizeof(*rule), GFP_KERNEL);
+	if (!rule)
+		goto err_exit;
+
+	list = kcalloc(lkups_cnt, sizeof(*list), GFP_ATOMIC);
+	if (!list)
+		goto err_list_alloc;
+
+	list[0].type = ICE_MAC_OFOS;
+	ether_addr_copy(list[0].h_u.eth_hdr.src_addr, mac);
+	eth_broadcast_addr(list[0].m_u.eth_hdr.src_addr);
+
+	rule_info.allow_pass_l2 = true;
+	rule_info.sw_act.vsi_handle = vsi_idx;
+	rule_info.sw_act.fltr_act = ICE_NOP;
+	rule_info.priority = 5;
+
+	err = ice_add_adv_rule(hw, list, lkups_cnt, &rule_info, rule);
+	if (err)
+		goto err_add_rule;
+
+	kfree(list);
+
+	return rule;
+
+err_add_rule:
+	kfree(list);
+err_list_alloc:
+	kfree(rule);
+err_exit:
+	return ERR_PTR(err);
+}
+
 static struct ice_esw_br_flow *
 ice_eswitch_br_flow_create(struct device *dev, struct ice_hw *hw, int vsi_idx,
 			   int port_type, const unsigned char *mac)
 {
-	struct ice_rule_query_data *fwd_rule;
+	struct ice_rule_query_data *fwd_rule, *guard_rule;
 	struct ice_esw_br_flow *flow;
 	int err;
 
@@ -146,10 +191,22 @@ ice_eswitch_br_flow_create(struct device *dev, struct ice_hw *hw, int vsi_idx,
 		goto err_fwd_rule;
 	}
 
+	guard_rule = ice_eswitch_br_guard_rule_create(hw, vsi_idx, mac);
+	err = PTR_ERR_OR_ZERO(guard_rule);
+	if (err) {
+		dev_err(dev, "Failed to create eswitch bridge %sgress guard rule, err: %d\n",
+			port_type == ICE_ESWITCH_BR_UPLINK_PORT ? "e" : "in",
+			err);
+		goto err_guard_rule;
+	}
+
 	flow->fwd_rule = fwd_rule;
+	flow->guard_rule = guard_rule;
 
 	return flow;
 
+err_guard_rule:
+	ice_eswitch_br_rule_delete(hw, fwd_rule);
 err_fwd_rule:
 	kfree(flow);
 
@@ -180,6 +237,11 @@ ice_eswitch_br_flow_delete(struct ice_pf *pf, struct ice_esw_br_flow *flow)
 		dev_err(dev, "Failed to delete FDB forward rule, err: %d\n",
 			err);
 
+	err = ice_eswitch_br_rule_delete(&pf->hw, flow->guard_rule);
+	if (err)
+		dev_err(dev, "Failed to delete FDB guard rule, err: %d\n",
+			err);
+
 	kfree(flow);
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch_br.h b/drivers/net/ethernet/intel/ice/ice_eswitch_br.h
index e1b4eda7a890..d0dcf66ff08b 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch_br.h
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch_br.h
@@ -13,6 +13,7 @@ struct ice_esw_br_fdb_data {
 
 struct ice_esw_br_flow {
 	struct ice_rule_query_data *fwd_rule;
+	struct ice_rule_query_data *guard_rule;
 };
 
 enum {
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 81f45d7e76de..813fef5fd748 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -2272,6 +2272,10 @@ ice_get_recp_frm_fw(struct ice_hw *hw, struct ice_sw_recipe *recps, u8 rid,
 		/* Propagate some data to the recipe database */
 		recps[idx].is_root = !!is_root;
 		recps[idx].priority = root_bufs.content.act_ctrl_fwd_priority;
+		recps[idx].need_pass_l2 = root_bufs.content.act_ctrl &
+					  ICE_AQ_RECIPE_ACT_NEED_PASS_L2;
+		recps[idx].allow_pass_l2 = root_bufs.content.act_ctrl &
+					   ICE_AQ_RECIPE_ACT_ALLOW_PASS_L2;
 		bitmap_zero(recps[idx].res_idxs, ICE_MAX_FV_WORDS);
 		if (root_bufs.content.result_indx & ICE_AQ_RECIPE_RESULT_EN) {
 			recps[idx].chain_idx = root_bufs.content.result_indx &
@@ -4613,13 +4617,13 @@ static struct ice_protocol_entry ice_prot_id_tbl[ICE_PROTOCOL_LAST] = {
  * ice_find_recp - find a recipe
  * @hw: pointer to the hardware structure
  * @lkup_exts: extension sequence to match
- * @tun_type: type of recipe tunnel
+ * @rinfo: information regarding the rule e.g. priority and action info
  *
  * Returns index of matching recipe, or ICE_MAX_NUM_RECIPES if not found.
  */
 static u16
 ice_find_recp(struct ice_hw *hw, struct ice_prot_lkup_ext *lkup_exts,
-	      enum ice_sw_tunnel_type tun_type)
+	      const struct ice_adv_rule_info *rinfo)
 {
 	bool refresh_required = true;
 	struct ice_sw_recipe *recp;
@@ -4680,9 +4684,12 @@ ice_find_recp(struct ice_hw *hw, struct ice_prot_lkup_ext *lkup_exts,
 			}
 			/* If for "i"th recipe the found was never set to false
 			 * then it means we found our match
-			 * Also tun type of recipe needs to be checked
+			 * Also tun type and *_pass_l2 of recipe needs to be
+			 * checked
 			 */
-			if (found && recp[i].tun_type == tun_type)
+			if (found && recp[i].tun_type == rinfo->tun_type &&
+			    recp[i].need_pass_l2 == rinfo->need_pass_l2 &&
+			    recp[i].allow_pass_l2 == rinfo->allow_pass_l2)
 				return i; /* Return the recipe ID */
 		}
 	}
@@ -4952,6 +4959,7 @@ ice_add_sw_recipe(struct ice_hw *hw, struct ice_sw_recipe *rm,
 		  unsigned long *profiles)
 {
 	DECLARE_BITMAP(result_idx_bm, ICE_MAX_FV_WORDS);
+	struct ice_aqc_recipe_content *content;
 	struct ice_aqc_recipe_data_elem *tmp;
 	struct ice_aqc_recipe_data_elem *buf;
 	struct ice_recp_grp_entry *entry;
@@ -5012,6 +5020,8 @@ ice_add_sw_recipe(struct ice_hw *hw, struct ice_sw_recipe *rm,
 		if (status)
 			goto err_unroll;
 
+		content = &buf[recps].content;
+
 		/* Clear the result index of the located recipe, as this will be
 		 * updated, if needed, later in the recipe creation process.
 		 */
@@ -5022,26 +5032,24 @@ ice_add_sw_recipe(struct ice_hw *hw, struct ice_sw_recipe *rm,
 		/* if the recipe is a non-root recipe RID should be programmed
 		 * as 0 for the rules to be applied correctly.
 		 */
-		buf[recps].content.rid = 0;
-		memset(&buf[recps].content.lkup_indx, 0,
-		       sizeof(buf[recps].content.lkup_indx));
+		content->rid = 0;
+		memset(&content->lkup_indx, 0,
+		       sizeof(content->lkup_indx));
 
 		/* All recipes use look-up index 0 to match switch ID. */
-		buf[recps].content.lkup_indx[0] = ICE_AQ_SW_ID_LKUP_IDX;
-		buf[recps].content.mask[0] =
-			cpu_to_le16(ICE_AQ_SW_ID_LKUP_MASK);
+		content->lkup_indx[0] = ICE_AQ_SW_ID_LKUP_IDX;
+		content->mask[0] = cpu_to_le16(ICE_AQ_SW_ID_LKUP_MASK);
 		/* Setup lkup_indx 1..4 to INVALID/ignore and set the mask
 		 * to be 0
 		 */
 		for (i = 1; i <= ICE_NUM_WORDS_RECIPE; i++) {
-			buf[recps].content.lkup_indx[i] = 0x80;
-			buf[recps].content.mask[i] = 0;
+			content->lkup_indx[i] = 0x80;
+			content->mask[i] = 0;
 		}
 
 		for (i = 0; i < entry->r_group.n_val_pairs; i++) {
-			buf[recps].content.lkup_indx[i + 1] = entry->fv_idx[i];
-			buf[recps].content.mask[i + 1] =
-				cpu_to_le16(entry->fv_mask[i]);
+			content->lkup_indx[i + 1] = entry->fv_idx[i];
+			content->mask[i + 1] = cpu_to_le16(entry->fv_mask[i]);
 		}
 
 		if (rm->n_grp_count > 1) {
@@ -5055,7 +5063,7 @@ ice_add_sw_recipe(struct ice_hw *hw, struct ice_sw_recipe *rm,
 			}
 
 			entry->chain_idx = chain_idx;
-			buf[recps].content.result_indx =
+			content->result_indx =
 				ICE_AQ_RECIPE_RESULT_EN |
 				((chain_idx << ICE_AQ_RECIPE_RESULT_DATA_S) &
 				 ICE_AQ_RECIPE_RESULT_DATA_M);
@@ -5069,7 +5077,13 @@ ice_add_sw_recipe(struct ice_hw *hw, struct ice_sw_recipe *rm,
 			    ICE_MAX_NUM_RECIPES);
 		set_bit(buf[recps].recipe_indx,
 			(unsigned long *)buf[recps].recipe_bitmap);
-		buf[recps].content.act_ctrl_fwd_priority = rm->priority;
+		content->act_ctrl_fwd_priority = rm->priority;
+
+		if (rm->need_pass_l2)
+			content->act_ctrl |= ICE_AQ_RECIPE_ACT_NEED_PASS_L2;
+
+		if (rm->allow_pass_l2)
+			content->act_ctrl |= ICE_AQ_RECIPE_ACT_ALLOW_PASS_L2;
 		recps++;
 	}
 
@@ -5107,9 +5121,11 @@ ice_add_sw_recipe(struct ice_hw *hw, struct ice_sw_recipe *rm,
 		if (status)
 			goto err_unroll;
 
+		content = &buf[recps].content;
+
 		buf[recps].recipe_indx = (u8)rid;
-		buf[recps].content.rid = (u8)rid;
-		buf[recps].content.rid |= ICE_AQ_RECIPE_ID_IS_ROOT;
+		content->rid = (u8)rid;
+		content->rid |= ICE_AQ_RECIPE_ID_IS_ROOT;
 		/* the new entry created should also be part of rg_list to
 		 * make sure we have complete recipe
 		 */
@@ -5121,16 +5137,13 @@ ice_add_sw_recipe(struct ice_hw *hw, struct ice_sw_recipe *rm,
 			goto err_unroll;
 		}
 		last_chain_entry->rid = rid;
-		memset(&buf[recps].content.lkup_indx, 0,
-		       sizeof(buf[recps].content.lkup_indx));
+		memset(&content->lkup_indx, 0, sizeof(content->lkup_indx));
 		/* All recipes use look-up index 0 to match switch ID. */
-		buf[recps].content.lkup_indx[0] = ICE_AQ_SW_ID_LKUP_IDX;
-		buf[recps].content.mask[0] =
-			cpu_to_le16(ICE_AQ_SW_ID_LKUP_MASK);
+		content->lkup_indx[0] = ICE_AQ_SW_ID_LKUP_IDX;
+		content->mask[0] = cpu_to_le16(ICE_AQ_SW_ID_LKUP_MASK);
 		for (i = 1; i <= ICE_NUM_WORDS_RECIPE; i++) {
-			buf[recps].content.lkup_indx[i] =
-				ICE_AQ_RECIPE_LKUP_IGNORE;
-			buf[recps].content.mask[i] = 0;
+			content->lkup_indx[i] = ICE_AQ_RECIPE_LKUP_IGNORE;
+			content->mask[i] = 0;
 		}
 
 		i = 1;
@@ -5142,8 +5155,8 @@ ice_add_sw_recipe(struct ice_hw *hw, struct ice_sw_recipe *rm,
 		last_chain_entry->chain_idx = ICE_INVAL_CHAIN_IND;
 		list_for_each_entry(entry, &rm->rg_list, l_entry) {
 			last_chain_entry->fv_idx[i] = entry->chain_idx;
-			buf[recps].content.lkup_indx[i] = entry->chain_idx;
-			buf[recps].content.mask[i++] = cpu_to_le16(0xFFFF);
+			content->lkup_indx[i] = entry->chain_idx;
+			content->mask[i++] = cpu_to_le16(0xFFFF);
 			set_bit(entry->rid, rm->r_bitmap);
 		}
 		list_add(&last_chain_entry->l_entry, &rm->rg_list);
@@ -5155,7 +5168,7 @@ ice_add_sw_recipe(struct ice_hw *hw, struct ice_sw_recipe *rm,
 			status = -EINVAL;
 			goto err_unroll;
 		}
-		buf[recps].content.act_ctrl_fwd_priority = rm->priority;
+		content->act_ctrl_fwd_priority = rm->priority;
 
 		recps++;
 		rm->root_rid = (u8)rid;
@@ -5220,6 +5233,8 @@ ice_add_sw_recipe(struct ice_hw *hw, struct ice_sw_recipe *rm,
 		recp->priority = buf[buf_idx].content.act_ctrl_fwd_priority;
 		recp->n_grp_count = rm->n_grp_count;
 		recp->tun_type = rm->tun_type;
+		recp->need_pass_l2 = rm->need_pass_l2;
+		recp->allow_pass_l2 = rm->allow_pass_l2;
 		recp->recp_created = true;
 	}
 	rm->root_buf = buf;
@@ -5388,6 +5403,9 @@ ice_add_adv_recipe(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
 	/* set the recipe priority if specified */
 	rm->priority = (u8)rinfo->priority;
 
+	rm->need_pass_l2 = rinfo->need_pass_l2;
+	rm->allow_pass_l2 = rinfo->allow_pass_l2;
+
 	/* Find offsets from the field vector. Pick the first one for all the
 	 * recipes.
 	 */
@@ -5403,7 +5421,7 @@ ice_add_adv_recipe(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
 	}
 
 	/* Look for a recipe which matches our requested fv / mask list */
-	*rid = ice_find_recp(hw, lkup_exts, rinfo->tun_type);
+	*rid = ice_find_recp(hw, lkup_exts, rinfo);
 	if (*rid < ICE_MAX_NUM_RECIPES)
 		/* Success if found a recipe that match the existing criteria */
 		goto err_unroll;
@@ -5839,7 +5857,9 @@ static bool ice_rules_equal(const struct ice_adv_rule_info *first,
 	return first->sw_act.flag == second->sw_act.flag &&
 	       first->tun_type == second->tun_type &&
 	       first->vlan_type == second->vlan_type &&
-	       first->src_vsi == second->src_vsi;
+	       first->src_vsi == second->src_vsi &&
+	       first->need_pass_l2 == second->need_pass_l2 &&
+	       first->allow_pass_l2 == second->allow_pass_l2;
 }
 
 /**
@@ -6078,7 +6098,8 @@ ice_add_adv_rule(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
 	if (!(rinfo->sw_act.fltr_act == ICE_FWD_TO_VSI ||
 	      rinfo->sw_act.fltr_act == ICE_FWD_TO_Q ||
 	      rinfo->sw_act.fltr_act == ICE_FWD_TO_QGRP ||
-	      rinfo->sw_act.fltr_act == ICE_DROP_PACKET)) {
+	      rinfo->sw_act.fltr_act == ICE_DROP_PACKET ||
+	      rinfo->sw_act.fltr_act == ICE_NOP)) {
 		status = -EIO;
 		goto free_pkt_profile;
 	}
@@ -6089,7 +6110,8 @@ ice_add_adv_rule(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
 		goto free_pkt_profile;
 	}
 
-	if (rinfo->sw_act.fltr_act == ICE_FWD_TO_VSI)
+	if (rinfo->sw_act.fltr_act == ICE_FWD_TO_VSI ||
+	    rinfo->sw_act.fltr_act == ICE_NOP)
 		rinfo->sw_act.fwd_id.hw_vsi_id =
 			ice_get_hw_vsi_num(hw, vsi_handle);
 
@@ -6159,6 +6181,11 @@ ice_add_adv_rule(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
 		act |= ICE_SINGLE_ACT_VSI_FORWARDING | ICE_SINGLE_ACT_DROP |
 		       ICE_SINGLE_ACT_VALID_BIT;
 		break;
+	case ICE_NOP:
+		act |= FIELD_PREP(ICE_SINGLE_ACT_VSI_ID_M,
+				  rinfo->sw_act.fwd_id.hw_vsi_id);
+		act &= ~ICE_SINGLE_ACT_VALID_BIT;
+		break;
 	default:
 		status = -EIO;
 		goto err_ice_add_adv_rule;
@@ -6439,7 +6466,7 @@ ice_rem_adv_rule(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
 			return -EIO;
 	}
 
-	rid = ice_find_recp(hw, &lkup_exts, rinfo->tun_type);
+	rid = ice_find_recp(hw, &lkup_exts, rinfo);
 	/* If did not find a recipe that match the existing criteria */
 	if (rid == ICE_MAX_NUM_RECIPES)
 		return -EINVAL;
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.h b/drivers/net/ethernet/intel/ice/ice_switch.h
index db08509805ce..10f5a0ae199e 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.h
+++ b/drivers/net/ethernet/intel/ice/ice_switch.h
@@ -191,6 +191,8 @@ struct ice_adv_rule_info {
 	u16 vlan_type;
 	u16 fltr_rule_id;
 	u32 priority;
+	u16 need_pass_l2:1;
+	u16 allow_pass_l2:1;
 	u16 src_vsi;
 	struct ice_sw_act_ctrl sw_act;
 	struct ice_adv_rule_flags_info flags_info;
@@ -254,6 +256,9 @@ struct ice_sw_recipe {
 	 */
 	u8 priority;
 
+	u8 need_pass_l2:1;
+	u8 allow_pass_l2:1;
+
 	struct list_head rg_list;
 
 	/* AQ buffer associated with this recipe */
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index a09556e57803..df9171a1a34f 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -1033,6 +1033,7 @@ enum ice_sw_fwd_act_type {
 	ICE_FWD_TO_Q,
 	ICE_FWD_TO_QGRP,
 	ICE_DROP_PACKET,
+	ICE_NOP,
 	ICE_INVAL_ACT
 };
 
-- 
2.38.1


