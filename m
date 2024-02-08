Return-Path: <netdev+bounces-70158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CB984DE3C
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 11:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CDE21C28627
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 10:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908396E2CB;
	Thu,  8 Feb 2024 10:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AfG9SoXL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADED6D1DB
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 10:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707387914; cv=none; b=A3E5sV4nFChHlWErhvgEXtzxDNUWglqhhdv1rqBJq5WTDG4WVP8HvxB8/YXxQyyB9Tl0HGQezVTfBg+FwyAUoKo4WA1qVG7ulbkNrJh9JyYB2DZIjpQ1hMzOpNV5UDRytSIoVmlWHtzQTcC0RpuuM6VJxiANkKjcolgX7kLeSHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707387914; c=relaxed/simple;
	bh=cPtFZucvCedpxf5Ba/L4JltWi/dthCXS6w17krS1J/8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EiXCgUOil+CVDEiXx1gMfoN4Cn28Y2MZfPHs+dU72sLPx+u1vPtnICQvim6uGIHG9v3hjZbJVqcQc+4Sokecd78UAz6VCmyeMJ7qzuADNY2T6QX4dfxwcO42XsIVOavmWHnSiMVwD7R4SKW1DNJ+oi3UHspF/lCavubPPMT8zO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AfG9SoXL; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6ade10cb8so1655162276.0
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 02:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707387912; x=1707992712; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ddf28OCLwtCOlt3GsE8jYkboA+yXiIzlsGl65s3DwMw=;
        b=AfG9SoXLxkdEzVj6+dOdnoxB3+T0zZ5kNUd9GG8sJzDFYj9orKtPXb3mWjjMtqh9uW
         lPKVYa1rtYBTkVQlPMwvEWrvzrt7cUXVIPfejgAzFnJhm7mNyIclPzJQJugM8tPPZXAL
         h+7g5wmr01oJAtwLajwz81GoS9QR4mGEKyfvjAcGIsScRYEmOJZj7vGOjJBN0dxb6MJi
         eKMXKXe90fo4qW9rojirt8L9CkAGU8MK3kCeP40+1fbu+ml4MSwVNYH360BJukiAfdMv
         kAEkNlD+Oqt2QjzMUPRaeSTV1L/jzsXprRBBjCARpVMCPIIinTF6vk4xFtUt7p921Sot
         +QbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707387912; x=1707992712;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ddf28OCLwtCOlt3GsE8jYkboA+yXiIzlsGl65s3DwMw=;
        b=oOdrkyftrpeX2bGwTlxE8c9a5LmM7/3RBL6sGUhaIWiWGsgRHNtm0AG85jQXy3N5Q8
         ZFzjnYHQPE/UhdtCXm7VgHOkrntUknB/Z0ksPDnJ39cCSNYRmKaEV7dqvskAgvpjjU5u
         OnkPESJTqZOqemyWZ1hhES5/Tj3KIZ0WUsk0rdhuykaHTCc6ZbDOFwJ7MveR/LHux/aB
         tUoETFF2k/Vnow0v07MYXyU22ATM5zuVcBpSwjDNhhG6Qf+ca36NLOvyzLiqAvHGmFQT
         1YFP6P6S/4+jk0NYn7YdDQzfuyQerMGdyejCkL7xucXCt0QVvI9tuCY5ENvR54Sptg+s
         w5qw==
X-Gm-Message-State: AOJu0YwaMGhLEwVaMAlYDFad+F3/xL8BWOrImUTtTdZ7MSOosqsvRWtS
	/I+D3kK7AGnAYJWaCHDJYCeNnqQ9iQRWSsPrEbK96EoF99wA+yQk/l0pACqLAzPLznC9QKAZ0WP
	eiHCkMtWILA==
X-Google-Smtp-Source: AGHT+IGR61KLyIYWoRgdqBfV9tCpfBZiWfNG7VrhnogXoCJ4xq9NOrLb4zcQvfz2B1Xa/ItOPPoh51JvlZVoSg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:10c1:b0:dc2:2e5c:a21d with SMTP
 id w1-20020a05690210c100b00dc22e5ca21dmr581737ybu.6.1707387911830; Thu, 08
 Feb 2024 02:25:11 -0800 (PST)
Date: Thu,  8 Feb 2024 10:25:07 +0000
In-Reply-To: <20240208102508.262907-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240208102508.262907-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240208102508.262907-2-edumazet@google.com>
Subject: [PATCH net-next 1/2] net/sched: act_api: uninline tc_action_net_init()
 and tc_action_net_exit()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

tc_action_net_init() and tc_action_net_exit() are slow path,
and quite big.

tcf_idrinfo_destroy() becomes static.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/act_api.h | 33 ++-------------------------------
 net/sched/act_api.c   | 36 +++++++++++++++++++++++++++++++++---
 2 files changed, 35 insertions(+), 34 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index 77ee0c657e2c78276ecb2efca7f4c3d28be511a2..8ec97644edf86d5d95960b74b9b57908ca19a198 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -146,39 +146,10 @@ struct tc_action_net {
 	const struct tc_action_ops *ops;
 };
 
-static inline
 int tc_action_net_init(struct net *net, struct tc_action_net *tn,
-		       const struct tc_action_ops *ops)
-{
-	int err = 0;
-
-	tn->idrinfo = kmalloc(sizeof(*tn->idrinfo), GFP_KERNEL);
-	if (!tn->idrinfo)
-		return -ENOMEM;
-	tn->ops = ops;
-	tn->idrinfo->net = net;
-	mutex_init(&tn->idrinfo->lock);
-	idr_init(&tn->idrinfo->action_idr);
-	return err;
-}
-
-void tcf_idrinfo_destroy(const struct tc_action_ops *ops,
-			 struct tcf_idrinfo *idrinfo);
-
-static inline void tc_action_net_exit(struct list_head *net_list,
-				      unsigned int id)
-{
-	struct net *net;
-
-	rtnl_lock();
-	list_for_each_entry(net, net_list, exit_list) {
-		struct tc_action_net *tn = net_generic(net, id);
+		       const struct tc_action_ops *ops);
 
-		tcf_idrinfo_destroy(tn->ops, tn->idrinfo);
-		kfree(tn->idrinfo);
-	}
-	rtnl_unlock();
-}
+void tc_action_net_exit(struct list_head *net_list, unsigned int id);
 
 int tcf_generic_walker(struct tc_action_net *tn, struct sk_buff *skb,
 		       struct netlink_callback *cb, int type,
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 9ee622fb1160fe5de8df9a5fca0c9a412e40e31a..9492eae0ebe5844419e1631122871d19b443bc4e 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -886,8 +886,24 @@ int tcf_idr_check_alloc(struct tc_action_net *tn, u32 *index,
 }
 EXPORT_SYMBOL(tcf_idr_check_alloc);
 
-void tcf_idrinfo_destroy(const struct tc_action_ops *ops,
-			 struct tcf_idrinfo *idrinfo)
+int tc_action_net_init(struct net *net, struct tc_action_net *tn,
+		       const struct tc_action_ops *ops)
+{
+	int err = 0;
+
+	tn->idrinfo = kmalloc(sizeof(*tn->idrinfo), GFP_KERNEL);
+	if (!tn->idrinfo)
+		return -ENOMEM;
+	tn->ops = ops;
+	tn->idrinfo->net = net;
+	mutex_init(&tn->idrinfo->lock);
+	idr_init(&tn->idrinfo->action_idr);
+	return err;
+}
+EXPORT_SYMBOL(tc_action_net_init);
+
+static void tcf_idrinfo_destroy(const struct tc_action_ops *ops,
+				struct tcf_idrinfo *idrinfo)
 {
 	struct idr *idr = &idrinfo->action_idr;
 	struct tc_action *p;
@@ -904,7 +920,21 @@ void tcf_idrinfo_destroy(const struct tc_action_ops *ops,
 	}
 	idr_destroy(&idrinfo->action_idr);
 }
-EXPORT_SYMBOL(tcf_idrinfo_destroy);
+
+void tc_action_net_exit(struct list_head *net_list, unsigned int id)
+{
+	struct net *net;
+
+	rtnl_lock();
+	list_for_each_entry(net, net_list, exit_list) {
+		struct tc_action_net *tn = net_generic(net, id);
+
+		tcf_idrinfo_destroy(tn->ops, tn->idrinfo);
+		kfree(tn->idrinfo);
+	}
+	rtnl_unlock();
+}
+EXPORT_SYMBOL(tc_action_net_exit);
 
 static LIST_HEAD(act_base);
 static DEFINE_RWLOCK(act_mod_lock);
-- 
2.43.0.594.gd9cf4e227d-goog


