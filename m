Return-Path: <netdev+bounces-177260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBAEA6E6BE
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 23:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00AB37A5ADD
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 22:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9C01F0E33;
	Mon, 24 Mar 2025 22:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IbC99N45"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4121EF092
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 22:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742856371; cv=none; b=VYAEOZqV2s6RLoy5Cs0+W/sTV5gC5ybksUHuviLtcMiqwJf2asMaNr5Aa96A/Fawe0t/bbWN50lgeCsiYJNfL8qj+1SWzCrHZLpDyINHPtxfnDIBd4Bm2cvJiICWlD1G4sMDTsQxulNuo81JZ4qdT9BD6ym7jjNMCcZqMm8RDAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742856371; c=relaxed/simple;
	bh=z/I/BtRF99v+TA+ww7AuEtVGtX1QLInv2akaA9X0L/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A54StCDMiYtUufiw7MqK3flub3MXiDvnn2sP4e0PTPugLpHodHwcTNDhLJ2Qe28BlwTfA+491cky9Zma7jxwMr/Jv3RFNr/rCf+fRkV4D+q8ufw6SiLL9f4Dve9nTBOGrSDyIGqIQEKntc/uRuQVlYOypxryRkct3DBkY9fVsf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IbC99N45; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9BD2C4CEED;
	Mon, 24 Mar 2025 22:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742856371;
	bh=z/I/BtRF99v+TA+ww7AuEtVGtX1QLInv2akaA9X0L/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IbC99N45j4OuT6mnu8Voug9bJTB9MVLbcvvuU2o8MRGrDa2PzuKUQoeQu7ey9zc7A
	 hEnjIu6DRbHqAtiq0xPSQtpt416EOb/cYTeCxfUCp0hpVpGBK4qMnja2Qj/J3vMJlH
	 h8YXA/XJhndkJEJNeRXRS79K6jU7IiuWpZ5tdl6yTJKFAh/VFRDjkrZn/R6k2aUT3c
	 O6UF088d7dvha2Sbia4MgEx0gt+vJ/xgZVYvJMVA87OVHKukfKVBa3EfrPuA1gFumV
	 iG/C//VrcLvjTahOPonADEm3gaBcU0dlJVO6XP9yH3ILs4OXxqk0uxjgmCykDxVsGU
	 9SbnZwiSxdBwQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 06/11] net: designate queue -> napi linking as "ops protected"
Date: Mon, 24 Mar 2025 15:45:32 -0700
Message-ID: <20250324224537.248800-7-kuba@kernel.org>
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
index 3dbce9cd3f5a..fd508e9f148c 100644
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
index aa99c91fd68f..690d46497b2f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6896,8 +6896,7 @@ void netif_queue_set_napi(struct net_device *dev, unsigned int queue_index,
 
 	if (WARN_ON_ONCE(napi && !napi->dev))
 		return;
-	if (dev->reg_state >= NETREG_REGISTERED)
-		ASSERT_RTNL();
+	netdev_ops_assert_locked_or_invisible(dev);
 
 	switch (type) {
 	case NETDEV_QUEUE_TYPE_RX:
-- 
2.49.0


