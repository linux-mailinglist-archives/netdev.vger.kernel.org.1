Return-Path: <netdev+bounces-131236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC7298D6F2
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 15:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43FEA1C2269C
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 13:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77501D0BA2;
	Wed,  2 Oct 2024 13:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fVmdhXAY"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011048.outbound.protection.outlook.com [52.101.65.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEF71D0795
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 13:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727876656; cv=fail; b=L/o5CLcT82feBhPFv62a7jnIVBOkF2pAW9JDmMcOcMzao5Mfu86ccz8NIMhjzFWVmWuybPZle9/HwPusDx79qXoDH4uJfJXMR+SY2BkhM11/0JntJsaovaRA48R1DXB2l8vc5mHpRqh5FBNl102rA2YTaI+2o9BqjfKbJcd/QVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727876656; c=relaxed/simple;
	bh=SKIevDk/4uYutGrOUVp7XoGItXWPQPOFP+chAkQIbRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SEpywvP37HusM2U7Oe/FfGnKkstx9hLhTGJDvlsmVA4LrZ1XxKKNMbsYfO+BMC3lq/tZZtH+20GlVEg/3oKPdPSPuXKB7uuup8/TTgFsiTHbm42EPnGjJxaOxDUxNKqlHreC5K3sIMWUXTOJhA8UnayRvCutttCWXSyCtvY7XWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fVmdhXAY; arc=fail smtp.client-ip=52.101.65.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QjDjPK8sIft2tEll5VYf5w5TeAXQjFyKnorUA62eQ85azlwQDkx/8OYR43nMgNN2Q6eXV/f5HrYiqLfuJV0z2QSmilVrGoE9sgsahzQIrO85L9InvNvljZStX9IeogUL1b2hSRdUZ1xAiXvNclfXynAq1iN20ZrXW1uS9qWaBADT11v5GZIihLU8LSK5pP/T7FlzYJZUKgNfDKpjjPOrlKwiy5WcyWFSqHO97e7cxjXYGFjdrW8hE6bE1Z8NzetO3AllH+ZmR/a9AefdSRBf4z/7Zst1GBczZ5RLcLpZ5FlUXQ0LrNtJ0ez4ffX57Z+pMbpTplA2jRVrFrlRy2mTnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jxVCB3TSg7QG/PJbMXSggNwM21WcAfaOYh0mV4ome0o=;
 b=mfS8wtgOv1G3+4fgUiJbnQQigAUqS1iYLmM9h8rH42TUEjt7qDAm9ikce5fyA/DV9q1CFTJARmjLH7jM8e1iDjxFV6yMWSPE2OlwCWPL8llkwEtitMSlGZecaet2hhT0mrtWPaHOKiujjFDOz7EIlyFkSnWghaSHtl5L0udvt767cGE0MB+LywBTOG9eKBowJWvC93kFawrd5VTkbOoO5fTq3i1p8SEksvrDOxg4n6xO6PyNbmEWHuPSavpfu1mL/bEX98Vmb2Ba+Y9hU0VIJeaK4EN8B5X8JnuYkMXIG9f5wcdLZR3fX+cb1KLs5eLgYvL4LyjRj5k4IIC35mXLCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxVCB3TSg7QG/PJbMXSggNwM21WcAfaOYh0mV4ome0o=;
 b=fVmdhXAYNm9KkTdQXFuxZTWeLtCXgAxpkcr3agn515f1MdAkH/TZRAS3fXrNV0gkN5rtoDyn10YEPUzZaUDW3Qka4lZlG51jUk/2cwNSph8sMpXggl6/6W2Pi5gU6iy4cDwhJ+XQuLb+EyrirhGwxFOtiCLLsaSXIVYZp7byA9Abp8XIXjyvGdxJ75sTHtMo/wCAWh4tBnKQIaivKmwhhu1U+amUxUlu/OeLySTcgGux0tCQ23fev46YFKG+V115sZWdBCtdBSQHpyjpa5GZCKJKBM35kZe1JZ/1iZ3QkQhOZKxYm81lboR6MMg6VsHDJ/TjmjGdUYqzENzzqxkhQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by PR3PR04MB7258.eurprd04.prod.outlook.com (2603:10a6:102:80::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 2 Oct
 2024 13:44:09 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc%6]) with mapi id 15.20.8005.020; Wed, 2 Oct 2024
 13:44:09 +0000
Date: Wed, 2 Oct 2024 16:44:06 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net-next 01/10] lib: packing: refuse operating on bit
 indices which exceed size of buffer
Message-ID: <20241002134406.a5vpk2cli5nqlvfu@skbuf>
References: <20240930-packing-kunit-tests-and-split-pack-unpack-v1-0-94b1f04aca85@intel.com>
 <20240930-packing-kunit-tests-and-split-pack-unpack-v1-1-94b1f04aca85@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930-packing-kunit-tests-and-split-pack-unpack-v1-1-94b1f04aca85@intel.com>
X-ClientProxiedBy: VI1PR04CA0086.eurprd04.prod.outlook.com
 (2603:10a6:803:64::21) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|PR3PR04MB7258:EE_
X-MS-Office365-Filtering-Correlation-Id: a826b7d3-85cd-4434-be16-08dce2e84ad2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pgxSINbUz3HMoewLDeCAkc+vLsq3wMdzeL19gq8VwnRIo0BgXSIA2VZoDmpX?=
 =?us-ascii?Q?UBw6gmg6AkqJWNk97VQ7jyIukG6XgwldczUs/59pEfALwSekkZFxKewomS62?=
 =?us-ascii?Q?0OUQsnk2f1tJbhKzot80NdOry9o04ajsTkDnUCBlMw0ICHFiJzqjJFWpi34i?=
 =?us-ascii?Q?T2KzhYprew7prEiDYHWa7A1aULYxwiDURVXvIf4zmbAsFHngX9wdC5SejHnE?=
 =?us-ascii?Q?I6t/F2+js8hw6qH8C6Bi84TPqiH9s2WoHt3TU7S62XgzhxxZDkvHTGE8ISGS?=
 =?us-ascii?Q?6TtFb0mdruU6Lsods3S+ntOOUQWJYN6xWVoT4qWq92ggtnKp0HuHYXcVpYLm?=
 =?us-ascii?Q?qaO67PJ0EeroNDYt3cvdAgmv4pd0Q8CiiDxV1F0P6HDog+Makzt97fFyGZk9?=
 =?us-ascii?Q?7zDisZFB+sNE2zMeQ3DqE+kdxYukFOgYEPmkLZ/UX0XE5OdXDR8PV/f7I3sx?=
 =?us-ascii?Q?ML9h7eB3tcoF30QUD6EWvSBOE22YYKOWnuJgE4lKOJ6V+6pZEjKZVIcDv8ut?=
 =?us-ascii?Q?277i0zXhfzAv/sKzR/6uQWijSfpvF0BhJd3G1+gpUElev4TL9wY1ZntXQTaA?=
 =?us-ascii?Q?SffU6gHmBRbYyw6GOCIv6VpgK2W/FbFGjYeX/aTt/Wv6hNt9OzRDXikaXqaA?=
 =?us-ascii?Q?r7IrSbBspeXd9meIxTLpqXowHzFvIAL1DWB/6Y5QKSTDKYhAJBduEFxXmrr9?=
 =?us-ascii?Q?62bECkkUPPQMZOSPLvB2cfDl6rXjTpzd6josoaHgtIwiwkSQmYNRfTTCzgC+?=
 =?us-ascii?Q?249Zj66mEl7AhjFbTsNV1f7JattQA04jDi+fw7B/ZDuinATFXOKYucQdHUoh?=
 =?us-ascii?Q?esCClRI7Y+PhSo2/67yxsu6qkwDEtMzRITmLZX5Ku6DHpQp5UIZW31/6AQtV?=
 =?us-ascii?Q?tU6k66KsK3onJHdcNF3Fvu/1YKRdc2IsKW4HphwwKIFOs1YEU4q09lolIs/D?=
 =?us-ascii?Q?irKfg/cGZjuPoGRhObpULhuKS4d0HyxR84rQJsOgYYCuZGjVjA3d1ao7xoKN?=
 =?us-ascii?Q?eqydnlVi7nd6yr4WnTZ49QGXVAjiafcaAp5OJ9Rnd5Y0xCkm7goGeWENaOjW?=
 =?us-ascii?Q?Wu4nuPxhyN1Jdp6nG41WP6ujssYLcSe5Oi1ur7mJh4pbKZ6Wp24EDQnMvJXJ?=
 =?us-ascii?Q?S69Cy0u2VMnVy1/ag9Ej1OEpFmoWnm66X/1x5obpjKs2p4ztFXw6Y77YTLNH?=
 =?us-ascii?Q?+o9mJgfmxhWRNRcEYGvXA06eLnUqXYD4UhhNwWKnHkRwCFlheR/Qq+fS30zq?=
 =?us-ascii?Q?+OtwX1Ch05H/eIf35rzQ0vKJt6zP7oHQKB05LOMXoA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eUDUQUGFQNX8B22HoXWE397JgW6Wc6KlG9s3F7y6zEqGNM42mhSZqTuXhnSn?=
 =?us-ascii?Q?vpPhmZbEUnN6p7AtqjaqPMvEn3XZHduj9Fw4fRKS7h7Cs4ipDbrqxy4F1gc0?=
 =?us-ascii?Q?4ulTvJ2b73CtghAWQbEztEQL/yTVYVtMUoouwfW2f1wxxsS+7BWCdZXL4XZE?=
 =?us-ascii?Q?JtEOKGvA8UQNTluRukYBWaQ0apu9lcjlkeM3D2ev8dzYORs2D00pFbkbprYy?=
 =?us-ascii?Q?LTpEXiizJunvXXHyT8Dg+XT4IFqQGo4EqD27IsI7BLG7ozAk702B06vDql29?=
 =?us-ascii?Q?oRJiWkG+qW0C02M/IgayriB0yH7FDk00vje/ma9BT+m9B8a8aUitfWLkKgi4?=
 =?us-ascii?Q?xf0h1KzyAeUlakriYiP8/tbuHnuberatf0YC7PZ+zs9qjRcH9g5VOjusLLxg?=
 =?us-ascii?Q?4hP1nyWvDg1U4zUwDvpoVrtNtm3FGa12Os36vnU2gwsq8XOgNh8c0K2fpLw5?=
 =?us-ascii?Q?yfF3Zn3F6Y5kJcBAGkcZblK0KD2rN+bU8QQb/uIt6WX61t38pQtagphZSDZB?=
 =?us-ascii?Q?RSkohkpjCcpLeRDQHG6ZuP9MjhBEincFoXP862ncfEOfWeo0YUZf5rQDwQlt?=
 =?us-ascii?Q?XcWt9Ris6+prd+kJbqIxqpYe0k+CNtR1TSOBKawk4Z7DvMfkFRdUtu4htctI?=
 =?us-ascii?Q?egkukbiPK9qqfdVZoAcX2Nwt/lGH/GquiwUyNuDL8VMElwbGop0exQU4YsQN?=
 =?us-ascii?Q?rSqHzt2FoArjatKJ7clZ9Yh9uykSDscJFgmsHjyO8gk8K+kLw/CNG8Pcz0i0?=
 =?us-ascii?Q?a8Qt2/dAqAO9iuLuuw5oib4cgq4IEIAgfEV0fhm5m0keKsH/JU7d1razi3Wy?=
 =?us-ascii?Q?Ge8UFu7eBdFcLvgUQH7CfLYixcOVOLMJpxSALeIofCst0E14fXqb1ECJrHqX?=
 =?us-ascii?Q?+tYVKH+wMsZyeqLnPMRq4SNViJs1X9GWfxHkvDH5S9erzcBEd8L02O24gxqG?=
 =?us-ascii?Q?hlZsyoMRFnpmG7MaoOReZ4swltnjHdKOmGaNwtO7/rlLafaC5sOVof/CJCie?=
 =?us-ascii?Q?+dDqNnuINQw3iQfPo7E55V7U7+K4lJPwLFMhQyQSghFkw32+uzjZK+jJo7WI?=
 =?us-ascii?Q?7Ct1W6N1wZ5vm7q+jiJpWxm2als9fGxJe2kXRKWk80aUOj7yRM6i+LwkEGiH?=
 =?us-ascii?Q?/ZySOjbtH08t+DCRvkkcJuHwO1QVvMvBBQz5ATFwrEmAgoTTFQ7hO58AgkyZ?=
 =?us-ascii?Q?41Mwwfom1klmLGiM5xU6Vnv3exwJqu1xSml6TqDYmAYyum/7zKAl5D+M0cdi?=
 =?us-ascii?Q?hY/9LnAD5P/C2KvNLfU9ujnXtayWRHuw741+ytsVQpOpjKdOFs+v5w4knbmk?=
 =?us-ascii?Q?aAVldEUdkj8y+70BovIQPlPKsQDlA6rR8l+DLM45m1aXSBYT6mEfGH5fv6dp?=
 =?us-ascii?Q?OHlaBoHGwsn2ojyROQe4Z3ZP0XN53tFcwDCaliNDqUa6uGCIlD7/3R9yRMoe?=
 =?us-ascii?Q?/8ZBUU5JSdQPWmg8BZTIcTw2EczD1Ge5/y6g/TK9IxTAz+kT21qWc247Q8+v?=
 =?us-ascii?Q?EFjD/s/k9D4Zm/1LycpXp4Gimv1OW1z8Cizat6x5ZMaB3SGkVUnPwy0cpfuf?=
 =?us-ascii?Q?W5Ow/kJICKX2amIaV9ky4nFimA+iT6ZRE+pyJPCyXmstrfuOVruAy9c6GGnv?=
 =?us-ascii?Q?hA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a826b7d3-85cd-4434-be16-08dce2e84ad2
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 13:44:09.7051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EyR91p4QNg28G51UcBNGdmPU99KdTc7EhPtGKX9JJ4/ekRBWnK4MljWk7RgqkQIxaex26I1BT9aV4wgiJowkGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7258

On Mon, Sep 30, 2024 at 04:19:34PM -0700, Jacob Keller wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> While reworking the implementation, it became apparent that this check
> does not exist.
> 
> There is no functional issue yet, because at call sites, "startbit" and
> "endbit" are always hardcoded to correct values, and never come from the
> user.
> 
> Even with the upcoming support of arbitrary buffer lengths, the
> "startbit >= 8 * pbuflen" check will remain correct. This is because
> we intend to always interpret the packed buffer in a way that avoids
> discontinuities in the available bit indices.
> 
> Fixes: 554aae35007e ("lib: Add support for generic packing operations")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Tested-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---

I thought that Fixes: tags are not in order for patches which are not
intended to be backported, and that is also clear from the commit message?

