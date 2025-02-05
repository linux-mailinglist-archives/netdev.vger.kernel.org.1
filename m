Return-Path: <netdev+bounces-163218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5BEA299A7
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 20:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1271716A001
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 19:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01331FF7D3;
	Wed,  5 Feb 2025 19:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkFkRu1I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBECE1FF7BF
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 19:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738782112; cv=none; b=R2WrQ6Nu9Sy6iQh9UlD6Zn2ixTbGQ509Im2KdAa7+yQik+ziZGmypM5pze9gREpKmadVVAiV89kC9i+MPA71H7mQ6sNutfMDLNCkhVyA5ugd8rfBIDKP+m8kMb+TfU5DOm8qTbOWMdyUZZcR48nuSBQL5g9OuCoCZ+Aj32926WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738782112; c=relaxed/simple;
	bh=xPW8xMnDUWTP59RzW3JJMTzIuMu9MBqeskgG3aTov0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KMObLuEZwDedE7taMSPFqqcayf0NLKRbwQcw9UXReiTVYbhBURo28opp5fTR1rl7f5MMqEqUDKtox35sy8q+d6E7kg47G6T5rJt43TqtZFm95JjUUsd6h+VH3SrxfYs1PxyjbIz0rPHLQKLJ8OpbE/jVv+7ZKGYTI2ijcIZ7Tc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CkFkRu1I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01822C4CEE2;
	Wed,  5 Feb 2025 19:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738782112;
	bh=xPW8xMnDUWTP59RzW3JJMTzIuMu9MBqeskgG3aTov0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CkFkRu1I/AIW8syBmGeBT5XRIckQui+MOhI8vVjOi/wAW5JBlzwJvNOqnCJy9kaMt
	 VKzAC/m+LCvKd8PK9cUlVIXBwCV8XVQc6A5EYCAtv254K4TdTSlFPk26uC+87T2KRe
	 TvBaIVYx+6fkdT35MVVAzo/ghIu28Mle3cLCc/Z+O5u4B2zSEciwDhf0grmUizCUTB
	 9JhDIysOCMMHf+2vAOknsfWiO3J2Yi3YF03caRbMJE9VT3gRjMesEul80Cljh10lAR
	 JKs37bDJbRmU7eSPpUQXUDP05WuM9fRYwmpODIBOsU2SFb4hfC/iZ6CX9GmDQUAiD7
	 ZIOsuHwMXvWRg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	almasrymina@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/3] netdevsim: allow normal queue reset while down
Date: Wed,  5 Feb 2025 11:01:31 -0800
Message-ID: <20250205190131.564456-4-kuba@kernel.org>
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

Resetting queues while the device is down should be legal.
Allow it, test it. Ideally we'd test this with a real device
supporting devmem but I don't have access to such devices.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/netdevsim/netdev.c           |  8 +++-----
 tools/testing/selftests/net/nl_netdev.py | 17 ++++++++++++++++-
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 42f247cbdcee..d26b2fb1cabc 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -644,6 +644,9 @@ nsim_queue_mem_alloc(struct net_device *dev, void *per_queue_mem, int idx)
 
 	if (ns->rq_reset_mode > 3)
 		return -EINVAL;
+	/* Only "mode 0" works when device is down */
+	if (!netif_running(ns->netdev) && ns->rq_reset_mode)
+		return -ENETDOWN;
 
 	if (ns->rq_reset_mode == 1)
 		return nsim_create_page_pool(&qmem->pp, &ns->rq[idx]->napi);
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
index 93e8cb671c3d..9a03e3fe7e31 100755
--- a/tools/testing/selftests/net/nl_netdev.py
+++ b/tools/testing/selftests/net/nl_netdev.py
@@ -35,6 +35,20 @@ from lib.py import NetdevFamily, NetdevSimDev, ip
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
+        nsim.dfs_write("queue_reset", f"1 0")
+
+
 def page_pool_check(nf) -> None:
     with NetdevSimDev() as nsimdev:
         nsim = nsimdev.nsims[0]
@@ -106,7 +120,8 @@ from lib.py import NetdevFamily, NetdevSimDev, ip
 
 def main() -> None:
     nf = NetdevFamily()
-    ksft_run([empty_check, lo_check, page_pool_check, napi_list_check],
+    ksft_run([empty_check, lo_check, page_pool_check, napi_list_check,
+              nsim_rxq_reset_down],
              args=(nf, ))
     ksft_exit()
 
-- 
2.48.1


