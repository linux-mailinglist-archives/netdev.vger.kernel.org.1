Return-Path: <netdev+bounces-230812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3C1BEFF46
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 10:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D504401B0A
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 08:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEA42EC080;
	Mon, 20 Oct 2025 08:27:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ED02EBDCB
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 08:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760948849; cv=none; b=gQ9BQZ915mn9fb9hq1aDDtQ7OCWDE/VBPxkWzixPLVFp+urGfuHOgAVw2awjgHsCLJle/X/KH8L0D1YUB34o0h1wHpvPWPR0/RlFP0QwoyIDCz+F3iCaBpKP4+9Ob8EU9xKy+KXrFlrSsDDUCsXVSxIIBMWwf+UK1JOZ4fHiDUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760948849; c=relaxed/simple;
	bh=5UPe9x75GnM7FU6ijjg8ExGYT8ZR2zz6JT7iK+DpHKo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GouKLKxtxdZtICy9m98ekQzITWjbA4xSVAIG6rblH/4k1kn0C46jTcW8jNF98DZ+AWTGqTJDX/6OtA2sLZ0JUBQ7GgTipHCwWItu9096D2hpBqrFzJ/rBEPjWVSkl586dhbQKXS4E1wslvx7HgxQBtBCkQ+1xasJ5NiddHNGv/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz7t1760948784t7e6fef8d
X-QQ-Originating-IP: FE3lVDANx8x2rUfWgI7tsUTHx2IfDguNY8iFuIhAxWA=
Received: from lap-jiawenwu.trustnetic.com ( [60.186.187.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 20 Oct 2025 16:26:23 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9705411741901712925
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
Subject: [PATCH net-next 3/3] net: txgbe: support RSC offload
Date: Mon, 20 Oct 2025 16:26:09 +0800
Message-Id: <20251020082609.6724-4-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20251020082609.6724-1-jiawenwu@trustnetic.com>
References: <20251020082609.6724-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NHGFjaVOIMm2Z+0bTwahR5GN1i5/S9u6WQZGjiFaOyhmKjVvYdwf1AAb
	4qCaVkmCopa9LOC9mjZ9djN64Ow3IPtRMopEeJ3QCcI6UMRSEg+eTPSkGOqIIhJiz8tVdUh
	XfpKUxP50/MosW2kasKGug6K+mDYFFXreCSR+oxKzK09gdtgUUlJHpHmKYbGPH+dFJfG5Dj
	UN2Gg6+OI7cNPIXyyQnwW8b8PyPUXgXMsagM0pgEuFEJiVcbU2SheotO3MZk7dGaa/HcbOd
	fZALDffiwDt/Q+OSnXq9TAVd41nJwjC3Zqg2KDi7xfvzknp1aG+YQYEbAw7HLkRZy2iyT8B
	UeQfSvArBURP0BC6fYmOYQrEeeDoqsUfgpXlo+BnZ+gUA15a3by6WLnvNcL2S8e0Yr1LlV1
	ny2FX43xv7ZPkILHW7y48UVAETEIiivvdAFGHXNRKZxdD81wjW1eY4Q8/6mAOnYtUBMwix6
	24jJG78BcYzG58L7mvkW5P6yUziubB1SBfHgHZaE66ssB3YmNp4PLGqd6w7xmxWHdhdNHwc
	O2OGEtxRkoSAmtuYxW1RmpkCjfLHQiYdKMZ6gvLskIAMf5E2yh2MPu+D9GZXG5K2SBoewml
	en6fsLhSoMTzg1Eyn76XQRE7EGzMurCLj4JsDAyoKHi8rcs/TPHzaeTW//Mohpfy8b11qpE
	B6RwxCeEH4vDBVFMV7tZI6uFe/XMt7tGw2EbOiYhfdDVD/Zn11LYP6YgyPaj4D0FphK3umV
	RHa+eeUpthBQBAc5Jr4xZPTRf/nQHzFfX01OPM1j5EHbetW4kSPXVssi8UnUwoEBjxMyLrx
	RL2/Hcbrd//CgUvu6aaZX9NoZhLeFuPAzfWkn9RvWgXKLy3KGpuAQc4Vj6lYW7C+dRWpbm8
	1RPSWeg3nRyPzhw9bu+3DlcirzEJUvaHh/NvdWTo/JB0Mywad95W6dmAusiPgcLBRuDzSti
	HAd2Kys7N6qzBsz3f+yucGwcUpzqmmV63OzKw/GJFth+dnEWK4VthI/OfUostsaKGw0lyLh
	bwyn16Qkh1PV/06i4VBt4cVz1CrK0wzsbNOzysiYSMH3l575uJr6ffouLv+Jg=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
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
index 5ea83aeb47e0..4c15d377aa5f 100644
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
@@ -3079,8 +3129,25 @@ int wx_set_features(struct net_device *netdev, netdev_features_t features)
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
@@ -3106,6 +3173,7 @@ int wx_set_features(struct net_device *netdev, netdev_features_t features)
 		break;
 	}
 
+out:
 	if (need_reset && wx->do_reset)
 		wx->do_reset(netdev);
 
@@ -3155,6 +3223,14 @@ netdev_features_t wx_fix_features(struct net_device *netdev,
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


