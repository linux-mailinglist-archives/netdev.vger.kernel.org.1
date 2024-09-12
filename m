Return-Path: <netdev+bounces-127773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24879976677
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 12:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4901B1C226AC
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 10:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCFC1A2C1B;
	Thu, 12 Sep 2024 10:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="v31dPbir"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3650319F431
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 10:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726135710; cv=none; b=Woqpunq7G9+cHqc3GPC5n6oKdgDwkkIeuepuLTmKsQ6lxsf848LyPdezeYEGYDn8+MFrWXqWf50Cput4xBScgPw7Gn8yuv46T2M2KOZGA7PZMhhlSGliSDVW6637qRIB85mIdx3ghbiStlEANA3v2C9VSkew0amVzRqxfKDjxuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726135710; c=relaxed/simple;
	bh=5139h/vAdKZH/+hDF4LGpoq5rzZ4VB7cmq7cSonzbF4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sLkd0bgOEFaRYNA+HQ9lo2mxfGD2cpir7Jd6EBOzJYQ+hFa0ukXAy78G6R+Y2CaGd6oc7FFU+Py/eqC86kX5rraOh/1lH2a/Geu1SbukEElidLm6a4kjEpGoExuWt8tw66xAZfoSGMil1z1NNcOWLo3Kw86jXMTpumY+eu9wqu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=v31dPbir; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20688fbaeafso9705185ad.0
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 03:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1726135708; x=1726740508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fuCU47ydUGB46V/ndRRnE6AYBHpF+SD0efezkXvrbTk=;
        b=v31dPbirvwABJYZzxag5gCjSrdRjmXQfLVRpqxQ0akMq/Su+Ia2zxOFJjCXLqOTxI6
         zZNujkb+p3xSl6Cu0VYDR0nqTeC4THK/uXueH8GVKWR0y6ohNHeyS/5X+mIV3toiLSU7
         X1y40IbSD2TR+fiPe5cnF8qpmRiacLvxRQhWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726135708; x=1726740508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fuCU47ydUGB46V/ndRRnE6AYBHpF+SD0efezkXvrbTk=;
        b=w02ISsbHVT7iZwhz0atQi0jrK2z3Eua6YB4v81GvQoKH5snS7WwjsAK3ZcSjoGk2Ad
         e5M55y4rD0kXY28EQpVvU6VIIo9q/7IeLDHPm7/OgiXhs1qLgRrOKjHMbgfdoBFwOHR2
         cEMVp1EQENXaoUdLQQ1i0mBccwusFCbc0cp03xl/qgy57NWDHseycty6qKup7aQRIghb
         DlJnpBMfP8LFT6UTxDRhE+zOYoeogdHaN24SXlk1HJq4h3o4zk3F6CwYC85H4JewrACc
         jPnqaYZxeWhPjdLTWJnbBTpY3O77/uU+arqg/1ngzc4PJPcuN9V9SsAMYsNk/Ey9bEZN
         K0IQ==
X-Gm-Message-State: AOJu0YyhSxEwGEjwRdslITKkptl4O8D1YUMsbbAorVV1On0Ul7alQPFh
	p4nSi6DLW0I3JRx4Y3jj/iIUmr8yq9ZJU1aiIe3X4JpysOOSc0AEvrqFctH2pKCFG5qHJ7kptFz
	/GJco8Wwl3q08g2Te7IW2fW0jyNG46Zn018QOkfL+Gytn7OiWCpFzETarcE2ik06pTQwsOt0L+0
	cFlnE8/l4NgSRiDQNgASJfGZ/n6ozrFwz15nkmAA==
X-Google-Smtp-Source: AGHT+IFcb8zMj6HbZ7uiJi9b+LJKIWJQoRMly1GMxYKLr2MRNBXzWLfzWLRfmYBY2BPTmecCsd3Row==
X-Received: by 2002:a17:903:2302:b0:207:20c5:42c with SMTP id d9443c01a7336-2076e40be2dmr38709985ad.45.1726135707779;
        Thu, 12 Sep 2024 03:08:27 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076afe9da3sm11583795ad.239.2024.09.12.03.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 03:08:27 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	kuba@kernel.org,
	skhawaja@google.com,
	sdf@fomichev.me,
	bjorn@rivosinc.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next v3 5/9] net: napi: Add napi_config
Date: Thu, 12 Sep 2024 10:07:13 +0000
Message-Id: <20240912100738.16567-6-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240912100738.16567-1-jdamato@fastly.com>
References: <20240912100738.16567-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a persistent NAPI config area for NAPI configuration to the core.
Drivers opt-in to setting the storage for a NAPI by passing an index
when calling netif_napi_add_storage.

napi_config is allocated in alloc_netdev_mqs, freed in free_netdev
(after the NAPIs are deleted), and set to 0 when napi_enable is called.

Drivers which implement call netif_napi_add_storage will have persistent
NAPI IDs.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 .../networking/net_cachelines/net_device.rst  |  1 +
 include/linux/netdevice.h                     | 34 +++++++++
 net/core/dev.c                                | 74 +++++++++++++++++--
 net/core/dev.h                                | 12 +++
 4 files changed, 113 insertions(+), 8 deletions(-)

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
index 3e07ab8e0295..08afc96179f9 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -342,6 +342,15 @@ struct gro_list {
  */
 #define GRO_HASH_BUCKETS	8
 
+/*
+ * Structure for per-NAPI storage
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
+ * netif_napi_add_storage - initialize a NAPI context and set storage area
+ * @dev: network device
+ * @napi: NAPI context
+ * @poll: polling function
+ * @weight: the poll weight of this NAPI
+ * @index: the NAPI index
+ */
+static inline void
+netif_napi_add_storage(struct net_device *dev, struct napi_struct *napi,
+		       int (*poll)(struct napi_struct *, int), int index)
+{
+	napi->index = index;
+	napi->config = &dev->napi_config[index];
+	netif_napi_add_weight(dev, napi, poll, NAPI_POLL_WEIGHT);
+}
+
 /**
  * netif_napi_add_tx() - initialize a NAPI context to be used for Tx only
  * @dev:  network device
@@ -2685,6 +2717,8 @@ void __netif_napi_del(struct napi_struct *napi);
  */
 static inline void netif_napi_del(struct napi_struct *napi)
 {
+	napi->config = NULL;
+	napi->index = -1;
 	__netif_napi_del(napi);
 	synchronize_net();
 }
diff --git a/net/core/dev.c b/net/core/dev.c
index f2fd503516de..ca2227d0b8ed 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6493,6 +6493,18 @@ EXPORT_SYMBOL(napi_busy_loop);
 
 #endif /* CONFIG_NET_RX_BUSY_POLL */
 
+static void napi_hash_add_with_id(struct napi_struct *napi, unsigned int napi_id)
+{
+	spin_lock(&napi_hash_lock);
+
+	napi->napi_id = napi_id;
+
+	hlist_add_head_rcu(&napi->napi_hash_node,
+			   &napi_hash[napi->napi_id % HASH_SIZE(napi_hash)]);
+
+	spin_unlock(&napi_hash_lock);
+}
+
 static void napi_hash_add(struct napi_struct *napi)
 {
 	if (test_bit(NAPI_STATE_NO_BUSY_POLL, &napi->state))
@@ -6505,12 +6517,13 @@ static void napi_hash_add(struct napi_struct *napi)
 		if (unlikely(++napi_gen_id < MIN_NAPI_ID))
 			napi_gen_id = MIN_NAPI_ID;
 	} while (napi_by_id(napi_gen_id));
-	napi->napi_id = napi_gen_id;
-
-	hlist_add_head_rcu(&napi->napi_hash_node,
-			   &napi_hash[napi->napi_id % HASH_SIZE(napi_hash)]);
 
 	spin_unlock(&napi_hash_lock);
+
+	napi_hash_add_with_id(napi, napi_gen_id);
+
+	if (napi->config)
+		napi->config->napi_id = napi_gen_id;
 }
 
 /* Warning : caller is responsible to make sure rcu grace period
@@ -6631,6 +6644,21 @@ void netif_queue_set_napi(struct net_device *dev, unsigned int queue_index,
 }
 EXPORT_SYMBOL(netif_queue_set_napi);
 
+static void napi_restore_config(struct napi_struct *n)
+{
+	n->defer_hard_irqs = n->config->defer_hard_irqs;
+	n->gro_flush_timeout = n->config->gro_flush_timeout;
+	napi_hash_add_with_id(n, n->config->napi_id);
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
@@ -6641,8 +6669,6 @@ void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
 	INIT_HLIST_NODE(&napi->napi_hash_node);
 	hrtimer_init(&napi->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
 	napi->timer.function = napi_watchdog;
-	napi_set_defer_hard_irqs(napi, READ_ONCE(dev->napi_defer_hard_irqs));
-	napi_set_gro_flush_timeout(napi, READ_ONCE(dev->gro_flush_timeout));
 	init_gro_hash(napi);
 	napi->skb = NULL;
 	INIT_LIST_HEAD(&napi->rx_list);
@@ -6660,7 +6686,15 @@ void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
 	set_bit(NAPI_STATE_SCHED, &napi->state);
 	set_bit(NAPI_STATE_NPSVC, &napi->state);
 	list_add_rcu(&napi->dev_list, &dev->napi_list);
-	napi_hash_add(napi);
+	/* if there is no config associated with this NAPI, generate a fresh
+	 * NAPI ID and hash it. Otherwise, settings will be restored in napi_enable.
+	 */
+	if (!napi->config || (napi->config && !napi->config->napi_id)) {
+		napi_hash_add(napi);
+		napi_set_defer_hard_irqs(napi, READ_ONCE(dev->napi_defer_hard_irqs));
+		napi_set_gro_flush_timeout(napi, READ_ONCE(dev->gro_flush_timeout));
+	}
+
 	napi_get_frags_check(napi);
 	/* Create kthread for this napi if dev->threaded is set.
 	 * Clear dev->threaded if kthread creation failed so that
@@ -6692,6 +6726,9 @@ void napi_disable(struct napi_struct *n)
 
 	hrtimer_cancel(&n->timer);
 
+	if (n->config)
+		napi_save_config(n);
+
 	clear_bit(NAPI_STATE_DISABLE, &n->state);
 }
 EXPORT_SYMBOL(napi_disable);
@@ -6714,6 +6751,9 @@ void napi_enable(struct napi_struct *n)
 		if (n->dev->threaded && n->thread)
 			new |= NAPIF_STATE_THREADED;
 	} while (!try_cmpxchg(&n->state, &val, new));
+
+	if (n->config)
+		napi_restore_config(n);
 }
 EXPORT_SYMBOL(napi_enable);
 
@@ -6736,7 +6776,13 @@ void __netif_napi_del(struct napi_struct *napi)
 	if (!test_and_clear_bit(NAPI_STATE_LISTED, &napi->state))
 		return;
 
-	napi_hash_del(napi);
+	if (!napi->config) {
+		napi_hash_del(napi);
+	} else {
+		napi->index = -1;
+		napi->config = NULL;
+	}
+
 	list_del_rcu(&napi->dev_list);
 	napi_free_frags(napi);
 
@@ -11049,6 +11095,8 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 		unsigned int txqs, unsigned int rxqs)
 {
 	struct net_device *dev;
+	size_t napi_config_sz;
+	unsigned int maxqs;
 
 	BUG_ON(strlen(name) >= sizeof(dev->name));
 
@@ -11062,6 +11110,9 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 		return NULL;
 	}
 
+	WARN_ON_ONCE(txqs != rxqs);
+	maxqs = max(txqs, rxqs);
+
 	dev = kvzalloc(struct_size(dev, priv, sizeof_priv),
 		       GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFAIL);
 	if (!dev)
@@ -11136,6 +11187,11 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
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
@@ -11197,6 +11253,8 @@ void free_netdev(struct net_device *dev)
 	list_for_each_entry_safe(p, n, &dev->napi_list, dev_list)
 		netif_napi_del(p);
 
+	kvfree(dev->napi_config);
+
 	ref_tracker_dir_exit(&dev->refcnt_tracker);
 #ifdef CONFIG_PCPU_DEV_REFCNT
 	free_percpu(dev->pcpu_refcnt);
diff --git a/net/core/dev.h b/net/core/dev.h
index a9d5f678564a..9eb3f559275c 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -167,11 +167,17 @@ static inline void napi_set_defer_hard_irqs(struct napi_struct *n, u32 defer)
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
@@ -206,11 +212,17 @@ static inline void napi_set_gro_flush_timeout(struct napi_struct *n,
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


