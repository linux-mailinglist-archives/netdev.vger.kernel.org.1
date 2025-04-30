Return-Path: <netdev+bounces-187124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE56FAA51C5
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 18:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 277B09E1AB0
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 16:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B5B2609D4;
	Wed, 30 Apr 2025 16:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="daDImLdX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A532609CA;
	Wed, 30 Apr 2025 16:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746031088; cv=none; b=DO9+43XZPTGdj0ccoj64PIMXPB6HifeNoRGTLffGT+MI2TsTVyAdDdiZZVQPejSMgpTDlayJeCHzjVyxnvAvt2P211lep88dyxvrP3FXZa7GDJCH2ENQKg3tcNBvqIvuu3Dd+JtiylZ6hpBTiFS1bWVg7T0NMmyaeOs4Sqb5ovQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746031088; c=relaxed/simple;
	bh=Kwh+D250+lz6tQ6Lf6LcLo7vr/SWVWmbcIzExKcLGiA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fqKUfILf3kz7nFNNbGJyB2wbOHHHW9z8X7agY94hZFKADLZgUUt6vaouMhyK6ECGGCgApJsopXITgfY1b4WMaCNaVZ4riG7oYAvlpKcMniyjlgi9LMw2IxOD6J31q9Rj/J0Wk5OyaEBiUG0SCJeJbqFsZt5tZ5xgXsVntpM8xPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=daDImLdX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 200E3C4CEE7;
	Wed, 30 Apr 2025 16:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746031087;
	bh=Kwh+D250+lz6tQ6Lf6LcLo7vr/SWVWmbcIzExKcLGiA=;
	h=From:To:Cc:Subject:Date:From;
	b=daDImLdXwxrnlZiVPC2+mWqe4o84V5Vc+FmbO9JXve8VUI+0e8poHICdC9UxB+eqh
	 xgymxEK/aghoCo8v2hK00dylWpe48/1dsF4cSIl4z1kJSdrWbEd6sHT6eqUXr2ybTZ
	 WIMlJ6J/wYTumdqHekjzjKlCpPvGZMbla/5Oqcom5xIeyYP8TmMUlr14CykUNqfjNU
	 PXsHsjXKBEls/LFkZHbZbyDzsPElItNzNnQ94Vzsy/fXKHnHpR5VSCZolBV36ZVOFK
	 xZ7cAGrQWnVF1GiE27iP0mmny/hPe522Nreve0wAQG773CWw5L215zAEdwLEVcRoqd
	 07uvBQU0D+jaA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Bui Quang Minh <minhquangbui99@gmail.com>,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	romieu@fr.zoreil.com,
	kuniyu@amazon.com,
	virtualization@lists.linux.dev
Subject: [PATCH net v2] virtio-net: don't re-enable refill work too early when NAPI is disabled
Date: Wed, 30 Apr 2025 09:37:58 -0700
Message-ID: <20250430163758.3029367-1-kuba@kernel.org>
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

Taking the spin lock in virtnet_set_queues() (requested during review)
may be unnecessary as we are under rtnl_lock and so are all paths writing
to ->refill_enabled.

Reviewed-by: Bui Quang Minh <minhquangbui99@gmail.com>
Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
Fixes: 413f0271f396 ("net: protect NAPI enablement with netdev_lock()")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - wrap schedule under the spin lock
v1: https://lore.kernel.org/20250429143104.2576553-1-kuba@kernel.org

CC: mst@redhat.com
CC: jasowang@redhat.com
CC: xuanzhuo@linux.alibaba.com
CC: eperezma@redhat.com
CC: minhquangbui99@gmail.com
CC: romieu@fr.zoreil.com
CC: kuniyu@amazon.com
CC: virtualization@lists.linux.dev
---
 drivers/net/virtio_net.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index c107916b685e..f9e3e628ec4d 100644
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
@@ -3728,8 +3731,10 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
 succ:
 	vi->curr_queue_pairs = queue_pairs;
 	/* virtnet_open() will refill when device is going to up. */
-	if (dev->flags & IFF_UP)
+	spin_lock_bh(&vi->refill_lock);
+	if (dev->flags & IFF_UP && vi->refill_enabled)
 		schedule_delayed_work(&vi->refill, 0);
+	spin_unlock_bh(&vi->refill_lock);
 
 	return 0;
 }
-- 
2.49.0


