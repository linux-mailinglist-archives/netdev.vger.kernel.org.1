Return-Path: <netdev+bounces-207779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9C1B088C8
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 11:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFB2E18867A3
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 09:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644F128C84F;
	Thu, 17 Jul 2025 09:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/oecDGo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B0E28C5CF;
	Thu, 17 Jul 2025 09:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752742894; cv=none; b=rGsbQuxAgh+CHj5dLZgNAxTUuTJaHzfP2I6uP24zfeHnAOOyPDBwS1PQjIbHQ7EZ+HTzGx99SmyfRNHV0jvlXXbFeZQvdnGlT9GoUQpYdC7UNQbKqdsAiR8DfkxAKPrYgtSQasXFyz0WvtJH9iIXEG63hhjp8etounOnumZt9uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752742894; c=relaxed/simple;
	bh=SfSAPODvLeyhcY58xHztgQC88eZuBiN28FsEP9S31Hs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lDvclWCeWrA4yGYULuA45AtQ1kep8zU7Yml2BdkX4zsjBrSEKRy+hFs/LEBpR2jcJUeG9g7OM3+D6YP1AEJtM5csnYOgH+Y7oHwtveUvP52AOdPjoDIOTm3IzZmoPjYE/VteU+20S7unzVLNOvTs5+VJWpp9f36rfr2sud2G7E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/oecDGo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE5EC4CEED;
	Thu, 17 Jul 2025 09:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752742894;
	bh=SfSAPODvLeyhcY58xHztgQC88eZuBiN28FsEP9S31Hs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F/oecDGoqCFyMi5FqRTj7DC28h5FeojL9EMLDCF91eJbUVm+V7i0SNX5vafDzW5+3
	 PADuXL2z5zPNKrHfNDsM3707tA4LPDX58geFhPmOqMbzr2xFjL9bScSHQ5WWGbNB+8
	 oSrQnIXQC8vF+MgbXexSp5847zC9q4LpPJ751GoyCYzXunr3f0VZ4Xmavg+Y8hj244
	 s2W6cSrKbCeu21l6GkXCjXRtgF4SamN0h4JqYbwbnEIXqBeNFzuTltxME/mQXYYXzn
	 jqaTccvNijekTHwixugdX14QlDXKSVYTdj1HvFfMdEp26p+CcRFKQAa/52gpuS0FQC
	 taUIZZJP6h0ow==
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
Subject: [PATCH v4 4/9] vsock/virtio: Resize receive buffers so that each SKB fits in a 4K page
Date: Thu, 17 Jul 2025 10:01:11 +0100
Message-Id: <20250717090116.11987-5-will@kernel.org>
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

When allocating receive buffers for the vsock virtio RX virtqueue, an
SKB is allocated with a 4140 data payload (the 44-byte packet header +
VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE). Even when factoring in the SKB
overhead, the resulting 8KiB allocation thanks to the rounding in
kmalloc_reserve() is wasteful (~3700 unusable bytes) and results in a
higher-order page allocation on systems with 4KiB pages just for the
sake of a few hundred bytes of packet data.

Limit the vsock virtio RX buffers to 4KiB per SKB, resulting in much
better memory utilisation and removing the need to allocate higher-order
pages entirely.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/virtio_vsock.h     | 7 ++++++-
 net/vmw_vsock/virtio_transport.c | 2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 97465f378ade..879f1dfa7d3a 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -106,7 +106,12 @@ static inline size_t virtio_vsock_skb_len(struct sk_buff *skb)
 	return (size_t)(skb_end_pointer(skb) - skb->head);
 }
 
-#define VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE	(1024 * 4)
+/* Dimension the RX SKB so that the entire thing fits exactly into
+ * a single 4KiB page. This avoids wasting memory due to alloc_skb()
+ * rounding up to the next page order and also means that we
+ * don't leave higher-order pages sitting around in the RX queue.
+ */
+#define VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE	SKB_WITH_OVERHEAD(1024 * 4)
 #define VIRTIO_VSOCK_MAX_BUF_SIZE		0xFFFFFFFFUL
 #define VIRTIO_VSOCK_MAX_PKT_BUF_SIZE		(1024 * 64)
 
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 0166919f8705..39f346890f7f 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -307,7 +307,7 @@ virtio_transport_cancel_pkt(struct vsock_sock *vsk)
 
 static void virtio_vsock_rx_fill(struct virtio_vsock *vsock)
 {
-	int total_len = VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADROOM;
+	int total_len = VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE;
 	struct scatterlist pkt, *p;
 	struct virtqueue *vq;
 	struct sk_buff *skb;
-- 
2.50.0.727.gbf7dc18ff4-goog


