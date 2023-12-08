Return-Path: <netdev+bounces-55236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0611D809F4F
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 10:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90FA1B20B5A
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 09:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289E4125CE;
	Fri,  8 Dec 2023 09:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Mg2s7S0A"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92CB172E;
	Fri,  8 Dec 2023 01:28:14 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B81KRK0028755;
	Fri, 8 Dec 2023 01:28:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=/SbDv81f8aUiAQr9WB+KgRejK4bzCZNzWZChpeYFMdQ=;
 b=Mg2s7S0AgHZg+UZ8F7cZgKwQNBAdpQZlye56Mx9YFtrg0eOsy+TWqoYNBgm9HOokcjik
 FDIsraN7ggk/i34x5t6g0c3DpkfYQKBLg9GeouXDvEAIqvaxNgLkKqAW0nPw61gjFrYW
 EDVgT8pcl8QP6LC7Pgkz7Vu6RiW1KhlbY5h26UkE3hpDTcNfgErDweDUBmZsRLb5CjQu
 M2idBUC/naRGAucUc7xma37m0OSUx+Zd4Sd5XoGygvvxKra+IVxmXl9ZzEgmOVhUUcPZ
 jC7xAyHaCOBmij90UmJxVmqKjtjipXcUwuv8Axd8eQk4o8KXdThfV0ES8ATEBssCcQAK og== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3uubddcfuk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Fri, 08 Dec 2023 01:28:01 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 8 Dec
 2023 01:27:59 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Fri, 8 Dec 2023 01:27:59 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 4E1BB3F7050;
	Fri,  8 Dec 2023 01:27:55 -0800 (PST)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <lcherian@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <edumazet@google.com>, <pabeni@redhat.com>
Subject: [net] octeontx2-af: Fix pause frame configuration
Date: Fri, 8 Dec 2023 14:57:54 +0530
Message-ID: <20231208092754.23462-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Hso7myGnRPfBIIAZF8GX1tvom3R3czf0
X-Proofpoint-GUID: Hso7myGnRPfBIIAZF8GX1tvom3R3czf0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-08_04,2023-12-07_01,2023-05-22_02

The current implementation's default Pause Forward setting is causing
unnecessary network traffic. This patch disables Pause Forward to
address this issue.

Fixes: 1121f6b02e7a ("octeontx2-af: Priority flow control configuration support")
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rpm.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rpm.c b/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
index af21e2030cff..4728ba34b0e3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
@@ -373,6 +373,11 @@ void rpm_lmac_pause_frm_config(void *rpmd, int lmac_id, bool enable)
 	cfg |= RPMX_MTI_MAC100X_COMMAND_CONFIG_TX_P_DISABLE;
 	rpm_write(rpm, lmac_id, RPMX_MTI_MAC100X_COMMAND_CONFIG, cfg);
 
+	/* Disable forward pause to driver */
+	cfg = rpm_read(rpm, lmac_id, RPMX_MTI_MAC100X_COMMAND_CONFIG);
+	cfg &= ~RPMX_MTI_MAC100X_COMMAND_CONFIG_PAUSE_FWD;
+	rpm_write(rpm, lmac_id, RPMX_MTI_MAC100X_COMMAND_CONFIG, cfg);
+
 	/* Enable channel mask for all LMACS */
 	if (is_dev_rpm2(rpm))
 		rpm_write(rpm, lmac_id, RPM2_CMR_CHAN_MSK_OR, 0xffff);
@@ -616,12 +621,10 @@ int rpm_lmac_pfc_config(void *rpmd, int lmac_id, u8 tx_pause, u8 rx_pause, u16 p
 
 	if (rx_pause) {
 		cfg &= ~(RPMX_MTI_MAC100X_COMMAND_CONFIG_RX_P_DISABLE |
-				RPMX_MTI_MAC100X_COMMAND_CONFIG_PAUSE_IGNORE |
-				RPMX_MTI_MAC100X_COMMAND_CONFIG_PAUSE_FWD);
+			 RPMX_MTI_MAC100X_COMMAND_CONFIG_PAUSE_IGNORE);
 	} else {
 		cfg |= (RPMX_MTI_MAC100X_COMMAND_CONFIG_RX_P_DISABLE |
-				RPMX_MTI_MAC100X_COMMAND_CONFIG_PAUSE_IGNORE |
-				RPMX_MTI_MAC100X_COMMAND_CONFIG_PAUSE_FWD);
+			RPMX_MTI_MAC100X_COMMAND_CONFIG_PAUSE_IGNORE);
 	}
 
 	if (tx_pause) {
-- 
2.17.1


