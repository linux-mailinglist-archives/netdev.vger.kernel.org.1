Return-Path: <netdev+bounces-245506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 191ACCCF4CD
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 11:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D32C530BC84A
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 10:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2746F2FFDF9;
	Fri, 19 Dec 2025 10:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ZaPwloJ/"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6C52FF158;
	Fri, 19 Dec 2025 10:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766138907; cv=none; b=rr8yCn0p+0AyLRj0YWKyppPUQlI4t88HUj90sAM7wlGr09U/PJt4JP5JK6haYXthp87Ne2NVTXIm1u518qpaAiBEA28lczQk23MnM16p9t9eeIcmkDf4wOwD98cxekP1rKrfnNfRqd1NNi+PokJMck9VEkOI8iXo504FSqVqPTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766138907; c=relaxed/simple;
	bh=B6awmfP7W39BTa6HiqTmm7eoI3kaxp/cRo/PkqKodBY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aYkfVqe7Bgg37FeIpzlfhRzCNW/qPhHXmTe5C9pbtypeY/7YOCbhqeDOjsPXdm9yru8QkWqihxk8slPIkTWNdY60DgU41PwGEdj3tOlCDP+MiZ4QjcMFWxzJMoX0vDiH8sV0hRz6KK01G6IwWSZVCAHUdZ+AXpnYWM5snot/IGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ZaPwloJ/; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BIJjVOG749067;
	Fri, 19 Dec 2025 02:08:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=J
	+xl2YPiogHJLOrjwhmAtEzTCwe4vF4uqPN6aMy4kmw=; b=ZaPwloJ/vd+6L6Jnn
	NlgzPLZre9ly4UiddaQooRM1ViS1OXAQq9y0g1d398BzumAdsNLIDT0kjkDdOmfg
	2ej1Ls1di/KwgfDPsb3bWrjJEuW59dPANu/8s6RMrpFugMhgDavx7fJZhwdE8Anw
	jLr4a2H37WmZZ5N/0MmgZwDj4qgpkJ9eXiMtNLJbqH5XKe06WvXI0Z3RN7/tPR64
	9uC325OClcTpRCpbkCXJOZ0hNrsRcvAVT3X8hKTj1AsKrZT5K9e/h3GM4rOcYMUi
	5tU09NPeqXrUOpsndVv7U6Qq9lHQT/060MhrEm3A8SUms2HMX0vPxpTtFquTzcr0
	DirVw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4b4r249gfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Dec 2025 02:08:17 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 19 Dec 2025 02:08:29 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 19 Dec 2025 02:08:29 -0800
Received: from sapphire1.sclab.marvell.com (unknown [10.111.132.245])
	by maili.marvell.com (Postfix) with ESMTP id 08E785B6962;
	Fri, 19 Dec 2025 02:08:16 -0800 (PST)
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
Subject: [PATCH net v2 3/3] octeon_ep_vf: ensure dbell BADDR updation
Date: Fri, 19 Dec 2025 10:07:49 +0000
Message-ID: <20251219100751.3063135-4-vimleshk@marvell.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251219100751.3063135-1-vimleshk@marvell.com>
References: <20251219100751.3063135-1-vimleshk@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=csSWUl4i c=1 sm=1 tr=0 ts=69452411 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=9s7rcsES4n5jIWhP9eIA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDA4MyBTYWx0ZWRfX5dNWPQgI1KvM
 5odDQj7o690Y4u282pbhwxsU3PMyiJAzg47oZTt5bggi6XuIdD9zk78kSfqfxymg1RsWELNZPFY
 chPlTBf3sZ+x96Iw2ivgDBbicyC0YU5uyI1K2ETQuACjBc4HhHirnusbPoNhOpHhJ+HxcUETxph
 vaZbUeuZe8iYxDQQrojS6MSWJRxxzS8NAEsg7Zlacg2rWlELq3G2m3ESVIeFeSvFcDrzNoPaQ8d
 xB7fWIamGNCt+qIfZwz9KvWcIk8FC2n/Z84iMmag18Fs67al5O/njJsJk+QJQoEe/bnx41xxkyQ
 VEaBghe1wGz3iFQFiT+Ay/KEhlER7ATNcXmMokBjb8FWADHLmhaWGcga7KgMRR20krPE0MVyr0C
 B9DQ3iTPtQ1T7mlCt5I1gGjg+9rwSGFpQrh3i1rBlZkAfBu5t1nqNfLA5KbidOoKcuSGXASmkr1
 yBPLzj+MkIiu5tiOZaQ==
X-Proofpoint-ORIG-GUID: NBSaBuKmIkB09m6-E7OVcMvljmKyoEON
X-Proofpoint-GUID: NBSaBuKmIkB09m6-E7OVcMvljmKyoEON
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_03,2025-12-17_02,2025-10-01_01

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
V2:
- Format code to avoid line exceeding 80 columns.
- Use ULLONG_MAX and return standard err code.
- Place limit to unbounded loop by adding timeout.

V1: https://lore.kernel.org/all/20251212122304.2562229-4-vimleshk@marvell.com/

 .../marvell/octeon_ep_vf/octep_vf_cn9k.c      |  3 +-
 .../marvell/octeon_ep_vf/octep_vf_cnxk.c      | 36 +++++++++++++++++--
 .../marvell/octeon_ep_vf/octep_vf_main.h      |  2 +-
 .../marvell/octeon_ep_vf/octep_vf_rx.c        |  4 ++-
 4 files changed, 39 insertions(+), 6 deletions(-)

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
index 1f79dfad42c6..3967d0e0de82 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cnxk.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cnxk.c
@@ -199,12 +199,14 @@ static void octep_vf_setup_iq_regs_cnxk(struct octep_vf_device *oct, int iq_no)
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
+	unsigned long t_out_jiffies;
 
 	reg_val = octep_vf_read_csr64(oct, CNXK_VF_SDP_R_OUT_CONTROL(oq_no));
 
@@ -214,6 +216,35 @@ static void octep_vf_setup_oq_regs_cnxk(struct octep_vf_device *oct, int oq_no)
 			reg_val = octep_vf_read_csr64(oct, CNXK_VF_SDP_R_OUT_CONTROL(oq_no));
 		} while (!(reg_val & CNXK_VF_R_OUT_CTL_IDLE));
 	}
+	octep_vf_write_csr64(oct, CNXK_VF_SDP_R_OUT_WMARK(oq_no),
+			     oq->max_count);
+	/* Wait for WMARK to get applied */
+	usleep_range(10, 15);
+
+	octep_vf_write_csr64(oct, CNXK_VF_SDP_R_OUT_SLIST_BADDR(oq_no),
+			     oq->desc_ring_dma);
+	octep_vf_write_csr64(oct, CNXK_VF_SDP_R_OUT_SLIST_RSIZE(oq_no),
+			     oq->max_count);
+	reg_ba_val = octep_vf_read_csr64(oct,
+					 CNXK_VF_SDP_R_OUT_SLIST_BADDR(oq_no));
+	if (reg_ba_val != oq->desc_ring_dma) {
+		t_out_jiffies = jiffies + 10 * HZ;
+		do {
+			if (reg_ba_val == ULLONG_MAX)
+				return -EFAULT;
+			octep_vf_write_csr64(oct,
+					     CNXK_VF_SDP_R_OUT_SLIST_BADDR
+					     (oq_no), oq->desc_ring_dma);
+			octep_vf_write_csr64(oct,
+					     CNXK_VF_SDP_R_OUT_SLIST_RSIZE
+					     (oq_no), oq->max_count);
+			reg_ba_val =
+			octep_vf_read_csr64(oct,
+					    CNXK_VF_SDP_R_OUT_SLIST_BADDR
+					    (oq_no));
+		} while ((reg_ba_val != oq->desc_ring_dma) &&
+			  time_before(jiffies, t_out_jiffies));
+	}
 
 	reg_val &= ~(CNXK_VF_R_OUT_CTL_IMODE);
 	reg_val &= ~(CNXK_VF_R_OUT_CTL_ROR_P);
@@ -227,8 +258,6 @@ static void octep_vf_setup_oq_regs_cnxk(struct octep_vf_device *oct, int oq_no)
 	reg_val |= (CNXK_VF_R_OUT_CTL_ES_P);
 
 	octep_vf_write_csr64(oct, CNXK_VF_SDP_R_OUT_CONTROL(oq_no), reg_val);
-	octep_vf_write_csr64(oct, CNXK_VF_SDP_R_OUT_SLIST_BADDR(oq_no), oq->desc_ring_dma);
-	octep_vf_write_csr64(oct, CNXK_VF_SDP_R_OUT_SLIST_RSIZE(oq_no), oq->max_count);
 
 	oq_ctl = octep_vf_read_csr64(oct, CNXK_VF_SDP_R_OUT_CONTROL(oq_no));
 	/* Clear the ISIZE and BSIZE (22-0) */
@@ -250,6 +279,7 @@ static void octep_vf_setup_oq_regs_cnxk(struct octep_vf_device *oct, int oq_no)
 	reg_val &= ~GENMASK_ULL(31, 0);
 	reg_val |= CFG_GET_OQ_WMARK(oct->conf);
 	octep_vf_write_csr64(oct, CNXK_VF_SDP_R_OUT_WMARK(oq_no), reg_val);
+	return 0;
 }
 
 /* Setup registers for a VF mailbox */
diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.h b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.h
index b9f13506f462..c74cd2369e90 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.h
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.h
@@ -55,7 +55,7 @@ struct octep_vf_mmio {
 
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


