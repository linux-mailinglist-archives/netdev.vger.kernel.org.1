Return-Path: <netdev+bounces-276094-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHOHDmA21WmP2wcAu9opvQ
	(envelope-from <netdev+bounces-276094-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 18:52:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F063B2174
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 18:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6D2F9301A76F
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 16:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F04E3CFF4F;
	Tue,  7 Apr 2026 16:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SC3vjSyV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7233B775B
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 16:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775580764; cv=none; b=kBolER6KMv1pktKz7zh2maFcj8N8h+5BHuE5t+wE8cC5a54Dtd7PCeRgs1MC8FyTYGuUtMPjfN8RJcxhqqP5mKHIfHiHvOIrdS7h80FJPWyF7WoimSdQmzlp8CWxVmRA9Tzxn9Q1Z9/Ug+0Hw/j6a0xCnHrX9TpnO1aiju1T+y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775580764; c=relaxed/simple;
	bh=LM+/xI0ovO+0zVOlyGzsXdJ+OP9bhvrhm+hrSOEbt4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=toE8vIJsEiAtw6yL5puyjBELXxfbYqIbJ+V/HM07Pt0GH8EMWILRk1YIoy7wK8rkqfhouI/prMXIPZj8Xbg/7NXPCoqknkCixEMoRgws65RJetbZrH/kWYnqTeHXkQanFtwG05vUsPQTHgXRmvC4kQUmzMyL2f7DfJsFikwzy0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SC3vjSyV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775580762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9mJAFR2P64r9/LOJtwiqZN1rPSkz3fb8OpCJmbM7VKg=;
	b=SC3vjSyVarideI4YWAM9oBlYQbawafw9nFbxeK0absPzrfmNKxV+LiveNzLVUTxpNij7Wa
	a+4WHDxYabrqmdxQd8C6FS5CZhrWQzLdSZLwJiIUMC/82uv6RKSXTZO9NhOlkG/dQY2E2j
	FjPc9F7DHLXxHhLUeYHpXWAgoTsD72Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-34-467aH6BKPJuklHHfbL38QQ-1; Tue,
 07 Apr 2026 12:52:39 -0400
X-MC-Unique: 467aH6BKPJuklHHfbL38QQ-1
X-Mimecast-MFC-AGG-ID: 467aH6BKPJuklHHfbL38QQ_1775580757
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A644E195605B;
	Tue,  7 Apr 2026 16:52:37 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 12085300019F;
	Tue,  7 Apr 2026 16:52:33 +0000 (UTC)
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
Subject: [PATCH net v2 2/4] i40e: skip unnecessary VF reset when setting trust
Date: Tue,  7 Apr 2026 18:52:04 +0200
Message-ID: <20260407165206.1121317-3-jtornosm@redhat.com>
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
	TAGGED_FROM(0.00)[bounces-276094-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 02F063B2174
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When VF trust is changed, i40e_ndo_set_vf_trust() always calls
i40e_vc_reset_vf() to sync MAC/VLAN filters. However, this reset is
only necessary when trust is removed from a VF that has ADQ (advanced
queue) filters, which need to be deleted

In all other cases, the reset causes a ~10 second delay during which:
- VF must reinitialize completely
- Any in-progress operations (like bonding enslave) fail with timeouts
- VF is unavailable

The MAC/VLAN filter sync will happen naturally through the normal VF
operations and doesn't require a forced reset.

Fix by only resetting when actually needed: when removing trust from a
VF that has ADQ cloud filters. For all other trust changes, just update
the trust flag and let normal operation continue.

Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index a26c3d47ec15..fea267af7afe 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -4987,16 +4987,21 @@ int i40e_ndo_set_vf_trust(struct net_device *netdev, int vf_id, bool setting)
 	set_bit(__I40E_MACVLAN_SYNC_PENDING, pf->state);
 	pf->vsi[vf->lan_vsi_idx]->flags |= I40E_VSI_FLAG_FILTER_CHANGED;
 
-	i40e_vc_reset_vf(vf, true);
 	dev_info(&pf->pdev->dev, "VF %u is now %strusted\n",
 		 vf_id, setting ? "" : "un");
 
+	/* Only reset VF if we're removing trust and it has ADQ cloud filters.
+	 * Cloud filters can only be added when trusted, so they must be
+	 * removed when trust is revoked. Other trust changes don't require
+	 * reset - MAC/VLAN filter sync happens through normal operation.
+	 */
 	if (vf->adq_enabled) {
 		if (!vf->trusted) {
 			dev_info(&pf->pdev->dev,
 				 "VF %u no longer Trusted, deleting all cloud filters\n",
 				 vf_id);
 			i40e_del_all_cloud_filters(vf);
+			i40e_vc_reset_vf(vf, true);
 		}
 	}
 
-- 
2.53.0


