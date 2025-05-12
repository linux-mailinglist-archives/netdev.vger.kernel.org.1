Return-Path: <netdev+bounces-189659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B014AAB31E1
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 10:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CC153A6306
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 08:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BEB259C8B;
	Mon, 12 May 2025 08:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="is9MJ3TO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A911258CD5
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 08:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747039279; cv=none; b=Jt0k67JL2PqwXg292QBLRfNhvUkB8fX207Y7jNkGeh2UCajXJrJ+w2Vpg5ywf1071q1uqHmsq9JRjRtKRDa7ma8TGQ0mqr3+Kuu+h2X1IJoTPUC+TaoxDxDabkUOOvJ9Gj28+/5DwPaFXCeT2jNE+XSB+l9pUaYXYLbS9EkAXyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747039279; c=relaxed/simple;
	bh=mRR4MEsZH6VKHiW81OtN190lSosU8olsoTrby5DcmhU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rU+yWj7oUJIv9QBd9zAcWbrGWnTCz3dRCaNOUsKJt555g1D7083GOytTHN2ogNtxqZZnLpyFEWabLf0wQFV1uoqgRfwsNXQVjSxNThM1oRpOkYVPKogxtvli/QGwzTa/t9La16hR5zLs3/I5Rcd8JOlqv/g1q3pzqXJwGVfWq/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=is9MJ3TO; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b1fcb97d209so4509095a12.1
        for <netdev@vger.kernel.org>; Mon, 12 May 2025 01:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747039275; x=1747644075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4UV1NY03Wdf0WsSdMGAsuxWPQqxku6DXKNAaaRDwkQ0=;
        b=is9MJ3TOVchyV8ac3mRD5GwrM333TBmaTKZa+icn3N40Tej+EfDZNTgh12B8zSXFt5
         fQ4CKpqtuyJccisz81pHjipF8hEuFMDcmrrU5pIqjsLr5PwKnYJpv+sLUntsc5Qg3opx
         o0RH4Y9W1loo8GEkRiuBbKRfg5rYs1B2WXYC+oQyBfeQEJ4a/0uVV1aYQqEXGDThR8Bj
         0nxOQIHHAkXUzRn+OiqrK4WOvMFZQ/orvSY2wHHDHeXFSwC2ddQE1GGdOOpdbXD9w7+l
         VtEGn0aMPgphFpYXyGTqADxFCwusdHYYu2Zp6fgk14xXqWLaeNMvX/voD2YHBk3jvO4J
         uDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747039275; x=1747644075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4UV1NY03Wdf0WsSdMGAsuxWPQqxku6DXKNAaaRDwkQ0=;
        b=w1LeL4Gx6BCc2ObzvUoGdyo3AMq7YQYjF328o/xMILHQ1WCydd80LWuTzBmklMHsNs
         K4NPwzzGkmqPIL9ljO32GIRit5OhXFtM1BMIidgaIFaeDLfJMMh+UqH0W4MDh1eQIbo/
         UJa7AfdwcQqxwZuhZ+tRqT4PCTapVuHzMjJnsJHUQDSh81rPmG4C7C69s79T6XGN7+B7
         /RdNkMnfxgFJp67GJhvXT7hnZPMTll6xtnQPXtIcgbUC4hK3MLIScscGa+ARpPchrJuu
         sJ9wN/l2evvIzTb2VYox5wwulSJm9t/Pdf8fHiqxn1qYns3bXt49QY8crpyR6S7fwJI7
         9G9g==
X-Forwarded-Encrypted: i=1; AJvYcCVHSmWOGvOSYN04RgmN0kAfOZ3FX0xLtOG4dDrJF4r1ZFYhtpSlV32bXJOAoVdL11gBm6+AozU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdymncCYlR2diC67jpnSCX6TJ9Eo12xgLD7pCXRCTVisKgJt/I
	yg7tJLWdHHUPoSB+PFKIGcBkdPpMHQNoDONgEAafGqrb6wdrkX9w
X-Gm-Gg: ASbGncsv4wHZyfPmZpCd6ROxEY6BEj0kv3IeY75+eh1yQY63Qaf3z47nW9745ks3XWp
	c97hIl+iOh2oT5LJqzMvAbaF5JL8V65gd9zJAGJ1OEV554phaUdzOW7GaQ7IWHrHLlOLWH5h99R
	uGh2dnddIaJTJmeOXEOn/jkt9Mrd6khrn1Us9t/BBT2uUOB1azbK2Pxz19aZntZhugCQGRu2VA7
	la6rpokQxJQ084qrtIiFmxcwQc1dfZLHq8T6vurWNrTA4ntaGfA3YYhX5idfpk8VwzvlzciE4R8
	3PMNW6lNop0y9B7sAlUUR+n20mVqdG1+eeDHNd8U
X-Google-Smtp-Source: AGHT+IF1cUhlZoNOdeyf3khOLODaHt9yjguyIQqNtUW3khM5EGHU+Jnr2Cp1uAnbGIBZtcNMpMdqJA==
X-Received: by 2002:a17:902:d4c3:b0:220:ff82:1c60 with SMTP id d9443c01a7336-22e8475b0b8mr269483385ad.14.1747039275200;
        Mon, 12 May 2025 01:41:15 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc7546aefsm58548615ad.37.2025.05.12.01.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 01:41:14 -0700 (PDT)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	almasrymina@google.com,
	sdf@fomichev.me,
	netdev@vger.kernel.org
Cc: asml.silence@gmail.com,
	dw@davidwei.uk,
	skhawaja@google.com,
	kaiyuanz@google.com,
	jdamato@fastly.com,
	ap420073@gmail.com
Subject: [PATCH net v4] net: devmem: fix kernel panic when netlink socket close after module unload
Date: Mon, 12 May 2025 08:40:59 +0000
Message-Id: <20250512084059.711037-1-ap420073@gmail.com>
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
(a)netlink socket close    (b)pp destroy    (c)uninstall    result
1                          2                3               OK
1                          3                2               (d)Impossible
2                          1                3               OK
3                          1                2               (e)Kernel panic
2                          3                1               (d)Impossible
3                          2                1               (d)Impossible

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

A new binding->lock is added to protect a dev of a binding.
So, lock ordering is like below.
 priv->lock
 netdev_lock(dev)
 binding->lock

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

v4:
 - Remove net_devmem_unset_dev().
 - Fix mishandling of list in the netdev_nl_bind_rx_doit().
 - Make net_devmem_{bind | unbind}_dmabuf() handle list themself.
 - Add a comment about an added new lock.

v3:
 - Add binding->lock for protecting members of a binding.
 - Add a net_devmem_unset_dev() helper function.
 - Do not reorder locks.
 - Fix build failure.

v2:
 - Fix commit message.
 - Correct Fixes tag.
 - Inverse locking order.
 - Do not put a reference count of binding in
   mp_dmabuf_devmem_uninstall().

In order to test this patch, driver side implementation of devmem TCP[1]
is needed to be applied.

[1] https://lore.kernel.org/netdev/20250415052458.1260575-1-ap420073@gmail.com/T/#u

 net/core/devmem.c      | 10 ++++++++++
 net/core/devmem.h      |  5 +++++
 net/core/netdev-genl.c | 15 ++++++++++++---
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 6e27a47d0493..a45d7ff24652 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -167,6 +167,7 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 
 struct net_devmem_dmabuf_binding *
 net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
+		       struct netdev_nl_sock *priv,
 		       struct netlink_ext_ack *extack)
 {
 	struct net_devmem_dmabuf_binding *binding;
@@ -200,6 +201,8 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
 
 	refcount_set(&binding->ref, 1);
 
+	mutex_init(&binding->lock);
+
 	binding->dmabuf = dmabuf;
 
 	binding->attachment = dma_buf_attach(binding->dmabuf, dev->dev.parent);
@@ -274,6 +277,8 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
 		virtual += len;
 	}
 
+	list_add(&binding->list, &priv->bindings);
+
 	return binding;
 
 err_free_chunks:
@@ -379,6 +384,11 @@ static void mp_dmabuf_devmem_uninstall(void *mp_priv,
 	xa_for_each(&binding->bound_rxqs, xa_idx, bound_rxq) {
 		if (bound_rxq == rxq) {
 			xa_erase(&binding->bound_rxqs, xa_idx);
+			if (xa_empty(&binding->bound_rxqs)) {
+				mutex_lock(&binding->lock);
+				binding->dev = NULL;
+				mutex_unlock(&binding->lock);
+			}
 			break;
 		}
 	}
diff --git a/net/core/devmem.h b/net/core/devmem.h
index 7fc158d52729..6d0eff3a4cb3 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -11,6 +11,7 @@
 #define _NET_DEVMEM_H
 
 #include <net/netmem.h>
+#include <net/netdev_netlink.h>
 
 struct netlink_ext_ack;
 
@@ -20,6 +21,8 @@ struct net_devmem_dmabuf_binding {
 	struct sg_table *sgt;
 	struct net_device *dev;
 	struct gen_pool *chunk_pool;
+	/* Protect dev */
+	struct mutex lock;
 
 	/* The user holds a ref (via the netlink API) for as long as they want
 	 * the binding to remain alive. Each page pool using this binding holds
@@ -63,6 +66,7 @@ struct dmabuf_genpool_chunk_owner {
 void __net_devmem_dmabuf_binding_free(struct net_devmem_dmabuf_binding *binding);
 struct net_devmem_dmabuf_binding *
 net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
+		       struct netdev_nl_sock *priv,
 		       struct netlink_ext_ack *extack);
 void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding);
 int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
@@ -127,6 +131,7 @@ __net_devmem_dmabuf_binding_free(struct net_devmem_dmabuf_binding *binding)
 
 static inline struct net_devmem_dmabuf_binding *
 net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
+		       struct netdev_nl_sock *priv,
 		       struct netlink_ext_ack *extack)
 {
 	return ERR_PTR(-EOPNOTSUPP);
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index dae9f0d432fb..81ff1b4a8a1c 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -908,7 +908,7 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_unlock;
 	}
 
-	binding = net_devmem_bind_dmabuf(netdev, dmabuf_fd, info->extack);
+	binding = net_devmem_bind_dmabuf(netdev, dmabuf_fd, priv, info->extack);
 	if (IS_ERR(binding)) {
 		err = PTR_ERR(binding);
 		goto err_unlock;
@@ -943,8 +943,6 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 			goto err_unbind;
 	}
 
-	list_add(&binding->list, &priv->bindings);
-
 	nla_put_u32(rsp, NETDEV_A_DMABUF_ID, binding->id);
 	genlmsg_end(rsp, hdr);
 
@@ -979,14 +977,25 @@ void netdev_nl_sock_priv_destroy(struct netdev_nl_sock *priv)
 {
 	struct net_devmem_dmabuf_binding *binding;
 	struct net_devmem_dmabuf_binding *temp;
+	netdevice_tracker dev_tracker;
 	struct net_device *dev;
 
 	mutex_lock(&priv->lock);
 	list_for_each_entry_safe(binding, temp, &priv->bindings, list) {
+		mutex_lock(&binding->lock);
 		dev = binding->dev;
+		if (!dev) {
+			mutex_unlock(&binding->lock);
+			net_devmem_unbind_dmabuf(binding);
+			continue;
+		}
+		netdev_hold(dev, &dev_tracker, GFP_KERNEL);
+		mutex_unlock(&binding->lock);
+
 		netdev_lock(dev);
 		net_devmem_unbind_dmabuf(binding);
 		netdev_unlock(dev);
+		netdev_put(dev, &dev_tracker);
 	}
 	mutex_unlock(&priv->lock);
 }
-- 
2.34.1


