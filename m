Return-Path: <netdev+bounces-184461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B2CA95968
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 00:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCA44176375
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 22:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9020E228CBE;
	Mon, 21 Apr 2025 22:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="reQg2Cnf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B14F21A435
	for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 22:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745274522; cv=none; b=h9xZjfm7ZM04mWrW0qih2tQ1DYZ+bQsP0Ca5qwUyvw1eGQ1RUPofQX2vQ3Jyhe9V/OIkCmjmdKbxdw+9Ydqbof1auSm/RJ11EnT2g1ZjHUNr5A/Uw6cHHqJbH4P1nQRaHP7Z9BWBOav1ijgrTVUmXaErvA6uTPraLkjt1/QOLqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745274522; c=relaxed/simple;
	bh=gC8UGg4z9cypbdRYLDJXL4Z2N3Z/np8mbllr7DYfHrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hjA7wryxOZhCe7ATJgD0TtTO9hv5iz8I3oV3DizPopG/Ec1xI3LLhOBImZcWnGlAyDcj2o495LqrR9KWwNOJTpRr1BHqW7YcpxnA8ZIwLw65G5Wx2k0hYk/FGGZy+3pbQd5T7HXCnbrpdSdAA9RtnCjItX7tcJ+GM7QhGC7lYw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=reQg2Cnf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB61C4AF09;
	Mon, 21 Apr 2025 22:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745274521;
	bh=gC8UGg4z9cypbdRYLDJXL4Z2N3Z/np8mbllr7DYfHrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=reQg2CnfFm4Y82GAHDI5ahweXoV8XeJBPV1fUPcnm8QbvNXnjU2GZFyINtfeOi8rG
	 k1JRkqyD88JPIM5OKeWVp9zPvSjV7IFgokh+/GVrMdyi7FHCzjdrhAC48EXakh78dm
	 JztujoDkWa3RkQIQNnZxeEUcKiALaosW6G9Nk90IkgeFKuBhnBEUltk7HdWeJwt54O
	 hX6/FuUtbWUyFt6QneZ9gNnzOOzvY5eB9qYpQ6/M8rK9CPQBbQAi9F7yerOrl8ktNm
	 dIBZmQtIp5t9ShVmstTRym8xWj9kyifwdYlXMzDSIV0BBDMDEtvsc3XwaqWVhA24cc
	 DH17lwgAmXi9g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	sdf@fomichev.me,
	almasrymina@google.com,
	dw@davidwei.uk,
	asml.silence@gmail.com,
	ap420073@gmail.com,
	jdamato@fastly.com,
	dtatulea@nvidia.com,
	michael.chan@broadcom.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC net-next 12/22] net: pass extack to netdev_rx_queue_restart()
Date: Mon, 21 Apr 2025 15:28:17 -0700
Message-ID: <20250421222827.283737-13-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250421222827.283737-1-kuba@kernel.org>
References: <20250421222827.283737-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pass extack to netdev_rx_queue_restart(). Subsequent change will need it.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/net/netdev_rx_queue.h             | 3 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 +-
 drivers/net/netdevsim/netdev.c            | 2 +-
 net/core/netdev_rx_queue.c                | 7 ++++---
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
index 8cdcd138b33f..a7def1f94823 100644
--- a/include/net/netdev_rx_queue.h
+++ b/include/net/netdev_rx_queue.h
@@ -56,6 +56,7 @@ get_netdev_rx_queue_index(struct netdev_rx_queue *queue)
 	return index;
 }
 
-int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq);
+int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq,
+			    struct netlink_ext_ack *extack);
 
 #endif
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index fbbe02cefdf1..627132ce10df 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11443,7 +11443,7 @@ static void bnxt_irq_affinity_notify(struct irq_affinity_notify *notify,
 
 	netdev_lock(irq->bp->dev);
 	if (netif_running(irq->bp->dev)) {
-		err = netdev_rx_queue_restart(irq->bp->dev, irq->ring_nr);
+		err = netdev_rx_queue_restart(irq->bp->dev, irq->ring_nr, NULL);
 		if (err)
 			netdev_err(irq->bp->dev,
 				   "RX queue restart failed: err=%d\n", err);
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index a2aa85a85e0f..a9975985aa24 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -797,7 +797,7 @@ nsim_qreset_write(struct file *file, const char __user *data,
 	}
 
 	ns->rq_reset_mode = mode;
-	ret = netdev_rx_queue_restart(ns->netdev, queue);
+	ret = netdev_rx_queue_restart(ns->netdev, queue, NULL);
 	ns->rq_reset_mode = 0;
 	if (ret)
 		goto exit_unlock;
diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index d8a710db21cd..b0523eb44e10 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -10,7 +10,8 @@
 #include "dev.h"
 #include "page_pool_priv.h"
 
-int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
+int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx,
+			    struct netlink_ext_ack *extack)
 {
 	struct netdev_rx_queue *rxq = __netif_get_rx_queue(dev, rxq_idx);
 	const struct netdev_queue_mgmt_ops *qops = dev->queue_mgmt_ops;
@@ -136,7 +137,7 @@ int __net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
 #endif
 
 	rxq->mp_params = *p;
-	ret = netdev_rx_queue_restart(dev, rxq_idx);
+	ret = netdev_rx_queue_restart(dev, rxq_idx, extack);
 	if (ret) {
 		rxq->mp_params.mp_ops = NULL;
 		rxq->mp_params.mp_priv = NULL;
@@ -179,7 +180,7 @@ void __net_mp_close_rxq(struct net_device *dev, unsigned int ifq_idx,
 
 	rxq->mp_params.mp_ops = NULL;
 	rxq->mp_params.mp_priv = NULL;
-	err = netdev_rx_queue_restart(dev, ifq_idx);
+	err = netdev_rx_queue_restart(dev, ifq_idx, NULL);
 	WARN_ON(err && err != -ENETDOWN);
 }
 
-- 
2.49.0


