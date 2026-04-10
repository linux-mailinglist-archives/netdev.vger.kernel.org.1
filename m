Return-Path: <netdev+bounces-277585-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBtgI0hp2Wn5pQgAu9opvQ
	(envelope-from <netdev+bounces-277585-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 23:19:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3F23DCD32
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 23:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BB7F2301D484
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 21:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41923AF663;
	Fri, 10 Apr 2026 21:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M/YeH/0S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0567A3B27DE
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 21:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775855869; cv=none; b=ba5EACOWCKGlKji1JlorCcajyuV9C4Uy+u8NCOsfAfD4pVtlR3U2upxjhqEZofB0y00uchHTni3H0Rr146S6qZRLCpuBA88LutQFkBN5keSTn4z8/0d0Ui0pmAfBjCELU85hWuwdfGODfw3mnvpZ+hBN49cCfipcGPiAUFWtkbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775855869; c=relaxed/simple;
	bh=k2x9TMyIQBhC9wov2lvehh9vRM0e74z3YMhHyTc484M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NfjFjwoSOW+5uyownRszmWqWnV/FqAtpnDbNO5AFzFYq8sVWkE7PPbTz641L9nQG4i0xAcsUcVF5+WzFPbUYW80mTYK2zLMuFILU2vALZVDjnPaoWFMRdjCV6NAvEvz4Ue9rL7++Nf5uqp6DVy40wAU864FY88l0V6EmZsZ5TpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M/YeH/0S; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b242cbb97aso19374795ad.1
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 14:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775855867; x=1776460667; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1SZrmOwe1ZKmgoayGFqmTXCHDPc2vmGRNnZRHExVJN4=;
        b=M/YeH/0SHFFZzTmFS0Bcd4HBTNYTeTibwNG9JkQyzx15/WyhRY1K9N2y9DlPmojykP
         9xndyBk1NiYBb+tkpJlP1k8vmtMAd37uYnVYnp+6i/m+hai0XJHncN/uqzBg9TUm2Irk
         bj4icpKlU3jlEYZ7sddsA6zDNA1FXQ64Lyh8Rx5eYemdImE4r4fuOs/4an3A+QVNSzMG
         odcvPlU20nP7kL8Gb2WpvDXk5YsfHUqn7mCTaKK9vpaeeH+U+OvXhh9ZqPWLCExdosNi
         h+7sS5eYL1Elb+/TeFnK/qG1my14FScety/0C4DU0aNobCL/o48k+HO2k24UG+/6Pv1T
         PGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775855867; x=1776460667;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1SZrmOwe1ZKmgoayGFqmTXCHDPc2vmGRNnZRHExVJN4=;
        b=aXNkfz+PWaiQI2MDt20RlX97OW85oXh/wMPtqIHpu8RyuzfX8WiPTxswBKQcIc0qGG
         dV85yaSnP/uDWZXfBGAsynKX1RjsrzjEzLgy95YokIShU+nsv1MYispuZPJE4nT95Bmq
         rMLfE7J9P3tw976cPHEV0Vc8IjeqZcc7uzm4ZQ1Bus2CUjBDElULm+Eg+i2DIOC8PGo4
         POP7+2pYtxmUwVh9nVcpJbnUp0gkwrCNYXMxZ6789hXUBM30YGNxHY//ZW0XTj756sZE
         ANDQkBi4EUGsGAUs6IKbcSnTBJPHxrvvA00uLiKbIccTH0M4qDZVbeEQfgmW/6IozNtC
         ifaQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4jVQaw2AmHk33zgrntScI1H+2CSsd6lsw68DDA2ZpQz/wYy0halWUXVpTaRBUUXoSEWZTzH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKf4zW/MWMH9IJWRr1yl0lxRMqOaHH+7+0aey/cHeVicZ2ovjQ
	f4hqlNxssJE8M2It3QLilHnUvk5icVXRMgL/SoGi/A2jz9FA1+69Vf7OiHBNeZIkWT75XJ3QWfR
	m3Anlug==
X-Received: from pghz8.prod.google.com ([2002:a63:e108:0:b0:c76:9cb0:80cb])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:1591:b0:398:aaac:a079
 with SMTP id adf61e73a8af0-39fe40839e4mr5785221637.45.1775855867216; Fri, 10
 Apr 2026 14:17:47 -0700 (PDT)
Date: Fri, 10 Apr 2026 21:17:05 +0000
In-Reply-To: <20260410211726.1668756-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260410211726.1668756-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260410211726.1668756-10-kuniyu@google.com>
Subject: [PATCH v2 net-next 09/15] ip6mr: Free mr_table after RCU grace period.
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277585-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AC3F23DCD32
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Since default_device_exit_batch() is called after ->exit_rtnl(),
idev->mc_ifc_work could finally call mroute6_is_socket() under RCU
while ->exit_rtnl() is running. [0]

With CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=n, ip6mr_fib_lookup() does
not check if net->ipv6.mrt6 is NULL.  If ip6mr_net_exit_batch()
set net->ipv6.mrt6 to NULL and freed it, the mrt->mroute_sk access
could result in null-ptr-deref or use-after-free.

Let's prepare for that situation by applying RCU rule to ip6mr
table similarly.

Link: https://lore.kernel.org/netdev/20260407184202.34cfe2d6@kernel.org/ #[0]
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/ip6mr.c | 53 +++++++++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 23 deletions(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 2b04e52ec61c..fdec7a541cf6 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -136,16 +136,6 @@ static struct mr_table *__ip6mr_get_table(struct net *net, u32 id)
 	return NULL;
 }
 
-static struct mr_table *ip6mr_get_table(struct net *net, u32 id)
-{
-	struct mr_table *mrt;
-
-	rcu_read_lock();
-	mrt = __ip6mr_get_table(net, id);
-	rcu_read_unlock();
-	return mrt;
-}
-
 static int ip6mr_fib_lookup(struct net *net, struct flowi6 *flp6,
 			    struct mr_table **mrt)
 {
@@ -274,7 +264,7 @@ static void __net_exit ip6mr_rules_exit(struct net *net)
 
 	ASSERT_RTNL();
 	list_for_each_entry_safe(mrt, next, &net->ipv6.mr6_tables, list) {
-		list_del(&mrt->list);
+		list_del_rcu(&mrt->list);
 		ip6mr_free_table(mrt);
 	}
 	fib_rules_unregister(net->ipv6.mr6_rules_ops);
@@ -298,28 +288,30 @@ bool ip6mr_rule_default(const struct fib_rule *rule)
 }
 EXPORT_SYMBOL(ip6mr_rule_default);
 #else
-#define ip6mr_for_each_table(mrt, net) \
-	for (mrt = net->ipv6.mrt6; mrt; mrt = NULL)
-
 static struct mr_table *ip6mr_mr_table_iter(struct net *net,
 					    struct mr_table *mrt)
 {
 	if (!mrt)
-		return net->ipv6.mrt6;
+		return rcu_dereference(net->ipv6.mrt6);
 	return NULL;
 }
 
-static struct mr_table *ip6mr_get_table(struct net *net, u32 id)
+static struct mr_table *__ip6mr_get_table(struct net *net, u32 id)
 {
-	return net->ipv6.mrt6;
+	return rcu_dereference_check(net->ipv6.mrt6,
+				     lockdep_rtnl_is_held() ||
+				     !rcu_access_pointer(net->ipv6.mrt6));
 }
 
-#define __ip6mr_get_table ip6mr_get_table
+#define ip6mr_for_each_table(mrt, net)				\
+	for (mrt = __ip6mr_get_table(net, 0); mrt; mrt = NULL)
 
 static int ip6mr_fib_lookup(struct net *net, struct flowi6 *flp6,
 			    struct mr_table **mrt)
 {
-	*mrt = net->ipv6.mrt6;
+	*mrt = rcu_dereference(net->ipv6.mrt6);
+	if (!*mrt)
+		return -EAGAIN;
 	return 0;
 }
 
@@ -330,15 +322,19 @@ static int __net_init ip6mr_rules_init(struct net *net)
 	mrt = ip6mr_new_table(net, RT6_TABLE_DFLT);
 	if (IS_ERR(mrt))
 		return PTR_ERR(mrt);
-	net->ipv6.mrt6 = mrt;
+
+	rcu_assign_pointer(net->ipv6.mrt6, mrt);
 	return 0;
 }
 
 static void __net_exit ip6mr_rules_exit(struct net *net)
 {
+	struct mr_table *mrt = rcu_dereference_protected(net->ipv6.mrt6, 1);
+
 	ASSERT_RTNL();
-	ip6mr_free_table(net->ipv6.mrt6);
-	net->ipv6.mrt6 = NULL;
+
+	RCU_INIT_POINTER(net->ipv6.mrt6, NULL);
+	ip6mr_free_table(mrt);
 }
 
 static int ip6mr_rules_dump(struct net *net, struct notifier_block *nb,
@@ -353,6 +349,17 @@ static unsigned int ip6mr_rules_seq_read(const struct net *net)
 }
 #endif
 
+static struct mr_table *ip6mr_get_table(struct net *net, u32 id)
+{
+	struct mr_table *mrt;
+
+	rcu_read_lock();
+	mrt = __ip6mr_get_table(net, id);
+	rcu_read_unlock();
+
+	return mrt;
+}
+
 static int ip6mr_hash_cmp(struct rhashtable_compare_arg *arg,
 			  const void *ptr)
 {
@@ -412,7 +419,7 @@ static void ip6mr_free_table(struct mr_table *mrt)
 	mroute_clean_tables(mrt, MRT6_FLUSH_MIFS | MRT6_FLUSH_MIFS_STATIC |
 				 MRT6_FLUSH_MFC | MRT6_FLUSH_MFC_STATIC);
 	rhltable_destroy(&mrt->mfc_hash);
-	kfree(mrt);
+	kfree_rcu(mrt, rcu);
 }
 
 #ifdef CONFIG_PROC_FS
-- 
2.53.0.1213.gd9a14994de-goog


