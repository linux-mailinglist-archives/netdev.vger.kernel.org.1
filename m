Return-Path: <netdev+bounces-281633-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iATfOWlE8Gn2QwEAu9opvQ
	(envelope-from <netdev+bounces-281633-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 07:23:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 917F747D892
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 07:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE65D3037D4A
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 05:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E12B32FA18;
	Tue, 28 Apr 2026 05:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cvS6l6xx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A052F39C2
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 05:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777353801; cv=none; b=gTFyeKfziSeD8N0LjW+6fR9AAwVt4HUDRtwEju6bUwfD72UDwOzPslterQllCAdKbrKd0Xzr0A0iG8pYWM2nhNKYQRdjlTd7j8X8y04RiopLtbQufZnr73b1zUxHUNkRipDHaznoJsltWgk0HL77LneU8iL4k5dn/3U5UmEe1hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777353801; c=relaxed/simple;
	bh=yiUeedwbWPT9KMT6+u9TwYTw2GvN3AqkABz9xg5LpUo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MH9GunWac+S599dfvj2y2nYtdNbQfxi4G0QCNd+XzHylwz5aaV5cN7Yej9XsbYG3JUoXD6ooOGzdF2SZkuB6fPyAzfZvMfY6MmFxjTfCS/WP1rncsQMJ2y+dGi0sQZFzo8rh7ljUtH/9m1lucrPQGbw3z9ni+Ni3hINJIe673wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cvS6l6xx; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777353800; x=1808889800;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=yiUeedwbWPT9KMT6+u9TwYTw2GvN3AqkABz9xg5LpUo=;
  b=cvS6l6xxtkt1iCoFIgZ1cSoSZz9oExmgr9DgiawB9SY+0Oq+z0g1mf2w
   ybppxFXtNf/k4wf263NeytI4EJzqJh0FGMmltzXppiPmc5DUOzLlGwAqj
   c2W+98XJ5uoYi0PfUj5M0qIR86FblBFH38AEXXmq8qRYv3/L6K0cNNvha
   g1Elo+xuRhTcqltmmBHr504nfp8Dfgv3K13GdE25rAvkdwiCTnhK7Wu7h
   Cd4A++IWwMNidFQLfxQ2wAN1wGN3oZOO2+KkhYK8XIYJ1gK5ekkyIpDJh
   utF0S23ZjFu/yXsx4NPB3EONN3F5SC0U7inXvedXyRIZDqGW+bcE/2p8y
   A==;
X-CSE-ConnectionGUID: fM1UYmlfQXe7EeR3yndubQ==
X-CSE-MsgGUID: Y/MBKNzDTgatIdEJqezr6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="100910517"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="100910517"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 22:23:15 -0700
X-CSE-ConnectionGUID: Qn+qAUZrQiScrnNKTXbPLw==
X-CSE-MsgGUID: 6xTFflUiTnGFOKrj2A5rfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="237800197"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 22:23:15 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 27 Apr 2026 22:22:14 -0700
Subject: [PATCH net 02/11] iavf: stop removing VLAN filters from PF on
 interface down
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-jk-iwl-net-petr-oros-fixes-v1-2-cdcb48303fd8@intel.com>
References: <20260427-jk-iwl-net-petr-oros-fixes-v1-0-cdcb48303fd8@intel.com>
In-Reply-To: <20260427-jk-iwl-net-petr-oros-fixes-v1-0-cdcb48303fd8@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Petr Oros <poros@redhat.com>, Rafal Romanowski <rafal.romanowski@intel.com>
X-Mailer: b4 0.16-dev-ea14f
X-Developer-Signature: v=1; a=openpgp-sha256; l=8786;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=QSXjfw3z863f15ttk9xHd5k+N6b87Lm2BxFm6+nTQ7Y=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhswPLg7hDa9FudkbBde+nXf18x2FWXsOr21rvFxQq/2nM
 K262KGuo5SFQYyLQVZMkUXBIWTldeMJYVpvnOVg5rAygQxh4OIUgImITGBkWJv5KCurcufnnwWv
 v8+ZIHf/M4+azqssmesb9Kb9e7BtJysjw+XGuo+Jv8JyF+30SNj0zsHU6GzJ8zKT6w5x84yOGrw
 15QQA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Rspamd-Queue-Id: 917F747D892
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281633-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: Petr Oros <poros@redhat.com>

When a VF goes down, the driver currently sends DEL_VLAN to the PF for
every VLAN filter (ACTIVE -> DISABLE -> send DEL -> INACTIVE), then
re-adds them all on UP (INACTIVE -> ADD -> send ADD -> ADDING ->
ACTIVE). This round-trip is unnecessary because:

 1. The PF disables the VF's queues via VIRTCHNL_OP_DISABLE_QUEUES,
    which already prevents all RX/TX traffic regardless of VLAN filter
    state.

 2. The VLAN filters remaining in PF HW while the VF is down is
    harmless - packets matching those filters have nowhere to go with
    queues disabled.

 3. The DEL+ADD cycle during down/up creates race windows where the
    VLAN filter list is incomplete. With spoofcheck enabled, the PF
    enables TX VLAN filtering on the first non-zero VLAN add, blocking
    traffic for any VLANs not yet re-added.

Remove the entire DISABLE/INACTIVE state machinery:
 - Remove IAVF_VLAN_DISABLE and IAVF_VLAN_INACTIVE enum values
 - Remove iavf_restore_filters() and its call from iavf_open()
 - Remove VLAN filter handling from iavf_clear_mac_vlan_filters(),
   rename it to iavf_clear_mac_filters()
 - Remove DEL_VLAN_FILTER scheduling from iavf_down()
 - Remove all DISABLE/INACTIVE handling from iavf_del_vlans()

VLAN filters now stay ACTIVE across down/up cycles. Only explicit
user removal (ndo_vlan_rx_kill_vid) or PF/VF reset triggers VLAN
filter deletion/re-addition.

Fixes: ed1f5b58ea01 ("i40evf: remove VLAN filters on close")
Signed-off-by: Petr Oros <poros@redhat.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf.h          |  6 ++--
 drivers/net/ethernet/intel/iavf/iavf_main.c     | 39 +++----------------------
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 33 ++++-----------------
 3 files changed, 12 insertions(+), 66 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index 47a862ca5e2c..5765715914d6 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -159,10 +159,8 @@ enum iavf_vlan_state_t {
 	IAVF_VLAN_INVALID,
 	IAVF_VLAN_ADD,		/* filter needs to be added */
 	IAVF_VLAN_ADDING,	/* ADD sent to PF, waiting for response */
-	IAVF_VLAN_ACTIVE,	/* filter is accepted by PF */
-	IAVF_VLAN_DISABLE,	/* filter needs to be deleted by PF, then marked INACTIVE */
-	IAVF_VLAN_INACTIVE,	/* filter is inactive, we are in IFF_DOWN */
-	IAVF_VLAN_REMOVE,	/* filter needs to be removed from list */
+	IAVF_VLAN_ACTIVE,	/* PF confirmed, filter is in HW */
+	IAVF_VLAN_REMOVE,	/* filter queued for DEL from PF */
 };
 
 struct iavf_vlan_filter {
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 3c1465cf0515..ca29038c0016 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -801,27 +801,6 @@ static void iavf_del_vlan(struct iavf_adapter *adapter, struct iavf_vlan vlan)
 	spin_unlock_bh(&adapter->mac_vlan_list_lock);
 }
 
-/**
- * iavf_restore_filters
- * @adapter: board private structure
- *
- * Restore existing non MAC filters when VF netdev comes back up
- **/
-static void iavf_restore_filters(struct iavf_adapter *adapter)
-{
-	struct iavf_vlan_filter *f;
-
-	/* re-add all VLAN filters */
-	spin_lock_bh(&adapter->mac_vlan_list_lock);
-
-	list_for_each_entry(f, &adapter->vlan_filter_list, list) {
-		if (f->state == IAVF_VLAN_INACTIVE)
-			f->state = IAVF_VLAN_ADD;
-	}
-
-	spin_unlock_bh(&adapter->mac_vlan_list_lock);
-	adapter->aq_required |= IAVF_FLAG_AQ_ADD_VLAN_FILTER;
-}
 
 /**
  * iavf_get_num_vlans_added - get number of VLANs added
@@ -1246,13 +1225,12 @@ static void iavf_up_complete(struct iavf_adapter *adapter)
 }
 
 /**
- * iavf_clear_mac_vlan_filters - Remove mac and vlan filters not sent to PF
- * yet and mark other to be removed.
+ * iavf_clear_mac_filters - Remove MAC filters not sent to PF yet and mark
+ * others to be removed.
  * @adapter: board private structure
  **/
-static void iavf_clear_mac_vlan_filters(struct iavf_adapter *adapter)
+static void iavf_clear_mac_filters(struct iavf_adapter *adapter)
 {
-	struct iavf_vlan_filter *vlf, *vlftmp;
 	struct iavf_mac_filter *f, *ftmp;
 
 	spin_lock_bh(&adapter->mac_vlan_list_lock);
@@ -1271,11 +1249,6 @@ static void iavf_clear_mac_vlan_filters(struct iavf_adapter *adapter)
 		}
 	}
 
-	/* disable all VLAN filters */
-	list_for_each_entry_safe(vlf, vlftmp, &adapter->vlan_filter_list,
-				 list)
-		vlf->state = IAVF_VLAN_DISABLE;
-
 	spin_unlock_bh(&adapter->mac_vlan_list_lock);
 }
 
@@ -1371,7 +1344,7 @@ void iavf_down(struct iavf_adapter *adapter)
 	iavf_napi_disable_all(adapter);
 	iavf_irq_disable(adapter);
 
-	iavf_clear_mac_vlan_filters(adapter);
+	iavf_clear_mac_filters(adapter);
 	iavf_clear_cloud_filters(adapter);
 	iavf_clear_fdir_filters(adapter);
 	iavf_clear_adv_rss_conf(adapter);
@@ -1388,8 +1361,6 @@ void iavf_down(struct iavf_adapter *adapter)
 		 */
 		if (!list_empty(&adapter->mac_filter_list))
 			adapter->aq_required |= IAVF_FLAG_AQ_DEL_MAC_FILTER;
-		if (!list_empty(&adapter->vlan_filter_list))
-			adapter->aq_required |= IAVF_FLAG_AQ_DEL_VLAN_FILTER;
 		if (!list_empty(&adapter->cloud_filter_list))
 			adapter->aq_required |= IAVF_FLAG_AQ_DEL_CLOUD_FILTER;
 		if (!list_empty(&adapter->fdir_list_head))
@@ -4494,8 +4465,6 @@ static int iavf_open(struct net_device *netdev)
 	iavf_add_filter(adapter, adapter->hw.mac.addr);
 	spin_unlock_bh(&adapter->mac_vlan_list_lock);
 
-	/* Restore filters that were removed with IFF_DOWN */
-	iavf_restore_filters(adapter);
 	iavf_restore_fdir_filters(adapter);
 
 	iavf_configure(adapter);
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 6b06ae872a0c..4f197d908124 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -911,22 +911,12 @@ void iavf_del_vlans(struct iavf_adapter *adapter)
 	spin_lock_bh(&adapter->mac_vlan_list_lock);
 
 	list_for_each_entry_safe(f, ftmp, &adapter->vlan_filter_list, list) {
-		/* since VLAN capabilities are not allowed, we dont want to send
-		 * a VLAN delete request because it will most likely fail and
-		 * create unnecessary errors/noise, so just free the VLAN
-		 * filters marked for removal to enable bailing out before
-		 * sending a virtchnl message
-		 */
 		if (f->state == IAVF_VLAN_REMOVE &&
 		    !VLAN_FILTERING_ALLOWED(adapter)) {
 			list_del(&f->list);
 			kfree(f);
 			adapter->num_vlan_filters--;
-		} else if (f->state == IAVF_VLAN_DISABLE &&
-		    !VLAN_FILTERING_ALLOWED(adapter)) {
-			f->state = IAVF_VLAN_INACTIVE;
-		} else if (f->state == IAVF_VLAN_REMOVE ||
-			   f->state == IAVF_VLAN_DISABLE) {
+		} else if (f->state == IAVF_VLAN_REMOVE) {
 			count++;
 		}
 	}
@@ -959,13 +949,7 @@ void iavf_del_vlans(struct iavf_adapter *adapter)
 		vvfl->vsi_id = adapter->vsi_res->vsi_id;
 		vvfl->num_elements = count;
 		list_for_each_entry_safe(f, ftmp, &adapter->vlan_filter_list, list) {
-			if (f->state == IAVF_VLAN_DISABLE) {
-				vvfl->vlan_id[i] = f->vlan.vid;
-				f->state = IAVF_VLAN_INACTIVE;
-				i++;
-				if (i == count)
-					break;
-			} else if (f->state == IAVF_VLAN_REMOVE) {
+			if (f->state == IAVF_VLAN_REMOVE) {
 				vvfl->vlan_id[i] = f->vlan.vid;
 				list_del(&f->list);
 				kfree(f);
@@ -1007,8 +991,7 @@ void iavf_del_vlans(struct iavf_adapter *adapter)
 		vvfl_v2->vport_id = adapter->vsi_res->vsi_id;
 		vvfl_v2->num_elements = count;
 		list_for_each_entry_safe(f, ftmp, &adapter->vlan_filter_list, list) {
-			if (f->state == IAVF_VLAN_DISABLE ||
-			    f->state == IAVF_VLAN_REMOVE) {
+			if (f->state == IAVF_VLAN_REMOVE) {
 				struct virtchnl_vlan_supported_caps *filtering_support =
 					&adapter->vlan_v2_caps.filtering.filtering_support;
 				struct virtchnl_vlan *vlan;
@@ -1022,13 +1005,9 @@ void iavf_del_vlans(struct iavf_adapter *adapter)
 				vlan->tci = f->vlan.vid;
 				vlan->tpid = f->vlan.tpid;
 
-				if (f->state == IAVF_VLAN_DISABLE) {
-					f->state = IAVF_VLAN_INACTIVE;
-				} else {
-					list_del(&f->list);
-					kfree(f);
-					adapter->num_vlan_filters--;
-				}
+				list_del(&f->list);
+				kfree(f);
+				adapter->num_vlan_filters--;
 				i++;
 				if (i == count)
 					break;

-- 
2.54.0.rc2.531.gaf818d63126a


