Return-Path: <netdev+bounces-161437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0441A21672
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 03:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D637F1889182
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 02:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C17189B94;
	Wed, 29 Jan 2025 02:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pb7FSKaJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B4A42A8B
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 02:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738116830; cv=none; b=GGmK2IZRbjO09hv/UC3BKMBvsqk9YsEc3xf8XariAYCjI0Ws4i16FAX8avQznk1Zk3E845Su8Pua563YnbY1RsSvLz8Am1lFqTTZh55mzFbdOrB67z8I9xWZKOUSmOuzuElqBY/wKDqgnRcnZ6koTODeIPUrZN0UvBpq6mnDdo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738116830; c=relaxed/simple;
	bh=BRVnhNUR3RrGIkjlGeTm2FvSq4TNEHza5vwFOHCy68g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kn1pe8betPaOMwiTAH5/EWNo6uHIZAh/ahm8MGbwZmqN4gECVMvx7AYr9IFIs7UaiPrhW8QY3W/YzMaletpDPO2sOSFBhbPigeQ69GwivDGnJrEyrv1CeSyDAPxbLHASOoYWSYpxEeaR/R2txjK+znpd4wVppXAqOm4oHsKZ6Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pb7FSKaJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B49C4CED3;
	Wed, 29 Jan 2025 02:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738116830;
	bh=BRVnhNUR3RrGIkjlGeTm2FvSq4TNEHza5vwFOHCy68g=;
	h=From:To:Cc:Subject:Date:From;
	b=Pb7FSKaJbYW0gpLkN5ZxtF5kDWfu/n2/qw9oVnQZvP+gsFrRcn2/JQe3kgT/yWf50
	 DeGXhSYsC9n2oAcFzy//2uRvISMDGbc1lSixPZobQ6Pfy0xxMQ6AISvcbhjeIS/wQp
	 0bwpV8zACFr4ThC4Lq+XslSZqU+J/oqOqxQZ94lLXhz56RUADTYxgnrmKiL3F89XLA
	 hohkd7DbyU7gEX5pfEaF6tMDLV4tzYjzw/wHurDwCn3EpGE5zWRNvWKUW6Fo/iHJ4p
	 Z0p7uGPhWDCa6hFv5j4kB9kU3G5rLcJ8TnJMdZW8gvr2AUa0x8cvkS//8Vv16dp5sS
	 +KjvJVkRnNeFA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	dsahern@kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH net 1/2] net: ipv6: fix dst refleaks in rpl, seg6 and ioam6 lwtunnels
Date: Tue, 28 Jan 2025 18:13:45 -0800
Message-ID: <20250129021346.2333089-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dst_cache_get() gives us a reference, we need to release it.

Discovered by the ioam6.sh test, kmemleak was recently fixed
to catch per-cpu memory leaks.

Fixes: 985ec6f5e623 ("net: ipv6: rpl_iptunnel: mitigate 2-realloc issue")
Fixes: 40475b63761a ("net: ipv6: seg6_iptunnel: mitigate 2-realloc issue")
Fixes: dce525185bc9 ("net: ipv6: ioam6_iptunnel: mitigate 2-realloc issue")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: dsahern@kernel.org
CC: justin.iurman@uliege.be
---
 net/ipv6/ioam6_iptunnel.c | 5 +++--
 net/ipv6/rpl_iptunnel.c   | 6 ++++--
 net/ipv6/seg6_iptunnel.c  | 6 ++++--
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/net/ipv6/ioam6_iptunnel.c b/net/ipv6/ioam6_iptunnel.c
index 28e5a89dc255..3936c137a572 100644
--- a/net/ipv6/ioam6_iptunnel.c
+++ b/net/ipv6/ioam6_iptunnel.c
@@ -336,7 +336,7 @@ static int ioam6_do_encap(struct net *net, struct sk_buff *skb,
 
 static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
-	struct dst_entry *dst = skb_dst(skb), *cache_dst;
+	struct dst_entry *dst = skb_dst(skb), *cache_dst = NULL;
 	struct in6_addr orig_daddr;
 	struct ioam6_lwt *ilwt;
 	int err = -EINVAL;
@@ -407,7 +407,6 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 		cache_dst = ip6_route_output(net, NULL, &fl6);
 		if (cache_dst->error) {
 			err = cache_dst->error;
-			dst_release(cache_dst);
 			goto drop;
 		}
 
@@ -426,8 +425,10 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 		return dst_output(net, sk, skb);
 	}
 out:
+	dst_release(cache_dst);
 	return dst->lwtstate->orig_output(net, sk, skb);
 drop:
+	dst_release(cache_dst);
 	kfree_skb(skb);
 	return err;
 }
diff --git a/net/ipv6/rpl_iptunnel.c b/net/ipv6/rpl_iptunnel.c
index 7ba22d2f2bfe..9b7d03563115 100644
--- a/net/ipv6/rpl_iptunnel.c
+++ b/net/ipv6/rpl_iptunnel.c
@@ -232,7 +232,6 @@ static int rpl_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 		dst = ip6_route_output(net, NULL, &fl6);
 		if (dst->error) {
 			err = dst->error;
-			dst_release(dst);
 			goto drop;
 		}
 
@@ -251,6 +250,7 @@ static int rpl_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	return dst_output(net, sk, skb);
 
 drop:
+	dst_release(dst);
 	kfree_skb(skb);
 	return err;
 }
@@ -269,8 +269,10 @@ static int rpl_input(struct sk_buff *skb)
 	local_bh_enable();
 
 	err = rpl_do_srh(skb, rlwt, dst);
-	if (unlikely(err))
+	if (unlikely(err)) {
+		dst_release(dst);
 		goto drop;
+	}
 
 	if (!dst) {
 		ip6_route_input(skb);
diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
index 4bf937bfc263..eacc4e91b48e 100644
--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -482,8 +482,10 @@ static int seg6_input_core(struct net *net, struct sock *sk,
 	local_bh_enable();
 
 	err = seg6_do_srh(skb, dst);
-	if (unlikely(err))
+	if (unlikely(err)) {
+		dst_release(dst);
 		goto drop;
+	}
 
 	if (!dst) {
 		ip6_route_input(skb);
@@ -571,7 +573,6 @@ static int seg6_output_core(struct net *net, struct sock *sk,
 		dst = ip6_route_output(net, NULL, &fl6);
 		if (dst->error) {
 			err = dst->error;
-			dst_release(dst);
 			goto drop;
 		}
 
@@ -593,6 +594,7 @@ static int seg6_output_core(struct net *net, struct sock *sk,
 
 	return dst_output(net, sk, skb);
 drop:
+	dst_release(dst);
 	kfree_skb(skb);
 	return err;
 }
-- 
2.48.1


