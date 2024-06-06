Return-Path: <netdev+bounces-101269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9432B8FDE96
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 08:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3DFF28761E
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 06:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0CE71B47;
	Thu,  6 Jun 2024 06:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GmUZMl8z"
X-Original-To: netdev@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B54261FD3
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 06:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717654512; cv=none; b=cI6OCHRYMRUKEFVXHjdHVY8sSbK10uhEkWDJyhhXq7RV/s0s800HlFqx3DOV7wE+dmCqX1YAhtFicyQcZWhYmv+2T4zHA3JWclwXgeA3vyTQvRLED+nb1hsO8Cq+qE3CBOm5Sp7HgoRpad9TZ1NVATmUifpIvfOEEPYAB9XS2Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717654512; c=relaxed/simple;
	bh=VN2iUoBWnyYiXaKESDXLd0fHPmf0gc5XV6WaeeCq+6w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hvH/eRDyz4L+Wqoh2xr92odOGlye4prFTeY09JcFKOziZyxxqb2wAuE9hcjkEnp5JS1jeu7bvz0it/rsNcJWStmTv5m6iCFY/U9sDgv/1rLlthq8Gb7s3JWJcYiAOlVZhShBclJnv+Zvza3V875lGkp4+6wpiLHymgUe16ptrnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GmUZMl8z; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717654501; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=3D88LeRE+6voTWokvHbaC35N34h1htu9n5z6n7Tnn/8=;
	b=GmUZMl8zVBAcpzJF7OT5APyZWqpSRnKI5WmAO4rbJ8s/KcQa8Vs1BALmPqgsfANDkcWpPyyyat90FaFYxKE2jM+TIqBuOoNzy6wiXf7p6a6Ob6c9aiHCMyptQbc5/2CkOCt3hpqDgHJOxKzbGESHeEBScFa4/8Xs8NVzYAC658w=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W7xDgpZ_1717654494;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W7xDgpZ_1717654494)
          by smtp.aliyun-inc.com;
          Thu, 06 Jun 2024 14:14:58 +0800
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
Subject: [PATCH net-next v3 2/4] virtio_net: enable irq for the control vq
Date: Thu,  6 Jun 2024 14:14:44 +0800
Message-Id: <20240606061446.127802-3-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240606061446.127802-1-hengqi@linux.alibaba.com>
References: <20240606061446.127802-1-hengqi@linux.alibaba.com>
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
index 0f872936d6ed..823a9dca51c1 100644
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
@@ -2723,14 +2732,8 @@ static bool virtnet_send_command_reply(struct virtnet_info *vi,
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
+	wait_for_completion(&vi->ctrl->completion);
+	virtqueue_get_buf(vi->cvq, &tmp);
 
 unlock:
 	mutex_unlock(&vi->cvq_lock);
@@ -5314,7 +5317,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
 
 	/* Parameters for control virtqueue, if any */
 	if (vi->has_cvq) {
-		callbacks[total_vqs - 1] = NULL;
+		callbacks[total_vqs - 1] = virtnet_cvq_done;
 		names[total_vqs - 1] = "control";
 	}
 
@@ -5834,6 +5837,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 	if (vi->has_rss || vi->has_rss_hash_report)
 		virtnet_init_default_rss(vi);
 
+	init_completion(&vi->ctrl->completion);
 	enable_rx_mode_work(vi);
 
 	/* serialize netdev register + virtio_device_ready() with ndo_open() */
-- 
2.32.0.3.g01195cf9f


