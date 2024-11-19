Return-Path: <netdev+bounces-146360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCE79D3066
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 23:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 003861F2348C
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 22:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7CB1D6DDD;
	Tue, 19 Nov 2024 22:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="iveLdEh3"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD9E1C1F08;
	Tue, 19 Nov 2024 22:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732054922; cv=none; b=mCD2norhexbpJRAkTC3vhqDcdraRKXOaMOMglTFypb43uYF1OwAFa3OjzG5HAx6ebUb/9AoC5tPpb1N5nn05iI4kYdwryVssRnxmcA66wHBeSQ4dyprRQ7H53QfXIcFcvAdiOC4iIGQMS1XjSeIXSa45eM4u4XK46KO8MB/JPp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732054922; c=relaxed/simple;
	bh=NxyQcAFC+EIcEx4ym0rUYYFqK38LZuoe4X6+NBqzFI8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hbULoAd85HiJK08hwQwLY827sFg5tLQldbUU0U7ofO3XLUXwqSMSqzddT8oY58zJGin/ZQAL2eY+JtFoGHKi27i5XkkIzWkIpTEnTtHL5zGji+Wq2iR42NSMpqxRmQ+tYBJn3XVR8T8YL6i8tXG2xYPVGCHQI4IYHikTJFt29Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=iveLdEh3; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from ubuntu.home (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id ADDA6200CCF4;
	Tue, 19 Nov 2024 23:21:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be ADDA6200CCF4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1732054910;
	bh=mQveZItNLzTIo34Os3uLO1zS26WneyxGStddfBwzByY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iveLdEh3+PKk2LCoVTnzhLXpFd+yMNnz62siU/9rBQmU9EEetcwa8pEnHseSeoy/b
	 oURlWcZ0jjEdqC0qugRbBVXYu9dYRa6kALrBhJ4qiX4LNZAsS2lpCyXLyvjXqP3Lm9
	 TnA68QCYlZSU0KhsbDLOfJ1Ha4GmQOLjaikIvBtcXu0yexBS0xNkVVmNsoLaomqBQ3
	 oamadU9jrYgOf11aUWykJDfkbSCgSo/9wJsxLc3O1+iz44GPQ3ok/F5GFLeGUjxMHZ
	 WOPAaj0nCf5ctvJtZfOSkKz6FtaQ+R44QJi3FKc4D6V5wYbgTKfcUDqRt2M9oqXZve
	 b2J0RtZEGo+KQ==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH net-next v5 2/4] net: ipv6: ioam6_iptunnel: mitigate 2-realloc issue
Date: Tue, 19 Nov 2024 23:21:37 +0100
Message-Id: <20241119222139.14338-3-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119222139.14338-1-justin.iurman@uliege.be>
References: <20241119222139.14338-1-justin.iurman@uliege.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch mitigates the two-reallocations issue with ioam6_iptunnel by
providing the dst_entry (in the cache) to the first call to
skb_cow_head(). As a result, the very first iteration may still trigger
two reallocations (i.e., empty cache), while next iterations would only
trigger a single reallocation.

Performance tests before/after applying this patch, which clearly shows
the improvement:
- inline mode:
  - before: https://ibb.co/LhQ8V63
  - after: https://ibb.co/x5YT2bS
- encap mode:
  - before: https://ibb.co/3Cjm5m0
  - after: https://ibb.co/TwpsxTC
- encap mode with tunsrc:
  - before: https://ibb.co/Gpy9QPg
  - after: https://ibb.co/PW1bZFT

This patch also fixes an incorrect behavior: after the insertion, the
second call to skb_cow_head() makes sure that the dev has enough
headroom in the skb for layer 2 and stuff. In that case, the "old"
dst_entry was used, which is now fixed. After discussing with Paolo, it
appears that both patches can be merged into a single one -this one-
(for the sake of readability) and target net-next.

Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
---
 net/ipv6/ioam6_iptunnel.c | 73 ++++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 36 deletions(-)

diff --git a/net/ipv6/ioam6_iptunnel.c b/net/ipv6/ioam6_iptunnel.c
index 9d8422e350f8..28e5a89dc255 100644
--- a/net/ipv6/ioam6_iptunnel.c
+++ b/net/ipv6/ioam6_iptunnel.c
@@ -253,14 +253,15 @@ static int ioam6_do_fill(struct net *net, struct sk_buff *skb)
 }
 
 static int ioam6_do_inline(struct net *net, struct sk_buff *skb,
-			   struct ioam6_lwt_encap *tuninfo)
+			   struct ioam6_lwt_encap *tuninfo,
+			   struct dst_entry *cache_dst)
 {
 	struct ipv6hdr *oldhdr, *hdr;
 	int hdrlen, err;
 
 	hdrlen = (tuninfo->eh.hdrlen + 1) << 3;
 
-	err = skb_cow_head(skb, hdrlen + skb->mac_len);
+	err = skb_cow_head(skb, hdrlen + dst_dev_overhead(cache_dst, skb));
 	if (unlikely(err))
 		return err;
 
@@ -291,7 +292,8 @@ static int ioam6_do_encap(struct net *net, struct sk_buff *skb,
 			  struct ioam6_lwt_encap *tuninfo,
 			  bool has_tunsrc,
 			  struct in6_addr *tunsrc,
-			  struct in6_addr *tundst)
+			  struct in6_addr *tundst,
+			  struct dst_entry *cache_dst)
 {
 	struct dst_entry *dst = skb_dst(skb);
 	struct ipv6hdr *hdr, *inner_hdr;
@@ -300,7 +302,7 @@ static int ioam6_do_encap(struct net *net, struct sk_buff *skb,
 	hdrlen = (tuninfo->eh.hdrlen + 1) << 3;
 	len = sizeof(*hdr) + hdrlen;
 
-	err = skb_cow_head(skb, len + skb->mac_len);
+	err = skb_cow_head(skb, len + dst_dev_overhead(cache_dst, skb));
 	if (unlikely(err))
 		return err;
 
@@ -334,7 +336,7 @@ static int ioam6_do_encap(struct net *net, struct sk_buff *skb,
 
 static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
-	struct dst_entry *dst = skb_dst(skb);
+	struct dst_entry *dst = skb_dst(skb), *cache_dst;
 	struct in6_addr orig_daddr;
 	struct ioam6_lwt *ilwt;
 	int err = -EINVAL;
@@ -352,6 +354,10 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 
 	orig_daddr = ipv6_hdr(skb)->daddr;
 
+	local_bh_disable();
+	cache_dst = dst_cache_get(&ilwt->cache);
+	local_bh_enable();
+
 	switch (ilwt->mode) {
 	case IOAM6_IPTUNNEL_MODE_INLINE:
 do_inline:
@@ -359,7 +365,7 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 		if (ipv6_hdr(skb)->nexthdr == NEXTHDR_HOP)
 			goto out;
 
-		err = ioam6_do_inline(net, skb, &ilwt->tuninfo);
+		err = ioam6_do_inline(net, skb, &ilwt->tuninfo, cache_dst);
 		if (unlikely(err))
 			goto drop;
 
@@ -369,7 +375,7 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 		/* Encapsulation (ip6ip6) */
 		err = ioam6_do_encap(net, skb, &ilwt->tuninfo,
 				     ilwt->has_tunsrc, &ilwt->tunsrc,
-				     &ilwt->tundst);
+				     &ilwt->tundst, cache_dst);
 		if (unlikely(err))
 			goto drop;
 
@@ -387,41 +393,36 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 		goto drop;
 	}
 
-	err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
-	if (unlikely(err))
-		goto drop;
+	if (unlikely(!cache_dst)) {
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
+		cache_dst = ip6_route_output(net, NULL, &fl6);
+		if (cache_dst->error) {
+			err = cache_dst->error;
+			dst_release(cache_dst);
+			goto drop;
+		}
 
-	if (!ipv6_addr_equal(&orig_daddr, &ipv6_hdr(skb)->daddr)) {
 		local_bh_disable();
-		dst = dst_cache_get(&ilwt->cache);
+		dst_cache_set_ip6(&ilwt->cache, cache_dst, &fl6.saddr);
 		local_bh_enable();
 
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
+		err = skb_cow_head(skb, LL_RESERVED_SPACE(cache_dst->dev));
+		if (unlikely(err))
+			goto drop;
+	}
 
+	if (!ipv6_addr_equal(&orig_daddr, &ipv6_hdr(skb)->daddr)) {
 		skb_dst_drop(skb);
-		skb_dst_set(skb, dst);
-
+		skb_dst_set(skb, cache_dst);
 		return dst_output(net, sk, skb);
 	}
 out:
-- 
2.34.1


