Return-Path: <netdev+bounces-289320-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIL1MMcaDGpJWQUAu9opvQ
	(envelope-from <netdev+bounces-289320-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 10:09:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC90579B2E
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 10:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1632300D94D
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 08:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FCF3DFC70;
	Tue, 19 May 2026 08:02:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134053D9025
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 08:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779177753; cv=none; b=p2cPlDhsQu4JY6oQ5Ulg2OXKArWz7xWuZG2bdt6rW4Hi1H6tahk4hRvLbrE+ZX3oI4unDSJheb9dsJKjh9yXssjD2XrEw+Pm+Zno84e5f1DrRNp5tppSxktQez+XiApBygnqXohd/FxNk4BWW0YghLLZAgPnc6mOXDLr+MuJ7ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779177753; c=relaxed/simple;
	bh=AKhwfcm+p4QJvY+BQwxr4YhFUZRUWaZLTnUnALqX/Bw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nT8UdFa5tkEayjpvmHJ6F/O+dLLu4cy2VIcwvlAfcesls0tFh3qXw26HDQ18eTH53AR2YM1dpQPVsgjo8kOCKFYYCeU0ZQbxMkPA1+pEAfvuVWLVmxbb7LM6FxKmoFzicm4341C+x/8Qz7ItoXLlN34FT2a0FqOidl/hHPX1z0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz10t1779177665t0fd74b34
X-QQ-Originating-IP: oqBsafx1S2QcvyMC0qZMOB9P4T2g3Ykn+X4FKj7SQ9A=
Received: from lap-jiawenwu.trustnetic.com ( [115.196.16.37])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 19 May 2026 16:01:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2652097943457501646
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
Subject: [PATCH net-next v1 1/3] net: wangxun: introduce WX_STATE_DOWN to serialize device shutdown state
Date: Tue, 19 May 2026 16:00:46 +0800
Message-Id: <20260519080048.7448-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260519080048.7448-1-jiawenwu@trustnetic.com>
References: <20260519080048.7448-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MB1Li/8byKSy0SQmykVSdu1FdOzWFX0wVVSJjE5P7GCqABrYJlNm8a8y
	IvnpETDkf6qKxmKbcWs5EHoxFAu4hUUDKYfHrRA7uqjBZ0iqoe9HrxHDOA+ogmqHIxr5RAp
	q1V1MY2Z+SuahDV6JmdyirzrkH5Jeh7sJloLNnni9tbB76FoH8u6ga1lBdTNltR34s70Bnr
	u8Nf3vqzINuAWAnOZy2kV4pd47b8JrlFJlBQjGNdVNyl7cPnd5JZjTQszcA94N1Ig/Xekna
	yPWJQrX+3EClDp1p0ZDW+SSJ+LtZPvAtk3MyaLObg1y1zq8b7uIjtzyX5vGC/3BJ8s62og5
	2XSCbBpwHtEcJnpubSSR/sYQ+gY9zXUc3WxC3JEjKL2VmROwVSiVjuZIP0DVSymy+xeMBxQ
	DTNR26Xw96PKPF0sibzioplStwuTLAOMlhBoRYD6HiNVr+BcTjwipnGeTpnq8ik+ExHMSTx
	+Oy5fKyvwOxnGAlErZEVFnfun0vYCbuIG1cdkCSKc5PEhGqd/g56jebWf+QUD4R6JhxZrO5
	9alxLlMF3xvCJt6hE1Na8PvRg7pz6s+WURPRutyIjROnvhIK1IIMYRZBS1yy5ugT2Bka3oU
	dh6G/ANdUUy9TWgt88JgtCURWFhDFKQ0/+8cq8tQlg9LUIevowlLGzE25BLSptM74D6nUY0
	ghyXcBEEM2cYqdBKNj1FDKtytYt1dqhnZcQuDhvBWkdfELwOFLjBG3cpH7Kf9oYMO7J9ta5
	Eft9v7fP8ZT3hjH909bBewDjQsW/vHa8mZ4mHwDHwIvhrXAcPwQNjSfwYxX2z5Y9f8hWV3j
	1hfgkumoILla4Y0c5G1hXzEvHBpXH0Yp2atoGRFhD0L2fWOE4xfnUJ0oaPlRe3Rkxk+Uq3A
	dSlVR1jI6ntjRMzS7hzvLH8Ed9KDnz2yrm+WVlM5saMMubHbRhSSywmJ5VPBjtMeRP2l7E0
	x8molPofUYWJcIyepnjnxpO5OEk0q8bca7FcWzHJscxeeUpXCdPcbHXe5H4OVCkCDVf0iVa
	g6Lda0bQHz0IF2xH2yQ9YzXTYRg6h0+e9hlJT8mx4Z5Bv65mWA
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[trustnetic.com];
	TAGGED_FROM(0.00)[bounces-289320-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[trustnetic.com:mid,trustnetic.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2FC90579B2E
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
index 746623fa59b4..69fe19737679 100644
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
+	if (!test_and_set_bit(WX_STATE_SERVICE_SCHED, wx->state) &&
+	    !test_bit(WX_STATE_DOWN, wx->state))
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


