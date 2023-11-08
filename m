Return-Path: <netdev+bounces-46603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D55C97E55A0
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 12:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 963FA28100D
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 11:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E5E15EA8;
	Wed,  8 Nov 2023 11:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="exO10LX5"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD6015E93
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 11:35:18 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB40125;
	Wed,  8 Nov 2023 03:35:18 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A8ADVdD021577;
	Wed, 8 Nov 2023 11:35:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=Hkwju9EcLBdYO8vsxdmT7ILikUmnGUjApf76XNlufe8=;
 b=exO10LX51AjqAGf4nh9xl0h9QcMCUQOpTTjsNq+xWwk5Wh2Xhd7QqlyO6IAOpYN3Snq6
 m8kdM+01eUUWe56SxCTgy5SQNkVwjlhUdEY4f6qeGFf462IkKTePIE+PkpJFJtVYlkLC
 hOZNnkrq3h0jhkSO+9tt/EL2QqVjL8vkZpJSZxaAXm03pM6OWuRmE0jtnVbetmwWkC70
 5WEDsHFsyNF135tLLyFTtHN6/n0JpWsHXJujIcnovR1XSVvABhRsbILCBSTXQ2RSOr23
 FVopRR/+ew7HxpoaUDxDX3gzGbXmIUgEwyDSRe6/Cm5ZiqfBIK94BaabBD0gruY9ybjw Wg== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u7wvshct5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Nov 2023 11:35:08 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A8BZ7xN000523
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 Nov 2023 11:35:07 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 8 Nov 2023 03:35:05 -0800
From: Luo Jie <quic_luoj@quicinc.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/3] net: phy: at803x: Add qca8084_config_init function
Date: Wed, 8 Nov 2023 19:34:44 +0800
Message-ID: <20231108113445.24825-3-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231108113445.24825-1-quic_luoj@quicinc.com>
References: <20231108113445.24825-1-quic_luoj@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fvOzj9TMZvlQ-kSYs1a4LdvOUxBGDe7w
X-Proofpoint-GUID: fvOzj9TMZvlQ-kSYs1a4LdvOUxBGDe7w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_01,2023-11-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311080097

Configure MSE detect threshold and ADC clock edge invert.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/net/phy/at803x.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index f2a0d1688159..6bea6e31caaa 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -280,6 +280,15 @@
 #define QCA8081_PHY_SERDES_MMD1_FIFO_CTRL	0x9072
 #define QCA8081_PHY_FIFO_RSTN			BIT(11)
 
+/* QCA8084 ADC clock edge */
+#define QCA8084_ADC_CLK_SEL			0x8b80
+#define QCA8084_ADC_CLK_SEL_ACLK		GENMASK(7, 4)
+#define QCA8084_ADC_CLK_SEL_ACLK_FALL		0xf
+#define QCA8084_ADC_CLK_SEL_ACLK_RISE		0x0
+
+#define QCA8084_MSE_THRESHOLD			0x800a
+#define QCA8084_MSE_THRESHOLD_2P5G_VAL		0x51c6
+
 MODULE_DESCRIPTION("Qualcomm Atheros AR803x and QCA808X PHY driver");
 MODULE_AUTHOR("Matus Ujhelyi");
 MODULE_LICENSE("GPL");
@@ -2077,6 +2086,23 @@ static void qca808x_link_change_notify(struct phy_device *phydev)
 			QCA8081_PHY_FIFO_RSTN, phydev->link ? QCA8081_PHY_FIFO_RSTN : 0);
 }
 
+static int qca8084_config_init(struct phy_device *phydev)
+{
+	int ret;
+
+	/* Invert ADC clock edge */
+	ret = at803x_debug_reg_mask(phydev, QCA8084_ADC_CLK_SEL,
+				    QCA8084_ADC_CLK_SEL_ACLK,
+				    FIELD_PREP(QCA8084_ADC_CLK_SEL_ACLK,
+					       QCA8084_ADC_CLK_SEL_ACLK_FALL));
+	if (ret < 0)
+		return ret;
+
+	/* Adjust MSE threshold value to avoid link issue with some link partner */
+	return phy_write_mmd(phydev, MDIO_MMD_PMAPMD,
+			     QCA8084_MSE_THRESHOLD, QCA8084_MSE_THRESHOLD_2P5G_VAL);
+}
+
 static struct phy_driver at803x_driver[] = {
 {
 	/* Qualcomm Atheros AR8035 */
@@ -2274,6 +2300,7 @@ static struct phy_driver at803x_driver[] = {
 	.soft_reset		= qca808x_soft_reset,
 	.cable_test_start	= qca808x_cable_test_start,
 	.cable_test_get_status	= qca808x_cable_test_get_status,
+	.config_init		= qca8084_config_init,
 }, };
 
 module_phy_driver(at803x_driver);
-- 
2.42.0


