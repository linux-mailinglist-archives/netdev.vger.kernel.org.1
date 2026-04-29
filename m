Return-Path: <netdev+bounces-282337-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIygD93c8Wn1kwEAu9opvQ
	(envelope-from <netdev+bounces-282337-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 12:26:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC8E492DB3
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 12:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 055C23014799
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 10:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4810837A48D;
	Wed, 29 Apr 2026 10:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cVjXuVU7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA14B26A1AF
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 10:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777458324; cv=none; b=tobyUL0p2TV81jIKLewNRVOPUJ4Q09vIZn5mObksmuLPgRIYRwEXfzpQrj/piD0EJl+Ybswx6p+DqpMcUh9lllUKUCIJjU1gi9qrI9CJ8qGpHNByVTv6LU1gu5DLF3RGoKPpU+WApk6SfJ6LWwf7MM1Gd3zdmVGTM+wZZJ+bYQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777458324; c=relaxed/simple;
	bh=+BIXZ8bMGmprfrdSn4TIfTCdmNPNH2uBfeXZPvi7JXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TPBT9LXC97FKusCrpz1wg/+NzFXKN5UEM7jrR7olrzdv4nQ62zzIzhcAI5oXCJ3ol1OOJu7p4fhmhRYdLDoqC0h+d2sJovBaz3tAyy0IkAOlutVMOQCeuYrm+JDAAQYoqmpxooBVd+tPT+/CHuUTTPpjYISv9OyhgEEmAIJjPFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cVjXuVU7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777458321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wFXSuTbArLWA6KgK84tVAXunsrSDHkBByEg9Ue3Lwfs=;
	b=cVjXuVU7cQQe+FiTgd6zm2KKf6qyVMxlCORCVc7uI4k5oxuQK6gu5RUBl6xCPVMRx+ytvc
	4jv3fkpiH7e8i68C/8fqEXPmKT8SuykGXCHWsO18A+PNROmvtHEpoKAyErDLCFWZylwNOL
	aX+Kw02g0fADix+E9TCEqG98j19wbHI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-133-Jg18yUZpOsORwEPjjFjR5w-1; Wed,
 29 Apr 2026 06:25:16 -0400
X-MC-Unique: Jg18yUZpOsORwEPjjFjR5w-1
X-Mimecast-MFC-AGG-ID: Jg18yUZpOsORwEPjjFjR5w_1777458314
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C2C381800366;
	Wed, 29 Apr 2026 10:25:14 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.45])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 421881800446;
	Wed, 29 Apr 2026 10:25:09 +0000 (UTC)
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
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Subject: [PATCH net v5 4/4] ice: skip unnecessary VF reset when setting trust
Date: Wed, 29 Apr 2026 12:24:26 +0200
Message-ID: <20260429102426.210750-5-jtornosm@redhat.com>
In-Reply-To: <20260429102426.210750-1-jtornosm@redhat.com>
References: <20260429102426.210750-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Queue-Id: 5AC8E492DB3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282337-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jtornosm@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sashiko.dev:url]

Similar to the i40e fix, ice_set_vf_trust() unconditionally calls
ice_reset_vf() when the trust setting changes. While the delay is smaller
than i40e this reset is still unnecessary in most cases.

Additionally, the original code has a race condition: it deletes MAC LLDP
filters BEFORE resetting the VF. During this deletion, the VF is still
ACTIVE and can add new MAC LLDP filters concurrently, potentially
corrupting the filter list.

When granting trust, no reset is needed - we can just set the capability
flag to allow privileged operations.

When revoking trust, we only need to reset (conservative approach) if
the VF has actually configured advanced features that require cleanup
(MAC LLDP filters, promiscuous mode). For VFs in a clean state, we can
safely change the trust setting without the disruptive reset.

When we do reset (MAC LLDP case), we fix the race condition by resetting
first to clear VF state (which blocks new MAC LLDP filter additions), then
delete existing filters safely. During cleanup, vf->trusted remains true so
ice_vf_is_lldp_ena() works properly. Only after cleanup do we set
vf->trusted = false.

When we don't reset, we manually handle capability flag via helper
function, eliminating the delay.

Fixes: 2296345416b0 ("ice: receive LLDP on trusted VFs")
Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
v5 Address the comments from Aleksandr Loktionov:
   - Error handling when ice_setup_vf_trust is called is not necessary
     because ice_vf_clear_all_promisc_modes is not used due to the
     conservative approach to solve AI tool review concerns 
   - kdoc should end with '*/' not '**/' (new function)
   Address AI review (sashiko.dev) from Simon Horman:
   - Adopt a conservative approach checking multiple conditions before
     skipping reset: MAC LLDP filters, promiscuous mode
   - Simplify helper function to only handle capability flag
   - No need to export ice_vf_clear_all_promisc_modes
v4: https://lore.kernel.org/all/20260423130405.139568-5-jtornosm@redhat.com/

 drivers/net/ethernet/intel/ice/ice_sriov.c | 33 +++++++++++++++++++---
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index 7e00e091756d..3c64ed1b41a8 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -1364,6 +1364,23 @@ int ice_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
 	return __ice_set_vf_mac(ice_netdev_to_pf(netdev), vf_id, mac);
 }
 
+/**
+ * ice_setup_vf_trust - Enable/disable VF trust mode without reset
+ * @vf: VF to configure
+ * @setting: trust setting
+ *
+ * Update VF flags when changing trust without performing a VF reset.
+ * This is only called when it's safe to skip the reset (VF has no advanced
+ * features configured that need cleanup).
+ */
+static void ice_setup_vf_trust(struct ice_vf *vf, bool setting)
+{
+	if (setting)
+		set_bit(ICE_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
+	else
+		clear_bit(ICE_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
+}
+
 /**
  * ice_set_vf_trust
  * @netdev: network interface device structure
@@ -1399,11 +1416,19 @@ int ice_set_vf_trust(struct net_device *netdev, int vf_id, bool trusted)
 
 	mutex_lock(&vf->cfg_lock);
 
-	while (!trusted && vf->num_mac_lldp)
-		ice_vf_update_mac_lldp_num(vf, ice_get_vf_vsi(vf), false);
-
+	/* Reset only if revoking trust and VF has advanced features configured */
+	if (!trusted &&
+	    (vf->num_mac_lldp > 0 ||
+	     test_bit(ICE_VF_STATE_UC_PROMISC, vf->vf_states) ||
+	     test_bit(ICE_VF_STATE_MC_PROMISC, vf->vf_states))) {
+		ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
+		while (vf->num_mac_lldp)
+			ice_vf_update_mac_lldp_num(vf, ice_get_vf_vsi(vf), false);
+	} else {
+		ice_setup_vf_trust(vf, trusted);
+	}
 	vf->trusted = trusted;
-	ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
+
 	dev_info(ice_pf_to_dev(pf), "VF %u is now %strusted\n",
 		 vf_id, trusted ? "" : "un");
 
-- 
2.53.0


