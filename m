Return-Path: <netdev+bounces-196007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B50AD3177
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 11:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 776777A95AD
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 09:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F4B28B7D0;
	Tue, 10 Jun 2025 09:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5g3nY1o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D91128A1E9
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 09:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749546773; cv=none; b=QNqRFiyOhH8oJBqGEekbsn3/UXq5muplpl9iuqofAl15ORXxXPWVgbjjAoeZRWPFLaOi26UYw8MoezULNRE73P3I8Boq1vOoeewOOUaPKeqUQr28nIhXH4+P98kv5OfeZHU9BzUGqktW6dbIy75kug8fnp1/RBJ0N370mk1azX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749546773; c=relaxed/simple;
	bh=rOVaLrzxaPc+YcRuOpalOUGc+5Zt4qH2nIIaNuqz3ss=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Y2WX/TWL1wqAUOFH3S7+uqfQ0p+XDrUcCOg2M+9siIf2YuD4dFHu8xAam/1jW97qulb1CiLGrPPdNzwuNu5XtTn546qp7m5mZGoxes0PLeLFR1mRwWCt4MwvfKOMfDoKp2446muxJ3Mfi/hCSD65tnlRBg78bfyyI+rCFJRdG9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5g3nY1o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F308C4CEED;
	Tue, 10 Jun 2025 09:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749546772;
	bh=rOVaLrzxaPc+YcRuOpalOUGc+5Zt4qH2nIIaNuqz3ss=;
	h=From:Date:Subject:To:Cc:From;
	b=f5g3nY1owQe49u4S8vOgeOSpgb+sO53P0vkQLdhjjdpG5loWczo0n5VMzXxQPz7e3
	 jeLP4fbs2xrivhN7UX/UUrDDoNzMYN376RG9bNdEoxbGKV2WzFDD1AmXb0t8el5ydf
	 okkK3litmzGBpmKCuSctEswU0UEszQBu5pk9KXrwGON1rI2kRAkfVQsOLxIXrpzQlb
	 H4Rdj3EUrkhm6ENAAv2Nlflf3REjHh3aW2EuKaSEAkopd2nyeQ0FIIg+Y5t6kJcGAO
	 a7B82App0aico4HSFj8Cmkzs0OSZuo7QvD/0JTI7AiqdGgT2CRmiSxt5VbzXv7uDw1
	 ZLvoq9Vrf3Fcg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 10 Jun 2025 11:12:36 +0200
Subject: [PATCH net-next] net: airoha: Add TCP LRO support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-airoha-eth-lro-v1-1-3b128c407fd8@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAP3R2gC/x2MQQqAIBAAvyJ7bkGFgvpKdBDdciE01ohA/HvSZ
 WAOMxUKCVOBRVUQerhwTl3MoMBHlw5CDt3BajvqyWh0LDk6pDviKRlp3H0wHX420KNLaOf3H65
 bax/9kFaOYAAAAA==
X-Change-ID: 20250610-airoha-eth-lro-e5fcd15fcc91
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.2

EN7581 SoC supports TCP hw Large Receive Offload (LRO) for 8 hw queues.
Introduce TCP LRO support to airoha_eth driver for RX queues 24-31.
In order to support hw TCP LRO, increase page_pool order to 5 for RX
queues 24-31.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c  | 191 +++++++++++++++++++++++++++---
 drivers/net/ethernet/airoha/airoha_eth.h  |  10 ++
 drivers/net/ethernet/airoha/airoha_regs.h |  25 +++-
 3 files changed, 210 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index a7ec609d64dee9c8e901c7eb650bb3fe144ee00a..9378ca384fe2025a40cc528714859dd59300fbcd 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -12,6 +12,7 @@
 #include <net/dst_metadata.h>
 #include <net/page_pool/helpers.h>
 #include <net/pkt_cls.h>
+#include <net/tcp.h>
 #include <uapi/linux/ppp_defs.h>
 
 #include "airoha_regs.h"
@@ -439,6 +440,40 @@ static void airoha_fe_crsn_qsel_init(struct airoha_eth *eth)
 				 CDM_CRSN_QSEL_Q1));
 }
 
+static void airoha_fe_lro_init_rx_queue(struct airoha_eth *eth, int qdma_id,
+					int lro_queue_index, int qid,
+					int nbuf, int buf_size)
+{
+	airoha_fe_rmw(eth, REG_CDM_LRO_LIMIT(qdma_id),
+		      CDM_LRO_AGG_NUM_MASK | CDM_LRO_AGG_SIZE_MASK,
+		      FIELD_PREP(CDM_LRO_AGG_NUM_MASK, nbuf) |
+		      FIELD_PREP(CDM_LRO_AGG_SIZE_MASK, buf_size));
+	airoha_fe_rmw(eth, REG_CDM_LRO_AGE_TIME(qdma_id),
+		      CDM_LRO_AGE_TIME_MASK | CDM_LRO_AGG_TIME_MASK,
+		      FIELD_PREP(CDM_LRO_AGE_TIME_MASK,
+				 AIROHA_RXQ_LRO_MAX_AGE_TIME) |
+		      FIELD_PREP(CDM_LRO_AGG_TIME_MASK,
+				 AIROHA_RXQ_LRO_MAX_AGG_TIME));
+	airoha_fe_rmw(eth, REG_CDM_LRO_RXQ(qdma_id, lro_queue_index),
+		      LRO_RXQ_MASK(lro_queue_index),
+		      qid << __ffs(LRO_RXQ_MASK(lro_queue_index)));
+	airoha_fe_set(eth, REG_CDM_LRO_EN(qdma_id), BIT(lro_queue_index));
+}
+
+static void airoha_fe_lro_disable(struct airoha_eth *eth, int qdma_id)
+{
+	int i;
+
+	airoha_fe_clear(eth, REG_CDM_LRO_LIMIT(qdma_id),
+			CDM_LRO_AGG_NUM_MASK | CDM_LRO_AGG_SIZE_MASK);
+	airoha_fe_clear(eth, REG_CDM_LRO_AGE_TIME(qdma_id),
+			CDM_LRO_AGE_TIME_MASK | CDM_LRO_AGG_TIME_MASK);
+	airoha_fe_clear(eth, REG_CDM_LRO_EN(qdma_id), LRO_RXQ_EN_MASK);
+	for (i = 0; i < AIROHA_MAX_NUM_LRO_QUEUES; i++)
+		airoha_fe_clear(eth, REG_CDM_LRO_RXQ(qdma_id, i),
+				LRO_RXQ_MASK(i));
+}
+
 static int airoha_fe_init(struct airoha_eth *eth)
 {
 	airoha_fe_maccr_init(eth);
@@ -618,9 +653,87 @@ static int airoha_qdma_get_gdm_port(struct airoha_eth *eth,
 	return port >= ARRAY_SIZE(eth->ports) ? -EINVAL : port;
 }
 
+static bool airoha_qdma_is_lro_rx_queue(struct airoha_queue *q,
+					struct airoha_qdma *qdma)
+{
+	int qid = q - &qdma->q_rx[0];
+
+	/* EN7581 SoC supports at most 8 LRO rx queues */
+	BUILD_BUG_ON(hweight32(AIROHA_RXQ_LRO_EN_MASK) >
+		     AIROHA_MAX_NUM_LRO_QUEUES);
+
+	return !!(AIROHA_RXQ_LRO_EN_MASK & BIT(qid));
+}
+
+static int airoha_qdma_lro_rx_process(struct airoha_queue *q,
+				      struct airoha_qdma_desc *desc)
+{
+	u32 msg1 = le32_to_cpu(desc->msg1), msg2 = le32_to_cpu(desc->msg2);
+	u32 th_off, tcp_ack_seq, msg3 = le32_to_cpu(desc->msg3);
+	bool ipv4 = FIELD_GET(QDMA_ETH_RXMSG_IP4_MASK, msg1);
+	bool ipv6 = FIELD_GET(QDMA_ETH_RXMSG_IP6_MASK, msg1);
+	struct sk_buff *skb = q->skb;
+	u16 tcp_win, l2_len;
+	struct tcphdr *th;
+
+	if (FIELD_GET(QDMA_ETH_RXMSG_AGG_COUNT_MASK, msg2) <= 1)
+		return 0;
+
+	if (!ipv4 && !ipv6)
+		return -EOPNOTSUPP;
+
+	l2_len = FIELD_GET(QDMA_ETH_RXMSG_L2_LEN_MASK, msg2);
+	if (ipv4) {
+		u16 agg_len = FIELD_GET(QDMA_ETH_RXMSG_AGG_LEN_MASK, msg3);
+		struct iphdr *iph = (struct iphdr *)(skb->data + l2_len);
+
+		if (iph->protocol != IPPROTO_TCP)
+			return -EOPNOTSUPP;
+
+		iph->tot_len = cpu_to_be16(agg_len);
+		iph->check = 0;
+		iph->check = ip_fast_csum((void *)iph, iph->ihl);
+		th_off = l2_len + (iph->ihl << 2);
+	} else {
+		struct ipv6hdr *ip6h = (struct ipv6hdr *)(skb->data + l2_len);
+		u32 len, desc_ctrl = le32_to_cpu(desc->ctrl);
+
+		if (ip6h->nexthdr != NEXTHDR_TCP)
+			return -EOPNOTSUPP;
+
+		len = FIELD_GET(QDMA_DESC_LEN_MASK, desc_ctrl);
+		ip6h->payload_len = cpu_to_be16(len - l2_len - sizeof(*ip6h));
+		th_off = l2_len + sizeof(*ip6h);
+	}
+
+	tcp_win = FIELD_GET(QDMA_ETH_RXMSG_TCP_WIN_MASK, msg3);
+	tcp_ack_seq = le32_to_cpu(desc->data);
+
+	th = (struct tcphdr *)(skb->data + th_off);
+	th->ack_seq = cpu_to_be32(tcp_ack_seq);
+	th->window = cpu_to_be16(tcp_win);
+
+	/* check tcp timestamp option */
+	if (th->doff == sizeof(*th) + TCPOLEN_TSTAMP_ALIGNED) {
+		__be32 *topt = (__be32 *)(th + 1);
+
+		if (*topt == cpu_to_be32((TCPOPT_NOP << 24) |
+					 (TCPOPT_NOP << 16) |
+					 (TCPOPT_TIMESTAMP << 8) |
+					 TCPOLEN_TIMESTAMP)) {
+			u32 tcp_ts_reply = le32_to_cpu(desc->tcp_ts_reply);
+
+			put_unaligned_be32(tcp_ts_reply, topt + 2);
+		}
+	}
+
+	return 0;
+}
+
 static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 {
 	enum dma_data_direction dir = page_pool_get_dma_dir(q->page_pool);
+	bool lro_queue = airoha_qdma_is_lro_rx_queue(q, q->qdma);
 	struct airoha_qdma *qdma = q->qdma;
 	struct airoha_eth *eth = qdma->eth;
 	int qid = q - &qdma->q_rx[0];
@@ -663,9 +776,14 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 			__skb_put(q->skb, len);
 			skb_mark_for_recycle(q->skb);
 			q->skb->dev = port->dev;
-			q->skb->protocol = eth_type_trans(q->skb, port->dev);
 			q->skb->ip_summed = CHECKSUM_UNNECESSARY;
 			skb_record_rx_queue(q->skb, qid);
+
+			if (lro_queue && (port->dev->features & NETIF_F_LRO) &&
+			    airoha_qdma_lro_rx_process(q, desc) < 0)
+				goto free_frag;
+
+			q->skb->protocol = eth_type_trans(q->skb, port->dev);
 		} else { /* scattered frame */
 			struct skb_shared_info *shinfo = skb_shinfo(q->skb);
 			int nr_frags = shinfo->nr_frags;
@@ -751,14 +869,16 @@ static int airoha_qdma_rx_napi_poll(struct napi_struct *napi, int budget)
 }
 
 static int airoha_qdma_init_rx_queue(struct airoha_queue *q,
-				     struct airoha_qdma *qdma, int ndesc)
+				     struct airoha_qdma *qdma,
+				     int ndesc, bool lro_queue)
 {
+	int pp_order = lro_queue ? 5 : 0;
 	const struct page_pool_params pp_params = {
-		.order = 0,
-		.pool_size = 256,
+		.order = pp_order,
+		.pool_size = 256 >> pp_order,
 		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
 		.dma_dir = DMA_FROM_DEVICE,
-		.max_len = PAGE_SIZE,
+		.max_len = PAGE_SIZE << pp_order,
 		.nid = NUMA_NO_NODE,
 		.dev = qdma->eth->dev,
 		.napi = &q->napi,
@@ -767,7 +887,7 @@ static int airoha_qdma_init_rx_queue(struct airoha_queue *q,
 	int qid = q - &qdma->q_rx[0], thr;
 	dma_addr_t dma_addr;
 
-	q->buf_size = PAGE_SIZE / 2;
+	q->buf_size = pp_params.max_len / (2 * (1 + lro_queue));
 	q->ndesc = ndesc;
 	q->qdma = qdma;
 
@@ -829,15 +949,18 @@ static int airoha_qdma_init_rx(struct airoha_qdma *qdma)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(qdma->q_rx); i++) {
-		int err;
+		struct airoha_queue *q = &qdma->q_rx[i];
+		bool lro_queue;
+		int err, ndesc;
 
 		if (!(RX_DONE_INT_MASK & BIT(i))) {
 			/* rx-queue not binded to irq */
 			continue;
 		}
 
-		err = airoha_qdma_init_rx_queue(&qdma->q_rx[i], qdma,
-						RX_DSCP_NUM(i));
+		lro_queue = airoha_qdma_is_lro_rx_queue(q, qdma);
+		ndesc = lro_queue ? RX_DSCP_NUM(1) : RX_DSCP_NUM(i);
+		err = airoha_qdma_init_rx_queue(q, qdma, ndesc, lro_queue);
 		if (err)
 			return err;
 	}
@@ -1870,6 +1993,46 @@ static u32 airoha_get_dsa_tag(struct sk_buff *skb, struct net_device *dev)
 #endif
 }
 
+static int airoha_dev_set_features(struct net_device *dev,
+				   netdev_features_t features)
+{
+	netdev_features_t diff = dev->features ^ features;
+	struct airoha_gdm_port *port = netdev_priv(dev);
+	struct airoha_qdma *qdma = port->qdma;
+	struct airoha_eth *eth = qdma->eth;
+	int qdma_id = qdma - &eth->qdma[0];
+
+	if (!(diff & NETIF_F_LRO))
+		return 0;
+
+	/* reset LRO configuration */
+	if (features & NETIF_F_LRO) {
+		int i, lro_queue_index = 0;
+
+		for (i = 0; i < ARRAY_SIZE(qdma->q_rx); i++) {
+			struct airoha_queue *q = &qdma->q_rx[i];
+			bool lro_queue;
+
+			if (!q->ndesc)
+				continue;
+
+			lro_queue = airoha_qdma_is_lro_rx_queue(q, qdma);
+			if (!lro_queue)
+				continue;
+
+			airoha_fe_lro_init_rx_queue(eth, qdma_id,
+						    lro_queue_index, i,
+						    q->page_pool->p.pool_size,
+						    q->buf_size);
+			lro_queue_index++;
+		}
+	} else {
+		airoha_fe_lro_disable(eth, qdma_id);
+	}
+
+	return 0;
+}
+
 static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 				   struct net_device *dev)
 {
@@ -2751,6 +2914,7 @@ static const struct net_device_ops airoha_netdev_ops = {
 	.ndo_stop		= airoha_dev_stop,
 	.ndo_change_mtu		= airoha_dev_change_mtu,
 	.ndo_select_queue	= airoha_dev_select_queue,
+	.ndo_set_features	= airoha_dev_set_features,
 	.ndo_start_xmit		= airoha_dev_xmit,
 	.ndo_get_stats64        = airoha_dev_get_stats64,
 	.ndo_set_mac_address	= airoha_dev_set_macaddr,
@@ -2848,12 +3012,9 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth,
 	dev->ethtool_ops = &airoha_ethtool_ops;
 	dev->max_mtu = AIROHA_MAX_MTU;
 	dev->watchdog_timeo = 5 * HZ;
-	dev->hw_features = NETIF_F_IP_CSUM | NETIF_F_RXCSUM |
-			   NETIF_F_TSO6 | NETIF_F_IPV6_CSUM |
-			   NETIF_F_SG | NETIF_F_TSO |
-			   NETIF_F_HW_TC;
-	dev->features |= dev->hw_features;
-	dev->vlan_features = dev->hw_features;
+	dev->hw_features = AIROHA_HW_FEATURES | NETIF_F_LRO;
+	dev->features |= AIROHA_HW_FEATURES;
+	dev->vlan_features = AIROHA_HW_FEATURES;
 	dev->dev.of_node = np;
 	dev->irq = qdma->irq_banks[0].irq;
 	SET_NETDEV_DEV(dev, eth->dev);
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index a970b789cf232c316e5ea27b0146493bf91c3767..bea56597af3ba0e8da3cc17e4a74b91d4f681137 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -41,6 +41,16 @@
 	 (_n) == 15 ? 128 :		\
 	 (_n) ==  0 ? 1024 : 16)
 
+#define AIROHA_MAX_NUM_LRO_QUEUES	8
+#define AIROHA_RXQ_LRO_EN_MASK		0xff000000
+#define AIROHA_RXQ_LRO_MAX_AGG_TIME	100
+#define AIROHA_RXQ_LRO_MAX_AGE_TIME	2000 /* 1ms */
+
+#define AIROHA_HW_FEATURES			\
+	(NETIF_F_IP_CSUM | NETIF_F_RXCSUM |	\
+	 NETIF_F_TSO6 | NETIF_F_IPV6_CSUM |	\
+	 NETIF_F_SG | NETIF_F_TSO | NETIF_F_HW_TC)
+
 #define PSE_RSV_PAGES			128
 #define PSE_QUEUE_RSV_PAGES		64
 
diff --git a/drivers/net/ethernet/airoha/airoha_regs.h b/drivers/net/ethernet/airoha/airoha_regs.h
index 04187eb40ec674ec5a4ccfc968bb4bd579a53095..86d320a6793b7d4ec77f823f61fa77a4c76a61a5 100644
--- a/drivers/net/ethernet/airoha/airoha_regs.h
+++ b/drivers/net/ethernet/airoha/airoha_regs.h
@@ -23,6 +23,9 @@
 #define GDM3_BASE			0x1100
 #define GDM4_BASE			0x2500
 
+#define CDM_BASE(_n)			\
+	((_n) == 1 ? CDM2_BASE : CDM1_BASE)
+
 #define GDM_BASE(_n)			\
 	((_n) == 4 ? GDM4_BASE :	\
 	 (_n) == 3 ? GDM3_BASE :	\
@@ -127,6 +130,20 @@
 #define CDM2_CRSN_QSEL_REASON_MASK(_n)	\
 	GENMASK(4 + (((_n) % 4) << 3),	(((_n) % 4) << 3))
 
+#define REG_CDM_LRO_RXQ(_n, _m)		(CDM_BASE(_n) + 0x78 + ((_m) & 0x4))
+#define LRO_RXQ_MASK(_n)		GENMASK(4 + (((_n) & 0x3) << 3), ((_n) & 0x3) << 3)
+
+#define REG_CDM_LRO_EN(_n)		(CDM_BASE(_n) + 0x80)
+#define LRO_RXQ_EN_MASK			GENMASK(7, 0)
+
+#define REG_CDM_LRO_LIMIT(_n)		(CDM_BASE(_n) + 0x84)
+#define CDM_LRO_AGG_NUM_MASK		GENMASK(23, 16)
+#define CDM_LRO_AGG_SIZE_MASK		GENMASK(15, 0)
+
+#define REG_CDM_LRO_AGE_TIME(_n)	(CDM_BASE(_n) + 0x88)
+#define CDM_LRO_AGE_TIME_MASK		GENMASK(31, 16)
+#define CDM_LRO_AGG_TIME_MASK		GENMASK(15, 0)
+
 #define REG_GDM_FWD_CFG(_n)		GDM_BASE(_n)
 #define GDM_DROP_CRC_ERR		BIT(23)
 #define GDM_IP4_CKSUM			BIT(22)
@@ -896,9 +913,15 @@
 #define QDMA_ETH_RXMSG_SPORT_MASK	GENMASK(25, 21)
 #define QDMA_ETH_RXMSG_CRSN_MASK	GENMASK(20, 16)
 #define QDMA_ETH_RXMSG_PPE_ENTRY_MASK	GENMASK(15, 0)
+/* RX MSG2 */
+#define QDMA_ETH_RXMSG_AGG_COUNT_MASK	GENMASK(31, 24)
+#define QDMA_ETH_RXMSG_L2_LEN_MASK	GENMASK(6, 0)
+/* RX MSG3 */
+#define QDMA_ETH_RXMSG_AGG_LEN_MASK	GENMASK(31, 16)
+#define QDMA_ETH_RXMSG_TCP_WIN_MASK	GENMASK(15, 0)
 
 struct airoha_qdma_desc {
-	__le32 rsv;
+	__le32 tcp_ts_reply;
 	__le32 ctrl;
 	__le32 addr;
 	__le32 data;

---
base-commit: 2c7e4a2663a1ab5a740c59c31991579b6b865a26
change-id: 20250610-airoha-eth-lro-e5fcd15fcc91

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


