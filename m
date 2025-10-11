Return-Path: <netdev+bounces-228587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 298A5BCF33A
	for <lists+netdev@lfdr.de>; Sat, 11 Oct 2025 11:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40AF84255E0
	for <lists+netdev@lfdr.de>; Sat, 11 Oct 2025 09:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5F32522BE;
	Sat, 11 Oct 2025 09:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GKSy6QRZ"
X-Original-To: netdev@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0268022422E
	for <netdev@vger.kernel.org>; Sat, 11 Oct 2025 09:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760175683; cv=none; b=uK0x3+S6VcLCw2ZXqw4ndZX/qqrCpmUNAbsE6mcQCtgVUJ6qE8nvXtCZQ4h1BoDFgBlPLfE1y4LF5nvkm+dJa19cyi4R5BOCbfB2CX7lSD8wNh6JGp9RW3jIZP2i1onqTquU5tbutuR2KXE1e6ek8qb0j21MIRdDuPCPgxCZCZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760175683; c=relaxed/simple;
	bh=9jWpdexeslocZY1OgfoeF+e/supLded3SAgaBRJBMnc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZhU5K3e7yhUrngaDnYw/ksDNmjXjLIfSI7hQEjeeak/JcaPMceu3Q1ma3nd9q1NfvNXzxv7e1NCAq6ZBgplPCkyJ1tOsng9XMivHkfI+oi3AtIkYcnpQTAOSxNvMP2buZKWaZMUR8gHKAE4ADhoV5rVnecSFlh7OqxP66TC1wh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GKSy6QRZ; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760175669; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=5lIGO5dOqEn/E9rtaIo990T2KqDRJ8uzmlBX+DLJftU=;
	b=GKSy6QRZDY2If3NOHzAZGz6bhPGBexN02kyxmL69iXaDfMLdgvilFz/TEFqy/nLXaPThZuGj4U0eCJiGZakuBVght46zO/4sWqmE1La/KuxvU0sN0CS1i3/8CUuFIrDGjKyoRqIfO2UeqvumGi1lLxPym27vngjgbEo1SItmEOY=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WpwHC-P_1760175668 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 11 Oct 2025 17:41:08 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	Heng Qi <hengqi@linux.alibaba.com>,
	virtualization@lists.linux.dev
Subject: [PATCH net v1 1/3] virtio-net: fix incorrect flags recording in big mode
Date: Sat, 11 Oct 2025 17:41:05 +0800
Message-Id: <20251011094107.16439-2-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20251011094107.16439-1-xuanzhuo@linux.alibaba.com>
References: <20251011094107.16439-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 94b35d9b48af
Content-Transfer-Encoding: 8bit

The purpose of commit 703eec1b2422 ("virtio_net: fixing XDP for fully
checksummed packets handling") is to record the flags in advance, as
their value may be overwritten in the XDP case. However, the flags
recorded under big mode are incorrect, because in big mode, the passed
buf does not point to the rx buffer, but rather to the page of the
submitted buffer. This commit fixes this issue.

For the small mode, the commit c11a49d58ad2 ("virtio_net: Fix mismatched
buf address when unmapping for small packets") fixed it.

Fixes: 703eec1b2422 ("virtio_net: fixing XDP for fully checksummed packets handling")
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7da5a37917e9..22f7725798e3 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2620,22 +2620,28 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
 		return;
 	}
 
-	/* 1. Save the flags early, as the XDP program might overwrite them.
+	/* About the flags below:
+	 * 1. Save the flags early, as the XDP program might overwrite them.
 	 * These flags ensure packets marked as VIRTIO_NET_HDR_F_DATA_VALID
 	 * stay valid after XDP processing.
 	 * 2. XDP doesn't work with partially checksummed packets (refer to
 	 * virtnet_xdp_set()), so packets marked as
 	 * VIRTIO_NET_HDR_F_NEEDS_CSUM get dropped during XDP processing.
 	 */
-	flags = ((struct virtio_net_common_hdr *)buf)->hdr.flags;
 
-	if (vi->mergeable_rx_bufs)
+	if (vi->mergeable_rx_bufs) {
+		flags = ((struct virtio_net_common_hdr *)buf)->hdr.flags;
 		skb = receive_mergeable(dev, vi, rq, buf, ctx, len, xdp_xmit,
 					stats);
-	else if (vi->big_packets)
+	} else if (vi->big_packets) {
+		void *p = page_address((struct page *)buf);
+
+		flags = ((struct virtio_net_common_hdr *)p)->hdr.flags;
 		skb = receive_big(dev, vi, rq, buf, len, stats);
-	else
+	} else {
+		flags = ((struct virtio_net_common_hdr *)buf)->hdr.flags;
 		skb = receive_small(dev, vi, rq, buf, ctx, len, xdp_xmit, stats);
+	}
 
 	if (unlikely(!skb))
 		return;
-- 
2.32.0.3.g01195cf9f


