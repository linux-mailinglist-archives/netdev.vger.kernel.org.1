Return-Path: <netdev+bounces-256750-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMHjIHNxg2mFmwMAu9opvQ
	(envelope-from <netdev+bounces-256750-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 17:18:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D79DEEA17B
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 17:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7539430D16A8
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 15:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85FB421EF7;
	Wed,  4 Feb 2026 15:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LE6/xRd6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05270421EEC;
	Wed,  4 Feb 2026 15:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770219866; cv=none; b=c71oA3+tH7lBnzKMao0ifMwbpozwaHi1CqkHGUxUxzqP/3pjdZ84jr20ZjHIlGB3YzUkwUEKcDBW97D3s0c1RVvsDDVqO4sjPaJ6a8AHQ7dW/4IBkrjRrdYxOGar1W44qWtqSlUJG+e0g27cpkLsA6xikRs8r+TMXO7uPb4albU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770219866; c=relaxed/simple;
	bh=JWmvUqaxGBDpmxTflwTsgJtVOJVahu8eyBgHP2/Rcdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AKEbxRs/6opefEv1ItJQmyXPp/2XXN9/2XH9d72S3rCHEI/WrO9IxegSjRtcb24gAb/PO+qIKWfYBDfZuA7sBNCD2l2mCVmaOoZVaX+oK8Pf+580m9qcgGsQct6wlFJJ1Evr56sIYFRWVc7kNaM9L3lee62YXj/pn4m1l7hsiqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LE6/xRd6; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770219866; x=1801755866;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JWmvUqaxGBDpmxTflwTsgJtVOJVahu8eyBgHP2/Rcdo=;
  b=LE6/xRd6KnwS4BIC3dG0IiWxf0uJUkQYZ1a24hgPxh9ynzh85C3UpRPR
   J08gK9XuCFC4+pOrCgq59KcNv6zzAPXz6dIdr7GkeUg540Lssal79Y+o1
   sf+XR1+Cg2fclaWo1wMUK48tq7XWpFe7+q9iDo5iYTT4f3iQ4/HEczu6m
   2k2LRrExMXwLeV1tMtE4SbZxxK5z68s3nDfl1d6ikSgodrqvNQ3q6IP7q
   8+2Qr/5C4+x0R+DJg+1teQXl6oundqwGZxEKpTxwBqL91ovxM3tKi063C
   daMub3zyvnEWhZFSv/Kvg1Ys/leX9kueKlVLlWEceM2MvcSrkWJSG0lqx
   Q==;
X-CSE-ConnectionGUID: oN6IMKnOROGzUz7r0HXhbQ==
X-CSE-MsgGUID: s6Or9dOUR1y3lPwAtw7mWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="88987092"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="88987092"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 07:44:26 -0800
X-CSE-ConnectionGUID: 6jqfFe4nRtKo1bJylNkOEA==
X-CSE-MsgGUID: AKljs61XQ7SXqFBlobG3LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="209494118"
Received: from hpe-dl385gen10.igk.intel.com ([10.91.240.117])
  by orviesa010.jf.intel.com with ESMTP; 04 Feb 2026 07:44:23 -0800
From: Jakub Slepecki <jakub.slepecki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	michal.swiatkowski@linux.intel.com,
	jakub.slepecki@intel.com,
	aleksandr.loktionov@intel.com
Subject: [PATCH iwl-next v4 2/7] ice: allow creating mac,vlan filters along mac filters
Date: Wed,  4 Feb 2026 16:44:13 +0100
Message-ID: <20260204154418.1285309-3-jakub.slepecki@intel.com>
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
	TAGGED_FROM(0.00)[bounces-256750-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D79DEEA17B
X-Rspamd-Action: no action

Among other uses, MAC filters are currently used to forward loopback
traffic between VSIs.  However, they only match destination MAC addresses
making them prone to mistakes when handling traffic within multiple
VLANs and especially across the boundaries.

Allows the driver to create MAC,VLAN filters in the same flow as
MAC-only filters completely interchangeably.  This is intended to be
used to forward the loopback traffic only within the boundaries of
particular VLANs.

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jakub Slepecki <jakub.slepecki@intel.com>

---
No changes in v4.
No changes in v3.
No changes in v2.
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 48 ++++++++++++++++-----
 1 file changed, 38 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 84848f0123e7..0275e2910c6b 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -3606,6 +3606,29 @@ bool ice_vlan_fltr_exist(struct ice_hw *hw, u16 vlan_id, u16 vsi_handle)
 	return false;
 }
 
+/**
+ * ice_fltr_mac_address - Find MAC in filter
+ * @dst: output MAC address
+ * @info: information struct for the filter in question
+ *
+ * Return: 0 for success, %-ENXIO if no address was found in the filter
+ * information.
+ */
+static
+int ice_fltr_mac_address(u8 *dst, struct ice_fltr_info *info)
+{
+	switch (info->lkup_type) {
+	case ICE_SW_LKUP_MAC:
+		ether_addr_copy(dst, info->l_data.mac.mac_addr);
+		return 0;
+	case ICE_SW_LKUP_MAC_VLAN:
+		ether_addr_copy(dst, info->l_data.mac_vlan.mac_addr);
+		return 0;
+	default:
+		return -ENXIO;
+	}
+}
+
 /**
  * ice_add_mac - Add a MAC address based filter rule
  * @hw: pointer to the hardware structure
@@ -3614,16 +3637,19 @@ bool ice_vlan_fltr_exist(struct ice_hw *hw, u16 vlan_id, u16 vsi_handle)
 int ice_add_mac(struct ice_hw *hw, struct list_head *m_list)
 {
 	struct ice_fltr_list_entry *m_list_itr;
-	int status = 0;
+	int err;
 
 	if (!m_list || !hw)
 		return -EINVAL;
 
 	list_for_each_entry(m_list_itr, m_list, list_entry) {
-		u8 *add = &m_list_itr->fltr_info.l_data.mac.mac_addr[0];
+		u8 addr[ETH_ALEN];
 		u16 vsi_handle;
 		u16 hw_vsi_id;
 
+		err = ice_fltr_mac_address(addr, &m_list_itr->fltr_info);
+		if (err || is_zero_ether_addr(addr))
+			return -EINVAL;
 		m_list_itr->fltr_info.flag = ICE_FLTR_TX;
 		vsi_handle = m_list_itr->fltr_info.vsi_handle;
 		if (!ice_is_vsi_valid(hw, vsi_handle))
@@ -3634,17 +3660,19 @@ int ice_add_mac(struct ice_hw *hw, struct list_head *m_list)
 		if (m_list_itr->fltr_info.src_id != ICE_SRC_ID_VSI)
 			return -EINVAL;
 		m_list_itr->fltr_info.src = hw_vsi_id;
-		if (m_list_itr->fltr_info.lkup_type != ICE_SW_LKUP_MAC ||
-		    is_zero_ether_addr(add))
+		if (m_list_itr->fltr_info.lkup_type != ICE_SW_LKUP_MAC &&
+		    m_list_itr->fltr_info.lkup_type != ICE_SW_LKUP_MAC_VLAN)
 			return -EINVAL;
 
-		m_list_itr->status = ice_add_rule_internal(hw, ICE_SW_LKUP_MAC,
-							   m_list_itr);
+		m_list_itr->status =
+			ice_add_rule_internal(hw,
+					      m_list_itr->fltr_info.lkup_type,
+					      m_list_itr);
 		if (m_list_itr->status)
 			return m_list_itr->status;
 	}
 
-	return status;
+	return 0;
 }
 
 /**
@@ -4055,7 +4083,7 @@ int ice_remove_mac(struct ice_hw *hw, struct list_head *m_list)
 		enum ice_sw_lkup_type l_type = list_itr->fltr_info.lkup_type;
 		u16 vsi_handle;
 
-		if (l_type != ICE_SW_LKUP_MAC)
+		if (l_type != ICE_SW_LKUP_MAC && l_type != ICE_SW_LKUP_MAC_VLAN)
 			return -EINVAL;
 
 		vsi_handle = list_itr->fltr_info.vsi_handle;
@@ -4066,7 +4094,7 @@ int ice_remove_mac(struct ice_hw *hw, struct list_head *m_list)
 					ice_get_hw_vsi_num(hw, vsi_handle);
 
 		list_itr->status = ice_remove_rule_internal(hw,
-							    ICE_SW_LKUP_MAC,
+							    l_type,
 							    list_itr);
 		if (list_itr->status)
 			return list_itr->status;
@@ -4507,6 +4535,7 @@ ice_remove_vsi_lkup_fltr(struct ice_hw *hw, u16 vsi_handle,
 
 	switch (lkup) {
 	case ICE_SW_LKUP_MAC:
+	case ICE_SW_LKUP_MAC_VLAN:
 		ice_remove_mac(hw, &remove_list_head);
 		break;
 	case ICE_SW_LKUP_VLAN:
@@ -4516,7 +4545,6 @@ ice_remove_vsi_lkup_fltr(struct ice_hw *hw, u16 vsi_handle,
 	case ICE_SW_LKUP_PROMISC_VLAN:
 		ice_remove_promisc(hw, lkup, &remove_list_head);
 		break;
-	case ICE_SW_LKUP_MAC_VLAN:
 	case ICE_SW_LKUP_ETHERTYPE:
 	case ICE_SW_LKUP_ETHERTYPE_MAC:
 	case ICE_SW_LKUP_DFLT:
-- 
2.43.0


