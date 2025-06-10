Return-Path: <netdev+bounces-196004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BE7AD30DB
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 10:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C644C17188C
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 08:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C008280A35;
	Tue, 10 Jun 2025 08:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kB9VjUYL"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012060.outbound.protection.outlook.com [52.101.71.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2123227FD5D;
	Tue, 10 Jun 2025 08:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749545410; cv=fail; b=T/252bymNonupzx5ZLOnYrSWxXonj2Of3TtWGM2bwuIoPi6ZYy0N9wjVmFcxcEO1xBv8yMmLm9NU6VoPnz9SFVGIuAgSEopc5S2hFt67EojgdWAU6Hkcc/KG2i6C7mqpxEZe4VjsCIkPcTuHrPr+yMsyahYw5aViFZLucTzz8G0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749545410; c=relaxed/simple;
	bh=g0E+dgOBOKIvp0kx6ATzygaPxXW7KjZvqXIOeSGqIwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=udZFi++V7DBdZOXfV1qxuXVUwFoq9xUTfaM5Qhe9zI1lNGxoBBnMmPIaNc0U38JU/pMRKPg5ajJ8pkg5ErBex/o1v5CzX1+dRCUJl3nGHMopCAZDq3GigRyD6/j6TBwqezNmPSlr5vOsHo/t2JdSqJb9AYn/A9DjhXwSbGoS3AI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kB9VjUYL; arc=fail smtp.client-ip=52.101.71.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OjmuiGgbS7xv5Q/8/LwnBVfuqMl1MIOPpdIIPLVoLGaItAQG8v+tzINjEWFEOD9KnaQHSsZd3TbSwIYTLlArfZ16eakRZGE/jHaRwG5YTNyON6+vf+KH/0Z84+M5qV7bxySsFrRrku1vBtwu6gYGupShfdSY6U2zcSGJIv40gEMFiqOvgOgWBW2YG66nDUUiYl330NCbAN/JY+wHQOnIuWM090U3Z3ZbhcsV84vdU/go+bODLWXcab/FFSKfY4JUgCCmTWLnngxU3Kz64BGzIbX89VxT1phwOltf+kHdWJ9SPYKAF1n+NbCLtrQCPUEmA9lEGC7DKEcjnw0bRVTGWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=flHaqWaxC82Edjn6gpAQIn+tVQcTs8VVYnc7PpuRE0s=;
 b=glsBvPI3EL6L4nHY/Q2Plc2vgxW6O8e7Xz2MorpHLm83OiUJHR3mWF5fgE1Yq0cnunoPNHpl71TsId1cyQa4U5EtwcwexZZRTM204L2w4s8BLK2rCYBWQFb+niCB+/v13gEcDCGTcWYIqBSWLaSYC53TjOKu52IGkNp5XlRk6ItGqlA5xWshP9xqZHJVxTX9hRNR7co6eQbNyZ6T45zYLVkeAN2892h/Pmj+VyvNO10Tcavc30VCybPXNhPP5D9jmdC5DBIo/WM05lZcAQowoJexRbq686wE7Jt5WHMbWqVTUv3C95PDPlo3peUyeYqn4DfkMHXeN3AaFc6WNXbhLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flHaqWaxC82Edjn6gpAQIn+tVQcTs8VVYnc7PpuRE0s=;
 b=kB9VjUYLUxZoBoeU9aRS8RMq7X19INFz82Qd3dc99Xtaa6tx52VHO4ydqOxeNshiC5Nwrc1d7FdAjWiJnTmDqvszfKg/nrMC27BvOJDmKK5HO3A32bQtchS62eNdod1SUhWD/cbqXHpSCI2uKW4qp46u/NkfAVuxQr197aC6pnMa3/fslZpajNSlmXo/4Yy4Fki99x552q+lfFeS5HRu1UtzB0pi5Ommdr50+XQ3G9PQQTyKL256ux6tDH4SPt9kC7gWrn4uKsLyL6yImAkR6Xy94uQwynFV3IdHVZ3ewls/LLz9av/RlDh94+Sguo/NJAps5GNlQ8SvbJQumNLfHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DB8PR04MB7132.eurprd04.prod.outlook.com (2603:10a6:10:12e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Tue, 10 Jun
 2025 08:50:05 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 08:50:04 +0000
Date: Tue, 10 Jun 2025 11:50:01 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Meghana Malladi <m-malladi@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Simon Horman <horms@kernel.org>,
	Guillaume La Roque <glaroque@baylibre.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Roger Quadros <rogerq@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, srk@ti.com,
	Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH net-next v10] net: ti: icssg-prueth: add TAPRIO offload
 support
Message-ID: <20250610085001.3upkj2wbmoasdcel@skbuf>
References: <20250502104235.492896-1-danishanwar@ti.com>
 <20250506154631.gvzt75gl2saqdpqj@skbuf>
 <5e928ff0-e75b-4618-b84c-609138598801@ti.com>
 <b05cc264-44f1-42e9-ba38-d2ef587763f5@ti.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b05cc264-44f1-42e9-ba38-d2ef587763f5@ti.com>
X-ClientProxiedBy: BE1P281CA0177.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:66::6) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DB8PR04MB7132:EE_
X-MS-Office365-Filtering-Correlation-Id: 22f0215e-6c43-44d2-eefb-08dda7fbcb5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kVdo+ePB3JJ5El/V0dvNSEbNAVbMHa8TVdUuObvoScYkeNaLZB4ZRpERRvI7?=
 =?us-ascii?Q?ZlASE0K0IFrWvDzszCMoqmxJZ720+91fdOfJ59Yd1vaFla5nuEShEaRdGsi6?=
 =?us-ascii?Q?PAn2crRjTT8elwqZTK8YOoOAx6zSdTurmfbqYimgLE/sOYsTPfzpEe68LFfE?=
 =?us-ascii?Q?i3k73CtOBXwGdaW/8D0cKUyWXMhy4U2sqWYq+C18vEzz8IECxrevazl/n5px?=
 =?us-ascii?Q?BApt+iK+8KB2SL+5M56uIN/oN8mCA54JRVezfZRA3+a1nRj+AtokP8TX4KNa?=
 =?us-ascii?Q?15Dt7twNNpvd60ITvbqt2F+/hviBssHcd9hlbaEqlZBCiFK0Bp3RldKdLiCy?=
 =?us-ascii?Q?XwUvLcwLuzwxYCC6jFhQux0+NIV3ZRjsguwRpLm1ox99FAM4oPSQkIGnr969?=
 =?us-ascii?Q?TFppKOzNTn45LACZ+e63nEqR1lJ2WPQzxoLzSut6DCSyOEygZinEhqB6ecap?=
 =?us-ascii?Q?6/O5eUGnLZBYSolVtSpBh4OVfQ/cxD6Pns3jvA0Ubyd7PFE56pwyaArFuBtj?=
 =?us-ascii?Q?nyRFtJAeZo1FvEJtnR3U1wOjQeCmTuuniMgSh/TpsNa6/xd/BNyFNOLtQsSo?=
 =?us-ascii?Q?VNvjfH3I2BBZ9EDEAGMTVs0WsOEHORdoCB4YuIRO9bEI+SRfKRi4TJZ0qVU3?=
 =?us-ascii?Q?UjXEsvXtm1H99h3KUadog1r0DZD4erDTioYoTTk+dL3b1Mn7GIkiq/7+DcgR?=
 =?us-ascii?Q?ePJPbvCKOuFIYb8qMA1X1O8s98m0cxS2BcH7Y0Qmd2WB/M+rjxZ7PNDJpCCx?=
 =?us-ascii?Q?5aF7lHKxsJPw8yxo/SnnxMYStI22ipEc3DMBDgwVyqtnCas+wZBSks4RqCC/?=
 =?us-ascii?Q?YdrCzoXfPa1HHlzTN9ub/3MxF8WtPsmFIwc1s5LsjvKr9L0QOyBvCwuc4xzB?=
 =?us-ascii?Q?oi9H52xaUeaDmr/UG13WWjBJgu+S8L2oC+H493TYKEvgNTz5LXuaFvjCF64R?=
 =?us-ascii?Q?376nSnunOlWREE2/FT6ANepnFE2Ti0P5d3ovO9b2fkDNhKX1SaNYZocNpTM0?=
 =?us-ascii?Q?I1Tp6fPfUTLd3qJOAOrnlC6ryaa1SGShSu0h385WObKKAbz5oDGhovqxTWTV?=
 =?us-ascii?Q?4F7d0od3/RBqM8BFQn3UjxesoDuYLBfFmewEaUgshJ01xemskKl/ZiGwTyrr?=
 =?us-ascii?Q?fveCLiiT+KA6xIEO8MBFJnEad1fDP7bU4HgDigLCcm9vE1Ww4d+qkNcJi6do?=
 =?us-ascii?Q?Xqcn4rTFnYhlhTSDOjo0X9RyMjoRY9g3QLrcvU8/tZbrA+2YvvX6Sagwuw3u?=
 =?us-ascii?Q?oEKXJhQn+vL2tYpML6/NYQT3DVe7VWM2M5p/CMmONvSZXXuMamPLA9Vy4STz?=
 =?us-ascii?Q?eWGrHEb9qH3rSJsxhotG7DrEUM16eobMGGYFIm8Ld1viI+RTC9eFLUhB0TGF?=
 =?us-ascii?Q?b5drhbYHfz8bHhTKDX6WlF9rF4RUUza6KhVLATuwAio63biS35K/VnTYRHK2?=
 =?us-ascii?Q?xe5HFH3rnxw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fw6+rCIZ6zUHoEh+iHom9DugV7wLzACC2gFbOqtqJRmdbK7j+S1YK26+/hfo?=
 =?us-ascii?Q?Z87TQkKYwfXOqusxuDJlPyOSv1CHYWqpc+erdnmUgx88vHoD+L/GlmMt6GgT?=
 =?us-ascii?Q?sxogpeq/VZ7UgqV1UpNOqxghRsGZ3yWVOZUiZT/DCL54fcVBtLG6aeV+wmCW?=
 =?us-ascii?Q?ai3uTAwRNtOn4VFUrkp73e0M0WsVfXnHLe6OPNKLllCk+49wTQYOX0NlPg5E?=
 =?us-ascii?Q?ipEZe/7vLvFgT4d5Aor9fLtq9EA36bTRUmqFiqCJcg+hWdnfsGForoWqN1pu?=
 =?us-ascii?Q?/XOETEFXpFiVjPg25OKqA1daCpYzVzp17PE2qQjS52K0ZrBq0Wn4cyTiHa3B?=
 =?us-ascii?Q?TXzZkRhFlwuqNHswLLw0zPf7wIlNfrQ15+zVRLKx3VOjVlMOPgw6vDS/oahg?=
 =?us-ascii?Q?z/o+cATwbM5xM7uz1GjtryLAzKmUjXW7cxiakPVmjt/lK9yU8adneA88Z7ej?=
 =?us-ascii?Q?2aNr+bDPshTTSjSOoPitYDA0Ayw3k8acfw1MGOFuLxETNVN1JOC6ysWTwQgS?=
 =?us-ascii?Q?+7Osv1d70i//NBqlqasxdck5DEivZ6B6iP8nz1BInNzprhOsz4xEpbgugIWJ?=
 =?us-ascii?Q?S59xSFT35/bOjxF08v35v6Tbw4dx9Of0F2HLQZmXZ6Wz5YtqWtMkth1m8DXY?=
 =?us-ascii?Q?JoQIm8dLMPnIjjygc6bZMxECvpJVCRrtnjIaIpuZds1L58T6enIJV6Q9t8mG?=
 =?us-ascii?Q?9I+U6P76WuNKAeAmRcwCNyXzUJPQ8qMfDmFbReA5x7rhcV2uMEN0p3NMvO69?=
 =?us-ascii?Q?w8KKGcax2bTJsKIpqvvDxslfxeR7N/pwM3qiGRhz/MWerp0toPLye/CkuOuW?=
 =?us-ascii?Q?bSMYJh2EbTUrdGa8oVdaHygn5Fe/mnIUaBsTddDkbL5Cv0U/iV8PE7FipEFo?=
 =?us-ascii?Q?STvRYcQTXyWwFbWk+BnW6KRR+oZbSEN1KgPQ/NPsAEJw1JHikNv4YebXO7fa?=
 =?us-ascii?Q?S6T2n65XsgnH+HEiAvrvaXtr0X4JPkYTWvo/8yAA8xFqcfcwRbJYzbYp6BUx?=
 =?us-ascii?Q?o755U+gOtNWiuWKGp2tMnEHmjHcL5ofa1HGxQE++ePe+Pg/XH/Mpb1epCEsQ?=
 =?us-ascii?Q?MewsyxDIm2m5qy11azTlA/wdL5Hk9jFcv9XFxTqsuxs47dbKlYHvh7pi9cAj?=
 =?us-ascii?Q?98NLo1DnpTmRBZInI5uWmoZvAbPm3SVzP7HQbhRIwo2Ly0kemklpNTqBD1NH?=
 =?us-ascii?Q?Labf9ttzkYGdffn5nDeV5Otbg5KcwmTWSEwIYgLWTv6RsKeF5O/FcQvdwL4V?=
 =?us-ascii?Q?BRXqB87Qf3XN0uGSF30sT+ZlJoRZN+V23Qxfbm0X410s2pcucQKvS3r/XES6?=
 =?us-ascii?Q?TObMcFJZbobywvfE21cUfjpAqRvBKXLCu0vdxK86E9h1N7kx7akAhjV2E6Hj?=
 =?us-ascii?Q?C9bS2jExe6wzAZjNOAtrjAx0JzrQq+f6OtD80nt4e6J0cFt0gPBTilTZqEdv?=
 =?us-ascii?Q?NjVjzo9ztnSTtSuRDIABiPN+ToARmoFxTiynvsRJD7SxXNUhee0bC76Vbxoh?=
 =?us-ascii?Q?jjLCtfdQ7WAeOGG2tPgLTLV8KmV1/LKgMboLkENSltkKjZKyBTb76f8i4Jvv?=
 =?us-ascii?Q?tytWEkUk3ngy14GWA/M3iFdcnGvHXJ139tklnhV89+dNgXKYjRvl/yhZWoLl?=
 =?us-ascii?Q?fA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f0215e-6c43-44d2-eefb-08dda7fbcb5f
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 08:50:04.9198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AXJlZ1gR51291Dneo7AkwY2ojArA6T4LXdLjFFKZp9SM3HKF+DByrkKcv+CKjw/Ip/RZmOB6zF8oSKc34bCecQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7132

Hi Danish,

On Tue, Jun 10, 2025 at 01:13:38PM +0530, MD Danish Anwar wrote:
> >> Please define the "cycle count" concept (local invention, not IEEE
> > 
> > cycle count here means number of cycles in the base-time.
> > If base-time is 1747291156846086012 and cycle-time is 1000000 (1ms) then
> > the cycle count is 1747291156846 where as extend will be 86012
> > 
> >> standard). Also, cross-checking with the code, base-time % cycle-time is
> >> incorrect here, that's not how you calculate it.
> > 
> > That's actually a typo. It should be
> > 
> >  - Computes cycle count (base-time / cycle-time) and extend (base-time %
> >    cycle-time)
> > 
> >>
> >> I'm afraid you also need to define the "extend" concept. It is not at
> >> all clear what it does and how it does it. Does it have any relationship
> >> with the CycleTimeExtension variables as documented by IEEE 802.1Q annex
> >> Q.5 definitions?
> >>
> > "extend" here is not same as `CycleTimeExtension`. The current firmware
> > implementation always extends the next-to-last cycle so that it aligns
> > with the new base-time.
> > 
> > Eg,
> > existing schedule, base-time 125ms cycle-time 1ms
> > New schedule, base-time 239.4ms cycle-time 1ms
> > 
> > Here the second-to-last cycle starts at 238ms and lasts for 1ms. The
> > Last cycle starts at 239ms and is only lasting for 0.4ms.
> > 
> > In this case, the existing schedule will continue till 238ms. After that
> > the next cycle will last for 1.4 ms instead of 1ms. And the new schedule
> > will happen at 239.4 ms.
> > 
> > The extend variable can be anything between 0 to 1ms in this case and
> > the second last cycle will be extended and the last cycle won't be
> > executed at all.

Thanks for the explanation. It sounds like a custom spin on CycleTimeExtension.

In your example above, "extend", when specified as part of the "new" schedule,
applies to the "existing" schedule. Whereas CycleTimeExtension extends
the next-to-last cycle of the same schedule as the one it was applied to.

Questions based on the above:

1. If there is no "existing" schedule, what does the "extend" variable
   extend? The custom base-time mechanism has to work even for the first
   taprio schedule. (this is an unanswered pre-existing question)

2. Can you give me another (valid, i.e. confirmed working) example of
   extension, where the cycle-time of the existing schedule is different
   from the cycle-time of the new one? You calculate the extension of
   the next-to-last cycle of the existing schedule based on the cycle
   length of the new schedule. It is not obvious to me why that would be
   correct.

> >>>   - Writes cycle time, cycle count, and extend values to firmware memory.
> >>>   - base-time being in past or base-time not being a multiple of
> >>>     cycle-time is taken care by the firmware. Driver just writes these
> >>>     variable for firmware and firmware takes care of the scheduling.
> >>
> >> "base-time not being a multiple of cycle-time is taken care by the firmware":
> >> To what extent is this true? You don't actually pass the base-time to
> >> the firmware, so how would it know that it's not a multiple of cycle-time?
> >>
> > 
> > We pass cycle-count and extend. If extend is zero, it implies base-time
> > is multiple of cycle-time. This way firmware knows whether base-time is
> > multiple of cycle-time or not.
> > 
> >>>   - If base-time is not a multiple of cycle-time, the value of extend
> >>>     (base-time % cycle-time) is used by the firmware to extend the last
> >>>     cycle.
> >>
> >> I'm surprised to read this. Why does the firmware expect the base time
> >> to be a multiple of the cycle time?
> >>
> > 
> > Earlier the limitation was that firmware can only start schedules at
> > multiple of cycle-times. If a base-time is not multiple of cycle-time
> > then the schedule is started at next nearest multiple of cycle-time from
> > the base-time. But now we have fix that, and schedule can be started at
> > any time. No need for base-time to be multiple of cycle-time.
> > 
> >> Also, I don't understand what the workaround achieves. If the "extend"
> >> feature is similar to CycleTimeExtension, then it applies at the _end_
> >> of the cycle. I.o.w. if you never change the cycle, it never applies.
> >> How does that help address a problem which exists since the very first
> >> cycle of the schedule (that it may be shifted relative to integer
> >> multiples of the cycle time)?
> >>
> >> And even assuming that a schedule change will take place - what's the
> >> math that would suggest the "extend" feature does anything at all to
> >> address the request to apply a phase-shifted schedule? The last cycle of
> >> the oper schedule passes, the admin schedule becomes the new oper, and
> >> then what? It still runs phase-aligned with its own cycle-time, but
> >> misaligned with the user-provided base time, no?
> >>
> >> The expectation is for all cycles to be shifted relative to N *
> >> base-time, not just the first or last one. It doesn't "sound" like you
> >> can achieve that using CycleTimeExtension (assuming that's what this
> > 
> > Yes I understand that. All the cycles will be shifted not just the first
> > or the last one. Let me explain with example.
> > 
> > Let's assume the existing schedule is as below,
> > base-time 500ms cycle-time 1ms
> > 
> > The schedule will start at 500ms and keep going on. The cycles will
> > start at 500ms, 501ms, 502ms ...
> > 
> > Now let's say new requested schedule is having base-time as 1000.821 ms
> > and cycle-time as 1ms.
> > 
> > In this case the earlier schedule's second-to-last cycle will start at
> > 999ms and end at 1000.821ms. The cycle gets extended by 0.821ms
> > 
> > It will look like this, 500ms, 501ms, 502ms ... 997ms, 998ms, 999ms,
> > 1000.821ms.
> > 
> > Now our new schedule will start at 1000.821ms and continue with 1ms
> > cycle-time.
> > 
> > The cycles will go on as 1000.821ms, 1001.821ms, 1002.821ms ......
> > 
> > Now in future some other schedule comes up with base-time as 1525.486ms
> > then again the second last cycle of current schedule will extend.
> > 
> > So the cycles will be like 1000.821ms, 1001.821ms, 1002.821ms ...
> > 1521.821ms, 1522.821ms, 1523.821ms, 1525.486ms. Here the second-to-last
> > cycle will last for 1.665ms (extended by 0.665ms) where as all other
> > cycles will be 1ms as requested by user.
> > 
> > Here all cycles are aligned with base-time (shifter by N*base-time).
> > Only the last cycle is extended depending upon the base-time of new
> > schedule.
> > 
> >> is), so better refuse those schedules which don't have the base-time you
> >> need.
> >>
> > 
> > That's what our first approach was. If it's okay with you I can drop all
> > these changes and add below check in driver
> > 
> > if (taprio->base_time % taprio->cycle_time) {
> > 	NL_SET_ERR_MSG_MOD(taprio->extack, "Base-time should be multiple of
> > cycle-time");
> > 	return -EOPNOTSUPP;
> > }

I don't want to make a definitive statement on this just yet, I don't
fully understand what was implemented in the firmware and what was the
thinking.

> >>>   - Sets `config_change` and `config_pending` flags to notify firmware of
> >>>     the new shadow list and its readiness for activation.
> >>>   - Sends the `ICSSG_EMAC_PORT_TAS_TRIGGER` r30 command to ask firmware to
> >>>     swap active and shadow lists.
> >>> - Waits for the firmware to clear the `config_change` flag before
> >>>   completing the update and returning successfully.
> >>>
> >>> This implementation ensures seamless TAS functionality by offloading
> >>> scheduling complexities to the firmware.
> >>>
> >>> Signed-off-by: Roger Quadros <rogerq@ti.com>
> >>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> >>> Reviewed-by: Simon Horman <horms@kernel.org>
> >>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> >>> ---
> >>> Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
> >>> v9 - v10:
> >>> There has been significant changes since v9. I have tried to address all
> >>> the comments given by Vladimir Oltean <vladimir.oltean@nxp.com> on v9
> >>> *) Made the driver depend on NET_SCH_TAPRIO || NET_SCH_TAPRIO=n for TAS
> >>> *) Used MACRO for max sdu size instead of magic number
> >>> *) Kept `tas->state = state` outside of the switch case in `tas_set_state`
> >>> *) Implemented TC_QUERY_CAPS case in `icssg_qos_ndo_setup_tc`
> >>> *) Calling `tas_update_fw_list_pointers` only once in
> >>>    `tas_update_oper_list` as the second call as unnecessary.
> >>> *) Moved the check for TAS_MAX_CYCLE_TIME to beginning of
> >>>    `emac_taprio_replace`
> >>> *) Added `__packed` to structures in `icssg_qos.h`
> >>> *) Modified implementation of `tas_set_trigger_list_change` to handle
> >>>    cases where base-time isn't a multiple of cycle-time. For this a new
> >>>    variable extend has to be calculated as base-time % cycle-time. This
> >>>    variable is used by firmware to extend the last cycle.
> >>> *) The API prueth_iep_gettime() and prueth_iep_settime() also needs to be
> >>>    adjusted according to the cycle time extension. These changes are also
> >>>    taken care in this patch.
> >>
> >> Why? Given the explanation of CycleTimeExtension above, it makes no
> >> sense to me why you would alter the gettime() and settime() values.
> >>
> > 
> > The Firmware has two counters
> > 
> > counter0 counts the number of miliseconds in current time
> > counter1 counts the number of nanoseconds in the current ms.
> > 
> > Let's say the current time is 1747305807237749032 ns.
> > counter0 will read 1747305807237 counter1 will read 749032.
> > 
> > The current time = counter0* 1ms + counter1
> > 
> > For taprio scheduling also counter0 is used.

"Used" in the sense that taprio needs to know the current time, correct?
But by that logic, taprio equally uses counter0 and counter1, no? For
example, for a cycle-time of 1.23 ms.

> > Now let's say below are the cycles of a schedule
> > 
> > cycles   = 500ms 501ms 502ms ... 997ms, 998ms, 999ms, 1000.821ms
> > counter0 = 500   501   502   ... 997    998    999    1000
> > curr_time= 500*1, 501*1, 502*2...997*1, 998*1, 999*1, 1000*1
> > 
> > Here you see after the last cycle the time is 1000.821 however our above
> > formula will give us 1000 as the time since last cycle was extended.

Wait a second. You compensate the time in prueth_iep_gettime(), which is
called, among other places, from icss_iep_ptp_gettimeex() (aka struct
ptp_clock_info :: gettimex64()).

I don't know about the other call paths, but ptp_clock_info :: gettimex64()
doesn't answer the question "what was the last time that a taprio cycle
ended at?" but rather "what time is it according this clock, now?"

I still fail to see why the taprio cycle extension would affect the
current time. Or does TIMESYNC_CYCLE_EXTN_TIME extend the length of the
millisecond?

> > To compensate this, whatever extension firmware applies need to be added
> > during current time calculation. Below is the code for that.
> > 
> >       ts += readl(prueth->shram.va + TIMESYNC_CYCLE_EXTN_TIME);
> > 
> > Now the current time becomes,
> > 	counter0* 1ms + counter1 + EXTEND
> > 
> > This is why change to set/get_time() APIs are needed. This will not be
> > needed if we drop this extends implementation.

What if the cycle that has to be extended has not arrived yet (is in the
future)? Why is the current time compensated in that case?

> > Let me know if above explanation makes sense and if I should continue
> > with this approach or drop the extend feature at all and just refuse the
> > schedules?
> > 
> 
> I am not sure if you got the change to review my replies to your initial
> comments. Let me know if I should continue with this approach or just
> refuse the schedules that don't have the base time that we need.
> 
> > Thanks for the feedback.
> > 
> 
> 
> -- 
> Thanks and Regards,
> Danish

As you can see, I still have trouble understanding the concepts proposed
by the firmware.

