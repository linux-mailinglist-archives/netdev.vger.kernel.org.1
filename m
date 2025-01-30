Return-Path: <netdev+bounces-161593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBADA227D0
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 04:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B56363A66D1
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 03:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B31E70814;
	Thu, 30 Jan 2025 03:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxydkxCa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178B02A8C1
	for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 03:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738206924; cv=none; b=mJc4O5yNKfZuVhV2y3SQYfiP4CJsTm02OsUSpowdpTSwCKvBRfnJsSZxY7KyITKUx+p1uuJUBDdroKH7ZKf1r7bu+Ob2x3ciA9UJGURyZHQHwnrOlpukijdvCGzWUuPgP6i+2i+8s3Wnd9gQ4S++H3o25E7+2GtP/ho+/ts9YNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738206924; c=relaxed/simple;
	bh=1N/bb2E9l0WDpQGqtBrNqGqG4OnZj3avmgnn3BZsmpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ROfrcJzlLRxq7Zm+b8NKplj7MQTfsLOnlvlRFi11NU1ZZmzvV85PMJtFxIS6DoOkenJqdSopugskjqGjPADO3/WAEmsOkdzBuL6WkAQohOTeKz3175J3xQJ/dlcteAAZYWNGrGpjiH5iMkMrzNTM9dBcWWiDwjmNfzq2jCvw4bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxydkxCa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E9CCC4CEDF;
	Thu, 30 Jan 2025 03:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738206923;
	bh=1N/bb2E9l0WDpQGqtBrNqGqG4OnZj3avmgnn3BZsmpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BxydkxCagaJYtKZ+WC+6EI9VWKzUEA5jYXpoRQMH2HtlbT58HCshH4u2/vAavAAWB
	 jao2M3qTvZF0s41Xkum/NCDlgStBOtPrB1CEeyJHALh68XOmxXjWfXrQD2+SDvo1+o
	 zGd4yIvBlC/PjRGiKX3xM4ecyIT8hHL3D3ZcEpUrM9lODrFDOpUjzsSCJ3PigUoEAt
	 1GztOQPJsk+TACtlWyRdtpLtFL0HIEK0gg0hfdNxwG6m3+Z8Lq5IfTZTesmVv0Kn7u
	 dinytjpT/kvJfcLOHMzARuiCikkPWp5EkJ9R5ayKdOuIvxRxSSKipKvXl8i4v0OMDt
	 gdagRQ83Lt+Ow==
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
Subject: [PATCH net v2 2/2] net: ipv6: fix dst ref loops in rpl, seg6 and ioam6 lwtunnels
Date: Wed, 29 Jan 2025 19:15:19 -0800
Message-ID: <20250130031519.2716843-2-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250130031519.2716843-1-kuba@kernel.org>
References: <20250130031519.2716843-1-kuba@kernel.org>
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
v2:
 - fix spello in the comments
v1: https://lore.kernel.org/20250129021346.2333089-2-kuba@kernel.org

CC: dsahern@kernel.org
CC: justin.iurman@uliege.be
---
 net/ipv6/ioam6_iptunnel.c | 9 ++++++---
 net/ipv6/rpl_iptunnel.c   | 9 ++++++---
 net/ipv6/seg6_iptunnel.c  | 9 ++++++---
 3 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/net/ipv6/ioam6_iptunnel.c b/net/ipv6/ioam6_iptunnel.c
index 3936c137a572..2c383c12a431 100644
--- a/net/ipv6/ioam6_iptunnel.c
+++ b/net/ipv6/ioam6_iptunnel.c
@@ -410,9 +410,12 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 			goto drop;
 		}
 
-		local_bh_disable();
-		dst_cache_set_ip6(&ilwt->cache, cache_dst, &fl6.saddr);
-		local_bh_enable();
+		/* cache only if we don't create a dst reference loop */
+		if (dst->lwtstate != cache_dst->lwtstate) {
+			local_bh_disable();
+			dst_cache_set_ip6(&ilwt->cache, cache_dst, &fl6.saddr);
+			local_bh_enable();
+		}
 
 		err = skb_cow_head(skb, LL_RESERVED_SPACE(cache_dst->dev));
 		if (unlikely(err))
diff --git a/net/ipv6/rpl_iptunnel.c b/net/ipv6/rpl_iptunnel.c
index 9b7d03563115..0ac4283acdf2 100644
--- a/net/ipv6/rpl_iptunnel.c
+++ b/net/ipv6/rpl_iptunnel.c
@@ -235,9 +235,12 @@ static int rpl_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 			goto drop;
 		}
 
-		local_bh_disable();
-		dst_cache_set_ip6(&rlwt->cache, dst, &fl6.saddr);
-		local_bh_enable();
+		/* cache only if we don't create a dst reference loop */
+		if (orig_dst->lwtstate != dst->lwtstate) {
+			local_bh_disable();
+			dst_cache_set_ip6(&rlwt->cache, dst, &fl6.saddr);
+			local_bh_enable();
+		}
 
 		err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
 		if (unlikely(err))
diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
index eacc4e91b48e..33833b2064c0 100644
--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -576,9 +576,12 @@ static int seg6_output_core(struct net *net, struct sock *sk,
 			goto drop;
 		}
 
-		local_bh_disable();
-		dst_cache_set_ip6(&slwt->cache, dst, &fl6.saddr);
-		local_bh_enable();
+		/* cache only if we don't create a dst reference loop */
+		if (orig_dst->lwtstate != dst->lwtstate) {
+			local_bh_disable();
+			dst_cache_set_ip6(&slwt->cache, dst, &fl6.saddr);
+			local_bh_enable();
+		}
 
 		err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
 		if (unlikely(err))
-- 
2.48.1


