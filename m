Return-Path: <netdev+bounces-12358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 332DF737337
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 19:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C94B1C20C9B
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 17:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1D2174D2;
	Tue, 20 Jun 2023 17:49:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600D9171AC
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 17:49:38 +0000 (UTC)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080F11712
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 10:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687283377; x=1718819377;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K3E0B769AGbw4NCeMH5GpEgH98CvoSnDDzxehqVqhWw=;
  b=IE4bm1akv8YXz+jIbpM4x0Gt4EOqF7pC8SEalmqExYhhdGl/cGU/Jghs
   TOadXXhf8MUA22ajZPEGqzxc3YHc/NqpOo3kZDtyf3bbrLe6DFebZqxXN
   pZ124DEXzEmYvGcbW8I1CpfN6CCOuMk5jVjhnYRuebIUCStZfA9ysKXN7
   oUsnCj5q0QoQgX+yPYJ70JvJgdYF1Kul6MmUycjlHKwCTEn4MEahY/LhQ
   tFmC3NSZz7dL4yQ/KiFMRBQL8F1sGjrrZf3SwXed8MvtoTDI3ndWVcy4s
   FC7TU8FMKwBf0NiZ6SQP+uPPZSJZJmsJ33GwaCHv1gZnBnNj6PVjb5GlZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="339554250"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="339554250"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 10:49:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="838300567"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="838300567"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga004.jf.intel.com with ESMTP; 20 Jun 2023 10:49:35 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Wojciech Drewek <wojciech.drewek@intel.com>,
	anthony.l.nguyen@intel.com,
	jiri@resnulli.us,
	ivecera@redhat.com,
	simon.horman@corigine.com,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net-next 01/12] ice: Skip adv rules removal upon switchdev release
Date: Tue, 20 Jun 2023 10:44:12 -0700
Message-Id: <20230620174423.4144938-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230620174423.4144938-1-anthony.l.nguyen@intel.com>
References: <20230620174423.4144938-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Wojciech Drewek <wojciech.drewek@intel.com>

Advanced rules for ctrl VSI will be removed anyway when the
VSI will cleaned up, no need to do it explicitly.

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
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
index 2ea9e1ae5517..92e16e9720ae 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -6539,59 +6539,6 @@ ice_rem_adv_rule_by_id(struct ice_hw *hw,
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
index c84b56fe84a5..db08509805ce 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.h
+++ b/drivers/net/ethernet/intel/ice/ice_switch.h
@@ -379,7 +379,6 @@ int
 ice_set_vlan_vsi_promisc(struct ice_hw *hw, u16 vsi_handle, u8 promisc_mask,
 			 bool rm_vlan_promisc);
 
-int ice_rem_adv_rule_for_vsi(struct ice_hw *hw, u16 vsi_handle);
 int
 ice_rem_adv_rule_by_id(struct ice_hw *hw,
 		       struct ice_rule_query_data *remove_entry);
-- 
2.38.1


