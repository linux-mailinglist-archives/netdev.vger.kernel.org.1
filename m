Return-Path: <netdev+bounces-131714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEDC98F50F
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 19:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B4A21C21489
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 17:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EFD1A76D0;
	Thu,  3 Oct 2024 17:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Pc+4zhHT"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC951DFFB;
	Thu,  3 Oct 2024 17:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727976504; cv=none; b=spJLsyoAsuLGoxGOg+UPekmo2GoRGAtPwy+rkv0gmM1M17c2DGvHpm6cutD+OXcJDzzW05hZRsKBIfVtJYVv66axI3UdKR/Kj97eXODZLQ2RBcPWsm1/jw0+Tyf4G4dQahTnxTCFPi3a61c8L1XkXA2Gne9lJTxRRAITzpEDryw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727976504; c=relaxed/simple;
	bh=WPTV571VPwjWgftRlqxtirBVjpT2ypp+B2x4MPUMvgQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=JZGx2LZLv0e3X+Utsj+WyRS5Z85RmsBgiVesNjmnOCOuc2pdTSALR5kA/37LfIC2nA2yUNXexVQE7zDvgdeRcdUGM2CkQp4BCFbuQ/3hipAXC8Vu96cH/2oXKh0ecO4hvYIESwYjSUB0jpqnZhmSTZrsLGcwjE6xulfW10g6+6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Pc+4zhHT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4939Okp4022918;
	Thu, 3 Oct 2024 17:28:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=kECYmxAAqQw50rgJr2KLXC
	490nyP7CVPR+cK9NUrQok=; b=Pc+4zhHTArzLWBigHme/AgD+HPgwdPd2Jpf5Rg
	pgnHoeAYPj+YDTtlGSt1IA59D7rLBrdY3TRO1irfJYNUy53Xr8dG1ne5JqZx9zs8
	aHlH6LQcbRGjQnsS+dbqXYvjJ3tLKeXvEgM8NKN3FR9isXNusQn1DKy/PqTkPfcA
	SNGC2VEcdcLV1J8jLIxFCelofJ1AO4Y9/KW6vSqC99EgjzX6YL1FxeHYTgeu3MpT
	LtX5ZZtn3wFQQ4wf1+CajBTyx7sPkKlpJa1Hy8ieIVtLt/LBRUv6Rp/+5oL+5MqY
	IbQlmTIgCCPG+Jx/rDIXNcdN5kXbO7Mu5v7qn2EKysibXgJw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41x7gefb7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Oct 2024 17:28:06 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 493HS5kh022812
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 3 Oct 2024 17:28:05 GMT
Received: from hu-zijuhu-lv.qualcomm.com (10.49.16.6) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 3 Oct 2024 10:28:04 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
Date: Thu, 3 Oct 2024 10:27:27 -0700
Subject: [PATCH net-next v6] net: qcom/emac: Find sgmii_ops by
 device_for_each_child()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241003-qcom_emac_fix-v6-1-0658e3792ca4@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAP7T/mYC/12NTQ6CMBCFr0JmbU2hQKwr72EIaYdRZkGRtjYYw
 t1tcOfy/X1vg0CeKcC12MBT4sCzy6I9FYCjcU8SPGQNlaxqqSslFpynniaD/YNXIY1U2FpNptS
 QNy9P2T54d3AUhaM1QpeTkUOc/ec4Ss2R/5hK/jFTI0pBjUY5DBYvtr4tb0Z2eM416PZ9/wJOZ
 dYatgAAAA==
To: Timur Tabi <timur@kernel.org>, "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zijun Hu
	<zijun_hu@icloud.com>, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: eOwl1rzZzJ_Ap7dSuLGchSDrcQUkZNxP
X-Proofpoint-GUID: eOwl1rzZzJ_Ap7dSuLGchSDrcQUkZNxP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410030125

To prepare for constifying the following old driver core API:

struct device *device_find_child(struct device *dev, void *data,
		int (*match)(struct device *dev, void *data));
to new:
struct device *device_find_child(struct device *dev, const void *data,
		int (*match)(struct device *dev, const void *data));

The new API does not allow its match function (*match)() to modify
caller's match data @*data, but emac_sgmii_acpi_match(), as the old
API's match function, indeed modifies relevant match data, so it is
not suitable for the new API any more, solved by implementing the same
finding sgmii_ops function by correcting the function and using it
as parameter of device_for_each_child() instead of device_find_child().

By the way, this commit does not change any existing logic.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
This patch is separated from the following patch series:
https://lore.kernel.org/all/20240905-const_dfc_prepare-v4-0-4180e1d5a244@quicinc.com/

This patch is to prepare for constifying the following driver API:

struct device *device_find_child(struct device *dev, void *data,
		int (*match)(struct device *dev, void *data));
to
struct device *device_find_child(struct device *dev, const void *data,
		int (*match)(struct device *dev, const void *data));

How to constify the API ?
There are total 30 usages of the API in current kernel tree:

For 2/30 usages, the API's match function (*match)() will modify
caller's match data @*data, and this patch will clean up one of both.

For remaining 28/30, the following patch series will simply change its
relevant parameter type to const void *.
https://lore.kernel.org/all/20240811-const_dfc_done-v1-1-9d85e3f943cb@quicinc.com/

Why to constify the API ?

(1) It normally does not make sense, also does not need to, for
such device finding operation to modify caller's match data which
is mainly used for comparison.

(2) It will make the API's match function and match data parameter
have the same type as all other APIs (bus|class|driver)_find_device().

(3) It will give driver author hints about choice between this API and
the following one:
int device_for_each_child(struct device *dev, void *data,
		int (*fn)(struct device *dev, void *data));
---
Changes in v6:
- Move get_device() out of emac_sgmii_acpi_match() as suggested by greg.
- Link to v5: https://lore.kernel.org/r/20240930-qcom_emac_fix-v5-1-e59c0ddbc8b4@quicinc.com

Changes in v5:
- Separate me for the series
- Correct commit message and remove the inline comment
- Link to v4: https://lore.kernel.org/r/20240905-const_dfc_prepare-v4-2-4180e1d5a244@quicinc.com

Changes in v4:
- Correct title and commit message
- Link to v3: https://lore.kernel.org/r/20240824-const_dfc_prepare-v3-3-32127ea32bba@quicinc.com

Changes in v3:
- Make qcom/emac follow cxl/region solution suggested by Greg
- Link to v2: https://lore.kernel.org/r/20240815-const_dfc_prepare-v2-0-8316b87b8ff9@quicinc.com

Changes in v2:
- Give up introducing the API constify_device_find_child_helper()
- Implement a driver specific and equivalent one instead of device_find_child()
- Correct commit message
- Link to v1: https://lore.kernel.org/r/20240811-const_dfc_prepare-v1-0-d67cc416b3d3@quicinc.com
---
 drivers/net/ethernet/qualcomm/emac/emac-sgmii.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c b/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c
index e4bc18009d08..a508ebc4b206 100644
--- a/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c
+++ b/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c
@@ -293,6 +293,11 @@ static struct sgmii_ops qdf2400_ops = {
 };
 #endif
 
+struct emac_match_data {
+	struct sgmii_ops **sgmii_ops;
+	struct device *target_device;
+};
+
 static int emac_sgmii_acpi_match(struct device *dev, void *data)
 {
 #ifdef CONFIG_ACPI
@@ -303,7 +308,7 @@ static int emac_sgmii_acpi_match(struct device *dev, void *data)
 		{}
 	};
 	const struct acpi_device_id *id = acpi_match_device(match_table, dev);
-	struct sgmii_ops **ops = data;
+	struct emac_match_data *match_data = data;
 
 	if (id) {
 		acpi_handle handle = ACPI_HANDLE(dev);
@@ -324,10 +329,12 @@ static int emac_sgmii_acpi_match(struct device *dev, void *data)
 
 		switch (hrv) {
 		case 1:
-			*ops = &qdf2432_ops;
+			*match_data->sgmii_ops = &qdf2432_ops;
+			match_data->target_device = dev;
 			return 1;
 		case 2:
-			*ops = &qdf2400_ops;
+			*match_data->sgmii_ops = &qdf2400_ops;
+			match_data->target_device = dev;
 			return 1;
 		}
 	}
@@ -356,16 +363,21 @@ int emac_sgmii_config(struct platform_device *pdev, struct emac_adapter *adpt)
 	int ret;
 
 	if (has_acpi_companion(&pdev->dev)) {
+		struct emac_match_data match_data = {
+			.sgmii_ops = &phy->sgmii_ops,
+			.target_device = NULL,
+		};
 		struct device *dev;
 
-		dev = device_find_child(&pdev->dev, &phy->sgmii_ops,
-					emac_sgmii_acpi_match);
+		device_for_each_child(&pdev->dev, &match_data, emac_sgmii_acpi_match);
+		dev = match_data.target_device;
 
 		if (!dev) {
 			dev_warn(&pdev->dev, "cannot find internal phy node\n");
 			return 0;
 		}
 
+		get_device(dev);
 		sgmii_pdev = to_platform_device(dev);
 	} else {
 		const struct of_device_id *match;

---
base-commit: c30a3f54e661d01df2bf193398336155089dd502
change-id: 20240923-qcom_emac_fix-0a03c6b9ea19

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


