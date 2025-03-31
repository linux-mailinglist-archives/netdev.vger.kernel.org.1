Return-Path: <netdev+bounces-178399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F24FBA76D90
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 21:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19A6D7A2ECE
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 19:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882E9215067;
	Mon, 31 Mar 2025 19:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqEcjKpw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644311B4138
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 19:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743450187; cv=none; b=joXXb9plVqXdhJz8HTWMunl2pTzBfS5IYNAxPQh/BjNWJXLvB3xq5ftLc1+Nwq6PJr5yscasRLbc5dMCDPxnnQyg2U96OWsrNe7XWTD06MywfJWncYwjsfoEAO9KAkPkf4v81V3nE+8e97e5iljrtzb0gHa8XEg0lns/5Wwa7rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743450187; c=relaxed/simple;
	bh=UaQ9rShvlbZRVzcFsikINqmNxUiys/Aao292bRb7+is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ICrEEgqJgIYdRzXkwgpKO7aktBaVfEIOCNCDpV8e5M7JS2HvsKFL4tqnVy0QAlKnSwXILLlo6bQw8OjjTNLuh0Ucq5Yhfodi0q+MdIGZJzZiNZVc1eNtx+Tv8ESzmdsMByzgNtlPd3MWbY3PBa+dJ2eVYskfo3na1C416ZGPMBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqEcjKpw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76825C4CEE3;
	Mon, 31 Mar 2025 19:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743450185;
	bh=UaQ9rShvlbZRVzcFsikINqmNxUiys/Aao292bRb7+is=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gqEcjKpwLlI+czPHLZXXFPf81FNwLX9WmduI+tmxoieAYaPlKWR8gcfpz0wAir3Cf
	 ZBpAY4sF63jE3GRUuc+Dk82Nqz9JM33gKWQcPBkk9Hg4ddoCMgJFZnWfQwJOMvC5JR
	 nhRSz0ubpnJXiMxmCeHm43Jg+2miXmyAogyZl/EbL04x/BS9FWVsfMD4zlurJaYxsR
	 Z6XZLh4diWOct6PDExRnnInOZ0SE10vNKHQRhBn+592gybCffAABjsjMkZUqKq141I
	 BgQg0tiK7GKIcNF7W6qYg8YxQ+RP68VD22r2XQE/wSTTx4GBqJKOrLYfjx0SbGmIbs
	 DUPOgbIFIkphA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	ap420073@gmail.com,
	asml.silence@gmail.com,
	almasrymina@google.com,
	dw@davidwei.uk,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 1/2] net: move mp dev config validation to __net_mp_open_rxq()
Date: Mon, 31 Mar 2025 12:43:03 -0700
Message-ID: <20250331194303.2026903-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250331194201.2026422-1-kuba@kernel.org>
References: <20250331194201.2026422-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devmem code performs a number of safety checks to avoid having
to reimplement all of them in the drivers. Move those to
__net_mp_open_rxq() and reuse that function for binding to make
sure that io_uring ZC also benefits from them.

While at it rename the queue ID variable to rxq_idx in
__net_mp_open_rxq(), we touch most of the relevant lines.

Fixes: 6e18ed929d3b ("net: add helpers for setting a memory provider on an rx queue")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: ap420073@gmail.com
CC: almasrymina@google.com
CC: asml.silence@gmail.com
CC: dw@davidwei.uk
CC: sdf@fomichev.me
---
 include/net/page_pool/memory_provider.h |  6 +++
 net/core/devmem.c                       | 52 ++++++-------------------
 net/core/netdev-genl.c                  |  6 ---
 net/core/netdev_rx_queue.c              | 49 +++++++++++++++++------
 4 files changed, 55 insertions(+), 58 deletions(-)

diff --git a/include/net/page_pool/memory_provider.h b/include/net/page_pool/memory_provider.h
index b3e665897767..3724ac3c9fb2 100644
--- a/include/net/page_pool/memory_provider.h
+++ b/include/net/page_pool/memory_provider.h
@@ -6,6 +6,7 @@
 #include <net/page_pool/types.h>
 
 struct netdev_rx_queue;
+struct netlink_ext_ack;
 struct sk_buff;
 
 struct memory_provider_ops {
@@ -24,8 +25,13 @@ void net_mp_niov_clear_page_pool(struct net_iov *niov);
 
 int net_mp_open_rxq(struct net_device *dev, unsigned ifq_idx,
 		    struct pp_memory_provider_params *p);
+int __net_mp_open_rxq(struct net_device *dev, unsigned int ifq_idx,
+		      const struct pp_memory_provider_params *p,
+		      struct netlink_ext_ack *extack);
 void net_mp_close_rxq(struct net_device *dev, unsigned ifq_idx,
 		      struct pp_memory_provider_params *old_p);
+void __net_mp_close_rxq(struct net_device *dev, unsigned int ifq_idx,
+			const struct pp_memory_provider_params *old_p);
 
 /**
   * net_mp_netmem_place_in_cache() - give a netmem to a page pool
diff --git a/net/core/devmem.c b/net/core/devmem.c
index ee145a2aa41c..f2ce3c2ebc97 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -8,7 +8,6 @@
  */
 
 #include <linux/dma-buf.h>
-#include <linux/ethtool_netlink.h>
 #include <linux/genalloc.h>
 #include <linux/mm.h>
 #include <linux/netdevice.h>
@@ -143,57 +142,28 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 				    struct net_devmem_dmabuf_binding *binding,
 				    struct netlink_ext_ack *extack)
 {
+	struct pp_memory_provider_params mp_params = {
+		.mp_priv	= binding,
+		.mp_ops		= &dmabuf_devmem_ops,
+	};
 	struct netdev_rx_queue *rxq;
 	u32 xa_idx;
 	int err;
 
-	if (rxq_idx >= dev->real_num_rx_queues) {
-		NL_SET_ERR_MSG(extack, "rx queue index out of range");
-		return -ERANGE;
-	}
-
-	if (dev->cfg->hds_config != ETHTOOL_TCP_DATA_SPLIT_ENABLED) {
-		NL_SET_ERR_MSG(extack, "tcp-data-split is disabled");
-		return -EINVAL;
-	}
-
-	if (dev->cfg->hds_thresh) {
-		NL_SET_ERR_MSG(extack, "hds-thresh is not zero");
-		return -EINVAL;
-	}
-
-	rxq = __netif_get_rx_queue(dev, rxq_idx);
-	if (rxq->mp_params.mp_ops) {
-		NL_SET_ERR_MSG(extack, "designated queue already memory provider bound");
-		return -EEXIST;
-	}
-
-#ifdef CONFIG_XDP_SOCKETS
-	if (rxq->pool) {
-		NL_SET_ERR_MSG(extack, "designated queue already in use by AF_XDP");
-		return -EBUSY;
-	}
-#endif
-
-	err = xa_alloc(&binding->bound_rxqs, &xa_idx, rxq, xa_limit_32b,
-		       GFP_KERNEL);
+	err = __net_mp_open_rxq(dev, rxq_idx, &mp_params, extack);
 	if (err)
 		return err;
 
-	rxq->mp_params.mp_priv = binding;
-	rxq->mp_params.mp_ops = &dmabuf_devmem_ops;
-
-	err = netdev_rx_queue_restart(dev, rxq_idx);
+	rxq = __netif_get_rx_queue(dev, rxq_idx);
+	err = xa_alloc(&binding->bound_rxqs, &xa_idx, rxq, xa_limit_32b,
+		       GFP_KERNEL);
 	if (err)
-		goto err_xa_erase;
+		goto err_close_rxq;
 
 	return 0;
 
-err_xa_erase:
-	rxq->mp_params.mp_priv = NULL;
-	rxq->mp_params.mp_ops = NULL;
-	xa_erase(&binding->bound_rxqs, xa_idx);
-
+err_close_rxq:
+	__net_mp_close_rxq(dev, rxq_idx, &mp_params);
 	return err;
 }
 
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index fd1cfa9707dc..8ad4a944f368 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -874,12 +874,6 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_unlock;
 	}
 
-	if (dev_xdp_prog_count(netdev)) {
-		NL_SET_ERR_MSG(info->extack, "unable to bind dmabuf to device with XDP program attached");
-		err = -EEXIST;
-		goto err_unlock;
-	}
-
 	binding = net_devmem_bind_dmabuf(netdev, dmabuf_fd, info->extack);
 	if (IS_ERR(binding)) {
 		err = PTR_ERR(binding);
diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index 3af716f77a13..556b5393ec9f 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
+#include <linux/ethtool_netlink.h>
 #include <linux/netdevice.h>
 #include <net/netdev_lock.h>
 #include <net/netdev_queues.h>
@@ -86,8 +87,9 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 }
 EXPORT_SYMBOL_NS_GPL(netdev_rx_queue_restart, "NETDEV_INTERNAL");
 
-static int __net_mp_open_rxq(struct net_device *dev, unsigned ifq_idx,
-			     struct pp_memory_provider_params *p)
+int __net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
+		      const struct pp_memory_provider_params *p,
+		      struct netlink_ext_ack *extack)
 {
 	struct netdev_rx_queue *rxq;
 	int ret;
@@ -95,16 +97,41 @@ static int __net_mp_open_rxq(struct net_device *dev, unsigned ifq_idx,
 	if (!netdev_need_ops_lock(dev))
 		return -EOPNOTSUPP;
 
-	if (ifq_idx >= dev->real_num_rx_queues)
+	if (rxq_idx >= dev->real_num_rx_queues)
 		return -EINVAL;
-	ifq_idx = array_index_nospec(ifq_idx, dev->real_num_rx_queues);
+	rxq_idx = array_index_nospec(rxq_idx, dev->real_num_rx_queues);
 
-	rxq = __netif_get_rx_queue(dev, ifq_idx);
-	if (rxq->mp_params.mp_ops)
+	if (rxq_idx >= dev->real_num_rx_queues) {
+		NL_SET_ERR_MSG(extack, "rx queue index out of range");
+		return -ERANGE;
+	}
+	if (dev->cfg->hds_config != ETHTOOL_TCP_DATA_SPLIT_ENABLED) {
+		NL_SET_ERR_MSG(extack, "tcp-data-split is disabled");
+		return -EINVAL;
+	}
+	if (dev->cfg->hds_thresh) {
+		NL_SET_ERR_MSG(extack, "hds-thresh is not zero");
+		return -EINVAL;
+	}
+	if (dev_xdp_prog_count(dev)) {
+		NL_SET_ERR_MSG(extack, "unable to custom memory provider to device with XDP program attached");
 		return -EEXIST;
+	}
+
+	rxq = __netif_get_rx_queue(dev, rxq_idx);
+	if (rxq->mp_params.mp_ops) {
+		NL_SET_ERR_MSG(extack, "designated queue already memory provider bound");
+		return -EEXIST;
+	}
+#ifdef CONFIG_XDP_SOCKETS
+	if (rxq->pool) {
+		NL_SET_ERR_MSG(extack, "designated queue already in use by AF_XDP");
+		return -EBUSY;
+	}
+#endif
 
 	rxq->mp_params = *p;
-	ret = netdev_rx_queue_restart(dev, ifq_idx);
+	ret = netdev_rx_queue_restart(dev, rxq_idx);
 	if (ret) {
 		rxq->mp_params.mp_ops = NULL;
 		rxq->mp_params.mp_priv = NULL;
@@ -112,19 +139,19 @@ static int __net_mp_open_rxq(struct net_device *dev, unsigned ifq_idx,
 	return ret;
 }
 
-int net_mp_open_rxq(struct net_device *dev, unsigned ifq_idx,
+int net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
 		    struct pp_memory_provider_params *p)
 {
 	int ret;
 
 	netdev_lock(dev);
-	ret = __net_mp_open_rxq(dev, ifq_idx, p);
+	ret = __net_mp_open_rxq(dev, rxq_idx, p, NULL);
 	netdev_unlock(dev);
 	return ret;
 }
 
-static void __net_mp_close_rxq(struct net_device *dev, unsigned ifq_idx,
-			      struct pp_memory_provider_params *old_p)
+void __net_mp_close_rxq(struct net_device *dev, unsigned int ifq_idx,
+			const struct pp_memory_provider_params *old_p)
 {
 	struct netdev_rx_queue *rxq;
 
-- 
2.49.0


