Return-Path: <netdev+bounces-15318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE17B746CA1
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 11:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B4E31C20962
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 09:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048334695;
	Tue,  4 Jul 2023 09:01:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0A7468B
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 09:01:23 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724FD136;
	Tue,  4 Jul 2023 02:01:22 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3647SHfW001949;
	Tue, 4 Jul 2023 09:01:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=iuL3l82E6mA/+2tHzLNUByCLAF4ByaXEaGTYJkIsLzY=;
 b=n5nMroXvvgEFaQYgLDEcKIBeKTadk9FJGqm1RL7Bgc6FlPrB6bbB42xrP3dGcbgDnR5l
 cZ+LsZLWVZtepgks/PhK4lA4BdhMUH3d2a6WwyxT+3TwrVuZkMKDhwKFo1mRa48ls/Cx
 OZ2xqNHxi9TIqg7YxMYY3q5AbojYfaGDcXWfDvmT+4/PnTOcBqNgUEFGPfC3GC/1EtTk
 At4WusUKUvUr7AMBH4K73EvrQV3ps/HUSZtMh/wo/kn3vY/8h+pCZT4nJyeU0kOGuAsa
 1Z+30SOp1Ie24BExvucOCzQu/xQRwSxvi3PFsHNt0gbGUQGTRYwKSgkz+5Bn/Cqbf9y5 6Q== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rkv1dja4m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jul 2023 09:01:04 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 364911vO015662
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Jul 2023 09:01:01 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.7; Tue, 4 Jul 2023 02:00:58 -0700
From: Luo Jie <quic_luoj@quicinc.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Luo Jie
	<quic_luoj@quicinc.com>
Subject: [PATCH v1 2/2] net: phy: at803x: add qca8081 fifo reset on the link changed
Date: Tue, 4 Jul 2023 17:00:16 +0800
Message-ID: <20230704090016.7757-3-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230704090016.7757-1-quic_luoj@quicinc.com>
References: <20230704090016.7757-1-quic_luoj@quicinc.com>
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
X-Proofpoint-GUID: EyLBkwgWWsRMmhMM4RKx9KKzbQXv2e1i
X-Proofpoint-ORIG-GUID: EyLBkwgWWsRMmhMM4RKx9KKzbQXv2e1i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_04,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307040074
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The qca8081 sgmii fifo needs to be reset on link down and
released on the link up in case of any abnormal issue
such as the packet blocked on the PHY.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/net/phy/at803x.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index 86cb030e5ebf..c26dec1763f3 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -276,6 +276,9 @@
 #define QCA808X_PHY_MMD7_CHIP_TYPE		0x901d
 #define QCA808X_PHY_CHIP_TYPE_1G		BIT(0)
 
+#define QCA8081_PHY_SERDES_MMD1_FIFO_CTRL	0x9072
+#define QCA8081_PHY_FIFO_RSTN			BIT(11)
+
 MODULE_DESCRIPTION("Qualcomm Atheros AR803x and QCA808X PHY driver");
 MODULE_AUTHOR("Matus Ujhelyi");
 MODULE_LICENSE("GPL");
@@ -2018,6 +2021,16 @@ static int qca808x_get_features(struct phy_device *phydev)
 	return 0;
 }
 
+static void qca808x_link_change_notify(struct phy_device *phydev)
+{
+	/* Assert interface sgmii fifo on link down, deassert it on link up,
+	 * the interface device address is always phy address added by 1.
+	 */
+	mdiobus_c45_modify_changed(phydev->mdio.bus, phydev->mdio.addr + 1,
+			MDIO_MMD_PMAPMD, QCA8081_PHY_SERDES_MMD1_FIFO_CTRL,
+			QCA8081_PHY_FIFO_RSTN, phydev->link ? QCA8081_PHY_FIFO_RSTN : 0);
+}
+
 static struct phy_driver at803x_driver[] = {
 {
 	/* Qualcomm Atheros AR8035 */
@@ -2196,6 +2209,7 @@ static struct phy_driver at803x_driver[] = {
 	.soft_reset		= qca808x_soft_reset,
 	.cable_test_start	= qca808x_cable_test_start,
 	.cable_test_get_status	= qca808x_cable_test_get_status,
+	.link_change_notify	= qca808x_link_change_notify,
 }, };
 
 module_phy_driver(at803x_driver);
-- 
2.17.1


