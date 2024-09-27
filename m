Return-Path: <netdev+bounces-130038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8ED1987C5A
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 03:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C4BF1C225E1
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 01:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AAB433D9;
	Fri, 27 Sep 2024 01:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Wccu0gF2"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06D71E504;
	Fri, 27 Sep 2024 01:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727399179; cv=none; b=M7f+5VGiOA2mmICWWIh/keSoroivIPFu0/0ocWlkeaeRK+0RrMzA18Igi30y8RRKyoV8xOdSDzc/MYhQt0LxeCFN4uE1RM5y2ZR5ytmG9D309EuOxK44Ipvyntn40iljzbdaEXTCzyuE6o0tgGeIOF8UpI2DNupNUk2rd2J5/6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727399179; c=relaxed/simple;
	bh=U3eDbCASrdllCVO2BAn3RDD9aDBZS4CjaSu09XfZQR0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WyLIC6pAziPJExiZPIOux3AeCbdqJmXquLOfJ9tya4nbwtNt53CI36+Zz1XmwXJi+Z64KVUBCC2UC0iwGqFDzuvZ37aM7Txa45U+XO5EBrFJqoFSdxuoh3/wVp4+Xoe/qRK9Kf0ChLBd4gTmgiA5SazpgOA++DOK766SsniHwTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Wccu0gF2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48QG9e2o001917;
	Fri, 27 Sep 2024 01:05:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=UDiZRIcvHWrLl7ONmI4a7TpUodwsB/Y6j4A
	Z2hwgNd4=; b=Wccu0gF2l7OxFFjroEUG4ujRLTb1LCo8hWoycWGxrXE2Pok8YrM
	euIyK7C0sQ31hGPpaSmEE5oXMRuo69u5fbnT16xF3xF5W2szhIU7fyzN/5RPRQK9
	1Nu1vQh8chzm48L3NGSgu0Nan+kJkLSRNf8Mc9ixlFaGHANAPn4LmZwXPN+tB5Om
	pma5o3W18Xhx8M/DCon9b/pUdPi6OF81pREYhhc9Amq1CYCTOKkFTJQtEVshhO81
	yDVLq4LCcfsrOtwl9HKhno1mV7c4Qhie6RghLCzt68h+S3xP01UBfWyHnvqdmqF2
	a1Y+R4Ab+nhDZ/OtRU06fDYL6xNcuu0jZ8w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41skgnhqj8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 01:05:55 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA05.qualcomm.com [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 48R15sWA003023;
	Fri, 27 Sep 2024 01:05:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 41w9tem3dq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 01:05:54 +0000
Received: from NALASPPMTA05.qualcomm.com (NALASPPMTA05.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48R15UQs002867;
	Fri, 27 Sep 2024 01:05:53 GMT
Received: from hu-devc-lv-u20-a-new.qualcomm.com (hu-abchauha-lv.qualcomm.com [10.81.25.35])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 48R15rKT003016
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 01:05:53 +0000
Received: by hu-devc-lv-u20-a-new.qualcomm.com (Postfix, from userid 214165)
	id 3C933215CB; Thu, 26 Sep 2024 18:05:53 -0700 (PDT)
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
Subject: [PATCH net v4 0/2] Fix AQR PMA capabilities
Date: Thu, 26 Sep 2024 18:05:51 -0700
Message-Id: <20240927010553.3557571-1-quic_abchauha@quicinc.com>
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
X-Proofpoint-ORIG-GUID: pRCi1S7tbWQz6VKQukoywFLx9NmcNvLT
X-Proofpoint-GUID: pRCi1S7tbWQz6VKQukoywFLx9NmcNvLT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxlogscore=961 adultscore=0 suspectscore=0 phishscore=0 impostorscore=0
 spamscore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409270006

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

 drivers/net/phy/aquantia/aquantia_main.c | 69 ++++++++++++++++++------
 1 file changed, 54 insertions(+), 15 deletions(-)

-- 
2.25.1


