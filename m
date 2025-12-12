Return-Path: <netdev+bounces-244489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B3FCB8CB0
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 13:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C849430B71CF
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 12:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A074031ED72;
	Fri, 12 Dec 2025 12:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="NS0ibPVQ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9423161A7;
	Fri, 12 Dec 2025 12:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765542220; cv=none; b=rwB1P1SS8dd3bd+mQuaE7u2GdiceSpTeu3PHnMRhk2SQL5ZluBR8JBazu2YYRIupTfXODmhJeN8QOSvjI96Pfeh/UkmelsO29gaLboAoCITad5JG0Jtvyw853zB7e3XqPtSZQvZJbR11fgQKoC96tuytQhsvXJmDpmkZK3H8vMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765542220; c=relaxed/simple;
	bh=u1vjdLvrfCvHk6C302hiG3ij5kCT8ltdn7LoOX9ABcA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uPQXUxyFf4gB8klmiydoDtRXO9GvIOtnU+AYyKK4bHJk9OGY+qlrsVpeYvJ6pQIXVmd11XtboeBOJp1wD5in4Vyqm8pUR+iU1nt56aCCpVuQUMH9OkEZCtm40fct1C6xklKXfkRxWJg4hhDwePtUGx/NwTpOo1GLymvs5OiL6dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=NS0ibPVQ; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BBNwS8i3502159;
	Fri, 12 Dec 2025 04:23:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=s
	nWDf3WrWrA76+If2FLbBsguJaJ0hYj03uOGX//+Lkw=; b=NS0ibPVQh9kUBmyyk
	j2OCIdINQChTBUVmEIMCclGWPTeg8EXxh0uZma21CfpLMQI2vPh4Pcx0xlyEuuje
	YuSsw57SIM0XjSuvg8tZQAgSYEsmr7hTLcmjj6faoob3Jhy36mV2dZx+sLoyMQtc
	QyfH6lgH1+wMNkxDSY6+NEbW7ynlXODh6QrVwRNDiY9zOYHVYj3MNKFsjRbvjfB9
	7DmQvEl+NfKAUT0oeuilwukZUgwMLx6df6iAuG2XAVQyL5y5fcYhhMgmWxb8WnL4
	PRK/EZ0Eb40pC5KKGr8BG5BzY/ZAOXS87HhnScXhiZl9o0mCtVV0C0rrrgASgZJd
	RQdWQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ayjcr4etj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Dec 2025 04:23:28 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 12 Dec 2025 04:23:41 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 12 Dec 2025 04:23:41 -0800
Received: from sapphire1.sclab.marvell.com (unknown [10.111.132.245])
	by maili.marvell.com (Postfix) with ESMTP id 08F4F3F7088;
	Fri, 12 Dec 2025 04:23:27 -0800 (PST)
From: Vimlesh Kumar <vimleshk@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sedara@marvell.com>, <srasheed@marvell.com>, <hgani@marvell.com>,
        "Vimlesh Kumar" <vimleshk@marvell.com>,
        Veerasenareddy Burru
	<vburru@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        "Paolo Abeni" <pabeni@redhat.com>
Subject: [PATCH net v1 2/3] octeon_ep: ensure dbell BADDR updation
Date: Fri, 12 Dec 2025 12:23:01 +0000
Message-ID: <20251212122304.2562229-3-vimleshk@marvell.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251212122304.2562229-1-vimleshk@marvell.com>
References: <20251212122304.2562229-1-vimleshk@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=XtT3+FF9 c=1 sm=1 tr=0 ts=693c0941 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=HOYU1IKHfkVmsGA0y00A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: yOXrcUV_nlcGzOlebu4FxTBz25KjGFXS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEyMDA5NiBTYWx0ZWRfX8Ya1CUX6qTY/
 reVqbH1VMFSc2aIcpAAIAhiIQ5g64EvjeAUetfa2smXrt7MWyIFoGCoCXeCV+Phf+aYxWPbwrUq
 pEPG9dQ4ZB1AEaAOYkc3Ha3dnTTeEfkPZ32P433fJURq5ndVIrr8qqm3Mo50qQhb2b2nTtTnKlV
 bA3RvJj8goeTr9ustZ5QXd2Y7Mpsyr6gNLkOMtMrSQCgJ2NUg7mWW/ZPbtsLZTyyQQlJqJdiNDw
 /KUkymNtUM7UR5JD+Xl67Ow3VSpyIEZT8BK/Ch1AsDg8UQRmeEB2uFMZ8LwfDx9iZjjopfJDxwd
 a6gZOL+SNeVbYvf4sysWynfUnpwtv70VQkOdGUMxeV9E5ajS4N3U4Zq4LZWXNKCm2Ptlc6Mulg+
 22b427WGml8P/lsgynKQrIbGomrM1g==
X-Proofpoint-GUID: yOXrcUV_nlcGzOlebu4FxTBz25KjGFXS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-12_03,2025-12-11_01,2025-10-01_01

Make sure the OUT DBELL base address reflects the
latest values written to it.

Fix:
Add a wait until the OUT DBELL base address register
is updated with the DMA ring descriptor address,
and modify the setup_oq function to properly
handle failures.

Fixes: 0807dc76f3bf5("octeon_ep: support Octeon CN10K devices")
Signed-off-by: Sathesh Edara <sedara@marvell.com>
Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
Signed-off-by: Vimlesh Kumar <vimleshk@marvell.com>
---
 .../marvell/octeon_ep/octep_cn9k_pf.c         |  3 ++-
 .../marvell/octeon_ep/octep_cnxk_pf.c         | 25 +++++++++++++++----
 .../ethernet/marvell/octeon_ep/octep_main.h   |  6 ++++-
 .../net/ethernet/marvell/octeon_ep/octep_rx.c |  4 ++-
 4 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c b/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
index db8ae1734e1b..32057a6351c1 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
@@ -307,7 +307,7 @@ static void octep_setup_iq_regs_cn93_pf(struct octep_device *oct, int iq_no)
 }
 
 /* Setup registers for a hardware Rx Queue  */
-static void octep_setup_oq_regs_cn93_pf(struct octep_device *oct, int oq_no)
+static int octep_setup_oq_regs_cn93_pf(struct octep_device *oct, int oq_no)
 {
 	u64 reg_val;
 	u64 oq_ctl = 0ULL;
@@ -355,6 +355,7 @@ static void octep_setup_oq_regs_cn93_pf(struct octep_device *oct, int oq_no)
 	reg_val = ((u64)time_threshold << 32) |
 		  CFG_GET_OQ_INTR_PKT(oct->conf);
 	octep_write_csr64(oct, CN93_SDP_R_OUT_INT_LEVELS(oq_no), reg_val);
+	return 0;
 }
 
 /* Setup registers for a PF mailbox */
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c b/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c
index 6369c4dedf46..80f658bf5418 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c
@@ -327,10 +327,11 @@ static void octep_setup_iq_regs_cnxk_pf(struct octep_device *oct, int iq_no)
 }
 
 /* Setup registers for a hardware Rx Queue  */
-static void octep_setup_oq_regs_cnxk_pf(struct octep_device *oct, int oq_no)
+static int octep_setup_oq_regs_cnxk_pf(struct octep_device *oct, int oq_no)
 {
 	u64 reg_val;
 	u64 oq_ctl = 0ULL;
+	u64 reg_ba_val;
 	u32 time_threshold = 0;
 	struct octep_oq *oq = oct->oq[oq_no];
 
@@ -343,6 +344,23 @@ static void octep_setup_oq_regs_cnxk_pf(struct octep_device *oct, int oq_no)
 			reg_val = octep_read_csr64(oct, CNXK_SDP_R_OUT_CONTROL(oq_no));
 		} while (!(reg_val & CNXK_R_OUT_CTL_IDLE));
 	}
+	octep_write_csr64(oct, CNXK_SDP_R_OUT_WMARK(oq_no),  oq->max_count);
+	/* Wait for WMARK to get applied */
+	usleep_range(10, 15);
+
+	octep_write_csr64(oct, CNXK_SDP_R_OUT_SLIST_BADDR(oq_no), oq->desc_ring_dma);
+	octep_write_csr64(oct, CNXK_SDP_R_OUT_SLIST_RSIZE(oq_no), oq->max_count);
+	reg_ba_val = octep_read_csr64(oct, CNXK_SDP_R_OUT_SLIST_BADDR(oq_no));
+	if (reg_ba_val != oq->desc_ring_dma) {
+		do {
+			if (reg_ba_val == UINT64_MAX)
+				return -1;
+			octep_write_csr64(oct, CNXK_SDP_R_OUT_SLIST_BADDR(oq_no),
+					  oq->desc_ring_dma);
+			octep_write_csr64(oct, CNXK_SDP_R_OUT_SLIST_RSIZE(oq_no), oq->max_count);
+			reg_ba_val = octep_read_csr64(oct, CNXK_SDP_R_OUT_SLIST_BADDR(oq_no));
+		} while (reg_ba_val != oq->desc_ring_dma);
+	}
 
 	reg_val &= ~(CNXK_R_OUT_CTL_IMODE);
 	reg_val &= ~(CNXK_R_OUT_CTL_ROR_P);
@@ -356,10 +374,6 @@ static void octep_setup_oq_regs_cnxk_pf(struct octep_device *oct, int oq_no)
 	reg_val |= (CNXK_R_OUT_CTL_ES_P);
 
 	octep_write_csr64(oct, CNXK_SDP_R_OUT_CONTROL(oq_no), reg_val);
-	octep_write_csr64(oct, CNXK_SDP_R_OUT_SLIST_BADDR(oq_no),
-			  oq->desc_ring_dma);
-	octep_write_csr64(oct, CNXK_SDP_R_OUT_SLIST_RSIZE(oq_no),
-			  oq->max_count);
 
 	oq_ctl = octep_read_csr64(oct, CNXK_SDP_R_OUT_CONTROL(oq_no));
 
@@ -385,6 +399,7 @@ static void octep_setup_oq_regs_cnxk_pf(struct octep_device *oct, int oq_no)
 	reg_val &= ~0xFFFFFFFFULL;
 	reg_val |= CFG_GET_OQ_WMARK(oct->conf);
 	octep_write_csr64(oct, CNXK_SDP_R_OUT_WMARK(oq_no), reg_val);
+	return 0;
 }
 
 /* Setup registers for a PF mailbox */
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.h b/drivers/net/ethernet/marvell/octeon_ep/octep_main.h
index 81ac4267811c..76622cdf577d 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.h
@@ -55,6 +55,10 @@
 				  (iq_)->max_count - IQ_INSTR_PENDING(iq_); \
 				})
 
+#ifndef UINT64_MAX
+#define UINT64_MAX ((u64)(~((u64)0)))        /* 0xFFFFFFFFFFFFFFFF */
+#endif
+
 /* PCI address space mapping information.
  * Each of the 3 address spaces given by BAR0, BAR2 and BAR4 of
  * Octeon gets mapped to different physical address spaces in
@@ -77,7 +81,7 @@ struct octep_pci_win_regs {
 
 struct octep_hw_ops {
 	void (*setup_iq_regs)(struct octep_device *oct, int q);
-	void (*setup_oq_regs)(struct octep_device *oct, int q);
+	int (*setup_oq_regs)(struct octep_device *oct, int q);
 	void (*setup_mbox_regs)(struct octep_device *oct, int mbox);
 
 	irqreturn_t (*mbox_intr_handler)(void *ioq_vector);
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
index 82b6b19e76b4..1581cc468d74 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
@@ -170,7 +170,9 @@ static int octep_setup_oq(struct octep_device *oct, int q_no)
 		goto oq_fill_buff_err;
 
 	octep_oq_reset_indices(oq);
-	oct->hw_ops.setup_oq_regs(oct, q_no);
+	if (oct->hw_ops.setup_oq_regs(oct, q_no))
+		goto oq_fill_buff_err;
+
 	oct->num_oqs++;
 
 	return 0;
-- 
2.47.0


