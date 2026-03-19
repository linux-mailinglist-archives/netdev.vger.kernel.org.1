Return-Path: <netdev+bounces-269496-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNTjF0YVvGnbrwIAu9opvQ
	(envelope-from <netdev+bounces-269496-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:24:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F862CDAF1
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEB103106D19
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 15:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89564258EDB;
	Thu, 19 Mar 2026 15:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="X9fxtJcq"
X-Original-To: netdev@vger.kernel.org
Received: from mout-b-110.mailbox.org (mout-b-110.mailbox.org [195.10.208.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C095A3DEFEE;
	Thu, 19 Mar 2026 15:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773933538; cv=none; b=BWA9HOFj914CWY+Ywpb9RjSgb/R5xIvzTr0hKKjqI6aVsvFsCHL4dXWVmtaz95/A9A6YWCuHGDlrpFU0ctPfoZX+38F5f2OhEyoVgU8z3fdwlWIBwSJv718P56nqQqFsUuhhfzFe1+S2JdCpXoDSjJEJO48aP2BLgeV0KkhKck0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773933538; c=relaxed/simple;
	bh=p/IricehhSgBDg3JPp7uZ1Tlpjhpc28qmp7zqTB4g9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JldgbUeRmwi8jZGb4o1u9JXatNER3gx5UkrG5Q2fCbtu5D+EMrPMB6f5Za00jsvWTYn5tZUfc0j9O7GruiQrU1e17zkzYIlpAWzurJqdoS1ERE46bkzLX6vLX6awW5P2oVM+7iRcwWVH7RK0PDEPZKaHiW/G5Y8yizUWBDwA84k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=X9fxtJcq; arc=none smtp.client-ip=195.10.208.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-110.mailbox.org (Postfix) with ESMTPS id 4fc8NM4m33zB0t7;
	Thu, 19 Mar 2026 16:13:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1773933219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sMX1i4BMieIT4ri4r8wi6e4mrWEXh5MS4f00MKXKxeI=;
	b=X9fxtJcqIBd3hDAWB5sbebpd1+OTNBnSz9INQRX8nStPA73NSRT36WjOgU8Cp6w/X0WamF
	g9qy/oZ7EbeqRico7oD8ZDBeWR+9dj+Nfpc1e4iwSNLlIgbfuqARQozuGRtG8Bh1nU9uIv
	t5qywwn7o/4VQpi91JRIAZvGN5xOjVhT/OdfamaV5OR5qJeu7OGRgQkxIP2pZWD6qpOr38
	R/stHfntR6eA+Yq+KSgch+qmlIMvJALkKcqc/ER5TZ+d0sGrgxbNIaIQyZ2hPzJTWk2hIn
	KgmaUs2qae0eaaR9xY7/EV2h/KSso4e5BUjM1ijdFQKkG3GTqdQFwilnB9ZR3g==
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
Subject: [RFC net-next 10/15] ipxlat: add 4to6 pre-fragmentation path
Date: Thu, 19 Mar 2026 16:12:19 +0100
Message-ID: <20260319151230.655687-11-ralf@mandelbit.com>
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
	TAGGED_FROM(0.00)[bounces-269496-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.901];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mandelbit.com:dkim,mandelbit.com:email,mandelbit.com:mid,dst.dev:url]
X-Rspamd-Queue-Id: C6F862CDAF1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RFC 7915 requires handling packets that would exceed the translated IPv6
size constraints. Add a pre-fragmentation planning/action path that
invokes kernel fragmentation helpers before translation, carries
fragment size through skb metadata, and then reinjects fragments into
the normal translation path.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ipxlat/dispatch.c     | 99 ++++++++++++++++++++++++++++++-
 drivers/net/ipxlat/translate_46.c | 59 +++++++++++++++++-
 drivers/net/ipxlat/translate_46.h | 11 ++++
 3 files changed, 166 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ipxlat/dispatch.c b/drivers/net/ipxlat/dispatch.c
index b8b9b930b04c..b58191d4b2c9 100644
--- a/drivers/net/ipxlat/dispatch.c
+++ b/drivers/net/ipxlat/dispatch.c
@@ -47,6 +47,16 @@ enum ipxlat_action ipxlat_translate(struct ipxlat_priv *ipxlat,
 		if (unlikely(ipxlat_v4_validate_skb(ipxlat, skb)))
 			return ipxlat_resolve_failed_action(skb);
 
+		/* 4->6 prefrag plan stores per-skb frag_max_size
+		 * when the packet must be split before translation
+		 * (DF clear and translated size
+		 * above PMTU/threshold).
+		 */
+		if (unlikely(ipxlat_46_plan_prefrag(ipxlat, skb)))
+			return ipxlat_resolve_failed_action(skb);
+		if (unlikely(ipxlat_skb_cb(skb)->frag_max_size))
+			return IPXLAT_ACT_PRE_FRAG;
+
 		if (unlikely(ipxlat_46_translate(ipxlat, skb)))
 			return ipxlat_resolve_failed_action(skb);
 
@@ -120,6 +130,76 @@ void ipxlat_emit_icmp_error(struct ipxlat_priv *ipxlat, struct sk_buff *inner)
 	}
 }
 
+static unsigned int ipxlat_frag_dst_get_mtu(const struct dst_entry *dst)
+{
+	return READ_ONCE(dst->dev->mtu);
+}
+
+static struct dst_ops ipxlat_frag_dst_ops = {
+	.family = AF_UNSPEC,
+	.mtu = ipxlat_frag_dst_get_mtu,
+};
+
+/**
+ * ipxlat_46_frag_output - reinject one fragment produced by ip_do_fragment
+ * @net: network namespace of the transmitter
+ * @sk: originating socket
+ * @skb: fragment to reinject
+ *
+ * This callback mirrors ndo_start_xmit processing but runs with
+ * pre-fragmentation disabled to prevent recursive pre-fragment loops.
+ *
+ * Return: 0 on success, negative errno on processing failure.
+ */
+static int ipxlat_46_frag_output(struct net *net, struct sock *sk,
+				 struct sk_buff *skb)
+{
+	struct ipxlat_priv *ipxlat = netdev_priv(skb->dev);
+
+	return ipxlat_process_skb(ipxlat, skb, false);
+}
+
+/**
+ * ipxlat_46_fragment_pkt - fragment oversized 4->6 input before translation
+ * @ipxlat: translator private context
+ * @skb: original packet to fragment
+ * @frag_max_size: per-fragment payload cap for ip_do_fragment
+ *
+ * Installs a temporary synthetic dst so ip_do_fragment can read MTU and then
+ * reinjects each produced fragment back into ipxlat through
+ * ipxlat_46_frag_output.
+ *
+ * Return: 0 on success, negative errno on fragmentation failure.
+ */
+static int ipxlat_46_fragment_pkt(struct ipxlat_priv *ipxlat,
+				  struct sk_buff *skb, u16 frag_max_size)
+{
+	const unsigned long orig_dst = skb->_skb_refdst;
+	struct rtable ipxlat_rt = {};
+	int err;
+
+	/* ip_do_fragment needs a dst object to query mtu */
+	dst_init(&ipxlat_rt.dst, &ipxlat_frag_dst_ops, NULL, DST_OBSOLETE_NONE,
+		 DST_NOCOUNT);
+
+	/* use translator netdev as mtu source for the temporary dst */
+	ipxlat_rt.dst.dev = ipxlat->dev;
+
+	/* setup the skb for fragmentation */
+	skb_dst_set_noref(skb, &ipxlat_rt.dst);
+	memset(IPCB(skb), 0, sizeof(struct inet_skb_parm));
+	IPCB(skb)->frag_max_size = frag_max_size;
+
+	/* fragment and reinject each frag in the translator */
+	err = ip_do_fragment(dev_net(ipxlat->dev), skb->sk, skb,
+			     ipxlat_46_frag_output);
+
+	/* drop original dst ref replaced by the synthetic NOREF dst */
+	refdst_drop(orig_dst);
+
+	return err;
+}
+
 static void ipxlat_forward_pkt(struct ipxlat_priv *ipxlat, struct sk_buff *skb)
 {
 	const unsigned int len = skb->len;
@@ -141,14 +221,29 @@ int ipxlat_process_skb(struct ipxlat_priv *ipxlat, struct sk_buff *skb,
 	enum ipxlat_action action;
 	int err = -EINVAL;
 
-	(void)allow_pre_frag;
-
 	action = ipxlat_translate(ipxlat, skb);
 	switch (action) {
 	case IPXLAT_ACT_FWD:
 		dev_dstats_tx_add(ipxlat->dev, skb->len);
 		ipxlat_forward_pkt(ipxlat, skb);
 		return 0;
+	case IPXLAT_ACT_PRE_FRAG:
+		/* prefrag is allowed only once to avoid unbounded loops */
+		if (unlikely(!allow_pre_frag)) {
+			err = -ELOOP;
+			goto drop_free;
+		}
+
+		/* fragment first, then reinject each fragment through
+		 * ipxlat_process_skb via ipxlat_46_frag_output
+		 */
+		err = ipxlat_46_fragment_pkt(ipxlat, skb,
+					     ipxlat_skb_cb(skb)->frag_max_size);
+		/* fragment path already consumed/freed skb */
+		skb = NULL;
+		if (unlikely(err))
+			goto drop_free;
+		return 0;
 	case IPXLAT_ACT_ICMP_ERR:
 		dev_dstats_tx_dropped(ipxlat->dev);
 		ipxlat_emit_icmp_error(ipxlat, skb);
diff --git a/drivers/net/ipxlat/translate_46.c b/drivers/net/ipxlat/translate_46.c
index aec8500db2c2..0b79ca07c771 100644
--- a/drivers/net/ipxlat/translate_46.c
+++ b/drivers/net/ipxlat/translate_46.c
@@ -87,6 +87,63 @@ unsigned int ipxlat_46_lookup_pmtu6(struct ipxlat_priv *ipxlat,
 	return mtu6;
 }
 
+/**
+ * ipxlat_46_plan_prefrag - plan pre-translation IPv4 fragmentation for 4->6
+ * @ipxlat: translator private context
+ * @skb: packet being translated
+ *
+ * Decides whether packet exceeds PMTU/LIM thresholds and, when needed, stores
+ * per-skb fragmentation cap in cb->frag_max_size for later ip_do_fragment.
+ *
+ * Return: 0 on success, negative errno on policy/validation failure.
+ */
+int ipxlat_46_plan_prefrag(struct ipxlat_priv *ipxlat, struct sk_buff *skb)
+{
+	unsigned int pkt_len6, pmtu6, threshold6, frag_max_size, pkt_len4,
+		old_l3_len, new_l3_len;
+	struct ipxlat_cb *cb = ipxlat_skb_cb(skb);
+	const struct iphdr *in4 = ip_hdr(skb);
+	int l3_delta, frag_l3_delta;
+
+	if (unlikely(cb->frag_max_size)) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		cb->frag_max_size = 0;
+	}
+
+	pkt_len4 = iph_totlen(skb, in4);
+	old_l3_len = cb->l3_hdr_len;
+	new_l3_len = sizeof(struct ipv6hdr) +
+		     (ip_is_fragment(in4) ? sizeof(struct frag_hdr) : 0);
+	l3_delta = (int)new_l3_len - (int)old_l3_len;
+	pkt_len6 = pkt_len4 + l3_delta;
+
+	pmtu6 = ipxlat_46_lookup_pmtu6(ipxlat, skb, in4);
+	threshold6 = min(pmtu6, READ_ONCE(ipxlat->lowest_ipv6_mtu));
+
+	if (likely(pkt_len6 <= threshold6))
+		return 0;
+
+	/* df packets are never locally pre-fragmented */
+	if (likely(be16_to_cpu(in4->frag_off) & IP_DF)) {
+		/* Let the IPv6 forwarding path raise PTB when needed and rely
+		 * on the reverse 6->4 ICMP translation path for feedback.
+		 */
+		return 0;
+	}
+
+	/* df not set: we can fragment */
+
+	frag_l3_delta =
+		(int)(sizeof(struct ipv6hdr) + sizeof(struct frag_hdr)) -
+		(int)old_l3_len;
+	frag_max_size = threshold6 - frag_l3_delta;
+	/* store per-skb prefrag cap: ipxlat_46_fragment_pkt will copy it into
+	 * IPCB(skb)->frag_max_size before calling ip_do_fragment
+	 */
+	cb->frag_max_size = min_t(unsigned int, frag_max_size, IP_MAX_MTU);
+	return 0;
+}
+
 /**
  * ipxlat_46_translate - translate one validated packet from IPv4 to IPv6
  * @ipxlat: translator private context
@@ -182,7 +239,7 @@ int ipxlat_46_translate(struct ipxlat_priv *ipxlat, struct sk_buff *skb)
 		err = ipxlat_46_outer_udp(skb, &outer4);
 		break;
 	case IPPROTO_ICMP:
-		err = ipxlat_46_icmp(ipxlat, skb);
+		err = -EPROTONOSUPPORT;
 		break;
 	default:
 		err = 0;
diff --git a/drivers/net/ipxlat/translate_46.h b/drivers/net/ipxlat/translate_46.h
index 75def10d0cad..6ba409c94185 100644
--- a/drivers/net/ipxlat/translate_46.h
+++ b/drivers/net/ipxlat/translate_46.h
@@ -61,6 +61,17 @@ unsigned int ipxlat_46_lookup_pmtu6(struct ipxlat_priv *ipxlat,
 				    const struct sk_buff *skb,
 				    const struct iphdr *in4);
 
+/**
+ * ipxlat_46_plan_prefrag - decide whether IPv4 packet must be pre-fragmented
+ * @ipxlat: translator private context
+ * @skb: packet being translated
+ *
+ * Sets cb->frag_max_size when pre-fragmentation is required.
+ *
+ * Return: 0 on success, negative errno on policy/validation failure.
+ */
+int ipxlat_46_plan_prefrag(struct ipxlat_priv *ipxlat, struct sk_buff *skb);
+
 /**
  * ipxlat_46_translate - translate outer packet from IPv4 to IPv6 in place
  * @ipxlat: translator private context
-- 
2.53.0


