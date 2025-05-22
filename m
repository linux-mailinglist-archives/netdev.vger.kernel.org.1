Return-Path: <netdev+bounces-192546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AACD7AC052F
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 09:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C11F1BA4FFB
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 07:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04055221FAE;
	Thu, 22 May 2025 07:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="G1xsmSy1"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16D3221D8D;
	Thu, 22 May 2025 07:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747897372; cv=fail; b=piKVqF3hwdZ+6JKigAwV2Q5rVpgt46XsHUsDx+I6yRddN8oBkMV88yY5APp4SGvkml6wLes9hYEeUODpRGQU/2BuhJuQtnSq5WzTO8ABL8iZuPw64cNowM0vsDXUywGdthnllHYdgHdMM3PURBg+IMPe78TjnFjRfvXw+NqeIBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747897372; c=relaxed/simple;
	bh=pmA69DFdEllbzakDyDDapHuO65oY+QUGt4jaVc7q20g=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=mTy6S5iZ6ntOoZ2Ou7nO2xpm+cIif9C0a0Yn6iTwJwDZgr5x7BDgfsOf68RJdYmEgT/WjQndhlG+XUtTdP4TxbLs4j3VP5wwvsgsLDwWVjHaUkze4u+7WEO/aOGFqK75TWfK5n05m9snJrDnJvEraa0eL17dDrK/MU2Fdw38hI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=G1xsmSy1; arc=fail smtp.client-ip=40.107.22.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P2VKUQFZG0RXp/Xp81JbWU+7yjJN89+wAfFQn4PKGLnEXBSF0aBXW/9OhOlUFeRrSsLC+SXGz6v2XHm0SneQg5G/0TNgx+AoprYKYwjxgsXeORx5LjtE0ZWb10kRKlULr3nyrA2rtqNA9AsCe/7rz06U2c3L7dI7GhC8v+j/vgHPH4WHdpcT5AYXlrFw/FFwgRG/K92TEbGdCD6p/RI93ofsSe0l28KASLCdQOhWN+J/LHHqmIeg+KpJL1lrPP117cGLYKZEZvyB91dQvkn4dfcDf6wmPlmRbnO8Nq+N+HZm0htcO/NzDQZs0JMtVxUjQfs6z/At4+AwRTcOg+Hd8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1vTKZ4Ljdj+MvSx0ga/zJOxDrEZOQFM+7Y9MTW2NRY=;
 b=I+nrc9xy9jvVeYGu4ojWF+5lNovKQM5uPR6jzjMRWF5VQUoSGx430xEL72mlYLdyhmCYXyorpyAvSAcZU4zta6zP99yewO2dWX/GFhe2b99mnAzKT1qIBqwozrrTf9qJ54vZYRqBHn5PozVafyAatYRnXkV0rP2msnf1Nc5KPVj7MbG12pzyJp1uOYOF9ADjFzju5LXGWb/wHuMQhxbKjy+W1YSy/r0cENZW8wEIeOndWm1gYGo6/eoHHZ9M650doTKvJAW69KEtAU0QoyDNSFpk7V/Lem/eVgK0pOp35sV1eCKCVF4Lf5N78QjoeyeHxjrdCchevrW/tplbvVyPzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1vTKZ4Ljdj+MvSx0ga/zJOxDrEZOQFM+7Y9MTW2NRY=;
 b=G1xsmSy1W9dmHn9pxFt452/UZY9uSWIOxty8H/qS3eky6YL9Xz8F0IMt+1pVb+MqVkaDLVmLMdrcBjmz16Ymu9p2TFGuYUqrNaF10sQekfO7FRCjReYwwnQRTX9i2ZIxrUU9d6HDopoicf2R016R5pZWCGZzu1QknhkALtwnjpL5xjL8Wol9YxgkWkJf92yxSBs2o0WGCO0RExsAR1ui1T0kMWZiqtriUoRv4Voq2x1QfytOkoYBJMIBCMU/f9cRJVBQ9gsCMm9mem4fRENlo29CLwgUy/ZGqhoqh/RdOeALtIyn+4hqKbKQ84EhPTZ4yANH3k3z3LTFrXruUlL48g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GVXPR04MB10754.eurprd04.prod.outlook.com (2603:10a6:150:225::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Thu, 22 May
 2025 07:02:39 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 07:02:39 +0000
From: Wei Fang <wei.fang@nxp.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	f.fainelli@gmail.com,
	xiaolei.wang@windriver.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH net] net: phy: clear phydev->devlink when the link is deleted
Date: Thu, 22 May 2025 14:42:53 +0800
Message-Id: <20250522064253.3653521-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0185.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::19) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|GVXPR04MB10754:EE_
X-MS-Office365-Filtering-Correlation-Id: fa0153b1-a2eb-4c46-17ce-08dd98fea38a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JuqQe3K6PMkrMApU6v5s5Yp24rUdHgSjB0Sc8nM28ohKiaK9uM6iTewU8xsg?=
 =?us-ascii?Q?6TaPM+lq1vASSthF/gjPNG+deqv5ttupoWVCsSGn2XzeZHp0XAcQrzC8N40y?=
 =?us-ascii?Q?kkxBK9L0dHX3uzts5FLtpWZdEZnGT3mq3g1Q4VOxgR/fKoMw0ldrDILhaj27?=
 =?us-ascii?Q?WHO6oZCTMaIUFpYbF6YNxWKH7W7aFX6d6v2+sj/k9YXfSQgAQwENC17IMKUm?=
 =?us-ascii?Q?KJnMQbDZi73nT9FHg5iiwkRu8y1/doQvVq5/ZYB3UTbRG5zxpQRdkeh8WSmP?=
 =?us-ascii?Q?cL4QL2ua7RPerjIi54sbxhcys538Omu2dGkZk6YL/NGRilC9MVRtxLBrSxQ7?=
 =?us-ascii?Q?Fv7cqJ3d69OqAWyc87STbcvApaBqvgEOc98j/XRsM/yXCwEzOU3OHo0G+R1T?=
 =?us-ascii?Q?rFxylGBbuLpnKf6NdLj+rggkenj5vspHC98OWR/BaX5Gb4otRJOif2+QQxbh?=
 =?us-ascii?Q?SLiuGfrpYfBI88hcyqzadiAYhAag9U9E6g6GaXYUXxawQ8PJb+LrchuBNgYZ?=
 =?us-ascii?Q?Aa1WdWxSqmmIZaEe0YTm1MT3k+2bkxWkGFJnurAokPWs/0TgciCcH4zl2iRx?=
 =?us-ascii?Q?00jxKU5+W/fsGuCO0gpe7tQrEr5XZ3xa5sa70ZlPaBH9CzQNG6oZ/RqGD89Z?=
 =?us-ascii?Q?ZS/Dd3HaevyYmbnQL5JOcjKH4A/hQB+DCpZSqcHhRgzy3K8FUfXT/w7uZKvy?=
 =?us-ascii?Q?CyUkYxquD2pOwpmsaMq7ERiebydTVxSDaRbmn0BUFszuAzSPaX4ssyUXZsPf?=
 =?us-ascii?Q?0oeNbO+vbcuCUOeVreqW7V11nceOoAMARQ4gtJfcYGRJIlZtiM5iUIC0mJpw?=
 =?us-ascii?Q?yDxypjvtX1GYmaqkBfGXbZTO91/YRy5PvIQaP08dB2sQv69ITNNnsYVvMzb6?=
 =?us-ascii?Q?zRAsri4vEEHlgpwDy2AyLJ1GNMyaTkoPpKv2pZkAfzs2+mHz8ULtAQW0RTV9?=
 =?us-ascii?Q?BnvuHInzcd8AI2oq32TgrORXTlQoPR8j3qOY1i+/1KCKDnzkMvQqa7OjRetx?=
 =?us-ascii?Q?8/YgXmGM4IiHdnPhZ7CR32BiXgwJbw6UGA+y3ghQBhehTf0sJ3+ncKeVZcv1?=
 =?us-ascii?Q?Wn5FOuL3UfR/1W/vcpjIPZe63d/wDomH3WW3Af5u48xLpB9SzbT/rkTYOYwV?=
 =?us-ascii?Q?RRPLl4q0DIdxnm5+G4xqlIUq1SMo/ciFyj52InN2PUURu8VPX2CQS7MyiExK?=
 =?us-ascii?Q?WWLg5HJS3p3i2x+eKLCHe0GieeN9USo7lsR8/vhnCW3P/XxLbMq0UtYRNxeo?=
 =?us-ascii?Q?sUvhWtf2mahwja8KV/J8B8ed6d7b/UhEYvsHJ0Ft1g+1MMHz22aPNbAHurJs?=
 =?us-ascii?Q?T4YNl5oAQyMcfXnZ3gPUhw+CcXEUBNVOTWukQmmn0h3xoG/idarBcVt2YDeZ?=
 =?us-ascii?Q?F5V99BNDdJPH4g/3bOSWLU0hplgLWz4bBkpxx3AICgGC52Z7PSMDzeQHffrJ?=
 =?us-ascii?Q?ISDyGqaWJDLFAhBHPB3X/iM7zk3noOrkhLvbP5nzHn8MWbnLP2hD5g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/nVKct1E0WYiml+Di7WjHAELU6Ipb1CQK6EsV5CbwUzGUYFEXqGDxD5IOwSm?=
 =?us-ascii?Q?ttzDZseunUzGoaP7Y9Kr9jLREoXb+1Um00cKe6MD2eUFkr5eSzEgK4gaS6+x?=
 =?us-ascii?Q?NR+jKFJ6asMzpklhIWXF9/3ND126KTo87ZOdUmY1SLF6hT/hEeeIc4VXj0oK?=
 =?us-ascii?Q?AzS4KQ38p6YpDS3sJcKg+lUfzLojIJYs+qbCw+Wfh1zjFOD9pXvPwWgNnPnT?=
 =?us-ascii?Q?BSfpMzhzx8G1vFSY+G1gPZoaRklNsIfdbDoazR57DTeiS5OfJhNgvfLUPSny?=
 =?us-ascii?Q?KygBYOa4/MSOWNTjZ06dooheHkPKegq345JiFbQDLvklrjapIUPpIA6GULY/?=
 =?us-ascii?Q?Nk174XwnQYr03PQwISzDYWtGaE7W3Db1H9sx/KU2zbQDfJCbJ19VBZKqub8B?=
 =?us-ascii?Q?ocMqnFcDG5cij7V/LouN9HqQ2L+bwm5pRa/Ub3UfOS5wF1EKaGhvKQLZVI1m?=
 =?us-ascii?Q?bZJeoS25MHy6o+KWslUzjLY/NJjYzfgsW5tlCcbA3od23A8ID3+3tcjIdaNu?=
 =?us-ascii?Q?z5s5F7MZsJDnPgX6wNqthjWonhZsVcJRhIMEsAfHlOCWnTFbZaMLJs2nh2jT?=
 =?us-ascii?Q?NVBoDu7MP4Gmqry4SOL2GA/GJmYOHNoAkomGvXhwAJ0mE6BrT+Jgqywrhe+a?=
 =?us-ascii?Q?+ij30gw3A2WzazOyHpqiMPfNLPckljl66EWq/nfkndhL099wnxUbF+Ka5qFJ?=
 =?us-ascii?Q?7gV4MSGkubMoB3E9oUmHD5gQc3831q7tj6/mvZcVukYSwCbAcLUcEtXZs1i0?=
 =?us-ascii?Q?N/OP/MH+QRkGdzN8+XKc64rhqgCaLrFDrWeKRZcmj1OOvqKcDIQ2UyTJDEOu?=
 =?us-ascii?Q?KEk0Ht/NyTz1PmMaAcvFjLdmFwdZbvc8tUtBpHqZRot4CHVW6TjMVnJvhh8o?=
 =?us-ascii?Q?JotdT27iMTyH9PdEWZjVelTraj3l6K4wlUqZiIGR/itPGFfJF/RJj9EO30/g?=
 =?us-ascii?Q?76Iv/ObiB1lge8q0l9jPlb2z6YI/Tp2WwuU6XrncqzAs9hDylACDEGngzmoE?=
 =?us-ascii?Q?LQXF8o6tas8rO8jLy//QF6y0by64952nrYSVCaWwWVhNPpul7NFbEcn2UOrY?=
 =?us-ascii?Q?Qptyr2AiWhPnnMN+CrEzaU9FenF3UauUkX8hjymIoO3ci9Qs3vtlsLKqNmZI?=
 =?us-ascii?Q?/eEjwNzndt0Z8IDyoK0qlCxK+eHCu9D1c4OKe/Fw27XEJrMVv7UUdUT5Spmo?=
 =?us-ascii?Q?UXZKFl+kpj2H75VaGWPR5nN+aOw/yhyqLIbjwMbBofCvAGH/VA6yolHchfON?=
 =?us-ascii?Q?WHw5kZKKqPBFCddBjAAGE2cD57gSbezuTnkcDi8qZyhMt43/FaFM/nOuSHs/?=
 =?us-ascii?Q?aXUGzFfLaAHM3pUzi3jM5cdRBOCruRllCFpzhDyjov7IcS2f3DRQbuACmSNX?=
 =?us-ascii?Q?HtiuFrb/UgPgXqwyzHejn5iWXD96wPJkruVfneMGLiikUDytrd72wTBMZNj7?=
 =?us-ascii?Q?GJ5jenLYy7kwWMz8BudPmPjAmmM3hw6wr349ijc94E/YZHqL2Dfnq67zqJ6Q?=
 =?us-ascii?Q?VlsfbyfxSI5W9O+5qnUG8ibrTy2hd7a2dnaBQ/gMm5RX2uHyE9gLn/85Nb9B?=
 =?us-ascii?Q?+YK49Q+oZrJViG8RIvJl7cR8wL02edf8EAjpZQx1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa0153b1-a2eb-4c46-17ce-08dd98fea38a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 07:02:39.1461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mLUh2B9/np8HGEzBNbPFw7LxZDT6zCiiJ3ZJA4CTMyvNLbqM0+TkWPksQJCbl/36wA7e2ZYQt0+DdXJOTa6tjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10754

The phydev->devlink is not cleared when the link is deleted, so calling
phy_detach() again will cause a crash. For example, the link is deleted
when the network interface is set to down, then re-enable the network
interface and phy_attach_direct() will be called, but an error occurs
and jump to the error path, so phy_detach() is called again and cause a
crash, the crash log is as follows.

[   24.702421] Call trace:
[   24.704856]  device_link_put_kref+0x20/0x120
[   24.709124]  device_link_del+0x30/0x48
[   24.712864]  phy_detach+0x24/0x168
[   24.716261]  phy_attach_direct+0x168/0x3a4
[   24.720352]  phylink_fwnode_phy_connect+0xc8/0x14c
[   24.725140]  phylink_of_phy_connect+0x1c/0x34

Fixes: bc66fa87d4fd ("net: phy: Add link between phy dev and mac dev")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/phy/phy_device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index cc1bfd22fb81..7d5e76a3db0e 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1727,8 +1727,10 @@ void phy_detach(struct phy_device *phydev)
 	struct module *ndev_owner = NULL;
 	struct mii_bus *bus;
 
-	if (phydev->devlink)
+	if (phydev->devlink) {
 		device_link_del(phydev->devlink);
+		phydev->devlink = NULL;
+	}
 
 	if (phydev->sysfs_links) {
 		if (dev)
-- 
2.34.1


