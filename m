Return-Path: <netdev+bounces-101267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9598FDE91
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 08:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B8481C21CD7
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 06:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80D851021;
	Thu,  6 Jun 2024 06:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CcSdh+Q1"
X-Original-To: netdev@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D474DA14
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 06:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717654501; cv=none; b=tqthXToYm5BuXiFbI7y306oJUrfLtq0Lvst5OczFSJgXw93QMlBaOlEkC+7VhEDUgJzTCrpj5tTFcqEp7JWLmUVpMSbDaDOK8COTpkfTykfQhqf9EWNUfKkVH+JOhsX/7J0tWYRMRjZUR+apqOvjyBUP2nPpvflAOjwLRdF4bv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717654501; c=relaxed/simple;
	bh=fyYpu7MxqD1gUL9xBttutRRy+Nl0wJMZ7nQ9jBzswHE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MJ6Di4fqIk+MA5ithNe6dV2xfUGhQvMT6GcCZP+m6MoKiuzOT+tjI+doLtyTB0+7r1eX90qVAZQMeB2J3qnIV3l4RxP0G9ve7LhchG7CDexZ6OE3C30Onz1nEfLAJWUmJ6yfTk7xciY2ktlxRi5SMcnOSHFKEWp/XtegfEC5H1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CcSdh+Q1; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717654496; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=REAT+/W1Vu+TlElmxbEOqsqLKmA92uxNeUfymZn1AaQ=;
	b=CcSdh+Q13YUMOQC7hEfmwsflJvh/D6hj26mtKD6IsRAzSP1iB094BpafEvHImQpdcOFwPsCC4E8HXI1e+poqaXWWvuESCljzudSN47XKr6iW8pDA9xiceBWHQi3SyQI226z+ok5bpHfSdOYZxK+X6NJxs/Nx90E+oGMEilu7/yY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W7xKi9d_1717654487;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W7xKi9d_1717654487)
          by smtp.aliyun-inc.com;
          Thu, 06 Jun 2024 14:14:54 +0800
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
Subject: [PATCH net-next v3 1/4] virtio_net: passing control_buf explicitly
Date: Thu,  6 Jun 2024 14:14:43 +0800
Message-Id: <20240606061446.127802-2-hengqi@linux.alibaba.com>
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

In a later patch, the driver may send requests concurrently, in
which case each command will have its own control buffer, so we
refactor virtnet_send_command_reply() to pass the control buffer
explicitly as a parameter.

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 4a802c0ea2cb..0f872936d6ed 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2680,7 +2680,9 @@ static int virtnet_tx_resize(struct virtnet_info *vi,
  * supported by the hypervisor, as indicated by feature bits, should
  * never fail unless improperly formatted.
  */
-static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 class, u8 cmd,
+static bool virtnet_send_command_reply(struct virtnet_info *vi,
+				       u8 class, u8 cmd,
+				       struct control_buf *ctrl,
 				       struct scatterlist *out,
 				       struct scatterlist *in)
 {
@@ -2692,18 +2694,18 @@ static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 class, u8 cmd
 	BUG_ON(!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VQ));
 
 	mutex_lock(&vi->cvq_lock);
-	vi->ctrl->status = ~0;
-	vi->ctrl->hdr.class = class;
-	vi->ctrl->hdr.cmd = cmd;
+	ctrl->status = ~0;
+	ctrl->hdr.class = class;
+	ctrl->hdr.cmd = cmd;
 	/* Add header */
-	sg_init_one(&hdr, &vi->ctrl->hdr, sizeof(vi->ctrl->hdr));
+	sg_init_one(&hdr, &ctrl->hdr, sizeof(ctrl->hdr));
 	sgs[out_num++] = &hdr;
 
 	if (out)
 		sgs[out_num++] = out;
 
 	/* Add return status. */
-	sg_init_one(&stat, &vi->ctrl->status, sizeof(vi->ctrl->status));
+	sg_init_one(&stat, &ctrl->status, sizeof(ctrl->status));
 	sgs[out_num + in_num++] = &stat;
 
 	if (in)
@@ -2732,13 +2734,13 @@ static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 class, u8 cmd
 
 unlock:
 	mutex_unlock(&vi->cvq_lock);
-	return vi->ctrl->status == VIRTIO_NET_OK;
+	return ctrl->status == VIRTIO_NET_OK;
 }
 
 static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
 				 struct scatterlist *out)
 {
-	return virtnet_send_command_reply(vi, class, cmd, out, NULL);
+	return virtnet_send_command_reply(vi, class, cmd, vi->ctrl, out, NULL);
 }
 
 static int virtnet_set_mac_address(struct net_device *dev, void *p)
@@ -4018,7 +4020,7 @@ static int __virtnet_get_hw_stats(struct virtnet_info *vi,
 
 	ok = virtnet_send_command_reply(vi, VIRTIO_NET_CTRL_STATS,
 					VIRTIO_NET_CTRL_STATS_GET,
-					&sgs_out, &sgs_in);
+					vi->ctrl, &sgs_out, &sgs_in);
 
 	if (!ok)
 		return ok;
@@ -5882,7 +5884,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 		if (!virtnet_send_command_reply(vi, VIRTIO_NET_CTRL_STATS,
 						VIRTIO_NET_CTRL_STATS_QUERY,
-						NULL, &sg)) {
+						vi->ctrl, NULL, &sg)) {
 			pr_debug("virtio_net: fail to get stats capability\n");
 			rtnl_unlock();
 			err = -EINVAL;
-- 
2.32.0.3.g01195cf9f


