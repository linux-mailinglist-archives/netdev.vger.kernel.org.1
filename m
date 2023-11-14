Return-Path: <netdev+bounces-47611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 852A27EAA53
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 06:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8A23281093
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 05:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3367C11737;
	Tue, 14 Nov 2023 05:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA5410A36
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 05:55:55 +0000 (UTC)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4EA8D42
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 21:55:53 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VwOFUJk_1699941350;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0VwOFUJk_1699941350)
          by smtp.aliyun-inc.com;
          Tue, 14 Nov 2023 13:55:51 +0800
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
Subject: [PATCH net-next v3 2/5] virtio-net: separate rx/tx coalescing moderation cmds
Date: Tue, 14 Nov 2023 13:55:44 +0800
Message-Id: <b84dfd2aacb4250874e0b4f5002e08ecb644a629.1699938946.git.hengqi@linux.alibaba.com>
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


