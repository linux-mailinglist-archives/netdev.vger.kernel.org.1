Return-Path: <netdev+bounces-57077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F310D8120D4
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 22:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 757061F21373
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 21:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4A37F54A;
	Wed, 13 Dec 2023 21:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKJMuNr4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC856CF
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 13:37:52 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5e35405c50cso3130297b3.1
        for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 13:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702503471; x=1703108271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XM6Pl69v5wkej0VvF00V07HT/fcqBvz2sAMb5v8+V3E=;
        b=YKJMuNr4go35kTQ5I14tbFKZtQbqzYXWHIJg9Ndssh/Eg8lmhgCoR9IJEnLyv+BscN
         EMD764Y5t2LhYcp3zcqkqiUIxmnxAGtCi7YtFsOLBK/WAYFjg3NFs5r1zHYO060yKgfK
         Gvh098JSBXScapnj4JGomZZIS0jlGssl8Nzeitk9JGdeBOMJMChko1R2GjvJ3LWe3hCR
         98frDk4Lsh/epxOocBTOLJzItDQPpVcl7kSyEp80/eDIVJlMjlkHrmFbaZrspOQdqt/0
         OcxcefKSxcvZScEHktdKSCUxQoWpANYClwn7+AuqH7kjIrOH4E5Gv3xBqjnPJG05We75
         cXeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702503471; x=1703108271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XM6Pl69v5wkej0VvF00V07HT/fcqBvz2sAMb5v8+V3E=;
        b=Y0aZhm6HudzUT3KPaR/wnNFDdJ9yDY15lG5qWQNdhQeK0D/LeYX4V95Pmebl0hW+ex
         NsOsaNYGWjhX0PSD9M3/lJpwGwDVH3kzgvy0RoJ0yT+G/0OyxxwsrDgJIunzJ7/cWRc5
         wwe4eBpSwQaSxTPs0kCfyvjboq7R3H22VofVVOoAbLxu7Bt6pt8V+Lt5fZY2fDO1YD+F
         EVA0ZDTFPKwzgE3OniznTf5hT216nCuRg4Ok+LZAWteobJwvIqvVb82IgVoWSrI9m90Q
         u0lY3bEdlO5Sa6YJrO/ZSWpUASE4yPQUt7QPVoaqihu5Ff0JdyPahZFjC66CUbAwWpmC
         VFhQ==
X-Gm-Message-State: AOJu0Yzndq5ZXYIti8x7tGfRtfyIOevTyu/XsEGbSFwHoskyHIUbBC2a
	0sv24Xj7t2WMZarWQ0H+EAYyCw7VDVs=
X-Google-Smtp-Source: AGHT+IFeZ5hL8HoRS+k4hnVYtAeuZukQgOf/nVXBrCk8mFgPLDpwJxEAFkoWuFsSLGQCxDy6l6/FrA==
X-Received: by 2002:a0d:e907:0:b0:5d8:9242:47ae with SMTP id s7-20020a0de907000000b005d8924247aemr6613057ywe.19.1702503471498;
        Wed, 13 Dec 2023 13:37:51 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:180e:8c9:1628:87e1])
        by smtp.gmail.com with ESMTPSA id t190-20020a0deac7000000b005e3175fc655sm496799ywe.55.2023.12.13.13.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 13:37:51 -0800 (PST)
From: thinker.li@gmail.com
To: netdev@vger.kernel.org,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	edumazet@google.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>,
	syzbot+c15aa445274af8674f41@syzkaller.appspotmail.com
Subject: [PATCH net-next v3 1/2] net/ipv6: insert a f6i to a GC list only if the f6i is in a fib6_table tree.
Date: Wed, 13 Dec 2023 13:37:34 -0800
Message-Id: <20231213213735.434249-2-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213213735.434249-1-thinker.li@gmail.com>
References: <20231213213735.434249-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

Check f6i->fib6_node and hlist_unhashed(&f6i->gc_link) before inserting a
f6i (fib6_info) to tb6_gc_hlist.

The current implementation checks if f6i->fib6_table is not NULL to
determines if a f6i is on a tree, however it is not enough. When a f6i is
removed from a fib6_table, f6i->fib6_table is not reset. However, fib6_node
is always reset when a f6i is removed from a fib6_table and is set when a
f6i is added to a fib6_table. So, f6i->fib6_node is a reliable way to
determine if a f6i is on a tree.

The current implementation checks RTF_EXPIRES on f6i->fib6_flags to
determine if a f6i is on a GC list. It also consider if the f6i is on a
tree before making a conclusion. This is indirect and complicated. The new
solution is checking hlist_unhashed(&f6i->gc_link), a clear evidence.

Putting them together, these changes provide more reliable signals to
determines if a f6i should be added/or removed to a GC list.

Fixes: 3dec89b14d37 ("net/ipv6: Remove expired routes with a separated list of routes.")
Reported-by: syzbot+c15aa445274af8674f41@syzkaller.appspotmail.com
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: dsahern@kernel.org
---
 include/net/ip6_fib.h | 46 ++++++++++++++++++++++++++++++++-----------
 net/ipv6/route.c      |  6 +++---
 2 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/include/net/ip6_fib.h b/include/net/ip6_fib.h
index 1ba9f4ddf2f6..1213722c394f 100644
--- a/include/net/ip6_fib.h
+++ b/include/net/ip6_fib.h
@@ -500,21 +500,47 @@ void fib6_gc_cleanup(void);
 
 int fib6_init(void);
 
-/* fib6_info must be locked by the caller, and fib6_info->fib6_table can be
- * NULL.
- */
-static inline void fib6_set_expires_locked(struct fib6_info *f6i,
-					   unsigned long expires)
+static inline void fib6_add_gc_list(struct fib6_info *f6i)
 {
 	struct fib6_table *tb6;
 
 	tb6 = f6i->fib6_table;
-	f6i->expires = expires;
-	if (tb6 && !fib6_has_expires(f6i))
+	if (tb6 &&
+	    rcu_dereference_protected(f6i->fib6_node,
+				      lockdep_is_held(&tb6->tb6_lock)) &&
+	    hlist_unhashed(&f6i->gc_link))
 		hlist_add_head(&f6i->gc_link, &tb6->tb6_gc_hlist);
+}
+
+static inline void fib6_del_gc_list(struct fib6_info *f6i)
+{
+	if (!hlist_unhashed(&f6i->gc_link))
+		hlist_del_init(&f6i->gc_link);
+}
+
+static inline void __fib6_set_expires(struct fib6_info *f6i,
+				      unsigned long expires)
+{
+	f6i->expires = expires;
 	f6i->fib6_flags |= RTF_EXPIRES;
 }
 
+static inline void __fib6_clean_expires(struct fib6_info *f6i)
+{
+	f6i->fib6_flags &= ~RTF_EXPIRES;
+	f6i->expires = 0;
+}
+
+/* fib6_info must be locked by the caller, and fib6_info->fib6_table can be
+ * NULL.
+ */
+static inline void fib6_set_expires_locked(struct fib6_info *f6i,
+					   unsigned long expires)
+{
+	__fib6_set_expires(f6i, expires);
+	fib6_add_gc_list(f6i);
+}
+
 /* fib6_info must be locked by the caller, and fib6_info->fib6_table can be
  * NULL.  If fib6_table is NULL, the fib6_info will no be inserted into the
  * list of GC candidates until it is inserted into a table.
@@ -529,10 +555,8 @@ static inline void fib6_set_expires(struct fib6_info *f6i,
 
 static inline void fib6_clean_expires_locked(struct fib6_info *f6i)
 {
-	if (fib6_has_expires(f6i))
-		hlist_del_init(&f6i->gc_link);
-	f6i->fib6_flags &= ~RTF_EXPIRES;
-	f6i->expires = 0;
+	fib6_del_gc_list(f6i);
+	__fib6_clean_expires(f6i);
 }
 
 static inline void fib6_clean_expires(struct fib6_info *f6i)
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index b132feae3393..dcaeb88d73aa 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3763,10 +3763,10 @@ static struct fib6_info *ip6_route_info_create(struct fib6_config *cfg,
 		rt->dst_nocount = true;
 
 	if (cfg->fc_flags & RTF_EXPIRES)
-		fib6_set_expires_locked(rt, jiffies +
-					clock_t_to_jiffies(cfg->fc_expires));
+		__fib6_set_expires(rt, jiffies +
+				   clock_t_to_jiffies(cfg->fc_expires));
 	else
-		fib6_clean_expires_locked(rt);
+		__fib6_clean_expires(rt);
 
 	if (cfg->fc_protocol == RTPROT_UNSPEC)
 		cfg->fc_protocol = RTPROT_BOOT;
-- 
2.34.1


