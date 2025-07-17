Return-Path: <netdev+bounces-207782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2090B088C5
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 11:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C531B7A1148
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 09:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943DC293C6C;
	Thu, 17 Jul 2025 09:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJPUiuj7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6765D28C5C9;
	Thu, 17 Jul 2025 09:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752742902; cv=none; b=jMRuevUOO9V6wrlDZ1WZfzChfmTiDLLyAxEvP7CYacPN2BvOAaeryUD95v2SyDBhfeTUn5icfzvlvWa59C5F/3I3ThBcMMvJraRWJpPj0BBlLnK2BOhNzoOKmIpofnkN+G/emt/1Fa81hWa5O/J2zGO6Yvp6q1oseLvvqxfAnxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752742902; c=relaxed/simple;
	bh=NiKPR/htVJnmrk6MTJRQgZc1xHv3Eu5IvMBg2dmm0rM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CdPwaCr9qeB6WdqMUQW3TWpFaBGt9VsbEs7DYScE2sf68muRl0K/ONu85NpKBc3WLU6g1hYQagjnSFpfdT5U3g25EP44o4AMTmKleydqk4jGkGU9B3tvM0K4gTR9yaJ4iNN7M3Au9gzGKMKy0Al18lan9lYJZ96IrKSSYKpnN0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJPUiuj7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5428C4CEEB;
	Thu, 17 Jul 2025 09:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752742901;
	bh=NiKPR/htVJnmrk6MTJRQgZc1xHv3Eu5IvMBg2dmm0rM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HJPUiuj76la303hxKP6iAfQsaoEAzt5WTvZWcxpG01b6nkFDbcjY9Q+NALb0yWdG0
	 Z4UEaQctddtCRPto8ar+11OXvVrr88ijuVVSzv0x+xwXjolwynjxqEW1cR3T4T8U2V
	 +s2XzHzY2Uytp1PcW4YlxukZ2/MpNFH1Rsl0WPgHyGd0WurN7oNs85nAQcYVkrYCbX
	 rTNNf9nIGKUvwdtUwSeAajPLIMWd57SQ1Ur9ILaomF+TMJ9XcicbQkew0nwupQCIZ/
	 jUA01Xu5QZqccIztV5XTm7mprV4uzCpDcm3urJzfS8gLuyGSbV8wzBRbV0F3Lb01wo
	 OdSL/ukGObVaQ==
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
Subject: [PATCH v4 7/9] vhost/vsock: Allocate nonlinear SKBs for handling large receive buffers
Date: Thu, 17 Jul 2025 10:01:14 +0100
Message-Id: <20250717090116.11987-8-will@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250717090116.11987-1-will@kernel.org>
References: <20250717090116.11987-1-will@kernel.org>
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
fragments. Finally, add a debug warning if virtio_vsock_skb_rx_put() is
ever called on an SKB with a non-zero length, as this would be
destructive for the nonlinear case.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/vhost/vsock.c        |  8 +++-----
 include/linux/virtio_vsock.h | 40 +++++++++++++++++++++++++++++-------
 2 files changed, 36 insertions(+), 12 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 24b7547b05a6..0679a706ebc0 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -349,7 +349,7 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
 		return NULL;
 
 	/* len contains both payload and hdr */
-	skb = virtio_vsock_alloc_linear_skb(len, GFP_KERNEL);
+	skb = virtio_vsock_alloc_skb(len, GFP_KERNEL);
 	if (!skb)
 		return NULL;
 
@@ -378,10 +378,8 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
 
 	virtio_vsock_skb_rx_put(skb, payload_len);
 
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
index 36dd0cd55368..fa5934ea9c81 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -49,20 +49,46 @@ static inline void virtio_vsock_skb_clear_tap_delivered(struct sk_buff *skb)
 
 static inline void virtio_vsock_skb_rx_put(struct sk_buff *skb, u32 len)
 {
-	skb_put(skb, len);
+	DEBUG_NET_WARN_ON_ONCE(skb->len);
+
+	if (skb_is_nonlinear(skb))
+		skb->len = len;
+	else
+		skb_put(skb, len);
+}
+
+static inline struct sk_buff *
+__virtio_vsock_alloc_skb_with_frags(unsigned int header_len,
+				    unsigned int data_len,
+				    gfp_t mask)
+{
+	struct sk_buff *skb;
+	int err;
+
+	skb = alloc_skb_with_frags(header_len, data_len,
+				   PAGE_ALLOC_COSTLY_ORDER, &err, mask);
+	if (!skb)
+		return NULL;
+
+	skb_reserve(skb, VIRTIO_VSOCK_SKB_HEADROOM);
+	skb->data_len = data_len;
+	return skb;
 }
 
 static inline struct sk_buff *
 virtio_vsock_alloc_linear_skb(unsigned int size, gfp_t mask)
 {
-	struct sk_buff *skb;
+	return __virtio_vsock_alloc_skb_with_frags(size, 0, mask);
+}
 
-	skb = alloc_skb(size, mask);
-	if (!skb)
-		return NULL;
+static inline struct sk_buff *virtio_vsock_alloc_skb(unsigned int size, gfp_t mask)
+{
+	if (size <= SKB_WITH_OVERHEAD(PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER))
+		return virtio_vsock_alloc_linear_skb(size, mask);
 
-	skb_reserve(skb, VIRTIO_VSOCK_SKB_HEADROOM);
-	return skb;
+	size -= VIRTIO_VSOCK_SKB_HEADROOM;
+	return __virtio_vsock_alloc_skb_with_frags(VIRTIO_VSOCK_SKB_HEADROOM,
+						   size, mask);
 }
 
 static inline void
-- 
2.50.0.727.gbf7dc18ff4-goog


