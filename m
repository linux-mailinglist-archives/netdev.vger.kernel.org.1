Return-Path: <netdev+bounces-256751-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPEUGdpqg2l+mgMAu9opvQ
	(envelope-from <netdev+bounces-256751-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 16:50:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2698E976E
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 16:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3EB60307E991
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 15:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90287421F0C;
	Wed,  4 Feb 2026 15:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aHcPivog"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F1B421EFD;
	Wed,  4 Feb 2026 15:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770219868; cv=none; b=MkErWBc+MAFsn8qtvwxL8sM1k+J0ckG2MxvCWGVZ867rMrJOwsmCBcl922fCjXnLMmHnRCjn0cztQ509VW8q0/sMHHvIAP68qmVCrr+Fgroinx/XqAAHVzIvw0XhJ/fmhPzkfxSF6r6tXRjWSshigsi2nm8CNDYyIwURygozu5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770219868; c=relaxed/simple;
	bh=Jlx1HM4WhK92C63jv0PewtEGzcL37nDTi+iriH0kgzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AT5EzVRdDhJMBDsn1Ea+AogVyUptQJ/zu6k5VEx/od106vKnJPInJUpT7XgJkYP6iMQUD5zOq9TRAJcBvXmU5zPDpQeHDuRkF56o3kIP8ItiiSqxWV67di3RBUH1ssoufoC4CsJ0x6fCowwpeY7RsYu+6TD9srIXVTn9PuPCr2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aHcPivog; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770219868; x=1801755868;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jlx1HM4WhK92C63jv0PewtEGzcL37nDTi+iriH0kgzk=;
  b=aHcPivog6DkbdZVRUsMKPFsEvsUj8O4TkpCI278ljLOBTC3XPvujT4u8
   5znGPm1SfgNPxSKEORRwGs0ZnHcjiLHLiOW8H6fu3X+jOVpAJzbfXZ86H
   85nZRI1Gi5z1lfbno9nqdoRf+RHRI3c461LgY0YOTT8/+V0vtdMbn8fDq
   rdUhu99h6/mrbM5KdM5yJeUACGpAXFhbRQ7zYo1jcqsarlpmF8kefZ7ue
   pRAbttuk+Eqaei2V8nS47Ikms2sm1vBrMHNRAn/oDb+1GFYpBrOcdGQTr
   LEU9tLxNciNAglRg7CNV85rYJZg8JLWGpXVsupxxQmbcOm9DbOtNWNsGG
   Q==;
X-CSE-ConnectionGUID: F5MPo02OQ0e301y+UB7wFg==
X-CSE-MsgGUID: g7cWYEFMRoCFvpjRE6VjOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="88987096"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="88987096"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 07:44:28 -0800
X-CSE-ConnectionGUID: yBmta7mfQ8+a1p3dhQUvbA==
X-CSE-MsgGUID: +nldAG6bQ7Cu9jKtAMF2nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="209494121"
Received: from hpe-dl385gen10.igk.intel.com ([10.91.240.117])
  by orviesa010.jf.intel.com with ESMTP; 04 Feb 2026 07:44:26 -0800
From: Jakub Slepecki <jakub.slepecki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	michal.swiatkowski@linux.intel.com,
	jakub.slepecki@intel.com,
	aleksandr.loktionov@intel.com
Subject: [PATCH iwl-next v4 3/7] ice: allow overriding lan_en, lb_en in switch
Date: Wed,  4 Feb 2026 16:44:14 +0100
Message-ID: <20260204154418.1285309-4-jakub.slepecki@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204154418.1285309-1-jakub.slepecki@intel.com>
References: <20260204154418.1285309-1-jakub.slepecki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-256751-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub.slepecki@intel.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D2698E976E
X-Rspamd-Action: no action

Currently, lan_en and lb_en are determined based on switching mode,
destination MAC, and the lookup type, action type and flags of the rule
in question.  This gives little to no options for the user (such as
ice_fltr.c) to enforce rules to behave in a specific way.

Such functionality is needed to work with pairs of rules, for example,
when handling MAC forward to LAN together with MAC,VLAN forward to
loopback rules pair.  This case could not be easily deduced in a context
of a single filter without adding some guessing logic or a specialized
flag.

Add a slightly more generic flag to the lan_en and lb_en themselves
for the ice_fltr.c to request specific destination flags later on,
for example, to override both values:

    struct ice_fltr_info fi;
    fi.lb_en = ICE_FLTR_INFO_LB_LAN_FORCE_ENABLED;
    fi.lan_en = ICE_FLTR_INFO_LB_LAN_FORCE_DISABLED;

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jakub Slepecki <jakub.slepecki@intel.com>
---
Added R-B from Aleksandr as we talked live and he reviewed the changes.

No changes in v4.

Changes in v3:
  - LB_LAN masks and values no longer rely on boolean promotion.
  - ice_fill_sw_info() deals with u8 the entire time instead of building
    building lb_en and lan_en values at the end from booleans.

Changes in v2:
  - Use FIELD_GET et al. when handling fi.lb_en and fi.lan_en.
  - Rename /LB_LAN/s/_MASK/_M/ because one of uses would need to break
    line
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 25 +++++++++++++--------
 drivers/net/ethernet/intel/ice/ice_switch.h | 19 +++++++++++++---
 2 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 04e5d653efce..3caccd798220 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -2534,12 +2534,14 @@ int ice_get_initial_sw_cfg(struct ice_hw *hw)
  *
  * This helper function populates the lb_en and lan_en elements of the provided
  * ice_fltr_info struct using the switch's type and characteristics of the
- * switch rule being configured.
+ * switch rule being configured.  Elements are updated only if their FORCE bit
+ * is not set.
  */
 static void ice_fill_sw_info(struct ice_hw *hw, struct ice_fltr_info *fi)
 {
-	fi->lb_en = false;
-	fi->lan_en = false;
+	u8 lan_en = fi->lan_en;
+	u8 lb_en = fi->lb_en;
+
 	if ((fi->flag & ICE_FLTR_TX) &&
 	    (fi->fltr_act == ICE_FWD_TO_VSI ||
 	     fi->fltr_act == ICE_FWD_TO_VSI_LIST ||
@@ -2549,7 +2551,7 @@ static void ice_fill_sw_info(struct ice_hw *hw, struct ice_fltr_info *fi)
 		 * packets to the internal switch that will be dropped.
 		 */
 		if (fi->lkup_type != ICE_SW_LKUP_VLAN)
-			fi->lb_en = true;
+			FIELD_MODIFY(ICE_FLTR_INFO_LB_LAN_VALUE_M, &lb_en, 1);
 
 		/* Set lan_en to TRUE if
 		 * 1. The switch is a VEB AND
@@ -2578,14 +2580,19 @@ static void ice_fill_sw_info(struct ice_hw *hw, struct ice_fltr_info *fi)
 			     !is_unicast_ether_addr(fi->l_data.mac.mac_addr)) ||
 			    (fi->lkup_type == ICE_SW_LKUP_MAC_VLAN &&
 			     !is_unicast_ether_addr(fi->l_data.mac.mac_addr)))
-				fi->lan_en = true;
+				FIELD_MODIFY(ICE_FLTR_INFO_LB_LAN_VALUE_M,
+					     &lan_en, 1);
 		} else {
-			fi->lan_en = true;
+			FIELD_MODIFY(ICE_FLTR_INFO_LB_LAN_VALUE_M, &lan_en, 1);
 		}
 	}
 
 	if (fi->flag & ICE_FLTR_TX_ONLY)
-		fi->lan_en = false;
+		FIELD_MODIFY(ICE_FLTR_INFO_LB_LAN_VALUE_M, &lan_en, 0);
+	if (!FIELD_GET(ICE_FLTR_INFO_LB_LAN_FORCE_M, lb_en))
+		fi->lb_en = lb_en;
+	if (!FIELD_GET(ICE_FLTR_INFO_LB_LAN_FORCE_M, lan_en))
+		fi->lan_en = lan_en;
 }
 
 /**
@@ -2669,9 +2676,9 @@ ice_fill_sw_rule(struct ice_hw *hw, struct ice_fltr_info *f_info,
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
index 671d7a5f359f..137eae878ab1 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.h
+++ b/drivers/net/ethernet/intel/ice/ice_switch.h
@@ -72,6 +72,14 @@ enum ice_src_id {
 	ICE_SRC_ID_LPORT,
 };
 
+#define ICE_FLTR_INFO_LB_LAN_VALUE_M BIT(0)
+#define ICE_FLTR_INFO_LB_LAN_FORCE_M BIT(1)
+#define ICE_FLTR_INFO_LB_LAN_FORCE_ENABLED			 \
+	(FIELD_PREP_CONST(ICE_FLTR_INFO_LB_LAN_VALUE_M, 1) |  \
+	 FIELD_PREP_CONST(ICE_FLTR_INFO_LB_LAN_FORCE_M, 1))
+#define ICE_FLTR_INFO_LB_LAN_FORCE_DISABLED			 \
+	(FIELD_PREP_CONST(ICE_FLTR_INFO_LB_LAN_FORCE_M, 1))
+
 struct ice_fltr_info {
 	/* Look up information: how to look up packet */
 	enum ice_sw_lkup_type lkup_type;
@@ -131,9 +139,14 @@ struct ice_fltr_info {
 	 */
 	u8 qgrp_size;
 
-	/* Rule creations populate these indicators basing on the switch type */
-	u8 lb_en;	/* Indicate if packet can be looped back */
-	u8 lan_en;	/* Indicate if packet can be forwarded to the uplink */
+	/* Following members have two bits: VALUE and FORCE.  Rule creation will
+	 * populate VALUE bit of these members based on switch type, but only if
+	 * their FORCE bit is not set.
+	 *
+	 * See ICE_FLTR_INFO_LB_LAN_VALUE_M and ICE_FLTR_INFO_LB_LAN_FORCE_M.
+	 */
+	u8 lb_en;	/* VALUE bit: packet can be looped back */
+	u8 lan_en;	/* VALUE bit: packet can be forwarded to the uplink */
 };
 
 struct ice_update_recipe_lkup_idx_params {
-- 
2.43.0


