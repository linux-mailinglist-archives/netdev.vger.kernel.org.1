Return-Path: <netdev+bounces-104943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAE890F3DC
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 18:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D5BC1F21188
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 16:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B6915253F;
	Wed, 19 Jun 2024 16:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uT69190t"
X-Original-To: netdev@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CDE15217F
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 16:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718813956; cv=none; b=XXrHGT2eX3m9/BbDs1b1udXbkRyfoJbY4fejjycrRuhpiPhK9qRCHdp8GqIPcvkQQPP/Y30EjJgy0yjJzol3bTFdMKA95Fg5xCVXlQ0bJHElZOfL4/wwHvH11qMTWjXevji9Nk7c+/Fxp/PDnd7wiT5rg5TFa89EKRoi5zvOe0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718813956; c=relaxed/simple;
	bh=1BZJxMvxEUAwC1iRE3nfzUQtnqIt/eiXx6ZTm6rSSRk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WZ5WdmRFvVvSvW93BWM+xbCzKNvC0L/E8MfKVm/HV3C1bxuUqXhILFlsUzJE6EH2/2ASERca7N1qf/Ddaud4QM1ZSwb4SU9yAo7+uumaCwzzZTbJAejvovqSNjs225EGTWwBjYmhZzCuPEK+qvmAGWiS6Y9oVmqFShVa4RWuIMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uT69190t; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718813951; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=d0e/DRwzgHTVqh5xXymRXwDC8hqxwM0bVlAwXi4XQX0=;
	b=uT69190tkMxqkvLkEXVlMVfJPPvLRZXZXRA/bR3XQMJ6jupfppZcbjQ0b7u/xD9di7ZrWZlLjyDQmGu5RLdJQ6h4I2L5GO/upKM0tnlij2+EgFmRIazW8M4RmbcnUPr6XrdCBnI6YotIaj0EpaC3lqOUGfVuGZASZ9UPDRpDpD4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W8oeGZa_1718813950;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W8oeGZa_1718813950)
          by smtp.aliyun-inc.com;
          Thu, 20 Jun 2024 00:19:11 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v4 2/5] virtio_net: enable irq for the control vq
Date: Thu, 20 Jun 2024 00:19:05 +0800
Message-Id: <20240619161908.82348-3-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240619161908.82348-1-hengqi@linux.alibaba.com>
References: <20240619161908.82348-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the device does not respond to a request for a long time,
then control vq polling elevates CPU utilization, a problem that
exacerbates with more command requests.

Enabling control vq's irq is advantageous for the guest, and
this still doesn't support concurrent requests.

Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index b45f58a902e3..ed10084997d3 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -372,6 +372,8 @@ struct virtio_net_ctrl_rss {
 struct control_buf {
 	struct virtio_net_ctrl_hdr hdr;
 	virtio_net_ctrl_ack status;
+	/* Wait for the device to complete the cvq request. */
+	struct completion completion;
 };
 
 struct virtnet_info {
@@ -664,6 +666,13 @@ static bool virtqueue_napi_complete(struct napi_struct *napi,
 	return false;
 }
 
+static void virtnet_cvq_done(struct virtqueue *cvq)
+{
+	struct virtnet_info *vi = cvq->vdev->priv;
+
+	complete(&vi->ctrl->completion);
+}
+
 static void skb_xmit_done(struct virtqueue *vq)
 {
 	struct virtnet_info *vi = vq->vdev->priv;
@@ -2724,14 +2733,8 @@ static bool virtnet_send_command_reply(struct virtnet_info *vi,
 	if (unlikely(!virtqueue_kick(vi->cvq)))
 		goto unlock;
 
-	/* Spin for a response, the kick causes an ioport write, trapping
-	 * into the hypervisor, so the request should be handled immediately.
-	 */
-	while (!virtqueue_get_buf(vi->cvq, &tmp) &&
-	       !virtqueue_is_broken(vi->cvq)) {
-		cond_resched();
-		cpu_relax();
-	}
+	wait_for_completion(&ctrl->completion);
+	virtqueue_get_buf(vi->cvq, &tmp);
 
 unlock:
 	ok = ctrl->status == VIRTIO_NET_OK;
@@ -5312,7 +5315,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
 
 	/* Parameters for control virtqueue, if any */
 	if (vi->has_cvq) {
-		callbacks[total_vqs - 1] = NULL;
+		callbacks[total_vqs - 1] = virtnet_cvq_done;
 		names[total_vqs - 1] = "control";
 	}
 
@@ -5832,6 +5835,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 	if (vi->has_rss || vi->has_rss_hash_report)
 		virtnet_init_default_rss(vi);
 
+	init_completion(&vi->ctrl->completion);
 	enable_rx_mode_work(vi);
 
 	/* serialize netdev register + virtio_device_ready() with ndo_open() */
-- 
2.32.0.3.g01195cf9f


