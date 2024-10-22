Return-Path: <netdev+bounces-137979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4469AB53B
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 19:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E0591F24625
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 17:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7661BCA12;
	Tue, 22 Oct 2024 17:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AEZbdoBQ"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013067.outbound.protection.outlook.com [52.101.67.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EA91BCA02;
	Tue, 22 Oct 2024 17:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729618663; cv=fail; b=Q8x8RziV25YU8AX86ZavfhdA/Jz7mYZ750bfCAicn1caMJcG6V8TUPo0LmBn1JwZZszGH3Lll7SK0jytnLcvbLKzgK6PzgIF4fT8JWQlFOeR43e8RceJkPddwfa0TFY/ss0ybiGkC1+k3w2lzjWs5RhFdzhQ3/IlO6unUB3ORKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729618663; c=relaxed/simple;
	bh=dntbcLwKYShjqsp37LlsvD9XkxqnTMfuP5pHAqKVqeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lkqbBaPqjK0XW5T5vYLpUwD0G2SsDcblV9+xU7su7B6FnU6w8OLH67t0TjydWOPmLGrAioIJ1vTy89jOxTTOIvnQ2Q3xXwARgOv7Ri8d9wXV82+wi4SmuCFEWtAB4d03T2dtaH23FmRfXr9X3znb85/4PvL/lDAAaTJS4jm0ahU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AEZbdoBQ; arc=fail smtp.client-ip=52.101.67.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f4OFkIuqGUHQSJBWbXQnIN2SwT/RfYXMnNJtImqbEeG5t4hZfwkCsZMu84eYxdTm/q/BzYpDtKQXxmbaAbn+21kgCQC0Gst7FdldQXSQwTbg3eoNlswYP3I57nm5pRGmvgOEUYvreTwZ26En5fOpEHJObT6nIF8hOn3b5BmQtFRuuMrlXKaQMSJoqJPS2EPwvGnSXMmmnQJdfw1IqGOYJZGa3fhqIG9ZVw46jfZG3rwSalp0BApFa4PwGrNMLqnkYB3GJ9RB3C3XSmiUx/y96kXYw8fqdnq8MzfbfFr3++JpT0IFynqWK+n7/d6dys+cJH/h3Y1Q0IJ2t1t+4UOlaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GR++i4m4kt5vURDiAS5zKV5kAehpUTwK99/rOV8Ko6U=;
 b=ENF0WPb5W/JnTslTBQn7cn3LcNu8sKKKA+xksTgCkkNdy13hpNHjnL083MOAczBerhHNG91iMX1XjEANAaoiHCHEZ/AvOTSGDOJzH/0g/TYso/DPk550Jr0QnWu4arpZ1b4N2RKdFNTn4hha4IIc/RtF7P4ycGBcFXOrGvNOcpQauI3Da/ZGnCQbpoNYCv7KYsz7Rv/jtwHpSHoa8NTuwjfrZ8ThoebDJISTCUCi+LS+azT9+GtSAXcPpswce7ZF3OFJGWJG5riDb4wXONKvsBjotwa82GGOvWnHaUcur2kq8HRd6DM/00BxumsldxsRpsZmXihLIa8yNQ535+FHpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GR++i4m4kt5vURDiAS5zKV5kAehpUTwK99/rOV8Ko6U=;
 b=AEZbdoBQyYWQqIHm4yCTJQgIDL19rpEoiWbT7d/WSqPe95rAlv22XG8LfPacSfBhJ//zD66zw9EhRhJCAXiMy4GQysUJISX8A03i3tSd18ioyRQFSdi6W90cOkAiUEhTi91cZTE4tcZ+PjGfHmq+AhUgcehPfmBdFkyuv6seCIua32mfAhgoVyF6iHNEX9/QXUkCYXFp+QS/dsdB27jFkEQ5Ww8z+vpkwg/zbmxZ2mZ90p4pALITIGLLuTGkiDblHJUfqOSgidEXF9peRKD0KRaHCdVXCF9K+YoOWWltFV3uoSGqivGYJeYX+xIzHDALh8UxUzN6jQWAxVt5dEo+lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS8PR04MB8344.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 17:37:38 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 17:37:38 +0000
Date: Tue, 22 Oct 2024 20:37:35 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Petr Machata <petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Vlad Buslov <vladbu@nvidia.com>, Simon Horman <horms@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next 0/6] Mirroring to DSA CPU port
Message-ID: <20241022173735.unun4qm4fmcrf25k@skbuf>
References: <20241017165215.3709000-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017165215.3709000-1-vladimir.oltean@nxp.com>
X-ClientProxiedBy: VI1PR09CA0137.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::21) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS8PR04MB8344:EE_
X-MS-Office365-Filtering-Correlation-Id: c5a9bfa0-60ba-4ac6-572d-08dcf2c038fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CaCwoTm1kmmCC+OtV5gGn5JZz6Wt6Mt7q3wQUnjd6A4cegK6f/wwqAn+KAWj?=
 =?us-ascii?Q?bS0h0RSpj5vQussVSBNTlvPgSWaQtK2fSiuo1Pmz0zcWK4TX0IxfawxQCTy1?=
 =?us-ascii?Q?5hak9qKnoZRoTtBQupJRt0rccYFf6bSo8p1Bw7HwMH9lBkey/csME7BQ3nFR?=
 =?us-ascii?Q?3xoWFwiInPHfREHVAol2LREB4yd9n74OnwYfO5O7gA1404ErK4RX/JKB4/jB?=
 =?us-ascii?Q?0ewWF2FesetTSX5GIVZjxwBCxbHnYcPkcjaLJKAArhFc+Uu+Nzy+rdhliJ64?=
 =?us-ascii?Q?jQYHXG37xOivNBPHjYNtjJxkYXe51s0Itv/9GdlwMU6UJoPoFw07nobGBaRZ?=
 =?us-ascii?Q?qWO/3+Hmb3OJDD16Wj2On4lkDuCt+zt72kjo+b9T4G9dwBYOwnRrfQpmAbNz?=
 =?us-ascii?Q?ixZq8SWR66cpMDpPhqOStncDMLgL41f6B6Umrw5yheMgVivKb71GPyi9WdPC?=
 =?us-ascii?Q?fSW5QfGE+KOT2R4ETgl2JpTR4MN1+DO65sNXTvoO6PmuLVZQuCJeJWXxuNN/?=
 =?us-ascii?Q?WZ1WlI7h9ZgHmcKMsyITe/mzw0eRfAWltUH2hc9u5f6rQscWp219u1WMF6g4?=
 =?us-ascii?Q?4k3L8HxLL+qnuOfWthtSXowpkQmP6reCYTFD+VhHvw4KctyVGJeAJonVyv+G?=
 =?us-ascii?Q?tYbQdTrsiRITSYM7NlI1TqajwQlVujPaICD4eCj3m7JTovyWN3IDV63k8HF8?=
 =?us-ascii?Q?vWE/vb4N0I540Afj+XVuW9HXTQrRG5yMR8Z7AnPtZXBtKTcbqFyH0TinNoob?=
 =?us-ascii?Q?C6ora6dM72yI4y9ZQQcIoX+zLNdzNi4BGXBwwHC7aRC5xX7ImaVYOuz8tYk7?=
 =?us-ascii?Q?GihCmMfCIEEPnraByci7jGzSv5jNFdyd+f/Vs5wnhunim5FKTTWdgZQB9W3A?=
 =?us-ascii?Q?LJxwrETr0Dg6liw78cAHjc/O+uVMLkhTveENZ8mOqNCFAvOqMddAfUvf651v?=
 =?us-ascii?Q?YDmCmT0DuNGxRCBpW5wMFMJSvrgM6hpVWvWXL0rxZRhljrv8NxjdUvGwFk9H?=
 =?us-ascii?Q?sZx9XAqO0BvdhIEQ7+5Eia+GwSbHGmqU8wnLhmyI69BzQMjujBmWmlTJny34?=
 =?us-ascii?Q?ctyMxaNtsMwaz5Cs+8SlSJIPXFrtpMc8onS1lDKm5sL1/ZIQP39a5VQ/h7qr?=
 =?us-ascii?Q?ZBIKo222Rz4LCt3DZZzg8g/0JkKF1AL6Ix4UdkbGZA0409PQ9pYDe8fm6sRg?=
 =?us-ascii?Q?SZ6eDaUgUkgNQbnB7cnDP9bwgN8UOocoFw9PODOkIvidp/D5gNmd7EPEhhu2?=
 =?us-ascii?Q?9PRhLYNwKHKY2zw4M9WfULc2YfJFMcdb25eS1CtYYZEZWllmIEWTA0JYQwg8?=
 =?us-ascii?Q?DZU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wJBOwvczoDm2wRXJWjIhZTI1b9m2/N1J8RvglI0Sr1Ct5ZFSmorDpCYAarSj?=
 =?us-ascii?Q?FU6eayChqXoCStf34xF8TNl2butBAI9I08LtvFkZN9YJl4YN9F6aeRREX7y8?=
 =?us-ascii?Q?07OcPd0NmukWCOoMlec6Q3EzO+K7Qki6IdLjkzPybX3tIwIy/79z04Z1lqax?=
 =?us-ascii?Q?DN48HdO9qw43C4rxAPw9pSRdWAsRRh5ZLyGnALkG8bKTgWDw6e6yqg47PX15?=
 =?us-ascii?Q?qRn/Mgwq2jvuIVxW19DgiaU5HV+SYjhP7jaAG44w4pr47mnpbftBXgz/w+Mx?=
 =?us-ascii?Q?gEBRrtTHzzdQbiy6CehN1OEVQk8Kh/2jlFMYvZlmgD0g8IcikJRtJ3hxtrfd?=
 =?us-ascii?Q?Ir+9antQwDunBTNvobxcp+PcO4+sHbpDXT0pI0vT4AgC4kzS3KIxHzHNiKK+?=
 =?us-ascii?Q?gnLnTMgibTeIevdMjl7tflZChFd7q1Ra9o1gjzteWKSGYdPZ28pbESr58I8N?=
 =?us-ascii?Q?fhmpPPuzpbFgw4fOmST6KH49mVVqJu3gslbD4yr15cjVezTKWJGPoDZT7Yix?=
 =?us-ascii?Q?2uNKwVNV+dLyf8khX3GTENsomwkCgC/Ef+6MGFRFslN5dIIsR0BzD9zRNGYX?=
 =?us-ascii?Q?nMj3sdo/eX8PGUEQl/ZlQh1D/rN8p4mapvjr/Ana3MgC1uDLiAEsbeIPBVp9?=
 =?us-ascii?Q?ZnO06pd7F0PXvsAw6hOJjxwyhhq5cXWReIUlMPH0v7ixczcPSnQaBecozQHD?=
 =?us-ascii?Q?FJpddwPMaMLY+xJdgiGVZa0czx9Q+76GeBgYgSZ+JckKHsf6+mcN8YBTgK5w?=
 =?us-ascii?Q?vM7QtNiAJr5762pddkUnNjpDOyukQ5ijqphpj6XF3C6gXEEZw8+Kg0V8fI8j?=
 =?us-ascii?Q?+TFSlE4Typy5y4LZZLroghPSjYhRnpL7iR8/gx8ATKQPHl7qTo/4MEy8sKbj?=
 =?us-ascii?Q?//36yGt7BRjmz5gU57nfqHDANqNWhIkGVub8Lfek3IB4ChQ3SBMTVeqM+nas?=
 =?us-ascii?Q?UCbcSjT28/yJ2CFTMm67JJ7gTKpM2rHLSTt++jeZ4f5MUcKtSOMxJdH95IMt?=
 =?us-ascii?Q?BnYOBohoiLuWC38Hbw2iHSrxNl6c51QeYfrJxKnhR5JgM8s8jomv87R2lBDX?=
 =?us-ascii?Q?BGZ18Fsms67XLOlSG+MjJIGZdinetOhnFnfc1k5kHUmZ7njA2S3UxSbGGfnq?=
 =?us-ascii?Q?fj1iVz5SRjEFIPz9Ic/qlznhQeRQbc2mvctgOooPw5weJFa4+c6Y7chjg48f?=
 =?us-ascii?Q?SWRxrdJDsNzHaHjpGnVnb8DRSeBl4TXItksVuRS9BlTbvXh4ZXis5iX3Speh?=
 =?us-ascii?Q?1z1K0sS/kvxpC1I70jm/S07GRaIzAqZvXfRsVP8U5TQP4c5Npp3W4zgKcWei?=
 =?us-ascii?Q?/QEVJ4c5aJaNbC7jNVe9/GtP+FX3lATMhGkUz+4POqy43BirOH8cw5cIk62R?=
 =?us-ascii?Q?CjqLfNNvREM2atkzETpnO3pfEiXN/03/QaY6nG5ktM/qitbs95zPvNqHVL39?=
 =?us-ascii?Q?WQu4LYiB9SND7+OdD4uKutgEovO8UfWWrVRX4Fan4tDFytun3eU+SgrooF9y?=
 =?us-ascii?Q?VUxanvbE7CE2yyWMn/MQzGvj7rvX8ofgL28MpFSMQkZu2nfK3KAVS+qDSmsL?=
 =?us-ascii?Q?2uThPT3Ba35nqBA6DJbeVg86lE80xYTNSLcyIh+r1M8ciwCGNO5UzdoCWZYj?=
 =?us-ascii?Q?Qw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a9bfa0-60ba-4ac6-572d-08dcf2c038fc
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 17:37:38.6112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rFRu7OqyIS6jtskCcO6JaH2swCcPnFdo+Vop9TZ02/wAH8H4Ba7zxoC0+zwOQmjNDwilaOGbk90dd0l5U0owEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8344

On Thu, Oct 17, 2024 at 07:52:09PM +0300, Vladimir Oltean wrote:
> Vladimir Oltean (6):
>   net: sched: propagate "skip_sw" flag to offload for flower and
>     matchall
>   net: dsa: clean up dsa_user_add_cls_matchall()
>   net: dsa: use "extack" as argument to
>     flow_action_basic_hw_stats_check()
>   net: dsa: add more extack messages in
>     dsa_user_add_cls_matchall_mirred()
>   net: dsa: allow matchall mirroring rules towards the CPU
>   net: mscc: ocelot: allow tc-flower mirred action towards foreign
>     interfaces

For this patch set:

pw-bot: cr

