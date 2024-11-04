Return-Path: <netdev+bounces-141442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9379BAEDA
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 09:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09142B231E7
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 08:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258CF1B2195;
	Mon,  4 Nov 2024 08:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="poZJLFpZ"
X-Original-To: netdev@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875861B0F12;
	Mon,  4 Nov 2024 08:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730710638; cv=none; b=BxkJLFPnSJxvSTloICk1p4xWl1BjDWDQ34ZQSCpEFkienahEeFGllQwkavDlFV6ooL3PeehqPyU3PFKrNRtTenQn4rIAMrkNen4/1aqfaTqDQeKfRGcE6VASEnCdImESvlsIbf5NQkpnF7l47kLC2ON5WY5LVXh2BtOeIPr6/vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730710638; c=relaxed/simple;
	bh=0FLFfBSAK6sU4ebwfJfJ/l+kivNg1Idp2rGw8Bmwh0U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q8KWbLhtcOj5mWpvEWN6qNGsVHa+lIBSFT2uh62lMwkEuwAnTE+YlrcZPSyR609J5A3AdyVtceSqQ0H90BZQbFUu36gvmO0NPQ1DUTx7qf+kNsCsRy8V1Y+uqDu9/TgIQ47CYLVrEgFMoMW5xIGPnBemJ2/59oTg9HZDUCn1eGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=poZJLFpZ; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730710633; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=aDKj9+4ZrQzwmLfshFCpLQjvnEMoj1w8tVLqhzceXe8=;
	b=poZJLFpZjTp6uNdcL54nJ9iQZt6bWJr+ymyCLJ1IqGcxA8HbARMQUf5StoQN3to2I8YkPNUlU1coqvzB2+e0G41i33D5/Jp0ukaJbElEDrjWRB3sPc/GhLkCKKOKjEbLjKp8ZHM/XNRYICh6CkL+oUa6gqNnQAONEZwhJtmV/v8=
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WIdkVoT_1730710630 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 04 Nov 2024 16:57:11 +0800
From: Philo Lu <lulie@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@daynix.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 4/4] virtio_net: Update rss when set queue
Date: Mon,  4 Nov 2024 16:57:06 +0800
Message-Id: <20241104085706.13872-5-lulie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20241104085706.13872-1-lulie@linux.alibaba.com>
References: <20241104085706.13872-1-lulie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RSS configuration should be updated with queue number. In particular, it
should be updated when (1) rss enabled and (2) default rss configuration
is used without user modification.

During rss command processing, device updates queue_pairs using
rss.max_tx_vq. That is, the device updates queue_pairs together with
rss, so we can skip the sperate queue_pairs update
(VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET below) and return directly.

Also remove the `vi->has_rss ?` check when setting vi->rss.max_tx_vq,
because this is not used in the other hash_report case.

Fixes: c7114b1249fa ("drivers/net/virtio_net: Added basic RSS support.")
Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 65 +++++++++++++++++++++++++++++++---------
 1 file changed, 51 insertions(+), 14 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 59d9fdf562e0..189afad3ffaa 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3394,15 +3394,59 @@ static void virtnet_ack_link_announce(struct virtnet_info *vi)
 		dev_warn(&vi->dev->dev, "Failed to ack link announce.\n");
 }
 
+static bool virtnet_commit_rss_command(struct virtnet_info *vi);
+
+static void virtnet_rss_update_by_qpairs(struct virtnet_info *vi, u16 queue_pairs)
+{
+	u32 indir_val = 0;
+	int i = 0;
+
+	for (; i < vi->rss_indir_table_size; ++i) {
+		indir_val = ethtool_rxfh_indir_default(i, queue_pairs);
+		vi->rss.indirection_table[i] = indir_val;
+	}
+	vi->rss.max_tx_vq = queue_pairs;
+}
+
 static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
 {
 	struct virtio_net_ctrl_mq *mq __free(kfree) = NULL;
-	struct scatterlist sg;
+	struct virtio_net_ctrl_rss old_rss;
 	struct net_device *dev = vi->dev;
+	struct scatterlist sg;
 
 	if (!vi->has_cvq || !virtio_has_feature(vi->vdev, VIRTIO_NET_F_MQ))
 		return 0;
 
+	/* Firstly check if we need update rss. Do updating if both (1) rss enabled and
+	 * (2) no user configuration.
+	 *
+	 * During rss command processing, device updates queue_pairs using rss.max_tx_vq. That is,
+	 * the device updates queue_pairs together with rss, so we can skip the sperate queue_pairs
+	 * update (VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET below) and return directly.
+	 */
+	if (vi->has_rss && !netif_is_rxfh_configured(dev)) {
+		memcpy(&old_rss, &vi->rss, sizeof(old_rss));
+		if (rss_indirection_table_alloc(&vi->rss, vi->rss_indir_table_size)) {
+			vi->rss.indirection_table = old_rss.indirection_table;
+			return -ENOMEM;
+		}
+
+		virtnet_rss_update_by_qpairs(vi, queue_pairs);
+
+		if (!virtnet_commit_rss_command(vi)) {
+			/* restore ctrl_rss if commit_rss_command failed */
+			rss_indirection_table_free(&vi->rss);
+			memcpy(&vi->rss, &old_rss, sizeof(old_rss));
+
+			dev_warn(&dev->dev, "Fail to set num of queue pairs to %d, because committing RSS failed\n",
+				 queue_pairs);
+			return -EINVAL;
+		}
+		rss_indirection_table_free(&old_rss);
+		goto succ;
+	}
+
 	mq = kzalloc(sizeof(*mq), GFP_KERNEL);
 	if (!mq)
 		return -ENOMEM;
@@ -3415,12 +3459,12 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
 		dev_warn(&dev->dev, "Fail to set num of queue pairs to %d\n",
 			 queue_pairs);
 		return -EINVAL;
-	} else {
-		vi->curr_queue_pairs = queue_pairs;
-		/* virtnet_open() will refill when device is going to up. */
-		if (dev->flags & IFF_UP)
-			schedule_delayed_work(&vi->refill, 0);
 	}
+succ:
+	vi->curr_queue_pairs = queue_pairs;
+	/* virtnet_open() will refill when device is going to up. */
+	if (dev->flags & IFF_UP)
+		schedule_delayed_work(&vi->refill, 0);
 
 	return 0;
 }
@@ -3880,21 +3924,14 @@ static bool virtnet_commit_rss_command(struct virtnet_info *vi)
 
 static void virtnet_init_default_rss(struct virtnet_info *vi)
 {
-	u32 indir_val = 0;
-	int i = 0;
-
 	vi->rss.hash_types = vi->rss_hash_types_supported;
 	vi->rss_hash_types_saved = vi->rss_hash_types_supported;
 	vi->rss.indirection_table_mask = vi->rss_indir_table_size
 						? vi->rss_indir_table_size - 1 : 0;
 	vi->rss.unclassified_queue = 0;
 
-	for (; i < vi->rss_indir_table_size; ++i) {
-		indir_val = ethtool_rxfh_indir_default(i, vi->curr_queue_pairs);
-		vi->rss.indirection_table[i] = indir_val;
-	}
+	virtnet_rss_update_by_qpairs(vi, vi->curr_queue_pairs);
 
-	vi->rss.max_tx_vq = vi->has_rss ? vi->curr_queue_pairs : 0;
 	vi->rss.hash_key_length = vi->rss_key_size;
 
 	netdev_rss_key_fill(vi->rss.key, vi->rss_key_size);
-- 
2.32.0.3.g01195cf9f


