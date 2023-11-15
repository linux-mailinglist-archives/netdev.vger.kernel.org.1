Return-Path: <netdev+bounces-48014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D5D7EC4C7
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 15:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FC942814A4
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 14:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EB928DC1;
	Wed, 15 Nov 2023 14:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="K5PK/9VB"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F40A930;
	Wed, 15 Nov 2023 14:09:29 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C70D134;
	Wed, 15 Nov 2023 06:09:27 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFD02AT026672;
	Wed, 15 Nov 2023 14:09:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=xoUh7MWwDswQU0Qbcu6kSaukCEbi0jZ75coOg98MRMg=;
 b=K5PK/9VBZEJj5RBVxg3ugsGs3aPcMEYBiDPEPEjEdGKv/PKFddVMLli5HpT2eSKnN/L8
 DFldKksWZKStNO3bw3VnELKOGilTfY4LRzTNosE/keFFoJB0snDNRBcFpUO6S8TgbgwV
 0zhFoTM9cgg080ZpIBYEsvpQuDG4Wn+ZiT9ikGefbry7QTMf97AF+7b4wgW5FP+mnLCW
 QuKcnfvXAJCC7mzY5LoKHgaq8kPiqyJSCx9EQC13nw6bOIIWwNho3Ww50zAjjxEiUsVg
 qXjCKNQimq68Sq7/eEZhfKdmAPGj5DVd0X9r8p+UcmrtfuYTSf1Ao8JVHd8KiESpHvma qg== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ucba6tvwm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Nov 2023 14:09:12 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AFE8tFK015451
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Nov 2023 14:08:55 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 15 Nov 2023 06:08:53 -0800
From: Luo Jie <quic_luoj@quicinc.com>
To: <andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <corbet@lwn.net>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v3 5/6] net: phy: at803x: Add qca8084_config_init function
Date: Wed, 15 Nov 2023 22:06:29 +0800
Message-ID: <20231115140630.10858-6-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115140630.10858-1-quic_luoj@quicinc.com>
References: <20231115140630.10858-1-quic_luoj@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yG2cd-iI8o591zMvfcO-164SPwdc8QDN
X-Proofpoint-ORIG-GUID: yG2cd-iI8o591zMvfcO-164SPwdc8QDN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_12,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 suspectscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999 phishscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311150110

Configure MSE detect threshold and ADC clock edge invert.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/net/phy/at803x.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index f56202f5944d..06a068ca5539 100644
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
@@ -2083,6 +2092,23 @@ static void qca808x_link_change_notify(struct phy_device *phydev)
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
@@ -2280,6 +2306,7 @@ static struct phy_driver at803x_driver[] = {
 	.soft_reset		= qca808x_soft_reset,
 	.cable_test_start	= qca808x_cable_test_start,
 	.cable_test_get_status	= qca808x_cable_test_get_status,
+	.config_init		= qca8084_config_init,
 }, };
 
 module_phy_driver(at803x_driver);
-- 
2.42.0


