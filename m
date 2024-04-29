Return-Path: <netdev+bounces-92158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA3E8B5A44
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 15:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD5211C212C3
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 13:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABA474400;
	Mon, 29 Apr 2024 13:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="13a2OFxV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F10071B47
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 13:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714398031; cv=none; b=ErE4k72UwXIiMNNR77u+ays7hIKQylJTLralhUv7n5UePST+YzjzxZNc2akjckmK1ZCNCz90Ww9C+eP1sjbJrM20NqxERx1WoHPZ7K+NvXAZzjjN6Yn9CCtm0I7uqXzakfBiw5sT8tsWssYiggUe8m2JE9G8xGmYs3FGTyiYnKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714398031; c=relaxed/simple;
	bh=4LwSGpsH4EVfi88dCSIGFVdR/ciAyCPoiIpnaatD3DY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Fuulo3Zzhd9JkyfbwoJI7SAo6KB1C8i+ydBYwQ1yZkO2XiIqgf39e+Haa4x7VDiWFSv5A5Osa/L6zFq70R2lw/D0GHPZE54hxI2FQqH53RtfNdGYYWIEthDQW4nQN/ztND5iBqzeefXTqjUBpWKGswk10EHftSnKahNBodnIAbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=13a2OFxV; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61b1200cc92so86996517b3.0
        for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 06:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714398029; x=1715002829; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=weBRy1mL/8+GKOw1EeGuZyc7Rd3303raB1gmLNP7l4I=;
        b=13a2OFxVz2NysHFBKkboQ899Kk/AWThk3nzXgk+6mc5FO0XzQC/4iUQv1Y+JQHPmN/
         hAkt5eZyalG55ZWPBDp57ZzWIVdU8Km2S0768h5BgzGrVgppL1i2a4B99qCqhCAkyy3L
         d5Kn0fFenAI0zHJcXdzM1s1kYP3VDZluOuPbmfbTFfeTK7yDuENg9cI67H9/NHWE8teK
         eThOvrvfppnYsKROaZgKL2qnEZ6ak1gDWfCvGChaPRoHC1xw4fa6Ak91SixGRFmbUXPW
         nkyQmZvRfMOVFMogBmYXckNQewDpibNw+EwVaDJuejJ9HHNBq6Ay1AhJ8+/ihNMS5Pq2
         IuTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714398029; x=1715002829;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=weBRy1mL/8+GKOw1EeGuZyc7Rd3303raB1gmLNP7l4I=;
        b=mHI1CucIiPCdRVhYKUr/eSIDm6N9zScj8gjrffa9FBOyOIiO/CRTPVOTp9QelS1BXO
         hCBugHbWJzTT186+3M7dUb4RuOY5njdVo11eXpxUW2Mqyj3mgUuPBq0UJjWKFk3ZIwoD
         qUhHXrXrxh3/AjJfNznVnl01MhaXxt7u2E8U2Cl41vINAYTxq3XEp/+VPy5aNbM55iCr
         ec8fj1NTn2/EhJDKkusBIIjkjXTcknDXvA01TEPab0u201Evk1dxm/Nqsir8aK3tP8x3
         w0NRooK8RxhmPPfTSRZPjZ8lUU20nWD0KCNI8VLVsTbfLOROgB1xMjJ7tnU3ru3C03eW
         i9gw==
X-Gm-Message-State: AOJu0YwvHIJvLmQaKcx05ezJPM4xlKQVXmuyPcwkcxuZu8S7TU/BqETK
	Ff8kFjB2zO9ZdA+s/IlnEzJ0MDlH7jasmTkzYfSQzki+I9uCXDigBpjX45F9hjGrJMymsSbZeX1
	5xoqTVD+whg==
X-Google-Smtp-Source: AGHT+IHfKV7hk/R2IvzKcS4G7q3acN6BGYX/03MgQtzBGa0064hquhKM7S6EzLhXwHtMzn3NTD5FivpRSiz3Dg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:c0b:b0:de5:1e69:6447 with SMTP
 id fs11-20020a0569020c0b00b00de51e696447mr3381435ybb.6.1714398029007; Mon, 29
 Apr 2024 06:40:29 -0700 (PDT)
Date: Mon, 29 Apr 2024 13:40:21 +0000
In-Reply-To: <20240429134025.1233626-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240429134025.1233626-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240429134025.1233626-2-edumazet@google.com>
Subject: [PATCH net-next 1/5] net: move sysctl_max_skb_frags to net_hotdata
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

sysctl_max_skb_frags is used in TCP and MPTCP fast paths,
move it to net_hodata for better cache locality.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/skbuff.h     | 2 --
 include/net/hotdata.h      | 1 +
 net/core/hotdata.c         | 1 +
 net/core/skbuff.c          | 5 +----
 net/core/sysctl_net_core.c | 2 +-
 net/ipv4/tcp.c             | 3 ++-
 net/mptcp/protocol.c       | 3 ++-
 7 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index f76825e5b92a334f7726d7f7c99aa60ec69a8e07..4f99a39db2eb2868d9a14334070d4a574ba1f9a3 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -353,8 +353,6 @@ struct sk_buff;
 
 #define MAX_SKB_FRAGS CONFIG_MAX_SKB_FRAGS
 
-extern int sysctl_max_skb_frags;
-
 /* Set skb_shinfo(skb)->gso_size to this in case you want skb_segment to
  * segment using its current segmentation instead.
  */
diff --git a/include/net/hotdata.h b/include/net/hotdata.h
index 003667a1efd6b63fc0f0d7cadd2c8472281331b0..a6cff65904267f338fbd258d23be79d46a062f9e 100644
--- a/include/net/hotdata.h
+++ b/include/net/hotdata.h
@@ -38,6 +38,7 @@ struct net_hotdata {
 	int			max_backlog;
 	int			dev_tx_weight;
 	int			dev_rx_weight;
+	int			sysctl_max_skb_frags;
 };
 
 #define inet_ehash_secret	net_hotdata.tcp_protocol.secret
diff --git a/net/core/hotdata.c b/net/core/hotdata.c
index c8a7a451c18a383d091e413a510d84d163473f2f..f17cbb4807b99937b272be12953f790c66cc2cd1 100644
--- a/net/core/hotdata.c
+++ b/net/core/hotdata.c
@@ -18,5 +18,6 @@ struct net_hotdata net_hotdata __cacheline_aligned = {
 	.max_backlog = 1000,
 	.dev_tx_weight = 64,
 	.dev_rx_weight = 64,
+	.sysctl_max_skb_frags = MAX_SKB_FRAGS,
 };
 EXPORT_SYMBOL(net_hotdata);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 0c8b82750000f63b097cb4b7b990c647c81019df..65779b8f0b126a1c039cf24a47474c0cb80ff6ae 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -109,9 +109,6 @@ static struct kmem_cache *skbuff_ext_cache __ro_after_init;
 #define SKB_SMALL_HEAD_HEADROOM						\
 	SKB_WITH_OVERHEAD(SKB_SMALL_HEAD_CACHE_SIZE)
 
-int sysctl_max_skb_frags __read_mostly = MAX_SKB_FRAGS;
-EXPORT_SYMBOL(sysctl_max_skb_frags);
-
 /* kcm_write_msgs() relies on casting paged frags to bio_vec to use
  * iov_iter_bvec(). These static asserts ensure the cast is valid is long as the
  * netmem is a page.
@@ -7040,7 +7037,7 @@ static void skb_splice_csum_page(struct sk_buff *skb, struct page *page,
 ssize_t skb_splice_from_iter(struct sk_buff *skb, struct iov_iter *iter,
 			     ssize_t maxsize, gfp_t gfp)
 {
-	size_t frag_limit = READ_ONCE(sysctl_max_skb_frags);
+	size_t frag_limit = READ_ONCE(net_hotdata.sysctl_max_skb_frags);
 	struct page *pages[8], **ppages = pages;
 	ssize_t spliced = 0, ret = 0;
 	unsigned int i;
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 903ab4a51c178a4705b7eb610958c81c5ebcfdf5..e75375d54b9e50673af28f6d6b3bb83fc74cb1f8 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -595,7 +595,7 @@ static struct ctl_table net_core_table[] = {
 	},
 	{
 		.procname	= "max_skb_frags",
-		.data		= &sysctl_max_skb_frags,
+		.data		= &net_hotdata.sysctl_max_skb_frags,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 4ec0f4feee003d91fa5ae37ed4dd50e09c4c874a..388f6e115bf168e6f70b762096a984a2cacfa5c9 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -280,6 +280,7 @@
 #include <linux/uaccess.h>
 #include <asm/ioctls.h>
 #include <net/busy_poll.h>
+#include <net/hotdata.h>
 #include <net/rps.h>
 
 /* Track pending CMSGs. */
@@ -1188,7 +1189,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 
 			if (!skb_can_coalesce(skb, i, pfrag->page,
 					      pfrag->offset)) {
-				if (i >= READ_ONCE(sysctl_max_skb_frags)) {
+				if (i >= READ_ONCE(net_hotdata.sysctl_max_skb_frags)) {
 					tcp_mark_push(tp, skb);
 					goto new_segment;
 				}
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4b13ca362efa395a2ef7a92e553a8c49feebec79..aff17597e6a71ecc4b9aef4d02f039318fa1fe7f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -20,6 +20,7 @@
 #include <net/transp_v6.h>
 #endif
 #include <net/mptcp.h>
+#include <net/hotdata.h>
 #include <net/xfrm.h>
 #include <asm/ioctls.h>
 #include "protocol.h"
@@ -1272,7 +1273,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 
 		i = skb_shinfo(skb)->nr_frags;
 		can_coalesce = skb_can_coalesce(skb, i, dfrag->page, offset);
-		if (!can_coalesce && i >= READ_ONCE(sysctl_max_skb_frags)) {
+		if (!can_coalesce && i >= READ_ONCE(net_hotdata.sysctl_max_skb_frags)) {
 			tcp_mark_push(tcp_sk(ssk), skb);
 			goto alloc_skb;
 		}
-- 
2.44.0.769.g3c40516874-goog


