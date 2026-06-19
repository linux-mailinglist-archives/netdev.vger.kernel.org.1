Return-Path: <netdev+bounces-300605-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 71F0HSPeNGqkiwYAu9opvQ
	(envelope-from <netdev+bounces-300605-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 08:13:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C596A40E9
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 08:13:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=OZUiOJh0;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300605-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300605-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 06DFC304E657
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 06:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697023563D4;
	Fri, 19 Jun 2026 06:13:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EE43148C5
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 06:13:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781849633; cv=none; b=k6l53P7BJep7EOPmzgNqlxjIVfvgbixUzUuJ7o87BYddGFMWEagJYCc5u/qIfZgtqHcVMd50dz74UDFqa3mPx3KkJny30eMsoI568OBjQJZR5r9VQFe2jrMdJXZaOxinTMfme6HxTLvmfoPLwWctsMz2I44E4GzsFnATxhxmyfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781849633; c=relaxed/simple;
	bh=JztbWetg571UwWfwTNziKeNj61Q3yi/AvPAnqyfEhJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S8sxjRuW3dixZFOFp9Vpj5CjXwybWxXgORLJIrQsv56EOVqYIfWdhq2cZusM1n3t1YKR5N8ySetU/osfIeogrQKAzSt278C67SoAS4nibYcCR95QBXgr1jpOW2xsG6DX2KCdL6WQOH+kvrx+4Nh+eGueYaMJHue2OQnBlIPrt7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OZUiOJh0; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781849630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=msD4SL+Z1RyUpqbz+Wvsj0nr0nQSMH+6amTrSFHcVgA=;
	b=OZUiOJh0uWSFob2WSmq0LkvAET95StFY0ToFuMJMVisvIapH87LMF8IDL6Y4ce8Qykif03
	dNNBMzfgPS+qcNWiU4+u1Wgz1Kg8jFdjqF99TUcqV5mFDLhHXgm0D8nQ8Bsotecl708qrb
	X+7ZsLIP3ESCrsLLV+rEIZnz04rrwrw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-316-MWEIWwzNMX6HjZVDT7ozNQ-1; Fri,
 19 Jun 2026 02:13:47 -0400
X-MC-Unique: MWEIWwzNMX6HjZVDT7ozNQ-1
X-Mimecast-MFC-AGG-ID: MWEIWwzNMX6HjZVDT7ozNQ_1781849625
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1C46D195605F;
	Fri, 19 Jun 2026 06:13:45 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.65])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 14EEF1956088;
	Fri, 19 Jun 2026 06:13:39 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	przemyslaw.kitszel@intel.com,
	aleksandr.loktionov@intel.com,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net v6 2/4] i40e: skip unnecessary VF reset when setting trust
Date: Fri, 19 Jun 2026 08:13:17 +0200
Message-ID: <20260619061321.8554-3-jtornosm@redhat.com>
In-Reply-To: <20260619061321.8554-1-jtornosm@redhat.com>
References: <20260619061321.8554-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300605-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:intel-wired-lan@lists.osuosl.org,m:przemyslaw.kitszel@intel.com,m:aleksandr.loktionov@intel.com,m:jacob.e.keller@intel.com,m:horms@kernel.org,m:jesse.brandeburg@intel.com,m:anthony.l.nguyen@intel.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jtornosm@redhat.com,m:rafal.romanowski@intel.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[jtornosm@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jtornosm@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F1C596A40E9

The current implementation triggers a VF reset when changing the trust
setting, causing a ~10 second delay during bonding setup.

In all the cases, the reset causes a ~10 second delay during which:
- VF must reinitialize completely
- Any in-progress operations (like bonding enslave) fail with timeouts
- VF is unavailable

When granting trust, no reset is needed - we can just set the capability
flag to allow privileged operations.

When revoking trust, we only need to reset (conservative approach) if
the VF has actually configured advanced features that require cleanup
(ADQ/cloud filters, promiscuous mode). For VFs in a clean state, we can
safely change the trust setting without the disruptive reset.

When we don't reset, we manually handle capability flag via helper
function, eliminating the delay.

Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
---
v6: No changes from v5. AI review comments covered design decisions
    (over-limit filter handling, synchronization model) and pre-existing
    issues, but found no bugs in the new code.
v5: https://lore.kernel.org/all/20260429102426.210750-3-jtornosm@redhat.com/

 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 38 ++++++++++++++-----
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index a26c3d47ec15..0cc434b26eb8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -4943,6 +4943,23 @@ int i40e_ndo_set_vf_spoofchk(struct net_device *netdev, int vf_id, bool enable)
 	return ret;
 }
 
+/**
+ * i40e_setup_vf_trust - Enable/disable VF trust mode without reset
+ * @vf: VF to configure
+ * @setting: trust setting
+ *
+ * Update VF flags when changing trust without performing a VF reset.
+ * This is only called when it's safe to skip the reset (VF has no advanced
+ * features configured that need cleanup).
+ */
+static void i40e_setup_vf_trust(struct i40e_vf *vf, bool setting)
+{
+	if (setting)
+		set_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
+	else
+		clear_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
+}
+
 /**
  * i40e_ndo_set_vf_trust
  * @netdev: network interface device structure of the pf
@@ -4987,19 +5004,20 @@ int i40e_ndo_set_vf_trust(struct net_device *netdev, int vf_id, bool setting)
 	set_bit(__I40E_MACVLAN_SYNC_PENDING, pf->state);
 	pf->vsi[vf->lan_vsi_idx]->flags |= I40E_VSI_FLAG_FILTER_CHANGED;
 
-	i40e_vc_reset_vf(vf, true);
+	/* Reset only if revoking trust and VF has advanced features configured */
+	if (!setting &&
+	    (vf->adq_enabled || vf->num_cloud_filters > 0 ||
+	     test_bit(I40E_VF_STATE_UC_PROMISC, &vf->vf_states) ||
+	     test_bit(I40E_VF_STATE_MC_PROMISC, &vf->vf_states))) {
+		i40e_vc_reset_vf(vf, true);
+		i40e_del_all_cloud_filters(vf);
+	} else {
+		i40e_setup_vf_trust(vf, setting);
+	}
+
 	dev_info(&pf->pdev->dev, "VF %u is now %strusted\n",
 		 vf_id, setting ? "" : "un");
 
-	if (vf->adq_enabled) {
-		if (!vf->trusted) {
-			dev_info(&pf->pdev->dev,
-				 "VF %u no longer Trusted, deleting all cloud filters\n",
-				 vf_id);
-			i40e_del_all_cloud_filters(vf);
-		}
-	}
-
 out:
 	clear_bit(__I40E_VIRTCHNL_OP_PENDING, pf->state);
 	return ret;
-- 
2.53.0


