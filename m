Return-Path: <netdev+bounces-276628-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMjbHQ2E1mmwFwgAu9opvQ
	(envelope-from <netdev+bounces-276628-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 18:36:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E639C3BEE84
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 18:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 843FF300B987
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 16:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919333D3322;
	Wed,  8 Apr 2026 16:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPSrBdTy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBAB3D1CCC;
	Wed,  8 Apr 2026 16:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775666185; cv=none; b=isCCNmE1L/4LBfs8AMvprnZtps2dg5PUycOCqnAljoekXe2MxVdMVfufqN284dVdK0VWyx4I9KV+dOLTHW7MAaVvU3WyizWbsCdLc/bxkfaGSnRINew5cdj2ba2Ik+PjI+2wy1yA1b/FvnJBSQEtdO88bbKXlXpV0H55n38JsZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775666185; c=relaxed/simple;
	bh=pSMej5vYrEDi0xh0yV9bJSxjZFllzDT7LgVuembtc00=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TolLPFgT5nl66RrTAdKudTwofkwGJyk2MoFFDqdkTQb/m+LTsnAXtsAV7Fo5Hm2mXE7MzxZ7xKmhF2nY/c1Rv/v7mpZYzciVJUXpzbSYV66usaGkW57Ekj1DZXJYx/IaFxna9xHv/T4Ftqo8kECYPpN1Ix9uV/TgwWy7pyvXlsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPSrBdTy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9E89C2BC87;
	Wed,  8 Apr 2026 16:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775666185;
	bh=pSMej5vYrEDi0xh0yV9bJSxjZFllzDT7LgVuembtc00=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BPSrBdTyeMOdN5RwOGdJ+dqI3d3sDEKuAiYw3KbgWmoGzpHgzhCKoFWruHZmiJB5o
	 bhiQ5ajM0xN4VF44Cqt7dNs/Bev8SKQMmG+y3xqt6v72MQp+zGc09OeH1kuYzRzTxo
	 K0CxSR7rIEVLt9p5U8j2EU6MCZTV+yv4PS4f/DjV34/LEEDwOZLVuvA6Ypn+qsjif4
	 CgAoUTnIQSzah8urRJUzTi+Drru9mp3Rmqufdmr7Au6K/KHdoKoh9wvmsknDjpPR2Q
	 5/hX67h2BuPZUDkh7QAsI7PzYsE1Weil2ceDlVy1UGpbM4vDW/zFTxIzEKEGkrXDJg
	 j83cvMtVq8PFA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E4E10F995A;
	Wed,  8 Apr 2026 16:36:24 +0000 (UTC)
From: Satish Kharat via B4 Relay <devnull+satishkh.cisco.com@kernel.org>
Date: Wed, 08 Apr 2026 09:36:22 -0700
Subject: [PATCH net-next v3 01/10] enic: verify firmware supports V2 SR-IOV
 at probe time
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-enic-sriov-v2-admin-channel-v2-v3-1-1d4999a03cec@cisco.com>
References: <20260408-enic-sriov-v2-admin-channel-v2-v3-0-1d4999a03cec@cisco.com>
In-Reply-To: <20260408-enic-sriov-v2-admin-channel-v2-v3-0-1d4999a03cec@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 20260401-enic-sriov-v2-prep-v4-0-d5834b2ef1b9@cisco.com, 
 Satish Kharat <satishkh@cisco.com>, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775666183; l=2531;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=bW4tqPiVbykt8E1AO6HaOo6t5TPoHN2weYduT38tfLQ=;
 b=BMNnaZ78N7AlI2U108Y696+XyXFqqWeHsVyxu6SqMvOcdqegR3lkpRcrnspKQnjD95N+LfPIg
 50OoVSRuI9ACvfyQNNsRPzCqUolFkxVU9ejE/lDFXTsw8a7cnoGpWYk
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Endpoint-Received: by B4 Relay for satishkh@cisco.com/default with
 auth_id=639
X-Original-From: Satish Kharat <satishkh@cisco.com>
Reply-To: satishkh@cisco.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276628-lists,netdev=lfdr.de,satishkh.cisco.com];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[satishkh@cisco.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cisco.com:email,cisco.com:replyto,cisco.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E639C3BEE84
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Satish Kharat <satishkh@cisco.com>

During PF probe, query the firmware get-supported-feature interface
to verify that the running firmware supports V2 SR-IOV. Firmware
version 5.3(4.72) and later report VIC_FEATURE_SRIOV via
CMD_GET_SUPP_FEATURE_VER. If the firmware does not support the
feature, set vf_type to ENIC_VF_TYPE_NONE and log a warning so the
admin knows a firmware upgrade is needed.

The VIC_FEATURE_SRIOV enum value (4) matches the firmware ABI. A
placeholder entry (VIC_FEATURE_PTP at position 3) is added to keep
the enum in sync with firmware's feature numbering.

Suggested-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic_main.c   | 19 +++++++++++++++++++
 drivers/net/ethernet/cisco/enic/vnic_devcmd.h |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index e7125b818087..73bb59eef7a0 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -2641,8 +2641,10 @@ static void enic_iounmap(struct enic *enic)
 static void enic_sriov_detect_vf_type(struct enic *enic)
 {
 	struct pci_dev *pdev = enic->pdev;
+	u64 supported_versions, a1 = 0;
 	int pos;
 	u16 vf_dev_id;
+	int err;
 
 	if (enic_is_sriov_vf(enic) || enic_is_dynamic(enic))
 		return;
@@ -2669,6 +2671,23 @@ static void enic_sriov_detect_vf_type(struct enic *enic)
 		enic->vf_type = ENIC_VF_TYPE_NONE;
 		break;
 	}
+
+	if (enic->vf_type != ENIC_VF_TYPE_V2)
+		return;
+
+	/* A successful command means firmware recognizes
+	 * VIC_FEATURE_SRIOV; supported_versions is available
+	 * for sub-feature versioning in the future.
+	 */
+	err = vnic_dev_get_supported_feature_ver(enic->vdev,
+						 VIC_FEATURE_SRIOV,
+						 &supported_versions,
+						 &a1);
+	if (err) {
+		dev_warn(&pdev->dev,
+			 "SR-IOV V2 not supported by current firmware. Upgrade to VIC FW 5.3(4.72) or higher.\n");
+		enic->vf_type = ENIC_VF_TYPE_NONE;
+	}
 }
 #endif
 
diff --git a/drivers/net/ethernet/cisco/enic/vnic_devcmd.h b/drivers/net/ethernet/cisco/enic/vnic_devcmd.h
index 605ef17f967e..7a4bce736105 100644
--- a/drivers/net/ethernet/cisco/enic/vnic_devcmd.h
+++ b/drivers/net/ethernet/cisco/enic/vnic_devcmd.h
@@ -734,6 +734,8 @@ enum vic_feature_t {
 	VIC_FEATURE_VXLAN,
 	VIC_FEATURE_RDMA,
 	VIC_FEATURE_VXLAN_PATCH,
+	VIC_FEATURE_PTP,
+	VIC_FEATURE_SRIOV,
 	VIC_FEATURE_MAX,
 };
 

-- 
2.43.0



