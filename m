Return-Path: <netdev+bounces-241442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F76C8403C
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 09:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 60DBD34E3C6
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 08:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1627C302CA2;
	Tue, 25 Nov 2025 08:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cjC4t1L0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E7D302CAC;
	Tue, 25 Nov 2025 08:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764059720; cv=none; b=Bx/gsKt7BaqvFCOKdB+lShnOK9wXT0OB/2pXyROI9RrgWUN3SdvFCKKelU/SvR7aQKXFb10nRuCW00i8C/8Zr0q2hjlXQ59Yv/0EO38x0W+zTG1bwL+WUf7H7qmrAhjYvYQ19ds2YWLGqgottQzeame1SP0N94qqbFZs69XJwks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764059720; c=relaxed/simple;
	bh=ZE5m1noLYEBVewBNpcWz7cAgC6/mDEw1KqgIxytGNFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E4vU3is8bIA8fAQhmLkUM5u+OiX8wS9bwkyanucnscOKg/X1HL1rjNUqMYdh1oz1v3qtIikmdjOZCWYP3d8KLt4nkROet19hJUsvhA+P+XviRDBy4ddp84gI6nhva8HZ9Ojx2pYx5xrEhU6retUqp4W453SjGsAH/N3LvYusD2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cjC4t1L0; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764059718; x=1795595718;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZE5m1noLYEBVewBNpcWz7cAgC6/mDEw1KqgIxytGNFQ=;
  b=cjC4t1L0lCMOZXCgUgeio+pT9HShJsOWBEJ4qQF8EQeXSD1pt0va4CQK
   UOLQKPG7Ao/1weCdP73wnZGxY7fcv6sNLYUhvhsoOM2ZK/ndddT7dI5KZ
   tfiTcgY/XQmdkUbs28peNwSS78n0Y6iKujzp/ZRC01qhJ7o3TDV0Ohwi2
   wgyNIUGBDBv0V5sJcznIRwDulQ7LQijNtEtVT0aeb4FiZltdfedRxxbM/
   r6U9mvob6FfAVXtkU0JtBqd77odvhT5+wBv9xl+7BjOeg6rdwXx5UB6Bj
   hK6OAv8K9ezSp7d/70dLb5k3Im/G4lgfgIGm7JtTCl21BexjqB1YfOTph
   g==;
X-CSE-ConnectionGUID: UMg8bbPRR3e4/bKmcG49JA==
X-CSE-MsgGUID: vHqaQpQBRmO14NxMUXgKFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="76694481"
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; 
   d="scan'208";a="76694481"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 00:35:17 -0800
X-CSE-ConnectionGUID: y4CLIAn9TCme8aCRpbQ5ag==
X-CSE-MsgGUID: +IILS/lkRuOz1EkuFmW/YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; 
   d="scan'208";a="196749952"
Received: from hpe-dl385gen10.igk.intel.com ([10.91.240.117])
  by orviesa003.jf.intel.com with ESMTP; 25 Nov 2025 00:35:16 -0800
From: Jakub Slepecki <jakub.slepecki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	michal.swiatkowski@linux.intel.com,
	jakub.slepecki@intel.com,
	aleksandr.loktionov@intel.com
Subject: [PATCH iwl-next v2 8/8] ice: in VEB, prevent "cross-vlan" traffic from hitting loopback
Date: Tue, 25 Nov 2025 09:34:56 +0100
Message-ID: <20251125083456.28822-9-jakub.slepecki@intel.com>
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

In Virtual Ethernet Bridge (VEB) mode, we use MAC filters to forward
traffic between two VFs.  We also use VLAN filters to prune potential
destinations, so that they don't cross VLANs.  In case a VF in VLAN X
sends a packet to a MAC address matching another VF but in VLAN Y, both
these filters will be hit.  Packet will be sent to loopback-only to VF
in VLAN Y, but VLAN filter will prune its VSI from the destination list
leaving the packet stranded in the internal switch and thus dropped.

Since there is no destination for the packet in the VLAN X, it should
instead be sent to the wire.

To fix this, we introduce MAC,VLAN filters in place of MAC-only filters
if VSI is part of any VLAN.  We consider VSI part of a VLAN if it has a
PVID set, or if it has a specific VLAN filter and does not have a VLAN
0 filter.

This approach does not attempt to fix interactions with upper devices.
If an upper vlan device requests a separate MAC address filter resulting
in a call to __dev_uc_sync, the VSI will start receiving all packets
destined for this MAC and not just within the VLAN.  I don't see a
straight-forward way to resolve this: information about MAC and VLAN
filters coming from kernel to driver is disconnected from one another
and from the device that requests it.  It could be worked around by,
for example, tracking all upper devices with netdev notifications and
adjusting the filters there.  The scope of this patch is hence limited
to VF traffic.

Following situations were considered for VLAN filters additions, removal,
or changes:

1. ice changes VF's vlan
2. VF is reset and rebuilt
3. vlan device attaches above a PF or a VF

And same for MAC filters:

4. PF's MAC is changed
5. PF changes MAC of a VF
6. VF's MAC is changed
7. ndo_set_rx_mode et al

When VLAN is assigned to a VF in (1), the affected VF is reset and
rebuild.  This makes (1) the same as (2).  We end up with two cases
where VLAN filters are added: (2) and (3).

To correctly handle (1-2), we move the VLAN filters initialization
before the MAC filters initialization, since MAC filters now depend
on VLAN filters presence.  These two handle PVID (or lack of thereof)
and because they are always associated with a reset, we don't need to
consider updating MAC and MAC,VLAN filters afterwards.

In (3), we will always have a lower device that is expected to receive
all packets for its MAC regardless of VLAN tag.  Because of the caveat
described above, we will do the same for each MAC address associated with
the interface regardless of VLANs.  The result is we only have MAC-only
filters in this case.

When we create MAC filters in (4-7) we now check for existing VLAN
filters and depending on PVID and VLAN 0 presence we decide to create,
respectively, a MAC and MAC,VLAN filter pair, or a MAC filter.  This is
done implicitly when requesting to remove old MAC and add new MAC,
so no change is required to this flow.

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jakub Slepecki <jakub.slepecki@intel.com>

---
No changes in v2.
---
 drivers/net/ethernet/intel/ice/ice_fltr.c   | 71 +++++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_fltr.h   |  6 +-
 drivers/net/ethernet/intel/ice/ice_main.c   |  8 +--
 drivers/net/ethernet/intel/ice/ice_switch.c |  2 +-
 drivers/net/ethernet/intel/ice/ice_switch.h |  2 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.c |  8 +--
 6 files changed, 83 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_fltr.c b/drivers/net/ethernet/intel/ice/ice_fltr.c
index 96a4e4b1b3fc..c0fc1bced167 100644
--- a/drivers/net/ethernet/intel/ice/ice_fltr.c
+++ b/drivers/net/ethernet/intel/ice/ice_fltr.c
@@ -3,6 +3,7 @@
 
 #include "ice.h"
 #include "ice_fltr.h"
+#include "ice_lib.h"
 
 /**
  * ice_fltr_free_list - free filter lists helper
@@ -221,10 +222,12 @@ void ice_fltr_remove_all(struct ice_vsi *vsi)
  * @list: list to add filter info to
  * @mac: MAC address to add
  * @action: filter action
+ * @external: force the filter to enable lan destination
  */
 int
 ice_fltr_add_mac_to_list(struct ice_vsi *vsi, struct list_head *list,
-			 const u8 *mac, enum ice_sw_fwd_act_type action)
+			 const u8 *mac, enum ice_sw_fwd_act_type action,
+			 bool external)
 {
 	struct ice_fltr_info info = { 0 };
 
@@ -233,6 +236,10 @@ ice_fltr_add_mac_to_list(struct ice_vsi *vsi, struct list_head *list,
 	info.lkup_type = ICE_SW_LKUP_MAC;
 	info.fltr_act = action;
 	info.vsi_handle = vsi->idx;
+	if (external) {
+		info.lb_en = ICE_FLTR_INFO_LB_LAN_FORCE_ENABLED;
+		info.lan_en = ICE_FLTR_INFO_LB_LAN_FORCE_ENABLED;
+	}
 
 	ether_addr_copy(info.l_data.mac.mac_addr, mac);
 
@@ -273,6 +280,62 @@ ice_fltr_add_mac_vlan_to_list(struct ice_vsi *vsi, struct list_head *list,
 					  list);
 }
 
+/**
+ * ice_fltr_add_macs_to_list - add MAC and MAC,VLAN filters info to an existing
+ * list
+ * @vsi: pointer to VSI struct
+ * @list: list to add filter info to
+ * @mac: MAC address to add
+ * @action: filter action
+ *
+ * Return:
+ * * 0 on success, or
+ * * %-ENOMEM if entry for filter could not be allocated.
+ */
+int
+ice_fltr_add_macs_to_list(struct ice_vsi *vsi, struct list_head *list,
+			  const u8 *mac, enum ice_sw_fwd_act_type action)
+{
+	if (is_multicast_ether_addr(mac)) {
+		/* There is no point in doing the same gymnastics as below
+		 * because multicast addresses are sent to both lan and lb then
+		 * pruned as necessary.
+		 */
+		return ice_fltr_add_mac_to_list(vsi, list, mac, action, false);
+	} else if (ice_vsi_has_pvid(vsi)) {
+		u16 pvid = ice_vsi_pvid(vsi);
+		int ret;
+
+		ret = ice_fltr_add_mac_to_list(vsi, list, mac, action, true);
+		if (ret)
+			return ret;
+
+		return ice_fltr_add_mac_vlan_to_list(vsi, list, mac, pvid,
+						     action);
+	} else if (vsi->num_vlan != ice_vsi_num_non_zero_vlans(vsi)) {
+		/* If VSI has VLAN 0 filters, then the interface is prepared to
+		 * receive untagged packets. As of now, we simply don't have
+		 * heuristics to decide which MAC is and is not part of which
+		 * VLAN so we put them all in the same bucket.
+		 */
+		return ice_fltr_add_mac_to_list(vsi, list, mac, action, false);
+	}
+
+	/* This branch is a.s. dead. There are three cases that may happen:
+	 *
+	 * - no vlans in sight; this is the VLAN 0 branch,
+	 * - VF is assigned PVID; this is ice_vsi_has_pvid branch,
+	 * - PF or VF is under vlan device; this is the VLAN 0 branch.
+	 *
+	 * This is where you would implement support for multiple VLANs but
+	 * without the VLAN 0. This could happen if vlan upper device is
+	 * assigned a MAC that is unique compared to lower ice device that is
+	 * forced to accept any VLAN. This would imply MAC-only filter for one
+	 * MAC address (PF) and MAC,VLAN+MAC filters for another (vlan).
+	 */
+	return ice_fltr_add_mac_to_list(vsi, list, mac, action, false);
+}
+
 /**
  * ice_fltr_add_vlan_to_list - add VLAN filter info to exsisting list
  * @vsi: pointer to VSI struct
@@ -343,7 +406,7 @@ ice_fltr_prepare_mac(struct ice_vsi *vsi, const u8 *mac,
 	LIST_HEAD(tmp_list);
 	int result;
 
-	if (ice_fltr_add_mac_to_list(vsi, &tmp_list, mac, action)) {
+	if (ice_fltr_add_macs_to_list(vsi, &tmp_list, mac, action)) {
 		ice_fltr_free_list(ice_pf_to_dev(vsi->back), &tmp_list);
 		return -ENOMEM;
 	}
@@ -371,8 +434,8 @@ ice_fltr_prepare_mac_and_broadcast(struct ice_vsi *vsi, const u8 *mac,
 	int result;
 
 	eth_broadcast_addr(broadcast);
-	if (ice_fltr_add_mac_to_list(vsi, &tmp_list, mac, action) ||
-	    ice_fltr_add_mac_to_list(vsi, &tmp_list, broadcast, action)) {
+	if (ice_fltr_add_macs_to_list(vsi, &tmp_list, mac, action) ||
+	    ice_fltr_add_macs_to_list(vsi, &tmp_list, broadcast, action)) {
 		ice_fltr_free_list(ice_pf_to_dev(vsi->back), &tmp_list);
 		return -ENOMEM;
 	}
diff --git a/drivers/net/ethernet/intel/ice/ice_fltr.h b/drivers/net/ethernet/intel/ice/ice_fltr.h
index fb9ffb39be50..ed3371b0a71f 100644
--- a/drivers/net/ethernet/intel/ice/ice_fltr.h
+++ b/drivers/net/ethernet/intel/ice/ice_fltr.h
@@ -21,12 +21,16 @@ ice_fltr_set_vsi_promisc(struct ice_hw *hw, u16 vsi_handle, u8 promisc_mask,
 			 u16 vid);
 int
 ice_fltr_add_mac_to_list(struct ice_vsi *vsi, struct list_head *list,
-			 const u8 *mac, enum ice_sw_fwd_act_type action);
+			 const u8 *mac, enum ice_sw_fwd_act_type action,
+			 bool external);
 int
 ice_fltr_add_mac_vlan_to_list(struct ice_vsi *vsi, struct list_head *list,
 			      const u8 *mac, u16 vlan_id,
 			      enum ice_sw_fwd_act_type action);
 int
+ice_fltr_add_macs_to_list(struct ice_vsi *vsi, struct list_head *list,
+			  const u8 *mac, enum ice_sw_fwd_act_type action);
+int
 ice_fltr_add_mac(struct ice_vsi *vsi, const u8 *mac,
 		 enum ice_sw_fwd_act_type action);
 int
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 921ed2b6c0aa..60d5e23d0d1a 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -212,8 +212,8 @@ static int ice_add_mac_to_sync_list(struct net_device *netdev, const u8 *addr)
 	struct ice_netdev_priv *np = netdev_priv(netdev);
 	struct ice_vsi *vsi = np->vsi;
 
-	if (ice_fltr_add_mac_to_list(vsi, &vsi->tmp_sync_list, addr,
-				     ICE_FWD_TO_VSI))
+	if (ice_fltr_add_macs_to_list(vsi, &vsi->tmp_sync_list, addr,
+				      ICE_FWD_TO_VSI))
 		return -EINVAL;
 
 	return 0;
@@ -242,8 +242,8 @@ static int ice_add_mac_to_unsync_list(struct net_device *netdev, const u8 *addr)
 	if (ether_addr_equal(addr, netdev->dev_addr))
 		return 0;
 
-	if (ice_fltr_add_mac_to_list(vsi, &vsi->tmp_unsync_list, addr,
-				     ICE_FWD_TO_VSI))
+	if (ice_fltr_add_macs_to_list(vsi, &vsi->tmp_unsync_list, addr,
+				      ICE_FWD_TO_VSI))
 		return -EINVAL;
 
 	return 0;
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index e0ff9a0882d5..c1418fd490cc 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -4016,7 +4016,7 @@ ice_cfg_dflt_vsi(struct ice_port_info *pi, u16 vsi_handle, bool set,
  * @fm_entry: filter entry to inspect
  * @vsi_handle: VSI handle to compare with filter info
  */
-static bool
+bool
 ice_vsi_uses_fltr(struct ice_fltr_mgmt_list_entry *fm_entry, u16 vsi_handle)
 {
 	return ((fm_entry->fltr_info.fltr_act == ICE_FWD_TO_VSI &&
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.h b/drivers/net/ethernet/intel/ice/ice_switch.h
index f1917e15b26c..a65c74c30b2e 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.h
+++ b/drivers/net/ethernet/intel/ice/ice_switch.h
@@ -341,6 +341,8 @@ ice_update_vsi(struct ice_hw *hw, u16 vsi_handle, struct ice_vsi_ctx *vsi_ctx,
 bool ice_is_vsi_valid(struct ice_hw *hw, u16 vsi_handle);
 struct ice_vsi_ctx *ice_get_vsi_ctx(struct ice_hw *hw, u16 vsi_handle);
 void ice_clear_all_vsi_ctx(struct ice_hw *hw);
+bool ice_vsi_uses_fltr(struct ice_fltr_mgmt_list_entry *fm_entry,
+		       u16 vsi_handle);
 /* Switch config */
 int ice_get_initial_sw_cfg(struct ice_hw *hw);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index de9e81ccee66..1031ce20bb60 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -501,14 +501,14 @@ static void ice_vf_rebuild_host_cfg(struct ice_vf *vf)
 
 	ice_vf_set_host_trust_cfg(vf);
 
-	if (ice_vf_rebuild_host_mac_cfg(vf))
-		dev_err(dev, "failed to rebuild default MAC configuration for VF %d\n",
-			vf->vf_id);
-
 	if (ice_vf_rebuild_host_vlan_cfg(vf, vsi))
 		dev_err(dev, "failed to rebuild VLAN configuration for VF %u\n",
 			vf->vf_id);
 
+	if (ice_vf_rebuild_host_mac_cfg(vf))
+		dev_err(dev, "failed to rebuild default MAC configuration for VF %d\n",
+			vf->vf_id);
+
 	if (ice_vf_rebuild_host_tx_rate_cfg(vf))
 		dev_err(dev, "failed to rebuild Tx rate limiting configuration for VF %u\n",
 			vf->vf_id);
-- 
2.43.0


