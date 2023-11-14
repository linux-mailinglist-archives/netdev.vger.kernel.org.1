Return-Path: <netdev+bounces-47613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1D67EAA57
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 06:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F6D31C20A76
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 05:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6519511734;
	Tue, 14 Nov 2023 05:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62684125BC
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 05:55:59 +0000 (UTC)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBC9D42
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 21:55:57 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VwOFULA_1699941354;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0VwOFULA_1699941354)
          by smtp.aliyun-inc.com;
          Tue, 14 Nov 2023 13:55:55 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Cc: Jason Wang <jasowang@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	xuanzhuo@linux.alibaba.com
Subject: [PATCH net-next v3 5/5] virtio-net: return -EOPNOTSUPP for adaptive-tx
Date: Tue, 14 Nov 2023 13:55:47 +0800
Message-Id: <6a79229fbeb72edf41185a45a0f9ea5cd87a1086.1699938946.git.hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <cover.1699938946.git.hengqi@linux.alibaba.com>
References: <cover.1699938946.git.hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We do not currently support tx dim, so respond to -EOPNOTSUPP.

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
v1->v2:
- Use -EOPNOTSUPP instead of specific implementation.

 drivers/net/virtio_net.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index bc32d5aae005..b082f2acbb22 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3364,9 +3364,15 @@ static int virtnet_get_link_ksettings(struct net_device *dev,
 static int virtnet_send_tx_notf_coal_cmds(struct virtnet_info *vi,
 					  struct ethtool_coalesce *ec)
 {
+	bool tx_ctrl_dim_on = !!ec->use_adaptive_tx_coalesce;
 	struct scatterlist sgs_tx;
 	int i;
 
+	if (tx_ctrl_dim_on) {
+		pr_debug("Failed to enable adaptive-tx, which is not supported\n");
+		return -EOPNOTSUPP;
+	}
+
 	vi->ctrl->coal_tx.tx_usecs = cpu_to_le32(ec->tx_coalesce_usecs);
 	vi->ctrl->coal_tx.tx_max_packets = cpu_to_le32(ec->tx_max_coalesced_frames);
 	sg_init_one(&sgs_tx, &vi->ctrl->coal_tx, sizeof(vi->ctrl->coal_tx));
@@ -3501,6 +3507,25 @@ static int virtnet_send_rx_notf_coal_vq_cmds(struct virtnet_info *vi,
 	return 0;
 }
 
+static int virtnet_send_tx_notf_coal_vq_cmds(struct virtnet_info *vi,
+					     struct ethtool_coalesce *ec,
+					     u16 queue)
+{
+	bool tx_ctrl_dim_on = !!ec->use_adaptive_tx_coalesce;
+	int err;
+
+	if (tx_ctrl_dim_on) {
+		pr_debug("Enabling adaptive-tx for txq%d is not supported\n", queue);
+		return -EOPNOTSUPP;
+	}
+
+	err = virtnet_send_tx_ctrl_coal_vq_cmd(vi, queue,
+					       ec->tx_coalesce_usecs,
+					       ec->tx_max_coalesced_frames);
+
+	return err;
+}
+
 static int virtnet_send_notf_coal_vq_cmds(struct virtnet_info *vi,
 					  struct ethtool_coalesce *ec,
 					  u16 queue)
@@ -3511,9 +3536,7 @@ static int virtnet_send_notf_coal_vq_cmds(struct virtnet_info *vi,
 	if (err)
 		return err;
 
-	err = virtnet_send_tx_ctrl_coal_vq_cmd(vi, queue,
-					       ec->tx_coalesce_usecs,
-					       ec->tx_max_coalesced_frames);
+	err = virtnet_send_tx_notf_coal_vq_cmds(vi, ec, queue);
 	if (err)
 		return err;
 
-- 
2.19.1.6.gb485710b


