Return-Path: <netdev+bounces-130634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C03798AFDC
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 00:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60AB11C213A0
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 22:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D8718785C;
	Mon, 30 Sep 2024 22:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="htUz+S6v"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E066183CCA;
	Mon, 30 Sep 2024 22:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727735648; cv=none; b=jID+E5OAlebHOchMqO0cCPYWG6lzIxYoiZK3rdMTF7WEWXZkd43wqa69D75nmpvaDChviN0/0r5i5zUKQJ7Rn1vxcmZdVwzV0gB3BzkYd0mUEPBQTR9sXn31vnSK78xr3hndrz9iNdOh5G4EQ94eY8OFYyZ4qb9IFS0wOD0MAk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727735648; c=relaxed/simple;
	bh=fRWOxzFnpSMvvznVleXI+dDR2fMvMQ38bMvwoWFHYI0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KitQsUrznA4qlZOIXpbulalY7pDEPi8bozrJe31zqvn9wbNbrcOSqY5XBrzUbaMLsG3YbYLcMkaXDlevMYKK9VPd3nr6/m2t47TKO0YfeLv9I7mfFS8yox6hBe6swGja9RTaH07IK8woAuhn/Zcw95Y2ZqZDr099ZiiSrgYXS2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=htUz+S6v; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UB5fm1008325;
	Mon, 30 Sep 2024 22:33:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=1+cXXbYtmvD
	bpjqXZ2muzAL34ROLkqQDicE5Z636f/k=; b=htUz+S6vDNIg2UPDeyD3M7aqkNr
	kANmYBHEFdxAfNyTwiCy6i/i6KPR0nMpZCeCACNAou9OUNFh3n0GmccA8jm0DB0R
	sw1LYmZUsBB1QbimYrkJoEBiyBWRnhZsAXlmK5RKjqDg4BnOBRvlm1gDh0vS01ra
	5YFDmZjBmjuXVy5Oeez/Iyr6slZHjnyymGPl8aIvEluAp9KsXvBQgE/9dHfDsdLC
	pTRNaLU+sLAQrssk612Lc6n92jDjVr5hgRWTwTdSYkrtm23VgK4Zti5Nmw5SJHw4
	w9TtRP1psDRVpe+aMC8cU7DxznxDt42h3q22c4peAKr7jik2oyCJ7q+VHFQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41x9vu65vf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 22:33:43 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA05.qualcomm.com [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 48UMXgOq014429;
	Mon, 30 Sep 2024 22:33:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 4203u7gdnc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 22:33:42 +0000
Received: from NALASPPMTA05.qualcomm.com (NALASPPMTA05.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48UMXfOB014422;
	Mon, 30 Sep 2024 22:33:41 GMT
Received: from hu-devc-lv-u20-a-new.qualcomm.com (hu-abchauha-lv.qualcomm.com [10.81.25.35])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 48UMXf7g014420
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 22:33:41 +0000
Received: by hu-devc-lv-u20-a-new.qualcomm.com (Postfix, from userid 214165)
	id 7DB4422EF0; Mon, 30 Sep 2024 15:33:41 -0700 (PDT)
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
Subject: [PATCH net v5 1/2] net: phy: aquantia: AQR115c fix up PMA capabilities
Date: Mon, 30 Sep 2024 15:33:40 -0700
Message-Id: <20240930223341.3807222-2-quic_abchauha@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240930223341.3807222-1-quic_abchauha@quicinc.com>
References: <20240930223341.3807222-1-quic_abchauha@quicinc.com>
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
X-Proofpoint-GUID: bPPVjdDXqlmh3n3zum12q0_MED6fmILF
X-Proofpoint-ORIG-GUID: bPPVjdDXqlmh3n3zum12q0_MED6fmILF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 clxscore=1015 spamscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 mlxscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409300160

AQR115c reports incorrect PMA capabilities which includes
10G/5G and also incorrectly disables capabilities like autoneg
and 10Mbps support.

AQR115c as per the Marvell databook supports speeds up to 2.5Gbps
with autonegotiation.

Fixes: 0ebc581f8a4b ("net: phy: aquantia: add support for aqr115c")
Link: https://lore.kernel.org/all/20240913011635.1286027-1-quic_abchauha@quicinc.com/T/
Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
---
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

 drivers/net/phy/aquantia/aquantia_main.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index e982e9ce44a5..bd543cdc8c1d 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -721,6 +721,16 @@ static int aqr113c_fill_interface_modes(struct phy_device *phydev)
 	return aqr107_fill_interface_modes(phydev);
 }
 
+static int aqr115c_get_features(struct phy_device *phydev)
+{
+	/* PHY FIXUP */
+	/* Phy supports Speeds up to 2.5G with Autoneg though the phy PMA says otherwise */
+	linkmode_or(phydev->supported, phydev->supported, phy_gbit_features);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, phydev->supported);
+
+	return 0;
+}
+
 static int aqr113c_config_init(struct phy_device *phydev)
 {
 	int ret;
@@ -1036,6 +1046,7 @@ static struct phy_driver aqr_driver[] = {
 	.get_sset_count = aqr107_get_sset_count,
 	.get_strings    = aqr107_get_strings,
 	.get_stats      = aqr107_get_stats,
+	.get_features   = aqr115c_get_features,
 	.link_change_notify = aqr107_link_change_notify,
 	.led_brightness_set = aqr_phy_led_brightness_set,
 	.led_hw_is_supported = aqr_phy_led_hw_is_supported,
-- 
2.25.1


