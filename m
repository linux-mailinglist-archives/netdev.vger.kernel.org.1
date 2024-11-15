Return-Path: <netdev+bounces-145155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9DC9CD5B9
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 04:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46FCD1F22101
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 03:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DFF181CE1;
	Fri, 15 Nov 2024 03:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RQiNBmMl"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2041.outbound.protection.outlook.com [40.107.20.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5694317E017;
	Fri, 15 Nov 2024 03:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731639835; cv=fail; b=kixjAxVRQqH9VS4gZCRYbjK6P+m3D2sqrPLQvdwlrt43Jc/eFZiUUsHHXUAI1O1FF7LbJS0Im4uXPJusl8A3IHUREq72p9XqqrF+teS0f7WhfBBHNAv2eIGW+UAnwL4Ot4ejmFfhn/GkAdW4LNmzXBwDdjSGC8Ou5yHOpTNfDbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731639835; c=relaxed/simple;
	bh=Nkk4AxYQjfxXdQi3GPscmfEoEXJ5yNP8kfWbHa31cok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EbUZ4XZE+otLQP7gIADu5pSmm+/MSqv39tnLcp453D+HkMcLKNH8SSsDKdiMmlrQ9nWojgrRL6c8GoWS03sPvSyBrEZoCeN4w+uCAvdcdLp38Fw6jYTaFx0eVoB2ZX221aRBWeh4KHCSfhboZU4kMAuIg08qHlYQ9p31nB0Xa+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RQiNBmMl; arc=fail smtp.client-ip=40.107.20.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ccRkElgwHP7ctIz2BAUeNvXbj30mCHyuXDjnwhD6P/u1C+57LREAtAJ0qLO3S9NShJCJeolXLTdWoIU84Ps2dGQgeXm0ksbzBBEx1M26WWKlThfca/E7W+f3NNnfl13gHH0n+tRvSDxwSKPVKTb+HCiQ7HWTl3ogp0QEj0GH/EaGNVHp42nHQRQCjizCSEM4U0iEwz/FljydX4nZ4OfiSBF5zSmK5+8nsvYpoHfqHQMNwgeg5ZhugfuP7FWZTwBRrU/snBGzYwuxtNTuaBY47buQLbsSIFmKSgPBOBC8knwXkjzT2giY2Bw2khObEgsaX+IQ/oTI0XiIAS/JO85Jlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSRSkCcH5OvfN4cZ4Cjkba+bZxVcDFUWG7inqlrM8mw=;
 b=YHAm/RQIvJ1/dcJqnNquiYfyvtyf4RZIhwZuQkDz08Mbp/QmYXntspFhERhHC5jNTIRwshIVSnJBVgy0Z57or+3lXJcKHSorbqHFdcuywiwT2BemfOOp2+LR3502mUbE3M3OfZwRNiV8xAIfEYIajdaZfLORiOOPBEHLrfdBVZANA9kikwnQRYhlmMwuaspg+b96ERUNfhvL3zh7bnymfCPJsqZ4NX6iyELQzNEKwAYLhOoW3g/+EiNr/4ESamDtC58aks5rKuPTDt6wBkHseuhlo3S3XYt+8vi/72RMD7pgp+CgD0nYZOc1+ISDKbrm+Ker99FW/0tONamzPD17PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSRSkCcH5OvfN4cZ4Cjkba+bZxVcDFUWG7inqlrM8mw=;
 b=RQiNBmMlhQ8Bey+Xu+HlDEO5aLSSgVZTY7tYGgGxhiFVdS3MTzy6I6xCNA6T0tHfbriJiGf5YbF7zH6ANKuG/+TvbuOQJ/frynNqiJf5y+Xd4WSBRO3vWUsFVIx2+/iNACCUkbFcSImdCIXKrVd4vElYZzoJ+AOMu/yam93p5tVV98oQa+0KwpczruDIse5+iwdH4ZgnR6aBsp/CdFxXagp38V3XpG6lMyAlPKYs29f7kHs57yDfTA3KrxNparCGs8wYWj0yc70dD4gBkpw9+BmOba3GY2uKRvGjaYO1nRrxvXIpnFTi7Z5cl2lQR2OiWsINrrHv568CjZFR2aD90g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI1PR04MB10028.eurprd04.prod.outlook.com (2603:10a6:800:1db::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 03:03:50 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 03:03:50 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	frank.li@nxp.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v4 net-next 5/5] net: enetc: add UDP segmentation offload support
Date: Fri, 15 Nov 2024 10:47:44 +0800
Message-Id: <20241115024744.1903377-6-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241115024744.1903377-1-wei.fang@nxp.com>
References: <20241115024744.1903377-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::15) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VI1PR04MB10028:EE_
X-MS-Office365-Filtering-Correlation-Id: a7d0fafb-cbeb-4140-e9b7-08dd05222170
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lrjqvaX/+CnrIOm2vHoWMwAJZiRYJ9jvrNXLFQPEhqhYyxQofLnJw837ynAg?=
 =?us-ascii?Q?N8NOPvc6BHJvKU0xBZO2W68nJBIJMAVMcu31HLDN7jFdtHBunBr4c2LkKGjn?=
 =?us-ascii?Q?DwUudxYIqp/DyIjIC1P5ypxXYtJFHVXE4YCYoBF6C+KToigth+tOMAf1GIQX?=
 =?us-ascii?Q?pOaTnsGr2hGIrqXGQZ3wcAeEZow5Rs2zcfIWzlZaRnkBdQys43b33jkyMxZE?=
 =?us-ascii?Q?lcFPkOQKslpqdSkXT5uuVeWMui/8TtpoKomF3RPxFkQ5OIBCscZ+NHGhRItN?=
 =?us-ascii?Q?efU5QpaABCcZZ7lKbgjixwdrwf2dm17q041YgQQJx13yL2bVgJxoBYq/69mO?=
 =?us-ascii?Q?fG5HHFge+4sZ/WcLzqk4/1C0DfVVMwcwiOQ/4/iRtj3Enh3mf2lR1DaxdKkd?=
 =?us-ascii?Q?pN0oJpiZCiT5XFAdww4PKk1cHO9VmNaLdHcV5btOi3kiD2/Fuv5Z79MI+RV+?=
 =?us-ascii?Q?ewNRfZCqvF91aA5jZDhiHhZwdgGw2nmGZNvUxQntYp2uqwl9II2WXaQyIKuB?=
 =?us-ascii?Q?md8sOLMDKLlqJXFLX513yXgcZYiA3FrxyeajGi8K1mnwCV56tjcJ0H/R2/Y4?=
 =?us-ascii?Q?+s6cQjxMQ232qvwfYI5yUkJXHTweFLC0Df1PpWy0c+1BhRXXcnHA/KyK2oLF?=
 =?us-ascii?Q?t9zuk8La4DZZz5KPUGI+s3A/3GYC38MqdIXKYs9CVgAC3dI6wc9JfM/3Ujuo?=
 =?us-ascii?Q?YKetEwjJE9Bhbb3OV+s8nXIJDKZ9PnTCC2x/YF1BUj6KCBUM0HS9iZmI4LUZ?=
 =?us-ascii?Q?57LSnQs4X+aEW1HviHWLsIDkbtrP0d9/1BEZyJJmBj4eGj9PJF6JjAE3XIm0?=
 =?us-ascii?Q?hreDedKLcq7o4nf7qDJmJoNh1hWMuPY4bDZRL9s+EWXfykzajirkxIA6/BI9?=
 =?us-ascii?Q?l0+kHC9oXpFtm6s/Zon9XOhdT5G0ICbBHv9IMwePVzDQ+5uRwM4Uqn46VCJ8?=
 =?us-ascii?Q?abpzNPrurDLgZuaFbLFXAEEYVTsrMUGzNNrpQo88sY1arNku4IYW3Y48PVWz?=
 =?us-ascii?Q?ROvTtRAjhnc2XRKf/oyokqeYSnMxT+Mbi0vj453vV4rFvQIrJIpa4Dp6gR03?=
 =?us-ascii?Q?WY3SvoKwWFAveERepz/JNNXhCq/H8VGo5m8FnHNUOfwPokRMVXId+TSL7kBE?=
 =?us-ascii?Q?ETPdvUJQ6n8PltDD3exzLSltC5RN3y16x/ybRL6BBGbMs4+CsmwDr+vsSbtv?=
 =?us-ascii?Q?o22nNIorxuxaZ272arJjulR+lz2Nj/IGHFT456LJyvmjIiWJj6N5rbrWnaJX?=
 =?us-ascii?Q?NfRxEfVQC+UrUqOSn+edSr/AVKtzU03V6I2unpOiB+yF9ltpxzW9eUyycool?=
 =?us-ascii?Q?iiN7w2QdGhJuyCQxgb0Qz2zrg3Tu8WVwQwPFb+9rLjvHWgFJDFwzHjwfSqHs?=
 =?us-ascii?Q?H8Ki+n4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mdzw2PxkViL7fmxGSkqB2sYdq5Ewj8jGI3Q28LY0kUbPao6zxkw8Bmtd+EDP?=
 =?us-ascii?Q?+uW+P36JS7yaAR07eNpQd1tdLHN7a3voDRvLIGV07b3+9OoFxnhVZeoPg2cn?=
 =?us-ascii?Q?gF+n9byrqcmxmE0Ul4vb7u/zqqr315npkc+WgnN6qvfO2MGRHof5YA2es7/q?=
 =?us-ascii?Q?loLjLaX0qrvPqCxyRdhn7YaZsIHcFrJJR4zz0OLxtoNxuFQ/9uzr0ZaJ2D+a?=
 =?us-ascii?Q?ikUaiLdzWL5vZS/F/e3V30WhFhqQl9BowJjxS6ToMasJ8PwzpG7XpXA8AQt6?=
 =?us-ascii?Q?ihawBb2jSJnJc4V6Q+GDyM/7B8EWEUIlYH3dr581fahfytNRamtTti4gBgOt?=
 =?us-ascii?Q?9vEaI6VhXTAXCI5Fpv+uqZfTfPKNZhgJsBr/QUGyVKAfuVdQbBBBOZtb5dyi?=
 =?us-ascii?Q?DTyxbunwSA7KC73vBmqBrzqgJFtISuAtH/6kMd/nbPUUQn/d8EN6KbO4rgvR?=
 =?us-ascii?Q?DmR3IxWqPd+9chfePF/Kz2GPqgmAmdeWrVSQoutg84V8Vc0y5ZOUvsf3ywuO?=
 =?us-ascii?Q?l4jsifQPi2ylf5LkxxP25mvmIKjqt6h/dNn5v+Th6TxfOXCtb1R+t5III50g?=
 =?us-ascii?Q?iRyLFcyJVxWbAMzy0Jxi3KyEmyUDCeLwsrPdBNMaiS/QBgjqBrRMtwHq2K5K?=
 =?us-ascii?Q?Mqdn3O5upYDIBB/WdibSrYISz08wRuiZuAk5cqAYPiLzhHSMiKW/oLkm7tUi?=
 =?us-ascii?Q?z8Vncy/Fc0n4JFI1zIVQVa15N7I2n/UMrIdtvVHSgnS53YVYaNfEuz1pgUiz?=
 =?us-ascii?Q?L045exNIG5rFVFSsE131a3EOpixUkFfm+QklXLKfZLYaiyq+YLwTgIRi2k8N?=
 =?us-ascii?Q?p1XMCDkit1CeFf6bm+ek4oesQCN+C6uwH+mEIhXVBqR/M4yA9iukiO9iK+ig?=
 =?us-ascii?Q?eF8W7cAFpO4ijCM8dKLj0X0BvjuES87Hp41E5GuAV5HiDJ8ACCck9+YEn+V3?=
 =?us-ascii?Q?+94OdWTaR3Djtbpt3pyTkebzj73YYVetN8Cgtc/lV2s3lfUNS0ej4axMqOwy?=
 =?us-ascii?Q?Nv8EuvKHs+A1n3IdJjhPzACXs1hDWKq4mQBCy9KJRB/LCxaqf8bKBJTPcZIb?=
 =?us-ascii?Q?HSdWLhML1Lqh40dGyOYN63qtpEMv31x2SKdouQ/TMVBp7zdOEnvFoq2x06sO?=
 =?us-ascii?Q?tuV1ZWFpvmMu+7tvkNIi4v5k8fd85/Si6IlW/Eb20/O6MiDpchlx3+3bSBBG?=
 =?us-ascii?Q?PJhi8TnUZYqJX66BzCLKSGcHmkPk88brYgRsmzyyQpH9A3aVQej4U6bzk/4o?=
 =?us-ascii?Q?2sjM11vQpts+rjFzoOEAsdpuDX+wSN9EArpcEyle5cLZ0TIYdiwvhzIOtohk?=
 =?us-ascii?Q?6kDI3Hlp+TsUs1KqsKq8ptEy8jhobsJPz4smj1pEJUo2A4dEf5nUI69oMmxB?=
 =?us-ascii?Q?BNk7o2opkfwiNQ5Fryg6NrYdDmYeJACU6t1KXxieZJxPlnKqLAi1sfJRw1AH?=
 =?us-ascii?Q?BXIZTxIqHSZncOApKddXsle8dosRz//5l1DQWX4cfz+3OdfM0nWjAPz92Rvx?=
 =?us-ascii?Q?VDS3BZXcYIzSpVj0BCwIFkZ47T0Z0wz2ppN/CqiTBED7+31AUl1mGEtelVBo?=
 =?us-ascii?Q?oOzIl58ZFfPc+18O3HqPANgMXweItEPVq1SrKgcP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7d0fafb-cbeb-4140-e9b7-08dd05222170
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 03:03:50.6938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3rPHZ1+L+rHSFP1rvm9lGQi2XQkmnhH+YARIg/Qt6x0aGVMrWZoafhXfenPve18U6EkcvYQ9ecHJwLdmcwtMnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10028

Set NETIF_F_GSO_UDP_L4 bit of hw_features and features because i.MX95
enetc and LS1028A driver implements UDP segmentation.

- i.MX95 ENETC supports UDP segmentation via LSO.
- LS1028A ENETC supports UDP segmentation since the commit 3d5b459ba0e3
("net: tso: add UDP segmentation support").

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
v2: rephrase the commit message
v3: no changes
v4: fix typo in commit message
---
 drivers/net/ethernet/freescale/enetc/enetc_pf_common.c | 6 ++++--
 drivers/net/ethernet/freescale/enetc/enetc_vf.c        | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 82a67356abe4..76fc3c6fdec1 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -110,11 +110,13 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 	ndev->hw_features = NETIF_F_SG | NETIF_F_RXCSUM |
 			    NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX |
 			    NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_LOOPBACK |
-			    NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
+			    NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6 |
+			    NETIF_F_GSO_UDP_L4;
 	ndev->features = NETIF_F_HIGHDMA | NETIF_F_SG | NETIF_F_RXCSUM |
 			 NETIF_F_HW_VLAN_CTAG_TX |
 			 NETIF_F_HW_VLAN_CTAG_RX |
-			 NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
+			 NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6 |
+			 NETIF_F_GSO_UDP_L4;
 	ndev->vlan_features = NETIF_F_SG | NETIF_F_HW_CSUM |
 			      NETIF_F_TSO | NETIF_F_TSO6;
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
index 052833acd220..ba71c04994c4 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -138,11 +138,13 @@ static void enetc_vf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 	ndev->hw_features = NETIF_F_SG | NETIF_F_RXCSUM |
 			    NETIF_F_HW_VLAN_CTAG_TX |
 			    NETIF_F_HW_VLAN_CTAG_RX |
-			    NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
+			    NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6 |
+			    NETIF_F_GSO_UDP_L4;
 	ndev->features = NETIF_F_HIGHDMA | NETIF_F_SG | NETIF_F_RXCSUM |
 			 NETIF_F_HW_VLAN_CTAG_TX |
 			 NETIF_F_HW_VLAN_CTAG_RX |
-			 NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
+			 NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6 |
+			 NETIF_F_GSO_UDP_L4;
 	ndev->vlan_features = NETIF_F_SG | NETIF_F_HW_CSUM |
 			      NETIF_F_TSO | NETIF_F_TSO6;
 
-- 
2.34.1


