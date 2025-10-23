Return-Path: <netdev+bounces-231956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C56BFEDEA
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 03:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B71984E373F
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 01:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A38B1F4262;
	Thu, 23 Oct 2025 01:47:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069EA2AD2C
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 01:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761184049; cv=none; b=AgCR6PsKaG0jslRx/I+8TiYkAKxaNVwKJDqZc0gBTgD9wwD1wKAw7mDwEb75km6UnGtc0FKLEIYqvCMiRW6UquNUbQhyODhhVvBBRNN9EitXCQVm8JNHDVvnYQUJs9ZonJ2Gss4c9uBvtznXx3zPCGRuqx6kk2GbkicfiLnkLOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761184049; c=relaxed/simple;
	bh=+cEDt0OymgdNxLUpNMMERTkboyTg9dlfNirCalaCyvU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=plr2rnMDUwn/AgHAs/ZVK8QnZS5jHQEeTR/xstTJDDeg67YHQv7efOiTNb6qn08fzgQCYOWLJFJcm/r2na3aYMslcxUH2STRyDgZwibjBIRNeSRqxTHxsNa1S40i0VbiegFuB8SmgzDt4Ba+EKMPXonUEootQTLGHed3TcxvuP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz20t1761183951tb47f4e15
X-QQ-Originating-IP: S19M7DjnrPNMBWT/LVX0oxk+lpHGqhQOfEk3mmmgjEc=
Received: from lap-jiawenwu.trustnetic.com ( [60.186.187.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 23 Oct 2025 09:45:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12947539812976038906
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
Subject: [PATCH net-next v2 3/3] net: txgbe: support RSC offload
Date: Thu, 23 Oct 2025 09:45:38 +0800
Message-Id: <20251023014538.12644-4-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20251023014538.12644-1-jiawenwu@trustnetic.com>
References: <20251023014538.12644-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Mm/8i8/T4yneSMlVm8jVpqdolM5Aa84RvqcRddHS0yyjPPsl4Ury9pWU
	McUcANNjk51SXKOYJDQND6DygDZcnoKEDj0rUBhFh6IFzvrSvt24CUiMdDdgZ2WW6oaupga
	o/ir+619Wl4Cptwl5+h3Efp5XtkS5uBu+Vw6JiZuYjJhd3iF20G+OyzK7CTGFPWrpyc/4qk
	HcUr81B0l4hmyt1o5KzTxansJQrMcaHgDkZfUo+UgDOyA3ACsmjSEvhenF+R3/9Ac+iCGBu
	DU70os0X79XQ8ZXfRKzJeYiVH0VIqtD3sXrQJM27o0sy4+U0wIXprl3eAb+uxL+Zl2zhIFZ
	E6WGKrxokfNh13pywgg39BTIS5ASW+R6AHszv8kiTssOVR+CfBZiff6tf6suhwfNE6noiUc
	wSsUrIXT6eQyisQwWifJlVXDWNl4FjPOAw2jO63hR+ghu2iEghGHsA69rt8ogkOQqusESts
	eEHQRgUhAw25DIUL8bZn/0QFgGLX/zZc7imRt4b72+EpYNmkqBYQDkoNu8AMmspgkbioDDt
	TQX+m0dNkm/0YiwMWgGq81X0q8lFsmDCeipdH/fbNhPfbXvOKSvwKBzVik8XR0phnS9J9v4
	OQTywfWlhYwHyfyRq1EwVlNY5QHFtyet2PFZEPpeYUXkWwvGY3lGu2O+JvYqUI/76rcobbs
	wZWAzCxptKlQ83C6YrUQtSuwDMvhIijJWrCmZKcf/hJUMVgkNNqc2OhE+WCMbU1ETeo0LOA
	r+mKqN8w/R1vCUCstbar6yoYlDubE+/iU0lv0mvEs9cGz3m5MgzYJ3jveLBpfzvmOtQOCaC
	UTLt3mpjLYBJcNPFcLPHq8Ig6IHx3ima2N+3ZM3vVIWfdMpkcbBFcmr6ZihxJ9HPWPRhplu
	PWJ0MbbPOl0tBNRppVcX4vgLNn8d+JSLogch0tZKmVwiHdVtZZYfsieghtRSoR5aTb+bj2J
	R9GXJhTPJWdpSpqvMvFiMdSC6f0VNf0X7ec6786fjKN4dHmAn3ll6WqJRzAINznhO39Jok3
	bR20oX9809sSSXF3nePZmkVxkNh5Bb9DbJPIMkWA3QSlezaXi6EU9t0Ae35NMy91F9Xv3N5
	A==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

Support to enable and disable RSC for txgbe devices.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 61 ++++++++++++-
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    | 50 ++++++++++-
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 90 +++++++++++++++++--
 drivers/net/ethernet/wangxun/libwx/wx_sriov.c |  4 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  | 33 +++++--
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  3 +
 6 files changed, 224 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index 06f401bd975c..9aa3964187e1 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -51,6 +51,11 @@ static const struct wx_stats wx_gstrings_fdir_stats[] = {
 	WX_STAT("fdir_miss", stats.fdirmiss),
 };
 
+static const struct wx_stats wx_gstrings_rsc_stats[] = {
+	WX_STAT("rsc_aggregated", rsc_count),
+	WX_STAT("rsc_flushed", rsc_flush),
+};
+
 /* drivers allocates num_tx_queues and num_rx_queues symmetrically so
  * we set the num_rx_queues to evaluate to num_tx_queues. This is
  * used because we do not have a good way to get the max number of
@@ -64,16 +69,21 @@ static const struct wx_stats wx_gstrings_fdir_stats[] = {
 		(sizeof(struct wx_queue_stats) / sizeof(u64)))
 #define WX_GLOBAL_STATS_LEN  ARRAY_SIZE(wx_gstrings_stats)
 #define WX_FDIR_STATS_LEN  ARRAY_SIZE(wx_gstrings_fdir_stats)
+#define WX_RSC_STATS_LEN  ARRAY_SIZE(wx_gstrings_rsc_stats)
 #define WX_STATS_LEN (WX_GLOBAL_STATS_LEN + WX_QUEUE_STATS_LEN)
 
 int wx_get_sset_count(struct net_device *netdev, int sset)
 {
 	struct wx *wx = netdev_priv(netdev);
+	int len = WX_STATS_LEN;
 
 	switch (sset) {
 	case ETH_SS_STATS:
-		return (test_bit(WX_FLAG_FDIR_CAPABLE, wx->flags)) ?
-			WX_STATS_LEN + WX_FDIR_STATS_LEN : WX_STATS_LEN;
+		if (test_bit(WX_FLAG_FDIR_CAPABLE, wx->flags))
+			len += WX_FDIR_STATS_LEN;
+		if (test_bit(WX_FLAG_RSC_CAPABLE, wx->flags))
+			len += WX_RSC_STATS_LEN;
+		return len;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -94,6 +104,10 @@ void wx_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 			for (i = 0; i < WX_FDIR_STATS_LEN; i++)
 				ethtool_puts(&p, wx_gstrings_fdir_stats[i].stat_string);
 		}
+		if (test_bit(WX_FLAG_RSC_CAPABLE, wx->flags)) {
+			for (i = 0; i < WX_RSC_STATS_LEN; i++)
+				ethtool_puts(&p, wx_gstrings_rsc_stats[i].stat_string);
+		}
 		for (i = 0; i < netdev->num_tx_queues; i++) {
 			ethtool_sprintf(&p, "tx_queue_%u_packets", i);
 			ethtool_sprintf(&p, "tx_queue_%u_bytes", i);
@@ -131,6 +145,13 @@ void wx_get_ethtool_stats(struct net_device *netdev,
 		}
 	}
 
+	if (test_bit(WX_FLAG_RSC_CAPABLE, wx->flags)) {
+		for (k = 0; k < WX_RSC_STATS_LEN; k++) {
+			p = (char *)wx + wx_gstrings_rsc_stats[k].stat_offset;
+			data[i++] = *(u64 *)p;
+		}
+	}
+
 	for (j = 0; j < netdev->num_tx_queues; j++) {
 		ring = wx->tx_ring[j];
 		if (!ring) {
@@ -322,6 +343,40 @@ int wx_get_coalesce(struct net_device *netdev,
 }
 EXPORT_SYMBOL(wx_get_coalesce);
 
+static void wx_update_rsc(struct wx *wx)
+{
+	struct net_device *netdev = wx->netdev;
+	bool need_reset = false;
+
+	/* nothing to do if LRO or RSC are not enabled */
+	if (!test_bit(WX_FLAG_RSC_CAPABLE, wx->flags) ||
+	    !(netdev->features & NETIF_F_LRO))
+		return;
+
+	/* check the feature flag value and enable RSC if necessary */
+	if (wx->rx_itr_setting == 1 ||
+	    wx->rx_itr_setting > WX_MIN_RSC_ITR) {
+		if (!test_bit(WX_FLAG_RSC_ENABLED, wx->flags)) {
+			set_bit(WX_FLAG_RSC_ENABLED, wx->flags);
+			dev_info(&wx->pdev->dev,
+				 "rx-usecs value high enough to re-enable RSC\n");
+
+			need_reset = true;
+		}
+	/* if interrupt rate is too high then disable RSC */
+	} else if (test_bit(WX_FLAG_RSC_ENABLED, wx->flags)) {
+		clear_bit(WX_FLAG_RSC_ENABLED, wx->flags);
+		dev_info(&wx->pdev->dev,
+			 "rx-usecs set too low, disabling RSC\n");
+
+		need_reset = true;
+	}
+
+	/* reset the device to apply the new RSC setting */
+	if (need_reset && wx->do_reset)
+		wx->do_reset(netdev);
+}
+
 int wx_set_coalesce(struct net_device *netdev,
 		    struct ethtool_coalesce *ec,
 		    struct kernel_ethtool_coalesce *kernel_coal,
@@ -414,6 +469,8 @@ int wx_set_coalesce(struct net_device *netdev,
 		wx_write_eitr(q_vector);
 	}
 
+	wx_update_rsc(wx);
+
 	return 0;
 }
 EXPORT_SYMBOL(wx_set_coalesce);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 986bc5acc472..814164459707 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -1779,7 +1779,9 @@ EXPORT_SYMBOL(wx_set_rx_mode);
 static void wx_set_rx_buffer_len(struct wx *wx)
 {
 	struct net_device *netdev = wx->netdev;
+	struct wx_ring *rx_ring;
 	u32 mhadd, max_frame;
+	int i;
 
 	max_frame = netdev->mtu + ETH_HLEN + ETH_FCS_LEN + VLAN_HLEN;
 	/* adjust max frame to be at least the size of a standard frame */
@@ -1789,6 +1791,19 @@ static void wx_set_rx_buffer_len(struct wx *wx)
 	mhadd = rd32(wx, WX_PSR_MAX_SZ);
 	if (max_frame != mhadd)
 		wr32(wx, WX_PSR_MAX_SZ, max_frame);
+
+	/*
+	 * Setup the HW Rx Head and Tail Descriptor Pointers and
+	 * the Base and Length of the Rx Descriptor Ring
+	 */
+	for (i = 0; i < wx->num_rx_queues; i++) {
+		rx_ring = wx->rx_ring[i];
+		rx_ring->rx_buf_len = WX_RXBUFFER_2K;
+#if (PAGE_SIZE < 8192)
+		if (test_bit(WX_FLAG_RSC_ENABLED, wx->flags))
+			rx_ring->rx_buf_len = WX_RXBUFFER_3K;
+#endif
+	}
 }
 
 /**
@@ -1865,11 +1880,27 @@ static void wx_configure_srrctl(struct wx *wx,
 	srrctl |= WX_RXBUFFER_256 << WX_PX_RR_CFG_BHDRSIZE_SHIFT;
 
 	/* configure the packet buffer length */
-	srrctl |= WX_RX_BUFSZ >> WX_PX_RR_CFG_BSIZEPKT_SHIFT;
+	srrctl |= rx_ring->rx_buf_len >> WX_PX_RR_CFG_BSIZEPKT_SHIFT;
 
 	wr32(wx, WX_PX_RR_CFG(reg_idx), srrctl);
 }
 
+static void wx_configure_rscctl(struct wx *wx,
+				struct wx_ring *ring)
+{
+	u8 reg_idx = ring->reg_idx;
+	u32 rscctrl;
+
+	if (!test_bit(WX_FLAG_RSC_ENABLED, wx->flags))
+		return;
+
+	rscctrl = rd32(wx, WX_PX_RR_CFG(reg_idx));
+	rscctrl |= WX_PX_RR_CFG_RSC;
+	rscctrl |= WX_PX_RR_CFG_MAX_RSCBUF_16;
+
+	wr32(wx, WX_PX_RR_CFG(reg_idx), rscctrl);
+}
+
 static void wx_configure_tx_ring(struct wx *wx,
 				 struct wx_ring *ring)
 {
@@ -1956,6 +1987,7 @@ static void wx_configure_rx_ring(struct wx *wx,
 	ring->tail = wx->hw_addr + WX_PX_RR_WP(reg_idx);
 
 	wx_configure_srrctl(wx, ring);
+	wx_configure_rscctl(wx, ring);
 
 	/* initialize rx_buffer_info */
 	memset(ring->rx_buffer_info, 0,
@@ -2194,7 +2226,9 @@ void wx_configure_rx(struct wx *wx)
 		/* RSC Setup */
 		psrctl = rd32(wx, WX_PSR_CTL);
 		psrctl |= WX_PSR_CTL_RSC_ACK; /* Disable RSC for ACK packets */
-		psrctl |= WX_PSR_CTL_RSC_DIS;
+		psrctl &= ~WX_PSR_CTL_RSC_DIS;
+		if (!test_bit(WX_FLAG_RSC_ENABLED, wx->flags))
+			psrctl |= WX_PSR_CTL_RSC_DIS;
 		wr32(wx, WX_PSR_CTL, psrctl);
 	}
 
@@ -2824,6 +2858,18 @@ void wx_update_stats(struct wx *wx)
 	wx->hw_csum_rx_error = hw_csum_rx_error;
 	wx->hw_csum_rx_good = hw_csum_rx_good;
 
+	if (test_bit(WX_FLAG_RSC_ENABLED, wx->flags)) {
+		u64 rsc_count = 0;
+		u64 rsc_flush = 0;
+
+		for (i = 0; i < wx->num_rx_queues; i++) {
+			rsc_count += wx->rx_ring[i]->rx_stats.rsc_count;
+			rsc_flush += wx->rx_ring[i]->rx_stats.rsc_flush;
+		}
+		wx->rsc_count = rsc_count;
+		wx->rsc_flush = rsc_flush;
+	}
+
 	for (i = 0; i < wx->num_tx_queues; i++) {
 		struct wx_ring *tx_ring = wx->tx_ring[i];
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 622213fe6790..32cadafa4b3b 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -235,7 +235,7 @@ static struct sk_buff *wx_build_skb(struct wx_ring *rx_ring,
 {
 	unsigned int size = le16_to_cpu(rx_desc->wb.upper.length);
 #if (PAGE_SIZE < 8192)
-	unsigned int truesize = WX_RX_BUFSZ;
+	unsigned int truesize = wx_rx_pg_size(rx_ring) / 2;
 #else
 	unsigned int truesize = ALIGN(size, L1_CACHE_BYTES);
 #endif
@@ -341,7 +341,7 @@ void wx_alloc_rx_buffers(struct wx_ring *rx_ring, u16 cleaned_count)
 		/* sync the buffer for use by the device */
 		dma_sync_single_range_for_device(rx_ring->dev, bi->dma,
 						 bi->page_offset,
-						 WX_RX_BUFSZ,
+						 rx_ring->rx_buf_len,
 						 DMA_FROM_DEVICE);
 
 		rx_desc->read.pkt_addr =
@@ -404,6 +404,7 @@ static bool wx_is_non_eop(struct wx_ring *rx_ring,
 			  union wx_rx_desc *rx_desc,
 			  struct sk_buff *skb)
 {
+	struct wx *wx = rx_ring->q_vector->wx;
 	u32 ntc = rx_ring->next_to_clean + 1;
 
 	/* fetch, update, and store next to clean */
@@ -412,6 +413,24 @@ static bool wx_is_non_eop(struct wx_ring *rx_ring,
 
 	prefetch(WX_RX_DESC(rx_ring, ntc));
 
+	/* update RSC append count if present */
+	if (test_bit(WX_FLAG_RSC_ENABLED, wx->flags)) {
+		__le32 rsc_enabled = rx_desc->wb.lower.lo_dword.data &
+				     cpu_to_le32(WX_RXD_RSCCNT_MASK);
+
+		if (unlikely(rsc_enabled)) {
+			u32 rsc_cnt = le32_to_cpu(rsc_enabled);
+
+			rsc_cnt >>= WX_RXD_RSCCNT_SHIFT;
+			WX_CB(skb)->append_cnt += rsc_cnt - 1;
+
+			/* update ntc based on RSC value */
+			ntc = le32_to_cpu(rx_desc->wb.upper.status_error);
+			ntc &= WX_RXD_NEXTP_MASK;
+			ntc >>= WX_RXD_NEXTP_SHIFT;
+		}
+	}
+
 	/* if we are the last buffer then there is nothing else to do */
 	if (likely(wx_test_staterr(rx_desc, WX_RXD_STAT_EOP)))
 		return false;
@@ -582,6 +601,33 @@ static void wx_rx_vlan(struct wx_ring *ring, union wx_rx_desc *rx_desc,
 	}
 }
 
+static void wx_set_rsc_gso_size(struct wx_ring *ring,
+				struct sk_buff *skb)
+{
+	u16 hdr_len = skb_headlen(skb);
+
+	/* set gso_size to avoid messing up TCP MSS */
+	skb_shinfo(skb)->gso_size = DIV_ROUND_UP((skb->len - hdr_len),
+						 WX_CB(skb)->append_cnt);
+	skb_shinfo(skb)->gso_type = SKB_GSO_TCPV4;
+}
+
+static void wx_update_rsc_stats(struct wx_ring *rx_ring,
+				struct sk_buff *skb)
+{
+	/* if append_cnt is 0 then frame is not RSC */
+	if (!WX_CB(skb)->append_cnt)
+		return;
+
+	rx_ring->rx_stats.rsc_count += WX_CB(skb)->append_cnt;
+	rx_ring->rx_stats.rsc_flush++;
+
+	wx_set_rsc_gso_size(rx_ring, skb);
+
+	/* gso_size is computed using append_cnt so always clear it last */
+	WX_CB(skb)->append_cnt = 0;
+}
+
 /**
  * wx_process_skb_fields - Populate skb header fields from Rx descriptor
  * @rx_ring: rx descriptor ring packet is being transacted on
@@ -598,6 +644,9 @@ static void wx_process_skb_fields(struct wx_ring *rx_ring,
 {
 	struct wx *wx = netdev_priv(rx_ring->netdev);
 
+	if (test_bit(WX_FLAG_RSC_CAPABLE, wx->flags))
+		wx_update_rsc_stats(rx_ring, skb);
+
 	wx_rx_hash(rx_ring, rx_desc, skb);
 	wx_rx_checksum(rx_ring, rx_desc, skb);
 
@@ -2549,7 +2598,7 @@ static void wx_clean_rx_ring(struct wx_ring *rx_ring)
 		dma_sync_single_range_for_cpu(rx_ring->dev,
 					      rx_buffer->dma,
 					      rx_buffer->page_offset,
-					      WX_RX_BUFSZ,
+					      rx_ring->rx_buf_len,
 					      DMA_FROM_DEVICE);
 
 		/* free resources associated with mapping */
@@ -2760,13 +2809,14 @@ static int wx_alloc_page_pool(struct wx_ring *rx_ring)
 
 	struct page_pool_params pp_params = {
 		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
-		.order = 0,
-		.pool_size = rx_ring->count,
+		.order = wx_rx_pg_order(rx_ring),
+		.pool_size = rx_ring->count * rx_ring->rx_buf_len /
+			     wx_rx_pg_size(rx_ring),
 		.nid = dev_to_node(rx_ring->dev),
 		.dev = rx_ring->dev,
 		.dma_dir = DMA_FROM_DEVICE,
 		.offset = 0,
-		.max_len = PAGE_SIZE,
+		.max_len = wx_rx_pg_size(rx_ring),
 	};
 
 	rx_ring->page_pool = page_pool_create(&pp_params);
@@ -3075,8 +3125,25 @@ int wx_set_features(struct net_device *netdev, netdev_features_t features)
 	else if (changed & (NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_CTAG_FILTER))
 		wx_set_rx_mode(netdev);
 
+	if (test_bit(WX_FLAG_RSC_CAPABLE, wx->flags)) {
+		if (!(features & NETIF_F_LRO)) {
+			if (test_bit(WX_FLAG_RSC_ENABLED, wx->flags))
+				need_reset = true;
+			clear_bit(WX_FLAG_RSC_ENABLED, wx->flags);
+		} else if (!(test_bit(WX_FLAG_RSC_ENABLED, wx->flags))) {
+			if (wx->rx_itr_setting == 1 ||
+			    wx->rx_itr_setting > WX_MIN_RSC_ITR) {
+				set_bit(WX_FLAG_RSC_ENABLED, wx->flags);
+				need_reset = true;
+			} else if (changed & NETIF_F_LRO) {
+				dev_info(&wx->pdev->dev,
+					 "rx-usecs set too low, disable RSC\n");
+			}
+		}
+	}
+
 	if (!(test_bit(WX_FLAG_FDIR_CAPABLE, wx->flags)))
-		return 0;
+		goto out;
 
 	/* Check if Flow Director n-tuple support was enabled or disabled.  If
 	 * the state changed, we need to reset.
@@ -3102,6 +3169,7 @@ int wx_set_features(struct net_device *netdev, netdev_features_t features)
 		break;
 	}
 
+out:
 	if (need_reset && wx->do_reset)
 		wx->do_reset(netdev);
 
@@ -3151,6 +3219,14 @@ netdev_features_t wx_fix_features(struct net_device *netdev,
 		}
 	}
 
+	/* If Rx checksum is disabled, then RSC/LRO should also be disabled */
+	if (!(features & NETIF_F_RXCSUM))
+		features &= ~NETIF_F_LRO;
+
+	/* Turn off LRO if not RSC capable */
+	if (!test_bit(WX_FLAG_RSC_CAPABLE, wx->flags))
+		features &= ~NETIF_F_LRO;
+
 	return features;
 }
 EXPORT_SYMBOL(wx_fix_features);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
index c6d158cd70da..493da5fffdb6 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
@@ -122,6 +122,10 @@ static int __wx_enable_sriov(struct wx *wx, u8 num_vfs)
 	      WX_CFG_PORT_CTL_NUM_VT_MASK,
 	      value);
 
+	/* Disable RSC when in SR-IOV mode */
+	clear_bit(WX_FLAG_RSC_CAPABLE, wx->flags);
+	clear_bit(WX_FLAG_RSC_ENABLED, wx->flags);
+
 	return ret;
 }
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 8b3c39945c0b..d0cbcded1dd4 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -424,6 +424,7 @@ enum WX_MSCA_CMD_value {
 #define WX_7K_ITR                    595
 #define WX_12K_ITR                   336
 #define WX_20K_ITR                   200
+#define WX_MIN_RSC_ITR               24
 #define WX_SP_MAX_EITR               0x00000FF8U
 #define WX_AML_MAX_EITR              0x00000FFFU
 #define WX_EM_MAX_EITR               0x00007FFCU
@@ -454,7 +455,9 @@ enum WX_MSCA_CMD_value {
 /* PX_RR_CFG bit definitions */
 #define WX_PX_RR_CFG_VLAN            BIT(31)
 #define WX_PX_RR_CFG_DROP_EN         BIT(30)
+#define WX_PX_RR_CFG_RSC             BIT(29)
 #define WX_PX_RR_CFG_SPLIT_MODE      BIT(26)
+#define WX_PX_RR_CFG_MAX_RSCBUF_16   FIELD_PREP(GENMASK(24, 23), 3)
 #define WX_PX_RR_CFG_DESC_MERGE      BIT(19)
 #define WX_PX_RR_CFG_RR_THER_SHIFT   16
 #define WX_PX_RR_CFG_RR_HDR_SZ       GENMASK(15, 12)
@@ -551,14 +554,9 @@ enum WX_MSCA_CMD_value {
 /* Supported Rx Buffer Sizes */
 #define WX_RXBUFFER_256      256    /* Used for skb receive header */
 #define WX_RXBUFFER_2K       2048
+#define WX_RXBUFFER_3K       3072
 #define WX_MAX_RXBUFFER      16384  /* largest size for single descriptor */
 
-#if MAX_SKB_FRAGS < 8
-#define WX_RX_BUFSZ      ALIGN(WX_MAX_RXBUFFER / MAX_SKB_FRAGS, 1024)
-#else
-#define WX_RX_BUFSZ      WX_RXBUFFER_2K
-#endif
-
 #define WX_RX_BUFFER_WRITE   16      /* Must be power of 2 */
 
 #define WX_MAX_DATA_PER_TXD  BIT(14)
@@ -652,6 +650,12 @@ enum wx_l2_ptypes {
 
 #define WX_RXD_PKTTYPE(_rxd) \
 	((le32_to_cpu((_rxd)->wb.lower.lo_dword.data) >> 9) & 0xFF)
+
+#define WX_RXD_RSCCNT_MASK           GENMASK(20, 17)
+#define WX_RXD_RSCCNT_SHIFT          17
+#define WX_RXD_NEXTP_MASK            GENMASK(19, 4)
+#define WX_RXD_NEXTP_SHIFT           4
+
 /*********************** Transmit Descriptor Config Masks ****************/
 #define WX_TXD_STAT_DD               BIT(0)  /* Descriptor Done */
 #define WX_TXD_DTYP_DATA             0       /* Adv Data Descriptor */
@@ -1039,6 +1043,8 @@ struct wx_rx_queue_stats {
 	u64 csum_good_cnt;
 	u64 csum_err;
 	u64 alloc_rx_buff_failed;
+	u64 rsc_count;
+	u64 rsc_flush;
 };
 
 /* iterator for handling rings in ring container */
@@ -1081,6 +1087,7 @@ struct wx_ring {
 					 */
 	u16 next_to_use;
 	u16 next_to_clean;
+	u16 rx_buf_len;
 	union {
 		u16 next_to_alloc;
 		struct {
@@ -1237,6 +1244,7 @@ enum wx_pf_flags {
 	WX_FLAG_FDIR_HASH,
 	WX_FLAG_FDIR_PERFECT,
 	WX_FLAG_RSC_CAPABLE,
+	WX_FLAG_RSC_ENABLED,
 	WX_FLAG_RX_HWTSTAMP_ENABLED,
 	WX_FLAG_RX_HWTSTAMP_IN_REGISTER,
 	WX_FLAG_PTP_PPS_ENABLED,
@@ -1352,6 +1360,8 @@ struct wx {
 	u64 hw_csum_rx_good;
 	u64 hw_csum_rx_error;
 	u64 alloc_rx_buff_failed;
+	u64 rsc_count;
+	u64 rsc_flush;
 	unsigned int num_vfs;
 	struct vf_data_storage *vfinfo;
 	struct vf_macvlans vf_mvs;
@@ -1483,4 +1493,15 @@ static inline int wx_set_state_reset(struct wx *wx)
 	return 0;
 }
 
+static inline unsigned int wx_rx_pg_order(struct wx_ring *ring)
+{
+#if (PAGE_SIZE < 8192)
+	if (ring->rx_buf_len == WX_RXBUFFER_3K)
+		return 1;
+#endif
+	return 0;
+}
+
+#define wx_rx_pg_size(_ring) (PAGE_SIZE << wx_rx_pg_order(_ring))
+
 #endif /* _WX_TYPE_H_ */
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index ff690e9a075a..daa761e48f9d 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -398,6 +398,7 @@ static int txgbe_sw_init(struct wx *wx)
 	wx->configure_fdir = txgbe_configure_fdir;
 
 	set_bit(WX_FLAG_RSC_CAPABLE, wx->flags);
+	set_bit(WX_FLAG_RSC_ENABLED, wx->flags);
 	set_bit(WX_FLAG_MULTI_64_FUNC, wx->flags);
 
 	/* enable itr by default in dynamic mode */
@@ -803,6 +804,8 @@ static int txgbe_probe(struct pci_dev *pdev,
 	netdev->features |= NETIF_F_HIGHDMA;
 	netdev->hw_features |= NETIF_F_GRO;
 	netdev->features |= NETIF_F_GRO;
+	netdev->hw_features |= NETIF_F_LRO;
+	netdev->features |= NETIF_F_LRO;
 	netdev->features |= NETIF_F_RX_UDP_TUNNEL_PORT;
 
 	netdev->priv_flags |= IFF_UNICAST_FLT;
-- 
2.48.1


