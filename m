Return-Path: <netdev+bounces-146828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CEC9D621B
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 17:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BB85B28449
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 16:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7731E00A6;
	Fri, 22 Nov 2024 16:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="D9BeO6ly"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC42148FF3;
	Fri, 22 Nov 2024 16:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732292468; cv=none; b=FuayS7Je3CH60OLO6YVOpe+cSezUJ8NEOrLhbXrwz2pkEzw1+GIduJUPBXOGCablrxTnAnE9K5c7ShjTXHSZoQWTsO1yXai7h+CtatndSSxccJTZAq2hZQVvymHesioRVHQ1ohvDQx6ixSmUA/VTdjod8F0IuEZXyRhY/nqLViM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732292468; c=relaxed/simple;
	bh=fZLyvc8Mr3kY+7lbiuMhW2nzS7i46QgYlcLKem/UDo0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b8D+sd9rq0gfwlVAGMLgF0Fo4uW5A28b1ACAys6EO+cUzlK2wvjem3rHzwfzyVY/H3g4tL4N4ObivbJdt6vlDDU8mrvHjHRGfpvZMM89Bf+eJMsn6bzq5dUmhPWojXm2d5J9eavCvhG+84FWTe8TKOTpVQ2ZEqt8GAFoTteloqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=D9BeO6ly; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMFTltK020253;
	Fri, 22 Nov 2024 08:20:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=BBAIoC3V0i+u1r1VWXvbB7kdO
	BnbP3lNDPGnmZ/fHp0=; b=D9BeO6lyeWUSXowTXqk6IdOt6vLZM/6+eHfL0b9Ve
	9/t4GYNbv2C/pmYJ+Z3Xa9rPr20vI0h9FR9d++FihNOYelOk2ERk6iIR9MWMtxg4
	vp0EmYSgEoTbcX8C1WVUoKWFxEbyBcRsfnaAo3xVTAujvy5X2E2xRLTTyDIi2PSx
	H5Qxq4t5+UGH8YJ8+/wdCfnVrISrjmhNIZ7Gp4Pw53AfQk3AC9arBlRANxjQOxrR
	XrjOagMcm1oNXkq2w3u6Lqyzjhjlc8SNfQ1F03FjkeMrFnsYgTWjQw3kSBSqMGRq
	wlnMezmLU7VZnrtzdEzFbzn3bcpgAr3LZvG0psLTUff/A==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 432ryyrmy2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 08:20:57 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 22 Nov 2024 08:20:55 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 22 Nov 2024 08:20:55 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 02BF13F7080;
	Fri, 22 Nov 2024 08:20:50 -0800 (PST)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <lcherian@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>
Subject: [net 3/5] octeontx2-af: RPM: fix stale RSFEC counters
Date: Fri, 22 Nov 2024 21:50:33 +0530
Message-ID: <20241122162035.5842-4-hkelam@marvell.com>
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
X-Proofpoint-GUID: ynrNGktEZeLFHghsbxByVDFdygPKMfE9
X-Proofpoint-ORIG-GUID: ynrNGktEZeLFHghsbxByVDFdygPKMfE9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

The earlier patch sets the 'Stats control register' for RPM
receive/transmit statistics instead of RSFEC statistics,
causing the driver to return stale FEC counters.

Fixes: 84ad3642115d ("octeontx2-af: Add FEC stats for RPM/RPM_USX block")
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rpm.c | 13 +++++++++----
 drivers/net/ethernet/marvell/octeontx2/af/rpm.h |  4 +++-
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rpm.c b/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
index 22dd50a3fcd3..70629f94c27e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
@@ -699,6 +699,10 @@ int rpm_get_fec_stats(void *rpmd, int lmac_id, struct cgx_fec_stats_rsp *rsp)
 	if (rpm->lmac_idmap[lmac_id]->link_info.fec == OTX2_FEC_NONE)
 		return 0;
 
+	/* latched registers FCFECX_CW_HI/RSFEC_STAT_FAST_DATA_HI_CDC are common
+	 * for all counters. Acquire lock to ensure serialized reads
+	 */
+	mutex_lock(&rpm->lock);
 	if (rpm->lmac_idmap[lmac_id]->link_info.fec == OTX2_FEC_BASER) {
 		val_lo = rpm_read(rpm, lmac_id, RPMX_MTI_FCFECX_VL0_CCW_LO);
 		val_hi = rpm_read(rpm, lmac_id, RPMX_MTI_FCFECX_CW_HI);
@@ -725,20 +729,21 @@ int rpm_get_fec_stats(void *rpmd, int lmac_id, struct cgx_fec_stats_rsp *rsp)
 		}
 	} else {
 		/* enable RS-FEC capture */
-		cfg = rpm_read(rpm, 0, RPMX_MTI_STAT_STATN_CONTROL);
+		cfg = rpm_read(rpm, 0, RPMX_MTI_RSFEC_STAT_STATN_CONTROL);
 		cfg |= RPMX_RSFEC_RX_CAPTURE | BIT(lmac_id);
-		rpm_write(rpm, 0, RPMX_MTI_STAT_STATN_CONTROL, cfg);
+		rpm_write(rpm, 0, RPMX_MTI_RSFEC_STAT_STATN_CONTROL, cfg);
 
 		val_lo = rpm_read(rpm, 0,
 				  RPMX_MTI_RSFEC_STAT_COUNTER_CAPTURE_2);
-		val_hi = rpm_read(rpm, 0, RPMX_MTI_STAT_DATA_HI_CDC);
+		val_hi = rpm_read(rpm, 0, RPMX_MTI_RSFEC_STAT_FAST_DATA_HI_CDC);
 		rsp->fec_corr_blks = (val_hi << 32 | val_lo);
 
 		val_lo = rpm_read(rpm, 0,
 				  RPMX_MTI_RSFEC_STAT_COUNTER_CAPTURE_3);
-		val_hi = rpm_read(rpm, 0, RPMX_MTI_STAT_DATA_HI_CDC);
+		val_hi = rpm_read(rpm, 0, RPMX_MTI_RSFEC_STAT_FAST_DATA_HI_CDC);
 		rsp->fec_uncorr_blks = (val_hi << 32 | val_lo);
 	}
+	mutex_unlock(&rpm->lock);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rpm.h b/drivers/net/ethernet/marvell/octeontx2/af/rpm.h
index 34b11deb0f3c..a5773fbacaff 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rpm.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rpm.h
@@ -84,9 +84,11 @@
 /* FEC stats */
 #define RPMX_MTI_STAT_STATN_CONTROL			0x10018
 #define RPMX_MTI_STAT_DATA_HI_CDC			0x10038
-#define RPMX_RSFEC_RX_CAPTURE				BIT_ULL(27)
+#define RPMX_RSFEC_RX_CAPTURE				BIT_ULL(28)
 #define RPMX_CMD_CLEAR_RX				BIT_ULL(30)
 #define RPMX_CMD_CLEAR_TX				BIT_ULL(31)
+#define RPMX_MTI_RSFEC_STAT_STATN_CONTROL               0x40018
+#define RPMX_MTI_RSFEC_STAT_FAST_DATA_HI_CDC            0x40000
 #define RPMX_MTI_RSFEC_STAT_COUNTER_CAPTURE_2		0x40050
 #define RPMX_MTI_RSFEC_STAT_COUNTER_CAPTURE_3		0x40058
 #define RPMX_MTI_FCFECX_VL0_CCW_LO			0x38618
-- 
2.34.1


