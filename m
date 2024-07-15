Return-Path: <netdev+bounces-111477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F76A931448
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 14:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC6D21F21C76
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 12:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FBB188CDE;
	Mon, 15 Jul 2024 12:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="GHlNdB8k"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A5313BAC2;
	Mon, 15 Jul 2024 12:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721046749; cv=fail; b=lECiNqKtQh3qArFYWOswuE0/N0E9dMH+lxe/ZPaV+fmxXTUt25Eikpjk45UdJTb+KNzcHReAFQnTb0HAQdzOBmPC1ZQBK+J9s3Fn3bqzXjKdClGoH3g9FCSSRncYwu2LFEZVRT2SeWDEGFr0m5HVbljHOS9tVR6SdTVoh6zE9fo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721046749; c=relaxed/simple;
	bh=1xoBAkrdIgUmj9FBWp+qKZdOPtOuNx12WQIpIeoIhKI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tn5j2Cfz+RNdgsKCHgUuKbuc4hux//vwDgTk7ZunlyVINPAprRMU3CreVATgd6Xxa3Idgfs3DX5QR4G74Dx2vkSnrV+m4WKfYv7vP0+Dy/RfgcaTcDNWXBP2nC3fKBkejXeYnQ6CkrSq+aMUPyaoPl/q/EecqJTy/sXNDFg3QUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=GHlNdB8k; arc=fail smtp.client-ip=40.107.21.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vTjyQebuUjXSd4LlyMi2xG7z8BRevtdPlQBX5w0b/K9T7e/kEQkHGbrLOHbqCEtZzD5TK33WSS1b/Sb1TeHZYBQU8lBZPyRXOyxrCYncwtU9FtnWoei6PE8W3beiRivttHF7h2YiPdPeFYBEHR98gXQ6z6+ianLkLIyc4v2q4SvgEZA33E+62Nqnly6icU3IXJZncvtQsjAAyEPLVx9vinsNu4ASCzEBlj84VZRo1+gwClRN683kcu30PY/DWc5UdhlC4do7OO2wEfrC6utXZw8k2OuHkSbkRwjGO6LM9uu3d5GUMvYP9LbPOYc3GTAPhG5mT5S8FDwWTi75t5NLvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SOsLc1RRGj7Cx25GUugndgTuCBtowFqMXO3cEi6jm4o=;
 b=Ogm2YcpuYqSuKfFHWSljWtt5mOyzNba79qDmBUrkozHUJ9ebjkcqUSd7FxzNwA3CoTJGy3fJJF4nAGuTSVtGZKF26T9j5eJksxIh6MgYG50PlkGngfbQWhPmeOU/Ge4/+7FnP0prObEFDnYnLRnJx+2b43eLf+M6lDDAtRfp8OxdgEdbJZcpaF2MLzkM3gUABbgQh+I+N8mr7ZGkwnrN1YdesiSeG4X965B0gw7rPPK5rpYSmb5zsVJa+7y5rlL4IZrBD1zezKGfoyEmiiu87mQWZAhOGLRykVbXt0pPQxxCu69Dt3aTn7ekjy5LYkXi7bh25wzq/rKw1XboG4bCBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=lunn.ch smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOsLc1RRGj7Cx25GUugndgTuCBtowFqMXO3cEi6jm4o=;
 b=GHlNdB8kbqkMZRuRCAwDaQrbfxZlmRvB0n9E9xxJzt9zr46TKfO81Qrj5kn1XTWvQT2jZkksypwuPoY0LxqwtIZ/3CbfvYoBSFtXvfImmmIcXB8SXP7quSWuGK0sTqcmih4Pl8u9wW0ijAjojODEnSFOogXgpS0GIozEMGkmVTA=
Received: from AS9PR06CA0295.eurprd06.prod.outlook.com (2603:10a6:20b:45a::12)
 by PAVPR07MB9381.eurprd07.prod.outlook.com (2603:10a6:102:311::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.12; Mon, 15 Jul
 2024 12:32:19 +0000
Received: from AMS0EPF000001A6.eurprd05.prod.outlook.com
 (2603:10a6:20b:45a:cafe::25) by AS9PR06CA0295.outlook.office365.com
 (2603:10a6:20b:45a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28 via Frontend
 Transport; Mon, 15 Jul 2024 12:32:17 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AMS0EPF000001A6.mail.protection.outlook.com (10.167.16.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.11 via Frontend Transport; Mon, 15 Jul 2024 12:32:17 +0000
Received: from N9W6SW14.arri.de (10.30.4.252) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Mon, 15 Jul
 2024 14:32:17 +0200
From: Christian Eggers <ceggers@arri.de>
To: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Juergen Beisert
	<jbe@pengutronix.de>, Stefan Roese <sr@denx.de>, Juergen Borleis
	<kernel@pengutronix.de>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Christian Eggers
	<ceggers@arri.de>
Subject: [PATCH net-next] dsa: lan9303: consistent naming for PHY address parameter
Date: Mon, 15 Jul 2024 14:30:50 +0200
Message-ID: <20240715123050.21202-1-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A6:EE_|PAVPR07MB9381:EE_
X-MS-Office365-Filtering-Correlation-Id: f2fcf75e-5292-421a-6c3d-08dca4ca2a0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?niYBccpzrG9iURx/elVuSIBZqxH06tuosK7naNDH/dyqUsSZO4pBbGCiQu42?=
 =?us-ascii?Q?SvBLKMebijHGr7vfDziMHDmAedVLHYGG1WoxbjrBB4FPK9RZSOAs+2a+8x6B?=
 =?us-ascii?Q?71y4HDOr8L8EG99t+fTsRpvcvO1W1ctABt1IdxqACmsVTT22fkfLYw8pbRYH?=
 =?us-ascii?Q?23U+QJ/QB38oyplhAA3ZNPfxiC4DqArMFQ38ZFCZGWXDWMsKEsK4iT1n52Ck?=
 =?us-ascii?Q?yrAHeX6klOepOjVxJzWwK9vW2y1nIFb0+FkLWM0MiUC78r2tr6QaJLuO8crt?=
 =?us-ascii?Q?1nGasH9EgYuLE0I4ILH2lwpUQg2rVskRSI0DvM8UcPcZsbgOguq44aRAb99Y?=
 =?us-ascii?Q?1nLBaOzVmgMCI/JHX9Gzt+vtmDxrQNPQnXBBCnYjI+NfRzmAGArvK4MHjdQ7?=
 =?us-ascii?Q?TB0lj4lnlPCl0vBz7gzhA8FzzCXHL9tt9Wymy9oVBwOvPrGOraj3KlMSqFa8?=
 =?us-ascii?Q?F454x2xgF8IyWW7vH7j3PjD0dwEhVI0hBwZ26umAKSLG+S84K2R8v/8zyiFo?=
 =?us-ascii?Q?culFio7mVwv+/ep8zPpHRCZHxDaASRP3M1tMIEwRV+nvK+G8HBVnBdscP5zM?=
 =?us-ascii?Q?xCi7p/dR2Xsen2rDviTcbc83++Tm/WSVrXRV4OGKyoL19sqGrhZ1/8wKLMer?=
 =?us-ascii?Q?OHgN6NYRem/9nMW45vkzT78rLsJOKB+LCbRFpxZYoiAhvAdWuwPL7ZJwFdrk?=
 =?us-ascii?Q?64ICJ2IAXz0WYMYxqrLLoCplLaTSXBS+SPhLv3fc25nTLHHjM41TTzqxvh24?=
 =?us-ascii?Q?xQe5wSQb9Em3Vn1OLDlh615KNVQSvNEbRi2+YXrCviti7ilg4tNQTfEiFULN?=
 =?us-ascii?Q?m1I1b8qspzNHbfqL9j0a8mDCInaCXE7nGe7RZtueb1gErVZSgF6SGiQ4y/dS?=
 =?us-ascii?Q?hvvyEDFp062ut1SA9LbSfPmC4U+a00yv07e3eHsu74300C98k/DJ8FAz+wyG?=
 =?us-ascii?Q?7jAadVrasnFcneu/0ove+LYSx/1V3Ciyx2XuHP6HdYRM0Qm8zdKSwYpEFLn/?=
 =?us-ascii?Q?B6FygCYql3Qw+pS4nzbvLDB+GnEXNz5+Ol2CtWFN7mKQIQaI4Gq2We4KMeQm?=
 =?us-ascii?Q?PAbaIzO9W844Ipmt/1tcIXhxBYTHLfZwqpztotlOnmrOfXOIEDGLlpWyb1+u?=
 =?us-ascii?Q?h+3MOA5mOVFL4r+jDaVik201RYxdAwv/I7yqRsSXCUGBsE5VHZfzsOOhUtch?=
 =?us-ascii?Q?oWcX66N2nrwCp5Ay/u9gtDsoS/p2G4eZurbJTNiTSrTRejWPz2BeVUv6sjjB?=
 =?us-ascii?Q?qN6k1bKuRI9G7JogrG36ilgXcHpP7lEAddv8Gswf3Njs2cYqQqF/TOOu+50k?=
 =?us-ascii?Q?Y8KP2WBHnj+MuNDf6XXHoGvtnBmD0ibDhRPHGYXl+LUa+VN0v7UGSktPgYbi?=
 =?us-ascii?Q?4iQLNDJMoTaqvt41zgrqFvvSr1KcvNo3Rv5TWl/Tbjv41ubizfG8ztMgaki/?=
 =?us-ascii?Q?xIs33xeAiV4OnzH63RlMnZaFf/1QOaeHZL+RrsGIzHeSMrCqWAvFmA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 12:32:17.5039
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2fcf75e-5292-421a-6c3d-08dca4ca2a0b
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A6.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR07MB9381

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


