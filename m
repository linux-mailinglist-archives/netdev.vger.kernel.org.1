Return-Path: <netdev+bounces-262619-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CvCJGd4pWkNBgYAu9opvQ
	(envelope-from <netdev+bounces-262619-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 12:45:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D751D7CA4
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 12:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDAC130579F2
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 11:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0413624A5;
	Mon,  2 Mar 2026 11:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cF9lJ/IF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE8236308A
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 11:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772451646; cv=none; b=TCqrx5NQ8p/HpyxmMU1YQMFu8fsCxGeTEZBT5YsYhrjS2Llq5aW29emw+x2KFTT3tPezOYNaOU8tioiTtFHBeDi3FvMt/7D3D1nAQEOLwMTY+8u5EVSwPPtqhW/TztLgPtyFeg+MNlOXQE0oQp+HlXgHEit+fdm96bjnECwmoTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772451646; c=relaxed/simple;
	bh=mI1A18vSDW1o9zQUAm3erDWQSHIuxk4SnhkGnxBKLfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SrSfdzbAq+0DTxzYmIowaPeXXvElcdHgqbAijo4FJEzcm6r8P35i8/ixvfPvRAEv+aEgWzqubWSyMzRe/Use99+Kee4sjOslzoZ1VfveGZEpo7bJOCXMlCTTiggXBULu2eiRd9Wi1AzIvS1NnVz3CAEwyPBoD4oY30eZQbNOJQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cF9lJ/IF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772451643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Be86IjUFHq6eNQwodapk2HrGH0te+YM55AbW5FS4mBU=;
	b=cF9lJ/IF5+UTZtDJP9ZsO/txLlstGuL8ZKii3vPJ/fUqlXli+bn/NDUjtvL3i75OD8VXFf
	KEnTKo5ZUjFOe4uMXIMFEW4ih3fcIO9Omhi6yZhKJBdDC/owr8BBkpa9qMx9wRwJHlqhiZ
	Sfj4oWFh9gAnxLd1CAAOjdLNvhIK+LU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-245-WdU3gTpGOVuO9dmRlBj78g-1; Mon,
 02 Mar 2026 06:40:42 -0500
X-MC-Unique: WdU3gTpGOVuO9dmRlBj78g-1
X-Mimecast-MFC-AGG-ID: WdU3gTpGOVuO9dmRlBj78g_1772451640
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 79DEE18001C6;
	Mon,  2 Mar 2026 11:40:40 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.50])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9AB3A1956053;
	Mon,  2 Mar 2026 11:40:35 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: jacob.e.keller@intel.com,
	Petr Oros <poros@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC iwl-next 2/4] iavf: stop removing VLAN filters from PF on interface down
Date: Mon,  2 Mar 2026 12:40:23 +0100
Message-ID: <20260302114025.1017985-3-poros@redhat.com>
In-Reply-To: <20260302114025.1017985-1-poros@redhat.com>
References: <20260302114025.1017985-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262619-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F0D751D7CA4
X-Rspamd-Action: no action

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

Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/iavf/iavf.h        |  6 +--
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 39 ++-----------------
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 33 +++-------------
 3 files changed, 12 insertions(+), 66 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index 8e6db72828ae14..1ad00690622c8e 100644
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
index bceaf4b1b85d5f..f1ab68f5f4050b 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -823,27 +823,6 @@ static void iavf_del_vlan(struct iavf_adapter *adapter, struct iavf_vlan vlan)
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
@@ -1262,13 +1241,12 @@ static void iavf_up_complete(struct iavf_adapter *adapter)
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
@@ -1287,11 +1265,6 @@ static void iavf_clear_mac_vlan_filters(struct iavf_adapter *adapter)
 		}
 	}
 
-	/* disable all VLAN filters */
-	list_for_each_entry_safe(vlf, vlftmp, &adapter->vlan_filter_list,
-				 list)
-		vlf->state = IAVF_VLAN_DISABLE;
-
 	spin_unlock_bh(&adapter->mac_vlan_list_lock);
 }
 
@@ -1387,7 +1360,7 @@ void iavf_down(struct iavf_adapter *adapter)
 	iavf_napi_disable_all(adapter);
 	iavf_irq_disable(adapter);
 
-	iavf_clear_mac_vlan_filters(adapter);
+	iavf_clear_mac_filters(adapter);
 	iavf_clear_cloud_filters(adapter);
 	iavf_clear_fdir_filters(adapter);
 	iavf_clear_adv_rss_conf(adapter);
@@ -1404,8 +1377,6 @@ void iavf_down(struct iavf_adapter *adapter)
 		 */
 		if (!list_empty(&adapter->mac_filter_list))
 			adapter->aq_required |= IAVF_FLAG_AQ_DEL_MAC_FILTER;
-		if (!list_empty(&adapter->vlan_filter_list))
-			adapter->aq_required |= IAVF_FLAG_AQ_DEL_VLAN_FILTER;
 		if (!list_empty(&adapter->cloud_filter_list))
 			adapter->aq_required |= IAVF_FLAG_AQ_DEL_CLOUD_FILTER;
 		if (!list_empty(&adapter->fdir_list_head))
@@ -4487,8 +4458,6 @@ static int iavf_open(struct net_device *netdev)
 	iavf_add_filter(adapter, adapter->hw.mac.addr);
 	spin_unlock_bh(&adapter->mac_vlan_list_lock);
 
-	/* Restore filters that were removed with IFF_DOWN */
-	iavf_restore_filters(adapter);
 	iavf_restore_fdir_filters(adapter);
 
 	iavf_configure(adapter);
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 5114934fe81fa6..d62c0d6394149e 100644
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


