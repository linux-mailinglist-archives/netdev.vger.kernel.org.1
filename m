Return-Path: <netdev+bounces-139817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B11F9B44B8
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 09:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 371681F2497B
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 08:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26274204930;
	Tue, 29 Oct 2024 08:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KfcYUm+a"
X-Original-To: netdev@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256D8204926
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 08:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730191586; cv=none; b=W+vGRC7P8vFxzRXp/juLfsjxM0qdUCBcqdKiCoIUaBJER/2t0iUzuaJvEm7U54gbrUtwRV2PWX77NiA8wXVWqD3vz79iYnrm9D9KqkRdRn97wUAkYswIFrMpyyVJRnYImzi1e52Af5qv5al9S7yZbpaS7q90jC1FCAKo3M82DOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730191586; c=relaxed/simple;
	bh=jyjL2KxEBw4MlV8WGNcRAYTyK35gLoNx+kZASufdjTk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bbTm8bJ+R2MnYcTdABua+OFI29gQEs65jl4FrfosJZcp/fYKP07QcV9qCZkf+HjrQc+mLkOZzgxg8qyQwRYob2B9LDoTLR45dHm+eNBByT7zh2lWsbi3B4Gjr8r/6H364zsfjyeuBKz0c1hzm/tmbIOHEcgG4e7f9rbb/zkIIFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KfcYUm+a; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730191580; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=48sS2yg0L4ksCXiPJjQSpqFMoSDM2yftC7jysiaxfFQ=;
	b=KfcYUm+au7i12xFCiaSq1wZBx2kp3u+LGJVNpchGloVgtksgoD1OAVe6Sg9LzjN78DOUUbi9WdR3TnHFmbHovSWlPIjN7acmhr63nF+qqXZMr7Sr1+irWk5qdkjp4+KmkvnycawU7/ibQ6lL07ewlHuJ31hbVqR9sWZC/9Cw3gE=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WI9Ye2._1730191578 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 29 Oct 2024 16:46:19 +0800
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
	virtualization@lists.linux.dev,
	Darren Kenny <darren.kenny@oracle.com>
Subject: [PATCH net-next v1 3/4] virtio_net: enable premapped mode for merge and small by default
Date: Tue, 29 Oct 2024 16:46:14 +0800
Message-Id: <20241029084615.91049-4-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20241029084615.91049-1-xuanzhuo@linux.alibaba.com>
References: <20241029084615.91049-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: df8220a5376e
Content-Transfer-Encoding: 8bit

Currently, the virtio core will perform a dma operation for each
buffer. Although, the same page may be operated multiple times.

In premapped mod, we can perform only one dma operation for the pages of
the alloc frag. This is beneficial for the iommu device.

kernel command line: intel_iommu=on iommu.passthrough=0

       |  strict=0  | strict=1
Before |  775496pps | 428614pps
After  | 1109316pps | 742853pps

In the 6.11, we disabled this feature because a regress [1].

Now, we fix the problem and re-enable it.

[1]: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com

Tested-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7557808e8c1f..ea433e9650eb 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6107,6 +6107,17 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
 	return -ENOMEM;
 }
 
+static void virtnet_rq_set_premapped(struct virtnet_info *vi)
+{
+	int i;
+
+	for (i = 0; i < vi->max_queue_pairs; i++) {
+		/* error should never happen */
+		BUG_ON(virtqueue_set_dma_premapped(vi->rq[i].vq));
+		vi->rq[i].do_dma = true;
+	}
+}
+
 static int init_vqs(struct virtnet_info *vi)
 {
 	int ret;
@@ -6120,6 +6131,10 @@ static int init_vqs(struct virtnet_info *vi)
 	if (ret)
 		goto err_free;
 
+	/* disable for big mode */
+	if (!vi->big_packets || vi->mergeable_rx_bufs)
+		virtnet_rq_set_premapped(vi);
+
 	cpus_read_lock();
 	virtnet_set_affinity(vi);
 	cpus_read_unlock();
-- 
2.32.0.3.g01195cf9f


