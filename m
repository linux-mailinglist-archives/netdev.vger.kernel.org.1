Return-Path: <netdev+bounces-113642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CD193F5D7
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 14:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 510431C22191
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 12:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF7A146D6D;
	Mon, 29 Jul 2024 12:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sssjVpFj"
X-Original-To: netdev@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFF1148304
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 12:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722257288; cv=none; b=KQIZ8wjZhvrukLdkCq/QZsWaX30wkz6fq3LrVVtsyDQkKw/L1H36H0Vbj9xdwQHn+PIciuhZm/A2NkvNVo5c1kQ9n8b6fvvaf5+WRoe5O63uHt++W0nrQj/+cmNDrMkV35NPDWIxR+zUBQtMoRoJbihvIR2HL/uba1UcqvkZySg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722257288; c=relaxed/simple;
	bh=igE+HtJT8zZ0cFXeIrI6FitI2VfseQpKEFSgzHO3Sf4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RSice3lfXVCUJQAm2eg9TKT70pQozr9Wf7dVlF0hGZ6/25ZStoewlcfHOEaI7Y5E5n4Nj8mM20LM1npnPuYo1XEGXkqTAl8AnpHamy17SJtf//E2gxtPQHp3azs3BKhLVdvlvkro+Q2nsKdWZB2gTkbOL33ZHI4HZYGqOfFpUrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sssjVpFj; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722257277; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=+OBdQR7y6nQXG3Qmm9hHKCHP3uBvPQTWwwC7JEBJ6Uk=;
	b=sssjVpFjEdeBLYD/z+CSu3fj3tNSrU/ulYDasKALWmVcyWM22L8dLJ9hSOSENFFftGxER1XAy3gFEkXe6AJMZQLQ66PxpxXRzEOQK//AYjQlEhjK7+RADtD3aCsSxZjo+63+ni85E2GoeX88n2RFXQyJPBTN8WUBe5AnOfV6lH8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0WBb8gbw_1722257275;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0WBb8gbw_1722257275)
          by smtp.aliyun-inc.com;
          Mon, 29 Jul 2024 20:47:56 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux.dev,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH net] virtio_net: Avoid sending unnecessary vq coalescing commands
Date: Mon, 29 Jul 2024 20:47:55 +0800
Message-Id: <20240729124755.35719-1-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From the virtio spec:

	The driver MUST have negotiated the VIRTIO_NET_F_VQ_NOTF_COAL
	feature when issuing commands VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET
	and VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET.

The driver must not send vq notification coalescing commands if
VIRTIO_NET_F_VQ_NOTF_COAL is not negotiated. This limitation of course
applies to vq resize.

Fixes: f61fe5f081cf ("virtio-net: fix the vq coalescing setting for vq resize")
Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 0383a3e136d6..eb115e807882 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3708,6 +3708,7 @@ static int virtnet_set_ringparam(struct net_device *dev,
 	u32 rx_pending, tx_pending;
 	struct receive_queue *rq;
 	struct send_queue *sq;
+	u32 pkts, usecs;
 	int i, err;
 
 	if (ring->rx_mini_pending || ring->rx_jumbo_pending)
@@ -3740,11 +3741,13 @@ static int virtnet_set_ringparam(struct net_device *dev,
 			 * through the VIRTIO_NET_CTRL_NOTF_COAL_TX_SET command, or, if the driver
 			 * did not set any TX coalescing parameters, to 0.
 			 */
-			err = virtnet_send_tx_ctrl_coal_vq_cmd(vi, i,
-							       vi->intr_coal_tx.max_usecs,
-							       vi->intr_coal_tx.max_packets);
-			if (err)
-				return err;
+			if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL)) {
+				usecs = vi->intr_coal_tx.max_usecs;
+				pkts = vi->intr_coal_tx.max_packets;
+				err = virtnet_send_tx_ctrl_coal_vq_cmd(vi, i, usecs, pkts);
+				if (err)
+					return err;
+			}
 		}
 
 		if (ring->rx_pending != rx_pending) {
@@ -3753,13 +3756,15 @@ static int virtnet_set_ringparam(struct net_device *dev,
 				return err;
 
 			/* The reason is same as the transmit virtqueue reset */
-			mutex_lock(&vi->rq[i].dim_lock);
-			err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, i,
-							       vi->intr_coal_rx.max_usecs,
-							       vi->intr_coal_rx.max_packets);
-			mutex_unlock(&vi->rq[i].dim_lock);
-			if (err)
-				return err;
+			if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL)) {
+				usecs = vi->intr_coal_rx.max_usecs;
+				pkts = vi->intr_coal_rx.max_packets;
+				mutex_lock(&vi->rq[i].dim_lock);
+				err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, i, usecs, pkts);
+				mutex_unlock(&vi->rq[i].dim_lock);
+				if (err)
+					return err;
+			}
 		}
 	}
 
-- 
2.32.0.3.g01195cf9f


