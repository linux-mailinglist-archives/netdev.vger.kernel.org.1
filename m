Return-Path: <netdev+bounces-235712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1B3C33F63
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 05:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ADD704F7AAF
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 04:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80309273D6C;
	Wed,  5 Nov 2025 04:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UH6hbVoe"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013012.outbound.protection.outlook.com [40.107.162.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C5D26FD9B;
	Wed,  5 Nov 2025 04:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762318580; cv=fail; b=ljNmUid7XAOoJ8cSz9tJoKGNQEri/1nTnGyJQ524GZx0FlBLgBVJonD0K23chKhdOxdiUPl+2oFKNHRWOn+T+87QQmJQwhJQkwdCd2dpcuzZk+qqIYQm09rRXzZdUMNWCToBGsessv9s8U9AixWPtk/RzlrIaAfRD3SBtE4v2EY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762318580; c=relaxed/simple;
	bh=9M1tojLEJ7Erc71J8JBkdIzuxXzVFD4wfrqYGtufZXY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NGVEj60x5zIWwjFHmFIZpP6B8Qoxd1n4qIHEmPuPG5YZ0Xb1AgcB/6CguHIk+ywUFTkm6w3rdFbSz1CkGEaRJPExuYB3xLRsDsWw7XEdO5QGyuTF9+80ND5tR0yLYNtQM5EP/TuhfR+nuNW9/SucUZQDGObRxO3DhGrs3uBEyss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UH6hbVoe; arc=fail smtp.client-ip=40.107.162.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=syHDTPbubCL+zi8MyKKxDrH/sgwnyyVtG9qsU/fBqkNrd1/KDaNe5soj5/IcIhtPG0c/OTkfxqkqJXrBB30BZHoqeS6FHxKWOQNRF0TXe0ir9gwJedphUbNSP72ymCs5378gLOfUv9LWAgkKkFdtESriPC98AaQVAzd5zB5xgKaiUC6k4kWegJ38r9tbD8KogdxbRVvoudTtHlAaJthl66cmczXoRE0YbYTwuZqObQM2aadKN3rx1o6JDnkxQ2+QcUh21mj4sCjMpKLy2ekTpWFqnYl50YB/lqAQVJ2AnZdnfp80jXt+fc9JjWgyQFWNKKSH3xS/1ASXPdgjkX/Q2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xkvX0IOkMDzIyZf8gPkDlkiy5MPQ+r32QmgXFZETU0o=;
 b=NdRD/CCjStlzdozUFtiNj83PG0vn8pke+rT7xjBehmRQoq7FBV6vZxewqsnGlDlr5sTNXpKA5L1H8XORApKi46YhSvFBXzYRFVylk8ysekzB/Tzgmq1BaukX2vPyCqzMKhX8W5n+Ef72AXB8XseOQF3YcVHNBYsbtt9oKntWy35gFhjoCToP9PUXvICMBkkEH05CgrDcTH4n5SQYU8+DQdL/nRhsJ19xkFBrUklDmDPIxr7r6ye+Mp0jEfMogdrEtsniL7im5wOwgItbUbLDWhH5PBWEs8RzfSH8cWoMqDZbwznYxKlCj4++bDMrhgx7cmiaqALq3s3Ig9p2c512fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xkvX0IOkMDzIyZf8gPkDlkiy5MPQ+r32QmgXFZETU0o=;
 b=UH6hbVoewEWSrlknnVUQI3NkLlUiTbM6C/BkyU4dGoL1NQntskXviIqdRUJAqpxIuPXmaRLzBwWEfYIiBxzEuclBK46pp8ZD+F2lWC2YsH+vckmQMQgEy6HSdt+mlghtKCJOkdgo5yTpNN+XnCVrNnfoAMl5QphC7z0FuZC6g7S0erlfjXsXoDj+6IPpnMsdcUp+p4O5tnfnxpj7sf9Wy1ywmhiYhf8xuXpEloaofQk2FUiTJsPpfFcdLgaD7SGMKTlZBV5AHNNxf9a/+tsrKPzvSV4EkEavs71qZ2RSY2cwgEveg2uNl8txi/GJL6m2PzfeukTutgC9DFVV85ASyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI0PR04MB12053.eurprd04.prod.outlook.com (2603:10a6:800:324::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 04:56:16 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9298.006; Wed, 5 Nov 2025
 04:56:16 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: aziz.sellami@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net-next 3/3] net: enetc: add port MDIO support for ENETC v4
Date: Wed,  5 Nov 2025 12:33:44 +0800
Message-Id: <20251105043344.677592-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251105043344.677592-1-wei.fang@nxp.com>
References: <20251105043344.677592-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0174.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1af::8) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VI0PR04MB12053:EE_
X-MS-Office365-Filtering-Correlation-Id: 41a3c08f-a1ac-4263-df75-08de1c27a6ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T8nUd5nyH8j3ZifcQyc/angVishnaXdHQCf6jMiLiopXHii6DuV39LfUV6gs?=
 =?us-ascii?Q?aVBG49VmLwbjdRufxJpdTsu6dmlBxsbobRUQZf80NN7NtOEyvfaAueosaoN2?=
 =?us-ascii?Q?x8uE+8VTvCWj686mvBLGSGnCDLwwGpVyx1vvdwroKqNgjAYfjV08fyRdLc8U?=
 =?us-ascii?Q?B8kB3/EUiksRBrZD86ecs+myIZfyfR77JFdxRc6C9aCaM7MHDn0Q0KEorRON?=
 =?us-ascii?Q?wHna5SYs28Iqu/GkuZfM9v8yYsftX1ZXuln/lJ9lKd62UVyVL4A2ho8+Ltzv?=
 =?us-ascii?Q?L7MQsTR8UbnAdqE2ZzwGsi3DIva6VhQZ32AnQ6Ym9jMCVX1E+3uRFNYDvfgu?=
 =?us-ascii?Q?4I293IVt4e5jHgYy4H9Ol5gcwm7HJJHmDVfCvZM3DwG5zQ+lLWKXyWjnCCb1?=
 =?us-ascii?Q?Qxjb+RwMbS+mHo4at417828M/fHKrJn9W4N6AkXonYedc+eiAMvcJSXo6Z+p?=
 =?us-ascii?Q?MvBQdyIzqKt1Cnj/Vl6vEQNcDOJKVoVQYNIYB2NSdKMF5OTNhcMa5L6wJYTR?=
 =?us-ascii?Q?MHcPiJ5aHOfZVzmNOh0Izzk9c2wIlvEuC0mSLCdiwxbWShHEnrFJuKPtAnnG?=
 =?us-ascii?Q?Vis7rpxT/qPIuTCHntRFbJON/N26ec0LQkm+3NJwNvHsjrhDFdUaKtkViXeB?=
 =?us-ascii?Q?dAor+nJXm7LL2TkJ7+oUNbN5UmFYTfHG0x+nSppdVtt7VsCxQkW7tbF5oior?=
 =?us-ascii?Q?s/baJARZfNqbwivqDZfc7KchW6/fze+cU1TCfAmgfstuBi4YKrDXo5X+wpta?=
 =?us-ascii?Q?YlbnJ/sAfB07PmKEyj2QjyGpOHWRlzynjYcWWdlDrPYD/iPDPoI4xyFXQiKA?=
 =?us-ascii?Q?nlJBy/w3kdPQklKuos7RGDOEYOmXzc8smBzhpbaS5BlEz1tOrV3/s9EdZpFU?=
 =?us-ascii?Q?jsQ0OiinBIyFVQgcuE+Aa9HKb36alKSBnJljneg+F+iYoOM0WZsv1i26jPi/?=
 =?us-ascii?Q?7hijsdOKlj3TarnEO5lhGK+X5eZgOOahu4iZIXbhKUSP+Brhm1RPjD5ALvlb?=
 =?us-ascii?Q?Ph+T2CU3MjxrSdSCNk24IAh5tkkg03ahu8cqf2d9rQDRJlO51I6Lx6Tb4WXA?=
 =?us-ascii?Q?30iq1hb/pvrGMZkmfWAQvVSjyazdlVSjiT+bG1fPCcAyzAabOyv7/fUGEP/a?=
 =?us-ascii?Q?MUw3f2+zBeCZfvwdVRxlmbbYDFk5OTBQmGxLlzeVq/+2ahcNLvwqteDrNoOv?=
 =?us-ascii?Q?ZHXAwX0k038uJS0tWO/Aclj5yYTIP0/mmgaFaqlu1l9HO34E6SwMsIw5tObq?=
 =?us-ascii?Q?Q9l2eK0s4zSEAwqGQIKd35VSUfdXESp0pDXyLqWiXv7528ENEcSvDiM33Td2?=
 =?us-ascii?Q?fPShoCCbH7m5/iP4kkTLylY3muFZ/DlmYh8pQa9MSqbv6+zSAtyuwu/IDxgJ?=
 =?us-ascii?Q?jrps11G9xhLKJBJbR9vEnJ01CAhrkbf9q1FFrI1NGT5V5iEytc49qQ2Aj0Ah?=
 =?us-ascii?Q?TIJirNnAYsvLXh1gIa+AOWwheNPc5GX5U/7jpuu0U7AuaqS3nmIeq/dh+SYq?=
 =?us-ascii?Q?ifM9GaIs4dnLrQ4ig6xlLBDaIufsNO0M+qKU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RksoRw7uPQV9jhGwsOdDtRoRSo0AeU4sT4fB1a9hTjobyyPZXDopyupPbVw+?=
 =?us-ascii?Q?5JQpXsUxgEY0GM0AwUOvKlJ0DGfvzyiF/BESems7ha5QCsPBUdOKN72u5fQ7?=
 =?us-ascii?Q?nsHOMfyYGjmdE/MYpWkIodG1oc9eVAuR2d0d/LyRqeK2Zuio7KdcntCzPOQK?=
 =?us-ascii?Q?k6fVTnLb+QgzSh81+K51O3FcsmrPQt4KSKH9Lgk9FeZCKLsPDAKeR/jxa1Iv?=
 =?us-ascii?Q?P4SbYCnuEKzTAR3iMAiIF1RkNgzouKpM63Qobmh6s/UyJijufgiJR0TsytIB?=
 =?us-ascii?Q?CqRVENLKSaN2tqMbi9BpvrttAOpsgedwHXSbyjSd3FtYxkQDjsOzRg+rPPjW?=
 =?us-ascii?Q?lmaWYtsQc1Z/RVayvTObDQS1TsClgqwicj1fgbEN2as67uCsmkXrp+FER8VR?=
 =?us-ascii?Q?PBQ+ZNSwUOj6/KcH8LB6RugeCUEEoSD/varU8NEiuNGEO3Ax33VaGdQ2JSlY?=
 =?us-ascii?Q?oP5SCngXaFjDZfpjrOhd+wZ+uUptqKm+XzPqyMsmWsUHBZCj2jNsi42IwXJy?=
 =?us-ascii?Q?wL1JNzOgAIZuv6suIHKZt7UdXd8CkmBpvszBlK7cC8H4jdJJgwdkqeAHV0+r?=
 =?us-ascii?Q?1nSlrVMnm3VN1EO2wbxz3be345JaH4Omh/bFpf6NkjPCuOJ3QHVx8PVOxvb5?=
 =?us-ascii?Q?LX0Ckv/AJuphAaDGh8tfjmTmMaVcNd2SxcQz0GvQGQmpdDIC8h95BovB0X4b?=
 =?us-ascii?Q?a0cHT/nuqz1eDETAIAWJmw/0kmSGdwM/igwqzYIzsXyens3+Gl09dKKco10O?=
 =?us-ascii?Q?8qip8FXht0am4WP3fm01sEENuRm83atNExreLv+OfgX0n7gcvZQNdxOXyPgu?=
 =?us-ascii?Q?Wh7MFf02cRBUNyDfsqrX5UbHl/CIVyyvp0sbKjljX7nurF1bMU/aGtC4rVX/?=
 =?us-ascii?Q?6jmccBuJq/EjlpJIzTCo4m5T31lqVGhrwjSyrCTa5Q0IVlElRY6MWEqtlePF?=
 =?us-ascii?Q?vWl4AOOAS3jqAIq6jWMBxEe08klo43wjkfkk5z9fOT7BDB2cgTO/MFnklzXp?=
 =?us-ascii?Q?XJ7lAeg4Wsl2LER961IIn+4hu749tKoMMe5wqyoN24gesTElG9ewJFi87kIy?=
 =?us-ascii?Q?HLhYk77+c5OmJka+RHkiTL/CdgrTI5CsoSNQ5HFs8s4ifmx2amTF522Gbt9U?=
 =?us-ascii?Q?6itXUK0p++QflF65XCvhNjkg14LTQrGL5UOou0UFL3W9hKnj/oBRDx+y8Rld?=
 =?us-ascii?Q?lo8Rol8KN1IflfW4H1Y61DcBqVVNC9TeL4jHYrUAMvZT0LZEx31IrAMAMt1g?=
 =?us-ascii?Q?9kqiEHzIb17HKGei4qRz9WWxqq7GqJKWbaNFIs784bS0O2ZeQEhK+/lj0LSC?=
 =?us-ascii?Q?fNfEyCpxLfSa+wPh2Ypjm1KUBcThFeFahMI5lccbrDsNtOa+eDQcBNJ5C7Nx?=
 =?us-ascii?Q?/rD5hbyGvhdgwsvgxz/WMQsyY6tUEn1KP2TsNSsSz2t4K+FnJw6Yg/fQ2LN7?=
 =?us-ascii?Q?RlTLwMd/yrDMgPxTa3rGkrRlsr4axx4U4iEX1eR9iF3Unvbcy6Kdnuwtppt8?=
 =?us-ascii?Q?mDLfeYdFZ7IGEFsQUD6NQ4bgGiLGpdOmNq5bi46wC8s0DmMKTdH36AUeH6kG?=
 =?us-ascii?Q?BNhCc2qWtb+ENyVAhRAzho5B+bm+5bH9WlWqnEaS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41a3c08f-a1ac-4263-df75-08de1c27a6ab
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 04:56:16.1176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6pajcaNS2DwdjBJD6a3PR+crw2CSeDztGDUckgt8hqQsIbzwuKghMnJY0jSKO6c3pyUV6zo6Y1kDcceczEjwNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12053

The NETC IP provides two ways for ENETC to access its external PHY. One
is that EMDIO function provides a means for different ENETCs to share a
single set of MDIO signals to access their PHYs. And this EMDIO support
has been added in the commit a52201fb9caa ("net: enetc: add i.MX95 EMDIO
support"). The other one is that each ENETC has a set of MDIO registers
to access and control its PHY. When the PHY node is a child node of the
ENETC node, the ENETC will use its port MDIO to access its external PHY.

For the on-die PHY (PCS/Serdes), each ENETC has an internal MDIO bus for
managing the on-die PHY, this internal MDIO bus is controlled by a set
of internal MDIO registers of the ENETC port.

Because the port MDIO support has been added to the driver for ENETC v1.
The difference between ENETC v4 and ENETC v1 is the base address of the
MDIO registers, so we only need to add the new base address to add the
port MDIO support for ENETC v4.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc4_hw.h   |  6 ++++++
 .../net/ethernet/freescale/enetc/enetc_pf_common.c | 14 ++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
index ebea4298791c..3ed0f7a02767 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
@@ -170,6 +170,9 @@
 /* Port MAC 0/1 Maximum Frame Length Register */
 #define ENETC4_PM_MAXFRM(mac)		(0x5014 + (mac) * 0x400)
 
+/* Port internal MDIO base address, use to access PCS */
+#define ENETC4_PM_IMDIO_BASE		0x5030
+
 /* Port MAC 0/1 Pause Quanta Register */
 #define ENETC4_PM_PAUSE_QUANTA(mac)	(0x5054 + (mac) * 0x400)
 
@@ -198,6 +201,9 @@
 #define   SSP_1G			2
 #define  PM_IF_MODE_ENA			BIT(15)
 
+/* Port external MDIO Base address, use to access off-chip PHY */
+#define ENETC4_EMDIO_BASE		0x5c00
+
 /**********************ENETC Pseudo MAC port registers************************/
 /* Port pseudo MAC receive octets counter (64-bit) */
 #define ENETC4_PPMROCR			0x5080
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 9c634205e2a7..76263b8566bb 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -176,7 +176,12 @@ static int enetc_mdio_probe(struct enetc_pf *pf, struct device_node *np)
 	bus->parent = dev;
 	mdio_priv = bus->priv;
 	mdio_priv->hw = &pf->si->hw;
-	mdio_priv->mdio_base = ENETC_EMDIO_BASE;
+
+	if (is_enetc_rev1(pf->si))
+		mdio_priv->mdio_base = ENETC_EMDIO_BASE;
+	else
+		mdio_priv->mdio_base = ENETC4_EMDIO_BASE;
+
 	snprintf(bus->id, MII_BUS_ID_SIZE, "%s", dev_name(dev));
 
 	err = of_mdiobus_register(bus, np);
@@ -221,7 +226,12 @@ static int enetc_imdio_create(struct enetc_pf *pf)
 	bus->phy_mask = ~0;
 	mdio_priv = bus->priv;
 	mdio_priv->hw = &pf->si->hw;
-	mdio_priv->mdio_base = ENETC_PM_IMDIO_BASE;
+
+	if (is_enetc_rev1(pf->si))
+		mdio_priv->mdio_base = ENETC_PM_IMDIO_BASE;
+	else
+		mdio_priv->mdio_base = ENETC4_PM_IMDIO_BASE;
+
 	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-imdio", dev_name(dev));
 
 	err = mdiobus_register(bus);
-- 
2.34.1


