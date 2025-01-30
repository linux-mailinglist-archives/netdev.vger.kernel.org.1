Return-Path: <netdev+bounces-161592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E6BA227CF
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 04:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 421FB3A5CF5
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 03:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2651119A;
	Thu, 30 Jan 2025 03:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/ocN248"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A73139B
	for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 03:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738206923; cv=none; b=NxOE5D8oOaPG+FQ1y1ClD5XdlsuTTMj6WZ5bkHRsL7CVgkVWoEKuByA5KereQ67ObD72xvKOnqaZj1jxpCyF7HGRNVbjGiuT8bbpclWc1U4Lx87NR2bIgul6pWvdfm+o6jU2hctywKqJMTh8DK/77Ciy6fUdrVV/ITcvMDiEiBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738206923; c=relaxed/simple;
	bh=rsRctDTehdxhX3kihLhNgYrSW8azk4rwx0dVFnI7lcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZE/Jc64TxmrzoQD8JPYxnOkkCIj/nV1Xuhy1pBQ+jwtIOflfOr5+U4dcNI6vFj2qmYy8o+0iM9lNFQPGyWaibiDHUI56nGHkRVpIOi34iwu/oTSLASevIQ+4Oq3jmcn/vAds0X8eEHnspPoO5UyL3fH/w/rIFbhBblIBzUeaplA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/ocN248; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5441C4CED1;
	Thu, 30 Jan 2025 03:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738206923;
	bh=rsRctDTehdxhX3kihLhNgYrSW8azk4rwx0dVFnI7lcQ=;
	h=From:To:Cc:Subject:Date:From;
	b=m/ocN248z4FGQI+XHqh19BBt3Add5bZIb0cA/tOpfS9MnbsJbZ1BXIU0dbxCMSIqP
	 Yx5rD+fPV842A25ZY3zNNIdpG5tqutXvRajAHIZUIl1zDDzNXaYu049QsMYdAn5SCR
	 EBscoyakxbywlQxIoujte+7FgvJyboqxWsxMv+ug7u8wYTCl6wLETza5W+9TmVLyFk
	 PCjzSQt4NxRHwaCYxgFwO4Aca9lPZYEgQoouZdELTEEjVvn6Jpvm4dfaaHlGNC+Q+t
	 hNTmHqkXnHCfg88dGHL7GHUeBPdVRpCpqbRaXHXM7P8NlyuT6GbIBkhNU+BRLbFFd0
	 kRplH/U5vw7oQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Justin Iurman <justin.iurman@uliege.be>,
	dsahern@kernel.org
Subject: [PATCH net v2 1/2] net: ipv6: fix dst refleaks in rpl, seg6 and ioam6 lwtunnels
Date: Wed, 29 Jan 2025 19:15:18 -0800
Message-ID: <20250130031519.2716843-1-kuba@kernel.org>
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
Reviewed-by: Justin Iurman <justin.iurman@uliege.be>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: dsahern@kernel.org
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


