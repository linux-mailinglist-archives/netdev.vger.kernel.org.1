Return-Path: <netdev+bounces-92159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F968B5A48
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 15:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E39E1F24C23
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 13:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31474745ED;
	Mon, 29 Apr 2024 13:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JNW098sd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDD174404
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 13:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714398033; cv=none; b=Zos3PYDZlmJY/HTxkH/30dI9PK77hTrF4fdu1lpRLEA7kEgRkn7Ndp7I8j0fspvyQN7kFsElmydysAAFXleMXbA7eZX812R4VfSMz2HxZq6BPjNxChvTkuV1uuncq8i0Zki25Jhapd1q53q2RstKlARK4m4Ye/qG5Znqw8tgZzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714398033; c=relaxed/simple;
	bh=CKyRb0jRgbcMZjZuRKL4Xo1l1UZfaQnuMg8GDrAD7bk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q+KnJErlwj9xEKyd3RQOoKtGc2k05CGp+djsF9uL5NQzbPkWOE+tbRsKQ5Lpe7YizCpadvfTpWh7xcsoYBKnKjpYiOz+lFXLYX579WnjswbLks/f3bgiuGtIpS2tSVcXvhE4wu8CfnzUtfzNnhKNUdJuOMgzjg3U68eIm4n3gZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JNW098sd; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de45c577ca9so6630984276.0
        for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 06:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714398030; x=1715002830; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BamTd/jje90Vv3sMBUF4Hr/QM7nsdp+JZ7ooDodhurU=;
        b=JNW098sdRw6AdAAJBwKSEsPneKRzYTGMfCB2iwNxzdaiX0BDQBaNEEzwxQsYXkUuy4
         v6kUm6uOyv+7L4K9gVQxnsU5LFXzEbGVZwoOzw9AJCUaedHPMZLPJsvtMpbRz11Bn1wt
         5WuaF9dyLjvU45yHRT4cuxeypsmbhAhDXgYZoC+1+1E0xYNuHVhGutCfDEaNx1qcXfOF
         o2Vtnusu/BAeHq0z5Wm3aabUEGK87gseHruAaIsi7Are8vJDA3h00qx11ZdygeQ02Wxv
         lFCRWBfzBwcyKEdGHDz7TrST1n0o5EA5P1WjgAC9fs6wuePL4wqWYnVaDSVCqTt0BYJG
         qGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714398030; x=1715002830;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BamTd/jje90Vv3sMBUF4Hr/QM7nsdp+JZ7ooDodhurU=;
        b=q4tVZlUeV6QqDh9X1sDxNwolXvzVZuqqer8NmpPRSj/rYlnqu7rGdU877FWu6eun7T
         1PC7v2VtMQVgrGIVpCFyJQRItkeI4c7e6GBUA7zN6DkELAM6DU5onWILcizl2uBrZ79F
         6hgu2mNZRr6BkdoYGHFR6HRxGynVQI4RKH0EzqK7c7UC4LvukQ+JK+iy3cKu+d0lQAO4
         ZRPO/r8MX+BzbSYxbFRFkgU61VA5/yjLwKK1BtQp8n3lYP/06NnegUYL7CPlGV4v0mCl
         4W+l1X3bu+hI2dY4mNbxHLbGoguZg1DcRhH4mkAGlZ7j3K3W3SKZG2twczaAxbM9SxPp
         loNg==
X-Gm-Message-State: AOJu0Yz5a9Lx6DuIgQnuQknBcTrpzTMLvrxH1zl/rsy6ECRW9FsatK3o
	R06BVekXO+yvSVKmBvdEQT7knbdrgh+X8tU7vBaQPw0CyMxWhgzBXQkpaGNNVfsa5uYSzh2N/d2
	MbQvGOT5YWg==
X-Google-Smtp-Source: AGHT+IFrkFK8wRzbA1m7Z2shwn6mczSz/NG0IlBSxoC5lwg2ecBzfKKPCRcZi4UWxm/R+Hh84K7Tye4BKSxD5w==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:d850:0:b0:de5:dcb8:5c8a with SMTP id
 p77-20020a25d850000000b00de5dcb85c8amr1309356ybg.2.1714398030620; Mon, 29 Apr
 2024 06:40:30 -0700 (PDT)
Date: Mon, 29 Apr 2024 13:40:22 +0000
In-Reply-To: <20240429134025.1233626-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240429134025.1233626-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240429134025.1233626-3-edumazet@google.com>
Subject: [PATCH net-next 2/5] net: move sysctl_skb_defer_max to net_hotdata
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

sysctl_skb_defer_max is used in TCP fast path,
move it to net_hodata.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/hotdata.h      | 1 +
 net/core/dev.c             | 1 -
 net/core/dev.h             | 1 -
 net/core/hotdata.c         | 1 +
 net/core/skbuff.c          | 2 +-
 net/core/sysctl_net_core.c | 2 +-
 6 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/net/hotdata.h b/include/net/hotdata.h
index a6cff65904267f338fbd258d23be79d46a062f9e..290499f72e18d45a8ed7bd9e8880a51f7ef2b94c 100644
--- a/include/net/hotdata.h
+++ b/include/net/hotdata.h
@@ -39,6 +39,7 @@ struct net_hotdata {
 	int			dev_tx_weight;
 	int			dev_rx_weight;
 	int			sysctl_max_skb_frags;
+	int			sysctl_skb_defer_max;
 };
 
 #define inet_ehash_secret	net_hotdata.tcp_protocol.secret
diff --git a/net/core/dev.c b/net/core/dev.c
index c9e59eff8ec841f6267c2749489fdc7fe0d03430..cd7ba50eac15341c1d3a2136f8b4a3584d5c2669 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4450,7 +4450,6 @@ EXPORT_SYMBOL(__dev_direct_xmit);
  *************************************************************************/
 static DEFINE_PER_CPU(struct task_struct *, backlog_napi);
 
-unsigned int sysctl_skb_defer_max __read_mostly = 64;
 int weight_p __read_mostly = 64;           /* old backlog weight */
 int dev_weight_rx_bias __read_mostly = 1;  /* bias for backlog weight */
 int dev_weight_tx_bias __read_mostly = 1;  /* bias for output_queue quota */
diff --git a/net/core/dev.h b/net/core/dev.h
index 8572d2c8dc4adce75c98868c888363e6a32e0f52..b7b518bc2be55aa42847fee3f21749a658d97f35 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -36,7 +36,6 @@ int dev_addr_init(struct net_device *dev);
 void dev_addr_check(struct net_device *dev);
 
 /* sysctls not referred to from outside net/core/ */
-extern unsigned int	sysctl_skb_defer_max;
 extern int		netdev_unregister_timeout_secs;
 extern int		weight_p;
 extern int		dev_weight_rx_bias;
diff --git a/net/core/hotdata.c b/net/core/hotdata.c
index f17cbb4807b99937b272be12953f790c66cc2cd1..a359ff160d54ad379eac7e56e1810a7e840f9275 100644
--- a/net/core/hotdata.c
+++ b/net/core/hotdata.c
@@ -19,5 +19,6 @@ struct net_hotdata net_hotdata __cacheline_aligned = {
 	.dev_tx_weight = 64,
 	.dev_rx_weight = 64,
 	.sysctl_max_skb_frags = MAX_SKB_FRAGS,
+	.sysctl_skb_defer_max = 64,
 };
 EXPORT_SYMBOL(net_hotdata);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 65779b8f0b126a1c039cf24a47474c0cb80ff6ae..5f382e94b4d1d2a1913867f28c639881fce962c0 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6985,7 +6985,7 @@ nodefer:	kfree_skb_napi_cache(skb);
 	DEBUG_NET_WARN_ON_ONCE(skb->destructor);
 
 	sd = &per_cpu(softnet_data, cpu);
-	defer_max = READ_ONCE(sysctl_skb_defer_max);
+	defer_max = READ_ONCE(net_hotdata.sysctl_skb_defer_max);
 	if (READ_ONCE(sd->defer_count) >= defer_max)
 		goto nodefer;
 
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index e75375d54b9e50673af28f6d6b3bb83fc74cb1f8..118c78615543852eabd3067bbb7920418b7da7b3 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -654,7 +654,7 @@ static struct ctl_table net_core_table[] = {
 	},
 	{
 		.procname	= "skb_defer_max",
-		.data		= &sysctl_skb_defer_max,
+		.data		= &net_hotdata.sysctl_skb_defer_max,
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-- 
2.44.0.769.g3c40516874-goog


