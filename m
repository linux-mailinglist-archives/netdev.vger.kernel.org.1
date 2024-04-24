Return-Path: <netdev+bounces-90805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD59A8B0405
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 10:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83D001F22332
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 08:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46301158A10;
	Wed, 24 Apr 2024 08:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="E+L0UBfl"
X-Original-To: netdev@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC7C158867
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 08:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713946606; cv=none; b=IUizYx7425d+NXza8lUcb1NG+WpI6W7Hz+8BqQWtycjtYdbGBexHT6yJk8SxShEATt4lQSMqt5ZPgXyqR0VB2ajBBXnob1qiyoyewnqaLSChc2ggsdUf66XBGDIi+m4EScvUQ56Ycitnj0kUIOLvNotRe8IymtXCFXr0DDPaLcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713946606; c=relaxed/simple;
	bh=P5b0K6KZflTZeSl43mhWXdlifhE5pyKdTUPP7/8Lboo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kPoev+VL+bGBnoPxiAVWKS8zNdR3OZXU5m1gZ95ErHek+rl4rMwwKV8kQ883QOcofd0fpTK1g9mabQ2rJ8Mbt8XGWi0VNpPmhAljypU0wplZ5hGROkF84tsqxq3yBeF8hgT41e5KUEyM7FJFkoq6emD2Fb/81nCckt6h7cwpiYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=E+L0UBfl; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713946601; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=7i4V7NWPrYoul3sd48hjn2e81AN+49jmbU0ySJ9TOO0=;
	b=E+L0UBflC/2re1cSezkOBy6LkiFhayJe0Mwcz2E3welNhJCaLAk4ZVfRa15jdJjrb7FuNImuLN/Eh6nmX4ksj7bWsn6LL+btGP9Hgo4p30MyrS7QwLbLwlugVHLX14E7Xl724dbrnpXVLV++DojMbnORfnq53UqEt/A0eXJCkzs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W5BlAUA_1713946599;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W5BlAUA_1713946599)
          by smtp.aliyun-inc.com;
          Wed, 24 Apr 2024 16:16:40 +0800
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
Subject: [PATCH vhost v3 2/4] virtio_net: big mode skip the unmap check
Date: Wed, 24 Apr 2024 16:16:34 +0800
Message-Id: <20240424081636.124029-3-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240424081636.124029-1-xuanzhuo@linux.alibaba.com>
References: <20240424081636.124029-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 55c7001bc45b
Content-Transfer-Encoding: 8bit

The virtio-net big mode did not enable premapped mode,
so we did not need to check the unmap. And the subsequent
commit will remove the failover code for failing enable
premapped for merge and small mode. So we need to remove
the checking do_dma code in the big mode path.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index c22d1118a133..16d84c95779c 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -820,7 +820,7 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
 
 	rq = &vi->rq[i];
 
-	if (rq->do_dma)
+	if (!vi->big_packets || vi->mergeable_rx_bufs)
 		virtnet_rq_unmap(rq, buf, 0);
 
 	virtnet_rq_free_buf(vi, rq, buf);
@@ -2128,7 +2128,7 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
 		}
 	} else {
 		while (packets < budget &&
-		       (buf = virtnet_rq_get_buf(rq, &len, NULL)) != NULL) {
+		       (buf = virtqueue_get_buf(rq->vq, &len)) != NULL) {
 			receive_buf(vi, rq, buf, len, NULL, xdp_xmit, &stats);
 			packets++;
 		}
-- 
2.32.0.3.g01195cf9f


