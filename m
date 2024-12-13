Return-Path: <netdev+bounces-151592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B99F9F02AC
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 03:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F4B116A538
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 02:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F89136327;
	Fri, 13 Dec 2024 02:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GAtegVUs"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2072.outbound.protection.outlook.com [40.107.21.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0812957333;
	Fri, 13 Dec 2024 02:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734057217; cv=fail; b=f5A0c0eYFkgPsPhSNgQZBvj1zCYBD5AuEDF6y8HBD+RwUMxCDckHnZTrEEhZLaUZf0s0oPOsnYiJJuXtVfSy+psVZzx7I0bVpLVJEh+jB0ZieKE5Cxwxo0IDsj6q7tYryaNh1aLdCYLv+5PyeEJ6hjAQcV3g8MI2u3yONldLGW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734057217; c=relaxed/simple;
	bh=FRq6qJfnftitbD4zveSJsSl374wdcbmj71lcXik427E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W/mhUc5A1EL0l4M/8hYh+34zp+OEfAPFc5Ir2aCNLq4tyv/T8tHHZnUWJUtBzZsam1OO3OTI9+OKSXcYy9u+hMyr3vSlRoIqkOzVFirQQ8O0idk8/8AeWGkrvXqnXIuIHITxCW9Hn1OrWBxWsKeO9Zd/Sjs8POkEeCCNk08gKUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GAtegVUs; arc=fail smtp.client-ip=40.107.21.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PTpRZS4ExmrLltBBPmFJARXB584f5PdMwVCWtFZt44TwTOKxWF1LaWVJ+fmXj9VnaYBlpIfQ4gSVHh0qmP5wc+sFTDqIxCVqZYRqnaEt5C+W5KYLpaVWNFjO45Cv3j3JmGawwQdYX4kHaRXE2QBKP/caJ/w8RYxzgywuqIAqWDVmFpPv7MGjLYej7jdEF44Iw3Tz+R1dS+AWM/hpguFqxyRRP7nse/rE0nxVea+Vy7jNKS1cgjJ6e+iz78otqsuGXXiSvpIi5bmfmiqFAU2HQavtqVJOrq9rD1PybhU2lW1Xr6hoPuF1nEKl2Umhz68/HqOlZxhWgfaUjG/QgHAUBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kcTP2IfOb4WxJx/2wEYbAgYHhqYPZF4IQVcnYZwx/F4=;
 b=onXOjKJeaX8k8GmZPPtVjwt3xJMfvEA6+gVpRCYfaKfXT5wtaZUIjlF7tvFG3BU7UrTnE6jU74jJ8JbJuuoy2wXe4eQ/WG1/gonZdelUvKQ2CHz5Ih37aYJGmcVOCsvSy9bm9Wcl4Ekul+T3DLqDVlW/klHZXpy98fQ+G5OlPx9pe2DQQ/LCO+o2Lqs8AI0wgsz66iRuTAtXfJMMDROAeevP3eDpIVKMnQe8B329HYsbKyE6amkjxB/JxYwFFuA1R6l+dzvuQQOPZTSq+8ObcwNl+YmvVbsWiC2hQXqC6MTTjaCeNWOtN8JLeT1c0WHiWTSFI/Q3/k+5AWbT6znYvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcTP2IfOb4WxJx/2wEYbAgYHhqYPZF4IQVcnYZwx/F4=;
 b=GAtegVUs6OUXh9HnrDlJRTzQkQalxxIJNEMnUcpOVENC3VxXv58HdOGy7Z+ZmvFaTriU16GQum53IyK7PSr6o9uj84XNbm46u1Tvtbu0Oe/F8OQSJUviEwI6b/Y9vD+8X09rxy+AHunjZUpz6A5THLRzcLF5Xu7PWWLg4runKeWWKZke+9y5gjoc+H2uAEXJS3atfKoP/pXdSQ5OzLpXVrws73+p8B3sGFu60NenLyLSvAS21s2jOsCprnfGwD0RcN7nbiJLfVaVsvG7AAt6Ffh/GgqqJztU5SoK3eXaJPwWXZY+jpKRsO0Grxpooc4DBcxvWeDvMN+2CRDUpWLbjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB8PR04MB7114.eurprd04.prod.outlook.com (2603:10a6:10:fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 02:33:33 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 02:33:32 +0000
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
Subject: [PATCH v8 net-next 1/4] net: enetc: add Tx checksum offload for i.MX95 ENETC
Date: Fri, 13 Dec 2024 10:17:28 +0800
Message-Id: <20241213021731.1157535-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213021731.1157535-1-wei.fang@nxp.com>
References: <20241213021731.1157535-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0014.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::17) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DB8PR04MB7114:EE_
X-MS-Office365-Filtering-Correlation-Id: 7953b6e4-4478-4985-3ccc-08dd1b1e8987
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DbsC/SMMy0eWhDYY9Y2xzxR+/h3pYmkuNXnkidqbWcr7feuRCMp3q71bGv2Q?=
 =?us-ascii?Q?hI0KJR+WYKV5/I7Eio8uh3vAbAt5viSlMBZGsHwAJdEQ+v4+RGVmv9UBAaaE?=
 =?us-ascii?Q?dxssxdcReBzYltl6drAKpbsBUUTUNgiZXdR1NdO15L8IupT2+CIXySWLw8CP?=
 =?us-ascii?Q?ULhQzGGWqdLMkBuniFwHA6tpUMmAqDFfS/Psw0U0p7C+8DyBGvCqja2VaW5y?=
 =?us-ascii?Q?RrOHRmY1OZBKTbnnvfgbrEgzsPeLvOdNgrQJTz40MwOPPrYeg7oy4G+A46IC?=
 =?us-ascii?Q?TkzASytakUohInzJUk8FLm72vDd+3p+1Zw0HI+GnZCpADcO8U/Rp6++dd900?=
 =?us-ascii?Q?RK5ss8VydYdzgxCGoD+tMRVKr76gnxG7QHAeTD+/bu4HZd1HEx5xP99Gkupl?=
 =?us-ascii?Q?0qe1UhbrTPl2KBZ1X/sYgbgnckLlJbnB/X0qlA3itHpTJ5oD+VENP/uWRwsA?=
 =?us-ascii?Q?ozPsD43gaIMP3PHg1nKslgBwueO4SG0UQCDvvXRYlL+om0zRKKREPfryDvAP?=
 =?us-ascii?Q?V6ZujrelzsNMZ24aX7WqBVGtjZBIOGi0PFVoKTYCZhXxx0NSYlVoJ0reZOIw?=
 =?us-ascii?Q?G9c9vqFfmDWuyTBqHOoRedVbLNd1V7iwUVzFsDrsvmvudSZDctEA01+sn0ZF?=
 =?us-ascii?Q?n6UMgRBh6YZgZpTpFR/mxH+7LawMe/DYEoyZZ6vs6hBHT0ZtgaYdED7SAW4E?=
 =?us-ascii?Q?nMRUz4HvXk0IC+WtKsYm3G+J8pbM+p/tzsAXZRdrYhdf8cjLxbxqxlATZNtr?=
 =?us-ascii?Q?1GaJnEr0wv/0wbHaexosFQ2T1xY+cXQBvbtyqsNYfLgrBz9f5nKW8fbNM4VD?=
 =?us-ascii?Q?X0BGYU8NW+vN68M6i8AvaHkmRyvGqEmGXvOD3zKAsJQnGg8eNOXGNNnrF7Fc?=
 =?us-ascii?Q?b1TXSOL+iMQwnFm9hpSCSWnR2btifUGshhj1jawouLxg41PytmYbC8SGN5b+?=
 =?us-ascii?Q?7g3GoEZ2crPOFtUIUCWStBB5RU17H9bLtI6yO3H+r/L2ZtCGc6j9utQTXVjr?=
 =?us-ascii?Q?TN15VgdCyFwQJpXR1bSlEolQemWHjccGJHTTZfb+AXaPSg1MDm7V5yA/qEwZ?=
 =?us-ascii?Q?32eiTM4EHF8ezuqBIehT5Mo84VcTrb4rckYXHuMpGHzwe5jXv+uR/kwEUr2I?=
 =?us-ascii?Q?QacrwRVP00AxCXcVDkaM4s0WqGNdvYCQsogCZ5HQqmf0uNvSHS0Oyi1qXM7h?=
 =?us-ascii?Q?5bX514b2vwzHXJKT+9nZP4WSSqNCe+lkzElF9naFthqzrV16u6XXAJUYOHGF?=
 =?us-ascii?Q?CTVMo9I91/iChc8xGbqcIrq/8Q6+ldYuDpdWhhci0pw87avPhmRyCRisHgFN?=
 =?us-ascii?Q?WC3w/875M1as93ZyavUwgMwR7CBV6z/M78+D9IKezMLRmR7NLSvQEEq7S8Bg?=
 =?us-ascii?Q?G7kJLFkoUG2MYB54pHvWYBNMu73lN5AShVCb/7xEPoBiCSaY5uE7hmeLHYu9?=
 =?us-ascii?Q?f/GSzI5iPmw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W1hb0YukuDGD0bvqsCmsk7pFn4hiKbXj2AAmJS/uJCSTeUkRryvTtLorBTP2?=
 =?us-ascii?Q?2YGwUpx9qunJf9jzN0Oa6qWJTyXnBrjVAd0Ai6DU2sY5x7caIpKTxis11Vjy?=
 =?us-ascii?Q?gAzLNXBP/cs7EVm5v68eZTLa3/cRWJDtfV+rxYRSm74fM26S00dDPKBzd5Dv?=
 =?us-ascii?Q?2xSOd1dVXBxwlcDzIHUqnviziW7TE/k+ZQ3Z4vZpTpAFBJpb5p7ZObRHg7aj?=
 =?us-ascii?Q?HfGHCHmo1ritlrhv3rHm1sNW3bzmOJKQgnCdpO6MsyaOn2Z+gJTxKpXN+ZpA?=
 =?us-ascii?Q?02HE4RtdAC7ZkN1T5WgeCGsPsDsNJHRIN6jOwMYwfELLSTT2DE1BV0opjnSF?=
 =?us-ascii?Q?3Q0f01ijvjqw7TXABsehwRwBVzWu3gVensE/XVa7l58X2/LRd5WyxgSqt31K?=
 =?us-ascii?Q?lwcYIwDCrZIbM2NTZJCZjCNiyScg9fEIE2P/5UHh6lx98Macvt3VzdHi3G5J?=
 =?us-ascii?Q?crHyWIyJ02Wqho2jphO0UrVyrMe57fVUfghNZRg5DUrusiBuagCrXcmHqyaO?=
 =?us-ascii?Q?bUr/X3J2khArQ9zpTqt2Of4/IOBWyFmR7BUtykcGvLLLXDfLoW4dCRysqB6f?=
 =?us-ascii?Q?H7c9tT8SMDvJ8mLa05hCNY/FrZrSXaQ+w/Dojy4grbHLsUjH88bsAEMI23jm?=
 =?us-ascii?Q?Rz5AvNbAlyvmx63a7GYYb85QEH+SE+4qLeAtutmuXpp3ivKcLcBt+yFj/C6A?=
 =?us-ascii?Q?ELPSSgn854WPmd7AgRm7NHJUkOj4o8XUcLcbg7e0UewaB7j7e1Xz7924VAp9?=
 =?us-ascii?Q?kMig3kGCQ/xjwGGEUhkXGLBfKYFh2eV5Z2XcyJTTUxt958RmJcWgB6Q7P8mJ?=
 =?us-ascii?Q?1ScRauGsolXWRK1k78gC3CeC3HfvOVGDbxAWXTALwBqKqgT3xSU3Kp1euyam?=
 =?us-ascii?Q?wFjtJex7U9Z51tQojC/d597LdYaTwZwtanuYvedaItWlD8TycTv9OohTW6Cg?=
 =?us-ascii?Q?Edd0aVCJBBChAmBaer2UMPbRZEG9GULgzYpp4SBJIvTZWrw2ysXQjVl526rx?=
 =?us-ascii?Q?mJndPEyUB7FdjuEkeRlFEqgNe4rgIcdLQdbdkXLi1wdpL2dspIwawdTyviMC?=
 =?us-ascii?Q?CoRs6sis53so3OWRH9vLJXhcgLoleVtj2BioXcvjx3J22L7hOYRprK0zx6uG?=
 =?us-ascii?Q?NxcscQVLqyL95cCc34H44JxqzuuqwJ+NzqSIAMVNLaagi2YX3hg9SOq6aho+?=
 =?us-ascii?Q?jDl8YGUAQZbHXI2b8CbWjG/vYPjDJs6DxG/GgH0C5oz422vFSqOK8e6eDLAK?=
 =?us-ascii?Q?e6xSMEBs0o9zOxtE/B2jw3FniTNL6XR+TxmYpGYKkXiTB0+iIhT1sCNtL0IL?=
 =?us-ascii?Q?aeT/92Yv+wnqfNW0o7aONEl97+Op7GmVpg2HJLEkOnBhTn+UIAEDZ1w32OVH?=
 =?us-ascii?Q?+h2EzvNXI3YpFt1YE9Hb1ZFMTML3NqpKt7xFDUh0Y6etO7dVdwlikCkvbiEx?=
 =?us-ascii?Q?pY689At5bLEKsR+fuKXV/54flUqcto81FVmKDVabVnaB7T9/Fl7oeY/dSHJC?=
 =?us-ascii?Q?VUuAGGhyjKYz3w9K1KdQFoo7YU94sTFNeVmpulipaz8S1ZaxDSjDFjERf+dQ?=
 =?us-ascii?Q?5sBXWo1S1XYsXgxMwPM3duwggDKQnPcpIWJtlQ6b?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7953b6e4-4478-4985-3ccc-08dd1b1e8987
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 02:33:32.8996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1gGIz+MmVHGUI7LSRmnhXmGpNVeKHwysx9aBF6cO/EJuyxPTJf3m4rfkhwMUBT0/E9mEDHF+ii1WL+aw4WayXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7114

In addition to supporting Rx checksum offload, i.MX95 ENETC also supports
Tx checksum offload. The transmit checksum offload is implemented through
the Tx BD. To support Tx checksum offload, software needs to fill some
auxiliary information in Tx BD, such as IP version, IP header offset and
size, whether L4 is UDP or TCP, etc.

Same as Rx checksum offload, Tx checksum offload capability isn't defined
in register, so tx_csum bit is added to struct enetc_drvdata to indicate
whether the device supports Tx checksum offload.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
v2: refine enetc_tx_csum_offload_check().
v3:
1. refine enetc_tx_csum_offload_check() and enetc_skb_is_tcp() through
skb->csum_offset instead of touching skb->data.
2. add enetc_skb_is_ipv6() helper function
v4: no changes
v5:
1. remove 'inline' from enetc_skb_is_ipv6() and enetc_skb_is_tcp().
2. temp_bd.ipcs is no need to be set due to Linux always aclculates
the IPv4 checksum, so remove it.
3. simplify the setting of temp_bd.l3t.
4. remove the error log from the datapath
v6: no changes
v7:
1. Change the layout of enetc_tx_bd to fix the issue on big-endian
hosts.
2. Rebase the patch due to remove the Rx checksum offload patch from
v6.
v8: no changes
---
 drivers/net/ethernet/freescale/enetc/enetc.c  | 54 ++++++++++++++++---
 drivers/net/ethernet/freescale/enetc/enetc.h  |  2 +
 .../net/ethernet/freescale/enetc/enetc_hw.h   | 15 ++++--
 .../freescale/enetc/enetc_pf_common.c         |  3 ++
 4 files changed, 64 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 535969fa0fdb..b8ac680e46bd 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -146,6 +146,27 @@ static int enetc_ptp_parse(struct sk_buff *skb, u8 *udp,
 	return 0;
 }
 
+static bool enetc_tx_csum_offload_check(struct sk_buff *skb)
+{
+	switch (skb->csum_offset) {
+	case offsetof(struct tcphdr, check):
+	case offsetof(struct udphdr, check):
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool enetc_skb_is_ipv6(struct sk_buff *skb)
+{
+	return vlan_get_protocol(skb) == htons(ETH_P_IPV6);
+}
+
+static bool enetc_skb_is_tcp(struct sk_buff *skb)
+{
+	return skb->csum_offset == offsetof(struct tcphdr, check);
+}
+
 static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 {
 	bool do_vlan, do_onestep_tstamp = false, do_twostep_tstamp = false;
@@ -163,6 +184,30 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 	dma_addr_t dma;
 	u8 flags = 0;
 
+	enetc_clear_tx_bd(&temp_bd);
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		/* Can not support TSD and checksum offload at the same time */
+		if (priv->active_offloads & ENETC_F_TXCSUM &&
+		    enetc_tx_csum_offload_check(skb) && !tx_ring->tsd_enable) {
+			temp_bd.l3_aux0 = FIELD_PREP(ENETC_TX_BD_L3_START,
+						     skb_network_offset(skb));
+			temp_bd.l3_aux1 = FIELD_PREP(ENETC_TX_BD_L3_HDR_LEN,
+						     skb_network_header_len(skb) / 4);
+			temp_bd.l3_aux1 |= FIELD_PREP(ENETC_TX_BD_L3T,
+						      enetc_skb_is_ipv6(skb));
+			if (enetc_skb_is_tcp(skb))
+				temp_bd.l4_aux = FIELD_PREP(ENETC_TX_BD_L4T,
+							    ENETC_TXBD_L4T_TCP);
+			else
+				temp_bd.l4_aux = FIELD_PREP(ENETC_TX_BD_L4T,
+							    ENETC_TXBD_L4T_UDP);
+			flags |= ENETC_TXBD_FLAGS_CSUM_LSO | ENETC_TXBD_FLAGS_L4CS;
+		} else {
+			if (skb_checksum_help(skb))
+				return 0;
+		}
+	}
+
 	i = tx_ring->next_to_use;
 	txbd = ENETC_TXBD(*tx_ring, i);
 	prefetchw(txbd);
@@ -173,7 +218,6 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 
 	temp_bd.addr = cpu_to_le64(dma);
 	temp_bd.buf_len = cpu_to_le16(len);
-	temp_bd.lstatus = 0;
 
 	tx_swbd = &tx_ring->tx_swbd[i];
 	tx_swbd->dma = dma;
@@ -594,7 +638,7 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	struct enetc_bdr *tx_ring;
-	int count, err;
+	int count;
 
 	/* Queue one-step Sync packet if already locked */
 	if (skb->cb[0] & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
@@ -627,11 +671,6 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 			return NETDEV_TX_BUSY;
 		}
 
-		if (skb->ip_summed == CHECKSUM_PARTIAL) {
-			err = skb_checksum_help(skb);
-			if (err)
-				goto drop_packet_err;
-		}
 		enetc_lock_mdio();
 		count = enetc_map_tx_buffs(tx_ring, skb);
 		enetc_unlock_mdio();
@@ -3274,6 +3313,7 @@ static const struct enetc_drvdata enetc_pf_data = {
 
 static const struct enetc_drvdata enetc4_pf_data = {
 	.sysclk_freq = ENETC_CLK_333M,
+	.tx_csum = 1,
 	.pmac_offset = ENETC4_PMAC_OFFSET,
 	.eth_ops = &enetc4_pf_ethtool_ops,
 };
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 72fa03dbc2dd..e82eb9a9137c 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -234,6 +234,7 @@ enum enetc_errata {
 
 struct enetc_drvdata {
 	u32 pmac_offset; /* Only valid for PSI which supports 802.1Qbu */
+	u8 tx_csum:1;
 	u64 sysclk_freq;
 	const struct ethtool_ops *eth_ops;
 };
@@ -341,6 +342,7 @@ enum enetc_active_offloads {
 	ENETC_F_QBV			= BIT(9),
 	ENETC_F_QCI			= BIT(10),
 	ENETC_F_QBU			= BIT(11),
+	ENETC_F_TXCSUM			= BIT(12),
 };
 
 enum enetc_flags_bit {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 55ba949230ff..0e259baf36ee 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -558,7 +558,16 @@ union enetc_tx_bd {
 		__le16 frm_len;
 		union {
 			struct {
-				u8 reserved[3];
+				u8 l3_aux0;
+#define ENETC_TX_BD_L3_START	GENMASK(6, 0)
+#define ENETC_TX_BD_IPCS	BIT(7)
+				u8 l3_aux1;
+#define ENETC_TX_BD_L3_HDR_LEN	GENMASK(6, 0)
+#define ENETC_TX_BD_L3T		BIT(7)
+				u8 l4_aux;
+#define ENETC_TX_BD_L4T		GENMASK(7, 5)
+#define ENETC_TXBD_L4T_UDP	1
+#define ENETC_TXBD_L4T_TCP	2
 				u8 flags;
 			}; /* default layout */
 			__le32 txstart;
@@ -582,10 +591,10 @@ union enetc_tx_bd {
 };
 
 enum enetc_txbd_flags {
-	ENETC_TXBD_FLAGS_RES0 = BIT(0), /* reserved */
+	ENETC_TXBD_FLAGS_L4CS = BIT(0), /* For ENETC 4.1 and later */
 	ENETC_TXBD_FLAGS_TSE = BIT(1),
 	ENETC_TXBD_FLAGS_W = BIT(2),
-	ENETC_TXBD_FLAGS_RES3 = BIT(3), /* reserved */
+	ENETC_TXBD_FLAGS_CSUM_LSO = BIT(3), /* For ENETC 4.1 and later */
 	ENETC_TXBD_FLAGS_TXSTART = BIT(4),
 	ENETC_TXBD_FLAGS_EX = BIT(6),
 	ENETC_TXBD_FLAGS_F = BIT(7)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 0eecfc833164..09f2d7ec44eb 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -119,6 +119,9 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 
 	ndev->priv_flags |= IFF_UNICAST_FLT;
 
+	if (si->drvdata->tx_csum)
+		priv->active_offloads |= ENETC_F_TXCSUM;
+
 	/* TODO: currently, i.MX95 ENETC driver does not support advanced features */
 	if (!is_enetc_rev1(si)) {
 		ndev->hw_features &= ~(NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_LOOPBACK);
-- 
2.34.1


