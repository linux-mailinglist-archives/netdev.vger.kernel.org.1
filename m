Return-Path: <netdev+bounces-165304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A00DCA31871
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 23:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A21383A26D7
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 22:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08F7268C6F;
	Tue, 11 Feb 2025 22:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="cevvMr+b"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A1B262D33
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 22:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739312201; cv=none; b=hGaBRSao2kzS8q7BRZCUbXRBVfntZdB2abZrECOjrnXL6xRePmtrGpu+pH4WuMYWrzGCCdyV7crK12e+XlslkaaMdloLVeREOaIsy3q+pvYDLGn+CP6pARppjSb9DyLfuAQjpTnAaggCE+Ln8veTXgSadhqhIFVgfn59G6HoEY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739312201; c=relaxed/simple;
	bh=UdVsu3mrtgi1GRZ8/KNToR9K4OYzp7rRJad2qovDibU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aTtN429B3/mUTymjM/QfnJ9YD1qGtq3dNzZVJ9c+Jh6I8cONjhWniYsyUCYWz71pX4g3smlpeS9SIBmxi/iJ6Jqa1aXf2n5ouTTLcVbhc3YYzzrH2ldd+ueEyrQ0NxCtPIadVG+iZEQl9+Il9jcDtn806+HVPnh4SEBHMdJzyNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=cevvMr+b; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (unknown [10.29.255.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 365CD200DB9A;
	Tue, 11 Feb 2025 23:16:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 365CD200DB9A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1739312192;
	bh=RHzIYsOrUNhMomVXoaZrFPBYkrAl2jJ7ocffOr6lJBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cevvMr+bBgwDLiEYXc9NEjF/fbzoMqUn0N5XqtLgm8cDHNkBBGvbMLco/ZfXkWbI1
	 K7vbVeMvYG9227jc7o97bnokhUeOdNbZPoBpYbZNs3CjfpSkfpArNj/+hZ+nx/YMtN
	 gckd0wpb6bo7fdJ30+wYyiLXsm94lqhUY73MvNkXYEbPkENUeaJ5G13695RxAghUPW
	 ygMPC+tcmi6LF/XajF7DJq6ZSMaGNlt/BJIuQl6O2AVibqG5Vi+3nIb1+wKscvgyeC
	 pZq7QRSBvRShqHzG9vrRm6b9/TZzw3HfMKcDW/4FZDW5WkhowJG1SM6qlivmfPOz4L
	 Ud7bM8N7dc3fA==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH net v2 3/3] net: ipv6: fix consecutive input and output transformation in lwtunnels
Date: Tue, 11 Feb 2025 23:16:24 +0100
Message-Id: <20250211221624.18435-4-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211221624.18435-1-justin.iurman@uliege.be>
References: <20250211221624.18435-1-justin.iurman@uliege.be>
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

Fixes: a7a29f9c361f ("net: ipv6: add rpl sr tunnel")
Fixes: 6c8702c60b88 ("ipv6: sr: add support for SRH encapsulation and injection with lwtunnels")
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
index 5ce662d8f334..69233c2ed658 100644
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
 		in_func = seg6_input_redirect_finish;
-	else
+	} else {
 		in_func = seg6_input_finish;
+	}
 
 	if (static_branch_unlikely(&nf_hooks_lwtunnel_enabled))
 		return NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_OUT,
@@ -573,6 +577,12 @@ static int seg6_output_core(struct net *net, struct sock *sk,
 	struct seg6_lwt *slwt;
 	int err;
 
+	/* Don't re-apply the transformation when seg6_input() already did it */
+	if (skb_is_redirected(skb)) {
+		skb_reset_redirect(skb);
+		return orig_dst->lwtstate->orig_output(net, sk, skb);
+	}
+
 	slwt = seg6_lwt_lwtunnel(orig_dst->lwtstate);
 
 	local_bh_disable();
-- 
2.34.1


