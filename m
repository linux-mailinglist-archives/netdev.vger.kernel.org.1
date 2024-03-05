Return-Path: <netdev+bounces-77581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF67872393
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 17:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C74BEB2249D
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 16:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6A5128380;
	Tue,  5 Mar 2024 16:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ef0a/L4H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA898128816
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 16:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709654664; cv=none; b=grjBzsSOcMJEDRDP70O5M1FbnWUId1ipU6v2HvrJy9ysxsCc4xJg6xEyo3KP3y2v47Sm6tlm2LhLdmzODT/mxzFVxtfX0AzEsuMQBSh2pqzZZuCrZ3NTPIDDUs8wGdaJ8czXNHc4b4/7J4OHE2DSXHyRj/eOVcDghVH7xBj/xlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709654664; c=relaxed/simple;
	bh=Q8ZqJk7HUmRJS8hfnpURnkWgcpiWkE0RQFvtDSawFQQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aICIVh+ocuoZihMGEvnb7by8HmIJqZj+8vYNnyaFFObBil4WPnbQIplOo9VXFlu031mTj7oIA5pBmMx6SW9TmcZP/QNmE9L8GV3IGWrY6Fm2oBGg9+XeFH+ogcfMOgIXuxYL3D7ago6LZySMhjCDU6r3TdyjTRkBHWc6SoDiciE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ef0a/L4H; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-609a8fc232bso33028637b3.0
        for <netdev@vger.kernel.org>; Tue, 05 Mar 2024 08:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709654662; x=1710259462; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nPp+FKZCe5WrKAC/L6DMRtNnUj6zHw/P99nkgEHXMdE=;
        b=ef0a/L4HePAVJzctE0nZ5UmbHpgXCwFmrD8M4FjXk2Yx2yJ8wBZDEcibqoP1wFaDZP
         2fEcPDcP5GULokHtFPvad852SfqQxxo6/lDcpXEDphAQetUV6cpKQcCJYCIjqPVEXdrL
         Xwn3VQl4ujy5pCMlAJ8pLq9MLJvcOj766CXKJtf+vS6eLEJ94PEXvUZVQikZZJxeJkyn
         WiH/pnLbMpv4GnIP0pXddFA6WJbZl7yc810v9xvfQHvIHNh9n0nfJDqLMAmf9aqU200E
         j5v1Oyhe2bFf/pucBdrwEBVt9iE+pYS6TkNwcpvbbAu68OyFIBNOdmiM7EowWF+D8OdY
         3oIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709654662; x=1710259462;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nPp+FKZCe5WrKAC/L6DMRtNnUj6zHw/P99nkgEHXMdE=;
        b=dDB/1K+SepLHAso8k2WRFdDIhDyJ7oFJdX22dD+Dvy60PfmpTS04pZJaNg+vyaobzp
         Ysef86cBbxfkJCoVKmm612Le90b8F+8aliBH53POOPtAbkBE8u4CrLs4Ij8eoymF6mFv
         XHRVPbLFX1Bwjw9HJqUyZIQ6SZF9Lh4NpT1WC867t9kOX0n1cSVHjQwG4+OpmiZqf0R/
         d/Yb5VmdpQ/HLdX8UbHr4Wco0/5Ah19BZVM8yohnS/aMetMwDNa5Nuo/yonGb/JPpTQD
         /e9QFACadePEYWM76Z/7RmGdFv3Kzp5TqxoZoLMZ0QM3dAu0kW6anHkNa3WP/OFErEWl
         MFBQ==
X-Gm-Message-State: AOJu0YzdK0eO6jqfHSp6lMihSxQS0eCFH/1b8r4Pj8HWZr95FkngBhid
	KwypsbbCHuPgMOTdRYzMeNy9zH00G536HbmraZNEph6bQN5S7dSEsyhP9o8D5Ss85jiDYEev1uv
	+wpqUwukMhw==
X-Google-Smtp-Source: AGHT+IG0VfqF5jYZoKSQY52ujme8HXdeOlHLHU4kOgSMfl7+fh/azEQQyg+z84+eb5EDl8LLTLT6eDzHyV+kyw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:154e:b0:dc7:3189:4e75 with SMTP
 id r14-20020a056902154e00b00dc731894e75mr415653ybu.3.1709654661987; Tue, 05
 Mar 2024 08:04:21 -0800 (PST)
Date: Tue,  5 Mar 2024 16:03:59 +0000
In-Reply-To: <20240305160413.2231423-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240305160413.2231423-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240305160413.2231423-5-edumazet@google.com>
Subject: [PATCH net-next 04/18] net: move ptype_all into net_hotdata
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Soheil Hassas Yeganeh <soheil@google.com>, 
	Neal Cardwell <ncardwell@google.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

ptype_all is used in rx/tx fast paths.

Move it to net_hotdata for better cache locality.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/netdevice.h |  1 -
 include/net/hotdata.h     |  1 +
 net/core/dev.c            | 16 +++++++---------
 net/core/hotdata.c        |  1 +
 net/core/net-procfs.c     |  7 ++++---
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 15ce809e0541078bff7a48b8d7cb2cf2c1ac8a93..e2e7d5a7ef34de165cd293eb71800e1e6b450432 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5300,7 +5300,6 @@ static inline const char *netdev_reg_state(const struct net_device *dev)
 #define PTYPE_HASH_SIZE	(16)
 #define PTYPE_HASH_MASK	(PTYPE_HASH_SIZE - 1)
 
-extern struct list_head ptype_all __read_mostly;
 extern struct list_head ptype_base[PTYPE_HASH_SIZE] __read_mostly;
 
 extern struct net_device *blackhole_netdev;
diff --git a/include/net/hotdata.h b/include/net/hotdata.h
index 149e56528537d8ed3365e46d6dc96e39c73a733a..d462cb8f16bad459b439c566274c01a0f18a95d0 100644
--- a/include/net/hotdata.h
+++ b/include/net/hotdata.h
@@ -7,6 +7,7 @@
 /* Read mostly data used in network fast paths. */
 struct net_hotdata {
 	struct list_head	offload_base;
+	struct list_head	ptype_all;
 	int			gro_normal_batch;
 	int			netdev_budget;
 	int			netdev_budget_usecs;
diff --git a/net/core/dev.c b/net/core/dev.c
index 53ebdb55e8b7c0a6522eb3fdbb7bdd00948eb9a5..119b7004a8e51ea6785c60e558988d369eec8935 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -161,7 +161,6 @@
 
 static DEFINE_SPINLOCK(ptype_lock);
 struct list_head ptype_base[PTYPE_HASH_SIZE] __read_mostly;
-struct list_head ptype_all __read_mostly;	/* Taps */
 
 static int netif_rx_internal(struct sk_buff *skb);
 static int call_netdevice_notifiers_extack(unsigned long val,
@@ -540,7 +539,7 @@ static inline void netdev_set_addr_lockdep_class(struct net_device *dev)
 static inline struct list_head *ptype_head(const struct packet_type *pt)
 {
 	if (pt->type == htons(ETH_P_ALL))
-		return pt->dev ? &pt->dev->ptype_all : &ptype_all;
+		return pt->dev ? &pt->dev->ptype_all : &net_hotdata.ptype_all;
 	else
 		return pt->dev ? &pt->dev->ptype_specific :
 				 &ptype_base[ntohs(pt->type) & PTYPE_HASH_MASK];
@@ -2226,7 +2225,8 @@ static inline bool skb_loop_sk(struct packet_type *ptype, struct sk_buff *skb)
  */
 bool dev_nit_active(struct net_device *dev)
 {
-	return !list_empty(&ptype_all) || !list_empty(&dev->ptype_all);
+	return !list_empty(&net_hotdata.ptype_all) ||
+	       !list_empty(&dev->ptype_all);
 }
 EXPORT_SYMBOL_GPL(dev_nit_active);
 
@@ -2237,10 +2237,9 @@ EXPORT_SYMBOL_GPL(dev_nit_active);
 
 void dev_queue_xmit_nit(struct sk_buff *skb, struct net_device *dev)
 {
-	struct packet_type *ptype;
+	struct list_head *ptype_list = &net_hotdata.ptype_all;
+	struct packet_type *ptype, *pt_prev = NULL;
 	struct sk_buff *skb2 = NULL;
-	struct packet_type *pt_prev = NULL;
-	struct list_head *ptype_list = &ptype_all;
 
 	rcu_read_lock();
 again:
@@ -2286,7 +2285,7 @@ void dev_queue_xmit_nit(struct sk_buff *skb, struct net_device *dev)
 		pt_prev = ptype;
 	}
 
-	if (ptype_list == &ptype_all) {
+	if (ptype_list == &net_hotdata.ptype_all) {
 		ptype_list = &dev->ptype_all;
 		goto again;
 	}
@@ -5387,7 +5386,7 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
 	if (pfmemalloc)
 		goto skip_taps;
 
-	list_for_each_entry_rcu(ptype, &ptype_all, list) {
+	list_for_each_entry_rcu(ptype, &net_hotdata.ptype_all, list) {
 		if (pt_prev)
 			ret = deliver_skb(skb, pt_prev, orig_dev);
 		pt_prev = ptype;
@@ -11771,7 +11770,6 @@ static int __init net_dev_init(void)
 	if (netdev_kobject_init())
 		goto out;
 
-	INIT_LIST_HEAD(&ptype_all);
 	for (i = 0; i < PTYPE_HASH_SIZE; i++)
 		INIT_LIST_HEAD(&ptype_base[i]);
 
diff --git a/net/core/hotdata.c b/net/core/hotdata.c
index 087c4c84987df07f11a87112a778a5cac608a654..29fcfe89fd9a697120f826dbe2fd36a1617581a1 100644
--- a/net/core/hotdata.c
+++ b/net/core/hotdata.c
@@ -7,6 +7,7 @@
 
 struct net_hotdata net_hotdata __cacheline_aligned = {
 	.offload_base = LIST_HEAD_INIT(net_hotdata.offload_base),
+	.ptype_all = LIST_HEAD_INIT(net_hotdata.ptype_all),
 	.gro_normal_batch = 8,
 
 	.netdev_budget = 300,
diff --git a/net/core/net-procfs.c b/net/core/net-procfs.c
index 2e4e96d30ee1a7a51e49587378aab47aed1290da..a97eceb84e61ec347ad132ff0f22c8ce82f12e90 100644
--- a/net/core/net-procfs.c
+++ b/net/core/net-procfs.c
@@ -3,6 +3,7 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <net/wext.h>
+#include <net/hotdata.h>
 
 #include "dev.h"
 
@@ -183,7 +184,7 @@ static void *ptype_get_idx(struct seq_file *seq, loff_t pos)
 		}
 	}
 
-	list_for_each_entry_rcu(pt, &ptype_all, list) {
+	list_for_each_entry_rcu(pt, &net_hotdata.ptype_all, list) {
 		if (i == pos)
 			return pt;
 		++i;
@@ -231,13 +232,13 @@ static void *ptype_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 			}
 		}
 
-		nxt = ptype_all.next;
+		nxt = net_hotdata.ptype_all.next;
 		goto ptype_all;
 	}
 
 	if (pt->type == htons(ETH_P_ALL)) {
 ptype_all:
-		if (nxt != &ptype_all)
+		if (nxt != &net_hotdata.ptype_all)
 			goto found;
 		hash = 0;
 		nxt = ptype_base[0].next;
-- 
2.44.0.278.ge034bb2e1d-goog


