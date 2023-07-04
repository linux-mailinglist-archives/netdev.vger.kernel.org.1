Return-Path: <netdev+bounces-15320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FA5746CA6
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 11:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C6472809C6
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 09:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95F8539E;
	Tue,  4 Jul 2023 09:01:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954DF525D
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 09:01:24 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A906187;
	Tue,  4 Jul 2023 02:01:23 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3648CoMG018740;
	Tue, 4 Jul 2023 09:01:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=FQkekfTI0PKvU45dvP42dB4XAjTpQUPvPCB56jNDlUE=;
 b=SnLN3MSWsxxUN8C8nrQqv+vBwcXwYxHEMW5pVXeqawc4A819Lx0nVrzRwecfI6qiWjbJ
 f+ewJnu9a0SmJUDZaJjKSY9WURSFF9ygFs6Yu1xtC66uHpnsPAqiBXRbC3pOre3YQoUd
 CZCWy1K6VCzLEr4uV0Uqwd1RM8prrxt5lPa8JUBP5KYwk8SoYC45cyx1UhPSbZjj9eOd
 oPmTOTKFZn6xThRswzzLm9FhZIMeN8QDRyMuC/+68ri9e72I0LtFYLdamhElsnM6CpNh
 VFGZSLFNSJBZnDlQ0PNODjL58mvlUXrBwctM0PJ2I+O3MJKqB9olhYvHHIoVpjuYTb0m ZQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rm14jhh4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jul 2023 09:01:01 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36490wXv025007
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Jul 2023 09:00:58 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.7; Tue, 4 Jul 2023 02:00:55 -0700
From: Luo Jie <quic_luoj@quicinc.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Luo Jie
	<quic_luoj@quicinc.com>
Subject: [PATCH v1 1/2] net: phy: at803x: support qca8081 1G chip type
Date: Tue, 4 Jul 2023 17:00:15 +0800
Message-ID: <20230704090016.7757-2-quic_luoj@quicinc.com>
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
X-Proofpoint-GUID: OWj6sUCJYbe_-zFhZvrcQXroGnz9IcoK
X-Proofpoint-ORIG-GUID: OWj6sUCJYbe_-zFhZvrcQXroGnz9IcoK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_04,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 impostorscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307040074
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The qca8081 1G chip version does not support 2.5 capability, which
is distinguished from qca8081 2.5G chip according to the bit0 of
register mmd7.0x901d.

The fast retrain and master slave seed configs are only needed when
the 2.5G capability is supported.

Switch to use genphy_c45_pma_read_abilities for .get_features API.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/net/phy/at803x.c | 81 ++++++++++++++++++++++++++--------------
 1 file changed, 54 insertions(+), 27 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index c1f307d90518..86cb030e5ebf 100644
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
@@ -897,15 +901,6 @@ static int at803x_get_features(struct phy_device *phydev)
 	if (err)
 		return err;
 
-	if (phydev->drv->phy_id == QCA8081_PHY_ID) {
-		err = phy_read_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_PMA_NG_EXTABLE);
-		if (err < 0)
-			return err;
-
-		linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, phydev->supported,
-				err & MDIO_PMA_NG_EXTABLE_2_5GBT);
-	}
-
 	if (phydev->drv->phy_id != ATH8031_PHY_ID)
 		return 0;
 
@@ -1770,20 +1765,22 @@ static int qca808x_config_init(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	/* Config the fast retrain for the link 2500M */
-	ret = qca808x_phy_fast_retrain_config(phydev);
-	if (ret)
-		return ret;
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, phydev->supported)) {
+		/* Config the fast retrain for the link 2500M */
+		ret = qca808x_phy_fast_retrain_config(phydev);
+		if (ret)
+			return ret;
 
-	/* Configure lower ramdom seed to make phy linked as slave mode */
-	ret = qca808x_phy_ms_random_seed_set(phydev);
-	if (ret)
-		return ret;
+		/* Configure lower ramdom seed to make phy linked as slave mode */
+		ret = qca808x_phy_ms_random_seed_set(phydev);
+		if (ret)
+			return ret;
 
-	/* Enable seed */
-	ret = qca808x_phy_ms_seed_enable(phydev, true);
-	if (ret)
-		return ret;
+		/* Enable seed */
+		ret = qca808x_phy_ms_seed_enable(phydev, true);
+		if (ret)
+			return ret;
+	}
 
 	/* Configure adc threshold as 100mv for the link 10M */
 	return at803x_debug_reg_mask(phydev, QCA808X_PHY_DEBUG_ADC_THRESHOLD,
@@ -1822,11 +1819,13 @@ static int qca808x_read_status(struct phy_device *phydev)
 		 * value is configured as the same value, the link can't be up and no link change
 		 * occurs.
 		 */
-		if (phydev->master_slave_state == MASTER_SLAVE_STATE_ERR) {
-			qca808x_phy_ms_seed_enable(phydev, false);
-		} else {
-			qca808x_phy_ms_random_seed_set(phydev);
-			qca808x_phy_ms_seed_enable(phydev, true);
+		if (linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, phydev->supported)) {
+			if (phydev->master_slave_state == MASTER_SLAVE_STATE_ERR) {
+				qca808x_phy_ms_seed_enable(phydev, false);
+			} else {
+				qca808x_phy_ms_random_seed_set(phydev);
+				qca808x_phy_ms_seed_enable(phydev, true);
+			}
 		}
 	}
 
@@ -1991,6 +1990,34 @@ static int qca808x_cable_test_get_status(struct phy_device *phydev, bool *finish
 	return 0;
 }
 
+static int qca808x_get_features(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = genphy_c45_pma_read_abilities(phydev);
+	if (ret)
+		return ret;
+
+	/* The autoneg ability is not existed in bit3 of MMD7.1,
+	 * but it is supported by qca808x PHY, so we add it here
+	 * manually.
+	 */
+	linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, phydev->supported);
+
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
+	return 0;
+}
+
 static struct phy_driver at803x_driver[] = {
 {
 	/* Qualcomm Atheros AR8035 */
@@ -2160,7 +2187,7 @@ static struct phy_driver at803x_driver[] = {
 	.set_tunable		= at803x_set_tunable,
 	.set_wol		= at803x_set_wol,
 	.get_wol		= at803x_get_wol,
-	.get_features		= at803x_get_features,
+	.get_features		= qca808x_get_features,
 	.config_aneg		= at803x_config_aneg,
 	.suspend		= genphy_suspend,
 	.resume			= genphy_resume,
-- 
2.17.1


