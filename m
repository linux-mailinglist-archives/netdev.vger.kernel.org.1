Return-Path: <netdev+bounces-208506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE213B0BE59
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 10:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0495174D13
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 08:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5CF285074;
	Mon, 21 Jul 2025 08:02:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0451C32FF
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 08:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753084971; cv=none; b=YPLzM17QWlXZ9HyjXraw5/QeArcI+Slaz+NBG8vBA4qSCneiqUhVmjaTphN/Hc4faDKbnczrM7fjcITuuiHCWBuUZcLnNbPYDb8XZTn79+2gXTt0CCFDDTnk3cwSNDZZK10NEeJo0GtNQ8GEtYTU9wfdoGTPjRLOhwA/2V5MqCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753084971; c=relaxed/simple;
	bh=RyGgJiAU/S1VILg2yqt86QryMKQ3Q0SX4Rex0ForznM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZL3+GZl13VDeTFjfg9KM9mJAsIaGW6AscQR1D80s8pktKEt/75bFZykKGu9s0jHLHw9ROb9ATQqvNhV4EaExhsgvEGPOiWF6sjSYq4VrvQdjme07aFRF55x5iAyL43ebpEWlyxkXKePmdYYe0sWxRMyPEXEflazvVexjVdXlZs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz21t1753084900t771ab309
X-QQ-Originating-IP: vilCnhM9BzA1xtoNKx6e9CbvdU6M0jwPXCCrljCJWUs=
Received: from lap-jiawenwu.trustnetic.com ( [36.24.205.22])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 21 Jul 2025 16:01:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12513487563435712954
EX-QQ-RecipientCnt: 9
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v2 3/3] net: wangxun: support to use adaptive RX coalescing
Date: Mon, 21 Jul 2025 16:01:03 +0800
Message-Id: <20250721080103.30964-4-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250721080103.30964-1-jiawenwu@trustnetic.com>
References: <20250721080103.30964-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OADxsO8kGARRm4qrb3YxQMgE7jGfccxSWW9Ce87FnWoQ7PpgFYtkQ5LM
	upLgJ0uONRIaArCBBx27KT36icmYEy06tztXGMJ3PUhry7Q0mWuYSvPkFLIm40a5rAjFXP+
	i6v9AOt3JG5jnC0j58hkwdQ1PrwX6z2mBOHXVq5bOiXz4Ao9LYwN+jAgdStOqcuNijG/KTr
	MMBKJt9Out1Rz39blLY8kfwkE1vp01TdTmgdInE3AVYJo5ghx6CODO07A3MYeXBje7L6Ddf
	No+4rk5Na1a6JsWKQByoaRdlfB4g7wHrMlX9Ir3VfvR1My+RTCUco1x7P6f0nlK2aIGaEsa
	GLtvIR5NYnYVTCCpoeEp08QJ4UOztX/BiV9cBIPDXdGs0kFyqtRVnMY7SkV0F13XG2ql8PV
	kgi2jpUmygrmbnT8xThggYARQBVWw2izVnreRYv6RWkho6HObeSeczPGXtuQs1bcOZL/XAx
	19XQxNreabddeOQqAT3uGvNEMZodQX8a3Q5Rd8/ABXdqBVpUm1bD19WJCqDPmgZCwgE4BMw
	PzLLFtQfEOfbiUFe7uyDaWtc7cFviONLzi1OT2fM7CMYH8QpWEONyLSlgh8vWobkW0Z6JgX
	e1Q7hK3rnpG5Mr01vYTZmelz5VtgyY8YfgI/kBI3hhyC4IzQ5ZkY6E7FALLmgi/5otFp0Mu
	3rZPv3+DJ32yvl5MVfePQ5aGAKRL9SZBT1OxLqqchx/cBIBHAqBvzyjyIUwUCHOqXr1vjL2
	LPMofSilIrY7JN+qGnCLMQ0NE/nDoFdtJIv7hF/VnGHrJd3pr5twNnKCM4cMXz94N1RmlKc
	jiXno9jp2nAR6inVJdxbDYrfbzmy7KzC5twX+iHKqmYiVdepFv95tuRUeRRLh5yigLoO6iJ
	PdyLDv8mk350ug99YRuYaGc6SOl1/Jrd4JKQKIwFbaHJluq9f5SV5rejl5beY86Z0M1YgLV
	B7XnVz6ZVAYkqzugDBUBeoqNeZNqulewSxhWbbKoVQ0NsZ3eCr/OduvvhIpYDh+mjX19UP7
	aZyGCfY8/Mw1xIMpUxV9/P/MgNm+naXgSOQRxGqocE/EIfFwiE9/i+gj3blLo=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

Support to turn on/off adaptive RX coalesce. When adaptive RX coalesce
is on, update the dynamic ITR value based on statistics.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   |  10 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 208 ++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |   9 +
 .../net/ethernet/wangxun/libwx/wx_vf_lib.c    |   2 +-
 .../net/ethernet/wangxun/libwx/wx_vf_lib.h    |   1 +
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |   3 +-
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |   3 +-
 7 files changed, 232 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index ebef99185bca..f2d888825659 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -303,6 +303,9 @@ int wx_get_coalesce(struct net_device *netdev,
 	else
 		ec->rx_coalesce_usecs = wx->rx_itr_setting >> 2;
 
+	if (wx->rx_itr_setting == 1)
+		ec->use_adaptive_rx_coalesce = 1;
+
 	/* if in mixed tx/rx queues per vector mode, report only rx settings */
 	if (wx->q_vector[0]->tx.count && wx->q_vector[0]->rx.count)
 		return 0;
@@ -363,10 +366,15 @@ int wx_set_coalesce(struct net_device *netdev,
 	    (ec->tx_coalesce_usecs > (max_eitr >> 2)))
 		return -EINVAL;
 
+	if (ec->use_adaptive_rx_coalesce) {
+		wx->rx_itr_setting = 1;
+		return 0;
+	}
+
 	if (ec->rx_coalesce_usecs > 1)
 		wx->rx_itr_setting = ec->rx_coalesce_usecs << 2;
 	else
-		wx->rx_itr_setting = ec->rx_coalesce_usecs;
+		wx->rx_itr_setting = rx_itr_param;
 
 	if (wx->rx_itr_setting != 1)
 		rx_itr_param = wx->rx_itr_setting;
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 723785ef87bb..ebc4281a8760 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -16,6 +16,7 @@
 #include "wx_lib.h"
 #include "wx_ptp.h"
 #include "wx_hw.h"
+#include "wx_vf_lib.h"
 
 /* Lookup table mapping the HW PTYPE to the bit field for decoding */
 static struct wx_dec_ptype wx_ptype_lookup[256] = {
@@ -832,6 +833,211 @@ static bool wx_clean_tx_irq(struct wx_q_vector *q_vector,
 	return !!budget;
 }
 
+static void wx_update_itr(struct wx_q_vector *q_vector,
+			  struct wx_ring_container *ring_container)
+{
+	unsigned int itr = WX_ITR_ADAPTIVE_MIN_USECS |
+			   WX_ITR_ADAPTIVE_LATENCY;
+	unsigned int avg_wire_size, packets, bytes;
+	unsigned long next_update = jiffies;
+
+	/* If we don't have any rings just leave ourselves set for maximum
+	 * possible latency so we take ourselves out of the equation.
+	 */
+	if (!ring_container->ring)
+		return;
+
+	/* If we didn't update within up to 1 - 2 jiffies we can assume
+	 * that either packets are coming in so slow there hasn't been
+	 * any work, or that there is so much work that NAPI is dealing
+	 * with interrupt moderation and we don't need to do anything.
+	 */
+	if (time_after(next_update, ring_container->next_update))
+		goto clear_counts;
+
+	packets = ring_container->total_packets;
+
+	/* We have no packets to actually measure against. This means
+	 * either one of the other queues on this vector is active or
+	 * we are a Tx queue doing TSO with too high of an interrupt rate.
+	 *
+	 * When this occurs just tick up our delay by the minimum value
+	 * and hope that this extra delay will prevent us from being called
+	 * without any work on our queue.
+	 */
+	if (!packets) {
+		itr = (q_vector->itr >> 2) + WX_ITR_ADAPTIVE_MIN_INC;
+		if (itr > WX_ITR_ADAPTIVE_MAX_USECS)
+			itr = WX_ITR_ADAPTIVE_MAX_USECS;
+		itr += ring_container->itr & WX_ITR_ADAPTIVE_LATENCY;
+		goto clear_counts;
+	}
+
+	bytes = ring_container->total_bytes;
+
+	/* If packets are less than 4 or bytes are less than 9000 assume
+	 * insufficient data to use bulk rate limiting approach. We are
+	 * likely latency driven.
+	 */
+	if (packets < 4 && bytes < 9000) {
+		itr = WX_ITR_ADAPTIVE_LATENCY;
+		goto adjust_by_size;
+	}
+
+	/* Between 4 and 48 we can assume that our current interrupt delay
+	 * is only slightly too low. As such we should increase it by a small
+	 * fixed amount.
+	 */
+	if (packets < 48) {
+		itr = (q_vector->itr >> 2) + WX_ITR_ADAPTIVE_MIN_INC;
+		if (itr > WX_ITR_ADAPTIVE_MAX_USECS)
+			itr = WX_ITR_ADAPTIVE_MAX_USECS;
+		goto clear_counts;
+	}
+
+	/* Between 48 and 96 is our "goldilocks" zone where we are working
+	 * out "just right". Just report that our current ITR is good for us.
+	 */
+	if (packets < 96) {
+		itr = q_vector->itr >> 2;
+		goto clear_counts;
+	}
+
+	/* If packet count is 96 or greater we are likely looking at a slight
+	 * overrun of the delay we want. Try halving our delay to see if that
+	 * will cut the number of packets in half per interrupt.
+	 */
+	if (packets < 256) {
+		itr = q_vector->itr >> 3;
+		if (itr < WX_ITR_ADAPTIVE_MIN_USECS)
+			itr = WX_ITR_ADAPTIVE_MIN_USECS;
+		goto clear_counts;
+	}
+
+	/* The paths below assume we are dealing with a bulk ITR since number
+	 * of packets is 256 or greater. We are just going to have to compute
+	 * a value and try to bring the count under control, though for smaller
+	 * packet sizes there isn't much we can do as NAPI polling will likely
+	 * be kicking in sooner rather than later.
+	 */
+	itr = WX_ITR_ADAPTIVE_BULK;
+
+adjust_by_size:
+	/* If packet counts are 256 or greater we can assume we have a gross
+	 * overestimation of what the rate should be. Instead of trying to fine
+	 * tune it just use the formula below to try and dial in an exact value
+	 * give the current packet size of the frame.
+	 */
+	avg_wire_size = bytes / packets;
+
+	/* The following is a crude approximation of:
+	 *  wmem_default / (size + overhead) = desired_pkts_per_int
+	 *  rate / bits_per_byte / (size + ethernet overhead) = pkt_rate
+	 *  (desired_pkt_rate / pkt_rate) * usecs_per_sec = ITR value
+	 *
+	 * Assuming wmem_default is 212992 and overhead is 640 bytes per
+	 * packet, (256 skb, 64 headroom, 320 shared info), we can reduce the
+	 * formula down to
+	 *
+	 *  (170 * (size + 24)) / (size + 640) = ITR
+	 *
+	 * We first do some math on the packet size and then finally bitshift
+	 * by 8 after rounding up. We also have to account for PCIe link speed
+	 * difference as ITR scales based on this.
+	 */
+	if (avg_wire_size <= 60) {
+		/* Start at 50k ints/sec */
+		avg_wire_size = 5120;
+	} else if (avg_wire_size <= 316) {
+		/* 50K ints/sec to 16K ints/sec */
+		avg_wire_size *= 40;
+		avg_wire_size += 2720;
+	} else if (avg_wire_size <= 1084) {
+		/* 16K ints/sec to 9.2K ints/sec */
+		avg_wire_size *= 15;
+		avg_wire_size += 11452;
+	} else if (avg_wire_size <= 1968) {
+		/* 9.2K ints/sec to 8K ints/sec */
+		avg_wire_size *= 5;
+		avg_wire_size += 22420;
+	} else {
+		/* plateau at a limit of 8K ints/sec */
+		avg_wire_size = 32256;
+	}
+
+	/* If we are in low latency mode half our delay which doubles the rate
+	 * to somewhere between 100K to 16K ints/sec
+	 */
+	if (itr & WX_ITR_ADAPTIVE_LATENCY)
+		avg_wire_size >>= 1;
+
+	/* Resultant value is 256 times larger than it needs to be. This
+	 * gives us room to adjust the value as needed to either increase
+	 * or decrease the value based on link speeds of 25G, 10G, 1G, etc.
+	 *
+	 * Use addition as we have already recorded the new latency flag
+	 * for the ITR value.
+	 */
+	switch (q_vector->wx->speed) {
+	case SPEED_25000:
+		itr += DIV_ROUND_UP(avg_wire_size,
+				    WX_ITR_ADAPTIVE_MIN_INC * 512) *
+		       WX_ITR_ADAPTIVE_MIN_INC;
+		break;
+	case SPEED_10000:
+	case SPEED_100:
+	default:
+		itr += DIV_ROUND_UP(avg_wire_size,
+				    WX_ITR_ADAPTIVE_MIN_INC * 256) *
+		       WX_ITR_ADAPTIVE_MIN_INC;
+		break;
+	case SPEED_1000:
+	case SPEED_10:
+		if (avg_wire_size > 8064)
+			avg_wire_size = 8064;
+		itr += DIV_ROUND_UP(avg_wire_size,
+				    WX_ITR_ADAPTIVE_MIN_INC * 64) *
+		       WX_ITR_ADAPTIVE_MIN_INC;
+		break;
+	}
+
+clear_counts:
+	/* write back value */
+	ring_container->itr = itr;
+
+	/* next update should occur within next jiffy */
+	ring_container->next_update = next_update + 1;
+
+	ring_container->total_bytes = 0;
+	ring_container->total_packets = 0;
+}
+
+static void wx_set_itr(struct wx_q_vector *q_vector)
+{
+	struct wx *wx = q_vector->wx;
+	u32 new_itr;
+
+	wx_update_itr(q_vector, &q_vector->tx);
+	wx_update_itr(q_vector, &q_vector->rx);
+
+	/* use the smallest value of new ITR delay calculations */
+	new_itr = min(q_vector->rx.itr, q_vector->tx.itr);
+
+	/* Clear latency flag if set, shift into correct position */
+	new_itr &= ~WX_ITR_ADAPTIVE_LATENCY;
+	new_itr <<= 2;
+
+	if (new_itr != q_vector->itr) {
+		/* save the algorithm value here */
+		q_vector->itr = new_itr;
+
+		if (wx->pdev->is_virtfn)
+			wx_write_eitr_vf(q_vector);
+		else
+			wx_write_eitr(q_vector);
+	}
+}
+
 /**
  * wx_poll - NAPI polling RX/TX cleanup routine
  * @napi: napi struct with our devices info in it
@@ -878,6 +1084,8 @@ static int wx_poll(struct napi_struct *napi, int budget)
 
 	/* all work done, exit the polling mode */
 	if (likely(napi_complete_done(napi, work_done))) {
+		if (wx->rx_itr_setting == 1)
+			wx_set_itr(q_vector);
 		if (netif_running(wx->netdev))
 			wx_intr_enable(wx, WX_INTR_Q(q_vector->v_idx));
 	}
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 5c52a1db4024..3530e0ef32c5 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -416,6 +416,14 @@ enum WX_MSCA_CMD_value {
 #define WX_AML_MAX_EITR              0x00000FFFU
 #define WX_EM_MAX_EITR               0x00007FFCU
 
+#define WX_ITR_ADAPTIVE_MIN_INC      2
+#define WX_ITR_ADAPTIVE_MIN_USECS    10
+#define WX_ITR_ADAPTIVE_MAX_USECS    84
+#define WX_ITR_ADAPTIVE_LATENCY      0x80
+#define WX_ITR_ADAPTIVE_BULK         0x00
+#define WX_ITR_ADAPTIVE_MASK_USECS   (WX_ITR_ADAPTIVE_LATENCY - \
+				      WX_ITR_ADAPTIVE_MIN_INC)
+
 /* transmit DMA Registers */
 #define WX_PX_TR_BAL(_i)             (0x03000 + ((_i) * 0x40))
 #define WX_PX_TR_BAH(_i)             (0x03004 + ((_i) * 0x40))
@@ -1030,6 +1038,7 @@ struct wx_rx_queue_stats {
 
 struct wx_ring_container {
 	struct wx_ring *ring;           /* pointer to linked list of rings */
+	unsigned long next_update;      /* jiffies value of last update */
 	unsigned int total_bytes;       /* total bytes processed this int */
 	unsigned int total_packets;     /* total packets processed this int */
 	u8 count;                       /* total number of rings in vector */
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c
index 5d48df7a849f..7bcf7e90883b 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c
@@ -10,7 +10,7 @@
 #include "wx_vf.h"
 #include "wx_vf_lib.h"
 
-static void wx_write_eitr_vf(struct wx_q_vector *q_vector)
+void wx_write_eitr_vf(struct wx_q_vector *q_vector)
 {
 	struct wx *wx = q_vector->wx;
 	int v_idx = q_vector->v_idx;
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.h b/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.h
index 43ea126b79eb..a4bd23c92800 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.h
@@ -4,6 +4,7 @@
 #ifndef _WX_VF_LIB_H_
 #define _WX_VF_LIB_H_
 
+void wx_write_eitr_vf(struct wx_q_vector *q_vector);
 void wx_configure_msix_vf(struct wx *wx);
 int wx_write_uc_addr_list_vf(struct net_device *netdev);
 void wx_setup_psrtype_vf(struct wx *wx);
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
index 7e2d9ec38a30..2ca127a7aa77 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
@@ -115,7 +115,8 @@ static int ngbe_set_channels(struct net_device *dev,
 
 static const struct ethtool_ops ngbe_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
-				     ETHTOOL_COALESCE_TX_MAX_FRAMES_IRQ,
+				     ETHTOOL_COALESCE_TX_MAX_FRAMES_IRQ |
+				     ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
 	.get_drvinfo		= wx_get_drvinfo,
 	.get_link		= ethtool_op_get_link,
 	.get_link_ksettings	= wx_get_link_ksettings,
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
index a4753402660e..86f3c106f1ed 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
@@ -538,7 +538,8 @@ static int txgbe_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
 
 static const struct ethtool_ops txgbe_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
-				     ETHTOOL_COALESCE_TX_MAX_FRAMES_IRQ,
+				     ETHTOOL_COALESCE_TX_MAX_FRAMES_IRQ |
+				     ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
 	.get_drvinfo		= wx_get_drvinfo,
 	.nway_reset		= wx_nway_reset,
 	.get_link		= ethtool_op_get_link,
-- 
2.48.1


