Return-Path: <netdev+bounces-136733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E019A2C3E
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 20:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0651B285008
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF40186287;
	Thu, 17 Oct 2024 18:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="v/XiOW0m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871B416EB42
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 18:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729190070; cv=none; b=RVlJ4ul0OkRHdzKjqfcB6j86fLJISJxI7LG6aUlEaDtdQONV6YhEwIdld9S8t5Xkx6i7S+jmF27fDJWECtatRmqp7QoeuhTY3Nkwj88UJKn/Cgvex0MW9lDb++UaEJodv69GcqzHftE9qCepwA7CtNgztcfne84I/KaJyeX+eGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729190070; c=relaxed/simple;
	bh=BihH66Kjkm6iWOOlDZvVkIm8L3Ws1yEIhQlA1S0LvS0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nQC5fGo3SLOrJEWYZiQB8Tx0mMNQztRjiCeZnhw2GJkWvHg1M7VOYRkEsIhUpkUl5mzFBRWnoZvcOJ+BeATmlhCu2UdmCCRmfbeV41CDvIjeSenOzraam0R6glSY8ST0In9U8/bfKhfeZNVx+Y2LdNUiQzhYL8KXeMxzWCV0F7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=v/XiOW0m; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729190066; x=1760726066;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qIJBlJ6K/weC5zqwyqQ3ouI+feXuvuiRV/0uXf+01aQ=;
  b=v/XiOW0m+OgZFKBPXQY/AiGOsQ08ldnXFFnfb/6ArzDDm7FtL2F7ItjX
   06lLdn08nifB6fPVGb13f1tO6SRwNf0ItFMup+Ne/mHdfAJ/cdNa1mAqi
   w7ci2SFCeRXLbldICz0NZsoToR0FA/JIKC1uFYFb6yPKJXR+HCRgaL77B
   8=;
X-IronPort-AV: E=Sophos;i="6.11,211,1725321600"; 
   d="scan'208";a="441691205"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 18:34:22 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:47899]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.7.250:2525] with esmtp (Farcaster)
 id 43ad005f-3bac-4c0d-b293-6545e3419cd2; Thu, 17 Oct 2024 18:34:21 +0000 (UTC)
X-Farcaster-Flow-ID: 43ad005f-3bac-4c0d-b293-6545e3419cd2
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 17 Oct 2024 18:34:20 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.171.30) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 17 Oct 2024 18:34:18 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Remi Denis-Courmont <courmisch@gmail.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 8/9] phonet: Convert phonet_routes.lock to spinlock_t.
Date: Thu, 17 Oct 2024 11:31:39 -0700
Message-ID: <20241017183140.43028-9-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D033UWC003.ant.amazon.com (10.13.139.217) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

route_doit() calls phonet_route_add() or phonet_route_del()
for RTM_NEWROUTE or RTM_DELROUTE, respectively.

Both functions only touch phonet_pernet(dev_net(dev))->routes,
which is currently protected by RTNL and its dedicated mutex,
phonet_routes.lock.

We will convert route_doit() to RCU and cannot use mutex inside RCU.

Let's convert the mutex to spinlock_t.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/phonet/pn_dev.h |  1 -
 net/phonet/pn_dev.c         | 23 ++++++++++++++---------
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/include/net/phonet/pn_dev.h b/include/net/phonet/pn_dev.h
index 021e524fd20a..37a3e83531c6 100644
--- a/include/net/phonet/pn_dev.h
+++ b/include/net/phonet/pn_dev.h
@@ -11,7 +11,6 @@
 #define PN_DEV_H
 
 #include <linux/list.h>
-#include <linux/mutex.h>
 #include <linux/spinlock.h>
 
 struct net;
diff --git a/net/phonet/pn_dev.c b/net/phonet/pn_dev.c
index 6ded0d347b9f..19234d664c4f 100644
--- a/net/phonet/pn_dev.c
+++ b/net/phonet/pn_dev.c
@@ -22,7 +22,7 @@
 #include <net/phonet/pn_dev.h>
 
 struct phonet_routes {
-	struct mutex		lock;
+	spinlock_t		lock;
 	struct net_device __rcu	*table[64];
 };
 
@@ -273,13 +273,15 @@ static void phonet_route_autodel(struct net_device *dev)
 
 	/* Remove left-over Phonet routes */
 	bitmap_zero(deleted, 64);
-	mutex_lock(&pnn->routes.lock);
-	for (i = 0; i < 64; i++)
+
+	spin_lock(&pnn->routes.lock);
+	for (i = 0; i < 64; i++) {
 		if (rcu_access_pointer(pnn->routes.table[i]) == dev) {
 			RCU_INIT_POINTER(pnn->routes.table[i], NULL);
 			set_bit(i, deleted);
 		}
-	mutex_unlock(&pnn->routes.lock);
+	}
+	spin_unlock(&pnn->routes.lock);
 
 	if (bitmap_empty(deleted, 64))
 		return; /* short-circuit RCU */
@@ -326,7 +328,7 @@ static int __net_init phonet_init_net(struct net *net)
 
 	INIT_LIST_HEAD(&pnn->pndevs.list);
 	spin_lock_init(&pnn->pndevs.lock);
-	mutex_init(&pnn->routes.lock);
+	spin_lock_init(&pnn->routes.lock);
 	return 0;
 }
 
@@ -376,13 +378,15 @@ int phonet_route_add(struct net_device *dev, u8 daddr)
 	int err = -EEXIST;
 
 	daddr = daddr >> 2;
-	mutex_lock(&routes->lock);
+
+	spin_lock(&routes->lock);
 	if (routes->table[daddr] == NULL) {
 		rcu_assign_pointer(routes->table[daddr], dev);
 		dev_hold(dev);
 		err = 0;
 	}
-	mutex_unlock(&routes->lock);
+	spin_unlock(&routes->lock);
+
 	return err;
 }
 
@@ -392,12 +396,13 @@ int phonet_route_del(struct net_device *dev, u8 daddr)
 	struct phonet_routes *routes = &pnn->routes;
 
 	daddr = daddr >> 2;
-	mutex_lock(&routes->lock);
+
+	spin_lock(&routes->lock);
 	if (rcu_access_pointer(routes->table[daddr]) == dev)
 		RCU_INIT_POINTER(routes->table[daddr], NULL);
 	else
 		dev = NULL;
-	mutex_unlock(&routes->lock);
+	spin_unlock(&routes->lock);
 
 	if (!dev)
 		return -ENOENT;
-- 
2.39.5 (Apple Git-154)


