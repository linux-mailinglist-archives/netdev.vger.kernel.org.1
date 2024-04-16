Return-Path: <netdev+bounces-88322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 455BF8A6AEE
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 14:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 023D9281E8D
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 12:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF92812BF01;
	Tue, 16 Apr 2024 12:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BW4aJ7LA"
X-Original-To: netdev@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D864A12B15A
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 12:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713270606; cv=none; b=TEZONuQwP4uKvX4h/Hsy+FEoSsCaBNbuonNLm96dbrTpsbSI6/93y5/mh9ocKYl6U1cZ50rdVVLheH4FqsaePhhZvDGe5clWE5S5XilkrK/SZ056w6PRT3K1JtI7oUpE78yb7m/jFFgW9OPYwcoEb4ah+iNRgSJPQ2JfQTYLe90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713270606; c=relaxed/simple;
	bh=Y7aVU+Yvd42Ru644LJeGMg1Z6uAGCvMyrYuVbR2AZ2E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KWKR/6/g6WHAvuoYhfR/i0TYAa4DDOMwj3V0GLh1pONE7Ddy+IC4OWto4dU8oWSztDi9u/+xRf+ifEBvI+EGjk1npT9dYpGdR9w6o5fgtdwB8j1GF0C8oPoq4MrK3frGL2Tdwew+mDXvpAYpTfamnu/FDnCx/E6QLn6YBCH6B5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BW4aJ7LA; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713270596; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=pD4eGjoRhd08IwOJQU2fyyVO7s5eSR6uO/l4PM+ufGE=;
	b=BW4aJ7LAA/HydoLHrt2SjN1Qw98Qekj6kTqn0W7Yb5xVDoED06BJkJKq2qRL5xNc2W228+D1rDfTw5oK01sabZygT0Us4CZXvkqvr9l9rjbFUa26J0+yxFNhe8oY+wcZ4R2qQHnW5Rf8RXqdUnUkjFEFgU3al391RFWLrMRmjhQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W4i.b.q_1713270595;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W4i.b.q_1713270595)
          by smtp.aliyun-inc.com;
          Tue, 16 Apr 2024 20:29:56 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Brett Creeley <bcreeley@amd.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH net-next v8 4/4] virtio-net: support dim profile fine-tuning
Date: Tue, 16 Apr 2024 20:29:50 +0800
Message-Id: <20240416122950.39046-5-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240416122950.39046-1-hengqi@linux.alibaba.com>
References: <20240416122950.39046-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Virtio-net has different types of back-end device implementations.
In order to effectively optimize the dim library's gains for
different device implementations, let's use the new interface
params to fine-tune the profile list.

Since the profile now exists in netdevice, adding a function similar
to net_dim_get_rx_moderation_dev() with netdevice as argument is
nice, but this would be better along with cleaning up the rest of
the drivers, which we can get to very soon after this set.

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 858d7ab89e34..1f7201b82be6 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3584,7 +3584,7 @@ static void virtnet_rx_dim_work(struct work_struct *work)
 		if (!rq->dim_enabled)
 			continue;
 
-		update_moder = net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
+		update_moder = dev->moderation->rx_eqe_profile[dim->profile_ix];
 		if (update_moder.usec != rq->intr_coal.max_usecs ||
 		    update_moder.pkts != rq->intr_coal.max_packets) {
 			err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, qnum,
@@ -3884,7 +3884,8 @@ static int virtnet_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info)
 
 static const struct ethtool_ops virtnet_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_MAX_FRAMES |
-		ETHTOOL_COALESCE_USECS | ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
+		ETHTOOL_COALESCE_USECS | ETHTOOL_COALESCE_USE_ADAPTIVE_RX |
+		ETHTOOL_COALESCE_RX_EQE_PROFILE,
 	.get_drvinfo = virtnet_get_drvinfo,
 	.get_link = ethtool_op_get_link,
 	.get_ringparam = virtnet_get_ringparam,
@@ -4440,6 +4441,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
 
 static void virtnet_dim_init(struct virtnet_info *vi)
 {
+	struct netdev_profile_moder *moder = vi->dev->moderation;
 	int i;
 
 	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
@@ -4449,6 +4451,8 @@ static void virtnet_dim_init(struct virtnet_info *vi)
 		INIT_WORK(&vi->rq[i].dim.work, virtnet_rx_dim_work);
 		vi->rq[i].dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_EQE;
 	}
+
+	moder->flags |= NETDEV_PROFILE_USEC | NETDEV_PROFILE_PKTS;
 }
 
 static int virtnet_alloc_queues(struct virtnet_info *vi)
-- 
2.32.0.3.g01195cf9f


