Return-Path: <netdev+bounces-164079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D46E8A2C8BE
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 17:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 585E51658A9
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 16:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3E9191461;
	Fri,  7 Feb 2025 16:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZzPymnKi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552E918E35D;
	Fri,  7 Feb 2025 16:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738945620; cv=none; b=Q7yLdIt6F49LLkpaeJ6v0J97bUmrJcazSwhy5N7aVb1iVl9oBO89nZM7KuBCliu1Sc9GGl4WrXHYVPidZ4Rsbt1CraNaA04F8H0yvUS147wOMxZBISkSMq1dnsEruAHqrw4a6TorEVuJbfrb3kBkbRQKvqWmF4uLSyAkiVoZU7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738945620; c=relaxed/simple;
	bh=s5r+AI5CoWy7fB3orb1C3bppD7WLV8ax2lMNTdU5FZk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E5HG2qCaGVcBYScX0R+ca8U3qopwEdnTrCzVnyBop32d4PyHmy0sdAYEWkQlAXj63ztCl56Wqjh1tUZ6J4UgHqJIkKPHo8WR9Aj9zhujlRxnoYg3stND9puo/gyzhOR9Zam51j1seuJfZum2IF5ngLNMdxTwV6tqIFQ68w0Ovkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZzPymnKi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49EAAC4CED1;
	Fri,  7 Feb 2025 16:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738945619;
	bh=s5r+AI5CoWy7fB3orb1C3bppD7WLV8ax2lMNTdU5FZk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZzPymnKikDyBeyrG/MVZvA3dzEVdxgLvncN5NC4zC0TJUcoeaZIE9bCHYBd9/RQ0g
	 9jEjmc+9pr2BA7jN8wCFBIGlbPe6OXnz3dAV5CsmDJASaJfLtPe7idmCM3AA65uzkO
	 OzZj0bIVPmHuo1htKiuqniDg/A41IoPiFqyoTfxKac0kpDEYSzxkIdpDXRpg1Xp19U
	 UZrJqF2/VILj44PmlWqFlajb2+LrYV/EfnDK7YbKZ2k9ucsOuLb0fGad8/IogZ8JH1
	 1JnAMw+ilB+BULTSauOeTXRLSX6V3FsIRgM8sZkP6m7g+ShKWF8ApiqHxzkgWxQbUy
	 YMAmTnpJcCbYw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 07 Feb 2025 17:26:20 +0100
Subject: [PATCH net-next v2 05/15] net: airoha: Move DSA tag in DMA
 descriptor
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-airoha-en7581-flowtable-offload-v2-5-3a2239692a67@kernel.org>
References: <20250207-airoha-en7581-flowtable-offload-v2-0-3a2239692a67@kernel.org>
In-Reply-To: <20250207-airoha-en7581-flowtable-offload-v2-0-3a2239692a67@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 "Chester A. Unal" <chester.a.unal@arinc9.com>, 
 Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 upstream@airoha.com
X-Mailer: b4 0.14.2

Packet Processor Engine (PPE) module reads DSA tags from the DMA descriptor
and requires untagged DSA packets to properly parse them. Move DSA tag
in the DMA descriptor on TX side and read DSA tag from DMA descriptor
on RX side. In order to avoid skb reallocation, store tag in skb_dst on
RX side.
This is a preliminary patch to enable netfilter flowtable hw offloading
on EN7581 SoC.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c  | 112 ++++++++++++++++++++++++++++--
 drivers/net/ethernet/airoha/airoha_eth.h  |   7 ++
 drivers/net/ethernet/airoha/airoha_regs.h |   2 +
 3 files changed, 116 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index a99d98be86a00f7bd000e2b8218afcde53b1946f..ab95f3da21d90bd42282a9f3f5474ce42a69c9d4 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -9,6 +9,7 @@
 #include <linux/tcp.h>
 #include <linux/u64_stats_sync.h>
 #include <net/dsa.h>
+#include <net/dst_metadata.h>
 #include <net/page_pool/helpers.h>
 #include <net/pkt_cls.h>
 #include <uapi/linux/ppp_defs.h>
@@ -656,6 +657,7 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 		struct airoha_qdma_desc *desc = &q->desc[q->tail];
 		dma_addr_t dma_addr = le32_to_cpu(desc->addr);
 		u32 desc_ctrl = le32_to_cpu(desc->ctrl);
+		struct airoha_gdm_port *port;
 		struct sk_buff *skb;
 		int len, p;
 
@@ -683,6 +685,7 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 			continue;
 		}
 
+		port = eth->ports[p];
 		skb = napi_build_skb(e->buf, q->buf_size);
 		if (!skb) {
 			page_pool_put_full_page(q->page_pool,
@@ -694,10 +697,26 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 		skb_reserve(skb, 2);
 		__skb_put(skb, len);
 		skb_mark_for_recycle(skb);
-		skb->dev = eth->ports[p]->dev;
+		skb->dev = port->dev;
 		skb->protocol = eth_type_trans(skb, skb->dev);
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 		skb_record_rx_queue(skb, qid);
+
+		if (netdev_uses_dsa(port->dev)) {
+			/* PPE module requires untagged packets to work
+			 * properly and it provides DSA port index via the
+			 * DMA descriptor. Report DSA tag to the DSA stack
+			 * via skb dst info.
+			 */
+			u32 sptag = FIELD_GET(QDMA_ETH_RXMSG_SPTAG,
+					      le32_to_cpu(desc->msg0));
+
+			if (sptag < ARRAY_SIZE(port->dsa_meta) &&
+			    port->dsa_meta[sptag])
+				skb_dst_set_noref(skb,
+						  &port->dsa_meta[sptag]->dst);
+		}
+
 		napi_gro_receive(&q->napi, skb);
 
 		done++;
@@ -1636,26 +1655,69 @@ static u16 airoha_dev_select_queue(struct net_device *dev, struct sk_buff *skb,
 	return queue < dev->num_tx_queues ? queue : 0;
 }
 
+static u32 airoha_get_dsa_tag(struct sk_buff *skb, struct net_device *dev)
+{
+#if IS_ENABLED(CONFIG_NET_DSA)
+	__be16 *phdr = (__be16 *)(skb->data + 2 * ETH_ALEN);
+	u16 tag = be16_to_cpu(*phdr);
+	u8 xmit_tpid = tag >> 8;
+	struct dsa_port *dp;
+
+	if (!netdev_uses_dsa(dev))
+		return 0;
+
+	dp = dev->dsa_ptr;
+	if (IS_ERR(dp))
+		return 0;
+
+	if (dp->tag_ops->proto != DSA_TAG_PROTO_MTK)
+		return 0;
+
+	switch (xmit_tpid) {
+	case MTK_HDR_XMIT_TAGGED_TPID_8100:
+		*phdr = cpu_to_be16(ETH_P_8021Q);
+		break;
+	case MTK_HDR_XMIT_TAGGED_TPID_88A8:
+		*phdr = cpu_to_be16(ETH_P_8021AD);
+		break;
+	default:
+		/* PPE module requires untagged DSA packets to work properly,
+		 * so move DSA tag to DMA descriptor.
+		 */
+		memmove(skb->data + MTK_HDR_LEN, skb->data, 2 * ETH_ALEN);
+		skb_pull_rcsum(skb, MTK_HDR_LEN);
+		break;
+	}
+
+	return tag;
+#else
+	return 0;
+#endif
+}
+
 static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 				   struct net_device *dev)
 {
 	struct skb_shared_info *sinfo = skb_shinfo(skb);
 	struct airoha_gdm_port *port = netdev_priv(dev);
-	u32 msg0, msg1, len = skb_headlen(skb);
+	u32 tag, msg0, msg1, len = skb_headlen(skb);
 	struct airoha_qdma *qdma = port->qdma;
 	u32 nr_frags = 1 + sinfo->nr_frags;
 	struct netdev_queue *txq;
 	struct airoha_queue *q;
-	void *data = skb->data;
+	void *data;
 	int i, qid;
 	u16 index;
 	u8 fport;
 
 	qid = skb_get_queue_mapping(skb) % ARRAY_SIZE(qdma->q_tx);
+	tag = airoha_get_dsa_tag(skb, dev);
+
 	msg0 = FIELD_PREP(QDMA_ETH_TXMSG_CHAN_MASK,
 			  qid / AIROHA_NUM_QOS_QUEUES) |
 	       FIELD_PREP(QDMA_ETH_TXMSG_QUEUE_MASK,
-			  qid % AIROHA_NUM_QOS_QUEUES);
+			  qid % AIROHA_NUM_QOS_QUEUES) |
+	       FIELD_PREP(QDMA_ETH_TXMSG_SP_TAG_MASK, tag);
 	if (skb->ip_summed == CHECKSUM_PARTIAL)
 		msg0 |= FIELD_PREP(QDMA_ETH_TXMSG_TCO_MASK, 1) |
 			FIELD_PREP(QDMA_ETH_TXMSG_UCO_MASK, 1) |
@@ -1692,7 +1754,9 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 		return NETDEV_TX_BUSY;
 	}
 
+	data = skb->data;
 	index = q->head;
+
 	for (i = 0; i < nr_frags; i++) {
 		struct airoha_qdma_desc *desc = &q->desc[index];
 		struct airoha_queue_entry *e = &q->entry[index];
@@ -2226,6 +2290,37 @@ static const struct ethtool_ops airoha_ethtool_ops = {
 	.get_rmon_stats		= airoha_ethtool_get_rmon_stats,
 };
 
+static int airoha_metadata_dst_alloc(struct airoha_gdm_port *port)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(port->dsa_meta); i++) {
+		struct metadata_dst *md_dst;
+
+		md_dst = metadata_dst_alloc(0, METADATA_HW_PORT_MUX,
+					    GFP_KERNEL);
+		if (!md_dst)
+			return -ENOMEM;
+
+		md_dst->u.port_info.port_id = i;
+		port->dsa_meta[i] = md_dst;
+	}
+
+	return 0;
+}
+
+static void airoha_metadata_dst_free(struct airoha_gdm_port *port)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(port->dsa_meta); i++) {
+		if (!port->dsa_meta[i])
+			continue;
+
+		metadata_dst_free(port->dsa_meta[i]);
+	}
+}
+
 static int airoha_alloc_gdm_port(struct airoha_eth *eth, struct device_node *np)
 {
 	const __be32 *id_ptr = of_get_property(np, "reg", NULL);
@@ -2298,6 +2393,10 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth, struct device_node *np)
 	port->id = id;
 	eth->ports[index] = port;
 
+	err = airoha_metadata_dst_alloc(port);
+	if (err)
+		return err;
+
 	return register_netdev(dev);
 }
 
@@ -2390,8 +2489,10 @@ static int airoha_probe(struct platform_device *pdev)
 	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
 		struct airoha_gdm_port *port = eth->ports[i];
 
-		if (port && port->dev->reg_state == NETREG_REGISTERED)
+		if (port && port->dev->reg_state == NETREG_REGISTERED) {
+			airoha_metadata_dst_free(port);
 			unregister_netdev(port->dev);
+		}
 	}
 	free_netdev(eth->napi_dev);
 	platform_set_drvdata(pdev, NULL);
@@ -2416,6 +2517,7 @@ static void airoha_remove(struct platform_device *pdev)
 			continue;
 
 		airoha_dev_stop(port->dev);
+		airoha_metadata_dst_free(port);
 		unregister_netdev(port->dev);
 	}
 	free_netdev(eth->napi_dev);
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 743aaf10235fe09fb2a91b491f4b25064ed8319b..fee6c10eaedfd30207205b6557e856091fd45d7e 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -15,6 +15,7 @@
 
 #define AIROHA_MAX_NUM_GDM_PORTS	1
 #define AIROHA_MAX_NUM_QDMA		2
+#define AIROHA_MAX_DSA_PORTS		7
 #define AIROHA_MAX_NUM_RSTS		3
 #define AIROHA_MAX_NUM_XSI_RSTS		5
 #define AIROHA_MAX_MTU			2000
@@ -43,6 +44,10 @@
 #define QDMA_METER_IDX(_n)		((_n) & 0xff)
 #define QDMA_METER_GROUP(_n)		(((_n) >> 8) & 0x3)
 
+#define MTK_HDR_LEN			4
+#define MTK_HDR_XMIT_TAGGED_TPID_8100	1
+#define MTK_HDR_XMIT_TAGGED_TPID_88A8	2
+
 enum {
 	QDMA_INT_REG_IDX0,
 	QDMA_INT_REG_IDX1,
@@ -231,6 +236,8 @@ struct airoha_gdm_port {
 	/* qos stats counters */
 	u64 cpu_tx_packets;
 	u64 fwd_tx_packets;
+
+	struct metadata_dst *dsa_meta[AIROHA_MAX_DSA_PORTS];
 };
 
 struct airoha_eth {
diff --git a/drivers/net/ethernet/airoha/airoha_regs.h b/drivers/net/ethernet/airoha/airoha_regs.h
index 7c9dadb348834cb5a856760abe45e8221d6fd700..e467dd81ff44a9ad560226cab42b7431812f5fb9 100644
--- a/drivers/net/ethernet/airoha/airoha_regs.h
+++ b/drivers/net/ethernet/airoha/airoha_regs.h
@@ -624,6 +624,8 @@
 #define QDMA_ETH_TXMSG_ACNT_G1_MASK	GENMASK(10, 6)	/* 0x1f do not count */
 #define QDMA_ETH_TXMSG_ACNT_G0_MASK	GENMASK(5, 0)	/* 0x3f do not count */
 
+/* RX MSG0 */
+#define QDMA_ETH_RXMSG_SPTAG		GENMASK(21, 14)
 /* RX MSG1 */
 #define QDMA_ETH_RXMSG_DEI_MASK		BIT(31)
 #define QDMA_ETH_RXMSG_IP6_MASK		BIT(30)

-- 
2.48.1


