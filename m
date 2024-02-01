Return-Path: <netdev+bounces-68122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A58D2845E25
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 18:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23EF91F27968
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 17:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0C115B994;
	Thu,  1 Feb 2024 17:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IZdK05qO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77AE77A1C
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 17:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706807383; cv=none; b=bA7yWrqlMy8zQ+1APC9x32ZBfSkuOc6dYZaRoeMPpzyNa2aFAmeUoH3TdN+970N2jGz34nabFN7dPKjD7UraoFgXuu4RltBI/6j0f8Apga2xMVVRu3SEf6g7la1jsJsAe5flSkXSFG/UMc8vVSCSH7GWCqX+jJNoH6CIfWynsFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706807383; c=relaxed/simple;
	bh=J0/YdDkxHXzm3XWRfN7oa6hvqBBKxPBY9NASLxrsZRM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o75zbMGwTxsKsT5aD++mT5CG4lkswa/myHQsyqTqtBMW23bpnvwXsPvFu+Zn0Qlp3878JlPhZzRbhC1ikUGbjqEr2+alsQ8T+KuOjE9Ci90vFcDp++9OA8bCuZjGa9+fL4C0uZpUVFAIisFZSBAIUEjZ7tweaooBICfAA39S/xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IZdK05qO; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-78346521232so147528685a.3
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 09:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706807380; x=1707412180; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1VIcw/+J8wok8KHYfmedUaIZ/lcX0VpElt9KvdufhIE=;
        b=IZdK05qOphEqzibtnSysu6yuvMvthX2GcdYNh32C7ZPjjF+K7kPOiYslTdNyMYPlf4
         SOC8PEye+AbOt1oQkNi08RaPw/1AUptTpWL+7WMiW3yqkIDUiOSfnJCFWZDe9VLQlDRR
         /Zn/DFDwpuQ3AJbxvOhlDliNzcDGEjQb8ga1nRRRwHsMnwK2WFkISZfTQTyn7dPv0iy/
         63BAmJ65M0LKS4RrDVNISAjU5lZeVKY3GJDb4tNin8k7kukDLp2srla8VI7OH/1gPXq8
         GGSwWukb6AGddtqwS2sjXYrD3cuM+LNvM3iucficXDV/Dmw6j3aynpp17IPWnC8QsinW
         luYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706807380; x=1707412180;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1VIcw/+J8wok8KHYfmedUaIZ/lcX0VpElt9KvdufhIE=;
        b=iB9pz6beT38mjwuC5T3P1ss7GiWgAbNUBozx6gKnigMXUF/3SMZNLwTFGBsT1qk6+i
         fsZTdDRaZ8BEgGVMmqp1cYGyUAOe4PHQ9AG3Rk4aFKH8mJQCyghsrjNFUxLDsmWracr/
         n8F2GtRCUGP3J1oHQwWUIST2J7zl/TY7Bgrl4cR7YbhxvGicsv7GvOEeC7hXNcJdbq5l
         SKjPJNCuHWIwJh6OwqLS/DAQ8DuCHsknuqo48x0LIzgik6dENTcCpBUNHrI1TK/HxF2U
         dAcOr8bzsDtVsze849sYLldmtaZZfsarQ4TMgrI8R9/OteDjp7wWsXW9w4PCGBBdYo+6
         Zk1w==
X-Gm-Message-State: AOJu0YxoPUhKZsvC/Phnpg0eHDrQWsNeVcuL2yedu79C4z2hro5a+Hog
	LG3kA+qdC1Gguv66ODm07906/6dyYvdjk4zN8GdKXmP5BNOj/z5Oh90u/JqX00lRJ0yDHHDvujP
	Ra15O/Uj4pQ==
X-Google-Smtp-Source: AGHT+IERbGzd2Mg0BEq6QahP9EBCaRE7IDXv5uXKFeStcCD35ZC/HIgtf4qJrjUFQ4vVzlZa6W8930+bd9GNNA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:620a:4494:b0:784:3ddc:cd3f with SMTP
 id x20-20020a05620a449400b007843ddccd3fmr44495qkp.13.1706807380585; Thu, 01
 Feb 2024 09:09:40 -0800 (PST)
Date: Thu,  1 Feb 2024 17:09:22 +0000
In-Reply-To: <20240201170937.3549878-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240201170937.3549878-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240201170937.3549878-2-edumazet@google.com>
Subject: [PATCH net-next 01/16] net: add exit_batch_rtnl() method
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
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
index 13b3a4e29fdb3b1f37649072ea71181ec1bad256..5e5b522eca88e9e19345792bd5137eb8cf374265 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -450,6 +450,9 @@ struct pernet_operations {
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
2.43.0.429.g432eaa2c6b-goog


