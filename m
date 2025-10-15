Return-Path: <netdev+bounces-229480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D05E4BDCD63
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 09:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7719189C34A
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 07:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A023128DD;
	Wed, 15 Oct 2025 07:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SKKpD7Wa"
X-Original-To: netdev@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263081C862D
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 07:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760512312; cv=none; b=pgorireMtFOlc7kvKtODaZ9RTNclF9mZRLSL9ngmgXg3s3G1mGEpzWaRr/rSABOr+BDOnZVKRYyWAMr7kYbjIhT8A+WW66Et1YTzPHMfSbqsFN0XCsWG4okz1cIBllHOctvFfmJ1B8VbAglRbUpd+hXNCNLATl26CqqCk1mB5O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760512312; c=relaxed/simple;
	bh=aMbyBT2iZz8MKxAP6YFUBDuAk6nIlcPSZLMaYZYrwTI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KLHSx2H8I8BqjxQCznWXUTXJmA//7lO6qiOk00bqw/78H8Q711oi4S+IWH8UsUDEMTNeikGadAoEXMEFmryMvvx2PY1yJBFmv+ILtIFdNy06EGSP970qTSX2JROYPIk3f93+5wLMKaEIhfEKNZb6HfsbGA418DpeqOQpu60SDB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SKKpD7Wa; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760512308; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=qPxKuK+0Me7swsli7M0gfO+rgTb8pnD0yBolmeJ+hok=;
	b=SKKpD7Wavj1hGmeWKJmb2gmLEmVeM8MGtBMT4OYGaGvLsIou1bKvJ4uK8QSkwLI53/whHNxdhOg+p2MXUhgWrPhUugpD+bVy2sshBijAN23FQurnR4NGHk+u4XnyzEcP5chu5vs0TqYQC2IJ+k6bdKl7BMQDO1Q2hgT0nIacdlw=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WqFR8-6_1760512306 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 15 Oct 2025 15:11:47 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Philo Lu <lulie@linux.alibaba.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Dust Li <dust.li@linux.alibaba.com>
Subject: [PATCH net-next v6 2/5] eea: introduce ring and descriptor structures
Date: Wed, 15 Oct 2025 15:11:42 +0800
Message-Id: <20251015071145.63774-3-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20251015071145.63774-1-xuanzhuo@linux.alibaba.com>
References: <20251015071145.63774-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: a1c6aa4df11e
Content-Transfer-Encoding: 8bit

Add basic driver framework for Alibaba Elastic Ethernet Adaptor.

This commit introduces the implementation of the ring and the
descriptor.

The ring and descriptor structures used by RX, TX and Admin queue.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/ethernet/alibaba/eea/Makefile   |   3 +-
 drivers/net/ethernet/alibaba/eea/eea_desc.h | 156 ++++++++++++
 drivers/net/ethernet/alibaba/eea/eea_ring.c | 260 ++++++++++++++++++++
 drivers/net/ethernet/alibaba/eea/eea_ring.h |  91 +++++++
 4 files changed, 509 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_desc.h
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_ring.c
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_ring.h

diff --git a/drivers/net/ethernet/alibaba/eea/Makefile b/drivers/net/ethernet/alibaba/eea/Makefile
index cf2acf1733fd..e5e4007810a6 100644
--- a/drivers/net/ethernet/alibaba/eea/Makefile
+++ b/drivers/net/ethernet/alibaba/eea/Makefile
@@ -1,3 +1,4 @@
 
 obj-$(CONFIG_EEA) += eea.o
-eea-y := eea_pci.o
+eea-y :=  eea_ring.o \
+	eea_pci.o
diff --git a/drivers/net/ethernet/alibaba/eea/eea_desc.h b/drivers/net/ethernet/alibaba/eea/eea_desc.h
new file mode 100644
index 000000000000..becb2e09c1e9
--- /dev/null
+++ b/drivers/net/ethernet/alibaba/eea/eea_desc.h
@@ -0,0 +1,156 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Driver for Alibaba Elastic Ethernet Adaptor.
+ *
+ * Copyright (C) 2025 Alibaba Inc.
+ */
+
+#ifndef __EEA_DESC_H__
+#define __EEA_DESC_H__
+
+#define EEA_DESC_TS_MASK GENMASK(47, 0)
+#define EEA_DESC_TS(desc) (le64_to_cpu((desc)->ts) & EEA_DESC_TS_MASK)
+
+struct eea_aq_desc {
+	__le16 flags;
+	__le16 id;
+	__le16 reserved;
+	u8 classid;
+	u8 command;
+	__le64 data_addr;
+	__le64 reply_addr;
+	__le32 data_len;
+	__le32 reply_len;
+};
+
+struct eea_aq_cdesc {
+	__le16 flags;
+	__le16 id;
+#define EEA_OK     0
+#define EEA_ERR    0xffffffff
+	__le32 status;
+	__le32 reply_len;
+	__le32 reserved1;
+
+	__le64 reserved2;
+	__le64 reserved3;
+};
+
+struct eea_rx_desc {
+	__le16 flags;
+	__le16 id;
+	__le16 len;
+	__le16 reserved1;
+
+	__le64 addr;
+
+	__le64 hdr_addr;
+	__le32 reserved2;
+	__le32 reserved3;
+};
+
+#define EEA_RX_CDESC_HDR_LEN_MASK GENMASK(9, 0)
+
+struct eea_rx_cdesc {
+#define EEA_DESC_F_DATA_VALID	BIT(6)
+#define EEA_DESC_F_SPLIT_HDR	BIT(5)
+	__le16 flags;
+	__le16 id;
+	__le16 len;
+#define EEA_NET_PT_NONE      0
+#define EEA_NET_PT_IPv4      1
+#define EEA_NET_PT_TCPv4     2
+#define EEA_NET_PT_UDPv4     3
+#define EEA_NET_PT_IPv6      4
+#define EEA_NET_PT_TCPv6     5
+#define EEA_NET_PT_UDPv6     6
+#define EEA_NET_PT_IPv6_EX   7
+#define EEA_NET_PT_TCPv6_EX  8
+#define EEA_NET_PT_UDPv6_EX  9
+	/* [9:0] is packet type. */
+	__le16 type;
+
+	/* hw timestamp [0:47]: ts */
+	__le64 ts;
+
+	__le32 hash;
+
+	/* 0-9: hdr_len  split header
+	 * 10-15: reserved1
+	 */
+	__le16 len_ex;
+	__le16 reserved2;
+
+	__le32 reserved3;
+	__le32 reserved4;
+};
+
+#define EEA_TX_GSO_NONE   0
+#define EEA_TX_GSO_TCPV4  1
+#define EEA_TX_GSO_TCPV6  4
+#define EEA_TX_GSO_UDP_L4 5
+#define EEA_TX_GSO_ECN    0x80
+
+struct eea_tx_desc {
+#define EEA_DESC_F_DO_CSUM	BIT(6)
+	__le16 flags;
+	__le16 id;
+	__le16 len;
+	__le16 reserved1;
+
+	__le64 addr;
+
+	__le16 csum_start;
+	__le16 csum_offset;
+	u8 gso_type;
+	u8 reserved2;
+	__le16 gso_size;
+	__le64 reserved3;
+};
+
+struct eea_tx_cdesc {
+	__le16 flags;
+	__le16 id;
+	__le16 len;
+	__le16 reserved1;
+
+	/* hw timestamp [0:47]: ts */
+	__le64 ts;
+	__le64 reserved2;
+	__le64 reserved3;
+};
+
+struct eea_db {
+#define EEA_IDX_PRESENT   BIT(0)
+#define EEA_IRQ_MASK      BIT(1)
+#define EEA_IRQ_UNMASK    BIT(2)
+#define EEA_DIRECT_INLINE BIT(3)
+#define EEA_DIRECT_DESC   BIT(4)
+	u8 kick_flags;
+	u8 reserved;
+	__le16 idx;
+
+	__le16 tx_cq_head;
+	__le16 rx_cq_head;
+};
+
+struct eea_db_direct {
+	u8 kick_flags;
+	u8 reserved;
+	__le16 idx;
+
+	__le16 tx_cq_head;
+	__le16 rx_cq_head;
+
+	u8 desc[24];
+};
+
+static_assert(sizeof(struct eea_rx_desc) == 32, "rx desc size does not match");
+static_assert(sizeof(struct eea_rx_cdesc) == 32,
+	      "rx cdesc size does not match");
+static_assert(sizeof(struct eea_tx_desc) == 32, "tx desc size does not match");
+static_assert(sizeof(struct eea_tx_cdesc) == 32,
+	      "tx cdesc size does not match");
+static_assert(sizeof(struct eea_db_direct) == 32,
+	      "db direct size does not match");
+#endif
diff --git a/drivers/net/ethernet/alibaba/eea/eea_ring.c b/drivers/net/ethernet/alibaba/eea/eea_ring.c
new file mode 100644
index 000000000000..d88072ae25bd
--- /dev/null
+++ b/drivers/net/ethernet/alibaba/eea/eea_ring.c
@@ -0,0 +1,260 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Driver for Alibaba Elastic Ethernet Adaptor.
+ *
+ * Copyright (C) 2025 Alibaba Inc.
+ */
+
+#include "eea_pci.h"
+#include "eea_ring.h"
+
+void ering_irq_unactive(struct eea_ring *ering)
+{
+	union {
+		u64 data;
+		struct eea_db db;
+	} val;
+
+	if (ering->mask == EEA_IRQ_MASK)
+		return;
+
+	ering->mask = EEA_IRQ_MASK;
+
+	val.db.kick_flags = EEA_IRQ_MASK;
+
+	writeq(val.data, (void __iomem *)ering->db);
+}
+
+void ering_irq_active(struct eea_ring *ering, struct eea_ring *tx_ering)
+{
+	union {
+		u64 data;
+		struct eea_db db;
+	} val;
+
+	if (ering->mask == EEA_IRQ_UNMASK)
+		return;
+
+	ering->mask = EEA_IRQ_UNMASK;
+
+	val.db.kick_flags = EEA_IRQ_UNMASK;
+
+	val.db.tx_cq_head = cpu_to_le16(tx_ering->cq.hw_idx);
+	val.db.rx_cq_head = cpu_to_le16(ering->cq.hw_idx);
+
+	writeq(val.data, ering->db);
+}
+
+void *ering_cq_get_desc(const struct eea_ring *ering)
+{
+	u8 phase;
+	u8 *desc;
+
+	desc = ering->cq.desc + (ering->cq.head << ering->cq.desc_size_shift);
+
+	phase = *(u8 *)(desc + ering->cq.desc_size - 1);
+
+	if ((phase & EEA_RING_DESC_F_CQ_PHASE) == ering->cq.phase) {
+		dma_rmb();
+		return desc;
+	}
+
+	return NULL;
+}
+
+/* sq api */
+void *ering_sq_alloc_desc(struct eea_ring *ering, u16 id, bool is_last,
+			  u16 flags)
+{
+	struct eea_ring_sq *sq = &ering->sq;
+	struct eea_common_desc *desc;
+
+	if (!sq->shadow_num) {
+		sq->shadow_idx = sq->head;
+		sq->shadow_id = cpu_to_le16(id);
+	}
+
+	if (!is_last)
+		flags |= EEA_RING_DESC_F_MORE;
+
+	desc = sq->desc + (sq->shadow_idx << sq->desc_size_shift);
+
+	desc->flags = cpu_to_le16(flags);
+	desc->id = sq->shadow_id;
+
+	if (unlikely(++sq->shadow_idx >= ering->num))
+		sq->shadow_idx = 0;
+
+	++sq->shadow_num;
+
+	return desc;
+}
+
+/* alloc desc for adminq */
+void *ering_aq_alloc_desc(struct eea_ring *ering)
+{
+	struct eea_ring_sq *sq = &ering->sq;
+	struct eea_common_desc *desc;
+
+	sq->shadow_idx = sq->head;
+
+	desc = sq->desc + (sq->shadow_idx << sq->desc_size_shift);
+
+	if (unlikely(++sq->shadow_idx >= ering->num))
+		sq->shadow_idx = 0;
+
+	++sq->shadow_num;
+
+	return desc;
+}
+
+void ering_sq_commit_desc(struct eea_ring *ering)
+{
+	struct eea_ring_sq *sq = &ering->sq;
+	int num;
+
+	num = sq->shadow_num;
+
+	ering->num_free -= num;
+
+	sq->head       = sq->shadow_idx;
+	sq->hw_idx     += num;
+	sq->shadow_num = 0;
+}
+
+void ering_sq_cancel(struct eea_ring *ering)
+{
+	ering->sq.shadow_num = 0;
+}
+
+/* cq api */
+void ering_cq_ack_desc(struct eea_ring *ering, u32 num)
+{
+	struct eea_ring_cq *cq = &ering->cq;
+
+	cq->head += num;
+	cq->hw_idx += num;
+
+	if (unlikely(cq->head >= ering->num)) {
+		cq->head -= ering->num;
+		cq->phase ^= EEA_RING_DESC_F_CQ_PHASE;
+	}
+
+	ering->num_free += num;
+}
+
+/* notify */
+bool ering_kick(struct eea_ring *ering)
+{
+	union {
+		struct eea_db db;
+		u64 data;
+	} val;
+
+	val.db.kick_flags = EEA_IDX_PRESENT;
+	val.db.idx = cpu_to_le16(ering->sq.hw_idx);
+
+	writeq(val.data, ering->db);
+
+	return true;
+}
+
+/* ering alloc/free */
+static void ering_free_queue(struct eea_device *edev, size_t size,
+			     void *queue, dma_addr_t dma_handle)
+{
+	dma_free_coherent(edev->dma_dev, size, queue, dma_handle);
+}
+
+static void *ering_alloc_queue(struct eea_device *edev, size_t size,
+			       dma_addr_t *dma_handle)
+{
+	gfp_t flags = GFP_KERNEL | __GFP_NOWARN | __GFP_ZERO;
+
+	return dma_alloc_coherent(edev->dma_dev, size, dma_handle, flags);
+}
+
+static int ering_alloc_queues(struct eea_ring *ering, struct eea_device *edev,
+			      u32 num, u8 sq_desc_size, u8 cq_desc_size)
+{
+	dma_addr_t addr;
+	size_t size;
+	void *ring;
+
+	size = num * sq_desc_size;
+
+	ring = ering_alloc_queue(edev, size, &addr);
+	if (!ring)
+		return -ENOMEM;
+
+	ering->sq.desc     = ring;
+	ering->sq.dma_addr = addr;
+	ering->sq.dma_size = size;
+	ering->sq.desc_size = sq_desc_size;
+	ering->sq.desc_size_shift = fls(sq_desc_size) - 1;
+
+	size = num * cq_desc_size;
+
+	ring = ering_alloc_queue(edev, size, &addr);
+	if (!ring)
+		goto err_cq;
+
+	ering->cq.desc     = ring;
+	ering->cq.dma_addr = addr;
+	ering->cq.dma_size = size;
+	ering->cq.desc_size = cq_desc_size;
+	ering->cq.desc_size_shift = fls(cq_desc_size) - 1;
+
+	ering->num = num;
+
+	return 0;
+
+err_cq:
+	ering_free_queue(ering->edev, ering->sq.dma_size,
+			 ering->sq.desc, ering->sq.dma_addr);
+	return -ENOMEM;
+}
+
+static void ering_init(struct eea_ring *ering)
+{
+	ering->cq.phase = EEA_RING_DESC_F_CQ_PHASE;
+	ering->num_free = ering->num;
+}
+
+struct eea_ring *ering_alloc(u32 index, u32 num, struct eea_device *edev,
+			     u8 sq_desc_size, u8 cq_desc_size,
+			     const char *name)
+{
+	struct eea_ring *ering;
+
+	ering = kzalloc(sizeof(*ering), GFP_KERNEL);
+	if (!ering)
+		return NULL;
+
+	ering->edev = edev;
+	ering->name = name;
+	ering->index = index;
+	ering->msix_vec = index / 2 + 1; /* vec 0 is for error notify. */
+
+	if (ering_alloc_queues(ering, edev, num, sq_desc_size, cq_desc_size))
+		goto err_ring;
+
+	ering_init(ering);
+
+	return ering;
+
+err_ring:
+	kfree(ering);
+	return NULL;
+}
+
+void ering_free(struct eea_ring *ering)
+{
+	ering_free_queue(ering->edev, ering->cq.dma_size,
+			 ering->cq.desc, ering->cq.dma_addr);
+
+	ering_free_queue(ering->edev, ering->sq.dma_size,
+			 ering->sq.desc, ering->sq.dma_addr);
+
+	kfree(ering);
+}
diff --git a/drivers/net/ethernet/alibaba/eea/eea_ring.h b/drivers/net/ethernet/alibaba/eea/eea_ring.h
new file mode 100644
index 000000000000..3afe8be47d5b
--- /dev/null
+++ b/drivers/net/ethernet/alibaba/eea/eea_ring.h
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Driver for Alibaba Elastic Ethernet Adaptor.
+ *
+ * Copyright (C) 2025 Alibaba Inc.
+ */
+
+#ifndef __EEA_RING_H__
+#define __EEA_RING_H__
+
+#include <linux/dma-mapping.h>
+#include "eea_desc.h"
+
+#define EEA_RING_DESC_F_MORE		BIT(0)
+#define EEA_RING_DESC_F_CQ_PHASE	BIT(7)
+
+struct eea_common_desc {
+	__le16 flags;
+	__le16 id;
+};
+
+struct eea_device;
+
+struct eea_ring_sq {
+	void *desc;
+
+	u16 head;
+	u16 hw_idx;
+
+	u16 shadow_idx;
+	__le16 shadow_id;
+	u16 shadow_num;
+
+	u8 desc_size;
+	u8 desc_size_shift;
+
+	dma_addr_t dma_addr;
+	u32 dma_size;
+};
+
+struct eea_ring_cq {
+	void *desc;
+
+	u16 head;
+	u16 hw_idx;
+
+	u8 phase;
+	u8 desc_size_shift;
+	u8 desc_size;
+
+	dma_addr_t dma_addr;
+	u32 dma_size;
+};
+
+struct eea_ring {
+	const char *name;
+	struct eea_device *edev;
+	u32 index;
+	void __iomem *db;
+	u16 msix_vec;
+
+	u8 mask;
+
+	u32 num;
+
+	u32 num_free;
+
+	struct eea_ring_sq sq;
+	struct eea_ring_cq cq;
+
+	char irq_name[32];
+};
+
+struct eea_ring *ering_alloc(u32 index, u32 num, struct eea_device *edev,
+			     u8 sq_desc_size, u8 cq_desc_size,
+			     const char *name);
+void ering_free(struct eea_ring *ering);
+bool ering_kick(struct eea_ring *ering);
+
+void *ering_sq_alloc_desc(struct eea_ring *ering, u16 id,
+			  bool is_last, u16 flags);
+void *ering_aq_alloc_desc(struct eea_ring *ering);
+void ering_sq_commit_desc(struct eea_ring *ering);
+void ering_sq_cancel(struct eea_ring *ering);
+
+void ering_cq_ack_desc(struct eea_ring *ering, u32 num);
+
+void ering_irq_unactive(struct eea_ring *ering);
+void ering_irq_active(struct eea_ring *ering, struct eea_ring *tx_ering);
+void *ering_cq_get_desc(const struct eea_ring *ering);
+#endif
-- 
2.32.0.3.g01195cf9f


