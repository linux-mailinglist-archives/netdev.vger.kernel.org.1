Return-Path: <netdev+bounces-17097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 823BA75057E
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 13:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86BAE1C2111D
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 11:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148F7200DD;
	Wed, 12 Jul 2023 11:05:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08609200DA
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 11:05:13 +0000 (UTC)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E991BE4
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 04:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689159908; x=1720695908;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3f8l4+kv+Ik7Ub08Se0HMJ8shoOFXxrXL9Gm27q5GMM=;
  b=LewaaVHjVfMjIRclrKvDgOVeqchXKxlyVzd8c1LIQKJ2UUDzvYId6h6G
   tA+vyzofGp1GI/vD9qUfOBXMd20Jb3u2RWNwWBJVCbItoqz6+LdF253xA
   OGxWEf9CWf2nBHmnrH4C2Hustpmd1HU8uim37On+08C6g5mz0RqhtKEUs
   zf+NOjrl8hApg4IrDu26YEtYme/byr5sz0UbgZu0RctD5VowpdvuRA4sh
   DS1yY5hVMzN4hjNs44G2+VKIHZKcQJ5YMM56jwYc4a8yBkARQSX93aBKh
   CwlbNg6uz/x10ZtLOlTzDbbc/6IXzjfvZjFoXnA/kGsEIohHXSwUbXSow
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="430993758"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="430993758"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 04:04:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="835093737"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="835093737"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga002.fm.intel.com with ESMTP; 12 Jul 2023 04:04:56 -0700
Received: from rozewie.igk.intel.com (rozewie.igk.intel.com [10.211.8.69])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 8A2CB369E7;
	Wed, 12 Jul 2023 12:04:55 +0100 (IST)
From: Wojciech Drewek <wojciech.drewek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	kuba@kernel.org,
	david.m.ertman@intel.com,
	michal.swiatkowski@linux.intel.com,
	marcin.szycik@linux.intel.com,
	pawel.chmielewski@intel.com,
	sridhar.samudrala@intel.com,
	pmenzel@molgen.mpg.de,
	simon.horman@corigine.com,
	dan.carpenter@linaro.org,
	vladbu@nvidia.com
Subject: [PATCH iwl-next v6 01/12] ice: Skip adv rules removal upon switchdev release
Date: Wed, 12 Jul 2023 13:03:26 +0200
Message-Id: <20230712110337.8030-2-wojciech.drewek@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230712110337.8030-1-wojciech.drewek@intel.com>
References: <20230712110337.8030-1-wojciech.drewek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Advanced rules for ctrl VSI will be removed anyway when the
VSI will cleaned up, no need to do it explicitly.

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
---
v5: remove ice_rem_adv_rule_for_vsi since it is unused
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c |  1 -
 drivers/net/ethernet/intel/ice/ice_switch.c  | 53 --------------------
 drivers/net/ethernet/intel/ice/ice_switch.h  |  1 -
 3 files changed, 55 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index ad0a007b7398..be5b22691f7c 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -503,7 +503,6 @@ static void ice_eswitch_disable_switchdev(struct ice_pf *pf)
 
 	ice_eswitch_napi_disable(pf);
 	ice_eswitch_release_env(pf);
-	ice_rem_adv_rule_for_vsi(&pf->hw, ctrl_vsi->idx);
 	ice_eswitch_release_reprs(pf, ctrl_vsi);
 	ice_vsi_release(ctrl_vsi);
 	ice_repr_rem_from_all_vfs(pf);
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 8f84c041ebc1..b9b1aab735f6 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -6668,59 +6668,6 @@ ice_rem_adv_rule_by_id(struct ice_hw *hw,
 	return -ENOENT;
 }
 
-/**
- * ice_rem_adv_rule_for_vsi - removes existing advanced switch rules for a
- *                            given VSI handle
- * @hw: pointer to the hardware structure
- * @vsi_handle: VSI handle for which we are supposed to remove all the rules.
- *
- * This function is used to remove all the rules for a given VSI and as soon
- * as removing a rule fails, it will return immediately with the error code,
- * else it will return success.
- */
-int ice_rem_adv_rule_for_vsi(struct ice_hw *hw, u16 vsi_handle)
-{
-	struct ice_adv_fltr_mgmt_list_entry *list_itr, *tmp_entry;
-	struct ice_vsi_list_map_info *map_info;
-	struct ice_adv_rule_info rinfo;
-	struct list_head *list_head;
-	struct ice_switch_info *sw;
-	int status;
-	u8 rid;
-
-	sw = hw->switch_info;
-	for (rid = 0; rid < ICE_MAX_NUM_RECIPES; rid++) {
-		if (!sw->recp_list[rid].recp_created)
-			continue;
-		if (!sw->recp_list[rid].adv_rule)
-			continue;
-
-		list_head = &sw->recp_list[rid].filt_rules;
-		list_for_each_entry_safe(list_itr, tmp_entry, list_head,
-					 list_entry) {
-			rinfo = list_itr->rule_info;
-
-			if (rinfo.sw_act.fltr_act == ICE_FWD_TO_VSI_LIST) {
-				map_info = list_itr->vsi_list_info;
-				if (!map_info)
-					continue;
-
-				if (!test_bit(vsi_handle, map_info->vsi_map))
-					continue;
-			} else if (rinfo.sw_act.vsi_handle != vsi_handle) {
-				continue;
-			}
-
-			rinfo.sw_act.vsi_handle = vsi_handle;
-			status = ice_rem_adv_rule(hw, list_itr->lkups,
-						  list_itr->lkups_cnt, &rinfo);
-			if (status)
-				return status;
-		}
-	}
-	return 0;
-}
-
 /**
  * ice_replay_vsi_adv_rule - Replay advanced rule for requested VSI
  * @hw: pointer to the hardware structure
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.h b/drivers/net/ethernet/intel/ice/ice_switch.h
index 8ca9bfcafab4..b75488ede83f 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.h
+++ b/drivers/net/ethernet/intel/ice/ice_switch.h
@@ -393,7 +393,6 @@ int
 ice_set_vlan_vsi_promisc(struct ice_hw *hw, u16 vsi_handle, u8 promisc_mask,
 			 bool rm_vlan_promisc);
 
-int ice_rem_adv_rule_for_vsi(struct ice_hw *hw, u16 vsi_handle);
 int
 ice_rem_adv_rule_by_id(struct ice_hw *hw,
 		       struct ice_rule_query_data *remove_entry);
-- 
2.40.1


