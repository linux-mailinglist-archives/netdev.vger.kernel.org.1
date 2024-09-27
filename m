Return-Path: <netdev+bounces-130039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DC7987C5E
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 03:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66951B24FC4
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 01:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44619139D1B;
	Fri, 27 Sep 2024 01:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LXuNErBr"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D321386D1;
	Fri, 27 Sep 2024 01:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727399184; cv=none; b=eoZIWvjEy0tK5YrmPnA9VOrgx+aizwxaVu4Xt4t0R4r3CiFMH/4crnqiNduUE/9xLfAfim577clBbVP7Yu4BzYMsYG9QgJSm6BVMIqK2sv9DVo7qw3ge7/Kxk8JGa5CMI8k6Mdu3hjwC8382/t37VfsVCJ+S/75GAnme9iyeNkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727399184; c=relaxed/simple;
	bh=eAtDoMi7B+vRwGWGL3vxjmjSdR0s4vc3WtXWNkin+Rk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uE2yZidgBr65IxFJ/YMktxvhdesptCKpnvO7GozM77GaXb2ZAKkjdm7mGWV7E6aZRLEK/ZrDuI5rCuuM8U0binxNMV8m5eisebcAQgdghLuKzKB67QeovuS3R0iEn6LQD+VW0vYDI8z1CWsdgPIiE31kXhJQSs1o3jXJ+qInwsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LXuNErBr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48QG9mVQ002826;
	Fri, 27 Sep 2024 01:05:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=eYE1OvQ5B+9
	eztvmXCCmgcWT6Y5CiaA48OnAiw39nTk=; b=LXuNErBrGQlFuX5O2AqGu7jaRyX
	rQNk/kg8MQBgkccKFSgjdWQm3Yi7sR+KeGkRwr/L26FFaNKtM2d/9GBxiY1f0oi8
	DffQnpN2xOSWznu7RDoH4kkLx7+V51PVYf4JGKCYWNGMhfi6UoJHbghlcKeAo979
	m2G6iGeY5ozQ51XrXsy3E7ryJUxl7ASC8HABeg4P3eVghyjrHC8vaVwQ7ttWAEjY
	e+RlV/kHWqWF/ODYvZ+EjCI6gqklWmMy3bLE78W6eNfQ9kEb3kZ3vaQLmVhgjaUX
	0ulu0d+pIrVUXUykj3KHM8h0xNWF+lwMGJaWV3h5LhjvBioebNjUeZniQ7w==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41sqakrtnn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 01:05:55 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA04.qualcomm.com [127.0.0.1])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 48R15sUf000953;
	Fri, 27 Sep 2024 01:05:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 41wahhbpet-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 01:05:54 +0000
Received: from NALASPPMTA04.qualcomm.com (NALASPPMTA04.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48R15rmx000941;
	Fri, 27 Sep 2024 01:05:53 GMT
Received: from hu-devc-lv-u20-a-new.qualcomm.com (hu-abchauha-lv.qualcomm.com [10.81.25.35])
	by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 48R15roG000940
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 01:05:53 +0000
Received: by hu-devc-lv-u20-a-new.qualcomm.com (Postfix, from userid 214165)
	id 417232207E; Thu, 26 Sep 2024 18:05:53 -0700 (PDT)
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
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: kernel@quicinc.com
Subject: [PATCH net v4 2/2] net: phy: aquantia: remove usage of phy_set_max_speed
Date: Thu, 26 Sep 2024 18:05:53 -0700
Message-Id: <20240927010553.3557571-3-quic_abchauha@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240927010553.3557571-1-quic_abchauha@quicinc.com>
References: <20240927010553.3557571-1-quic_abchauha@quicinc.com>
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
X-Proofpoint-ORIG-GUID: qx0jjypZKxXFGbuyPWqtpmun7AToNmG4
X-Proofpoint-GUID: qx0jjypZKxXFGbuyPWqtpmun7AToNmG4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 suspectscore=0 phishscore=0 adultscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409270006

Remove the use of phy_set_max_speed in phy driver as the
function is mainly used in MAC driver to set the max
speed.

Instead use get_features to fix up Phy PMA capabilities for
AQR111, AQR111B0, AQR114C and AQCS109

Fixes: 038ba1dc4e54 ("net: phy: aquantia: add AQR111 and AQR111B0 PHY ID")
Fixes: 0974f1f03b07 ("net: phy: aquantia: remove false 5G and 10G speed ability for AQCS109")
Fixes: c278ec644377 ("net: phy: aquantia: add support for AQR114C PHY ID")
Link: https://lore.kernel.org/all/20240913011635.1286027-1-quic_abchauha@quicinc.com/T/
Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
---
Changes since v3
1. remove setting of 2500baseX bit introduced as
   part of previous patches.
2. follow reverse xmas declaration of variables.
3. remove local mask introduced as part of
   previous patch and optimize the logic.

Changes since v2
1. seperate out the changes into two different patches. 
2. use phy_gbit_features instead of initializing each and 
   every link mode bits. 
3. write seperate functions for 2.5Gbps supported phy. 
4. remove FIBRE bit which was introduced in patch 1.

Changes since v1 
1. remove usage of phy_set_max_speed in the aquantia driver code.
2. Introduce aqr_custom_get_feature which checks for the phy id and
   takes necessary actions based on max_speed supported by the phy.
3. remove aqr111_config_init as it is just a wrapper function. 

 drivers/net/phy/aquantia/aquantia_main.c | 51 +++++++++++++++---------
 1 file changed, 32 insertions(+), 19 deletions(-)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index af6784b118d2..73f4e67e14b6 100644
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
 
@@ -741,6 +735,31 @@ static int aqr113c_config_init(struct phy_device *phydev)
 	return aqr113c_fill_interface_modes(phydev);
 }
 
+static int aqr111_get_features(struct phy_device *phydev)
+{
+	unsigned long *supported = phydev->supported;
+	int ret;
+
+	/* Normal feature discovery */
+	ret = genphy_c45_pma_read_abilities(phydev);
+	if (ret)
+		return ret;
+
+	/* PHY FIXUP */
+	/* Although the PHY sets bit 12.18.19, it does not support 10G modes */
+	linkmode_clear_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT, supported);
+	linkmode_clear_bit(ETHTOOL_LINK_MODE_10000baseKX4_Full_BIT, supported);
+	linkmode_clear_bit(ETHTOOL_LINK_MODE_10000baseKR_Full_BIT, supported);
+
+	/* Phy supports Speeds up to 5G with Autoneg though the phy PMA says otherwise */
+	linkmode_or(supported, supported, phy_gbit_features);
+	/* Set the 5G speed if it wasn't set as part of the PMA feature discovery */
+	linkmode_set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT, supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, supported);
+
+	return 0;
+}
+
 static int aqr107_probe(struct phy_device *phydev)
 {
 	int ret;
@@ -757,16 +776,6 @@ static int aqr107_probe(struct phy_device *phydev)
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
 static int aqr115c_get_features(struct phy_device *phydev)
 {
 	unsigned long *supported = phydev->supported;
@@ -868,6 +877,7 @@ static struct phy_driver aqr_driver[] = {
 	.get_sset_count	= aqr107_get_sset_count,
 	.get_strings	= aqr107_get_strings,
 	.get_stats	= aqr107_get_stats,
+	.get_features   = aqr115c_get_features,
 	.link_change_notify = aqr107_link_change_notify,
 	.led_brightness_set = aqr_phy_led_brightness_set,
 	.led_hw_is_supported = aqr_phy_led_hw_is_supported,
@@ -880,7 +890,7 @@ static struct phy_driver aqr_driver[] = {
 	.name		= "Aquantia AQR111",
 	.probe		= aqr107_probe,
 	.get_rate_matching = aqr107_get_rate_matching,
-	.config_init	= aqr111_config_init,
+	.config_init	= aqr107_config_init,
 	.config_aneg    = aqr_config_aneg,
 	.config_intr	= aqr_config_intr,
 	.handle_interrupt = aqr_handle_interrupt,
@@ -892,6 +902,7 @@ static struct phy_driver aqr_driver[] = {
 	.get_sset_count	= aqr107_get_sset_count,
 	.get_strings	= aqr107_get_strings,
 	.get_stats	= aqr107_get_stats,
+	.get_features   = aqr111_get_features,
 	.link_change_notify = aqr107_link_change_notify,
 	.led_brightness_set = aqr_phy_led_brightness_set,
 	.led_hw_is_supported = aqr_phy_led_hw_is_supported,
@@ -904,7 +915,7 @@ static struct phy_driver aqr_driver[] = {
 	.name		= "Aquantia AQR111B0",
 	.probe		= aqr107_probe,
 	.get_rate_matching = aqr107_get_rate_matching,
-	.config_init	= aqr111_config_init,
+	.config_init	= aqr107_config_init,
 	.config_aneg    = aqr_config_aneg,
 	.config_intr	= aqr_config_intr,
 	.handle_interrupt = aqr_handle_interrupt,
@@ -916,6 +927,7 @@ static struct phy_driver aqr_driver[] = {
 	.get_sset_count	= aqr107_get_sset_count,
 	.get_strings	= aqr107_get_strings,
 	.get_stats	= aqr107_get_stats,
+	.get_features   = aqr111_get_features,
 	.link_change_notify = aqr107_link_change_notify,
 	.led_brightness_set = aqr_phy_led_brightness_set,
 	.led_hw_is_supported = aqr_phy_led_hw_is_supported,
@@ -1025,7 +1037,7 @@ static struct phy_driver aqr_driver[] = {
 	.name           = "Aquantia AQR114C",
 	.probe          = aqr107_probe,
 	.get_rate_matching = aqr107_get_rate_matching,
-	.config_init    = aqr111_config_init,
+	.config_init    = aqr107_config_init,
 	.config_aneg    = aqr_config_aneg,
 	.config_intr    = aqr_config_intr,
 	.handle_interrupt = aqr_handle_interrupt,
@@ -1037,6 +1049,7 @@ static struct phy_driver aqr_driver[] = {
 	.get_sset_count = aqr107_get_sset_count,
 	.get_strings    = aqr107_get_strings,
 	.get_stats      = aqr107_get_stats,
+	.get_features   = aqr111_get_features,
 	.link_change_notify = aqr107_link_change_notify,
 	.led_brightness_set = aqr_phy_led_brightness_set,
 	.led_hw_is_supported = aqr_phy_led_hw_is_supported,
-- 
2.25.1


