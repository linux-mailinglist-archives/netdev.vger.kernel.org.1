Return-Path: <netdev+bounces-268109-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDg3CtHet2mcWAEAu9opvQ
	(envelope-from <netdev+bounces-268109-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 11:43:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28ACD2981C9
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 11:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5BD343013716
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 10:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBD338F62A;
	Mon, 16 Mar 2026 10:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YSX+dt6x"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD82390200
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 10:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773657758; cv=none; b=b1/JU4wUq6J1/EG25jM8knXNfMwMHnyPrmiciehAXFUfiYuutHoZPFZgUm/rqvLKaYkFhM5+/tMaeeOpB1+ejncYlVEj63qncxdUrqxT10vprvhKJwQoQasdTTeUwEycWKdB+Ri6UGYzpwObX8Xb5cNWAgTlMYQWb1JG9GH3NO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773657758; c=relaxed/simple;
	bh=Z23iiIUboMOopgrGLq2MzlaGaSWgZb9psd3YQCeMYhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tB4/fw5HPfi0YZ34IIgcOvSdqk/i4d73kvaPis2zHW/lXIly5sayD3YM59q9RBKHwtqw0q2ae82orUHCzBZNX7C2ulDsQZNb8YNolM7U3NlljGjUgQ91CPrPpFiwYELRKRqOio8PYgTVRg+HM0GXb7Z/6scUrg/lLTyC2cunflY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YSX+dt6x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773657755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vG/uH1+MoWziuiYVHD5GqsUIbFKI25Uy5mOYHhl24nM=;
	b=YSX+dt6xpYeFT90b2ptUI0fsHQMWk7MMnNF42RUxKRKZAFmnfJhnemb0gNmuajpvQOLkhZ
	m11NjtKOfak9F+f6xuFYIpiP0z/+iRpwrhjHgGb9C7stpGA93qR87mbfEOZLGIGCKL0AjL
	C3ZcCMY+s1VLkUCRMKe5XVc4O0TsrJo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-6K6OrgyVOT-wHzHeRSjqZA-1; Mon,
 16 Mar 2026 06:42:31 -0400
X-MC-Unique: 6K6OrgyVOT-wHzHeRSjqZA-1
X-Mimecast-MFC-AGG-ID: 6K6OrgyVOT-wHzHeRSjqZA_1773657748
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 95B9D1953963;
	Mon, 16 Mar 2026 10:42:27 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.45.224.235])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D49A0180035F;
	Mon, 16 Mar 2026 10:42:23 +0000 (UTC)
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
Subject: [PATCH iwl-next 3/4] iavf: wait for PF confirmation before removing VLAN filters
Date: Mon, 16 Mar 2026 11:42:08 +0100
Message-ID: <20260316104209.1285962-4-poros@redhat.com>
In-Reply-To: <20260316104209.1285962-1-poros@redhat.com>
References: <20260316104209.1285962-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268109-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 28ACD2981C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index b38ce496a95c75..89e5aae20d5573 100644
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
index d62c0d6394149e..d0b7b810679399 100644
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
+					/* PF rejected DEL, keep filter */
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


