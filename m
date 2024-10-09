Return-Path: <netdev+bounces-133390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B43995C88
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 02:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E45EB22E54
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 00:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D733BB22;
	Wed,  9 Oct 2024 00:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="EMsQJ7a+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6FE53AC
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 00:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728435357; cv=none; b=MjyFvW2laAvUtpNvxV7yJBh4FD5XYXGZn2H/3IdmKPHeIqqpYeIakax08FfHZTJUB6xphhu/70+Y+PqjCsh+ZjtFQnkLDD9IOLZqLLTrnFE6S/ayPASvmSTkJMTGrCuyzHtkP3PH/PV/MiadgrWZ4Sgcv3q23hK5UKcrAgl3idU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728435357; c=relaxed/simple;
	bh=L7ye8pmrftNu3IkpoKdu8GwvDW1PO1p+AP0iNfFSjhA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kdhH8Yp+msRvDNrl9g2FBHhEsYKrDVeRLYioaJ6blk4jdblZGOz8lXDSqgWjd1vJPNhucnHykz0eXltDuq4lISEfIEHp6Ym2VIdxwNQrbDvXeCD+qXx2kybs+KMASQwFrxKeY7fzj2k9As2yTyJavepS5wHxTKqcauDNU/ZiegE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=EMsQJ7a+; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20c56b816faso12729745ad.2
        for <netdev@vger.kernel.org>; Tue, 08 Oct 2024 17:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728435355; x=1729040155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ha0YuEKd9nmgN8+z/fTji7Q40w0sfoYW6qAEsAvCTJQ=;
        b=EMsQJ7a+tZ1K0NbUlZ6K5O7RX/g+0Cc/8EuvOT9X40mG9Bz0vtpl/k/AZfU6rQLq4j
         z8hYfCIXqUCYmLqJ64nt9iSpph1BiYdwswq/JVVLGCtOSy9i+zpVnClCiUCZ5qGnsyxj
         PuBu+T3CTQONi1Z7fOZts+pxv3hJVBvne+KVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728435355; x=1729040155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ha0YuEKd9nmgN8+z/fTji7Q40w0sfoYW6qAEsAvCTJQ=;
        b=OlEXMU6oq2GuFyTelAW+iuk3w0lCqeeCdnm32yKX/fJ5NjAvObEI0FxuRt4vzEWsrv
         ByOrkQknk16kJMV5M6fPqiw56BP/saPVJBufARbCRQ1gjN/0ZMqIyYUyg0yztbc/OGb6
         YSPS6sYXEzoEuUWucDxOOERdwbhZgWxbS8FFhtGIjLt4PBahp2l9tnREbUvkFP5fnA4y
         Wkn/rdizOfK6wd4jbZLPhLK1scPlweQMoTBAQtjCW6PeHMjbioX673Jb+Cv7ZDlNS/3A
         x62YWb+TycynNITmylLxI8rUTOXYAul+TclVjRtITilYSY2cfISbr2ESkvnmyJQqv9FB
         ibSA==
X-Gm-Message-State: AOJu0YzqAF+X1CuRfKjrVaxrQVe3wL4Hpthx4YqQt0aAh04kajoR2Qiq
	qn8KJGwl9+BSAc6h1qWuSFTQ4cYXM9WNDYQNXTLOYifV6gvYUXhZ6q8wWHU/NXwjiWq3H8kJmOh
	bOKGiDXh3VTOAJZpsU7JYunjVioEXqLIt4PuPq9RlT457la5hdnWV1eLSpKSnDFAdx2xOwk3OVy
	BOVSs+k40OIPwhFNy5lMOBaK6tvR2V/h7YX7Q=
X-Google-Smtp-Source: AGHT+IEmQPUV6/8+Ao7RL15qOhFm881mHN5EgoEZfCzj2eAg1fFmgFosCzKUGOAUHC9LSzRKIvtmDA==
X-Received: by 2002:a17:902:c451:b0:20b:a25e:16c5 with SMTP id d9443c01a7336-20c639157c5mr10973795ad.53.1728435354802;
        Tue, 08 Oct 2024 17:55:54 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138cec92sm60996045ad.101.2024.10.08.17.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 17:55:53 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	skhawaja@google.com,
	sdf@fomichev.me,
	bjorn@rivosinc.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	willemdebruijn.kernel@gmail.com,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list)
Subject: [net-next v5 3/9] net: napi: Make gro_flush_timeout per-NAPI
Date: Wed,  9 Oct 2024 00:54:57 +0000
Message-Id: <20241009005525.13651-4-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241009005525.13651-1-jdamato@fastly.com>
References: <20241009005525.13651-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow per-NAPI gro_flush_timeout setting.

The existing sysfs parameter is respected; writes to sysfs will write to
all NAPI structs for the device and the net_device gro_flush_timeout
field. Reads from sysfs will read from the net_device field.

The ability to set gro_flush_timeout on specific NAPI instances will be
added in a later commit, via netdev-genl.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 .../networking/net_cachelines/net_device.rst  |  2 +-
 include/linux/netdevice.h                     |  3 +-
 net/core/dev.c                                | 12 +++---
 net/core/dev.h                                | 40 +++++++++++++++++++
 net/core/net-sysfs.c                          |  2 +-
 5 files changed, 50 insertions(+), 9 deletions(-)

diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index d78b1362f12a..3ab663b6cf16 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -99,7 +99,6 @@ struct_netdev_queue*                _rx                     read_mostly
 unsigned_int                        num_rx_queues                                                   
 unsigned_int                        real_num_rx_queues      -                   read_mostly         get_rps_cpu
 struct_bpf_prog*                    xdp_prog                -                   read_mostly         netif_elide_gro()
-unsigned_long                       gro_flush_timeout       -                   read_mostly         napi_complete_done
 unsigned_int                        gro_max_size            -                   read_mostly         skb_gro_receive
 unsigned_int                        gro_ipv4_max_size       -                   read_mostly         skb_gro_receive
 rx_handler_func_t*                  rx_handler              read_mostly         -                   __netif_receive_skb_core
@@ -184,4 +183,5 @@ struct_dpll_pin*                    dpll_pin
 struct hlist_head                   page_pools
 struct dim_irq_moder*               irq_moder
 u64                                 max_pacing_offload_horizon
+unsigned_long                       gro_flush_timeout
 u32                                 napi_defer_hard_irqs
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 9042920cdd1a..4239a4a9d295 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -373,6 +373,7 @@ struct napi_struct {
 	unsigned int		napi_id;
 	struct hrtimer		timer;
 	struct task_struct	*thread;
+	unsigned long		gro_flush_timeout;
 	u32			defer_hard_irqs;
 	/* control-path-only fields follow */
 	struct list_head	dev_list;
@@ -2077,7 +2078,6 @@ struct net_device {
 	int			ifindex;
 	unsigned int		real_num_rx_queues;
 	struct netdev_rx_queue	*_rx;
-	unsigned long		gro_flush_timeout;
 	unsigned int		gro_max_size;
 	unsigned int		gro_ipv4_max_size;
 	rx_handler_func_t __rcu	*rx_handler;
@@ -2405,6 +2405,7 @@ struct net_device {
 	struct dim_irq_moder	*irq_moder;
 
 	u64			max_pacing_offload_horizon;
+	unsigned long		gro_flush_timeout;
 	u32			napi_defer_hard_irqs;
 
 	u8			priv[] ____cacheline_aligned
diff --git a/net/core/dev.c b/net/core/dev.c
index 3487eec284a6..fca2295f4d95 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6230,12 +6230,12 @@ bool napi_complete_done(struct napi_struct *n, int work_done)
 
 	if (work_done) {
 		if (n->gro_bitmask)
-			timeout = READ_ONCE(n->dev->gro_flush_timeout);
+			timeout = napi_get_gro_flush_timeout(n);
 		n->defer_hard_irqs_count = napi_get_defer_hard_irqs(n);
 	}
 	if (n->defer_hard_irqs_count > 0) {
 		n->defer_hard_irqs_count--;
-		timeout = READ_ONCE(n->dev->gro_flush_timeout);
+		timeout = napi_get_gro_flush_timeout(n);
 		if (timeout)
 			ret = false;
 	}
@@ -6370,7 +6370,7 @@ static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock,
 
 	if (flags & NAPI_F_PREFER_BUSY_POLL) {
 		napi->defer_hard_irqs_count = napi_get_defer_hard_irqs(napi);
-		timeout = READ_ONCE(napi->dev->gro_flush_timeout);
+		timeout = napi_get_gro_flush_timeout(napi);
 		if (napi->defer_hard_irqs_count && timeout) {
 			hrtimer_start(&napi->timer, ns_to_ktime(timeout), HRTIMER_MODE_REL_PINNED);
 			skip_schedule = true;
@@ -6652,6 +6652,7 @@ void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
 	hrtimer_init(&napi->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
 	napi->timer.function = napi_watchdog;
 	napi_set_defer_hard_irqs(napi, READ_ONCE(dev->napi_defer_hard_irqs));
+	napi_set_gro_flush_timeout(napi, READ_ONCE(dev->gro_flush_timeout));
 	init_gro_hash(napi);
 	napi->skb = NULL;
 	INIT_LIST_HEAD(&napi->rx_list);
@@ -11057,7 +11058,7 @@ void netdev_sw_irq_coalesce_default_on(struct net_device *dev)
 	WARN_ON(dev->reg_state == NETREG_REGISTERED);
 
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
-		dev->gro_flush_timeout = 20000;
+		netdev_set_gro_flush_timeout(dev, 20000);
 		netdev_set_defer_hard_irqs(dev, 1);
 	}
 }
@@ -11995,7 +11996,6 @@ static void __init net_dev_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, ifindex);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, real_num_rx_queues);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, _rx);
-	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, gro_flush_timeout);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, gro_max_size);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, gro_ipv4_max_size);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, rx_handler);
@@ -12007,7 +12007,7 @@ static void __init net_dev_struct_check(void)
 #ifdef CONFIG_NET_XGRESS
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, tcx_ingress);
 #endif
-	CACHELINE_ASSERT_GROUP_SIZE(struct net_device, net_device_read_rx, 100);
+	CACHELINE_ASSERT_GROUP_SIZE(struct net_device, net_device_read_rx, 92);
 }
 
 /*
diff --git a/net/core/dev.h b/net/core/dev.h
index b3792219879b..26e598aa56c3 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -174,6 +174,46 @@ static inline void netdev_set_defer_hard_irqs(struct net_device *netdev,
 		napi_set_defer_hard_irqs(napi, defer);
 }
 
+/**
+ * napi_get_gro_flush_timeout - get the gro_flush_timeout
+ * @n: napi struct to get the gro_flush_timeout from
+ *
+ * Return: the per-NAPI value of the gro_flush_timeout field.
+ */
+static inline unsigned long
+napi_get_gro_flush_timeout(const struct napi_struct *n)
+{
+	return READ_ONCE(n->gro_flush_timeout);
+}
+
+/**
+ * napi_set_gro_flush_timeout - set the gro_flush_timeout for a napi
+ * @n: napi struct to set the gro_flush_timeout
+ * @timeout: timeout value to set
+ *
+ * napi_set_gro_flush_timeout sets the per-NAPI gro_flush_timeout
+ */
+static inline void napi_set_gro_flush_timeout(struct napi_struct *n,
+					      unsigned long timeout)
+{
+	WRITE_ONCE(n->gro_flush_timeout, timeout);
+}
+
+/**
+ * netdev_set_gro_flush_timeout - set gro_flush_timeout of a netdev's NAPIs
+ * @netdev: the net_device for which all NAPIs will have gro_flush_timeout set
+ * @timeout: the timeout value to set
+ */
+static inline void netdev_set_gro_flush_timeout(struct net_device *netdev,
+						unsigned long timeout)
+{
+	struct napi_struct *napi;
+
+	WRITE_ONCE(netdev->gro_flush_timeout, timeout);
+	list_for_each_entry(napi, &netdev->napi_list, dev_list)
+		napi_set_gro_flush_timeout(napi, timeout);
+}
+
 int rps_cpumask_housekeeping(struct cpumask *mask);
 
 #if defined(CONFIG_DEBUG_NET) && defined(CONFIG_BPF_SYSCALL)
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 25125f356a15..2d9afc6e2161 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -409,7 +409,7 @@ NETDEVICE_SHOW_RW(tx_queue_len, fmt_dec);
 
 static int change_gro_flush_timeout(struct net_device *dev, unsigned long val)
 {
-	WRITE_ONCE(dev->gro_flush_timeout, val);
+	netdev_set_gro_flush_timeout(dev, val);
 	return 0;
 }
 
-- 
2.34.1


