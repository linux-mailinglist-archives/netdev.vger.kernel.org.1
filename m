Return-Path: <netdev+bounces-163696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DBCA2B604
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 23:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1427F1629B0
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 22:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417B82417D6;
	Thu,  6 Feb 2025 22:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRV+ZXnq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5FB2417D5
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 22:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738882614; cv=none; b=D9zZvSAp30hjddgIVUKZDmCQLIdh/Crgj0qDY3SHmYxi43y0i3WGPTEXzu0v8oYcuEr4ocSFTp1q8UBHF8MgvXDm+p8Y9Hxwccf43M7Hz/514GN5qHGmTXNjoSAivQHq8ldUxuKyEH5smKjIVsZkReELQKb3dg4lX1cBqMvUEd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738882614; c=relaxed/simple;
	bh=/B7IRCyXsg7eaxH7DTtqwWtUJl7ouEXyji5+0llCgHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GBdkIt5XOnZjoNqUuOz3l3au1imJYVJpXzfBsoLNrg9PcstvE9of1EG4VWTtXU86OLMgUxW+jhbxcxuwC433unTGffJb91DrhLhaFi7u1oSnKZQcMr9O6Av7F6ODefmnQusJHfrG3PUrR25Oyfe7rIUgzxvWck1ygcB/NEkINEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRV+ZXnq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390D5C4CEDF;
	Thu,  6 Feb 2025 22:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738882612;
	bh=/B7IRCyXsg7eaxH7DTtqwWtUJl7ouEXyji5+0llCgHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MRV+ZXnq4S46vf4TL3jPO1BH4sWJHlM5hb6EWwdvKsGh9zqoW4IZ7TWhG/dltttFt
	 TY0gtc+Vlh+LbfqgtScerACULILgb0AsfkBsBkSkezDzqMw9Nh4N4IvHEG+fOK3oaj
	 CqgneawAu8n+13AhgGL43LEYBE7OvRYD3/2umSnU/p9LSDrIvcFm06Q66y14yRrdF4
	 UV9pyPpwoP4IScLN/vGIbPGn59VgUT63xr/D/j/xmTY/iD0yxOKzoBpWnKZKMSUWUx
	 OODJOx5/5hrzTev7OB0koyl/DYize1L17+rVxv1yV1X6iUkCwtM5B19xJ09qcSn6oD
	 RTXl9KoVntkow==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	almasrymina@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 1/4] net: refactor netdev_rx_queue_restart() to use local qops
Date: Thu,  6 Feb 2025 14:56:35 -0800
Message-ID: <20250206225638.1387810-2-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250206225638.1387810-1-kuba@kernel.org>
References: <20250206225638.1387810-1-kuba@kernel.org>
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


