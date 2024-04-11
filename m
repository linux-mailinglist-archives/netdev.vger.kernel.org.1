Return-Path: <netdev+bounces-86832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DDF8A0634
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 04:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBB741F257B2
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 02:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B76513B2B3;
	Thu, 11 Apr 2024 02:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Tbr/nQve"
X-Original-To: netdev@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F0613B5A5
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 02:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712803897; cv=none; b=DeuRLI2ah2Q5WWofTqfXV5FsHB14z+rDlDZEZqHQ4CE20jFjNAiwmUCp0ENVotWJvmZk38MyeyoQh2LXnlbVmNnusxFuSSUgLb+vm0vJ1wpzGntZ1z74Y8MfZBzmSQWNJhgHX/ns2oM7ljvLFy/wMgos6vNEDkJ8DzsNAa9QXF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712803897; c=relaxed/simple;
	bh=miCPScfh21j9uz1QvaLJKnsl7ydBn0J4ay5WPoqV3+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XnHp42McO9eXAY2kRMNFdwBYQ1mkwObdREcOgYPk2INyqR/FGJK8WA7wpVxXzLSvGuW+4acijTJN+Y1nHn8I0GZKTsDMHw41DLH8Lf86ABCEUTOa541p1iUrr44x84p1wTPrZPswC3HFdynvCXkdO+Ut8A4tWDFK3bXD7FjKMoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Tbr/nQve; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712803893; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Mc+qwhMMQZxW7Pe4sx6I9JfFRSK5ghrWVN+yqd/F7H4=;
	b=Tbr/nQvegDFNupMM8PkCj5lQG53iXDt7Xn6BsO6l5vgOGn96Bpts87REuM+ee2yhcsTHG/jq7L9vtw1P57utejpKbNOJMvDLA4m7hB/E9DStCqqNUiK9FZ6SD099tIHgyP9hQ19OdIbRpAdr5CmK7tss9sDrtvNLN8FDUqy8Fqs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W4JPoA8_1712803891;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W4JPoA8_1712803891)
          by smtp.aliyun-inc.com;
          Thu, 11 Apr 2024 10:51:32 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH vhost 5/6] virtio_net: enable premapped by default
Date: Thu, 11 Apr 2024 10:51:26 +0800
Message-Id: <20240411025127.51945-6-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240411025127.51945-1-xuanzhuo@linux.alibaba.com>
References: <20240411025127.51945-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: aa9dfb80fb4a
Content-Transfer-Encoding: 8bit

Currently, big, merge, and small modes all support the premapped mode.
We can now enable premapped mode by default. Furthermore,
virtqueue_set_dma_premapped() must succeed when called immediately after
find_vqs(). Consequently, we can assume that premapped mode is always
enabled.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7ea7e9bcd5d7..f0faf7c0fe59 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -860,15 +860,13 @@ static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
 
 static void virtnet_rq_set_premapped(struct virtnet_info *vi)
 {
-	int i;
-
-	/* disable for big mode */
-	if (!vi->mergeable_rx_bufs && vi->big_packets)
-		return;
+	int i, err;
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {
-		if (virtqueue_set_dma_premapped(vi->rq[i].vq))
-			continue;
+		err = virtqueue_set_dma_premapped(vi->rq[i].vq);
+
+		/* never happen */
+		BUG_ON(err);
 
 		vi->rq[i].do_dma = true;
 	}
-- 
2.32.0.3.g01195cf9f


