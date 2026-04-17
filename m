Return-Path: <netdev+bounces-279337-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJ40BwNE4mlh4AAAu9opvQ
	(envelope-from <netdev+bounces-279337-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 16:30:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B2E41C101
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 16:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0EADE301CA93
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 14:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5665C3B38AB;
	Fri, 17 Apr 2026 14:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EEzgTw2x"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68213B2FFC
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 14:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776436214; cv=none; b=NdjEcV+qwlJTqcp/KFBMJgyJPVTE6Ker1m0oLJx7n+M3YzSeoXCsgnnUTRZyoxEWsa8dMp+LUFRD2fb0U+fg0gw7qR44FccmlYj85mDl3olmTPGnNtqlAnBuT+iXRunTJ8+tG4pv4VQnsbELg+RtGsCVZrCKTzY6Fsbu+yit3c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776436214; c=relaxed/simple;
	bh=OeXZTygGdeW/yXGB92JtqKAHSmJIq/9AaxG3VZZtM5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jVKaE1qauEs1pgxZ6BTogRxPY1Gr1GW5fWY8GMvJ73UYzmpOm9s2XRylh/XP9KU61z524r/c0fY2oUHZH02xk8BMFHHvrBLdKVs/0stWHGwWErLmtms3kzqs0vNcu1Q0yr/42zHKBaX4lFavQyn/Gcq/OcOTx4wFVejM7ZBJfBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EEzgTw2x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776436211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9yVRVn/zRQuQzeFy5xr25n7quPTdCY6cNbOdP3O2WBA=;
	b=EEzgTw2xcyuAvdZnwLCQeN51+xFiS1EOex5Baa3Hidgz1X8FuxQiWZRMR/rvYsVq29JMqJ
	PHzh0REpSSAnpH3683dZ9lWF31k/tF8mwh2wMqt4dCIDk/UTbxNm9UnUESwX0XW+zyWUua
	nV9gMa3EVjuFIVV2fTonrS1tSHRh3Sw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-117-1qz2CUZyOTmXw6lVQ5aiAA-1; Fri,
 17 Apr 2026 10:30:05 -0400
X-MC-Unique: 1qz2CUZyOTmXw6lVQ5aiAA-1
X-Mimecast-MFC-AGG-ID: 1qz2CUZyOTmXw6lVQ5aiAA_1776436202
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 106A91956094;
	Fri, 17 Apr 2026 14:30:02 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.76])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 70271180047F;
	Fri, 17 Apr 2026 14:29:57 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Mitch Williams <mitch.a.williams@intel.com>,
	Aaron Brown <aaron.f.brown@intel.com>,
	Przemyslaw Patynowski <przemyslawx.patynowski@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com
Subject: [PATCH iwl-net v2 2/4] iavf: stop removing VLAN filters from PF on interface down
Date: Fri, 17 Apr 2026 16:29:43 +0200
Message-ID: <7e03c6b17b67453f7c0c3eefce034a8fb9c40b63.1776426683.git.poros@redhat.com>
In-Reply-To: <cover.1776426683.git.poros@redhat.com>
References: <cover.1776426683.git.poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279337-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 15B2E41C101
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
---
 drivers/net/ethernet/intel/iavf/iavf.h        |  6 +--
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 39 ++-----------------
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 33 +++-------------
 3 files changed, 12 insertions(+), 66 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index 47a862ca5e2c3f..5765715914d6b2 100644
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
index dad001abc9086b..12e102506011a6 100644
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
@@ -1240,13 +1219,12 @@ static void iavf_up_complete(struct iavf_adapter *adapter)
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
@@ -1265,11 +1243,6 @@ static void iavf_clear_mac_vlan_filters(struct iavf_adapter *adapter)
 		}
 	}
 
-	/* disable all VLAN filters */
-	list_for_each_entry_safe(vlf, vlftmp, &adapter->vlan_filter_list,
-				 list)
-		vlf->state = IAVF_VLAN_DISABLE;
-
 	spin_unlock_bh(&adapter->mac_vlan_list_lock);
 }
 
@@ -1365,7 +1338,7 @@ void iavf_down(struct iavf_adapter *adapter)
 	iavf_napi_disable_all(adapter);
 	iavf_irq_disable(adapter);
 
-	iavf_clear_mac_vlan_filters(adapter);
+	iavf_clear_mac_filters(adapter);
 	iavf_clear_cloud_filters(adapter);
 	iavf_clear_fdir_filters(adapter);
 	iavf_clear_adv_rss_conf(adapter);
@@ -1382,8 +1355,6 @@ void iavf_down(struct iavf_adapter *adapter)
 		 */
 		if (!list_empty(&adapter->mac_filter_list))
 			adapter->aq_required |= IAVF_FLAG_AQ_DEL_MAC_FILTER;
-		if (!list_empty(&adapter->vlan_filter_list))
-			adapter->aq_required |= IAVF_FLAG_AQ_DEL_VLAN_FILTER;
 		if (!list_empty(&adapter->cloud_filter_list))
 			adapter->aq_required |= IAVF_FLAG_AQ_DEL_CLOUD_FILTER;
 		if (!list_empty(&adapter->fdir_list_head))
@@ -4488,8 +4459,6 @@ static int iavf_open(struct net_device *netdev)
 	iavf_add_filter(adapter, adapter->hw.mac.addr);
 	spin_unlock_bh(&adapter->mac_vlan_list_lock);
 
-	/* Restore filters that were removed with IFF_DOWN */
-	iavf_restore_filters(adapter);
 	iavf_restore_fdir_filters(adapter);
 
 	iavf_configure(adapter);
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 6b06ae872a0cdf..4f197d908124e6 100644
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
2.52.0


