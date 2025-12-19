Return-Path: <netdev+bounces-245476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8E2CCEC8B
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 08:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0225A300E02F
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 07:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683CF22D7B5;
	Fri, 19 Dec 2025 07:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="kygqWe2f"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A891A23B6;
	Fri, 19 Dec 2025 07:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766129418; cv=none; b=WOeZOkqBDZV7XPY3611gdIneKa+ohIGZL0fm8MtRM5JJEjRwHzugO1UQ0F9nKOwmGwzGF7dw4BSb1JZ7J1rLzsASqHYX2zDr7NwfIju/uCFWGNWdSgsflCDoZsjdR4Sk6A5M4RseMx18x8IytoF0p/jTnZtg+zgtF8vTTvKV87w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766129418; c=relaxed/simple;
	bh=vYF2RmCPGCM5OedgwIepoztSUVauQ1ywCDtY9zdNF9E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eaPaa4lorp/YqJqIAMCnFtP8KyGvIHVqat6fonfNF/cpUPRYRLqHQeBJK+c/QYuDsNoCceymy8hJrlbkRsYykt8zKxv7np+6+a5Whin5CNo8qWcwCJ3P3myGLDwylkZvQYQ/foRL6XX02S1w54aVfSgLGEddOtloi4Ngj6FL9K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=kygqWe2f; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BIJjP5F679923;
	Thu, 18 Dec 2025 23:30:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=/
	gXAo7GVe5FacXtvUOj/fcv83KeOHuG6Ny2UGBzDWoU=; b=kygqWe2fDRHHRzUEx
	xQB0+JD7OVGTszVZL0XihDNKgx0qS8iceGRN+xaWfrl8B0a1ADrjh7Ka33kBOKmc
	u77VgrIyzYqL4w891xl0hRM4yfREl42hVcL2mBvqp/BMRejOqRB6y5UnpSkWvoxq
	tVc4/1lxWL0DJWGFg2nSkbXq3MoG3U1XLi+gt82O/Ho9QnNe9cABrpjwMs8J1H9z
	mHPBbBvb7aWlY7GSisE1EtjM65xPx1GPbO6FYQqsIQrzNs7m1urPIGjZWgX7cHpm
	Z5TjhW3hFL27jEUmPKGG+BrGqzTOHa17fcD/7ZyjVu41vCntIzZb9w2At3CMKVzh
	jO8og==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4b4r2416bg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Dec 2025 23:30:06 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 18 Dec 2025 23:30:05 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 18 Dec 2025 23:30:04 -0800
Received: from sapphire1.sclab.marvell.com (unknown [10.111.132.245])
	by maili.marvell.com (Postfix) with ESMTP id 888013F70BE;
	Thu, 18 Dec 2025 23:30:04 -0800 (PST)
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
Subject: [PATCH net v1 2/2] octeon_ep_vf: avoid compiler and IQ/OQ reordering
Date: Fri, 19 Dec 2025 07:29:53 +0000
Message-ID: <20251219072955.3048238-3-vimleshk@marvell.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251219072955.3048238-1-vimleshk@marvell.com>
References: <20251219072955.3048238-1-vimleshk@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDA2MSBTYWx0ZWRfX8y10MFmUOnho
 O8gTiTYNhRtiRytqv9WwwICVQ2OJW582hmxRlIkH1AQj4KBpQxyeZjfgQ2oeiTVN1B2bIh/iGRQ
 BuXGVFochZGjjbvy6ysZ6auJrsR216xqUbOQzhpyMqix7xNI0GqXgGJqyvrEBWhktgPMOFd7b7z
 OeLrVmc+qe2QlaHJvCYPM3Oa5JEZNAF7d0+mSXbEIcabJqWAgjl8aEAU43ne+lB47dJN06Qhnto
 OUYMXJXhJF09EZO4YlFOoDVCg9+JSeR1z0Asb8a+WlCWM6xo+8791O/jrKROtF4w05N3LuG53na
 w58O1GNOyrRbUlz1GsKno2olGdb3vIGUbSqZBcdLwMGbYXSOZKcntwQbjOVMcNd9EupETJDwQaL
 3HHeM2vgp8uTyackybuAZ+Xnvb7+fHBsap89ctTjUnW3Tu5qf0VutNa6ybUA3Z3kruelc5HowIn
 LQCwDpAXRpVVIVhzXEg==
X-Proofpoint-ORIG-GUID: mVZOWPAPicIC8o4JTR3iQrVtmfBDFl86
X-Authority-Analysis: v=2.4 cv=T4uBjvKQ c=1 sm=1 tr=0 ts=6944fefe cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=zFyd0VMmUU5vBRt5t4UA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: mVZOWPAPicIC8o4JTR3iQrVtmfBDFl86
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_02,2025-12-17_02,2025-10-01_01

Utilize READ_ONCE and WRITE_ONCE APIs for IO queue Tx/Rx
variable access to prevent compiler optimization and reordering.
Additionally, ensure IO queue OUT/IN_CNT registers are flushed
by performing a read-back after writing.

Relocate IQ/OQ IN/OUT_CNTS updates to occur before NAPI completion,
and replace napi_complete with napi_complete_done.

Fixes: 1cd3b407977c3 ("octeon_ep_vf: add Tx/Rx processing and interrupt support")
Signed-off-by: Sathesh Edara <sedara@marvell.com>
Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
Signed-off-by: Vimlesh Kumar <vimleshk@marvell.com>
---
 .../marvell/octeon_ep_vf/octep_vf_main.c      | 38 ++++++++++++++-----
 .../marvell/octeon_ep_vf/octep_vf_rx.c        | 28 ++++++++++----
 2 files changed, 48 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
index 420c3f4cf741..27a5fc38bccb 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
@@ -286,28 +286,45 @@ static void octep_vf_clean_irqs(struct octep_vf_device *oct)
 }
 
 /**
- * octep_vf_enable_ioq_irq() - Enable MSI-x interrupt of a Tx/Rx queue.
+ * octep_vf_update_pkt() - Update IQ/OQ IN/OUT_CNT registers.
  *
  * @iq: Octeon Tx queue data structure.
  * @oq: Octeon Rx queue data structure.
  */
-static void octep_vf_enable_ioq_irq(struct octep_vf_iq *iq, struct octep_vf_oq *oq)
+
+static void octep_vf_update_pkt(struct octep_vf_iq *iq, struct octep_vf_oq *oq)
 {
-	u32 pkts_pend = oq->pkts_pending;
+	u32 pkts_pend = READ_ONCE(oq->pkts_pending);
+	u32 last_pkt_count = READ_ONCE(oq->last_pkt_count);
+	u32 pkts_processed = READ_ONCE(iq->pkts_processed);
+	u32 pkt_in_done = READ_ONCE(iq->pkt_in_done);
 
 	netdev_dbg(iq->netdev, "enabling intr for Q-%u\n", iq->q_no);
-	if (iq->pkts_processed) {
-		writel(iq->pkts_processed, iq->inst_cnt_reg);
-		iq->pkt_in_done -= iq->pkts_processed;
-		iq->pkts_processed = 0;
+	if (pkts_processed) {
+		writel(pkts_processed, iq->inst_cnt_reg);
+		readl(iq->inst_cnt_reg);
+		WRITE_ONCE(iq->pkt_in_done, (pkt_in_done - pkts_processed));
+		WRITE_ONCE(iq->pkts_processed, 0);
 	}
-	if (oq->last_pkt_count - pkts_pend) {
-		writel(oq->last_pkt_count - pkts_pend, oq->pkts_sent_reg);
-		oq->last_pkt_count = pkts_pend;
+	if (last_pkt_count - pkts_pend) {
+		writel(last_pkt_count - pkts_pend, oq->pkts_sent_reg);
+		readl(oq->pkts_sent_reg);
+		WRITE_ONCE(oq->last_pkt_count, pkts_pend);
 	}
 
 	/* Flush the previous wrties before writing to RESEND bit */
 	smp_wmb();
+}
+
+/**
+ * octep_vf_enable_ioq_irq() - Enable MSI-x interrupt of a Tx/Rx queue.
+ *
+ * @iq: Octeon Tx queue data structure.
+ * @oq: Octeon Rx queue data structure.
+ */
+static void octep_vf_enable_ioq_irq(struct octep_vf_iq *iq,
+				    struct octep_vf_oq *oq)
+{
 	writeq(1UL << OCTEP_VF_OQ_INTR_RESEND_BIT, oq->pkts_sent_reg);
 	writeq(1UL << OCTEP_VF_IQ_INTR_RESEND_BIT, iq->inst_cnt_reg);
 }
@@ -333,6 +350,7 @@ static int octep_vf_napi_poll(struct napi_struct *napi, int budget)
 	if (tx_pending || rx_done >= budget)
 		return budget;
 
+	octep_vf_update_pkt(ioq_vector->iq, ioq_vector->oq);
 	if (likely(napi_complete_done(napi, rx_done)))
 		octep_vf_enable_ioq_irq(ioq_vector->iq, ioq_vector->oq);
 
diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
index d70c8be3cfc4..31380962c212 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
@@ -319,9 +319,16 @@ static int octep_vf_oq_check_hw_for_pkts(struct octep_vf_device *oct,
 					 struct octep_vf_oq *oq)
 {
 	u32 pkt_count, new_pkts;
+	u32 last_pkt_count, pkts_pending;
 
 	pkt_count = readl(oq->pkts_sent_reg);
-	new_pkts = pkt_count - oq->last_pkt_count;
+	last_pkt_count = READ_ONCE(oq->last_pkt_count);
+	new_pkts = pkt_count - last_pkt_count;
+
+	if (pkt_count < last_pkt_count) {
+		dev_err(oq->dev, "OQ-%u pkt_count(%u) < oq->last_pkt_count(%u)\n",
+			oq->q_no, pkt_count, last_pkt_count);
+	}
 
 	/* Clear the hardware packets counter register if the rx queue is
 	 * being processed continuously with-in a single interrupt and
@@ -333,8 +340,9 @@ static int octep_vf_oq_check_hw_for_pkts(struct octep_vf_device *oct,
 		pkt_count = readl(oq->pkts_sent_reg);
 		new_pkts += pkt_count;
 	}
-	oq->last_pkt_count = pkt_count;
-	oq->pkts_pending += new_pkts;
+	WRITE_ONCE(oq->last_pkt_count, pkt_count);
+	pkts_pending = READ_ONCE(oq->pkts_pending);
+	WRITE_ONCE(oq->pkts_pending, (pkts_pending + new_pkts));
 	return new_pkts;
 }
 
@@ -363,7 +371,7 @@ static int __octep_vf_oq_process_rx(struct octep_vf_device *oct,
 	struct sk_buff *skb;
 	u32 read_idx;
 
-	read_idx = oq->host_read_idx;
+	read_idx = READ_ONCE(oq->host_read_idx);
 	rx_bytes = 0;
 	desc_used = 0;
 	for (pkt = 0; pkt < pkts_to_process; pkt++) {
@@ -457,7 +465,7 @@ static int __octep_vf_oq_process_rx(struct octep_vf_device *oct,
 		napi_gro_receive(oq->napi, skb);
 	}
 
-	oq->host_read_idx = read_idx;
+	WRITE_ONCE(oq->host_read_idx, read_idx);
 	oq->refill_count += desc_used;
 	oq->stats->packets += pkt;
 	oq->stats->bytes += rx_bytes;
@@ -480,22 +488,26 @@ int octep_vf_oq_process_rx(struct octep_vf_oq *oq, int budget)
 {
 	u32 pkts_available, pkts_processed, total_pkts_processed;
 	struct octep_vf_device *oct = oq->octep_vf_dev;
+	u32 pkts_pending;
 
 	pkts_available = 0;
 	pkts_processed = 0;
 	total_pkts_processed = 0;
 	while (total_pkts_processed < budget) {
 		 /* update pending count only when current one exhausted */
-		if (oq->pkts_pending == 0)
+		pkts_pending = READ_ONCE(oq->pkts_pending);
+		if (pkts_pending == 0)
 			octep_vf_oq_check_hw_for_pkts(oct, oq);
+		pkts_pending = READ_ONCE(oq->pkts_pending);
 		pkts_available = min(budget - total_pkts_processed,
-				     oq->pkts_pending);
+				     pkts_pending);
 		if (!pkts_available)
 			break;
 
 		pkts_processed = __octep_vf_oq_process_rx(oct, oq,
 							  pkts_available);
-		oq->pkts_pending -= pkts_processed;
+		pkts_pending = READ_ONCE(oq->pkts_pending);
+		WRITE_ONCE(oq->pkts_pending, (pkts_pending - pkts_processed));
 		total_pkts_processed += pkts_processed;
 	}
 
-- 
2.47.0


