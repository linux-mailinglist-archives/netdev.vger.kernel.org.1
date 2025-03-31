Return-Path: <netdev+bounces-178338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C94A76AE2
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 17:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C32753A44EC
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 15:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7710321C171;
	Mon, 31 Mar 2025 15:06:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C497A21C16D
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 15:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743433571; cv=none; b=JtTj7EAIOQ6qqeis/Xike1cLCycWjyDXfqtVzLJibpIHsfieISdDxeFGGaTuQlGGEn5KFMxDm47iQxy9cLWju+oMypjeqNhUOq4vYvNxqZKZmpjL8Uy2uLmHZNd6tRbSa5MuTrUsj/mTdPCTOzQwpNR4t4bf0InxuhjhI7vc2SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743433571; c=relaxed/simple;
	bh=Y0zSK5Mfb9dAIBmguwkV8PCJ1TB5QJ7L71JV9vpNrIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TV7e7Syqq+/9vwhEoMD5a94pp0f457IKmkvI0qNdk2VQEGQzUlN5XdTyeCD2WxwrdfQp/W+4Q4xswUgI/zkxQjs1/1EH1WziNeteA1Tvmc2tNV1IGGfe9FRQtEmqtg40Y7aXX1JMNPoP38vKJEIqX7gRP3iHWLCAPCXutGYnElg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3031354f134so5918691a91.3
        for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 08:06:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743433568; x=1744038368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dH1tGqHtaJIkSU1XT0iRYgg9/cYsUvwhQOGJy6XN8+I=;
        b=ZdVqNqhCo5ay/JGnSKIjoVcYEWBi1yyPNkJvUqBDG995HeQPi2I6VPIjdR4RGqrH4k
         Eq3Hr4+x26YClJd27/gzep6TmYS1qOG7W+YuCs3CDoixw8ZJ7895Vn0ucRz0cMQeEw2m
         DIDPtH03Z86z1BvaCU2fpWd28nw+nW+8qp1i8/Q7LzHMT09+rOYy9L+9rOzHz5N77InO
         olW3ClWbVf/w7Z7PfW0TN+mbZY3U7Z+YY+VmSPmraWVL8FwzOwbVnVE4Q36tWklTW1Hd
         rW+mlNA8ib4YTcnsOrifrsxjbyBOIOXcCfMEgJDVpFGfOHv4awAqGjlZqQ+twxLGMFsu
         pdyA==
X-Gm-Message-State: AOJu0Yzcn+VqlktwScCowT0wOk1VWS50Ur0IEVkxWk/voAzEtYSFOTKa
	DJ4HKoWUflb4kgvWekqDDCdBIJ0T8kuieiRfM2SZoTXCdRZwsCbqBQU0
X-Gm-Gg: ASbGncuuDU9rayK1hHTCI9t6/hRKQ7fP6isvzoiOHL0Xnafq6zdRLYbg7basSWzc5Lv
	vynyYglF6wANINVH7MJmjR6NGEg5GPE5sBvvvZ1K6tUrjixkaGqvVFFDX0gErLBieHYke+WiNIM
	u1UbPmOV++11xqEeHo6wHy7neJqvz94I9qm239244F2ZgYbbgQHwNDpkF2hswD2kZqmiQY080s8
	Fi73ftFIl7puL1S+UCVVPiB55WxJPpSbEpvNL0j216aydsnhQ1RigCSbyH0e16NF0rhqUIM6FU+
	q14veo0d8X+IqCWT9rNSWv6RrZBBRye/TIcpQVLrJ0It
X-Google-Smtp-Source: AGHT+IHABNHL3tzX7Oz1lJpYefmo8KItnnenATa3QhIeTyO9hTCDy1TpAqRLOLSRfT2422XOH2C9zw==
X-Received: by 2002:a17:90b:3c8e:b0:2f8:b2c:5ef3 with SMTP id 98e67ed59e1d1-30531fa5f90mr17337718a91.14.1743433567725;
        Mon, 31 Mar 2025 08:06:07 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3039e10af2csm9726009a91.21.2025.03.31.08.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 08:06:07 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH net v4 02/11] net: hold instance lock during NETDEV_REGISTER/UP
Date: Mon, 31 Mar 2025 08:05:54 -0700
Message-ID: <20250331150603.1906635-3-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250331150603.1906635-1-sdf@fomichev.me>
References: <20250331150603.1906635-1-sdf@fomichev.me>
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

Reported-by: Cosmin Ratiu <cratiu@nvidia.com>
Fixes: ad7c7b2172c3 ("net: hold netdev instance lock during sysfs operations")
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 include/linux/netdevice.h |  2 +-
 net/core/dev.c            | 12 +++++++++---
 net/core/dev_api.c        |  4 +---
 net/core/rtnetlink.c      | 10 +++++-----
 4 files changed, 16 insertions(+), 12 deletions(-)

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
index 711a946d4bfb..e59eb173900d 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1859,7 +1859,9 @@ static int call_netdevice_register_net_notifiers(struct notifier_block *nb,
 	int err;
 
 	for_each_netdev(net, dev) {
+		netdev_lock_ops(dev);
 		err = call_netdevice_register_notifiers(nb, dev);
+		netdev_unlock_ops(dev);
 		if (err)
 			goto rollback;
 	}
@@ -11046,7 +11048,9 @@ int register_netdevice(struct net_device *dev)
 		memcpy(dev->perm_addr, dev->dev_addr, dev->addr_len);
 
 	/* Notify protocols, that a new device appeared. */
+	netdev_lock_ops(dev);
 	ret = call_netdevice_notifiers(NETDEV_REGISTER, dev);
+	netdev_unlock_ops(dev);
 	ret = notifier_to_errno(ret);
 	if (ret) {
 		/* Expect explicit free_netdev() on failure */
@@ -12058,7 +12062,7 @@ void unregister_netdev(struct net_device *dev)
 }
 EXPORT_SYMBOL(unregister_netdev);
 
-int netif_change_net_namespace(struct net_device *dev, struct net *net,
+int __dev_change_net_namespace(struct net_device *dev, struct net *net,
 			       const char *pat, int new_ifindex,
 			       struct netlink_ext_ack *extack)
 {
@@ -12143,11 +12147,12 @@ int netif_change_net_namespace(struct net_device *dev, struct net *net,
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
 
@@ -12209,11 +12214,12 @@ int netif_change_net_namespace(struct net_device *dev, struct net *net,
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
index 8dbc60612100..cb3e5807dce8 100644
--- a/net/core/dev_api.c
+++ b/net/core/dev_api.c
@@ -119,9 +119,7 @@ int dev_change_net_namespace(struct net_device *dev, struct net *net,
 {
 	int ret;
 
-	netdev_lock_ops(dev);
-	ret = netif_change_net_namespace(dev, net, pat, 0, NULL);
-	netdev_unlock_ops(dev);
+	ret = __dev_change_net_namespace(dev, net, pat, 0, NULL);
 
 	return ret;
 }
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 334db17be37d..f49665851172 100644
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
-						 new_ifindex, extack);
+		err = __dev_change_net_namespace(dev, tgt_net, pat, new_ifindex,
+						 extack);
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
2.48.1


