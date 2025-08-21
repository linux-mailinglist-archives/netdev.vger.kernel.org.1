Return-Path: <netdev+bounces-215699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FDFB2FE71
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 17:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBCA93BA933
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 15:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562B3338F21;
	Thu, 21 Aug 2025 15:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QrDu6cKY"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012037.outbound.protection.outlook.com [52.101.66.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A143334396;
	Thu, 21 Aug 2025 15:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755789703; cv=fail; b=RQn7LvQkfltZTprfog0E8ApRU6DGeqhkYK7QmzYzAt/QUBJI2+GdXl2KTlejoJ1pIUXQAs9HzVkL5m/HUE0Wgf89HmQnSG1SmT8ThLBuwVK4UfMoRhVieM/C2cy816S10xKpIZHTZmSk3b6UinU0baN+hRUikfHYJ68EadJLMGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755789703; c=relaxed/simple;
	bh=xP60Qj0Q7P1dhdXXS2qEVug3ep2A4KxQdAdCqDDheDc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OYv+TjdcM2ofgn4+XvVA79mvCJvw9zmdnRyKH6Rge4UbWHIbgHO1pVsVHf6gU3DvVR1xhg4SCchQnN3K6bocW11lbrYcByAUcZbUn7i/sAvXI5rZwUx4KS0qe+D4CXRJV/yTQZAuXu0cXEzFg5bYNpOE+yGRmctZUfa+TwXUNJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QrDu6cKY; arc=fail smtp.client-ip=52.101.66.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kx7ksoWJSF5nLMCrNMn04ataLD7sRFn2zXtcDsf1/EH/qOMXc8HbamxX++sUWeTaCVJbKWICysAUujELhSvaVh0KtYTBQ/s/l9CIjjXp1xyxaEY8pueK90Ii4g2Biy06NAAt20qkzWCfY+TS8cKYa/0J0J+S5FSuiKDstHz207uWiVtpjkfQ1BCUupXB6CfeJgQIHxsdw7wneKExPN1O/4LgDapxDl0zdQASfm8BQo2WMwHrzQC33u1ndzUakWbKPAUupmlGdYOvYY+dAoFf6xoJF5VMGWGc6D5xONSuVzjVtYtM18VLowkB//HNop+Gu+AOxKNRYig3coCE4fVXjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RhCRQTVFK2Au7yh3qgj0TH/uNLM6INeu5I8zzKSow/k=;
 b=OQ+0s7aVZT6Vfq/NQxAgZuZ1IpGU/lRmrKGK2cfYWnvWMayg3mMJ2AFZGaJRb3N9VfPo3B7ZiPvgS/iYVIZQyLtoI9c8HDUv4JYihDVSfc1m+/+/RIzz66wsQGcYiAW5zi1Nwp368SmbR2umLJ98TVBkCvuxHRiSJ11CWM0eSih/YVQlERXLCjZ7VXEjpnamkfm+zGnszQ06x6Wh5yPE1p+qfszE+IzGu1cDSNMcUjEy6N6XIpjxQnKaDlcWZDWDN23wI1TrtNGplOHOd8oT9QJkTPSQtsRMwbiRondjuHhwYIEmzZ73bVyZY6mrMgo75uhtdyuv45Vu9WDkL6xFzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhCRQTVFK2Au7yh3qgj0TH/uNLM6INeu5I8zzKSow/k=;
 b=QrDu6cKYxfeyM00N1Dr4jDtaaipaJCOzrrJ+bQ294StSc32kinchENC405foyW3GivPPTVgl/3N6iCAPTiJAUATJHWQijGQPA2H1BbBmm7r5kprDEpcBoJ5cimeZCu0LM7cuL9M6oKWuk94BrgMhy2xscLUJam8JNGj00YtZtc42FVLtQwJnLp4gQe/xXV4VamiiB4syucZqXd+wAK0NXfzWhRJTWGlzn0/9XQTfshhC/yjMfoKqLuU1ejNpJqsPRV0FCkX9FbMz/t6J3z7Pcm78PB+WNtZEtcLiBzZr8G3evua7pw/wk0pVK9FR0xWi6SRAk0djEpTmmz2ee92JVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI2PR04MB10809.eurprd04.prod.outlook.com (2603:10a6:800:27b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.11; Thu, 21 Aug
 2025 15:21:31 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 15:21:31 +0000
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
Subject: [PATCH net-next 15/15] net: phy: aquantia: add support for AQR115
Date: Thu, 21 Aug 2025 18:20:22 +0300
Message-Id: <20250821152022.1065237-16-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: e7750584-edc1-498a-27e1-08dde0c66846
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|52116014|376014|19092799006|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?T6xDWz+cg5VSNqNKkNJub0596a0Q3mcm8wWAFut9s6JI9MgjuQ5VbNasHweO?=
 =?us-ascii?Q?Wo68TlCdy9YgVfWTmw89ZXdH6+FnISabzgyY/4pogDbsxnZV4VMpdB0XB3S3?=
 =?us-ascii?Q?B+G08j7ZtmVEBQL+1PnXgs8KbJhwhMMZO28q00pYahYpGnSNd7hUriv4yrbI?=
 =?us-ascii?Q?Fcn3P3P2FMtxYv56uCA4hmWi18O5r30zHabGTHDpgSo0DPOo4zwURpb78iq0?=
 =?us-ascii?Q?i1ROnKUnSgr/71WOV1JGSHMaoiuFgWWcv3+ioZfst4Ax0R3KzWbQhrA4L6wE?=
 =?us-ascii?Q?0MOI4YQjb8q1nTXog05YemJUntdwu1XAjAHX0kMIaP00zzQUXrucPBraFdzF?=
 =?us-ascii?Q?scCDVJ31rTr33ZOdoOxObpGAoH4HwzREHzEYtJjz9T40uC3CnbO9M6qjPW07?=
 =?us-ascii?Q?x5w75fYJsB7m+oIguVPZkBGq65Svla2GHyHGEpJOElk8gE3eSYKWvU6N83VU?=
 =?us-ascii?Q?BJOCso8cvoqKbJkJ+vYjoVJrHAMmCIvSYkTvLt5/ydLQfALSd/NUyCSvJKnF?=
 =?us-ascii?Q?abPrEhTkTqbAol4FtPl1MfZFCA+utZSyQkllEgpsZe74BxOAPlhLRHCKabHL?=
 =?us-ascii?Q?udwQ8YcF2aoHKdUVXMTy0kmN+bKVQ4TAhzd2F1PhKC5dDemk8bJBOAPxCC5n?=
 =?us-ascii?Q?gNZmLFQX37m2Kx7XxD7/LUvTgEnJeGZpU3QoeEA6ufz8haT5T4iTqnXUcWhz?=
 =?us-ascii?Q?Klog+9DCTcX/SC3aMewTXN+U6UzSPbJ4oY4Z0cFioRfAR0lvqePIl7c3s3mp?=
 =?us-ascii?Q?PiZnuWkBq6CeJNaPE9b3s93v6A/vscVgPUBBfeqh5amz5fkuhimFrh7onapQ?=
 =?us-ascii?Q?IwdJEMn66CUDvrRyNJu3N+lAv1Xd52myvK9A5CpvnUPw0O1GQobaUFsc2Y4V?=
 =?us-ascii?Q?mU3iO0c8DFGcgz56czoxiLHumQkuPT4lk6VMMuscUYQ1zgzP5FqwdYkc6wPE?=
 =?us-ascii?Q?72osS6tnc4IxV8l6CVWPoywyR+cVBDlfSjFi5h4mmUeU7mILCgucIixeRdyW?=
 =?us-ascii?Q?ZRgPhTQ6Z2YJpUbckyrJfYLG5zO/gUjO1plJcrSzT6aShkzEBMIBtOInCGda?=
 =?us-ascii?Q?5cS5XT0uXvTHZn1wGSpun+VSkW9ejTl/uQ+rZRrIclbaPY/T2SzuXDf889en?=
 =?us-ascii?Q?0NRXaorogFEvleWMmpiHJBi+3X4UBrkY9a6y93VfgNpyIn6F28OUL01pOGK8?=
 =?us-ascii?Q?W18HX09v+NseBmwLO0lI6ktKtOiw3C+gDL3gaZum9gyhzj0pIQnrCtonhRPh?=
 =?us-ascii?Q?eDI4RRvOfvdb4qJuvgHuzeL4PLfa/t+hOdZaeD98SeWKAImAaGo2S/LbiXzy?=
 =?us-ascii?Q?B+8ZMs/YDIZXbrH9GJXWZZTsf+AZ5sPZYzejm0DuJ0WPE+XvVfgswoTfBAuB?=
 =?us-ascii?Q?9d/8XUXIKGsiPwmheEgl4nWqMkFVhA0J+B7g1MAwD83V2WmfsF5GUgxhhJOC?=
 =?us-ascii?Q?7NNcHXxSqdCbmP7zct+Gi7rUHjuHzNiIJlD3EFB4RE2gUkEGfx+h9g=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(19092799006)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?b2TrfEasC1CIGZ6emhHcZpnhPvqyrzmDPH8/4UwziCj7L5+vL1+5eE3K7jl7?=
 =?us-ascii?Q?wvEG9BmMOadtGuKvZgixx5Wff7xzimiABqvwoxd/er/cPR4MdLRlJrS3S3ET?=
 =?us-ascii?Q?aC/RIM3gHpqYHAM+16jF6BMddpe1d8TICAIMb0S4rled4uOfsHJHFBG+iPss?=
 =?us-ascii?Q?C6ItbV5Y6VbGdxH2yWyUWAipv7MlBYAMTFpekQESHscfMywHv8aYXIhksJV+?=
 =?us-ascii?Q?XWmIOZo8ARBCalkEaIBOFGDV+ywClB58S1c01k4N1Jnu6K032u+SWMBE6l3f?=
 =?us-ascii?Q?SppQLP+wvyHXwZ0xVJFcZiVU7frktNBTmF/fqRUXGajVxebTOVMaBl/cQ6bH?=
 =?us-ascii?Q?tGm914YMEA2DG/xSZHAzxkvQPYU3Dm59LXeihIO4ZD8E3IN4fNQlzJEjxPB0?=
 =?us-ascii?Q?DnKYFVGBsGP9Fgp2tDkW3HtCnL8+v+Bu3r3qo7DQBPTLGSl9SuAQZaFVTZKD?=
 =?us-ascii?Q?e6bO6EFm7JEAUKjVHMAP5JyV3CsKcDLA6YY3LhajvkCqnpky5WCZkooQJt5h?=
 =?us-ascii?Q?6Cs4ujMb5aQu9rqeMvE9Ui13iY1oZ3oao5EGpOLfnoq48AGrfXsPB/aA2iK2?=
 =?us-ascii?Q?0/hlXqwa52j4RowcytuaKGaGdihaOAMP5oZRp9OawfJM1epPZG9SWY/6jRV5?=
 =?us-ascii?Q?4i4mLg0WKBTbjGDwGoOOvf6fQqqvfjPp+yFpm84kbaFwFp2Yeo6HE9m0XBGc?=
 =?us-ascii?Q?MsPOZqqG+8uCrNHD0Lu/P9bAgmgSd3E2E5EasrxFc2N6Y4WRlJobC3YUqWFY?=
 =?us-ascii?Q?uCsc2hl6GokBTf92iwBGBSI2k4FmIAIG3rOPAZjcVrRa2ZCLGK2uVfnniXQi?=
 =?us-ascii?Q?1ZqbVQmi0j3ydNqxyXlOpgiVLTAIuwhPMHtPpVJCt+RT4x/BDQ0L8VlqGEfr?=
 =?us-ascii?Q?E00F1hbCV3hoXkICjMb+WCjbQ9LiugfwrdR8+KMEQHRxBsJfEfUQlDDY2Hso?=
 =?us-ascii?Q?70cMgS4R6na3ITKl7AsIrmhAcPgRt3JXFEtu4EXdbpuQzmcdVAxp4BzKIIeh?=
 =?us-ascii?Q?6DDA54iugUdvK0ZZHiO7OAHt4qFBXUeBa5voqrisG16JJX69DmuTmmiRVLti?=
 =?us-ascii?Q?cCWwPjr/x3kB6K+EPfW4dZ3TlCSl2XoS7i4XRLrCMS9dJLs2CX/3i3ZTIs38?=
 =?us-ascii?Q?vsEsgEsXOG+YlAaAwqlSvmY7YGa4ohtuJrWVYsve+hPsSBhF2t7x39hXBHzF?=
 =?us-ascii?Q?mn48A/rI219cescfAZuu9fuQ1rUEaLReEwzU8/YmsV5rBjKTQEqDRToTZyTY?=
 =?us-ascii?Q?E7+MwBsRV7IE0Al3Ngr/9wmK5Yh7KHClv46ia6gfjyvavNiDc/hBxzqHUazB?=
 =?us-ascii?Q?1H7ugDhuWyHuNMdviuvPAEopWQXUv/xQlYzeZZC08pMdBv+hqP8/uPTk8Nrb?=
 =?us-ascii?Q?XiSsSRTQqfcJJJVTw8LAQHv3GJsfVm5oYHjXc+5HXXxs4VYLVTmJuH+oed+v?=
 =?us-ascii?Q?zQwgVwNuVY2B2U20vAWwU3tEpv8newJCrH5F714IWwHoXu7xBlRgJarrApEm?=
 =?us-ascii?Q?jLbzCqgUmtdCpieEmuSPQIfexKHr37aXuQMUHpKL8gt7D8PYVt7jk8uMCxXt?=
 =?us-ascii?Q?KSGkriiMZAlUqQsgL+KvnxuqXzReucMwG/n32j/+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7750584-edc1-498a-27e1-08dde0c66846
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 15:21:31.5494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0dO9SMZZluzC66x7e29PsdxPSzwCLSQFZKHvVcKW2IGK2h222Y47XzGX4FlemuJWo6gKfRqJze0MR50mtboJ/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10809

From: Camelia Groza <camelia.groza@nxp.com>

AQR115 is similar to the already supported AQR115C, having speeds up to
2.5Gbps. In fact, the two differ only in the FCBGA package size (7x11mm
vs 7x7mm for the Compact variant). So it makes sense that the feature
set is identical for the 2 drivers.

This PHY is present on the newest PCB revision E (v4.0) of the NXP
LS1046A-RDB, having replaced the RTL8211FS SGMII PHY going to fm1-mac5.

Signed-off-by: Camelia Groza <camelia.groza@nxp.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/phy/aquantia/aquantia_main.c | 27 ++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index dd83205a8869..8516690e34db 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -31,6 +31,7 @@
 #define PHY_ID_AQR113	0x31c31c40
 #define PHY_ID_AQR113C	0x31c31c12
 #define PHY_ID_AQR114C	0x31c31c22
+#define PHY_ID_AQR115	0x31c31c63
 #define PHY_ID_AQR115C	0x31c31c33
 #define PHY_ID_AQR813	0x31c31cb2
 
@@ -1344,6 +1345,31 @@ static struct phy_driver aqr_driver[] = {
 	.led_hw_control_get = aqr_phy_led_hw_control_get,
 	.led_polarity_set = aqr_phy_led_polarity_set,
 },
+{
+	PHY_ID_MATCH_MODEL(PHY_ID_AQR115),
+	.name		= "Aquantia AQR115",
+	.probe		= aqr107_probe,
+	.get_rate_matching = aqr_gen2_get_rate_matching,
+	.config_init	= aqr_gen4_config_init,
+	.config_aneg	= aqr_config_aneg,
+	.config_intr	= aqr_config_intr,
+	.handle_interrupt = aqr_handle_interrupt,
+	.read_status	= aqr_gen2_read_status,
+	.get_tunable    = aqr107_get_tunable,
+	.set_tunable    = aqr107_set_tunable,
+	.suspend	= aqr_gen1_suspend,
+	.resume		= aqr_gen1_resume,
+	.get_sset_count	= aqr107_get_sset_count,
+	.get_strings	= aqr107_get_strings,
+	.get_stats	= aqr107_get_stats,
+	.get_features	= aqr115c_get_features,
+	.link_change_notify = aqr107_link_change_notify,
+	.led_brightness_set = aqr_phy_led_brightness_set,
+	.led_hw_is_supported = aqr_phy_led_hw_is_supported,
+	.led_hw_control_set = aqr_phy_led_hw_control_set,
+	.led_hw_control_get = aqr_phy_led_hw_control_get,
+	.led_polarity_set = aqr_phy_led_polarity_set,
+},
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR115C),
 	.name           = "Aquantia AQR115C",
@@ -1413,6 +1439,7 @@ static const struct mdio_device_id __maybe_unused aqr_tbl[] = {
 	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR113) },
 	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR113C) },
 	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR114C) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR115) },
 	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR115C) },
 	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR813) },
 	{ }
-- 
2.34.1


