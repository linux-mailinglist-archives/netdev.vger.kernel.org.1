Return-Path: <netdev+bounces-163698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CF7A2B606
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 23:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 388901883FDE
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 22:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE612376E3;
	Thu,  6 Feb 2025 22:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qp8S6dpK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0C9236A75
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 22:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738882614; cv=none; b=ff06aqWKzNQhbI/Aa+V/gx18jPA/TxJJAnWtqff/4ck66sKCy0YTCx1NrqpOBE8q/MSGC/pN2XPvOkcTc/RAFZNvEG+gdYEE4KkIKY7E6OeJwEP7I2++LY5KMDLZ5aumbKxkdcDOfMlY64KIYmb2dbZMkv8RU7yv0adNoAr/RmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738882614; c=relaxed/simple;
	bh=+Ef4SdvDzFGRaBV9KVjIzCrBZL4MsQlSYgAunRL+QRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ON9PGp7XNlGdzjn8Zghj5J9gqerPc31Dg/vvrDvnkvfOu1WDeapXe5dtT9Yed0ZzJrljNAMQFCsU+dpcEQTDEkYRwYWC8g8c1krC65sRyjY8OO9sZEaNGhKq4nkPZC6rXxIVM0bAkFSRGaQwQPW1fGwRsU8HwwQIrIo69qH58sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qp8S6dpK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A51C4CEE2;
	Thu,  6 Feb 2025 22:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738882614;
	bh=+Ef4SdvDzFGRaBV9KVjIzCrBZL4MsQlSYgAunRL+QRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qp8S6dpKIInoAHR9e2W6mQJ8iD64gicyua+8U/c265wwP0omNl1f2KXH7j2U/Sh+M
	 dd/j3VuwDCCpMjkMNTF6OAd1IY816cjxGXZoqXm5jhiqBJIhxPAEfsEqP4zQdoHWdu
	 R38/857ZGUE/tg9Ld3u4JX4/sPOgtIGjuSfzW0+5R/s/0r7rwmxmnvKzU/LIUBKMQr
	 5HKMwqwW4HQEy14vv9aelfYk+QBgTNFxIWPrHPseB6UqD5EA24hP9Dz+G0gLDddtNr
	 M/E1JSS/fa4Z5t7WRf6b06/iMXRP29GZImrPSw8VDGJkWMAMNjFkq4LWdC0NvCDrt2
	 OSNKMyUR23q5w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	almasrymina@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 4/4] netdevsim: allow normal queue reset while down
Date: Thu,  6 Feb 2025 14:56:38 -0800
Message-ID: <20250206225638.1387810-5-kuba@kernel.org>
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

Resetting queues while the device is down should be legal.
Allow it, test it. Ideally we'd test this with a real device
supporting devmem but I don't have access to such devices.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/netdevsim/netdev.c           | 10 ++++------
 tools/testing/selftests/net/nl_netdev.py | 18 +++++++++++++++++-
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 42f247cbdcee..9b394ddc5206 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -645,8 +645,11 @@ nsim_queue_mem_alloc(struct net_device *dev, void *per_queue_mem, int idx)
 	if (ns->rq_reset_mode > 3)
 		return -EINVAL;
 
-	if (ns->rq_reset_mode == 1)
+	if (ns->rq_reset_mode == 1) {
+		if (!netif_running(ns->netdev))
+			return -ENETDOWN;
 		return nsim_create_page_pool(&qmem->pp, &ns->rq[idx]->napi);
+	}
 
 	qmem->rq = nsim_queue_alloc();
 	if (!qmem->rq)
@@ -754,11 +757,6 @@ nsim_qreset_write(struct file *file, const char __user *data,
 		return -EINVAL;
 
 	rtnl_lock();
-	if (!netif_running(ns->netdev)) {
-		ret = -ENETDOWN;
-		goto exit_unlock;
-	}
-
 	if (queue >= ns->netdev->real_num_rx_queues) {
 		ret = -EINVAL;
 		goto exit_unlock;
diff --git a/tools/testing/selftests/net/nl_netdev.py b/tools/testing/selftests/net/nl_netdev.py
index 93e8cb671c3d..beaee5e4e2aa 100755
--- a/tools/testing/selftests/net/nl_netdev.py
+++ b/tools/testing/selftests/net/nl_netdev.py
@@ -35,6 +35,21 @@ from lib.py import NetdevFamily, NetdevSimDev, ip
                         comment=f"queue count after reset queue {q} mode {i}")
 
 
+def nsim_rxq_reset_down(nf) -> None:
+    """
+    Test that the queue API supports resetting a queue
+    while the interface is down. We should convert this
+    test to testing real HW once more devices support
+    queue API.
+    """
+    with NetdevSimDev(queue_count=4) as nsimdev:
+        nsim = nsimdev.nsims[0]
+
+        ip(f"link set dev {nsim.ifname} down")
+        for i in [0, 2, 3]:
+            nsim.dfs_write("queue_reset", f"1 {i}")
+
+
 def page_pool_check(nf) -> None:
     with NetdevSimDev() as nsimdev:
         nsim = nsimdev.nsims[0]
@@ -106,7 +121,8 @@ from lib.py import NetdevFamily, NetdevSimDev, ip
 
 def main() -> None:
     nf = NetdevFamily()
-    ksft_run([empty_check, lo_check, page_pool_check, napi_list_check],
+    ksft_run([empty_check, lo_check, page_pool_check, napi_list_check,
+              nsim_rxq_reset_down],
              args=(nf, ))
     ksft_exit()
 
-- 
2.48.1


