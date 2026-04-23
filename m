Return-Path: <netdev+bounces-280757-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFEXN2EZ6mmzuAIAu9opvQ
	(envelope-from <netdev+bounces-280757-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 15:06:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC83C452781
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 15:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 94BC93019D7A
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 13:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA933EE1E2;
	Thu, 23 Apr 2026 13:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hd/pPKFX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038D43A4F30
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 13:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776949478; cv=none; b=qEyEJxQRstvfIUF8Ob6+lyXqvwGFdZC89lteJpeGxGCFSq6uiZSFmSKly+UpUVKmigFv7TqWfY5qZh+xv+8h6etk5KZcOePv5ldWDKO4wFowf6P0tx8cEPZJlQAS5xjfng/kUKOJIbZhQgCN9gV0UlK6hhd5EdJSMi3UqpcLsjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776949478; c=relaxed/simple;
	bh=DnjZRLxZLrOuboPQijvsjfWA+P2Q7ZS90oDw+nXLAaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tT4Gl8lrX694sDNKT6kHJqlcxZfccfKK58zbnlusYcd3/PUJw8rkwRKgZ/BidP1yXA7GpEhh9D/Y8y1ZfEXBv7kJHTLsCw0hkPZ1YDiuPEJ/QzTF9aaNXpLRGehHtIuu5AuE2HPbTcaO5hxh2RYXI/lIj/YLdF02Tg/aEuIw0fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hd/pPKFX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776949476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V4Q0MOn1u0gAM7/dNJGpsnMsr1o6R0pQuwhdX44mvZo=;
	b=hd/pPKFXIs/CTn0Fyf/3uvxl9pNWW34lccd9C5JufMC+PMLYnNAyqfwFQvrMDtRZDRvYdb
	K/pbmlla+cHm7iw0WfnKd46hygJYdXYuMQnyXXgHL9TyHuZHEhQ6YRCC1lOZsyrp/b8xlU
	VvgBeFqf9xViBNwyOYcIXSka/IggLs4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-583-IprX85EhNc2mqjLH94ZZ7Q-1; Thu,
 23 Apr 2026 09:04:32 -0400
X-MC-Unique: IprX85EhNc2mqjLH94ZZ7Q-1
X-Mimecast-MFC-AGG-ID: IprX85EhNc2mqjLH94ZZ7Q_1776949470
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DAFF619560A3;
	Thu, 23 Apr 2026 13:04:29 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.35])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8C96E19560AB;
	Thu, 23 Apr 2026 13:04:25 +0000 (UTC)
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
Subject: [PATCH net v4 2/4] i40e: skip unnecessary VF reset when setting trust
Date: Thu, 23 Apr 2026 15:04:03 +0200
Message-ID: <20260423130405.139568-3-jtornosm@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280757-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jtornosm@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MAILSPIKE_FAIL(0.00)[2600:3c09:e001:a7::12fc:5321:query timed out];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AC83C452781
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The current implementation triggers a VF reset when changing the trust
setting, causing a ~10 second delay during bonding setup.

In all the cases, the reset causes a ~10 second delay during which:
- VF must reinitialize completely
- Any in-progress operations (like bonding enslave) fail with timeouts
- VF is unavailable

When granting trust, no reset is needed - we can just set the capability
flag to allow privileged operations.

When revoking trust, we need to:
1. Clear the capability flag to block privileged operations
2. Disable promiscuous mode if it was enabled (trusted VFs can enable it)
3. Only reset if ADQ is enabled (to clean up cloud filters)

When we do reset (ADQ case), we reset first to clear VF_STATE_ACTIVE
(which blocks new cloud filter additions), then delete existing cloud
filters safely. This avoids the race condition where VF could add filters
during deletion.

When we don't reset, we manually handle capability flag and promiscuous
mode via helper function, eliminating the delay.

Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
v4: Address AI review (sashiko.dev) from Simon Horman:
    - Manually set/clear capability flag when not resetting
    - Explicitly disable promiscuous mode when revoking trust                                        
    - Fix cloud filter race: reset FIRST (clears VF_STATE_ACTIVE),
      delete filters AFTER (no race window)
    - Add helper function i40e_setup_vf_trust() for non-reset path
v3: https://lore.kernel.org/all/20260414110006.124286-3-jtornosm@redhat.com/

 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 42 ++++++++++++++-----
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index a26c3d47ec15..69f68fec6809 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -4943,6 +4943,30 @@ int i40e_ndo_set_vf_spoofchk(struct net_device *netdev, int vf_id, bool enable)
 	return ret;
 }
 
+/**
+ * i40e_setup_vf_trust - Enable/disable VF trust mode without reset
+ * @vf: VF to configure
+ * @setting: trust setting
+ *
+ * Manually handle capability flag and promiscuous mode when changing trust
+ * without performing a VF reset.
+ * When reset is performed, this is not necessary as the reset procedure
+ * already handles this.
+ **/
+static void i40e_setup_vf_trust(struct i40e_vf *vf, bool setting)
+{
+	if (setting) {
+		set_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
+	} else {
+		clear_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
+
+		if (test_bit(I40E_VF_STATE_UC_PROMISC, &vf->vf_states) ||
+		    test_bit(I40E_VF_STATE_MC_PROMISC, &vf->vf_states))
+			i40e_config_vf_promiscuous_mode(vf, vf->lan_vsi_idx,
+							false, false);
+	}
+}
+
 /**
  * i40e_ndo_set_vf_trust
  * @netdev: network interface device structure of the pf
@@ -4987,19 +5011,17 @@ int i40e_ndo_set_vf_trust(struct net_device *netdev, int vf_id, bool setting)
 	set_bit(__I40E_MACVLAN_SYNC_PENDING, pf->state);
 	pf->vsi[vf->lan_vsi_idx]->flags |= I40E_VSI_FLAG_FILTER_CHANGED;
 
-	i40e_vc_reset_vf(vf, true);
+	/* Reset only if revoking trust with ADQ (for cloud filter cleanup) */
+	if (vf->adq_enabled && !setting) {
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


