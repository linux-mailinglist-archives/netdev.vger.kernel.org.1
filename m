Return-Path: <netdev+bounces-24370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBE876FFB7
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 13:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D0321C21579
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 11:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2102BA39;
	Fri,  4 Aug 2023 11:51:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2185BA28
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 11:51:31 +0000 (UTC)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5812134
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 04:51:29 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3742b8MZ001292;
	Fri, 4 Aug 2023 04:51:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=UJE0Dpng4Mi1yWGqMEy0o76uJmtc3crcuEtCF8MbgUg=;
 b=j+TsbLJopQfcnBJ1JadEO/r3ObjEgdcdVW51nhpnuXt0ld+Z8Wgw/qe+XnhSor+YpjXu
 /dNzWBP6Zd/jguwqMyL1SnvIFaWj8I1cDAeJQnAtFt32MLJdn4HBl8JcCyl9vXPemVgv
 ngkUYD8Q3FAucNMSB+YWoxsSYee2qPfRkrBr2/cLMi4R2v5unOD4TCCVg6FkbbyGVCcW
 qZUyxvwtWENWfu728Lawb2lb+UILzSDrbg1XxU9Y3LtdLOQ6OELWd2np7m1fgy3NfgNE
 5775uC5pXyX8im3jGapzdrzHZBhXYkdW+Qg1HUVPWkDaZpmkf8Mn/90bGFZ4U9Rwk1Sy Rg== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3s8p0xhh79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Fri, 04 Aug 2023 04:51:22 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 4 Aug
 2023 04:51:20 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Fri, 4 Aug 2023 04:51:20 -0700
Received: from falcon.marvell.com (unknown [10.30.46.95])
	by maili.marvell.com (Postfix) with ESMTP id C18B83F7084;
	Fri,  4 Aug 2023 04:51:16 -0700 (PDT)
From: Manish Chopra <manishc@marvell.com>
To: <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <aelior@marvell.com>, <palok@marvell.com>,
        <njavali@marvell.com>, <skashyap@marvell.com>, <jmeneghi@redhat.com>,
        "David
 Miller" <davem@davemloft.net>
Subject: [PATCH net] qede: fix firmware halt over suspend and resume
Date: Fri, 4 Aug 2023 17:21:11 +0530
Message-ID: <20230804115111.84988-1-manishc@marvell.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: KWTSq_V73oGWS-vtBsj1paKeYZ4bQ0rV
X-Proofpoint-ORIG-GUID: KWTSq_V73oGWS-vtBsj1paKeYZ4bQ0rV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_10,2023-08-03_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

While performing certain power-off sequences, PCI drivers are
called to suspend and resume their underlying devices through
PCI PM (power management) interface. However this NIC hardware
does not support PCI PM suspend/resume operations so system wide
suspend/resume leads to bad MFW (management firmware) state which
causes various follow-up errors in driver when communicating with
the device/firmware afterwards.

To fix this driver implements PCI PM suspend handler to indicate
unsupported operation to the PCI subsystem explicitly, thus avoiding
system to go into suspended/standby mode.

Fixes: 2950219d87b0 ("qede: Add basic network device support")
Cc: David Miller <davem@davemloft.net>
Signed-off-by: Manish Chopra <manishc@marvell.com>
Signed-off-by: Alok Prasad <palok@marvell.com>
---
 drivers/net/ethernet/qlogic/qede/qede_main.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_main.c b/drivers/net/ethernet/qlogic/qede/qede_main.c
index d57e52a97f85..35ef187e4825 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_main.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_main.c
@@ -177,6 +177,18 @@ static int qede_sriov_configure(struct pci_dev *pdev, int num_vfs_param)
 }
 #endif
 
+static int __maybe_unused qede_suspend(struct device *dev)
+{
+	if (!dev)
+		return -ENODEV;
+
+	dev_info(dev, "Device does not support suspend operation\n");
+
+	return -EOPNOTSUPP;
+}
+
+static SIMPLE_DEV_PM_OPS(qede_pm_ops, qede_suspend, NULL);
+
 static const struct pci_error_handlers qede_err_handler = {
 	.error_detected = qede_io_error_detected,
 };
@@ -191,6 +203,7 @@ static struct pci_driver qede_pci_driver = {
 	.sriov_configure = qede_sriov_configure,
 #endif
 	.err_handler = &qede_err_handler,
+	.driver.pm = &qede_pm_ops,
 };
 
 static struct qed_eth_cb_ops qede_ll_ops = {
-- 
2.27.0


