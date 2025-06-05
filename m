Return-Path: <netdev+bounces-195186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 619C6ACEC65
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 10:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D25A91898E9B
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 08:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5481FDE39;
	Thu,  5 Jun 2025 08:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jJuMMgpC"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011045.outbound.protection.outlook.com [52.101.70.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A829D72632;
	Thu,  5 Jun 2025 08:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749113777; cv=fail; b=NLsDh1f8IKoSX4wTGqIu9nBTH51oQ+F4pUiwsiAFWd8Jfqxgxg7JITNCQ+pv+1enMvrcLqs+jDpwdho+FKXnUHbzzFDiXHbd4aZju78e2Y31l8ZZeMGHqvrbSWQmXi7fAbN7buH7Uy5paoyxVrrugn7T1daR0j9oAnHvpuXAu8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749113777; c=relaxed/simple;
	bh=wpFc0Jj623OwFj4A0fO5OGz/m+jRLjcnxj7Y1dirxHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OkxvDxKBaMXvRb0MwNFFfeq05Nfx3P8IPMH+n0t4eDMg+xkK8u7Rcia/f/Nbk9V/F6QP7MEk/NRJzWjFIPB5LXBG8XsSZ1S5NJ/Rgif3qtHgd/jDkx368lc7q9iURadPxHJupWsn9c/SqkeDldmdonmbC+lbcFUM1LPcMV1KD14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jJuMMgpC; arc=fail smtp.client-ip=52.101.70.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r9w4O2y5ZsAjqC3gDx8pmZ+tg9rLvx3PRTlKcWL9UhqE9MBqzgv4+tPR2p5x9+SUyjGUYY77d7aq0aTKUOSQ69tIr2/uSDsePq2t6HJH1dvAr+n/cGNmUYQXIJEqsG0MI/lUn9Fx/jv0Vg6jzIK4qsshyWMJkTOKVMzciiShkQnpytmnz+j9COVQOK8oF3opJQ3TB1ybKS161xGn3AqSOjYhxp7fO/OX2IX5ZQbVT2JXjfQZsq87sRrqPS+8EN4A2qT3qpjBxs2dNF0elaII+Y46SPptDjXO0rlD+Nw6GCyuH7FlOJAM/15nUFNkfxkNIRdbdT1sJzy5lTTJQUyqfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZjwSsqEV/otGAAelFU0tNt0DqGJZFbtmmUzMrth4ps=;
 b=w3y0a8cBTvw8NWD3e3hy3pY9GAwFKB0+R3EhEHXEUhzZDdClbPn7ZwRw0IprtR9VHorZhgIMSYJCz2l5II/GqsfYeO9dVp9gHngeo0Ux6bruZBwMhb4rFoMua6xnvMzPgKBamvgYLMWrIRgbc6UnejFyjf09fTTI6rAGw4QR3KO9wODjx6Dgtdsd/SQ9W8hAUYEN1Jqqv5gg4hoY7NKRlnwFRlcrC+6bEV+QZ29dWwFZvgZM6YeLTM/KQ3WjD2pAqyXjaxFtXJmxmnPHtlYllx3NDN2OfUpr4h5NllrP2oR6g0xt7k+2dcSCu0CEc3nsDbe2xzIkUP6nnFUdGIzpAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZjwSsqEV/otGAAelFU0tNt0DqGJZFbtmmUzMrth4ps=;
 b=jJuMMgpCCjE4aknXXuaDUeMebSglSl55CF8y0tvai6g3xZWCx68pIMUsyyhZKmSVjCSRBzVMRM1k8F0ZOJqzsujD1xiINEqoI/iWs2+wWZYzoMwpBCpdN7exH8bhFQBRkz6ALh5zHCVL3e6qpQHCMczxqsgiH7g9HyMcBOERkVaWlYe0m7SIoptE5J7kyrljUBxsfzQS33o1bzyDhE1C6IyqrhKHhLnlAUyTrsZlQx9Ro52YH9JyT4GajY6WAuCwAEy7gVoq4gWwsaPgj+TTV6mk0Ou/S0QCQG0R/Y84BWC7cTnCEzwgPhnaaUbJtdYdvZgnFjPhum1Wx5rNyI07kQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI0PR04MB10342.eurprd04.prod.outlook.com (2603:10a6:800:219::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Thu, 5 Jun
 2025 08:56:11 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8813.018; Thu, 5 Jun 2025
 08:56:11 +0000
Date: Thu, 5 Jun 2025 11:56:08 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, arnd@kernel.org
Subject: Re: [PATCH v2] net: enetc: fix the netc-lib driver build dependency
Message-ID: <20250605085608.dyfp6zy37c6i3qnp@skbuf>
References: <20250605060836.4087745-1-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605060836.4087745-1-wei.fang@nxp.com>
X-ClientProxiedBy: VI1PR09CA0147.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::31) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI0PR04MB10342:EE_
X-MS-Office365-Filtering-Correlation-Id: a43fb57c-67d7-4626-dc64-08dda40ed1b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BkTessAoIHiff/Os73aPfiWg6gVFg14irRHoVwnD8YngRs7m0Rzab1Fhy4I4?=
 =?us-ascii?Q?Sdl38rssW2NmmXuqubOCXH4EqaRVrfk+a2H9Ves6d6/uoOLF3kG29tkOKNtj?=
 =?us-ascii?Q?phfACJIvjSNekeMgg0qZUhOHROOiLPiaTWebIY9jW6bGfq3UAnw9Gof6RmSi?=
 =?us-ascii?Q?LZ/tZqE8P2sJzrCYqMZ+IMz8yr93gU5dcQaB+qFaJ5Q7NWL6uk/hvFvE8LUw?=
 =?us-ascii?Q?PmZBIC3jrwkpOdPGYiGz92IFnnug5FHzhujWdYEBxcr4NZqLLLaQj+4+pJDO?=
 =?us-ascii?Q?cO/O8HOgDrUhI1H3arlfDGn6rOOt1+WhhxQKTZSqyED1MIHVoEe4ASmJc+Is?=
 =?us-ascii?Q?z/T6Y/UGWR7EsHFekwlVHiDiBckDMnyMIPmtFVo6p8sw2mUs71ikrC6MMqZn?=
 =?us-ascii?Q?mvNAE4fbchInQ+1LREMTuJLxDHAZDdRm1m10LQGk/QyxqhP12JI773RLsHq+?=
 =?us-ascii?Q?4ZDM6sUHsvF3QHmk+NFvJk1ULCjPYP0y6DKcy5MzpD2qVzAFWxj6nOXFgDID?=
 =?us-ascii?Q?JdvjKUEQXtlFZny2BZxFK07dAlLm+xCHSxbt7xIrNgMqUtx8fZ0EbzoAD7a0?=
 =?us-ascii?Q?GS4p1jVFpvHjMkUoPMBrQJ/NqxQExx5ad3JeBQo7oiGx5b9xrlJDWvCt1O7O?=
 =?us-ascii?Q?eRd8Mq+Yl/PWu3x8CD0UwzPAvQF5Yf8EA8IsVg3QNvla4Y5z3Jozrl/JkM9y?=
 =?us-ascii?Q?8IK999x9i2AHoaBt7XrWWmVv5+Prp1/pyUrD1OUPQgc/ct9elhf4nUkyuxkb?=
 =?us-ascii?Q?Ouhv6OPmS6eSwFkIJLt9UIKyMix+95Dcy8cSgWXMPwhfaNABrBQr/rsq2Vuy?=
 =?us-ascii?Q?6aXIkjb1W8wlLZXRn3vfZqfUbYd1ww/Y20Li8j+SdAxiOUw1+OZBQq4RJcw8?=
 =?us-ascii?Q?uHT243h++WkK23tG96aCPXtFbPL52yIitMR1B+Y7/YBAKHYfZe77yBXu/wFJ?=
 =?us-ascii?Q?Zgj/DuOQmo6eKP9vJ4T2sgU05xQzdC8muM9W3AWH3LtZDEzFwm16MBqvGrel?=
 =?us-ascii?Q?/rtBaue02wVBDBJ5yAPtrvMmv8BiDYh9F4t8P7/pODnfMjiyDWtHkvOOBnKr?=
 =?us-ascii?Q?3HrXAY+20hBtgdWoagz7ba/Wwj1Q5Q8DXLHFB6nUUJmnhmuKvB1L8Z5I8YFE?=
 =?us-ascii?Q?LVJf+ur1YieGBHNRKqxK+pxw93jx1HWau+P3COo21hWbWinU5LRKB0acEbiZ?=
 =?us-ascii?Q?xd13z8goMyO8m19TwrQXbLql0FWovnr1804FSqM5oo9XveIEI9+FsQmq1hMv?=
 =?us-ascii?Q?pzz3MMz6LCF/qVzkI7I/hkMYg2KGW6DPmGcs1x9JvtiXY7/pRlTbAcVpyskh?=
 =?us-ascii?Q?r25m4JbMsrXa3TQ+QWX9Z3843TvGocH5uWfTYkh2G8Orn6HmHcA9ZGbfPwOC?=
 =?us-ascii?Q?zwUGVqwXK/O+p78JS9+sYUfmMhcwcof8Z04rSEYvP51QAanUv8cSzoN5zcT7?=
 =?us-ascii?Q?QQQhshZsCYujgDqILiEapQYGe8J/HO++?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6jWJdMlnkF0o1GCa5GsJAkTw4Ktcm+Gx3wHu3suyaUcUgVGLYTIXVeyEhXXG?=
 =?us-ascii?Q?I01LADznWRj4EMy8GeH5NaZblo+RoVdpgS0ELG8s1HhOXAeEGm6IGlUbpGPt?=
 =?us-ascii?Q?fXR6TrfVpyfbRKz++9pLVmoP7dt34YRIk2ZI6df3C2e1lw8OLe+N0HKrq0lg?=
 =?us-ascii?Q?r5qeZGJZH5zKj66g5aa1js55kJMWAdNLJnfqoOCeI2yq2MUpx7V+74ahsOCA?=
 =?us-ascii?Q?NuZPFw9WCHhfcIFJ7nPvvlvXSoAdLimfLOkYf5uTcA0ioBeOJrgca+2tdN7y?=
 =?us-ascii?Q?7K7exYZ10+gmP0FhhhoFKBrS/0FWFG0iN2QlxzzQUplAqBdUwMqjtxAEf1BK?=
 =?us-ascii?Q?KOGg1paWuhJxGn0sba7KjcRP1qh8Gt2telBkzzitfENCM9nWR03bD+pvXs2p?=
 =?us-ascii?Q?MMgHOE/BGnUq3R0cyybUuaaHhjSWdu/HLsdP9zzeQ+GtJJ0+CuduCtWBHBpZ?=
 =?us-ascii?Q?+SzBz01DV+xpCIUrcBQJhkfkyMqBv4u702mvOBCQ5Dv/LhWAISkE7l7cBZbe?=
 =?us-ascii?Q?LDy/kxNiK3rRA6tljrAHMHl5qWmHZnCxtCrzQ4z1rWSi7Qv28aXSr5vjwNFx?=
 =?us-ascii?Q?MvktLIX4mIADVbKlf6gLYSdZtBNZ1CeRD+gPC44ktwR4cqAkNNp8t/k9y9Qi?=
 =?us-ascii?Q?PQs2YmPV5AhkypeOnsSF52IG7sg37gAOMZHblf2cfPFDBZoaZSTanKRyZxYv?=
 =?us-ascii?Q?BOL+GFE8otKHA2xsCNFKu1mTLAovDvR8LkMvVSpwEy1/gjNZ5PHlbREJ7+3W?=
 =?us-ascii?Q?HvmQ6o91EtU2JzTIGGHfm3Jca6/Pw8AadpEAxSgYuVDyuStMhSiteMBgvO8t?=
 =?us-ascii?Q?hG9HUQyx+kvVnrOpMXqG7o0HzHt14V6ExX1PXeC0IUH9nst/26ZvCGsnv0To?=
 =?us-ascii?Q?v5KGbufY4/oWzV3QldYzEXvZOLaoVQ/ykcED/If6W/ozl+ZCzsroo1BSeMEA?=
 =?us-ascii?Q?P/YmgRwHxw34YiJfRAkf5SE1h+ZhMsplnNF+Pp0jdGtjYBgRiMp6EznUU5a+?=
 =?us-ascii?Q?sghb9OolSyMfNtCpEeiIUaDWls0GReBFFz+G4YNq2dbmv07uTyXE2cXYbNQu?=
 =?us-ascii?Q?RWqb81hrirAIEqwHMAfUnW0990OCqb7QvQyit8i+gf6weB1s+bAmuNIYv+Yf?=
 =?us-ascii?Q?LJyazksRZvBHib63HdeHQww2XDR7RUaLnnXxd2rnjVRl8U59tOdJGrXyanpn?=
 =?us-ascii?Q?gdW6+DJFk/ThFlDUNw4OgjhGsUx8gvKEmSUV/uDa6vLzvc5HSuSxz0cYxlhC?=
 =?us-ascii?Q?6ATzMaV9e4QvXBKVcPh4q//eff6j4SAGGE2TeLS5vfKMMbYJpLUXTcIItF+e?=
 =?us-ascii?Q?ZFMhhAE+/oCXHrZlWlgXUpZvuFpkz4DeRoxk893iEoZoJ2+iInOYC0SirXjR?=
 =?us-ascii?Q?a0FW0MkHjZz49RgC6HrhYePyKBBKg7T6jcPs03VS0/BXxTZHJO/zoi7YHGDk?=
 =?us-ascii?Q?JoTJdFG8wMwMVHqkA0RL4EHQsqQXRgZFWqvrpKyQfF40V7vH5nGh7fQq1F+9?=
 =?us-ascii?Q?1ttddjQu9JU1lHvccnqv1TgBOF3WizSiY4NoWhdMy/uI6tEByewzneoxvW4C?=
 =?us-ascii?Q?FpLCKIx7shZf+lVkiT4pXzUgxzTcWqQMNvLiZ3cqlaqc5GCD5v0KNXGhAMwL?=
 =?us-ascii?Q?SQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a43fb57c-67d7-4626-dc64-08dda40ed1b4
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 08:56:11.3144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8NwnvGhTPxuYPrlb7QM1HWgvyqZK+MP7jcyaFPV1gXMQKsJTPn6uavsw5CPp1Xr0FX9ndPoqUosg43STVmyxUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10342

Hi Wei,

On Thu, Jun 05, 2025 at 02:08:36PM +0800, Wei Fang wrote:
> The kernel robot reported the following errors when the netc-lib driver
> was compiled as a loadable module and the enetc-core driver was built-in.
> 
> ld.lld: error: undefined symbol: ntmp_init_cbdr
> referenced by enetc_cbdr.c:88 (drivers/net/ethernet/freescale/enetc/enetc_cbdr.c:88)
> ld.lld: error: undefined symbol: ntmp_free_cbdr
> referenced by enetc_cbdr.c:96 (drivers/net/ethernet/freescale/enetc/enetc_cbdr.c:96)
> 
> Simply changing "tristate" to "bool" can fix this issue, but considering
> that the netc-lib driver needs to support being compiled as a loadable
> module and LS1028 does not need the netc-lib driver. Therefore, we add a
> boolean symbol 'NXP_NTMP' to enable 'NXP_NETC_LIB' as needed. And when
> adding NETC switch driver support in the future, there is no need to
> modify the dependency, just select "NXP_NTMP" and "NXP_NETC_LIB" at the
> same time.
> 
> Reported-by: Arnd Bergmann <arnd@kernel.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202505220734.x6TF6oHR-lkp@intel.com/
> Fixes: 4701073c3deb ("net: enetc: add initial netc-lib driver to support NTMP")
> Suggested-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
> v1 Link: https://lore.kernel.org/imx/20250603105056.4052084-1-wei.fang@nxp.com/
> v2:
> 1. Add the boolean symbol 'NXP_NTMP' as Arnd suggested and modify
> the commit message.
> ---
>  drivers/net/ethernet/freescale/enetc/Kconfig | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/Kconfig b/drivers/net/ethernet/freescale/enetc/Kconfig
> index e917132d3714..54b0f0a5a6bb 100644
> --- a/drivers/net/ethernet/freescale/enetc/Kconfig
> +++ b/drivers/net/ethernet/freescale/enetc/Kconfig
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  config FSL_ENETC_CORE
>  	tristate
> +	select NXP_NETC_LIB if NXP_NTMP
>  	help
>  	  This module supports common functionality between the PF and VF
>  	  drivers for the NXP ENETC controller.
> @@ -22,6 +23,9 @@ config NXP_NETC_LIB
>  	  Switch, such as NETC Table Management Protocol (NTMP) 2.0, common tc
>  	  flower and debugfs interfaces and so on.
>  
> +config NXP_NTMP
> +	bool
> +
>  config FSL_ENETC
>  	tristate "ENETC PF driver"
>  	depends on PCI_MSI
> @@ -45,7 +49,7 @@ config NXP_ENETC4
>  	select FSL_ENETC_CORE
>  	select FSL_ENETC_MDIO
>  	select NXP_ENETC_PF_COMMON
> -	select NXP_NETC_LIB
> +	select NXP_NTMP
>  	select PHYLINK
>  	select DIMLIB
>  	help
> -- 
> 2.34.1
>

I think you slightly misunderstood Arnd's suggestion. NXP_NTMP was named
"NXP_NETC_NTMP" in his proposal, and it meant "does FSL_ENETC_CORE need
the functionality from NXP_NETC_LIB?".

The switch driver shouldn't need to select NXP_NTMP. Just NXP_NETC_LIB.

I don't agree with removing "NETC" from NXP_NETC_NTMP, I think it helps
clarify that the option pertains just to the NETC drivers.

