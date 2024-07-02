Return-Path: <netdev+bounces-108571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3761392469C
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 19:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68F5C1C220C9
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 17:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4601BD005;
	Tue,  2 Jul 2024 17:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="yrX0AN3k"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E41F2F4A;
	Tue,  2 Jul 2024 17:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719942351; cv=none; b=pOYGFTeMNM9o/RM+whL0P9z3yGbbVWsWPD2PgZXn39HF22UQl9Ole/2dOVnTN/lcOJeBsAorWNymsKpO9IXeYO52SlBIiLvNymx60XTMYwSZTVu9L4p77y+048DJGi/TgYC2a1h4H/l1op+6mm3ySGHiO9wc0NrsGZ1jUeP3Hf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719942351; c=relaxed/simple;
	bh=79m0+IHKOGJpBG6VM+cdQYZz7BkdFizzIX3hwF2tek0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RSq15ZBdrngyZ6VNaEjly1TT/n/nsJTGpdrgQjNVBasqS5QMdjMp80Q9DRKDNfoniwtDtbjp7fhMB/qnvvHFHDnphhwlkyjB7C04fRy4XIONOT6RsVif49zQze856nuudBaEPm7+E2NUMdjVafM5/NhN3eTsu1wz2I6ijmQ0JWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=yrX0AN3k; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (48.39-182-91.adsl-dyn.isp.belgacom.be [91.182.39.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 05142200BFE5;
	Tue,  2 Jul 2024 19:45:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 05142200BFE5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1719942347;
	bh=lCaW80VzNxTMCxl0iWs4I+4RdjYWCe+gUOodsHPN+jI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yrX0AN3kBNZJgjGw8ercURW2DmEl3Du/mC4Kxyf7GKdp3GvgsPtfgUfpeCJJPqIYb
	 7ufWYV+NpZInF3iDqba2CKovPhCvHMFeY9045uW+M8KOXlUafRrROB+L7rk2+wAb9D
	 X0IO+cHFB3Jogx2TgZWkcsV/NJlJsVlmfqnA2hXbaO+qQyabwrD7JFZTfmqR+Jr+qY
	 hGDj0KbzX17exbpCF9Vu+qY8/tTB1PcCAK2yniey4mMWWdOBS4PIhj/8pGBChnf5vc
	 MCvDux4G8D4bQIk5K+95oo9iUPmSAH+K4NadTk1J9NcYfz1m0YvrzUVzsGDZ5cvprF
	 i87NwgL/nc+wA==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH net 1/2] net: ioam6: use "new" dst entry with skb_cow_head
Date: Tue,  2 Jul 2024 19:44:50 +0200
Message-Id: <20240702174451.22735-2-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240702174451.22735-1-justin.iurman@uliege.be>
References: <20240702174451.22735-1-justin.iurman@uliege.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ioam6_output(), we call skb_cow_head() with LL_RESERVED_SPACE(). The
latter uses "dst", which is potentially not the good one anymore. As a
consequence, there might not be enough headroom, depending on the "new"
dev (e.g., needed_headroom > 0). Therefore, we first need to get the
"new" dst entry (from the cache or by calling ip6_route_output()), just
like seg6 and rpl both do, and only then call skb_cow_head() with
LL_RESERVED_SPACE() on the "new" dst entry.

Fixes: 8cb3bf8bff3c ("ipv6: ioam: Add support for the ip6ip6 encapsulation")
Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
---
 net/ipv6/ioam6_iptunnel.c | 65 +++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 33 deletions(-)

diff --git a/net/ipv6/ioam6_iptunnel.c b/net/ipv6/ioam6_iptunnel.c
index bf7120ecea1e..b08c13550144 100644
--- a/net/ipv6/ioam6_iptunnel.c
+++ b/net/ipv6/ioam6_iptunnel.c
@@ -295,7 +295,7 @@ static int ioam6_do_encap(struct net *net, struct sk_buff *skb,
 
 static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
-	struct dst_entry *dst = skb_dst(skb);
+	struct dst_entry *dst, *orig_dst = skb_dst(skb);
 	struct in6_addr orig_daddr;
 	struct ioam6_lwt *ilwt;
 	int err = -EINVAL;
@@ -304,7 +304,7 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	if (skb->protocol != htons(ETH_P_IPV6))
 		goto drop;
 
-	ilwt = ioam6_lwt_state(dst->lwtstate);
+	ilwt = ioam6_lwt_state(orig_dst->lwtstate);
 
 	/* Check for insertion frequency (i.e., "k over n" insertions) */
 	pkt_cnt = atomic_fetch_inc(&ilwt->pkt_cnt);
@@ -346,45 +346,44 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 		goto drop;
 	}
 
-	err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
-	if (unlikely(err))
-		goto drop;
+	local_bh_disable();
+	dst = dst_cache_get(&ilwt->cache);
+	local_bh_enable();
+
+	if (unlikely(!dst)) {
+		struct ipv6hdr *hdr = ipv6_hdr(skb);
+		struct flowi6 fl6;
+
+		memset(&fl6, 0, sizeof(fl6));
+		fl6.daddr = hdr->daddr;
+		fl6.saddr = hdr->saddr;
+		fl6.flowlabel = ip6_flowinfo(hdr);
+		fl6.flowi6_mark = skb->mark;
+		fl6.flowi6_proto = hdr->nexthdr;
+
+		dst = ip6_route_output(net, NULL, &fl6);
+		if (dst->error) {
+			err = dst->error;
+			dst_release(dst);
+			goto drop;
+		}
 
-	if (!ipv6_addr_equal(&orig_daddr, &ipv6_hdr(skb)->daddr)) {
 		local_bh_disable();
-		dst = dst_cache_get(&ilwt->cache);
+		dst_cache_set_ip6(&ilwt->cache, dst, &fl6.saddr);
 		local_bh_enable();
+	}
 
-		if (unlikely(!dst)) {
-			struct ipv6hdr *hdr = ipv6_hdr(skb);
-			struct flowi6 fl6;
-
-			memset(&fl6, 0, sizeof(fl6));
-			fl6.daddr = hdr->daddr;
-			fl6.saddr = hdr->saddr;
-			fl6.flowlabel = ip6_flowinfo(hdr);
-			fl6.flowi6_mark = skb->mark;
-			fl6.flowi6_proto = hdr->nexthdr;
-
-			dst = ip6_route_output(net, NULL, &fl6);
-			if (dst->error) {
-				err = dst->error;
-				dst_release(dst);
-				goto drop;
-			}
-
-			local_bh_disable();
-			dst_cache_set_ip6(&ilwt->cache, dst, &fl6.saddr);
-			local_bh_enable();
-		}
+	skb_dst_drop(skb);
+	skb_dst_set(skb, dst);
 
-		skb_dst_drop(skb);
-		skb_dst_set(skb, dst);
+	err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
+	if (unlikely(err))
+		goto drop;
 
+	if (!ipv6_addr_equal(&orig_daddr, &ipv6_hdr(skb)->daddr))
 		return dst_output(net, sk, skb);
-	}
 out:
-	return dst->lwtstate->orig_output(net, sk, skb);
+	return orig_dst->lwtstate->orig_output(net, sk, skb);
 drop:
 	kfree_skb(skb);
 	return err;
-- 
2.34.1


