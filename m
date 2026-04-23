Return-Path: <netdev+bounces-280759-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIYoBXYZ6mmzuAIAu9opvQ
	(envelope-from <netdev+bounces-280759-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 15:07:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F65445279F
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 15:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5FD4C306C3E5
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 13:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43852FE071;
	Thu, 23 Apr 2026 13:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Plzb8MjS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E34C3EE1EF
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 13:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776949490; cv=none; b=hc2Z3CNN8lT0O0NN9zfTI+wUF839t2BqNFb6ch/kOWpCZsPzY7niXNwf1lU2AI4Lzp4EJPxTwM7xF3ofJtDnj1vAKkwV6k2dZmsQr8chCShUlVYc3JxhkRdGmVkPVG+lsr4fpD5i7teMJZbBmtkSj+6AEcQk0aUZYXqN1z6kSqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776949490; c=relaxed/simple;
	bh=fIZ8ZiY1KDfMs3Phm7asXwByqiXQvDJI7aWp8x6bzTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CpIT+xNSkBcIfbXF5QYGhsm2IGezEK5HrbuJtX+4x/hM3PkjOaPhxtVS54ZplrVMIW+1VpHRC+h7N4SJiqvFWrlPhmJTq5c7PKGXPQmnzOlgxswtRmH1eMa7eo+wD9wn+WKqwqGE2/AFJC78OOVcSJV8sclnJ6UiBlIYG9sMPSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Plzb8MjS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776949488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hNxPm0l1Sh7y0ewMYZbtJKVp2OY0iO3QRahnfY38HjY=;
	b=Plzb8MjSwYJbhDTtlhgXBCDU3YboU83AVGOSIe7AxhCtS9vyXScGY6faqrV4nT7hdV8xBP
	qEXvOTmvE7m+0iZcte9g415stD3yvgswlX7czOwESEmh7UaGRfYN/KUw4Jc9DplJHTeBS+
	oHJ05P6YX9ExSjdlF5NmnIlr772rfSs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-380-gryGd0IUPd6ToVTN0eyAgA-1; Thu,
 23 Apr 2026 09:04:45 -0400
X-MC-Unique: gryGd0IUPd6ToVTN0eyAgA-1
X-Mimecast-MFC-AGG-ID: gryGd0IUPd6ToVTN0eyAgA_1776949482
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 76A0A1935303;
	Thu, 23 Apr 2026 13:04:42 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.35])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4036E19560AB;
	Thu, 23 Apr 2026 13:04:37 +0000 (UTC)
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
Subject: [PATCH net v4 4/4] ice: skip unnecessary VF reset when setting trust
Date: Thu, 23 Apr 2026 15:04:05 +0200
Message-ID: <20260423130405.139568-5-jtornosm@redhat.com>
In-Reply-To: <20260423130405.139568-1-jtornosm@redhat.com>
References: <20260423130405.139568-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280759-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jtornosm@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MAILSPIKE_FAIL(0.00)[2600:3c04:e001:36c::12fc:5321:query timed out];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: 8F65445279F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Similar to the i40e fix, ice_set_vf_trust() unconditionally calls
ice_reset_vf() when the trust setting changes. While the delay is smaller
than i40e this reset is still unnecessary in most cases.

Additionally, the original code has a race condition: it deletes MAC LLDP
filters BEFORE resetting the VF. During this deletion, the VF is still
ACTIVE and can add new MAC LLDP filters concurrently, potentially
corrupting the filter list.

When granting trust, no reset is needed - we can just set the capability
flag to allow privileged operations.

When revoking trust, we need to:
1. Clear the capability flag to block privileged operations
2. Disable promiscuous mode if it was enabled (trusted VFs can enable it)
3. Only reset if MAC LLDP filters exist (to clean them up)

When we do reset (MAC LLDP case), we fix the race condition by resetting
first to clear VF state (which blocks new MAC LLDP filter additions), then
delete existing filters safely. During cleanup, vf->trusted remains true so
ice_vf_is_lldp_ena() works properly. Only after cleanup do we set
vf->trusted = false.

When we don't reset, we manually handle capability flag and promiscuous
mode via helper function.

The ice driver already has logic to clean up MAC LLDP filters when
removing trust. After this cleanup, the VF reset is only necessary if
there were actually filters to remove (num_mac_lldp was non-zero).

This saves time and eliminates unnecessary service disruption when
changing VF trust settings in most cases, while properly handling filter
cleanup.

Fixes: 2296345416b0 ("ice: receive LLDP on trusted VFs")
Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
v4:
    - Address AI review (sashiko.dev) from Simon Horman:
      vf->trusted ordering bug
    - Fix upstream race condition when comparing with i40e code
    - Apply capability flag and promiscuous mode fixes from i40e AI review
    - Add helper function ice_setup_vf_trust() for non-reset path
    - Export ice_vf_clear_all_promisc_modes() for code reuse 
v3: https://lore.kernel.org/all/20260414110006.124286-5-jtornosm@redhat.com/

 drivers/net/ethernet/intel/ice/ice_sriov.c  | 41 +++++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_vf_lib.c |  2 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.h |  1 +
 3 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index 7e00e091756d..d0da7f6adc23 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -1364,6 +1364,34 @@ int ice_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
 	return __ice_set_vf_mac(ice_netdev_to_pf(netdev), vf_id, mac);
 }
 
+/**
+ * ice_setup_vf_trust - Enable/disable VF trust mode without reset
+ * @vf: VF to configure
+ * @setting: trust setting
+ *
+ * Manually handle capability flag and promiscuous mode when changing trust
+ * without performing a VF reset.
+ * When reset is performed, this is not necessary as the reset procedure
+ * already handles this.
+ **/
+static void ice_setup_vf_trust(struct ice_vf *vf, bool setting)
+{
+	struct ice_vsi *vsi;
+
+	if (setting) {
+		set_bit(ICE_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
+	} else {
+		clear_bit(ICE_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
+
+		if (test_bit(ICE_VF_STATE_UC_PROMISC, vf->vf_states) ||
+		    test_bit(ICE_VF_STATE_MC_PROMISC, vf->vf_states)) {
+			vsi = ice_get_vf_vsi(vf);
+			if (vsi)
+				ice_vf_clear_all_promisc_modes(vf, vsi);
+		}
+	}
+}
+
 /**
  * ice_set_vf_trust
  * @netdev: network interface device structure
@@ -1399,11 +1427,16 @@ int ice_set_vf_trust(struct net_device *netdev, int vf_id, bool trusted)
 
 	mutex_lock(&vf->cfg_lock);
 
-	while (!trusted && vf->num_mac_lldp)
-		ice_vf_update_mac_lldp_num(vf, ice_get_vf_vsi(vf), false);
-
+	/* Reset only if revoking trust with MAC LLDP filters */
+	if (!trusted && vf->num_mac_lldp) {
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
 
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index c8bc952f05cd..81bbf30e5c29 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -623,7 +623,7 @@ ice_vf_get_promisc_masks(struct ice_vf *vf, struct ice_vsi *vsi,
  *
  * Clear all promiscuous/allmulticast filters for a VF
  */
-static int
+int
 ice_vf_clear_all_promisc_modes(struct ice_vf *vf, struct ice_vsi *vsi)
 {
 	struct ice_pf *pf = vf->pf;
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.h b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
index 7a9c75d1d07c..a3501bd92311 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
@@ -310,6 +310,7 @@ bool ice_is_any_vf_in_unicast_promisc(struct ice_pf *pf);
 void
 ice_vf_get_promisc_masks(struct ice_vf *vf, struct ice_vsi *vsi,
 			 u8 *ucast_m, u8 *mcast_m);
+int ice_vf_clear_all_promisc_modes(struct ice_vf *vf, struct ice_vsi *vsi);
 int
 ice_vf_set_vsi_promisc(struct ice_vf *vf, struct ice_vsi *vsi, u8 promisc_m);
 int
-- 
2.53.0


