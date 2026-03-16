Return-Path: <netdev+bounces-268110-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aL48OC3ft2mcWAEAu9opvQ
	(envelope-from <netdev+bounces-268110-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 11:45:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA2129826F
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 11:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 061CA30470BC
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 10:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD1F390C8F;
	Mon, 16 Mar 2026 10:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q3C/GVeC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE2539023B
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 10:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773657761; cv=none; b=DVwjh5mETyGMwP9ITUV+vUzdz75K7qJXSxd86X6iV60oJWGzCsPsxDqMQEd64yRmIseT2OnBm9GxRVlcQTigrRbIjH37y+E99xYg8QFMdkdPwR7uYSIDfdtpvYj5DkSwf5rahQ2+kXR4wxAPYuD1Vv1K97qc/eyoqxVW9xwxvVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773657761; c=relaxed/simple;
	bh=JCHvrEojksVEpHjmb8f0l8T6uIGVkerMflt9zKrQE80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fb9FP9Welu2Kw+y3v4TL4eaNUlG5KEtyKEbZWFi0+1ZrGOfWBpfmfLidkT6Ds4WsxKTiDUYHhDDtOfB7Yi+Jrei6eTg2O5gM5Blqaz/6p1t0QsUcvwJWMYJi0QOjSTrgsuiLf3d+XG6KTDs2QofUgyBRE3vPopQZveeO5dyBcIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q3C/GVeC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773657759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TcCvlNKS2FtWNY/zDB/0qSw6naZ8LMZekz/Sa7hhVBQ=;
	b=Q3C/GVeC4ihebBe4eEKAGH7+ngIO61JJ5c+RoE/k4yso6w724p97Po99l3MllEF7QzETFl
	sff1PYaZnhT25rnVxtmvVCqDq8erFZplLOV2AQBvrXV+XsFNdWoWQ1EfS3Dm6U4VOKPsXA
	afVp+Ze7MvSpjJXJEtENfqm+2uEqN/c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-277-54-iBjSePL26S8rctg4q0A-1; Mon,
 16 Mar 2026 06:42:36 -0400
X-MC-Unique: 54-iBjSePL26S8rctg4q0A-1
X-Mimecast-MFC-AGG-ID: 54-iBjSePL26S8rctg4q0A_1773657754
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 98A7D180AA95;
	Mon, 16 Mar 2026 10:42:31 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.45.224.235])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 116131800351;
	Mon, 16 Mar 2026 10:42:27 +0000 (UTC)
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
Subject: [PATCH iwl-next 4/4] iavf: harden VLAN filter state machine race handling
Date: Mon, 16 Mar 2026 11:42:09 +0100
Message-ID: <20260316104209.1285962-5-poros@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268110-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5AA2129826F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index 89e5aae20d5573..1ffc0ce3f35602 100644
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
index d0b7b810679399..147adb76f64141 100644
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


