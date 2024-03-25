Return-Path: <netdev+bounces-81768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D216988B419
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 23:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC91BBA51C1
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 20:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD2F524D8;
	Mon, 25 Mar 2024 20:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BrqjNeZq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BF84654D
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 20:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711398396; cv=none; b=hIjzyIsirzgZzHnaHPyyvuBivHbXjFi3LZnjQDv7YvOn2HFx5Z8dXAFGhvhg5mDMLcRWjPzDj427THZ0yeW+lDRjkVRUZh5TbFjh7/4oNHsx86HH3/xo6SujLXfi7PQs08d+j6CzmS+b4wsYgohaVS2al8Krp0P35s4zvrzRj9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711398396; c=relaxed/simple;
	bh=tqyIQsC0CZIRcmMNpzwmhg/FXm1Zp2OatR5Zqyy2YYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NandtNYzCRDF2NrTLrvYIG4jjVJp5A/AK8Z9Nh0/JEhUdOALV9qSao5qiB20kT1QWn1ylx3vHKmFEFZN7JzgleWUn/d7UY9HGZ1mqDUQsKsfbQDHE8MvB0eZsgxlzlU6wJtq+s2BfCR4LP1y88JVmp7qJ3Uk52ND2B6wGVrAP2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BrqjNeZq; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711398396; x=1742934396;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tqyIQsC0CZIRcmMNpzwmhg/FXm1Zp2OatR5Zqyy2YYw=;
  b=BrqjNeZqv3epWlFhzvrgYCYM1cTD+XGAGcCWliJ7mGxyV1kXWcYEnYYx
   mo3Sxf1NyyRdDEVOiUgti0JZK5/bnd2igDYOfQ0xNwjF3V0TRW6cFgkPF
   Gg1F38gcdoBsx2UVeNIOZ76iQ9PMDIhD/HQUmwm0KPAP9/uPGo6PtH+xM
   fLVXMaDoiDf77IbHf70tQHy1uFM0rm2GeVZjUVdPLPEYgz2pl86ubnMqm
   Ykej3/yvE1iP4OO4KgvUxFh3KbFSUnivP0+IeqwZnKt6wCe5QLS76FoYG
   RDWJqkN0BUUDOKoVN9nf6Seh+UDh1/soldYbXNGeITiH7XfMvz4wk7oW6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="10219652"
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="10219652"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 13:26:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="15787375"
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
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net-next 4/8] ice: control default Tx rule in lag
Date: Mon, 25 Mar 2024 13:26:12 -0700
Message-ID: <20240325202623.1012287-5-anthony.l.nguyen@intel.com>
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

Tx rule in switchdev was changed to use PF instead of additional control
plane VSI. Because of that during lag we should control it. Control
means to add and remove the default Tx rule during lag active/inactive
switching.

It can be done the same way as default Rx rule.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lag.c | 44 +++++++++++++++++++-----
 drivers/net/ethernet/intel/ice/ice_lag.h |  3 +-
 2 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
index 467372d541d2..7b802884440c 100644
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
2.41.0


