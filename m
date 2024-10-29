Return-Path: <netdev+bounces-139820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBD39B44C1
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 09:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9893C1F24C83
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 08:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3F8205ABE;
	Tue, 29 Oct 2024 08:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TT+42A09"
X-Original-To: netdev@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8145920494E
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 08:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730191589; cv=none; b=EzPRyL6V5Xc1USBXgAECSL9wFa9IzwqO34KOoKDiu4eY5AHexzpZE8OcZ0Ss9PZQIlI87PeP1chJTsyDZOuFxXRO6H4M4NHHID91pqFTrkqA7L0mg3QUVEjpTpFtf3WhpRLu3RNlQrH+dbl0A71rl9e7mHEqpKFCVv0aStcSMMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730191589; c=relaxed/simple;
	bh=tLayIPhAFs4aevN7QDSWDSVqF4NHjBOAVESNKWt5heQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j12CviyG+Qf+d0HIatK0UFenH9QXTsRzBlNnWGExfycxRqL9X0WV8mHtD76KOV02SLIVCuvrWQ+30Jha5+EOxREE/5bJQp+zgqILYXqcvMUgX2ORxKztPx3zDuO8uaK+vhp5D8v6Sxk4aaYFSl1LHmmU3AzIA8B6oVGJAct8qkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TT+42A09; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730191579; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=C6wOnS9hID7035sURlfUXbTKbV7jOWOgQEJEnU/CjSM=;
	b=TT+42A09J7FElfpjXoYJNZq54DfZubYyWQ1wMVk4r+qYtdYi07xLpqQIjcXjvZwWopwaB/FohsX/FMtkJIJ0tK82p2LKIO2Q5JP2BDpZ7fEDpAbO0ISI98TU/zgyf19UEgsCYYwn6Qjg1wyc4Rkpf1haZvGck178tZys3Vecnrk=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WI9W1FN_1730191577 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 29 Oct 2024 16:46:18 +0800
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
Subject: [PATCH net-next v1 2/4] virtio_net: big mode skip the unmap check
Date: Tue, 29 Oct 2024 16:46:13 +0800
Message-Id: <20241029084615.91049-3-xuanzhuo@linux.alibaba.com>
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

The virtio-net big mode did not enable premapped mode,
so we did not need to check the unmap. And the subsequent
commit will remove the failover code for failing enable
premapped for merge and small mode. So we need to remove
the checking do_dma code in the big mode path.

Tested-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index d50c1940eb23..7557808e8c1f 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -987,7 +987,7 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
 		return;
 	}
 
-	if (rq->do_dma)
+	if (!vi->big_packets || vi->mergeable_rx_bufs)
 		virtnet_rq_unmap(rq, buf, 0);
 
 	virtnet_rq_free_buf(vi, rq, buf);
@@ -2712,7 +2712,7 @@ static int virtnet_receive_packets(struct virtnet_info *vi,
 		}
 	} else {
 		while (packets < budget &&
-		       (buf = virtnet_rq_get_buf(rq, &len, NULL)) != NULL) {
+		       (buf = virtqueue_get_buf(rq->vq, &len)) != NULL) {
 			receive_buf(vi, rq, buf, len, NULL, xdp_xmit, stats);
 			packets++;
 		}
-- 
2.32.0.3.g01195cf9f


