Return-Path: <netdev+bounces-177956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4253A733AA
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 14:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DCF43B836D
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 13:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9572163B8;
	Thu, 27 Mar 2025 13:57:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A367F215F6C
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 13:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743083826; cv=none; b=ezstQOtXgnkyzcAZUfVrIRqbn0NaP4uj4sjuaOi07gJQzk6ZWK5gRZFstRQHcYk3sAXU0X6Gq7lEfywvb2WoQcnvuHV45NzA7Q16AH2A5c4fqGSuYbc/bXsuRCHp/lDjbr8B3NVYfIs+UNFqD/wKQr8KpQ2bZPRy0mKPssX5isk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743083826; c=relaxed/simple;
	bh=tm6o/3FxEt4Z+I9o21RZnbS58EvBomkNpdhEpNPWSUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hZB/YqNIhWuwiGZb/ECaA4WM+K5BlCCmsAiToYEAFezQWXEqsjXqktOa8J7Caeon/nMsctSKJub820q3lGJVc0xBY6EbnEoQ6IM6Z/6s3e2FUq8/s6YtBpcMiqDZp/SQc+iI44l6rStubRjcN4VBrMuSE0KHop3/c/lDukenG44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-227b650504fso22015785ad.0
        for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 06:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743083823; x=1743688623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTKaip8E4PutjEdyQWuPX2ECkZPWrWyOQOPPOifxHHw=;
        b=A6H0pGLY7TI8jeiaWaWSO38MIuqZigdPcNe3Qaeuhx40xzrbsrbzNMX7/xeX8dwm+M
         OlxgxphmWO9R69Qgl3xKzvet7588snN1YWgFTwyvZQR2enlvafO+qcmNg0WzmMZ14CSb
         //2JFn5d1I+OewVh9fStyghSHjWl6oQlupo78ACrJfZ+L0a0B+KtCUyWamODNtZ0Zlpj
         zUzVRT9rL4ZcHADL/0NLh/Oh74p4L/2aMUnvp/33AZEf6qk/pKdehqct6RHGT0x4LAD9
         VZPO6uBLXkU1ZPXl8zPdrrGJ0OnJFzOZLgckzwScGAD/tLrWYxj5SYWEITLh4txCcnkg
         cfLA==
X-Gm-Message-State: AOJu0YycMWKllMEgRSkmwUMWW633djewEJ/A2Tml1Y0sGh7GC19+izzf
	T/md4BtizBaZ9vOTIVjJyixe/ENTv71uMGXFtDn0D2vSn5U2mjBQ5HTwApRWAw==
X-Gm-Gg: ASbGncsZNOu4ETRSyMpTkS9bwjo053bjrq+8Pv+6IrLJf7GYYQtuDx2hkIUODlkDynb
	BRXRL3xiJ93wDgh2EGLm7+nHsOu5UQ5DGX/7p78w+W/iXv+tBEPo1MQ/TEnglphmi1nHmFOm49t
	QkiN91LhyKjHkWtfxlg6iS1i7/2yZ9jcdhg+JybZnLulmhzm6oJGTmFC0tidCStrI4DTox7bKmz
	CGL80PNfICvd+TL2DMRO3HvjuLmI9MdhYqFuXJxn6iK0Y2zTSt4RhEAiWk4q/fQLS4lsViQ5kI9
	Xf+8eDG214CEPUO4TnpPeyy0x/Ye1YX6fBxf2IW6lKV8
X-Google-Smtp-Source: AGHT+IG/+S0nX8H4zC9wGq/aebxmJAwNASqowSKOmkxT9NnSzbbU8FFXdyUOy8/LMLPNo+wDyFCpiQ==
X-Received: by 2002:a17:902:d511:b0:223:47e4:d288 with SMTP id d9443c01a7336-2280493bf03mr44140515ad.47.1743083823445;
        Thu, 27 Mar 2025 06:57:03 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-227811c0cb8sm128128565ad.122.2025.03.27.06.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 06:57:03 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH net v2 02/11] net: hold instance lock during NETDEV_REGISTER/UP/UNREGISTER
Date: Thu, 27 Mar 2025 06:56:50 -0700
Message-ID: <20250327135659.2057487-3-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250327135659.2057487-1-sdf@fomichev.me>
References: <20250327135659.2057487-1-sdf@fomichev.me>
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
 net/core/dev.c | 66 ++++++++++++++++++++++++++++++++++----------------
 1 file changed, 45 insertions(+), 21 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 80523f75ee6b..019f838f94d8 100644
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
+						struct net_device *locked)
 {
 	if (dev->flags & IFF_UP) {
 		call_netdevice_notifier(nb, NETDEV_GOING_DOWN,
 					dev);
 		call_netdevice_notifier(nb, NETDEV_DOWN, dev);
 	}
+	if (dev != locked)
+		netdev_lock_ops(dev);
 	call_netdevice_notifier(nb, NETDEV_UNREGISTER, dev);
+	if (dev != locked)
+		netdev_unlock_ops(dev);
 }
 
 static int call_netdevice_register_net_notifiers(struct notifier_block *nb,
-						 struct net *net)
+						 struct net *net,
+						 struct net_device *locked)
 {
 	struct net_device *dev;
 	int err;
 
 	for_each_netdev(net, dev) {
+		if (locked != dev)
+			netdev_lock_ops(dev);
 		err = call_netdevice_register_notifiers(nb, dev);
+		if (locked != dev)
+			netdev_unlock_ops(dev);
 		if (err)
 			goto rollback;
 	}
@@ -1867,17 +1879,18 @@ static int call_netdevice_register_net_notifiers(struct notifier_block *nb,
 
 rollback:
 	for_each_netdev_continue_reverse(net, dev)
-		call_netdevice_unregister_notifiers(nb, dev);
+		call_netdevice_unregister_notifiers(nb, dev, locked);
 	return err;
 }
 
 static void call_netdevice_unregister_net_notifiers(struct notifier_block *nb,
-						    struct net *net)
+						    struct net *net,
+						    struct net_device *locked)
 {
 	struct net_device *dev;
 
 	for_each_netdev(net, dev)
-		call_netdevice_unregister_notifiers(nb, dev);
+		call_netdevice_unregister_notifiers(nb, dev, locked);
 }
 
 static int dev_boot_phase = 1;
@@ -1914,7 +1927,7 @@ int register_netdevice_notifier(struct notifier_block *nb)
 		goto unlock;
 	for_each_net(net) {
 		__rtnl_net_lock(net);
-		err = call_netdevice_register_net_notifiers(nb, net);
+		err = call_netdevice_register_net_notifiers(nb, net, NULL);
 		__rtnl_net_unlock(net);
 		if (err)
 			goto rollback;
@@ -1928,7 +1941,7 @@ int register_netdevice_notifier(struct notifier_block *nb)
 rollback:
 	for_each_net_continue_reverse(net) {
 		__rtnl_net_lock(net);
-		call_netdevice_unregister_net_notifiers(nb, net);
+		call_netdevice_unregister_net_notifiers(nb, net, NULL);
 		__rtnl_net_unlock(net);
 	}
 
@@ -1965,7 +1978,7 @@ int unregister_netdevice_notifier(struct notifier_block *nb)
 
 	for_each_net(net) {
 		__rtnl_net_lock(net);
-		call_netdevice_unregister_net_notifiers(nb, net);
+		call_netdevice_unregister_net_notifiers(nb, net, NULL);
 		__rtnl_net_unlock(net);
 	}
 
@@ -1978,7 +1991,8 @@ EXPORT_SYMBOL(unregister_netdevice_notifier);
 
 static int __register_netdevice_notifier_net(struct net *net,
 					     struct notifier_block *nb,
-					     bool ignore_call_fail)
+					     bool ignore_call_fail,
+					     struct net_device *locked)
 {
 	int err;
 
@@ -1988,7 +2002,7 @@ static int __register_netdevice_notifier_net(struct net *net,
 	if (dev_boot_phase)
 		return 0;
 
-	err = call_netdevice_register_net_notifiers(nb, net);
+	err = call_netdevice_register_net_notifiers(nb, net, locked);
 	if (err && !ignore_call_fail)
 		goto chain_unregister;
 
@@ -2000,7 +2014,8 @@ static int __register_netdevice_notifier_net(struct net *net,
 }
 
 static int __unregister_netdevice_notifier_net(struct net *net,
-					       struct notifier_block *nb)
+					       struct notifier_block *nb,
+					       struct net_device *locked)
 {
 	int err;
 
@@ -2008,7 +2023,7 @@ static int __unregister_netdevice_notifier_net(struct net *net,
 	if (err)
 		return err;
 
-	call_netdevice_unregister_net_notifiers(nb, net);
+	call_netdevice_unregister_net_notifiers(nb, net, locked);
 	return 0;
 }
 
@@ -2032,7 +2047,7 @@ int register_netdevice_notifier_net(struct net *net, struct notifier_block *nb)
 	int err;
 
 	rtnl_net_lock(net);
-	err = __register_netdevice_notifier_net(net, nb, false);
+	err = __register_netdevice_notifier_net(net, nb, false, NULL);
 	rtnl_net_unlock(net);
 
 	return err;
@@ -2061,7 +2076,7 @@ int unregister_netdevice_notifier_net(struct net *net,
 	int err;
 
 	rtnl_net_lock(net);
-	err = __unregister_netdevice_notifier_net(net, nb);
+	err = __unregister_netdevice_notifier_net(net, nb, NULL);
 	rtnl_net_unlock(net);
 
 	return err;
@@ -2070,10 +2085,11 @@ EXPORT_SYMBOL(unregister_netdevice_notifier_net);
 
 static void __move_netdevice_notifier_net(struct net *src_net,
 					  struct net *dst_net,
-					  struct notifier_block *nb)
+					  struct notifier_block *nb,
+					  struct net_device *locked)
 {
-	__unregister_netdevice_notifier_net(src_net, nb);
-	__register_netdevice_notifier_net(dst_net, nb, true);
+	__unregister_netdevice_notifier_net(src_net, nb, locked);
+	__register_netdevice_notifier_net(dst_net, nb, true, locked);
 }
 
 static void rtnl_net_dev_lock(struct net_device *dev)
@@ -2119,7 +2135,7 @@ int register_netdevice_notifier_dev_net(struct net_device *dev,
 	int err;
 
 	rtnl_net_dev_lock(dev);
-	err = __register_netdevice_notifier_net(dev_net(dev), nb, false);
+	err = __register_netdevice_notifier_net(dev_net(dev), nb, false, NULL);
 	if (!err) {
 		nn->nb = nb;
 		list_add(&nn->list, &dev->net_notifier_list);
@@ -2138,7 +2154,7 @@ int unregister_netdevice_notifier_dev_net(struct net_device *dev,
 
 	rtnl_net_dev_lock(dev);
 	list_del(&nn->list);
-	err = __unregister_netdevice_notifier_net(dev_net(dev), nb);
+	err = __unregister_netdevice_notifier_net(dev_net(dev), nb, NULL);
 	rtnl_net_dev_unlock(dev);
 
 	return err;
@@ -2151,7 +2167,7 @@ static void move_netdevice_notifiers_dev_net(struct net_device *dev,
 	struct netdev_net_notifier *nn;
 
 	list_for_each_entry(nn, &dev->net_notifier_list, list)
-		__move_netdevice_notifier_net(dev_net(dev), net, nn->nb);
+		__move_netdevice_notifier_net(dev_net(dev), net, nn->nb, dev);
 }
 
 /**
@@ -11046,7 +11062,9 @@ int register_netdevice(struct net_device *dev)
 		memcpy(dev->perm_addr, dev->dev_addr, dev->addr_len);
 
 	/* Notify protocols, that a new device appeared. */
+	netdev_lock_ops(dev);
 	ret = call_netdevice_notifiers(NETDEV_REGISTER, dev);
+	netdev_unlock_ops(dev);
 	ret = notifier_to_errno(ret);
 	if (ret) {
 		/* Expect explicit free_netdev() on failure */
@@ -11179,8 +11197,11 @@ static struct net_device *netdev_wait_allrefs_any(struct list_head *list)
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
@@ -11971,7 +11992,9 @@ void unregister_netdevice_many_notify(struct list_head *head,
 		/* Notify protocols, that we are about to destroy
 		 * this device. They should clean all the things.
 		 */
+		netdev_lock_ops(dev);
 		call_netdevice_notifiers(NETDEV_UNREGISTER, dev);
+		netdev_unlock_ops(dev);
 
 		if (!dev->rtnl_link_ops ||
 		    dev->rtnl_link_state == RTNL_LINK_INITIALIZED)
@@ -12068,6 +12091,7 @@ int netif_change_net_namespace(struct net_device *dev, struct net *net,
 	int err, new_nsid;
 
 	ASSERT_RTNL();
+	netdev_ops_assert_locked(dev);
 
 	/* Don't allow namespace local devices to be moved. */
 	err = -EINVAL;
-- 
2.48.1


