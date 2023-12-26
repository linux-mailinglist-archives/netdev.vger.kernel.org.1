Return-Path: <netdev+bounces-60239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7932A81E5A6
	for <lists+netdev@lfdr.de>; Tue, 26 Dec 2023 08:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E1861C21CC7
	for <lists+netdev@lfdr.de>; Tue, 26 Dec 2023 07:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659BB4C630;
	Tue, 26 Dec 2023 07:31:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849584C614
	for <netdev@vger.kernel.org>; Tue, 26 Dec 2023 07:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VzH-NX0_1703575866;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VzH-NX0_1703575866)
          by smtp.aliyun-inc.com;
          Tue, 26 Dec 2023 15:31:06 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev,
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH net-next v1 2/6] virtio_net: virtnet_send_command supports command-specific-result
Date: Tue, 26 Dec 2023 15:30:59 +0800
Message-Id: <20231226073103.116153-3-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20231226073103.116153-1-xuanzhuo@linux.alibaba.com>
References: <20231226073103.116153-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: a7c967e04d1e
Content-Transfer-Encoding: 8bit

As the spec https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f95bbbd243291ab0064f82

The virtnet cvq supports to get result from the device.
This commit implement this.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 47 +++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index d16f592c2061..31b9ead6260d 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2451,10 +2451,11 @@ static int virtnet_tx_resize(struct virtnet_info *vi,
  * never fail unless improperly formatted.
  */
 static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
-				 struct scatterlist *out)
+				 struct scatterlist *out,
+				 struct scatterlist *in)
 {
-	struct scatterlist *sgs[4], hdr, stat;
-	unsigned out_num = 0, tmp;
+	struct scatterlist *sgs[5], hdr, stat;
+	u32 out_num = 0, tmp, in_num = 0;
 	int ret;
 
 	/* Caller should know better */
@@ -2472,10 +2473,13 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
 
 	/* Add return status. */
 	sg_init_one(&stat, &vi->ctrl->status, sizeof(vi->ctrl->status));
-	sgs[out_num] = &stat;
+	sgs[out_num + in_num++] = &stat;
 
-	BUG_ON(out_num + 1 > ARRAY_SIZE(sgs));
-	ret = virtqueue_add_sgs(vi->cvq, sgs, out_num, 1, vi, GFP_ATOMIC);
+	if (in)
+		sgs[out_num + in_num++] = in;
+
+	BUG_ON(out_num + in_num > ARRAY_SIZE(sgs));
+	ret = virtqueue_add_sgs(vi->cvq, sgs, out_num, in_num, vi, GFP_ATOMIC);
 	if (ret < 0) {
 		dev_warn(&vi->vdev->dev,
 			 "Failed to add sgs for command vq: %d\n.", ret);
@@ -2517,7 +2521,8 @@ static int virtnet_set_mac_address(struct net_device *dev, void *p)
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_MAC_ADDR)) {
 		sg_init_one(&sg, addr->sa_data, dev->addr_len);
 		if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MAC,
-					  VIRTIO_NET_CTRL_MAC_ADDR_SET, &sg)) {
+					  VIRTIO_NET_CTRL_MAC_ADDR_SET,
+					  &sg, NULL)) {
 			dev_warn(&vdev->dev,
 				 "Failed to set mac address by vq command.\n");
 			ret = -EINVAL;
@@ -2586,7 +2591,7 @@ static void virtnet_ack_link_announce(struct virtnet_info *vi)
 {
 	rtnl_lock();
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_ANNOUNCE,
-				  VIRTIO_NET_CTRL_ANNOUNCE_ACK, NULL))
+				  VIRTIO_NET_CTRL_ANNOUNCE_ACK, NULL, NULL))
 		dev_warn(&vi->dev->dev, "Failed to ack link announce.\n");
 	rtnl_unlock();
 }
@@ -2603,7 +2608,7 @@ static int _virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
 	sg_init_one(&sg, &vi->ctrl->mq, sizeof(vi->ctrl->mq));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MQ,
-				  VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET, &sg)) {
+				  VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET, &sg, NULL)) {
 		dev_warn(&dev->dev, "Fail to set num of queue pairs to %d\n",
 			 queue_pairs);
 		return -EINVAL;
@@ -2664,14 +2669,14 @@ static void virtnet_set_rx_mode(struct net_device *dev)
 	sg_init_one(sg, &vi->ctrl->promisc, sizeof(vi->ctrl->promisc));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_RX,
-				  VIRTIO_NET_CTRL_RX_PROMISC, sg))
+				  VIRTIO_NET_CTRL_RX_PROMISC, sg, NULL))
 		dev_warn(&dev->dev, "Failed to %sable promisc mode.\n",
 			 vi->ctrl->promisc ? "en" : "dis");
 
 	sg_init_one(sg, &vi->ctrl->allmulti, sizeof(vi->ctrl->allmulti));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_RX,
-				  VIRTIO_NET_CTRL_RX_ALLMULTI, sg))
+				  VIRTIO_NET_CTRL_RX_ALLMULTI, sg, NULL))
 		dev_warn(&dev->dev, "Failed to %sable allmulti mode.\n",
 			 vi->ctrl->allmulti ? "en" : "dis");
 
@@ -2707,7 +2712,7 @@ static void virtnet_set_rx_mode(struct net_device *dev)
 		   sizeof(mac_data->entries) + (mc_count * ETH_ALEN));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MAC,
-				  VIRTIO_NET_CTRL_MAC_TABLE_SET, sg))
+				  VIRTIO_NET_CTRL_MAC_TABLE_SET, sg, NULL))
 		dev_warn(&dev->dev, "Failed to set MAC filter table.\n");
 
 	kfree(buf);
@@ -2723,7 +2728,7 @@ static int virtnet_vlan_rx_add_vid(struct net_device *dev,
 	sg_init_one(&sg, &vi->ctrl->vid, sizeof(vi->ctrl->vid));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_VLAN,
-				  VIRTIO_NET_CTRL_VLAN_ADD, &sg))
+				  VIRTIO_NET_CTRL_VLAN_ADD, &sg, NULL))
 		dev_warn(&dev->dev, "Failed to add VLAN ID %d.\n", vid);
 	return 0;
 }
@@ -2738,7 +2743,7 @@ static int virtnet_vlan_rx_kill_vid(struct net_device *dev,
 	sg_init_one(&sg, &vi->ctrl->vid, sizeof(vi->ctrl->vid));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_VLAN,
-				  VIRTIO_NET_CTRL_VLAN_DEL, &sg))
+				  VIRTIO_NET_CTRL_VLAN_DEL, &sg, NULL))
 		dev_warn(&dev->dev, "Failed to kill VLAN ID %d.\n", vid);
 	return 0;
 }
@@ -2956,7 +2961,7 @@ static bool virtnet_commit_rss_command(struct virtnet_info *vi)
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MQ,
 				  vi->has_rss ? VIRTIO_NET_CTRL_MQ_RSS_CONFIG
-				  : VIRTIO_NET_CTRL_MQ_HASH_CONFIG, sgs)) {
+				  : VIRTIO_NET_CTRL_MQ_HASH_CONFIG, sgs, NULL)) {
 		dev_warn(&dev->dev, "VIRTIONET issue with committing RSS sgs\n");
 		return false;
 	}
@@ -3274,7 +3279,7 @@ static int virtnet_send_notf_coal_cmds(struct virtnet_info *vi,
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
 				  VIRTIO_NET_CTRL_NOTF_COAL_TX_SET,
-				  &sgs_tx))
+				  &sgs_tx, NULL))
 		return -EINVAL;
 
 	/* Save parameters */
@@ -3291,7 +3296,7 @@ static int virtnet_send_notf_coal_cmds(struct virtnet_info *vi,
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
 				  VIRTIO_NET_CTRL_NOTF_COAL_RX_SET,
-				  &sgs_rx))
+				  &sgs_rx, NULL))
 		return -EINVAL;
 
 	/* Save parameters */
@@ -3317,7 +3322,7 @@ static int virtnet_send_ctrl_coal_vq_cmd(struct virtnet_info *vi,
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
 				  VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET,
-				  &sgs))
+				  &sgs, NULL))
 		return -EINVAL;
 
 	return 0;
@@ -3687,7 +3692,8 @@ static int virtnet_set_guest_offloads(struct virtnet_info *vi, u64 offloads)
 	sg_init_one(&sg, &vi->ctrl->offloads, sizeof(vi->ctrl->offloads));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_GUEST_OFFLOADS,
-				  VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET, &sg)) {
+				  VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET,
+				  &sg, NULL)) {
 		dev_warn(&vi->dev->dev, "Fail to set guest offload.\n");
 		return -EINVAL;
 	}
@@ -4619,7 +4625,8 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 		sg_init_one(&sg, dev->dev_addr, dev->addr_len);
 		if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MAC,
-					  VIRTIO_NET_CTRL_MAC_ADDR_SET, &sg)) {
+					  VIRTIO_NET_CTRL_MAC_ADDR_SET,
+					  &sg, NULL)) {
 			pr_debug("virtio_net: setting MAC address failed\n");
 			rtnl_unlock();
 			err = -EINVAL;
-- 
2.32.0.3.g01195cf9f


