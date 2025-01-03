Return-Path: <netdev+bounces-154990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8014CA00924
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 13:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EEF77A1CF1
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 12:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FEF1F9F77;
	Fri,  3 Jan 2025 12:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrAsgU/C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129781C07CF
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 12:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735906656; cv=none; b=be4fBVBQRBCLUmZTvbe6pcD3/L9SLVE3AZbAGwXEGTvU5Yd67bvCLpq/C8/c0M9nrzYzpV8wlWfrW9Z6G4tVuBlW9ri0Nphu27pzHc1qMg2ZsbIVqD0josYCGYVYwjs5pvFHFOYwVHjvii7vF+Y2SLrQG06q4lk8csCjWr4MqiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735906656; c=relaxed/simple;
	bh=JRnHLtZnJoQ0iDU2DZQstsrXqzWvKNfZv0Jn51+HVcA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EYja8+txKvJgD8AlLubovqPzF1CDkCq6xAeVYMwuUHdXAhZ8r1hPXXkljLWQmGeSanodmfqAbLQCdZ/w5El50UYpyWu9ghH4MB0PcFH7GiqKszkqMLjZp85e7VlQia48bjA3EULVP+HMxoYV/5SvHqxLelIc51bmo+AzqLq4L0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrAsgU/C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E7CBC4CECE;
	Fri,  3 Jan 2025 12:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735906655;
	bh=JRnHLtZnJoQ0iDU2DZQstsrXqzWvKNfZv0Jn51+HVcA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RrAsgU/Cbr1PYYswprRAJXe929GnT8ZI5m+ZuUksLJNv4EfVchoSxd0hgLU8mK3Gl
	 a9QNgEYlVUAYM3JHZSvbDy00Iyz7OLTkua5zgjcl7/ZgzEczHCQqMKDrNRbxk8HDJr
	 M4lnXrvQRuyFo5JJKc1iGpSz/Tox5qR5x5oyjOMcATJa9D0s+B6/LmO9U0E+HGUgNv
	 1f1xoicVcu9ZIv07StEmcghe9GAxH9Q124V08JROj1aEqSCs6TduNN9aSKCwGVJrih
	 4cD4JUWVSd4aM1lxCNLm6N7i6cwOoZhWjfCaVvj59mNmotTVIuOUg4ffPxTmu46amL
	 yfSbyGEt1pyGw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 03 Jan 2025 13:17:03 +0100
Subject: [PATCH net-next 2/4] net: airoha: Introduce ndo_select_queue
 callback
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-airoha-en7581-qdisc-offload-v1-2-608a23fa65d5@kernel.org>
References: <20250103-airoha-en7581-qdisc-offload-v1-0-608a23fa65d5@kernel.org>
In-Reply-To: <20250103-airoha-en7581-qdisc-offload-v1-0-608a23fa65d5@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
 Mark Lee <Mark-MC.Lee@mediatek.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 upstream@airoha.com, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Airoha EN7581 SoC supports 32 Tx DMA rings used to feed packets to QoS
channels. Each channels supports 8 QoS queues where the user can apply
QoS scheduling policies. In a similar way, the user can configure hw
rate shaping for each QoS channel.
Introduce ndo_select_queue callback in order to select the tx queue
based on QoS channel and QoS queue. In particular, for dsa device select
QoS channel according to the dsa user port index, rely on port id
otherwise. Select QoS queue based on the skb priority.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/airoha_eth.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
index 59e889cf08e49b89d20fa630f83a1c1322bae6b4..4b361f30829f4f5c40b1d8a97d43fd3a206e4206 100644
--- a/drivers/net/ethernet/mediatek/airoha_eth.c
+++ b/drivers/net/ethernet/mediatek/airoha_eth.c
@@ -23,6 +23,8 @@
 #define AIROHA_MAX_NUM_XSI_RSTS		5
 #define AIROHA_MAX_MTU			2000
 #define AIROHA_MAX_PACKET_SIZE		2048
+#define AIROHA_NUM_QOS_CHANNELS		4
+#define AIROHA_NUM_QOS_QUEUES		8
 #define AIROHA_NUM_TX_RING		32
 #define AIROHA_NUM_RX_RING		32
 #define AIROHA_FE_MC_MAX_VLAN_TABLE	64
@@ -2429,21 +2431,44 @@ static void airoha_dev_get_stats64(struct net_device *dev,
 	} while (u64_stats_fetch_retry(&port->stats.syncp, start));
 }
 
+static u16 airoha_dev_select_queue(struct net_device *dev, struct sk_buff *skb,
+				   struct net_device *sb_dev)
+{
+	struct airoha_gdm_port *port = netdev_priv(dev);
+	int queue, channel;
+
+	/* For dsa device select QoS channel according to the dsa user port
+	 * index, rely on port id otherwise. Select QoS queue based on the
+	 * skb priority.
+	 */
+	channel = netdev_uses_dsa(dev) ? skb_get_queue_mapping(skb) : port->id;
+	channel = channel % AIROHA_NUM_QOS_CHANNELS;
+	queue = (skb->priority - 1) % AIROHA_NUM_QOS_QUEUES; /* QoS queue */
+	queue = channel * AIROHA_NUM_QOS_QUEUES + queue;
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
@@ -2617,6 +2642,7 @@ static const struct net_device_ops airoha_netdev_ops = {
 	.ndo_init		= airoha_dev_init,
 	.ndo_open		= airoha_dev_open,
 	.ndo_stop		= airoha_dev_stop,
+	.ndo_select_queue	= airoha_dev_select_queue,
 	.ndo_start_xmit		= airoha_dev_xmit,
 	.ndo_get_stats64        = airoha_dev_get_stats64,
 	.ndo_set_mac_address	= airoha_dev_set_macaddr,

-- 
2.47.1


