Return-Path: <netdev+bounces-252573-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MODkGZ/McmlgpgAAu9opvQ
	(envelope-from <netdev+bounces-252573-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 02:19:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8036EFC5
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 02:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAFFE300FEC5
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 01:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E9B36A035;
	Fri, 23 Jan 2026 01:19:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-171.mail.aliyun.com (out28-171.mail.aliyun.com [115.124.28.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4082FD7A0;
	Fri, 23 Jan 2026 01:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769131141; cv=none; b=t08IpH0YM9uIVpPARBmNq9B/gmeYFfWLY23DkPhdgWwEGj06ZyM6WJghPkG6ZTcXYN0TUPttB8dE96MKM4dJhZC2zWJsAeNDKNtpZ8NrNhMkTYawGrFTKwz2Brwk4tddjy+81G6kTn7IZNdG6NWMRSnflGB4w8qbt/yJO2QyBvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769131141; c=relaxed/simple;
	bh=bf1FFoEWu3mSM+DR+3uZhxrCZwDXrfuIDKWMW7uv8lg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AU4bGo/36DH5UJ2n/VeDtphLi/tdnwnrrifEwp0x/tQdwnlo4hZr7UsiCcfmDX5UFFWqNur2GAQTySAqpd39DtZ9qQM0k0KiIKInD5F0yqDyQvhxm53OIVAgcGqWUa8tDJTTXuuQAQjTkXQZEotnpz0AQlRKGZvSp1VIThpWOcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.gDSYWAW_1769131130 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 23 Jan 2026 09:18:51 +0800
From: "illusion.wang" <illusion.wang@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	illusion.wang@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	corbet@lwn.net,
	kuba@kernel.org,
	linux-doc@vger.kernel.org,
	lorenzo@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com,
	hawk@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	sdf@fomichev.me,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	edumazet@google.com,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 net-next 10/15] net/nebula-matrix: add txrx interrupt handling logic
Date: Fri, 23 Jan 2026 09:17:47 +0800
Message-ID: <20260123011804.31263-11-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260123011804.31263-1-illusion.wang@nebula-matrix.com>
References: <20260123011804.31263-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252573-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[nebula-matrix.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,lwn.net,kernel.org,vger.kernel.org,redhat.com,linux.dev,fomichev.me,iogearbox.net,gmail.com,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	FROM_NEQ_ENVFROM(0.00)[illusion.wang@nebula-matrix.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[22];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nebula-matrix.com:mid,nebula-matrix.com:email,illusion.wang:url]
X-Rspamd-Queue-Id: BE8036EFC5
X-Rspamd-Action: no action

This patch implements the TX and RX interrupt handling logic:

Transmit (TX) Handling:
nbl_res_txrx_clean_tx_irq: Cleans up completed transmit descriptors,
frees resources, and updates statistics.
Checks if descriptors are used (via nbl_ring_desc_used).
Updates TX packet count, byte count, and descriptor count.
Wakes up the TX queue if necessary (netif_wake_subqueue).
Receive (RX) Handling:
nbl_res_txrx_clean_rx_irq: Processes received packets, constructs
sk_buff, and passes them to the upper layer.
Checks if descriptors are used.
Retrieves packet length from the descriptor and gets the RX buffer.
Constructs sk_buff (nbl_construct_skb), handles checksum (nbl_rx_csum),
and VLAN tags (nbl_rx_vlan_pop).
Reallocates RX buffers if necessary (nbl_alloc_rx_bufs).

Signed-off-by: illusion.wang <illusion.wang@nebula-matrix.com>
---
 .../nebula-matrix/nbl/nbl_hw/nbl_txrx.c       | 371 ++++++++++++++++++
 1 file changed, 371 insertions(+)

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_txrx.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_txrx.c
index 939166a074e2..7008402751a7 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_txrx.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_txrx.c
@@ -835,6 +835,166 @@ static void nbl_res_txrx_stop_rx_ring(void *priv, u8 ring_index)
 	nbl_debug(res_mgt->common, "Stop rx ring %d", ring_index);
 }
 
+static __always_inline bool nbl_ring_desc_used(struct nbl_ring_desc *ring_desc,
+					       bool used_wrap_counter)
+{
+	bool avail;
+	bool used;
+	u16 flags;
+
+	flags = le16_to_cpu(ring_desc->flags);
+	avail = !!(flags & BIT(NBL_PACKED_DESC_F_AVAIL));
+	used = !!(flags & BIT(NBL_PACKED_DESC_F_USED));
+
+	return avail == used && used == used_wrap_counter;
+}
+
+static int nbl_res_txrx_clean_tx_irq(struct nbl_res_tx_ring *tx_ring)
+{
+	struct nbl_tx_buffer *tx_buffer;
+	struct nbl_ring_desc *tx_desc;
+	unsigned int i = tx_ring->next_to_clean;
+	unsigned int total_tx_pkts = 0;
+	unsigned int total_tx_bytes = 0;
+	unsigned int total_tx_descs = 0;
+	int count = 64;
+
+	tx_buffer = NBL_TX_BUF(tx_ring, i);
+	tx_desc = NBL_TX_DESC(tx_ring, i);
+	i -= tx_ring->desc_num;
+
+	do {
+		struct nbl_ring_desc *end_desc = tx_buffer->next_to_watch;
+
+		if (!end_desc)
+			break;
+
+		/* smp_rmb */
+		smp_rmb();
+
+		if (!nbl_ring_desc_used(tx_desc, tx_ring->used_wrap_counter))
+			break;
+
+		total_tx_pkts += tx_buffer->gso_segs;
+		total_tx_bytes += tx_buffer->bytecount;
+
+		while (true) {
+			total_tx_descs++;
+			nbl_unmap_and_free_tx_resource(tx_ring, tx_buffer, true,
+						       true);
+			if (tx_desc == end_desc)
+				break;
+			i++;
+			tx_buffer++;
+			tx_desc++;
+			if (unlikely(!i)) {
+				i -= tx_ring->desc_num;
+				tx_buffer = NBL_TX_BUF(tx_ring, 0);
+				tx_desc = NBL_TX_DESC(tx_ring, 0);
+				tx_ring->used_wrap_counter ^= 1;
+			}
+		}
+
+		tx_buffer++;
+		tx_desc++;
+		i++;
+		if (unlikely(!i)) {
+			i -= tx_ring->desc_num;
+			tx_buffer = NBL_TX_BUF(tx_ring, 0);
+			tx_desc = NBL_TX_DESC(tx_ring, 0);
+			tx_ring->used_wrap_counter ^= 1;
+		}
+
+		prefetch(tx_desc);
+
+	} while (--count);
+
+	i += tx_ring->desc_num;
+
+	tx_ring->next_to_clean = i;
+
+	u64_stats_update_begin(&tx_ring->syncp);
+	tx_ring->stats.bytes += total_tx_bytes;
+	tx_ring->stats.packets += total_tx_pkts;
+	tx_ring->stats.descs += total_tx_descs;
+	u64_stats_update_end(&tx_ring->syncp);
+	if (nbl_txrx_within_vsi(&tx_ring->vsi_info[NBL_VSI_DATA],
+				tx_ring->queue_index))
+		netdev_tx_completed_queue(txring_txq(tx_ring), total_tx_pkts,
+					  total_tx_bytes);
+
+#define TX_WAKE_THRESHOLD (DESC_NEEDED * 2)
+	if (unlikely(total_tx_pkts && netif_carrier_ok(tx_ring->netdev) &&
+		     nbl_txrx_within_vsi(&tx_ring->vsi_info[NBL_VSI_DATA],
+					 tx_ring->queue_index) &&
+		    (nbl_unused_tx_desc_count(tx_ring) >= TX_WAKE_THRESHOLD))) {
+		/* Make sure that anybody stopping the queue after this
+		 * sees the new next_to_clean.
+		 */
+		smp_mb();
+
+		if (__netif_subqueue_stopped(tx_ring->netdev,
+					     tx_ring->queue_index)) {
+			netif_wake_subqueue(tx_ring->netdev,
+					    tx_ring->queue_index);
+			dev_dbg(NBL_RING_TO_DEV(tx_ring), "wake queue %u\n",
+				tx_ring->queue_index);
+		}
+	}
+
+	return count;
+}
+
+static void nbl_rx_csum(struct nbl_res_rx_ring *rx_ring, struct sk_buff *skb,
+			struct nbl_rx_extend_head *hdr)
+{
+	skb->ip_summed = CHECKSUM_NONE;
+	skb_checksum_none_assert(skb);
+
+	/* if user disable rx csum Offload, then stack verify the rx csum */
+	if (!(rx_ring->netdev->features & NETIF_F_RXCSUM))
+		return;
+
+	if (!hdr->checksum_status)
+		return;
+
+	if (hdr->error_code) {
+		rx_ring->rx_stats.rx_csum_errors++;
+		return;
+	}
+
+	skb->ip_summed = CHECKSUM_UNNECESSARY;
+	rx_ring->rx_stats.rx_csum_packets++;
+}
+
+static __always_inline void nbl_add_rx_frag(struct nbl_rx_buffer *rx_buffer,
+					    struct sk_buff *skb,
+					    unsigned int size)
+{
+	page_ref_inc(rx_buffer->di->page);
+	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, rx_buffer->di->page,
+			rx_buffer->offset, size, rx_buffer->size);
+}
+
+static __always_inline int nbl_rx_vlan_pop(struct nbl_res_rx_ring *rx_ring,
+					   struct sk_buff *skb)
+{
+	struct vlan_ethhdr *veth = (struct vlan_ethhdr *)skb->data;
+
+	if (!rx_ring->vlan_proto)
+		return 0;
+
+	if (rx_ring->vlan_proto != ntohs(veth->h_vlan_proto) ||
+	    (rx_ring->vlan_tci & VLAN_VID_MASK) !=
+		    (ntohs(veth->h_vlan_TCI) & VLAN_VID_MASK))
+		return 1;
+
+	memmove(skb->data + VLAN_HLEN, skb->data, 2 * ETH_ALEN);
+	__skb_pull(skb, VLAN_HLEN);
+
+	return 0;
+}
+
 static void nbl_txrx_register_vsi_ring(void *priv, u16 vsi_index,
 				       u16 ring_offset, u16 ring_num)
 {
@@ -845,6 +1005,92 @@ static void nbl_txrx_register_vsi_ring(void *priv, u16 vsi_index,
 	txrx_mgt->vsi_info[vsi_index].ring_num = ring_num;
 }
 
+/*
+ * Current version support merging multiple descriptor for one packet.
+ */
+static struct sk_buff *nbl_construct_skb(struct nbl_res_rx_ring *rx_ring,
+					 struct napi_struct *napi,
+					 struct nbl_rx_buffer *rx_buf,
+					 unsigned int size)
+{
+	struct sk_buff *skb;
+	char *p, *buf;
+	int tailroom,
+		shinfo_size = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+	unsigned int truesize = rx_buf->size;
+	unsigned int headlen;
+
+	p = page_address(rx_buf->di->page) + rx_buf->offset;
+	buf = p - NBL_RX_PAD;
+	p += NBL_BUFFER_HDR_LEN;
+	tailroom = truesize - size - NBL_RX_PAD;
+	size -= NBL_BUFFER_HDR_LEN;
+
+	if (rx_ring->linear_skb && tailroom >= shinfo_size) {
+		skb = build_skb(buf, truesize);
+		if (unlikely(!skb))
+			return NULL;
+
+		page_ref_inc(rx_buf->di->page);
+		skb_reserve(skb, p - buf);
+		skb_put(skb, size);
+		goto ok;
+	}
+
+	skb = napi_alloc_skb(napi, NBL_RX_HDR_SIZE);
+	if (unlikely(!skb))
+		return NULL;
+
+	headlen = size;
+	if (headlen > NBL_RX_HDR_SIZE)
+		headlen = eth_get_headlen(skb->dev, p, NBL_RX_HDR_SIZE);
+
+	memcpy(__skb_put(skb, headlen), p, ALIGN(headlen, sizeof(long)));
+	size -= headlen;
+	if (size) {
+		page_ref_inc(rx_buf->di->page);
+		skb_add_rx_frag(skb, 0, rx_buf->di->page,
+				rx_buf->offset + NBL_BUFFER_HDR_LEN + headlen,
+				size, truesize);
+	}
+ok:
+	skb_record_rx_queue(skb, rx_ring->queue_index);
+
+	return skb;
+}
+
+static __always_inline struct nbl_rx_buffer *
+nbl_get_rx_buf(struct nbl_res_rx_ring *rx_ring)
+{
+	struct nbl_rx_buffer *rx_buf;
+
+	rx_buf = NBL_RX_BUF(rx_ring, rx_ring->next_to_clean);
+	prefetchw(rx_buf->di->page);
+
+	dma_sync_single_range_for_cpu(rx_ring->dma_dev, rx_buf->di->addr,
+				      rx_buf->offset, rx_ring->buf_len,
+				      DMA_FROM_DEVICE);
+
+	return rx_buf;
+}
+
+static __always_inline void nbl_put_rx_buf(struct nbl_res_rx_ring *rx_ring,
+					   struct nbl_rx_buffer *rx_buf)
+{
+	u16 ntc = rx_ring->next_to_clean + 1;
+
+	/* if at the end of the ring, reset ntc and flip used wrap bit */
+	if (unlikely(ntc >= rx_ring->desc_num)) {
+		ntc = 0;
+		rx_ring->used_wrap_counter ^= 1;
+	}
+
+	rx_ring->next_to_clean = ntc;
+	prefetch(NBL_RX_DESC(rx_ring, ntc));
+
+	nbl_put_rx_frag(rx_ring, rx_buf, true);
+}
+
 static __always_inline int nbl_maybe_stop_tx(struct nbl_res_tx_ring *tx_ring,
 					     unsigned int size)
 {
@@ -874,6 +1120,130 @@ static __always_inline int nbl_maybe_stop_tx(struct nbl_res_tx_ring *tx_ring,
 	return 0;
 }
 
+static int nbl_res_txrx_clean_rx_irq(struct nbl_res_rx_ring *rx_ring,
+				     struct napi_struct *napi, int budget)
+{
+	struct nbl_ring_desc *rx_desc;
+	struct nbl_rx_buffer *rx_buf;
+	struct nbl_rx_extend_head *hdr;
+	struct sk_buff *skb = NULL;
+	unsigned int total_rx_pkts = 0;
+	unsigned int total_rx_bytes = 0;
+	unsigned int size;
+	u32 rx_multicast_packets = 0;
+	u32 rx_unicast_packets = 0;
+	u16 desc_count = 0;
+	u16 num_buffers = 0;
+	u16 cleaned_count = nbl_unused_rx_desc_count(rx_ring);
+	bool failure = 0;
+	bool drop = 0;
+	u16 tmp;
+
+	while (likely(total_rx_pkts < budget)) {
+		rx_desc = NBL_RX_DESC(rx_ring, rx_ring->next_to_clean);
+		if (!nbl_ring_desc_used(rx_desc, rx_ring->used_wrap_counter))
+			break;
+
+		dma_rmb();
+		size = le32_to_cpu(rx_desc->len);
+		rx_buf = nbl_get_rx_buf(rx_ring);
+
+		desc_count++;
+
+		if (skb) {
+			nbl_add_rx_frag(rx_buf, skb, size);
+		} else {
+			hdr = page_address(rx_buf->di->page) + rx_buf->offset;
+			net_prefetch(hdr);
+			skb = nbl_construct_skb(rx_ring, napi, rx_buf, size);
+			if (unlikely(!skb)) {
+				rx_ring->rx_stats.rx_alloc_buf_err_cnt++;
+				break;
+			}
+
+			num_buffers = (u16)hdr->num_buffers;
+			nbl_rx_csum(rx_ring, skb, hdr);
+			drop = nbl_rx_vlan_pop(rx_ring, skb);
+		}
+
+		cleaned_count++;
+		nbl_put_rx_buf(rx_ring, rx_buf);
+		if (desc_count < num_buffers)
+			continue;
+		desc_count = 0;
+
+		if (unlikely(eth_skb_pad(skb))) {
+			skb = NULL;
+			drop = 0;
+			continue;
+		}
+
+		if (unlikely(drop)) {
+			dev_kfree_skb_any(skb);
+			skb = NULL;
+			drop = 0;
+			continue;
+		}
+
+		total_rx_bytes += skb->len;
+		skb->protocol = eth_type_trans(skb, rx_ring->netdev);
+		if (unlikely(skb->pkt_type == PACKET_BROADCAST ||
+			     skb->pkt_type == PACKET_MULTICAST))
+			rx_multicast_packets++;
+		else
+			rx_unicast_packets++;
+
+		napi_gro_receive(napi, skb);
+		skb = NULL;
+		drop = 0;
+		total_rx_pkts++;
+	}
+	tmp = cleaned_count & (~(NBL_MAX_BATCH_DESC - 1));
+	if (tmp)
+		failure = nbl_alloc_rx_bufs(rx_ring, tmp);
+
+	u64_stats_update_begin(&rx_ring->syncp);
+	rx_ring->stats.packets += total_rx_pkts;
+	rx_ring->stats.bytes += total_rx_bytes;
+	rx_ring->rx_stats.rx_multicast_packets += rx_multicast_packets;
+	rx_ring->rx_stats.rx_unicast_packets += rx_unicast_packets;
+	u64_stats_update_end(&rx_ring->syncp);
+
+	return failure ? budget : total_rx_pkts;
+}
+
+static int nbl_res_napi_poll(struct napi_struct *napi, int budget)
+{
+	struct nbl_napi_struct *nbl_napi =
+		container_of(napi, struct nbl_napi_struct, napi);
+	struct nbl_res_vector *vector =
+		container_of(nbl_napi, struct nbl_res_vector, nbl_napi);
+	struct nbl_res_tx_ring *tx_ring;
+	struct nbl_res_rx_ring *rx_ring;
+	int complete = 1, cleaned = 0, tx_done = 1;
+
+	tx_ring = vector->tx_ring;
+	rx_ring = vector->rx_ring;
+
+	if (vector->started) {
+		tx_done = nbl_res_txrx_clean_tx_irq(tx_ring);
+		cleaned = nbl_res_txrx_clean_rx_irq(rx_ring, napi, budget);
+	}
+	complete = tx_done && (cleaned < budget);
+	if (!complete)
+		return budget;
+
+	if (!napi_complete_done(napi, cleaned))
+		return min_t(int, cleaned, budget - 1);
+
+	/* unmask irq passthrough for performace */
+	if (vector->net_msix_mask_en)
+		writel(vector->irq_data,
+		       (void __iomem *)vector->irq_enable_base);
+
+	return min_t(int, cleaned, budget - 1);
+}
+
 static unsigned int nbl_xmit_desc_count(struct sk_buff *skb)
 {
 	unsigned int nr_frags = skb_shinfo(skb)->nr_frags;
@@ -1416,6 +1786,7 @@ static void nbl_res_txrx_set_vector_info(void *priv,
 static void nbl_res_get_pt_ops(void *priv, struct nbl_resource_pt_ops *pt_ops)
 {
 	pt_ops->start_xmit = nbl_res_txrx_start_xmit;
+	pt_ops->napi_poll = nbl_res_napi_poll;
 }
 
 static u32 nbl_res_txrx_get_tx_headroom(void *priv)
-- 
2.47.3


