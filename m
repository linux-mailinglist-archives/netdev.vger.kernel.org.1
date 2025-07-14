Return-Path: <netdev+bounces-206730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6EF2B043C5
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 17:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AED316A5D1
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 15:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5959426A0CC;
	Mon, 14 Jul 2025 15:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZQj5SjG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E3226A0AD;
	Mon, 14 Jul 2025 15:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506494; cv=none; b=IBjRE1azRLIQqd16l8on7twLqL8/fcrUm5cExM7H9LD1sTTRxLR5WPb4KuzdbuxfcOnkwq0o/UOrz94i3i17fWVHgdhjaXOvsGMsgTk4kmufwNcS2tqRBBa2pcAGrL+3EgO4r9amEhiACqXD09ssicHgLcKdor0J6TDnoykDEF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506494; c=relaxed/simple;
	bh=6dFc2pj54Tf3DihdCujZcgocrkZgNMlBdT6L3xux37o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WLPGMP+pFo9yOIRDGEEUfBQYerGWNkIGIFLFUpvHbqVfIFRIT3NKaX6QWrjZDaep9rqM3w3LTatD9if5wfroUgsxLcCZKdO370Lulv8QiIaIgfRwo99tzqp2cXE3LAE4YoDvITxXpfaE8PdfopVQ5GyRxJNLafSUJ8oNNYHslRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZQj5SjG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE4DAC4CEED;
	Mon, 14 Jul 2025 15:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752506494;
	bh=6dFc2pj54Tf3DihdCujZcgocrkZgNMlBdT6L3xux37o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NZQj5SjG0nKwG6IsMgiWmCa2cvUcj4u/oBu5Tncu8+HT8vc+m+qbKH/sdUJ7JhZ5W
	 XBGW6HJG7LlFtigQLSYbr3q5dAFZYgXwOC1pyvl1OsqXUa51/a3K8eiLeFPQzErLsH
	 WRbninklb+4oUj82uSP05giZ1BVpshFGxKAqRzIdqAJtEuERkyesmaSUqTwpDlpsUT
	 ATnixcwQiFZ65fJAUOVyy68ewTWkulRbz+0gnh7Rsn/5bcfej1oPra92cV4nGgxZpn
	 QQaTQyNdxqYz+dPIPk3q2LRd3F5238aNToVFbxvw+muze+NuJfodRnr8A6NIqvm3CQ
	 WNza1tcqHpELA==
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
Subject: [PATCH v3 8/9] vsock/virtio: Rename virtio_vsock_skb_rx_put()
Date: Mon, 14 Jul 2025 16:21:02 +0100
Message-Id: <20250714152103.6949-9-will@kernel.org>
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
index 0679a706ebc0..ae01457ea2cd 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -376,7 +376,7 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
 		return NULL;
 	}
 
-	virtio_vsock_skb_rx_put(skb, payload_len);
+	virtio_vsock_skb_put(skb, payload_len);
 
 	if (skb_copy_datagram_from_iter(skb, 0, &iov_iter, payload_len)) {
 		vq_err(vq, "Failed to copy %zu byte payload\n", payload_len);
diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index fa5934ea9c81..0c67543a45c8 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -47,7 +47,7 @@ static inline void virtio_vsock_skb_clear_tap_delivered(struct sk_buff *skb)
 	VIRTIO_VSOCK_SKB_CB(skb)->tap_delivered = false;
 }
 
-static inline void virtio_vsock_skb_rx_put(struct sk_buff *skb, u32 len)
+static inline void virtio_vsock_skb_put(struct sk_buff *skb, u32 len)
 {
 	DEBUG_NET_WARN_ON_ONCE(skb->len);
 
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index c983fd62e37a..f65ad8706bbd 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -657,7 +657,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
 			}
 
 			if (payload_len)
-				virtio_vsock_skb_rx_put(skb, payload_len);
+				virtio_vsock_skb_put(skb, payload_len);
 
 			virtio_transport_deliver_tap_pkt(skb);
 			virtio_transport_recv_pkt(&virtio_transport, skb);
-- 
2.50.0.727.gbf7dc18ff4-goog


