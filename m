Return-Path: <netdev+bounces-109522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FD7928AEB
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 16:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 324621F21D86
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 14:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6223116B397;
	Fri,  5 Jul 2024 14:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="bY6A1wAo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f100.google.com (mail-wr1-f100.google.com [209.85.221.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D291BC43
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 14:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720191187; cv=none; b=Bx4u+S4yltIIwzkWqBp2qpN08HPjF4dPfi2pOs4WyPrAPEJ7rOejyVVG0OJnXVMk6aBYilcWd1KJX/BDHw/YNiVfYh0Y75DFT7T7RPmq4Qu9Sl/Tk3XXpjLBtsvvA33VShdUKh1Y0woDyKcZDvyg8RVjm8WqH9hm066vgo94XWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720191187; c=relaxed/simple;
	bh=KPuaZpd8ZJ0HSSdikT2sPrbPLojsEUP1W+x8ZsaZVHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZfBHbrqj7B8j3vxpHwUFxXPYjlIkuxmywKz0SVu1fJZvuVJCg3/txMcvdB4W40qvIrF6XX+SkCO7rWXjT7A6JuNYX9u22U4uCZiB/YUDSncRz440Spi4IO0V1DRcMaHKF5mZo8OgGE1qRe5fzjIdFcKtVSBsfdnmO9E5cJagLbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=bY6A1wAo; arc=none smtp.client-ip=209.85.221.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f100.google.com with SMTP id ffacd0b85a97d-3679e9bfb08so1005923f8f.1
        for <netdev@vger.kernel.org>; Fri, 05 Jul 2024 07:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1720191184; x=1720795984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Na5Lj3E4Abq+eDT2imOsy9+2Ynrb8boxONyEAkQz6mk=;
        b=bY6A1wAo5vLsFbn95r/9R1wvPPq7sYY/0uea+O3RrGOEXTVFKPslp4hZmZMqhickKP
         tTG0d/pBwU2N6bpE4WmJ6qjI2npS68YbwR8ywiwiE0VOpXZma8xKzOQCh/nuxRHlY79e
         nJd5xNaTYhXh9eGN2QHzX+2txTJET1DsURFMKqhQEB2owslPFUdZqPbTV2EeVy7HDSTJ
         2eY2gkTnvSCkOWGF7z90/0y4MElW9Kds1ZejpFc0IHPCGqSoqcylbP8kC6+3JfqDmlB/
         1ek0T03VdUXv8ym8nZhH83iIk/tn65GbzPOhfkZ1ybU5UYYbp6PO4yD9XGh/8+JpYlCo
         NLAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720191184; x=1720795984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Na5Lj3E4Abq+eDT2imOsy9+2Ynrb8boxONyEAkQz6mk=;
        b=l5RiDL8yXFML9orklLPI/Bo8FCqFXnAdLKQJHZYvvFPoqDkTRegCpUFWI/1r5yDrcK
         pNpBwKhmVlUYaxlp58k73UWXxltH0m6NvXnkWpKNKUCz4p9LEIav0NNeY6eVQcl7vTjF
         Z5oaX5ns7FrHcMoGXVKuRZ7HigyMxBIdqjkUWCCLCz9/LB5vsyt8IwnY4lEAF2IsKMfR
         DiX1RI/G67U0wSfoBmX8KhQQmgZoXh2d787zItputRll2YLjFBGA4buETt8JHhsii2MA
         0ww96KrsCyztZzfQ/5rjkqoUik0p6xOp4tGzjPA+pxfgJ70OcgCMKODHKdBCyWkVqp29
         xwFQ==
X-Forwarded-Encrypted: i=1; AJvYcCURWfmH294ed+HF2kCUvVssOO4cFF4/XU6CzgecKfbWiLQjz42lK3B54buBoW+YVRidiKu5r6rlJEeUhBqTdmEb/qhx8IiB
X-Gm-Message-State: AOJu0YxmryRwWzlE7eTOK8D16YplsfcA0pcFth7GckkTiVPNWlhYxszp
	Qj0aU0jQyXyIQD+XurhSEBVYiYZehG0oQTAkccEI5x1IQzCW3QFJhDaJm8eHosGt9cuJh9sPcmr
	htrE6IQO4DfOPUp2rPpSdxtCkWV4JiVrS
X-Google-Smtp-Source: AGHT+IG3rWEKH598/OdyXI4YCQApiejblsEBfLU4wMmifT2aA56lwMgBrxtwOCBYzRKpeblPHwK0ouqyK12Y
X-Received: by 2002:adf:f9cf:0:b0:366:ea4a:17ec with SMTP id ffacd0b85a97d-3679f6c5b81mr4981583f8f.2.1720191184145;
        Fri, 05 Jul 2024 07:53:04 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 5b1f17b1804b1-4264a1d60afsm1377375e9.4.2024.07.05.07.53.03;
        Fri, 05 Jul 2024 07:53:04 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id D264F603EF;
	Fri,  5 Jul 2024 16:53:03 +0200 (CEST)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1sPkJ5-007Cqj-Hi; Fri, 05 Jul 2024 16:53:03 +0200
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 2/4] ipv6: fix source address selection with route leak
Date: Fri,  5 Jul 2024 16:52:13 +0200
Message-ID: <20240705145302.1717632-3-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240705145302.1717632-1-nicolas.dichtel@6wind.com>
References: <20240705145302.1717632-1-nicolas.dichtel@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By default, an address assigned to the output interface is selected when
the source address is not specified. This is problematic when a route,
configured in a vrf, uses an interface from another vrf (aka route leak).
The original vrf does not own the selected source address.

Let's add a check against the output interface and call the appropriate
function to select the source address.

CC: stable@vger.kernel.org
Fixes: 0d240e7811c4 ("net: vrf: Implement get_saddr for IPv6")
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 include/net/ip6_route.h | 19 ++++++++++++-------
 net/ipv6/ip6_output.c   |  1 +
 net/ipv6/route.c        |  2 +-
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
index a18ed24fed94..a7c27f0c6bce 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -127,18 +127,23 @@ void rt6_age_exceptions(struct fib6_info *f6i, struct fib6_gc_args *gc_args,
 
 static inline int ip6_route_get_saddr(struct net *net, struct fib6_info *f6i,
 				      const struct in6_addr *daddr,
-				      unsigned int prefs,
+				      unsigned int prefs, int l3mdev_index,
 				      struct in6_addr *saddr)
 {
+	struct net_device *l3mdev;
+	struct net_device *dev;
+	bool same_vrf;
 	int err = 0;
 
-	if (f6i && f6i->fib6_prefsrc.plen) {
+	rcu_read_lock();
+	l3mdev = dev_get_by_index_rcu(net, l3mdev_index);
+	dev = f6i ? fib6_info_nh_dev(f6i) : NULL;
+	same_vrf = l3mdev == NULL || l3mdev_master_dev_rcu(dev) == l3mdev;
+	if (f6i && f6i->fib6_prefsrc.plen && same_vrf)
 		*saddr = f6i->fib6_prefsrc.addr;
-	} else {
-		struct net_device *dev = f6i ? fib6_info_nh_dev(f6i) : NULL;
-
-		err = ipv6_dev_get_saddr(net, dev, daddr, prefs, saddr);
-	}
+	else
+		err = ipv6_dev_get_saddr(net, same_vrf ? dev : l3mdev, daddr, prefs, saddr);
+	rcu_read_unlock();
 
 	return err;
 }
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 27d8725445e3..784424ac4147 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1124,6 +1124,7 @@ static int ip6_dst_lookup_tail(struct net *net, const struct sock *sk,
 		from = rt ? rcu_dereference(rt->from) : NULL;
 		err = ip6_route_get_saddr(net, from, &fl6->daddr,
 					  sk ? READ_ONCE(inet6_sk(sk)->srcprefs) : 0,
+					  fl6->flowi6_l3mdev,
 					  &fl6->saddr);
 		rcu_read_unlock();
 
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 8d72ca0b086d..c9a9506b714d 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -5689,7 +5689,7 @@ static int rt6_fill_node(struct net *net, struct sk_buff *skb,
 				goto nla_put_failure;
 	} else if (dest) {
 		struct in6_addr saddr_buf;
-		if (ip6_route_get_saddr(net, rt, dest, 0, &saddr_buf) == 0 &&
+		if (ip6_route_get_saddr(net, rt, dest, 0, 0, &saddr_buf) == 0 &&
 		    nla_put_in6_addr(skb, RTA_PREFSRC, &saddr_buf))
 			goto nla_put_failure;
 	}
-- 
2.43.1


