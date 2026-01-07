Return-Path: <netdev+bounces-247735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A73B5CFDF24
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 14:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 929B030B7568
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 13:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E71E32939F;
	Wed,  7 Jan 2026 13:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="HTqDTlgu"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1470C328B5B;
	Wed,  7 Jan 2026 13:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767791964; cv=none; b=ChLNWY2LjbOu4+ubVUJKI6Nl8xkpzVLiq/yAu/GEysLnB2v6eb1tLhGDP1e90e0yunNOTf0gJP6O9b37CO1vEBwq1Ssp+xkM6kUBQVVIWqfQh9Yi8ymjYumcMHY4hE3ZfLqeAM7IDkQSPrcP5O+mVFiFHwLpZpWjBO4QhNan+8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767791964; c=relaxed/simple;
	bh=gsKC0zaiIawdpqHIM2SJnRUt8D2667wj6rp34hRdTaI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QcTRzytlDy9QcpbumMpG0UsA7bSQaN/yeFcJR4gDHe72a1YG2+4K6fhPxLvaDA7oi4opJWRCLZ5+jYyKNvavKFCmeVyhOCZO0GKmTQsqjKmr3vFtuLwQXPPsunYVMj470cA/E6MbN6lxwGgAzOFLK7yUTk5IzgvuOW/9EGsT9Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=HTqDTlgu; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 607BjkvT2113136;
	Wed, 7 Jan 2026 05:19:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=I
	A4Z9AZGj6MgXH+XaiZrFZxX4YjzVClXqMqL5rUA8j0=; b=HTqDTlguZ5IvPx7cw
	Un0LGHukHgXpoUOEcy3406B3O9gLF3iqKVjNLuQSVpqvpeRTMq5daGsOY932FoYr
	skngZ3nZid44shDm7atAAfy3AUqsFMMrtaGn5POZVbfLuX3AN+qCy//vcm2fE5zf
	RF4mrd29vwZ8k6GphnnDYS4quwBmr9hht6nKbT+SbHNGeRGm//CFTeUBjXpgKgZk
	yewPxnpeCyS0izNj67sNLXiKV4dMwy+pcAPMtqtNNI8mtqtJ3q0n95munsxLDgZJ
	1xW6dDbaZIiwKTb0ugIOu4+IUcQm0sJrizuAO0yIlwE15C3vePUrnGBX2JWQ2zR+
	UlS5Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bhc3n1bcd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Jan 2026 05:19:12 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 7 Jan 2026 05:19:11 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 7 Jan 2026 05:19:11 -0800
Received: from sapphire1.sclab.marvell.com (unknown [10.111.132.245])
	by maili.marvell.com (Postfix) with ESMTP id B67933F704A;
	Wed,  7 Jan 2026 05:19:10 -0800 (PST)
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
        "Paolo Abeni" <pabeni@redhat.com>,
        Satananda Burla
	<sburla@marvell.com>,
        "Abhijit Ayarekar" <aayarekar@marvell.com>
Subject: [PATCH net v3 1/3] octeon_ep: disable per ring interrupts
Date: Wed, 7 Jan 2026 13:18:54 +0000
Message-ID: <20260107131857.3434352-2-vimleshk@marvell.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260107131857.3434352-1-vimleshk@marvell.com>
References: <20260107131857.3434352-1-vimleshk@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 4Zggx9QfxoO52tEzBqQXZtQWSXesDyAj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDEwMiBTYWx0ZWRfX6MNz5A9Du/pN
 1Lz9no9wQilq6phm0yRzwenpJmsSytpegYs9kEDBipYHHpl1GDMBnfXru1oMAyo7e2TzFZAUe1X
 9INUeTAaGaK+KZ2hcOrfadUXFZ+T1vmYwzBbV8bgRCJrlMLcmVzLCxpf06LCi3RsAwaQ4dYUE2o
 Ap9xynD6jAP8Tz6KwmomzujRl06fNTEeRDP2+wfsONrpxej6g192Hr8STjg4cciWrnbg0Gkzr/L
 T25giQ9YX3lzEbfv+n8J3s4acOsKcWXCvEyoAxOkAVqG4A8p8wzZbUony0SUhq1kaKOnA2NV/nH
 sll+tNKp2w7s7piu4sqq2GWo2pdrdIOlul8FwT+xEUlntoXwcBkctz76XZ94tKiQJP5kgsD5ZHL
 a5vgRPWfqVPiZZeNl14HqSe8q4i7tvL1+Q9Xsnmg5XuGE3ZZvQfepLMobQxsBfa7GvGV0BvVp49
 0yUNn/MnSHLVfqwDo8A==
X-Authority-Analysis: v=2.4 cv=EOILElZC c=1 sm=1 tr=0 ts=695e5d50 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=BjJIY8cOur314jIlsncA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 4Zggx9QfxoO52tEzBqQXZtQWSXesDyAj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_01,2026-01-06_01,2025-10-01_01

Disable the MSI-X per ring interrupt for every PF ring when PF
netdev goes down.

Fixes: 1f2c2d0cee023 ("octeon_ep: add hardware configuration APIs")
Signed-off-by: Sathesh Edara <sedara@marvell.com>
Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
Signed-off-by: Vimlesh Kumar <vimleshk@marvell.com>
---
V3:
- No change

V2: https://lore.kernel.org/all/20251219100751.3063135-2-vimleshk@marvell.com/

V1: https://lore.kernel.org/all/20251212122304.2562229-2-vimleshk@marvell.com/

 .../ethernet/marvell/octeon_ep/octep_cn9k_pf.c | 18 +++++++++++++++---
 .../ethernet/marvell/octeon_ep/octep_cnxk_pf.c | 18 +++++++++++++++---
 .../marvell/octeon_ep/octep_regs_cn9k_pf.h     |  1 +
 .../marvell/octeon_ep/octep_regs_cnxk_pf.h     |  1 +
 4 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c b/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
index b5805969404f..2574a6061e3d 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
@@ -696,14 +696,26 @@ static void octep_enable_interrupts_cn93_pf(struct octep_device *oct)
 /* Disable all interrupts */
 static void octep_disable_interrupts_cn93_pf(struct octep_device *oct)
 {
-	u64 intr_mask = 0ULL;
+	u64 reg_val, intr_mask = 0ULL;
 	int srn, num_rings, i;
 
 	srn = CFG_GET_PORTS_PF_SRN(oct->conf);
 	num_rings = CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf);
 
-	for (i = 0; i < num_rings; i++)
-		intr_mask |= (0x1ULL << (srn + i));
+	for (i = 0; i < num_rings; i++) {
+		intr_mask |= (BIT_ULL(srn + i));
+		reg_val = octep_read_csr64(oct,
+					   CN93_SDP_R_IN_INT_LEVELS(srn + i));
+		reg_val &= (~CN93_INT_ENA_BIT);
+		octep_write_csr64(oct,
+				  CN93_SDP_R_IN_INT_LEVELS(srn + i), reg_val);
+
+		reg_val = octep_read_csr64(oct,
+					   CN93_SDP_R_OUT_INT_LEVELS(srn + i));
+		reg_val &= (~CN93_INT_ENA_BIT);
+		octep_write_csr64(oct,
+				  CN93_SDP_R_OUT_INT_LEVELS(srn + i), reg_val);
+	}
 
 	octep_write_csr64(oct, CN93_SDP_EPF_IRERR_RINT_ENA_W1C, intr_mask);
 	octep_write_csr64(oct, CN93_SDP_EPF_ORERR_RINT_ENA_W1C, intr_mask);
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c b/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c
index 5de0b5ecbc5f..73cd0ca758f0 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c
@@ -720,14 +720,26 @@ static void octep_enable_interrupts_cnxk_pf(struct octep_device *oct)
 /* Disable all interrupts */
 static void octep_disable_interrupts_cnxk_pf(struct octep_device *oct)
 {
-	u64 intr_mask = 0ULL;
+	u64 reg_val, intr_mask = 0ULL;
 	int srn, num_rings, i;
 
 	srn = CFG_GET_PORTS_PF_SRN(oct->conf);
 	num_rings = CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf);
 
-	for (i = 0; i < num_rings; i++)
-		intr_mask |= (0x1ULL << (srn + i));
+	for (i = 0; i < num_rings; i++) {
+		intr_mask |= BIT_ULL(srn + i);
+		reg_val = octep_read_csr64(oct,
+					   CNXK_SDP_R_IN_INT_LEVELS(srn + i));
+		reg_val &= (~CNXK_INT_ENA_BIT);
+		octep_write_csr64(oct,
+				  CNXK_SDP_R_IN_INT_LEVELS(srn + i), reg_val);
+
+		reg_val = octep_read_csr64(oct,
+					   CNXK_SDP_R_OUT_INT_LEVELS(srn + i));
+		reg_val &= (~CNXK_INT_ENA_BIT);
+		octep_write_csr64(oct,
+				  CNXK_SDP_R_OUT_INT_LEVELS(srn + i), reg_val);
+	}
 
 	octep_write_csr64(oct, CNXK_SDP_EPF_IRERR_RINT_ENA_W1C, intr_mask);
 	octep_write_csr64(oct, CNXK_SDP_EPF_ORERR_RINT_ENA_W1C, intr_mask);
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cn9k_pf.h b/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cn9k_pf.h
index ca473502d7a0..42cb199bd085 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cn9k_pf.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cn9k_pf.h
@@ -386,5 +386,6 @@
 #define CN93_PEM_BAR4_INDEX            7
 #define CN93_PEM_BAR4_INDEX_SIZE       0x400000ULL
 #define CN93_PEM_BAR4_INDEX_OFFSET     (CN93_PEM_BAR4_INDEX * CN93_PEM_BAR4_INDEX_SIZE)
+#define CN93_INT_ENA_BIT	(BIT_ULL(62))
 
 #endif /* _OCTEP_REGS_CN9K_PF_H_ */
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cnxk_pf.h b/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cnxk_pf.h
index e637d7c8224d..9eaadded9c50 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cnxk_pf.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cnxk_pf.h
@@ -412,5 +412,6 @@
 #define CNXK_PEM_BAR4_INDEX		7
 #define CNXK_PEM_BAR4_INDEX_SIZE	0x400000ULL
 #define CNXK_PEM_BAR4_INDEX_OFFSET	(CNXK_PEM_BAR4_INDEX * CNXK_PEM_BAR4_INDEX_SIZE)
+#define CNXK_INT_ENA_BIT	(BIT_ULL(62))
 
 #endif /* _OCTEP_REGS_CNXK_PF_H_ */
-- 
2.47.0


