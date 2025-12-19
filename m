Return-Path: <netdev+bounces-245505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A8ACCF470
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 11:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F31E23020812
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 10:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F012FBE1D;
	Fri, 19 Dec 2025 10:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="fOeeX+kI"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332092C21F9;
	Fri, 19 Dec 2025 10:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766138903; cv=none; b=EecXGrREMgL/PcdtGuEsk8c7zW+MbggygOgwm4m2OvDBKyxwQQtW8rr1EhWloqhI9rmMrEtXpIZbkm/4oj+mLZYk2fGEUig/IvJWs+13R8gj/Zo9IsKNIKP3gw3CPaodynZw4u+niwfXP5BDDZaaji0Cy++E/hiOPL7fIzHfXUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766138903; c=relaxed/simple;
	bh=phcE4pLrkiFcS6TPtBbMrb4pi8h8/MM88EUCP6phBjo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uiRCnM0gtJDAVVRveQ9VbOIvWGtgmZ5rRZG5QdqdK/mEMLD95YNpo8lVxTBmHwDs+m/kKXx2IGQWX3kTmWJpHdgnEjEeg55JkmGUL21iUDMDEzjtZX+IA5yZdZBhtIxuq/IQYpo5TbOrtEStlTSZ3Rk8zl8CXGL+QgVQR5su8+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=fOeeX+kI; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BIJkNor750231;
	Fri, 19 Dec 2025 02:08:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=q
	N8EfDBhKvaMzQDTRgW7wRK9/yKmw7nRQCFiljnT2Uk=; b=fOeeX+kIk2vvB9bRX
	tW8D+7s8vUodSisRRy70gWMldwjf40UYuQXSeNCzr1lHz/NN5AlJEJlbgmuCUBSb
	BnMhkXpXUIRbpFui3aUaptVUUO/QzYqEgrH+ub72uo5i3gDbF8k8gUeKSKnqUMCm
	ZBI/ANI29tf/vwyt01v50hQcfTBlgeIffXgQrvDrdJYN35SugDSspSkpNytOpT2X
	eP4RQVa2l501JQa9rPm5vevvkTT4QYxrQ3DyBhneV2qr84hn+16G+FQBgdIraCft
	lPvnQMhA3uXcsGC/PXRqS3HVL0RRKycHA+ZK+XTJi0OBBkVMTq2fT8s1hD7RpxDH
	dNDYA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4b4r249gf6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Dec 2025 02:08:13 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 19 Dec 2025 02:08:12 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 19 Dec 2025 02:08:12 -0800
Received: from sapphire1.sclab.marvell.com (unknown [10.111.132.245])
	by maili.marvell.com (Postfix) with ESMTP id 53EE95B695F;
	Fri, 19 Dec 2025 02:08:12 -0800 (PST)
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
Subject: [PATCH net v2 2/3] octeon_ep: ensure dbell BADDR updation
Date: Fri, 19 Dec 2025 10:07:48 +0000
Message-ID: <20251219100751.3063135-3-vimleshk@marvell.com>
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
X-Authority-Analysis: v=2.4 cv=csSWUl4i c=1 sm=1 tr=0 ts=6945240d cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=HhD5TD71VMN5Ao0PvCkA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDA4MyBTYWx0ZWRfX+6oSOrbSk8ol
 XfZkXHj2j9zoRsWUfXwjbDIZ4KhP6VNXGAMWQIES5OwyfkyVw6PsHw9v7bXBORIXD/E7e1klMFD
 K+05iGzbX2Ir1SoGpy7lP1ScdYuRWTRJt4YkZUJ3gyGhpS7ArTy3+ji4oBvTGvnMDxMotd5dhED
 SHupjlsRqAgVyIay1v3AaqbxbH8T84b1uFNE+XzP3A61/YnoLxzso9Skk6wAwrjnzw5kW8wiYR9
 hQ1/AREC4qjTX3CCpYg1ifii8WBL3+5JtWdCt6+200x/Vo3iPQnTGdL1lVfDpxMz2zoQar1e4Ph
 a78nNLksooM4cL3kWgazIi9i8v0V8Yi+4ubdP5e0z1HbnE52LW9J+TRNyQfk2lTZWS7iOqFqwyp
 ZBrdh7bW9VmJk/TYGCk+IT9Bpg9AQwmX2zbzKa+eXvGBknISgOW04XEiWwxfs91KXrwjCnreH70
 LQV+mSF7FZtxr+H01Fg==
X-Proofpoint-ORIG-GUID: fGJzaPfb-agJfGcwel6bXHnxQ88xiN8c
X-Proofpoint-GUID: fGJzaPfb-agJfGcwel6bXHnxQ88xiN8c
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

Fixes: 0807dc76f3bf5 ("octeon_ep: support Octeon CN10K devices")
Signed-off-by: Sathesh Edara <sedara@marvell.com>
Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
Signed-off-by: Vimlesh Kumar <vimleshk@marvell.com>
---
V2:
- Format code to avoid line exceeding 80 columns.
- Use ULLONG_MAX and return standard err code.
- Place limit to unbounded loop by adding timeout.

V1: https://lore.kernel.org/all/20251212122304.2562229-3-vimleshk@marvell.com/

 .../marvell/octeon_ep/octep_cn9k_pf.c         |  3 +-
 .../marvell/octeon_ep/octep_cnxk_pf.c         | 37 ++++++++++++++++---
 .../ethernet/marvell/octeon_ep/octep_main.h   |  2 +-
 .../net/ethernet/marvell/octeon_ep/octep_rx.c |  4 +-
 4 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c b/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
index 2574a6061e3d..2a5cebbf1ff8 100644
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
index 73cd0ca758f0..1ca8da3f7dc7 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c
@@ -8,6 +8,7 @@
 #include <linux/pci.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
+#include <linux/jiffies.h>
 
 #include "octep_config.h"
 #include "octep_main.h"
@@ -327,11 +328,13 @@ static void octep_setup_iq_regs_cnxk_pf(struct octep_device *oct, int iq_no)
 }
 
 /* Setup registers for a hardware Rx Queue  */
-static void octep_setup_oq_regs_cnxk_pf(struct octep_device *oct, int oq_no)
+static int octep_setup_oq_regs_cnxk_pf(struct octep_device *oct, int oq_no)
 {
 	u64 reg_val;
 	u64 oq_ctl = 0ULL;
+	u64 reg_ba_val;
 	u32 time_threshold = 0;
+	unsigned long t_out_jiffies;
 	struct octep_oq *oq = oct->oq[oq_no];
 
 	oq_no += CFG_GET_PORTS_PF_SRN(oct->conf);
@@ -343,6 +346,33 @@ static void octep_setup_oq_regs_cnxk_pf(struct octep_device *oct, int oq_no)
 			reg_val = octep_read_csr64(oct, CNXK_SDP_R_OUT_CONTROL(oq_no));
 		} while (!(reg_val & CNXK_R_OUT_CTL_IDLE));
 	}
+	octep_write_csr64(oct, CNXK_SDP_R_OUT_WMARK(oq_no),  oq->max_count);
+	/* Wait for WMARK to get applied */
+	usleep_range(10, 15);
+
+	octep_write_csr64(oct, CNXK_SDP_R_OUT_SLIST_BADDR(oq_no),
+			  oq->desc_ring_dma);
+	octep_write_csr64(oct, CNXK_SDP_R_OUT_SLIST_RSIZE(oq_no),
+			  oq->max_count);
+	reg_ba_val = octep_read_csr64(oct, CNXK_SDP_R_OUT_SLIST_BADDR(oq_no));
+
+	if (reg_ba_val != oq->desc_ring_dma) {
+		t_out_jiffies = jiffies + 10 * HZ;
+		do {
+			if (reg_ba_val == ULLONG_MAX)
+				return -EFAULT;
+			octep_write_csr64(oct,
+					  CNXK_SDP_R_OUT_SLIST_BADDR(oq_no),
+					  oq->desc_ring_dma);
+			octep_write_csr64(oct,
+					  CNXK_SDP_R_OUT_SLIST_RSIZE(oq_no),
+					  oq->max_count);
+			reg_ba_val =
+			octep_read_csr64(oct,
+					 CNXK_SDP_R_OUT_SLIST_BADDR(oq_no));
+		} while ((reg_ba_val != oq->desc_ring_dma) &&
+			  time_before(jiffies, t_out_jiffies));
+	}
 
 	reg_val &= ~(CNXK_R_OUT_CTL_IMODE);
 	reg_val &= ~(CNXK_R_OUT_CTL_ROR_P);
@@ -356,10 +386,6 @@ static void octep_setup_oq_regs_cnxk_pf(struct octep_device *oct, int oq_no)
 	reg_val |= (CNXK_R_OUT_CTL_ES_P);
 
 	octep_write_csr64(oct, CNXK_SDP_R_OUT_CONTROL(oq_no), reg_val);
-	octep_write_csr64(oct, CNXK_SDP_R_OUT_SLIST_BADDR(oq_no),
-			  oq->desc_ring_dma);
-	octep_write_csr64(oct, CNXK_SDP_R_OUT_SLIST_RSIZE(oq_no),
-			  oq->max_count);
 
 	oq_ctl = octep_read_csr64(oct, CNXK_SDP_R_OUT_CONTROL(oq_no));
 
@@ -385,6 +411,7 @@ static void octep_setup_oq_regs_cnxk_pf(struct octep_device *oct, int oq_no)
 	reg_val &= ~0xFFFFFFFFULL;
 	reg_val |= CFG_GET_OQ_WMARK(oct->conf);
 	octep_write_csr64(oct, CNXK_SDP_R_OUT_WMARK(oq_no), reg_val);
+	return 0;
 }
 
 /* Setup registers for a PF mailbox */
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.h b/drivers/net/ethernet/marvell/octeon_ep/octep_main.h
index 81ac4267811c..35d0ff289a70 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.h
@@ -77,7 +77,7 @@ struct octep_pci_win_regs {
 
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


