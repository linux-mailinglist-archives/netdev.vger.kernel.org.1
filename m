Return-Path: <netdev+bounces-189082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B66AB050C
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 22:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F488189A0DE
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 20:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282AE21CC51;
	Thu,  8 May 2025 20:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aF7YptOT"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013021.outbound.protection.outlook.com [52.101.72.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1EA20E01B;
	Thu,  8 May 2025 20:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746737810; cv=fail; b=o4DxqNNIj39/wialHCnAX7E2A/PnrnC4UK9Px9LdMiEeQdWtLvtLAQIzK1ONcjEUg5MVhoi8/Zis23Ln6TqgMoEQvWg6jZymbDbf38PiL2R744Ulun7HktSK6SRbXtPtwjNJcBJyZ3bNbE6svPSKFuSWVaokFS6v9qWEAvKyRtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746737810; c=relaxed/simple;
	bh=yZNaEb9kslYN2XCynZ4SRlglP4HFSxxIDm6VCHAz0qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QS+/TWI++eERajtuLS1+7WnuS/a8EvubKUb6KfPhUhZybt+WC0XT/bZuQsebkls2eQ8IVPZYJrolx60sUd+/SWw4UieERrXJkK6cOD47o3xdSrvi8loj9tkFqc5vfCzky43g5t/MsQ+KcMTeTUKWPqoH+Nl/WvTwNryVMCpEebU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aF7YptOT; arc=fail smtp.client-ip=52.101.72.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sy5TDOGhNS/VwK3FpZ0Rt+qiJUs3TaC22PkmzptOr2gG1dabuVyACmRsWBO0WkfrBfesmNXPKb9XVlBxWqkdERXW8vxIuCTl+Q0Z2GrHJWWWuyYgc5Hw2GZshvQQoEqwE5zOXPnvfsjW82zdHQV16DrGXLAZx6AaZ53km3hXh5mdhXERDG97sngtDzxRvKdm4SRcYVa1sqNpcv06CA7HsIaaNmfdZpnpK0G5yQfGMfsCvdMgatlq4fmZnT0fN6gNCUx470c2IG/G7TDriC5NmFVpv2YomxP6QzN+E4+/fBofVe+YA2BWuPtIui8NHpkG+l0Bc8xsbGBSBNA7BIFpqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s04JLmn0ALXYLXAmgAUJezXSJP1ha5mbune+3LfdDW4=;
 b=lpiWdkW1mL2RRtCSAeLPkfkXCvXrSNZaP33Mn9dqp0fUkx17MzqP+GGWJDHT7SybbDEAYJxdjWbEgcZmyhnIe3Qf9v0Hnt7SXFYqQmE87/Vaft9e7arRqOP0yDrE0Xvhk3Xc9R6UwErhGEcQYyvU7Usq/zEBIr5X1673/Ixgdz0MCxDNYaCLB5KMw3X9K5+Fq6V5sxK9OLqpeoO90hCD6wVQceHqpnGm7AjGC+sW/LjTjmGIijuF8e6B7Be4qSSYGUkk3c8kiLAPHd/68gzsP/tVu7hwTcrCS9MvvZSfR08ULJau4o7sQuiX6OFPGrD590qoYtjjTx7n0IRyqeTooQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s04JLmn0ALXYLXAmgAUJezXSJP1ha5mbune+3LfdDW4=;
 b=aF7YptOTO1kYq7/gqRjvPvrl8wkRabf7s2ppBETj5B52qP81E/4DqUiFTQqd+w6rLVpOkqCtihYDW6+11OV4XVNKFllrs8iZvJcpZFP2zjwABcMw2Srii8YqzEIwJtzZCfbOUgrQvYSyUs+/4XLQWtb+xnf20GDRJqFFbgYsCkDWRX5G4Tzpi0tOzo1FixBOAIFjc3IsEd/C6vr+sSTqLDUEcdqUXWQNG+sflP7O3h0Nf7RY/8HM1Z6QTlmgRHc0m1WeOD4FdH2vI9jv7WpCyaERW4RpjVTtDJqSayq948/8QtaEnDhKp1GoDYS4zKBJn2UxqS9+MuOcGXeYnuYAaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA4PR04MB9389.eurprd04.prod.outlook.com (2603:10a6:102:2a8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Thu, 8 May
 2025 20:56:45 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 20:56:45 +0000
Date: Thu, 8 May 2025 23:56:41 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: netdev@vger.kernel.org,
	=?utf-8?B?S8ODwrZyeQ==?= Maincent <kory.maincent@bootlin.com>,
	Kurt Kanzenbach <kurt@linutronix.de>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: convert to ndo_hwtstamp_get() and
 ndo_hwtstamp_set()
Message-ID: <20250508205641.dsoksrasn4wicz76@skbuf>
References: <20250508095236.887789-1-vladimir.oltean@nxp.com>
 <21e9e805-1582-4960-8250-61fe47b2d0aa@linux.dev>
 <20250508204059.msdda5kll4s7coti@skbuf>
 <1aab25ca-aed5-4041-a42a-59922b909c02@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1aab25ca-aed5-4041-a42a-59922b909c02@linux.dev>
X-ClientProxiedBy: VI1PR03CA0075.eurprd03.prod.outlook.com
 (2603:10a6:803:50::46) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA4PR04MB9389:EE_
X-MS-Office365-Filtering-Correlation-Id: a5aed0e5-4abd-4c06-5506-08dd8e72d768
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N5E8wEu0ZDNjzQGtKm7xlOKckpI0+Uv+JADPrSkFfk6hfflW8jncBi2R9ek5?=
 =?us-ascii?Q?BcBD5eGb6EYvZY4WJM64g1s000nXOUYEyztWa3yFRhbOPnrg85E6FU8RCGE+?=
 =?us-ascii?Q?P/UlMxMC41s5MGgAp0mQbi2ebIDx5mBFjt0BvmYqBFcp7fCC42JhArInpznD?=
 =?us-ascii?Q?V2IHQUOKCxV4HFiynxan2nNIwTr7sckNww0C+/HgY+duhdjqzWxKRcnGqya7?=
 =?us-ascii?Q?uuj4wRvuabEG4epvW0/vQD+QUgJ+ioh6aPlKELKHdInAkoSK2yPPnRkhPRZu?=
 =?us-ascii?Q?kXfyGL/vEpxV33TgRBv3ea6EeOTcvMx9lXM/6fkv+EbejDWojm19oM309htb?=
 =?us-ascii?Q?cpVqfCRb9Hkw1K7oxX73i/BYSqOZu0BKgKpf7StKolx4vZxvh4HDdqqTHgJN?=
 =?us-ascii?Q?Pu2Cwt7Q/y7V8EIa2DjmRA+M4RsZdfwOOFH7zNMqu9qoQ1BSO37uUBLPjBaV?=
 =?us-ascii?Q?m+vQkl2s/csGyu21wz5LWziAIbfEJoWf9UtUpKJw+Nl9L8SJdQZUc4Q+6AtO?=
 =?us-ascii?Q?UK7FCyo2GocA9ERml9M93SDlnF3rbfqsRA7kG6WTv6KVljc01Xtpl4Hy7/lw?=
 =?us-ascii?Q?+2UszONNQVOQDwnylCJZzrTIaiUmZf+NuZRI9INzxhk4IByE9ZIZFvY6f7yB?=
 =?us-ascii?Q?Ae8hfZNuMIYxqHpUqBS7+2HDoQi1tKFR4i8/04inlo93cxHcQOsnUrrFpegg?=
 =?us-ascii?Q?W8xTabdUfDUVeAVIHXGSf1Q51w5plYy4c7/GKnYFXjz8JM1TBePTwXbndyhD?=
 =?us-ascii?Q?truu+t5fsm6A0O65Of1ZpmWbOau5v/cBdRjZxt5Va7WZ6FoMbQdDjEsprf44?=
 =?us-ascii?Q?ltmRcoDWMtK4K1gXGvAMVChIOfmeGh76C9fLgWOUzvIXkeJpVCu6SDuAHAZB?=
 =?us-ascii?Q?D8c40tcxP+yvYyEn+OBABNi/Qw3jtx9UYvg/Kr/IDfm+1f1ty/t+MZ0Ahfqu?=
 =?us-ascii?Q?cEA2Ght7Oj6lTg8HEJ+LBvZ3AM7+Y0pJQTtZVDlgilyr28Q3vCALXPE+9Dc7?=
 =?us-ascii?Q?A3mRYY5Rl58QGxL70lA8twNlhRxfdBQEboTMIFmTfDgYidfdUtIMYpwqAFhE?=
 =?us-ascii?Q?rGBaB736pvSZugJKZyi39AKy5rxgzBDeh0CLDwAHpikxkfkHURve2yk5QTE0?=
 =?us-ascii?Q?xPPzs0LZRySDmSEoSceh3DXy5T/CoaPvDKBBVvRZMau47zlrlVmHe8CkJC0x?=
 =?us-ascii?Q?gCcWApAcahO88Msp68kXUBtj02PWcAHavko366GQpdbSmo9c8LgYtmRj5ZFF?=
 =?us-ascii?Q?jB7kNDZEwH6ssG7LCLod6105HPzfug9L/M4QauN7CzUWjDFygvIQf1lkFUbe?=
 =?us-ascii?Q?cZq3DRCFGckM5brxOgtbpPIZsCn1SI/eBMUSKplg8cWKMYgKRSKge6twA7hW?=
 =?us-ascii?Q?d17WBJYJsvEq0iVhQsW1pBbGGCuGu52KR9KWKId3MMHgR9sw1qinb3P5Ba9w?=
 =?us-ascii?Q?JE1MqBnCSqc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qfh3Z2mnyBsG/schRwUA+4d2EOL5psWSwZ8jumEsKf4yzKxGUZ9sTkml/EoG?=
 =?us-ascii?Q?lgFxW9FxZDyv8BE42M8oQ5B8ZJtMMymUgId1iNhWCFmkcEVxeq0/djWnfG84?=
 =?us-ascii?Q?XDeYKVYXQOKBuyRRAIT050m4i/UByKBrVIHMZDOkRzxRT++6NTcPmgMpto4M?=
 =?us-ascii?Q?9CJu0TGbCdC2wFp0ZRnQJNBFxPmsDXeXkUc6gv58Ao4YFKFi/57Ox6RIREX5?=
 =?us-ascii?Q?R4yiYQNjs08scW8rMRDNrhAhBb2EI2Nm4zYHg+OXogKAiE94KZNr9PDiehtK?=
 =?us-ascii?Q?+KPeKQ0WvQ9Cxot36DEtf1ZUTAUm0wad3RD8cgA/ar/Zm3+P+G15Y7H46Adp?=
 =?us-ascii?Q?EKuKtPebDec0vHsNNVzRewS18zqpBOSouOa6KsgZlSfw8z5xcJs8obRsI+Pl?=
 =?us-ascii?Q?1qsdgCeP7DFseYwDMacfj+AHNxiTvORwIChTDJW+FxESudp9lRTp08aJpjx8?=
 =?us-ascii?Q?P3Mz5BP5SdkmAIpTt/VNEQ11oO7ZNo2uR5u7fbt4vjtnmTjGxZjGUWz+xkWi?=
 =?us-ascii?Q?woZKFMJLUDfyxg/e0zDo/cnmEJ8Eco2VSFkVTm+DwgYzfT8hRlhodbqw21zV?=
 =?us-ascii?Q?YRxzGzxYN9S5kzd4sFtDGSJf41vwcinvE4JoBjSmAX4evqkmYpVHAZHQsXgc?=
 =?us-ascii?Q?FovREeKfSxqWqirhC3JBONrkBT+n9uZBchXb8R1kN/AFLpbFrDaSIVqlo2gj?=
 =?us-ascii?Q?NoTdlg4u9T/LQgLlcXSLzBOPZ+4qESRUatLV/UxRXbaWX5vC0BmLLqCB7FZ3?=
 =?us-ascii?Q?mqW6wiUwDIaDFYsDBPnLXL1DzfbsXSMAa22V5rJDpCLKGJkxq1ggMnlpAUKx?=
 =?us-ascii?Q?LQiWuwInV8z88HBckJEillSIbQLEfHYWiRWa8fnneUFHTbyL/9DoQYeZZJxT?=
 =?us-ascii?Q?QTEKVQXmDiGgXRM5rQ80476mUesJB0wAgJyqgSIk73zbHun81+RWgxu6hOM1?=
 =?us-ascii?Q?WB77hxEbtnsDSi1GgLAWUAIL0NNO31tG6DZr2c8jvHFUcxbcvSnEVA8SzDFQ?=
 =?us-ascii?Q?pfgJ5mhTj8oGchFWWYvGjPO/Jy8U/dQVQEK2w4rMcgO20cgcs61/k2qLBcpW?=
 =?us-ascii?Q?Iv7kdcBMI8rX63XFyy/mzuDTKVQJ8jdRQ0K2UdpoXwxTJN1co/hdJwtrwxlK?=
 =?us-ascii?Q?VQmauyJt2Vx7sypG9fWmUbIggb4lEUoYluQgvfhoDqO0/1NXnEdifwW/TPAd?=
 =?us-ascii?Q?F7L3stpcfgHDnGM7Sx8JCU2mKiRMxICx4G38gwGrH3DRjNKBwIr1vn5jebu+?=
 =?us-ascii?Q?EVGDOmjzPKiri/8SFjQftQjNedzFglY/j7BEAVT5zN3j0YBqsIaWIvobOy6K?=
 =?us-ascii?Q?PMwlBmTvR6W5a0hIQKLK7nSvmNInUcDZNZsM6za4+hh9vBI0iGun0034NhDN?=
 =?us-ascii?Q?JAvTuBkIq+UOerOKfWibmHxAjCXfseKY0RV9JoQl8KDZnUejHulVs5X497wx?=
 =?us-ascii?Q?UQ/gA7cYSmkosnPgiIGU86dPGhVZKMRCdc5CM5vAGNnY91hQCCROfIKrmxYD?=
 =?us-ascii?Q?2MURiV1z0N3aGizyaldMBoKunoLJH5g/NHDFzZxQ9opNvkUGl98nokuHGK8R?=
 =?us-ascii?Q?M1gyt/J6sL9GzJN7plCzHlNunNpMRYG7ExpMi3urzz59SfgX/maeSwrdOXoJ?=
 =?us-ascii?Q?zw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5aed0e5-4abd-4c06-5506-08dd8e72d768
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 20:56:44.9511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hGPU4oYe63KKAxO6cR+iC7hAfiZJzz/f2zO7VJxNnScLqgVGSRRL8HHvUbLf9MmUv2HpDoaNxbPYZpE/WlVKxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9389

On Thu, May 08, 2025 at 09:48:40PM +0100, Vadim Fedorenko wrote:
> On 08/05/2025 21:40, Vladimir Oltean wrote:
> > On Thu, May 08, 2025 at 09:25:14PM +0100, Vadim Fedorenko wrote:
> > > The new interface also supports providing error explanation via extack,
> > > it would be great to add some error messages in case when setter fails.
> > > For example, HIRSCHMANN HellCreek switch doesn't support disabling
> > > of timestamps, it's not obvious from general -ERANGE error code, but can
> > > be explained by the text in extack message.
> > 
> > I wanted to keep the patches spartan and not lose track of the conversion
> > subtleties in embelishments like extack messages which can be added later
> > and do not require nearly as much attention to the flow before and after.
> > I'm afraid if I say "yes" here to the request to add extack to hellcreek
> > I'm opening the door to further requests to do that for other DSA drivers,
> > and sadly I do not have infinite time to fulfill them. Plus, I would
> > like to finalize the conversion tree-wide by the end of this development
> > cycle.
> > 
> > Even if I were to follow through with your request, I would do so in a
> > separate patch. I've self-reviewed this patch prior to posting it, and I
> > was already of the impression that it is pretty busy as it is.
> 
> I agree that the patch is pretty busy, and the extack additions should
> go into separate patch. The only thing which bothers me is that it may never
> happen if it's not done with this patch.

That may well be. But look at it another way, I wrote this patch in July
2023 and never got to upstream it, then Kory pinged me because it's
necessary to get rid of the old API. I don't want to go back and spend
time on extack messages when there's still a long way to go, and the
priority is obviously somewhere else. I've added this request to my
to-do list, and if I still have time at the end of all conversions, I'll
go through DSA drivers and see what can be improved.

> Anyway, the conversion code looks good, so
> 
> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

Thanks for the review, here and elsewhere. Do you want me to copy you on
the remaining conversions?

