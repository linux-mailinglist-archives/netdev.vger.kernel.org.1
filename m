Return-Path: <netdev+bounces-188258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 920B9AABD2E
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 10:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F5847A6537
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 08:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55A625291E;
	Tue,  6 May 2025 08:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="buFTanOP"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013018.outbound.protection.outlook.com [52.101.67.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B82B25290D;
	Tue,  6 May 2025 08:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746520035; cv=fail; b=WXAEabcXT/Pe+Zf9sz9nCOKpB3941iev4RgTBQu+QdUKjIzi7uAoJmDSnwJQgwnD24n1/VIXnAJh+imdJPpCR0Hd8Ag2U5nVlVt6PWKgedtYUHiX7oLXPcdQGgJeceizMu2+RZi02iNSyz0N37U7tc2THGkfNDAdQoa3atWpBXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746520035; c=relaxed/simple;
	bh=sohNHEnuk1sw3OUv6El9zLxu4l9GBa1QaXB2fkXsYFE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R0x3Ir5HmYRQ0p1EJvQ+46SXqqZBQlSvs4LpIgwbHNSCiO0wliPd5XC/ZxKtqNzVEQ6cpihjnlrFHSNPssIl1Xdp91HId2xYGfCc6NmQzGBC56PwdJY58cF/yn0mTiVERr9aJ0Gntm/vm6yVpwTvO5ZU80ZQQ3aVKS2DI52898o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=buFTanOP; arc=fail smtp.client-ip=52.101.67.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c9GaSgZ3CrwH5kOpsg/KiwSba96r9zB8KkyPdvQuy+NcDZg9xsAY4aIU6bs7G22bjNjdVBywUpjUSVw4W+/E0mnrL714042vjTKrWAel1N7rRPZNyi/QlsKjO9WIQX2XKYcXm3XEGO8UGKCpSqr/bRuV9nHmYXti82zt86KmJ9hUa2H6qK4/qjkGW1EFtYSHV7XMMWKdUUMtGOZf1F2uIckn4rRb8vP93K45HaLK/UjXwbOiwxz1mZJulht6vETRCGMIHWwUqyYIhDhrhIi2tcbGGcPQK8Kp59mEfBYj+p31EX1jr3ie/ecLxb8xMlzmEg87PGDWBZ8UVuup2zyy0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kRhcVk6eSI93pwXcibbfWx3WDfrpg9mR0Zyr+9IIJcQ=;
 b=PittQS/shr8Sxvpq25jlWw2FmAXHahch1+RIJm4PlLn9djPCYYS2WQQIbHBYdVSxW3QbS0lYgyhGJXA9rIMJOmAKCqidGV3ACB4rlIa28odjqIoJ6al2Z1/KelUxOvxjTMWoGUh0PsXaxm3prBUymW22xJm3coD8YwP76xd5DQRX9zprg6xyvaJJvi9P7YSfV+doDW+SgJP0IeAQH696eDqmoS103X1mxuYKHfXNoBcMZzUXXftQ+MHsPNJYpvR1Nq115oywr0IbZVokg5wERGdenKJZ4qGnXbq48YYnUzsGpAHnZwezRRCVIVxAD2HzJRBpRHg5jTqytk7MU2vQOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kRhcVk6eSI93pwXcibbfWx3WDfrpg9mR0Zyr+9IIJcQ=;
 b=buFTanOPBV1Ved2b5hIwA4G5g3LZtb2VDwNhsnyU4ZwTQirdWrF2jAA58ubEW9FUeTXrTdwU7Ogbhlvv6nscJF1pnFhQ73guOhgOO3i6WKNEWdyEz2BN0cu4aXBFdXuDAQ6lTtatVAdjilczIyOd58xCFk4stP6uIqOH8czAvpg/fQDJI7i4K3kvavZ39bDYJDFDm0GlV+K5X2SIHZTbMzy+unTJcffVN+WRzdnrn3lqez9tL4i+KaOxS4AkqDJzC9EU5Z/QuBTIKjv/k22lKS1cY9/UR38loiavjPtE03VWiVIpSLK1iYJ6L51WelHPv30Mmu3VU0plwzuI8vqEJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB7744.eurprd04.prod.outlook.com (2603:10a6:102:c9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 08:27:11 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 08:27:10 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: christophe.leroy@csgroup.eu,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	timur@kernel.org
Subject: [PATCH v7 net-next 05/14] net: enetc: add debugfs interface to dump MAC filter
Date: Tue,  6 May 2025 16:07:26 +0800
Message-Id: <20250506080735.3444381-6-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250506080735.3444381-1-wei.fang@nxp.com>
References: <20250506080735.3444381-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0249.apcprd06.prod.outlook.com
 (2603:1096:4:ac::33) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA4PR04MB7744:EE_
X-MS-Office365-Filtering-Correlation-Id: e9994450-b40b-454f-c52f-08dd8c77cbcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DmqyEdaBQzxJMiJgbbkJZeVUs0vJ5vkbA4ShlnhcbBrrGjoSr9yQMbmINAeD?=
 =?us-ascii?Q?aOf/8CmRQZVK0U8RL7+2LSooIsHSQ9cqgeER2gQVqf6Q26hs8zJrPZ65eRwq?=
 =?us-ascii?Q?VGBT7d8wraaMcIPDAyL9W9qqQEJK4DK6neDZ4Qd8gS8nGsBpa7HdOQv8FbSr?=
 =?us-ascii?Q?6vWIojz7PvMPJno5moU8Fkt+amfmUd7eUo9hN0xr3RcPivWYEK/aRDzKdvqP?=
 =?us-ascii?Q?Seny/Tmp4xuKT886KbV+zTMV8G93wWPDbM7ofSIeWa7vPhdzdLSADHg4mSOv?=
 =?us-ascii?Q?4cr40y/KYNFlg7cKZXwtpITkduz0F5GtyN3765v3QMAER9QbbXjARqhROEtn?=
 =?us-ascii?Q?oF8Gc1p7ZogMPTD4raijlbfUmLNTbRwVWexV4aSgZPNM64RHqLiGCBsjX8xE?=
 =?us-ascii?Q?eP/pag2T/LptH9x/rHR8azUYZy1T6hTWjM9uFv6k89uov3c6wm7rS61NOnvi?=
 =?us-ascii?Q?cYgOFfCV3GCnOcaZZJp3uMtDiVVRquaOYzYge9oU/OGlM8zMjvsKr9rwUquk?=
 =?us-ascii?Q?z4EQMZAltObLorMV7YZKhsFozOOpzni1fDgMlCwm0H406LeM0J5GZDOfeVHD?=
 =?us-ascii?Q?cXJ/PJKray0SGb2fgY/ZR6mMtU5MNe66dfJ8DsNH7E0PlaXWa/VCObVZ5/Mk?=
 =?us-ascii?Q?tuJns/ddk0B16rrk0cQO1NPKG/62lN+75DP+2ftSotta/VRg6Y7F44sX4/Is?=
 =?us-ascii?Q?yyPomzfLYqOXznrrSnOUNcjxea0KuSMUxs6Qf4a8UPtp1JtfayS+JalcvmpC?=
 =?us-ascii?Q?8ShUNxhq6pA8ju3nkaXv6/abVrA1ZpyZigB0D2FAV7GREN1F/mAOT5hMRjKE?=
 =?us-ascii?Q?L3sRGRAoUpnQP+P7q62pCUR5ZNrQDn2r4m34plm3puNvef/zvni4WkC3rVz9?=
 =?us-ascii?Q?kqYzytrsjX47MWoibg4fFLTKNGdNqMpDVGBVpXFlx6CzZQaZ6umec+m3KhKr?=
 =?us-ascii?Q?I764i5DjHD0KGTyG1EJvm4/WELVq1CE5tPSgTKw6iKFg+Iv7uFh/k4OWEFmL?=
 =?us-ascii?Q?8dfSofw8nLZq7SpdD3aa7sLi1wHMBxydmKLMwl3vDS0/0tZqcg9jsdhavrTp?=
 =?us-ascii?Q?dYeDNcArnyhgRzmQ6zhrrDqx53ptjqsw0HIuBvu2f8j83LSvukIZ0tN5vHPX?=
 =?us-ascii?Q?IJX+4z2M6O3dS4CwJvVTBj8+tT5vbIgkkPgPAqS5ipQcTxwI0hqfrprgCuBu?=
 =?us-ascii?Q?1UWZnfUF1adTdJ7OCLCV6a42FvkK0GIwDQPftpPxDgV2cdgpqd8D8+2tTKEX?=
 =?us-ascii?Q?dDfxkAKNEZq/UzLzy3NIf5v5jCXRd8qN1X4U++Q3nKYg2Ayr2WZKf50Iqu5K?=
 =?us-ascii?Q?hqcDx0zsphhIB7EDEmeePpfLqIGXfPjPNxk1Ixz7jLjdx4vg+xa5qctV1/VJ?=
 =?us-ascii?Q?9dLJ3PRleJaXm2HJXU3kJcUIfYTPyckGRiI745XRO+LEfVVkgRWkNVIfQC0B?=
 =?us-ascii?Q?KJkRE8tEQtJCdxDvImcJejurAdlcmzwQBlJfmHhBfYi4Bp1XC6RHNA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a4UXSRme0mwVsAEXosXCpILkfFk72PqtuT0DV7NNm8AZsaKVtCe97KN1sg2w?=
 =?us-ascii?Q?tG5q26Y+cfliIyApRfXS/BCun8CkowBiDkp6lJY56ObYCw7oHcku4bI2/ypv?=
 =?us-ascii?Q?yDSpm8ZP+5bS/6BD/Wzqtx6dCFbhFhBwxO++h5sy0bR+PKDx6jiqhv+XlXOb?=
 =?us-ascii?Q?/ki9MaDrVdvNyZYjGo6rNDBwixPK5e0/tVjj7ZqN96o4kgjAhugtYJAoXvpn?=
 =?us-ascii?Q?0kC+Peun0I00dG+aDgt2u8g2LAZx6rsTbYJhdCMpt4PrfvgoT7bgJ9A9z1Ae?=
 =?us-ascii?Q?iriiFfYVvZdJa5VB5kCfW0/iD/EMToioQNJ8CPHJb3NLCUJECLApKAFjkRbO?=
 =?us-ascii?Q?5i2lOREH4eAbZTJn5jOK9RxG2OocHYh44zijuqCy79FMtomUkmL8JAQUuXg9?=
 =?us-ascii?Q?+w+XSEJ23nFTeY/soMJw8xfzo6z6cu3IwkaQFLTIofXuRNo71XOwPHW7+USR?=
 =?us-ascii?Q?qb+fJKQPcKrYIa20/H+5dpj+qCzApeR18sWSv68lLOCdgHpBCSJkPF2dEYxY?=
 =?us-ascii?Q?5Rz8O+z7wU7DYRnhpHoTYLdbevYR0skpzY9VUZCVKnTWtcBY6I7zqQpFIQBR?=
 =?us-ascii?Q?W1WP+l1VtUmxiHPmS5x+UcIHHrChnqbZCgR+MulE3yNTX7AhHSGmKc1IoQJY?=
 =?us-ascii?Q?T+fzBCHaGfeA7VoZIxsREQ3NCnKro8Qh1c3OmkQExdpzzHDhiN1yLGAazWtQ?=
 =?us-ascii?Q?1nYvuWirEg5CcT2aSI93mUA7ANPaWYnAOhlZQFUikexGW/7efjKgCdZPDXlP?=
 =?us-ascii?Q?cTBECvj21yVQq82cofmjVkfsbtlZnvSpoJ1PPwENvvL7IyhhEv0pntpb0gPH?=
 =?us-ascii?Q?VHSOK9FRA1YNCa120btvNOH2yRJt+Lqmqr8ETSk15w2NblP4nLoQF+2AVjRa?=
 =?us-ascii?Q?+n0g0V6KfmnDYGsvntGfhvfSM1EzlYOLvV729rYEa2WkkpJ3kkzGrlZ2aBec?=
 =?us-ascii?Q?iaOMyFqwrdVOFCJ6YWgvTRcw9rwclp++HEwz25vRcjjEHOBvetH3f8ddIo0M?=
 =?us-ascii?Q?ZAQDq8/NyaBtVRGi3eIlOmQ913V2y3XaKF9mOblv6aJPE5mrvOFOl5B1LLaS?=
 =?us-ascii?Q?stVcj4SyKfjzNm9d6ixaVJBzVCYPFTY7I80m5JObbgZ5COD3cmZ8MLT2UjJb?=
 =?us-ascii?Q?nW6ayFXzNV6JevG9hLUxZKJHHDNzU/BYAN+pj13cOP+YCDutwU13LIvi1hQx?=
 =?us-ascii?Q?p9xetHkc1EV7eFgwcINXxL5aulhRCz2RY2S0RP5zITqlbgzqdVcou2AfPJcy?=
 =?us-ascii?Q?/FeumsdGT6rs7h6FPyLa7WwZZCMKm3d2CdwjY8LvIVjlppqmTMNKa3hqkt8G?=
 =?us-ascii?Q?NSJw09hYbhPeZrqakND9NKVX7KMOl84i5slLeqeBpj1a5OzMguWceHS+xi5u?=
 =?us-ascii?Q?i1OwOwRnCqfrPZvXJpGuYJL4eG00WJLp59LkjZRQAfqgGGXpeWjYq7V3/WBD?=
 =?us-ascii?Q?x7BaUrQ1mCBS/bC51gDn0K3TwKRWdqL9mADZUPiOpErT5aX07CMN1pnTpwEp?=
 =?us-ascii?Q?bAambDM0YcSH6rk0/nf987Evq9oDORM9PNAr7MUylmulgRGqIu5jP+TWYSf1?=
 =?us-ascii?Q?+rxHymOkjeGLoyXVbXBJXjaH6ItOX4Xzjyuwe+FK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9994450-b40b-454f-c52f-08dd8c77cbcd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 08:27:10.8683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +gB1tQjHE4OYkBgCgCks+n9K6P5z+01HRHSUAJrXDCgXXzDDrO0o3VJHAE8m3+yQ69OVMkxps1cWXIWVjEoY1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7744

ENETC's MAC filter consists of hash MAC filter and exact MAC filter.
Hash MAC filter is a 64-bit entry hash table consisting of two 32-bit
registers. Exact MAC filter is implemented by configuring MAC address
filter table through command BD ring. The table is stored in ENETC's
internal memory and needs to be read through command BD ring. In order
to facilitate debugging, added a debugfs interface to get the relevant
information about MAC filter.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/Makefile |  1 +
 drivers/net/ethernet/freescale/enetc/enetc.h  |  1 +
 .../ethernet/freescale/enetc/enetc4_debugfs.c | 90 +++++++++++++++++++
 .../ethernet/freescale/enetc/enetc4_debugfs.h | 20 +++++
 .../net/ethernet/freescale/enetc/enetc4_pf.c  |  4 +
 5 files changed, 116 insertions(+)
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc4_debugfs.h

diff --git a/drivers/net/ethernet/freescale/enetc/Makefile b/drivers/net/ethernet/freescale/enetc/Makefile
index 707a68e26971..f1c5ad45fd76 100644
--- a/drivers/net/ethernet/freescale/enetc/Makefile
+++ b/drivers/net/ethernet/freescale/enetc/Makefile
@@ -16,6 +16,7 @@ fsl-enetc-$(CONFIG_FSL_ENETC_QOS) += enetc_qos.o
 
 obj-$(CONFIG_NXP_ENETC4) += nxp-enetc4.o
 nxp-enetc4-y := enetc4_pf.o
+nxp-enetc4-$(CONFIG_DEBUG_FS) += enetc4_debugfs.o
 
 obj-$(CONFIG_FSL_ENETC_VF) += fsl-enetc-vf.o
 fsl-enetc-vf-y := enetc_vf.o
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 1573ff06fcf4..b53ecc882a90 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -304,6 +304,7 @@ struct enetc_si {
 
 	struct workqueue_struct *workqueue;
 	struct work_struct rx_mode_task;
+	struct dentry *debugfs_root;
 };
 
 #define ENETC_SI_ALIGN	32
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c b/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
new file mode 100644
index 000000000000..1b1591dce73d
--- /dev/null
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright 2025 NXP */
+
+#include <linux/device.h>
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+#include <linux/string_choices.h>
+
+#include "enetc_pf.h"
+#include "enetc4_debugfs.h"
+
+static void enetc_show_si_mac_hash_filter(struct seq_file *s, int i)
+{
+	struct enetc_si *si = s->private;
+	struct enetc_hw *hw = &si->hw;
+	u32 hash_h, hash_l;
+
+	hash_l = enetc_port_rd(hw, ENETC4_PSIUMHFR0(i));
+	hash_h = enetc_port_rd(hw, ENETC4_PSIUMHFR1(i));
+	seq_printf(s, "SI %d unicast MAC hash filter: 0x%08x%08x\n",
+		   i, hash_h, hash_l);
+
+	hash_l = enetc_port_rd(hw, ENETC4_PSIMMHFR0(i));
+	hash_h = enetc_port_rd(hw, ENETC4_PSIMMHFR1(i));
+	seq_printf(s, "SI %d multicast MAC hash filter: 0x%08x%08x\n",
+		   i, hash_h, hash_l);
+}
+
+static int enetc_mac_filter_show(struct seq_file *s, void *data)
+{
+	struct enetc_si *si = s->private;
+	struct enetc_hw *hw = &si->hw;
+	struct maft_entry_data maft;
+	struct enetc_pf *pf;
+	int i, err, num_si;
+	u32 val;
+
+	pf = enetc_si_priv(si);
+	num_si = pf->caps.num_vsi + 1;
+
+	val = enetc_port_rd(hw, ENETC4_PSIPMMR);
+	for (i = 0; i < num_si; i++) {
+		seq_printf(s, "SI %d Unicast Promiscuous mode: %s\n", i,
+			   str_enabled_disabled(PSIPMMR_SI_MAC_UP(i) & val));
+		seq_printf(s, "SI %d Multicast Promiscuous mode: %s\n", i,
+			   str_enabled_disabled(PSIPMMR_SI_MAC_MP(i) & val));
+	}
+
+	/* MAC hash filter table */
+	for (i = 0; i < num_si; i++)
+		enetc_show_si_mac_hash_filter(s, i);
+
+	if (!pf->num_mfe)
+		return 0;
+
+	/* MAC address filter table */
+	seq_puts(s, "MAC address filter table\n");
+	for (i = 0; i < pf->num_mfe; i++) {
+		memset(&maft, 0, sizeof(maft));
+		err = ntmp_maft_query_entry(&si->ntmp_user, i, &maft);
+		if (err)
+			return err;
+
+		seq_printf(s, "Entry %d, MAC: %pM, SI bitmap: 0x%04x\n", i,
+			   maft.keye.mac_addr, le16_to_cpu(maft.cfge.si_bitmap));
+	}
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(enetc_mac_filter);
+
+void enetc_create_debugfs(struct enetc_si *si)
+{
+	struct net_device *ndev = si->ndev;
+	struct dentry *root;
+
+	root = debugfs_create_dir(netdev_name(ndev), NULL);
+	if (IS_ERR(root))
+		return;
+
+	si->debugfs_root = root;
+
+	debugfs_create_file("mac_filter", 0444, root, si, &enetc_mac_filter_fops);
+}
+
+void enetc_remove_debugfs(struct enetc_si *si)
+{
+	debugfs_remove(si->debugfs_root);
+	si->debugfs_root = NULL;
+}
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.h b/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.h
new file mode 100644
index 000000000000..96caca35f79d
--- /dev/null
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
+/* Copyright 2025 NXP */
+
+#ifndef __ENETC4_DEBUGFS_H
+#define __ENETC4_DEBUGFS_H
+
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+void enetc_create_debugfs(struct enetc_si *si);
+void enetc_remove_debugfs(struct enetc_si *si);
+#else
+static inline void enetc_create_debugfs(struct enetc_si *si)
+{
+}
+
+static inline void enetc_remove_debugfs(struct enetc_si *si)
+{
+}
+#endif
+
+#endif
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 7b801f6e9a31..db60354ea8d1 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -8,6 +8,7 @@
 #include <linux/unaligned.h>
 
 #include "enetc_pf_common.h"
+#include "enetc4_debugfs.h"
 
 #define ENETC_SI_MAX_RING_NUM	8
 
@@ -1018,6 +1019,8 @@ static int enetc4_pf_probe(struct pci_dev *pdev,
 	if (err)
 		goto err_netdev_create;
 
+	enetc_create_debugfs(si);
+
 	return 0;
 
 err_netdev_create:
@@ -1031,6 +1034,7 @@ static void enetc4_pf_remove(struct pci_dev *pdev)
 	struct enetc_si *si = pci_get_drvdata(pdev);
 	struct enetc_pf *pf = enetc_si_priv(si);
 
+	enetc_remove_debugfs(si);
 	enetc4_pf_netdev_destroy(si);
 	enetc4_pf_free(pf);
 }
-- 
2.34.1


