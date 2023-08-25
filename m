Return-Path: <netdev+bounces-30567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CE87880F5
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 09:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAAB028171B
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 07:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522821C13;
	Fri, 25 Aug 2023 07:36:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4062A1C01
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 07:36:56 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704C61FF2
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 00:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692949007; x=1724485007;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FXb+laYzL8EamZJzkwG8+LX5juA7ZWeISM1FZRMkmC0=;
  b=Nd7WdJH+mnwM7LqCm1bRaqKfp4X5IPPFdFEKQwvBeYJ0ZYRz1TffY2aI
   cUB65+dK5Gwc01MqjS2pvUggVUbyM411OhbyLKQCSaGyT9YwTwKZO4goi
   x+do5gX1LPSwXddA//OYyVzU76qi6q91OI9SmBjSzEhDaRQbi/5Yw/aH5
   yqyKRjXC4lxEhHTytefmWiJdiLtmvw8ZSRr27sJfi5yqIG3oAOKd5YgQv
   H+CbjBVnUKwNtf4+AqtWR/s8xIHF83ml6q8Fx+yoh1BneOkDA92kgNVZg
   +AXnG4LAzpnOEt4Rsizem6f+IPJIwZPphCsc4McTsqsFzQ/WJ2V+T0kmc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="441000094"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="441000094"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 00:36:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="1068148571"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="1068148571"
Received: from wasp.igk.intel.com ([10.102.20.192])
  by fmsmga005.fm.intel.com with ESMTP; 25 Aug 2023 00:36:44 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	david.m.ertman@intel.com,
	wojciech.drewek@intel.com,
	aleksander.lobakin@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Simon Horman <horms@kernel.org>,
	Marcin Szycik <marcin.szycik@intel.com>
Subject: [PATCH iwl-next v2] ice: add drop rule matching on not active lport
Date: Fri, 25 Aug 2023 09:13:19 +0200
Message-ID: <20230825071319.2230108-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Inactive LAG port should not receive any packets, as it can cause adding
invalid FDBs (bridge offload). Add a drop rule matching on inactive lport
in LAG.

Reviewed-by: Simon Horman <horms@kernel.org>
Co-developed-by: Marcin Szycik <marcin.szycik@intel.com>
Signed-off-by: Marcin Szycik <marcin.szycik@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
v1 --> v2 (based on Olek comments):
 * remove zeroes from tabels
 * style changes
---
 .../net/ethernet/intel/ice/ice_eswitch_br.c   |  6 +-
 drivers/net/ethernet/intel/ice/ice_lag.c      | 87 +++++++++++++++----
 drivers/net/ethernet/intel/ice/ice_lag.h      |  2 +
 3 files changed, 75 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c b/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
index 67bfd1f61cdd..6ae0269bdf73 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
@@ -73,7 +73,7 @@ ice_eswitch_br_ingress_rule_setup(struct ice_adv_rule_info *rule_info,
 	rule_info->sw_act.vsi_handle = vf_vsi_idx;
 	rule_info->sw_act.flag |= ICE_FLTR_RX;
 	rule_info->sw_act.src = pf_id;
-	rule_info->priority = 5;
+	rule_info->priority = 2;
 }
 
 static void
@@ -84,7 +84,7 @@ ice_eswitch_br_egress_rule_setup(struct ice_adv_rule_info *rule_info,
 	rule_info->sw_act.flag |= ICE_FLTR_TX;
 	rule_info->flags_info.act = ICE_SINGLE_ACT_LAN_ENABLE;
 	rule_info->flags_info.act_valid = true;
-	rule_info->priority = 5;
+	rule_info->priority = 2;
 }
 
 static int
@@ -207,7 +207,7 @@ ice_eswitch_br_guard_rule_create(struct ice_hw *hw, u16 vsi_idx,
 	rule_info.allow_pass_l2 = true;
 	rule_info.sw_act.vsi_handle = vsi_idx;
 	rule_info.sw_act.fltr_act = ICE_NOP;
-	rule_info.priority = 5;
+	rule_info.priority = 2;
 
 	err = ice_add_adv_rule(hw, list, lkups_cnt, &rule_info, rule);
 	if (err)
diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
index 4f39863b5537..0c8cbcd16b6d 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.c
+++ b/drivers/net/ethernet/intel/ice/ice_lag.c
@@ -19,8 +19,11 @@ static const u8 lacp_train_pkt[LACP_TRAIN_PKT_LEN] = { 0, 0, 0, 0, 0, 0,
 static const u8 ice_dflt_vsi_rcp[ICE_RECIPE_LEN] = {
 	0x05, 0, 0, 0, 0x20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 	0x85, 0, 0x01, 0, 0, 0, 0xff, 0xff, 0x08, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0x30, 0, 0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
+	0, 0, 0, 0, 0, 0, 0x30 };
+static const u8 ice_lport_rcp[ICE_RECIPE_LEN] = {
+	0x05, 0, 0, 0, 0x20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+	0x85, 0, 0x16, 0, 0, 0, 0xff, 0xff, 0x07, 0, 0, 0, 0, 0, 0, 0,
+	0, 0, 0, 0, 0, 0, 0x30 };
 
 /**
  * ice_lag_set_primary - set PF LAG state as Primary
@@ -173,18 +176,22 @@ static struct ice_lag *ice_lag_find_primary(struct ice_lag *lag)
 }
 
 /**
- * ice_lag_cfg_dflt_fltr - Add/Remove default VSI rule for LAG
+ * ice_lag_cfg_fltr - Add/Remove rule for LAG
  * @lag: lag struct for local interface
+ * @act: rule action
+ * @recipe_id: recipe id for the new rule
+ * @rule_idx: pointer to rule index
  * @add: boolean on whether we are adding filters
  */
 static int
-ice_lag_cfg_dflt_fltr(struct ice_lag *lag, bool add)
+ice_lag_cfg_fltr(struct ice_lag *lag, u32 act, u16 recipe_id, u16 *rule_idx,
+		 bool add)
 {
 	struct ice_sw_rule_lkup_rx_tx *s_rule;
 	u16 s_rule_sz, vsi_num;
 	struct ice_hw *hw;
-	u32 act, opc;
 	u8 *eth_hdr;
+	u32 opc;
 	int err;
 
 	hw = &lag->pf->hw;
@@ -193,7 +200,7 @@ ice_lag_cfg_dflt_fltr(struct ice_lag *lag, bool add)
 	s_rule_sz = ICE_SW_RULE_RX_TX_ETH_HDR_SIZE(s_rule);
 	s_rule = kzalloc(s_rule_sz, GFP_KERNEL);
 	if (!s_rule) {
-		dev_err(ice_pf_to_dev(lag->pf), "error allocating rule for LAG default VSI\n");
+		dev_err(ice_pf_to_dev(lag->pf), "error allocating rule for LAG\n");
 		return -ENOMEM;
 	}
 
@@ -201,19 +208,17 @@ ice_lag_cfg_dflt_fltr(struct ice_lag *lag, bool add)
 		eth_hdr = s_rule->hdr_data;
 		ice_fill_eth_hdr(eth_hdr);
 
-		act = (vsi_num << ICE_SINGLE_ACT_VSI_ID_S) &
+		act |= (vsi_num << ICE_SINGLE_ACT_VSI_ID_S) &
 			ICE_SINGLE_ACT_VSI_ID_M;
-		act |= ICE_SINGLE_ACT_VSI_FORWARDING |
-			ICE_SINGLE_ACT_VALID_BIT | ICE_SINGLE_ACT_LAN_ENABLE;
 
 		s_rule->hdr.type = cpu_to_le16(ICE_AQC_SW_RULES_T_LKUP_RX);
-		s_rule->recipe_id = cpu_to_le16(lag->pf_recipe);
+		s_rule->recipe_id = cpu_to_le16(recipe_id);
 		s_rule->src = cpu_to_le16(hw->port_info->lport);
 		s_rule->act = cpu_to_le32(act);
 		s_rule->hdr_len = cpu_to_le16(DUMMY_ETH_HDR_LEN);
 		opc = ice_aqc_opc_add_sw_rules;
 	} else {
-		s_rule->index = cpu_to_le16(lag->pf_rule_id);
+		s_rule->index = cpu_to_le16(*rule_idx);
 		opc = ice_aqc_opc_remove_sw_rules;
 	}
 
@@ -222,15 +227,46 @@ ice_lag_cfg_dflt_fltr(struct ice_lag *lag, bool add)
 		goto dflt_fltr_free;
 
 	if (add)
-		lag->pf_rule_id = le16_to_cpu(s_rule->index);
+		*rule_idx = le16_to_cpu(s_rule->index);
 	else
-		lag->pf_rule_id = 0;
+		*rule_idx = 0;
 
 dflt_fltr_free:
 	kfree(s_rule);
 	return err;
 }
 
+/**
+ * ice_lag_cfg_dflt_fltr - Add/Remove default VSI rule for LAG
+ * @lag: lag struct for local interface
+ * @add: boolean on whether to add filter
+ */
+static int
+ice_lag_cfg_dflt_fltr(struct ice_lag *lag, bool add)
+{
+	u32 act = ICE_SINGLE_ACT_VSI_FORWARDING |
+		ICE_SINGLE_ACT_VALID_BIT | ICE_SINGLE_ACT_LAN_ENABLE;
+
+	return ice_lag_cfg_fltr(lag, act, lag->pf_recipe,
+				&lag->pf_rule_id, add);
+}
+
+/**
+ * ice_lag_cfg_drop_fltr - Add/Remove lport drop rule
+ * @lag: lag struct for local interface
+ * @add: boolean on whether to add filter
+ */
+static int
+ice_lag_cfg_drop_fltr(struct ice_lag *lag, bool add)
+{
+	u32 act = ICE_SINGLE_ACT_VSI_FORWARDING |
+		  ICE_SINGLE_ACT_VALID_BIT |
+		  ICE_SINGLE_ACT_DROP;
+
+	return ice_lag_cfg_fltr(lag, act, lag->lport_recipe,
+				&lag->lport_rule_idx, add);
+}
+
 /**
  * ice_lag_cfg_pf_fltrs - set filters up for new active port
  * @lag: local interfaces lag struct
@@ -257,13 +293,18 @@ ice_lag_cfg_pf_fltrs(struct ice_lag *lag, void *ptr)
 	if (bonding_info->slave.state && lag->pf_rule_id) {
 		if (ice_lag_cfg_dflt_fltr(lag, false))
 			dev_err(dev, "Error removing old default VSI filter\n");
+		if (ice_lag_cfg_drop_fltr(lag, true))
+			dev_err(dev, "Error adding new drop filter\n");
 		return;
 	}
 
 	/* interface becoming active - add new default VSI rule */
-	if (!bonding_info->slave.state && !lag->pf_rule_id)
+	if (!bonding_info->slave.state && !lag->pf_rule_id) {
 		if (ice_lag_cfg_dflt_fltr(lag, true))
 			dev_err(dev, "Error adding new default VSI filter\n");
+		if (lag->lport_rule_idx && ice_lag_cfg_drop_fltr(lag, false))
+			dev_err(dev, "Error removing old drop filter\n");
+	}
 }
 
 /**
@@ -1195,6 +1236,7 @@ static void ice_lag_changeupper_event(struct ice_lag *lag, void *ptr)
 			swid = primary_lag->pf->hw.port_info->sw_id;
 			ice_lag_set_swid(swid, lag, true);
 			ice_lag_add_prune_list(primary_lag, lag->pf);
+			ice_lag_cfg_drop_fltr(lag, true);
 		}
 		/* add filter for primary control packets */
 		ice_lag_cfg_cp_fltr(lag, true);
@@ -1953,11 +1995,16 @@ int ice_init_lag(struct ice_pf *pf)
 		goto lag_error;
 	}
 
-	err = ice_create_lag_recipe(&pf->hw, &lag->pf_recipe, ice_dflt_vsi_rcp,
-				    1);
+	err = ice_create_lag_recipe(&pf->hw, &lag->pf_recipe,
+				    ice_dflt_vsi_rcp, 1);
 	if (err)
 		goto lag_error;
 
+	err = ice_create_lag_recipe(&pf->hw, &lag->lport_recipe,
+				    ice_lport_rcp, 3);
+	if (err)
+		goto free_rcp_res;
+
 	/* associate recipes to profiles */
 	for (n = 0; n < ICE_PROFID_IPV6_GTPU_IPV6_TCP_INNER; n++) {
 		err = ice_aq_get_recipe_to_profile(&pf->hw, n,
@@ -1966,7 +2013,8 @@ int ice_init_lag(struct ice_pf *pf)
 			continue;
 
 		if (recipe_bits & BIT(ICE_SW_LKUP_DFLT)) {
-			recipe_bits |= BIT(lag->pf_recipe);
+			recipe_bits |= BIT(lag->pf_recipe) |
+				       BIT(lag->lport_recipe);
 			ice_aq_map_recipe_to_profile(&pf->hw, n,
 						     (u8 *)&recipe_bits, NULL);
 		}
@@ -1977,6 +2025,9 @@ int ice_init_lag(struct ice_pf *pf)
 	dev_dbg(dev, "INIT LAG complete\n");
 	return 0;
 
+free_rcp_res:
+	ice_free_hw_res(&pf->hw, ICE_AQC_RES_TYPE_RECIPE, 1,
+			&pf->lag->pf_recipe);
 lag_error:
 	kfree(lag);
 	pf->lag = NULL;
@@ -2006,6 +2057,8 @@ void ice_deinit_lag(struct ice_pf *pf)
 
 	ice_free_hw_res(&pf->hw, ICE_AQC_RES_TYPE_RECIPE, 1,
 			&pf->lag->pf_recipe);
+	ice_free_hw_res(&pf->hw, ICE_AQC_RES_TYPE_RECIPE, 1,
+			&pf->lag->lport_recipe);
 
 	kfree(lag);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_lag.h b/drivers/net/ethernet/intel/ice/ice_lag.h
index 18075b82485a..c29a27f16b81 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.h
+++ b/drivers/net/ethernet/intel/ice/ice_lag.h
@@ -39,8 +39,10 @@ struct ice_lag {
 	u8 bonded:1; /* currently bonded */
 	u8 primary:1; /* this is primary */
 	u16 pf_recipe;
+	u16 lport_recipe;
 	u16 pf_rule_id;
 	u16 cp_rule_idx;
+	u16 lport_rule_idx;
 	u8 role;
 };
 
-- 
2.41.0


