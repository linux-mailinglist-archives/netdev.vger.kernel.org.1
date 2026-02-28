Return-Path: <netdev+bounces-262241-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yL5GKC1qo2mACgUAu9opvQ
	(envelope-from <netdev+bounces-262241-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 23:20:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 153C61C973E
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 23:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8EA6330A6275
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 22:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A6B3D4133;
	Sat, 28 Feb 2026 22:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BdixoFRK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33ACE3D5220
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 22:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772317098; cv=none; b=qQBro0VNIe7RTQ5eJea+tVYbEEkczLxHNJNjKBIsM2pelRT/Xl2DEZY9V1As40jkz5Y6piziFWKNpvUcA4wpW1wGIcVYTXn5fF8OYSynWV8+H+m5zYFKsDHlOXk/CSsLmZL+rOdkJIyF+Ol8A2trZ7etVahG5Ni1pfA/R48OLHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772317098; c=relaxed/simple;
	bh=pkqSvit2/+dtK3MnajdtrtuDmC9DlNrhF2Ffq4eH53Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s6wauwCSZWQCEm3OOxahFuuP+1KJV2BezgcR7Khx0GRmxnuNWnmYdULg0yeidgsPQ0525XdTDZIqMZJZJ0DUMTWDSoq4np1aKIAmiBK89zk5TyaeQflZdz5F8Y22tHZR2z9sk9RkFB2EsMxZoVcFWx5YcRPGHZYQzzeab4bxzE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BdixoFRK; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2adb085735bso33843795ad.1
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 14:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772317097; x=1772921897; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hFwqQru6JOSey0Nu9edEv08dpDfYg41CEJ67TRY90dE=;
        b=BdixoFRK/gTGskVQKGO/Rm2PLQ6rLjZ2Q/6Jp/4wT2WkEKdlS0tccU0mJfKnl7gnBI
         S1UR9hwP5rgkMytZLT/bpjpV6KonQKIM6D4xIneuTiHWPzPIrKScki8BtG3BgGhRS1yX
         BxAk3OKa4pFF5W3pt1oO9tdq8DDyo24WTFC0ePYlESkyeXBxIDDwmMRejL//sjNihYNN
         EuFajjYvx7DNQbmEdYsNhmaE5yUILyuqMugrEDwTu5320g8gw4HjPSIfMUl4IGj3MuY3
         i97dPi4u0IWOR+CmVZmGWEetF3HxRblWpHnQArjC2s7w3fdR/HzKLRPGMjH6DUPcJnWA
         42kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772317097; x=1772921897;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hFwqQru6JOSey0Nu9edEv08dpDfYg41CEJ67TRY90dE=;
        b=ZdGhYvTsJwqUSOOjlXLmmhUPcvOPvu8WCCNVhO4zgPP2Exx3PgfAgNQvdA+73M6eNe
         vFjzh4Zd9Q6VgyHtWGS3zF7Ew3i0HbIivJdHuAbSzSXXBDouq1d00WoOoP2n+aZfmyyF
         LifTBUzyFPQbf8SEyd1mlkz+j6ddiQ3UBX+g/MK/OhffuoQuC8VaRmW9OPAdlYTi+mZI
         BbVeZA0RhdOYKxvHU5QmRZz/7J5sEVDCNGVkp6Dss7x6woL9L4uakyYn67Gs50BRpWhf
         O/l39qguzHPfBrQ6xv/T2SdTYYEiS5qnnrn2AbDh63U8qiKw7VrHWokKtraot4TNBnYI
         Bg/w==
X-Forwarded-Encrypted: i=1; AJvYcCXCiYcw5KBKd3MquKWwcgPcwg8uHVRsLmx2ABnwkm3ERQ8CQiuNM1V21+bwrSBvoQP4uJXkDAg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9W952TIGs4nSIcxl79Itp15+CwYlxIBObLRIIZFIclrt4e7mj
	R5GcRj7CMUo5uu48DkhkVP8GtGxLnTKy+pCwIkmz/+KD8Vd8jlhq9wKB3i58Yd2gdf2Ssh4AE2h
	MaGVidQ==
X-Received: from plko1.prod.google.com ([2002:a17:902:6b01:b0:2a3:1bf9:d25])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4cc:b0:29b:e512:752e
 with SMTP id d9443c01a7336-2ae2e4d650amr75612995ad.47.1772317096462; Sat, 28
 Feb 2026 14:18:16 -0800 (PST)
Date: Sat, 28 Feb 2026 22:17:26 +0000
In-Reply-To: <20260228221800.1082070-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260228221800.1082070-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260228221800.1082070-9-kuniyu@google.com>
Subject: [PATCH v3 net-next 08/15] ipmr: Move unregister_netdevice_many() out
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
	TAGGED_FROM(0.00)[bounces-262241-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 153C61C973E
X-Rspamd-Action: no action

This is a prep commit to convert ipmr_net_exit_batch() to
->exit_rtnl().

Let's move unregister_netdevice_many() in ipmr_free_table()
to its callers.

Now ipmr_rules_exit() can do batching all tables per netns.

Note that later we will remove RTNL and unregister_netdevice_many()
in ipmr_rules_init().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/ipmr.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index d15e05662b09..7e2aa2026f01 100644
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


