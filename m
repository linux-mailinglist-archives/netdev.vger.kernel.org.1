Return-Path: <netdev+bounces-244490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F60ECB8CA7
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 13:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5A2803014BC3
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 12:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40783115B1;
	Fri, 12 Dec 2025 12:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="N3oXfel6"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3B42C11F3;
	Fri, 12 Dec 2025 12:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765542225; cv=none; b=XlbcLckGEy7IVHmfHOV+VKbf7A0cIklFrRHvBLxy60SzdalM5+lcHpTHRliGZw2lFwUK97fNFbw0kTuunLAyBwVZTVOjh95A272hV8j+J5fMRTjFrNgQ04WEF9fO5o108ZRI6+Fmt8nwiJiBL8h15GrMXtyd63FTlsXY67xqMiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765542225; c=relaxed/simple;
	bh=RZIgm8HY1YD/cocv1qXh9Jr0qfsgGPfivLRvEKFDQdc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k/M1vikLR5InCr8jBXDtYskxFs9cmawPSkktOhMFET4z5OW/PQGAnzOSCLcmc5TvHJxoGAmL1UYVOtXqu0rrWUGtVZUtFxs4Gf0Z8t0cwQasQ1K6rHBq0AC9FkqQ6+i0gInmC9d1JsOyTfMppj73/DR0yiRH48ifHMl4YGIdcqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=N3oXfel6; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BBNS59p3755296;
	Fri, 12 Dec 2025 04:23:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=3
	/3sCamQhiE5u0bnwAImbrTbT2uQHqoAQ6K3CnEqTDI=; b=N3oXfel6NNsqAzOuP
	KiCXyHwWtrySTFkEA0vfLGwbrzzAYf1Ic8idDddpYXxw0IB3o69PtelfsmOSnt7a
	Baz+mwNzoUyOXRKmgae1An9AeX7eZhVA2ItCmKongwakB1eE5S63YuA/GSwHgCuC
	f6L11QTzM8VxJnXR85zhIys4naaQwPWYjXS+up5dxuEs++SZkkOUX8BW/HJ/h6Kj
	E0tRaVNR35HwtJb1jdTUYichymWPBgbOMju7I3l6lTMS5zeRa81Gzbr8ugm2OuIy
	IP5D/Plsxy6+aPJIwkjCYPIBsbMRqigZ56QWQ4vBg4Sytzskkig9D7kC4aqeHlka
	PxlMg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4b07nfsb88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Dec 2025 04:23:35 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 12 Dec 2025 04:23:48 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 12 Dec 2025 04:23:48 -0800
Received: from sapphire1.sclab.marvell.com (unknown [10.111.132.245])
	by maili.marvell.com (Postfix) with ESMTP id 039843F7088;
	Fri, 12 Dec 2025 04:23:33 -0800 (PST)
From: Vimlesh Kumar <vimleshk@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sedara@marvell.com>, <srasheed@marvell.com>, <hgani@marvell.com>,
        "Vimlesh Kumar" <vimleshk@marvell.com>,
        Veerasenareddy Burru
	<vburru@marvell.com>,
        Satananda Burla <sburla@marvell.com>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>
Subject: [PATCH net v1 3/3] octeon_ep_vf: ensure dbell BADDR updation
Date: Fri, 12 Dec 2025 12:23:02 +0000
Message-ID: <20251212122304.2562229-4-vimleshk@marvell.com>
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
X-Proofpoint-GUID: SMBZumO5rdAjs1FlWfITfJVpJrNiYvup
X-Authority-Analysis: v=2.4 cv=QtZTHFyd c=1 sm=1 tr=0 ts=693c0948 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=9s7rcsES4n5jIWhP9eIA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEyMDA5NiBTYWx0ZWRfX9t5YTyDPmd0Z
 K+KDiM36fsX1cbSmMIfyKYi903ohmq5A7XiI6CJh59BAYyGqSOF+w8L4+bR6YgDO1GVHhHoL6/l
 3awDUsww7IH6V6EggmHg3Z58f7A/hVfYg3SioUJ28jglr7t+G18sNgH7GBt9DeKTRnhkblgjZuW
 DF4+Xi61g/67rCm12vVFsPe9B1d7ft0P7kTgEq7EUyY1bSOCqxjamETqg9ARqW4a7hCiNsPnwh2
 Z48fmMj/uO9+OGzlb6Dex1TVW7Vb1vQaBJV32gVEpEDoYi/Aedx0v9mAbbOjM5DhrcI7nggAQxK
 agCqcbK1WVggOVHjjWDh+peOiQqAv4N7ufYGe8RRyfkScfLLybPlP7E5nSxU/a60Tv8AEfmCcLt
 ymTtmrIduODRoFgxae40Hkd9tjzbGw==
X-Proofpoint-ORIG-GUID: SMBZumO5rdAjs1FlWfITfJVpJrNiYvup
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

Fixes: 2c0c32c72be29 ("octeon_ep_vf: add hardware configuration APIs")
Signed-off-by: Sathesh Edara <sedara@marvell.com>
Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
Signed-off-by: Vimlesh Kumar <vimleshk@marvell.com>
---
 .../marvell/octeon_ep_vf/octep_vf_cn9k.c      |  3 ++-
 .../marvell/octeon_ep_vf/octep_vf_cnxk.c      | 25 ++++++++++++++++---
 .../marvell/octeon_ep_vf/octep_vf_main.h      |  6 ++++-
 .../marvell/octeon_ep_vf/octep_vf_rx.c        |  4 ++-
 4 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cn9k.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cn9k.c
index 88937fce75f1..4c769b27c278 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cn9k.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cn9k.c
@@ -196,7 +196,7 @@ static void octep_vf_setup_iq_regs_cn93(struct octep_vf_device *oct, int iq_no)
 }
 
 /* Setup registers for a hardware Rx Queue  */
-static void octep_vf_setup_oq_regs_cn93(struct octep_vf_device *oct, int oq_no)
+static int octep_vf_setup_oq_regs_cn93(struct octep_vf_device *oct, int oq_no)
 {
 	struct octep_vf_oq *oq = oct->oq[oq_no];
 	u32 time_threshold = 0;
@@ -239,6 +239,7 @@ static void octep_vf_setup_oq_regs_cn93(struct octep_vf_device *oct, int oq_no)
 	time_threshold = CFG_GET_OQ_INTR_TIME(oct->conf);
 	reg_val = ((u64)time_threshold << 32) | CFG_GET_OQ_INTR_PKT(oct->conf);
 	octep_vf_write_csr64(oct, CN93_VF_SDP_R_OUT_INT_LEVELS(oq_no), reg_val);
+	return 0;
 }
 
 /* Setup registers for a VF mailbox */
diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cnxk.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cnxk.c
index 1f79dfad42c6..30dc09205446 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cnxk.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cnxk.c
@@ -199,11 +199,12 @@ static void octep_vf_setup_iq_regs_cnxk(struct octep_vf_device *oct, int iq_no)
 }
 
 /* Setup registers for a hardware Rx Queue  */
-static void octep_vf_setup_oq_regs_cnxk(struct octep_vf_device *oct, int oq_no)
+static int octep_vf_setup_oq_regs_cnxk(struct octep_vf_device *oct, int oq_no)
 {
 	struct octep_vf_oq *oq = oct->oq[oq_no];
 	u32 time_threshold = 0;
 	u64 oq_ctl = ULL(0);
+	u64 reg_ba_val;
 	u64 reg_val;
 
 	reg_val = octep_vf_read_csr64(oct, CNXK_VF_SDP_R_OUT_CONTROL(oq_no));
@@ -214,6 +215,25 @@ static void octep_vf_setup_oq_regs_cnxk(struct octep_vf_device *oct, int oq_no)
 			reg_val = octep_vf_read_csr64(oct, CNXK_VF_SDP_R_OUT_CONTROL(oq_no));
 		} while (!(reg_val & CNXK_VF_R_OUT_CTL_IDLE));
 	}
+	octep_vf_write_csr64(oct, CNXK_VF_SDP_R_OUT_WMARK(oq_no),  oq->max_count);
+	/* Wait for WMARK to get applied */
+	usleep_range(10, 15);
+
+	octep_vf_write_csr64(oct, CNXK_VF_SDP_R_OUT_SLIST_BADDR(oq_no), oq->desc_ring_dma);
+	octep_vf_write_csr64(oct, CNXK_VF_SDP_R_OUT_SLIST_RSIZE(oq_no), oq->max_count);
+	reg_ba_val = octep_vf_read_csr64(oct, CNXK_VF_SDP_R_OUT_SLIST_BADDR(oq_no));
+	if (reg_ba_val != oq->desc_ring_dma) {
+		do {
+			if (reg_ba_val == UINT64_MAX)
+				return -1;
+			octep_vf_write_csr64(oct, CNXK_VF_SDP_R_OUT_SLIST_BADDR(oq_no),
+					     oq->desc_ring_dma);
+			octep_vf_write_csr64(oct, CNXK_VF_SDP_R_OUT_SLIST_RSIZE(oq_no),
+					     oq->max_count);
+			reg_ba_val = octep_vf_read_csr64(oct,
+							 CNXK_VF_SDP_R_OUT_SLIST_BADDR(oq_no));
+		} while (reg_ba_val != oq->desc_ring_dma);
+	}
 
 	reg_val &= ~(CNXK_VF_R_OUT_CTL_IMODE);
 	reg_val &= ~(CNXK_VF_R_OUT_CTL_ROR_P);
@@ -227,8 +247,6 @@ static void octep_vf_setup_oq_regs_cnxk(struct octep_vf_device *oct, int oq_no)
 	reg_val |= (CNXK_VF_R_OUT_CTL_ES_P);
 
 	octep_vf_write_csr64(oct, CNXK_VF_SDP_R_OUT_CONTROL(oq_no), reg_val);
-	octep_vf_write_csr64(oct, CNXK_VF_SDP_R_OUT_SLIST_BADDR(oq_no), oq->desc_ring_dma);
-	octep_vf_write_csr64(oct, CNXK_VF_SDP_R_OUT_SLIST_RSIZE(oq_no), oq->max_count);
 
 	oq_ctl = octep_vf_read_csr64(oct, CNXK_VF_SDP_R_OUT_CONTROL(oq_no));
 	/* Clear the ISIZE and BSIZE (22-0) */
@@ -250,6 +268,7 @@ static void octep_vf_setup_oq_regs_cnxk(struct octep_vf_device *oct, int oq_no)
 	reg_val &= ~GENMASK_ULL(31, 0);
 	reg_val |= CFG_GET_OQ_WMARK(oct->conf);
 	octep_vf_write_csr64(oct, CNXK_VF_SDP_R_OUT_WMARK(oq_no), reg_val);
+	return 0;
 }
 
 /* Setup registers for a VF mailbox */
diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.h b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.h
index b9f13506f462..65454d875677 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.h
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.h
@@ -40,6 +40,10 @@
 				  (iq_)->max_count - IQ_INSTR_PENDING(iq_); \
 				})
 
+#ifndef UINT64_MAX
+#define UINT64_MAX ((u64)(~((u64)0)))        /* 0xFFFFFFFFFFFFFFFF */
+#endif
+
 /* PCI address space mapping information.
  * Each of the 3 address spaces given by BAR0, BAR2 and BAR4 of
  * Octeon gets mapped to different physical address spaces in
@@ -55,7 +59,7 @@ struct octep_vf_mmio {
 
 struct octep_vf_hw_ops {
 	void (*setup_iq_regs)(struct octep_vf_device *oct, int q);
-	void (*setup_oq_regs)(struct octep_vf_device *oct, int q);
+	int (*setup_oq_regs)(struct octep_vf_device *oct, int q);
 	void (*setup_mbox_regs)(struct octep_vf_device *oct, int mbox);
 
 	irqreturn_t (*non_ioq_intr_handler)(void *ioq_vector);
diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
index d70c8be3cfc4..6446f6bf0b90 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
@@ -171,7 +171,9 @@ static int octep_vf_setup_oq(struct octep_vf_device *oct, int q_no)
 		goto oq_fill_buff_err;
 
 	octep_vf_oq_reset_indices(oq);
-	oct->hw_ops.setup_oq_regs(oct, q_no);
+	if (oct->hw_ops.setup_oq_regs(oct, q_no))
+		goto oq_fill_buff_err;
+
 	oct->num_oqs++;
 
 	return 0;
-- 
2.47.0


