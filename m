Return-Path: <netdev+bounces-129869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A159F986952
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 01:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FFCD28146E
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 23:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE0C186E5F;
	Wed, 25 Sep 2024 23:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="L8DzBNUP"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A36186E36;
	Wed, 25 Sep 2024 23:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727305316; cv=none; b=ejXtRnYudi7b6sK7ED2jP1QFb/CBazCK8Fa9wgYN1GcbGKk9hPfsYuc+AQy5meTqxNW7HJAThZU7BFgF8PRVL136gsAd7BL5VOwWa9UxnHIN41RD4rg++3Y4VVwou8UzaYsg1uyhj8CRCNL7D3oh6w4TwEP9hVrLKY3sVWMladM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727305316; c=relaxed/simple;
	bh=4RRry88l42YWMnIm3Kf7otPxCu4Y3NeGaIx1YdU7vqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OZ5LyxWFa+DuVWkwOJGswKv9/Pebz98td8+aw8kZAobxF0XQ5HvHncCaoD5Afl+l5jw4X8W+M911OvQeQ4FEU/COXGkmb6KhwOEtBsKWhoVUB7ghpU8Wcfq8plp3a7KYcJceQi1KN5Bux34BeD1YTtBQX6DU7W/284N1hg4WLO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=L8DzBNUP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48PH5Dfn007919;
	Wed, 25 Sep 2024 23:01:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=1uSVyniIwqHCHdlFrBLS7ZeBT58eCVGU7d3
	n0U0EmDs=; b=L8DzBNUPTgzVZ1vw1CipRMYsp/odeV5u2bxondpJoscVzaDH0Sy
	63+u3a/Kary7D14atun3+xV0KY0E8FvBQiALQiB4S8ULtAvBPqMoWq9csleBKhUF
	fkkCc9rKFhFBxfRrNl7lGp2Zum2rsPJWoue53MBB6c314Ik8HTDHxk6rdDQUNzLS
	9PJrU+dVUwzoV/Of3RmAlrxV47+el4Ey0Dg0W86HjrhMrJKwu7PX4crRNXx0B1tv
	ldsUYPE76LbUKJYaK4jlTUrZVIE76Pz2jL3ySt9ZRTO5T89xJ3bPp91HOkLzqucZ
	aml89HdLKihbccN0FBYgTGdn8+xS33hvSpw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41sn3sdh3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Sep 2024 23:01:31 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA05.qualcomm.com [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 48PN1UX8012467;
	Wed, 25 Sep 2024 23:01:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 41vfmmx1jy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Sep 2024 23:01:30 +0000
Received: from NALASPPMTA05.qualcomm.com (NALASPPMTA05.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48PN09ql010238;
	Wed, 25 Sep 2024 23:01:30 GMT
Received: from hu-devc-lv-u20-a-new.qualcomm.com (hu-abchauha-lv.qualcomm.com [10.81.25.35])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 48PN1Ukm012446
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Sep 2024 23:01:30 +0000
Received: by hu-devc-lv-u20-a-new.qualcomm.com (Postfix, from userid 214165)
	id DBB8021B91; Wed, 25 Sep 2024 16:01:29 -0700 (PDT)
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
Subject: [PATCH net v3 0/2] Fix AQR PMA capabilities
Date: Wed, 25 Sep 2024 16:01:27 -0700
Message-Id: <20240925230129.2064336-1-quic_abchauha@quicinc.com>
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
X-Proofpoint-GUID: MiWFWSx67aM2dgFDDg9a6wb8Z8YSA_Pv
X-Proofpoint-ORIG-GUID: MiWFWSx67aM2dgFDDg9a6wb8Z8YSA_Pv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 mlxscore=0 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=963 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409250163

Patch 1:- 
AQR115c reports incorrect PMA capabilities which includes
10G/5G and also incorrectly disables capabilities like autoneg
and 10Mbps support.

AQR115c as per the Marvell databook supports speeds up to 2.5Gbps
with autonegotiation.

AQR115c also support 2500BaseX 

Patch 2:- 
Remove the use of phy_set_max_speed in phy driver as the
function is mainly used in MAC driver to set the max
speed.

Instead use get_features to fix up Phy PMA capabilities for
AQR111, AQR111B0, AQR114C and AQCS109


Abhishek Chauhan (2):
  net: phy: aquantia: AQR115c fix up PMA capabilities
  net: phy: aquantia: remove usage of phy_set_max_speed

 drivers/net/phy/aquantia/aquantia_main.c | 73 +++++++++++++++++++-----
 1 file changed, 58 insertions(+), 15 deletions(-)

-- 
2.25.1


