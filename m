Return-Path: <netdev+bounces-77594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E98CD8723AA
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 17:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6147F1F24243
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 16:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16AB12C526;
	Tue,  5 Mar 2024 16:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E1PLC2Pt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60917128807
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 16:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709654699; cv=none; b=f3VJ7M9ia51XzcJkJvoTXfmvRKSrY1w/pcQEL/0Nc3fbIbWXRSd/iNkmRQiQ4Tb9eDK4mevlS67V0K/SOc6lKFyUnP9Np7iiU6BxV0EHYv8wvbWpH7DVHapkw3SEuDmDBcDD7gK+dfCc0gy0OHmqTcjphxeNExtK5WUr5/XGISc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709654699; c=relaxed/simple;
	bh=+RpDZ4umHT16KgkibZ6MLC6oD8ZUCZVpsTThjwhrJS4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HIhkyTWDW85dFuaFwCqPHgQ+kKyJ8rLWOWEhBPfDcfee7K9uOaef0zPzUWL/pV3zrg9gk5DT0ZT7P67YXfWF+7kDDC/UB8+i/c7oUYbWx4sAwJHEO/Lkz2Zm0nQynVh4B8KPODJIznC27mJErH382kgLWLFlzY+LBftVVXJguto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E1PLC2Pt; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60998ed9df5so53891917b3.3
        for <netdev@vger.kernel.org>; Tue, 05 Mar 2024 08:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709654682; x=1710259482; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+XW2iTaBEBFjs9ewuQar/cXIujcUM7/EhsgXAWDpU3Q=;
        b=E1PLC2PtTsNYljRXBcZWQ7Rq6H6iKIZxGD8nI+4yDtxmO3NoHRW+BthvpwSgxGvqDY
         LGHzBy8GhndTElPEFDnN2779S4We0C8eBmwLBbR7ig1Ks9Y/e3lnMkguUMQ0p9tqQ60Q
         4Tq4DAt7ECFHldt9jmGqv7ixe67D5xcMwG3UpPwRqLBTo7ipPZmPpX/5xkLLu6PlaIl6
         U9bpcB5dC2xXH9NFCoWND9ccOunhkUUghlnFEu7BK4IV1ydt2ARYQvn26+RvDZaCVAif
         oMO+EE0j8B/HfRpixElvdt9ORM0/p54Gyi2pV5TcQ3XVqGaOld9ZO4KsDzE2QpoEtCFN
         PCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709654682; x=1710259482;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+XW2iTaBEBFjs9ewuQar/cXIujcUM7/EhsgXAWDpU3Q=;
        b=YDD9t1WDccVWkezkI8RtCQAtFj7htcTARKuI+nW9zlSj/Nnsy8104+Ax1y9jXd5Tox
         8zAxXBBYOZqj9ZK8419nzYB3q1t2yxxBjCJTdaZEZtHkhS+plTw9IdhHhqVtIHKbDsdP
         0+jK04Y8j7sULH66pfpwj6XYFTc/F3xOhhCW34Vg78XHddigy+N+gag2O3NDEjIXZY59
         B7AYUue5vdSh6/99XzyswDuW7q+41JbU9ul8hykaykvLHdQ9APBe8oVgtGVivmDOZSnI
         5UTzMvwJ4kjTVI48gsBFHupkLRvXMj/OeU2PTYBuMWcxOxcOso4b7ozImcFH/o7szEJt
         uLAQ==
X-Gm-Message-State: AOJu0YwIKPr0kggy8GbEGYeUC8LWIphHrem0h3iX9Fn+7narhwVbFxUb
	Gdh1dd9dWwmabITta+bnuQFq3e3aZC6DexsXRf/2URK69kyNOEFy5O22P4EfmCylyDKZlggXF1x
	1ul5A/S+NNA==
X-Google-Smtp-Source: AGHT+IEYBRYeWySyG8pUIpAZ2LXSGW7xA5jA+AqbRnhM+9qiwRXlWG/aYFQ/a4h0yIsXFfm27zpCNYAC1nLPpg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:72c:b0:dbe:a0c2:df25 with SMTP
 id l12-20020a056902072c00b00dbea0c2df25mr437273ybt.8.1709654682475; Tue, 05
 Mar 2024 08:04:42 -0800 (PST)
Date: Tue,  5 Mar 2024 16:04:12 +0000
In-Reply-To: <20240305160413.2231423-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240305160413.2231423-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240305160413.2231423-18-edumazet@google.com>
Subject: [PATCH net-next 17/18] net: introduce include/net/rps.h
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Soheil Hassas Yeganeh <soheil@google.com>, 
	Neal Cardwell <ncardwell@google.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Move RPS related structures and helpers from include/linux/netdevice.h
and include/net/sock.h to a new include file.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/ethernet/intel/ice/ice_arfs.c     |   1 +
 .../net/ethernet/mellanox/mlx4/en_netdev.c    |   1 +
 .../net/ethernet/mellanox/mlx5/core/en_arfs.c |   1 +
 drivers/net/ethernet/sfc/rx_common.c          |   1 +
 drivers/net/ethernet/sfc/siena/rx_common.c    |   1 +
 drivers/net/tun.c                             |   1 +
 include/linux/netdevice.h                     |  82 -----------
 include/net/rps.h                             | 127 ++++++++++++++++++
 include/net/sock.h                            |  35 -----
 net/core/dev.c                                |   1 +
 net/core/net-sysfs.c                          |   1 +
 net/core/sysctl_net_core.c                    |   1 +
 net/ipv4/af_inet.c                            |   1 +
 net/ipv4/tcp.c                                |   1 +
 net/ipv6/af_inet6.c                           |   1 +
 net/sctp/socket.c                             |   1 +
 16 files changed, 140 insertions(+), 117 deletions(-)
 create mode 100644 include/net/rps.h

diff --git a/drivers/net/ethernet/intel/ice/ice_arfs.c b/drivers/net/ethernet/intel/ice/ice_arfs.c
index cca0e753f38ff92be24f8e8fc8963e2bf2416cfa..7cee365cc7d167865511c8b0dab08520814d4ec1 100644
--- a/drivers/net/ethernet/intel/ice/ice_arfs.c
+++ b/drivers/net/ethernet/intel/ice/ice_arfs.c
@@ -2,6 +2,7 @@
 /* Copyright (C) 2018-2020, Intel Corporation. */
 
 #include "ice.h"
+#include <net/rps.h>
 
 /**
  * ice_is_arfs_active - helper to check is aRFS is active
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
index d7da62cda821f70af530f95d23b63afd64423219..5d3fde63b273922f52f2466c7b339f3c9908e705 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
@@ -42,6 +42,7 @@
 #include <net/ip.h>
 #include <net/vxlan.h>
 #include <net/devlink.h>
+#include <net/rps.h>
 
 #include <linux/mlx4/driver.h>
 #include <linux/mlx4/device.h>
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c
index e66f486faafe1a6b0cfc75f0f11b2e957b040842..c7f542d0b8f08c635a6fad868a364a8f5f91ba8c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c
@@ -34,6 +34,7 @@
 #include <linux/mlx5/fs.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>
+#include <net/rps.h>
 #include "en.h"
 
 #define ARFS_HASH_SHIFT BITS_PER_BYTE
diff --git a/drivers/net/ethernet/sfc/rx_common.c b/drivers/net/ethernet/sfc/rx_common.c
index fac227d372db4c832a52a62144ff9c6c89995335..dcd901eccfc8f1f9c68ee391de548a2c1602ab94 100644
--- a/drivers/net/ethernet/sfc/rx_common.c
+++ b/drivers/net/ethernet/sfc/rx_common.c
@@ -11,6 +11,7 @@
 #include "net_driver.h"
 #include <linux/module.h>
 #include <linux/iommu.h>
+#include <net/rps.h>
 #include "efx.h"
 #include "nic.h"
 #include "rx_common.h"
diff --git a/drivers/net/ethernet/sfc/siena/rx_common.c b/drivers/net/ethernet/sfc/siena/rx_common.c
index 4579f43484c3675963de1ad8c7753a200c680fe1..219fb358a646d399dbd3c66cc34039f70bbd7341 100644
--- a/drivers/net/ethernet/sfc/siena/rx_common.c
+++ b/drivers/net/ethernet/sfc/siena/rx_common.c
@@ -11,6 +11,7 @@
 #include "net_driver.h"
 #include <linux/module.h>
 #include <linux/iommu.h>
+#include <net/rps.h>
 #include "efx.h"
 #include "nic.h"
 #include "rx_common.h"
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index be37235af55d2d282b162adcd9d0e599cd5e6b3e..c1be5cec0f350d61c604d5d2776e047aa48c90b8 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -78,6 +78,7 @@
 #include <net/ax25.h>
 #include <net/rose.h>
 #include <net/6lowpan.h>
+#include <net/rps.h>
 
 #include <linux/uaccess.h>
 #include <linux/proc_fs.h>
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d3d4d1052ecb0bc704e9bb40fffbea85cfb6ab03..aaacf86df56ab480485b34b19fecebfd00c34c59 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -227,12 +227,6 @@ struct net_device_core_stats {
 #include <linux/cache.h>
 #include <linux/skbuff.h>
 
-#ifdef CONFIG_RPS
-#include <linux/static_key.h>
-extern struct static_key_false rps_needed;
-extern struct static_key_false rfs_needed;
-#endif
-
 struct neighbour;
 struct neigh_parms;
 struct sk_buff;
@@ -732,86 +726,10 @@ static inline void netdev_queue_numa_node_write(struct netdev_queue *q, int node
 #endif
 }
 
-#ifdef CONFIG_RPS
-/*
- * This structure holds an RPS map which can be of variable length.  The
- * map is an array of CPUs.
- */
-struct rps_map {
-	unsigned int len;
-	struct rcu_head rcu;
-	u16 cpus[];
-};
-#define RPS_MAP_SIZE(_num) (sizeof(struct rps_map) + ((_num) * sizeof(u16)))
-
-/*
- * The rps_dev_flow structure contains the mapping of a flow to a CPU, the
- * tail pointer for that CPU's input queue at the time of last enqueue, and
- * a hardware filter index.
- */
-struct rps_dev_flow {
-	u16 cpu;
-	u16 filter;
-	unsigned int last_qtail;
-};
-#define RPS_NO_FILTER 0xffff
-
-/*
- * The rps_dev_flow_table structure contains a table of flow mappings.
- */
-struct rps_dev_flow_table {
-	unsigned int mask;
-	struct rcu_head rcu;
-	struct rps_dev_flow flows[];
-};
-#define RPS_DEV_FLOW_TABLE_SIZE(_num) (sizeof(struct rps_dev_flow_table) + \
-    ((_num) * sizeof(struct rps_dev_flow)))
-
-/*
- * The rps_sock_flow_table contains mappings of flows to the last CPU
- * on which they were processed by the application (set in recvmsg).
- * Each entry is a 32bit value. Upper part is the high-order bits
- * of flow hash, lower part is CPU number.
- * rps_cpu_mask is used to partition the space, depending on number of
- * possible CPUs : rps_cpu_mask = roundup_pow_of_two(nr_cpu_ids) - 1
- * For example, if 64 CPUs are possible, rps_cpu_mask = 0x3f,
- * meaning we use 32-6=26 bits for the hash.
- */
-struct rps_sock_flow_table {
-	u32	mask;
-
-	u32	ents[] ____cacheline_aligned_in_smp;
-};
-#define	RPS_SOCK_FLOW_TABLE_SIZE(_num) (offsetof(struct rps_sock_flow_table, ents[_num]))
-
-#define RPS_NO_CPU 0xffff
-
-extern u32 rps_cpu_mask;
-extern struct rps_sock_flow_table __rcu *rps_sock_flow_table;
-
-static inline void rps_record_sock_flow(struct rps_sock_flow_table *table,
-					u32 hash)
-{
-	if (table && hash) {
-		unsigned int index = hash & table->mask;
-		u32 val = hash & ~rps_cpu_mask;
-
-		/* We only give a hint, preemption can change CPU under us */
-		val |= raw_smp_processor_id();
-
-		/* The following WRITE_ONCE() is paired with the READ_ONCE()
-		 * here, and another one in get_rps_cpu().
-		 */
-		if (READ_ONCE(table->ents[index]) != val)
-			WRITE_ONCE(table->ents[index], val);
-	}
-}
-
 #ifdef CONFIG_RFS_ACCEL
 bool rps_may_expire_flow(struct net_device *dev, u16 rxq_index, u32 flow_id,
 			 u16 filter_id);
 #endif
-#endif /* CONFIG_RPS */
 
 /* XPS map type and offset of the xps map within net_device->xps_maps[]. */
 enum xps_map_type {
diff --git a/include/net/rps.h b/include/net/rps.h
new file mode 100644
index 0000000000000000000000000000000000000000..6081d817d2458b7b34036d87fbdef3fa6dc914ea
--- /dev/null
+++ b/include/net/rps.h
@@ -0,0 +1,127 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _NET_RPS_H
+#define _NET_RPS_H
+
+#include <linux/types.h>
+#include <linux/static_key.h>
+#include <net/sock.h>
+
+#ifdef CONFIG_RPS
+
+extern struct static_key_false rps_needed;
+extern struct static_key_false rfs_needed;
+
+/*
+ * This structure holds an RPS map which can be of variable length.  The
+ * map is an array of CPUs.
+ */
+struct rps_map {
+	unsigned int	len;
+	struct rcu_head	rcu;
+	u16		cpus[];
+};
+#define RPS_MAP_SIZE(_num) (sizeof(struct rps_map) + ((_num) * sizeof(u16)))
+
+/*
+ * The rps_dev_flow structure contains the mapping of a flow to a CPU, the
+ * tail pointer for that CPU's input queue at the time of last enqueue, and
+ * a hardware filter index.
+ */
+struct rps_dev_flow {
+	u16		cpu;
+	u16		filter;
+	unsigned int	last_qtail;
+};
+#define RPS_NO_FILTER 0xffff
+
+/*
+ * The rps_dev_flow_table structure contains a table of flow mappings.
+ */
+struct rps_dev_flow_table {
+	unsigned int		mask;
+	struct rcu_head		rcu;
+	struct rps_dev_flow	flows[];
+};
+#define RPS_DEV_FLOW_TABLE_SIZE(_num) (sizeof(struct rps_dev_flow_table) + \
+    ((_num) * sizeof(struct rps_dev_flow)))
+
+/*
+ * The rps_sock_flow_table contains mappings of flows to the last CPU
+ * on which they were processed by the application (set in recvmsg).
+ * Each entry is a 32bit value. Upper part is the high-order bits
+ * of flow hash, lower part is CPU number.
+ * rps_cpu_mask is used to partition the space, depending on number of
+ * possible CPUs : rps_cpu_mask = roundup_pow_of_two(nr_cpu_ids) - 1
+ * For example, if 64 CPUs are possible, rps_cpu_mask = 0x3f,
+ * meaning we use 32-6=26 bits for the hash.
+ */
+struct rps_sock_flow_table {
+	u32	mask;
+
+	u32	ents[] ____cacheline_aligned_in_smp;
+};
+#define	RPS_SOCK_FLOW_TABLE_SIZE(_num) (offsetof(struct rps_sock_flow_table, ents[_num]))
+
+#define RPS_NO_CPU 0xffff
+
+extern u32 rps_cpu_mask;
+extern struct rps_sock_flow_table __rcu *rps_sock_flow_table;
+
+static inline void rps_record_sock_flow(struct rps_sock_flow_table *table,
+					u32 hash)
+{
+	unsigned int index = hash & table->mask;
+	u32 val = hash & ~rps_cpu_mask;
+
+	/* We only give a hint, preemption can change CPU under us */
+	val |= raw_smp_processor_id();
+
+	/* The following WRITE_ONCE() is paired with the READ_ONCE()
+	 * here, and another one in get_rps_cpu().
+	 */
+	if (READ_ONCE(table->ents[index]) != val)
+		WRITE_ONCE(table->ents[index], val);
+}
+
+#endif /* CONFIG_RPS */
+
+static inline void sock_rps_record_flow_hash(__u32 hash)
+{
+#ifdef CONFIG_RPS
+	struct rps_sock_flow_table *sock_flow_table;
+
+	if (!hash)
+		return;
+	rcu_read_lock();
+	sock_flow_table = rcu_dereference(rps_sock_flow_table);
+	if (sock_flow_table)
+		rps_record_sock_flow(sock_flow_table, hash);
+	rcu_read_unlock();
+#endif
+}
+
+static inline void sock_rps_record_flow(const struct sock *sk)
+{
+#ifdef CONFIG_RPS
+	if (static_branch_unlikely(&rfs_needed)) {
+		/* Reading sk->sk_rxhash might incur an expensive cache line
+		 * miss.
+		 *
+		 * TCP_ESTABLISHED does cover almost all states where RFS
+		 * might be useful, and is cheaper [1] than testing :
+		 *	IPv4: inet_sk(sk)->inet_daddr
+		 * 	IPv6: ipv6_addr_any(&sk->sk_v6_daddr)
+		 * OR	an additional socket flag
+		 * [1] : sk_state and sk_prot are in the same cache line.
+		 */
+		if (sk->sk_state == TCP_ESTABLISHED) {
+			/* This READ_ONCE() is paired with the WRITE_ONCE()
+			 * from sock_rps_save_rxhash() and sock_rps_reset_rxhash().
+			 */
+			sock_rps_record_flow_hash(READ_ONCE(sk->sk_rxhash));
+		}
+	}
+#endif
+}
+
+#endif /* _NET_RPS_H */
diff --git a/include/net/sock.h b/include/net/sock.h
index 09a0cde8bf52286167f3b9e9b32f632f3d1b5487..b5e00702acc1f037df7eb8ad085d00e0b18079a8 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1117,41 +1117,6 @@ static inline void sk_incoming_cpu_update(struct sock *sk)
 		WRITE_ONCE(sk->sk_incoming_cpu, cpu);
 }
 
-static inline void sock_rps_record_flow_hash(__u32 hash)
-{
-#ifdef CONFIG_RPS
-	struct rps_sock_flow_table *sock_flow_table;
-
-	rcu_read_lock();
-	sock_flow_table = rcu_dereference(rps_sock_flow_table);
-	rps_record_sock_flow(sock_flow_table, hash);
-	rcu_read_unlock();
-#endif
-}
-
-static inline void sock_rps_record_flow(const struct sock *sk)
-{
-#ifdef CONFIG_RPS
-	if (static_branch_unlikely(&rfs_needed)) {
-		/* Reading sk->sk_rxhash might incur an expensive cache line
-		 * miss.
-		 *
-		 * TCP_ESTABLISHED does cover almost all states where RFS
-		 * might be useful, and is cheaper [1] than testing :
-		 *	IPv4: inet_sk(sk)->inet_daddr
-		 * 	IPv6: ipv6_addr_any(&sk->sk_v6_daddr)
-		 * OR	an additional socket flag
-		 * [1] : sk_state and sk_prot are in the same cache line.
-		 */
-		if (sk->sk_state == TCP_ESTABLISHED) {
-			/* This READ_ONCE() is paired with the WRITE_ONCE()
-			 * from sock_rps_save_rxhash() and sock_rps_reset_rxhash().
-			 */
-			sock_rps_record_flow_hash(READ_ONCE(sk->sk_rxhash));
-		}
-	}
-#endif
-}
 
 static inline void sock_rps_save_rxhash(struct sock *sk,
 					const struct sk_buff *skb)
diff --git a/net/core/dev.c b/net/core/dev.c
index 26676dbd6c8594371a4d30e0dd95d72342e226ca..e9f24a31ae121f713e6ef5a530a65218bbb457e8 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -155,6 +155,7 @@
 #include <net/netdev_rx_queue.h>
 #include <net/page_pool/types.h>
 #include <net/page_pool/helpers.h>
+#include <net/rps.h>
 
 #include "dev.h"
 #include "net-sysfs.h"
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index af238026ac3c6d81267bf0b53a7b240ee9ba32b1..5560083774b1ad4e2612637990dfa3f80f750c83 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -24,6 +24,7 @@
 #include <linux/of_net.h>
 #include <linux/cpu.h>
 #include <net/netdev_rx_queue.h>
+#include <net/rps.h>
 
 #include "dev.h"
 #include "net-sysfs.h"
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 8a4c698dad9c97636ca9cebfad925d4220e98f2a..4b93e27404e83a5b3afaa23ebd18cf55b1fdc6e8 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -24,6 +24,7 @@
 #include <net/busy_poll.h>
 #include <net/pkt_sched.h>
 #include <net/hotdata.h>
+#include <net/rps.h>
 
 #include "dev.h"
 
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 6f1cfd176e7b84f23d8a5e505bf8e13b2b755f06..55bd72997b31063b7baad350fdcff40e938aecb8 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -119,6 +119,7 @@
 #endif
 #include <net/l3mdev.h>
 #include <net/compat.h>
+#include <net/rps.h>
 
 #include <trace/events/sock.h>
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 7e1b848398d04f2da2a91c3af97b1e2e3895b8ee..c5b83875411aee6037d0afd060eb9d3e16f8b6b0 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -279,6 +279,7 @@
 #include <linux/uaccess.h>
 #include <asm/ioctls.h>
 #include <net/busy_poll.h>
+#include <net/rps.h>
 
 /* Track pending CMSGs. */
 enum {
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index b90d46533cdcc1ffb61ca483e6f67ab358ede55c..8041dc181bd42e5e1af2d9e9fe6af50057e5b58f 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -64,6 +64,7 @@
 #include <net/xfrm.h>
 #include <net/ioam6.h>
 #include <net/rawv6.h>
+#include <net/rps.h>
 
 #include <linux/uaccess.h>
 #include <linux/mroute6.h>
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 6b9fcdb0952a0fe599ae5d1d1cc6fa9557a3a3bc..c67679a41044fc8e801d175b235249f2c8b99dc0 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -67,6 +67,7 @@
 #include <net/sctp/sctp.h>
 #include <net/sctp/sm.h>
 #include <net/sctp/stream_sched.h>
+#include <net/rps.h>
 
 /* Forward declarations for internal helper functions. */
 static bool sctp_writeable(const struct sock *sk);
-- 
2.44.0.278.ge034bb2e1d-goog


