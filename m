Return-Path: <netdev+bounces-177259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A455A6E6C1
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 23:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98FD01898BC7
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 22:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500A31F0E21;
	Mon, 24 Mar 2025 22:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGg78okt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEA2189520
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 22:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742856368; cv=none; b=vCaQX8VE8I41SBrp3xX+FJIY69szIgJQbv0sw4+CYn9gJmBgQbqIeI0oB8lm4dhX+bieH9W+bDaUX1GSX9FRMeYINfYYoIlrsMDIbWHXeGKRnpbJrziP3dfj6uNb8cZdP555xCf7fxdHGefL+MwQXn67DE47LtVygs/9CTZ6uT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742856368; c=relaxed/simple;
	bh=N8ce7/T2rdGP3Dp6ms+l8h8orXsx57wAFWWsqkkX7NM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QO4vK7fDQpa9NJI39qmYv42gb27uZiPEEwDTHIYJC9vKUjBTgXc1+m0pWneYO8q+aXCGiEJ7+A81L0WIOC9Tb6NsL2zHSMLHvOpDqML4IgrSwKlJTn2ln1JG9E2uQVPSfAvj7eMBQpzXwo6nKkCZwRtDBjFwQfqpERF3BJA0ToE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGg78okt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8C4C4CEDD;
	Mon, 24 Mar 2025 22:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742856368;
	bh=N8ce7/T2rdGP3Dp6ms+l8h8orXsx57wAFWWsqkkX7NM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oGg78oktDth4jiA0z93PniAMXDlqy3GOutIrNX5T8+AO/xPBAUNsbQYsEWpMH42hM
	 I43vwmrT4Q1TnsIevYLJQoiw2aTfRaB8cae4PF8uy1PenivTgPL6jRVi3u0nNxuGR2
	 2Rtf66swGAvd5IhKARGd0Vw52300WUimjPGLDZvIvBMWVrezL48U1AQT3lP09gPJhm
	 T9CZgmXomUSyw8oJcLfemlOblYvsy+nlOY3X/s8sMKxwaqLXXeA8LY6szYxtieovca
	 Jl7t0egNloMj3debzeU8dnn9acH8pwn8RfgdMTioEi9CqIEInjy9WWQwaxmlUzp7UI
	 sxb8sJ5+I48Dw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 05/11] net: designate queue counts as "double ops protected" by instance lock
Date: Mon, 24 Mar 2025 15:45:31 -0700
Message-ID: <20250324224537.248800-6-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250324224537.248800-1-kuba@kernel.org>
References: <20250324224537.248800-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drivers which opt into instance lock protection of ops should
only call set_real_num_*_queues() under the instance lock.
This means that queue counts are double protected (writes
are under both rtnl_lock and instance lock, readers under
either).

Some readers may still be under the rtnl_lock, however, so for
now we need double protection of writers.

OTOH queue API paths are only under the protection of the instance
lock, so we need to validate that the instance is actually locking
ops, otherwise the input checks we do against queue count are racy.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/netdevice.h  | 3 +++
 net/core/dev.c             | 2 ++
 net/core/net-sysfs.c       | 2 ++
 net/core/netdev-genl.c     | 7 +++++++
 net/core/netdev_rx_queue.c | 3 +++
 5 files changed, 17 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 09773e5c109a..3dbce9cd3f5a 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2519,6 +2519,9 @@ struct net_device {
 	 * Double protects:
 	 *	@up
 	 *
+	 * Double ops protects:
+	 *	@real_num_rx_queues, @real_num_tx_queues
+	 *
 	 * Also protects some fields in struct napi_struct.
 	 *
 	 * Ordering: take after rtnl_lock.
diff --git a/net/core/dev.c b/net/core/dev.c
index 1a6e62792bb5..aa99c91fd68f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3130,6 +3130,7 @@ int netif_set_real_num_tx_queues(struct net_device *dev, unsigned int txq)
 	if (dev->reg_state == NETREG_REGISTERED ||
 	    dev->reg_state == NETREG_UNREGISTERING) {
 		ASSERT_RTNL();
+		netdev_ops_assert_locked(dev);
 
 		rc = netdev_queue_update_kobjects(dev, dev->real_num_tx_queues,
 						  txq);
@@ -3179,6 +3180,7 @@ int netif_set_real_num_rx_queues(struct net_device *dev, unsigned int rxq)
 
 	if (dev->reg_state == NETREG_REGISTERED) {
 		ASSERT_RTNL();
+		netdev_ops_assert_locked(dev);
 
 		rc = net_rx_queue_update_kobjects(dev, dev->real_num_rx_queues,
 						  rxq);
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index abaa1c919b98..fa8c8c364a9a 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -2148,8 +2148,10 @@ static void remove_queue_kobjects(struct net_device *dev)
 	net_rx_queue_update_kobjects(dev, real_rx, 0);
 	netdev_queue_update_kobjects(dev, real_tx, 0);
 
+	netdev_lock_ops(dev);
 	dev->real_num_rx_queues = 0;
 	dev->real_num_tx_queues = 0;
+	netdev_unlock_ops(dev);
 #ifdef CONFIG_SYSFS
 	kset_unregister(dev->queues_kset);
 #endif
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 9e4882a22407..fd1cfa9707dc 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -867,6 +867,13 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_unlock_sock;
 	}
 
+	if (!netdev_need_ops_lock(netdev)) {
+		err = -EOPNOTSUPP;
+		NL_SET_BAD_ATTR(info->extack,
+				info->attrs[NETDEV_A_DEV_IFINDEX]);
+		goto err_unlock;
+	}
+
 	if (dev_xdp_prog_count(netdev)) {
 		NL_SET_ERR_MSG(info->extack, "unable to bind dmabuf to device with XDP program attached");
 		err = -EEXIST;
diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index a5b234b33cd5..3af716f77a13 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -92,6 +92,9 @@ static int __net_mp_open_rxq(struct net_device *dev, unsigned ifq_idx,
 	struct netdev_rx_queue *rxq;
 	int ret;
 
+	if (!netdev_need_ops_lock(dev))
+		return -EOPNOTSUPP;
+
 	if (ifq_idx >= dev->real_num_rx_queues)
 		return -EINVAL;
 	ifq_idx = array_index_nospec(ifq_idx, dev->real_num_rx_queues);
-- 
2.49.0


