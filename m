Return-Path: <netdev+bounces-239692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D12C3C6B5AD
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 20:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id 4BF4929099
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 19:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C1E369233;
	Tue, 18 Nov 2025 19:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DDD8o61X"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013035.outbound.protection.outlook.com [40.107.162.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907FD36827C;
	Tue, 18 Nov 2025 19:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763492773; cv=fail; b=jQdfywHFd9nMdF1LjdMYeJx0U5lWOVdD6sqXyQlhtzeBhxhy2GvLiHJV9zU1SL4inZBjDBWYpVP3GW8Wfen8gpzzAPgeo2zd6m6TKNRVhYRZunOixqD/MwlMfa4QD68Pd4aVkHVcfmBo8FRf/2zVRka1y/xbwqKAJ8eXYxKjCVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763492773; c=relaxed/simple;
	bh=gKuEqsLG3CNospalsrMA5YZ9fWswOfezWT948nwqec8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UYrpPNFE520rBC/auEWfhV+JgkLIlCeKVbY7P09h0qLbIGF4CQcijjEPUBiN4Toz2QEN/Eivs5BU/JtCkdW1J9byd1IhUojfOh3lnB7h/sYS5qmYe+sFOdb7WQbwleryQ770FBpjh4LVLcQ1Beg/kr95/Ruz4lucSZjubnYFZP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DDD8o61X; arc=fail smtp.client-ip=40.107.162.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oHDdUvAMAzbVZfjloQaQiMk229rqm0Vwc63tDS4ztZu0j6/4UTqTtGn6wpZtDKAQEuwa3N0AZzwfTOiXfb0UASfLYvFFRYnf6m+HHhU9yoMikuGBJwGP676siyTSB8DXL2joZk0YFwV7bYDE8AJQB+S9l4PNW8ckHVbuo+AQUshB7c6QUSQ+Oot9VKDzCHH9hdzdfN8GwDjZuuqZ8Xr434/D5SoxryoNvGUaCUBiUws22SpXNr+c7RyYyK/iW/irwMwmmTrcKVEJX0ZG89yCRGRE56a0ktVrqwig7w3xW7V3ntjpzfnxlJvDzQYPnXUv+5SuLeivzT/lOaOgi4NBgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZPWNvmLEtc0ng7Rs4Ok+eVovfXw4+QCKnKcjcbdKe0=;
 b=e4apQAe8iRJvqRkGyGiW+knRKCby+TpnBhjSD7eyospJqOS+D571ujyU/Yr6E7kAAeNXSHB8Xa4eTRz97xb8R2xCOPi7/ILEfom8cyKVtuWE8OTcrHq/LuDf9Rt0EkXJVzMG1Qhn1imZLjY1xp45/vwQ33UgaxpqZSRu+7vgFPsh08/vRq67UWIZExfFc8rrycH+43+XCgaCtH3hajlnnPQNARArp1SA13ywMR0wMZkziB9NIIRPB0fjDPDsUVp0ybu8FSanBXBs7nhf/ZJUw7bPoNMMXdA0AO7cubnN4LlbBzVCoY0isAqU6lWpA1/hYRxklSVkSz+VwOt0jHjcAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZPWNvmLEtc0ng7Rs4Ok+eVovfXw4+QCKnKcjcbdKe0=;
 b=DDD8o61XTp9RLowYK9DRz16sAOXy/jv4EXCRMCDT45lGjgA3pPGjZlR1EWhLwRPQ/4OcDvLDe0lJbdMiploSpUdRajbSWVwpryY7njr8w/sMNQ1Ct4SoKSEL5jBmaMLwtukEj+3FZy8SLLMeCFiNuhAE81ZzafZFAZoitZ0Az+XfPWQ+3+UGqaXmREIIbT4vhSCZQhkGpgNQVrcvTCPLrprTSqkRJvW008Hg6aTp739tMDB8/D5E9gPRUSUW0F6BFw8AHv1k0N4tFxMgk3qNwHmM9izdQLteCR3DGcp4n7c+Q8kcRjo6jhdsgTx/DI3neQPbnuvqoC+MvQmzjaawbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com (2603:10a6:10:204::9)
 by PA4PR04MB7695.eurprd04.prod.outlook.com (2603:10a6:102:e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 19:06:00 +0000
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff]) by DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff%4]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 19:06:00 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH net-next 11/15] net: pcs: xpcs-plat: convert to regmap
Date: Tue, 18 Nov 2025 21:05:26 +0200
Message-Id: <20251118190530.580267-12-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251118190530.580267-1-vladimir.oltean@nxp.com>
References: <20251118190530.580267-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0022.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::32) To DBBPR04MB7497.eurprd04.prod.outlook.com
 (2603:10a6:10:204::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7497:EE_|PA4PR04MB7695:EE_
X-MS-Office365-Filtering-Correlation-Id: 287c3964-cc9d-4e94-397a-08de26d582d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|7416014|376014|52116014|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PPGlMvxU5d+F5g6UsUbGTodxNrcwRj+xu+AaOIafU9bbf9E7r+nDqPmq3NMZ?=
 =?us-ascii?Q?n3IWcJTIKlUXB4ri+9+XK0a6iwtPdPUnp3zPP9RZO8gyxtPe4E0NW7Gkwbfr?=
 =?us-ascii?Q?UGsYHtqvPHxmonmuoLSxC8djr3/jZQ2rluys0HbzSblp+AGTDYU9iRVUwR3n?=
 =?us-ascii?Q?3lca6MnkzW1rkKUZP28f/hAeXkkmH6+0BjgoT/pze3aen3Uftw0gGMcoIsoW?=
 =?us-ascii?Q?2LLiz4VFnNcGZqf/Qv9yLLfz+txTO3bE+XnPB8EglaxorGq6byYxcHn2LiP6?=
 =?us-ascii?Q?yoLG02L+jcA6DGgpVyIqGS6PiAKE/Cm8sShma0qTSxn3RkYdPOuUB9U2bdum?=
 =?us-ascii?Q?xlRpSIUfPQ02kcafHnyQRavyuobsF55TIs3V51h+z0HzExslzRrK7Hr6uHug?=
 =?us-ascii?Q?OZXs2AHANesQZhI0VQ8058Lku/UjcRfRFYtsKmkQND/W7p0oqeUZVQ6wwjP6?=
 =?us-ascii?Q?kZJyWoPwYKv6uvO08gNXiRS+DUo6qp3T74P/ND3CeSae3/d4yPgVOCex5D+K?=
 =?us-ascii?Q?yxjDxXiWOLnUbl+9m2R8KioIjfuyKtMAoYikPVh/UNLK40/ZDF3CuBKX6Oi+?=
 =?us-ascii?Q?P9I30PJcAJxpi8eEPhbmg+U55tizunFhwt2jVgJ0yhx52djTzMyOV7i46AN8?=
 =?us-ascii?Q?GeqXHE8Z1+KRotN5NuEKyIqz29M+1OyFkamgd8f6atkGm32uKL+BiOIjTyJn?=
 =?us-ascii?Q?02usCVNVP0RvwxBoYzjEpEZkHVml0qY21hlu5kgz0nxDQf8k2M/Tlode722q?=
 =?us-ascii?Q?WGTEdj7pn5TU7JQXVotNGTD0uHapaWa0H/sHW3FJFMwT0EOAy0wmj2j1qydS?=
 =?us-ascii?Q?yLfRmgTs4WUayw7opAg52/SdmD4Z44cVDfp/QdD8ar+f7QClnr5HfvAGcraq?=
 =?us-ascii?Q?sO7JfqWd3gy/juo+QX7fphJ0TDbH+tZuLuE6xq5mtfl487AV1ANtvqKFegNo?=
 =?us-ascii?Q?2skJArJVCGaUCOVAhxf1rtQuknvzRjZN9FocSLczfrLybskHYY2gE9u7g96s?=
 =?us-ascii?Q?TTkslg20eJvjZ4fzpSY3HbQPA+Q52yO8nme+sjmW4Plt99RSejB5sZLiuFny?=
 =?us-ascii?Q?GwfQsgnco7e8+Ufk0yJgXfz7hzg/H7/qzFGui0+YbMh1OooTcbtvjFf8qm//?=
 =?us-ascii?Q?dmxPgVGEcJDfH1JKIhSOP0cQpy3Qg31j8PfK9ZJ1S5LpphDY/jro5WjFVUHL?=
 =?us-ascii?Q?DusYRQkt/0aUjQ6OvV3YK+ZE3q+7h0WYGYCZ9UyRKmbWPD96B1TinTEcTd5C?=
 =?us-ascii?Q?qly+vBYvYx1oIzNMglVy1kQlJIhQ9+DBoI19nGLLA3gSMmFwZkgugNvUdrjh?=
 =?us-ascii?Q?wgwzJCUgBZeDRO/cFrVIjZGdDBKP8+jXHjT2Zxx3JLcya/gMQvebjd4Wbg6g?=
 =?us-ascii?Q?XzbCuIQuBJq4BJh8x6TwUfoIP6k6C7pkK8RSEvls1QFFUwpRCwPCoDD4Xbzz?=
 =?us-ascii?Q?uPg2NJS8dLnM4wgKUWWCPi2CfDzcmxmI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014)(52116014)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ihoODRFcgGXyJU39W2NX8VHMAnlTaY3IvyNtti8YniiCan87urLgaL9uwusS?=
 =?us-ascii?Q?nPKrlW9em0scGJo9GeQbh6gTqXnZzJcyy3kVfzsqBpa7qCp68zRSmy4on2DP?=
 =?us-ascii?Q?jRq3v+hzC7ABChw4Nx7Q5jrqDNP1Ja54fgLo6loxN0H2wHSN2TGXeIC5Rc7K?=
 =?us-ascii?Q?yiFNoHYjoBNwur1qil6uosRkYCBTrYSKgJ0hhC1MRbDc4MawTdS1ehXReNzU?=
 =?us-ascii?Q?wV+48vBii9hJpBwR54GllW3JkbXBnAZm8tocKkah8+cbKXBhFaOibFLSeNPP?=
 =?us-ascii?Q?u6zbuNvtt2PDFbslfOP5Fp/4xgfaTM7VgAoTbb6v3F222QLHosyhQhrGb77M?=
 =?us-ascii?Q?xJn00KmfFCrrk30KFm+rz31UiG604XQYv71JjBJf9MG2ccigfOmNMPuF2QxM?=
 =?us-ascii?Q?9aMqafs0s6nCkFmhvxu32EJyNKZcrfcmU59YYmxlbkS4yCbf/8RjieiiV/Gl?=
 =?us-ascii?Q?1NS9JiIm8ZSVezu6Iyr0bwZU7M2liBV9CfrbRGzHGOLZ0wZX7cqMZo3nMJdi?=
 =?us-ascii?Q?gb8+cWgCD03PkbSdZVIyi1HMaK5Jg4l94TlAg5EkGmbourcWOKsXRqpYJwMo?=
 =?us-ascii?Q?kTZCkCMqjHdC7TfMqhETlE81ziMVdnYwhqniQ6uQTV4PiyeI/2NmvubwtBz3?=
 =?us-ascii?Q?qrGUycyYz1fHhOkdRf/hu8D6gnB936Y+zTHedz8RIAaQP3waWcMnfs7qXXG7?=
 =?us-ascii?Q?js9QKvsVYWhcEcgMhntCDPhU7J2HdTUJyxwZ0+ppOURm2quvQQp1Uzg4exbo?=
 =?us-ascii?Q?qVlMtF5RcpfKYFegzAUs0DYAI2+63m/mORcuv07h7rNcbIZl4rWbLqiPU8Zz?=
 =?us-ascii?Q?R+DMBN3CN6KrX8nnRXM0TRxAiOM1nJe1Uu92Sk6KDAVofY6wfEedtmoGeQun?=
 =?us-ascii?Q?Mh9KZtmp27UGNREVo1+EDclywVOoJc2lH5ajLKAlNS8kOZIKlXacBz6Dj7DW?=
 =?us-ascii?Q?3lhX6pAE6NbO7cYwHGx34FgQQ7fPXrG6kVTkaf53klD7UEUIRxyPsNS5nBvU?=
 =?us-ascii?Q?qA03VZyLovdhP/RLqyfLVaZrhtq/zfVoPwwLIBYUQ/F+LiezCudR9XIHafX2?=
 =?us-ascii?Q?H+Ky747LbuVu+YSE7jFhQbAhxKgE6mje1uWy2aJ6JfAYLXBP9QpSC3dPksd1?=
 =?us-ascii?Q?QGxdRIhEzdUSTcRPfDBDn9OKGtd0cH+uQkFZPP1w5CldyR275X3DaORfKj1A?=
 =?us-ascii?Q?1BWdkXSV0g+NKiVrxLhiUMfYOM/FASdLmPLdhCmAxR4v2zC07FzcVoSVxmjR?=
 =?us-ascii?Q?zWx7rMrHt1zJJ/1qYtGbT1JA8+Q8PntJHZxARlZgm8DAcPNs+kiULMxRWdUN?=
 =?us-ascii?Q?NtFZ+b2MB5nshL/vh4SuQ3tVT8OMFK6eo2cYgsGaLLfhCu9oR4H67nCwJEKo?=
 =?us-ascii?Q?NLfd7Lb+cpyvpH+HP+2SszUn/MrEiWFzwJTrbMYGKcqGKAxA0qIjdb55UBSy?=
 =?us-ascii?Q?P31iTKZo34M9UMXRROn84JOwBLnD4M/KWIFZmj9cf9BensypMPypE4KlY2WD?=
 =?us-ascii?Q?mePqzc/O7VSQ7XjyilwVAvVV/Yawity/limh1KfwGBrzsYIBUN9F7mefwT/7?=
 =?us-ascii?Q?CAI4tSghWAHrgmT7QgdmT2NhyJ2TwDmCHlK7/Dnx82BQ4dZ+620ANECXMJoU?=
 =?us-ascii?Q?KldKhmAgQJHQrK5jnDVzWJA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 287c3964-cc9d-4e94-397a-08de26d582d1
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 19:05:59.9307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VUzrjUxTv3k3eublWIp/a/cN+URubNdBwK70wygW6fJmys0ycUxcjGIWV00nd7/Os1seq7kEpRb/dpnrhvcMmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7695

Generalize the MDIO buses for accessing memory-mapped XPCS devices
(through direct or indirect I/O) to also cover the case where the CSR is
behind an SPI bus. This is the case when accessing the embedded XPCS
from the NXP SJA1105/SJA1110 DSA switches.

Cc: Serge Semin <fancer.lancer@gmail.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/pcs/pcs-xpcs-plat.c | 142 +++++++++++++++++++++-----------
 1 file changed, 95 insertions(+), 47 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs-plat.c b/drivers/net/pcs/pcs-xpcs-plat.c
index c422e8d8b89f..ea6482aa8431 100644
--- a/drivers/net/pcs/pcs-xpcs-plat.c
+++ b/drivers/net/pcs/pcs-xpcs-plat.c
@@ -17,6 +17,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
+#include <linux/regmap.h>
 #include <linux/sizes.h>
 
 #include "pcs-xpcs.h"
@@ -29,7 +30,8 @@ struct dw_xpcs_plat {
 	struct mii_bus *bus;
 	bool reg_indir;
 	int reg_width;
-	void __iomem *reg_base;
+	unsigned int base;
+	struct regmap *regmap;
 	struct clk *cclk;
 };
 
@@ -52,7 +54,9 @@ static int xpcs_mmio_read_reg_indirect(struct dw_xpcs_plat *pxpcs,
 				       int dev, int reg)
 {
 	ptrdiff_t csr, ofs;
+	unsigned int addr;
 	u16 page;
+	u32 val;
 	int ret;
 
 	csr = xpcs_mmio_addr_format(dev, reg);
@@ -63,19 +67,21 @@ static int xpcs_mmio_read_reg_indirect(struct dw_xpcs_plat *pxpcs,
 	if (ret)
 		return ret;
 
-	switch (pxpcs->reg_width) {
-	case 4:
-		writel(page, pxpcs->reg_base + (DW_VR_CSR_VIEWPORT << 2));
-		ret = readl(pxpcs->reg_base + (ofs << 2)) & 0xffff;
-		break;
-	default:
-		writew(page, pxpcs->reg_base + (DW_VR_CSR_VIEWPORT << 1));
-		ret = readw(pxpcs->reg_base + (ofs << 1));
-		break;
-	}
+	addr = pxpcs->base + (DW_VR_CSR_VIEWPORT * pxpcs->reg_width);
+	ret = regmap_write(pxpcs->regmap, addr, page);
+	if (ret)
+		goto err_put;
+
+	addr = pxpcs->base + (ofs * pxpcs->reg_width);
+	ret = regmap_read(pxpcs->regmap, addr, &val);
+	if (ret)
+		goto err_put;
 
 	pm_runtime_put(&pxpcs->pdev->dev);
+	return val & 0xffff;
 
+err_put:
+	pm_runtime_put(&pxpcs->pdev->dev);
 	return ret;
 }
 
@@ -83,6 +89,7 @@ static int xpcs_mmio_write_reg_indirect(struct dw_xpcs_plat *pxpcs,
 					int dev, int reg, u16 val)
 {
 	ptrdiff_t csr, ofs;
+	unsigned int addr;
 	u16 page;
 	int ret;
 
@@ -94,26 +101,25 @@ static int xpcs_mmio_write_reg_indirect(struct dw_xpcs_plat *pxpcs,
 	if (ret)
 		return ret;
 
-	switch (pxpcs->reg_width) {
-	case 4:
-		writel(page, pxpcs->reg_base + (DW_VR_CSR_VIEWPORT << 2));
-		writel(val, pxpcs->reg_base + (ofs << 2));
-		break;
-	default:
-		writew(page, pxpcs->reg_base + (DW_VR_CSR_VIEWPORT << 1));
-		writew(val, pxpcs->reg_base + (ofs << 1));
-		break;
-	}
+	addr = pxpcs->base + (DW_VR_CSR_VIEWPORT * pxpcs->reg_width);
+	ret = regmap_write(pxpcs->regmap, addr, page);
+	if (ret)
+		goto err_put;
 
-	pm_runtime_put(&pxpcs->pdev->dev);
+	addr = pxpcs->base + (ofs * pxpcs->reg_width);
+	ret = regmap_write(pxpcs->regmap, addr, val);
 
-	return 0;
+err_put:
+	pm_runtime_put(&pxpcs->pdev->dev);
+	return ret;
 }
 
 static int xpcs_mmio_read_reg_direct(struct dw_xpcs_plat *pxpcs,
 				     int dev, int reg)
 {
+	unsigned int addr;
 	ptrdiff_t csr;
+	u32 val;
 	int ret;
 
 	csr = xpcs_mmio_addr_format(dev, reg);
@@ -122,23 +128,23 @@ static int xpcs_mmio_read_reg_direct(struct dw_xpcs_plat *pxpcs,
 	if (ret)
 		return ret;
 
-	switch (pxpcs->reg_width) {
-	case 4:
-		ret = readl(pxpcs->reg_base + (csr << 2)) & 0xffff;
-		break;
-	default:
-		ret = readw(pxpcs->reg_base + (csr << 1));
-		break;
-	}
+	addr = pxpcs->base + (csr * pxpcs->reg_width);
+	ret = regmap_read(pxpcs->regmap, addr, &val);
+	if (ret)
+		goto err_put;
 
 	pm_runtime_put(&pxpcs->pdev->dev);
+	return val & 0xffff;
 
+err_put:
+	pm_runtime_put(&pxpcs->pdev->dev);
 	return ret;
 }
 
 static int xpcs_mmio_write_reg_direct(struct dw_xpcs_plat *pxpcs,
 				      int dev, int reg, u16 val)
 {
+	unsigned int addr;
 	ptrdiff_t csr;
 	int ret;
 
@@ -148,18 +154,11 @@ static int xpcs_mmio_write_reg_direct(struct dw_xpcs_plat *pxpcs,
 	if (ret)
 		return ret;
 
-	switch (pxpcs->reg_width) {
-	case 4:
-		writel(val, pxpcs->reg_base + (csr << 2));
-		break;
-	default:
-		writew(val, pxpcs->reg_base + (csr << 1));
-		break;
-	}
+	addr = pxpcs->base + (csr * pxpcs->reg_width);
+	ret = regmap_write(pxpcs->regmap, addr, val);
 
 	pm_runtime_put(&pxpcs->pdev->dev);
-
-	return 0;
+	return ret;
 }
 
 static int xpcs_mmio_read_c22(struct mii_bus *bus, int addr, int reg)
@@ -230,11 +229,48 @@ static struct dw_xpcs_plat *xpcs_plat_create_data(struct platform_device *pdev)
 	return pxpcs;
 }
 
+static struct regmap *xpcs_plat_create_regmap(struct dw_xpcs_plat *pxpcs,
+					      const struct resource *res)
+{
+	struct platform_device *pdev = pxpcs->pdev;
+	struct regmap_config config = {};
+	struct device *dev = &pdev->dev;
+	void __iomem *reg_base;
+
+	reg_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(reg_base)) {
+		dev_err(dev, "Failed to map reg-space\n");
+		return ERR_CAST(reg_base);
+	}
+
+	if (pxpcs->reg_width == 2) {
+		config.reg_bits = 16;
+		config.val_bits = 16;
+		config.reg_stride = 2;
+	} else {
+		config.reg_bits = 32;
+		config.val_bits = 32;
+		config.reg_stride = 4;
+	}
+
+	if (pxpcs->reg_indir)
+		config.max_register = 0xff * pxpcs->reg_width;
+	else
+		config.max_register = 0x1fffff * pxpcs->reg_width;
+
+	config.reg_format_endian = REGMAP_ENDIAN_NATIVE;
+	config.val_format_endian = REGMAP_ENDIAN_NATIVE;
+
+	return devm_regmap_init_mmio(dev, reg_base, &config);
+}
+
 static int xpcs_plat_init_res(struct dw_xpcs_plat *pxpcs)
 {
 	struct platform_device *pdev = pxpcs->pdev;
 	struct device *dev = &pdev->dev;
+	bool have_reg_resource = false;
 	resource_size_t spc_size;
+	struct regmap *regmap;
 	struct resource *res;
 
 	if (!device_property_read_u32(dev, "reg-io-width", &pxpcs->reg_width)) {
@@ -246,8 +282,14 @@ static int xpcs_plat_init_res(struct dw_xpcs_plat *pxpcs)
 		pxpcs->reg_width = 2;
 	}
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "direct") ?:
-	      platform_get_resource_byname(pdev, IORESOURCE_MEM, "indirect");
+	res = platform_get_resource_byname(pdev, IORESOURCE_REG, "direct") ?:
+	      platform_get_resource_byname(pdev, IORESOURCE_REG, "indirect");
+	if (res) {
+		have_reg_resource = true;
+	} else {
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "direct") ?:
+		      platform_get_resource_byname(pdev, IORESOURCE_MEM, "indirect");
+	}
 	if (!res) {
 		dev_err(dev, "No reg-space found\n");
 		return -EINVAL;
@@ -266,10 +308,16 @@ static int xpcs_plat_init_res(struct dw_xpcs_plat *pxpcs)
 		return -EINVAL;
 	}
 
-	pxpcs->reg_base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(pxpcs->reg_base)) {
-		dev_err(dev, "Failed to map reg-space\n");
-		return PTR_ERR(pxpcs->reg_base);
+	if (have_reg_resource) {
+		regmap = dev_get_regmap(dev->parent, NULL);
+		pxpcs->base = res->start;
+	} else {
+		regmap = xpcs_plat_create_regmap(pxpcs, res);
+	}
+	pxpcs->regmap = regmap;
+	if (!pxpcs->regmap) {
+		dev_err(dev, "No regmap available\n");
+		return -ENODEV;
 	}
 
 	return 0;
-- 
2.34.1


