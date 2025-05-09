Return-Path: <netdev+bounces-189330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A106AB19D0
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 18:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90E071C442B4
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 16:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4F9233736;
	Fri,  9 May 2025 16:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHzLnWJc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AEA235046
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 16:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746806472; cv=none; b=kzBNtQmzPI7IwRb6tx+Lu/yVAlH5nP9n2itbB+F79hROkih+lM5A+sZTc2ln4WVs7/r6idAighBLbKjiKmXsKeKby6gmHFzZ/aVBhCVVYnoZn1ulnENFULwvDlpUIgaX+rXa769Ca72qjEMCEAR8CcwDOnIevqWUqZKVxUSSeAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746806472; c=relaxed/simple;
	bh=gn3Fw1yd0mZmv++vMxgROLHDSfzvO3kgVKf+g+bpWE8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F4JOqjA0gqI/LUkM+UvCyH/iqraggDak+7b0y4o5flVXEziVPSk4N/Wj5l7hDkqqOh2TyfTezJeYieg5Y1y4riGrH47Ei9X6aol0oEJfS+NVMzv3tgiZwrtCbh+JcMMiTR3psY5S2RLabBSR+6RR7S/LUX1v6qSEHYtbogEIBHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHzLnWJc; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-74019695377so1794499b3a.3
        for <netdev@vger.kernel.org>; Fri, 09 May 2025 09:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746806470; x=1747411270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Oxm6HAf+zZ7S5Y7Hy0bvLmZt7BM16qnH9wQPy3cRVRY=;
        b=QHzLnWJcAj2u/dWH1Z3YYRXRWQaeqo2vJrR9uS1dxVgL7GwXv3cu+2dQ1/hLtlWjeF
         yKo7tGvPwaZRz/5BYV3lgquVPTexJ6cCGVudVvCXUIoJy5V8A86IJ+fMJPygHElWgNSP
         XiTMfkl3whJ+TW3E+nhDb7M0ZPuqpqhB72aVQEJN9lI3CoSVaoaL1fRD0KEXnGoS2hYf
         VdBPda1T035nBjFfkrkCQft5SexTV/IONhR6SPjHTPb16RpGsUsd+UDlsTYnkpTKmMo+
         JVKjQ4P9x1dYStvkR80PRGnYbB7WYIaXGz+9ocxdlEIJJtZWJKB9IxJrxYXBLzqDZo+g
         fwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746806470; x=1747411270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oxm6HAf+zZ7S5Y7Hy0bvLmZt7BM16qnH9wQPy3cRVRY=;
        b=WV072/tYGyunUg+4XzDfeqfZpCawlWChzr9HMYGf/SilW/SIAbXpd8DLACOwIB4QoT
         wHc9ct34pjTYaoNITnBf9ENpBeHEFrPk5ra/vQX/8HDFl0MVR7U0GCZ9X9Egy+yn89Bb
         lncOqQnBDokdKyR21WmjLw8rn6/I3rAG1UVNHwYBR7iQhD6rPaOiUIVKxx1o+Fr/uXCL
         czUYQH3PPO3Yo0VRYSbjPcvS8BQ3zvRUZp9t+J9MJLTzlSggFfv4Xug2Gi3Dg1iATprP
         4MEPAtzM1/9Vedy+4MeeIoAuvLDqeTnzkLnm+ClMCphgMYsTR2iwQoWZgrvgwbqQbwug
         OB5A==
X-Forwarded-Encrypted: i=1; AJvYcCXBE4rCQmxGi4/3P+GLfZ3IP7uUQBPqQrBX1uoxUa/rR0LWEpGw8ipaaZSYKhftB3XFHo7O4U0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1QFO4aTiLdHLnzztD7jUerlNTKTH3eRrC88QWaomGQ4VQcial
	h7vPJ65CitPN1VuM7xuaxDT1C9at7owzY53rdBdg2/VnVpwbDxnt
X-Gm-Gg: ASbGncsQpuRGQlyioklNimT9K1A3T9c59wbNp63OKDe+rQVVTnWUwMXt2hDmy8tq+49
	et7QEV63krp1yQmQ7Msi30YpHHcAQgHq8iXViY4v5B/Psbb5ZZCws+Nz8AwLOuJKjyCMAO7L5Mn
	pWw5xEvOo5ak2NJEzqm6e1qQIhM8vHhw4fQomIW4BbkgxfNvG0ypalJkHwuQSk3KTCo+ScvXVyN
	3LIKbaNPgrh3g7CR7Mfn7zpVGOCzMZOwyko6NHEKFDgY4TjywNgSpggjR48Jci2XDLbMGF/OgAF
	4yj15glxzjR267Y3XlFeVHmxRmQySw==
X-Google-Smtp-Source: AGHT+IHyOdyI8kkrRJiNO5R30PyOa6kiOz+U9h9sNzoeXqfcOtNy+18e2Pi4p7SxQopbOMlRZwa2/g==
X-Received: by 2002:a05:6a20:7283:b0:1f5:520d:fb93 with SMTP id adf61e73a8af0-215abb3ba5cmr5661530637.24.1746806469615;
        Fri, 09 May 2025 09:01:09 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b234a0b76ccsm1648085a12.27.2025.05.09.09.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 09:01:08 -0700 (PDT)
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
Subject: [PATCH net v3] net: devmem: fix kernel panic when netlink socket close after module unload
Date: Fri,  9 May 2025 16:00:55 +0000
Message-Id: <20250509160055.261803-1-ap420073@gmail.com>
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

A new binding->lock is added to protect members of a binding.

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

 net/core/devmem.c      | 14 +++++++++++---
 net/core/devmem.h      |  2 ++
 net/core/netdev-genl.c | 13 +++++++++++++
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 6e27a47d0493..ffbf50337413 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -33,6 +33,13 @@ bool net_is_devmem_iov(struct net_iov *niov)
 	return niov->pp->mp_ops == &dmabuf_devmem_ops;
 }
 
+static void net_devmem_unset_dev(struct net_devmem_dmabuf_binding *binding)
+{
+	mutex_lock(&binding->lock);
+	binding->dev = NULL;
+	mutex_unlock(&binding->lock);
+}
+
 static void net_devmem_dmabuf_free_chunk_owner(struct gen_pool *genpool,
 					       struct gen_pool_chunk *chunk,
 					       void *not_used)
@@ -117,9 +124,6 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
 	unsigned long xa_idx;
 	unsigned int rxq_idx;
 
-	if (binding->list.next)
-		list_del(&binding->list);
-
 	xa_for_each(&binding->bound_rxqs, xa_idx, rxq) {
 		const struct pp_memory_provider_params mp_params = {
 			.mp_priv	= binding,
@@ -200,6 +204,8 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
 
 	refcount_set(&binding->ref, 1);
 
+	mutex_init(&binding->lock);
+
 	binding->dmabuf = dmabuf;
 
 	binding->attachment = dma_buf_attach(binding->dmabuf, dev->dev.parent);
@@ -379,6 +385,8 @@ static void mp_dmabuf_devmem_uninstall(void *mp_priv,
 	xa_for_each(&binding->bound_rxqs, xa_idx, bound_rxq) {
 		if (bound_rxq == rxq) {
 			xa_erase(&binding->bound_rxqs, xa_idx);
+			if (xa_empty(&binding->bound_rxqs))
+				net_devmem_unset_dev(binding);
 			break;
 		}
 	}
diff --git a/net/core/devmem.h b/net/core/devmem.h
index 7fc158d52729..b69adca6cd44 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -20,6 +20,8 @@ struct net_devmem_dmabuf_binding {
 	struct sg_table *sgt;
 	struct net_device *dev;
 	struct gen_pool *chunk_pool;
+	/* Protect all members */
+	struct mutex lock;
 
 	/* The user holds a ref (via the netlink API) for as long as they want
 	 * the binding to remain alive. Each page pool using this binding holds
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index dae9f0d432fb..bd5d58604ec0 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -979,14 +979,27 @@ void netdev_nl_sock_priv_destroy(struct netdev_nl_sock *priv)
 {
 	struct net_devmem_dmabuf_binding *binding;
 	struct net_devmem_dmabuf_binding *temp;
+	netdevice_tracker dev_tracker;
 	struct net_device *dev;
 
 	mutex_lock(&priv->lock);
 	list_for_each_entry_safe(binding, temp, &priv->bindings, list) {
+		list_del(&binding->list);
+
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


