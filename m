Return-Path: <netdev+bounces-271839-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yB/ONS/DxGku3QQAu9opvQ
	(envelope-from <netdev+bounces-271839-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 06:25:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC4532F5C5
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 06:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 369B030A8FE4
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 05:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B1D39DBC4;
	Thu, 26 Mar 2026 05:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fB2m3Fx6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5C3358381;
	Thu, 26 Mar 2026 05:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774502339; cv=none; b=qP6fCT93aJxufRQji8BpEpC/D9ptFg4rLtIyhG4hVTLc/INxFDG31PoaUbSvGe7L1DKG+RSoIDZ0ePHbpOprrnlrMD09x2F0fxXkPcY0GLWyRrFFIKR/a4gHxYGqxO9Pg4yuwJibGuFytqNEOvuwJC7P01hw+gPkKT1QtVvGXBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774502339; c=relaxed/simple;
	bh=DqwtVVfKBRtZG90awt3Hou5/bkkSaWRQy8JNg+A+L0k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gMOCKckBxo5xUPPir5hs7wWSZYE17fu6gKMu+W94Lu6HYgwKvGgEOlK2RE4880VbWRDnuqZO+bPb5MALSrB1W0pMWaM+f1NemrfAHUeSp2tDGBd7LmB/vvA5qksX0T/oXvaC6Z4df2Uoz1W0+wSEc8fsWqjTLG1CKe5nF0rI6SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fB2m3Fx6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78E47C2BCB5;
	Thu, 26 Mar 2026 05:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774502339;
	bh=DqwtVVfKBRtZG90awt3Hou5/bkkSaWRQy8JNg+A+L0k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fB2m3Fx6Bam1osAubW+SCM9REbC3zJETRa0/psToJB4Xofl0O2PYdyJLrfIBbeBfa
	 GYnVTgP+MJpNRIPSSg+vknTxEQPXg6ZWjLvubeEYacn5TEq8xaI6d9K1DvZ3NKQ/61
	 nDbPcoyxhvK1lnKjhJMZC9XoOHNMXA2H5TGlb+gdLkD4pCf4ViBVSYU7E6GFn49rYs
	 Cvr7Cwxkpw7VLfmSf7UO7+OmAO4MoF3q/AivWReNDhfzENPwJklFugsXksmrMIyStI
	 oBqqkzo8BO66lYkolix7ImT1wS35U3yDZ/RdVDfHXKkx75mRD/uqhIGatBaj52PJ8e
	 TNl/9EesTCF6w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F906109E54B;
	Thu, 26 Mar 2026 05:18:59 +0000 (UTC)
From: Satish Kharat via B4 Relay <devnull+satishkh.cisco.com@kernel.org>
Date: Wed, 25 Mar 2026 22:19:04 -0700
Subject: [PATCH net-next v2 6/6] enic: detect admin channel resources for
 SR-IOV
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-enic-sriov-v2-prep-v2-6-f72cf716ebfa@cisco.com>
References: <20260325-enic-sriov-v2-prep-v2-0-f72cf716ebfa@cisco.com>
In-Reply-To: <20260325-enic-sriov-v2-prep-v2-0-f72cf716ebfa@cisco.com>
To: Satish Kharat <satishkh@cisco.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774502338; l=2233;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=6gUIHgzzr9QVCSafrLsAZ7By14yZUVkLBmnYaiDR2i4=;
 b=v7GTUw7Kvzi5vlc2XcICGyia+rK8OidbGzAvrvW5RBuE1VWde3IFOyIh9G78zee/JGI549ClY
 APmSYeGiS2KCsHTtha+X2mqcf1GvhBsctsQ9Suxhi1/K5cBv/aVeGRl
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Endpoint-Received: by B4 Relay for satishkh@cisco.com/default with
 auth_id=639
X-Original-From: Satish Kharat <satishkh@cisco.com>
Reply-To: satishkh@cisco.com
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_MATCH_TO(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271839-lists,netdev=lfdr.de,satishkh.cisco.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[satishkh@cisco.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cisco.com:email,cisco.com:replyto,cisco.com:mid]
X-Rspamd-Queue-Id: 7BC4532F5C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Satish Kharat <satishkh@cisco.com>

Check for the presence of admin channel BAR resources
(RES_TYPE_ADMIN_WQ, ADMIN_RQ, ADMIN_CQ, SRIOV_INTR) during resource
discovery. Set has_admin_channel when all four are available.

Add admin WQ, RQ, CQ and INTR fields to struct enic for use by the
upcoming admin channel open/close paths.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic.h     |  7 +++++++
 drivers/net/ethernet/cisco/enic/enic_res.c | 11 +++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index 67fd780b1fa1..08472420f3a1 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -289,6 +289,13 @@ struct enic {
 	u8 rss_key[ENIC_RSS_LEN];
 	struct vnic_gen_stats gen_stats;
 	enum ext_cq ext_cq;
+
+	/* Admin channel resources for SR-IOV MBOX */
+	bool has_admin_channel;
+	struct vnic_wq admin_wq;
+	struct vnic_rq admin_rq;
+	struct vnic_cq admin_cq[2];
+	struct vnic_intr admin_intr;
 };
 
 static inline struct net_device *vnic_get_netdev(struct vnic_dev *vdev)
diff --git a/drivers/net/ethernet/cisco/enic/enic_res.c b/drivers/net/ethernet/cisco/enic/enic_res.c
index bbd3143ed73e..5ca3e5aec7f9 100644
--- a/drivers/net/ethernet/cisco/enic/enic_res.c
+++ b/drivers/net/ethernet/cisco/enic/enic_res.c
@@ -205,10 +205,17 @@ void enic_get_res_counts(struct enic *enic)
 	enic->cq_count = enic->cq_avail;
 	enic->intr_count = enic->intr_avail;
 
+	enic->has_admin_channel =
+		vnic_dev_get_res_count(enic->vdev, RES_TYPE_ADMIN_WQ) >= 1 &&
+		vnic_dev_get_res_count(enic->vdev, RES_TYPE_ADMIN_RQ) >= 1 &&
+		vnic_dev_get_res_count(enic->vdev, RES_TYPE_ADMIN_CQ) >= 1 &&
+		vnic_dev_get_res_count(enic->vdev, RES_TYPE_SRIOV_INTR) >= 1;
+
 	dev_info(enic_get_dev(enic),
-		"vNIC resources avail: wq %d rq %d cq %d intr %d\n",
+		"vNIC resources avail: wq %d rq %d cq %d intr %d admin %s\n",
 		enic->wq_avail, enic->rq_avail,
-		enic->cq_avail, enic->intr_avail);
+		enic->cq_avail, enic->intr_avail,
+		enic->has_admin_channel ? "yes" : "no");
 }
 
 void enic_init_vnic_resources(struct enic *enic)

-- 
2.43.0



