Return-Path: <netdev+bounces-228241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3A9BC57D5
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 16:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63675189B9FE
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 14:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4612EC559;
	Wed,  8 Oct 2025 14:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JMEpd98T"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010062.outbound.protection.outlook.com [52.101.69.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D496C2EC097;
	Wed,  8 Oct 2025 14:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759935359; cv=fail; b=GudQJhYSY34MWhPYegOWBUITQPhTMoVv3itsEFZTnHVPgBebhaPDc3IfdfBbJy0MPS3a+f0Y2rmub4PIvbSqjsex+fJRp24k8yH/cX7Rrr4Va6WIoLmKrspP2D7sqwblG96GxNKgc6+MNENCuKyQcEcxcpdp77aa4K6w5JYAytk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759935359; c=relaxed/simple;
	bh=Cw9asU39a1N/8jkgIFR4Js573dbEw+VU9ZJSpQGBzFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EviTA4EQlnYEtUIj6zHd4PulOsapld4qY1p/0f6wk2azMzRBTttscmguo+9zLlaqgJLzuiIVqbn8aPPaXLPPjoL0yMz30hC0/Tki1tRMw6BLsS/CxaQo8B1WW090HasfnMklA/jSmR3vQwfLYp7SQ/xii5TOqxkDs7v0ZJDNAeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JMEpd98T; arc=fail smtp.client-ip=52.101.69.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aPxDhhsl1n18VtoYkHB1jhbcHXmVptw3+ch8i2oWfS44r3JLvMG8g0Y3q86bdv5mhnRUG1Ui4gN+iMlKSEbdUV3Zbw15V1hpfVuDwCk+GRMU/sWJrjhdZxyR6cEPPw/eDRMB3QTDMMof631nucyEhv1fSMzFvnGMnXJ6dNqWroAWa8WX/RbXM6lzyaHyZzC67+WNVhg+/THr8KXW1wloH0nv0QTOG4gU86ZSc6KGQOvxGF4SWNfpxP1swpC8HpQAvluqtf9L70VB0BZAcP6dz05LjBQcGZcRh8xl/TPYD1nNVbGLva7bFM+pc3khw4zkQO4hWxmemLBImFiuQjlrkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ulDnZGVOcr6J5GyPgGf5AU/M6jxMAo/iify5nIkSK8=;
 b=icchsEGCOrZGoAvR0Sy0p/arErXtkzV1ni34dRroy1VH0JQ8FP5mw6X+k6bof2Jiu4YQsR/nuql5JzKZ2MUNmmIgD/IeEf4J+9k4YeraburRIp3hPaF1gxyE7MVOXxUqwjMINR2ukPMYFq0+nlz++52GB1CtLEpxSG112vg2/AsrJ5gWLOhq7RyRtXkidHr/8Oo3Ae3FQPXIleY16ojnJzSeePzv0a9VOSJSmNY7KrrXWvQDw90VSYv2EsZL/mCt2rdpAMx6qZGB3IxnrHJXpXu3IJsGu18wg4SQ1tpXidrEc4DuLbORu+RPu4pB/3QHsnVyKjW2CkojNU41zM7a6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ulDnZGVOcr6J5GyPgGf5AU/M6jxMAo/iify5nIkSK8=;
 b=JMEpd98THttt0LIaoUk1wwjRIHO22Tc1wTMxS/ji0QySWUpEddQyV5E+z+fsqzQ9KBIAUrDpo2pdU5FGteKEGJQVlbMDtS0C2X0Mv33W6iv75p7wRKPI2T4DAGtd6U6NL+R/iqO9KFd1ifJwGrzi4tNQbfdljL9o++3eRw2YVQJ2Quc8/bGiBHqaNcidXj/Rdse6rycbmdL4bvWh7AypRJCjQWtreDSn1b+S73dkkMAiBl6MUwubrrsG5lxcpdV/k/UuJD/lWjgzRgFDl0gEdJjdlIpbbd7y54ZD3e96qkD4gT7P6B9ln81ylh2GGKAaM2Mdx0U7212LkPA1bqC7kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by GV2PR04MB11445.eurprd04.prod.outlook.com (2603:10a6:150:2af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 14:55:53 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 14:55:53 +0000
Date: Wed, 8 Oct 2025 17:55:49 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Aquantia PHY in OCSGMII mode?
Message-ID: <20251008145549.6zhlsvphgx62zwgp@skbuf>
References: <aK7Ep7Khdw58hyA0@FUE-ALEWI-WINX>
 <aK7GNVi8ED0YiWau@shell.armlinux.org.uk>
 <aK7J7kOltB/IiYUd@FUE-ALEWI-WINX>
 <aK7MV2TrkVKwOEpr@shell.armlinux.org.uk>
 <20250828092859.vvejz6xrarisbl2w@skbuf>
 <aN4TqGD-YBx01vlj@FUE-ALEWI-WINX>
 <20251007140819.7s5zfy4zv7w3ffy5@skbuf>
 <aOYXEFf1fVK93QeS@FUE-ALEWI-WINX>
 <20251008111059.wxf3jgialy36qc6m@skbuf>
 <aOZm52L7k2bAEovF@FUE-ALEWI-WINX>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOZm52L7k2bAEovF@FUE-ALEWI-WINX>
X-ClientProxiedBy: VI1P190CA0002.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::15) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|GV2PR04MB11445:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e23a538-6e91-4af7-1c2a-08de067ac6fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|19092799006|7416014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N6A+oNMbQ7sbHFOxjmoagRjnDvo04feL8b7r5/UCV3xaGW/semOjsmWgoMfY?=
 =?us-ascii?Q?uEBvr2IphvgaulOVYCXuLiMVXIoS/EK0oP0+GPxaXEKa/9cbPIMjgZzd+pYC?=
 =?us-ascii?Q?3tfq+XXcw3NQ9LsCkaJgVuIYezKb4+c6s3Op1g3But696O5pdRCiJHRYeXmn?=
 =?us-ascii?Q?mzZypVuRWDBy/eft5BJ7KOqwg0PiB25wtkyALVub3gnTA8ajDgeEw61CGiAz?=
 =?us-ascii?Q?Hu7DpDZ6sZ2tWZTBol8yhGs9WI+gYWIil3/NCn8hWDzDHLBCcKhahC4beZ9L?=
 =?us-ascii?Q?l/BODXjQDaqQfHEfumTbhU9VxcVzNSpoza6zr6XCW6veA1rfAbcln5Ti19Ij?=
 =?us-ascii?Q?7wnpqEWHt+moz+WWHl8lfQyo6G91YAtOw18cYID0weVrpSgWi3A+dM74xLZo?=
 =?us-ascii?Q?CReCTg3Mw4hcRiI8hwXfh10SAFCbGCRotxaK6P7R5+f1EpJRjKmBG2jsOL8Z?=
 =?us-ascii?Q?tlpmQYaLNl99r85VEX6YUyoxYWcqOU8J0ADg3Vc/nvGPtYrOoAaMOPdzupyD?=
 =?us-ascii?Q?xaIKGQFud/7k575OxiWdT2PVWAdZMWn90chppTWBBgAsgBLA+ZisjhUyw4Wn?=
 =?us-ascii?Q?XeMkHlb6zS34raLCwZjykgV4LJ4yzZt3nY7GBDs+QlQDCpo7YgUtUXl9S77W?=
 =?us-ascii?Q?bEUrcypm/AhGvhJCvl7EUe4KbX0oBO9uYhVRQ7xm09kEA1Gh2iVAVmGy5mlE?=
 =?us-ascii?Q?oPJ/bAbR5E3i+oYV8or40nGDmOwCpwd9QTwS5w+p4/0YgpadWO6A/HT7euoX?=
 =?us-ascii?Q?FyrLWFCK9Mf3tNqNQeeyymqaqsOBMp93elfpGtpR/tMApI0U6+2SPRHXEI79?=
 =?us-ascii?Q?AX8GrWYwachc4iAsFWAW23mfHJFPtooVEX3cRDMJmYOruaCCscqhz5FKBBrp?=
 =?us-ascii?Q?adyYInSM29zL3waTnBI7sjFHVvDXENZs4O3ApRjupa3Gj4547UfCmbG1Akg0?=
 =?us-ascii?Q?EKBI3Nzyo4KB5YZHsvcZ2M8tZ2H/+5dcj+Xod8BkwkPE8Y/WrVFvv2h/1eL7?=
 =?us-ascii?Q?zhmvD01Uj4VES0m582HkU9Rs35aBfXJuf48Dn5T3FIBUafLKzqBzHA/8/soS?=
 =?us-ascii?Q?0OITb/3F/UJ43wfH/KC7Wo0Dzt/plJMlSymhQnFanNgUfL4R9Qg+ulzBx/Sq?=
 =?us-ascii?Q?Qso+Dv+yQca4K9i5pMFAGv0P+5rB+mw1/DFOF9PeChLtcxTPUfER4GSmHw28?=
 =?us-ascii?Q?E4KGWcDf21uWisdMe6KnATjlzd09TNxHQ6s2bGfGdqXPHr2GvbdUY0SLEk2S?=
 =?us-ascii?Q?kE8aUBswB21GFWkEFTUiiKTQuOcY8p5ZCrMrfDtlNz+2A9AkMZ59U/EuRdqO?=
 =?us-ascii?Q?EsmAp9oIAOAycoGtgTCW6I3QhZ9e3sjK13I9KFaHYc1nc5ssU4K9+tTr0vi9?=
 =?us-ascii?Q?wUAKJC+M45H698UADLhsgEKKw/1ZiPUHmyTxmD5Vj2X8GfmXAy4XdPeO8ElT?=
 =?us-ascii?Q?VDnLrV8iAGJh87lvx91Dp207nsXvZoey?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(19092799006)(7416014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2bhEozHVhKqO9LRDHF4hmvV53U/+pQDWGH+G+e7mYACqQfC57Im+DSwKi8gp?=
 =?us-ascii?Q?rXmZDgNWlYKb08A3dmQ+74wtm9P4Mxn05qhrljaALCzXPxHmwdJteqmtbmyH?=
 =?us-ascii?Q?kLe9XchaBNFws8CjuJvi7GDAgOwBzghRs6VPc8fG4OVnV3976RiyC9ISL3x7?=
 =?us-ascii?Q?rpndSGcX412eLzX+gUCL6PrIiFv5Tcrv9CkCURP8lQIngNHRpq+qo+CC+6PV?=
 =?us-ascii?Q?ciZJii2yNUJgsYPb+RjTIfhGwY4JOBJCHjzg7ZWrpCl/0FidjQMAhRUYjE1e?=
 =?us-ascii?Q?fAqBuy2tveTQmK3MZu9oSueXhtpvZMd+2z7YBckhSxORytbC1YovbpMolH0/?=
 =?us-ascii?Q?eS+dtOjF3rVqOBjZeJZ3d+UHq9WD0vLz7L5AWV4g5e8RRxLNtZupdTZOlbDR?=
 =?us-ascii?Q?oKqeQ8uQOscQkCmyRDffiXLQ3sBZWWudh7RCj6YJ2brjXsI8mL7UB3VP4AIg?=
 =?us-ascii?Q?frwYgojGysveORV2aBQ26xr8NZ5IatfWByrlrixFNB5zGIu19TmDybXdAKWi?=
 =?us-ascii?Q?MIAB3hQ1wgNPxgk4WNvIBpYewMDRnycbrXfJ3H1LvkOxhA10j0BZXrrppiY6?=
 =?us-ascii?Q?/sFXaufWRlosOt1EeSQD6JIZY6nzPZup2JrEm6L++OeZZ5zh1wZO9VNwW/xK?=
 =?us-ascii?Q?j7fvf6QCS3cQV2pnWAXcZPLrchvV9qYSdKif6IqG8kyiJj26MMg8pnDq9+Q1?=
 =?us-ascii?Q?ChwAp0kPmx1pxnZu39/EPejCdT/OWkbPxx8zRFmQ4WSqttmHdaxPAjwQeEOj?=
 =?us-ascii?Q?YTOjsspXshBkYGXPVHnwoJt7qEkPISh+9sjgbVbE3PrQgytxoB6yWQXGOUXm?=
 =?us-ascii?Q?n0+dhtlEkqR8jVQrJ+epqTBtTVvkmY8qaMj9URK4mh26gygyGwfPSSKEutSG?=
 =?us-ascii?Q?j1myeZEBX/3P1JXplHct5TWzMkMnFm6RTEj90AIGW1bTvUXqjzGrA5MWkEWL?=
 =?us-ascii?Q?+Y+bSrfjLuJx2iDMCXOkWnXfKao84lHpKw5eokOaT2Jr2i3CB/ag5DgYAim9?=
 =?us-ascii?Q?/F0TjbZIYpUBS2MkGrIxFYcd9qfcqSbB2wEHhqG8WST5YLxh1/YdjTFMXD0b?=
 =?us-ascii?Q?I2ZKo39uXmPKu8iz+c5hGzO6JJ8n56kjnHCve4EZdwG6FsFQN81Fa0bXeWuR?=
 =?us-ascii?Q?bl6bQPNGSdY7IHp3QRqObKPP7RkZgRypgIJCOztKv1WLtHWHcPKKlUqdNMyj?=
 =?us-ascii?Q?qezWknj4t/k9GaQhPoCobw7HyuTLWOrbpdkYXySYX17tu1QTS2+hbablfZ9y?=
 =?us-ascii?Q?uweZ1hllLZPR0wvMIE8ZsUwfkxP5lJbzNSWHzqPki+SW0xG5elHWN5MP+/4Y?=
 =?us-ascii?Q?P2ktrhT5Pwgjb+A5cQW4z3b1Ws/vg8hhNMj6k0aZogv0nk7tVZTB+Fh/P8Os?=
 =?us-ascii?Q?GGxidsP6+ygSjEseZ3DwzJc8vo6NEixJlW0LPcsSJZ52uC1zhhDnzapqYXlY?=
 =?us-ascii?Q?gIJ2ylMbvv76r1JrNaElnzVHnQMCvEMAq1iWbK2jYvN2MH9FGykhSZh+AW+t?=
 =?us-ascii?Q?Rfj+18SVbXWGXm+Q3ctnasOa5LBDhbrhE5W5KtlJy0SYHOUHGBFSR/vEJHnD?=
 =?us-ascii?Q?DxpcJx4TTCzWsrcWaO9kq+52s8wyuZiHdukE+dX5qyI/4vrv7lAkHZNMtOkD?=
 =?us-ascii?Q?EYsNcZGRSzZOzeTG/sJ6uUMixB1hZw3dPjzghYnTJAZbkOp2pyDiDMrnOLTK?=
 =?us-ascii?Q?omruxg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e23a538-6e91-4af7-1c2a-08de067ac6fe
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 14:55:52.9694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FTDzLJxiDbXtYrRo7iaMjHYKPV0RqKX+cavb8xdER1vG56ms99QTtx9ZooYfxQhHQZ0KR28w0A+mRWeQlmj5sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11445

On Wed, Oct 08, 2025 at 03:28:07PM +0200, Alexander Wilhelm wrote:
> I have the broken 100M link state again (IF_MODE=3). Below are the debug
> details I was able to observe:
> 
> * With 2.5G link:
> 
>     mdio_bus 0x0000000ffe4e5000:00: BMSR 0x2d, BMCR 0x1140, ADV 0x41a0, LPA 0xdc01, IF_MODE 0x3
> 
> * With 1G link:
> 
>     mdio_bus 0x0000000ffe4e5000:00: BMSR 0x2d, BMCR 0x1140, ADV 0x41a0, LPA 0xd801, IF_MODE 0x3
> 
> * With 100M link:
> 
>     mdio_bus 0x0000000ffe4e5000:00: BMSR 0x2d, BMCR 0x1140, ADV 0x41a0, LPA 0xd401, IF_MODE 0x3

Ok, this is why I didn't trust the print from lynx_pcs_config(). BMSR was 0x29
in your previous log (no link) and is 0x2d now. Also, the LPA for 100M is
different (I trust this one).

We have:
2.5G link: LPA_SGMII_SPD_MASK bits = 0b11 => undefined behaviour, reserved value
1G link: LPA_SGMII_SPD_MASK bits = 0b10 => 1G, the only proper value (by coincidence, of course)
100M link: LPA_SGMII_SPD_MASK bits = 0b01 => 100M, PHY practically requests 10x symbol replication, and the Lynx PCS obliges

So the AQR115 PHY uses the SGMII base page format, and with the IF_MODE=0 fix,
the Lynx PCS uses the Clause 37 base page format.

We know that in-band autoneg is enabled in the AQR115 PHY and we don't
know how to disable it, and we know that for traffic to pass, one of two
things must happen:

1. In-band autoneg must complete (as required by LINK_INBAND_ENABLE).
   This happens when we have managed = "in-band-status" in the device tree.
   - From the AQR115 perspective, SGMII AN completes if it receives a base page
     with the ACK bit set. Since SGMII and Clause 37 are compatible in this
     regard (the ACK bit is in the same position, bit 14), the Lynx PCS
     fulfills what the AQR115 expects.
   - From the Lynx PCS perspective, clause 37 AN also completes if it
     receives a base page with the ACK bit set. Which again it does, but
     the SGMII code word overlaps in strange ways (Next Page and Remote
     Fault 1 end up being set, neither Half Duplex nor Full Duplex bits
     are set), so the Lynx PCS may behave in unpredictable ways.
2. In-band autoneg fails, but the AQR115 PHY falls back to full data
   rate anyway (as permitted by LINK_INBAND_BYPASS). This happens when
   we do _not_ have managed = "in-band-status" in the device tree.
   The Lynx PCS does not respond with code words having the ACK bit set,
   and does not generate clause 37 code words of its own, instead goes
   to data mode directly. AQR115 eventually goes to data mode too.

I expect that your setup works through #2 right now.

The symbol replication aspect is now clarified, there is a new question mark caused by
the 0b11 speed bits also empirically passing traffic despite being a reserved value,
and in order to gain a bit more control over things and make them more robust, we need
to see how the PHY driver can implement aqr_gen2_inband_caps() and aqr_gen2_config_inband()
for PHY_INTERFACE_MODE_2500BASEX, and fix up the base pages the PHY is sending
(the current format is broken per all known standards).

Thanks a lot for testing.

