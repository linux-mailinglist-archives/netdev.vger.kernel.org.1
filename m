Return-Path: <netdev+bounces-216048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB13B31B5E
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 16:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D2F41D41040
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 14:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14CC307AFC;
	Fri, 22 Aug 2025 14:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iF8JSONf"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010018.outbound.protection.outlook.com [52.101.84.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BBB305E04;
	Fri, 22 Aug 2025 14:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872369; cv=fail; b=KaQDmqcbgUHHoDV8bdmAECQ6tIGWQPrxRkdunFAvvwL8WrE2vtd7pn+jsLDAOSknRAHNUxnG4oMp3+Nv3+vYxMnLppg62RcJWH1CcukLQAf8Bz3BvF8VrA0nga/VAezQUT3fe1uRg9PJ8NpNfhMWhlCY2CJLEUpkGrAqTG/BRU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872369; c=relaxed/simple;
	bh=Ji5SvsA+b4kK6YrHlEA5lBcj6R3y427SxZ1YstuskBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Dwyjh8DeNbLPVhx0BM/AGWhp9guRidV8LV9k1oYMXqmOtV74UdnDzU1C63+oPRyeBtRbnfh3l9LT9Iz3G320p5h++flME2Swk+BlVaaSspvDT5KYvmadAxkWvi/08BP5huMa440g2WQwm8el5GnQO3Vh3vbnh51TeY9rW6KGAJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iF8JSONf; arc=fail smtp.client-ip=52.101.84.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BuRsO1R8KW5HyxltdW2MqjlCJdczDsbiY7/iehJ9Dcgtwm23c2VdRz3DTeQ+nIpc+baRlwDJeshct/gB5EXO3KCW+dCRojlcBxG/nitSiggFMSuUQGSXimcqhJaare9EG0HzKmh5sHDDQgunXicnWVvu9lPSoNIiNSuPES60auVj3URXX1VKhzrJdtBtbJhkROeGnPETH9+4sq1W9TmAn/xhI+E94aDuFPhr1FiBXwrNfjL6TzkL1d4Ztajcm/8fbsdx/8TqaZ4p6u1gW71QKnJbyMfcBNJgvUxWOruOw8L8Qbgum1r3Gh9hynfHIWF9GsDE39j+yuese/XYCpslmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XqsPQzMyQtJc3oae7/tH0z/+oIEyLHFeaF1TLaxKkI=;
 b=eb7jbDAdhxdBzRiQZl4yTyQSQNrAzBuezm2FrcrG7jXRxySsaqMLXPr8BRluWahYy84Hck4zNGMEJ/xdNKDlc9Lw5O6ka+ethb7P87HGurgHpqq0yabgXWi+f0laduzlgwu7L3RARM0vpnwguuc9IkmyKHFyG1+9SwN68lcC+GwMGUKavV1ltUlAGegAAyajoaR5oQEnv1Qm/yqg0KB3JmL+61PTqzHUIPbKzu/C4KOXY5vdb1C/ZMjsiCDeKuEUGzJY83+b3PDMRahYhKQIYW67SKx4Jc91+3EMIg/c8P5esdT29enKLG7obYP1SX1DXk9t8HY1KL8OWfw81zr+ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XqsPQzMyQtJc3oae7/tH0z/+oIEyLHFeaF1TLaxKkI=;
 b=iF8JSONffxxPlaJEFsOb8bPfjcCQi0TgCXmq19MwLGokZCLxRRYGF2PJBoRUNdvu4PPnzbPXR2/zUAjAa02iK7h5NZFY4PhNJzLasJCi4yK53rCdrgCpY6ccdXBDgaOk8lYucNFlq5tn8lLnu2hmS9PW9Ib8y5xEa+bLe13nlihctMJsJakI2eYhOe5AumTNCl2KH0Efi7Btgkw8htiQ8+KKdOdIiSEiTZrLgpYxjkHqNIZc/0RNb+cLfxXy9gnCNjZRH3kqiSQYQADYIsaywcJPMstPLoPbKgf4i8XpFBt/rto/rAF7UIS8U87LTPfwO5ecT5R4qP9wLe/hfkfUYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Fri, 22 Aug
 2025 14:19:25 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 14:19:25 +0000
Date: Fri, 22 Aug 2025 17:19:21 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Lukasz Majewski <lukma@denx.de>, Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jiri Pirko <jiri@resnulli.us>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>, Divya.Koppera@microchip.com,
	Sabrina Dubroca <sd@queasysnail.net>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH net-next v3 3/3] Documentation: net: add flow control
 guide and document ethtool API
Message-ID: <20250822141921.rlii3dnblodqezrc@skbuf>
References: <20250820131023.855661-1-o.rempel@pengutronix.de>
 <20250820131023.855661-4-o.rempel@pengutronix.de>
 <20250822113519.y6maeu4ifoqx4mxe@skbuf>
 <aKheqhfqht1Cx31M@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKheqhfqht1Cx31M@pengutronix.de>
X-ClientProxiedBy: VE1PR08CA0036.eurprd08.prod.outlook.com
 (2603:10a6:803:104::49) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS8PR04MB8198:EE_
X-MS-Office365-Filtering-Correlation-Id: 0123f416-d127-4500-c3a9-08dde186e57e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|7416014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zkZ1HJxzj6Ls1/1nmEjNy7w5Ok9CBiceHy8ln1myKlzoSc7l5FffhWjFFAn3?=
 =?us-ascii?Q?cvRELQaG++X/5xebAuvmlPEkDhreUcSadVs9qmHZFyu0rjBUM4mODY1p+/2x?=
 =?us-ascii?Q?Xc5mQAdJFo5O8A9fS9lMJZ9rnujmPD2f8Eyk4M1WtzztUTGjyE16D2899/LD?=
 =?us-ascii?Q?MhauTxb1r3sGUum+lGD5KE4vahSLqZJRNaJWjJ0mP/MdGOHTd7F51vt2mQjF?=
 =?us-ascii?Q?3k66iD0+89HYrZVTfvaQW3OyWbVWu7R+8Yjl48T6YYkR9tKSmHTxvPnA23mg?=
 =?us-ascii?Q?MbZcQrFc/3vOEFD+Iyeh9Ai6HJSMF1xt6EadfXBANpgNaVtPn3x7nt7XF64N?=
 =?us-ascii?Q?U8sek9t3QL0G5Srq4gr0TjhhM4j2iTj8+QOpduZc14o/VFemt0BH5tXqgrvW?=
 =?us-ascii?Q?+zJZ0dlMqLThRiTvxzM6MDojkTqZqbNd4NKbjg04Iyzns+LvpDwzR8BYYUp3?=
 =?us-ascii?Q?EAe+QfjsLuQWS56z/baMNRxadUOHnqp+cKGiUZKNZobEIEXdMKjHrz0NVuMA?=
 =?us-ascii?Q?9uXnwjDDClPrFaijE0a/8AnEvAzWMnA+hNf7Mp7emqQngYZ/5N4rS6npOvEv?=
 =?us-ascii?Q?2br4slb6g2auKg10NLtO/pFwkRqEJTOxIJSxkI3ma7pQSAv+ucRwM/iGwQ2c?=
 =?us-ascii?Q?QSqUHprqYvs+wQ5qxLhD3Cr1j3oscrwrjjUgyj1ZmqypCoB1ihsQWoYWQxnR?=
 =?us-ascii?Q?yG7VKY2QiMvORCnTyt9ZExArP7QEnQGgVIN2nlsCE1nqpPKCeQ3lJOG5mkJR?=
 =?us-ascii?Q?BRioYG0nYk0GRI8SD0BtjRlI+T8jKepsOtFI7wELWsjPkCRJXAo4wCz27sXU?=
 =?us-ascii?Q?OtoNLOpC/cwcu89iqDhQhUrNuUOdQPwnfQRntJcPD2yNqdcrCBIoBw61CbO6?=
 =?us-ascii?Q?um6xpXayEbpNpfDmW+QT0Gqx/ESLZXrebMo91M4VSBlqtqujhFsXP938k/MB?=
 =?us-ascii?Q?tDnwZQ/Hwh98zD67/0Lyz4pAPMu95shJFG5jqeKIY/8C6KrjZ0eVhcrAk51s?=
 =?us-ascii?Q?ocz8OvdUgwyCpTbRneSXGDioIBzW3KfAHMe021wJ4U7I9aB5HmWtO8DkYUCM?=
 =?us-ascii?Q?vwjuIFm2HWqSgc3Ullgb+fzpWCAJXSQTkfR4fn8ga22hrVYojEQsfnNqwkqR?=
 =?us-ascii?Q?82ZmyT6V3YQS5F9I04MuUnM6elvG/XSeQzs4WJTNT25lQkCBlhgHYhMxc3zm?=
 =?us-ascii?Q?aFEi/eDnFX6RzNwihOVguC4ozFd2q4N97T7bJB3AM8k9DX7+FndiBZh9XJhS?=
 =?us-ascii?Q?rU2ccICcMUPt/RoXjeUX+jR+i2hSoZx91eGSKSJGAWlqmDVoLub8/av75Gg7?=
 =?us-ascii?Q?wba69L2Dhuw3fbv9gwMylvJsY7tWTFGmBdehmhh601z94FBfuSypdi3q3Jgt?=
 =?us-ascii?Q?LkbeGB84Y5ERRz5F6QvTND5JN5Q/2UTx4au3ofkLv07In3ZCXpoo2bl+L2ku?=
 =?us-ascii?Q?7mb7eES6j8o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i+wE7M/ruNFaSKSqf4K39Ok5YBhakaqwA+DUDQVFEa4CjSkCUGepYvady5w9?=
 =?us-ascii?Q?8pKnzz9TEkOSYNjAzRncLzjugFJ5voDew1GpIst8ChNfmWtrOI01OAqDXcez?=
 =?us-ascii?Q?EKNxM8ibkXfz53f7skBbU8FwdGJfaHtu9kszariR3ADRTsuJVcX0jiFXuI6b?=
 =?us-ascii?Q?IoSA5gGySeGi76PMgYBOCnKh4zFMhNu1EUGq4qYY/1iFz477HloS4C7khPAH?=
 =?us-ascii?Q?FyyujsqA/H9EQ97XsD2+ibdBrTIS3HZek11u55SQ2myHT4S4rjssMufHxqA/?=
 =?us-ascii?Q?6cWKuj3e+AJ0nfjGb1s3kUGHDac9oYHZBHTb9Apl1468vO2u5Mx/mfGr1khF?=
 =?us-ascii?Q?JuTtsa3FkjjAhgP17CXV6v1qsMoTK2ryGRCjxUjTWtaV1HQZq1p6fQR+KSvY?=
 =?us-ascii?Q?rLVkQlNTYzYCwNnH3IlwqSjzKwlh3/WVN58D2r9NgWiCtFc6Ksbx2K+oQFSq?=
 =?us-ascii?Q?S+8Bwyy9xkg0Df4d+/Pwc0Be6EobvSQnS0TRy1qr59EcL+BqowC8j+XNbFpp?=
 =?us-ascii?Q?mCsLyN8bx1dT/028f7iKMhpY8NxiCyX5IWkwxtAlBMNKfhWS/XJ/PVqS4Sht?=
 =?us-ascii?Q?SrsOcTqkWpIcc1sNTS9ymp7rmq584+HB1aBNTcC/ExQ6R1kafucLh/anrDns?=
 =?us-ascii?Q?+hYex4sZomQ3apcwqbMqbd9jaTmm20jLVKzFKAP0RYfmDxY1fOTmcdnRACZ2?=
 =?us-ascii?Q?VqzcANGKmEVySkH4mfkrYl4L3TBiUbW5Vw5h8LZLW2KpMI1xjuT/Olp7uVoh?=
 =?us-ascii?Q?aXUKqyoq/EfD9TxaIO3R0bCKCn8dHz5FrQhA9ieDLnHwnYsGOx5pvf5Id1oL?=
 =?us-ascii?Q?S1ULGnMAIAT4ufwVwUebL6qgpIUWIiLJxZgfOSBU4ud/Po63B/40230pxJ6a?=
 =?us-ascii?Q?kB4ugSq5Okk3gLB6hnSaRmpF13T1GBE0RYpoo0uo3v48wzI89w1O29TVBhgC?=
 =?us-ascii?Q?zgkPsVhWbvCFytI7jnLeEHyMYVkNPy9tw8Bj97+p9kXsFYUDkiWg+I85Eqv0?=
 =?us-ascii?Q?SIX4RvfVfGZinqyNnu3E9gD6ZzX9u9sV5e3Ju4kwDZB3pUth+HYIAnfU07MW?=
 =?us-ascii?Q?aqP/GHybK6s29OqVMZSgNgz4I//xpr43C4YiS5pyzxM86a4yVjo12Z5Cl4t1?=
 =?us-ascii?Q?ZeHKjYrc5BBa1qIXcuxEKhQIZwI+Ujz53zLrQaNcy8LXSR6CPSWSNvOi5RNV?=
 =?us-ascii?Q?R8KqbzuDmBqAYID1C2e3XnIdRv3yEsWYSRAbOTN7UwzJNRhl6gTjAQZJ7hRb?=
 =?us-ascii?Q?g6S0eqCZAG0rKG+Pzlm9ELoXNR1wMJBm8pmCnWEBFnT1lPFTNov1WUqLnXPk?=
 =?us-ascii?Q?WuBs91v618sFu/BjoU/jHSw+gr3MNRE9C5qT+rmrMJCntJwbwChWB7EpaDA/?=
 =?us-ascii?Q?Ws3i1b8S2HjAocMZzsdyS43/VkUUSIk1CdgRWz4aXvnJRH/Fih7AOg8zPdna?=
 =?us-ascii?Q?RoXwx61KelOHqJUqk/4W/tZ8ZqGvs5MZQKjkr47WxZHZiOIdE/wM2hKzEX7I?=
 =?us-ascii?Q?/PZ+1ae2B1qg1JJHp5IHkAG3l2DTQGlT7J9AEZPlg/pcTZZPkqvm23LlNEuN?=
 =?us-ascii?Q?KZs7+kdlWGYCeexRlwmTPj+Mc07mu8SDkum3qF1AWmX8Z2dSC4JYt+IlM3Xp?=
 =?us-ascii?Q?UAOvQW10xvQiy4F7PpXLEV6i2B4mymdRI/KHUulLIZ881twLW45FNKFS5FSb?=
 =?us-ascii?Q?Nmb1Sw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0123f416-d127-4500-c3a9-08dde186e57e
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 14:19:24.9987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nq6zgndZJyW4455sAfrj5cHBg5KT5RcvOXNtARJvusbjpsXIl2mTi8mt6A6iIx/VmMMrHf+rkzXNH9yThgYYUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8198

On Fri, Aug 22, 2025 at 02:12:26PM +0200, Oleksij Rempel wrote:
> > > +The optimal values for these thresholds depend on the link's round-trip-time
> > > +(RTT) and the peer's internal processing latency. The high water mark must be
> > > +set low enough so that the MAC's RX FIFO does not overflow while waiting for
> > > +the peer to react to the PAUSE frame. The driver is responsible for configuring
> > > +sensible defaults according to the IEEE specification. User tuning should only
> > > +be necessary in special cases, such as on links with unusually long cable
> > > +lengths (e.g., long-haul fiber).
> > 
> > How would user tuning be achieved?
> 
> Do you mean how such tuning could be exposed to user space (e.g. via
> ethtool/sysfs), or rather whether it makes sense to provide a user
> interface for this at all, since drivers normally set safe defaults?

Sorry for not being clear. I think that by saying that user tuning
should only be necessary in certain cases, you're giving the impression
that it's supported in current API. You might want to clarify that it's
not.

Also, I'm not sure that the length of the cable runs would be a factor
in tuning the flow control watermarks, do you have a reference for that?
I'm mentally debating the value of the last sentence.

