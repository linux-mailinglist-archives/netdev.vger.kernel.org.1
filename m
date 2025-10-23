Return-Path: <netdev+bounces-231955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A07BFEDE7
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 03:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2F5018C68C3
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 01:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F6B1C860B;
	Thu, 23 Oct 2025 01:47:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0FF2AD2C
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 01:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761184043; cv=none; b=XMlY7ht0ilHgve5yWe1prKYPxDyEIvQwDkEf8amj/vt/uO8A1KvJGIgN5bkxNYqK7u5ZQf09tUJmULGbd7UEQIb7bNnHLaK70Uwm/cBNuIa9IyzLJl46Qi3pZDJG/REjG07eJIlBHGrZIO2hps1CEJGDUI7r1WikdTNVY0X4my8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761184043; c=relaxed/simple;
	bh=URFbmLln9vb8agl60PRj+BMbpsMxSQKgNs4tXviu6Tk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ORmASOIwq9Qzv+t/gh2FjvdQODNJJjM4heCp6tAuFJQOBjMFVQiXGDCvSIyb4G2M61SM/0Ttz0HTH23Vg2HAR+t8vsfM3bqgKb2K2iHPG5g+1mRz1+4ehMzYs6zInG7qY9524lquKpMICJ2cXo0fTWdt5PYTtSKbHyZGd+1ZJu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz20t1761183948t12585654
X-QQ-Originating-IP: 23PThtISQe0p/AWcCak0kzkw9/J5aT9iTLu89dJYncA=
Received: from lap-jiawenwu.trustnetic.com ( [60.186.187.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 23 Oct 2025 09:45:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7482797919076256251
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
Subject: [PATCH net-next v2 2/3] net: txgbe: support TX head write-back mode
Date: Thu, 23 Oct 2025 09:45:37 +0800
Message-Id: <20251023014538.12644-3-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: NhUkPfKlCtQw4ITifdoKuX+SStdGqFxNjzeyCSW1Fvn7mSfFnH2JxXh+
	fjYWKLWvA0umbDIKctXelnGvwoQ3/989c0JSZA4lgXCUwhddaicoIEQPl+5iF3J9KlnSx8N
	/6uxd7+YWNC+sNcLK5PRX8sbKdQzRG2OxGIuQK6n1cwjZCFY+qWLiVn3Cj8kRcKB9SAje4q
	oDJockzgeF+FxyH5yoc/i9ujzfCh+fzjQuGjUVoxLeJsMBvjSH2aAPwWokJrzY5YfvU7HiJ
	Z8nP300GcX06eVkiU/K+yiB9b1IWjS39kOYs3J1PcOFOYcD+hfEeXsFiXe/6HTcJY8vjdVL
	baFnd8wV7VjeKTAun3oDHq1hzQgKHrmzEDzqwT50+XMdUBgWLGDp+92AyY3Zfsn1/PSZTaH
	LQNz/RhGfY9+wpczPqXkzG7SCecAlExGBufOrFRZoglZcbTh+QUo1BdEbGGHYie5KDwLi3/
	u7vi9GjgQwzTI0fObDuYbxQaDxMSzBd2gHUBJBFJPFwEMrt2d8urKTE+LLD93aqK2n30i1I
	dKCOha4x3L2gapqB2JNANUqjQ30IcLdSwzCnRMw1uES6/sEhxrR53QGWYApGBWsGNkzvKqC
	MElvC1b29jAL8PVj9QXIh+OMG7CQ7pmri5h9e0HmCNQsYWvVrPFNLZzrU9S3cBUtE7YOP5p
	YzFVRjxOH94fKmeuHZ8c6N5FL6JtEfk1fdYEhj80h8mQi6SZpLK/42mFABHg5bK5BEqw4I0
	S8y43bUBgAy3kUqUEOVGnYMzP11CLhCK+F/NFqGiIwikMVT1maO/Wtim8N00La5YgygjFjn
	CLW+2Rr3UbxMjWzdHYNlHGQaxC65ycc+qaCua5UOS0B0gan8Jj2NFB0XhU95w0MNJrL1Nll
	BrbcQSqdy39MMfDS0QDsGFHL8klc5GzGx/QU8XMhA45kcbwdJrtxne2gbmxXLviNaDwi06H
	6OarHskWE2vP8veu++PFk23BYD/Za5IRoiSn6mPFRXjHXYw0QV4O5pUjjwM5N7b4NZJG3cd
	zXxWiFTIp4EcB0zevtLYcZ8uDp8W5hmD3ywQxV5OJsAoUOC2qDCsTMpRg8SqI=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

TX head write-back mode is supported on AML devices. When it is enabled,
the hardware no longer writes the descriptors DD one by one, but write
back pointer of completion descriptor to the head_wb address.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  9 ++++
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 53 ++++++++++++++++++-
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  7 +++
 drivers/net/ethernet/wangxun/libwx/wx_vf.h    |  3 ++
 .../net/ethernet/wangxun/libwx/wx_vf_lib.c    |  9 ++++
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  1 +
 .../ethernet/wangxun/txgbevf/txgbevf_main.c   |  1 +
 7 files changed, 81 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 2dbbb42aa9c0..986bc5acc472 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -1905,6 +1905,15 @@ static void wx_configure_tx_ring(struct wx *wx,
 	memset(ring->tx_buffer_info, 0,
 	       sizeof(struct wx_tx_buffer) * ring->count);
 
+	if (ring->headwb_mem) {
+		wr32(wx, WX_PX_TR_HEAD_ADDRL(reg_idx),
+		     ring->headwb_dma & DMA_BIT_MASK(32));
+		wr32(wx, WX_PX_TR_HEAD_ADDRH(reg_idx),
+		     upper_32_bits(ring->headwb_dma));
+
+		txdctl |= WX_PX_TR_CFG_HEAD_WB;
+	}
+
 	/* enable queue */
 	wr32(wx, WX_PX_TR_CFG(reg_idx), txdctl);
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 3adf7048320a..622213fe6790 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -735,9 +735,22 @@ static bool wx_clean_tx_irq(struct wx_q_vector *q_vector,
 		/* prevent any other reads prior to eop_desc */
 		smp_rmb();
 
-		/* if DD is not set pending work has not been completed */
-		if (!(eop_desc->wb.status & cpu_to_le32(WX_TXD_STAT_DD)))
+		if (tx_ring->headwb_mem) {
+			u32 head = *tx_ring->headwb_mem;
+
+			if (head == tx_ring->next_to_clean)
+				break;
+			else if (head > tx_ring->next_to_clean &&
+				 !(tx_buffer->next_eop >= tx_ring->next_to_clean &&
+				   tx_buffer->next_eop < head))
+				break;
+			else if (!(tx_buffer->next_eop >= tx_ring->next_to_clean ||
+				   tx_buffer->next_eop < head))
+				break;
+		} else if (!(eop_desc->wb.status & cpu_to_le32(WX_TXD_STAT_DD))) {
+			/* if DD is not set pending work has not been completed */
 			break;
+		}
 
 		/* clear next_to_watch to prevent false hangs */
 		tx_buffer->next_to_watch = NULL;
@@ -1075,6 +1088,10 @@ static int wx_tx_map(struct wx_ring *tx_ring,
 	/* set next_to_watch value indicating a packet is present */
 	first->next_to_watch = tx_desc;
 
+	/* set next_eop for amlite tx head wb */
+	if (tx_ring->headwb_mem)
+		first->next_eop = i;
+
 	i++;
 	if (i == tx_ring->count)
 		i = 0;
@@ -2683,6 +2700,16 @@ void wx_clean_all_tx_rings(struct wx *wx)
 }
 EXPORT_SYMBOL(wx_clean_all_tx_rings);
 
+static void wx_free_headwb_resources(struct wx_ring *tx_ring)
+{
+	if (!tx_ring->headwb_mem)
+		return;
+
+	dma_free_coherent(tx_ring->dev, sizeof(u32),
+			  tx_ring->headwb_mem, tx_ring->headwb_dma);
+	tx_ring->headwb_mem = NULL;
+}
+
 /**
  * wx_free_tx_resources - Free Tx Resources per Queue
  * @tx_ring: Tx descriptor ring for a specific queue
@@ -2702,6 +2729,8 @@ static void wx_free_tx_resources(struct wx_ring *tx_ring)
 	dma_free_coherent(tx_ring->dev, tx_ring->size,
 			  tx_ring->desc, tx_ring->dma);
 	tx_ring->desc = NULL;
+
+	wx_free_headwb_resources(tx_ring);
 }
 
 /**
@@ -2840,6 +2869,24 @@ static int wx_setup_all_rx_resources(struct wx *wx)
 	return err;
 }
 
+static void wx_setup_headwb_resources(struct wx_ring *tx_ring)
+{
+	struct wx *wx = netdev_priv(tx_ring->netdev);
+
+	if (!test_bit(WX_FLAG_TXHEAD_WB_ENABLED, wx->flags))
+		return;
+
+	if (!tx_ring->q_vector)
+		return;
+
+	tx_ring->headwb_mem = dma_alloc_coherent(tx_ring->dev,
+						 sizeof(u32),
+						 &tx_ring->headwb_dma,
+						 GFP_KERNEL);
+	if (!tx_ring->headwb_mem)
+		dev_info(tx_ring->dev, "Allocate headwb memory failed, disable it\n");
+}
+
 /**
  * wx_setup_tx_resources - allocate Tx resources (Descriptors)
  * @tx_ring: tx descriptor ring (for a specific queue) to setup
@@ -2880,6 +2927,8 @@ static int wx_setup_tx_resources(struct wx_ring *tx_ring)
 	if (!tx_ring->desc)
 		goto err;
 
+	wx_setup_headwb_resources(tx_ring);
+
 	tx_ring->next_to_use = 0;
 	tx_ring->next_to_clean = 0;
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index eb3f32551c14..8b3c39945c0b 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -434,12 +434,15 @@ enum WX_MSCA_CMD_value {
 #define WX_PX_TR_WP(_i)              (0x03008 + ((_i) * 0x40))
 #define WX_PX_TR_RP(_i)              (0x0300C + ((_i) * 0x40))
 #define WX_PX_TR_CFG(_i)             (0x03010 + ((_i) * 0x40))
+#define WX_PX_TR_HEAD_ADDRL(_i)      (0x03028 + ((_i) * 0x40))
+#define WX_PX_TR_HEAD_ADDRH(_i)      (0x0302C + ((_i) * 0x40))
 /* Transmit Config masks */
 #define WX_PX_TR_CFG_ENABLE          BIT(0) /* Ena specific Tx Queue */
 #define WX_PX_TR_CFG_TR_SIZE_SHIFT   1 /* tx desc number per ring */
 #define WX_PX_TR_CFG_SWFLSH          BIT(26) /* Tx Desc. wr-bk flushing */
 #define WX_PX_TR_CFG_WTHRESH_SHIFT   16 /* shift to WTHRESH bits */
 #define WX_PX_TR_CFG_THRE_SHIFT      8
+#define WX_PX_TR_CFG_HEAD_WB         BIT(27)
 
 /* Receive DMA Registers */
 #define WX_PX_RR_BAL(_i)             (0x01000 + ((_i) * 0x40))
@@ -1011,6 +1014,7 @@ struct wx_tx_buffer {
 	DEFINE_DMA_UNMAP_LEN(len);
 	__be16 protocol;
 	u32 tx_flags;
+	u32 next_eop;
 };
 
 struct wx_rx_buffer {
@@ -1062,6 +1066,8 @@ struct wx_ring {
 	};
 	u8 __iomem *tail;
 	dma_addr_t dma;                 /* phys. address of descriptor ring */
+	dma_addr_t headwb_dma;
+	u32 *headwb_mem;
 	unsigned int size;              /* length in bytes */
 
 	u16 count;                      /* amount of descriptors */
@@ -1239,6 +1245,7 @@ enum wx_pf_flags {
 	WX_FLAG_NEED_UPDATE_LINK,
 	WX_FLAG_NEED_DO_RESET,
 	WX_FLAG_RX_MERGE_ENABLED,
+	WX_FLAG_TXHEAD_WB_ENABLED,
 	WX_PF_FLAGS_NBITS               /* must be last */
 };
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf.h b/drivers/net/ethernet/wangxun/libwx/wx_vf.h
index ecb198592393..eb6ca3fe4e97 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf.h
@@ -92,6 +92,9 @@
 #define WX_VXTXDCTL_PTHRESH(f)   FIELD_PREP(GENMASK(11, 8), f)
 #define WX_VXTXDCTL_WTHRESH(f)   FIELD_PREP(GENMASK(22, 16), f)
 #define WX_VXTXDCTL_FLUSH        BIT(26)
+#define WX_VXTXDCTL_HEAD_WB      BIT(27)
+#define WX_VXTXD_HEAD_ADDRL(r)   (0x3028 + (0x40 * (r)))
+#define WX_VXTXD_HEAD_ADDRH(r)   (0x302C + (0x40 * (r)))
 
 #define WX_PFLINK_STATUS(g)      FIELD_GET(BIT(0), g)
 #define WX_PFLINK_SPEED(g)       FIELD_GET(GENMASK(31, 1), g)
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c
index f54107f3c6d7..aa8be036956c 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c
@@ -132,6 +132,15 @@ static void wx_configure_tx_ring_vf(struct wx *wx, struct wx_ring *ring)
 	txdctl |= WX_VXTXDCTL_BUFLEN(wx_buf_len(ring->count));
 	txdctl |= WX_VXTXDCTL_ENABLE;
 
+	if (ring->headwb_mem) {
+		wr32(wx, WX_VXTXD_HEAD_ADDRL(reg_idx),
+		     ring->headwb_dma & DMA_BIT_MASK(32));
+		wr32(wx, WX_VXTXD_HEAD_ADDRH(reg_idx),
+		     upper_32_bits(ring->headwb_dma));
+
+		txdctl |= WX_VXTXDCTL_HEAD_WB;
+	}
+
 	/* reinitialize tx_buffer_info */
 	memset(ring->tx_buffer_info, 0,
 	       sizeof(struct wx_tx_buffer) * ring->count);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index 60a04c5a7678..ff690e9a075a 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -424,6 +424,7 @@ static int txgbe_sw_init(struct wx *wx)
 	case wx_mac_aml:
 	case wx_mac_aml40:
 		set_bit(WX_FLAG_RX_MERGE_ENABLED, wx->flags);
+		set_bit(WX_FLAG_TXHEAD_WB_ENABLED, wx->flags);
 		set_bit(WX_FLAG_SWFW_RING, wx->flags);
 		wx->swfw_index = 0;
 		break;
diff --git a/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c b/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
index 52c1e223bbd7..37e4ec487afd 100644
--- a/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
+++ b/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
@@ -163,6 +163,7 @@ static int txgbevf_sw_init(struct wx *wx)
 	case wx_mac_aml:
 	case wx_mac_aml40:
 		set_bit(WX_FLAG_RX_MERGE_ENABLED, wx->flags);
+		set_bit(WX_FLAG_TXHEAD_WB_ENABLED, wx->flags);
 		break;
 	default:
 		break;
-- 
2.48.1


