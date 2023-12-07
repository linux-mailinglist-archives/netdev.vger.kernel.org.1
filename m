Return-Path: <netdev+bounces-54775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E503680822A
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 08:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEC7B1C20B9F
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 07:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512241A29B;
	Thu,  7 Dec 2023 07:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="OMcMEIdZ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B6A10D;
	Wed,  6 Dec 2023 23:49:57 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B6JIedq026191;
	Wed, 6 Dec 2023 23:49:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=IMsCjRPKHSS3qe8aDrsdKaGB8Jnu3d6HBJjxEXEh3zQ=;
 b=OMcMEIdZrzN443HVzCb2oL7rlSBAac/m6XzIaMGgB2U2Wa9XHjSNCZ2Sv5elIL0g4PWg
 6ngsV+1BE9ENGPwuJ9HGmYLxpKxnYDHMAaSWWTGg9l21l6KMnQev2YAsooM65+wxskR7
 a+E3UWj1NqxHAS4zqfujc+W0vVlsdrlXCFBlew3K6uUpnawA/nTZg09/vtssPCMXaye0
 7M4mohfxJznYMm+qJNEMdLd7A+V/ZaBS2sFeT6oIQMPu3YIjyvGO+HSp0ZY40mCUk6zl
 GTnMTXxQHAgwU1cyQcMqmPymCKqN9q+BiMiAenn1Ribmph46GWRpzqsG/OCKckmI+0hu LA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3uty0jj5g6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Wed, 06 Dec 2023 23:49:44 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 6 Dec
 2023 23:49:39 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 6 Dec 2023 23:49:38 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id 6CBC43F70AA;
	Wed,  6 Dec 2023 23:49:38 -0800 (PST)
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
Subject: [PATCH net v2] octeon_ep: explicitly test for firmware ready value
Date: Wed, 6 Dec 2023 23:49:36 -0800
Message-ID: <20231207074936.2597889-1-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 1kHbwibEP1979Fc0s6JeMBLX0u551Upm
X-Proofpoint-ORIG-GUID: 1kHbwibEP1979Fc0s6JeMBLX0u551Upm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_05,2023-12-06_01,2023-05-22_02

The firmware ready value is 1, and get firmware ready status
function should explicitly test for that value. The firmware
ready value read will be 2 after driver load, and on unbind
till firmware rewrites the firmware ready back to 0, the value
seen by driver will be 2, which should be regarded as not ready.

Fixes: 10c073e40469 ("octeon_ep: defer probe if firmware not ready")
Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V2:
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
+		return (status == FW_STATUS_READY);
 	}
 	return false;
 }
-- 
2.25.1


