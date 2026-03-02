Return-Path: <netdev+bounces-262622-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KN8+KLN3pWkNBgYAu9opvQ
	(envelope-from <netdev+bounces-262622-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 12:42:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 263C31D7AC8
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 12:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 22DCB304FA51
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 11:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA4B364939;
	Mon,  2 Mar 2026 11:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UserYUUO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7B436492E
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 11:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772451654; cv=none; b=ddZDDijOgDOVCtStdRghJ7oTdgUc710pQKilRQHbCdtKahEx3PjhW97k7NlVnK+kbJCGEmfLeX+tzt8JwdrhW6iv6b7CwoaG/KUaOq1ltF3IsITIH5tDC5rXbkzSiudiyzjxN+Pty+KDSOEYZ/KH7wXGGnqUcsHEThWb42cETto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772451654; c=relaxed/simple;
	bh=aHe7LDf+K8E9ZqlW4z5TwFGHnXHVNwK8jkl8jq649qQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IK047htqKP/rX++Yl4/JEWyNHTOIH+9FlHGDZnAxePEAaPXyN34UwUY5aLlS2Pm0lN52m0UX3u/L9HcevffNZBRBDODh2wUQ1ij1LzxhwtTocmL2aYs0nGXn5qsCp6bhA02EDnArkWiUBUj7UDViBAkP3kvdUNT08bZ5WgyDDNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UserYUUO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772451652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4GboqBNjOxLnkJWlCgoSfV3V8BCKz0Frnmh0ecySpFw=;
	b=UserYUUOaHVZkt5v0v5mXwgEA6+/yUJuJ2AjFf7IRgkW1VMYwVRbR3TuK2pb6jiLfWYH3N
	5fnnjd5WpvcVvZwKxBjenmCTsf4MXQJvNPJUMSqaHzDL/bqHNTxtWxYfKlg27QDk8ZtCIP
	JDmqnSIM3ObweXcWs8+xN5tQZGqbof0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-6LHR4HLJPYyz3bgR0kwY0Q-1; Mon,
 02 Mar 2026 06:40:49 -0500
X-MC-Unique: 6LHR4HLJPYyz3bgR0kwY0Q-1
X-Mimecast-MFC-AGG-ID: 6LHR4HLJPYyz3bgR0kwY0Q_1772451647
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9915F195608F;
	Mon,  2 Mar 2026 11:40:47 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.50])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 70AEB1955D85;
	Mon,  2 Mar 2026 11:40:44 +0000 (UTC)
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
Subject: [PATCH RFC iwl-next 4/4] iavf: harden VLAN filter state machine race handling
Date: Mon,  2 Mar 2026 12:40:25 +0100
Message-ID: <20260302114025.1017985-5-poros@redhat.com>
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
	TAGGED_FROM(0.00)[bounces-262622-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 263C31D7AC8
X-Rspamd-Action: no action

Address remaining race windows in the VLAN filter state machine that
were identified during cross-state analysis of ADD and DEL paths.

1. Add VIRTCHNL_OP_ADD_VLAN to the success completion handler.

   The V1 ADD_VLAN opcode had no success handler -- filters sent via V1
   stayed in ADDING state permanently.  Add a fallthrough case so V1
   filters also transition ADDING -> ACTIVE on PF confirmation.

   Critically, add an `if (v_retval) break` guard: the error switch
   in iavf_virtchnl_completion() does NOT return after handling errors,
   it falls through to the success switch.  Without this guard, a
   PF-rejected ADD would incorrectly mark ADDING filters as ACTIVE,
   creating a driver/HW mismatch where the driver believes the filter
   is installed but the PF never accepted it.

   For V2, this is harmless: iavf_vlan_add_reject() in the error
   block already kfree'd all ADDING filters, so the success handler
   finds nothing to transition.

2. Skip DEL on filters already in REMOVING state.

   In iavf_del_vlan(), if a filter is in IAVF_VLAN_REMOVING (DEL
   already sent to PF, waiting for response), do not overwrite to
   REMOVE and schedule a redundant DEL.  The pending DEL's
   completion handler will either kfree the filter (PF confirms)
   or revert to ACTIVE (PF rejects).

   Without this, the sequence DEL(pending) -> user-del -> second DEL
   could result in PF returning an error for the second DEL (filter
   already gone), causing the completion handler to incorrectly revert
   a deleted filter back to ACTIVE.

Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c     | 5 ++++-
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 4 ++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 212a23ead20c57..9bcf34f581e748 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -816,11 +816,14 @@ static void iavf_del_vlan(struct iavf_adapter *adapter, struct iavf_vlan vlan)
 			list_del(&f->list);
 			kfree(f);
 			adapter->num_vlan_filters--;
-		} else {
+		} else if (f->state != IAVF_VLAN_REMOVING) {
 			f->state = IAVF_VLAN_REMOVE;
 			iavf_schedule_aq_request(adapter,
 						 IAVF_FLAG_AQ_DEL_VLAN_FILTER);
 		}
+		/* If REMOVING, DEL is already sent to PF; completion
+		 * handler will free the filter when PF confirms.
+		 */
 	}
 
 	spin_unlock_bh(&adapter->mac_vlan_list_lock);
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 9f2b64bb4ed9e7..d5264e1d5d5699 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -2877,9 +2877,13 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 		spin_unlock_bh(&adapter->adv_rss_lock);
 		}
 		break;
+	case VIRTCHNL_OP_ADD_VLAN:
 	case VIRTCHNL_OP_ADD_VLAN_V2: {
 		struct iavf_vlan_filter *f;
 
+		if (v_retval)
+			break;
+
 		spin_lock_bh(&adapter->mac_vlan_list_lock);
 		list_for_each_entry(f, &adapter->vlan_filter_list, list) {
 			if (f->state == IAVF_VLAN_ADDING)
-- 
2.52.0


