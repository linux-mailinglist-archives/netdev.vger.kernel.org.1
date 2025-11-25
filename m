Return-Path: <netdev+bounces-241438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD37C84024
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 09:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E48324E89A7
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 08:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FC32FFDD6;
	Tue, 25 Nov 2025 08:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="icrBi0FN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E1B2FF166;
	Tue, 25 Nov 2025 08:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764059710; cv=none; b=bIW+QYHsU4LEYGyrzdCRCm2+42CycKe9XufrMlvEvNCmPF/Z0HDHOn9TIW2vMuDtihu0qf/4OMqaqo/7jOI0j+L7WYn0QB8FjApwLw+7otdMIoUb0CN8v+FOqIFJsWMSAsiDEOwTwInvCTiYQVIL0cXzvdk6DWA5yYeh+3P4rSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764059710; c=relaxed/simple;
	bh=LD1Sq4vuKKU7qYEKwzSby9X/dhqZHZ7greDgzv3gq80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZZs3og8Xqx/vg0LvrFz+dK57lxuRwrFldNs5k2BOFeQV+s01SXZWkI2f1pz+LkUlwEv461LMpzivAobvpMr/IAoEioOn0MNIv1DEzZPg7eg1EicAmuqTZvfO+gAhqRj8XZ0675kObOd8szuBp8jgJQQMtBa5GlADK5TYenZuaFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=icrBi0FN; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764059708; x=1795595708;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LD1Sq4vuKKU7qYEKwzSby9X/dhqZHZ7greDgzv3gq80=;
  b=icrBi0FN1/SR7j9FX4xqpb292DPbC1WFqlQHp7IVCcBbCcGdVyx7xUAx
   VPpdBOK3tOUeIna+KRN9oKonWwqx0RckTf4Eo7gBydFUnYQ9OsuNoz3H0
   74joVkjjV2vWdaY5vRZlir/zt12F/eb+XtQfODB7yWDsJnF9vvtpuY2ax
   XtNpspaS7qKhEl1JZPXe+EXm69RS9Ren7xAoyaJZHhMAXTLL6wx/fEM2o
   EzFeshaB5T8sOJEivi4GqaU1XWnPUFzB9/adv5Ve6gp0yE3bMi8b8UnlI
   WxFsD4lBHbjKu+i8gEgXL7gJan/I4dHR9we4juvVPueiOJ6rch0e1vZy8
   w==;
X-CSE-ConnectionGUID: j7qkJEzcQgyWC6IfCtRhAg==
X-CSE-MsgGUID: VUAcT2TcQYafnds5MF39iA==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="76694450"
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; 
   d="scan'208";a="76694450"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 00:35:08 -0800
X-CSE-ConnectionGUID: +zCLvLmcS66fbIl3F29HFA==
X-CSE-MsgGUID: pxG76YHFSxWB+dOT9wBuFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; 
   d="scan'208";a="196749931"
Received: from hpe-dl385gen10.igk.intel.com ([10.91.240.117])
  by orviesa003.jf.intel.com with ESMTP; 25 Nov 2025 00:35:07 -0800
From: Jakub Slepecki <jakub.slepecki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	michal.swiatkowski@linux.intel.com,
	jakub.slepecki@intel.com,
	aleksandr.loktionov@intel.com
Subject: [PATCH iwl-next v2 4/8] ice: allow overriding lan_en, lb_en in switch
Date: Tue, 25 Nov 2025 09:34:52 +0100
Message-ID: <20251125083456.28822-5-jakub.slepecki@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251125083456.28822-1-jakub.slepecki@intel.com>
References: <20251125083456.28822-1-jakub.slepecki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit

Currently, lan_en and lb_en are determined based on switching mode,
destination MAC, and the lookup type, action type and flags of the rule
in question.  This gives little to no options for the user (such as
ice_fltr.c) to enforce rules to behave in a specific way.

Such functionality is needed to work with pairs of rules, for example,
when handling MAC forward to LAN together with MAC,VLAN forward to
loopback rules pair.  This case could not be easily deduced in a context
of a single filter without adding a specialized flag.

Instead of adding a specialized flag to mark special scenario rules,
we add a slightly more generic flag to the lan_en and lb_en themselves
for the ice_fltr.c to request specific destination flags later on, for
example, to override value:

    struct ice_fltr_info fi;
    fi.lb_en = ICE_FLTR_INFO_LB_LAN_FORCE_ENABLED;
    fi.lan_en = ICE_FLTR_INFO_LB_LAN_FORCE_DISABLED;

Signed-off-by: Jakub Slepecki <jakub.slepecki@intel.com>

---
Dropping reviewed-by from Michał due to changes.

Changes in v2:
  - Use FIELD_GET et al. when handling fi.lb_en and fi.lan_en.
  - Rename /LB_LAN/s/_MASK/_M/ because one of uses would need to break
    line.
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 21 +++++++++++++--------
 drivers/net/ethernet/intel/ice/ice_switch.h |  8 ++++++++
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 04e5d653efce..b3f5cda1571e 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -2538,8 +2538,9 @@ int ice_get_initial_sw_cfg(struct ice_hw *hw)
  */
 static void ice_fill_sw_info(struct ice_hw *hw, struct ice_fltr_info *fi)
 {
-	fi->lb_en = false;
-	fi->lan_en = false;
+	bool lan_en = false;
+	bool lb_en = false;
+
 	if ((fi->flag & ICE_FLTR_TX) &&
 	    (fi->fltr_act == ICE_FWD_TO_VSI ||
 	     fi->fltr_act == ICE_FWD_TO_VSI_LIST ||
@@ -2549,7 +2550,7 @@ static void ice_fill_sw_info(struct ice_hw *hw, struct ice_fltr_info *fi)
 		 * packets to the internal switch that will be dropped.
 		 */
 		if (fi->lkup_type != ICE_SW_LKUP_VLAN)
-			fi->lb_en = true;
+			lb_en = true;
 
 		/* Set lan_en to TRUE if
 		 * 1. The switch is a VEB AND
@@ -2578,14 +2579,18 @@ static void ice_fill_sw_info(struct ice_hw *hw, struct ice_fltr_info *fi)
 			     !is_unicast_ether_addr(fi->l_data.mac.mac_addr)) ||
 			    (fi->lkup_type == ICE_SW_LKUP_MAC_VLAN &&
 			     !is_unicast_ether_addr(fi->l_data.mac.mac_addr)))
-				fi->lan_en = true;
+				lan_en = true;
 		} else {
-			fi->lan_en = true;
+			lan_en = true;
 		}
 	}
 
 	if (fi->flag & ICE_FLTR_TX_ONLY)
-		fi->lan_en = false;
+		lan_en = false;
+	if (!FIELD_GET(ICE_FLTR_INFO_LB_LAN_FORCE_M, fi->lb_en))
+		FIELD_MODIFY(ICE_FLTR_INFO_LB_LAN_VALUE_M, &fi->lb_en, lb_en);
+	if (!FIELD_GET(ICE_FLTR_INFO_LB_LAN_FORCE_M, fi->lan_en))
+		FIELD_MODIFY(ICE_FLTR_INFO_LB_LAN_VALUE_M, &fi->lan_en, lan_en);
 }
 
 /**
@@ -2669,9 +2674,9 @@ ice_fill_sw_rule(struct ice_hw *hw, struct ice_fltr_info *f_info,
 		return;
 	}
 
-	if (f_info->lb_en)
+	if (FIELD_GET(ICE_FLTR_INFO_LB_LAN_VALUE_M, f_info->lb_en))
 		act |= ICE_SINGLE_ACT_LB_ENABLE;
-	if (f_info->lan_en)
+	if (FIELD_GET(ICE_FLTR_INFO_LB_LAN_VALUE_M, f_info->lan_en))
 		act |= ICE_SINGLE_ACT_LAN_ENABLE;
 
 	switch (f_info->lkup_type) {
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.h b/drivers/net/ethernet/intel/ice/ice_switch.h
index 671d7a5f359f..b694c131ad58 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.h
+++ b/drivers/net/ethernet/intel/ice/ice_switch.h
@@ -72,6 +72,14 @@ enum ice_src_id {
 	ICE_SRC_ID_LPORT,
 };
 
+#define ICE_FLTR_INFO_LB_LAN_VALUE_M BIT(0)
+#define ICE_FLTR_INFO_LB_LAN_FORCE_M BIT(1)
+#define ICE_FLTR_INFO_LB_LAN_FORCE_ENABLED			 \
+	(FIELD_PREP_CONST(ICE_FLTR_INFO_LB_LAN_VALUE_M, true) |  \
+	 FIELD_PREP_CONST(ICE_FLTR_INFO_LB_LAN_FORCE_M, true))
+#define ICE_FLTR_INFO_LB_LAN_FORCE_DISABLED			 \
+	(FIELD_PREP_CONST(ICE_FLTR_INFO_LB_LAN_FORCE_M, true))
+
 struct ice_fltr_info {
 	/* Look up information: how to look up packet */
 	enum ice_sw_lkup_type lkup_type;
-- 
2.43.0


