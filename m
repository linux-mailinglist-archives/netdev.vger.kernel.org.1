Return-Path: <netdev+bounces-104264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0938990BC73
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 22:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94DA1281B75
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 20:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAF6199EA8;
	Mon, 17 Jun 2024 20:54:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83169199385
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 20:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718657665; cv=none; b=VKd7tG7Mgfsw7WpYJtxolAYWV1S6+1dcdALqiL/tOAla5GFAeJDPtYR6qc+Q+rCw7pNu7m0K6Efav88K0r7gBMvX/4j0l9Hq7I8ly5guQAPzB4IZtT5CMKwRRElVpCsrw6AvQC2VIlPILqj2qqqEkmaoobOYWrDOjc7zQuBINQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718657665; c=relaxed/simple;
	bh=RlUrsHwZWuCgr00Ypt6ww025VcVXHRt++5wsiIOonsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IupNF0PRhMmd1gUqSRAV+XJ1yYo/MtV92ztjs6vNSUaHnEN5Y3BZo8JgYKEqNiRp2icWuK8KIfHs4fb7tV/k+yj7XHJZewqGyD+kuhQJHNlOG0Sph7KAMas2VQlgFkiLZCy39fVoRHbVxTUcZBwqSHiuX6yVLe2b1tf20QzBCzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from labnh.big (syn-172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 217A37D12A;
	Mon, 17 Jun 2024 20:54:23 +0000 (UTC)
From: Christian Hopps <chopps@chopps.org>
To: devel@linux-ipsec.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org,
	Christian Hopps <chopps@chopps.org>,
	Christian Hopps <chopps@labn.net>
Subject: [PATCH ipsec-next v4 12/18] xfrm: iptfs: add basic receive packet (tunnel egress) handling
Date: Mon, 17 Jun 2024 16:53:10 -0400
Message-ID: <20240617205316.939774-13-chopps@chopps.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240617205316.939774-1-chopps@chopps.org>
References: <20240617205316.939774-1-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Hopps <chopps@labn.net>

Add handling of packets received from the tunnel. This implements
tunnel egress functionality.

Signed-off-by: Christian Hopps <chopps@labn.net>
---
 net/xfrm/xfrm_iptfs.c | 283 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 283 insertions(+)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 1a1d86de1a6c..ee75be187539 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -19,6 +19,10 @@
 
 #include "xfrm_inout.h"
 
+/* IPTFS encap (header) values. */
+#define IPTFS_SUBTYPE_BASIC 0
+#define IPTFS_SUBTYPE_CC 1
+
 /* 1) skb->head should be cache aligned.
  * 2) when resv is for L2 headers (i.e., ethernet) we want the cacheline to
  * start -16 from data.
@@ -56,6 +60,17 @@ struct xfrm_iptfs_data {
 static u32 __iptfs_get_inner_mtu(struct xfrm_state *x, int outer_mtu);
 static enum hrtimer_restart iptfs_delay_timer(struct hrtimer *me);
 
+/* ================= */
+/* Utility Functions */
+/* ================= */
+
+static u64 __esp_seq(struct sk_buff *skb)
+{
+	u64 seq = ntohl(XFRM_SKB_CB(skb)->seq.input.low);
+
+	return seq | (u64)ntohl(XFRM_SKB_CB(skb)->seq.input.hi) << 32;
+}
+
 /* ================= */
 /* SK_BUFF Functions */
 /* ================= */
@@ -165,6 +180,273 @@ static int skb_copy_bits_seq(struct skb_seq_state *st, int offset, void *to,
 	}
 }
 
+/* ================================== */
+/* IPTFS Receiving (egress) Functions */
+/* ================================== */
+
+/**
+ * iptfs_pskb_extract_seq() - Create and load data into a new sk_buff.
+ * @skblen: the total data size for `skb`.
+ * @st: The source for the rest of the data to copy into `skb`.
+ * @off: The offset into @st to copy data from.
+ * @len: The length of data to copy from @st into `skb`. This must be <=
+ *       @skblen.
+ *
+ * Create a new sk_buff `skb` with @skblen of packet data space. If non-zero,
+ * copy @rlen bytes of @runt into `skb`. Then using seq functions copy @len
+ * bytes from @st into `skb` starting from @off.
+ *
+ * It is an error for @len to be greater than the amount of data left in @st.
+ *
+ * Return: The newly allocated sk_buff `skb` or NULL if an error occurs.
+ */
+static struct sk_buff *
+iptfs_pskb_extract_seq(u32 skblen, struct skb_seq_state *st, u32 off, int len)
+{
+	struct sk_buff *skb = iptfs_alloc_skb(st->root_skb, skblen, false);
+
+	if (!skb)
+		return NULL;
+	if (skb_copy_bits_seq(st, off, skb_put(skb, len), len)) {
+		XFRM_INC_STATS(dev_net(st->root_skb->dev),
+			       LINUX_MIB_XFRMINERROR);
+		kfree_skb(skb);
+		return NULL;
+	}
+	return skb;
+}
+
+/**
+ * iptfs_complete_inner_skb() - finish preparing the inner packet for gro recv.
+ * @x: xfrm state
+ * @skb: the inner packet
+ *
+ * Finish the standard xfrm processing on the inner packet prior to sending back
+ * through gro_cells_receive. We do this separately b/c we are building a list
+ * of packets in the hopes that one day a list will be taken by
+ * xfrm_input.
+ */
+static void iptfs_complete_inner_skb(struct xfrm_state *x, struct sk_buff *skb)
+{
+	skb_reset_network_header(skb);
+
+	/* The packet is going back through gro_cells_receive no need to
+	 * set this.
+	 */
+	skb_reset_transport_header(skb);
+
+	/* Packet already has checksum value set. */
+	skb->ip_summed = CHECKSUM_NONE;
+
+	/* Our skb will contain the header data copied when this outer packet
+	 * which contained the start of this inner packet. This is true
+	 * when we allocate a new skb as well as when we reuse the existing skb.
+	 */
+	if (ip_hdr(skb)->version == 0x4) {
+		struct iphdr *iph = ip_hdr(skb);
+
+		if (x->props.flags & XFRM_STATE_DECAP_DSCP)
+			ipv4_copy_dscp(XFRM_MODE_SKB_CB(skb)->tos, iph);
+		if (!(x->props.flags & XFRM_STATE_NOECN))
+			if (INET_ECN_is_ce(XFRM_MODE_SKB_CB(skb)->tos))
+				IP_ECN_set_ce(iph);
+
+		skb->protocol = htons(ETH_P_IP);
+	} else {
+		struct ipv6hdr *iph = ipv6_hdr(skb);
+
+		if (x->props.flags & XFRM_STATE_DECAP_DSCP)
+			ipv6_copy_dscp(XFRM_MODE_SKB_CB(skb)->tos, iph);
+		if (!(x->props.flags & XFRM_STATE_NOECN))
+			if (INET_ECN_is_ce(XFRM_MODE_SKB_CB(skb)->tos))
+				IP6_ECN_set_ce(skb, iph);
+
+		skb->protocol = htons(ETH_P_IPV6);
+	}
+}
+
+/**
+ * iptfs_input() - handle receipt of iptfs payload
+ * @x: xfrm state
+ * @skb: the packet
+ *
+ * Process the IPTFS payload in `skb` and consume it afterwards.
+ */
+static int iptfs_input(struct xfrm_state *x, struct sk_buff *skb)
+{
+	u8 hbytes[sizeof(struct ipv6hdr)];
+	struct ip_iptfs_cc_hdr iptcch;
+	struct skb_seq_state skbseq;
+	struct list_head sublist; /* rename this it's just a list */
+	struct sk_buff *first_skb, *next;
+	const unsigned char *old_mac;
+	struct xfrm_iptfs_data *xtfs;
+	struct ip_iptfs_hdr *ipth;
+	struct iphdr *iph;
+	struct net *net;
+	u32 remaining, iplen, iphlen, data, tail;
+	u32 blkoff;
+	u64 seq;
+
+	xtfs = x->mode_data;
+	net = dev_net(skb->dev);
+	first_skb = NULL;
+
+	seq = __esp_seq(skb);
+
+	/* Large enough to hold both types of header */
+	ipth = (struct ip_iptfs_hdr *)&iptcch;
+
+	/* Save the old mac header if set */
+	old_mac = skb_mac_header_was_set(skb) ? skb_mac_header(skb) : NULL;
+
+	skb_prepare_seq_read(skb, 0, skb->len, &skbseq);
+
+	/* Get the IPTFS header and validate it */
+
+	if (skb_copy_bits_seq(&skbseq, 0, ipth, sizeof(*ipth))) {
+		XFRM_INC_STATS(net, LINUX_MIB_XFRMINBUFFERERROR);
+		goto done;
+	}
+	data = sizeof(*ipth);
+
+	/* Set data past the basic header */
+	if (ipth->subtype == IPTFS_SUBTYPE_CC) {
+		/* Copy the rest of the CC header */
+		remaining = sizeof(iptcch) - sizeof(*ipth);
+		if (skb_copy_bits_seq(&skbseq, data, ipth + 1, remaining)) {
+			XFRM_INC_STATS(net, LINUX_MIB_XFRMINBUFFERERROR);
+			goto done;
+		}
+		data += remaining;
+	} else if (ipth->subtype != IPTFS_SUBTYPE_BASIC) {
+		XFRM_INC_STATS(net, LINUX_MIB_XFRMINHDRERROR);
+		goto done;
+	}
+
+	if (ipth->flags != 0) {
+		XFRM_INC_STATS(net, LINUX_MIB_XFRMINHDRERROR);
+		goto done;
+	}
+
+	INIT_LIST_HEAD(&sublist);
+
+	/* Fragment handling in following commits */
+	blkoff = ntohs(ipth->block_offset);
+	data += blkoff;
+
+	/* New packets */
+	tail = skb->len;
+	while (data < tail) {
+		__be16 protocol = 0;
+
+		/* Gather information on the next data block.
+		 * `data` points to the start of the data block.
+		 */
+		remaining = tail - data;
+
+		/* try and copy enough bytes to read length from ipv4/ipv6 */
+		iphlen = min_t(u32, remaining, 6);
+		if (skb_copy_bits_seq(&skbseq, data, hbytes, iphlen)) {
+			XFRM_INC_STATS(net, LINUX_MIB_XFRMINBUFFERERROR);
+			goto done;
+		}
+
+		iph = (struct iphdr *)hbytes;
+		if (iph->version == 0x4) {
+			/* must have at least tot_len field present */
+			if (remaining < 4)
+				break;
+
+			iplen = be16_to_cpu(iph->tot_len);
+			iphlen = iph->ihl << 2;
+			protocol = cpu_to_be16(ETH_P_IP);
+			XFRM_MODE_SKB_CB(skbseq.root_skb)->tos = iph->tos;
+		} else if (iph->version == 0x6) {
+			/* must have at least payload_len field present */
+			if (remaining < 6)
+				break;
+
+			iplen = be16_to_cpu(
+				((struct ipv6hdr *)hbytes)->payload_len);
+			iplen += sizeof(struct ipv6hdr);
+			iphlen = sizeof(struct ipv6hdr);
+			protocol = cpu_to_be16(ETH_P_IPV6);
+			XFRM_MODE_SKB_CB(skbseq.root_skb)->tos =
+				ipv6_get_dsfield((struct ipv6hdr *)iph);
+		} else if (iph->version == 0x0) {
+			/* pad */
+			break;
+		} else {
+			XFRM_INC_STATS(net, LINUX_MIB_XFRMINBUFFERERROR);
+			goto done;
+		}
+
+		if (unlikely(skbseq.stepped_offset)) {
+			/* We need to reset our seq read, it can't backup at
+			 * this point.
+			 */
+			struct sk_buff *save = skbseq.root_skb;
+
+			skb_abort_seq_read(&skbseq);
+			skb_prepare_seq_read(save, data, tail, &skbseq);
+		}
+
+		if (!first_skb)
+			first_skb = skb;
+
+		/* Fragment handling in following commits */
+		if (iplen > remaining)
+			break;
+
+		skb = iptfs_pskb_extract_seq(iplen, &skbseq, data, iplen);
+		if (!skb) {
+			/* skip to next packet or done */
+			data += iplen;
+			continue;
+		}
+
+		skb->protocol = protocol;
+		if (old_mac) {
+			/* rebuild the mac header */
+			skb_set_mac_header(skb, -first_skb->mac_len);
+			memcpy(skb_mac_header(skb), old_mac,
+			       first_skb->mac_len);
+			eth_hdr(skb)->h_proto = skb->protocol;
+		}
+
+		data += iplen;
+		iptfs_complete_inner_skb(x, skb);
+		list_add_tail(&skb->list, &sublist);
+	}
+
+	/* Send the packets! */
+	list_for_each_entry_safe(skb, next, &sublist, list) {
+		skb_list_del_init(skb);
+		if (xfrm_input(skb, 0, 0, -3))
+			kfree_skb(skb);
+	}
+
+done:
+	skb = skbseq.root_skb;
+	skb_abort_seq_read(&skbseq);
+
+	if (first_skb) {
+		consume_skb(first_skb);
+	} else {
+		/* skb is the original passed in skb, but we didn't get far
+		 * enough to process it as the first_skb.
+		 */
+		kfree_skb(skb);
+	}
+
+	/* We always have dealt with the input SKB, either we are re-using it,
+	 * or we have freed it. Return EINPROGRESS so that xfrm_input stops
+	 * processing it.
+	 */
+	return -EINPROGRESS;
+}
+
 /* ================================= */
 /* IPTFS Sending (ingress) Functions */
 /* ================================= */
@@ -1128,6 +1410,7 @@ static const struct xfrm_mode_cbs iptfs_mode_cbs = {
 	.sa_len = iptfs_sa_len,
 	.clone = iptfs_clone,
 	.get_inner_mtu = iptfs_get_inner_mtu,
+	.input = iptfs_input,
 	.output = iptfs_output_collect,
 	.prepare_output = iptfs_prepare_output,
 };
-- 
2.45.2


