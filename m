Return-Path: <netdev+bounces-165876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2BAA339A0
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 09:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBF6E7A1A38
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 08:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1E320A5E2;
	Thu, 13 Feb 2025 08:06:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E3F20C025
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 08:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739433970; cv=none; b=V0Ld7S4KdaV9YMWp2MBi0qGd7xsQKJked+4N32I5MPFfr+YtD/dyKQRYfAbu6+IvZ5QDDW9FKZ8QGF+yTmek+7D8k/oDKLPEg8Ap4TbOQk0xG8SA/nqSCioESPvNLxQ8JPKwWFSfNua6vqtwV4AjIG8bu/k7XumtawfQYcgPziI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739433970; c=relaxed/simple;
	bh=Yv0t2G6+B3eXolbogzxPuhWDJzBhfzUwHuZxMDbJtw0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AkF2KpvcnFUxuU2utWqB9tmSY1ZqM4TOnTs7TM4HtzQe+quGqjHQUYLyJ4xMLbX6tFjFkm7pq17cuQzZZU+hULRTG+lhCD0TRqsebEWEN4qv+cklxGhyDL8Po9i6pP9wvlSUAtQYB/RAlZH5nsXDpyIaXRR8DGVyX799hLvlvZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtpsz2t1739433956tvzfeo0
X-QQ-Originating-IP: 6LjWjYoB8ZOFmHBFlC0FV2N1wqokxOtXwc+mg+lESPg=
Received: from wxdbg.localdomain.com ( [218.72.127.28])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 13 Feb 2025 16:05:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16209870527408324439
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
Subject: [PATCH net-next v7 3/4] net: wangxun: Add periodic checks for overflow and errors
Date: Thu, 13 Feb 2025 16:30:40 +0800
Message-Id: <20250213083041.78917-4-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20250213083041.78917-1-jiawenwu@trustnetic.com>
References: <20250213083041.78917-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: M5AoSkhGr8pkVXK8zVdWOjeiJ9RCQGIqiwh8pGQDp3L65l2m0xIZ2kxO
	7NIdjCI5WbaItQ7ND8yT2JbxCrt2U32kDspVcftUdYNVP2ZEL0V0gtqSYZknLJbK3TqfBUr
	vAvglZuNEE/uFNV8pehZKpDuXHwhL+YuDQvpmIfvfffTeuFcLpsh+FQVhwqEARj91RylAwz
	BgJgf7lLz73q9TAieF5Xl1Ox2dLRp65SyP8Pn1EWjoh3twG6t8I2vQXiFXYmiCB7Wx5GJWc
	SeosXTYTWyJ2TFeVGuMUC33lgB6YQF2g8eDvGNt7gPv3tCRHoQCsK8tY38FRepfCaU6iqch
	kGEOoF1Puj9LvFoRGmY77ScvocxMoXnleP7SylKbL5nT041RLZ7acFNBkqRpriPcCO8/1Eh
	Jaj0wUdOA1+sZpigGHvqGhyGy+ZOFvYrp7xCL0p2CmlXelK7J/BF9F7/Ry4m8a8/JTRllye
	FpPqWud5uKQWpTOxb5N6ib6kjuZMOHLVS6rdAh/caTTIIp4v+yozJ5SJKfQOT7tjj1iDMMW
	DrLRjfJs5CA8RNBlAaPBkE8xCHd70zRAyqrq2wM79vkvS1rL5QpRJPoDZYCqmvJoQym28ej
	t+6VxBq7sSEO0jnuROhzIFfV2n7RCL9hosWMEUQoO0fNf6QgsQw1qzhUPnEAi0dOLpxog7z
	GnZ4nPSLpRvw9JJ/HtsHVxuqRpRGM4hXMcXP4FiCMcc2C2Bvf+Qv06mWBK8keAlmF8d6tjZ
	JFvbtDBu64OF2mkahL9hWUv9A2k9z2kppCkfm19tLmLkcANigmuFSzoUB2nC2ZsMdXediGe
	xWnkRFFj04e5KoXA3kYC54p7orIw7gn05MSSxK+cVW3aIrvZ5Jp7XPkpF7Fg3AWAY5vh4Pu
	FzJFyhsXYonxTQ7VmXKgsd1Aibt6AZlZxkncmMvGORCBrbqTwB5UHz6dsxB+9ISWLHOJoca
	VO+MDuZRmr92xNxPwmeVD1UpAwZ6xzC1814IMCHNUST1UWgtRajxlqhMbHquUIViBxXaj6r
	Y+9PkSWg==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

Implement watchdog task to detect SYSTIME overflow and error cases of
Rx/Tx timestamp.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 drivers/net/ethernet/wangxun/libwx/wx_ptp.c   | 105 ++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |   2 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c |   1 +
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |   1 +
 4 files changed, 109 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
index b0251e41f4f6..528f008dec11 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
@@ -258,6 +258,102 @@ static int wx_ptp_tx_hwtstamp_work(struct wx *wx)
 	return -1;
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
+		wx_ptp_clear_tx_timestamp(wx);
+		wx->tx_hwtstamp_timeouts++;
+		dev_warn(&wx->pdev->dev, "clearing Tx timestamp hang\n");
+	}
+}
+
 static long wx_ptp_do_aux_work(struct ptp_clock_info *ptp)
 {
 	struct wx *wx = container_of(ptp, struct wx, ptp_caps);
@@ -265,6 +361,12 @@ static long wx_ptp_do_aux_work(struct ptp_clock_info *ptp)
 
 	ts_done = wx_ptp_tx_hwtstamp_work(wx);
 
+	wx_ptp_overflow_check(wx);
+	if (unlikely(test_bit(WX_FLAG_RX_HWTSTAMP_IN_REGISTER,
+			      wx->flags)))
+		wx_ptp_rx_hang(wx);
+	wx_ptp_tx_hang(wx);
+
 	return ts_done ? 1 : HZ;
 }
 
@@ -580,6 +682,9 @@ void wx_ptp_reset(struct wx *wx)
 	timecounter_init(&wx->hw_tc, &wx->hw_cc,
 			 ktime_to_ns(ktime_get_real()));
 	write_sequnlock_irqrestore(&wx->hw_tc_lock, flags);
+
+	wx->last_overflow_check = jiffies;
+	ptp_schedule_worker(wx->ptp_clock, HZ);
 }
 EXPORT_SYMBOL(wx_ptp_reset);
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index f83c54d4657c..0fabfa90d4e7 100644
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


