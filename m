Return-Path: <netdev+bounces-276096-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIOTB2021WmP2wcAu9opvQ
	(envelope-from <netdev+bounces-276096-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 18:53:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EC03B21A0
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 18:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4EAF6301D092
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 16:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E273D091C;
	Tue,  7 Apr 2026 16:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nmt3VawR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5597733B95C
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 16:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775580776; cv=none; b=aJI6sZCsBtkqZBo6U1ojNtiqySvHGCtK/fwXoj9grY3BNDujUh8SH9yZudFIpuIwks3jhRlFVrecieCh/wxFPSLkhrpYYOmrBjfq5t59yDRusf65dCMG4yxUWm5nm3DG1kjA6tY3May4ffFeNHbThM0NMtBZso03ysniSWx8jzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775580776; c=relaxed/simple;
	bh=AY/WxWXgf8T8fn0+ZoZsWObrf7iBvOMN0P1T4yOQyqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JA2o9kJJxU9s5zCKCq+MBp+fXXZq4CURcHuct+6L9IC4hf1dglO09l4r1WVVOx14y5+mHmCW4PNXWzXArFf3OG8G8tm52dVSzwwBypJ1gsNjC7VdSDqelY6AkcUFOBBv7X9JY+bkPKRatKEejik7zpF19QUufDUmMyNaY4tqEnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nmt3VawR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775580774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VAmbrQbBI4SBbRZx1DWmHOcKHdFiGv6B3VCsYo5YKNM=;
	b=Nmt3VawRFoo04xZy9YZNJ1U8v5K/AzYMh/qk2A8/WdgDToQtjJbQvdtbrtpiJM1I98GMM3
	oevY+7U3ujv1jKnjJC4xWnhW5N96xbjYSXr5h3btBGaXYxRIpRLJOtlfHGuQYS9z0UduhF
	TKpAHCpNRkrqekossBSU8VW0kYZEsCI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-307-3fiw3TKxPBuqmTPKMB5HjQ-1; Tue,
 07 Apr 2026 12:52:53 -0400
X-MC-Unique: 3fiw3TKxPBuqmTPKMB5HjQ-1
X-Mimecast-MFC-AGG-ID: 3fiw3TKxPBuqmTPKMB5HjQ_1775580770
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A70FD1956096;
	Tue,  7 Apr 2026 16:52:50 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1337630001BB;
	Tue,  7 Apr 2026 16:52:46 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Subject: [PATCH net v2 4/4] ice: skip unnecessary VF reset when setting trust
Date: Tue,  7 Apr 2026 18:52:06 +0200
Message-ID: <20260407165206.1121317-5-jtornosm@redhat.com>
In-Reply-To: <20260407165206.1121317-1-jtornosm@redhat.com>
References: <20260407165206.1121317-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276096-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jtornosm@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 05EC03B21A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Similar to the i40e fix, ice_set_vf_trust() unconditionally calls
ice_reset_vf() when the trust setting changes.

The ice driver already has logic to clean up MAC LLDP filters when
removing trust, which is the only operation that requires filter
synchronization. After this cleanup, the VF reset is only necessary if
there were actually filters to remove.

For all other trust state changes (setting trust, or removing trust
when no filters exist), the reset is unnecessary as filter
synchronization happens naturally through normal VF operations.

Fix by only triggering the VF reset when removing trust AND filters
were actually cleaned up (num_mac_lldp was non-zero).

This saves some time and eliminates unnecessary service disruption when
changing VF trust settings if not necessary.

Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_sriov.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index 7e00e091756d..23f692b1e86c 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -1399,14 +1399,19 @@ int ice_set_vf_trust(struct net_device *netdev, int vf_id, bool trusted)
 
 	mutex_lock(&vf->cfg_lock);
 
-	while (!trusted && vf->num_mac_lldp)
-		ice_vf_update_mac_lldp_num(vf, ice_get_vf_vsi(vf), false);
-
 	vf->trusted = trusted;
-	ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
 	dev_info(ice_pf_to_dev(pf), "VF %u is now %strusted\n",
 		 vf_id, trusted ? "" : "un");
 
+	/* Only reset VF if removing trust and there are MAC LLDP filters
+	 * to clean up. Reset is needed to ensure filter removal completes.
+	 */
+	if (!trusted && vf->num_mac_lldp) {
+		while (vf->num_mac_lldp)
+			ice_vf_update_mac_lldp_num(vf, ice_get_vf_vsi(vf), false);
+		ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
+	}
+
 	mutex_unlock(&vf->cfg_lock);
 
 out_put_vf:
-- 
2.53.0


