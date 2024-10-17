Return-Path: <netdev+bounces-136728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DD19A2C37
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 20:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E974B2284A
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB99A18133F;
	Thu, 17 Oct 2024 18:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="CZqFIMip"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA85716EB42
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 18:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729189971; cv=none; b=EcXfYyN5xhQB7115s2IZ3Jp10p9RUfQww5qOVs/q/xqVPMdc6jJlxHRICevAV3s7rU9qH5a72QCiUqG9IdCkLQT6J/ZEQ/a0zll2O9rAsoaUy7oQYUFkthXoH9Aa5wMr+YED4raGxVqeR1ehOoieb0ROffiXBP/t1ZbzYq2TnC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729189971; c=relaxed/simple;
	bh=Wb5Wi1hM05cgjdYn2xMgvGFhlKdE6MpIBJ8Q67qtSzI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gNku0oK88lR5TGmCDsWRDaju4sd9rrp8b4yns+DEz5ZwT0mP80WlFSIS/ticvszEBifvIQVApw/ETg1aUoMSSupINV1xMZhw9vVPn6fisZ9UN/U61pwOIwGGuTo7LnkC4RUSjno1UrU1ndYbG1Eid6da07FGgaQtlV+h534DByQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=CZqFIMip; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729189970; x=1760725970;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vlu1FurEO/A9fkTuG4ODBjrbh1+MwSSfQjG1l7Rtgok=;
  b=CZqFIMipnBnzl3syVsEDlBoOD8l9p2AX9zlar9gtg+p4LlTHr8sUnW0d
   0p5AtgLF7iBV7KVUEX+rEb4Hf9qbEgy3h3zddbT43YUKULI8adn38kWFo
   JgyzoVxd0WK5nLiR+b5+y7JiI0G6T6eLJPYHlZXxouINyMfvuyc1bcJJ9
   o=;
X-IronPort-AV: E=Sophos;i="6.11,211,1725321600"; 
   d="scan'208";a="34139974"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 18:32:47 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:50253]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.202:2525] with esmtp (Farcaster)
 id 1134f79b-b7dc-4c74-b6ef-75a27d610b36; Thu, 17 Oct 2024 18:32:46 +0000 (UTC)
X-Farcaster-Flow-ID: 1134f79b-b7dc-4c74-b6ef-75a27d610b36
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 17 Oct 2024 18:32:45 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.171.30) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 17 Oct 2024 18:32:43 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Remi Denis-Courmont <courmisch@gmail.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 3/9] phonet: Convert phonet_device_list.lock to spinlock_t.
Date: Thu, 17 Oct 2024 11:31:34 -0700
Message-ID: <20241017183140.43028-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241017183140.43028-1-kuniyu@amazon.com>
References: <20241017183140.43028-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA004.ant.amazon.com (10.13.139.93) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

addr_doit() calls phonet_address_add() or phonet_address_del()
for RTM_NEWADDR or RTM_DELADDR, respectively.

Both functions only touch phonet_device_list(dev_net(dev)),
which is currently protected by RTNL and its dedicated mutex,
phonet_device_list.lock.

We will convert addr_doit() to RCU and cannot use mutex inside RCU.

Let's convert the mutex to spinlock_t.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/phonet/pn_dev.h |  3 ++-
 net/phonet/pn_dev.c         | 26 +++++++++++++++++---------
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/include/net/phonet/pn_dev.h b/include/net/phonet/pn_dev.h
index 6b2102b4ece3..ac0331d83a81 100644
--- a/include/net/phonet/pn_dev.h
+++ b/include/net/phonet/pn_dev.h
@@ -12,12 +12,13 @@
 
 #include <linux/list.h>
 #include <linux/mutex.h>
+#include <linux/spinlock.h>
 
 struct net;
 
 struct phonet_device_list {
 	struct list_head list;
-	struct mutex lock;
+	spinlock_t lock;
 };
 
 struct phonet_device_list *phonet_device_list(struct net *net);
diff --git a/net/phonet/pn_dev.c b/net/phonet/pn_dev.c
index 2e7d850dc726..545279ef5910 100644
--- a/net/phonet/pn_dev.c
+++ b/net/phonet/pn_dev.c
@@ -54,7 +54,7 @@ static struct phonet_device *__phonet_device_alloc(struct net_device *dev)
 	pnd->netdev = dev;
 	bitmap_zero(pnd->addrs, 64);
 
-	BUG_ON(!mutex_is_locked(&pndevs->lock));
+	lockdep_assert_held(&pndevs->lock);
 	list_add_rcu(&pnd->list, &pndevs->list);
 	return pnd;
 }
@@ -64,7 +64,8 @@ static struct phonet_device *__phonet_get(struct net_device *dev)
 	struct phonet_device_list *pndevs = phonet_device_list(dev_net(dev));
 	struct phonet_device *pnd;
 
-	BUG_ON(!mutex_is_locked(&pndevs->lock));
+	lockdep_assert_held(&pndevs->lock);
+
 	list_for_each_entry(pnd, &pndevs->list, list) {
 		if (pnd->netdev == dev)
 			return pnd;
@@ -91,11 +92,13 @@ static void phonet_device_destroy(struct net_device *dev)
 
 	ASSERT_RTNL();
 
-	mutex_lock(&pndevs->lock);
+	spin_lock(&pndevs->lock);
+
 	pnd = __phonet_get(dev);
 	if (pnd)
 		list_del_rcu(&pnd->list);
-	mutex_unlock(&pndevs->lock);
+
+	spin_unlock(&pndevs->lock);
 
 	if (pnd) {
 		struct net *net = dev_net(dev);
@@ -136,7 +139,8 @@ int phonet_address_add(struct net_device *dev, u8 addr)
 	struct phonet_device *pnd;
 	int err = 0;
 
-	mutex_lock(&pndevs->lock);
+	spin_lock(&pndevs->lock);
+
 	/* Find or create Phonet-specific device data */
 	pnd = __phonet_get(dev);
 	if (pnd == NULL)
@@ -145,7 +149,9 @@ int phonet_address_add(struct net_device *dev, u8 addr)
 		err = -ENOMEM;
 	else if (test_and_set_bit(addr >> 2, pnd->addrs))
 		err = -EEXIST;
-	mutex_unlock(&pndevs->lock);
+
+	spin_unlock(&pndevs->lock);
+
 	return err;
 }
 
@@ -155,7 +161,8 @@ int phonet_address_del(struct net_device *dev, u8 addr)
 	struct phonet_device *pnd;
 	int err = 0;
 
-	mutex_lock(&pndevs->lock);
+	spin_lock(&pndevs->lock);
+
 	pnd = __phonet_get(dev);
 	if (!pnd || !test_and_clear_bit(addr >> 2, pnd->addrs)) {
 		err = -EADDRNOTAVAIL;
@@ -164,7 +171,8 @@ int phonet_address_del(struct net_device *dev, u8 addr)
 		list_del_rcu(&pnd->list);
 	else
 		pnd = NULL;
-	mutex_unlock(&pndevs->lock);
+
+	spin_unlock(&pndevs->lock);
 
 	if (pnd)
 		kfree_rcu(pnd, rcu);
@@ -313,7 +321,7 @@ static int __net_init phonet_init_net(struct net *net)
 		return -ENOMEM;
 
 	INIT_LIST_HEAD(&pnn->pndevs.list);
-	mutex_init(&pnn->pndevs.lock);
+	spin_lock_init(&pnn->pndevs.lock);
 	mutex_init(&pnn->routes.lock);
 	return 0;
 }
-- 
2.39.5 (Apple Git-154)


