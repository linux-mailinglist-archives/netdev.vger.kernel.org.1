Return-Path: <netdev+bounces-167170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AD2A390A9
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 03:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1AE73B2DAE
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 02:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8672D148857;
	Tue, 18 Feb 2025 02:09:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1136482EB
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 02:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739844589; cv=none; b=sqErvYg/gLkaR9OeoYCbLKS4Gd/bGsAoHh5O7Er7UZ+U6fd6TDfiBwOTXSN47h2yU1N5oCTpQLUeumJtpIDLRbKAWxa6sDidMyICIABZvVLpHjBTNm6VtZ/kl3lmv5B+YNp4kjFo/l2f8EM7H1TKaRR6I834OVL5ufjEvPK0Hds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739844589; c=relaxed/simple;
	bh=8/7T84lpFwYJg3JJQZfnZa6swqZ+aMXk2kTJjIZ271Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oKH23yRV7zlMm6STYs69nRueB17uVL+yCLS6aaMZ97hSEoxW345rWHyhQ4fw5Ap+deDCVb3uBaeegtESM1vwYQNN4K5Z4eRWTPksVT4xdFSpv7089XRazOM1Txj91u4MtlSiAig6at93gyDN0M6er89dQQAD9rp8BkMTSCQZef0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtpsz5t1739844577ty0ejay
X-QQ-Originating-IP: ZogU6NONzzy5Ew8a5nZObBSB+GlvUA1326i0164g2Jg=
Received: from wxdbg.localdomain.com ( [36.24.205.26])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 18 Feb 2025 10:09:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2578718508898896570
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
Subject: [PATCH net-next v8 3/4] net: wangxun: Add periodic checks for overflow and errors
Date: Tue, 18 Feb 2025 10:34:31 +0800
Message-Id: <20250218023432.146536-4-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20250218023432.146536-1-jiawenwu@trustnetic.com>
References: <20250218023432.146536-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OCG/O0Z17aKrwlY5pJsdzvjo7v8osYK+dR051I9+Q1K140zVTg1t+R0o
	zgY4tiBUFSpmwxo7PFwjy0j9YY4lH3QxUV4Eg7XdeAunBjVhi4s8f+Ildhayl9+XumqyHP+
	SDb39U0EeJ6iJ+Y4hp8BdleYuyFzOzipD1pHFdzZ6k4mp6iJWuyc0Pc3ftyWtEnQhzIyCSv
	jVPrlDR36mc/SAztG1YLtnwkw3MPwKCtp7dcOAwl6Sfb5XwKTt51stpTp1SmoZ4+uQNcv/R
	ZX23ceh1n7/lfiBzKx6GGAG/bnLh4rZ4dHm+mumvRxMriRkfsrZjN7utuFD7+QecJQa6fVy
	1Gzt3xnma7aY5evMpXjF/1f92ct3gfPjoDoIsUZUcX4NK28XNCtGJ5Mm6/oh1/i3yPlSKWL
	R3sVBi+5ajCc12FJ5eYwP4ay5BRNx5YzjPgmey1iVODCFhHcT4XQ3Mv1K6jAAw6qaZGTT3d
	lVYROEq1Jvaxvcvvy9WWVdcrNLl2GrX3oAw6fUw/OWILpyLMwhPCqevzzqanIx3avWAuao8
	WLm03eCvi09bbt2Wosuxh7IgxKAEb7mtjKwtEbwQGGcpxmtu4DGC/ppWEgC6u9WLZ/l/tu9
	I1Mlz7vyl0+1G96NbygOf9q4aJGKClHplF7IMFEcI268KrCB7osnT9g44gedMY/h/8f0V2J
	nsijywcitpwCWDhhUzSsr0dAkMqSDVYPQGYXCIoy+Z/c0hoNK3RZlrU++fpSgo9D96gQy5d
	zWjCOX16uxLiFEV43Yq7yC8Q7do2Rcg+Xt8hjdx4gYeIZksZXvhoRhKVOk4bGeJOFNm9z1H
	KLKRzjpU830qhirKMsQkB6tD8du0nvlmUb7JUxYyEYYlEHBI57buq9wpm5YZcp9IyKfce73
	iYjz4fnidG4NEEowo3fOIkYnbvAe7zrmLERS9hyvLHZa6oJZ16Hl0/RgdPYyHrlHAWUUXeK
	u/a1Gs62vchzdwZ/EuOl3ONZ7Nsv8xGLsR81RBcGxbPOA7kEML8zZ/EDoy8SB/LjhW7pexa
	vRwq2TCCyJMQX8/Vdp
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
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
index e56288a18614..76986e41afe0 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
@@ -212,6 +212,102 @@ static int wx_ptp_tx_hwtstamp_work(struct wx *wx)
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
@@ -219,6 +315,12 @@ static long wx_ptp_do_aux_work(struct ptp_clock_info *ptp)
 
 	ts_done = wx_ptp_tx_hwtstamp_work(wx);
 
+	wx_ptp_overflow_check(wx);
+	if (unlikely(test_bit(WX_FLAG_RX_HWTSTAMP_IN_REGISTER,
+			      wx->flags)))
+		wx_ptp_rx_hang(wx);
+	wx_ptp_tx_hang(wx);
+
 	return ts_done ? 1 : HZ;
 }
 
@@ -475,6 +577,9 @@ void wx_ptp_reset(struct wx *wx)
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


