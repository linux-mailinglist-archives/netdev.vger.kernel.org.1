Return-Path: <netdev+bounces-100687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 566388FB988
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 18:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F2F91C21508
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 16:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4340814883B;
	Tue,  4 Jun 2024 16:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SKdfkJG0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AB9149009
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 16:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717519915; cv=none; b=YcmmxrlNd1qtWYDYV6JTLLaQcFN8MLgGmVUxevdF3O8H5Wfjwm3jxZRUeRm03SiOy3cwZY4qH7zcxvgkaLnNqDlqpiwnu2Y99rO6iHiOWGbVrH2Jei4IDs53NlZ01ngG+9MJq+U71In0ncuNCCcTE+/AO29JUuDOpwHRJvwojtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717519915; c=relaxed/simple;
	bh=SkTIiVAjvg4PPoe1ns9ndbfJeJuVPlELgie1jOTkmr4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gIobVALHaFRFhusNDdWu/b+89QDhk/JKRj6W+yI8rBND7fZw7g1vxKrfagQQlrMnFtHL0CkUu83EnsBRER4O23fHp0Q2d35GUur45fzTvhEM/qIQOxdELaeaGqu2c2mjJTiqaikO26TkrFDyILUlbxQzV6PeHit6hmEvgDvbU54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SKdfkJG0; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dfab38b7f6bso2383613276.0
        for <netdev@vger.kernel.org>; Tue, 04 Jun 2024 09:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717519912; x=1718124712; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HAW5uMfok/6u/dUItmKRpn6Vj98nQYeSb+rNIdyrzQQ=;
        b=SKdfkJG08tx7nNcTU8R+wL3iH9oYqfgGJNgyx2K90yx8MH23Oy+/8QGAME7A3aKaUl
         ZKa+dN3Ep2hOVwarrFVlvv6WWtaARPXRUj5DrljXEv7UFOUpMLC2c38WG2Jzm9wwu3+0
         +IGC0bjNIho8CfJAeI1HljxjWV9yjLi6paTUcPKj/Yxj7kcjkVG/Dc2/jEaG9ZEgdqRa
         0IkkH1QXA2cS7G9oZ+gVktKb2xy1gcXItd/cvdfYeBoixuJe6NLbqfuYJNjNnSbJHK6k
         SVQVcM8Put2x/EX+IQdO8TuJcCArnM3x5261fCUSPF9gava0iPPvDH2Z4MU3SS2e6fub
         2vgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717519912; x=1718124712;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HAW5uMfok/6u/dUItmKRpn6Vj98nQYeSb+rNIdyrzQQ=;
        b=ECgYTcGgq8tFEwv8i/DaBUGI6cn2b9aVYKCju1l7OzIG2TkyCFmkxY/glqISy/TgGt
         say7qOurL/FMs3hOsVBicFOPaJtR+LchgfH4XiREqzNQzUcki7/n/gWn5xr5UUfSNZA+
         1KgPV9/NVDD52hucoO8Bpn0NW/AJF+r9ok5icce70YHEAthX6HXLm0YwBn+SEReogzIZ
         nWngSCxo57sM419+UbqE1aor/uqntzBaLit9Y0hpBKEOSp0opBD7WM3+PsexkS9W5aTQ
         NsCNtkcEmcC03enO9QG7q/10hIslJWyhJ8508LMTpMU59Wj1rUNNWfC83kYcmz3Fk1PO
         0Qlw==
X-Gm-Message-State: AOJu0YxBM8zfbjF6RQPk3UdM1iq+th8g69IQO048/72UWw/Va8UEVDSa
	/1baCeW5UHzCAft7rHPnWskdCL4yOgdNDShijIo2jHOPV42BH5WbWYyd7870HovG1sxlFN9W050
	jPH9XQ9iAMA==
X-Google-Smtp-Source: AGHT+IEpSVe8OLzuCQbUAV5V+HUMQDvyX1UvQSM4t31xJAzvW5wZcWDiC9+RMDWRetmVNV63hOMUeIA0P+NXXQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:20c4:b0:df7:6206:4bd6 with SMTP
 id 3f1490d57ef6-dfa73bbc864mr3417275276.2.1717519912675; Tue, 04 Jun 2024
 09:51:52 -0700 (PDT)
Date: Tue,  4 Jun 2024 16:51:50 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240604165150.726382-1-edumazet@google.com>
Subject: [PATCH net-next] inet: remove (struct uncached_list)->quarantine
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This list is used to tranfert dst that are handled by
rt_flush_dev() and rt6_uncached_list_flush_dev() out
of the per-cpu lists.

But quarantine list is not used later.

If we simply use list_del_init(&rt->dst.rt_uncached),
this also removes the dst from per-cpu list.

This patch also makes the future calls to rt_del_uncached_list()
and rt6_uncached_list_del() faster, because no spinlock
acquisition is needed anymore.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/route.c | 4 +---
 net/ipv6/route.c | 5 +----
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index b3073d1c8f8f71c88dc525eefb2b03be8f1f2945..cb0bdf34ed50c92688a3c0fe14c3e0c06d78b47c 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1481,7 +1481,6 @@ static bool rt_cache_route(struct fib_nh_common *nhc, struct rtable *rt)
 struct uncached_list {
 	spinlock_t		lock;
 	struct list_head	head;
-	struct list_head	quarantine;
 };
 
 static DEFINE_PER_CPU_ALIGNED(struct uncached_list, rt_uncached_list);
@@ -1532,7 +1531,7 @@ void rt_flush_dev(struct net_device *dev)
 			rt->dst.dev = blackhole_netdev;
 			netdev_ref_replace(dev, blackhole_netdev,
 					   &rt->dst.dev_tracker, GFP_ATOMIC);
-			list_move(&rt->dst.rt_uncached, &ul->quarantine);
+			list_del_init(&rt->dst.rt_uncached);
 		}
 		spin_unlock_bh(&ul->lock);
 	}
@@ -3661,7 +3660,6 @@ int __init ip_rt_init(void)
 		struct uncached_list *ul = &per_cpu(rt_uncached_list, cpu);
 
 		INIT_LIST_HEAD(&ul->head);
-		INIT_LIST_HEAD(&ul->quarantine);
 		spin_lock_init(&ul->lock);
 	}
 #ifdef CONFIG_IP_ROUTE_CLASSID
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index a504b88ec06b5aec6b0f915c3ff044cd98f864ab..7b3704ef401bbb258d9ac4380a934b8ad2031bbe 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -131,7 +131,6 @@ static struct fib6_info *rt6_get_route_info(struct net *net,
 struct uncached_list {
 	spinlock_t		lock;
 	struct list_head	head;
-	struct list_head	quarantine;
 };
 
 static DEFINE_PER_CPU_ALIGNED(struct uncached_list, rt6_uncached_list);
@@ -189,8 +188,7 @@ static void rt6_uncached_list_flush_dev(struct net_device *dev)
 				handled = true;
 			}
 			if (handled)
-				list_move(&rt->dst.rt_uncached,
-					  &ul->quarantine);
+				list_del_init(&rt->dst.rt_uncached);
 		}
 		spin_unlock_bh(&ul->lock);
 	}
@@ -6755,7 +6753,6 @@ int __init ip6_route_init(void)
 		struct uncached_list *ul = per_cpu_ptr(&rt6_uncached_list, cpu);
 
 		INIT_LIST_HEAD(&ul->head);
-		INIT_LIST_HEAD(&ul->quarantine);
 		spin_lock_init(&ul->lock);
 	}
 
-- 
2.45.1.467.gbab1589fc0-goog


