Return-Path: <netdev+bounces-214967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 877EAB2C4E6
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 15:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A879243CD2
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 13:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946FC340D8C;
	Tue, 19 Aug 2025 13:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HaE2AsxM"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011047.outbound.protection.outlook.com [40.107.130.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C75133EB1D;
	Tue, 19 Aug 2025 13:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755608752; cv=fail; b=t4SxMxavl7jbeea+isWlqVUV+a3LpwWGIekPvkdgRS04nd3zf085OLBWy5WpXBDxyH0X1B7IxYNTpeMHvrX5A7r0jJnLe3Hf5CJ7cjBUEv3Pg1cyV3/DV5/yz8jLuvmGfBd6uz0jADXbSa/5SKBGSSU0Zouh5WhR9lOJmI4b1QA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755608752; c=relaxed/simple;
	bh=oUTIjOZjNx/EGiX1xHbrM4HlxNMY/ipezryM6KTfzMY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ubkMu1KSzEbOr//pfSXYujjMyER/Jnsj3aWa6h98kShbzjsgtxnKHJyl27vvICrV2OWnFiKK1z3N0D5J3VBD/bn3rSoTZ00BtbUq0HIXDgZNpCBQ8quN3sKm6TOCsIr4JCYPwdwGkLGvaXjXnpuuCnsIkERvPnBPU1XThPn61XE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HaE2AsxM; arc=fail smtp.client-ip=40.107.130.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XpybZ0FlOHpKmxffy3h8buxJoHh6XaDAL5Slj2bgouMZyPgQN2Mq6D4Vod5qt5kgw2KA/zC5wcs+ETFeuavp6/Fp9VN8tFVbeJXjx+MNBZvbc/MkoPMf2x8FVvzdWFlyHH+UeZtYhg14MxN58QoXNbX5jWKJgA3IJbsWgTkX8WRus5NRmVlCBRwXUaNUkuAZkx9EwrZjDFi9GpS1wsEg8uaSO+ybJw4y4k7bzSFGRxfP/By0xgX0PN6uSOq/Ii+dsSspz8TeBmfwvW9F+xzDqMmyYLTrezpXXci2/xiU2zu99bOE71AiEzODX4COSIQi/xBr6DFz+3xcsBB0D71eEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8LWoBk5DX+xG6L9x8UqgXoedBH1tUmtGA3Yw3Xe0Hk=;
 b=OwhlvI+7hvob17DVDgNJj0sBcs7+er4DRRVN8NPBif6tCC/XysYM6Q40wlx9AZM/qV2laxMvJ0nP69WmCYZJLR9Ev2EnFBlw6fVFCO7lyC9VdoEYOI3b1qbVast7pIRAayR6SDjTOgZAVrJ5lc92Gw4NLrrNuMKvtmlW2BB2J9MUpOCCNCAJAZ6q3vpitpSYbUnr6w3DEp2cZmkAOYmtBO648BqV5+HcFbNW6fxvjHn0A/gLJutdslFcQozLGKrDzbWq8oI3kwCuJGSajOv7ZeyzUQBU2EaG8IlRrPNoY2r1cUT1CE9QWcax0WNFps2ueEv/0lzK9ekciBvGIABLaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8LWoBk5DX+xG6L9x8UqgXoedBH1tUmtGA3Yw3Xe0Hk=;
 b=HaE2AsxMWX4kLFZVO/ChjXxX4b8jzA+XQ3FGwUsFqo+y0GCBLuOXThCJoEmS3+oVqUKcbxStlMAh75DDJ6MI48sKJANO/NuYPSJp+rCHoBmWJZxUPVjCkwTfp+xtCYLntllMI5AMQpieW2EF0DKjf65PEvO0FKQtqYPPTqkXccoKvifi2tz2kZUVPb+JrFpqG6m94c7cjiSRsPxtH8GZ+HuUoiikG+D7Lik/2qyQuv09SV6Vw197zL4RY/Vr9r+YMrAac9M30M3wtUA+91mumj32bG86yym8l7DPmPk2g0zakx5On6jHKmMpyscZaCHPbOkdnqOJTDCLh+uJ0Vd8Eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DUZPR04MB9946.eurprd04.prod.outlook.com (2603:10a6:10:4db::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Tue, 19 Aug
 2025 12:59:09 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Tue, 19 Aug 2025
 12:59:09 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	richardcochran@gmail.com,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	Frank.Li@nxp.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH v4 net-next 08/15] ptp: netc: add debugfs support to loop back pulse signal
Date: Tue, 19 Aug 2025 20:36:13 +0800
Message-Id: <20250819123620.916637-9-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250819123620.916637-1-wei.fang@nxp.com>
References: <20250819123620.916637-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0054.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::23)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DUZPR04MB9946:EE_
X-MS-Office365-Filtering-Correlation-Id: 47e3d3bb-e4c3-431e-e42c-08dddf20301a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p3AEgD9Q2o9lB509Ul2QUeUWwi4YxG7LnA6vswszBURGL7mBaZ5jUT8pMkhS?=
 =?us-ascii?Q?E9r6vOAXDBCIKA2GWAYYmX1brKqW+o/DaiqY6KZ4qdA/Itu0eMmfXLRZeLJl?=
 =?us-ascii?Q?IZWZ5WrlO0ybrSPL7pl58i4vAMUhA0fjf463/OHH/EaDfq0FlnYooT6TqE3k?=
 =?us-ascii?Q?BGu9kf04R0j8LDw7+KLFrkzi16XHzQxnq11M6jUD1esmHv8x6dp9AbpEF0dH?=
 =?us-ascii?Q?TNxZul/3v2sjGNhH7SHEaVuv8LvjQE2p5KqsnoVk/kyrF4UXdtFgBEW27UYJ?=
 =?us-ascii?Q?mrBXzFeZ4YEV5VAPeiGqfAEWlwlicsQmrTXejwSgJUqWtgFSrqRuU1p/6Wsd?=
 =?us-ascii?Q?wp2IICPT3gCLQha17yWwGPfMvLPTwaNaV/qDz3o1+9REgFd0zFBVLjT4aPX1?=
 =?us-ascii?Q?C5hYFKu9drkYx0UEYxWjZPGyW6cPwqX5ksn6GugQu4mwQhbV79iuk609RVXr?=
 =?us-ascii?Q?ImarvvPpISEv1Od8DjJjkfjodpgFh40nYO2WYD1VXw4qnQAePPA7DIQnndx4?=
 =?us-ascii?Q?iN//jVs/HoVTbppLoyHjEShw8Y7uaNptqIMw3E3+H1rXDvTiD+UNjyH48yjf?=
 =?us-ascii?Q?odNwAA4CzgXYLJAkf2rkF2Wakx/1iuhmWEcO59iBrxRSgbjLvtAZoJ/TrKtG?=
 =?us-ascii?Q?EeOzki5v465IoxDl5jquhJdkpOk/6AumUxweHJk5aXIZd4d8hvtUilxUNJ/C?=
 =?us-ascii?Q?FU+FpMMM4KEM2mD4HUk9bGp0uXPgj1B2o3yUKTrYZz0gWFmw8KhkjMmwmj5j?=
 =?us-ascii?Q?/8Q42t8sOl+hZ/eVKlaK2gB6GEwspyJlioih7f6inVa5b8xWZE4EpaLc3Onb?=
 =?us-ascii?Q?wxgPujP+wpk3YJXnpSjNPIjONsG7IIgES8LGw23hOqDSQGz4SseiuJpyYZU/?=
 =?us-ascii?Q?L7rQIPtHP7I/qcUdjVoZRPi4iWVSHWWo4ySs8QtjIgJ1WNp6UwYdvtmDnuz+?=
 =?us-ascii?Q?x9EZ7jJLNc7snei/xCqvu2SkaY9fwUthhRIZDRo6vXMs/8xyEZItr25oNKWV?=
 =?us-ascii?Q?/BgK/uidD/E40NDMKy3u3ZtOwKN/CVyMIX8lrV9hEOSmIVAdqnEDrAyEAhU5?=
 =?us-ascii?Q?ManuHPDqafGkhRWgtO/PwFD5oqRCdYsS4qvxifDdbDJNq+0Hb13vasI8m9IR?=
 =?us-ascii?Q?M410YoBHT1vqaKQUpnwS/Hus8LfMCvioYtHRrvtZYvHhGQ/cK1Q/YREh1ors?=
 =?us-ascii?Q?SnTa3TuDm8/SJMIjK2PCaABMdR9oLb1vykgtbCUq8db+jRDRiw2Qd7UpBFJ4?=
 =?us-ascii?Q?ol7sUJV4ZpeHLETqIgtlfyKWgJhTrj2RuhLagZKjLALJuRP7LNdfi7zeT4C5?=
 =?us-ascii?Q?bzh8IaLImboSHY1CHiSo1JwydfNnq2Bbx4a+fwgFaCwYUluZvNr6e/s75406?=
 =?us-ascii?Q?vMNJ3Y5ff4y4B+3UwmfqYNTytT+MJLF22pVSnBZfAuZvQ0BhnYiZ9TSHN+u/?=
 =?us-ascii?Q?07OjSQQlNogno/eacypxlU8LForQGeqV4PxEE3+sPBGEHXpd/aT5jLVdhXHC?=
 =?us-ascii?Q?Q4IzfAebVXk98SI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ucx4TIPqh0UQDKhwFWpp3Z6MCRRFGBeeTEIOpEczVYJsRisOntnML5tchGvY?=
 =?us-ascii?Q?Du8bvqARzcAmk8E0aeVigzeJfKB9JvNkuu5BEMN5Hcs03pkfrXVEzezpu6fV?=
 =?us-ascii?Q?J556xE5h8rd5kibhowW/bvqByo4TvINpYVV+F0FbyF/ulkUWYBcuMreVJ9cm?=
 =?us-ascii?Q?W+WKrygpCIScszxGaB09l8HS6OJC8ydEQRF//mIflAWIdloaCYYIvSogH4Zk?=
 =?us-ascii?Q?uJR8LGxf+dlu/1H6ouK9X6pQzU/67r+XDWzp/Tch7bpC+kDc8cG10q+8P8Yu?=
 =?us-ascii?Q?ZSg1c2HmTKsyeC0LDZuB0dpxr5qNQiREDmrW/Px3xJzLcU6F2mza5WWJ00DX?=
 =?us-ascii?Q?25EJOgjNBnjdLmyD2wepBXBRkY1L0GB69PHULrgaNF87SwnQc1s2BY1qZSB2?=
 =?us-ascii?Q?AbLEod0FeIm7IrXJs2AkrQqWjpEo+dHo5smDQj8/b9nu+HusBk7MOVemfrvo?=
 =?us-ascii?Q?wpugfsysRkDxvue5ZhL83xAmFkIZvR0/H6J7dJaX/rCFXqBwsop5IYrNopfa?=
 =?us-ascii?Q?I4gV/PcWvxiYX6hMA680q086s8xi1fPO+EgS4TJbm6zeXqLDjLYpoqYAl2jU?=
 =?us-ascii?Q?L1uM4a5o6Kyd2ZHssZTP/9fzxDZPsb4y8RoW+OAF2W6pP6z3KxzyIaG4D+cz?=
 =?us-ascii?Q?WZG63iGwlgGk5gNEaWHpHsPhnGbWshsb9QbUTujSMo5AjqDvGY5l5cnYoXhL?=
 =?us-ascii?Q?7FuSKxxtsH2fYZfrNQzcc6aH6EGqyfYxnjjAT7JzWwbWmC1I4z3W18TPFrsF?=
 =?us-ascii?Q?wSCYdeqhfoKn0DeNdAwGrsLU4LyDuqGjJlAj2TVxVqrjJcz3f5XrDDLNeiRy?=
 =?us-ascii?Q?V8iwKfHXfya8rYycPXgiOQI9Bxno6P/w2UoMPrM6JQEk9nZ+h1fxt6z/+B3V?=
 =?us-ascii?Q?rEvGlFFy1Gjj+LNIdidlgC3O4sr8NvP0BASm4jYJTc5rOOECIDrtbdITH/jy?=
 =?us-ascii?Q?geKpsmBGhHJ1AApCK+AUx18tjqyzvioqm2XEnzEUX7CusjhLwlZOiJD31M63?=
 =?us-ascii?Q?KhqI2kIXSpU0/z9+bOioGzwIFSBOJ98rFu7KdI/wpgZoWxYbLoVrgFk7H2TI?=
 =?us-ascii?Q?D2xBBbSdd0f881qYfpTmDQ9GpWFj7PD+bPS2xtF2gnBjg5fem/tEBKdcnk2g?=
 =?us-ascii?Q?JIIKeAaIlUG9Wly8wKGCiFFmj3sL5fB/3Xq4lsTif7MwQBF+lafAPSgAO+wu?=
 =?us-ascii?Q?TQgS2TD7yUXASBgg/t3twhaGRWpRn7HMhH3ALmsEq3hkrK5bRMx0eUjGryxc?=
 =?us-ascii?Q?6dK/XlYv3/QzlfrjgsK7n2I2pHkvUYXkW7NKxm1pfboxibea/pPZ5BZtETM/?=
 =?us-ascii?Q?+Qp+s/w04fC9rLg94lDri0Az7ToB5Q88+N90hKaFZXECCHQ3vjcdLmvTy2w0?=
 =?us-ascii?Q?SYhjEkv9meAXIJEJXNP2hoC4OTmXaJ4/tgWtq4dsuSpijWjh3tph99mXI2os?=
 =?us-ascii?Q?qr6kiJbi76otTSe/E6u+FHscSvumZyXFd0INswKJ+iw9YmEMDBqvoyembfcw?=
 =?us-ascii?Q?9ShjnSmaVOFPp5qRXiquF5ICd11NikafhATsKE18Hbg1NKpevd9ZDn8yZiqn?=
 =?us-ascii?Q?QZcC4pdypsIM4KySiFJPmQ1iwJ6aoO/w/UsjQ98G?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47e3d3bb-e4c3-431e-e42c-08dddf20301a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 12:59:09.7900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sg3zslyxhji+jvDs73nbc3zNgSTXiLGqP79MSAc1QacMP6RlfDmDZaXy5nRPZbJ4981c7sr0LCDyMynXvM5LXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9946

The NETC Timer supports to loop back the output pulse signal of Fiper-n
into Trigger-n input, so that we can leverage this feature to validate
some other features without external hardware support. For example, we
can use it to test external trigger stamp (EXTTS). And we can combine
EXTTS with loopback mode to check whether the generation time of PPS is
aligned with an integral second of PHC, or the periodic output signal
(PTP_CLK_REQ_PEROUT) whether is generated at the specified time. So add
the debugfs interfaces to enable the loopback mode of Fiper1 and Fiper2.
See below typical user cases.

Test the generation time of PPS event:

$ echo 1 > /sys/kernel/debug/netc_timer0/fiper1-loopback
$ echo 1 > /sys/class/ptp/ptp0/pps_enable
$ testptp -d /dev/ptp0 -e 3
external time stamp request okay
event index 0 at 108.000000018
event index 0 at 109.000000018
event index 0 at 110.000000018

Test the generation time of the periodic output signal:

$ echo 1 > /sys/kernel/debug/netc_timer0/fiper1-loopback
$ echo 0 260 0 1 500000000 > /sys/class/ptp/ptp0/period
$ testptp -d /dev/ptp0 -e 3
external time stamp request okay
event index 0 at 260.000000016
event index 0 at 261.500000015
event index 0 at 263.000000016

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>

---
v2 changes:
1. Remove the check of the return value of debugfs_create_dir()
v3 changes:
1. Rename TMR_CTRL_PP1L and TMR_CTRL_PP2L to TMR_CTRL_PPL(i)
2. Remove switch statement from netc_timer_get_fiper_loopback() and
   netc_timer_set_fiper_loopback()
v4 changes:
1. Slightly modify the commit message and add Reviewed-by tag
---
 drivers/ptp/ptp_netc.c | 95 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
index 7741b5bbe61d..4158fb3c58eb 100644
--- a/drivers/ptp/ptp_netc.c
+++ b/drivers/ptp/ptp_netc.c
@@ -6,6 +6,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/clk.h>
+#include <linux/debugfs.h>
 #include <linux/fsl/netc_global.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -20,6 +21,7 @@
 #define  TMR_ETEP(i)			BIT(8 + (i))
 #define  TMR_COMP_MODE			BIT(15)
 #define  TMR_CTRL_TCLK_PERIOD		GENMASK(25, 16)
+#define  TMR_CTRL_PPL(i)		BIT(27 - (i))
 #define  TMR_CTRL_FS			BIT(28)
 
 #define NETC_TMR_TEVENT			0x0084
@@ -120,6 +122,7 @@ struct netc_timer {
 	u8 fs_alarm_num;
 	u8 fs_alarm_bitmap;
 	struct netc_pp pp[NETC_TMR_FIPER_NUM]; /* periodic pulse */
+	struct dentry *debugfs_root;
 };
 
 #define netc_timer_rd(p, o)		netc_read((p)->base + (o))
@@ -936,6 +939,95 @@ static int netc_timer_get_global_ip_rev(struct netc_timer *priv)
 	return val & IPBRR0_IP_REV;
 }
 
+static int netc_timer_get_fiper_loopback(struct netc_timer *priv,
+					 int fiper, u64 *val)
+{
+	unsigned long flags;
+	u32 tmr_ctrl;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	tmr_ctrl = netc_timer_rd(priv, NETC_TMR_CTRL);
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	*val = (tmr_ctrl & TMR_CTRL_PPL(fiper)) ? 1 : 0;
+
+	return 0;
+}
+
+static int netc_timer_set_fiper_loopback(struct netc_timer *priv,
+					 int fiper, bool en)
+{
+	unsigned long flags;
+	u32 tmr_ctrl;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	tmr_ctrl = netc_timer_rd(priv, NETC_TMR_CTRL);
+	if (en)
+		tmr_ctrl |= TMR_CTRL_PPL(fiper);
+	else
+		tmr_ctrl &= ~TMR_CTRL_PPL(fiper);
+
+	netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
+static int netc_timer_get_fiper1_loopback(void *data, u64 *val)
+{
+	struct netc_timer *priv = data;
+
+	return netc_timer_get_fiper_loopback(priv, 0, val);
+}
+
+static int netc_timer_set_fiper1_loopback(void *data, u64 val)
+{
+	struct netc_timer *priv = data;
+
+	return netc_timer_set_fiper_loopback(priv, 0, !!val);
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(netc_timer_fiper1_fops, netc_timer_get_fiper1_loopback,
+			 netc_timer_set_fiper1_loopback, "%llu\n");
+
+static int netc_timer_get_fiper2_loopback(void *data, u64 *val)
+{
+	struct netc_timer *priv = data;
+
+	return netc_timer_get_fiper_loopback(priv, 1, val);
+}
+
+static int netc_timer_set_fiper2_loopback(void *data, u64 val)
+{
+	struct netc_timer *priv = data;
+
+	return netc_timer_set_fiper_loopback(priv, 1, !!val);
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(netc_timer_fiper2_fops, netc_timer_get_fiper2_loopback,
+			 netc_timer_set_fiper2_loopback, "%llu\n");
+
+static void netc_timer_create_debugfs(struct netc_timer *priv)
+{
+	char debugfs_name[24];
+
+	snprintf(debugfs_name, sizeof(debugfs_name), "netc_timer%d",
+		 ptp_clock_index(priv->clock));
+	priv->debugfs_root = debugfs_create_dir(debugfs_name, NULL);
+	debugfs_create_file("fiper1-loopback", 0600, priv->debugfs_root,
+			    priv, &netc_timer_fiper1_fops);
+	debugfs_create_file("fiper2-loopback", 0600, priv->debugfs_root,
+			    priv, &netc_timer_fiper2_fops);
+}
+
+static void netc_timer_remove_debugfs(struct netc_timer *priv)
+{
+	debugfs_remove(priv->debugfs_root);
+	priv->debugfs_root = NULL;
+}
+
 static int netc_timer_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *id)
 {
@@ -974,6 +1066,8 @@ static int netc_timer_probe(struct pci_dev *pdev,
 		goto free_msix_irq;
 	}
 
+	netc_timer_create_debugfs(priv);
+
 	return 0;
 
 free_msix_irq:
@@ -988,6 +1082,7 @@ static void netc_timer_remove(struct pci_dev *pdev)
 {
 	struct netc_timer *priv = pci_get_drvdata(pdev);
 
+	netc_timer_remove_debugfs(priv);
 	ptp_clock_unregister(priv->clock);
 	netc_timer_free_msix_irq(priv);
 	netc_timer_pci_remove(pdev);
-- 
2.34.1


