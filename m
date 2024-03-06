Return-Path: <netdev+bounces-77993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40490873B72
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 17:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 493021C243D9
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 16:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7302313665D;
	Wed,  6 Mar 2024 16:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e41lbpT7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FD413667B
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 16:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740846; cv=none; b=iOkfSevPrClMKvfvmJlhIVHy2Iqw7bcVOIZv6jsE8fbyjEcwxDxgEvJz+UecKPpvMcbQnnbaQ1VHPqdrBsGDLaxJnz1RpdE1Lg2S8tJKT2itpv2o1E6xWnbHDKtDRwOR/Poluz6LeCAyokOZTrXV7C5o56nkxFuy+YyYVmzxvXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740846; c=relaxed/simple;
	bh=f4wxbe4KgsVU2UnfrwyI6uMEOA7LUdOMPKRsbXWElNU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cUA658yPo+xL4gYzW/Ss0SVH6BkMtfuxVc7Iu/tItr3y5DorfUf+m8aGIW+jNzmL8lVzr87IFqOlEXtfyJYuZD8h5VmJPK3Mr2xK7ELy+grF2azDu5uW/tFA/1F/56w7rJ3WT06J1rAbqPfcxLBB1hkLCdKITX2zz46f1/vG3A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e41lbpT7; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6096493f3d3so94987357b3.2
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 08:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709740844; x=1710345644; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1rVDJdLTVx9j+9qoaD0w8tRyN1ITErVjhB+hHzPdz9c=;
        b=e41lbpT7w2T02buNAMB5yE93PFx3NhciNzqmWJPAeZA8ihKrEUvgMQY55BSW1thra9
         R9LC0R6mAXVnrowkaGO1uAcigAL8b6djBvX0CGchSYZfPGhiviLdNQu6ujPXEkstj7Yl
         giJvjzLGSeSPkwuo6UyXMSjTiDsZ4wpdXlY/hB0ksQk2KVpmFCVf1hAHr0tbqLVJDGlU
         eLYHmcO1MFwocAiUAXrwQh21l4mQDv8x/e99Xcj8iu3HMRA9thppyGeyf+XdcX6XbD03
         NdKTqGp85+twAX0NS/V2wuosyjLb0skg90gXR93/olXRtv/kx9o3EJXej3kDnRwkpY6t
         ABBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709740844; x=1710345644;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1rVDJdLTVx9j+9qoaD0w8tRyN1ITErVjhB+hHzPdz9c=;
        b=rxzpaukaFnHC6xue7o/AtyWhVRyz3k4okKSBxmTB+v1I8a310wpvM5OA9Z6IPDxPeL
         2MaSiZMt2Q3C0Ze3T3qLXzfC9+Tizthj03RBKNgSYuvXyaxAOIfk6ZmRy9TkeQFfclq7
         6wW49SQk/RwghKNMlDesPv0QQU+480x7jxoiRclISoDjqdk76C9++lE4kHnAP9Jto/wj
         G212B7oWGjQEJ1PUzmV2V620QyGWX4GDB+AgJg5PXYeWtXzZknV0ctAvgWWkdLEzL1tO
         saJxwaaP7SHSuIPX0QIle27P6n1vDHbUHiEZrlKBkE3ecuKGmUJugrgxF3md+pD2wEUL
         rVew==
X-Forwarded-Encrypted: i=1; AJvYcCUTCCm/xbhpFSRX6VWsYhtpTNI4qTLDKKgvyx+soRzXZfwNd79KYGtYj+pLU0OHV5PjyndpX+EaPps5PoMkUmf4f+TBTgy9
X-Gm-Message-State: AOJu0Yz/FbIQjsXLB6zi7uY8w9XnAQVrdtl0SEt+S0NB8ah9BXtAyute
	g9TliefuiRzZiVUjwgohiODtpeo//zd2Y+e80SGdlRb+kpoB9bD6fooktskERyIO7eMIZj7zpWz
	R1CxE2nJsoQ==
X-Google-Smtp-Source: AGHT+IFEZd7XhA13yNbj1WGFW5PB/X2aA+9VFVBGeNwF/4bYof801w2hRM4KDDs2unpJpLoIAI0TMfKuhzZzDg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:690c:82:b0:609:78d7:4e9 with SMTP id
 be2-20020a05690c008200b0060978d704e9mr3210275ywb.6.1709740843847; Wed, 06 Mar
 2024 08:00:43 -0800 (PST)
Date: Wed,  6 Mar 2024 16:00:16 +0000
In-Reply-To: <20240306160031.874438-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240306160031.874438-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306160031.874438-4-edumazet@google.com>
Subject: [PATCH v2 net-next 03/18] net: move netdev_tstamp_prequeue into net_hotdata
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

netdev_tstamp_prequeue is used in rx path.

Move it to net_hotdata for better cache locality.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
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


