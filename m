Return-Path: <netdev+bounces-224288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64287B83863
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 10:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 817AC3B2FC4
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 08:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D175D2F83C4;
	Thu, 18 Sep 2025 08:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qR5Ej+Ix"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1172F83C3
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 08:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758184298; cv=none; b=p59cewRxayG8QiU3E2mhdFVV2qZ9thGsEnspUC5BcrAvvE3ncsoGAKC/D2Juj0QwN9psa0N1N0dhR+07CAtp029CZTwc+3SxAC+vKCgq2Sg1Nt7lUqaJFuckJsrVSHAQh/bvWsZsA+T108rzPjAWSDo4YT+6+LMAWs8JrJIANNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758184298; c=relaxed/simple;
	bh=OG51gZ9FT3Yft/f9V80kYaqN15PmBJ964yzj/asMkOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J6xK9iYuwMlv96PF1kKDQ/jbNynTPLl+6woaBD64dUTK58hUs1YkRcye7tZCStV0R39nbYIoKc/IaIIgZNiM9dvETYU69jdOYVs6DQomnbnOkfJhnAu264RTO8R8HXnOt+lcwkEPtlzR8Pn9UrM/JCZLXv4S8oB6tK6LRQlwbkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qR5Ej+Ix; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2B5EC4CEE7;
	Thu, 18 Sep 2025 08:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758184298;
	bh=OG51gZ9FT3Yft/f9V80kYaqN15PmBJ964yzj/asMkOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qR5Ej+IxrUFu7i/Z1TVZ40FoEm8DpHS3QVjaq4HAaxP9BvSFuU/TioP/KhR1acCV1
	 mQa++haiiouhv3OJ3kYaIbCwaNj8SAafRfI/9o0F875xtK054/1rzO6qvid941hlF5
	 HD0pbO8viNzRP1hjJ8XKAzcKwhXrtWoHOzbRC4Loln5a5Fo56xXpSW5hxOJ3zQiLlQ
	 Rlk8pFnkdOM0bA0wV09ohrwnsZYp95BQyugK8yaXyiCL/mYbl7MAnIm8CUoBWSFUqs
	 jxAfeKL5v4HbDRvQhiD8l07M2Q6xnWAsoIQ5A3KOCDzBAYvlpoXmTkq3ByGTkRkhSR
	 mI2bd+g4Vr9ow==
From: Antoine Tenart <atenart@kernel.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	dsahern@kernel.org
Cc: Antoine Tenart <atenart@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 2/4] net: ipv4: simplify drop reason handling in ip_rcv_finish_core
Date: Thu, 18 Sep 2025 10:31:15 +0200
Message-ID: <20250918083127.41147-3-atenart@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250918083127.41147-1-atenart@kernel.org>
References: <20250918083127.41147-1-atenart@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of setting the drop reason to SKB_DROP_REASON_NOT_SPECIFIED
early and having to reset it each time it is overridden by a function
returned value, just set the drop reason to the expected value before
returning from ip_rcv_finish_core.

Signed-off-by: Antoine Tenart <atenart@kernel.org>
---
 net/ipv4/ip_input.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
index 8878e865ddf6..93b8286e526a 100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -335,7 +335,6 @@ static int ip_rcv_finish_core(struct net *net,
 			goto drop_error;
 	}
 
-	drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	if (READ_ONCE(net->ipv4.sysctl_ip_early_demux) &&
 	    !skb_dst(skb) &&
 	    !skb->sk &&
@@ -354,7 +353,6 @@ static int ip_rcv_finish_core(struct net *net,
 				drop_reason = udp_v4_early_demux(skb);
 				if (unlikely(drop_reason))
 					goto drop_error;
-				drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
 
 				/* must reload iph, skb->head might have changed */
 				iph = ip_hdr(skb);
@@ -372,7 +370,6 @@ static int ip_rcv_finish_core(struct net *net,
 						   ip4h_dscp(iph), dev);
 		if (unlikely(drop_reason))
 			goto drop_error;
-		drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	} else {
 		struct in_device *in_dev = __in_dev_get_rcu(dev);
 
@@ -391,8 +388,10 @@ static int ip_rcv_finish_core(struct net *net,
 	}
 #endif
 
-	if (iph->ihl > 5 && ip_rcv_options(skb, dev))
+	if (iph->ihl > 5 && ip_rcv_options(skb, dev)) {
+		drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
 		goto drop;
+	}
 
 	rt = skb_rtable(skb);
 	if (rt->rt_type == RTN_MULTICAST) {
-- 
2.51.0


