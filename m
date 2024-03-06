Return-Path: <netdev+bounces-77992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F501873B71
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 17:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 829D61C246AC
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 16:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B26136668;
	Wed,  6 Mar 2024 16:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CTzoZ48R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04DC13665D
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 16:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740844; cv=none; b=dWuLrKgzi5gx1oN/BaCSKuYKaR8fOriR8haxq7Qi+5Petf/XTt2xBcurOPA8hdcL6z+D1hSGkuAIEjVa+X7rid7PrFl5vViSsrrmQWeYIw+vv8jRYmsRGsLJRpJik+Xo+4oF2b5RHW7cjjRLoj/oSvuTsC/zK5uVrOC3WQQ9MyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740844; c=relaxed/simple;
	bh=kMWm8kH4b+ITapk4/NpQ8GbNj7rfzxEY18zU3EY8ZOI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sXT9L2CwAJtwCzqb2OuMjZfhkFgB10lh01dpdrx+AMYB0qBG7P2f8mlCxeYItNl5amt8G4WYRe5pgmo5eciQV5CDerNIMdCIZNWUTwUWqAnC95cHEyDbf1WUID8fDvQk9zXWgbIHy0Md+wh51sYmOxBpvSmiXEhK8JwcR1oGTi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CTzoZ48R; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-609a8fc232bso52423137b3.0
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 08:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709740841; x=1710345641; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+qh3Zyb/w9TvxBiWKj2uKBnLvw6V7yRjmepRKjM7p4M=;
        b=CTzoZ48RmYVptcJ+bl6HMQuFmcrF2SooaWmYI3jyrCOBpo5BfTmjO7Op1JstFMEJfc
         aVmUJrgF4Qjef9c1aCUC2LPLw5cWnuDkuDblvtc2M9nB87jx6FIICM+BMWfWH+Z19OAv
         wP2G9hAWI7htH6lr3lwfi73+sj2N6GOTpoGCF5KXRVEhT5d/gNMtnOkHGQJ4horXDUsa
         vtsOMl1M/sHdAs1+eEGdSAjelmx92KhbhRGcvfwaf7LcMXsXXozpLPb3UV0OW9jn8YEg
         YSms/YNir6BgPdGlvr345nlBS/dpmzDJy/lOSoZF+AdUmIepIoJ7W4PVB6bjmD2vSwCC
         5Gdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709740841; x=1710345641;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+qh3Zyb/w9TvxBiWKj2uKBnLvw6V7yRjmepRKjM7p4M=;
        b=BoAN3ExZioeoNejE+7QFb+dzHS2HJ7wkjRcXtJxqm2acQKq+2Sp5D1Bp564mL8wntn
         Lf0u2mSKY7TA2wC7BoclAM3LdmMCWNA7U4kcFP8svTZ1x8NIyYwb+32NAflt1tFqjkCR
         FfmWkfdGn0hzXrEddozvGkqTdMuUlOcuA+q89Wd1H9sweasrZfBJu+nqowBakEYNadIz
         ywfs8StS5KOkHMKAIBcc5NRZ7LlOfijjRgkBjq9CyLNwH8G2pUkdso08tR+loMJ5hknG
         obSFvYm8bqhgkOSuzjqjiWEGD+ycGybkg3L/BVa7jsnq3Oyy5f0dZYNpdX5t2Y4sBs7O
         83XQ==
X-Forwarded-Encrypted: i=1; AJvYcCXo6kKPcSAtVyVcHLGTUN+G9nIOdRJPwde/Ia64ES2HKsdPtZ41HUCPJdmnVJvke3tT4lBtUpsaRs8v0lvmLhk0ACvySzyU
X-Gm-Message-State: AOJu0YzyFg7EDUbPgZtE3WPJpAgMBbDpQDDBNt9OpIb0T7sesD8KYy0v
	23WQUcSEDoWz9MWhbiziZLX650TePEle0ARXK4ACzMjkfkio46t/GgcmDVmeUHgCOU+0QWUFOQJ
	ccZHzIV9HRw==
X-Google-Smtp-Source: AGHT+IHu67eXwLlEmc6YSNh1k8oQMoU41Pfbk34iphMBVBGm91WrNVj+bQSrDpf1USRutGGAPwQNFU+EC2fjdQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1148:b0:dc6:b813:5813 with SMTP
 id p8-20020a056902114800b00dc6b8135813mr501255ybu.9.1709740841603; Wed, 06
 Mar 2024 08:00:41 -0800 (PST)
Date: Wed,  6 Mar 2024 16:00:15 +0000
In-Reply-To: <20240306160031.874438-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240306160031.874438-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306160031.874438-3-edumazet@google.com>
Subject: [PATCH v2 net-next 02/18] net: move netdev_budget and netdev_budget
 to net_hotdata
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

netdev_budget and netdev_budget are used in rx path (net_rx_action())

Move them into net_hotdata for better cache locality.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
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


