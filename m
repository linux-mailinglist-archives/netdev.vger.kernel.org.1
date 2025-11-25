Return-Path: <netdev+bounces-241441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DE9C84031
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 09:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 696CE34DA32
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 08:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506AE302759;
	Tue, 25 Nov 2025 08:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fk/zpBfi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A063019C5;
	Tue, 25 Nov 2025 08:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764059717; cv=none; b=F25cqmFoQWRtom6FVEaOMkwD0dTAVDKKh316yrOy8OKA8xbw1WOyiUKIOllXnwihwz70c1aw637KKT7UqBwY57TGtgABVmtj4IK9zWIs16RfMyWseZtdwwCphNswJ3gBXyX12DzNpmIIB6xJMZAVSdLqGuPs3B+8DKBKB5C7wE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764059717; c=relaxed/simple;
	bh=6muR2WPvesx66PW1vmJn92/ClL9m4ig7yvnTOy2aBmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U3/a1WDYm7rAZ3THXAeBUXoZ91gPVAa5jQiukJWPfZnbURQOfawiw9YO0Zy6keSv/H5WE/ruiW4rVBV6Xw3EveGQRVH9BUuAy5eVupZBuGkx+ZA0x+BIcz3RQxzfzrZXqDfOp4Q9VJt/l7FZpHLVhY7UGvfHdC4quaN5pVA/LeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fk/zpBfi; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764059715; x=1795595715;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6muR2WPvesx66PW1vmJn92/ClL9m4ig7yvnTOy2aBmk=;
  b=fk/zpBfiuWYXP98TX6GDAcq2xbQXFD1avj6oxJRNth9ZdTY7rKJKohvI
   +hLNTllEB8+/ozaxSVylpB5N40uYFbLWyv/Vj8PQ4FkbSF1k7q5qxs9rV
   NzM80BQJDdjayG1ZVmU3AJe1/thcF2ZXdRrIcl9PqjJVWkNduXUb4Nmox
   CXb32q21qyeHqIRXngRKBJ0mMZv1JsXs/D3RWt5Q6LZX2Ddg7SD+SxUC5
   LrhOWPBONkEDtt9YRhGCRzWk3mLL8f0Ii7bwMHChriimEeNsQryHvNwK2
   NEERQ+xpE7StZlgpcpQsgU4k9p9vxuPj8OoKg5smPt0GgEhaVET8nMubV
   Q==;
X-CSE-ConnectionGUID: Rj78gLJHTMibfG1KCazsxw==
X-CSE-MsgGUID: oID3WdADTqCHg2DJHDuggA==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="76694471"
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; 
   d="scan'208";a="76694471"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 00:35:15 -0800
X-CSE-ConnectionGUID: ooaZs8VmTPiCAaYnQwO6Ow==
X-CSE-MsgGUID: EX1H3JVLQZ+KBepzZHMhZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; 
   d="scan'208";a="196749947"
Received: from hpe-dl385gen10.igk.intel.com ([10.91.240.117])
  by orviesa003.jf.intel.com with ESMTP; 25 Nov 2025 00:35:13 -0800
From: Jakub Slepecki <jakub.slepecki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	michal.swiatkowski@linux.intel.com,
	jakub.slepecki@intel.com,
	aleksandr.loktionov@intel.com
Subject: [PATCH iwl-next v2 7/8] ice: add mac vlan to filter API
Date: Tue, 25 Nov 2025 09:34:55 +0100
Message-ID: <20251125083456.28822-8-jakub.slepecki@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251125083456.28822-1-jakub.slepecki@intel.com>
References: <20251125083456.28822-1-jakub.slepecki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Allow mac vlan filters to be managed by filters API in ice driver.
Together with mac-only filters they will be used to forward traffic
intended for loopback in VEB mode.

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jakub Slepecki <jakub.slepecki@intel.com>

---
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


