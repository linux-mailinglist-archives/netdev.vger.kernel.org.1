Return-Path: <netdev+bounces-69119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D81B4849AFE
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 13:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 484471F25BFC
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 12:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E272C68F;
	Mon,  5 Feb 2024 12:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A3jYWRD/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503AF2C6AC
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 12:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137283; cv=none; b=agk4aX3LOHjaTjAlDfmboBeTW+14T1tLIyQ9C6HrN8Hg3G5Ff0krE6F3bopMtRZMY7yKQqIXmoTSI8E5i2XSr3jEaBDf6AlasnH4UUkK+vWxAI/wZJ2TbhLmJtzaLciFv/wNsZDYkUexAg0stmJCvWjaIACsdBBw4tfDYCd9sXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137283; c=relaxed/simple;
	bh=KdAtNz/cBtMCUpp+YnWC2X++eMy2gSKBB/xydSPDLhY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fHzsR8Q/54A6JwGigmGiiqgMJk8fZC1aN+FoByatCcIhBfGvvnm5Vx1W/mffuBdnm9ZH/RWSqR/4SSy6CMtucezClTV360MmMcaVKkfVDciMfBSvLXwDqlO76jH4iwJVk2NTXjv0wwYJAiDLF0F8U0d5nXZG0ZnPNQT99yyE4Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A3jYWRD/; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26783b4so4756810276.0
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 04:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707137281; x=1707742081; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ppm1by4rYBNCXK1Qe1GGbJ+D8r3e/t1KR8J/U3dzp8Q=;
        b=A3jYWRD/u7TaCnl/H2Y9YxTQSaSRiBUL7lDbx+Sm94uXE8Ttx7Wt8AZBYuSqF/eS4V
         oHHeytv6jy38Fgl8KG6KXdSiXs8eT0U1LVvK3cEG07qPNO9zoZg5EwRK42wMZrXPe6tG
         MirnmI4D4cg8zEAGeFj2uuZwLujx2qyvyLQooEfDX40bz3Z+R6JMQwsHtGvVnZpgUmWj
         tKAGWyelljlotTn0STZJUPMMqESgT0qLODQY+U5xzaIe/K6zXZjs3HGopg72Qap4w/sk
         4V507MQIL0KM73ACIKTFn6Vl0lp3SaXiVC/ttWe7wYnxfJMfx7R71JoPrrwmHLX3sf6r
         F4CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707137281; x=1707742081;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ppm1by4rYBNCXK1Qe1GGbJ+D8r3e/t1KR8J/U3dzp8Q=;
        b=wQ1fTyoxL4Ku0MbHE3zYwXd9Blm/dAT3ZflkwDC1MQ6ghPqGtaGzQtQ5OHBjDz1Y0c
         pui+VadCK1G+2GxaGSMWUAK0z69eTwfe++SfrA9makxWs0fJLDF5ooGCD9lH+46JRZiA
         GlD1UW06m4RaMhkwaZcdkXqaTujm6p6ys/B3QCj6Ck0/Sx4xh1jBrzWUwyFK/PbMYsa6
         /6XQV/A9ws/HVR1ORk7pDxpeUGrap+l5ZaX0TNhxZEv5gGRNTjUY3c5dVWc2o42t8VzF
         62AWDOZNQxuBsRnINKJclHRK8zNU2HvPNBPPfCSCBwl9dVJTb4TkFvWopIBkFEModq/p
         +ljQ==
X-Gm-Message-State: AOJu0YzzBNqwKa9aq4ZzxqdYgv72sbOsI+9/2BZVBG161CYH8JjB0W1O
	NdtLcCFQMWSbSc2e0mGYRQSMG9fRlf7Gt4wcHvV5X9Sdgrid7vJUlEvJ8vo1e6i5oaSbE8C9PY4
	KsmtaaaM0VQ==
X-Google-Smtp-Source: AGHT+IGpVmHNJeKg96I6WZp+ZCOH6B/tENfplAb8y+Kmgef4mVYn1dRH9UAgNYdDsAtpXQ/cAYdAitOUhuTKxA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:2313:b0:dc6:b84d:93f8 with SMTP
 id do19-20020a056902231300b00dc6b84d93f8mr434240ybb.3.1707137281315; Mon, 05
 Feb 2024 04:48:01 -0800 (PST)
Date: Mon,  5 Feb 2024 12:47:38 +0000
In-Reply-To: <20240205124752.811108-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240205124752.811108-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240205124752.811108-2-edumazet@google.com>
Subject: [PATCH v3 net-next 01/15] net: add exit_batch_rtnl() method
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Antoine Tenart <atenart@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Many (struct pernet_operations)->exit_batch() methods have
to acquire rtnl.

In presence of rtnl mutex pressure, this makes cleanup_net()
very slow.

This patch adds a new exit_batch_rtnl() method to reduce
number of rtnl acquisitions from cleanup_net().

exit_batch_rtnl() handlers are called while rtnl is locked,
and devices to be killed can be queued in a list provided
as their second argument.

A single unregister_netdevice_many() is called right
before rtnl is released.

exit_batch_rtnl() handlers are called before ->exit() and
->exit_batch() handlers.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/net_namespace.h |  3 +++
 net/core/net_namespace.c    | 31 ++++++++++++++++++++++++++++++-
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index cd0c2eedbb5e9ddcbd5e0a37e2eb7e0cf57495d5..20c34bd7a07783a9a13696fd74b41eff1ff860a8 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -448,6 +448,9 @@ struct pernet_operations {
 	void (*pre_exit)(struct net *net);
 	void (*exit)(struct net *net);
 	void (*exit_batch)(struct list_head *net_exit_list);
+	/* Following method is called with RTNL held. */
+	void (*exit_batch_rtnl)(struct list_head *net_exit_list,
+				struct list_head *dev_kill_list);
 	unsigned int *id;
 	size_t size;
 };
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 72799533426b6162256d7c4eef355af96c66e844..233ec0cdd0111d5ca21c6f8a66f4c1f3fbc4657b 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -318,8 +318,9 @@ static __net_init int setup_net(struct net *net, struct user_namespace *user_ns)
 {
 	/* Must be called with pernet_ops_rwsem held */
 	const struct pernet_operations *ops, *saved_ops;
-	int error = 0;
 	LIST_HEAD(net_exit_list);
+	LIST_HEAD(dev_kill_list);
+	int error = 0;
 
 	refcount_set(&net->ns.count, 1);
 	ref_tracker_dir_init(&net->refcnt_tracker, 128, "net refcnt");
@@ -357,6 +358,15 @@ static __net_init int setup_net(struct net *net, struct user_namespace *user_ns)
 
 	synchronize_rcu();
 
+	ops = saved_ops;
+	rtnl_lock();
+	list_for_each_entry_continue_reverse(ops, &pernet_list, list) {
+		if (ops->exit_batch_rtnl)
+			ops->exit_batch_rtnl(&net_exit_list, &dev_kill_list);
+	}
+	unregister_netdevice_many(&dev_kill_list);
+	rtnl_unlock();
+
 	ops = saved_ops;
 	list_for_each_entry_continue_reverse(ops, &pernet_list, list)
 		ops_exit_list(ops, &net_exit_list);
@@ -573,6 +583,7 @@ static void cleanup_net(struct work_struct *work)
 	struct net *net, *tmp, *last;
 	struct llist_node *net_kill_list;
 	LIST_HEAD(net_exit_list);
+	LIST_HEAD(dev_kill_list);
 
 	/* Atomically snapshot the list of namespaces to cleanup */
 	net_kill_list = llist_del_all(&cleanup_list);
@@ -613,6 +624,14 @@ static void cleanup_net(struct work_struct *work)
 	 */
 	synchronize_rcu();
 
+	rtnl_lock();
+	list_for_each_entry_reverse(ops, &pernet_list, list) {
+		if (ops->exit_batch_rtnl)
+			ops->exit_batch_rtnl(&net_exit_list, &dev_kill_list);
+	}
+	unregister_netdevice_many(&dev_kill_list);
+	rtnl_unlock();
+
 	/* Run all of the network namespace exit methods */
 	list_for_each_entry_reverse(ops, &pernet_list, list)
 		ops_exit_list(ops, &net_exit_list);
@@ -1193,7 +1212,17 @@ static void free_exit_list(struct pernet_operations *ops, struct list_head *net_
 {
 	ops_pre_exit_list(ops, net_exit_list);
 	synchronize_rcu();
+
+	if (ops->exit_batch_rtnl) {
+		LIST_HEAD(dev_kill_list);
+
+		rtnl_lock();
+		ops->exit_batch_rtnl(net_exit_list, &dev_kill_list);
+		unregister_netdevice_many(&dev_kill_list);
+		rtnl_unlock();
+	}
 	ops_exit_list(ops, net_exit_list);
+
 	ops_free_list(ops, net_exit_list);
 }
 
-- 
2.43.0.594.gd9cf4e227d-goog


