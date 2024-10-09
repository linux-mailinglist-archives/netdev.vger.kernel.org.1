Return-Path: <netdev+bounces-133966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7212999791C
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 01:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45D5F1C221DA
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 23:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218BA1E3DDA;
	Wed,  9 Oct 2024 23:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="du+2ALkR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667991E282B
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 23:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728516454; cv=none; b=M3E4xIn+iU22LH9KPReiVJfP654Bvhbs5W6r5Nj9XkCwvsqm++9CBl3KahV6VQ4bhxC9xuaRiDE9Y1oDWdtk0dqUFjc50F8iQGPEaxptSPQVkgxZZrW71bhqtKzuGarqvzfiXl1fN3kSrihNWeTyG8zgy2Z0L4KxbptN3wekuDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728516454; c=relaxed/simple;
	bh=OaZB4rMw6Fcwtu0gFAgulwkOWt8ODR4JWC58QB+aOmo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D5/k028TP2ZB5MBkDvxzVou2hqwycUAzFtSpD94Kd+tveS0q11TvkwV144u2JmtnQEYFCKjGZ3PkVlv4d4+B8YjRGnvrUPv6l69IR0O9Z/Mwo4OGS6J8oePytasjokneefPLw+zWHfHs4tihu+XnRu/3oZIhkzZgFbnvtd4TbR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=du+2ALkR; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7acdd745756so66021385a.3
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 16:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728516451; x=1729121251; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nu5swq1C0DK6ZZ2KUK8UQ9gbhcL8ehCGw8Rx9aLgFws=;
        b=du+2ALkRI8imSEdnWcdrCe95czWB2FPrdrKF16d5n5Tnip6zGCogCK/waKlny5DYBr
         b5YOnZevPTPpu3HltT02kFQs7FniUIBev/wTFWIdIRGnQWEz7iwlx5vAlhIA6XLyxY5X
         sqE//Ob1/iipMtIPAg8HTxxFSkLhCGokN52SRsIhagi469Zcyoeo73PhpP85K+xu4z9p
         PxbKAAKGr7kEXB22SkWX6bamSQmQ2UWPuRw6yoGD/l2g8l6WdZBS9Kfavbg71Oz7cfn1
         hoZhclAp0TOtZwldbrDuE94HY9GEuxdpBhFPuzVRyqPH2ln1PD9teLZvJXNi3tiPOwVU
         0qYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728516451; x=1729121251;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nu5swq1C0DK6ZZ2KUK8UQ9gbhcL8ehCGw8Rx9aLgFws=;
        b=StjQFg51LN1UKjRVgZr0DMQvK7G43bbIYY/C5AOjNeAes8o8u4L5wBZQxuYUbDn145
         AyErhi9p70SlpWB7hiNuotUrH2vmxI4ZzHlq9sSBWPNQZ77mLYa4Ydn99+fa1wfqQd58
         QMiuudUaDPIk7tbsBnqxBkrIVnCHn694vSBwheSsHNVsV3V/g/uyQCNlHZXziX6J8eZt
         PxcWNXR4WftsLOE7Ii7FO/Q5urm20p7sxhYBwWE4YoLLywGQbYCjniBL8sQW3K11Ps+S
         U9eXUfUqQHZex3fQm4mmzJOT1kakB7dgmbuzqX8xCczrPhr0ztVk2H2e1PfADFtDIqkp
         pz1A==
X-Forwarded-Encrypted: i=1; AJvYcCVs3+s+HugOtbTjn/azVb9ynFRhKN9575bytiyUnHzr73qUXjHg88Y3jXiodbSPxcoFN9MlEYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuM/rpODfQNcO+0rpdG5gCk9BNGvYQcBm7IWT42dPGfVrN6ddh
	G01KKbX53spAa7qQqr+QKa8e7mOM/6ykx/+6z+B3noqTEgMTd4hl5eOStoB2Y5j8QMBacOQkhAO
	kFGnCldAcaQ==
X-Google-Smtp-Source: AGHT+IHyKPhjoS7zEhz6efegHO7zubDGXb5jAykwAft5k52Q6yH80Sk0DURPD17To2AAUPoPdUkLh2Q2R3a+PQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a05:620a:6a14:b0:7b1:11e0:7131 with SMTP
 id af79cd13be357-7b111e0722dmr99085a.6.1728516451231; Wed, 09 Oct 2024
 16:27:31 -0700 (PDT)
Date: Wed,  9 Oct 2024 23:27:26 +0000
In-Reply-To: <20241009232728.107604-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241009232728.107604-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241009232728.107604-2-edumazet@google.com>
Subject: [PATCH net-next 1/2] netdev-genl: do not use rtnl in netdev_nl_napi_get_doit()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

With upcoming per netns RTNL, rtnl use in netdev_nl_napi_get_doit()
is a bit problematic.

Prepare netdev_nl_napi_fill_one() to not rely on RTNL:

1) netif_napi_set_irq() uses WRITE_ONCE(napi->irq, ...)

2) napi_kthread_create() uses WRITE_ONCE(napi->thread, ...)

3) Add napi->thread_pid_nr to avoid race in netdev_nl_napi_fill_one
   and __netif_napi_del()

4) netdev_nl_napi_fill_one() uses corresponding READ_ONCE()

5) netdev_nl_napi_get_doit() can use RCU instead of RTNL

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/netdevice.h |  3 ++-
 net/core/dev.c            | 21 ++++++++++++---------
 net/core/netdev-genl.c    | 21 +++++++++++----------
 3 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 3baf8e539b6f33caaf83961c4cf619b799e5e41d..64a5e4927901740db8dbc255ed19faca96820333 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -377,6 +377,7 @@ struct napi_struct {
 	struct list_head	dev_list;
 	struct hlist_node	napi_hash_node;
 	int			irq;
+	pid_t			thread_pid_nr;
 };
 
 enum {
@@ -2618,7 +2619,7 @@ void netif_queue_set_napi(struct net_device *dev, unsigned int queue_index,
 
 static inline void netif_napi_set_irq(struct napi_struct *napi, int irq)
 {
-	napi->irq = irq;
+	WRITE_ONCE(napi->irq, irq);
 }
 
 /* Default NAPI poll() weight
diff --git a/net/core/dev.c b/net/core/dev.c
index ea5fbcd133ae4c743545945def00790ec74e2bb6..77c39a95e74df2485777bc008a507bdcc4e75a00 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1423,21 +1423,23 @@ static int napi_threaded_poll(void *data);
 
 static int napi_kthread_create(struct napi_struct *n)
 {
-	int err = 0;
+	struct task_struct *thread;
 
 	/* Create and wake up the kthread once to put it in
 	 * TASK_INTERRUPTIBLE mode to avoid the blocked task
 	 * warning and work with loadavg.
 	 */
-	n->thread = kthread_run(napi_threaded_poll, n, "napi/%s-%d",
+	thread = kthread_run(napi_threaded_poll, n, "napi/%s-%d",
 				n->dev->name, n->napi_id);
-	if (IS_ERR(n->thread)) {
-		err = PTR_ERR(n->thread);
+	if (IS_ERR(thread)) {
+		int err = PTR_ERR(thread);
+
 		pr_err("kthread_run failed with err %d\n", err);
-		n->thread = NULL;
+		return err;
 	}
-
-	return err;
+	WRITE_ONCE(n->thread, thread);
+	WRITE_ONCE(n->thread_pid_nr, task_pid_nr(thread));
+	return 0;
 }
 
 static int __dev_open(struct net_device *dev, struct netlink_ext_ack *extack)
@@ -6668,6 +6670,7 @@ void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
 	set_bit(NAPI_STATE_SCHED, &napi->state);
 	set_bit(NAPI_STATE_NPSVC, &napi->state);
 	list_add_rcu(&napi->dev_list, &dev->napi_list);
+	netif_napi_set_irq(napi, -1);
 	napi_hash_add(napi);
 	napi_get_frags_check(napi);
 	/* Create kthread for this napi if dev->threaded is set.
@@ -6676,7 +6679,6 @@ void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
 	 */
 	if (dev->threaded && napi_kthread_create(napi))
 		dev->threaded = false;
-	netif_napi_set_irq(napi, -1);
 }
 EXPORT_SYMBOL(netif_napi_add_weight);
 
@@ -6753,7 +6755,8 @@ void __netif_napi_del(struct napi_struct *napi)
 
 	if (napi->thread) {
 		kthread_stop(napi->thread);
-		napi->thread = NULL;
+		WRITE_ONCE(napi->thread, NULL);
+		WRITE_ONCE(napi->thread_pid_nr, 0);
 	}
 }
 EXPORT_SYMBOL(__netif_napi_del);
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 1cb954f2d39e8248bffd854cdf27eceb25293425..0dcfe3527c122884c5713e56d5e27d4e638d936f 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -163,10 +163,11 @@ netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
 {
 	void *hdr;
 	pid_t pid;
+	int irq;
 
 	if (WARN_ON_ONCE(!napi->dev))
 		return -EINVAL;
-	if (!(napi->dev->flags & IFF_UP))
+	if (!(READ_ONCE(napi->dev->flags) & IFF_UP))
 		return 0;
 
 	hdr = genlmsg_iput(rsp, info);
@@ -177,17 +178,17 @@ netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
 	    nla_put_u32(rsp, NETDEV_A_NAPI_ID, napi->napi_id))
 		goto nla_put_failure;
 
-	if (nla_put_u32(rsp, NETDEV_A_NAPI_IFINDEX, napi->dev->ifindex))
+	if (nla_put_u32(rsp, NETDEV_A_NAPI_IFINDEX,
+			READ_ONCE(napi->dev->ifindex)))
 		goto nla_put_failure;
 
-	if (napi->irq >= 0 && nla_put_u32(rsp, NETDEV_A_NAPI_IRQ, napi->irq))
+	irq = READ_ONCE(napi->irq);
+	if (irq >= 0 && nla_put_u32(rsp, NETDEV_A_NAPI_IRQ, irq))
 		goto nla_put_failure;
 
-	if (napi->thread) {
-		pid = task_pid_nr(napi->thread);
-		if (nla_put_u32(rsp, NETDEV_A_NAPI_PID, pid))
-			goto nla_put_failure;
-	}
+	pid = READ_ONCE(napi->thread_pid_nr);
+	if (pid && nla_put_u32(rsp, NETDEV_A_NAPI_PID, pid))
+		goto nla_put_failure;
 
 	genlmsg_end(rsp, hdr);
 
@@ -214,7 +215,7 @@ int netdev_nl_napi_get_doit(struct sk_buff *skb, struct genl_info *info)
 	if (!rsp)
 		return -ENOMEM;
 
-	rtnl_lock();
+	rcu_read_lock();
 
 	napi = napi_by_id(napi_id);
 	if (napi) {
@@ -224,7 +225,7 @@ int netdev_nl_napi_get_doit(struct sk_buff *skb, struct genl_info *info)
 		err = -ENOENT;
 	}
 
-	rtnl_unlock();
+	rcu_read_unlock();
 
 	if (err)
 		goto err_free_msg;
-- 
2.47.0.rc0.187.ge670bccf7e-goog


