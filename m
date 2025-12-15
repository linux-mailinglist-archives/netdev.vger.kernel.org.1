Return-Path: <netdev+bounces-244835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 398FCCBFA26
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 21:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1E0B302A384
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 20:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0140933AD9B;
	Mon, 15 Dec 2025 19:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cQkoOkTD"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013051.outbound.protection.outlook.com [52.101.72.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8C133A71A;
	Mon, 15 Dec 2025 19:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765826940; cv=fail; b=U0LLhVEXpdSY4/0QiWj29ogddRAmuehozSbVilRU1OYyyl9S/S38emp6FcSbNZzrfLCDi7tDWTai/5WqMMldaSSxgqHpRFueqCeSMC0wtHWcECy9Z1nWKNq2gg+GZsn2kWDMlTOlpu+mAuROxhGiqe/CsfiXgPNqzIi9IKbHVZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765826940; c=relaxed/simple;
	bh=q7L3URzftk9+cnl9hlHrbSMkgRH6O/uJTx6jWJMtnkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Arqryd9raQqzVDDCaB3nZIeiWNNbAJ569fJ9RGxLy1qhAcpRTF8hP8l5NZJFRTGyOFRqo8fzYwAlf5/04YtFFABWf2nYJtmQagsWVRAEmM1ak7f3aFNJvwTZhew/R0FROq6cYOj12lx27n4alxjfPkd/1nxQso1+QqzMOtRtcGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cQkoOkTD; arc=fail smtp.client-ip=52.101.72.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QLPkLStj9gP5ZUM52C1dt0Yafb37uV42ZgeEo2NRvwPCRpalSZilPhqnQrk7B+5KcabuCWzgHYGtUP8qCc14Glu6IQrqZLwKZoJb17ZbsoHd0JYC8PPQw5kLZZVTTolZZyeQLdQFjoHZewcmagT/cq58oyb18rPpY616mMHnKLyee3F6zApwdIZxEUw6LcoHkgqt3vmlc4DjcG2DgyPNK6faP4bWqYRf3QkjkKBo4/Lupm3t3SwCM7XAl9Z7KdQzyC4PpqzYPT2iDdv33etfVMUGVBZnU0mKU3w+VZwzRBorFbmK2HnfvHYi1HGVHwoLnctaIrYnsCe5Bax+aaZlfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+m26h3AwNnPSzpL2ZtLc3qDLbZsuoBiZpt3AMS78oM=;
 b=JK6j/clzDgaDaKH5IBc5oJDlT6wixMlxoEOIHkXglX9TJGB54OzXq5dYm2e0q6eOaG/eYUfKTuua012CC1ZM1wjuCTBWUwQwts1vX9BcqgIqjcmhjO8a8dncioW0ZW5jTS3UEIQrngoRLs1HuOv7Bf23DRf6z+TTlHxcULd1hbVRL5UcekI4GriU63qGI/XhYqJ1cstL1/jORd7WQPTx0sQSPfuGv4gEO6SgtqB5tCjHtQBd25GF0f1EmtW5GvroEhrbawSQ3KNebUHgyHiSjCJ8rysKsogbtmNTMWxhtYRI4E61zJhRoYyKxyk/MQzrFvKUq0Sok+WFFxYRMSTNUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+m26h3AwNnPSzpL2ZtLc3qDLbZsuoBiZpt3AMS78oM=;
 b=cQkoOkTDkauGToKJzi8eejpoTYqGNeVMddU9tHfr9nhsTPp19kUeMdTeaQYB9I6riCmAG0a+D/F3HkAg6m9pnPNizHXdbDOve7D4O/tiWOI6GqqFQZSDsdF9X7Xa0UON9JR0xhxwI2kjaqJjMXvTG8hRnBhEUSsiKczO10tkCHOFHSyGyq1ZCZfpKmEqfEroscHI5bR7KW1Jls8VKHhnB3byr1NQDPFzgtkvTljI2L0ipPh9Jr7CSTNa5G7FwhzI5Ou15PGG4rndJUXChbWJy5BYcFQ4VuQK3XrErrI4cExoxNzjki0GABwW8J4Ox5U5VI3c0XwyPgaMLtZBJiAfvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by AM8PR04MB7938.eurprd04.prod.outlook.com (2603:10a6:20b:24e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 19:28:54 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 19:28:54 +0000
Date: Mon, 15 Dec 2025 14:28:43 -0500
From: Frank Li <Frank.li@nxp.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Chester Lin <chester62515@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	imx@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
	Jan Petrous <jan.petrous@oss.nxp.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Matthias Brugger <mbrugger@suse.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	NXP S32 Linux Team <s32@nxp.com>, Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, linaro-s32@linaro.org
Subject: Re: [PATCH v2 0/4] s32g: Use a syscon for GPR
Message-ID: <aUBha2/xiZsIF/o5@lizhi-Precision-Tower-5810>
References: <cover.1765806521.git.dan.carpenter@linaro.org>
 <aUAvwRmIZBC0W6ql@lizhi-Precision-Tower-5810>
 <aUBUkuLf7NHtLSl1@stanley.mountain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUBUkuLf7NHtLSl1@stanley.mountain>
X-ClientProxiedBy: SJ0PR05CA0165.namprd05.prod.outlook.com
 (2603:10b6:a03:339::20) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|AM8PR04MB7938:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b1cff4e-49a0-41ba-c127-08de3c102f34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M+JK4xRQjlalJ8b2g73zJwjYiDF/1ud06wPT3aL062nPDobbIt9JcQOTMYhv?=
 =?us-ascii?Q?0ixK0M3a34pmRMhnGwgU5ylQYBB5xm3WMaNHhz5mWjGOWLnsckBtHDr1DaiP?=
 =?us-ascii?Q?izfkEv3UyCVZ9OhY8w3+TJbojRDHMj7H1Kv0VNkkzGaoE1DCn8f6XucGH4TV?=
 =?us-ascii?Q?PpYIPNQ8d+hJlncz4EpiTxi+YZIVcOyfuXDbXskoLoxE8w0XoXR23qyVwaYF?=
 =?us-ascii?Q?XMXPMDhvCIsYf1s98FCfAPomF83WDKcpe88gbNEZuwUJdkJzCBTMBfrw9Wvp?=
 =?us-ascii?Q?AykCF/mLCT6btfyFUJ6p1l0HFU7cyZWlXcu9HwSw6Z2HqT+InrA/A5ef/6rd?=
 =?us-ascii?Q?griXS+xNw+qBNyWYBBprmyVJRFsekWOKSAgLmt/MnL17LaEJZgeKsW8ZtBFX?=
 =?us-ascii?Q?udA2lfvEn7nmnoJj727VgMgSv+dftVeL0ed7Jo+8FSgJnq5dQ8JAwz4rbJIK?=
 =?us-ascii?Q?Z5HHOiBTtDyT+vxXUN5HKzKxsOVGLzw1fSGXyTJZsQv2nBzAcGHDm9gU2a6M?=
 =?us-ascii?Q?oiHlyY4wIR5X2vvW0/N3KW3RGVs0nMFZdDzI6zqIfWf+dteI4uTjD27PvAwC?=
 =?us-ascii?Q?eVHP+vSenTg6YSg3jwma79fr9t7pdjgZmkGEVJjAkMMUIKnWqH7cBFxzCpal?=
 =?us-ascii?Q?5UMKDNZ6DNBxsDWSW3FY7v5vtCxI0gjMPznEXYMQ1ooAdXzUxzCd6p93LzLA?=
 =?us-ascii?Q?7qCTzKJ1biIPlSGM5RjTjwU31iD/g/pjc5HT1GyEwHs+DU4aeU+8NfGn6smH?=
 =?us-ascii?Q?KIHlCU3Yj0ObQj/sBuuu6c7842xa6YukDsVNuph0SQ+hR8ps3q6eV0ohTWqv?=
 =?us-ascii?Q?+DIvke6veWL0KkytWqbYNFE9EEjil1QcukYvnkhYyDEfBQfX7hKhNvy/MtJC?=
 =?us-ascii?Q?XSxlyDtl6VYIIDOd9cR6I3u9L880X/5Pj5952BPXon2OiBwXkLulBExpIvDB?=
 =?us-ascii?Q?JU1pp/QYsg4ZgHJJBi59+WO+IAC/2Emqa9lHD/f5/OQITMU0ir0tMR3shCQ6?=
 =?us-ascii?Q?vqwUk40hZsJJ6INi0BoYnf02oefj0CGQB7fPKBDdz7eqxZOx0KqopXgwgMne?=
 =?us-ascii?Q?T9Y6+5AAOTb8dLEKLlbVBHXk+GG930a2sELbkKS4TQRfWxP4TLeEHIIgbH73?=
 =?us-ascii?Q?jdg2Ekoa1oe8WgFMlwwrJn4geFJIkoXB9nbmyAW4MjeH+7ccIVDuZUDk0HhB?=
 =?us-ascii?Q?4zWJAPhkwyQmoGbLaGASZUf8FZAtdcDIyv75gzTvLzvc9nnnA4fNP7w+T5JF?=
 =?us-ascii?Q?/2mYEzI5KEp8l0U1N/4TxbZl4xzjlKFeNS9ssN9jjXmO4mCBRbbBa66dRwjc?=
 =?us-ascii?Q?WhrV60cShpWtYGrD74/dUblB36Ekqg660mFGluzEJkB/rBk3FLkYqfeIl5fe?=
 =?us-ascii?Q?NFM8efguUWeTIDNPkpDXWAYCwkWmOKRf3oVFy2g61WFzRLkZTpMRRCzAx5Qj?=
 =?us-ascii?Q?dCI4RearjBSMeGUKPRs9jHDo4m9dp/EwUXtBW5uFLTzXX8kDYZYnNrFQn/VH?=
 =?us-ascii?Q?EDa1uAQ5iKgaqSiQB7ZkyA86CzotzXkMuqFC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cIUmFobuqCNo3oU4ZK8V8ESisjm410QoFSiALRc3jW9+RxgwwUtWJRxmbsdU?=
 =?us-ascii?Q?Ndk/nP8qUEqE/onQYHIDlkCAeqJWBjd9VUPzX7lwom5VUY91MCbtIzMDmAL/?=
 =?us-ascii?Q?O4mzpTd0BrQeMqmnfDJNWTnyVaWT28PoS0SR8A47AkUMzi9lTDvYi4UhNGCX?=
 =?us-ascii?Q?gv5odjkjYidknJDrQpaKiy73r6obmo0NjC8JC7bgtK0jMwUqBKdHGkrZaJmx?=
 =?us-ascii?Q?MO36zo0gAsZD0zrzubFKWtCdXP51JxIAnsdZNamjzWCqAQ5F+me/WXgzmx9/?=
 =?us-ascii?Q?D/resLcr+46mvsiW7h8WIfUS0mgu/udn3LwTVTgcf6GivajXOfBDQEyJS4qJ?=
 =?us-ascii?Q?KPWeIYgG1tTpW0oiMoIVca83WMj3LafVQqIT+RfONg//gcKuo7SWEnscV3Jo?=
 =?us-ascii?Q?OXijTCBcituXL4t9dDwkwxdyBWHU5/PzW6Ftp5ET+8hRSJsWe4BjiTGWDd9A?=
 =?us-ascii?Q?wqSFa7KIfaZ+hHQfJcTSgJZAG8jC9KGv3MxfyZ9Cso6bTI6AcrlOid4wjx1s?=
 =?us-ascii?Q?Pc+NmXqfDPhPj+Mn4nHGUsKjPEjL8D8IvcxLzrO5Bo5Su22nJNv6y3Oc18Iy?=
 =?us-ascii?Q?fPYHmUAAHeu1DGpnU+Mk/k7BC5zMOPK6OEU2ignkXmHKnVdq2/kaeoIuNgFr?=
 =?us-ascii?Q?kkVB0i0d47iOBNM34NjFnxwgbpeyp9Thm01OYiXgaUnkcyNFuT+hsVKsc2Nu?=
 =?us-ascii?Q?L/l4f2Czxvb6GEu99NqVCzI+U0jVr4DI3mgK0/4+L6p4En5KFqgYmK2IZbWv?=
 =?us-ascii?Q?2yk4QSh5gSz+40k4PfhyW/MgGTzzdkk8m+P7zGQUk4hUn/Xr2LhbsQtnFX7r?=
 =?us-ascii?Q?AB/nWyOR4pHky+nqkw0joDV54dy4p7k6Xwc2XYr8xXc354Ht8a81DaPC1MT3?=
 =?us-ascii?Q?RJZSd6S6XNFQyTkQXNzFiCCcrMZlqOe+ZONbMXHFRPsLjhrUzebORj6tK/bq?=
 =?us-ascii?Q?OJu506n2VK+TYy203tFKm6m9L9Rwib70naq/KIQw3OYSjPtdE2E26jZvM3Oo?=
 =?us-ascii?Q?/YSagYIDt9pQ3dAtzl21Qx6WT/F4ckoebj6Ltg7PzBxxGN2QSP6rdeB2Nw2M?=
 =?us-ascii?Q?PRerMeef9kY7N1y/CUSX1T78bIDyu5JEa6p1bcLiFkHyQu2cH6+88JZVqCWa?=
 =?us-ascii?Q?XW5yKrxokrYoGHnx0apektPWjpruT0hrRs8d8z28u5Khwzb0QjuwWVIVQKnC?=
 =?us-ascii?Q?XLCDMSRCKeKUlR6b8cUUpykvlGNAkDTjDVR3Ni6Tm6guKjLuvHWGh14Lx4YD?=
 =?us-ascii?Q?5lomF6LVdkCl9R+xliXIOUGh3z8+p6Q2MhQSTEieyh2T/4f9kJ8HSGebAjhI?=
 =?us-ascii?Q?h7VM9HI4nTUuFqbcEUY5MNcvB+VzF1gX+evlm8CRwvpxldvYNVmeWd63zJBA?=
 =?us-ascii?Q?dqlKF8InxoKF2XHaGn/8RxjV55WNFxt871b6vYY9BfDMKjwShk3vTxBHqUIu?=
 =?us-ascii?Q?/SSD/rnwDFNMZbNg2OT6jG+gcdHSF6+OuqQZP5TU8Ck3yKqeHWkS1Tn8mjUI?=
 =?us-ascii?Q?qU4KeMX/WQ5S8A1xgnYsB614QO1w/mFe2Fb9oxFUp27nDdp8u9Q8v8p1vsJL?=
 =?us-ascii?Q?meE+nMy+F7Zx2K8VDcJu1o1rKqtZlvIxJgc9f5xW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b1cff4e-49a0-41ba-c127-08de3c102f34
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 19:28:54.4447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DlwYi0uKQcNkKK4zNU/YMo3uxRZYTwSspzGyWvnm6ciGvurSj5Bns3DTTdQDkfEGp6x89vDsm65725kg2RoMqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7938

On Mon, Dec 15, 2025 at 09:33:54PM +0300, Dan Carpenter wrote:
> On Mon, Dec 15, 2025 at 10:56:49AM -0500, Frank Li wrote:
> > On Mon, Dec 15, 2025 at 05:41:43PM +0300, Dan Carpenter wrote:
> > > The s32g devices have a GPR register region which holds a number of
> > > miscellaneous registers.  Currently only the stmmac/dwmac-s32.c uses
> > > anything from there and we just add a line to the device tree to
> > > access that GMAC_0_CTRL_STS register:
> > >
> > >                         reg = <0x4033c000 0x2000>, /* gmac IP */
> > >                               <0x4007c004 0x4>;    /* GMAC_0_CTRL_STS */
> > >
> > > We still have to maintain backwards compatibility to this format,
> > > of course, but it would be better to access these through a syscon.
> > > First of all, putting all the registers together is more organized
> > > and shows how the hardware actually is implemented.  Secondly, in
> > > some versions of this chipset those registers can only be accessed
> > > via SCMI, if the registers aren't grouped together each driver will
> > > have to create a whole lot of if then statements to access it via
> > > IOMEM or via SCMI,
> >
> > Does SCMI work as regmap? syscon look likes simple, but missed abstract
> > in overall.
> >
>
> The SCMI part of this is pretty complicated and needs discussion.  It
> might be that it requires a vendor extension.  Right now, the out of
> tree code uses a nvmem vendor extension but that probably won't get
> merged upstream.
>
> But in theory, it's fairly simple, you can write a regmap driver and
> register it as a syscon and everything that was accessing nxp,phy-sel
> accesses the same register but over SCMI.

nxp,phy-sel is not standard API. Driver access raw register value. such
as write 1 to offset 0x100.

After change to SCMI, which may mapped to difference command. Even change
to other SOC, value and offset also need be changed. It is not standilzed
as what you expected.

>
> > You still use regmap by use MMIO. /* GMAC_0_CTRL_STS */
> >
> > regmap = devm_regmap_init_mmio(dev, sts_offset, &regmap_config);
> >
>
> You can use have an MMIO syscon, or you can create a custom driver
> and register it as a syscon using of_syscon_register_regmap().

My means is that it is not necessary to create nxp,phy-sel, especially
there already have <0x4007c004 0x4>;    /* GMAC_0_CTRL_STS */

Frank

>
> > So all code can use regmap function without if-then statements if SCMI work
> > as regmap.
> >
>
> regards,
> dan carpenter
>

