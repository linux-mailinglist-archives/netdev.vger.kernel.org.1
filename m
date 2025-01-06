Return-Path: <netdev+bounces-155375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F896A020A2
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 09:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AFF53A306C
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 08:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021761D7E4A;
	Mon,  6 Jan 2025 08:25:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4C41D63CF
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 08:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736151906; cv=none; b=f2+qyS1a2PwImVcPM7VmSLDGEWrNZmDFFX6uTN/vALcjFV+9/0hscVzPecpFC2pebWDW3Xl+7qtBGZaNmQUZiOlrRVMFTJvKWGU872kOoiadBqIvZRnzKLk/LuV+iNDBQt2H+JErEf2lNYxU12TFUjdENw/DRudqykb3I/eKiuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736151906; c=relaxed/simple;
	bh=3G0KQgA3vAi3n+XXVtenik8jimtwI+qxMlkuYh2lnDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mfjox4XFPusXR/X8eWgT50s/nEVWs2TgK+cIYW4i3NqrcAG4fyVnC2UXEVZTdKfCTvfZEAWiuBwWuBVNODyP4KxksW4BdyPFXIThKdD5FtP43tNLYnPDPs25krZD035IsQq+jV7Zz5pWz5vctvm2uIgCjPpMspg41MZWvBGZXjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtpsz14t1736151871t0senq
X-QQ-Originating-IP: i9frT461jKUaGF5UPhNAW8sAfkZl7IsXALWXlbwDZA8=
Received: from wxdbg.localdomain ( [125.118.30.165])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 06 Jan 2025 16:24:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7605833486242641068
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
	netdev@vger.kernel.org,
	vadim.fedorenko@linux.dev
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v2 3/4] net: wangxun: Implement do_aux_work of ptp_clock_info
Date: Mon,  6 Jan 2025 16:45:05 +0800
Message-Id: <20250106084506.2042912-4-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20250106084506.2042912-1-jiawenwu@trustnetic.com>
References: <20250106084506.2042912-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MFrsSwQn8ixcBCt+OYyXIDS+Z9gvUAq0GlLm6lTtBMSUCoQWFvjdmLJb
	XE/t82wUNlW78nmFPrytJ7nl8cW2ibWgUWTKErL14zVuX86elnaTA7kXaM20gY2kzaaceNL
	L3EHGn0Jih6GY9a6ZHVilGiIauwZBJbxG5nmHwaIzZwuO+WZZ+33brYAYXFF1rPjjD4pu9Y
	7zbET+lB+BrcCjq6Hq5dumd1G4HBVQjRtmtyc9ouHhoLk710ACx7GKkTQ9gKcRicP2nSrhw
	i9aNxRljp1w7fgLExG3rUaNPtnrmpLSXNw9ZUSqkadiw68g5kmlP9v5AkMnoB2zzktAJIr1
	/uvxIQe6FO00y7KLYL8kbaqH9ZAhNy0ZOVQWgbp/uLDn8F2RKgr0Kve8xqfpI2VpCaWp5n+
	uUqifAEPsIms1rb3DtEc+F7Iff8LgWijrbekvpNcGnhxXRN696CEqe4iyo6Y6YTcVnm+/Gs
	oumlAm1uGwOPQ0Yn6bUrwtUxEoQgl+I1yavLBSSV7QtjRfeTR4q+rn1PQIQo2GYBc7ZHa4l
	4NGT1NQ30q+fEc632XKwgsynEg2GX6MyCMSjhJgTgw72umYePNxO/M23Mgm5r0tXiZp1hYv
	Pj3MiAF1ydI1pCubD3CeYMK/ClA56xwJ2jwovKKR/2AAvLOtlg6KJJbO9ZDa70R+lyLxLQz
	kBsXERi0a0C/fYY3AeyMomLyNnU4qEUufmNmq/cUmv5GQuJy247HybXuR5NAl0MitMCq3+J
	xp0Jeqy1pQtxgKvpEfaUJg1VwawlZ76Hi2Kz6Yfz93Laa5GhzpG+eOl6uZX5AIW27QcKYJ8
	vpIfhUffxlKDO6xLKaBxct/US/DtZe2satNFQCvv/G96xBajattbi/Bthx/AfdQt2op+4Yr
	yeqvNUR3mHw2eRr2NitpxX/6Pg9IonV45BCsasc/q5f2nDxZhSzWfMO7kt+Vbj1c4fW9cUt
	Ht19EprgRI2ltIwiyX/9n26hRo78sX+WVJo4jnP/Fe/vpDfx/ds9V9iYz81lUDK/owMTRaU
	9nxufo6TuBU4lFlpmZaAVebgy3rmLmGlzCKcD6voimtHb16lyi
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

Implement watchdog task to detect SYSTIME overflow and error cases of
Rx/Tx timestamp.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_ptp.c   | 211 ++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |   2 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c |   1 +
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |   1 +
 4 files changed, 215 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
index 0f683e576b29..0071ba929738 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
@@ -255,6 +255,215 @@ static void wx_ptp_tx_hwtstamp_work(struct work_struct *work)
 	}
 }
 
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
+static void wx_ptp_overflow_check(struct wx *wx)
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
+static void wx_ptp_rx_hang(struct wx *wx)
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
+static void wx_ptp_tx_hang(struct wx *wx)
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
+
+static long wx_ptp_do_aux_work(struct ptp_clock_info *ptp)
+{
+	struct wx *wx = container_of(ptp, struct wx, ptp_caps);
+
+	wx_ptp_overflow_check(wx);
+	if (unlikely(test_bit(WX_FLAG_RX_HWTSTAMP_IN_REGISTER,
+			      wx->flags)))
+		wx_ptp_rx_hang(wx);
+	wx_ptp_tx_hang(wx);
+
+	return 0;
+}
+
+/**
+ * wx_ptp_feature_enable
+ * @ptp: the ptp clock structure
+ * @rq: the requested feature to change
+ * @on: whether to enable or disable the feature
+ *
+ * enable (or disable) ancillary features of the phc subsystem.
+ */
+static int wx_ptp_feature_enable(struct ptp_clock_info *ptp,
+				 struct ptp_clock_request *rq, int on)
+{
+	struct wx *wx = container_of(ptp, struct wx, ptp_caps);
+
+	/**
+	 * When PPS is enabled, unmask the interrupt for the ClockOut
+	 * feature, so that the interrupt handler can send the PPS
+	 * event when the clock SDP triggers. Clear mask when PPS is
+	 * disabled
+	 */
+	if (rq->type != PTP_CLK_REQ_PPS || !wx->ptp_setup_sdp)
+		return -EOPNOTSUPP;
+
+	if (on)
+		set_bit(WX_FLAG_PTP_PPS_ENABLED, wx->flags);
+	else
+		clear_bit(WX_FLAG_PTP_PPS_ENABLED, wx->flags);
+
+	wx->ptp_setup_sdp(wx);
+
+	return 0;
+}
+
+/**
+ * wx_ptp_check_pps_event
+ * @wx: the private wx structure
+ *
+ * This function is called by the interrupt routine when checking for
+ * interrupts. It will check and handle a pps event.
+ */
+void wx_ptp_check_pps_event(struct wx *wx)
+{
+	struct cyclecounter *cc = &wx->hw_cc;
+	u32 tsauxc, rem, int_status;
+	u32 trgttiml0, trgttimh0;
+	u32 trgttiml1, trgttimh1;
+	unsigned long flags;
+	u64 ns = 0;
+
+	/* this check is necessary in case the interrupt was enabled via some
+	 * alternative means (ex. debug_fs). Better to check here than
+	 * everywhere that calls this function.
+	 */
+	if (!wx->ptp_clock)
+		return;
+
+	int_status = rd32ptp(wx, WX_TSC_1588_INT_ST);
+	if (int_status & WX_TSC_1588_INT_ST_TT1) {
+		/* disable the pin first */
+		wr32ptp(wx, WX_TSC_1588_AUX_CTL, 0);
+		WX_WRITE_FLUSH(wx);
+
+		tsauxc = WX_TSC_1588_AUX_CTL_PLSG | WX_TSC_1588_AUX_CTL_EN_TT0 |
+			 WX_TSC_1588_AUX_CTL_EN_TT1 | WX_TSC_1588_AUX_CTL_EN_TS0;
+
+		/* Read the current clock time, and save the cycle counter value */
+		spin_lock_irqsave(&wx->tmreg_lock, flags);
+		ns = timecounter_read(&wx->hw_tc);
+		wx->pps_edge_start = wx->hw_tc.cycle_last;
+		spin_unlock_irqrestore(&wx->tmreg_lock, flags);
+		wx->pps_edge_end = wx->pps_edge_start;
+
+		/* Figure out how far past the next second we are */
+		div_u64_rem(ns, WX_NS_PER_SEC, &rem);
+
+		/* Figure out how many nanoseconds to add to round the clock edge up
+		 * to the next full second
+		 */
+		rem = (WX_NS_PER_SEC - rem);
+
+		/* Adjust the clock edge to align with the next full second. */
+		wx->pps_edge_start += div_u64(((u64)rem << cc->shift), cc->mult);
+		trgttiml0 = (u32)wx->pps_edge_start;
+		trgttimh0 = (u32)(wx->pps_edge_start >> 32);
+
+		rem += WX_1588_PPS_WIDTH_EM * WX_NS_PER_MSEC;
+		wx->pps_edge_end += div_u64(((u64)rem << cc->shift), cc->mult);
+		trgttiml1 = (u32)wx->pps_edge_end;
+		trgttimh1 = (u32)(wx->pps_edge_end >> 32);
+
+		wr32ptp(wx, WX_TSC_1588_TRGT_L(0), trgttiml0);
+		wr32ptp(wx, WX_TSC_1588_TRGT_H(0), trgttimh0);
+		wr32ptp(wx, WX_TSC_1588_TRGT_L(1), trgttiml1);
+		wr32ptp(wx, WX_TSC_1588_TRGT_H(1), trgttimh1);
+		wr32ptp(wx, WX_TSC_1588_AUX_CTL, tsauxc);
+		WX_WRITE_FLUSH(wx);
+	}
+}
+EXPORT_SYMBOL(wx_ptp_check_pps_event);
+
 /**
  * wx_ptp_create_clock
  * @wx: the private board structure
@@ -573,6 +782,8 @@ void wx_ptp_reset(struct wx *wx)
 	timecounter_init(&wx->hw_tc, &wx->hw_cc,
 			 ktime_to_ns(ktime_get_real()));
 	spin_unlock_irqrestore(&wx->tmreg_lock, flags);
+
+	wx->last_overflow_check = jiffies;
 }
 EXPORT_SYMBOL(wx_ptp_reset);
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 31b11dba6bf5..1f9ddddea191 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1173,6 +1173,8 @@ struct wx {
 	u32 tx_hwtstamp_timeouts;
 	u32 tx_hwtstamp_skipped;
 	u32 rx_hwtstamp_cleared;
+	unsigned long last_overflow_check;
+	unsigned long last_rx_ptp_check;
 	unsigned long ptp_tx_start;
 	spinlock_t tmreg_lock; /* spinlock for ptp */
 	struct cyclecounter hw_cc;
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
index c7944e62838a..ea1d7e9a91f3 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
@@ -111,6 +111,7 @@ static void ngbe_mac_link_up(struct phylink_config *config,
 	wr32(wx, WX_MAC_WDG_TIMEOUT, reg);
 
 	wx->speed = speed;
+	wx->last_rx_ptp_check = jiffies;
 	if (test_bit(WX_STATE_PTP_RUNNING, wx->state))
 		wx_ptp_reset_cyclecounter(wx);
 }
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
index 60e5f3288ad8..7e17d727c2ba 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
@@ -222,6 +222,7 @@ static void txgbe_mac_link_up(struct phylink_config *config,
 	wr32(wx, WX_MAC_WDG_TIMEOUT, wdg);
 
 	wx->speed = speed;
+	wx->last_rx_ptp_check = jiffies;
 	if (test_bit(WX_STATE_PTP_RUNNING, wx->state))
 		wx_ptp_reset_cyclecounter(wx);
 }
-- 
2.27.0


