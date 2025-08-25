Return-Path: <netdev+bounces-216367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB982B3353D
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 06:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F9D83A6051
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 04:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84348280CC9;
	Mon, 25 Aug 2025 04:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="b47bcQq3"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013041.outbound.protection.outlook.com [52.101.72.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16F0265637;
	Mon, 25 Aug 2025 04:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756096627; cv=fail; b=nEQbk5Nr8MI6hM4xrN0bendBPVmHIKzlhry2H+HVRJ0jNeGxOpC4+zKn0lGAOFRoMs6VUC3qzu4NxlzLigEf0LxPouUUw5zjN8EDR2pvSUVhyhW5cXFHV6wEunoDFVhXoGsryUPXYmRPSr/Yj3st6abVIH1RnPjO5pyDsCQ/2qY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756096627; c=relaxed/simple;
	bh=YbGxb3sWyPS/S7FsuyjsKEu9l3kAZL/6nDODfaYb75U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HammQ6jFeQ0wkfC64haNPPlFJWclISCDpUSbEwub6WXzsDiRSlG7lxQsYWpUmu4MM+lfwRyimjeLznvZJdI1YAVBTnoLRJ/EUqK/+2TLoM/Mqv6PiPEZ6vZ3rRMBUzZ1AuHLe/wOxWt5PqFfU3WRViU/0ApJIiTQEYS/6ttuSco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=b47bcQq3; arc=fail smtp.client-ip=52.101.72.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AuHS1bmzaSFdg/JHEcH2IQc7lHOztBuiHohlHFqQEs0SmjDrVOTTBrEhbXlCl7Pa6IQe6pgMySFrPp8gYojKSTLYfEQcaMpFEIMw5LiS/oXSwZiM1NZ8RW97FuXawJdz+pjkKzb5bqtmEiYqXaeY5vjF0j9TfmcFDMd/Eg5wDrlvGMCOHVdKiwzyoh/sSwcF2S3vWZnGZUIu9iFTyZOICC8h4uZU9SsjEH97c7CCaBSjYww7XfmvHUKpzv1T9K++fIL4rxW1ua8azgmX8eKHm9WWHwCugq/P9mCvIXLHAKmKoMaYDHkOpjXceqGDo2ZtfLMVqK0xVj+vDIvPZP8Vlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wksZ4HkN4LjWyzitrzV+PcSmRE9F4AHfpT2g+mp05Ac=;
 b=NdTjh6NKbKk0p+xnD30QmRJZ71e2SHeKN1E9ob6QBk4VU43j56mzcEsy6EM+ksNkPs3asheChPwTD0KxMeHvtbzs4SVdorseyqiJsFNJ6TCaRZ87UcjSg8zXvZ+/sZMuyoGN+cTkic6mvKZgA3pW/nnbc5+CcSx7A6Go6FppajACF+CEMchmW0Z4cH+vgIi72hdNRF5Awj7M7jzPFSsutpqc0Et5Vhc6VUiQHpJTwykN7ljCIt8PeNHTFvPNBfxcVPPw0/4xi8oRujuDxbI+r8dJEz62pI/ZaX16QoadgHtkvF7roks2hnkgguRHKNJ8XtFPzIaAQBbdsFqYu9VC2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wksZ4HkN4LjWyzitrzV+PcSmRE9F4AHfpT2g+mp05Ac=;
 b=b47bcQq395gCAXvee38sAfmkinRX2rPJWof7yMqfwYGWcyzNpCOjHz/YbxkS55CFb4ScpOiY9MGiy4sAWHWgalnaYkjoWS/BkleqFss/8S2nLK7Lb4WPMFmmLK3I99Zx7PD/8SSSc4ckSRSmgZ4H05tNufUBykPbCfEN7QFF4PzMj9ZQWLrIu1wbSkAiHdLGDHWKgEnlhVEqApjHEYq0Ca43QfWUqXXhbd7PqbeVsdvKW//wEseE2r52lhJmNmZ4s5KRzqoNTGp8MP6nVbPvnZCODCz8m/1A5uL+lUlCrXZh3d/k2L5ORb5YRFab72jzwIeU88/ZlJ9WsmJd7A+exw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB9661.eurprd04.prod.outlook.com (2603:10a6:102:273::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Mon, 25 Aug
 2025 04:37:02 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Mon, 25 Aug 2025
 04:37:02 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	richardcochran@gmail.com,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	Frank.Li@nxp.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH v5 net-next 06/15] ptp: netc: add periodic pulse output support
Date: Mon, 25 Aug 2025 12:15:23 +0800
Message-Id: <20250825041532.1067315-7-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250825041532.1067315-1-wei.fang@nxp.com>
References: <20250825041532.1067315-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0064.apcprd02.prod.outlook.com
 (2603:1096:4:54::28) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA4PR04MB9661:EE_
X-MS-Office365-Filtering-Correlation-Id: 79e77519-c7b9-4dca-a66f-08dde3910927
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|52116014|376014|366016|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zC+O8LfJ6IqBcUj0FnQuLFasZv08AEGGned3Ts/syrzCtbRNo8fKenz01pzw?=
 =?us-ascii?Q?jP5u+G6/H7aFtqalB1nq4+XqkU5n2t6tcIRS912ExkxVitT9X2l0s7t4XKiD?=
 =?us-ascii?Q?uL1bjAt+o/Jrbb6xMVbMuzNfTQ3pvF+ogsmEZbxRlxbOpefu4AANuUhL9Nb6?=
 =?us-ascii?Q?jPSn0aiNi394jR9CHU9oiQeuw32d1+Sal6iSGebNljIVkWeR3Bpzogk26IEi?=
 =?us-ascii?Q?lyWKBHpZNwL9WOS6YlnZewdu/bFEe08Ip6HYwLue2GWcG7PELLyNHsEN7P9L?=
 =?us-ascii?Q?PVgt/O6DF8yy4T5OG2vkf4XDiXuSYxIIXtYJ1t2+XTVsy/sTFFRcTezyuU9h?=
 =?us-ascii?Q?o4d/uXP3FuEjTARUov3SLhDGYBBTlwp3hsRK4S6nxqjmX2HKqVISdcI/qJML?=
 =?us-ascii?Q?6sI4ux3OES8SBXGA/1qoSiGyDXu3IgMiuJupWKjCs1nC8/NJETmePlCQFepV?=
 =?us-ascii?Q?cFmfMlySB+KnO5ZM+uzKZONDISm0WIoBRbP2F6bZ7E3N1Iuk68ix+DtHqDST?=
 =?us-ascii?Q?/Bwxs6T51xzJAacva4Hs8XQG4lr8QMi0GuIOHumfibST6FRBJq1+0g1E4qXQ?=
 =?us-ascii?Q?wDyVDwULz9W0PHzKFcabemK1O0oe9xbea8Ui8RfyYhIZ7heqjO80DN8hOe8G?=
 =?us-ascii?Q?H9tYxu/qN8rZhwjacvORQz3QQHSPjjeNt5F3nTQA+uBG/bb4gbUYvVSMwrv0?=
 =?us-ascii?Q?WO0a/3USDueTGk1SLMrVx9Fg3pQ/wCR6kg1T/t3oe9sbElZtarcpAwczcn/e?=
 =?us-ascii?Q?ZkZwRFuu+49LJAI5jBT6+XKbNhGziRb+xI4Ulj9Wzx6vZ/j6sWlpVuwAKpir?=
 =?us-ascii?Q?UX3mAW9KR597T1ntbsfljzDWxmPaOiJ5E2iDJJfdD/PpdUfVG+QPXVUNV6na?=
 =?us-ascii?Q?SrDb/C6y/M3ys2xPCS1KUZIAOU5PdH0AFslRBXvlCvFVt0mXeoiGgX1nT+cF?=
 =?us-ascii?Q?9Nf7Ap3yB0JMoy+sXkqOH2z0oWyoyC3aV3M1hax7orn2n1zMVRbAqEoctFBV?=
 =?us-ascii?Q?xtX72icX4MAgypwNEuUAlLyK/xUoCd2pA36tUMOGUWgJSTA0b+v2UIUkQU/M?=
 =?us-ascii?Q?wbM37ipg50UOUFjanNnRzGq/rdfWAiEELIEC9vYuP5y5yvH3yrcVqV4OglCH?=
 =?us-ascii?Q?C5aaPo+eqaD/71WFpMT0S+tLZotpMitN12QHv5fjOEJBZnNUgbR4jbSGl1Sc?=
 =?us-ascii?Q?Y51ykbPIwGPOgDchKrNh6mKqybvNGoSV4vy3VavhBq9YhIDKIuU+3UAsUvTA?=
 =?us-ascii?Q?yQBfdUAvCvHnNJMk4P+PrJpMpkbzxfVT0tB0NW9OHfz5qXFl8+s0nvPR+YIL?=
 =?us-ascii?Q?3P4GCErBJegByjhXVlTeJAkjnsrkmmJQeC+mkcqe+4+vKpLtqwOTL+nD9qz1?=
 =?us-ascii?Q?DByZPrNe6z3ewILSXSdmQMMBYe3mBumIJLMnhVb3giMuO7HFMbae1B3EYpcp?=
 =?us-ascii?Q?NZeKvegaMd1jmhysohVvGw4dvUZCwe+1CBITo4+b8QUOl382lJnqmgY6CNzB?=
 =?us-ascii?Q?s3N90RKh0W+X1AE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(52116014)(376014)(366016)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z3E7nZ9IICbVqG90wCVDt8Uc63MaMt84LS2jpQ0t6kGkm4hK2b9AUm+K2ivp?=
 =?us-ascii?Q?WR3PeacBNUDIzJxQHURWxWime1uz8JD6lJS0LjeVdnJbl0WJH3x818iJ2uZo?=
 =?us-ascii?Q?pPTznHlqRmceyTpg3evvBvIQsC5Sf8HhHJR//K0uwbSkK8l89jyJZnjiNKCV?=
 =?us-ascii?Q?B+2NMMTUR4+FfNw2EgDMiFlZXKnHekL9ICbiRGTkgG3QvqVuaiBsoKMwdXj0?=
 =?us-ascii?Q?LRuwIUzEPYdCQDYSwG8zxScPHzKCuwDdMxxG5fKc00vBwYiLiyY+MtpnHWga?=
 =?us-ascii?Q?ZELOg1mZw9wA9QWW6OaITbke0M1l63kaDCjIh5NbjA4t+nuOVzw0zSwlpgAQ?=
 =?us-ascii?Q?ikbUDLBID98hd3prH0VPV1miHR67o0CYJ/BnCy1Y1NCSpvawjMrX/96AqNEs?=
 =?us-ascii?Q?3LUH1x4TnGm8NxCDWNyM6exmcvr3vb6BhxQAqvpKas4i3JP+C+GeLHULS+Zm?=
 =?us-ascii?Q?Rx8wTkcwmF78RZZY0VthKChccXbkCmNtjgdyDRnz1b/InPoDbVOrSeacyybp?=
 =?us-ascii?Q?Z2cB9HwLXKSMHPI8Ju0MIFwhXDBsztnNnZTQT9ILIkcoRO8OY0SGeu+UMs8M?=
 =?us-ascii?Q?tGtrZbUoqRWZpr1CBdpg/qE+exLdocKU5xzGYQ8bgdbFj7rpYxAfEKEZS6r7?=
 =?us-ascii?Q?vp1UPF04YdLc1jgWkr2s7tqZPNtMNM8T+6GjfNuoghoqu3wz1awtx3SNtSAQ?=
 =?us-ascii?Q?72o+1vHbX+9s+j7f5N4S4f5lfX6r2Hx8gK3qxGlD9+stgg7zrj5z1Lcf1y7k?=
 =?us-ascii?Q?4x16SPV/EhHl+2b38g+ErD77F4SIkLicjlMjCB/B9JZ6moznfeE0D9AR88+E?=
 =?us-ascii?Q?vfyQh6GaNmbyeRgHZJR4oo+nXU0FoD3uu3WACr3JTl2daYQjygw8CEwRhDfo?=
 =?us-ascii?Q?esL8LM6NX5PBpsDGSwG+s1pn4UnIyY8lWd06S+0Bd6mfQ/3HBGvzpWhvP/SD?=
 =?us-ascii?Q?kplhL6PiPVbc4Vd1XNwKtZuG8+vsdK4qPeIvjAUUOs4klyI+tOdtMDCGBSyr?=
 =?us-ascii?Q?vs7F9OfCT6XSWO7iQCmAzraxoi4MXhCaGQ16j+ExZI2S54a4o2ijd+tDv0li?=
 =?us-ascii?Q?lrmwm/DULb/KGmQi3tTXjWGZRp+ZY2rgrKcyY8viSlfDUvB+qi1+UnQhaTnX?=
 =?us-ascii?Q?64bRvHM3WnvSuZ5hAXgmH8FzNT1mJGwBHJs4a0v93EJ5Ekw7/LpcVBSw6kVO?=
 =?us-ascii?Q?AZOL9f2Z99IzgCjBitYv8nvmimmtfayglX5i9kH7P4H0iebUOKM4ho6wUnmS?=
 =?us-ascii?Q?XBjnBK9Lg+2S4Pk5aDw0zts+p0UOx91l5BFEAIing6Yg9J3xgmYIb1TwrU8g?=
 =?us-ascii?Q?W9HxICoOw102w0ApI/qB5FJuD5ACaRT124vLuEfnYiNded4tZLUqnc6eB+5p?=
 =?us-ascii?Q?mTSsu0zDCmn+Z7qCVv2bJ6G7nIGNiOr7BHwp+Y11mhV/UqMRcsuWO8xqUj2T?=
 =?us-ascii?Q?9CpXqDT2jIBilfTchEjJZJFN/oMhRrZSLYyZF77mXizdAOY/E7Mk7Gr/LGx0?=
 =?us-ascii?Q?sQ4NCACgY5vTn05eoCes5/HSni+OVkV24bl40ZoVY0qMZX8kXeGzKKIWo96V?=
 =?us-ascii?Q?SZrmULjQDXw9PANdRHnVVOFg2FIMcqkNZ25R6B0E?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79e77519-c7b9-4dca-a66f-08dde3910927
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 04:37:02.3350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dN20su3CDjiTzA5eD84V9IwU5Ed5xuc7/11Uk60Yzjr75fA77SbonOrhoZ1DEqt9IOKptAbT83ZAWypQ2Gs2mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9661

NETC Timer has three pulse channels, all of which support periodic pulse
output. Bind the channel to a ALARM register and then sets a future time
into the ALARM register. When the current time is greater than the ALARM
value, the FIPER register will be triggered to count down, and when the
count reaches 0, the pulse will be triggered. The PPS signal is also
implemented in this way.

i.MX95 only has ALARM1 can be used as an indication to the FIPER start
down counting, but i.MX943 has ALARM1 and ALARM2 can be used. Therefore,
only one channel can work for i.MX95, two channels for i.MX943 as most.

In addition, change the PPS channel to be dynamically selected from fixed
number (0) because add PTP_CLK_REQ_PEROUT support.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>

---
v4:
1. Simplify the commit message
2. Fix dereference unassigned pointer "pp" in netc_timer_enable_pps().
v3 changes:
1. Improve the commit message
2. Add revision to struct netc_timer
3. Use priv->tmr_emask to instead of reading TMR_EMASK register
4. Add pps_channel to struct netc_timer and NETC_TMR_INVALID_CHANNEL
5. Add some helper functions: netc_timer_enable/disable_periodic_pulse(),
   and netc_timer_select_pps_channel()
6. Dynamically select PPS channel instead of fixed to channel 0.
v2: no changes
---
 drivers/ptp/ptp_netc.c | 356 +++++++++++++++++++++++++++++++++++------
 1 file changed, 306 insertions(+), 50 deletions(-)

diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
index 69d45a4a4cec..8cf44b8ebe44 100644
--- a/drivers/ptp/ptp_netc.c
+++ b/drivers/ptp/ptp_netc.c
@@ -53,12 +53,18 @@
 #define NETC_TMR_CUR_TIME_H		0x00f4
 
 #define NETC_TMR_REGS_BAR		0
+#define NETC_GLOBAL_OFFSET		0x10000
+#define NETC_GLOBAL_IPBRR0		0xbf8
+#define  IPBRR0_IP_REV			GENMASK(15, 0)
+#define NETC_REV_4_1			0x0401
 
 #define NETC_TMR_FIPER_NUM		3
+#define NETC_TMR_INVALID_CHANNEL	NETC_TMR_FIPER_NUM
 #define NETC_TMR_DEFAULT_PRSC		2
 #define NETC_TMR_DEFAULT_ALARM		GENMASK_ULL(63, 0)
 #define NETC_TMR_DEFAULT_FIPER		GENMASK(31, 0)
 #define NETC_TMR_FIPER_MAX_PW		GENMASK(4, 0)
+#define NETC_TMR_ALARM_NUM		2
 
 /* 1588 timer reference clock source select */
 #define NETC_TMR_CCM_TIMER1		0 /* enet_timer1_clk_root, from CCM */
@@ -67,6 +73,19 @@
 
 #define NETC_TMR_SYSCLK_333M		333333333U
 
+enum netc_pp_type {
+	NETC_PP_PPS = 1,
+	NETC_PP_PEROUT,
+};
+
+struct netc_pp {
+	enum netc_pp_type type;
+	bool enabled;
+	int alarm_id;
+	u32 period; /* pulse period, ns */
+	u64 stime; /* start time, ns */
+};
+
 struct netc_timer {
 	void __iomem *base;
 	struct pci_dev *pdev;
@@ -82,8 +101,12 @@ struct netc_timer {
 
 	int irq;
 	char irq_name[24];
+	int revision;
 	u32 tmr_emask;
-	bool pps_enabled;
+	u8 pps_channel;
+	u8 fs_alarm_num;
+	u8 fs_alarm_bitmap;
+	struct netc_pp pp[NETC_TMR_FIPER_NUM]; /* periodic pulse */
 };
 
 #define netc_timer_rd(p, o)		netc_read((p)->base + (o))
@@ -193,6 +216,7 @@ static u32 netc_timer_calculate_fiper_pw(struct netc_timer *priv,
 static void netc_timer_set_pps_alarm(struct netc_timer *priv, int channel,
 				     u32 integral_period)
 {
+	struct netc_pp *pp = &priv->pp[channel];
 	u64 alarm;
 
 	/* Get the alarm value */
@@ -200,7 +224,116 @@ static void netc_timer_set_pps_alarm(struct netc_timer *priv, int channel,
 	alarm = roundup_u64(alarm, NSEC_PER_SEC);
 	alarm = roundup_u64(alarm, integral_period);
 
-	netc_timer_alarm_write(priv, alarm, 0);
+	netc_timer_alarm_write(priv, alarm, pp->alarm_id);
+}
+
+static void netc_timer_set_perout_alarm(struct netc_timer *priv, int channel,
+					u32 integral_period)
+{
+	u64 cur_time = netc_timer_cur_time_read(priv);
+	struct netc_pp *pp = &priv->pp[channel];
+	u64 alarm, delta, min_time;
+	u32 period = pp->period;
+	u64 stime = pp->stime;
+
+	min_time = cur_time + NSEC_PER_MSEC + period;
+	if (stime < min_time) {
+		delta = min_time - stime;
+		stime += roundup_u64(delta, period);
+	}
+
+	alarm = roundup_u64(stime - period, integral_period);
+	netc_timer_alarm_write(priv, alarm, pp->alarm_id);
+}
+
+static int netc_timer_get_alarm_id(struct netc_timer *priv)
+{
+	int i;
+
+	for (i = 0; i < priv->fs_alarm_num; i++) {
+		if (!(priv->fs_alarm_bitmap & BIT(i))) {
+			priv->fs_alarm_bitmap |= BIT(i);
+			break;
+		}
+	}
+
+	return i;
+}
+
+static u64 netc_timer_get_gclk_period(struct netc_timer *priv)
+{
+	/* TMR_GCLK_freq = (clk_freq / oclk_prsc) Hz.
+	 * TMR_GCLK_period = NSEC_PER_SEC / TMR_GCLK_freq.
+	 * TMR_GCLK_period = (NSEC_PER_SEC * oclk_prsc) / clk_freq
+	 */
+
+	return div_u64(mul_u32_u32(NSEC_PER_SEC, priv->oclk_prsc),
+		       priv->clk_freq);
+}
+
+static void netc_timer_enable_periodic_pulse(struct netc_timer *priv,
+					     u8 channel)
+{
+	u32 fiper_pw, fiper, fiper_ctrl, integral_period;
+	struct netc_pp *pp = &priv->pp[channel];
+	int alarm_id = pp->alarm_id;
+
+	integral_period = netc_timer_get_integral_period(priv);
+	/* Set to desired FIPER interval in ns - TCLK_PERIOD */
+	fiper = pp->period - integral_period;
+	fiper_pw = netc_timer_calculate_fiper_pw(priv, fiper);
+
+	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
+	fiper_ctrl &= ~(FIPER_CTRL_DIS(channel) | FIPER_CTRL_PW(channel) |
+			FIPER_CTRL_FS_ALARM(channel));
+	fiper_ctrl |= FIPER_CTRL_SET_PW(channel, fiper_pw);
+	fiper_ctrl |= alarm_id ? FIPER_CTRL_FS_ALARM(channel) : 0;
+
+	priv->tmr_emask |= TMR_TEVNET_PPEN(channel) |
+			   TMR_TEVENT_ALMEN(alarm_id);
+
+	if (pp->type == NETC_PP_PPS)
+		netc_timer_set_pps_alarm(priv, channel, integral_period);
+	else
+		netc_timer_set_perout_alarm(priv, channel, integral_period);
+
+	netc_timer_wr(priv, NETC_TMR_TEMASK, priv->tmr_emask);
+	netc_timer_wr(priv, NETC_TMR_FIPER(channel), fiper);
+	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
+}
+
+static void netc_timer_disable_periodic_pulse(struct netc_timer *priv,
+					      u8 channel)
+{
+	struct netc_pp *pp = &priv->pp[channel];
+	int alarm_id = pp->alarm_id;
+	u32 fiper_ctrl;
+
+	if (!pp->enabled)
+		return;
+
+	priv->tmr_emask &= ~(TMR_TEVNET_PPEN(channel) |
+			     TMR_TEVENT_ALMEN(alarm_id));
+
+	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
+	fiper_ctrl |= FIPER_CTRL_DIS(channel);
+
+	netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, alarm_id);
+	netc_timer_wr(priv, NETC_TMR_TEMASK, priv->tmr_emask);
+	netc_timer_wr(priv, NETC_TMR_FIPER(channel), NETC_TMR_DEFAULT_FIPER);
+	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
+}
+
+static u8 netc_timer_select_pps_channel(struct netc_timer *priv)
+{
+	int i;
+
+	for (i = 0; i < NETC_TMR_FIPER_NUM; i++) {
+		if (!priv->pp[i].enabled)
+			return i;
+	}
+
+	return NETC_TMR_INVALID_CHANNEL;
 }
 
 /* Note that users should not use this API to output PPS signal on
@@ -211,77 +344,178 @@ static void netc_timer_set_pps_alarm(struct netc_timer *priv, int channel,
 static int netc_timer_enable_pps(struct netc_timer *priv,
 				 struct ptp_clock_request *rq, int on)
 {
-	u32 fiper, fiper_ctrl;
+	struct device *dev = &priv->pdev->dev;
 	unsigned long flags;
+	struct netc_pp *pp;
+	int err = 0;
 
 	spin_lock_irqsave(&priv->lock, flags);
 
-	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
-
 	if (on) {
-		u32 integral_period, fiper_pw;
+		int alarm_id;
+		u8 channel;
+
+		if (priv->pps_channel < NETC_TMR_FIPER_NUM) {
+			channel = priv->pps_channel;
+		} else {
+			channel = netc_timer_select_pps_channel(priv);
+			if (channel == NETC_TMR_INVALID_CHANNEL) {
+				dev_err(dev, "No available FIPERs\n");
+				err = -EBUSY;
+				goto unlock_spinlock;
+			}
+		}
 
-		if (priv->pps_enabled)
+		pp = &priv->pp[channel];
+		if (pp->enabled)
 			goto unlock_spinlock;
 
-		integral_period = netc_timer_get_integral_period(priv);
-		fiper = NSEC_PER_SEC - integral_period;
-		fiper_pw = netc_timer_calculate_fiper_pw(priv, fiper);
-		fiper_ctrl &= ~(FIPER_CTRL_DIS(0) | FIPER_CTRL_PW(0) |
-				FIPER_CTRL_FS_ALARM(0));
-		fiper_ctrl |= FIPER_CTRL_SET_PW(0, fiper_pw);
-		priv->tmr_emask |= TMR_TEVNET_PPEN(0) | TMR_TEVENT_ALMEN(0);
-		priv->pps_enabled = true;
-		netc_timer_set_pps_alarm(priv, 0, integral_period);
+		alarm_id = netc_timer_get_alarm_id(priv);
+		if (alarm_id == priv->fs_alarm_num) {
+			dev_err(dev, "No available ALARMs\n");
+			err = -EBUSY;
+			goto unlock_spinlock;
+		}
+
+		pp->enabled = true;
+		pp->type = NETC_PP_PPS;
+		pp->alarm_id = alarm_id;
+		pp->period = NSEC_PER_SEC;
+		priv->pps_channel = channel;
+
+		netc_timer_enable_periodic_pulse(priv, channel);
 	} else {
-		if (!priv->pps_enabled)
+		/* pps_channel is invalid if PPS is not enabled, so no
+		 * processing is needed.
+		 */
+		if (priv->pps_channel >= NETC_TMR_FIPER_NUM)
 			goto unlock_spinlock;
 
-		fiper = NETC_TMR_DEFAULT_FIPER;
-		priv->tmr_emask &= ~(TMR_TEVNET_PPEN(0) |
-				     TMR_TEVENT_ALMEN(0));
-		fiper_ctrl |= FIPER_CTRL_DIS(0);
-		priv->pps_enabled = false;
-		netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, 0);
+		netc_timer_disable_periodic_pulse(priv, priv->pps_channel);
+		pp = &priv->pp[priv->pps_channel];
+		priv->fs_alarm_bitmap &= ~BIT(pp->alarm_id);
+		memset(pp, 0, sizeof(*pp));
+		priv->pps_channel = NETC_TMR_INVALID_CHANNEL;
 	}
 
-	netc_timer_wr(priv, NETC_TMR_TEMASK, priv->tmr_emask);
-	netc_timer_wr(priv, NETC_TMR_FIPER(0), fiper);
-	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
+unlock_spinlock:
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return err;
+}
+
+static int net_timer_enable_perout(struct netc_timer *priv,
+				   struct ptp_clock_request *rq, int on)
+{
+	struct device *dev = &priv->pdev->dev;
+	u32 channel = rq->perout.index;
+	unsigned long flags;
+	struct netc_pp *pp;
+	int err = 0;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	pp = &priv->pp[channel];
+	if (pp->type == NETC_PP_PPS) {
+		dev_err(dev, "FIPER%u is being used for PPS\n", channel);
+		err = -EBUSY;
+		goto unlock_spinlock;
+	}
+
+	if (on) {
+		u64 period_ns, gclk_period, max_period, min_period;
+		struct timespec64 period, stime;
+		u32 integral_period;
+		int alarm_id;
+
+		period.tv_sec = rq->perout.period.sec;
+		period.tv_nsec = rq->perout.period.nsec;
+		period_ns = timespec64_to_ns(&period);
+
+		integral_period = netc_timer_get_integral_period(priv);
+		max_period = (u64)NETC_TMR_DEFAULT_FIPER + integral_period;
+		gclk_period = netc_timer_get_gclk_period(priv);
+		min_period = gclk_period * 4 + integral_period;
+		if (period_ns > max_period || period_ns < min_period) {
+			dev_err(dev, "The period range is %llu ~ %llu\n",
+				min_period, max_period);
+			err = -EINVAL;
+			goto unlock_spinlock;
+		}
+
+		if (pp->enabled) {
+			alarm_id = pp->alarm_id;
+		} else {
+			alarm_id = netc_timer_get_alarm_id(priv);
+			if (alarm_id == priv->fs_alarm_num) {
+				dev_err(dev, "No available ALARMs\n");
+				err = -EBUSY;
+				goto unlock_spinlock;
+			}
+
+			pp->type = NETC_PP_PEROUT;
+			pp->enabled = true;
+			pp->alarm_id = alarm_id;
+		}
+
+		stime.tv_sec = rq->perout.start.sec;
+		stime.tv_nsec = rq->perout.start.nsec;
+		pp->stime = timespec64_to_ns(&stime);
+		pp->period = period_ns;
+
+		netc_timer_enable_periodic_pulse(priv, channel);
+	} else {
+		netc_timer_disable_periodic_pulse(priv, channel);
+		priv->fs_alarm_bitmap &= ~BIT(pp->alarm_id);
+		memset(pp, 0, sizeof(*pp));
+	}
 
 unlock_spinlock:
 	spin_unlock_irqrestore(&priv->lock, flags);
 
-	return 0;
+	return err;
 }
 
-static void netc_timer_disable_pps_fiper(struct netc_timer *priv)
+static void netc_timer_disable_fiper(struct netc_timer *priv)
 {
-	u32 fiper_ctrl;
+	u32 fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
+	int i;
 
-	if (!priv->pps_enabled)
-		return;
+	for (i = 0; i < NETC_TMR_FIPER_NUM; i++) {
+		if (!priv->pp[i].enabled)
+			continue;
+
+		fiper_ctrl |= FIPER_CTRL_DIS(i);
+		netc_timer_wr(priv, NETC_TMR_FIPER(i), NETC_TMR_DEFAULT_FIPER);
+	}
 
-	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
-	fiper_ctrl |= FIPER_CTRL_DIS(0);
-	netc_timer_wr(priv, NETC_TMR_FIPER(0), NETC_TMR_DEFAULT_FIPER);
 	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
 }
 
-static void netc_timer_enable_pps_fiper(struct netc_timer *priv)
+static void netc_timer_enable_fiper(struct netc_timer *priv)
 {
-	u32 fiper_ctrl, integral_period, fiper;
+	u32 integral_period = netc_timer_get_integral_period(priv);
+	u32 fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
+	int i;
 
-	if (!priv->pps_enabled)
-		return;
+	for (i = 0; i < NETC_TMR_FIPER_NUM; i++) {
+		struct netc_pp *pp = &priv->pp[i];
+		u32 fiper;
 
-	integral_period = netc_timer_get_integral_period(priv);
-	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
-	fiper_ctrl &= ~FIPER_CTRL_DIS(0);
-	fiper = NSEC_PER_SEC - integral_period;
+		if (!pp->enabled)
+			continue;
+
+		fiper_ctrl &= ~FIPER_CTRL_DIS(i);
+
+		if (pp->type == NETC_PP_PPS)
+			netc_timer_set_pps_alarm(priv, i, integral_period);
+		else if (pp->type == NETC_PP_PEROUT)
+			netc_timer_set_perout_alarm(priv, i, integral_period);
+
+		fiper = pp->period - integral_period;
+		netc_timer_wr(priv, NETC_TMR_FIPER(i), fiper);
+	}
 
-	netc_timer_set_pps_alarm(priv, 0, integral_period);
-	netc_timer_wr(priv, NETC_TMR_FIPER(0), fiper);
 	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
 }
 
@@ -293,6 +527,8 @@ static int netc_timer_enable(struct ptp_clock_info *ptp,
 	switch (rq->type) {
 	case PTP_CLK_REQ_PPS:
 		return netc_timer_enable_pps(priv, rq, on);
+	case PTP_CLK_REQ_PEROUT:
+		return net_timer_enable_perout(priv, rq, on);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -311,9 +547,9 @@ static void netc_timer_adjust_period(struct netc_timer *priv, u64 period)
 	tmr_ctrl = u32_replace_bits(old_tmr_ctrl, integral_period,
 				    TMR_CTRL_TCLK_PERIOD);
 	if (tmr_ctrl != old_tmr_ctrl) {
-		netc_timer_disable_pps_fiper(priv);
+		netc_timer_disable_fiper(priv);
 		netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
-		netc_timer_enable_pps_fiper(priv);
+		netc_timer_enable_fiper(priv);
 	}
 
 	netc_timer_wr(priv, NETC_TMR_ADD, fractional_period);
@@ -340,7 +576,7 @@ static int netc_timer_adjtime(struct ptp_clock_info *ptp, s64 delta)
 
 	spin_lock_irqsave(&priv->lock, flags);
 
-	netc_timer_disable_pps_fiper(priv);
+	netc_timer_disable_fiper(priv);
 
 	/* Adjusting TMROFF instead of TMR_CNT is that the timer
 	 * counter keeps increasing during reading and writing
@@ -350,7 +586,7 @@ static int netc_timer_adjtime(struct ptp_clock_info *ptp, s64 delta)
 	tmr_off += delta;
 	netc_timer_offset_write(priv, tmr_off);
 
-	netc_timer_enable_pps_fiper(priv);
+	netc_timer_enable_fiper(priv);
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 
@@ -387,10 +623,10 @@ static int netc_timer_settime64(struct ptp_clock_info *ptp,
 
 	spin_lock_irqsave(&priv->lock, flags);
 
-	netc_timer_disable_pps_fiper(priv);
+	netc_timer_disable_fiper(priv);
 	netc_timer_offset_write(priv, 0);
 	netc_timer_cnt_write(priv, ns);
-	netc_timer_enable_pps_fiper(priv);
+	netc_timer_enable_fiper(priv);
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 
@@ -404,6 +640,7 @@ static const struct ptp_clock_info netc_timer_ptp_caps = {
 	.n_pins		= 0,
 	.n_alarm	= 2,
 	.pps		= 1,
+	.n_per_out	= 3,
 	.adjfine	= netc_timer_adjfine,
 	.adjtime	= netc_timer_adjtime,
 	.gettimex64	= netc_timer_gettimex64,
@@ -561,6 +798,9 @@ static irqreturn_t netc_timer_isr(int irq, void *data)
 	if (tmr_event & TMR_TEVENT_ALMEN(0))
 		netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, 0);
 
+	if (tmr_event & TMR_TEVENT_ALMEN(1))
+		netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, 1);
+
 	if (tmr_event & TMR_TEVENT_PPEN_ALL) {
 		event.type = PTP_CLOCK_PPS;
 		ptp_clock_event(priv->clock, &event);
@@ -604,6 +844,15 @@ static void netc_timer_free_msix_irq(struct netc_timer *priv)
 	pci_free_irq_vectors(pdev);
 }
 
+static int netc_timer_get_global_ip_rev(struct netc_timer *priv)
+{
+	u32 val;
+
+	val = netc_timer_rd(priv, NETC_GLOBAL_OFFSET + NETC_GLOBAL_IPBRR0);
+
+	return val & IPBRR0_IP_REV;
+}
+
 static int netc_timer_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *id)
 {
@@ -616,12 +865,19 @@ static int netc_timer_probe(struct pci_dev *pdev,
 		return err;
 
 	priv = pci_get_drvdata(pdev);
+	priv->revision = netc_timer_get_global_ip_rev(priv);
+	if (priv->revision == NETC_REV_4_1)
+		priv->fs_alarm_num = 1;
+	else
+		priv->fs_alarm_num = NETC_TMR_ALARM_NUM;
+
 	err = netc_timer_parse_dt(priv);
 	if (err)
 		goto timer_pci_remove;
 
 	priv->caps = netc_timer_ptp_caps;
 	priv->oclk_prsc = NETC_TMR_DEFAULT_PRSC;
+	priv->pps_channel = NETC_TMR_INVALID_CHANNEL;
 	spin_lock_init(&priv->lock);
 	snprintf(priv->irq_name, sizeof(priv->irq_name), "ptp-netc %s",
 		 pci_name(pdev));
-- 
2.34.1


