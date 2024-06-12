Return-Path: <netdev+bounces-102835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90625904FB8
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 11:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AAB61C20DE6
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 09:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A835616F26C;
	Wed, 12 Jun 2024 09:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VenXACPk"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3883616E885;
	Wed, 12 Jun 2024 09:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718186038; cv=none; b=h+rl0nFJx+3vFsflxlf1lrOeKmgepxCc7pSTt+fHS2EbH1tfdhu8hc+ifaCUix0pGMvaP++hsD2YK1KfmRse3WXttDf2O7Opt3/OFfnUfCNTSo8xkx8h8Yf6hyWXH7vGnpDe1Ro0PSxVCTM4eyDVR2u53mP0NDMeEvUsi6lOITs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718186038; c=relaxed/simple;
	bh=1KEWyFoCMTmoTcxSTlV4zMfEojOLQmrzSBfJGBmPpLE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jSZGrdULSiE+Sc869jk6FgOBd37ATs0u7O/Yv+63jWmJrYD//da3dYswqPQpdT+fqxEKNWNtvMqTWrp+My2NUpdK6TQ5p3tWSNfOiwkCk3pqS+WKCyLfiyJd5AzmwnRPVuickyBQBBwC9KoWEqdhGXTH8MpfuLEcxg68Lggt6SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VenXACPk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45C9KrNf018083;
	Wed, 12 Jun 2024 09:53:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lBymZgJFy/4Nwqfcncss78bsklXX4SxvhrH9q6SaQZY=; b=VenXACPkTUP6c8RC
	l5cOZkgzLWtGEflFJLzbm51qLIb2e9wPULUMvs1j+CrP+CWjolHP2cXDbVejvIcE
	kDeMr1PBpSp/2C+CMi8D2N1xzDGrajR89QZEkrLp84hbI6XCaAaWyoJqw/zGNHly
	niqpL68t4ysumNL/BoF4qFJhgO2aLlAAturvimecceh56gacxfWzLcbdmVGQRIV/
	37lOL11LJZRAJqW3x+lFYVCXcsyrGoFdpi1Zih2hov2ZxiE2I/Tc9wB2G7mP4eXL
	hCLpIUhS4A82A4kKUj8RmyJgs/dC0zw9vz26c00ObNkatNG91stZJM9Dh+cd0RAN
	fFwJUA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ypp87ts8n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 09:53:42 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45C9rfhf027041
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 09:53:41 GMT
Received: from luoj-gv.qualcomm.com (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 12 Jun
 2024 02:53:37 -0700
From: Luo Jie <quic_luoj@quicinc.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
        <linux@armlinux.org.uk>, <corbet@lwn.net>, <vladimir.oltean@nxp.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH net-next 2/2] dt-bindings: net: ethernet-controller: add 10g-qxgmii mode
Date: Wed, 12 Jun 2024 17:53:17 +0800
Message-ID: <20240612095317.1261855-3-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240612095317.1261855-1-quic_luoj@quicinc.com>
References: <20240612095317.1261855-1-quic_luoj@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uAiV06oRFTUmciDQ6inKAGW3PuC7c7TR
X-Proofpoint-ORIG-GUID: uAiV06oRFTUmciDQ6inKAGW3PuC7c7TR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_06,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 bulkscore=0 mlxscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406120071

From: Vladimir Oltean <vladimir.oltean@nxp.com>

Add the new interface mode 10g-qxgmii, which is similar to
usxgmii but extend to 4 channels to support maximum of 4
ports with the link speed 10M/100M/1G/2.5G.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 Documentation/devicetree/bindings/net/ethernet-controller.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
index b2785b03139f..45819b235800 100644
--- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
@@ -103,6 +103,7 @@ properties:
       - usxgmii
       - 10gbase-r
       - 25gbase-r
+      - 10g-qxgmii
 
   phy-mode:
     $ref: "#/properties/phy-connection-type"
-- 
2.34.1


