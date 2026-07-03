Return-Path: <netdev+bounces-304646-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WdptAkz8R2oyigAAu9opvQ
	(envelope-from <netdev+bounces-304646-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 20:15:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DAB704D14
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 20:15:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cisco.com header.s=iport01 header.b=MpkZQ+AT;
	dmarc=pass (policy=reject) header.from=cisco.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304646-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304646-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8DC3330B912A
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 18:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23DB3290B9;
	Fri,  3 Jul 2026 18:09:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-8.cisco.com (rcdn-iport-8.cisco.com [173.37.86.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020CB31353C;
	Fri,  3 Jul 2026 18:09:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783102167; cv=none; b=iO24B9FEufs9QoW8+BK8GlgBbeO2NYtm61CarJK5Aa1aZBYL6OhjKLkd/F/JxkWOwK8ZhdPX9ZZRfjAuC2b+6SPkYM2A5C9Yp3l0nuVmGW3O7+j9wJNlsZAoXKHBW3LIbLYCpAOymU4FRB5VZTOTxQTPuWuoYivEMt2KtldmMcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783102167; c=relaxed/simple;
	bh=FdWRKYYtk0FuUUegGgtNhjQIkPVlYiHEZ4/j6/h3dCk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pj91er26SsGaBVPhLWCZEADAjQskNViM1bIbWJ16uKI8puX7/bsZ3zYU8s/azscr1hapRj0t3YfP9mmDiR6ohTZXnaNgjUXxsI0Iw0mE9LgU+9xB0VsWh+7mzAWSYwMBlGGebeqONfE66CZGESWJLNDesXaQXfL/5A/K13OX9dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=MpkZQ+AT; arc=none smtp.client-ip=173.37.86.79
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=6579; q=dns/txt;
  s=iport01; t=1783102166; x=1784311766;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=r7xz+wdOM2LeRCY3jPvIhQ2Pkga6rs6A23prvlcG3s0=;
  b=MpkZQ+ATSNQqfyV+abRIqZWzaArwfkpM8qM7GahorrlLpVYFbfiVXWgY
   njzaLiy/nC4fETAQidX+cQ0vxLwvY6PDI2H8IVcT5vrU6w7VM7IBe/ybK
   vnPxHGg1h/muHZpitQo6xto/86XYTZmW+9ti373wF9bky5Ne914wv2lI3
   vOvgALdLc3mpAzK/NY49+iMGUnOAy605cgSwqLpfqC4FcUPnPdXCI8hz4
   5KtCH2WvemW9WR2piYgQPmPrQJYCbat1V+XqStfEzm7osE6K+5FkPenbs
   Npeqni0O5ez7nG3mY5o07z47zPFXvoqIxSqYsxi/PcKNsR6IV7fp7FC+U
   w==;
X-CSE-ConnectionGUID: nY9JYPKWS0ChhHmyS1lI7Q==
X-CSE-MsgGUID: uqAkR2pjTrGr2m464X2gWg==
X-IPAS-Result: =?us-ascii?q?A0D8AgBN+kdq/5P/Ja1aHgEBCxIMggULgleBUkNJhFePU?=
 =?us-ascii?q?4Ihnh4UgWoPAQEBD1EEAQGFBgKNSwImNgcOAQIEAwIDAQEBAQEBAQEBAQELA?=
 =?us-ascii?q?QEFAQEBAgEHBYEOE4ZchlsCAQMjBFIQJQImAgJGEAYBEoMCgnQDvAp6fzOBA?=
 =?us-ascii?q?d5DgWYBCxQBgQouhXGCagGBcIQGO4RBJxuBSUSBFYNphCqDdIJqBIMcEpEfC?=
 =?us-ascii?q?T+BAhwDWSwBVRMNCgsHBWFSMwMgCgsSEhgVAhQcEw8EFjIdcAwnEiwXNFgbB?=
 =?us-ascii?q?wWBHYEVMQQhgQSEeSMfAzl/gTB1SnkzgQIBEh4KgVKBJgMLGA1IESw3Bg4bB?=
 =?us-ascii?q?D0BbgeNABcPgUxxATwdNBRoMw6BZh+SRBGDbY1fa4E1n1qEJ4FmoA8BMpdnk?=
 =?us-ascii?q?wWZCCOkN4RogW8GL4FZMxoIGxWDIlMZD44tFhzSHicyPQEBBwIHDgMLgWiRf?=
 =?us-ascii?q?QEB?=
IronPort-Data: A9a23:ecjbWaLOMalAsxSKFE+REZQlxSXFcZb7ZxGr2PjKsXjdYENS3mBSz
 2AZUDvQaK6IazH9et0kPYi/9RhSscTXzYVhSlYd+CA2RRqmiyZq6fd1j6vUF3nPRiEWZBs/t
 63yUvGZcoZsCCSa/kvxWlTYhSEU/bmSQbbhA/LzNCl0RAt1IA8skhsLd9QR2uaEuvDnRVnQ0
 T/Oi5eHYgH9hGYvajh8B5+r8XuDgtyj4Fv0gXRmDRx7lAe2v2UYCpsZOZawIxPQKqFIHvS3T
 vr017qw+GXU5X8FUrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRuukoPD8fwXG8M49m/c3+d/
 /0W3XC4YV9B0qQhA43xWTEAe811FfUuFLMqvRFTvOTLp3AqfUcAzN1oPRAUDLU7xd0vKmFO1
 fkJE2kJT0+60rfeLLKTEoGAh+w5J8XteYdasXZ6wHSAVbAtQIvIROPB4towMDUY358VW62BI
 ZBENHw2MEuojx5nYj/7DLollfupnXn8cxVTqUmeouw85G27IAlZjOmzaYeFJ4TXLSlTtluBj
 2H8pXz7Pgs1LoaalWTZwiijueCayEsXX6pXTtVU7MVCjFSNy2k7BBQIWF6/pvelzEizR7p3J
 kAJ/yM8oLQa+0usQd3wGRa/pRasvQMWUvJTHvc85QXLzbDbiy6QAGQeQyECbtE6uMIobTg30
 FnPlNOBLSRmurCTSFqH+7uUpC/0Mi8QRUcGZCkZXU4G7sPlrYUbkB3CVJBgHbSzg9mzHiv/q
 xiMoTQyiqs7k8EGzeO48ErBjjbqoYLGJjPZ/S3NVW6jqwc8b4m/asnxsR7Q7O1LK8CSSVzpU
 GU4pvVyJdsmVfml/BFhis1SdF11z55p6AHhvGM=
IronPort-HdrOrdr: A9a23:9laY2aABb8m4qEPlHela55DYdb4zR+YMi2TDGXoBLSC9Ffb4qy
 nOppomPHDP5Qr5NEtLpTnEAtjjfZq+z/FICPcqXYtKNTOO0ACVxcNZnOjfKlbbdxEWmNQtsJ
 tIQuxSBML9CF5igd2/wgWpeuxQueWvweSEifjTynF1QRovUaFv6A9lFh2We3cGIjWufaBJc6
 a0145guyeqf2gRY4CQA3kIWPWGmvjw/aiWGSLvw3UcmXOzZfTC0s+ALySl
X-Talos-CUID: =?us-ascii?q?9a23=3AdGNzP2hs8xvOfr3WE3c2treZqTJudEyM7kboAHC?=
 =?us-ascii?q?DUU1pSJ2QWGTJ/II7qp87?=
X-Talos-MUID: =?us-ascii?q?9a23=3A5hrTbg6s99Yoa+w4bTKEXHGCxox1+o2tMhoVk6k?=
 =?us-ascii?q?clNPeMHAuZwfHgwu4F9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,145,1779148800"; 
   d="scan'208";a="496158505"
Received: from rcdn-l-core-10.cisco.com ([173.37.255.147])
  by rcdn-iport-8.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 03 Jul 2026 18:09:04 +0000
Received: from [127.0.0.1] (unknown [10.25.130.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-10.cisco.com (Postfix) with ESMTPS id E550F180008AC;
	Fri,  3 Jul 2026 18:09:03 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Fri, 03 Jul 2026 11:09:01 -0700
Subject: [PATCH net-next v11 12/12] enic: re-establish V2 VF admin channel
 and PF registration after reset
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-enic-sriov-v2-admin-channel-v2-v11-12-5b739f1fe9e5@cisco.com>
References: <20260703-enic-sriov-v2-admin-channel-v2-v11-0-5b739f1fe9e5@cisco.com>
In-Reply-To: <20260703-enic-sriov-v2-admin-channel-v2-v11-0-5b739f1fe9e5@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sesidhar Baddela <sebaddel@cisco.com>, Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783102134; l=6769;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=FdWRKYYtk0FuUUegGgtNhjQIkPVlYiHEZ4/j6/h3dCk=;
 b=pbzGV22FbyLgzcmY+XKE3XVzVCXGp453SNRyaBsYGhUj1t0i0Zjn3/uvqGDHBP9hF4yKW5oVq
 APiI7xZCH5TAI+X79NX6n17d+1S/ey3MpxX8GB5jPTEUqp43Dkk6kpr
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.130.254];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.130.254, [10.25.130.254]
X-Outbound-Node: rcdn-l-core-10.cisco.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[cisco.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cisco.com,reject];
	R_DKIM_ALLOW(-0.20)[cisco.com:s=iport01];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-304646-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[satishkh@cisco.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sebaddel@cisco.com,m:satishkh@cisco.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[satishkh@cisco.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[cisco.com:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cisco.com:from_mime,cisco.com:email,cisco.com:mid,cisco.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 74DAB704D14

The reset paths (enic_reset/enic_tx_hang_reset) tore down and re-opened
the V2 admin/MBOX channel only for the PF: the close/reopen was gated on
enic_sriov_enabled() && vf_type == ENIC_VF_TYPE_V2, which is never true on
a VF (vf_type is set only on the PF; VFs are identified by
enic_is_sriov_vf_v2()).  A VF-initiated reset therefore left the VF admin
QP wiped by the reset but never re-opened, and the VF never re-registered
with the PF, so VF<->PF MBOX traffic (link state, MAC, packet filter)
stopped working until the VF was re-probed.

Factor the decision into enic_has_admin_chan() (true for a V2 PF while
SR-IOV is enabled and for every V2 VF) and the reopen sequence into
enic_admin_chan_reopen().  For a VF the helper additionally re-runs the
probe-time handshake (enic_mbox_vf_capability_check() +
enic_mbox_vf_register()) so the PF learns about the VF again; for a PF it
re-pushes the current link state as before.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic_main.c | 105 +++++++++++++++++-----------
 1 file changed, 65 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index 99c06a049800..be3ae0a57af3 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -2171,6 +2171,57 @@ static void enic_set_api_busy(struct enic *enic, bool busy)
 	spin_unlock(&enic->enic_api_lock);
 }
 
+/* The admin/MBOX channel exists on a V2 PF while SR-IOV is enabled and on
+ * every V2 VF.  A reset wipes the admin WQ/RQ/CQ, so such devices must tear
+ * the channel down before the reset and re-establish it afterwards.
+ */
+static bool enic_has_admin_chan(struct enic *enic)
+{
+	return enic_is_sriov_vf_v2(enic) ||
+	       (enic_sriov_enabled(enic) && enic->vf_type == ENIC_VF_TYPE_V2);
+}
+
+/* Re-establish the admin/MBOX channel after a reset has re-created the data
+ * path.  Mirrors the relevant part of the probe / SR-IOV-enable sequence:
+ * reopen the channel and reinitialise MBOX, then for a VF re-run the PF
+ * handshake (its admin QP and PF-side registration were torn down by the
+ * reset), or for a PF re-push the current link state to registered VFs.
+ */
+static void enic_admin_chan_reopen(struct enic *enic)
+{
+	int err;
+
+	err = enic_admin_channel_open(enic);
+	if (err) {
+		netdev_err(enic->netdev,
+			   "admin channel reopen after reset failed: %d\n", err);
+		return;
+	}
+
+	enic_mbox_init(enic);
+
+	if (enic_is_sriov_vf_v2(enic)) {
+		err = enic_mbox_vf_capability_check(enic);
+		if (err) {
+			netdev_err(enic->netdev,
+				   "MBOX capability check after reset failed: %d\n",
+				   err);
+			return;
+		}
+		err = enic_mbox_vf_register(enic);
+		if (err)
+			netdev_err(enic->netdev,
+				   "MBOX VF re-registration after reset failed: %d\n",
+				   err);
+	} else {
+		/* The link came back up during enic_open() above while MBOX
+		 * sends were still disabled (channel not yet reopened), so that
+		 * link-notify was dropped.  Re-push current link state now.
+		 */
+		schedule_work(&enic->link_notify_work);
+	}
+}
+
 static void enic_reset(struct work_struct *work)
 {
 	struct enic *enic = container_of(work, struct enic, reset);
@@ -2189,8 +2240,7 @@ static void enic_reset(struct work_struct *work)
 	 * DMAs from the about-to-be-reset rings) and frees the admin resources
 	 * so they are cleanly re-allocated afterwards.
 	 */
-	if (enic_sriov_enabled(enic) &&
-	    enic->vf_type == ENIC_VF_TYPE_V2)
+	if (enic_has_admin_chan(enic))
 		enic_admin_channel_close(enic);
 
 	enic_stop(enic->netdev);
@@ -2204,25 +2254,13 @@ static void enic_reset(struct work_struct *work)
 
 	enic_open(enic->netdev);
 
-	/* Re-establish the admin/MBOX channel after the data path is back up,
-	 * mirroring the SR-IOV enable path (channel open + mbox init).  The
-	 * channel was fully torn down by enic_admin_channel_close() above.
+	/* Re-establish the admin/MBOX channel after the data path is back up.
+	 * It was fully torn down by enic_admin_channel_close() above;
+	 * enic_admin_chan_reopen() reopens it and, for a PF re-pushes link
+	 * state, or for a VF re-runs the probe-time PF handshake.
 	 */
-	if (enic_sriov_enabled(enic) &&
-	    enic->vf_type == ENIC_VF_TYPE_V2) {
-		if (enic_admin_channel_open(enic)) {
-			netdev_err(enic->netdev,
-				   "admin channel reopen after reset failed\n");
-		} else {
-			enic_mbox_init(enic);
-			/* The link came back up during enic_open() above
-			 * while MBOX sends were still disabled (channel not
-			 * yet reopened), so that link-notify was dropped.
-			 * Re-push current link state to registered VFs now.
-			 */
-			schedule_work(&enic->link_notify_work);
-		}
-	}
+	if (enic_has_admin_chan(enic))
+		enic_admin_chan_reopen(enic);
 
 	/* Allow infiniband to fiddle with the device again */
 	enic_set_api_busy(enic, false);
@@ -2245,8 +2283,7 @@ static void enic_tx_hang_reset(struct work_struct *work)
 	 * the same reason as the soft reset path: stop the admin QP and free
 	 * the admin resources before the hardware queues are wiped.
 	 */
-	if (enic_sriov_enabled(enic) &&
-	    enic->vf_type == ENIC_VF_TYPE_V2)
+	if (enic_has_admin_chan(enic))
 		enic_admin_channel_close(enic);
 
 	enic_dev_hang_notify(enic);
@@ -2261,25 +2298,13 @@ static void enic_tx_hang_reset(struct work_struct *work)
 
 	enic_open(enic->netdev);
 
-	/* Re-establish the admin/MBOX channel after the data path is back up,
-	 * mirroring the SR-IOV enable path (channel open + mbox init).  The
-	 * channel was fully torn down by enic_admin_channel_close() above.
+	/* Re-establish the admin/MBOX channel after the data path is back up.
+	 * It was fully torn down by enic_admin_channel_close() above;
+	 * enic_admin_chan_reopen() reopens it and, for a PF re-pushes link
+	 * state, or for a VF re-runs the probe-time PF handshake.
 	 */
-	if (enic_sriov_enabled(enic) &&
-	    enic->vf_type == ENIC_VF_TYPE_V2) {
-		if (enic_admin_channel_open(enic)) {
-			netdev_err(enic->netdev,
-				   "admin channel reopen after reset failed\n");
-		} else {
-			enic_mbox_init(enic);
-			/* The link came back up during enic_open() above
-			 * while MBOX sends were still disabled (channel not
-			 * yet reopened), so that link-notify was dropped.
-			 * Re-push current link state to registered VFs now.
-			 */
-			schedule_work(&enic->link_notify_work);
-		}
-	}
+	if (enic_has_admin_chan(enic))
+		enic_admin_chan_reopen(enic);
 
 	/* Allow infiniband to fiddle with the device again */
 	enic_set_api_busy(enic, false);

-- 
2.43.0


