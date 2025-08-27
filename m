Return-Path: <netdev+bounces-217182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBC8B37B09
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 08:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEE343BF645
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 06:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD80314B8E;
	Wed, 27 Aug 2025 06:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="E+a01VUp"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013022.outbound.protection.outlook.com [40.107.162.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD93A31AF2B;
	Wed, 27 Aug 2025 06:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756277758; cv=fail; b=A5bICTNAEckYoX/JQEh9wMrlDtWCj9MmbQKMk/5PXz8mUK5GCjr53NoKEluP7OmxoMIlCP6fhdPAwIPefmCM5BSYsfIwVjn3JWdt/XCGdvXMyCIN2/M1x7v5P78Vgu1W+c+Ggd9MFOVY6meJipRnl/uD29clKE5AXtdJeu+DUso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756277758; c=relaxed/simple;
	bh=38Z0yxZBhs5yWyuG92ncgFhx4bDoz40jUTfEhxUUN84=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a6IzzKj3pyb2QmYx4PFAsySfs+Llc2RAFBeB91iQehO06h5argsTpwjK4HFniIFE6Ai3yDT/Iczkm/f8nbWRrXWcPzlP72p1S5o96+B0AoH2AZoUv0OXSgOuTCDZwgJef7TceJWVEruNb1zmQsI1+AyjiAsB69/chjInOlOpDD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=E+a01VUp; arc=fail smtp.client-ip=40.107.162.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Si4hOq1GMwm5ySNHa5fa6sQJrL1SG4rrYgfX4iSLsVn5xs+tJKOaKd76rXQw3zZ6B8XC+vyVPHaxC2siJbd3ut0AnlWpNmgRQ2B1rcOwc5vMY8qmt6mtoYgj0zUJBRCjBWsUZUZGylOoAGJfZ9amt4SkadRdA5COtku7vFAKgBdbjGINBWiWWam1EAXoTgUundvOPviuSiga2wqHkPK+CRIkLD8nVpn3oU+YLmfT3D3hg6siXKpU2Xdc6YQAR80Qn2x7oLkwmzUqD58REobIKZ7kI/Rk2I4OCMmPFTBL9qTiHcipCt9xOJCzhewjaudsdXeSr/jZqgLrEjDE6RR45Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yt6KRkf0gXwfOGivmY7luvsu/hENg3cVSlJV+2SoKOU=;
 b=JzuEtkqZazUDLtQKPieDb4vnIsG/BKiSa/7l/9rISjTX79jMGHn/TqCxq2Mkdhtz1tJGD3arljjkbmEMO9FHeHk+9uJqoGgYO5tVNHPAkZ28L3s7PgD6lUXlp63ZWLemTkNDGZXpskHm35RD8IZklZQfg0ZhRR61VxofACx85ryE2tm5yML/+MoVqsC93p/MpowGd0ESTR41yJssmkVMTVrpGtSK42y5zEpzgTrEM/SWri7iocmHIPQbVP/yeK+wMtG9/xlCIwHlDoPmnTnpRV7kHxvNREYVtMvMX/3UwtkCkeYeDDV9NSjI8dBovRfeNKMt1V5wfIgCzD4Alvt7pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yt6KRkf0gXwfOGivmY7luvsu/hENg3cVSlJV+2SoKOU=;
 b=E+a01VUprrx4VC52RB1NQy9O82SWIArQbliBh0Ap2Fprl3VlBThxWj0ErHGIWvbSEMkBXeeFrefmvLCmO5F2bBhLHeeKvI7aS0uPRuP8POP4CutA4KTwr5WirErdDmcOOlYMuRJfKC82sfk3DHRQ5qRMetGg/AHp/ORzW9/E30aDL4lLozXrJw3GFDgE0Gb1FYt4CZeLv9pDoCXElG/grpwLCmrFH2m8YxLo1SuyUlF9r087Fqj3kjs2C6yWK3EfCPh7d/mGCLICW5kOjKkjO4QwaqCe1hVJNN4xxakl/igunGRA345s0I7QLK43D7X0Hzq3WjY0lob1OIXyAzu2Ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB9PR04MB9676.eurprd04.prod.outlook.com (2603:10a6:10:308::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Wed, 27 Aug
 2025 06:55:53 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 06:55:53 +0000
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
	shawnguo@kernel.org
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v6 net-next 10/17] MAINTAINERS: add NETC Timer PTP clock driver section
Date: Wed, 27 Aug 2025 14:33:25 +0800
Message-Id: <20250827063332.1217664-11-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250827063332.1217664-1-wei.fang@nxp.com>
References: <20250827063332.1217664-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0111.apcprd02.prod.outlook.com
 (2603:1096:4:92::27) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DB9PR04MB9676:EE_
X-MS-Office365-Filtering-Correlation-Id: b79f79d1-4160-46c0-23f0-08dde536c384
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fYVlyyg2jvxBCLMRId4aFI2TxQmnDoJsna+uOJFbD4lVr60DzoriJcjsOxjY?=
 =?us-ascii?Q?fcZzRy5dzhi2oUf9ZkO+JrKgG23PxV4wmtOCil1k3Y2761crk0I4A29fcvtV?=
 =?us-ascii?Q?0g79KIGS381XDaF/VWN/8WcBoJL/3LvfxncaVM2BnKjmt9LtV5DTleoryHWR?=
 =?us-ascii?Q?iBJciSqsKTI8Wk0rOnWZg2PEQvafulQu4HF3JXm5NjnLnnWa51DWoqBULBxk?=
 =?us-ascii?Q?kVIqaehbJs/6yabPCBNK79Y3E74qoeAl3Ag+U0i6Gpfb17EnQF4nsMg+l5I6?=
 =?us-ascii?Q?As3MSKsMJQC//yf7PMZJa8Lrc/oK6po1LAiDvdx8CdVOkIRva3n3H04oFHpP?=
 =?us-ascii?Q?9O81zfF+BOR8dnkx8dbJpV0vsJ2nhQhP1N4Rns1jpap397LOtlsJ40J21fK0?=
 =?us-ascii?Q?qaiOEtujBDDpbUw9yZp2YBfb7QebZrL+u38a6xUi+QAHZicfljkozgYmUuVR?=
 =?us-ascii?Q?Hs8SloxynsR600EJ3nsmCgArbgn+o/dszR1yTLzuWuQxEAI1vqqcMJ9oKCEK?=
 =?us-ascii?Q?L187P+mo2+Y7cM70sYBtF5q71hI24Xgy/gpTjJJJLsxN8ZHIQM+7+CFdbXzt?=
 =?us-ascii?Q?qyEst78xgSVY4bmgZ/CbLl4OfWh+qvZzKCIlp1t6ZvRH887H/GnZ8mwjanMf?=
 =?us-ascii?Q?RDLIqAdThQ30/w51ZE8Gl/7b8XkhbpBrMqS/AJdwba3YlxOWRdviSV3HTHfl?=
 =?us-ascii?Q?KAd9smk7+1hINZLyF4/M4VeE+9bb5BYw/sCUyp+8OPbwuMqbkFRhFPxJaCdB?=
 =?us-ascii?Q?X6iAfSaG5LLxP0EzZ8kyEExAdfKC4LojzE+MG7MWQ3Tm/vmT7PAg0BirPqVE?=
 =?us-ascii?Q?wIgPd18+dVJ0qflj9OgeQYvtqUmuqxUhsmgQaTlZ/xMVW76Viox0hLvqC7bE?=
 =?us-ascii?Q?K6MT8ZRAnnGdEgKJhqX2pDvxJpsHOPRdjmNVkCiLr/IazwMcoS8CGpIjH75L?=
 =?us-ascii?Q?4+8+CyOebAPSzWXrvRfESpDxx7xedv3LVx0eZX1LzCAxlTN1pCD0msNESirt?=
 =?us-ascii?Q?k4OYNpgdgvkkE+TX1fODFdbVeUJy6Gtl2Q1gYSkqLPWkjeEv6056t7Mh7ImL?=
 =?us-ascii?Q?8kJ7IOQWM/B5M4TDqKjaXCQkkUO7NONfPwG5iDHHS2f19C4VXUu23GGHeaVu?=
 =?us-ascii?Q?0s1m1Cv0Zc5/eDl1z/ON/nHLIkZq2KRq8NfwW7Q0AjhFlEuX8l78pAOgbhqs?=
 =?us-ascii?Q?ILmSi0W/nxUtOLfLyw8J2c/zwEGTp/F+/LlRwMRuYU6DEsv41TFbKCnfaBPw?=
 =?us-ascii?Q?LBDvOjjeKfSJEIf2MCKDw5y0AlkoNNFOM7lT7YgGYdc4F65j4/PCaVq/L94K?=
 =?us-ascii?Q?Ei2crP7YN122L68pqhbtr7tn9CtxTxr9a8esSPUMC8oWkJNsF2rgyoloQCvc?=
 =?us-ascii?Q?7s6Jau+a0ArZjtVKkAmcZTca7j1UxL8gm0gcDp2/GCKEPekr8olWyOsEjiIy?=
 =?us-ascii?Q?4pUswC7EZnetk/eV79UOdK81cZtee528xvBuJudR0RdLunYFWloVyRdtSvsb?=
 =?us-ascii?Q?h7X4usnlIuvsi34=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eZVz9cXXNmc2r47FMU0xqZzsoycDReYk2buRTZS/aPALndc3u42o3DgrraEw?=
 =?us-ascii?Q?p/7L7xg4alGhNyAlLE3oT61dVtcgivL7cqlcXKscPuF9ciuv9ZqugTxC5jX2?=
 =?us-ascii?Q?s1/LtUO3cdhdC6jHwVjJawp9uiK8FHO8p3iplF+CLbZ76nDmL9SUTfcKXIV2?=
 =?us-ascii?Q?ENRBR4vgewpuendfcx5mNO4xBNszcYSxmQpIRLGWu98si8f1ZgEe+i2QZkg2?=
 =?us-ascii?Q?NyKCflNxMNowHLrJs34uNRUayb/WWi7z0Q/AZ2D+mGEK2qtJCwky9DGvu2bO?=
 =?us-ascii?Q?2xceNuQ8OmHySrQ66jtc9ke507yM34HSr7vCuxGwID4UEw0qQANyivgGm/27?=
 =?us-ascii?Q?OTH9m3t+ToQKjeMpTWWCy2nwgS8z5/tcyxzfuliZXnh2Yi3Luqvp1kGvxucS?=
 =?us-ascii?Q?QN2BSuaTk2HaOBXbZbrLiEMQjEZ4MQ3GkyHme5dmUS8b9cEyQC/sQ7tmRzou?=
 =?us-ascii?Q?h+5Yml7IbP90NQuPDHnsCDWkMF2O9dYWnC9uM4h4/Gw9ahu4JU2gAwNHa7ve?=
 =?us-ascii?Q?eraPxbZZqF2zMoyQ4WFQS4GZ5zeACuyG/WDyDvwn6D5383HFs8zStyzyfO20?=
 =?us-ascii?Q?DUJjQ1IqaDuXUle5Sx+udiuD2f9bvNXBDoqPmr34JdgxzxedAXQdVXFuBmQ5?=
 =?us-ascii?Q?IelFp7klWtdooFj9g/4rJjo8jk1Jfv1YnaXpcMLLEhjuOO0eiqfWLW7LOFOT?=
 =?us-ascii?Q?9+hZ4oL3KKSFGt4srOOYajidlUC4XZAfd04rCeFticmwY1KbwIVWvQ6UUMp1?=
 =?us-ascii?Q?5BHDGtZ8nobGxLYwofPLfF2zT7nhjwiI6YBI9Cbis3fUs9X1LU06/kkhNcS1?=
 =?us-ascii?Q?lWLzaBA0bLHLXKy/PDIUEUwL6Pgo72pK9bD9WD+5tZHtJ5m/r3hxHNUZa7ML?=
 =?us-ascii?Q?GqjusfLaXSQmGGVto+LTGsaR8iTP+iYKbftS98722vnHtATyX5gpCOoeBJLp?=
 =?us-ascii?Q?5Hn7vLYup11GWX5/c9468fFeSN7OhcUws+fCYH9lINlEUoWII2IwaElbHSVs?=
 =?us-ascii?Q?67TgWr2LwTP3/GPLD/A9UVpfsdWc3qeA2Z/K4Z8LB2sEtWmILI8K+R5agyW0?=
 =?us-ascii?Q?XPjDbwmXzKX9xbVeE5In6ox6X1pd3YoCr+CZVCPt4G9J1ho2lxn2LpCCks/D?=
 =?us-ascii?Q?a7/ZGp8DBSfpTNuGDULtY/6NZdSK+jnYNdtrNlTW06cvOry1apANJKFmW2YT?=
 =?us-ascii?Q?5ygS8hrq5lgtAAxKBUsZ+vNBvHpibaw95YM4t6gGFNtmMeNipmvLDr+On31K?=
 =?us-ascii?Q?wD/UZ7os25AzXJGx4mn2QboacuKRZTJTT5TDhXD3SM9ypZuNw6Y+nYQUZt9H?=
 =?us-ascii?Q?rZ2/ShyI+qsUkAUfRVQMBxHWQHEzbefax6oNZkyV1b6K5g0ala5SwzxU3Irk?=
 =?us-ascii?Q?ruWMV+DcXYHrSJYh9/kxF0IOqlUNit8R5MGEnHAFgD19P53rVRgccWG6M/Zi?=
 =?us-ascii?Q?+c0N7cOBGFsZcU0KIZ8vZ2eAwITgtW2rpMfyGn6pGUYZt+pvjezk6mg3JeKA?=
 =?us-ascii?Q?YsenL8vpLL/LVCn1+k+d78cYMoxDG90gsYxnrLDG6nPWHXECXoMJGeKGmWhd?=
 =?us-ascii?Q?c7MDNzw66yf7GDHLQPANdNDBhJb35ik3+FhRELAt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b79f79d1-4160-46c0-23f0-08dde536c384
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 06:55:53.1065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n3VWWfs160rMSdTY1ZjfI1ibVpHhraI6Sfs2CBlp7l9SrfeEN6fxoXs17ZpRHy3oA7NKVuFXHtbYiVBu3wodWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9676

Add a section entry for NXP NETC Timer PTP clock driver.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>

---
v2,v3: no changes, just collect Reviewed-by tag
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bce96dd254b8..eb33acf9e3ec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18263,6 +18263,15 @@ F:	Documentation/devicetree/bindings/clock/*imx*
 F:	drivers/clk/imx/
 F:	include/dt-bindings/clock/*imx*
 
+NXP NETC TIMER PTP CLOCK DRIVER
+M:	Wei Fang <wei.fang@nxp.com>
+M:	Clark Wang <xiaoning.wang@nxp.com>
+L:	imx@lists.linux.dev
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml
+F:	drivers/ptp/ptp_netc.c
+
 NXP PF8100/PF8121A/PF8200 PMIC REGULATOR DEVICE DRIVER
 M:	Jagan Teki <jagan@amarulasolutions.com>
 S:	Maintained
-- 
2.34.1


