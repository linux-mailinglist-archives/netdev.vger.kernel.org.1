Return-Path: <netdev+bounces-130636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 856A598AFE4
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 00:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AEE72835F3
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 22:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5C118C904;
	Mon, 30 Sep 2024 22:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oZrpybRp"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A651188925;
	Mon, 30 Sep 2024 22:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727735650; cv=none; b=YFaD78O93KTEQ/MT0mmEgZqUXe62krBP6bL5Cy9w4yXcha6gwJVURXRJMYmi0MOw/54MZc5fkBDXzaXhfao+MMuFqXUO4HMzN+c3MV9TFm5VFDrLb93cAAYM2ew+YFwT5PeYG9KtxWseYkpYbQByUO6DVujqH7MNxj+d726fO9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727735650; c=relaxed/simple;
	bh=TTznifno1lwZ77J0pNV6ZAWKw9kojR0DD7ycuSeEJxY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uJj9Pxd9sXnpEfi37Ee/3cOED9zHiI/0rzIHANG4aYlD1/QY57eVNsYk70TGR6zzWrJbPDg34kveJ2767FuZK4TqXNYqC8/xTDbnCR4TC+xpu7Ntb63OjRnCLZrzrWBNhQeeIGcogdXCegEBLpi2DwybMhfc3nt5FMU4m/8iNc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oZrpybRp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UC8cGN024372;
	Mon, 30 Sep 2024 22:33:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=zluV84NRDmXstZkidHmSSvRaCzmT96qsEpL
	I8RZKSg8=; b=oZrpybRp6KtJCXcLPrYbSebvrqOkuLUtmYiD1oOJjJ/PbpCNBfJ
	027xZajw9amZ/LKHndSY9l0hOEf+/TbCtydGkZ24qKyQzf4bONNByvPpoIqT/txQ
	R1F1pAIWVkhx2WwAhx/TCNnk0iULgqxnDctrcj3fhbCtlVtRHRK5I8w7kKUYOjuq
	H6qsoe9Uk3btO9nHZVNjvbU+zgdwwtwmeJ7M66/cas5qBpXk+/3L+mkcmVrCazsT
	SQnywEHlGMg4yktG4aQrWh1QNSM24SRL5dZC6Pcn6BU7Y+xSpsZisBrlffwRdfiU
	rl11Tc7EpJgMs4J+Fya5TpSlJZCh9mA/gjQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41xa12p718-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 22:33:43 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA03.qualcomm.com [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 48UMUANU013770;
	Mon, 30 Sep 2024 22:33:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 41yxq0ts4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 22:33:42 +0000
Received: from NALASPPMTA03.qualcomm.com (NALASPPMTA03.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48UMUxnL014530;
	Mon, 30 Sep 2024 22:33:41 GMT
Received: from hu-devc-lv-u20-a-new.qualcomm.com (hu-abchauha-lv.qualcomm.com [10.81.25.35])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 48UMXf9x018152
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 22:33:41 +0000
Received: by hu-devc-lv-u20-a-new.qualcomm.com (Postfix, from userid 214165)
	id 6493A21B67; Mon, 30 Sep 2024 15:33:41 -0700 (PDT)
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
Subject: [PATCH net v5 0/2] Fix AQR PMA capabilities
Date: Mon, 30 Sep 2024 15:33:39 -0700
Message-Id: <20240930223341.3807222-1-quic_abchauha@quicinc.com>
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
X-Proofpoint-ORIG-GUID: PUCZW7inTO6RvyteOb8CUtzYXrKWMtd7
X-Proofpoint-GUID: PUCZW7inTO6RvyteOb8CUtzYXrKWMtd7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=954
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 spamscore=0 clxscore=1015 mlxscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409300160

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

 drivers/net/phy/aquantia/aquantia_main.c | 46 ++++++++++++++----------
 1 file changed, 28 insertions(+), 18 deletions(-)

-- 
2.25.1


