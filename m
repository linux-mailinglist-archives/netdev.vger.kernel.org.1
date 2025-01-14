Return-Path: <netdev+bounces-157980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E2AA0FFC0
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 04:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4B241633BF
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 03:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D55F233547;
	Tue, 14 Jan 2025 03:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uNmC0tSu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677CE23353C
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 03:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736826693; cv=none; b=ApUtL1scGXJfNgXFce78eBqzOw4bKYeu9TsgEjPfVNslu89AwGIH60vWmKnyzdsQ8D7tw/UCDI2gzGUvHi0b80r77HHbweQHuzQI9QpTZcpp1aGo1QWpWrkQsE7nt6BIh8sX0swOTJpe+0T0PQOOSuIu+8wb9IimSL+e92COUXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736826693; c=relaxed/simple;
	bh=o9GEh7JWbKmRqO6sblRDoE/qu3xXdfDzYkpbWQC0itI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lYFLG03MbZiNCUiApEgimH2ebqR9Dt0FmCg/4ehB5+RVd4sf8e8DFJo752U6JW+YpHO3Flf5j8LgNClBm6vb5iWPYGvVOZuGNPgqJHsef2VqtncLAqRnvrhk9L7mj3OFz8x/5HRo2PJ4w1SktF1ce6HJdzG1KhjnZB0b6BtyNdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uNmC0tSu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66459C4CEE1;
	Tue, 14 Jan 2025 03:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736826692;
	bh=o9GEh7JWbKmRqO6sblRDoE/qu3xXdfDzYkpbWQC0itI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uNmC0tSugOSFYtTJkdGCHTsj2CKV5Y11g+FjE7q31w6a2z1oB82/yu+T9AbQZaTKd
	 h7Wp2OdH6jeYdKF4TMAaxZStUfi1To5R8MU1hnn/QBpNHF+9nQA1NeoUuLMwA/9gMO
	 Ej0cLRAyoc8jvD4hFf1ze5CEfo1OGH4juOGt03/b4z1rvBNfM+YCd8Er5izD2PnEXF
	 cLMfOlNdOi04tPZaXbnZIp4SpU8GdxKy/+uoFzgSwQn7sKIxVIcrVwIZ0gG78Mevz7
	 WqiOUalYpLGWgpy9aMoEyjlQNGemC5Jn/y3LMP0UWXzq+0MVrOtL1X2UHamOqWFzL2
	 6NTleg1v0mUhQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	jdamato@fastly.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 04/11] net: add netdev->up protected by netdev_lock()
Date: Mon, 13 Jan 2025 19:51:10 -0800
Message-ID: <20250114035118.110297-5-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250114035118.110297-1-kuba@kernel.org>
References: <20250114035118.110297-1-kuba@kernel.org>
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

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/netdevice.h | 13 ++++++++++++-
 net/core/dev.h            | 12 ++++++++++++
 net/core/dev.c            |  4 ++--
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index bdbc5849469c..565dfeb78774 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2443,12 +2443,23 @@ struct net_device {
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
+	 * Partially protects (readers hold either @lock or rtnl_lock,
+	 * writers must hold both for registered devices):
+	 *	@up
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
index 2ded6eedb4cc..1a05ad60b89f 100644
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
2.47.1


