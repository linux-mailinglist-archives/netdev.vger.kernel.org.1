Return-Path: <netdev+bounces-172696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58159A55B96
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 01:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21CBB3B4E94
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 00:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAE542AB4;
	Fri,  7 Mar 2025 00:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ko6cN5oP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBC65227;
	Fri,  7 Mar 2025 00:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741306372; cv=none; b=g16PDfC+SCQQyu9Dyawg36j5b2GK2ZbrjzbI7SlUmCR2W9QjY2b8lNYL44HgPyeY6t122loc112N/qc8wZvZaYGyl/ZGXdWHjG3LfyKXByvil9/TVAz6ZDAldYrVu93qFyhw4PSF3IPuQGlI8wCSODnqd06L6ZrvTqynZQ7tdhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741306372; c=relaxed/simple;
	bh=bWa3MKME2jx9B9XyXHOSlEswDyhjLmt9L1QVIXhWduI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eEq9DdIOtxorxCaS1rQfpORQHeLtZdD3WUY7SbONhPDCi95Odych7Gg3eAp6EJPSL2WDxQcOUTS9qz9va/b1kUe3CwbfF+qD14yXbSWA1NSKQKOvrfjq0c/KZLSb/5jXsNYoYHjd7NVNRJpS5nvS6Z+q+yTb8FKsFLaYqvB3174=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ko6cN5oP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A01AAC4CEF2;
	Fri,  7 Mar 2025 00:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741306371;
	bh=bWa3MKME2jx9B9XyXHOSlEswDyhjLmt9L1QVIXhWduI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ko6cN5oPd4oa4MR1Jg0Bi3vLT/a5YfWe3XvPkCJQ7nyt1QH3QzAxAWvisRvxRIHot
	 fbPVtusNgL5SGkEnWh2jitpioeamBulVY+78Q50sFeg06pDmAdCicr8RFh7zVg5V9b
	 xb/KD97+sUlcp0S7f9zGWH7uu/VhQuGT8ZqLiREFS3mJHHe192hKwR5LT1jQDy2adf
	 A3ZwjBGmds3crTCfdpaw1wBsQ88nX0899uvRybJONG5g3kizy+y5MERt9SgqAT9XZz
	 V3m4hbHGEz4DMuG38jUUKIDFOr9DfRYb/iNhbb624JABMjAe/58HppOiE8SbEHTneS
	 o2TELxQk5j5NA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CDEC28B23;
	Fri,  7 Mar 2025 00:12:51 +0000 (UTC)
From: Satish Kharat via B4 Relay <devnull+satishkh.cisco.com@kernel.org>
Date: Thu, 06 Mar 2025 19:15:27 -0500
Subject: [PATCH net-next v3 6/8] enic: added enic_wq.c and enic_wq.h
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-enic_cleanup_and_ext_cq-v3-6-92bc165344cf@cisco.com>
References: <20250306-enic_cleanup_and_ext_cq-v3-0-92bc165344cf@cisco.com>
In-Reply-To: <20250306-enic_cleanup_and_ext_cq-v3-0-92bc165344cf@cisco.com>
To: Christian Benvenuti <benve@cisco.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Satish Kharat <satishkh@cisco.com>, Nelson Escobar <neescoba@cisco.com>, 
 John Daley <johndale@cisco.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741306525; l=11927;
 i=satishkh@cisco.com; s=20250226; h=from:subject:message-id;
 bh=EeYgiBx6VHDfzMmmGoc4ZdtH1pe6AyWH8ejPrRUgPrw=;
 b=r2FvQKIwOOsZlpowAWyVPcNGpVVxN7yYf5gb2Kph/2yOPs4TPnChJY5nycUQsh9s/oRBAonCt
 isOYna21snsAg5OFAr/O7XIC5X5vFbn6hSJDn0inXKeR+26giXtJbPF
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
 drivers/net/ethernet/cisco/enic/enic_main.c |  52 +-----------
 drivers/net/ethernet/cisco/enic/enic_wq.c   | 118 ++++++++++++++++++++++++++++
 drivers/net/ethernet/cisco/enic/enic_wq.h   |  14 ++++
 drivers/net/ethernet/cisco/enic/vnic_cq.h   |  41 ----------
 7 files changed, 138 insertions(+), 117 deletions(-)

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
index 0000000000000000000000000000000000000000..59b02906a1f91f695757c649e74e3f6f117abab3
--- /dev/null
+++ b/drivers/net/ethernet/cisco/enic/enic_wq.c
@@ -0,0 +1,118 @@
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
+			     int (*q_service)(struct vnic_dev *vdev,
+					      struct cq_desc *cq_desc, u8 type,
+					      u16 q_number, u16 completed_index,
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
+	if (netif_tx_queue_stopped(netdev_get_tx_queue(enic->netdev, q_number))
+	    && vnic_wq_desc_avail(&enic->wq[q_number].vwq) >=
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
index 0000000000000000000000000000000000000000..cc4d6a969a9fb11d6ec3b0e8e56ac106b6d34be2
--- /dev/null
+++ b/drivers/net/ethernet/cisco/enic/enic_wq.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ * Copyright 2025 Cisco Systems, Inc.  All rights reserved.
+ */
+
+unsigned int vnic_cq_service(struct vnic_cq *cq, unsigned int work_to_do,
+			     int (*q_service)(struct vnic_dev *vdev,
+					      struct cq_desc *cq_desc, u8 type,
+					      u16 q_number, u16 completed_index,
+					      void *opaque), void *opaque);
+
+void enic_free_wq_buf(struct vnic_wq *wq, struct vnic_wq_buf *buf);
+
+int enic_wq_service(struct vnic_dev *vdev, struct cq_desc *cq_desc, u8 type,
+		    u16 q_number, u16 completed_index, void *opaque);
diff --git a/drivers/net/ethernet/cisco/enic/vnic_cq.h b/drivers/net/ethernet/cisco/enic/vnic_cq.h
index 21d97c01f9424fde3d3c1d9b6cb4b7ef6de144b1..0e37f5d5e5272ed82773b9c16008087ef2dc6dd7 100644
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
 static inline void *vnic_cq_to_clean(struct vnic_cq *cq)
 {
 	return ((u8 *)cq->ring.descs + cq->ring.desc_size * cq->to_clean);

-- 
2.48.1



