Return-Path: <netdev+bounces-231994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B3CBFF7AC
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 09:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A580B3A82DB
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 07:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830ED2D24A3;
	Thu, 23 Oct 2025 07:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ALbDh78h"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010000.outbound.protection.outlook.com [52.101.84.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6179A2D3A75;
	Thu, 23 Oct 2025 07:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203791; cv=fail; b=oVJwbmLzmnqtnvPuzp6/A3QmoeNgSu/HypmouRyArMUAAg6Tyeo2IVx5VhQWLEfGtrLMZNlHB+QQusGPg1bDZBNe7fcwnz1FNYvZJYMCOkMAxOqImw9mZ9e4FVaE47RxDETnvCF6k2YPrLCgUvqFXlFwL9urHaYdT4tkWHEmFlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203791; c=relaxed/simple;
	bh=9qqKj2GjWNKQNsDiG7Au4onpfWPg3fhktpAlBFOmm4w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m/hJQ/35JGQuGxPwxKKFhs66VpIYPVm14tBMz0Gm3XplLEB95xchpOpukHXpAtIz6051IirlET5wSOeS0RGlPBqyGlOTT5seDm6n8N2SSL+2FzRjLI1DSTO6K4mFLT0hnkuo3ACfWPY5I0j14PUETubW1qe9cKEUDQiDEdyfFrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ALbDh78h; arc=fail smtp.client-ip=52.101.84.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fIwnvT9QF4rvsRZC2FkKDNvTSACR802+bm+S2GEUBxlyCw5cYkaSTvPZfPO3q2yHRL0zs1yyWdzPk8OdJxov2R9EsHtDMdDNmT37jiVymzt1Hc8vuTqxbzftJmi0sYW2q6bxOhjfMCA61LLvR1AN+PhQe8kgJy4YBg0OpfP0S8Jg3KcIBtyo9hj5LdQvwo747T9cIjWcWCbTKiIoz1k8DdvxS+sX9SFovQFVMXgOCpI2YgSoIjQ33KsbqL4dELQKpnyx88UHbIR6VByxMZgUjuef2Vhv080A9Vv3lUs8kePyBgVRR3bL7yL2az7he42CDdcB+IKxkVXTSfQj5Un4Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qiUrGi9TQQwHGsE7rP3rBaGXmmRPYTcCEruWUXZjRuM=;
 b=audj5ZSXBxvq7wyVSsKsHqKemKsHboBC7qHV4LdWqwA3TUCzKofeYFgSmLE2urUChO/z7GuIp6z710lXxYOwHrLzTb2ez1mdRH+qSwsiftg6aCAu0ld1de5jJp5Tg5ERP7k1sC4CYkK06289IjE2qzEk6C0CnnX8Tmj14NCwrk1yG7aeItPBAXjKc5XghVYxlivU7fEkmF2yRm/zdn2cqg+dlrC9Lw4RTR8R/ojHHkvOH/L/NYseSWQxjLFn27sI2UDifIl7pYvlISwJqgVVzYZL55cFmzKaEXGVK0/zYg9+YZkpEHH2/X8FWr6PCERL8O54FRjKGQNPAJMjmIywqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qiUrGi9TQQwHGsE7rP3rBaGXmmRPYTcCEruWUXZjRuM=;
 b=ALbDh78hf4U+Hp167F62zaE/cTtCYuBz/t7vx8hE6UWQNFheHF0ZexGX+xAM+dljx5cuC4fPzRFcsid9OUNI7GnUlRn7knLs7UEfVKVFr5DCkVlicaXd5nTXBpL61TShMYSZa68ziTv23ao40/liq4gvL8eE0XJBqwqO67SIOhV+W9eLqWZSQF0hoidAwJ3x4AYrSNSyI8kELeO6jBh/n9TOK0JPgUth5Uveko89Ih6Ce06ixlI+hXTm9CuQYDLf/GPyjpO+y4W74k6Ct2g1TsQcJme7nXhPhoMm2HccyUZF8WdcM2Zil+FMd+hD0ky6KB4+qOOahL07kTeRIl2+0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU2PR04MB8853.eurprd04.prod.outlook.com (2603:10a6:10:2e0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 07:16:25 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 07:16:25 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	Frank.Li@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 net-next 3/6] net: enetc: add preliminary i.MX94 NETC blocks control support
Date: Thu, 23 Oct 2025 14:54:13 +0800
Message-Id: <20251023065416.30404-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251023065416.30404-1-wei.fang@nxp.com>
References: <20251023065416.30404-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0243.apcprd06.prod.outlook.com
 (2603:1096:4:ac::27) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DU2PR04MB8853:EE_
X-MS-Office365-Filtering-Correlation-Id: 938334c3-eb91-4fe3-80a8-08de120413be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|52116014|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3Z8wiRRjTnsBBF+H+voGpVxKLQoN2BtBZGS8x/133d15prblmg5vP0Pp22MU?=
 =?us-ascii?Q?LU4LlkJoVWsazGoe6V7fYpFFSS2qT9HIq1bVIsOX3ACzMG7TDMo535hihVZd?=
 =?us-ascii?Q?coH42hoHP6q9esOhZIcX+saz45sfkA6FcaXpkf4VzBnP9FNZDc+12FFJ4m9Z?=
 =?us-ascii?Q?GI9icSk/AOBvsMYiPyhmv+jZXL1XU6DDRld9+PSnQlQVrSrrFWmWV4N8Chfj?=
 =?us-ascii?Q?JkFO6sZV/cuzpELV46h7WdhqiRBW7MZnQgUMtQ6ReYLgq2YYo0Dk7f41OnRV?=
 =?us-ascii?Q?pKT/JTOsAcream1OQm3LGK7558Cq3CxSekXIYukVdXyoqFADUTbwRHljvg/1?=
 =?us-ascii?Q?GCPmOt4DLNCcsYmi1KRcFmxpVUQzAnNcL2R80qKjr4DTeyIBjLBsSd2cmN93?=
 =?us-ascii?Q?p8Ije+2nF8f3eflqcGkku6tBgIAFGNUcI0aaLRT4YNmtckAgIBZL79QIZYdu?=
 =?us-ascii?Q?ShaU319SA/oNW0D1ZHef08zaYdmEALnQK3ZYvQcLzBXnrJ4oViMLz6ndYrmI?=
 =?us-ascii?Q?sOPL/VyXz3z4TlIhyP7iA5JW69zwlRoR0LbZ711/+SRNQUAAW1Hy4T/JeYtH?=
 =?us-ascii?Q?kxMRiOGMaRvDm8HjxR28lBIUb46dBx7RhuHNw1R9lr3Tk7OxHWG//6+UAOie?=
 =?us-ascii?Q?JwZUqESCOMBWnNTnijtanLP4rQsb1De0DlFIRjIpt7J27pcpTJwGmJADGkGO?=
 =?us-ascii?Q?CLeYRrqOtCiH/CDfwQSUq+eWlrahcODUd8NnrSTfTviDiFBBlM5iC5WV3dkt?=
 =?us-ascii?Q?WXZH56Uz16TbhxFUknWTvzqHIFYXXVOCDdL0m8cdro6ZdIMTNQ1ruCbRivJ7?=
 =?us-ascii?Q?OBtkRMOjStfc0kw+3RPMErkewDCgtad5VWYXZuThNGKE4GagBijdRcwv+lEc?=
 =?us-ascii?Q?g2tc/5HuE9D6y0V+q4n7KZGcCqRjVQTYoEbI0TlfP8l3XbUQaFhIAY/8GkiK?=
 =?us-ascii?Q?fX7f35hFkLmvOa4HllfguSSCFLCAnutpaPxbgQPU1AjdXdcxNYYCj4/ObvQ/?=
 =?us-ascii?Q?OiGAObz+m11hUnKopd5wDiCZwhn9AYQ4GRA7r3IGGqqhrGB94mAK5vkin98T?=
 =?us-ascii?Q?YJgu5etCVqFTqJ2yL1A52uEfrV1tuFD06C1e0BCU7NKZT4MaxMjUm4mARcMH?=
 =?us-ascii?Q?pywQq5WO2nZ7l46r053l8Q4amLZoRF5H6M24xFITzXTVFUvjfHbNhJNHTA4s?=
 =?us-ascii?Q?fvIYT8EupjX5Q/RC/zcfJ79GjYKfEpb+vbOiFm3HBQgjHjQM0bRk6vKEBkrg?=
 =?us-ascii?Q?AXiCp51WJ1WoYHr9Sh9ITbjboBBf31G99RQpKoEw1+TNoVZyMDGcc6kJoF1w?=
 =?us-ascii?Q?DNd+SPi85agv0Ya6xXY2ZM0OYtm1ZYEJyA0Iz7jzddveGfhC6fBgAx2S6c0t?=
 =?us-ascii?Q?W/syv8eGm9X8CEePy2lNCRiQna7b/0uJYkyNPS7tRz5wXeJJb2gbv9b4gwAF?=
 =?us-ascii?Q?AHe7B2weWHTS+Mgx4gCm+RuXCOTm6/nooPXafkykK3YSqTjZ97367g5YDKQ4?=
 =?us-ascii?Q?MYco5a99JR3h37Vjm8OYPO0wdUlwD5TpZDFrHqXlJgd/ypg5LP+RFNXdaw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(52116014)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ITEqlmLNrB+NdWPK/nA/li8onuwBPYJr6q1wW23TQCoDdoZrERg/RINl9v+6?=
 =?us-ascii?Q?DdKt/TIwUh//MPeM3422qLy92pDMasdW2Wl1OyvnHM/G4xOYFGe/iIKkUFXz?=
 =?us-ascii?Q?rEa3Ca1Wel+gGJ1sbLSatBag5GUxBHBqMh4L3EXWf+AsNBpnDOoH7seX6uww?=
 =?us-ascii?Q?xwPzmIr4Hcr2BnMW0p44mypTIWiYU+e3qc8pEFYFd6zT/aRgJUiF2fcCdNSp?=
 =?us-ascii?Q?rrQ17TRnT/FwRsBrJKhrNmdOTYNP2TDivkjpcX5PW209CNN69Y7K9LPSPeCu?=
 =?us-ascii?Q?5XWI+bw+lcpfLMiLyQBAOIh0xQvp7dUAsEptNlOELGhtHRtorRw8OTHtE31U?=
 =?us-ascii?Q?5kD47yUUXLaD9+jBjUkzyXx0U6g3u2led2xr56faM7pPZHDCjULtld4wT2ad?=
 =?us-ascii?Q?MHeJ/ivx+wpq7CDGm1wxaCU6TTQiPSAhKKCPFDdNG5jovjNpz+KKoG8FfLgZ?=
 =?us-ascii?Q?gGCXOINbN69yGU79nRsJX1SwfOSGxy/29O4eTCucBpbpdGsKbgPJH6CYfbYY?=
 =?us-ascii?Q?3jlVKGecfNAQI9UHaYgKcSFZfecfPVVpF5QJ3FiqSP+nh7tk+g03FJcRbQ6+?=
 =?us-ascii?Q?PdgDGv4yqxsFLEttYJulh37AuUQxdnkIOVc4c2YLQrrnI16xtvc7NwcmiOCG?=
 =?us-ascii?Q?Ycn2BIbKkSE7bFlDaQtmk8RsMSHVswfEo4ZIRRGTddTKGvu0Vtp9AXGqHNDe?=
 =?us-ascii?Q?EVdhhl/pOOPM1+X8xe8WaxFwMB/tSd0oMewxJPN1WWThy9Xix9O5DZgH3ms5?=
 =?us-ascii?Q?v6z6owrt8Uu5lQb/YG+bNzNYqlWwDtOk8c15Lu+7U/ao+MDO/3UEGbePZedr?=
 =?us-ascii?Q?AzptGP2Ml1FSJhYO/4XxHc8UWLaIluwmk83remYznLOHPCIDsd2PVBdJE9WO?=
 =?us-ascii?Q?68NTtna13otmtNrOeAbv4XlBh0XelEyomsf4rVqEFooFzk4JwoxlT9mBbPlR?=
 =?us-ascii?Q?4KTzLQLYxSQcmmJ0OtiD9vQhEfa658MJRwH9J0RZmj/eXVuLK49JonK1LRsA?=
 =?us-ascii?Q?FKtEDm7ghJq4ZjYjNNkRXX1j5RG+hbTSgYaSUvWYwDCoj2UQHmAiW/7e27sk?=
 =?us-ascii?Q?OlS6vbBKtQ5rwCTVPuDi4rqSYJ61dePRIzLIvNVPHjmiwF184vpWdNQOUPmM?=
 =?us-ascii?Q?v5svLPID++EYahnb93yKpXtYp+bU8GyJbDmyv0L6tgasLfJV0/OwuiUZ1l9x?=
 =?us-ascii?Q?bEx0VF8AnDjXuG9f/AlvJBkK+63bnFqg72Oi866ol8T3yEBDeS8yPJxwUdF2?=
 =?us-ascii?Q?XQGjiwFteYzuStrhG20GaN6R5vkkVrlZzk03yJk4tOT8R4MlLx0hdokSoZph?=
 =?us-ascii?Q?M1K9sDNi4nTf2xsQyO8GWq/fa6xeqIMrDDaR+Zpq2h6WTt5Q5DVnurEOU6rS?=
 =?us-ascii?Q?ejW5Pnxa97WJFJOaZWk2zDnD9ORvjANYLkfJhMhAmML3FtUcHkIVErzrSFgK?=
 =?us-ascii?Q?V6smclACSOPKMf2Zyqop/lQvi3zd7lT550r/HL2o0ESyzqSGw2YiMN+XMXTb?=
 =?us-ascii?Q?BqdFap+DXUk5bYOxKZZiUxTk54dEzPNFMrGtp1yRl8rw16PucsbrC7GdhoH1?=
 =?us-ascii?Q?7QySDODVOK1THOpqxHOvCp8yLPIKDe5Fe4C+2P9N?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 938334c3-eb91-4fe3-80a8-08de120413be
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 07:16:25.6833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nUX9IBf7XBsqxp0JTRc8ehYCMjuILkG0CX99L0y4vr9GKkR4SFQJMDiBvRIWtk+iqM4xRXxJHNUEXe/6Ey8vxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8853

NETC blocks control is used for warm reset and pre-boot initialization.
Different versions of NETC blocks control are not exactly the same. We
need to add corresponding netc_devinfo data for each version. The NETC
version of i.MX94 is v4.3, which is different from i.MX95. Currently,
the patch adds the following configurations for ENETCs.

1. Set the link's MII protocol.
2. ENETC 0 (MAC 3) and the switch port 2 (MAC 2) share the same parallel
interface, but due to SoC constraint, they cannot be used simultaneously.
Since the switch is not supported yet, so the interface is assigned to
ENETC 0 by default.

The switch configuration will be added separately in a subsequent patch.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../ethernet/freescale/enetc/netc_blk_ctrl.c  | 104 ++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
index bcb8eefeb93c..5978ea096e80 100644
--- a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
+++ b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
@@ -47,6 +47,13 @@
 #define PCS_PROT_SFI			BIT(4)
 #define PCS_PROT_10G_SXGMII		BIT(6)
 
+#define IMX94_EXT_PIN_CONTROL		0x10
+#define  MAC2_MAC3_SEL			BIT(1)
+
+#define IMX94_NETC_LINK_CFG(a)		(0x4c + (a) * 4)
+#define  NETC_LINK_CFG_MII_PROT		GENMASK(3, 0)
+#define  NETC_LINK_CFG_IO_VAR		GENMASK(19, 16)
+
 /* NETC privileged register block register */
 #define PRB_NETCRR			0x100
 #define  NETCRR_SR			BIT(0)
@@ -68,6 +75,13 @@
 #define IMX95_ENETC1_BUS_DEVFN		0x40
 #define IMX95_ENETC2_BUS_DEVFN		0x80
 
+#define IMX94_ENETC0_BUS_DEVFN		0x100
+#define IMX94_ENETC1_BUS_DEVFN		0x140
+#define IMX94_ENETC2_BUS_DEVFN		0x180
+#define IMX94_ENETC0_LINK		3
+#define IMX94_ENETC1_LINK		4
+#define IMX94_ENETC2_LINK		5
+
 /* Flags for different platforms */
 #define NETC_HAS_NETCMIX		BIT(0)
 
@@ -192,6 +206,90 @@ static int imx95_netcmix_init(struct platform_device *pdev)
 	return 0;
 }
 
+static int imx94_enetc_get_link_id(struct device_node *np)
+{
+	int bus_devfn = netc_of_pci_get_bus_devfn(np);
+
+	/* Parse ENETC link number */
+	switch (bus_devfn) {
+	case IMX94_ENETC0_BUS_DEVFN:
+		return IMX94_ENETC0_LINK;
+	case IMX94_ENETC1_BUS_DEVFN:
+		return IMX94_ENETC1_LINK;
+	case IMX94_ENETC2_BUS_DEVFN:
+		return IMX94_ENETC2_LINK;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int imx94_link_config(struct netc_blk_ctrl *priv,
+			     struct device_node *np, int link_id)
+{
+	phy_interface_t interface;
+	int mii_proto;
+	u32 val;
+
+	/* The node may be disabled and does not have a 'phy-mode'
+	 * or 'phy-connection-type' property.
+	 */
+	if (of_get_phy_mode(np, &interface))
+		return 0;
+
+	mii_proto = netc_get_link_mii_protocol(interface);
+	if (mii_proto < 0)
+		return mii_proto;
+
+	val = mii_proto & NETC_LINK_CFG_MII_PROT;
+	if (val == MII_PROT_SERIAL)
+		val = u32_replace_bits(val, IO_VAR_16FF_16G_SERDES,
+				       NETC_LINK_CFG_IO_VAR);
+
+	netc_reg_write(priv->netcmix, IMX94_NETC_LINK_CFG(link_id), val);
+
+	return 0;
+}
+
+static int imx94_enetc_link_config(struct netc_blk_ctrl *priv,
+				   struct device_node *np)
+{
+	int link_id = imx94_enetc_get_link_id(np);
+
+	if (link_id < 0)
+		return link_id;
+
+	return imx94_link_config(priv, np, link_id);
+}
+
+static int imx94_netcmix_init(struct platform_device *pdev)
+{
+	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
+	struct device_node *np = pdev->dev.of_node;
+	u32 val;
+	int err;
+
+	for_each_child_of_node_scoped(np, child) {
+		for_each_child_of_node_scoped(child, gchild) {
+			if (!of_device_is_compatible(gchild, "pci1131,e101"))
+				continue;
+
+			err = imx94_enetc_link_config(priv, gchild);
+			if (err)
+				return err;
+		}
+	}
+
+	/* ENETC 0 and switch port 2 share the same parallel interface.
+	 * Currently, the switch is not supported, so this interface is
+	 * used by ENETC 0 by default.
+	 */
+	val = netc_reg_read(priv->netcmix, IMX94_EXT_PIN_CONTROL);
+	val |= MAC2_MAC3_SEL;
+	netc_reg_write(priv->netcmix, IMX94_EXT_PIN_CONTROL, val);
+
+	return 0;
+}
+
 static bool netc_ierb_is_locked(struct netc_blk_ctrl *priv)
 {
 	return !!(netc_reg_read(priv->prb, PRB_NETCRR) & NETCRR_LOCK);
@@ -340,8 +438,14 @@ static const struct netc_devinfo imx95_devinfo = {
 	.ierb_init = imx95_ierb_init,
 };
 
+static const struct netc_devinfo imx94_devinfo = {
+	.flags = NETC_HAS_NETCMIX,
+	.netcmix_init = imx94_netcmix_init,
+};
+
 static const struct of_device_id netc_blk_ctrl_match[] = {
 	{ .compatible = "nxp,imx95-netc-blk-ctrl", .data = &imx95_devinfo },
+	{ .compatible = "nxp,imx94-netc-blk-ctrl", .data = &imx94_devinfo },
 	{},
 };
 MODULE_DEVICE_TABLE(of, netc_blk_ctrl_match);
-- 
2.34.1


