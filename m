Return-Path: <netdev+bounces-205004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B20FAFCD94
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 16:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 643321885070
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 14:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0F22DEA82;
	Tue,  8 Jul 2025 14:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jvKKsGdf"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E332C7E9;
	Tue,  8 Jul 2025 14:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751984851; cv=fail; b=dQiMDxW5qmwHk+9+o2FLkVFi1dfWrvm2V+I+h3asTLAQ0nXnXquAt+pb1DW3/SmXH8vYjiV5OquOMcjENsRqqLYsbshRQJNdZg+pHEnf1NRof3T1iLytA2KH/xdcu6VDemHFdzl2LKlIMiw3GlhPvZmjB64Jseh7LmMnsis+7Dw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751984851; c=relaxed/simple;
	bh=YyjWtv92cO8yOc4c4RSX26bLcgkxFKwhCDzOYBWgkxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rEdFtDB6aq8GLKkMU525ZxzcKSs3EOqWKS3y1GV+Y55RpLLsAyc+S/0ZEqx2OZvYRo4OU1NAXTJXvC+8O20Jf5AGS20QyOTpcyVCNRF+lDWZiZGOgVKl6PUHeSfDOz24xFQcjZzTPIrYcM1P54hipIFDXYzV4MldIuuXKuuDgv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jvKKsGdf; arc=fail smtp.client-ip=40.107.220.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OPoCldWJBnIgK7i4bZyTsLH8wMr6C0zacaB5DBZWSGhV0KT8ethgtowaFj/zsHqqQJVKuB/W4HIvz/ZaNi0KVNHGGv1m7wf7fIv5lVptsmHrlXOFr+VzNYvLj6uym0L52Bq98nKlDroN7XAzyh3mUSw9auoZzyx7FB9q9WHAmfbU1EUVnu0rf4UAKnzbId64PkrxaGfhMcUwmfiqa+qPNPwxlR5SL4+SF2BRyXZyibLlTQtBfqM0VSyVqhAAL0caLIK0lW5d44F/7bPSQCOjCr8/S19VH+IeU3f7Z8aaZgq6OolqYZE3CHs2aBGD7mj2MIfibFvJrR38tdlNgstkaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xo+KsLskK3xIn1iMpKyTmHv8mk8DVAuhW1Reht7tDKQ=;
 b=CrJj5GytYjLchzpSLgJBBljy+XX/lS7GJu2yXWH8+Jhzonfa+i3l0UAxfga8UPUEVihsbXmk+kwoo2E3VUWA3J+UqSR+8nENyHHsv5xCxzNK3DU6jLvW4sZrI+xgltIjTTTQA1mTU4mcXz3Exi7px9itox3nps5U0V0UhqgnH/tHsPSzNcP41a+xvyiyvHoJXi8+uQUO+hVkvPcNKV9LGb+w432FKj9f9aSl/1Z1P9VjtlEox1ZmjoLkxwziKgy6B9JR7P+roPUHZQfNz3tAjQm5HW63DofKrI8TIcqW8LpDgD8EQN2Mrwd3NUcp7JxXItwQz9HT9TnP54snkVWwCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xo+KsLskK3xIn1iMpKyTmHv8mk8DVAuhW1Reht7tDKQ=;
 b=jvKKsGdf4Uymb1O1HTSNKL8V0cBAKDQlTsP7rmo3XIfoQ5+/ivvFSB5JxJ4vxQJKbihcI/UNq8k3zZYDHPfdsVWQL8Uq+nnVzPNhlvYYm6kfDEPEEErrTkjRKtb5XN01dT4Ebivb8+z08N6FJVKadVZUrWZRfgRAgVnknn95IOEDZCrmBZrLFx4CGYdGsr7E7wPeee/wnf8dh8lwwa82fuHsmBGKdQI/snkxux9SpYqN93CmHeCDU9zBRi+lNYW4HeS+5Fohc5dyp0Kg97vm+FkLXTfQVOS+Ix9QoAm7HdEo+6vFSdrBQL8n2N52WMQDYt+ncC0EHJAUzhhwDMfoNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB9038.namprd12.prod.outlook.com (2603:10b6:8:f2::20) by
 PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 14:27:23 +0000
Received: from DS0PR12MB9038.namprd12.prod.outlook.com
 ([fe80::7106:f1be:4972:9438]) by DS0PR12MB9038.namprd12.prod.outlook.com
 ([fe80::7106:f1be:4972:9438%5]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 14:27:23 +0000
Date: Tue, 8 Jul 2025 14:26:54 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Pavel Begunkov <asml.silence@gmail.com>, 
	Parav Pandit <parav@nvidia.com>, Jakub Kicinski <kuba@kernel.org>
Cc: "almasrymina@google.com" <almasrymina@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Cosmin Ratiu <cratiu@nvidia.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next 1/4] net: Allow non parent devices to be used for
 ZC DMA
Message-ID: <fszmowhndjnms4dyqt2nvnoisoml27e3eddbxg3pwgqrkywpop@g7u75aair6la>
References: <20250702172433.1738947-1-dtatulea@nvidia.com>
 <20250702172433.1738947-2-dtatulea@nvidia.com>
 <20250702113208.5adafe79@kernel.org>
 <c5pxc7ppuizhvgasy57llo2domksote5uvo54q65shch3sqmkm@bgcnojnxt4hh>
 <20250702135329.76dbd878@kernel.org>
 <CY8PR12MB7195361C14592016B8D2217DDC43A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <22kf5wtxym5x3zllar7ek3onkav6nfzclf7w2lzifhebjme4jb@h4qycdqmwern>
 <c006f353-8b35-43c5-b010-d058954ff993@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c006f353-8b35-43c5-b010-d058954ff993@gmail.com>
X-ClientProxiedBy: TLZP290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::12) To DS0PR12MB9038.namprd12.prod.outlook.com
 (2603:10b6:8:f2::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB9038:EE_|PH7PR12MB5596:EE_
X-MS-Office365-Filtering-Correlation-Id: 54a311a2-26e9-4d40-e1ef-08ddbe2b8dcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m59FPXOx5JYq0o3BZonoJVba8EyKMgsh4MSvOuofE9CgXrr8DJMCliB6j2BI?=
 =?us-ascii?Q?Tc+Xpy+tjA57EETm0VTtyUQjh/u2o9BML4FzWRRB1OTspCTI0tya9MgnR6cS?=
 =?us-ascii?Q?zrYEayC0/lNLvaFXTJpS5Nw5ulujiL1u1QLZ9Ste6tFXh6GkJnQU2U17cYDI?=
 =?us-ascii?Q?ljgmouR1imJdvaHtd9mY+3Fo51xjXJrg0DsB6laL0IJmU2FuXeGYT7Gbj2RF?=
 =?us-ascii?Q?8nB3lGFYWQJiZFCptUVG4kkpeUTnx/gNYoEXAiSzYIkxAKb5J8wI+Tl8G5o7?=
 =?us-ascii?Q?DRJ69m7tqTZK9HH6Hw/UFGjq9OtFOd4EUGmetkxHU3DCUihtkK3i2NlIbp+D?=
 =?us-ascii?Q?3T66lDeQ52ght6P3o8jzJBYTzaP9RkdL9q63MIPUw9ESnG+9/k5pTpknXOxV?=
 =?us-ascii?Q?fjRIayY9VVMLsh+VELpKGQhdcV4gMVPumPY/eVf9ZJ/IgD3mAemhXHhoQO6E?=
 =?us-ascii?Q?5zdbsYk38yVnrVWedsAfR6Y+j9v2+u1Sa4HgTQBST9y05H9POEH7R8bDrOX8?=
 =?us-ascii?Q?oEtWEPzEdhOaPNAR72RA3GsxbyJ+E8JflXOJMYxoNO46okskMQ6Myh24dAKR?=
 =?us-ascii?Q?5ISCP+xWHijZiwT1Ny/gH/Er4hpldtUVON6jM8zdfeMcKZ20Je9hSzljnMQp?=
 =?us-ascii?Q?H2ZN6qwP3dAJJvaN4e+GwTNRrHci6Xp3WqF4xz3A0TqCH7e07pF3sT6GdSZ4?=
 =?us-ascii?Q?0io+p99VWMJ43rQxC2Df/LXz0O6kc1L0NCsUI2TByKU5nxbiWgRm/onkNKrv?=
 =?us-ascii?Q?WWnn5hI5b+4gvhOLL11rJ0tIZ2NgL+pS6nIINFrxOS9zou/9QK8yfKjWoAwa?=
 =?us-ascii?Q?e7GP59CUl1dZEWmwyyuwOrqsX3Xtid5NEwZK0RmU52Ixz9T6Ba2QzFqqYLjU?=
 =?us-ascii?Q?mEfRZT/Dh+Tu8kY5By2cHalCOHnlNP5oCOgteA1nnG2IigyuAz/rVbHPe7ny?=
 =?us-ascii?Q?eN7V3+o7PgZbT5nFmE+ICs9SWJIiL4Ur68r3+UQ/HKSKPFG8yhlhu/F0J9hn?=
 =?us-ascii?Q?ROk0rklFK9L9OhNu186K4MoIlPdJNw78nIpTDyzxljkOfgYb9hI3g4D6YA5s?=
 =?us-ascii?Q?mkfOg6PRr3pjs+u7Pp0Knu3RB5oCoRfJNzhBpam3mHuPouJBiDM+C3WTNssS?=
 =?us-ascii?Q?AVanM/hVbgSRFu50OTVQGSdFRWHh/khrtKt6easo/g+I3guaMSGDpjgLvGSq?=
 =?us-ascii?Q?79SuaJwEE2TmxAHHJrAaxqI6eLRt4UNtVCsXA8J4Mt6qxYy15u5sci7pJYe8?=
 =?us-ascii?Q?qJCOGfbXu1osXNLXerNaKDO2GFcjECzfI4TIJF0EuhUM5VHxIH130Yi0GpRw?=
 =?us-ascii?Q?h3PIfvDDKImnlXTqO5xzmw2lWFMwJR3/MFDMAEV6jN42Y+qth+rJKa2dsc01?=
 =?us-ascii?Q?fxRsEDOd6+vRgPF9lNBglVbvUorZDtYGi+XDrzaC5ZjlYWbCytZh2aLtB3il?=
 =?us-ascii?Q?05nyketomZc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB9038.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i1KQw72xVuUaUZLpCY87op9tq+1dsFk5yTtNZMCOf4fXcBWDe2M9qABnY7hT?=
 =?us-ascii?Q?CHbZgAJ9z4zxIaDWXcvAMJjMyQjCmz+WowoTjFip4e5YrNQRnr/ZovsJNRpz?=
 =?us-ascii?Q?xTt7UzUdnMNENqabPqmrhXsTf1ow81yPZzUhAFyvqz+RXeCp+fDG3kE2/ese?=
 =?us-ascii?Q?2QOw0InYn8fgdoHfm/6KjZyCelED9M0ekVIF36HDZSsg52BSl6YV3EUniJaQ?=
 =?us-ascii?Q?mMYlgD5C4rA22tEuDuB2rAahn3A5hK7+XNsojXKiv8ayKpU37K6Ocl/KGqwu?=
 =?us-ascii?Q?RW0XatiAE6HFj2B1T71IrMcPBeizS60MPn3y7eYEMjKkeS4pLqhoxT0nAkJG?=
 =?us-ascii?Q?QmE6J3TgN+Siqv4wyQuZ0rwAhdOP2Gq/IF2YvKdiNCBKkpgz32RCiDNBdo2C?=
 =?us-ascii?Q?zK+pnwptHb/uJfZIXLjEkqOTEa3EEza6AdU5wlpZoQzMzjVtpbQgt8SRtJ15?=
 =?us-ascii?Q?q0hYm+rGl6iSE74MmXoCVd3mvydTJtZCg9d17d8mfv6qnqPgrcDnDaomqDGT?=
 =?us-ascii?Q?8iK+FvZtTBmU7hBQPJ1RFtdYiPpmUTFZUW7at+TITkUCst10VSMOELBFbCF/?=
 =?us-ascii?Q?JFPcQ9oG/ZeUIs17DQ9Bek3bqSXGeggq3yCHa+TqvysUwyXgvsB1g0ywVQpV?=
 =?us-ascii?Q?VC9oh23tuWXWQanmDC/z+0l7VU0x++VJTPQ72wSfunclvLDKjDzm8AOkX9Hy?=
 =?us-ascii?Q?QIJE8WvBtgwhUFz8v5WV+30jCzlAC6xP5Aou5zr8Tbbl74FM3k1yxU20y+6P?=
 =?us-ascii?Q?FLc/Pm6q5cKUVU2C00yg/zL9acMT79PrPUmpdTd0z7qGAlUBW6L38YrNnKxr?=
 =?us-ascii?Q?5BPEMumAcNAsBuzaYJrcaJ7PFOnF98ffr3WNwHKYR6/uNimM/yhyQsF3ztc4?=
 =?us-ascii?Q?ysRTsS4B/fyXYEfP3sCFHHWBv9SNOCJCIJnNulkF9AnryA2n2peUwHstIlT1?=
 =?us-ascii?Q?hAgfF7k+o/ALZghd6RHgLqx/RlVmCE6/mV/rVfaW07uz3xuO6I46iZmtO+3D?=
 =?us-ascii?Q?3k6V3mCSBnZ9xnKMyK9Db5z++XI6l0loUa1lspFqOzzCYcxxOgG276V0Lj6s?=
 =?us-ascii?Q?eYy/jBBPrk57YKMr4QyXjpNRjaBqXifEnMtwXDmDG5CHjtzhuOP5H63Zkzt/?=
 =?us-ascii?Q?TCu5zLE3ut/9JBaAes6IoXVcrJRWZvhmtOCZr8uP7xw4OmoBuzwo94utHm+D?=
 =?us-ascii?Q?U8jXnIQgfU+pw5NF+GS8rZzO02ZOuiTC7B7MrcIjK0ct/ykp3Qb1HsJcKjVl?=
 =?us-ascii?Q?ckOhvbIy99DA1ZyiZLWQFI0yF2Bi4JAdzUvdyC/iRT/JA9ROKjJQjRLOfe1v?=
 =?us-ascii?Q?GdLGUqgNrOkw4VDtHrEnAzoIHWWjV3B2zch+ndubA0fT8OuaNsw7KqDfBr9E?=
 =?us-ascii?Q?fjKKISu9StQokG8wCNCKPjrIphIHZ+nQt1NuA66EiF0/fD+kJFMWTVwItwXd?=
 =?us-ascii?Q?US9POT5+bzpFcRSUKBmHjMDjSLXHvRIEjv0R237wALYN7yuQuAn+7E14RWdy?=
 =?us-ascii?Q?lcd2yi4cYkIf2bN2MO+1SXr1WaryNB+hUIeAhWhVv7gn8RBcwPsxwiLu1OTJ?=
 =?us-ascii?Q?7HZ4IJ/TmtE/g/Zw78AvAl1qnR+ktFHvgtBEFbV/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54a311a2-26e9-4d40-e1ef-08ddbe2b8dcc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB9038.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 14:27:23.1323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fn2X67JJns/9eilWASayNqbAqFqeXc1EO7I0j7EQvsaeuaDxW+fa/6yCEQVEiL8/Ofydsu9c6xnK4HIU0rpj5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5596

On Tue, Jul 08, 2025 at 12:08:48PM +0100, Pavel Begunkov wrote:
> On 7/4/25 14:11, Dragos Tatulea wrote:
> > On Thu, Jul 03, 2025 at 01:58:50PM +0200, Parav Pandit wrote:
> > > 
> > > > From: Jakub Kicinski <kuba@kernel.org>
> > > > Sent: 03 July 2025 02:23 AM
> ...>> In an offline discussion, Dragos mentioned that io_uring already
> > > operates at the queue level, may be some ideas can be picked up
> > > from io_uring?
> > The problem for devmem is that the device based API is already set in
> > stone so not sure how we can change this. Maybe Mina can chime in.
> > 
> > To sum the conversation up, there are 2 imperfect and overlapping
> > solutions:
> > 
> > 1) For the common case of having a single PCI device per netdev, going one
> >     parent up if the parent device is not DMA capable would be a good
> >     starting point.
> > 
> > 2) For multi-PF netdev [0], a per-queue get_dma_dev() op would be ideal
> >     as it provides the right PF device for the given queue. io_uring
> >     could use this but devmem can't. Devmem could use 1. but the
> >     driver has to detect and block the multi PF case.
> > 
> > I think we need both. Either that or a netdev op with an optional queue
> > parameter. Any thoughts?
> 
> No objection from zcrx for either approach, but it sounds like a good
> idea to have something simple for 1) sooner than later, and perhaps
> marked as a fix.
>
Sounds good. This is light enough to be a single patch.

Will tackle multi-PF netdev in a subsequent series.

Thanks,
Dragos

