Return-Path: <netdev+bounces-146830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9129D6250
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 17:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C10EB22FA7
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 16:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C201E0B7F;
	Fri, 22 Nov 2024 16:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="VU8qpQQU"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60921E04BD;
	Fri, 22 Nov 2024 16:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732292472; cv=none; b=KdZ+Acy386Fu52RWUV7nxaRuRciLHeqs5DImybepHjpIFjRz2H/bnkI0gdEBI/sJhHUVlAQ7PtZC9O+XxKGby9uFCaLnnksnlSa1BMJ9kkn6fKf7b340zlqOVp/ehTYyYLjbju3xxyv7JTT++oXHrGfvNR4NOOE6OfL0pfOq5ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732292472; c=relaxed/simple;
	bh=Un/Gk2pTsjWi7RNzlMUNCyn8NqY3KpOLAlWRtyxxwTI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MlvPJXauvqyFan+b+1DJmXlD1CN2khkxfcE9qL0TJxa6Tz7pn1SvO4ouA1NHGqog7CpOsEkzgRqeISF1O1IDfFUK2F9g7V5O8AVKhJNwrbskPJn+mtrLjimgDC29nqeIB3fsFr1G1Tq9U/aKG9JoXLQYqR/thedF52oq1BCqJ4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=VU8qpQQU; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMCwcaV008223;
	Fri, 22 Nov 2024 08:21:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=tWxl63UOtmPeGeBbZ0DmuIo+z
	FBQdY8yc27guD0PWvE=; b=VU8qpQQU9PkbYmAP/lrRyM4JNN0KlXzRzl3AapMiu
	rgC4OLcjWpEvcFoZPPtLBZa7qefUP71sXHYyIWd2v2Qh0VdYPIjYLKGwKTZo3p9q
	W2AUkZazhgIruBIIBv2GNoVAH5ihVRAkDYlTWdQ1wkfrrGE/hGdKtyN3+Ir7X40S
	KGOv5eN/LyPDi5JVmWHaMQ4LJf9hCoMHaQLkcx7HrPfTV+X6jOqBbqXVmdHAFCaK
	62qRGT5J8ftprb2A8e35eQ0idTwX2l3YaRUFPBy/odPrznPzi329o4ZpFQ+kn3/j
	CbS79cngVqBxM3St7ICGcn/qth7EyegHd153vyPf5iFXA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 432tdwgfxk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 08:21:01 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 22 Nov 2024 08:21:00 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 22 Nov 2024 08:21:00 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id A46983F7080;
	Fri, 22 Nov 2024 08:20:55 -0800 (PST)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <lcherian@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>
Subject: [net 4/5] octeontx2-af: RPM: fix stale FCFEC counters
Date: Fri, 22 Nov 2024 21:50:34 +0530
Message-ID: <20241122162035.5842-5-hkelam@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241122162035.5842-1-hkelam@marvell.com>
References: <20241122162035.5842-1-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Syd2y1eIjcU_Y9qLc_3sZkagL0F24W6-
X-Proofpoint-GUID: Syd2y1eIjcU_Y9qLc_3sZkagL0F24W6-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

The corrected words register(FCFECX_VL0_CCW_LO)/Uncorrected words
register (FCFECX_VL0_NCCW_LO) of FCFEC counter has different LMAC
offset which needs to be accessed differently.

Fixes: 84ad3642115d ("octeontx2-af: Add FEC stats for RPM/RPM_USX block")
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/rpm.c   | 24 +++++++++----------
 .../net/ethernet/marvell/octeontx2/af/rpm.h   | 10 ++++----
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rpm.c b/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
index 70629f94c27e..e97fcc51d7f2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
@@ -704,27 +704,27 @@ int rpm_get_fec_stats(void *rpmd, int lmac_id, struct cgx_fec_stats_rsp *rsp)
 	 */
 	mutex_lock(&rpm->lock);
 	if (rpm->lmac_idmap[lmac_id]->link_info.fec == OTX2_FEC_BASER) {
-		val_lo = rpm_read(rpm, lmac_id, RPMX_MTI_FCFECX_VL0_CCW_LO);
-		val_hi = rpm_read(rpm, lmac_id, RPMX_MTI_FCFECX_CW_HI);
+		val_lo = rpm_read(rpm, 0, RPMX_MTI_FCFECX_VL0_CCW_LO(lmac_id));
+		val_hi = rpm_read(rpm, 0, RPMX_MTI_FCFECX_CW_HI(lmac_id));
 		rsp->fec_corr_blks = (val_hi << 16 | val_lo);
 
-		val_lo = rpm_read(rpm, lmac_id, RPMX_MTI_FCFECX_VL0_NCCW_LO);
-		val_hi = rpm_read(rpm, lmac_id, RPMX_MTI_FCFECX_CW_HI);
+		val_lo = rpm_read(rpm, 0, RPMX_MTI_FCFECX_VL0_NCCW_LO(lmac_id));
+		val_hi = rpm_read(rpm, 0, RPMX_MTI_FCFECX_CW_HI(lmac_id));
 		rsp->fec_uncorr_blks = (val_hi << 16 | val_lo);
 
 		/* 50G uses 2 Physical serdes lines */
 		if (rpm->lmac_idmap[lmac_id]->link_info.lmac_type_id ==
 		    LMAC_MODE_50G_R) {
-			val_lo = rpm_read(rpm, lmac_id,
-					  RPMX_MTI_FCFECX_VL1_CCW_LO);
-			val_hi = rpm_read(rpm, lmac_id,
-					  RPMX_MTI_FCFECX_CW_HI);
+			val_lo = rpm_read(rpm, 0,
+					  RPMX_MTI_FCFECX_VL1_CCW_LO(lmac_id));
+			val_hi = rpm_read(rpm, 0,
+					  RPMX_MTI_FCFECX_CW_HI(lmac_id));
 			rsp->fec_corr_blks += (val_hi << 16 | val_lo);
 
-			val_lo = rpm_read(rpm, lmac_id,
-					  RPMX_MTI_FCFECX_VL1_NCCW_LO);
-			val_hi = rpm_read(rpm, lmac_id,
-					  RPMX_MTI_FCFECX_CW_HI);
+			val_lo = rpm_read(rpm, 0,
+					  RPMX_MTI_FCFECX_VL1_NCCW_LO(lmac_id));
+			val_hi = rpm_read(rpm, 0,
+					  RPMX_MTI_FCFECX_CW_HI(lmac_id));
 			rsp->fec_uncorr_blks += (val_hi << 16 | val_lo);
 		}
 	} else {
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rpm.h b/drivers/net/ethernet/marvell/octeontx2/af/rpm.h
index a5773fbacaff..5194fec4c3b8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rpm.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rpm.h
@@ -91,11 +91,11 @@
 #define RPMX_MTI_RSFEC_STAT_FAST_DATA_HI_CDC            0x40000
 #define RPMX_MTI_RSFEC_STAT_COUNTER_CAPTURE_2		0x40050
 #define RPMX_MTI_RSFEC_STAT_COUNTER_CAPTURE_3		0x40058
-#define RPMX_MTI_FCFECX_VL0_CCW_LO			0x38618
-#define RPMX_MTI_FCFECX_VL0_NCCW_LO			0x38620
-#define RPMX_MTI_FCFECX_VL1_CCW_LO			0x38628
-#define RPMX_MTI_FCFECX_VL1_NCCW_LO			0x38630
-#define RPMX_MTI_FCFECX_CW_HI				0x38638
+#define RPMX_MTI_FCFECX_VL0_CCW_LO(a)			(0x38618 + ((a) * 0x40))
+#define RPMX_MTI_FCFECX_VL0_NCCW_LO(a)			(0x38620 + ((a) * 0x40))
+#define RPMX_MTI_FCFECX_VL1_CCW_LO(a)			(0x38628 + ((a) * 0x40))
+#define RPMX_MTI_FCFECX_VL1_NCCW_LO(a)			(0x38630 + ((a) * 0x40))
+#define RPMX_MTI_FCFECX_CW_HI(a)			(0x38638 + ((a) * 0x40))
 
 /* CN10KB CSR Declaration */
 #define  RPM2_CMRX_SW_INT				0x1b0
-- 
2.34.1


