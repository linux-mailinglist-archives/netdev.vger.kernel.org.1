Return-Path: <netdev+bounces-261671-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HlVNDL6oGlXogQAu9opvQ
	(envelope-from <netdev+bounces-261671-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 02:58:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C101B1B47
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 02:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB5B730D5B36
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 01:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A562BE7A7;
	Fri, 27 Feb 2026 01:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="a6hSE6Pa"
X-Original-To: netdev@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C055F2BE05F
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 01:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772157362; cv=none; b=JT5YhmUkkynS70DkqgR6DxaSgXxuUrwl/yJqVGBuP8WO8LDiGgVj6HqzXILT5V2CDeP+UbuWP42hSBK4lVL6rhia6v3zi4l1dGxOoihGwEv5ibgtnPADRF/ndTENMHboxbtQD34iG2VGNiKhbX7Z8J8bONe6afeA+9xmUtcV61o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772157362; c=relaxed/simple;
	bh=8FMWcZoX5yVcUd7NT6EUmCqkXGsL13E+A+2fFKE99Go=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JECvGpJPUyt00Pi2hi5r30DzK682c4tA0+hj3Z6lU0mYA+Wiw73o8ySPwIh4mKhnD32A8NttRRsvbL981nECpCpC7p3S4hx7qMPNw6sjb9bpRQc9mi6UHPzRjQJqMVL7YpbtrMHxErqP06Y9GX71BX1o4kzuxD0ki1jz3iQXJSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=a6hSE6Pa; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772157353; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=oxVTg8fubKUH0SwJRK1ndCG+wysW+CV1TmJChCNUN6s=;
	b=a6hSE6PaLkOTUHKiSaxIFtOopm5sVwYeuYBbaobQotoHkjnqlJWCAVyrwvL/E0X9nFUMrGgJmd2Q+gYVkb5WmtX1JS+svIvciM+I8LlRbCQSbxbHWTMSAqSxbvtDm2mPmjzCnUYnn3gOBnh2kXNf/AWvI5KUck+bhOoFY6d538Q=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WzsdiLT_1772157350 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 27 Feb 2026 09:55:51 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Philo Lu <lulie@linux.alibaba.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Dong Yibo <dong100@mucse.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Dust Li <dust.li@linux.alibaba.com>
Subject: [PATCH net-next v27 6/8] eea: implement packet transmit logic
Date: Fri, 27 Feb 2026 09:55:44 +0800
Message-Id: <20260227015546.47336-7-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20260227015546.47336-1-xuanzhuo@linux.alibaba.com>
References: <20260227015546.47336-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: f713bd6bad2c
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261671-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linux.alibaba.com,linux.dev,mucse.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanzhuo@linux.alibaba.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.990];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.alibaba.com:mid,linux.alibaba.com:dkim,alibaba.com:email]
X-Rspamd-Queue-Id: 35C101B1B47
X-Rspamd-Action: no action

Implement the core logic for transmitting packets in the EEA TX path,
including packet preparation and submission to the underlying transport.

Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
Reviewed-by: Philo Lu <lulie@linux.alibaba.com>
Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/ethernet/alibaba/eea/eea_tx.c | 270 +++++++++++++++++++++-
 1 file changed, 268 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/alibaba/eea/eea_tx.c b/drivers/net/ethernet/alibaba/eea/eea_tx.c
index 259f57674d9f..9b40a6c4eb18 100644
--- a/drivers/net/ethernet/alibaba/eea/eea_tx.c
+++ b/drivers/net/ethernet/alibaba/eea/eea_tx.c
@@ -11,6 +11,11 @@
 #include "eea_pci.h"
 #include "eea_ring.h"
 
+struct eea_sq_free_stats {
+	u64 packets;
+	u64 bytes;
+};
+
 struct eea_tx_meta {
 	struct eea_tx_meta *next;
 
@@ -28,20 +33,281 @@ struct eea_tx_meta {
 	u16 dma_len;
 };
 
+static struct eea_tx_meta *eea_tx_meta_get(struct eea_net_tx *tx)
+{
+	struct eea_tx_meta *meta;
+
+	if (!tx->free)
+		return NULL;
+
+	meta = tx->free;
+	tx->free = meta->next;
+
+	return meta;
+}
+
+static void eea_tx_meta_put_and_unmap(struct eea_net_tx *tx,
+				      struct eea_tx_meta *meta)
+{
+	struct eea_tx_meta *head;
+
+	head = meta;
+
+	while (true) {
+		dma_unmap_single(tx->dma_dev, meta->dma_addr,
+				 meta->dma_len, DMA_TO_DEVICE);
+
+		if (meta->next) {
+			meta = meta->next;
+			continue;
+		}
+
+		break;
+	}
+
+	meta->next = tx->free;
+	tx->free = head;
+}
+
+static void eea_meta_free_xmit(struct eea_net_tx *tx,
+			       struct eea_tx_meta *meta,
+			       int budget,
+			       struct eea_tx_cdesc *desc,
+			       struct eea_sq_free_stats *stats)
+{
+	struct sk_buff *skb = meta->skb;
+
+	if (unlikely((skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) && desc)) {
+		struct skb_shared_hwtstamps ts = {};
+
+		ts.hwtstamp = EEA_DESC_TS(desc) + tx->enet->hw_ts_offset;
+		skb_tstamp_tx(skb, &ts);
+	}
+
+	++stats->packets;
+	stats->bytes += meta->skb->len;
+	napi_consume_skb(meta->skb, budget);
+
+	meta->data = NULL;
+}
+
+static u32 eea_clean_tx(struct eea_net_tx *tx, int budget)
+{
+	struct eea_sq_free_stats stats = {0};
+	struct eea_tx_cdesc *desc;
+	struct eea_tx_meta *meta;
+	int desc_n;
+
+	while ((desc = ering_cq_get_desc(tx->ering))) {
+		meta = &tx->meta[le16_to_cpu(desc->id)];
+
+		if (meta->data) {
+			eea_tx_meta_put_and_unmap(tx, meta);
+			eea_meta_free_xmit(tx, meta, budget, desc, &stats);
+			desc_n = meta->num;
+		} else {
+			netdev_err(tx->enet->netdev,
+				   "tx meta->data is null. id %d num: %d\n",
+				   meta->id, meta->num);
+			desc_n = 1;
+		}
+
+		ering_cq_ack_desc(tx->ering, desc_n);
+	}
+
+	return stats.packets;
+}
+
 int eea_poll_tx(struct eea_net_tx *tx, int budget)
 {
-	/* Empty function; will be implemented in a subsequent commit. */
+	struct eea_net *enet = tx->enet;
+	u32 index = tx - enet->tx;
+	struct netdev_queue *txq;
+	u32 cleaned;
+
+	txq = netdev_get_tx_queue(enet->netdev, index);
+
+	__netif_tx_lock(txq, smp_processor_id());
+
+	cleaned = eea_clean_tx(tx, budget);
+
+	if (netif_tx_queue_stopped(txq) && cleaned > 0)
+		netif_tx_wake_queue(txq);
+
+	__netif_tx_unlock(txq);
+
+	return 0;
+}
+
+static int eea_fill_desc_from_skb(const struct sk_buff *skb,
+				  struct eea_ring *ering,
+				  struct eea_tx_desc *desc)
+{
+	if (skb_is_gso(skb)) {
+		struct skb_shared_info *sinfo = skb_shinfo(skb);
+
+		desc->gso_size = cpu_to_le16(sinfo->gso_size);
+		if (sinfo->gso_type & SKB_GSO_TCPV4)
+			desc->gso_type = EEA_TX_GSO_TCPV4;
+
+		else if (sinfo->gso_type & SKB_GSO_TCPV6)
+			desc->gso_type = EEA_TX_GSO_TCPV6;
+
+		else if (sinfo->gso_type & SKB_GSO_UDP_L4)
+			desc->gso_type = EEA_TX_GSO_UDP_L4;
+
+		else
+			return -EINVAL;
+
+		if (sinfo->gso_type & SKB_GSO_TCP_ECN)
+			desc->gso_type |= EEA_TX_GSO_ECN;
+	} else {
+		desc->gso_type = EEA_TX_GSO_NONE;
+	}
+
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		desc->csum_start = cpu_to_le16(skb_checksum_start_offset(skb));
+		desc->csum_offset = cpu_to_le16(skb->csum_offset);
+	}
+
+	return 0;
+}
+
+static struct eea_tx_meta *eea_tx_desc_fill(struct eea_net_tx *tx,
+					    dma_addr_t addr, u32 len,
+					    bool is_last, void *data, u16 flags)
+{
+	struct eea_tx_meta *meta;
+	struct eea_tx_desc *desc;
+
+	meta = eea_tx_meta_get(tx);
+
+	desc = ering_sq_alloc_desc(tx->ering, meta->id, is_last, flags);
+	desc->addr = cpu_to_le64(addr);
+	desc->len = cpu_to_le16(len);
+
+	meta->next     = NULL;
+	meta->dma_len  = len;
+	meta->dma_addr = addr;
+	meta->data     = data;
+	meta->num      = 1;
+	meta->desc     = desc;
+
+	return meta;
+}
+
+static int eea_tx_add_skb_frag(struct eea_net_tx *tx,
+			       struct eea_tx_meta *head_meta,
+			       const skb_frag_t *frag, bool is_last)
+{
+	u32 len = skb_frag_size(frag);
+	struct eea_tx_meta *meta;
+	dma_addr_t addr;
+
+	addr = skb_frag_dma_map(tx->dma_dev, frag, 0, len, DMA_TO_DEVICE);
+	if (unlikely(dma_mapping_error(tx->dma_dev, addr)))
+		return -ENOMEM;
+
+	meta = eea_tx_desc_fill(tx, addr, len, is_last, NULL, 0);
+
+	meta->next = head_meta->next;
+	head_meta->next = meta;
+
 	return 0;
 }
 
+static int eea_tx_post_skb(struct eea_net_tx *tx, struct sk_buff *skb)
+{
+	const struct skb_shared_info *shinfo = skb_shinfo(skb);
+	u32 hlen = skb_headlen(skb);
+	struct eea_tx_meta *meta;
+	dma_addr_t addr;
+	int i, err;
+	u16 flags;
+
+	addr = dma_map_single(tx->dma_dev, skb->data, hlen, DMA_TO_DEVICE);
+	if (unlikely(dma_mapping_error(tx->dma_dev, addr)))
+		return -ENOMEM;
+
+	flags = skb->ip_summed == CHECKSUM_PARTIAL ? EEA_DESC_F_DO_CSUM : 0;
+
+	meta = eea_tx_desc_fill(tx, addr, hlen, !shinfo->nr_frags, skb, flags);
+
+	if (eea_fill_desc_from_skb(skb, tx->ering, meta->desc))
+		goto err_cancel;
+
+	for (i = 0; i < shinfo->nr_frags; i++) {
+		const skb_frag_t *frag = &shinfo->frags[i];
+		bool is_last = i == (shinfo->nr_frags - 1);
+
+		err = eea_tx_add_skb_frag(tx, meta, frag, is_last);
+		if (err)
+			goto err_cancel;
+	}
+
+	meta->num = shinfo->nr_frags + 1;
+	ering_sq_commit_desc(tx->ering);
+
+	return 0;
+
+err_cancel:
+	ering_sq_cancel(tx->ering);
+	eea_tx_meta_put_and_unmap(tx, meta);
+	meta->data = NULL;
+	return -ENOMEM;
+}
+
+static void eea_tx_kick(struct eea_net_tx *tx)
+{
+	ering_kick(tx->ering);
+}
+
 netdev_tx_t eea_tx_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
-	/* Empty function; will be implemented in a subsequent commit. */
+	struct eea_net *enet = netdev_priv(netdev);
+	int qnum = skb_get_queue_mapping(skb);
+	struct eea_net_tx *tx = &enet->tx[qnum];
+	struct netdev_queue *txq;
+	int err, n;
+
+	txq = netdev_get_tx_queue(netdev, qnum);
+
+	skb_tx_timestamp(skb);
+
+	err = eea_tx_post_skb(tx, skb);
+	if (unlikely(err))
+		dev_kfree_skb_any(skb);
+
+	/* NETDEV_TX_BUSY is expensive. So stop advancing the TX queue. */
+	n = MAX_SKB_FRAGS + 1;
+	netif_txq_maybe_stop(txq, tx->ering->num_free, n, n);
+
+	if (!netdev_xmit_more() || netif_xmit_stopped(txq))
+		eea_tx_kick(tx);
+
 	return NETDEV_TX_OK;
 }
 
 static void eea_free_meta(struct eea_net_tx *tx, struct eea_net_cfg *cfg)
 {
+	struct eea_sq_free_stats stats = {0};
+	struct eea_tx_meta *meta;
+	int i;
+
+	while ((meta = eea_tx_meta_get(tx)))
+		meta->skb = NULL;
+
+	for (i = 0; i < cfg->tx_ring_depth; i++) {
+		meta = &tx->meta[i];
+
+		if (!meta->skb)
+			continue;
+
+		eea_tx_meta_put_and_unmap(tx, meta);
+
+		eea_meta_free_xmit(tx, meta, 0, NULL, &stats);
+	}
+
 	kvfree(tx->meta);
 	tx->meta = NULL;
 }
-- 
2.32.0.3.g01195cf9f


