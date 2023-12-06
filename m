Return-Path: <netdev+bounces-54285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E356806765
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 07:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C01171C21155
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 06:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B1A10A37;
	Wed,  6 Dec 2023 06:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="fbP6on6j"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC46D46;
	Tue,  5 Dec 2023 22:36:07 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B65ddqp023836;
	Tue, 5 Dec 2023 22:35:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=C2Vbd6JnDAfhgxbHY/teR4Hm++QYeBA9A+zn+kRvmgQ=;
 b=fbP6on6jCeqDu+3KP4c3c12eBlb+wTZBUnHJeSGSBWpHSusAFauYmiNF1SCOKypgQr9D
 Qr3GJxqUuH3gbYqgUtiSoNgpF3RBXGTd6jqKLplvspO+90YLclIJdxDZSb8vdCaF0yH/
 lYe6haOq51/RA/cF7ae19B/qwWgLuAVXlcs7RUPMcdy4Yz72oW1umVJFv47jblyYv4Bq
 2Nm2tjdXzUX8BQqqZQwc4DJekaLPHVczwqgkX2bPDcWdGdwCkQgUBaR0EHafXcEcWRW3
 BHykKewB4JWXSCOqhoqk9F4Qa02CZQOqjJz/EHFeO14PtpIniRC05OXm37j5EH+9tq3Q AA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3utd0p95tf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Tue, 05 Dec 2023 22:35:54 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 5 Dec
 2023 22:35:52 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 5 Dec 2023 22:35:52 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id D640E3F704E;
	Tue,  5 Dec 2023 22:35:51 -0800 (PST)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <vimleshk@marvell.com>, <egallen@redhat.com>,
        <mschmidt@redhat.com>, <pabeni@redhat.com>, <horms@kernel.org>,
        <kuba@kernel.org>, <davem@davemloft.net>, <wizhao@redhat.com>,
        <konguyen@redhat.com>, Shinas Rasheed <srasheed@marvell.com>,
        "Veerasenareddy
 Burru" <vburru@marvell.com>,
        Sathesh Edara <sedara@marvell.com>,
        Eric Dumazet
	<edumazet@google.com>,
        Abhijit Ayarekar <aayarekar@marvell.com>,
        "Satananda
 Burla" <sburla@marvell.com>
Subject: [PATCH net v1] octeon_ep: explicitly test for firmware ready value
Date: Tue, 5 Dec 2023 22:35:49 -0800
Message-ID: <20231206063549.2590305-1-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: U6H81ENnbgqaAmserLKIWBlR8Vi0D_Ch
X-Proofpoint-ORIG-GUID: U6H81ENnbgqaAmserLKIWBlR8Vi0D_Ch
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_04,2023-12-05_01,2023-05-22_02

The firmware ready value is 1, and get firmware ready status
function should explicitly test for that value. The firmware
ready value read will be 2 after driver load, and on unbind
till firmware rewrites the firmware ready back to 0, the value
seen by driver will be 2, which should be regarded as not ready.

Fixes: 10c073e40469 ("octeon_ep: defer probe if firmware not ready")
Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
 drivers/net/ethernet/marvell/octeon_ep/octep_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
index 552970c7dec0..b8ae269f6f97 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -1258,7 +1258,8 @@ static bool get_fw_ready_status(struct pci_dev *pdev)
 
 		pci_read_config_byte(pdev, (pos + 8), &status);
 		dev_info(&pdev->dev, "Firmware ready status = %u\n", status);
-		return status;
+#define FW_STATUS_READY 1ULL
+		return (status == FW_STATUS_READY) ? true : false;
 	}
 	return false;
 }
-- 
2.25.1


