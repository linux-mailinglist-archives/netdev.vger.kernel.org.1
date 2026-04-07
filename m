Return-Path: <netdev+bounces-276173-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8A2UE1N11WlC6gcAu9opvQ
	(envelope-from <netdev+bounces-276173-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 23:21:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC93E3B4F9B
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 23:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A41B3030C92
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 21:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DE637CD51;
	Tue,  7 Apr 2026 21:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IF9v0+Ld"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C17537D116
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 21:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775596822; cv=none; b=egcRziO+qzMLpTC+qEdCQn6pZdfBvmyB0+Pp+ZH94bzAnQNq0YCjQB+/FV/rzbE/NiMt6ntI67BQQdO3L2G71P/w6erXDAARowM+DB3WbEgRJLT0MgFFSfgG1vzlzgNRPvg7v7EViwh/ft9q/JA9I2KMit27IYwDPoWZwJ+xD/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775596822; c=relaxed/simple;
	bh=KFInPZyVLUthzNvmi/R3Uf7OwmS9ujzlVJ3YUfX3vdE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lOwwwljJiaFJbp194V9DgkTsHz56bvlWIrODQdY4f/SVYp0vLcRVdGfA5EF6XU1aQ3yeyMNSZPm7MnK9lYwpWC07HYFJWo+aaQkImlsH8WvVgPjVuq5ATn2CY/0P4X8rIh38RZLKzlvUq6tyoudk01wyMOz9SUCHdAxpwROk8Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IF9v0+Ld; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b249975139so138465945ad.0
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 14:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775596820; x=1776201620; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FyjkmhVqPlkaIkMdwi7y+3jOFUrTS1tOcdHEXBNR4Tg=;
        b=IF9v0+Ld09yNZ71Cdl/7rr1cN05d5R44zChkxaERzz4V7lxTV/fKGyh18ZhZ3huSJn
         3ScX5iuR+rruOYVSjiU9QVStzCYZoPco7Ki6jp3P1RvdhJWyCjboOREbBag+R+FFAM5k
         QPvzn5ZWC76Xw+224Z7s3dTBkcWQf4PGXTRKpuzXi5Mz8UiPxQMhBom4uQQuXhs0SAPw
         HlvpFmSUYkzmzcF629RyTaSz2ZfR2lWhkBV7lJyuYRIfkh4Qitep8E+klr1tiTslymyV
         WVnx/SjiQOrdo5uOhp6Iw8XOrS5SW6E9ky6GzkqacFUoRrM3S9gOgIbNNGXtkb0id24C
         ArIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775596820; x=1776201620;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FyjkmhVqPlkaIkMdwi7y+3jOFUrTS1tOcdHEXBNR4Tg=;
        b=b3N8APUL0qDhwmyLx/jPC5N4JWt94kO8BLTMK+A1iNubng/yKVHsQmGgonOveSNfSq
         BXogzj6nmo5tqcZJa7cVG9nFyH7qT6Lb39BRDhhzmHYDtPLUmnPcMh++t6FHu35/s72A
         sdXM9heYtCzVLG1iwcVDYV1iqq/JakTDsCGRSZoDIjf/VSFYoSNlnQtjA45HAg6tNfDy
         7sZEUd4e0CFLyKROIlu8wQ4Srfha9xsWPJVt4iaLbeVGkuTKfO7pkZI8ScaLi0rgi7G9
         g0Sp3W7gXWpkJyg4adpLrmMQsaCbseZTi3efovoUwdtdGqPgfRprCdRqoNoN0GyXbzws
         NaiA==
X-Forwarded-Encrypted: i=1; AJvYcCWyYrlSU4pkOSMqc54QE0o4jrwHFk3KHVRimKb9L51qyxfRrnEtDWYGbAhhC+20pHcs1vTgrWM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzabfp9QmjdxZ3WnQ9+62j5JefilYoaTyuaGpIUuOVFpzRFcK6m
	hKiQnmOHAnxSU8UOcukJkRc5cdo1NktHWzeo79BGG8rxhjbWdy8CS5jTJ+3pTDZLY2RlNJt7EAm
	iOiN2aw==
X-Received: from plqt2.prod.google.com ([2002:a17:902:a5c2:b0:2b0:6207:5fd3])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2ac4:b0:2b2:56bc:c6bc
 with SMTP id d9443c01a7336-2b2817e852emr209927225ad.40.1775596819739; Tue, 07
 Apr 2026 14:20:19 -0700 (PDT)
Date: Tue,  7 Apr 2026 21:19:43 +0000
In-Reply-To: <20260407212001.2368593-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260407212001.2368593-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260407212001.2368593-11-kuniyu@google.com>
Subject: [PATCH v3 net-next 10/15] ip6mr: Move unregister_netdevice_many() out
 of ip6mr_free_table().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276173-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BC93E3B4F9B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is a prep commit to convert ip6mr_net_exit_batch() to
->exit_rtnl().

Let's move unregister_netdevice_many() in ip6mr_free_table()
to its callers.

Now ip6mr_rules_exit() can do batching all tables per netns.

Note that later we will remove RTNL and unregister_netdevice_many()
in ip6mr_rules_init().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/ip6mr.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index c46f6a430d26..30e1aece5f53 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -85,7 +85,8 @@ static DEFINE_SPINLOCK(mfc_unres_lock);
 static struct kmem_cache *mrt_cachep __read_mostly;
 
 static struct mr_table *ip6mr_new_table(struct net *net, u32 id);
-static void ip6mr_free_table(struct mr_table *mrt);
+static void ip6mr_free_table(struct mr_table *mrt,
+			     struct list_head *dev_kill_list);
 
 static void ip6_mr_forward(struct net *net, struct mr_table *mrt,
 			   struct net_device *dev, struct sk_buff *skb,
@@ -238,6 +239,7 @@ static const struct fib_rules_ops __net_initconst ip6mr_rules_ops_template = {
 static int __net_init ip6mr_rules_init(struct net *net)
 {
 	struct fib_rules_ops *ops;
+	LIST_HEAD(dev_kill_list);
 	struct mr_table *mrt;
 	int err;
 
@@ -262,7 +264,8 @@ static int __net_init ip6mr_rules_init(struct net *net)
 
 err2:
 	rtnl_lock();
-	ip6mr_free_table(mrt);
+	ip6mr_free_table(mrt, &dev_kill_list);
+	unregister_netdevice_many(&dev_kill_list);
 	rtnl_unlock();
 err1:
 	fib_rules_unregister(ops);
@@ -272,12 +275,15 @@ static int __net_init ip6mr_rules_init(struct net *net)
 static void __net_exit ip6mr_rules_exit(struct net *net)
 {
 	struct mr_table *mrt, *next;
+	LIST_HEAD(dev_kill_list);
 
 	ASSERT_RTNL();
 	list_for_each_entry_safe(mrt, next, &net->ipv6.mr6_tables, list) {
 		list_del(&mrt->list);
-		ip6mr_free_table(mrt);
+		ip6mr_free_table(mrt, &dev_kill_list);
 	}
+
+	unregister_netdevice_many(&dev_kill_list);
 	fib_rules_unregister(net->ipv6.mr6_rules_ops);
 }
 
@@ -337,8 +343,12 @@ static int __net_init ip6mr_rules_init(struct net *net)
 
 static void __net_exit ip6mr_rules_exit(struct net *net)
 {
+	LIST_HEAD(dev_kill_list);
+
 	ASSERT_RTNL();
-	ip6mr_free_table(net->ipv6.mrt6);
+	ip6mr_free_table(net->ipv6.mrt6, &dev_kill_list);
+	unregister_netdevice_many(&dev_kill_list);
+
 	net->ipv6.mrt6 = NULL;
 }
 
@@ -403,18 +413,17 @@ static struct mr_table *ip6mr_new_table(struct net *net, u32 id)
 			      ipmr_expire_process, ip6mr_new_table_set);
 }
 
-static void ip6mr_free_table(struct mr_table *mrt)
+static void ip6mr_free_table(struct mr_table *mrt,
+			     struct list_head *dev_kill_list)
 {
 	struct net *net = read_pnet(&mrt->net);
-	LIST_HEAD(dev_kill_list);
 
 	WARN_ON_ONCE(!mr_can_free_table(net));
 
 	timer_shutdown_sync(&mrt->ipmr_expire_timer);
 	mroute_clean_tables(mrt, MRT6_FLUSH_MIFS | MRT6_FLUSH_MIFS_STATIC |
 			    MRT6_FLUSH_MFC | MRT6_FLUSH_MFC_STATIC,
-			    &dev_kill_list);
-	unregister_netdevice_many(&dev_kill_list);
+			    dev_kill_list);
 	rhltable_destroy(&mrt->mfc_hash);
 	kfree(mrt);
 }
-- 
2.53.0.1213.gd9a14994de-goog


