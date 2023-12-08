Return-Path: <netdev+bounces-55430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B247080AD50
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 20:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CE861C20A79
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 19:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1322D5027E;
	Fri,  8 Dec 2023 19:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYNMJnCp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241681716
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 11:45:32 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5d719a2004fso20823977b3.3
        for <netdev@vger.kernel.org>; Fri, 08 Dec 2023 11:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702064731; x=1702669531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XM6Pl69v5wkej0VvF00V07HT/fcqBvz2sAMb5v8+V3E=;
        b=lYNMJnCpvpJkMt/IQVDaE73jXzv1zL6p1nQTQqVfgC50GMwQVgK0sQ3CNDb9eS3nqH
         X4qw2a1RaV++1B16laZldIyXdI6FuI2zLXGr30TevFavMo6ywcm5VK1Q1xYOthCGBVx2
         Ad8kSTLeI1bvf8AapZv7G+6x9tQhOvNghO+eLj7EhErF0TSsv2wo08m4exlUtOugi40d
         fjvPYSQP41zDdpJiUwl8yy1FNB3W6WYTR/POCdJet+0hcYntdBWZLXmqEIdT+iAvazLM
         q/tVPyTplepnNzeWgLsEscVoM3o2Jg6sbsgtFfflkswaVlloWUlpVXzCUZSm1u18QL5v
         435A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702064731; x=1702669531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XM6Pl69v5wkej0VvF00V07HT/fcqBvz2sAMb5v8+V3E=;
        b=KNQATkfeG2MEw7jflKMvQ1nLx+FOAeGdqGg0305K6yqYseRywU87xsZ38pb8vMWjcr
         MMFr/3zJmb1RSrjFiuUv7xBJ/FVKVwy8dikupCA7b7wVANIKCI/2MOajPd1v+pkpfh3s
         C/3XxspMXXeE5h/94iAM+9cqDxaHfQu1PgBV9uEHilhRh1ytGUxc+qOeUyFGnwlsYmoA
         LMb3Q6hWIR+DegF4bQfjUOPlGfpjT1D0Ocvx37LCeKQpV6vGTRx3ZQgwr7q2jynso5os
         +4ZkjSMSt8VEUU8r8wBMOgXMpGbuCJe68awblT4ij1Gfcz41LgXdH0P2YodIum4UBQGM
         Rxqg==
X-Gm-Message-State: AOJu0Yx0g5GTRahjSu5aijuWiG3uCZrTg08epAtvpE598bHrFt8g/kZo
	P8VxrS59Z8cV7azby5qb8oV672a03bk=
X-Google-Smtp-Source: AGHT+IGF9A9TDlDD6P8XswTt3LOGUsAJ4fTKzJ5FHmXm3nVXI1gv6PJB72oKBeZatgYvY33EIp915w==
X-Received: by 2002:a0d:d401:0:b0:5ca:4db5:cb76 with SMTP id w1-20020a0dd401000000b005ca4db5cb76mr415049ywd.34.1702064730727;
        Fri, 08 Dec 2023 11:45:30 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:65fe:fe26:c15:a05c])
        by smtp.gmail.com with ESMTPSA id w5-20020a0dd405000000b005d23b8a7e1bsm887414ywd.91.2023.12.08.11.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 11:45:30 -0800 (PST)
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
Subject: [PATCH net-next v2 1/2] net/ipv6: insert a f6i to a GC list only if the f6i is in a fib6_table tree.
Date: Fri,  8 Dec 2023 11:45:22 -0800
Message-Id: <20231208194523.312416-2-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208194523.312416-1-thinker.li@gmail.com>
References: <20231208194523.312416-1-thinker.li@gmail.com>
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


