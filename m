Return-Path: <netdev+bounces-222966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 013CCB574AF
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 11:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78B2E3AA8A9
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 09:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2402F362A;
	Mon, 15 Sep 2025 09:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5zyLZ43"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441752D3ECC
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 09:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757928013; cv=none; b=i8VDSgdpBx+/AIjXnxZ7nkGPwH6sxfbTmFCku08ny5Ds1Wr34f4s/cZgG1/WwSMSUD0YuiG9h/YClP222eFM+O+x8OWiIE+Wwc+v89qOwJzNV94wXnzpDjvDQsXBE7I7O2EJj4uwxvKYrP8aBx61xrWXDiPi/SawPKJf76niw6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757928013; c=relaxed/simple;
	bh=BRIqJLg2FM359TBM9nhtd+30YuKa4xfctM09sJtJjls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WxrKU4GiqNbJJDBXaAJkqXCb0+GYn735i6nOFfAUtnA3TR6pc/JgA8T39aN92/tJskZZNyf4C58FiD/X0kCpmrzxeyWXx9EP0StvXDR4+3tghYD0zkRSXcbiA9MH7hAdmMP/OCjSp9M+RQMVLhzFT5LGTtr5YUMuIoEYHVBmKsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5zyLZ43; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C33C4CEF1;
	Mon, 15 Sep 2025 09:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757928011;
	bh=BRIqJLg2FM359TBM9nhtd+30YuKa4xfctM09sJtJjls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P5zyLZ43jzGXnhiH4BgEvI08ky8M5NUiO4uqy2VQemF3J7zDAgAOLKbJByjp6Crn7
	 I8G0o52suoVwgmPzfZ2LQHiZOyYbPQNZFWyawwMq0GnpIRx5rRiLoY9gbKihiqESkG
	 BT5WhEGALO38ZtaV2Um+d/YGu/6Ps2xqdVezV4EA1TyhBEXDcO3LmJ3ycnvNJt54LV
	 0zBxV7Jb3x3JrpGGJ/fRvUePzTJte/iXEp4VhvPAQfjs7jr0rBqeI6+lFsRAfDifkD
	 HqNpmYodWbZQuR75Aosi/1IZlIEKjdXLjw5dsKyb76CSiRoJU30jDK53gnZHiZJvce
	 cUr2PGFpX5KsQ==
From: Antoine Tenart <atenart@kernel.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: Antoine Tenart <atenart@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH net-next 3/3] net: ipv4: convert ip_rcv_options to drop reasons
Date: Mon, 15 Sep 2025 11:19:56 +0200
Message-ID: <20250915091958.15382-4-atenart@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915091958.15382-1-atenart@kernel.org>
References: <20250915091958.15382-1-atenart@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This converts the only path not returning drop reasons in
ip_rcv_finish_core.

Signed-off-by: Antoine Tenart <atenart@kernel.org>
---
 net/ipv4/ip_input.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
index 93b8286e526a..273578579a6b 100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -263,10 +263,11 @@ int ip_local_deliver(struct sk_buff *skb)
 }
 EXPORT_SYMBOL(ip_local_deliver);
 
-static inline bool ip_rcv_options(struct sk_buff *skb, struct net_device *dev)
+static inline enum skb_drop_reason
+ip_rcv_options(struct sk_buff *skb, struct net_device *dev)
 {
-	struct ip_options *opt;
 	const struct iphdr *iph;
+	struct ip_options *opt;
 
 	/* It looks as overkill, because not all
 	   IP options require packet mangling.
@@ -277,7 +278,7 @@ static inline bool ip_rcv_options(struct sk_buff *skb, struct net_device *dev)
 	*/
 	if (skb_cow(skb, skb_headroom(skb))) {
 		__IP_INC_STATS(dev_net(dev), IPSTATS_MIB_INDISCARDS);
-		goto drop;
+		return SKB_DROP_REASON_NOMEM;
 	}
 
 	iph = ip_hdr(skb);
@@ -286,7 +287,7 @@ static inline bool ip_rcv_options(struct sk_buff *skb, struct net_device *dev)
 
 	if (ip_options_compile(dev_net(dev), opt, skb)) {
 		__IP_INC_STATS(dev_net(dev), IPSTATS_MIB_INHDRERRORS);
-		goto drop;
+		return SKB_DROP_REASON_IP_INHDR;
 	}
 
 	if (unlikely(opt->srr)) {
@@ -298,17 +299,15 @@ static inline bool ip_rcv_options(struct sk_buff *skb, struct net_device *dev)
 					net_info_ratelimited("source route option %pI4 -> %pI4\n",
 							     &iph->saddr,
 							     &iph->daddr);
-				goto drop;
+				return SKB_DROP_REASON_NOT_SPECIFIED;
 			}
 		}
 
 		if (ip_options_rcv_srr(skb, dev))
-			goto drop;
+			return SKB_DROP_REASON_NOT_SPECIFIED;
 	}
 
-	return false;
-drop:
-	return true;
+	return SKB_NOT_DROPPED_YET;
 }
 
 static bool ip_can_use_hint(const struct sk_buff *skb, const struct iphdr *iph,
@@ -388,9 +387,10 @@ static int ip_rcv_finish_core(struct net *net,
 	}
 #endif
 
-	if (iph->ihl > 5 && ip_rcv_options(skb, dev)) {
-		drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
-		goto drop;
+	if (iph->ihl > 5) {
+		drop_reason = ip_rcv_options(skb, dev);
+		if (drop_reason)
+			goto drop;
 	}
 
 	rt = skb_rtable(skb);
-- 
2.51.0


