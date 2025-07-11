Return-Path: <netdev+bounces-206101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C970EB01762
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 11:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A6AB3A7BF4
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 09:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A83A264FA0;
	Fri, 11 Jul 2025 09:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FNUD6XqR"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010018.outbound.protection.outlook.com [52.101.84.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10974264625;
	Fri, 11 Jul 2025 09:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752225255; cv=fail; b=H76C1S0VD+gE6ls2/fwyZjDNaE+8zcMZIYV6jU98QYv/4EFRz/iXYEzmWbW4Ri321pEkCFYxUJjekG0vIJC1C6MME5ZdHjitJwrSAslYyOSTNOjNQ9h5ij18WJGIzjLP+Hm/NCMY5xglUCh6dT2A5y5h0jr1g43QzjE6nKlZ8DQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752225255; c=relaxed/simple;
	bh=cYl9VcVvX5r7j5bO4u78gf35JQO1Tf8GCz1w+9rXZI0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QtTOq2+LfBqCYilFsZ90Mr7Obadd6dpdmfEnLp3jcSEEerKXE/Nx9W5BXjaEl6pFY2+0vaZPfgJ7LVnDwStsJ54T2UTgxLJV/XZgKL2Dexd35nYzaX5lSnidPiII1f6Z3eyaGjnf6n9/FEfszdmLiWqvXPSNKfHkJ4Na0OAUflU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FNUD6XqR; arc=fail smtp.client-ip=52.101.84.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aUk+QU1bNlj7uP9FyQNJGQQHmUCSNuy+ok4p2PqY4rldKmzMxhV1szbTVmcNSP0ZugQvRaj5fLZIVOlIrTrPyCqLjm8ejApO0pW3N25NyiKJPRyhR7cjP/TNfWZ7e5ag2JSEYTj5j7yDAjEsn9PVy28SfFEm61E+cDfo4k8WwsXdSkKmSe39M60y8y4+vhnIDvxbh+PvsIzEjdkAqjT5+Oljl7uxknQIaGsi/IU6lZcRMGCYxvOSYiNWj1npxRkuXAy8zTfDpabhYmBNENfWCPgP7udG2LXxkg4SOfQuMAKou7wPIMRPILTavboM8jdVTJHzUJ5V9/Ea7GVRt7QCsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IV5lRFNXPY8NQ1H4hLuSSYSimNbymxKyw5ggZbc+/M0=;
 b=cdMaitEho8g7NSTS6yYLv/KvWHa2eBJyobb35HixbhiL04o9Bgw23Rqdjf+twEKHK0aqzPhSj0lAVIDizrcbhhKIN6wVXUkaBVg/I7XkZu3Q1X/hyqLWDk8ugVtnKfVLuCZleF3Nr93H2qLuVyKzSx4T51pkujuwHbbb91Hmz//PLGoBH6gGXNGfkUo1Cn3cY8PBAKCIOujRvy1UPIriLwQby6uaJRkvtsjQH6ojOVO4l20KUbs7pKPhvpbFZfPv2JICP6h3rwZKp8kSm6r+acGqDi99YK9YwZA1fngbIrdzWOoY1aM2wl0D22UIFNBJayGCVpvsFDhjgWDI0BQBSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IV5lRFNXPY8NQ1H4hLuSSYSimNbymxKyw5ggZbc+/M0=;
 b=FNUD6XqR0wNGVDUR/vmulMP07wqArBZpkMGICXMJwiVLXKEdZ5Ei0UErRLgBzlXs+L9zAGr5te3VQ4IXbo7rZE+TaRG49PT7U26lv8B2fNNQcYTFGFm9zcH01wOoMh4RXfzfHd8SAp/VZUKnze+Mw05f7va/Do1sNXiuE3E0gzkyNjC/imwIBB/RVYx55OII/ZKM+Yl/5QyNTqCUJ7mQApCwoUjhAZtglMJrokpTqUjzudB6wy0QbtVIc6lQgcns2++qUMPIDjw36lVr3oxzRwSIXvPDaIiRVlQgPxsE2GPBLITibS5mPt52yBjMWxP+cDh0dJosh09nORbQ0y7/8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBBPR04MB7708.eurprd04.prod.outlook.com (2603:10a6:10:20d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Fri, 11 Jul
 2025 09:14:13 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 09:14:12 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v2 net-next 3/3] net: fec: add fec_set_hw_mac_addr() helper function
Date: Fri, 11 Jul 2025 17:16:39 +0800
Message-Id: <20250711091639.1374411-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711091639.1374411-1-wei.fang@nxp.com>
References: <20250711091639.1374411-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0P287CA0005.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::17) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DBBPR04MB7708:EE_
X-MS-Office365-Filtering-Correlation-Id: f74694cd-63e2-467d-b691-08ddc05b4d36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ht7vlMq+/XbwZkxfdWwPx01mKRq6RFKNG+aUNhRfmewC1FAN4mjr8k0XysXR?=
 =?us-ascii?Q?6Dp5eclAD8Ges1hgnaMgMughxYFu5jg8Jvfu7G4YGnWNDGcd/khk+DcOt4/m?=
 =?us-ascii?Q?0zcggxhhh6rXhHYFQFGJpONsdpSD/y9LqGSGT/JgP0rUGcjZSN5ojPCMgEPo?=
 =?us-ascii?Q?lLEbm3qf/Jw8ywUrRe4JKz0J/r/ti9Wgl7AyHGm5EDeLpJRX6z6MH2o8oGN5?=
 =?us-ascii?Q?PvEjeYtBiofXl11G1uXQ2yyruPWvzzTQJE5+gLtUNtNpfCrUAbqCDznxXIFB?=
 =?us-ascii?Q?s80+N2Ol+fWcDwc5yruQIlGL1z5SinC8L1Vpo+8XRGPWksMXEiv0q3VLO2JP?=
 =?us-ascii?Q?IIkveBvQvwqcd2n1wDn6CsfZqwtECnXqPnr7TsAnbpzMsJJf1Bd84DEZ6ARS?=
 =?us-ascii?Q?ZZVNlfFbqYigUltAhFj208vg1XXK7fq9KlfOZS/RKk7V/LoZCfLI/dFEj+dJ?=
 =?us-ascii?Q?RD6wTjfSMaUvj0S7+SLRLqOEkoX+uadzErhxH92plWYVlBZyITMqDi/1W0dk?=
 =?us-ascii?Q?zLbCEAQT3GTFoeBNQjfol5c15x/kRJyuEKJikosa7HxQrFP6TIGKhiGNY5sS?=
 =?us-ascii?Q?gjDba99uwRCQxc/jiLphDsZktiestxG6G72Eh8kdGZNp8o3iIKyJnCPgT2s4?=
 =?us-ascii?Q?4RcnbPo54ZWshQNoGExxKI0NkJqQRrwFBAPgqNODl5dnX8DVbMjFfICLJrnw?=
 =?us-ascii?Q?BIvuDAokiY/ErRyVD4sGB8OUDDk2ifxNyDX5N0p4TaY7tI5/bHxAgipqDBk9?=
 =?us-ascii?Q?fuLh2VFjQ3X8oPxEJwN2UnL8wag1ndMPcWlH3Gpc/zyzTFYrEk8yhDephbjd?=
 =?us-ascii?Q?++GmW/+r7kHh35dtZdghFS8BWlq8eSFjTShm81EWfscXufRcFiHUIUCqpkDW?=
 =?us-ascii?Q?20kQOd3017M1Pv/ShaW4TvZO/jEbTPrN4mWrOOjsDF4aJQvuY827SzHR7noB?=
 =?us-ascii?Q?Z0fKoCI3hIaxzu4pgfeE6EWJPCZAMZLZYPmZy/d9r2SnZ+WeK/rhOfXwWEtL?=
 =?us-ascii?Q?M0LM0Ec0CheNOkjtNKq9bRNU0LYChsls5ne0d8AWVHGoDw7fk0o0lTks10NW?=
 =?us-ascii?Q?VsE11gxYMMIsWWWvoPcweDZwXTSlfSCJH7jVJndsslFiKvKBRTF4HwEjIxsE?=
 =?us-ascii?Q?8hzqwjzvlPB0ZYGyEz3H5uADYlTStmJIG6b2XUPqdlBCTKlMyXhl6SQxLQMD?=
 =?us-ascii?Q?FI5NuYMcSpBLC6TKsyQLxisVzpvPifdNVQHKsJabY6tcCnz8pjZqyhCzLexA?=
 =?us-ascii?Q?88rrt6n3hIQu+6oo5M+3HbI1uEu7iWFWIctTHqLR2ISBNBOItMoHQ/u9py+I?=
 =?us-ascii?Q?fHdzkVUvme5USUJku5yIJVUFqJ9a7kWFzW3ZCL75gkhLcyNEbJYyaPIOS/r4?=
 =?us-ascii?Q?r2fP4OFYwWJrDHreMCQyHECz8CpQS2OwUgo1BKpVkdEFCvWjhwq5vyOXM7V2?=
 =?us-ascii?Q?Xx7wmbc3D1iUnoiOuz/Wr29vrqPMoAobH9XhCLxAgl6yF0HFyfmfAA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zNK87WiqXTi1YXUcNw6aaVztJXOg0uTT2R841Y9kYFBbKS1Ml8FHDFXD7uiE?=
 =?us-ascii?Q?7L18PAZd78BFG6zoRJn5IAiy/7R/Vbjep9Z2xLrY4YHq6sZcUf48qodIfKlI?=
 =?us-ascii?Q?owkChvXhMABEYEhUT1H6mi8bbLs9/JI8YzFVKsY4hiniJ5rYxFDR6Z4tcwvw?=
 =?us-ascii?Q?AvkRh3w2r1GWr0U1ss7NzgBQ4I2c6EVI40KMXUx7qyTIKREmb59gslVbj4ar?=
 =?us-ascii?Q?38i/3A301Ff3m2BjLpNXoiX4hQ9IO4i8Zv8Zx8t/L96864X4wIiy6yTh4tS0?=
 =?us-ascii?Q?3j+dmRVR9tz6HCgXYDFR/VTBmavl6hZ45O7DoNWCjNIHNNh4zUr6rIfyFsUz?=
 =?us-ascii?Q?1FoEA7iHzvSrKd2xG5+8xNQYMe31MDJyFBR9mOU37S6U69hf/RIaod+EGlp8?=
 =?us-ascii?Q?xsfuNFr81HjuX07JaJFz+zr/yQdxm/K4mxpt7FH+IQvZxrPXg291FG9O/D+p?=
 =?us-ascii?Q?8gDuE00OSMdyIkFZval7jmV33wIk/9AQBfrIpFhA7aeJ0/pc+MQLnmCQb5qZ?=
 =?us-ascii?Q?73pu1Y9rpCKjw7bBTy71jZmBlI/0l4tt54xbjExxQ9TGpGGe5R82QjS4HFBc?=
 =?us-ascii?Q?7lY7pvdVyIcBplAAP3uXdkROjo0gSJxfRklKL8x9BvYICJflb5lUTaQyxUod?=
 =?us-ascii?Q?Q+GRhzoNvhFCvmvinxp86E1G0qqTrdFJkg/Yu6S3QsUW64/PvYTCxyPXC1v0?=
 =?us-ascii?Q?nR2osHsM39oJwCobKR2kKl5XJ9Ofer2Dn/xz9gPLoo6oFd675GBUYtJ6EPds?=
 =?us-ascii?Q?MFzjCMa5+qcOpqk5iSWJ8BVb9AH1fwO10Mu6IAeMQemT///mCq7BnX+bEcaE?=
 =?us-ascii?Q?se3Bq0JgucZOp5M4+cooL3/QXXnxM0hyb8LPwWm0Gh4SdLHfs1VLkMqcdMFS?=
 =?us-ascii?Q?cIGa2a+JIV6DEJz4W6khwvf06jyacJZB+zg60Sz0bp50xAdX08JLdeSlY9nb?=
 =?us-ascii?Q?D4H66A+bKfZYoXCiTH9+G8qznp0fI5KmyOez30j/kL7ehQuoPaouJBiQNDJW?=
 =?us-ascii?Q?d2IET4K4GIpTpGrXoMpSx5wt8NP94sZ7d027eWagHw7OZ8XpCDwGAgmYtiVg?=
 =?us-ascii?Q?oPThilOnprRwzCnMN158JmRIol20hroavGNGEmE2752FV7T3JS4uxgO12dvH?=
 =?us-ascii?Q?WLD6+79VviXpwWdb+AxnBOktgqWcBBBUAIeQo+CZ/hjk+gdgs7qX3zTUtEis?=
 =?us-ascii?Q?AxwO+usRTVlYzmv7ilVbwcN/LaVMO3jceymgOX4F9BR289Onnixlj6jUlIhF?=
 =?us-ascii?Q?+jDotAUxl54jiBAGxiZeZuuGhdMwhs1nqwwbAfr57axwjA+ns1FTwKg93c7D?=
 =?us-ascii?Q?d5febqt18m1ddkcDy4K/TXf0a5QEtNtqhgz+Ro9Bz1NIpDm4J0LbWrpzqvis?=
 =?us-ascii?Q?Sg5XTBLjqCgVhztJfz/BUsswIWkn+PiZi9xyrgNlF2DdBMtFOzmyEOmx7NUi?=
 =?us-ascii?Q?01TSYeMEX5yXAeJ4EC0xrXRiImksRvQNVOe5yp8SWvQxI7R6Eb1gQIW1Mu99?=
 =?us-ascii?Q?zcGrGZH4Dx6d+hY5qWH9WGBJQrhAW5HTVo7RTBGLXmx1uSe6I+iz3Zbp7UIH?=
 =?us-ascii?Q?3nyYOKPUCJnyjCS/zZU0ANWR9kMKbryqiQuO2gfA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f74694cd-63e2-467d-b691-08ddc05b4d36
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 09:14:12.8942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ermt19dcWUmvQKEQ4OezxhajeHJgY4GfoxZTg4VkMVKcnE417GYBtVieLPiaY00BM28p2uYlQFDKSbfefKdXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7708

In the current driver, the MAC address is set in both fec_restart() and
fec_set_mac_address(), so a generic helper function fec_set_hw_mac_addr()
is added to set the hardware MAC address to make the code more compact.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 26 ++++++++++++-----------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 00f8be4119ed..b481ee8ee478 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1123,6 +1123,17 @@ static void fec_ctrl_reset(struct fec_enet_private *fep, bool allow_wol)
 	}
 }
 
+static void fec_set_hw_mac_addr(struct net_device *ndev)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+
+	writel(ndev->dev_addr[3] | (ndev->dev_addr[2] << 8) |
+	       (ndev->dev_addr[1] << 16) | (ndev->dev_addr[0] << 24),
+	       fep->hwp + FEC_ADDR_LOW);
+	writel((ndev->dev_addr[5] << 16) | (ndev->dev_addr[4] << 24),
+	       fep->hwp + FEC_ADDR_HIGH);
+}
+
 /*
  * This function is called to start or restart the FEC during a link
  * change, transmit timeout, or to reconfigure the FEC.  The network
@@ -1132,7 +1143,6 @@ static void
 fec_restart(struct net_device *ndev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
-	u32 temp_mac[2];
 	u32 rcntl = OPT_FRAME_SIZE | FEC_RCR_MII;
 	u32 ecntl = FEC_ECR_ETHEREN;
 
@@ -1145,11 +1155,7 @@ fec_restart(struct net_device *ndev)
 	 * enet-mac reset will reset mac address registers too,
 	 * so need to reconfigure it.
 	 */
-	memcpy(&temp_mac, ndev->dev_addr, ETH_ALEN);
-	writel((__force u32)cpu_to_be32(temp_mac[0]),
-	       fep->hwp + FEC_ADDR_LOW);
-	writel((__force u32)cpu_to_be32(temp_mac[1]),
-	       fep->hwp + FEC_ADDR_HIGH);
+	fec_set_hw_mac_addr(ndev);
 
 	/* Clear any outstanding interrupt, except MDIO. */
 	writel((0xffffffff & ~FEC_ENET_MII), fep->hwp + FEC_IEVENT);
@@ -3693,7 +3699,6 @@ static void set_multicast_list(struct net_device *ndev)
 static int
 fec_set_mac_address(struct net_device *ndev, void *p)
 {
-	struct fec_enet_private *fep = netdev_priv(ndev);
 	struct sockaddr *addr = p;
 
 	if (addr) {
@@ -3710,11 +3715,8 @@ fec_set_mac_address(struct net_device *ndev, void *p)
 	if (!netif_running(ndev))
 		return 0;
 
-	writel(ndev->dev_addr[3] | (ndev->dev_addr[2] << 8) |
-		(ndev->dev_addr[1] << 16) | (ndev->dev_addr[0] << 24),
-		fep->hwp + FEC_ADDR_LOW);
-	writel((ndev->dev_addr[5] << 16) | (ndev->dev_addr[4] << 24),
-		fep->hwp + FEC_ADDR_HIGH);
+	fec_set_hw_mac_addr(ndev);
+
 	return 0;
 }
 
-- 
2.34.1


