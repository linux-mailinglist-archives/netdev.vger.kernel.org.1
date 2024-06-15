Return-Path: <netdev+bounces-103793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEEF909816
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 14:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 351A5283E7F
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 12:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C844449623;
	Sat, 15 Jun 2024 12:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aEeMXd21"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DD2481AB;
	Sat, 15 Jun 2024 12:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718452884; cv=none; b=u26tB2UbzXwpjGHe4amu6XWq73+Ke53wIvHBgSn9c+rUHTbkYWw7UEKIBST1XsbnftdQyXmd0jmjupXPj+DfrPa7f3IkC1tX2TC8VmqIzxIE3GaoA+h2Nn5JccTXqf9ujLUqNtsjz6BAe6dP3LbLqd2EfLUcfsejmqOqE45CX4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718452884; c=relaxed/simple;
	bh=1KEWyFoCMTmoTcxSTlV4zMfEojOLQmrzSBfJGBmPpLE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uTwsmMIbEaRJAi3FrJiKpGiB3+HTii3TwecSyM/fjIjyJY29n31awovjgc16vtzu2UINFE/MvG3DiXVCVY3RgH8/d4CMnmkh7VXJrFggC3z+ZGYWeO4FG5VpD2p1FEh4mAYNIMyS3+YtKDAmJsNKr/8GogLiVlRyUV6R1ipg9Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aEeMXd21; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45FBUJEW016513;
	Sat, 15 Jun 2024 12:00:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lBymZgJFy/4Nwqfcncss78bsklXX4SxvhrH9q6SaQZY=; b=aEeMXd21vADXl703
	Il1kNPWMNF9q+CYl5Q48vjjgg6TZ+WKApvNs2P0mZjrkxCanW+VNOmfUcfp9RHOY
	ORxH6JRwJ6z1byWgkj2hvYKtY1mlp3KV+ROlXhGtpw8VpgpLlMmDNNf/QtB3ibV9
	HZf8fOyvXcABUuTWPXNAWRpCOfIHzp5X98jfT0nlPPubzkxTn5Om38WjzRnnm2jz
	CSGBSj4+SePBW5ZnnTijLoZj3rgstNZr/hK8JTrmCbAndtKQTnBWXbsjOLpOVPNW
	Yt9QD1+KVCgWV/t6mhf/3Ek7pHUZtcXjUFz3TA1vC7+UnQPl8bscHxtet0UkxOuS
	1tzXtA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ys1y6rmad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Jun 2024 12:00:57 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45FC0tt1014197
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Jun 2024 12:00:55 GMT
Received: from luoj-gv.qualcomm.com (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 15 Jun
 2024 05:00:47 -0700
From: Luo Jie <quic_luoj@quicinc.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
        <linux@armlinux.org.uk>, <corbet@lwn.net>, <vladimir.oltean@nxp.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH net-next v2 2/2] dt-bindings: net: ethernet-controller: add 10g-qxgmii mode
Date: Sat, 15 Jun 2024 20:00:28 +0800
Message-ID: <20240615120028.2384732-3-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240615120028.2384732-1-quic_luoj@quicinc.com>
References: <20240615120028.2384732-1-quic_luoj@quicinc.com>
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
X-Proofpoint-GUID: QnXwXMQqWjNSTlHeOntmevy0lgoacB6O
X-Proofpoint-ORIG-GUID: QnXwXMQqWjNSTlHeOntmevy0lgoacB6O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-15_08,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406150092

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


