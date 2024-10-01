Return-Path: <netdev+bounces-131084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF7598C85B
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 00:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65C4F1F24E3D
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 22:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EED01CF2B0;
	Tue,  1 Oct 2024 22:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JgKN3X2v"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597191BD034;
	Tue,  1 Oct 2024 22:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727822816; cv=none; b=iU+lEu/NXySwBpSz8nEUjFFVcN7tOd5LIOvJfVN5W/QPp/JcnMhajnmStHtI6LJcfReyegKy4YcInkGKe7t83q5SEj4+O+NpaJVNIjrJ6LcLY8Vjrg2c17kvc9QUlGQ4I3VTKX1VPBolODgrZq+0AcYWiCcwVju1jR2K5qoEPRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727822816; c=relaxed/simple;
	bh=vC25o7FZ3cVozBxnNlfGgJprAUhdF9E2YOrpqj90Gv8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q9juAqmAB4FKvMu/o3BHOp2/m1xmOMyReJh9Y7NEMycMLE5NbWrmR1e5qgplhwcSKnq3pJqN7S2g0QFTHlPuGFljI13oCLC95Lp0lhIFToen0KEXB9lUTcOwB2c5jRqbERORqf2y6t3DiuS/3IxfZjbkHM1X3vfuenKgY3xzToc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JgKN3X2v; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 491KB5fh008272;
	Tue, 1 Oct 2024 22:46:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=vXheO8IgHrd
	6EHZK+8AZ6qtmsHn+hGVWCy0YUryQsH8=; b=JgKN3X2vP2uvZ8TGlNjjmjwX9HM
	VhzlRKrBHAqzKGY4Sxmt36ZzYfgsTrbggwYnE4fKXsjlTZmnTy4z0n6agm/y0U8V
	2HDTFt0FEOfRnqdMeh5122PO8gPW6Xhx9pRwLi9EebWEMTxY9Yv+EALXY3liix7c
	g6DsVjQal3lpk+Fag0ynPMxvIY7/eiE7aLGh+aGG+yP519QAnloaBWfn+7TSfWIr
	VpCLNa6oD9ncg3S8o9SeUCGGcSOpEwtxI2mAdxlcGOhnFFSPPFN2XzunbSwgMU5M
	qHo7fqCSx6NBE34jYuun1CCNOwXHxBBioc67qnCYEk6hr3QzC7qbptU+aqg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41x9vu9wh6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 22:46:29 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA05.qualcomm.com [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 491MkQBV023882;
	Tue, 1 Oct 2024 22:46:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 4203u7thk9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 22:46:26 +0000
Received: from NALASPPMTA05.qualcomm.com (NALASPPMTA05.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 491MkQiq023875;
	Tue, 1 Oct 2024 22:46:26 GMT
Received: from hu-devc-lv-u20-a-new.qualcomm.com (hu-abchauha-lv.qualcomm.com [10.81.25.35])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 491MkQaB023873
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 22:46:26 +0000
Received: by hu-devc-lv-u20-a-new.qualcomm.com (Postfix, from userid 214165)
	id 207B0215AF; Tue,  1 Oct 2024 15:46:26 -0700 (PDT)
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
Subject: [PATCH net v6 1/2] net: phy: aquantia: AQR115c fix up PMA capabilities
Date: Tue,  1 Oct 2024 15:46:25 -0700
Message-Id: <20241001224626.2400222-2-quic_abchauha@quicinc.com>
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
X-Proofpoint-GUID: JTZiiSNVb_kcKyDZXEneln2Um56vs1KS
X-Proofpoint-ORIG-GUID: JTZiiSNVb_kcKyDZXEneln2Um56vs1KS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 clxscore=1015 spamscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 mlxscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2410010151

AQR115c reports incorrect PMA capabilities which includes
10G/5G and also incorrectly disables capabilities like autoneg
and 10Mbps support.

AQR115c as per the Marvell databook supports speeds up to 2.5Gbps
with autonegotiation.

Fixes: 0ebc581f8a4b ("net: phy: aquantia: add support for aqr115c")
Link: https://lore.kernel.org/all/20240913011635.1286027-1-quic_abchauha@quicinc.com/T/
Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
---
Changes since v5
1. Minor comments addressed such as having 
   unsigned long *supported = phydev->supported;
2. Updated comments as per Russell suggestion. 

Changes since v4
1. Forget about asking hardware for PMA capabilites.
2. Just set the Gbits features along with 2.5Gbps support 
   for AQR115c Phy chip. 

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
 drivers/net/phy/aquantia/aquantia_main.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index e982e9ce44a5..86bb3b5bfc70 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -721,6 +721,19 @@ static int aqr113c_fill_interface_modes(struct phy_device *phydev)
 	return aqr107_fill_interface_modes(phydev);
 }
 
+static int aqr115c_get_features(struct phy_device *phydev)
+{
+	unsigned long *supported = phydev->supported;
+
+	/* PHY supports speeds up to 2.5G with autoneg. PMA capabilities
+	 * are not useful.
+	 */
+	linkmode_or(supported, supported, phy_gbit_features);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, supported);
+
+	return 0;
+}
+
 static int aqr113c_config_init(struct phy_device *phydev)
 {
 	int ret;
@@ -1036,6 +1049,7 @@ static struct phy_driver aqr_driver[] = {
 	.get_sset_count = aqr107_get_sset_count,
 	.get_strings    = aqr107_get_strings,
 	.get_stats      = aqr107_get_stats,
+	.get_features   = aqr115c_get_features,
 	.link_change_notify = aqr107_link_change_notify,
 	.led_brightness_set = aqr_phy_led_brightness_set,
 	.led_hw_is_supported = aqr_phy_led_hw_is_supported,
-- 
2.25.1


