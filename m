Return-Path: <netdev+bounces-117190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD4894D06E
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 14:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E6111F20FE4
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 12:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0171946C4;
	Fri,  9 Aug 2024 12:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="JDhpV4Wj"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA9B18C93F;
	Fri,  9 Aug 2024 12:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723207533; cv=none; b=CvJo7shVOaKGG68y2LskHP1YP5dTtCKbB1ToVxuh8URMGqw3DOyzmPwbTdcw9vsftmMzlql+PjQWX//2vZ8wTXSUW+ur5LljRQ7h+C1z2etvsIpm0A7N92Jfrs06FOwjvDaLwrtGQxXq7zo85FJuKVnTnmxvxSypUL5wsxqruEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723207533; c=relaxed/simple;
	bh=2mRo/DONMGi8QYzwmW+ABBjx67b18Vo3cU+K85naGJM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=goEqJqAQPV7oCPut9bWtMSBiUQDl2dhbbH6jvwHCTmTQAqvRKn94akYZ2P7+BrXHcvmXRD0gPdMbrvR89ZLCbypRAGEYrvuap2LFl2G2VfBgDV5CEq9e7QbQ+QziGSCoUY+PUlxPblcvkL1LwFlpJJqHNIDIJCDk6EiMKvDpVTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=JDhpV4Wj; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id D8C35200BE63;
	Fri,  9 Aug 2024 14:39:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be D8C35200BE63
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1723207172;
	bh=Ecm+y/MsTsMWLKn8C+NPBacqLu9+6Ql0BpAZKQQUHxQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JDhpV4Wjaxr0yMk7Bkg1VaBeRWUic1p9B0xxM0YPJxXzIhH10FjnVmmQSiDTh5Y1E
	 Ld1usgVodyqxtViDA1gg0S/536HiBVkko4Sp0v48oYlR+QPpix+r4EtxOdAB/4S8hM
	 5BZ/qiMYwh+bLtFY3Zb9H9VqseQyTzHj8MMMiBUKWq8YTmt5zcz/198u5g9uREkmCx
	 RJ9AOwk3iQWkUxijyAeiX5h/WcdCagg53YoXlwW7s2CWsIa0q96UjRBVnCHuMYnLie
	 j+2yHeol32dY+l6K+LAHA6WlcR/8sn6Msw07ftHS3zLlXJmY1j7zeH7cDIDlqQw32I
	 Mdqyy/ZzOuseg==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH net-next 2/2] net: ipv6: ioam6: new feature tunsrc
Date: Fri,  9 Aug 2024 14:39:15 +0200
Message-Id: <20240809123915.27812-3-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809123915.27812-1-justin.iurman@uliege.be>
References: <20240809123915.27812-1-justin.iurman@uliege.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch provides a new feature (i.e., "tunsrc") for the tunnel (i.e.,
"encap") mode of ioam6. Just like seg6 already does, except it is
attached to a route. The "tunsrc" is optional: when not provided (by
default), the automatic resolution is applied. Using "tunsrc" when
possible has a benefit: performance.

Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
---
 include/uapi/linux/ioam6_iptunnel.h |  7 +++++
 net/ipv6/ioam6_iptunnel.c           | 48 ++++++++++++++++++++++++++---
 2 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/ioam6_iptunnel.h b/include/uapi/linux/ioam6_iptunnel.h
index 38f6a8fdfd34..6cdbd0da7ad8 100644
--- a/include/uapi/linux/ioam6_iptunnel.h
+++ b/include/uapi/linux/ioam6_iptunnel.h
@@ -50,6 +50,13 @@ enum {
 	IOAM6_IPTUNNEL_FREQ_K,		/* u32 */
 	IOAM6_IPTUNNEL_FREQ_N,		/* u32 */
 
+	/* Tunnel src address.
+	 * For encap,auto modes.
+	 * Optional (automatic if
+	 * not provided).
+	 */
+	IOAM6_IPTUNNEL_SRC,		/* struct in6_addr */
+
 	__IOAM6_IPTUNNEL_MAX,
 };
 
diff --git a/net/ipv6/ioam6_iptunnel.c b/net/ipv6/ioam6_iptunnel.c
index cd2522f04edf..e0e73faf9969 100644
--- a/net/ipv6/ioam6_iptunnel.c
+++ b/net/ipv6/ioam6_iptunnel.c
@@ -42,6 +42,8 @@ struct ioam6_lwt {
 	struct ioam6_lwt_freq freq;
 	atomic_t pkt_cnt;
 	u8 mode;
+	bool has_tunsrc;
+	struct in6_addr tunsrc;
 	struct in6_addr tundst;
 	struct ioam6_lwt_encap tuninfo;
 };
@@ -72,6 +74,7 @@ static const struct nla_policy ioam6_iptunnel_policy[IOAM6_IPTUNNEL_MAX + 1] = {
 	[IOAM6_IPTUNNEL_MODE]	= NLA_POLICY_RANGE(NLA_U8,
 						   IOAM6_IPTUNNEL_MODE_MIN,
 						   IOAM6_IPTUNNEL_MODE_MAX),
+	[IOAM6_IPTUNNEL_SRC]	= NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
 	[IOAM6_IPTUNNEL_DST]	= NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
 	[IOAM6_IPTUNNEL_TRACE]	= NLA_POLICY_EXACT_LEN(
 					sizeof(struct ioam6_trace_hdr)),
@@ -144,6 +147,11 @@ static int ioam6_build_state(struct net *net, struct nlattr *nla,
 	else
 		mode = nla_get_u8(tb[IOAM6_IPTUNNEL_MODE]);
 
+	if (tb[IOAM6_IPTUNNEL_SRC] && mode == IOAM6_IPTUNNEL_MODE_INLINE) {
+		NL_SET_ERR_MSG(extack, "no tunnel source expected in this mode");
+		return -EINVAL;
+	}
+
 	if (!tb[IOAM6_IPTUNNEL_DST] && mode != IOAM6_IPTUNNEL_MODE_INLINE) {
 		NL_SET_ERR_MSG(extack, "this mode needs a tunnel destination");
 		return -EINVAL;
@@ -178,6 +186,14 @@ static int ioam6_build_state(struct net *net, struct nlattr *nla,
 	ilwt->freq.n = freq_n;
 
 	ilwt->mode = mode;
+
+	if (!tb[IOAM6_IPTUNNEL_SRC]) {
+		ilwt->has_tunsrc = false;
+	} else {
+		ilwt->has_tunsrc = true;
+		ilwt->tunsrc = nla_get_in6_addr(tb[IOAM6_IPTUNNEL_SRC]);
+	}
+
 	if (tb[IOAM6_IPTUNNEL_DST])
 		ilwt->tundst = nla_get_in6_addr(tb[IOAM6_IPTUNNEL_DST]);
 
@@ -257,6 +273,8 @@ static int ioam6_do_inline(struct net *net, struct sk_buff *skb,
 
 static int ioam6_do_encap(struct net *net, struct sk_buff *skb,
 			  struct ioam6_lwt_encap *tuninfo,
+			  bool has_tunsrc,
+			  struct in6_addr *tunsrc,
 			  struct in6_addr *tundst)
 {
 	struct dst_entry *dst = skb_dst(skb);
@@ -286,8 +304,13 @@ static int ioam6_do_encap(struct net *net, struct sk_buff *skb,
 	hdr->nexthdr = NEXTHDR_HOP;
 	hdr->payload_len = cpu_to_be16(skb->len - sizeof(*hdr));
 	hdr->daddr = *tundst;
-	ipv6_dev_get_saddr(net, dst->dev, &hdr->daddr,
-			   IPV6_PREFER_SRC_PUBLIC, &hdr->saddr);
+
+	if (has_tunsrc && !ipv6_addr_any(tunsrc)) {
+		memcpy(&hdr->saddr, tunsrc, sizeof(*tunsrc));
+	} else {
+		ipv6_dev_get_saddr(net, dst->dev, &hdr->daddr,
+				   IPV6_PREFER_SRC_PUBLIC, &hdr->saddr);
+	}
 
 	skb_postpush_rcsum(skb, hdr, len);
 
@@ -329,7 +352,9 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	case IOAM6_IPTUNNEL_MODE_ENCAP:
 do_encap:
 		/* Encapsulation (ip6ip6) */
-		err = ioam6_do_encap(net, skb, &ilwt->tuninfo, &ilwt->tundst);
+		err = ioam6_do_encap(net, skb, &ilwt->tuninfo,
+				     ilwt->has_tunsrc, &ilwt->tunsrc,
+				     &ilwt->tundst);
 		if (unlikely(err))
 			goto drop;
 
@@ -415,6 +440,13 @@ static int ioam6_fill_encap_info(struct sk_buff *skb,
 		goto ret;
 
 	if (ilwt->mode != IOAM6_IPTUNNEL_MODE_INLINE) {
+		if (ilwt->has_tunsrc) {
+			err = nla_put_in6_addr(skb, IOAM6_IPTUNNEL_SRC,
+					       &ilwt->tunsrc);
+			if (err)
+				goto ret;
+		}
+
 		err = nla_put_in6_addr(skb, IOAM6_IPTUNNEL_DST, &ilwt->tundst);
 		if (err)
 			goto ret;
@@ -436,8 +468,12 @@ static int ioam6_encap_nlsize(struct lwtunnel_state *lwtstate)
 		  nla_total_size(sizeof(ilwt->mode)) +
 		  nla_total_size(sizeof(ilwt->tuninfo.traceh));
 
-	if (ilwt->mode != IOAM6_IPTUNNEL_MODE_INLINE)
+	if (ilwt->mode != IOAM6_IPTUNNEL_MODE_INLINE) {
+		if (ilwt->has_tunsrc)
+			nlsize += nla_total_size(sizeof(ilwt->tunsrc));
+
 		nlsize += nla_total_size(sizeof(ilwt->tundst));
+	}
 
 	return nlsize;
 }
@@ -452,8 +488,12 @@ static int ioam6_encap_cmp(struct lwtunnel_state *a, struct lwtunnel_state *b)
 	return (ilwt_a->freq.k != ilwt_b->freq.k ||
 		ilwt_a->freq.n != ilwt_b->freq.n ||
 		ilwt_a->mode != ilwt_b->mode ||
+		ilwt_a->has_tunsrc != ilwt_b->has_tunsrc ||
 		(ilwt_a->mode != IOAM6_IPTUNNEL_MODE_INLINE &&
 		 !ipv6_addr_equal(&ilwt_a->tundst, &ilwt_b->tundst)) ||
+		(ilwt_a->mode != IOAM6_IPTUNNEL_MODE_INLINE &&
+		 ilwt_a->has_tunsrc &&
+		 !ipv6_addr_equal(&ilwt_a->tunsrc, &ilwt_b->tunsrc)) ||
 		trace_a->namespace_id != trace_b->namespace_id);
 }
 
-- 
2.34.1


