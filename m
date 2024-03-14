Return-Path: <netdev+bounces-79814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E686087B9CC
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 09:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E174283643
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 08:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E2D6CDAA;
	Thu, 14 Mar 2024 08:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nAFDmImq"
X-Original-To: netdev@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D678C6BFB4;
	Thu, 14 Mar 2024 08:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710406514; cv=none; b=nWq06/rHd+XFVdMkIQ07tKtbkK+J8AVlBWXQwColNABzd2j/P/8tjaLnJ/HEbOkmvqzjNCYoaLwmdzk8B218NhP/iEBUid5nrYHcnPWY+Gt1ms3T0cSgvMVmsKtr+mvXST6PrdyakOfsj9hjh0OdVG8AhubAPsid2rT882Sz2Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710406514; c=relaxed/simple;
	bh=9m/O+3r1B2RnBaFOwDCAEwFrJ7W4beElY/eO1nXl/ew=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YUCWfTu2LBC2aswqrrxPeDMRzq+onyKLGkoEE+CuSmQWzFrTXcyBnThx3l4RWQdJWwRMqueWaCbU4Wtp0/ASMVrlZ6lBdmB0JDkyy37xIpIGu6oJYUgVKpsLKmjFSdI+V1rRgyGFNVUvu5yPJp7OC5t2PgdOUTug1EnaqyCPrGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nAFDmImq; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710406503; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=QQpe5ERGNhNNhcEiYcakS/tgM/4IOFii+kpwWQliOgs=;
	b=nAFDmImqubCuPdJsDrwk03P/jt72PJruq3lH83VVBzEH3lr9M1FjupdDxqgBhk4fyQAjxWllY0BHL8EZNcl9O9v1EpiTQ2EhoSZpUzh19oeMFHTMYY90cackWxYUFiSTa9Tag4JI0WAhzunSmb1G3HmR4616tDmM4shJoaPDJKE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R871e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W2S2VHH_1710406502;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W2S2VHH_1710406502)
          by smtp.aliyun-inc.com;
          Thu, 14 Mar 2024 16:55:03 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@google.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	virtualization@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH net-next v4 2/8] virtio_net: virtnet_send_command supports command-specific-result
Date: Thu, 14 Mar 2024 16:54:53 +0800
Message-Id: <20240314085459.115933-3-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240314085459.115933-1-xuanzhuo@linux.alibaba.com>
References: <20240314085459.115933-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 76259b0090f3
Content-Transfer-Encoding: 8bit

As the spec https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f95bbbd243291ab0064f82

The virtnet cvq supports to get result from the device.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 47 +++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index d7ce4a1011ea..af512d85cd5b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2512,10 +2512,11 @@ static int virtnet_tx_resize(struct virtnet_info *vi,
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
@@ -2533,10 +2534,13 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
 
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
@@ -2578,7 +2582,8 @@ static int virtnet_set_mac_address(struct net_device *dev, void *p)
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_MAC_ADDR)) {
 		sg_init_one(&sg, addr->sa_data, dev->addr_len);
 		if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MAC,
-					  VIRTIO_NET_CTRL_MAC_ADDR_SET, &sg)) {
+					  VIRTIO_NET_CTRL_MAC_ADDR_SET,
+					  &sg, NULL)) {
 			dev_warn(&vdev->dev,
 				 "Failed to set mac address by vq command.\n");
 			ret = -EINVAL;
@@ -2647,7 +2652,7 @@ static void virtnet_ack_link_announce(struct virtnet_info *vi)
 {
 	rtnl_lock();
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_ANNOUNCE,
-				  VIRTIO_NET_CTRL_ANNOUNCE_ACK, NULL))
+				  VIRTIO_NET_CTRL_ANNOUNCE_ACK, NULL, NULL))
 		dev_warn(&vi->dev->dev, "Failed to ack link announce.\n");
 	rtnl_unlock();
 }
@@ -2664,7 +2669,7 @@ static int _virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
 	sg_init_one(&sg, &vi->ctrl->mq, sizeof(vi->ctrl->mq));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MQ,
-				  VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET, &sg)) {
+				  VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET, &sg, NULL)) {
 		dev_warn(&dev->dev, "Fail to set num of queue pairs to %d\n",
 			 queue_pairs);
 		return -EINVAL;
@@ -2727,14 +2732,14 @@ static void virtnet_set_rx_mode(struct net_device *dev)
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
 
@@ -2770,7 +2775,7 @@ static void virtnet_set_rx_mode(struct net_device *dev)
 		   sizeof(mac_data->entries) + (mc_count * ETH_ALEN));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MAC,
-				  VIRTIO_NET_CTRL_MAC_TABLE_SET, sg))
+				  VIRTIO_NET_CTRL_MAC_TABLE_SET, sg, NULL))
 		dev_warn(&dev->dev, "Failed to set MAC filter table.\n");
 
 	kfree(buf);
@@ -2786,7 +2791,7 @@ static int virtnet_vlan_rx_add_vid(struct net_device *dev,
 	sg_init_one(&sg, &vi->ctrl->vid, sizeof(vi->ctrl->vid));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_VLAN,
-				  VIRTIO_NET_CTRL_VLAN_ADD, &sg))
+				  VIRTIO_NET_CTRL_VLAN_ADD, &sg, NULL))
 		dev_warn(&dev->dev, "Failed to add VLAN ID %d.\n", vid);
 	return 0;
 }
@@ -2801,7 +2806,7 @@ static int virtnet_vlan_rx_kill_vid(struct net_device *dev,
 	sg_init_one(&sg, &vi->ctrl->vid, sizeof(vi->ctrl->vid));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_VLAN,
-				  VIRTIO_NET_CTRL_VLAN_DEL, &sg))
+				  VIRTIO_NET_CTRL_VLAN_DEL, &sg, NULL))
 		dev_warn(&dev->dev, "Failed to kill VLAN ID %d.\n", vid);
 	return 0;
 }
@@ -2920,7 +2925,7 @@ static int virtnet_send_ctrl_coal_vq_cmd(struct virtnet_info *vi,
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
 				  VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET,
-				  &sgs))
+				  &sgs, NULL))
 		return -EINVAL;
 
 	return 0;
@@ -3062,7 +3067,7 @@ static bool virtnet_commit_rss_command(struct virtnet_info *vi)
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MQ,
 				  vi->has_rss ? VIRTIO_NET_CTRL_MQ_RSS_CONFIG
-				  : VIRTIO_NET_CTRL_MQ_HASH_CONFIG, sgs)) {
+				  : VIRTIO_NET_CTRL_MQ_HASH_CONFIG, sgs, NULL)) {
 		dev_warn(&dev->dev, "VIRTIONET issue with committing RSS sgs\n");
 		return false;
 	}
@@ -3380,7 +3385,7 @@ static int virtnet_send_tx_notf_coal_cmds(struct virtnet_info *vi,
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
 				  VIRTIO_NET_CTRL_NOTF_COAL_TX_SET,
-				  &sgs_tx))
+				  &sgs_tx, NULL))
 		return -EINVAL;
 
 	vi->intr_coal_tx.max_usecs = ec->tx_coalesce_usecs;
@@ -3430,7 +3435,7 @@ static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
 				  VIRTIO_NET_CTRL_NOTF_COAL_RX_SET,
-				  &sgs_rx))
+				  &sgs_rx, NULL))
 		return -EINVAL;
 
 	vi->intr_coal_rx.max_usecs = ec->rx_coalesce_usecs;
@@ -3899,7 +3904,8 @@ static int virtnet_set_guest_offloads(struct virtnet_info *vi, u64 offloads)
 	sg_init_one(&sg, &vi->ctrl->offloads, sizeof(vi->ctrl->offloads));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_GUEST_OFFLOADS,
-				  VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET, &sg)) {
+				  VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET,
+				  &sg, NULL)) {
 		dev_warn(&vi->dev->dev, "Fail to set guest offload.\n");
 		return -EINVAL;
 	}
@@ -4822,7 +4828,8 @@ static int virtnet_probe(struct virtio_device *vdev)
 
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


