Return-Path: <netdev+bounces-262621-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLYmAKB3pWkNBgYAu9opvQ
	(envelope-from <netdev+bounces-262621-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 12:42:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 830001D7AB3
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 12:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C916304AA34
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 11:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA2835DA4E;
	Mon,  2 Mar 2026 11:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hw8pe1ly"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4883630B6
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 11:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772451651; cv=none; b=iyX1fTtYh8IIw462TpYqV6XQDKJ4O3eJM401Jbxvbk2CCuV9gGHqcahDUByc8yl3C0ZmJVVBZ9f/u5qnvQ12r4CrgP7fcf6y6zIPlrGiZiXsBMhm8E2NMvb94at87oof76ztFHJWqoQfrZEqRb3GZlSjgDZtkE3+TjqZ6vA0goY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772451651; c=relaxed/simple;
	bh=K+JT0hUFt2U3gKTuWEWnh0uuCjs1QJ1qcLNTp8jLe5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mEFP0BO1T9sOiQtWoP5WxFizL/tiZK6xgd9a76AR8zmC2RNSUCBAESKtdUUztPF4K43J9r1oa6Uqe6G6HbriKmbwZ8vrlXhMXsC1CI9EzWh/Nd8fM7PcIeAj2QM1cbXTNeeZ0Ca9lhF+rYgVL5gAIL8Bse34oBrlQIK5KIKqRj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hw8pe1ly; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772451649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Bb+I9g2d7bQxdwADL6SA7iVdzmM7hNyUv0fUe9nErk=;
	b=Hw8pe1lyeq0QDfN+RnT3jLeAApVRrRXk2Tr897aoH8P50m1BlCiClbYkWMFY31377fzoog
	D+pn3lLAOlnmqjrk9mhuzcp3Al9w5BN21i8q/pjKpjuhKwO9KHWl9y0yrSYYUJ9JJCyFT3
	xl1auYzau9aTGuvwaOU8tG+6OWCS/bk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-92-87jLJdzeMBKVrMfpdPhnSA-1; Mon,
 02 Mar 2026 06:40:45 -0500
X-MC-Unique: 87jLJdzeMBKVrMfpdPhnSA-1
X-Mimecast-MFC-AGG-ID: 87jLJdzeMBKVrMfpdPhnSA_1772451644
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0CDDB19560AD;
	Mon,  2 Mar 2026 11:40:44 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.50])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DD3D11956053;
	Mon,  2 Mar 2026 11:40:40 +0000 (UTC)
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
Subject: [PATCH RFC iwl-next 3/4] iavf: wait for PF confirmation before removing VLAN filters
Date: Mon,  2 Mar 2026 12:40:24 +0100
Message-ID: <20260302114025.1017985-4-poros@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262621-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 830001D7AB3
X-Rspamd-Action: no action

The VLAN filter DELETE path was asymmetric with the ADD path: ADD
waits for PF confirmation (ADD -> ADDING -> ACTIVE), but DELETE
immediately frees the filter struct after sending the DEL message
without waiting for the PF response.

This is problematic because:
 - If the PF rejects the DEL, the filter remains in HW but the driver
   has already freed the tracking structure, losing sync.
 - Race conditions between DEL pending and other operations
   (add, reset) cannot be properly resolved if the filter struct
   is already gone.

Add IAVF_VLAN_REMOVING state to make the DELETE path symmetric:

  REMOVE -> REMOVING (send DEL) -> PF confirms -> kfree
                                -> PF rejects  -> ACTIVE

In iavf_del_vlans(), transition filters from REMOVE to REMOVING
instead of immediately freeing them. The new DEL completion handler
in iavf_virtchnl_completion() frees filters on success or reverts
them to ACTIVE on error.

Update iavf_add_vlan() to handle the REMOVING state: if a DEL is
pending and the user re-adds the same VLAN, queue it for ADD so
it gets re-programmed after the PF processes the DEL.

The !VLAN_FILTERING_ALLOWED early-exit path still frees filters
directly since no PF message is sent in that case.

Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/iavf/iavf.h        |  1 +
 drivers/net/ethernet/intel/iavf/iavf_main.c   |  9 +++--
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 37 +++++++++++++------
 3 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index 1ad00690622c8e..f9ad814d18b1da 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -161,6 +161,7 @@ enum iavf_vlan_state_t {
 	IAVF_VLAN_ADDING,	/* ADD sent to PF, waiting for response */
 	IAVF_VLAN_ACTIVE,	/* PF confirmed, filter is in HW */
 	IAVF_VLAN_REMOVE,	/* filter queued for DEL from PF */
+	IAVF_VLAN_REMOVING,	/* DEL sent to PF, waiting for response */
 };
 
 struct iavf_vlan_filter {
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index f1ab68f5f4050b..212a23ead20c57 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -782,10 +782,13 @@ iavf_vlan_filter *iavf_add_vlan(struct iavf_adapter *adapter,
 		adapter->num_vlan_filters++;
 		iavf_schedule_aq_request(adapter, IAVF_FLAG_AQ_ADD_VLAN_FILTER);
 	} else if (f->state == IAVF_VLAN_REMOVE) {
-		/* IAVF_VLAN_REMOVE means that VLAN wasn't yet removed.
-		 * We can safely only change the state here.
-		 */
+		/* DEL not yet sent to PF, cancel it */
 		f->state = IAVF_VLAN_ACTIVE;
+	} else if (f->state == IAVF_VLAN_REMOVING) {
+		/* DEL already sent to PF, re-add after completion */
+		f->state = IAVF_VLAN_ADD;
+		iavf_schedule_aq_request(adapter,
+					 IAVF_FLAG_AQ_ADD_VLAN_FILTER);
 	}
 
 clearout:
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index d62c0d6394149e..9f2b64bb4ed9e7 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -948,12 +948,10 @@ void iavf_del_vlans(struct iavf_adapter *adapter)
 
 		vvfl->vsi_id = adapter->vsi_res->vsi_id;
 		vvfl->num_elements = count;
-		list_for_each_entry_safe(f, ftmp, &adapter->vlan_filter_list, list) {
+		list_for_each_entry(f, &adapter->vlan_filter_list, list) {
 			if (f->state == IAVF_VLAN_REMOVE) {
 				vvfl->vlan_id[i] = f->vlan.vid;
-				list_del(&f->list);
-				kfree(f);
-				adapter->num_vlan_filters--;
+				f->state = IAVF_VLAN_REMOVING;
 				i++;
 				if (i == count)
 					break;
@@ -990,7 +988,7 @@ void iavf_del_vlans(struct iavf_adapter *adapter)
 
 		vvfl_v2->vport_id = adapter->vsi_res->vsi_id;
 		vvfl_v2->num_elements = count;
-		list_for_each_entry_safe(f, ftmp, &adapter->vlan_filter_list, list) {
+		list_for_each_entry(f, &adapter->vlan_filter_list, list) {
 			if (f->state == IAVF_VLAN_REMOVE) {
 				struct virtchnl_vlan_supported_caps *filtering_support =
 					&adapter->vlan_v2_caps.filtering.filtering_support;
@@ -1005,9 +1003,7 @@ void iavf_del_vlans(struct iavf_adapter *adapter)
 				vlan->tci = f->vlan.vid;
 				vlan->tpid = f->vlan.tpid;
 
-				list_del(&f->list);
-				kfree(f);
-				adapter->num_vlan_filters--;
+				f->state = IAVF_VLAN_REMOVING;
 				i++;
 				if (i == count)
 					break;
@@ -2370,10 +2366,6 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 			ether_addr_copy(adapter->hw.mac.addr, netdev->dev_addr);
 			wake_up(&adapter->vc_waitqueue);
 			break;
-		case VIRTCHNL_OP_DEL_VLAN:
-			dev_err(&adapter->pdev->dev, "Failed to delete VLAN filter, error %s\n",
-				iavf_stat_str(&adapter->hw, v_retval));
-			break;
 		case VIRTCHNL_OP_DEL_ETH_ADDR:
 			dev_err(&adapter->pdev->dev, "Failed to delete MAC filter, error %s\n",
 				iavf_stat_str(&adapter->hw, v_retval));
@@ -2896,6 +2888,27 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 		spin_unlock_bh(&adapter->mac_vlan_list_lock);
 		}
 		break;
+	case VIRTCHNL_OP_DEL_VLAN:
+	case VIRTCHNL_OP_DEL_VLAN_V2: {
+		struct iavf_vlan_filter *f, *ftmp;
+
+		spin_lock_bh(&adapter->mac_vlan_list_lock);
+		list_for_each_entry_safe(f, ftmp, &adapter->vlan_filter_list,
+					 list) {
+			if (f->state == IAVF_VLAN_REMOVING) {
+				if (v_retval) {
+					/* PF rejected DEL, filter is still in HW */
+					f->state = IAVF_VLAN_ACTIVE;
+				} else {
+					list_del(&f->list);
+					kfree(f);
+					adapter->num_vlan_filters--;
+				}
+			}
+		}
+		spin_unlock_bh(&adapter->mac_vlan_list_lock);
+		}
+		break;
 	case VIRTCHNL_OP_ENABLE_VLAN_STRIPPING:
 		/* PF enabled vlan strip on this VF.
 		 * Update netdev->features if needed to be in sync with ethtool.
-- 
2.52.0


