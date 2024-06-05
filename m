Return-Path: <netdev+bounces-101057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DC78FD13F
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 16:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 477621C22E40
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 14:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA96F39FC5;
	Wed,  5 Jun 2024 14:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="AGr2etHu"
X-Original-To: netdev@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47F639FC1
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 14:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717599346; cv=none; b=UAgPreIzgKHsfkdsfsnvzRoGT2Rl5WpsNuIvfnoaHAQbPZpcu+1m61w3HEuXYOGgtV38AzNKxwhKtund71mqzYhmdPJEGKnTyKRPePTZBo2BUrSB9bIK4JXveDoNrg1+hIfYdwkhZ5qEF3CZ77eJMvdedqxiKoQT1VawaeKxJ90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717599346; c=relaxed/simple;
	bh=KwmcliVMqjUSTD9o0qF7vBO3APlH3puE3t0ZP2PiOmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y3rPKhQMVdKR6ol0s4iuuF/Iv1Dg6Nk37coXDW83zxC6D6ql0jPnJ06JAcXEPlcstGIzMVZ/TzsZ1tYubNSn8oVP7HA+9gEy6ymJzXXCyEWm6GjhfUij8P1L6GN2H8VCWmRbCJey5xyGZw6ERoWGcneetPAnpViOpOCR1tGgpKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=AGr2etHu; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717599336; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Ttnbl2j1aEtBTyzPVa6M/GluC//+S33k0PKWgXXCsOE=;
	b=AGr2etHubQDIWaJ2mVjZKYRZoihExFNLXRuex/2p3Sw7MPV9V4pFheSjg1Nq0NXTqyZ40ag1r3CviMmYasbXvbNP+Xz4aKlhQeRczvOr20LxdxkDIwWUIQiUu5GyuWSGsrCAiA70xVahsttuHc6cXdFQiuKaibvrp68YMeqHPtE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W7vUVwT_1717599334;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W7vUVwT_1717599334)
          by smtp.aliyun-inc.com;
          Wed, 05 Jun 2024 22:55:35 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 1/2] virtio_net: enable irq for the control vq
Date: Wed,  5 Jun 2024 22:55:32 +0800
Message-Id: <20240605145533.86229-2-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240605145533.86229-1-hengqi@linux.alibaba.com>
References: <20240605145533.86229-1-hengqi@linux.alibaba.com>
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

This code is basically from Jason:
https://lore.kernel.org/all/20230413064027.13267-3-jasowang@redhat.com/

Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 4a802c0ea2cb..9b556ce89546 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -418,6 +418,9 @@ struct virtnet_info {
 	/* Lock to protect the control VQ */
 	struct mutex cvq_lock;
 
+	/* Wait for the device to complete the cvq request. */
+	struct completion completion;
+
 	/* Host can handle any s/g split between our header and packet data */
 	bool any_header_sg;
 
@@ -664,6 +667,13 @@ static bool virtqueue_napi_complete(struct napi_struct *napi,
 	return false;
 }
 
+static void virtnet_cvq_done(struct virtqueue *cvq)
+{
+	struct virtnet_info *vi = cvq->vdev->priv;
+
+	complete(&vi->completion);
+}
+
 static void skb_xmit_done(struct virtqueue *vq)
 {
 	struct virtnet_info *vi = vq->vdev->priv;
@@ -2721,14 +2731,8 @@ static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 class, u8 cmd
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
+	wait_for_completion(&vi->completion);
+	virtqueue_get_buf(vi->cvq, &tmp);
 
 unlock:
 	mutex_unlock(&vi->cvq_lock);
@@ -5312,7 +5316,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
 
 	/* Parameters for control virtqueue, if any */
 	if (vi->has_cvq) {
-		callbacks[total_vqs - 1] = NULL;
+		callbacks[total_vqs - 1] = virtnet_cvq_done;
 		names[total_vqs - 1] = "control";
 	}
 
@@ -5832,6 +5836,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 	if (vi->has_rss || vi->has_rss_hash_report)
 		virtnet_init_default_rss(vi);
 
+	init_completion(&vi->completion);
 	enable_rx_mode_work(vi);
 
 	/* serialize netdev register + virtio_device_ready() with ndo_open() */
-- 
2.32.0.3.g01195cf9f


