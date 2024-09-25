Return-Path: <netdev+bounces-129871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC34986956
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 01:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4672A28272C
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 23:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D3918754D;
	Wed, 25 Sep 2024 23:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UiEK1rVE"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB2D186E3B;
	Wed, 25 Sep 2024 23:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727305318; cv=none; b=Kk0FIsMX8ZW82zRFTkCmwq5jH5RLZa1/nsqTb6Bw5/K/rly83oNDSetDvajYAgnAbIKh/Jr2CC+aHsrpOaoJLR8BTF9cEaVu1JAUBtPnSx3wSBsYWI+l+ERVIDB2gsQVONWzIEbctMlJGwZ7Kpmfn4YZpg+vErmNasKBUu0CVDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727305318; c=relaxed/simple;
	bh=SRmbnH7kyy1Vv2IWh2/dThJlwYgu+7QCIezWnZO+CrU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g7n3swKcnaZSXULl5VeLaa2DLi3qqmxqmNzpxEimL4B9waHFu72+G9S9so4npyis2DoPSm/CW1JPUAYQg28fgjJrdNWem4ECZ6bPralpS9kt1c16ry1CvOFPpOAqLBrs19rctBBF3rvEl21evW8CTmbPuMCySZ+PO09JPNMyhK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UiEK1rVE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48PH5CsU027642;
	Wed, 25 Sep 2024 23:01:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=hXXcRLhiMHz
	DDeW23RdhyY7h0fqUfW12YpRBhSunht8=; b=UiEK1rVEJQ9Z4Tfx5LSCx30FlNN
	DFuttdb5QC5mf491lxT9/naJA86DnvMGCRHi42r3ui7OkvzCJbJXrCIJ3SqJdbKu
	NpXvw2ZJR2N4gJlJeFn/8lfe6l7Rmw3EOUVnYsIcpbfwzOgWtP9KK2VCZhIsywGM
	X+s5PFGrTib0+5Jyk4qKFmseLPOP/CzzF5+KIdLG9L5Zi3UTdc9Y85vmNyAw7i0J
	AKTbvXwpyh+RP/sy8IesuwoStmBCkuJAoRUfaX+T3mg1H1yO9dWPfK/sqn7gm8n9
	vd10HetskQDBsSHyaP7ioduTiXJtczmzP2pIgpXxjaoUPIYIigH1+5dHTKA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41spc2wgdb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Sep 2024 23:01:31 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA05.qualcomm.com [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 48PN1USD012468;
	Wed, 25 Sep 2024 23:01:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 41vfmmx1k0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Sep 2024 23:01:30 +0000
Received: from NALASPPMTA05.qualcomm.com (NALASPPMTA05.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48PN1U10012450;
	Wed, 25 Sep 2024 23:01:30 GMT
Received: from hu-devc-lv-u20-a-new.qualcomm.com (hu-abchauha-lv.qualcomm.com [10.81.25.35])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 48PN1UM1012445
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Sep 2024 23:01:30 +0000
Received: by hu-devc-lv-u20-a-new.qualcomm.com (Postfix, from userid 214165)
	id DEA38214A8; Wed, 25 Sep 2024 16:01:29 -0700 (PDT)
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
Subject: [PATCH net v3 1/2] net: phy: aquantia: AQR115c fix up PMA capabilities
Date: Wed, 25 Sep 2024 16:01:28 -0700
Message-Id: <20240925230129.2064336-2-quic_abchauha@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240925230129.2064336-1-quic_abchauha@quicinc.com>
References: <20240925230129.2064336-1-quic_abchauha@quicinc.com>
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
X-Proofpoint-GUID: eBX4Qa-7f70CE6Z19PRfa53SrFMvUoCW
X-Proofpoint-ORIG-GUID: eBX4Qa-7f70CE6Z19PRfa53SrFMvUoCW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409250163

AQR115c reports incorrect PMA capabilities which includes
10G/5G and also incorrectly disables capabilities like autoneg
and 10Mbps support.

AQR115c as per the Marvell databook supports speeds up to 2.5Gbps
with autonegotiation.

Fixes: 0ebc581f8a4b ("net: phy: aquantia: add support for aqr115c")
Link: https://lore.kernel.org/all/20240913011635.1286027-1-quic_abchauha@quicinc.com/T/
Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
---
Changes since v2
1. seperate out the changes into two different patches. 
3. use phy_gbit_features instead of initializing each and 
every link mode bits. 
4. write seperate functions for 2.5Gbps supported phy 
5. remove FIBRE bit which was introduced in patch 1

Changes since v1 
1. remove usage of phy_set_max_speed in the aquantia driver code.
2. Introduce aqr_custom_get_feature which checks for the phy id and
   takes necessary actions based on max_speed supported by the phy
3. remove aqr111_config_init as it is just a wrapper function. 

 drivers/net/phy/aquantia/aquantia_main.c | 28 ++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index e982e9ce44a5..88ba12aaf6e0 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -767,6 +767,33 @@ static int aqr111_config_init(struct phy_device *phydev)
 	return aqr107_config_init(phydev);
 }
 
+static int aqr115c_get_features(struct phy_device *phydev)
+{
+	int ret;
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported) = { 0, };
+
+	/* Normal feature discovery */
+	ret = genphy_c45_pma_read_abilities(phydev);
+	if (ret)
+		return ret;
+
+	/* PHY FIXUP */
+	/* Although the PHY sets bit 12.18.19.48, it does not support 5G/10G modes */
+	linkmode_clear_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT, phydev->supported);
+	linkmode_clear_bit(ETHTOOL_LINK_MODE_10000baseKX4_Full_BIT, phydev->supported);
+	linkmode_clear_bit(ETHTOOL_LINK_MODE_10000baseKR_Full_BIT, phydev->supported);
+	linkmode_clear_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT, phydev->supported);
+
+	/* Phy supports Speeds up to 2.5G with Autoneg though the phy PMA says otherwise */
+	linkmode_copy(supported, phy_gbit_features);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseX_Full_BIT, supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, supported);
+
+	linkmode_or(phydev->supported, supported, phydev->supported);
+
+	return 0;
+}
+
 static struct phy_driver aqr_driver[] = {
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQ1202),
@@ -1036,6 +1063,7 @@ static struct phy_driver aqr_driver[] = {
 	.get_sset_count = aqr107_get_sset_count,
 	.get_strings    = aqr107_get_strings,
 	.get_stats      = aqr107_get_stats,
+	.get_features   = aqr115c_get_features,
 	.link_change_notify = aqr107_link_change_notify,
 	.led_brightness_set = aqr_phy_led_brightness_set,
 	.led_hw_is_supported = aqr_phy_led_hw_is_supported,
-- 
2.25.1


