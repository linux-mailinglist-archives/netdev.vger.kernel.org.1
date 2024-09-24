Return-Path: <netdev+bounces-129425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AC5983C83
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 07:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69B991C20BC4
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 05:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AC548CFC;
	Tue, 24 Sep 2024 05:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EF636BeV"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597221FB4;
	Tue, 24 Sep 2024 05:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727157200; cv=none; b=oJlddt3VuSTlWnae1W93AfaWWvnJvIQGT1W356MrRwB5C8uI7xauDQXbYJKiJAb2PhC7BR2e85LQi/pbxT+1F2vBkZ2xDVgwHqAYoMeIIcWgteQNa/7gAkkSUsksbj41784rAtQPlSXDs6OuMl/UZiLEMfQDVngX7tz3TnZv5mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727157200; c=relaxed/simple;
	bh=V18ygPbLM4ZCWjISmoNo8ENeNOaYX2Ogx/Ok5AaJnus=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IX8laioBr9eP/9F7xT4DSDM0FupjLoge4gTswdVD92p1PjvybFcalDeN2e0jo1/OHYjQ/GOwLUdXQBK5paD2uGoTemwrt8wv/nBbz5KEAznKqSTJFZn21TE8rttPhJVBUOYTi4v2ZMTkGFkOFkiXUQs/KGivunaVUmnTLpfnT0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EF636BeV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48NLdNYM011775;
	Tue, 24 Sep 2024 05:52:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=kFcB0e+kn21msd0XWACkrhAAekjJjEh12SL
	Or3cHgUM=; b=EF636BeVSjgbHG6xtTW86XAW/RBTaMBFrSFnN5doUnO31XMMCVI
	/ltLvAHInLPs7S71b4OokBtceKGjWm/a0GYRsF5s9RnxZjQeQ3pkR7MB+ryH0x4y
	CjE/BoH3Etg/X0ewiSCaAYtvVoGH5PSGK+EbUky/x60FdwjmDjRHWZrN+tqtQYi1
	h/1yLQruWWRm/qdo6gP8QHLiebZCws5yMQEatTK+zCNkmh1PoOqpaTMudzBHSFxG
	w1JPSr/ZJ8rSx0S+z+mE3EqCiw1LeXlbsjFG4nM7nDrgQL3/cAG8lf+ppywuiNky
	gWrl5GZjiYTzZPrbPnHI+7GIkFDNL3FyqsA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41sph6qcjy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 05:52:54 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA02.qualcomm.com [127.0.0.1])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 48O5j6HJ031414;
	Tue, 24 Sep 2024 05:52:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 41ugm9b44j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 05:52:52 +0000
Received: from NALASPPMTA02.qualcomm.com (NALASPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48O5qqSE010623;
	Tue, 24 Sep 2024 05:52:52 GMT
Received: from hu-devc-lv-u20-a-new.qualcomm.com (hu-abchauha-lv.qualcomm.com [10.81.25.35])
	by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 48O5qqiT010622
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 05:52:52 +0000
Received: by hu-devc-lv-u20-a-new.qualcomm.com (Postfix, from userid 214165)
	id 012DE21B99; Mon, 23 Sep 2024 22:52:51 -0700 (PDT)
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
        Jon Hunter <jonathanh@nvidia.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: kernel@quicinc.com
Subject: [PATCH net v2] net: phy: aquantia: Introduce custom get_features
Date: Mon, 23 Sep 2024 22:52:51 -0700
Message-Id: <20240924055251.3074850-1-quic_abchauha@quicinc.com>
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
X-Proofpoint-GUID: VWIIQgYI3Hfzu3EfJZEJka7Z7_iNnShN
X-Proofpoint-ORIG-GUID: VWIIQgYI3Hfzu3EfJZEJka7Z7_iNnShN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxlogscore=999
 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409240038

Remove the use of phy_set_max_speed in phy driver as the
function is mainly used in MAC driver to set the max
speed.

Introduce custom get_features for AQR family of chipsets

1. such as AQR111/B0/114c which supports speeds up to 5Gbps
2. such as AQR115c/AQCS109 which supports speeds up to 2.5Gbps

Fixes: 038ba1dc4e54 ("net: phy: aquantia: add AQR111 and AQR111B0 PHY ID")
Fixes: 0974f1f03b07 ("net: phy: aquantia: remove false 5G and 10G speed ability for AQCS109")
Fixes: c278ec644377 ("net: phy: aquantia: add support for AQR114C PHY ID")
Fixes: 0ebc581f8a4b ("net: phy: aquantia: add support for aqr115c")
Link: https://lore.kernel.org/all/20240913011635.1286027-1-quic_abchauha@quicinc.com/T/
Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
---
Changes since v1 
1. remove usage of phy_set_max_speed in the aquantia driver code.
2. Introduce aqr_custom_get_feature which checks for the phy id and
   takes necessary actions based on max_speed supported by the phy
3. remove aqr111_config_init as it is just a wrapper function. 

output from my device looks like :- 
1. Link is up with 2.5Gbps with 2500BaseX with autoneg on.


Settings for eth0:
        Supported ports: [ TP    FIBRE ]
        Supported link modes:   10baseT/Full
                                100baseT/Full
                                1000baseT/Full
                                2500baseX/Full
                                2500baseT/Full
        Supported pause frame use: Symmetric Receive-only
        Supports auto-negotiation: Yes
        Supported FEC modes: Not reported
        Advertised link modes:  10baseT/Full
                                100baseT/Full
                                1000baseT/Full
                                2500baseX/Full
                                2500baseT/Full



 drivers/net/phy/aquantia/aquantia_main.c | 71 +++++++++++++++++-------
 1 file changed, 52 insertions(+), 19 deletions(-)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index e982e9ce44a5..53e7e25f3c85 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -527,12 +527,6 @@ static int aqcs109_config_init(struct phy_device *phydev)
 	if (!ret)
 		aqr107_chip_info(phydev);
 
-	/* AQCS109 belongs to a chip family partially supporting 10G and 5G.
-	 * PMA speed ability bits are the same for all members of the family,
-	 * AQCS109 however supports speeds up to 2.5G only.
-	 */
-	phy_set_max_speed(phydev, SPEED_2500);
-
 	return aqr107_set_downshift(phydev, MDIO_AN_VEND_PROV_DOWNSHIFT_DFLT);
 }
 
@@ -639,6 +633,50 @@ static int aqr107_resume(struct phy_device *phydev)
 	return aqr107_wait_processor_intensive_op(phydev);
 }
 
+static void aqr_supported_speed(struct phy_device *phydev, u32 max_speed)
+{
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported) = { 0, };
+
+	linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT, supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_FIBRE_BIT, supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_TP_BIT, supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT, supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT, supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT, supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT, supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Half_BIT, supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, supported);
+
+	if (max_speed == SPEED_2500) {
+		linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseX_Full_BIT, supported);
+		linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, supported);
+	} else if (max_speed == SPEED_5000) {
+		linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseX_Full_BIT, supported);
+		linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, supported);
+		linkmode_set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT, supported);
+	}
+
+	linkmode_copy(phydev->supported, supported);
+}
+
+static int aqr_custom_get_feature(struct phy_device *phydev)
+{
+	switch (phydev->drv->phy_id) {
+	case PHY_ID_AQR115C:
+	case PHY_ID_AQCS109:
+		aqr_supported_speed(phydev, SPEED_2500);
+	break;
+	case PHY_ID_AQR111:
+	case PHY_ID_AQR111B0:
+	case PHY_ID_AQR114C:
+		aqr_supported_speed(phydev, SPEED_5000);
+	break;
+	}
+	return 0;
+}
+
 static const u16 aqr_global_cfg_regs[] = {
 	VEND1_GLOBAL_CFG_10M,
 	VEND1_GLOBAL_CFG_100M,
@@ -757,16 +795,6 @@ static int aqr107_probe(struct phy_device *phydev)
 	return aqr_hwmon_probe(phydev);
 }
 
-static int aqr111_config_init(struct phy_device *phydev)
-{
-	/* AQR111 reports supporting speed up to 10G,
-	 * however only speeds up to 5G are supported.
-	 */
-	phy_set_max_speed(phydev, SPEED_5000);
-
-	return aqr107_config_init(phydev);
-}
-
 static struct phy_driver aqr_driver[] = {
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQ1202),
@@ -843,6 +871,7 @@ static struct phy_driver aqr_driver[] = {
 	.get_sset_count	= aqr107_get_sset_count,
 	.get_strings	= aqr107_get_strings,
 	.get_stats	= aqr107_get_stats,
+	.get_features	= aqr_custom_get_feature,
 	.link_change_notify = aqr107_link_change_notify,
 	.led_brightness_set = aqr_phy_led_brightness_set,
 	.led_hw_is_supported = aqr_phy_led_hw_is_supported,
@@ -855,7 +884,7 @@ static struct phy_driver aqr_driver[] = {
 	.name		= "Aquantia AQR111",
 	.probe		= aqr107_probe,
 	.get_rate_matching = aqr107_get_rate_matching,
-	.config_init	= aqr111_config_init,
+	.config_init	= aqr107_config_init,
 	.config_aneg    = aqr_config_aneg,
 	.config_intr	= aqr_config_intr,
 	.handle_interrupt = aqr_handle_interrupt,
@@ -867,6 +896,7 @@ static struct phy_driver aqr_driver[] = {
 	.get_sset_count	= aqr107_get_sset_count,
 	.get_strings	= aqr107_get_strings,
 	.get_stats	= aqr107_get_stats,
+	.get_features	= aqr_custom_get_feature,
 	.link_change_notify = aqr107_link_change_notify,
 	.led_brightness_set = aqr_phy_led_brightness_set,
 	.led_hw_is_supported = aqr_phy_led_hw_is_supported,
@@ -879,7 +909,7 @@ static struct phy_driver aqr_driver[] = {
 	.name		= "Aquantia AQR111B0",
 	.probe		= aqr107_probe,
 	.get_rate_matching = aqr107_get_rate_matching,
-	.config_init	= aqr111_config_init,
+	.config_init	= aqr107_config_init,
 	.config_aneg    = aqr_config_aneg,
 	.config_intr	= aqr_config_intr,
 	.handle_interrupt = aqr_handle_interrupt,
@@ -891,6 +921,7 @@ static struct phy_driver aqr_driver[] = {
 	.get_sset_count	= aqr107_get_sset_count,
 	.get_strings	= aqr107_get_strings,
 	.get_stats	= aqr107_get_stats,
+	.get_features	= aqr_custom_get_feature,
 	.link_change_notify = aqr107_link_change_notify,
 	.led_brightness_set = aqr_phy_led_brightness_set,
 	.led_hw_is_supported = aqr_phy_led_hw_is_supported,
@@ -1000,7 +1031,7 @@ static struct phy_driver aqr_driver[] = {
 	.name           = "Aquantia AQR114C",
 	.probe          = aqr107_probe,
 	.get_rate_matching = aqr107_get_rate_matching,
-	.config_init    = aqr111_config_init,
+	.config_init    = aqr107_config_init,
 	.config_aneg    = aqr_config_aneg,
 	.config_intr    = aqr_config_intr,
 	.handle_interrupt = aqr_handle_interrupt,
@@ -1012,6 +1043,7 @@ static struct phy_driver aqr_driver[] = {
 	.get_sset_count = aqr107_get_sset_count,
 	.get_strings    = aqr107_get_strings,
 	.get_stats      = aqr107_get_stats,
+	.get_features	= aqr_custom_get_feature,
 	.link_change_notify = aqr107_link_change_notify,
 	.led_brightness_set = aqr_phy_led_brightness_set,
 	.led_hw_is_supported = aqr_phy_led_hw_is_supported,
@@ -1036,6 +1068,7 @@ static struct phy_driver aqr_driver[] = {
 	.get_sset_count = aqr107_get_sset_count,
 	.get_strings    = aqr107_get_strings,
 	.get_stats      = aqr107_get_stats,
+	.get_features	= aqr_custom_get_feature,
 	.link_change_notify = aqr107_link_change_notify,
 	.led_brightness_set = aqr_phy_led_brightness_set,
 	.led_hw_is_supported = aqr_phy_led_hw_is_supported,
-- 
2.25.1


