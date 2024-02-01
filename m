Return-Path: <netdev+bounces-68082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A89B5845C8D
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 17:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBB731C2CC9C
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 16:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21D1626BD;
	Thu,  1 Feb 2024 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="bxMzRBQk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96214626AB
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 16:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706803858; cv=none; b=VL4lpl4C1q2lC2/37admsynWknbNd+Xlc4p0tznlDFy++Gj/hJhVU8xEB41JDNqeLAI1IGpCbEwhEsxSVTAw+qgvPn57iv1QXg7jjwUi9b+ru+TYJ8lGGMqaYEBIla22GAHcmpJbmw+qJ5JnpzAlNKMrTnl7uU08HpZUgSMxGUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706803858; c=relaxed/simple;
	bh=7cgT8swYUHF5iJkB8D8jTLHsvEi1ThHpXgJDwGV1tMg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aeVO+iCsWTciTHt5T8ILKFrAE8UbjHCMxocZ107x84G/x0Bc2R5vHTHGpVU7NPvWnAwIOpn7Cov3Cz6rXjj/hioUUWQpR1kDrAGHybqVGAG9qZIL2ZLag9UaKMbWQAeTIGB9Z5d4Srw/gjpKKD3iOz2Fo0DkaQMHmlJTme3LKiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=bxMzRBQk; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2cf591d22dfso12840751fa.0
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 08:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1706803854; x=1707408654; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QUVoc0E/OYa+AToYGz8Q4BBQZXgHdlFQ4US1MgCl+mc=;
        b=bxMzRBQkdf2hRXMLSHUgNQwcxMxme4H45VFNvWBaCOa5TF3LNERmMXfnTpZJv3S6JH
         lmh1mDgAsOwu5Yw2ZkPEEubKt9moJW2GJ++u7rbKLcUNIclaW5behPM+zNcSSiXZo263
         iHeWZDHcT1TuYLg2aFCMNlxctdeWHfxGYKLftSyaxEHMMypzg9qkDdTMZ1aGlSe395wD
         sMQmAmUnSj7lAOyW7vFMaEvmvgVX4cEVkP7JD0KPnz+YRiahsK5BMchAYqvFUgDB1mJE
         xYJa5pML1eioRqZKDrU45Hoc5Km5NqCYh9bMBg38HdtU1q1rK+UeVPtrfjAlplxcLEzW
         yQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706803854; x=1707408654;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUVoc0E/OYa+AToYGz8Q4BBQZXgHdlFQ4US1MgCl+mc=;
        b=ie3PzI7pDo2JYOT+odT7YELYjQHILEkkqPoA+dr6Vv2zNPH3ddpxuVnscfWRl4bRDB
         iLO8sy0FPvclP8DCYfA8JT2HkUMyJ5H4LIOVYfSJlrarHMX7rfWzTGKZD9OGTGtelXee
         r8gh0E1szIkHSs3IH5ih/Cl8A9lQU1ZctD5DMA2W1a07LMfCDA2Pvith0V7/oXvcggMH
         b1U7H0r/y5YYHxCsuvC1sxqKTXm6HtOWIAzSUUoTD4de/ZOM7hWokWjfqWjNwK5cfHav
         b0gSdxqNEc7gmjpZscbsGra6eHy7mdbD/REe4PAjEeowzS8pU28oBxsP/riRMzt086fm
         EkXw==
X-Gm-Message-State: AOJu0Yy5j0plZgiAPYf+ZN2xseUg2yCStLiDwDjo9RS+D+FjcvQyFj0h
	JNFEQcsasmyWIznKGD4Bz/X+ChL7uAxVp6ju+m5L1pBafJRmtTSOKLH8aox/en5hdUQzFCudquB
	b
X-Google-Smtp-Source: AGHT+IEdykIuN7/o5lMWik40LVDQK7zQYhARMjAg93ApuRHTe0/QCoSK6b2B/arIFRjh+NgB82J8WQ==
X-Received: by 2002:a2e:6e0b:0:b0:2cf:1535:9307 with SMTP id j11-20020a2e6e0b000000b002cf15359307mr3628705ljc.52.1706803854453;
        Thu, 01 Feb 2024 08:10:54 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXGBcHjBKKa9Hp1Frq6z0IhePrlvdjjS5lMePe36KtqClUHsi+17zOCRo3fL/61kEee3EP22cbvJHlAJAOv1ZRrajV5LxO4jM8tr8svg78hkH1YJ18mrFkVwvjaT8j5ZPyo8ATuuaDkTwwQw54g6QhIbtk8LYOgI7emnOjzRFRa63HvcxYuA2woYcbhtHKRGty6n1+y1kIcSSmxEiy1JblXIq32EJ9JIuK0NcJufeKRkyGSi68W+o8EAEL0iZZxf3Ag5MveLRHRqF0zMESj02fb
Received: from wkz-x13.addiva.ad (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id y1-20020a2e95c1000000b002cd7a4a2611sm2427088ljh.35.2024.02.01.08.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 08:10:53 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: olteanv@gmail.com,
	atenart@kernel.org,
	roopa@nvidia.com,
	razor@blackwall.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	jiri@resnulli.us,
	ivecera@redhat.com
Subject: [PATCH v3 net] net: bridge: switchdev: Skip MDB replays of pending events
Date: Thu,  1 Feb 2024 17:10:45 +0100
Message-Id: <20240201161045.1956074-1-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Addiva Elektronik
Content-Transfer-Encoding: 8bit

Before this change, generation of the list of events MDB to replay
would race against the IGMP/MLD snooping logic, which could concurrently
enqueue events to the switchdev deferred queue, leading to duplicate
events being sent to drivers. As a consequence of this, drivers which
reference count memberships (at least DSA), would be left with orphan
groups in their hardware database when the bridge was destroyed.

Avoid this by grabbing the write-side lock of the MDB while generating
the replay list, making sure that no deferred version of a replay
event is already enqueued to the switchdev deferred queue, before
adding it to the replay list.

An easy way to reproduce this issue, on an mv88e6xxx system, was to
create a snooping bridge, and immediately add a port to it:

    root@infix-06-0b-00:~$ ip link add dev br0 up type bridge mcast_snooping 1 && \
    > ip link set dev x3 up master br0
    root@infix-06-0b-00:~$ ip link del dev br0
    root@infix-06-0b-00:~$ mvls atu
    ADDRESS             FID  STATE      Q  F  0  1  2  3  4  5  6  7  8  9  a
    DEV:0 Marvell 88E6393X
    33:33:00:00:00:6a     1  static     -  -  0  .  .  .  .  .  .  .  .  .  .
    33:33:ff:87:e4:3f     1  static     -  -  0  .  .  .  .  .  .  .  .  .  .
    ff:ff:ff:ff:ff:ff     1  static     -  -  0  1  2  3  4  5  6  7  8  9  a
    root@infix-06-0b-00:~$

The two IPv6 groups remain in the hardware database because the
port (x3) is notified of the host's membership twice: once via the
original event and once via a replay. Since only a single delete
notification is sent, the count remains at 1 when the bridge is
destroyed.

Fixes: 4f2673b3a2b6 ("net: bridge: add helper to replay port and host-joined mdb entries")
Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---

Notes:
    v1 -> v2:
    
    - Squash the previously separate addition of
      switchdev_port_obj_act_is_deferred into this patch.
    - Use ether_addr_equal to compare MAC addresses.
    - Document switchdev_port_obj_act_is_deferred (renamed from
      switchdev_port_obj_is_deferred in v1, to indicate that we also match
      on the action).
    - Delay allocations of MDB objects until we know they're needed.
    - Use non-RCU version of the hash list iterator, now that the MDB is
      not scanned while holding the RCU read lock.
    - Add Fixes tag to commit message
    
    v2 -> v3:
    
    - Fix unlocking in error paths
    - Access RCU protected port list via mlock_dereference, since MDB is
      guaranteed to remain constant for the duration of the scan.

 include/net/switchdev.h   |  3 ++
 net/bridge/br_switchdev.c | 69 +++++++++++++++++++++---------------
 net/switchdev/switchdev.c | 73 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 117 insertions(+), 28 deletions(-)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index a43062d4c734..8346b0d29542 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -308,6 +308,9 @@ void switchdev_deferred_process(void);
 int switchdev_port_attr_set(struct net_device *dev,
 			    const struct switchdev_attr *attr,
 			    struct netlink_ext_ack *extack);
+bool switchdev_port_obj_act_is_deferred(struct net_device *dev,
+					enum switchdev_notifier_type nt,
+					const struct switchdev_obj *obj);
 int switchdev_port_obj_add(struct net_device *dev,
 			   const struct switchdev_obj *obj,
 			   struct netlink_ext_ack *extack);
diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index ee84e783e1df..6d3fb4292071 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -595,21 +595,35 @@ br_switchdev_mdb_replay_one(struct notifier_block *nb, struct net_device *dev,
 }
 
 static int br_switchdev_mdb_queue_one(struct list_head *mdb_list,
+				      struct net_device *dev,
+				      unsigned long action,
 				      enum switchdev_obj_id id,
 				      const struct net_bridge_mdb_entry *mp,
 				      struct net_device *orig_dev)
 {
-	struct switchdev_obj_port_mdb *mdb;
+	struct switchdev_obj_port_mdb mdb = {
+		.obj = {
+			.id = id,
+			.orig_dev = orig_dev,
+		},
+	};
+	struct switchdev_obj_port_mdb *pmdb;
 
-	mdb = kzalloc(sizeof(*mdb), GFP_ATOMIC);
-	if (!mdb)
-		return -ENOMEM;
+	br_switchdev_mdb_populate(&mdb, mp);
 
-	mdb->obj.id = id;
-	mdb->obj.orig_dev = orig_dev;
-	br_switchdev_mdb_populate(mdb, mp);
-	list_add_tail(&mdb->obj.list, mdb_list);
+	if (switchdev_port_obj_act_is_deferred(dev, action, &mdb.obj)) {
+		/* This event is already in the deferred queue of
+		 * events, so this replay must be elided, lest the
+		 * driver receives duplicate events for it.
+		 */
+		return 0;
+	}
+
+	pmdb = kmemdup(&mdb, sizeof(mdb), GFP_ATOMIC);
+	if (!pmdb)
+		return -ENOMEM;
 
+	list_add_tail(&pmdb->obj.list, mdb_list);
 	return 0;
 }
 
@@ -677,51 +691,50 @@ br_switchdev_mdb_replay(struct net_device *br_dev, struct net_device *dev,
 	if (!br_opt_get(br, BROPT_MULTICAST_ENABLED))
 		return 0;
 
-	/* We cannot walk over br->mdb_list protected just by the rtnl_mutex,
-	 * because the write-side protection is br->multicast_lock. But we
-	 * need to emulate the [ blocking ] calling context of a regular
-	 * switchdev event, so since both br->multicast_lock and RCU read side
-	 * critical sections are atomic, we have no choice but to pick the RCU
-	 * read side lock, queue up all our events, leave the critical section
-	 * and notify switchdev from blocking context.
+	if (adding)
+		action = SWITCHDEV_PORT_OBJ_ADD;
+	else
+		action = SWITCHDEV_PORT_OBJ_DEL;
+
+	/* br_switchdev_mdb_queue_one() will take care to not queue a
+	 * replay of an event that is already pending in the switchdev
+	 * deferred queue. In order to safely determine that, there
+	 * must be no new deferred MDB notifications enqueued for the
+	 * duration of the MDB scan. Therefore, grab the write-side
+	 * lock to avoid racing with any concurrent IGMP/MLD snooping.
 	 */
-	rcu_read_lock();
+	spin_lock_bh(&br->multicast_lock);
 
-	hlist_for_each_entry_rcu(mp, &br->mdb_list, mdb_node) {
+	hlist_for_each_entry(mp, &br->mdb_list, mdb_node) {
 		struct net_bridge_port_group __rcu * const *pp;
 		const struct net_bridge_port_group *p;
 
 		if (mp->host_joined) {
-			err = br_switchdev_mdb_queue_one(&mdb_list,
+			err = br_switchdev_mdb_queue_one(&mdb_list, dev, action,
 							 SWITCHDEV_OBJ_ID_HOST_MDB,
 							 mp, br_dev);
 			if (err) {
-				rcu_read_unlock();
+				spin_unlock_bh(&br->multicast_lock);
 				goto out_free_mdb;
 			}
 		}
 
-		for (pp = &mp->ports; (p = rcu_dereference(*pp)) != NULL;
+		for (pp = &mp->ports; (p = mlock_dereference(*pp, br)) != NULL;
 		     pp = &p->next) {
 			if (p->key.port->dev != dev)
 				continue;
 
-			err = br_switchdev_mdb_queue_one(&mdb_list,
+			err = br_switchdev_mdb_queue_one(&mdb_list, dev, action,
 							 SWITCHDEV_OBJ_ID_PORT_MDB,
 							 mp, dev);
 			if (err) {
-				rcu_read_unlock();
+				spin_unlock_bh(&br->multicast_lock);
 				goto out_free_mdb;
 			}
 		}
 	}
 
-	rcu_read_unlock();
-
-	if (adding)
-		action = SWITCHDEV_PORT_OBJ_ADD;
-	else
-		action = SWITCHDEV_PORT_OBJ_DEL;
+	spin_unlock_bh(&br->multicast_lock);
 
 	list_for_each_entry(obj, &mdb_list, list) {
 		err = br_switchdev_mdb_replay_one(nb, dev,
diff --git a/net/switchdev/switchdev.c b/net/switchdev/switchdev.c
index 5b045284849e..7d11f31820df 100644
--- a/net/switchdev/switchdev.c
+++ b/net/switchdev/switchdev.c
@@ -19,6 +19,35 @@
 #include <linux/rtnetlink.h>
 #include <net/switchdev.h>
 
+static bool switchdev_obj_eq(const struct switchdev_obj *a,
+			     const struct switchdev_obj *b)
+{
+	const struct switchdev_obj_port_vlan *va, *vb;
+	const struct switchdev_obj_port_mdb *ma, *mb;
+
+	if (a->id != b->id || a->orig_dev != b->orig_dev)
+		return false;
+
+	switch (a->id) {
+	case SWITCHDEV_OBJ_ID_PORT_VLAN:
+		va = SWITCHDEV_OBJ_PORT_VLAN(a);
+		vb = SWITCHDEV_OBJ_PORT_VLAN(b);
+		return va->flags == vb->flags &&
+			va->vid == vb->vid &&
+			va->changed == vb->changed;
+	case SWITCHDEV_OBJ_ID_PORT_MDB:
+	case SWITCHDEV_OBJ_ID_HOST_MDB:
+		ma = SWITCHDEV_OBJ_PORT_MDB(a);
+		mb = SWITCHDEV_OBJ_PORT_MDB(b);
+		return ma->vid == mb->vid &&
+			ether_addr_equal(ma->addr, mb->addr);
+	default:
+		break;
+	}
+
+	BUG();
+}
+
 static LIST_HEAD(deferred);
 static DEFINE_SPINLOCK(deferred_lock);
 
@@ -307,6 +336,50 @@ int switchdev_port_obj_del(struct net_device *dev,
 }
 EXPORT_SYMBOL_GPL(switchdev_port_obj_del);
 
+/**
+ *	switchdev_port_obj_act_is_deferred - Is object action pending?
+ *
+ *	@dev: port device
+ *	@nt: type of action; add or delete
+ *	@obj: object to test
+ *
+ *	Returns true if a deferred item is exists, which is equivalent
+ *	to the action @nt of an object @obj.
+ *
+ *	rtnl_lock must be held.
+ */
+bool switchdev_port_obj_act_is_deferred(struct net_device *dev,
+					enum switchdev_notifier_type nt,
+					const struct switchdev_obj *obj)
+{
+	struct switchdev_deferred_item *dfitem;
+	bool found = false;
+
+	ASSERT_RTNL();
+
+	spin_lock_bh(&deferred_lock);
+
+	list_for_each_entry(dfitem, &deferred, list) {
+		if (dfitem->dev != dev)
+			continue;
+
+		if ((dfitem->func == switchdev_port_obj_add_deferred &&
+		     nt == SWITCHDEV_PORT_OBJ_ADD) ||
+		    (dfitem->func == switchdev_port_obj_del_deferred &&
+		     nt == SWITCHDEV_PORT_OBJ_DEL)) {
+			if (switchdev_obj_eq((const void *)dfitem->data, obj)) {
+				found = true;
+				break;
+			}
+		}
+	}
+
+	spin_unlock_bh(&deferred_lock);
+
+	return found;
+}
+EXPORT_SYMBOL_GPL(switchdev_port_obj_act_is_deferred);
+
 static ATOMIC_NOTIFIER_HEAD(switchdev_notif_chain);
 static BLOCKING_NOTIFIER_HEAD(switchdev_blocking_notif_chain);
 
-- 
2.34.1


