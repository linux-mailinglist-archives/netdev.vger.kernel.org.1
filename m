Return-Path: <netdev+bounces-103887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0141909F96
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 22:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD3761C20F9C
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 20:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95E245C14;
	Sun, 16 Jun 2024 20:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VPGtIYwc"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C809C152;
	Sun, 16 Jun 2024 20:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718568134; cv=none; b=eFTQ5nC3tSekQf67pEURfItsukW/NYAIizyeLtnNKSAoIW+moTaS8ZS89kQP7hDiQHHNI4nDxwRBn7hkyc319FXilNQyc4+r6YN2nZz7I6cBM9aFvA/qYLb5IOunSRA/Ey3TNXtJYQRKX48EIEqxIxhPDAd+10EAIj+J89mUxYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718568134; c=relaxed/simple;
	bh=SpSkcX0ApxCCmB3/XkT8BCH/3qksP4dTDReO84QOVac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=Rncza8HnGKUSvGsCqBw4uaG1ycVuBg2Rt5MFIeBJYc9mFNuzX5Vyba+9xGZ2dQ+th0MBw82zXQL6s58xCvLeRw4l+Id0pmjMPbqsJHoHRMbtfsTg+c1PemOXk82MbrafyJ4Rl+kcAL/Ng7oylW18H0kXncg9WAmS4Eehxfa0XNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VPGtIYwc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45GJlZer018960;
	Sun, 16 Jun 2024 20:01:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=dAhOWxWL4ZwEjmzTGhUKqN
	VC3nm8lWK6zu6sRmOykWg=; b=VPGtIYwczdAYIEeyQhqxo3wgx8hD83A3S6P4bO
	iNOP8w/cQ5g+PlGo52oLHA0Cjd2Ga9EcfzI1h18G3+FTXqPaLF3IMG7qwEDyDnXa
	IdJrQlR23j03tSIRRIJpYKFJ6GPP94SEzXI6bWylqjddBIhWfR+FfvrPfiyvuS/E
	Uf3hHVkScgKNGc5avkXMEyja72nj8M+so7sh7i3gZJkUPiIRjoSWHW6ATwLKqvjU
	nWMCzkYKG3Zl4sjZiyjWPY4baFwVy5P9T5rIBIc1NkJVxks+VtRLfWNNIzxeYusW
	B+B6NQLdfD11AZ5l1DYLp/6qT47eTvO6bjNaL2H39bFU4Qaw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ys3b725rc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 16 Jun 2024 20:01:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45GK1oA1001754
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 16 Jun 2024 20:01:50 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 16 Jun
 2024 13:01:49 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sun, 16 Jun 2024 13:01:48 -0700
Subject: [PATCH] net: dwc-xlgmac: fix missing MODULE_DESCRIPTION() warning
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240616-md-hexagon-drivers-net-ethernet-synopsys-v1-1-55852b60aef8@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAKtEb2YC/x3NQQ6CQAyF4auQrm0CqBC9inFRhsI0kUJaJBDC3
 R3cvW/z/h2cTdjhme1gvIjLqAnFJYMQSXtGaZOhzMtbXhUVDi1GXqkfFVuThc1ReUaeI9s5fNN
 x8s2RQ10313tX0IMg3U3Gnaz/1Oud3JAzNkYa4hn4iH5XHMhnNjiOH4TY/maZAAAA
To: Jose Abreu <Jose.Abreu@synopsys.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mnnfhhTHmSOLnCSuMnsY3-0YNG5yRi2A
X-Proofpoint-ORIG-GUID: mnnfhhTHmSOLnCSuMnsY3-0YNG5yRi2A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-16_12,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 bulkscore=0 spamscore=0 mlxscore=0 priorityscore=1501 clxscore=1011
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406160157

With ARCH=hexagon, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/synopsys/dwc-xlgmac.o

With most other ARCH settings the MODULE_DESCRIPTION() is provided by
the macro invocation in dwc-xlgmac-pci.c. However, for hexagon, the
PCI bus is not enabled, and hence CONFIG_DWC_XLGMAC_PCI is not set.
As a result, dwc-xlgmac-pci.c is not compiled, and hence is not linked
into dwc-xlgmac.o.

To avoid this issue, relocate the MODULE_DESCRIPTION() and other
related macros from dwc-xlgmac-pci.c to dwc-xlgmac-common.c, since
that file already has an existing MODULE_LICENSE() and it is
unconditionally linked into dwc-xlgmac.o.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/ethernet/synopsys/dwc-xlgmac-common.c | 7 +++++--
 drivers/net/ethernet/synopsys/dwc-xlgmac-pci.c    | 5 -----
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/synopsys/dwc-xlgmac-common.c b/drivers/net/ethernet/synopsys/dwc-xlgmac-common.c
index f8e133604146..131786aa4d5b 100644
--- a/drivers/net/ethernet/synopsys/dwc-xlgmac-common.c
+++ b/drivers/net/ethernet/synopsys/dwc-xlgmac-common.c
@@ -21,8 +21,6 @@
 #include "dwc-xlgmac.h"
 #include "dwc-xlgmac-reg.h"
 
-MODULE_LICENSE("Dual BSD/GPL");
-
 static int debug = -1;
 module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug, "DWC ethernet debug level (0=none,...,16=all)");
@@ -725,3 +723,8 @@ void xlgmac_print_all_hw_features(struct xlgmac_pdata *pdata)
 	XLGMAC_PR("=====================================================\n");
 	XLGMAC_PR("\n");
 }
+
+MODULE_DESCRIPTION(XLGMAC_DRV_DESC);
+MODULE_VERSION(XLGMAC_DRV_VERSION);
+MODULE_AUTHOR("Jie Deng <jiedeng@synopsys.com>");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/ethernet/synopsys/dwc-xlgmac-pci.c b/drivers/net/ethernet/synopsys/dwc-xlgmac-pci.c
index fa8604d7b797..36fe538e3332 100644
--- a/drivers/net/ethernet/synopsys/dwc-xlgmac-pci.c
+++ b/drivers/net/ethernet/synopsys/dwc-xlgmac-pci.c
@@ -71,8 +71,3 @@ static struct pci_driver xlgmac_pci_driver = {
 };
 
 module_pci_driver(xlgmac_pci_driver);
-
-MODULE_DESCRIPTION(XLGMAC_DRV_DESC);
-MODULE_VERSION(XLGMAC_DRV_VERSION);
-MODULE_AUTHOR("Jie Deng <jiedeng@synopsys.com>");
-MODULE_LICENSE("Dual BSD/GPL");

---
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240616-md-hexagon-drivers-net-ethernet-synopsys-ec77b35f1a9a


