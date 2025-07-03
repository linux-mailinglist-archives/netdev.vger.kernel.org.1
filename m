Return-Path: <netdev+bounces-203585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 607A9AF6786
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 03:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE6BB1C46714
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 01:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45FD24679B;
	Thu,  3 Jul 2025 01:52:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AAA246BC1;
	Thu,  3 Jul 2025 01:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751507526; cv=none; b=iMLe5oademVraVGEcXaREDPiZGZWzkYnQSXknRk+UD9MY3P9KC96ro7EQlfsnCunGqY8n9rxhx2/VFSg5qTJNbOkgBg4uUe2rJDyjeRdAYgxUH99enEnBCWpQ3wkWtGvYMIaisTyuGhvJx37VP142VuK8qHUBjmH3AiV+6VpGrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751507526; c=relaxed/simple;
	bh=Mm7IZiFNMnbxKSXQgtSuhJG0N/BFhn7Go1NY+dUy9fM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AJ81yJQCvijFf50uK7OLyLjZe0Smv0713PcGdbdhEzd+6tliyWKbcLUiato0aQYBMBgrhNUUOjnUwu9s63b/WgdSe0vQXMUcX1+5diFuXrxZTSbWXwNSD6M6NnPPFpmWb6UCCURZnvc60j3TmJZ0YArSN4R7Xv8QsmxfesIVbdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz8t1751507413tdf0abb81
X-QQ-Originating-IP: +QrC9xChzcH6HQz/g7luc9deusWmGb+bP+AHfYQz9fI=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 03 Jul 2025 09:50:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11652823405052598181
EX-QQ-RecipientCnt: 22
From: Dong Yibo <dong100@mucse.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	andrew+netdev@lunn.ch,
	gur.stavi@huawei.com,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	danishanwar@ti.com,
	lee@trager.us,
	gongfan1@huawei.com,
	lorenzo@kernel.org,
	geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com,
	lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dong100@mucse.com
Subject: [PATCH 15/15] net: rnpgbe: Add ITR for rx
Date: Thu,  3 Jul 2025 09:48:59 +0800
Message-Id: <20250703014859.210110-16-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250703014859.210110-1-dong100@mucse.com>
References: <20250703014859.210110-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Mwdq8jAc4iJQ29n369uInzBmbrxH3n79YHKv6bFVykyD3qhJv2ffwALa
	yxI57zkMoujfqd6hP99eH2JremvaELM8TAKEj93PqCUHF7SFtG4IChGsLzeFj+3Aa8b8Asl
	1rhSBawUhEDE+HINYT9vaE6Nm2UbZZKNj+NsQmguMDsq+/qJRIs/PHOhMFbEG1SsqujZ9Ao
	XxDbfnL0Ba0h5Y7IE1QqxdfW2jrsYcwjwJZ9uHj6gnPDpE2oigbl0NQTi6kU30BXyrjlW6u
	chyt9nfVZ9d44rSYW9KCCRRBXxckUSIhPq+cAWupd/6uTrVaPxp0WQpDLpUd9M3c+rVG0sM
	PVkFh80bH9ByPr+9Y4kVOehxNkdZJVMTPWVIiaZQeQmJM113fRuKUZst3qTxyYYR4lkhSCp
	BumBSW2kQwIfyTfy064bZrzNqD2XEuZW8b2qEQU1eGX2dejHah5tsodIvIT4erNEEctuwWF
	13xs6Jm0REhTLooTu1M4JpwUcyNdtuTbMPQ9UEMdMJTx1KcSdcVdDfpgtCRCBAI+J/65AJj
	X4LJKm9JN59TKZMv9rcl+8OpIAd/hLdJUxEb9ImbKiW18k+qNVCLeo8MYqBf5D1rO4P3IR1
	JTx01o6KvLODyUiIHZ00QLMUv4vLUwh50KCeyjLihMv2ogbk29Tjjfz4Rnty1lWrwoW2pzW
	dQtNy10SpDiqpmTPl9zvq40fJ3crOgASfASERvSVbAjTtx5kUg8xi4pAv5wXGs41PmZQULO
	AWdYpNH8QwncM3QUTvPA0YgHy+8cQbrX5+68COkEOyV67w5sutxSnxKTzPGfL3eJU1hTAQc
	nbIlsfKX3gMvwWgTa1GLL0zNc4PYCBlekz02ryzbYHCrVD5cH4soQL07hHxvP5mpBskblbY
	VhIPEFKw9JXVpTCHde1O/fkMtjvcMQk8XrDiD4mBGec+vCc/7xhBykoTDLNzJFN61+yt1pt
	TbLFhKJlSmuDGn29UEBmpNe4P13CKsni7hzea8ZxZynTjhdp26nIrDs93zl6enshDsxwUxA
	Zd5Xwzff0uUh309dZBOAkr5abfIsC/1HxgfFwvbyqnn9kdIG9z
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

Initialize itr function according to rx packets/bytes

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  5 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.c    | 91 ++++++++++++++++++-
 2 files changed, 95 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index 0b6ba4c3a6cb..8e692da05eb7 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -551,6 +551,8 @@ struct mucse_ring_container {
 	unsigned int total_packets;
 	u16 work_limit;
 	u16 count;
+	u16 itr;
+	int update_count;
 };
 
 struct mucse_q_vector {
@@ -705,6 +707,9 @@ static inline __le16 rnpgbe_test_staterr(union rnpgbe_rx_desc *rx_desc,
 
 #define M_TRY_LINK_TIMEOUT (4 * HZ)
 
+#define M_LOWEREST_ITR (5)
+#define M_4K_ITR (980)
+
 #define M_RX_BUFFER_WRITE (16)
 #define m_rd_reg(reg) readl((void *)(reg))
 #define m_wr_reg(reg, val) writel((val), (void *)(reg))
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
index 05073663ad0e..5d82f063eade 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
@@ -681,6 +681,62 @@ static int rnpgbe_clean_rx_irq(struct mucse_q_vector *q_vector,
 	return fail_alloc ? budget : total_rx_packets;
 }
 
+static void rnpgbe_update_ring_itr_rx(struct mucse_q_vector *q_vector)
+{
+	int new_val = q_vector->itr_rx;
+	int avg_wire_size = 0;
+	struct mucse *mucse = q_vector->mucse;
+	unsigned int packets;
+
+	switch (mucse->link_speed) {
+	case M_LINK_SPEED_10_FULL:
+	case M_LINK_SPEED_100_FULL:
+		new_val = M_4K_ITR;
+		goto set_itr_val;
+	default:
+		break;
+	}
+
+	packets = q_vector->rx.total_packets;
+	if (packets)
+		avg_wire_size = max_t(u32, avg_wire_size,
+				      q_vector->rx.total_bytes / packets);
+
+	/* if avg_wire_size isn't set no work was done */
+	if (!avg_wire_size)
+		goto clear_counts;
+
+	/* Add 24 bytes to size to account for CRC, preamble, and gap */
+	avg_wire_size += 24;
+
+	/* Don't starve jumbo frames */
+	avg_wire_size = min(avg_wire_size, 3000);
+
+	/* Give a little boost to mid-size frames */
+	if (avg_wire_size > 300 && avg_wire_size < 1200)
+		new_val = avg_wire_size / 3;
+	else
+		new_val = avg_wire_size / 2;
+
+	if (new_val < M_LOWEREST_ITR)
+		new_val = M_LOWEREST_ITR;
+
+set_itr_val:
+	if (q_vector->rx.itr != new_val) {
+		q_vector->rx.update_count++;
+		if (q_vector->rx.update_count >= 2) {
+			q_vector->rx.itr = new_val;
+			q_vector->rx.update_count = 0;
+		}
+	} else {
+		q_vector->rx.update_count = 0;
+	}
+
+clear_counts:
+	q_vector->rx.total_bytes = 0;
+	q_vector->rx.total_packets = 0;
+}
+
 /**
  * rnpgbe_poll - NAPI Rx polling callback
  * @napi: structure for representing this polling device
@@ -725,6 +781,7 @@ static int rnpgbe_poll(struct napi_struct *napi, int budget)
 		return budget;
 	/* all work done, exit the polling mode */
 	if (likely(napi_complete_done(napi, work_done))) {
+		rnpgbe_update_ring_itr_rx(q_vector);
 		if (!test_bit(__MUCSE_DOWN, &mucse->state))
 			rnpgbe_irq_enable_queues(mucse, q_vector);
 	}
@@ -1677,12 +1734,44 @@ void rnpgbe_clean_all_tx_rings(struct mucse *mucse)
 		rnpgbe_clean_tx_ring(mucse->tx_ring[i]);
 }
 
+static void rnpgbe_write_eitr_rx(struct mucse_q_vector *q_vector)
+{
+	struct mucse *mucse = q_vector->mucse;
+	struct mucse_hw *hw = &mucse->hw;
+	u32 new_itr_rx = q_vector->rx.itr;
+	u32 old_itr_rx = q_vector->rx.itr;
+	struct mucse_ring *ring;
+
+	new_itr_rx = new_itr_rx * hw->usecstocount;
+	/* if we are in auto mode write to hw */
+	mucse_for_each_ring(ring, q_vector->rx) {
+		ring_wr32(ring, DMA_REG_RX_INT_DELAY_TIMER, new_itr_rx);
+		if (ring->ring_flags & M_RING_LOWER_ITR) {
+			/* if we are already in this mode skip */
+			if (q_vector->itr_rx == M_LOWEREST_ITR)
+				continue;
+			ring_wr32(ring, DMA_REG_RX_INT_DELAY_PKTCNT, 1);
+			ring_wr32(ring, DMA_REG_RX_INT_DELAY_TIMER,
+				  M_LOWEREST_ITR);
+			q_vector->itr_rx = M_LOWEREST_ITR;
+		} else {
+			if (new_itr_rx == q_vector->itr_rx)
+				continue;
+			ring_wr32(ring, DMA_REG_RX_INT_DELAY_TIMER,
+				  new_itr_rx);
+			ring_wr32(ring, DMA_REG_RX_INT_DELAY_PKTCNT,
+				  mucse->rx_frames);
+			q_vector->itr_rx = old_itr_rx;
+		}
+	}
+}
+
 static irqreturn_t rnpgbe_msix_clean_rings(int irq, void *data)
 {
 	struct mucse_q_vector *q_vector = (struct mucse_q_vector *)data;
 
 	rnpgbe_irq_disable_queues(q_vector);
-
+	rnpgbe_write_eitr_rx(q_vector);
 	if (q_vector->rx.ring || q_vector->tx.ring)
 		napi_schedule_irqoff(&q_vector->napi);
 
-- 
2.25.1


