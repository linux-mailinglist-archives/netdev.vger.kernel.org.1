Return-Path: <netdev+bounces-257808-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YN0QFm5NiGk/ngQAu9opvQ
	(envelope-from <netdev+bounces-257808-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 09:46:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73388108200
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 09:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5A6A63003BFC
	for <lists+netdev@lfdr.de>; Sun,  8 Feb 2026 08:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0759633C188;
	Sun,  8 Feb 2026 08:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OW9jjHom"
X-Original-To: netdev@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400BB1E1A3B
	for <netdev@vger.kernel.org>; Sun,  8 Feb 2026 08:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770540384; cv=none; b=ohYjbPHhiqdgtfkzeG2fSEnfyOSxHXdlI+ioa8ztoWXKP+OmxaICkFIi4IL0pao5nJ/hI7cgalxVWElcj2Eb6ndA8rultZd1vPC/cntvfyS/8nuD4Dh1jVTRP9ZKP08Yj+23diWKbuwqaeiQ7/IUTn6BDdG83MsMfrbBrBcTH/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770540384; c=relaxed/simple;
	bh=h2AUejclNBlSY+PSJvHSdsZpBvtigqk6jx0B9oCrf7o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eAxN6z5jkm5SFBMqNFaePtMOZ4b4pUUxhse84orM2SEHj4LU/0u75MCBPfiuH/e6IT8yuIFmBHeAUTxUTk7gfm6sMY+HcDN9+DslglJJ6YOQKvaCHLw+oRcbnYfgY2WWGABeCn1FVEQLuPgikCxCXzV381B+g6ObbMyVMfZh8VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OW9jjHom; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1770540375; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=3C65dBgms8fCHu9RZZUhjJDmNh+Wl2fQ/SvOMcHX73o=;
	b=OW9jjHomc2SQwEt+HH5bJCui57WwaL1UneQI2piWNM/hckuNfQ5zZIbDpzGlBEqh+XkfnXekDUdfjoNxKeh8EsvozWedMgmXa3eOkpSuVf0VfFcErn4bsyXTA0FpTW8svNd9r0ySdZsjJBQfDV0JTTguHZUlZ5oKTd5FIkr6//Y=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WykTQWb_1770540374 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 08 Feb 2026 16:46:15 +0800
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
	Dong Yibo <dong100@mucse.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Dust Li <dust.li@linux.alibaba.com>
Subject: [PATCH net-next v26 2/8] eea: introduce ring and descriptor structures
Date: Sun,  8 Feb 2026 16:46:07 +0800
Message-Id: <20260208084613.2658-3-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20260208084613.2658-1-xuanzhuo@linux.alibaba.com>
References: <20260208084613.2658-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 5481c6b77b7b
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257808-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanzhuo@linux.alibaba.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linux.alibaba.com,linux.dev,mucse.com,gmail.com];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 73388108200
X-Rspamd-Action: no action

Add basic driver framework for the Alibaba Elastic Ethernet Adapter(EEA).

This commit introduces the ring and descriptor implementations.

These structures and ring APIs are used by the RX, TX, and admin queues.

Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
Reviewed-by: Philo Lu <lulie@linux.alibaba.com>
Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/ethernet/alibaba/eea/Makefile   |   3 +-
 drivers/net/ethernet/alibaba/eea/eea_desc.h | 134 ++++++++++
 drivers/net/ethernet/alibaba/eea/eea_ring.c | 265 ++++++++++++++++++++
 drivers/net/ethernet/alibaba/eea/eea_ring.h |  89 +++++++
 4 files changed, 490 insertions(+), 1 deletion(-)
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
index 000000000000..90c402bd6c36
--- /dev/null
+++ b/drivers/net/ethernet/alibaba/eea/eea_desc.h
@@ -0,0 +1,134 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Driver for Alibaba Elastic Ethernet Adapter.
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
+	u8 kick_flags;
+	u8 reserved;
+	__le16 idx;
+
+	__le16 tx_cq_head;
+	__le16 rx_cq_head;
+};
+#endif
diff --git a/drivers/net/ethernet/alibaba/eea/eea_ring.c b/drivers/net/ethernet/alibaba/eea/eea_ring.c
new file mode 100644
index 000000000000..c8269dbf0d76
--- /dev/null
+++ b/drivers/net/ethernet/alibaba/eea/eea_ring.c
@@ -0,0 +1,265 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Driver for Alibaba Elastic Ethernet Adapter.
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
+	val.data = 0;
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
+	val.data = 0;
+
+	val.db.kick_flags = EEA_IRQ_UNMASK;
+
+	val.db.tx_cq_head = cpu_to_le16(tx_ering->cq.hw_idx);
+	val.db.rx_cq_head = cpu_to_le16(ering->cq.hw_idx);
+
+	writeq(val.data, (void __iomem *)ering->db);
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
+	val.data = 0;
+
+	val.db.kick_flags = EEA_IDX_PRESENT;
+	val.db.idx = cpu_to_le16(ering->sq.hw_idx);
+
+	writeq(val.data, (void __iomem *)ering->db);
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
+	gfp_t flags = GFP_KERNEL | __GFP_NOWARN;
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
+		goto err_free_sq;
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
+err_free_sq:
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
+
+	if (ering_alloc_queues(ering, edev, num, sq_desc_size, cq_desc_size))
+		goto err_free;
+
+	ering_init(ering);
+
+	return ering;
+
+err_free:
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
index 000000000000..89ec7e2a1398
--- /dev/null
+++ b/drivers/net/ethernet/alibaba/eea/eea_ring.h
@@ -0,0 +1,89 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Driver for Alibaba Elastic Ethernet Adapter.
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


