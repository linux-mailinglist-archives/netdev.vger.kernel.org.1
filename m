Return-Path: <netdev+bounces-173915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD1BA5C375
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 15:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E1C31774E0
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 14:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722AB25BAAA;
	Tue, 11 Mar 2025 14:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="lYlJQJrG"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB7725BAA6
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 14:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741702404; cv=none; b=GwTm8Udg56+S4TRaEO8gehr/6pHOqnyEgm3ciih3e56G6UyvsBUQR8K02r2hqmf5LN0C5ItqzmVR01lkt458nISR13wMdMSS1LJd/kRBE5+hlm1pZCFk7tOPRPTD3Fb3AThQik5C0igEtoIXKNouowx4GjrKH1LY3ffz672bTv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741702404; c=relaxed/simple;
	bh=MIV7/izstExolPlXQ7yNxt/kD8CFmRLjFk4u7naaJCU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uifSWJHCwcTCHuymy/LOeWeZ89II/Jt7TlqWWJZ2xIURFmuqq8tSEmFmgxz7s06/mI+dbbEp7Yx32B2gQ1EQ01ArFfDL7dOI4GD08AnQ9YoLEBY7PiGnXgyv16gaVrNFebx8It7vJwoHC9gyNpuJvsXT9Ya0jSjcGy6KHDRqdS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=lYlJQJrG; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (unknown [195.29.54.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 38B37200E1C2;
	Tue, 11 Mar 2025 15:13:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 38B37200E1C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1741702401;
	bh=SrFzeG7WESB6iRaodQ62GFVhuvaWk2gni+EKmPpz1UQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lYlJQJrGxwroYTsCLih1Q4NfMY5zU5NxEM9Yl1HBlxc7ln23ZjAW6mgMDE8bwNeKu
	 oG1wOcH4Fhb0ph9GRlfsiZbQ5AJd62IjDaqGoDZ7bkd/N73iO1bz+DbykveVRcY1/4
	 zMTGcIqkh7CjcJzOJqesPRkfnP3sJl2SPacMMUNjV70LvJjHx0jEZORjwqEWO2nNWq
	 7v4ZTZnmMJovGTq9TTYNIJEM3xzq25eCiG2w2KwyHmLetZfxxUIi825ZFPkitxItdf
	 BKt3HM3OjztA+gqeKxL+sA2jJ4eulNr1UfEXnBh+ZFLa3DaT58AqniIJ21+8NaKwsx
	 C2RCPbmapdK3Q==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	justin.iurman@uliege.be,
	David Lebrun <dlebrun@google.com>,
	Andrea Mayer <andrea.mayer@uniroma2.it>,
	Stefano Salsano <stefano.salsano@uniroma2.it>,
	Ahmed Abdelsalam <ahabdels.dev@gmail.com>,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net 3/7] net: ipv6: seg6: fix lwtunnel_input/output loop
Date: Tue, 11 Mar 2025 15:12:34 +0100
Message-Id: <20250311141238.19862-4-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250311141238.19862-1-justin.iurman@uliege.be>
References: <20250311141238.19862-1-justin.iurman@uliege.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the lwtunnel_input() and lwtunnel_output() reentry loop in
seg6_iptunnel when the destination is the same after transformation.
Some configurations leading to this may be considered pathological, but
we don't want the kernel to crash even for these ones. The logic in this
patch is a bit different from others of this series due to how we deal
with nf hooks.

Fixes: 6c8702c60b88 ("ipv6: sr: add support for SRH encapsulation and injection with lwtunnels")
Cc: David Lebrun <dlebrun@google.com>
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: Stefano Salsano <stefano.salsano@uniroma2.it>
Cc: Ahmed Abdelsalam <ahabdels.dev@gmail.com>
Cc: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
---
 net/ipv6/seg6_iptunnel.c | 37 +++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
index 51583461ae29..a6fce54acfbe 100644
--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -467,9 +467,16 @@ static int seg6_input_finish(struct net *net, struct sock *sk,
 	return dst_input(skb);
 }
 
+static int seg6_input_redirect_finish(struct net *net, struct sock *sk,
+				      struct sk_buff *skb)
+{
+	return skb_dst(skb)->lwtstate->orig_input(skb);
+}
+
 static int seg6_input_core(struct net *net, struct sock *sk,
 			   struct sk_buff *skb)
 {
+	int (*in_func)(struct net *net, struct sock *sk, struct sk_buff *skb);
 	struct dst_entry *orig_dst = skb_dst(skb);
 	struct dst_entry *dst = NULL;
 	struct lwtunnel_state *lwtst;
@@ -515,12 +522,20 @@ static int seg6_input_core(struct net *net, struct sock *sk,
 		skb_dst_set(skb, dst);
 	}
 
+	/* avoid lwtunnel_input() reentry loop when destination is the same
+	 * after transformation
+	 */
+	if (lwtst == dst->lwtstate)
+		in_func = seg6_input_redirect_finish;
+	else
+		in_func = seg6_input_finish;
+
 	if (static_branch_unlikely(&nf_hooks_lwtunnel_enabled))
 		return NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_OUT,
 			       dev_net(skb->dev), NULL, skb, NULL,
-			       skb_dst(skb)->dev, seg6_input_finish);
+			       skb_dst(skb)->dev, in_func);
 
-	return seg6_input_finish(dev_net(skb->dev), NULL, skb);
+	return in_func(dev_net(skb->dev), NULL, skb);
 drop:
 	kfree_skb(skb);
 	return err;
@@ -554,6 +569,7 @@ static int seg6_input(struct sk_buff *skb)
 static int seg6_output_core(struct net *net, struct sock *sk,
 			    struct sk_buff *skb)
 {
+	int (*out_func)(struct net *net, struct sock *sk, struct sk_buff *skb);
 	struct dst_entry *orig_dst = skb_dst(skb);
 	struct dst_entry *dst = NULL;
 	struct seg6_lwt *slwt;
@@ -598,14 +614,23 @@ static int seg6_output_core(struct net *net, struct sock *sk,
 			goto drop;
 	}
 
-	skb_dst_drop(skb);
-	skb_dst_set(skb, dst);
+	/* avoid lwtunnel_output() reentry loop when destination is the same
+	 * after transformation
+	 */
+	if (orig_dst->lwtstate == dst->lwtstate) {
+		dst_release(dst);
+		out_func = orig_dst->lwtstate->orig_output;
+	} else {
+		skb_dst_drop(skb);
+		skb_dst_set(skb, dst);
+		out_func = dst_output;
+	}
 
 	if (static_branch_unlikely(&nf_hooks_lwtunnel_enabled))
 		return NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_OUT, net, sk, skb,
-			       NULL, skb_dst(skb)->dev, dst_output);
+			       NULL, skb_dst(skb)->dev, out_func);
 
-	return dst_output(net, sk, skb);
+	return out_func(net, sk, skb);
 drop:
 	dst_release(dst);
 	kfree_skb(skb);
-- 
2.34.1


