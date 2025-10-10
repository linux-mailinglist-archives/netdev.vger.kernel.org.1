Return-Path: <netdev+bounces-228496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A4BBCC6F2
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 11:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89E191A6507A
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 09:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CEB2ED15A;
	Fri, 10 Oct 2025 09:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ejUQyV64"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012057.outbound.protection.outlook.com [52.101.66.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121202ECE9A;
	Fri, 10 Oct 2025 09:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760089758; cv=fail; b=CgLbx6w16t5532VC/JQVud1fgs6Rp5CdqIlbnWw2H9+F6BY3bJQcH+dr3KymjckupCqu8EwXhlEof3quqx/A4Nj4J4o49ddXZ1s2RkfPV1bxF1l8YqBB/qiGFmECnQhKB3zoH29oCDSP2t0aB1ILGKYV7c2W0ljyOkbLW/PuOl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760089758; c=relaxed/simple;
	bh=3MOMElqVaW1I+oCG3aAxf4Ajp4jh9RGcqOgCAGT/LBg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=aJ+c+oAJ0QAixCmhoGT2ohNQrULdkPg4CtGIfRdCkwQybI1kufqZyHHy8Z9xhpB6SJGGP33X5eM2U5lU48baIefnQJdOkmYLLTE4XNMcoANgmmqH0ObNmZazC1McVabITed4To9S7jbwL/f1p6EplsGrBSwd/lAy8dJWwUIDngk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ejUQyV64; arc=fail smtp.client-ip=52.101.66.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/SCWk8wZQHakYYuML4XXqOa9t4gcE/AjAhgm2IqXUN425DCHL7OVZqhq4a+GNHXZ49OMs4y1qqg7pQJype84mQoAViLKc9gI2VRNsSKpGbqS0xH0cG7HkEGaTGbjAMcKAmHVzMmKe9+/5kWaeXFOAk5FLfJME+cCgmmp7DNCyxiezstjl8ttZFRV+Ju6W25FjNIKGxXZxxH/Z0A/V7vh9Ycqb/7WKC8vEVUbfQwcE0TnGJ3BVr+Jf85m4o+NYwNrHxKS9y6XdC3lcANW0uUIR8G8YMQbIiud19HWrKYPClim3U5tv/AVqUi1bS4xxJyG3SElOhxCIAgcWv0Bepmtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vFb2socNW5tc9YdA+GnG+Lsne9GZZnFsiKOhmQXEIbA=;
 b=ayb8QFSTPb6OIpYXLS54WWn4L9vPcH27znwgxnLEWgU5PRUlER6s7utqwjwiOWr5dnTG0VhAqsbXsg+vHtXPsEUSxMkwmab0WGzY+mP7Pr5F3zLLNf0s5RUybPAqQ0FZCaXKnWQjvC4qykjANCKaUEDkd3DoJY6PjRcOnxnaChsz/nu0zqc8aTVwmcBZjuiC2daNTkDCC+ETInRpBHhcO3olHHdQRCWuDOBQMKg9upCRwuJYrxr3dVV1zFss47MYh+IiUPfUyE3wF4KPrSQ3F4OK/itYr8krvujXtLMZ4O1j1MbuiV+/WsUWEEcQSHmE4cBXdYCNdFMoDv/4cVi+bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFb2socNW5tc9YdA+GnG+Lsne9GZZnFsiKOhmQXEIbA=;
 b=ejUQyV64avqkMX2vQLqwsYwcgDFL92bMXxBQEqBJSMrDCrM1d9r/hJwQnTQD1Ot/tGcz/MY4/7+ibjoOelQI+f08DFxOY/j/lTqx1uUoX2Qcc2r1WLKkotoOYjPK4nOKl8+Cz+r/Cn4ltYwXLTKcQIX9HKAXScYz50lasw7NtGk9IpwlpIgyIZd0Xy3bjaBpzUwcvfbHeSoAbD4sPB1VGOih5lMoJkMkt1Ym2QgsQfkM6yJnm1cb+GiMt+zkr+qn+xEByjb7UAwwhcWt/KdmYqFRl44bhjCCObykoadjTa0JhZ6tCdmC3dYDBDV7ne+Qec1rFG/iTbHmfsGy00u96g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAWPR04MB9958.eurprd04.prod.outlook.com (2603:10a6:102:380::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 09:49:14 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 09:49:14 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Frank.Li@nxp.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: enetc: correct the value of ENETC_RXB_TRUESIZE
Date: Fri, 10 Oct 2025 17:26:08 +0800
Message-Id: <20251010092608.2520561-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0212.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ab::9) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PAWPR04MB9958:EE_
X-MS-Office365-Filtering-Correlation-Id: 9900df42-11d1-42a3-9dee-08de07e24527
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xONMyccmJnd0Ai3m945ZITmKJCVkAsf8OgxLGXDNYW46C+igx1N9Sl0QfBNc?=
 =?us-ascii?Q?MmABB1fvQUck/LT4Q31Yed8IwoKsLK60EDcKWIzq/41XUwjTFQceFYfgurav?=
 =?us-ascii?Q?U8Udz51M0mH7L2b9iuzN2TpzlNkWiKWf5eUYULXDLsjbdLY0yxzupkfDUz6D?=
 =?us-ascii?Q?L4n7F+rRnQqqzYvOmtL65WbUuldDB3bslThHHjib/a5H8Kan/tbsRU/NPkc5?=
 =?us-ascii?Q?pZqO2ZkpncrlihQwNViRLWOdF27iQuuMwZiC05+Fu1pN1cD6UosRlk+6kqTV?=
 =?us-ascii?Q?blk70tFBGg3CgOnsFEqd84MemRvVKIwbP53Z5nXdURK7L3iJ6jYVb7Wxm+hk?=
 =?us-ascii?Q?pmZnY6eFPiy5G2jhDyoK7X+4CJwb4TyjrabBH857LRSyIrST/QmmaB18+6Xa?=
 =?us-ascii?Q?2YChx+4f7XcQ6eEXTd8idnB0+A3yl9RPc/PVylwbsOtkTXI7GY8osZngn/2C?=
 =?us-ascii?Q?RZNSvZMdMKXlrwKtckpS6/UwrlE7hPkNWuilfCRs6kcd2nZUDCgAPK7uj0LO?=
 =?us-ascii?Q?uBeAIMCHM1gAxxKBXQCvrnLG9drw4MasX+hTcqVsMDDpjLu9h77tTkGFD14M?=
 =?us-ascii?Q?saQvKSp+CvlgN/OEbub3XP7UFq5bMUb52nPndqVeiaIfiiWTYgpbDG/yZCox?=
 =?us-ascii?Q?n8dIlwEqaA9+LUTBGtn2u2csuuvoNrwteBVyqzU7n+8N1TX96U5N88IlQHNX?=
 =?us-ascii?Q?J242nYUXuF2ElDJwH3T9b5/DXS6kfXPaxpmeOWGXH1YNhjea26ZzP4UD6lDB?=
 =?us-ascii?Q?Osd0wEbQzsI2pxzMVFuCJnq/yDNWRjVOn5rpLPqX+i2CudMi7XU517MYwMta?=
 =?us-ascii?Q?I00dWtB9G3PjDmaOe15BIE06b/7rUXJiEJ+o696uNccatNOysMoMLkEye6qW?=
 =?us-ascii?Q?jJ/D1ge9Yw6OqbguRSO82yVlF2oLmJqIWukw/fU+p7Ch6HpNPJMOXY0iw8s3?=
 =?us-ascii?Q?ukTtDvoupbQL7WqmpEchstft+N0ViCOGsJxvoEcwRsTqkkwSCNiGs1Kgds3m?=
 =?us-ascii?Q?WmyDTqkLa6KtIwGTEx+67YMkeb/NxTYVUcQ5RmTWNmcRhVG2jbk8C5JAu+hf?=
 =?us-ascii?Q?ddYPjeQHur4WnXZ0afYcKqG0iustT6FM4X1Edom9q3LuHVnGCdSjKDZOahI0?=
 =?us-ascii?Q?h6g2VBrxf/EAJ2yYK0xxNE2Iwuiw6DY123v14isuRpEQI/XcGJIYgQ8f1bmW?=
 =?us-ascii?Q?uAlJoy8jtfLDjMRWJKBgnrXOn+JlA6eSbv61OOd9YohRI/QxFHTJV9949qag?=
 =?us-ascii?Q?STSJWjgxJT9W0Z5C4kLKP8XK/S4fZy5AvvoO/w+HXWaZz+wxWpVuWjkmDGwP?=
 =?us-ascii?Q?jKc8gVnM7oSG7IwLUH1F5I5JdxYQK6pyHLS1psxPddW/fji2LKgvJDLUuz4s?=
 =?us-ascii?Q?jDbW1gSie04KUwiOdKm5HxSwh5/LcJaPPqzIFpdW+UNOwUOFcO5fmfQuaeua?=
 =?us-ascii?Q?jKkXyhnTjt5eTnhkAf7YirGT7muXxzpsVNHczotTwuL91WIAp+zwy+R2n6Gx?=
 =?us-ascii?Q?6ZdDWdpoPGMK25ZlKMlNyZ1iJ0VR2dGfQXBP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kn5TXEyZZXruMSF5HXtXkKjKFzlxrxjg2Z9ze+C5Zzf983io58ed5GS6Gfh1?=
 =?us-ascii?Q?fZ2v5aWyhrwBm5vmCZRW4Lx/XgFUgehnivpAnc3alsmKRI9d5PB+0UIawXDv?=
 =?us-ascii?Q?p1iWu4LKYk4FELOWP73jK4PjD2FJeKMKtOfsivWW5zruAxTvCmuHBGg0gLFZ?=
 =?us-ascii?Q?QzB1FH6HrK4HF9IsZebaVe0YL9NMCZQIzW3FXQzpKlChbbiCAZjYRP1laLvf?=
 =?us-ascii?Q?fT8k68NZ4L7/PXUYCOye0s8qNCOtvo16GSdBoHpJlwTMkf4fOlP90n6qvbrT?=
 =?us-ascii?Q?gTmcDHYp3eq+M7w/iI+jZbw53xyjajtGRgrv9RYA5dqWhrD0BErCLm/abRBT?=
 =?us-ascii?Q?aGs2EDiuTbUO5nhsAfJaf1ORAR/fmC9gSYz4BLp5Dhp6lwK6nvLjoRPdDcgg?=
 =?us-ascii?Q?wJtzAZmDgsiq4EPM53TgjRMFSwn6R7pNumRpqguTvceSO4YS6/DNIrEfhtZu?=
 =?us-ascii?Q?//66kAOGo96piVUC+RFovJjVQBho/hFa7AG0ZUBnNhreAC10CXke7Sh+tofz?=
 =?us-ascii?Q?pqoi2xvxtEqcMZ7/lUceEsvguNCviBVo0eSat2wPywj2S51yDOBz9QErRs+e?=
 =?us-ascii?Q?aVw/jNVVR1h9wrh225kP3sCXu8VAskxeoSV4yQJplj9WLcm9LANdmkXd5Yr7?=
 =?us-ascii?Q?8dfbqq0Cu5brbRlQSksjwVsxrbsqo/F7CFmQxfsNKlNCz2caiJ8cjqF8ZV4J?=
 =?us-ascii?Q?zBaxd9j3J+zITVBmuf6oiHjWlz5I+/Cf8HTTYWax2L4MLgKB7G0PpnHVMU2X?=
 =?us-ascii?Q?JStnq0NCRt/5sS1tbZB/Dx1WgguuZcTfkHnwt27nZExixNWwPmaFVCzZwbnd?=
 =?us-ascii?Q?FF7oAnNw8KcSAIbuBV8wHTLUM6zEaSPkb3lklV4e3TOENureotEXD886xoE8?=
 =?us-ascii?Q?34IuzoUuPXmSgNImWotCHqSZqnthQiCVGL30ato3+OPgWVzuYpLufHZld0dU?=
 =?us-ascii?Q?jkK9gZJdr0fnFMykCcdRofq+jnHz6B1+JMpMBjjDGM+e3k/yEmr7SF7tA1QY?=
 =?us-ascii?Q?OksvR3Rhdi19vCzsD9nEaUTBWAJ6BMCN6/oE7Imlju3Z322+gv3VFU8AfaHj?=
 =?us-ascii?Q?y2c26H73z/Qx98f47SgurD1cMmVd+9+g9zuif9ViSklwY1WiCANmfp5p6Xoy?=
 =?us-ascii?Q?OUX5ltekI79zssKZ0vqUvEVg12W/RUSSPy0eM/7N5ahNtKX2GM0xCCxU9dcM?=
 =?us-ascii?Q?hpVsmu1AkW93NI31eTRrdiBflJd8EQuUHU3tYNvtPtriIb0BPUEE8TtBI7cI?=
 =?us-ascii?Q?d3cQxpO20iTMdeJOdSr56SGA4JJ9ghiHLwkgUBs6mSXv9wt49tt5a8dXBj84?=
 =?us-ascii?Q?1cGI4/W/hDR/ug+UVYlq6P/Jj9AlgN4j101KZFnzkSJWnC+gFau2aWoGRtrA?=
 =?us-ascii?Q?DWRCBNAZ+6W7ErxeJLNrK09ASCy9gLW61XCqlaETiYbbtj5RO6hHRFe53DRo?=
 =?us-ascii?Q?3woXouYE7la4oislLgy47UuJXppHvqLjtcIs1dlhKHL0lcSwJ5eEubspjxz9?=
 =?us-ascii?Q?MV9KuxPJozVQDKwK/Vtt+PqFCvPE3Mfbg89WmPgSX9CGytLB275jmZxqqoyi?=
 =?us-ascii?Q?hKR3rzmr+XE4OVChR7wXboez9NIwutS6IOYqHGwv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9900df42-11d1-42a3-9dee-08de07e24527
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 09:49:14.1275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wBAwpfMfrPInpYYV+vunTSmsJJEiKey8ZOjfB5JZjzdOqIaqMAFGG3dWXLPheuD528CzvXdjRYYo6yJ3Sx2GEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9958

ENETC_RXB_TRUESIZE indicates the size of half a page, but the page size
is adjustable, for ARM64 platform, the PAGE_SIZE can be 4K, 16K and 64K,
so a fixed value '2048' is not correct when the PAGE_SIZE is 16K or 64K.

Fixes: d4fd0404c1c9 ("enetc: Introduce basic PF and VF ENETC ethernet drivers")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 0ec010a7d640..f279fa597991 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -76,7 +76,7 @@ struct enetc_lso_t {
 #define ENETC_LSO_MAX_DATA_LEN		SZ_256K
 
 #define ENETC_RX_MAXFRM_SIZE	ENETC_MAC_MAXFRM_SIZE
-#define ENETC_RXB_TRUESIZE	2048 /* PAGE_SIZE >> 1 */
+#define ENETC_RXB_TRUESIZE	(PAGE_SIZE >> 1)
 #define ENETC_RXB_PAD		NET_SKB_PAD /* add extra space if needed */
 #define ENETC_RXB_DMA_SIZE	\
 	(SKB_WITH_OVERHEAD(ENETC_RXB_TRUESIZE) - ENETC_RXB_PAD)
-- 
2.34.1


