Return-Path: <netdev+bounces-154696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C21779FF7D4
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 11:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8C601882D62
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 10:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D04A19C540;
	Thu,  2 Jan 2025 10:11:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.124.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE5319068E
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 10:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.124.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735812664; cv=none; b=hVZuJawhIRIb7WLFdnTET1hMA9FdJebqUX5ONejKdeAPSCWwyZYja189lQc+9Y7KVEjYy+aJJg7zIFXdXwOWm9ntFkfsOon0gZeHEfvHBUezzBx2Ua9kAKJBow45eGHPCQpXclwjd4iXkBTy8h4Ll2wWFimWQp0eG8G+IRVJDC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735812664; c=relaxed/simple;
	bh=wwmCJVVWzkk5urvbFYGOX2v4/8TDyFLOdN+i4ozQhbg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MRDZUzthkxF126pMoynNuiL/OJt/Ssx4Q9UxRRMbIwxSZOv/XDVmFy4woDaUclCitKqCecy3XwaisiSzTAGWkZ2tTBJFOQJURSrQDQHnGbF6bfxg5V2bfoWBMnpJuF//Bb+oLFU59IBi23n7oDfiuPhOIQXi8KTMyYE4Ds+MLxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=114.132.124.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtpsz2t1735812575t2ggcas
X-QQ-Originating-IP: dpXcMPxvhVbYF20FnWRwvAMU9W+U/ep93SkvCHwOpfE=
Received: from wxdbg.localdomain.com ( [115.220.136.229])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 02 Jan 2025 18:09:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10001004045011985822
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	linux@armlinux.org.uk,
	horms@kernel.org,
	jacob.e.keller@intel.com,
	netdev@vger.kernel.org
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next 3/4] net: wangxun: Add watchdog task for PTP clock
Date: Thu,  2 Jan 2025 18:30:25 +0800
Message-Id: <20250102103026.1982137-4-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20250102103026.1982137-1-jiawenwu@trustnetic.com>
References: <20250102103026.1982137-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: N0fHFfxtkpsjHbwKOS9wf3e9d8mf5sNV8gv6JzzOZEKZzjtPrjZYiOsn
	I37SAl4ZISDanf2//EWAFfxHPW/eVKAwKc6FY71LqDrIvL3xLRVT2covj62y5HGBaTPUYDO
	ZZiFCAclWg5Gqf41Sn6GWKa1Z+G3V9EWhYV/mYvZ66RC3kpfG571aa4zXFA03S2Vx2NQD3x
	yI46+ihTLhoJtErS7SEhkKiRZlI9nXdbO8l4XKmYgDbA0IJfykIlb73UxF2DmepcMuw0yB9
	2xqz5J0ep1yqTn/yMoSoLMjp1D1VfAuqcr7moEWx1pElqHRHFERVjF85UeOuFSUw+SxkQY+
	TpbFN4Bf+cNUYssmMPJTuDJXQdx3iUnsxlGAoeq4RDmRAkDQ/J5mhNtAOt6+vQ4CMmOnm4j
	pCjpzOZnp3neEc5TsCtzrQb8VWASI9/A++FOAvZU2IWFpHWfbqJN5UUQ4xfwrWaJD/4S+ij
	/L15uKod2gYv6O7BELQcvDOjLbhDHg1/k6wuOi29wAhPjMl23G8dHe0t1kaU/y5E4wdUjW7
	X4imBiqr3nHiUSHZDgk2DUo4Hm+eZ6JSwBtiPONOSH4klL+GKcXLIgHvoXg5hZrakrHKO6/
	eg914g5hEsuQ8tHuZKr9uCaF0YATDA++z9PPNVCBq44gglwj2auc9Rs1y2c5/gfhc2Pcf2S
	um/MbCEYjsjYUX6a3iipoFxjNwTpKG04GuQFhFsquoZXvFtzTqxyX69tzTTq2Iw+P7GEe+P
	KNb3VNgx+x+5ILayxZfnVNmdOMiHrKT4FIK3G71Isyo6b1Rj52KJ+3mixE7Prlf5Ee93xr4
	2r47M/+l2Nz2mpvUCQQxYkoPbkfkcZOD9EJ3goBcGbAv7PmYyBo4k55VAiizPSu00eW/feH
	oC1hPLAOoYK9LexmkKLizr2k6L89/uRV/kT/13oIwjEQv7DWrLpM6/wQyFKfI+aM2m172DJ
	Y/XYWwizU4h4lsBZGYa59QEsTx7UBfxdz2Zd1Mo1tGt+B1kJCLEf3tRtn+rDEixS++6c9mx
	t5/4rGgw==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

Implement watchdog task to detect SYSTIME overflow and error cases of
Rx/Tx timestamp.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 57 +++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |  2 +
 drivers/net/ethernet/wangxun/libwx/wx_ptp.c   | 99 +++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_ptp.h   |  3 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  6 ++
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  8 ++
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c |  1 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  7 ++
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |  1 +
 9 files changed, 184 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index be1dcc278612..c6db69406f15 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2019 - 2022 Beijing WangXun Technology Co., Ltd. */
 
 #include <linux/etherdevice.h>
+#include <linux/workqueue.h>
 #include <net/ip6_checksum.h>
 #include <net/page_pool/helpers.h>
 #include <net/inet_ecn.h>
@@ -2909,6 +2910,62 @@ void wx_set_ring(struct wx *wx, u32 new_tx_count,
 }
 EXPORT_SYMBOL(wx_set_ring);
 
+void wx_service_event_schedule(struct wx *wx)
+{
+	if (netif_carrier_ok(wx->netdev) &&
+	    !test_and_set_bit(WX_STATE_SERVICE_SCHED, wx->state))
+		queue_work(system_power_efficient_wq, &wx->service_task);
+}
+EXPORT_SYMBOL(wx_service_event_schedule);
+
+static void wx_service_event_complete(struct wx *wx)
+{
+	if (WARN_ON(!test_bit(WX_STATE_SERVICE_SCHED, wx->state)))
+		return;
+
+	/* flush memory to make sure state is correct before next watchdog */
+	smp_mb__before_atomic();
+	clear_bit(WX_STATE_SERVICE_SCHED, wx->state);
+}
+
+static void wx_service_timer(struct timer_list *t)
+{
+	struct wx *wx = from_timer(wx, t, service_timer);
+	unsigned long next_event_offset = HZ * 2;
+
+	/* Reset the timer */
+	mod_timer(&wx->service_timer, next_event_offset + jiffies);
+
+	wx_service_event_schedule(wx);
+}
+
+/**
+ * wx_service_task - manages and runs subtasks
+ * @work: pointer to work_struct containing our data
+ **/
+static void wx_service_task(struct work_struct *work)
+{
+	struct wx *wx = container_of(work, struct wx, service_task);
+
+	if (test_bit(WX_STATE_PTP_RUNNING, wx->state)) {
+		wx_ptp_overflow_check(wx);
+		if (unlikely(test_bit(WX_FLAG_RX_HWTSTAMP_IN_REGISTER,
+				      wx->flags)))
+			wx_ptp_rx_hang(wx);
+		wx_ptp_tx_hang(wx);
+	}
+
+	wx_service_event_complete(wx);
+}
+
+void wx_init_service(struct wx *wx)
+{
+	timer_setup(&wx->service_timer, wx_service_timer, 0);
+	INIT_WORK(&wx->service_task, wx_service_task);
+	clear_bit(WX_STATE_SERVICE_SCHED, wx->state);
+}
+EXPORT_SYMBOL(wx_init_service);
+
 int wx_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
 {
 	struct wx *wx = netdev_priv(netdev);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.h b/drivers/net/ethernet/wangxun/libwx/wx_lib.h
index d67a33216811..77c4ea4baabf 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.h
@@ -35,6 +35,8 @@ netdev_features_t wx_fix_features(struct net_device *netdev,
 				  netdev_features_t features);
 void wx_set_ring(struct wx *wx, u32 new_tx_count,
 		 u32 new_rx_count, struct wx_ring *temp_ring);
+void wx_service_event_schedule(struct wx *wx);
+void wx_init_service(struct wx *wx);
 int wx_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd);
 
 #endif /* _NGBE_LIB_H_ */
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
index d78f99cf4a10..2047667ce0fe 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
@@ -571,6 +571,8 @@ void wx_ptp_reset(struct wx *wx)
 	timecounter_init(&wx->hw_tc, &wx->hw_cc,
 			 ktime_to_ns(ktime_get_real()));
 	spin_unlock_irqrestore(&wx->tmreg_lock, flags);
+
+	wx->last_overflow_check = jiffies;
 }
 EXPORT_SYMBOL(wx_ptp_reset);
 
@@ -717,3 +719,100 @@ int wx_ptp_set_ts_config(struct wx *wx, struct ifreq *ifr)
 	return copy_to_user(ifr->ifr_data, &config, sizeof(config)) ?
 		-EFAULT : 0;
 }
+
+/**
+ * wx_ptp_overflow_check - watchdog task to detect SYSTIME overflow
+ * @wx: pointer to wx struct
+ *
+ * this watchdog task periodically reads the timecounter
+ * in order to prevent missing when the system time registers wrap
+ * around. This needs to be run approximately twice a minute for the fastest
+ * overflowing hardware. We run it for all hardware since it shouldn't have a
+ * large impact.
+ */
+void wx_ptp_overflow_check(struct wx *wx)
+{
+	bool timeout = time_is_before_jiffies(wx->last_overflow_check +
+					      WX_OVERFLOW_PERIOD);
+	unsigned long flags;
+
+	if (timeout) {
+		/* Update the timecounter */
+		spin_lock_irqsave(&wx->tmreg_lock, flags);
+		timecounter_read(&wx->hw_tc);
+		spin_unlock_irqrestore(&wx->tmreg_lock, flags);
+
+		wx->last_overflow_check = jiffies;
+	}
+}
+
+/**
+ * wx_ptp_rx_hang - detect error case when Rx timestamp registers latched
+ * @wx: pointer to wx struct
+ *
+ * this watchdog task is scheduled to detect error case where hardware has
+ * dropped an Rx packet that was timestamped when the ring is full. The
+ * particular error is rare but leaves the device in a state unable to
+ * timestamp any future packets.
+ */
+void wx_ptp_rx_hang(struct wx *wx)
+{
+	struct wx_ring *rx_ring;
+	unsigned long rx_event;
+	u32 tsyncrxctl;
+	int n;
+
+	tsyncrxctl = rd32(wx, WX_PSR_1588_CTL);
+
+	/* if we don't have a valid timestamp in the registers, just update the
+	 * timeout counter and exit
+	 */
+	if (!(tsyncrxctl & WX_PSR_1588_CTL_VALID)) {
+		wx->last_rx_ptp_check = jiffies;
+		return;
+	}
+
+	/* determine the most recent watchdog or rx_timestamp event */
+	rx_event = wx->last_rx_ptp_check;
+	for (n = 0; n < wx->num_rx_queues; n++) {
+		rx_ring = wx->rx_ring[n];
+		if (time_after(rx_ring->last_rx_timestamp, rx_event))
+			rx_event = rx_ring->last_rx_timestamp;
+	}
+
+	/* only need to read the high RXSTMP register to clear the lock */
+	if (time_is_before_jiffies(rx_event + 5 * HZ)) {
+		rd32(wx, WX_PSR_1588_STMPH);
+		wx->last_rx_ptp_check = jiffies;
+
+		wx->rx_hwtstamp_cleared++;
+		dev_warn(&wx->pdev->dev, "clearing RX Timestamp hang");
+	}
+}
+
+/**
+ * wx_ptp_tx_hang - detect error case where Tx timestamp never finishes
+ * @wx: private network wx structure
+ */
+void wx_ptp_tx_hang(struct wx *wx)
+{
+	bool timeout = time_is_before_jiffies(wx->ptp_tx_start +
+					      WX_PTP_TX_TIMEOUT);
+
+	if (!wx->ptp_tx_skb)
+		return;
+
+	if (!test_bit(WX_STATE_PTP_TX_IN_PROGRESS, wx->state))
+		return;
+
+	/* If we haven't received a timestamp within the timeout, it is
+	 * reasonable to assume that it will never occur, so we can unlock the
+	 * timestamp bit when this occurs.
+	 */
+	if (timeout) {
+		cancel_work_sync(&wx->ptp_tx_work);
+		wx_ptp_clear_tx_timestamp(wx);
+		wx->tx_hwtstamp_timeouts++;
+		dev_warn(&wx->pdev->dev, "clearing Tx timestamp hang\n");
+	}
+}
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ptp.h b/drivers/net/ethernet/wangxun/libwx/wx_ptp.h
index 0fdc4f808636..4a7a9cda2a35 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ptp.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ptp.h
@@ -9,6 +9,9 @@ void wx_ptp_reset(struct wx *wx);
 void wx_ptp_init(struct wx *wx);
 void wx_ptp_suspend(struct wx *wx);
 void wx_ptp_stop(struct wx *wx);
+void wx_ptp_overflow_check(struct wx *wx);
+void wx_ptp_rx_hang(struct wx *wx);
+void wx_ptp_tx_hang(struct wx *wx);
 void wx_ptp_rx_hwtstamp(struct wx *wx, struct sk_buff *skb);
 int wx_ptp_get_ts_config(struct wx *wx, struct ifreq *ifr);
 int wx_ptp_set_ts_config(struct wx *wx, struct ifreq *ifr);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 4fa817f55c0a..706ee8dd99c1 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1057,6 +1057,7 @@ struct wx_hw_stats {
 
 enum wx_state {
 	WX_STATE_RESETTING,
+	WX_STATE_SERVICE_SCHED,
 	WX_STATE_PTP_RUNNING,
 	WX_STATE_PTP_TX_IN_PROGRESS,
 	WX_STATE_NBITS,		/* must be last */
@@ -1169,10 +1170,15 @@ struct wx {
 	void (*configure_fdir)(struct wx *wx);
 	void (*do_reset)(struct net_device *netdev);
 
+	struct timer_list service_timer;
+	struct work_struct service_task;
+
 	u32 base_incval;
 	u32 tx_hwtstamp_timeouts;
 	u32 tx_hwtstamp_skipped;
 	u32 rx_hwtstamp_cleared;
+	unsigned long last_overflow_check;
+	unsigned long last_rx_ptp_check;
 	unsigned long ptp_tx_start;
 	spinlock_t tmreg_lock; /* spinlock for ptp */
 	struct cyclecounter hw_cc;
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index 655433bd5545..83bc0100fb3e 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -304,6 +304,9 @@ static void ngbe_disable_device(struct wx *wx)
 	if (wx->gpio_ctrl)
 		ngbe_sfp_modules_txrx_powerctl(wx, false);
 	wx_irq_disable(wx);
+
+	del_timer_sync(&wx->service_timer);
+
 	/* disable transmits in the hardware now that interrupts are off */
 	for (i = 0; i < wx->num_tx_queues; i++) {
 		u8 reg_idx = wx->tx_ring[i]->reg_idx;
@@ -342,6 +345,7 @@ void ngbe_up(struct wx *wx)
 		ngbe_sfp_modules_txrx_powerctl(wx, true);
 
 	phylink_start(wx->phylink);
+	mod_timer(&wx->service_timer, jiffies);
 }
 
 /**
@@ -685,6 +689,8 @@ static int ngbe_probe(struct pci_dev *pdev,
 	eth_hw_addr_set(netdev, wx->mac.perm_addr);
 	wx_mac_set_default_filter(wx, wx->mac.perm_addr);
 
+	wx_init_service(wx);
+
 	err = wx_init_interrupt_scheme(wx);
 	if (err)
 		goto err_free_mac_table;
@@ -731,6 +737,8 @@ static void ngbe_remove(struct pci_dev *pdev)
 	struct wx *wx = pci_get_drvdata(pdev);
 	struct net_device *netdev;
 
+	cancel_work_sync(&wx->service_task);
+
 	netdev = wx->netdev;
 	unregister_netdev(netdev);
 	phylink_destroy(wx->phylink);
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
index 7282ca53d834..623c615361a9 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
@@ -111,6 +111,7 @@ static void ngbe_mac_link_up(struct phylink_config *config,
 	wr32(wx, WX_MAC_WDG_TIMEOUT, reg);
 
 	wx->speed = speed;
+	wx->last_rx_ptp_check = jiffies;
 	if (test_bit(WX_STATE_PTP_RUNNING, wx->state))
 		wx_ptp_start_cyclecounter(wx);
 }
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index c0e800d0f66b..fccfd02b0e54 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -100,6 +100,7 @@ static void txgbe_up_complete(struct wx *wx)
 
 	/* enable transmits */
 	netif_tx_start_all_queues(netdev);
+	mod_timer(&wx->service_timer, jiffies);
 }
 
 static void txgbe_reset(struct wx *wx)
@@ -142,6 +143,8 @@ static void txgbe_disable_device(struct wx *wx)
 	wx_irq_disable(wx);
 	wx_napi_disable_all(wx);
 
+	del_timer_sync(&wx->service_timer);
+
 	if (wx->bus.func < 2)
 		wr32m(wx, TXGBE_MIS_PRB_CTL, TXGBE_MIS_PRB_CTL_LAN_UP(wx->bus.func), 0);
 	else
@@ -631,6 +634,8 @@ static int txgbe_probe(struct pci_dev *pdev,
 	eth_hw_addr_set(netdev, wx->mac.perm_addr);
 	wx_mac_set_default_filter(wx, wx->mac.perm_addr);
 
+	wx_init_service(wx);
+
 	err = wx_init_interrupt_scheme(wx);
 	if (err)
 		goto err_free_mac_table;
@@ -751,6 +756,8 @@ static void txgbe_remove(struct pci_dev *pdev)
 	struct txgbe *txgbe = wx->priv;
 	struct net_device *netdev;
 
+	cancel_work_sync(&wx->service_task);
+
 	netdev = wx->netdev;
 	unregister_netdev(netdev);
 
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
index f6f3c94de97a..2cafb723a4d9 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
@@ -222,6 +222,7 @@ static void txgbe_mac_link_up(struct phylink_config *config,
 	wr32(wx, WX_MAC_WDG_TIMEOUT, wdg);
 
 	wx->speed = speed;
+	wx->last_rx_ptp_check = jiffies;
 	if (test_bit(WX_STATE_PTP_RUNNING, wx->state))
 		wx_ptp_start_cyclecounter(wx);
 }
-- 
2.27.0


