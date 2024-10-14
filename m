Return-Path: <netdev+bounces-135302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BDD99D812
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 22:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DC721F22CA3
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 20:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750901D07B5;
	Mon, 14 Oct 2024 20:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="qPsVqyv8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE40614A4E7
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 20:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728937205; cv=none; b=g7BUUw2ifWWUJ5gyqpj1M67LN+0Q0feO3RNTrDKVBUo3KtjAB7V2y+M3mYc4xSnz8DVlzvMYjfoEV2Xgq8BY0N8Vd4Hxxx9Vkp9qiZksHhHjCIVBP6DZ9VSRtVHj8zmvWXNvWngJjM3YKlPd6ZwuDjGY5SvYuELJCAgzZnXXMC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728937205; c=relaxed/simple;
	bh=RnsYEAxS9aSKVRf+jHYwjyPibxxzJbvNksI8Q7bxDio=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bx4LxT6pZ0/EDNBaezYQPz4DdI2omEuy1wmUr2XsUkDsVx4QYV1rCYDE9oy9512/5C4kZPg2PD95fW9Hyj7D5HjYBKGMVArYgmMGp0a7O86VIC3qTX8FBaaJa91zIP1jbJSb8tlSriKvtMUPxPJ7i1hAFceM4fs4HnahEKyN9Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=qPsVqyv8; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728937204; x=1760473204;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SC8LfFEvIVPFonSt4Mk87JG2Y1UhoSWRfCrlu82Kg+o=;
  b=qPsVqyv8rl4No93t/cbeSY5zekqED8LVfvqbn1DqIIMYexfl2wA9J43l
   /2ZeEznjlNyVLs7DH74KfviZNj75b0HyRiPA9Sz9034UK1posv4PtagaD
   Z1mOA/o96wu8HSwX0crwusjX/BlibTEdAQpQDfSIylkQglPsEvwh+nX6E
   o=;
X-IronPort-AV: E=Sophos;i="6.11,203,1725321600"; 
   d="scan'208";a="766497431"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 20:19:57 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:28217]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.23:2525] with esmtp (Farcaster)
 id 54487de2-5efc-4d00-b702-8f4303965587; Mon, 14 Oct 2024 20:19:56 +0000 (UTC)
X-Farcaster-Flow-ID: 54487de2-5efc-4d00-b702-8f4303965587
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 14 Oct 2024 20:19:55 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.101.44) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 14 Oct 2024 20:19:52 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, Jamal Hadi Salim
	<jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
	<jiri@resnulli.us>
Subject: [PATCH v2 net-next 04/11] net: sched: Use rtnl_register_many().
Date: Mon, 14 Oct 2024 13:18:21 -0700
Message-ID: <20241014201828.91221-5-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241014201828.91221-1-kuniyu@amazon.com>
References: <20241014201828.91221-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA002.ant.amazon.com (10.13.139.53) To
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

v2:
  * Add __initconst
  * Use C99 initialisation
---
 net/sched/act_api.c | 13 ++++++++-----
 net/sched/cls_api.c | 25 ++++++++++++++-----------
 net/sched/sch_api.c | 20 ++++++++++++--------
 3 files changed, 34 insertions(+), 24 deletions(-)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 2714c4ed928e..5bbfb83ed600 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -2243,13 +2243,16 @@ static int tc_dump_action(struct sk_buff *skb, struct netlink_callback *cb)
 	return skb->len;
 }
 
+static const struct rtnl_msg_handler tc_action_rtnl_msg_handlers[] __initconst = {
+	{.msgtype = RTM_NEWACTION, .doit = tc_ctl_action},
+	{.msgtype = RTM_DELACTION, .doit = tc_ctl_action},
+	{.msgtype = RTM_GETACTION, .doit = tc_ctl_action,
+	 .dumpit = tc_dump_action},
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
index 17d97bbe890f..7637f979d689 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -4055,6 +4055,19 @@ static struct pernet_operations tcf_net_ops = {
 	.size = sizeof(struct tcf_net),
 };
 
+static const struct rtnl_msg_handler tc_filter_rtnl_msg_handlers[] __initconst = {
+	{.msgtype = RTM_NEWTFILTER, .doit = tc_new_tfilter,
+	 .flags = RTNL_FLAG_DOIT_UNLOCKED},
+	{.msgtype = RTM_DELTFILTER, .doit = tc_del_tfilter,
+	 .flags = RTNL_FLAG_DOIT_UNLOCKED},
+	{.msgtype = RTM_GETTFILTER, .doit = tc_get_tfilter,
+	 .dumpit = tc_dump_tfilter, .flags = RTNL_FLAG_DOIT_UNLOCKED},
+	{.msgtype = RTM_NEWCHAIN, .doit = tc_ctl_chain},
+	{.msgtype = RTM_DELCHAIN, .doit = tc_ctl_chain},
+	{.msgtype = RTM_GETCHAIN, .doit = tc_ctl_chain,
+	 .dumpit = tc_dump_chain},
+};
+
 static int __init tc_filter_init(void)
 {
 	int err;
@@ -4068,17 +4081,7 @@ static int __init tc_filter_init(void)
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
index 2eefa4783879..da2da2ab858b 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -2420,6 +2420,17 @@ static struct pernet_operations psched_net_ops = {
 DEFINE_STATIC_KEY_FALSE(tc_skip_wrapper);
 #endif
 
+static const struct rtnl_msg_handler psched_rtnl_msg_handlers[] __initconst = {
+	{.msgtype = RTM_NEWQDISC, .doit = tc_modify_qdisc},
+	{.msgtype = RTM_DELQDISC, .doit = tc_get_qdisc},
+	{.msgtype = RTM_GETQDISC, .doit = tc_get_qdisc,
+	 .dumpit = tc_dump_qdisc},
+	{.msgtype = RTM_NEWTCLASS, .doit = tc_ctl_tclass},
+	{.msgtype = RTM_DELTCLASS, .doit = tc_ctl_tclass},
+	{.msgtype = RTM_GETTCLASS, .doit = tc_ctl_tclass,
+	 .dumpit = tc_dump_tclass},
+};
+
 static int __init pktsched_init(void)
 {
 	int err;
@@ -2438,14 +2449,7 @@ static int __init pktsched_init(void)
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


