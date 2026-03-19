Return-Path: <netdev+bounces-269494-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sK6SDg8UvGnbrwIAu9opvQ
	(envelope-from <netdev+bounces-269494-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:19:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 867B52CD946
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF1D6326EF63
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 15:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A0F3E0C7F;
	Thu, 19 Mar 2026 15:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="s07lKALh"
X-Original-To: netdev@vger.kernel.org
Received: from mout-b-107.mailbox.org (mout-b-107.mailbox.org [195.10.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B9A3DBD4C;
	Thu, 19 Mar 2026 15:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773933236; cv=none; b=P07N0oqqzY13GIZJ4E2Pz7krifON4YVrmDks395NNVUA1CB5YU3UB2d5Zq4wdZ5M7QaBfcgHWxgd2tujBNMDmmnVs0iY6xXcabYosL2izpqGYKTupIb/Swt3FqkNlevBVQlgV28NeSDd5sRKcwN2jeaTVYJ3yq5llJKBv8XZkIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773933236; c=relaxed/simple;
	bh=iv/RoZG2i0Vfix/pw0Pn5MBTtScs4OUE8WnIBTXtYW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z4d3gbZfQFeS0kwVuQe7aYlsAwcVSZ2YNHa8OlkFGM4RNe7G4qSrUt9+oywMMMQC0384Wdrq1B6IDzbrGke95JBEMfGNrCx9lnPW9M7DwuGiNGLED3tXo4YEMskZv5aWEj/5Is3K/P2p5CmgXkIz1iOjEuUWP8SLdZ1laAHEOhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=s07lKALh; arc=none smtp.client-ip=195.10.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-107.mailbox.org (Postfix) with ESMTPS id 4fc8NZ5XYMzDs35;
	Thu, 19 Mar 2026 16:13:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1773933230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BdVIX3OEz97Rndlxx28vLkvE2hbfipn+YTLQYxmB624=;
	b=s07lKALh/eJ7qxH1/6ap4ZTVqx+NCt5z7y8QD84eYiuKyb/QsDK2CKmjLPgAW4teW0stgo
	21CxSMPuDLnYw2RaDk96ETwqMGrpUW3tX7PBDZr5md6+kt8Zi4RxN94dOZQ5RNeaVlYdnr
	E5gjWm7YQ2TfJj/ZLGdDwNMOPlDpQm4wRnZUOHp+9lbaipUuyqsrV/0ZmyAupwxHu7RSOl
	R/TpoTs+W36uhAzy7ozY6RLCSbwHbm7IASBJIK//3me5yZ6J1PdZsyfH9lf5SclV6IAzHd
	LRVUIi0axJga3p1M22cBc4+qu4W5NOQSHeCt2L/sfQ8rJU1VedlmpSrIrrdq+A==
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
Subject: [RFC net-next 12/15] ipxlat: add ICMP error translation and quoted-inner handling
Date: Thu, 19 Mar 2026 16:12:21 +0100
Message-ID: <20260319151230.655687-13-ralf@mandelbit.com>
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
	TAGGED_FROM(0.00)[bounces-269494-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.923];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mandelbit.com:dkim,mandelbit.com:email,mandelbit.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 867B52CD946
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Extend ICMP translation with error-path support for both directions,
including quoted-inner packet rewriting and RFC 4884 extension
relayout/squeeze logic.

This adds the ICMP type/code/error-field mappings, inner L3/L4 rewrite
paths, and final checksum handling required for translator ICMP error
processing.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ipxlat/icmp.h      |  14 +-
 drivers/net/ipxlat/icmp_46.c   | 467 ++++++++++++++++++++++++++++++++-
 drivers/net/ipxlat/icmp_64.c   | 453 +++++++++++++++++++++++++++++++-
 drivers/net/ipxlat/transport.c |  61 +++++
 drivers/net/ipxlat/transport.h |  19 ++
 5 files changed, 996 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ipxlat/icmp.h b/drivers/net/ipxlat/icmp.h
index 52d681787d6a..71bd7e20af91 100644
--- a/drivers/net/ipxlat/icmp.h
+++ b/drivers/net/ipxlat/icmp.h
@@ -19,22 +19,24 @@
 #include "ipxlpriv.h"
 
 /**
- * ipxlat_46_icmp - translate ICMP informational payload
- *		    after outer 4->6 rewrite
- * @ipxl: translator private context
+ * ipxlat_46_icmp - translate ICMP payload after outer 4->6 L3 rewrite
+ * @ipxlat: translator private context
  * @skb: packet carrying ICMPv4 transport payload
  *
+ * Handles both ICMP info translation and ICMP error quoted-inner rewriting.
+ *
  * Return: 0 on success, negative errno on translation failure.
  */
-int ipxlat_46_icmp(struct ipxlat_priv *ipxl, struct sk_buff *skb);
+int ipxlat_46_icmp(struct ipxlat_priv *ipxlat, struct sk_buff *skb);
 
 /**
- * ipxlat_64_icmp - translate ICMP informational payload
- *		    after outer 6->4 rewrite
+ * ipxlat_64_icmp - translate ICMP payload after outer 6->4 L3 rewrite
  * @ipxlat: translator private context
  * @skb: packet carrying ICMPv6 transport payload
  * @in6: snapshot of original outer IPv6 header
  *
+ * Handles both ICMP info translation and ICMP error quoted-inner rewriting.
+ *
  * Return: 0 on success, negative errno on translation failure.
  */
 int ipxlat_64_icmp(struct ipxlat_priv *ipxlat, struct sk_buff *skb,
diff --git a/drivers/net/ipxlat/icmp_46.c b/drivers/net/ipxlat/icmp_46.c
index ad907f60416c..41a91d4bc3dc 100644
--- a/drivers/net/ipxlat/icmp_46.c
+++ b/drivers/net/ipxlat/icmp_46.c
@@ -11,13 +11,49 @@
  *		Ralf Lici <ralf@mandelbit.com>
  */
 
-#include <linux/icmp.h>
-#include <linux/icmpv6.h>
-
+#include "address.h"
 #include "icmp.h"
 #include "packet.h"
+#include "translate_46.h"
 #include "transport.h"
 
+#define IPXLAT_ICMP4_PP_CODE_PTR 0
+#define IPXLAT_ICMP4_PP_CODE_BADLEN 2
+
+/* RFC 7915 Section 4.2, Figure 3 */
+static const u8 ipxlat_46_icmp_param_prob_map[] = { 0,	1,    4,    4,	0xff,
+						  0xff, 0xff, 0xff, 7,	6,
+						  0xff, 0xff, 8,    8,	8,
+						  8,	24,   24,   24, 24 };
+
+/* RFC 1191 plateau table used when ICMPv4 FRAG_NEEDED reports MTU=0 */
+static const u16 ipxlat_46_mtu_plateaus[] = {
+	65535, 32000, 17914, 8166, 4352, 2002, 1492,
+};
+
+static u8 ipxlat_icmp4_get_param_ptr(const struct icmphdr *ic4)
+{
+	return ntohl(ic4->un.gateway) >> 24;
+}
+
+static int ipxlat_46_map_icmp_param_prob(const struct icmphdr *in,
+					 struct icmp6hdr *out)
+{
+	u8 ptr;
+
+	if (unlikely(in->code != IPXLAT_ICMP4_PP_CODE_PTR &&
+		     in->code != IPXLAT_ICMP4_PP_CODE_BADLEN))
+		return -EPROTONOSUPPORT;
+
+	ptr = ipxlat_icmp4_get_param_ptr(in);
+	if (unlikely(ptr >= ARRAY_SIZE(ipxlat_46_icmp_param_prob_map) ||
+		     ipxlat_46_icmp_param_prob_map[ptr] == 0xff))
+		return -EPROTONOSUPPORT;
+
+	out->icmp6_pointer = cpu_to_be32(ipxlat_46_icmp_param_prob_map[ptr]);
+	return 0;
+}
+
 static int ipxlat_46_map_icmp_info_type_code(const struct icmphdr *in,
 					     struct icmp6hdr *out)
 {
@@ -39,6 +75,165 @@ static int ipxlat_46_map_icmp_info_type_code(const struct icmphdr *in,
 	return -EPROTONOSUPPORT;
 }
 
+static __be32 ipxlat_46_compute_icmp_mtu6(unsigned int pkt_mtu,
+					  unsigned int nexthop6mtu,
+					  unsigned int nexthop4mtu,
+					  u16 tot_len_field)
+{
+	unsigned int i;
+	u32 result;
+
+	/* RFC 7915 Section 4.2:
+	 * If the IPv4 router set the MTU field to zero, then the translator
+	 * MUST use the plateau values specified in RFC 1191 to determine a
+	 * likely path MTU and include that path MTU in the ICMPv6 packet.
+	 */
+	if (unlikely(pkt_mtu == 0)) {
+		for (i = 0; i < ARRAY_SIZE(ipxlat_46_mtu_plateaus); i++) {
+			if (ipxlat_46_mtu_plateaus[i] < tot_len_field) {
+				pkt_mtu = ipxlat_46_mtu_plateaus[i];
+				break;
+			}
+		}
+	}
+
+	/* RFC 7915 Section 4.2:
+	 * max(1280, min(pkt_mtu + 20, mtu6_nexthop, mtu4_nexthop + 20))
+	 *
+	 * pkt_mtu + 20 converts ICMPv4-reported MTU to IPv6 context.
+	 * mtu6_nexthop and mtu4_nexthop + 20 clamp to local next-hop limits.
+	 * max(..., 1280) enforces IPv6 minimum MTU.
+	 */
+	result = min(pkt_mtu + 20, min(nexthop6mtu, nexthop4mtu + 20));
+	if (result < IPV6_MIN_MTU)
+		result = IPV6_MIN_MTU;
+
+	return cpu_to_be32(result);
+}
+
+static int ipxlat_46_build_icmp_dest_unreach(struct ipxlat_priv *ipxlat,
+					     struct sk_buff *skb,
+					     const struct icmphdr *in,
+					     struct icmp6hdr *out,
+					     const struct iphdr *inner4)
+{
+	unsigned int inner4_tot_len, in_frag_mtu, in_mtu, out_mtu;
+
+	switch (in->code) {
+	case ICMP_NET_UNREACH:
+	case ICMP_HOST_UNREACH:
+	case ICMP_SR_FAILED:
+	case ICMP_NET_UNKNOWN:
+	case ICMP_HOST_UNKNOWN:
+	case ICMP_HOST_ISOLATED:
+	case ICMP_NET_UNR_TOS:
+	case ICMP_HOST_UNR_TOS:
+	case ICMP_PORT_UNREACH:
+	case ICMP_NET_ANO:
+	case ICMP_HOST_ANO:
+	case ICMP_PKT_FILTERED:
+	case ICMP_PREC_CUTOFF:
+		out->icmp6_unused = 0;
+		return 0;
+	case ICMP_PROT_UNREACH:
+		out->icmp6_pointer =
+			cpu_to_be32(offsetof(struct ipv6hdr, nexthdr));
+		return 0;
+	case ICMP_FRAG_NEEDED:
+		in_frag_mtu = be16_to_cpu(in->un.frag.mtu);
+		inner4_tot_len = be16_to_cpu(inner4->tot_len);
+		in_mtu = READ_ONCE(ipxlat->dev->mtu);
+		out_mtu = ipxlat_46_lookup_pmtu6(ipxlat, skb, inner4);
+
+		out->icmp6_mtu =
+			ipxlat_46_compute_icmp_mtu6(in_frag_mtu, out_mtu,
+						    in_mtu, inner4_tot_len);
+		return 0;
+	}
+
+	return -EPROTONOSUPPORT;
+}
+
+static int ipxlat_46_map_icmp_type_code(struct ipxlat_priv *ipxlat,
+					struct sk_buff *skb,
+					const struct icmphdr *in,
+					struct icmp6hdr *out,
+					const struct iphdr *inner4,
+					bool *ie_forbidden)
+{
+	int err;
+
+	*ie_forbidden = false;
+
+	switch (in->type) {
+	case ICMP_ECHO:
+	case ICMP_ECHOREPLY:
+		return ipxlat_46_map_icmp_info_type_code(in, out);
+	case ICMP_DEST_UNREACH:
+		switch (in->code) {
+		case ICMP_NET_UNREACH:
+		case ICMP_HOST_UNREACH:
+		case ICMP_SR_FAILED:
+		case ICMP_NET_UNKNOWN:
+		case ICMP_HOST_UNKNOWN:
+		case ICMP_HOST_ISOLATED:
+		case ICMP_NET_UNR_TOS:
+		case ICMP_HOST_UNR_TOS:
+			out->icmp6_type = ICMPV6_DEST_UNREACH;
+			out->icmp6_code = ICMPV6_NOROUTE;
+			break;
+		case ICMP_PROT_UNREACH:
+			out->icmp6_type = ICMPV6_PARAMPROB;
+			out->icmp6_code = ICMPV6_UNK_NEXTHDR;
+			*ie_forbidden = true;
+			break;
+		case ICMP_PORT_UNREACH:
+			out->icmp6_type = ICMPV6_DEST_UNREACH;
+			out->icmp6_code = ICMPV6_PORT_UNREACH;
+			break;
+		case ICMP_FRAG_NEEDED:
+			out->icmp6_type = ICMPV6_PKT_TOOBIG;
+			out->icmp6_code = 0;
+			*ie_forbidden = true;
+			break;
+		case ICMP_NET_ANO:
+		case ICMP_HOST_ANO:
+		case ICMP_PKT_FILTERED:
+		case ICMP_PREC_CUTOFF:
+			out->icmp6_type = ICMPV6_DEST_UNREACH;
+			out->icmp6_code = ICMPV6_ADM_PROHIBITED;
+			break;
+		default:
+			return -EPROTONOSUPPORT;
+		}
+			return ipxlat_46_build_icmp_dest_unreach(ipxlat,
+								 skb, in, out,
+								 inner4);
+	case ICMP_TIME_EXCEEDED:
+		out->icmp6_type = ICMPV6_TIME_EXCEED;
+		out->icmp6_code = in->code;
+		out->icmp6_unused = 0;
+		return 0;
+	case ICMP_PARAMETERPROB:
+		out->icmp6_type = ICMPV6_PARAMPROB;
+		*ie_forbidden = true;
+		switch (in->code) {
+		case IPXLAT_ICMP4_PP_CODE_PTR:
+		case IPXLAT_ICMP4_PP_CODE_BADLEN:
+			out->icmp6_code = ICMPV6_HDR_FIELD;
+			break;
+		default:
+			return -EPROTONOSUPPORT;
+		}
+		err = ipxlat_46_map_icmp_param_prob(in, out);
+		if (unlikely(err))
+			return err;
+		return 0;
+	}
+
+	return -EPROTONOSUPPORT;
+}
+
 static void ipxlat_46_icmp_info_update_csum(const struct icmphdr *icmp4,
 					    struct icmp6hdr *icmp6,
 					    const struct ipv6hdr *ip6,
@@ -86,10 +281,272 @@ static int ipxlat_46_icmp_info_outer(struct sk_buff *skb)
 	return 0;
 }
 
-int ipxlat_46_icmp(struct ipxlat_priv *ipxl, struct sk_buff *skb)
+static int ipxlat_46_icmp_info_inner(struct sk_buff *skb,
+				     unsigned int inner_l4_off,
+				     const struct ipv6hdr *inner6)
+{
+	struct icmp6hdr *icmp6;
+	struct icmphdr icmp4;
+	int err;
+
+	/* inner header alignment is not guaranteed */
+	memcpy(&icmp4, skb->data + inner_l4_off, sizeof(icmp4));
+	icmp6 = (struct icmp6hdr *)(skb->data + inner_l4_off);
+
+	err = ipxlat_46_map_icmp_info_type_code(&icmp4, icmp6);
+	if (unlikely(err))
+		return -EINVAL;
+
+	ipxlat_46_icmp_info_update_csum(&icmp4, icmp6, inner6, skb,
+					inner_l4_off);
+	return 0;
+}
+
+static int ipxlat_46_icmp_inner_l4(struct sk_buff *skb,
+				   unsigned int inner_l4_off,
+				   const struct iphdr *inner4,
+				   const struct ipv6hdr *inner6)
+{
+	struct tcphdr *tcp;
+	struct udphdr *udp;
+
+	switch (inner4->protocol) {
+	case IPPROTO_TCP:
+		tcp = (struct tcphdr *)(skb->data + inner_l4_off);
+		return ipxlat_46_inner_tcp(skb, inner4, inner6, tcp);
+	case IPPROTO_UDP:
+		udp = (struct udphdr *)(skb->data + inner_l4_off);
+		return ipxlat_46_inner_udp(skb, inner4, inner6, udp);
+	case IPPROTO_ICMP:
+		return ipxlat_46_icmp_info_inner(skb, inner_l4_off, inner6);
+	default:
+		return 0;
+	}
+}
+
+static int ipxlat_46_icmp_inner(struct ipxlat_priv *ipxlat,
+				struct sk_buff *skb, struct iphdr *inner4,
+				int *inner_delta)
+{
+	unsigned int inner_l3_len, inner_l3_off, inner_l4_off, old_prefix,
+		new_prefix, inner_tot_len, inner_l3_payload, inner_l4_payload;
+	const unsigned int outer_l3_len = skb_transport_offset(skb);
+	const struct ipxlat_cb *cb = ipxlat_skb_cb(skb);
+	struct ipv6hdr outer_ip6_copy, *inner_ip6;
+	struct frag_hdr *fh6;
+	u8 next_hdr;
+	bool has_inner_frag;
+
+	inner_l3_off = cb->inner_l3_offset;
+	inner_l4_off = cb->inner_l4_offset;
+
+	/* inner header alignment is not guaranteed */
+	memcpy(inner4, skb->data + inner_l3_off, sizeof(*inner4));
+	inner_l3_len = inner4->ihl << 2;
+	has_inner_frag = ip_is_fragment(inner4);
+
+	/* save outer IPv6 hdr because pull+push destroys that hdr region */
+	outer_ip6_copy = *ipv6_hdr(skb);
+
+	old_prefix = inner_l3_off + inner_l3_len;
+	new_prefix = inner_l3_off + sizeof(struct ipv6hdr) +
+		     (has_inner_frag ? sizeof(struct frag_hdr) : 0);
+	*inner_delta = (int)new_prefix - (int)old_prefix;
+
+	if (unlikely(skb_cow_head(skb, max_t(int, 0, *inner_delta))))
+		return -ENOMEM;
+
+	skb_pull(skb, old_prefix);
+	skb_push(skb, new_prefix);
+	/* outer 4->6 path already set header offsets, but inner relayout
+	 * pulls/pushes change skb->data placement. Reinitialize outer header
+	 * offsets so ip{,v6}_hdr/icmp{,6}_hdr and skb_transport_offset keep
+	 * pointing to the outer packet.
+	 */
+	skb_reset_network_header(skb);
+	skb_set_transport_header(skb, outer_l3_len);
+
+	*ipv6_hdr(skb) = outer_ip6_copy;
+	ipv6_hdr(skb)->payload_len = htons(skb->len - sizeof(struct ipv6hdr));
+
+	inner_ip6 = (struct ipv6hdr *)(skb->data + inner_l3_off);
+	/* use quoted IPv4 total-length, not skb->len:
+	 * skb->len also includes ICMP extension bytes at the end, which are
+	 * not part of the quoted inner IP datagram length.
+	 */
+	inner_tot_len = ntohs(inner4->tot_len);
+	if (unlikely(inner_tot_len < inner_l3_len))
+		return -EINVAL;
+
+	inner_l3_payload = inner_tot_len - inner_l3_len +
+			   (has_inner_frag ? sizeof(struct frag_hdr) : 0);
+	if (has_inner_frag)
+		next_hdr = NEXTHDR_FRAGMENT;
+	else
+		next_hdr = ipxlat_46_map_proto_to_nexthdr(inner4->protocol);
+
+	ipxlat_46_build_l3(inner_ip6, inner4, inner_l3_payload, next_hdr,
+			   inner4->ttl);
+
+	ipxlat_46_convert_addrs(&ipxlat->xlat_prefix6, inner4, inner_ip6);
+
+	if (unlikely(has_inner_frag)) {
+		fh6 = (struct frag_hdr *)(inner_ip6 + 1);
+		ipxlat_46_build_frag_hdr(fh6, inner4, inner4->protocol);
+	}
+
+	if (unlikely(!ipxlat_is_first_frag4(inner4)))
+		return 0;
+
+	inner_l4_payload = new_prefix + ipxlat_l4_min_len(inner4->protocol);
+	if (unlikely(skb_ensure_writable(skb, inner_l4_payload)))
+		return -ENOMEM;
+
+	return ipxlat_46_icmp_inner_l4(skb, new_prefix, inner4, inner_ip6);
+}
+
+/* Adjust ICMP error quoted-datagram/extensions after inner 4->6 translation.
+ * The inner rewrite changes quoted datagram length; this helper recomputes
+ * RFC 4884 delimiter/padding, preserves extensions only when allowed, and
+ * enforces IPv6 minimum-MTU packet size constraints.
+ */
+static int ipxlat_46_icmp_squeeze_ext(struct sk_buff *skb,
+				      unsigned int icmp4_ipl, int inner_delta,
+				      bool ie_forbidden)
+{
+	unsigned int icmp6_iel_in, icmp6_iel_out, max_iel, outer_hdrs_len,
+		out_pad, payload_len, icmp6_ipl_out_bytes, pkt_len_cap;
+	unsigned int icmp6_ipl_out = 0;
+	int icmp6_ipl_in_bytes, err;
+	struct icmp6hdr *ic6;
+	struct ipv6hdr *iph6;
+
+	/* icmp4_ipl marks where quoted datagram ends and extension area starts
+	 */
+	if (likely(!icmp4_ipl))
+		goto no_extensions;
+
+	outer_hdrs_len = skb_transport_offset(skb) + sizeof(struct icmp6hdr);
+	payload_len = skb->len - outer_hdrs_len;
+	icmp6_ipl_in_bytes = icmp4_ipl + inner_delta;
+	if (unlikely(icmp6_ipl_in_bytes < 0 ||
+		     icmp6_ipl_in_bytes > payload_len))
+		return -EINVAL;
+
+	if (likely(icmp6_ipl_in_bytes == payload_len))
+		goto no_extensions;
+
+	icmp6_iel_in = payload_len - icmp6_ipl_in_bytes;
+	max_iel = IPV6_MIN_MTU - (outer_hdrs_len + ICMP_EXT_ORIG_DGRAM_MIN_LEN);
+
+	if (unlikely(ie_forbidden || icmp6_iel_in > max_iel)) {
+		pkt_len_cap = min_t(unsigned int, skb->len - icmp6_iel_in,
+				    IPV6_MIN_MTU);
+		icmp6_ipl_out_bytes = pkt_len_cap - outer_hdrs_len;
+		out_pad = 0;
+		icmp6_iel_out = 0;
+		icmp6_ipl_out = 0;
+	} else {
+		pkt_len_cap = min_t(unsigned int, skb->len, IPV6_MIN_MTU);
+		icmp6_ipl_out_bytes =
+			round_down(pkt_len_cap - icmp6_iel_in - outer_hdrs_len,
+				   sizeof(u64));
+		out_pad = max_t(unsigned int, ICMP_EXT_ORIG_DGRAM_MIN_LEN,
+				icmp6_ipl_out_bytes) -
+			  icmp6_ipl_out_bytes;
+		icmp6_iel_out = icmp6_iel_in;
+		icmp6_ipl_out = (icmp6_ipl_out_bytes + out_pad) >> 3;
+	}
+
+	/* if no extension bytes are copied and no pad is written, relayout only
+	 * trims/updates lengths and does not require full data writability
+	 */
+	if (unlikely(icmp6_iel_out || out_pad)) {
+		err = skb_ensure_writable(skb, skb->len);
+		if (unlikely(err))
+			return err;
+	}
+
+	err = ipxlat_icmp_relayout(skb, outer_hdrs_len, icmp6_ipl_in_bytes,
+				   icmp6_iel_in, icmp6_ipl_out_bytes, out_pad,
+				   icmp6_iel_out);
+	if (unlikely(err))
+		return err;
+
+	iph6 = ipv6_hdr(skb);
+	iph6->payload_len = htons(skb->len - sizeof(*iph6));
+
+no_extensions:
+	if (unlikely(skb->len > IPV6_MIN_MTU)) {
+		err = pskb_trim(skb, IPV6_MIN_MTU);
+		if (unlikely(err))
+			return err;
+
+		iph6 = ipv6_hdr(skb);
+		iph6->payload_len = htons(skb->len - sizeof(*iph6));
+	}
+
+	ic6 = icmp6_hdr(skb);
+	ic6->icmp6_datagram_len = icmp6_ipl_out;
+	return 0;
+}
+
+/**
+ * ipxlat_46_icmp_error - translate ICMPv4 error payload to ICMPv6 error form
+ * @ipxlat: translator private context
+ * @skb: packet carrying outer ICMPv4 error
+ *
+ * Rewrites the quoted inner datagram in place, maps type/code/fields and
+ * adjusts RFC 4884 datagram/extension layout before recomputing outer checksum.
+ *
+ * Return: 0 on success, negative errno on translation failure.
+ */
+static int ipxlat_46_icmp_error(struct ipxlat_priv *ipxlat, struct sk_buff *skb)
+{
+	const struct ipxlat_cb *cb = ipxlat_skb_cb(skb);
+	const struct icmphdr icmp4 = *icmp_hdr(skb);
+	struct iphdr inner4_ip;
+	int inner_delta, err;
+	bool ie_forbidden;
+
+	if (unlikely(!(cb->is_icmp_err))) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		return -EINVAL;
+	}
+
+	/* translate quoted inner packet headers */
+	err = ipxlat_46_icmp_inner(ipxlat, skb, &inner4_ip, &inner_delta);
+	if (unlikely(err))
+		return err;
+
+	err = ipxlat_46_map_icmp_type_code(ipxlat, skb, &icmp4, icmp6_hdr(skb),
+					   &inner4_ip, &ie_forbidden);
+	if (unlikely(err))
+		return err;
+
+	err = ipxlat_46_icmp_squeeze_ext(skb, icmp4.un.reserved[1] << 2,
+					 inner_delta, ie_forbidden);
+	if (unlikely(err))
+		return err;
+
+	/* error path rewrites quoted packet bytes/lengths, so use full
+	 * checksum recomputation instead of incremental update
+	 */
+	icmp6_hdr(skb)->icmp6_cksum = 0;
+	icmp6_hdr(skb)->icmp6_cksum =
+		ipxlat_l4_csum_ipv6(&ipv6_hdr(skb)->saddr,
+				    &ipv6_hdr(skb)->daddr, skb,
+				    skb_transport_offset(skb),
+				    ipxlat_skb_datagram_len(skb),
+				    IPPROTO_ICMPV6);
+	skb->ip_summed = CHECKSUM_NONE;
+	return 0;
+}
+
+int ipxlat_46_icmp(struct ipxlat_priv *ipxlat, struct sk_buff *skb)
 {
 	if (unlikely(ipxlat_skb_cb(skb)->is_icmp_err))
-		return -EPROTONOSUPPORT;
+		return ipxlat_46_icmp_error(ipxlat, skb);
 
 	return ipxlat_46_icmp_info_outer(skb);
 }
diff --git a/drivers/net/ipxlat/icmp_64.c b/drivers/net/ipxlat/icmp_64.c
index 6b11aa638068..18583620a09a 100644
--- a/drivers/net/ipxlat/icmp_64.c
+++ b/drivers/net/ipxlat/icmp_64.c
@@ -11,12 +11,38 @@
  *		Ralf Lici <ralf@mandelbit.com>
  */
 
-#include <linux/icmpv6.h>
+#include <net/route.h>
 
+#include "address.h"
 #include "icmp.h"
 #include "packet.h"
+#include "translate_64.h"
 #include "transport.h"
 
+#define IPXLAT_ICMP4_ERROR_MAX_LEN 576U
+
+/* RFC 7915 Section 5.2, Figure 4 */
+static const u8 ipxlat_64_icmp_param_prob_map[] = {
+	0,  1,	0xff, 0xff, 2,	2,  9,	8,  12, 12, 12, 12, 12, 12,
+	12, 12, 12,   12,   12, 12, 12, 12, 12, 12, 16, 16, 16, 16,
+	16, 16, 16,   16,   16, 16, 16, 16, 16, 16, 16, 16,
+};
+
+static int ipxlat_64_map_icmp_param_prob(u32 ptr6, u32 *ptr4)
+{
+	if (unlikely(ptr6 >= ARRAY_SIZE(ipxlat_64_icmp_param_prob_map) ||
+		     ipxlat_64_icmp_param_prob_map[ptr6] == 0xff))
+		return -EPROTONOSUPPORT;
+
+	*ptr4 = ipxlat_64_icmp_param_prob_map[ptr6];
+	return 0;
+}
+
+static void ipxlat_icmp4_set_param_ptr(struct icmphdr *ic4, u8 ptr)
+{
+	ic4->un.gateway = htonl((u32)ptr << 24);
+}
+
 static int ipxlat_64_map_icmp_info_type_code(const struct icmp6hdr *in,
 					     struct icmphdr *out)
 {
@@ -38,10 +64,119 @@ static int ipxlat_64_map_icmp_info_type_code(const struct icmp6hdr *in,
 	}
 }
 
-static __sum16 ipxlat_64_compute_icmp_info_csum(const struct ipv6hdr *in6,
-						const struct icmp6hdr *in_icmp6,
-						const struct icmphdr *out_icmp4,
-						unsigned int l4_len)
+/* Lookup post-translation IPv4 PMTU for ICMPv6 PTB -> ICMPv4 FRAG_NEEDED.
+ * Falls back to translator MTU on routing failures and clamps route MTU
+ * against translator egress MTU.
+ */
+static unsigned int ipxlat_64_lookup_pmtu4(struct ipxlat_priv *ipxlat,
+					   const struct sk_buff *skb)
+{
+	const struct iphdr *iph4;
+	struct flowi4 fl4 = {};
+	unsigned int dev_mtu;
+	struct rtable *rt;
+	unsigned int mtu4;
+
+	dev_mtu = READ_ONCE(ipxlat->dev->mtu);
+	iph4 = ip_hdr(skb);
+
+	fl4.daddr = iph4->daddr;
+	fl4.saddr = iph4->saddr;
+	fl4.flowi4_mark = skb->mark;
+	fl4.flowi4_proto = IPPROTO_ICMP;
+
+	rt = ip_route_output_key(dev_net(ipxlat->dev), &fl4);
+	if (IS_ERR(rt))
+		return dev_mtu;
+
+	/* clamp against translator MTU to avoid oversized local PMTU */
+	mtu4 = min_t(unsigned int, dst_mtu(&rt->dst), dev_mtu);
+	ip_rt_put(rt);
+
+	return mtu4;
+}
+
+static int ipxlat_64_build_icmp4_errhdr(struct ipxlat_priv *ipxlat,
+					struct sk_buff *skb,
+					const struct icmp6hdr *ic6,
+					struct icmphdr *ic4, bool *ie_forbidden)
+{
+	unsigned int in_mtu, out_mtu;
+	u32 ptr6, ptr4;
+	int err;
+
+	switch (ic6->icmp6_type) {
+	case ICMPV6_DEST_UNREACH:
+		ic4->type = ICMP_DEST_UNREACH;
+		switch (ic6->icmp6_code) {
+		case ICMPV6_NOROUTE:
+		case ICMPV6_NOT_NEIGHBOUR:
+		case ICMPV6_ADDR_UNREACH:
+			ic4->code = ICMP_HOST_UNREACH;
+			break;
+		case ICMPV6_ADM_PROHIBITED:
+			ic4->code = ICMP_HOST_ANO;
+			break;
+		case ICMPV6_PORT_UNREACH:
+			ic4->code = ICMP_PORT_UNREACH;
+			break;
+		default:
+			return -EINVAL;
+		}
+		ic4->un.gateway = 0;
+		*ie_forbidden = false;
+		return 0;
+	case ICMPV6_TIME_EXCEED:
+		ic4->type = ICMP_TIME_EXCEEDED;
+		ic4->code = ic6->icmp6_code;
+		ic4->un.gateway = 0;
+		*ie_forbidden = false;
+		return 0;
+	case ICMPV6_PKT_TOOBIG:
+		ic4->type = ICMP_DEST_UNREACH;
+		ic4->code = ICMP_FRAG_NEEDED;
+		ic4->un.frag.__unused = 0;
+		in_mtu = ipxlat_64_lookup_pmtu4(ipxlat, skb);
+		out_mtu = READ_ONCE(ipxlat->dev->mtu);
+		/* RFC 7915 Section 5.2:
+		 * min((PTB_mtu - 20), mtu4_nexthop, (mtu6_nexthop - 20))
+		 */
+		ic4->un.frag.mtu =
+			cpu_to_be16(min3(be32_to_cpu(ic6->icmp6_mtu) - 20,
+					 in_mtu, out_mtu - 20));
+		*ie_forbidden = true;
+		return 0;
+	case ICMPV6_PARAMPROB:
+		ptr6 = be32_to_cpu(ic6->icmp6_dataun.un_data32[0]);
+		switch (ic6->icmp6_code) {
+		case ICMPV6_HDR_FIELD:
+			ic4->type = ICMP_PARAMETERPROB;
+			ic4->code = 0;
+			err = ipxlat_64_map_icmp_param_prob(ptr6, &ptr4);
+			if (unlikely(err))
+				return err;
+			ipxlat_icmp4_set_param_ptr(ic4, ptr4);
+			break;
+		case ICMPV6_UNK_NEXTHDR:
+			ic4->type = ICMP_DEST_UNREACH;
+			ic4->code = ICMP_PROT_UNREACH;
+			ic4->un.gateway = 0;
+			break;
+		default:
+			return -EINVAL;
+		}
+		*ie_forbidden = true;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static __sum16
+ipxlat_64_compute_icmp_info_csum(const struct ipv6hdr *in6,
+				 const struct icmp6hdr *in_icmp6,
+				 const struct icmphdr *out_icmp4,
+				 unsigned int l4_len)
 {
 	struct icmp6hdr icmp6_zero;
 	struct icmphdr icmp4_zero;
@@ -82,11 +217,315 @@ static int ipxlat_64_icmp_info(struct sk_buff *skb, const struct ipv6hdr *in6)
 	return 0;
 }
 
-int ipxlat_64_icmp(struct ipxlat_priv *ipxl, struct sk_buff *skb,
+static int ipxlat_64_icmp_inner_info(struct sk_buff *skb,
+				     unsigned int inner_l4_off)
+{
+	struct icmphdr *ic4;
+	struct icmp6hdr ic6;
+	int err;
+
+	/* inner header alignment is not guaranteed */
+	memcpy(&ic6, skb->data + inner_l4_off, sizeof(ic6));
+	ic4 = (struct icmphdr *)(skb->data + inner_l4_off);
+	err = ipxlat_64_map_icmp_info_type_code(&ic6, ic4);
+	if (unlikely(err))
+		return err;
+
+	ic4->checksum = 0;
+	ic4->checksum = csum_fold(skb_checksum(skb, inner_l4_off,
+					       skb->len - inner_l4_off, 0));
+	skb->ip_summed = CHECKSUM_NONE;
+	return 0;
+}
+
+static int ipxlat_64_icmp_inner_l4(struct sk_buff *skb,
+				   unsigned int inner_l4_off,
+				   const struct iphdr *inner4,
+				   const struct ipv6hdr *inner6)
+{
+	struct tcphdr *tcp;
+	struct udphdr *udp;
+
+	switch (inner4->protocol) {
+	case IPPROTO_TCP:
+		tcp = (struct tcphdr *)(skb->data + inner_l4_off);
+		return ipxlat_64_inner_tcp(skb, inner6, inner4, tcp);
+	case IPPROTO_UDP:
+		udp = (struct udphdr *)(skb->data + inner_l4_off);
+		return ipxlat_64_inner_udp(skb, inner6, inner4, udp);
+	case IPPROTO_ICMP:
+		return ipxlat_64_icmp_inner_info(skb, inner_l4_off);
+	default:
+		return 0;
+	}
+}
+
+static int ipxlat_64_icmp_inner(struct ipxlat_priv *ipxlat, struct sk_buff *skb,
+				int *inner_delta)
+{
+	unsigned int old_prefix, new_prefix, inner_l3_len, inner_tot_len,
+		inner_l4_payload, outer_prefix, inner_l3_off, inner_l4_old_off;
+	const unsigned int outer_l3_len = skb_transport_offset(skb);
+	const struct ipxlat_cb *cb = ipxlat_skb_cb(skb);
+	const struct iphdr outer4_copy = *ip_hdr(skb);
+	bool has_inner_frag, first_inner_frag, mf, df;
+	struct frag_hdr inner_fragh;
+	struct ipv6hdr inner6;
+	struct iphdr *inner4;
+	__be32 saddr, daddr;
+	u16 frag_off;
+	u8 inner_l4_proto;
+	__be16 frag_id;
+	int err;
+
+	inner_l3_off = cb->inner_l3_offset;
+	inner_l4_old_off = cb->inner_l4_offset;
+	inner_l3_len = inner_l4_old_off - inner_l3_off;
+	outer_prefix = inner_l3_off;
+
+	inner_l4_proto = ipxlat_64_map_nexthdr_proto(cb->inner_l4_proto);
+	has_inner_frag = !!cb->inner_fragh_off;
+
+	/* inner header alignment is not guaranteed */
+	memcpy(&inner6, skb->data + outer_prefix, sizeof(inner6));
+
+	first_inner_frag = true;
+	if (unlikely(has_inner_frag)) {
+		memcpy(&inner_fragh, skb->data + cb->inner_fragh_off,
+		       sizeof(inner_fragh));
+		first_inner_frag = ipxlat_is_first_frag6(&inner_fragh);
+	}
+
+	err = ipxlat_64_convert_addrs(&ipxlat->xlat_prefix6, &inner6, false,
+				      &saddr, &daddr);
+	if (unlikely(err))
+		return err;
+
+	old_prefix = outer_prefix + inner_l3_len;
+	new_prefix = outer_prefix + sizeof(struct iphdr);
+	*inner_delta = (int)new_prefix - (int)old_prefix;
+
+	/* unlike 46, inner 6->4 always shrinks quoted L3 size */
+	skb_pull(skb, old_prefix);
+	skb_push(skb, new_prefix);
+	/* outer 6->4 translation already set network/transport headers, but
+	 * inner relayout pulls/pushes again and changes skb->data placement.
+	 * Reinitialize outer header offsets so ip{,v6}_hdr/icmp{,6}_hdr and
+	 * skb_transport_offset keep pointing to the outer packet.
+	 */
+	skb_reset_network_header(skb);
+	skb_set_transport_header(skb, outer_l3_len);
+
+	*ip_hdr(skb) = outer4_copy;
+
+	inner4 = (struct iphdr *)(skb->data + outer_prefix);
+	inner_tot_len = ntohs(inner6.payload_len) + sizeof(inner6) -
+			inner_l3_len + sizeof(struct iphdr);
+	/* RFC 7915 Section 5.1 */
+	if (likely(!has_inner_frag)) {
+		df = inner_tot_len > (IPV6_MIN_MTU - sizeof(struct iphdr));
+		inner4->frag_off = ipxlat_build_frag4_offset(df, false, 0);
+	} else {
+		mf = !!(be16_to_cpu(inner_fragh.frag_off) & IP6_MF);
+		frag_off = ipxlat_get_frag6_offset(&inner_fragh);
+		inner4->frag_off =
+			ipxlat_build_frag4_offset(false, mf, frag_off);
+	}
+
+	/* keep low 16 bits of IPv6 Fragment ID as numeric value, then re-encode
+	 * to network-order IPv4 ID
+	 */
+	frag_id = has_inner_frag ?
+			  cpu_to_be16(be32_to_cpu(inner_fragh.identification)) :
+			  0;
+	ipxlat_64_build_l3(inner4, &inner6, inner_tot_len, inner4->frag_off,
+			   inner_l4_proto, saddr, daddr, inner6.hop_limit,
+			   frag_id);
+
+	if (likely(!has_inner_frag)) {
+		inner4->id = 0;
+		__ip_select_ident(dev_net(ipxlat->dev), inner4, 1);
+		inner4->check = 0;
+		inner4->check = ip_fast_csum(inner4, inner4->ihl);
+	}
+
+	if (unlikely(!first_inner_frag))
+		return 0;
+
+	inner_l4_payload = new_prefix + ipxlat_l4_min_len(inner4->protocol);
+	if (unlikely(skb_ensure_writable(skb, inner_l4_payload)))
+		return -ENOMEM;
+
+	return ipxlat_64_icmp_inner_l4(skb, new_prefix, inner4, &inner6);
+}
+
+/* Rebuild ICMPv4 quoted-datagram/extensions after inner 6->4 translation.
+ *
+ * The inner rewrite changes the quoted datagram length. This helper updates
+ * the RFC 4884 delimiter/padding and extension bytes, then enforces the
+ * IPv4 ICMP error size cap.
+ *
+ * This is intentionally not a mirror of ipxlat_46_icmp_squeeze_ext:
+ * - 4->6 always writes icmp6_datagram_len (either computed or 0).
+ * - 6->4 updates ICMPv4 datagram-length only when extensions are allowed.
+ *   Some mapped ICMPv6 errors set ie_forbidden, and in that case we keep the
+ *   ICMPv4 header semantics for that type/code and only relayout/trim payload.
+ */
+static int ipxlat_64_squeeze_icmp_ext(struct sk_buff *skb,
+				      unsigned int icmp6_ipl, int inner_delta,
+				      bool ie_forbidden)
+{
+	unsigned int outer_hdrs_len, payload_len, icmp4_iel_in, icmp4_iel_out;
+	unsigned int out_pad, max_iel, pkt_len_cap, icmp4_ipl_out_bytes;
+	unsigned int icmp4_ipl_out = 0, icmp4_ipl_in_bytes;
+	unsigned int new_tot_len;
+	int icmp4_ipl_in, err;
+	struct icmphdr *ic4;
+	struct iphdr *iph4;
+
+	if (likely(!icmp6_ipl))
+		goto finalize;
+
+	outer_hdrs_len = skb_transport_offset(skb) + sizeof(struct icmphdr);
+	if (unlikely(skb->len < outer_hdrs_len))
+		return -EINVAL;
+
+	payload_len = skb->len - outer_hdrs_len;
+	icmp4_ipl_in = (int)icmp6_ipl + inner_delta;
+	if (unlikely(icmp4_ipl_in < 0))
+		return -EINVAL;
+	icmp4_ipl_in_bytes = icmp4_ipl_in;
+	if (unlikely(icmp4_ipl_in_bytes > payload_len))
+		return -EINVAL;
+
+	if (likely(icmp4_ipl_in_bytes == payload_len))
+		goto finalize;
+
+	icmp4_iel_in = payload_len - icmp4_ipl_in_bytes;
+	max_iel = IPXLAT_ICMP4_ERROR_MAX_LEN -
+		  (outer_hdrs_len + ICMP_EXT_ORIG_DGRAM_MIN_LEN);
+
+	if (unlikely(ie_forbidden)) {
+		icmp4_ipl_out_bytes = icmp4_ipl_in_bytes;
+		out_pad = 0;
+		icmp4_iel_out = 0;
+	} else if (unlikely(icmp4_iel_in > max_iel)) {
+		pkt_len_cap = min_t(unsigned int, skb->len - icmp4_iel_in,
+				    IPXLAT_ICMP4_ERROR_MAX_LEN);
+		icmp4_ipl_out_bytes = pkt_len_cap - outer_hdrs_len;
+		out_pad = 0;
+		icmp4_iel_out = 0;
+		icmp4_ipl_out = 0;
+	} else {
+		pkt_len_cap = min_t(unsigned int, skb->len,
+				    IPXLAT_ICMP4_ERROR_MAX_LEN);
+		icmp4_ipl_out_bytes =
+			round_down(pkt_len_cap - icmp4_iel_in - outer_hdrs_len,
+				   sizeof(u32));
+		out_pad = max_t(unsigned int, ICMP_EXT_ORIG_DGRAM_MIN_LEN,
+				icmp4_ipl_out_bytes) -
+			  icmp4_ipl_out_bytes;
+		icmp4_iel_out = icmp4_iel_in;
+		/* RFC 4884 field is in 32-bit units for ICMPv4 errors */
+		icmp4_ipl_out = (icmp4_ipl_out_bytes + out_pad) >> 2;
+	}
+
+	/* if no extension bytes are copied and no pad is written, relayout only
+	 * trims/updates lengths and does not require full data writability
+	 */
+	if (unlikely(icmp4_iel_out || out_pad)) {
+		err = skb_ensure_writable(skb, skb->len);
+		if (unlikely(err))
+			return err;
+	}
+
+	err = ipxlat_icmp_relayout(skb, outer_hdrs_len, icmp4_ipl_in_bytes,
+				   icmp4_iel_in, icmp4_ipl_out_bytes, out_pad,
+				   icmp4_iel_out);
+	if (unlikely(err))
+		return err;
+
+finalize:
+	if (!ie_forbidden) {
+		ic4 = icmp_hdr(skb);
+		ic4->un.reserved[1] = icmp4_ipl_out;
+	}
+
+	if (unlikely(skb->len > IPXLAT_ICMP4_ERROR_MAX_LEN)) {
+		err = pskb_trim(skb, IPXLAT_ICMP4_ERROR_MAX_LEN);
+		if (unlikely(err))
+			return err;
+	}
+
+	iph4 = ip_hdr(skb);
+	new_tot_len = skb->len;
+	if (unlikely(be16_to_cpu(iph4->tot_len) != new_tot_len)) {
+		iph4->tot_len = cpu_to_be16(new_tot_len);
+		/* relayout/trim may invalidate precomputed DF decision */
+		iph4->frag_off &= cpu_to_be16(~IP_DF);
+		iph4->check = 0;
+		iph4->check = ip_fast_csum(iph4, iph4->ihl);
+	}
+
+	return 0;
+}
+
+/**
+ * ipxlat_64_icmp_error - translate ICMPv6 error payload to ICMPv4 error form
+ * @ipxlat: translator private context
+ * @skb: packet carrying outer ICMPv6 error
+ *
+ * Rewrites the quoted inner datagram in place, maps type/code/fields and
+ * adjusts RFC 4884 datagram/extension layout before recomputing outer checksum.
+ *
+ * Return: 0 on success, negative errno on translation failure.
+ */
+static int ipxlat_64_icmp_error(struct ipxlat_priv *ipxlat, struct sk_buff *skb)
+{
+	const struct ipxlat_cb *cb = ipxlat_skb_cb(skb);
+	const struct icmp6hdr ic6 = *icmp6_hdr(skb);
+	unsigned int icmp6_ipl;
+	int inner_delta, err;
+	struct icmphdr *ic4;
+	bool ie_forbidden;
+
+	if (unlikely(!(cb->is_icmp_err))) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		return -EINVAL;
+	}
+
+	/* translate quoted inner packet headers */
+	err = ipxlat_64_icmp_inner(ipxlat, skb, &inner_delta);
+	if (unlikely(err))
+		return err;
+
+	/* build outer ICMPv4 error header after inner relayout */
+	ic4 = (struct icmphdr *)(skb->data + skb_transport_offset(skb));
+	err = ipxlat_64_build_icmp4_errhdr(ipxlat, skb, &ic6, ic4,
+					   &ie_forbidden);
+	if (unlikely(err))
+		return err;
+
+	icmp6_ipl = ic6.icmp6_datagram_len << 3;
+	err = ipxlat_64_squeeze_icmp_ext(skb, icmp6_ipl, inner_delta,
+					 ie_forbidden);
+	if (unlikely(err))
+		return err;
+
+	/* recompute whole ICMPv4 checksum after error-path relayout */
+	ic4->checksum = 0;
+	ic4->checksum = csum_fold(skb_checksum(skb, skb_transport_offset(skb),
+					       ipxlat_skb_datagram_len(skb),
+					       0));
+	skb->ip_summed = CHECKSUM_NONE;
+	return 0;
+}
+
+int ipxlat_64_icmp(struct ipxlat_priv *ipxlat, struct sk_buff *skb,
 		   const struct ipv6hdr *in6)
 {
 	if (unlikely(ipxlat_skb_cb(skb)->is_icmp_err))
-		return -EPROTONOSUPPORT;
+		return ipxlat_64_icmp_error(ipxlat, skb);
 
 	return ipxlat_64_icmp_info(skb, in6);
 }
diff --git a/drivers/net/ipxlat/transport.c b/drivers/net/ipxlat/transport.c
index 3aa00c635916..82aedfb0ee48 100644
--- a/drivers/net/ipxlat/transport.c
+++ b/drivers/net/ipxlat/transport.c
@@ -87,6 +87,67 @@ __sum16 ipxlat_l4_csum_ipv6(const struct in6_addr *saddr,
 			       skb_checksum(skb, l4_off, l4_len, 0));
 }
 
+static int ipxlat_ensure_tailroom(struct sk_buff *skb, const unsigned int grow)
+{
+	int err;
+
+	if (!grow || skb_tailroom(skb) >= grow)
+		return 0;
+
+	/* tail growth may reallocate backing storage and move skb data */
+	err = pskb_expand_head(skb, 0, grow - skb_tailroom(skb), GFP_ATOMIC);
+	if (unlikely(err))
+		return err;
+
+	return 0;
+}
+
+/* Rewrite quoted datagram layout after inner translation in ICMP errors.
+ *
+ * Caller provides old/new quoted lengths and extension lengths; this helper
+ * only does byte moves/padding/trim while preserving extension bytes at the
+ * end of the packet when present
+ */
+int ipxlat_icmp_relayout(struct sk_buff *skb, unsigned int outer_len,
+			 unsigned int in_ipl, unsigned int in_iel,
+			 unsigned int out_ipl, unsigned int out_pad,
+			 unsigned int out_iel)
+{
+	const unsigned int in_ie_off = outer_len + in_ipl, old_len = skb->len;
+	const unsigned int new_len = outer_len + out_ipl + out_pad + out_iel;
+	const unsigned int out_ie_off = outer_len + out_ipl + out_pad;
+	unsigned int grow = 0;
+	int err;
+
+	/* new_len > old_len here means "we need extra bytes on top of
+	 * already-translated length", mainly due padding/layout decisions
+	 * while keeping extensions
+	 */
+	if (unlikely(new_len > old_len)) {
+		grow = new_len - old_len;
+
+		err = ipxlat_ensure_tailroom(skb, grow);
+		if (unlikely(err))
+			return err;
+
+		__skb_put(skb, grow);
+	}
+
+	if (unlikely(out_iel))
+		memmove(skb->data + out_ie_off, skb->data + in_ie_off, out_iel);
+
+	if (unlikely(out_pad))
+		memset(skb->data + outer_len + out_ipl, 0, out_pad);
+
+	if (unlikely(new_len < old_len)) {
+		err = pskb_trim(skb, new_len);
+		if (unlikely(err))
+			return err;
+	}
+
+	return 0;
+}
+
 /* Normalize checksum/offload metadata after address-family translation.
  *
  * Translation changes protocol family but keeps transport payload semantics
diff --git a/drivers/net/ipxlat/transport.h b/drivers/net/ipxlat/transport.h
index 9b6fe422b01f..09f522696eea 100644
--- a/drivers/net/ipxlat/transport.h
+++ b/drivers/net/ipxlat/transport.h
@@ -63,6 +63,25 @@ __sum16 ipxlat_l4_csum_ipv6(const struct in6_addr *saddr,
 			    const struct sk_buff *skb, unsigned int l4_off,
 			    unsigned int l4_len, u8 proto);
 
+/**
+ * ipxlat_icmp_relayout - resize quoted ICMP payload/extensions in place
+ * @skb: packet buffer
+ * @outer_len: offset to quoted datagram start
+ * @in_ipl: input datagram payload length
+ * @in_iel: input extension length
+ * @out_ipl: output datagram payload length
+ * @out_pad: output pad bytes between datagram and extensions
+ * @out_iel: output extension length
+ *
+ * This helper may move payload bytes and adjust skb tail length.
+ *
+ * Return: 0 on success, negative errno on resize/memory failures.
+ */
+int ipxlat_icmp_relayout(struct sk_buff *skb, unsigned int outer_len,
+			 unsigned int in_ipl, unsigned int in_iel,
+			 unsigned int out_ipl, unsigned int out_pad,
+			 unsigned int out_iel);
+
 /**
  * ipxlat_finalize_offload - normalize checksum/GSO metadata after translation
  * @skb: translated packet
-- 
2.53.0


