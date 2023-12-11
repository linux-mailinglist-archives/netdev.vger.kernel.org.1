Return-Path: <netdev+bounces-55838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8999780C6BC
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 11:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44CB02816C9
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 10:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C10C25556;
	Mon, 11 Dec 2023 10:36:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9C0D5
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 02:36:13 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VyFoSTY_1702290970;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0VyFoSTY_1702290970)
          by smtp.aliyun-inc.com;
          Mon, 11 Dec 2023 18:36:11 +0800
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
Subject: [PATCH net-next v8 2/4] virtio-net: separate rx/tx coalescing moderation cmds
Date: Mon, 11 Dec 2023 18:36:05 +0800
Message-Id: <b84dfd2aacb4250874e0b4f5002e08ecb644a629.1702275514.git.hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <cover.1702275514.git.hengqi@linux.alibaba.com>
References: <cover.1702275514.git.hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch separates the rx and tx global coalescing moderation
commands to support netdim switches in subsequent patches.

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 0ad2894e6a5e..0285301caf78 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3266,10 +3266,10 @@ static int virtnet_get_link_ksettings(struct net_device *dev,
 	return 0;
 }
 
-static int virtnet_send_notf_coal_cmds(struct virtnet_info *vi,
-				       struct ethtool_coalesce *ec)
+static int virtnet_send_tx_notf_coal_cmds(struct virtnet_info *vi,
+					  struct ethtool_coalesce *ec)
 {
-	struct scatterlist sgs_tx, sgs_rx;
+	struct scatterlist sgs_tx;
 	int i;
 
 	vi->ctrl->coal_tx.tx_usecs = cpu_to_le32(ec->tx_coalesce_usecs);
@@ -3289,6 +3289,15 @@ static int virtnet_send_notf_coal_cmds(struct virtnet_info *vi,
 		vi->sq[i].intr_coal.max_packets = ec->tx_max_coalesced_frames;
 	}
 
+	return 0;
+}
+
+static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
+					  struct ethtool_coalesce *ec)
+{
+	struct scatterlist sgs_rx;
+	int i;
+
 	vi->ctrl->coal_rx.rx_usecs = cpu_to_le32(ec->rx_coalesce_usecs);
 	vi->ctrl->coal_rx.rx_max_packets = cpu_to_le32(ec->rx_max_coalesced_frames);
 	sg_init_one(&sgs_rx, &vi->ctrl->coal_rx, sizeof(vi->ctrl->coal_rx));
@@ -3309,6 +3318,22 @@ static int virtnet_send_notf_coal_cmds(struct virtnet_info *vi,
 	return 0;
 }
 
+static int virtnet_send_notf_coal_cmds(struct virtnet_info *vi,
+				       struct ethtool_coalesce *ec)
+{
+	int err;
+
+	err = virtnet_send_tx_notf_coal_cmds(vi, ec);
+	if (err)
+		return err;
+
+	err = virtnet_send_rx_notf_coal_cmds(vi, ec);
+	if (err)
+		return err;
+
+	return 0;
+}
+
 static int virtnet_send_ctrl_coal_vq_cmd(struct virtnet_info *vi,
 					 u16 vqn, u32 max_usecs, u32 max_packets)
 {
-- 
2.19.1.6.gb485710b


