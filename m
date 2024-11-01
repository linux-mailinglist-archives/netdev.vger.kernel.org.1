Return-Path: <netdev+bounces-140986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C696A9B8F55
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 11:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7A861C222E6
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 10:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B5B1A08D7;
	Fri,  1 Nov 2024 10:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dEbeWQix"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3901A0AE1;
	Fri,  1 Nov 2024 10:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730457326; cv=none; b=H5rCuP/TbmBIflXLpkfbcFFFIUDgj1muzHodvU3j9ux9TxxTJL92KnsO2AwW/KHzXRQl5ZPh3Y8DBMjEVPJ3E+tNMr7cnhRkTaDFPhAAERPShfc9L15HEvGb8A1VF0lMTkndgDVV6PZ9y5RkYQwog+4m0C0hcKiedvjP5pHuzOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730457326; c=relaxed/simple;
	bh=5BCkNeRcshI9KjANnXaqdtrejbfKFp3NeWF0f9umzBg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=PSFylbZ8qgNckdTiN3HNRTxqnncwxrMIU46z5Z8FqjcmOhnpYRm6alo+PWPvCm6ODPVAhCHLZnNMtdpZn8jRJ4ck+FTTXpRpitR3rYJkqqWYGAJk8Td65MD+44mSwxeWUQmOmGAeH0tBg4FufSVL9ljMUOuQzCl3HrcFfQmtDWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dEbeWQix; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A13Jnk2019830;
	Fri, 1 Nov 2024 10:35:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cJU8D/oiuhvdJzzr8DdcXs2hWijqPz683UrCaE/vrEk=; b=dEbeWQixWnhrmvwG
	v2pQZEwcu2l5PuvBGeOwtyRPOSS6NyXtJAwhB8Y4XHi5hv33tTh1F7y3DwITKHXn
	iv3NGDX20DWYfUoVwBFEEGJ0bf8O8K6Z4dV6w0S3RmgnJouDicmc438ZugeGMNgZ
	oEZt8YVFO/kjtGbW//aQleF+ISIp0zIVnmNiq1VUiZKCGKxxi463FDJOWmUY4k1P
	qI9tulvkNPHf6sUr1gY2ZpOPGu8xpd8QuuEm/ZhLbUw6HkuQBRIC5tjTFAdPJT8o
	tFGoaMtXQIO/vghL5/yDcZWdnwlQoQ8YQl5J4JZaSr4q9vNSf1SELUe1FlQUT/+E
	+3hNAw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42kmp0pupy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Nov 2024 10:35:07 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A1AZ7oI023884
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 1 Nov 2024 10:35:07 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 1 Nov 2024 03:35:00 -0700
From: Lei Wei <quic_leiwei@quicinc.com>
Date: Fri, 1 Nov 2024 18:32:52 +0800
Subject: [PATCH net-next 4/5] net: pcs: qcom-ipq: Add USXGMII interface
 mode for IPQ9574
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241101-ipq_pcs_rc1-v1-4-fdef575620cf@quicinc.com>
References: <20241101-ipq_pcs_rc1-v1-0-fdef575620cf@quicinc.com>
In-Reply-To: <20241101-ipq_pcs_rc1-v1-0-fdef575620cf@quicinc.com>
To: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andrew Lunn
	<andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King
	<linux@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_kkumarcs@quicinc.com>,
        <quic_suruchia@quicinc.com>, <quic_pavir@quicinc.com>,
        <quic_linchen@quicinc.com>, <quic_luoj@quicinc.com>,
        <quic_leiwei@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <bartosz.golaszewski@linaro.org>, <vsmuthu@qti.qualcomm.com>,
        <john@phrozen.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730457277; l=7406;
 i=quic_leiwei@quicinc.com; s=20240829; h=from:subject:message-id;
 bh=5BCkNeRcshI9KjANnXaqdtrejbfKFp3NeWF0f9umzBg=;
 b=EKC/Faohp4cixOpYExMX2fd++2qoCs2XW2LN+AiwZDCKBu1IcH/N0zkQcR2XUAXxqCOfKJzwD
 xLKWmLwXB+PAsG5Ufj6yrSCnolMkzAw5B1gX+I6tW0mpmZMv0zH0UJ9
X-Developer-Key: i=quic_leiwei@quicinc.com; a=ed25519;
 pk=uFXBHtxtDjtIrTKpDEZlMLSn1i/sonZepYO8yioKACM=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 690z9GnxDjB4r-KgS961yNTXifzaispV
X-Proofpoint-ORIG-GUID: 690z9GnxDjB4r-KgS961yNTXifzaispV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 mlxscore=0 suspectscore=0
 adultscore=0 clxscore=1015 phishscore=0 spamscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411010076

USXGMII mode is enabled by PCS when 10Gbps PHYs are connected, such as
Aquantia 10Gbps PHY.

Signed-off-by: Lei Wei <quic_leiwei@quicinc.com>
---
 drivers/net/pcs/pcs-qcom-ipq.c | 180 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 180 insertions(+)

diff --git a/drivers/net/pcs/pcs-qcom-ipq.c b/drivers/net/pcs/pcs-qcom-ipq.c
index dd432303b549..19cb995f7c87 100644
--- a/drivers/net/pcs/pcs-qcom-ipq.c
+++ b/drivers/net/pcs/pcs-qcom-ipq.c
@@ -26,6 +26,7 @@
 #define PCS_MODE_SEL_MASK		GENMASK(12, 8)
 #define PCS_MODE_SGMII			FIELD_PREP(PCS_MODE_SEL_MASK, 0x4)
 #define PCS_MODE_QSGMII			FIELD_PREP(PCS_MODE_SEL_MASK, 0x1)
+#define PCS_MODE_XPCS			FIELD_PREP(PCS_MODE_SEL_MASK, 0x10)
 #define PCS_MODE_AN_MODE		BIT(0)
 
 #define PCS_MII_CTRL(x)			(0x480 + 0x18 * (x))
@@ -57,6 +58,35 @@
 					 FIELD_PREP(GENMASK(9, 2), \
 					 FIELD_GET(XPCS_INDIRECT_ADDR_L, reg)))
 
+#define XPCS_DIG_CTRL			0x38000
+#define XPCS_USXG_ADPT_RESET		BIT(10)
+#define XPCS_USXG_EN			BIT(9)
+
+#define XPCS_MII_CTRL			0x1f0000
+#define XPCS_MII_AN_EN			BIT(12)
+#define XPCS_DUPLEX_FULL		BIT(8)
+#define XPCS_SPEED_MASK			(BIT(13) | BIT(6) | BIT(5))
+#define XPCS_SPEED_10000		(BIT(13) | BIT(6))
+#define XPCS_SPEED_5000			(BIT(13) | BIT(5))
+#define XPCS_SPEED_2500			BIT(5)
+#define XPCS_SPEED_1000			BIT(6)
+#define XPCS_SPEED_100			BIT(13)
+#define XPCS_SPEED_10			0
+
+#define XPCS_MII_AN_CTRL		0x1f8001
+#define XPCS_MII_AN_8BIT		BIT(8)
+
+#define XPCS_MII_AN_INTR_STS		0x1f8002
+#define XPCS_USXG_AN_LINK_STS		BIT(14)
+#define XPCS_USXG_AN_DUPLEX_FULL	BIT(13)
+#define XPCS_USXG_AN_SPEED_MASK		GENMASK(12, 10)
+#define XPCS_USXG_AN_SPEED_10		0
+#define XPCS_USXG_AN_SPEED_100		1
+#define XPCS_USXG_AN_SPEED_1000		2
+#define XPCS_USXG_AN_SPEED_2500		4
+#define XPCS_USXG_AN_SPEED_5000		5
+#define XPCS_USXG_AN_SPEED_10000	3
+
 /* Private data for the PCS instance */
 struct ipq_pcs {
 	struct device *dev;
@@ -144,9 +174,57 @@ static void ipq_pcs_get_state_sgmii(struct ipq_pcs *qpcs,
 		state->pause |= MLO_PAUSE_RX;
 }
 
+static void ipq_pcs_get_state_usxgmii(struct ipq_pcs *qpcs,
+				      struct phylink_link_state *state)
+{
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(qpcs->regmap, XPCS_MII_AN_INTR_STS, &val);
+	if (ret) {
+		state->link = 0;
+		return;
+	}
+
+	state->link = !!(val & XPCS_USXG_AN_LINK_STS);
+
+	if (!state->link)
+		return;
+
+	switch (FIELD_GET(XPCS_USXG_AN_SPEED_MASK, val)) {
+	case XPCS_USXG_AN_SPEED_10000:
+		state->speed = SPEED_10000;
+		break;
+	case XPCS_USXG_AN_SPEED_5000:
+		state->speed = SPEED_5000;
+		break;
+	case XPCS_USXG_AN_SPEED_2500:
+		state->speed = SPEED_2500;
+		break;
+	case XPCS_USXG_AN_SPEED_1000:
+		state->speed = SPEED_1000;
+		break;
+	case XPCS_USXG_AN_SPEED_100:
+		state->speed = SPEED_100;
+		break;
+	case XPCS_USXG_AN_SPEED_10:
+		state->speed = SPEED_10;
+		break;
+	default:
+		state->link = false;
+		return;
+	}
+
+	if (val & XPCS_USXG_AN_DUPLEX_FULL)
+		state->duplex = DUPLEX_FULL;
+	else
+		state->duplex = DUPLEX_HALF;
+}
+
 static int ipq_pcs_config_mode(struct ipq_pcs *qpcs,
 			       phy_interface_t interface)
 {
+	unsigned long rate = 125000000;
 	unsigned int val;
 	int ret;
 
@@ -167,6 +245,13 @@ static int ipq_pcs_config_mode(struct ipq_pcs *qpcs,
 		if (ret)
 			return ret;
 		break;
+	case PHY_INTERFACE_MODE_USXGMII:
+		rate = 312500000;
+		ret = regmap_update_bits(qpcs->regmap, PCS_MODE_CTRL,
+					 PCS_MODE_SEL_MASK, PCS_MODE_XPCS);
+		if (ret)
+			return ret;
+		break;
 	default:
 		dev_err(qpcs->dev,
 			"Unsupported interface %s\n", phy_modes(interface));
@@ -196,6 +281,21 @@ static int ipq_pcs_config_mode(struct ipq_pcs *qpcs,
 
 	qpcs->interface = interface;
 
+	/* Configure the RX and TX clock to NSSCC as 125M or 312.5M based
+	 * on current interface mode.
+	 */
+	ret = clk_set_rate(qpcs->rx_hw.clk, rate);
+	if (ret) {
+		dev_err(qpcs->dev, "Failed to set RX clock rate\n");
+		return ret;
+	}
+
+	ret = clk_set_rate(qpcs->tx_hw.clk, rate);
+	if (ret) {
+		dev_err(qpcs->dev, "Failed to set TX clock rate\n");
+		return ret;
+	}
+
 	return 0;
 }
 
@@ -240,6 +340,35 @@ static int ipq_pcs_config_sgmii(struct ipq_pcs *qpcs,
 	return ret;
 }
 
+static int ipq_pcs_config_usxgmii(struct ipq_pcs *qpcs)
+{
+	int ret;
+
+	/* Configure the XPCS for USXGMII mode if required */
+	if (qpcs->interface != PHY_INTERFACE_MODE_USXGMII) {
+		ret = ipq_pcs_config_mode(qpcs, PHY_INTERFACE_MODE_USXGMII);
+		if (ret)
+			return ret;
+
+		ret = regmap_update_bits(qpcs->regmap, XPCS_DIG_CTRL,
+					 XPCS_USXG_EN, XPCS_USXG_EN);
+		if (ret)
+			return ret;
+
+		ret = regmap_update_bits(qpcs->regmap, XPCS_MII_AN_CTRL,
+					 XPCS_MII_AN_8BIT, XPCS_MII_AN_8BIT);
+		if (ret)
+			return ret;
+
+		ret = regmap_update_bits(qpcs->regmap, XPCS_MII_CTRL,
+					 XPCS_MII_AN_EN, XPCS_MII_AN_EN);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int ipq_pcs_link_up_config_sgmii(struct ipq_pcs *qpcs,
 					int index,
 					unsigned int neg_mode,
@@ -288,6 +417,49 @@ static int ipq_pcs_link_up_config_sgmii(struct ipq_pcs *qpcs,
 				  PCS_MII_ADPT_RESET, PCS_MII_ADPT_RESET);
 }
 
+static int ipq_pcs_link_up_config_usxgmii(struct ipq_pcs *qpcs, int speed)
+{
+	unsigned int val;
+	int ret;
+
+	switch (speed) {
+	case SPEED_10000:
+		val = XPCS_SPEED_10000;
+		break;
+	case SPEED_5000:
+		val = XPCS_SPEED_5000;
+		break;
+	case SPEED_2500:
+		val = XPCS_SPEED_2500;
+		break;
+	case SPEED_1000:
+		val = XPCS_SPEED_1000;
+		break;
+	case SPEED_100:
+		val = XPCS_SPEED_100;
+		break;
+	case SPEED_10:
+		val = XPCS_SPEED_10;
+		break;
+	default:
+		dev_err(qpcs->dev, "Invalid USXGMII speed %d\n", speed);
+		return -EINVAL;
+	}
+
+	/* USXGMII only support full duplex mode */
+	val |= XPCS_DUPLEX_FULL;
+
+	/* Configure XPCS speed */
+	ret = regmap_update_bits(qpcs->regmap, XPCS_MII_CTRL,
+				 XPCS_SPEED_MASK | XPCS_DUPLEX_FULL, val);
+	if (ret)
+		return ret;
+
+	/* XPCS adapter reset */
+	return regmap_update_bits(qpcs->regmap, XPCS_DIG_CTRL,
+				  XPCS_USXG_ADPT_RESET, XPCS_USXG_ADPT_RESET);
+}
+
 static void ipq_pcs_get_state(struct phylink_pcs *pcs,
 			      struct phylink_link_state *state)
 {
@@ -300,6 +472,9 @@ static void ipq_pcs_get_state(struct phylink_pcs *pcs,
 	case PHY_INTERFACE_MODE_QSGMII:
 		ipq_pcs_get_state_sgmii(qpcs, index, state);
 		break;
+	case PHY_INTERFACE_MODE_USXGMII:
+		ipq_pcs_get_state_usxgmii(qpcs, state);
+		break;
 	default:
 		break;
 	}
@@ -326,6 +501,8 @@ static int ipq_pcs_config(struct phylink_pcs *pcs,
 	case PHY_INTERFACE_MODE_SGMII:
 	case PHY_INTERFACE_MODE_QSGMII:
 		return ipq_pcs_config_sgmii(qpcs, index, neg_mode, interface);
+	case PHY_INTERFACE_MODE_USXGMII:
+		return ipq_pcs_config_usxgmii(qpcs);
 	default:
 		dev_err(qpcs->dev,
 			"Unsupported interface %s\n", phy_modes(interface));
@@ -349,6 +526,9 @@ static void ipq_pcs_link_up(struct phylink_pcs *pcs,
 		ret = ipq_pcs_link_up_config_sgmii(qpcs, index,
 						   neg_mode, speed);
 		break;
+	case PHY_INTERFACE_MODE_USXGMII:
+		ret = ipq_pcs_link_up_config_usxgmii(qpcs, speed);
+		break;
 	default:
 		dev_err(qpcs->dev,
 			"Unsupported interface %s\n", phy_modes(interface));

-- 
2.34.1


