Return-Path: <netdev+bounces-69963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC9A84D23C
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 20:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 502C6B22DAA
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 19:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DA885C49;
	Wed,  7 Feb 2024 19:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HiGb8QGe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76381E514
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 19:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707334185; cv=none; b=KMVC9Z9MDLPvroEQEZqrrL9ElvmGLSgUyNib3Rh7e3sMkkQEe8EF/717Qr/fDs3FyLVTwcBnDhko9k5xcfsmcJqaf7OiZbMFRj1t1Zodppin/RWl/W6pdhxtz6llQCqqjgVbDTwp/7gzZ8PLqtDNjHW9E6vUgcQGnBxMIPBnUrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707334185; c=relaxed/simple;
	bh=4tSVrc3lDD9aUoYxlltfLeAwJNFQSEcmRZdoZavUtrI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lpLisYtLvJWzbo2qRUwP22uq+ZwkTaGOtCfysMSYBxnDuMT3ILz2Fd9/m/DPvpNqs5X0WpR+6yUVhQJyqIPCCbBTE5Km84WobIXK424hei+vniluMJ+FGrYd7Yi5ro5QpIyYxuCCgRnot9MZyHNPkVfN0VycbOHsu97w+rjLT2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HiGb8QGe; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-604a05e26c3so3393857b3.3
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 11:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707334182; x=1707938982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g8gr/KnM/VeL15b3iiujnM+2BUtml3tCCqm7xonJUZI=;
        b=HiGb8QGebrQL0dGJmAA5PS5Q9cd2EyvtkXdUhcB5tziRIoLL4WtcaA+xa4rrP+Di9A
         FHoTsisHOnL0U/IeHBLx2IpkTZvNx1Ks/ar66r6EoTJ04gQyDNqLu4ElY9BOcOKAJe8P
         uNa7jZ6nRVZdT2nIh8ieO/47vSF+CfncA558q/fy4nouW2sg9BfgGLXXd9ME2xJs+o46
         OdDCZlTVeWSqBlQX4R+w2k2+nz2irAY1P0h+j6E4NvXTMw3uyeQKg1ufsCWNP3D/04PH
         oWsmG1F5ej7dqgaoLoefm0NDjZf5odjcpY0FdppDkjfph103EYteW6jw3fL/mAXDcWeG
         qQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707334182; x=1707938982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g8gr/KnM/VeL15b3iiujnM+2BUtml3tCCqm7xonJUZI=;
        b=XZzS2n1QCobIDvth4HunK8/WGJUUvrcfelflEODVLuieztkpoUR3C8eaPYgnv7BAMJ
         /yp7NU5gHhry7MCLhgRpR6tescKxNIvc78Q/hJo2tvzIK24S/jLWZEHwJ7An1UaxPUfF
         v5zl5UH367ttpLKwtLb1DIgL2hrDJA8f0F8Og8p82e2aa9Pmc5HX02sFDnmKHOaedgcN
         FfUGFwBlyaN203kTmmgM0LKtBC/9nlr1zNnQme6HUBEF9IX/KgFu7KtGIVkGDhWMxt2n
         7DbJRuTESwI0O7RnvhvUAw2Vd2igimjR10amhIQJIP7mKHtlExYeRtJEUAFwLmk/RBTi
         yfHg==
X-Gm-Message-State: AOJu0YxCOgxWLC6k6DfCcX4LDol7wZT/SoOAaoA7kMFHgPU3QLeVxuAy
	ZBgdm47X6BWRPHQyo/izkZmZB54ZPax95BrY6lPmJwQBMmIYmhZaSy2pHuuK
X-Google-Smtp-Source: AGHT+IEBTK0CDpkXFnw67b9Ub5KCuvpWWwPirWHpk9VyUqk5PYjmDS3FHIUocNrbpg+upreUy5Aj9g==
X-Received: by 2002:a0d:ec43:0:b0:604:99a:141 with SMTP id r3-20020a0dec43000000b00604099a0141mr5113568ywn.51.1707334182047;
        Wed, 07 Feb 2024 11:29:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXYGPyRT7p3FBDXQqm3R6waf8MAngy/ZPufcjJUSjZ6ycoI7nLmvBIjQTCMPNKuOH3o94ALRQcheS5zpSf249Tby2avDbAJnGJ+Lp3ub9dKDvc3WI95U4T0mti9VXxk8/GV79/wIq9WmuMYTI3BVJDE1lkXTrjorvZF2hUcTGttKfBEoGszpL2hufQEcG2yzPDCrb2wzBvsZWMw+4Qtm5K4vi8OWAGvncLad+jxd5mqKqMasRd+PF8RRs7n/t3KIGvTXpXX6RzmYCy0Jab2tcwcdplJuqZR1EZq3u7qkri37JUQmHM23vXP+/e72u59czWsdB2GQLFADepV3XcbuDpIwO49FBLhYab66w==
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:50ba:b8f8:e3dd:4d24])
        by smtp.gmail.com with ESMTPSA id cn33-20020a05690c0d2100b006040cbbe952sm380088ywb.89.2024.02.07.11.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 11:29:41 -0800 (PST)
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
Subject: [PATCH net-next v5 1/5] net/ipv6: set expires in rt6_add_dflt_router().
Date: Wed,  7 Feb 2024 11:29:29 -0800
Message-Id: <20240207192933.441744-2-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240207192933.441744-1-thinker.li@gmail.com>
References: <20240207192933.441744-1-thinker.li@gmail.com>
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

Suggested-by: David Ahern <dsahern@kernel.org>
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
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


