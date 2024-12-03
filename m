Return-Path: <netdev+bounces-148481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB7D9E1D3A
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 14:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D918B3540C
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 13:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5851EF0B0;
	Tue,  3 Dec 2024 12:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="N8bitWIw"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE3E1EBFE6;
	Tue,  3 Dec 2024 12:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733230795; cv=none; b=qv2Jvx3v/meJ9F3d7pIy9aDv0LFTKcktXuKho/yWoivYWcBIE2uYR30oqvuwSAs1qOPlC+3+FBiNweK6891lQtH2SIeij+LNIs33MoyEjjU1//MVS4U4L88bS7RjLk2JXNsjeVe7Sn4wDH7/5xLfxBvwojXzp6cyzIEGwyE62vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733230795; c=relaxed/simple;
	bh=N9lNPAnG9daoRRu44eC7wcwd7qVHi20bhm7d5c83t+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KyqTbfYNxdfHLA5JVUxMZiepjIqLL69IHemmfVFQgHc7vKVEu5zO3/80JL8AxepK8Ld30S7oyua7Nr42sZqdZ/GruPI2i12VRpDH0p6NYEDgmCEP0Dggj3bV172lgcRosnj91MvDjkuifyXOE5Qg0lhN8SC++1szCEem1KceZCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=N8bitWIw; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from ubuntu.home (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id F1B8D200E2CD;
	Tue,  3 Dec 2024 13:49:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be F1B8D200E2CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1733230195;
	bh=BRbyYLcn7uQDCnfS43ZRCSxf5KuJgj54skzk37kjRJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N8bitWIwRa7Y3bE/+j1646Ddb33J8X4JjidAJzeclFOIMbS8YgSVqWugX7M8qLfFQ
	 g6rhn3EQA+nUkGfOKrwe6P2d1rLVWUqLQBPrGQbvQxgBTruaO1NtnMFxnu6P5PGH90
	 3snzMIFClW8wlxZ66JBh146Bm+YojNbqmEOkuV/1cHRYw7g7EU20qVCR2bV/T0SjUW
	 +0JYmXu2if5qBW0JpAk9Iff0CLwH3sUEXS7UrYBv09aTyGUua59l4oBLJwMsEm0e41
	 ODr1Jd++7UggBgflf4fuwMdLtEikBetWPTAoTCbw2XDt9M5dnHGiMl2rgUvmD7iWMR
	 TiEkBw3F/sGkw==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	justin.iurman@uliege.be,
	Alexander Aring <aahringo@redhat.com>
Subject: [RESEND PATCH net-next v5 4/4] net: ipv6: rpl_iptunnel: mitigate 2-realloc issue
Date: Tue,  3 Dec 2024 13:49:45 +0100
Message-Id: <20241203124945.22508-5-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203124945.22508-1-justin.iurman@uliege.be>
References: <20241203124945.22508-1-justin.iurman@uliege.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch mitigates the two-reallocations issue with rpl_iptunnel by
providing the dst_entry (in the cache) to the first call to
skb_cow_head(). As a result, the very first iteration would still
trigger two reallocations (i.e., empty cache), while next iterations
would only trigger a single reallocation.

Performance tests before/after applying this patch, which clearly shows
there is no impact (it even shows improvement):
- before: https://ibb.co/nQJhqwc
- after: https://ibb.co/4ZvW6wV

Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
Cc: Alexander Aring <aahringo@redhat.com>
---
 net/ipv6/rpl_iptunnel.c | 46 ++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/net/ipv6/rpl_iptunnel.c b/net/ipv6/rpl_iptunnel.c
index db3c19a42e1c..7ba22d2f2bfe 100644
--- a/net/ipv6/rpl_iptunnel.c
+++ b/net/ipv6/rpl_iptunnel.c
@@ -125,7 +125,8 @@ static void rpl_destroy_state(struct lwtunnel_state *lwt)
 }
 
 static int rpl_do_srh_inline(struct sk_buff *skb, const struct rpl_lwt *rlwt,
-			     const struct ipv6_rpl_sr_hdr *srh)
+			     const struct ipv6_rpl_sr_hdr *srh,
+			     struct dst_entry *cache_dst)
 {
 	struct ipv6_rpl_sr_hdr *isrh, *csrh;
 	const struct ipv6hdr *oldhdr;
@@ -153,7 +154,7 @@ static int rpl_do_srh_inline(struct sk_buff *skb, const struct rpl_lwt *rlwt,
 
 	hdrlen = ((csrh->hdrlen + 1) << 3);
 
-	err = skb_cow_head(skb, hdrlen + skb->mac_len);
+	err = skb_cow_head(skb, hdrlen + dst_dev_overhead(cache_dst, skb));
 	if (unlikely(err)) {
 		kfree(buf);
 		return err;
@@ -186,7 +187,8 @@ static int rpl_do_srh_inline(struct sk_buff *skb, const struct rpl_lwt *rlwt,
 	return 0;
 }
 
-static int rpl_do_srh(struct sk_buff *skb, const struct rpl_lwt *rlwt)
+static int rpl_do_srh(struct sk_buff *skb, const struct rpl_lwt *rlwt,
+		      struct dst_entry *cache_dst)
 {
 	struct dst_entry *dst = skb_dst(skb);
 	struct rpl_iptunnel_encap *tinfo;
@@ -196,7 +198,7 @@ static int rpl_do_srh(struct sk_buff *skb, const struct rpl_lwt *rlwt)
 
 	tinfo = rpl_encap_lwtunnel(dst->lwtstate);
 
-	return rpl_do_srh_inline(skb, rlwt, tinfo->srh);
+	return rpl_do_srh_inline(skb, rlwt, tinfo->srh, cache_dst);
 }
 
 static int rpl_output(struct net *net, struct sock *sk, struct sk_buff *skb)
@@ -208,14 +210,14 @@ static int rpl_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 
 	rlwt = rpl_lwt_lwtunnel(orig_dst->lwtstate);
 
-	err = rpl_do_srh(skb, rlwt);
-	if (unlikely(err))
-		goto drop;
-
 	local_bh_disable();
 	dst = dst_cache_get(&rlwt->cache);
 	local_bh_enable();
 
+	err = rpl_do_srh(skb, rlwt, dst);
+	if (unlikely(err))
+		goto drop;
+
 	if (unlikely(!dst)) {
 		struct ipv6hdr *hdr = ipv6_hdr(skb);
 		struct flowi6 fl6;
@@ -237,15 +239,15 @@ static int rpl_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 		local_bh_disable();
 		dst_cache_set_ip6(&rlwt->cache, dst, &fl6.saddr);
 		local_bh_enable();
+
+		err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
+		if (unlikely(err))
+			goto drop;
 	}
 
 	skb_dst_drop(skb);
 	skb_dst_set(skb, dst);
 
-	err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
-	if (unlikely(err))
-		goto drop;
-
 	return dst_output(net, sk, skb);
 
 drop:
@@ -262,29 +264,31 @@ static int rpl_input(struct sk_buff *skb)
 
 	rlwt = rpl_lwt_lwtunnel(orig_dst->lwtstate);
 
-	err = rpl_do_srh(skb, rlwt);
-	if (unlikely(err))
-		goto drop;
-
 	local_bh_disable();
 	dst = dst_cache_get(&rlwt->cache);
+	local_bh_enable();
+
+	err = rpl_do_srh(skb, rlwt, dst);
+	if (unlikely(err))
+		goto drop;
 
 	if (!dst) {
 		ip6_route_input(skb);
 		dst = skb_dst(skb);
 		if (!dst->error) {
+			local_bh_disable();
 			dst_cache_set_ip6(&rlwt->cache, dst,
 					  &ipv6_hdr(skb)->saddr);
+			local_bh_enable();
 		}
+
+		err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
+		if (unlikely(err))
+			goto drop;
 	} else {
 		skb_dst_drop(skb);
 		skb_dst_set(skb, dst);
 	}
-	local_bh_enable();
-
-	err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
-	if (unlikely(err))
-		goto drop;
 
 	return dst_input(skb);
 
-- 
2.34.1


