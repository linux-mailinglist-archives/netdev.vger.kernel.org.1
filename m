Return-Path: <netdev+bounces-156611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADE3A07229
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 10:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4716E3A04A9
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 09:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD81218826;
	Thu,  9 Jan 2025 09:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="Pem/00fg"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC7A217F2D
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 09:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736416146; cv=none; b=PYi3jEhQI50T5Mbouqg8IPy+IjOe+3134nghZFX5ELukuw8QsqY+ISP4utrION0CQ0CTT6m9AcZzYptcku0g8/XedAc7+09Ayuo3LBCfMEAIN7fV1kMmyMv7eKCvj8b1qsiEIsTuOpWb1Vz3Y2nx0LGyQ7Tjk/kMRAgMSrZbmtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736416146; c=relaxed/simple;
	bh=+A9dkdls3vmJc+oyuussGxl77hsBm7sIQunXm6QX7bg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ug5Y8OIYx2WRjwiZC0tbmhB88loIVHR1Qmk/Hc09mxRULzTGe0q8P80cTdLSdGb4/Cb7AtPIk9MN4GJGFQMpGBIusU1s1dNIk9xMfeUH3fbRjiCmCRq6TN8Moey3VEjPIcfcI2rr445sJnCB2FmK09kRnrKV0IJ8pp9kOHXIonI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=Pem/00fg; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id D098E2006C;
	Thu,  9 Jan 2025 10:49:00 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ozD3zSgRAv2S; Thu,  9 Jan 2025 10:48:59 +0100 (CET)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 9E0C22088A;
	Thu,  9 Jan 2025 10:48:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 9E0C22088A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1736416137;
	bh=neV41ihOYKyWJFxl5TwY9hzHbp7O/SlndAmRkguxWgc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=Pem/00fgeZNcudafWKjbGi3ANeKQdkC5UdRU3F9YOCKLPpSQvz45+IEn0HDmE79NX
	 zXJaBHAYiq7W80SWDPouHOUihDKbwflNprdyde9jWOhuEvscELbGXmXft03Un2qaug
	 Cf5iU86VQKgAF28vo9eOoGgn1FmbCGQX7NogKolvGN3QgHvNUsh+g69QIlPE5Uk8ec
	 uF9UaqbZIt9jLf9juVCu9O+Wy2DG7833oLfLjCQwWxT97L9hTJTtqfjiMbFbSFYzaL
	 8eUsiuUdfq2trc1u3vdD1iqYT6sRmpG3Eul8ACgW+gS32O/cSP9XBwp1pjWbNWB/5e
	 oPjtaLXBjfPPA==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 9 Jan 2025 10:48:57 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 9 Jan
 2025 10:48:56 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id A3665318412B; Thu,  9 Jan 2025 10:43:29 +0100 (CET)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 10/17] xfrm: iptfs: add basic receive packet (tunnel egress) handling
Date: Thu, 9 Jan 2025 10:43:14 +0100
Message-ID: <20250109094321.2268124-11-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250109094321.2268124-1-steffen.klassert@secunet.com>
References: <20250109094321.2268124-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

From: Christian Hopps <chopps@labn.net>

Add handling of packets received from the tunnel. This implements
tunnel egress functionality.

Signed-off-by: Christian Hopps <chopps@labn.net>
Tested-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_iptfs.c | 276 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 276 insertions(+)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index b7d706a006eb..085964fe3251 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -20,6 +20,10 @@
 
 #include "xfrm_inout.h"
 
+/* IPTFS encap (header) values. */
+#define IPTFS_SUBTYPE_BASIC 0
+#define IPTFS_SUBTYPE_CC 1
+
 /* ------------------------------------------------ */
 /* IPTFS default SA values (tunnel ingress/dir-out) */
 /* ------------------------------------------------ */
@@ -185,6 +189,277 @@ static void iptfs_skb_head_to_frag(const struct sk_buff *skb, skb_frag_t *frag)
 	skb_frag_fill_page_desc(frag, page, skb->data - addr, skb_headlen(skb));
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
+	if (skb_copy_seq_read(st, off, skb_put(skb, len), len)) {
+		XFRM_INC_STATS(dev_net(st->root_skb->dev), LINUX_MIB_XFRMINERROR);
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
+static bool __input_process_payload(struct xfrm_state *x, u32 data,
+				    struct skb_seq_state *skbseq,
+				    struct list_head *sublist)
+{
+	u8 hbytes[sizeof(struct ipv6hdr)];
+	struct sk_buff *first_skb, *next, *skb;
+	const unsigned char *old_mac;
+	struct iphdr *iph;
+	struct net *net;
+	u32 remaining, iplen, iphlen, tail;
+
+	net = xs_net(x);
+	skb = skbseq->root_skb;
+	first_skb = NULL;
+
+	/* Save the old mac header if set */
+	old_mac = skb_mac_header_was_set(skb) ? skb_mac_header(skb) : NULL;
+
+	/* New packets */
+
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
+		if (skb_copy_seq_read(skbseq, data, hbytes, iphlen)) {
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
+			XFRM_MODE_SKB_CB(skbseq->root_skb)->tos = iph->tos;
+		} else if (iph->version == 0x6) {
+			/* must have at least payload_len field present */
+			if (remaining < 6)
+				break;
+
+			iplen = be16_to_cpu(((struct ipv6hdr *)hbytes)->payload_len);
+			iplen += sizeof(struct ipv6hdr);
+			iphlen = sizeof(struct ipv6hdr);
+			protocol = cpu_to_be16(ETH_P_IPV6);
+			XFRM_MODE_SKB_CB(skbseq->root_skb)->tos =
+				ipv6_get_dsfield((struct ipv6hdr *)iph);
+		} else if (iph->version == 0x0) {
+			/* pad */
+			break;
+		} else {
+			XFRM_INC_STATS(net, LINUX_MIB_XFRMINBUFFERERROR);
+			goto done;
+		}
+
+		if (unlikely(skbseq->stepped_offset)) {
+			/* We need to reset our seq read, it can't backup at
+			 * this point.
+			 */
+			struct sk_buff *save = skbseq->root_skb;
+
+			skb_abort_seq_read(skbseq);
+			skb_prepare_seq_read(save, data, tail, skbseq);
+		}
+
+		if (!first_skb)
+			first_skb = skb;
+
+		/* Fragment handling in following commits */
+		if (iplen > remaining)
+			break;
+
+		skb = iptfs_pskb_extract_seq(iplen, skbseq, data, iplen);
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
+			memcpy(skb_mac_header(skb), old_mac, first_skb->mac_len);
+			eth_hdr(skb)->h_proto = skb->protocol;
+		}
+
+		data += iplen;
+		iptfs_complete_inner_skb(x, skb);
+		list_add_tail(&skb->list, sublist);
+	}
+
+	/* Send the packets! */
+	list_for_each_entry_safe(skb, next, sublist, list) {
+		skb_list_del_init(skb);
+		if (xfrm_input(skb, 0, 0, -2))
+			kfree_skb(skb);
+	}
+
+done:
+	return false;
+}
+
+/**
+ * iptfs_input() - handle receipt of iptfs payload
+ * @x: xfrm state
+ * @skb: the packet
+ *
+ * Process the IPTFS payload in `skb` and consume it afterwards.
+ *
+ * Returns 0.
+ */
+static int iptfs_input(struct xfrm_state *x, struct sk_buff *skb)
+{
+	struct ip_iptfs_cc_hdr iptcch;
+	struct skb_seq_state skbseq;
+	struct list_head sublist; /* rename this it's just a list */
+	struct ip_iptfs_hdr *ipth;
+	struct net *net;
+	u32 remaining, data;
+	bool consumed = false;
+
+	net = xs_net(x);
+
+	/* Large enough to hold both types of header */
+	ipth = (struct ip_iptfs_hdr *)&iptcch;
+
+	skb_prepare_seq_read(skb, 0, skb->len, &skbseq);
+
+	/* Get the IPTFS header and validate it */
+
+	if (skb_copy_seq_read(&skbseq, 0, ipth, sizeof(*ipth))) {
+		XFRM_INC_STATS(net, LINUX_MIB_XFRMINBUFFERERROR);
+		goto done;
+	}
+	data = sizeof(*ipth);
+
+	/* Set data past the basic header */
+	if (ipth->subtype == IPTFS_SUBTYPE_CC) {
+		/* Copy the rest of the CC header */
+		remaining = sizeof(iptcch) - sizeof(*ipth);
+		if (skb_copy_seq_read(&skbseq, data, ipth + 1, remaining)) {
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
+	data += ntohs(ipth->block_offset);
+
+	/* New packets */
+	consumed = __input_process_payload(x, data, &skbseq, &sublist);
+done:
+	skb = skbseq.root_skb;
+	skb_abort_seq_read(&skbseq);
+
+	if (!consumed)
+		kfree_skb(skb);
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
@@ -1101,6 +1376,7 @@ static const struct xfrm_mode_cbs iptfs_mode_cbs = {
 	.copy_to_user = iptfs_copy_to_user,
 	.sa_len = iptfs_sa_len,
 	.get_inner_mtu = iptfs_get_inner_mtu,
+	.input = iptfs_input,
 	.output = iptfs_output_collect,
 	.prepare_output = iptfs_prepare_output,
 };
-- 
2.34.1


