Return-Path: <netdev+bounces-95671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EA58C2F46
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 05:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C73561C214D2
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 03:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0683F44C8F;
	Sat, 11 May 2024 03:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Kqy2r6Jt"
X-Original-To: netdev@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BF441A94
	for <netdev@vger.kernel.org>; Sat, 11 May 2024 03:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715397258; cv=none; b=fIhcJflnGfF2EPt72KCYqzDNGRL1YIa7e4adheo9RMOHtCdfjwZUeteZWaQr3ch6DoaBnuBPirWfFFak5yG1eMVycgovMNADk0dghjMSfk+uQHZFocPYDmxqQvUDoEdtq/2TX+SGKlHkcmutJvjPizWkZ0OF64F4HVm9cOtNr5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715397258; c=relaxed/simple;
	bh=lKcILrr0CQQbQMTw2bpUm49qL3L6gBAcLwf6s+8t+c8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gwjucb5nHQTgqBmlJSKo/wjUXzuhEUERcVPZQdEfPW2Zw8MVzpUFu8RB8Tu1ZLmEmvfpZmp9V22h3hLRSczk6EijeVNCu4WP+xP7MA9DAEbLCO7da2nAuHAKMzRMDBTDTHATSfSHCBZLkuFzzbVed51LwdPODEDCS0Hri2q0lGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Kqy2r6Jt; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715397249; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=3659iuCuj9lMjfvlZ4Ukvy74uMKo7KIC27i8mvKhiEA=;
	b=Kqy2r6Jt1DycwTBxXKCDkdG1oQb0AZBnkHMC/+mB9zIlhYACHBerSzeKeqNKl3g7/zlMn+S6Ho9oOJBz/oOhsp734bhxSj0kxN4yFhA0TeCHxDc10bBCVMBAYzzeeiuvRH50IHKiQhhYl6397AaIcxiwUiiaSppunc2amJQ9z1s=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W6Byw0B_1715397247;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W6Byw0B_1715397247)
          by smtp.aliyun-inc.com;
          Sat, 11 May 2024 11:14:08 +0800
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
Subject: [PATCH net-next v5 2/4] virtio_net: big mode skip the unmap check
Date: Sat, 11 May 2024 11:14:02 +0800
Message-Id: <20240511031404.30903-3-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240511031404.30903-1-xuanzhuo@linux.alibaba.com>
References: <20240511031404.30903-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: e1ef52e80115
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
index ad0fb832b538..724f9310e732 100644
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


