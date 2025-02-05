Return-Path: <netdev+bounces-163216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FC7A299A3
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 20:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0B3E168B75
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 19:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4791FECD4;
	Wed,  5 Feb 2025 19:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5e2/QkX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098101FDA8A
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 19:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738782112; cv=none; b=sGQupcxQm/TaVMieU9DAo5v6PVn0ohUYPIQSJQ90VhQFzl2Wtk9ClBB/V2LrXYVrE8XfyWvfXc5XjgTFfnizthGMWaBz4f7wMXEu9twUCtRzDFWrBuqkPn1j3hR+zEq3wzFqIA21odW2B379ci+XF/p/FzEbapCKsJIQTBznc1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738782112; c=relaxed/simple;
	bh=/B7IRCyXsg7eaxH7DTtqwWtUJl7ouEXyji5+0llCgHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G9rz52TxjUlLXPlxUAKT4w+zMI3Pn+O8E+kDkOYb20XYtE0XQTaoJB5mLq+nIVjX0HVloDvoDvEFss7YUFIXtip3kTPpgG8XLE/gCA/9i2kPBnR7/WlsVS0F7I7/cS5m8yTYDaOiBReH5LG+CQjXyZjAU3ZJ3FFJbdqr1qGwjl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5e2/QkX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34AC3C4CEDD;
	Wed,  5 Feb 2025 19:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738782111;
	bh=/B7IRCyXsg7eaxH7DTtqwWtUJl7ouEXyji5+0llCgHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l5e2/QkXPz1+JYzWHNMS+Ag46dvQiVVPhK2gsJ6a/j95yM0d1aDze45akwc30qXfG
	 aY9ASn9LC5lsd8JQtC4Pgm5DO2bTPblCmVFAooRs4ftw7zqfparZ4X2EJo5kA/dm/u
	 tiHk33Gp3Yj1Ll3XGeJe8qwJtugAls1pzs/sKnh3Rl2NwXkIrP08GFvtoKS8mgr5dY
	 D2oQnA/r/QH9uwyMaQJe3qoiE/0tO3B2BidGApvBTQNjPBs40lJYEJbY6YjIl/xj3N
	 YzpaPQdluOHbn/MwhkTQ3tRwiDjm9eLgj0Apc8sq0RbecA7gVbluhiBOvQUlMrG8S9
	 0nsnkReHOK+BA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	almasrymina@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/3] net: refactor netdev_rx_queue_restart() to use local qops
Date: Wed,  5 Feb 2025 11:01:29 -0800
Message-ID: <20250205190131.564456-2-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205190131.564456-1-kuba@kernel.org>
References: <20250205190131.564456-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Shorten the lines by storing dev->queue_mgmt_ops in a temp variable.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/core/netdev_rx_queue.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index db82786fa0c4..a5813d50e058 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -9,28 +9,27 @@
 int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 {
 	struct netdev_rx_queue *rxq = __netif_get_rx_queue(dev, rxq_idx);
+	const struct netdev_queue_mgmt_ops *qops = dev->queue_mgmt_ops;
 	void *new_mem, *old_mem;
 	int err;
 
-	if (!dev->queue_mgmt_ops || !dev->queue_mgmt_ops->ndo_queue_stop ||
-	    !dev->queue_mgmt_ops->ndo_queue_mem_free ||
-	    !dev->queue_mgmt_ops->ndo_queue_mem_alloc ||
-	    !dev->queue_mgmt_ops->ndo_queue_start)
+	if (!qops || !qops->ndo_queue_stop || !qops->ndo_queue_mem_free ||
+	    !qops->ndo_queue_mem_alloc || !qops->ndo_queue_start)
 		return -EOPNOTSUPP;
 
 	ASSERT_RTNL();
 
-	new_mem = kvzalloc(dev->queue_mgmt_ops->ndo_queue_mem_size, GFP_KERNEL);
+	new_mem = kvzalloc(qops->ndo_queue_mem_size, GFP_KERNEL);
 	if (!new_mem)
 		return -ENOMEM;
 
-	old_mem = kvzalloc(dev->queue_mgmt_ops->ndo_queue_mem_size, GFP_KERNEL);
+	old_mem = kvzalloc(qops->ndo_queue_mem_size, GFP_KERNEL);
 	if (!old_mem) {
 		err = -ENOMEM;
 		goto err_free_new_mem;
 	}
 
-	err = dev->queue_mgmt_ops->ndo_queue_mem_alloc(dev, new_mem, rxq_idx);
+	err = qops->ndo_queue_mem_alloc(dev, new_mem, rxq_idx);
 	if (err)
 		goto err_free_old_mem;
 
@@ -38,15 +37,15 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 	if (err)
 		goto err_free_new_queue_mem;
 
-	err = dev->queue_mgmt_ops->ndo_queue_stop(dev, old_mem, rxq_idx);
+	err = qops->ndo_queue_stop(dev, old_mem, rxq_idx);
 	if (err)
 		goto err_free_new_queue_mem;
 
-	err = dev->queue_mgmt_ops->ndo_queue_start(dev, new_mem, rxq_idx);
+	err = qops->ndo_queue_start(dev, new_mem, rxq_idx);
 	if (err)
 		goto err_start_queue;
 
-	dev->queue_mgmt_ops->ndo_queue_mem_free(dev, old_mem);
+	qops->ndo_queue_mem_free(dev, old_mem);
 
 	kvfree(old_mem);
 	kvfree(new_mem);
@@ -61,15 +60,15 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 	 * WARN if we fail to recover the old rx queue, and at least free
 	 * old_mem so we don't also leak that.
 	 */
-	if (dev->queue_mgmt_ops->ndo_queue_start(dev, old_mem, rxq_idx)) {
+	if (qops->ndo_queue_start(dev, old_mem, rxq_idx)) {
 		WARN(1,
 		     "Failed to restart old queue in error path. RX queue %d may be unhealthy.",
 		     rxq_idx);
-		dev->queue_mgmt_ops->ndo_queue_mem_free(dev, old_mem);
+		qops->ndo_queue_mem_free(dev, old_mem);
 	}
 
 err_free_new_queue_mem:
-	dev->queue_mgmt_ops->ndo_queue_mem_free(dev, new_mem);
+	qops->ndo_queue_mem_free(dev, new_mem);
 
 err_free_old_mem:
 	kvfree(old_mem);
-- 
2.48.1


