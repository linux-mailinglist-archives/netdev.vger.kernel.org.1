Return-Path: <netdev+bounces-118725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8770F95292D
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 08:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ED43286531
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 06:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFEE17A5BE;
	Thu, 15 Aug 2024 06:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eQpRpURu"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013067.outbound.protection.outlook.com [52.101.67.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7439317A58A;
	Thu, 15 Aug 2024 06:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723701953; cv=fail; b=JQQ6IumRgiINL0LETqghWwUyKSbwl47i9GrcQtx6jPfFo1yMoaI7Ju1k1j2oVVsXJcXr9t+yLeY3fnoVYCnldInI268IyPinSOeUzOGODPKvo+6eqFz1/syXNK53RM4n0or8cxRXbwyaD64pZfCDtq550MbEBx7XGiUr2vSBXZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723701953; c=relaxed/simple;
	bh=QZgYJN86zmk3hXiZCOc/KTDuTbWRqnQPlSXUV4XSmQc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jsKCUrF9aJQoy9+f6qVwEAuTQK80mu0T7fcVjTn5kiqP5Y5FN59qas3anFOmdyCPeti1WgwNdqrIiFXy/Y6RDlPiEmDE/JoWdUA1+rAlZWWsVAn7l4Ygxk3/y9XQhWmKvHI9f5XdbWdPNiB0jmXoUmfsoE7qIgSLiPf4izSekKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eQpRpURu; arc=fail smtp.client-ip=52.101.67.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fpqJ2puJTcfIuu7kno1zBDZwCCaEtMyo/qwFEUWGIZpZU+xmRl7KIaxhONclmh75LWZH4M/crbJPyXgWoemOUZmAluYoWiqFuzAuGYYogdGSR/EJKT7zvnhIxm18zyoGjeejde4gAqIpGY8p3WSjisgHVUIuHW3PQdgIP/4wdauOY5iKc18i2J+z+PB15+eJ5BQzOpWKx81Jj/oK6w+PpBl0X738PUmNQtHKIbYiE9OOWQuUClPBT9kFNtxiMskNJ6tAZyn4pif4aQN+zVXE40YxHpDIkXknWJ7oNksJ1nZ6d+7wyPxI2eAH94XLdNjtfi/l/TsCL6su5dwidhE5UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=COyCIIfhCurzhPjKt1L8CkqRierS1FI6OtXAVcSRF2A=;
 b=R2kYkTT3R9xXgTsZaUaX2QX4RQRufEPEbjln5y4oFhMde2okNz4sJtaa9VaGvwckLWT91/t1PrReRIY1MyebFjALRmqBrDfrPzdffCOfAIzVTA2aIcV5GrA/TiqBj5FZqc6DnhPChDaSG6fWliUmZjsFiYcLCFUDp4smo2DSA4063nB8GcPAdJGffuQNP5MUCdmtIf1KVXOeqMSDbqlADLmljSNX436nTUekG9QMbg/FeHsxBjDhbqtuRhV9iWC/u2Kg819tZtX07XDzXP8nlHFc0VJy0JT7+reeJTSU1yaDvjaosIwrqLcHHAIeWLrzP4uVVG4exeTiuC1QR9LnnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COyCIIfhCurzhPjKt1L8CkqRierS1FI6OtXAVcSRF2A=;
 b=eQpRpURuwhpJaXtTTz7iOArYyrfrS4bc5FkLWEmGiMsCQWnP8G3EDdHQg+af03KQz/b50gWk1zZZO2knYxFztgtIhLJJos063XsTwhxdNCUaYIbWn2hQTUrR+nVcrG2/zoZhSRN09m74QKB38xMhloFUJLLJZpd+ifHDPKl5ErPIKr+53nO8DyZCG/MZKEqWY9l7GvVLuj0rUCoGGFVL569mp1jw3s7xypZbEyB/SMMqLhFApv5qZnmDTSup4bZCAh5LLn7K9cXQ4beJSFJrGRY7o588Egxx8PcqtiaOjqp86n8cFr4yJfdH7EldAnwmsmOMNQz2UhYa6VXE+pFetA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI0PR04MB10805.eurprd04.prod.outlook.com (2603:10a6:800:25f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 06:05:48 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 06:05:48 +0000
From: Wei Fang <wei.fang@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	andrei.botila@oss.nxp.com
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/3] net: phy: c45-tja11xx: add revRMII mode support
Date: Thu, 15 Aug 2024 13:51:26 +0800
Message-Id: <20240815055126.137437-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815055126.137437-1-wei.fang@nxp.com>
References: <20240815055126.137437-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0097.apcprd02.prod.outlook.com
 (2603:1096:4:92::13) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VI0PR04MB10805:EE_
X-MS-Office365-Filtering-Correlation-Id: de0df6fe-fbde-49d4-ddfe-08dcbcf04f2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qaw6wnXyR7eB3rQtLyKXxdxu1qyZfUEghE6mAk3tXBUVC+10VCLvdHPffuXm?=
 =?us-ascii?Q?zO38OP5yS+xJ9wMMioT0qdS3UnB4/yRjH7lr7JENZWPuvL/RHzg9M9htN5SS?=
 =?us-ascii?Q?xVBT6ZDIMGr0bijAX1hRbloqbpcq5ye32cBOuE2veBvEcvA1Amb64N92yr0g?=
 =?us-ascii?Q?dSL0/YtY0yL79rLUavjQnq5nPfbJo1K0PT+UE9XoCsANVNQiHNVcX4XUd3T2?=
 =?us-ascii?Q?XBHWvGFP79vfcVZRchoOCt9y8r4PCanZ5PrKP/qsnbRf57AojbxtuAdykhOt?=
 =?us-ascii?Q?jfN6mZXRMOJIlgbuOub85NHlHh7wb9gQ1VnZU+hkQ2rly4NqiY0p/4zdRwB7?=
 =?us-ascii?Q?iAyESU/YDZjTLlsWGd2m/RoQl2WkvCI9XLL4nXGbIW98fmm21B8Rv9mJkUmt?=
 =?us-ascii?Q?hMJMqcSJxhaoRT3arOJ6+Qb91XxuOyCFpJAmj2eLeZZ7inAD3gDEaF3YcKhv?=
 =?us-ascii?Q?2z9syb5ki29OStpJL0m7OiKy6T77F/aCLdgQsvdE+SEni428KpWqsG0XOMX4?=
 =?us-ascii?Q?pP8AbainRO3Hf4mO2BkF+ueDriaiKdlZuLptI43sv64BKhoJXO8afUknraaC?=
 =?us-ascii?Q?wRZjmMBAqxHWloU37mBkvpmxyvWQqT7iwdKTxFQAxgteLjQbtBM3WV1YjvnN?=
 =?us-ascii?Q?LWD9NPzIalpZYuhS/17n/WZpui8Afev1YB5XtY4U/LvhJYOAo9Qrqbf6DYG9?=
 =?us-ascii?Q?6h7lQYd1HlhErdnHMq/fqy0UFmnRgCOmAI1wL9e5fkxhBp70BnyuofppVOKM?=
 =?us-ascii?Q?bnBr1JVDRIJeYu+TlhKrn5Njr/isEqW+Vp2cnoqSbdXyfVnMct77d8+DgTNM?=
 =?us-ascii?Q?cX880WPjgpqMczjgU/AJJo8uwd9ANQ5sStA8wwxVFqUaOboGNPu9WAhs62MF?=
 =?us-ascii?Q?oZXN9Trrt4ALCjojbha2g3wNNA69EBP3L2uAmIxkGflnlW86naes1R0W0WdU?=
 =?us-ascii?Q?cP0En3h8wiZNt0XKqfLiQJiloHF6hLWDnrnlhXg/VVAnTjnh1sWR95nknufN?=
 =?us-ascii?Q?dD6BXoq/+IoRIlsmdINjXtQ3wUdYn+DVBkWcsRlHwa1mfjBMRgSQZ9HDdAtj?=
 =?us-ascii?Q?skawC5ynOAMxm2Qni/raUb2MMHKH9g785nXO7tm2YUVw7el1gkgFU7yVHG7R?=
 =?us-ascii?Q?UPOxapbKzAQaNS6cuPbZsHxVrBIrFe0C8iSrpsAYhBwoUPg0T1Hj5rLEmp6p?=
 =?us-ascii?Q?yLy4VZBa6bsCdWxxu+RK9zRSc01z2yu6gdaPSu1S/84F+KhACdaOwLFNQQkK?=
 =?us-ascii?Q?1kN2mKijn4Uv4k3tDtOqjkPPew8CNIEPVSZs4qDpoW4nvxHghbsk56cY3ANo?=
 =?us-ascii?Q?ZhoDY8LFsUOJYIm2gFMYX7rQxuP576K1+9jbW/IBp2OCUn2FHt1DYj9UyJuK?=
 =?us-ascii?Q?HpDbWYH/JIAuLdS+EvuoBmtxkUZ1oc2LK9SpmbGOjpFAuG1WrDDLL9nPSK8K?=
 =?us-ascii?Q?EDHjfUD+IOE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?79wjKj6jv1kdvFBWy2Wk4ZpcX5dfQ8+ymRDjkcfdm5LIyS1pHIicv7ok7FI8?=
 =?us-ascii?Q?ESVOaJCsycmMCK7xOVUQPRi0UKbcFgiEWBCrabgeKiqJ58dpPu/L3e8E+HIo?=
 =?us-ascii?Q?gOEQw/j9zVLJpaTnvRHCeMDcEfTv18VXDzAxeDSA+En1mjUHxpTh27Nbg4lb?=
 =?us-ascii?Q?3pToYHLJy5jca7gS46cpWHWqfgnfwmfm4KwqANQUzVYRe1QfzA5LxTa9I7eZ?=
 =?us-ascii?Q?2VaIdqeT0C3+R/W5DbcQMyEWZenvshvAPp2Yp5aoA2QmalO9K6HfrtFLEW6O?=
 =?us-ascii?Q?bNM9BOCGYRmoopyqvwfaXjimQOiZ83aLIeJwgpqGcMTviUUY02u/4CcKnx1v?=
 =?us-ascii?Q?t9+sjQr1mfRZxoybnW7HR0QK83EvxpjUUVEB4ADQxRkMalSnyp+YUI1taV4h?=
 =?us-ascii?Q?sF7lAstWj+O0VwM9hRr8HVjnV/1ALThdvjXHgaUKHLYfOD9im/5aREjsclr1?=
 =?us-ascii?Q?f2EhDgIt97M5jk8GNOuVav8cR8l2e3BFWTPvgLw7wJ+QnIKx/7ieijbTGGX0?=
 =?us-ascii?Q?t2gGxq60/F674oBD5O57AAr9/KE1jabcKgY6OUHCdhBAPbOM6lp+hHPqLbXD?=
 =?us-ascii?Q?1g9PwIzqYzgtWLDrLuD0ud9VMRiWHh2CViCWEeOUuyIrypZH9q3QHu0xVF2n?=
 =?us-ascii?Q?tviySIeQVIOsF98TxHzKzdEP5DGhFYDdAaPKNbtSc9LYfr6t69FHADXlfslx?=
 =?us-ascii?Q?K4kWj3ZpzdW3GCVBz8W4UTG2FGeyGwPNcBIryZ0qsLSPsQabJnCDvKoUCS6O?=
 =?us-ascii?Q?eFyHlTw6ortiuJE7T3t29auqdhH8uadT5llPP5ocgteItSfdqkzX39WT7Q1g?=
 =?us-ascii?Q?Og/o61LJasjCdWVkrvujgsFt7A+NbjVQvjzV2sGVl0XBY0evXEYbesbcQb76?=
 =?us-ascii?Q?LdcOuLTt4q14yJmN+gjF6iGvuRbBh6mnlgi/M9JvqrteTsaaOEEzqrlR9TZ7?=
 =?us-ascii?Q?a+fWT3VSGtvqG5S1fVHbVoEGALaY3ZXhp/FV73/JQvk9TOD0AnR6tupJVFmz?=
 =?us-ascii?Q?gAaW4E6cgKB7VaYOrKgFujIQbg5H9VDkXKb6fr0Myf3Yu2COUZPmXNa3r7Mu?=
 =?us-ascii?Q?AdV2plhWOrwbNoncdTBOW13w6HeZwl/Grr4ES2PKkcOX9UXaC8FkB1dnUBdX?=
 =?us-ascii?Q?1o7QHg1Wbww8zPjHRI2bi5P+MUL/zfZK4dIqGQ/IWq8n7GkVuYwsje6VIMDT?=
 =?us-ascii?Q?z3K4LrGcF7tohZitXrc+d3/wljFib0qe3X0feQ87E9VzqvSE5js9u31lYNv+?=
 =?us-ascii?Q?vGG44QYYuUHCAIsIGYT7oxbn/1bF2rwWEWgzur2+731A5IfhhD15bmfUR1sv?=
 =?us-ascii?Q?RESueSWXlZ6ZaIz5Ugu+tt+9M1o8Ey8RYYwphBCPIw03g7naajhrSNGBOzGk?=
 =?us-ascii?Q?/HGsZFFopcT6KavojXfIe4sDrjhYXCCtz7alzsepiwQhevG9NmRjH0JR+R7E?=
 =?us-ascii?Q?JYOucADddPZg+3QB8284d/xIaiq7pr1OxFXxM6ar2JRZgmBUFoRlV5/lIVif?=
 =?us-ascii?Q?5HdSYgz1xgY46wqB9T40KMDKjvApWqLDJKIH/imnIr90hfYFIGjDpRVCNLyS?=
 =?us-ascii?Q?cyA//RebXT7DVKgKBn+FTDCZAjPGwEZyu86qW4xI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de0df6fe-fbde-49d4-ddfe-08dcbcf04f2c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 06:05:48.8723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2g7XfP1QzD40kKRFU9WB8Fm28mJfGN+JeV4RQRyup8/QbJxBkn4pVKyuSUuy0+aUb/3NGpdVAK3UMkTYHLdgzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10805

For TJA11xx PHYs, they have the capability to make REF_CLK as output
in RMII mode, which is called revRMII mode in the data sheet, so add
the revRMII mode support.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/phy/nxp-c45-tja11xx.c | 29 +++++++++++++++++++++++++++--
 drivers/net/phy/nxp-c45-tja11xx.h |  1 +
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index 5af5ade4fc64..571ecdbd49d9 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/mii.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/phy.h>
 #include <linux/processor.h>
 #include <linux/property.h>
@@ -185,6 +186,8 @@
 
 #define NXP_C45_SKB_CB(skb)	((struct nxp_c45_skb_cb *)(skb)->cb)
 
+#define TJA11XX_REVERSE_MODE		BIT(0)
+
 struct nxp_c45_phy;
 
 struct nxp_c45_skb_cb {
@@ -1510,6 +1513,7 @@ static int nxp_c45_get_delays(struct phy_device *phydev)
 
 static int nxp_c45_set_phy_mode(struct phy_device *phydev)
 {
+	struct nxp_c45_phy *priv = phydev->priv;
 	int ret;
 
 	ret = phy_read_mmd(phydev, MDIO_MMD_VEND1, VEND1_ABILITIES);
@@ -1561,8 +1565,13 @@ static int nxp_c45_set_phy_mode(struct phy_device *phydev)
 			phydev_err(phydev, "rmii mode not supported\n");
 			return -EINVAL;
 		}
-		phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_MII_BASIC_CONFIG,
-			      MII_BASIC_CONFIG_RMII);
+
+		if (priv->flags & TJA11XX_REVERSE_MODE)
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_MII_BASIC_CONFIG,
+				      MII_BASIC_CONFIG_RMII | MII_BASIC_CONFIG_REV);
+		else
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_MII_BASIC_CONFIG,
+				      MII_BASIC_CONFIG_RMII);
 		break;
 	case PHY_INTERFACE_MODE_SGMII:
 		if (!(ret & SGMII_ABILITY)) {
@@ -1623,6 +1632,20 @@ static int nxp_c45_get_features(struct phy_device *phydev)
 	return genphy_c45_pma_read_abilities(phydev);
 }
 
+static int nxp_c45_parse_dt(struct phy_device *phydev)
+{
+	struct device_node *node = phydev->mdio.dev.of_node;
+	struct nxp_c45_phy *priv = phydev->priv;
+
+	if (!IS_ENABLED(CONFIG_OF_MDIO))
+		return 0;
+
+	if (of_property_read_bool(node, "nxp,reverse-mode"))
+		priv->flags |= TJA11XX_REVERSE_MODE;
+
+	return 0;
+}
+
 static int nxp_c45_probe(struct phy_device *phydev)
 {
 	struct nxp_c45_phy *priv;
@@ -1642,6 +1665,8 @@ static int nxp_c45_probe(struct phy_device *phydev)
 
 	phydev->priv = priv;
 
+	nxp_c45_parse_dt(phydev);
+
 	mutex_init(&priv->ptp_lock);
 
 	phy_abilities = phy_read_mmd(phydev, MDIO_MMD_VEND1,
diff --git a/drivers/net/phy/nxp-c45-tja11xx.h b/drivers/net/phy/nxp-c45-tja11xx.h
index f364fca68f0b..8b5fc383752b 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.h
+++ b/drivers/net/phy/nxp-c45-tja11xx.h
@@ -28,6 +28,7 @@ struct nxp_c45_phy {
 	int extts_index;
 	bool extts;
 	struct nxp_c45_macsec *macsec;
+	u32 flags;
 };
 
 #if IS_ENABLED(CONFIG_MACSEC)
-- 
2.34.1


