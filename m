Return-Path: <netdev+bounces-108927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02328926413
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 16:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 832011F21046
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 14:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F3F1822E2;
	Wed,  3 Jul 2024 14:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="HL/9SsE/"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05hn2235.outbound.protection.outlook.com [52.100.174.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991D1181D1A;
	Wed,  3 Jul 2024 14:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.100.174.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720018665; cv=fail; b=geg0ehmnYRtQPIITZBv4Kwx1c9WFIAq/LkmdYkX99lEfCjBNMSt/u+Ts92mLAOV/t0r52gqH/Pm6yAPEdwJASEt/TF6H30du1WR2jwtrbgmZ1UWEQM+gEDe4X701ToLsTsvqlrRvjov9MeSApjSdTwo4Dlan1uOGXM8Z98XUDoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720018665; c=relaxed/simple;
	bh=1xoBAkrdIgUmj9FBWp+qKZdOPtOuNx12WQIpIeoIhKI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kSMMqgQZlKCfjYf3aO/eQcapq+knGW4M2spAm6Lgd64Oy/4lMKj/JUJZ5D5hFXnVu9FkTx3IW9XsxkGu9Za2GRmbN0/KDU5qJuh4zo8bf5lrSklJyz2veoSln/5LkGl9mL/EmjZN2CxCiUjNzz8ElipY8hvkrrsuFIFPsfOfNUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=HL/9SsE/; arc=fail smtp.client-ip=52.100.174.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWCnYeHjWEWqIm6dBxmNn8hJ617uA6pomrPDffegjbMAHfQQH//PZ29J5WRcuG6Io7Lc82UhVJm5R+yKSceQkNDq+/P5rsEiEZSY1DmuP53XYRlyAgMUAqYAsldwtM7h1vCw9Kr90b4qUW5aUQqF4DDQ0kQpXRGPi9GOXkgi6ECN8xUhS7cqEXSEhvzDR7SMN+4+SO1/1x/hIBhIHa+qrlEcr7TM3S2UvmgQZSmlcR/+w6+jGoR/C/ZZpDLyM41XcncPh1EFLqdQNACXgVIO4JDhmFGpeSqGxL2/9Mr3Al1tHncisyzQw9dfNskxzrbC6ZwRzL/y14HbHKKOOaNkvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SOsLc1RRGj7Cx25GUugndgTuCBtowFqMXO3cEi6jm4o=;
 b=VI06DQJOKefLw1o/73klXs1RO/x+HJoh3kaCfWGidjPj9x2l/IwJnZlzbWjfr7+Ax0AMDjw6cDe/a90RJKB3Jk1+QCJDNnFr+EHrEJTAhYKcstuAmptl4PGLZUhOyVO46bmT5Dm+ufMkW5GJD5QNrQw1SqeG7cyW3cQY6h8X/6y9C1h0rQNOLSnqitQFdr5xt0Pt4mcEhTypXt/TfqLLVpaQYLun3c6IQw1bEO8aophCdSIc3LKhj0K5LyG6GEnv9MzwqBSUw0cT8UPdKKglaTJagM2HH2fC2bamQzlFPYDKs9BINcqLdOW73Zg2oyyuS26w7Z+U9Url+tCSu0y+yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=lunn.ch smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOsLc1RRGj7Cx25GUugndgTuCBtowFqMXO3cEi6jm4o=;
 b=HL/9SsE/dj6vXnktnNZI4ldeIDifetY28DVRkukh7Op3gkz62ICNNzKvJ1AVVDRl7CVN5BlfTcm6InrEEdaHOk7DmRL4SSqBIBiSmWw1YqwW0FJrqmSmvIv8FoFceDSDwjdf4aswRaxoCnQAezRk2xqq6JMUEZn06eiTobBFJEc=
Received: from DB7PR02CA0001.eurprd02.prod.outlook.com (2603:10a6:10:52::14)
 by GVXPR07MB10219.eurprd07.prod.outlook.com (2603:10a6:150:223::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Wed, 3 Jul
 2024 14:57:37 +0000
Received: from DU2PEPF00028D11.eurprd03.prod.outlook.com
 (2603:10a6:10:52:cafe::1e) by DB7PR02CA0001.outlook.office365.com
 (2603:10a6:10:52::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25 via Frontend
 Transport; Wed, 3 Jul 2024 14:57:37 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DU2PEPF00028D11.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.18 via Frontend Transport; Wed, 3 Jul 2024 14:57:36 +0000
Received: from N9W6SW14.arri.de (10.30.4.245) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Wed, 3 Jul
 2024 16:57:36 +0200
From: Christian Eggers <ceggers@arri.de>
To: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Juergen Beisert
	<jbe@pengutronix.de>, Stefan Roese <sr@denx.de>, Juergen Borleis
	<kernel@pengutronix.de>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Christian Eggers
	<ceggers@arri.de>
Subject: [PATCH net 2/2] dsa: lan9303: consistent naming for PHY address parameter
Date: Wed, 3 Jul 2024 16:57:18 +0200
Message-ID: <20240703145718.19951-2-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240703145718.19951-1-ceggers@arri.de>
References: <20240703145718.19951-1-ceggers@arri.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D11:EE_|GVXPR07MB10219:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eea6028-66b1-49c0-6637-08dc9b707a45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|34020700016|36860700013|921020|12100799063;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7Hy/1VsMxbJ1IsDT0V8cMK7vQ8O/jCvqI5PFXoBM8uYrDjdtsfYFfDXKDNAe?=
 =?us-ascii?Q?UBdYrrXPC1dK8/n7vu2EtO2cVMFakmeaCZJDlE39ZTTqChhLLyzIVTJsDgkM?=
 =?us-ascii?Q?j0/LJIwuG+x2KLc4RXHhptLjJfxxNnVKSRIXx+XlJxjttuMTrQl8H7bLof19?=
 =?us-ascii?Q?3bdMxIBcs0kpv3JdTPfTGlV5LnkcqUNePpD5b8sAfnVipuIq9Kf05QcMr1oP?=
 =?us-ascii?Q?YB8cvnLIbs4l5ZPweCw5JhWNpPE8drDnqyjo+3btS4c5Ca9SybaY0p17kH87?=
 =?us-ascii?Q?oAIWjH2CvIyd/pV98uTrNe1F0XK4h6y1xxLBfGoX/M8Nmes61mR2JXhMY+Ib?=
 =?us-ascii?Q?Asy2XHnpeUxGBX6jC9iRM0mMSwpaHroan7p7uEb4BLy+h1XmJhiEOC1o8G9k?=
 =?us-ascii?Q?3DvyQGu/H/bQWWZvgy13JySWFkrTC2mVWNi323Ri9kEqx1sfQcmn9mLGnTYy?=
 =?us-ascii?Q?xsGdauDLMuX/UxhX1dtq9n8dmFe571KXqtp4ryUAw7Nn2eEmHINrygEwZXE5?=
 =?us-ascii?Q?UErkGf1M5q/MFX+DI1+38HHDT/t37AvVD6Un+4zBS/DCB1VUWkJjIJQy4HzD?=
 =?us-ascii?Q?0Kr1ul+ckzSRB4H5C8NPzcoMO8svNe00Vjsa8RQUU1whIP1XTBK+rn+LUMbD?=
 =?us-ascii?Q?6ZbrBIg9MBeCcWRyCkzh+tBvwWk8n8zVTY5+3RNEGP2OOhDAsfsa+NQOgASY?=
 =?us-ascii?Q?emKV9orIMxjY91Hfj8zBoXpEcai7JDwSL60AMeaEIUTSWzuu+ykZiWKYmm5/?=
 =?us-ascii?Q?7LhUDNGA366A2m+8ZhwTCdLMAp7jq9vo1WkieyJ8z3bNl/4NpMtO1StoC6sP?=
 =?us-ascii?Q?Y8FI72AvcRRvGoOZyZQEpUG14A9rPQHYESZw4C+qW47obSSBFlJ9JEc29rbe?=
 =?us-ascii?Q?OWdORU8gA7+A6KD8aBsR604yWG4mMoZrGJc2rTvuVRJyGkFFBTVSMOCSp9LB?=
 =?us-ascii?Q?3f0QP6MaWHc5lk2GEgHCbA/FB/7uJSt8j5CMHJWJPwy78icYSa6A5jN3HyoW?=
 =?us-ascii?Q?+5Qomtvh0+5fm/SVA6sGSkbDjZwvapJeVw+0CW89PV8l2r4NdL0T+0dD7m9j?=
 =?us-ascii?Q?k70tM/DXyzhBheEoyfCSzJSbugFeITtYoiRveO/DFaqEMmJ65YTC+kvL+wBw?=
 =?us-ascii?Q?WAISpBqTp/4n2aW9yDZFq6DM0pkVUOTzZY/lsNZkBNzluLhXulwwzjJZJzhp?=
 =?us-ascii?Q?Dk0FxQTBN7C3pJdDNaxmprjofFfC8+36xeO6y5vtKE4hFs63GCStg74XjyC3?=
 =?us-ascii?Q?fkCdb+78lRITnobXmM72Hcx1AJQ/dpEpTn3ZbHgave7FHIM+Ay5Ab76cE2EH?=
 =?us-ascii?Q?t1wew9ITnM5WIF1FkK33uJMLXVvM5M4OpBprxrVe4x192z13W3x5tkzzZLjm?=
 =?us-ascii?Q?ADCPDGfFQrsM0w0jGCtAYGWVFGEnez7Nv04iCB/37S2ZMnWInluadGj6QwRq?=
 =?us-ascii?Q?EJg+bpX4RrPNJ1qzbdp0tkTrBsoznH4N4Tl+QBnr1zRJ6Cr6GmfF+A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(34020700016)(36860700013)(921020)(12100799063);DIR:OUT;SFP:1501;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 14:57:36.9153
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eea6028-66b1-49c0-6637-08dc9b707a45
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D11.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR07MB10219

Name it 'addr' instead of 'port' or 'phy'.

Signed-off-by: Christian Eggers <ceggers@arri.de>
---
 drivers/net/dsa/lan9303_mdio.c | 8 ++++----
 include/linux/dsa/lan9303.h    | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/lan9303_mdio.c b/drivers/net/dsa/lan9303_mdio.c
index 167a86f39f27..0ac4857e5ee8 100644
--- a/drivers/net/dsa/lan9303_mdio.c
+++ b/drivers/net/dsa/lan9303_mdio.c
@@ -58,19 +58,19 @@ static int lan9303_mdio_read(void *ctx, uint32_t reg, uint32_t *val)
 	return 0;
 }
 
-static int lan9303_mdio_phy_write(struct lan9303 *chip, int phy, int reg,
+static int lan9303_mdio_phy_write(struct lan9303 *chip, int addr, int reg,
 				  u16 val)
 {
 	struct lan9303_mdio *sw_dev = dev_get_drvdata(chip->dev);
 
-	return mdiobus_write_nested(sw_dev->device->bus, phy, reg, val);
+	return mdiobus_write_nested(sw_dev->device->bus, addr, reg, val);
 }
 
-static int lan9303_mdio_phy_read(struct lan9303 *chip, int phy,  int reg)
+static int lan9303_mdio_phy_read(struct lan9303 *chip, int addr, int reg)
 {
 	struct lan9303_mdio *sw_dev = dev_get_drvdata(chip->dev);
 
-	return mdiobus_read_nested(sw_dev->device->bus, phy, reg);
+	return mdiobus_read_nested(sw_dev->device->bus, addr, reg);
 }
 
 static const struct lan9303_phy_ops lan9303_mdio_phy_ops = {
diff --git a/include/linux/dsa/lan9303.h b/include/linux/dsa/lan9303.h
index b4f22112ba75..3ce7cbcc37a3 100644
--- a/include/linux/dsa/lan9303.h
+++ b/include/linux/dsa/lan9303.h
@@ -5,8 +5,8 @@ struct lan9303;
 
 struct lan9303_phy_ops {
 	/* PHY 1 and 2 access*/
-	int	(*phy_read)(struct lan9303 *chip, int port, int regnum);
-	int	(*phy_write)(struct lan9303 *chip, int port,
+	int	(*phy_read)(struct lan9303 *chip, int addr, int regnum);
+	int	(*phy_write)(struct lan9303 *chip, int addr,
 			     int regnum, u16 val);
 };
 
-- 
2.43.0


