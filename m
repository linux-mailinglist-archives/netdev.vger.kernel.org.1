Return-Path: <netdev+bounces-202985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2278AF00BD
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 18:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAE201C235BD
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 16:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A415C284B5F;
	Tue,  1 Jul 2025 16:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KMmAGp1M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EAB283683;
	Tue,  1 Jul 2025 16:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751388329; cv=none; b=RFW9fll5lsLYImwpPx/CIgLrAgiAr27amRAMJu83QgPE/9jjgUsBYCVGmdDPjGYyXp/FTwH53X1AYQ9t1PVK9FdpJv0dGf+yc3OUBmnECYgb3HKV+/Slf5D9uAQSoPiTAH81AcsPW9wUNDL1o2u+8PyvtTJEve1vk1VP/j9Qzys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751388329; c=relaxed/simple;
	bh=ll+/aFb8wcFEbLCTKUL+CegPo8SzmsaGprgTn8Gb6+E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uIVfPoxRdSVj9L8kngN36aKEs96t3UJddH7cKRpUC/Suyer8ei6XwO0tY28lc9WAj7wJMoDl+O+zxroN1FpYh+7Z0InAGmoKTWnzZ8CzYpPDyXgVStWKqupozNGXm9iu3W9LhP5qHA9mg+o38H8HOV/jZ5EU2Fnv1kpUZDmOddI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KMmAGp1M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B38C4CEEF;
	Tue,  1 Jul 2025 16:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751388329;
	bh=ll+/aFb8wcFEbLCTKUL+CegPo8SzmsaGprgTn8Gb6+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KMmAGp1MT5xfOR1gGBkq4LZZ8Sqpz+nbcmf/pg1QEFKEaNZPeuvcbo4DYzOrTkS8m
	 qtf8EmIEvsC+N48qM5guBBhcnkZ9JNTXinoYB8vNvhKB/bSzquhVZ2H8kBgmtKzzO0
	 7sFBxps6GypVm2Bply6TvQQTmYT5CmHDWeXcjwwYZ3Pg4KDx0US3StClOOge0wnOvX
	 cqAPVUmUG3F6nRuaQXJy+nIFO5HTnhrc9G2PafE5Z24LHpWcllyue3MHvbbXhYdEmp
	 3VUVnzwXkxWt1xwhARtPYBeAI1HIFNWYwcWYn0WWbZpFijfsRJxX5xPeg4XBSS3ju7
	 voo03PK0Ub52w==
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
Subject: [PATCH v2 5/8] vsock/virtio: Add vsock helper for linear SKB allocation
Date: Tue,  1 Jul 2025 17:45:04 +0100
Message-Id: <20250701164507.14883-6-will@kernel.org>
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

In preparation for nonlinear allocations for large SKBs, introduce a
new virtio_vsock_alloc_linear_skb() helper to return linear SKBs
unconditionally and switch all callers over to this new interface for
now.

No functional change.

Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/vhost/vsock.c                   | 2 +-
 include/linux/virtio_vsock.h            | 6 ++++++
 net/vmw_vsock/virtio_transport.c        | 2 +-
 net/vmw_vsock/virtio_transport_common.c | 2 +-
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 66a0f060770e..b13f6be452ba 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -348,7 +348,7 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
 		return NULL;
 
 	/* len contains both payload and hdr */
-	skb = virtio_vsock_alloc_skb(len, GFP_KERNEL);
+	skb = virtio_vsock_alloc_linear_skb(len, GFP_KERNEL);
 	if (!skb)
 		return NULL;
 
diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 1b5731186095..6d4a933c895a 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -70,6 +70,12 @@ static inline struct sk_buff *virtio_vsock_alloc_skb(unsigned int size, gfp_t ma
 	return skb;
 }
 
+static inline struct sk_buff *
+virtio_vsock_alloc_linear_skb(unsigned int size, gfp_t mask)
+{
+	return virtio_vsock_alloc_skb(size, mask);
+}
+
 static inline void
 virtio_vsock_skb_queue_head(struct sk_buff_head *list, struct sk_buff *skb)
 {
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 3daba06ed499..2959db0404ed 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -321,7 +321,7 @@ static void virtio_vsock_rx_fill(struct virtio_vsock *vsock)
 	vq = vsock->vqs[VSOCK_VQ_RX];
 
 	do {
-		skb = virtio_vsock_alloc_skb(total_len, GFP_KERNEL);
+		skb = virtio_vsock_alloc_linear_skb(total_len, GFP_KERNEL);
 		if (!skb)
 			break;
 
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 1b5d9896edae..c9eb7f7ac00d 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -261,7 +261,7 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
 	if (!zcopy)
 		skb_len += payload_len;
 
-	skb = virtio_vsock_alloc_skb(skb_len, GFP_KERNEL);
+	skb = virtio_vsock_alloc_linear_skb(skb_len, GFP_KERNEL);
 	if (!skb)
 		return NULL;
 
-- 
2.50.0.727.gbf7dc18ff4-goog


