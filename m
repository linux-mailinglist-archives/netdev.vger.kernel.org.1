Return-Path: <netdev+bounces-269490-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8N23OA8TvGnbrwIAu9opvQ
	(envelope-from <netdev+bounces-269490-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:15:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7212CD887
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D2C0E3031B2A
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 15:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8703E1D07;
	Thu, 19 Mar 2026 15:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="0LmAj+Se"
X-Original-To: netdev@vger.kernel.org
Received: from mout-b-107.mailbox.org (mout-b-107.mailbox.org [195.10.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FBB3DE437;
	Thu, 19 Mar 2026 15:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773933195; cv=none; b=KpySPH7sgfJXjdVTb33uPl+xxu9yMf0SHdVGdGk1R9q5UbgpMv6IrMr2Sn31p+arR97jIsFREUtwYOiM2G1JfQhk23xBOl6eux6vS/B5zlz1gXPHI0ViHMflhiYGzD82FaNwwXOcbPQcohsAO0fSeE7HEo1M3b1EWmpeqdanV2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773933195; c=relaxed/simple;
	bh=D1vNkKfupMoP2d5SF28Np/g0vRw1AZ3D7zDLIYeLhq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZRrX+Aklkr4lNuBM+rHm0TM2tPcRDvPvO6P1A6pc2cbE8hWT8OdAARw8nbLf5t7eP07iNWobFY2SGnz8Je5epSf5U2aPsTkTqXusEEV8ISvImuGl4a1V17yfRBMjMJoUDZIHis1p2Nts7euTF9CvgGMWFNwG3HAT/dRcze58e4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=0LmAj+Se; arc=none smtp.client-ip=195.10.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-107.mailbox.org (Postfix) with ESMTPS id 4fc8Mn2m7yzDs2b;
	Thu, 19 Mar 2026 16:13:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1773933189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ELi3LIGFSDx2zQa6RJTz+X8P1Q4yynMqgkJVxUcqTz8=;
	b=0LmAj+SeaWqLrSHgbG9+zW77XSC2QtpijJMiM7HKx93qGtu6efE65uDBsTuZCSfw7j/AbZ
	TQfBpbWH6tSzNeAd7lRtru/YnNUuParoFV/caFY2i/uP/dwYB3aWUHYt821mJ3LLvYWRp0
	eQxnKCWOVffk10fnM24JxiMT8d9gUIc20ePZduhOJGqLJLZ5uLxdo/NS+OolUi0vBghvon
	kENFxzKSgWf0HrPnfDC+VkjGDVEQI7XU5DDTDNAvCYHjloTxS4pjoC1wt5eHe1aN/Bc4B7
	Ypj54dAJBCATF8fqXIJ4Jq4GESr+vlg9CbzbWtg3LR5+5qqm5jKR/IVqEP27Sg==
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
Subject: [RFC net-next 04/15] ipxlat: add IPv4 packet validation path
Date: Thu, 19 Mar 2026 16:12:13 +0100
Message-ID: <20260319151230.655687-5-ralf@mandelbit.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269490-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.908];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7A7212CD887
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implement IPv4 packet parsing and validation, including option
inspection, fragment-sensitive L4 checks, and UDP checksum-zero handling
consistent with translator constraints. The parser populates skb
control-block metadata consumed by translation and marks RFC-driven drop
reasons for later action handling.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ipxlat/packet.c | 312 +++++++++++++++++++++++++++++++++++-
 1 file changed, 310 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ipxlat/packet.c b/drivers/net/ipxlat/packet.c
index f82c375255f3..0cc619dca147 100644
--- a/drivers/net/ipxlat/packet.c
+++ b/drivers/net/ipxlat/packet.c
@@ -11,6 +11,8 @@
  *		Ralf Lici <ralf@mandelbit.com>
  */
 
+#include <linux/icmp.h>
+
 #include "packet.h"
 
 /* Shift cached skb cb offsets by the L3 header delta after in-place rewrite.
@@ -88,9 +90,315 @@ bool ipxlat_cb_offsets_valid(const struct ipxlat_cb *cb)
 }
 #endif
 
-int ipxlat_v4_validate_skb(struct ipxlat_priv *ipxl, struct sk_buff *skb)
+static bool ipxlat_v4_validate_addr(__be32 addr4)
 {
-	return -EOPNOTSUPP;
+	return !(ipv4_is_zeronet(addr4) || ipv4_is_loopback(addr4) ||
+		 ipv4_is_multicast(addr4) || ipv4_is_lbcast(addr4));
+}
+
+/* RFC 7915 Section 4.1 requires ignoring IPv4 options unless an unexpired
+ * LSRR/SSRR is present, in which case we must send ICMPv4 SR_FAILED.
+ * We intentionally treat malformed option encoding as invalid input and
+ * drop early instead of continuing translation.
+ */
+static int ipxlat_v4_srr_check(struct sk_buff *skb, const struct iphdr *hdr)
+{
+	const u8 *opt, *end;
+	u8 type, len, ptr;
+
+	if (likely(hdr->ihl <= 5))
+		return 0;
+
+	opt = (const u8 *)(hdr + 1);
+	end = (const u8 *)hdr + (hdr->ihl << 2);
+
+	while (opt < end) {
+		type = opt[0];
+		if (type == IPOPT_END)
+			return 0;
+		if (type == IPOPT_NOOP) {
+			opt++;
+			continue;
+		}
+
+		if (unlikely(end - opt < 2))
+			return -EINVAL;
+
+		len = opt[1];
+		if (unlikely(len < 2 || opt + len > end))
+			return -EINVAL;
+
+		if (type == IPOPT_LSRR || type == IPOPT_SSRR) {
+			if (unlikely(len < 3))
+				return -EINVAL;
+
+			/* points to the beginning of the next IP addr */
+			ptr = opt[2];
+			if (unlikely(ptr < 4))
+				return -EINVAL;
+			if (unlikely(ptr > len))
+				return 0;
+			if (unlikely(ptr > len - 3))
+				return -EINVAL;
+
+			return -EINVAL;
+		}
+
+		opt += len;
+	}
+
+	return 0;
+}
+
+static int ipxlat_v4_pull_l3(struct sk_buff *skb, unsigned int l3_offset,
+			     bool inner)
+{
+	const struct iphdr *iph;
+	unsigned int tot_len;
+	int l3_len;
+
+	if (unlikely(!pskb_may_pull(skb, l3_offset + sizeof(*iph))))
+		return -EINVAL;
+
+	iph = (const struct iphdr *)(skb->data + l3_offset);
+	if (unlikely(iph->version != 4 || iph->ihl < 5))
+		return -EINVAL;
+
+	l3_len = iph->ihl << 2;
+	/* For inner packets use ntohs(iph->tot_len) instead of iph_totlen.
+	 * If inner iph->tot_len is zero, iph_totlen would fall back to outer
+	 * GSO metadata, which is unrelated to quoted inner packet length.
+	 */
+	tot_len = unlikely(inner) ? ntohs(iph->tot_len) : iph_totlen(skb, iph);
+	if (unlikely(tot_len < l3_len))
+		return -EINVAL;
+
+	if (unlikely(!pskb_may_pull(skb, l3_offset + l3_len)))
+		return -EINVAL;
+
+	return l3_len;
+}
+
+static int ipxlat_v4_pull_l4(struct sk_buff *skb, unsigned int l4_offset,
+			     u8 l4_proto, bool *is_icmp_err)
+{
+	struct icmphdr *icmp;
+	struct udphdr *udp;
+	struct tcphdr *tcp;
+
+	*is_icmp_err = false;
+
+	switch (l4_proto) {
+	case IPPROTO_TCP:
+		if (unlikely(!pskb_may_pull(skb, l4_offset + sizeof(*tcp))))
+			return -EINVAL;
+
+		tcp = (struct tcphdr *)(skb->data + l4_offset);
+		if (unlikely(tcp->doff < 5))
+			return -EINVAL;
+
+		return __tcp_hdrlen(tcp);
+	case IPPROTO_UDP:
+		if (unlikely(!pskb_may_pull(skb, l4_offset + sizeof(*udp))))
+			return -EINVAL;
+
+		udp = (struct udphdr *)(skb->data + l4_offset);
+		if (unlikely(ntohs(udp->len) < sizeof(*udp)))
+			return -EINVAL;
+
+		return sizeof(struct udphdr);
+	case IPPROTO_ICMP:
+		if (unlikely(!pskb_may_pull(skb, l4_offset + sizeof(*icmp))))
+			return -EINVAL;
+
+		icmp = (struct icmphdr *)(skb->data + l4_offset);
+		*is_icmp_err = icmp_is_err(icmp->type);
+		return sizeof(struct icmphdr);
+	default:
+		return 0;
+	}
+}
+
+static int ipxlat_v4_pull_icmp_inner(struct sk_buff *skb,
+				     unsigned int inner_l3_off)
+{
+	struct ipxlat_cb *cb = ipxlat_skb_cb(skb);
+	const struct iphdr *inner_l3_hdr;
+	unsigned int inner_l4_off;
+	int inner_l3_len, err;
+	bool is_icmp_err;
+
+	inner_l3_len = ipxlat_v4_pull_l3(skb, inner_l3_off, true);
+	if (unlikely(inner_l3_len < 0))
+		return inner_l3_len;
+	inner_l3_hdr = (const struct iphdr *)(skb->data + inner_l3_off);
+
+	/* accept non-first quoted fragments: only inner L3 is translatable */
+	inner_l4_off = inner_l3_off + inner_l3_len;
+	cb->inner_l3_offset = inner_l3_off;
+	cb->inner_l3_hdr_len = inner_l3_len;
+	cb->inner_l4_offset = inner_l4_off;
+
+	if (unlikely(!ipxlat_is_first_frag4(inner_l3_hdr)))
+		return 0;
+
+	err = ipxlat_v4_pull_l4(skb, inner_l4_off, inner_l3_hdr->protocol,
+				&is_icmp_err);
+	if (unlikely(err < 0))
+		return err;
+	if (unlikely(is_icmp_err))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int ipxlat_v4_pull_hdrs(struct sk_buff *skb)
+{
+	const unsigned int l3_off = skb_network_offset(skb);
+	struct ipxlat_cb *cb = ipxlat_skb_cb(skb);
+	int err, l3_len, l4_len = 0;
+	const struct iphdr *l3_hdr;
+
+	/* parse IPv4 header and get its full length including options */
+	l3_len = ipxlat_v4_pull_l3(skb, l3_off, false);
+	if (unlikely(l3_len < 0))
+		return l3_len;
+	l3_hdr = ip_hdr(skb);
+
+	if (unlikely(!ipxlat_v4_validate_addr(l3_hdr->daddr)))
+		return -EINVAL;
+
+	/* RFC 7915 Section 4.1 */
+	if (unlikely(ipxlat_v4_srr_check(skb, l3_hdr)))
+		return -EINVAL;
+	if (unlikely(l3_hdr->ttl <= 1))
+		return -EINVAL;
+
+	/* RFC 7915 Section 1.2:
+	 * Fragmented ICMP/ICMPv6 packets will not be translated by IP/ICMP
+	 * translators.
+	 */
+	if (unlikely(l3_hdr->protocol == IPPROTO_ICMP &&
+		     ip_is_fragment(l3_hdr)))
+		return -EINVAL;
+
+	cb->l3_hdr_len = l3_len;
+	cb->l4_proto = l3_hdr->protocol;
+	cb->l4_off = l3_off + l3_len;
+	cb->payload_off = cb->l4_off;
+	cb->is_icmp_err = false;
+
+	/* only non fragmented packets or first fragments have transport hdrs */
+	if (unlikely(!ipxlat_is_first_frag4(l3_hdr))) {
+		if (unlikely(!ipxlat_v4_validate_addr(l3_hdr->saddr)))
+			return -EINVAL;
+		return 0;
+	}
+
+	l4_len = ipxlat_v4_pull_l4(skb, cb->l4_off, l3_hdr->protocol,
+				   &cb->is_icmp_err);
+	if (unlikely(l4_len < 0))
+		return l4_len;
+
+	/* RFC 7915 Section 4.1:
+	 * Illegal IPv4 sources are accepted only for ICMPv4 error translation.
+	 */
+	if (unlikely(!ipxlat_v4_validate_addr(l3_hdr->saddr) &&
+		     !cb->is_icmp_err))
+		return -EINVAL;
+
+	cb->payload_off = cb->l4_off + l4_len;
+
+	if (unlikely(cb->is_icmp_err)) {
+		/* validate the quoted packet in an ICMP error */
+		err = ipxlat_v4_pull_icmp_inner(skb, cb->payload_off);
+		if (unlikely(err))
+			return err;
+	}
+
+	return 0;
+}
+
+static int ipxlat_v4_validate_icmp_csum(const struct sk_buff *skb)
+{
+	__sum16 csum;
+
+	/* skip when checksum is not software-owned */
+	if (skb->ip_summed != CHECKSUM_NONE)
+		return 0;
+
+	/* compute checksum over ICMP header and payload, then fold to 16-bit
+	 * Internet checksum to validate it
+	 */
+	csum = csum_fold(skb_checksum(skb, skb_transport_offset(skb),
+				      ipxlat_skb_datagram_len(skb), 0));
+	return unlikely(csum) ? -EINVAL : 0;
+}
+
+/**
+ * ipxlat_v4_validate_skb - validate IPv4 input and fill parser metadata in cb
+ * @ipxlat: translator private context
+ * @skb: packet to validate
+ *
+ * Ensures required headers are present/consistent and stores parsed offsets
+ * into &struct ipxlat_cb for the translation path.
+ *
+ * Return: 0 on success, negative errno on validation failure.
+ */
+int ipxlat_v4_validate_skb(struct ipxlat_priv *ipxlat, struct sk_buff *skb)
+{
+	struct ipxlat_cb *cb = ipxlat_skb_cb(skb);
+	struct iphdr *l3_hdr;
+	struct udphdr *udph;
+	int err;
+
+	if (unlikely(skb_shared(skb)))
+		return -EINVAL;
+
+	err = ipxlat_v4_pull_hdrs(skb);
+	if (unlikely(err))
+		return err;
+
+	skb_set_transport_header(skb, cb->l4_off);
+
+	if (unlikely(cb->is_icmp_err)) {
+		if (unlikely(cb->l4_proto != IPPROTO_ICMP)) {
+			DEBUG_NET_WARN_ON_ONCE(1);
+			return -EINVAL;
+		}
+
+		/* Translation path recomputes ICMPv6 checksum from scratch.
+		 * Validate here so a corrupted ICMPv4 error is not converted
+		 * into a translated packet with a valid checksum.
+		 */
+		return ipxlat_v4_validate_icmp_csum(skb);
+	}
+
+	l3_hdr = ip_hdr(skb);
+	if (likely(cb->l4_proto != IPPROTO_UDP))
+		return 0;
+	if (unlikely(!ipxlat_is_first_frag4(l3_hdr)))
+		return 0;
+
+	udph = udp_hdr(skb);
+	if (likely(udph->check != 0))
+		return 0;
+
+	/* We are in the path where L4 header is present (unfragmented packets
+	 * or first fragments) and is UDP.
+	 * Fragmented checksum-less IPv4 UDP is rejected because 4->6 cannot
+	 * reliably translate it.
+	 */
+	if (unlikely(ip_is_fragment(l3_hdr)))
+		return -EINVAL;
+
+	/* udph->len bounds the span used to compute replacement checksum */
+	if (unlikely(ntohs(udph->len) > skb->len - cb->l4_off))
+		return -EINVAL;
+
+	cb->udp_zero_csum_len = ntohs(udph->len);
+
+	return 0;
 }
 
 int ipxlat_v6_validate_skb(struct sk_buff *skb)
-- 
2.53.0


