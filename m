Return-Path: <netdev+bounces-279118-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iL4QAz0x4WlGqQAAu9opvQ
	(envelope-from <netdev+bounces-279118-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 20:58:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C161413EA8
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 20:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C38430A4A89
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 18:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D92D34A76E;
	Thu, 16 Apr 2026 18:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwCB3xtr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com [209.85.167.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFE82773EC
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 18:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776365839; cv=none; b=RZelfHeWT9OWsLT5tOXkPe07uAmFVKCR/3eN7B6G8uqRk8vymQuMh4nOTHvWdaz8MQYFSyZ2pwZP80uZKsJfZae66ioM+iGE12x/8Zc1XTn/ryDMv8Wa+Xw1UU8zGgu2GzXMuBIK3ogNhCoFMbhTo4MiOjRRUjuJCdc1LF9X+fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776365839; c=relaxed/simple;
	bh=RuZ9uRJe7QUDupylDAdaAtpM0PACV7TXMB+0Yj0AZ34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f8SVgl3JJFGaGelHN3x4PaRwjXpVrllnpVuQ6JsCmF3W9vAuWmkxhtVM1YiU0/+P5Edux3d+4TAjLmvI7piUul+o17JJBDI2Ah33r5py6ksJD6qrdPcarNmdCBSFX4B6sP1Kz3QNpsbznBOiG4lSzHgOK4hk/2KNz6F77So0ee8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EwCB3xtr; arc=none smtp.client-ip=209.85.167.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f194.google.com with SMTP id 5614622812f47-46aa216a65aso4485977b6e.1
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 11:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776365837; x=1776970637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2UuRY53Oc+Vk9YTxgIUtMDvwyiWQ1mah3C2K4wgDLPg=;
        b=EwCB3xtrsv6hZ4NPvoWhIk/Qgi4dZlr1TWkcu54JFWJq/tf3ME7kmuKZIcpha384Oz
         gcEBW/QUWoEUQt75/cI5xBJH6X82wk7R8NVzX7NjqUedNepmkGLZ6mDbUyMa+n9Ph7ou
         7ujWxBjaELaKmZwvMqcGwkFjB9pqzO0JuZDIacG37B/3J/qUNDu7hNKeYJqanATOTwl8
         jt0BzGvih0/ZS3MZBOV7nOr2YAerN7CPPDm45jPJadnV+QKQb4OyjKK9tN+xKK/70air
         M69MyDyWWoVPbBmeE+0zdgXAS55D/2p0wgoYgeTVylQG7ozU+I/ubikj+C4JOqgrhEhX
         KJ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776365837; x=1776970637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2UuRY53Oc+Vk9YTxgIUtMDvwyiWQ1mah3C2K4wgDLPg=;
        b=LulV5VrXXabAUEyTmQO5ZGW/sgAl0dkfZ0+9qcjv8mp2ktHntvQUO57bZsXnrtn4Vi
         /QmTO50bitVdxP6hMxJVJJBuCJdMkRyuW1KwyYNynwU6lI6hjiKEJicoickrQkua/lKX
         4IVbkQ36G6/+mh691O/tlU6zohDBWPI0SCof8TgKwPL2nuOyaszn58f92Dg/ky7R3vaH
         4L7vntPF45a8YPGVaERd138gx2DuOrNHnzfJG9LQn1QZaLaN/wgr3MyKxL0GUFgt0x+I
         A5vl+it29XxC/GA1boawlyHkhdBFBMgztRt3WnZfCvUGC4rZtbpqmH3MqJitP509kBa8
         RQsQ==
X-Gm-Message-State: AOJu0Yyr7mnS6aYaXt6lqG7UmKR5UF3sO6Vo/YHJgU7NWtr5ZVg1zbsm
	bETw8l2jjw/mXewCI/LtV2334qlZAXSuN5pIZIpsGFhP0HO230Y0j+vZd8hIkXfw
X-Gm-Gg: AeBDietriKbpzGPLtP2Rwlsw0cRYRx7Uh+VR+ayBldepGRij8ZFydiI4dA6m722MyVM
	ygMkJCJNBprEBH6yKIlpsNFS4UFRF4iwxLZEOYX9824oFSV8IiU9wB9VfOid+tDYu2qtyZJyzQM
	cSIv8hpdyO+VBsCDw0KQTSCY2w3o0MN1ZF8xe7tHP6ji22OMoSl7ICcl929y8j5wxCGW/dw9BSR
	1IZHWovCjmmnbqJKIAiVTZdvO3EZXWA9CZXOPRMrk9k8A88aLMM2z2X+D/zy93ihrmtaNwE7kEv
	yzI67CW+MCk8okby66Np6I11MpmNIFfFWDrLs3uGFs9tKNVHrBtaxZaN5qGU/IYPy2TOufzCuvH
	lHljVHr4F3uz0xSrHb/eLF8GpWhtuR43cfkXIqc1WkR1kOC+u/1oNPuSv2Q0JpiAiyhpHLHOnV2
	ZjLl4Ek09aW+D4wAemZMgXbYsyQMy8
X-Received: by 2002:a05:6808:6d98:b0:467:de0e:feb6 with SMTP id 5614622812f47-4799a178503mr100524b6e.11.1776365836811;
        Thu, 16 Apr 2026 11:57:16 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:43::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47997fcfb38sm468258b6e.17.2026.04.16.11.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 11:57:16 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net v8 03/15] net: cache snapshot entries for ndo_set_rx_mode_async
Date: Thu, 16 Apr 2026 11:57:00 -0700
Message-ID: <20260416185712.2155425-4-sdf@fomichev.me>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260416185712.2155425-1-sdf@fomichev.me>
References: <20260416185712.2155425-1-sdf@fomichev.me>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279118-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fomichev.me:mid,fomichev.me:email]
X-Rspamd-Queue-Id: 4C161413EA8
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
index 6ed97f4c3bc6..97b435da5771 100644
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
@@ -5025,10 +5027,11 @@ void __hw_addr_init(struct netdev_hw_addr_list *list);
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
index b37061238a25..8597ec56fd64 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -12088,6 +12088,7 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 
 	mutex_init(&dev->lock);
 	INIT_LIST_HEAD(&dev->rx_mode_node);
+	__hw_addr_init(&dev->rx_mode_addr_cache);
 
 	dev->priv_flags = IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM;
 	setup(dev);
@@ -12192,6 +12193,8 @@ void free_netdev(struct net_device *dev)
 
 	kfree(rcu_dereference_protected(dev->ingress_queue, 1));
 
+	__hw_addr_flush(&dev->rx_mode_addr_cache);
+
 	/* Flush device addresses */
 	dev_addr_flush(dev);
 
diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
index 056bca6fce12..7bab2ed0f625 100644
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


