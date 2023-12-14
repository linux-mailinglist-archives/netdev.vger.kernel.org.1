Return-Path: <netdev+bounces-57291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1D9812C15
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 10:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C85761C21561
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 09:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29AC3418E;
	Thu, 14 Dec 2023 09:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="avuB8VK+"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A319B10E2;
	Thu, 14 Dec 2023 01:49:22 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BE5ebtr021783;
	Thu, 14 Dec 2023 09:49:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=Pv0bj9BwrtvC5bjKTWWscgwoj6oQ0HJW9ayhPrX1rpc=; b=av
	uB8VK+rZji8jFbuHXmSyXY5nWcKQdgZrYa3fhsrTJZfI5x18N29SlgGQPWry9Tw/
	HgErdP463iQgVtyHKxZ3pVS203iiTYg6R1wCGCRKIh4gsTjkV9J7rvx8nfzELmQ8
	tGUIxgg85Az4IxKQnII5pLwWkkRjCY8FLQnwOS6rRFsGES5xzQI8LL2ukmQlv9Rw
	Xd736LirDR3DUh8lw4w/1D93XXbGAbIpfqPn3AZ31Fwfy1hcBy9SjySyk9L6LDPN
	qjyee+H2eyi7VVh2WySVYW4oIcn26UUSEmRS5Hx+g1VMLrs/+wyrO010u5+vRtfL
	uw1fDA46r4F2SAGtpCsg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uynre131p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 09:49:09 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BE9n8WY001600
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 09:49:08 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Dec 2023 01:49:03 -0800
From: Luo Jie <quic_luoj@quicinc.com>
To: <andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <corbet@lwn.net>,
        <p.zabel@pengutronix.de>, <f.fainelli@gmail.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v7 09/14] net: phy: at803x: set MDIO address of qca8084 PHY
Date: Thu, 14 Dec 2023 17:48:08 +0800
Message-ID: <20231214094813.24690-10-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231214094813.24690-1-quic_luoj@quicinc.com>
References: <20231214094813.24690-1-quic_luoj@quicinc.com>
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
X-Proofpoint-ORIG-GUID: B344eEj8kRyMFwBGLtS16jb4hoxAoER7
X-Proofpoint-GUID: B344eEj8kRyMFwBGLtS16jb4hoxAoER7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312140065

Program the MDIO address of qca8084 PHY and PCS device
in the PHY probe function.

The MDIO address of qca8084 device is configured according
to the property "qcom,phy-addr-fixup" of phy node, which
defines the MDIO address for 4 PHYs and 3 PCSes, each MDIO
address occupies 5 bits in the config register.

The MDIO address of qca8084 should be configured correctly
before doing the clock initialization in the PHY probe function,
so the property "reg" can't be used to configure the MDIO address
of phy device one by one, the clock initialization will be configured
with all 4 PHY devices in one PHY probe function.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/net/phy/at803x.c | 61 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index 016e40e32982..a00c5950683c 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -303,6 +303,18 @@
 #define QCA8084_HIGH_ADDR_PREFIX		0x18
 #define QCA8084_LOW_ADDR_PREFIX			0x10
 
+#define QCA8084_PCS_CFG				0xc90f014
+#define QCA8084_PCS_ADDR0_MASK			GENMASK(4, 0)
+#define QCA8084_PCS_ADDR1_MASK			GENMASK(9, 5)
+#define QCA8084_PCS_ADDR2_MASK			GENMASK(14, 10)
+
+#define QCA8084_EPHY_CFG			0xc90f018
+#define QCA8084_EPHY_ADDR0_MASK			GENMASK(4, 0)
+#define QCA8084_EPHY_ADDR1_MASK			GENMASK(9, 5)
+#define QCA8084_EPHY_ADDR2_MASK			GENMASK(14, 10)
+#define QCA8084_EPHY_ADDR3_MASK			GENMASK(19, 15)
+#define QCA8084_EPHY_LDO_EN			GENMASK(21, 20)
+
 MODULE_DESCRIPTION("Qualcomm Atheros AR803x and QCA808X PHY driver");
 MODULE_AUTHOR("Matus Ujhelyi");
 MODULE_LICENSE("GPL");
@@ -955,6 +967,51 @@ static int at803x_parse_dt(struct phy_device *phydev)
 	return 0;
 }
 
+static int qca8084_parse_and_set_phyaddr(struct phy_device *phydev)
+{
+	struct device_node *node;
+	u32 addr[7];
+	int ret;
+
+	node = phydev->mdio.dev.of_node;
+
+	/* The property "qcom,phy-addr-fixup" is only defined in one
+	 * PHY device tree node.
+	 */
+	ret = of_property_read_u32_array(node, "qcom,phy-addr-fixup",
+					 addr, ARRAY_SIZE(addr));
+	if (ret)
+		return ret == -EINVAL ? 0 : ret;
+
+	/* There are 4 PHYs and 3 PCSes on qca8084 chip, each device address
+	 * occupies 5 bits of the config register to customize the MDIO address.
+	 */
+	ret = qca8084_mii_modify(phydev, QCA8084_EPHY_CFG,
+				 QCA8084_EPHY_ADDR0_MASK |
+				 QCA8084_EPHY_ADDR1_MASK |
+				 QCA8084_EPHY_ADDR2_MASK |
+				 QCA8084_EPHY_ADDR3_MASK,
+				 FIELD_PREP(QCA8084_EPHY_ADDR0_MASK, addr[0]) |
+				 FIELD_PREP(QCA8084_EPHY_ADDR1_MASK, addr[1]) |
+				 FIELD_PREP(QCA8084_EPHY_ADDR2_MASK, addr[2]) |
+				 FIELD_PREP(QCA8084_EPHY_ADDR3_MASK, addr[3]));
+	if (ret)
+		return ret;
+
+	return qca8084_mii_modify(phydev, QCA8084_PCS_CFG,
+				  QCA8084_PCS_ADDR0_MASK |
+				  QCA8084_PCS_ADDR1_MASK |
+				  QCA8084_PCS_ADDR2_MASK,
+				  FIELD_PREP(QCA8084_PCS_ADDR0_MASK, addr[4]) |
+				  FIELD_PREP(QCA8084_PCS_ADDR1_MASK, addr[5]) |
+				  FIELD_PREP(QCA8084_PCS_ADDR2_MASK, addr[6]));
+}
+
+static int qca8084_probe(struct phy_device *phydev)
+{
+	return qca8084_parse_and_set_phyaddr(phydev);
+}
+
 static int at803x_probe(struct phy_device *phydev)
 {
 	struct device *dev = &phydev->mdio.dev;
@@ -967,6 +1024,9 @@ static int at803x_probe(struct phy_device *phydev)
 
 	phydev->priv = priv;
 
+	if (phydev_id_compare(phydev, QCA8084_PHY_ID))
+		return qca8084_probe(phydev);
+
 	ret = at803x_parse_dt(phydev);
 	if (ret)
 		return ret;
@@ -2434,6 +2494,7 @@ static struct phy_driver at803x_driver[] = {
 	PHY_ID_MATCH_MODEL(QCA8084_PHY_ID),
 	.name			= "Qualcomm QCA8084",
 	.flags			= PHY_POLL_CABLE_TEST,
+	.probe			= at803x_probe,
 	.config_intr		= at803x_config_intr,
 	.handle_interrupt	= at803x_handle_interrupt,
 	.get_tunable		= at803x_get_tunable,
-- 
2.42.0


