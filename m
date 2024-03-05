Return-Path: <netdev+bounces-77580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BCE872392
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 17:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 205CD1C22452
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 16:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5FC12881B;
	Tue,  5 Mar 2024 16:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EhWhZbCa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC08128804
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 16:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709654663; cv=none; b=Wy1lOKwOnqFm57QDNElzazf0rKNL67NmiUGNaddVEemJs1Cbsy88bIbQzbA+ojewELGELemqDuF28Z6t1TXNDYIV7E8NT64jv8oZ3u1ZKMVOy1JFQytiKDNb0qWe9AjJHg8OXbpb9dzoCenIqceSeF/HU0NwQ4tddv1hq6A4BDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709654663; c=relaxed/simple;
	bh=JzNyBUgM5kqm0qh/j6abNXmcE/WZtRpjVnkJZqx2Vvg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H3ZrD7CpagVCTGB4giWZLR2XlH7CoxIp5eAzjUH8iuBj/gEhJs1W7OmjObanXBBBVjMA2NXS5ZoLkZcIzoBc+GCSTmTTwKGdNiBceIbKi3VdpXODvuQgFBdTr6JX0Sagdi6vxMunxz/5UxGrBsUC8/iXsN6sGSBoMLAV81M5Gr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EhWhZbCa; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc64e0fc7c8so8781220276.2
        for <netdev@vger.kernel.org>; Tue, 05 Mar 2024 08:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709654660; x=1710259460; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TfYSoeGWUA6oA9i9yl8PIu9Ha00NoLjunGBNWRckx+M=;
        b=EhWhZbCa7GlDJm/espnif/X1ImOGth4LpWUU8/ZE8lr8cGC8Dvi+0EpWminsHwxLVN
         gTS7+DHElJU5xHDGMPzl6RFRRhB5yj5LCs/EcrPy5YM5+Lxz52WSythO5uPFJVw3lFYt
         IVQQwWGBkFS5j2oBVY8sSZgYoSoGWZnwH3EvpkqIiqUzKCwBYPPDUgQXFjPi2rwtvLbG
         YKweF0cHYiMipSFvBTI0e7YUh5qf3vHHGaI3+3ElDHAsGUXsVjH354y0yv5wIMArbEvK
         32oluEPlXg99X8s6g4i7HOkG9zNBodZLnq0EKGmVCRDsrgNR1g1nQqB13HBEjwUwvGrj
         Z2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709654660; x=1710259460;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TfYSoeGWUA6oA9i9yl8PIu9Ha00NoLjunGBNWRckx+M=;
        b=Jme70hKu68I7O6m3r0gfRsbo2YufTWU2FkWEX8YFsGgarMlvVkIcnRLtRF73qPGAiN
         HWXC0P7vj1g1OWmBpHSlBu1XLJCveRVTRKpgDUyEv2P1OSDjiwGj8YFEsdt6FE+0lrAf
         Hp07wJK8ez7YOpal9iNprwPSfMJF7LefXEnRrRqfCEWtggjFnobO4ykohyqEdo5X/Umo
         EO0qzBB65uEyIWtEkbhvMFBzKsx9A5FMxd/I5VE+BVWY/sweAWrAlzhqAdX+VTDOHcUK
         hR3lHdyi2tkb8zr21OMoh7sBAOozii6OvIutc7HZiNuOO7sh9OylGU7gJ0XyFBXpnxz0
         zNSg==
X-Gm-Message-State: AOJu0YwGAzGlU3mXseQhnVTCB5UddiegfYQTsI5+jYkKgK7Mz30e6zAs
	04s33HqXqkJEpijsB/mL7J0033aLRXiWyRJRZoVlUux7CaStvRMW1O3yEfA9QoEcub/+9SAWgPN
	2QcHaay4R1g==
X-Google-Smtp-Source: AGHT+IHvyW25y+EGIWbprAvVgm5OeELPoXUHCIi3TtfNeSV+acnJfl4seredc4JFVV7R3RlNDR42ke9cx1QudQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:102e:b0:dcd:c091:e86 with SMTP
 id x14-20020a056902102e00b00dcdc0910e86mr523862ybt.13.1709654660663; Tue, 05
 Mar 2024 08:04:20 -0800 (PST)
Date: Tue,  5 Mar 2024 16:03:58 +0000
In-Reply-To: <20240305160413.2231423-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240305160413.2231423-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240305160413.2231423-4-edumazet@google.com>
Subject: [PATCH net-next 03/18] net: move netdev_tstamp_prequeue into net_hotdata
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Soheil Hassas Yeganeh <soheil@google.com>, 
	Neal Cardwell <ncardwell@google.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

netdev_tstamp_prequeue is used in rx path.

Move it to net_hotdata for better cache locality.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/hotdata.h      |  1 +
 net/core/dev.c             | 10 +++++-----
 net/core/dev.h             |  1 -
 net/core/hotdata.c         |  2 ++
 net/core/sysctl_net_core.c |  2 +-
 5 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/net/hotdata.h b/include/net/hotdata.h
index 72170223385ebe65cce42f762b3686c072291d36..149e56528537d8ed3365e46d6dc96e39c73a733a 100644
--- a/include/net/hotdata.h
+++ b/include/net/hotdata.h
@@ -10,6 +10,7 @@ struct net_hotdata {
 	int			gro_normal_batch;
 	int			netdev_budget;
 	int			netdev_budget_usecs;
+	int			tstamp_prequeue;
 };
 
 extern struct net_hotdata net_hotdata;
diff --git a/net/core/dev.c b/net/core/dev.c
index 0102a1810e7b148f465b87886b743e3d12c0e578..53ebdb55e8b7c0a6522eb3fdbb7bdd00948eb9a5 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4408,7 +4408,6 @@ EXPORT_SYMBOL(__dev_direct_xmit);
 int netdev_max_backlog __read_mostly = 1000;
 EXPORT_SYMBOL(netdev_max_backlog);
 
-int netdev_tstamp_prequeue __read_mostly = 1;
 unsigned int sysctl_skb_defer_max __read_mostly = 64;
 int weight_p __read_mostly = 64;           /* old backlog weight */
 int dev_weight_rx_bias __read_mostly = 1;  /* bias for backlog weight */
@@ -5052,7 +5051,7 @@ static int netif_rx_internal(struct sk_buff *skb)
 {
 	int ret;
 
-	net_timestamp_check(READ_ONCE(netdev_tstamp_prequeue), skb);
+	net_timestamp_check(READ_ONCE(net_hotdata.tstamp_prequeue), skb);
 
 	trace_netif_rx(skb);
 
@@ -5344,7 +5343,7 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
 	int ret = NET_RX_DROP;
 	__be16 type;
 
-	net_timestamp_check(!READ_ONCE(netdev_tstamp_prequeue), skb);
+	net_timestamp_check(!READ_ONCE(net_hotdata.tstamp_prequeue), skb);
 
 	trace_netif_receive_skb(skb);
 
@@ -5728,7 +5727,7 @@ static int netif_receive_skb_internal(struct sk_buff *skb)
 {
 	int ret;
 
-	net_timestamp_check(READ_ONCE(netdev_tstamp_prequeue), skb);
+	net_timestamp_check(READ_ONCE(net_hotdata.tstamp_prequeue), skb);
 
 	if (skb_defer_rx_timestamp(skb))
 		return NET_RX_SUCCESS;
@@ -5758,7 +5757,8 @@ void netif_receive_skb_list_internal(struct list_head *head)
 
 	INIT_LIST_HEAD(&sublist);
 	list_for_each_entry_safe(skb, next, head, list) {
-		net_timestamp_check(READ_ONCE(netdev_tstamp_prequeue), skb);
+		net_timestamp_check(READ_ONCE(net_hotdata.tstamp_prequeue),
+				    skb);
 		skb_list_del_init(skb);
 		if (!skb_defer_rx_timestamp(skb))
 			list_add_tail(&skb->list, &sublist);
diff --git a/net/core/dev.h b/net/core/dev.h
index 9a6170530850c78508f9234ec82b174f4bf5a4a3..2bcaf8eee50c179db2ca59880521b9be6ecd45c8 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -39,7 +39,6 @@ void dev_addr_check(struct net_device *dev);
 
 /* sysctls not referred to from outside net/core/ */
 extern unsigned int	sysctl_skb_defer_max;
-extern int		netdev_tstamp_prequeue;
 extern int		netdev_unregister_timeout_secs;
 extern int		weight_p;
 extern int		dev_weight_rx_bias;
diff --git a/net/core/hotdata.c b/net/core/hotdata.c
index 907d69120397dfb8d5a901912b72580fe256c762..087c4c84987df07f11a87112a778a5cac608a654 100644
--- a/net/core/hotdata.c
+++ b/net/core/hotdata.c
@@ -12,4 +12,6 @@ struct net_hotdata net_hotdata __cacheline_aligned = {
 	.netdev_budget = 300,
 	/* Must be at least 2 jiffes to guarantee 1 jiffy timeout */
 	.netdev_budget_usecs = 2 * USEC_PER_SEC / HZ,
+
+	.tstamp_prequeue = 1,
 };
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index a9c2d798b219506da75a5d0a30d490ff4011d668..bddd07da099886f2747f2ac4ba39a482b0f4231d 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -499,7 +499,7 @@ static struct ctl_table net_core_table[] = {
 #endif
 	{
 		.procname	= "netdev_tstamp_prequeue",
-		.data		= &netdev_tstamp_prequeue,
+		.data		= &net_hotdata.tstamp_prequeue,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec
-- 
2.44.0.278.ge034bb2e1d-goog


