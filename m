Return-Path: <netdev+bounces-29224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA85782327
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 07:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D18C1C203D9
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 05:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34301389;
	Mon, 21 Aug 2023 05:25:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A2B1841
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 05:25:51 +0000 (UTC)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81565A6;
	Sun, 20 Aug 2023 22:25:50 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37KMF7fr017878;
	Sun, 20 Aug 2023 22:25:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=1Y0opkK+tRx2x7Fg5xU/6zCK9jvWV6W18jQIHkasWTI=;
 b=Hf16bWV/ucKvdCJPKSEaAe8M+oVkeFY0qgxGhIMr7NfQRIN7BWPaBrK8WHgriXdFUsKE
 k0DWMtB9RFqOdBqi+f4CaROtvJ/yFCkAPO8d3a2dg5kuk7f0TQbuu1Kt3BrFvdN4ncVb
 rl0LdpXkmiKeEBZ+eqPSE7xMoY7k8CcBTtfwEBAhjiiH0iCbrP6Sr9chaA9T4heL7lcK
 5E7oS4i5JIdU5+woyIxPlbrZ77CHsAOoqW+ScoeDxafe3UeXbKUyy7qpVRKT6vZzlsrG
 Q1ysleQNufghUeiKfC8hWSyZbgmjKco6e3ypiiuJf/Z537BQgamRQ73t10k5xYfsviCj rQ== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3sju3qksav-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Sun, 20 Aug 2023 22:25:40 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 20 Aug
 2023 22:25:34 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Sun, 20 Aug 2023 22:25:34 -0700
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id 956EF3F7081;
	Sun, 20 Aug 2023 22:25:30 -0700 (PDT)
From: Suman Ghosh <sumang@marvell.com>
To: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <lcherian@marvell.com>, <jerinj@marvell.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [net PATCH V3 2/3] octeontx2-af: CN10KB: fix PFC configuration
Date: Mon, 21 Aug 2023 10:55:15 +0530
Message-ID: <20230821052516.398572-3-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230821052516.398572-1-sumang@marvell.com>
References: <20230821052516.398572-1-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: XLOA7p6mHWBnAEyxB_kTlHA-tyWtltJr
X-Proofpoint-ORIG-GUID: XLOA7p6mHWBnAEyxB_kTlHA-tyWtltJr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-20_15,2023-08-18_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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


