Return-Path: <netdev+bounces-207783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B69A3B088DD
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 11:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3395318808F8
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 09:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5EC2951CA;
	Thu, 17 Jul 2025 09:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OF9QRyEX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A902877F3;
	Thu, 17 Jul 2025 09:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752742904; cv=none; b=jqzuCOj1pGU7Dz2oQos3z6x3SmJOmYTW2q+7DjupHbgWZTR/MjLygGoiJb3aFLzKNN8euAuBX0GslnVjRyStBPkE7Flem3wkaDqBf3qvPneOHAhlhnuVRbTI4moUFl/k0ZZ6Si7WsRft+V9eTOd/oFeXJtdJVrUaAxvuTe5aPds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752742904; c=relaxed/simple;
	bh=wYs1S2rTX4fH2s4I7jI+Sd6BQo9XPGIBbbUJtE/9wBM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cec4QsdjRoQz/cXETHQRxZCnZvjtXLb/7yi0kNrvdo2Y2tZKRIIs+uxUBYr4rRcxv9oN/eOg3LF+QoxIk2yzGzfIu9knZTuaMGiHw2YmMfEoAk50gq7i7fkO2+gr3VyRI/wwLCfiDENsExJ/yqJ1wz5Vvs8vlqrbv+eyWgDPtkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OF9QRyEX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6301DC4CEE3;
	Thu, 17 Jul 2025 09:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752742904;
	bh=wYs1S2rTX4fH2s4I7jI+Sd6BQo9XPGIBbbUJtE/9wBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OF9QRyEXr3dw6Ugf6pbqIgNMPyM9hEL7O3VsWRN/4jyhQxhpqdNM66mwesrR25X1d
	 HQuqvAdtwo/hObeY/8vkBumn6W59tn77QouaMPMrH1zWnizpU95mfAakprUXDxYsvB
	 nqLFCttdlRBq7rtuTtOCppbs10cr+0Iy+kZzcsaYozvWbJOeAtqsmBMW5/d/pfjXgQ
	 VIN7egyf4/ViUuVGQcNKnNEqLohYZZYLBrAloJx+xsEk98VzbDTqpv5ljNsmP7391r
	 0gsg9fIL6pB26PqZPCeL9VKxd4olRMg2UF6t3/YgFuqj+HyOwE/YuHlufJmq1x/lHg
	 zid0Orb4x23BQ==
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
Subject: [PATCH v4 8/9] vsock/virtio: Rename virtio_vsock_skb_rx_put()
Date: Thu, 17 Jul 2025 10:01:15 +0100
Message-Id: <20250717090116.11987-9-will@kernel.org>
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
index 80dcf6ac1e72..b6569b0ca2bb 100644
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


