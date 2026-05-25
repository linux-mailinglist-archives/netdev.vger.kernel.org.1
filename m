Return-Path: <netdev+bounces-291281-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHzPD2wfFGpGKAcAu9opvQ
	(envelope-from <netdev+bounces-291281-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 12:07:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2A85C8FC5
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 12:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC5D2300C004
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 10:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51999337110;
	Mon, 25 May 2026 10:07:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DC418B0F
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 10:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779703630; cv=none; b=aLTwZmQv9vArHRyJvMAJEdbnbvpbfJ1adOEkAzNvVKZXwjFF5iev5Q5S2a1zJmEkKvDwaSzmF3UFhoqy8anfyXjgcagdx0fpemw9/L4tASJ5LFGwQKNgSNsU0+kdIzKJ4EFOSbVvKXnw6EPV5Is5qf12fiy9n5v8XCHTDspshHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779703630; c=relaxed/simple;
	bh=MiwqICj7Rh8TkJ0z1NfrJPtRm4lhuGiAzfXHuHhM7I0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ans6Q7rpkbSqLMEvHkMmJZKen7IxqJ+VvREefTu1+fAn8QRbcPoVXjdIRhWsOrCHwVjtiG1I7hTiUd00X+QDwXmV0aAM52sKUcD5tzEPpFBjBREBFM8Llkor3Kg9Y3BkbiEyM6oJKSb4264GPCPyX5S1zrAiWIsm3yHw1y5NCdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpgz11t1779703554t60c77371
X-QQ-Originating-IP: XmDGxGWuxIOH8dD7mCsZLhzpAonvfLEJgz1PydRiKms=
Received: from lap-jiawenwu.trustnetic.com ( [122.231.28.113])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 25 May 2026 18:05:53 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10701332685428782613
EX-QQ-RecipientCnt: 12
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v2 1/3] net: wangxun: introduce WX_STATE_DOWN to serialize device shutdown state
Date: Mon, 25 May 2026 18:05:41 +0800
Message-Id: <20260525100543.27140-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260525100543.27140-1-jiawenwu@trustnetic.com>
References: <20260525100543.27140-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NUkHSB3spckt4RtdcmMv3H2bcpnNgnwuOrJ1+vKMp103bxwIEQtYWzht
	8Bvf9rD9TBAvH35ThNs49Fq66grIWYk5YGDmDcwOmyqf+w7C0ionoXXpvOmckTUpNk5zMUL
	pkYBuoohsaDR4B7NcrjqhrOU+tSSGTbXjE/MWjzHXVFoKxJZ/Sk9/KnO6pqsIllzTcGqtuh
	Jyjk+t6f0hbVIMDKlPQXEwBMFCKE/NszQWncSS31C7jc18lOa31zgbt9K7ch5Yfz97bsCuw
	seLHO1duHPL+IqUvG17fYlTx+6oFkBt4LFj5Xb0P9fmCM5Vdme+OnU/E0TVE9+KYN3s7zYD
	l84soR6B1CWwJpj336Tx5W0x+VgYZrT8Jx4U2sb6VhF1zpFgGYLb0p9HPNyHAisQTG1U+vj
	5YADrDOxkDe+p2K7dwnmXdqF5c2t5SeHjjDDkasw4MgtgtznoEz+FzQrQ9aoJ0CVU/PEe2d
	Ed+7RdnQCBgmhqb8VvSjw/5F0h7fXfJcDVlv4VDGLkD/J9Qtp8L2TEf11NcstLiP3HGg5bD
	ng+jqOqUJfZYYEHCYYUtUUJ0X8HQLWtfNK3AY5hyo3cyu2cHUgKvdf1euVXlpiiCqeDzNb9
	dW/7cu37Cax4cDZfEMGsaLvvqmqpq//oL5COEhBAQ1XnXu6u61fUFl0Iz0vQHz7Zj4Fc7zA
	qe2/XKSaStOwWUcNxb3xS6Vd9N6OyojLz7dPNM8DFFTyQ3kFaR0JBDuX4dW3mg0n/sraZ08
	Wk0ZbhhO/dCynwjG5AXdOAY8Vf+MuqdoZ81aUjr7ef6s5cmKPkoEIJFOcfDWeSzFx/p2KSd
	W9rEsPXrzDuFi5L10q7jLO+yjvfdIHXoJyBwgLQQG4xLc2I4bBbNFlaOz2fz1I8V4226iXZ
	is6RIsy0uFiMzBiEbhLL+iXEbUhYqCN3DpIYX+gz4WNBKYkihR0XOH2KTpm6i4YNxEweXBh
	WQIkXY7YDQbSywxcxo02BQ0Wfh8z1wh6lGHZV+VukFQVK2PvKxEeyEjBeNYKp8eC4JUkrdA
	aAUFNKUYCmW+0smxSX6g273Gn8n1ziKE8x5aI09joMx4MHaIdoqK+b1MAceMGwCH+5EsLRJ
	mOycFvyUiKQEDXGgLd+VBs=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-291281-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DMARC_NA(0.00)[trustnetic.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.509];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 9B2A85C8FC5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Replace various netif_running() checks with an explicit WX_STATE_DOWN
state bit to track whether the device datapath and interrupt handling
are operational.

The previous logic relied on netif_running() to gate interrupt
reenablement, queue wakeups, statistics updates, and service task
execution. However, netif_running() only reflects the administrative
state of the netdevice and does not fully serialize against teardown
and reset paths. During device shutdown and reset flows, asynchronous
contexts such as interrupt handlers, NAPI poll, and service work could
still observe netif_running() as true while device resources were
already being disabled or freed.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c        |  3 ++-
 drivers/net/ethernet/wangxun/libwx/wx_lib.c       |  9 ++++++---
 drivers/net/ethernet/wangxun/libwx/wx_sriov.c     |  2 +-
 drivers/net/ethernet/wangxun/libwx/wx_type.h      |  1 +
 drivers/net/ethernet/wangxun/libwx/wx_vf_common.c |  8 ++++++--
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c     | 12 ++++++++----
 drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c    |  2 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c   |  4 ++++
 8 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 2451f6b20b11..260e14d5d541 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -2520,6 +2520,7 @@ int wx_sw_init(struct wx *wx)
 	mutex_init(&wx->reset_lock);
 	bitmap_zero(wx->state, WX_STATE_NBITS);
 	bitmap_zero(wx->flags, WX_PF_FLAGS_NBITS);
+	set_bit(WX_STATE_DOWN, wx->state);
 	wx->misc_irq_domain = false;
 
 	return 0;
@@ -2875,7 +2876,7 @@ void wx_update_stats(struct wx *wx)
 	u64 restart_queue = 0, tx_busy = 0;
 	u32 i;
 
-	if (!netif_running(wx->netdev) ||
+	if (test_bit(WX_STATE_DOWN, wx->state) ||
 	    test_bit(WX_STATE_RESETTING, wx->state))
 		return;
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 746623fa59b4..d042567b8128 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -876,7 +876,7 @@ static bool wx_clean_tx_irq(struct wx_q_vector *q_vector,
 
 		if (__netif_subqueue_stopped(tx_ring->netdev,
 					     tx_ring->queue_index) &&
-		    netif_running(tx_ring->netdev)) {
+		    !test_bit(WX_STATE_DOWN, wx->state)) {
 			netif_wake_subqueue(tx_ring->netdev,
 					    tx_ring->queue_index);
 			++tx_ring->tx_stats.restart_queue;
@@ -964,7 +964,7 @@ static int wx_poll(struct napi_struct *napi, int budget)
 	if (likely(napi_complete_done(napi, work_done))) {
 		if (wx->adaptive_itr)
 			wx_update_dim_sample(q_vector);
-		if (netif_running(wx->netdev))
+		if (!test_bit(WX_STATE_DOWN, wx->state))
 			wx_intr_enable(wx, WX_INTR_Q(q_vector->v_idx));
 	}
 
@@ -2341,6 +2341,8 @@ int wx_init_interrupt_scheme(struct wx *wx)
 
 	wx_cache_ring_rss(wx);
 
+	set_bit(WX_STATE_DOWN, wx->state);
+
 	return 0;
 }
 EXPORT_SYMBOL(wx_init_interrupt_scheme);
@@ -3314,7 +3316,8 @@ EXPORT_SYMBOL(wx_set_ring);
 
 void wx_service_event_schedule(struct wx *wx)
 {
-	if (!test_and_set_bit(WX_STATE_SERVICE_SCHED, wx->state))
+	if (!test_bit(WX_STATE_DOWN, wx->state) &&
+	    !test_and_set_bit(WX_STATE_SERVICE_SCHED, wx->state))
 		queue_work(system_power_efficient_wq, &wx->service_task);
 }
 EXPORT_SYMBOL(wx_service_event_schedule);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
index a360b06a086a..0152004a2dd3 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
@@ -898,7 +898,7 @@ static void wx_set_vf_link_state(struct wx *wx, int vf, int state)
 	wx->vfinfo[vf].link_state = state;
 	switch (state) {
 	case IFLA_VF_LINK_STATE_AUTO:
-		if (netif_running(wx->netdev))
+		if (!test_bit(WX_STATE_DOWN, wx->state))
 			wx->vfinfo[vf].link_enable = true;
 		else
 			wx->vfinfo[vf].link_enable = false;
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 0da5565ee4ff..c7befe4cdfe9 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1202,6 +1202,7 @@ struct wx_last_stats {
 };
 
 enum wx_state {
+	WX_STATE_DOWN,
 	WX_STATE_RESETTING,
 	WX_STATE_SWFW_BUSY,
 	WX_STATE_PTP_RUNNING,
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
index 94ff8f5f0b4c..0d2db8d38cd5 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
@@ -68,7 +68,7 @@ static irqreturn_t wx_msix_misc_vf(int __always_unused irq, void *data)
 
 	set_bit(WX_FLAG_NEED_UPDATE_LINK, wx->flags);
 	/* Clear the interrupt */
-	if (netif_running(wx->netdev))
+	if (!test_bit(WX_STATE_DOWN, wx->state))
 		wr32(wx, WX_VXIMC, wx->eims_other);
 
 	return IRQ_HANDLED;
@@ -278,6 +278,7 @@ static void wxvf_up_complete(struct wx *wx)
 
 	wx_configure_msix_vf(wx);
 	smp_mb__before_atomic();
+	clear_bit(WX_STATE_DOWN, wx->state);
 	wx_napi_enable_all(wx);
 
 	/* clear any pending interrupts, may auto mask */
@@ -327,6 +328,9 @@ static void wxvf_down(struct wx *wx)
 {
 	struct net_device *netdev = wx->netdev;
 
+	if (test_and_set_bit(WX_STATE_DOWN, wx->state))
+		return;
+
 	timer_delete_sync(&wx->service_timer);
 	netif_tx_stop_all_queues(netdev);
 	netif_tx_disable(netdev);
@@ -360,7 +364,7 @@ static void wxvf_reset_subtask(struct wx *wx)
 
 	rtnl_lock();
 	if (test_bit(WX_STATE_RESETTING, wx->state) ||
-	    !(netif_running(wx->netdev))) {
+	    test_bit(WX_STATE_DOWN, wx->state)) {
 		rtnl_unlock();
 		return;
 	}
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index d51d8db95a76..f4a2dd6fa493 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -204,7 +204,7 @@ static irqreturn_t ngbe_intr(int __always_unused irq, void *data)
 		/* shared interrupt alert!
 		 * the interrupt that we masked before the EICR read.
 		 */
-		if (netif_running(wx->netdev))
+		if (!test_bit(WX_STATE_DOWN, wx->state))
 			ngbe_irq_enable(wx, true);
 		return IRQ_NONE;        /* Not our interrupt */
 	}
@@ -220,7 +220,7 @@ static irqreturn_t ngbe_intr(int __always_unused irq, void *data)
 	/* would disable interrupts here but it is auto disabled */
 	napi_schedule_irqoff(&q_vector->napi);
 
-	if (netif_running(wx->netdev))
+	if (!test_bit(WX_STATE_DOWN, wx->state))
 		ngbe_irq_enable(wx, false);
 
 	return IRQ_HANDLED;
@@ -235,7 +235,7 @@ static irqreturn_t __ngbe_msix_misc(struct wx *wx, u32 eicr)
 		wx_ptp_check_pps_event(wx);
 
 	/* re-enable the original interrupt state, no lsc, no queues */
-	if (netif_running(wx->netdev))
+	if (!test_bit(WX_STATE_DOWN, wx->state))
 		ngbe_irq_enable(wx, false);
 
 	return IRQ_HANDLED;
@@ -262,7 +262,7 @@ static irqreturn_t ngbe_misc_and_queue(int __always_unused irq, void *data)
 		/* queue */
 		q_vector = wx->q_vector[0];
 		napi_schedule_irqoff(&q_vector->napi);
-		if (netif_running(wx->netdev))
+		if (!test_bit(WX_STATE_DOWN, wx->state))
 			ngbe_irq_enable(wx, true);
 		return IRQ_HANDLED;
 	}
@@ -363,6 +363,9 @@ static void ngbe_disable_device(struct wx *wx)
 	struct net_device *netdev = wx->netdev;
 	u32 i;
 
+	if (test_and_set_bit(WX_STATE_DOWN, wx->state))
+		return;
+
 	if (wx->num_vfs) {
 		/* Clear EITR Select mapping */
 		wr32(wx, WX_PX_ITRSEL, 0);
@@ -428,6 +431,7 @@ void ngbe_up(struct wx *wx)
 
 	/* make sure to complete pre-operations */
 	smp_mb__before_atomic();
+	clear_bit(WX_STATE_DOWN, wx->state);
 	wx_napi_enable_all(wx);
 	/* enable transmits */
 	netif_tx_start_all_queues(wx->netdev);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
index aa14958d439a..8746318ad3bc 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
@@ -141,7 +141,7 @@ static irqreturn_t txgbe_misc_irq_handle(int irq, void *data)
 		/* shared interrupt alert!
 		 * the interrupt that we masked before the ICR read.
 		 */
-		if (netif_running(wx->netdev))
+		if (!test_bit(WX_STATE_DOWN, wx->state))
 			txgbe_irq_enable(wx, true);
 		return IRQ_NONE;        /* Not our interrupt */
 	}
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index 4c549c2644ab..f9cd1caaf0a4 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -151,6 +151,7 @@ static void txgbe_up_complete(struct wx *wx)
 
 	/* make sure to complete pre-operations */
 	smp_mb__before_atomic();
+	clear_bit(WX_STATE_DOWN, wx->state);
 	wx_napi_enable_all(wx);
 
 	switch (wx->mac.type) {
@@ -213,6 +214,9 @@ static void txgbe_disable_device(struct wx *wx)
 	struct net_device *netdev = wx->netdev;
 	u32 i;
 
+	if (test_and_set_bit(WX_STATE_DOWN, wx->state))
+		return;
+
 	wx_disable_pcie_master(wx);
 	/* disable receives */
 	wx_disable_rx(wx);
-- 
2.51.0


