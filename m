Return-Path: <netdev+bounces-207780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6081B088CA
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 11:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C785A45972
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 09:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C34B28D8FE;
	Thu, 17 Jul 2025 09:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/QZQ7Pj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A5728D8DB;
	Thu, 17 Jul 2025 09:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752742897; cv=none; b=Y1nyoaN0czJ5H6aDhRjVCcsSu3Gyktqqsd0ryfPwKPF1DXM9N6fzgZF19fZ3YuYN8kapIGm5DGh9Z3G8rPb9UDRaIECIEUa/qF56n1zz9j9t1A9FhcopqcsHvCQcY5YMYTJH/pMGGfBGCsLa8pwlzfG/A7Ee1rX6tL72HyweM7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752742897; c=relaxed/simple;
	bh=KwXpHKVzwAEGl09Zp22el4vE43Y3lNfWFQ5n8BlpBqw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aZaaQ1Mi+kXzMVIMVHKb1SvnImUdazHmwUzOQOIhUm+ThBY3AFobTDoGpe6WkB5N4Twuy8Okqd8ZzQpkaFqhMy8y/F1aNeV0Y7P1m++Miwzf/PI/FXW/+LhYt2GkkqGQeKulyqPmVDpZblqntY0veZHHTSVJfylp+rIxzgW4gwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/QZQ7Pj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90306C4CEEB;
	Thu, 17 Jul 2025 09:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752742896;
	bh=KwXpHKVzwAEGl09Zp22el4vE43Y3lNfWFQ5n8BlpBqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j/QZQ7Pj6FMi0ncGhta00mLUQN6O0WHkdg0IfPADdrnmuwxnoo/fCF98/Obl7iJmJ
	 eJG89O2fQccdGcG9HtYjpd9AgVyDeWpQTBHRb3KYNJBox79XI+tfoljid10uYv2DPj
	 4tyAWrqWRmRKwpW1dYGBLHI3QSch/m471SZ9/nqWqujB7ZsTleIhzGhhb3DG79u2fU
	 Hskld+0jl7RssHayQ6gTcPwNG10xQVqVPR3goy6tqK6JBnLFBa6owLahwJIxDRAvLc
	 GCU9yuB+TpjHbQDUTcOgUTEsFXxkOOzLZtd0SPLdQD2JyZVbg0nWjnN1tMhnLVRmgJ
	 +C68lc/4jUATg==
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
Subject: [PATCH v4 5/9] vsock/virtio: Rename virtio_vsock_alloc_skb()
Date: Thu, 17 Jul 2025 10:01:12 +0100
Message-Id: <20250717090116.11987-6-will@kernel.org>
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

In preparation for nonlinear allocations for large SKBs, rename
virtio_vsock_alloc_skb() to virtio_vsock_alloc_linear_skb() to indicate
that it returns linear SKBs unconditionally and switch all callers over
to this new interface for now.

No functional change.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
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
index 39f346890f7f..80dcf6ac1e72 100644
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


