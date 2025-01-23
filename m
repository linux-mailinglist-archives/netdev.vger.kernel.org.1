Return-Path: <netdev+bounces-160439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A01EA19BE2
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 01:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43CED188D77D
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 00:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391CFAD31;
	Thu, 23 Jan 2025 00:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eaIVm8T7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1357E9460
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 00:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737593125; cv=none; b=MIgksKjxHh/k6WIsgUveroBBC2+1Uu67Jxu3N2R5CmHGDu/KmHtIIS1Hfi/1lIIgBPHH5TFgOCQurh33XXAjr37Pc/Ye9S1RPCQbF29JAkkB//KWrsXMpXTA3hwMcyv7vnS4sk60ri9VPgjNNu6my4Rt9sAvmoh2L9EoQz0vOGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737593125; c=relaxed/simple;
	bh=DERSy1q9mPbZrWJIHMvstslTg1AXc1RUE68aDa8LMdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GELJU/JJXQ7EV/CtXkqW0sfxEX39Fn28ObekVEdidsRC6dwSwOoLzyTmYQGBByMym7iiE0gBtkgJ7C8h3H5uYHpP+EPYRxSDjMpekRpitxY4ZwtzyNvJ7wPPDJJvomDeXyJ45/U7YM6i1lmbUSdpycnfQK41kCRufQwCSeztaFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eaIVm8T7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ECFEC4CED6;
	Thu, 23 Jan 2025 00:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737593124;
	bh=DERSy1q9mPbZrWJIHMvstslTg1AXc1RUE68aDa8LMdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eaIVm8T7p6uzoIr4Wnaa2NwECFge9Z5t/fRJWAE8i66TL9AlpLHRWRZ20UFqSr3bN
	 MeoHT08lfzEaZ3MybntEaVOhhg7mKlCw/pSW6ODezj336Dd7tJQq1DATs8XZCJwH0Y
	 B10xgXeUlI59YU75szSYS5gcRliPjUPHaFPvA7u+CrbPlekJOR/Ml3MrKli3RUAfrB
	 8wxtFIBHGuWQuu4oQ54O2jNzOtL2T2/lagECYPjP5Q7768pBVcur7vf9Jjq04+hkXk
	 SLDxiWpDAQEZgs8puijCln2KcDayoah8ZOgWZ597feUC2mpgOErp+ELufL9dD9XLlD
	 lMRvqqWHVwohQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	dan.carpenter@linaro.org,
	Jakub Kicinski <kuba@kernel.org>,
	pavan.chebbi@broadcom.com,
	mchan@broadcom.com,
	kuniyu@amazon.com,
	romieu@fr.zoreil.com
Subject: [PATCH net v2 1/7] eth: tg3: fix calling napi_enable() in atomic context
Date: Wed, 22 Jan 2025 16:45:14 -0800
Message-ID: <20250123004520.806855-2-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250123004520.806855-1-kuba@kernel.org>
References: <20250123004520.806855-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tg3 has a spin lock protecting most of the config,
switch to taking netdev_lock() explicitly on enable/start
paths. Disable/stop paths seem to not be under the spin
lock (since napi_disable() already needs to sleep),
so leave that side as is.

tg3_restart_hw() releases and re-takes the spin lock,
we need to do the same because dev_close() needs to
take netdev_lock().

Fixes: 413f0271f396 ("net: protect NAPI enablement with netdev_lock()")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/dcfd56bc-de32-4b11-9e19-d8bd1543745d@stanley.mountain
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - correct commit msg (can't sleep -> needs to sleep)
 - add re-locking annotation to tg3_irq_quiesce()
v1: https://lore.kernel.org/20250121221519.392014-2-kuba@kernel.org

CC: pavan.chebbi@broadcom.com
CC: mchan@broadcom.com
CC: kuniyu@amazon.com
CC: romieu@fr.zoreil.com
---
 drivers/net/ethernet/broadcom/tg3.c | 35 +++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 9cc8db10a8d6..57a09107b0dc 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -7424,7 +7424,7 @@ static void tg3_napi_enable(struct tg3 *tp)
 
 	for (i = 0; i < tp->irq_cnt; i++) {
 		tnapi = &tp->napi[i];
-		napi_enable(&tnapi->napi);
+		napi_enable_locked(&tnapi->napi);
 		if (tnapi->tx_buffers) {
 			netif_queue_set_napi(tp->dev, txq_idx,
 					     NETDEV_QUEUE_TYPE_TX,
@@ -7445,9 +7445,10 @@ static void tg3_napi_init(struct tg3 *tp)
 	int i;
 
 	for (i = 0; i < tp->irq_cnt; i++) {
-		netif_napi_add(tp->dev, &tp->napi[i].napi,
-			       i ? tg3_poll_msix : tg3_poll);
-		netif_napi_set_irq(&tp->napi[i].napi, tp->napi[i].irq_vec);
+		netif_napi_add_locked(tp->dev, &tp->napi[i].napi,
+				      i ? tg3_poll_msix : tg3_poll);
+		netif_napi_set_irq_locked(&tp->napi[i].napi,
+					  tp->napi[i].irq_vec);
 	}
 }
 
@@ -7489,6 +7490,8 @@ static inline void tg3_netif_start(struct tg3 *tp)
 static void tg3_irq_quiesce(struct tg3 *tp)
 	__releases(tp->lock)
 	__acquires(tp->lock)
+	__releases(tp->dev->lock)
+	__acquires(tp->dev->lock)
 {
 	int i;
 
@@ -11271,7 +11274,9 @@ static int tg3_restart_hw(struct tg3 *tp, bool reset_phy)
 		tg3_timer_stop(tp);
 		tp->irq_sync = 0;
 		tg3_napi_enable(tp);
+		netdev_unlock(tp->dev);
 		dev_close(tp->dev);
+		netdev_lock(tp->dev);
 		tg3_full_lock(tp, 0);
 	}
 	return err;
@@ -11299,6 +11304,7 @@ static void tg3_reset_task(struct work_struct *work)
 
 	tg3_netif_stop(tp);
 
+	netdev_lock(tp->dev);
 	tg3_full_lock(tp, 1);
 
 	if (tg3_flag(tp, TX_RECOVERY_PENDING)) {
@@ -11318,12 +11324,14 @@ static void tg3_reset_task(struct work_struct *work)
 		 * call cancel_work_sync() and wait forever.
 		 */
 		tg3_flag_clear(tp, RESET_TASK_PENDING);
+		netdev_unlock(tp->dev);
 		dev_close(tp->dev);
 		goto out;
 	}
 
 	tg3_netif_start(tp);
 	tg3_full_unlock(tp);
+	netdev_unlock(tp->dev);
 	tg3_phy_start(tp);
 	tg3_flag_clear(tp, RESET_TASK_PENDING);
 out:
@@ -11683,9 +11691,11 @@ static int tg3_start(struct tg3 *tp, bool reset_phy, bool test_irq,
 	if (err)
 		goto out_ints_fini;
 
+	netdev_lock(dev);
 	tg3_napi_init(tp);
 
 	tg3_napi_enable(tp);
+	netdev_unlock(dev);
 
 	for (i = 0; i < tp->irq_cnt; i++) {
 		err = tg3_request_irq(tp, i);
@@ -12569,6 +12579,7 @@ static int tg3_set_ringparam(struct net_device *dev,
 		irq_sync = 1;
 	}
 
+	netdev_lock(dev);
 	tg3_full_lock(tp, irq_sync);
 
 	tp->rx_pending = ering->rx_pending;
@@ -12597,6 +12608,7 @@ static int tg3_set_ringparam(struct net_device *dev,
 	}
 
 	tg3_full_unlock(tp);
+	netdev_unlock(dev);
 
 	if (irq_sync && !err)
 		tg3_phy_start(tp);
@@ -12678,6 +12690,7 @@ static int tg3_set_pauseparam(struct net_device *dev, struct ethtool_pauseparam
 			irq_sync = 1;
 		}
 
+		netdev_lock(dev);
 		tg3_full_lock(tp, irq_sync);
 
 		if (epause->autoneg)
@@ -12707,6 +12720,7 @@ static int tg3_set_pauseparam(struct net_device *dev, struct ethtool_pauseparam
 		}
 
 		tg3_full_unlock(tp);
+		netdev_unlock(dev);
 	}
 
 	tp->phy_flags |= TG3_PHYFLG_USER_CONFIGURED;
@@ -13911,6 +13925,7 @@ static void tg3_self_test(struct net_device *dev, struct ethtool_test *etest,
 			data[TG3_INTERRUPT_TEST] = 1;
 		}
 
+		netdev_lock(dev);
 		tg3_full_lock(tp, 0);
 
 		tg3_halt(tp, RESET_KIND_SHUTDOWN, 1);
@@ -13922,6 +13937,7 @@ static void tg3_self_test(struct net_device *dev, struct ethtool_test *etest,
 		}
 
 		tg3_full_unlock(tp);
+		netdev_unlock(dev);
 
 		if (irq_sync && !err2)
 			tg3_phy_start(tp);
@@ -14365,6 +14381,7 @@ static int tg3_change_mtu(struct net_device *dev, int new_mtu)
 
 	tg3_set_mtu(dev, tp, new_mtu);
 
+	netdev_lock(dev);
 	tg3_full_lock(tp, 1);
 
 	tg3_halt(tp, RESET_KIND_SHUTDOWN, 1);
@@ -14384,6 +14401,7 @@ static int tg3_change_mtu(struct net_device *dev, int new_mtu)
 		tg3_netif_start(tp);
 
 	tg3_full_unlock(tp);
+	netdev_unlock(dev);
 
 	if (!err)
 		tg3_phy_start(tp);
@@ -18164,6 +18182,7 @@ static int tg3_resume(struct device *device)
 
 	netif_device_attach(dev);
 
+	netdev_lock(dev);
 	tg3_full_lock(tp, 0);
 
 	tg3_ape_driver_state_change(tp, RESET_KIND_INIT);
@@ -18180,6 +18199,7 @@ static int tg3_resume(struct device *device)
 
 out:
 	tg3_full_unlock(tp);
+	netdev_unlock(dev);
 
 	if (!err)
 		tg3_phy_start(tp);
@@ -18260,7 +18280,9 @@ static pci_ers_result_t tg3_io_error_detected(struct pci_dev *pdev,
 done:
 	if (state == pci_channel_io_perm_failure) {
 		if (netdev) {
+			netdev_lock(netdev);
 			tg3_napi_enable(tp);
+			netdev_unlock(netdev);
 			dev_close(netdev);
 		}
 		err = PCI_ERS_RESULT_DISCONNECT;
@@ -18314,7 +18336,9 @@ static pci_ers_result_t tg3_io_slot_reset(struct pci_dev *pdev)
 
 done:
 	if (rc != PCI_ERS_RESULT_RECOVERED && netdev && netif_running(netdev)) {
+		netdev_lock(netdev);
 		tg3_napi_enable(tp);
+		netdev_unlock(netdev);
 		dev_close(netdev);
 	}
 	rtnl_unlock();
@@ -18340,12 +18364,14 @@ static void tg3_io_resume(struct pci_dev *pdev)
 	if (!netdev || !netif_running(netdev))
 		goto done;
 
+	netdev_lock(netdev);
 	tg3_full_lock(tp, 0);
 	tg3_ape_driver_state_change(tp, RESET_KIND_INIT);
 	tg3_flag_set(tp, INIT_COMPLETE);
 	err = tg3_restart_hw(tp, true);
 	if (err) {
 		tg3_full_unlock(tp);
+		netdev_unlock(netdev);
 		netdev_err(netdev, "Cannot restart hardware after reset.\n");
 		goto done;
 	}
@@ -18357,6 +18383,7 @@ static void tg3_io_resume(struct pci_dev *pdev)
 	tg3_netif_start(tp);
 
 	tg3_full_unlock(tp);
+	netdev_unlock(netdev);
 
 	tg3_phy_start(tp);
 
-- 
2.48.1


