Return-Path: <netdev+bounces-276046-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GM6nCA0k1WnK1AcAu9opvQ
	(envelope-from <netdev+bounces-276046-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 17:34:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B22563B1199
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 17:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E64D305288F
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 15:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C213F3BE644;
	Tue,  7 Apr 2026 15:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOnEgpuB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f66.google.com (mail-oa1-f66.google.com [209.85.160.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461653624C0
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 15:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775575879; cv=none; b=SpNwF4pwzv2g056OUNic3uGECFUsW3xN5B0AOiS0IQNkb6gUQog/4muzreASH9Y8FlWnvtyOJpiR6aIPbvYkQo4OW/0NgOiYaoknhDV3S4InejZs8rc8HwpC+qJtjT9HJlie1Q7WgprOsE20HcEPbdfF3Ff3YXPIGhpTkFbn9UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775575879; c=relaxed/simple;
	bh=UN8xlYZopPiCjJ27LzExyJKhUM4lPHj10evpPr+opa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hNA7htVZhQekC6vBBHzkKimNPFGLdh99L3erMVEc4yGCVHkciGDKUL2mvWtEZE6tP+oDK2FT4J/+pRwUDkiIEZikdwFSbphVbPuRVdMQcsIllnqWYOAbmUdhrQTYJJuiylhlsnFEFl052MpYNRIuZJp9GxAKfpwSU767wfiI6O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dOnEgpuB; arc=none smtp.client-ip=209.85.160.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f66.google.com with SMTP id 586e51a60fabf-40ef10ec84cso3810286fac.2
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 08:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775575867; x=1776180667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uw8TpLfvCDqn5cvoi1cHh+hz1DDAoAGM1GlO5K9uOuA=;
        b=dOnEgpuBnKoSPf2GGfvBcMhSOPzvZHDSivk7GqvTSvRJIf350r0Fa3jTk/jFE5LOEd
         p1O0XuaCclYbml7s2KjuFy3yLKVuacQbXXFQtJ/ndOGGYuI4PkAidpxvKva6EaObGAj2
         megx1anegB5ZNfd9s/TCrHBAw54hElb6LYzT7Y3W/1MO55H8vCmW1kjAbXZN91+1s3Bv
         HjgEXHDoMw1Absu30uZE++UjYlSbwGa9rBo8Gva+0ioPsJqIvN41wZ0iJsf8Dn13XC9g
         X588k5wawTDPGAIQ6GvPvLOa6vqAesvBq/2OY01V+23vyo+806WEvgYBoEZM9FFjiEtN
         sviQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775575867; x=1776180667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Uw8TpLfvCDqn5cvoi1cHh+hz1DDAoAGM1GlO5K9uOuA=;
        b=jgrROIW7jLrCbdZZqNnS1vzN7Rz8Lv6mzPXP8rHwZvV8cNTqIrtFuCTWh4YNc80Qpf
         lmwqdSJ2XG91sLApTLLGo4Zd6tXVPvnYjlSdGjHcKZlZFfcmP/SKWQgKgqPzychqpQ89
         45jcHGlGLJIo+UfubCxAv0ECvjYloJgSSG9AIi7CfgE1/E98da8U7o9YJMFVFPC5TX/i
         Cl2nGj9WK6vqxJ6ZqlIvcXWdNGFbdy7eXV/dIHHoNASKL9gvb8X/2PE40rzueYA4VWar
         cvHcdVLnFCodWAKT9NtjYmXYrKs4Nzle2MZ3Dv4wXt91ioKuIpmKTGSL9wYEaGjM1c1e
         rU2g==
X-Gm-Message-State: AOJu0YzYGzLr4pcXR1Qpn8xx0p8cSyWXTEL0M9o0aR4lhkkwXC5QL9LX
	zuyuA81nu8jGcG4gjtLIUNe9wkjuXHIJ0iRA59RiuT+V32sNxN8gRo4SRlsN09kTGsk=
X-Gm-Gg: AeBDietzNrCSHQvN6AQx1nlDMloW+LFt4ETjQ6LMP4CLYEi4VAa8oujtM5mOQDzl9pq
	Gcz5Wtqj4C/At8IW1BgQjqqki056vn/xKP97rgwPSUIKhNfYi8jiSHaxsVoUyYGd2hppiWvL7zx
	NCv5j3l1V/f9vcj57Y+e5egOSdWHZc4ZwarXRwfE9EGed86mBJYJvyl8QdgkZ1oyELhjG5wVIb0
	90ZmL4qIuhb5PxwLB7Trl1OgRrO++zjLza9h//tfjxOhGqCNJeFerfkv6n/mIUNzvMeIXdDSFmY
	Oi4YTwTpZCiilu3prk/NVG/BM4KZzZer6Lo0+LTaQ4svMjOs44W/fIvZuSrgJInGiBSL53jmvZI
	uDP5h90Ll/kAgOCWB2XbtXCaNvAnhaCrNYr48Nj5NuIgL3G/vp20vZoOWut0lcgnAO/2MRzcqfl
	djCtbSPTWwg4GyeQ==
X-Received: by 2002:a05:6870:2398:b0:41b:f7f5:e88c with SMTP id 586e51a60fabf-4230ffc1546mr9225739fac.23.1775575866240;
        Tue, 07 Apr 2026 08:31:06 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-422eb25ad44sm13626914fac.12.2026.04.07.08.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 08:31:05 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v6 03/14] net: cache snapshot entries for ndo_set_rx_mode_async
Date: Tue,  7 Apr 2026 08:30:50 -0700
Message-ID: <20260407153101.3694714-4-sdf@fomichev.me>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260407153101.3694714-1-sdf@fomichev.me>
References: <20260407153101.3694714-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276046-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fomichev.me:email,fomichev.me:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B22563B1199
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a per-device netdev_hw_addr_list cache (rx_mode_addr_cache) that
allows __hw_addr_list_snapshot() and __hw_addr_list_reconcile() to
reuse previously allocated entries instead of hitting GFP_ATOMIC on
every snapshot cycle.

snapshot pops entries from the cache when available, falling back to
__hw_addr_create(). reconcile splices both snapshot lists back into
the cache via __hw_addr_splice(). The cache is flushed in
free_netdev().

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
(cherry picked from commit ba3ab1832a511f660fdc6231245b14bf610c05bd)
---
 include/linux/netdevice.h      |  7 ++--
 net/core/dev.c                 |  3 ++
 net/core/dev_addr_lists.c      | 66 ++++++++++++++++++++++++----------
 net/core/dev_addr_lists_test.c | 60 +++++++++++++++++++++----------
 4 files changed, 97 insertions(+), 39 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0a41b216cbcf..0c11bfd716a9 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1919,6 +1919,7 @@ enum netdev_reg_state {
  *				does not implement ndo_set_rx_mode()
  *	@rx_mode_node:		List entry for rx_mode work processing
  *	@rx_mode_tracker:	Refcount tracker for rx_mode work
+ *	@rx_mode_addr_cache:	Recycled snapshot entries for rx_mode work
  *	@uc:			unicast mac addresses
  *	@mc:			multicast mac addresses
  *	@dev_addrs:		list of device hw addresses
@@ -2312,6 +2313,7 @@ struct net_device {
 	bool			uc_promisc;
 	struct list_head	rx_mode_node;
 	netdevice_tracker	rx_mode_tracker;
+	struct netdev_hw_addr_list	rx_mode_addr_cache;
 #ifdef CONFIG_LOCKDEP
 	unsigned char		nested_level;
 #endif
@@ -5016,10 +5018,11 @@ void __hw_addr_init(struct netdev_hw_addr_list *list);
 void __hw_addr_flush(struct netdev_hw_addr_list *list);
 int __hw_addr_list_snapshot(struct netdev_hw_addr_list *snap,
 			    const struct netdev_hw_addr_list *list,
-			    int addr_len);
+			    int addr_len, struct netdev_hw_addr_list *cache);
 void __hw_addr_list_reconcile(struct netdev_hw_addr_list *real_list,
 			      struct netdev_hw_addr_list *work,
-			      struct netdev_hw_addr_list *ref, int addr_len);
+			      struct netdev_hw_addr_list *ref, int addr_len,
+			      struct netdev_hw_addr_list *cache);
 
 /* Functions used for device addresses handling */
 void dev_addr_mod(struct net_device *dev, unsigned int offset,
diff --git a/net/core/dev.c b/net/core/dev.c
index fe33feacc4f3..23a832c9facc 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -12074,6 +12074,7 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 
 	mutex_init(&dev->lock);
 	INIT_LIST_HEAD(&dev->rx_mode_node);
+	__hw_addr_init(&dev->rx_mode_addr_cache);
 
 	dev->priv_flags = IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM;
 	setup(dev);
@@ -12178,6 +12179,8 @@ void free_netdev(struct net_device *dev)
 
 	kfree(rcu_dereference_protected(dev->ingress_queue, 1));
 
+	__hw_addr_flush(&dev->rx_mode_addr_cache);
+
 	/* Flush device addresses */
 	dev_addr_flush(dev);
 
diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
index 477392127e8a..88e995db15dd 100644
--- a/net/core/dev_addr_lists.c
+++ b/net/core/dev_addr_lists.c
@@ -511,30 +511,50 @@ void __hw_addr_init(struct netdev_hw_addr_list *list)
 }
 EXPORT_SYMBOL(__hw_addr_init);
 
+static void __hw_addr_splice(struct netdev_hw_addr_list *dst,
+			     struct netdev_hw_addr_list *src)
+{
+	src->tree = RB_ROOT;
+	list_splice_init(&src->list, &dst->list);
+	dst->count += src->count;
+	src->count = 0;
+}
+
 /**
  *  __hw_addr_list_snapshot - create a snapshot copy of an address list
  *  @snap: destination snapshot list (needs to be __hw_addr_init-initialized)
  *  @list: source address list to snapshot
  *  @addr_len: length of addresses
+ *  @cache: entry cache to reuse entries from; falls back to GFP_ATOMIC
  *
- *  Creates a copy of @list with individually allocated entries suitable
- *  for use with __hw_addr_sync_dev() and other list manipulation helpers.
- *  Each entry is allocated with GFP_ATOMIC; must be called under a spinlock.
+ *  Creates a copy of @list reusing entries from @cache when available.
+ *  Must be called under a spinlock.
  *
  *  Return: 0 on success, -errno on failure.
  */
 int __hw_addr_list_snapshot(struct netdev_hw_addr_list *snap,
 			    const struct netdev_hw_addr_list *list,
-			    int addr_len)
+			    int addr_len, struct netdev_hw_addr_list *cache)
 {
 	struct netdev_hw_addr *ha, *entry;
 
 	list_for_each_entry(ha, &list->list, list) {
-		entry = __hw_addr_create(ha->addr, addr_len, ha->type,
-					 false, false);
-		if (!entry) {
-			__hw_addr_flush(snap);
-			return -ENOMEM;
+		if (cache->count) {
+			entry = list_first_entry(&cache->list,
+						 struct netdev_hw_addr, list);
+			list_del(&entry->list);
+			cache->count--;
+			memcpy(entry->addr, ha->addr, addr_len);
+			entry->type = ha->type;
+			entry->global_use = false;
+			entry->synced = 0;
+		} else {
+			entry = __hw_addr_create(ha->addr, addr_len, ha->type,
+						 false, false);
+			if (!entry) {
+				__hw_addr_flush(snap);
+				return -ENOMEM;
+			}
 		}
 		entry->sync_cnt = ha->sync_cnt;
 		entry->refcount = ha->refcount;
@@ -554,15 +574,17 @@ EXPORT_SYMBOL_IF_KUNIT(__hw_addr_list_snapshot);
  *  @work: the working snapshot (modified by driver via __hw_addr_sync_dev)
  *  @ref: the reference snapshot (untouched copy of original state)
  *  @addr_len: length of addresses
+ *  @cache: entry cache to return snapshot entries to for reuse
  *
  *  Walks the reference snapshot and compares each entry against the work
  *  snapshot to compute sync_cnt deltas. Applies those deltas to @real_list.
- *  Frees both snapshots when done.
+ *  Returns snapshot entries to @cache for reuse; frees both snapshots.
  *  Caller must hold netif_addr_lock_bh.
  */
 void __hw_addr_list_reconcile(struct netdev_hw_addr_list *real_list,
 			      struct netdev_hw_addr_list *work,
-			      struct netdev_hw_addr_list *ref, int addr_len)
+			      struct netdev_hw_addr_list *ref, int addr_len,
+			      struct netdev_hw_addr_list *cache)
 {
 	struct netdev_hw_addr *ref_ha, *tmp, *work_ha, *real_ha;
 	int delta;
@@ -611,8 +633,8 @@ void __hw_addr_list_reconcile(struct netdev_hw_addr_list *real_list,
 		}
 	}
 
-	__hw_addr_flush(work);
-	__hw_addr_flush(ref);
+	__hw_addr_splice(cache, work);
+	__hw_addr_splice(cache, ref);
 }
 EXPORT_SYMBOL_IF_KUNIT(__hw_addr_list_reconcile);
 
@@ -1173,14 +1195,18 @@ static int netif_addr_lists_snapshot(struct net_device *dev,
 {
 	int err;
 
-	err = __hw_addr_list_snapshot(uc_snap, &dev->uc, dev->addr_len);
+	err = __hw_addr_list_snapshot(uc_snap, &dev->uc, dev->addr_len,
+				      &dev->rx_mode_addr_cache);
 	if (!err)
-		err = __hw_addr_list_snapshot(uc_ref, &dev->uc, dev->addr_len);
+		err = __hw_addr_list_snapshot(uc_ref, &dev->uc, dev->addr_len,
+					      &dev->rx_mode_addr_cache);
 	if (!err)
 		err = __hw_addr_list_snapshot(mc_snap, &dev->mc,
-					      dev->addr_len);
+					      dev->addr_len,
+					      &dev->rx_mode_addr_cache);
 	if (!err)
-		err = __hw_addr_list_snapshot(mc_ref, &dev->mc, dev->addr_len);
+		err = __hw_addr_list_snapshot(mc_ref, &dev->mc, dev->addr_len,
+					      &dev->rx_mode_addr_cache);
 
 	if (err) {
 		__hw_addr_flush(uc_snap);
@@ -1197,8 +1223,10 @@ static void netif_addr_lists_reconcile(struct net_device *dev,
 				       struct netdev_hw_addr_list *uc_ref,
 				       struct netdev_hw_addr_list *mc_ref)
 {
-	__hw_addr_list_reconcile(&dev->uc, uc_snap, uc_ref, dev->addr_len);
-	__hw_addr_list_reconcile(&dev->mc, mc_snap, mc_ref, dev->addr_len);
+	__hw_addr_list_reconcile(&dev->uc, uc_snap, uc_ref, dev->addr_len,
+				 &dev->rx_mode_addr_cache);
+	__hw_addr_list_reconcile(&dev->mc, mc_snap, mc_ref, dev->addr_len,
+				 &dev->rx_mode_addr_cache);
 }
 
 static void netif_rx_mode_run(struct net_device *dev)
diff --git a/net/core/dev_addr_lists_test.c b/net/core/dev_addr_lists_test.c
index fba926d5ec0d..260e71a2399f 100644
--- a/net/core/dev_addr_lists_test.c
+++ b/net/core/dev_addr_lists_test.c
@@ -251,8 +251,8 @@ static void dev_addr_test_add_excl(struct kunit *test)
  */
 static void dev_addr_test_snapshot_sync(struct kunit *test)
 {
+	struct netdev_hw_addr_list snap, ref, cache;
 	struct net_device *netdev = test->priv;
-	struct netdev_hw_addr_list snap, ref;
 	struct dev_addr_test_priv *datp;
 	struct netdev_hw_addr *ha;
 	u8 addr[ETH_ALEN];
@@ -268,10 +268,13 @@ static void dev_addr_test_snapshot_sync(struct kunit *test)
 	netif_addr_lock_bh(netdev);
 	__hw_addr_init(&snap);
 	__hw_addr_init(&ref);
+	__hw_addr_init(&cache);
 	KUNIT_EXPECT_EQ(test, 0,
-			__hw_addr_list_snapshot(&snap, &netdev->uc, ETH_ALEN));
+			__hw_addr_list_snapshot(&snap, &netdev->uc, ETH_ALEN,
+						&cache));
 	KUNIT_EXPECT_EQ(test, 0,
-			__hw_addr_list_snapshot(&ref, &netdev->uc, ETH_ALEN));
+			__hw_addr_list_snapshot(&ref, &netdev->uc, ETH_ALEN,
+						&cache));
 	netif_addr_unlock_bh(netdev);
 
 	/* Driver syncs ADDR_A to hardware */
@@ -283,7 +286,8 @@ static void dev_addr_test_snapshot_sync(struct kunit *test)
 
 	/* Reconcile: delta=+1 applied to real entry */
 	netif_addr_lock_bh(netdev);
-	__hw_addr_list_reconcile(&netdev->uc, &snap, &ref, ETH_ALEN);
+	__hw_addr_list_reconcile(&netdev->uc, &snap, &ref, ETH_ALEN,
+				 &cache);
 	netif_addr_unlock_bh(netdev);
 
 	/* Real entry should now reflect the sync: sync_cnt=1, refcount=2 */
@@ -301,6 +305,7 @@ static void dev_addr_test_snapshot_sync(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 0, datp->addr_unsynced);
 	KUNIT_EXPECT_EQ(test, 1, netdev->uc.count);
 
+	__hw_addr_flush(&cache);
 	rtnl_unlock();
 }
 
@@ -310,8 +315,8 @@ static void dev_addr_test_snapshot_sync(struct kunit *test)
  */
 static void dev_addr_test_snapshot_remove_during_sync(struct kunit *test)
 {
+	struct netdev_hw_addr_list snap, ref, cache;
 	struct net_device *netdev = test->priv;
-	struct netdev_hw_addr_list snap, ref;
 	struct dev_addr_test_priv *datp;
 	struct netdev_hw_addr *ha;
 	u8 addr[ETH_ALEN];
@@ -327,10 +332,13 @@ static void dev_addr_test_snapshot_remove_during_sync(struct kunit *test)
 	netif_addr_lock_bh(netdev);
 	__hw_addr_init(&snap);
 	__hw_addr_init(&ref);
+	__hw_addr_init(&cache);
 	KUNIT_EXPECT_EQ(test, 0,
-			__hw_addr_list_snapshot(&snap, &netdev->uc, ETH_ALEN));
+			__hw_addr_list_snapshot(&snap, &netdev->uc, ETH_ALEN,
+						&cache));
 	KUNIT_EXPECT_EQ(test, 0,
-			__hw_addr_list_snapshot(&ref, &netdev->uc, ETH_ALEN));
+			__hw_addr_list_snapshot(&ref, &netdev->uc, ETH_ALEN,
+						&cache));
 	netif_addr_unlock_bh(netdev);
 
 	/* Driver syncs ADDR_A to hardware */
@@ -349,7 +357,8 @@ static void dev_addr_test_snapshot_remove_during_sync(struct kunit *test)
 	 * so it gets re-inserted as stale (sync_cnt=1, refcount=1).
 	 */
 	netif_addr_lock_bh(netdev);
-	__hw_addr_list_reconcile(&netdev->uc, &snap, &ref, ETH_ALEN);
+	__hw_addr_list_reconcile(&netdev->uc, &snap, &ref, ETH_ALEN,
+				 &cache);
 	netif_addr_unlock_bh(netdev);
 
 	KUNIT_EXPECT_EQ(test, 1, netdev->uc.count);
@@ -366,6 +375,7 @@ static void dev_addr_test_snapshot_remove_during_sync(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 1 << ADDR_A, datp->addr_unsynced);
 	KUNIT_EXPECT_EQ(test, 0, netdev->uc.count);
 
+	__hw_addr_flush(&cache);
 	rtnl_unlock();
 }
 
@@ -376,8 +386,8 @@ static void dev_addr_test_snapshot_remove_during_sync(struct kunit *test)
  */
 static void dev_addr_test_snapshot_readd_during_unsync(struct kunit *test)
 {
+	struct netdev_hw_addr_list snap, ref, cache;
 	struct net_device *netdev = test->priv;
-	struct netdev_hw_addr_list snap, ref;
 	struct dev_addr_test_priv *datp;
 	struct netdev_hw_addr *ha;
 	u8 addr[ETH_ALEN];
@@ -403,10 +413,13 @@ static void dev_addr_test_snapshot_readd_during_unsync(struct kunit *test)
 	netif_addr_lock_bh(netdev);
 	__hw_addr_init(&snap);
 	__hw_addr_init(&ref);
+	__hw_addr_init(&cache);
 	KUNIT_EXPECT_EQ(test, 0,
-			__hw_addr_list_snapshot(&snap, &netdev->uc, ETH_ALEN));
+			__hw_addr_list_snapshot(&snap, &netdev->uc, ETH_ALEN,
+						&cache));
 	KUNIT_EXPECT_EQ(test, 0,
-			__hw_addr_list_snapshot(&ref, &netdev->uc, ETH_ALEN));
+			__hw_addr_list_snapshot(&ref, &netdev->uc, ETH_ALEN,
+						&cache));
 	netif_addr_unlock_bh(netdev);
 
 	/* Driver unsyncs stale ADDR_A from hardware */
@@ -426,7 +439,8 @@ static void dev_addr_test_snapshot_readd_during_unsync(struct kunit *test)
 	 * applied. Result: sync_cnt=0, refcount=1 (fresh).
 	 */
 	netif_addr_lock_bh(netdev);
-	__hw_addr_list_reconcile(&netdev->uc, &snap, &ref, ETH_ALEN);
+	__hw_addr_list_reconcile(&netdev->uc, &snap, &ref, ETH_ALEN,
+				 &cache);
 	netif_addr_unlock_bh(netdev);
 
 	/* Entry survives as fresh: needs re-sync to HW */
@@ -443,6 +457,7 @@ static void dev_addr_test_snapshot_readd_during_unsync(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 1 << ADDR_A, datp->addr_synced);
 	KUNIT_EXPECT_EQ(test, 0, datp->addr_unsynced);
 
+	__hw_addr_flush(&cache);
 	rtnl_unlock();
 }
 
@@ -452,8 +467,8 @@ static void dev_addr_test_snapshot_readd_during_unsync(struct kunit *test)
  */
 static void dev_addr_test_snapshot_add_and_remove(struct kunit *test)
 {
+	struct netdev_hw_addr_list snap, ref, cache;
 	struct net_device *netdev = test->priv;
-	struct netdev_hw_addr_list snap, ref;
 	struct dev_addr_test_priv *datp;
 	struct netdev_hw_addr *ha;
 	u8 addr[ETH_ALEN];
@@ -480,10 +495,13 @@ static void dev_addr_test_snapshot_add_and_remove(struct kunit *test)
 	netif_addr_lock_bh(netdev);
 	__hw_addr_init(&snap);
 	__hw_addr_init(&ref);
+	__hw_addr_init(&cache);
 	KUNIT_EXPECT_EQ(test, 0,
-			__hw_addr_list_snapshot(&snap, &netdev->uc, ETH_ALEN));
+			__hw_addr_list_snapshot(&snap, &netdev->uc, ETH_ALEN,
+						&cache));
 	KUNIT_EXPECT_EQ(test, 0,
-			__hw_addr_list_snapshot(&ref, &netdev->uc, ETH_ALEN));
+			__hw_addr_list_snapshot(&ref, &netdev->uc, ETH_ALEN,
+						&cache));
 	netif_addr_unlock_bh(netdev);
 
 	/* Driver syncs snapshot: ADDR_C is new -> synced; A,B already synced */
@@ -502,7 +520,8 @@ static void dev_addr_test_snapshot_add_and_remove(struct kunit *test)
 	 * so nothing to apply to ADDR_B.
 	 */
 	netif_addr_lock_bh(netdev);
-	__hw_addr_list_reconcile(&netdev->uc, &snap, &ref, ETH_ALEN);
+	__hw_addr_list_reconcile(&netdev->uc, &snap, &ref, ETH_ALEN,
+				 &cache);
 	netif_addr_unlock_bh(netdev);
 
 	/* ADDR_A: unchanged (sync_cnt=1, refcount=2)
@@ -536,13 +555,14 @@ static void dev_addr_test_snapshot_add_and_remove(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 1 << ADDR_B, datp->addr_unsynced);
 	KUNIT_EXPECT_EQ(test, 2, netdev->uc.count);
 
+	__hw_addr_flush(&cache);
 	rtnl_unlock();
 }
 
 static void dev_addr_test_snapshot_benchmark(struct kunit *test)
 {
 	struct net_device *netdev = test->priv;
-	struct netdev_hw_addr_list snap;
+	struct netdev_hw_addr_list snap, cache;
 	u8 addr[ETH_ALEN];
 	s64 duration = 0;
 	ktime_t start;
@@ -557,6 +577,8 @@ static void dev_addr_test_snapshot_benchmark(struct kunit *test)
 		KUNIT_EXPECT_EQ(test, 0, dev_uc_add(netdev, addr));
 	}
 
+	__hw_addr_init(&cache);
+
 	for (iter = 0; iter < 1000; iter++) {
 		netif_addr_lock_bh(netdev);
 		__hw_addr_init(&snap);
@@ -564,13 +586,15 @@ static void dev_addr_test_snapshot_benchmark(struct kunit *test)
 		start = ktime_get();
 		KUNIT_EXPECT_EQ(test, 0,
 				__hw_addr_list_snapshot(&snap, &netdev->uc,
-							ETH_ALEN));
+							ETH_ALEN, &cache));
 		duration += ktime_to_ns(ktime_sub(ktime_get(), start));
 
 		netif_addr_unlock_bh(netdev);
 		__hw_addr_flush(&snap);
 	}
 
+	__hw_addr_flush(&cache);
+
 	kunit_info(test,
 		   "1024 addrs x 1000 snapshots: %lld ns total, %lld ns/iter",
 		   duration, div_s64(duration, 1000));
-- 
2.52.0


