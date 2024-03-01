Return-Path: <netdev+bounces-76527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2503286E0A5
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 12:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C6681F25337
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 11:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4186D1A7;
	Fri,  1 Mar 2024 11:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PSiNsTjO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE2B6D52E
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 11:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709293800; cv=none; b=Jomfzjm5ry+r0LyL0mK6ekXqOgMSjLIcs6lefZov48Kxc6aIGc3AFZwHSwjlyZ89SGA7Vcc6/ZdWh0BC05v7YkY8LBw6rsSATdcWi3G7oag4gESN8rjrfOEXcNPYs9ZOx6/YfuIZSnmz64S61q/2x+QB9lXA5cFr89wLyewJjqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709293800; c=relaxed/simple;
	bh=FLIY5kfD3ncERyoI7+bk+IFigu6koSUMnW5kLntfDlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UCYjNWu4iH56ApX+jTYCxIN3bmf59NFE4/T1nsh0ZpIaW1eTJBgU3PBfiROEhDwQQs/zdBT/tWjKdUq170WaMUgr8o4drmDpEa2aekPxUTN7raWrTLLdVaZnCgY0WKPK7kuU6Cn3Oi5ZYJPc+JC/+VpvLnzLG9Sl4LmEccK+agw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PSiNsTjO; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709293799; x=1740829799;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FLIY5kfD3ncERyoI7+bk+IFigu6koSUMnW5kLntfDlM=;
  b=PSiNsTjO/6X0r7bVOY11qpAlXII1IFmlf1Oc1d5++61D6a/qtDVJZUEi
   v/7k3KPBw7H4yBrZozS9M4ERVnYgX8iTJFV1d23JC0DlFOwg4IXc5t758
   evMSihsPx2Q42nJIU5fhluDngTKRGKNyJ7SLuqPD4wuveYb2ulIMrqhT0
   llRID2JAX7vOnyWB3/rr2ZTGM/Vo+HrS9OF5yciI6xZEX4NGEyG311Hip
   1cm4CL3XVyk/hIHIHZ/Z4MA/9Ov547clboMgePH4ZEA2TP+SeyiegsPnz
   QENtRt5w7RZtZfDWJ/meDbA7DdAhqtBEmGtzYlIJ5SLfSEV2j2mjq8Gr+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="4000056"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="4000056"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 03:49:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="39195040"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by fmviesa001.fm.intel.com with ESMTP; 01 Mar 2024 03:49:57 -0800
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	marcin.szycik@intel.com,
	wojciech.drewek@intel.com,
	sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com,
	horms@kernel.org,
	sujai.buvaneswaran@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: [iwl-next v3 4/8] ice: control default Tx rule in lag
Date: Fri,  1 Mar 2024 12:54:10 +0100
Message-ID: <20240301115414.502097-5-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240301115414.502097-1-michal.swiatkowski@linux.intel.com>
References: <20240301115414.502097-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tx rule in switchdev was changed to use PF instead of additional control
plane VSI. Because of that during lag we should control it. Control
means to add and remove the default Tx rule during lag active/inactive
switching.

It can be done the same way as default Rx rule.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lag.c | 44 +++++++++++++++++++-----
 drivers/net/ethernet/intel/ice/ice_lag.h |  3 +-
 2 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
index a7a342809935..0cb4a5e5c00c 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.c
+++ b/drivers/net/ethernet/intel/ice/ice_lag.c
@@ -202,11 +202,12 @@ static struct ice_lag *ice_lag_find_primary(struct ice_lag *lag)
  * @act: rule action
  * @recipe_id: recipe id for the new rule
  * @rule_idx: pointer to rule index
+ * @direction: ICE_FLTR_RX or ICE_FLTR_TX
  * @add: boolean on whether we are adding filters
  */
 static int
 ice_lag_cfg_fltr(struct ice_lag *lag, u32 act, u16 recipe_id, u16 *rule_idx,
-		 bool add)
+		 u8 direction, bool add)
 {
 	struct ice_sw_rule_lkup_rx_tx *s_rule;
 	u16 s_rule_sz, vsi_num;
@@ -231,9 +232,16 @@ ice_lag_cfg_fltr(struct ice_lag *lag, u32 act, u16 recipe_id, u16 *rule_idx,
 
 		act |= FIELD_PREP(ICE_SINGLE_ACT_VSI_ID_M, vsi_num);
 
-		s_rule->hdr.type = cpu_to_le16(ICE_AQC_SW_RULES_T_LKUP_RX);
 		s_rule->recipe_id = cpu_to_le16(recipe_id);
-		s_rule->src = cpu_to_le16(hw->port_info->lport);
+		if (direction == ICE_FLTR_RX) {
+			s_rule->hdr.type =
+				cpu_to_le16(ICE_AQC_SW_RULES_T_LKUP_RX);
+			s_rule->src = cpu_to_le16(hw->port_info->lport);
+		} else {
+			s_rule->hdr.type =
+				cpu_to_le16(ICE_AQC_SW_RULES_T_LKUP_TX);
+			s_rule->src = cpu_to_le16(vsi_num);
+		}
 		s_rule->act = cpu_to_le32(act);
 		s_rule->hdr_len = cpu_to_le16(DUMMY_ETH_HDR_LEN);
 		opc = ice_aqc_opc_add_sw_rules;
@@ -266,9 +274,27 @@ ice_lag_cfg_dflt_fltr(struct ice_lag *lag, bool add)
 {
 	u32 act = ICE_SINGLE_ACT_VSI_FORWARDING |
 		ICE_SINGLE_ACT_VALID_BIT | ICE_SINGLE_ACT_LAN_ENABLE;
+	int err;
+
+	err = ice_lag_cfg_fltr(lag, act, lag->pf_recipe, &lag->pf_rx_rule_id,
+			       ICE_FLTR_RX, add);
+	if (err)
+		goto err_rx;
 
-	return ice_lag_cfg_fltr(lag, act, lag->pf_recipe,
-				&lag->pf_rule_id, add);
+	act = ICE_SINGLE_ACT_VSI_FORWARDING | ICE_SINGLE_ACT_VALID_BIT |
+	      ICE_SINGLE_ACT_LB_ENABLE;
+	err = ice_lag_cfg_fltr(lag, act, lag->pf_recipe, &lag->pf_tx_rule_id,
+			       ICE_FLTR_TX, add);
+	if (err)
+		goto err_tx;
+
+	return 0;
+
+err_tx:
+	ice_lag_cfg_fltr(lag, act, lag->pf_recipe, &lag->pf_rx_rule_id,
+			 ICE_FLTR_RX, !add);
+err_rx:
+	return err;
 }
 
 /**
@@ -284,7 +310,7 @@ ice_lag_cfg_drop_fltr(struct ice_lag *lag, bool add)
 		  ICE_SINGLE_ACT_DROP;
 
 	return ice_lag_cfg_fltr(lag, act, lag->lport_recipe,
-				&lag->lport_rule_idx, add);
+				&lag->lport_rule_idx, ICE_FLTR_RX, add);
 }
 
 /**
@@ -310,7 +336,7 @@ ice_lag_cfg_pf_fltrs(struct ice_lag *lag, void *ptr)
 	dev = ice_pf_to_dev(lag->pf);
 
 	/* interface not active - remove old default VSI rule */
-	if (bonding_info->slave.state && lag->pf_rule_id) {
+	if (bonding_info->slave.state && lag->pf_rx_rule_id) {
 		if (ice_lag_cfg_dflt_fltr(lag, false))
 			dev_err(dev, "Error removing old default VSI filter\n");
 		if (ice_lag_cfg_drop_fltr(lag, true))
@@ -319,7 +345,7 @@ ice_lag_cfg_pf_fltrs(struct ice_lag *lag, void *ptr)
 	}
 
 	/* interface becoming active - add new default VSI rule */
-	if (!bonding_info->slave.state && !lag->pf_rule_id) {
+	if (!bonding_info->slave.state && !lag->pf_rx_rule_id) {
 		if (ice_lag_cfg_dflt_fltr(lag, true))
 			dev_err(dev, "Error adding new default VSI filter\n");
 		if (lag->lport_rule_idx && ice_lag_cfg_drop_fltr(lag, false))
@@ -2149,7 +2175,7 @@ void ice_lag_rebuild(struct ice_pf *pf)
 
 	ice_lag_cfg_cp_fltr(lag, true);
 
-	if (lag->pf_rule_id)
+	if (lag->pf_rx_rule_id)
 		if (ice_lag_cfg_dflt_fltr(lag, true))
 			dev_err(ice_pf_to_dev(pf), "Error adding default VSI rule in rebuild\n");
 
diff --git a/drivers/net/ethernet/intel/ice/ice_lag.h b/drivers/net/ethernet/intel/ice/ice_lag.h
index 183b38792ef2..bab2c83142a1 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.h
+++ b/drivers/net/ethernet/intel/ice/ice_lag.h
@@ -43,7 +43,8 @@ struct ice_lag {
 	u8 primary:1; /* this is primary */
 	u16 pf_recipe;
 	u16 lport_recipe;
-	u16 pf_rule_id;
+	u16 pf_rx_rule_id;
+	u16 pf_tx_rule_id;
 	u16 cp_rule_idx;
 	u16 lport_rule_idx;
 	u8 role;
-- 
2.42.0


