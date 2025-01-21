Return-Path: <netdev+bounces-159920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 248E6A175F0
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 03:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 432703A1EC6
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 02:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD47152514;
	Tue, 21 Jan 2025 02:21:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC2C18E3F
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 02:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737426080; cv=none; b=Yh0JX4C385BR/iy31VDfjirBctE7quH+/OcUjmXzWppwjmiLSzLD+0pYNU5ZLy8uxN17l+MEODb1Ncaz7xJPj+1wuOcngjKAmCHYT5dJkmYHK8EnKTS00ZLCGHRjWsQEOZpPiOtAQqVhGmxk80pEcWrppo8IkAOFSB42+0w9Azk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737426080; c=relaxed/simple;
	bh=e7SJElewtCcspsT3VG5tud3ZGOqnSkMj3A7ShVHuRDI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N2dGl9/BMwERMGkZEukvEMUYV3OkxARL/Ix+amueeGa2/MR7MeUwKPQ6sRSdkizkcSM2f6UuoOgVliH2I3U2NgsG928JFgnOgWFWssxc76xCTmbq8KcT38R9aZ/kwta8BPWTplIeLy3E0p7m8S7dOyMaFAL6A5N3NDxaxDnFReY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtpsz7t1737426062tdvdjmy
X-QQ-Originating-IP: MHLWT4WIHvgfs3TUprwVrHmyeWkQJjBabBnUfNUJrgw=
Received: from wxdbg.localdomain.com ( [115.197.136.137])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 21 Jan 2025 10:21:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5276951506715011404
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
Subject: [PATCH net-next v6 1/4] net: wangxun: Add support for PTP clock
Date: Tue, 21 Jan 2025 10:20:31 +0800
Message-Id: <20250121022034.2321131-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20250121022034.2321131-1-jiawenwu@trustnetic.com>
References: <20250121022034.2321131-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MrPQPvu31i48sT4iu1S/93ChevPsviH+TSk49dFhuIuobhH53d9seCqi
	s5tAkEFu9f1QLbHfbYPuJTismSihxsbCQhoYxezl8xUk1jjz2D2uYuY59LfMOzyXJZTWwvy
	yL9Q9AT9DfAYKy8a8DMkNDoiyOjL1df14mBgrnXf2ZOeDf7zJ5UTsVK9unv2KZT0WrCbzgd
	1DMTeBYwbUxHEs9NeBUtLZb/xXPp1WGEVRbHmzZs+vny38z4rMK5YIEheyGG2d1T1Qva7if
	Y5S+wd2sy+dd4uO4oReHWggBN9A6aMN/r3vmI9UF8Z7OVQ2aTWs4+xiffDz05BRb2nR/789
	5mMpXlcINKjI9qk/a7NT96/BoE6M9ZUaAZKp+/PEeW27SwsWv2uRB7lr8qHaG170azgm7Pn
	FtvGrFUjkKzSgROPUEXd6MGVJ+cYZ6L43f4Lwj3x0n+4GMCQtdhWJ1o30Ouvw+INIos22Um
	mdYd7pBM3VuVrEikHaal3q4gqzVEoaal/J322VcJNQtFuImTcFHWoikXoj0stqk9Hl7g5sm
	uzYOq+qhOMrzIuBWgNOVsGd6Cy2UmvQLdOHmHSrV+FLea8pvN8ZeP+Q9uP9XIWHSKqv8w3r
	dkztsWY37WhY/Fib9tauuLxb0HA+wvM+QJ1NJQff/y4RgjjkIJBlscv4SVoilGX+rwzKLVq
	lFEy5BovSUfwTLAk/EWlev6NfNHHw744s3ttwxkGBClCs2OFwWwhl4ZHFBZWBNwAKA9niqm
	rBJxQtx+pexNNt7MQkEf36KU7nMJma3MP6zo2GP/n+R1OTN2Purj2St3outEWD+VreR+/lh
	eI82GYYrUcUZH3u/F2/PwJz7pMfx1jVAm5WYA91NXDMKWN4A2EN3SRReZDEeRERT+ctzWpN
	pVAgMNaIYuUuwzTeV/rFbRZGL164Ah/3AJ8CEuEWBSQkuiC/frKbRkMUbITu2JqrAvOwQF+
	SMdkQDrl0wQgkTRfaujxtIf1gdDDyy84bUGB7s+QbmrUPYg==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

Implement support for PTP clock on Wangxun NICs.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 drivers/net/ethernet/wangxun/Kconfig          |   1 +
 drivers/net/ethernet/wangxun/libwx/Makefile   |   2 +-
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   |   3 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  52 +-
 drivers/net/ethernet/wangxun/libwx/wx_ptp.c   | 717 ++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_ptp.h   |  19 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  69 ++
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |   8 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c |  10 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  11 +
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |   9 +
 11 files changed, 895 insertions(+), 6 deletions(-)
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_ptp.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_ptp.h

diff --git a/drivers/net/ethernet/wangxun/Kconfig b/drivers/net/ethernet/wangxun/Kconfig
index e46ccebcfd22..6b60173fe1f5 100644
--- a/drivers/net/ethernet/wangxun/Kconfig
+++ b/drivers/net/ethernet/wangxun/Kconfig
@@ -18,6 +18,7 @@ if NET_VENDOR_WANGXUN
 
 config LIBWX
 	tristate
+	depends on PTP_1588_CLOCK_OPTIONAL
 	select PAGE_POOL
 	help
 	Common library for Wangxun(R) Ethernet drivers.
diff --git a/drivers/net/ethernet/wangxun/libwx/Makefile b/drivers/net/ethernet/wangxun/libwx/Makefile
index 42ccd6e4052e..e9f0f1f2309b 100644
--- a/drivers/net/ethernet/wangxun/libwx/Makefile
+++ b/drivers/net/ethernet/wangxun/libwx/Makefile
@@ -4,4 +4,4 @@
 
 obj-$(CONFIG_LIBWX) += libwx.o
 
-libwx-objs := wx_hw.o wx_lib.o wx_ethtool.o
+libwx-objs := wx_hw.o wx_lib.o wx_ethtool.o wx_ptp.o
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index abe5921dde02..c4b3b00b0926 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -41,6 +41,9 @@ static const struct wx_stats wx_gstrings_stats[] = {
 	WX_STAT("rx_csum_offload_good_count", hw_csum_rx_good),
 	WX_STAT("rx_csum_offload_errors", hw_csum_rx_error),
 	WX_STAT("alloc_rx_buff_failed", alloc_rx_buff_failed),
+	WX_STAT("tx_hwtstamp_timeouts", tx_hwtstamp_timeouts),
+	WX_STAT("tx_hwtstamp_skipped", tx_hwtstamp_skipped),
+	WX_STAT("rx_hwtstamp_cleared", rx_hwtstamp_cleared),
 };
 
 static const struct wx_stats wx_gstrings_fdir_stats[] = {
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 2b3d6586f44a..62c837cd3fb7 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -13,6 +13,7 @@
 
 #include "wx_type.h"
 #include "wx_lib.h"
+#include "wx_ptp.h"
 #include "wx_hw.h"
 
 /* Lookup table mapping the HW PTYPE to the bit field for decoding */
@@ -597,8 +598,17 @@ static void wx_process_skb_fields(struct wx_ring *rx_ring,
 				  union wx_rx_desc *rx_desc,
 				  struct sk_buff *skb)
 {
+	struct wx *wx = netdev_priv(rx_ring->netdev);
+
 	wx_rx_hash(rx_ring, rx_desc, skb);
 	wx_rx_checksum(rx_ring, rx_desc, skb);
+
+	if (unlikely(test_bit(WX_FLAG_RX_HWTSTAMP_ENABLED, wx->flags)) &&
+	    unlikely(wx_test_staterr(rx_desc, WX_RXD_STAT_TS))) {
+		wx_ptp_rx_hwtstamp(rx_ring->q_vector->wx, skb);
+		rx_ring->last_rx_timestamp = jiffies;
+	}
+
 	wx_rx_vlan(rx_ring, rx_desc, skb);
 	skb_record_rx_queue(skb, rx_ring->queue_index);
 	skb->protocol = eth_type_trans(skb, rx_ring->netdev);
@@ -705,6 +715,7 @@ static bool wx_clean_tx_irq(struct wx_q_vector *q_vector,
 {
 	unsigned int budget = q_vector->wx->tx_work_limit;
 	unsigned int total_bytes = 0, total_packets = 0;
+	struct wx *wx = netdev_priv(tx_ring->netdev);
 	unsigned int i = tx_ring->next_to_clean;
 	struct wx_tx_buffer *tx_buffer;
 	union wx_tx_desc *tx_desc;
@@ -737,6 +748,11 @@ static bool wx_clean_tx_irq(struct wx_q_vector *q_vector,
 		total_bytes += tx_buffer->bytecount;
 		total_packets += tx_buffer->gso_segs;
 
+		/* schedule check for Tx timestamp */
+		if (unlikely(test_bit(WX_STATE_PTP_TX_IN_PROGRESS, wx->state)) &&
+		    skb_shinfo(tx_buffer->skb)->tx_flags & SKBTX_IN_PROGRESS)
+			schedule_work(&wx->ptp_tx_work);
+
 		/* free the skb */
 		napi_consume_skb(tx_buffer->skb, napi_budget);
 
@@ -932,9 +948,9 @@ static void wx_tx_olinfo_status(union wx_tx_desc *tx_desc,
 	tx_desc->read.olinfo_status = cpu_to_le32(olinfo_status);
 }
 
-static void wx_tx_map(struct wx_ring *tx_ring,
-		      struct wx_tx_buffer *first,
-		      const u8 hdr_len)
+static int wx_tx_map(struct wx_ring *tx_ring,
+		     struct wx_tx_buffer *first,
+		     const u8 hdr_len)
 {
 	struct sk_buff *skb = first->skb;
 	struct wx_tx_buffer *tx_buffer;
@@ -1013,6 +1029,8 @@ static void wx_tx_map(struct wx_ring *tx_ring,
 
 	netdev_tx_sent_queue(wx_txring_txq(tx_ring), first->bytecount);
 
+	/* set the timestamp */
+	first->time_stamp = jiffies;
 	skb_tx_timestamp(skb);
 
 	/* Force memory writes to complete before letting h/w know there
@@ -1038,7 +1056,7 @@ static void wx_tx_map(struct wx_ring *tx_ring,
 	if (netif_xmit_stopped(wx_txring_txq(tx_ring)) || !netdev_xmit_more())
 		writel(i, tx_ring->tail);
 
-	return;
+	return 0;
 dma_error:
 	dev_err(tx_ring->dev, "TX DMA map failed\n");
 
@@ -1062,6 +1080,8 @@ static void wx_tx_map(struct wx_ring *tx_ring,
 	first->skb = NULL;
 
 	tx_ring->next_to_use = i;
+
+	return -ENOMEM;
 }
 
 static void wx_tx_ctxtdesc(struct wx_ring *tx_ring, u32 vlan_macip_lens,
@@ -1486,6 +1506,20 @@ static netdev_tx_t wx_xmit_frame_ring(struct sk_buff *skb,
 		tx_flags |= WX_TX_FLAGS_HW_VLAN;
 	}
 
+	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) &&
+	    wx->ptp_clock) {
+		if (wx->tstamp_config.tx_type == HWTSTAMP_TX_ON &&
+		    !test_and_set_bit_lock(WX_STATE_PTP_TX_IN_PROGRESS,
+					   wx->state)) {
+			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
+			tx_flags |= WX_TX_FLAGS_TSTAMP;
+			wx->ptp_tx_skb = skb_get(skb);
+			wx->ptp_tx_start = jiffies;
+		} else {
+			wx->tx_hwtstamp_skipped++;
+		}
+	}
+
 	/* record initial flags and protocol */
 	first->tx_flags = tx_flags;
 	first->protocol = vlan_get_protocol(skb);
@@ -1501,12 +1535,20 @@ static netdev_tx_t wx_xmit_frame_ring(struct sk_buff *skb,
 	if (test_bit(WX_FLAG_FDIR_CAPABLE, wx->flags) && tx_ring->atr_sample_rate)
 		wx->atr(tx_ring, first, ptype);
 
-	wx_tx_map(tx_ring, first, hdr_len);
+	if (wx_tx_map(tx_ring, first, hdr_len))
+		goto cleanup_tx_tstamp;
 
 	return NETDEV_TX_OK;
 out_drop:
 	dev_kfree_skb_any(first->skb);
 	first->skb = NULL;
+cleanup_tx_tstamp:
+	if (unlikely(tx_flags & WX_TX_FLAGS_TSTAMP)) {
+		dev_kfree_skb_any(wx->ptp_tx_skb);
+		wx->ptp_tx_skb = NULL;
+		wx->tx_hwtstamp_errors++;
+		clear_bit_unlock(WX_STATE_PTP_TX_IN_PROGRESS, wx->state);
+	}
 
 	return NETDEV_TX_OK;
 }
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
new file mode 100644
index 000000000000..e50209b12845
--- /dev/null
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
@@ -0,0 +1,717 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2015 - 2025 Beijing WangXun Technology Co., Ltd. */
+
+#include <linux/ptp_classify.h>
+#include <linux/clocksource.h>
+#include <linux/pci.h>
+
+#include "wx_type.h"
+#include "wx_ptp.h"
+#include "wx_hw.h"
+
+#define WX_INCVAL_10GB        0xCCCCCC
+#define WX_INCVAL_1GB         0x800000
+#define WX_INCVAL_100         0xA00000
+#define WX_INCVAL_10          0xC7F380
+#define WX_INCVAL_EM          0x2000000
+
+#define WX_INCVAL_SHIFT_10GB  20
+#define WX_INCVAL_SHIFT_1GB   18
+#define WX_INCVAL_SHIFT_100   15
+#define WX_INCVAL_SHIFT_10    12
+#define WX_INCVAL_SHIFT_EM    22
+
+#define WX_OVERFLOW_PERIOD    (HZ * 30)
+#define WX_PTP_TX_TIMEOUT     (HZ)
+
+#define WX_1588_PPS_WIDTH_EM  120
+
+#define WX_NS_PER_SEC         1000000000ULL
+
+static u64 wx_ptp_timecounter_cyc2time(struct wx *wx, u64 timestamp)
+{
+	unsigned int seq;
+	u64 ns;
+
+	do {
+		seq = read_seqbegin(&wx->hw_tc_lock);
+		ns = timecounter_cyc2time(&wx->hw_tc, timestamp);
+	} while (read_seqretry(&wx->hw_tc_lock, seq));
+
+	return ns;
+}
+
+static u64 wx_ptp_readtime(struct wx *wx, struct ptp_system_timestamp *sts)
+{
+	u32 timeh1, timeh2, timel;
+
+	timeh1 = rd32ptp(wx, WX_TSC_1588_SYSTIMH);
+	ptp_read_system_prets(sts);
+	timel = rd32ptp(wx, WX_TSC_1588_SYSTIML);
+	ptp_read_system_postts(sts);
+	timeh2 = rd32ptp(wx, WX_TSC_1588_SYSTIMH);
+
+	if (timeh1 != timeh2) {
+		ptp_read_system_prets(sts);
+		timel = rd32ptp(wx, WX_TSC_1588_SYSTIML);
+		ptp_read_system_prets(sts);
+	}
+	return (u64)timel | (u64)timeh2 << 32;
+}
+
+/**
+ * wx_ptp_adjfine
+ * @ptp: the ptp clock structure
+ * @ppb: parts per billion adjustment from base
+ * Returns 0 on success
+ *
+ * Adjust the frequency of the ptp cycle counter by the
+ * indicated ppb from the base frequency.
+ */
+static int wx_ptp_adjfine(struct ptp_clock_info *ptp, long ppb)
+{
+	struct wx *wx = container_of(ptp, struct wx, ptp_caps);
+	u64 incval, mask;
+
+	smp_mb(); /* Force any pending update before accessing. */
+	incval = READ_ONCE(wx->base_incval);
+	incval = adjust_by_scaled_ppm(incval, ppb);
+
+	mask = (wx->mac.type == wx_mac_em) ? 0x7FFFFFF : 0xFFFFFF;
+	incval &= mask;
+	if (wx->mac.type != wx_mac_em)
+		incval |= 2 << 24;
+
+	wr32ptp(wx, WX_TSC_1588_INC, incval);
+
+	return 0;
+}
+
+/**
+ * wx_ptp_adjtime
+ * @ptp: the ptp clock structure
+ * @delta: offset to adjust the cycle counter by ns
+ * Returns 0 on success
+ *
+ * Adjust the timer by resetting the timecounter structure.
+ */
+static int wx_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
+{
+	struct wx *wx = container_of(ptp, struct wx, ptp_caps);
+	unsigned long flags;
+
+	write_seqlock_irqsave(&wx->hw_tc_lock, flags);
+	timecounter_adjtime(&wx->hw_tc, delta);
+	write_sequnlock_irqrestore(&wx->hw_tc_lock, flags);
+
+	return 0;
+}
+
+/**
+ * wx_ptp_gettimex64
+ * @ptp: the ptp clock structure
+ * @ts: timespec structure to hold the current time value
+ * @sts: structure to hold the system time before and after reading the PHC
+ * Returns 0 on success
+ *
+ * Read the timecounter and return the correct value on ns,
+ * after converting it into a struct timespec64.
+ */
+static int wx_ptp_gettimex64(struct ptp_clock_info *ptp,
+			     struct timespec64 *ts,
+			     struct ptp_system_timestamp *sts)
+{
+	struct wx *wx = container_of(ptp, struct wx, ptp_caps);
+	u64 ns, stamp;
+
+	stamp = wx_ptp_readtime(wx, sts);
+	ns = wx_ptp_timecounter_cyc2time(wx, stamp);
+	*ts = ns_to_timespec64(ns);
+
+	return 0;
+}
+
+/**
+ * wx_ptp_settime64
+ * @ptp: the ptp clock structure
+ * @ts: the timespec64 containing the new time for the cycle counter
+ * Returns 0 on success
+ *
+ * Reset the timecounter to use a new base value instead of the kernel
+ * wall timer value.
+ */
+static int wx_ptp_settime64(struct ptp_clock_info *ptp,
+			    const struct timespec64 *ts)
+{
+	struct wx *wx = container_of(ptp, struct wx, ptp_caps);
+	unsigned long flags;
+	u64 ns;
+
+	ns = timespec64_to_ns(ts);
+	/* reset the timecounter */
+	write_seqlock_irqsave(&wx->hw_tc_lock, flags);
+	timecounter_init(&wx->hw_tc, &wx->hw_cc, ns);
+	write_sequnlock_irqrestore(&wx->hw_tc_lock, flags);
+
+	return 0;
+}
+
+/**
+ * wx_ptp_clear_tx_timestamp - utility function to clear Tx timestamp state
+ * @wx: the private board structure
+ *
+ * This function should be called whenever the state related to a Tx timestamp
+ * needs to be cleared. This helps ensure that all related bits are reset for
+ * the next Tx timestamp event.
+ */
+static void wx_ptp_clear_tx_timestamp(struct wx *wx)
+{
+	rd32ptp(wx, WX_TSC_1588_STMPH);
+	if (wx->ptp_tx_skb) {
+		dev_kfree_skb_any(wx->ptp_tx_skb);
+		wx->ptp_tx_skb = NULL;
+	}
+	clear_bit_unlock(WX_STATE_PTP_TX_IN_PROGRESS, wx->state);
+}
+
+/**
+ * wx_ptp_convert_to_hwtstamp - convert register value to hw timestamp
+ * @wx: private board structure
+ * @hwtstamp: stack timestamp structure
+ * @timestamp: unsigned 64bit system time value
+ *
+ * We need to convert the adapter's RX/TXSTMP registers into a hwtstamp value
+ * which can be used by the stack's ptp functions.
+ *
+ * The lock is used to protect consistency of the cyclecounter and the SYSTIME
+ * registers. However, it does not need to protect against the Rx or Tx
+ * timestamp registers, as there can't be a new timestamp until the old one is
+ * unlatched by reading.
+ *
+ * In addition to the timestamp in hardware, some controllers need a software
+ * overflow cyclecounter, and this function takes this into account as well.
+ **/
+static void wx_ptp_convert_to_hwtstamp(struct wx *wx,
+				       struct skb_shared_hwtstamps *hwtstamp,
+				       u64 timestamp)
+{
+	u64 ns;
+
+	ns = wx_ptp_timecounter_cyc2time(wx, timestamp);
+	hwtstamp->hwtstamp = ns_to_ktime(ns);
+}
+
+/**
+ * wx_ptp_tx_hwtstamp - utility function which checks for TX time stamp
+ * @wx: the private board struct
+ *
+ * if the timestamp is valid, we convert it into the timecounter ns
+ * value, then store that result into the shhwtstamps structure which
+ * is passed up the network stack
+ */
+static void wx_ptp_tx_hwtstamp(struct wx *wx)
+{
+	struct skb_shared_hwtstamps shhwtstamps;
+	struct sk_buff *skb = wx->ptp_tx_skb;
+	u64 regval = 0;
+
+	regval |= (u64)rd32ptp(wx, WX_TSC_1588_STMPL);
+	regval |= (u64)rd32ptp(wx, WX_TSC_1588_STMPH) << 32;
+
+	wx_ptp_convert_to_hwtstamp(wx, &shhwtstamps, regval);
+
+	wx->ptp_tx_skb = NULL;
+	clear_bit_unlock(WX_STATE_PTP_TX_IN_PROGRESS, wx->state);
+	skb_tstamp_tx(skb, &shhwtstamps);
+	dev_kfree_skb_any(skb);
+	wx->tx_hwtstamp_pkts++;
+}
+
+/**
+ * wx_ptp_tx_hwtstamp_work
+ * @work: pointer to the work struct
+ *
+ * This work item polls TSC_1588_CTL valid bit to determine when a Tx hardware
+ * timestamp has been taken for the current skb. It is necessary, because the
+ * descriptor's "done" bit does not correlate with the timestamp event.
+ */
+static void wx_ptp_tx_hwtstamp_work(struct work_struct *work)
+{
+	struct wx *wx = container_of(work, struct wx, ptp_tx_work);
+	u32 tsynctxctl;
+	bool timeout;
+
+	/* we have to have a valid skb to poll for a timestamp */
+	if (!wx->ptp_tx_skb) {
+		wx_ptp_clear_tx_timestamp(wx);
+		return;
+	}
+
+	/* stop polling once we have a valid timestamp */
+	tsynctxctl = rd32ptp(wx, WX_TSC_1588_CTL);
+	if (tsynctxctl & WX_TSC_1588_CTL_VALID) {
+		wx_ptp_tx_hwtstamp(wx);
+		return;
+	}
+
+	timeout = time_is_before_jiffies(wx->ptp_tx_start + WX_PTP_TX_TIMEOUT);
+	/* check timeout last in case timestamp event just occurred */
+	if (timeout) {
+		wx_ptp_clear_tx_timestamp(wx);
+		wx->tx_hwtstamp_timeouts++;
+		dev_warn(&wx->pdev->dev, "clearing Tx Timestamp hang\n");
+	} else {
+		/* reschedule to keep checking until we timeout */
+		schedule_work(&wx->ptp_tx_work);
+	}
+}
+
+/**
+ * wx_ptp_create_clock
+ * @wx: the private board structure
+ *
+ * Returns 0 on success, negative value on failure
+ *
+ * This function performs setup of the user entry point function table and
+ * initalizes the PTP clock device used by userspace to access the clock-like
+ * features of the PTP core. It will be called by wx_ptp_init, and may
+ * re-use a previously initialized clock (such as during a suspend/resume
+ * cycle).
+ */
+static long wx_ptp_create_clock(struct wx *wx)
+{
+	struct net_device *netdev = wx->netdev;
+	long err;
+
+	/* do nothing if we already have a clock device */
+	if (!IS_ERR_OR_NULL(wx->ptp_clock))
+		return 0;
+
+	snprintf(wx->ptp_caps.name, sizeof(wx->ptp_caps.name),
+		 "%s", netdev->name);
+	wx->ptp_caps.owner = THIS_MODULE;
+	wx->ptp_caps.n_alarm = 0;
+	wx->ptp_caps.n_ext_ts = 0;
+	wx->ptp_caps.n_per_out = 0;
+	wx->ptp_caps.pps = 0;
+	wx->ptp_caps.adjfine = wx_ptp_adjfine;
+	wx->ptp_caps.adjtime = wx_ptp_adjtime;
+	wx->ptp_caps.gettimex64 = wx_ptp_gettimex64;
+	wx->ptp_caps.settime64 = wx_ptp_settime64;
+	if (wx->mac.type == wx_mac_em)
+		wx->ptp_caps.max_adj = 500000000;
+	else
+		wx->ptp_caps.max_adj = 250000000;
+
+	wx->ptp_clock = ptp_clock_register(&wx->ptp_caps, &wx->pdev->dev);
+	if (IS_ERR(wx->ptp_clock)) {
+		err = PTR_ERR(wx->ptp_clock);
+		wx->ptp_clock = NULL;
+		wx_err(wx, "ptp clock register failed\n");
+		return err;
+	} else if (wx->ptp_clock) {
+		dev_info(&wx->pdev->dev, "registered PHC device on %s\n",
+			 netdev->name);
+	}
+
+	/* Set the default timestamp mode to disabled here. We do this in
+	 * create_clock instead of initialization, because we don't want to
+	 * override the previous settings during a suspend/resume cycle.
+	 */
+	wx->tstamp_config.rx_filter = HWTSTAMP_FILTER_NONE;
+	wx->tstamp_config.tx_type = HWTSTAMP_TX_OFF;
+
+	return 0;
+}
+
+/**
+ * wx_ptp_set_timestamp_mode - setup the hardware for the requested mode
+ * @wx: the private board structure
+ * @config: the hwtstamp configuration requested
+ *
+ * Returns 0 on success, negative on failure
+ *
+ * Outgoing time stamping can be enabled and disabled. Play nice and
+ * disable it when requested, although it shouldn't cause any overhead
+ * when no packet needs it. At most one packet in the queue may be
+ * marked for time stamping, otherwise it would be impossible to tell
+ * for sure to which packet the hardware time stamp belongs.
+ *
+ * Incoming time stamping has to be configured via the hardware
+ * filters. Not all combinations are supported, in particular event
+ * type has to be specified. Matching the kind of event packet is
+ * not supported, with the exception of "all V2 events regardless of
+ * level 2 or 4".
+ *
+ * Since hardware always timestamps Path delay packets when timestamping V2
+ * packets, regardless of the type specified in the register, only use V2
+ * Event mode. This more accurately tells the user what the hardware is going
+ * to do anyways.
+ *
+ * Note: this may modify the hwtstamp configuration towards a more general
+ * mode, if required to support the specifically requested mode.
+ */
+static int wx_ptp_set_timestamp_mode(struct wx *wx,
+				     struct kernel_hwtstamp_config *config)
+{
+	u32 tsync_tx_ctl = WX_TSC_1588_CTL_ENABLED;
+	u32 tsync_rx_ctl = WX_PSR_1588_CTL_ENABLED;
+	DECLARE_BITMAP(flags, WX_PF_FLAGS_NBITS);
+	u32 tsync_rx_mtrl = PTP_EV_PORT << 16;
+	bool is_l2 = false;
+	u32 regval;
+
+	memcpy(flags, wx->flags, sizeof(wx->flags));
+
+	switch (config->tx_type) {
+	case HWTSTAMP_TX_OFF:
+		tsync_tx_ctl = 0;
+		break;
+	case HWTSTAMP_TX_ON:
+		break;
+	default:
+		return -ERANGE;
+	}
+
+	switch (config->rx_filter) {
+	case HWTSTAMP_FILTER_NONE:
+		tsync_rx_ctl = 0;
+		tsync_rx_mtrl = 0;
+		clear_bit(WX_FLAG_RX_HWTSTAMP_ENABLED, flags);
+		clear_bit(WX_FLAG_RX_HWTSTAMP_IN_REGISTER, flags);
+		break;
+	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
+		tsync_rx_ctl |= WX_PSR_1588_CTL_TYPE_L4_V1;
+		tsync_rx_mtrl |= WX_PSR_1588_MSG_V1_SYNC;
+		set_bit(WX_FLAG_RX_HWTSTAMP_ENABLED, flags);
+		set_bit(WX_FLAG_RX_HWTSTAMP_IN_REGISTER, flags);
+		break;
+	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
+		tsync_rx_ctl |= WX_PSR_1588_CTL_TYPE_L4_V1;
+		tsync_rx_mtrl |= WX_PSR_1588_MSG_V1_DELAY_REQ;
+		set_bit(WX_FLAG_RX_HWTSTAMP_ENABLED, flags);
+		set_bit(WX_FLAG_RX_HWTSTAMP_IN_REGISTER, flags);
+		break;
+	case HWTSTAMP_FILTER_PTP_V2_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
+	case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
+	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
+		tsync_rx_ctl |= WX_PSR_1588_CTL_TYPE_EVENT_V2;
+		is_l2 = true;
+		config->rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
+		set_bit(WX_FLAG_RX_HWTSTAMP_ENABLED, flags);
+		set_bit(WX_FLAG_RX_HWTSTAMP_IN_REGISTER, flags);
+		break;
+	default:
+		/* register PSR_1588_MSG must be set in order to do V1 packets,
+		 * therefore it is not possible to time stamp both V1 Sync and
+		 * Delay_Req messages unless hardware supports timestamping all
+		 * packets => return error
+		 */
+		config->rx_filter = HWTSTAMP_FILTER_NONE;
+		return -ERANGE;
+	}
+
+	/* define ethertype filter for timestamping L2 packets */
+	if (is_l2)
+		wr32(wx, WX_PSR_ETYPE_SWC(WX_PSR_ETYPE_SWC_FILTER_1588),
+		     (WX_PSR_ETYPE_SWC_FILTER_EN | /* enable filter */
+		      WX_PSR_ETYPE_SWC_1588 | /* enable timestamping */
+		      ETH_P_1588)); /* 1588 eth protocol type */
+	else
+		wr32(wx, WX_PSR_ETYPE_SWC(WX_PSR_ETYPE_SWC_FILTER_1588), 0);
+
+	/* enable/disable TX */
+	regval = rd32ptp(wx, WX_TSC_1588_CTL);
+	regval &= ~WX_TSC_1588_CTL_ENABLED;
+	regval |= tsync_tx_ctl;
+	wr32ptp(wx, WX_TSC_1588_CTL, regval);
+
+	/* enable/disable RX */
+	regval = rd32(wx, WX_PSR_1588_CTL);
+	regval &= ~(WX_PSR_1588_CTL_ENABLED | WX_PSR_1588_CTL_TYPE_MASK);
+	regval |= tsync_rx_ctl;
+	wr32(wx, WX_PSR_1588_CTL, regval);
+
+	/* define which PTP packets are time stamped */
+	wr32(wx, WX_PSR_1588_MSG, tsync_rx_mtrl);
+
+	WX_WRITE_FLUSH(wx);
+
+	/* configure adapter flags only when HW is actually configured */
+	memcpy(wx->flags, flags, sizeof(wx->flags));
+
+	/* clear TX/RX timestamp state, just to be sure */
+	wx_ptp_clear_tx_timestamp(wx);
+	rd32(wx, WX_PSR_1588_STMPH);
+
+	return 0;
+}
+
+/**
+ * wx_ptp_read - read raw cycle counter (to be used by time counter)
+ * @hw_cc: the cyclecounter structure
+ *
+ * this function reads the cyclecounter registers and is called by the
+ * cyclecounter structure used to construct a ns counter from the
+ * arbitrary fixed point registers
+ */
+static u64 wx_ptp_read(const struct cyclecounter *hw_cc)
+{
+	struct wx *wx = container_of(hw_cc, struct wx, hw_cc);
+
+	return wx_ptp_readtime(wx, NULL);
+}
+
+static void wx_ptp_link_speed_adjust(struct wx *wx, u32 *shift, u32 *incval)
+{
+	if (wx->mac.type == wx_mac_em) {
+		*shift = WX_INCVAL_SHIFT_EM;
+		*incval = WX_INCVAL_EM;
+		return;
+	}
+
+	switch (wx->speed) {
+	case SPEED_10:
+		*shift = WX_INCVAL_SHIFT_10;
+		*incval = WX_INCVAL_10;
+		break;
+	case SPEED_100:
+		*shift = WX_INCVAL_SHIFT_100;
+		*incval = WX_INCVAL_100;
+		break;
+	case SPEED_1000:
+		*shift = WX_INCVAL_SHIFT_1GB;
+		*incval = WX_INCVAL_1GB;
+		break;
+	case SPEED_10000:
+	default:
+		*shift = WX_INCVAL_SHIFT_10GB;
+		*incval = WX_INCVAL_10GB;
+		break;
+	}
+}
+
+/**
+ * wx_ptp_reset_cyclecounter - create the cycle counter from hw
+ * @wx: pointer to the wx structure
+ *
+ * This function should be called to set the proper values for the TSC_1588_INC
+ * register and tell the cyclecounter structure what the tick rate of SYSTIME
+ * is. It does not directly modify SYSTIME registers or the timecounter
+ * structure. It should be called whenever a new TSC_1588_INC value is
+ * necessary, such as during initialization or when the link speed changes.
+ */
+void wx_ptp_reset_cyclecounter(struct wx *wx)
+{
+	u32 incval = 0, mask = 0;
+	struct cyclecounter cc;
+	unsigned long flags;
+
+	/* For some of the boards below this mask is technically incorrect.
+	 * The timestamp mask overflows at approximately 61bits. However the
+	 * particular hardware does not overflow on an even bitmask value.
+	 * Instead, it overflows due to conversion of upper 32bits billions of
+	 * cycles. Timecounters are not really intended for this purpose so
+	 * they do not properly function if the overflow point isn't 2^N-1.
+	 * However, the actual SYSTIME values in question take ~138 years to
+	 * overflow. In practice this means they won't actually overflow. A
+	 * proper fix to this problem would require modification of the
+	 * timecounter delta calculations.
+	 */
+	cc.mask = CLOCKSOURCE_MASK(64);
+	cc.mult = 1;
+	cc.shift = 0;
+
+	cc.read = wx_ptp_read;
+	wx_ptp_link_speed_adjust(wx, &cc.shift, &incval);
+
+	/* update the base incval used to calculate frequency adjustment */
+	WRITE_ONCE(wx->base_incval, incval);
+
+	mask = (wx->mac.type == wx_mac_em) ? 0x7FFFFFF : 0xFFFFFF;
+	incval &= mask;
+	if (wx->mac.type != wx_mac_em)
+		incval |= 2 << 24;
+	wr32ptp(wx, WX_TSC_1588_INC, incval);
+
+	smp_mb(); /* Force the above update. */
+
+	/* need lock to prevent incorrect read while modifying cyclecounter */
+	write_seqlock_irqsave(&wx->hw_tc_lock, flags);
+	memcpy(&wx->hw_cc, &cc, sizeof(wx->hw_cc));
+	write_sequnlock_irqrestore(&wx->hw_tc_lock, flags);
+}
+EXPORT_SYMBOL(wx_ptp_reset_cyclecounter);
+
+/**
+ * wx_ptp_reset
+ * @wx: the private board structure
+ *
+ * When the MAC resets, all of the hardware configuration for timesync is
+ * reset. This function should be called to re-enable the device for PTP,
+ * using the last known settings. However, we do lose the current clock time,
+ * so we fallback to resetting it based on the kernel's realtime clock.
+ *
+ * This function will maintain the hwtstamp_config settings, and it retriggers
+ * the SDP output if it's enabled.
+ */
+void wx_ptp_reset(struct wx *wx)
+{
+	unsigned long flags;
+
+	/* reset the hardware timestamping mode */
+	wx_ptp_set_timestamp_mode(wx, &wx->tstamp_config);
+	wx_ptp_reset_cyclecounter(wx);
+
+	wr32ptp(wx, WX_TSC_1588_SYSTIML, 0);
+	wr32ptp(wx, WX_TSC_1588_SYSTIMH, 0);
+	WX_WRITE_FLUSH(wx);
+
+	write_seqlock_irqsave(&wx->hw_tc_lock, flags);
+	timecounter_init(&wx->hw_tc, &wx->hw_cc,
+			 ktime_to_ns(ktime_get_real()));
+	write_sequnlock_irqrestore(&wx->hw_tc_lock, flags);
+}
+EXPORT_SYMBOL(wx_ptp_reset);
+
+/**
+ * wx_ptp_init
+ * @wx: the private board structure
+ *
+ * This function performs the required steps for enabling ptp
+ * support. If ptp support has already been loaded it simply calls the
+ * cyclecounter init routine and exits.
+ */
+void wx_ptp_init(struct wx *wx)
+{
+	/* Initialize the seqlock_t first, since the user might call the clock
+	 * functions any time after we've initialized the ptp clock device.
+	 */
+	seqlock_init(&wx->hw_tc_lock);
+
+	/* obtain a ptp clock device, or re-use an existing device */
+	if (wx_ptp_create_clock(wx))
+		return;
+
+	/* we have a clock, so we can initialize work for timestamps now */
+	INIT_WORK(&wx->ptp_tx_work, wx_ptp_tx_hwtstamp_work);
+
+	wx->tx_hwtstamp_pkts = 0;
+	wx->tx_hwtstamp_timeouts = 0;
+	wx->tx_hwtstamp_skipped = 0;
+	wx->tx_hwtstamp_errors = 0;
+	wx->rx_hwtstamp_cleared = 0;
+	/* reset the ptp related hardware bits */
+	wx_ptp_reset(wx);
+
+	/* enter the WX_STATE_PTP_RUNNING state */
+	set_bit(WX_STATE_PTP_RUNNING, wx->state);
+}
+EXPORT_SYMBOL(wx_ptp_init);
+
+/**
+ * wx_ptp_suspend - stop ptp work items
+ * @wx: pointer to wx struct
+ *
+ * This function suspends ptp activity, and prevents more work from being
+ * generated, but does not destroy the clock device.
+ */
+void wx_ptp_suspend(struct wx *wx)
+{
+	/* leave the WX_STATE_PTP_RUNNING STATE */
+	if (!test_and_clear_bit(WX_STATE_PTP_RUNNING, wx->state))
+		return;
+
+	cancel_work_sync(&wx->ptp_tx_work);
+	wx_ptp_clear_tx_timestamp(wx);
+}
+EXPORT_SYMBOL(wx_ptp_suspend);
+
+/**
+ * wx_ptp_stop - destroy the ptp_clock device
+ * @wx: pointer to wx struct
+ *
+ * Completely destroy the ptp_clock device, and disable all PTP related
+ * features. Intended to be run when the device is being closed.
+ */
+void wx_ptp_stop(struct wx *wx)
+{
+	/* first, suspend ptp activity */
+	wx_ptp_suspend(wx);
+
+	/* now destroy the ptp clock device */
+	if (wx->ptp_clock) {
+		ptp_clock_unregister(wx->ptp_clock);
+		wx->ptp_clock = NULL;
+		dev_info(&wx->pdev->dev, "removed PHC on %s\n", wx->netdev->name);
+	}
+}
+EXPORT_SYMBOL(wx_ptp_stop);
+
+/**
+ * wx_ptp_rx_hwtstamp - utility function which checks for RX time stamp
+ * @wx: pointer to wx struct
+ * @skb: particular skb to send timestamp with
+ *
+ * if the timestamp is valid, we convert it into the timecounter ns
+ * value, then store that result into the shhwtstamps structure which
+ * is passed up the network stack
+ */
+void wx_ptp_rx_hwtstamp(struct wx *wx, struct sk_buff *skb)
+{
+	u64 regval = 0;
+	u32 tsyncrxctl;
+
+	/* Read the tsyncrxctl register afterwards in order to prevent taking an
+	 * I/O hit on every packet.
+	 */
+	tsyncrxctl = rd32(wx, WX_PSR_1588_CTL);
+	if (!(tsyncrxctl & WX_PSR_1588_CTL_VALID))
+		return;
+
+	regval |= (u64)rd32(wx, WX_PSR_1588_STMPL);
+	regval |= (u64)rd32(wx, WX_PSR_1588_STMPH) << 32;
+
+	wx_ptp_convert_to_hwtstamp(wx, skb_hwtstamps(skb), regval);
+}
+
+int wx_hwtstamp_get(struct net_device *dev,
+		    struct kernel_hwtstamp_config *cfg)
+{
+	struct wx *wx = netdev_priv(dev);
+
+	if (!netif_running(dev))
+		return -EINVAL;
+
+	*cfg = wx->tstamp_config;
+
+	return 0;
+}
+EXPORT_SYMBOL(wx_hwtstamp_get);
+
+int wx_hwtstamp_set(struct net_device *dev,
+		    struct kernel_hwtstamp_config *cfg,
+		    struct netlink_ext_ack *extack)
+{
+	struct wx *wx = netdev_priv(dev);
+	int err;
+
+	if (!netif_running(dev))
+		return -EINVAL;
+
+	err = wx_ptp_set_timestamp_mode(wx, cfg);
+	if (err)
+		return err;
+
+	/* save these settings for future reference */
+	memcpy(&wx->tstamp_config, cfg, sizeof(wx->tstamp_config));
+
+	return 0;
+}
+EXPORT_SYMBOL(wx_hwtstamp_set);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ptp.h b/drivers/net/ethernet/wangxun/libwx/wx_ptp.h
new file mode 100644
index 000000000000..8742d2797363
--- /dev/null
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ptp.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2019 - 2025 Beijing WangXun Technology Co., Ltd. */
+
+#ifndef _WX_PTP_H_
+#define _WX_PTP_H_
+
+void wx_ptp_reset_cyclecounter(struct wx *wx);
+void wx_ptp_reset(struct wx *wx);
+void wx_ptp_init(struct wx *wx);
+void wx_ptp_suspend(struct wx *wx);
+void wx_ptp_stop(struct wx *wx);
+void wx_ptp_rx_hwtstamp(struct wx *wx, struct sk_buff *skb);
+int wx_hwtstamp_get(struct net_device *dev,
+		    struct kernel_hwtstamp_config *cfg);
+int wx_hwtstamp_set(struct net_device *dev,
+		    struct kernel_hwtstamp_config *cfg,
+		    struct netlink_ext_ack *extack);
+
+#endif /* _WX_PTP_H_ */
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index b54bffda027b..9199317f7175 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -4,6 +4,8 @@
 #ifndef _WX_TYPE_H_
 #define _WX_TYPE_H_
 
+#include <linux/ptp_clock_kernel.h>
+#include <linux/timecounter.h>
 #include <linux/bitfield.h>
 #include <linux/netdevice.h>
 #include <linux/if_vlan.h>
@@ -180,6 +182,23 @@
 #define WX_PSR_VLAN_CTL              0x15088
 #define WX_PSR_VLAN_CTL_CFIEN        BIT(29)  /* bit 29 */
 #define WX_PSR_VLAN_CTL_VFE          BIT(30)  /* bit 30 */
+/* EType Queue Filter */
+#define WX_PSR_ETYPE_SWC(_i)         (0x15128 + ((_i) * 4))
+#define WX_PSR_ETYPE_SWC_FILTER_1588 3
+#define WX_PSR_ETYPE_SWC_FILTER_EN   BIT(31)
+#define WX_PSR_ETYPE_SWC_1588        BIT(30)
+/* 1588 */
+#define WX_PSR_1588_MSG                 0x15120
+#define WX_PSR_1588_MSG_V1_SYNC         FIELD_PREP(GENMASK(7, 0), 0)
+#define WX_PSR_1588_MSG_V1_DELAY_REQ    FIELD_PREP(GENMASK(7, 0), 1)
+#define WX_PSR_1588_STMPL               0x151E8
+#define WX_PSR_1588_STMPH               0x151A4
+#define WX_PSR_1588_CTL                 0x15188
+#define WX_PSR_1588_CTL_ENABLED         BIT(4)
+#define WX_PSR_1588_CTL_TYPE_MASK       GENMASK(3, 1)
+#define WX_PSR_1588_CTL_TYPE_L4_V1      FIELD_PREP(GENMASK(3, 1), 1)
+#define WX_PSR_1588_CTL_TYPE_EVENT_V2   FIELD_PREP(GENMASK(3, 1), 5)
+#define WX_PSR_1588_CTL_VALID           BIT(0)
 /* mcasst/ucast overflow tbl */
 #define WX_PSR_MC_TBL(_i)            (0x15200  + ((_i) * 4))
 #define WX_PSR_UC_TBL(_i)            (0x15400 + ((_i) * 4))
@@ -253,6 +272,15 @@
 #define WX_TSC_ST_SECTX_RDY          BIT(0)
 #define WX_TSC_BUF_AE                0x1D00C
 #define WX_TSC_BUF_AE_THR            GENMASK(9, 0)
+/* 1588 */
+#define WX_TSC_1588_CTL              0x11F00
+#define WX_TSC_1588_CTL_ENABLED      BIT(4)
+#define WX_TSC_1588_CTL_VALID        BIT(0)
+#define WX_TSC_1588_STMPL            0x11F04
+#define WX_TSC_1588_STMPH            0x11F08
+#define WX_TSC_1588_SYSTIML          0x11F0C
+#define WX_TSC_1588_SYSTIMH          0x11F10
+#define WX_TSC_1588_INC              0x11F14
 
 /************************************** MNG ********************************/
 #define WX_MNG_SWFW_SYNC             0x1E008
@@ -460,6 +488,7 @@ enum WX_MSCA_CMD_value {
 #define WX_RXD_STAT_L4CS             BIT(7) /* L4 xsum calculated */
 #define WX_RXD_STAT_IPCS             BIT(8) /* IP xsum calculated */
 #define WX_RXD_STAT_OUTERIPCS        BIT(10) /* Cloud IP xsum calculated*/
+#define WX_RXD_STAT_TS               BIT(14) /* IEEE1588 Time Stamp */
 
 #define WX_RXD_ERR_OUTERIPER         BIT(26) /* CRC IP Header error */
 #define WX_RXD_ERR_RXE               BIT(29) /* Any MAC Error */
@@ -863,6 +892,7 @@ struct wx_tx_context_desc {
  */
 struct wx_tx_buffer {
 	union wx_tx_desc *next_to_watch;
+	unsigned long time_stamp;
 	struct sk_buff *skb;
 	unsigned int bytecount;
 	unsigned short gso_segs;
@@ -924,6 +954,7 @@ struct wx_ring {
 	unsigned int size;              /* length in bytes */
 
 	u16 count;                      /* amount of descriptors */
+	unsigned long last_rx_timestamp;
 
 	u8 queue_index; /* needed for multiqueue queue management */
 	u8 reg_idx;                     /* holds the special value that gets
@@ -1026,6 +1057,8 @@ struct wx_hw_stats {
 
 enum wx_state {
 	WX_STATE_RESETTING,
+	WX_STATE_PTP_RUNNING,
+	WX_STATE_PTP_TX_IN_PROGRESS,
 	WX_STATE_NBITS,		/* must be last */
 };
 
@@ -1033,6 +1066,8 @@ enum wx_pf_flags {
 	WX_FLAG_FDIR_CAPABLE,
 	WX_FLAG_FDIR_HASH,
 	WX_FLAG_FDIR_PERFECT,
+	WX_FLAG_RX_HWTSTAMP_ENABLED,
+	WX_FLAG_RX_HWTSTAMP_IN_REGISTER,
 	WX_PF_FLAGS_NBITS               /* must be last */
 };
 
@@ -1133,6 +1168,22 @@ struct wx {
 	void (*atr)(struct wx_ring *ring, struct wx_tx_buffer *first, u8 ptype);
 	void (*configure_fdir)(struct wx *wx);
 	void (*do_reset)(struct net_device *netdev);
+
+	u32 base_incval;
+	u32 tx_hwtstamp_pkts;
+	u32 tx_hwtstamp_timeouts;
+	u32 tx_hwtstamp_skipped;
+	u32 tx_hwtstamp_errors;
+	u32 rx_hwtstamp_cleared;
+	unsigned long ptp_tx_start;
+	seqlock_t hw_tc_lock; /* seqlock for ptp */
+	struct cyclecounter hw_cc;
+	struct timecounter hw_tc;
+	struct ptp_clock *ptp_clock;
+	struct ptp_clock_info ptp_caps;
+	struct kernel_hwtstamp_config tstamp_config;
+	struct work_struct ptp_tx_work;
+	struct sk_buff *ptp_tx_skb;
 };
 
 #define WX_INTR_ALL (~0ULL)
@@ -1177,6 +1228,24 @@ rd64(struct wx *wx, u32 reg)
 	return (lsb | msb << 32);
 }
 
+static inline u32
+rd32ptp(struct wx *wx, u32 reg)
+{
+	if (wx->mac.type == wx_mac_em)
+		return rd32(wx, reg);
+
+	return rd32(wx, reg + 0xB500);
+}
+
+static inline void
+wr32ptp(struct wx *wx, u32 reg, u32 value)
+{
+	if (wx->mac.type == wx_mac_em)
+		return wr32(wx, reg, value);
+
+	return wr32(wx, reg + 0xB500, value);
+}
+
 /* On some domestic CPU platforms, sometimes IO is not synchronized with
  * flushing memory, here use readl() to flush PCI read and write.
  */
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index 53aeae2f884b..c60a96cc3508 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -14,6 +14,7 @@
 #include "../libwx/wx_type.h"
 #include "../libwx/wx_hw.h"
 #include "../libwx/wx_lib.h"
+#include "../libwx/wx_ptp.h"
 #include "ngbe_type.h"
 #include "ngbe_mdio.h"
 #include "ngbe_hw.h"
@@ -317,6 +318,8 @@ void ngbe_down(struct wx *wx)
 {
 	phylink_stop(wx->phylink);
 	ngbe_disable_device(wx);
+	if (test_bit(WX_STATE_PTP_RUNNING, wx->state))
+		wx_ptp_reset(wx);
 	wx_clean_all_tx_rings(wx);
 	wx_clean_all_rx_rings(wx);
 }
@@ -379,6 +382,8 @@ static int ngbe_open(struct net_device *netdev)
 	if (err)
 		goto err_dis_phy;
 
+	wx_ptp_init(wx);
+
 	ngbe_up(wx);
 
 	return 0;
@@ -407,6 +412,7 @@ static int ngbe_close(struct net_device *netdev)
 {
 	struct wx *wx = netdev_priv(netdev);
 
+	wx_ptp_stop(wx);
 	ngbe_down(wx);
 	wx_free_irq(wx);
 	wx_free_isb_resources(wx);
@@ -507,6 +513,8 @@ static const struct net_device_ops ngbe_netdev_ops = {
 	.ndo_get_stats64        = wx_get_stats64,
 	.ndo_vlan_rx_add_vid    = wx_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid   = wx_vlan_rx_kill_vid,
+	.ndo_hwtstamp_set       = wx_hwtstamp_set,
+	.ndo_hwtstamp_get       = wx_hwtstamp_get,
 };
 
 /**
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
index a5e9b779c44d..c7944e62838a 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
@@ -7,6 +7,7 @@
 #include <linux/phy.h>
 
 #include "../libwx/wx_type.h"
+#include "../libwx/wx_ptp.h"
 #include "../libwx/wx_hw.h"
 #include "ngbe_type.h"
 #include "ngbe_mdio.h"
@@ -64,6 +65,11 @@ static void ngbe_mac_config(struct phylink_config *config, unsigned int mode,
 static void ngbe_mac_link_down(struct phylink_config *config,
 			       unsigned int mode, phy_interface_t interface)
 {
+	struct wx *wx = phylink_to_wx(config);
+
+	wx->speed = SPEED_UNKNOWN;
+	if (test_bit(WX_STATE_PTP_RUNNING, wx->state))
+		wx_ptp_reset_cyclecounter(wx);
 }
 
 static void ngbe_mac_link_up(struct phylink_config *config,
@@ -103,6 +109,10 @@ static void ngbe_mac_link_up(struct phylink_config *config,
 	wr32(wx, WX_MAC_PKT_FLT, WX_MAC_PKT_FLT_PR);
 	reg = rd32(wx, WX_MAC_WDG_TIMEOUT);
 	wr32(wx, WX_MAC_WDG_TIMEOUT, reg);
+
+	wx->speed = speed;
+	if (test_bit(WX_STATE_PTP_RUNNING, wx->state))
+		wx_ptp_reset_cyclecounter(wx);
 }
 
 static const struct phylink_mac_ops ngbe_mac_ops = {
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index f77450268036..734450af9a43 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -13,6 +13,7 @@
 
 #include "../libwx/wx_type.h"
 #include "../libwx/wx_lib.h"
+#include "../libwx/wx_ptp.h"
 #include "../libwx/wx_hw.h"
 #include "txgbe_type.h"
 #include "txgbe_hw.h"
@@ -116,6 +117,9 @@ static void txgbe_reset(struct wx *wx)
 	memcpy(old_addr, &wx->mac_table[0].addr, netdev->addr_len);
 	wx_flush_sw_mac_table(wx);
 	wx_mac_set_default_filter(wx, old_addr);
+
+	if (test_bit(WX_STATE_PTP_RUNNING, wx->state))
+		wx_ptp_reset(wx);
 }
 
 static void txgbe_disable_device(struct wx *wx)
@@ -176,6 +180,7 @@ void txgbe_down(struct wx *wx)
 void txgbe_up(struct wx *wx)
 {
 	wx_configure(wx);
+	wx_ptp_init(wx);
 	txgbe_up_complete(wx);
 }
 
@@ -321,6 +326,8 @@ static int txgbe_open(struct net_device *netdev)
 	if (err)
 		goto err_free_irq;
 
+	wx_ptp_init(wx);
+
 	txgbe_up_complete(wx);
 
 	return 0;
@@ -344,6 +351,7 @@ static int txgbe_open(struct net_device *netdev)
  */
 static void txgbe_close_suspend(struct wx *wx)
 {
+	wx_ptp_suspend(wx);
 	txgbe_disable_device(wx);
 	wx_free_resources(wx);
 }
@@ -363,6 +371,7 @@ static int txgbe_close(struct net_device *netdev)
 {
 	struct wx *wx = netdev_priv(netdev);
 
+	wx_ptp_stop(wx);
 	txgbe_down(wx);
 	wx_free_irq(wx);
 	wx_free_resources(wx);
@@ -479,6 +488,8 @@ static const struct net_device_ops txgbe_netdev_ops = {
 	.ndo_get_stats64        = wx_get_stats64,
 	.ndo_vlan_rx_add_vid    = wx_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid   = wx_vlan_rx_kill_vid,
+	.ndo_hwtstamp_set       = wx_hwtstamp_set,
+	.ndo_hwtstamp_get       = wx_hwtstamp_get,
 };
 
 /**
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
index 1ae68f94dd49..60e5f3288ad8 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
@@ -15,6 +15,7 @@
 
 #include "../libwx/wx_type.h"
 #include "../libwx/wx_lib.h"
+#include "../libwx/wx_ptp.h"
 #include "../libwx/wx_hw.h"
 #include "txgbe_type.h"
 #include "txgbe_phy.h"
@@ -179,6 +180,10 @@ static void txgbe_mac_link_down(struct phylink_config *config,
 	struct wx *wx = phylink_to_wx(config);
 
 	wr32m(wx, WX_MAC_TX_CFG, WX_MAC_TX_CFG_TE, 0);
+
+	wx->speed = SPEED_UNKNOWN;
+	if (test_bit(WX_STATE_PTP_RUNNING, wx->state))
+		wx_ptp_reset_cyclecounter(wx);
 }
 
 static void txgbe_mac_link_up(struct phylink_config *config,
@@ -215,6 +220,10 @@ static void txgbe_mac_link_up(struct phylink_config *config,
 	wr32(wx, WX_MAC_PKT_FLT, WX_MAC_PKT_FLT_PR);
 	wdg = rd32(wx, WX_MAC_WDG_TIMEOUT);
 	wr32(wx, WX_MAC_WDG_TIMEOUT, wdg);
+
+	wx->speed = speed;
+	if (test_bit(WX_STATE_PTP_RUNNING, wx->state))
+		wx_ptp_reset_cyclecounter(wx);
 }
 
 static int txgbe_mac_prepare(struct phylink_config *config, unsigned int mode,
-- 
2.27.0


