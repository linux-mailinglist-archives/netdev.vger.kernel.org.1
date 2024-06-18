Return-Path: <netdev+bounces-104451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A0490C92C
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 13:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3286328663D
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 11:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A6A13AA51;
	Tue, 18 Jun 2024 10:18:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.77.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0525E2B9B6
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 10:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.77.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718705916; cv=none; b=tbhyX1P9kbXVD0WULqHZ8EE2vfT03oTQrfRfIjJSL9AMUYeGA6S8fDCYCKEnk0rT+ih+9M5tsY+EjG+4wzA24wB1lwNyLIte/YTRdgBGztseBgneejGuMALEV1taIrijYBaIQiBMce0NHsrao0/OdvBlZ0R3oUcgqHM79lHqHzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718705916; c=relaxed/simple;
	bh=SyNr08NabdzXfUjtRGgRNcVE2W7RReTIHAFFwVY49UI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ML7NtXoJBIFyJuZ1hqlbW5vnUurGWDUNOWkr51/LeKcxTjpSrDQ5wafSpYaznXXCwyYyqmnWXIt1acY9B86jehUFv1TDEILrh5O81iCxD8N801HwmxMpEf5B+rCgkTMl6nkXo8yu0CX9ygA0/iwJ3wRpqEJA+m/aTrMe7o/j9go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=114.132.77.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtpsz9t1718705778tohlj93
X-QQ-Originating-IP: QB2u1HF1ctfFJrjr2CiffPvN+fXpXbvNdWzaoC2FU3c=
Received: from lap-jiawenwu.trustnetic.com ( [183.159.97.141])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 18 Jun 2024 18:16:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17707120873498691987
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: davem@davemloft.net,
	dumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch,
	rmk+kernel@armlinux.org.uk,
	horms@kernel.org,
	netdev@vger.kernel.org
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v3 1/3] net: txgbe: add FDIR ATR support
Date: Tue, 18 Jun 2024 18:16:07 +0800
Message-Id: <20240618101609.3580-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20240618101609.3580-1-jiawenwu@trustnetic.com>
References: <20240618101609.3580-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1

Add flow director ATR filter. ATR mode is enabled by default to filter
TCP packets.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  27 +-
 drivers/net/ethernet/wangxun/libwx/wx_hw.h    |   2 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  31 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |   1 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  52 ++-
 drivers/net/ethernet/wangxun/txgbe/Makefile   |   1 +
 .../net/ethernet/wangxun/txgbe/txgbe_fdir.c   | 302 ++++++++++++++++++
 .../net/ethernet/wangxun/txgbe/txgbe_fdir.h   |  10 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |   9 +
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   | 121 +++++++
 10 files changed, 548 insertions(+), 8 deletions(-)
 create mode 100644 drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.c
 create mode 100644 drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.h

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 7c4b6881a93f..8fb38f83a615 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -1147,8 +1147,15 @@ static void wx_enable_rx(struct wx *wx)
 static void wx_set_rxpba(struct wx *wx)
 {
 	u32 rxpktsize, txpktsize, txpbthresh;
+	u32 pbsize = wx->mac.rx_pb_size;
 
-	rxpktsize = wx->mac.rx_pb_size << WX_RDB_PB_SZ_SHIFT;
+	if (test_bit(WX_FLAG_FDIR_CAPABLE, wx->flags)) {
+		if (test_bit(WX_FLAG_FDIR_HASH, wx->flags) ||
+		    test_bit(WX_FLAG_FDIR_PERFECT, wx->flags))
+			pbsize -= 64; /* Default 64KB */
+	}
+
+	rxpktsize = pbsize << WX_RDB_PB_SZ_SHIFT;
 	wr32(wx, WX_RDB_PB_SZ(0), rxpktsize);
 
 	/* Only support an equally distributed Tx packet buffer strategy. */
@@ -1261,7 +1268,7 @@ static void wx_configure_port(struct wx *wx)
  *  Stops the receive data path and waits for the HW to internally empty
  *  the Rx security block
  **/
-static int wx_disable_sec_rx_path(struct wx *wx)
+int wx_disable_sec_rx_path(struct wx *wx)
 {
 	u32 secrx;
 
@@ -1271,6 +1278,7 @@ static int wx_disable_sec_rx_path(struct wx *wx)
 	return read_poll_timeout(rd32, secrx, secrx & WX_RSC_ST_RSEC_RDY,
 				 1000, 40000, false, wx, WX_RSC_ST);
 }
+EXPORT_SYMBOL(wx_disable_sec_rx_path);
 
 /**
  *  wx_enable_sec_rx_path - Enables the receive data path
@@ -1278,11 +1286,12 @@ static int wx_disable_sec_rx_path(struct wx *wx)
  *
  *  Enables the receive data path.
  **/
-static void wx_enable_sec_rx_path(struct wx *wx)
+void wx_enable_sec_rx_path(struct wx *wx)
 {
 	wr32m(wx, WX_RSC_CTL, WX_RSC_CTL_RX_DIS, 0);
 	WX_WRITE_FLUSH(wx);
 }
+EXPORT_SYMBOL(wx_enable_sec_rx_path);
 
 static void wx_vlan_strip_control(struct wx *wx, bool enable)
 {
@@ -1499,6 +1508,13 @@ static void wx_configure_tx_ring(struct wx *wx,
 		txdctl |= ring->count / 128 << WX_PX_TR_CFG_TR_SIZE_SHIFT;
 	txdctl |= 0x20 << WX_PX_TR_CFG_WTHRESH_SHIFT;
 
+	ring->atr_count = 0;
+	if (test_bit(WX_FLAG_FDIR_CAPABLE, wx->flags) &&
+	    test_bit(WX_FLAG_FDIR_HASH, wx->flags))
+		ring->atr_sample_rate = wx->atr_sample_rate;
+	else
+		ring->atr_sample_rate = 0;
+
 	/* reinitialize tx_buffer_info */
 	memset(ring->tx_buffer_info, 0,
 	       sizeof(struct wx_tx_buffer) * ring->count);
@@ -1732,7 +1748,9 @@ void wx_configure(struct wx *wx)
 
 	wx_set_rx_mode(wx->netdev);
 	wx_restore_vlan(wx);
-	wx_enable_sec_rx_path(wx);
+
+	if (test_bit(WX_FLAG_FDIR_CAPABLE, wx->flags))
+		wx->configure_fdir(wx);
 
 	wx_configure_tx(wx);
 	wx_configure_rx(wx);
@@ -1959,6 +1977,7 @@ int wx_sw_init(struct wx *wx)
 	}
 
 	bitmap_zero(wx->state, WX_STATE_NBITS);
+	bitmap_zero(wx->flags, WX_PF_FLAGS_NBITS);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.h b/drivers/net/ethernet/wangxun/libwx/wx_hw.h
index 9e219fa717a2..11fb33349482 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.h
@@ -28,6 +28,8 @@ void wx_mac_set_default_filter(struct wx *wx, u8 *addr);
 void wx_flush_sw_mac_table(struct wx *wx);
 int wx_set_mac(struct net_device *netdev, void *p);
 void wx_disable_rx(struct wx *wx);
+int wx_disable_sec_rx_path(struct wx *wx);
+void wx_enable_sec_rx_path(struct wx *wx);
 void wx_set_rx_mode(struct net_device *netdev);
 int wx_change_mtu(struct net_device *netdev, int new_mtu);
 void wx_disable_rx_queue(struct wx *wx, struct wx_ring *ring);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 68bde91b67a0..6fbdbb6c9bb5 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -148,10 +148,11 @@ static struct wx_dec_ptype wx_ptype_lookup[256] = {
 	[0xFD] = WX_PTT(IP, IPV6, IGMV, IPV6, SCTP, PAY4),
 };
 
-static struct wx_dec_ptype wx_decode_ptype(const u8 ptype)
+struct wx_dec_ptype wx_decode_ptype(const u8 ptype)
 {
 	return wx_ptype_lookup[ptype];
 }
+EXPORT_SYMBOL(wx_decode_ptype);
 
 /* wx_test_staterr - tests bits in Rx descriptor status and error fields */
 static __le32 wx_test_staterr(union wx_rx_desc *rx_desc,
@@ -1453,6 +1454,7 @@ static void wx_tx_csum(struct wx_ring *tx_ring, struct wx_tx_buffer *first,
 static netdev_tx_t wx_xmit_frame_ring(struct sk_buff *skb,
 				      struct wx_ring *tx_ring)
 {
+	struct wx *wx = netdev_priv(tx_ring->netdev);
 	u16 count = TXD_USE_COUNT(skb_headlen(skb));
 	struct wx_tx_buffer *first;
 	u8 hdr_len = 0, ptype;
@@ -1498,6 +1500,10 @@ static netdev_tx_t wx_xmit_frame_ring(struct sk_buff *skb,
 		goto out_drop;
 	else if (!tso)
 		wx_tx_csum(tx_ring, first, ptype);
+
+	if (test_bit(WX_FLAG_FDIR_CAPABLE, wx->flags) && tx_ring->atr_sample_rate)
+		wx->atr(tx_ring, first, ptype);
+
 	wx_tx_map(tx_ring, first, hdr_len);
 
 	return NETDEV_TX_OK;
@@ -1574,8 +1580,27 @@ static void wx_set_rss_queues(struct wx *wx)
 	f = &wx->ring_feature[RING_F_RSS];
 	f->indices = f->limit;
 
-	wx->num_rx_queues = f->limit;
-	wx->num_tx_queues = f->limit;
+	if (!(test_bit(WX_FLAG_FDIR_CAPABLE, wx->flags)))
+		goto out;
+
+	clear_bit(WX_FLAG_FDIR_HASH, wx->flags);
+
+	/* Use Flow Director in addition to RSS to ensure the best
+	 * distribution of flows across cores, even when an FDIR flow
+	 * isn't matched.
+	 */
+	if (f->indices > 1) {
+		f = &wx->ring_feature[RING_F_FDIR];
+
+		f->indices = f->limit;
+
+		if (!(test_bit(WX_FLAG_FDIR_PERFECT, wx->flags)))
+			set_bit(WX_FLAG_FDIR_HASH, wx->flags);
+	}
+
+out:
+	wx->num_rx_queues = f->indices;
+	wx->num_tx_queues = f->indices;
 }
 
 static void wx_set_num_queues(struct wx *wx)
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.h b/drivers/net/ethernet/wangxun/libwx/wx_lib.h
index c41b29ea812f..fdeb0c315b75 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.h
@@ -7,6 +7,7 @@
 #ifndef _WX_LIB_H_
 #define _WX_LIB_H_
 
+struct wx_dec_ptype wx_decode_ptype(const u8 ptype);
 void wx_alloc_rx_buffers(struct wx_ring *rx_ring, u16 cleaned_count);
 u16 wx_desc_unused(struct wx_ring *ring);
 netdev_tx_t wx_xmit_frame(struct sk_buff *skb,
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 5aaf7b1fa2db..b1f9bab06e90 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -503,6 +503,34 @@ enum WX_MSCA_CMD_value {
 #define WX_PTYPE_TYP_TCP             0x04
 #define WX_PTYPE_TYP_SCTP            0x05
 
+/* Packet type non-ip values */
+enum wx_l2_ptypes {
+	WX_PTYPE_L2_ABORTED = (WX_PTYPE_PKT_MAC),
+	WX_PTYPE_L2_MAC = (WX_PTYPE_PKT_MAC | WX_PTYPE_TYP_MAC),
+
+	WX_PTYPE_L2_IPV4_FRAG = (WX_PTYPE_PKT_IP | WX_PTYPE_TYP_IPFRAG),
+	WX_PTYPE_L2_IPV4 = (WX_PTYPE_PKT_IP | WX_PTYPE_TYP_IP),
+	WX_PTYPE_L2_IPV4_UDP = (WX_PTYPE_PKT_IP | WX_PTYPE_TYP_UDP),
+	WX_PTYPE_L2_IPV4_TCP = (WX_PTYPE_PKT_IP | WX_PTYPE_TYP_TCP),
+	WX_PTYPE_L2_IPV4_SCTP = (WX_PTYPE_PKT_IP | WX_PTYPE_TYP_SCTP),
+	WX_PTYPE_L2_IPV6_FRAG = (WX_PTYPE_PKT_IP | WX_PTYPE_PKT_IPV6 |
+				 WX_PTYPE_TYP_IPFRAG),
+	WX_PTYPE_L2_IPV6 = (WX_PTYPE_PKT_IP | WX_PTYPE_PKT_IPV6 |
+			    WX_PTYPE_TYP_IP),
+	WX_PTYPE_L2_IPV6_UDP = (WX_PTYPE_PKT_IP | WX_PTYPE_PKT_IPV6 |
+				WX_PTYPE_TYP_UDP),
+	WX_PTYPE_L2_IPV6_TCP = (WX_PTYPE_PKT_IP | WX_PTYPE_PKT_IPV6 |
+				WX_PTYPE_TYP_TCP),
+	WX_PTYPE_L2_IPV6_SCTP = (WX_PTYPE_PKT_IP | WX_PTYPE_PKT_IPV6 |
+				 WX_PTYPE_TYP_SCTP),
+
+	WX_PTYPE_L2_TUN4_MAC = (WX_PTYPE_TUN_IPV4 | WX_PTYPE_PKT_IGM),
+	WX_PTYPE_L2_TUN6_MAC = (WX_PTYPE_TUN_IPV6 | WX_PTYPE_PKT_IGM),
+};
+
+#define WX_PTYPE_PKT(_pt)            ((_pt) & 0x30)
+#define WX_PTYPE_TYPL4(_pt)          ((_pt) & 0x07)
+
 #define WX_RXD_PKTTYPE(_rxd) \
 	((le32_to_cpu((_rxd)->wb.lower.lo_dword.data) >> 9) & 0xFF)
 #define WX_RXD_IPV6EX(_rxd) \
@@ -552,6 +580,9 @@ enum wx_tx_flags {
 	WX_TX_FLAGS_OUTER_IPV4	= 0x100,
 	WX_TX_FLAGS_LINKSEC	= 0x200,
 	WX_TX_FLAGS_IPSEC	= 0x400,
+
+	/* software defined flags */
+	WX_TX_FLAGS_SW_VLAN	= 0x40,
 };
 
 /* VLAN info */
@@ -900,7 +931,13 @@ struct wx_ring {
 					 */
 	u16 next_to_use;
 	u16 next_to_clean;
-	u16 next_to_alloc;
+	union {
+		u16 next_to_alloc;
+		struct {
+			u8 atr_sample_rate;
+			u8 atr_count;
+		};
+	};
 
 	struct wx_queue_stats stats;
 	struct u64_stats_sync syncp;
@@ -939,6 +976,7 @@ struct wx_ring_feature {
 enum wx_ring_f_enum {
 	RING_F_NONE = 0,
 	RING_F_RSS,
+	RING_F_FDIR,
 	RING_F_ARRAY_SIZE  /* must be last in enum set */
 };
 
@@ -986,9 +1024,18 @@ enum wx_state {
 	WX_STATE_RESETTING,
 	WX_STATE_NBITS,		/* must be last */
 };
+
+enum wx_pf_flags {
+	WX_FLAG_FDIR_CAPABLE,
+	WX_FLAG_FDIR_HASH,
+	WX_FLAG_FDIR_PERFECT,
+	WX_PF_FLAGS_NBITS               /* must be last */
+};
+
 struct wx {
 	unsigned long active_vlans[BITS_TO_LONGS(VLAN_N_VID)];
 	DECLARE_BITMAP(state, WX_STATE_NBITS);
+	DECLARE_BITMAP(flags, WX_PF_FLAGS_NBITS);
 
 	void *priv;
 	u8 __iomem *hw_addr;
@@ -1077,6 +1124,9 @@ struct wx {
 	u64 hw_csum_rx_error;
 	u64 alloc_rx_buff_failed;
 
+	u32 atr_sample_rate;
+	void (*atr)(struct wx_ring *ring, struct wx_tx_buffer *first, u8 ptype);
+	void (*configure_fdir)(struct wx *wx);
 	void (*do_reset)(struct net_device *netdev);
 };
 
diff --git a/drivers/net/ethernet/wangxun/txgbe/Makefile b/drivers/net/ethernet/wangxun/txgbe/Makefile
index 42718875277c..f74576fe7062 100644
--- a/drivers/net/ethernet/wangxun/txgbe/Makefile
+++ b/drivers/net/ethernet/wangxun/txgbe/Makefile
@@ -10,4 +10,5 @@ txgbe-objs := txgbe_main.o \
               txgbe_hw.o \
               txgbe_phy.o \
               txgbe_irq.o \
+              txgbe_fdir.o \
               txgbe_ethtool.o
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.c
new file mode 100644
index 000000000000..6158209e84cb
--- /dev/null
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.c
@@ -0,0 +1,302 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2015 - 2024 Beijing WangXun Technology Co., Ltd. */
+
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/pci.h>
+
+#include "../libwx/wx_type.h"
+#include "../libwx/wx_lib.h"
+#include "../libwx/wx_hw.h"
+#include "txgbe_type.h"
+#include "txgbe_fdir.h"
+
+/* These defines allow us to quickly generate all of the necessary instructions
+ * in the function below by simply calling out TXGBE_COMPUTE_SIG_HASH_ITERATION
+ * for values 0 through 15
+ */
+#define TXGBE_ATR_COMMON_HASH_KEY \
+		(TXGBE_ATR_BUCKET_HASH_KEY & TXGBE_ATR_SIGNATURE_HASH_KEY)
+#define TXGBE_COMPUTE_SIG_HASH_ITERATION(_n) \
+do { \
+	u32 n = (_n); \
+	if (TXGBE_ATR_COMMON_HASH_KEY & (0x01 << n)) \
+		common_hash ^= lo_hash_dword >> n; \
+	else if (TXGBE_ATR_BUCKET_HASH_KEY & (0x01 << n)) \
+		bucket_hash ^= lo_hash_dword >> n; \
+	else if (TXGBE_ATR_SIGNATURE_HASH_KEY & (0x01 << n)) \
+		sig_hash ^= lo_hash_dword << (16 - n); \
+	if (TXGBE_ATR_COMMON_HASH_KEY & (0x01 << (n + 16))) \
+		common_hash ^= hi_hash_dword >> n; \
+	else if (TXGBE_ATR_BUCKET_HASH_KEY & (0x01 << (n + 16))) \
+		bucket_hash ^= hi_hash_dword >> n; \
+	else if (TXGBE_ATR_SIGNATURE_HASH_KEY & (0x01 << (n + 16))) \
+		sig_hash ^= hi_hash_dword << (16 - n); \
+} while (0)
+
+/**
+ *  txgbe_atr_compute_sig_hash - Compute the signature hash
+ *  @input: input bitstream to compute the hash on
+ *  @common: compressed common input dword
+ *  @hash: pointer to the computed hash
+ *
+ *  This function is almost identical to the function above but contains
+ *  several optimizations such as unwinding all of the loops, letting the
+ *  compiler work out all of the conditional ifs since the keys are static
+ *  defines, and computing two keys at once since the hashed dword stream
+ *  will be the same for both keys.
+ **/
+static void txgbe_atr_compute_sig_hash(union txgbe_atr_hash_dword input,
+				       union txgbe_atr_hash_dword common,
+				       u32 *hash)
+{
+	u32 sig_hash = 0, bucket_hash = 0, common_hash = 0;
+	u32 hi_hash_dword, lo_hash_dword, flow_vm_vlan;
+	u32 i;
+
+	/* record the flow_vm_vlan bits as they are a key part to the hash */
+	flow_vm_vlan = ntohl(input.dword);
+
+	/* generate common hash dword */
+	hi_hash_dword = ntohl(common.dword);
+
+	/* low dword is word swapped version of common */
+	lo_hash_dword = (hi_hash_dword >> 16) | (hi_hash_dword << 16);
+
+	/* apply flow ID/VM pool/VLAN ID bits to hash words */
+	hi_hash_dword ^= flow_vm_vlan ^ (flow_vm_vlan >> 16);
+
+	/* Process bits 0 and 16 */
+	TXGBE_COMPUTE_SIG_HASH_ITERATION(0);
+
+	/* apply flow ID/VM pool/VLAN ID bits to lo hash dword, we had to
+	 * delay this because bit 0 of the stream should not be processed
+	 * so we do not add the VLAN until after bit 0 was processed
+	 */
+	lo_hash_dword ^= flow_vm_vlan ^ (flow_vm_vlan << 16);
+
+	/* Process remaining 30 bit of the key */
+	for (i = 1; i <= 15; i++)
+		TXGBE_COMPUTE_SIG_HASH_ITERATION(i);
+
+	/* combine common_hash result with signature and bucket hashes */
+	bucket_hash ^= common_hash;
+	bucket_hash &= TXGBE_ATR_HASH_MASK;
+
+	sig_hash ^= common_hash << 16;
+	sig_hash &= TXGBE_ATR_HASH_MASK << 16;
+
+	/* return completed signature hash */
+	*hash = sig_hash ^ bucket_hash;
+}
+
+static int txgbe_fdir_check_cmd_complete(struct wx *wx)
+{
+	u32 val;
+
+	return read_poll_timeout_atomic(rd32, val,
+					!(val & TXGBE_RDB_FDIR_CMD_CMD_MASK),
+					10, 100, false,
+					wx, TXGBE_RDB_FDIR_CMD);
+}
+
+/**
+ *  txgbe_fdir_add_signature_filter - Adds a signature hash filter
+ *  @wx: pointer to hardware structure
+ *  @input: unique input dword
+ *  @common: compressed common input dword
+ *  @queue: queue index to direct traffic to
+ *
+ *  @return: 0 on success and negative on failure
+ **/
+static int txgbe_fdir_add_signature_filter(struct wx *wx,
+					   union txgbe_atr_hash_dword input,
+					   union txgbe_atr_hash_dword common,
+					   u8 queue)
+{
+	u32 fdirhashcmd, fdircmd;
+	u8 flow_type;
+	int err;
+
+	/* Get the flow_type in order to program FDIRCMD properly
+	 * lowest 2 bits are FDIRCMD.L4TYPE, third lowest bit is FDIRCMD.IPV6
+	 * fifth is FDIRCMD.TUNNEL_FILTER
+	 */
+	flow_type = input.formatted.flow_type;
+	switch (flow_type) {
+	case TXGBE_ATR_FLOW_TYPE_TCPV4:
+	case TXGBE_ATR_FLOW_TYPE_UDPV4:
+	case TXGBE_ATR_FLOW_TYPE_SCTPV4:
+	case TXGBE_ATR_FLOW_TYPE_TCPV6:
+	case TXGBE_ATR_FLOW_TYPE_UDPV6:
+	case TXGBE_ATR_FLOW_TYPE_SCTPV6:
+		break;
+	default:
+		wx_err(wx, "Error on flow type input\n");
+		return -EINVAL;
+	}
+
+	/* configure FDIRCMD register */
+	fdircmd = TXGBE_RDB_FDIR_CMD_CMD_ADD_FLOW |
+		  TXGBE_RDB_FDIR_CMD_FILTER_UPDATE |
+		  TXGBE_RDB_FDIR_CMD_LAST | TXGBE_RDB_FDIR_CMD_QUEUE_EN;
+	fdircmd |= TXGBE_RDB_FDIR_CMD_FLOW_TYPE(flow_type);
+	fdircmd |= TXGBE_RDB_FDIR_CMD_RX_QUEUE(queue);
+
+	txgbe_atr_compute_sig_hash(input, common, &fdirhashcmd);
+	fdirhashcmd |= TXGBE_RDB_FDIR_HASH_BUCKET_VALID;
+	wr32(wx, TXGBE_RDB_FDIR_HASH, fdirhashcmd);
+	wr32(wx, TXGBE_RDB_FDIR_CMD, fdircmd);
+
+	wx_dbg(wx, "Tx Queue=%x hash=%x\n", queue, (u32)fdirhashcmd);
+
+	err = txgbe_fdir_check_cmd_complete(wx);
+	if (err)
+		wx_err(wx, "Flow Director command did not complete!\n");
+
+	return err;
+}
+
+void txgbe_atr(struct wx_ring *ring, struct wx_tx_buffer *first, u8 ptype)
+{
+	union txgbe_atr_hash_dword common = { .dword = 0 };
+	union txgbe_atr_hash_dword input = { .dword = 0 };
+	struct wx_q_vector *q_vector = ring->q_vector;
+	struct wx_dec_ptype dptype;
+	union network_header {
+		struct ipv6hdr *ipv6;
+		struct iphdr *ipv4;
+		void *raw;
+	} hdr;
+	struct tcphdr *th;
+
+	/* if ring doesn't have a interrupt vector, cannot perform ATR */
+	if (!q_vector)
+		return;
+
+	ring->atr_count++;
+	dptype = wx_decode_ptype(ptype);
+	if (dptype.etype) {
+		if (WX_PTYPE_TYPL4(ptype) != WX_PTYPE_TYP_TCP)
+			return;
+		hdr.raw = (void *)skb_inner_network_header(first->skb);
+		th = inner_tcp_hdr(first->skb);
+	} else {
+		if (WX_PTYPE_PKT(ptype) != WX_PTYPE_PKT_IP ||
+		    WX_PTYPE_TYPL4(ptype) != WX_PTYPE_TYP_TCP)
+			return;
+		hdr.raw = (void *)skb_network_header(first->skb);
+		th = tcp_hdr(first->skb);
+	}
+
+	/* skip this packet since it is invalid or the socket is closing */
+	if (!th || th->fin)
+		return;
+
+	/* sample on all syn packets or once every atr sample count */
+	if (!th->syn && ring->atr_count < ring->atr_sample_rate)
+		return;
+
+	/* reset sample count */
+	ring->atr_count = 0;
+
+	/* src and dst are inverted, think how the receiver sees them
+	 *
+	 * The input is broken into two sections, a non-compressed section
+	 * containing vm_pool, vlan_id, and flow_type.  The rest of the data
+	 * is XORed together and stored in the compressed dword.
+	 */
+	input.formatted.vlan_id = htons((u16)ptype);
+
+	/* since src port and flex bytes occupy the same word XOR them together
+	 * and write the value to source port portion of compressed dword
+	 */
+	if (first->tx_flags & WX_TX_FLAGS_SW_VLAN)
+		common.port.src ^= th->dest ^ first->skb->protocol;
+	else if (first->tx_flags & WX_TX_FLAGS_HW_VLAN)
+		common.port.src ^= th->dest ^ first->skb->vlan_proto;
+	else
+		common.port.src ^= th->dest ^ first->protocol;
+	common.port.dst ^= th->source;
+
+	if (WX_PTYPE_PKT_IPV6 & WX_PTYPE_PKT(ptype)) {
+		input.formatted.flow_type = TXGBE_ATR_FLOW_TYPE_TCPV6;
+		common.ip ^= hdr.ipv6->saddr.s6_addr32[0] ^
+					 hdr.ipv6->saddr.s6_addr32[1] ^
+					 hdr.ipv6->saddr.s6_addr32[2] ^
+					 hdr.ipv6->saddr.s6_addr32[3] ^
+					 hdr.ipv6->daddr.s6_addr32[0] ^
+					 hdr.ipv6->daddr.s6_addr32[1] ^
+					 hdr.ipv6->daddr.s6_addr32[2] ^
+					 hdr.ipv6->daddr.s6_addr32[3];
+	} else {
+		input.formatted.flow_type = TXGBE_ATR_FLOW_TYPE_TCPV4;
+		common.ip ^= hdr.ipv4->saddr ^ hdr.ipv4->daddr;
+	}
+
+	/* This assumes the Rx queue and Tx queue are bound to the same CPU */
+	txgbe_fdir_add_signature_filter(q_vector->wx, input, common,
+					ring->queue_index);
+}
+
+/**
+ *  txgbe_fdir_enable - Initialize Flow Director control registers
+ *  @wx: pointer to hardware structure
+ *  @fdirctrl: value to write to flow director control register
+ **/
+static void txgbe_fdir_enable(struct wx *wx, u32 fdirctrl)
+{
+	u32 val;
+	int ret;
+
+	/* Prime the keys for hashing */
+	wr32(wx, TXGBE_RDB_FDIR_HKEY, TXGBE_ATR_BUCKET_HASH_KEY);
+	wr32(wx, TXGBE_RDB_FDIR_SKEY, TXGBE_ATR_SIGNATURE_HASH_KEY);
+
+	wr32(wx, TXGBE_RDB_FDIR_CTL, fdirctrl);
+	WX_WRITE_FLUSH(wx);
+	ret = read_poll_timeout(rd32, val, val & TXGBE_RDB_FDIR_CTL_INIT_DONE,
+				1000, 10000, false, wx, TXGBE_RDB_FDIR_CTL);
+
+	if (ret < 0)
+		wx_dbg(wx, "Flow Director poll time exceeded!\n");
+}
+
+/**
+ *  txgbe_init_fdir_signature -Initialize Flow Director sig filters
+ *  @wx: pointer to hardware structure
+ **/
+static void txgbe_init_fdir_signature(struct wx *wx)
+{
+	u32 fdirctrl = TXGBE_FDIR_PBALLOC_64K;
+	u32 flex = 0;
+
+	flex = rd32(wx, TXGBE_RDB_FDIR_FLEX_CFG(0));
+	flex &= ~TXGBE_RDB_FDIR_FLEX_CFG_FIELD0;
+
+	flex |= (TXGBE_RDB_FDIR_FLEX_CFG_BASE_MAC |
+		 TXGBE_RDB_FDIR_FLEX_CFG_OFST(0x6));
+	wr32(wx, TXGBE_RDB_FDIR_FLEX_CFG(0), flex);
+
+	/* Continue setup of fdirctrl register bits:
+	 *  Move the flexible bytes to use the ethertype - shift 6 words
+	 *  Set the maximum length per hash bucket to 0xA filters
+	 *  Send interrupt when 64 filters are left
+	 */
+	fdirctrl |= TXGBE_RDB_FDIR_CTL_HASH_BITS(0xF) |
+		    TXGBE_RDB_FDIR_CTL_MAX_LENGTH(0xA) |
+		    TXGBE_RDB_FDIR_CTL_FULL_THRESH(4);
+
+	/* write hashes and fdirctrl register, poll for completion */
+	txgbe_fdir_enable(wx, fdirctrl);
+}
+
+void txgbe_configure_fdir(struct wx *wx)
+{
+	wx_disable_sec_rx_path(wx);
+
+	if (test_bit(WX_FLAG_FDIR_HASH, wx->flags))
+		txgbe_init_fdir_signature(wx);
+
+	wx_enable_sec_rx_path(wx);
+}
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.h
new file mode 100644
index 000000000000..ed245b66dc2a
--- /dev/null
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2015 - 2024 Beijing WangXun Technology Co., Ltd. */
+
+#ifndef _TXGBE_FDIR_H_
+#define _TXGBE_FDIR_H_
+
+void txgbe_atr(struct wx_ring *ring, struct wx_tx_buffer *first, u8 ptype);
+void txgbe_configure_fdir(struct wx *wx);
+
+#endif /* _TXGBE_FDIR_H_ */
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index 8c7a74981b90..ce49fb725541 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -18,6 +18,7 @@
 #include "txgbe_hw.h"
 #include "txgbe_phy.h"
 #include "txgbe_irq.h"
+#include "txgbe_fdir.h"
 #include "txgbe_ethtool.h"
 
 char txgbe_driver_name[] = "txgbe";
@@ -257,6 +258,14 @@ static int txgbe_sw_init(struct wx *wx)
 						   num_online_cpus());
 	wx->rss_enabled = true;
 
+	wx->ring_feature[RING_F_FDIR].limit = min_t(int, TXGBE_MAX_FDIR_INDICES,
+						    num_online_cpus());
+	set_bit(WX_FLAG_FDIR_CAPABLE, wx->flags);
+	set_bit(WX_FLAG_FDIR_HASH, wx->flags);
+	wx->atr_sample_rate = TXGBE_DEFAULT_ATR_SAMPLE_RATE;
+	wx->atr = txgbe_atr;
+	wx->configure_fdir = txgbe_configure_fdir;
+
 	/* enable itr by default in dynamic mode */
 	wx->rx_itr_setting = 1;
 	wx->tx_itr_setting = 1;
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
index f434a7865cb7..5b8c55df35fe 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
@@ -89,6 +89,39 @@
 #define TXGBE_XPCS_IDA_ADDR                     0x13000
 #define TXGBE_XPCS_IDA_DATA                     0x13004
 
+/********************************* Flow Director *****************************/
+#define TXGBE_RDB_FDIR_CTL                      0x19500
+#define TXGBE_RDB_FDIR_CTL_INIT_DONE            BIT(3)
+#define TXGBE_RDB_FDIR_CTL_PERFECT_MATCH        BIT(4)
+#define TXGBE_RDB_FDIR_CTL_DROP_Q(v)            FIELD_PREP(GENMASK(14, 8), v)
+#define TXGBE_RDB_FDIR_CTL_HASH_BITS(v)         FIELD_PREP(GENMASK(23, 20), v)
+#define TXGBE_RDB_FDIR_CTL_MAX_LENGTH(v)        FIELD_PREP(GENMASK(27, 24), v)
+#define TXGBE_RDB_FDIR_CTL_FULL_THRESH(v)       FIELD_PREP(GENMASK(31, 28), v)
+#define TXGBE_RDB_FDIR_HASH                     0x19528
+#define TXGBE_RDB_FDIR_HASH_SIG_SW_INDEX(v)     FIELD_PREP(GENMASK(31, 16), v)
+#define TXGBE_RDB_FDIR_HASH_BUCKET_VALID        BIT(15)
+#define TXGBE_RDB_FDIR_CMD                      0x1952C
+#define TXGBE_RDB_FDIR_CMD_CMD_MASK             GENMASK(1, 0)
+#define TXGBE_RDB_FDIR_CMD_CMD(v)               FIELD_PREP(GENMASK(1, 0), v)
+#define TXGBE_RDB_FDIR_CMD_CMD_ADD_FLOW         TXGBE_RDB_FDIR_CMD_CMD(1)
+#define TXGBE_RDB_FDIR_CMD_CMD_REMOVE_FLOW      TXGBE_RDB_FDIR_CMD_CMD(2)
+#define TXGBE_RDB_FDIR_CMD_CMD_QUERY_REM_FILT   TXGBE_RDB_FDIR_CMD_CMD(3)
+#define TXGBE_RDB_FDIR_CMD_FILTER_VALID         BIT(2)
+#define TXGBE_RDB_FDIR_CMD_FILTER_UPDATE        BIT(3)
+#define TXGBE_RDB_FDIR_CMD_FLOW_TYPE(v)         FIELD_PREP(GENMASK(6, 5), v)
+#define TXGBE_RDB_FDIR_CMD_DROP                 BIT(9)
+#define TXGBE_RDB_FDIR_CMD_LAST                 BIT(11)
+#define TXGBE_RDB_FDIR_CMD_QUEUE_EN             BIT(15)
+#define TXGBE_RDB_FDIR_CMD_RX_QUEUE(v)          FIELD_PREP(GENMASK(22, 16), v)
+#define TXGBE_RDB_FDIR_CMD_VT_POOL(v)           FIELD_PREP(GENMASK(29, 24), v)
+#define TXGBE_RDB_FDIR_HKEY                     0x19568
+#define TXGBE_RDB_FDIR_SKEY                     0x1956C
+#define TXGBE_RDB_FDIR_FLEX_CFG(_i)             (0x19580 + ((_i) * 4))
+#define TXGBE_RDB_FDIR_FLEX_CFG_FIELD0          GENMASK(7, 0)
+#define TXGBE_RDB_FDIR_FLEX_CFG_BASE_MAC        FIELD_PREP(GENMASK(1, 0), 0)
+#define TXGBE_RDB_FDIR_FLEX_CFG_MSK             BIT(2)
+#define TXGBE_RDB_FDIR_FLEX_CFG_OFST(v)         FIELD_PREP(GENMASK(7, 3), v)
+
 /* Checksum and EEPROM pointers */
 #define TXGBE_EEPROM_LAST_WORD                  0x800
 #define TXGBE_EEPROM_CHECKSUM                   0x2F
@@ -112,6 +145,91 @@
 #define TXGBE_SP_RX_PB_SIZE     512
 #define TXGBE_SP_TDB_PB_SZ      (160 * 1024) /* 160KB Packet Buffer */
 
+#define TXGBE_DEFAULT_ATR_SAMPLE_RATE           20
+
+/* Software ATR hash keys */
+#define TXGBE_ATR_BUCKET_HASH_KEY               0x3DAD14E2
+#define TXGBE_ATR_SIGNATURE_HASH_KEY            0x174D3614
+
+/* Software ATR input stream values and masks */
+#define TXGBE_ATR_HASH_MASK                     0x7fff
+#define TXGBE_ATR_L4TYPE_MASK                   0x3
+#define TXGBE_ATR_L4TYPE_UDP                    0x1
+#define TXGBE_ATR_L4TYPE_TCP                    0x2
+#define TXGBE_ATR_L4TYPE_SCTP                   0x3
+#define TXGBE_ATR_L4TYPE_IPV6_MASK              0x4
+#define TXGBE_ATR_L4TYPE_TUNNEL_MASK            0x10
+
+enum txgbe_atr_flow_type {
+	TXGBE_ATR_FLOW_TYPE_IPV4                = 0x0,
+	TXGBE_ATR_FLOW_TYPE_UDPV4               = 0x1,
+	TXGBE_ATR_FLOW_TYPE_TCPV4               = 0x2,
+	TXGBE_ATR_FLOW_TYPE_SCTPV4              = 0x3,
+	TXGBE_ATR_FLOW_TYPE_IPV6                = 0x4,
+	TXGBE_ATR_FLOW_TYPE_UDPV6               = 0x5,
+	TXGBE_ATR_FLOW_TYPE_TCPV6               = 0x6,
+	TXGBE_ATR_FLOW_TYPE_SCTPV6              = 0x7,
+	TXGBE_ATR_FLOW_TYPE_TUNNELED_IPV4       = 0x10,
+	TXGBE_ATR_FLOW_TYPE_TUNNELED_UDPV4      = 0x11,
+	TXGBE_ATR_FLOW_TYPE_TUNNELED_TCPV4      = 0x12,
+	TXGBE_ATR_FLOW_TYPE_TUNNELED_SCTPV4     = 0x13,
+	TXGBE_ATR_FLOW_TYPE_TUNNELED_IPV6       = 0x14,
+	TXGBE_ATR_FLOW_TYPE_TUNNELED_UDPV6      = 0x15,
+	TXGBE_ATR_FLOW_TYPE_TUNNELED_TCPV6      = 0x16,
+	TXGBE_ATR_FLOW_TYPE_TUNNELED_SCTPV6     = 0x17,
+};
+
+/* Flow Director ATR input struct. */
+union txgbe_atr_input {
+	/* Byte layout in order, all values with MSB first:
+	 *
+	 * vm_pool    - 1 byte
+	 * flow_type  - 1 byte
+	 * vlan_id    - 2 bytes
+	 * dst_ip     - 16 bytes
+	 * src_ip     - 16 bytes
+	 * src_port   - 2 bytes
+	 * dst_port   - 2 bytes
+	 * flex_bytes - 2 bytes
+	 * bkt_hash   - 2 bytes
+	 */
+	struct {
+		u8 vm_pool;
+		u8 flow_type;
+		__be16 vlan_id;
+		__be32 dst_ip[4];
+		__be32 src_ip[4];
+		__be16 src_port;
+		__be16 dst_port;
+		__be16 flex_bytes;
+		__be16 bkt_hash;
+	} formatted;
+	__be32 dword_stream[11];
+};
+
+/* Flow Director compressed ATR hash input struct */
+union txgbe_atr_hash_dword {
+	struct {
+		u8 vm_pool;
+		u8 flow_type;
+		__be16 vlan_id;
+	} formatted;
+	__be32 ip;
+	struct {
+		__be16 src;
+		__be16 dst;
+	} port;
+	__be16 flex_bytes;
+	__be32 dword;
+};
+
+enum txgbe_fdir_pballoc_type {
+	TXGBE_FDIR_PBALLOC_NONE = 0,
+	TXGBE_FDIR_PBALLOC_64K  = 1,
+	TXGBE_FDIR_PBALLOC_128K = 2,
+	TXGBE_FDIR_PBALLOC_256K = 3,
+};
+
 /* TX/RX descriptor defines */
 #define TXGBE_DEFAULT_TXD               512
 #define TXGBE_DEFAULT_TX_WORK           256
@@ -196,6 +314,9 @@ struct txgbe {
 	struct gpio_chip *gpio;
 	unsigned int gpio_irq;
 	unsigned int link_irq;
+
+	/* flow director */
+	union txgbe_atr_input fdir_mask;
 };
 
 #endif /* _TXGBE_TYPE_H_ */
-- 
2.27.0


