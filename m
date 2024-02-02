Return-Path: <netdev+bounces-68413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E06846D6F
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 11:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE754B21D02
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 10:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB8478689;
	Fri,  2 Feb 2024 10:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ox/rwC/h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE6878B64
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 10:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706868675; cv=none; b=M7USK73y2UbkDU9H2Bq3Bf250re6cwlFBknWuEAADCXG7s0jlBb5nAeDNSs3+cajYDcxnb0kdg716Kg/xnBUUfut/qUUbkDEcFIhDQLmcurQ6lu18hTumdoJE4u0nfU77JMBuKr/Z+xSsQe9kYE6Y8TLy1+pTMLm8cRb+Ov020A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706868675; c=relaxed/simple;
	bh=EUcoDlDnScu5R29EZt8aGgnEjCyVEJVgaISs5U4foCs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=STTdQ2D4AYmm5WWMfKbNgpcVVY2bOmGpNPugkBuTkqbZs2yCj/PTKhrvWAu/JpTyWZDaITjHTZqpmhLt2SQJT9Ji3jIWGdPAD7J39Wt7Ig33KQ1H6kgD7ON13WQ8Tav2EcprPcDziu9vAntl3oIK/ncdO5CSRCZl84wuC20g4nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ox/rwC/h; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60411f95c44so25897297b3.1
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 02:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706868672; x=1707473472; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kujuJOig/7eZ1lmFxecDrSJEVZfyScq048PRj49BE5g=;
        b=ox/rwC/hcIQFGxWhuFwMj/W0frqkgV7m0y5PNNNwnuCQwwEXGZ68jBq+v52BwEv+b+
         1NZOpw/Vv0KFuO4WqmM0UpqZhFlwr+gLp3j4wlpUQQWQ5LRK8wAGfFovOuG/vGdc5W82
         48LP8M0s5mKKOyWuZZJbhn9vj1T0m8tIp+LhqSpBtsFzvIrcFTJFbRxWaFJvTE2pZc4S
         Bw/0NNL7hExfvD0P4AMuk0oE0vwYtlQZIe4S1cCKbEJhELG8UeQP7CYL0WiPcgNpusBH
         j/iJXWxCkqXfhHX9/UOaEPqW84OIOr+EA/CfOFrxR7BHDVqaJ/obF05XlNNlYjcrbAwO
         l77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706868672; x=1707473472;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kujuJOig/7eZ1lmFxecDrSJEVZfyScq048PRj49BE5g=;
        b=jPSC/i+9N4Myx8Wx3MwCeqLOalVDooSDmXJ5vPR+xFvo0MYKJBUkOBl+b6Pbn/UTSN
         2QGqbSr5Fdmi2hMtSHQWoVD23qjpBURU8s/Y6LXlMFGawbKlLN6fyT7LLVHEQLTBfwh7
         yHvPyaiIyjIZ16gk8t0wEeanwBbVTRdfnsamktQz0vd7Qz8LmqCy++capAExlir9dGT5
         K78nsIGRtTaaBj3BkPHzo/vmg68wznBztD1tDGCxzGyoHSHNDEGpiBLJDm5YjewsK97m
         vNQCdkneOe4E88Txcuc2NHZA9MdyPgzH9/HnnrxEJLR93YjPvDK/sXZJ2+BLD8lj3C3/
         lpOA==
X-Gm-Message-State: AOJu0YxQ43iJL/OtmN6MBf3cS+8DhPLO21kSoO6ZBI1bj8lB52Zx4QMz
	Dn3fm/zXvQGyUBY+21bmN6I65jLqMzMhz1JVGmcJHfAT/icmRkEW0CLqiIrrqI9XYYvWro1eM4V
	rVwp9AZpK0w==
X-Google-Smtp-Source: AGHT+IFRZzkCxS69p8p2gUo6KwSiBs94YEylVBD2cDncllcA0KyamxSZ5aDsP/ErrldCgfoK1NTQglZWkdvBxA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1b90:b0:dc6:eb86:c422 with SMTP
 id ei16-20020a0569021b9000b00dc6eb86c422mr43056ybb.5.1706868672445; Fri, 02
 Feb 2024 02:11:12 -0800 (PST)
Date: Fri,  2 Feb 2024 10:11:06 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240202101106.342543-1-edumazet@google.com>
Subject: [PATCH net-next] net: make dev_unreg_count global
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

We can use a global dev_unreg_count counter instead
of a per netns one.

As a bonus we can factorize the changes done on it
for bulk device removals.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/rtnetlink.h   |  1 +
 include/net/net_namespace.h |  2 --
 net/core/dev.c              | 12 +++++++++---
 net/core/rtnetlink.c        | 11 +----------
 4 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
index 410529fca18b2f18ce2f94bba02ccebf1b544817..21780608cf47ca0687dbaaf0d07b561e8631412c 100644
--- a/include/linux/rtnetlink.h
+++ b/include/linux/rtnetlink.h
@@ -47,6 +47,7 @@ extern int rtnl_lock_killable(void);
 extern bool refcount_dec_and_rtnl_lock(refcount_t *r);
 
 extern wait_queue_head_t netdev_unregistering_wq;
+extern atomic_t dev_unreg_count;
 extern struct rw_semaphore pernet_ops_rwsem;
 extern struct rw_semaphore net_rwsem;
 
diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index c6a19d0209e2b64afc17229c6fd8d70d406b9c10..ec70c1be6ba3083903cbef4f7a7a6837e68c0a00 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -67,8 +67,6 @@ struct net {
 						 */
 	spinlock_t		rules_mod_lock;
 
-	atomic_t		dev_unreg_count;
-
 	unsigned int		dev_base_seq;	/* protected by rtnl_mutex */
 	u32			ifindex;
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 3742130d54a1c09c1343a409a22bd16330cd4d96..ac17e2ea674bc41cd34cfaf308245f8dfed413c6 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9698,11 +9698,11 @@ static void dev_index_release(struct net *net, int ifindex)
 /* Delayed registration/unregisteration */
 LIST_HEAD(net_todo_list);
 DECLARE_WAIT_QUEUE_HEAD(netdev_unregistering_wq);
+atomic_t dev_unreg_count = ATOMIC_INIT(0);
 
 static void net_set_todo(struct net_device *dev)
 {
 	list_add_tail(&dev->todo_list, &net_todo_list);
-	atomic_inc(&dev_net(dev)->dev_unreg_count);
 }
 
 static netdev_features_t netdev_sync_upper_features(struct net_device *lower,
@@ -10529,6 +10529,7 @@ void netdev_run_todo(void)
 {
 	struct net_device *dev, *tmp;
 	struct list_head list;
+	int cnt;
 #ifdef CONFIG_LOCKDEP
 	struct list_head unlink_list;
 
@@ -10565,6 +10566,7 @@ void netdev_run_todo(void)
 		linkwatch_sync_dev(dev);
 	}
 
+	cnt = 0;
 	while (!list_empty(&list)) {
 		dev = netdev_wait_allrefs_any(&list);
 		list_del(&dev->todo_list);
@@ -10582,12 +10584,13 @@ void netdev_run_todo(void)
 		if (dev->needs_free_netdev)
 			free_netdev(dev);
 
-		if (atomic_dec_and_test(&dev_net(dev)->dev_unreg_count))
-			wake_up(&netdev_unregistering_wq);
+		cnt++;
 
 		/* Free network device */
 		kobject_put(&dev->dev.kobj);
 	}
+	if (cnt && atomic_sub_and_test(cnt, &dev_unreg_count))
+		wake_up(&netdev_unregistering_wq);
 }
 
 /* Convert net_device_stats to rtnl_link_stats64. rtnl_link_stats64 has
@@ -11034,6 +11037,7 @@ void unregister_netdevice_many_notify(struct list_head *head,
 {
 	struct net_device *dev, *tmp;
 	LIST_HEAD(close_head);
+	int cnt = 0;
 
 	BUG_ON(dev_boot_phase);
 	ASSERT_RTNL();
@@ -11130,7 +11134,9 @@ void unregister_netdevice_many_notify(struct list_head *head,
 	list_for_each_entry(dev, head, unreg_list) {
 		netdev_put(dev, &dev->dev_registered_tracker);
 		net_set_todo(dev);
+		cnt++;
 	}
+	atomic_add(cnt, &dev_unreg_count);
 
 	list_del(head);
 }
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index d58bb91008824454efb030920533834bb6af3e97..2d99df654caf5dc9724cd5c613c768c6098baba0 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -483,24 +483,15 @@ EXPORT_SYMBOL_GPL(__rtnl_link_unregister);
  */
 static void rtnl_lock_unregistering_all(void)
 {
-	struct net *net;
-	bool unregistering;
 	DEFINE_WAIT_FUNC(wait, woken_wake_function);
 
 	add_wait_queue(&netdev_unregistering_wq, &wait);
 	for (;;) {
-		unregistering = false;
 		rtnl_lock();
 		/* We held write locked pernet_ops_rwsem, and parallel
 		 * setup_net() and cleanup_net() are not possible.
 		 */
-		for_each_net(net) {
-			if (atomic_read(&net->dev_unreg_count) > 0) {
-				unregistering = true;
-				break;
-			}
-		}
-		if (!unregistering)
+		if (!atomic_read(&dev_unreg_count))
 			break;
 		__rtnl_unlock();
 
-- 
2.43.0.594.gd9cf4e227d-goog


