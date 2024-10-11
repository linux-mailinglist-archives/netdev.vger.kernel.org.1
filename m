Return-Path: <netdev+bounces-134708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3938999AE7C
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 00:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8D35282AB6
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 22:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973BB1D1E72;
	Fri, 11 Oct 2024 22:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="FgdbR/7B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1DF1D1E63
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 22:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728684440; cv=none; b=QP0ww9eYPBoXYzXk+JkKtYVI/EJn3RG8CoYXqGzn6vm199OpSxdCoz5IUuDf+2rpXQSH8CgRZXHeSf3LRRst34GOCUft0tHoTmIYB2Px9wsvTc7GT1mv22t6QxfPb3S5K66FpKto/xcJI9hizXzT7FdymhBBFyfsb2pZiE23qBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728684440; c=relaxed/simple;
	bh=kKej4wEfsu9Ih4AohvpGf92dqtsIv9DYjHCN5Fzs5Vk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fAVSjVvxVFjr/GbgixKtf9PMwARDKMyY/E96vYEiE7CSUwaHqF7bqHHo295DFv5nX2t4GrzdJhSxMSvNkSNzCzAmxjkY8ADKEgXbtYJM6+2uKJfX1plv+P/twTI36LLfYQzeYB7lm0XUch8yOa6tOZd+Ri/X0Xn9QTJxmbMhcKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=FgdbR/7B; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728684439; x=1760220439;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gMPSmaYvowTQybNW3dbL1cpGR+FVhe/ZO327TehgmGI=;
  b=FgdbR/7BPDwx7yfBXwDHxXnZx6bsl1QkidLeU04zFRh0TZiEwDX695eQ
   B2CUJnJSsb6riOmP+p/X7rFjsCTyewYmiSKZA7+7+/QyAAzF5sU5J6dKa
   xoMYvwT5XB8U+iNTzJJzEn4/OhAYoSgMKeiYklB7YGvFWc0zqvwuscv7c
   s=;
X-IronPort-AV: E=Sophos;i="6.11,196,1725321600"; 
   d="scan'208";a="434489220"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 22:07:17 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:4125]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.95:2525] with esmtp (Farcaster)
 id 939b7a01-24fd-4eb1-bc53-d290676b618d; Fri, 11 Oct 2024 22:07:15 +0000 (UTC)
X-Farcaster-Flow-ID: 939b7a01-24fd-4eb1-bc53-d290676b618d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 11 Oct 2024 22:07:15 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.100.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 11 Oct 2024 22:07:12 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, Jamal Hadi Salim
	<jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
	<jiri@resnulli.us>
Subject: [PATCH v1 net-next 04/11] net: sched: Use rtnl_register_many().
Date: Fri, 11 Oct 2024 15:05:43 -0700
Message-ID: <20241011220550.46040-5-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241011220550.46040-1-kuniyu@amazon.com>
References: <20241011220550.46040-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA003.ant.amazon.com (10.13.139.105) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will remove rtnl_register() in favour of rtnl_register_many().

When it succeeds, rtnl_register_many() guarantees all rtnetlink types
in the passed array are supported, and there is no chance that a part
of message types is not supported.

Let's use rtnl_register_many() instead.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>
---
 net/sched/act_api.c | 12 +++++++-----
 net/sched/cls_api.c | 24 +++++++++++++-----------
 net/sched/sch_api.c | 18 ++++++++++--------
 3 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 2714c4ed928e..1caaeef90684 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -2243,13 +2243,15 @@ static int tc_dump_action(struct sk_buff *skb, struct netlink_callback *cb)
 	return skb->len;
 }
 
+static const struct rtnl_msg_handler tc_action_rtnl_msg_handlers[] = {
+	{NULL, PF_UNSPEC, RTM_NEWACTION, tc_ctl_action, NULL, 0},
+	{NULL, PF_UNSPEC, RTM_DELACTION, tc_ctl_action, NULL, 0},
+	{NULL, PF_UNSPEC, RTM_GETACTION, tc_ctl_action, tc_dump_action, 0},
+};
+
 static int __init tc_action_init(void)
 {
-	rtnl_register(PF_UNSPEC, RTM_NEWACTION, tc_ctl_action, NULL, 0);
-	rtnl_register(PF_UNSPEC, RTM_DELACTION, tc_ctl_action, NULL, 0);
-	rtnl_register(PF_UNSPEC, RTM_GETACTION, tc_ctl_action, tc_dump_action,
-		      0);
-
+	rtnl_register_many(tc_action_rtnl_msg_handlers);
 	return 0;
 }
 
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 17d97bbe890f..2d9961e6b019 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -4055,6 +4055,18 @@ static struct pernet_operations tcf_net_ops = {
 	.size = sizeof(struct tcf_net),
 };
 
+static const struct rtnl_msg_handler tc_filter_rtnl_msg_handlers[] = {
+	{NULL, PF_UNSPEC, RTM_NEWTFILTER, tc_new_tfilter, NULL,
+	 RTNL_FLAG_DOIT_UNLOCKED},
+	{NULL, PF_UNSPEC, RTM_DELTFILTER, tc_del_tfilter, NULL,
+	 RTNL_FLAG_DOIT_UNLOCKED},
+	{NULL, PF_UNSPEC, RTM_GETTFILTER, tc_get_tfilter, tc_dump_tfilter,
+	 RTNL_FLAG_DOIT_UNLOCKED},
+	{NULL, PF_UNSPEC, RTM_NEWCHAIN, tc_ctl_chain, NULL, 0},
+	{NULL, PF_UNSPEC, RTM_DELCHAIN, tc_ctl_chain, NULL, 0},
+	{NULL, PF_UNSPEC, RTM_GETCHAIN, tc_ctl_chain, tc_dump_chain, 0},
+};
+
 static int __init tc_filter_init(void)
 {
 	int err;
@@ -4068,17 +4080,7 @@ static int __init tc_filter_init(void)
 		goto err_register_pernet_subsys;
 
 	xa_init_flags(&tcf_exts_miss_cookies_xa, XA_FLAGS_ALLOC1);
-
-	rtnl_register(PF_UNSPEC, RTM_NEWTFILTER, tc_new_tfilter, NULL,
-		      RTNL_FLAG_DOIT_UNLOCKED);
-	rtnl_register(PF_UNSPEC, RTM_DELTFILTER, tc_del_tfilter, NULL,
-		      RTNL_FLAG_DOIT_UNLOCKED);
-	rtnl_register(PF_UNSPEC, RTM_GETTFILTER, tc_get_tfilter,
-		      tc_dump_tfilter, RTNL_FLAG_DOIT_UNLOCKED);
-	rtnl_register(PF_UNSPEC, RTM_NEWCHAIN, tc_ctl_chain, NULL, 0);
-	rtnl_register(PF_UNSPEC, RTM_DELCHAIN, tc_ctl_chain, NULL, 0);
-	rtnl_register(PF_UNSPEC, RTM_GETCHAIN, tc_ctl_chain,
-		      tc_dump_chain, 0);
+	rtnl_register_many(tc_filter_rtnl_msg_handlers);
 
 	return 0;
 
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 2eefa4783879..e475f767bcfb 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -2420,6 +2420,15 @@ static struct pernet_operations psched_net_ops = {
 DEFINE_STATIC_KEY_FALSE(tc_skip_wrapper);
 #endif
 
+static const struct rtnl_msg_handler psched_rtnl_msg_handlers[] = {
+	{NULL, PF_UNSPEC, RTM_NEWQDISC, tc_modify_qdisc, NULL, 0},
+	{NULL, PF_UNSPEC, RTM_DELQDISC, tc_get_qdisc, NULL, 0},
+	{NULL, PF_UNSPEC, RTM_GETQDISC, tc_get_qdisc, tc_dump_qdisc, 0},
+	{NULL, PF_UNSPEC, RTM_NEWTCLASS, tc_ctl_tclass, NULL, 0},
+	{NULL, PF_UNSPEC, RTM_DELTCLASS, tc_ctl_tclass, NULL, 0},
+	{NULL, PF_UNSPEC, RTM_GETTCLASS, tc_ctl_tclass, tc_dump_tclass, 0},
+};
+
 static int __init pktsched_init(void)
 {
 	int err;
@@ -2438,14 +2447,7 @@ static int __init pktsched_init(void)
 	register_qdisc(&mq_qdisc_ops);
 	register_qdisc(&noqueue_qdisc_ops);
 
-	rtnl_register(PF_UNSPEC, RTM_NEWQDISC, tc_modify_qdisc, NULL, 0);
-	rtnl_register(PF_UNSPEC, RTM_DELQDISC, tc_get_qdisc, NULL, 0);
-	rtnl_register(PF_UNSPEC, RTM_GETQDISC, tc_get_qdisc, tc_dump_qdisc,
-		      0);
-	rtnl_register(PF_UNSPEC, RTM_NEWTCLASS, tc_ctl_tclass, NULL, 0);
-	rtnl_register(PF_UNSPEC, RTM_DELTCLASS, tc_ctl_tclass, NULL, 0);
-	rtnl_register(PF_UNSPEC, RTM_GETTCLASS, tc_ctl_tclass, tc_dump_tclass,
-		      0);
+	rtnl_register_many(psched_rtnl_msg_handlers);
 
 	tc_wrapper_init();
 
-- 
2.39.5 (Apple Git-154)


