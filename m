Return-Path: <netdev+bounces-125920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0B696F458
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 14:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D6751F25B82
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 12:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD151C8FA6;
	Fri,  6 Sep 2024 12:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mE0dNQUg"
X-Original-To: netdev@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6160B2745B
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 12:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725625907; cv=none; b=cbmUCKr7fZpgSVU1rwxDFGTZvx6TQJDSUHC+nZXaoIppTMsC0KYNCUeL5q4ajtOLw3/9B+KTyH/Y9s2g34BeH9kgCfhrwswHMzmV8NN/yS/1oPRaul5uWLFUyNNDNCv8vqhhUeU/pEQhZancRBUwTfNwrtcIWlDSVOuHOiibOwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725625907; c=relaxed/simple;
	bh=mn7y2zkZQcflb7caPkSvKXMi0qBZrd4lUlyd2cMwMpc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dawxxnp07bOe6gPM/gyzubEejrL/XKvsqmW5iLXABWO4PILtHc6oVk4fvZwPcf2yk225pfT/glgdQQpt3Z74RcGHWtOaUUG6NQk3Uu4j8lQWB/uXwqJ2nC/pkBo1HRj/+6YDuBwRLob9c1vy966qJtoqJW9isrrxDtxO8y05rCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mE0dNQUg; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725625902; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=flm84cZ50p0ZhzY1qn+60k+Q7cO3pJV1KA7+5DMpu1A=;
	b=mE0dNQUgz66heqkAPDSjLP+BqYqekifpAhVHDkqY567YGz779g7cRbCoQB0MNM3fBCW8kVCeEimsK6rS5aTs1XLGAz2VTHFDCW2rLsQSq3sSP/VFYgXYTyt12AObL2QblrCEBiAwLJXGUcoAxQiUxXxxWbJBYdYE88XjMLVKfXU=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WEPa0pQ_1725625899)
          by smtp.aliyun-inc.com;
          Fri, 06 Sep 2024 20:31:40 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Darren Kenny <darren.kenny@oracle.com>,
	"Si-Wei Liu" <si-wei.liu@oracle.com>
Subject: [PATCH 2/3] Revert "virtio_net: big mode skip the unmap check"
Date: Fri,  6 Sep 2024 20:31:36 +0800
Message-Id: <20240906123137.108741-3-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240906123137.108741-1-xuanzhuo@linux.alibaba.com>
References: <20240906123137.108741-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: ccfd5e625b8b
Content-Transfer-Encoding: 8bit

This reverts commit a377ae542d8d0a20a3173da3bbba72e045bea7a9.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 36a7781979b7..b68e64e8c7b6 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1008,7 +1008,7 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
 		return;
 	}
 
-	if (!vi->big_packets || vi->mergeable_rx_bufs)
+	if (rq->do_dma)
 		virtnet_rq_unmap(rq, buf, 0);
 
 	virtnet_rq_free_buf(vi, rq, buf);
@@ -2718,7 +2718,7 @@ static int virtnet_receive_packets(struct virtnet_info *vi,
 		}
 	} else {
 		while (packets < budget &&
-		       (buf = virtqueue_get_buf(rq->vq, &len)) != NULL) {
+		       (buf = virtnet_rq_get_buf(rq, &len, NULL)) != NULL) {
 			receive_buf(vi, rq, buf, len, NULL, xdp_xmit, stats);
 			packets++;
 		}
-- 
2.32.0.3.g01195cf9f


