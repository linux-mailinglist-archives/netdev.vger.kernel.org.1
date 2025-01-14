Return-Path: <netdev+bounces-158026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1488A101F5
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 09:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B4CC16A539
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 08:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7052284A6B;
	Tue, 14 Jan 2025 08:24:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F88284A48
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 08:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736843062; cv=none; b=E7oEI1MXfPOtjB5Vp+uAGeVH6AMsjv7GP2jCQ/eSqYVCmGRzWiwaD9vmSa6VKcACwn7CbUKFcSN2y14xtALLUTPhzafI00IxaYXp9sOsoEK9ftWdiJUdA58BQZksGDaN/oydXgdSf3bn3whF17I0tTKjYrOpM6EloC4MRvB3Mrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736843062; c=relaxed/simple;
	bh=jiZ+JXMucgnh2KhNQ8BRhQqi8RpEeoCCEKN1MaH6468=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EeAv1m7E86e++lTHN62FIQk685YM+GeZKe6J8U5fdw+sAEaWGhm4qlK2kw2xLJ95nedz13SMmRnCwAznH1s2bhYYMLV+Ex0i36aSEc+tTXJCz2r43N8nxekOhc9jupColt/hqHxkBaoBWFSFq3bMOrye4YxYUJiwsdDH4Yxv0K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtpsz9t1736843042tuxi73r
X-QQ-Originating-IP: T1+VJWjE2JnkjAidPJFipxZ9yrvS7gulFYIcg+Xt1e0=
Received: from wxdbg.localdomain.com ( [36.20.58.48])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 14 Jan 2025 16:24:01 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10760654707764697820
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
Subject: [PATCH net-next v4 3/4] net: wangxun: Implement do_aux_work of ptp_clock_info
Date: Tue, 14 Jan 2025 16:44:24 +0800
Message-Id: <20250114084425.2203428-4-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20250114084425.2203428-1-jiawenwu@trustnetic.com>
References: <20250114084425.2203428-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: M/ESU50hZOEXyX7sqdAqMkkDBqUrMGIFRgBbK+WfsWqL5NjkpxITdFGp
	xvth1QBgDgQFHihLsiLFPbDu9Hemr3gr4OpMvExga0ZwBq2fTJuj6KazMEJcpDSEFaGx+g1
	tlHK06WpWyjduLHWsQkLzZn6FuS63wqjKyNDVlPdldZ30aOn6BT+ybxIUlL7SaGPOyiX/Nw
	JJ3jZOxyTVnSQEaKQ6wK/RNzG3TuVo0G1TSrAZFUKpdmuutSc3UiIy3ImWcMJdvH1aJEPYK
	ZaWIRhTHikzyJHUQloJshacfH8nHV78pSgLN01URW8IMHo39RcPVXVjPdqxmJ7UHdRDQVdP
	3Q9OtfOHjAkNGy8NwM4/YZICXVxSHflI5WsEIFmbR+ZwkMwcDRLIRYU/YZTRaI9W7omZf7b
	uEis6iRd6nPwMHSBS4GhzoFud3ijW6jaN0AB07OviD8qLOpoYZWONMr0/9rhyha9yNH5sRi
	geKwqOoT/7a9FaJKu18d/i7cqtu30qJCIMXursJO37KHeujOYIyokSaWLibvEVmxBe6ocG4
	LMzjNBxW7UVDuOS75HrHJe+M86k8dfXsp7IVqTJRJAxz+BqJv3KEaQy6Ci6X4DBxZ6O2QFs
	8KsbW3gu9ZTh7KnFEUlEz8GxNSe4CEowDQDIOAhLFuJRWP2wjK6nAe+yqoqNlMaRnGpN3lI
	qfZs3+ry2gdEKO5uSEwTqtzYRRxz12PQFb0NR/3nrzUTeQnQP5M8UvATxOy/hij+FgeVkt4
	2ZwOztbKco87mVyuldLYoZeBpWSjw7zrYHg/a8Ffqb4DIMr5GcqAFj2H7oymC8BCuA7oWUm
	YaSv93DoJhJxxHOwgtQtWoyob5Ao0vDBsOV+bqk5Y/RD321Wke+JqB8bJq9zz5KXrK/4Gti
	izh+RcsNS0WJqJACFIOFfZGdsWvxa2KPwwaElhTtXjJGK6/8udjpPxfefAocf1LtAux3qOv
	ID0ZXwKgD2xXPrfmwsIaLn81CO2B1lgj15YVhJWUyEibko3YPLFitqjOAK5EUI2X7Eo2Z6+
	X808/I7pQkrEnzf89Z
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

Implement watchdog task to detect SYSTIME overflow and error cases of
Rx/Tx timestamp.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_ptp.c   | 114 ++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |   2 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c |   1 +
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |   1 +
 4 files changed, 118 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
index 97d39e8f02da..2e3d9cfc8aba 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
@@ -251,6 +251,116 @@ static void wx_ptp_tx_hwtstamp_work(struct work_struct *work)
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
+		write_seqlock_irqsave(&wx->hw_tc_lock, flags);
+		timecounter_read(&wx->hw_tc);
+		write_sequnlock_irqrestore(&wx->hw_tc_lock, flags);
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
+	return HZ;
+}
+
 /**
  * wx_ptp_create_clock
  * @wx: the private board structure
@@ -283,6 +393,7 @@ static long wx_ptp_create_clock(struct wx *wx)
 	wx->ptp_caps.adjtime = wx_ptp_adjtime;
 	wx->ptp_caps.gettimex64 = wx_ptp_gettimex64;
 	wx->ptp_caps.settime64 = wx_ptp_settime64;
+	wx->ptp_caps.do_aux_work = wx_ptp_do_aux_work;
 	if (wx->mac.type == wx_mac_em)
 		wx->ptp_caps.max_adj = 500000000;
 	else
@@ -566,6 +677,9 @@ void wx_ptp_reset(struct wx *wx)
 	timecounter_init(&wx->hw_tc, &wx->hw_cc,
 			 ktime_to_ns(ktime_get_real()));
 	write_sequnlock_irqrestore(&wx->hw_tc_lock, flags);
+
+	wx->last_overflow_check = jiffies;
+	ptp_schedule_worker(wx->ptp_clock, HZ);
 }
 EXPORT_SYMBOL(wx_ptp_reset);
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 9199317f7175..c2e58de3559a 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1175,6 +1175,8 @@ struct wx {
 	u32 tx_hwtstamp_skipped;
 	u32 tx_hwtstamp_errors;
 	u32 rx_hwtstamp_cleared;
+	unsigned long last_overflow_check;
+	unsigned long last_rx_ptp_check;
 	unsigned long ptp_tx_start;
 	seqlock_t hw_tc_lock; /* seqlock for ptp */
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


