Return-Path: <netdev+bounces-131082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0E398C856
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 00:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47858B2270F
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 22:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE30E1CEE84;
	Tue,  1 Oct 2024 22:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iLDs8TPw"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1281719AD8D;
	Tue,  1 Oct 2024 22:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727822814; cv=none; b=MDP9NPfjjkNQgec49aHxnORASKMMm0U2XO8Yw6GdxD42fUk95OxBE+hjw7E6NyraohvnCNMXrI1BcUmJMRs26DXobKZriJw0eHKnglBYVpKNwQP99Hl4nJsW38+sZz6NofW9gUI1Pha0tc3v1L03jKMna40zf4LFy/lGtOkldxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727822814; c=relaxed/simple;
	bh=eRLn8e0XkupbfZ5IW14NLWXdWA1fZK4AkDr32qLaf0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cEbx60XgeJnmIuAP9JJH0EJES4Y57whK1494xGO4bAkRJD+YLKKubtVIJLcC/Wvp78BuQF19i7hH0wL/VF2kKuG2IQ+NZBu1C+eKiSfZd0eUFsvkBL8+hp3syYhmnvIgLZdFY38QTtGdn+8RektwsVJZz6R8S4VzPfDfL1UTFnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iLDs8TPw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 491L2Zgl007235;
	Tue, 1 Oct 2024 22:46:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=+gQXce0lXoR
	eRi8SO6oBQM6Xlh14ipG0UmhMfrOHfKw=; b=iLDs8TPwDipPowXAx1sl6/+/tCQ
	0XFUDyjdYuJ4Fn/tiX7MkvaPk6hV1xAfVwHgvEVrt4gNTgxjE3nJ86sQI1MdYGYO
	MOVQ3QmuSfryP3bk/30LhEUSwa1Cn2xxkLpxF1XZMx4dEeFZCtA/5ysZZ43yrRJ6
	w8s9Mz3vOxTMG1z0OhbYE7zMRScluOH60u7Sx4BytP427Yg8ZPOg2Cw3daTN3LWv
	o/IZLs8EJJsXryB+zqezOd3Yy+l9Pzv8W2mHbvvvvnZQ9SXF3+lhQa7VK24RZVsR
	Lb1cj7jF+QMYfn8UCPEpvZVVvg2ExS8k6OW0AkDa+9wRsKsnk7h6rHsQQ2g==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41x9cyhy01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 22:46:29 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA02.qualcomm.com [127.0.0.1])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 491MkQJO005723;
	Tue, 1 Oct 2024 22:46:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 41ytj3ew04-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 22:46:26 +0000
Received: from NALASPPMTA02.qualcomm.com (NALASPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 491MkQVh005718;
	Tue, 1 Oct 2024 22:46:26 GMT
Received: from hu-devc-lv-u20-a-new.qualcomm.com (hu-abchauha-lv.qualcomm.com [10.81.25.35])
	by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 491MkQGv005716
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 22:46:26 +0000
Received: by hu-devc-lv-u20-a-new.qualcomm.com (Postfix, from userid 214165)
	id 232B7235E1; Tue,  1 Oct 2024 15:46:26 -0700 (PDT)
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
Subject: [PATCH net v6 2/2] net: phy: aquantia: remove usage of phy_set_max_speed
Date: Tue,  1 Oct 2024 15:46:26 -0700
Message-Id: <20241001224626.2400222-3-quic_abchauha@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241001224626.2400222-1-quic_abchauha@quicinc.com>
References: <20241001224626.2400222-1-quic_abchauha@quicinc.com>
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
X-Proofpoint-GUID: zmfSY8lM4S3GC3aciIKYgEz4bZa4orRr
X-Proofpoint-ORIG-GUID: zmfSY8lM4S3GC3aciIKYgEz4bZa4orRr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=999 impostorscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2410010151

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
Changes since v5
1. Minor comments addressed to not exceed 80 columns. 

Changes since v4
1. Forget about asking hardware for PMA capabilites.
2. Just set the Gbits features along with 2.5Gbps support 
   for AQCS109 Phy chip. 
3. Just set the Gbits features along with 5Gbps support 
   for AQR111, AQR111B0 and AQR114C Phy chips. 
4. re-use aqr115c_get_features inside aqr111_get_features
   for further optimizations.


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

 drivers/net/phy/aquantia/aquantia_main.c | 37 ++++++++++++------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index 86bb3b5bfc70..819d87b280ac 100644
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
 
@@ -734,6 +728,18 @@ static int aqr115c_get_features(struct phy_device *phydev)
 	return 0;
 }
 
+static int aqr111_get_features(struct phy_device *phydev)
+{
+	/* PHY supports speeds up to 5G with autoneg. PMA capabilities
+	 * are not useful.
+	 */
+	aqr115c_get_features(phydev);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
+			 phydev->supported);
+
+	return 0;
+}
+
 static int aqr113c_config_init(struct phy_device *phydev)
 {
 	int ret;
@@ -770,15 +776,6 @@ static int aqr107_probe(struct phy_device *phydev)
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
 
 static struct phy_driver aqr_driver[] = {
 {
@@ -856,6 +853,7 @@ static struct phy_driver aqr_driver[] = {
 	.get_sset_count	= aqr107_get_sset_count,
 	.get_strings	= aqr107_get_strings,
 	.get_stats	= aqr107_get_stats,
+	.get_features   = aqr115c_get_features,
 	.link_change_notify = aqr107_link_change_notify,
 	.led_brightness_set = aqr_phy_led_brightness_set,
 	.led_hw_is_supported = aqr_phy_led_hw_is_supported,
@@ -868,7 +866,7 @@ static struct phy_driver aqr_driver[] = {
 	.name		= "Aquantia AQR111",
 	.probe		= aqr107_probe,
 	.get_rate_matching = aqr107_get_rate_matching,
-	.config_init	= aqr111_config_init,
+	.config_init	= aqr107_config_init,
 	.config_aneg    = aqr_config_aneg,
 	.config_intr	= aqr_config_intr,
 	.handle_interrupt = aqr_handle_interrupt,
@@ -880,6 +878,7 @@ static struct phy_driver aqr_driver[] = {
 	.get_sset_count	= aqr107_get_sset_count,
 	.get_strings	= aqr107_get_strings,
 	.get_stats	= aqr107_get_stats,
+	.get_features   = aqr111_get_features,
 	.link_change_notify = aqr107_link_change_notify,
 	.led_brightness_set = aqr_phy_led_brightness_set,
 	.led_hw_is_supported = aqr_phy_led_hw_is_supported,
@@ -892,7 +891,7 @@ static struct phy_driver aqr_driver[] = {
 	.name		= "Aquantia AQR111B0",
 	.probe		= aqr107_probe,
 	.get_rate_matching = aqr107_get_rate_matching,
-	.config_init	= aqr111_config_init,
+	.config_init	= aqr107_config_init,
 	.config_aneg    = aqr_config_aneg,
 	.config_intr	= aqr_config_intr,
 	.handle_interrupt = aqr_handle_interrupt,
@@ -904,6 +903,7 @@ static struct phy_driver aqr_driver[] = {
 	.get_sset_count	= aqr107_get_sset_count,
 	.get_strings	= aqr107_get_strings,
 	.get_stats	= aqr107_get_stats,
+	.get_features   = aqr111_get_features,
 	.link_change_notify = aqr107_link_change_notify,
 	.led_brightness_set = aqr_phy_led_brightness_set,
 	.led_hw_is_supported = aqr_phy_led_hw_is_supported,
@@ -1013,7 +1013,7 @@ static struct phy_driver aqr_driver[] = {
 	.name           = "Aquantia AQR114C",
 	.probe          = aqr107_probe,
 	.get_rate_matching = aqr107_get_rate_matching,
-	.config_init    = aqr111_config_init,
+	.config_init    = aqr107_config_init,
 	.config_aneg    = aqr_config_aneg,
 	.config_intr    = aqr_config_intr,
 	.handle_interrupt = aqr_handle_interrupt,
@@ -1025,6 +1025,7 @@ static struct phy_driver aqr_driver[] = {
 	.get_sset_count = aqr107_get_sset_count,
 	.get_strings    = aqr107_get_strings,
 	.get_stats      = aqr107_get_stats,
+	.get_features   = aqr111_get_features,
 	.link_change_notify = aqr107_link_change_notify,
 	.led_brightness_set = aqr_phy_led_brightness_set,
 	.led_hw_is_supported = aqr_phy_led_hw_is_supported,
-- 
2.25.1


