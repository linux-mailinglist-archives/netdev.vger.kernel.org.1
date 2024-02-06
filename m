Return-Path: <netdev+bounces-69507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE0884B826
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 15:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05CA428E75C
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 14:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B937B131E2B;
	Tue,  6 Feb 2024 14:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gpaY+/Mz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EB012F5A4
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 14:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707230601; cv=none; b=YwCe1n4TOfqbYaZqXujqnDN0L5vFHg0l7vRDZw7O/61m57V+vb3Zdg5/D5rTcPnqkpGpWyieKiiSllv2GEU0yFshvWWwAT9pc139QZxMX2yWJ0RjjUQu1FahEMdj81fAI6BYaBLw5cZI9a+69ch4YncncOAv4J9Savh5jqdgVT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707230601; c=relaxed/simple;
	bh=KdAtNz/cBtMCUpp+YnWC2X++eMy2gSKBB/xydSPDLhY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NeXnYub0+9jvjS0VMDI23uLnF08oMOmEDw8HNDYyM34qUrVMXyTOVxNAHHApTxh5aSolUbMWEnlcauvHNFG0zF5fDZ1pVW0Rt3KNTRDabw8/z4k7GTKejg0DM4D5NSQIDRyISgn5nkd6ml3TvjZakWSHNWyYYZ+EtojjA22dK/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gpaY+/Mz; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6cd00633dso1301939276.3
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 06:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707230599; x=1707835399; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ppm1by4rYBNCXK1Qe1GGbJ+D8r3e/t1KR8J/U3dzp8Q=;
        b=gpaY+/MznyPue28m8LzCOQmzdbYHYfbgY92d0yEbitxGospY7nz99b3p2RAs0Gm/Hc
         2gMEdaZckXWIIE1clcRceafOem2RYa9sjm9G3y27PFTNmbkMkZou0lU5s7BucL5nL6jF
         iFFfIA7JEwxai8olTKny2rs/pYGQbvyCc2MYA7lCE+fE9jclaxzSlT8FF1g1ZHcWaFU3
         Klmx9zPYFfkdZpbVGIA5NEKyl+1YMcbZK/v7TataC/vwplNHnvK/I+BGqwzU5nm5XKMK
         6puwHdmPSaLhQ2TKg1IJHLVh8bQEuDVOcY7ZSR0K3lkkWcOLNOE0424tyl1UNjscTlm9
         /9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707230599; x=1707835399;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ppm1by4rYBNCXK1Qe1GGbJ+D8r3e/t1KR8J/U3dzp8Q=;
        b=ZgKaAt5NcD5+fQ3lqYegAJF3trPFc5AyUwO3W1OKBFOKINZMZl1FxIz2oFh4iJps3x
         H/vVB1ygc+fnHXwxFurQtTVHXfAfB0H/cCgt423LHAVzUvGuXA6UPoTlfay/bwlpbZJS
         R1KGimAa6aCoi/HIdkSDmh+GvOpWW9EeI2MulH56XElnqMV7xUPwJM2cRWok3PFwOrza
         zTS1qAIEIgAgIPJU/I8Lk6xTeIP5Hfz36ctoGd6DaWMVQErerK+rspZwnZenqMzOHyah
         TVHY6t1CJqGPQCywmvfJV43OvvWwosojIJT+29OzBOxVBUnou7eiUnVe5XzRxJb5YCNG
         wkCg==
X-Gm-Message-State: AOJu0Yxj1KUPhKt9KcFJofdUVcVqsDzqQzU4FM1/5uafrUE6WD3Zogr8
	Tra10TSHw4YmvDnVVrEiOu61dnRPcDcmR8q5N7w9AOIBaxQURg1GS3onfJVaALbOICpoDFyTXjg
	r3aCYDVLM9g==
X-Google-Smtp-Source: AGHT+IGr7XSMjN8BIQB9OSxSXXFwqHTTws9FR8vqIebxMpPVWRXuakEhnSHH6IrvlNBH27CdCNzmaszHagw45Q==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:2512:b0:dc6:f90f:e37f with SMTP
 id dt18-20020a056902251200b00dc6f90fe37fmr54809ybb.13.1707230599146; Tue, 06
 Feb 2024 06:43:19 -0800 (PST)
Date: Tue,  6 Feb 2024 14:42:57 +0000
In-Reply-To: <20240206144313.2050392-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240206144313.2050392-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240206144313.2050392-2-edumazet@google.com>
Subject: [PATCH v4 net-next 01/15] net: add exit_batch_rtnl() method
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


