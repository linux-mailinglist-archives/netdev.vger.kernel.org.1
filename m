Return-Path: <netdev+bounces-74999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 855F9867BFE
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 17:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54E2EB2E22A
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 15:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C254F12C7FA;
	Mon, 26 Feb 2024 15:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0x/DvWeg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1012112C807
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 15:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708962676; cv=none; b=GJOjQESCAG3hrxKtRpQdCCLe9AQKSXE+PwHlmaVFWc0gjjzkcisxVD75NDlTqFYI6g0BNo128yRoen8autMovABaoG63hvT/Vimfmt3JIymx0OueyQudl4Xlf8a47ac+zVrzJW3zTHX2pSbgjQzmUydXTo8d/HDSknOh4YNml3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708962676; c=relaxed/simple;
	bh=JNEi7SKD2sIULlUh+utOsfAxmAAjpXIOhERxlftrjL8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uVOKKkJZwhxQADbT53823J8va8aZMrrWd9BlU0VDFTj40kombyJfN6edf62bE3FFLJxuctv4bLmjRbGLXcu2NleNWktpquysw6pbwBiq6P/dzJYASAUSY4VfFFkEA2rJIAAyDQUPTzMpLmxjEpyywvC7bjkxiL4NAE5rNJbbiug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0x/DvWeg; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcd94cc48a1so4417648276.3
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 07:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708962674; x=1709567474; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=O/eCW1wd+IUcZzg7ImV6NfYoMyoWz8c9Of9U1FHqSb0=;
        b=0x/DvWega+Z9KZuBYBkpa/3jgtvIEvtraYVMa9u54s/7V0Y/jL0Ode9E1woG/iPPCk
         cZtf3FwKDhj8AL4eY7y+qK3UwjBPU0UqFQfegKvvIMjnrqXcNWPiOASa4TAXPpqdbfHs
         P9JU37EUpBdH7vpYSbuz7GKZ+UH702DenvQZePKoaXSg6qYaFA8WvoOHcT99X6AO/jfj
         l6Eu3/ZGSk7LGIi8yY9pTG5ZqyzPB/X5bQPL3+fiuhtQ+pQd9nbYZJFn8018w5oEJkop
         l5GIGxisKgvKQNhPFoasuSdTM7NwqO6WJXmq+BWriggK1cWOONcKkIFgv/O4Go9sl4Pe
         7tuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708962674; x=1709567474;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O/eCW1wd+IUcZzg7ImV6NfYoMyoWz8c9Of9U1FHqSb0=;
        b=VsFyygu6GjMXhh6E7K3EkinQ1arEuSOnf2gwXxytgbbxJCrYhqEmZkhHVeuT4PURmj
         vxG8Y2iZ1fAPS/Uk+kNN52Lv7Vq3+EpfDYIolM+4XE9JyTixafRqlUDce8XbVxyC3C84
         FWsO+mfjxtIHyUtPgJgyBRERvx9wEZ7mdZJCQ05ekoCuOll1bEDLmeOEr/VLgZTiNsGz
         XcRjraxtAVHj850t4LStq1YyHgmMhvxmHvE7wGTifvo9Thgz1ugrfw9UMmRyZW/dzXD6
         NqLpKoXVhiB5uxLtEGfaAv5Bc4fzkRxLLTNZrdfuO4/kSRSWOEM7tu1LMno0BNfZrut0
         tk/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUP/WRdrbu2zOyA9qBftxYAUkfM+ffq4rIXqwCWb3EPIsta7aaABUMEXCKGZO3p7JKLlVjc5l6WsqPTPD51jcTA9gzXgXF+
X-Gm-Message-State: AOJu0YxAJyojs7VKo79NNfXwRz/SHm7Yo4hBNWP2zw8T8d9qCgXUWUtY
	KqYrnP2AZh0rsX/9+cbivvEjPVOTVBLBC0R/FqjKy0yMIfenR6FBNquStM2vDQuCoFP0DHb/LGK
	xncfUNU5l/Q==
X-Google-Smtp-Source: AGHT+IGCubBW5mD9G6a88w3FVKUKnaOBWoh9azdx9l6CMBgt50qkzTQoqJhsSuCS/o6lmDwkvmweZccvtPag7Q==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:722:b0:dc7:48ce:d17f with SMTP
 id l2-20020a056902072200b00dc748ced17fmr2137096ybt.10.1708962674097; Mon, 26
 Feb 2024 07:51:14 -0800 (PST)
Date: Mon, 26 Feb 2024 15:50:48 +0000
In-Reply-To: <20240226155055.1141336-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240226155055.1141336-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240226155055.1141336-7-edumazet@google.com>
Subject: [PATCH net-next 06/13] ipv6: annotate data-races in ndisc_router_discovery()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Annotate reads from in6_dev->cnf.XXX fields, as they could
change concurrently.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/ndisc.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 1fb5e37bc78be54c71b49506e833a53edff3fa0e..f6430db249401b12debc0b174027af966fa71ccb 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1319,7 +1319,7 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
 	if (old_if_flags != in6_dev->if_flags)
 		send_ifinfo_notify = true;
 
-	if (!in6_dev->cnf.accept_ra_defrtr) {
+	if (!READ_ONCE(in6_dev->cnf.accept_ra_defrtr)) {
 		ND_PRINTK(2, info,
 			  "RA: %s, defrtr is false for dev: %s\n",
 			  __func__, skb->dev->name);
@@ -1327,7 +1327,8 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
 	}
 
 	lifetime = ntohs(ra_msg->icmph.icmp6_rt_lifetime);
-	if (lifetime != 0 && lifetime < in6_dev->cnf.accept_ra_min_lft) {
+	if (lifetime != 0 &&
+	    lifetime < READ_ONCE(in6_dev->cnf.accept_ra_min_lft)) {
 		ND_PRINTK(2, info,
 			  "RA: router lifetime (%ds) is too short: %s\n",
 			  lifetime, skb->dev->name);
@@ -1338,7 +1339,7 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
 	 * accept_ra_from_local is set to true.
 	 */
 	net = dev_net(in6_dev->dev);
-	if (!in6_dev->cnf.accept_ra_from_local &&
+	if (!READ_ONCE(in6_dev->cnf.accept_ra_from_local) &&
 	    ipv6_chk_addr(net, &ipv6_hdr(skb)->saddr, in6_dev->dev, 0)) {
 		ND_PRINTK(2, info,
 			  "RA from local address detected on dev: %s: default router ignored\n",
@@ -1350,7 +1351,7 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
 	pref = ra_msg->icmph.icmp6_router_pref;
 	/* 10b is handled as if it were 00b (medium) */
 	if (pref == ICMPV6_ROUTER_PREF_INVALID ||
-	    !in6_dev->cnf.accept_ra_rtr_pref)
+	    !READ_ONCE(in6_dev->cnf.accept_ra_rtr_pref))
 		pref = ICMPV6_ROUTER_PREF_MEDIUM;
 #endif
 	/* routes added from RAs do not use nexthop objects */
@@ -1421,10 +1422,12 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
 
 		spin_unlock_bh(&table->tb6_lock);
 	}
-	if (in6_dev->cnf.accept_ra_min_hop_limit < 256 &&
+	if (READ_ONCE(in6_dev->cnf.accept_ra_min_hop_limit) < 256 &&
 	    ra_msg->icmph.icmp6_hop_limit) {
-		if (in6_dev->cnf.accept_ra_min_hop_limit <= ra_msg->icmph.icmp6_hop_limit) {
-			WRITE_ONCE(in6_dev->cnf.hop_limit, ra_msg->icmph.icmp6_hop_limit);
+		if (READ_ONCE(in6_dev->cnf.accept_ra_min_hop_limit) <=
+		    ra_msg->icmph.icmp6_hop_limit) {
+			WRITE_ONCE(in6_dev->cnf.hop_limit,
+				   ra_msg->icmph.icmp6_hop_limit);
 			fib6_metric_set(rt, RTAX_HOPLIMIT,
 					ra_msg->icmph.icmp6_hop_limit);
 		} else {
@@ -1506,7 +1509,7 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
 	}
 
 #ifdef CONFIG_IPV6_ROUTE_INFO
-	if (!in6_dev->cnf.accept_ra_from_local &&
+	if (!READ_ONCE(in6_dev->cnf.accept_ra_from_local) &&
 	    ipv6_chk_addr(dev_net(in6_dev->dev), &ipv6_hdr(skb)->saddr,
 			  in6_dev->dev, 0)) {
 		ND_PRINTK(2, info,
@@ -1515,7 +1518,7 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
 		goto skip_routeinfo;
 	}
 
-	if (in6_dev->cnf.accept_ra_rtr_pref && ndopts.nd_opts_ri) {
+	if (READ_ONCE(in6_dev->cnf.accept_ra_rtr_pref) && ndopts.nd_opts_ri) {
 		struct nd_opt_hdr *p;
 		for (p = ndopts.nd_opts_ri;
 		     p;
@@ -1527,14 +1530,14 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
 				continue;
 #endif
 			if (ri->prefix_len == 0 &&
-			    !in6_dev->cnf.accept_ra_defrtr)
+			    !READ_ONCE(in6_dev->cnf.accept_ra_defrtr))
 				continue;
 			if (ri->lifetime != 0 &&
-			    ntohl(ri->lifetime) < in6_dev->cnf.accept_ra_min_lft)
+			    ntohl(ri->lifetime) < READ_ONCE(in6_dev->cnf.accept_ra_min_lft))
 				continue;
-			if (ri->prefix_len < in6_dev->cnf.accept_ra_rt_info_min_plen)
+			if (ri->prefix_len < READ_ONCE(in6_dev->cnf.accept_ra_rt_info_min_plen))
 				continue;
-			if (ri->prefix_len > in6_dev->cnf.accept_ra_rt_info_max_plen)
+			if (ri->prefix_len > READ_ONCE(in6_dev->cnf.accept_ra_rt_info_max_plen))
 				continue;
 			rt6_route_rcv(skb->dev, (u8 *)p, (p->nd_opt_len) << 3,
 				      &ipv6_hdr(skb)->saddr);
@@ -1554,7 +1557,7 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
 	}
 #endif
 
-	if (in6_dev->cnf.accept_ra_pinfo && ndopts.nd_opts_pi) {
+	if (READ_ONCE(in6_dev->cnf.accept_ra_pinfo) && ndopts.nd_opts_pi) {
 		struct nd_opt_hdr *p;
 		for (p = ndopts.nd_opts_pi;
 		     p;
@@ -1565,7 +1568,7 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
 		}
 	}
 
-	if (ndopts.nd_opts_mtu && in6_dev->cnf.accept_ra_mtu) {
+	if (ndopts.nd_opts_mtu && READ_ONCE(in6_dev->cnf.accept_ra_mtu)) {
 		__be32 n;
 		u32 mtu;
 
-- 
2.44.0.rc1.240.g4c46232300-goog


