Return-Path: <netdev+bounces-178945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 645DCA799B9
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 03:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA3B0171155
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 01:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83E07D3F4;
	Thu,  3 Apr 2025 01:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTSjT9eM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937AC8460
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 01:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743644051; cv=none; b=K9PAPlzCm5jssangzXkMPixf16UErqmLyk95rHSOhOzVFCCCu/0kNxnpvGFMK4voOapxtjH8HieC8sNZyoYkUyFXf1XPOA8IRHrtP2xtWKdQl6K54PlszMxqsmonTDMjDoa2D6YNU/jYwFPcplJec/dJM8pBatDpO7RCGm1b/8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743644051; c=relaxed/simple;
	bh=A//hy07M3wXTn3Xwf7TcbZ4f/KvNiHSMlmyhkVzRr+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ILgMRR17teissFgk9OAMTVFpiKIgv2szv7RmOx4kZYJ8ea2hCnR5BJfstybetBrqlAGwRnBOKvg3sWMesfJIxnbKsqjGsjxHVSvlGmPhIfrmFC1hGWhe8x1cBR6fS3BNdd4hCpAK5OuSZgD32qhux6gZ/Wi19G3eJ00CGH06XsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTSjT9eM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F35FC4AF09;
	Thu,  3 Apr 2025 01:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743644051;
	bh=A//hy07M3wXTn3Xwf7TcbZ4f/KvNiHSMlmyhkVzRr+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FTSjT9eMxBLPZgKdmLI1T+wCBmXCDe/IuAf67tktx7Sdkwjz55LcMwbvyhddIo6OW
	 SEk70L8EipqSZWFKcou59FkNEIH5QmCuLZA/xmygCQ46kY6CBmByF68cBHExdcCTyp
	 miN+RU5XnizZUo9HnKW2fVcxiuF7MSxsMQQs3Vy5KuCAKbEohKlefgUN0IOtv+uSF3
	 aIfHz7LC7G/QPv304pUG2A8/wXCzXidDQqs9b41jiw94RxsTqCHvlug9136Sc1UTM1
	 +wvBRn3tY/cbz3RQfJqu0cAVvIikmgE4eLlCbZQorxifS+UkcQOOCq4mpFYlKvuUe1
	 xhznTVNM1hBdg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	ap420073@gmail.com,
	almasrymina@google.com,
	asml.silence@gmail.com,
	dw@davidwei.uk,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net v2 1/2] net: move mp dev config validation to __net_mp_open_rxq()
Date: Wed,  2 Apr 2025 18:34:04 -0700
Message-ID: <20250403013405.2827250-2-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250403013405.2827250-1-kuba@kernel.org>
References: <20250403013405.2827250-1-kuba@kernel.org>
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

The XArray insertion is reordered after the netdev_rx_queue_restart()
call, otherwise we'd need to duplicate the queue index check
or risk inserting an invalid pointer. The XArray allocation
failures should be extremely rare.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Fixes: 6e18ed929d3b ("net: add helpers for setting a memory provider on an rx queue")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - add to commit msg
 - fix arg naming in the header (Stan)
v1: https://lore.kernel.org/20250331194303.2026903-1-kuba@kernel.org

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
index b3e665897767..ada4f968960a 100644
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
+int __net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
+		      const struct pp_memory_provider_params *p,
+		      struct netlink_ext_ack *extack);
 void net_mp_close_rxq(struct net_device *dev, unsigned ifq_idx,
 		      struct pp_memory_provider_params *old_p);
+void __net_mp_close_rxq(struct net_device *dev, unsigned int rxq_idx,
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
index 3afeaa8c5dc5..5d7af50fe702 100644
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


