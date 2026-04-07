Return-Path: <netdev+bounces-276175-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAwIFWt11WlC6gcAu9opvQ
	(envelope-from <netdev+bounces-276175-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 23:21:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA97F3B4FA2
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 23:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E93533061571
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 21:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7F537C11D;
	Tue,  7 Apr 2026 21:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S3ggQcI7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F122237D12A
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 21:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775596825; cv=none; b=CEGQ+aCcv9Ql4g+VpFDu+AhRK3xaJDlRmBGQBK6gDm7OJVlkiaPuCaTbQ3pqJmw4+KzFZ2IqRqkzAuHYToPt5WXozBemlD7gzxoLvgbRUcaAxikyy2rGp3ALCDCtV3znQ/ZVB6qsiNfxWmbeVnXSZ+D1HGZfMaewZcvle56QyCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775596825; c=relaxed/simple;
	bh=+VmZAMza3bmu7xZz1pRmdmsCez50aad/cUyMe1EdORI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aZpPOtG64SKpoy3cWoIn5eVwJ1h33OSL5MdB506QeugbqWgvzFZEUEscmUKE2Nca+sKA5W1petCc6Dkqh2pXKKmTZhKZl/veKE1+RyMEOSqN9COas+kCL6BscaZ2oFQyiw6/ztEMqmdO7IXxLYMaRnjjEG7eUfubULG9fA3OZMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S3ggQcI7; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82ce34a78edso7191150b3a.1
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 14:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775596823; x=1776201623; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ySm0xs+e4ZVyVwKVesZyjRNyt0JiYOqLjohh4aCslWU=;
        b=S3ggQcI7Rx56mLo69JYPOFTvCUr+DGIyvokRbNXFAe0KKGSxH9g2OhnoeJoLb2p0hV
         gTmY0u0bH/f2dypDlvOdQerPyvjqCpAQI8jvj/My1soZE84gJiiFsE1t/+V4kFvRdFEZ
         UBC5g18GFydQt5rNhMx3Hg++wlk9Hcbs2mk+rH4+zzbv/eRmkHK+sG1PCvQk8mocA/I5
         5K0LXIAPtjo0BfsyDFpK/7uRIfgq952J103d6kYzygGfAgRRFcERc8IUPxuqwEWzoAw+
         ru+zeYzI8OWNkVxQJ0JbZQE0d1urSPz6W7a1iCel/bS7P2z4Wk3u7P1x8hahaF5CuaYk
         5q/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775596823; x=1776201623;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ySm0xs+e4ZVyVwKVesZyjRNyt0JiYOqLjohh4aCslWU=;
        b=pIB6QWmK+B0GoCl7Poo8fiGFZ6nL9vecyzML3URVB4R7QNNB7XAiZAabXz5J4h8tn/
         N9NVvjLNbgWzya6tN2MdHHES9XHton7g+vEvV72u7HjMJEcDYZ+XK+pCLTO4aqKGuasY
         il1DxS7J4fLeltqapnYcfYUn9/y5L2EJjOecJiGVY8E8l6LGuSqbnGiMp38hMwxWP/AL
         mrdZSRLdqfxZPejB4kg5Xe3u2J/shN5KWuhsRlol7TEMafGepPCPJhTWS/CIPIuospp0
         wICnZvqO0BdUGTcJhuKf0pbmpmwbPlb+OkNO/CGisTifBz8NKdNuFoq/fbMQpyHnIhiw
         ZClg==
X-Forwarded-Encrypted: i=1; AJvYcCWhbOsd7dCseEkCe4LJsZVMrRWwp7AKxifO3b2x2v+70hRl/Cimd2RliesWWmV9D7iJE2tWFmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPw1AzQThVhsa75d4m2NfipEl5e4GmW/r4UI7ygESII+METbD5
	i1L9VUKL3IyU0AS31cOPxT+3e0vpat2PRg3/pI22wYWlX7UDj39rG/n7tNrQxtRovN2Y2kcdfsh
	dqAd/0Q==
X-Received: from pfbdw15.prod.google.com ([2002:a05:6a00:368f:b0:82c:eaa1:7ba])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:140d:b0:82c:bd9d:246
 with SMTP id d2e1a72fcca58-82d0dba8280mr18688991b3a.40.1775596823039; Tue, 07
 Apr 2026 14:20:23 -0700 (PDT)
Date: Tue,  7 Apr 2026 21:19:45 +0000
In-Reply-To: <20260407212001.2368593-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260407212001.2368593-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260407212001.2368593-13-kuniyu@google.com>
Subject: [PATCH v3 net-next 12/15] ip6mr: Remove RTNL in ip6mr_rules_init()
 and ip6mr_net_init().
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
	TAGGED_FROM(0.00)[bounces-276175-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: DA97F3B4FA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When ip6mr_free_table() is called from ip6mr_rules_init() or
ip6mr_net_init(), the netns is not yet published.

Thus, no device should have been registered, and
mroute_clean_tables() will not call mif6_delete(), so
unregister_netdevice_many() is unnecessary.

unregister_netdevice_many() does nothing if the list is empty,
but it requires RTNL due to the unconditional ASSERT_RTNL()
at the entry of unregister_netdevice_many_notify().

Let's remove unnecessary RTNL and ASSERT_RTNL() and instead
add WARN_ON_ONCE() in ip6mr_free_table().

Note that we use a local list for the new WARN_ON_ONCE() because
dev_kill_list passed from ip6mr_rules_exit_rtnl() may have some
devices when other ops->init() fails after ipmr durnig setup_net().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/ip6mr.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 2220a2049781..e5a1d2c48b1b 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -263,10 +263,7 @@ static int __net_init ip6mr_rules_init(struct net *net)
 	return 0;
 
 err2:
-	rtnl_lock();
 	ip6mr_free_table(mrt, &dev_kill_list);
-	unregister_netdevice_many(&dev_kill_list);
-	rtnl_unlock();
 err1:
 	fib_rules_unregister(ops);
 	return err;
@@ -277,7 +274,6 @@ static void __net_exit ip6mr_rules_exit_rtnl(struct net *net,
 {
 	struct mr_table *mrt, *next;
 
-	ASSERT_RTNL();
 	list_for_each_entry_safe(mrt, next, &net->ipv6.mr6_tables, list) {
 		list_del(&mrt->list);
 		ip6mr_free_table(mrt, dev_kill_list);
@@ -343,7 +339,6 @@ static int __net_init ip6mr_rules_init(struct net *net)
 static void __net_exit ip6mr_rules_exit_rtnl(struct net *net,
 					     struct list_head *dev_kill_list)
 {
-	ASSERT_RTNL();
 	ip6mr_free_table(net->ipv6.mrt6, dev_kill_list);
 
 	net->ipv6.mrt6 = NULL;
@@ -414,15 +409,19 @@ static void ip6mr_free_table(struct mr_table *mrt,
 			     struct list_head *dev_kill_list)
 {
 	struct net *net = read_pnet(&mrt->net);
+	LIST_HEAD(ip6mr_dev_kill_list);
 
 	WARN_ON_ONCE(!mr_can_free_table(net));
 
 	timer_shutdown_sync(&mrt->ipmr_expire_timer);
 	mroute_clean_tables(mrt, MRT6_FLUSH_MIFS | MRT6_FLUSH_MIFS_STATIC |
 			    MRT6_FLUSH_MFC | MRT6_FLUSH_MFC_STATIC,
-			    dev_kill_list);
+			    &ip6mr_dev_kill_list);
 	rhltable_destroy(&mrt->mfc_hash);
 	kfree(mrt);
+
+	WARN_ON_ONCE(!net_initialized(net) && !list_empty(&ip6mr_dev_kill_list));
+	list_splice(&ip6mr_dev_kill_list, dev_kill_list);
 }
 
 #ifdef CONFIG_PROC_FS
@@ -1364,10 +1363,7 @@ static int __net_init ip6mr_net_init(struct net *net)
 proc_cache_fail:
 	remove_proc_entry("ip6_mr_vif", net->proc_net);
 proc_vif_fail:
-	rtnl_lock();
 	ip6mr_rules_exit_rtnl(net, &dev_kill_list);
-	unregister_netdevice_many(&dev_kill_list);
-	rtnl_unlock();
 #endif
 ip6mr_rules_fail:
 	ip6mr_notifier_exit(net);
-- 
2.53.0.1213.gd9a14994de-goog


