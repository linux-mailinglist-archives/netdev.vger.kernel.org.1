Return-Path: <netdev+bounces-236212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E12FC39CC5
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 10:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 72A924E8811
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 09:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCD830BBAB;
	Thu,  6 Nov 2025 09:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AexFtvpc"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012046.outbound.protection.outlook.com [52.101.48.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540FF747F;
	Thu,  6 Nov 2025 09:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762421039; cv=fail; b=tBItlNJpon3+g4JIF5Ld+rB1to6n3j7dnH2MPnuxv+2jJ4gnIdF7iS9v0+ng0GMpxP/flYPtOP49Zo8OAj2EBJl4/3+9TKRiXk2qTgdsic0ZY2phERmxjzAricBtJLiIBzwIxvMVvxQXybqrQzi0WBJlqMISi1I5Onfk9K6SOd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762421039; c=relaxed/simple;
	bh=B08h3zaHq0jtX9DziXVpsZu3QNuEzNDX4p96hTpZlIQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GpfYA14tKuHvIRyOa7PNleZ5k6Pib+C0NIr6YRxkfplJW5o+lnUUCdP6q4FHwbh8s/sscFXEbudhSfkv74IP599T8BaGpx6YjJPxQIWQs22s+WSqfzTZpP68QY+T/XbJSTf6TN/NmtjpbHsQ8cn49yu20DhfPe1bFfwTAtvc500=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=AexFtvpc; arc=fail smtp.client-ip=52.101.48.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OL3O7UwzTYpHMdlkZx3kuaQiyjgNbmkHDyCEwOnBMqiGy3kOfomVo5Y3L5eGpmbmyfkI5fbF9c1zs21T4wETUCmOMKreP4jZEYmAY0IR7JXiomZ/l8xUm5Gj6UJAhnPgZWuw1YxOtEEFqoSR65Ja37/XISq04yyckH6VflgPf4dN6SHWLzWM7d5H0pYzRXKRu2/kYu2CI/3bXhTk9MG35Kzp7sfUaFu2iiHRAj7I5BlJ/VUPvmUYkeqmkfkXBqpHEL776e4wpOQiolfX+ko7dxke8r7Lx3npNvrLSHkhFGksXxXNNGcauf6/V5sKhn+w+E3yky6IBFVsUZcYeh9iFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJxPFmVECFRhNePdO7YOcBmEIKaCmQpzTvpGLTHJvoQ=;
 b=Ed+hy2mmnMoWUdG19brWQlKBXlgxSgqnetxneVkEjPGfaXH3lICkM/b0COT2Om+Dcq8jBpcsboVqky6yAZYJl3imdLiWJNokQZZaeja/2ggIlyOlKQPxkXeic8vKHwb8HD9HerYxneqzq9VVBJoWGPmodmaxAlGe2Xs1C4CQ9kLmcEiAg49WfsnU0zYFsmo4KKdLVMT1yJbTJaHPxM8E0Rgymr+sH+cVUpJk0qVljJt7qHYAHD6eSQI1BgnLp9N1StftA6tjeWzmAzcZHhxOZ+yhSGxYa529DkoApuqrlK5H7KKFA2BGkN0mXD+eY+Q8JDxRPZF6ejkcfehnHimoqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJxPFmVECFRhNePdO7YOcBmEIKaCmQpzTvpGLTHJvoQ=;
 b=AexFtvpcNyJcMuRY3lROS9M0ZXODMnCXmLHNWxWqwRDuEv7elrT2OAiQlqyKJcUb/qTMfSooT91AutAqAH/as5SOs1J0NXGogCffbOynDswmDX3x9SuzthqB/9o/tlouyzHGWuQ98ZvcEm8U1uG1gXyDI5XTFTzHGNXct1QmWEw=
Received: from PH7PR03CA0027.namprd03.prod.outlook.com (2603:10b6:510:339::14)
 by BY5PR10MB4289.namprd10.prod.outlook.com (2603:10b6:a03:20c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 09:23:55 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:510:339:cafe::8e) by PH7PR03CA0027.outlook.office365.com
 (2603:10b6:510:339::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Thu,
 6 Nov 2025 09:23:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 09:23:54 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 03:23:52 -0600
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 03:23:51 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 6 Nov 2025 03:23:51 -0600
Received: from a0507033-hp.dhcp.ti.com (a0507033-hp.dhcp.ti.com [172.24.231.225])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A69NXmn1034235;
	Thu, 6 Nov 2025 03:23:48 -0600
From: Aksh Garg <a-garg7@ti.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <edumazet@google.com>
CC: <linux-kernel@vger.kernel.org>, <c-vankar@ti.com>, <s-vadapalli@ti.com>,
	<danishanwar@ti.com>, Aksh Garg <a-garg7@ti.com>
Subject: [PATCH net 1/2] net: ethernet: ti: am65-cpsw-qos: fix IET verify/response timeout
Date: Thu, 6 Nov 2025 14:53:04 +0530
Message-ID: <20251106092305.1437347-2-a-garg7@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251106092305.1437347-1-a-garg7@ti.com>
References: <20251106092305.1437347-1-a-garg7@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|BY5PR10MB4289:EE_
X-MS-Office365-Filtering-Correlation-Id: 24997e6b-56c2-48ee-38b9-08de1d1634a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|34020700016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J3ua1K9XIJ+Td5miuNWkkXhEaWFJADeIGlUJrO3oJP1ZzrHbLPmeNttcaeq8?=
 =?us-ascii?Q?sS7aKeBiIAqHauvG+f5eag/HYvvoae2ZxP5zxTp4aVWot2c4K8qB3wXuvJid?=
 =?us-ascii?Q?W3cPZBd8ltWgh0sJmd33E4yaZGGdM3JzS8eYjXhGIzpqLx3Z7CGGkNyjQ8is?=
 =?us-ascii?Q?UMX5FdqHjnjnqrcX9Rr400Bx0X73RzwWtx1egK5OENBmKjNQM6gOWgE6u6d1?=
 =?us-ascii?Q?CqPv0PHx+OTGVG1G1sJr5xlFG9lpGwvlguiXtchcZp+gSlu6bbTdRYr75Ja5?=
 =?us-ascii?Q?f3aeWWUvFy3TiU7jkPGrDjsw0BvEaP7S6IBUEW13OfzkWkuvC2Ewnua1ocyd?=
 =?us-ascii?Q?OTIilCQip6lptH8VonHyL8P+GWwyP4aj+pURpeIrvwTVUpsOvfWyr+LP6czU?=
 =?us-ascii?Q?YjwnLH0CntX+6goNnU67WEyN9nKUFRMoczM+qU6i/Lkawpdt1iZON8rcfVwI?=
 =?us-ascii?Q?XPECuEBas29vDNLqzOB/E27sCn9UewaIVC5iBW170Vua2HS7WCXTzRoSD+JQ?=
 =?us-ascii?Q?ndyFbQybBwS0ax1S6q6D78AjtNA1epX72KMlgBWM5WPahhAWbGDIklO2JHS2?=
 =?us-ascii?Q?g/KJWuvYBTwvmUi3nzBCf5wPKqw4tlGGMOGYzwIlmRB+G2OcuEdT8QykiK33?=
 =?us-ascii?Q?0fvvyLCTQHOwHoNgwpUSOR2FTfdZlk8DGoUpykhPpPx6VQOld5F6vD7urQEG?=
 =?us-ascii?Q?Xd4nwNIq/9dDa6ebbGLFtqeIHdLB2OGAhPentimBDMvjRBSfWDzfl0bSHHQM?=
 =?us-ascii?Q?MIe+qUgS3W6hYhzsBTv35no3kl77Pxok3jD8bN7SdRqdLL5DvCl5J6RcU5D3?=
 =?us-ascii?Q?WkUOyQDrblKvrcSdV6EA2UmNyJzE9yd8jJ1LpywKrEXF+UyQulrADudaW1YN?=
 =?us-ascii?Q?N6Ol0qg8Qo4FnmP5558YN/nDNK9Kxd0PqVriGSSkUyhIucBzx+SdEEWit2io?=
 =?us-ascii?Q?MpDxotQf7CAiht9l/bvhS6I0Z1DCo1RPIoStrX/yr6gc8d/QUf+U2YE7o4KX?=
 =?us-ascii?Q?xQjVo+7I2HGDC5i67d9OR6fh/oUN4OFAkPJbCxdmhP+gKf9lOB6JmYUGZhhj?=
 =?us-ascii?Q?UIEI9HYeYji//dscfTSt6XvcYTQkCCi3GC5GGbBK385ZUanNcY3xsEtpl7Ge?=
 =?us-ascii?Q?FxNPwVT6Negkimd11qIOgIBpfQkN8DBNlTjK2FnTul1fc1gY5rEyPSceo6Hr?=
 =?us-ascii?Q?8VhsKDGmP81VBlAzZAu/3WOr4Fvq00Zdx53gRka16XGj+BnZDq0uf0y9ZkaW?=
 =?us-ascii?Q?a8OMDXOzhWYBfqssValyYCGOYuNzZAyj4zb7gSegPGoqojDMi/OxYSfsOHYB?=
 =?us-ascii?Q?GKtOOBTUd2xuReioj7x+83M1HH5/U/LWIFafzNnu5EIMYhJLy2w9Jq1wFvyh?=
 =?us-ascii?Q?7h2URzsMUCW7kiLqAp0ZspoAV1NYeBJMO9/gyC/PyqaBLqPGBJFsYha9ucPq?=
 =?us-ascii?Q?tGDmXtfGRGPFKF8HkFyyfMgYWOlvVDZgKjNZSgfzgfv0HxhqqXm118dQPpOf?=
 =?us-ascii?Q?IavM91zCYb+STV6o9ITkeApLk4fpkUSV+Rh199RDyBSnoqPTE1JE2C08R+o7?=
 =?us-ascii?Q?hJsu6WoH4HthcdI8btA=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(34020700016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 09:23:54.2094
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24997e6b-56c2-48ee-38b9-08de1d1634a4
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4289

The CPSW module uses the MAC_VERIFY_CNT bit field in the
CPSW_PN_IET_VERIFY_REG_k register to set the verify/response timeout
count. This register specifies the number of clock cycles to wait before
resending a verify packet if the verification fails.

The verify/response timeout count, as being set by the function
am65_cpsw_iet_set_verify_timeout_count() is hardcoded for 125MHz
clock frequency, which varies based on PHY mode and link speed.

The respective clock frequencies are as follows:
- RGMII mode:
  * 1000 Mbps: 125 MHz
  * 100 Mbps: 25 MHz
  * 10 Mbps: 2.5 MHz
- QSGMII/SGMII mode: 125 MHz (all speeds)

Fix this by adding logic to calculate the correct timeout counts
based on the actual PHY interface mode and link speed.

Fixes: 49a2eb9068246 ("net: ethernet: ti: am65-cpsw-qos: Add Frame Preemption MAC Merge support")
Signed-off-by: Aksh Garg <a-garg7@ti.com>
---
 drivers/net/ethernet/ti/am65-cpsw-qos.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-qos.c b/drivers/net/ethernet/ti/am65-cpsw-qos.c
index fa96db7c1a13..ff68a56796a7 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-qos.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-qos.c
@@ -276,9 +276,31 @@ static int am65_cpsw_iet_set_verify_timeout_count(struct am65_cpsw_port *port)
 	/* The number of wireside clocks contained in the verify
 	 * timeout counter. The default is 0x1312d0
 	 * (10ms at 125Mhz in 1G mode).
+	 * The frequency of the clock depends on the link speed
+	 * and the PHY interface.
 	 */
-	val = 125 * HZ_PER_MHZ;	/* assuming 125MHz wireside clock */
+	switch (port->slave.phy_if) {
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		if (port->qos.link_speed == SPEED_1000)
+			val = 125 * HZ_PER_MHZ;	/* 125 MHz at 1000Mbps*/
+		else if (port->qos.link_speed == SPEED_100)
+			val = 25 * HZ_PER_MHZ;	/* 25 MHz at 100Mbps*/
+		else
+			val = (25 * HZ_PER_MHZ) / 10;	/* 2.5 MHz at 10Mbps*/
+		break;
+
+	case PHY_INTERFACE_MODE_QSGMII:
+	case PHY_INTERFACE_MODE_SGMII:
+		val = 125 * HZ_PER_MHZ;	/* 125 MHz */
+		break;
 
+	default:
+		netdev_err(port->ndev, "selected mode does not supported IET\n");
+		return -EOPNOTSUPP;
+	}
 	val /= MILLIHZ_PER_HZ;		/* count per ms timeout */
 	val *= verify_time_ms;		/* count for timeout ms */
 
-- 
2.34.1


