Return-Path: <netdev+bounces-188362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 825B1AAC780
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 16:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F15A1461B23
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 14:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9ECE280A47;
	Tue,  6 May 2025 14:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctlhd/BI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A348F7D
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 14:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746540554; cv=none; b=hd0YECU3z950yL+PIeydh94i0vZ65sSGnr8LxcSsIXKuom9Qmw+hcGavJjCop/cJVSUtrNVrdK+UIQ+CrWmm0QT/Ei6pub4KNbkxfIPfb588GTb343oV6KTmzZZYHgGebiTcVXGESK1HZmoTdfjEWVnAQGcIfLgtzYRDO/NitCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746540554; c=relaxed/simple;
	bh=bRU26KLZlbBwud9qep2Pf/qK9hLOd934MJTXlxSfL2I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mqpx7G2bXBvLFOme9NHGjbTG1W4S0da2ue2z3+nynHyI0dZLyAZVmOr7hMA/NIZjg41HqJqJkh+D0g7hkcLKi2sbitWfF9Jtz9rjqeBM1D/JcFu1cC9yjd6VvkbUzhnhj6OrAuVq6rt0p3LyZ0EqaqSP+BYk2s9+bOxxBsn7d1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctlhd/BI; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-736c3e7b390so6553700b3a.2
        for <netdev@vger.kernel.org>; Tue, 06 May 2025 07:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746540552; x=1747145352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cJEya40J9FtrZ0bUuprajy+gHJshSF046dPnFaJPcsQ=;
        b=ctlhd/BI1FvN5fK+sVS3necwSUEN4dMUsuBkOoJD4rlvGLN8ttSljFKJMD5c+7DBKs
         pxqYVzmDszTGhOXELib/Xq8qvdyzqiC3UvmfHuPtopUtzeSjMiTRUpEpLA32244brvZz
         c981VnOhiGD9UfPV8dCzhwsM99kcD2TFvi8SJ1udBdT1hqpWElG4yUrDYNECJQRyuhhH
         gJQr0G3hn9/pUuiSW6bF3R0NzD6QUhj5dPg6mQWBHrPpxqm9DSeGtZKDtopHXQ83QJZ4
         Pb429mrTVrGxKTui+mIbA+0ds4KQxf4re66DCkEB38zx0XSDlFcliTKSDKWZl/pYazZu
         QF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746540552; x=1747145352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cJEya40J9FtrZ0bUuprajy+gHJshSF046dPnFaJPcsQ=;
        b=LFR/9a24UD6W9DCGxZ8AP5Mzu7DMWXq7bZUooCmW5PkTgym1VHOI0fI6lJ4uGf0Vdx
         4WZHAMDc8Sr8/mksOOlEYHfFAyx8feIOj+Pynu8hVPWuTGAS/aqSHjLpg6OSG8SEUfCQ
         GT+vXoC+RBKDmedKZ5P9DOPiFgbHhx1TKDuv9AiL5BAkYZBXxB9gBZmcGEbNULqP3gr/
         krkpgfA+dRtLsnRRPyaY5zUOqiFgKy+F8nrPoy0EfI5wotIFesAshNL97vkrbS9LaWox
         DwoUpux+akVAer9nH+29HTbeUkrEIGwsipZazIn7dye4Q4RQT6LiHDZHTQ3QTp8YC1Ks
         h7iw==
X-Forwarded-Encrypted: i=1; AJvYcCVPjGfJwiDzD5HgXyRCgdDLdyHXi4OjGlwR7qVurqvKOEAOiy0aSC0kzO3bN55pYOFKsms2rig=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaGSpR3mnNB3EnEFGOdJSOCpMeM0zryAL5SovCNHFdL0BoQZ8G
	mbCSw6Zuh8y1nNHaiE/KIC9btfq8KDRE2aYckTkM8I6oGHCBSRwE
X-Gm-Gg: ASbGncttUcZeWnqG7s3Vug2eHOUZWRUBfM78R32v1EfEArdQd5b4jdz5FKLqovdB9Nm
	UGYpy1fG7lUDntI9W5xibk1W+S3p7lMa4b2pPh5mBdYCOJBGxj6NURoimSIjNbHUBt1dhDQW8+g
	PrR7rBwzLeyT2kZHTG3tesmzEzg4BHpukT4/n5qHCcxrn8pYZKpyfmUSXoCOX3vQ8zuKC5JgMB+
	LuvEgWnLVCDa8j3HbhxTMpKxLMdA7pRiWGAVldI9ZpWCWried0KjKc9ivHSwBDujTTnLI+O3uVP
	4d0MqdunIf+s9OvZNuRFU1UL288EYBf6Gzpt78Ot
X-Google-Smtp-Source: AGHT+IHZ2huFfyEwugGhApYYmq/lPcn0uQpDf6wOGxaDQTapJOqMShRbSiRD/r5UnG5gnaM6nsHkjA==
X-Received: by 2002:a05:6a21:900e:b0:1f5:7862:7f3a with SMTP id adf61e73a8af0-20e9660591dmr15804765637.14.1746540552095;
        Tue, 06 May 2025 07:09:12 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b1fb3b5683esm7521284a12.24.2025.05.06.07.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 07:09:11 -0700 (PDT)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	almasrymina@google.com,
	sdf@fomichev.me,
	netdev@vger.kernel.org
Cc: asml.silence@gmail.com,
	dw@davidwei.uk,
	skhawaja@google.com,
	willemb@google.com,
	jdamato@fastly.com,
	ap420073@gmail.com
Subject: [PATCH net v2] net: devmem: fix kernel panic when socket close after module unload
Date: Tue,  6 May 2025 14:08:58 +0000
Message-Id: <20250506140858.2660441-1-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kernel panic occurs when a devmem TCP socket is closed after NIC module
is unloaded.

This is Devmem TCP unregistration scenarios. number is an order.
(a)socket close    (b)pp destroy    (c)uninstall    result
1                  2                3               OK
1                  3                2               (d)Impossible
2                  1                3               OK
3                  1                2               (e)Kernel panic
2                  3                1               (d)Impossible
3                  2                1               (d)Impossible

(a) netdev_nl_sock_priv_destroy() is called when devmem TCP socket is
    closed.
(b) page_pool_destroy() is called when the interface is down.
(c) mp_ops->uninstall() is called when an interface is unregistered.
(d) There is no scenario in mp_ops->uninstall() is called before
    page_pool_destroy().
    Because unregister_netdevice_many_notify() closes interfaces first
    and then calls mp_ops->uninstall().
(e) netdev_nl_sock_priv_destroy() accesses struct net_device to acquire
    netdev_lock().
    But if the interface module has already been removed, net_device
    pointer is invalid, so it causes kernel panic.

In summary, there are only 3 possible scenarios.
 A. sk close -> pp destroy -> uninstall.
 B. pp destroy -> sk close -> uninstall.
 C. pp destroy -> uninstall -> sk close.

Case C is a kernel panic scenario.

In order to fix this problem, It makes mp_dmabuf_devmem_uninstall() set
binding->dev to NULL.
It indicates an bound net_device was unregistered.

It makes netdev_nl_sock_priv_destroy() do not acquire netdev_lock()
if binding->dev is NULL.

It inverts socket/netdev lock order like below:
    netdev_lock();
    mutex_lock(&priv->lock);
    mutex_unlock(&priv->lock);
    netdev_unlock();

Because of inversion of locking ordering, mp_dmabuf_devmem_uninstall()
acquires socket lock from now on.

Tests:
Scenario A:
    ./ncdevmem -s 192.168.1.4 -c 192.168.1.2 -f $interface -l -p 8000 \
        -v 7 -t 1 -q 1 &
    pid=$!
    sleep 10
    kill $pid
    ip link set $interface down
    modprobe -rv $module

Scenario B:
    ./ncdevmem -s 192.168.1.4 -c 192.168.1.2 -f $interface -l -p 8000 \
        -v 7 -t 1 -q 1 &
    pid=$!
    sleep 10
    ip link set $interface down
    kill $pid
    modprobe -rv $module

Scenario C:
    ./ncdevmem -s 192.168.1.4 -c 192.168.1.2 -f $interface -l -p 8000 \
        -v 7 -t 1 -q 1 &
    pid=$!
    sleep 10
    modprobe -rv $module
    sleep 5
    kill $pid

Splat looks like:
Oops: general protection fault, probably for non-canonical address 0xdffffc001fffa9f7: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN NOPTI
KASAN: probably user-memory-access in range [0x00000000fffd4fb8-0x00000000fffd4fbf]
CPU: 0 UID: 0 PID: 2041 Comm: ncdevmem Tainted: G    B   W           6.15.0-rc1+ #2 PREEMPT(undef)  0947ec89efa0fd68838b78e36aa1617e97ff5d7f
Tainted: [B]=BAD_PAGE, [W]=WARN
RIP: 0010:__mutex_lock (./include/linux/sched.h:2244 kernel/locking/mutex.c:400 kernel/locking/mutex.c:443 kernel/locking/mutex.c:605 kernel/locking/mutex.c:746)
Code: ea 03 80 3c 02 00 0f 85 4f 13 00 00 49 8b 1e 48 83 e3 f8 74 6a 48 b8 00 00 00 00 00 fc ff df 48 8d 7b 34 48 89 fa 48 c1 ea 03 <0f> b6 f
RSP: 0018:ffff88826f7ef730 EFLAGS: 00010203
RAX: dffffc0000000000 RBX: 00000000fffd4f88 RCX: ffffffffaa9bc811
RDX: 000000001fffa9f7 RSI: 0000000000000008 RDI: 00000000fffd4fbc
RBP: ffff88826f7ef8b0 R08: 0000000000000000 R09: ffffed103e6aa1a4
R10: 0000000000000007 R11: ffff88826f7ef442 R12: fffffbfff669f65e
R13: ffff88812a830040 R14: ffff8881f3550d20 R15: 00000000fffd4f88
FS:  0000000000000000(0000) GS:ffff888866c05000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000563bed0cb288 CR3: 00000001a7c98000 CR4: 00000000007506f0
PKRU: 55555554
Call Trace:
<TASK>
 ...
 netdev_nl_sock_priv_destroy (net/core/netdev-genl.c:953 (discriminator 3))
 genl_release (net/netlink/genetlink.c:653 net/netlink/genetlink.c:694 net/netlink/genetlink.c:705)
 ...
 netlink_release (net/netlink/af_netlink.c:737)
 ...
 __sock_release (net/socket.c:647)
 sock_close (net/socket.c:1393)

Fixes: 1d22d3060b9b ("net: drop rtnl_lock for queue_mgmt operations")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v2:
 - Fix commit message.
 - Correct Fixes tag.
 - Inverse locking order.
 - Do not put a reference count of binding in
   mp_dmabuf_devmem_uninstall().

In order to test this patch, driver side implementation of devmem TCP[1]
is needed to be applied.

[1] https://lore.kernel.org/netdev/20250415052458.1260575-1-ap420073@gmail.com/T/#u

 net/core/devmem.c      |  6 ++++++
 net/core/devmem.h      |  3 +++
 net/core/netdev-genl.c | 27 ++++++++++++++++++---------
 3 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 6e27a47d0493..636c1e82b8da 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -167,6 +167,7 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 
 struct net_devmem_dmabuf_binding *
 net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
+		       struct netdev_nl_sock *priv,
 		       struct netlink_ext_ack *extack)
 {
 	struct net_devmem_dmabuf_binding *binding;
@@ -189,6 +190,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
 	}
 
 	binding->dev = dev;
+	binding->priv = priv;
 
 	err = xa_alloc_cyclic(&net_devmem_dmabuf_bindings, &binding->id,
 			      binding, xa_limit_32b, &id_alloc_next,
@@ -376,12 +378,16 @@ static void mp_dmabuf_devmem_uninstall(void *mp_priv,
 	struct netdev_rx_queue *bound_rxq;
 	unsigned long xa_idx;
 
+	mutex_lock(&binding->priv->lock);
 	xa_for_each(&binding->bound_rxqs, xa_idx, bound_rxq) {
 		if (bound_rxq == rxq) {
 			xa_erase(&binding->bound_rxqs, xa_idx);
+			if (xa_empty(&binding->bound_rxqs))
+				binding->dev = NULL;
 			break;
 		}
 	}
+	mutex_unlock(&binding->priv->lock);
 }
 
 static const struct memory_provider_ops dmabuf_devmem_ops = {
diff --git a/net/core/devmem.h b/net/core/devmem.h
index 7fc158d52729..afd6320b2c9b 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -11,6 +11,7 @@
 #define _NET_DEVMEM_H
 
 #include <net/netmem.h>
+#include <net/netdev_netlink.h>
 
 struct netlink_ext_ack;
 
@@ -20,6 +21,7 @@ struct net_devmem_dmabuf_binding {
 	struct sg_table *sgt;
 	struct net_device *dev;
 	struct gen_pool *chunk_pool;
+	struct netdev_nl_sock *priv;
 
 	/* The user holds a ref (via the netlink API) for as long as they want
 	 * the binding to remain alive. Each page pool using this binding holds
@@ -63,6 +65,7 @@ struct dmabuf_genpool_chunk_owner {
 void __net_devmem_dmabuf_binding_free(struct net_devmem_dmabuf_binding *binding);
 struct net_devmem_dmabuf_binding *
 net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
+		       struct netdev_nl_sock *priv,
 		       struct netlink_ext_ack *extack);
 void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding);
 int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 230743bdbb14..b8bb73574276 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -859,13 +859,11 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_genlmsg_free;
 	}
 
-	mutex_lock(&priv->lock);
-
 	err = 0;
 	netdev = netdev_get_by_index_lock(genl_info_net(info), ifindex);
 	if (!netdev) {
 		err = -ENODEV;
-		goto err_unlock_sock;
+		goto err_genlmsg_free;
 	}
 	if (!netif_device_present(netdev))
 		err = -ENODEV;
@@ -877,10 +875,11 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_unlock;
 	}
 
-	binding = net_devmem_bind_dmabuf(netdev, dmabuf_fd, info->extack);
+	mutex_lock(&priv->lock);
+	binding = net_devmem_bind_dmabuf(netdev, dmabuf_fd, priv, info->extack);
 	if (IS_ERR(binding)) {
 		err = PTR_ERR(binding);
-		goto err_unlock;
+		goto err_unlock_sock;
 	}
 
 	nla_for_each_attr_type(attr, NETDEV_A_DMABUF_QUEUES,
@@ -921,18 +920,17 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 	if (err)
 		goto err_unbind;
 
-	netdev_unlock(netdev);
-
 	mutex_unlock(&priv->lock);
+	netdev_unlock(netdev);
 
 	return 0;
 
 err_unbind:
 	net_devmem_unbind_dmabuf(binding);
-err_unlock:
-	netdev_unlock(netdev);
 err_unlock_sock:
 	mutex_unlock(&priv->lock);
+err_unlock:
+	netdev_unlock(netdev);
 err_genlmsg_free:
 	nlmsg_free(rsp);
 	return err;
@@ -948,14 +946,25 @@ void netdev_nl_sock_priv_destroy(struct netdev_nl_sock *priv)
 {
 	struct net_devmem_dmabuf_binding *binding;
 	struct net_devmem_dmabuf_binding *temp;
+	netdevice_tracker dev_tracker;
 	struct net_device *dev;
 
 	mutex_lock(&priv->lock);
 	list_for_each_entry_safe(binding, temp, &priv->bindings, list) {
 		dev = binding->dev;
+		if (!dev) {
+			net_devmem_unbind_dmabuf(binding);
+			continue;
+		}
+		netdev_hold(dev, &dev_tracker, GFP_KERNEL);
+		mutex_unlock(&priv->lock);
 		netdev_lock(dev);
+		mutex_lock(&priv->lock);
 		net_devmem_unbind_dmabuf(binding);
+		mutex_unlock(&priv->lock);
 		netdev_unlock(dev);
+		netdev_put(dev, &dev_tracker);
+		mutex_lock(&priv->lock);
 	}
 	mutex_unlock(&priv->lock);
 }
-- 
2.34.1


