Return-Path: <netdev+bounces-245606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC8DCD3658
	for <lists+netdev@lfdr.de>; Sat, 20 Dec 2025 20:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 70991300161D
	for <lists+netdev@lfdr.de>; Sat, 20 Dec 2025 19:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC01230E839;
	Sat, 20 Dec 2025 19:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SJO89V4M"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011059.outbound.protection.outlook.com [40.107.130.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFA12367BA;
	Sat, 20 Dec 2025 19:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766260578; cv=fail; b=bv/WRyiFfLr+vErb/lETiktP1+6XFiZ0ztEQXdD0YNn8AY8xmkADHAFYmT8eHPD7VfRnUhikqoFQ3ip3VTWXF9hC2momieHvGtIkBBCFH9iUfJCVgKaa6z4PzRvKTT3KQ54qeHe9w2BUzIzxaW9nF4Oabz4Qe/CakAgp19Ylpsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766260578; c=relaxed/simple;
	bh=pMLxqxsQ5FfhF7uHXEzGkvwOtOETYNEPounVg9DCaJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GftVglnDaae7BhRdLfTf/Icyx2ZfBtN/hFFY0Sc3dhHzWuJytWDjwDS2XuJlaVP164O/HC4PbRh8f74KlCeI38tneUP72XUhtEayUrs98+9iU22xevNOdOkJh7x96uNu9XimriMLME0KPCVKv7+p3rZptJ2kvUKibIEQeEmgztc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SJO89V4M; arc=fail smtp.client-ip=40.107.130.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gtsFpmE6rOR9gNnUPl6ddOJQUnZBGqa15t9ffYFT2I/Nc9Q6o/XvCTJeFtMTMoJ7pAiX0zd//bsi92Hh8yiYOCx1dA4PCDHrdigJuEzaBexgUeed2/y8hhKZe65RunWZj9wc8yN4Kbrgb3sRHM6ogLpAA2qZnukDBBQi2iPze6NF5vk8vA/FyWJaj+pB0Q7aAkI8EOPJyOSV9wZRPJQah3vMfOsVVD4BNMy4i2DHN/YkCLHW8uIswohffmgIlhVsLRCmtGI2z+Zt8ALwPK1FYl+wkPCMYVbCzREpvukjIVU63kfXEEFX5V9VzrVLRN5hC/nZyN5gGCE0Xbg9GKekTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ieWMHitVt5MZRknegyNE99wZK3jhgQPrYfPtOQqBfNs=;
 b=kq+3aU96GjSmLcXbCIgMWuNK/ukZqefXivtkBMam7zANDB17GzlZd4Eo5393C06EOc/XYS0UpABnQkqw7RtP8J4f7Plohd4UcYXeaEob5jAk3MJ+30u0IFMLKaBwsiRBxQlylo/E25kx8uE7V+h9srrjyrcG97/kDTADKZAwfzBRwuOcyS7ugZlliLbCT09RPPxG1s/7NqbkD01U4phzQXcAL8+qHle4dkkjkiBxF9J2h9K5cTTukJDRzbrJ9+1HIMgmKNEaovzmNWaqfYoSpt/kS8qcQnzlDH/OMjJwf+mQITGu+pQLrgpjBrHJ6vXbizyClT0/X7u4wYu9prs4ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieWMHitVt5MZRknegyNE99wZK3jhgQPrYfPtOQqBfNs=;
 b=SJO89V4M67yTYj+A4UVzHWngtGrAAuESgq+GDkcR/dSUrt3Q9nUThAGpKK0Z16Mxn39G2DtaRoFDMayBU5V+a1isnZesD8ifHqFlQmaOKpLC6x83nhi6QLcRBXcmyp0A6EayiGBJg0Hs+NMeCuJJxFg37TYZfC2XOWoFEnWgVm5Lctfj+ncuhAgz/wVnr8XFa/2zHsGj3lAiIBZqXOrR6EcA+s0k+MdB59ifvVhZEJBq3pavArcwy/3jWupM7xP8ycHAEPcJwN0Tow9Np5cz09Bgdarnpz4VGxjiPfEm8zJioIQ6wBjqrFdmDUAZ2Xh9kL9dajv8QWe7YF+RhnhwBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DB8PR04MB6873.eurprd04.prod.outlook.com (2603:10a6:10:115::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.10; Sat, 20 Dec
 2025 19:56:11 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9434.009; Sat, 20 Dec 2025
 19:56:10 +0000
Date: Sat, 20 Dec 2025 21:56:07 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jerry Wu <w.7erry@foxmail.com>
Cc: claudiu.manoil@nxp.com, alexandre.belloni@bootlin.com,
	UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: mscc: ocelot: Fix crash when adding
 interface under a lag
Message-ID: <20251220195607.wz4rykcbczjjeh76@skbuf>
References: <tencent_7C21405938B40C8251F2CFE0308CD7093908@qq.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_7C21405938B40C8251F2CFE0308CD7093908@qq.com>
X-ClientProxiedBy: VI1PR07CA0161.eurprd07.prod.outlook.com
 (2603:10a6:802:16::48) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DB8PR04MB6873:EE_
X-MS-Office365-Filtering-Correlation-Id: 83a154ab-db48-4510-e567-08de4001d29b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|7416014|10070799003|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yos/Zu+2MiCpRzApb0uFLra1+B6WE+lUFKhTLuyFdSl9c4Ek/v+kwTAUnLd1?=
 =?us-ascii?Q?50bLbuUVwJCZZnRdhTzVjG5qehrrEDQDElD9MKmMR2ncCgRtRnt0t70wSrCU?=
 =?us-ascii?Q?+dI73ivUP5UyaarRDywcwszDRp4mZrMqy4KuYX9XakVsrvLe+IzcVrdG3b5w?=
 =?us-ascii?Q?e7m1/z0rhUY9RaZyUOK+LbQhDvLcBD4GjxGpvct9EZYy5JKpZ+37Zemd/ior?=
 =?us-ascii?Q?CqI7OLVWeBGqnBEyptTlxU8zojj75pyU7jjOzeDrWtsvMYD11laHbYe+lwsW?=
 =?us-ascii?Q?gKJm1xCSKzp3Gnt2pKE6fyaiJoWK3ZRh5CPgu7YZ50JLZnVLvAbc7vBXf7M3?=
 =?us-ascii?Q?wTfQ6GiVUjilsloNHysIcnf55zOfKnj2tf4U7so0wZYx8cs+djxGLwg7Yf0C?=
 =?us-ascii?Q?N4Aab2r+VT83YVlFCUs5mCTvOqXpM8WpnTqhSJtXceC7uzWzhdQOVz9EoZpM?=
 =?us-ascii?Q?YDhkGgl9DnKUCRre0LSg3QQnwqYFwGj5AGAgQxFsQjQCJCG/4X1I2fKxPuR6?=
 =?us-ascii?Q?lkdG2UlaJguJr/a4pMgjgdqzNwp4E69sFLrZ4UrRcUt6X467p6KZp12jV/cp?=
 =?us-ascii?Q?rTumvMR8Nz1MPs4Qza9olBYCoB023HA9fKIa41VcK+6cmJSVTQju2g4EZfMp?=
 =?us-ascii?Q?y/cwFBR9S19P3k9xTptHmyv3RCBpH2z74ppITMVImI0nO0AGbFDiynzLsmWq?=
 =?us-ascii?Q?TML0CgeVNVvboENyouCL6JOecD6NWVge/bFb0gTnwaWFGzClXdDE4/lsMuWD?=
 =?us-ascii?Q?9OPEt3aTzfvMvHlpqTB1wDV9KBgob+p4CyEhZDExDhXExcpByCX5yRwg6YXH?=
 =?us-ascii?Q?rGQPZb2Kux6u6cK7fud93kZcRi2mbZiUykQAs8ORA7sKbbCQcpwOe/MDVaE+?=
 =?us-ascii?Q?4FS9GO6NuRs1lWo/ZFNFQ/050Q4+TXOkVRGz/0C8xF4Qtazvq+3NerPo3g+R?=
 =?us-ascii?Q?JL/dcuqhxbxgcvtyrGZv0J7Ni4igpR/t4JgP9hz79+BTOLt7QeFOPqwFav7h?=
 =?us-ascii?Q?peiZSX/jxAWKETgEiva7Zj7+m1t1W4ZXQ4GFYdn6j4ddhEeodPYrDd0IBrAu?=
 =?us-ascii?Q?3cRhjKS0wfMCIX708+CYksvHIjGQJm7RD0kd66GDzgInCxiE1teCJCImb3p4?=
 =?us-ascii?Q?x8R+o4kBKBGpe7b2q512Fh4a7ZvmOArDhnP6GyAiPPZ7N/V7gANgDubu/QAm?=
 =?us-ascii?Q?4nT1aFz39gO1nu6EUhG4ClYpoPJvg4HMfyGZjBuPYqaGVhMebXik918EWMBJ?=
 =?us-ascii?Q?w2O89UweOSTK2Jl2P0UtR9Qpo0O7aToFCS2c3AlNINn7I+BTpbLG8i7YBSYG?=
 =?us-ascii?Q?j6iG1moDa9eMw4uJ26zKYpWpcclXuAkipYmMqoVp2M/G/L/C8yjuw0zLl6Mt?=
 =?us-ascii?Q?dtNIPUeBiXQ0grdqZRITYkYmFUzQc234UO5taqZRmFw5DyPHorfOqwnZzbbb?=
 =?us-ascii?Q?+w6l0xK+gAR7Vg3q+FQ14S/lun2gaJfYWKrDhlyohq6LhWc3M0VCEQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(7416014)(10070799003)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t9nLr1fRvNS6znXPgcCsWMk6GWDgpu6hfEEEPiPMRovDQyTneNyD6hNB+b8M?=
 =?us-ascii?Q?xgGqtJMXeIUfOKwn4OdYrRZly/v7qmyvXmA+uFj8a/pMJLhLw8gHdeVIn1a9?=
 =?us-ascii?Q?MeYq+FIjoRohv0qsHhVIaUw24JKz44NRsTGUAoG7JHpsJNr7XW4zcvnae+0m?=
 =?us-ascii?Q?RABMAhexGJTTvKiRrNLOZiSZvNeqIPgaMRfiswcozdAmH/RezQp5SaVWE6Ts?=
 =?us-ascii?Q?V6t7D/mVw19Nyei1RP3pCtOX2Avxo07zLCjPc3TcwPI4VW+2y8WF/L0FDGEo?=
 =?us-ascii?Q?BazL3a5VQAUvRnpDyJ7vQdVCAlK/zfcTON3RPd6Fp74lf8p7Nobk3+Mx8nW3?=
 =?us-ascii?Q?0f5HAh3ee/3rdSGw+9Y77o9x6a5xY1DMBPIPLr/9iytOWCqxCF2AAGFuynLl?=
 =?us-ascii?Q?K621h/5V5f7NCHUHwDJumfv1PA8S5FHxQcPVhL9Z8G3EGmOa7eUoFcbnV9kj?=
 =?us-ascii?Q?PWeT+ZZ/sB+55PE+IVVJoB8Q/64UsVAsBmwCcWVz3Tj5a/9DO/wxzRQpa2MP?=
 =?us-ascii?Q?Elck/kM1AeUth+Th3is0FIJDztsH/TsKRD1+QPVcpPJIWb5wWUh0aULX5nxG?=
 =?us-ascii?Q?w96B7f3vQhNktYWUtSyl5dHf6lnWLDpIMDItclNkbNDsgTANwiUcVCjDz9hp?=
 =?us-ascii?Q?rxFdpGNDqHkQb8bkqc0rHrfmSpkOEFtKL/z+VSd7GU8/cPc69O16s1nwnd+m?=
 =?us-ascii?Q?TAudh2S/H96HrqZiADRjGc+3jfT/O2+RKUYi/SgNU/FI9gyWKLUUlr/hqKw3?=
 =?us-ascii?Q?tQ/jrpx2LgKRsiE1CLzc6FjParQHE4zjsa1g2HDLvQ5f1/+aIleoP3e2ippG?=
 =?us-ascii?Q?LdBxFMFqTEWZTK5C+oFP9IvarKqBh3vpos4WAcxMNhCRVmqdOzMokS3OGk0D?=
 =?us-ascii?Q?rkgbBkEELJiodvuETVvNNVzaBTBoL/+TBUfDszLmesd8uvC6+R9ATVIL86Xr?=
 =?us-ascii?Q?F6jkUm4qnlLJQFpkpV1kXoVJzrVXUONI56kvkRFoZxO3NHjFaQiZXqZubdnl?=
 =?us-ascii?Q?qkdB3D7aQ7lXuPiislVqGH1I1lAnWLcZZo9He9U2YfsZ+ZywkEITzDa/BMXn?=
 =?us-ascii?Q?XNY3t0J6A4LLxzo7z/j6v051egtoqBiO4RAoiDpK3f7QQNDAnIk2c9/Hag/t?=
 =?us-ascii?Q?yfccMaFTS5hyfFqDy45PajDA92iY6+zDjSJ65oJ/GRlVmlP7/V08jSY9E2So?=
 =?us-ascii?Q?o/pmyIfApM18HahurTga0ZqvP2Q6z0mDFHjTNrtLYvRxB5Ast4kNRDGOsK2X?=
 =?us-ascii?Q?pvEtmB29Agm0J15scu91bArLfVQ4JQfGB2U7Zk1vEhhPeLBRb2fXj55BYa1y?=
 =?us-ascii?Q?2/mRmDEdhO3M6DGm3mC/U7GEU8PifuKYs3VkxiTdllZvAjGa0RlEivRlP5p/?=
 =?us-ascii?Q?JbNSzgxsb5tobx0v/HPbLNYDd3DCvHBiaSlkRqdFZB4nkaex/sTpZJbi8sRf?=
 =?us-ascii?Q?tbbsrUj9xarTMRmp1oLyPPzM0Y63z3IQ+fM9BoQlCy5eJxEgI+X+G37RxAte?=
 =?us-ascii?Q?vgZ/5UgPIi+lmfoWUMD8f/+haHdmcu0C7ZorpkaE/tRgGeymPlLrnhYW7q0y?=
 =?us-ascii?Q?z57NFJZtDq2ceHbmMb1tB7v22BM/4dFfmvrH/iCDTGHuUYQYePpd9NDNbB/O?=
 =?us-ascii?Q?hDdICIu7jA1gfC5Ouhz1B/8Iw8Sb8+pqU4GZ2TOiykqUA1m6ftw7Flcw85zb?=
 =?us-ascii?Q?D3Ps9vB/qWZMvSMg/MYkpCle7OEsEM/GAe/7Wk907wqUWHc+/uv6OviOhGlQ?=
 =?us-ascii?Q?tHOC6bagaT1YaUhxOAm/SVo7xeUqxajI9aNjhV+8D3WygJ5T4jsASTlJMtDy?=
X-MS-Exchange-AntiSpam-MessageData-1: fL4ah8FDtJNw/NvOvz59DJYen1weTBavWGE=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83a154ab-db48-4510-e567-08de4001d29b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2025 19:56:10.7402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1H2NT/fTSiI8yXjoNNQ2euNaYRrvgAYM7hDJsvaoKcejdUVLeE+wusLyVK/q11FPOPvBclKB/dYAkMzbgb0gHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6873

Hi Jerry,

On Sat, Dec 20, 2025 at 07:01:23PM +0000, Jerry Wu wrote:
> Commit 15faa1f67ab4 ("lan966x: Fix crash when adding interface under a lag")
> fixed a similar issue in the lan966x driver caused by a NULL pointer dereference.
> The ocelot_set_aggr_pgids() function in the ocelot driver has similar logic
> and is susceptible to the same crash.
> 
> This issue specifically affects the ocelot_vsc7514.c frontend, which leaves
> unused ports as NULL pointers. The felix_vsc9959.c frontend is unaffected as
> it uses the DSA framework which registers all ports.
> 
> Fix this by checking if the port pointer is valid before accessing it.
> 
> Fixes: 528d3f190c98 ("net: mscc: ocelot: drop the use of the "lags" array")
> Signed-off-by: Jerry Wu <w.7erry@foxmail.com>
> ---

The 4th item in maintainer-netdev.rst is "don't repost your patches
within one 24h period". This would have given me more than 4 minutes
between your v2 and... v2 (?!) to leave extra comments.

The area below "---" in the patch is discarded when applying the patch.
It is recommended that you use it for patch change information between
versions. You copied a bunch of new people in v2 which have no reference
to v1. Find your patches on https://lore.kernel.org/netdev/ and
https://lore.kernel.org/lkml/ and reference them, and explain the
changes you've made.

>  drivers/net/ethernet/mscc/ocelot.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
> index 08bee56aea35..6f917fd7af4d 100644
> --- a/drivers/net/ethernet/mscc/ocelot.c
> +++ b/drivers/net/ethernet/mscc/ocelot.c
> @@ -2307,14 +2307,16 @@ static void ocelot_set_aggr_pgids(struct ocelot *ocelot)
>  
>  	/* Now, set PGIDs for each active LAG */
>  	for (lag = 0; lag < ocelot->num_phys_ports; lag++) {
> -		struct net_device *bond = ocelot->ports[lag]->bond;
> +		struct ocelot_port *ocelot_port = ocelot->ports[lag];
>  		int num_active_ports = 0;
> +		struct net_device *bond;
>  		unsigned long bond_mask;
>  		u8 aggr_idx[16];
>  
> -		if (!bond || (visited & BIT(lag)))
> +		if (!ocelot_port || !ocelot_port->bond || (visited & BIT(lag)))
>  			continue;
>  
> +		bond = ocelot_port->bond;
>  		bond_mask = ocelot_get_bond_mask(ocelot, bond);

Because the "bond" variable is used only once, I had a review comment in
v1 to delete it, and leave the code with just this:

		bond_mask = ocelot_get_bond_mask(ocelot, ocelot_port->bond);

You didn't leave any reason for disregarding this element of the feedback.

>  
>  		for_each_set_bit(port, &bond_mask, ocelot->num_phys_ports) {
> -- 
> 2.52.0
>

