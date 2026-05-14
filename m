Return-Path: <netdev+bounces-287884-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MO8/ADabBWrAYwIAu9opvQ
	(envelope-from <netdev+bounces-287884-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 11:51:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CC153FFEE
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 11:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED6F7300697E
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 09:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A1238C2CC;
	Thu, 14 May 2026 09:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KHs0QaYK"
X-Original-To: netdev@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD25368D42
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 09:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778752307; cv=none; b=NE5IzwZCnxJLrLE/iNc+FiuSIMuZ/yvWHiKZMNmIPrQ8piKDkMfpLSop/VcNdr7hsaE9nMSPfN0eC0BLlOzQZ4uebSdUYQkDEeYgrd7sETwbG7oRnN3cEX57yZYSseCYaCfp2t/w0Cos4RtaM1uBNpS9cq4O8BthyybOnEDH8hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778752307; c=relaxed/simple;
	bh=UkJK+EX4KD9bOnt+xHZu8t0Ov9lQUVIMUzA1ilHkXC4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=slUrhZZ46Y+nj0ORQmNxCemMAbQS1Wzo1fYUj8oZ2j6Yozw5UoxbFjQNEBWf2BaN+Ep9FmtI+2CYCaDSglnb6NDYX2Bd7wHhbLJWqJoQyLwrwaPzM5gPdELJszCCtG7GC+DuCot6VVvhf72ZU2HyvBBX8fWpCmmxVSbjRP88yKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KHs0QaYK; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778752302; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=dTqc0416qRhc02v9/8+4EcxV/vKQxy8Dq1aXhmWahHA=;
	b=KHs0QaYK/sLj4SZq3h7p/s3HC6iPw/xuZtUA0EGFYRtAQ8noUf0QskiG+PsV360IOYBeblHt69Asc49HSvhlWIiTHKCOOn6Ssx79MULNECxqKvopNvFcgB64tTHh6z3RJaMWbIjGA6RVuuXIGDYqEyjJbDDDbiiFDcUdR3Sqs6U=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0X2wXL8b_1778752300;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X2wXL8b_1778752300 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 14 May 2026 17:51:41 +0800
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
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Dong Yibo <dong100@mucse.com>,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Dust Li <dust.li@linux.alibaba.com>
Subject: [PATCH net-next v43 2/8] eea: introduce ring and descriptor structures
Date: Thu, 14 May 2026 17:51:32 +0800
Message-Id: <20260514095138.80680-3-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20260514095138.80680-1-xuanzhuo@linux.alibaba.com>
References: <20260514095138.80680-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 1b215e28dce9
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 55CC153FFEE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-287884-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linux.alibaba.com,linux.dev,mucse.com,stu.xidian.edu.cn,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanzhuo@linux.alibaba.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,alibaba.com:email,linux.alibaba.com:mid,linux.alibaba.com:dkim]
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
 drivers/net/ethernet/alibaba/eea/eea_desc.h | 138 +++++++++++
 drivers/net/ethernet/alibaba/eea/eea_ring.c | 249 ++++++++++++++++++++
 drivers/net/ethernet/alibaba/eea/eea_ring.h |  99 ++++++++
 4 files changed, 488 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_desc.h
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_ring.c
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_ring.h

diff --git a/drivers/net/ethernet/alibaba/eea/Makefile b/drivers/net/ethernet/alibaba/eea/Makefile
index a07f3019ec1f..7d8e7e8c2f3a 100644
--- a/drivers/net/ethernet/alibaba/eea/Makefile
+++ b/drivers/net/ethernet/alibaba/eea/Makefile
@@ -1,3 +1,4 @@
 
 obj-$(CONFIG_ALIBABA_EEA) += eea.o
-eea-y := eea_pci.o
+eea-y :=  eea_ring.o \
+	eea_pci.o
diff --git a/drivers/net/ethernet/alibaba/eea/eea_desc.h b/drivers/net/ethernet/alibaba/eea/eea_desc.h
new file mode 100644
index 000000000000..8d94a0f0f237
--- /dev/null
+++ b/drivers/net/ethernet/alibaba/eea/eea_desc.h
@@ -0,0 +1,138 @@
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
+#define EEA_DESC_TS_MASK GENMASK_ULL(47, 0)
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
+struct eea_rx_desc_no_hdr {
+	__le16 flags;
+	__le16 id;
+	__le16 len;
+	__le16 reserved1;
+
+	__le64 addr;
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
+#define EEA_RX_CDESC_HDR_LEN_MASK GENMASK_ULL(9, 0)
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
+};
+
+#define EEA_DB_FLAGS_OFF      0
+#define EEA_DB_IDX_OFF        (2 * 8)
+#define EEA_DB_TX_CQ_HEAD_OFF (4 * 8)
+#define EEA_DB_RX_CQ_HEAD_OFF (6 * 8)
+
+#define EEA_IDX_PRESENT   BIT(0)
+#define EEA_IRQ_MASK      BIT(1)
+#define EEA_IRQ_UNMASK    BIT(2)
+#endif
diff --git a/drivers/net/ethernet/alibaba/eea/eea_ring.c b/drivers/net/ethernet/alibaba/eea/eea_ring.c
new file mode 100644
index 000000000000..99dcabd094b8
--- /dev/null
+++ b/drivers/net/ethernet/alibaba/eea/eea_ring.c
@@ -0,0 +1,249 @@
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
+void eea_ering_irq_active(struct eea_ring *ering, struct eea_ring *tx_ering)
+{
+	u64 value = 0, rx_idx, tx_idx;
+
+	tx_idx = (u64)tx_ering->cq.hw_idx;
+	rx_idx = (u64)ering->cq.hw_idx;
+
+	value |= EEA_IRQ_UNMASK << EEA_DB_FLAGS_OFF;
+	value |= tx_idx << EEA_DB_TX_CQ_HEAD_OFF;
+	value |= rx_idx << EEA_DB_RX_CQ_HEAD_OFF;
+
+	writeq(value, ering->db);
+}
+
+void *eea_ering_cq_get_desc(const struct eea_ring *ering)
+{
+	u8 phase;
+	u8 *desc;
+
+	desc = ering->cq.desc + (ering->cq.head << ering->cq.desc_size_shift);
+
+	phase = READ_ONCE(*(u8 *)(desc + ering->cq.desc_size - 1));
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
+void *eea_ering_sq_alloc_desc(struct eea_ring *ering, u16 id, bool is_last,
+			      u16 flags)
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
+/* This is an allocation API for admin Q. For each call to admin Q, only one
+ * desc will be allocated.
+ */
+void *eea_ering_aq_alloc_desc(struct eea_ring *ering)
+{
+	struct eea_ring_sq *sq = &ering->sq;
+	struct eea_common_desc *desc;
+
+	if (!sq->shadow_num)
+		sq->shadow_idx = sq->head;
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
+void eea_ering_sq_commit_desc(struct eea_ring *ering)
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
+void eea_ering_sq_cancel(struct eea_ring *ering)
+{
+	ering->sq.shadow_num = 0;
+}
+
+/* cq api */
+void eea_ering_cq_ack_desc(struct eea_ring *ering, u32 num)
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
+void eea_ering_kick(struct eea_ring *ering)
+{
+	u64 value = 0, idx;
+
+	idx = (u64)ering->sq.hw_idx;
+
+	value |= EEA_IDX_PRESENT << EEA_DB_FLAGS_OFF;
+	value |= idx << EEA_DB_IDX_OFF;
+
+	writeq(value, ering->db);
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
+			      size_t num, u8 sq_desc_size, u8 cq_desc_size)
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
+struct eea_ring *eea_ering_alloc(u32 index, u32 num, struct eea_device *edev,
+				 u8 sq_desc_size, u8 cq_desc_size,
+				 const char *name)
+{
+	struct eea_ring *ering;
+
+	if (num > EEA_NET_IO_HW_RING_DEPTH_MAX ||
+	    num < EEA_NET_IO_RING_DEPTH_MIN)
+		return NULL;
+
+	if (!is_power_of_2(num))
+		return NULL;
+
+	if (!sq_desc_size || !is_power_of_2(sq_desc_size))
+		return NULL;
+
+	if (!cq_desc_size || !is_power_of_2(cq_desc_size))
+		return NULL;
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
+void eea_ering_free(struct eea_ring *ering)
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
index 000000000000..a7ce465943a5
--- /dev/null
+++ b/drivers/net/ethernet/alibaba/eea/eea_ring.h
@@ -0,0 +1,99 @@
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
+/* These two values define the bounds for the queue depth returned by the
+ * hardware.
+ */
+#define EEA_NET_IO_HW_RING_DEPTH_MAX (32 * 1024)
+#define EEA_NET_IO_HW_RING_DEPTH_MIN 128
+
+/* This value constrains the minimum queue depth that the driver configures for
+ * the hardware, which typically applies to user-provided settings. Naturally,
+ * the configured depth must also not exceed the maximum capacity supported by
+ * the hardware.
+ */
+#define EEA_NET_IO_RING_DEPTH_MIN 64
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
+	u32 num;
+
+	u32 num_free;
+
+	struct eea_ring_sq sq;
+	struct eea_ring_cq cq;
+};
+
+struct eea_ring *eea_ering_alloc(u32 index, u32 num, struct eea_device *edev,
+				 u8 sq_desc_size, u8 cq_desc_size,
+				 const char *name);
+void eea_ering_free(struct eea_ring *ering);
+void eea_ering_kick(struct eea_ring *ering);
+
+void *eea_ering_sq_alloc_desc(struct eea_ring *ering, u16 id,
+			      bool is_last, u16 flags);
+void *eea_ering_aq_alloc_desc(struct eea_ring *ering);
+void eea_ering_sq_commit_desc(struct eea_ring *ering);
+void eea_ering_sq_cancel(struct eea_ring *ering);
+
+void eea_ering_cq_ack_desc(struct eea_ring *ering, u32 num);
+
+void eea_ering_irq_active(struct eea_ring *ering, struct eea_ring *tx_ering);
+void *eea_ering_cq_get_desc(const struct eea_ring *ering);
+#endif
-- 
2.32.0.3.g01195cf9f


