Return-Path: <netdev+bounces-67545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B204843F7F
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 13:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 576BA1F2202F
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 12:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F347AE5E;
	Wed, 31 Jan 2024 12:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="jc63w5pL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C612D7869F
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 12:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706704559; cv=none; b=CK0LaiYMnOXYAOe9xsqaF2iubR9d433AGecy9Jm83qg4Hy307fxc8o1UMSylbsnzn2m+f4qeiSBr7tfJHh6V/YRZCb4RCDHu4wVHaJFEh8GNbmhr2A/W/ju0B36AyNmIz3Of3GfRPnj3kW7X1PUV16wljETkXdNzgMUGKTu0xYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706704559; c=relaxed/simple;
	bh=go1CxnwkYrNSMMXZA9us4VqyOB02NCR6uu21U6/jbb8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CPnc2kO7kXpELo6WSk8vtLfDOIw3YHBSTScyJ9i7MVXRMDbivI9inZGqM1QxLrVrPVV0iXgnlkc+ZjboscODIA9bc6RzXt7zb0BG/WTRhtCWNaQAgu51W/9Fy49eZ6JV9iLJDN2e1UjK1UightqfhPAQhNFiaJccgMQ/S/JAFH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=jc63w5pL; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d04fb2f36bso32039411fa.2
        for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 04:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1706704556; x=1707309356; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QEiIF2a77a2NYlBdF0rnvbhZ9XEvtTWVhxdh+i0lTps=;
        b=jc63w5pLzbv8MdKytEyo19ClyzhASBbNaO88XrZ3vtr+KToUgxyH1KESfjAc2wq8lG
         GCwwXXOHBDv074hYPyuj+p1lCQWxtw6WJrNOwNCWfik9fYNWidtx9WLDnzwVVnHSquag
         TCnIU2+dKIz4YNf2eMEhNYF8fqYYJBDUhEzz04NDIZh+iOV+75oUAjKwXJkNRxFoGJtD
         /FGbyFbTUfxXMSRs7SXW9teRhkmRPu7GJiDU57ZlDFYf8DDHzNvwap5VjkTgFKS+Gjrz
         g9chvTcXIXqrKL9pfdTk4laF/VaDZ+8+bW0pgXXEA4okapJbZUbdfwOM6sVzdgIqMR/o
         /j8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706704556; x=1707309356;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QEiIF2a77a2NYlBdF0rnvbhZ9XEvtTWVhxdh+i0lTps=;
        b=Op2JMSha00fqc6jEKBXAyujrHLbtRmAQLTExP1AdWdOamKwcrsfKYaYk39yANg111a
         3KDut7KwRzsRu87i++My5iHkuiNJOsSrEXVATtAD5lJOdZqz7dDIlzJU5ibr68T5OlRO
         GzMuKhA7SePmcUqM0QA+IF0yMj/9csWxA6+fLHX4R6vQS4FVjT/ixbrNUehzTyG/PgOo
         p5PsNH2PFCBPoixIwFc0oTk80ejz73GBsVf+4pVKqq2UwmNRa/A3qZOfr7YznCsKhlvd
         pImqnzMxC69cg+2ElAribmYrAA8GhktQB8/CxiXAlcUag46Ub1MtMVm7r85rWCKC7/d/
         ZiLQ==
X-Gm-Message-State: AOJu0YyFRSjdZDFRVN4dBQYiktSLtkWU+bo56yGcxR7BfJwrbmkK2ode
	MD+bXlYUcgnKZKFcrs50GakGEA8P/mhc/wk89q/iW6oQRFoMRSlb9qCKvsASA54=
X-Google-Smtp-Source: AGHT+IF2YwYWLus8PuFNfKLdfhUbeyNe6T0Pteaa0qeEdznNQXcwqXUMLHRIieF9cyqckkxKrvd96g==
X-Received: by 2002:a2e:7011:0:b0:2cf:2ef2:87f7 with SMTP id l17-20020a2e7011000000b002cf2ef287f7mr942673ljc.53.1706704555700;
        Wed, 31 Jan 2024 04:35:55 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXKNd1C9bpqVIlZCyele8ttZpf1tBlvnerSbbAefCXaKrZ9qcLUqipgcsFtqQL0JE6dUPwKSW9ycDvkbhYZEyeBGqQQGQRmyNdWBEWtRO7bPAVKVJIH0G7DVWwRtCIWEUVUGEqGdCJCH1JCBL0Cl16qXWE39f+GQj/JSJzGr5GDGD9Yi/+/DLcpeIQk+wgowyHi9OjshEdiR0yVfEQsL1UbmUfHqoDaOW8jXidWxiLeTeVwKbJynh4YWiOYaQ==
Received: from wkz-x13.addiva.ad (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id w21-20020a2e9bd5000000b002cdf4797fb7sm1913517ljj.125.2024.01.31.04.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 04:35:54 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: olteanv@gmail.com,
	roopa@nvidia.com,
	razor@blackwall.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	jiri@resnulli.us,
	ivecera@redhat.com
Subject: [PATCH net 2/2] net: bridge: switchdev: Skip MDB replays of pending events
Date: Wed, 31 Jan 2024 13:35:44 +0100
Message-Id: <20240131123544.462597-3-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131123544.462597-1-tobias@waldekranz.com>
References: <20240131123544.462597-1-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Addiva Elektronik
Content-Transfer-Encoding: 8bit

Generating the list of events MDB to replay races against the IGMP/MLD
snooping logic, which may concurrently enqueue events to the switchdev
deferred queue, leading to duplicate events being sent to drivers.

Avoid this by grabbing the write-side lock of the MDB, and make sure
that a deferred version of a replay event is not already enqueued to
the switchdev deferred queue before adding it to the replay list.

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
port (x3) is notified of the host's membership twice: once in the
original event and once in a replay. Since DSA tracks host addresses
using reference counters, and only a single delete notification is
sent, the count remains at 1 when the bridge is destroyed.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 net/bridge/br_switchdev.c | 44 ++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index ee84e783e1df..a3481190d5e6 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -595,6 +595,8 @@ br_switchdev_mdb_replay_one(struct notifier_block *nb, struct net_device *dev,
 }
 
 static int br_switchdev_mdb_queue_one(struct list_head *mdb_list,
+				      struct net_device *dev,
+				      unsigned long action,
 				      enum switchdev_obj_id id,
 				      const struct net_bridge_mdb_entry *mp,
 				      struct net_device *orig_dev)
@@ -608,8 +610,17 @@ static int br_switchdev_mdb_queue_one(struct list_head *mdb_list,
 	mdb->obj.id = id;
 	mdb->obj.orig_dev = orig_dev;
 	br_switchdev_mdb_populate(mdb, mp);
-	list_add_tail(&mdb->obj.list, mdb_list);
 
+	if (switchdev_port_obj_is_deferred(dev, action, &mdb->obj)) {
+		/* This event is already in the deferred queue of
+		 * events, so this replay must be elided, lest the
+		 * driver receives duplicate events for it.
+		 */
+		kfree(mdb);
+		return 0;
+	}
+
+	list_add_tail(&mdb->obj.list, mdb_list);
 	return 0;
 }
 
@@ -677,22 +688,26 @@ br_switchdev_mdb_replay(struct net_device *br_dev, struct net_device *dev,
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
+	/* br_switchdev_mdb_queue_one will take care to not queue a
+	 * replay of an event that is already pending in the switchdev
+	 * deferred queue. In order to safely determine that, there
+	 * must be no new deferred MDB notifications enqueued for the
+	 * duration of the MDB scan. Therefore, grab the write-side
+	 * lock to avoid racing with any concurrent IGMP/MLD snooping.
 	 */
-	rcu_read_lock();
+	spin_lock_bh(&br->multicast_lock);
 
 	hlist_for_each_entry_rcu(mp, &br->mdb_list, mdb_node) {
 		struct net_bridge_port_group __rcu * const *pp;
 		const struct net_bridge_port_group *p;
 
 		if (mp->host_joined) {
-			err = br_switchdev_mdb_queue_one(&mdb_list,
+			err = br_switchdev_mdb_queue_one(&mdb_list, dev, action,
 							 SWITCHDEV_OBJ_ID_HOST_MDB,
 							 mp, br_dev);
 			if (err) {
@@ -706,7 +721,7 @@ br_switchdev_mdb_replay(struct net_device *br_dev, struct net_device *dev,
 			if (p->key.port->dev != dev)
 				continue;
 
-			err = br_switchdev_mdb_queue_one(&mdb_list,
+			err = br_switchdev_mdb_queue_one(&mdb_list, dev, action,
 							 SWITCHDEV_OBJ_ID_PORT_MDB,
 							 mp, dev);
 			if (err) {
@@ -716,12 +731,7 @@ br_switchdev_mdb_replay(struct net_device *br_dev, struct net_device *dev,
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
-- 
2.34.1


