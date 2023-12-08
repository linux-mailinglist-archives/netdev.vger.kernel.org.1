Return-Path: <netdev+bounces-55187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BABA809C13
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 06:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36FDD1F2117F
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 05:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189AA6FC7;
	Fri,  8 Dec 2023 05:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ZoAVrR6X"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D59D19A2;
	Thu,  7 Dec 2023 21:57:03 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B81CqNC028994;
	Thu, 7 Dec 2023 21:56:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=HEQnHUIqnjI0rxLDWe/wA9HwPEdz9nqzT9bUL9LwXow=;
 b=ZoAVrR6XhBhqwm3jZsjRCUX1EwrmtYbO3Jeam3qDhwrQy98Uw3BDTpX68yD6IRrR1Y6b
 ZKVMUKJhC9UyFjTXbH6xkqndNnfJIIyC5oUF/AkJ6/418qDFOQK5uth7GDSOQTx/OTC4
 llhbGZTf/ndsMCpYRh+p01JtniX3eu8kAaC622fwzzW3+CuVD6erGoOoGs+yP7Zm8CAR
 d7cUE2heN3K87/OmrEIM4sEprbAa81ZlxKBB8iXlsF4e1CpbSfnyUdgUjkkgfxV1kI2l
 tyB19MrPfCqn9MU+AhCytGDUw2Zn1lAmDlKjT+zbhv1uQta3vBIGf9Zm8ulcgxjGNwtF MQ== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3uubddbuhe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Thu, 07 Dec 2023 21:56:55 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 7 Dec
 2023 21:56:53 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 7 Dec 2023 21:56:53 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id 573F63F7050;
	Thu,  7 Dec 2023 21:56:53 -0800 (PST)
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
Subject: [PATCH net v3] octeon_ep: explicitly test for firmware ready value
Date: Thu, 7 Dec 2023 21:56:46 -0800
Message-ID: <20231208055646.2602363-1-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ok7DybbzTglDBUek9-Dr2b8mjc3niAau
X-Proofpoint-GUID: ok7DybbzTglDBUek9-Dr2b8mjc3niAau
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-08_02,2023-12-07_01,2023-05-22_02

The firmware ready value is 1, and get firmware ready status
function should explicitly test for that value. The firmware
ready value read will be 2 after driver load, and on unbind
till firmware rewrites the firmware ready back to 0, the value
seen by driver will be 2, which should be regarded as not ready.

Fixes: 10c073e40469 ("octeon_ep: defer probe if firmware not ready")
Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V3:
  - Removed unnecessary parenthesis around boolean return.

V2: https://lore.kernel.org/all/20231207074936.2597889-1-srasheed@marvell.com/
  - Fixed redundant logic

V1: https://lore.kernel.org/all/20231206063549.2590305-1-srasheed@marvell.com/

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
+		return status == FW_STATUS_READY;
 	}
 	return false;
 }
-- 
2.25.1


