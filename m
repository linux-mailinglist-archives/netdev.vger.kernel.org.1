Return-Path: <netdev+bounces-42072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CACD37CD130
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 02:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 071A01C20430
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 00:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9AD15A6;
	Wed, 18 Oct 2023 00:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="hbjx+Dxl"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFB615A2
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 00:16:56 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BECE9F
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 17:16:55 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39I01lU6016120;
	Tue, 17 Oct 2023 17:16:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=ROLgZptvgoh7DlU+OtsLNphb9xuRKAhW5LTn2JqvgUU=;
 b=hbjx+DxlZ2G5y77BGv9QFm6ywbU7SyiA8V2cLqeTxwXl1+X9BTzahJ0dwKypCAdLQuLt
 X4nnQ+zUP2VmE8T+BJvZJZrAYJr8Px0aDA+PytbJ3LeyOrkXB9VrGaVFoKcBO32ERmza
 C7IZwVerMBWA5bGfgVNhcyhpdlANOFKiV2WxvN7Eui7hpTWY2k2cmxnT7V68piRTnm+P
 +6HLHxPBXrg+IGOriT2e63fwDWSIkCKScau//aJMgLCd9dcnp0yKt0pN8Bo6mLhxvj3V
 R3mAbuxGXNCHY6xZWIkLwniI/kx9+Kb6DM7FWijl/BGz8cOTLFHqBrVvEdo6nbsEigoi qQ== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3tt4f58299-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 17 Oct 2023 17:16:41 -0700
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server id
 15.1.2507.23; Tue, 17 Oct 2023 17:16:38 -0700
From: Vadim Fedorenko <vadfed@meta.com>
To: Martin Lau <kafai@meta.com>, Jakub Kicinski <kuba@kernel.org>,
        "Pavan
 Chebbi" <pavan.chebbi@broadcom.com>,
        Andy Gospodarek
	<andrew.gospodarek@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>
CC: Vadim Fedorenko <vadfed@meta.com>,
        Richard Cochran
	<richardcochran@gmail.com>,
        Vadim Fedorenko <vadim.fedorenko@linux.dev>, <netdev@vger.kernel.org>
Subject: [PATCH net v4] bnxt_en: reset PHC frequency in free-running mode
Date: Tue, 17 Oct 2023 17:16:28 -0700
Message-ID: <20231018001630.1064001-1-vadfed@meta.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2620:10d:c0a8:1c::11]
X-Proofpoint-ORIG-GUID: jrv8F2CCRcvgjSEQ6IcOnNkkyGl6k-1k
X-Proofpoint-GUID: jrv8F2CCRcvgjSEQ6IcOnNkkyGl6k-1k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_07,2023-10-17_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When using a PHC in shared between multiple hosts, the previous
frequency value may not be reset and could lead to host being unable to
compensate the offset with timecounter adjustments. To avoid such state
reset the hardware frequency of PHC to zero on init. Some refactoring is
needed to make code readable.

Fixes: 85036aee1938 ("bnxt_en: Add a non-real time mode to access NIC clock")
Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  6 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  2 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 56 ++++++++++---------
 3 files changed, 35 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 808236dc898b..e2e2c986c82b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -6990,11 +6990,9 @@ static int bnxt_hwrm_func_qcfg(struct bnxt *bp)
 		if (flags & FUNC_QCFG_RESP_FLAGS_FW_DCBX_AGENT_ENABLED)
 			bp->fw_cap |= BNXT_FW_CAP_DCBX_AGENT;
 	}
-	if (BNXT_PF(bp) && (flags & FUNC_QCFG_RESP_FLAGS_MULTI_HOST)) {
+	if (BNXT_PF(bp) && (flags & FUNC_QCFG_RESP_FLAGS_MULTI_HOST))
 		bp->flags |= BNXT_FLAG_MULTI_HOST;
-		if (bp->fw_cap & BNXT_FW_CAP_PTP_RTC)
-			bp->fw_cap &= ~BNXT_FW_CAP_PTP_RTC;
-	}
+
 	if (flags & FUNC_QCFG_RESP_FLAGS_RING_MONITOR_ENABLED)
 		bp->fw_cap |= BNXT_FW_CAP_RING_MONITOR;
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index dcb09fbe4007..c0628ac1b798 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2000,6 +2000,8 @@ struct bnxt {
 	u32			fw_dbg_cap;
 
 #define BNXT_NEW_RM(bp)		((bp)->fw_cap & BNXT_FW_CAP_NEW_RM)
+#define BNXT_PTP_USE_RTC(bp)	(!BNXT_MH(bp) && \
+				 ((bp)->fw_cap & BNXT_FW_CAP_PTP_RTC))
 	u32			hwrm_spec_code;
 	u16			hwrm_cmd_seq;
 	u16                     hwrm_cmd_kong_seq;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
index 4ec8bba18cdd..a3a3978a4d1c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
@@ -63,7 +63,7 @@ static int bnxt_ptp_settime(struct ptp_clock_info *ptp_info,
 						ptp_info);
 	u64 ns = timespec64_to_ns(ts);
 
-	if (ptp->bp->fw_cap & BNXT_FW_CAP_PTP_RTC)
+	if (BNXT_PTP_USE_RTC(ptp->bp))
 		return bnxt_ptp_cfg_settime(ptp->bp, ns);
 
 	spin_lock_bh(&ptp->ptp_lock);
@@ -196,7 +196,7 @@ static int bnxt_ptp_adjtime(struct ptp_clock_info *ptp_info, s64 delta)
 	struct bnxt_ptp_cfg *ptp = container_of(ptp_info, struct bnxt_ptp_cfg,
 						ptp_info);
 
-	if (ptp->bp->fw_cap & BNXT_FW_CAP_PTP_RTC)
+	if (BNXT_PTP_USE_RTC(ptp->bp))
 		return bnxt_ptp_adjphc(ptp, delta);
 
 	spin_lock_bh(&ptp->ptp_lock);
@@ -205,34 +205,39 @@ static int bnxt_ptp_adjtime(struct ptp_clock_info *ptp_info, s64 delta)
 	return 0;
 }
 
+static int bnxt_ptp_adjfine_rtc(struct bnxt *bp, long scaled_ppm)
+{
+	s32 ppb = scaled_ppm_to_ppb(scaled_ppm);
+	struct hwrm_port_mac_cfg_input *req;
+	int rc;
+
+	rc = hwrm_req_init(bp, req, HWRM_PORT_MAC_CFG);
+	if (rc)
+		return rc;
+
+	req->ptp_freq_adj_ppb = cpu_to_le32(ppb);
+	req->enables = cpu_to_le32(PORT_MAC_CFG_REQ_ENABLES_PTP_FREQ_ADJ_PPB);
+	rc = hwrm_req_send(bp, req);
+	if (rc)
+		netdev_err(bp->dev,
+			   "ptp adjfine failed. rc = %d\n", rc);
+	return rc;
+}
+
 static int bnxt_ptp_adjfine(struct ptp_clock_info *ptp_info, long scaled_ppm)
 {
 	struct bnxt_ptp_cfg *ptp = container_of(ptp_info, struct bnxt_ptp_cfg,
 						ptp_info);
-	struct hwrm_port_mac_cfg_input *req;
 	struct bnxt *bp = ptp->bp;
-	int rc = 0;
 
-	if (!(ptp->bp->fw_cap & BNXT_FW_CAP_PTP_RTC)) {
-		spin_lock_bh(&ptp->ptp_lock);
-		timecounter_read(&ptp->tc);
-		ptp->cc.mult = adjust_by_scaled_ppm(ptp->cmult, scaled_ppm);
-		spin_unlock_bh(&ptp->ptp_lock);
-	} else {
-		s32 ppb = scaled_ppm_to_ppb(scaled_ppm);
-
-		rc = hwrm_req_init(bp, req, HWRM_PORT_MAC_CFG);
-		if (rc)
-			return rc;
+	if (BNXT_PTP_USE_RTC(bp))
+		return bnxt_ptp_adjfine_rtc(bp, scaled_ppm);
 
-		req->ptp_freq_adj_ppb = cpu_to_le32(ppb);
-		req->enables = cpu_to_le32(PORT_MAC_CFG_REQ_ENABLES_PTP_FREQ_ADJ_PPB);
-		rc = hwrm_req_send(ptp->bp, req);
-		if (rc)
-			netdev_err(ptp->bp->dev,
-				   "ptp adjfine failed. rc = %d\n", rc);
-	}
-	return rc;
+	spin_lock_bh(&ptp->ptp_lock);
+	timecounter_read(&ptp->tc);
+	ptp->cc.mult = adjust_by_scaled_ppm(ptp->cmult, scaled_ppm);
+	spin_unlock_bh(&ptp->ptp_lock);
+	return 0;
 }
 
 void bnxt_ptp_pps_event(struct bnxt *bp, u32 data1, u32 data2)
@@ -879,7 +884,7 @@ int bnxt_ptp_init_rtc(struct bnxt *bp, bool phc_cfg)
 	u64 ns;
 	int rc;
 
-	if (!bp->ptp_cfg || !(bp->fw_cap & BNXT_FW_CAP_PTP_RTC))
+	if (!bp->ptp_cfg || !BNXT_PTP_USE_RTC(bp))
 		return -ENODEV;
 
 	if (!phc_cfg) {
@@ -932,13 +937,14 @@ int bnxt_ptp_init(struct bnxt *bp, bool phc_cfg)
 	atomic_set(&ptp->tx_avail, BNXT_MAX_TX_TS);
 	spin_lock_init(&ptp->ptp_lock);
 
-	if (bp->fw_cap & BNXT_FW_CAP_PTP_RTC) {
+	if (BNXT_PTP_USE_RTC(bp)) {
 		bnxt_ptp_timecounter_init(bp, false);
 		rc = bnxt_ptp_init_rtc(bp, phc_cfg);
 		if (rc)
 			goto out;
 	} else {
 		bnxt_ptp_timecounter_init(bp, true);
+		bnxt_ptp_adjfine_rtc(bp, 0);
 	}
 
 	ptp->ptp_info = bnxt_ptp_caps;
-- 
2.34.1


