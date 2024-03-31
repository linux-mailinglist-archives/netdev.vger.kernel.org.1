Return-Path: <netdev+bounces-83584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAEC8931F9
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 16:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C2D91C21429
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 14:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B59145326;
	Sun, 31 Mar 2024 14:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="GDoiiD/F"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27D774C1D
	for <netdev@vger.kernel.org>; Sun, 31 Mar 2024 14:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711895060; cv=none; b=mlJlQZwiNvdAymw3bylBrvMYZkAyTsNNnovyJeRTuzAOUEGrKDwWyJpQXubU+YNbt+q06HLdSYS6rIkbCNqjAQMeQWePqaL/XTI1MUjCGYLIkgKpkytTKkE5qKmGAz98rXc0AKedlIDM9LKNBdj+i7NTqbnf1WsKd8RR4DXEyS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711895060; c=relaxed/simple;
	bh=RCq8ECneAcFQNthL3eafKXE5isa8/+3llJptkHIZvN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=frT0iOwSGMY3MvG7lCFaRzI5BZ1F8V7B8Iwyymzfwf08vxCN0rXjMMBLD+QDrO+fLkeQ3e3bAiFxrlRQXvClDJnwITfP/dXvtEYfOB9mBUAx4NNC9NzyEw100YiI5jbLOzMUJihztbIkLkoYbfOwPM46LPhqO+e8jDd5nxUoTMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=GDoiiD/F; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 45EE087F5C;
	Sun, 31 Mar 2024 16:24:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711895056;
	bh=6k5mc4z91Zj/OnKoK/eiEIlBfqwHMRyAIh8rhYTMJvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GDoiiD/F8eyC0IAWdXjUpcBZVbophWl3Ca/Gvz89/YFn9PSqqlAfpQ+ZgaLKC77JV
	 o30k3+OkG96b3uNazte0+CUc2+CX8wP0tc+AGhyo8eoO8AYLDfgfzoDQBRD3d0gxWn
	 jAf2kkOt913XLbu5o/HVwnrx7aaNZVF8rj/K2BJOx/zem+kf7tekBFTYdNPkA5KiSn
	 KdcghVrBUbAkiS8jIR5IN+bu8d6zE5v0QrPzfMzp15sSlSjaKuXpI7jJM2rBjHfFo/
	 lTaT5XpGZdkBDpVSrmSeejvlKJT2My8My4OeZvYwXsPN+UOIWv3BHZDjRK9Ozs335x
	 tXXtww6ul+FMg==
From: Marek Vasut <marex@denx.de>
To: netdev@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	"David S. Miller" <davem@davemloft.net>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ronald Wahl <ronald.wahl@raritan.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH 2/2] net: ks8851: Handle softirqs at the end of IRQ thread to fix hang
Date: Sun, 31 Mar 2024 16:21:46 +0200
Message-ID: <20240331142353.93792-2-marex@denx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240331142353.93792-1-marex@denx.de>
References: <20240331142353.93792-1-marex@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The ks8851_irq() thread may call ks8851_rx_pkts() in case there are
any packets in the MAC FIFO, which calls netif_rx(). This netif_rx()
implementation is guarded by local_bh_disable() and local_bh_enable().
The local_bh_enable() may call do_softirq() to run softirqs in case
any are pending. One of the softirqs is net_rx_action, which ultimately
reaches the driver .start_xmit callback. If that happens, the system
hangs. The entire call chain is below:

ks8851_start_xmit_par from netdev_start_xmit
netdev_start_xmit from dev_hard_start_xmit
dev_hard_start_xmit from sch_direct_xmit
sch_direct_xmit from __dev_queue_xmit
__dev_queue_xmit from __neigh_update
__neigh_update from neigh_update
neigh_update from arp_process.constprop.0
arp_process.constprop.0 from __netif_receive_skb_one_core
__netif_receive_skb_one_core from process_backlog
process_backlog from __napi_poll.constprop.0
__napi_poll.constprop.0 from net_rx_action
net_rx_action from __do_softirq
__do_softirq from call_with_stack
call_with_stack from do_softirq
do_softirq from __local_bh_enable_ip
__local_bh_enable_ip from netif_rx
netif_rx from ks8851_irq
ks8851_irq from irq_thread_fn
irq_thread_fn from irq_thread
irq_thread from kthread
kthread from ret_from_fork

The hang happens because ks8851_irq() first locks a spinlock in
ks8851_par.c ks8851_lock_par() spin_lock_irqsave(&ksp->lock, ...)
and with that spinlock locked, calls netif_rx(). Once the execution
reaches ks8851_start_xmit_par(), it calls ks8851_lock_par() again
which attempts to claim the already locked spinlock again, and the
hang happens.

Move the do_softirq() call outside of the spinlock protected section
of ks8851_irq() by disabling BHs around the entire spinlock protected
section of ks8851_irq() handler. Place local_bh_enable() outside of
the spinlock protected section, so that it can trigger do_softirq()
without the ks8851_par.c ks8851_lock_par() spinlock being held, and
safely call ks8851_start_xmit_par() without attempting to lock the
already locked spinlock.

Since ks8851_irq() is protected by local_bh_disable()/local_bh_enable()
now, replace netif_rx() with __netif_rx() which is not duplicating the
local_bh_disable()/local_bh_enable() calls.

Fixes: 797047f875b5 ("net: ks8851: Implement Parallel bus operations")
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "David S. Miller" <davem@davemloft.net>
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Ronald Wahl <ronald.wahl@raritan.com>
Cc: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
---
 drivers/net/ethernet/micrel/ks8851_common.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/micrel/ks8851_common.c b/drivers/net/ethernet/micrel/ks8851_common.c
index 896d43bb8883d..b6b727e651f3d 100644
--- a/drivers/net/ethernet/micrel/ks8851_common.c
+++ b/drivers/net/ethernet/micrel/ks8851_common.c
@@ -299,7 +299,7 @@ static void ks8851_rx_pkts(struct ks8851_net *ks)
 					ks8851_dbg_dumpkkt(ks, rxpkt);
 
 				skb->protocol = eth_type_trans(skb, ks->netdev);
-				netif_rx(skb);
+				__netif_rx(skb);
 
 				ks->netdev->stats.rx_packets++;
 				ks->netdev->stats.rx_bytes += rxlen;
@@ -325,11 +325,15 @@ static void ks8851_rx_pkts(struct ks8851_net *ks)
  */
 static irqreturn_t ks8851_irq(int irq, void *_ks)
 {
+	bool need_bh_off = !(hardirq_count() | softirq_count());
 	struct ks8851_net *ks = _ks;
 	unsigned handled = 0;
 	unsigned long flags;
 	unsigned int status;
 
+	if (need_bh_off)
+		local_bh_disable();
+
 	ks8851_lock(ks, &flags);
 
 	status = ks8851_rdreg16(ks, KS_ISR);
@@ -406,6 +410,9 @@ static irqreturn_t ks8851_irq(int irq, void *_ks)
 	if (status & IRQ_LCI)
 		mii_check_link(&ks->mii);
 
+	if (need_bh_off)
+		local_bh_enable();
+
 	return IRQ_HANDLED;
 }
 
-- 
2.43.0


