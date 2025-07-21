Return-Path: <netdev+bounces-208582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B1EB0C342
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 13:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44E881AA2603
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 11:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3BF2BE64F;
	Mon, 21 Jul 2025 11:35:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662EC2BD595;
	Mon, 21 Jul 2025 11:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753097753; cv=none; b=XGg5KUZhfp7kmt1bftN9xuT/RVvGL9Ml323Ha8u2asIe+Acr5sV5n55/jQmjf5ZsTnodzFQOZ2H1Unde6+w2Jr+67p8eVW3sIgQrlVWmHiQWI+3DOnq1mgS3ESJh9QHhf7zBl/WRvqsLLKkinx+0mHBcUWL4qhXNNLOd31n7aHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753097753; c=relaxed/simple;
	bh=kSqO5KJqMd0ShsTRf+YZa+U+68jPnc8xVojuiQAj/4I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uYhzhEfQWAuAeE1D42Qbi5XIJGOnHn+lTg4XB5roeR28/HKS9itu9jT7TP/B1A1jk8tTx04Hxo26Tu3FoFSmnQT+AtWVhE8aN40nHQQwTp3U35Gj63skT+QRMoEI2Hrtkf4viWLn7sGq6sFfNrrnSIQR+tWTKVCAx03/dcqD+dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz18t1753097637t10ed0f73
X-QQ-Originating-IP: AUZFOgkES0R6H72iICvKupyHsfemWHNYmBQqkItQFNA=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 21 Jul 2025 19:33:53 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16800422432126434323
EX-QQ-RecipientCnt: 23
From: Dong Yibo <dong100@mucse.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
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
	alexanderduyck@fb.com,
	richardcochran@gmail.com
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dong100@mucse.com
Subject: [PATCH v2 15/15] net: rnpgbe: Add ITR for rx
Date: Mon, 21 Jul 2025 19:32:38 +0800
Message-Id: <20250721113238.18615-16-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250721113238.18615-1-dong100@mucse.com>
References: <20250721113238.18615-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MxZCU/CcMqmTR5fpMEbbL1vpdrfH7ePor8jJNs5qjyXk8uQRsCWCKFoo
	RjbdtL8HgJ9gdZvKz9jSYeT2p8lzF9gH8JDZv9UanWQcwsulXG8JdmkFbWz/031roH/xdrz
	19K+8gN7x75OZIP+bf/07HiYG/oOFb35uGoYjaYTa8WnwkLB70hnnYxQjykYzN+IwTnuGKG
	CjTbByNMeKz06iejWbSC66hbK5z8lcDohzwfPYG1BxRfJdgdEQ7OenQFdQUjNwL/4YcT59j
	Tp9uRO8LOKpNNAyJwQMYwy9g5EonSuX47tUVPK9rG6kNRLyr1ygdo0UIVLgyFGLDUY2ExUw
	h8kKZq3w6yIJgpyGK0SCUFSGBkBbztQtYeFOdH8/n1c6OwdPGbRldJTU1Sdnx1LIsD23j3p
	n6GLRSaWEoY1MCarf65Ao/nNj2wK6TGtWoCzV8bLpLvxXKKOa7bYXwcBJJvpjPzOT+UrqIn
	o9mQWfiT0AIXWLqdDn86sG0LGuS5vSF2N72Qwyx8Lj4vubUPUz39Qex0cS7c+4yqlCugFGj
	gb0c0kAV09bnGGxnBoN9NFihlEtrepulJMDUvJrXkHBf/JQA9nG++j0TYDtmE4CnYCeQAp2
	H+hXJLbj9Qmc8g2roAltECBPk6rn+5fLa0Gq/Zmj49LNgRVSSLCr7vDZBohyAUbpkDtyDYO
	HGdSYizhP1ZP0ZF/dVZB7Wh1/iqgGnHZzi9EwEpkQkqsiQlREW9xIHXjn58hRsR2RAus1yk
	6EneLwZ2DppaEn/5sTjeK209WeSCNcZfx7V4BZctOwXwwsXLgrY5VvLDcbasugmXviVY47m
	qQmstcvhMQmnCKxBL8Jk0UzrP4P6E/tWOspQkkWH1lC0/TE7rG8hQ+Ya99m5MMSWNvZXoOU
	9ruPtCMC5YBQVGZ9UhphmH34MhEXQ8e8C1WcQ+sfj9fS56N/FF/vll7W5gwQofcRD7piKlT
	iZGsd0xA1RxEKnG79uKOIkJCTTG5ovE8/Ke5dcbRVe+hYQxdyUgLM/hL91Tg5LYUooduqHv
	l2MC+tQBssmvcRVr1TEgBVh24hManSSek/s987VmW393KV9QDoqqAlPuvvAXc=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

Initialize itr function according to rx packets/bytes

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  5 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.c    | 99 ++++++++++++++++++-
 2 files changed, 103 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index 9d8d939d81a4..d24438f458ac 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -547,6 +547,8 @@ struct mucse_ring_container {
 	unsigned int total_packets;
 	u16 work_limit;
 	u16 count;
+	u16 itr;
+	int update_count;
 };
 
 struct mucse_q_vector {
@@ -701,6 +703,9 @@ static inline __le16 rnpgbe_test_staterr(union rnpgbe_rx_desc *rx_desc,
 
 #define M_TRY_LINK_TIMEOUT (4 * HZ)
 
+#define M_LOWEREST_ITR (5)
+#define M_4K_ITR (980)
+
 #define M_RX_BUFFER_WRITE (16)
 #define m_rd_reg(reg) readl(reg)
 #define m_wr_reg(reg, val) writel((val), reg)
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
index 675ed12cffcb..1211b742223b 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
@@ -693,6 +693,66 @@ static int rnpgbe_clean_rx_irq(struct mucse_q_vector *q_vector,
 	return fail_alloc ? budget : total_rx_packets;
 }
 
+/**
+ * rnpgbe_update_ring_itr_rx - Update rx itr according received pacekts/bytes
+ * @q_vector: structure containing interrupt and ring information
+ **/
+static void rnpgbe_update_ring_itr_rx(struct mucse_q_vector *q_vector)
+{
+	struct mucse *mucse = q_vector->mucse;
+	int new_val = q_vector->itr_rx;
+	int avg_wire_size = 0;
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
  * rnpgbe_poll - NAPI polling RX/TX cleanup routine
  * @napi: napi struct with our devices info in it
@@ -739,6 +799,7 @@ static int rnpgbe_poll(struct napi_struct *napi, int budget)
 		return budget;
 	/* all work done, exit the polling mode */
 	if (likely(napi_complete_done(napi, work_done))) {
+		rnpgbe_update_ring_itr_rx(q_vector);
 		if (!test_bit(__MUCSE_DOWN, &mucse->state))
 			rnpgbe_irq_enable_queues(mucse, q_vector);
 	}
@@ -1696,6 +1757,42 @@ void rnpgbe_clean_all_tx_rings(struct mucse *mucse)
 		rnpgbe_clean_tx_ring(mucse->tx_ring[i]);
 }
 
+/**
+ * rnpgbe_write_eitr_rx - write new itr to Hw
+ * @q_vector: structure containing interrupt and ring information
+ **/
+static void rnpgbe_write_eitr_rx(struct mucse_q_vector *q_vector)
+{
+	struct mucse *mucse = q_vector->mucse;
+	u32 new_itr_rx = q_vector->rx.itr;
+	u32 old_itr_rx = q_vector->rx.itr;
+	struct mucse_hw *hw = &mucse->hw;
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
 /**
  * rnpgbe_msix_clean_rings - msix irq handler for ring irq
  * @irq: irq num
@@ -1708,7 +1805,7 @@ static irqreturn_t rnpgbe_msix_clean_rings(int irq, void *data)
 	struct mucse_q_vector *q_vector = (struct mucse_q_vector *)data;
 
 	rnpgbe_irq_disable_queues(q_vector);
-
+	rnpgbe_write_eitr_rx(q_vector);
 	if (q_vector->rx.ring || q_vector->tx.ring)
 		napi_schedule_irqoff(&q_vector->napi);
 
-- 
2.25.1


