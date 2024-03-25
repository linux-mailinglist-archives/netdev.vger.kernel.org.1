Return-Path: <netdev+bounces-81767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDA988B150
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 21:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E54F81F66F1C
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 20:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682A0524B1;
	Mon, 25 Mar 2024 20:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cvyiq7GS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C59F4597D
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 20:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711398396; cv=none; b=Q8p4CVqIppFbyGnMc+2o/Lt+w1uD+YYL5kTpm2cnMbQVZnhVYXrY+dL7c8XX+3vy+dmjO9umTxwCSpBtAJBm0ac736JFUeBAeU/xcUbIlAcm/H575h0c3JMt9peW1lBlH264D5SNT0wAyTgFuJ8re+iywXrmw1ao6nkXZQxVCHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711398396; c=relaxed/simple;
	bh=SuyQNJbw21NCIq77hJZQVkiROlIT94mOsKn9a9O45xU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U778MH5+9yGmHfGVNGD0XK1YD0GEnC9Qny4P0a5Muo4r1L+eSH6ARWd5R3OjzQSllQKqBYHqhSaKcXdC/QYX8VSBzQqy9IkHvJBZ9LO8fUnYRTEvJgheuRvZMYScTby24WFmxsy+UvTav+GFuqhMxzbiBKyyewfyRgE+xgvsCOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cvyiq7GS; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711398394; x=1742934394;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SuyQNJbw21NCIq77hJZQVkiROlIT94mOsKn9a9O45xU=;
  b=cvyiq7GSb2kXi/J3g0A7lvOEYtxhUQQ1CNzZ/StbyGEzUGfvKlGOmCWJ
   6TLhU4XkFpzAkOqORStB0+6ynA87kGndUAco3DzVJpG6wQcTwkg21zX2O
   4Bu8u0mbYUKPLovdbVOGXkeC+8QUrJAz3lcRrdpfaPA95b643lMJDXXMN
   nhStmYhU6rGUMN6NDZUaG7T7BElJ51tyyabuA4Z/Q/x44Xlp1Xdy2+bzT
   fACNel2xjJbxYYND8tqBzuRilPlJpcEMlatyWM96cRAQClqk99O1NsbuG
   GyOfHpswTHU7riiyTihvc+cTXNZyHdF38IbEMgPRlTwWtXwG/ugTB4SLr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="10219647"
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="10219647"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 13:26:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="15787372"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 25 Mar 2024 13:26:31 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net-next 3/8] ice: default Tx rule instead of to queue
Date: Mon, 25 Mar 2024 13:26:11 -0700
Message-ID: <20240325202623.1012287-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240325202623.1012287-1-anthony.l.nguyen@intel.com>
References: <20240325202623.1012287-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Steer all packets that miss other rules to PF VSI. Previously in
switchdev mode, PF VSI received missed packets, but only ones marked
as Rx. Now it is receiving all missed packets.

To queue rule per PR isn't needed, because we use PF VSI instead of
control VSI now, and it's already correctly configured.

Add flag to correctly set LAN_EN bit in default Tx rule. It shouldn't
allow packet to go outside when there is a match.

Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 107 +++----------------
 drivers/net/ethernet/intel/ice/ice_repr.h    |   4 -
 drivers/net/ethernet/intel/ice/ice_switch.c  |   4 +
 drivers/net/ethernet/intel/ice/ice_switch.h  |   5 +-
 4 files changed, 23 insertions(+), 97 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index 8ad271534d80..50b3de700837 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -10,85 +10,6 @@
 #include "ice_devlink.h"
 #include "ice_tc_lib.h"
 
-/**
- * ice_eswitch_del_sp_rules - delete adv rules added on PRs
- * @pf: pointer to the PF struct
- *
- * Delete all advanced rules that were used to forward packets with the
- * device's VSI index to the corresponding eswitch ctrl VSI queue.
- */
-static void ice_eswitch_del_sp_rules(struct ice_pf *pf)
-{
-	struct ice_repr *repr;
-	unsigned long id;
-
-	xa_for_each(&pf->eswitch.reprs, id, repr) {
-		if (repr->sp_rule.rid)
-			ice_rem_adv_rule_by_id(&pf->hw, &repr->sp_rule);
-	}
-}
-
-/**
- * ice_eswitch_add_sp_rule - add adv rule with device's VSI index
- * @pf: pointer to PF struct
- * @repr: pointer to the repr struct
- *
- * This function adds advanced rule that forwards packets with
- * device's VSI index to the corresponding eswitch ctrl VSI queue.
- */
-static int ice_eswitch_add_sp_rule(struct ice_pf *pf, struct ice_repr *repr)
-{
-	struct ice_vsi *ctrl_vsi = pf->eswitch.control_vsi;
-	struct ice_adv_rule_info rule_info = { 0 };
-	struct ice_adv_lkup_elem *list;
-	struct ice_hw *hw = &pf->hw;
-	const u16 lkups_cnt = 1;
-	int err;
-
-	list = kcalloc(lkups_cnt, sizeof(*list), GFP_ATOMIC);
-	if (!list)
-		return -ENOMEM;
-
-	ice_rule_add_src_vsi_metadata(list);
-
-	rule_info.sw_act.flag = ICE_FLTR_TX;
-	rule_info.sw_act.vsi_handle = ctrl_vsi->idx;
-	rule_info.sw_act.fltr_act = ICE_FWD_TO_Q;
-	rule_info.sw_act.fwd_id.q_id = hw->func_caps.common_cap.rxq_first_id +
-				       ctrl_vsi->rxq_map[repr->q_id];
-	rule_info.flags_info.act |= ICE_SINGLE_ACT_LB_ENABLE;
-	rule_info.flags_info.act_valid = true;
-	rule_info.tun_type = ICE_SW_TUN_AND_NON_TUN;
-	rule_info.src_vsi = repr->src_vsi->idx;
-
-	err = ice_add_adv_rule(hw, list, lkups_cnt, &rule_info,
-			       &repr->sp_rule);
-	if (err)
-		dev_err(ice_pf_to_dev(pf), "Unable to add slow-path rule for eswitch for PR %d",
-			repr->id);
-
-	kfree(list);
-	return err;
-}
-
-static int
-ice_eswitch_add_sp_rules(struct ice_pf *pf)
-{
-	struct ice_repr *repr;
-	unsigned long id;
-	int err;
-
-	xa_for_each(&pf->eswitch.reprs, id, repr) {
-		err = ice_eswitch_add_sp_rule(pf, repr);
-		if (err) {
-			ice_eswitch_del_sp_rules(pf);
-			return err;
-		}
-	}
-
-	return 0;
-}
-
 /**
  * ice_eswitch_setup_env - configure eswitch HW filters
  * @pf: pointer to PF struct
@@ -102,7 +23,6 @@ static int ice_eswitch_setup_env(struct ice_pf *pf)
 	struct ice_vsi *ctrl_vsi = pf->eswitch.control_vsi;
 	struct net_device *netdev = uplink_vsi->netdev;
 	struct ice_vsi_vlan_ops *vlan_ops;
-	bool rule_added = false;
 
 	ice_remove_vsi_fltr(&pf->hw, uplink_vsi->idx);
 
@@ -112,17 +32,19 @@ static int ice_eswitch_setup_env(struct ice_pf *pf)
 	netif_addr_unlock_bh(netdev);
 
 	if (ice_vsi_add_vlan_zero(uplink_vsi))
+		goto err_vlan_zero;
+
+	if (ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx, true,
+			     ICE_FLTR_RX))
 		goto err_def_rx;
 
-	if (!ice_is_dflt_vsi_in_use(uplink_vsi->port_info)) {
-		if (ice_set_dflt_vsi(uplink_vsi))
-			goto err_def_rx;
-		rule_added = true;
-	}
+	if (ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx, true,
+			     ICE_FLTR_TX))
+		goto err_def_tx;
 
 	vlan_ops = ice_get_compat_vsi_vlan_ops(uplink_vsi);
 	if (vlan_ops->dis_rx_filtering(uplink_vsi))
-		goto err_dis_rx;
+		goto err_vlan_filtering;
 
 	if (ice_vsi_update_security(uplink_vsi, ice_vsi_ctx_set_allow_override))
 		goto err_override_uplink;
@@ -141,10 +63,15 @@ static int ice_eswitch_setup_env(struct ice_pf *pf)
 	ice_vsi_update_security(uplink_vsi, ice_vsi_ctx_clear_allow_override);
 err_override_uplink:
 	vlan_ops->ena_rx_filtering(uplink_vsi);
-err_dis_rx:
-	if (rule_added)
-		ice_clear_dflt_vsi(uplink_vsi);
+err_vlan_filtering:
+	ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx, false,
+			 ICE_FLTR_TX);
+err_def_tx:
+	ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx, false,
+			 ICE_FLTR_RX);
 err_def_rx:
+	ice_vsi_del_vlan_zero(uplink_vsi);
+err_vlan_zero:
 	ice_fltr_add_mac_and_broadcast(uplink_vsi,
 				       uplink_vsi->port_info->mac.perm_addr,
 				       ICE_FWD_TO_VSI);
@@ -585,7 +512,6 @@ void ice_eswitch_stop_all_tx_queues(struct ice_pf *pf)
 
 static void ice_eswitch_stop_reprs(struct ice_pf *pf)
 {
-	ice_eswitch_del_sp_rules(pf);
 	ice_eswitch_stop_all_tx_queues(pf);
 	ice_eswitch_napi_disable(&pf->eswitch.reprs);
 }
@@ -594,7 +520,6 @@ static void ice_eswitch_start_reprs(struct ice_pf *pf)
 {
 	ice_eswitch_napi_enable(&pf->eswitch.reprs);
 	ice_eswitch_start_all_tx_queues(pf);
-	ice_eswitch_add_sp_rules(pf);
 }
 
 static void
diff --git a/drivers/net/ethernet/intel/ice/ice_repr.h b/drivers/net/ethernet/intel/ice/ice_repr.h
index b107e058d538..34823f58cd23 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.h
+++ b/drivers/net/ethernet/intel/ice/ice_repr.h
@@ -16,10 +16,6 @@ struct ice_repr {
 	int q_id;
 	u32 id;
 	u8 parent_mac[ETH_ALEN];
-#ifdef CONFIG_ICE_SWITCHDEV
-	/* info about slow path rule */
-	struct ice_rule_query_data sp_rule;
-#endif
 };
 
 struct ice_repr *ice_repr_add_vf(struct ice_vf *vf);
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index f84bab80ca42..ce0b344dda99 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -2444,6 +2444,9 @@ static void ice_fill_sw_info(struct ice_hw *hw, struct ice_fltr_info *fi)
 			fi->lan_en = true;
 		}
 	}
+
+	if (fi->flag & ICE_FLTR_TX_ONLY)
+		fi->lan_en = false;
 }
 
 /**
@@ -3819,6 +3822,7 @@ ice_cfg_dflt_vsi(struct ice_port_info *pi, u16 vsi_handle, bool set,
 	} else if (f_info.flag & ICE_FLTR_TX) {
 		f_info.src_id = ICE_SRC_ID_VSI;
 		f_info.src = hw_vsi_id;
+		f_info.flag |= ICE_FLTR_TX_ONLY;
 	}
 	f_list_entry.fltr_info = f_info;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.h b/drivers/net/ethernet/intel/ice/ice_switch.h
index db7e501b7e0a..1b7dae9ce8d6 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.h
+++ b/drivers/net/ethernet/intel/ice/ice_switch.h
@@ -8,8 +8,9 @@
 
 #define ICE_SW_CFG_MAX_BUF_LEN 2048
 #define ICE_DFLT_VSI_INVAL 0xff
-#define ICE_FLTR_RX BIT(0)
-#define ICE_FLTR_TX BIT(1)
+#define ICE_FLTR_RX		BIT(0)
+#define ICE_FLTR_TX		BIT(1)
+#define ICE_FLTR_TX_ONLY	BIT(2)
 #define ICE_VSI_INVAL_ID 0xffff
 #define ICE_INVAL_Q_HANDLE 0xFFFF
 
-- 
2.41.0


