Return-Path: <netdev+bounces-269491-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJ9CBIsTvGnbrwIAu9opvQ
	(envelope-from <netdev+bounces-269491-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:17:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDE12CD8E9
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D85B23219365
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 15:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144B13E315D;
	Thu, 19 Mar 2026 15:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="lay8uwxM"
X-Original-To: netdev@vger.kernel.org
Received: from mout-b-112.mailbox.org (mout-b-112.mailbox.org [195.10.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCC93E2768;
	Thu, 19 Mar 2026 15:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773933199; cv=none; b=f6hbYRNS3wZrYXkZz5aL9ULBAgHLjwV1vbOQAMExSdiXTgDQatePsNlVl6sCzhkk8jz2pTnn2mnIhNUH5KVgDYIQPC6zcFHpdk5X+kRmlxMJtWh8UihDh3uQ4Laf+D7AMtVFIMk+R0TST9LkmbEIQgKu9Acx5NWcfjoWxgjul+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773933199; c=relaxed/simple;
	bh=JwGy+BPlkGjZjKA3BTlYKwhIK/1wQWC18opsy5kgiCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kZyGy4tuUOmWCP8B1FuwetUmKeiGTcdEgFXrd/O1x7+Pi+Tpg+Lpy5ihvN5Wu2jKWJ6ZY8MtlK9QmwKnB53r4qED5eQvsYU2o1OxL8pOuFNJID0ZgLHgh1MP0I61N8n/67OWBUswEvnZWpJdHuJUCytBabm10VJFeNpuTfXhWRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=lay8uwxM; arc=none smtp.client-ip=195.10.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4fc8Mt0rsQzDvNX;
	Thu, 19 Mar 2026 16:13:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1773933194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hNd5T3aNWF08LM/DvKx32Cly2ZAmObchJq+lKFbTppc=;
	b=lay8uwxMQHB4PkU6Z8gyledt+NXkDLsV8oGNCOlt6DqJbiIvoe1Y7gFfy7bmO9h8B6WxPC
	l9s02dX2P99EhHMnXbcSIIhrpQAUZAiSbWoC4NZA9Vx132BsXb4stauOoXtQ175RgKFMan
	UscRPaX67hSa+NIJuhIJVZ25maXUMJ1kc2MqvAiGBYODKJSI+rjtPX+wO+1zLB9v5SPiBM
	7YOZPIEWnf+jcAISQzBF/Qym5KZr6ShEpG9ckYs5LuM9xYvF4t7iREHzQS271oru8n+ere
	HgpArXuIlUCPQmGcBh3PBpEQ7m6QfrFbZx3vH2tJSZ6xmgJCEMmNoZKoEmBHYg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Daniel=20Gr=C3=B6ber?= <dxld@darkboxed.org>,
	Ralf Lici <ralf@mandelbit.com>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC net-next 05/15] ipxlat: add IPv6 packet validation path
Date: Thu, 19 Mar 2026 16:12:14 +0100
Message-ID: <20260319151230.655687-6-ralf@mandelbit.com>
In-Reply-To: <20260319151230.655687-1-ralf@mandelbit.com>
References: <20260319151230.655687-1-ralf@mandelbit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mandelbit.com:s=MBO0001];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269491-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mandelbit.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mandelbit.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ralf@mandelbit.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.912];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mandelbit.com:dkim,mandelbit.com:email,mandelbit.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7FDE12CD8E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implement IPv6 packet parsing and validation, including extension header
traversal, fragment-header constraints, and ICMPv6 checksum handling for
informational/error traffic. The parser fills skb control-block metadata
for 6->4 translation and quoted-inner packet handling.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ipxlat/packet.c | 326 +++++++++++++++++++++++++++++++++++-
 1 file changed, 325 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ipxlat/packet.c b/drivers/net/ipxlat/packet.c
index 0cc619dca147..b9a9af1b3adb 100644
--- a/drivers/net/ipxlat/packet.c
+++ b/drivers/net/ipxlat/packet.c
@@ -401,7 +401,331 @@ int ipxlat_v4_validate_skb(struct ipxlat_priv *ipxlat, struct sk_buff *skb)
 	return 0;
 }
 
+static bool ipxlat_v6_validate_saddr(const struct in6_addr *addr6)
+{
+	return !(ipv6_addr_any(addr6) || ipv6_addr_loopback(addr6) ||
+		 ipv6_addr_is_multicast(addr6));
+}
+
+static int ipxlat_v6_pull_l4(struct sk_buff *skb, unsigned int l4_offset,
+			     u8 l4_proto, bool *is_icmp_err)
+{
+	struct icmp6hdr *icmp;
+	struct udphdr *udp;
+	struct tcphdr *tcp;
+
+	*is_icmp_err = false;
+
+	switch (l4_proto) {
+	case NEXTHDR_TCP:
+		if (unlikely(!pskb_may_pull(skb, l4_offset + sizeof(*tcp))))
+			return -EINVAL;
+		tcp = (struct tcphdr *)(skb->data + l4_offset);
+		return __tcp_hdrlen(tcp);
+	case NEXTHDR_UDP:
+		if (unlikely(!pskb_may_pull(skb, l4_offset + sizeof(*udp))))
+			return -EINVAL;
+		udp = (struct udphdr *)(skb->data + l4_offset);
+		if (unlikely(ntohs(udp->len) < sizeof(*udp)))
+			return -EINVAL;
+		return sizeof(struct udphdr);
+	case NEXTHDR_ICMP:
+		if (unlikely(!pskb_may_pull(skb, l4_offset + sizeof(*icmp))))
+			return -EINVAL;
+		icmp = (struct icmp6hdr *)(skb->data + l4_offset);
+		*is_icmp_err = icmpv6_is_err(icmp->icmp6_type);
+		return sizeof(struct icmp6hdr);
+	default:
+		return 0;
+	}
+}
+
+/* Basic IPv6 header walk: parse only the packet starting at l3_offset.
+ * It does not inspect quoted inner packets carried by ICMP errors.
+ */
+static int ipxlat_v6_walk_hdrs(struct sk_buff *skb, unsigned int l3_offset,
+			       u8 *l4_proto, unsigned int *fhdr_offset,
+			       unsigned int *l4_offset, bool *has_l4)
+{
+	unsigned int frag_hdr_off, l4hdr_off;
+	struct frag_hdr *frag;
+	struct ipv6hdr *ip6;
+	bool first_frag;
+	int err;
+
+	/* cannot use default getter because this function is used both for
+	 * outer and inner packets
+	 */
+	ip6 = (struct ipv6hdr *)(skb->data + l3_offset);
+
+	/* if present, locate Fragment Header first because it affects
+	 * whether transport headers are available
+	 */
+	frag_hdr_off = l3_offset;
+	err = ipv6_find_hdr(skb, &frag_hdr_off, NEXTHDR_FRAGMENT, NULL, NULL);
+	if (unlikely(err < 0 && err != -ENOENT))
+		return -EINVAL;
+
+	*has_l4 = true;
+	*fhdr_offset = 0;
+	if (unlikely(err == NEXTHDR_FRAGMENT)) {
+		if (unlikely(!pskb_may_pull(skb, frag_hdr_off + sizeof(*frag))))
+			return -EINVAL;
+		frag = (struct frag_hdr *)(skb->data + frag_hdr_off);
+
+		/* remember Fragment Header offset for downstream logic */
+		*fhdr_offset = frag_hdr_off;
+		first_frag = ipxlat_is_first_frag6(frag);
+
+		/* ipv6 forbids chaining FHs */
+		if (unlikely(frag->nexthdr == NEXTHDR_FRAGMENT))
+			return -EINVAL;
+
+		/* RFC 7915 Section 5.1.1 does not support extension headers
+		 * after FH (except NEXTHDR_NONE)
+		 */
+		if (unlikely(ipv6_ext_hdr(frag->nexthdr) &&
+			     frag->nexthdr != NEXTHDR_NONE))
+			return -EPROTONOSUPPORT;
+
+		/* non-first fragments do not carry a full transport header */
+		if (!first_frag) {
+			*l4_proto = frag->nexthdr;
+			/* first byte after FH is fragment payload,
+			 * not L4 header
+			 */
+			*l4_offset = frag_hdr_off + sizeof(struct frag_hdr);
+			*has_l4 = false;
+			return 0;
+		}
+	}
+
+	/* walk extension headers to terminal protocol and compute offsets used
+	 * by validation/translation
+	 */
+	l4hdr_off = l3_offset;
+	err = ipv6_find_hdr(skb, &l4hdr_off, -1, NULL, NULL);
+	if (unlikely(err < 0))
+		return -EINVAL;
+
+	*l4_proto = err;
+	*l4_offset = l4hdr_off;
+	return 0;
+}
+
+/* RFC 7915 Section 5.1 says a Routing Header with Segments Left != 0
+ * must not be translated. We detect it by asking ipv6_find_hdr not to
+ * skip RH, then emit ICMPv6 Parameter Problem pointing to segments_left.
+ */
+static int ipxlat_v6_check_rh(struct sk_buff *skb)
+{
+	unsigned int rh_off;
+	int flags, nexthdr;
+
+	rh_off = 0;
+	flags = IP6_FH_F_SKIP_RH;
+	nexthdr = ipv6_find_hdr(skb, &rh_off, NEXTHDR_ROUTING, NULL, &flags);
+	if (unlikely(nexthdr < 0 && nexthdr != -ENOENT))
+		return -EINVAL;
+	if (likely(nexthdr != NEXTHDR_ROUTING))
+		return 0;
+
+	return -EINVAL;
+}
+
+static int ipxlat_v6_pull_outer_l3(struct sk_buff *skb)
+{
+	const unsigned int l3_off = skb_network_offset(skb);
+	struct ipv6hdr *l3_hdr;
+
+	if (unlikely(!pskb_may_pull(skb, l3_off + sizeof(*l3_hdr))))
+		return -EINVAL;
+	l3_hdr = ipv6_hdr(skb);
+
+	/* translator does not support jumbograms; payload_len must match skb */
+	if (unlikely(l3_hdr->version != 6 ||
+		     skb->len != sizeof(*l3_hdr) +
+					 be16_to_cpu(l3_hdr->payload_len) ||
+		     !ipxlat_v6_validate_saddr(&l3_hdr->saddr)))
+		return -EINVAL;
+
+	if (unlikely(l3_hdr->hop_limit <= 1))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int ipxlat_v6_pull_icmp_inner(struct sk_buff *skb,
+				     unsigned int outer_payload_off)
+{
+	unsigned int inner_fhdr_off, inner_l4_off;
+	struct ipxlat_cb *cb = ipxlat_skb_cb(skb);
+	struct ipv6hdr *inner_ip6;
+	bool has_l4, is_icmp_err;
+	u8 inner_l4_proto;
+	int err;
+
+	if (unlikely(!pskb_may_pull(skb,
+				    outer_payload_off + sizeof(*inner_ip6))))
+		return -EINVAL;
+
+	inner_ip6 = (struct ipv6hdr *)(skb->data + outer_payload_off);
+	if (unlikely(inner_ip6->version != 6))
+		return -EINVAL;
+
+	err = ipxlat_v6_walk_hdrs(skb, outer_payload_off, &inner_l4_proto,
+				  &inner_fhdr_off, &inner_l4_off, &has_l4);
+	if (unlikely(err))
+		return err;
+
+	cb->inner_l3_offset = outer_payload_off;
+	cb->inner_l4_offset = inner_l4_off;
+	cb->inner_fragh_off = inner_fhdr_off;
+	cb->inner_l4_proto = inner_l4_proto;
+
+	if (likely(has_l4)) {
+		err = ipxlat_v6_pull_l4(skb, inner_l4_off, inner_l4_proto,
+					&is_icmp_err);
+		if (unlikely(err < 0))
+			return err;
+		if (unlikely(is_icmp_err))
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ipxlat_v6_pull_hdrs(struct sk_buff *skb)
+{
+	const unsigned int l3_off = skb_network_offset(skb);
+	unsigned int fragh_off, l4_off, payload_off;
+	struct ipxlat_cb *cb = ipxlat_skb_cb(skb);
+	int l3_len, l4_len, err;
+	struct frag_hdr *frag;
+	bool has_l4;
+	u8 l4_proto;
+
+	/* parse IPv6 base header and perform basic structural checks */
+	err = ipxlat_v6_pull_outer_l3(skb);
+	if (unlikely(err))
+		return err;
+
+	/* walk extension/fragment headers and locate the transport header */
+	err = ipxlat_v6_walk_hdrs(skb, l3_off, &l4_proto, &fragh_off, &l4_off,
+				  &has_l4);
+	/* -EPROTONOSUPPORT means packet layout is syntactically valid but
+	 * unsupported by our RFC 7915 path
+	 */
+	if (unlikely(err == -EPROTONOSUPPORT))
+		return -EINVAL;
+	if (unlikely(err))
+		return err;
+
+	l3_len = l4_off - l3_off;
+	payload_off = l4_off;
+
+	if (likely(has_l4)) {
+		l4_len = ipxlat_v6_pull_l4(skb, l4_off, l4_proto,
+					   &cb->is_icmp_err);
+		if (unlikely(l4_len < 0))
+			return l4_len;
+		payload_off += l4_len;
+	}
+
+	/* RFC 7915 Section 5.1 */
+	err = ipxlat_v6_check_rh(skb);
+	if (unlikely(err))
+		return err;
+
+	if (unlikely(l4_proto == NEXTHDR_ICMP)) {
+		/* A stateless translator cannot reliably translate ICMP
+		 * checksum across real IPv6 fragments, so fragmented ICMP is
+		 * dropped. A Fragment Header alone, however, is not enough to
+		 * decide: so-called atomic fragments (offset=0, M=0) carry a
+		 * Fragment Header but are not actually fragmented.
+		 */
+		if (unlikely(fragh_off)) {
+			if (unlikely(!pskb_may_pull(skb,
+						    fragh_off + sizeof(*frag))))
+				return -EINVAL;
+
+			frag = (struct frag_hdr *)(skb->data + fragh_off);
+			if (unlikely(ipxlat_get_frag6_offset(frag) ||
+				     (be16_to_cpu(frag->frag_off) & IP6_MF)))
+				return -EINVAL;
+		}
+
+		if (unlikely(cb->is_icmp_err)) {
+			/* validate the quoted packet in an ICMP error */
+			err = ipxlat_v6_pull_icmp_inner(skb, payload_off);
+			if (unlikely(err))
+				return err;
+		}
+	}
+
+	cb->l4_proto = l4_proto;
+	cb->l4_off = l4_off;
+	cb->fragh_off = fragh_off;
+	cb->payload_off = payload_off;
+	cb->l3_hdr_len = l3_len;
+
+	return 0;
+}
+
+static int ipxlat_v6_validate_icmp_csum(const struct sk_buff *skb)
+{
+	struct ipv6hdr *iph6;
+	unsigned int len;
+	__sum16 csum;
+
+	if (skb->ip_summed != CHECKSUM_NONE)
+		return 0;
+
+	iph6 = ipv6_hdr(skb);
+	len = ipxlat_skb_datagram_len(skb);
+	csum = csum_ipv6_magic(&iph6->saddr, &iph6->daddr, len, NEXTHDR_ICMP,
+			       skb_checksum(skb, skb_transport_offset(skb), len,
+					    0));
+
+	return unlikely(csum) ? -EINVAL : 0;
+}
+
+/**
+ * ipxlat_v6_validate_skb - validate IPv6 input and fill parser metadata in cb
+ * @skb: packet to validate
+ *
+ * Ensures required headers are present/consistent and stores parsed offsets
+ * into &struct ipxlat_cb for the translation path.
+ *
+ * Return: 0 on success, negative errno on validation failure.
+ */
 int ipxlat_v6_validate_skb(struct sk_buff *skb)
 {
-	return -EOPNOTSUPP;
+	struct ipxlat_cb *cb = ipxlat_skb_cb(skb);
+	int err;
+
+	if (unlikely(skb_shared(skb)))
+		return -EINVAL;
+
+	err = ipxlat_v6_pull_hdrs(skb);
+	if (unlikely(err))
+		return err;
+
+	skb_set_transport_header(skb, cb->l4_off);
+
+	if (unlikely(cb->is_icmp_err)) {
+		if (unlikely(cb->l4_proto != NEXTHDR_ICMP)) {
+			DEBUG_NET_WARN_ON_ONCE(1);
+			return -EINVAL;
+		}
+
+		/* The translated ICMPv4 checksum is recomputed from scratch,
+		 * so reject bad ICMPv6 error checksums before conversion.
+		 */
+		err = ipxlat_v6_validate_icmp_csum(skb);
+		if (unlikely(err))
+			return err;
+	}
+
+	return 0;
 }
-- 
2.53.0


