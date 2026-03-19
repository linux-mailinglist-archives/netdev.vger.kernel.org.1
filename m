Return-Path: <netdev+bounces-269500-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AacGiYWvGnbrwIAu9opvQ
	(envelope-from <netdev+bounces-269500-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:28:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E75B02CDBA9
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EFF432C605E
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 15:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AF03E3C5D;
	Thu, 19 Mar 2026 15:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="hJFg6k/E"
X-Original-To: netdev@vger.kernel.org
Received: from mout-b-201.mailbox.org (mout-b-201.mailbox.org [195.10.208.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858113E556B;
	Thu, 19 Mar 2026 15:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773933631; cv=none; b=muisLNLfLkgGSC1/yfE13o7sWxUWImFkbzjqLifRQBVwMZj6ukpLLGQx0Yf/NDDVMjEVaGfsjlQ2bFpFAUylfWhfpWna8vG0Y/as4QXRQp47S7ofiES2le5gbwOwh7woaravIwnJAAt2e4JdBjPH+qC1jPczxu2Gngdpug6nj8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773933631; c=relaxed/simple;
	bh=HFsB2eky2Tk0cvZa+RJn225M3EBHBhiR9X02au8fvgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eN/CTLTSkDNl+SL1XaL31lUnSJkBJWZB5wuKerA67rKrOjrJSsEozRVc7/v9PZZT3YZVJZQ4JlXwfTr66iecn1n6yzEsCb7h6q5yeZ31hlJbW7SEsQ+MQout+Fl7Emx+Yt1r5xXlihWZ+c6h9EV290GuMl/fBgLmARmQQdgm/Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=hJFg6k/E; arc=none smtp.client-ip=195.10.208.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-201.mailbox.org (Postfix) with ESMTPS id 4fc8NG0dZrzDs2P;
	Thu, 19 Mar 2026 16:13:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1773933214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lZmf3XMXGG3SmE3J2wOJSJ7B3hQ2E0d5WPu7AoMMTbo=;
	b=hJFg6k/EGLrXPGrEpxuSoGOJxC3USyR+lkRouQbilasWQzkvxxIVqHc0m8Xhf+LGDo+nrJ
	Cno4OLiZL/z47DJ5WDSAXAmmvdgy0+94kQZUOoNUgr+9EjdAx/NEMexUPiDwqIWi8SvtCS
	vBvVxg2O9PLnOzZ+2nc8/bnNs4r23RUsaenZKJGiCT8YS1YUrb2TF9IdH/pyVjRCKiJOPX
	UKdd342kqV8nK9tG/UAj9xPjxSYIcElK3HCLW4v07IPjLopAaONxiV0JVew+B9k7DAyFWC
	xBxwycdt8WcmGKWS59GGtAU3aZ/WEzyvF53hZZpyqA+zqYfOC04buZjA0mSIyA==
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
Subject: [RFC net-next 09/15] ipxlat: emit translator-generated ICMP errors on drop
Date: Thu, 19 Mar 2026 16:12:18 +0100
Message-ID: <20260319151230.655687-10-ralf@mandelbit.com>
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
	TAGGED_FROM(0.00)[bounces-269500-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.938];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mandelbit.com:dkim,mandelbit.com:email,mandelbit.com:mid]
X-Rspamd-Queue-Id: E75B02CDBA9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When validation or policy requires dropping a packet and generating an
ICMP error, route that failure through explicit ICMP emission paths so
the sender can be notified where appropriate. This commit adds
translator-originated error generation for both directions and
integrates it into dispatch action handling without changing normal
forwarding behavior.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ipxlat/dispatch.c | 66 ++++++++++++++++++++++++++++++++++-
 drivers/net/ipxlat/dispatch.h |  7 ++++
 drivers/net/ipxlat/packet.c   | 25 ++++++++++---
 3 files changed, 92 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ipxlat/dispatch.c b/drivers/net/ipxlat/dispatch.c
index 133d30859f49..b8b9b930b04c 100644
--- a/drivers/net/ipxlat/dispatch.c
+++ b/drivers/net/ipxlat/dispatch.c
@@ -11,7 +11,12 @@
  *		Ralf Lici <ralf@mandelbit.com>
  */
 
+#include <linux/icmp.h>
+#include <linux/icmpv6.h>
+#include <net/icmp.h>
 #include <net/ip.h>
+#include <net/route.h>
+#include <net/ipv6.h>
 
 #include "dispatch.h"
 #include "packet.h"
@@ -21,7 +26,8 @@
 static enum ipxlat_action
 ipxlat_resolve_failed_action(const struct sk_buff *skb)
 {
-	return IPXLAT_ACT_DROP;
+	return ipxlat_skb_cb(skb)->emit_icmp_err ? IPXLAT_ACT_ICMP_ERR :
+						 IPXLAT_ACT_DROP;
 }
 
 enum ipxlat_action ipxlat_translate(struct ipxlat_priv *ipxlat,
@@ -61,6 +67,59 @@ void ipxlat_mark_icmp_drop(struct sk_buff *skb, u8 type, u8 code, u32 info)
 	cb->icmp_err.info = info;
 }
 
+static void ipxlat_46_emit_icmp_err(struct ipxlat_priv *ipxlat,
+				    struct sk_buff *inner)
+{
+	struct ipxlat_cb *cb = ipxlat_skb_cb(inner);
+	const struct iphdr *iph = ip_hdr(inner);
+	struct inet_skb_parm param = {};
+
+	/* build route metadata on demand when the packet has no dst */
+	if (unlikely(!skb_dst(inner))) {
+		const int reason = ip_route_input_noref(inner, iph->daddr,
+							iph->saddr,
+							ip4h_dscp(iph),
+							inner->dev);
+
+		if (unlikely(reason)) {
+			netdev_dbg(ipxlat->dev,
+				   "icmp4 emit: route build failed reason=%d\n",
+				   reason);
+			return;
+		}
+	}
+
+	/* emit the ICMPv4 error */
+	__icmp_send(inner, cb->icmp_err.type, cb->icmp_err.code,
+		    htonl(cb->icmp_err.info), &param);
+}
+
+static void ipxlat_64_emit_icmp_err(struct sk_buff *inner)
+{
+	struct ipxlat_cb *cb = ipxlat_skb_cb(inner);
+	struct inet6_skb_parm param = {};
+
+	/* emit the ICMPv6 error */
+	icmp6_send(inner, cb->icmp_err.type, cb->icmp_err.code,
+		   cb->icmp_err.info, NULL, &param);
+}
+
+/* emit translator-generated ICMP errors for packets rejected by RFC rules */
+void ipxlat_emit_icmp_error(struct ipxlat_priv *ipxlat, struct sk_buff *inner)
+{
+	switch (ntohs(inner->protocol)) {
+	case ETH_P_IPV6:
+		ipxlat_64_emit_icmp_err(inner);
+		return;
+	case ETH_P_IP:
+		ipxlat_46_emit_icmp_err(ipxlat, inner);
+		return;
+	default:
+		DEBUG_NET_WARN_ON_ONCE(1);
+		return;
+	}
+}
+
 static void ipxlat_forward_pkt(struct ipxlat_priv *ipxlat, struct sk_buff *skb)
 {
 	const unsigned int len = skb->len;
@@ -90,6 +149,11 @@ int ipxlat_process_skb(struct ipxlat_priv *ipxlat, struct sk_buff *skb,
 		dev_dstats_tx_add(ipxlat->dev, skb->len);
 		ipxlat_forward_pkt(ipxlat, skb);
 		return 0;
+	case IPXLAT_ACT_ICMP_ERR:
+		dev_dstats_tx_dropped(ipxlat->dev);
+		ipxlat_emit_icmp_error(ipxlat, skb);
+		consume_skb(skb);
+		return 0;
 	case IPXLAT_ACT_DROP:
 		goto drop_free;
 	default:
diff --git a/drivers/net/ipxlat/dispatch.h b/drivers/net/ipxlat/dispatch.h
index fa6fafea656b..73acd831b6cf 100644
--- a/drivers/net/ipxlat/dispatch.h
+++ b/drivers/net/ipxlat/dispatch.h
@@ -44,6 +44,13 @@ enum ipxlat_action {
  */
 void ipxlat_mark_icmp_drop(struct sk_buff *skb, u8 type, u8 code, u32 info);
 
+/**
+ * ipxlat_emit_icmp_error - emit cached translator-generated ICMP error
+ * @ipxlat: translator private context
+ * @inner: offending packet used as quoted payload
+ */
+void ipxlat_emit_icmp_error(struct ipxlat_priv *ipxlat, struct sk_buff *inner);
+
 /**
  * ipxlat_translate - validate/translate one packet and return next action
  * @ipxlat: translator private context
diff --git a/drivers/net/ipxlat/packet.c b/drivers/net/ipxlat/packet.c
index b37a3e55aff8..758b72bdc6f1 100644
--- a/drivers/net/ipxlat/packet.c
+++ b/drivers/net/ipxlat/packet.c
@@ -142,6 +142,8 @@ static int ipxlat_v4_srr_check(struct sk_buff *skb, const struct iphdr *hdr)
 			if (unlikely(ptr > len - 3))
 				return -EINVAL;
 
+			ipxlat_mark_icmp_drop(skb, ICMP_DEST_UNREACH,
+					      ICMP_SR_FAILED, 0);
 			return -EINVAL;
 		}
 
@@ -272,8 +274,10 @@ static int ipxlat_v4_pull_hdrs(struct sk_buff *skb)
 	/* RFC 7915 Section 4.1 */
 	if (unlikely(ipxlat_v4_srr_check(skb, l3_hdr)))
 		return -EINVAL;
-	if (unlikely(l3_hdr->ttl <= 1))
+	if (unlikely(l3_hdr->ttl <= 1)) {
+		ipxlat_mark_icmp_drop(skb, ICMP_TIME_EXCEEDED, ICMP_EXC_TTL, 0);
 		return -EINVAL;
+	}
 
 	/* RFC 7915 Section 1.2:
 	 * Fragmented ICMP/ICMPv6 packets will not be translated by IP/ICMP
@@ -390,8 +394,11 @@ int ipxlat_v4_validate_skb(struct ipxlat_priv *ipxlat, struct sk_buff *skb)
 	 * Fragmented checksum-less IPv4 UDP is rejected because 4->6 cannot
 	 * reliably translate it.
 	 */
-	if (unlikely(ip_is_fragment(l3_hdr)))
+	if (unlikely(ip_is_fragment(l3_hdr))) {
+		ipxlat_mark_icmp_drop(skb, ICMP_DEST_UNREACH, ICMP_PKT_FILTERED,
+				      0);
 		return -EINVAL;
+	}
 
 	/* udph->len bounds the span used to compute replacement checksum */
 	if (unlikely(ntohs(udph->len) > skb->len - cb->l4_off))
@@ -520,7 +527,7 @@ static int ipxlat_v6_walk_hdrs(struct sk_buff *skb, unsigned int l3_offset,
  */
 static int ipxlat_v6_check_rh(struct sk_buff *skb)
 {
-	unsigned int rh_off;
+	unsigned int rh_off, pointer;
 	int flags, nexthdr;
 
 	rh_off = 0;
@@ -531,6 +538,8 @@ static int ipxlat_v6_check_rh(struct sk_buff *skb)
 	if (likely(nexthdr != NEXTHDR_ROUTING))
 		return 0;
 
+	pointer = rh_off + offsetof(struct ipv6_rt_hdr, segments_left);
+	ipxlat_mark_icmp_drop(skb, ICMPV6_PARAMPROB, ICMPV6_HDR_FIELD, pointer);
 	return -EINVAL;
 }
 
@@ -550,8 +559,11 @@ static int ipxlat_v6_pull_outer_l3(struct sk_buff *skb)
 		     !ipxlat_v6_validate_saddr(&l3_hdr->saddr)))
 		return -EINVAL;
 
-	if (unlikely(l3_hdr->hop_limit <= 1))
+	if (unlikely(l3_hdr->hop_limit <= 1)) {
+		ipxlat_mark_icmp_drop(skb, ICMPV6_TIME_EXCEED,
+				      ICMPV6_EXC_HOPLIMIT, 0);
 		return -EINVAL;
+	}
 
 	return 0;
 }
@@ -617,8 +629,11 @@ static int ipxlat_v6_pull_hdrs(struct sk_buff *skb)
 	/* -EPROTONOSUPPORT means packet layout is syntactically valid but
 	 * unsupported by our RFC 7915 path
 	 */
-	if (unlikely(err == -EPROTONOSUPPORT))
+	if (unlikely(err == -EPROTONOSUPPORT)) {
+		ipxlat_mark_icmp_drop(skb, ICMPV6_DEST_UNREACH,
+				      ICMPV6_ADM_PROHIBITED, 0);
 		return -EINVAL;
+	}
 	if (unlikely(err))
 		return err;
 
-- 
2.53.0


