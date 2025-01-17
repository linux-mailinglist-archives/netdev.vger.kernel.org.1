Return-Path: <netdev+bounces-159166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C549A149A8
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 07:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E726A16AE41
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 06:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3535E1F76D6;
	Fri, 17 Jan 2025 06:21:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F941F7540
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 06:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737094884; cv=none; b=s2+HzDxeg6dSLFpzMeEhW9qGxWW3Wmu2KBXbuotF6TFTKOy6mey84F3/uNNNjv0/k1+JUXWs9Zg2tiF1BRROsyGnh4R9WppTZ1vYVsZh+9pDmpxErotN62GTqAlWVlFrZaZ7w4Hh1ECfwdqcRhNjd93pEiB4TZAA9FhkzQXGr1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737094884; c=relaxed/simple;
	bh=AzlYGc/DEAsD4C1HQAFUs7hHDPCnh2QEggAD5x7dEvo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DvaqQNsy0dAMvhLcTl//tqGxoxE6Nz617yZvJlFiFS9eWLnWFNKiU7Z5gg4/C0KDjrSQDMl6KQNGsoTn8xeHyD9chqMud+TPLTv92xG2MGVdCdgtuYXZXaASgbQAV10GylLHz2bvmJixdAZvc6m2kgQwox1rRDz+F3ma3HZVAho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtp89t1737094875t3bjnw6b
X-QQ-Originating-IP: 6DIsV7QqKsjv6AiGaVnbWhhhLahwJUOM6iKdTLB8Vcc=
Received: from wxdbg.localdomain.com ( [36.24.187.167])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 17 Jan 2025 14:21:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5966894241320681521
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
Subject: [PATCH net-next v5 3/4] net: wangxun: Implement do_aux_work of ptp_clock_info
Date: Fri, 17 Jan 2025 14:20:50 +0800
Message-Id: <20250117062051.2257073-4-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20250117062051.2257073-1-jiawenwu@trustnetic.com>
References: <20250117062051.2257073-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NOH1TaCqk/M+aM2hGYlQyu7Lx+tp+jf0Yf6f8B2mNSdjg/haHrH+HZg6
	DIp/LXaFa1Zqp8M4fwalIZbRYJjkivGKp2JEznzedatomlXFtS54FLYp7b/5Y1p3VISzS6I
	EYgfjUDD26NZd8YQ9P2pnLYnSPOkYgY/NZNM0n9icEySYAQ9BSTQhJ6qAqvGkZ3cVkGGV/F
	hRMWXFcCcrOdgZWx3vtSLqy9upRU4iYbpvglN6DNpFgIJyHzHsoKf6nBvfYYG5WQjw6NsIV
	3hN7Fq7c54bwUoy0efZ/XtJCa0sfw89yLa3MTG4Ac6Ay9Nljuu4wVbhoIyIQzkv2eqKcBJl
	6BUSdkp5dJRE2ngfQhOOFzrae7oFODQdTFphlD+MUzkhN+IAs6vd/nQ4jUvXJzf/1bjJZpK
	ifcqN3uHJDaez0OOaJ7tS5rOUtx+aYF4Jaw+F2Zo4cHhSF7bAHfdblwva64ywZ+d53Ny9Tq
	0R5MehjgN/slVi35RSOkT4jRgRJHSDdOG5sEqz2F8Ysgl4HomltbimB4p0gztKdUmwC2yt8
	575lCcKbAmf5/jc+OFI6TA1cbKi+kYE9seRisyeKU04TulbeeGoJi0/p6MbSgcvw+Jvz4dn
	ie9GWx47LJ0x20RuuXRlC/l6yQbTguqbzJ9C9EvUU73ZEV7eSd2bZHeTmQuQHwXXmQPTCR8
	i+fqnJK0R9FwlqTRbpocQBn3nZVQJIIOaXSK5iVkPb14FYY5gKT6hNKQEhQCmgmZP45cyrd
	cM94bXvYWTG5bZu/m/YPNQvA4+D8HerjRUmqHIk5KS4Llm502hZuaWT+mSjJ5nlG1ZSK0+L
	KnxkwijtXdT/d2XnPKqba28G2rqhzNftPtOg2DByy6plcQShSCV1QN/sasFHm9433PE7drl
	mqFz6ZvUrfMo73htquBEzUxhSh16s6epE7PZ0Pxow6K4aOAkKQODLWn6nTx9hoId84bDRjY
	ew92PuhX7yntUmnpTIgOF2NIja8KIzdVhJxbgCzrQl2O2p07jKyoisHXOjl+02h0Or7Yy8a
	xCeC0sZpFZFawj9XMVCb8DNABLQr8=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

Implement watchdog task to detect SYSTIME overflow and error cases of
Rx/Tx timestamp.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 drivers/net/ethernet/wangxun/libwx/wx_ptp.c   | 114 ++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |   2 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c |   1 +
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |   1 +
 4 files changed, 118 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
index e50209b12845..69b8989b7712 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
@@ -266,6 +266,116 @@ static void wx_ptp_tx_hwtstamp_work(struct work_struct *work)
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
@@ -298,6 +408,7 @@ static long wx_ptp_create_clock(struct wx *wx)
 	wx->ptp_caps.adjtime = wx_ptp_adjtime;
 	wx->ptp_caps.gettimex64 = wx_ptp_gettimex64;
 	wx->ptp_caps.settime64 = wx_ptp_settime64;
+	wx->ptp_caps.do_aux_work = wx_ptp_do_aux_work;
 	if (wx->mac.type == wx_mac_em)
 		wx->ptp_caps.max_adj = 500000000;
 	else
@@ -577,6 +688,9 @@ void wx_ptp_reset(struct wx *wx)
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


