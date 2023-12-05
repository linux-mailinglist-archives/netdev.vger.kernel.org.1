Return-Path: <netdev+bounces-53817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1117804BA8
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 09:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D6A71F214EF
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 08:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E544235F12;
	Tue,  5 Dec 2023 08:02:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5BEC6
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 00:02:27 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VxtpBdv_1701763344;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0VxtpBdv_1701763344)
          by smtp.aliyun-inc.com;
          Tue, 05 Dec 2023 16:02:25 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Cc: jasowang@redhat.com,
	mst@redhat.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	yinjun.zhang@corigine.com,
	edumazet@google.com,
	davem@davemloft.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	ast@kernel.org,
	horms@kernel.org,
	xuanzhuo@linux.alibaba.com
Subject: [PATCH net-next v6 4/5] virtio-net: add spin lock for ctrl cmd access
Date: Tue,  5 Dec 2023 16:02:18 +0800
Message-Id: <245ea32fe5de5eb81b1ed8ec9782023af074e137.1701762688.git.hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <cover.1701762688.git.hengqi@linux.alibaba.com>
References: <cover.1701762688.git.hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently access to ctrl cmd is globally protected via rtnl_lock and works
fine. But if dim work's access to ctrl cmd also holds rtnl_lock, deadlock
may occur due to cancel_work_sync for dim work. Therefore, treating
ctrl cmd as a separate protection object of the lock is the solution and
the basis for the next patch.

Since ndo_set_rx_mode is in an atomic environment(netif_addr_lock_bh),
the mutex lock is excluded.

And I tried putting the spin lock in virtnet_send_command, but
virtnet_rx_dim_work and virtnet_set_per_queue_coalesce access to
shared variables prevent this.

cancel_work_sync and virtnet_rx_dim_work are from the next patch.

Please review. Thanks a lot!

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 70 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 64 insertions(+), 6 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 69fe09e99b3c..0dd09c4f8d89 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -301,6 +301,9 @@ struct virtnet_info {
 
 	struct control_buf *ctrl;
 
+	/* The lock to synchronize the access to contrl cmd */
+	spinlock_t ctrl_lock;
+
 	/* Ethtool settings */
 	u8 duplex;
 	u32 speed;
@@ -2520,13 +2523,16 @@ static int virtnet_set_mac_address(struct net_device *dev, void *p)
 
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_MAC_ADDR)) {
 		sg_init_one(&sg, addr->sa_data, dev->addr_len);
+		spin_lock(&vi->ctrl_lock);
 		if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MAC,
 					  VIRTIO_NET_CTRL_MAC_ADDR_SET, &sg)) {
 			dev_warn(&vdev->dev,
 				 "Failed to set mac address by vq command.\n");
 			ret = -EINVAL;
+			spin_unlock(&vi->ctrl_lock);
 			goto out;
 		}
+		spin_unlock(&vi->ctrl_lock);
 	} else if (virtio_has_feature(vdev, VIRTIO_NET_F_MAC) &&
 		   !virtio_has_feature(vdev, VIRTIO_F_VERSION_1)) {
 		unsigned int i;
@@ -2589,9 +2595,11 @@ static void virtnet_stats(struct net_device *dev,
 static void virtnet_ack_link_announce(struct virtnet_info *vi)
 {
 	rtnl_lock();
+	spin_lock(&vi->ctrl_lock);
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_ANNOUNCE,
 				  VIRTIO_NET_CTRL_ANNOUNCE_ACK, NULL))
 		dev_warn(&vi->dev->dev, "Failed to ack link announce.\n");
+	spin_unlock(&vi->ctrl_lock);
 	rtnl_unlock();
 }
 
@@ -2603,6 +2611,7 @@ static int _virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
 	if (!vi->has_cvq || !virtio_has_feature(vi->vdev, VIRTIO_NET_F_MQ))
 		return 0;
 
+	spin_lock(&vi->ctrl_lock);
 	vi->ctrl->mq.virtqueue_pairs = cpu_to_virtio16(vi->vdev, queue_pairs);
 	sg_init_one(&sg, &vi->ctrl->mq, sizeof(vi->ctrl->mq));
 
@@ -2610,6 +2619,7 @@ static int _virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
 				  VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET, &sg)) {
 		dev_warn(&dev->dev, "Fail to set num of queue pairs to %d\n",
 			 queue_pairs);
+		spin_unlock(&vi->ctrl_lock);
 		return -EINVAL;
 	} else {
 		vi->curr_queue_pairs = queue_pairs;
@@ -2618,6 +2628,7 @@ static int _virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
 			schedule_delayed_work(&vi->refill, 0);
 	}
 
+	spin_unlock(&vi->ctrl_lock);
 	return 0;
 }
 
@@ -2662,6 +2673,7 @@ static void virtnet_set_rx_mode(struct net_device *dev)
 	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_RX))
 		return;
 
+	spin_lock(&vi->ctrl_lock);
 	vi->ctrl->promisc = ((dev->flags & IFF_PROMISC) != 0);
 	vi->ctrl->allmulti = ((dev->flags & IFF_ALLMULTI) != 0);
 
@@ -2679,6 +2691,7 @@ static void virtnet_set_rx_mode(struct net_device *dev)
 		dev_warn(&dev->dev, "Failed to %sable allmulti mode.\n",
 			 vi->ctrl->allmulti ? "en" : "dis");
 
+	spin_unlock(&vi->ctrl_lock);
 	uc_count = netdev_uc_count(dev);
 	mc_count = netdev_mc_count(dev);
 	/* MAC filter - use one buffer for both lists */
@@ -2710,10 +2723,12 @@ static void virtnet_set_rx_mode(struct net_device *dev)
 	sg_set_buf(&sg[1], mac_data,
 		   sizeof(mac_data->entries) + (mc_count * ETH_ALEN));
 
+	spin_lock(&vi->ctrl_lock);
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MAC,
 				  VIRTIO_NET_CTRL_MAC_TABLE_SET, sg))
 		dev_warn(&dev->dev, "Failed to set MAC filter table.\n");
 
+	spin_unlock(&vi->ctrl_lock);
 	kfree(buf);
 }
 
@@ -2723,12 +2738,15 @@ static int virtnet_vlan_rx_add_vid(struct net_device *dev,
 	struct virtnet_info *vi = netdev_priv(dev);
 	struct scatterlist sg;
 
+	spin_lock(&vi->ctrl_lock);
 	vi->ctrl->vid = cpu_to_virtio16(vi->vdev, vid);
 	sg_init_one(&sg, &vi->ctrl->vid, sizeof(vi->ctrl->vid));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_VLAN,
 				  VIRTIO_NET_CTRL_VLAN_ADD, &sg))
 		dev_warn(&dev->dev, "Failed to add VLAN ID %d.\n", vid);
+	spin_unlock(&vi->ctrl_lock);
+
 	return 0;
 }
 
@@ -2738,12 +2756,15 @@ static int virtnet_vlan_rx_kill_vid(struct net_device *dev,
 	struct virtnet_info *vi = netdev_priv(dev);
 	struct scatterlist sg;
 
+	spin_lock(&vi->ctrl_lock);
 	vi->ctrl->vid = cpu_to_virtio16(vi->vdev, vid);
 	sg_init_one(&sg, &vi->ctrl->vid, sizeof(vi->ctrl->vid));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_VLAN,
 				  VIRTIO_NET_CTRL_VLAN_DEL, &sg))
 		dev_warn(&dev->dev, "Failed to kill VLAN ID %d.\n", vid);
+	spin_unlock(&vi->ctrl_lock);
+
 	return 0;
 }
 
@@ -2958,11 +2979,15 @@ static int virtnet_set_ringparam(struct net_device *dev,
 			 * through the VIRTIO_NET_CTRL_NOTF_COAL_TX_SET command, or, if the driver
 			 * did not set any TX coalescing parameters, to 0.
 			 */
+			spin_lock(&vi->ctrl_lock);
 			err = virtnet_send_tx_ctrl_coal_vq_cmd(vi, i,
 							       vi->intr_coal_tx.max_usecs,
 							       vi->intr_coal_tx.max_packets);
-			if (err)
+			if (err) {
+				spin_unlock(&vi->ctrl_lock);
 				return err;
+			}
+			spin_unlock(&vi->ctrl_lock);
 		}
 
 		if (ring->rx_pending != rx_pending) {
@@ -2971,11 +2996,15 @@ static int virtnet_set_ringparam(struct net_device *dev,
 				return err;
 
 			/* The reason is same as the transmit virtqueue reset */
+			spin_lock(&vi->ctrl_lock);
 			err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, i,
 							       vi->intr_coal_rx.max_usecs,
 							       vi->intr_coal_rx.max_packets);
-			if (err)
+			if (err) {
+				spin_unlock(&vi->ctrl_lock);
 				return err;
+			}
+			spin_unlock(&vi->ctrl_lock);
 		}
 	}
 
@@ -2991,6 +3020,7 @@ static bool virtnet_commit_rss_command(struct virtnet_info *vi)
 	/* prepare sgs */
 	sg_init_table(sgs, 4);
 
+	spin_lock(&vi->ctrl_lock);
 	sg_buf_size = offsetof(struct virtio_net_ctrl_rss, indirection_table);
 	sg_set_buf(&sgs[0], &vi->ctrl->rss, sg_buf_size);
 
@@ -3008,8 +3038,12 @@ static bool virtnet_commit_rss_command(struct virtnet_info *vi)
 				  vi->has_rss ? VIRTIO_NET_CTRL_MQ_RSS_CONFIG
 				  : VIRTIO_NET_CTRL_MQ_HASH_CONFIG, sgs)) {
 		dev_warn(&dev->dev, "VIRTIONET issue with committing RSS sgs\n");
+		spin_unlock(&vi->ctrl_lock);
 		return false;
 	}
+
+	spin_unlock(&vi->ctrl_lock);
+
 	return true;
 }
 
@@ -3318,14 +3352,17 @@ static int virtnet_send_tx_notf_coal_cmds(struct virtnet_info *vi,
 	struct scatterlist sgs_tx;
 	int i;
 
+	spin_lock(&vi->ctrl_lock);
 	vi->ctrl->coal_tx.tx_usecs = cpu_to_le32(ec->tx_coalesce_usecs);
 	vi->ctrl->coal_tx.tx_max_packets = cpu_to_le32(ec->tx_max_coalesced_frames);
 	sg_init_one(&sgs_tx, &vi->ctrl->coal_tx, sizeof(vi->ctrl->coal_tx));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
 				  VIRTIO_NET_CTRL_NOTF_COAL_TX_SET,
-				  &sgs_tx))
+				  &sgs_tx)) {
+		spin_unlock(&vi->ctrl_lock);
 		return -EINVAL;
+	}
 
 	/* Save parameters */
 	vi->intr_coal_tx.max_usecs = ec->tx_coalesce_usecs;
@@ -3334,6 +3371,7 @@ static int virtnet_send_tx_notf_coal_cmds(struct virtnet_info *vi,
 		vi->sq[i].intr_coal.max_usecs = ec->tx_coalesce_usecs;
 		vi->sq[i].intr_coal.max_packets = ec->tx_max_coalesced_frames;
 	}
+	spin_unlock(&vi->ctrl_lock);
 
 	return 0;
 }
@@ -3344,14 +3382,17 @@ static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
 	struct scatterlist sgs_rx;
 	int i;
 
+	spin_lock(&vi->ctrl_lock);
 	vi->ctrl->coal_rx.rx_usecs = cpu_to_le32(ec->rx_coalesce_usecs);
 	vi->ctrl->coal_rx.rx_max_packets = cpu_to_le32(ec->rx_max_coalesced_frames);
 	sg_init_one(&sgs_rx, &vi->ctrl->coal_rx, sizeof(vi->ctrl->coal_rx));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
 				  VIRTIO_NET_CTRL_NOTF_COAL_RX_SET,
-				  &sgs_rx))
+				  &sgs_rx)) {
+		spin_unlock(&vi->ctrl_lock);
 		return -EINVAL;
+	}
 
 	/* Save parameters */
 	vi->intr_coal_rx.max_usecs = ec->rx_coalesce_usecs;
@@ -3361,6 +3402,8 @@ static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
 		vi->rq[i].intr_coal.max_packets = ec->rx_max_coalesced_frames;
 	}
 
+	spin_unlock(&vi->ctrl_lock);
+
 	return 0;
 }
 
@@ -3386,17 +3429,24 @@ static int virtnet_send_notf_coal_vq_cmds(struct virtnet_info *vi,
 {
 	int err;
 
+	spin_lock(&vi->ctrl_lock);
 	err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, queue,
 					       ec->rx_coalesce_usecs,
 					       ec->rx_max_coalesced_frames);
-	if (err)
+	if (err) {
+		spin_unlock(&vi->ctrl_lock);
 		return err;
+	}
 
 	err = virtnet_send_tx_ctrl_coal_vq_cmd(vi, queue,
 					       ec->tx_coalesce_usecs,
 					       ec->tx_max_coalesced_frames);
-	if (err)
+	if (err) {
+		spin_unlock(&vi->ctrl_lock);
 		return err;
+	}
+
+	spin_unlock(&vi->ctrl_lock);
 
 	return 0;
 }
@@ -3733,6 +3783,8 @@ static int virtnet_restore_up(struct virtio_device *vdev)
 static int virtnet_set_guest_offloads(struct virtnet_info *vi, u64 offloads)
 {
 	struct scatterlist sg;
+
+	spin_lock(&vi->ctrl_lock);
 	vi->ctrl->offloads = cpu_to_virtio64(vi->vdev, offloads);
 
 	sg_init_one(&sg, &vi->ctrl->offloads, sizeof(vi->ctrl->offloads));
@@ -3740,9 +3792,11 @@ static int virtnet_set_guest_offloads(struct virtnet_info *vi, u64 offloads)
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_GUEST_OFFLOADS,
 				  VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET, &sg)) {
 		dev_warn(&vi->dev->dev, "Fail to set guest offload.\n");
+		spin_unlock(&vi->ctrl_lock);
 		return -EINVAL;
 	}
 
+	spin_unlock(&vi->ctrl_lock);
 	return 0;
 }
 
@@ -4525,6 +4579,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 	INIT_WORK(&vi->config_work, virtnet_config_changed_work);
 	spin_lock_init(&vi->refill_lock);
+	spin_lock_init(&vi->ctrl_lock);
 
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF)) {
 		vi->mergeable_rx_bufs = true;
@@ -4669,13 +4724,16 @@ static int virtnet_probe(struct virtio_device *vdev)
 		struct scatterlist sg;
 
 		sg_init_one(&sg, dev->dev_addr, dev->addr_len);
+		spin_lock(&vi->ctrl_lock);
 		if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MAC,
 					  VIRTIO_NET_CTRL_MAC_ADDR_SET, &sg)) {
 			pr_debug("virtio_net: setting MAC address failed\n");
+			spin_unlock(&vi->ctrl_lock);
 			rtnl_unlock();
 			err = -EINVAL;
 			goto free_unregister_netdev;
 		}
+		spin_unlock(&vi->ctrl_lock);
 	}
 
 	rtnl_unlock();
-- 
2.19.1.6.gb485710b


