Return-Path: <netdev+bounces-170475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10832A48D62
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 01:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C12B716F438
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 00:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451A4187859;
	Fri, 28 Feb 2025 00:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1zWxrGl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31DF28DD0;
	Fri, 28 Feb 2025 00:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740702542; cv=none; b=h5RHnrc88ac/qzb8HPqm+hQAEh5WQkpqCVVZouezc+d5TJaR9t/lW+Um/dPNwuOSDxpLVZUAVqDPdtldSJF9BxDVqiNB3a+GKcs5rn+K99e4Jucu/nRkAlc30JrzitNytqMggMAheUB8lRVeQBnwLwIwBqhYKKneRy7Zw5m8Fo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740702542; c=relaxed/simple;
	bh=NsY29KM8qQTeChFpSPoCssap1GnyJX+lxtAgVW2qX7s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kQt60NJpnUYVRBezJnEMADozgwrTw/eZAxWcyukRy3ekcuK0lxSWki3sKzZi2TMM2QNvh9P+/ZjMTM8VesrsBLXdZPIH1CKfHRqSAB5dUqqlmM8M2srlifOsZKRx3CorQUYoCwP0sjHPEzhYuIjjHuijqR/jb2cCCYNYz6DrDWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1zWxrGl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6BBDCC4CEF2;
	Fri, 28 Feb 2025 00:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740702542;
	bh=NsY29KM8qQTeChFpSPoCssap1GnyJX+lxtAgVW2qX7s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=X1zWxrGlP0LTN9Bw4cHhQHH9BPaj50ZWfPTNIgjUCA96k3x//DqqQV/e7Iks8uxc2
	 AXe9c+88Ht+6+agTWQXgsXYc9qkmx6rS54Pl0C4qFdbigzcGF9hUbC/cEztpatAGij
	 cPzUeQBJhbd5z1GHAxdXfnvPKQW/1ei4piCU6WV4xe62LHwhGq4zCcO7jGMlqrSFcm
	 p0Hpv+xcu48urGxbqb5t5q78CEFgaBwAW9s9CRsK86wIJkTzrZ0AgL8Ux8k8dMYRgS
	 7H6ZgsKiDtJycUub3QhiieR2uhU5JQ52FeuHtzD9gOLGpVqzqMwN7BaFkOM8iEwNEc
	 DTLMpacRAaDsQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61717C282C5;
	Fri, 28 Feb 2025 00:29:02 +0000 (UTC)
From: Satish Kharat via B4 Relay <devnull+satishkh.cisco.com@kernel.org>
Date: Thu, 27 Feb 2025 19:30:50 -0500
Subject: [PATCH 7/8] enic : cleanup of enic wq request completion path
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-enic_cleanup_and_ext_cq-v1-7-c314f95812bb@cisco.com>
References: <20250227-enic_cleanup_and_ext_cq-v1-0-c314f95812bb@cisco.com>
In-Reply-To: <20250227-enic_cleanup_and_ext_cq-v1-0-c314f95812bb@cisco.com>
To: Christian Benvenuti <benve@cisco.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Satish Kharat <satishkh@cisco.com>, Nelson Escobar <neescoba@cisco.com>, 
 John Daley <johndale@cisco.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740702696; l=7262;
 i=satishkh@cisco.com; s=20250226; h=from:subject:message-id;
 bh=1sczjSBdRA3aypx3Bqw397yw73Gn6lT/RmBkFM9Qsq4=;
 b=S+2we0MzlHBtbMJAKz/mOZW0ApUFVBIoGksFzT8Ga0CfCYnVMQC5330ULP4q+pMql0LT24YZE
 RSf5SnhA9L/Ac/cVu8XAkxbc9uwS39Nj4ZemnqglKGxb/YwtH5SDgQX
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=lkxzORFYn5ejiy0kzcsfkpGoXZDcnHMc4n3YK7jJnJo=
X-Endpoint-Received: by B4 Relay for satishkh@cisco.com/20250226 with
 auth_id=351
X-Original-From: Satish Kharat <satishkh@cisco.com>
Reply-To: satishkh@cisco.com

From: Satish Kharat <satishkh@cisco.com>

Cleans up the enic wq request completion path needed for 16k wq size
support.

Co-developed-by: Nelson Escobar <neescoba@cisco.com>
Signed-off-by: Nelson Escobar <neescoba@cisco.com>
Co-developed-by: John Daley <johndale@cisco.com>
Signed-off-by: John Daley <johndale@cisco.com>
Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic_main.c |  7 +--
 drivers/net/ethernet/cisco/enic/enic_wq.c   | 98 +++++++++++++++--------------
 drivers/net/ethernet/cisco/enic/enic_wq.h   |  9 +--
 3 files changed, 55 insertions(+), 59 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index 52174843f02f1fecc75666367ad5034cbbcf8f07..54aa3953bf7b6ed4fdadd7b9871ee7bbcf6614ea 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -1332,8 +1332,7 @@ static int enic_poll(struct napi_struct *napi, int budget)
 	unsigned int  work_done, rq_work_done = 0, wq_work_done;
 	int err;
 
-	wq_work_done = vnic_cq_service(&enic->cq[cq_wq], wq_work_to_do,
-				       enic_wq_service, NULL);
+	wq_work_done = enic_wq_cq_service(enic, cq_wq, wq_work_to_do);
 
 	if (budget > 0)
 		rq_work_done = enic_rq_cq_service(enic, cq_rq, rq_work_to_do);
@@ -1435,8 +1434,8 @@ static int enic_poll_msix_wq(struct napi_struct *napi, int budget)
 	wq_irq = wq->index;
 	cq = enic_cq_wq(enic, wq_irq);
 	intr = enic_msix_wq_intr(enic, wq_irq);
-	wq_work_done = vnic_cq_service(&enic->cq[cq], wq_work_to_do,
-				       enic_wq_service, NULL);
+
+	wq_work_done = enic_wq_cq_service(enic, cq, wq_work_to_do);
 
 	vnic_intr_return_credits(&enic->intr[intr], wq_work_done,
 				 0 /* don't unmask intr */,
diff --git a/drivers/net/ethernet/cisco/enic/enic_wq.c b/drivers/net/ethernet/cisco/enic/enic_wq.c
index 88fdc462839a8360000eb8526be64118ea35c0e2..37e8f6eeae3fabd3391b8fcacc5f3420ad091b17 100644
--- a/drivers/net/ethernet/cisco/enic/enic_wq.c
+++ b/drivers/net/ethernet/cisco/enic/enic_wq.c
@@ -6,8 +6,12 @@
 #include "enic.h"
 #include "enic_wq.h"
 
-static void cq_desc_dec(const struct cq_desc *desc_arg, u8 *type, u8 *color,
-			u16 *q_number, u16 *completed_index)
+#define ENET_CQ_DESC_COMP_NDX_BITS 14
+#define ENET_CQ_DESC_COMP_NDX_MASK GENMASK(ENET_CQ_DESC_COMP_NDX_BITS - 1, 0)
+
+static inline void enic_wq_cq_desc_dec(const struct cq_desc *desc_arg, bool ext_wq,
+				       u8 *type, u8 *color, u16 *q_number,
+				       u16 *completed_index)
 {
 	const struct cq_desc *desc = desc_arg;
 	const u8 type_color = desc->type_color;
@@ -25,47 +29,13 @@ static void cq_desc_dec(const struct cq_desc *desc_arg, u8 *type, u8 *color,
 
 	*type = type_color & CQ_DESC_TYPE_MASK;
 	*q_number = le16_to_cpu(desc->q_number) & CQ_DESC_Q_NUM_MASK;
-	*completed_index = le16_to_cpu(desc->completed_index) &
-		CQ_DESC_COMP_NDX_MASK;
-}
-
-unsigned int vnic_cq_service(struct vnic_cq *cq, unsigned int work_to_do,
-			     int (*q_service)(struct vnic_dev *vdev, struct cq_desc *cq_desc,
-					      u8 type, u16 q_number, u16 completed_index,
-					      void *opaque), void *opaque)
-{
-	struct cq_desc *cq_desc;
-	unsigned int work_done = 0;
-	u16 q_number, completed_index;
-	u8 type, color;
 
-	cq_desc = (struct cq_desc *)((u8 *)cq->ring.descs +
-		   cq->ring.desc_size * cq->to_clean);
-	cq_desc_dec(cq_desc, &type, &color,
-		    &q_number, &completed_index);
-
-	while (color != cq->last_color) {
-		if ((*q_service)(cq->vdev, cq_desc, type, q_number,
-				 completed_index, opaque))
-			break;
-
-		cq->to_clean++;
-		if (cq->to_clean == cq->ring.desc_count) {
-			cq->to_clean = 0;
-			cq->last_color = cq->last_color ? 0 : 1;
-		}
-
-		cq_desc = (struct cq_desc *)((u8 *)cq->ring.descs +
-			cq->ring.desc_size * cq->to_clean);
-		cq_desc_dec(cq_desc, &type, &color,
-			    &q_number, &completed_index);
-
-		work_done++;
-		if (work_done >= work_to_do)
-			break;
-	}
-
-	return work_done;
+	if (ext_wq)
+		*completed_index = le16_to_cpu(desc->completed_index) &
+			ENET_CQ_DESC_COMP_NDX_MASK;
+	else
+		*completed_index = le16_to_cpu(desc->completed_index) &
+			CQ_DESC_COMP_NDX_MASK;
 }
 
 void enic_free_wq_buf(struct vnic_wq *wq, struct vnic_wq_buf *buf)
@@ -93,15 +63,15 @@ static void enic_wq_free_buf(struct vnic_wq *wq, struct cq_desc *cq_desc,
 	enic_free_wq_buf(wq, buf);
 }
 
-int enic_wq_service(struct vnic_dev *vdev, struct cq_desc *cq_desc, u8 type,
-		    u16 q_number, u16 completed_index, void *opaque)
+static void enic_wq_service(struct vnic_dev *vdev, struct cq_desc *cq_desc,
+			    u8 type, u16 q_number, u16 completed_index)
 {
 	struct enic *enic = vnic_dev_priv(vdev);
 
 	spin_lock(&enic->wq[q_number].lock);
 
 	vnic_wq_service(&enic->wq[q_number].vwq, cq_desc,
-			completed_index, enic_wq_free_buf, opaque);
+			completed_index, enic_wq_free_buf, NULL);
 
 	if (netif_tx_queue_stopped(netdev_get_tx_queue(enic->netdev, q_number)) &&
 	    vnic_wq_desc_avail(&enic->wq[q_number].vwq) >=
@@ -111,7 +81,41 @@ int enic_wq_service(struct vnic_dev *vdev, struct cq_desc *cq_desc, u8 type,
 	}
 
 	spin_unlock(&enic->wq[q_number].lock);
-
-	return 0;
 }
 
+unsigned int enic_wq_cq_service(struct enic *enic, unsigned int cq_index, unsigned int work_to_do)
+{
+	u16 q_number, completed_index;
+	u8 type, color;
+	unsigned int work_done = 0;
+	struct vnic_cq *cq = &enic->cq[cq_index];
+	struct cq_desc *cq_desc = (struct cq_desc *)((u8 *)cq->ring.descs +
+		cq->ring.desc_size * cq->to_clean);
+
+	bool ext_wq = cq->ring.size > ENIC_MAX_WQ_DESCS;
+
+	enic_wq_cq_desc_dec(cq_desc, ext_wq, &type, &color,
+			    &q_number, &completed_index);
+
+	while (color != cq->last_color) {
+		enic_wq_service(cq->vdev, cq_desc, type, q_number, completed_index);
+
+		cq->to_clean++;
+
+		if (cq->to_clean == cq->ring.desc_count) {
+			cq->to_clean = 0;
+			cq->last_color = cq->last_color ? 0 : 1;
+		}
+
+		if (++work_done >= work_to_do)
+			break;
+
+		cq_desc = (struct cq_desc *)((u8 *)cq->ring.descs +
+			cq->ring.desc_size * cq->to_clean);
+
+		enic_wq_cq_desc_dec(cq_desc, ext_wq, &type, &color,
+				    &q_number, &completed_index);
+	}
+
+	return work_done;
+}
diff --git a/drivers/net/ethernet/cisco/enic/enic_wq.h b/drivers/net/ethernet/cisco/enic/enic_wq.h
index 051fe8a0cbbaba603414fb49b8a1cc919a2e1347..c54df0a7f061dc544816a2c64bb42f2d617c00bb 100644
--- a/drivers/net/ethernet/cisco/enic/enic_wq.h
+++ b/drivers/net/ethernet/cisco/enic/enic_wq.h
@@ -2,12 +2,5 @@
  * Copyright 2025 Cisco Systems, Inc.  All rights reserved.
  */
 
-unsigned int vnic_cq_service(struct vnic_cq *cq, unsigned int work_to_do,
-			     int (*q_service)(struct vnic_dev *vdev, struct cq_desc *cq_desc,
-					      u8 type, u16 q_number, u16 completed_index,
-					      void *opaque), void *opaque);
-
 void enic_free_wq_buf(struct vnic_wq *wq, struct vnic_wq_buf *buf);
-
-int enic_wq_service(struct vnic_dev *vdev, struct cq_desc *cq_desc, u8 type,
-		    u16 q_number, u16 completed_index, void *opaque);
+unsigned int enic_wq_cq_service(struct enic *enic, unsigned int cq_index, unsigned int work_to_do);

-- 
2.48.1



