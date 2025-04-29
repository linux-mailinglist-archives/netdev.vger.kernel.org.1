Return-Path: <netdev+bounces-186754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD36BAA0ED2
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 16:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16D534A0F75
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 14:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D5A86353;
	Tue, 29 Apr 2025 14:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ec2nQoFT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF61C17BCE;
	Tue, 29 Apr 2025 14:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745937072; cv=none; b=ZDVm6ohAL+aKaxL9cAQiUhTOku8Ya/SYsGnUYOZtf0W061aVXIuhoAal8DP9DYbD8ax0l2nhSAsQGhKm+R22D5Ad0oyrOoB+bWhpO7ZDqnXsJ9YosKOnZQHN1NaIulXZL6ja53jIjmEQ3GtiBfHD0kslJgWad1iz9nwIKv+/INA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745937072; c=relaxed/simple;
	bh=n1MOblvz9LCeIQL3f5bV0p3VsgSmJFiNF5ozBVnuPs0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZnsAILHaFezxbsbZgoUp0Oepb/g+1vf7935zx+DhlzbuNYNGl3xUmwHLwEGIxSv4xn0OklJHfwGnEikDFIMkrhIEzv0syZjfWI6w8tGX9GD9tSrW1+o9HPrgCv9i5FxDWzB4eC+5mXr4qcPqAzJpsCX+r8HxJCk56zBqA3nPu/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ec2nQoFT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC14CC4CEE3;
	Tue, 29 Apr 2025 14:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745937072;
	bh=n1MOblvz9LCeIQL3f5bV0p3VsgSmJFiNF5ozBVnuPs0=;
	h=From:To:Cc:Subject:Date:From;
	b=Ec2nQoFTilvo6sqrkeiX6M/qLEkgE4W5JTl/kEqWI/4ERrdtNmUa4CWYCIOYD6hN+
	 OjHa+4JQ6FZ6LxGCWwTTqTKp978yUrJ+xI/GrqVSw5KuFVQB890L5nLlJ01rENqaZw
	 JiMcOk0OLl50ebfTKH7obNTf+C+elWP86kDod8euj/zuP90tyhdsnDzu0x8TS/Pxua
	 0h7+AG2g1GPkwtRVCAkzI7KAyo3S0yt3+ZLpknkxY3psoLMUPb1gV3AxqUuuKtYbxt
	 XUw9fmdy1WbL526erUOpmX2pKFyswcIMXnR5/cLxvYs/AUOp9jWblVz4v4hSTZAaLL
	 jCDm9yMK14uwg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	minhquangbui99@gmail.com,
	romieu@fr.zoreil.com,
	kuniyu@amazon.com,
	virtualization@lists.linux.dev
Subject: [PATCH net] virtio-net: don't re-enable refill work too early when NAPI is disabled
Date: Tue, 29 Apr 2025 07:31:04 -0700
Message-ID: <20250429143104.2576553-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
fixed a deadlock between reconfig paths and refill work trying to disable
the same NAPI instance. The refill work can't run in parallel with reconfig
because trying to double-disable a NAPI instance causes a stall under the
instance lock, which the reconfig path needs to re-enable the NAPI and
therefore unblock the stalled thread.

There are two cases where we re-enable refill too early. One is in the
virtnet_set_queues() handler. We call it when installing XDP:

   virtnet_rx_pause_all(vi);
   ...
   virtnet_napi_tx_disable(..);
   ...
   virtnet_set_queues(..);
   ...
   virtnet_rx_resume_all(..);

We want the work to be disabled until we call virtnet_rx_resume_all(),
but virtnet_set_queues() kicks it before NAPIs were re-enabled.

The other case is a more trivial case of mis-ordering in
__virtnet_rx_resume() found by code inspection.

Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
Fixes: 413f0271f396 ("net: protect NAPI enablement with netdev_lock()")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: mst@redhat.com
CC: jasowang@redhat.com
CC: xuanzhuo@linux.alibaba.com
CC: eperezma@redhat.com
CC: minhquangbui99@gmail.com
CC: romieu@fr.zoreil.com
CC: kuniyu@amazon.com
CC: virtualization@lists.linux.dev
---
 drivers/net/virtio_net.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 848fab51dfa1..4c904e176495 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3383,12 +3383,15 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
 				bool refill)
 {
 	bool running = netif_running(vi->dev);
+	bool schedule_refill = false;
 
 	if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
-		schedule_delayed_work(&vi->refill, 0);
-
+		schedule_refill = true;
 	if (running)
 		virtnet_napi_enable(rq);
+
+	if (schedule_refill)
+		schedule_delayed_work(&vi->refill, 0);
 }
 
 static void virtnet_rx_resume_all(struct virtnet_info *vi)
@@ -3728,7 +3731,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
 succ:
 	vi->curr_queue_pairs = queue_pairs;
 	/* virtnet_open() will refill when device is going to up. */
-	if (dev->flags & IFF_UP)
+	if (dev->flags & IFF_UP && vi->refill_enabled)
 		schedule_delayed_work(&vi->refill, 0);
 
 	return 0;
-- 
2.49.0


