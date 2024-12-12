Return-Path: <netdev+bounces-151463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B22599EF6D9
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 18:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCF7E1899DE4
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 17:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BE62144AD;
	Thu, 12 Dec 2024 17:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fioZx9sP"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2051.outbound.protection.outlook.com [40.107.20.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D73205501;
	Thu, 12 Dec 2024 17:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734024035; cv=fail; b=GSJe7ooNgmcOb4dKgRj0mMZeXKZq4ltJeBmOOr4vZjzABVSqCmodObehq9vHreaW02t/rfdBWDsWXGbi+jNNP9VjwRUvY9xftoHAbwNJVwWT609nL1J57mw6GDrYdlTPr58BNpBxxkoFsh5/+mXLOkr1yc6G1A+j9FqXl/RDLqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734024035; c=relaxed/simple;
	bh=hQ0UIeFxBcscW8sPl4UzVWJPr8J3mEeVLEro0MeqEFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Wf6dGcjW7OEUf98z66sxCCtwWngerkR21E7Wo4wLxfZl2nUw3EwhTEe0+yXtWA63k6dffEireW00OK7r5TB72/aU/9nWnYMXQ2pIhXFJIHVJ2SmRCdsAemO1Fp364kLDoD7wicRH6pU8uYhAsaNHsNMYQtitNqEaSMa2KQrtzt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fioZx9sP; arc=fail smtp.client-ip=40.107.20.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qC6TLfuXPUm/Fbv04cnAu2GkbF9TuAelVpbROknuvYfOIAP9gDQSBiN7Ehkecc4Puyu+eoJ4R1ugtSDa76ME7vEBzMJ31h+C4r0rNEhz9inPmnRqqxjWq023KdFUVANC2Xo42uMJfcvP410E5GcWmoBEDbUSwIatWZ7G+kbRXtxcEorGeBhMLttOk0ukfmuhEYgxBATWhpRkNxPX1EH4tIY0qmude9b0kt/LTCDwK53Xpmt7ihdVkAzd9kLpbJDUXrNFI8GniqXHrc+upSA4nuY3xOIRb6iJJtMTKM2AMmDsgB4r3IfgO7nvKic4VWSpaO/g0Xws4Rnl7fIUmOWhhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7zGxeCqPgoLqqebWL+vT0386AcK7KLqEXnVwLav59fA=;
 b=SkXMN6PUGBaUM2yv1px0cxsgF4w8TonGgr7Fbte9Byy7q6EUHZ/R6mXqpA9ve73Xkmefy95gfUcIJoWi73AWAk9l8W7/wpWvSuzn5J+Ltso0l7m8hB/XrhECy43XqIgFFL9BqnnDBdDlXETC7hrZbI3cqupL1uZW0V6swOlkBcAZJ3dcScNVm/sOeoaAMoLuxFYDT6nQ5gN3XaWgf2DhBkhEIgAhtN1tM6XXUckOOY63ciyMxsSK+Qk5mBYAjrT1ZsvZTm0kJ90V9sWD/ZLX3Ii4E2mnYHvkgcGug07c9P+m+cHGEP0uuG/fg4nJdKZpJI/mythNAuWncHFV3xILtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zGxeCqPgoLqqebWL+vT0386AcK7KLqEXnVwLav59fA=;
 b=fioZx9sPlhli1NVrsHxtzF+Z7K2A4Cr21Tog3OfUAstsUXguh+P1yTBMwIdpspCl9vEaHLyEqS5zGnpjpTnF4rKkfxGm1+x1VQl73/Os/T4spr9IudwD4oyXaYlROyXu0HEc5ZHu6HLnOQXg2nRBUKRhN7e8/CurOAzxw8UcK6cnrfJ6IC975mYO2aILDswCziAEx4fvsM+LO05Yu5DWK+Cx8IrY+ChuYN0Uj4y0T7FyoHmAZLN99xoT90PlCNdnap1zYotzXjt5P/07dVAybJNjPVjQVQpB7jIBVgEb5bxkJjFry99FnVIH0k7iOsDe6gYVFKK4tyfR4PLSO+NfoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PAXPR04MB8389.eurprd04.prod.outlook.com (2603:10a6:102:1bf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 17:20:29 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8251.015; Thu, 12 Dec 2024
 17:20:29 +0000
Date: Thu, 12 Dec 2024 19:20:26 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next] net: dsa: sja1105: let phylink help with
 the replay of link callbacks
Message-ID: <20241212172026.ivjkhm7s2qt6ejyz@skbuf>
References: <20241003140754.1229076-1-vladimir.oltean@nxp.com>
 <Z1sHtZXuOvJe3Ruu@shell.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1sHtZXuOvJe3Ruu@shell.armlinux.org.uk>
X-ClientProxiedBy: BE1P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:15::10) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PAXPR04MB8389:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ba2c332-8ef6-4d8c-cbfc-08dd1ad14697
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w3BE9lz0zjTTuR15NoCu3Pb0btZkygz4nUrn0vwISV0pG4BsqP7/c7HL3eRM?=
 =?us-ascii?Q?MPM9t5TNfCYp+fVsfIynehvH5FvwYgCjJIeTyW41lUOiYz8lDZX8BKBFMwBB?=
 =?us-ascii?Q?dnvRu7i+kOLFOFVIQul50JcOtyRg2XJVC+8BYCpqF3u0LLhy0+vO7meM5Wt6?=
 =?us-ascii?Q?L8KBGFnbjh2UQeLohVDHjk8OOFXe3IC0o+93QcHfmNJCGK7ShB0+D4ZxRULn?=
 =?us-ascii?Q?tD8D2RAaY2nt4AWkWoQpeDrbJ6cPkOD6FKPXe/bLNvAbXzVGKbqsA0MAFghy?=
 =?us-ascii?Q?YetvcLq19W/H1xFc7FZW8prot5p/QW3bI3p0KQx699hIY8qmHeXhZPVX2VHF?=
 =?us-ascii?Q?UzhlhPUEI2QqIWwxC3P3rLFH2Cf9HPVjzeOfnmwUnZHOxP9Mq6YvnWmxiqGl?=
 =?us-ascii?Q?6fBmIkDY2bloUmqq5YkHe2WD57T9ZgH+TRZNlufMGja5WSNJJiEIHH8Fvmj9?=
 =?us-ascii?Q?2gh1iawAbHAgXHS97OeoiwQwwHVDhvDwAyk6Zhd7Vt1hOr25YTnBKEtjvtTh?=
 =?us-ascii?Q?LiaTWz1G42HwGWbuSzFW8RsXT0n8NRX71EI+UGNuP1m1MmYkF88YJzXrwk+i?=
 =?us-ascii?Q?Zqxf8G6y9ZKhTUgJEPIYZBn0OzYJWC2NQX6jZniMvtEgEUwrI7Y0hdvOStFT?=
 =?us-ascii?Q?E2mONy2I0A2g6wI4dPi3nbSCNZQXGA96JPWyviTkalKlUtYaDcJZXr0Os7qH?=
 =?us-ascii?Q?AVoAz7MSvpY1OU+qulwHiprfL7rk7RmCNrrE89xgKLSCCh6W8yHXciZquQEu?=
 =?us-ascii?Q?sjHngjKgAlE6avt7Lp1AYjIKrVic4e94g4jmdLr8KBe4E5CIIcOHE/pHP7e5?=
 =?us-ascii?Q?APo0S/2R1rB9OrPH0g8So5LOQ+8QujTaE1CQtd0RtMxA4qeRDrW18nfokw7q?=
 =?us-ascii?Q?fTw5BBEMS/Hj6GzPKhzhn6Va/C66ePkjm12YvhWKFOa4cKhAAy4ebLpqIB9X?=
 =?us-ascii?Q?DFdTofmGqozgpOBeWNcQPE2qN+Ia+Q0hLYkD0Ha0OUJ17tVmCmxxl6ol5HFx?=
 =?us-ascii?Q?8KtQTs55/r6EKT4eg2K96+AJiShGRy+jXZJc/8h+0NHjLd+VhUpgfncGIxYa?=
 =?us-ascii?Q?DmFPKHYAA0U0CPMHVdoE3+V9LbfXD8x6BRMmoIROBD3INE9nGC3ZJyZc3BoU?=
 =?us-ascii?Q?aOztMEu2jynYBRDNR0WvlK1YuMqXMb+HUgHf+rB/u97krT1hi6zuOGw/tyCL?=
 =?us-ascii?Q?pluIgfy23BwIpCLQQCxa6sNi1IQG2NVn54YAuxrrONxXtiz6iFqpzXbL4jx4?=
 =?us-ascii?Q?OH73X1Nh8GXIT4aJ5As/fqdL2htTIy52Pqandl2ysA4wnr0elR7qjH78ae4x?=
 =?us-ascii?Q?iDFHv3s8uJhIehdZshdswhzznCPHinXubrKLK0rvAjya1w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1IM80UeHpjic41n26zDvzEJUvmBD7k2vAeWlx5WqFRt3+sH4Tv2BUXAWOt1l?=
 =?us-ascii?Q?N8LCXLoeGvVI8Jmbd2N68mW9NCDKtcRx+azhOhoKpEkekYqf1vTqJlJDY5sw?=
 =?us-ascii?Q?FSsyoJHWvi7PXYtyFY3dDmQaJJOpoY0clxnR+Ikn/HcuxkCgAYktkvJy9hcb?=
 =?us-ascii?Q?e2QhhaYRnnU2UugNaKq3ogl+hi3eLI8e5/bzhAhFCQe3dWAeLS7d1ToMuXba?=
 =?us-ascii?Q?yGJ/qUEpG15Lf9FRcOYMbw0yiCLMJz9CvEnyp5kZoY81OQvs3AOh+WNvoOOh?=
 =?us-ascii?Q?BcPSLGXA1Ec0LjG9VCB0DaOSrQNADSPsYDq4uZo102dQ4emwTI59/QSPasqH?=
 =?us-ascii?Q?xGTwpzeg6vjC3dMekVrKiYDx8iNoeyAvuJm5sM72eDq4T5Qct1cSCJlqq7Ft?=
 =?us-ascii?Q?hP+Lxyyd03kZR8IeVZV7Kxi7BpX9/ynt9RvBi67bXi1hXUN9qahkM34QfmJN?=
 =?us-ascii?Q?oKaoMY/1osEI4Op1xNwYcIcz0Q3r7YIz/I9dKtaxdYyIsUPmT7cPuzKa3Ea1?=
 =?us-ascii?Q?6NHQMf3pUKrQvVfWiS04KFnc6aoGKnGJojnha3a9cYN2HCg9gsNDS2eQ6SqR?=
 =?us-ascii?Q?41MpzxC6ScSg+b7d0XiaLb97XbIThrmVjVpAAD8zGvXw152pzl8a0cVqyOMB?=
 =?us-ascii?Q?3tSxeYMPx5cXy2I1jFUl2xvPhPNNFdTVx6oTbGyutyBstlm2h6FBq7aWz5l5?=
 =?us-ascii?Q?kJqjNt+pLaProsx2oj1SW3mRlDOBKw9LEH3/cQya3f6nD1vhTtR8ycnWLihd?=
 =?us-ascii?Q?m+jEYZB/aTwCtUlYpMgxLrfhZJsnSdJsg/x5TLhz/gFvIKo6FRw8RWQh+dR2?=
 =?us-ascii?Q?9/gqhyVvpAHK067dgj6QwAmQQfSE1i2NBanYwqdcgQsuYbWzOcgm/jJ7pQHh?=
 =?us-ascii?Q?14X09OsYjkcEGtrWbgJxAf69ZJEYNFFqEszAADQrlpKWYliBLR9pW/IrL8u0?=
 =?us-ascii?Q?V4zrsOZrKWYjjpDJPJ/+roKIINsDTiEMgehy8z9RbBeES847kIMZYQz9FbQb?=
 =?us-ascii?Q?eQN9IG4HJT+ukS/rhuAzmtTei1FpAPFEIdpxRVAyR7+88XhDQLPnuidtuV83?=
 =?us-ascii?Q?l7PF5vaJgJnJXx3cPzAiATEKVfD8gIRX7YJG7+umEDEM85gQKZXp8yVS5geI?=
 =?us-ascii?Q?sEsqmbjJLuj1IaIIHit46VYeutoRiRrO9ZkUsaA1m81uSJTX++YsEKSwaovP?=
 =?us-ascii?Q?hNMO4RxLTm7Zz9osuWJx5HVp7dV4m6ND17zSHdT+KDOAiv3BI1hnuvyv64Cm?=
 =?us-ascii?Q?O1I62DcrAvwgxtNAPRfyD2ZxpJPR6p9YCoENrEQcoYe3HsoUgbDcS6dEwD6d?=
 =?us-ascii?Q?dcxXbafBszSO3MoNUX/obRaZ8XCY8SFYmDCxnQANuxtmg6fNJEsvZrALIetA?=
 =?us-ascii?Q?liBjSgHWrf/GWFJRBivw0/tDGABh0Pi0JKDjuB+scadg3jE7WtI1Kx450r9H?=
 =?us-ascii?Q?QN32FXtdXNw7zKH/rsHcgDb1bFbrr3cWkYGVVkPi3mUoGmBLFCAofNvATG9C?=
 =?us-ascii?Q?L1E014ZmgR2dtxfBi+Ji3WRtMP19Buw1Iqyr4+12igM6x3s0hfPQEZGh35zz?=
 =?us-ascii?Q?hYbl1oL4IjL5wgSS0ZoKkk+kosLRBbH7IjnDwSdTTQh/f9DVCNWGnOGrxF6o?=
 =?us-ascii?Q?fA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ba2c332-8ef6-4d8c-cbfc-08dd1ad14697
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 17:20:29.2372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PT5q5OOFzMjxW47rmRg16fXT2OAX5e0LelU6w8FjEtWGLBFFPG07I6rN2sNhEIqJBhKSUOQIQcZbv0pN56GdBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8389

On Thu, Dec 12, 2024 at 03:56:37PM +0000, Russell King (Oracle) wrote:
> On Thu, Oct 03, 2024 at 05:07:53PM +0300, Vladimir Oltean wrote:
> > sja1105_static_config_reload() changes major settings in the switch and
> > it requires a reset. A use case is to change things like Qdiscs (but see
> > sja1105_reset_reasons[] for full list) while PTP synchronization is
> > running, and the servo loop must not exit the locked state (s2).
> > Therefore, stopping and restarting the phylink instances of all ports is
> > not desirable, because that also stops the phylib state machine, and
> > retriggers a seconds-long auto-negotiation process that breaks PTP.
> 
> However:
> 
> > ptp4l[63.553]: master offset         14 s2 freq    -896 path delay       765
> > $ ip link set br0 type bridge vlan_filtering 1
> > [   63.983283] sja1105 spi2.0 sw0p0: Link is Down
> > [   63.991913] sja1105 spi2.0: Link is Down
> > [   64.009784] sja1105 spi2.0: Reset switch and programmed static config. Reason: VLAN filtering
> > [   64.020217] sja1105 spi2.0 sw0p0: Link is Up - 1Gbps/Full - flow control off
> > [   64.030683] sja1105 spi2.0: Link is Up - 1Gbps/Full - flow control off
> > ptp4l[64.554]: master offset       7397 s2 freq   +6491 path delay       765
> > ptp4l[65.554]: master offset         38 s2 freq   +1352 path delay       765
> > ptp4l[66.554]: master offset      -2225 s2 freq    -900 path delay       764
> 
> doesn't this change in offset and frequency indicate that the PTP clock
> was still disrupted, and needed to be re-synchronised? If it was
> unaffected, then I would have expected the offset and frequency to
> remain similar to before the reset happened.

Regarding expectations: I cannot avoid having _some_ disruption, as the
hardware doesn't have proper assist for this operation. It's an automotive
switch intended to be used with a static configuration programmed once.
Offloading the dynamic Linux network stack is somewhat outside of its
design intentions.

The driver measures the time elapsed, in the CLOCK_REALTIME domain,
during the switch reset, and then reprograms the switch PTP clock with
the value pre-reset plus that elapsed time. It's still better than
leaving the PTP time in January 1970, which would require the user space
PTP stack to exit the "servo locked" state and perform a clock step.

I also haven't actually shown the post-reset output when it has reached
the steady state again, just a few seconds worth of ouput, that's why
the frequency adjustment is not yet equal to the previous value.

There are ways to further reduce the convergence time in real life systems,
which I didn't bother to apply here, like synchronize CLOCK_REALTIME to
the switch PHC (to better approximate the leap missed during switch reset),
or increasing the Sync packet interval (SJA1105 is frequently used with
gPTP which has a Sync interval of 125 ms, here I tested with 1 s).
It still really doesn't compare at all to the disruption caused by
alternatives such as dropping the link in the PHY, or not restoring the
PTP time at all.

> Nevertheless...
> 
> > @@ -1551,7 +1552,8 @@ static void phylink_resolve(struct work_struct *w)
> >  	}
> >  
> >  	if (mac_config) {
> > -		if (link_state.interface != pl->link_config.interface) {
> > +		if (link_state.interface != pl->link_config.interface ||
> > +		    pl->force_major_config) {
> >  			/* The interface has changed, force the link down and
> >  			 * then reconfigure.
> >  			 */
> > @@ -1561,6 +1563,7 @@ static void phylink_resolve(struct work_struct *w)
> >  			}
> >  			phylink_major_config(pl, false, &link_state);
> >  			pl->link_config.interface = link_state.interface;
> > +			pl->force_major_config = false;
> >  		}
> >  	}
> 
> This will delay the major config until the link comes up, as mac_config
> only gets set true for fixed-link and PHY when the link is up. For
> inband mode, things get less certain, because mac_config will only be
> true if there is a PHY present and the PHY link was up. Otherwise,
> inband leaves mac_config false, and thus if force_major_config was
> true, that would persist indefinitely.

Ok, I certainly wasn't careful enough when analyzing the existing code path.
If I understand you correctly, you're thinking something like this should be
sufficient to avoid depending on bool mac_config? The diff is
incremental over the change posted here.

-- >8 --
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 3dcd1f47093a..893acab0d9bd 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1712,20 +1712,18 @@ static void phylink_resolve(struct work_struct *w)
 	if (pl->act_link_an_mode != MLO_AN_FIXED)
 		phylink_apply_manual_flow(pl, &link_state);
 
-	if (mac_config) {
-		if (link_state.interface != pl->link_config.interface ||
-		    pl->force_major_config) {
-			/* The interface has changed, force the link down and
-			 * then reconfigure.
-			 */
-			if (cur_link_state) {
-				phylink_link_down(pl);
-				cur_link_state = false;
-			}
-			phylink_major_config(pl, false, &link_state);
-			pl->link_config.interface = link_state.interface;
-			pl->force_major_config = false;
+	if ((mac_config && link_state.interface != pl->link_config.interface) ||
+	    pl->force_major_config) {
+		/* The interface has changed or a forced major configuration
+		 * was requested, so force the link down and then reconfigure.
+		 */
+		if (cur_link_state) {
+			phylink_link_down(pl);
+			cur_link_state = false;
 		}
+		phylink_major_config(pl, false, &link_state);
+		pl->link_config.interface = link_state.interface;
+		pl->force_major_config = false;
 	}
 
 	if (link_state.link != cur_link_state) {
-- >8 --

Not worth it, IMO, to complicate the logic with yet one more layer of
"ifs" for the pl->link_config.interface and pl->force_major_config
reassignment. It's ok if they are assigned their current values, when
the code block is entered on a transition of the other variable.

> > +void phylink_replay_link_begin(struct phylink *pl)
> > +{
> > +	ASSERT_RTNL();
> > +
> > +	phylink_run_resolve_and_disable(pl, PHYLINK_DISABLE_STOPPED);
> 
> I would prefer this used a different disable flag, so that...
> 
> > +}
> > +
> > +void phylink_replay_link_end(struct phylink *pl)
> > +{
> > +	ASSERT_RTNL();
> > +
> > +	pl->force_major_config = true;
> > +	phylink_enable_and_run_resolve(pl, PHYLINK_DISABLE_STOPPED);
> 
> this can check that phylink_replay_link_begin() was previously called
> to catch programming errors. There shouldn't be any conflict with
> phylink_start()/phylink_stop() since the RTNL is held, but I think
> its still worth checking that phylink_replay_link_begin() was
> indeed called previously.

This should be fine, right?
-- >8 --
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 893acab0d9bd..c9fb0bb024d5 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -34,6 +34,7 @@ enum {
 	PHYLINK_DISABLE_STOPPED,
 	PHYLINK_DISABLE_LINK,
 	PHYLINK_DISABLE_MAC_WOL,
+	PHYLINK_DISABLE_REPLAY,
 
 	PCS_STATE_DOWN = 0,
 	PCS_STATE_STARTING,
@@ -4070,7 +4071,7 @@ void phylink_replay_link_begin(struct phylink *pl)
 {
 	ASSERT_RTNL();
 
-	phylink_run_resolve_and_disable(pl, PHYLINK_DISABLE_STOPPED);
+	phylink_run_resolve_and_disable(pl, PHYLINK_DISABLE_REPLAY);
 }
 EXPORT_SYMBOL_GPL(phylink_replay_link_begin);
 
@@ -4093,8 +4094,13 @@ void phylink_replay_link_end(struct phylink *pl)
 {
 	ASSERT_RTNL();
 
+	if (WARN(!test_bit(PHYLINK_DISABLE_REPLAY,
+			   &pl->phylink_disable_state),
+		 "phylink_replay_link_end() called without a prior phylink_replay_link_begin()\n"))
+		return;
+
 	pl->force_major_config = true;
-	phylink_enable_and_run_resolve(pl, PHYLINK_DISABLE_STOPPED);
+	phylink_enable_and_run_resolve(pl, PHYLINK_DISABLE_REPLAY);
 	flush_work(&pl->resolve);
 }
 EXPORT_SYMBOL_GPL(phylink_replay_link_end);
-- >8 --

> Other than those points, I think for sja1105 this is a better approach,
> and as it's lightweight in phylink, I don't think having this will add
> much maintenance burden, so I'm happy with the approach.

Thanks, this is encouraging. I'll continue to work on it, and then clean
up what's left in sja1105, as mentioned in the commit message.

I've retested with both changes, and it still appears to work.

