Return-Path: <netdev+bounces-230580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D928FBEB647
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 21:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4274D34BA2B
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 19:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85768311964;
	Fri, 17 Oct 2025 19:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XAauZ4PW"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB28C3002D6
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 19:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760729751; cv=none; b=sM6GA8urybKeknlVT7qt7WkewAYpgZDeifzyiyULm4RfI+iiT4FWkf4g2Q4wbvD5QtbqjunK+t2lWeHDClHG7VE57ka37GhY0UrSWVLxXPG7qhAC/qMgBEahCkLSVaI8+9edDBXi+VMRY6s80iCwazLifhFu8Z+/CGMijZTVXG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760729751; c=relaxed/simple;
	bh=KlclBd1/gJj+OViHhBFdBhHTzD0ZDq//c227oFmq41A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kEc//EzeCp9tBgaLYTTvqGNZldZWg3qTf4b7f1riYIi/W/J5Q+QO1LxSHvekZg+iYx5MxzAPWKjh5wKnBW6gmEdXn+CoB36ui1w9ydl5XdEpSiqYqqtapEC+tNzXl7h2FmkBc5xLouQcL+Qmsy4vDbtPn6vfYvjfvqPNQ/uLqpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XAauZ4PW; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59HCde7i030396;
	Fri, 17 Oct 2025 19:35:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=mTfJi
	0v+ygxGHBYhPR+1kyj7HRod4cSvCN/Ge50W+/w=; b=XAauZ4PWD/hXY0MaYOMwW
	UykcWbC4+4jnwL3BYw9mGSh2Op6YM9lnm+CSvacEtii+noAUhq0W6auhMcl7jQd9
	gGuIdFMO11fN7CZIWFP80/AhHmdbQ8DE2WhgDxVFateylgx1vZlk/7mghLVnJp1i
	iMUa54oKyQkndzXsjfP9YKZZbtgi/tulGn1s5vjwoIqsjQggatG7XJugzx5cSF6J
	TlTN6Ubss0Mp+pebyljFp6tDSkTC7JtPQ012jKcsUnQSF/UH0aMVWfdhZykKEsi9
	yfBelOBBVenjOz3D4KRrTgHZZMyz4ijVnx4fvauFXhBx5YBs0kJhb67CQqgkWYGy
	A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qdncbjy4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 19:35:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59HI2G1R002237;
	Fri, 17 Oct 2025 19:35:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpkg5uh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 19:35:32 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59HJZUVP017300;
	Fri, 17 Oct 2025 19:35:31 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 49qdpkg5t3-2;
	Fri, 17 Oct 2025 19:35:31 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: hkallweit1@gmail.com, andrew@lunn.ch, kuba@kernel.org,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, horms@kernel.org, linux@armlinux.org.uk,
        netdev@vger.kernel.org, alok.a.tiwari@oracle.com
Cc: alok.a.tiwarilinux@gmail.com
Subject: [PATCH net-next 2/2] net: phy: micrel: fix typos in comments
Date: Fri, 17 Oct 2025 12:35:21 -0700
Message-ID: <20251017193525.1457064-2-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251017193525.1457064-1-alok.a.tiwari@oracle.com>
References: <20251017193525.1457064-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510170149
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAwNiBTYWx0ZWRfXxQGPEx6RkF4P
 3rmsZA9OhMdvCTwQADM7EbZoAlcEz8uhWqVCGRCX7ycZj9CQP8zaglVPvzjfrP7zGmy92/Q+a7C
 NVUTUhQU6HXit6Xt6rOM3g/+6OZaqSHCg+COL/alrkraCv4aq95c92F7+8tLbKKDv99Yj460l8r
 6yCFI7xYz8g4lgG8ZZc3B7eULDGY/uYOhL514e4/o17d/ATmYylxks+lZuu1rl4AyrE9dFuYdGo
 VVfFQcr5ZsPd1qIp32Me6g5jSzBifurMhHl0LZmvZkf5aKtsmLfhptNbMjek9N/yIPhcO5P8kB3
 Am9+1H9tGZCpBvoCrRVyPnwTKYG0HXGqeWXp58JXUPQJw//dJNhp1idYgy/oeKaiga6lsbX5XAN
 1v1hFIIVCfbDcCc/NAA9KrTGaqxL5BN9GR3PVDT5w2Y+wlcJXI8=
X-Proofpoint-GUID: pbxp-xI6PdJ45aS_HxKBrVEHc_PjxmpW
X-Authority-Analysis: v=2.4 cv=ReCdyltv c=1 sm=1 tr=0 ts=68f29a84 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=TdIup4c53DgqRV6WsYcA:9 cc=ntf awl=host:12092
X-Proofpoint-ORIG-GUID: pbxp-xI6PdJ45aS_HxKBrVEHc_PjxmpW

Fix several spelling and grammatical errors in comments across
micrel PHY drivers. Corrections include:
- "dealy" -> "delay"
- "autonegotation" -> "autonegotiation"
- "recheas" -> "reaches"
- "one" -> "on"
- "improvenent" -> "improvement"
- "intput" -> "input"

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/phy/micrel.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 65994d97c403..5f2c7e5c314f 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -1050,7 +1050,7 @@ static int ksz9021_config_init(struct phy_device *phydev)
 #define TX_CLK_ID			0x1f
 
 /* set tx and tx_clk to "No delay adjustment" to keep 0ns
- * dealy
+ * delay
  */
 #define TX_ND				0x7
 #define TX_CLK_ND			0xf
@@ -1913,7 +1913,7 @@ static int ksz886x_config_aneg(struct phy_device *phydev)
 		return ret;
 
 	if (phydev->autoneg != AUTONEG_ENABLE) {
-		/* When autonegotation is disabled, we need to manually force
+		/* When autonegotiation is disabled, we need to manually force
 		 * the link state. If we don't do this, the PHY will keep
 		 * sending Fast Link Pulses (FLPs) which are part of the
 		 * autonegotiation process. This is not desired when
@@ -3533,7 +3533,7 @@ static void lan8814_ptp_disable_event(struct phy_device *phydev, int event)
 	/* Set target to too far in the future, effectively disabling it */
 	lan8814_ptp_set_target(phydev, event, 0xFFFFFFFF, 0);
 
-	/* And then reload once it recheas the target */
+	/* And then reload once it reaches the target */
 	lanphy_modify_page_reg(phydev, LAN8814_PAGE_COMMON_REGS, LAN8814_PTP_GENERAL_CONFIG,
 			       LAN8814_PTP_GENERAL_CONFIG_RELOAD_ADD_X(event),
 			       LAN8814_PTP_GENERAL_CONFIG_RELOAD_ADD_X(event));
@@ -4403,7 +4403,7 @@ static int lan8814_release_coma_mode(struct phy_device *phydev)
 static void lan8814_clear_2psp_bit(struct phy_device *phydev)
 {
 	/* It was noticed that when traffic is passing through the PHY and the
-	 * cable is removed then the LED was still one even though there is no
+	 * cable is removed then the LED was still on even though there is no
 	 * link
 	 */
 	lanphy_modify_page_reg(phydev, LAN8814_PAGE_PCS_DIGITAL, LAN8814_EEE_STATE,
@@ -4543,7 +4543,7 @@ static int lan8841_config_init(struct phy_device *phydev)
 	phy_write_mmd(phydev, KSZ9131RN_MMD_COMMON_CTRL_REG,
 		      LAN8841_PTP_TX_VERSION, 0xff00);
 
-	/* 100BT Clause 40 improvenent errata */
+	/* 100BT Clause 40 improvement errata */
 	phy_write_mmd(phydev, LAN8841_MMD_ANALOG_REG,
 		      LAN8841_ANALOG_CONTROL_1,
 		      LAN8841_ANALOG_CONTROL_1_PLL_TRIM(0x2));
@@ -5563,7 +5563,7 @@ static int lan8841_ptp_extts_on(struct kszphy_ptp_priv *ptp_priv, int pin,
 	u16 tmp = 0;
 	int ret;
 
-	/* Set GPIO to be intput */
+	/* Set GPIO to be input */
 	ret = phy_set_bits_mmd(phydev, 2, LAN8841_GPIO_EN, BIT(pin));
 	if (ret)
 		return ret;
-- 
2.50.1


