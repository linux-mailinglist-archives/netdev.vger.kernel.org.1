Return-Path: <netdev+bounces-232370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBCDC04C7A
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 09:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8505B35A7A9
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 07:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4052E8E13;
	Fri, 24 Oct 2025 07:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZmIdO6oW"
X-Original-To: netdev@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D8D2E8894
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 07:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291697; cv=none; b=LJhxPXHds6tdtzPYETHVIbQKGeeJOxmNmM212EaGfWXPhYqE6dfb+HsKlV0kmlQxmh/Bxsms2e84qGIWU3ozepdAodnLrE2wqcWxwTJZNZxXPOoZD8JzLtSyxADanrG5F5QSk6dhOt+KNScmDOYFoNgzPJ1awygejYPbPy7owWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291697; c=relaxed/simple;
	bh=VsGrtzGrNy1cIT4AoNC/ON4WFlgvVfd6eytwrKQgnPg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B7MAgtStrAK20Yqv84pZ9CPdsQI8R/izQWgvy8rEfPce9rjDrOyXUEUGrqVmwoM49hi54sUBvvBYDzm7FnuT0hyATIJVbSVDYojvRqQ3bWm43mglqyxXixFcZca/orJRalamGv24wIfS6Ps6LqG3XPAKAUngU//9D1b6Q8doClc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZmIdO6oW; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761291692; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=38XUyf4PYI6r7rorqyBRnTafMkc9cf9wYq9IqQkZUMc=;
	b=ZmIdO6oWpVGnkIk2oyYecorfQjTnld7o2pne57V0iqWrWYul9hUYxufc0ibzQkPI/PhedcXq1eFNrR8MvOp/KHaIZXZAlj0MO8u2Q7DR+0FjBN1TNMA8axNKBHwambDtX6p5lZotN7nKm+CENY7nAko/WxgVw70pG8qYTvK0z5c=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Wqtb4BM_1761291691 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 24 Oct 2025 15:41:31 +0800
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
Subject: [PATCH net v3 1/3] virtio-net: fix incorrect flags recording in big mode
Date: Fri, 24 Oct 2025 15:41:28 +0800
Message-Id: <20251024074130.65580-2-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20251024074130.65580-1-xuanzhuo@linux.alibaba.com>
References: <20251024074130.65580-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: deaf684dfaeb
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
index 8e8a179aaa49..59f116b609f6 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2625,22 +2625,28 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
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


