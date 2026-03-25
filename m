Return-Path: <netdev+bounces-271430-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6M8qHaGNw2lVrgQAu9opvQ
	(envelope-from <netdev+bounces-271430-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 08:24:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E57C8320A7B
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 08:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DDE4730A422F
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 07:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6A9371CE4;
	Wed, 25 Mar 2026 07:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5Y+QVg4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25F83644D1;
	Wed, 25 Mar 2026 07:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774423300; cv=none; b=MquDnsCl0O4Z4FKy/pcQhyCEhe6Zndat/pErghpN3ayT0MD1vrHVHAYfMBcOxlbYlQFI8NRQZYXYidNPtW984yHo3FeJpEEywmgsclmQzoxogmoK0Lwu16C/hZ+yrEJ87KbClAJvTTgj7tB3FjYgEnWX7cdms8vClcKjAQuHdiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774423300; c=relaxed/simple;
	bh=WXpYpK3yhKn2sm0AMqrjWN6OL03+heVozAsWmGdd/6M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LHKASRWkVgP0HXxkp+r6WnUMdkufKfWz8992wEHtZ/BEvd4gVxffEqh1NtCRBh3d0yJ6TtRnFm+VQV02/11HYW3C27ACzVHyokcE3/HGAWQxjeJlaW2A9GnifFlYN2Gw1r6GoabU2qKrHAR+Uhl2cVioMbW2R9301sTTL4YaKxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5Y+QVg4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6ADEC4CEF7;
	Wed, 25 Mar 2026 07:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774423299;
	bh=WXpYpK3yhKn2sm0AMqrjWN6OL03+heVozAsWmGdd/6M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=K5Y+QVg48C6sTD5VhylNCumbRBFL/HIz4uDGG4j1A2ATtRMUrs6tGDof8OG9Rx8qY
	 46lhaFeg4YUqdpBIKfEO0ihv25siufzxcPXSbHvxGwq9Ydvon2jU8hyRzPYUu1S9pc
	 PuTAw34NvP7sIFWHio8y0d+yUeWk1Dc1vhJ/NAhoZZgpJqgfWHR++KQ7sde1JgggGd
	 YULKuFJl8DybMeszXIH1GQxEc+k8GvT9zrTZxxEZ2+EwK/MdM3VxF8rLZ1NOxjqGof
	 l0kZPaEITH/k/iHGWktQQvX9AUp5DT5EQffdAD+2kBLfTLZsBHjLuHou3doOL4lHsa
	 OVi4e1ba4Znnw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0592FEA822;
	Wed, 25 Mar 2026 07:21:39 +0000 (UTC)
From: Satish Kharat via B4 Relay <devnull+satishkh.cisco.com@kernel.org>
Date: Wed, 25 Mar 2026 00:21:43 -0700
Subject: [PATCH net-next 5/6] enic: add type-aware alloc for WQ, RQ, CQ and
 INTR resources
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-enic-sriov-v2-prep-v1-5-48f04ce110cc@cisco.com>
References: <20260325-enic-sriov-v2-prep-v1-0-48f04ce110cc@cisco.com>
In-Reply-To: <20260325-enic-sriov-v2-prep-v1-0-48f04ce110cc@cisco.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774423298; l=10146;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=sStTy9Bg8r3IiBcBVUP3bIWBVt484dhT5KCgXRyPs1c=;
 b=QmD2EUolDeDfroPNN0AARXNneDqrQo9YfHCPbPow6gBiHnATdgZF4W36W1FKR3pPTSJKekLOZ
 8JiMI9ACvm8DZsRjSdHuzK9IYQOeKslnk5cygrxOr66s3HCEVw2C8g4
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Endpoint-Received: by B4 Relay for satishkh@cisco.com/default with
 auth_id=639
X-Original-From: Satish Kharat <satishkh@cisco.com>
Reply-To: satishkh@cisco.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271430-lists,netdev=lfdr.de,satishkh.cisco.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	HAS_REPLYTO(0.00)[satishkh@cisco.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cisco.com:email,cisco.com:replyto,cisco.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E57C8320A7B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Satish Kharat <satishkh@cisco.com>

The existing vnic_wq_alloc(), vnic_rq_alloc(), vnic_cq_alloc() and
vnic_intr_alloc() hardcode data-path resource types (RES_TYPE_WQ,
RES_TYPE_RQ, RES_TYPE_CQ, RES_TYPE_INTR_CTRL). The upcoming admin
channel uses different BAR resource types (RES_TYPE_ADMIN_WQ/RQ/CQ,
RES_TYPE_SRIOV_INTR) for its queues.

Add _with_type() variants that accept an explicit resource type
parameter. Refactor the original functions as thin wrappers that
pass the default data-path type. No functional change.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/vnic_cq.c   | 14 +++++++++++---
 drivers/net/ethernet/cisco/enic/vnic_cq.h   |  3 +++
 drivers/net/ethernet/cisco/enic/vnic_intr.c | 12 +++++++++---
 drivers/net/ethernet/cisco/enic/vnic_intr.h |  2 ++
 drivers/net/ethernet/cisco/enic/vnic_rq.c   | 14 +++++++++++---
 drivers/net/ethernet/cisco/enic/vnic_rq.h   |  3 +++
 drivers/net/ethernet/cisco/enic/vnic_wq.c   | 14 +++++++++++---
 drivers/net/ethernet/cisco/enic/vnic_wq.h   |  3 +++
 8 files changed, 53 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/vnic_cq.c b/drivers/net/ethernet/cisco/enic/vnic_cq.c
index 27c885e91552..5a0dbb816223 100644
--- a/drivers/net/ethernet/cisco/enic/vnic_cq.c
+++ b/drivers/net/ethernet/cisco/enic/vnic_cq.c
@@ -20,13 +20,14 @@ void vnic_cq_free(struct vnic_cq *cq)
 	cq->ctrl = NULL;
 }
 
-int vnic_cq_alloc(struct vnic_dev *vdev, struct vnic_cq *cq, unsigned int index,
-	unsigned int desc_count, unsigned int desc_size)
+int vnic_cq_alloc_with_type(struct vnic_dev *vdev, struct vnic_cq *cq,
+			    unsigned int index, unsigned int desc_count,
+			    unsigned int desc_size, unsigned int res_type)
 {
 	cq->index = index;
 	cq->vdev = vdev;
 
-	cq->ctrl = vnic_dev_get_res(vdev, RES_TYPE_CQ, index);
+	cq->ctrl = vnic_dev_get_res(vdev, res_type, index);
 	if (!cq->ctrl) {
 		vdev_err(vdev, "Failed to hook CQ[%d] resource\n", index);
 		return -EINVAL;
@@ -35,6 +36,13 @@ int vnic_cq_alloc(struct vnic_dev *vdev, struct vnic_cq *cq, unsigned int index,
 	return vnic_dev_alloc_desc_ring(vdev, &cq->ring, desc_count, desc_size);
 }
 
+int vnic_cq_alloc(struct vnic_dev *vdev, struct vnic_cq *cq, unsigned int index,
+		  unsigned int desc_count, unsigned int desc_size)
+{
+	return vnic_cq_alloc_with_type(vdev, cq, index, desc_count, desc_size,
+				       RES_TYPE_CQ);
+}
+
 void vnic_cq_init(struct vnic_cq *cq, unsigned int flow_control_enable,
 	unsigned int color_enable, unsigned int cq_head, unsigned int cq_tail,
 	unsigned int cq_tail_color, unsigned int interrupt_enable,
diff --git a/drivers/net/ethernet/cisco/enic/vnic_cq.h b/drivers/net/ethernet/cisco/enic/vnic_cq.h
index 0e37f5d5e527..d46d4d2ef6bb 100644
--- a/drivers/net/ethernet/cisco/enic/vnic_cq.h
+++ b/drivers/net/ethernet/cisco/enic/vnic_cq.h
@@ -73,6 +73,9 @@ static inline void vnic_cq_inc_to_clean(struct vnic_cq *cq)
 void vnic_cq_free(struct vnic_cq *cq);
 int vnic_cq_alloc(struct vnic_dev *vdev, struct vnic_cq *cq, unsigned int index,
 	unsigned int desc_count, unsigned int desc_size);
+int vnic_cq_alloc_with_type(struct vnic_dev *vdev, struct vnic_cq *cq,
+			    unsigned int index, unsigned int desc_count,
+			    unsigned int desc_size, unsigned int res_type);
 void vnic_cq_init(struct vnic_cq *cq, unsigned int flow_control_enable,
 	unsigned int color_enable, unsigned int cq_head, unsigned int cq_tail,
 	unsigned int cq_tail_color, unsigned int interrupt_enable,
diff --git a/drivers/net/ethernet/cisco/enic/vnic_intr.c b/drivers/net/ethernet/cisco/enic/vnic_intr.c
index 25319f072a04..010ad8c2108d 100644
--- a/drivers/net/ethernet/cisco/enic/vnic_intr.c
+++ b/drivers/net/ethernet/cisco/enic/vnic_intr.c
@@ -19,13 +19,13 @@ void vnic_intr_free(struct vnic_intr *intr)
 	intr->ctrl = NULL;
 }
 
-int vnic_intr_alloc(struct vnic_dev *vdev, struct vnic_intr *intr,
-	unsigned int index)
+int vnic_intr_alloc_with_type(struct vnic_dev *vdev, struct vnic_intr *intr,
+			      unsigned int index, unsigned int res_type)
 {
 	intr->index = index;
 	intr->vdev = vdev;
 
-	intr->ctrl = vnic_dev_get_res(vdev, RES_TYPE_INTR_CTRL, index);
+	intr->ctrl = vnic_dev_get_res(vdev, res_type, index);
 	if (!intr->ctrl) {
 		vdev_err(vdev, "Failed to hook INTR[%d].ctrl resource\n",
 			 index);
@@ -35,6 +35,12 @@ int vnic_intr_alloc(struct vnic_dev *vdev, struct vnic_intr *intr,
 	return 0;
 }
 
+int vnic_intr_alloc(struct vnic_dev *vdev, struct vnic_intr *intr,
+		    unsigned int index)
+{
+	return vnic_intr_alloc_with_type(vdev, intr, index, RES_TYPE_INTR_CTRL);
+}
+
 void vnic_intr_init(struct vnic_intr *intr, u32 coalescing_timer,
 	unsigned int coalescing_type, unsigned int mask_on_assertion)
 {
diff --git a/drivers/net/ethernet/cisco/enic/vnic_intr.h b/drivers/net/ethernet/cisco/enic/vnic_intr.h
index 33a72aa10b26..2bc2dbffdb80 100644
--- a/drivers/net/ethernet/cisco/enic/vnic_intr.h
+++ b/drivers/net/ethernet/cisco/enic/vnic_intr.h
@@ -89,6 +89,8 @@ static inline u32 vnic_intr_legacy_pba(u32 __iomem *legacy_pba)
 void vnic_intr_free(struct vnic_intr *intr);
 int vnic_intr_alloc(struct vnic_dev *vdev, struct vnic_intr *intr,
 	unsigned int index);
+int vnic_intr_alloc_with_type(struct vnic_dev *vdev, struct vnic_intr *intr,
+			      unsigned int index, unsigned int res_type);
 void vnic_intr_init(struct vnic_intr *intr, u32 coalescing_timer,
 	unsigned int coalescing_type, unsigned int mask_on_assertion);
 void vnic_intr_coalescing_timer_set(struct vnic_intr *intr,
diff --git a/drivers/net/ethernet/cisco/enic/vnic_rq.c b/drivers/net/ethernet/cisco/enic/vnic_rq.c
index 5ae80551f17c..a662d9fd1199 100644
--- a/drivers/net/ethernet/cisco/enic/vnic_rq.c
+++ b/drivers/net/ethernet/cisco/enic/vnic_rq.c
@@ -69,15 +69,16 @@ void vnic_rq_free(struct vnic_rq *rq)
 	rq->ctrl = NULL;
 }
 
-int vnic_rq_alloc(struct vnic_dev *vdev, struct vnic_rq *rq, unsigned int index,
-	unsigned int desc_count, unsigned int desc_size)
+int vnic_rq_alloc_with_type(struct vnic_dev *vdev, struct vnic_rq *rq,
+			    unsigned int index, unsigned int desc_count,
+			    unsigned int desc_size, unsigned int res_type)
 {
 	int err;
 
 	rq->index = index;
 	rq->vdev = vdev;
 
-	rq->ctrl = vnic_dev_get_res(vdev, RES_TYPE_RQ, index);
+	rq->ctrl = vnic_dev_get_res(vdev, res_type, index);
 	if (!rq->ctrl) {
 		vdev_err(vdev, "Failed to hook RQ[%d] resource\n", index);
 		return -EINVAL;
@@ -98,6 +99,13 @@ int vnic_rq_alloc(struct vnic_dev *vdev, struct vnic_rq *rq, unsigned int index,
 	return 0;
 }
 
+int vnic_rq_alloc(struct vnic_dev *vdev, struct vnic_rq *rq, unsigned int index,
+		  unsigned int desc_count, unsigned int desc_size)
+{
+	return vnic_rq_alloc_with_type(vdev, rq, index, desc_count, desc_size,
+				       RES_TYPE_RQ);
+}
+
 static void vnic_rq_init_start(struct vnic_rq *rq, unsigned int cq_index,
 	unsigned int fetch_index, unsigned int posted_index,
 	unsigned int error_interrupt_enable,
diff --git a/drivers/net/ethernet/cisco/enic/vnic_rq.h b/drivers/net/ethernet/cisco/enic/vnic_rq.h
index a1cdd729caec..9fc2090eac44 100644
--- a/drivers/net/ethernet/cisco/enic/vnic_rq.h
+++ b/drivers/net/ethernet/cisco/enic/vnic_rq.h
@@ -196,6 +196,9 @@ static inline int vnic_rq_fill(struct vnic_rq *rq,
 void vnic_rq_free(struct vnic_rq *rq);
 int vnic_rq_alloc(struct vnic_dev *vdev, struct vnic_rq *rq, unsigned int index,
 	unsigned int desc_count, unsigned int desc_size);
+int vnic_rq_alloc_with_type(struct vnic_dev *vdev, struct vnic_rq *rq,
+			    unsigned int index, unsigned int desc_count,
+			    unsigned int desc_size, unsigned int res_type);
 void vnic_rq_init(struct vnic_rq *rq, unsigned int cq_index,
 	unsigned int error_interrupt_enable,
 	unsigned int error_interrupt_offset);
diff --git a/drivers/net/ethernet/cisco/enic/vnic_wq.c b/drivers/net/ethernet/cisco/enic/vnic_wq.c
index 29c7900349b2..5a20bdc62141 100644
--- a/drivers/net/ethernet/cisco/enic/vnic_wq.c
+++ b/drivers/net/ethernet/cisco/enic/vnic_wq.c
@@ -72,15 +72,16 @@ void vnic_wq_free(struct vnic_wq *wq)
 	wq->ctrl = NULL;
 }
 
-int vnic_wq_alloc(struct vnic_dev *vdev, struct vnic_wq *wq, unsigned int index,
-	unsigned int desc_count, unsigned int desc_size)
+int vnic_wq_alloc_with_type(struct vnic_dev *vdev, struct vnic_wq *wq,
+			    unsigned int index, unsigned int desc_count,
+			    unsigned int desc_size, unsigned int res_type)
 {
 	int err;
 
 	wq->index = index;
 	wq->vdev = vdev;
 
-	wq->ctrl = vnic_dev_get_res(vdev, RES_TYPE_WQ, index);
+	wq->ctrl = vnic_dev_get_res(vdev, res_type, index);
 	if (!wq->ctrl) {
 		vdev_err(vdev, "Failed to hook WQ[%d] resource\n", index);
 		return -EINVAL;
@@ -101,6 +102,13 @@ int vnic_wq_alloc(struct vnic_dev *vdev, struct vnic_wq *wq, unsigned int index,
 	return 0;
 }
 
+int vnic_wq_alloc(struct vnic_dev *vdev, struct vnic_wq *wq, unsigned int index,
+		  unsigned int desc_count, unsigned int desc_size)
+{
+	return vnic_wq_alloc_with_type(vdev, wq, index, desc_count, desc_size,
+				       RES_TYPE_WQ);
+}
+
 int enic_wq_devcmd2_alloc(struct vnic_dev *vdev, struct vnic_wq *wq,
 			  unsigned int desc_count, unsigned int desc_size)
 {
diff --git a/drivers/net/ethernet/cisco/enic/vnic_wq.h b/drivers/net/ethernet/cisco/enic/vnic_wq.h
index 3bb4758100ba..1d448b7a9ba2 100644
--- a/drivers/net/ethernet/cisco/enic/vnic_wq.h
+++ b/drivers/net/ethernet/cisco/enic/vnic_wq.h
@@ -165,6 +165,9 @@ static inline void vnic_wq_service(struct vnic_wq *wq,
 void vnic_wq_free(struct vnic_wq *wq);
 int vnic_wq_alloc(struct vnic_dev *vdev, struct vnic_wq *wq, unsigned int index,
 	unsigned int desc_count, unsigned int desc_size);
+int vnic_wq_alloc_with_type(struct vnic_dev *vdev, struct vnic_wq *wq,
+			    unsigned int index, unsigned int desc_count,
+			    unsigned int desc_size, unsigned int res_type);
 void vnic_wq_init(struct vnic_wq *wq, unsigned int cq_index,
 	unsigned int error_interrupt_enable,
 	unsigned int error_interrupt_offset);

-- 
2.43.0



