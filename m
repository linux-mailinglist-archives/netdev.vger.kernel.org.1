Return-Path: <netdev+bounces-289828-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCdIOXBuDWp9xQUAu9opvQ
	(envelope-from <netdev+bounces-289828-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 10:18:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 687E1589914
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 10:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E2FA1307C42B
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5691539BFFC;
	Wed, 20 May 2026 08:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f01dcePf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54D437106A
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 08:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779264765; cv=none; b=nHP4iiYB+iN5woM3J1SFbHlzjTptRrVnKXllb8Fd33F16Hw2+cAc0v9fQG+s3Md2GfpUp/xlkSY9dlnKJbXPR2Gdxxixn2/Y09sWcEDApivYgOaDf94VQPD55TNOTUPxunY0//QCqXDtqIJfqcUCWAtayYXLmf+rjoLPmJb/VhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779264765; c=relaxed/simple;
	bh=RriNfkTkU1TJRia+W95y6VaKtU6o07QP1ncUci+GT6M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=r2ZK9pxaoZ2YzC0kS8/GH3n64nM63HDVUPp18x6Y7tv/6XI9adhkqLKeZ06u0PbcNsvhIsJRYipfluCc84dA3nW7zJ8RYBevvjdvLs4bawqoIMIaWucQzItNIScLUina1tGveDZT8lt8t1Q5TWDfuG4BJrhUxSnxQw46gAFySBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f01dcePf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF431F000E9;
	Wed, 20 May 2026 08:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779264763;
	bh=ZQS8XilUa1r3xVa+F86IWUqS7+Nx5O9cdD1dsWTVuI0=;
	h=From:Date:Subject:To:Cc;
	b=f01dcePf2OkPCCOnYxfAEQlHBSo0PmhTJ0SekbYQrXRdudCivtjeR554U+LpJ3664
	 wFFybPTvpumb64YiIP+i7M0q9z2DmEhaqDcH8CWbPmN8Szk3CK6hOPAR5Fw7j3+UAT
	 sFjyHsKUdQVMeTYoP9Xy++HvAu+yw+tMjtNTlZQtC1namjmTVhvYLth2sU+SQo8nUL
	 uyhyZTsAGzKogQ+D1CnkPXTRuX5unu6cJD5RT6NOrNk0/k6pp3SJg5H2oB2KHDa5aG
	 2sBUKeuEE6kcEKNF3smF+xC2XBch4lcWaHXebBO4t/6h0R/dW5P4CYNRM92Q4ULaht
	 Q+KYUqIFoFeeQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 20 May 2026 10:12:12 +0200
Subject: [PATCH RFC net-next] net: airoha: Add TCP LRO support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260520-airoha-eth-lro-v1-1-129cc33766e9@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUyMD3cTMovyMRN3UkgzdnKJ83UTTFMNkYzNjQwtDQyWgpoKi1LTMCrC
 B0UpBbs4KeaklunmpFSVKsbW1ADaHt11uAAAA
X-Change-ID: 20260520-airoha-eth-lro-a5d1c3631811
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289828-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 687E1589914
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add hardware TCP Large Receive Offload (LRO) support to the airoha_eth
driver, leveraging the EN7581/AN7583 SoC's 8 dedicated LRO hardware queues
mapped to RX queues 24–31. To meet the hardware requirement for contiguous
memory regions, increase the page_pool allocation order to 2 for RX queues
24–31.

Performance comparison between GRO and hw LRO has been carried out using
a 10Gbps NIC:

GRO: ~2.7 Gbps
LRO: ~3.5 Gbps (~30% improvement)

Please note with respect to the previous implementation, page_pool
allocation order has been reduced from 5 to 2.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c  | 202 +++++++++++++++++++++++++++---
 drivers/net/ethernet/airoha/airoha_eth.h  |  23 ++++
 drivers/net/ethernet/airoha/airoha_regs.h |  22 +++-
 3 files changed, 232 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 5a027cc7ffcb..e2c6231ee6a0 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -12,6 +12,7 @@
 #include <net/dst_metadata.h>
 #include <net/page_pool/helpers.h>
 #include <net/pkt_cls.h>
+#include <net/tcp.h>
 #include <uapi/linux/ppp_defs.h>
 
 #include "airoha_regs.h"
@@ -431,6 +432,47 @@ static void airoha_fe_crsn_qsel_init(struct airoha_eth *eth)
 				 CDM_CRSN_QSEL_Q1));
 }
 
+static void airoha_fe_lro_init_rx_queue(struct airoha_eth *eth, int qdma_id,
+					int lro_queue_index, int qid,
+					int nbuf, int buf_size)
+{
+	int id = qdma_id + 1;
+
+	airoha_fe_rmw(eth, REG_CDM_LRO_LIMIT(id),
+		      CDM_LRO_AGG_NUM_MASK | CDM_LRO_AGG_SIZE_MASK,
+		      FIELD_PREP(CDM_LRO_AGG_NUM_MASK, nbuf) |
+		      FIELD_PREP(CDM_LRO_AGG_SIZE_MASK, buf_size));
+	airoha_fe_rmw(eth, REG_CDM_LRO_AGE_TIME(id),
+		      CDM_LRO_AGE_TIME_MASK | CDM_LRO_AGG_TIME_MASK,
+		      FIELD_PREP(CDM_LRO_AGE_TIME_MASK,
+				 AIROHA_RXQ_LRO_MAX_AGE_TIME) |
+		      FIELD_PREP(CDM_LRO_AGG_TIME_MASK,
+				 AIROHA_RXQ_LRO_MAX_AGG_TIME));
+	airoha_fe_rmw(eth, REG_CDM_LRO_RXQ(id, lro_queue_index),
+		      LRO_RXQ_MASK(lro_queue_index),
+		      __field_prep(LRO_RXQ_MASK(lro_queue_index), qid));
+	airoha_fe_set(eth, REG_CDM_LRO_EN(id), BIT(lro_queue_index));
+}
+
+static void airoha_fe_lro_disable(struct airoha_eth *eth, int qdma_id)
+{
+	int i, id = qdma_id + 1;
+
+	airoha_fe_clear(eth, REG_CDM_LRO_LIMIT(id),
+			CDM_LRO_AGG_NUM_MASK | CDM_LRO_AGG_SIZE_MASK);
+	airoha_fe_clear(eth, REG_CDM_LRO_AGE_TIME(id),
+			CDM_LRO_AGE_TIME_MASK | CDM_LRO_AGG_TIME_MASK);
+	airoha_fe_clear(eth, REG_CDM_LRO_EN(id), LRO_RXQ_EN_MASK);
+	for (i = 0; i < AIROHA_MAX_NUM_LRO_QUEUES; i++)
+		airoha_fe_clear(eth, REG_CDM_LRO_RXQ(id, i), LRO_RXQ_MASK(i));
+}
+
+static bool airoha_fe_lro_is_enabled(struct airoha_eth *eth, int qdma_id)
+{
+	return airoha_fe_get(eth, REG_CDM_LRO_EN(qdma_id + 1),
+			     LRO_RXQ_EN_MASK);
+}
+
 static int airoha_fe_init(struct airoha_eth *eth)
 {
 	airoha_fe_maccr_init(eth);
@@ -587,9 +629,78 @@ static int airoha_qdma_get_gdm_port(struct airoha_eth *eth,
 	return port >= ARRAY_SIZE(eth->ports) ? -EINVAL : port;
 }
 
+static int airoha_qdma_lro_rx_process(struct airoha_queue *q,
+				      struct airoha_qdma_desc *desc)
+{
+	u32 msg1 = le32_to_cpu(READ_ONCE(desc->msg1));
+	u32 msg2 = le32_to_cpu(READ_ONCE(desc->msg2));
+	u32 msg3 = le32_to_cpu(READ_ONCE(desc->msg3));
+	bool ipv4 = FIELD_GET(QDMA_ETH_RXMSG_IP4_MASK, msg1);
+	bool ipv6 = FIELD_GET(QDMA_ETH_RXMSG_IP6_MASK, msg1);
+	struct sk_buff *skb = q->skb;
+	u32 th_off, tcp_ack_seq;
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
+		u32 len, desc_ctrl = le32_to_cpu(READ_ONCE(desc->ctrl));
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
+	tcp_ack_seq = le32_to_cpu(READ_ONCE(desc->data));
+
+	th = (struct tcphdr *)(skb->data + th_off);
+	th->ack_seq = cpu_to_be32(tcp_ack_seq);
+	th->window = cpu_to_be16(tcp_win);
+
+	/* Check tcp timestamp option */
+	if (th->doff == (sizeof(*th) + TCPOLEN_TSTAMP_ALIGNED) / 4) {
+		__be32 *topt = (__be32 *)(th + 1);
+
+		if (*topt == cpu_to_be32((TCPOPT_NOP << 24) |
+					 (TCPOPT_NOP << 16) |
+					 (TCPOPT_TIMESTAMP << 8) |
+					 TCPOLEN_TIMESTAMP)) {
+			__le32 tcp_ts_reply = READ_ONCE(desc->tcp_ts_reply);
+
+			put_unaligned_be32(le32_to_cpu(tcp_ts_reply),
+					   topt + 2);
+		}
+	}
+
+	return 0;
+}
+
 static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 {
 	enum dma_data_direction dir = page_pool_get_dma_dir(q->page_pool);
+	bool lro_q = airoha_qdma_is_lro_queue(q);
 	struct airoha_qdma *qdma = q->qdma;
 	struct airoha_eth *eth = qdma->eth;
 	int qid = q - &qdma->q_rx[0];
@@ -636,9 +747,14 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 			__skb_put(q->skb, len);
 			skb_mark_for_recycle(q->skb);
 			q->skb->dev = port->dev;
-			q->skb->protocol = eth_type_trans(q->skb, port->dev);
 			q->skb->ip_summed = CHECKSUM_UNNECESSARY;
 			skb_record_rx_queue(q->skb, qid);
+
+			if (lro_q && (port->dev->features & NETIF_F_LRO) &&
+			    airoha_qdma_lro_rx_process(q, desc) < 0)
+				goto free_frag;
+
+			q->skb->protocol = eth_type_trans(q->skb, port->dev);
 		} else { /* scattered frame */
 			struct skb_shared_info *shinfo = skb_shinfo(q->skb);
 			int nr_frags = shinfo->nr_frags;
@@ -727,23 +843,19 @@ static int airoha_qdma_rx_napi_poll(struct napi_struct *napi, int budget)
 static int airoha_qdma_init_rx_queue(struct airoha_queue *q,
 				     struct airoha_qdma *qdma, int ndesc)
 {
-	const struct page_pool_params pp_params = {
-		.order = 0,
-		.pool_size = 256,
+	struct page_pool_params pp_params = {
 		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
 		.dma_dir = DMA_FROM_DEVICE,
-		.max_len = PAGE_SIZE,
 		.nid = NUMA_NO_NODE,
 		.dev = qdma->eth->dev,
 		.napi = &q->napi,
 	};
+	int pp_order, qid = q - &qdma->q_rx[0], thr;
 	struct airoha_eth *eth = qdma->eth;
-	int qid = q - &qdma->q_rx[0], thr;
 	dma_addr_t dma_addr;
+	bool lro_q;
 
-	q->buf_size = PAGE_SIZE / 2;
 	q->qdma = qdma;
-
 	q->entry = devm_kzalloc(eth->dev, ndesc * sizeof(*q->entry),
 				GFP_KERNEL);
 	if (!q->entry)
@@ -754,6 +866,12 @@ static int airoha_qdma_init_rx_queue(struct airoha_queue *q,
 	if (!q->desc)
 		return -ENOMEM;
 
+	lro_q = airoha_qdma_is_lro_queue(q);
+	pp_order = lro_q ? AIROHA_LRO_PAGE_ORDER : 0;
+	pp_params.order = pp_order;
+	pp_params.pool_size = 256 >> pp_order;
+	pp_params.max_len = PAGE_SIZE << pp_order;
+
 	q->page_pool = page_pool_create(&pp_params);
 	if (IS_ERR(q->page_pool)) {
 		int err = PTR_ERR(q->page_pool);
@@ -762,6 +880,7 @@ static int airoha_qdma_init_rx_queue(struct airoha_queue *q,
 		return err;
 	}
 
+	q->buf_size = pp_params.max_len / (2 * (1 + lro_q));
 	q->ndesc = ndesc;
 	netif_napi_add(eth->napi_dev, &q->napi, airoha_qdma_rx_napi_poll);
 
@@ -1991,6 +2110,63 @@ int airoha_get_fe_port(struct airoha_gdm_port *port)
 	}
 }
 
+static int airoha_dev_set_features(struct net_device *dev,
+				   netdev_features_t features)
+{
+	netdev_features_t diff = dev->features ^ features;
+	struct airoha_gdm_port *port = netdev_priv(dev);
+	struct airoha_qdma *qdma = port->qdma;
+	struct airoha_eth *eth = qdma->eth;
+	int qdma_id = qdma - &eth->qdma[0];
+	int i;
+
+	if (!(diff & NETIF_F_LRO))
+		return 0;
+
+	/* reset LRO configuration */
+	if (features & NETIF_F_LRO) {
+		int lro_queue_index = 0;
+
+		if (airoha_fe_lro_is_enabled(eth, qdma_id))
+			return 0;
+
+		for (i = 0; i < ARRAY_SIZE(qdma->q_rx); i++) {
+			struct airoha_queue *q = &qdma->q_rx[i];
+
+			if (!q->ndesc)
+				continue;
+
+			if (!airoha_qdma_is_lro_queue(q))
+				continue;
+
+			airoha_fe_lro_init_rx_queue(eth, qdma_id,
+						    lro_queue_index, i,
+						    q->page_pool->p.pool_size,
+						    q->buf_size);
+			lro_queue_index++;
+		}
+	} else {
+		for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
+			struct airoha_gdm_port *p = eth->ports[i];
+
+			if (!p)
+				continue;
+
+			if (p->qdma != qdma)
+				continue;
+
+			if (p->dev == dev)
+				continue;
+
+			if (p->dev->features & NETIF_F_LRO)
+				return 0;
+		}
+		airoha_fe_lro_disable(eth, qdma_id);
+	}
+
+	return 0;
+}
+
 static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 				   struct net_device *dev)
 {
@@ -2890,6 +3066,7 @@ static const struct net_device_ops airoha_netdev_ops = {
 	.ndo_stop		= airoha_dev_stop,
 	.ndo_change_mtu		= airoha_dev_change_mtu,
 	.ndo_select_queue	= airoha_dev_select_queue,
+	.ndo_set_features	= airoha_dev_set_features,
 	.ndo_start_xmit		= airoha_dev_xmit,
 	.ndo_get_stats64        = airoha_dev_get_stats64,
 	.ndo_set_mac_address	= airoha_dev_set_macaddr,
@@ -2987,12 +3164,9 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth,
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
 	SET_NETDEV_DEV(dev, eth->dev);
 
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index d3781103abb5..39ab6bdb1f67 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -43,6 +43,17 @@
 	 (_n) == 15 ? 128 :		\
 	 (_n) ==  0 ? 1024 : 16)
 
+#define AIROHA_LRO_PAGE_ORDER		2
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
 
@@ -661,6 +672,18 @@ static inline bool airoha_is_7583(struct airoha_eth *eth)
 	return eth->soc->version == 0x7583;
 }
 
+static inline bool airoha_qdma_is_lro_queue(struct airoha_queue *q)
+{
+	struct airoha_qdma *qdma = q->qdma;
+	int qid = q - &qdma->q_rx[0];
+
+	/* EN7581 SoC supports at most 8 LRO rx queues */
+	BUILD_BUG_ON(hweight32(AIROHA_RXQ_LRO_EN_MASK) >
+		     AIROHA_MAX_NUM_LRO_QUEUES);
+
+	return !!(AIROHA_RXQ_LRO_EN_MASK & BIT(qid));
+}
+
 int airoha_get_fe_port(struct airoha_gdm_port *port);
 bool airoha_is_valid_gdm_port(struct airoha_eth *eth,
 			      struct airoha_gdm_port *port);
diff --git a/drivers/net/ethernet/airoha/airoha_regs.h b/drivers/net/ethernet/airoha/airoha_regs.h
index 436f3c8779c1..dfc786583774 100644
--- a/drivers/net/ethernet/airoha/airoha_regs.h
+++ b/drivers/net/ethernet/airoha/airoha_regs.h
@@ -122,6 +122,20 @@
 #define CDM_CRSN_QSEL_REASON_MASK(_n)	\
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
 #define GDM_PAD_EN_MASK			BIT(28)
 #define GDM_DROP_CRC_ERR_MASK		BIT(23)
@@ -883,9 +897,15 @@
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
base-commit: bf53bf33206137c2337bd8aacf0ef4c348b97a36
change-id: 20260520-airoha-eth-lro-a5d1c3631811

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


