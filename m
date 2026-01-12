Return-Path: <netdev+bounces-249121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9E6D14911
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 18:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7C3BF3051F5A
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 17:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1646C3090D4;
	Mon, 12 Jan 2026 17:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kSb1PzHA"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011004.outbound.protection.outlook.com [52.101.65.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79791B7F4;
	Mon, 12 Jan 2026 17:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768240239; cv=fail; b=rH94q4z5h7WR+AZzSjcGbSBLVaUElQGqsqm5pKTu58swC9hDHPPb71+7OkOKSfoLoj1albJNW4ZfJzHRvO41id7k20QfGi47y7GIw6ag+BVfzXniKiIPfuRD0GIs/f/NKM8P0OzYJGC73/e160zbwhHg1EZQ7hMUhb4k8me7bhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768240239; c=relaxed/simple;
	bh=ee3h1oJ6TYb20YWZVu6VEXH9698DYhlZ7AwVTj6pfCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L9KfrZZkM/tsQmcYKRqORhjzqcmOqESo86zCWLie9h/oBPqS2d4bDlC7qZ6F1Hcun9d226IwIgnLvzBiRx06gFOIp64/lG/diFlenOeQTINlviOS+BMrFEa0lGqsobVRQtwXM+DuZXJJLAIGHpXiFi893PUXVyQeatFV1RhU+Ro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kSb1PzHA; arc=fail smtp.client-ip=52.101.65.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fsodxPB3KTWgQ85vJszSthKr4TjSb9oklEPCZPEyNOkAzD/rJ3WEM5FK4S7ojv2iOiR6E5hHiYxkjifJnjImdyKFo2W/gzMci1j390UUPQe8ZAWhDfwLD7g018gnJHfLy9rv95kwmGc9xFxPNBSuZf0sMr68WnGoau5rij5sx34MF6i13HePmp8kFBp0rEwPNTku2+LY2gyQb1I7yHnC8pTErHppOLaf0/URAoYvQ6pN+twgfS4ZO7yuYCoLyjlpw/Gf/tiiRoi6EVMJAIqo/CYI35B/IrXWPAtrnMY15kNejoiE0tUVdm+l0qu5cWzqZPpnnDjkr9erz3+QqqIgCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GqMAH0VJ10/6L94pt5z0PgOushNA1f9oRMCagK1ctv4=;
 b=WWOSdolFypeqDJP8WKPCEjyS1Php59kXEC8XRnpWzfedXXN4j0Pwgtmp6EYVj67BS8ECBdREv0t2El678drzqecEOKwyW14HqppqfoUnNiAXvsYSD6LJTk2Eyi90GCa1sBwg0jpVTlQ4Z4o7kpVUSOfmXcNMZTSz78FI+YlYE0A/tfWOIelESWabMhjTDnUAiVL1bbY1zYnz2G92bm3TiuNNcp7uyH6RdC4y4ZV6Yfa3tcQ5GcSSQtBsm9Xj6dYW1KAJueYRZJRynel56Vv5UDK9D9HBTeIwefJhGW+6gMK82hN1YQz/HjguiLcKzmgXuI6qocITuA/xGS255mCz8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqMAH0VJ10/6L94pt5z0PgOushNA1f9oRMCagK1ctv4=;
 b=kSb1PzHAV90hreNKmZK+scM+ANkFBCzo3Lwt2gJb4+bD3yaszTBc1mCbztwRVi9A8ZpzAF6hjatK1kbjBeJxh9dzBAu3OyMJEz/ol7QjmfscZk459w0AP8S/G62r1Iwm+x6wjiwFtfr7vOhrMK9F7r1mqsCNZBZXsBPTbR7lR6Ag4BblFpvyftCrHLiFpuR+ViU8c5QqRFymCDB7tv/bZxlH/zpBQX1lBD7905RY1R0FJfcJ0Wds7oviptDviuWKFpigYl715hjbYy3wCbK7KgJ75+B/O/xmcPaX1pEXEj8EM0FSkI0ic/wvTcKXQH5o93ovTb7+gnRBBj9Uvt2iRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AM9PR04MB8100.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Mon, 12 Jan
 2026 17:50:32 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 17:50:32 +0000
Date: Mon, 12 Jan 2026 19:50:29 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Meghana Malladi <m-malladi@ti.com>
Cc: vadim.fedorenko@linux.dev, horms@kernel.org, jacob.e.keller@intel.com,
	afd@ti.com, pmohan@couthit.com, basharath@couthit.com,
	rogerq@kernel.org, danishanwar@ti.com, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	andrew+netdev@lunn.ch, linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH net-next 1/2] net: ti: icssg-prueth: Add Frame Preemption
 MAC Merge support
Message-ID: <20260112175029.hgjpxwmysjg5ypne@skbuf>
References: <20260107125111.2372254-1-m-malladi@ti.com>
 <20260107125111.2372254-2-m-malladi@ti.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107125111.2372254-2-m-malladi@ti.com>
X-ClientProxiedBy: VI1PR08CA0246.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::19) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AM9PR04MB8100:EE_
X-MS-Office365-Filtering-Correlation-Id: b15e27e9-4401-410e-531d-08de520314f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|19092799006|1800799024|10070799003|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?49i6USpnvg3/0sc4+0O2CGWqd9wreYg+D1zEs+XkJ7k1P1ttxlyCtJ/pLA+w?=
 =?us-ascii?Q?0rVrooOzdK1EJT5XHygPSem030pHlwaloitj7b9zpwfnP5diXL2JVPCynxH1?=
 =?us-ascii?Q?CZ9oI8TPSlBjfEfBKFhUblmO/m3r6K+35xM8rQG7T2VAZrgXkhTZzW0cK14f?=
 =?us-ascii?Q?bzeCMd62MGcVT3hIbfln/0z4wDjwFnDkoIJ+P35dyre5XzYJ6vZl1WhNhbte?=
 =?us-ascii?Q?c4tWOUN2Cu9SXkR++lGzyoPMotB/YYxyvpVf0y2V7DeXgQDsweVB84QPnj1s?=
 =?us-ascii?Q?AOMn+5OLc2m1dBaOafdTlr5DPn36jMNBbrr+dSbucSsup7eyYJ7x4vcAmoMD?=
 =?us-ascii?Q?FcWHxf6pxljFb1bFOdr+PZ7O9lmSDZgdaPUkdyiVX216Ax+wKziXM2JGrvCb?=
 =?us-ascii?Q?v0H5JPB8a9uu3OccYl3ArKSaid7YOnBeFoaZpTXhXmz154b2hrD5eIZSTZXH?=
 =?us-ascii?Q?FZyQH2K1RMFV841gaBI1Bz5HPPjS2+gO5uhnV3ew/wt7xEiZCfr9U0RbYqew?=
 =?us-ascii?Q?qtu9A4FLuwuFXK5bZxP0+ftuS4/kWNm8OygN+TYjod9NdIEI2jKf72qw1DTe?=
 =?us-ascii?Q?d7btxyysMB2jujD9gpdmFdd4W+F7EeekC4JIB2641CrmImlXHKm+m6oPGsv0?=
 =?us-ascii?Q?cXuKqyqllkddPGd6x+ooc8PFKlGkJVX7Mn4P+Wm5FLvywT1gu/WdgOHuIMkG?=
 =?us-ascii?Q?DWM44OJxAE88CRDnYl5PUPMLf2+2Q10cUUI6/b2GB4/L5sBX9wdLo9yI5WMh?=
 =?us-ascii?Q?chUz74PS1zrgsh4XvDVhwRvVUTjONUBbPetz9iA92UkIkRdZqtreo5vllPt4?=
 =?us-ascii?Q?rUhsq8p4QbVxJ3K/L0uYOhPCaPKo96Emp3nOFrieZPHB8vB+Gj+dYTtZhndv?=
 =?us-ascii?Q?ribSnjCJ04dBjQE5kAs+YLdMKO/fJEZq+2CtchqR5Cb+ucMPuuHAoXhMaKCb?=
 =?us-ascii?Q?kFNKk2/afKZF7KtDrw0iGmRNMQPs/b/fjDI5ALkHlDp6AR+rJ7K0Qrlq2nNi?=
 =?us-ascii?Q?UOulxC88hkU6TRUXMTM/YmJ7z6hoSt/vh18NU54/1iAAp9cU6ZREJQ84hx2r?=
 =?us-ascii?Q?MScXG+cssMAoRqb0ojOwrVkh0L1dghxJaTEaN/kwKGg4fMWrm0COD5h0/qL/?=
 =?us-ascii?Q?bQI/o46xata0TTuTsMwANBDuGMaMgMQJrLE1UnON1YcJlmDpiFZnhda/t4c4?=
 =?us-ascii?Q?Q8UDiNHVCBYrJXd9bYxvvqFV4cTpWMD0zNhPnr5IinEW8PnvQT6t0XOZ0BNq?=
 =?us-ascii?Q?VN3UWmU1mYvHyu15mhhai5GYU8WApkfl61ryZNJ+F8SHmCBJ+486eOsTdZta?=
 =?us-ascii?Q?vP/VhqkE6QpC2Pa+5SjxfRgomVlZC9k7Y2DL7CmK2R8gzGC7Bs23h/Z4E7BK?=
 =?us-ascii?Q?qnXi88maSYjBGAByhC41eTSZcg4xtap9o/BtC7mOuWaondqpajqBLq5PS0Zd?=
 =?us-ascii?Q?V+vF4/ENVVW9PN5nCRxswr+acKOqubKM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(19092799006)(1800799024)(10070799003)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vmpIA7cwQAQVV25/R9V5UNfpc1UEaEv3NBCgaV75JGLS7yw+pjgHINsjnT5Z?=
 =?us-ascii?Q?qzS2hjsEyvyF4AeZ8sPkN804PyeyNNmlvFSrW6Yk3sNUVSkkx72n65CAi9VZ?=
 =?us-ascii?Q?FllWsNaT8Ouu7Pg1LG1DBAt4gNrRnspJbDMKk/CCRiLsit5dDJl5Wy9bQU+q?=
 =?us-ascii?Q?Hj5PmowU5faLLBuWQgpSfGYrHIIqdxx7TKYD8orIuxx42EOkJjwzwbjfp8iX?=
 =?us-ascii?Q?0LGeja7UCQ2rb5j95MQtuub13MeBHT1Lfff0/0QqFklDrQYiQJmTexYB0+U5?=
 =?us-ascii?Q?JlN3qpMtr7q4XB77F84zvXVt1wwKges3MJtF1H7ACpyUektVNOAh4yQ2ZgL4?=
 =?us-ascii?Q?DCHG2M07H9NxatUmyrIFDB7AaDOwb+zNrEUyyxgihhOTkx05nJhW5VLLhLFw?=
 =?us-ascii?Q?50Z9FuEqmgclexcf8lV9yzAWpSbkCMNq83Om+vD82IccXHZMvu+ELFGGVpnf?=
 =?us-ascii?Q?PsmFLxivsiZHQRPANSyKC8ugYxQcOUiqonTu1c7L6J+Whmhq5Eoz80bBhAHC?=
 =?us-ascii?Q?18s3mR2MLyTZFd4ovAR+5IoFtU9yqYru5/dsJ7I67tcL01/gwBEVbbswDo1Q?=
 =?us-ascii?Q?RPtHVx4oR743F4PJt3Ro2xpObubixLg0fKnTKLfQYSYoOD0OX7HUosFXDQqN?=
 =?us-ascii?Q?5wGJFo2YkGy05wbOsT5uXkl/F+QYyFdaaT179CKjw+rQhn/JbaiPrI4MuN0s?=
 =?us-ascii?Q?u4OpwHbuUJhvkovQq1JRhtZTNu16GrLEzB/3bIzyVoeVHrvtjx+E+RFgw5uq?=
 =?us-ascii?Q?SU70dxs2XCwLoujOgsF+xSu9TyusV5yGCJelEutMOX+fF0C3v1wgqELfiDZE?=
 =?us-ascii?Q?DEczSnmmfTetyZd43Riqr2nQxpbHnBvVVYH9tvsxqkK1m8NNfiXwU/scIvSB?=
 =?us-ascii?Q?VMkm0G6YOFsJuSxbuqfojqEJ4qbaamgisAZ1X0SZdzq0Gvm5Gl+N1NXVxJC7?=
 =?us-ascii?Q?kGRTyVUagTEzbFksv2+S2hjbaMKCRLlV2zwr/V526A0f1QVPdxFWCwt5VHeF?=
 =?us-ascii?Q?HEc7Hu0Eam4Qt9ycwBOoJFFr9DzdwdxFuRgJj9GOjv58wF1YmeRSovjKFhWE?=
 =?us-ascii?Q?ffYAKz3ZezWq+u5J9Y2YKfo7AzkMilbE5AcOm16Ym/x1dAFRUI3JS2hYUkE8?=
 =?us-ascii?Q?53vgsHRhds1kz7KIPO6iv6xsrb1yRLymkXxWIqg7z5QrTSiBmLQxHU1iImn3?=
 =?us-ascii?Q?/n63TWAnNXPDIpmwWa/MhMlfbEdRMmRsL7vJhkjAT3Kf5aC3HoCIEjS7irvZ?=
 =?us-ascii?Q?Cv0Y+4xHuqi7lzteyqdFSACLe94LbGjLjsuLC7HW1tt8TgU+r/f9e8a3n1XC?=
 =?us-ascii?Q?0vX9zrqIr83PFCxemDoyvapJRP/mgMCtW7MQ446TGRX74Y2UqU2CqoC0cWmn?=
 =?us-ascii?Q?pz9if1qxHHdNZCgbIEqZQ/KfGWgv8lWVHGMp2Y9E48f7muu+f+5Aso6YvYQ+?=
 =?us-ascii?Q?6ZtA94iDNdVUfZ0T8T68mJfuFuADq7HO0S8o/ixWoqHaDjHqUE5kc14m/a4v?=
 =?us-ascii?Q?42zgx+lkRUrpAsdPQ0veJqBYooauBmgydnXUD7R8FlMDhdKUiddSQK2XTcmh?=
 =?us-ascii?Q?JQB2bEDHl2jRpkMKY5/XCdndJLpGGKnqEaICz6IEULOQAAxChRo9EqE3FD5A?=
 =?us-ascii?Q?+YNm8CPdUw1UP6XG3Odv/ydjHK1X6eWJzRkHwMilleFiV4M3r6DwaCAEE4g7?=
 =?us-ascii?Q?OmEUXHbAk+tCko6V1db04M9o2mTVhpjfmEAG8BAJhDpKPa6tzdD64nwu67Uq?=
 =?us-ascii?Q?wz9Cg4g/Z7occQFgiDSEAfB1xFprDsQfnbyOowcBlG+WG/GSzm4VpvaQHk6i?=
X-MS-Exchange-AntiSpam-MessageData-1: F1rf8UoG8TOIjA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b15e27e9-4401-410e-531d-08de520314f5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 17:50:32.6002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ePk/Zqp3UUNSb9PEf+GQWFiCRkQrD2UNlysbEdhF3rzkOfvN0hZhUhyAN/LPaUnSw+utJesy7AIB1buGVnmCoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8100

Hi Meghana,

On Wed, Jan 07, 2026 at 06:21:10PM +0530, Meghana Malladi wrote:
> This patch adds utility functions to configure firmware to enable
> IET FPE. The highest priority queue is marked as Express queue and
> lower priority queues as pre-emptable, as the default configuration
> which will be overwritten by the mqprio tc mask passed by tc qdisc.
> Driver optionally allow configure the Verify state machine in the
> firmware to check remote peer capability. If remote fails to respond
> to Verify command, then FPE is disabled by firmware and TX FPE active

"If remote fails to respond to Verify command, then FPE is disabled by
firmware" -> please clarify that. There is also a question on the code
about this.

> status is disabled.
> 
> This also adds the necessary hooks to enable IET/FPE feature in ICSSG
> driver. IET/FPE gets configured when Link is up and gets disabled when link
> goes down or device is stopped.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> Signed-off-by: Meghana Malladi <m-malladi@ti.com>
> ---
>  drivers/net/ethernet/ti/Makefile             |   2 +-
>  drivers/net/ethernet/ti/icssg/icssg_prueth.c |   9 +
>  drivers/net/ethernet/ti/icssg/icssg_prueth.h |   2 +
>  drivers/net/ethernet/ti/icssg/icssg_qos.c    | 319 +++++++++++++++++++
>  drivers/net/ethernet/ti/icssg/icssg_qos.h    |  48 +++
>  5 files changed, 379 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.c
>  create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.h
> 
> diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
> index 93c0a4d0e33a..2f588663fdf0 100644
> --- a/drivers/net/ethernet/ti/Makefile
> +++ b/drivers/net/ethernet/ti/Makefile
> @@ -35,7 +35,7 @@ ti-am65-cpsw-nuss-$(CONFIG_TI_K3_AM65_CPSW_SWITCHDEV) += am65-cpsw-switchdev.o
>  obj-$(CONFIG_TI_K3_AM65_CPTS) += am65-cpts.o
>  
>  obj-$(CONFIG_TI_ICSSG_PRUETH) += icssg-prueth.o icssg.o
> -icssg-prueth-y := icssg/icssg_prueth.o icssg/icssg_switchdev.o
> +icssg-prueth-y := icssg/icssg_prueth.o icssg/icssg_switchdev.o icssg/icssg_qos.o
>  
>  obj-$(CONFIG_TI_ICSSG_PRUETH_SR1) += icssg-prueth-sr1.o icssg.o
>  icssg-prueth-sr1-y := icssg/icssg_prueth_sr1.o
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> index f65041662173..668177eba3f8 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> @@ -378,6 +378,12 @@ static void emac_adjust_link(struct net_device *ndev)
>  		} else {
>  			icssg_set_port_state(emac, ICSSG_EMAC_PORT_DISABLE);
>  		}
> +
> +		if (emac->link) {
> +			icssg_qos_link_up(ndev);
> +		} else {
> +			icssg_qos_link_down(ndev);
> +		}
>  	}
>  
>  	if (emac->link) {
> @@ -967,6 +973,8 @@ static int emac_ndo_open(struct net_device *ndev)
>  	if (ret)
>  		goto destroy_rxq;
>  
> +	icssg_qos_init(ndev);
> +
>  	/* start PHY */
>  	phy_start(ndev->phydev);
>  
> @@ -1421,6 +1429,7 @@ static const struct net_device_ops emac_netdev_ops = {
>  	.ndo_hwtstamp_get = icssg_ndo_get_ts_config,
>  	.ndo_hwtstamp_set = icssg_ndo_set_ts_config,
>  	.ndo_xsk_wakeup = prueth_xsk_wakeup,
> +	.ndo_setup_tc = icssg_qos_ndo_setup_tc,
>  };
>  
>  static int prueth_netdev_init(struct prueth *prueth,
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> index 10eadd356650..7a586038adf8 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> @@ -44,6 +44,7 @@
>  #include "icssg_config.h"
>  #include "icss_iep.h"
>  #include "icssg_switch_map.h"
> +#include "icssg_qos.h"
>  
>  #define PRUETH_MAX_MTU          (2000 - ETH_HLEN - ETH_FCS_LEN)
>  #define PRUETH_MIN_PKT_SIZE     (VLAN_ETH_ZLEN)
> @@ -255,6 +256,7 @@ struct prueth_emac {
>  	struct bpf_prog *xdp_prog;
>  	struct xdp_attachment_info xdpi;
>  	int xsk_qid;
> +	struct prueth_qos qos;
>  };
>  
>  /* The buf includes headroom compatible with both skb and xdpf */
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_qos.c b/drivers/net/ethernet/ti/icssg/icssg_qos.c
> new file mode 100644
> index 000000000000..858268740dae
> --- /dev/null
> +++ b/drivers/net/ethernet/ti/icssg/icssg_qos.c
> @@ -0,0 +1,319 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Texas Instruments ICSSG PRUETH QoS submodule
> + * Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com/
> + */
> +
> +#include "icssg_prueth.h"
> +#include "icssg_switch_map.h"
> +
> +static int icssg_prueth_iet_fpe_enable(struct prueth_emac *emac);
> +static void icssg_prueth_iet_fpe_disable(struct prueth_qos_iet *iet);
> +static void icssg_qos_enable_ietfpe(struct work_struct *work);

Please order functions such as to avoid forward declarations.

> +
> +void icssg_qos_init(struct net_device *ndev)
> +{
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +	struct prueth_qos_iet *iet = &emac->qos.iet;
> +
> +	if (!iet->fpe_configured)
> +		return;

Bug:

if you open (ip link set ... up) the interface first, emac_ndo_open() ->
icssg_qos_init() will run, and will find iet->fpe_configured false,
exiting early.

Then you run ethtool --set-mm ... tx-enabled on, which sets
iet->fpe_configured = true.

Then you insert a cable and icssg_qos_link_up() -> icssg_prueth_iet_fpe_enable()
runs, which calls schedule_work(&iet->fpe_config_task). But you've never
called INIT_WORK() on this structure, so the kernel will oops.

> +
> +	/* Init work queue for IET MAC verify process */
> +	iet->emac = emac;
> +	INIT_WORK(&iet->fpe_config_task, icssg_qos_enable_ietfpe);
> +	init_completion(&iet->fpe_config_compl);
> +
> +	/* As worker may be sleeping, check this flag to abort
> +	 * as soon as it comes of out of sleep and cancel the
> +	 * fpe config task.
> +	 */
> +	atomic_set(&iet->cancel_fpe_config, 0);
> +}
> +
> +static void icssg_iet_set_preempt_mask(struct prueth_emac *emac, u8 preemptible_tcs)
> +{
> +	void __iomem *config = emac->dram.va + ICSSG_CONFIG_OFFSET;
> +	struct prueth_qos_mqprio *p_mqprio = &emac->qos.mqprio;
> +	struct tc_mqprio_qopt *qopt = &p_mqprio->mqprio.qopt;
> +	u8 tc;
> +	int i;
> +
> +	/* Configure highest queue as express. Set Bit 4 for FPE,
> +	 * Reset for express
> +	 */

I wasn't able to parse the code below, I just got stuck on this comment.
Why configure just the highest queue as express, rather than all queues
as express?

What is the current default behaviour in mainline, and does this
constitute a change of that behaviour?

> +
> +	/* first set all 8 queues as Preemptive */
> +	for (i = 0; i < PRUETH_MAX_TX_QUEUES * PRUETH_NUM_MACS; i++)

What is the purpose of PRUETH_NUM_MACS here? Is the FPE configuration of
PRUETH_MAC0 not independent of that of PRUETH_MAC1?

> +		writeb(BIT(4), config + EXPRESS_PRE_EMPTIVE_Q_MAP + i);
> +
> +	/* set highest priority channel queue as express as default configuration */
> +	writeb(0, config + EXPRESS_PRE_EMPTIVE_Q_MAP + emac->tx_ch_num - 1);
> +
> +	/* set up queue mask for FPE. 1 means express */
> +	writeb(BIT(emac->tx_ch_num - 1), config + EXPRESS_PRE_EMPTIVE_Q_MASK);
> +
> +	/* Overwrite the express queue mapping based on the tc map set by the user */
> +	for (tc = 0; tc < p_mqprio->mqprio.qopt.num_tc; tc++) {
> +		/* check if the tc is express or not */
> +		if (!(p_mqprio->preemptible_tcs & BIT(tc))) {
> +			for (i = qopt->offset[tc]; i < qopt->offset[tc] + qopt->count[tc]; i++) {
> +				/* Set all the queues in this tc as express queues */
> +				writeb(0, config + EXPRESS_PRE_EMPTIVE_Q_MAP + i);
> +				writeb(BIT(i), config + EXPRESS_PRE_EMPTIVE_Q_MASK);
> +			}
> +		}
> +		netdev_set_tc_queue(emac->ndev, tc, qopt->count[tc], qopt->offset[tc]);
> +	}
> +}
> +
> +static int prueth_mqprio_validate(struct net_device *ndev,
> +				  struct tc_mqprio_qopt_offload *mqprio)
> +{
> +	int num_tc = mqprio->qopt.num_tc;
> +	int queue_count = 0;
> +	int i;
> +
> +	/* Always start tc-queue mapping from queue 0 */
> +	if (mqprio->qopt.offset[0] != 0)
> +		return -EINVAL;
> +
> +	/* Check for valid number of traffic classes */
> +	if (num_tc < 1 || num_tc > PRUETH_MAX_TX_QUEUES)
> +		return -EINVAL;
> +
> +	/* Only channel mode is supported */
> +	if (mqprio->mode != TC_MQPRIO_MODE_CHANNEL) {
> +		netdev_err(ndev, "Unsupported mode: %d\n", mqprio->mode);

struct tc_mqprio_qopt_offload has an extack argument. Please use
NL_SET_EXT_MSG_MOD(extack) instead of netdev_err() here and below.

> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < num_tc; i++) {
> +		if (!mqprio->qopt.count[i]) {
> +			netdev_err(ndev, "TC %d has zero size queue count: %d\n",
> +				   i, mqprio->qopt.count[i]);
> +			return -EINVAL;
> +		}

You set caps->validate_queue_counts = true, which is laudable. But did
you also look at what mqprio_validate_queue_counts() does? Do you need
to duplicate it here?

> +		if (mqprio->min_rate[i] || mqprio->max_rate[i]) {
> +			netdev_err(ndev, "Min/Max tx rate is not supported\n");
> +			return -EINVAL;
> +		}
> +		if (mqprio->qopt.offset[i] != queue_count) {
> +			netdev_err(ndev, "Discontinuous queues config is not supported\n");
> +			return -EINVAL;
> +		}
> +		queue_count += mqprio->qopt.count[i];
> +	}
> +
> +	if (queue_count > PRUETH_MAX_TX_QUEUES) {
> +		netdev_err(ndev, "Total queues %d exceed max %d\n",
> +			   queue_count, PRUETH_MAX_TX_QUEUES);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int emac_tc_query_caps(struct net_device *ndev, void *type_data)
> +{
> +	struct tc_query_caps_base *base = type_data;
> +
> +	switch (base->type) {
> +	case TC_SETUP_QDISC_MQPRIO: {
> +		struct tc_mqprio_caps *caps = base->caps;
> +
> +		caps->validate_queue_counts = true;
> +		return 0;
> +	}
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int emac_tc_setup_mqprio(struct net_device *ndev, void *type_data)
> +{
> +	struct tc_mqprio_qopt_offload *mqprio = type_data;
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +	struct prueth_qos_mqprio *p_mqprio;
> +	int ret;
> +
> +	if (mqprio->qopt.hw == TC_MQPRIO_HW_OFFLOAD_TCS)
> +		return -EOPNOTSUPP;
> +
> +	if (!mqprio->qopt.num_tc) {
> +		netdev_reset_tc(ndev);
> +		p_mqprio->preemptible_tcs = 0;
> +		return 0;
> +	}
> +
> +	ret = prueth_mqprio_validate(ndev, mqprio);
> +	if (ret)
> +		return ret;
> +
> +	p_mqprio = &emac->qos.mqprio;
> +	memcpy(&p_mqprio->mqprio, mqprio, sizeof(*mqprio));
> +	netdev_set_num_tc(ndev, mqprio->qopt.num_tc);
> +
> +	return 0;
> +}
> +
> +int icssg_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
> +			   void *type_data)
> +{
> +	switch (type) {
> +	case TC_QUERY_CAPS:
> +		return emac_tc_query_caps(ndev, type_data);
> +	case TC_SETUP_QDISC_MQPRIO:
> +		return emac_tc_setup_mqprio(ndev, type_data);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(icssg_qos_ndo_setup_tc);
> +
> +void icssg_qos_link_up(struct net_device *ndev)
> +{
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +	struct prueth_qos_iet *iet = &emac->qos.iet;
> +
> +	if (!iet->fpe_configured)
> +		return;
> +
> +	icssg_prueth_iet_fpe_enable(emac);
> +}
> +
> +void icssg_qos_link_down(struct net_device *ndev)
> +{
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +	struct prueth_qos_iet *iet = &emac->qos.iet;
> +
> +	if (iet->fpe_configured)
> +		icssg_prueth_iet_fpe_disable(iet);
> +}
> +
> +static int icssg_config_ietfpe(struct prueth_qos_iet *iet, bool enable)
> +{
> +	void __iomem *config = iet->emac->dram.va + ICSSG_CONFIG_OFFSET;
> +	struct prueth_qos_mqprio *p_mqprio =  &iet->emac->qos.mqprio;
> +	int ret;
> +	u8 val;
> +
> +	/* If FPE is to be enabled, first configure MAC Verify state
> +	 * machine in firmware as firmware kicks the Verify process
> +	 * as soon as ICSSG_EMAC_PORT_PREMPT_TX_ENABLE command is
> +	 * received.
> +	 */
> +	if (enable && iet->mac_verify_configured) {
> +		writeb(1, config + PRE_EMPTION_ENABLE_VERIFY);

When mac_verify_configured transitions from true to false, who disables
the feature in firmware? Or do you have to reboot the board?

> +		writew(iet->tx_min_frag_size, config + PRE_EMPTION_ADD_FRAG_SIZE_LOCAL);
> +		writel(iet->verify_time_ms, config + PRE_EMPTION_VERIFY_TIME);
> +	}
> +
> +	/* Send command to enable FPE Tx side. Rx is always enabled */
> +	ret = icssg_set_port_state(iet->emac,
> +				   enable ? ICSSG_EMAC_PORT_PREMPT_TX_ENABLE :
> +					    ICSSG_EMAC_PORT_PREMPT_TX_DISABLE);
> +	if (ret) {
> +		netdev_err(iet->emac->ndev, "TX preempt %s command failed\n",
> +			   str_enable_disable(enable));
> +		writeb(0, config + PRE_EMPTION_ENABLE_VERIFY);
> +		return ret;
> +	}
> +
> +	/* Update FPE Tx enable bit. Assume firmware use this bit
> +	 * and enable PRE_EMPTION_ACTIVE_TX if everything looks
> +	 * good at firmware
> +	 */
> +	writeb(enable ? 1 : 0, config + PRE_EMPTION_ENABLE_TX);
> +
> +	if (enable && iet->mac_verify_configured) {
> +		ret = readb_poll_timeout(config + PRE_EMPTION_VERIFY_STATUS, val,
> +					 (val == ICSSG_IETFPE_STATE_SUCCEEDED),
> +					 USEC_PER_MSEC, 5 * USEC_PER_SEC);
> +		if (ret) {
> +			netdev_err(iet->emac->ndev,
> +				   "timeout for MAC Verify: status %x\n",
> +				   val);
> +			return ret;
> +		}
> +	} else {
> +		/* Give f/w some time to update PRE_EMPTION_ACTIVE_TX state */
> +		usleep_range(100, 200);
> +	}
> +
> +	if (enable) {
> +		val = readb(config + PRE_EMPTION_ACTIVE_TX);
> +		if (val != 1) {
> +			netdev_err(iet->emac->ndev,
> +				   "F/w fails to activate IET/FPE\n");
> +			writeb(0, config + PRE_EMPTION_ENABLE_TX);

Why do you write 0 to PRE_EMPTION_ENABLE_TX here? You previously said
that "FPE is disabled by firmware" which I suppose translates into the
same (incorrect) thing? Is it disabled by firmware, or by the driver, or
by both?

When FPE is enabled with verification, but the link partner does not
respond, the ENABLED status remains, but the ACTIVE status never
transitions to true. It is documented that preemptible traffic should
only be sent based on the ACTIVE status, not the ENABLED one. So, I
don't think this is necessary at all.

> +			return -ENODEV;
> +		}
> +	} else {
> +		return 0;
> +	}
> +
> +	icssg_iet_set_preempt_mask(iet->emac, p_mqprio->preemptible_tcs);
> +
> +	iet->fpe_enabled = true;

iet->fpe_enabled is set to true here and never to false. It tracks no
useful information, other than "was icssg_config_ietfpe() ever called
for this interface with enable=true?". You assign that result to
state->tx_enabled in emac_get_mm(), which is obviously wrong because
this variable does not track that information.  For example, if you call
icssg_config_ietfpe() with enable=false, FPE should be enabled, and
emac_get_mm() should reflect that.

> +
> +	return ret;
> +}
> +
> +static void icssg_qos_enable_ietfpe(struct work_struct *work)
> +{
> +	struct prueth_qos_iet *iet =
> +		container_of(work, struct prueth_qos_iet, fpe_config_task);
> +	int ret;
> +
> +	/* Set the required flag and send a command to ICSSG firmware to
> +	 * enable FPE and start MAC verify
> +	 */
> +	ret = icssg_config_ietfpe(iet, true);
> +
> +	/* if verify configured, poll for the status and complete.
> +	 * Or just do completion
> +	 */
> +	if (!ret)
> +		netdev_err(iet->emac->ndev, "IET FPE configured successfully\n");
> +	else
> +		netdev_err(iet->emac->ndev, "IET FPE config error\n");
> +	complete(&iet->fpe_config_compl);
> +}
> +
> +static void icssg_prueth_iet_fpe_disable(struct prueth_qos_iet *iet)
> +{
> +	int ret;
> +
> +	atomic_set(&iet->cancel_fpe_config, 1);
> +	cancel_work_sync(&iet->fpe_config_task);
> +	ret = icssg_config_ietfpe(iet, false);
> +	if (!ret)
> +		netdev_err(iet->emac->ndev, "IET FPE disabled successfully\n");
> +	else
> +		netdev_err(iet->emac->ndev, "IET FPE disable failed\n");
> +}
> +
> +static int icssg_prueth_iet_fpe_enable(struct prueth_emac *emac)
> +{
> +	struct prueth_qos_iet *iet = &emac->qos.iet;
> +	int ret;
> +
> +	/* Schedule MAC Verify and enable IET FPE if configured */
> +	atomic_set(&iet->cancel_fpe_config, 0);
> +	reinit_completion(&iet->fpe_config_compl);
> +	schedule_work(&iet->fpe_config_task);
> +	/* By trial, found it takes about 1.5s. So
> +	 * wait for 10s
> +	 */
> +	ret = wait_for_completion_timeout(&iet->fpe_config_compl,
> +					  msecs_to_jiffies(10000));

Why schedule async work (&iet->fpe_config_task) then immediately wait
for it to finish? Isn't that an extremely roundabout way of just running
the contents of the task directly?

Also, I think you are blocking the system_power_efficient_wq (which
phy_queue_state_machine() -> .. -> emac_adjust_link() runs on) for up to
10 seconds at a time, and nothing else can run while you are waiting for
the FPE verification completion.

Why exactly do you need to wait for icssg_prueth_iet_fpe_enable() to
finish here?

> +	if (!ret) {
> +		netdev_err(emac->ndev,
> +			   "IET verify completion timeout\n");
> +		/* cancel verify in progress */
> +		atomic_set(&iet->cancel_fpe_config, 1);
> +		cancel_work_sync(&iet->fpe_config_task);
> +	}
> +
> +	return ret;
> +}
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_qos.h b/drivers/net/ethernet/ti/icssg/icssg_qos.h
> new file mode 100644
> index 000000000000..3d3f42107dd7
> --- /dev/null
> +++ b/drivers/net/ethernet/ti/icssg/icssg_qos.h
> @@ -0,0 +1,48 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com/
> + */
> +
> +#ifndef __NET_TI_ICSSG_QOS_H
> +#define __NET_TI_ICSSG_QOS_H
> +
> +#include <linux/atomic.h>
> +#include <linux/netdevice.h>
> +#include <net/pkt_sched.h>
> +
> +struct prueth_qos_mqprio {
> +	struct tc_mqprio_qopt_offload mqprio;
> +	u8 preemptible_tcs;
> +};
> +
> +struct prueth_qos_iet {
> +	struct work_struct fpe_config_task;
> +	struct completion fpe_config_compl;
> +	struct prueth_emac *emac;
> +	atomic_t cancel_fpe_config;

This variable has no reader.

> +	/* Set through priv flags to enable IET frame preemption */

These comments referencing priv flags might be obsolete. At least in the
mainline submission there is no netdev priv flag involved.

> +	bool fpe_configured;
> +	/* Set through priv flags to enable IET MAC Verify state machine
> +	 * in firmware
> +	 */
> +	bool mac_verify_configured;
> +	/* Min TX fragment size, set via ethtool */
> +	u32 tx_min_frag_size;
> +	/* wait time between verification attempts in ms (according to clause
> +	 * 30.14.1.6 aMACMergeVerifyTime), set via ethtool
> +	 */
> +	u32 verify_time_ms;
> +	/* Set if IET FPE is active */
> +	bool fpe_enabled;

"enabled" and "active" have quite distinct meanings if you read
Documentation/networking/ethtool-netlink.rst (ETHTOOL_A_MM_TX_ENABLED vs
ETHTOOL_A_MM_TX_ACTIVE) as well as the standard. The fact that this
comment explain that "fpe_enabled" tracks the "active" status makes
things clear as mud.

> +};
> +
> +struct prueth_qos {
> +	struct prueth_qos_iet iet;
> +	struct prueth_qos_mqprio mqprio;
> +};
> +
> +void icssg_qos_init(struct net_device *ndev);
> +void icssg_qos_link_up(struct net_device *ndev);
> +void icssg_qos_link_down(struct net_device *ndev);
> +int icssg_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
> +			   void *type_data);
> +#endif /* __NET_TI_ICSSG_QOS_H */
> -- 
> 2.43.0
>

