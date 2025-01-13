Return-Path: <netdev+bounces-157563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D017EA0ACD5
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 01:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B19E93A587A
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 00:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC684C9F;
	Mon, 13 Jan 2025 00:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5zZG/5E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F05322E;
	Mon, 13 Jan 2025 00:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736728517; cv=none; b=PsVC9QbJd5Y3xjJ8uomLKY+D4/Ae2qdOJUNiwX37El6PeG2znWep5pusIsoR1xPVzXpNrpMmt0EoGpomsy6sU1MSoswcPOXvXiTIe7mVQbE9lb4/VFzF7tFxIQxRiGQx1zlKjU2PBln+HNa/8ypZLtbQ7FU1aP8iiKHqKJynzFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736728517; c=relaxed/simple;
	bh=OM6yPd8qpn0P82foBAutAW+ABGJ9xEbOVHdh+yFpiIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eqMil4J9+0JM4I27uMkC9q1saPqEzZbcVVpb81NA+lH7cegQq76pQyuWAiMSRGeuOzyXMBEIAW+/1ipmdBcSiJR8mJdaf41jwtJXYgrkBNpxLC22K8ePA+YV8Xk1CHpqgqQMs3ZdzuVDKA7REaen5S25dIX6w3cv7TklvdO6nQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5zZG/5E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94EBDC4CEDF;
	Mon, 13 Jan 2025 00:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736728517;
	bh=OM6yPd8qpn0P82foBAutAW+ABGJ9xEbOVHdh+yFpiIQ=;
	h=From:To:Cc:Subject:Date:From;
	b=d5zZG/5ErPPcMgq2a7r7iwwEuw0tnWaedwT2Gvz+fc3ElkjcL5hyUvk0+6jB8DMO9
	 fvMBaTzBVLGbKMmLhpuWxVJ7knTjA51J/s2Moo99eSataX/lZ/IDRRH4cH+T+QkBt3
	 74psIAks4bOkT36l8jP+Yh2dxJMfm8xPU/ku38rj1oY7T6V0QRW77XOw+1mXIJCzml
	 8ur4zXkcI5hlYlhXlt7VpG4g501Ww382wqP19/K6mLGDa21tn66KdQfy3+6lBlKnBT
	 jvU+4VAnfLcqgju4TLOncbYozijGX43eFxrO2/6kgfYc2BWxzmy3IAYtZHLV4xGJvQ
	 j9SySnKpmXltQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	mptcp@lists.linux.dev
Subject: [PATCH net-next v2 1/2] net: remove init_dummy_netdev()
Date: Sun, 12 Jan 2025 16:34:55 -0800
Message-ID: <20250113003456.3904110-1-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

init_dummy_netdev() can initialize statically declared or embedded
net_devices. Such netdevs did not come from alloc_netdev_mqs().
After recent work by Breno, there are the only two cases where
we have do that.

Switch those cases to alloc_netdev_mqs() and delete init_dummy_netdev().
Dealing with static netdevs is not worth the maintenance burden.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2: change of plan, delete init_dummy_netdev() completely
v1: https://lore.kernel.org/20250111065955.3698801-1-kuba@kernel.org
---
CC: matttbe@kernel.org
CC: martineau@kernel.org
CC: geliang@kernel.org
CC: steffen.klassert@secunet.com
CC: herbert@gondor.apana.org.au
CC: mptcp@lists.linux.dev
---
 include/linux/netdevice.h |  1 -
 net/core/dev.c            | 22 ----------------------
 net/mptcp/protocol.c      |  8 +++++---
 net/xfrm/xfrm_input.c     |  9 ++++++---
 4 files changed, 11 insertions(+), 29 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index aeb4a6cff171..dd8f6f8991fe 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3238,7 +3238,6 @@ static inline void unregister_netdevice(struct net_device *dev)
 
 int netdev_refcnt_read(const struct net_device *dev);
 void free_netdev(struct net_device *dev);
-void init_dummy_netdev(struct net_device *dev);
 
 struct net_device *netdev_get_xmit_slave(struct net_device *dev,
 					 struct sk_buff *skb,
diff --git a/net/core/dev.c b/net/core/dev.c
index 1a90ed8cc6cc..c9abc9fc770e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10762,28 +10762,6 @@ static void init_dummy_netdev_core(struct net_device *dev)
 	 */
 }
 
-/**
- *	init_dummy_netdev	- init a dummy network device for NAPI
- *	@dev: device to init
- *
- *	This takes a network device structure and initializes the minimum
- *	amount of fields so it can be used to schedule NAPI polls without
- *	registering a full blown interface. This is to be used by drivers
- *	that need to tie several hardware interfaces to a single NAPI
- *	poll scheduler due to HW limitations.
- */
-void init_dummy_netdev(struct net_device *dev)
-{
-	/* Clear everything. Note we don't initialize spinlocks
-	 * as they aren't supposed to be taken by any of the
-	 * NAPI code and this dummy netdev is supposed to be
-	 * only ever used for NAPI polls
-	 */
-	memset(dev, 0, sizeof(struct net_device));
-	init_dummy_netdev_core(dev);
-}
-EXPORT_SYMBOL_GPL(init_dummy_netdev);
-
 /**
  *	register_netdev	- register a network device
  *	@dev: device to register
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1b2e7cbb577f..c44c89ecaca6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -47,7 +47,7 @@ static void __mptcp_destroy_sock(struct sock *sk);
 static void mptcp_check_send_data_fin(struct sock *sk);
 
 DEFINE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions);
-static struct net_device mptcp_napi_dev;
+static struct net_device *mptcp_napi_dev;
 
 /* Returns end sequence number of the receiver's advertised window */
 static u64 mptcp_wnd_end(const struct mptcp_sock *msk)
@@ -4147,11 +4147,13 @@ void __init mptcp_proto_init(void)
 	if (percpu_counter_init(&mptcp_sockets_allocated, 0, GFP_KERNEL))
 		panic("Failed to allocate MPTCP pcpu counter\n");
 
-	init_dummy_netdev(&mptcp_napi_dev);
+	mptcp_napi_dev = alloc_netdev_dummy(0);
+	if (!mptcp_napi_dev)
+		panic("Failed to allocate MPTCP dummy netdev\n");
 	for_each_possible_cpu(cpu) {
 		delegated = per_cpu_ptr(&mptcp_delegated_actions, cpu);
 		INIT_LIST_HEAD(&delegated->head);
-		netif_napi_add_tx(&mptcp_napi_dev, &delegated->napi,
+		netif_napi_add_tx(mptcp_napi_dev, &delegated->napi,
 				  mptcp_napi_poll);
 		napi_enable(&delegated->napi);
 	}
diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 2c4ae61e7e3a..7e6a71b9d6a3 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -48,7 +48,7 @@ static DEFINE_SPINLOCK(xfrm_input_afinfo_lock);
 static struct xfrm_input_afinfo const __rcu *xfrm_input_afinfo[2][AF_INET6 + 1];
 
 static struct gro_cells gro_cells;
-static struct net_device xfrm_napi_dev;
+static struct net_device *xfrm_napi_dev;
 
 static DEFINE_PER_CPU(struct xfrm_trans_tasklet, xfrm_trans_tasklet);
 
@@ -825,8 +825,11 @@ void __init xfrm_input_init(void)
 	int err;
 	int i;
 
-	init_dummy_netdev(&xfrm_napi_dev);
-	err = gro_cells_init(&gro_cells, &xfrm_napi_dev);
+	xfrm_napi_dev = alloc_netdev_dummy(0);
+	if (!xfrm_napi_dev)
+		panic("Failed to allocate XFRM dummy netdev\n");
+
+	err = gro_cells_init(&gro_cells, xfrm_napi_dev);
 	if (err)
 		gro_cells.cells = NULL;
 
-- 
2.47.1


