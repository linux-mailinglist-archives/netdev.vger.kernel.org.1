Return-Path: <netdev+bounces-190488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D3DAB701E
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 17:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 989061BA1AB4
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 15:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D73199EBB;
	Wed, 14 May 2025 15:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0Xog71c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA63191F6C
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 15:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747237266; cv=none; b=JRA9mxek5blAqG9hzYRCunDL/uoplkE0ez4ptUiK90SRosc4t3PUbGVRoClbP9C1s2Gy6iwjvwD5dOtT6lURUUEnZyycYvEtMmt9QRFk6fDzelOWDPhzxjNEcFLHdMiHiuJHUH+3zlIdoeJ+KzquM6IUdcvUww3fRQVAwn/3MqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747237266; c=relaxed/simple;
	bh=TSVRQMXUj+gLSEVIz9Q7jlD69wAlJP3vrOyZYdKDPcI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sQQecuxnQFXHk3cpSdiaj4VUN79DMQonrsaxiy17iJ1WSAzSLqrEsd1QK4UjixbZjAP/PtfnfP9d55P6rDkZCcGguyNqSBmDTkVjScrCV0IPEmK6FSyBrzQcEWFdlUCLNbgK8b1QHIPVb54/x7tev9lBQIqXqnrKFkKf45wUQRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S0Xog71c; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-30a93117e1bso9044736a91.1
        for <netdev@vger.kernel.org>; Wed, 14 May 2025 08:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747237264; x=1747842064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kUeMoAI2YGMj866GHKp3SbyyrAKKzd3cRMiGIxBAkz4=;
        b=S0Xog71cwYSlQoe6FsORNeSBTgHcltawsde/Wt8JaKO271gmZ3eu8ZIQ8UC7hTTw/h
         Q6FhFELBNXogzX386tUSRKUQwRyxZAeRelbaiKsPymz2YAmIfoZoIeKEh/sdznz5eFmC
         ycMYWhgt2uyZI3F/5l0L/NBCf//OJ2rUU8vovuzXoQI8NyoiylfTp8tUdqkFiA7mJpWe
         9FfNGqyyeIC/ZRz5gBOajjtzkLCFP60rvPHtY603if8b4stAPbFWsmdcxi2RY/mTV3Yk
         pv4qW2cwrpJN82Gc+HE7zyGouDueYABoJKLh8gl4hrLXSO5PJgVXi/T++InpQ+tHLSsc
         ikCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747237264; x=1747842064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kUeMoAI2YGMj866GHKp3SbyyrAKKzd3cRMiGIxBAkz4=;
        b=TbHcpw1XSyomBlAd/ImE6CMdAlyMANsFL9Wy/R+ZmmfxHj52/ZlijPn00pgu624Cp6
         da5sYM6Enzuk322toZrdmN4ixPYEt/dCp5ls2qtDXRtqZRPg3elZcrTzMY/gtdhpC9EJ
         2Eg6fqHe/RonBn55TO1KlQZaRftEdrBWl9ECcLMPUc61w2w+miNJW64mJOW9SDLw1wD6
         cvE3+NLb4btBGexC4K0aKQHrb1bVLYtyfpfA+oUy65C5mU9pDUjutoiWVJgX83+At1Am
         1qr5CIIO6QZaSlOZHPegTjaQrnj5dfPEmtOQTCcjyc4RvPkuNsVtWyDvTbGLexdHIuWl
         5XBA==
X-Forwarded-Encrypted: i=1; AJvYcCX3RBXRONgZEm/IK+p/q/43huI7e5O8Xv6omtLFL5GM+n9+VtuwYrIvAmYyFd8Ug8K430F6K4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfvjVEB23u1gNOshsJx07ub4DY/cFBoX59eAgilWOgTS+Hn43f
	ormQ66k8iCIlsLEAoo69912a7Qk3vVwkvld3KTWwmtr2yXUE/xl6uJXlRuT/
X-Gm-Gg: ASbGncvgZ/WDdQO54VyOYOqj9jYYGtNNdN2vGPOEfwNDXURIWp78w1nlLBboIUXsHtJ
	nBDBRON04n8V8Wou/yRODGvLcAoCHsJSblXxFEySgAB9qKn//rz/Zt0ea7GaHAnOHtUolm3fodm
	2sIp4j0kXThnRS9jcNDIj6EXYIVAN2s8gw1kxICeMAxK+awbvl5GFgJX9C/lYwKCXzeR4XIor94
	sTLgSwVu7GdN688po3lH+QVLdfjR05OTm5xk4GAvnNenxu98KCiN6BcEdY3nKfj/wuOT2bjYx9o
	Wrc36QH1lkgjhztdAeSHYgermzvNs/L/S9XYoIKD
X-Google-Smtp-Source: AGHT+IHX63YM8UMcvbj+WS/fPdT7rBWI8Bku6ZWz9juy0tSTNpM4XA+r25DS10UivZ4roGf+yz3Wvw==
X-Received: by 2002:a17:90b:5403:b0:309:e351:2e3d with SMTP id 98e67ed59e1d1-30e2e5bb679mr6927936a91.12.1747237264010;
        Wed, 14 May 2025 08:41:04 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30e33451e1asm1712238a91.24.2025.05.14.08.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 08:41:03 -0700 (PDT)
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
Subject: [PATCH net v5] net: devmem: fix kernel panic when netlink socket close after module unload
Date: Wed, 14 May 2025 15:40:28 +0000
Message-Id: <20250514154028.1062909-1-ap420073@gmail.com>
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

v5:
 - Remove cleanup changes.

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

 net/core/devmem.c      |  7 +++++++
 net/core/devmem.h      |  2 ++
 net/core/netdev-genl.c | 11 +++++++++++
 3 files changed, 20 insertions(+)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 6e27a47d0493..2db428ab6b8b 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -200,6 +200,8 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
 
 	refcount_set(&binding->ref, 1);
 
+	mutex_init(&binding->lock);
+
 	binding->dmabuf = dmabuf;
 
 	binding->attachment = dma_buf_attach(binding->dmabuf, dev->dev.parent);
@@ -379,6 +381,11 @@ static void mp_dmabuf_devmem_uninstall(void *mp_priv,
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
index 7fc158d52729..a1aabc9685cc 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -20,6 +20,8 @@ struct net_devmem_dmabuf_binding {
 	struct sg_table *sgt;
 	struct net_device *dev;
 	struct gen_pool *chunk_pool;
+	/* Protect dev */
+	struct mutex lock;
 
 	/* The user holds a ref (via the netlink API) for as long as they want
 	 * the binding to remain alive. Each page pool using this binding holds
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index dae9f0d432fb..a877693fecd6 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -979,14 +979,25 @@ void netdev_nl_sock_priv_destroy(struct netdev_nl_sock *priv)
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


