Return-Path: <netdev+bounces-302743-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2ycVIm2rQmr1/QkAu9opvQ
	(envelope-from <netdev+bounces-302743-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 19:29:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6241D6DDBB8
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 19:29:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cisco.com header.s=iport01 header.b=Rs7ekn3Q;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302743-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-302743-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=cisco.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 716533022B33
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 17:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E934779B0;
	Mon, 29 Jun 2026 17:26:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-3.cisco.com (rcdn-iport-3.cisco.com [173.37.86.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4922F47278B;
	Mon, 29 Jun 2026 17:26:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782753969; cv=none; b=O95pIeEJq13r5p1PFhKme6MiJ4i7/4yWxqgBOT26XGYTW8wNJGo63JWB5Mvakvg4qTVtuxYrwFW6jwoijz2KZsFN4jxQLiFUZ4bRLBnfKv5/GDbthO7E00IjWI5vPKF6ZOODd7kLty3OTNmVp+fAZtjkSp2uXUpaXpmyvG+cFe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782753969; c=relaxed/simple;
	bh=IoiORi5eBnz/sH/wNMiM6mZiKFrxcgsrmGy/JyHMrK8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e13BloMpzZuQSv1p1BTADS1cWGcgz09qMJUHuGLdrIhI1hHxL5x2/fHLdbjzJtr2cRi6gd28BC0saTXKw3sCdoycwmUkA4mkkm1t51Cj131WFT/CMULXy3z4jFCbvDcONi6g9I9THJ1z9njLcRFouz0b7i7oHL1+/DGqrNgPdwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=Rs7ekn3Q; arc=none smtp.client-ip=173.37.86.74
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=6579; q=dns/txt;
  s=iport01; t=1782753968; x=1783963568;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=AToEZlzjFh+iYoxWIVynTZtoBoB5EFk5itvXxODoVQY=;
  b=Rs7ekn3QlWVTIAwefz4HWcyNFVTQno613LdUKb570RBzBJdSvcoKd2mt
   RvBy/lL4fcvgpmixO/plW81VwcmkE1EJM9swWXC6mEtkQ8gY3foGonGTN
   YwKXL9HJF0mZG2En7BgJTpJpuYan465LYWICAOhNuVWzBjmVLN2q/0pck
   M5UDdg5PsMjW1t0Svdg9h1XEyXc6oyRHzgs57Obm91RnQp+T6/MGt5+q/
   ZKlsg0H7Uhc4aPaJUE66a61upWJY1PgY0G5bu4H7LGmbLhlhMfv+O570J
   FIiZXfQ0nI5cKtawCwKpUFgGiPL4VhBy1ISVazonObWPyKv8HA6768fcs
   Q==;
X-CSE-ConnectionGUID: dza89F0tRmmiR/BYjktw9g==
X-CSE-MsgGUID: 2hlGJpclSV+mAlV37LDTqw==
X-IPAS-Result: =?us-ascii?q?A0AmAABUqkJq/5D/Ja1aHQEBAQEJARIBBQUBgXwIAQsBg?=
 =?us-ascii?q?laBUkNJhFeIHIc3giGeHhSBag8BAQEPUQQBAYUGAo1LAiY0CQ4BAgQDAgMBA?=
 =?us-ascii?q?QEBAQEBAQEBAQsBAQUBAQECAQcFgQ4ThlyGWwIBAyMEUhAlAiYCAkYQBgESg?=
 =?us-ascii?q?wKCdAO4c3p/M4EB3kOBZgELFAGBCi4BhXCCagGBcIQGO4RBJxuBSUSBFYNph?=
 =?us-ascii?q?CqDdIJqBIMcEpEGCT+BAhwDWSwBVRMNCgsHBWFSMwMgCgsSEhgVAhQcEw8EF?=
 =?us-ascii?q?jIdcAwnEiwXNFgbBwWBHYEVLwQhgQSEfSMfAzl/gTB1WGYVMDWBER4KgVInA?=
 =?us-ascii?q?wsYDUgRLDcGDhsEPQFuB4xdFw+BTHEBPB00FGgzDoFmH5JEEYNtjV9rgTWfW?=
 =?us-ascii?q?oQngWagDwEyl2eTBZkII6Q3hGiBaDyBWTMaCBsVgyJTGQ+OLRYczD8nMj0BA?=
 =?us-ascii?q?QcCBw4DC4FokX0BAQ?=
IronPort-Data: A9a23:TC2uuqIlyK3d8neTFE+REZQlxSXFcZb7ZxGr2PjKsXjdYENS1TNVn
 GtLC23VOaveMzD8L40gPYrn/EIA6sSHzdQyT1Md+CA2RRqmiyZq6fd1j6vUF3nPRiEWZBs/t
 63yUvGZcoZsCCSa/kvxWlTYhSEU/bmSQbbhA/LzNCl0RAt1IA8skhsLd9QR2uaEuvDnRVnR0
 T/Oi5eHYgH9hWQlajt8B5+r8XuDgtyj4Fv0gXRmDRx7lAe2v2UYCpsZOZawIxPQKqFIHvS3T
 vr017qw+GXU5X8FUrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRuukoPD8fwXG8M49m/c3+d/
 /0W3XC4YV9B0qQhA43xWTEAe811FfUuFLMqvRFTvOTLp3AqfUcAzN1iHkhmbKNA5txyBGB0s
 tYpKjMRcUGM0rfeLLKTEoGAh+w5J8XteYdasXZ6wHSBUrAtQIvIROPB4towMDUY358VW62BI
 ZBENHw2MEiojx5nYj/7DLollfupnXn8cxVTqUmeouw85G27IAlZjeC3boePJYfVLSlTthyYo
 k3k52/9OS9ZMfWb92Ha1l6Qn/CayEsXX6pXTtVU7MVCjFSNy2k7BBQIWF6/pvelzEizR7p3J
 kAJ/yM8oLQa+0usQd3wGRa/pRasvQMWUvJTHvc85QXLzbDbiy6QAGQeQyECbtE6uMIobTg30
 FnPlNOBLSRmurCTSFqH+7uUpC/0Mi8QRUcGZCkZXU4G7sPlrYUbkB3CVJBgHbSzg9mzHiv/q
 xiMoTQyiqs7k8EGzeO48ErBjjbqoYLGJjPZ/S3NVW6jqwc8b4m/asnwth7Q7O1LK8CSSVzpU
 GU4pvVyJdsmVfml/BFhis1RdF11z55p6AHhvGM=
IronPort-HdrOrdr: A9a23:cMDweKqDDd4DOIFlN79pL+saV5rdeYIsimQD101hICG9vPbo8/
 xG+8576faUslgssR4b9OxoVJPrfZqYz+8W3WBzB9iftXfd2FdARbsKheDfKn/bak7DH4VmuZ
 uIHZIObeHYPBxWgdn35Q+gH81l4tWWmZrY/Nv2/jNBQR5nbqd44xw8MAaUFUVqWBJLbKBJcq
 Z0nvA3wAaISDAwctmxAGUDUqzoot3Gk4+jXDs9biRXkDVnSViTmcTH+9/y5GZkbw9y
X-Talos-CUID: =?us-ascii?q?9a23=3A8eO3vGr+0hV8iaW8ZSS+EKfmUcw3ey2M4i/MGUq?=
 =?us-ascii?q?9CFwuYoyXSkOPqawxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AI/4QUA3VYooCaLi+ncMvgOMvBTUjuaSqJ2IVmpE?=
 =?us-ascii?q?9hYqBHChOYGi5oAiuXdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.24,232,1774310400"; 
   d="scan'208";a="502652737"
Received: from rcdn-l-core-07.cisco.com ([173.37.255.144])
  by rcdn-iport-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 29 Jun 2026 17:26:07 +0000
Received: from [127.0.0.1] (unknown [10.25.130.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-07.cisco.com (Postfix) with ESMTPS id 0C3C418000210;
	Mon, 29 Jun 2026 17:26:06 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Mon, 29 Jun 2026 10:26:04 -0700
Subject: [PATCH net-next v10 12/12] enic: re-establish V2 VF admin channel
 and PF registration after reset
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-enic-sriov-v2-admin-channel-v2-v10-12-62569af83417@cisco.com>
References: <20260629-enic-sriov-v2-admin-channel-v2-v10-0-62569af83417@cisco.com>
In-Reply-To: <20260629-enic-sriov-v2-admin-channel-v2-v10-0-62569af83417@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sesidhar Baddela <sebaddel@cisco.com>, Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782753956; l=6769;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=IoiORi5eBnz/sH/wNMiM6mZiKFrxcgsrmGy/JyHMrK8=;
 b=lsYiZnj2ZR5+tGBAezVxWUJL1O5mJiwTuTQCBwMNljgClXOqoXpYIhsH2xl/Ki9MF/l+ZLS5X
 BAJ00bx+KEuCZLsr4QiOubZ7oXDlOBI4f1gvqlbO3RRMdD5TtkRnzTL
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.130.254];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.130.254, [10.25.130.254]
X-Outbound-Node: rcdn-l-core-07.cisco.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[cisco.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cisco.com,reject];
	R_DKIM_ALLOW(-0.20)[cisco.com:s=iport01];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-302743-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,cisco.com:dkim,cisco.com:email,cisco.com:mid,cisco.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6241D6DDBB8

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
index abb30e5457c1..de90332dc40c 100644
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


