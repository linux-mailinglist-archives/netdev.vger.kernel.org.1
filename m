Return-Path: <netdev+bounces-130037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B05C9987C57
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 03:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F140283AFF
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 01:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EBC22087;
	Fri, 27 Sep 2024 01:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ISyiZndl"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A12A1799D;
	Fri, 27 Sep 2024 01:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727399179; cv=none; b=SQzcHE1+0mNUgV3Kl+Hb5SnAJU7cKA9RtsT0LngS8NnYxwnVBGgxxprV/KO6s5jfsd4U0y9lM5LNimD3jNVRweKrz3H3PGB0WPjhkth5ZCFv6DP2nPeOFxla1RO/PtYBiOLZsMJqHRt48jC8yM4kMe8p/S64N7OurmRgJtbxGwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727399179; c=relaxed/simple;
	bh=EtVOC8MKfmxkQp/I+qVY3ddMVITq3VHzGrb5KOweycM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s5JTdcxHz+LgorKCl7ldCtD566gzMVGNAy2WqayFPUxyR5FqTneCOWuw9rsAITH6kP0AYud+hIB4IZDhD/MHmjYmWfDSHCJ7+5DKfBuFPJtGdA5f/tBiOn5iwUG1Hkh3WzuEgLderLzqRlKPNdgLDtHnrRxsasV9v9cRISOKeSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ISyiZndl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48QG9eAY026449;
	Fri, 27 Sep 2024 01:05:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=EDpWecO+56D
	z59WNY6EzRWs5CpbapSD0der1VgYb9NE=; b=ISyiZndlTn6ryyGcMtbrEJPK6xm
	kAkIOfnNhg7eForNGMJ7H/dbAU5S3g/GGJpTMwv6sAzsnRbeI6clznQ3oXi1NAM+
	D6PxsSq90e1bts50vuZtLNWquM9vcFjtWQLd0vtGVFvU4qF4WixgxUSSQhb1Ss4m
	TGXGcv4TJqfaq7mRStN4Ohtn4PsOFSBgcNVLfR6LTKyHAFEqhM2MH8Bu4aTpIqkt
	EW0pF344rmZNuMgtlTkSNu9hQfqMMua6T7NnGh4S8sjN6Mdhbw9e8WUQfjcKuIPp
	H4WJnEyr9hzx0BlzHvKvEFxcLeWM2yLKT4OUWBIShgjjQb/UzKYS33+GPfw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41snfh9e6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 01:05:55 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA04.qualcomm.com [127.0.0.1])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 48R0rgBd016123;
	Fri, 27 Sep 2024 01:05:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 41wahhbper-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 01:05:53 +0000
Received: from NALASPPMTA04.qualcomm.com (NALASPPMTA04.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48R15rmv000941;
	Fri, 27 Sep 2024 01:05:53 GMT
Received: from hu-devc-lv-u20-a-new.qualcomm.com (hu-abchauha-lv.qualcomm.com [10.81.25.35])
	by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 48R15rXo000939
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 01:05:53 +0000
Received: by hu-devc-lv-u20-a-new.qualcomm.com (Postfix, from userid 214165)
	id 3F24D215AA; Thu, 26 Sep 2024 18:05:53 -0700 (PDT)
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
Subject: [PATCH net v4 1/2] net: phy: aquantia: AQR115c fix up PMA capabilities
Date: Thu, 26 Sep 2024 18:05:52 -0700
Message-Id: <20240927010553.3557571-2-quic_abchauha@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 4DiCoWiqMZ4qfb2k7pyn0b0zbNjk633B
X-Proofpoint-GUID: 4DiCoWiqMZ4qfb2k7pyn0b0zbNjk633B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409270005

AQR115c reports incorrect PMA capabilities which includes
10G/5G and also incorrectly disables capabilities like autoneg
and 10Mbps support.

AQR115c as per the Marvell databook supports speeds up to 2.5Gbps
with autonegotiation.

Fixes: 0ebc581f8a4b ("net: phy: aquantia: add support for aqr115c")
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

 drivers/net/phy/aquantia/aquantia_main.c | 26 ++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index e982e9ce44a5..af6784b118d2 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -767,6 +767,31 @@ static int aqr111_config_init(struct phy_device *phydev)
 	return aqr107_config_init(phydev);
 }
 
+static int aqr115c_get_features(struct phy_device *phydev)
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
+	/* Although the PHY sets bit 12.18.19.48, it does not support 5G/10G modes */
+	linkmode_clear_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT, supported);
+	linkmode_clear_bit(ETHTOOL_LINK_MODE_10000baseKX4_Full_BIT, supported);
+	linkmode_clear_bit(ETHTOOL_LINK_MODE_10000baseKR_Full_BIT, supported);
+	linkmode_clear_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT, supported);
+
+	/* Phy supports Speeds up to 2.5G with Autoneg though the phy PMA says otherwise */
+	linkmode_or(supported, supported, phy_gbit_features);
+	/* Set the 2.5G speed if it wasn't set as part of the PMA feature discovery */
+	linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, supported);
+
+	return 0;
+}
+
 static struct phy_driver aqr_driver[] = {
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQ1202),
@@ -1036,6 +1061,7 @@ static struct phy_driver aqr_driver[] = {
 	.get_sset_count = aqr107_get_sset_count,
 	.get_strings    = aqr107_get_strings,
 	.get_stats      = aqr107_get_stats,
+	.get_features   = aqr115c_get_features,
 	.link_change_notify = aqr107_link_change_notify,
 	.led_brightness_set = aqr_phy_led_brightness_set,
 	.led_hw_is_supported = aqr_phy_led_hw_is_supported,
-- 
2.25.1


