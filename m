Return-Path: <netdev+bounces-155070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D620A00F3E
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 22:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EEC47A05C9
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 21:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2859A1B2186;
	Fri,  3 Jan 2025 21:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NMAN3bWS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3082511CA0
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 21:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735938319; cv=none; b=gkDJ/Dzk2godBBQnnmqxMmOMr/DqHASfH7JYGrPDmopRjcjRP8WKyZKxaPV+C0YPejMta92FE1NXSDsb4Tm9McmnTh9acuzlyzAqD/YTjDT+orgKC/Ry8zuyjB2TWool/WBgRbsFyBA06Nk30Co3BCwGEAwTOkfbrhIt2zFkiIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735938319; c=relaxed/simple;
	bh=LkALG/hq+ZDSG3GWDHae32Ah8822JNIkphtxIANtpDM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RkKExvimgiAN4MGAwBABeIHyInSBvz6riPzPwtoyFMuMTDK76FAkHz4RLA5hnGz9q7qljj9Dw/Uinn5hzpR3N/KLIWOWTaRSIxdZCD7bgNAuvHhWP5gC+xLctikYFj9BrtM2YR0i+BE/ujvIVn8FU0WRPAorOz2c81Q0U4JHh/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NMAN3bWS; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-6d88d56beb7so127014996d6.3
        for <netdev@vger.kernel.org>; Fri, 03 Jan 2025 13:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735938316; x=1736543116; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GB2BWoRHvvjrIJdViKiNZdIfN1ntxxIBjQFMgLQ3NLs=;
        b=NMAN3bWSkMzpGCIY3OZjy4Cm0CG3Z1K4607L1Ko/H2VcDRZyUz3p33q3kNEQp0/Pof
         9MnIrQ5iSPEFVvGte429bFLtD67M5dkReK4AQH3v5dMjZhZmEc/oIxBMtrWiIGz8q0Il
         j7rTFXtZ1YZEFNBtpk/swFpVjw4Za6Ud+KOpyDZoE1NjF6nkPTKGrn2NBca/DV5YS3sd
         ieMzGTYIRKFK0jts+N3AXtEu8v03bybPMvNoLq2W0XK4l0zjXSPeTedDPE+pgFFBBCpO
         AwEybM0WLZTNgldk9k47DKzyHEg4faIh5hrvBzL9duGdfp5+pcx5DMwSwfqkecYepKx0
         gSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735938316; x=1736543116;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GB2BWoRHvvjrIJdViKiNZdIfN1ntxxIBjQFMgLQ3NLs=;
        b=b7rwDFYHEkyS1fFnLqNWgpbb5D/iovbkHEmLzB/wcdtB61/sIUQ3/lYSRySVlvAsfG
         IiFUo6sdDDd5VkreP4ZB4ZNmx7F8R6SL8NQCcmFCdLJLTyOSE3OlPLReDvdrFv+8/Mi7
         XlfY+YP282+yxMR0zjgGJVTv26kYq/cQLTLzNs7Qd+15nr6plcNZhGm7tWMQ0wXguEqs
         /TdLM6h0l5kYynqJncqnT2ivdb0Cw0vixKSMfhWfi4rlVdYg1E95ZJwAKFoG0ZxJYaVf
         AyDTejBnEfWoKI6q6AMm5AXhRhtMpT4ZZiRZaH3w9xgY4BMVIgRufvtjqYLcPy2E+mQB
         +wQA==
X-Gm-Message-State: AOJu0Yx/kJbqsuE5/hxnG16CFJofvHwjfWE1JdROXNIA5g0j061IJrY1
	RfA/qxASn7kqwEGBf75xxqmrj/URnQknM6W38bVIapTlh9j0GqU8JwhVWa73E6KzF5fzqI7joLW
	pk9Qkx7A+fA==
X-Google-Smtp-Source: AGHT+IGJVP0Qr6WGcHS1KWbImZ5298mVFDrm51tpYLE5EW2h77OLqZTJrWqT5JWWJonDOJRqqpWFt0l1JOk6mQ==
X-Received: from qvwk9.prod.google.com ([2002:a05:6214:14e9:b0:6d8:aa06:d4bf])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:2264:b0:6d8:ae2c:503a with SMTP id 6a1803df08f44-6dd233af4f9mr783419726d6.48.1735938316106;
 Fri, 03 Jan 2025 13:05:16 -0800 (PST)
Date: Fri,  3 Jan 2025 21:05:14 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250103210514.87290-1-edumazet@google.com>
Subject: [PATCH net-next] ax25: rcu protect dev->ax25_ptr
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"

syzbot found a lockdep issue [1].

We should remove ax25 RTNL dependency in ax25_setsockopt()

This should also fix a variety of possible UAF in ax25.

[1]

WARNING: possible circular locking dependency detected
6.13.0-rc3-syzkaller-00762-g9268abe611b0 #0 Not tainted
------------------------------------------------------
syz.5.1818/12806 is trying to acquire lock:
 ffffffff8fcb3988 (rtnl_mutex){+.+.}-{4:4}, at: ax25_setsockopt+0xa55/0xe90 net/ax25/af_ax25.c:680

but task is already holding lock:
 ffff8880617ac258 (sk_lock-AF_AX25){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1618 [inline]
 ffff8880617ac258 (sk_lock-AF_AX25){+.+.}-{0:0}, at: ax25_setsockopt+0x209/0xe90 net/ax25/af_ax25.c:574

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #1 (sk_lock-AF_AX25){+.+.}-{0:0}:
        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
        lock_sock_nested+0x48/0x100 net/core/sock.c:3642
        lock_sock include/net/sock.h:1618 [inline]
        ax25_kill_by_device net/ax25/af_ax25.c:101 [inline]
        ax25_device_event+0x24d/0x580 net/ax25/af_ax25.c:146
        notifier_call_chain+0x1a5/0x3f0 kernel/notifier.c:85
       __dev_notify_flags+0x207/0x400
        dev_change_flags+0xf0/0x1a0 net/core/dev.c:9026
        dev_ifsioc+0x7c8/0xe70 net/core/dev_ioctl.c:563
        dev_ioctl+0x719/0x1340 net/core/dev_ioctl.c:820
        sock_do_ioctl+0x240/0x460 net/socket.c:1234
        sock_ioctl+0x626/0x8e0 net/socket.c:1339
        vfs_ioctl fs/ioctl.c:51 [inline]
        __do_sys_ioctl fs/ioctl.c:906 [inline]
        __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
        do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (rtnl_mutex){+.+.}-{4:4}:
        check_prev_add kernel/locking/lockdep.c:3161 [inline]
        check_prevs_add kernel/locking/lockdep.c:3280 [inline]
        validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
        __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
        __mutex_lock_common kernel/locking/mutex.c:585 [inline]
        __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
        ax25_setsockopt+0xa55/0xe90 net/ax25/af_ax25.c:680
        do_sock_setsockopt+0x3af/0x720 net/socket.c:2324
        __sys_setsockopt net/socket.c:2349 [inline]
        __do_sys_setsockopt net/socket.c:2355 [inline]
        __se_sys_setsockopt net/socket.c:2352 [inline]
        __x64_sys_setsockopt+0x1ee/0x280 net/socket.c:2352
        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
        do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(sk_lock-AF_AX25);
                               lock(rtnl_mutex);
                               lock(sk_lock-AF_AX25);
  lock(rtnl_mutex);

 *** DEADLOCK ***

1 lock held by syz.5.1818/12806:
  #0: ffff8880617ac258 (sk_lock-AF_AX25){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1618 [inline]
  #0: ffff8880617ac258 (sk_lock-AF_AX25){+.+.}-{0:0}, at: ax25_setsockopt+0x209/0xe90 net/ax25/af_ax25.c:574

stack backtrace:
CPU: 1 UID: 0 PID: 12806 Comm: syz.5.1818 Not tainted 6.13.0-rc3-syzkaller-00762-g9268abe611b0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
  __dump_stack lib/dump_stack.c:94 [inline]
  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
  print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2074
  check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2206
  check_prev_add kernel/locking/lockdep.c:3161 [inline]
  check_prevs_add kernel/locking/lockdep.c:3280 [inline]
  validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
  __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
  lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
  __mutex_lock_common kernel/locking/mutex.c:585 [inline]
  __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
  ax25_setsockopt+0xa55/0xe90 net/ax25/af_ax25.c:680
  do_sock_setsockopt+0x3af/0x720 net/socket.c:2324
  __sys_setsockopt net/socket.c:2349 [inline]
  __do_sys_setsockopt net/socket.c:2355 [inline]
  __se_sys_setsockopt net/socket.c:2352 [inline]
  __x64_sys_setsockopt+0x1ee/0x280 net/socket.c:2352
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7b62385d29

Fixes: c433570458e4 ("ax25: fix a use-after-free in ax25_fillin_cb()")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/netdevice.h |  2 +-
 include/net/ax25.h        | 10 +++++-----
 net/ax25/af_ax25.c        | 12 ++++++------
 net/ax25/ax25_dev.c       |  4 ++--
 net/ax25/ax25_ip.c        |  3 ++-
 net/ax25/ax25_out.c       | 22 +++++++++++++++++-----
 net/ax25/ax25_route.c     |  2 ++
 7 files changed, 35 insertions(+), 20 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 2593019ad5b1614f3b8c037afb4ba4fa740c7d51..e84602e0226c1c520435f35bb22b1aaf36db2dd1 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2261,7 +2261,7 @@ struct net_device {
 	void 			*atalk_ptr;
 #endif
 #if IS_ENABLED(CONFIG_AX25)
-	void			*ax25_ptr;
+	struct ax25_dev	__rcu	*ax25_ptr;
 #endif
 #if IS_ENABLED(CONFIG_CFG80211)
 	struct wireless_dev	*ieee80211_ptr;
diff --git a/include/net/ax25.h b/include/net/ax25.h
index cb622d84cd0cc4570705774036a843c8c075a328..4ee141aae0a29de4655c9f72be1f21910b89d4a3 100644
--- a/include/net/ax25.h
+++ b/include/net/ax25.h
@@ -231,6 +231,7 @@ typedef struct ax25_dev {
 #endif
 	refcount_t		refcount;
 	bool device_up;
+	struct rcu_head		rcu;
 } ax25_dev;
 
 typedef struct ax25_cb {
@@ -290,9 +291,8 @@ static inline void ax25_dev_hold(ax25_dev *ax25_dev)
 
 static inline void ax25_dev_put(ax25_dev *ax25_dev)
 {
-	if (refcount_dec_and_test(&ax25_dev->refcount)) {
-		kfree(ax25_dev);
-	}
+	if (refcount_dec_and_test(&ax25_dev->refcount))
+		kfree_rcu(ax25_dev, rcu);
 }
 static inline __be16 ax25_type_trans(struct sk_buff *skb, struct net_device *dev)
 {
@@ -335,9 +335,9 @@ void ax25_digi_invert(const ax25_digi *, ax25_digi *);
 extern spinlock_t ax25_dev_lock;
 
 #if IS_ENABLED(CONFIG_AX25)
-static inline ax25_dev *ax25_dev_ax25dev(struct net_device *dev)
+static inline ax25_dev *ax25_dev_ax25dev(const struct net_device *dev)
 {
-	return dev->ax25_ptr;
+	return rcu_dereference_rtnl(dev->ax25_ptr);
 }
 #endif
 
diff --git a/net/ax25/af_ax25.c b/net/ax25/af_ax25.c
index d6f9fae06a9d8139ec0505358327e3876af228ae..aa6c714892ec9dcaa5617fdc96e0174b0fbd1041 100644
--- a/net/ax25/af_ax25.c
+++ b/net/ax25/af_ax25.c
@@ -467,7 +467,7 @@ static int ax25_ctl_ioctl(const unsigned int cmd, void __user *arg)
 	goto out_put;
 }
 
-static void ax25_fillin_cb_from_dev(ax25_cb *ax25, ax25_dev *ax25_dev)
+static void ax25_fillin_cb_from_dev(ax25_cb *ax25, const ax25_dev *ax25_dev)
 {
 	ax25->rtt     = msecs_to_jiffies(ax25_dev->values[AX25_VALUES_T1]) / 2;
 	ax25->t1      = msecs_to_jiffies(ax25_dev->values[AX25_VALUES_T1]);
@@ -677,22 +677,22 @@ static int ax25_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		rtnl_lock();
-		dev = __dev_get_by_name(&init_net, devname);
+		rcu_read_lock();
+		dev = dev_get_by_name_rcu(&init_net, devname);
 		if (!dev) {
-			rtnl_unlock();
+			rcu_read_unlock();
 			res = -ENODEV;
 			break;
 		}
 
 		ax25->ax25_dev = ax25_dev_ax25dev(dev);
 		if (!ax25->ax25_dev) {
-			rtnl_unlock();
+			rcu_read_unlock();
 			res = -ENODEV;
 			break;
 		}
 		ax25_fillin_cb(ax25, ax25->ax25_dev);
-		rtnl_unlock();
+		rcu_read_unlock();
 		break;
 
 	default:
diff --git a/net/ax25/ax25_dev.c b/net/ax25/ax25_dev.c
index 9efd6690b3443653a2f2ef421080aa48b214a8ba..3733c0254a50842fed496bfd983d9d5633ea8ea4 100644
--- a/net/ax25/ax25_dev.c
+++ b/net/ax25/ax25_dev.c
@@ -90,7 +90,7 @@ void ax25_dev_device_up(struct net_device *dev)
 
 	spin_lock_bh(&ax25_dev_lock);
 	list_add(&ax25_dev->list, &ax25_dev_list);
-	dev->ax25_ptr     = ax25_dev;
+	rcu_assign_pointer(dev->ax25_ptr, ax25_dev);
 	spin_unlock_bh(&ax25_dev_lock);
 
 	ax25_register_dev_sysctl(ax25_dev);
@@ -125,7 +125,7 @@ void ax25_dev_device_down(struct net_device *dev)
 		}
 	}
 
-	dev->ax25_ptr = NULL;
+	RCU_INIT_POINTER(dev->ax25_ptr, NULL);
 	spin_unlock_bh(&ax25_dev_lock);
 	netdev_put(dev, &ax25_dev->dev_tracker);
 	ax25_dev_put(ax25_dev);
diff --git a/net/ax25/ax25_ip.c b/net/ax25/ax25_ip.c
index 36249776c021e725512e156c773aead2afea1d13..215d4ccf12b91319580b5af9f9a9abcbe565df49 100644
--- a/net/ax25/ax25_ip.c
+++ b/net/ax25/ax25_ip.c
@@ -122,6 +122,7 @@ netdev_tx_t ax25_ip_xmit(struct sk_buff *skb)
 	if (dev == NULL)
 		dev = skb->dev;
 
+	rcu_read_lock();
 	if ((ax25_dev = ax25_dev_ax25dev(dev)) == NULL) {
 		kfree_skb(skb);
 		goto put;
@@ -202,7 +203,7 @@ netdev_tx_t ax25_ip_xmit(struct sk_buff *skb)
 	ax25_queue_xmit(skb, dev);
 
 put:
-
+	rcu_read_unlock();
 	ax25_route_lock_unuse();
 	return NETDEV_TX_OK;
 }
diff --git a/net/ax25/ax25_out.c b/net/ax25/ax25_out.c
index 3db76d2470e954cc3de1a8a1f536cc2021cb0912..8bca2ace98e51b6bf79691406c3b9484ef6372f7 100644
--- a/net/ax25/ax25_out.c
+++ b/net/ax25/ax25_out.c
@@ -39,10 +39,14 @@ ax25_cb *ax25_send_frame(struct sk_buff *skb, int paclen, const ax25_address *sr
 	 * specified.
 	 */
 	if (paclen == 0) {
-		if ((ax25_dev = ax25_dev_ax25dev(dev)) == NULL)
+		rcu_read_lock();
+		ax25_dev = ax25_dev_ax25dev(dev);
+		if (!ax25_dev) {
+			rcu_read_unlock();
 			return NULL;
-
+		}
 		paclen = ax25_dev->values[AX25_VALUES_PACLEN];
+		rcu_read_unlock();
 	}
 
 	/*
@@ -53,13 +57,19 @@ ax25_cb *ax25_send_frame(struct sk_buff *skb, int paclen, const ax25_address *sr
 		return ax25;		/* It already existed */
 	}
 
-	if ((ax25_dev = ax25_dev_ax25dev(dev)) == NULL)
+	rcu_read_lock();
+	ax25_dev = ax25_dev_ax25dev(dev);
+	if (!ax25_dev) {
+		rcu_read_unlock();
 		return NULL;
+	}
 
-	if ((ax25 = ax25_create_cb()) == NULL)
+	if ((ax25 = ax25_create_cb()) == NULL) {
+		rcu_read_unlock();
 		return NULL;
-
+	}
 	ax25_fillin_cb(ax25, ax25_dev);
+	rcu_read_unlock();
 
 	ax25->source_addr = *src;
 	ax25->dest_addr   = *dest;
@@ -358,7 +368,9 @@ void ax25_queue_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	unsigned char *ptr;
 
+	rcu_read_lock();
 	skb->protocol = ax25_type_trans(skb, ax25_fwd_dev(dev));
+	rcu_read_unlock();
 
 	ptr  = skb_push(skb, 1);
 	*ptr = 0x00;			/* KISS */
diff --git a/net/ax25/ax25_route.c b/net/ax25/ax25_route.c
index b7c4d656a94b7107aa93a62a0c6db569babab2ca..69de75db0c9c2155f81a1161b456f4c3864bb246 100644
--- a/net/ax25/ax25_route.c
+++ b/net/ax25/ax25_route.c
@@ -406,6 +406,7 @@ int ax25_rt_autobind(ax25_cb *ax25, ax25_address *addr)
 		ax25_route_lock_unuse();
 		return -EHOSTUNREACH;
 	}
+	rcu_read_lock();
 	if ((ax25->ax25_dev = ax25_dev_ax25dev(ax25_rt->dev)) == NULL) {
 		err = -EHOSTUNREACH;
 		goto put;
@@ -442,6 +443,7 @@ int ax25_rt_autobind(ax25_cb *ax25, ax25_address *addr)
 	}
 
 put:
+	rcu_read_unlock();
 	ax25_route_lock_unuse();
 	return err;
 }
-- 
2.47.1.613.gc27f4b7a9f-goog


