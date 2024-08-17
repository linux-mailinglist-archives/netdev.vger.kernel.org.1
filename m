Return-Path: <netdev+bounces-119412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF67C955807
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 15:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E46361C20BFB
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 13:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6EA1534EC;
	Sat, 17 Aug 2024 13:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="pIgzhRj4"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFF614A62A;
	Sat, 17 Aug 2024 13:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723900711; cv=none; b=UAfX6PsXPrS951X0ug7xSLVNibZdUhgyzfRfhAhM8J4OS4wiKJTsRXN46kwhecIPPddAKuS9Non69jk4kRg2n4H4SRn1Fy3WwsvZ4laSRUoYWh+3DnI83oheCex6Fyn1z5YFwkOsE/jlxGL9Xp/OSdvUfASNbYkohfzCco/6deI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723900711; c=relaxed/simple;
	bh=l3Pcit2HKMIVRRNq+eOBCmc/FgwTUkjqLEl5uNbvaG0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G/vDoX+eaqgQGekxn2LLoyzXfe8mTJPG3HX8I0/yyjFVvLzvzYO0XaJAqjwupruzafaEnQifJmtAgkNCkB3e/YdZ5wIShLlX0umHjXF29DeqZJVmVhltEYoj9ehGU/669hPrbNpxB+pXrTuCyXL8kfUW24EdOr2BvKn9s7hU/hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=pIgzhRj4; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from ubuntu.home (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id EA0D4200BFF1;
	Sat, 17 Aug 2024 15:18:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be EA0D4200BFF1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1723900708;
	bh=yDr/wEszIPpIanIMProCH/+6UJrerZZ27U4O2SImT0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pIgzhRj4ib4tXbVHdf79+4L/Q1uszs/ssYfIiSFmXUOMBx1PFvsuLxtP+MVN1ptJ3
	 r11ZQwpczB7SNzwx3NJEr2OugYQXWPwNhkmlKjAuxHZ4dSWWpXc3ncZMI2+8si6wC8
	 SGxjpqJWvL+4gvPp87Z2QR2r8wTwk8XmkEZXutZ3Dt/BRj85aPoHjdK7CPswxUroJ3
	 +N3J+jS4bDvbNfWKfyaj3HNFXiwVWhpzDhOnOVaeyI04cuPbr9ScKVU7JVf3IM1S+8
	 cWS+ivNCKHkoU4a8RhnpkCNHb7AFvwtxseE8nLDUNZynebj0LQzNc/c6Tdcgb6bv8B
	 g6aktrrJ9We3g==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH net-next v3 2/2] net: ipv6: ioam6: new feature tunsrc
Date: Sat, 17 Aug 2024 15:18:18 +0200
Message-Id: <20240817131818.11834-3-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240817131818.11834-1-justin.iurman@uliege.be>
References: <20240817131818.11834-1-justin.iurman@uliege.be>
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
possible has a benefit: performance. See the comparison:
 - before (= "encap" mode): https://ibb.co/bNCzvf7
 - after (= "encap" mode with "tunsrc"): https://ibb.co/PT8L6yq

Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
---
 include/uapi/linux/ioam6_iptunnel.h |  6 +++
 net/ipv6/ioam6_iptunnel.c           | 65 +++++++++++++++++++++++++----
 2 files changed, 63 insertions(+), 8 deletions(-)

diff --git a/include/uapi/linux/ioam6_iptunnel.h b/include/uapi/linux/ioam6_iptunnel.h
index 38f6a8fdfd34..8aef21e4a8c1 100644
--- a/include/uapi/linux/ioam6_iptunnel.h
+++ b/include/uapi/linux/ioam6_iptunnel.h
@@ -50,6 +50,12 @@ enum {
 	IOAM6_IPTUNNEL_FREQ_K,		/* u32 */
 	IOAM6_IPTUNNEL_FREQ_N,		/* u32 */
 
+	/* Tunnel src address.
+	 * For encap,auto modes.
+	 * Optional (automatic if not provided).
+	 */
+	IOAM6_IPTUNNEL_SRC,		/* struct in6_addr */
+
 	__IOAM6_IPTUNNEL_MAX,
 };
 
diff --git a/net/ipv6/ioam6_iptunnel.c b/net/ipv6/ioam6_iptunnel.c
index cd2522f04edf..e34e1ff24546 100644
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
+		NL_SET_ERR_MSG(extack, "no tunnel src expected with this mode");
+		return -EINVAL;
+	}
+
 	if (!tb[IOAM6_IPTUNNEL_DST] && mode != IOAM6_IPTUNNEL_MODE_INLINE) {
 		NL_SET_ERR_MSG(extack, "this mode needs a tunnel destination");
 		return -EINVAL;
@@ -168,16 +176,29 @@ static int ioam6_build_state(struct net *net, struct nlattr *nla,
 
 	ilwt = ioam6_lwt_state(lwt);
 	err = dst_cache_init(&ilwt->cache, GFP_ATOMIC);
-	if (err) {
-		kfree(lwt);
-		return err;
-	}
+	if (err)
+		goto free_lwt;
 
 	atomic_set(&ilwt->pkt_cnt, 0);
 	ilwt->freq.k = freq_k;
 	ilwt->freq.n = freq_n;
 
 	ilwt->mode = mode;
+
+	if (!tb[IOAM6_IPTUNNEL_SRC]) {
+		ilwt->has_tunsrc = false;
+	} else {
+		ilwt->has_tunsrc = true;
+		ilwt->tunsrc = nla_get_in6_addr(tb[IOAM6_IPTUNNEL_SRC]);
+
+		if (ipv6_addr_any(&ilwt->tunsrc)) {
+			NL_SET_ERR_MSG_ATTR(extack, tb[IOAM6_IPTUNNEL_SRC],
+					    "invalid tunnel source address");
+			err = -EINVAL;
+			goto free_cache;
+		}
+	}
+
 	if (tb[IOAM6_IPTUNNEL_DST])
 		ilwt->tundst = nla_get_in6_addr(tb[IOAM6_IPTUNNEL_DST]);
 
@@ -202,6 +223,11 @@ static int ioam6_build_state(struct net *net, struct nlattr *nla,
 	*ts = lwt;
 
 	return 0;
+free_cache:
+	dst_cache_destroy(&ilwt->cache);
+free_lwt:
+	kfree(lwt);
+	return err;
 }
 
 static int ioam6_do_fill(struct net *net, struct sk_buff *skb)
@@ -257,6 +283,8 @@ static int ioam6_do_inline(struct net *net, struct sk_buff *skb,
 
 static int ioam6_do_encap(struct net *net, struct sk_buff *skb,
 			  struct ioam6_lwt_encap *tuninfo,
+			  bool has_tunsrc,
+			  struct in6_addr *tunsrc,
 			  struct in6_addr *tundst)
 {
 	struct dst_entry *dst = skb_dst(skb);
@@ -286,8 +314,12 @@ static int ioam6_do_encap(struct net *net, struct sk_buff *skb,
 	hdr->nexthdr = NEXTHDR_HOP;
 	hdr->payload_len = cpu_to_be16(skb->len - sizeof(*hdr));
 	hdr->daddr = *tundst;
-	ipv6_dev_get_saddr(net, dst->dev, &hdr->daddr,
-			   IPV6_PREFER_SRC_PUBLIC, &hdr->saddr);
+
+	if (has_tunsrc)
+		memcpy(&hdr->saddr, tunsrc, sizeof(*tunsrc));
+	else
+		ipv6_dev_get_saddr(net, dst->dev, &hdr->daddr,
+				   IPV6_PREFER_SRC_PUBLIC, &hdr->saddr);
 
 	skb_postpush_rcsum(skb, hdr, len);
 
@@ -329,7 +361,9 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	case IOAM6_IPTUNNEL_MODE_ENCAP:
 do_encap:
 		/* Encapsulation (ip6ip6) */
-		err = ioam6_do_encap(net, skb, &ilwt->tuninfo, &ilwt->tundst);
+		err = ioam6_do_encap(net, skb, &ilwt->tuninfo,
+				     ilwt->has_tunsrc, &ilwt->tunsrc,
+				     &ilwt->tundst);
 		if (unlikely(err))
 			goto drop;
 
@@ -415,6 +449,13 @@ static int ioam6_fill_encap_info(struct sk_buff *skb,
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
@@ -436,8 +477,12 @@ static int ioam6_encap_nlsize(struct lwtunnel_state *lwtstate)
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
@@ -452,8 +497,12 @@ static int ioam6_encap_cmp(struct lwtunnel_state *a, struct lwtunnel_state *b)
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


