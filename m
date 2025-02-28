Return-Path: <netdev+bounces-170473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8726BA48D65
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 01:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1F141893366
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 00:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F283517A302;
	Fri, 28 Feb 2025 00:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVZ91Jsr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DF9224CC;
	Fri, 28 Feb 2025 00:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740702542; cv=none; b=Y5UTYjzeKIIUBHKSGnmCmMnvdfR/I6ztQRryHoOvSX4xbZv7FH8Fkcwf+a7PFpteEVodHZd1nTW/NvNOsVH7kEJDFZyrBOluDgksWyD7Pp5Jh8TooFTEUP9NMFcM3yYDHEwGgHI7+UzkcaE+w/cUX3J5l5uJD9xtsgCzoY1a0V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740702542; c=relaxed/simple;
	bh=kcr4Krre820bmaF7LeCZpMv8yNsY2bR6A3IuWT89/d8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=alrvPtp3bNnTGaezbJlzzUwyZRhGI8Ki5h/k9QtBV7n5dANOlfZ5qSwf2HY4Wdwuxn8qreNsGM84YDmwd6slHUAmXHmDfuj3iVLWLEBUR/HiBK6Ist4ftF7BGFf48L9xnlbmCCmHbv4uQHZfxrN9hTfE8MabrVa5xet/c50i1js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVZ91Jsr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E004C4CEF0;
	Fri, 28 Feb 2025 00:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740702542;
	bh=kcr4Krre820bmaF7LeCZpMv8yNsY2bR6A3IuWT89/d8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=nVZ91JsrKAR5MWIh6G6Y829Tb6AI3fagh7tc9bnAKatEt2Na+xVCt5WomlKlqa3fi
	 VMOmX89qmwDIYxk3OwS0zoBxKsr41pjCUBxiC2qBJ4erpVDi06yZ71m6KcwxmqSxXz
	 mS2B79feftGjKKGplN8f0BPWCJFR+ngZ7U+XfOh+n818/N887sPCnzWDCzyqJSlAf5
	 wuWvS5fSffI1zPGGbo2IP1qCWg8ZDx3D30iURLZDhyKyDBn5ACgHxI5TB3u1WnFNz0
	 xUO43BNSOI/cGhyHVjR+XmrBq6UejperlAc005jhy7UrcLJd3iHCz95xS1yZUpPWOB
	 t42JDBaLt2PAQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E30C282C7;
	Fri, 28 Feb 2025 00:29:02 +0000 (UTC)
From: Satish Kharat via B4 Relay <devnull+satishkh.cisco.com@kernel.org>
Date: Thu, 27 Feb 2025 19:30:49 -0500
Subject: [PATCH 6/8] enic : added enic_wq.c and enic_wq.h
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-enic_cleanup_and_ext_cq-v1-6-c314f95812bb@cisco.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740702696; l=11946;
 i=satishkh@cisco.com; s=20250226; h=from:subject:message-id;
 bh=yXV/wz+tCPVcaOhW/6r6nU4R1X7xTBUWz+dlUyGLGBc=;
 b=fsjHXCh1PjtwK/NfEWLRXiaSt/PfQcXGlrOPTi0crEpCVPXLOfYKmcCbuWpBAM6WTZOYJ3WTj
 sfivki91phaDbgB/X1c0ZDWUwH+q6ppdY0rOb4m3VkxAPgXWq8grbKn
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=lkxzORFYn5ejiy0kzcsfkpGoXZDcnHMc4n3YK7jJnJo=
X-Endpoint-Received: by B4 Relay for satishkh@cisco.com/20250226 with
 auth_id=351
X-Original-From: Satish Kharat <satishkh@cisco.com>
Reply-To: satishkh@cisco.com

From: Satish Kharat <satishkh@cisco.com>

Moves wq related function to enic_wq.c. Prepares for
a cleaup of enic wq code path.

Co-developed-by: Nelson Escobar <neescoba@cisco.com>
Signed-off-by: Nelson Escobar <neescoba@cisco.com>
Co-developed-by: John Daley <johndale@cisco.com>
Signed-off-by: John Daley <johndale@cisco.com>
Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/Makefile    |   2 +-
 drivers/net/ethernet/cisco/enic/cq_desc.h   |  24 ------
 drivers/net/ethernet/cisco/enic/enic.h      |   4 +
 drivers/net/ethernet/cisco/enic/enic_main.c |  52 +------------
 drivers/net/ethernet/cisco/enic/enic_wq.c   | 117 ++++++++++++++++++++++++++++
 drivers/net/ethernet/cisco/enic/enic_wq.h   |  13 ++++
 drivers/net/ethernet/cisco/enic/vnic_cq.h   |  41 ----------
 7 files changed, 136 insertions(+), 117 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/Makefile b/drivers/net/ethernet/cisco/enic/Makefile
index b3b5196b2dfcc3e59366474ba78fc7a4cd746eb0..a96b8332e6e2a87da6e50a2da3ef9546d61b589c 100644
--- a/drivers/net/ethernet/cisco/enic/Makefile
+++ b/drivers/net/ethernet/cisco/enic/Makefile
@@ -3,5 +3,5 @@ obj-$(CONFIG_ENIC) := enic.o
 
 enic-y := enic_main.o vnic_cq.o vnic_intr.o vnic_wq.o \
 	enic_res.o enic_dev.o enic_pp.o vnic_dev.o vnic_rq.o vnic_vic.o \
-	enic_ethtool.o enic_api.o enic_clsf.o enic_rq.o
+	enic_ethtool.o enic_api.o enic_clsf.o enic_rq.o enic_wq.o
 
diff --git a/drivers/net/ethernet/cisco/enic/cq_desc.h b/drivers/net/ethernet/cisco/enic/cq_desc.h
index 8fc313b6ed0434bd55b8e10bf3086ef848acbdf1..bfb3f14e89f5d6cfb0159bdf041b8004c774d7e8 100644
--- a/drivers/net/ethernet/cisco/enic/cq_desc.h
+++ b/drivers/net/ethernet/cisco/enic/cq_desc.h
@@ -43,28 +43,4 @@ struct cq_desc {
 #define CQ_DESC_32_FI_MASK (BIT(0) | BIT(1))
 #define CQ_DESC_64_FI_MASK (BIT(0) | BIT(1))
 
-static inline void cq_desc_dec(const struct cq_desc *desc_arg,
-	u8 *type, u8 *color, u16 *q_number, u16 *completed_index)
-{
-	const struct cq_desc *desc = desc_arg;
-	const u8 type_color = desc->type_color;
-
-	*color = (type_color >> CQ_DESC_COLOR_SHIFT) & CQ_DESC_COLOR_MASK;
-
-	/*
-	 * Make sure color bit is read from desc *before* other fields
-	 * are read from desc.  Hardware guarantees color bit is last
-	 * bit (byte) written.  Adding the rmb() prevents the compiler
-	 * and/or CPU from reordering the reads which would potentially
-	 * result in reading stale values.
-	 */
-
-	rmb();
-
-	*type = type_color & CQ_DESC_TYPE_MASK;
-	*q_number = le16_to_cpu(desc->q_number) & CQ_DESC_Q_NUM_MASK;
-	*completed_index = le16_to_cpu(desc->completed_index) &
-		CQ_DESC_COMP_NDX_MASK;
-}
-
 #endif /* _CQ_DESC_H_ */
diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index d60e55accafd0e4f83728524da4f167a474d6213..9c12e967e9f1299e1cf3e280a16fb9bf93ac607b 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -83,6 +83,10 @@ struct enic_rx_coal {
 #define ENIC_SET_INSTANCE		(1 << 3)
 #define ENIC_SET_HOST			(1 << 4)
 
+#define MAX_TSO			BIT(16)
+#define WQ_ENET_MAX_DESC_LEN	BIT(WQ_ENET_LEN_BITS)
+#define ENIC_DESC_MAX_SPLITS	(MAX_TSO / WQ_ENET_MAX_DESC_LEN + 1)
+
 struct enic_port_profile {
 	u32 set;
 	u8 request;
diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index d716514366dfc56b4e08260d18d78fddd23f6253..52174843f02f1fecc75666367ad5034cbbcf8f07 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -59,11 +59,9 @@
 #include "enic_pp.h"
 #include "enic_clsf.h"
 #include "enic_rq.h"
+#include "enic_wq.h"
 
 #define ENIC_NOTIFY_TIMER_PERIOD	(2 * HZ)
-#define WQ_ENET_MAX_DESC_LEN		(1 << WQ_ENET_LEN_BITS)
-#define MAX_TSO				(1 << 16)
-#define ENIC_DESC_MAX_SPLITS		(MAX_TSO / WQ_ENET_MAX_DESC_LEN + 1)
 
 #define PCI_DEVICE_ID_CISCO_VIC_ENET         0x0043  /* ethernet vnic */
 #define PCI_DEVICE_ID_CISCO_VIC_ENET_DYN     0x0044  /* enet dynamic vnic */
@@ -321,54 +319,6 @@ int enic_is_valid_vf(struct enic *enic, int vf)
 #endif
 }
 
-static void enic_free_wq_buf(struct vnic_wq *wq, struct vnic_wq_buf *buf)
-{
-	struct enic *enic = vnic_dev_priv(wq->vdev);
-
-	if (buf->sop)
-		dma_unmap_single(&enic->pdev->dev, buf->dma_addr, buf->len,
-				 DMA_TO_DEVICE);
-	else
-		dma_unmap_page(&enic->pdev->dev, buf->dma_addr, buf->len,
-			       DMA_TO_DEVICE);
-
-	if (buf->os_buf)
-		dev_kfree_skb_any(buf->os_buf);
-}
-
-static void enic_wq_free_buf(struct vnic_wq *wq,
-	struct cq_desc *cq_desc, struct vnic_wq_buf *buf, void *opaque)
-{
-	struct enic *enic = vnic_dev_priv(wq->vdev);
-
-	enic->wq[wq->index].stats.cq_work++;
-	enic->wq[wq->index].stats.cq_bytes += buf->len;
-	enic_free_wq_buf(wq, buf);
-}
-
-static int enic_wq_service(struct vnic_dev *vdev, struct cq_desc *cq_desc,
-	u8 type, u16 q_number, u16 completed_index, void *opaque)
-{
-	struct enic *enic = vnic_dev_priv(vdev);
-
-	spin_lock(&enic->wq[q_number].lock);
-
-	vnic_wq_service(&enic->wq[q_number].vwq, cq_desc,
-		completed_index, enic_wq_free_buf,
-		opaque);
-
-	if (netif_tx_queue_stopped(netdev_get_tx_queue(enic->netdev, q_number)) &&
-	    vnic_wq_desc_avail(&enic->wq[q_number].vwq) >=
-	    (MAX_SKB_FRAGS + ENIC_DESC_MAX_SPLITS)) {
-		netif_wake_subqueue(enic->netdev, q_number);
-		enic->wq[q_number].stats.wake++;
-	}
-
-	spin_unlock(&enic->wq[q_number].lock);
-
-	return 0;
-}
-
 static bool enic_log_q_error(struct enic *enic)
 {
 	unsigned int i;
diff --git a/drivers/net/ethernet/cisco/enic/enic_wq.c b/drivers/net/ethernet/cisco/enic/enic_wq.c
new file mode 100644
index 0000000000000000000000000000000000000000..88fdc462839a8360000eb8526be64118ea35c0e2
--- /dev/null
+++ b/drivers/net/ethernet/cisco/enic/enic_wq.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright 2025 Cisco Systems, Inc.  All rights reserved.
+
+#include <net/netdev_queues.h>
+#include "enic_res.h"
+#include "enic.h"
+#include "enic_wq.h"
+
+static void cq_desc_dec(const struct cq_desc *desc_arg, u8 *type, u8 *color,
+			u16 *q_number, u16 *completed_index)
+{
+	const struct cq_desc *desc = desc_arg;
+	const u8 type_color = desc->type_color;
+
+	*color = (type_color >> CQ_DESC_COLOR_SHIFT) & CQ_DESC_COLOR_MASK;
+
+	/*
+	 * Make sure color bit is read from desc *before* other fields
+	 * are read from desc.  Hardware guarantees color bit is last
+	 * bit (byte) written.  Adding the rmb() prevents the compiler
+	 * and/or CPU from reordering the reads which would potentially
+	 * result in reading stale values.
+	 */
+	rmb();
+
+	*type = type_color & CQ_DESC_TYPE_MASK;
+	*q_number = le16_to_cpu(desc->q_number) & CQ_DESC_Q_NUM_MASK;
+	*completed_index = le16_to_cpu(desc->completed_index) &
+		CQ_DESC_COMP_NDX_MASK;
+}
+
+unsigned int vnic_cq_service(struct vnic_cq *cq, unsigned int work_to_do,
+			     int (*q_service)(struct vnic_dev *vdev, struct cq_desc *cq_desc,
+					      u8 type, u16 q_number, u16 completed_index,
+					      void *opaque), void *opaque)
+{
+	struct cq_desc *cq_desc;
+	unsigned int work_done = 0;
+	u16 q_number, completed_index;
+	u8 type, color;
+
+	cq_desc = (struct cq_desc *)((u8 *)cq->ring.descs +
+		   cq->ring.desc_size * cq->to_clean);
+	cq_desc_dec(cq_desc, &type, &color,
+		    &q_number, &completed_index);
+
+	while (color != cq->last_color) {
+		if ((*q_service)(cq->vdev, cq_desc, type, q_number,
+				 completed_index, opaque))
+			break;
+
+		cq->to_clean++;
+		if (cq->to_clean == cq->ring.desc_count) {
+			cq->to_clean = 0;
+			cq->last_color = cq->last_color ? 0 : 1;
+		}
+
+		cq_desc = (struct cq_desc *)((u8 *)cq->ring.descs +
+			cq->ring.desc_size * cq->to_clean);
+		cq_desc_dec(cq_desc, &type, &color,
+			    &q_number, &completed_index);
+
+		work_done++;
+		if (work_done >= work_to_do)
+			break;
+	}
+
+	return work_done;
+}
+
+void enic_free_wq_buf(struct vnic_wq *wq, struct vnic_wq_buf *buf)
+{
+	struct enic *enic = vnic_dev_priv(wq->vdev);
+
+	if (buf->sop)
+		dma_unmap_single(&enic->pdev->dev, buf->dma_addr, buf->len,
+				 DMA_TO_DEVICE);
+	else
+		dma_unmap_page(&enic->pdev->dev, buf->dma_addr, buf->len,
+			       DMA_TO_DEVICE);
+
+	if (buf->os_buf)
+		dev_kfree_skb_any(buf->os_buf);
+}
+
+static void enic_wq_free_buf(struct vnic_wq *wq, struct cq_desc *cq_desc,
+			     struct vnic_wq_buf *buf, void *opaque)
+{
+	struct enic *enic = vnic_dev_priv(wq->vdev);
+
+	enic->wq[wq->index].stats.cq_work++;
+	enic->wq[wq->index].stats.cq_bytes += buf->len;
+	enic_free_wq_buf(wq, buf);
+}
+
+int enic_wq_service(struct vnic_dev *vdev, struct cq_desc *cq_desc, u8 type,
+		    u16 q_number, u16 completed_index, void *opaque)
+{
+	struct enic *enic = vnic_dev_priv(vdev);
+
+	spin_lock(&enic->wq[q_number].lock);
+
+	vnic_wq_service(&enic->wq[q_number].vwq, cq_desc,
+			completed_index, enic_wq_free_buf, opaque);
+
+	if (netif_tx_queue_stopped(netdev_get_tx_queue(enic->netdev, q_number)) &&
+	    vnic_wq_desc_avail(&enic->wq[q_number].vwq) >=
+	    (MAX_SKB_FRAGS + ENIC_DESC_MAX_SPLITS)) {
+		netif_wake_subqueue(enic->netdev, q_number);
+		enic->wq[q_number].stats.wake++;
+	}
+
+	spin_unlock(&enic->wq[q_number].lock);
+
+	return 0;
+}
+
diff --git a/drivers/net/ethernet/cisco/enic/enic_wq.h b/drivers/net/ethernet/cisco/enic/enic_wq.h
new file mode 100644
index 0000000000000000000000000000000000000000..051fe8a0cbbaba603414fb49b8a1cc919a2e1347
--- /dev/null
+++ b/drivers/net/ethernet/cisco/enic/enic_wq.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ * Copyright 2025 Cisco Systems, Inc.  All rights reserved.
+ */
+
+unsigned int vnic_cq_service(struct vnic_cq *cq, unsigned int work_to_do,
+			     int (*q_service)(struct vnic_dev *vdev, struct cq_desc *cq_desc,
+					      u8 type, u16 q_number, u16 completed_index,
+					      void *opaque), void *opaque);
+
+void enic_free_wq_buf(struct vnic_wq *wq, struct vnic_wq_buf *buf);
+
+int enic_wq_service(struct vnic_dev *vdev, struct cq_desc *cq_desc, u8 type,
+		    u16 q_number, u16 completed_index, void *opaque);
diff --git a/drivers/net/ethernet/cisco/enic/vnic_cq.h b/drivers/net/ethernet/cisco/enic/vnic_cq.h
index eed5bf59e5d2c87bf240a96638cc4f58cd17c79c..2fec4218cb8b5d68e0f28b3574948a0b7f77e426 100644
--- a/drivers/net/ethernet/cisco/enic/vnic_cq.h
+++ b/drivers/net/ethernet/cisco/enic/vnic_cq.h
@@ -56,47 +56,6 @@ struct vnic_cq {
 	ktime_t prev_ts;
 };
 
-static inline unsigned int vnic_cq_service(struct vnic_cq *cq,
-	unsigned int work_to_do,
-	int (*q_service)(struct vnic_dev *vdev, struct cq_desc *cq_desc,
-	u8 type, u16 q_number, u16 completed_index, void *opaque),
-	void *opaque)
-{
-	struct cq_desc *cq_desc;
-	unsigned int work_done = 0;
-	u16 q_number, completed_index;
-	u8 type, color;
-
-	cq_desc = (struct cq_desc *)((u8 *)cq->ring.descs +
-		cq->ring.desc_size * cq->to_clean);
-	cq_desc_dec(cq_desc, &type, &color,
-		&q_number, &completed_index);
-
-	while (color != cq->last_color) {
-
-		if ((*q_service)(cq->vdev, cq_desc, type,
-			q_number, completed_index, opaque))
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
-			&q_number, &completed_index);
-
-		work_done++;
-		if (work_done >= work_to_do)
-			break;
-	}
-
-	return work_done;
-}
-
 void vnic_cq_free(struct vnic_cq *cq);
 int vnic_cq_alloc(struct vnic_dev *vdev, struct vnic_cq *cq, unsigned int index,
 	unsigned int desc_count, unsigned int desc_size);

-- 
2.48.1



