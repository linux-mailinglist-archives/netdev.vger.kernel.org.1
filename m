Return-Path: <netdev+bounces-134656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F2499AB68
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 20:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B4CC1C22698
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 18:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6251D14E6;
	Fri, 11 Oct 2024 18:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="R89x13gR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6750D1D0421
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 18:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728672364; cv=none; b=gW083bgg3ISQ3uD1RhDO96wgiVFVqNYqhLlqRZ0w+tL/00Ce9+iozGxphdmk32vWBD2Czr8nG8Pv83yZoJSzqBCRJ3qx+JK6wiKgstmNrWkwS2aPT1aQWf+NY4FP6CBteFTw62B08o+tfl2i1xgKovceLQpeBqyiswfrSLb+SJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728672364; c=relaxed/simple;
	bh=bfDh3MXLufnPabGOrxrrmjox6Eci5oAwJ24pd1w+jdc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JxxbQATHGceKVx5eg1jNym53tbBvH3rXZKdUmz6b7z9L2ypaCTsQqryQYJD72DfXlvgmCicP4WK8kV68TKFNTXmDyHSaw06ZzouSycqO2Ll67OQgeJKmxTHTU+7UhqNbKwK+kOH67NttHQUVbrmo3dWTp5ydY9SkAfpBvfF/iSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=R89x13gR; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e2a999b287so1972660a91.0
        for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 11:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728672361; x=1729277161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLUfaAOkJl+Vde+WJrmLFXZ+vNL5nfp8Zqg9U19iPew=;
        b=R89x13gRd0p82JSg3vfhEqeKAxaOBilF66tHSsTCS/aBXbox4SZ7Z5/0t3vIXZlOHt
         AQRGIN9Ubof6CsoSDtUyRMMdHWceQOAaRs5wQjW+ioopcTK/sV47PO7nPnWV+65e1moT
         GPO/OCZldFMyh9ChPy+rdkt+7HtgfNuSwIcuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728672361; x=1729277161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aLUfaAOkJl+Vde+WJrmLFXZ+vNL5nfp8Zqg9U19iPew=;
        b=aF5bJBVyzjU/ygPpS2+ZTGCFyP4C+Ch5ipSHb1XsMZ9UY7hfYu1PUYhN26kQCJptZS
         4tTH9yVfrIUqliBJTOJFS3wXMl64MrSLap/ugC+COAPOh3lzxwHRd/XdsfvGNlvAeFGS
         i7KfbKF+pBSrcgS4OX29AbBFr5u2sksN819iNAEnQ3GiUIKh1ZTtFjPp9qmENxuP7o+M
         CKHztxY9EvavbP4ZO9vKEugT1VqJGm95OSXgsr85PEyFgA8BWrlgVL5O4hflGkphPoCe
         8mao46hfacYSJHHmUIkmrukaVgnwsqhRYBPEWbNLbQXUyesOYXi8GhPHdFRoq2STl3Xe
         vlzA==
X-Gm-Message-State: AOJu0YxLShNTOuVHeCbv9ST1M3F4bkG4cvAAWTFAVXBqi70/8XFFF/7g
	JuZpU9qQf1Wlq2vprjhbQuH77pgtZX1rx5eqfOKXJVWDHb1ZmZryUrmYkUldDCsTF9TdEukKoIk
	GkofOVlZefoYs+32XS9Y8+PGrFcQtc2ViWDAkwnAnASPucTQfpU/hqNMBTEBvZcrvOWEaf1Db3c
	hkjrQkSNKjkzZgiWjyz55LdibESbEtYLwxh0Q=
X-Google-Smtp-Source: AGHT+IFz4xe7dCBlsvUD75EtcMO0wHJOv7cpsrcGSU55pc1PZ9LqNUwYvebSdnHdxbEcvS1Kcwo9Cg==
X-Received: by 2002:a17:90b:4a0b:b0:2e2:d879:7cfc with SMTP id 98e67ed59e1d1-2e2f0affbffmr4257847a91.21.1728672361222;
        Fri, 11 Oct 2024 11:46:01 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e30d848e1csm687625a91.42.2024.10.11.11.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 11:46:00 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	skhawaja@google.com,
	sdf@fomichev.me,
	bjorn@rivosinc.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	willemdebruijn.kernel@gmail.com,
	edumazet@google.com,
	Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list)
Subject: [net-next v6 5/9] net: napi: Add napi_config
Date: Fri, 11 Oct 2024 18:45:00 +0000
Message-Id: <20241011184527.16393-6-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241011184527.16393-1-jdamato@fastly.com>
References: <20241011184527.16393-1-jdamato@fastly.com>
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
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
---
 .../networking/net_cachelines/net_device.rst  |  1 +
 include/linux/netdevice.h                     | 36 ++++++++-
 net/core/dev.c                                | 80 +++++++++++++++++--
 net/core/dev.h                                | 12 +++
 4 files changed, 119 insertions(+), 10 deletions(-)

diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index 67910ea49160..db6192b2bb50 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -186,6 +186,7 @@ struct dpll_pin*                    dpll_pin
 struct hlist_head                   page_pools
 struct dim_irq_moder*               irq_moder
 u64                                 max_pacing_offload_horizon
+struct_napi_config*                 napi_config
 unsigned_long                       gro_flush_timeout
 u32                                 napi_defer_hard_irqs
 =================================== =========================== =================== =================== ===================================================================================
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 93241d4de437..8feaca12655e 100644
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
 	struct list_head	dev_list;
 	struct hlist_node	napi_hash_node;
 	int			irq;
+	int			index;
+	struct napi_config	*config;
 };
 
 enum {
@@ -1868,9 +1879,6 @@ enum netdev_reg_state {
  *				allocated at register_netdev() time
  *	@real_num_rx_queues: 	Number of RX queues currently active in device
  *	@xdp_prog:		XDP sockets filter program pointer
- *	@gro_flush_timeout:	timeout for GRO layer in NAPI
- *	@napi_defer_hard_irqs:	If not zero, provides a counter that would
- *				allow to avoid NIC hard IRQ, on busy queues.
  *
  *	@rx_handler:		handler for received packets
  *	@rx_handler_data: 	XXX: need comments on this one
@@ -2020,6 +2028,11 @@ enum netdev_reg_state {
  *		   where the clock is recovered.
  *
  *	@max_pacing_offload_horizon: max EDT offload horizon in nsec.
+ *	@napi_config: An array of napi_config structures containing per-NAPI
+ *		      settings.
+ *	@gro_flush_timeout:	timeout for GRO layer in NAPI
+ *	@napi_defer_hard_irqs:	If not zero, provides a counter that would
+ *				allow to avoid NIC hard IRQ, on busy queues.
  *
  *	FIXME: cleanup struct net_device such that network protocol info
  *	moves out.
@@ -2413,6 +2426,7 @@ struct net_device {
 	struct dim_irq_moder	*irq_moder;
 
 	u64			max_pacing_offload_horizon;
+	struct napi_config	*napi_config;
 	unsigned long		gro_flush_timeout;
 	u32			napi_defer_hard_irqs;
 
@@ -2678,6 +2692,22 @@ netif_napi_add_tx_weight(struct net_device *dev,
 	netif_napi_add_weight(dev, napi, poll, weight);
 }
 
+/**
+ * netif_napi_add_config - initialize a NAPI context with persistent config
+ * @dev: network device
+ * @napi: NAPI context
+ * @poll: polling function
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
index e21ace3551d5..c682173a7642 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6505,6 +6505,23 @@ EXPORT_SYMBOL(napi_busy_loop);
 
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
+	WARN_ON_ONCE(napi_by_id(napi_id));
+	__napi_hash_add_with_id(napi, napi_id);
+	spin_unlock(&napi_hash_lock);
+}
+
 static void napi_hash_add(struct napi_struct *napi)
 {
 	if (test_bit(NAPI_STATE_NO_BUSY_POLL, &napi->state))
@@ -6517,10 +6534,8 @@ static void napi_hash_add(struct napi_struct *napi)
 		if (unlikely(++napi_gen_id < MIN_NAPI_ID))
 			napi_gen_id = MIN_NAPI_ID;
 	} while (napi_by_id(napi_gen_id));
-	napi->napi_id = napi_gen_id;
 
-	hlist_add_head_rcu(&napi->napi_hash_node,
-			   &napi_hash[napi->napi_id % HASH_SIZE(napi_hash)]);
+	__napi_hash_add_with_id(napi, napi_gen_id);
 
 	spin_unlock(&napi_hash_lock);
 }
@@ -6643,6 +6658,28 @@ void netif_queue_set_napi(struct net_device *dev, unsigned int queue_index,
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
@@ -6653,8 +6690,6 @@ void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
 	INIT_HLIST_NODE(&napi->napi_hash_node);
 	hrtimer_init(&napi->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
 	napi->timer.function = napi_watchdog;
-	napi_set_defer_hard_irqs(napi, READ_ONCE(dev->napi_defer_hard_irqs));
-	napi_set_gro_flush_timeout(napi, READ_ONCE(dev->gro_flush_timeout));
 	init_gro_hash(napi);
 	napi->skb = NULL;
 	INIT_LIST_HEAD(&napi->rx_list);
@@ -6672,7 +6707,13 @@ void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
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
@@ -6704,6 +6745,11 @@ void napi_disable(struct napi_struct *n)
 
 	hrtimer_cancel(&n->timer);
 
+	if (n->config)
+		napi_save_config(n);
+	else
+		napi_hash_del(n);
+
 	clear_bit(NAPI_STATE_DISABLE, &n->state);
 }
 EXPORT_SYMBOL(napi_disable);
@@ -6719,6 +6765,11 @@ void napi_enable(struct napi_struct *n)
 {
 	unsigned long new, val = READ_ONCE(n->state);
 
+	if (n->config)
+		napi_restore_config(n);
+	else
+		napi_hash_add(n);
+
 	do {
 		BUG_ON(!test_bit(NAPI_STATE_SCHED, &val));
 
@@ -6748,7 +6799,11 @@ void __netif_napi_del(struct napi_struct *napi)
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
 
@@ -11085,6 +11140,8 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 		unsigned int txqs, unsigned int rxqs)
 {
 	struct net_device *dev;
+	size_t napi_config_sz;
+	unsigned int maxqs;
 
 	BUG_ON(strlen(name) >= sizeof(dev->name));
 
@@ -11098,6 +11155,8 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 		return NULL;
 	}
 
+	maxqs = max(txqs, rxqs);
+
 	dev = kvzalloc(struct_size(dev, priv, sizeof_priv),
 		       GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFAIL);
 	if (!dev)
@@ -11174,6 +11233,11 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
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
@@ -11237,6 +11301,8 @@ void free_netdev(struct net_device *dev)
 	list_for_each_entry_safe(p, n, &dev->napi_list, dev_list)
 		netif_napi_del(p);
 
+	kvfree(dev->napi_config);
+
 	ref_tracker_dir_exit(&dev->refcnt_tracker);
 #ifdef CONFIG_PCPU_DEV_REFCNT
 	free_percpu(dev->pcpu_refcnt);
diff --git a/net/core/dev.h b/net/core/dev.h
index 7d0aab7e3ef1..7881bced70a9 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -177,11 +177,17 @@ static inline void napi_set_defer_hard_irqs(struct napi_struct *n, u32 defer)
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
+	for (i = 0; i < count; i++)
+		netdev->napi_config[i].defer_hard_irqs = defer;
 }
 
 /**
@@ -217,11 +223,17 @@ static inline void napi_set_gro_flush_timeout(struct napi_struct *n,
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
+	for (i = 0; i < count; i++)
+		netdev->napi_config[i].gro_flush_timeout = timeout;
 }
 
 int rps_cpumask_housekeeping(struct cpumask *mask);
-- 
2.25.1


