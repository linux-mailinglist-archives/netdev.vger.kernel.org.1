Return-Path: <netdev+bounces-89965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D948A8AC57B
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 09:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E6411F23920
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 07:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC7950A6E;
	Mon, 22 Apr 2024 07:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JvBLwAXz"
X-Original-To: netdev@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4A05029E
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 07:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713770660; cv=none; b=WyC0chL6TXD0ypd6dWkrZ2ZEmDpCJMiJjOuxbhnzRq8zLipG+6KWI9Dy3u5QSKSbnyfD1QgCVggWSmrQ9s8TXYgCtQWHhQzJ48PE7JlgJJjv63umSf3M2f3Mn7mlzsgJZBmg6stDPXiZ8f2A9RWiGF2/blZQ3x4u5sAXveRR0uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713770660; c=relaxed/simple;
	bh=GwRgAB8+myCzYs49EetAYoyxlLK3o1zRbwFkQVNKsOU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VNz3UfjfvmYnCyIGbDpmWNLj404zQz+mRKuf9lbP93rWNY8HhG6Uv7ddADCkDzGoyEi8DsvX0Cn5AGBFz5z9qWpS7jvoJdiKb7bd0ULeZaPn8Ui396x7+UsnZkvAjKdyfwwZENJXvnIZ8qlT6DuukGzJiTuyhkaccxxGMDTD+sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JvBLwAXz; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713770656; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=FJpFi/MWH6Aswgcto79sFfR+i5d1gpvvgOn4AesLcLs=;
	b=JvBLwAXzYeO0dS/r33wnEEnb/3Xe6ncVnKAOdKdKdtnSt9JfJiM6YopKxUzj6uNuxeJ/n+gdB8Lvutj10n/T0O5ffXzWqU3dTwZV7A+/JdNAQhaStGg1gMjh9V+kGD/MhhgiwdZxYQauJ4e6VyjX0l2M/+V0Edwq1bi9b8zsvk8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W5.kZo7_1713770654;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W5.kZo7_1713770654)
          by smtp.aliyun-inc.com;
          Mon, 22 Apr 2024 15:24:15 +0800
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
Subject: [PATCH vhost v2 5/7] virtio_net: enable premapped by default
Date: Mon, 22 Apr 2024 15:24:06 +0800
Message-Id: <20240422072408.126821-6-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240422072408.126821-1-xuanzhuo@linux.alibaba.com>
References: <20240422072408.126821-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: aa968d36d784
Content-Transfer-Encoding: 8bit

Currently, big, merge, and small modes all support the premapped mode.
We can now enable premapped mode by default. Furthermore,
virtqueue_set_dma_premapped() must succeed when called immediately after
find_vqs(). Consequently, we can assume that premapped mode is always
enabled.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index d4f5e65b247e..f04b10426b8f 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -896,13 +896,9 @@ static void virtnet_rq_set_premapped(struct virtnet_info *vi)
 {
 	int i;
 
-	/* disable for big mode */
-	if (!vi->mergeable_rx_bufs && vi->big_packets)
-		return;
-
 	for (i = 0; i < vi->max_queue_pairs; i++) {
-		if (virtqueue_set_dma_premapped(vi->rq[i].vq))
-			continue;
+		/* error never happen */
+		BUG_ON(virtqueue_set_dma_premapped(vi->rq[i].vq));
 
 		vi->rq[i].do_dma = true;
 	}
-- 
2.32.0.3.g01195cf9f


