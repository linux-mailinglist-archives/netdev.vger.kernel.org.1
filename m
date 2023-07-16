Return-Path: <netdev+bounces-18102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 359ED754DEA
	for <lists+netdev@lfdr.de>; Sun, 16 Jul 2023 10:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45EE02815B2
	for <lists+netdev@lfdr.de>; Sun, 16 Jul 2023 08:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6165C63C9;
	Sun, 16 Jul 2023 08:50:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A0D6FA5
	for <netdev@vger.kernel.org>; Sun, 16 Jul 2023 08:50:15 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C671AB;
	Sun, 16 Jul 2023 01:50:14 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36G8KcDZ002595;
	Sun, 16 Jul 2023 08:50:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=fE6woKC+MEbN7eHkBk0cpK6nMHDHlI/VJsOjmyACTZg=;
 b=KomfUsBfVwg3OEl16wuYfyTtcCwZL1jiDfauqYYaZlKrsVhaZ8ZN7F8xYvk3azOB3wJr
 ADjVmKbmXsBbHo/Ib0CUPGiTr2w5dx/Bmo9TzgWPCcq7dsDepWl7PgQMv7ztYHNsOdz0
 c1YWs/IfrJWiO15QGPMuV0WeQR6ObokmwGgZbK5IBN7kFYa7pZsxOh3jwYEfreGbB6KQ
 xVLcon5p0zOdrV1/rIS2PDtCrk26zXCR41KiQpsM7M/NYit5senwt25FaNdsLeEGpA+I
 BtsOxktxpiq86PqyxkvjXFWo8X1WKFKmycVVV93mc1PWmckNPYfPD4NeT/XkAVf/IA2Z bw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3run1j99m2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 16 Jul 2023 08:50:02 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36G8o1uY022994
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 16 Jul 2023 08:50:01 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sun, 16 Jul 2023 01:49:58 -0700
From: Luo Jie <quic_luoj@quicinc.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Luo Jie
	<quic_luoj@quicinc.com>
Subject: [PATCH v3 4/6] net: phy: at803x: support qca8081 1G chip type
Date: Sun, 16 Jul 2023 16:49:22 +0800
Message-ID: <20230716084924.9714-5-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230716084924.9714-1-quic_luoj@quicinc.com>
References: <20230716084924.9714-1-quic_luoj@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fjbJqCm-blb04ARLS00kAjiQNwGJJVAg
X-Proofpoint-ORIG-GUID: fjbJqCm-blb04ARLS00kAjiQNwGJJVAg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-15_14,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 clxscore=1015 malwarescore=0 adultscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307160081
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The qca8081 1G chip version does not support 2.5 capability, which
is distinguished from qca8081 2.5G chip according to the bit0 of
register mmd7.0x901d, the 1G version chip also has the same PHY ID
as the normal qca8081 2.5G chip.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/at803x.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index 6cdc1b8f8c4d..cb4c45c81a85 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -272,6 +272,10 @@
 #define QCA808X_CDT_STATUS_STAT_OPEN		2
 #define QCA808X_CDT_STATUS_STAT_SHORT		3
 
+/* QCA808X 1G chip type */
+#define QCA808X_PHY_MMD7_CHIP_TYPE		0x901d
+#define QCA808X_PHY_CHIP_TYPE_1G		BIT(0)
+
 MODULE_DESCRIPTION("Qualcomm Atheros AR803x and QCA808X PHY driver");
 MODULE_AUTHOR("Matus Ujhelyi");
 MODULE_LICENSE("GPL");
@@ -2000,6 +2004,17 @@ static int qca808x_get_features(struct phy_device *phydev)
 	 */
 	linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, phydev->supported);
 
+	/* As for the qca8081 1G version chip, the 2500baseT ability is also
+	 * existed in the bit0 of MMD1.21, we need to remove it manually if
+	 * it is the qca8081 1G chip according to the bit0 of MMD7.0x901d.
+	 */
+	ret = phy_read_mmd(phydev, MDIO_MMD_AN, QCA808X_PHY_MMD7_CHIP_TYPE);
+	if (ret < 0)
+		return ret;
+
+	if (QCA808X_PHY_CHIP_TYPE_1G & ret)
+		linkmode_clear_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, phydev->supported);
+
 	return 0;
 }
 
-- 
2.17.1


