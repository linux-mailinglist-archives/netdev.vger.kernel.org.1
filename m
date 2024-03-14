Return-Path: <netdev+bounces-79990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DCA87C559
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 23:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F30761C20FCF
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 22:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0DC4A11;
	Thu, 14 Mar 2024 22:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="KSXaWa3S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E02FC09
	for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 22:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710456575; cv=none; b=JKDpu8mjT8ZcYE2lcX3bVlCh13rgi/+NFcLKIn9oC26846xOKw2eXPRZVZi2FO+7LG8FaR/XREpMVChsncSNzSb31wyXctZ9rI3PhxIwLqYDXS6UFe8uGuJ/QGHq21g4z2/9vYqoKhsQZz92/vSOSof4SJoNfN0r8Hu5V8KP/bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710456575; c=relaxed/simple;
	bh=+oTe+hBfa0aQpugI7WzWEpwgjpZu2EHvmoEqIHnyllA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pXV6eTKsCwjhwCA1/WIwfvJDD6occ4jYxc5BgTyPy/VWaYiz+fmdmoyrvBIhGGPh+/DfgKJRL3mD+vr7hJnSh9D+v1dXWLe4Npza+E/uvv2BDKvQcuNbpNPLUQEWSPGpd8QAjKfbjo5uzWsyid8DSRg5NE4zHP7K6/GcvIXpk5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=KSXaWa3S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAFACC433C7;
	Thu, 14 Mar 2024 22:49:34 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="KSXaWa3S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1710456572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c/aFDQVnZYf/0SMALBb3qNKTfWdlxu70J44C4NGowpg=;
	b=KSXaWa3S+M6EJnIEroTw5vfujpp8bh6QmuWcOME/LF3qFrm6QaE24fHhm2MFGafzxUtod9
	ttPPDJgaiDmdC6jNZXck3JSSZT5+y9bOngYEkXiAJNzPUMQMRh3yHVbfN35PXGkUqVRPae
	B6zmTKKlD+71G4NwcS7aDLq4Wu+z5Ds=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0b56b9f8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 14 Mar 2024 22:49:32 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org
Subject: [PATCH net 2/6] wireguard: device: leverage core stats allocator
Date: Thu, 14 Mar 2024 16:49:07 -0600
Message-ID: <20240314224911.6653-3-Jason@zx2c4.com>
In-Reply-To: <20240314224911.6653-1-Jason@zx2c4.com>
References: <20240314224911.6653-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Breno Leitao <leitao@debian.org>

With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core
and convert veth & vrf"), stats allocation could be done on net core
instead of in this driver.

With this new approach, the driver doesn't have to bother with error
handling (allocation failure checking, making sure free happens in the
right spot, etc). This is core responsibility now.

Remove the allocation in this driver and leverage the network core
allocation instead.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/net/wireguard/device.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireguard/device.c b/drivers/net/wireguard/device.c
index deb9636b0ecf..6aa071469e1c 100644
--- a/drivers/net/wireguard/device.c
+++ b/drivers/net/wireguard/device.c
@@ -262,7 +262,6 @@ static void wg_destruct(struct net_device *dev)
 	rcu_barrier(); /* Wait for all the peers to be actually freed. */
 	wg_ratelimiter_uninit();
 	memzero_explicit(&wg->static_identity, sizeof(wg->static_identity));
-	free_percpu(dev->tstats);
 	kvfree(wg->index_hashtable);
 	kvfree(wg->peer_hashtable);
 	mutex_unlock(&wg->device_update_lock);
@@ -297,6 +296,7 @@ static void wg_setup(struct net_device *dev)
 	dev->hw_enc_features |= WG_NETDEV_FEATURES;
 	dev->mtu = ETH_DATA_LEN - overhead;
 	dev->max_mtu = round_down(INT_MAX, MESSAGE_PADDING_MULTIPLE) - overhead;
+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 
 	SET_NETDEV_DEVTYPE(dev, &device_type);
 
@@ -331,14 +331,10 @@ static int wg_newlink(struct net *src_net, struct net_device *dev,
 	if (!wg->index_hashtable)
 		goto err_free_peer_hashtable;
 
-	dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
-	if (!dev->tstats)
-		goto err_free_index_hashtable;
-
 	wg->handshake_receive_wq = alloc_workqueue("wg-kex-%s",
 			WQ_CPU_INTENSIVE | WQ_FREEZABLE, 0, dev->name);
 	if (!wg->handshake_receive_wq)
-		goto err_free_tstats;
+		goto err_free_index_hashtable;
 
 	wg->handshake_send_wq = alloc_workqueue("wg-kex-%s",
 			WQ_UNBOUND | WQ_FREEZABLE, 0, dev->name);
@@ -397,8 +393,6 @@ static int wg_newlink(struct net *src_net, struct net_device *dev,
 	destroy_workqueue(wg->handshake_send_wq);
 err_destroy_handshake_receive:
 	destroy_workqueue(wg->handshake_receive_wq);
-err_free_tstats:
-	free_percpu(dev->tstats);
 err_free_index_hashtable:
 	kvfree(wg->index_hashtable);
 err_free_peer_hashtable:
-- 
2.44.0


