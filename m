Return-Path: <netdev+bounces-180463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3658CA81633
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 22:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBDEE19E09B0
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 20:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25364253F22;
	Tue,  8 Apr 2025 20:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ucfGhnDF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B01253F1F
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 20:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744142408; cv=none; b=cRTD9IAgXRUigG8QIyT44m990qmCQ2UNwNPhnVaPuK3KtEcENZZTPmUUGark5WyD2DkVe8eu9K8rqnRdls8HrZLOHLsNLnYT7c7EjfJJcpCraaIdJYxKCyPGb1cPloW4nOzdp0FiKfZZBhszgRmesutAbu8VEqJVv0mYGKxBhI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744142408; c=relaxed/simple;
	bh=a/7goKcVV0s9MH9Ap0KjbTu3o7YXNr5+57vTt1IQG3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zr68BUTH+sanLMtLyQfe/PEiq3lbAL4s49+EN9FQDkCoo3S0PCGYEJvzGeQQgoXhIDesEUYhBA/q/iDOpzSktuZeqSia3VoT5YZEReCF2SaidhwI67FTu1QJ4r63Txam6AAdzQTygMOHEYfi0WvujB5ZTsLuX9JG0UTPPyTgKfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ucfGhnDF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA4E9C4CEEA;
	Tue,  8 Apr 2025 20:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744142407;
	bh=a/7goKcVV0s9MH9Ap0KjbTu3o7YXNr5+57vTt1IQG3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ucfGhnDFJuWpVj6BIs40o0bvcEZm6Z/RHtGeYCnDtlEslliKwdLplTnqO+oj5tehN
	 hGkZ7xr8OO1vGEveKTnwxz17fo6/8QrCTlt9LyI2wCD/CBdzorXx85AmxPlz9aMiQp
	 iAsb7b0c9MdMlynVUDEpMPCALcESiVdKFccCzsZGUAUdvyER5TvI+NIsB0NuKaB0N4
	 0N3AXxJHPt25t+UuMwu5T3jvnv25peRMLuZnN2xUTnJOXHTff+y73AOHFECek6vGbU
	 U2n8gTMitkp9SPmJH2LuMZUEhpe2Zlu1N6I/ziZSyhxTXD2vnV+VtHg3pSpfWPo+nu
	 okgg2G0pXqZ+A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me,
	hramamurthy@google.com,
	kuniyu@amazon.com,
	jdamato@fastly.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 1/8] net: avoid potential race between netdev_get_by_index_lock() and netns switch
Date: Tue,  8 Apr 2025 12:59:48 -0700
Message-ID: <20250408195956.412733-2-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408195956.412733-1-kuba@kernel.org>
References: <20250408195956.412733-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netdev_get_by_index_lock() performs following steps:

  rcu_lock();
  dev = lookup(netns, ifindex);
  dev_get(dev);
  rcu_unlock();
  [... lock & validate the dev ...]
  return dev

Validation right now only checks if the device is registered but since
the lookup is netns-aware we must also protect against the device
switching netns right after we dropped the RCU lock. Otherwise
the caller in netns1 may get a pointer to a device which has just
switched to netns2.

We can't hold the lock for the entire netns change process (because of
the NETDEV_UNREGISTER notifier), and there's no existing marking to
indicate that the netns is unlisted because of netns move, so add one.

AFAIU none of the existing netdev_get_by_index_lock() callers can
suffer from this problem (NAPI code double checks the netns membership
and other callers are either under rtnl_lock or not ns-sensitive),
so this patch does not have to be treated as a fix.

Reviewed-by: Joe Damato <jdamato@fastly.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/netdevice.h |  6 +++++-
 net/core/dev.h            |  2 +-
 net/core/dev.c            | 25 ++++++++++++++++++-------
 3 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index cf3b6445817b..8e9be80bc167 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1952,6 +1952,7 @@ enum netdev_reg_state {
  *	@priv_destructor:	Called from unregister
  *	@npinfo:		XXX: need comments on this one
  * 	@nd_net:		Network namespace this network device is inside
+ *				protected by @lock
  *
  * 	@ml_priv:	Mid-layer private
  *	@ml_priv_type:  Mid-layer private type
@@ -2359,6 +2360,9 @@ struct net_device {
 
 	bool dismantle;
 
+	/** @moving_ns: device is changing netns, protected by @lock */
+	bool moving_ns;
+
 	enum {
 		RTNL_LINK_INITIALIZED,
 		RTNL_LINK_INITIALIZING,
@@ -2521,7 +2525,7 @@ struct net_device {
 	 *	@net_shaper_hierarchy, @reg_state, @threaded
 	 *
 	 * Double protects:
-	 *	@up
+	 *	@up, @moving_ns, @nd_net
 	 *
 	 * Double ops protects:
 	 *	@real_num_rx_queues, @real_num_tx_queues
diff --git a/net/core/dev.h b/net/core/dev.h
index 710abc05ebdb..e7bf21f52fc7 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -30,7 +30,7 @@ netdev_napi_by_id_lock(struct net *net, unsigned int napi_id);
 struct net_device *dev_get_by_napi_id(unsigned int napi_id);
 
 struct net_device *netdev_get_by_index_lock(struct net *net, int ifindex);
-struct net_device *__netdev_put_lock(struct net_device *dev);
+struct net_device *__netdev_put_lock(struct net_device *dev, struct net *net);
 struct net_device *
 netdev_xa_find_lock(struct net *net, struct net_device *dev,
 		    unsigned long *index);
diff --git a/net/core/dev.c b/net/core/dev.c
index 4ccc6dc5303e..8c13e5339cc9 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -828,7 +828,7 @@ netdev_napi_by_id_lock(struct net *net, unsigned int napi_id)
 	dev_hold(dev);
 	rcu_read_unlock();
 
-	dev = __netdev_put_lock(dev);
+	dev = __netdev_put_lock(dev, net);
 	if (!dev)
 		return NULL;
 
@@ -1039,10 +1039,11 @@ struct net_device *dev_get_by_napi_id(unsigned int napi_id)
  * This helper is intended for locking net_device after it has been looked up
  * using a lockless lookup helper. Lock prevents the instance from going away.
  */
-struct net_device *__netdev_put_lock(struct net_device *dev)
+struct net_device *__netdev_put_lock(struct net_device *dev, struct net *net)
 {
 	netdev_lock(dev);
-	if (dev->reg_state > NETREG_REGISTERED) {
+	if (dev->reg_state > NETREG_REGISTERED ||
+	    dev->moving_ns || !net_eq(dev_net(dev), net)) {
 		netdev_unlock(dev);
 		dev_put(dev);
 		return NULL;
@@ -1070,7 +1071,7 @@ struct net_device *netdev_get_by_index_lock(struct net *net, int ifindex)
 	if (!dev)
 		return NULL;
 
-	return __netdev_put_lock(dev);
+	return __netdev_put_lock(dev, net);
 }
 
 struct net_device *
@@ -1090,7 +1091,7 @@ netdev_xa_find_lock(struct net *net, struct net_device *dev,
 		dev_hold(dev);
 		rcu_read_unlock();
 
-		dev = __netdev_put_lock(dev);
+		dev = __netdev_put_lock(dev, net);
 		if (dev)
 			return dev;
 
@@ -12157,7 +12158,11 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
 	netif_close(dev);
 	/* And unlink it from device chain */
 	unlist_netdevice(dev);
-	netdev_unlock_ops(dev);
+
+	if (!netdev_need_ops_lock(dev))
+		netdev_lock(dev);
+	dev->moving_ns = true;
+	netdev_unlock(dev);
 
 	synchronize_net();
 
@@ -12193,7 +12198,9 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
 	move_netdevice_notifiers_dev_net(dev, net);
 
 	/* Actually switch the network namespace */
+	netdev_lock(dev);
 	dev_net_set(dev, net);
+	netdev_unlock(dev);
 	dev->ifindex = new_ifindex;
 
 	if (new_name[0]) {
@@ -12219,7 +12226,11 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
 	err = netdev_change_owner(dev, net_old, net);
 	WARN_ON(err);
 
-	netdev_lock_ops(dev);
+	netdev_lock(dev);
+	dev->moving_ns = false;
+	if (!netdev_need_ops_lock(dev))
+		netdev_unlock(dev);
+
 	/* Add the device back in the hashes */
 	list_netdevice(dev);
 	/* Notify protocols, that a new device appeared. */
-- 
2.49.0


