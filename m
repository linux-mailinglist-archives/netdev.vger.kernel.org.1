Return-Path: <netdev+bounces-194833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB33ACCE53
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 22:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 729B23A4918
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 20:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A16224220;
	Tue,  3 Jun 2025 20:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ioyIMqAD"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013066.outbound.protection.outlook.com [52.101.72.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2EF2236E3;
	Tue,  3 Jun 2025 20:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748983514; cv=fail; b=lVXuWyushap/2LGWDUguKIM1UDzp+/owD0SSztHM5ZpO1bCH5N2oErIpVcG4EuHx9K71EJkP8c5Xke3x0wWPi8k376a1pzZOC2bvMIWD4rOP0IKGqy169NFeekGS1Ez4BMJG593BAByZnrQBzli7Hnm0s5CqSAVT+RzvVC71H1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748983514; c=relaxed/simple;
	bh=xSHQYPNvzrCl45Wl70QRWuP2Drl7d8Rf4WhbL+C7mAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Zag2dZ1EmeNr4HdLaxLbQbk/UQvOEY0l1xElLTV/V+TclB1Gpz20iR4GzDNEq9hp5zYg2+swetGuCPk+0EcM3roMtTLMmJshmZ8FTDYhxQHaAN62iuIpjI0G9tOpVXWy9OYKvJ23om2TcqxXxGvQQiAElP2Wz+7OGjmfJjbZxo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ioyIMqAD; arc=fail smtp.client-ip=52.101.72.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IP8DcUgPI6XqWh8WKhYCOzmx1uO0ky2r/GF7E62lySZxD4hUWkKiTN81tHFXIRwnRmglbE2NsYBfoKtpzsN1Ad3mgpsQ4GOMelhQ5UvVxF6IRlAeM7T+vg+1yFLU0uXWGPO+PDrAqa0/efaicUcNf0wHFYlDReCDI/c8MLvBx0YiGSZqQLGaSQTWX3ts8jwkwxuuO8p91r6M5L9E2lwBrjXdKb5uuvh6MCHhrlB9hwaLe7SMPJOpi+rxgSL4EmDYhiTv50ZyZBgjwZ41zteCjSy9ShqQDdrsV9twK1F54usItySu4DEPWRx+qkV7WKlJ2sN5a73nIdlWdvDQJejamg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9I07JanY+77tr0/+AOfmSncqNd8TSDl5vePmwqhwkU=;
 b=zFGpZRDQF4v0F9dQCsAK55Irq+Kc1ZXY608qD+97xhTkG7kmBoUwetRln6hT0AaxK03P3AUO5h4Vlkq2MMljQgv2rMYeuv/hx6n2Xs+i0xpJFYKic5dpGsACTjwKDYMPuP8D8Uy9kBFYR26FuqE5kPNqKdUGoHU6qUtmPdeXuxUcxtIC36rQD0TvRORmH8Z0euUb6cxtMvBmmHAQJJwJjaS63i+4Xl1GGti88Mea9K06RHCVFPCW36rzSYY6UH8ZwMwpKRF9OhRlSXWwNxv1BoDqwoXDCqOodQXtlRLz+P42m6TBjb11fJJSwoeeelOElCl7Dnt47yi5W0/NeI1VVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9I07JanY+77tr0/+AOfmSncqNd8TSDl5vePmwqhwkU=;
 b=ioyIMqADx61rMJhVeP+o6U9cQ5upf0YUkt5zFyXjiGQbbJlc2714LBspGFGv8oh4Ct5pJHPgYfFNGlRuT8n9F4JREwxae6ARPpWulAPt1FgXRlbDe7fpdW+a5yWcTH05U+CuiXq5Umj+CSU5XwTA3dCfEr3/KhoZOXHv0F4QdEcULLOrMCw8U/jLzjx1i5cPv213r5u42XZBp9gW+BZYen63V6JzLtS8e47DNgZ35dbWEeKg4O8jI+YXi742pVTj9HMvUMktoVTm3yC9NGusmn04aJJp6tzLknabtbP6PjpDUwxdb37TxO+WxiOZTWZwCdBxF8I/a58AsdT4CHNFAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA4PR04MB7566.eurprd04.prod.outlook.com (2603:10a6:102:f0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.36; Tue, 3 Jun
 2025 20:45:05 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8792.034; Tue, 3 Jun 2025
 20:45:04 +0000
Date: Tue, 3 Jun 2025 23:45:01 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, arnd@kernel.org
Subject: Re: [PATCH net] net: enetc: fix the netc-lib driver build dependency
Message-ID: <20250603204501.2lcszfoiy5svbw6s@skbuf>
References: <20250603105056.4052084-1-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603105056.4052084-1-wei.fang@nxp.com>
X-ClientProxiedBy: VI1PR09CA0174.eurprd09.prod.outlook.com
 (2603:10a6:800:120::28) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA4PR04MB7566:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c2bd9c9-02e7-4505-f430-08dda2df847b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LwnVHqRYSZ4Q1+2EKpKP2dXRNpGwqHn+Tg5Fr5yY7QTmQuoY9Wv4gSHW7hDY?=
 =?us-ascii?Q?jmGcXI4SAz2T0I1uGOD5jPuGBRGeAzCEEICJW2Q7gylSr7Whh8bc2uhk+0mC?=
 =?us-ascii?Q?XVVA+tMelh7afkKmyGBvl6Niqefw57Q0zHaKb/PD4HkC82gNBxLDbPRFT36w?=
 =?us-ascii?Q?6FmIWA2DKqC0k0jR3bUSkC+eNpbo4PglwwnPJJuuByg8BXp3eAkqTA8seSpI?=
 =?us-ascii?Q?ITxz2g2JiUIJxoncIgQWntzlwDmUKS+gosVjqLp5BxQva02ScYgTUgOni4Gj?=
 =?us-ascii?Q?msZaRr82TGbI8dZwQe1lht2rCBBFym1ORhTuHIgEL4oGkDeov4/jzc3ffGfx?=
 =?us-ascii?Q?movbXhhH9t2Uyv/3SqFzFjGNTTnR4XSIuA11b0AaMDYXvCHOq782TrAvgQA6?=
 =?us-ascii?Q?T3uCqfRMLI+IVjQsJtY//E8RnM4RsEaj9orbSdZFR0j4A1ZnXtO4T4gwFV15?=
 =?us-ascii?Q?PJa+GhUe6xTiV+oX4sIQ10kblyymrUnBFYWhvnmGg0gegziPr4ykGNLCSNXH?=
 =?us-ascii?Q?ybSSrrV0n6GR9Su4oyYr71OAcwZ+5y4dr1+0VF85zp3wz48cNAxvR53pPe7g?=
 =?us-ascii?Q?We/L1V3kEFy5zrrZ8/LMjhpYq3VMeFbAecsbR5T+DKJKnyQXV4+LssYOGppc?=
 =?us-ascii?Q?Vm4rMzdROszMiw+GxJyZFxAHGRdzqZEg5l2fojYigHOiuPH+3V3rWHJQmfWQ?=
 =?us-ascii?Q?2VwZxrkZ5IuvKSfa2JGt4PVc6lm5DSCmfI9Ir3Hpk2uJBSASDvrE1RasPqm5?=
 =?us-ascii?Q?56SLGhwKWimESemLE8cdPvGxUWP9vtsHYIvsZWwwDTKikkxfDt0tUabMVozQ?=
 =?us-ascii?Q?wXYm3vyb5B9fjLWmPjDuVM+qeESRXutJr4YU+hWx8QZ/IemNuri1E7Etraiz?=
 =?us-ascii?Q?7JC+LhnQo+7FRDrW72Wg6RXoRCcs0CMx4n9m61ZCLrDzVNIy4VHzgiR6TejN?=
 =?us-ascii?Q?LgbWpJfy7bFDzck5+gQKGfrZ5D6m6n4jTU4PXJVK8uskdaDZ/F/nDLRoCMo7?=
 =?us-ascii?Q?kj8vepa8aX3LIZ3kvNXzAHZmReYD44lhiXmnRdyPXGsjWCFsUX33zWB6/PCv?=
 =?us-ascii?Q?FvtTiXbuKvju9IpaGfLJWc5e253k0VSpLJS1/9ecam1ALQNoQJu9IxV1uQn7?=
 =?us-ascii?Q?w3/EnK0VLH8CHMrZzYXKqtrsDmHy5kAxEVS7Eme7eJ8gn+KddL0EhdN0Tpjs?=
 =?us-ascii?Q?ThAUHAC6W7YuKDALJOcroaRte6efm86D2iuSp1nbp4u2b1go0tk3dPpfN3kk?=
 =?us-ascii?Q?+s4YggCFS6Xi2CSthynPxHFKu/P0n+j2XXWn58seAaDDIY25enRWuvY313TE?=
 =?us-ascii?Q?fcQ/xRrrqDRlGpw8c8ullQrT5pQu2844NoUzMN9VQDd69eEIUuHEWCJ2f5YJ?=
 =?us-ascii?Q?CkOVtnaZp7UlBV4OPTQh1KU5C7hMgs/Ag6Ijb5UGq4Uoe0PCXMJWutd2uVxr?=
 =?us-ascii?Q?oFgpkvoiLy0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+rxeGfB2ZKGsOaKjf89eacFZ4sTLkCWdqYEIpjkThdUQMWgVH1KIdzE9AtE5?=
 =?us-ascii?Q?r93VmojMDg8jt5GQmORIJ0saQdVg+8Xf9wLPxFAzG/e5Vf/YzGyLySjexp81?=
 =?us-ascii?Q?SngdnwijLOmM0uc+psGQYeoEEKbnZvF+QRLucNamOk/Qurdby2ixFQs/GRQX?=
 =?us-ascii?Q?0n3Lp/5Y8177uBRDlx8xfwHIAVQuXO5MvaMEr3fDf2w8QK4Sez4r750ilfeZ?=
 =?us-ascii?Q?sQVJAi1rbkdp1ppDBfjcIMJGVagRxs0MDjaXASIFP4qkp1AXEdhrcx/zREHB?=
 =?us-ascii?Q?Hzz/un5UqK/Dxzbqtw8BlQNrt9cr1cVpC5UQb9+F1H3+6OoyILHCfVxAyD6O?=
 =?us-ascii?Q?tjJnhuUVSb+/xFb2SAKe74DRRNHPqnh3E6quu5d/gbMMUWHIlPr677h7TKXW?=
 =?us-ascii?Q?xz6y8K/NqKwP4rHcL+PpZvI/cS4d/5QG2Q/iuWUAkh8lsYUm46bNeRpb6+1J?=
 =?us-ascii?Q?/bSKyt/rEy6QGkZkXnkI/zS95Ve35iV7lGERhMP2IHyjAnlOskl2ljme2D0k?=
 =?us-ascii?Q?Hxv5PwTXXSqPkzrU8S98Wa+yYixpJOHWLPnv2pAg/xjcMsqqhGh994HDubFQ?=
 =?us-ascii?Q?cX0s11Jyf6ZKSxz3ZeRLR8RIMWFaOoLMVNe9CG8noy17la1/fi4ek9YDZV7D?=
 =?us-ascii?Q?HBdsqvJJAyTM/1WQyYuB11kqfEXv4HWpbcjnkt9pX1P18cFeBMLAJoibRdT9?=
 =?us-ascii?Q?s1OgeVzfylG6pQrxb0iMimEWuYe9WLKW7sC8XdwoyOFuL6olGxQSlQJRiD2p?=
 =?us-ascii?Q?QZm5dC4PA8W4xLOwqaqRqSt8jzrG8muiGXyk+fnJEFw3pFAaZfPYBr2069Bk?=
 =?us-ascii?Q?mr6QH4oEkCm4w3FInzpPEfANU/lw8LFl6OGGUgVDaDTDIKmzYwdqLIry6BmX?=
 =?us-ascii?Q?ZOIKlSuh/LIly6P2zkpgIKtLlL63v+v7ImLNGyA6bDfSksKx7JLxuqDZ/WnN?=
 =?us-ascii?Q?mNqR/WLbMXMQ308ObnNlSYgBASPXahy35GofFsH2SMGOWyENWpeUmCOlSR10?=
 =?us-ascii?Q?x5mHkfXrOCw1+y+oHvs9aPBxDmptoB1mM1uWypBdQxWn5B9JXv19/0PWJvC/?=
 =?us-ascii?Q?h/aAfHQ9VWnq25XKakj3Y3tk9oQfNfAKq6TSqX37ShESrV0q+BqvpSTyzmHJ?=
 =?us-ascii?Q?NRCAcLpSloUbPRWz5iquCJTtH4MbrINUpv8m25Kk7j6f9s4RKFHy6WYD29L5?=
 =?us-ascii?Q?g1NGJbSTkGKlNwByemfldO5qygCA1S0On7z1zF1FCQke4T9jhEL8KfAIx9pa?=
 =?us-ascii?Q?6NQ3DrN1T2ozJ7XUAxfBOD1ujrlc8X7xcMgJOLHcmRG3GThkmqoc0tvCQiK8?=
 =?us-ascii?Q?AhF3ttfMRObf9XA3lQOsWayRB+vggRxWVWj7Zy5QFbS0TtrEagmCdAQNjvfU?=
 =?us-ascii?Q?MimnewIYUN7FUmjcSaU+H/lbbugmO9a1FTLo9gwWMxBYPoI1+FpsTltyjrlj?=
 =?us-ascii?Q?qHYoLxYOVITuWGBm5XTUcWIPOhhepL+b5ctoJrQV2ZGdXqEpTwY06i0+6aGL?=
 =?us-ascii?Q?xAjVvVS/iTEsC13U7HnKiFQh4RYimEmx7bRtATX7jPG/rRMz+kP/aOPVV2pl?=
 =?us-ascii?Q?FCbP/jtRTSELbOrJs0MVSERd0YbjglDEB/boR0DJChVvzhHHntc4HQk4wakx?=
 =?us-ascii?Q?eA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c2bd9c9-02e7-4505-f430-08dda2df847b
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 20:45:04.8415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fy6IfXHsZ+S1s03gIhkwKa0iP7g8OC1B1+vm8R5eg1fZ4UIgDIsNNb0Lif2hT5JX2RvLTukSVomi47h+I+5rOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7566

On Tue, Jun 03, 2025 at 06:50:56PM +0800, Wei Fang wrote:
> The kernel robot reported the following errors when the netc-lib driver
> was compiled as a loadable module and the enetc-core driver was built-in.
> 
> ld.lld: error: undefined symbol: ntmp_init_cbdr
> referenced by enetc_cbdr.c:88 (drivers/net/ethernet/freescale/enetc/enetc_cbdr.c:88)
> ld.lld: error: undefined symbol: ntmp_free_cbdr
> referenced by enetc_cbdr.c:96 (drivers/net/ethernet/freescale/enetc/enetc_cbdr.c:96)
> 
> Simply changing "tristate" to "bool" can fix this issue, but take into
> account that the netc-lib driver needs to support being compiled as a
> loadable module. So we can solve this issue and support "tristate" by
> setting the default value.
> 
> Reported-by: Arnd Bergmann <arnd@kernel.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202505220734.x6TF6oHR-lkp@intel.com/
> Fixes: 4701073c3deb ("net: enetc: add initial netc-lib driver to support NTMP")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
> Arnd Bergmann has posted a similar patch [1], but it has not been updated
> since the first version, perhaps he is busy with more important things.
> In order to fix the issue ASAP, I made this patch. And I added the
> Reported-by tag to give credit to Arnd Bergmann.
> [1] https://lore.kernel.org/imx/20250520161218.3581272-1-arnd@kernel.org/
> ---

Ok, so to summarize, you want nxp-netc-lib.ko to be separate from
fsl-enetc-core.ko, because when you upstream the switch driver (also a
consumer of ntmp.o), you want it to depend just on nxp-netc-lib.ko but
not on the full fsl-enetc-core.ko.

Does it practically matter, given the fact that the yet-to-be-upstreamed
switch is DSA, and needs the conduit interface driver to load anyway?

>  drivers/net/ethernet/freescale/enetc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/Kconfig b/drivers/net/ethernet/freescale/enetc/Kconfig
> index e917132d3714..06759bedb193 100644
> --- a/drivers/net/ethernet/freescale/enetc/Kconfig
> +++ b/drivers/net/ethernet/freescale/enetc/Kconfig
> @@ -17,6 +17,7 @@ config NXP_ENETC_PF_COMMON
>  
>  config NXP_NETC_LIB
>  	tristate
> +	default y if FSL_ENETC_CORE=y && NXP_ENETC4=m

So your logic here is: NXP_NETC_LIB has only one select/reverse dependency (NXP_ENETC4)
and FSL_ENETC_CORE has 3 (FSL_ENETC, NXP_ENETC4, FSL_ENETC_VF).

If the only reverse dependency of NXP_NETC_LIB, NXP_ENETC4, becomes m,
then NXP_NETC_LIB also becomes m, but in reality, FSL_ENETC_CORE, via
cbdr.o, still depends on symbols from NXP_NETC_LIB.

So you influence NXP_NETC_LIB to not become m when its only selecter is m,
instead stay y.

Won't this need to change, and become even more complicated when
NXP_NETC_LIB gains another selecter, the switch driver?

>  	help
>  	  This module provides common functionalities for both ENETC and NETC
>  	  Switch, such as NETC Table Management Protocol (NTMP) 2.0, common tc
> -- 
> 2.34.1
>

What about this interpretation? cbdr.o uses symbols from NXP_NETC_LIB,
so the Kconfig option controlling cbdr.o, aka FSL_ENETC_CORE, should
select NXP_NETC_LIB. This solves the problem in a way which is more
logical to me, and doesn't need to change when the switch is later added.

Then you can drop "select NXP_NETC_LIB" from NXP_ENETC4, because the
dependency will transfer transitively via FSL_ENETC_CORE.

diff --git a/drivers/net/ethernet/freescale/enetc/Kconfig b/drivers/net/ethernet/freescale/enetc/Kconfig
index 616ea22ceabc..ef31eea0fc50 100644
--- a/drivers/net/ethernet/freescale/enetc/Kconfig
+++ b/drivers/net/ethernet/freescale/enetc/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 config FSL_ENETC_CORE
 	tristate
+	select NXP_NETC_LIB
 	help
 	  This module supports common functionality between the PF and VF
 	  drivers for the NXP ENETC controller.
@@ -47,7 +48,6 @@ config NXP_ENETC4
 	select FSL_ENETC_CORE
 	select FSL_ENETC_MDIO
 	select NXP_ENETC_PF_COMMON
-	select NXP_NETC_LIB
 	select PHYLINK
 	select DIMLIB
 	help

