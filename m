Return-Path: <netdev+bounces-131097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8229898C9A9
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 01:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16F4828288D
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 23:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CEB1E1328;
	Tue,  1 Oct 2024 23:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="iE9GiHBY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A0F1E1334
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 23:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727826837; cv=none; b=CPjesEgQ4wGZtKdDi4MTae38c/V6BuxBt41DCzBSdvPfrPNFeXf1zf6LPdA1XAm21oLCsvzSmRs/4hwV7H0sH9nVArTuiyX7JvIQjOma+V/ItT5pvXjKY4GZpWhsoW6BiJt7OTi4rNV8Y17Ys+yTz2WOE+aOn/wCcExA5vAKjlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727826837; c=relaxed/simple;
	bh=zto/izfmmguhKhVHdEZdiijUzaBXpzkbp1KqyItqIxo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QYOI6s5mFeDBUEKEN35Di48XcBVBk1dAq4YF4kWXEz7CzgWjE5Pg5kLf9iXChmZPPpihGDbqn5qEuKaZWvbQGopuwm4T1suW26QOgEx29vJD7fWb5V/liJvHAiK2HrRngjnPh0gvZNnUu15ASqwbWs67QUIkO7uwK9gbwIhor+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=iE9GiHBY; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e0a74ce880so5043403a91.2
        for <netdev@vger.kernel.org>; Tue, 01 Oct 2024 16:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727826835; x=1728431635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wlIWZP5hxY7Z7ed2/y3QCNWpfTA3UWwpTpt+lr7sIBg=;
        b=iE9GiHBYF+WhLpT3RBv1V+mfW8Wgm3Yu9wy/VmhIK74mxvKpN1VWtseoOuV1eLE7/f
         P5femz9h5P+u4RYDvI8lrmuunCnYT6+XaZC6YfEBjejNc6GRbVuKdaMj4KXtymAmjhGp
         2ndF8394YUpVGLHchbKmNl/S4Y5/Ld1PQ/uI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727826835; x=1728431635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wlIWZP5hxY7Z7ed2/y3QCNWpfTA3UWwpTpt+lr7sIBg=;
        b=A3jsLvWK1Do9u9sDheiHoYhiGmNjD3Raztk4q3ENOAv7ldOTiCgmNAPulRbw2xoEGp
         LtvKHNg5h0yy7GLEgfWTc1EGwt8m7BoZDcI16bKMdp0qTxupJ0m2RtOuhaGhM2EtMzl1
         Nlfa7T7zOt+ldeWPfuVFj18Txa0D7Bo2SK5CFROuDJSyGekuuxWSOn+JQncwEJVGMNxc
         AGjBPhQrN5BYOOU3gAxhP12fhUx40DF8/nnc1yHI/r2jALUv6plbnhsC01/LpViufP2U
         F3007Ygr/0RrCshDkPzK0vwnjBQ6rVa6uceb8xCo3EbTQK/ZcNOvJj5G+zSuNfD/HPzy
         iTQA==
X-Gm-Message-State: AOJu0Ywt2TzboTwjATjDbesIEPKWyts9WnsvKtfzoofqbmlzRnZzedYK
	DjehTXOgbw+xjxc8MH7DnXcHCASgoyp3B0+DIpQSZXNUZAieiZFGveqYwAk69bV4+/OlagRdI+v
	PMkMf6dMUw7qo9/b7Jaol8RdrNwv/Bzez85mfVWcfQuCjsLn7e+lS+N+YFBGs53Z6DjWZMhpdew
	YzQyy/co2IoMlFRYGCErX4DtEnhZwFsDYIqG8=
X-Google-Smtp-Source: AGHT+IFPu7lvhG4uUYOO2d1rHoWdVGH9+8y4NJPM7S8ebIb+AWvoza2AwcPTUtXv++qlhFapQqZP5w==
X-Received: by 2002:a17:90a:ff0d:b0:2e0:875a:f72d with SMTP id 98e67ed59e1d1-2e182c80442mr1777548a91.0.1727826834967;
        Tue, 01 Oct 2024 16:53:54 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18f89e973sm213130a91.29.2024.10.01.16.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 16:53:54 -0700 (PDT)
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
	Johannes Berg <johannes.berg@intel.com>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next v4 5/9] net: napi: Add napi_config
Date: Tue,  1 Oct 2024 23:52:36 +0000
Message-Id: <20241001235302.57609-6-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241001235302.57609-1-jdamato@fastly.com>
References: <20241001235302.57609-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a persistent NAPI config area for NAPI configuration to the core.
Drivers opt-in to setting the persistent config for a NAPI by passing an
index when calling netif_napi_add_config.

napi_config is allocated in alloc_netdev_mqs, freed in free_netdev
(after the NAPIs are deleted).

Drivers which call netif_napi_add_config will have persistent per-NAPI
settings: NAPI IDs, gro_flush_timeout, and defer_hard_irq settings.

Per-NAPI settings are saved in napi_disable and restored in napi_enable.

Co-developed-by: Martin Karsten <mkarsten@uwaterloo.ca>
Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 .../networking/net_cachelines/net_device.rst  |  1 +
 include/linux/netdevice.h                     | 32 ++++++++
 net/core/dev.c                                | 79 +++++++++++++++++--
 net/core/dev.h                                | 14 ++++
 4 files changed, 119 insertions(+), 7 deletions(-)

diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index 3d02ae79c850..11d659051f5e 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -183,3 +183,4 @@ struct hlist_head                   page_pools
 struct dim_irq_moder*               irq_moder
 unsigned_long                       gro_flush_timeout
 u32                                 napi_defer_hard_irqs
+struct napi_config*                 napi_config
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 33897edd16c8..51cff55e7ab8 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -342,6 +342,15 @@ struct gro_list {
  */
 #define GRO_HASH_BUCKETS	8
 
+/*
+ * Structure for per-NAPI config
+ */
+struct napi_config {
+	u64 gro_flush_timeout;
+	u32 defer_hard_irqs;
+	unsigned int napi_id;
+};
+
 /*
  * Structure for NAPI scheduling similar to tasklet but with weighting
  */
@@ -379,6 +388,8 @@ struct napi_struct {
 	int			irq;
 	unsigned long		gro_flush_timeout;
 	u32			defer_hard_irqs;
+	int			index;
+	struct napi_config	*config;
 };
 
 enum {
@@ -2011,6 +2022,9 @@ enum netdev_reg_state {
  *	@dpll_pin: Pointer to the SyncE source pin of a DPLL subsystem,
  *		   where the clock is recovered.
  *
+ *	@napi_config: An array of napi_config structures containing per-NAPI
+ *		      settings.
+ *
  *	FIXME: cleanup struct net_device such that network protocol info
  *	moves out.
  */
@@ -2400,6 +2414,7 @@ struct net_device {
 	struct dim_irq_moder	*irq_moder;
 	unsigned long		gro_flush_timeout;
 	u32			napi_defer_hard_irqs;
+	struct napi_config	*napi_config;
 
 	u8			priv[] ____cacheline_aligned
 				       __counted_by(priv_len);
@@ -2650,6 +2665,23 @@ netif_napi_add_tx_weight(struct net_device *dev,
 	netif_napi_add_weight(dev, napi, poll, weight);
 }
 
+/**
+ * netif_napi_add_config - initialize a NAPI context with persistent config
+ * @dev: network device
+ * @napi: NAPI context
+ * @poll: polling function
+ * @weight: the poll weight of this NAPI
+ * @index: the NAPI index
+ */
+static inline void
+netif_napi_add_config(struct net_device *dev, struct napi_struct *napi,
+		      int (*poll)(struct napi_struct *, int), int index)
+{
+	napi->index = index;
+	napi->config = &dev->napi_config[index];
+	netif_napi_add_weight(dev, napi, poll, NAPI_POLL_WEIGHT);
+}
+
 /**
  * netif_napi_add_tx() - initialize a NAPI context to be used for Tx only
  * @dev:  network device
diff --git a/net/core/dev.c b/net/core/dev.c
index 056ed44f766f..9acb6db19200 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6499,6 +6499,22 @@ EXPORT_SYMBOL(napi_busy_loop);
 
 #endif /* CONFIG_NET_RX_BUSY_POLL */
 
+static void __napi_hash_add_with_id(struct napi_struct *napi,
+				    unsigned int napi_id)
+{
+	napi->napi_id = napi_id;
+	hlist_add_head_rcu(&napi->napi_hash_node,
+			   &napi_hash[napi->napi_id % HASH_SIZE(napi_hash)]);
+}
+
+static void napi_hash_add_with_id(struct napi_struct *napi,
+				  unsigned int napi_id)
+{
+	spin_lock(&napi_hash_lock);
+	__napi_hash_add_with_id(napi, napi_id);
+	spin_unlock(&napi_hash_lock);
+}
+
 static void napi_hash_add(struct napi_struct *napi)
 {
 	if (test_bit(NAPI_STATE_NO_BUSY_POLL, &napi->state))
@@ -6511,10 +6527,8 @@ static void napi_hash_add(struct napi_struct *napi)
 		if (unlikely(++napi_gen_id < MIN_NAPI_ID))
 			napi_gen_id = MIN_NAPI_ID;
 	} while (napi_by_id(napi_gen_id));
-	napi->napi_id = napi_gen_id;
 
-	hlist_add_head_rcu(&napi->napi_hash_node,
-			   &napi_hash[napi->napi_id % HASH_SIZE(napi_hash)]);
+	__napi_hash_add_with_id(napi, napi_gen_id);
 
 	spin_unlock(&napi_hash_lock);
 }
@@ -6637,6 +6651,28 @@ void netif_queue_set_napi(struct net_device *dev, unsigned int queue_index,
 }
 EXPORT_SYMBOL(netif_queue_set_napi);
 
+static void napi_restore_config(struct napi_struct *n)
+{
+	n->defer_hard_irqs = n->config->defer_hard_irqs;
+	n->gro_flush_timeout = n->config->gro_flush_timeout;
+	/* a NAPI ID might be stored in the config, if so use it. if not, use
+	 * napi_hash_add to generate one for us. It will be saved to the config
+	 * in napi_disable.
+	 */
+	if (n->config->napi_id)
+		napi_hash_add_with_id(n, n->config->napi_id);
+	else
+		napi_hash_add(n);
+}
+
+static void napi_save_config(struct napi_struct *n)
+{
+	n->config->defer_hard_irqs = n->defer_hard_irqs;
+	n->config->gro_flush_timeout = n->gro_flush_timeout;
+	n->config->napi_id = n->napi_id;
+	napi_hash_del(n);
+}
+
 void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
 			   int (*poll)(struct napi_struct *, int), int weight)
 {
@@ -6647,8 +6683,6 @@ void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
 	INIT_HLIST_NODE(&napi->napi_hash_node);
 	hrtimer_init(&napi->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
 	napi->timer.function = napi_watchdog;
-	napi_set_defer_hard_irqs(napi, READ_ONCE(dev->napi_defer_hard_irqs));
-	napi_set_gro_flush_timeout(napi, READ_ONCE(dev->gro_flush_timeout));
 	init_gro_hash(napi);
 	napi->skb = NULL;
 	INIT_LIST_HEAD(&napi->rx_list);
@@ -6666,7 +6700,13 @@ void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
 	set_bit(NAPI_STATE_SCHED, &napi->state);
 	set_bit(NAPI_STATE_NPSVC, &napi->state);
 	list_add_rcu(&napi->dev_list, &dev->napi_list);
-	napi_hash_add(napi);
+
+	/* default settings from sysfs are applied to all NAPIs. any per-NAPI
+	 * configuration will be loaded in napi_enable
+	 */
+	napi_set_defer_hard_irqs(napi, READ_ONCE(dev->napi_defer_hard_irqs));
+	napi_set_gro_flush_timeout(napi, READ_ONCE(dev->gro_flush_timeout));
+
 	napi_get_frags_check(napi);
 	/* Create kthread for this napi if dev->threaded is set.
 	 * Clear dev->threaded if kthread creation failed so that
@@ -6698,6 +6738,11 @@ void napi_disable(struct napi_struct *n)
 
 	hrtimer_cancel(&n->timer);
 
+	if (n->config)
+		napi_save_config(n);
+	else
+		napi_hash_del(n);
+
 	clear_bit(NAPI_STATE_DISABLE, &n->state);
 }
 EXPORT_SYMBOL(napi_disable);
@@ -6713,6 +6758,11 @@ void napi_enable(struct napi_struct *n)
 {
 	unsigned long new, val = READ_ONCE(n->state);
 
+	if (n->config)
+		napi_restore_config(n);
+	else
+		napi_hash_add(n);
+
 	do {
 		BUG_ON(!test_bit(NAPI_STATE_SCHED, &val));
 
@@ -6742,7 +6792,11 @@ void __netif_napi_del(struct napi_struct *napi)
 	if (!test_and_clear_bit(NAPI_STATE_LISTED, &napi->state))
 		return;
 
-	napi_hash_del(napi);
+	if (napi->config) {
+		napi->index = -1;
+		napi->config = NULL;
+	}
+
 	list_del_rcu(&napi->dev_list);
 	napi_free_frags(napi);
 
@@ -11079,6 +11133,8 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 		unsigned int txqs, unsigned int rxqs)
 {
 	struct net_device *dev;
+	size_t napi_config_sz;
+	unsigned int maxqs;
 
 	BUG_ON(strlen(name) >= sizeof(dev->name));
 
@@ -11092,6 +11148,8 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 		return NULL;
 	}
 
+	maxqs = max(txqs, rxqs);
+
 	dev = kvzalloc(struct_size(dev, priv, sizeof_priv),
 		       GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFAIL);
 	if (!dev)
@@ -11166,6 +11224,11 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 	if (!dev->ethtool)
 		goto free_all;
 
+	napi_config_sz = array_size(maxqs, sizeof(*dev->napi_config));
+	dev->napi_config = kvzalloc(napi_config_sz, GFP_KERNEL_ACCOUNT);
+	if (!dev->napi_config)
+		goto free_all;
+
 	strscpy(dev->name, name);
 	dev->name_assign_type = name_assign_type;
 	dev->group = INIT_NETDEV_GROUP;
@@ -11227,6 +11290,8 @@ void free_netdev(struct net_device *dev)
 	list_for_each_entry_safe(p, n, &dev->napi_list, dev_list)
 		netif_napi_del(p);
 
+	kvfree(dev->napi_config);
+
 	ref_tracker_dir_exit(&dev->refcnt_tracker);
 #ifdef CONFIG_PCPU_DEV_REFCNT
 	free_percpu(dev->pcpu_refcnt);
diff --git a/net/core/dev.h b/net/core/dev.h
index 26e598aa56c3..7365fa0ffdc7 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -167,11 +167,18 @@ static inline void napi_set_defer_hard_irqs(struct napi_struct *n, u32 defer)
 static inline void netdev_set_defer_hard_irqs(struct net_device *netdev,
 					      u32 defer)
 {
+	unsigned int count = max(netdev->num_rx_queues,
+				 netdev->num_tx_queues);
 	struct napi_struct *napi;
+	int i;
 
 	WRITE_ONCE(netdev->napi_defer_hard_irqs, defer);
 	list_for_each_entry(napi, &netdev->napi_list, dev_list)
 		napi_set_defer_hard_irqs(napi, defer);
+
+	if (netdev->napi_config)
+		for (i = 0; i < count; i++)
+			netdev->napi_config[i].defer_hard_irqs = defer;
 }
 
 /**
@@ -207,11 +214,18 @@ static inline void napi_set_gro_flush_timeout(struct napi_struct *n,
 static inline void netdev_set_gro_flush_timeout(struct net_device *netdev,
 						unsigned long timeout)
 {
+	unsigned int count = max(netdev->num_rx_queues,
+				 netdev->num_tx_queues);
 	struct napi_struct *napi;
+	int i;
 
 	WRITE_ONCE(netdev->gro_flush_timeout, timeout);
 	list_for_each_entry(napi, &netdev->napi_list, dev_list)
 		napi_set_gro_flush_timeout(napi, timeout);
+
+	if (netdev->napi_config)
+		for (i = 0; i < count; i++)
+			netdev->napi_config[i].gro_flush_timeout = timeout;
 }
 
 int rps_cpumask_housekeeping(struct cpumask *mask);
-- 
2.25.1


