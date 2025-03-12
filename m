Return-Path: <netdev+bounces-174395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 087F9A5E783
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 23:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91ECA189A0DD
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 22:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC2D1F0E43;
	Wed, 12 Mar 2025 22:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JeG+WeJN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01FC1DFD95
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 22:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741818923; cv=none; b=B3YK295BhYJ1LFYaCfYay9T2L0ocyrHuv+dZE0kJzHErnuqMam7I6oa96QMOYOV4DJeqnx0lBIcMvon+WraaRyCLCwuJGw78yzrOxR/A8u7rNI9w4qzUqaBUGcyEVwpWT6jP0ya4liGmQu4+G/DBczFuCHaEi7cSQl7RYN9ithw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741818923; c=relaxed/simple;
	bh=fU29yfcICr0i7WPZOez/rsw4Cxi+HOfiazZsiZQuRe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LlBfyGGwb5w+UrsA0Vb1FcFkU9EC0qMzlmRXV407bZeCMJyuIdSefJuJonvk5IaK8+2f4h1ivCyTXTvOye9wfN1qm/MKBZmvhJhXtE45Xfk6kiiAyUWIrDsTdFb76gIWQI1vcElqgOlb4hr3jjSilu2xFpzzeqRyDZEX1nkKlCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JeG+WeJN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAEFBC4CEDD;
	Wed, 12 Mar 2025 22:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741818922;
	bh=fU29yfcICr0i7WPZOez/rsw4Cxi+HOfiazZsiZQuRe4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JeG+WeJNa9W4ttPuvMwzY7jBKFJG7zL2QhWFbd/fWSArttAKdrObRasZc4PT9Jp6V
	 3Knld+EQ2gVW49QgiUdSZO/24AIjeKfxpApHCoOHKzTq58AG6V+akp9xB9hzzTSu1F
	 +5eLjjvStZnIMuOPGGjNUQLy4FfZPBLBUP/IOf1nsJ5j4ETkuezSjwdEiggcsJ8k7U
	 POfgt7Sf55I/A0e2aKh8w267LljW2WjAITk+m8SXfR3zCn2yzuhEay93BWVc3GcYiT
	 S5gBhEyiFDdH26xt2gc6z63Vt9LWImFYfwrqCJJy5oMyczktB2fvsCrPquvdOcoxKv
	 v9tXtblXFueNw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 02/11] net: remove netif_set_real_num_rx_queues() helper for when SYSFS=n
Date: Wed, 12 Mar 2025 23:34:58 +0100
Message-ID: <20250312223507.805719-3-kuba@kernel.org>
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

Since commit a953be53ce40 ("net-sysfs: add support for device-specific
rx queue sysfs attributes"), so for at least a decade now it is safe
to call net_rx_queue_update_kobjects() when SYSFS=n. That function
does its own ifdef-inery and will return 0. Remove the unnecessary
stub for netif_set_real_num_rx_queues().

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/netdevice.h | 10 ----------
 net/core/dev.c            |  2 --
 2 files changed, 12 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0dbfe069a6e3..2f344d5ad953 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4062,17 +4062,7 @@ static inline bool netif_is_multiqueue(const struct net_device *dev)
 }
 
 int netif_set_real_num_tx_queues(struct net_device *dev, unsigned int txq);
-
-#ifdef CONFIG_SYSFS
 int netif_set_real_num_rx_queues(struct net_device *dev, unsigned int rxq);
-#else
-static inline int netif_set_real_num_rx_queues(struct net_device *dev,
-						unsigned int rxqs)
-{
-	dev->real_num_rx_queues = rxqs;
-	return 0;
-}
-#endif
 int netif_set_real_num_queues(struct net_device *dev,
 			      unsigned int txq, unsigned int rxq);
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 0bf5af9706b1..3f35f3f8b2f1 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3162,7 +3162,6 @@ int netif_set_real_num_tx_queues(struct net_device *dev, unsigned int txq)
 }
 EXPORT_SYMBOL(netif_set_real_num_tx_queues);
 
-#ifdef CONFIG_SYSFS
 /**
  *	netif_set_real_num_rx_queues - set actual number of RX queues used
  *	@dev: Network device
@@ -3193,7 +3192,6 @@ int netif_set_real_num_rx_queues(struct net_device *dev, unsigned int rxq)
 	return 0;
 }
 EXPORT_SYMBOL(netif_set_real_num_rx_queues);
-#endif
 
 /**
  *	netif_set_real_num_queues - set actual number of RX and TX queues used
-- 
2.48.1


