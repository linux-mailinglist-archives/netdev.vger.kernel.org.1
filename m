Return-Path: <netdev+bounces-202986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B34BDAF0088
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 18:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A654525D1D
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 16:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAFA28507B;
	Tue,  1 Jul 2025 16:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dnu8kSMM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336C0285074;
	Tue,  1 Jul 2025 16:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751388332; cv=none; b=AYAlcD7u4I1pAP3prXPPSpV2jCE23vWW9XWcR4z7ma2Q2NYSCORd4PM7XVCN8pcaDPdS8DawzOvRw9LTKDZYeq0BpRumxHPvgl3J0wkeAqGQuJ2z95t/+ONnmxSwomPewt3R2Et+FN50oqXcREOvy3ywtIKXSopjolWl5OFPqrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751388332; c=relaxed/simple;
	bh=WW0Oy/HLwiKqJEO7w3O99UJACNVQrCQ/O89R8zhmn8M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dQsxGlR2iM5lXjzszTSf+OwapVX8h+ygH+SXJsP04SPtFOljdonLEJcBt189SHbiTcfO7ZYBiygnpgajOmBRqiFcm9G8GQw+5XNnVBnS6WQYvWpOMu4Vz75OA78ocz98QqWuVTRl+TZBwYrr/JdRivjI6eiG/58UfIE7XqWDVmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dnu8kSMM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 883AFC4CEF1;
	Tue,  1 Jul 2025 16:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751388331;
	bh=WW0Oy/HLwiKqJEO7w3O99UJACNVQrCQ/O89R8zhmn8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dnu8kSMMtJ3xfoOanUIdgAEQh2nmF0yLNOuZrcyhW+JGpIiGU7uEtEfJkOYsyEjP0
	 +WF+m25K4ZPIH3S433be3X9J6ItMKqKZxPlY+DWpH7Vcq3o3BvIWebfi8C/3cAYAKx
	 UlZInKiM5Z78Q4YVgEJ65zVe+GE7Daqcd+PA57XOGzwgEXGZmZyjwU+mrsoZ4svnWY
	 S75hpaaxIy56PbIjzaIESjzryQERzI2SjuO0N0uDbocHMxUdtYbD6Atu3AwmwyH1cM
	 g0zZj5yrbZ0vhVwrZIfDoqk26zudURykM+woIQCUlAZ2F4glkjRQqxNZ4EjXgJI0Lf
	 j0oyZGaZf73HQ==
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
Subject: [PATCH v2 6/8] vhost/vsock: Allocate nonlinear SKBs for handling large receive buffers
Date: Tue,  1 Jul 2025 17:45:05 +0100
Message-Id: <20250701164507.14883-7-will@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250701164507.14883-1-will@kernel.org>
References: <20250701164507.14883-1-will@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When receiving a packet from a guest, vhost_vsock_handle_tx_kick()
calls vhost_vsock_alloc_linear_skb() to allocate and fill an SKB with
the receive data. Unfortunately, these are always linear allocations and
can therefore result in significant pressure on kmalloc() considering
that the maximum packet size (VIRTIO_VSOCK_MAX_PKT_BUF_SIZE +
VIRTIO_VSOCK_SKB_HEADROOM) is a little over 64KiB, resulting in a 128KiB
allocation for each packet.

Rework the vsock SKB allocation so that, for sizes with page order
greater than PAGE_ALLOC_COSTLY_ORDER, a nonlinear SKB is allocated
instead with the packet header in the SKB and the receive data in the
fragments. Move the VIRTIO_VSOCK_SKB_HEADROOM check out of the
allocation function and into the single caller that needs it and add a
debug warning if virtio_vsock_skb_rx_put() is ever called on an SKB with
a non-zero length, as this would be destructive for the nonlinear case.

Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/vhost/vsock.c        | 11 +++++------
 include/linux/virtio_vsock.h | 32 +++++++++++++++++++++++++-------
 2 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index b13f6be452ba..f3c2ea1d0ae7 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -344,11 +344,12 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
 
 	len = iov_length(vq->iov, out);
 
-	if (len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADROOM)
+	if (len < VIRTIO_VSOCK_SKB_HEADROOM ||
+	    len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADROOM)
 		return NULL;
 
 	/* len contains both payload and hdr */
-	skb = virtio_vsock_alloc_linear_skb(len, GFP_KERNEL);
+	skb = virtio_vsock_alloc_skb(len, GFP_KERNEL);
 	if (!skb)
 		return NULL;
 
@@ -377,10 +378,8 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
 
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
index 6d4a933c895a..ad69668f6b91 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -51,29 +51,47 @@ static inline void virtio_vsock_skb_rx_put(struct sk_buff *skb)
 {
 	u32 len;
 
+	DEBUG_NET_WARN_ON_ONCE(skb->len);
 	len = le32_to_cpu(virtio_vsock_hdr(skb)->len);
-	skb_put(skb, len);
+
+	if (skb_is_nonlinear(skb))
+		skb->len = len;
+	else
+		skb_put(skb, len);
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
 
 static inline struct sk_buff *
 virtio_vsock_alloc_linear_skb(unsigned int size, gfp_t mask)
 {
-	return virtio_vsock_alloc_skb(size, mask);
+	return __virtio_vsock_alloc_skb_with_frags(size, 0, mask);
+}
+
+static inline struct sk_buff *virtio_vsock_alloc_skb(unsigned int size, gfp_t mask)
+{
+	if (size <= SKB_WITH_OVERHEAD(PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER))
+		return virtio_vsock_alloc_linear_skb(size, mask);
+
+	size -= VIRTIO_VSOCK_SKB_HEADROOM;
+	return __virtio_vsock_alloc_skb_with_frags(VIRTIO_VSOCK_SKB_HEADROOM,
+						   size, mask);
 }
 
 static inline void
-- 
2.50.0.727.gbf7dc18ff4-goog


