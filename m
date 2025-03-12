Return-Path: <netdev+bounces-174400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5533FA5E789
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 23:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1F203ACA6D
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 22:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17771F0E54;
	Wed, 12 Mar 2025 22:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pRdpt3mt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFD71F0E51
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 22:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741818935; cv=none; b=sNX6v432E4e0XJ4JMXATwRZLO2gAJc9ZbcuqUsbmWRiuQRZdue/XF9xEncBoIpokLNFXdhODLol1PmC690/aopj9J5WT+yV6OUgdOdATA3Wpoz4ZzVRfmTFnKPrHQnI9nOl/1K9glHbHPZf+EfbefDegjtYmQnQt+vkQ3mLJC8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741818935; c=relaxed/simple;
	bh=l07BTBACX/w8O/b9xOZb3065+hBiDYS2A4dopmh/V48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j6GF3QSlFkQ0w11b88wuRtFS7JgqMvHOqITDXvHfxqIovQAqOHU5hpUnNct0gDpE8I4iz7+H1uLjpOOO2cu+NALcH3oPbRYzTH4jmYlJWwijit02Oa/F9eEolVvqzagnRRmHbDgnixQSFjuitRd4EKwvwCAJNMaK/FsG+GLt4a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pRdpt3mt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599C9C4CEDD;
	Wed, 12 Mar 2025 22:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741818935;
	bh=l07BTBACX/w8O/b9xOZb3065+hBiDYS2A4dopmh/V48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pRdpt3mtW8VabyM51wM91PkyFJ693JJFG5/cY0voV+vwWE1CfcXw0+c5G4Bm8ydg8
	 mpGigKvFN3wq+3GPU5K7CVmivafAvI22QP4p2NZoWB/MMGZwWS2yuiDJBtok6ZIxPe
	 omCD7YmpNFIDX/lUkHw0TKBCKl0ZkyfZRCnjF8AEobe45lreCSk8zqctaeAxwDiv3n
	 QYci0cdZo7+lOrrKUBkwKnMblgo83SfIEo1J2iMPfvkHM0Ff+yhBJOspT8PXYUel+7
	 tpLXYUf4HfxilRche1u08/URX3sXLeqPepoTuQEKKLS5ModRnoc8jYsTNrf6YAtCpj
	 fSND8WF+xZzKQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 07/11] net: protect rxq->mp_params with the instance lock
Date: Wed, 12 Mar 2025 23:35:03 +0100
Message-ID: <20250312223507.805719-8-kuba@kernel.org>
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

Ensure that all accesses to mp_params are under the netdev
instance lock. The only change we need is to move
dev_memory_provider_uninstall() under the lock.

Appropriately swap the asserts.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/core/dev.c       | 4 ++--
 net/core/page_pool.c | 7 ++-----
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 8f30938ed402..ded6ffbda965 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10334,7 +10334,7 @@ u32 dev_get_min_mp_channel_count(const struct net_device *dev)
 {
 	int i;
 
-	ASSERT_RTNL();
+	netdev_ops_assert_locked(dev);
 
 	for (i = dev->real_num_rx_queues - 1; i >= 0; i--)
 		if (dev->_rx[i].mp_params.mp_priv)
@@ -11938,9 +11938,9 @@ void unregister_netdevice_many_notify(struct list_head *head,
 		dev_tcx_uninstall(dev);
 		netdev_lock_ops(dev);
 		dev_xdp_uninstall(dev);
+		dev_memory_provider_uninstall(dev);
 		netdev_unlock_ops(dev);
 		bpf_dev_bound_netdev_unregister(dev);
-		dev_memory_provider_uninstall(dev);
 
 		netdev_offload_xstats_disable_all(dev);
 
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index acef1fcd8ddc..7745ad924ae2 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -11,6 +11,7 @@
 #include <linux/slab.h>
 #include <linux/device.h>
 
+#include <net/netdev_lock.h>
 #include <net/netdev_rx_queue.h>
 #include <net/page_pool/helpers.h>
 #include <net/page_pool/memory_provider.h>
@@ -279,11 +280,7 @@ static int page_pool_init(struct page_pool *pool,
 		get_device(pool->p.dev);
 
 	if (pool->slow.flags & PP_FLAG_ALLOW_UNREADABLE_NETMEM) {
-		/* We rely on rtnl_lock()ing to make sure netdev_rx_queue
-		 * configuration doesn't change while we're initializing
-		 * the page_pool.
-		 */
-		ASSERT_RTNL();
+		netdev_assert_locked(pool->slow.netdev);
 		rxq = __netif_get_rx_queue(pool->slow.netdev,
 					   pool->slow.queue_idx);
 		pool->mp_priv = rxq->mp_params.mp_priv;
-- 
2.48.1


