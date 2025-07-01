Return-Path: <netdev+bounces-202987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E758AF0096
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 18:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E2955233B1
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 16:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF452857D7;
	Tue,  1 Jul 2025 16:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTxyQjfz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E052853F7;
	Tue,  1 Jul 2025 16:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751388334; cv=none; b=lvhF9F15ibpxXWJgXXi4jxwC8sTyWEFJlt7aEoGThbWqkpr37K5oqT6fwEcPjrS/dIa9UQ2Ts+HaKkoMzXwiQOdSx3l0qbpigIFUVk922XTsS/dThB8NkiKvoAH+GDJBOwGIXaq77MHsHfzISoaomdatMzQ3bqGOTMncoEkPHzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751388334; c=relaxed/simple;
	bh=04XFkYAVsDTo05+5VTb2GZyNBXtBavyJjtbY6aD1Ra0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kyKvSAo7UpeQSHNDSG4DSgqA5rXZh2udHJXRqJgKpH2XJtjbbaOiojZ0nyfda1KWXbAYUN1PbJ6MNOmynWHbYOCDfOCUqmrO1eaWyALa4x5MivEi3XR2o3HKHNnc4yrv+5pa1ESBSdBPbolEoJ0Wn5VPG2uN59lUObNtPUTuTMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTxyQjfz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6D6C4CEEB;
	Tue,  1 Jul 2025 16:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751388334;
	bh=04XFkYAVsDTo05+5VTb2GZyNBXtBavyJjtbY6aD1Ra0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QTxyQjfz6Si2y+b0Yw73V9GCBZqG+bR6QGNoRuArgc6P4Zi/Kxum7A9jf2wujCJfG
	 hb2Oial7dTUKfMuWXsxBlR7CSR9ZNvUiFpqo/cD/odY8bpKhlLPtMU9jh5dxafgC7Z
	 s85EU6W3WLalMai341O75MckawkDXeM+vUkiSCFmmgpFX6W2ifJzEfPugBfV1HW3IF
	 jSemwd1ybxmKroMvL5yMtb5m0qc1Y71rw4tShwSouZ67sh1rGOr1d/5auHDsH4IIt/
	 WGu/Izgskibu5Q2CnnHSFYY2sXq899fAmX7f43R/Vide3ONx1/5kX5Dz4fKRN1AQzy
	 nxGezQQGZafVA==
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
Subject: [PATCH v2 7/8] vsock/virtio: Rename virtio_vsock_skb_rx_put() to virtio_vsock_skb_put()
Date: Tue,  1 Jul 2025 17:45:06 +0100
Message-Id: <20250701164507.14883-8-will@kernel.org>
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

In preparation for using virtio_vsock_skb_rx_put() when populating SKBs
on the vsock TX path, rename virtio_vsock_skb_rx_put() to
virtio_vsock_skb_put().

No functional change.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/vhost/vsock.c            | 2 +-
 include/linux/virtio_vsock.h     | 2 +-
 net/vmw_vsock/virtio_transport.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index f3c2ea1d0ae7..a6cd72a32f63 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -376,7 +376,7 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
 		return NULL;
 	}
 
-	virtio_vsock_skb_rx_put(skb);
+	virtio_vsock_skb_put(skb);
 
 	if (skb_copy_datagram_from_iter(skb, 0, &iov_iter, payload_len)) {
 		vq_err(vq, "Failed to copy %zu byte payload\n", payload_len);
diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index ad69668f6b91..ed5eab46e3dc 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -47,7 +47,7 @@ static inline void virtio_vsock_skb_clear_tap_delivered(struct sk_buff *skb)
 	VIRTIO_VSOCK_SKB_CB(skb)->tap_delivered = false;
 }
 
-static inline void virtio_vsock_skb_rx_put(struct sk_buff *skb)
+static inline void virtio_vsock_skb_put(struct sk_buff *skb)
 {
 	u32 len;
 
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 2959db0404ed..44751cf8dfca 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -662,7 +662,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
 			}
 
 			if (payload_len)
-				virtio_vsock_skb_rx_put(skb);
+				virtio_vsock_skb_put(skb);
 
 			virtio_transport_deliver_tap_pkt(skb);
 			virtio_transport_recv_pkt(&virtio_transport, skb);
-- 
2.50.0.727.gbf7dc18ff4-goog


