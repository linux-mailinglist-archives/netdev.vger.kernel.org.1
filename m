Return-Path: <netdev+bounces-181328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5642AA847BE
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 17:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8E5D9A80E9
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 15:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4361E9904;
	Thu, 10 Apr 2025 15:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="mOzT9hO1"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845D5189F5C
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 15:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744298700; cv=none; b=RqM8uYZ+eOgRo71xA38X/7U0uss64lXsa3VjyWQGk5PCYj336okch3MayYPUpfJ4jVIgOD1ex+pL7lFi71WiMCDB6Dlq6tGBCQ/5FjGuZ0rMpC/yMGTov1y3XUxX8OS881NZI0I9OKkrjzUeqVFsfY02FcuurG70resmUUrd23Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744298700; c=relaxed/simple;
	bh=Ah63/2ph1kMoookg3wm9DLIhPQ+nNEftKGn/FPfbyaY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pv1AuqMBBAHEtX8RigtA7NzLEU1sfCq4rp9fKM4oLlWK0FHw0KugtUtVlHG4JnpBOcmNbWW6cKQUGivYiW6bpeUkrxU7b9EdzDV+YD4U+4S8gemLWA0stv0vIkkpFAI19DM/FX/4q7X0QQ9yI924eq6hQep10oLswe6R2kivUWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=mOzT9hO1; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id C1FBA200A8AA;
	Thu, 10 Apr 2025 17:24:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be C1FBA200A8AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1744298690;
	bh=i2fIxjkP6fIq5vWdrs4ldAsMwKK/xiAoosutAlyh7n0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mOzT9hO1d5s/Xh/gmbBeeFbhgXVjdCWNLSvvvpP882qVZiGtoUxSO1RHP7ZXbX9xh
	 i5QfcfGBFZqzF8q0ESdSFE6tRtMac15EcT+sXSl2xaS85263yCms/K8xwJUUs0L5sD
	 /Ru+jiEkBbRd1hcMeiizEQvmUvjysKlDsC2nOLs2VTwQqMja3VxTcqa3iiHeJtOIg5
	 OR5t/HR1jqO1cN33xMtqOUhUxcjP6JjgC41nVMhBKs2KBa+Ra40jtpasJmBUkN7Gy1
	 LXDcN07tVzCKrK55NaBhtjrHFEALQ5lERUuAVhTQQke0486+moSIXY7b8wuYAsdXJf
	 X18ZIk7/AYUsg==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH net-next 1/2] net: ipv6: ioam6: use consistent dst names
Date: Thu, 10 Apr 2025 17:24:31 +0200
Message-Id: <20250410152432.30246-2-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250410152432.30246-1-justin.iurman@uliege.be>
References: <20250410152432.30246-1-justin.iurman@uliege.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Be consistent and use the same terminology as other lwt users: orig_dst
is the dst_entry before the transformation, while dst is either the
dst_entry in the cache or the dst_entry after the transformation

Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
---
 net/ipv6/ioam6_iptunnel.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/net/ipv6/ioam6_iptunnel.c b/net/ipv6/ioam6_iptunnel.c
index 09065187378e..57200b9991a1 100644
--- a/net/ipv6/ioam6_iptunnel.c
+++ b/net/ipv6/ioam6_iptunnel.c
@@ -336,7 +336,8 @@ static int ioam6_do_encap(struct net *net, struct sk_buff *skb,
 
 static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
-	struct dst_entry *dst = skb_dst(skb), *cache_dst = NULL;
+	struct dst_entry *orig_dst = skb_dst(skb);
+	struct dst_entry *dst = NULL;
 	struct ioam6_lwt *ilwt;
 	int err = -EINVAL;
 	u32 pkt_cnt;
@@ -344,7 +345,7 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	if (skb->protocol != htons(ETH_P_IPV6))
 		goto drop;
 
-	ilwt = ioam6_lwt_state(dst->lwtstate);
+	ilwt = ioam6_lwt_state(orig_dst->lwtstate);
 
 	/* Check for insertion frequency (i.e., "k over n" insertions) */
 	pkt_cnt = atomic_fetch_inc(&ilwt->pkt_cnt);
@@ -352,7 +353,7 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 		goto out;
 
 	local_bh_disable();
-	cache_dst = dst_cache_get(&ilwt->cache);
+	dst = dst_cache_get(&ilwt->cache);
 	local_bh_enable();
 
 	switch (ilwt->mode) {
@@ -362,7 +363,7 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 		if (ipv6_hdr(skb)->nexthdr == NEXTHDR_HOP)
 			goto out;
 
-		err = ioam6_do_inline(net, skb, &ilwt->tuninfo, cache_dst);
+		err = ioam6_do_inline(net, skb, &ilwt->tuninfo, dst);
 		if (unlikely(err))
 			goto drop;
 
@@ -372,7 +373,7 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 		/* Encapsulation (ip6ip6) */
 		err = ioam6_do_encap(net, skb, &ilwt->tuninfo,
 				     ilwt->has_tunsrc, &ilwt->tunsrc,
-				     &ilwt->tundst, cache_dst);
+				     &ilwt->tundst, dst);
 		if (unlikely(err))
 			goto drop;
 
@@ -390,7 +391,7 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 		goto drop;
 	}
 
-	if (unlikely(!cache_dst)) {
+	if (unlikely(!dst)) {
 		struct ipv6hdr *hdr = ipv6_hdr(skb);
 		struct flowi6 fl6;
 
@@ -401,20 +402,20 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 		fl6.flowi6_mark = skb->mark;
 		fl6.flowi6_proto = hdr->nexthdr;
 
-		cache_dst = ip6_route_output(net, NULL, &fl6);
-		if (cache_dst->error) {
-			err = cache_dst->error;
+		dst = ip6_route_output(net, NULL, &fl6);
+		if (dst->error) {
+			err = dst->error;
 			goto drop;
 		}
 
 		/* cache only if we don't create a dst reference loop */
-		if (dst->lwtstate != cache_dst->lwtstate) {
+		if (orig_dst->lwtstate != dst->lwtstate) {
 			local_bh_disable();
-			dst_cache_set_ip6(&ilwt->cache, cache_dst, &fl6.saddr);
+			dst_cache_set_ip6(&ilwt->cache, dst, &fl6.saddr);
 			local_bh_enable();
 		}
 
-		err = skb_cow_head(skb, LL_RESERVED_SPACE(cache_dst->dev));
+		err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
 		if (unlikely(err))
 			goto drop;
 	}
@@ -422,16 +423,16 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	/* avoid lwtunnel_output() reentry loop when destination is the same
 	 * after transformation (e.g., with the inline mode)
 	 */
-	if (dst->lwtstate != cache_dst->lwtstate) {
+	if (orig_dst->lwtstate != dst->lwtstate) {
 		skb_dst_drop(skb);
-		skb_dst_set(skb, cache_dst);
+		skb_dst_set(skb, dst);
 		return dst_output(net, sk, skb);
 	}
 out:
-	dst_release(cache_dst);
-	return dst->lwtstate->orig_output(net, sk, skb);
+	dst_release(dst);
+	return orig_dst->lwtstate->orig_output(net, sk, skb);
 drop:
-	dst_release(cache_dst);
+	dst_release(dst);
 	kfree_skb(skb);
 	return err;
 }
-- 
2.34.1


