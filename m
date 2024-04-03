Return-Path: <netdev+bounces-84608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7157389799E
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 22:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24C882837B7
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 20:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFDC1553B3;
	Wed,  3 Apr 2024 20:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMUzLPiR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B935E156240
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 20:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712174960; cv=none; b=XVyvmquLk6nabgcw3WvyqdMsbCKnPyokWV49V8uGGMhaymQcq92ect1pnGSXs4HsxdsLiKpAGyEMCFulWKrYTTSn3W+waTdq425McknD9FOsPo60KwBn+/lrKrMy/PmosgxU7K9qRypKKBILIV4X3pRqc2yjGDDvs8Hkyg79lnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712174960; c=relaxed/simple;
	bh=hXHLOrUbaPK4t8JTLIRRCdriWfmTxhWllRIOfi6fA6Y=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dlYlOaVVS0XhM1ZEkMBhRM0wJQvKrRwCfiN0qedOncsFSEEnIuxGS9seTyQce8QMzITQTXFeZDEN/ylNtosjk0W1Pc2rzqpuDJCgYet6Mg8xZSGTC5mbGCMbS72TU3bLW/H9G+fDm3Ud/uf5Nd6plmKRBVc19w5ppzVD7uozOIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YMUzLPiR; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e6b6f86975so160815b3a.1
        for <netdev@vger.kernel.org>; Wed, 03 Apr 2024 13:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712174958; x=1712779758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=db2Zi8gUKhvG2OYZvelvNuSUVR4ymhA84T8mia8RnMY=;
        b=YMUzLPiRQgITv+w1Oa/86Qa02gvg64CUi/63cyk+EgkVav1loY2knHKaQ1FxsLvRf8
         g1NYN1BM6r2X8yThexH+1+BsuklBsnzrQE1S6jVY/9R7nmicjSHrai2Yqa512KbzrHpp
         emlO6O0fWo33KCNT5U4xh0DeskHixnbIxbvuUwyAjreEtSg696s9MUhvH/kEu6VtStZ9
         n+bXO8tXfJ7iNxS6uwygnvjVun2BWlMKTUiAYBa2qcI9w4NRIhnYzQ4PQaFsfUq3zooi
         gu8bm/ad1ryRodrzYkNnpoddrv9JcEWwlihJlSJfp4paBT4UU/FW37STy+8GWG0cJ2w4
         OvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712174958; x=1712779758;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=db2Zi8gUKhvG2OYZvelvNuSUVR4ymhA84T8mia8RnMY=;
        b=BhignIw1PxR4VXhxwzCvH+kyfbQ9BIKwfeXDj4wWXCQWb7IBaJH/1bdbZAVtEF9MjW
         PxBpD9HeaEuHQkK0yvd9jfsUFZsr/GW2H2WANtJRNOo8WyPfvsDaBM4ViLeEQhT3moVp
         h7StWhg967b1fzZuZfe0Rh/HPAxAkwc1aKP9E1QdL0lYFzf2mbvu2+q38WA2jq+3a5cm
         i8QIddhZ7+I+hib+Sm2WNqM4IC3nAAPKXPPyqoN6FkGqVkGGEpRtomHSM/KocrVzMVjb
         ZRfviWWaHTaUJvUPwbM6SQMgbZ+JXe2QFyB84RBVhwYsYtdTPHa1tTcGIGDUoOVtN459
         sq4Q==
X-Gm-Message-State: AOJu0YyzB4CwfXJ8hVDP+3QCOJ6ZdlUqAUHuY6T4RjC5XMwn9LOuRfB3
	8fLf6WNA3btXSk5t2UtMnsgGFY/hJd16EN6cZbBhLLMRzzPre7ga
X-Google-Smtp-Source: AGHT+IETIRKbtHiaARtw3B8Q/8zXV9jvs2TD+tqwE8unGxLHef47mACFffe62Cj9IjTr4dcu5qBVUQ==
X-Received: by 2002:a05:6a00:140e:b0:6ec:da37:d09 with SMTP id l14-20020a056a00140e00b006ecda370d09mr642459pfu.16.1712174957923;
        Wed, 03 Apr 2024 13:09:17 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([98.97.103.43])
        by smtp.gmail.com with ESMTPSA id j18-20020a632312000000b005d6a0b2efb3sm12033422pgj.21.2024.04.03.13.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 13:09:17 -0700 (PDT)
Subject: [net-next PATCH 12/15] eth: fbnic: add basic Tx handling
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: Alexander Duyck <alexanderduyck@fb.com>, kuba@kernel.org,
 davem@davemloft.net, pabeni@redhat.com
Date: Wed, 03 Apr 2024 13:09:15 -0700
Message-ID: 
 <171217495560.1598374.4872808628328829588.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

Handle Tx of simple packets. Support checksum offload and gather.
Use .ndo_features_check to make sure packet geometry will be
supported by the HW, i.e. we can fit the header lengths into
the descriptor fields.

The device writes to the completion rings the position of the tail
(consumer) pointer. Read all those writebacks, obviously the last
one will be the most recent, complete skbs up to that point.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h    |   66 ++++
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c |    9 +
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c   |  395 ++++++++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h   |   15 +
 4 files changed, 483 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index 39c98d2dce12..0819ddc1dcc8 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -24,6 +24,72 @@
 
 #define FBNIC_CLOCK_FREQ	(600 * (1000 * 1000))
 
+/* Transmit Work Descriptor Format */
+/* Length, Type, Offset Masks and Shifts */
+#define FBNIC_TWD_L2_HLEN_MASK			DESC_GENMASK(5, 0)
+
+#define FBNIC_TWD_L3_TYPE_MASK			DESC_GENMASK(7, 6)
+enum {
+	FBNIC_TWD_L3_TYPE_OTHER	= 0,
+	FBNIC_TWD_L3_TYPE_IPV4	= 1,
+	FBNIC_TWD_L3_TYPE_IPV6	= 2,
+	FBNIC_TWD_L3_TYPE_V6V6	= 3,
+};
+
+#define FBNIC_TWD_L3_OHLEN_MASK			DESC_GENMASK(15, 8)
+#define FBNIC_TWD_L3_IHLEN_MASK			DESC_GENMASK(23, 16)
+
+enum {
+	FBNIC_TWD_L4_TYPE_OTHER	= 0,
+	FBNIC_TWD_L4_TYPE_TCP	= 1,
+	FBNIC_TWD_L4_TYPE_UDP	= 2,
+};
+
+#define FBNIC_TWD_CSUM_OFFSET_MASK		DESC_GENMASK(27, 24)
+#define FBNIC_TWD_L4_HLEN_MASK			DESC_GENMASK(31, 28)
+
+/* Flags and Type */
+#define FBNIC_TWD_L4_TYPE_MASK			DESC_GENMASK(33, 32)
+#define FBNIC_TWD_FLAG_REQ_TS			DESC_BIT(34)
+#define FBNIC_TWD_FLAG_REQ_LSO			DESC_BIT(35)
+#define FBNIC_TWD_FLAG_REQ_CSO			DESC_BIT(36)
+#define FBNIC_TWD_FLAG_REQ_COMPLETION		DESC_BIT(37)
+#define FBNIC_TWD_FLAG_DEST_MAC			DESC_BIT(43)
+#define FBNIC_TWD_FLAG_DEST_BMC			DESC_BIT(44)
+#define FBNIC_TWD_FLAG_DEST_FW			DESC_BIT(45)
+#define FBNIC_TWD_TYPE_MASK			DESC_GENMASK(47, 46)
+enum {
+	FBNIC_TWD_TYPE_META	= 0,
+	FBNIC_TWD_TYPE_OPT_META	= 1,
+	FBNIC_TWD_TYPE_AL	= 2,
+	FBNIC_TWD_TYPE_LAST_AL	= 3,
+};
+
+/* MSS and Completion Req */
+#define FBNIC_TWD_MSS_MASK			DESC_GENMASK(61, 48)
+
+#define FBNIC_TWD_TS_MASK			DESC_GENMASK(39, 0)
+#define FBNIC_TWD_ADDR_MASK			DESC_GENMASK(45, 0)
+#define FBNIC_TWD_LEN_MASK			DESC_GENMASK(63, 48)
+
+/* Tx Completion Descriptor Format */
+#define FBNIC_TCD_TYPE0_HEAD0_MASK		DESC_GENMASK(15, 0)
+#define FBNIC_TCD_TYPE0_HEAD1_MASK		DESC_GENMASK(31, 16)
+
+#define FBNIC_TCD_TYPE1_TS_MASK			DESC_GENMASK(39, 0)
+
+#define FBNIC_TCD_STATUS_MASK			DESC_GENMASK(59, 48)
+#define FBNIC_TCD_STATUS_TS_INVALID		DESC_BIT(48)
+#define FBNIC_TCD_STATUS_ILLEGAL_TS_REQ		DESC_BIT(49)
+#define FBNIC_TCD_TWQ1				DESC_BIT(60)
+#define FBNIC_TCD_TYPE_MASK			DESC_GENMASK(62, 61)
+enum {
+	FBNIC_TCD_TYPE_0	= 0,
+	FBNIC_TCD_TYPE_1	= 1,
+};
+
+#define FBNIC_TCD_DONE				DESC_BIT(63)
+
 /* Rx Buffer Descriptor Format */
 #define FBNIC_BD_PAGE_ADDR_MASK			DESC_GENMASK(45, 12)
 #define FBNIC_BD_PAGE_ID_MASK			DESC_GENMASK(63, 48)
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index c49ace7f2156..91d4ea2bfb29 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -91,6 +91,7 @@ static const struct net_device_ops fbnic_netdev_ops = {
 	.ndo_stop		= fbnic_stop,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_start_xmit		= fbnic_xmit_frame,
+	.ndo_features_check	= fbnic_features_check,
 };
 
 void fbnic_reset_queues(struct fbnic_net *fbn,
@@ -148,6 +149,14 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
 
 	fbnic_reset_queues(fbn, default_queues, default_queues);
 
+	netdev->features |=
+		NETIF_F_SG |
+		NETIF_F_HW_CSUM;
+
+	netdev->hw_features |= netdev->features;
+	netdev->vlan_features |= netdev->features;
+	netdev->hw_enc_features |= netdev->features;
+
 	netdev->min_mtu = IPV6_MIN_MTU;
 	netdev->max_mtu = FBNIC_MAX_JUMBO_FRAME_SIZE - ETH_HLEN;
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 2967ff53305a..ad4cb059c959 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) Meta Platforms, Inc. and affiliates. */
 
+#include <linux/bitfield.h>
 #include <linux/iopoll.h>
 #include <linux/pci.h>
 #include <net/netdev_queues.h>
@@ -10,6 +11,14 @@
 #include "fbnic_txrx.h"
 #include "fbnic.h"
 
+struct fbnic_xmit_cb {
+	u32 bytecount;
+	u8 desc_count;
+	int hw_head;
+};
+
+#define FBNIC_XMIT_CB(_skb) ((struct fbnic_xmit_cb *)(skb->cb))
+
 static u32 __iomem *fbnic_ring_csr_base(const struct fbnic_ring *ring)
 {
 	unsigned long csr_base = (unsigned long)ring->doorbell;
@@ -38,12 +47,313 @@ static inline unsigned int fbnic_desc_unused(struct fbnic_ring *ring)
 	return (ring->head - ring->tail - 1) & ring->size_mask;
 }
 
-netdev_tx_t fbnic_xmit_frame(struct sk_buff *skb, struct net_device *dev)
+static inline unsigned int fbnic_desc_used(struct fbnic_ring *ring)
+{
+	return (ring->tail - ring->head) & ring->size_mask;
+}
+
+static inline struct netdev_queue *txring_txq(const struct net_device *dev,
+					      const struct fbnic_ring *ring)
+{
+	return netdev_get_tx_queue(dev, ring->q_idx);
+}
+
+static inline int fbnic_maybe_stop_tx(const struct net_device *dev,
+				      struct fbnic_ring *ring,
+				      const unsigned int size)
+{
+	struct netdev_queue *txq = txring_txq(dev, ring);
+	int res;
+
+	res = netif_txq_maybe_stop(txq, fbnic_desc_unused(ring), size,
+				   FBNIC_TX_DESC_WAKEUP);
+
+	return !res;
+}
+
+static inline bool fbnic_tx_sent_queue(struct sk_buff *skb,
+				       struct fbnic_ring *ring)
+{
+	struct netdev_queue *dev_queue = txring_txq(skb->dev, ring);
+	unsigned int bytecount = FBNIC_XMIT_CB(skb)->bytecount;
+	bool xmit_more = netdev_xmit_more();
+
+	/* TBD: Request completion more often if xmit_more becomes large */
+
+	return __netdev_tx_sent_queue(dev_queue, bytecount, xmit_more);
+}
+
+static void fbnic_unmap_single_twd(struct device *dev, __le64 *twd)
+{
+	u64 raw_twd = le64_to_cpu(*twd);
+	unsigned int len;
+	dma_addr_t dma;
+
+	dma = FIELD_GET(FBNIC_TWD_ADDR_MASK, raw_twd);
+	len = FIELD_GET(FBNIC_TWD_LEN_MASK, raw_twd);
+
+	dma_unmap_single(dev, dma, len, DMA_TO_DEVICE);
+}
+
+static void fbnic_unmap_page_twd(struct device *dev, __le64 *twd)
+{
+	u64 raw_twd = le64_to_cpu(*twd);
+	unsigned int len;
+	dma_addr_t dma;
+
+	dma = FIELD_GET(FBNIC_TWD_ADDR_MASK, raw_twd);
+	len = FIELD_GET(FBNIC_TWD_LEN_MASK, raw_twd);
+
+	dma_unmap_page(dev, dma, len, DMA_TO_DEVICE);
+}
+
+#define FBNIC_TWD_TYPE(_type) \
+	cpu_to_le64(FIELD_PREP(FBNIC_TWD_TYPE_MASK, FBNIC_TWD_TYPE_##_type))
+
+static bool
+fbnic_tx_offloads(struct fbnic_ring *ring, struct sk_buff *skb, __le64 *meta)
+{
+	unsigned int l2len, i3len;
+
+	if (unlikely(skb->ip_summed != CHECKSUM_PARTIAL))
+		return false;
+
+	l2len = skb_mac_header_len(skb);
+	i3len = skb_checksum_start(skb) - skb_network_header(skb);
+
+	*meta |= cpu_to_le64(FIELD_PREP(FBNIC_TWD_CSUM_OFFSET_MASK,
+					skb->csum_offset / 2));
+
+	*meta |= cpu_to_le64(FBNIC_TWD_FLAG_REQ_CSO);
+
+	*meta |= cpu_to_le64(FIELD_PREP(FBNIC_TWD_L2_HLEN_MASK, l2len / 2) |
+			     FIELD_PREP(FBNIC_TWD_L3_IHLEN_MASK, i3len / 2));
+	return false;
+}
+
+static bool
+fbnic_tx_map(struct fbnic_ring *ring, struct sk_buff *skb, __le64 *meta)
 {
+	struct device *dev = skb->dev->dev.parent;
+	unsigned int tail = ring->tail, first;
+	unsigned int size, data_len;
+	skb_frag_t *frag;
+	dma_addr_t dma;
+	__le64 *twd;
+
+	ring->tx_buf[tail] = skb;
+
+	tail++;
+	tail &= ring->size_mask;
+	first = tail;
+
+	size = skb_headlen(skb);
+	data_len = skb->data_len;
+
+	if (size > FIELD_MAX(FBNIC_TWD_LEN_MASK))
+		goto dma_error;
+
+	dma = dma_map_single(dev, skb->data, size, DMA_TO_DEVICE);
+
+	for (frag = &skb_shinfo(skb)->frags[0];; frag++) {
+		twd = &ring->desc[tail];
+
+		if (dma_mapping_error(dev, dma))
+			goto dma_error;
+
+		*twd = cpu_to_le64(FIELD_PREP(FBNIC_TWD_ADDR_MASK, dma) |
+				   FIELD_PREP(FBNIC_TWD_LEN_MASK, size) |
+				   FIELD_PREP(FBNIC_TWD_TYPE_MASK,
+					      FBNIC_TWD_TYPE_AL));
+
+		tail++;
+		tail &= ring->size_mask;
+
+		if (!data_len)
+			break;
+
+		size = skb_frag_size(frag);
+		data_len -= size;
+
+		if (size > FIELD_MAX(FBNIC_TWD_LEN_MASK))
+			goto dma_error;
+
+		dma = skb_frag_dma_map(dev, frag, 0, size, DMA_TO_DEVICE);
+	}
+
+	*twd |= FBNIC_TWD_TYPE(LAST_AL);
+
+	FBNIC_XMIT_CB(skb)->desc_count = ((twd - meta) + 1) & ring->size_mask;
+
+	ring->tail = tail;
+
+	/* Verify there is room for another packet */
+	fbnic_maybe_stop_tx(skb->dev, ring, FBNIC_MAX_SKB_DESC);
+
+	if (fbnic_tx_sent_queue(skb, ring)) {
+		*meta |= cpu_to_le64(FBNIC_TWD_FLAG_REQ_COMPLETION);
+
+		/* Force DMA writes to flush before writing to tail */
+		dma_wmb();
+
+		writel(tail, ring->doorbell);
+	}
+
+	return false;
+dma_error:
+	if (net_ratelimit())
+		netdev_err(skb->dev, "TX DMA map failed\n");
+
+	while (tail != first) {
+		tail--;
+		tail &= ring->size_mask;
+		twd = &ring->desc[tail];
+		if (tail == first)
+			fbnic_unmap_single_twd(dev, twd);
+		else
+			fbnic_unmap_page_twd(dev, twd);
+	}
+
+	return true;
+}
+
+#define FBNIC_MIN_FRAME_LEN	60
+
+static netdev_tx_t
+fbnic_xmit_frame_ring(struct sk_buff *skb, struct fbnic_ring *ring)
+{
+	__le64 *meta = &ring->desc[ring->tail];
+	u16 desc_needed;
+
+	if (skb_put_padto(skb, FBNIC_MIN_FRAME_LEN))
+		goto err_count;
+
+	/* need: 1 descriptor per page,
+	 *       + 1 desc for skb_head,
+	 *       + 2 desc for metadata and timestamp metadata
+	 *       + 7 desc gap to keep tail from touching head
+	 * otherwise try next time
+	 */
+	desc_needed = skb_shinfo(skb)->nr_frags + 10;
+	if (fbnic_maybe_stop_tx(skb->dev, ring, desc_needed))
+		return NETDEV_TX_BUSY;
+
+	*meta = cpu_to_le64(FBNIC_TWD_FLAG_DEST_MAC);
+
+	/* Write all members within DWORD to condense this into 2 4B writes */
+	FBNIC_XMIT_CB(skb)->bytecount = skb->len;
+	FBNIC_XMIT_CB(skb)->desc_count = 0;
+
+	if (fbnic_tx_offloads(ring, skb, meta))
+		goto err_free;
+
+	if (fbnic_tx_map(ring, skb, meta))
+		goto err_free;
+
+	return NETDEV_TX_OK;
+
+err_free:
 	dev_kfree_skb_any(skb);
+err_count:
 	return NETDEV_TX_OK;
 }
 
+netdev_tx_t fbnic_xmit_frame(struct sk_buff *skb, struct net_device *dev)
+{
+	struct fbnic_net *fbn = netdev_priv(dev);
+	unsigned int q_map = skb->queue_mapping;
+
+	return fbnic_xmit_frame_ring(skb, fbn->tx[q_map]);
+}
+
+netdev_features_t
+fbnic_features_check(struct sk_buff *skb, struct net_device *dev,
+		     netdev_features_t features)
+{
+	unsigned int l2len, l3len;
+
+	if (unlikely(skb->ip_summed != CHECKSUM_PARTIAL))
+		return features;
+
+	l2len = skb_mac_header_len(skb);
+	l3len = skb_checksum_start(skb) - skb_network_header(skb);
+
+	/* Check header lengths are multiple of 2.
+	 * In case of 6in6 we support longer headers (IHLEN + OHLEN)
+	 * but keep things simple for now, 512B is plenty.
+	 */
+	if ((l2len | l3len | skb->csum_offset) % 2 ||
+	    !FIELD_FIT(FBNIC_TWD_L2_HLEN_MASK, l2len / 2) ||
+	    !FIELD_FIT(FBNIC_TWD_L3_IHLEN_MASK, l3len / 2) ||
+	    !FIELD_FIT(FBNIC_TWD_CSUM_OFFSET_MASK, skb->csum_offset / 2))
+		return features & ~NETIF_F_CSUM_MASK;
+
+	return features;
+}
+
+static void fbnic_clean_twq0(struct fbnic_napi_vector *nv, int napi_budget,
+			     struct fbnic_ring *ring, bool discard,
+			     unsigned int hw_head)
+{
+	u64 total_bytes = 0, total_packets = 0;
+	unsigned int head = ring->head;
+	struct netdev_queue *txq;
+	unsigned int clean_desc;
+
+	clean_desc = (hw_head - head) & ring->size_mask;
+
+	while (clean_desc) {
+		struct sk_buff *skb = ring->tx_buf[head];
+		unsigned int desc_cnt;
+
+		desc_cnt = FBNIC_XMIT_CB(skb)->desc_count;
+		if (desc_cnt > clean_desc)
+			break;
+
+		ring->tx_buf[head] = NULL;
+
+		clean_desc -= desc_cnt;
+
+		while (!(ring->desc[head] & FBNIC_TWD_TYPE(AL))) {
+			head++;
+			head &= ring->size_mask;
+			desc_cnt--;
+		}
+
+		fbnic_unmap_single_twd(nv->dev, &ring->desc[head]);
+		head++;
+		head &= ring->size_mask;
+		desc_cnt--;
+
+		while (desc_cnt--) {
+			fbnic_unmap_page_twd(nv->dev, &ring->desc[head]);
+			head++;
+			head &= ring->size_mask;
+		}
+
+		total_bytes += FBNIC_XMIT_CB(skb)->bytecount;
+		total_packets += 1;
+
+		napi_consume_skb(skb, napi_budget);
+	}
+
+	if (!total_bytes)
+		return;
+
+	ring->head = head;
+
+	txq = txring_txq(nv->napi.dev, ring);
+
+	if (unlikely(discard)) {
+		netdev_tx_completed_queue(txq, total_packets, total_bytes);
+		return;
+	}
+
+	netif_txq_completed_wake(txq, total_packets, total_bytes,
+				 fbnic_desc_unused(ring),
+				 FBNIC_TX_DESC_WAKEUP);
+}
+
 static void fbnic_page_pool_init(struct fbnic_ring *ring, unsigned int idx,
 				 struct page *page)
 {
@@ -66,6 +376,65 @@ static void fbnic_page_pool_drain(struct fbnic_ring *ring, unsigned int idx,
 	rx_buf->page = NULL;
 }
 
+static void fbnic_clean_twq(struct fbnic_napi_vector *nv, int napi_budget,
+			    struct fbnic_q_triad *qt, s32 head0)
+{
+	if (head0 >= 0)
+		fbnic_clean_twq0(nv, napi_budget, &qt->sub0, false, head0);
+}
+
+static void
+fbnic_clean_tcq(struct fbnic_napi_vector *nv, struct fbnic_q_triad *qt,
+		int napi_budget)
+{
+	struct fbnic_ring *cmpl = &qt->cmpl;
+	__le64 *raw_tcd, done;
+	u32 head = cmpl->head;
+	s32 head0 = -1;
+
+	done = (head & (cmpl->size_mask + 1)) ? 0 : cpu_to_le64(FBNIC_TCD_DONE);
+	raw_tcd = &cmpl->desc[head & cmpl->size_mask];
+
+	/* Walk the completion queue collecting the heads reported by NIC */
+	while ((*raw_tcd & cpu_to_le64(FBNIC_TCD_DONE)) == done) {
+		u64 tcd;
+
+		dma_rmb();
+
+		tcd = le64_to_cpu(*raw_tcd);
+
+		switch (FIELD_GET(FBNIC_TCD_TYPE_MASK, tcd)) {
+		case FBNIC_TCD_TYPE_0:
+			if (!(tcd & FBNIC_TCD_TWQ1))
+				head0 = FIELD_GET(FBNIC_TCD_TYPE0_HEAD0_MASK,
+						  tcd);
+			/* Currently all err status bits are related to
+			 * timestamps and as those have yet to be added
+			 * they are skipped for now.
+			 */
+			break;
+		default:
+			break;
+		}
+
+		raw_tcd++;
+		head++;
+		if (!(head & cmpl->size_mask)) {
+			done ^= cpu_to_le64(FBNIC_TCD_DONE);
+			raw_tcd = &cmpl->desc[0];
+		}
+	}
+
+	/* Record the current head/tail of the queue */
+	if (cmpl->head != head) {
+		cmpl->head = head;
+		writel(head & cmpl->size_mask, cmpl->doorbell);
+	}
+
+	/* Unmap and free processed buffers */
+	fbnic_clean_twq(nv, napi_budget, qt, head0);
+}
+
 static void fbnic_clean_bdq(struct fbnic_napi_vector *nv, int napi_budget,
 			    struct fbnic_ring *ring, unsigned int hw_head)
 {
@@ -153,7 +522,7 @@ static void fbnic_put_pkt_buff(struct fbnic_napi_vector *nv,
 	page = virt_to_page(pkt->buff.data_hard_start);
 	page_pool_put_full_page(nv->page_pool, page, !!budget);
 	pkt->buff.data_hard_start = NULL;
-}
+};
 
 static void fbnic_nv_irq_disable(struct fbnic_napi_vector *nv)
 {
@@ -163,8 +532,27 @@ static void fbnic_nv_irq_disable(struct fbnic_napi_vector *nv)
 	wr32(FBNIC_INTR_MASK_SET(v_idx / 32), 1 << (v_idx % 32));
 }
 
+static void fbnic_nv_irq_rearm(struct fbnic_napi_vector *nv)
+{
+	struct fbnic_dev *fbd = nv->fbd;
+	u32 v_idx = nv->v_idx;
+
+	wr32(FBNIC_INTR_CQ_REARM(v_idx), FBNIC_INTR_CQ_REARM_INTR_UNMASK);
+}
+
 static int fbnic_poll(struct napi_struct *napi, int budget)
 {
+	struct fbnic_napi_vector *nv = container_of(napi,
+						    struct fbnic_napi_vector,
+						    napi);
+	int i;
+
+	for (i = 0; i < nv->txt_count; i++)
+		fbnic_clean_tcq(nv, &nv->qt[i], budget);
+
+	if (likely(napi_complete_done(napi, 0)))
+		fbnic_nv_irq_rearm(nv);
+
 	return 0;
 }
 
@@ -896,6 +1284,9 @@ void fbnic_flush(struct fbnic_net *fbn)
 			struct fbnic_q_triad *qt = &nv->qt[i];
 			struct netdev_queue *tx_queue;
 
+			/* Clean the work queues of unprocessed work */
+			fbnic_clean_twq0(nv, 0, &qt->sub0, true, qt->sub0.tail);
+
 			/* Reset completion queue descriptor ring */
 			memset(qt->cmpl.desc, 0, qt->cmpl.size);
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
index 812e4bb245db..0c424c49866d 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
@@ -10,6 +10,18 @@
 
 struct fbnic_net;
 
+/* Guarantee we have space needed for storing the buffer
+ * To store the buffer we need:
+ *	1 descriptor per page
+ *	+ 1 descriptor for skb head
+ *	+ 2 descriptors for metadata and optional metadata
+ *	+ 7 descriptors to keep tail out of the same cachline as head
+ * If we cannot guarantee that then we should return TX_BUSY
+ */
+#define FBNIC_MAX_SKB_DESC	(MAX_SKB_FRAGS + 10)
+#define FBNIC_TX_DESC_WAKEUP	(FBNIC_MAX_SKB_DESC * 2)
+#define FBNIC_TX_DESC_MIN	roundup_pow_of_two(FBNIC_TX_DESC_WAKEUP)
+
 #define FBNIC_MAX_TXQS			128u
 #define FBNIC_MAX_RXQS			128u
 
@@ -90,6 +102,9 @@ struct fbnic_napi_vector {
 #define FBNIC_MAX_RXQS			128u
 
 netdev_tx_t fbnic_xmit_frame(struct sk_buff *skb, struct net_device *dev);
+netdev_features_t
+fbnic_features_check(struct sk_buff *skb, struct net_device *dev,
+		     netdev_features_t features);
 
 int fbnic_alloc_napi_vectors(struct fbnic_net *fbn);
 void fbnic_free_napi_vectors(struct fbnic_net *fbn);



