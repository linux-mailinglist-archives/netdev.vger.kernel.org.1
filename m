Return-Path: <netdev+bounces-124821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C171C96B108
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 08:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F48AB213F7
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 06:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E852484E0A;
	Wed,  4 Sep 2024 06:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ke9mNOLq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F9282C7E
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 06:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725430223; cv=none; b=hK5RX/rEnCWITzXrfWPPk/ygiv4STVy15BFD4Npi0Q3re88bFA2BNeDBQNSSY3sYc0rPxjgGxETyGEmPRMkWTIWYdomz9xcgDvQ/tzE/d/ZYBVjnmroWf+k7fKZnsuO9abnAw3HKj91Pa5vrNpYqGjSy/dEY4VjsnreBecvVT5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725430223; c=relaxed/simple;
	bh=014gXkD8ygbNVGMJO+0Zp0ga5DirG6KNtyYbEwIUiCU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qk2a5+FjSdEjgg7/qVznNupBkbb7sWyXiRQtMvOHZ9+pYkqMcSNiVvdMsbWQAT1FeoakLKSgvnWLhC+7KCsKC5T6sUF0G6vd3BsASrQzxeN+ENY3ELCZ1hBH5py5uBcpIcX9J3CdktS+SPzc9ehOfPIVgMWmyIG0PDkbZR9QMHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ke9mNOLq; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7b0c9bbddb4so344255a12.3
        for <netdev@vger.kernel.org>; Tue, 03 Sep 2024 23:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1725430220; x=1726035020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V36tSWxAHLAIOwnkr8bXXchZBGFhkcs/NfyGu0nHDJw=;
        b=ke9mNOLqSBayh2F08yupz1d86VGCKQMD5YVzwom1GDULdcM8IHz5evIBuNJPTS8Ki1
         wzUnOReGrUkxbHv99ETqrCyPU9olFZMgUQd5MjwT4lTWTYrXBgei+/RQRcIPpAGiuUPb
         cp0betABczsUDRPDsM5USlkqa3G5Yc2fihMpJH7MNh6Re088Fz3bvwdIKczNTzQhYZpa
         UtIwfEvMWbApKLC2/4zbqwZrcdomgucMmypV2924arjmmsPlWuUvoY5p05EvlLg1KYCo
         KF7cCmfjPtTivB5jGzMN4jIdYVkiegqMTTF2BbvkhnRrSKwqs6Yn3wMa4CuWjcB6vz0S
         MdYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725430220; x=1726035020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V36tSWxAHLAIOwnkr8bXXchZBGFhkcs/NfyGu0nHDJw=;
        b=DP7M32w00P0cjAh943FmcJEYvIkkPEoCjpQ8iA4BjG7NA0GR0USyoqD5Rz4HFSzbAA
         oGESWHN2kywEBLn8SYcb8yx+k9VqwAarprgbvyM6WOaTWrWMK8RKQPJ82DTeuCOQVrqV
         yFGOL9bh1M8PSLn6c1S8+5jZYvKd7hVWd/Yygb9ihXlKLCrjxzcK5kx+VIk5lsPbwOX6
         vmdQRTzHYr534rWWoe7awM3K4LsHevx7kDaIH3ZpWpBdFYRiMTXLwyIuXyInqWvNt2iz
         ZrX+SPiZwno3BTvqoMxFWiO9VD/QDBmm6Q56sNWwXe3jY7ORK0OBiyoVLbQwoz3DpL4M
         qwyg==
X-Forwarded-Encrypted: i=1; AJvYcCVzGcpGAuuXMLRvHln2YdBZZz/k+7V/9Y9ySzws9QXPX7VPLywviJGnutKIQ2S5LLWco6mbtEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhEfugrnFptiYuZMeAOelbsHKyBpTThPA4ZFvWZFUIaGaGIaHi
	WsFVoLBiF5/yeHm3sQm+ZEDb2TFMHijQZLoGii5CwoZR3XUW1qCQdhqO5m8Odkg=
X-Google-Smtp-Source: AGHT+IHMau4o8Ew3FW+eey6qgIUz41XJZGyUqCz0/A7x+A6o0sgpiBWZX5EMygQKk21MSGSMGAcELQ==
X-Received: by 2002:a17:903:18d:b0:206:b5b8:25ef with SMTP id d9443c01a7336-206b5b82940mr13284525ad.15.1725430220327;
        Tue, 03 Sep 2024 23:10:20 -0700 (PDT)
Received: from LRW1FYT73J.bytedance.net ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae912357sm6989385ad.14.2024.09.03.23.10.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Sep 2024 23:10:19 -0700 (PDT)
From: Wenbo Li <liwenbo.martin@bytedance.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wenbo Li <liwenbo.martin@bytedance.com>,
	Jiahui Cen <cenjiahui@bytedance.com>,
	Ying Fang <fangying.tommy@bytedance.com>
Subject: [PATCH v2] virtio_net: Fix mismatched buf address when unmapping for small packets
Date: Wed,  4 Sep 2024 14:10:09 +0800
Message-Id: <20240904061009.90785-1-liwenbo.martin@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the virtio-net driver will perform a pre-dma-mapping for
small or mergeable RX buffer. But for small packets, a mismatched address
without VIRTNET_RX_PAD and xdp_headroom is used for unmapping.

That will result in unsynchronized buffers when SWIOTLB is enabled, for
example, when running as a TDX guest.

This patch handles small and mergeable packets separately and fixes
the mismatched buffer address.

Changes from v1: Use ctx to get xdp_headroom.

Fixes: 295525e29a5b ("virtio_net: merge dma operations when filling mergeable buffers")
Signed-off-by: Wenbo Li <liwenbo.martin@bytedance.com>
Signed-off-by: Jiahui Cen <cenjiahui@bytedance.com>
Signed-off-by: Ying Fang <fangying.tommy@bytedance.com>
---
 drivers/net/virtio_net.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index c6af18948..cbc3c0ae4 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -891,6 +891,23 @@ static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void **ctx)
 	return buf;
 }
 
+static void *virtnet_rq_get_buf_small(struct receive_queue *rq,
+				      u32 *len,
+				      void **ctx,
+				      unsigned int header_offset)
+{
+	void *buf;
+	unsigned int xdp_headroom;
+
+	buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
+	if (buf) {
+		xdp_headroom = (unsigned long)*ctx;
+		virtnet_rq_unmap(rq, buf + VIRTNET_RX_PAD + xdp_headroom, *len);
+	}
+
+	return buf;
+}
+
 static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *buf, u32 len)
 {
 	struct virtnet_rq_dma *dma;
@@ -2692,13 +2709,23 @@ static int virtnet_receive_packets(struct virtnet_info *vi,
 	int packets = 0;
 	void *buf;
 
-	if (!vi->big_packets || vi->mergeable_rx_bufs) {
+	if (vi->mergeable_rx_bufs) {
 		void *ctx;
 		while (packets < budget &&
 		       (buf = virtnet_rq_get_buf(rq, &len, &ctx))) {
 			receive_buf(vi, rq, buf, len, ctx, xdp_xmit, stats);
 			packets++;
 		}
+	} else if (!vi->big_packets) {
+		void *ctx;
+		unsigned int xdp_headroom = virtnet_get_headroom(vi);
+		unsigned int header_offset = VIRTNET_RX_PAD + xdp_headroom;
+
+		while (packets < budget &&
+		       (buf = virtnet_rq_get_buf_small(rq, &len, &ctx, header_offset))) {
+			receive_buf(vi, rq, buf, len, ctx, xdp_xmit, stats);
+			packets++;
+		}
 	} else {
 		while (packets < budget &&
 		       (buf = virtqueue_get_buf(rq->vq, &len)) != NULL) {
-- 
2.20.1


