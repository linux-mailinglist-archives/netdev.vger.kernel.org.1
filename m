Return-Path: <netdev+bounces-157981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A9DA0FFC1
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 04:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16A2B163616
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 03:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1237D234963;
	Tue, 14 Jan 2025 03:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mIfGwVMX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E172343C1
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 03:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736826695; cv=none; b=jiMNDcl0X2Ka3SvClak8NhiV55L34rIH1RH3DApnSLPLM8PNsypWOEoWGnUz31HOuqfWlRosDaSjUVMhfa7FwV8WoTe9P0WnmkgpXwVVYv0mau8ppIhewmq567Zz9+EQLWIsJY4miD47UEjoYS0Hj6sFwX3zhKvbm+GOhSYfiZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736826695; c=relaxed/simple;
	bh=oixeFpHbXSKSe4sdtgCaYKBsu8BSYJszShdwIYht2+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TbZ0MAquLMAEHbnPBnGRIvbfFD2sAY6x0u8sqhUDPj8sZi6ooTPvmHjrcZDJ4Ln8FgUnytnCig2BfqUVS81o3fwI/AZRnIvJNsaspWj1yaB/z3xkP8kiMNFZrE7DZFUJyLVLe3T5s8LSu89cOEFzGaGkk+hYkOn6mR+KK77/wkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mIfGwVMX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E06FC4CEEA;
	Tue, 14 Jan 2025 03:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736826693;
	bh=oixeFpHbXSKSe4sdtgCaYKBsu8BSYJszShdwIYht2+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mIfGwVMXYxmpeKLsasPFJKxVJi+Vt+Z0NXOp6INqfjbaDRodWlplKcInfGCj+HWxi
	 nNMX+nG9I1ONz8qQuWDdcZzINxWiLhfa6O/A1gEH8A2SsefNefauttarQ29BCh0F4j
	 bcSD9ZsP6pAmXWF5qb0aK/Z1oDMbzng49d0ODL4FSxiRvDL2jv5Ll1SKPmkwjGrpJ7
	 S91J4X89xxuO7cvPeyZKi9RgkWkAAg/09SX748d1syplaVmwN2YVgXKAs9D0JLOMw8
	 XbywUXp6nBKbkCNdN9JyLReW0rRE96Yyb0HPHJUz8h1R2y/2HG1TY6UQOa36RR1TE4
	 thmLRqm9D0n2w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	jdamato@fastly.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 05/11] net: protect netdev->napi_list with netdev_lock()
Date: Mon, 13 Jan 2025 19:51:11 -0800
Message-ID: <20250114035118.110297-6-kuba@kernel.org>
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

Hold netdev->lock when NAPIs are getting added or removed.
This will allow safe access to NAPI instances of a net_device
without rtnl_lock.

Create a family of helpers which assume the lock is already taken.
Switch iavf to them, as it makes extensive use of netdev->lock,
already.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/netdevice.h                   | 54 ++++++++++++++++++---
 drivers/net/ethernet/intel/iavf/iavf_main.c |  6 +--
 net/core/dev.c                              | 15 ++++--
 3 files changed, 60 insertions(+), 15 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 565dfeb78774..9d0585a656b3 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2456,7 +2456,7 @@ struct net_device {
 	 * Drivers are free to use it for other protection.
 	 *
 	 * Protects:
-	 *	@net_shaper_hierarchy, @reg_state
+	 *	@napi_list, @net_shaper_hierarchy, @reg_state
 	 * Partially protects (readers hold either @lock or rtnl_lock,
 	 * writers must hold both for registered devices):
 	 *	@up
@@ -2711,8 +2711,19 @@ static inline void netif_napi_set_irq(struct napi_struct *napi, int irq)
  */
 #define NAPI_POLL_WEIGHT 64
 
-void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
-			   int (*poll)(struct napi_struct *, int), int weight);
+void netif_napi_add_weight_locked(struct net_device *dev,
+				  struct napi_struct *napi,
+				  int (*poll)(struct napi_struct *, int),
+				  int weight);
+
+static inline void
+netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
+		      int (*poll)(struct napi_struct *, int), int weight)
+{
+	netdev_lock(dev);
+	netif_napi_add_weight_locked(dev, napi, poll, weight);
+	netdev_unlock(dev);
+}
 
 /**
  * netif_napi_add() - initialize a NAPI context
@@ -2730,6 +2741,13 @@ netif_napi_add(struct net_device *dev, struct napi_struct *napi,
 	netif_napi_add_weight(dev, napi, poll, NAPI_POLL_WEIGHT);
 }
 
+static inline void
+netif_napi_add_locked(struct net_device *dev, struct napi_struct *napi,
+		      int (*poll)(struct napi_struct *, int))
+{
+	netif_napi_add_weight_locked(dev, napi, poll, NAPI_POLL_WEIGHT);
+}
+
 static inline void
 netif_napi_add_tx_weight(struct net_device *dev,
 			 struct napi_struct *napi,
@@ -2740,6 +2758,15 @@ netif_napi_add_tx_weight(struct net_device *dev,
 	netif_napi_add_weight(dev, napi, poll, weight);
 }
 
+static inline void
+netif_napi_add_config_locked(struct net_device *dev, struct napi_struct *napi,
+			     int (*poll)(struct napi_struct *, int), int index)
+{
+	napi->index = index;
+	napi->config = &dev->napi_config[index];
+	netif_napi_add_weight_locked(dev, napi, poll, NAPI_POLL_WEIGHT);
+}
+
 /**
  * netif_napi_add_config - initialize a NAPI context with persistent config
  * @dev: network device
@@ -2751,9 +2778,9 @@ static inline void
 netif_napi_add_config(struct net_device *dev, struct napi_struct *napi,
 		      int (*poll)(struct napi_struct *, int), int index)
 {
-	napi->index = index;
-	napi->config = &dev->napi_config[index];
-	netif_napi_add_weight(dev, napi, poll, NAPI_POLL_WEIGHT);
+	netdev_lock(dev);
+	netif_napi_add_config_locked(dev, napi, poll, index);
+	netdev_unlock(dev);
 }
 
 /**
@@ -2773,6 +2800,8 @@ static inline void netif_napi_add_tx(struct net_device *dev,
 	netif_napi_add_tx_weight(dev, napi, poll, NAPI_POLL_WEIGHT);
 }
 
+void __netif_napi_del_locked(struct napi_struct *napi);
+
 /**
  *  __netif_napi_del - remove a NAPI context
  *  @napi: NAPI context
@@ -2781,7 +2810,18 @@ static inline void netif_napi_add_tx(struct net_device *dev,
  * containing @napi. Drivers might want to call this helper to combine
  * all the needed RCU grace periods into a single one.
  */
-void __netif_napi_del(struct napi_struct *napi);
+static inline void __netif_napi_del(struct napi_struct *napi)
+{
+	netdev_lock(napi->dev);
+	__netif_napi_del_locked(napi);
+	netdev_unlock(napi->dev);
+}
+
+static inline void netif_napi_del_locked(struct napi_struct *napi)
+{
+	__netif_napi_del_locked(napi);
+	synchronize_net();
+}
 
 /**
  *  netif_napi_del - remove a NAPI context
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index ab908d620285..2db97c5d9f9e 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1800,8 +1800,8 @@ static int iavf_alloc_q_vectors(struct iavf_adapter *adapter)
 		q_vector->v_idx = q_idx;
 		q_vector->reg_idx = q_idx;
 		cpumask_copy(&q_vector->affinity_mask, cpu_possible_mask);
-		netif_napi_add(adapter->netdev, &q_vector->napi,
-			       iavf_napi_poll);
+		netif_napi_add_locked(adapter->netdev, &q_vector->napi,
+				      iavf_napi_poll);
 	}
 
 	return 0;
@@ -1827,7 +1827,7 @@ static void iavf_free_q_vectors(struct iavf_adapter *adapter)
 	for (q_idx = 0; q_idx < num_q_vectors; q_idx++) {
 		struct iavf_q_vector *q_vector = &adapter->q_vectors[q_idx];
 
-		netif_napi_del(&q_vector->napi);
+		netif_napi_del_locked(&q_vector->napi);
 	}
 	kfree(adapter->q_vectors);
 	adapter->q_vectors = NULL;
diff --git a/net/core/dev.c b/net/core/dev.c
index 1a05ad60b89f..6d9cb1b80a17 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6909,9 +6909,12 @@ netif_napi_dev_list_add(struct net_device *dev, struct napi_struct *napi)
 	list_add_rcu(&napi->dev_list, higher); /* adds after higher */
 }
 
-void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
-			   int (*poll)(struct napi_struct *, int), int weight)
+void netif_napi_add_weight_locked(struct net_device *dev,
+				  struct napi_struct *napi,
+				  int (*poll)(struct napi_struct *, int),
+				  int weight)
 {
+	netdev_assert_locked(dev);
 	if (WARN_ON(test_and_set_bit(NAPI_STATE_LISTED, &napi->state)))
 		return;
 
@@ -6952,7 +6955,7 @@ void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
 		dev->threaded = false;
 	netif_napi_set_irq(napi, -1);
 }
-EXPORT_SYMBOL(netif_napi_add_weight);
+EXPORT_SYMBOL(netif_napi_add_weight_locked);
 
 void napi_disable(struct napi_struct *n)
 {
@@ -7023,8 +7026,10 @@ static void flush_gro_hash(struct napi_struct *napi)
 }
 
 /* Must be called in process context */
-void __netif_napi_del(struct napi_struct *napi)
+void __netif_napi_del_locked(struct napi_struct *napi)
 {
+	netdev_assert_locked(napi->dev);
+
 	if (!test_and_clear_bit(NAPI_STATE_LISTED, &napi->state))
 		return;
 
@@ -7044,7 +7049,7 @@ void __netif_napi_del(struct napi_struct *napi)
 		napi->thread = NULL;
 	}
 }
-EXPORT_SYMBOL(__netif_napi_del);
+EXPORT_SYMBOL(__netif_napi_del_locked);
 
 static int __napi_poll(struct napi_struct *n, bool *repoll)
 {
-- 
2.47.1


