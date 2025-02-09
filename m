Return-Path: <netdev+bounces-164509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2D2A2E046
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 20:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBDFF164699
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 19:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606491E32BD;
	Sun,  9 Feb 2025 19:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="B5plJkhb"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66E81E231A
	for <netdev@vger.kernel.org>; Sun,  9 Feb 2025 19:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739130295; cv=none; b=ka2QVTUmMqXS6+yjoNgipZvWKhX1uNXZ75Wq8eil3XflIE/X+AYGXbC2g4iYy1iaunDAf/5fyGWx2aXtZPXkYfK+svtQ8yGNwdbf8yWg/xsm70mgC80yu/r8Ms8Lmq5kZx93DNaDRLnR4FRh6k5O9otu5i0mUSZOjwOiHRZC8q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739130295; c=relaxed/simple;
	bh=sa7e51/w+DCZXb0mLrZPoVCOgp02JE689pS4IVsWYJU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i8V6bZlOMIEdp9fSb8kia5xKGQsOyi12L35hEZwSPdJ73UF/nUu2JQgt5bfUN5NRWA4aUIrJcsY7PAlAL2JE7bW32z6skKiuH85vVLooOrAEIUUpoP64iqvlnUuqy7Qys9pNsjAa98hqw6W+xLrPuUp6/iO0cGYnG0oLP7vnKFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=B5plJkhb; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from ubuntu.home (lfbn-ncy-1-721-166.w86-216.abo.wanadoo.fr [86.216.56.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 0E16A200E2B8;
	Sun,  9 Feb 2025 20:39:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 0E16A200E2B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1739129976;
	bh=BcQoNa2dVJYJXIinBzkuvymO9wfzsaRF1eTbnNsCWIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B5plJkhbJcXkEI7erJQg4h8pKY2mgyzIlL4nbREv1WpCaBDkDQqT82qPJoujhir43
	 6JDUU57P3SwGKwTrWyW/WoHxdRxDA0dMWesxHBiwrvNTXyIVlsmwBl0vFYxlvZYl3M
	 w12ZmUDKQ0IUKCOPUU062vQBfBmfDNp9jAZt0nEhbSWSlYl4ofqgjhrk+wNMHuiay0
	 e6MEtO3V+hUQLiqw+Vldjz33jCcY6OQWWnvOzKHR+PeWV/ObXIhJ84eCNmpLt67B2/
	 hLNThabnT2+lrxUsFoP7dqBcZsOQo2//hZ4wiD0i6YXVcqg4Gdep492AaWU9CiTpU4
	 2sJRmcvELgTYg==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH net 3/3] net: ipv6: fix consecutive input and output transformation in lwtunnels
Date: Sun,  9 Feb 2025 20:38:40 +0100
Message-Id: <20250209193840.20509-4-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250209193840.20509-1-justin.iurman@uliege.be>
References: <20250209193840.20509-1-justin.iurman@uliege.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some lwtunnel users implement both lwt input and output handlers. If the
post-transformation destination on input is the same, the output handler
is also called and the same transformation is applied (again). Here are
the users: ila, bpf, rpl, seg6. The first one (ila) does not need this
fix, since it already implements a check to avoid such a duplicate. The
second (bpf) may need this fix, but I'm not familiar with that code path
and will keep it out of this patch. The two others (rpl and seg6) do
need this patch.

Due to the ila implementation (as an example), we cannot fix the issue
in lwtunnel_input() and lwtunnel_output() directly. Instead, we need to
do it on a case-by-case basis. This patch fixes both rpl_iptunnel and
seg6_iptunnel users. The fix re-uses skb->redirected in input handlers
to notify corresponding output handlers that the transformation was
already applied and to skip it. The "redirected" field seems safe to be
used here.

Fixes a7a29f9c361f ("net: ipv6: add rpl sr tunnel")
Fixes 6c8702c60b88 ("ipv6: sr: add support for SRH encapsulation and injection with lwtunnels")
Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
---
 net/ipv6/rpl_iptunnel.c  | 14 ++++++++++++--
 net/ipv6/seg6_iptunnel.c | 16 +++++++++++++---
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/net/ipv6/rpl_iptunnel.c b/net/ipv6/rpl_iptunnel.c
index dc004e9aa649..2dc1f2297e39 100644
--- a/net/ipv6/rpl_iptunnel.c
+++ b/net/ipv6/rpl_iptunnel.c
@@ -208,6 +208,12 @@ static int rpl_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	struct rpl_lwt *rlwt;
 	int err;
 
+	/* Don't re-apply the transformation when rpl_input() already did it */
+	if (skb_is_redirected(skb)) {
+		skb_reset_redirect(skb);
+		return orig_dst->lwtstate->orig_output(net, sk, skb);
+	}
+
 	rlwt = rpl_lwt_lwtunnel(orig_dst->lwtstate);
 
 	local_bh_disable();
@@ -311,9 +317,13 @@ static int rpl_input(struct sk_buff *skb)
 		skb_dst_set(skb, dst);
 	}
 
-	/* avoid a lwtunnel_input() loop when dst_entry is the same */
-	if (lwtst == dst->lwtstate)
+	/* avoid a lwtunnel_input() loop when dst_entry is the same, and make
+	 * sure rpl_output() does not apply the transformation one more time
+	 */
+	if (lwtst == dst->lwtstate) {
+		skb_set_redirected_noclear(skb, true);
 		return dst->lwtstate->orig_input(skb);
+	}
 
 	return dst_input(skb);
 
diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
index 9fce6b2dbd54..539c79903ffa 100644
--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -522,11 +522,15 @@ static int seg6_input_core(struct net *net, struct sock *sk,
 		skb_dst_set(skb, dst);
 	}
 
-	/* avoid a lwtunnel_input() loop when dst_entry is the same */
-	if (lwtst == dst->lwtstate)
+	/* avoid a lwtunnel_input() loop when dst_entry is the same, and make
+	 * sure seg6_output() does not apply the transformation one more time
+	 */
+	if (lwtst == dst->lwtstate) {
+		skb_set_redirected_noclear(skb, true);
 		input_func = seg6_input_redirect_finish;
-	else
+	} else {
 		input_func = seg6_input_finish;
+	}
 
 	if (static_branch_unlikely(&nf_hooks_lwtunnel_enabled))
 		return NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_OUT,
@@ -573,6 +577,12 @@ static int seg6_output_core(struct net *net, struct sock *sk,
 	struct seg6_lwt *slwt;
 	int err;
 
+        /* Don't re-apply the transformation when seg6_input() already did it */
+        if (skb_is_redirected(skb)) {
+                skb_reset_redirect(skb);
+                return orig_dst->lwtstate->orig_output(net, sk, skb);
+        }
+
 	slwt = seg6_lwt_lwtunnel(orig_dst->lwtstate);
 
 	local_bh_disable();
-- 
2.34.1


