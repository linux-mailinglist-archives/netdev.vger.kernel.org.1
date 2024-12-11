Return-Path: <netdev+bounces-151002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6A29EC510
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 07:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DFDD167B42
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 06:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721E21CACF7;
	Wed, 11 Dec 2024 06:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DTnUxha8"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2073.outbound.protection.outlook.com [40.107.21.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6E71C5CCD;
	Wed, 11 Dec 2024 06:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733900062; cv=fail; b=ao1pi7tqoUU75D9IyUbKZy6mhB4B16ovi0PvybWTyE48XKn1dCGPj9ty/6vxuyUxJZZP8G9kTj1JJJAiMozDvjIaKrgQbSP011NlTNCZe+mVKI5i/QRdQ0w6fqIpkFbD2yNrzGY6cwLrqkkqCJfL5pwwPw2LOBOUIqtHM7QOxEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733900062; c=relaxed/simple;
	bh=eZ+f86BtXZnFrFVtUTGtIbNQ7TesIQCEFQMtsIZMEsU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h7PUcsypeZeJbfB3xd/Miw9rsLkaHim0888WIqcECefSjuhWkt7t9YXppL6R5CJHWriR+WVRz6M3xqs6j+76zKwvy8FznGrFsQh7xRsaJy46CiEil9NkwXKWHCJMgTd+PYl06QYu2M8zucXrdcKVUWMxgqx6J+hl2j1duygV9FQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DTnUxha8; arc=fail smtp.client-ip=40.107.21.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j+fJcb6oQqDDebWdwR2d9mte5uorsb9ONQebv57b4kmX/oQ+LvyUkIByzUxutUtsz9TIHGZMTIszJL8iFBGVQAZiR0m53pSOJGmcbSZG8lb+6DzqxzxNrjhlylO6tkCvUq4439vJXoLwUNFjujIHDNEO7t8P2o+M7K0OsrTA3jJ2q4i7N5wcfDjbxNSaOanuR8V6AXqr9SpmkgTV0Y1GGluQKVCUAyNcsXpb3yP5M8FU2p1KlMMq/FjTjEZuI53Ew916IXwuswXoQXBzOyzUx1a+Jx6137qDuz7w5KB2VAl7JXR3ToCp7WseQE5Q+gZGon6A5jbx+/ZbFHl9b8bojQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Yyqj/0ldTtYZEIVR+oRp/9wA2PcIxoJtU+g0QhTT84=;
 b=zD3HUdJewZO2bVT7bu9lwxFxDTzQJWm9GHTAldOsAEu4yyFOW4m4Mulc4oIJ7VHrY6i9gehkIDVTmNRmkVWJV8GAfn+eL82kkekUTquCVSLVFO8WzVbeOBzQ0+aepXmwyQNmcVD2cRSkt5oriVemvqxdIWKHr5vLXMq1tepnXVW2GRLnpM92V6h/aGlRBoZxJRrVA6jmpesTHzHT1SOBbgAv0Q8X2kw35t6o94CXzVMqnq14jlqpMeSC2Qs4Ab/6FYF+6e1F46rtd626X/wMdEeZt8E+3qij5Ncx8cb832E5wRrWv4bGOVT5DMZUfrS7aLrHS0ZWIJBjSaJfwUMe6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Yyqj/0ldTtYZEIVR+oRp/9wA2PcIxoJtU+g0QhTT84=;
 b=DTnUxha8amYH4Dcr1DUqL9fJovLnrL9Tb89Wn0AMC8JusoZh3C9OkHweBWnLvjJhrb4O4ker1kzAEsVFgBIK8I7FY/9XCfY1hF5b+bgV4saJtGewLkxC3M1GHbYRIi83SBjWt1cb8lIdJUZEEotADDMu2R0MQUqsjwhX2AVStF3ftQrwFPUXHgyvH8tlIj1UGQ0wSugYZXe7WBBM/4iKxyuvwytYMx/bZTOH/lghQ4AXxA3PFu0cs1EnX9kx2Zxay2HvHMFq4Wh/YgcrDHg+czHMDp5YMiOtPADWXh6XRAMQcaFcA6+Vsupyl9v6s+ONJvP5gMAluDAh6NZZbph8+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GVXPR04MB11042.eurprd04.prod.outlook.com (2603:10a6:150:21f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Wed, 11 Dec
 2024 06:54:17 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 06:54:17 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	frank.li@nxp.com,
	horms@kernel.org,
	idosch@idosch.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v7 net-next 4/4] net: enetc: add UDP segmentation offload support
Date: Wed, 11 Dec 2024 14:37:52 +0800
Message-Id: <20241211063752.744975-5-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211063752.744975-1-wei.fang@nxp.com>
References: <20241211063752.744975-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0237.apcprd06.prod.outlook.com
 (2603:1096:4:ac::21) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|GVXPR04MB11042:EE_
X-MS-Office365-Filtering-Correlation-Id: 58837c78-a6c5-45d8-e59d-08dd19b0a19c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q6NP47CgnT+eBZMZeJfpOMJX7qJgXgb3iKb6jESr/SCRyjRiy01fK6XGNBWL?=
 =?us-ascii?Q?vQZUe/QULAvXWOQLAqs2KjkLkymzi/2twaX4RUc31vghIDXcyEl22o0k8kI2?=
 =?us-ascii?Q?NEd1zhrRJnmhRvy1icd98i00eQWXlzXlyufH7X7oHNFRSYh3TGj074a1bzlB?=
 =?us-ascii?Q?Yunnv2ftfFuTAEChQyuv9fHS22qnu3b4wgRQLK78TIS+mZAbJjG3bWPioP2v?=
 =?us-ascii?Q?v8hGU/fhFQtf5A/Ly0EWkHO/6fXOOvghmYew16qK4h20lLJx9KcgQtMrP3Jv?=
 =?us-ascii?Q?aEhBUnbvrF+oZ6ROEDw861FbDoGkgiP3f4duprf6PBmrseDTpwRcq8e6sZ1O?=
 =?us-ascii?Q?BCIsWJx0GwmKPAsmjtJhbfO7qMNne3HG6whDIFzCTcnuKI1iyS/T3uqdSPI4?=
 =?us-ascii?Q?RFUOcz8fwv9FHyr73dypB/BZFMlbvl6tt5fbmKnrL2H5RvVg+M3c4/bLmWJl?=
 =?us-ascii?Q?DITTQuZT6yC3xQDKaEiz73fa6VlNM0X/2oodpCM/pul2FjyE/8JYahqQG/Wj?=
 =?us-ascii?Q?V7K8np57OewssEpxHAiEtdH2iZ23CIN6xa1DWQwzJqLx/l8sd4S+9lSilXtl?=
 =?us-ascii?Q?PLq5aRAGj//QWEr3neSRHsNtCMFb5PdTHsqfK1blXe9hswzVrNtYo4hxeWcz?=
 =?us-ascii?Q?e+I+MmiyDRFJQJfpbZBw2cL6lxsYS2wToANiohC87IvzOJAH1dYL7HkroIrf?=
 =?us-ascii?Q?XYbwnqeXEbKQNgys40ZDxFcannN6qPnovZoQsXN6yUH93inSCexq26V/cUOt?=
 =?us-ascii?Q?bPEPW2QtN7NSTTN3nYYHO7Nek9TxlodyRx/r7/5ZwF5ghJUnZ/qIAzHKyHyV?=
 =?us-ascii?Q?UgqhRiPjDCtU5sja+ScB+TwAx7ogdvBTId0KlVOHeZsmUmdViK92D8NeBjrr?=
 =?us-ascii?Q?uiQrxHYW+MjJuLnJNA2H8HqOzDhfyVEmc4YY0rzR9VejARmiK+19qIaB4YzD?=
 =?us-ascii?Q?LLIWrxlQFanGbDbyconJiaDRuGSDkZ8IkS0M/ctmhPBnihLYJfapQZlLOr2F?=
 =?us-ascii?Q?10CgqLm1exiBo9R8M60afLzJ2T9VabcGj1+xBEk8SiYT3w26k8bQYmxbWhjv?=
 =?us-ascii?Q?ijCWmxxGVENqtjfmuUnxDoL2XMW56YuJjK9BK91z2CGKGDwub3P/whs+Lx3o?=
 =?us-ascii?Q?eWhEH2fXCz/pvdsiP6310dNsVfn6mU0eLA1riJMLAEQqYZ4N0Afoa5xEH34M?=
 =?us-ascii?Q?pP1di6MRgOXhcjbxu3Hh5/7ccZMn3NCz0C/hPfST4vpwW1f4jwMyznx8+TCJ?=
 =?us-ascii?Q?lTv5OWDR7Q5dC2kiZTQVn8fdlxRUFLbucAKo0LQoOcIwv9w/VZ50gXe1x/3b?=
 =?us-ascii?Q?0zwOA1JLOkr5+vx78SaExLgygwo41z7fBAmWpIwxxKy7cdCn2l7/AQdoKbuM?=
 =?us-ascii?Q?F3XB4YSjhpoHb5mxkqkbFpB/Txkp5vaS+UPJhXzlKXFUT4Ag6WaJQRDpK1dj?=
 =?us-ascii?Q?gO9C6ttBIho=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1FxThlx1OvBrmlINU2o8whtvTWeM2y9GJ6bVnhqvx1dy85jZKREUQgptP/5g?=
 =?us-ascii?Q?xxnD4GZkorFFKixo0MipbS12X+DacqBqzxEdZmCcZ14C6P4hlOVqyymVju3I?=
 =?us-ascii?Q?hPX75Kz8rfBaBqrtUv9jDC3eTCLgPx2psmp6Wy9uEPRgIdIqfD8AoNAA/edx?=
 =?us-ascii?Q?TO9Pg/4v9gJwN59IcB00qPcMS5XlZRIeLBUbMuYaAAWBh0P/nm1LAcWMIuVc?=
 =?us-ascii?Q?dpVK1tgmWUpNQGVDJQLPdzj7lKEiJAwKQMwJLXIAaPWqHA/5rj2h9NLLbsyv?=
 =?us-ascii?Q?bqXyyHtgOQJW/XQYJdeN+0i2ys5sHibQQc5+PqOoQD+EuHsUMcci+5ufhkAb?=
 =?us-ascii?Q?xDQTuwnL51wMTkL7ffHiXV05wQYDppxKQVahmnJGLElyl3jv83yxkTbsTFIP?=
 =?us-ascii?Q?SPBiVsZS2IhYTW4hlV0lq831q0qKmcATjP7whtKlKx4Fx0J5W5Jg2AixrCwo?=
 =?us-ascii?Q?xIIeqd/mmFfb5tmVuJaxYzW1gtPo7HXhE+4RvfrpNcQsMB2yanxehucCXRfc?=
 =?us-ascii?Q?d/BaIOxI1MuMXfP1zTyoq09TmJA0pAuB/1hjCbsD6TcTe3RKHEU1KPtgAAf9?=
 =?us-ascii?Q?gNGlBElD4ksCmO/hlXqJ0UsjbcIEKUDAEF+TRLSplTQTqMTEi3G+jNWDuIaL?=
 =?us-ascii?Q?OTA8uvds5dVZZgOwb6sySBQd4r2LRtBRlgKHs8PV0WP0TkhQu92aFuILqpov?=
 =?us-ascii?Q?pBc6PnRoPCiZhWdDmMl2kbCpQUasnJ8Q83BZh/Ymrp4XodYLIU1hxsHHFsL8?=
 =?us-ascii?Q?5wn+JSIhxOFf0GhEjfhlvCDVyMEBKV5ijg8JakVwbw17TNej3tBQHA65jDsX?=
 =?us-ascii?Q?kW7ZinOjXeIMC7/Xtm1fAf501JmF1aOYllZfeivfS9c/QfiPSJB4Ynb7qQ4L?=
 =?us-ascii?Q?7+zy07jQhm25wXFbBdQsi39ZPivnvXjeNRT/YelzyJz0/bt0PFPYGfW+FTxC?=
 =?us-ascii?Q?qhKWuk7aWV6wrLS99SmYenVEjOC50ULQ6u1pP7fXFzOkXW5mu2UbWdgjvlXO?=
 =?us-ascii?Q?viidHY51mfJUjGory1BKGGh2lkK1J55maMUND0YrSfhAU80MlAFtLENCHuB+?=
 =?us-ascii?Q?sy7zW9kqbeQaK7egXbNcHKB96lRRfL7cWJkQLY9fVwyRffQ4L0x2ZGErCpwS?=
 =?us-ascii?Q?LUTOSvUFPqx8Bsi+1gyqwaFAEZswEKEECR7t7sWX4V/xuuR8xypJZVb5EAix?=
 =?us-ascii?Q?fsnmIVlri6iCziEQNFZcjKz0/5OYRATMNhWpeiylppbeDAxKsLigLO24f0e/?=
 =?us-ascii?Q?18sY2GfC8ZtdSOwrcLm248Je0Irnt/HihYE/SEHd6iUxVAVozUvRMhjoAhs9?=
 =?us-ascii?Q?NELvjWRTPPaBaBf2EDk+TGxGEelMB3wZFRO7w0UZFQzifEIf1k5ejFvV5bBq?=
 =?us-ascii?Q?aS+BxTKj0DNvjYqQvvi1mDHwPLuh5a4UMWmGIVl/xDzI0BO28ef2RKQHmZE3?=
 =?us-ascii?Q?yeT/gukE/0QCSAvd5YYMq+YHhd2ap7VESVTPChnJkvOeCi+tz81ghGSXGTwQ?=
 =?us-ascii?Q?oTp7OJePTwzwCOnG3B0rGQ3F5d3GWu34bI7+gmkNJqNW3+CN2SYGhh7OlUgD?=
 =?us-ascii?Q?yAo9Dz/wWo6CV0NBOXAEVnjVNOs9mLz0nWk4CbMC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58837c78-a6c5-45d8-e59d-08dd19b0a19c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 06:54:17.5190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a/fsPjHw4l26kgCSD5quXERmmKvmyNzjyZng+f9qHzW5Swipa63rSnxGPdZ11wm8EYqGcwdvH5lPFeNqxux7mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11042

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
v5 ~ v7: no changes
---
 drivers/net/ethernet/freescale/enetc/enetc_pf_common.c | 6 ++++--
 drivers/net/ethernet/freescale/enetc/enetc_vf.c        | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 31dedc665a16..3fd9b0727875 100644
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
index 63d78b2b8670..3768752b6008 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -145,11 +145,13 @@ static void enetc_vf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
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


