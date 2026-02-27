Return-Path: <netdev+bounces-261704-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Pw3MlwSoWlwqAQAu9opvQ
	(envelope-from <netdev+bounces-261704-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 04:41:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC501B2556
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 04:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0757C3131A20
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 03:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E033328EA;
	Fri, 27 Feb 2026 03:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DjoSlBRD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D2D33342D
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 03:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772163561; cv=none; b=uFG6gYICfLMcy7MkTPztpoOuB2t+tpuOCYkn/bl2Y5lBKnnWlEZbuwJfAlbCLHw/2JYnPMtNMeKdn94Pj6490PBqxGdDfiFaRf5njSoBpQbu8NNXtxv8hfhP6XjIzb7cfEYKWDcbwKq9zCPiGYLIIYiA2gJehfTZH6w3FAL+TOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772163561; c=relaxed/simple;
	bh=s2+d3AzFYv/Z8CAc2/o0JjwzNHGcZZlS3PfywqhIgzI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NeAue86UFhEidvv8p+/FQCaKHlMninL6rkKSu8lJymbUXvj9b7xpPIzBNwmYXdNI0KgJepBXBBW8JohHcoF6/wwiP72KjJmlQqCa83G1r/y+3ep2KQFWCebMsX+LhZl39dg9Qe1ZaoSxuz9GUxS1M0jjdRaBSx+wfyAEesrquzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DjoSlBRD; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2aaeafeadbcso16428355ad.1
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 19:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772163560; x=1772768360; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l1gtzPbqqYm/YoXkm+N1YOGFncKqUoN3d1OP23ZC9Nw=;
        b=DjoSlBRDmJ3pQCuqiGBqKxtnW4U/Nv6t9umt5Mku3//AxuuTkeMIp278STimcYmNIz
         H8oWj9/odHl13z0XMZgUlJqiO4HQhibYmUJ7FO2I8hCec0TXe28nhN0X3qA3wtoEzmsf
         RPWWE78KKtQVvDGBXPHiBPJD6g+YaWwvVIjWpv4tmVHgZdHR37X6cvF4AyzWjDSU8Nhu
         lVooT0qpzjhftG7Z/s8GT+f3WqNmOwZDXkhjGU5UgXK18AuGqgUVdNpAX39UUTa3UAfo
         7muBEtVX5gRkKDjFzJubExNYQ2CP00LtNhwf6+3SeMexhUmH/ja7GC+nJXCNKZrGXAff
         30MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772163560; x=1772768360;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l1gtzPbqqYm/YoXkm+N1YOGFncKqUoN3d1OP23ZC9Nw=;
        b=faXSYZk8XO6f154mLHWk3ebZG4ZBtaLlZZe+bMygOdpVBvfwAnanXDiTMIWNYMTwNS
         ilPnWoltr+Mmv2Ts00UHUxuZGgcEjd+0xm4LlBl79w133+CYWGXDiHlkK/WxGB8OKvmV
         vGOdBHZ5KZX6H3vnf23YhwsqkYJQLcPQkqHhhfpRoifZmJ7jFEmonBjKRxcJ47OEpazP
         cMuE9ShmIlLkD/KfPSyZHNoVuTwx/+JTHAy0sEAoJGvz4KGnr5fMYBfiSX4MB8658yCj
         t5UoRrVdjRlv7OCEjXbSCjEaQCshTb/vQRYWnGvzZRCAFL7zUK5z/Ge8VpC9wJqxOdyg
         GvZw==
X-Forwarded-Encrypted: i=1; AJvYcCVdvUl6987BWXGSe2D3Pvoe7dDdhXzl6C28ehUI0fu779A4a11qtnnCnQ6yBDo7Em7TpWKU6A0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0LI/uRnx4yLm1En5N4adXVw/w3+LQlTOolOG65ljVEJFpUTr3
	DCdVEIHRV+MSPCRv5VxcBV+OaEevYjSe6bYGwmV6fELtQHGCaNN7V4uVo/pXZM/g9r4U4n499Je
	gjazVlA==
X-Received: from plbka13.prod.google.com ([2002:a17:903:334d:b0:2aa:1fa9:23b9])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1aa3:b0:2ad:c66d:ad06
 with SMTP id d9443c01a7336-2ae2e4d603dmr13399255ad.47.1772163559675; Thu, 26
 Feb 2026 19:39:19 -0800 (PST)
Date: Fri, 27 Feb 2026 03:38:31 +0000
In-Reply-To: <20260227033903.3307272-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260227033903.3307272-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260227033903.3307272-9-kuniyu@google.com>
Subject: [PATCH v2 net-next 08/15] ipmr: Move unregister_netdevice_many() out
 of ipmr_free_table().
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
	TAGGED_FROM(0.00)[bounces-261704-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: EEC501B2556
X-Rspamd-Action: no action

This is a prep commit to convert ipmr_net_exit_batch() to
->exit_rtnl().

Let's move unregister_netdevice_many() in ipmr_free_table()
to its callers.

Now ipmr_rules_exit() can do batching all tables per netns.

Note that later we will remove RTNL and unregister_netdevice_many()
in ipmr_rules_init().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/ipmr.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 64c73bf7389f..766668ec5183 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -102,7 +102,8 @@ static DEFINE_SPINLOCK(mfc_unres_lock);
 static struct kmem_cache *mrt_cachep __ro_after_init;
 
 static struct mr_table *ipmr_new_table(struct net *net, u32 id);
-static void ipmr_free_table(struct mr_table *mrt);
+static void ipmr_free_table(struct mr_table *mrt,
+			    struct list_head *dev_kill_list);
 
 static void ip_mr_forward(struct net *net, struct mr_table *mrt,
 			  struct net_device *dev, struct sk_buff *skb,
@@ -251,6 +252,7 @@ static const struct fib_rules_ops __net_initconst ipmr_rules_ops_template = {
 static int __net_init ipmr_rules_init(struct net *net)
 {
 	struct fib_rules_ops *ops;
+	LIST_HEAD(dev_kill_list);
 	struct mr_table *mrt;
 	int err;
 
@@ -275,7 +277,8 @@ static int __net_init ipmr_rules_init(struct net *net)
 
 err2:
 	rtnl_lock();
-	ipmr_free_table(mrt);
+	ipmr_free_table(mrt, &dev_kill_list);
+	unregister_netdevice_many(&dev_kill_list);
 	rtnl_unlock();
 err1:
 	fib_rules_unregister(ops);
@@ -285,12 +288,15 @@ static int __net_init ipmr_rules_init(struct net *net)
 static void __net_exit ipmr_rules_exit(struct net *net)
 {
 	struct mr_table *mrt, *next;
+	LIST_HEAD(dev_kill_list);
 
 	ASSERT_RTNL();
 	list_for_each_entry_safe(mrt, next, &net->ipv4.mr_tables, list) {
 		list_del(&mrt->list);
-		ipmr_free_table(mrt);
+		ipmr_free_table(mrt, &dev_kill_list);
 	}
+
+	unregister_netdevice_many(&dev_kill_list);
 	fib_rules_unregister(net->ipv4.mr_rules_ops);
 }
 
@@ -349,8 +355,13 @@ static int __net_init ipmr_rules_init(struct net *net)
 
 static void __net_exit ipmr_rules_exit(struct net *net)
 {
+	LIST_HEAD(dev_kill_list);
+
 	ASSERT_RTNL();
-	ipmr_free_table(net->ipv4.mrt);
+
+	ipmr_free_table(net->ipv4.mrt, &dev_kill_list);
+	unregister_netdevice_many(&dev_kill_list);
+
 	net->ipv4.mrt = NULL;
 }
 
@@ -425,18 +436,16 @@ static struct mr_table *ipmr_new_table(struct net *net, u32 id)
 			      ipmr_expire_process, ipmr_new_table_set);
 }
 
-static void ipmr_free_table(struct mr_table *mrt)
+static void ipmr_free_table(struct mr_table *mrt, struct list_head *dev_kill_list)
 {
 	struct net *net = read_pnet(&mrt->net);
-	LIST_HEAD(dev_kill_list);
 
 	WARN_ON_ONCE(!mr_can_free_table(net));
 
 	timer_shutdown_sync(&mrt->ipmr_expire_timer);
 	mroute_clean_tables(mrt, MRT_FLUSH_VIFS | MRT_FLUSH_VIFS_STATIC |
 			    MRT_FLUSH_MFC | MRT_FLUSH_MFC_STATIC,
-			    &dev_kill_list);
-	unregister_netdevice_many(&dev_kill_list);
+			    dev_kill_list);
 	rhltable_destroy(&mrt->mfc_hash);
 	kfree(mrt);
 }
-- 
2.53.0.473.g4a7958ca14-goog


