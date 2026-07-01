Return-Path: <netdev+bounces-303843-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 69J+OXWKRWrfBgsAu9opvQ
	(envelope-from <netdev+bounces-303843-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:45:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4946D6F1EC5
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:45:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=k0KMidtc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303843-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303843-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17E7130E3AFA
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 21:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09383BB12A;
	Wed,  1 Jul 2026 21:43:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614663BD651
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 21:43:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782942227; cv=none; b=jyjdpUlgtPMM/nkuoylhyPeTx/wVYOemoibM7A42EwjbkjHerv+19PzC+MQgMEvOnMMYPjqsDDs6sDep9ZLgmsJGVgYy+1+puh+3Lo9gHA7CMZJ0BkmrAmfPOTlLvF3Va4kAiayavg6h+7NywDNqsTAFeUSF+wcuLkNDu50ofPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782942227; c=relaxed/simple;
	bh=JxsE9m5REMf87+P1b3FwkitHXu9vKQ71LozXv0lBwno=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iwKj8vNO9KIv9X7PSuELgtta6NeqLTEIrWf2BhBH5I2OvALod6EvSWfmNBI55Q9/HhQRC48Os6kNGzWrzM9gT5Wd0vHEI3QXdwD/yFfGEXnPHZfGb4abtL8nbVITkajfnmklBv+mY3DNLK1b+V2BEbR3BPtpEaBLiWkuQYhjQ9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k0KMidtc; arc=none smtp.client-ip=209.85.214.201
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ca53c486f2so14528315ad.3
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 14:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782942226; x=1783547026; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t9EEFFRPjsAGZ/FBfdqh7kwb+gY00dfuyduPcYJ3gDw=;
        b=k0KMidtcAvCHtzKOSKS8B6FL9O3YFbKvSDnGvuZAHUaTxOmR8gS/nNHDfS1RMQtvir
         y4acTCI3Der2kkampl3G2E4K2fOH5cK9gtiHy2ODoxfg3aRSbcQj6rMrwCFrT+CpyiQj
         jVZiELYvMGQIvc7TWgVj+Mr7kQpU3/XdhH/JjtiKy7aPFcxG8R48N2W4mwuAtkmT24qW
         EDX2S3oP7xx2Ynt8PvCNc6U88Q3rbxFwNXL0sazV2ippYeyNTII5XBP/2MoG3xE5/eJp
         5cAoJIcatX5z5peaBV0L+/X5W++jPuu1dIAmyzRb34i2Xp9Z8cU3PBwXJcvb3SSdBklG
         20gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782942226; x=1783547026;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t9EEFFRPjsAGZ/FBfdqh7kwb+gY00dfuyduPcYJ3gDw=;
        b=L/PNjUTlsTCFtE6TIMJyPLjrQJtb7iuL1M5a1TZ3GGcUgr7xDkQy6v9O2nZfKxo2G1
         Mzlw1rtSl9/DoxcCXUAeuxHXXc8VhVRDj/VvLJng+rw43w8CmmstQwF9DWMHFwLsBpk3
         LfHm4KY4nSvQZ/We1WrQ3VaEyWb1llykwZtmxLZ6Cx8YKmuFzkK0QOhnrK1Y7BEif+A+
         H03MsakyhpNW6xikiwZUmwBqc9Q06FP0jzjHZw2MhC8w0r5OBo2OYhcBrQq5V5mabs4U
         yw5MaNJf+duW4srV8mZ7nlAa1hGHfmGyQT3XlBl74vGSSRT3acMRkZzxdJTDm/MxBUB7
         wdLA==
X-Forwarded-Encrypted: i=1; AHgh+RoCOO8ZYmP1Ovv8bJIpMRTlgNI86l1iRarRGt+hMwAcnFPrEES5Q7p7InygjsiOCtK9zmr4zr8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6LFjPlUPNlnOCl8B/wuW2/p2I5ClLjsafZLfQER8NZlewE/w6
	LN3CwT6dPwJ44CRlvR6pCv1KjURD78z3oQGDACAcaNxOByVkvxIcmbeuKFQvYWPcrtecbNqXwTt
	lDXXpEg==
X-Received: from plbbi9.prod.google.com ([2002:a17:902:bf09:b0:2bf:195a:2b9d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:fa5:b0:2c8:f34c:82c0
 with SMTP id d9443c01a7336-2ca9112c9d2mr22860565ad.2.1782942225229; Wed, 01
 Jul 2026 14:43:45 -0700 (PDT)
Date: Wed,  1 Jul 2026 21:41:41 +0000
In-Reply-To: <20260701214334.266991-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701214334.266991-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701214334.266991-4-kuniyu@google.com>
Subject: [PATCH v1 net-next 03/14] rtnetlink: Add per-netns rtnl_work.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-303843-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:kuniyu@google.com,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4946D6F1EC5

The biggest blocker to per-netns RTNL is netdev unregistration.

It starts within a single netns (e.g., during a device lookup or
netns dismantle), but it can eventually involve multiple namespaces,
such as when upper ipvlan devices reside in different netns.

This prevents us from acquiring multiple rtnl_net_lock()s beforehand.

When we encounter such a cross-netns device, we must delegate the
unregistration to the work of the netns where the device actually
resides.

Let's add per-netns rtnl_work to support the deferred netdev
unregistration.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/linux/rtnetlink.h   |  8 ++++++++
 include/net/net_namespace.h |  1 +
 net/core/net_namespace.c    |  1 +
 net/core/rtnetlink.c        | 26 ++++++++++++++++++++++++++
 4 files changed, 36 insertions(+)

diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
index ea39dd23a197..95729339e7a5 100644
--- a/include/linux/rtnetlink.h
+++ b/include/linux/rtnetlink.h
@@ -115,6 +115,10 @@ bool rtnl_net_is_locked(struct net *net);
 
 bool lockdep_rtnl_net_is_held(struct net *net);
 
+void rtnl_net_queue_work(struct net *net);
+void rtnl_net_flush_workqueue(void);
+void rtnl_net_work_func(struct work_struct *work);
+
 #define rcu_dereference_rtnl_net(net, p)				\
 	rcu_dereference_check(p, lockdep_rtnl_net_is_held(net))
 #define rtnl_net_dereference(net, p)					\
@@ -150,6 +154,10 @@ static inline void ASSERT_RTNL_NET(struct net *net)
 	ASSERT_RTNL();
 }
 
+static inline void rtnl_net_flush_workqueue(void)
+{
+}
+
 #define rcu_dereference_rtnl_net(net, p)		\
 	rcu_dereference_rtnl(p)
 #define rtnl_net_dereference(net, p)			\
diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index 80de5e98a66d..a989019af5f7 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -197,6 +197,7 @@ struct net {
 #ifdef CONFIG_DEBUG_NET_SMALL_RTNL
 	/* Move to a better place when the config guard is removed. */
 	struct mutex		rtnl_mutex;
+	struct work_struct	rtnl_work;
 #endif
 #if IS_ENABLED(CONFIG_VSOCKETS)
 	struct netns_vsock	vsock;
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index d9dafe24f57e..d1aeff9de580 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -422,6 +422,7 @@ static __net_init int preinit_net(struct net *net, struct user_namespace *user_n
 #ifdef CONFIG_DEBUG_NET_SMALL_RTNL
 	mutex_init(&net->rtnl_mutex);
 	lock_set_cmp_fn(&net->rtnl_mutex, rtnl_net_lock_cmp_fn, NULL);
+	INIT_WORK(&net->rtnl_work, rtnl_net_work_func);
 #endif
 
 	INIT_LIST_HEAD(&net->ptype_all);
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 7207da002fb5..7959519e7375 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -273,6 +273,26 @@ bool lockdep_rtnl_net_is_held(struct net *net)
 	return lockdep_rtnl_is_held() && lockdep_is_held(&net->rtnl_mutex);
 }
 EXPORT_SYMBOL(lockdep_rtnl_net_is_held);
+
+static struct workqueue_struct *rtnl_net_wq;
+
+void rtnl_net_queue_work(struct net *net)
+{
+	queue_work(rtnl_net_wq, &net->rtnl_work);
+}
+
+void rtnl_net_flush_workqueue(void)
+{
+	flush_workqueue(rtnl_net_wq);
+}
+
+void rtnl_net_work_func(struct work_struct *work)
+{
+	struct net *net = container_of(work, struct net, rtnl_work);
+
+	rtnl_net_lock(net);
+	rtnl_net_unlock(net);
+}
 #else
 static int rtnl_net_cmp_locks(const struct net *net_a, const struct net *net_b)
 {
@@ -7226,4 +7246,10 @@ void __init rtnetlink_init(void)
 	register_netdevice_notifier(&rtnetlink_dev_notifier);
 
 	rtnl_register_many(rtnetlink_rtnl_msg_handlers);
+
+#ifdef CONFIG_DEBUG_NET_SMALL_RTNL
+	rtnl_net_wq = create_workqueue("rtnl_net");
+	if (!rtnl_net_wq)
+		panic("Could not create rtnl_net workq");
+#endif
 }
-- 
2.55.0.rc0.799.gd6f94ed593-goog


