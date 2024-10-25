Return-Path: <netdev+bounces-139112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD129B046D
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 15:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B00B01F24099
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 13:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF3E1D9A66;
	Fri, 25 Oct 2024 13:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="0u6jS3/u"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB58212177;
	Fri, 25 Oct 2024 13:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729863987; cv=none; b=HAIxHz9baDDZjFI1j7doZrPtLWAuqOvg4AFYLU6ObZkrpta91XYjeFMR4gbOWN8kBcz6UXCuggpAdFIBdYWl7ol7jisafRez3728RDO32XHmXJ/2WzDboBaVWJ/7emoSK3rrOKmancKnvREFiyYkq3wJF6wQbB82IQofBkCMNFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729863987; c=relaxed/simple;
	bh=pN5S/suqrVBmUuOOhlG641kV76MVLuZyxF3UxYpKWJM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IeDIzHPjGGs2piKpP4p02s9W2ndGgs4zTXg227JU2Jr0REj72e5f/DulaaekIuG2mXdVwcv5+97OluZJ1oXCmPDTJ8GHANCQ0L5+JRVY+5L9pGP1fT8KqQkBaQGqX1Ozjhs+akkGJMDG6P+F5CnOoz47WoWuDzdRZFmjxiifKyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=0u6jS3/u; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id A96AC200EEC4;
	Fri, 25 Oct 2024 15:37:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be A96AC200EEC4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1729863469;
	bh=1+tgB7eC8476UFHHG9DorVn20PbINOrYtk0wudgCZhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0u6jS3/u+5aFCoCVC8vpi0PKT8EEk+Qi/zedGzpgSz+VMpSY9yuWCZ+Mi+SEFrtR/
	 Qt1D1M1NmZQuRviwumzhj7fNCOqqaBhxIH+drhkLhstIKMf8Wz2idZA/OHGYxWopGQ
	 G/jvoLqJ12eNfqLeUmjXnv3bDuNu8gw0ZsTRJnhtcPJpce4AWF0JjoEN+F2jX/Ba+3
	 QxMsWtALS7/6+yjLuEKULusC9i2k1YZF8aLuuQL8FOemZl8Uw8wVrI7Xnqs5T1DQul
	 rECe0MyBq+ftV/XKzADn1P09xfHsAonURjWX1xaenkoEFSTm61ZlbWcqS91RPaVZ9X
	 8MUimQdGxSo8Q==
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
Subject: [PATCH net-next 1/3] net: ipv6: ioam6_iptunnel: mitigate 2-realloc issue
Date: Fri, 25 Oct 2024 15:37:25 +0200
Message-Id: <20241025133727.27742-2-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025133727.27742-1-justin.iurman@uliege.be>
References: <20241025133727.27742-1-justin.iurman@uliege.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch mitigates the two-reallocations issue with ioam6_iptunnel by
providing the dst_entry (in the cache) to the first call to
skb_cow_head(). As a result, the very first iteration would still
trigger two reallocations (i.e., empty cache), while next iterations
would only trigger a single reallocation.

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
 net/ipv6/ioam6_iptunnel.c | 84 ++++++++++++++++++++-------------------
 1 file changed, 43 insertions(+), 41 deletions(-)

diff --git a/net/ipv6/ioam6_iptunnel.c b/net/ipv6/ioam6_iptunnel.c
index beb6b4cfc551..da79055fc02a 100644
--- a/net/ipv6/ioam6_iptunnel.c
+++ b/net/ipv6/ioam6_iptunnel.c
@@ -255,14 +255,16 @@ static int ioam6_do_fill(struct net *net, struct sk_buff *skb)
 }
 
 static int ioam6_do_inline(struct net *net, struct sk_buff *skb,
-			   struct ioam6_lwt_encap *tuninfo)
+			   struct ioam6_lwt_encap *tuninfo,
+			   struct dst_entry *dst)
 {
 	struct ipv6hdr *oldhdr, *hdr;
 	int hdrlen, err;
 
 	hdrlen = (tuninfo->eh.hdrlen + 1) << 3;
 
-	err = skb_cow_head(skb, hdrlen + skb->mac_len);
+	err = skb_cow_head(skb, hdrlen + (!dst ? skb->mac_len
+					       : LL_RESERVED_SPACE(dst->dev)));
 	if (unlikely(err))
 		return err;
 
@@ -293,16 +295,17 @@ static int ioam6_do_encap(struct net *net, struct sk_buff *skb,
 			  struct ioam6_lwt_encap *tuninfo,
 			  bool has_tunsrc,
 			  struct in6_addr *tunsrc,
-			  struct in6_addr *tundst)
+			  struct in6_addr *tundst,
+			  struct dst_entry *dst)
 {
-	struct dst_entry *dst = skb_dst(skb);
 	struct ipv6hdr *hdr, *inner_hdr;
 	int hdrlen, len, err;
 
 	hdrlen = (tuninfo->eh.hdrlen + 1) << 3;
 	len = sizeof(*hdr) + hdrlen;
 
-	err = skb_cow_head(skb, len + skb->mac_len);
+	err = skb_cow_head(skb, len + (!dst ? skb->mac_len
+					    : LL_RESERVED_SPACE(dst->dev)));
 	if (unlikely(err))
 		return err;
 
@@ -326,7 +329,7 @@ static int ioam6_do_encap(struct net *net, struct sk_buff *skb,
 	if (has_tunsrc)
 		memcpy(&hdr->saddr, tunsrc, sizeof(*tunsrc));
 	else
-		ipv6_dev_get_saddr(net, dst->dev, &hdr->daddr,
+		ipv6_dev_get_saddr(net, skb_dst(skb)->dev, &hdr->daddr,
 				   IPV6_PREFER_SRC_PUBLIC, &hdr->saddr);
 
 	skb_postpush_rcsum(skb, hdr, len);
@@ -336,7 +339,7 @@ static int ioam6_do_encap(struct net *net, struct sk_buff *skb,
 
 static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
-	struct dst_entry *dst = skb_dst(skb);
+	struct dst_entry *dst, *orig_dst = skb_dst(skb);
 	struct in6_addr orig_daddr;
 	struct ioam6_lwt *ilwt;
 	int err = -EINVAL;
@@ -345,7 +348,7 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	if (skb->protocol != htons(ETH_P_IPV6))
 		goto drop;
 
-	ilwt = ioam6_lwt_state(dst->lwtstate);
+	ilwt = ioam6_lwt_state(orig_dst->lwtstate);
 
 	/* Check for insertion frequency (i.e., "k over n" insertions) */
 	pkt_cnt = atomic_fetch_inc(&ilwt->pkt_cnt);
@@ -354,6 +357,10 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 
 	orig_daddr = ipv6_hdr(skb)->daddr;
 
+	local_bh_disable();
+	dst = dst_cache_get(&ilwt->cache);
+	local_bh_enable();
+
 	switch (ilwt->mode) {
 	case IOAM6_IPTUNNEL_MODE_INLINE:
 do_inline:
@@ -361,7 +368,7 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 		if (ipv6_hdr(skb)->nexthdr == NEXTHDR_HOP)
 			goto out;
 
-		err = ioam6_do_inline(net, skb, &ilwt->tuninfo);
+		err = ioam6_do_inline(net, skb, &ilwt->tuninfo, dst);
 		if (unlikely(err))
 			goto drop;
 
@@ -371,7 +378,7 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 		/* Encapsulation (ip6ip6) */
 		err = ioam6_do_encap(net, skb, &ilwt->tuninfo,
 				     ilwt->has_tunsrc, &ilwt->tunsrc,
-				     &ilwt->tundst);
+				     &ilwt->tundst, dst);
 		if (unlikely(err))
 			goto drop;
 
@@ -389,45 +396,40 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 		goto drop;
 	}
 
-	err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
-	if (unlikely(err))
-		goto drop;
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
+		err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
+		if (unlikely(err))
+			goto drop;
+	}
 
-		skb_dst_drop(skb);
-		skb_dst_set(skb, dst);
+	skb_dst_drop(skb);
+	skb_dst_set(skb, dst);
 
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


