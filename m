Return-Path: <netdev+bounces-178202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 636BDA75788
	for <lists+netdev@lfdr.de>; Sat, 29 Mar 2025 19:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9C213A8EB0
	for <lists+netdev@lfdr.de>; Sat, 29 Mar 2025 18:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D091DE892;
	Sat, 29 Mar 2025 18:57:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBC11B3927
	for <netdev@vger.kernel.org>; Sat, 29 Mar 2025 18:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743274636; cv=none; b=X+4SUKYTDp3yJ7uQXjFIgtO30Dijg759azpwiqNcsvqBfdJ9xDbbijz08bBj+/PbDmAcrxEu9YmELXsRqaqkeZFtTJS8zsv3XSeXljWwZPA2tRVSJAmR5xz+W6BlIiRzUx96R7LZ2/VnVEpI2Vk2uHMTcrjW7h+/2VVM2Aa42iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743274636; c=relaxed/simple;
	bh=fk6PCYPeCeRjRPK+RnICodseYYpTy/4gvY4+yGXBwgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NScw8sPmDxpYwTlUYJNC4Hc/JaJa7Styrb1Vc8nQK+Lx9q/bGtaxBa8tICNkZufJKsQeWIP4fWfQUObT3W06VClSlKq4FnhXVPNUh5YMaGRMM32MyXXXKBtNBkVJEJQ5nv9ppfAj/G4fVcgYUhWvT5E6fki+2NCGLYKdkMX4yO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-227b828de00so59043115ad.1
        for <netdev@vger.kernel.org>; Sat, 29 Mar 2025 11:57:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743274634; x=1743879434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IxdX0i18cLiiRxO0Z5z7ViZeMQPVjKCK2cApBMaWKX8=;
        b=puvg/sNqOxk1wSxKi3T0SXNFB+Im/DtPvOlrKy/dqCeJ1emCAplwCn4uX38y/91jYX
         xYRruN2iYDxq+eY/8yflwgUSh0VVF/3qXNf9MnBFEOR6So9b2K3RKk3JpSspNRqE0ZUZ
         IN7meQs2PuAtexX4neEAyObKoTNxuUJB2OObYOjB2bi0oBVbTeDEuITlMbbbgu4qy6Il
         c9Cd1Pos7RmhLeA8bmBrGcZklsxdAeR4hilLxNxnSayQ/eDp9rM9KQVPynLJgn/ABUyD
         tRQ6OWJGqXJvV3kNSfsAa/ybW9RZujQ2Ky7LJeJIEZNtI7tNZOZrpwk5gkZy/KMBL0//
         qsAA==
X-Gm-Message-State: AOJu0YzHQpVZewzqsbwIiBRsoY7vvIJqX/70pE5qs7dzNWfldSG0CDVM
	LUsJJVyZfCxB2PSwcopxhAjXgXrscvNf/VK4NFCQWn71fnjQqtgI/d6FVyA=
X-Gm-Gg: ASbGncvEQgVKmXZPJSqSJ8WR64mcQ9I+DeyzR4GbBrN09iWrj0eWpB+7knLuF8TdMIU
	mu5b12JH2N57TM0mf/4q6c+rIFf7fxXI/AdGrGoL15Kv2CoBXy2gxOBOxh9VVjLesmEXJVp4Flq
	WeTeEzN1LRcunZk2oj4+Hc5Me5dBegjHl6RwGOaQFeztczxPoRdMPh8tkjgC5RNzq8uE86vaT4D
	ugziMeA+AP+YW4lq9UoMyWZRhPp3lZ/YT7ii+LSa0Ku5aosoHpypoQBn/aDv+l8Uja4Wtn7l0uc
	iK0Bdw+4iSeXobz+YdQFqrwy1YgRAv7HVIcmRfRL0wDe
X-Google-Smtp-Source: AGHT+IFgp3tcjw63weALhXZ+PfsrkBIChYzrgTusrXg+OZnCdS6Qok1BYwr6NRj5Dv9z7Ldkg0dyHw==
X-Received: by 2002:a05:6a20:3d95:b0:1f5:64a4:aeac with SMTP id adf61e73a8af0-2009f7535d0mr5133607637.33.1743274633666;
        Sat, 29 Mar 2025 11:57:13 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-af93b6d6f77sm3057224a12.36.2025.03.29.11.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 11:57:13 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net v3 05/11] netdevsim: add dummy device notifiers
Date: Sat, 29 Mar 2025 11:56:58 -0700
Message-ID: <20250329185704.676589-6-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250329185704.676589-1-sdf@fomichev.me>
References: <20250329185704.676589-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to exercise and verify notifiers' locking assumptions,
register dummy notifiers (via register_netdevice_notifier_dev_net).
Share notifier event handler that enforces the assumptions with
lock_debug.c (rename and export rtnl_net_debug_event as
netdev_debug_event). Add ops lock asserts to netdev_debug_event.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/netdevsim/netdev.c    | 10 ++++++++++
 drivers/net/netdevsim/netdevsim.h |  3 +++
 include/net/netdev_lock.h         | 11 +++++++++++
 net/core/lock_debug.c             | 14 +++++++++-----
 4 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index b67af4651185..6188699aa241 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -939,6 +939,7 @@ static int nsim_init_netdevsim(struct netdevsim *ns)
 	ns->netdev->netdev_ops = &nsim_netdev_ops;
 	ns->netdev->stat_ops = &nsim_stat_ops;
 	ns->netdev->queue_mgmt_ops = &nsim_queue_mgmt_ops;
+	netdev_lockdep_set_classes(ns->netdev);
 
 	err = nsim_udp_tunnels_info_create(ns->nsim_dev, ns->netdev);
 	if (err)
@@ -960,6 +961,11 @@ static int nsim_init_netdevsim(struct netdevsim *ns)
 	if (err)
 		goto err_ipsec_teardown;
 	rtnl_unlock();
+
+	ns->nb.notifier_call = netdev_debug_event;
+	if (register_netdevice_notifier_dev_net(ns->netdev, &ns->nb, &ns->nn))
+		ns->nb.notifier_call = NULL;
+
 	return 0;
 
 err_ipsec_teardown:
@@ -1043,6 +1049,10 @@ void nsim_destroy(struct netdevsim *ns)
 	debugfs_remove(ns->qr_dfs);
 	debugfs_remove(ns->pp_dfs);
 
+	if (ns->nb.notifier_call)
+		unregister_netdevice_notifier_dev_net(ns->netdev, &ns->nb,
+						      &ns->nn);
+
 	rtnl_lock();
 	peer = rtnl_dereference(ns->peer);
 	if (peer)
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index 665020d18f29..d04401f0bdf7 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -144,6 +144,9 @@ struct netdevsim {
 
 	struct nsim_ethtool ethtool;
 	struct netdevsim __rcu *peer;
+
+	struct notifier_block nb;
+	struct netdev_net_notifier nn;
 };
 
 struct netdevsim *
diff --git a/include/net/netdev_lock.h b/include/net/netdev_lock.h
index 1c0c9a94cc22..5f712de5bf8a 100644
--- a/include/net/netdev_lock.h
+++ b/include/net/netdev_lock.h
@@ -98,4 +98,15 @@ static inline int netdev_lock_cmp_fn(const struct lockdep_map *a,
 				  &qdisc_xmit_lock_key);	\
 }
 
+#if IS_ENABLED(CONFIG_DEBUG_NET)
+int netdev_debug_event(struct notifier_block *nb, unsigned long event,
+		       void *ptr);
+#else
+static inline int netdev_debug_event(struct notifier_block *nb,
+				     unsigned long event, void *ptr)
+{
+	return 0;
+}
+#endif
+
 #endif
diff --git a/net/core/lock_debug.c b/net/core/lock_debug.c
index 7ecd28cc1c22..506899164f31 100644
--- a/net/core/lock_debug.c
+++ b/net/core/lock_debug.c
@@ -6,10 +6,11 @@
 #include <linux/notifier.h>
 #include <linux/rtnetlink.h>
 #include <net/net_namespace.h>
+#include <net/netdev_lock.h>
 #include <net/netns/generic.h>
 
-static int rtnl_net_debug_event(struct notifier_block *nb,
-				unsigned long event, void *ptr)
+int netdev_debug_event(struct notifier_block *nb, unsigned long event,
+		       void *ptr)
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
 	struct net *net = dev_net(dev);
@@ -17,11 +18,13 @@ static int rtnl_net_debug_event(struct notifier_block *nb,
 
 	/* Keep enum and don't add default to trigger -Werror=switch */
 	switch (cmd) {
+	case NETDEV_REGISTER:
 	case NETDEV_UP:
+		netdev_ops_assert_locked(dev);
+		fallthrough;
 	case NETDEV_DOWN:
 	case NETDEV_REBOOT:
 	case NETDEV_CHANGE:
-	case NETDEV_REGISTER:
 	case NETDEV_UNREGISTER:
 	case NETDEV_CHANGEMTU:
 	case NETDEV_CHANGEADDR:
@@ -66,6 +69,7 @@ static int rtnl_net_debug_event(struct notifier_block *nb,
 
 	return NOTIFY_DONE;
 }
+EXPORT_SYMBOL_GPL(netdev_debug_event);
 
 static int rtnl_net_debug_net_id;
 
@@ -74,7 +78,7 @@ static int __net_init rtnl_net_debug_net_init(struct net *net)
 	struct notifier_block *nb;
 
 	nb = net_generic(net, rtnl_net_debug_net_id);
-	nb->notifier_call = rtnl_net_debug_event;
+	nb->notifier_call = netdev_debug_event;
 
 	return register_netdevice_notifier_net(net, nb);
 }
@@ -95,7 +99,7 @@ static struct pernet_operations rtnl_net_debug_net_ops __net_initdata = {
 };
 
 static struct notifier_block rtnl_net_debug_block = {
-	.notifier_call = rtnl_net_debug_event,
+	.notifier_call = netdev_debug_event,
 };
 
 static int __init rtnl_net_debug_init(void)
-- 
2.48.1


