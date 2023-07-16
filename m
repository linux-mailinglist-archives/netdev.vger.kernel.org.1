Return-Path: <netdev+bounces-18101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA79B754DE9
	for <lists+netdev@lfdr.de>; Sun, 16 Jul 2023 10:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B088F1C209A0
	for <lists+netdev@lfdr.de>; Sun, 16 Jul 2023 08:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F881FBC;
	Sun, 16 Jul 2023 08:50:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B56A63D1
	for <netdev@vger.kernel.org>; Sun, 16 Jul 2023 08:50:11 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D78B1AB;
	Sun, 16 Jul 2023 01:50:10 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36G8l097006459;
	Sun, 16 Jul 2023 08:49:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=2KpKwl/ODSAHvAsOwzUmU6ojuL1xgCIvRpzU2AIFHKM=;
 b=mtxJdwTwj2K904Uy8HduUgqDYaqasSpZ6VIwVVy+bvE4Q/asM7ntzgKk7+3Tb1DVDnKd
 YTCjTM3TQwwZm9ne1jQbQNkvG9RW85fbA+XO7VzkJRdM9WvECrkShSzLAu99u7aTt0qi
 mYN9FYMaasDJCFE4XjDeKf8tV513EoQXK4rkjUchbk4NsKFDEddPO3IOhhSQEi2LZy9+
 fySVOSMPXmKPlgZV/g7GGZ98AQFk76EMmwZ8L2Yhnl019846kp1yRvOBrOSUOUF7o2lW
 z+VUhUspQcXeFzg6z6Rmg+PqcBL78Yh7gU0D500hp3WCIvT23kM2kwqCyd44nTbyqLh5 bA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3run09s9rc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 16 Jul 2023 08:49:57 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36G8nu99003535
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 16 Jul 2023 08:49:56 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sun, 16 Jul 2023 01:49:53 -0700
From: Luo Jie <quic_luoj@quicinc.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Luo Jie
	<quic_luoj@quicinc.com>
Subject: [PATCH v3 2/6] net: phy: at803x: merge qca8081 slave seed function
Date: Sun, 16 Jul 2023 16:49:20 +0800
Message-ID: <20230716084924.9714-3-quic_luoj@quicinc.com>
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
X-Proofpoint-ORIG-GUID: _BRLzGrBXM1ActxMrkZzGj_seYpVyjOD
X-Proofpoint-GUID: _BRLzGrBXM1ActxMrkZzGj_seYpVyjOD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-15_14,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307160081
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

merge the seed enablement and seed value configuration into
one function, since the random seed value is needed to be
configured when the seed is enabled.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/at803x.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index 11388ef3f7ef..1d4aef60d51a 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -1725,24 +1725,19 @@ static int qca808x_phy_fast_retrain_config(struct phy_device *phydev)
 	return 0;
 }
 
-static int qca808x_phy_ms_random_seed_set(struct phy_device *phydev)
-{
-	u16 seed_value = get_random_u32_below(QCA808X_MASTER_SLAVE_SEED_RANGE);
-
-	return at803x_debug_reg_mask(phydev, QCA808X_PHY_DEBUG_LOCAL_SEED,
-			QCA808X_MASTER_SLAVE_SEED_CFG,
-			FIELD_PREP(QCA808X_MASTER_SLAVE_SEED_CFG, seed_value));
-}
-
 static int qca808x_phy_ms_seed_enable(struct phy_device *phydev, bool enable)
 {
-	u16 seed_enable = 0;
+	u16 seed_value;
 
-	if (enable)
-		seed_enable = QCA808X_MASTER_SLAVE_SEED_ENABLE;
+	if (!enable)
+		return at803x_debug_reg_mask(phydev, QCA808X_PHY_DEBUG_LOCAL_SEED,
+				QCA808X_MASTER_SLAVE_SEED_ENABLE, 0);
 
+	seed_value = get_random_u32_below(QCA808X_MASTER_SLAVE_SEED_RANGE);
 	return at803x_debug_reg_mask(phydev, QCA808X_PHY_DEBUG_LOCAL_SEED,
-			QCA808X_MASTER_SLAVE_SEED_ENABLE, seed_enable);
+			QCA808X_MASTER_SLAVE_SEED_CFG | QCA808X_MASTER_SLAVE_SEED_ENABLE,
+			FIELD_PREP(QCA808X_MASTER_SLAVE_SEED_CFG, seed_value) |
+			QCA808X_MASTER_SLAVE_SEED_ENABLE);
 }
 
 static int qca808x_config_init(struct phy_device *phydev)
@@ -1766,12 +1761,7 @@ static int qca808x_config_init(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	/* Configure lower ramdom seed to make phy linked as slave mode */
-	ret = qca808x_phy_ms_random_seed_set(phydev);
-	if (ret)
-		return ret;
-
-	/* Enable seed */
+	/* Enable seed and configure lower ramdom seed to make phy linked as slave mode */
 	ret = qca808x_phy_ms_seed_enable(phydev, true);
 	if (ret)
 		return ret;
@@ -1816,7 +1806,6 @@ static int qca808x_read_status(struct phy_device *phydev)
 		if (phydev->master_slave_state == MASTER_SLAVE_STATE_ERR) {
 			qca808x_phy_ms_seed_enable(phydev, false);
 		} else {
-			qca808x_phy_ms_random_seed_set(phydev);
 			qca808x_phy_ms_seed_enable(phydev, true);
 		}
 	}
-- 
2.17.1


