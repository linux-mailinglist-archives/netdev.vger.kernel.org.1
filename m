Return-Path: <netdev+bounces-145841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9F39D11BC
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 14:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9580B29A5A
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 13:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2871A9B44;
	Mon, 18 Nov 2024 13:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="0S2ef9T5"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB3B19ABB6;
	Mon, 18 Nov 2024 13:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731936090; cv=none; b=pwe8bCpdrJsV1b/zIl6dX/w9Ssnk/0wLiJHrzvAS8faC8VyiXsXSuxWo7RPq/AM5TvXbGrXULoF2erzIWI0w5bbHjozHyK45ENIZ2m6Cu/3fVoyWsllpythb7s2gdcgy4UsGGGOUoZYOZNrCIaQmCywWtpKrMP9/SPLKmYqHWNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731936090; c=relaxed/simple;
	bh=AFTQiSpgMlVTAVvVYlCbKEg0Mhs0FIC7WJptSf0rX7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iRbo+pMgcdT0Ub4F2FzIA17sPd0UqDLeGhqWfFNm0fBCiFgLlOpjoJomGpSLmfBQJCM2hROsdUI3KfGXa/J/yWKCfYN6+/kzxPP4EXFSr29cu/q7Vbrq2cHHzrQBQImSZ9DbMU4UiBlXEjY2tC0MPfFRj8iAW17qUDZz/qG9u3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=0S2ef9T5; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 95071200DF8A;
	Mon, 18 Nov 2024 14:15:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 95071200DF8A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1731935718;
	bh=zFQvbFSJLr/DFpW/f/eCgTYxv+sRAGr/Q9vEWapPn+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0S2ef9T5S8BEfDg7txxEYaXn8zT1UQ6ORS28451dMGQnYTumk6IuUsaam8KQ8lUDt
	 l7BhN1kAAtqLZjzP92EdUGsyI4RdxwV37GwZO3sMbVOScl23Ne0ZZacCX2MHd9ETRw
	 uaVQXV5nIh1zHYjI7qUsu8pB2HbHNpCVS2SpxfTFUyiWfOSMnZ4Voec+W5JYXKWrit
	 s54EskPZt7cPoPawwtr4tNiSogJXAoC7SAjy/4fkl6YYKQLzQIsoZXJyKcs7MCUKQV
	 qMz94I2mp70iFVMVJerXCAF/A3Ww48iKwX0YE4uvmYtOgSHPvTEQu93rMLOeq+45xQ
	 eRqUCWwfFetmw==
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
Subject: [PATCH net-next v4 4/4] net: ipv6: rpl_iptunnel: mitigate 2-realloc issue
Date: Mon, 18 Nov 2024 14:15:02 +0100
Message-Id: <20241118131502.10077-5-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241118131502.10077-1-justin.iurman@uliege.be>
References: <20241118131502.10077-1-justin.iurman@uliege.be>
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
 net/ipv6/rpl_iptunnel.c | 59 +++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 29 deletions(-)

diff --git a/net/ipv6/rpl_iptunnel.c b/net/ipv6/rpl_iptunnel.c
index db3c19a42e1c..c48074b5292c 100644
--- a/net/ipv6/rpl_iptunnel.c
+++ b/net/ipv6/rpl_iptunnel.c
@@ -125,7 +125,8 @@ static void rpl_destroy_state(struct lwtunnel_state *lwt)
 }
 
 static int rpl_do_srh_inline(struct sk_buff *skb, const struct rpl_lwt *rlwt,
-			     const struct ipv6_rpl_sr_hdr *srh)
+			     const struct ipv6_rpl_sr_hdr *srh,
+			     struct dst_entry *dst)
 {
 	struct ipv6_rpl_sr_hdr *isrh, *csrh;
 	const struct ipv6hdr *oldhdr;
@@ -153,7 +154,7 @@ static int rpl_do_srh_inline(struct sk_buff *skb, const struct rpl_lwt *rlwt,
 
 	hdrlen = ((csrh->hdrlen + 1) << 3);
 
-	err = skb_cow_head(skb, hdrlen + skb->mac_len);
+	err = skb_cow_head(skb, hdrlen + dst_dev_overhead(dst, skb));
 	if (unlikely(err)) {
 		kfree(buf);
 		return err;
@@ -186,36 +187,35 @@ static int rpl_do_srh_inline(struct sk_buff *skb, const struct rpl_lwt *rlwt,
 	return 0;
 }
 
-static int rpl_do_srh(struct sk_buff *skb, const struct rpl_lwt *rlwt)
+static int rpl_do_srh(struct sk_buff *skb, const struct rpl_lwt *rlwt,
+		      struct dst_entry *dst)
 {
-	struct dst_entry *dst = skb_dst(skb);
 	struct rpl_iptunnel_encap *tinfo;
 
 	if (skb->protocol != htons(ETH_P_IPV6))
 		return -EINVAL;
 
-	tinfo = rpl_encap_lwtunnel(dst->lwtstate);
+	tinfo = rpl_encap_lwtunnel(skb_dst(skb)->lwtstate);
 
-	return rpl_do_srh_inline(skb, rlwt, tinfo->srh);
+	return rpl_do_srh_inline(skb, rlwt, tinfo->srh, dst);
 }
 
 static int rpl_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
-	struct dst_entry *orig_dst = skb_dst(skb);
-	struct dst_entry *dst = NULL;
+	struct dst_entry *dst;
 	struct rpl_lwt *rlwt;
 	int err;
 
-	rlwt = rpl_lwt_lwtunnel(orig_dst->lwtstate);
-
-	err = rpl_do_srh(skb, rlwt);
-	if (unlikely(err))
-		goto drop;
+	rlwt = rpl_lwt_lwtunnel(skb_dst(skb)->lwtstate);
 
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
@@ -237,15 +237,15 @@ static int rpl_output(struct net *net, struct sock *sk, struct sk_buff *skb)
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
@@ -255,36 +255,37 @@ static int rpl_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 
 static int rpl_input(struct sk_buff *skb)
 {
-	struct dst_entry *orig_dst = skb_dst(skb);
-	struct dst_entry *dst = NULL;
+	struct dst_entry *dst;
 	struct rpl_lwt *rlwt;
 	int err;
 
-	rlwt = rpl_lwt_lwtunnel(orig_dst->lwtstate);
-
-	err = rpl_do_srh(skb, rlwt);
-	if (unlikely(err))
-		goto drop;
+	rlwt = rpl_lwt_lwtunnel(skb_dst(skb)->lwtstate);
 
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


