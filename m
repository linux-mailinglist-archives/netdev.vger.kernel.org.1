Return-Path: <netdev+bounces-151143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 163A89ECFC3
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 16:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BCC1282275
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 15:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7255219F41B;
	Wed, 11 Dec 2024 15:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="elwXX8+H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5FA134AC
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 15:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733931134; cv=none; b=ECoQ0j6iDQaj+DX64+VaGI+dHf3HOxiqgpAccEfxdK0nAIR1pn9KWqBOkXF3ceOzhUYmabmOpc+AkZnsK3d7XaNgVAdUlIXz89J6Ksb05iUBDleuY4oWCtQUsQqZk0Xrcm5+IA+emHDyfTmo5c5RGW3V22SttrE62ZaZGreE55M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733931134; c=relaxed/simple;
	bh=FjkADuk5QT857Oow1g4ktRv2/j1HY4gW3jc60LkOf6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ov0MAgHJCEeD2fbbbCvTI/VGpf0Ug+2KCCLP2FfXLBkMjc5W5Da/j/aE+C820cv5kHPSz5uWwOo44KCUN017rCoYmYemIDCif92nvnyTQ3Kx08KlIR7ufSh3XHCR2Q0sI39PccUA0k1QnjfmYTPQi/aKAhrKGItABiBlJZ6+sFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=elwXX8+H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 826BBC4CED2;
	Wed, 11 Dec 2024 15:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733931133;
	bh=FjkADuk5QT857Oow1g4ktRv2/j1HY4gW3jc60LkOf6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=elwXX8+HlLQ6eYQQ9H6qXZhmeeMzSBm0B1S8Aiy8bwOM+2OHOQmhrR39suayuF+5n
	 PkT6lq3aOOsQsmI9fANi9Gr53zaMgpP2IoFbKwABqkI2Zt8DR5eiDifQAKrPzqwIZ0
	 B6iLxkecOlMRLQTEGSMC3BuBcpoZ1KcGmBpJisEh6DjCG+p+yQmacJhPBwzq7fDFd+
	 kpyOpyVya30UCnUiTuuUJyq/GTvdaoZor6K5ecCyDV+TuE+9IHofNEmrbh4OxPG8fh
	 uUUPq5JzR7/k8mXBRIVNmWWgadHIv4EvdjD3Sl+CVdaQmoNXAVO65zvn9nH61XWsr9
	 c0GQjPq6GMdEg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	nbd@nbd.name,
	sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com,
	lorenzo.bianconi83@gmail.com
Subject: [RFC net-next 2/5] net: airoha: Introduce ndo_select_queue callback
Date: Wed, 11 Dec 2024 16:31:50 +0100
Message-ID: <a7d8ec3d70d7a0e2208909189e46a63e769f8f9d.1733930558.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1733930558.git.lorenzo@kernel.org>
References: <cover.1733930558.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Airoha EN7581 SoC supports 32 Tx DMA rings used to feed packets to 32
QoS channels. Each channels supports 8 QoS queues where the user can
apply QoS scheduling policies. In a similar way, the user can configure
hw rate shaping for each QoS channel.
Introduce ndo_select_queue callback in order to select the tx queue
based on QoS channel and QoS queue. In particular, for dsa device select
QoS channel according to the dsa user port index, rely on port id
otherwise. Select QoS queue based on the skb priority.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/airoha_eth.c | 28 ++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
index dd8d65a7e255..8b927bf310ed 100644
--- a/drivers/net/ethernet/mediatek/airoha_eth.c
+++ b/drivers/net/ethernet/mediatek/airoha_eth.c
@@ -23,6 +23,7 @@
 #define AIROHA_MAX_NUM_XSI_RSTS		5
 #define AIROHA_MAX_MTU			2000
 #define AIROHA_MAX_PACKET_SIZE		2048
+#define AIROHA_NUM_QOS_QUEUES		8
 #define AIROHA_NUM_TX_RING		32
 #define AIROHA_NUM_RX_RING		32
 #define AIROHA_FE_MC_MAX_VLAN_TABLE	64
@@ -2417,21 +2418,43 @@ static void airoha_dev_get_stats64(struct net_device *dev,
 	} while (u64_stats_fetch_retry(&port->stats.syncp, start));
 }
 
+static u16 airoha_dev_select_queue(struct net_device *dev, struct sk_buff *skb,
+				   struct net_device *sb_dev)
+{
+	struct airoha_gdm_port *port = netdev_priv(dev);
+	u16 queue;
+
+	/* For dsa device select QoS channel according to the dsa user port
+	 * index, rely on port id otherwise. Select QoS queue based on the
+	 * skb priority.
+	 */
+	queue = netdev_uses_dsa(dev) ? skb_get_queue_mapping(skb) : port->id;
+	queue = queue * AIROHA_NUM_QOS_QUEUES +		/* QoS channel */
+		skb->priority % AIROHA_NUM_QOS_QUEUES;	/* QoS queue */
+
+	return queue < dev->num_tx_queues ? queue : 0;
+}
+
 static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 				   struct net_device *dev)
 {
 	struct skb_shared_info *sinfo = skb_shinfo(skb);
 	struct airoha_gdm_port *port = netdev_priv(dev);
-	u32 msg0 = 0, msg1, len = skb_headlen(skb);
-	int i, qid = skb_get_queue_mapping(skb);
+	u32 msg0, msg1, len = skb_headlen(skb);
 	struct airoha_qdma *qdma = port->qdma;
 	u32 nr_frags = 1 + sinfo->nr_frags;
 	struct netdev_queue *txq;
 	struct airoha_queue *q;
 	void *data = skb->data;
+	int i, qid;
 	u16 index;
 	u8 fport;
 
+	qid = skb_get_queue_mapping(skb) % ARRAY_SIZE(qdma->q_tx);
+	msg0 = FIELD_PREP(QDMA_ETH_TXMSG_CHAN_MASK,
+			  qid / AIROHA_NUM_QOS_QUEUES) |
+	       FIELD_PREP(QDMA_ETH_TXMSG_QUEUE_MASK,
+			  qid % AIROHA_NUM_QOS_QUEUES);
 	if (skb->ip_summed == CHECKSUM_PARTIAL)
 		msg0 |= FIELD_PREP(QDMA_ETH_TXMSG_TCO_MASK, 1) |
 			FIELD_PREP(QDMA_ETH_TXMSG_UCO_MASK, 1) |
@@ -2605,6 +2628,7 @@ static const struct net_device_ops airoha_netdev_ops = {
 	.ndo_init		= airoha_dev_init,
 	.ndo_open		= airoha_dev_open,
 	.ndo_stop		= airoha_dev_stop,
+	.ndo_select_queue	= airoha_dev_select_queue,
 	.ndo_start_xmit		= airoha_dev_xmit,
 	.ndo_get_stats64        = airoha_dev_get_stats64,
 	.ndo_set_mac_address	= airoha_dev_set_macaddr,
-- 
2.47.1


