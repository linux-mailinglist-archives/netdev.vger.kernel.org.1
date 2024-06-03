Return-Path: <netdev+bounces-100239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E158D8497
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 16:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BC571C21915
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 14:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFD812DD9D;
	Mon,  3 Jun 2024 14:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AUBAebJl"
X-Original-To: netdev@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2087.outbound.protection.outlook.com [40.107.13.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E8712DD92;
	Mon,  3 Jun 2024 14:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717423568; cv=fail; b=nyLh5Xni3TJLtl7lt7smcM76ER6+60v0oXSTa4mn1s+RZCubmQfx/50lu7w7mHOOubxVHS1MWBNWBoyme9zN3veUQ5Li7pE9O3+tpgdYJwzAZdn5udVqj8ND5df5wlTtYD1YPTHoAeNguNJEZ0lyFwXuNmc1Qt2ZdrpxHO7+uc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717423568; c=relaxed/simple;
	bh=H4122ts51rq6xf8tw3avuay8zhiQ1FuwJUM73lmboRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jmESY2F41e2A8QOLxjjUCSA7K1v7nDoHNAiQDOEcjcdVOcDM74arT+m0YAEFZbh/Xoye6YkatCSvyRI/BZafGLk5nGEVwBWpT1KsapWs+SdTS7ACJoIoHZNsLxhHNjgtbPGHqupAXerD4ajmWErJDZgQjOVLpH25YWrrC4+iqQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=AUBAebJl; arc=fail smtp.client-ip=40.107.13.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nlrXmjZm5X40Hq8KE+3mL/4nrCw67F1RZMmGrHuccOrEozte3I7hoxSURhGdfsUr6VzpHTRICkRFodSiQkTI4ankvWxaR/DrI4hKWSZhhbLnVvIXOpR0FvTcbLQ/3rP73e6dLnQ9QPoqAoEcz1MbmMsrm1ifkYigS1/oru52W7a+K7lqCkOwPQuJSlxUkz8dCwp60TGd23TmippYTHYxbgug6lO28hKuD49HoCXL9WWKd+yNcmo1U1wYY6Gfaobx7sOtYnI51EqB3E5Prie227b5idYv1k7hilE2bG6XvCjTIKTPGGbnqV0VMzqdWFcCsx2tSiiviWmty3SHP0kErA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q+TmaNeolPNcRYxryylsatlr/fIONDS1WSzO0D14AoQ=;
 b=B9fPJDaex7/mqwYjM0rP1PrdXEvoIwMIP/yx7XXzrwxujagzN5g7w+trQfRDUrylHkKyw42lIFmKVbDq6Gbn/OnpNykipwMQl1CNSfkNjr+3+PPe7mIYPdwQEhnFKIav1erizVa9tMyyrSPlN0A9wGplmD1TxgDSjJdtuV1R12tSVepI50hfDwuxglyNAo8IocLW5/eJXXeEMRBY1+7brng/hA5Ek4Okr2MNiqwTNHnkYxXZ5uXmz7nSOteV1jMLL000/fxCWL6CaBYLqVYEck48cFOY3+GY5pp2swPiMoNJ08k81HE7ZSbGMD0vMTKN3T3r3O6E7orU0kC3Cg6y5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+TmaNeolPNcRYxryylsatlr/fIONDS1WSzO0D14AoQ=;
 b=AUBAebJlBZ5+FLiBoteVZusX5BW/HmWtNS90xZJh7oevlfKeLV/f7qNpCQjqGsEhBkC8neBePguC71NK9ioV1rE5L7axjDeFYPHodfyVACez6O1VS/SmBggx1QuF3eG7SbzqkxHIau2k5OTJyawOJeSzGfZdegF/ly/fRzgA/6g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4551.eurprd04.prod.outlook.com (2603:10a6:20b:1a::24)
 by VI2PR04MB10571.eurprd04.prod.outlook.com (2603:10a6:800:278::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Mon, 3 Jun
 2024 14:06:03 +0000
Received: from AM6PR04MB4551.eurprd04.prod.outlook.com
 ([fe80::5b1c:9249:b225:f6fa]) by AM6PR04MB4551.eurprd04.prod.outlook.com
 ([fe80::5b1c:9249:b225:f6fa%5]) with mapi id 15.20.7611.030; Mon, 3 Jun 2024
 14:06:03 +0000
Date: Mon, 3 Jun 2024 17:05:59 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>,
	Diogo Ivo <diogo.ivo@siemens.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Roger Quadros <rogerq@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, srk@ti.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH net-next v9 2/2] net: ti: icssg_prueth: add TAPRIO
 offload support
Message-ID: <20240603140559.krc6ap5qbltutsvj@skbuf>
References: <20240531044512.981587-3-danishanwar@ti.com>
 <20240531135157.aaxgslyur5br6zkb@skbuf>
 <20240531044512.981587-1-danishanwar@ti.com>
 <20240531044512.981587-1-danishanwar@ti.com>
 <20240531044512.981587-3-danishanwar@ti.com>
 <20240531044512.981587-3-danishanwar@ti.com>
 <20240531135157.aaxgslyur5br6zkb@skbuf>
 <9bcc04a9-645a-4571-a679-ffe67300877a@ti.com>
 <9bcc04a9-645a-4571-a679-ffe67300877a@ti.com>
 <20240603135100.t57lr4u3j6h6zszd@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603135100.t57lr4u3j6h6zszd@skbuf>
X-ClientProxiedBy: VI1PR0202CA0003.eurprd02.prod.outlook.com
 (2603:10a6:803:14::16) To AM6PR04MB4551.eurprd04.prod.outlook.com
 (2603:10a6:20b:1a::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4551:EE_|VI2PR04MB10571:EE_
X-MS-Office365-Filtering-Correlation-Id: f1a3ba35-89e8-4b3e-4332-08dc83d64d97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mMwFvd2WcyIDNuMIuvAs5YIcpsULjidUWxv2fJWls7AxblcbC0nkd0zTqLoz?=
 =?us-ascii?Q?C7Hh/D67WBT6UIFwub5hNV1U3aD2MU7f5ZloEV0WI091Q/iIGlujGbe5ZK7L?=
 =?us-ascii?Q?Dr4KXZSoKy1a3tL222KNUKT3atyAEyQUnE/vhFw0QndvxDp+kBusQ5lR5ssI?=
 =?us-ascii?Q?foN3cq/p2FX034EO+R2QvRVpD9XyQuUk+WspsWj9VctIawtLr/Mu2f6jEZJz?=
 =?us-ascii?Q?FnvPZ5gZhWJSttJkQRdeMPmXRiM5oJ+5G5F4LYCvKu98+n+4fM8f5MdWgdys?=
 =?us-ascii?Q?wG899CqdGsU3+yV4ANJEEan5dTLeX9J/MwuYzvrRrzabfNpnm/5X3Z2I67TB?=
 =?us-ascii?Q?QxEX30Lk5dhG+lwvkqvBpUCXh3x4VovCMfIv+1G7jPGhn8iMiH2ufnGa54ZP?=
 =?us-ascii?Q?W96A7WKE3JxxP504IF9ICZB4guArHhzJhRAuGt+T+WnBbQXIEGsZcOcm+gL7?=
 =?us-ascii?Q?WT/9fLB/EsrDO1TropuquODsFsXCmzP/N4TYR4jyDUZUNF/GzA53qOjJFV2h?=
 =?us-ascii?Q?RDtXmaRPzcSFmLHxNdRNTaoeIBK1QHakVGUW4/ESH7tOwlm8JSU1hNs1wyNY?=
 =?us-ascii?Q?rMOh9x9XZOin2SVdVc+gQ4PIE71vjgqavlOxTAPFvunQIRMCr2rt79OyCiC3?=
 =?us-ascii?Q?v6a7qmFTPz8kkfL4amxj1bYn5oaXeq/rT4X1ftxlP852Frj3nKMqQdDSnRPc?=
 =?us-ascii?Q?x/AXzB8NS/50EHONuKwafnWQO+LJQpknliKXIhG8D4PrChjUzQLdvItNeD82?=
 =?us-ascii?Q?wYa9rTyle7enV1zO7AXeLKKLEy7WJg+Pp6/Z9rLvQ6WhCBTVg5nrlNkWhItK?=
 =?us-ascii?Q?+1x9jwiP9laRVD9MoXz2bS537ublDMpNSmBmU3dwkv331DUtm9cplVK6KE2K?=
 =?us-ascii?Q?29bRLkQi59ww9f05fTdI9u7IL9QayXT0/2jbeJcZqiaqze2eAN2qjqtSqqGR?=
 =?us-ascii?Q?Wsly+ZWm1n2ZGBsdolmDGay6s0MT8MzJDJSSYlipyzOGJaa4IyLgLekNjETw?=
 =?us-ascii?Q?sRx78HOH4NZJ1qoPGhzuRHJvVeZespqjxy9v2NqAHb3elrP/JRHfxMQUXD1T?=
 =?us-ascii?Q?e39o7Qge9YFKZveTgkAc2RouHIJkfv/8OE/ln3T1++83LGCUBIhsqXCBe8k1?=
 =?us-ascii?Q?kCNIKmDzefUOmo4+YSFCqxnkZ2IDhww9y77EOWMIp/ShYDwgGqxFu5ADWRk+?=
 =?us-ascii?Q?ValoYhSVkJRh3XjZYqXbyXlejTTU/7fwU1rfow7sfNB+yFHlrMjwr94Yi1x8?=
 =?us-ascii?Q?ZDjdd1uG8tDp0p+Nc5jE5q3hy/Is6ibvD9aRBbwiOg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4551.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2hECoWV2KGY03SKSO1FyDvA7CN5/LZssEc+4qTH1Z7ojtikkM8Fucu+RrvCG?=
 =?us-ascii?Q?qfDrx31TVLI7BFri1CTzh+DVLQt2Abi1+f8N9mcqPpq065WULOIhHt5rVA+Y?=
 =?us-ascii?Q?FuGPBZP0rOl6cDSzGAi8MFavI4H7IvYjhHHYYRcLb2DYBesJn6C/1ty3kVB7?=
 =?us-ascii?Q?+samfaiZw2f4KCQqs11AECDmOEQqErGrcdnxywP0r4RavJHXB/AnbYWbI8S0?=
 =?us-ascii?Q?ru+5sEsoJ4THFdPys5+ZRtiK4Rgagc/qmegEPfemQPYJOx4w/G//vPFLfZjF?=
 =?us-ascii?Q?RIM771q6FZwpTbSf0CbuZd0aEbEH2lT++ovvlgy74DNHThe88zZBw09Mf+Uj?=
 =?us-ascii?Q?EuoYwVoJP8rQLyV/yXWPk8tfKSK+1p6RRnY7cFjkhgshTXCtRLrTdP+sFffG?=
 =?us-ascii?Q?P2iFqFrOVHC2yJ8UEtbYx4ICg0v2mwTbREXT9VYxCsksgbyUAO1fP6ggI6nN?=
 =?us-ascii?Q?0s85X6aJpvlXamyRpvqXm48PgYmtqRAqyd5ZCcbdFi7pTVWnQDPMf3CXeO+g?=
 =?us-ascii?Q?zCqHPkuCa7xEzOa1jD5Le16jEdbNd9clmgqlxepwVHDWz5x++OfGkGIFJ67q?=
 =?us-ascii?Q?xYLIUeOe0cEi1KUh/JDncxLw1vOi3k0bcu8f7fVTUunBlTchBcKK+2Jw6DgL?=
 =?us-ascii?Q?41ZXs3hRm4nT4TD6TTsJ1KorvymAtzH7cPpkVhVkXj28+i4ONvVUIQlDAqzU?=
 =?us-ascii?Q?0DJdrkAPNh6R2dJlZ1N8ISlcULOl0buq5kDCyJVqff0KLYIQlhZtAXg4yDEB?=
 =?us-ascii?Q?4t+EAJg6eKmGaMQ5vwIKpJ2qJeUlqIMc1BA31yaLmHnnAqLALXyeBwWIqNBq?=
 =?us-ascii?Q?15O+0S3Ed2ucCgoi0BcBdvHoN17cXX8SfP3OeEAiWqfVL678MQNnDKfgjPTq?=
 =?us-ascii?Q?Ki+8uv1IoQYh+mvgyVy0RiKk/mbwyAsmWrngyDRTH3ZSekUSsA7aSzG5DGiU?=
 =?us-ascii?Q?yk60fhXjUt6Ypg3H5LbFunAoqq6UdCGicZYdLy8Ic6Gy0Ub0m9/qo+aiRGhh?=
 =?us-ascii?Q?wybuKyjWz1Jndxp7qPg7IgZ2wbKuoZ45ZhhpRPWweSZtogXOUmvsPPaTajri?=
 =?us-ascii?Q?x+cL8tN975U0B3Ep2JTtY52JW7fanVoGuRf63LslHUTboprfq0FAYjWrCx2s?=
 =?us-ascii?Q?/Jux4/n30IAeY3fKRsgwRR3kiJT2f+A3Q5yRNgDEbzHKv/nQwms+yj/n0Ehv?=
 =?us-ascii?Q?/WnvGgF2KKzRZ+8pHoSBXQek1z5tsQGseUCIjpblD+GTmlJ/KXedmlwXTWCe?=
 =?us-ascii?Q?GvLkhSf/wceVZbWep2dZvRtwetKyKZxAVn7kKqKCvcfLs0RddhRhFp+/GOIB?=
 =?us-ascii?Q?owsVQ576rKNLPmc2UiB78eYOlfLgmuU+03Fwh+e883xiE2h1Bbu7HkNOYN6Q?=
 =?us-ascii?Q?33aXlD4W2hFlaQjNfFSBDqkSGvisOO3MQZRfRzKodAoxoRSYEKCvdSE98q3p?=
 =?us-ascii?Q?fYwWV7MqCmnnhDD0qSro0HicGeok0+drpm6cRyMHImDEysFSOZdqTEEG3xe1?=
 =?us-ascii?Q?IcxzFb/GnO3EyKNBU02qV4KxwkDMNuaQlSmNQXF4/kPt4w3ojKNzpW0xt4dK?=
 =?us-ascii?Q?AlcdoCQtMNCw52NCW/duNM4ikKq4yigfvc/TA6CTsHVrNAe48wZ9uyMX1/+U?=
 =?us-ascii?Q?hQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a3ba35-89e8-4b3e-4332-08dc83d64d97
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4551.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 14:06:02.9671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bGsbtDcl+vJdwdXF/lsSSgPtSIFeMC8fpnDge0U38Tu1nzjuAR7wGtXKmzRu1oCMMFffQ7hMzsEAbhipQF9vdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10571

On Mon, Jun 03, 2024 at 04:51:00PM +0300, Vladimir Oltean wrote:
> > >> +static void tas_reset(struct prueth_emac *emac)
> > >> +{
> > >> +	struct tas_config *tas = &emac->qos.tas.config;
> > >> +	int i;
> > >> +
> > >> +	for (i = 0; i < TAS_MAX_NUM_QUEUES; i++)
> > >> +		tas->max_sdu_table.max_sdu[i] = 2048;
> > > 
> > > Macro + short comment for the magic number, please.
> > > 
> > 
> > Sure I will add it. Each elements in this array is a 2 byte value
> > showing the maximum length of frame to be allowed through each gate.
> 
> Is the queueMaxSDU[] array active even with the TAS being in the reset
> state? Does this configuration have any impact upon the device MTU?
> I don't know why 2048 was chosen.

Another comment here is: in the tc-taprio UAPI, a max-sdu value of 0
is special and means "no maxSDU limit for this TX queue". You are
programming the values from taprio straight away to hardware, so,
assuming there's no bug there, it means that the hardware also
understands 0 to mean "no maxSDU limit".

If so, then during tas_reset(), after which the TAS should be disabled,
why aren't you also using 0 as a default value, but 2048?

