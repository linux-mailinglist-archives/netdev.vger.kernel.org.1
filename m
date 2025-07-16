Return-Path: <netdev+bounces-207390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75025B06F7F
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 09:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F192D4A316C
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 07:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6887529186F;
	Wed, 16 Jul 2025 07:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ONJnJOKP"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011020.outbound.protection.outlook.com [52.101.70.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513E72980BF;
	Wed, 16 Jul 2025 07:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752652293; cv=fail; b=WQLar/ONwDI8KPRiMoxJ+T4VcCwMIx5ADR5uYsMo8itaSzAuRWbuf2XrBWRiwSrJo4QxzVZ51J6oW9xmm5IXKWTPPI+PIk6yOaZFZqeUoRGevmrLsk0q5VW3s1iL0KNxgsLt55/Iw9pT2/RLIw9RiA0U1Ck1uCH+m/dTHuNffQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752652293; c=relaxed/simple;
	bh=O+32xjP04IbY3BJUlkNZMcsEBLKGqQ/eT43n6u4Wh6E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pvqHKjPJ+inaOsoUH/9BgbUs/Djsx0S4C8UYVG9fE/fL1hmFWGjxwcJAtLy2DDNVfXejGJhiDiI9uglwm88fh2o+QXzlZbpLKKKm2jRTdt9mszEE7ZdcHKkM/qFwhSJmodgwdJ9xDzA9rLClUAuoUUys3lLI5BwcWAil53iVpBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ONJnJOKP; arc=fail smtp.client-ip=52.101.70.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B+qJ6jTAow4Un3kth9/2LrbBhU6/CvSxRfyS6MVGoZhfD0IvXOLaft1fJPYlZ4E+9TZ45zBrK8J0vYXzjMBTMKDJ/wo/VWaXmZ0ob/li9xCCVq9W845zNgS3zy7xPw/+77wXpw0oiphio2lJFQDhZKOvwcZIkCVuBCZvEzyynhhh4UG7Qa5UahIY1nPLCVN6dOXNsp9L76DUnveck9HzDIBjZwUZ6lKqiziYIMHM9hpub/j0sd9S6E7W9WJs4odMSqBCeE3gYsfntBF9cov6mvS8R461vdXbjfwo29jW17s+JCGbY1AgtLF4sw+B5yYlwVuSzO6PC1T90mgKT+qYgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=227sehZKKcyXsubP871sSdIHH35VMxmJtpqvTVmvBik=;
 b=FVN+1W59QKdJYguOu6GSHf+NC+nbahGh6IfY01zQ4tQOP7BkvhUJG67AgTAilovlWWJ/Dp7TucsWAr0bZSx5yzT33kEUZruSAftdCiMAEqxOL0NtT9QfwRH5ndOfIarGlufbYaf/N+k31MX58nH7XaONtnC86tS8OUgIr+Gif4ewTxUEGoEjladakXh+iBrYnkNa5ZLto6kqN+ZBwnLf7ZWRmYWmPm9rg1svKTL6+5yzbiqgzYRDpzKguFUI3NE+yID0f73bMEnM62cOBVr9Sivmvsf1IpPZ25gX3yDlKuKqeE6PO4nIxq5Rz6lLhH6yAuqrsZLE+mrSK3xPFHRdGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=227sehZKKcyXsubP871sSdIHH35VMxmJtpqvTVmvBik=;
 b=ONJnJOKPRkuKhYrOCYO2EvnEhUDBqvBrWh5QGGfN2Uv8/geaWrB1+L6vwp7HYjOtbNwtMZjBl87xJtyOFGmwI7BkHi6hT9xiYxGQIC+xj+blOxA/Y6zmH3XmH9GlJZaiNOQWpahYoyquYIkeua0jWanPSC/4o8eEQj79ubinVFfPGblWWuCH5JIlGUXxyy3yfxeMlUNkRRM31u8wm2ZSHIcrbqZS5i9nJ0q1GCTItLd+563YurhIG1eAu8wRQbuTvUHQOKCcWP/C/sa+V9qfzM/xwPgqw2RJZmEToOi5dHMZ5P/6FiOrJJj1ak4wQGIrbf3MZqWZwfX7X274sFivQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBBPR04MB7708.eurprd04.prod.outlook.com (2603:10a6:10:20d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 07:51:26 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 07:51:26 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	richardcochran@gmail.com,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	Frank.Li@nxp.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH v2 net-next 04/14] ptp: netc: add PTP_CLK_REQ_PPS support
Date: Wed, 16 Jul 2025 15:31:01 +0800
Message-Id: <20250716073111.367382-5-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250716073111.367382-1-wei.fang@nxp.com>
References: <20250716073111.367382-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0P287CA0004.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::14) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DBBPR04MB7708:EE_
X-MS-Office365-Filtering-Correlation-Id: e47a23e4-16be-48ac-3e23-08ddc43d910b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|7416014|52116014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yjneIy/c6810s+BOTFFNxpCk+p4hilZC2oofXyqfDtg/DhPbFlhMCs3+ACIR?=
 =?us-ascii?Q?ngN6KgYaecm7OxoCry6HyTu/7LF9fg1maVmlikYuUHIOUH/syuOB6VV2STJi?=
 =?us-ascii?Q?YAMmFQtfmQR63//olWRmtVWW/bHIDcrFU9+umvbGlovzA3kBy/JdHCjEMh1f?=
 =?us-ascii?Q?XRcE2Hr5wUDHxU+KWnUvodb48W59mlr92aVzrJC2PdwpANuWHRbTNIXfpqxo?=
 =?us-ascii?Q?G37dB5WwUZ7c1kcq0ZFfg6IlBrDN9jug6nz3aCmwAFJajkzaOlqU1XmcRwtb?=
 =?us-ascii?Q?IGcmGNzvkAi5RykDLK8wrDeGP9PEM0CCju1oUMR5yW8ozN2rUKMSvSSVX/HS?=
 =?us-ascii?Q?6q/lE/v4hnsTUiA6so+VYk9nFnE8oPZ7Ea7HlfvR7xl38J+lqrudfTPQLelD?=
 =?us-ascii?Q?If/3PAGOQosgrlW6Ow2kh+cfK2IXwdo0ux5eHPBfBU9v7+wc1wH+G7NkFmaF?=
 =?us-ascii?Q?IBMmIV40uklFCRIoshAwPCVJCadgM7G3+08zWsaMvlbQTI8Tryc0keBHvh/G?=
 =?us-ascii?Q?dYU+ssD2aQq76hAoCqbWDWSLTOHmjZlWBMudRfeF8P2SifpAJMY/2spUWIA2?=
 =?us-ascii?Q?TyJxPPvFYVOrz8bbRcXBji8Ctkh3ae4WCueneVBZB0gHccrGjve3/PQgb4To?=
 =?us-ascii?Q?9TDIOe4qn3z2ioCX6anOY132DpDVruYhiTb63eeg8qZ+nXUeE3HasvSoLy9b?=
 =?us-ascii?Q?s5zRqAZcQbh7Bqw2sLFxg4X8X7vsZTS02lKF2P1WGsj+dUSMx0mHbIyKfSSu?=
 =?us-ascii?Q?vUrter2/h+zSoVucZyAE3p0+reh3nA//9+JNVJfS+UWj7xJwzBsO3BlMf28p?=
 =?us-ascii?Q?8KzN01EgPzPTy/OLA2uo4OeTmVJ775hj3/Ya3AhOilXliwJpmThXl4bQ0FbT?=
 =?us-ascii?Q?jkiPPo2L5frGdSVGIPMcdZL3l5CPJjQdQlwvVi1DXV6IA+4FXXVSNd+QnLfM?=
 =?us-ascii?Q?lJMd6C2jX/FKv5Lw7DtwX1Xquyn0lEy3jG8O1Rgi0F5GY5Qt58TlRCd5jD8I?=
 =?us-ascii?Q?cQRPrvLkSOd6PEWxiNFSY1Atswo7Ieet3a6uOZOSj+/Vy/UpqQWdU3JYLZnU?=
 =?us-ascii?Q?3N0BwT3i27AuyIOBaxEyNpZztrZTw/QTMTtKVlV6uvb2HV59yrS1Nnw4f1tg?=
 =?us-ascii?Q?8fc0odCeMX9/kY0BzXb7drwQL6+nI5us7oLxSVZuBVzS3nKr58XZZOxQ4qHg?=
 =?us-ascii?Q?E9E7MkAJ7cdhkTqBIMEDZwCJ7KMUcGXuvlnKKfCwSCOYRP2KYcRmF1Y6EF82?=
 =?us-ascii?Q?N/Hn9J8gWose7cVcSw7V/fQ5M51Fi15gf+BsCwDImLpbWUo3BjkyTlxZzFuO?=
 =?us-ascii?Q?yU1NP4JOmXwv0zAnaku6dFpCiRQcG0uoSzrKitzK6Ek9N4gnGwFmc1mE7bJC?=
 =?us-ascii?Q?xnFetekcFM1Rp10BAANoECQhYd9PuNcRDDowQRbaXErFT5me3BVuGCj51oHE?=
 =?us-ascii?Q?qLFmJorRU6/hjt2hwu41gKHBr7vP5Y2nSuLF58JvM4p3/qmUu/J6rJ9D7LPC?=
 =?us-ascii?Q?gMZQ2e2FdQIIPs0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v6s4uh+4fYizyEC16pKwn74zxLmimmEWzIseblYLKj9INoRMo9uBScm7iosj?=
 =?us-ascii?Q?gANo+BjEXWr1ioDFQ9gI/FbbH9QkD2HZGjLYokExSP7puRUH5ZVb/jkEcvUm?=
 =?us-ascii?Q?4pVTfwglILIBpxlOEW7Mo4Pi+vSSOY+fI9Dz52uWP7mXFGA1t1bVW+UMwB3g?=
 =?us-ascii?Q?WAKZyupLy4/QEqXgIQS9DGobLYr6lEhHW38j8XKiAq7EVheQ+IN3xUqktJfm?=
 =?us-ascii?Q?zcdV1/To2seOpIX9AY1Jye52ZqXcGS1GXjCiAGGiZLR2LePZDgQj2lVBP25N?=
 =?us-ascii?Q?jwBnceLxnQ/w5sPygkHjQiUHoUbQqMCPRWXLDdlzZqJPJ9iqdTOOS+h1M7Cg?=
 =?us-ascii?Q?qMYmFWxLW8EYHODv4oi1ayBvPaNuRgVN6xlmDiKrl6EzlX+XCiAAMSWtWhkN?=
 =?us-ascii?Q?+9JQyFgadj0StKKhrinRJn5TAv/hgtBqylgO5yRj6JX+tBA0pD85bHnnT9OD?=
 =?us-ascii?Q?Qq3cYdzZT/eP1D0DvWy42CIZrUgBAvh0C+ExWtB5pV5ZAPS7/7QeXdiGpEbu?=
 =?us-ascii?Q?VwhzYQlh2Yakke3cmecxqkQiOocrmD+wXC1i1ISUtvxCj+SzOsiXIHorSrac?=
 =?us-ascii?Q?QepDYlo+Jb4IMqtucNuTGpl1NsxR0BX2ycCOJTG61ZQunKhaSGcZcsUFXfEp?=
 =?us-ascii?Q?LYNHlQdKxJA57Gh5+Xqs6tzwYCS8N4VrXy9JSQbGQN1gem87xYLsdP+4C7G2?=
 =?us-ascii?Q?SzHRjfxPW4M4lAPvxNO8nCibhUeANsht9bJNzZC4bA3LGiXiKEqPuW2P9S2Q?=
 =?us-ascii?Q?YI+xxyZgdAlvBavQ0wPSp9FKrBSzA25A/5MT3WWCgjnZBXU8lajTK+ZjjWUv?=
 =?us-ascii?Q?7gmJ7fxmC2jgJnPPdg7P+1/k+7hGME+owkwGlOaBZ0/1/oegBXchvU/6q3cM?=
 =?us-ascii?Q?gpq6r4HetIJA+l1U9GMVx+mBusmvzKZa1/OIEv0GLgHK5l7p1FcbkuR5YMCG?=
 =?us-ascii?Q?BB2fn5b76n4flDidweWF4k9d3W/Wa6lEVsaVUl94OnC6lOu+uIF07R8LlluL?=
 =?us-ascii?Q?MrMWyLwUxrcdMqv+KwbwQv8ud40eBJHKzHvjID694ZeGP+MG6NLC9XZzWU08?=
 =?us-ascii?Q?LLeDnaxwEveTecRtOGazvbBd8QlAqSFOSmeMXtkTL2librxzs9YMHK9hjZxr?=
 =?us-ascii?Q?NpFcVGT+nQy9PaXYzi7z8i1S1UcGRBP0c7FZwIqOvIHsBm5POc3DFetCoiRv?=
 =?us-ascii?Q?yMxelVUfNYjbI9vtXFAEmyTx2iAV6SVuCQj9re18OQrIUkvBR1nXqCheS7N9?=
 =?us-ascii?Q?WoYYJozMZjDaT3dxTUmhCBqHNm1xC6oYN2EKMxuEIjotBsnJDzxyOu0skgwz?=
 =?us-ascii?Q?ZT15RpxKk8ZOznUoE0JgcqLcZmg9Ssg8sLUaQxtmaKM27TJuP2h4jVooFlyj?=
 =?us-ascii?Q?qPZ169ncJk0sBv7o1BX/h0BtPM+0MMh+T1n+/vc1WSPM+T/FR9zkRES6Yf58?=
 =?us-ascii?Q?+79NQr4quZ3FqjnQt32BVxhdMjsjFbtQL7upyo56y5bivIPZMS2VvoTNlhUk?=
 =?us-ascii?Q?xczUlVzbwaP8dmS3SxEACjNdhvuMYCzWJoVHv0OjJ0vSb9lhWxH2wjp3RokD?=
 =?us-ascii?Q?Q2+dT8pZ9BWbkrjO66NUpmI69VzXkaDcKaBPJT8K?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e47a23e4-16be-48ac-3e23-08ddc43d910b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 07:51:26.5776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZSkX8MmlbDFGBblfjvro4hwguck2Y62MsrVkMOwphpV3POpZsBzT+7IDrr2lnhn/+NXdytkHIVJuPCOzmcnsOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7708

The NETC Times is able to generate the PPS event, so add PTP_CLK_REQ_PPS
support. In addition, if there is a time drift when PPS is enabled, the
PPS event will not be generated at an integral second of PHC. Based on
the suggestion from IP team, FIPER should be disabled before adjusting
the hardware time and then rearm ALARM after the time adjustment to make
the next PPS event be generated at an integral second of PHC. Finally,
re-enable FIPER.

Signed-off-by: Wei Fang <wei.fang@nxp.com>

---
v2 changes:
1. Refine the subject and the commit message
2. Add a comment to netc_timer_enable_pps()
3. Remove the "nxp,pps-channel" logic from the driver
---
 drivers/ptp/ptp_netc.c | 176 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 175 insertions(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
index 82cb1e6a0fe9..e39605c5b73b 100644
--- a/drivers/ptp/ptp_netc.c
+++ b/drivers/ptp/ptp_netc.c
@@ -24,6 +24,8 @@
 #define  TMR_ALARM1P			BIT(31)
 
 #define NETC_TMR_TEVENT			0x0084
+#define  TMR_TEVNET_PPEN(i)		BIT(7 - (i))
+#define  TMR_TEVENT_PPEN_ALL		GENMASK(7, 5)
 #define  TMR_TEVENT_ALM1EN		BIT(16)
 #define  TMR_TEVENT_ALM2EN		BIT(17)
 
@@ -39,9 +41,15 @@
 #define NETC_TMR_ALARM_L(i)		(0x00b8 + (i) * 8)
 #define NETC_TMR_ALARM_H(i)		(0x00bc + (i) * 8)
 
+/* i = 0, 1, 2. i indicates the index of TMR_FIPER. */
+#define NETC_TMR_FIPER(i)		(0x00d0 + (i) * 4)
+
 #define NETC_TMR_FIPER_CTRL		0x00dc
 #define  FIPER_CTRL_DIS(i)		(BIT(7) << (i) * 8)
 #define  FIPER_CTRL_PG(i)		(BIT(6) << (i) * 8)
+#define  FIPER_CTRL_FS_ALARM(i)		(BIT(5) << (i) * 8)
+#define  FIPER_CTRL_PW(i)		(GENMASK(4, 0) << (i) * 8)
+#define  FIPER_CTRL_SET_PW(i, v)	(((v) & GENMASK(4, 0)) << 8 * (i))
 
 #define NETC_TMR_CUR_TIME_L		0x00f0
 #define NETC_TMR_CUR_TIME_H		0x00f4
@@ -51,6 +59,9 @@
 #define NETC_TMR_FIPER_NUM		3
 #define NETC_TMR_DEFAULT_PRSC		2
 #define NETC_TMR_DEFAULT_ALARM		GENMASK_ULL(63, 0)
+#define NETC_TMR_DEFAULT_PPS_CHANNEL	0
+#define NETC_TMR_DEFAULT_FIPER		GENMASK(31, 0)
+#define NETC_TMR_FIPER_MAX_PW		GENMASK(4, 0)
 
 /* 1588 timer reference clock source select */
 #define NETC_TMR_CCM_TIMER1		0 /* enet_timer1_clk_root, from CCM */
@@ -75,6 +86,8 @@ struct netc_timer {
 	u64 period;
 
 	int irq;
+	u8 pps_channel;
+	bool pps_enabled;
 };
 
 #define netc_timer_rd(p, o)		netc_read((p)->base + (o))
@@ -152,6 +165,147 @@ static void netc_timer_alarm_write(struct netc_timer *priv,
 	netc_timer_wr(priv, NETC_TMR_ALARM_H(index), alarm_h);
 }
 
+static u32 netc_timer_get_integral_period(struct netc_timer *priv)
+{
+	u32 tmr_ctrl, integral_period;
+
+	tmr_ctrl = netc_timer_rd(priv, NETC_TMR_CTRL);
+	integral_period = FIELD_GET(TMR_CTRL_TCLK_PERIOD, tmr_ctrl);
+
+	return integral_period;
+}
+
+static u32 netc_timer_calculate_fiper_pw(struct netc_timer *priv,
+					 u32 fiper)
+{
+	u64 divisor, pulse_width;
+
+	/* Set the FIPER pulse width to half FIPER interval by default.
+	 * pulse_width = (fiper / 2) / TMR_GCLK_period,
+	 * TMR_GCLK_period = NSEC_PER_SEC / TMR_GCLK_freq,
+	 * TMR_GCLK_freq = (clk_freq / oclk_prsc) Hz,
+	 * so pulse_width = fiper * clk_freq / (2 * NSEC_PER_SEC * oclk_prsc).
+	 */
+	divisor = mul_u32_u32(2000000000U, priv->oclk_prsc);
+	pulse_width = div64_u64(mul_u32_u32(fiper, priv->clk_freq), divisor);
+
+	/* The FIPER_PW field only has 5 bits, need to update oclk_prsc */
+	if (pulse_width > NETC_TMR_FIPER_MAX_PW)
+		pulse_width = NETC_TMR_FIPER_MAX_PW;
+
+	return pulse_width;
+}
+
+static void netc_timer_set_pps_alarm(struct netc_timer *priv, int channel,
+				     u32 integral_period)
+{
+	u64 alarm;
+
+	/* Get the alarm value */
+	alarm = netc_timer_cur_time_read(priv) +  NSEC_PER_MSEC;
+	alarm = roundup_u64(alarm, NSEC_PER_SEC);
+	alarm = roundup_u64(alarm, integral_period);
+
+	netc_timer_alarm_write(priv, alarm, 0);
+}
+
+/* Note that users should not use this API to output PPS signal on
+ * external pins, because PTP_CLK_REQ_PPS trigger internal PPS event
+ * for input into kernel PPS subsystem. See:
+ * https://lore.kernel.org/r/20201117213826.18235-1-a.fatoum@pengutronix.de
+ */
+static int netc_timer_enable_pps(struct netc_timer *priv,
+				 struct ptp_clock_request *rq, int on)
+{
+	u32 tmr_emask, fiper, fiper_ctrl;
+	u8 channel = priv->pps_channel;
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	tmr_emask = netc_timer_rd(priv, NETC_TMR_TEMASK);
+	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
+
+	if (on) {
+		u32 integral_period, fiper_pw;
+
+		if (priv->pps_enabled)
+			goto unlock_spinlock;
+
+		integral_period = netc_timer_get_integral_period(priv);
+		fiper = NSEC_PER_SEC - integral_period;
+		fiper_pw = netc_timer_calculate_fiper_pw(priv, fiper);
+		fiper_ctrl &= ~(FIPER_CTRL_DIS(channel) | FIPER_CTRL_PW(channel) |
+				FIPER_CTRL_FS_ALARM(channel));
+		fiper_ctrl |= FIPER_CTRL_SET_PW(channel, fiper_pw);
+		tmr_emask |= TMR_TEVNET_PPEN(channel);
+		priv->pps_enabled = true;
+		netc_timer_set_pps_alarm(priv, channel, integral_period);
+	} else {
+		if (!priv->pps_enabled)
+			goto unlock_spinlock;
+
+		fiper = NETC_TMR_DEFAULT_FIPER;
+		tmr_emask &= ~TMR_TEVNET_PPEN(channel);
+		fiper_ctrl |= FIPER_CTRL_DIS(channel);
+		priv->pps_enabled = false;
+	}
+
+	netc_timer_wr(priv, NETC_TMR_TEMASK, tmr_emask);
+	netc_timer_wr(priv, NETC_TMR_FIPER(channel), fiper);
+	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
+
+unlock_spinlock:
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
+static void netc_timer_disable_pps_fiper(struct netc_timer *priv)
+{
+	u32 fiper = NETC_TMR_DEFAULT_FIPER;
+	u8 channel = priv->pps_channel;
+	u32 fiper_ctrl;
+
+	if (!priv->pps_enabled)
+		return;
+
+	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
+	fiper_ctrl |= FIPER_CTRL_DIS(channel);
+	netc_timer_wr(priv, NETC_TMR_FIPER(channel), fiper);
+	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
+}
+
+static void netc_timer_enable_pps_fiper(struct netc_timer *priv)
+{
+	u32 fiper_ctrl, integral_period, fiper;
+	u8 channel = priv->pps_channel;
+
+	if (!priv->pps_enabled)
+		return;
+
+	integral_period = netc_timer_get_integral_period(priv);
+	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
+	fiper_ctrl &= ~FIPER_CTRL_DIS(channel);
+	fiper = NSEC_PER_SEC - integral_period;
+	netc_timer_set_pps_alarm(priv, channel, integral_period);
+	netc_timer_wr(priv, NETC_TMR_FIPER(channel), fiper);
+	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
+}
+
+static int netc_timer_enable(struct ptp_clock_info *ptp,
+			     struct ptp_clock_request *rq, int on)
+{
+	struct netc_timer *priv = ptp_to_netc_timer(ptp);
+
+	switch (rq->type) {
+	case PTP_CLK_REQ_PPS:
+		return netc_timer_enable_pps(priv, rq, on);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static void netc_timer_adjust_period(struct netc_timer *priv, u64 period)
 {
 	u32 fractional_period = lower_32_bits(period);
@@ -164,8 +318,11 @@ static void netc_timer_adjust_period(struct netc_timer *priv, u64 period)
 	old_tmr_ctrl = netc_timer_rd(priv, NETC_TMR_CTRL);
 	tmr_ctrl = u32_replace_bits(old_tmr_ctrl, integral_period,
 				    TMR_CTRL_TCLK_PERIOD);
-	if (tmr_ctrl != old_tmr_ctrl)
+	if (tmr_ctrl != old_tmr_ctrl) {
+		netc_timer_disable_pps_fiper(priv);
 		netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
+		netc_timer_enable_pps_fiper(priv);
+	}
 
 	netc_timer_wr(priv, NETC_TMR_ADD, fractional_period);
 
@@ -191,6 +348,8 @@ static int netc_timer_adjtime(struct ptp_clock_info *ptp, s64 delta)
 
 	spin_lock_irqsave(&priv->lock, flags);
 
+	netc_timer_disable_pps_fiper(priv);
+
 	tmr_off = netc_timer_offset_read(priv);
 	if (delta < 0 && tmr_off < abs(delta)) {
 		delta += tmr_off;
@@ -205,6 +364,8 @@ static int netc_timer_adjtime(struct ptp_clock_info *ptp, s64 delta)
 		netc_timer_offset_write(priv, tmr_off);
 	}
 
+	netc_timer_enable_pps_fiper(priv);
+
 	spin_unlock_irqrestore(&priv->lock, flags);
 
 	return 0;
@@ -239,8 +400,12 @@ static int netc_timer_settime64(struct ptp_clock_info *ptp,
 	unsigned long flags;
 
 	spin_lock_irqsave(&priv->lock, flags);
+
+	netc_timer_disable_pps_fiper(priv);
 	netc_timer_offset_write(priv, 0);
 	netc_timer_cnt_write(priv, ns);
+	netc_timer_enable_pps_fiper(priv);
+
 	spin_unlock_irqrestore(&priv->lock, flags);
 
 	return 0;
@@ -267,10 +432,12 @@ static const struct ptp_clock_info netc_timer_ptp_caps = {
 	.max_adj	= 500000000,
 	.n_alarm	= 2,
 	.n_pins		= 0,
+	.pps		= 1,
 	.adjfine	= netc_timer_adjfine,
 	.adjtime	= netc_timer_adjtime,
 	.gettimex64	= netc_timer_gettimex64,
 	.settime64	= netc_timer_settime64,
+	.enable		= netc_timer_enable,
 };
 
 static void netc_timer_init(struct netc_timer *priv)
@@ -429,6 +596,7 @@ static int netc_timer_parse_dt(struct netc_timer *priv)
 static irqreturn_t netc_timer_isr(int irq, void *data)
 {
 	struct netc_timer *priv = data;
+	struct ptp_clock_event event;
 	u32 tmr_event, tmr_emask;
 	unsigned long flags;
 
@@ -444,6 +612,11 @@ static irqreturn_t netc_timer_isr(int irq, void *data)
 	if (tmr_event & TMR_TEVENT_ALM2EN)
 		netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, 1);
 
+	if (tmr_event & TMR_TEVENT_PPEN_ALL) {
+		event.type = PTP_CLOCK_PPS;
+		ptp_clock_event(priv->clock, &event);
+	}
+
 	/* Clear interrupts status */
 	netc_timer_wr(priv, NETC_TMR_TEVENT, tmr_event);
 
@@ -506,6 +679,7 @@ static int netc_timer_probe(struct pci_dev *pdev,
 
 	priv->caps = netc_timer_ptp_caps;
 	priv->oclk_prsc = NETC_TMR_DEFAULT_PRSC;
+	priv->pps_channel = NETC_TMR_DEFAULT_PPS_CHANNEL;
 	priv->phc_index = -1; /* initialize it as an invalid index */
 	spin_lock_init(&priv->lock);
 
-- 
2.34.1


