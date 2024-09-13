Return-Path: <netdev+bounces-127984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5C3977653
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 03:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5241F1F242D6
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 01:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DF8139D;
	Fri, 13 Sep 2024 01:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mrCCHMbW"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688FF4A06;
	Fri, 13 Sep 2024 01:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726190222; cv=none; b=YmJWYdp7dGakka+0Ky5vTr3Ci0BKkBWbHuBEJYcjeZgGegRvPNUr3/AL2pxRVc/mAeH63nBEY/VtiayBUTLmkL9B1JrqD1zjAPEy/t+coRMwnqLGs8zDjn2Y6ROEf5Fst14srxlLLPXoAht6FKTbkAQESVHUtIIBjT0lQErZ394=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726190222; c=relaxed/simple;
	bh=E2gV8B8A3jzr/nMS2SjrXxg5bgvM29YhQivGU6jtdJc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jTRblFOadQtLTTEN44dpoZPHSiXxW0mxPgGgIgByJitmBWpKXOXmvSdPvS6ooyR20wiGdLKPlaTAPgMXh9G3L0IHncrSDDw5makRPmK8lyQWFivYXdYM1+gB7qR5nMo393a7ajTgx+9wfQLUNB8uD0T0lFTs7PSHa+JREzQLTnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mrCCHMbW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48CMCD0f026534;
	Fri, 13 Sep 2024 01:16:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=/hXxj2sLevdSYIfC94W0db/OYZ+/bHx9gEI
	VaF2ne9E=; b=mrCCHMbWi/TZvRcuAjoKa2mbPWc0lJuqrJZYjbVGYej7qBqi67D
	TmyS6kPkoeOGjVwOfJiA7IX+DCtstO0VIpYDMojnZDFTEGIXy4WhkZV06I019FbT
	zASqsYfUKD6lBJk9YTfhP9Ghv/nS4gre+D8zoaNc/2f282O086pL0nuJ0HOqH6g3
	Yu1srAuOjLwmxlc8a8rZb1Zk+7c/A2UC/qNcCk0Ytyv/rw3A5gRsuaUKMHVTPOb8
	Z9Er98wJEZ8h1sBNA+8x55GVdBUCrTYpNIfvAzKZNgLmsewpLGFs0fenTLBAW+Ku
	BrN+V5oX9taWh8x2w9BPdz83Vw+Fto/GlbA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gy8p764t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 01:16:37 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA03.qualcomm.com [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 48D1Gamg002243;
	Fri, 13 Sep 2024 01:16:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 41kxud4yt5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 01:16:36 +0000
Received: from NALASPPMTA03.qualcomm.com (NALASPPMTA03.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48D1GaUb002238;
	Fri, 13 Sep 2024 01:16:36 GMT
Received: from hu-devc-lv-u20-a-new.qualcomm.com (hu-abchauha-lv.qualcomm.com [10.81.25.35])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 48D1GZ68002235
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 01:16:36 +0000
Received: by hu-devc-lv-u20-a-new.qualcomm.com (Postfix, from userid 214165)
	id 77FF522114; Thu, 12 Sep 2024 18:16:35 -0700 (PDT)
From: Abhishek Chauhan <quic_abchauha@quicinc.com>
To: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Brad Griffis <bgriffis@nvidia.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Jon Hunter <jonathanh@nvidia.com>
Cc: kernel@quicinc.com
Subject: [RFC PATCH net v1] net: phy: aquantia: Set phy speed to 2.5gbps for AQR115c
Date: Thu, 12 Sep 2024 18:16:35 -0700
Message-Id: <20240913011635.1286027-1-quic_abchauha@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qxWp5TY8iCz_57xYBxdGvkQvHTJcQ3m0
X-Proofpoint-ORIG-GUID: qxWp5TY8iCz_57xYBxdGvkQvHTJcQ3m0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 impostorscore=0 mlxscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409130008

Recently we observed that aquantia AQR115c always comes up in
100Mbps mode. AQR115c aquantia chip supports max speed up to
2.5Gbps. Today the AQR115c configuration is done through
aqr113c_config_init which internally calls aqr107_config_init.
aqr113c and aqr107 are both capable of 10Gbps. Whereas AQR115c
supprts max speed of 2.5Gbps only.

Fixes: 0ebc581f8a4b ("net: phy: aquantia: add support for aqr115c")
Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
---
 drivers/net/phy/aquantia/aquantia_main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index e982e9ce44a5..9afc041dbb64 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -499,6 +499,12 @@ static int aqr107_config_init(struct phy_device *phydev)
 	if (!ret)
 		aqr107_chip_info(phydev);
 
+	/* AQR115c supports speed up to 2.5Gbps */
+	if (phydev->interface == PHY_INTERFACE_MODE_2500BASEX) {
+		phy_set_max_speed(phydev, SPEED_2500);
+		phydev->autoneg = AUTONEG_ENABLE;
+	}
+
 	ret = aqr107_set_downshift(phydev, MDIO_AN_VEND_PROV_DOWNSHIFT_DFLT);
 	if (ret)
 		return ret;
@@ -1036,6 +1042,7 @@ static struct phy_driver aqr_driver[] = {
 	.get_sset_count = aqr107_get_sset_count,
 	.get_strings    = aqr107_get_strings,
 	.get_stats      = aqr107_get_stats,
+	.get_features	= genphy_c45_pma_read_abilities,
 	.link_change_notify = aqr107_link_change_notify,
 	.led_brightness_set = aqr_phy_led_brightness_set,
 	.led_hw_is_supported = aqr_phy_led_hw_is_supported,
-- 
2.25.1


