Return-Path: <netdev+bounces-158375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CC1A11819
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 04:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 943E27A369E
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 03:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C33922F152;
	Wed, 15 Jan 2025 03:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lv/rlPfI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DFE22E41D
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 03:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736913219; cv=none; b=n6ygpK9ZRQ47RstB0wtYnwZfEX7JGwyZggPQ8/XGv4lF1PZQVvZdZLS2kqlcdaoPx9gMgJ2LpB+y5x8T3fSHmYwrEyg9La04cccOZ0K4CMFapYEN4Ru2Mlo9Vcr9UPLcaeSOn4bSYoOMMNg6vIMJUWC/F3eqlBbdi9qzEo3oS3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736913219; c=relaxed/simple;
	bh=0s2TaLPITNZgbrpX6AdtBSLUabw5dyWkhwRq5Z93L7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j/IIgktajU5+ZgQ2zOh7DZSNTi5ae7AM2hgZVhHgAjgb9vY8jQB4AFSTPLxlDs+xitNcplNXg6wwbNqoKzBFumGqQdkX/XhUD+CrptNMHw9gQYRYUBq6EaFu4G/zDXzY/4FKd9stRiFmG95KT5H5nJp/Qrs10kQaFkfRraTM4G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lv/rlPfI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3AF9C4CEE2;
	Wed, 15 Jan 2025 03:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736913219;
	bh=0s2TaLPITNZgbrpX6AdtBSLUabw5dyWkhwRq5Z93L7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lv/rlPfI/N89JdyYF7Cd+upntyCzbNeT5JcCmmPBv5Bl5w03f+RU1BLp4dcjZttsk
	 YYQYSpymziP5YBNk33GVULTuhOKAuC71HKdrBBDZNK0sojbYRGiJe8wACYYZ1Ekyw3
	 4oR6+djdU1KgfCeBwhR0GmoGmbEQcs9E10y05WMHP5c6+sZgEHJ+q2jBmJeOb4KBux
	 ra+eizzOevrKP945SIXf0crYGuWqKpRqOFPZKGmKhx40SJnKEbnv8j5Nr9fHvB8Rsk
	 oZJII9vsT0k0+1MrgIZdzbokr4H8J5tXEml6Ys6+gWwRRtFZ1FFkpq2nAsqqPXlSJi
	 kTY2q2PUB6b9A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	jdamato@fastly.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 04/11] net: add netdev->up protected by netdev_lock()
Date: Tue, 14 Jan 2025 19:53:12 -0800
Message-ID: <20250115035319.559603-5-kuba@kernel.org>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250115035319.559603-1-kuba@kernel.org>
References: <20250115035319.559603-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some uAPI (netdev netlink) hide net_device's sub-objects while
the interface is down to ensure uniform behavior across drivers.
To remove the rtnl_lock dependency from those uAPIs we need a way
to safely tell if the device is down or up.

Add an indication of whether device is open or closed, protected
by netdev->lock. The semantics are the same as IFF_UP, but taking
netdev_lock around every write to ->flags would be a lot of code
churn.

We don't want to blanket the entire open / close path by netdev_lock,
because it will prevent us from applying it to specific structures -
core helpers won't be able to take that lock from any function
called by the drivers on open/close paths.

So the state of the flag is "pessimistic", as in it may report false
negatives, but never false positives.

Reviewed-by: Joe Damato <jdamato@fastly.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - rework the kdoc to please Sphinx
v1:  https://lore.kernel.org/20250114035118.110297-5-kuba@kernel.org
---
 include/linux/netdevice.h | 14 +++++++++++++-
 net/core/dev.h            | 12 ++++++++++++
 net/core/dev.c            |  4 ++--
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 30963c5d409b..fdf3a8d93185 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2443,12 +2443,24 @@ struct net_device {
 	unsigned long		gro_flush_timeout;
 	u32			napi_defer_hard_irqs;
 
+	/**
+	 * @up: copy of @state's IFF_UP, but safe to read with just @lock.
+	 *	May report false negatives while the device is being opened
+	 *	or closed (@lock does not protect .ndo_open, or .ndo_close).
+	 */
+	bool			up;
+
 	/**
 	 * @lock: netdev-scope lock, protects a small selection of fields.
 	 * Should always be taken using netdev_lock() / netdev_unlock() helpers.
 	 * Drivers are free to use it for other protection.
 	 *
-	 * Protects: @reg_state, @net_shaper_hierarchy.
+	 * Protects:
+	 *	@net_shaper_hierarchy, @reg_state
+	 *
+	 * Partially protects (writers must hold both @lock and rtnl_lock):
+	 *	@up
+	 *
 	 * Ordering: take after rtnl_lock.
 	 */
 	struct mutex		lock;
diff --git a/net/core/dev.h b/net/core/dev.h
index 25ae732c0775..ef37e2dd44f4 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -128,6 +128,18 @@ void __dev_notify_flags(struct net_device *dev, unsigned int old_flags,
 void unregister_netdevice_many_notify(struct list_head *head,
 				      u32 portid, const struct nlmsghdr *nlh);
 
+static inline void netif_set_up(struct net_device *dev, bool value)
+{
+	if (value)
+		dev->flags |= IFF_UP;
+	else
+		dev->flags &= ~IFF_UP;
+
+	netdev_lock(dev);
+	dev->up = value;
+	netdev_unlock(dev);
+}
+
 static inline void netif_set_gso_max_size(struct net_device *dev,
 					  unsigned int size)
 {
diff --git a/net/core/dev.c b/net/core/dev.c
index c871e2697fb6..4cba553a4742 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1618,7 +1618,7 @@ static int __dev_open(struct net_device *dev, struct netlink_ext_ack *extack)
 	if (ret)
 		clear_bit(__LINK_STATE_START, &dev->state);
 	else {
-		dev->flags |= IFF_UP;
+		netif_set_up(dev, true);
 		dev_set_rx_mode(dev);
 		dev_activate(dev);
 		add_device_randomness(dev->dev_addr, dev->addr_len);
@@ -1697,7 +1697,7 @@ static void __dev_close_many(struct list_head *head)
 		if (ops->ndo_stop)
 			ops->ndo_stop(dev);
 
-		dev->flags &= ~IFF_UP;
+		netif_set_up(dev, false);
 		netpoll_poll_enable(dev);
 	}
 }
-- 
2.48.0


