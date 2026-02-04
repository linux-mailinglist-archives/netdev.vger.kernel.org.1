Return-Path: <netdev+bounces-256754-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mG5aNYxvg2lgmwMAu9opvQ
	(envelope-from <netdev+bounces-256754-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 17:10:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AF9E9F7C
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 17:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEA14329E767
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 15:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE2842668A;
	Wed,  4 Feb 2026 15:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i7HS1P/y"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106F6156677;
	Wed,  4 Feb 2026 15:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770219875; cv=none; b=IbbJFJQG35HM5WywEa7+AdDezvYXAn877/nlnR2U1B9lOxNc5OQwgjSrc/QpmRAHUYPhgi97JQ5XCXI5e5HqtYQTApPtBpZDz00Y60RQc91Xo+lsRETA1gHgbv0qrhUlFxkFWl1/s4u3lu1QEchAUDx1h9qMbh1OjEGXCjBhZAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770219875; c=relaxed/simple;
	bh=K0E7+UMYGPTimqdt5ibfjpZFUmqBu3rV8ubOJ6pR7tc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I2RZGpUfr+VClAdaZFrR+hCO3Hcb+bszoXUs/EcbCDSxmPbYSVDKsjtq+9U/Zpq4Y/81voA0IM07uIa+eqpNV6atzsV3hjX04RvvO097z+xI1/K81uz7WPo/BQl69oNAdOQSXDTLqQ6WjXpYcVFJV4sFu0VraRW1ygd/a05Dq6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i7HS1P/y; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770219875; x=1801755875;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K0E7+UMYGPTimqdt5ibfjpZFUmqBu3rV8ubOJ6pR7tc=;
  b=i7HS1P/yUSO5GwgnChNqglh3qnciJeXHEpAjx0kG8tQtqwoQ/nUi3wM5
   Mbozutd8SO0qha3UT0jWO28s90OXMjROkAPY91wXk+rfp+7wBzZNsstEd
   M+1Y9SmZyLad4tPNdIYfv1JgW8o/IlwmegKBv+SROWsB636CGtPMRfyrH
   qXKaXdoM7UvCpKcsb/a68jLvJpnJmIX/+GmDSLLqeRd3PqFQ218vRDHot
   oyBlrZ2a8OVooyaNvFc80QkU1W7xRRtvZDDu8PTj6IszwA6Rr42arZLuK
   niDybjSx/My5oUYe4/bW2P2p7V7aKmE0Sf67nxTLNqNUpKDJWjpdH08nn
   g==;
X-CSE-ConnectionGUID: 37LSrM9nQk2oKx/RSCubRQ==
X-CSE-MsgGUID: Nt/HCuQxQKiuBWSXYOV3hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="88987115"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="88987115"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 07:44:35 -0800
X-CSE-ConnectionGUID: dSAUQIflSTuYohwg3SIPYg==
X-CSE-MsgGUID: Qp/7AQxdSsOPPRzlbTZHfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="209494136"
Received: from hpe-dl385gen10.igk.intel.com ([10.91.240.117])
  by orviesa010.jf.intel.com with ESMTP; 04 Feb 2026 07:44:32 -0800
From: Jakub Slepecki <jakub.slepecki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	michal.swiatkowski@linux.intel.com,
	jakub.slepecki@intel.com,
	aleksandr.loktionov@intel.com
Subject: [PATCH iwl-next v4 6/7] ice: add mac vlan to filter API
Date: Wed,  4 Feb 2026 16:44:17 +0100
Message-ID: <20260204154418.1285309-7-jakub.slepecki@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[jakub.slepecki@intel.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-256754-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 29AF9E9F7C
X-Rspamd-Action: no action

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Allow mac vlan filters to be managed by filters API in ice driver.
Together with mac-only filters they will be used to forward traffic
intended for loopback in VEB mode.

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jakub Slepecki <jakub.slepecki@intel.com>

---
No changes in v4.
No changes in v3.
No changes in v2.
---
 drivers/net/ethernet/intel/ice/ice_fltr.c | 33 +++++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_fltr.h |  4 +++
 2 files changed, 37 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_fltr.c b/drivers/net/ethernet/intel/ice/ice_fltr.c
index aff7a141c30d..96a4e4b1b3fc 100644
--- a/drivers/net/ethernet/intel/ice/ice_fltr.c
+++ b/drivers/net/ethernet/intel/ice/ice_fltr.c
@@ -240,6 +240,39 @@ ice_fltr_add_mac_to_list(struct ice_vsi *vsi, struct list_head *list,
 					  list);
 }
 
+/**
+ * ice_fltr_add_mac_vlan_to_list - add MAC VLAN filter info to
+ * existing list
+ * @vsi: pointer to VSI struct
+ * @list: list to add filter info to
+ * @mac: MAC address to add
+ * @vlan_id: VLAN id to add
+ * @action: filter action
+ *
+ * Return:
+ * * 0 if entry for filter was added, or
+ * * %-ENOMEM if entry could not be allocated.
+ */
+int
+ice_fltr_add_mac_vlan_to_list(struct ice_vsi *vsi, struct list_head *list,
+			      const u8 *mac, u16 vlan_id,
+			      enum ice_sw_fwd_act_type action)
+{
+	struct ice_fltr_info info = {};
+
+	info.flag = ICE_FLTR_TX;
+	info.src_id = ICE_SRC_ID_VSI;
+	info.lkup_type = ICE_SW_LKUP_MAC_VLAN;
+	info.fltr_act = action;
+	info.vsi_handle = vsi->idx;
+
+	info.l_data.mac_vlan.vlan_id = vlan_id;
+	ether_addr_copy(info.l_data.mac_vlan.mac_addr, mac);
+
+	return ice_fltr_add_entry_to_list(ice_pf_to_dev(vsi->back), &info,
+					  list);
+}
+
 /**
  * ice_fltr_add_vlan_to_list - add VLAN filter info to exsisting list
  * @vsi: pointer to VSI struct
diff --git a/drivers/net/ethernet/intel/ice/ice_fltr.h b/drivers/net/ethernet/intel/ice/ice_fltr.h
index 0f3dbc308eec..fb9ffb39be50 100644
--- a/drivers/net/ethernet/intel/ice/ice_fltr.h
+++ b/drivers/net/ethernet/intel/ice/ice_fltr.h
@@ -23,6 +23,10 @@ int
 ice_fltr_add_mac_to_list(struct ice_vsi *vsi, struct list_head *list,
 			 const u8 *mac, enum ice_sw_fwd_act_type action);
 int
+ice_fltr_add_mac_vlan_to_list(struct ice_vsi *vsi, struct list_head *list,
+			      const u8 *mac, u16 vlan_id,
+			      enum ice_sw_fwd_act_type action);
+int
 ice_fltr_add_mac(struct ice_vsi *vsi, const u8 *mac,
 		 enum ice_sw_fwd_act_type action);
 int
-- 
2.43.0


