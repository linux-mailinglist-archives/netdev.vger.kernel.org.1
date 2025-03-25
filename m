Return-Path: <netdev+bounces-177622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F09DCA70C0C
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 22:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48BB216FCD9
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 21:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D569A2690FB;
	Tue, 25 Mar 2025 21:31:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D592A165F16
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 21:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742938263; cv=none; b=O3YKvD7UtuefXkNhIOZVKuat7pnZcWFFZfFVbajwGjHSg76hF4P98MnJceiqSpYBwyb6otJBhiY4lvWFRo5W7sjo7PMAEYg1Dn78+9YGdUr4xPj9lKYXFKvLIufFge4Ud/VPdVPvaE/U95ZZhf1osUYy1yNCRhqPRWH22oO/4fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742938263; c=relaxed/simple;
	bh=9cN1mnZYPdbTuLyPYME9DwUnMLCMZGu7wMN0yGCWtMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HoIP52d4/a7ZOXrMvgZa3IlYQsh3Hv/eGMW1FqRW0Iwt6nZ5dGe+MhhHVGx8TjwqksKaSTBrfNco1+INR+KVMeoL7ZG2IX87mZcU0AaBA01Nz1ryI0WV2lVk4Bogjzxbe2c+2feACwf5xgw36JT/JmPPVWBjTP0X7DRHPOkQcgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2241053582dso51203265ad.1
        for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 14:31:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742938261; x=1743543061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qbc9SPvdUhMYEZgc4W/JfKQwvmAd91zf6wDNocXeRcU=;
        b=Ht8bPJdwkWiYa4S9zVhz6bDEYS1NQ4sha8QJHJzUr7EVGRm+Nr7btfrX22YmcJDSIZ
         9ECdSKjPoCNChAtiPqHOlpd39O3nmMw1bkMmxj//zzteksIg8xhDW/8NkrIdtMufd4x3
         a+BPmmUHw8S+13EvZX5E8QWivFRy5AtrFso/WuOE/BL31YBLr1NNBOlXlc7J4vieujKd
         8xDExhr0eTaaweU8EKlx/PHhnC983vPNxX/2YswX1h25Snm4zF96sgqRu4ggUVbVVcGW
         SLVWIGC5EnEuqxbEN1mD/N0f/2RWNQOU8Wuw66NYeXTujeTwZtint/gK8lghnc2QKu8f
         iZfw==
X-Gm-Message-State: AOJu0YxztNE97C/HdrgswU1Bn462GS3MJa3U/BJOjXUJjFc5UaXRSIIP
	E/JmUrQ5JXN3FCtNwkwkEhigyjjCUpkr0sez8QXQR5O8zPPar72tsdPYi98Wew==
X-Gm-Gg: ASbGncuAsLJFHJLfS/KRyl4wD+ym6Ow0pUiY3f1lEZsdgk2MYygufzxIDYQC8Osie5N
	vqUluZXYkboQY7y1e6wyRkA+p7zwAZShb/Q6UALk/DuCExNRSshoLBdy40sCqNW3ZeLUC+uZNMW
	BLlYMMFqA8cPMYNB+F03LSpuzSyn91iO+hiMmLQZBboTD605Z/awHPt6skb8Hc+DSA/wVkC1RrY
	znuu9Ouh44DKETEeTmZga+7UuRWVpt5aMdFcErbPK4E4EjIZn+s/6KEJnDmdmsnnjLtSHHiVonk
	ez5mqXsW8djNQZVKL4XCIlV0HH/vxDmiMYNoqzO3jeJe
X-Google-Smtp-Source: AGHT+IGScIDpf3rIgwEJGKwR8xzuyYdaS4Y7ob6UkPfqZlpFd0FdSRzeJat3aXiuUkX+7CSwPvtplQ==
X-Received: by 2002:a17:903:2350:b0:21f:74ec:1ff0 with SMTP id d9443c01a7336-22780e14e77mr301886455ad.32.1742938260531;
        Tue, 25 Mar 2025 14:31:00 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22780f3b7c2sm95689735ad.8.2025.03.25.14.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 14:30:59 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH net-next 2/9] net: hold instance lock during NETDEV_REGISTER/UP/UNREGISTER
Date: Tue, 25 Mar 2025 14:30:49 -0700
Message-ID: <20250325213056.332902-3-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250325213056.332902-1-sdf@fomichev.me>
References: <20250325213056.332902-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Callers of inetdev_init can come from several places with inconsistent
expectation about netdev instance lock. Grab instance lock during
REGISTER (plus UP) and UNREGISTER netdev notifiers.

Take extra care in the path that re-registers the notifiers during
net namespace move (all the dance with extra 'lock' argument).

WARNING: CPU: 10 PID: 1479 at ./include/net/netdev_lock.h:54
__netdev_update_features+0x65f/0xca0
__warn+0x81/0x180
__netdev_update_features+0x65f/0xca0
report_bug+0x156/0x180
handle_bug+0x4f/0x90
exc_invalid_op+0x13/0x60
asm_exc_invalid_op+0x16/0x20
__netdev_update_features+0x65f/0xca0
netif_disable_lro+0x30/0x1d0
inetdev_init+0x12f/0x1f0
inetdev_event+0x48b/0x870
notifier_call_chain+0x38/0xf0
register_netdevice+0x741/0x8b0
register_netdev+0x1f/0x40
mlx5e_probe+0x4e3/0x8e0 [mlx5_core]
auxiliary_bus_probe+0x3f/0x90
really_probe+0xc3/0x3a0
__driver_probe_device+0x80/0x150
driver_probe_device+0x1f/0x90
__device_attach_driver+0x7d/0x100
bus_for_each_drv+0x80/0xd0
__device_attach+0xb4/0x1c0
bus_probe_device+0x91/0xa0
device_add+0x657/0x870

Reported-by: Cosmin Ratiu <cratiu@nvidia.com>
Fixes: ad7c7b2172c3 ("net: hold netdev instance lock during sysfs operations")
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 net/core/dev.c | 61 ++++++++++++++++++++++++++++++++++----------------
 1 file changed, 42 insertions(+), 19 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 8df428fc6924..bbcf302b53a8 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1829,6 +1829,8 @@ static int call_netdevice_register_notifiers(struct notifier_block *nb,
 {
 	int err;
 
+	netdev_ops_assert_locked(dev);
+
 	err = call_netdevice_notifier(nb, NETDEV_REGISTER, dev);
 	err = notifier_to_errno(err);
 	if (err)
@@ -1842,24 +1844,34 @@ static int call_netdevice_register_notifiers(struct notifier_block *nb,
 }
 
 static void call_netdevice_unregister_notifiers(struct notifier_block *nb,
-						struct net_device *dev)
+						struct net_device *dev,
+						bool lock)
 {
 	if (dev->flags & IFF_UP) {
 		call_netdevice_notifier(nb, NETDEV_GOING_DOWN,
 					dev);
 		call_netdevice_notifier(nb, NETDEV_DOWN, dev);
 	}
+	if (lock)
+		netdev_lock_ops(dev);
 	call_netdevice_notifier(nb, NETDEV_UNREGISTER, dev);
+	if (lock)
+		netdev_unlock_ops(dev);
 }
 
 static int call_netdevice_register_net_notifiers(struct notifier_block *nb,
-						 struct net *net)
+						 struct net *net,
+						 bool lock)
 {
 	struct net_device *dev;
 	int err;
 
 	for_each_netdev(net, dev) {
+		if (lock)
+			netdev_lock_ops(dev);
 		err = call_netdevice_register_notifiers(nb, dev);
+		if (lock)
+			netdev_unlock_ops(dev);
 		if (err)
 			goto rollback;
 	}
@@ -1867,17 +1879,18 @@ static int call_netdevice_register_net_notifiers(struct notifier_block *nb,
 
 rollback:
 	for_each_netdev_continue_reverse(net, dev)
-		call_netdevice_unregister_notifiers(nb, dev);
+		call_netdevice_unregister_notifiers(nb, dev, lock);
 	return err;
 }
 
 static void call_netdevice_unregister_net_notifiers(struct notifier_block *nb,
-						    struct net *net)
+						    struct net *net,
+						    bool lock)
 {
 	struct net_device *dev;
 
 	for_each_netdev(net, dev)
-		call_netdevice_unregister_notifiers(nb, dev);
+		call_netdevice_unregister_notifiers(nb, dev, lock);
 }
 
 static int dev_boot_phase = 1;
@@ -1914,7 +1927,7 @@ int register_netdevice_notifier(struct notifier_block *nb)
 		goto unlock;
 	for_each_net(net) {
 		__rtnl_net_lock(net);
-		err = call_netdevice_register_net_notifiers(nb, net);
+		err = call_netdevice_register_net_notifiers(nb, net, true);
 		__rtnl_net_unlock(net);
 		if (err)
 			goto rollback;
@@ -1928,7 +1941,7 @@ int register_netdevice_notifier(struct notifier_block *nb)
 rollback:
 	for_each_net_continue_reverse(net) {
 		__rtnl_net_lock(net);
-		call_netdevice_unregister_net_notifiers(nb, net);
+		call_netdevice_unregister_net_notifiers(nb, net, true);
 		__rtnl_net_unlock(net);
 	}
 
@@ -1965,7 +1978,7 @@ int unregister_netdevice_notifier(struct notifier_block *nb)
 
 	for_each_net(net) {
 		__rtnl_net_lock(net);
-		call_netdevice_unregister_net_notifiers(nb, net);
+		call_netdevice_unregister_net_notifiers(nb, net, true);
 		__rtnl_net_unlock(net);
 	}
 
@@ -1978,7 +1991,8 @@ EXPORT_SYMBOL(unregister_netdevice_notifier);
 
 static int __register_netdevice_notifier_net(struct net *net,
 					     struct notifier_block *nb,
-					     bool ignore_call_fail)
+					     bool ignore_call_fail,
+					     bool lock)
 {
 	int err;
 
@@ -1988,7 +2002,7 @@ static int __register_netdevice_notifier_net(struct net *net,
 	if (dev_boot_phase)
 		return 0;
 
-	err = call_netdevice_register_net_notifiers(nb, net);
+	err = call_netdevice_register_net_notifiers(nb, net, lock);
 	if (err && !ignore_call_fail)
 		goto chain_unregister;
 
@@ -2000,7 +2014,8 @@ static int __register_netdevice_notifier_net(struct net *net,
 }
 
 static int __unregister_netdevice_notifier_net(struct net *net,
-					       struct notifier_block *nb)
+					       struct notifier_block *nb,
+					       bool lock)
 {
 	int err;
 
@@ -2008,7 +2023,7 @@ static int __unregister_netdevice_notifier_net(struct net *net,
 	if (err)
 		return err;
 
-	call_netdevice_unregister_net_notifiers(nb, net);
+	call_netdevice_unregister_net_notifiers(nb, net, lock);
 	return 0;
 }
 
@@ -2032,7 +2047,7 @@ int register_netdevice_notifier_net(struct net *net, struct notifier_block *nb)
 	int err;
 
 	rtnl_net_lock(net);
-	err = __register_netdevice_notifier_net(net, nb, false);
+	err = __register_netdevice_notifier_net(net, nb, false, true);
 	rtnl_net_unlock(net);
 
 	return err;
@@ -2061,7 +2076,7 @@ int unregister_netdevice_notifier_net(struct net *net,
 	int err;
 
 	rtnl_net_lock(net);
-	err = __unregister_netdevice_notifier_net(net, nb);
+	err = __unregister_netdevice_notifier_net(net, nb, true);
 	rtnl_net_unlock(net);
 
 	return err;
@@ -2072,8 +2087,8 @@ static void __move_netdevice_notifier_net(struct net *src_net,
 					  struct net *dst_net,
 					  struct notifier_block *nb)
 {
-	__unregister_netdevice_notifier_net(src_net, nb);
-	__register_netdevice_notifier_net(dst_net, nb, true);
+	__unregister_netdevice_notifier_net(src_net, nb, false);
+	__register_netdevice_notifier_net(dst_net, nb, true, false);
 }
 
 static void rtnl_net_dev_lock(struct net_device *dev)
@@ -2119,7 +2134,7 @@ int register_netdevice_notifier_dev_net(struct net_device *dev,
 	int err;
 
 	rtnl_net_dev_lock(dev);
-	err = __register_netdevice_notifier_net(dev_net(dev), nb, false);
+	err = __register_netdevice_notifier_net(dev_net(dev), nb, false, true);
 	if (!err) {
 		nn->nb = nb;
 		list_add(&nn->list, &dev->net_notifier_list);
@@ -2138,7 +2153,7 @@ int unregister_netdevice_notifier_dev_net(struct net_device *dev,
 
 	rtnl_net_dev_lock(dev);
 	list_del(&nn->list);
-	err = __unregister_netdevice_notifier_net(dev_net(dev), nb);
+	err = __unregister_netdevice_notifier_net(dev_net(dev), nb, true);
 	rtnl_net_dev_unlock(dev);
 
 	return err;
@@ -11047,7 +11062,9 @@ int register_netdevice(struct net_device *dev)
 		memcpy(dev->perm_addr, dev->dev_addr, dev->addr_len);
 
 	/* Notify protocols, that a new device appeared. */
+	netdev_lock_ops(dev);
 	ret = call_netdevice_notifiers(NETDEV_REGISTER, dev);
+	netdev_unlock_ops(dev);
 	ret = notifier_to_errno(ret);
 	if (ret) {
 		/* Expect explicit free_netdev() on failure */
@@ -11180,8 +11197,11 @@ static struct net_device *netdev_wait_allrefs_any(struct list_head *list)
 			rtnl_lock();
 
 			/* Rebroadcast unregister notification */
-			list_for_each_entry(dev, list, todo_list)
+			list_for_each_entry(dev, list, todo_list) {
+				netdev_lock_ops(dev);
 				call_netdevice_notifiers(NETDEV_UNREGISTER, dev);
+				netdev_unlock_ops(dev);
+			}
 
 			__rtnl_unlock();
 			rcu_barrier();
@@ -11972,7 +11992,9 @@ void unregister_netdevice_many_notify(struct list_head *head,
 		/* Notify protocols, that we are about to destroy
 		 * this device. They should clean all the things.
 		 */
+		netdev_lock_ops(dev);
 		call_netdevice_notifiers(NETDEV_UNREGISTER, dev);
+		netdev_unlock_ops(dev);
 
 		if (!dev->rtnl_link_ops ||
 		    dev->rtnl_link_state == RTNL_LINK_INITIALIZED)
@@ -12069,6 +12091,7 @@ int netif_change_net_namespace(struct net_device *dev, struct net *net,
 	int err, new_nsid;
 
 	ASSERT_RTNL();
+	netdev_ops_assert_locked(dev);
 
 	/* Don't allow namespace local devices to be moved. */
 	err = -EINVAL;
-- 
2.48.1


