Return-Path: <netdev+bounces-174399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A51EA5E787
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 23:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6AD117AECB
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 22:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891BF1F0E4B;
	Wed, 12 Mar 2025 22:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWthig+e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650761EFFBA
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 22:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741818933; cv=none; b=ido1c93KQ6LThVc/Nj97hCGJf6l4XlLI602HMZC0jAxrDxEX+cm6C1y/o/Oql3KMuU2QCC6WArgEwWQG7eviv2UIIj3nUwmTuRS7xb5/qiyY7uF8Lffl2HPvmvbAZ/hPRwqRGw94HKU8vTtoZUYRPZopnEpB3CDa2hCtZbwUpaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741818933; c=relaxed/simple;
	bh=m94RWl7vU9oHuhve8G/1ka9IbsK+2DTHzEc60QzSUWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f7szl1i8bZwMnSEJGhC8sUKHug0Sg1MgW5IdeuGjF9G+kz9qKmOkGjQx4MYDZMpL+FpmpyXpIskL3YXMA3yPMNl6EpG4YZ3vBlRl7EC4E7VT+llyp+DJ52F34P2SkPYrswPsl177POwB7IZmM9CxH5A/dv34nvxDMdELvcIGXNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWthig+e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8010C4CEE3;
	Wed, 12 Mar 2025 22:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741818932;
	bh=m94RWl7vU9oHuhve8G/1ka9IbsK+2DTHzEc60QzSUWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iWthig+eWjigUtVEaa6Erm5ePiUSNsZsc7EYCW0XNF60yZoiheBcuNMb8c1OY2xiZ
	 N1r9hXTT+OYQYWxV45+tUnVQghz+tJt80jLnbk8ZrQ5doox9Gfg/1yqpvwHT1Qsey3
	 +e0prnDCRRSm6Z+QL/nq6XA24AHiKcF9Yf0mX8lNzS+XwQowWJqx8gY/guSypM0dGm
	 8by7TgKQhObjFED9HePVXHInYevGh+xAHrBwxDjPFSazySO9DoLYRwkZEweguqP0P/
	 qoU6RRhAV1+CBW/dSRmryT9hM5sbkT9R0q/SMv/rpRj9bBnIkUSHYPMFxJIG6UpW64
	 HeRoN6CFLgkuQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 06/11] net: designate queue -> napi linking as "ops protected"
Date: Wed, 12 Mar 2025 23:35:02 +0100
Message-ID: <20250312223507.805719-7-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250312223507.805719-1-kuba@kernel.org>
References: <20250312223507.805719-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netdev netlink is the only reader of netdev_{,rx_}queue->napi,
and it already holds netdev->lock. Switch protection of
the writes to netdev->lock to "ops protected".

The expectation will be now that accessing queue->napi
will require netdev->lock for "ops locked" drivers, and
rtnl_lock for all other drivers.

Current "ops locked" drivers don't require any changes.
gve and netdevsim use _locked() helpers right next to
netif_queue_set_napi() so they must be holding the instance
lock. iavf doesn't call it. bnxt is a bit messy but all paths
seem locked.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/netdevice.h     | 5 +++--
 include/net/netdev_lock.h     | 8 ++++++++
 include/net/netdev_rx_queue.h | 2 +-
 net/core/dev.c                | 3 +--
 4 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0e2fa80a556d..0fc79ae60ff5 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -710,7 +710,7 @@ struct netdev_queue {
  * slow- / control-path part
  */
 	/* NAPI instance for the queue
-	 * Readers and writers must hold RTNL
+	 * "ops protected", see comment about net_device::lock
 	 */
 	struct napi_struct	*napi;
 
@@ -2522,7 +2522,8 @@ struct net_device {
 	 * Double ops protects:
 	 *	@real_num_rx_queues, @real_num_tx_queues
 	 *
-	 * Also protects some fields in struct napi_struct.
+	 * Also protects some fields in:
+	 *	struct napi_struct, struct netdev_queue, struct netdev_rx_queue
 	 *
 	 * Ordering: take after rtnl_lock.
 	 */
diff --git a/include/net/netdev_lock.h b/include/net/netdev_lock.h
index efd302375ef2..1c0c9a94cc22 100644
--- a/include/net/netdev_lock.h
+++ b/include/net/netdev_lock.h
@@ -56,6 +56,14 @@ static inline void netdev_ops_assert_locked(const struct net_device *dev)
 		ASSERT_RTNL();
 }
 
+static inline void
+netdev_ops_assert_locked_or_invisible(const struct net_device *dev)
+{
+	if (dev->reg_state == NETREG_REGISTERED ||
+	    dev->reg_state == NETREG_UNREGISTERING)
+		netdev_ops_assert_locked(dev);
+}
+
 static inline int netdev_lock_cmp_fn(const struct lockdep_map *a,
 				     const struct lockdep_map *b)
 {
diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
index af40842f229d..b2238b551dce 100644
--- a/include/net/netdev_rx_queue.h
+++ b/include/net/netdev_rx_queue.h
@@ -24,7 +24,7 @@ struct netdev_rx_queue {
 	struct xsk_buff_pool            *pool;
 #endif
 	/* NAPI instance for the queue
-	 * Readers and writers must hold RTNL
+	 * "ops protected", see comment about net_device::lock
 	 */
 	struct napi_struct		*napi;
 	struct pp_memory_provider_params mp_params;
diff --git a/net/core/dev.c b/net/core/dev.c
index 8ae4f56169fe..8f30938ed402 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6886,8 +6886,7 @@ void netif_queue_set_napi(struct net_device *dev, unsigned int queue_index,
 
 	if (WARN_ON_ONCE(napi && !napi->dev))
 		return;
-	if (dev->reg_state >= NETREG_REGISTERED)
-		ASSERT_RTNL();
+	netdev_ops_assert_locked_or_invisible(dev);
 
 	switch (type) {
 	case NETDEV_QUEUE_TYPE_RX:
-- 
2.48.1


