Return-Path: <netdev+bounces-215689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CFEB2FE60
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 17:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 857AFAC1920
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 15:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE4829B8D9;
	Thu, 21 Aug 2025 15:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="B4JoU8/G"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012037.outbound.protection.outlook.com [52.101.66.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88096283FCE;
	Thu, 21 Aug 2025 15:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755789689; cv=fail; b=FNBSEsg20ywRwbfCzvsqbpKr3FXyjQ8mwBi8TUc/bvh73cH1YIHUBb5ZzD2Z3I4doi+lmGGEqWgU8NCCRVVCza6Z0TseAncmQIlsue425AJ+yOvTx0ENPJLHX6NKQkPMKu0RfsgYiNoKBzeFF1J34VJsRQI8e69n6e21HQXy3Ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755789689; c=relaxed/simple;
	bh=7ZO8BWdNB3gFOE6N2KfiF1kGW0jDGB7VPs9/pt3ry3s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CbIYYAdhLRvCDFvqzjt6xyrYp0qohTx77E6n4pb4oONx3+G3475faBZACFD9Ilrba2j3Zj4QTlGohK2sNav2AdXbe38Yj9gtMAO4d/acpCg5+pZGrNpOYIbP6Jt6iHefHInQ1dhynW1b3rLTGYJglZAHEl3oFoGywnv+pIp/R0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=B4JoU8/G; arc=fail smtp.client-ip=52.101.66.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FTEikOBeqyH4TanoZ4cEr/Tns34TFT9f2KWMN48zJFC3W7a5/pGiiZexR5YAFD/jO46AhV0pPf+ucqvyb6hGLgHAox9MQSyYwMflac+z0bOwXrQShdWpxbQMV+kIXN+uqVV/rxCfrArM90yymTQ9fbTY0cuh8EMWjp2uqzQAT0b2128YIyqWxcybPNwZhSeCLmTKWr8A+U/0OfDGKs1CfL6av915emX/Mc1crU4cQZg+ZKa+I+bNp5qITRThuj5K5/8bMq9KQAi5gOIdNsz4kxbHwPc9CuFM6qcOm+0vAUI7EReb46fzfxcm6bWNYjrYf/gQ7prZphuUpAVnxAPqMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7jlV6vbgvzqX5kXY5ZVH6ZggRYe8Q1k4zdx9zNYHvy8=;
 b=qQ8f/AjVJYPfBIjULWp5zRRP3mLNSjOA4D2c8gQLYdyCog/gmfJlKSrlrcK5m3mlr26oYhPGgi3aa6r82qXFX+9GyDs7aGcE+NNw582jnv/M0spevLbMak2XStILKXvcKuORquWzkQvOKydMS4NCm0QtsVG+5zxFkSHCnmwQ2nXnNLER29k+T2AVGNFDOHrDHGfuihiVRQlZYsE/kb+FUD0L17qDT3PMFhcrZUv2SKdULfX6/bL9qU6UKOEp0shPFCVS4v7sabbhLXNhuZHDRv2XgGmmdC5tYSWFgMvqLnhCLen0Kynld5lTfjTp4IMYyEfb5+4QShAq3V0cQd8opw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7jlV6vbgvzqX5kXY5ZVH6ZggRYe8Q1k4zdx9zNYHvy8=;
 b=B4JoU8/GgRNacG9xRm0ugPaDBSbsQc43eMrgxn4bgrzuT4ktfofPwqHB2M0oL0GbISHE/I5OvXLNf0nZ6jxZmd0ZeJgv6XQ8BKNUjWNWMn5GyOlX4ERbMQU9TJesS86x43qHynxXD2XVRssB/GiST1AAt5luSIOArQ9v4LevjLPYYPi08/AwZ1fwhczoPA3qHsB/YErJBKiO0xZq2RYuw/Yje4Mbewu2Pwe6DBWn4TNRrPodrQEl40EAUKtuVk7yTx9X+U7jM91ILla8UgT1n2UDkiIgEEOklxcKf8cTWxZ4FO6597nvbJhvrWbWTip1T2CTCmfVfIi2tcfDit8AZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI2PR04MB10809.eurprd04.prod.outlook.com (2603:10a6:800:27b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.11; Thu, 21 Aug
 2025 15:21:18 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 15:21:18 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	linux-kernel@vger.kernel.org,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Robert Marko <robimarko@gmail.com>,
	=?UTF-8?q?Pawe=C5=82=20Owoc?= <frut3k7@gmail.com>,
	Sean Anderson <sean.anderson@seco.com>,
	Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH net-next 04/15] net: phy: aquantia: rename some aqr107 functions according to generation
Date: Thu, 21 Aug 2025 18:20:11 +0300
Message-Id: <20250821152022.1065237-5-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250821152022.1065237-1-vladimir.oltean@nxp.com>
References: <20250821152022.1065237-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0016.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::8) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI2PR04MB10809:EE_
X-MS-Office365-Filtering-Correlation-Id: f89b955d-5a13-4e81-f7ba-08dde0c6609e
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|52116014|376014|19092799006|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?5WYGp6FWu1TsRmZOdBY1cIts1pw0LPDtxUQcr+vLMZwJatq6TmPQLwg6mcMq?=
 =?us-ascii?Q?BhnQ94mnl49zfql11fOrD8M1KX+eUoNQ8n1XfofoOTuxRn1Lvl5qdmOSBc3z?=
 =?us-ascii?Q?ERwWX0C1LESG/3q+e76f8pVIoB/u/bxccIqCqnxQ6ay1iOXOzTGhd4S7EvEW?=
 =?us-ascii?Q?prBMZB4Qyi7vLNHR9aMyhCdcdoK/lCcxrPY41lf3HXAqDRly/1c46fCrX1p5?=
 =?us-ascii?Q?QJ+4qoktq5UJVvBBaM1HuGDqJmzQLKKFAH+8I15K2jpnw9i5UR+jACP3Ot0t?=
 =?us-ascii?Q?Rk1lv5jnTaiHkRlUDtdcCTBccZ7rarVWTV1H92mzRmJT4nbdD4QzfE1T7gqo?=
 =?us-ascii?Q?tr/CBUYB5N9Qt80myjic6aaae2UCSLmyG/ov7pciAg9+/t1fP3kxToTwTCYr?=
 =?us-ascii?Q?Enrw+yNtj5PwOr8sBO0F3GZ1JrcXOviAEMPMyfXp9kdYh2CDir4/FJyoA5EG?=
 =?us-ascii?Q?WWQFzr0wrdUzslyWkbIhCH+wkFIQ3JYszAIT2UuCVdy4m+Iffk31vn5hfRMZ?=
 =?us-ascii?Q?vcALYlGulljDcxcms5qjEoy/DhbKS3XVNMAQ+Dzq2BB6syEnGl+i4owrIDMm?=
 =?us-ascii?Q?m7JuTH9guqFGc4W/XI6U+t8QC9rUlEkt2XITLfczmiBvQ2YTCqEf8EiCQ825?=
 =?us-ascii?Q?5UxwHMVejXfQst0LruxHNpQ7xj7v3en+rABg35MsCO3lGEgvCiRxYzNl9ONm?=
 =?us-ascii?Q?UdGp9FpIH9a1BWAn5RLTvC+Rj+OtYuClcgcaaQAceVk9n4y/bNlCO+9ON1dj?=
 =?us-ascii?Q?GHpHUKNIcA5m/GLCJWMNAX4M5F4PhmGoFy/i3Ku+9FEBGLord3PRMrm6G3ip?=
 =?us-ascii?Q?CVGc4AgdTmgNkwTp5D0X3XrLPSu/3Y900nStIgr3SUYvntn6YXY/Lk5pD41l?=
 =?us-ascii?Q?lqvsmZmgCMlIsJQIqL9nA2d0bqhE4glhugQRNIXEvLp2i1fH91KzsdXZ8fUF?=
 =?us-ascii?Q?B+ppvGwm6XXX98ECUTNml39pPydaMit7DLw1+hi+5A62jfp/H/bnNDwN055C?=
 =?us-ascii?Q?YSd/5u/9iURklqDfoIpwz0OOW8BbTiBgPjPAK+OInnh7ia6m8ho9TKNhGQQk?=
 =?us-ascii?Q?JaKAHBret86EP5V+GXS+Xe6QaatvKQm2ldfcCo7j5bc1uI6i/uIr/T0bQh7a?=
 =?us-ascii?Q?yLlr9Wawev9UzqSyQyfqWNAob6QPJvPv6hdrkbciS/HAQkXaLzQzN21sY120?=
 =?us-ascii?Q?dcHCcjUxiKGV+cz3f2r0rl4UR5cnUhJ5i0dv/ZEL2T29EQ+k63tFGiF5Olvg?=
 =?us-ascii?Q?s7oWoW1GvvY5RMtCLFsUC8PvH6/3S5qpiCaHBeMd1hOXxXqEGbpD+kwH95qH?=
 =?us-ascii?Q?Bjrsx7SR5EQhE8W6Dnmuue3PMt/UzlaejN4fPvYLkZPJctZhyHmzbxGUMIfK?=
 =?us-ascii?Q?RkCIUAfh50NR3MEZQiXNMQ97ZHQiqAll/HAigPi6289WxpsIp2puL72txOW9?=
 =?us-ascii?Q?Aneo243zIIj8M6xVnxPKcwCNu2LrBJlobF3Uf5W12s7wqxduCWryIw=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(19092799006)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?NE4xei/5bh1fCIJIz2gLiEyDFdmp/rTqZ5PvTtPyDFe62mEvNb1D8zrMYC6N?=
 =?us-ascii?Q?sRwwq4Kk0t9lAQIvBXm+jxa9RohBLynTI4kIIR6g4BkXP34nLDhIlD3cAjGU?=
 =?us-ascii?Q?G/sBEVo6fLBM8AwbJAwpbiw4At7JfHAD7DovpUO7gPEN7dD5jwusrB42VxZJ?=
 =?us-ascii?Q?1c2G9/hHdOy0Wf4o2bjY8bKX990I2nrB2dVIsQd/W8cwtaR5wwBFeThbq7rR?=
 =?us-ascii?Q?/ZgOMTd7oQVawpTma1I7pDlmiHhKuPuasLVMyd79SVRAJATKcmk+FAaqBXht?=
 =?us-ascii?Q?Dl1x0xdgJjohSyC6jC04NYNRcnJBMnVmkjQeTs03X+4hWBMxFu4Ex0MIoGD6?=
 =?us-ascii?Q?IzOHdtFvoB2dugS8fd5yGqA1/fTlYaWy0mg3acoU4gpv5U61cqnO+gH8KZin?=
 =?us-ascii?Q?DNm22DdeQsts9I1xJdbUQn2CP8p3ryyMl/toEHPqgq0gcVgHrv3A6mMOD/KW?=
 =?us-ascii?Q?kZJoHCouphVBdHtftr86ZDFWO/ZBI/lalB2N8iPR9Tepw2qK6WIkxJlyBfxD?=
 =?us-ascii?Q?mcBOStGFaBvWjRcvabspMPORxguwWXkLeRgk9O0DetPEL8BeoMw4ezk6mt/X?=
 =?us-ascii?Q?gswXhJmHV9u3h1hedp8QkFBIyosWJHhixIB+Ib1L8jwqo73fnuyIFNobEWoz?=
 =?us-ascii?Q?DepX7gBvqn7c0GdR/zc/MPI6EDwvAPeVjMzyMBaI0C8gvsReKZZXE2tUYSH1?=
 =?us-ascii?Q?UZ36DymIBBMmym08MfKHCCinuiYQAE+DJ5Mgsg6tdNqb2Wj2yH+NTy3wR6jK?=
 =?us-ascii?Q?o+vUgW/PyNXBHeELih41zXNVHxFumKLQWGRzYRem9pN9+fkuuUvIOkR/BVLT?=
 =?us-ascii?Q?sDgjzW4GhNBwCdznuP5jHSbK/e2y7DlHGdQpa7YgUtzrntmMrIUEPXBKpcXf?=
 =?us-ascii?Q?BYIUS6hwB36BS/4/afdhTIyg5ZQSz1lKwDPzGOqOsITITtGs8RKwBzrYd2oK?=
 =?us-ascii?Q?0bL5sPMMlF3sP+m89C9+pxJVr8p3G1CyDDNd6FLGQu8KtcA7NfS2pDXgTrGg?=
 =?us-ascii?Q?YccoljJe83ki0fPQtXFVP+SZgnxKwthAVL34/hMsbojZAxgHKjLxehVlCsD7?=
 =?us-ascii?Q?E7IzbMnYKnudgWZ3Y7yuw7M3M84BZQQ5w41gb+orYBgNHUmNKYNnBJNlPmfR?=
 =?us-ascii?Q?GjjfhmoMvPWRandy2mDPZUysWB3X6uaJOd/k+dvoQXWp4yYc7USGwkMKtRMp?=
 =?us-ascii?Q?l9QcDu7sEqAsRVBBRKn0LR0fdep5rSfoePmKWBVZ4MjfpEE42Q+mpL/EUHvv?=
 =?us-ascii?Q?n2QSkzqJgnu7e4RoAwyRhcH5Rom1JdFZpN6LVOhmoEPqO346twSQ5jnL3Sg+?=
 =?us-ascii?Q?ZxelMPQX4d7iWk3k9HvhpoSSV/BQkVNFUMpi/sjjiNNkkufncIWH9HwGtPt/?=
 =?us-ascii?Q?Rl2hVKHBASc3pgliha7Xu/a3N1Jzq25LRBUnRnjOxapRqCzGcT5tEH8kfxDP?=
 =?us-ascii?Q?F0Ui2myRPH51qQCm7ByvKyvGHYUG8Kc2cE1Tm5n3dv894Wkmi+9JtmnDcJ71?=
 =?us-ascii?Q?gPB2rz5J4EsYHM/1FjBW2SU08MiM2asFsAJWwIWL5HrjN4IF314s1H11L/sr?=
 =?us-ascii?Q?hKDiKdnP46ghfQghKHarRA2pQn4c+WNoWAFL62d2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f89b955d-5a13-4e81-f7ba-08dde0c6609e
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 15:21:18.6900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /GeXuImO5q0uIyVD+Rv2F8/iF7ujTTbidnzZHAVzM3SIIOjx2p/ML0sNaRnPOgVWvyPwvUNyJdS/7ZY9PILsiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10809

Establish a more intuitive function naming convention in this driver.
A GenX PHY must only call aqr_genY_ functions, where Y <= X.

Loosely speaking, aqr107_ is representative of Gen2 and above, except for:
- aqr107_config_init()
- aqr107_suspend()
- aqr107_resume()
- aqr107_wait_processor_intensive_op()

which are also called by AQR105, so these are renamed to Gen1.

Actually aqr107_config_init() is renamed to aqr_gen1_config_init() when
called by AQR105, and aqr_gen2_config_init() when called by all other
PHYs. The Gen2 function calls the Gen1 function, so there is no
functional change. This prefaces further Gen2-specific initialization
steps which must be omitted for AQR105. These will be added to
aqr_gen2_config_init().

In fact, many PHY drivers call an aqr*_config_init() beneath their
generation's feature set: AQR114C is a Gen4 PHY which calls
aqr_gen2_config_init(), even though AQR113C, also a Gen4 PHY which
differs only in maximum link speed, calls the richer
aqr113c_config_init() which also sets phydev->possible_interfaces.
Many of the more subtle inconsistencies of this kind will be fixed up in
later changes.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/phy/aquantia/aquantia_main.c | 117 ++++++++++++-----------
 1 file changed, 61 insertions(+), 56 deletions(-)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index 7ac0b685a317..8136f7843a37 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -811,7 +811,7 @@ static int aqr107_config_mdi(struct phy_device *phydev)
 			      mdi_conf | PMAPMD_RSVD_VEND_PROV_MDI_FORCE);
 }
 
-static int aqr107_config_init(struct phy_device *phydev)
+static int aqr_gen1_config_init(struct phy_device *phydev)
 {
 	struct aqr107_priv *priv = phydev->priv;
 	u32 led_idx;
@@ -860,6 +860,11 @@ static int aqr107_config_init(struct phy_device *phydev)
 	return 0;
 }
 
+static int aqr_gen2_config_init(struct phy_device *phydev)
+{
+	return aqr_gen1_config_init(phydev);
+}
+
 static int aqcs109_config_init(struct phy_device *phydev)
 {
 	int ret;
@@ -921,7 +926,7 @@ static void aqr107_link_change_notify(struct phy_device *phydev)
 		phydev_info(phydev, "Aquantia 1000Base-T2 mode active\n");
 }
 
-static int aqr107_wait_processor_intensive_op(struct phy_device *phydev)
+static int aqr_gen1_wait_processor_intensive_op(struct phy_device *phydev)
 {
 	int val, err;
 
@@ -945,8 +950,8 @@ static int aqr107_wait_processor_intensive_op(struct phy_device *phydev)
 	return 0;
 }
 
-static int aqr107_get_rate_matching(struct phy_device *phydev,
-				    phy_interface_t iface)
+static int aqr_gen2_get_rate_matching(struct phy_device *phydev,
+				      phy_interface_t iface)
 {
 	if (iface == PHY_INTERFACE_MODE_10GBASER ||
 	    iface == PHY_INTERFACE_MODE_2500BASEX ||
@@ -955,7 +960,7 @@ static int aqr107_get_rate_matching(struct phy_device *phydev,
 	return RATE_MATCH_NONE;
 }
 
-static int aqr107_suspend(struct phy_device *phydev)
+static int aqr_gen1_suspend(struct phy_device *phydev)
 {
 	int err;
 
@@ -964,10 +969,10 @@ static int aqr107_suspend(struct phy_device *phydev)
 	if (err)
 		return err;
 
-	return aqr107_wait_processor_intensive_op(phydev);
+	return aqr_gen1_wait_processor_intensive_op(phydev);
 }
 
-static int aqr107_resume(struct phy_device *phydev)
+static int aqr_gen1_resume(struct phy_device *phydev)
 {
 	int err;
 
@@ -976,7 +981,7 @@ static int aqr107_resume(struct phy_device *phydev)
 	if (err)
 		return err;
 
-	return aqr107_wait_processor_intensive_op(phydev);
+	return aqr_gen1_wait_processor_intensive_op(phydev);
 }
 
 static const u16 aqr_global_cfg_regs[] = {
@@ -988,7 +993,7 @@ static const u16 aqr_global_cfg_regs[] = {
 	VEND1_GLOBAL_CFG_10G
 };
 
-static int aqr107_fill_interface_modes(struct phy_device *phydev)
+static int aqr_gen2_fill_interface_modes(struct phy_device *phydev)
 {
 	unsigned long *possible = phydev->possible_interfaces;
 	struct aqr107_priv *priv = phydev->priv;
@@ -1089,11 +1094,11 @@ static int aqr113c_config_init(struct phy_device *phydev)
 
 	priv->wait_on_global_cfg = true;
 
-	ret = aqr107_config_init(phydev);
+	ret = aqr_gen2_config_init(phydev);
 	if (ret < 0)
 		return ret;
 
-	ret = aqr107_fill_interface_modes(phydev);
+	ret = aqr_gen2_fill_interface_modes(phydev);
 	if (ret)
 		return ret;
 
@@ -1102,7 +1107,7 @@ static int aqr113c_config_init(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	return aqr107_wait_processor_intensive_op(phydev);
+	return aqr_gen1_wait_processor_intensive_op(phydev);
 }
 
 static int aqr107_probe(struct phy_device *phydev)
@@ -1144,13 +1149,13 @@ static struct phy_driver aqr_driver[] = {
 	.name		= "Aquantia AQR105",
 	.get_features	= aqr105_get_features,
 	.probe		= aqr107_probe,
-	.config_init	= aqr107_config_init,
+	.config_init	= aqr_gen1_config_init,
 	.config_aneg    = aqr105_config_aneg,
 	.config_intr	= aqr_config_intr,
 	.handle_interrupt = aqr_handle_interrupt,
 	.read_status	= aqr105_read_status,
-	.suspend	= aqr107_suspend,
-	.resume		= aqr107_resume,
+	.suspend	= aqr_gen1_suspend,
+	.resume		= aqr_gen1_resume,
 },
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR106),
@@ -1164,16 +1169,16 @@ static struct phy_driver aqr_driver[] = {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR107),
 	.name		= "Aquantia AQR107",
 	.probe		= aqr107_probe,
-	.get_rate_matching = aqr107_get_rate_matching,
-	.config_init	= aqr107_config_init,
+	.get_rate_matching = aqr_gen2_get_rate_matching,
+	.config_init	= aqr_gen2_config_init,
 	.config_aneg    = aqr_config_aneg,
 	.config_intr	= aqr_config_intr,
 	.handle_interrupt = aqr_handle_interrupt,
 	.read_status	= aqr107_read_status,
 	.get_tunable    = aqr107_get_tunable,
 	.set_tunable    = aqr107_set_tunable,
-	.suspend	= aqr107_suspend,
-	.resume		= aqr107_resume,
+	.suspend	= aqr_gen1_suspend,
+	.resume		= aqr_gen1_resume,
 	.get_sset_count	= aqr107_get_sset_count,
 	.get_strings	= aqr107_get_strings,
 	.get_stats	= aqr107_get_stats,
@@ -1188,7 +1193,7 @@ static struct phy_driver aqr_driver[] = {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQCS109),
 	.name		= "Aquantia AQCS109",
 	.probe		= aqr107_probe,
-	.get_rate_matching = aqr107_get_rate_matching,
+	.get_rate_matching = aqr_gen2_get_rate_matching,
 	.config_init	= aqcs109_config_init,
 	.config_aneg    = aqr_config_aneg,
 	.config_intr	= aqr_config_intr,
@@ -1196,8 +1201,8 @@ static struct phy_driver aqr_driver[] = {
 	.read_status	= aqr107_read_status,
 	.get_tunable    = aqr107_get_tunable,
 	.set_tunable    = aqr107_set_tunable,
-	.suspend	= aqr107_suspend,
-	.resume		= aqr107_resume,
+	.suspend	= aqr_gen1_suspend,
+	.resume		= aqr_gen1_resume,
 	.get_sset_count	= aqr107_get_sset_count,
 	.get_strings	= aqr107_get_strings,
 	.get_stats	= aqr107_get_stats,
@@ -1213,16 +1218,16 @@ static struct phy_driver aqr_driver[] = {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR111),
 	.name		= "Aquantia AQR111",
 	.probe		= aqr107_probe,
-	.get_rate_matching = aqr107_get_rate_matching,
-	.config_init	= aqr107_config_init,
+	.get_rate_matching = aqr_gen2_get_rate_matching,
+	.config_init	= aqr_gen2_config_init,
 	.config_aneg    = aqr_config_aneg,
 	.config_intr	= aqr_config_intr,
 	.handle_interrupt = aqr_handle_interrupt,
 	.read_status	= aqr107_read_status,
 	.get_tunable    = aqr107_get_tunable,
 	.set_tunable    = aqr107_set_tunable,
-	.suspend	= aqr107_suspend,
-	.resume		= aqr107_resume,
+	.suspend	= aqr_gen1_suspend,
+	.resume		= aqr_gen1_resume,
 	.get_sset_count	= aqr107_get_sset_count,
 	.get_strings	= aqr107_get_strings,
 	.get_stats	= aqr107_get_stats,
@@ -1238,16 +1243,16 @@ static struct phy_driver aqr_driver[] = {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR111B0),
 	.name		= "Aquantia AQR111B0",
 	.probe		= aqr107_probe,
-	.get_rate_matching = aqr107_get_rate_matching,
-	.config_init	= aqr107_config_init,
+	.get_rate_matching = aqr_gen2_get_rate_matching,
+	.config_init	= aqr_gen2_config_init,
 	.config_aneg    = aqr_config_aneg,
 	.config_intr	= aqr_config_intr,
 	.handle_interrupt = aqr_handle_interrupt,
 	.read_status	= aqr107_read_status,
 	.get_tunable    = aqr107_get_tunable,
 	.set_tunable    = aqr107_set_tunable,
-	.suspend	= aqr107_suspend,
-	.resume		= aqr107_resume,
+	.suspend	= aqr_gen1_suspend,
+	.resume		= aqr_gen1_resume,
 	.get_sset_count	= aqr107_get_sset_count,
 	.get_strings	= aqr107_get_strings,
 	.get_stats	= aqr107_get_stats,
@@ -1276,10 +1281,10 @@ static struct phy_driver aqr_driver[] = {
 	.handle_interrupt = aqr_handle_interrupt,
 	.get_tunable    = aqr107_get_tunable,
 	.set_tunable    = aqr107_set_tunable,
-	.suspend	= aqr107_suspend,
-	.resume		= aqr107_resume,
+	.suspend	= aqr_gen1_suspend,
+	.resume		= aqr_gen1_resume,
 	.read_status	= aqr107_read_status,
-	.get_rate_matching = aqr107_get_rate_matching,
+	.get_rate_matching = aqr_gen2_get_rate_matching,
 	.get_sset_count = aqr107_get_sset_count,
 	.get_strings	= aqr107_get_strings,
 	.get_stats	= aqr107_get_stats,
@@ -1299,10 +1304,10 @@ static struct phy_driver aqr_driver[] = {
 	.handle_interrupt = aqr_handle_interrupt,
 	.get_tunable    = aqr107_get_tunable,
 	.set_tunable    = aqr107_set_tunable,
-	.suspend	= aqr107_suspend,
-	.resume		= aqr107_resume,
+	.suspend	= aqr_gen1_suspend,
+	.resume		= aqr_gen1_resume,
 	.read_status	= aqr107_read_status,
-	.get_rate_matching = aqr107_get_rate_matching,
+	.get_rate_matching = aqr_gen2_get_rate_matching,
 	.get_sset_count = aqr107_get_sset_count,
 	.get_strings	= aqr107_get_strings,
 	.get_stats	= aqr107_get_stats,
@@ -1317,10 +1322,10 @@ static struct phy_driver aqr_driver[] = {
 	.handle_interrupt = aqr_handle_interrupt,
 	.get_tunable    = aqr107_get_tunable,
 	.set_tunable    = aqr107_set_tunable,
-	.suspend	= aqr107_suspend,
-	.resume		= aqr107_resume,
+	.suspend	= aqr_gen1_suspend,
+	.resume		= aqr_gen1_resume,
 	.read_status	= aqr107_read_status,
-	.get_rate_matching = aqr107_get_rate_matching,
+	.get_rate_matching = aqr_gen2_get_rate_matching,
 	.get_sset_count = aqr107_get_sset_count,
 	.get_strings	= aqr107_get_strings,
 	.get_stats	= aqr107_get_stats,
@@ -1330,7 +1335,7 @@ static struct phy_driver aqr_driver[] = {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR113),
 	.name		= "Aquantia AQR113",
 	.probe          = aqr107_probe,
-	.get_rate_matching = aqr107_get_rate_matching,
+	.get_rate_matching = aqr_gen2_get_rate_matching,
 	.config_init    = aqr113c_config_init,
 	.config_aneg    = aqr_config_aneg,
 	.config_intr    = aqr_config_intr,
@@ -1338,8 +1343,8 @@ static struct phy_driver aqr_driver[] = {
 	.read_status    = aqr107_read_status,
 	.get_tunable    = aqr107_get_tunable,
 	.set_tunable    = aqr107_set_tunable,
-	.suspend        = aqr107_suspend,
-	.resume         = aqr107_resume,
+	.suspend        = aqr_gen1_suspend,
+	.resume         = aqr_gen1_resume,
 	.get_sset_count = aqr107_get_sset_count,
 	.get_strings    = aqr107_get_strings,
 	.get_stats      = aqr107_get_stats,
@@ -1354,7 +1359,7 @@ static struct phy_driver aqr_driver[] = {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR113C),
 	.name           = "Aquantia AQR113C",
 	.probe          = aqr107_probe,
-	.get_rate_matching = aqr107_get_rate_matching,
+	.get_rate_matching = aqr_gen2_get_rate_matching,
 	.config_init    = aqr113c_config_init,
 	.config_aneg    = aqr_config_aneg,
 	.config_intr    = aqr_config_intr,
@@ -1362,8 +1367,8 @@ static struct phy_driver aqr_driver[] = {
 	.read_status    = aqr107_read_status,
 	.get_tunable    = aqr107_get_tunable,
 	.set_tunable    = aqr107_set_tunable,
-	.suspend        = aqr107_suspend,
-	.resume         = aqr107_resume,
+	.suspend        = aqr_gen1_suspend,
+	.resume         = aqr_gen1_resume,
 	.get_sset_count = aqr107_get_sset_count,
 	.get_strings    = aqr107_get_strings,
 	.get_stats      = aqr107_get_stats,
@@ -1378,16 +1383,16 @@ static struct phy_driver aqr_driver[] = {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR114C),
 	.name           = "Aquantia AQR114C",
 	.probe          = aqr107_probe,
-	.get_rate_matching = aqr107_get_rate_matching,
-	.config_init    = aqr107_config_init,
+	.get_rate_matching = aqr_gen2_get_rate_matching,
+	.config_init    = aqr_gen2_config_init,
 	.config_aneg    = aqr_config_aneg,
 	.config_intr    = aqr_config_intr,
 	.handle_interrupt = aqr_handle_interrupt,
 	.read_status    = aqr107_read_status,
 	.get_tunable    = aqr107_get_tunable,
 	.set_tunable    = aqr107_set_tunable,
-	.suspend        = aqr107_suspend,
-	.resume         = aqr107_resume,
+	.suspend        = aqr_gen1_suspend,
+	.resume         = aqr_gen1_resume,
 	.get_sset_count = aqr107_get_sset_count,
 	.get_strings    = aqr107_get_strings,
 	.get_stats      = aqr107_get_stats,
@@ -1403,7 +1408,7 @@ static struct phy_driver aqr_driver[] = {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR115C),
 	.name           = "Aquantia AQR115C",
 	.probe          = aqr107_probe,
-	.get_rate_matching = aqr107_get_rate_matching,
+	.get_rate_matching = aqr_gen2_get_rate_matching,
 	.config_init    = aqr113c_config_init,
 	.config_aneg    = aqr_config_aneg,
 	.config_intr    = aqr_config_intr,
@@ -1411,8 +1416,8 @@ static struct phy_driver aqr_driver[] = {
 	.read_status    = aqr107_read_status,
 	.get_tunable    = aqr107_get_tunable,
 	.set_tunable    = aqr107_set_tunable,
-	.suspend        = aqr107_suspend,
-	.resume         = aqr107_resume,
+	.suspend        = aqr_gen1_suspend,
+	.resume         = aqr_gen1_resume,
 	.get_sset_count = aqr107_get_sset_count,
 	.get_strings    = aqr107_get_strings,
 	.get_stats      = aqr107_get_stats,
@@ -1428,16 +1433,16 @@ static struct phy_driver aqr_driver[] = {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR813),
 	.name		= "Aquantia AQR813",
 	.probe		= aqr107_probe,
-	.get_rate_matching = aqr107_get_rate_matching,
-	.config_init	= aqr107_config_init,
+	.get_rate_matching = aqr_gen2_get_rate_matching,
+	.config_init	= aqr_gen2_config_init,
 	.config_aneg    = aqr_config_aneg,
 	.config_intr	= aqr_config_intr,
 	.handle_interrupt = aqr_handle_interrupt,
 	.read_status	= aqr107_read_status,
 	.get_tunable    = aqr107_get_tunable,
 	.set_tunable    = aqr107_set_tunable,
-	.suspend	= aqr107_suspend,
-	.resume		= aqr107_resume,
+	.suspend	= aqr_gen1_suspend,
+	.resume		= aqr_gen1_resume,
 	.get_sset_count	= aqr107_get_sset_count,
 	.get_strings	= aqr107_get_strings,
 	.get_stats	= aqr107_get_stats,
-- 
2.34.1


