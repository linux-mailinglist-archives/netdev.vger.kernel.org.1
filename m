Return-Path: <netdev+bounces-261005-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFAVL2YRn2nNYwQAu9opvQ
	(envelope-from <netdev+bounces-261005-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 16:12:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9DB19948B
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 16:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C9D063107DF5
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8502E3D5231;
	Wed, 25 Feb 2026 15:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JxL/gGPe"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010018.outbound.protection.outlook.com [52.101.84.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865453921D3;
	Wed, 25 Feb 2026 15:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772032057; cv=fail; b=H6ZgQJEn2odnenmaVdoDVM7Mjer10yrrE9oNfOQWJ8g8f5Nmg10Rb/xiuSS+WS2zmXAlP1+07Q7Kl0FnQtWGiwNqOAK8spAHpm/3zmhIdpW8T+fC/XYYnYp+mxTL6xS2m60WEqS2fGd7OtmrIN798LrerqR1ZVeN7VSpz1XzWAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772032057; c=relaxed/simple;
	bh=Nku+LfVRT3lkpWN15Ap1JLbhRdNNh+qEoHk53IVYhPI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gbEzzizGBe7R8jy8G7W0ViFyHSXUN6HoZyUDcURNwcNy84Z33OwRVsXMFTCpEPD+KhDZmz70CKvRQT5ZJUwZdmXBflQTS9OWUGB4nw7jwmeuCMCvJesGAsQFBoRLk/5AvP0GEvuQ7R0LR2BtLEv3TmdNHeKxtuQWVO1j9InpubM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JxL/gGPe; arc=fail smtp.client-ip=52.101.84.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YctFQ+W0Y7AOrsPHMDd4vNuR3026gDNzEvKcVRxfUNQCUkKwZ+QoHgd0z1Sl7OXmZAH5TooZHQ3Qx865y/cl/vgyuw2SCSeus/npaP1cUS346t9md7jc8CcCZQpxPr7+lEo4Pk5mitOfKpz6y0wo+bgVCbxT4n0Dykpk15Q2jWAYsW4WDSmCdl21szNDN0yNHGrdm/NKpV26nnhUQyZ3RSSMgUxinCwcgLLtpVvNiUWzutED2w04FEpislg5mI9O7YoqEsc0L5c1QxXC8TkJPla4FpiFfk78H7wI2lRvT27R3AZaD6AjbpiRrrI5N4phrp0M//owMZRY8o4XuE4FZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AH8DrDa24YCtsChSfG14xHFO8slrd8Sjz3kfnLPi6eM=;
 b=N3X7fHDGLebjMlwZTbA1hqgTD2BybhP3t9lsJqYvswvpj3UvP1sSsVMmU4e674BCQlP0R+TsPY41Tz3PqUjxuYczu+YU6UCqqhzY+taoEjIMemoCYYQZoiDJ9SGJeuh10Fx0M5xG/hoHEOj2lFuKeoNegzkfDakm+MzD4CzOXTQxcmJAqKxdBMx39ZVe8xHsrSXFbZdz16dwZvm3CvvPcyg/TczSqqI+171unfIcSZc4YI7cqfIzkBPuDUWGSWSLFkb+upPzBxXk+92Xn0HDb8gEJaPZTAHkI+VtfjvL5rC3pX910OPdB0Z0AzfFB8JEcxmxw2vfRzNv1BTm/5nHrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AH8DrDa24YCtsChSfG14xHFO8slrd8Sjz3kfnLPi6eM=;
 b=JxL/gGPeS02XPmfPrZtC2bjTUu1Q+Hs1UwazbNu5fo8kdZBTTxsgVa8R9B2wD4KQJ/c8jEjhSRKL4DzBkXlYkgYJk20fuW1xW3tmWWcXIxvx1DdRf0zGaY2APlNzbRtIlPyVBa49B7BWB16Ec8Q4dEWHx5lH+gqfyCIRpTNP5Qf0QJE8f+4b5zH6KEVoADg1og0EV/aqAhdZQCkFNj8S2W1ciV9ZMmh4xbWSkVeYXQ80OvWIj+4r4ksAPiKvE1cpLPCYVYAEHIhNtjzB3r/nW5mS5VH37aa8W0c7KuYu2e3KXrdeRO6nEM5H+OXXb+XxWq2QY/J9jsv3Y/BpOBLowg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by DBBPR04MB7914.eurprd04.prod.outlook.com (2603:10a6:10:1f0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 15:07:32 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 15:07:31 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 2/5] net: dpaa2-mac: retrieve MAC statistics in one firmware command
Date: Wed, 25 Feb 2026 17:06:45 +0200
Message-Id: <20260225150648.1542206-3-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260225150648.1542206-1-ioana.ciornei@nxp.com>
References: <20260225150648.1542206-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P250CA0028.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::16) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|DBBPR04MB7914:EE_
X-MS-Office365-Filtering-Correlation-Id: da18cf75-c05c-43b2-efaf-08de747f996f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|19092799006;
X-Microsoft-Antispam-Message-Info:
	pED2xdSLrEA2FeXuCFsqqCJmHOA4iPOm+eTyiuf3vm6MFOaXMV6mGbJE7gyDTjutz8+Ix+EKJx+N98ObUbfEh52z+a/dLu4hctWGQCwnSHEhvGVX2xNl1WA7lkMzkEaJzTcJJ08tVkK4/V7ZZeS7sqom5RP0K/pXpDcVa3Q6T8Y0BpBiIaLl7xQzpXPzzWb00PtACk/3vDQNgsMR7RsGJjXVV0zi0qgxgsjsiCx+8rTaoTvWDix9iG3RG5Y66NeNATuzuQQkRdVRI+wbpVooPhnuReh/yndO0yGvbHJMdeKx/pXcU/c0M+zTw64tA79dGKjEXzF5/DXSIO9gAJZ1yRBJaZfqX3OUsFs4rInsQj3OhKH/XMTEbTU8K2pylq1uiYhm81c1Esj6vtww1akYtpxXpzMe4hJnSAZTCSeZ0cmJLnUGrrglmuROXAzqW6xGCaLX2F6eBhfVHx3tCsYFyspO7RdzpSFR1Bn2jo/4ldEGFME5XTDXmgcdd7M8hkrd88QmnF+awvv7uDjWZu5QPyf1bgb/qtjuAkMOAho1i/btZmIt7b3LuMvtb1rLstS0NodXoih1TbJBC+SpxjrLvsjUH16QK8CbSBNT+rYx7vTr81eyZ3UmvfQTynnonu6mWQlGk0wri0Ug0cBtvtgo8Kls90dNpZL5iOPaaPjkoVlkBSppI6lXYTMteOSL/lBaPIHKR4J6JR7InAw6RHw5+nkzp4Qo8olbzvrIPOEIzno=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WOwGVbwb7NDa+SgLxCapYNk+CmnNp+yXf/KkoUNvfxk6iEnEiJ3Ai3xG2eHy?=
 =?us-ascii?Q?AYvPhkWGyVxdQHChcYET0K2xSeyJ0wnAFMZCWq8VLnIb60OOV2csx7I4/5nJ?=
 =?us-ascii?Q?e3SiOgAMl3ZMLkbWaLP2z7qfTP+cwbzCIyEDlpMnrNP2GP48Re64nOZkH5zB?=
 =?us-ascii?Q?1W6rcz5wdpku7/zUM+6HgvLvCBtQeUm3rvvKRbbNcHA0WyITORw8uYEqazsP?=
 =?us-ascii?Q?qP55s8BeGlbL+ZS9QBYED6fI1j5/CxVln74WyCly7xl+oM72CxBK9BHHWYxY?=
 =?us-ascii?Q?RZTHtvdSwt/k0cFfMG+HoCTaBSQcHtM2fzkyAroDWbDiopx80+0k/ESggrpY?=
 =?us-ascii?Q?cVTFjWKm1JSU3VpT9girHvqzSY8TOPJqyLYeXLIg4fkX0FsCt+45bSr7Y6ai?=
 =?us-ascii?Q?gXBUt9zYgEu8CipvUk8ZD+HPfVPESOruy6ga6h2qSoQ1BF/8g7gkqEhbXX93?=
 =?us-ascii?Q?4e/ex914joLQDVtmJrgspi+fs8kBMdY3MZ8tygspoedIrJrdtXxJk4e16p94?=
 =?us-ascii?Q?YO801u5Jgw3m/0aBvH0sYKr1VOIN02Spy5xxQEkMXpu2tVtGQ58M9IDI0YZG?=
 =?us-ascii?Q?DOUwVhHIT6szW2D5NTicf4/I+GnjtDySgpsLpfwZSZ4UknScvaU1fbLsX8mu?=
 =?us-ascii?Q?OUkiXY99nGqOapSB30V5oAJx5acUJn9IbbEjkgPkhO+FOVWgzK0LR2LyUakv?=
 =?us-ascii?Q?pDdti1Q1gQc5FByBdushSNCDSNMDbC8GQFG/5s/38D9NwAKF4W++gHBPJsgf?=
 =?us-ascii?Q?ZI2Ss0ysybDnL957ZNRtGjNouXXflHFGiroYOYK9n7Jz06cUq6zIvYRHRXql?=
 =?us-ascii?Q?3HFCgBcRmOt7Z2MpHAwO82gNv8PxfmlplRGSPihrvKcbMZEwwxTpM/9+FHC0?=
 =?us-ascii?Q?o9K0GdMVUheiE+7a/yx4ANhxXtIDrUk5khFr+wPjEVOLHj3E+IO0KkPx821n?=
 =?us-ascii?Q?BRq014YD7jteuwezdZvbIuCme2mOa1VZuyGuMmieTgbn5c5ItTsVCV5E9KEb?=
 =?us-ascii?Q?Ey7r+BeM+DkLl0agDDVPYfKm+Gc6aMoHYbGewQwIcBvgh3AAh+NJP2GIyRV9?=
 =?us-ascii?Q?Ijn8O9wqa/Lh5mOccWe8SdVzSAbVqLH8hOGvCXtuiV8z0gWxgDiJxzft0lkB?=
 =?us-ascii?Q?nZgJIF+1pfULVBx5YiSOYCZlbeuoZJJy5jxnRVcHL9ns0DNGO6DIyysm4ygx?=
 =?us-ascii?Q?bXYTLA3yc8YLtKGglchhSE8d2kIIUQBR3wA89L+B5Hyr9RbHmmfbdNnU/0uK?=
 =?us-ascii?Q?4F6ZcmFLrGY6fMXsqv+Smq6F2fmYMwAU803Np9ioW/38OOZzeYi219PAZ/Yx?=
 =?us-ascii?Q?hvH2LqcA37wZyxXXZF5ghPUYLflS/KehZWXaKC1EiDYAh8KrB5Nz1Itz7Uk5?=
 =?us-ascii?Q?HBv5L1mASrkquLq+ZDUPLK/VRdh79U8dw8d0FhlPOgprg/0Q9GqaChmuHc4o?=
 =?us-ascii?Q?YdPKcp5Xx1uUGwzm4MW/OAu3svHeWaru+U3pX0oF5fM9wWSkAd3Q7Np89bnI?=
 =?us-ascii?Q?SsIpv63edygwNMdrLgTBRpOltpT+k95Q89FGDKVfr6RBWCiFdMb+TtEBupmR?=
 =?us-ascii?Q?8O26IlxHeqI0QsfLLGGP0f1b7RAgJpQJLhuHHaEsptaJiKtCFVypo/kZp04v?=
 =?us-ascii?Q?5joUCTEh4vUuQThfnTqf5D2m6oVdGALuBKC4STj32CCIT2Aepll/UEIXXx5l?=
 =?us-ascii?Q?sfwaNOZW21ojIAPJhe/xGl5r7fxy7tVyI9aY9gA8wbNRz+x6CpmBM0lSUlpi?=
 =?us-ascii?Q?Q3x5aKIBpw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da18cf75-c05c-43b2-efaf-08de747f996f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 15:07:31.8574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hONBF2xw0olC/is40Em6AZGhmoScRHJySbxMW/Aq9T507UhBdIzCUp/cQHACconLoEb+V8J+pxYLMVUzCm52lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7914
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261005-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:mid,nxp.com:dkim,nxp.com:email]
X-Rspamd-Queue-Id: 3B9DB19948B
X-Rspamd-Action: no action

The latest MC firmware version added a new command to retrieve all DPMAC
counters in a single firmware call. Use this new command, when possible,
in dpaa2-mac as well.

In order to use the dpmac_get_statistics() API, two DMA memory areas are
used: one to transmit what counters the driver is requesting and one to
receive the values of those counters. These memory areas are allocated
and DMA mapped at probe time so that we don't waste time at runtime.

And since we are planning to add rmon, eth-ctrl and other standard
statistics using the same infrastructure, make the setup and cleanup
processes as generic as possibile through the dpaa2_mac_setup_stats()
and dpaa2_mac_clear_stats() functions.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 .../net/ethernet/freescale/dpaa2/dpaa2-mac.c  | 195 ++++++++++++++----
 .../net/ethernet/freescale/dpaa2/dpaa2-mac.h  |  10 +-
 2 files changed, 166 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
index 422ce13a7c94..63dc597dbd7c 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
-/* Copyright 2019 NXP */
+/* Copyright 2019, 2024-2026 NXP */
 
 #include <linux/acpi.h>
 #include <linux/pcs-lynx.h>
@@ -15,7 +15,121 @@
 #define DPMAC_PROTOCOL_CHANGE_VER_MAJOR		4
 #define DPMAC_PROTOCOL_CHANGE_VER_MINOR		8
 
+#define DPMAC_STATS_BUNDLE_VER_MAJOR		4
+#define DPMAC_STATS_BUNDLE_VER_MINOR		10
+
 #define DPAA2_MAC_FEATURE_PROTOCOL_CHANGE	BIT(0)
+#define DPAA2_MAC_FEATURE_STATS_BUNDLE		BIT(1)
+
+struct dpmac_counter {
+	enum dpmac_counter_id id;
+	const char *name;
+};
+
+#define DPMAC_UNSTRUCTURED_COUNTER(counter_id, counter_name)	\
+	{							\
+		.id = counter_id,				\
+		.name = counter_name,				\
+	}
+
+static const struct dpmac_counter dpaa2_mac_ethtool_stats[] = {
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_ALL_FRAME,  "[mac] rx all frames"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_GOOD_FRAME,  "[mac] rx frames ok"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_ERR_FRAME, "[mac] rx frame errors"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_FRAME_DISCARD, "[mac] rx frame discards"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_UCAST_FRAME, "[mac] rx u-cast"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_BCAST_FRAME, "[mac] rx b-cast"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_MCAST_FRAME, "[mac] rx m-cast"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_FRAME_64, "[mac] rx 64 bytes"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_FRAME_127, "[mac] rx 65-127 bytes"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_FRAME_255, "[mac] rx 128-255 bytes"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_FRAME_511, "[mac] rx 256-511 bytes"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_FRAME_1023, "[mac] rx 512-1023 bytes"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_FRAME_1518, "[mac] rx 1024-1518 bytes"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_FRAME_1519_MAX, "[mac] rx 1519-max bytes"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_FRAG, "[mac] rx frags"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_JABBER, "[mac] rx jabber"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_ALIGN_ERR, "[mac] rx align errors"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_OVERSIZED, "[mac] rx oversized"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_VALID_PAUSE_FRAME, "[mac] rx pause"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_BYTE, "[mac] rx bytes"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_EGR_GOOD_FRAME, "[mac] tx frames ok"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_EGR_UCAST_FRAME, "[mac] tx u-cast"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_EGR_MCAST_FRAME, "[mac] tx m-cast"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_EGR_BCAST_FRAME, "[mac] tx b-cast"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_EGR_ERR_FRAME, "[mac] tx frame errors"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_EGR_UNDERSIZED, "[mac] tx undersized"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_EGR_VALID_PAUSE_FRAME, "[mac] tx b-pause"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_EGR_BYTE, "[mac] tx bytes"),
+};
+
+#define DPAA2_MAC_NUM_ETHTOOL_STATS	ARRAY_SIZE(dpaa2_mac_ethtool_stats)
+
+static void dpaa2_mac_setup_stats(struct dpaa2_mac *mac, struct dpaa2_mac_stats *stats,
+				  size_t num_stats, const struct dpmac_counter *counters)
+{
+	struct device *dev = mac->net_dev->dev.parent;
+	u32 *cnt_idx;
+
+	stats->idx_dma_mem = kcalloc(num_stats, sizeof(u32), GFP_KERNEL);
+	if (!stats->idx_dma_mem)
+		goto out;
+
+	stats->values_dma_mem = kcalloc(num_stats, sizeof(u64), GFP_KERNEL);
+	if (!stats->values_dma_mem)
+		goto err_alloc_values;
+
+	cnt_idx = stats->idx_dma_mem;
+	for (size_t i = 0; i < num_stats; i++)
+		*cnt_idx++ = cpu_to_le32((u32)(counters[i].id));
+
+	stats->idx_iova = dma_map_single(dev, stats->idx_dma_mem,
+					 num_stats * sizeof(u32),
+					 DMA_TO_DEVICE);
+	if (dma_mapping_error(dev, stats->idx_iova))
+		goto err_dma_map_idx;
+
+	stats->values_iova = dma_map_single(dev, stats->values_dma_mem,
+					    num_stats * sizeof(u64),
+					    DMA_FROM_DEVICE);
+	if (dma_mapping_error(dev, stats->values_iova))
+		goto err_dma_map_values;
+
+	return;
+
+err_dma_map_values:
+	dma_unmap_single(dev, stats->idx_iova, num_stats * sizeof(u32),
+			 DMA_TO_DEVICE);
+err_dma_map_idx:
+	kfree(stats->values_dma_mem);
+err_alloc_values:
+	kfree(stats->idx_dma_mem);
+out:
+	stats->idx_dma_mem = NULL;
+	stats->values_dma_mem = NULL;
+}
+
+static void dpaa2_mac_clear_stats(struct dpaa2_mac *mac, struct dpaa2_mac_stats *stats,
+				  size_t num_stats)
+{
+	struct device *dev = mac->net_dev->dev.parent;
+
+	if (stats->idx_dma_mem) {
+		dma_unmap_single(dev, stats->idx_iova,
+				 num_stats * sizeof(u32),
+				 DMA_TO_DEVICE);
+		kfree(stats->idx_dma_mem);
+		stats->idx_dma_mem = NULL;
+	}
+
+	if (stats->values_dma_mem) {
+		dma_unmap_single(dev, stats->values_iova,
+				 num_stats * sizeof(u64),
+				 DMA_FROM_DEVICE);
+		kfree(stats->values_dma_mem);
+		stats->values_dma_mem = NULL;
+	}
+}
 
 static int dpaa2_mac_cmp_ver(struct dpaa2_mac *mac,
 			     u16 ver_major, u16 ver_minor)
@@ -32,6 +146,10 @@ static void dpaa2_mac_detect_features(struct dpaa2_mac *mac)
 	if (dpaa2_mac_cmp_ver(mac, DPMAC_PROTOCOL_CHANGE_VER_MAJOR,
 			      DPMAC_PROTOCOL_CHANGE_VER_MINOR) >= 0)
 		mac->features |= DPAA2_MAC_FEATURE_PROTOCOL_CHANGE;
+
+	if (dpaa2_mac_cmp_ver(mac, DPMAC_STATS_BUNDLE_VER_MAJOR,
+			      DPMAC_STATS_BUNDLE_VER_MINOR) >= 0)
+		mac->features |= DPAA2_MAC_FEATURE_STATS_BUNDLE;
 }
 
 static int phy_mode(enum dpmac_eth_if eth_if, phy_interface_t *if_mode)
@@ -504,6 +622,10 @@ int dpaa2_mac_open(struct dpaa2_mac *mac)
 	mac->fw_node = fw_node;
 	net_dev->dev.of_node = to_of_node(mac->fw_node);
 
+	if (mac->features & DPAA2_MAC_FEATURE_STATS_BUNDLE)
+		dpaa2_mac_setup_stats(mac, &mac->ethtool_stats,
+				      DPAA2_MAC_NUM_ETHTOOL_STATS, dpaa2_mac_ethtool_stats);
+
 	return 0;
 
 err_close_dpmac:
@@ -515,64 +637,61 @@ void dpaa2_mac_close(struct dpaa2_mac *mac)
 {
 	struct fsl_mc_device *dpmac_dev = mac->mc_dev;
 
+	if (mac->features & DPAA2_MAC_FEATURE_STATS_BUNDLE)
+		dpaa2_mac_clear_stats(mac, &mac->ethtool_stats, DPAA2_MAC_NUM_ETHTOOL_STATS);
+
 	dpmac_close(mac->mc_io, 0, dpmac_dev->mc_handle);
 	if (mac->fw_node)
 		fwnode_handle_put(mac->fw_node);
 }
 
-static char dpaa2_mac_ethtool_stats[][ETH_GSTRING_LEN] = {
-	[DPMAC_CNT_ING_ALL_FRAME]		= "[mac] rx all frames",
-	[DPMAC_CNT_ING_GOOD_FRAME]		= "[mac] rx frames ok",
-	[DPMAC_CNT_ING_ERR_FRAME]		= "[mac] rx frame errors",
-	[DPMAC_CNT_ING_FRAME_DISCARD]		= "[mac] rx frame discards",
-	[DPMAC_CNT_ING_UCAST_FRAME]		= "[mac] rx u-cast",
-	[DPMAC_CNT_ING_BCAST_FRAME]		= "[mac] rx b-cast",
-	[DPMAC_CNT_ING_MCAST_FRAME]		= "[mac] rx m-cast",
-	[DPMAC_CNT_ING_FRAME_64]		= "[mac] rx 64 bytes",
-	[DPMAC_CNT_ING_FRAME_127]		= "[mac] rx 65-127 bytes",
-	[DPMAC_CNT_ING_FRAME_255]		= "[mac] rx 128-255 bytes",
-	[DPMAC_CNT_ING_FRAME_511]		= "[mac] rx 256-511 bytes",
-	[DPMAC_CNT_ING_FRAME_1023]		= "[mac] rx 512-1023 bytes",
-	[DPMAC_CNT_ING_FRAME_1518]		= "[mac] rx 1024-1518 bytes",
-	[DPMAC_CNT_ING_FRAME_1519_MAX]		= "[mac] rx 1519-max bytes",
-	[DPMAC_CNT_ING_FRAG]			= "[mac] rx frags",
-	[DPMAC_CNT_ING_JABBER]			= "[mac] rx jabber",
-	[DPMAC_CNT_ING_ALIGN_ERR]		= "[mac] rx align errors",
-	[DPMAC_CNT_ING_OVERSIZED]		= "[mac] rx oversized",
-	[DPMAC_CNT_ING_VALID_PAUSE_FRAME]	= "[mac] rx pause",
-	[DPMAC_CNT_ING_BYTE]			= "[mac] rx bytes",
-	[DPMAC_CNT_EGR_GOOD_FRAME]		= "[mac] tx frames ok",
-	[DPMAC_CNT_EGR_UCAST_FRAME]		= "[mac] tx u-cast",
-	[DPMAC_CNT_EGR_MCAST_FRAME]		= "[mac] tx m-cast",
-	[DPMAC_CNT_EGR_BCAST_FRAME]		= "[mac] tx b-cast",
-	[DPMAC_CNT_EGR_ERR_FRAME]		= "[mac] tx frame errors",
-	[DPMAC_CNT_EGR_UNDERSIZED]		= "[mac] tx undersized",
-	[DPMAC_CNT_EGR_VALID_PAUSE_FRAME]	= "[mac] tx b-pause",
-	[DPMAC_CNT_EGR_BYTE]			= "[mac] tx bytes",
-};
-
-#define DPAA2_MAC_NUM_STATS	ARRAY_SIZE(dpaa2_mac_ethtool_stats)
-
 int dpaa2_mac_get_sset_count(void)
 {
-	return DPAA2_MAC_NUM_STATS;
+	return DPAA2_MAC_NUM_ETHTOOL_STATS;
 }
 
 void dpaa2_mac_get_strings(u8 **data)
 {
 	int i;
 
-	for (i = 0; i < DPAA2_MAC_NUM_STATS; i++)
-		ethtool_puts(data, dpaa2_mac_ethtool_stats[i]);
+	for (i = 0; i < DPAA2_MAC_NUM_ETHTOOL_STATS; i++)
+		ethtool_puts(data, dpaa2_mac_ethtool_stats[i].name);
 }
 
 void dpaa2_mac_get_ethtool_stats(struct dpaa2_mac *mac, u64 *data)
 {
+	struct device *dev = mac->net_dev->dev.parent;
 	struct fsl_mc_device *dpmac_dev = mac->mc_dev;
+	u64 *cnt_values;
 	int i, err;
 	u64 value;
 
-	for (i = 0; i < DPAA2_MAC_NUM_STATS; i++) {
+	if (!(mac->features & DPAA2_MAC_FEATURE_STATS_BUNDLE))
+		goto fallback;
+
+	if (!mac->ethtool_stats.idx_dma_mem || !mac->ethtool_stats.values_dma_mem)
+		goto fallback;
+
+	err = dpmac_get_statistics(mac->mc_io, 0, dpmac_dev->mc_handle,
+				   mac->ethtool_stats.idx_iova, mac->ethtool_stats.values_iova,
+				   DPAA2_MAC_NUM_ETHTOOL_STATS);
+	if (err)
+		goto fallback;
+
+	dma_sync_single_for_cpu(dev, mac->ethtool_stats.values_iova,
+				DPAA2_MAC_NUM_ETHTOOL_STATS * sizeof(u64),
+				DMA_FROM_DEVICE);
+
+	cnt_values = mac->ethtool_stats.values_dma_mem;
+	for (i = 0; i < DPAA2_MAC_NUM_ETHTOOL_STATS; i++)
+		*(data + i) = le64_to_cpu(*cnt_values++);
+
+	return;
+
+fallback:
+
+	/* Fallback and retrieve each counter one by one */
+	for (i = 0; i < DPAA2_MAC_NUM_ETHTOOL_STATS; i++) {
 		err = dpmac_get_counter(mac->mc_io, 0, dpmac_dev->mc_handle,
 					i, &value);
 		if (err) {
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.h b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.h
index 53f8d106d11e..386286209606 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.h
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
-/* Copyright 2019 NXP */
+/* Copyright 2019, 2024-2026 NXP */
 #ifndef DPAA2_MAC_H
 #define DPAA2_MAC_H
 
@@ -11,6 +11,12 @@
 #include "dpmac.h"
 #include "dpmac-cmd.h"
 
+struct dpaa2_mac_stats {
+	u32 *idx_dma_mem;
+	u64 *values_dma_mem;
+	dma_addr_t idx_iova, values_iova;
+};
+
 struct dpaa2_mac {
 	struct fsl_mc_device *mc_dev;
 	struct dpmac_link_state state;
@@ -28,6 +34,8 @@ struct dpaa2_mac {
 	struct fwnode_handle *fw_node;
 
 	struct phy *serdes_phy;
+
+	struct dpaa2_mac_stats ethtool_stats;
 };
 
 static inline bool dpaa2_mac_is_type_phy(struct dpaa2_mac *mac)
-- 
2.25.1


