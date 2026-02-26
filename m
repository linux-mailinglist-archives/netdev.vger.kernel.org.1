Return-Path: <netdev+bounces-261131-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCKwKWKyn2kpdQQAu9opvQ
	(envelope-from <netdev+bounces-261131-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 03:39:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B241A0289
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 03:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29B2E308CBD9
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 02:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0736B37AA91;
	Thu, 26 Feb 2026 02:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GeL+x/+6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1B1379989
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 02:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772073414; cv=none; b=fyRLuAABz2V1Je1qroIlyMuvZeGFZNKNYO1u8mTM5/W66N8JKd2wIhGx+hnB9N5vsvLtF3kSEpPG4GmMHoggPnxaCWj1DnD2VwQsNgDBE+Y9rxb5i12cTdWhZxQJnedhJ1XHTo3/UBr4CKuBk7LsxSRYp1AqKKftffeV7Kco99w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772073414; c=relaxed/simple;
	bh=7Dp22PT2REYV7mL5g+skF0dNqlhewD9NLzXsc1G04Wg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hlbR39l7cev7OhKML//5IsiYMo0APpYZMClbIe6k0ers/0PAnhNAgRkxXmtEIcqTBoeyrrqTnHptv8QlHhgwKqmkIUsKpG4uElfgaK6G8mQVIuMiKKFLStF4K2jS9pKOEYapYxhodlZLH03f77rBfTajTrznFoN5slB0XjCnaDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GeL+x/+6; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-358dc09b43eso226726a91.2
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 18:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772073413; x=1772678213; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SOwY6yXM1AqszG1TinrrQ0HCBbO1yATydk1s/TYbG+M=;
        b=GeL+x/+6Vb+nYtRZSVUAjrdcg/UH8DRMWvA9+5w3rZ1Q8crwv+eUCwSz64GXmMM40P
         dH2Mdx1/ZmdbEsmlY1AXi5W73wPUyaNFZPFmyr6YvhT0z55Dos7Ck1y15CYQ/3O4WUPM
         jnpMp5S0r5oPntyX4CYNdj2R7F3AsowsxeKE0/gasJK56DLnOm9qix9pba7bTSDl+Sv+
         3sy2MFwH5+3F7PMbeLPlq7jzydl2Ltp3Xa9UtXZELthHMn2bf+h9GdUANI4dmr+sLX/n
         5xXT/3lGeyaZWGM+GCM7+XDbl8qAPyZr1qosnVKBZnkvK63ftwfz8RKSa5wWXrA8Vbz2
         ZuTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772073413; x=1772678213;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SOwY6yXM1AqszG1TinrrQ0HCBbO1yATydk1s/TYbG+M=;
        b=fcFqywJXa/uhHNE6C0jK15SSIn9tUN5W8qlupI/K/sg1QyxW9eaO7MjN+8vq8+7LAo
         qX+xMSH+C/qgn73ERm6AxWk96r/H7AaVCXcIADeJNXJ0tRzI9dTJ2i83Mp2D6DmWe17S
         W0ewbJZJR/9tD9HhJ4AqLjAH66bbH7ucdR9ESBuj12dQI2MlxK5NeyatJU407GguyrRI
         39h5G8SuuqjHdbrM8tcQVxgfA8OYSgkobvfwEqmn4B371HHl3+oy4FzmLsR/cUqKhalF
         hw0jGDTw5bMN903Fa92iP+Dj+lnco29IBEa6ymDqKUlQG2wiLoTazH0WRx+84SxsFp43
         y9Ew==
X-Forwarded-Encrypted: i=1; AJvYcCVoPo7Orhn3C9pB1reYrXvu2nYpUneF7zTSJMoD3pdAC2qY6bItxPEnGV8FHyfE3aFZE0fy8CI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxQVWDjhyzbszHAGcckbmcSOACj/IUj1qACOBTGCZZf6+rq5uc
	h0eqESpN2VVkhieqnFET5ntYknGqDuSKxXH7xQaTqcowXZ5z+QeEdySXDWs9qLiiRbgQ+kZSnS/
	4oez+zA==
X-Received: from pjyv2.prod.google.com ([2002:a17:90a:e982:b0:359:e2a:cdb8])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3807:b0:33f:eca0:47c6
 with SMTP id 98e67ed59e1d1-35928c22b38mr2387544a91.30.1772073413076; Wed, 25
 Feb 2026 18:36:53 -0800 (PST)
Date: Thu, 26 Feb 2026 02:35:20 +0000
In-Reply-To: <20260226023637.1335854-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260226023637.1335854-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260226023637.1335854-9-kuniyu@google.com>
Subject: [PATCH v1 net-next 08/15] ipmr: Move unregister_netdevice_many() out
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261131-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 21B241A0289
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
index f8bbb88f5784..3fb50307fc2f 100644
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
2.53.0.414.gf7e9f6c205-goog


