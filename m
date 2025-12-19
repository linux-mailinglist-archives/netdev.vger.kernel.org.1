Return-Path: <netdev+bounces-245484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8A5CCEF8F
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 09:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DA6E1300E747
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 08:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD992C1788;
	Fri, 19 Dec 2025 08:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hMPhvu0K"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013063.outbound.protection.outlook.com [52.101.72.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92C419CD0A;
	Fri, 19 Dec 2025 08:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766132940; cv=fail; b=kyWWayBrOHqRtttWLH/1Bvz6hLRF4UydnjXrp60TXaVxTtO045Peux+Lic3cvFquVPRRkxRMSIL0Af00QqhY9UXzR8Iyn0eY1uF9T7SMi+J2bWrimWD8hDthMdlS8IAplhWQgSdJHBzHEFIinztVxEzwnOxXz0DVZzGMT+iGBB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766132940; c=relaxed/simple;
	bh=MqDl6u9SnbDbvnibE47Dgq3moqDHApX3yqzc2oJehAE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=chjkvBRpJHEuXWA8pVD8xX3Z5WkgYz4DtVpVX7uQL42kJ9E63hnkekU46s40mCFranQEh8PeAD4pEMIjTXT7UaiLLK1SlUXXaF7I3128qBtXcOLI9oZ2+Pb9Hc7asCEoOnX4okrxfZmXqDCMBfBLJif1uoYQa0gh2IYnTJkyZWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hMPhvu0K; arc=fail smtp.client-ip=52.101.72.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h8akMGRY+w7g6MHxt92+PAWHigeAkcyZg/vWlb5a1ykhCRaK9vlNpP0l4kZ1m/Q9nNfyH0lpciUUpD0Ax34ZwHaaiV36yBHL7Frk35/Ui8rDyVrmMJ+DDm/MQqRjOo5d0NF/SUfpQWnRNTBgFq+uxHsqJk79sT9TNa52wQKflCr1nrfjycDozir3Axh36NL5EwqKCy+nDtJ2sC5fbkSNywoWh4oF08I/g4149DPBGaCASrMd4mvIHzKsunu+tfA3c610ijwdb73aEyCdYDe9wgmg9MrBqnbsKVZiKYtLLmvijOtprQfgKbBWiVIOJ1CgqMagwxMfEH6abYmNrcyDJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ky6I9T/uKVPWoV5hBTRotRHm/l/X9sCVuO9weDw3NVM=;
 b=OGlB87n91J32Z5YcS+1VMPyKOltTLU2yZqtHWCqdMnKjNp6g2ClS9nnkt3YEDZ9nyOQAp2BKcAP0jxq/Lze7YMFcJgB9Im9tKjvEX0T3eX/LQLtOmQF0qNzod/j5Oo+Xh0jWxbMOQcwRHhVfuV+htTYC7SLRfK4l0DJBTbpvvyv+wlhAxl8EIKFbaKf23ZI6fjbOSojzSYef2s65XdI9/H62ox721K8PxnAjpHnXWAIzsqYbLEZKlFP71q8C7QNZ5BOGHmTs+6b9bRZBS9bCTJLBMKP8508zXY/wVqzleUWr3VpiDrg0fMRVtsR7iH3Hsflj4GMH3nBolEOGegxhRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ky6I9T/uKVPWoV5hBTRotRHm/l/X9sCVuO9weDw3NVM=;
 b=hMPhvu0KJCw0TjI+IluJrK0YRiaSDmktiN0ud1IFI85fLovclvGZNbLxfxGq4rUw33zyfFEuAIoFUoPhsqrA9I9lKf+eB2j8jEDiUL/Idlc1uUD9loI0KPJbc8cTgGHAxyv+/HVvS1KO7Gd/Li80TmY0pVePRFhrpp8QLwpriYiF+Hqv7Slnqn7If3Qs+/KyFBjgU+SJsB7ancX+ziIf+Pa2uvRj5mv1fK5LvCapZwoyTcUYMQpOonYhNK1MPb69CiBp96PrwfK4ELF3CISY0P52tb9UXP0DDHwV6M5cHddQRGOfIUwqo++z69TzO4RziOjaWHAUcn/pw7IxeMpvVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI0PR04MB11613.eurprd04.prod.outlook.com (2603:10a6:800:2fc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 08:28:55 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 08:28:55 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH net] net: enetc: do not print error log if addr is 0
Date: Fri, 19 Dec 2025 16:29:22 +0800
Message-Id: <20251219082922.3883800-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:195::22) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VI0PR04MB11613:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e1593db-6bac-4e55-2b82-08de3ed8a5c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|19092799006|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TEpF+bHa6gbUfAj4jCzEYNB2KB4k3FszrwMVoPn77SUeIGEd5WnAM1NUKkil?=
 =?us-ascii?Q?QkPrfj3pTm36G+3vGXyBl2WVrwjXiMX1jBlvAWi6mK4AJ4fBc4yjkl3FSl0S?=
 =?us-ascii?Q?imY0gVxqDg9TJiICqYGBlQahARZNGL+9+9tKv+EUrYZOO6UhRAf38LPaFlQ5?=
 =?us-ascii?Q?7JDHyKs7exJcSLuTGDJjkRbZl0xmO/eKKradtUb/0vwSwNFqtPzqwQf0UOzT?=
 =?us-ascii?Q?S2bvXGZEwt55r9eN8l5gW748odrHf8G5Bvc+ynohBHck95khbovfWR8tW5qB?=
 =?us-ascii?Q?C3tXDxSTqHP3tLx/C7I85LZOQ1T4vbEWlsgffxQCZvaIXQRNX26YyJi/6+SK?=
 =?us-ascii?Q?SN9xjcfhS0f+oyVrsAJpMT9siyvUv03IuDnfsSnyzyfUMuNG2LsEE1UA7g8I?=
 =?us-ascii?Q?dQi9BLfoA1791h/aEdZXR/tLuSg83wrAMKVW6zCKsS9KBMA0PGaiBFNKniYz?=
 =?us-ascii?Q?4VKwjfcqBHU74ySZSgyZk8rakxyvpjneR9CmGjO+ObAshCWId/sOb3pI7S1k?=
 =?us-ascii?Q?QxTGioObfJ2kQVs0Q4EwscoR93+1mrDaiZ3o8E/ehzgMWe4woQCrF418//BP?=
 =?us-ascii?Q?ugqLMk+mAcnC3XPJsLC4s9vh0tAl6ehDXSCLJTn3jDUhHMTqqmJCuOpVD/Ct?=
 =?us-ascii?Q?3/Fw2lnv0/KRJZ6urbpnjbjRj+cC0c5Zn7YuXbELM6vigUh4ZRaueuaAJl01?=
 =?us-ascii?Q?+Ej8jwYQ9W16v3XNTQUDm072dMSOR9+PU2cSckNs/OvmQEz6LGuNTLLf66bf?=
 =?us-ascii?Q?/xPZ/pz+2LjdkCwFJt0lZ6bkjy2LDnhiwt6Msog5CeMvAGURu0LbDeWmhQuP?=
 =?us-ascii?Q?Q9pRkouKHGQxBdvZNm39wNthnd2xquGY2LTOfp6yytzhRTxkFqCIyC8FdJmt?=
 =?us-ascii?Q?xXPOgRKz/bwLVeVBWolk4L2BHgcCTqyTwdajexvsyS/znO/L5NS8wQ21xaCn?=
 =?us-ascii?Q?A2dNZcZIIuRSVPCBue5pNWpB+sayS+NIAcWgGH1mPmwsoQ+vK0AaFX1N5Ecr?=
 =?us-ascii?Q?Oivkh+7IhYIblIxqVVkPiOZz8QYBxeke5hPeJjInvfPfU5uYDu8ga3S3nBia?=
 =?us-ascii?Q?7WWErZlUPM/9NcEPSkPSQdDoyPctcQ+w4Kf15Klh4NRoZxjxD4cW+VLOtcbV?=
 =?us-ascii?Q?0DHj1PD3YpZ81z4TclpXfivDN6WYz0K0vQHaqSgQx6pcWfT0vSLxw9QRLv3h?=
 =?us-ascii?Q?I5a62gKU0PPIE0GxC4yVpMrCsCwax0Xd4n1KmbruzzPvEDNpfCRrj9KC9Gqp?=
 =?us-ascii?Q?B/SjjWuSsBv+4BuQXHbrvhZXIaM7AWhl0OPC59wrjpJ8tfTHFOTWCuFkJsuL?=
 =?us-ascii?Q?V5MbYme8xUItUH4YJzWwC6d1Msykv9JfR4lGt1TGkD2F92I9MH3LAoyFSMvQ?=
 =?us-ascii?Q?53fOxp4r7BJjHDCU5nQdPitGXNb6VWpggDgcOgNYlmsuEd6X18VGxeePvGn9?=
 =?us-ascii?Q?flGrmdNRPToh85hLzJBkR32GlNDCwwNKmPL1ztKSZwRumZA/ncBiwnG49rPL?=
 =?us-ascii?Q?a0PIP07mau267cQd0h+Y5SSE0Fm7GZsbrtnR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(19092799006)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ssog+7QqdXJKu7X7R1yfaIz+hxdk8xAoVtVJKCODSdRHGyB4AXeYXQLpDgOJ?=
 =?us-ascii?Q?bXoZmWhR6UylZwBmlL47iX/CNA4Y+Rq3CjLWexhJhUYQe1iXVCUSbjt2P1Fm?=
 =?us-ascii?Q?fV4ySspCQLWmIpqbjKOExopdpZENJKnXvXooBMKuoz3JkjNPpCODiNqMeLvL?=
 =?us-ascii?Q?iHyvyNazJbXQnJxcpv9JtYX6AXOpx3cpkpOw9rh9TN5Fc6tn1B7zhojZJKYH?=
 =?us-ascii?Q?1c5P/5JmNyo+yCgmus/1aDuacxYwGgjuw+zQT5noCrmCvN1J4O/0cysO3oX0?=
 =?us-ascii?Q?jHwzx0qEVBGy6iCLuLdVpGUuOOepM3FoDCC0Pf1y9NXFh7V8mOviooGuqVxB?=
 =?us-ascii?Q?OEmMNhN4X0FpWrqweCUekoHyA9ALdr3nwECjtKVNCuehSVfaaEMA3mcJnLk+?=
 =?us-ascii?Q?70BHaBY85jGWN22sdLzOWm/Vg6AlWunQMq0tazejWSUS1HuUDPOIXkl7tKPx?=
 =?us-ascii?Q?8VQKZI10m+V66BvrC+VPO+AcLN6Thykec58ZN4HlJYnDUJ8Bp035UuUgxATn?=
 =?us-ascii?Q?gKCP+m7m4W2B9ZuTvIuvaUTV8mBFL1jCeRtej9CdTQO/xeM8VgJPj8yq/grZ?=
 =?us-ascii?Q?Bq8kAoc4nDWduSSPushJLPuGJB7Bpy971+jvDe9teCYTwngZSZu2s7bDkJ3s?=
 =?us-ascii?Q?Fs0PkhtRU10bzimX9scEZtimd1WDKbnoWVYY6l78jJvONvsVysCZbvFmbPEp?=
 =?us-ascii?Q?FeFyUmyuF2t1FOlzqtwujyNWrj0WZHcv2BdlsAkOEMNka/DipCEhsICU3Eiy?=
 =?us-ascii?Q?yDX/jwdimgW6AWKK3zs2PfNWhT736Ri2V1lo4Ll179HnQJVohc3+Lm3tWFfF?=
 =?us-ascii?Q?pBRNrbMxL1pIdqNRFUFgmQQFm27LtVeICe7TwQ+vH2vt7uL/ZbbFImL7qvhI?=
 =?us-ascii?Q?NKZk5EthwFfC8NmUcNF/cHirGmSIAnbj0Kl5txewetefNuYZh7k9rtYoHBmx?=
 =?us-ascii?Q?nKANQfCFQiCImaVg/3CFXoD6RCxLVsAZIhRqg4uu/JQS6/rCG9Z761S3NTjD?=
 =?us-ascii?Q?1kb1psEGxXARSdUuXddT77XAAqUvR1+ium2mHx8uDC8M8b2X9akQ5SSp2DtK?=
 =?us-ascii?Q?m33A+sHXtpP/RryYIl25TBzC+3+VtwQJQFtDf4E5u6eidfQ7XaCnzXRE/cHE?=
 =?us-ascii?Q?aZO9sehfR/RsLMpCprAUbrfU2YfDIB43Q6F0LauxQMKmK32X0OKGCSQIRex4?=
 =?us-ascii?Q?RJwrjEcztZJ+ke0dn9rrbEJ7rLSkZh1UOtTLNBrx5zaQpUjR7m7eFSDAnRyx?=
 =?us-ascii?Q?hu2DfjH2X085GDvb0WQQNvaUsv0TdYW6nNjG7WXJZ8rzhHn/qKglGAViYlZ2?=
 =?us-ascii?Q?UZvfKmRylLcur+CiO2wwwtudiAH8GSVEw8xTxba1aV5LuQ2pEBK1XEMH/pQf?=
 =?us-ascii?Q?rG8X2fa+IDsXeDbRKN4N4k8Y0p0j7oR981NLd1PYPuD97ulwirIqJ4h8LeTb?=
 =?us-ascii?Q?NGe9x/ppLlWkSAn+Qov7NMOrLrCQXeXZttQD1+FuGD5xQG3Juddop+wOl9TS?=
 =?us-ascii?Q?/azt37/h2VeP7RcIIata1Ud/FmBqxny4Lp3tQTdSoEhsLEyQPuPj8f6vxc0H?=
 =?us-ascii?Q?RuFFpaxsgpdlZdFmXPkMjEKz1FN/yHSp+xIDVyTb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e1593db-6bac-4e55-2b82-08de3ed8a5c5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 08:28:55.2287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hqtd0IjRPH6bubo03fcWrHRZ5mYztWv7ZNO1CgPIg5RkD6m0chl5kKwDDgkRBxp5TM0RROyXWBUayIDf0LCZUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11613

A value of 0 for addr indicates that the IEB_LBCR register does not
need to be configured, as its default value is 0. However, the driver
will print an error log if addr is 0, so this issue needs to be fixed.

Fixes: 50bfd9c06f0f ("net: enetc: set external PHY address in IERB for i.MX94 ENETC")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
index 443983fdecd9..b2d7e0573d32 100644
--- a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
+++ b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
@@ -578,7 +578,9 @@ static int imx94_enetc_mdio_phyaddr_config(struct netc_blk_ctrl *priv,
 
 	addr = netc_get_phy_addr(np);
 	if (addr <= 0) {
-		dev_err(dev, "Failed to get PHY address\n");
+		if (addr)
+			dev_err(dev, "Failed to get PHY address\n");
+
 		return addr;
 	}
 
-- 
2.34.1


