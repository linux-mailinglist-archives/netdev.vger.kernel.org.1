Return-Path: <netdev+bounces-77579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2DB872391
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 17:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F83F1C21B81
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 16:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBE6128805;
	Tue,  5 Mar 2024 16:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dbXyHV46"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353A48613F
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 16:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709654661; cv=none; b=dIJ6NzW7rl+TM80CNiu7hshn1gRWZ13OQ+yK2lhj3BeuWer/KGJNN9Jb4fqL0RWya1lrrE934/lG0lHB7BrQ1g09derJE2+0drKviJqJSCWFXy4ScBzj2BmlgiExzoj4KS2iA1AFzXB1OXbtk37DpwGK5CXsshcR0080R84kmKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709654661; c=relaxed/simple;
	bh=qp1qgt2zDEDBM+0n/pxRpAEVbnIJipRGuXxeSRTPy/g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UxDmtgKgmGTPj6Ln7U+4QmpE0h1SrtSNwTrg0KrPSyL6Jncqljh+Kvk01WFQc+7NLKIaezArBx8RZ9Up+n992VFHjTfvaX2RDw6ZiEUf+gNjEUJ8XrXQZ96wJEbz4zuXUKWCs9N459Igk+M8G7fZXsbAtPYomU0JahAuTdIXtt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dbXyHV46; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dced704f17cso9808761276.1
        for <netdev@vger.kernel.org>; Tue, 05 Mar 2024 08:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709654659; x=1710259459; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BlPfYhfDEF30sgDH3HFcx4bwCeATqFumLekjJ9n7FH0=;
        b=dbXyHV46uzA61i6eEC120OHEh/Y0n7QXb0JBdcU3brwzKw4JMpm9wiUoHB2rFGZVHm
         2eZzEVpKgQ8CJLGGoUBiVtqoF46CGSC3kwJQRps3bNFjgARlyVn40OpRQvYoJneAxjko
         Biqba0fFyuHWOy21LAFiXIuvaQbVTs1Hr3z+ZBsAcmo1vETYPZp39yFmilrK/nD6j5e0
         z8dnFAQn3hQrPMPpcDgVmf6c359h8fDRg23NTjnKgmFe5OKe1ICF75gwP/P8oyKCmOAG
         MZ8S0mQErJcCwgYmU7/z0og4GAXMuoyL0+ZgZwameWh+LZVmBQEp3tNlGSfTQBcBsBKs
         vJRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709654659; x=1710259459;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BlPfYhfDEF30sgDH3HFcx4bwCeATqFumLekjJ9n7FH0=;
        b=iud7WmI8QtFVxg9TT9bazoWAdjzCxo6mo4bspuBurUvSoJgenaf/aYH2mZVVs+Oc54
         bmKjYhXjLIzmgA2P+dGiaBFVgepqICzm5PGj9kwRahWkGdUrpxhGW48Hfilfy+2PjaMR
         oxXHc4HC1PeFlzD83eM15sMg0V7msj0cV5t+MmPLrmJAgs4jCo+GtEeAk5EmJk5N8hAC
         yv4rJZyuc4URw1CJ6GXTbPzqMlZhxgMNAHo6IyrtMoporDN8/RrGWOaqhQrUaSewYPdI
         yFtZPAwjh2Z04uyZvuidevDrv5/hyuj4nERTWTxEgBDqldWK40AUOSY0fvz90wWCO+X9
         AtvQ==
X-Gm-Message-State: AOJu0Yye2aR7G5eNqoH5FKxTxPMyLNOUWcIPvyQs8VTr5NaGEbuVEqYW
	2sW/W01piAKVkYjrknWcYBLLoVUyuPvKm8/BVcBhmafSxx3zvowzecIrHk2ijVcrJMWSH0dfgln
	TYYthgk8btA==
X-Google-Smtp-Source: AGHT+IGKDieeyo3h8ch4c0hBIwR9S8G86/YrRoZF1TPDL4z3Joh4864uVlawC3FeDD7mzsIWFfg1AyQm8RNQmw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1081:b0:dcc:41ad:fb3b with SMTP
 id v1-20020a056902108100b00dcc41adfb3bmr475061ybu.10.1709654659198; Tue, 05
 Mar 2024 08:04:19 -0800 (PST)
Date: Tue,  5 Mar 2024 16:03:57 +0000
In-Reply-To: <20240305160413.2231423-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240305160413.2231423-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240305160413.2231423-3-edumazet@google.com>
Subject: [PATCH net-next 02/18] net: move netdev_budget and netdev_budget to net_hotdata
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Soheil Hassas Yeganeh <soheil@google.com>, 
	Neal Cardwell <ncardwell@google.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

netdev_budget and netdev_budget are used in rx path (net_rx_action())

Move them into net_hotdata for better cache locality.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/hotdata.h      | 2 ++
 net/core/dev.c             | 7 ++-----
 net/core/dev.h             | 2 --
 net/core/hotdata.c         | 6 ++++++
 net/core/sysctl_net_core.c | 4 ++--
 5 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/include/net/hotdata.h b/include/net/hotdata.h
index 6ed32e4e34aa3bdc6e860f5a8a6cab69c36c7fad..72170223385ebe65cce42f762b3686c072291d36 100644
--- a/include/net/hotdata.h
+++ b/include/net/hotdata.h
@@ -8,6 +8,8 @@
 struct net_hotdata {
 	struct list_head	offload_base;
 	int			gro_normal_batch;
+	int			netdev_budget;
+	int			netdev_budget_usecs;
 };
 
 extern struct net_hotdata net_hotdata;
diff --git a/net/core/dev.c b/net/core/dev.c
index fe054cbd41e92cbca87f1c0640c6ebe4fb6b2d86..0102a1810e7b148f465b87886b743e3d12c0e578 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4410,9 +4410,6 @@ EXPORT_SYMBOL(netdev_max_backlog);
 
 int netdev_tstamp_prequeue __read_mostly = 1;
 unsigned int sysctl_skb_defer_max __read_mostly = 64;
-int netdev_budget __read_mostly = 300;
-/* Must be at least 2 jiffes to guarantee 1 jiffy timeout */
-unsigned int __read_mostly netdev_budget_usecs = 2 * USEC_PER_SEC / HZ;
 int weight_p __read_mostly = 64;           /* old backlog weight */
 int dev_weight_rx_bias __read_mostly = 1;  /* bias for backlog weight */
 int dev_weight_tx_bias __read_mostly = 1;  /* bias for output_queue quota */
@@ -6790,8 +6787,8 @@ static __latent_entropy void net_rx_action(struct softirq_action *h)
 {
 	struct softnet_data *sd = this_cpu_ptr(&softnet_data);
 	unsigned long time_limit = jiffies +
-		usecs_to_jiffies(READ_ONCE(netdev_budget_usecs));
-	int budget = READ_ONCE(netdev_budget);
+		usecs_to_jiffies(READ_ONCE(net_hotdata.netdev_budget_usecs));
+	int budget = READ_ONCE(net_hotdata.netdev_budget);
 	LIST_HEAD(list);
 	LIST_HEAD(repoll);
 
diff --git a/net/core/dev.h b/net/core/dev.h
index 45892267848d7a35a09aea95f04cfd9b72204d3c..9a6170530850c78508f9234ec82b174f4bf5a4a3 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -38,8 +38,6 @@ int dev_addr_init(struct net_device *dev);
 void dev_addr_check(struct net_device *dev);
 
 /* sysctls not referred to from outside net/core/ */
-extern int		netdev_budget;
-extern unsigned int	netdev_budget_usecs;
 extern unsigned int	sysctl_skb_defer_max;
 extern int		netdev_tstamp_prequeue;
 extern int		netdev_unregister_timeout_secs;
diff --git a/net/core/hotdata.c b/net/core/hotdata.c
index abb8ad19d59acc0d7d6e1b06f4506afa42bde44b..907d69120397dfb8d5a901912b72580fe256c762 100644
--- a/net/core/hotdata.c
+++ b/net/core/hotdata.c
@@ -1,9 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 #include <net/hotdata.h>
 #include <linux/cache.h>
+#include <linux/jiffies.h>
 #include <linux/list.h>
 
+
 struct net_hotdata net_hotdata __cacheline_aligned = {
 	.offload_base = LIST_HEAD_INIT(net_hotdata.offload_base),
 	.gro_normal_batch = 8,
+
+	.netdev_budget = 300,
+	/* Must be at least 2 jiffes to guarantee 1 jiffy timeout */
+	.netdev_budget_usecs = 2 * USEC_PER_SEC / HZ,
 };
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 0eb1242eabbe0d3ea58886b1db409c9d991ac672..a9c2d798b219506da75a5d0a30d490ff4011d668 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -577,7 +577,7 @@ static struct ctl_table net_core_table[] = {
 #endif
 	{
 		.procname	= "netdev_budget",
-		.data		= &netdev_budget,
+		.data		= &net_hotdata.netdev_budget,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec
@@ -600,7 +600,7 @@ static struct ctl_table net_core_table[] = {
 	},
 	{
 		.procname	= "netdev_budget_usecs",
-		.data		= &netdev_budget_usecs,
+		.data		= &net_hotdata.netdev_budget_usecs,
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-- 
2.44.0.278.ge034bb2e1d-goog


