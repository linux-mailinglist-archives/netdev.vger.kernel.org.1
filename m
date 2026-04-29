Return-Path: <netdev+bounces-282218-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMrNMF1v8WkIgwEAu9opvQ
	(envelope-from <netdev+bounces-282218-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 04:39:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED5B48E620
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 04:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD69130B9A03
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 02:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C608F385533;
	Wed, 29 Apr 2026 02:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="B3Y1T/FE"
X-Original-To: netdev@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A13385523
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 02:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777430257; cv=none; b=DUFVgbcRDXd+UNVXMNB3VllvkvD+q9i8dZm9lT8bZah9HIrtvCVcM5DTBBDvMZF4wQY0tq4JOdxfexXIZF+Wnaxo/u0NUlpXDjyA6+KUolC3Q730J4nfyUtxsasjvEm0QdmvZP/ryDx0v8sp/KAjtffTMeAMOIMKlb9XJiwLVA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777430257; c=relaxed/simple;
	bh=kqE92QZV7M9AlhMYo57W4A4rIcsEp42XqR4UjaJFRq0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UeAdvmh1o4T2/iFkEIA8A7x3zC+AWmXwsapWaHT4Rmtzhp4czZ+ZgJSqJxlKP2+4RmhqqFW7WHg5+5qHCxqXWCsluHnblFemjumF99WYJJkXcksbQE4nA1rueiHZc79ufFxxxUW4oCQduJV2dkdYJopBrJwfw2dbn7A8Hn5RAmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=B3Y1T/FE; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1777430253; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=GRcixgFZVXl7D0Bd15AN6HL9txSNDN7kqVzVGRWH8sE=;
	b=B3Y1T/FESOt4VP676uxW0Y5CJ3MCMEeSfS11rVsGL1JbLHY5B0U0qSULLxP3yBGkk/9hJMR8bZd8DRTeBzQ3hu9dDrhmYs+cj/k6t5SHVQdg/sv3jLLOnmhfTAlHTYYAKuyUNqsqooP6oO0B/s2706RkYJrKzs0PMJLPOqcqJVs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0X1w.JzL_1777430251;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X1w.JzL_1777430251 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 29 Apr 2026 10:37:32 +0800
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
	Mingyu Wang <25181214217@stu.xidian.edu.cn>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Dust Li <dust.li@linux.alibaba.com>
Subject: [PATCH net-next v41 6/7] eea: implement packet transmit logic
Date: Wed, 29 Apr 2026 10:37:25 +0800
Message-Id: <20260429023726.100908-7-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20260429023726.100908-1-xuanzhuo@linux.alibaba.com>
References: <20260429023726.100908-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 5a28192679d2
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3ED5B48E620
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-282218-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linux.alibaba.com,linux.dev,mucse.com,stu.xidian.edu.cn,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanzhuo@linux.alibaba.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:dkim,linux.alibaba.com:mid,alibaba.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Implement the core logic for transmitting packets in the EEA TX path,
including packet preparation and submission to the underlying transport.

Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
Reviewed-by: Philo Lu <lulie@linux.alibaba.com>
Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/ethernet/alibaba/eea/eea_net.c |   9 +
 drivers/net/ethernet/alibaba/eea/eea_tx.c  | 367 ++++++++++++++++++++-
 2 files changed, 372 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.c b/drivers/net/ethernet/alibaba/eea/eea_net.c
index 7202e248249f..87fcf675e21d 100644
--- a/drivers/net/ethernet/alibaba/eea/eea_net.c
+++ b/drivers/net/ethernet/alibaba/eea/eea_net.c
@@ -725,6 +725,12 @@ int eea_net_probe(struct eea_device *edev)
 
 	eea_update_ts_off(edev, enet);
 
+	netif_carrier_off(enet->netdev);
+
+	err = register_netdev(enet->netdev);
+	if (err)
+		goto err_reset_dev;
+
 	netdev_dbg(enet->netdev, "eea probe success.\n");
 
 	/* Queue TX/RX implementation is still in progress. register_netdev is
@@ -781,6 +787,8 @@ void eea_net_remove(struct eea_device *edev, bool ha)
 		return;
 	}
 
+	unregister_netdev(netdev);
+
 	if (!enet->wait_pci_ready) {
 		eea_device_reset(edev);
 		eea_destroy_adminq(enet);
@@ -801,6 +809,7 @@ void eea_net_shutdown(struct eea_device *edev)
 	rtnl_lock();
 
 	netif_device_detach(netdev);
+	dev_close(netdev);
 
 	if (!enet->wait_pci_ready) {
 		eea_device_reset(edev);
diff --git a/drivers/net/ethernet/alibaba/eea/eea_tx.c b/drivers/net/ethernet/alibaba/eea/eea_tx.c
index b33e37c0160f..f3b967f33b9b 100644
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
 
@@ -26,23 +31,377 @@ struct eea_tx_meta {
 	dma_addr_t dma_addr;
 	struct eea_tx_desc *desc;
 	u32 dma_len;
+	bool unmap;
+	bool unmap_single;
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
+		if (meta->unmap) {
+			if (meta->unmap_single)
+				dma_unmap_single(tx->dma_dev, meta->dma_addr,
+						 meta->dma_len, DMA_TO_DEVICE);
+			else
+				dma_unmap_page(tx->dma_dev, meta->dma_addr,
+					       meta->dma_len, DMA_TO_DEVICE);
+		}
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
+	napi_consume_skb(meta->skb, budget);
+
+	meta->data = NULL;
+}
+
+static int eea_clean_tx(struct eea_net_tx *tx, int budget)
+{
+	struct eea_sq_free_stats stats = {0};
+	struct eea_tx_cdesc *desc;
+	struct eea_tx_meta *meta;
+	int desc_n;
+	u16 id;
+
+	while (stats.packets < budget) {
+		desc = ering_cq_get_desc(tx->ering);
+		if (!desc)
+			break;
+
+		id = le16_to_cpu(desc->id);
+		if (unlikely(id >= tx->ering->num)) {
+			if (net_ratelimit())
+				netdev_err(tx->enet->netdev, "tx invalid id %d\n",
+					   id);
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
+			if (net_ratelimit())
+				netdev_err(tx->enet->netdev,
+					   "tx meta->data is null. id %d num: %d\n",
+					   meta->id, meta->num);
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
-	return budget;
+	struct eea_net *enet = tx->enet;
+	u32 index = tx - enet->tx;
+	struct netdev_queue *txq;
+	int num;
+
+	txq = netdev_get_tx_queue(enet->netdev, index);
+
+	__netif_tx_lock(txq, smp_processor_id());
+
+	num = eea_clean_tx(tx, budget);
+
+	if (netif_tx_queue_stopped(txq) &&
+	    tx->ering->num_free >= MAX_SKB_FRAGS + 2)
+		netif_tx_wake_queue(txq);
+
+	__netif_tx_unlock(txq);
+
+	return num;
+}
+
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
+static struct eea_tx_meta *__eea_tx_desc_fill(struct eea_net_tx *tx,
+					      struct eea_tx_meta *head_meta,
+					      dma_addr_t addr, u32 data_len,
+					      u32 dma_len, bool last,
+					      void *data, u16 flags,
+					      bool unmap)
+{
+	struct eea_tx_meta *meta;
+	struct eea_tx_desc *desc;
+
+	meta = eea_tx_meta_get(tx);
+
+	desc = ering_sq_alloc_desc(tx->ering, meta->id, last, flags);
+	desc->addr = cpu_to_le64(addr);
+	desc->len = cpu_to_le16(data_len);
+
+	meta->next     = NULL;
+	meta->dma_len  = dma_len;
+	meta->dma_addr = addr;
+	meta->data     = data;
+	meta->num      = 1;
+	meta->desc     = desc;
+	meta->unmap    = unmap;
+	meta->unmap_single = false;
+
+	if (head_meta) {
+		meta->next = head_meta->next;
+		head_meta->next = meta;
+		++head_meta->num;
+	}
+
+	return meta;
+}
+
+static struct eea_tx_meta *eea_tx_desc_fill(struct eea_net_tx *tx,
+					    struct eea_tx_meta *head_meta,
+					    dma_addr_t addr, u32 length,
+					    bool is_last, void *data, u16 flags)
+{
+	struct eea_tx_meta *meta;
+	u16 len, last;
+
+	/* Since eea does not support BIG TCP, the maximum GSO size is capped at
+	 * 64KB. Consequently, a single skb buffer (head or fragment) will not
+	 * require more than two descriptors
+	 */
+	if (length > USHRT_MAX) {
+		len = USHRT_MAX;
+		last = false;
+	} else {
+		len = length;
+		last = is_last;
+	}
+
+	meta = __eea_tx_desc_fill(tx, head_meta, addr, len, length,
+				  last, data, flags, true);
+
+	if (length > USHRT_MAX) {
+		if (!head_meta)
+			head_meta = meta;
+
+		addr += USHRT_MAX;
+		len = length - USHRT_MAX;
+
+		__eea_tx_desc_fill(tx, head_meta, addr, len, 0, is_last,
+				   NULL, 0, false);
+	}
+
+	return meta;
+}
+
+static int eea_tx_add_skb_frag(struct eea_net_tx *tx,
+			       struct eea_tx_meta *head_meta,
+			       const skb_frag_t *frag, bool is_last)
+{
+	u32 len = skb_frag_size(frag);
+	dma_addr_t addr;
+
+	addr = skb_frag_dma_map(tx->dma_dev, frag, 0, len, DMA_TO_DEVICE);
+	if (unlikely(dma_mapping_error(tx->dma_dev, addr)))
+		return -ENOMEM;
+
+	eea_tx_desc_fill(tx, head_meta, addr, len, is_last, NULL, 0);
+
+	return 0;
+}
+
+static int eea_tx_post_skb(struct eea_net_tx *tx, struct sk_buff *skb)
+{
+	const struct skb_shared_info *shinfo = skb_shinfo(skb);
+	u32 hlen = skb_headlen(skb);
+	struct eea_tx_meta *meta;
+	const skb_frag_t *frag;
+	dma_addr_t addr;
+	u32 len = hlen;
+	int i, err;
+	u16 flags;
+	bool last;
+
+	if (len) {
+		addr = dma_map_single(tx->dma_dev, skb->data, len,
+				      DMA_TO_DEVICE);
+		if (unlikely(dma_mapping_error(tx->dma_dev, addr)))
+			return -ENOMEM;
+
+		last = !shinfo->nr_frags;
+		i = 0;
+	} else {
+		/* The net stack will never submit an skb with an skb->len of
+		 * 0. If the head len is 0, the number of frags must be greater
+		 * than 0.
+		 */
+		frag = &shinfo->frags[0];
+		len = skb_frag_size(frag);
+
+		addr = skb_frag_dma_map(tx->dma_dev, frag, 0, len,
+					DMA_TO_DEVICE);
+		if (unlikely(dma_mapping_error(tx->dma_dev, addr)))
+			return -ENOMEM;
+
+		last = shinfo->nr_frags == 1;
+		i = 1;
+	}
+
+	flags = skb->ip_summed == CHECKSUM_PARTIAL ? EEA_DESC_F_DO_CSUM : 0;
+
+	meta = eea_tx_desc_fill(tx, NULL, addr, len, last, skb, flags);
+	meta->unmap_single = !!hlen;
+
+	err = eea_fill_desc_from_skb(skb, meta->desc);
+	if (err)
+		goto err_cancel;
+
+	for (; i < shinfo->nr_frags; i++) {
+		frag = &shinfo->frags[i];
+		bool is_last = i == (shinfo->nr_frags - 1);
+
+		err = eea_tx_add_skb_frag(tx, meta, frag, is_last);
+		if (err)
+			goto err_cancel;
+	}
+
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
 }
 
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
+	err = eea_tx_post_skb(tx, skb);
+	if (unlikely(err))
+		dev_kfree_skb_any(skb);
+	else
+		skb_tx_timestamp(skb);
+
+	/* NETDEV_TX_BUSY is expensive. So stop advancing the TX queue.
+	 * MAX_SKB_FRAGS + 1: Covers the skb linear head and all paged fragments
+	 * 1: Extra slot for a head or fragment that exceeds 64KB.
+	 */
+	n = MAX_SKB_FRAGS + 2;
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


