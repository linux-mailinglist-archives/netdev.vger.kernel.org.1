Return-Path: <netdev+bounces-155264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BECBA0191F
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 12:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACEBF3A31F4
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 11:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1896A149E16;
	Sun,  5 Jan 2025 11:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCmW38yn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AE4149C4D;
	Sun,  5 Jan 2025 11:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736074895; cv=none; b=W3IE6J3ZqEgL97zguGe2sARjGz3zAl9Y3ZUfdUOpiga1FeJ0pLCf8VarbwTPMrO5J8jnrluWdV59gDuj1vXn5APk2GffBVF2CabGfxQo8rT0xRN9o+FcxDFBlObwttXHTrpdJi+cqLHRy7rIc/Mq6U3YqTGIiwcxTcGQWkxMQ8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736074895; c=relaxed/simple;
	bh=mUEw0ExtY6Bglq6Fa3hZJoEilDIbjuM6czlSQ+ZFcPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oLMEmnq8+OMiPaSc9/7p3GC9B4VO33SZZUxR80SEBVSE8Sn6tYUebG2oPecAYlERYhjgp7kmObZOxO4L0uyhr4vyslL/cwp9gZxflbsMB+s9VOIc8mtB3/1SP5s1g0EW8+cgHJsiXkbD8k0MEUZQCc3clNXbgFzY6i1WahxKFrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lCmW38yn; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5401bd6cdb4so13480551e87.2;
        Sun, 05 Jan 2025 03:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736074889; x=1736679689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QtU7nSZEmG7drXgH/Jpmu2wPwJvHEWlPXPsUjRIcY9c=;
        b=lCmW38ynAcjlJh/Nh6DXOmwLXv1P2olbUeQXAYB3W4MdahYwTDuAtMCpiKwiauEBxa
         7LYVsCtwp1IZfgl5jYTRj9ZpLoFtoT/aIcmmYT6noXp4+fr9WbNrRvh1fbp2LEfyT6+N
         HihSI+ssnm5w/aobSLrNJ0jxSLt1sCjlhCZZl0YL2AiJ4sQE5Rqze0swxxjfXsjJatP9
         Qmhtn9iP0dMNZBMUUyjJehaQc6aqBAFX+P18/cwdAlNry1fCD6e99sQEjRqBluNDTGxY
         KqlZLzjTfM+YYv1ri+/e+aATMc4abkJw2+tGqwksyPa7zWehfLEymAaHLE7zvYQKJXwG
         RSUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736074889; x=1736679689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QtU7nSZEmG7drXgH/Jpmu2wPwJvHEWlPXPsUjRIcY9c=;
        b=Wr57PrSYSoLpmUzV9iQcjHx0y9iX+imsnZAIt6SX5yqEkANnYsW3tIF53t1EOBXjNU
         1GQdRKEjEH5d5WfWi0I831tFOa72shIrRBoYM/PmNOOCIhGeX0dGypZPc2mq9BNm4vmB
         e8AgS33YqpXgbsYW9EymFKfdG+31x2kFyme8n39BwsTgsANTLy/QJLJbXC62bps4k5JC
         6CES46boIxGf8UmJKfb31+7A95VUhlcZ2fZyHk4N7KaEDZ7EP3vV2+cxJdhqCyiBdeGK
         N6gdH6UbiRZJroq6SlNXy0qqqApJpKzweCjMXsAffvQbMcS8hmZVsdcYxwbx1eACjQgz
         EX2A==
X-Forwarded-Encrypted: i=1; AJvYcCWTnWFQa8ewz3sfwpdkzETjQMEoCcd88YrgiLDpnxWsD51OVcavg24aneGXJKK6rvTPvuIeWiAD@vger.kernel.org, AJvYcCWfBj37mtHV3aNEF8IOc11J5a1BCW7XnRwbbuYGL9CFpM+GvT4jr9Dz0vLp33pTnC7ts6UkLZBVWPPgyWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEGv1YptgRIOejCZMHgSNOxTxIS2lkhWVC7aVx1C+hruBNAkOt
	lQ/CZmIaT1uJRSctZRJrTpFoovNDTgn/vvWPldCypMkO4UXSZfwb
X-Gm-Gg: ASbGncuOZGZ8qj36voThy/1EDT1J/eAFhCpe2Dt7GBepZmUqbfmSWhbQWRrNPPa1My4
	aRRQM3SvS3Xjw25iOFSyyv7gzlnD34rPOnMZCgrZK8GuGNglXYCmq26xxKi2QV2qgma8PGfC+9L
	6QLU+gmOEwpRj3Hz/Lk4JtfjTyO3fZJ+h28pjvzAe9VbnPu9IFmh7ClJjFGhkTQn0SfLeOWoAxP
	XMT7EQYVddp1wNEJTFALWIY3qyUQlf9ZZFbBFO5ThMSrQ==
X-Google-Smtp-Source: AGHT+IEtX2gAoY5iKEx3mfVlhceK2Cu1wGZUCOnE50x1tXX3BxyANKRmZ8vk1MNgiZJX0vmhaLmfRQ==
X-Received: by 2002:a05:6512:33c9:b0:542:21f5:b9cd with SMTP id 2adb3069b0e04-54229532fe5mr17609595e87.17.1736074889148;
        Sun, 05 Jan 2025 03:01:29 -0800 (PST)
Received: from laptop.dev.lan ([2001:2040:c00f:15c::4159])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-542235f6073sm4690817e87.27.2025.01.05.03.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2025 03:01:27 -0800 (PST)
From: Dmitrii Ermakov <demonihin@gmail.com>
To: Jason@zx2c4.com
Cc: wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitrii Ermakov <demonihin@gmail.com>
Subject: [PATCH net-next] wireguard: use rhashtables instead of hashtables
Date: Sun,  5 Jan 2025 12:00:17 +0100
Message-ID: <20250105110036.70720-2-demonihin@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace hashtable of static length (8192) with dynamic rhashtable

Signed-off-by: Dmitrii Ermakov <demonihin@gmail.com>
---
 drivers/net/wireguard/device.c     |   4 +
 drivers/net/wireguard/noise.h      |   4 +-
 drivers/net/wireguard/peer.h       |   4 +-
 drivers/net/wireguard/peerlookup.c | 195 ++++++++++++++++++-----------
 drivers/net/wireguard/peerlookup.h |  10 +-
 5 files changed, 138 insertions(+), 79 deletions(-)

diff --git a/drivers/net/wireguard/device.c b/drivers/net/wireguard/device.c
index 6cf173a008e7..2068039667dd 100644
--- a/drivers/net/wireguard/device.c
+++ b/drivers/net/wireguard/device.c
@@ -3,6 +3,8 @@
  * Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
  */
 
+#include "linux/rhashtable-types.h"
+#include "linux/rhashtable.h"
 #include "queueing.h"
 #include "socket.h"
 #include "timers.h"
@@ -261,6 +263,8 @@ static void wg_destruct(struct net_device *dev)
 	rcu_barrier(); /* Wait for all the peers to be actually freed. */
 	wg_ratelimiter_uninit();
 	memzero_explicit(&wg->static_identity, sizeof(wg->static_identity));
+	rhashtable_destroy(&wg->index_hashtable->rhashtable);
+	rhashtable_destroy(&wg->peer_hashtable->rhashtable);
 	kvfree(wg->index_hashtable);
 	kvfree(wg->peer_hashtable);
 	mutex_unlock(&wg->device_update_lock);
diff --git a/drivers/net/wireguard/noise.h b/drivers/net/wireguard/noise.h
index c527253dba80..216abc956c32 100644
--- a/drivers/net/wireguard/noise.h
+++ b/drivers/net/wireguard/noise.h
@@ -5,6 +5,7 @@
 #ifndef _WG_NOISE_H
 #define _WG_NOISE_H
 
+#include "linux/siphash.h"
 #include "messages.h"
 #include "peerlookup.h"
 
@@ -74,7 +75,6 @@ struct noise_handshake {
 	u8 remote_static[NOISE_PUBLIC_KEY_LEN];
 	u8 remote_ephemeral[NOISE_PUBLIC_KEY_LEN];
 	u8 precomputed_static_static[NOISE_PUBLIC_KEY_LEN];
-
 	u8 preshared_key[NOISE_SYMMETRIC_KEY_LEN];
 
 	u8 hash[NOISE_HASH_LEN];
@@ -83,6 +83,8 @@ struct noise_handshake {
 	u8 latest_timestamp[NOISE_TIMESTAMP_LEN];
 	__le32 remote_index;
 
+	siphash_key_t hash_seed;
+
 	/* Protects all members except the immutable (after noise_handshake_
 	 * init): remote_static, precomputed_static_static, static_identity.
 	 */
diff --git a/drivers/net/wireguard/peer.h b/drivers/net/wireguard/peer.h
index 76e4d3128ad4..06250679822b 100644
--- a/drivers/net/wireguard/peer.h
+++ b/drivers/net/wireguard/peer.h
@@ -7,6 +7,7 @@
 #define _WG_PEER_H
 
 #include "device.h"
+#include "linux/siphash.h"
 #include "noise.h"
 #include "cookie.h"
 
@@ -15,6 +16,7 @@
 #include <linux/spinlock.h>
 #include <linux/kref.h>
 #include <net/dst_cache.h>
+#include <linux/rhashtable.h>
 
 struct wg_device;
 
@@ -48,7 +50,7 @@ struct wg_peer {
 	atomic64_t last_sent_handshake;
 	struct work_struct transmit_handshake_work, clear_peer_work, transmit_packet_work;
 	struct cookie latest_cookie;
-	struct hlist_node pubkey_hash;
+	struct rhash_head pubkey_hash;
 	u64 rx_bytes, tx_bytes;
 	struct timer_list timer_retransmit_handshake, timer_send_keepalive;
 	struct timer_list timer_new_handshake, timer_zero_key_material;
diff --git a/drivers/net/wireguard/peerlookup.c b/drivers/net/wireguard/peerlookup.c
index f2783aa7a88f..3912bf30ec98 100644
--- a/drivers/net/wireguard/peerlookup.c
+++ b/drivers/net/wireguard/peerlookup.c
@@ -4,30 +4,90 @@
  */
 
 #include "peerlookup.h"
+#include "linux/printk.h"
+#include "linux/rcupdate.h"
+#include "linux/rhashtable-types.h"
+#include "linux/rhashtable.h"
+#include "linux/siphash.h"
+#include "messages.h"
 #include "peer.h"
 #include "noise.h"
+#include "linux/memory.h"
 
-static struct hlist_head *pubkey_bucket(struct pubkey_hashtable *table,
-					const u8 pubkey[NOISE_PUBLIC_KEY_LEN])
+static inline u32 index_hashfn(const void *data, u32 len, u32 seed)
 {
-	/* siphash gives us a secure 64bit number based on a random key. Since
-	 * the bits are uniformly distributed, we can then mask off to get the
-	 * bits we need.
-	 */
-	const u64 hash = siphash(pubkey, NOISE_PUBLIC_KEY_LEN, &table->key);
+	const u32 *index = data;
+	return *index;
+}
+
+static const struct rhashtable_params index_ht_params = {
+	.head_offset = offsetof(struct index_hashtable_entry, index_hash),
+	.key_offset = offsetof(struct index_hashtable_entry, index),
+	.hashfn = index_hashfn,
+	.key_len = sizeof(__le32),
+	.automatic_shrinking = true,
+};
+
+struct peer_hash_pubkey {
+	siphash_key_t key;
+	u8 pubkey[NOISE_PUBLIC_KEY_LEN];
+};
+
+static inline u32 wg_peer_obj_hashfn(const void *data, u32 len, u32 seed)
+{
+	const struct wg_peer *peer = data;
+	struct peer_hash_pubkey key;
+	u64 hash;
+
+	memcpy(&key.key, &peer->handshake.hash_seed, sizeof(key.key));
+	memcpy(&key.pubkey, &peer->handshake.remote_static, NOISE_PUBLIC_KEY_LEN);
+
+	hash = siphash(&key.pubkey, NOISE_PUBLIC_KEY_LEN, &key.key);
 
-	return &table->hashtable[hash & (HASH_SIZE(table->hashtable) - 1)];
+	return (u32)hash;
 }
 
+static inline u32 wg_peer_hashfn(const void *data, u32 len, u32 seed)
+{
+	const struct peer_hash_pubkey *key = data;
+	u64 hash = siphash(&key->pubkey, NOISE_PUBLIC_KEY_LEN, &key->key);
+
+	return (u32)hash;
+}
+
+static inline int wg_peer_cmpfn(struct rhashtable_compare_arg *arg,
+				const void *obj)
+{
+	const struct peer_hash_pubkey *key = arg->key;
+	const struct wg_peer *peer = obj;
+
+	return memcmp(key->pubkey, &peer->handshake.remote_static,
+		      NOISE_PUBLIC_KEY_LEN);
+}
+
+static const struct rhashtable_params pubkey_ht_params = {
+	.head_offset = offsetof(struct wg_peer, pubkey_hash),
+	.key_offset = offsetof(struct wg_peer, handshake.remote_static),
+	.obj_cmpfn = wg_peer_cmpfn,
+	.obj_hashfn = wg_peer_obj_hashfn,
+	.hashfn = wg_peer_hashfn,
+	.automatic_shrinking = true,
+};
+
 struct pubkey_hashtable *wg_pubkey_hashtable_alloc(void)
 {
-	struct pubkey_hashtable *table = kvmalloc(sizeof(*table), GFP_KERNEL);
+	int ret;
 
+	struct pubkey_hashtable *table = kvmalloc(sizeof(*table), GFP_KERNEL);
 	if (!table)
 		return NULL;
 
 	get_random_bytes(&table->key, sizeof(table->key));
-	hash_init(table->hashtable);
+	ret = rhashtable_init(&table->rhashtable, &pubkey_ht_params);
+	if (ret) {
+		kvfree(table);
+		return NULL;
+	}
 	mutex_init(&table->lock);
 	return table;
 }
@@ -35,9 +95,16 @@ struct pubkey_hashtable *wg_pubkey_hashtable_alloc(void)
 void wg_pubkey_hashtable_add(struct pubkey_hashtable *table,
 			     struct wg_peer *peer)
 {
+	struct peer_hash_pubkey key;
+
 	mutex_lock(&table->lock);
-	hlist_add_head_rcu(&peer->pubkey_hash,
-			   pubkey_bucket(table, peer->handshake.remote_static));
+	memcpy(&peer->handshake.hash_seed, &table->key,
+	       sizeof(peer->handshake.hash_seed));
+	memcpy(&key.key, &peer->handshake.hash_seed, sizeof(key.key));
+	memcpy(&key.pubkey, peer->handshake.remote_static, NOISE_PUBLIC_KEY_LEN);
+
+	rhashtable_lookup_insert_key(&table->rhashtable, &key,
+				     &peer->pubkey_hash, pubkey_ht_params);
 	mutex_unlock(&table->lock);
 }
 
@@ -45,7 +112,8 @@ void wg_pubkey_hashtable_remove(struct pubkey_hashtable *table,
 				struct wg_peer *peer)
 {
 	mutex_lock(&table->lock);
-	hlist_del_init_rcu(&peer->pubkey_hash);
+	rhashtable_remove_fast(&table->rhashtable, &peer->pubkey_hash,
+			       pubkey_ht_params);
 	mutex_unlock(&table->lock);
 }
 
@@ -54,30 +122,18 @@ struct wg_peer *
 wg_pubkey_hashtable_lookup(struct pubkey_hashtable *table,
 			   const u8 pubkey[NOISE_PUBLIC_KEY_LEN])
 {
-	struct wg_peer *iter_peer, *peer = NULL;
+	struct wg_peer *peer = NULL;
+	struct peer_hash_pubkey key;
 
 	rcu_read_lock_bh();
-	hlist_for_each_entry_rcu_bh(iter_peer, pubkey_bucket(table, pubkey),
-				    pubkey_hash) {
-		if (!memcmp(pubkey, iter_peer->handshake.remote_static,
-			    NOISE_PUBLIC_KEY_LEN)) {
-			peer = iter_peer;
-			break;
-		}
-	}
+	memcpy(&key.key, &table->key, sizeof(key.key));
+	memcpy(&key.pubkey, pubkey, NOISE_PUBLIC_KEY_LEN);
+	peer = rhashtable_lookup_fast(&table->rhashtable, &key,
+				      pubkey_ht_params);
 	peer = wg_peer_get_maybe_zero(peer);
 	rcu_read_unlock_bh();
-	return peer;
-}
 
-static struct hlist_head *index_bucket(struct index_hashtable *table,
-				       const __le32 index)
-{
-	/* Since the indices are random and thus all bits are uniformly
-	 * distributed, we can find its bucket simply by masking.
-	 */
-	return &table->hashtable[(__force u32)index &
-				 (HASH_SIZE(table->hashtable) - 1)];
+	return peer;
 }
 
 struct index_hashtable *wg_index_hashtable_alloc(void)
@@ -87,7 +143,11 @@ struct index_hashtable *wg_index_hashtable_alloc(void)
 	if (!table)
 		return NULL;
 
-	hash_init(table->hashtable);
+	if (rhashtable_init(&table->rhashtable, &index_ht_params)) {
+		kvfree(table);
+		return NULL;
+	}
+
 	spin_lock_init(&table->lock);
 	return table;
 }
@@ -119,45 +179,42 @@ struct index_hashtable *wg_index_hashtable_alloc(void)
 __le32 wg_index_hashtable_insert(struct index_hashtable *table,
 				 struct index_hashtable_entry *entry)
 {
-	struct index_hashtable_entry *existing_entry;
-
 	spin_lock_bh(&table->lock);
-	hlist_del_init_rcu(&entry->index_hash);
+	rhashtable_remove_fast(&table->rhashtable, &entry->index_hash,
+			       index_ht_params);
 	spin_unlock_bh(&table->lock);
 
 	rcu_read_lock_bh();
+	rcu_read_lock();
 
 search_unused_slot:
 	/* First we try to find an unused slot, randomly, while unlocked. */
 	entry->index = (__force __le32)get_random_u32();
-	hlist_for_each_entry_rcu_bh(existing_entry,
-				    index_bucket(table, entry->index),
-				    index_hash) {
-		if (existing_entry->index == entry->index)
-			/* If it's already in use, we continue searching. */
-			goto search_unused_slot;
+	if (rhashtable_lookup(&table->rhashtable, &entry->index,
+			      index_ht_params)) {
+		/* If it's already in use, we continue searching. */
+		goto search_unused_slot;
 	}
 
 	/* Once we've found an unused slot, we lock it, and then double-check
 	 * that nobody else stole it from us.
 	 */
 	spin_lock_bh(&table->lock);
-	hlist_for_each_entry_rcu_bh(existing_entry,
-				    index_bucket(table, entry->index),
-				    index_hash) {
-		if (existing_entry->index == entry->index) {
-			spin_unlock_bh(&table->lock);
-			/* If it was stolen, we start over. */
-			goto search_unused_slot;
-		}
+	if (rhashtable_lookup(&table->rhashtable, &entry->index,
+			      index_ht_params)) {
+		spin_unlock_bh(&table->lock);
+		/* If it was stolen, we start over. */
+		goto search_unused_slot;
 	}
+
 	/* Otherwise, we know we have it exclusively (since we're locked),
 	 * so we insert.
 	 */
-	hlist_add_head_rcu(&entry->index_hash,
-			   index_bucket(table, entry->index));
+	rhashtable_insert_fast(&table->rhashtable, &entry->index_hash,
+			       index_ht_params);
 	spin_unlock_bh(&table->lock);
 
+	rcu_read_unlock();
 	rcu_read_unlock_bh();
 
 	return entry->index;
@@ -170,20 +227,15 @@ bool wg_index_hashtable_replace(struct index_hashtable *table,
 	bool ret;
 
 	spin_lock_bh(&table->lock);
-	ret = !hlist_unhashed(&old->index_hash);
+	ret = rhashtable_lookup_fast(&table->rhashtable, &old->index,
+				     index_ht_params);
 	if (unlikely(!ret))
 		goto out;
 
 	new->index = old->index;
-	hlist_replace_rcu(&old->index_hash, &new->index_hash);
+	rhashtable_replace_fast(&table->rhashtable, &old->index_hash,
+				&new->index_hash, index_ht_params);
 
-	/* Calling init here NULLs out index_hash, and in fact after this
-	 * function returns, it's theoretically possible for this to get
-	 * reinserted elsewhere. That means the RCU lookup below might either
-	 * terminate early or jump between buckets, in which case the packet
-	 * simply gets dropped, which isn't terrible.
-	 */
-	INIT_HLIST_NODE(&old->index_hash);
 out:
 	spin_unlock_bh(&table->lock);
 	return ret;
@@ -193,7 +245,8 @@ void wg_index_hashtable_remove(struct index_hashtable *table,
 			       struct index_hashtable_entry *entry)
 {
 	spin_lock_bh(&table->lock);
-	hlist_del_init_rcu(&entry->index_hash);
+	rhashtable_remove_fast(&table->rhashtable, &entry->index_hash,
+			       index_ht_params);
 	spin_unlock_bh(&table->lock);
 }
 
@@ -203,24 +256,24 @@ wg_index_hashtable_lookup(struct index_hashtable *table,
 			  const enum index_hashtable_type type_mask,
 			  const __le32 index, struct wg_peer **peer)
 {
-	struct index_hashtable_entry *iter_entry, *entry = NULL;
+	struct index_hashtable_entry *entry = NULL;
 
 	rcu_read_lock_bh();
-	hlist_for_each_entry_rcu_bh(iter_entry, index_bucket(table, index),
-				    index_hash) {
-		if (iter_entry->index == index) {
-			if (likely(iter_entry->type & type_mask))
-				entry = iter_entry;
-			break;
-		}
+	entry = rhashtable_lookup_fast(&table->rhashtable, &index, index_ht_params);
+
+	if (unlikely(!entry)) {
+		rcu_read_unlock_bh();
+		return entry;
 	}
-	if (likely(entry)) {
+
+	if (likely(entry && (entry->type & type_mask))) {
 		entry->peer = wg_peer_get_maybe_zero(entry->peer);
 		if (likely(entry->peer))
 			*peer = entry->peer;
 		else
 			entry = NULL;
 	}
+
 	rcu_read_unlock_bh();
 	return entry;
 }
diff --git a/drivers/net/wireguard/peerlookup.h b/drivers/net/wireguard/peerlookup.h
index ced811797680..edc6acc21d79 100644
--- a/drivers/net/wireguard/peerlookup.h
+++ b/drivers/net/wireguard/peerlookup.h
@@ -8,15 +8,14 @@
 
 #include "messages.h"
 
-#include <linux/hashtable.h>
 #include <linux/mutex.h>
 #include <linux/siphash.h>
+#include <linux/rhashtable.h>
 
 struct wg_peer;
 
 struct pubkey_hashtable {
-	/* TODO: move to rhashtable */
-	DECLARE_HASHTABLE(hashtable, 11);
+	struct rhashtable rhashtable;
 	siphash_key_t key;
 	struct mutex lock;
 };
@@ -31,8 +30,7 @@ wg_pubkey_hashtable_lookup(struct pubkey_hashtable *table,
 			   const u8 pubkey[NOISE_PUBLIC_KEY_LEN]);
 
 struct index_hashtable {
-	/* TODO: move to rhashtable */
-	DECLARE_HASHTABLE(hashtable, 13);
+	struct rhashtable rhashtable;
 	spinlock_t lock;
 };
 
@@ -43,7 +41,7 @@ enum index_hashtable_type {
 
 struct index_hashtable_entry {
 	struct wg_peer *peer;
-	struct hlist_node index_hash;
+	struct rhash_head index_hash;
 	enum index_hashtable_type type;
 	__le32 index;
 };
-- 
2.45.2


