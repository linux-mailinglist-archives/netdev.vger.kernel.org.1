Return-Path: <netdev+bounces-277587-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIWONohp2Wn5pQgAu9opvQ
	(envelope-from <netdev+bounces-277587-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 23:20:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B043DCD6F
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 23:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2BC42304BBAA
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 21:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969BA3ACA52;
	Fri, 10 Apr 2026 21:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P6QYmOHF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5710A3B2FC3
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 21:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775855872; cv=none; b=U9javZatNHA3S6XmO198/1zC8sUROkalwBSBf/VubXgB63YI4u34tg+i0Gx8GtXnN44xTAND8CyQykzTPwJCGJac3+UDCgs5wrw6KT8oD4mvjdzb8RG5ool3st2e9rKmRRguXR6mUnbfZTquGZb+SYtzxEjgcD1N0yuhFKzATR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775855872; c=relaxed/simple;
	bh=GoYU6hiXhg4vrOG1RVU1q8naF23VWMHZElErdAH6qPU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fvlhl/Z053LeI5C0+Dlrd2Ot8SozzREqQWIAi5D4yM6a8C9H/xlxvoYDZ3Ocf3SONCKGius94BX+BIYOs33m3e0fOHw7ybtQq9TibgPN9AQ58bqN1uttZNrD/LYsqs/+oA9jmrtBPso2Db4DKhSAKCRtO1r01kJcjrVL7Ao6KRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P6QYmOHF; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c741b950511so1368066a12.0
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 14:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775855871; x=1776460671; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0GWhpKBGdmW7B2UG3cFEs5dpMnIVdsgYwsut38d1f7M=;
        b=P6QYmOHFiWLVXOw0tw5PjcHTQog2SGHFw/Bp103kd3ZBjWHPp0xQivuhdLzfa9PUjc
         hQ0KSOKbr8vB0gJIB+SVnB6KWitmpKZS0K8r9ey8bD0NeR1qkP8NdgYpd7uoUVoel2LF
         jPr4Pg5qtbq2dIqUeU3bztQFOm1Yl9vjUlHT+YejyjtSZk13hsYptiE1NKGPUKb3vqty
         FeA3Ec7ATXfhrSSrvxnL/WNnTuLFfWtv23kEa/TjKFxOv68C6jPhV40ua4l01ncjj1ER
         2pTTyGpiqmoyi7117brVdMxxkkwQLrg1mfVb11KpzaakvTfAOyzvZL4RWdrS5zXFNv3D
         Eyrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775855871; x=1776460671;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0GWhpKBGdmW7B2UG3cFEs5dpMnIVdsgYwsut38d1f7M=;
        b=SqCK/faDg7r5EgK2kT+eDRPRLOO9o8uYKm6QDEaEf9RghCYu1G/hbz2kSKCq/HtRVZ
         0APgytq1XdkY5SRePJxKVMt9mB9tQVEFdfDldtyBcy0A1M9h/12qoBIMcDFxariFtUTt
         T7JgiMX9LCH5wLSDLsH89nLkelW5d0EQgBN+VQ/6lcgeYUlJhYGb6/EdCPSnuVJ83Ua6
         iqhM1zdjeoRqqGBfMh9cueSXiZc75sKFV7G+M8taz9jxTpiV9ni2wJsec7Ni+uA7YPQD
         n4Yp6TqE79qby1iY4uj3jGIu4d1mwBLMqy7UPAZzRO0vHHGVbgKLW6ZsZPQWWxuUw3Be
         fUSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVad0AiE/qO4VL9gt1mn26KrB1RWIGZ8uLEpuDgsghlgp68DozE9gZhB1zgNLzWF5LvTMV4+LE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUSfUyvksuJz1P+A51ZLCfOPdzWZhbbjhNO1zaKdkx6OrurL+n
	EnSmXCaDfz5JEJt4xClWFjQi/zxnJXRfUFM0LzKI5oChiL0Vnx/L1ecd8Nho5bxrKP+uljcD6bJ
	hZL5bxw==
X-Received: from pfgs7.prod.google.com ([2002:a05:6a00:1787:b0:82a:ff5:27be])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:b80c:b0:82f:111:7e60
 with SMTP id d2e1a72fcca58-82f0c323e1bmr5297027b3a.37.1775855870434; Fri, 10
 Apr 2026 14:17:50 -0700 (PDT)
Date: Fri, 10 Apr 2026 21:17:07 +0000
In-Reply-To: <20260410211726.1668756-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260410211726.1668756-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260410211726.1668756-12-kuniyu@google.com>
Subject: [PATCH v2 net-next 11/15] ip6mr: Move unregister_netdevice_many() out
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277587-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 57B043DCD6F
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
 net/ipv6/ip6mr.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index dd72eb346eb1..af11fd883831 100644
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
@@ -228,6 +229,7 @@ static const struct fib_rules_ops __net_initconst ip6mr_rules_ops_template = {
 static int __net_init ip6mr_rules_init(struct net *net)
 {
 	struct fib_rules_ops *ops;
+	LIST_HEAD(dev_kill_list);
 	struct mr_table *mrt;
 	int err;
 
@@ -252,7 +254,8 @@ static int __net_init ip6mr_rules_init(struct net *net)
 
 err2:
 	rtnl_lock();
-	ip6mr_free_table(mrt);
+	ip6mr_free_table(mrt, &dev_kill_list);
+	unregister_netdevice_many(&dev_kill_list);
 	rtnl_unlock();
 err1:
 	fib_rules_unregister(ops);
@@ -262,12 +265,15 @@ static int __net_init ip6mr_rules_init(struct net *net)
 static void __net_exit ip6mr_rules_exit(struct net *net)
 {
 	struct mr_table *mrt, *next;
+	LIST_HEAD(dev_kill_list);
 
 	ASSERT_RTNL();
 	list_for_each_entry_safe(mrt, next, &net->ipv6.mr6_tables, list) {
 		list_del_rcu(&mrt->list);
-		ip6mr_free_table(mrt);
+		ip6mr_free_table(mrt, &dev_kill_list);
 	}
+
+	unregister_netdevice_many(&dev_kill_list);
 	fib_rules_unregister(net->ipv6.mr6_rules_ops);
 }
 
@@ -331,11 +337,13 @@ static int __net_init ip6mr_rules_init(struct net *net)
 static void __net_exit ip6mr_rules_exit(struct net *net)
 {
 	struct mr_table *mrt = rcu_dereference_protected(net->ipv6.mrt6, 1);
+	LIST_HEAD(dev_kill_list);
 
 	ASSERT_RTNL();
 
 	RCU_INIT_POINTER(net->ipv6.mrt6, NULL);
-	ip6mr_free_table(mrt);
+	ip6mr_free_table(mrt, &dev_kill_list);
+	unregister_netdevice_many(&dev_kill_list);
 }
 
 static int ip6mr_rules_dump(struct net *net, struct notifier_block *nb,
@@ -410,18 +418,17 @@ static struct mr_table *ip6mr_new_table(struct net *net, u32 id)
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
 	kfree_rcu(mrt, rcu);
 }
-- 
2.53.0.1213.gd9a14994de-goog


