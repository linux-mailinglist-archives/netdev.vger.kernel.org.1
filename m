Return-Path: <netdev+bounces-131083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA6A98C857
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 00:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7FAEB22D67
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 22:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6781CEEA4;
	Tue,  1 Oct 2024 22:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HmxTsrat"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD8D1BFE00;
	Tue,  1 Oct 2024 22:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727822814; cv=none; b=NDmzm+dufAPkUNl+7k+uojZEz7tujAnQMnBzZVnkHFRBNzxvhR2YQ2U4GWEmJRvET1mKIkk514tYQOQr8cKwCCJGKBuFEOcjrLHAIiVmVO2oGvXkw0UY450U/yE9/HQbEOpM/y5lTj7lfK0RlzRFFfBjczfSzf/TDwAndxopCXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727822814; c=relaxed/simple;
	bh=ZDslSkulC1sAOhjyNUpHtCXyeuQyFQa5OSChIsUPVwk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TOHTujQtVwyXDV4oYEr4LyQqZpsT2R37ikZVpzACVFwzY1TKPFvXtnv+Jt9vTnUQAeUW2fY2NDlOhHhTqciVejEiSuio2mcC0m08iWPfmG05LPqb7ZhNGDmTtLw1sqVEVVmofR03VDXruhLxGEj8v65aNhqUvJhExYa/uI4PJ0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HmxTsrat; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 491LbhhW032323;
	Tue, 1 Oct 2024 22:46:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=mg4Z9hX96gITYTKok2FJQoBsdRCEhmnRJQk
	ltEOy2aM=; b=HmxTsratHIKlgf31a0cKT+PQwxBIYOGzGmJa4Ik13facU+y0cei
	GbfCQVHiIAd/0HsQVl+cdnjK0IMoGZ00Jr/OgWen5nNpQP1MLiB9NT4mIJYbQit0
	0pIlUovUShvYdIdhPb8/1f8l0ARQRD8UoTh6X4TnLFLjLXh30FwCJveX6I3zs8gL
	vhoLrTlJPoSDNKGOzGnWhx4HpP0gdN+2rQIXdESdL0rLIW8gTcY3sQblq5fUI9As
	MFxsLlCkpUfGJdSUvJHk3B4vAJD4Wbn6nGQFQWazbmf7AIlNZiSfwqd6sjGSlqe+
	BpCtjPhqJIYQp3a24GhSyt1PXb6QDiyjIXQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41x94hhwe1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 22:46:28 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA03.qualcomm.com [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 491MfwtO014023;
	Tue, 1 Oct 2024 22:46:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 420h1qmc1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 22:46:26 +0000
Received: from NALASPPMTA03.qualcomm.com (NALASPPMTA03.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 491MiW30016955;
	Tue, 1 Oct 2024 22:46:26 GMT
Received: from hu-devc-lv-u20-a-new.qualcomm.com (hu-abchauha-lv.qualcomm.com [10.81.25.35])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 491MkQtC018812
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 22:46:26 +0000
Received: by hu-devc-lv-u20-a-new.qualcomm.com (Postfix, from userid 214165)
	id 1EEB722EC5; Tue,  1 Oct 2024 15:46:26 -0700 (PDT)
From: Abhishek Chauhan <quic_abchauha@quicinc.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
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
Subject: [PATCH net v6 0/2] Fix AQR PMA capabilities
Date: Tue,  1 Oct 2024 15:46:24 -0700
Message-Id: <20241001224626.2400222-1-quic_abchauha@quicinc.com>
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
X-Proofpoint-GUID: Tyn-HQgOKGOXoiasYRd4iclQoIdUCkT3
X-Proofpoint-ORIG-GUID: Tyn-HQgOKGOXoiasYRd4iclQoIdUCkT3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=954 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410010151

Patch 1:- 
AQR115c reports incorrect PMA capabilities which includes
10G/5G and also incorrectly disables capabilities like autoneg
and 10Mbps support.

AQR115c as per the Marvell databook supports speeds up to 2.5Gbps
with autonegotiation.

Patch 2:- 
Remove the use of phy_set_max_speed in phy driver as the
function is mainly used in MAC driver to set the max
speed.

Instead use get_features to fix up Phy PMA capabilities for
AQR111, AQR111B0, AQR114C and AQCS109


Abhishek Chauhan (2):
  net: phy: aquantia: AQR115c fix up PMA capabilities
  net: phy: aquantia: remove usage of phy_set_max_speed

 drivers/net/phy/aquantia/aquantia_main.c | 51 +++++++++++++++---------
 1 file changed, 33 insertions(+), 18 deletions(-)

-- 
2.25.1


