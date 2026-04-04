Return-Path: <netdev+bounces-275374-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UL7TGLIX0WlfFAcAu9opvQ
	(envelope-from <netdev+bounces-275374-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 15:52:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B772039B446
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 15:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 86E4B3017517
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 13:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5472346E4A;
	Sat,  4 Apr 2026 13:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ixQyZMWN"
X-Original-To: netdev@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D08283CB5
	for <netdev@vger.kernel.org>; Sat,  4 Apr 2026 13:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775310721; cv=none; b=mtzRC2TRxsEx9EKr/3x/DH9iA4aYQn5EDzIMrt6Ycyi5KOh/DC5KW6bQ1e/DEvu0DsywLJnGnd5ta4ZMjpLCO0rCR/WnKohbYeLmX48f/eXfiNMm87vlIpPb8Pz4FKwZ469gBIXjtiktyfCKtZz00cQuzDwpPd1VlH/CJj7Lbhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775310721; c=relaxed/simple;
	bh=58UJCwOFUzot2TxpSkmjdkg2HhSIkFrCIcpw6rR1fQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=anb17pe9c7Sm7QQ3LjDksdvxrS79hj4/dFkVJh7OXx4HkadAEqh41aSPS8P2gIdyttgpH5AvTmi2tKhi4BGM6Zy8Vb6xGO8fNfyhluTWyt8mjO3FRXWC1R7DKZWu/Y8UC5dWGwzLxvZHZhbl3W8qj2qm2cHLekK1+MyYKSPwAWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ixQyZMWN; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775310711; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=7G+n+qUDNDpju3O2SvlD2HZOTGi7kf6hy9JirqeJqTk=;
	b=ixQyZMWNsky17UfLzeMU2N1fdOikSbrQVqVp81KPyOxpNo3jEAT/diNCgJvRVJOajPC/ABK0n+c+hrpFaaP6ks+C5e1yg/cXCX9tNYQ7E7RIib0Zta6fFO2yROK/ox5dDJIAzv23R8Tcypnn+Upvls0nbYhhFZKXkk44yocrp4k=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0X0ND9J4_1775310709;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X0ND9J4_1775310709 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 04 Apr 2026 21:51:50 +0800
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
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Dong Yibo <dong100@mucse.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Dust Li <dust.li@linux.alibaba.com>
Subject: [PATCH net-next v37 6/8] eea: implement packet transmit logic
Date: Sat,  4 Apr 2026 21:51:42 +0800
Message-Id: <20260404135144.33166-7-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20260404135144.33166-1-xuanzhuo@linux.alibaba.com>
References: <20260404135144.33166-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 9bff4ab70b04
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-275374-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:dkim,linux.alibaba.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,alibaba.com:email]
X-Rspamd-Queue-Id: B772039B446
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implement the core logic for transmitting packets in the EEA TX path,
including packet preparation and submission to the underlying transport.

Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
Reviewed-by: Philo Lu <lulie@linux.alibaba.com>
Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/ethernet/alibaba/eea/eea_net.c |   8 +
 drivers/net/ethernet/alibaba/eea/eea_tx.c  | 288 ++++++++++++++++++++-
 2 files changed, 293 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.c b/drivers/net/ethernet/alibaba/eea/eea_net.c
index 095fcbf71ee9..9c20cfb7caeb 100644
--- a/drivers/net/ethernet/alibaba/eea/eea_net.c
+++ b/drivers/net/ethernet/alibaba/eea/eea_net.c
@@ -714,6 +714,12 @@ int eea_net_probe(struct eea_device *edev)
 
 	eea_update_ts_off(edev, enet);
 
+	netif_carrier_off(enet->netdev);
+
+	err = register_netdev(enet->netdev);
+	if (err)
+		goto err_reset_dev;
+
 	netdev_dbg(enet->netdev, "eea probe success.\n");
 
 	return 0;
@@ -766,6 +772,8 @@ void eea_net_remove(struct eea_device *edev, bool ha)
 		return;
 	}
 
+	unregister_netdev(netdev);
+
 	if (!enet->wait_pci_ready) {
 		eea_device_reset(edev);
 		eea_destroy_adminq(enet);
diff --git a/drivers/net/ethernet/alibaba/eea/eea_tx.c b/drivers/net/ethernet/alibaba/eea/eea_tx.c
index d247e658385b..8a8f5ecafca3 100644
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
 
@@ -28,21 +33,298 @@ struct eea_tx_meta {
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
+		if (head == meta)
+			dma_unmap_single(tx->dma_dev, meta->dma_addr,
+					 meta->dma_len, DMA_TO_DEVICE);
+		else
+			dma_unmap_page(tx->dma_dev, meta->dma_addr,
+				       meta->dma_len, DMA_TO_DEVICE);
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
+	u16 id;
+
+	while ((desc = ering_cq_get_desc(tx->ering))) {
+		id = le16_to_cpu(desc->id);
+		if (unlikely(id >= tx->ering->num)) {
+			netdev_err(tx->enet->netdev, "tx invalid id %d\n", id);
+			ering_cq_ack_desc(tx->ering, 1);
+			continue;
+		}
+
+		meta = &tx->meta[id];
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
+
+	txq = netdev_get_tx_queue(enet->netdev, index);
+
+	__netif_tx_lock(txq, smp_processor_id());
+
+	eea_clean_tx(tx, budget);
+
+	if (netif_tx_queue_stopped(txq) &&
+	    tx->ering->num_free >= MAX_SKB_FRAGS + 1)
+		netif_tx_wake_queue(txq);
+
+	__netif_tx_unlock(txq);
+
 	return 0;
 }
 
+static int eea_fill_desc_from_skb(const struct sk_buff *skb,
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
+
+	/* The len here is a u16, but it is safe. Since eea does not support BIG
+	 * TCP, the maximum GSO size is 64KB. Therefore, the size of a single
+	 * skb buffer will not exceed the range of a u16.
+	 */
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
+	return 0;
+}
+
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
+	err = eea_fill_desc_from_skb(skb, meta->desc);
+	if (err)
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
+	return err;
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
-	dev_kfree_skb_any(skb);
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


