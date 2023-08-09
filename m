Return-Path: <netdev+bounces-25710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F94C775386
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 09:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B04491C21122
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 07:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888726106;
	Wed,  9 Aug 2023 07:06:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DADE20EC
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 07:06:12 +0000 (UTC)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A4A2113;
	Wed,  9 Aug 2023 00:06:07 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 379661wo023098;
	Wed, 9 Aug 2023 00:05:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=1Y0opkK+tRx2x7Fg5xU/6zCK9jvWV6W18jQIHkasWTI=;
 b=R9k20ungijHcazW5H+msGBphis/iEYJ1XzdUEmXPdBgcxkZ5iZBHrwAbsYc/oYXe81I2
 LNof5RPQVN9MPVstJpkfVdoTOHJQrPZdn+AM7liMEyeHSpA646jqtdoXiOp6LJYTbioT
 uuI4Stx3Jt312aFIUAIZvH6odGsW2Ey3b5I/jJyULN74uOCtLkcD358oImwBU545pVM/
 unSIIWiNJCrwKjs1KDaae4XP6qRDbm9K8d2AOpUg1nZQAuB4c6MmS2YZ0jgw6EvuoQ9K
 5WflG1Fpqyt6Mnf2GS4d9RZv91A1sgMhOTibQ3x515w8eTriqdKg2xa6igBUcbYWFtrQ dA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3sc57sg62a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Wed, 09 Aug 2023 00:05:59 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 9 Aug
 2023 00:05:57 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 9 Aug 2023 00:05:57 -0700
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id C8B393F705B;
	Wed,  9 Aug 2023 00:05:53 -0700 (PDT)
From: Suman Ghosh <sumang@marvell.com>
To: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lcherian@marvell.com>,
        <jerinj@marvell.com>
Subject: [net PATCH V2 3/4] octeontx2-af: CN10KB: fix PFC configuration
Date: Wed, 9 Aug 2023 12:35:31 +0530
Message-ID: <20230809070532.3252464-4-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230809070532.3252464-1-sumang@marvell.com>
References: <20230809070532.3252464-1-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: T3xAGntLOpXuPAgMz2MTwSJo2fxcMDFm
X-Proofpoint-ORIG-GUID: T3xAGntLOpXuPAgMz2MTwSJo2fxcMDFm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_04,2023-08-08_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Hariprasad Kelam <hkelam@marvell.com>

The previous patch which added new CN10KB RPM block support,
has a bug due to which PFC is not getting configured properly.
This patch fixes the same.

Fixes: 99c969a83d82 ("octeontx2-pf: Add egress PFC support")
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rpm.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rpm.c b/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
index b4fcb20c3f4f..af21e2030cff 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
@@ -355,8 +355,8 @@ int rpm_lmac_enadis_pause_frm(void *rpmd, int lmac_id, u8 tx_pause,
 
 void rpm_lmac_pause_frm_config(void *rpmd, int lmac_id, bool enable)
 {
+	u64 cfg, pfc_class_mask_cfg;
 	rpm_t *rpm = rpmd;
-	u64 cfg;
 
 	/* ALL pause frames received are completely ignored */
 	cfg = rpm_read(rpm, lmac_id, RPMX_MTI_MAC100X_COMMAND_CONFIG);
@@ -380,9 +380,11 @@ void rpm_lmac_pause_frm_config(void *rpmd, int lmac_id, bool enable)
 		rpm_write(rpm, 0, RPMX_CMR_CHAN_MSK_OR, ~0ULL);
 
 	/* Disable all PFC classes */
-	cfg = rpm_read(rpm, lmac_id, RPMX_CMRX_PRT_CBFC_CTL);
+	pfc_class_mask_cfg = is_dev_rpm2(rpm) ? RPM2_CMRX_PRT_CBFC_CTL :
+						RPMX_CMRX_PRT_CBFC_CTL;
+	cfg = rpm_read(rpm, lmac_id, pfc_class_mask_cfg);
 	cfg = FIELD_SET(RPM_PFC_CLASS_MASK, 0, cfg);
-	rpm_write(rpm, lmac_id, RPMX_CMRX_PRT_CBFC_CTL, cfg);
+	rpm_write(rpm, lmac_id, pfc_class_mask_cfg, cfg);
 }
 
 int rpm_get_rx_stats(void *rpmd, int lmac_id, int idx, u64 *rx_stat)
@@ -605,8 +607,11 @@ int rpm_lmac_pfc_config(void *rpmd, int lmac_id, u8 tx_pause, u8 rx_pause, u16 p
 	if (!is_lmac_valid(rpm, lmac_id))
 		return -ENODEV;
 
+	pfc_class_mask_cfg = is_dev_rpm2(rpm) ? RPM2_CMRX_PRT_CBFC_CTL :
+						RPMX_CMRX_PRT_CBFC_CTL;
+
 	cfg = rpm_read(rpm, lmac_id, RPMX_MTI_MAC100X_COMMAND_CONFIG);
-	class_en = rpm_read(rpm, lmac_id, RPMX_CMRX_PRT_CBFC_CTL);
+	class_en = rpm_read(rpm, lmac_id, pfc_class_mask_cfg);
 	pfc_en |= FIELD_GET(RPM_PFC_CLASS_MASK, class_en);
 
 	if (rx_pause) {
@@ -635,10 +640,6 @@ int rpm_lmac_pfc_config(void *rpmd, int lmac_id, u8 tx_pause, u8 rx_pause, u16 p
 		cfg |= RPMX_MTI_MAC100X_COMMAND_CONFIG_PFC_MODE;
 
 	rpm_write(rpm, lmac_id, RPMX_MTI_MAC100X_COMMAND_CONFIG, cfg);
-
-	pfc_class_mask_cfg = is_dev_rpm2(rpm) ? RPM2_CMRX_PRT_CBFC_CTL :
-						RPMX_CMRX_PRT_CBFC_CTL;
-
 	rpm_write(rpm, lmac_id, pfc_class_mask_cfg, class_en);
 
 	return 0;
-- 
2.25.1


