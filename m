Return-Path: <netdev+bounces-178654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BF7A78093
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 18:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55AE616B43D
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 16:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4653120C48C;
	Tue,  1 Apr 2025 16:35:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D5720E313
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 16:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743525304; cv=none; b=gPNVElpuSEahclovjO4gQSYyjNLdYxYZnHe7jinWWDF/4zuUwAVPFoS0uY5gc3ls5YLjPz+TAK3K52wkZGpw+IxxONbWmUhc0ufCY2gAZL1VeLLC8wlVI7+rW2OMu8R7w9Wlq1DixIqtxKVq6/ZrVmC4lY86GvW8EzINAvjhd5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743525304; c=relaxed/simple;
	bh=37DPlTB1m+vNulI3hmYc3tDyAAJiHuA+wLkwQsf3Un8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LED/RJtHLW9eyn8MLjP6BJQhOyS9zYIkzywX5en0UNANpRJK3pCNKFkUawAPx6rq5rQyh69tFKqfUxnyohokbw0xR6R00HTM0sirFtFzxzr0/6I0oy1aV66IKjGc0/95GklT4JbuG9gfZXV2UHQqnfAyowUkmSrT8UI7ocU31K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2260c91576aso92327295ad.3
        for <netdev@vger.kernel.org>; Tue, 01 Apr 2025 09:35:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743525301; x=1744130101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QtrkWp/IUEbfiPxi5ET2roEwQfuYzRFO4zkGAj8DquA=;
        b=SZeC8YhOM44NAPdBJ4zyiLeoOsMwIunYBxyHnLiMN8dSAgmR2cgMSw1UBcLUCMnQCl
         oWkNDzYvznEuZUkERKCRaUfSrT6ejOVKWO4Jk9Wjn8Vk4Yu4407qZUQpJ7KfAZcHsE0C
         /Hb8PXzmrszEqrUaMEMm4x4vXBWDVls0qhxJ1oGwx4SymY8ucXALJWCBFZWVS+xJw5/s
         sTbjZuIvrS8/MGFVrz1lrJI/+v1ZNHJh3lFnJqM/CvGNOiFLQur2pOsy+3P/f6xmLpB1
         uLCUVvSvPbcNU4gkV9obqR7lgJ9Bk6kPDD8VqHD8hGNsItJ6NZoLDTQxkF7miggE9zwd
         xrtw==
X-Gm-Message-State: AOJu0YzHWg4BuM+1ytOltxbOuQZS47CfCwSxlYPv/FZc9aZTq+gPYFtZ
	6rH4MzSQLGR0EGO3Wt5dhYtaoVhmpyyJ+CLssGsGFnYtLzD5TOn4ANs2+8H3nw==
X-Gm-Gg: ASbGncvQn6UtJ100tku9avgLcGSkhRhfUdGWst7BC8dOpBOU81rB+blYlj+Q9BCxpy9
	MbwsBH9Es/RuhczaD4jQqgdjhwn+d2/XDAsgiL68WQFqJMYOslT/cDJfPhhCAczJvz+UAZeGh+l
	2sn23iL1wwicJFvi4TzFaRvARWD7j2L/a5AGpM8bFYYOdmv6P63PfkGv7qRIO7ka4APLjGvLTl5
	mHVXw4tOVwWxay6StLToh7bvT+oMf9+WRwjrp5Qv3wqpALgBBu76DtOuQo4d0A7o4CxnLNKKmcE
	QBxi5KisIKY1lXDv2P32siohLZNWg/wro9zVydoxia9nTR05o9vG4jI=
X-Google-Smtp-Source: AGHT+IE7QtvIM/kCpjnL0I+6bU7HziVdI2MSwS7kXtHjLp24ijHW5tP/29JZGijVvCfUuKSxM1osSQ==
X-Received: by 2002:a17:902:da83:b0:227:e7c7:d451 with SMTP id d9443c01a7336-2292f974b3emr226446835ad.29.1743525301231;
        Tue, 01 Apr 2025 09:35:01 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2291eee03f5sm91135375ad.99.2025.04.01.09.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 09:35:00 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net v5 05/11] netdevsim: add dummy device notifiers
Date: Tue,  1 Apr 2025 09:34:46 -0700
Message-ID: <20250401163452.622454-6-sdf@fomichev.me>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250401163452.622454-1-sdf@fomichev.me>
References: <20250401163452.622454-1-sdf@fomichev.me>
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
 drivers/net/netdevsim/netdev.c    | 13 +++++++++++++
 drivers/net/netdevsim/netdevsim.h |  3 +++
 include/net/netdev_lock.h         |  3 +++
 net/core/lock_debug.c             | 14 +++++++++-----
 4 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index b67af4651185..ddda0c1e7a6d 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -939,6 +939,7 @@ static int nsim_init_netdevsim(struct netdevsim *ns)
 	ns->netdev->netdev_ops = &nsim_netdev_ops;
 	ns->netdev->stat_ops = &nsim_stat_ops;
 	ns->netdev->queue_mgmt_ops = &nsim_queue_mgmt_ops;
+	netdev_lockdep_set_classes(ns->netdev);
 
 	err = nsim_udp_tunnels_info_create(ns->nsim_dev, ns->netdev);
 	if (err)
@@ -960,6 +961,14 @@ static int nsim_init_netdevsim(struct netdevsim *ns)
 	if (err)
 		goto err_ipsec_teardown;
 	rtnl_unlock();
+
+	if (IS_ENABLED(CONFIG_DEBUG_NET)) {
+		ns->nb.notifier_call = netdev_debug_event;
+		if (register_netdevice_notifier_dev_net(ns->netdev, &ns->nb,
+							&ns->nn))
+			ns->nb.notifier_call = NULL;
+	}
+
 	return 0;
 
 err_ipsec_teardown:
@@ -1043,6 +1052,10 @@ void nsim_destroy(struct netdevsim *ns)
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
index 1c0c9a94cc22..c316b551df8d 100644
--- a/include/net/netdev_lock.h
+++ b/include/net/netdev_lock.h
@@ -98,4 +98,7 @@ static inline int netdev_lock_cmp_fn(const struct lockdep_map *a,
 				  &qdisc_xmit_lock_key);	\
 }
 
+int netdev_debug_event(struct notifier_block *nb, unsigned long event,
+		       void *ptr);
+
 #endif
diff --git a/net/core/lock_debug.c b/net/core/lock_debug.c
index 7ecd28cc1c22..72e522a68775 100644
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
+EXPORT_SYMBOL_NS_GPL(netdev_debug_event, "NETDEV_INTERNAL");
 
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
2.49.0


