Return-Path: <netdev+bounces-161438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8E0A21673
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 03:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ECEE1884247
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 02:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB1518C34B;
	Wed, 29 Jan 2025 02:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sy/ccVsM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2760218BB9C
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 02:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738116831; cv=none; b=uumMceCH/ItPdTYIVw5qPSv0BFipG8dvA1jbDZtJLY2wyanDkBelzFzjgj+m7sxBTjkmFC3r1cOiPiA8xxQrbuo1/ldlnrMBDDWvBixfuf8KmXRmtVNIJaXCYRfrCwJ0T4cQOjLsJsUiQ5At88j3gcTpCjyWx/0a6ZRdQaJqfRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738116831; c=relaxed/simple;
	bh=oRmZ79oHnW6eHHeM5kMlHV2nS9XPVAOOmnB3GyNqaqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TGfXclfrz3oZ2sxWkjsWMX606S+ISQnbzty0+W1+8GkexIAL9VhsmXS8oBloSI0zJTZ1AbK1v5F7nZUQBRPOvv8ao4rGtUPlN1/Zq8xGX33yo5UON2bT+6BdMl+0RO0x/yyWluEzUuvH9Zs0+CkVlH+CiKlfzKNzTx7tyUU514g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sy/ccVsM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BCEAC4CEE5;
	Wed, 29 Jan 2025 02:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738116830;
	bh=oRmZ79oHnW6eHHeM5kMlHV2nS9XPVAOOmnB3GyNqaqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sy/ccVsMBrRznLhVCwBIzSbybjam5TMjQnGaNINwdh8q7BLMAI5BDItNDt+4QUY3k
	 myYUmWsCCYipNjLZJmNNLpw6NEafW2hgkY4nlY8JG5KeEDeKEmiehKAUuAJZIp/t51
	 ZeTuD3jXslXNEEFL4KaFgXVOmUHNdVKmBHwKtBfS858NASR/jAtjHiHlmZRMDmH/vp
	 +49CLbrrW3o4H9vzDoEFgKgChzE7HDZHtBUnFEDSde/W8qcKxt4k9FxB1/3u/OCYpP
	 j+w3NhNm0KkPK6gD2qwo89I3oKY4cmIwshgdi8PxmEmYulfmJ2BxLC5TOKZbnnX5/7
	 +lGph/n3hdl0Q==
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
Subject: [PATCH net 2/2] net: ipv6: fix dst ref loops in rpl, seg6 and ioam6 lwtunnels
Date: Tue, 28 Jan 2025 18:13:46 -0800
Message-ID: <20250129021346.2333089-2-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250129021346.2333089-1-kuba@kernel.org>
References: <20250129021346.2333089-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some lwtunnels have a dst cache for post-transformation dst.
If the packet destination did not change we may end up recording
a reference to the lwtunnel in its own cache, and the lwtunnel
state will never be freed.

Discovered by the ioam6.sh test, kmemleak was recently fixed
to catch per-cpu memory leaks. I'm not sure if rpl and seg6
can actually hit this, but in principle I don't see why not.

Fixes: 985ec6f5e623 ("net: ipv6: rpl_iptunnel: mitigate 2-realloc issue")
Fixes: 40475b63761a ("net: ipv6: seg6_iptunnel: mitigate 2-realloc issue")
Fixes: dce525185bc9 ("net: ipv6: ioam6_iptunnel: mitigate 2-realloc issue")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: dsahern@kernel.org
CC: justin.iurman@uliege.be
---
 net/ipv6/ioam6_iptunnel.c | 9 ++++++---
 net/ipv6/rpl_iptunnel.c   | 9 ++++++---
 net/ipv6/seg6_iptunnel.c  | 9 ++++++---
 3 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/net/ipv6/ioam6_iptunnel.c b/net/ipv6/ioam6_iptunnel.c
index 3936c137a572..0279f1327ad5 100644
--- a/net/ipv6/ioam6_iptunnel.c
+++ b/net/ipv6/ioam6_iptunnel.c
@@ -410,9 +410,12 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 			goto drop;
 		}
 
-		local_bh_disable();
-		dst_cache_set_ip6(&ilwt->cache, cache_dst, &fl6.saddr);
-		local_bh_enable();
+		/* cache only if we don't create a dst refrence loop */
+		if (dst->lwtstate != cache_dst->lwtstate) {
+			local_bh_disable();
+			dst_cache_set_ip6(&ilwt->cache, cache_dst, &fl6.saddr);
+			local_bh_enable();
+		}
 
 		err = skb_cow_head(skb, LL_RESERVED_SPACE(cache_dst->dev));
 		if (unlikely(err))
diff --git a/net/ipv6/rpl_iptunnel.c b/net/ipv6/rpl_iptunnel.c
index 9b7d03563115..f3febe4881a5 100644
--- a/net/ipv6/rpl_iptunnel.c
+++ b/net/ipv6/rpl_iptunnel.c
@@ -235,9 +235,12 @@ static int rpl_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 			goto drop;
 		}
 
-		local_bh_disable();
-		dst_cache_set_ip6(&rlwt->cache, dst, &fl6.saddr);
-		local_bh_enable();
+		/* cache only if we don't create a dst refrence loop */
+		if (orig_dst->lwtstate != dst->lwtstate) {
+			local_bh_disable();
+			dst_cache_set_ip6(&rlwt->cache, dst, &fl6.saddr);
+			local_bh_enable();
+		}
 
 		err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
 		if (unlikely(err))
diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
index eacc4e91b48e..0da989f07376 100644
--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -576,9 +576,12 @@ static int seg6_output_core(struct net *net, struct sock *sk,
 			goto drop;
 		}
 
-		local_bh_disable();
-		dst_cache_set_ip6(&slwt->cache, dst, &fl6.saddr);
-		local_bh_enable();
+		/* cache only if we don't create a dst refrence loop */
+		if (orig_dst->lwtstate != dst->lwtstate) {
+			local_bh_disable();
+			dst_cache_set_ip6(&slwt->cache, dst, &fl6.saddr);
+			local_bh_enable();
+		}
 
 		err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
 		if (unlikely(err))
-- 
2.48.1


