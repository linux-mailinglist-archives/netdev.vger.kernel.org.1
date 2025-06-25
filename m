Return-Path: <netdev+bounces-201146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8E4AE844E
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 15:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB2B51888C5F
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 13:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818A1266B6B;
	Wed, 25 Jun 2025 13:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R65+/fuF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5220A266B40;
	Wed, 25 Jun 2025 13:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750857359; cv=none; b=sN7qbIrSOhaubJRPf2kRSfrOXJFOTozeVVI2ne4lMGnTScl8Antg1hpiI3FmMrWRGbkb6MdsyyxzYCbAwB/XHS9yokNC9JjJkjpfPOrCwBkClZTH+Z4YYCu4DBcXaJ0xsm1OUHEH5fghaPzS55LCI8QZs+OoatgNWyEfj9UcSEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750857359; c=relaxed/simple;
	bh=6FGvTFiznU/YaYWH3NC0Q28wP/NFxB0CJ852Q7yLWto=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ObJPix1RnC6GqBFCD7tSe+ERG23W8LZIUVT78/lTmeJgdxeLuFJIpIgLgLQpNEVCnNfXrWhmdHoXr6W/KR56LKdNO0bLC9u+rdBPTecVd4cGfXfTPC+Ao2CFRaIBY0SuTqZgSGulHW3iXJRiIcdkK6xY1lxHjqwNjZseHcVHVz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R65+/fuF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 016BAC4CEF5;
	Wed, 25 Jun 2025 13:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750857359;
	bh=6FGvTFiznU/YaYWH3NC0Q28wP/NFxB0CJ852Q7yLWto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R65+/fuFoMFU0nJIJeS/jVGsx/DWb6yzZE6aM/rohakai6HSG82IGaVrnWeiV/C8P
	 brcsURjy1Z+9jZAftBRxadvrGHiqoFRBFShE3UNt+oljVf5NLZorwE/Z76eKxNwpJf
	 LGBkUo9HdQyFKpHnVsJ+zB/vfxu326X0Q4bHUkFWSMWCT/0kF1TQFlc5F0RVT8onVO
	 IA2GgiX/xH5wc8FIEmFI0pfii7KCjvoEOI1UcUp7hwmySLjV87u+9ac8wcMxwVJf8v
	 NxTe1hjpUBwNRElVPZUFXEkI7Eac5F8uJAatwVidHBfuva99H+BiW0Hnpu4sJ+c9oB
	 Q1W2ACLbErhvg==
From: Will Deacon <will@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Will Deacon <will@kernel.org>,
	Keir Fraser <keirf@google.com>,
	Steven Moreland <smoreland@google.com>,
	Frederick Mayle <fmayle@google.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH 3/5] vhost/vsock: Allocate nonlinear SKBs for handling large receive buffers
Date: Wed, 25 Jun 2025 14:15:41 +0100
Message-Id: <20250625131543.5155-4-will@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250625131543.5155-1-will@kernel.org>
References: <20250625131543.5155-1-will@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When receiving a packet from a guest, vhost_vsock_handle_tx_kick()
calls vhost_vsock_alloc_skb() to allocate and fill an SKB with the
receive data. Unfortunately, these are always linear allocations and can
therefore result in significant pressure on kmalloc() considering that
the maximum packet size (VIRTIO_VSOCK_MAX_PKT_BUF_SIZE +
VIRTIO_VSOCK_SKB_HEADROOM) is a little over 64KiB, resulting in a 128KiB
allocation for each packet.

Rework the vsock SKB allocation so that, for sizes with page order
greater than PAGE_ALLOC_COSTLY_ORDER, a nonlinear SKB is allocated
instead with the packet header in the SKB and the receive data in the
fragments.

Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/vhost/vsock.c        | 15 +++++++++------
 include/linux/virtio_vsock.h | 31 +++++++++++++++++++++++++------
 2 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 66a0f060770e..cfa4e1bcf367 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -344,11 +344,16 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
 
 	len = iov_length(vq->iov, out);
 
-	if (len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADROOM)
+	if (len < VIRTIO_VSOCK_SKB_HEADROOM ||
+	    len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADROOM)
 		return NULL;
 
 	/* len contains both payload and hdr */
-	skb = virtio_vsock_alloc_skb(len, GFP_KERNEL);
+	if (len > SKB_WITH_OVERHEAD(PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER))
+		skb = virtio_vsock_alloc_skb_with_frags(len, GFP_KERNEL);
+	else
+		skb = virtio_vsock_alloc_skb(len, GFP_KERNEL);
+
 	if (!skb)
 		return NULL;
 
@@ -377,10 +382,8 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
 
 	virtio_vsock_skb_rx_put(skb);
 
-	nbytes = copy_from_iter(skb->data, payload_len, &iov_iter);
-	if (nbytes != payload_len) {
-		vq_err(vq, "Expected %zu byte payload, got %zu bytes\n",
-		       payload_len, nbytes);
+	if (skb_copy_datagram_from_iter(skb, 0, &iov_iter, payload_len)) {
+		vq_err(vq, "Failed to copy %zu byte payload\n", payload_len);
 		kfree_skb(skb);
 		return NULL;
 	}
diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 67ffb64325ef..8f9fa1cab32a 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -51,27 +51,46 @@ static inline void virtio_vsock_skb_rx_put(struct sk_buff *skb)
 {
 	u32 len;
 
+	DEBUG_NET_WARN_ON_ONCE(skb->len);
 	len = le32_to_cpu(virtio_vsock_hdr(skb)->len);
 
-	if (len > 0)
+	if (skb_is_nonlinear(skb))
+		skb->len = len;
+	else
 		skb_put(skb, len);
 }
 
-static inline struct sk_buff *virtio_vsock_alloc_skb(unsigned int size, gfp_t mask)
+static inline struct sk_buff *
+__virtio_vsock_alloc_skb_with_frags(unsigned int header_len,
+				    unsigned int data_len,
+				    gfp_t mask)
 {
 	struct sk_buff *skb;
+	int err;
 
-	if (size < VIRTIO_VSOCK_SKB_HEADROOM)
-		return NULL;
-
-	skb = alloc_skb(size, mask);
+	skb = alloc_skb_with_frags(header_len, data_len,
+				   PAGE_ALLOC_COSTLY_ORDER, &err, mask);
 	if (!skb)
 		return NULL;
 
 	skb_reserve(skb, VIRTIO_VSOCK_SKB_HEADROOM);
+	skb->data_len = data_len;
 	return skb;
 }
 
+static inline struct sk_buff *
+virtio_vsock_alloc_skb_with_frags(unsigned int size, gfp_t mask)
+{
+	size -= VIRTIO_VSOCK_SKB_HEADROOM;
+	return __virtio_vsock_alloc_skb_with_frags(VIRTIO_VSOCK_SKB_HEADROOM,
+						   size, mask);
+}
+
+static inline struct sk_buff *virtio_vsock_alloc_skb(unsigned int size, gfp_t mask)
+{
+	return __virtio_vsock_alloc_skb_with_frags(size, 0, mask);
+}
+
 static inline void
 virtio_vsock_skb_queue_head(struct sk_buff_head *list, struct sk_buff *skb)
 {
-- 
2.50.0.714.g196bf9f422-goog


