Return-Path: <netdev+bounces-278139-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EEuHlkl3WkzaQkAu9opvQ
	(envelope-from <netdev+bounces-278139-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 19:18:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE09E3F1233
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 19:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C28C430451C6
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 17:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A8C3451AF;
	Mon, 13 Apr 2026 17:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rJclS+14"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B853368B5
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 17:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776100297; cv=none; b=Dt84HMQRGzkm++CoocYP1JwbPDgx4AQSbOF9ZD9XB3JgUBzNaI6lDHeonJ+9esWvbs4KtJmPcHKXggY12pMHzsOtL2hV/e5oxRVlxS0VpC1ZH49OBSxhM1qJJgtfyXmFEd3d38OUJ5ptPkcdEY/DHoOQifHNrkVW7Svw6peEmI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776100297; c=relaxed/simple;
	bh=Emy4bA4nzhhD09+8wLoPmbunqnoSheM+iOfuK1UCj+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EZVcpZ+BNvUUxRO6sKgJgSXFw2ulfDt5us34No6PlmIBQrgA4ZA9wpo0VCDDKHYjDSajeofL4N0uIK1g7makR2Vc0ke6YgkZhgfuviqoznTLQ+CvxbKotU9eAWmISz98HD4V+xU2DssSZZMaLOov7YB2ivZaweRupC7Z5KR+18g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rJclS+14; arc=none smtp.client-ip=209.85.210.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-7dbba5076c8so2355281a34.0
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 10:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776100294; x=1776705094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F9l0YtPgch7F02LlKRToaxxSWGKiuA0ga+AkdL1ZhmA=;
        b=rJclS+14wovcXfqcwf8GURyMBWPoB/3a6PMCBRyT1O+bE1kCrlGYF2pVtwN3D7f5Ey
         TiGk7psFmk4qnsqsDb6CX50ShHmL+Rd3Ag2o+Hmk+7R3huXGCLHQuyY3gXWKJXHUGUWN
         FfFpzwLRgJiCBwOW1V3ycm0nPgWPeiYwvhupY1aHR/JMDSNGv3vgvfqHtYS0rjJ67oW8
         dynWL5gdW0GPWs3keNkCWznRFTBqWnglbEyR/noj10KwICAiHC7vP1hgvxvVVGBW6mrK
         rh3/FFaoC/7dLX3cYfrK4HzPe165M4WUXQD+UEB3VrpTLLm0m1t094SJc4DEV3Bzno5L
         jtuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776100294; x=1776705094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F9l0YtPgch7F02LlKRToaxxSWGKiuA0ga+AkdL1ZhmA=;
        b=rEesfB3U4aP/ChXLA1b5nH1jM1Yoc73czvWQecacus1WtJrrLl+M/CQqG2A7PBfzzL
         fVSV/a5LQ3adwy/f8MnsgB2Tf4YBTuMqlQUIm9hSulFgqz0sfWG82SsDbqjU5AtOJp0a
         VRLjkkgGfGEsu5wHJMAmXDT8O5RkqZxI/8KZhVFQxQ4e/FvmeeT8PaRgY/am0D8FzS8n
         umCNNkB4OppBpgj50ofFVoCcixx8pW7qdasDmMAA1sC5W9SbCpRye6aRu7/nlGI4LjFC
         c3PCo88MykY/9I7Z8osq7ibzgLdIbwT4s4410+ILohLPGglUNxe/XDf281hF9O+BqcKc
         WKRg==
X-Gm-Message-State: AOJu0YxLvQu6R8eTApWCPbCpzUaRJsfDMVyuxtnZ8DoTcGGY6a7wIrEi
	zkNU/LE7VpqLEm2DNSARM4m3Mg4wwGvrFvtS+L3AX3pk8YD6HaG7Ysy6JRIXQxhB
X-Gm-Gg: AeBDieuq/GSB70mKfGgv2uwQ+OBCH69k597HuGQVVHyRoIQZNjEoHjDD5sma/HMZN3m
	WS9/EXuNQ8jRM0rpq7m/pEHe5MwOoNkizL/RxYDuwOjk5cg5Co0QoDa9HmX8H1/lTddf9DRXOFz
	kvMlNH1ViguWEkzcSJs3hAhxg0kOKolk27+bm5SHPkXmeri9YSNjTZcX8Xn91cvWgSc1SocxKsP
	9DUC3/PtfHl4sJUcQPnERJN3LGyPYP18Zs5nQmSF0vxivVB9OkY/up3+yXXnMW2mTR5h85Cz547
	rw4Ht3k2JXhY+ZCYZ8RLOhYgpCM3rzazIB0tS5sW6xw4LkmEuS5dD0r3RpejZxTYz7emRLwxmGb
	WnOxUCzgyOIFGsmG9IJ/giOuUPSRuDV2AzaVSJehG6BJ/8b2K4yy0+rm8GI5JLR9i6SRAnq6kBg
	VSCAvsKVcNsu297Rkw
X-Received: by 2002:a05:6830:6608:b0:7db:b5c9:2d87 with SMTP id 46e09a7af769-7dc27deeafamr9033692a34.11.1776100293683;
        Mon, 13 Apr 2026 10:11:33 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:3::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc2657335csm8993635a34.5.2026.04.13.10.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 10:11:33 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next v7 01/15] net: add address list snapshot and reconciliation infrastructure
Date: Mon, 13 Apr 2026 10:11:17 -0700
Message-ID: <20260413171131.550126-2-sdf@fomichev.me>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260413171131.550126-1-sdf@fomichev.me>
References: <20260413171131.550126-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278139-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,fomichev.me:email,fomichev.me:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CE09E3F1233
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Introduce __hw_addr_list_snapshot() and __hw_addr_list_reconcile()
for use by the upcoming ndo_set_rx_mode_async callback.

The async rx_mode path needs to snapshot the device's unicast and
multicast address lists under the addr_lock, hand those snapshots
to the driver (which may sleep), and then propagate any sync_cnt
changes back to the real lists. Two identical snapshots are taken:
a work copy for the driver to pass to __hw_addr_sync_dev() and a
reference copy to compute deltas against.

__hw_addr_list_reconcile() walks the reference snapshot comparing
each entry against the work snapshot to determine what the driver
synced or unsynced. It then applies those deltas to the real list,
handling concurrent modifications:

  - If the real entry was concurrently removed but the driver synced
    it to hardware (delta > 0), re-insert a stale entry so the next
    work run properly unsyncs it from hardware.
  - If the entry still exists, apply the delta normally. An entry
    whose refcount drops to zero is removed.

  # dev_addr_test_snapshot_benchmark: 1024 addrs x 1000 snapshots: 89872802 ns total, 89872 ns/iter
  # dev_addr_test_snapshot_benchmark.speed: slow

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 include/linux/netdevice.h      |   7 +
 net/core/dev.h                 |   1 +
 net/core/dev_addr_lists.c      | 109 +++++++++-
 net/core/dev_addr_lists_test.c | 363 ++++++++++++++++++++++++++++++++-
 4 files changed, 477 insertions(+), 3 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 47417b2d48a4..4a804f552da4 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5004,6 +5004,13 @@ void __hw_addr_unsync_dev(struct netdev_hw_addr_list *list,
 			  int (*unsync)(struct net_device *,
 					const unsigned char *));
 void __hw_addr_init(struct netdev_hw_addr_list *list);
+void __hw_addr_flush(struct netdev_hw_addr_list *list);
+int __hw_addr_list_snapshot(struct netdev_hw_addr_list *snap,
+			    const struct netdev_hw_addr_list *list,
+			    int addr_len);
+void __hw_addr_list_reconcile(struct netdev_hw_addr_list *real_list,
+			      struct netdev_hw_addr_list *work,
+			      struct netdev_hw_addr_list *ref, int addr_len);
 
 /* Functions used for device addresses handling */
 void dev_addr_mod(struct net_device *dev, unsigned int offset,
diff --git a/net/core/dev.h b/net/core/dev.h
index 628bdaebf0ca..585b6d7e88df 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -78,6 +78,7 @@ void linkwatch_run_queue(void);
 void dev_addr_flush(struct net_device *dev);
 int dev_addr_init(struct net_device *dev);
 void dev_addr_check(struct net_device *dev);
+void __hw_addr_flush(struct netdev_hw_addr_list *list);
 
 #if IS_ENABLED(CONFIG_NET_SHAPER)
 void net_shaper_flush_netdev(struct net_device *dev);
diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
index 76c91f224886..bb4851bc55ce 100644
--- a/net/core/dev_addr_lists.c
+++ b/net/core/dev_addr_lists.c
@@ -11,6 +11,7 @@
 #include <linux/rtnetlink.h>
 #include <linux/export.h>
 #include <linux/list.h>
+#include <kunit/visibility.h>
 
 #include "dev.h"
 
@@ -481,7 +482,7 @@ void __hw_addr_unsync_dev(struct netdev_hw_addr_list *list,
 }
 EXPORT_SYMBOL(__hw_addr_unsync_dev);
 
-static void __hw_addr_flush(struct netdev_hw_addr_list *list)
+void __hw_addr_flush(struct netdev_hw_addr_list *list)
 {
 	struct netdev_hw_addr *ha, *tmp;
 
@@ -492,6 +493,7 @@ static void __hw_addr_flush(struct netdev_hw_addr_list *list)
 	}
 	list->count = 0;
 }
+EXPORT_SYMBOL_IF_KUNIT(__hw_addr_flush);
 
 void __hw_addr_init(struct netdev_hw_addr_list *list)
 {
@@ -501,6 +503,111 @@ void __hw_addr_init(struct netdev_hw_addr_list *list)
 }
 EXPORT_SYMBOL(__hw_addr_init);
 
+/**
+ *  __hw_addr_list_snapshot - create a snapshot copy of an address list
+ *  @snap: destination snapshot list (needs to be __hw_addr_init-initialized)
+ *  @list: source address list to snapshot
+ *  @addr_len: length of addresses
+ *
+ *  Creates a copy of @list with individually allocated entries suitable
+ *  for use with __hw_addr_sync_dev() and other list manipulation helpers.
+ *  Each entry is allocated with GFP_ATOMIC; must be called under a spinlock.
+ *
+ *  Return: 0 on success, -errno on failure.
+ */
+int __hw_addr_list_snapshot(struct netdev_hw_addr_list *snap,
+			    const struct netdev_hw_addr_list *list,
+			    int addr_len)
+{
+	struct netdev_hw_addr *ha, *entry;
+
+	list_for_each_entry(ha, &list->list, list) {
+		entry = __hw_addr_create(ha->addr, addr_len, ha->type,
+					 false, false);
+		if (!entry) {
+			__hw_addr_flush(snap);
+			return -ENOMEM;
+		}
+		entry->sync_cnt = ha->sync_cnt;
+		entry->refcount = ha->refcount;
+
+		list_add_tail(&entry->list, &snap->list);
+		__hw_addr_insert(snap, entry, addr_len);
+		snap->count++;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_IF_KUNIT(__hw_addr_list_snapshot);
+
+/**
+ *  __hw_addr_list_reconcile - sync snapshot changes back and free snapshots
+ *  @real_list: the real address list to update
+ *  @work: the working snapshot (modified by driver via __hw_addr_sync_dev)
+ *  @ref: the reference snapshot (untouched copy of original state)
+ *  @addr_len: length of addresses
+ *
+ *  Walks the reference snapshot and compares each entry against the work
+ *  snapshot to compute sync_cnt deltas. Applies those deltas to @real_list.
+ *  Frees both snapshots when done.
+ *  Caller must hold netif_addr_lock_bh.
+ */
+void __hw_addr_list_reconcile(struct netdev_hw_addr_list *real_list,
+			      struct netdev_hw_addr_list *work,
+			      struct netdev_hw_addr_list *ref, int addr_len)
+{
+	struct netdev_hw_addr *ref_ha, *tmp, *work_ha, *real_ha;
+	int delta;
+
+	list_for_each_entry_safe(ref_ha, tmp, &ref->list, list) {
+		work_ha = __hw_addr_lookup(work, ref_ha->addr, addr_len,
+					   ref_ha->type);
+		if (work_ha)
+			delta = work_ha->sync_cnt - ref_ha->sync_cnt;
+		else
+			delta = -1;
+
+		if (delta == 0)
+			continue;
+
+		real_ha = __hw_addr_lookup(real_list, ref_ha->addr, addr_len,
+					   ref_ha->type);
+		if (!real_ha) {
+			/* The real entry was concurrently removed. If the
+			 * driver synced this addr to hardware (delta > 0),
+			 * re-insert it as a stale entry so the next work
+			 * run unsyncs it from hardware.
+			 */
+			if (delta > 0) {
+				rb_erase(&ref_ha->node, &ref->tree);
+				list_del(&ref_ha->list);
+				ref->count--;
+				ref_ha->sync_cnt = delta;
+				ref_ha->refcount = delta;
+				list_add_tail_rcu(&ref_ha->list,
+						  &real_list->list);
+				__hw_addr_insert(real_list, ref_ha,
+						 addr_len);
+				real_list->count++;
+			}
+			continue;
+		}
+
+		real_ha->sync_cnt += delta;
+		real_ha->refcount += delta;
+		if (!real_ha->refcount) {
+			rb_erase(&real_ha->node, &real_list->tree);
+			list_del_rcu(&real_ha->list);
+			kfree_rcu(real_ha, rcu_head);
+			real_list->count--;
+		}
+	}
+
+	__hw_addr_flush(work);
+	__hw_addr_flush(ref);
+}
+EXPORT_SYMBOL_IF_KUNIT(__hw_addr_list_reconcile);
+
 /*
  * Device addresses handling functions
  */
diff --git a/net/core/dev_addr_lists_test.c b/net/core/dev_addr_lists_test.c
index 8e1dba825e94..fba926d5ec0d 100644
--- a/net/core/dev_addr_lists_test.c
+++ b/net/core/dev_addr_lists_test.c
@@ -2,22 +2,31 @@
 
 #include <kunit/test.h>
 #include <linux/etherdevice.h>
+#include <linux/math64.h>
 #include <linux/netdevice.h>
 #include <linux/rtnetlink.h>
 
 static const struct net_device_ops dummy_netdev_ops = {
 };
 
+#define ADDR_A	1
+#define ADDR_B	2
+#define ADDR_C	3
+
 struct dev_addr_test_priv {
 	u32 addr_seen;
+	u32 addr_synced;
+	u32 addr_unsynced;
 };
 
 static int dev_addr_test_sync(struct net_device *netdev, const unsigned char *a)
 {
 	struct dev_addr_test_priv *datp = netdev_priv(netdev);
 
-	if (a[0] < 31 && !memchr_inv(a, a[0], ETH_ALEN))
+	if (a[0] < 31 && !memchr_inv(a, a[0], ETH_ALEN)) {
 		datp->addr_seen |= 1 << a[0];
+		datp->addr_synced |= 1 << a[0];
+	}
 	return 0;
 }
 
@@ -26,11 +35,22 @@ static int dev_addr_test_unsync(struct net_device *netdev,
 {
 	struct dev_addr_test_priv *datp = netdev_priv(netdev);
 
-	if (a[0] < 31 && !memchr_inv(a, a[0], ETH_ALEN))
+	if (a[0] < 31 && !memchr_inv(a, a[0], ETH_ALEN)) {
 		datp->addr_seen &= ~(1 << a[0]);
+		datp->addr_unsynced |= 1 << a[0];
+	}
 	return 0;
 }
 
+static void dev_addr_test_reset(struct net_device *netdev)
+{
+	struct dev_addr_test_priv *datp = netdev_priv(netdev);
+
+	datp->addr_seen = 0;
+	datp->addr_synced = 0;
+	datp->addr_unsynced = 0;
+}
+
 static int dev_addr_test_init(struct kunit *test)
 {
 	struct dev_addr_test_priv *datp;
@@ -225,6 +245,339 @@ static void dev_addr_test_add_excl(struct kunit *test)
 	rtnl_unlock();
 }
 
+/* Snapshot test: basic sync with no concurrent modifications.
+ * Add one address, snapshot, driver syncs it, reconcile propagates
+ * sync_cnt delta back to real list.
+ */
+static void dev_addr_test_snapshot_sync(struct kunit *test)
+{
+	struct net_device *netdev = test->priv;
+	struct netdev_hw_addr_list snap, ref;
+	struct dev_addr_test_priv *datp;
+	struct netdev_hw_addr *ha;
+	u8 addr[ETH_ALEN];
+
+	datp = netdev_priv(netdev);
+
+	rtnl_lock();
+
+	memset(addr, ADDR_A, sizeof(addr));
+	KUNIT_EXPECT_EQ(test, 0, dev_uc_add(netdev, addr));
+
+	/* Snapshot: ADDR_A has sync_cnt=0, refcount=1 (new) */
+	netif_addr_lock_bh(netdev);
+	__hw_addr_init(&snap);
+	__hw_addr_init(&ref);
+	KUNIT_EXPECT_EQ(test, 0,
+			__hw_addr_list_snapshot(&snap, &netdev->uc, ETH_ALEN));
+	KUNIT_EXPECT_EQ(test, 0,
+			__hw_addr_list_snapshot(&ref, &netdev->uc, ETH_ALEN));
+	netif_addr_unlock_bh(netdev);
+
+	/* Driver syncs ADDR_A to hardware */
+	dev_addr_test_reset(netdev);
+	__hw_addr_sync_dev(&snap, netdev, dev_addr_test_sync,
+			   dev_addr_test_unsync);
+	KUNIT_EXPECT_EQ(test, 1 << ADDR_A, datp->addr_synced);
+	KUNIT_EXPECT_EQ(test, 0, datp->addr_unsynced);
+
+	/* Reconcile: delta=+1 applied to real entry */
+	netif_addr_lock_bh(netdev);
+	__hw_addr_list_reconcile(&netdev->uc, &snap, &ref, ETH_ALEN);
+	netif_addr_unlock_bh(netdev);
+
+	/* Real entry should now reflect the sync: sync_cnt=1, refcount=2 */
+	KUNIT_EXPECT_EQ(test, 1, netdev->uc.count);
+	ha = list_first_entry(&netdev->uc.list, struct netdev_hw_addr, list);
+	KUNIT_EXPECT_MEMEQ(test, ha->addr, addr, ETH_ALEN);
+	KUNIT_EXPECT_EQ(test, 1, ha->sync_cnt);
+	KUNIT_EXPECT_EQ(test, 2, ha->refcount);
+
+	/* Second work run: already synced, nothing to do */
+	dev_addr_test_reset(netdev);
+	__hw_addr_sync_dev(&netdev->uc, netdev, dev_addr_test_sync,
+			   dev_addr_test_unsync);
+	KUNIT_EXPECT_EQ(test, 0, datp->addr_synced);
+	KUNIT_EXPECT_EQ(test, 0, datp->addr_unsynced);
+	KUNIT_EXPECT_EQ(test, 1, netdev->uc.count);
+
+	rtnl_unlock();
+}
+
+/* Snapshot test: ADDR_A synced to hardware, then concurrently removed
+ * from the real list before reconcile runs. Reconcile re-inserts ADDR_A as
+ * a stale entry so the next work run unsyncs it from hardware.
+ */
+static void dev_addr_test_snapshot_remove_during_sync(struct kunit *test)
+{
+	struct net_device *netdev = test->priv;
+	struct netdev_hw_addr_list snap, ref;
+	struct dev_addr_test_priv *datp;
+	struct netdev_hw_addr *ha;
+	u8 addr[ETH_ALEN];
+
+	datp = netdev_priv(netdev);
+
+	rtnl_lock();
+
+	memset(addr, ADDR_A, sizeof(addr));
+	KUNIT_EXPECT_EQ(test, 0, dev_uc_add(netdev, addr));
+
+	/* Snapshot: ADDR_A is new (sync_cnt=0, refcount=1) */
+	netif_addr_lock_bh(netdev);
+	__hw_addr_init(&snap);
+	__hw_addr_init(&ref);
+	KUNIT_EXPECT_EQ(test, 0,
+			__hw_addr_list_snapshot(&snap, &netdev->uc, ETH_ALEN));
+	KUNIT_EXPECT_EQ(test, 0,
+			__hw_addr_list_snapshot(&ref, &netdev->uc, ETH_ALEN));
+	netif_addr_unlock_bh(netdev);
+
+	/* Driver syncs ADDR_A to hardware */
+	dev_addr_test_reset(netdev);
+	__hw_addr_sync_dev(&snap, netdev, dev_addr_test_sync,
+			   dev_addr_test_unsync);
+	KUNIT_EXPECT_EQ(test, 1 << ADDR_A, datp->addr_synced);
+	KUNIT_EXPECT_EQ(test, 0, datp->addr_unsynced);
+
+	/* Concurrent removal: user deletes ADDR_A while driver was working */
+	memset(addr, ADDR_A, sizeof(addr));
+	KUNIT_EXPECT_EQ(test, 0, dev_uc_del(netdev, addr));
+	KUNIT_EXPECT_EQ(test, 0, netdev->uc.count);
+
+	/* Reconcile: ADDR_A gone from real list but driver synced it,
+	 * so it gets re-inserted as stale (sync_cnt=1, refcount=1).
+	 */
+	netif_addr_lock_bh(netdev);
+	__hw_addr_list_reconcile(&netdev->uc, &snap, &ref, ETH_ALEN);
+	netif_addr_unlock_bh(netdev);
+
+	KUNIT_EXPECT_EQ(test, 1, netdev->uc.count);
+	ha = list_first_entry(&netdev->uc.list, struct netdev_hw_addr, list);
+	KUNIT_EXPECT_MEMEQ(test, ha->addr, addr, ETH_ALEN);
+	KUNIT_EXPECT_EQ(test, 1, ha->sync_cnt);
+	KUNIT_EXPECT_EQ(test, 1, ha->refcount);
+
+	/* Second work run: stale entry gets unsynced from HW and removed */
+	dev_addr_test_reset(netdev);
+	__hw_addr_sync_dev(&netdev->uc, netdev, dev_addr_test_sync,
+			   dev_addr_test_unsync);
+	KUNIT_EXPECT_EQ(test, 0, datp->addr_synced);
+	KUNIT_EXPECT_EQ(test, 1 << ADDR_A, datp->addr_unsynced);
+	KUNIT_EXPECT_EQ(test, 0, netdev->uc.count);
+
+	rtnl_unlock();
+}
+
+/* Snapshot test: ADDR_A was stale (unsynced from hardware by driver),
+ * but concurrently re-added by the user. The re-add bumps refcount of
+ * the existing stale entry. Reconcile applies delta=-1, leaving ADDR_A
+ * as a fresh entry (sync_cnt=0, refcount=1) for the next work run.
+ */
+static void dev_addr_test_snapshot_readd_during_unsync(struct kunit *test)
+{
+	struct net_device *netdev = test->priv;
+	struct netdev_hw_addr_list snap, ref;
+	struct dev_addr_test_priv *datp;
+	struct netdev_hw_addr *ha;
+	u8 addr[ETH_ALEN];
+
+	datp = netdev_priv(netdev);
+
+	rtnl_lock();
+
+	memset(addr, ADDR_A, sizeof(addr));
+	KUNIT_EXPECT_EQ(test, 0, dev_uc_add(netdev, addr));
+
+	/* Sync ADDR_A to hardware: sync_cnt=1, refcount=2 */
+	dev_addr_test_reset(netdev);
+	__hw_addr_sync_dev(&netdev->uc, netdev, dev_addr_test_sync,
+			   dev_addr_test_unsync);
+	KUNIT_EXPECT_EQ(test, 1 << ADDR_A, datp->addr_synced);
+	KUNIT_EXPECT_EQ(test, 0, datp->addr_unsynced);
+
+	/* User removes ADDR_A: refcount=1, sync_cnt=1 -> stale */
+	KUNIT_EXPECT_EQ(test, 0, dev_uc_del(netdev, addr));
+
+	/* Snapshot: ADDR_A is stale (sync_cnt=1, refcount=1) */
+	netif_addr_lock_bh(netdev);
+	__hw_addr_init(&snap);
+	__hw_addr_init(&ref);
+	KUNIT_EXPECT_EQ(test, 0,
+			__hw_addr_list_snapshot(&snap, &netdev->uc, ETH_ALEN));
+	KUNIT_EXPECT_EQ(test, 0,
+			__hw_addr_list_snapshot(&ref, &netdev->uc, ETH_ALEN));
+	netif_addr_unlock_bh(netdev);
+
+	/* Driver unsyncs stale ADDR_A from hardware */
+	dev_addr_test_reset(netdev);
+	__hw_addr_sync_dev(&snap, netdev, dev_addr_test_sync,
+			   dev_addr_test_unsync);
+	KUNIT_EXPECT_EQ(test, 0, datp->addr_synced);
+	KUNIT_EXPECT_EQ(test, 1 << ADDR_A, datp->addr_unsynced);
+
+	/* Concurrent: user re-adds ADDR_A.  dev_uc_add finds the existing
+	 * stale entry and bumps refcount from 1 -> 2.  sync_cnt stays 1.
+	 */
+	KUNIT_EXPECT_EQ(test, 0, dev_uc_add(netdev, addr));
+	KUNIT_EXPECT_EQ(test, 1, netdev->uc.count);
+
+	/* Reconcile: ref sync_cnt=1 matches real sync_cnt=1, delta=-1
+	 * applied. Result: sync_cnt=0, refcount=1 (fresh).
+	 */
+	netif_addr_lock_bh(netdev);
+	__hw_addr_list_reconcile(&netdev->uc, &snap, &ref, ETH_ALEN);
+	netif_addr_unlock_bh(netdev);
+
+	/* Entry survives as fresh: needs re-sync to HW */
+	KUNIT_EXPECT_EQ(test, 1, netdev->uc.count);
+	ha = list_first_entry(&netdev->uc.list, struct netdev_hw_addr, list);
+	KUNIT_EXPECT_MEMEQ(test, ha->addr, addr, ETH_ALEN);
+	KUNIT_EXPECT_EQ(test, 0, ha->sync_cnt);
+	KUNIT_EXPECT_EQ(test, 1, ha->refcount);
+
+	/* Second work run: fresh entry gets synced to HW */
+	dev_addr_test_reset(netdev);
+	__hw_addr_sync_dev(&netdev->uc, netdev, dev_addr_test_sync,
+			   dev_addr_test_unsync);
+	KUNIT_EXPECT_EQ(test, 1 << ADDR_A, datp->addr_synced);
+	KUNIT_EXPECT_EQ(test, 0, datp->addr_unsynced);
+
+	rtnl_unlock();
+}
+
+/* Snapshot test: ADDR_A is new (synced by driver), and independent ADDR_B
+ * is concurrently removed from the real list. A's sync delta propagates
+ * normally; B's absence doesn't interfere.
+ */
+static void dev_addr_test_snapshot_add_and_remove(struct kunit *test)
+{
+	struct net_device *netdev = test->priv;
+	struct netdev_hw_addr_list snap, ref;
+	struct dev_addr_test_priv *datp;
+	struct netdev_hw_addr *ha;
+	u8 addr[ETH_ALEN];
+
+	datp = netdev_priv(netdev);
+
+	rtnl_lock();
+
+	/* Add ADDR_A and ADDR_B (will be synced then removed) */
+	memset(addr, ADDR_A, sizeof(addr));
+	KUNIT_EXPECT_EQ(test, 0, dev_uc_add(netdev, addr));
+	memset(addr, ADDR_B, sizeof(addr));
+	KUNIT_EXPECT_EQ(test, 0, dev_uc_add(netdev, addr));
+
+	/* Sync both to hardware: sync_cnt=1, refcount=2 */
+	__hw_addr_sync_dev(&netdev->uc, netdev, dev_addr_test_sync,
+			   dev_addr_test_unsync);
+
+	/* Add ADDR_C (new, will be synced by snapshot) */
+	memset(addr, ADDR_C, sizeof(addr));
+	KUNIT_EXPECT_EQ(test, 0, dev_uc_add(netdev, addr));
+
+	/* Snapshot: A,B synced (sync_cnt=1,refcount=2); C new (0,1) */
+	netif_addr_lock_bh(netdev);
+	__hw_addr_init(&snap);
+	__hw_addr_init(&ref);
+	KUNIT_EXPECT_EQ(test, 0,
+			__hw_addr_list_snapshot(&snap, &netdev->uc, ETH_ALEN));
+	KUNIT_EXPECT_EQ(test, 0,
+			__hw_addr_list_snapshot(&ref, &netdev->uc, ETH_ALEN));
+	netif_addr_unlock_bh(netdev);
+
+	/* Driver syncs snapshot: ADDR_C is new -> synced; A,B already synced */
+	dev_addr_test_reset(netdev);
+	__hw_addr_sync_dev(&snap, netdev, dev_addr_test_sync,
+			   dev_addr_test_unsync);
+	KUNIT_EXPECT_EQ(test, 1 << ADDR_C, datp->addr_synced);
+	KUNIT_EXPECT_EQ(test, 0, datp->addr_unsynced);
+
+	/* Concurrent: user removes addr B while driver was working */
+	memset(addr, ADDR_B, sizeof(addr));
+	KUNIT_EXPECT_EQ(test, 0, dev_uc_del(netdev, addr));
+
+	/* Reconcile: ADDR_C's delta=+1 applied to real list.
+	 * ADDR_B's delta=0 (unchanged in snapshot),
+	 * so nothing to apply to ADDR_B.
+	 */
+	netif_addr_lock_bh(netdev);
+	__hw_addr_list_reconcile(&netdev->uc, &snap, &ref, ETH_ALEN);
+	netif_addr_unlock_bh(netdev);
+
+	/* ADDR_A: unchanged (sync_cnt=1, refcount=2)
+	 * ADDR_B: refcount went from 2->1 via dev_uc_del (still present, stale)
+	 * ADDR_C: sync propagated (sync_cnt=1, refcount=2)
+	 */
+	KUNIT_EXPECT_EQ(test, 3, netdev->uc.count);
+	netdev_hw_addr_list_for_each(ha, &netdev->uc) {
+		u8 id = ha->addr[0];
+
+		if (!memchr_inv(ha->addr, id, ETH_ALEN)) {
+			if (id == ADDR_A) {
+				KUNIT_EXPECT_EQ(test, 1, ha->sync_cnt);
+				KUNIT_EXPECT_EQ(test, 2, ha->refcount);
+			} else if (id == ADDR_B) {
+				/* B: still present but now stale */
+				KUNIT_EXPECT_EQ(test, 1, ha->sync_cnt);
+				KUNIT_EXPECT_EQ(test, 1, ha->refcount);
+			} else if (id == ADDR_C) {
+				KUNIT_EXPECT_EQ(test, 1, ha->sync_cnt);
+				KUNIT_EXPECT_EQ(test, 2, ha->refcount);
+			}
+		}
+	}
+
+	/* Second work run: ADDR_B is stale, gets unsynced and removed */
+	dev_addr_test_reset(netdev);
+	__hw_addr_sync_dev(&netdev->uc, netdev, dev_addr_test_sync,
+			   dev_addr_test_unsync);
+	KUNIT_EXPECT_EQ(test, 0, datp->addr_synced);
+	KUNIT_EXPECT_EQ(test, 1 << ADDR_B, datp->addr_unsynced);
+	KUNIT_EXPECT_EQ(test, 2, netdev->uc.count);
+
+	rtnl_unlock();
+}
+
+static void dev_addr_test_snapshot_benchmark(struct kunit *test)
+{
+	struct net_device *netdev = test->priv;
+	struct netdev_hw_addr_list snap;
+	u8 addr[ETH_ALEN];
+	s64 duration = 0;
+	ktime_t start;
+	int i, iter;
+
+	rtnl_lock();
+
+	for (i = 0; i < 1024; i++) {
+		memset(addr, 0, sizeof(addr));
+		addr[0] = (i >> 8) & 0xff;
+		addr[1] = i & 0xff;
+		KUNIT_EXPECT_EQ(test, 0, dev_uc_add(netdev, addr));
+	}
+
+	for (iter = 0; iter < 1000; iter++) {
+		netif_addr_lock_bh(netdev);
+		__hw_addr_init(&snap);
+
+		start = ktime_get();
+		KUNIT_EXPECT_EQ(test, 0,
+				__hw_addr_list_snapshot(&snap, &netdev->uc,
+							ETH_ALEN));
+		duration += ktime_to_ns(ktime_sub(ktime_get(), start));
+
+		netif_addr_unlock_bh(netdev);
+		__hw_addr_flush(&snap);
+	}
+
+	kunit_info(test,
+		   "1024 addrs x 1000 snapshots: %lld ns total, %lld ns/iter",
+		   duration, div_s64(duration, 1000));
+
+	rtnl_unlock();
+}
+
 static struct kunit_case dev_addr_test_cases[] = {
 	KUNIT_CASE(dev_addr_test_basic),
 	KUNIT_CASE(dev_addr_test_sync_one),
@@ -232,6 +585,11 @@ static struct kunit_case dev_addr_test_cases[] = {
 	KUNIT_CASE(dev_addr_test_del_main),
 	KUNIT_CASE(dev_addr_test_add_set),
 	KUNIT_CASE(dev_addr_test_add_excl),
+	KUNIT_CASE(dev_addr_test_snapshot_sync),
+	KUNIT_CASE(dev_addr_test_snapshot_remove_during_sync),
+	KUNIT_CASE(dev_addr_test_snapshot_readd_during_unsync),
+	KUNIT_CASE(dev_addr_test_snapshot_add_and_remove),
+	KUNIT_CASE_SLOW(dev_addr_test_snapshot_benchmark),
 	{}
 };
 
@@ -243,5 +601,6 @@ static struct kunit_suite dev_addr_test_suite = {
 };
 kunit_test_suite(dev_addr_test_suite);
 
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
 MODULE_DESCRIPTION("KUnit tests for struct netdev_hw_addr_list");
 MODULE_LICENSE("GPL");
-- 
2.52.0


