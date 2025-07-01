Return-Path: <netdev+bounces-202984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF512AF007E
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 18:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB04B17920A
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 16:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0416A284674;
	Tue,  1 Jul 2025 16:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTn8bUBe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD140283FD6;
	Tue,  1 Jul 2025 16:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751388326; cv=none; b=kydTNDCBk1IAUwPLJduj4O2p/gNNPnh+ZU+a8GA7s+/ec9ZYgeePcDkumj4+2+fAWEtttDzR1KB4u0MRJwqU+DseJBQCh03hAhznelYohIRINpd8+WzBJanEKx7Bhvok1JnciJ/T5ew57rG9PFm1DUY22uGmcOhjlEJa26/tRD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751388326; c=relaxed/simple;
	bh=B1w0qcrCgepHrxOTMugcVkliDb4+0LWgsIR7uZB8lLM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OS6RphYV4YchdchY+7PzqiX7xes09JrhfcrxgnFQQPRWKXO5UMZ9tRZkjr2DxVXznTgVCfip6qw/XwLTlwiDE+a1mszHfO4bJQLMjSHeNgKFlJVx38ELgLNAETlZnNjcP9KRvbqZuOu2NZ4ewMDxIjt8REBTixwfvTkInyuKbl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTn8bUBe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E4F0C4CEEB;
	Tue,  1 Jul 2025 16:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751388326;
	bh=B1w0qcrCgepHrxOTMugcVkliDb4+0LWgsIR7uZB8lLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oTn8bUBeJ/lie7A6fbC05ty2k4Lfx7Ieir/ROFNOPROE5jTUOzeu3zrcWKosBxFpJ
	 +0OLClWuoIuqv8+LmssHpix2mOYrOwEtI4bLUi/pCb/oBnwtjlQDlXICbOfnqCLwGU
	 8eb+7HpDOAwLm8zn4QcTHZiic+LCpi0fDnIK2VheEkyhNaH7HCO+3zYJTRUW32DntW
	 atV/saUnkQyu5JAoe1aIqs7OU65J7aRJXu4FzL9xzeHsfyDGa1HtjuvPufpEi5dHGF
	 6nvQwy2pNIczC1s7JCcCKf29yOzprQ7DQFuEMYSYLDEVIMdYox6IX5JU+tJ2PGZU8x
	 OTjBbQi+LJe6A==
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
Subject: [PATCH v2 4/8] vsock/virtio: Resize receive buffers so that each SKB fits in a page
Date: Tue,  1 Jul 2025 17:45:03 +0100
Message-Id: <20250701164507.14883-5-will@kernel.org>
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

When allocating receive buffers for the vsock virtio RX virtqueue, an
SKB is allocated with a 4140 data payload (the 44-byte packet header +
VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE). Even when factoring in the SKB
overhead, the resulting 8KiB allocation thanks to the rounding in
kmalloc_reserve() is wasteful (~3700 unusable bytes) and results in a
higher-order page allocation for the sake of a few hundred bytes of
packet data.

Limit the vsock virtio RX buffers to a page per SKB, resulting in much
better memory utilisation and removing the need to allocate higher-order
pages entirely.

Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/virtio_vsock.h     | 1 -
 net/vmw_vsock/virtio_transport.c | 7 ++++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index eb6980aa19fd..1b5731186095 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -109,7 +109,6 @@ static inline size_t virtio_vsock_skb_len(struct sk_buff *skb)
 	return (size_t)(skb_end_pointer(skb) - skb->head);
 }
 
-#define VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE	(1024 * 4)
 #define VIRTIO_VSOCK_MAX_BUF_SIZE		0xFFFFFFFFUL
 #define VIRTIO_VSOCK_MAX_PKT_BUF_SIZE		(1024 * 64)
 
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 488e6ddc6ffa..3daba06ed499 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -307,7 +307,12 @@ virtio_transport_cancel_pkt(struct vsock_sock *vsk)
 
 static void virtio_vsock_rx_fill(struct virtio_vsock *vsock)
 {
-	int total_len = VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADROOM;
+	/* Dimension the SKB so that the entire thing fits exactly into
+	 * a single page. This avoids wasting memory due to alloc_skb()
+	 * rounding up to the next page order and also means that we
+	 * don't leave higher-order pages sitting around in the RX queue.
+	 */
+	int total_len = SKB_WITH_OVERHEAD(PAGE_SIZE);
 	struct scatterlist pkt, *p;
 	struct virtqueue *vq;
 	struct sk_buff *skb;
-- 
2.50.0.727.gbf7dc18ff4-goog


