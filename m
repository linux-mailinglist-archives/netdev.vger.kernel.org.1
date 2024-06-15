Return-Path: <netdev+bounces-103792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F31909812
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 14:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F415E2837CB
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 12:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA293F9FC;
	Sat, 15 Jun 2024 12:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pZh/myXj"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E895C4779F;
	Sat, 15 Jun 2024 12:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718452882; cv=none; b=IoVIrpz6cRYHadgKULNS8hM+1gjzM0U/l4AtGhT/+yW4jPc43NCdxNvebqPTruKi/91/UX1j9clDXiRKAM1PEqcFTUgdQjwwaq5otQUcRAOEVIh3nhn1t6CbhEISLXf2Cua4bAuBDUPcczGjXOfUO6ZfygcOmX7NlurAuMpwmrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718452882; c=relaxed/simple;
	bh=OT/HKUKOCIKwj/yAboIO2XCrsuGuzqCYpdcgZ+8PYjY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Dv98p72v46i3gZh1MHVmWHNVlBSIa21Q6OL7FaR/AvEJVuV+7gN/EwjluC1yVVyRpW2gaJdNqO+o5WhAvLr1GlwCvCTvTvokrvZVaJP2P9oZEhOIRIR1ZRNyGvGbpZyY0y2PEScEaiHkS5UtyfXHDCXVCPpyCuxteKUtid94uto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pZh/myXj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45FBfSBT018819;
	Sat, 15 Jun 2024 12:00:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=WliGhlPHqj+gEVrbetMvgS
	lUq+iGOkxMB/rjvW5/fhs=; b=pZh/myXjiblRjLIASajEkdo/hKnDIFJd8eItx+
	TDCVycsx++9XeE5iQTRn9vi351epD6tNI132Jhkk/z8Vqr39Uuxk9fXGEUEHFcoz
	2Wzd1YM1f/r9/R0duclbE4G9d11ZIMUZ/O0vfbwOFi+GFxB5ToW8U25uLzqDc1vm
	WhhPCKwZzp6qM65PbSt9INYB4bejZ873iDg6jo0hvWbMVx3Xr0wiKTppMSW+J4LW
	OuXqVNZeOCcZyoa62VAX7oOCMgMBirqFvsuvL9K7Q/NXXRbeHCIfh8heyQAZ4zVx
	icQciiIzxBZFE5SAFYMZ8MUz7jLjBoPlPZabionZYxMtePTg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ys31u0hkq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Jun 2024 12:00:45 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45FC0iKl026458
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Jun 2024 12:00:44 GMT
Received: from luoj-gv.qualcomm.com (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 15 Jun
 2024 05:00:40 -0700
From: Luo Jie <quic_luoj@quicinc.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
        <linux@armlinux.org.uk>, <corbet@lwn.net>, <vladimir.oltean@nxp.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH net-next v2 0/2] Introduce PHY mode 10G-QXGMII
Date: Sat, 15 Jun 2024 20:00:26 +0800
Message-ID: <20240615120028.2384732-1-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tUazm06b5owhuoBp9eYVOR8_0qoPyqd8
X-Proofpoint-ORIG-GUID: tUazm06b5owhuoBp9eYVOR8_0qoPyqd8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-15_08,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 adultscore=0 priorityscore=1501
 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=802 bulkscore=0
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2406150091

This patch series adds 10G-QXGMII mode for PHY driver. The patch
series is split from the QCA8084 PHY driver patch series below.
https://lore.kernel.org/all/20231215074005.26976-1-quic_luoj@quicinc.com/
 
Per Andrew Lunn’s advice, submitting this patch series for acceptance
as they already include the necessary 'Reviewed-by:' tags. This way,
they need not wait for QCA8084 series patches to conclude review.

Changes in v2:
	* remove PHY_INTERFACE_MODE_10G_QXGMII from workaround of
	  validation in the phylink_validate_phy. 10G_QXGMII will
	  be set into phy->possible_interfaces in its .config_init
	  method of PHY driver that supports it. 

Vladimir Oltean (2):
  net: phy: introduce core support for phy-mode = "10g-qxgmii"
  dt-bindings: net: ethernet-controller: add 10g-qxgmii mode

 .../devicetree/bindings/net/ethernet-controller.yaml     | 1 +
 Documentation/networking/phy.rst                         | 6 ++++++
 drivers/net/phy/phy-core.c                               | 1 +
 drivers/net/phy/phylink.c                                | 9 ++++++++-
 include/linux/phy.h                                      | 4 ++++
 include/linux/phylink.h                                  | 1 +
 6 files changed, 21 insertions(+), 1 deletion(-)


base-commit: 934c29999b57b835d65442da6f741d5e27f3b584
-- 
2.34.1


