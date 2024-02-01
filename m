Return-Path: <netdev+bounces-67871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E46845293
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 09:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79F491C213F0
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 08:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE0D159576;
	Thu,  1 Feb 2024 08:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZQI0aam"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC47D158D85
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 08:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706775631; cv=none; b=ej2qFdiDGpZ0+sdIBzgOy8erCBrVa0CfqMYSnsLPUHFlAKKB/OG24iSjpGINusp0FZWGFBJa4aDjqYXP4+yTg9Ltx/yxX1O+HugivfG4vtZcmv5646+ocCOUFFZ/Pr7Q8o4UBvHpVRBMkudRh7+G/GAussCc8AN0580zw2s4Wsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706775631; c=relaxed/simple;
	bh=9Q7dIWO/up+Z+zGT7zjSYYeM+tBMW5qlYmi941jKS2A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Se3myD2TXei3DIDUnon6A2Sc/H8ID84xga1WgLO4nlcgNQLh6aJFJoRCmr53wbO6WIwIKJ1+ZHYezAQCQ0QFOhrmZ02FEl36P4CoCWIxMQy20wU02mFOo8hkXi6aMMD9MrXdcLC3fYn1YV5MllA1xeHUdE7HGYQw6hZesEj+Bno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZQI0aam; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-60410da20a2so6221027b3.1
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 00:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706775628; x=1707380428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPABcs344aIEO6XlzzqYh/8aI4dOCp92Q8NZDEsORFE=;
        b=MZQI0aam6EbKWUw87fdn8a6gkgF8fueQzlmhK8zDPBLwBT7DHnJUT0s3O+94rzIQsN
         DCyfLRnw2BezgEWMsad7kYzK7Vjz8GZF33z/8pWR7iEGQEGdFwHaa1uAn7d8R5K7oCZs
         vECRu/Azw32PUYVusd4W0bnTk44ViXNWZgxV/X+J25YB449n5fDgEDjLoRlfCML8UG6t
         X520LQL44K0btDHxvDSfTe4Ai0xIWZ3S3ckcUG/6dVsrdOTDx9ix17tDDgyT3hU1FWex
         gXzug1yOJ5yUztvmOGpyFqpeMyzukO3WeXLsWPZpbxa3plXHS9lgm7xFN6Knyze5dS5T
         2pHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706775628; x=1707380428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nPABcs344aIEO6XlzzqYh/8aI4dOCp92Q8NZDEsORFE=;
        b=pyXkAx0+rAXPxA0dWWFGxfdFXjDmRi7M6LXrqWT3QiLYSzrGTVzSrylXwCo4yc/NuN
         VCj1Oyabj5NNyConhb+2HGzKjw/4aG9wDDqVQZYQqmbarLKRDZBTzm/fsVJvhm32XE9a
         g0bNbqwrXu8kk+Sd1wctpUkUW2EAPfjAjiUd9g6/W+3wgk8FsPpOG2ANYqTP1fQyvfGE
         8y6JpLyor3Fiz3TO2gEjDNQLjmSIOCX3f5wHhmfL3T01NavwGzsIFuRIlk/ysew7bOrO
         oU+LNV9xUfrRrZPKy+LKd/KiwoHk/EamsHwRBK+2xql/xyxg5+C6tSYPUKNj8fQBTkDu
         4fng==
X-Gm-Message-State: AOJu0YwHGwk4dvvi4RHJ2ZBwEAIzaOV0mxqj/B0HOOLw8nwiXqh6fabu
	pfo6ZSPzABEQWohMijI57PpRG/XyD+N2mtZAOOuRu1fP37Yzl61t8AMOQpUlAA0=
X-Google-Smtp-Source: AGHT+IEcq/RocWCNxeO3/03eb8q9EqrBfVN7sOJgDgX31OQ13oK3BM95OMWrtTkiKdjY+eZr5I4K4A==
X-Received: by 2002:a0d:ea4a:0:b0:5f0:4e4e:1b11 with SMTP id t71-20020a0dea4a000000b005f04e4e1b11mr3735523ywe.29.1706775628532;
        Thu, 01 Feb 2024 00:20:28 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:b616:d09e:9171:5ef4])
        by smtp.gmail.com with ESMTPSA id w186-20020a0dd4c3000000b006041ca620f4sm209090ywd.81.2024.02.01.00.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 00:20:28 -0800 (PST)
From: thinker.li@gmail.com
To: netdev@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	liuhangbin@gmail.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH net-next v2 1/5] net/ipv6: set expires in rt6_add_dflt_router().
Date: Thu,  1 Feb 2024 00:20:20 -0800
Message-Id: <20240201082024.1018011-2-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201082024.1018011-1-thinker.li@gmail.com>
References: <20240201082024.1018011-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

Pass the duration of a lifetime (in seconds) to the function
rt6_add_dflt_router() so that it can properly set the expiration time.

The function ndisc_router_discovery() is the only one that calls
rt6_add_dflt_router(), and it will later set the expiration time for the
route created by rt6_add_dflt_router(). However, there is a gap of time
between calling rt6_add_dflt_router() and setting the expiration time in
ndisc_router_discovery(). During this period, there is a possibility that a
new route may be removed from the routing table. By setting the correct
expiration time in rt6_add_dflt_router(), we can prevent this from
happening. The reason for setting RTF_EXPIRES in rt6_add_dflt_router() is
to start the Garbage Collection (GC) timer, as it only activates when a
route with RTF_EXPIRES is added to a table.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/net/ip6_route.h | 3 ++-
 net/ipv6/ndisc.c        | 3 ++-
 net/ipv6/route.c        | 4 +++-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
index 28b065790261..52a51c69aa9d 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -170,7 +170,8 @@ struct fib6_info *rt6_get_dflt_router(struct net *net,
 struct fib6_info *rt6_add_dflt_router(struct net *net,
 				     const struct in6_addr *gwaddr,
 				     struct net_device *dev, unsigned int pref,
-				     u32 defrtr_usr_metric);
+				     u32 defrtr_usr_metric,
+				     int lifetime);
 
 void rt6_purge_dflt_routers(struct net *net);
 
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index a19999b30bc0..a68462668158 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1382,7 +1382,8 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
 			neigh_release(neigh);
 
 		rt = rt6_add_dflt_router(net, &ipv6_hdr(skb)->saddr,
-					 skb->dev, pref, defrtr_usr_metric);
+					 skb->dev, pref, defrtr_usr_metric,
+					 lifetime);
 		if (!rt) {
 			ND_PRINTK(0, err,
 				  "RA: %s failed to add default route\n",
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 63b4c6056582..98abba8f15cd 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -4355,7 +4355,8 @@ struct fib6_info *rt6_add_dflt_router(struct net *net,
 				     const struct in6_addr *gwaddr,
 				     struct net_device *dev,
 				     unsigned int pref,
-				     u32 defrtr_usr_metric)
+				     u32 defrtr_usr_metric,
+				     int lifetime)
 {
 	struct fib6_config cfg = {
 		.fc_table	= l3mdev_fib_table(dev) ? : RT6_TABLE_DFLT,
@@ -4368,6 +4369,7 @@ struct fib6_info *rt6_add_dflt_router(struct net *net,
 		.fc_nlinfo.portid = 0,
 		.fc_nlinfo.nlh = NULL,
 		.fc_nlinfo.nl_net = net,
+		.fc_expires = jiffies_to_clock_t(lifetime * HZ),
 	};
 
 	cfg.fc_gateway = *gwaddr;
-- 
2.34.1


