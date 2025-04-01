Return-Path: <netdev+bounces-178651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEC9A78089
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 18:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 953377A4185
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 16:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076F420DD51;
	Tue,  1 Apr 2025 16:35:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F9A20D4F7
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 16:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743525299; cv=none; b=ekBkj8JUzWMxRSq4p5SbFckjfvSXDHS4Bs9akZMOGLLGzx05xZfoQnxJzlxfZ42BTDqUHvDQ5LsXFr8IInnpH7x4V4GZwPcrzhkCguEgqn/ZrEQaVNJNnSueG2neqt7Pv7nyFxLkDHctAEvKFl3z1EvToqtx9lj8i8DZCLhhyDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743525299; c=relaxed/simple;
	bh=NCJWGxBSpQ5TCQWjoI6vVXAt0Odv6zejZA4HfO9GObw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B5z8DRo6Ar8cCludg4O/oJijpMHCAmzZHTz0wxjn+U/PNiH6cRlJod76FL+tkezCcPd2SniIX562qBdW9evVTpIQcNziR3BuMRlNB5fDqewgdedblS/GZ+G/iS3z5/ZEGZZ246e4nZ7RwmzLULJTHMuYeIydYocFswB/hikGmko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ff615a114bso21983a91.0
        for <netdev@vger.kernel.org>; Tue, 01 Apr 2025 09:34:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743525297; x=1744130097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M6vlPCUZHkjrtvyT/1+ymW/z2m3BuDKhtRHAQhec/o8=;
        b=PWHJRFnV3UGaILdXGXGrtyMmUF13ltk/ACvXrxdS2MyP0krwxdJxVmyR0t3rmIBHVT
         Er9CBg9uKcWCmoTbOGJPTtjPDMvoNiYY9hpBVOnEwvKV5vB2qbCZ8efvid54iOA8VfRK
         U5mVUQiYexXQSz6SjdcHJwbMj8FE6h14K2QUY1OVQDhL0v5/Pu07wK6c10aB/e9Htr2q
         syl0zDkNEifY0g0ukbEkiKuX/fXArjBZg3j/j43YwxqGTJueK1izCOTiBwpgqxR+zxd3
         K4pzEwqPfQydcfKsF3mAFE1fK3pSrtffEgQTy+r2eX1V2u4Jzv2C/1UJ2dPTaGjQhTn7
         jDIA==
X-Gm-Message-State: AOJu0YwWsNd1nE87DYnBDryCFzARuEjY/q1T0JgbJO70O+UEF8/rWWBY
	dK+Mu1FIm7YAfnGR2P/p7o4VmZTa8NYihD4ArqZhhAPPBxAXUHdnUQrvC41SoQ==
X-Gm-Gg: ASbGncucqwF3TM+zyCnqUAB08AOTzrUPj/GKQfVAdZcJJDYE9J7jVKkgQe6pp8j0NUC
	o13ZNTGwZSEAp5EPFHpPHmFdwAxtLCXfDjnbT6EteSPBw/Qq+n28l77cZIOaGg46DVqCtDxZyJ9
	2pJKvOoSwsj43gXqBA+ma57pyJnkWwHFRqHQ15VI7+4v8IJCHGe/Vvc8/fq3Qz5/ZmOC1/g5tUQ
	zcRlenZvv8v8DI/Eli/JwJL0/cGjz9ijragVZ51vFiDXkSpjbUgej8+GWeiQ9/XcDRT3wR32cJO
	6o0J5ZI5nZrBmYNt77u4rTdk8I7yh907Lkr76SWIWePL
X-Google-Smtp-Source: AGHT+IGO9IxGvKS6j0PpKgBt6rYY7VeUbvWWePJHFog8JiXlaYqW4MwEZmxkSX0P8UqqMt54MgAsOw==
X-Received: by 2002:a17:90b:5750:b0:2fb:fe21:4841 with SMTP id 98e67ed59e1d1-3056b70940fmr1015529a91.8.1743525297001;
        Tue, 01 Apr 2025 09:34:57 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-30516fed6f4sm9500406a91.32.2025.04.01.09.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 09:34:56 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH net v5 02/11] net: hold instance lock during NETDEV_REGISTER/UP
Date: Tue,  1 Apr 2025 09:34:43 -0700
Message-ID: <20250401163452.622454-3-sdf@fomichev.me>
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

Callers of inetdev_init can come from several places with inconsistent
expectation about netdev instance lock. Grab instance lock during
REGISTER (plus UP). Also solve the inconsistency with UNREGISTER
where it was locked only during move netns path.

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

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Reported-by: Cosmin Ratiu <cratiu@nvidia.com>
Fixes: ad7c7b2172c3 ("net: hold netdev instance lock during sysfs operations")
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 include/linux/netdevice.h |  2 +-
 net/core/dev.c            | 12 +++++++++---
 net/core/dev_api.c        |  8 +-------
 net/core/rtnetlink.c      |  8 ++++----
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index fa79145518d1..cf3b6445817b 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4192,7 +4192,7 @@ int dev_change_flags(struct net_device *dev, unsigned int flags,
 int netif_set_alias(struct net_device *dev, const char *alias, size_t len);
 int dev_set_alias(struct net_device *, const char *, size_t);
 int dev_get_alias(const struct net_device *, char *, size_t);
-int netif_change_net_namespace(struct net_device *dev, struct net *net,
+int __dev_change_net_namespace(struct net_device *dev, struct net *net,
 			       const char *pat, int new_ifindex,
 			       struct netlink_ext_ack *extack);
 int dev_change_net_namespace(struct net_device *dev, struct net *net,
diff --git a/net/core/dev.c b/net/core/dev.c
index be17e0660144..0ebe8d6597f2 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1858,7 +1858,9 @@ static int call_netdevice_register_net_notifiers(struct notifier_block *nb,
 	int err;
 
 	for_each_netdev(net, dev) {
+		netdev_lock_ops(dev);
 		err = call_netdevice_register_notifiers(nb, dev);
+		netdev_unlock_ops(dev);
 		if (err)
 			goto rollback;
 	}
@@ -11045,7 +11047,9 @@ int register_netdevice(struct net_device *dev)
 		memcpy(dev->perm_addr, dev->dev_addr, dev->addr_len);
 
 	/* Notify protocols, that a new device appeared. */
+	netdev_lock_ops(dev);
 	ret = call_netdevice_notifiers(NETDEV_REGISTER, dev);
+	netdev_unlock_ops(dev);
 	ret = notifier_to_errno(ret);
 	if (ret) {
 		/* Expect explicit free_netdev() on failure */
@@ -12057,7 +12061,7 @@ void unregister_netdev(struct net_device *dev)
 }
 EXPORT_SYMBOL(unregister_netdev);
 
-int netif_change_net_namespace(struct net_device *dev, struct net *net,
+int __dev_change_net_namespace(struct net_device *dev, struct net *net,
 			       const char *pat, int new_ifindex,
 			       struct netlink_ext_ack *extack)
 {
@@ -12142,11 +12146,12 @@ int netif_change_net_namespace(struct net_device *dev, struct net *net,
 	 * And now a mini version of register_netdevice unregister_netdevice.
 	 */
 
+	netdev_lock_ops(dev);
 	/* If device is running close it first. */
 	netif_close(dev);
-
 	/* And unlink it from device chain */
 	unlist_netdevice(dev);
+	netdev_unlock_ops(dev);
 
 	synchronize_net();
 
@@ -12208,11 +12213,12 @@ int netif_change_net_namespace(struct net_device *dev, struct net *net,
 	err = netdev_change_owner(dev, net_old, net);
 	WARN_ON(err);
 
+	netdev_lock_ops(dev);
 	/* Add the device back in the hashes */
 	list_netdevice(dev);
-
 	/* Notify protocols, that a new device appeared. */
 	call_netdevice_notifiers(NETDEV_REGISTER, dev);
+	netdev_unlock_ops(dev);
 
 	/*
 	 *	Prevent userspace races by waiting until the network
diff --git a/net/core/dev_api.c b/net/core/dev_api.c
index 8dbc60612100..90bafb0b1b8c 100644
--- a/net/core/dev_api.c
+++ b/net/core/dev_api.c
@@ -117,13 +117,7 @@ EXPORT_SYMBOL(dev_set_mac_address_user);
 int dev_change_net_namespace(struct net_device *dev, struct net *net,
 			     const char *pat)
 {
-	int ret;
-
-	netdev_lock_ops(dev);
-	ret = netif_change_net_namespace(dev, net, pat, 0, NULL);
-	netdev_unlock_ops(dev);
-
-	return ret;
+	return __dev_change_net_namespace(dev, net, pat, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(dev_change_net_namespace);
 
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 334db17be37d..c23852835050 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3025,8 +3025,6 @@ static int do_setlink(const struct sk_buff *skb, struct net_device *dev,
 	char ifname[IFNAMSIZ];
 	int err;
 
-	netdev_lock_ops(dev);
-
 	err = validate_linkmsg(dev, tb, extack);
 	if (err < 0)
 		goto errout;
@@ -3042,14 +3040,16 @@ static int do_setlink(const struct sk_buff *skb, struct net_device *dev,
 
 		new_ifindex = nla_get_s32_default(tb[IFLA_NEW_IFINDEX], 0);
 
-		err = netif_change_net_namespace(dev, tgt_net, pat,
+		err = __dev_change_net_namespace(dev, tgt_net, pat,
 						 new_ifindex, extack);
 		if (err)
-			goto errout;
+			return err;
 
 		status |= DO_SETLINK_MODIFIED;
 	}
 
+	netdev_lock_ops(dev);
+
 	if (tb[IFLA_MAP]) {
 		struct rtnl_link_ifmap *u_map;
 		struct ifmap k_map;
-- 
2.49.0


