Return-Path: <netdev+bounces-256749-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4C0wOn9qg2l+mgMAu9opvQ
	(envelope-from <netdev+bounces-256749-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 16:49:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 851E7E96A7
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 16:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 56D293026085
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 15:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF9C4219FA;
	Wed,  4 Feb 2026 15:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZV6XuF1O"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC0B42188B;
	Wed,  4 Feb 2026 15:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770219864; cv=none; b=kLLNKQFZAMg+9lrgHKcnQbZxRHjEDCUKOpL89Hk5DQWw7JaIQUvMnffgB+mA+QDahpvLKZITw+npoPwHaJM8ogKs1uPzxEhwVO5fxyTzYrYYsS/nHKJF63WLfNIDJ57HfsRkknYqbn2xYxxrOjT5LHEMaQn2XhU/jj+7mKj8C/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770219864; c=relaxed/simple;
	bh=dwcyIJF8VgjcMQ3xJeX68AIy1NtJFyfUkiIvEZTRHPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WQuxWTYavgpLubgJlGwOh1uf5jBpgJQ+vPj5Wp0moTaa+7vEZJ6GDiiTuzm+aQKaU+K4Z73V5m/2g251f1/3DjgaQXMt5e7tyGdSvYN0OhXylUmaKoxusu0YjPO/apERDq9W29c2nKAgCbw4wY2yalIKFc2Q28z+vwz+AzSPjcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZV6XuF1O; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770219864; x=1801755864;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dwcyIJF8VgjcMQ3xJeX68AIy1NtJFyfUkiIvEZTRHPw=;
  b=ZV6XuF1O2iiX2/VgOs3Zry092byxM1rCGAT6Fh9VhgAI/SkWFPP/0Dr/
   2UqIQ7FCrlPez/iD+FzesjpJ6YVpdEPUPrCqmkE2Bt2VITiR++S8zm+zi
   oZDosId0ZIBtEg46kIPnC69Yj7B6jo/Fv4O5l1m34q1Tmy5BFfRxmM5WI
   2nhCRkXT8FQHp2AGJt6Zyi+FYEoEwwBvPcbwk/J6/Bh2zAc7tbZbp3nvV
   gLlZ8hlyeCl2UoxoDo5oknQz6yO4sDRWzfq6RH9ldS8rxvlUa3+Ff2DYQ
   wKC1J3ArDdVirM6MrGQhfV2cuUI90AuO+HlgJqteTsLzOrqGW/ad9dEyL
   g==;
X-CSE-ConnectionGUID: yYVTmAwySV6hdaIDZBzlmA==
X-CSE-MsgGUID: vOvH/phrQzmUxQdgKVD9wA==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="88987088"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="88987088"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 07:44:23 -0800
X-CSE-ConnectionGUID: CiN9cfT+QQ6oak+3mG5LwA==
X-CSE-MsgGUID: yzzJF2+6RhKZB9/RP/OxhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="209494108"
Received: from hpe-dl385gen10.igk.intel.com ([10.91.240.117])
  by orviesa010.jf.intel.com with ESMTP; 04 Feb 2026 07:44:21 -0800
From: Jakub Slepecki <jakub.slepecki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	michal.swiatkowski@linux.intel.com,
	jakub.slepecki@intel.com,
	aleksandr.loktionov@intel.com
Subject: [PATCH iwl-next v4 1/7] ice: in dvm, use outer VLAN in MAC,VLAN lookup
Date: Wed,  4 Feb 2026 16:44:12 +0100
Message-ID: <20260204154418.1285309-2-jakub.slepecki@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204154418.1285309-1-jakub.slepecki@intel.com>
References: <20260204154418.1285309-1-jakub.slepecki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[jakub.slepecki@intel.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-256749-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 851E7E96A7
X-Rspamd-Action: no action

In double VLAN mode (DVM), outer VLAN is located a word earlier in
the field vector compared to the single VLAN mode.  We already modify
ICE_SW_LKUP_VLAN to use it but ICE_SW_LKUP_MAC_VLAN was left untouched,
causing the lookup to match any packet with one or no layer of Dot1q.
This change enables to fix cross-vlan loopback traffic using MAC,VLAN
lookups.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Jakub Slepecki <jakub.slepecki@intel.com>

---
No changes in v4.
No changes in v3.
No changes in v2.
---
 drivers/net/ethernet/intel/ice/ice_vlan_mode.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_vlan_mode.c b/drivers/net/ethernet/intel/ice/ice_vlan_mode.c
index fb526cb84776..68a7b05de44e 100644
--- a/drivers/net/ethernet/intel/ice/ice_vlan_mode.c
+++ b/drivers/net/ethernet/intel/ice/ice_vlan_mode.c
@@ -198,6 +198,7 @@ static bool ice_is_dvm_supported(struct ice_hw *hw)
 #define ICE_SW_LKUP_VLAN_LOC_LKUP_IDX			1
 #define ICE_SW_LKUP_VLAN_PKT_FLAGS_LKUP_IDX		2
 #define ICE_SW_LKUP_PROMISC_VLAN_LOC_LKUP_IDX		2
+#define ICE_SW_LKUP_MAC_VLAN_LOC_LKUP_IDX		4
 #define ICE_PKT_FLAGS_0_TO_15_FV_IDX			1
 static struct ice_update_recipe_lkup_idx_params ice_dvm_dflt_recipes[] = {
 	{
@@ -234,6 +235,17 @@ static struct ice_update_recipe_lkup_idx_params ice_dvm_dflt_recipes[] = {
 		.mask_valid = false,  /* use pre-existing mask */
 		.lkup_idx = ICE_SW_LKUP_PROMISC_VLAN_LOC_LKUP_IDX,
 	},
+	{
+		/* Similarly to ICE_SW_LKUP_VLAN, change to outer/single VLAN in
+		 * DVM
+		 */
+		.rid = ICE_SW_LKUP_MAC_VLAN,
+		.fv_idx = ICE_EXTERNAL_VLAN_ID_FV_IDX,
+		.ignore_valid = true,
+		.mask = 0,
+		.mask_valid = false,
+		.lkup_idx = ICE_SW_LKUP_MAC_VLAN_LOC_LKUP_IDX,
+	},
 };
 
 /**
-- 
2.43.0


