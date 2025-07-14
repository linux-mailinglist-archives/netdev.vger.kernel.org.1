Return-Path: <netdev+bounces-206726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 647BEB043BB
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 17:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25CAA1637EF
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 15:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8ED2265CD8;
	Mon, 14 Jul 2025 15:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayH8CWqp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBB9265CC8;
	Mon, 14 Jul 2025 15:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506483; cv=none; b=RRN65Q8NQZn38aBkF+yUCyma+/gYmwmtT1H38iRLofFfMwrBYxFvJSrOgLP/3rbJXdkjtTBOQ37oEsG6KFlZAxvybcLMtOmw55a9yrJ4UbiOMvoHmL2WQETc7YS3bjrmGqfA+NjlzESN6X4g+6NWHfzHfotBzGxIRIv1SPfZz/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506483; c=relaxed/simple;
	bh=Vx2pfAKdJSquUFDasHiryHQmmc0i9STm5fwpK+Q3Mek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KOk0zIj6mUB118UWDVtVso6fQbXxKgfUn/yo8ixcY5+8WuS6syuSI8aM+iM/oajEg6vb32bvwM5S8QyXTuhVxctgmLgPxvRngqxdfFlmoZbPUY2EkpVZ3xyq6z+Xtbc39ba4VKIopZQBj3DhQxVLfiHiVKM9Y/MR1jek+ctAQcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayH8CWqp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3724C4CEF0;
	Mon, 14 Jul 2025 15:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752506483;
	bh=Vx2pfAKdJSquUFDasHiryHQmmc0i9STm5fwpK+Q3Mek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ayH8CWqp0PPFYMr3lzg5Je9Jm5zHynZG1ds1IS+hLKkInDlfzsuz4fglFwTl2tB8y
	 EOsGnMpTrgpERDQZdMQ3eU/hvdz1gjWA8f1Aqx+F91qL3FvTJF4VBotRaThaKWkJzF
	 TAAJoTKF5n9mMG2ak9cFqQ2o1B1rqdlA269QO3HPRLx9pB2NyIk+6iLNQlgdmWVZ9C
	 t9W6hO0VytBOgh852m+imm3lVNZlIon7Yfalrd/O3Tmryc31enwbkuMP4XPAdhFi1h
	 acYm29cqi566DTGItKXmzom1Zvc6q5048o8/6pvA2967PZypsOdiJKw3eahncCnTXM
	 Vkl5hnYxROzDw==
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
Subject: [PATCH v3 4/9] vsock/virtio: Resize receive buffers so that each SKB fits in a 4K page
Date: Mon, 14 Jul 2025 16:20:58 +0100
Message-Id: <20250714152103.6949-5-will@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250714152103.6949-1-will@kernel.org>
References: <20250714152103.6949-1-will@kernel.org>
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
index 1af7723669cb..5416214ae666 100644
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


