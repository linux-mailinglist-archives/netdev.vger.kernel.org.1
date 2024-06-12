Return-Path: <netdev+bounces-102833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D50E904FAB
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 11:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD6C2282A82
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 09:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2AAA16DEDD;
	Wed, 12 Jun 2024 09:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Nr22xxNX"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C70716DED2;
	Wed, 12 Jun 2024 09:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718186031; cv=none; b=c9Z0oTewCko/yxiGS9N0hw3KFP5TInd/i2PWGipUvbXg9w5Zvyl+iDs0BfH8Qq7/gNJjE+U/cySNxVSfbRh0Rm5XPQSQH6HH0t6KFqJBNrPTMYonzpm7AlLxsiBLx5c1774KWY+LMOTUFoJo6/wu6X8xAmhHAAi05k2NPxgYcls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718186031; c=relaxed/simple;
	bh=yRlmiQo1uibOoBDJDgUIhh3gKKJ8sqPtUMS2oriWl9k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DBkWj5SSwWEfQ3oIEPsEg7p03qEBlgCz+sFk7cz1k9XbuFpEXXZQ3HQY4jYc3d9y9YrtAvwMobFKCvOX6xJ9lNc09D81c++wVyn+gEs/OYoFGtI5PvY8Cdyi/D1I/kMDNHphk9KAn8KKMGcpNk8doUHt4z75niqd4S1i5bz9L+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Nr22xxNX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45C6cKkN001361;
	Wed, 12 Jun 2024 09:53:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=nsxJ81OnUl8js+adMpv2E1
	+5d/b+K4/IU2AKkSrL+E4=; b=Nr22xxNXXQMnvw9cNdIV1qA14ugNe2cbtVB3xi
	N7D8VvwS4mWG2JfFvPo4HXA+ob3b+E4ZVQCAFU0P+ll6utPIQ3mPoBKWBxNQTnGT
	BAogH4TGAL/kU3yAOeyoBae2ZMnwP9wMeLppwif1G+1lGtweJbYFDj7QvHXxbxsS
	9ZD15I4KjzA11VRTIUSRMolpw3wMjA727l6JMm/OEh3jpJ/6MPYtOKh97eAiWePR
	0HSpbZK3VRwXMP/fb1YkO3OotNLMKIQodpfBpsFndBHZgUfFqe/6gSRH5TLPQZ6f
	2EioqnW6lNFub5//Pvqd4GIWqoDVq1cwKolLDxA5Ai42mwsA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yptuy1uru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 09:53:33 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45C9rXSh013682
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 09:53:33 GMT
Received: from luoj-gv.qualcomm.com (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 12 Jun
 2024 02:53:29 -0700
From: Luo Jie <quic_luoj@quicinc.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
        <linux@armlinux.org.uk>, <corbet@lwn.net>, <vladimir.oltean@nxp.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH net-next 0/2] Introduce PHY mode 10G-QXGMII
Date: Wed, 12 Jun 2024 17:53:15 +0800
Message-ID: <20240612095317.1261855-1-quic_luoj@quicinc.com>
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
X-Proofpoint-GUID: g_iMA5xOiqjxnp3lsznu5Ie_Cx3rYknf
X-Proofpoint-ORIG-GUID: g_iMA5xOiqjxnp3lsznu5Ie_Cx3rYknf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_06,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 clxscore=1011 mlxlogscore=748 phishscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406120071

This patch series adds 10G-QXGMII mode for PHY driver. The patch
series is split from the QCA8084 PHY driver patch series below.
https://lore.kernel.org/all/20231215074005.26976-1-quic_luoj@quicinc.com/
 
Per Andrew Lunn’s advice, submitting this patch series for acceptance
as they already include the necessary 'Reviewed-by:' tags. This way,
they need not wait for QCA8084 series patches to conclude review.

Vladimir Oltean (2):
  net: phy: introduce core support for phy-mode = "10g-qxgmii"
  dt-bindings: net: ethernet-controller: add 10g-qxgmii mode

 .../devicetree/bindings/net/ethernet-controller.yaml |  1 +
 Documentation/networking/phy.rst                     |  6 ++++++
 drivers/net/phy/phy-core.c                           |  1 +
 drivers/net/phy/phylink.c                            | 12 ++++++++++--
 include/linux/phy.h                                  |  4 ++++
 include/linux/phylink.h                              |  1 +
 6 files changed, 23 insertions(+), 2 deletions(-)


base-commit: 91579c93a9b207725559e3199870419afd50220f
-- 
2.34.1


