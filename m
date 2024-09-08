Return-Path: <netdev+bounces-126289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5F39708A4
	for <lists+netdev@lfdr.de>; Sun,  8 Sep 2024 18:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C07FD1C20E0C
	for <lists+netdev@lfdr.de>; Sun,  8 Sep 2024 16:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4E5175D54;
	Sun,  8 Sep 2024 16:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="dKuGZRhq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110FF175D3E
	for <netdev@vger.kernel.org>; Sun,  8 Sep 2024 16:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725811718; cv=none; b=jPDIxA8Oy70igx4cqGbbPPBTnV0xNnWX2yQi4Vl8q4y4ILgK9nlIvuheDhDWFJufkQt1Gvn1aaAbaIOUKBi7gUC5v2/BYiuWP8ibkgsPf5udbQ80WrorFNA3xI391iJCULyxgIFsKglZpHgTHS044BneDo4+BAc6X1w2TKl+EhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725811718; c=relaxed/simple;
	bh=TEopUeuNpArQzjNi0/ijxKYlco4fqs+wda8kEBuhDiU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pXzM1iHY0lxXtv8tFNat3IltCG5l9DYgyV06oiGXNdwGtMj9FSFLeV6xdBeM0VicMS7EHaZWZYXb6Q9vNVx73JDRslbOyTSwuLZeiv4GobLeVCT5atUOtCVhuWqJYjaRDTOixqK1QCciz0jQawz13gbSbmLZiVzoArsJ45xPLFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=dKuGZRhq; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-718d985b6bbso1889340b3a.2
        for <netdev@vger.kernel.org>; Sun, 08 Sep 2024 09:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1725811715; x=1726416515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x49fADX7wQzdDZdnsJnfx2RtW4EZX6aPDebcZANzv7Q=;
        b=dKuGZRhqdIJrtKr0C/6GnrYPGUVAXSHtBbi1OKNpUy7/DFwDC70T3UOtzgwxXUHRAm
         R9N728pgf0cTg1mgEhO9FEeR7hpV3Z57z4ETx6pCUV7+BXzif+O6/n4JQmCCjkcJp5KD
         Cbe6xKBDrIlbMbfPNj8F1GlTdJClUdGk6O1Mo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725811715; x=1726416515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x49fADX7wQzdDZdnsJnfx2RtW4EZX6aPDebcZANzv7Q=;
        b=WFYyRLykcHjUh70ybNRfvWzz8liLnj8aH/lyTl1MSM+rRQhbtGvGCUtLJP7+YKiYym
         qzbwnfxBcu04vZdadUu4mgtK26kAI+oUTpm7wpef+F2CmGXANlYD18Vg0Telfb381n/1
         ST38ij9QMkm6inTpr+jSj7wNLjS3HC6OfPcx++8O8JztVZ/8tPCvWHMAwfJdQPokPW0e
         qzVKa5iWmG6MHo7Rgysl1yKT0oCpYoYJT7R4N39VdESY6pANUfo6KOjBvj8FdxmhY4BG
         fKimzSSjokH2KAGyXIq1It/KHfZlXtFiNFvURQJLrKyKXRVsiIBQb3Bi0iJggYuTOwxn
         WaQw==
X-Gm-Message-State: AOJu0YzGYOaypSskj/zBV/0ZDG6IBzxR3D51Orc+1remwsPpzDHRmJDu
	hqBUx0royaMvS7aivL41FsQeciNk0v2sE6kOnEjxhheq9UjFD9zq7mD0Inv8PD3obUNRpSRIIJ/
	FVUzTzVDy8A80EnGvRRIL1xj4mIARDygISVCA9JOZ3vvk94J39NZHSdP8f0ONl90CwNnRzKkv6d
	H52iNRjOKk8Nu1iVIPWK4qlv7oAoUP2Jn8dYymFuKF
X-Google-Smtp-Source: AGHT+IE3kHdpTxCt3sf1n/2nkPKmrrFiS28bSOkpaARZ0WbViQPWroW4ok4KOIVg7NpKcj3hfUxghg==
X-Received: by 2002:a17:902:ec8f:b0:202:4666:f018 with SMTP id d9443c01a7336-206f04e55c3mr118419965ad.15.1725811715224;
        Sun, 08 Sep 2024 09:08:35 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710f3179fsm21412535ad.258.2024.09.08.09.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 09:08:34 -0700 (PDT)
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
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next v2 1/9] net: napi: Add napi_storage
Date: Sun,  8 Sep 2024 16:06:35 +0000
Message-Id: <20240908160702.56618-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240908160702.56618-1-jdamato@fastly.com>
References: <20240908160702.56618-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a persistent NAPI storage area for NAPI configuration to the core.
Drivers opt-in to setting the storage for a NAPI by passing an index
when calling netif_napi_add_storage.

napi_storage is allocated in alloc_netdev_mqs, freed in free_netdev
(after the NAPIs are deleted), and set to 0 when napi_enable is called.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 .../networking/net_cachelines/net_device.rst  |  1 +
 include/linux/netdevice.h                     | 34 +++++++++++++++++++
 net/core/dev.c                                | 18 +++++++++-
 3 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index 22b07c814f4a..a82751c88d18 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -106,6 +106,7 @@ rx_handler_func_t*                  rx_handler              read_mostly
 void*                               rx_handler_data         read_mostly         -                   
 struct_netdev_queue*                ingress_queue           read_mostly         -                   
 struct_bpf_mprog_entry              tcx_ingress             -                   read_mostly         sch_handle_ingress
+struct napi_storage*                napi_storage            -                   read_mostly         napi_complete_done
 struct_nf_hook_entries*             nf_hooks_ingress                                                
 unsigned_char                       broadcast[32]                                                   
 struct_cpu_rmap*                    rx_cpu_rmap                                                     
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index b47c00657bd0..54da1c800e65 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -342,6 +342,14 @@ struct gro_list {
  */
 #define GRO_HASH_BUCKETS	8
 
+/*
+ * Structure for per-NAPI storage
+ */
+struct napi_storage {
+	u64 gro_flush_timeout;
+	u32 defer_hard_irqs;
+};
+
 /*
  * Structure for NAPI scheduling similar to tasklet but with weighting
  */
@@ -377,6 +385,8 @@ struct napi_struct {
 	struct list_head	dev_list;
 	struct hlist_node	napi_hash_node;
 	int			irq;
+	int			index;
+	struct napi_storage	*napi_storage;
 };
 
 enum {
@@ -2009,6 +2019,9 @@ enum netdev_reg_state {
  *	@dpll_pin: Pointer to the SyncE source pin of a DPLL subsystem,
  *		   where the clock is recovered.
  *
+ *	@napi_storage: An array of napi_storage structures containing per-NAPI
+ *		       settings.
+ *
  *	FIXME: cleanup struct net_device such that network protocol info
  *	moves out.
  */
@@ -2087,6 +2100,7 @@ struct net_device {
 #ifdef CONFIG_NET_XGRESS
 	struct bpf_mprog_entry __rcu *tcx_ingress;
 #endif
+	struct napi_storage	*napi_storage;
 	__cacheline_group_end(net_device_read_rx);
 
 	char			name[IFNAMSIZ];
@@ -2648,6 +2662,24 @@ netif_napi_add_tx_weight(struct net_device *dev,
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
+		       int (*poll)(struct napi_struct *, int), int weight,
+		       int index)
+{
+	napi->index = index;
+	napi->napi_storage = &dev->napi_storage[index];
+	netif_napi_add_weight(dev, napi, poll, weight);
+}
+
 /**
  * netif_napi_add_tx() - initialize a NAPI context to be used for Tx only
  * @dev:  network device
@@ -2683,6 +2715,8 @@ void __netif_napi_del(struct napi_struct *napi);
  */
 static inline void netif_napi_del(struct napi_struct *napi)
 {
+	napi->napi_storage = NULL;
+	napi->index = -1;
 	__netif_napi_del(napi);
 	synchronize_net();
 }
diff --git a/net/core/dev.c b/net/core/dev.c
index 22c3f14d9287..ca90e8cab121 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6719,6 +6719,9 @@ void napi_enable(struct napi_struct *n)
 		if (n->dev->threaded && n->thread)
 			new |= NAPIF_STATE_THREADED;
 	} while (!try_cmpxchg(&n->state, &val, new));
+
+	if (n->napi_storage)
+		memset(n->napi_storage, 0, sizeof(*n->napi_storage));
 }
 EXPORT_SYMBOL(napi_enable);
 
@@ -11054,6 +11057,8 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 		unsigned int txqs, unsigned int rxqs)
 {
 	struct net_device *dev;
+	size_t napi_storage_sz;
+	unsigned int maxqs;
 
 	BUG_ON(strlen(name) >= sizeof(dev->name));
 
@@ -11067,6 +11072,9 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 		return NULL;
 	}
 
+	WARN_ON_ONCE(txqs != rxqs);
+	maxqs = max(txqs, rxqs);
+
 	dev = kvzalloc(struct_size(dev, priv, sizeof_priv),
 		       GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFAIL);
 	if (!dev)
@@ -11141,6 +11149,11 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 	if (!dev->ethtool)
 		goto free_all;
 
+	napi_storage_sz = array_size(maxqs, sizeof(*dev->napi_storage));
+	dev->napi_storage = kvzalloc(napi_storage_sz, GFP_KERNEL_ACCOUNT);
+	if (!dev->napi_storage)
+		goto free_all;
+
 	strscpy(dev->name, name);
 	dev->name_assign_type = name_assign_type;
 	dev->group = INIT_NETDEV_GROUP;
@@ -11202,6 +11215,8 @@ void free_netdev(struct net_device *dev)
 	list_for_each_entry_safe(p, n, &dev->napi_list, dev_list)
 		netif_napi_del(p);
 
+	kvfree(dev->napi_storage);
+
 	ref_tracker_dir_exit(&dev->refcnt_tracker);
 #ifdef CONFIG_PCPU_DEV_REFCNT
 	free_percpu(dev->pcpu_refcnt);
@@ -11979,7 +11994,8 @@ static void __init net_dev_struct_check(void)
 #ifdef CONFIG_NET_XGRESS
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, tcx_ingress);
 #endif
-	CACHELINE_ASSERT_GROUP_SIZE(struct net_device, net_device_read_rx, 104);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, napi_storage);
+	CACHELINE_ASSERT_GROUP_SIZE(struct net_device, net_device_read_rx, 112);
 }
 
 /*
-- 
2.25.1


