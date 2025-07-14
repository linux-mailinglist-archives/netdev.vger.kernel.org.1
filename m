Return-Path: <netdev+bounces-206727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 916D3B043BD
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 17:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCDDF164C59
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 15:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A2A266EFE;
	Mon, 14 Jul 2025 15:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtdVMVzb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7558C266EF8;
	Mon, 14 Jul 2025 15:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506486; cv=none; b=jlIEmPvWwjdUPkbFLjoaQ+XZLuuFukCivqyBA2M3AjEQ6HtZtLIguNswpqQ1+R9UP6XZmS7rEYlHU7V49QQxEoBi//hn1ULFws43Qp0sduOT2UhQ+2/Q5f+KQZXL22ZHSR6IBMte/mcjM16p02ZRk8AaVY/1bOG7vXMaWe+dUF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506486; c=relaxed/simple;
	bh=P6/iRHnilU2cPLDO49VvL0Sx0zgXeNiQB3tnoQ0dbsg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OcX1yf90pd+M2JlgzYX39U0uwSG2AZo1roS9wdDbMHSpKIv/O6/ewRURhRY4Zs8rXLn3+EQNZEhWU2+4oHIdxLKglXBgeWF6Y2lN/LZYPjEZlONF1oGvvTVdEE36IQwXCmghtqbKT4JeeSeyRX7t70unW7yIMxwpyWMAvmH89ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtdVMVzb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA9EFC4CEED;
	Mon, 14 Jul 2025 15:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752506485;
	bh=P6/iRHnilU2cPLDO49VvL0Sx0zgXeNiQB3tnoQ0dbsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DtdVMVzb78nKywbtGOLWvfVMRhf8it0OFH99Ca3OhGF9n9HGP5cf4IdEoOA6vMBEP
	 ATj6A/tr9ms6LsK8bHFOK5DMDzW/CKh37dDUmMkGRZOo6aT7o658SseoT2OeEtfW9+
	 7WIcnqbtayMokKLPor+x9QO1Kwp6TMEIzGgDBe8ovZ+1yqTrTmRiC5ldXwTYxGjx54
	 MPSG3BsGsBPfV422Mk12BtyqoimBQNrJo4pbg2nwgV4JloHdnra/+itkMNuGr4ZbSN
	 FwUV4i75raSyTQLGHwphVuP76/aTPjKdOVFsD92u/8i7oMKpH2DWK5c3158JWziYOd
	 WJdsLuD5jnLrQ==
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
Subject: [PATCH v3 5/9] vsock/virtio: Rename virtio_vsock_alloc_skb()
Date: Mon, 14 Jul 2025 16:20:59 +0100
Message-Id: <20250714152103.6949-6-will@kernel.org>
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

In preparation for nonlinear allocations for large SKBs, rename
virtio_vsock_alloc_skb() to virtio_vsock_alloc_linear_skb() to indicate
that it returns linear SKBs unconditionally and switch all callers over
to this new interface for now.

No functional change.

Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/vhost/vsock.c                   | 2 +-
 include/linux/virtio_vsock.h            | 3 ++-
 net/vmw_vsock/virtio_transport.c        | 2 +-
 net/vmw_vsock/virtio_transport_common.c | 2 +-
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 4c4a642945eb..1ad96613680e 100644
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
index 879f1dfa7d3a..4504ea29ff82 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -52,7 +52,8 @@ static inline void virtio_vsock_skb_rx_put(struct sk_buff *skb, u32 len)
 	skb_put(skb, len);
 }
 
-static inline struct sk_buff *virtio_vsock_alloc_skb(unsigned int size, gfp_t mask)
+static inline struct sk_buff *
+virtio_vsock_alloc_linear_skb(unsigned int size, gfp_t mask)
 {
 	struct sk_buff *skb;
 
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 5416214ae666..c983fd62e37a 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -316,7 +316,7 @@ static void virtio_vsock_rx_fill(struct virtio_vsock *vsock)
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


