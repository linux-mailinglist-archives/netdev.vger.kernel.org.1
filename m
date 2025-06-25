Return-Path: <netdev+bounces-201144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78074AE8436
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 15:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6165A1896095
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 13:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E052641E7;
	Wed, 25 Jun 2025 13:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQjg6m/1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F842609F7;
	Wed, 25 Jun 2025 13:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750857354; cv=none; b=TjzWeqFQOWyRA1ZCDRYUKYF6V5H2amv4tOhGi77DIufFy8mXD37ukc0R4kqx58O5OUU3vpzQ7pe9rO3P0L/ZDNsOK3LceLfW+pU5hLkCiQM2zIiZk7gpkT+DTer2ZXA1OEIbqdgFioOToAB275cBRmupOBBdVLIY+3L0PKVQxrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750857354; c=relaxed/simple;
	bh=NAwf6+Q/qrG6EI6uYZH3wXeLmsbgzYePN5qMa/M14K4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uchZhzrAcbXWtqC0tWZSLLV9M9vejE3nlF3+qQZRoYMUjT8NiRk5+5blyWTfHFp5F6P0n1k/lcmIyiW+y59ZffYCQUDOS6g/0aV7O/DXkwThVAqYn72JQ0AsPn7nEFtimaXKtZlp5Thk/PjaDjFAAQwhYvNO3H8I1jYlVDWsIRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQjg6m/1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 938E6C4CEF3;
	Wed, 25 Jun 2025 13:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750857353;
	bh=NAwf6+Q/qrG6EI6uYZH3wXeLmsbgzYePN5qMa/M14K4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MQjg6m/1C9qlCPUODcoH0JDFEtk4CIosbdfn+i6vqC/f8ej0/R8unSl3quBtgbZc2
	 uu8KtQBJW2ab9G7eHrDZeaEZ7aDV+8RvFpgjS6Rqy3P5w/RjhwQ+8GA7wIThGVXhBA
	 DVj57PASE3mFzs0/NMfimvqcUPew/oyGlnQpLNH8JXJW1deu+OSMydYZvCKoK5dLbj
	 DLuqDvK0ubgwlgN1fCHG3GGZjGVLpuNYtOUaxvgmYQa1yCOhgewvYK3pGPeio6LJ8s
	 NAn13T1DMBbVDlI2JZkYTf8l5ntAEa+k0azt72s7LHu6h2ifN9myiBHfGPXDrm0ZIJ
	 FLhNJ2zSLZ31g==
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
Subject: [PATCH 1/5] vhost/vsock: Avoid allocating arbitrarily-sized SKBs
Date: Wed, 25 Jun 2025 14:15:39 +0100
Message-Id: <20250625131543.5155-2-will@kernel.org>
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

vhost_vsock_alloc_skb() returns NULL for packets advertising a length
larger than VIRTIO_VSOCK_MAX_PKT_BUF_SIZE in the packet header. However,
this is only checked once the SKB has been allocated and, if the length
in the packet header is zero, the SKB may not be freed immediately.

Hoist the size check before the SKB allocation so that an iovec larger
than VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + the header size is rejected
outright. The subsequent check on the length field in the header can
then simply check that the allocated SKB is indeed large enough to hold
the packet.

Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/vhost/vsock.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 802153e23073..66a0f060770e 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -344,6 +344,9 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
 
 	len = iov_length(vq->iov, out);
 
+	if (len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADROOM)
+		return NULL;
+
 	/* len contains both payload and hdr */
 	skb = virtio_vsock_alloc_skb(len, GFP_KERNEL);
 	if (!skb)
@@ -367,8 +370,7 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
 		return skb;
 
 	/* The pkt is too big or the length in the header is invalid */
-	if (payload_len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE ||
-	    payload_len + sizeof(*hdr) > len) {
+	if (payload_len + sizeof(*hdr) > len) {
 		kfree_skb(skb);
 		return NULL;
 	}
-- 
2.50.0.714.g196bf9f422-goog


