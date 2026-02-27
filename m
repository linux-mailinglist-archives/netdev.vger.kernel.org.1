Return-Path: <netdev+bounces-261706-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBmHHHUSoWlwqAQAu9opvQ
	(envelope-from <netdev+bounces-261706-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 04:41:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DDED41B2565
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 04:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8DB030E6CAB
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 03:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7F5332EDA;
	Fri, 27 Feb 2026 03:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Umb0qjJ+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60F9332EA0
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 03:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772163565; cv=none; b=uVbv4KJKoEqquch0d+Y75qp84Tq+FxbfZ9r29JLd2Eem41JQTtlsf2vWYi/4Mh5IahqY5qKroaLODmeJJVYUNe/aJhgGmxv4ph7BTS1KCFMmFaWfgUKSsbxhlGwdsCN8ws8QcU8UOOCNb3Q3z7S5vKUlczeS+nsJMZGut/7ebXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772163565; c=relaxed/simple;
	bh=IomPhwa77ahmO7eMHVoETPwM9lQp+ZOTdBt6YGY99iQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SJHKXtLR+7cjzjOs3jYTvxDgyzczCDGWOcaDUV9f/TUGcuzasdrGBI1f1H9LgcMKa+OSDaoVBHgPtmbNyBKMZkgk7cAwStCUO19b2xcaMsJP/eQdR6ATMHVGuFRPtvMdH0smIoldVHYdocH30HNH4EVE3wRRjwuQrmVEwXRsG6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Umb0qjJ+; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2adad0625d1so95626985ad.0
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 19:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772163563; x=1772768363; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=85uKKkA8AWhvvjmdlM3MCYCZPnjUCjB9hF39Ru2WRdc=;
        b=Umb0qjJ+F1kbatPbzgapDzJk/htw3zocH1QzAqALzAAfZzfqVXp+pwofQ+COEvuUhG
         wYA3UT+fG0Ly8PMF/sIsYDITN1z0kiPtWm62BXn5+vfdVhfH7pVIZYrOaLIW2Arrzwey
         WajXTQQYN59HEKRnZo6L0S6FNcmtA2iheBIKcdtzB/f47BXJTcktxyWSQe8xt+WQhvqG
         54f4uRpVOYv5mEihhySW0orfiZ2gB+QA5/kklQBM/V4bM4QLVgmiKgVfZeJJEgFTPQij
         nqn+SbP0qN1YPxHTleMBU1yBqt53MyokvzNyE9t+QOFi1UeMjf7wgCzbiis2aKAhwtTH
         +yOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772163563; x=1772768363;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=85uKKkA8AWhvvjmdlM3MCYCZPnjUCjB9hF39Ru2WRdc=;
        b=vmuRx5MFDaFUnTWhJEG0Q6GyQXXiWFTTpFwfv4bS528IVdb+xFlGAPOhVXP8Nhp6Xr
         +oC2kOj0sC2VafXxYxn7tUKzYlJgxQih388c2rHfyFRtN2ZGP3IAEKIvejHZd1Mr1IZg
         QECyJsXQnBqRqbhJPSCybYRInnioF6piTzNXXM8KG03Dw3TFKos4wUM0c1SLKb0RLNDk
         zrLXrzGGUeg6CyZ95Sx1L+ZIDlLYgACZr20R4DsjE5kXMbEvP5N7LfuI4etN9V5Nxi8m
         6U/V6kXmpsQE1tD5LrmJmtwUFVfDbQM/dhJj5eoj8/Ts1b3lh7+sJER5H7k5qus3Evua
         sq7g==
X-Forwarded-Encrypted: i=1; AJvYcCV5SmnU/YF1Zq6hBPcc2o9EKjODf+p/1mBcsVpiJRh0ie0+KmeQppvQHDzja96mNyiDA00cB/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxEWuZkd4ImLue7VdSqIry+qo+chaZDQmiL7pqtDc2vWhQYXNB
	fX8jdchbRLULmm4xXyj43D7mGATtKefo+Gn+FeTOM3WLfE5+YPMkF83vcbkcn7KRi5++RKVU9KI
	499EvxA==
X-Received: from plbkt13.prod.google.com ([2002:a17:903:88d:b0:2ad:5a23:794e])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:4b07:b0:2aa:e574:c9f7
 with SMTP id d9443c01a7336-2ae2e4fd80bmr10832545ad.57.1772163563164; Thu, 26
 Feb 2026 19:39:23 -0800 (PST)
Date: Fri, 27 Feb 2026 03:38:33 +0000
In-Reply-To: <20260227033903.3307272-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260227033903.3307272-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260227033903.3307272-11-kuniyu@google.com>
Subject: [PATCH v2 net-next 10/15] ipmr: Remove RTNL in ipmr_rules_init() and ipmr_net_init().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261706-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DDED41B2565
X-Rspamd-Action: no action

When ipmr_free_table() is called from ipmr_rules_init() or
ipmr_net_init(), the netns is not yet published.

Thus, no device should have been registered, and
mroute_clean_tables() will not call vif_delete(), so
unregister_netdevice_many() is unnecessary.

unregister_netdevice_many() does nothing if the list is empty,
but it requires RTNL due to the unconditional ASSERT_RTNL()
at the entry of unregister_netdevice_many_notify().

Let's remove unnecessary RTNL and ASSERT_RTNL() and instead
add WARN_ON_ONCE() in ipmr_free_table().

Note that we use a local list for the new WARN_ON_ONCE() because
dev_kill_list passed from ipmr_rules_exit_rtnl() may have some
devices when other ops->init() fails after ipmr durnig setup_net().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2: Use a local list in ipmr_free_table()
---
 net/ipv4/ipmr.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index d12e08c99518..354e7dd1f374 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -276,10 +276,7 @@ static int __net_init ipmr_rules_init(struct net *net)
 	return 0;
 
 err2:
-	rtnl_lock();
 	ipmr_free_table(mrt, &dev_kill_list);
-	unregister_netdevice_many(&dev_kill_list);
-	rtnl_unlock();
 err1:
 	fib_rules_unregister(ops);
 	return err;
@@ -290,7 +287,6 @@ static void __net_exit ipmr_rules_exit_rtnl(struct net *net,
 {
 	struct mr_table *mrt, *next;
 
-	ASSERT_RTNL();
 	list_for_each_entry_safe(mrt, next, &net->ipv4.mr_tables, list) {
 		list_del(&mrt->list);
 		ipmr_free_table(mrt, dev_kill_list);
@@ -355,8 +351,6 @@ static int __net_init ipmr_rules_init(struct net *net)
 static void __net_exit ipmr_rules_exit_rtnl(struct net *net,
 					    struct list_head *dev_kill_list)
 {
-	ASSERT_RTNL();
-
 	ipmr_free_table(net->ipv4.mrt, dev_kill_list);
 
 	net->ipv4.mrt = NULL;
@@ -436,15 +430,19 @@ static struct mr_table *ipmr_new_table(struct net *net, u32 id)
 static void ipmr_free_table(struct mr_table *mrt, struct list_head *dev_kill_list)
 {
 	struct net *net = read_pnet(&mrt->net);
+	LIST_HEAD(ipmr_dev_kill_list);
 
 	WARN_ON_ONCE(!mr_can_free_table(net));
 
 	timer_shutdown_sync(&mrt->ipmr_expire_timer);
 	mroute_clean_tables(mrt, MRT_FLUSH_VIFS | MRT_FLUSH_VIFS_STATIC |
 			    MRT_FLUSH_MFC | MRT_FLUSH_MFC_STATIC,
-			    dev_kill_list);
+			    &ipmr_dev_kill_list);
 	rhltable_destroy(&mrt->mfc_hash);
 	kfree(mrt);
+
+	WARN_ON_ONCE(!net_initialized(net) && !list_empty(&ipmr_dev_kill_list));
+	list_splice(&ipmr_dev_kill_list, dev_kill_list);
 }
 
 /* Service routines creating virtual interfaces: DVMRP tunnels and PIMREG */
@@ -3287,10 +3285,7 @@ static int __net_init ipmr_net_init(struct net *net)
 proc_cache_fail:
 	remove_proc_entry("ip_mr_vif", net->proc_net);
 proc_vif_fail:
-	rtnl_lock();
 	ipmr_rules_exit_rtnl(net, &dev_kill_list);
-	unregister_netdevice_many(&dev_kill_list);
-	rtnl_unlock();
 #endif
 ipmr_rules_fail:
 	ipmr_notifier_exit(net);
-- 
2.53.0.473.g4a7958ca14-goog


