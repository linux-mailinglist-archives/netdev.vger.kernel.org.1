Return-Path: <netdev+bounces-228204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E654BC4837
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 13:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C55493BAF24
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 11:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA0A2F6190;
	Wed,  8 Oct 2025 11:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="S0sgqAcJ"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013019.outbound.protection.outlook.com [40.107.162.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7C122D4F6;
	Wed,  8 Oct 2025 11:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759921869; cv=fail; b=fqHi68/uW1eVyV0UIMTK2CCF+ayiI3741rxpUpHAT6Tq7odVeFk2fcACT+0hqujidMO5AzUL6OBibhpURldLVl2N5DYuPrCiBs5RbVwd5IEC96v1yloVttg09rhFn4nvtGMPfjRhxHtjFa1kDZDhPcCiddjM0Ng9WwRpfniTlzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759921869; c=relaxed/simple;
	bh=zVC4kg4skvY0rKIOdxTTO/bceY3Ao637/ZiAEAPM034=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aulrnFOmi0emupnA9mo5x7fD+jjJc4l+jlTJxyB739Sbpmr6ugvA5ONwRtVFSrBLpFb27JDG9DLmHXPLvjbXIVnlGlc6EojxSPu+GGBMaBxJOak0PUeQC9AlY906d0MqNWSxowE6/VAPIigReniJ6Tyk33vZghyb6DqKFv1dm0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=S0sgqAcJ; arc=fail smtp.client-ip=40.107.162.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EHJkc7ZrufUKMXi9Z+iEdwtHq5i0IAGEpP1T6S1l390Lr4sLvk6AMc0WGA0l9nGtwvLYJKGq8JXrNN+Zv9T58RROtMT1KumdlXVD2K7Z7lvSBpyZuMiYOmj2Qd39l0BFcF8mWOZVn10B/wHzd7gXJPjISYvLl/1Jqc28807yjGVjHEYsCtVD7m+4m6GcIshOWu0hn0l9o0vKiOuTuEnUVpPkZiFCKi8vtgFChH6CcQaXm0uIq+MHWMJC5/XPiYFP51dRsV1oOkjAT1v9xgwBo3fV/P66EW+Bxz6kQ7Gnp6LtEFqEr99Hn50xJzLIDQuhg8hd3AAY2ap6QF61CQE6gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hb5GWs8lhV7ros5OfFIbpHyPj3KXtjTbVuvfJkJJHuw=;
 b=aTtzyrljZJz5vRTPL+fMET9JKApaUo7enrugUL8hJjQZbel0T5rP2xhVWSxSQKikCd4inwyDXhYwrM1eOsu1VFpC/7ho+dO0ey9Mitr3MeyBosLN6vSv8xW+b20LqzjVcGRLSBKlzxqyfDSqrJ6ty8svXKDLsYdQIPZy2T/PAoTLKJKyD6jsRT+UH+dPzPslkXndoMQSidVoJnE+sF4vp7/GzZZhpr2sWhPF6rKxYHzX3qBu0O5KnaQ+4Oa4gwf0dG4/LkgJ07YZXAnSHiK3YqnA0JdSVf1LcMgyx7DMihdcqhezUBBNBim43Do2PcKL7RYh3yR5OwB/vPHDBNUulw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hb5GWs8lhV7ros5OfFIbpHyPj3KXtjTbVuvfJkJJHuw=;
 b=S0sgqAcJOyp5G0PjmIknfzVFwDW8qYuJA6aamlOFxjf77i/taWp3ofGGgWMmjBUtUKHzZtxECSv+HCmGxhZNa93KHR3ps56JRssvIzCOQe+t8IHJCA0zvtHPf8PnwGuZk7A2hsGKIyyAe532LsNQjDw1Lb6pl6GZgWc2cBcpZTS3nKijOe4Tf2BFvmNaiKGO3nqRXeugd/HKwqLbMt2rMTiMkSHba2va+6ChLdnvV7zzTmnjz3ABlw8E4Oxa70jjkmgAK0QDuurhHEtRlQIhxsz/dSGiCDYUN4nRi9BQkYBApdjTu00DJUwUtrCwEoRmYJOV7HmvvW1UEsBJd3e6WQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM9PR04MB8716.eurprd04.prod.outlook.com (2603:10a6:20b:43f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Wed, 8 Oct
 2025 11:11:02 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 11:11:02 +0000
Date: Wed, 8 Oct 2025 14:10:59 +0300
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
Message-ID: <20251008111059.wxf3jgialy36qc6m@skbuf>
References: <aK6eSEOGhKAcPzBq@FUE-ALEWI-WINX>
 <20250827073120.6i4wbuimecdplpha@skbuf>
 <aK7Ep7Khdw58hyA0@FUE-ALEWI-WINX>
 <aK7GNVi8ED0YiWau@shell.armlinux.org.uk>
 <aK7J7kOltB/IiYUd@FUE-ALEWI-WINX>
 <aK7MV2TrkVKwOEpr@shell.armlinux.org.uk>
 <20250828092859.vvejz6xrarisbl2w@skbuf>
 <aN4TqGD-YBx01vlj@FUE-ALEWI-WINX>
 <20251007140819.7s5zfy4zv7w3ffy5@skbuf>
 <aOYXEFf1fVK93QeS@FUE-ALEWI-WINX>
Content-Type: multipart/mixed; boundary="twz3sslclvcmmfbv"
Content-Disposition: inline
In-Reply-To: <aOYXEFf1fVK93QeS@FUE-ALEWI-WINX>
X-ClientProxiedBy: VI1P189CA0010.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::23) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM9PR04MB8716:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c807ab4-8df0-44f6-ca94-08de065b5e30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|19092799006|1800799024|10070799003|366016|4053099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?buRVt9EI6BkJo0W8b9MXgM4t2b+Dg7gBRwoh1SLALZTTlXy+mfZM7/4UMlpr?=
 =?us-ascii?Q?fNf+TomnZaY2RumZN7QLlyJf6TOXF+93LCYYMIx2UhpN1J7HTeNioV2Q/yML?=
 =?us-ascii?Q?PY0dEPuazb/H0GVhyV+DZzjWY8rVcQmY1qI39raxvwxsHK2qvySZfuJnOg85?=
 =?us-ascii?Q?9sGWmcNPEsPkmEAhz3LaAopOXLLQL1yFuD5u/qeMIzBynP0kMHer7eaofl8n?=
 =?us-ascii?Q?BYY54ZlttuqfEnNIRdJ1JYXTBY5yUurSDS+iY5o2G3fPZAcMmIJ4ZlFORKRz?=
 =?us-ascii?Q?mw1pC620zSmdwtl+hlnoe1ECFFSZAcYde+e3IcyNMsW6i7T9FgZuv9pD2P0I?=
 =?us-ascii?Q?RZT5S2+5aDJHsdLtFIL0+0vKnDJ1t3zhqLAps0DfHXwqxU6opXO9IDzFglFL?=
 =?us-ascii?Q?Nuhqn9DA5ppFdMb2Yf+8tVfZ7+64/WGL6gEFAEQH8vV69K5OVQchkVIWQbQz?=
 =?us-ascii?Q?PM9QtA37ruEmXDM93YiayeYK0edRrqBQb5B1WtkHWi5bMtgLVKTt9cUyyRQU?=
 =?us-ascii?Q?3I4Hyn07MvLC3Miti2nOzh6LAuY+LI1Z+Wx0jMsZTX7eG7cz9280qpFUSR1U?=
 =?us-ascii?Q?RbbefPT4o21gWafJU9/tAWBL6X9J82A5tmmTwH+nsq+jwBszmHoRmFb0TZC/?=
 =?us-ascii?Q?gSK+psODdb9SR6GuHrxQ25ACFpsAYT8H6dUkuyS4Sxsfc+wEyrL/4SigJYpX?=
 =?us-ascii?Q?N5dvoOGO6uX7BJCegtv642rAY4D4m4495WDd1Q3ko0G0EAtdYi86+WGxc6fP?=
 =?us-ascii?Q?XsRcGZPwHypc/hQQt2klWlqX0IARCWoN5H5BYYiWkEpdPZ0ThTpilfhVe9+t?=
 =?us-ascii?Q?vrVpoS50lP48hE62PpCSKKPBjln+n9jZeQgXUCtZXrfNXGNs0eI/FFmrBdKn?=
 =?us-ascii?Q?UuzhsR3/IMLviZA8inCgvcumXcd64VqI5jgR0kQWBJbDudovpQse8vzOw47Q?=
 =?us-ascii?Q?CtwYAhQFvnP2cdqAGiTlZIUrXcS8koKf2U0pjZ0EVQ5ZV9WNqI1kU/P/d8G1?=
 =?us-ascii?Q?nZR4LCRR8KX774XMqZopTLlibOHr5vlc6Qj8llFLoNkIccpm1cGAYse5oxAo?=
 =?us-ascii?Q?kJwt77VBjs+Ojn9p+6tNZAaO6TeONPANyP67cj8qDjGRZkpd9yaEH3ZDpXh4?=
 =?us-ascii?Q?eVI0Rf3YPv5CPOnV3sNgfECqbS8c2cDL6GP102KNMo0w9LRv3e8PM9U5kMY0?=
 =?us-ascii?Q?+E+plI1okM/aE24wEqeM/rly1pqMwWRcxzso+mIampxBvZzsfB4NzZ20u78a?=
 =?us-ascii?Q?bvrOoqxGWITcVIRD8k7MevoQKwUcgVp7bAkf9kI3kh9tJGd6UethE6vB39Sm?=
 =?us-ascii?Q?f5D8nRbtPeHOD09O3QATWnJcaeJndVds6oqrvSO6mFpPrRSmDG2TtLGbQPmv?=
 =?us-ascii?Q?m43nkOc5wpqgqEGeiKrk23gB2Knd1YLkhxVuQWjqPfD1Pvg5udam1r+PEaEp?=
 =?us-ascii?Q?uCbp9HCQG5CIfbHwARyL/Xjj8X0DiSjFNPdo/uHRzN8KLJvqA994mg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(19092799006)(1800799024)(10070799003)(366016)(4053099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wNul6mzTbR47yHpS5B4gU9JXcdEVID7Z071GhG7Z0KlneW9dJfofAqsWfRlM?=
 =?us-ascii?Q?1S8HhjzR//lU6EJvv0oLh6ebZIrtP9iQ3Yz0CJvZ7nOMP9ebj5kDnzkrI06y?=
 =?us-ascii?Q?MusCFDCXhF/tGGRPh3PcJbBbP7Wa7BcxKF94sll7xSiaA8sDJZmY7cq5ydoy?=
 =?us-ascii?Q?UgMiUPSdpKJgOtNSlKOgdGxGcLy9Amruk+YZwJdcCnNhlXrAPjB8pvEL4B75?=
 =?us-ascii?Q?1ID9Wd9nS+f2R2c8QfavXnqcFbmQwmc935wkE2rsqm4Xkyn6C3qP+IWZQ8cJ?=
 =?us-ascii?Q?AjE0whRLZj5jZl8oMFrT0ghqW9d7FMA9HdNvmHdVkrbp6CorMsYHruiD8Pfw?=
 =?us-ascii?Q?b/gIg0/xrix/IKeNx3TmFCDrJsSDowVC58eQJZUmO7c5DbP2DR2WrHH16FfG?=
 =?us-ascii?Q?nl6JHFweSMmmjZeLGQ2d1adt4FKfUEOG2jpinrCPPQLE3MDvUdCSiEcuh4OO?=
 =?us-ascii?Q?/Hgi88U8Th0gf/gzlNj7OfwfgvXvrcA4xsAAmQZZHU8BEHXdwcPr6Zn19dAr?=
 =?us-ascii?Q?0MsCYyO1UJ+EFdoknKWCgtM8GALSsxlKW6Ozi1R7op7XzBv8JLZI2hwfzJSK?=
 =?us-ascii?Q?IxOrt0Xj8suz4ei/4vl2dDUAT883BO2/eJCykMEDwiPmlQPSEIhOixONl+vy?=
 =?us-ascii?Q?dJtz3Pfj6gJbho6tCpTRusxQPDweWPQu1K27uJgnrLi17m/ieOci+BZseTt9?=
 =?us-ascii?Q?x0qGPAkjTMGE7cbiVPxwBH7wzzuuAyEnpCzYVgLFQl+WnOcoZ6eLRdpKWxH7?=
 =?us-ascii?Q?DHomHygmxdnNKRHSoYewH6JLprwS/hEmnjZE2imdQYHZ6ZddOGMEYgzekWB6?=
 =?us-ascii?Q?ZxKhIXUTIC+LcwQmvXbKC93RAnnp1vGowN9f1koxsmH+PfsK30v811h0cIpA?=
 =?us-ascii?Q?2xdFsjW+7QrCKAAPOukz+68SH+WuwBtWbjfcrTGSsakkYQ71NxsoCLi27IyV?=
 =?us-ascii?Q?GObHyHqB60lR5amdHRPv8eNR/1PgTVUSdPo42N8Lhcz9B5thVy9uMnlNnrUx?=
 =?us-ascii?Q?Rppjx6bN9x/aZdw2uhnirrgM7FxD6hBS9RfE3xUffcoq8Kn28VQQ+/mO+E69?=
 =?us-ascii?Q?y3RxUdwU6ZE9KPnb+3L3FEDQ69WDh2JVRaEb2CuRsRFyiv67VEY1lb/cY0Y8?=
 =?us-ascii?Q?hlXZWfvw4vLCmP0F4O/94TLY2U1lomyzWfYBEe0DDZaW51aLAY2sfkUoMj01?=
 =?us-ascii?Q?VivD2SjXWuGyM1n9nM3M1GkJDdbFahDcfEfJ8o8WCUq37NEmnLxl1IopX27L?=
 =?us-ascii?Q?+E3gYe5bfPccA+z7jl1m+zsoltS85iygMN+/caZAabcwKmMHGRQvxTl0TNPI?=
 =?us-ascii?Q?7yupV/74DPEyaB6ECR5nyP/HpLyi5XkaZtisP6MaWtcHMpRPcnEXYuCIi9Vv?=
 =?us-ascii?Q?DoipMdFlNc/QIt5vL1CylSOC2QTfhKgU5hKhPIqrL1G8ZRWvMaHF3j8X9X2v?=
 =?us-ascii?Q?olSayIfwFPq5hBUwambfebkW6R3h9V1DmliFP6diYWS7fSct6okGxllkXzRr?=
 =?us-ascii?Q?io+9moIu6NvqhZT2H67TDT2Pc72YsSvOFyfHoXTosvaOZYVJ/rvIK/URHq3w?=
 =?us-ascii?Q?cPDwTlBT6kLlBVuCWZB0kLTfDoL0LH9CKnpj+o9brcWT2nyiCo94f8cEuhfe?=
 =?us-ascii?Q?GUVUjwHYlzm2ktK16iKah9dx47HqgNDHBHxle2q+oEfBNUR4k6MNpV+2la3L?=
 =?us-ascii?Q?VzaBFA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c807ab4-8df0-44f6-ca94-08de065b5e30
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 11:11:02.7409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F7OzVsLO4GMMRACa/iyLdaUt3LJxaX4GTEMfpLjFwjYxzsqpwgDzPGjgnVKY412MFOaVaKs/fL076Skt8QTk2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8716

--twz3sslclvcmmfbv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 08, 2025 at 09:47:28AM +0200, Alexander Wilhelm wrote:
> On Tue, Oct 07, 2025 at 05:08:19PM +0300, Vladimir Oltean wrote:
> > Hi Alexander,
> [...]
> > Sorry for the delay. What you have found are undoubtebly two major bugs,
> > causing the Lynx PCS to operate in undefined behaviour territory.
> > Nonetheless, while your finding has helped me discover many previously
> > unknown facts about the hardware IP, I still cannot replicate exactly
> > your reported behaviour. In order to fully process things, I would like
> > to ask a few more clarification questions.
> 
> Sure.
> 
> > Is your U-Boot implementation based on NXP's dtsec_configure_serdes()?
> > https://github.com/u-boot/u-boot/blob/master/drivers/net/fm/eth.c#L57
> 
> Unfortunately, I am working with an older U-Boot version v2016.07. However,
> the bug I fixed was not part of the official U-Boot codebase, it was
> introduced by our team:
> 
>     value = PHY_SGMII_IF_MODE_SGMII;
>     value |= PHY_SGMII_IF_MODE_AN;
> 
> I added the missing `if` condition as follows:
> 
>     if (!sgmii_2500) {
>         value = PHY_SGMII_IF_MODE_SGMII;
>         value |= PHY_SGMII_IF_MODE_AN;
>     }
> 
> With the official U-Boot codebase I don't have a ping at none of the
> speeds:
> 
>     value = PHY_SGMII_IF_MODE_SGMII;
>     if (!sgmii_2500)
>         value |= PHY_SGMII_IF_MODE_AN;
> 
> > Why would U-Boot set IF_MODE_SGMII_EN | IF_MODE_USE_SGMII_AN only when
> > the AQR115 resolves only to 100M, but not in the other cases (which do
> > not have this problem)? Or does it do it irrespective of resolved media
> > side link speed? Simply put: what did the code that you fixed up look like?
> 
> In our implementation, the SGMII flags were always set in U-Boot,
> regardless of the negotiated link speed. My assumption is that the SGMII
> mode configuration results in a behavior where only a 100M link applies the
> 10x symbol replication, while 1G does not. For a 2.5G link, the behavior
> ends up being the same as 1G, since there is no actual SGMII mode for 2.5G.

Yes, this assumption seems to hold water thus far, but I have to
validate it by seeing the debugging print for 1G/2.5G, once we figure
out the debug printing aspect.

> > With the U-Boot fix reverted, could you please replicate the broken
> > setup with AQR115 linking at 100Mbps, and add the following function in
> > Linux drivers/pcs-lynx.c?
> > 
> > static void lynx_pcs_debug(struct mdio_device *pcs)
> > {
> > 	int bmsr = mdiodev_read(pcs, MII_BMSR);
> > 	int bmcr = mdiodev_read(pcs, MII_BMCR);
> > 	int adv = mdiodev_read(pcs, MII_ADVERTISE);
> > 	int lpa = mdiodev_read(pcs, MII_LPA);
> > 	int if_mode = mdiodev_read(pcs, IF_MODE);
> > 
> > 	dev_info(&pcs->dev, "BMSR 0x%x, BMCR 0x%x, ADV 0x%x, LPA 0x%x, IF_MODE 0x%x\n", bmsr, bmcr, adv, lpa, if_mode);
> > }
> > 
> > and call it from:
> > 
> > static void lynx_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
> > 			       struct phylink_link_state *state)
> > {
> > 	struct lynx_pcs *lynx = phylink_pcs_to_lynx(pcs);
> > 
> > 	lynx_pcs_debug(lynx->mdio); // <- here
> > 
> > 	switch (state->interface) {
> > 	...
> > 
> > With this, I would like to know:
> > (a) what is the IF_MODE register content outside of the IF_MODE_SGMII_EN
> >     and IF_MODE_USE_SGMII_AN bits.
> > (b) what is the SGMII code word advertised by the AQR115 in OCSGMII mode.
> > 
> > Then if you could replicate this test for 1Gbps medium link speed, it
> > would be great.
> 
> For now, I have reverted both the U-Boot and kernel fixes and added debug
> outputs for further analysis. Unfortunately the function
> `lynx_pcs_get_state` is never called in my kernel code. Therefore I put the
> debug function into `lynx_pcs_config`. Here is the output:
> 
>     mdio_bus 0x0000000ffe4e5000:00: BMSR 0x29, BMCR 0x1140, ADV 0x4001, LPA 0xdc01, IF_MODE 0x3
> 
> I hope it'll help to analyze the problem further.

Correct. lynx_pcs_get_state() is only called for MLO_AN_INBAND (managed = "in-band-status"),
which the Lynx PCS driver does not currently support for 2500base-x.

However, I don't fully trust the positioning of the debug print into lynx_pcs_config().
The BMCR, ADV and IF_MODE registers look plausible, as if lynx_pcs_config() did what it
was supposed to do, but LPA (link config code word coming from AQR115) looks strange.
Field 11:10 (COP_SPD) is 0b11, which is a reserved value, neither 1G nor 100M nor 10M.
Maybe this is the mythical "SGMII 2500" auto-negotiation? Anyway, I don't think there is
any standard for it, and even if there was, the Lynx PCS doesn't implement it.

I'm surprised your AQR115 would transmit in-band code words for OCSGMII. None of the Aquantia
PHYs I've tested on were able to do that, and I'm not sure what register controls that.
If we look at your previous debugging output of the global system configuration registers:
https://lore.kernel.org/lkml/aJH8n0zheqB8tWzb@FUE-ALEWI-WINX/
we see that for 100M line side, the PHY uses "SerDes mode 4 autoneg 0". I also tried modifying
aqr_gen2_config_inband() to set VEND1_GLOBAL_CFG_AUTONEG_ENA for OCSGMII, but it didn't appear
to change anything, so that's probably not the setting. I'll have to ask somebody at Marvell.

In any case, contrary to my previous beliefs and according to your finding plus my parallel
testing, the Lynx PCS actually supports in-band auto-negotiation at 2500 data rate - both
2500base-x auto-negotiation and SGMII auto-negotiation (to the extent that this is a thing
that actually makes sense - it doesn't).

With IF_MODE=3 (SGMII_EN | USE_SGMII_AN), the PCS will automatically reconfigure the data path
for the speed decoded in hardware from the LPA_SGMII_SPD_MASK bits. Apparently it does this
for the lane data rate of 2500 just the same as it does it for 1000, just that the
LPA_SGMII_SPD_MASK bits need to be 0b00 (gigabit) for traffic to pass. Otherwise, it tries to
perform symbol replication (as per your hw engineer's claim), and that didn't work in my testing
either(* details at the end).

I'm not saying that IF_MODE=3 is a valid configuration when the lane data rate is 2500.
It absolutely isn't, and your patch which changes IF_MODE to 0 seems ok. I'm just trying to
understand and then re-explain what the PCS does when configured in this mode, based on the
evidence.

Specifically when LPA_SGMII_SPD_MASK/COP_SPD is 0b11, it isn't documented how it would behave,
I don't have a protocol analyzer to count replicated symbols, and I'm unable to obtain a
functional data path to measure bandwidth with iperf3. Your hardware engineer's claim remains
the most trustworthy source of information we have.

Regarding lynx_pcs_get_state(): I actually was working on the patch attached, which I had in my
tree and I didn't realize it would impact your testing. I would kindly ask you to apply as well.
Applying it alone would be enough to fix the IF_MODE=3 problem, but fixing the problem is not
what we want, instead we want to see the MII_LPA register value at lynx_pcs_get_state() time,
and for multiple link speeds.

For that, please break the link again, by making the following changes on top:

1. Configure IF_MODE=3 (SGMII autoneg format) for 2500base-x:

diff --git a/drivers/net/pcs/pcs-lynx.c b/drivers/net/pcs/pcs-lynx.c
index a88cbe67cc9d..ea42b8d813f3 100644
--- a/drivers/net/pcs/pcs-lynx.c
+++ b/drivers/net/pcs/pcs-lynx.c
@@ -152,11 +152,10 @@ static int lynx_pcs_config_giga(struct mdio_device *pcs,
 		mdiodev_write(pcs, LINK_TIMER_HI, link_timer >> 16);
 	}

-	if (interface == PHY_INTERFACE_MODE_1000BASEX ||
-	    interface == PHY_INTERFACE_MODE_2500BASEX) {
+	if (interface == PHY_INTERFACE_MODE_1000BASEX) {
 		if_mode = 0;
 	} else {
-		/* SGMII and QSGMII */
+		/* SGMII, QSGMII and (incorrectly) 2500base-x */
 		if_mode = IF_MODE_SGMII_EN;
 		if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
 			if_mode |= IF_MODE_USE_SGMII_AN;

2. Edit your MAC OF node in the device tree and add:

&mac {
	managed = "in-band-status";  // this
	phy-mode = "2500base-x";
};

This will reliably cause the same behaviour as before, but with no dependency on U-Boot.

Because aqr_gen2_inband_caps() (code added recently to net-next) returns 0 (unknown)
for 2500base-x, phylink doesn't know whether the PHY will send or not in-band code words.
It will have to trust the firmware description with managed = "in-band-status", which will
lead neg_mode to be PHYLINK_PCS_NEG_INBAND_ENABLED, which will cause IF_MODE_USE_SGMII_AN
to be set.

Note: this is something else we'll have to look at later too. What bits control "OCSGMII"
link codeword transmission in Aquantia PHYs?

Your earlier assumption about why 100M is broken but 1G / 2.5G are not
only holds water if, as a result of testing at these other link speeds,
you find the MII_LPA register to contain 0b10 (Gigabit) in bits 11:10
(COP_SPD / LPA_SGMII_SPD_MASK). Aka it worked, but it was purely accidental,
because phylink thought 2500base-x would not use autoneg, yet it did,
and by some miracle the SGMII format coincided and resulted in no change
in the link characteristics.

Regarding my patch vs yours, my thoughts on this topic are: the bug is
old, the PCS driver never worked if the registers were not as expected
(this is not a regression), and your patch is incomplete if MII_BMCR
also contains significant differences. I would recommend submitting
mine, as a new feature to net-next, when it reopens for patches for 6.19.
I've credited you with Co-developed-by due to the significance of your
findings. Thanks.

(*) When testing forced 10x SGMII symbol replication on a 3.125 Gbps
lane over a pair of optical SFP+ modules connected between two LS1028A Lynx PCS
blocks, I can see packets being transmitted, but on the receiver, the
RFRG mEMAC counter increases (rx_fragments). The documentation says for this:
"Incremented for each packet which is shorter than 64 octets received with
a wrong CRC. (Fragments are not delivered to the FIFO interface.)"
Without dedicated equipment, I'm unsure how to push this further.

--twz3sslclvcmmfbv
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-net-pcs-lynx-accept-in-band-autoneg-for-2500base-x.patch"

From 19a375a81f3dae953410f8da607e89c34095a21c Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Fri, 3 Oct 2025 17:20:20 +0300
Subject: [PATCH] net: pcs: lynx: accept in-band autoneg for 2500base-x

Testing in two circumstances:

1. back to back optical SFP+ connection between two LS1028A-QDS ports
   with the SCH-26908 riser card
2. T1042 with on-board AQR115 PHY using "OCSGMII", as per
   https://lore.kernel.org/lkml/aIuEvaSCIQdJWcZx@FUE-ALEWI-WINX/

strongly suggests that enabling in-band auto-negotiation is actually
possible when the lane baud rate is 3.125 Gbps.

It was previously thought that this would not be the case, because it
was only tested on 2500base-x links with on-board Aquantia PHYs, where
it was noticed that MII_LPA is always reported as zero, and it was
thought that this is because of the PCS.

Test case #1 above shows it is not, and the configured MII_ADVERTISE on
system A ends up in the MII_LPA on system B, when in 2500base-x mode
(IF_MODE=0).

Test case #2, which uses "SGMII" auto-negotiation (IF_MODE=3) for the
3.125 Gbps lane, is actually a misconfiguration, but it is what led to
the discovery.

There is actually an old bug in the Lynx PCS driver - it expects all
register values to contain their default out-of-reset values, as if the
PCS were initialized by the Reset Configuration Word (RCW) settings.
There are 2 cases in which this is problematic:
- if the bootloader (or previous kexec-enabled Linux) wrote a different
  IF_MODE value
- if dynamically changing the SerDes protocol from 1000base-x to
  2500base-x, e.g. by replacing the optical SFP module.

Specifically in test case #2, an accidental alignment between the
bootloader configuring the PCS to expect SGMII in-band code words, and
the AQR115 PHY actually transmitting SGMII in-band code words when
operating in the "OCSGMII" system interface protocol, led to the PCS
transmitting replicated symbols at 3.125 Gbps baud rate. This could only
have happened if the PCS saw and reacted to the SGMII code words in the
first place.

Since test #2 is invalid from a protocol perspective (there seems to be
no standard way of negotiating the data rate of 2500 Mbps with SGMII,
and the lower data rates should remain 10/100/1000), in-band auto-negotiation
for 2500base-x effectively means Clause 37 (i.e. IF_MODE=0).

Make 2500base-x be treated like 1000base-x in this regard, by removing
all prior limitations and calling lynx_pcs_config_giga().

This adds a new feature: LINK_INBAND_ENABLE and at the same time fixes
the Lynx PCS's long standing problem that the registers (specifically
IF_MODE, but others could be misconfigured as well) are not written by
the driver to the known valid values for 2500base-x.

Co-developed-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/pcs/pcs-lynx.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/net/pcs/pcs-lynx.c b/drivers/net/pcs/pcs-lynx.c
index 677f92883976..a88cbe67cc9d 100644
--- a/drivers/net/pcs/pcs-lynx.c
+++ b/drivers/net/pcs/pcs-lynx.c
@@ -40,12 +40,12 @@ static unsigned int lynx_pcs_inband_caps(struct phylink_pcs *pcs,
 {
 	switch (interface) {
 	case PHY_INTERFACE_MODE_1000BASEX:
+	case PHY_INTERFACE_MODE_2500BASEX:
 	case PHY_INTERFACE_MODE_SGMII:
 	case PHY_INTERFACE_MODE_QSGMII:
 		return LINK_INBAND_DISABLE | LINK_INBAND_ENABLE;
 
 	case PHY_INTERFACE_MODE_10GBASER:
-	case PHY_INTERFACE_MODE_2500BASEX:
 		return LINK_INBAND_DISABLE;
 
 	case PHY_INTERFACE_MODE_USXGMII:
@@ -152,7 +152,8 @@ static int lynx_pcs_config_giga(struct mdio_device *pcs,
 		mdiodev_write(pcs, LINK_TIMER_HI, link_timer >> 16);
 	}
 
-	if (interface == PHY_INTERFACE_MODE_1000BASEX) {
+	if (interface == PHY_INTERFACE_MODE_1000BASEX ||
+	    interface == PHY_INTERFACE_MODE_2500BASEX) {
 		if_mode = 0;
 	} else {
 		/* SGMII and QSGMII */
@@ -202,15 +203,9 @@ static int lynx_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 	case PHY_INTERFACE_MODE_1000BASEX:
 	case PHY_INTERFACE_MODE_SGMII:
 	case PHY_INTERFACE_MODE_QSGMII:
+	case PHY_INTERFACE_MODE_2500BASEX:
 		return lynx_pcs_config_giga(lynx->mdio, ifmode, advertising,
 					    neg_mode);
-	case PHY_INTERFACE_MODE_2500BASEX:
-		if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED) {
-			dev_err(&lynx->mdio->dev,
-				"AN not supported on 3.125GHz SerDes lane\n");
-			return -EOPNOTSUPP;
-		}
-		break;
 	case PHY_INTERFACE_MODE_USXGMII:
 	case PHY_INTERFACE_MODE_10G_QXGMII:
 		return lynx_pcs_config_usxgmii(lynx->mdio, ifmode, advertising,
-- 
2.34.1


--twz3sslclvcmmfbv--

