Return-Path: <netdev+bounces-94413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9E48BF65D
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 08:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FF221C2226D
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 06:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE6D2030B;
	Wed,  8 May 2024 06:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Hba3vx4J"
X-Original-To: netdev@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83207171B6
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 06:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715150253; cv=none; b=h37pq1KLCtBQtzraAgk8EQeDzWs8tjsLCThdoYaMQLyXltAKB/+k2fu4UOIh+pzz+P4MBiYpJPEEcqbPtV+KU5995u4LLWOCf0RlOzVJApiK4oOspUX6XWmHunwwITDanuZc6fEdus6LyDLfpATTLZOVsSnNuwkyTpvA4+vfKHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715150253; c=relaxed/simple;
	bh=jWjg4hgJzTc2CvtbL59M33pU1IElO7Gra0bZ5DNbr1k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A+/1lJgSk2pf8GT9vr3tVmMkzNZFYmugmn9GthjLYQHHbZu01wV4DnKn8ZPh+ReFcYLqTsnadT0vgXr1b3f22l1jHr4K7qikBD1kN6sycbWoINVPTppcE63V/NpNso4+dJS8bOgQzrz0R9AqwAin8mnSLGHwk5H6Otj8emw+DlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Hba3vx4J; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715150243; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=kXgwGN5+VB+qe2Z97q57EktA80yJnTrAYio1YS0R3VA=;
	b=Hba3vx4JxhQiqZYgfwD0ApMP4ja0jdtoCNzkDatYjUi5nuquKmNb0FzFt6mcdoMB7+l3ABdJBbScCmEXO4qfc5pq8yCkb3309wK145QNcHI+qJWjU8vJbfuSYwb6CtkuNk0vWXSbAvEkKlPddIpn1f7G0Yiv/3vpKYhiwNS/Xd4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W62X2ou_1715150241;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W62X2ou_1715150241)
          by smtp.aliyun-inc.com;
          Wed, 08 May 2024 14:37:22 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH net-next v4 2/4] virtio_net: big mode skip the unmap check
Date: Wed,  8 May 2024 14:37:16 +0800
Message-Id: <20240508063718.69806-3-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240508063718.69806-1-xuanzhuo@linux.alibaba.com>
References: <20240508063718.69806-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: cadd21343bbc
Content-Transfer-Encoding: 8bit

The virtio-net big mode did not enable premapped mode,
so we did not need to check the unmap. And the subsequent
commit will remove the failover code for failing enable
premapped for merge and small mode. So we need to remove
the checking do_dma code in the big mode path.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 218a446c4c27..a2452d35bb93 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -959,7 +959,7 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
 
 	rq = &vi->rq[i];
 
-	if (rq->do_dma)
+	if (!vi->big_packets || vi->mergeable_rx_bufs)
 		virtnet_rq_unmap(rq, buf, 0);
 
 	virtnet_rq_free_buf(vi, rq, buf);
@@ -2267,7 +2267,7 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
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


