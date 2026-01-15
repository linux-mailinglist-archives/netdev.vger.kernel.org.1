Return-Path: <netdev+bounces-250069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 899C6D23AE1
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 10:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5BF9E30ACCCA
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 09:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E31F35C181;
	Thu, 15 Jan 2026 09:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="E7k3u1hE"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010044.outbound.protection.outlook.com [52.101.69.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015A535A94F;
	Thu, 15 Jan 2026 09:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768469754; cv=fail; b=DoM6E6yx03dbFwdPd5S9vKOOLUCAuAIwdbDpG8K6RFw+RG0Sfjl8fwKBvVngLkJeQveh3rXno0fqiepE9WVwrk/E1KXhBOcDzPm4Ciu5cVgeOxwa6RQWDsKeYxj/O2P/HfMrY7wHYanIlELWfPGcToMG5Pnn4SSV+0H2B/Y7dHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768469754; c=relaxed/simple;
	bh=p/mVRX2oaWtoL3CY3xK0/thy1+HctpVSouAcFTDxpSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E+ki8Tpt+cyJiieJM6dHPIk6SQwb903JVs/IHVVIkLMHfOQOhOo76B0OZ/t/3dud4rphW5rkOFs22428q4VcrSoeWgTrYNeQEoWMyBJSH3jy/wqqokKGBG1K/Nk6cY5cg8c9b28iNa9RaADEYHEfH7+4Gow21geXuby69ZZ66X4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=E7k3u1hE; arc=fail smtp.client-ip=52.101.69.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qLpWFu9ZGnZX+hHbwb8B+bD7Y6bZQ1jZyR5b5pModZ1lX1ToGwAR6AvAYssdwxgZL8paF6NqduP9UZtCKMgZT7ey3PXIKttcEwG+EJqFq4lN9KuJcRpcmnkSZ+27KllBwXX7/HLSzC0+5CqPPP3uhQWM/pivJ2f9dWEWEbY1WTIyOoGvVX1k/uiOr+vS9om+XW7nKbXn1PdC+Zj/YOGrXMHiyU/nmeQ8CEzqWSs76ymZsTTKuaeHBh4cGxrWQq1POr2LxStU4M3yF1cXnbewDISJ7sxAgayNgI/nKz+/qQ/ZV319uYOOvQW7FYH+oudn1CncEd45fOloeQvHALWqUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=neunMyl6i8GNxddtOJNbhzyQSHQQ49N6WJAku+3qPq8=;
 b=aHo2Yt87gPo1n3Z2DtNJ7918z1Cz+okWi12hav11hIxBYVGKWg0QNwHKWrHB70C1RSPmWrCIkrwaHLXEFVT3trsAFv90hTtM3B1Yg20S/OlQbb7TUbzINQNvg1UHkauC8YBRNCXFeme5kO58gw517vFWDGPKqi1xOgO1iWeOuxXT623xvGMAA2wn7oDgyBeGkugzE++dm4SNnZyZb2W2xv9wypD1QEoIEIP8htkx0662vu8dl8AsdYZ+wPTm3SIrPAs/VuSZlaPDEi7V/u6nGnflF3+ks6K+djZb1UbIFRAzHgKamHcH/OLxIVptcnxpKQtd158SCBvUvUhzE/alBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=neunMyl6i8GNxddtOJNbhzyQSHQQ49N6WJAku+3qPq8=;
 b=E7k3u1hEk/AGmEWLDpa3kP0IyCC3LfAUI32vj3K6DYjBxthRNBiLEymW0Na2SLlAcMsgV6lxHxBN242a1PJBYTQ+NOM9gg1wxhbTeXFRukMYzIhe7wTCCf2+GoDstTq1mkqyLy8iYAJUqnSBWOblgIEsPh4Gf6wIrLSbwwPGOfjbsjJ2PP8kCjQfGEylq1Z7tY8lyO+X36hkz17VsyDPYkPbOfVDo02Smvihsn0YmTvlDUinEbDkgGNzisdyrQfYEFqd/m5995MoOdR5SyX5bM1tiz78WnjzHkaHD5Yzql95bHYoJmlAiqAikjuCvVnYlz1L+OOBUXOVIvmtmERsRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AM0PR04MB12074.eurprd04.prod.outlook.com (2603:10a6:20b:745::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 09:35:50 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9520.003; Thu, 15 Jan 2026
 09:35:50 +0000
Date: Thu, 15 Jan 2026 11:35:38 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Lee Jones <lee@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 07/15] mfd: core: add ability for cells to probe
 on a custom parent OF node
Message-ID: <20260115093538.o5ghqb6j6dzledyw@skbuf>
References: <20251120144136.GF661940@google.com>
 <20251120153622.p6sy77coa3de6srw@skbuf>
 <20251121120646.GB1117685@google.com>
 <20251121170308.tntvl2mcp2qwx6qz@skbuf>
 <20251215155028.GF9275@google.com>
 <20251216002955.bgjy52s4stn2eo4r@skbuf>
 <20251216091831.GG9275@google.com>
 <20251216162447.erl5cuxlj7yd3ktv@skbuf>
 <20260109103105.GE1118061@google.com>
 <20260109121432.lu2o22iijd4i57qq@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109121432.lu2o22iijd4i57qq@skbuf>
X-ClientProxiedBy: VIXP296CA0008.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a9::7) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AM0PR04MB12074:EE_
X-MS-Office365-Filtering-Correlation-Id: a6490efd-d08c-4820-bab4-08de541977d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|10070799003|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TV1onmWu7q+d8n+1SnAEfLx0DBUXLCGba0JVo8UK9kneDwYQJcYAd40iT6Li?=
 =?us-ascii?Q?yJ7q7FmunwHByN4dKeXce3rXIXCHPUBpiDKCQifOw6RBZfKwqYYkqs0aErlw?=
 =?us-ascii?Q?exBH55Y6zOIjSpWAkjakx4gCUoyLDqrmLgGcReiVH8Vc3ZlToTqcaqJamgEl?=
 =?us-ascii?Q?JCYQxsirW+deCWvl0pEdI2r8XulKEFRjZunpwmtxU5PzeKYXEEw9OnvQI+SB?=
 =?us-ascii?Q?T6ubSPL2z6QExKAMrsM0YixPSDUuytMkJuGPhbqXwtcLzsD2C+5ZVZylWpXh?=
 =?us-ascii?Q?XC+ZAi9kKB3UY3z5ZPQMn46sDNITj3F+hkEukzz64qvL+WBfv3sSHrD4Em+3?=
 =?us-ascii?Q?00UQSeo/YEiDCItu6Va+OeV+cw4+LB/kXfr9SFslN/2oVV0MpKHVVenbTnfx?=
 =?us-ascii?Q?32OJh8kosiY4z6h7Dm7Ar+w0qZV9nPRBbcqDcU7tXqeejgl2kz+/0J2HMG+r?=
 =?us-ascii?Q?b4H/SucqOMxamma2ObcGtI37N7WJ6+XXPR+ZKx0KhSmyaO/mcQragB124d12?=
 =?us-ascii?Q?7GnubCM5eUoNSpqcAVfYs/gVfV5HPAz6JhWlu+qKFJhY5Fnn3UwTbI5TVmgU?=
 =?us-ascii?Q?1YTQTrzuIqxC/NTxx5k3FnkQm99gLcYiLp4fswGjpw+HxK9zQ320ixGy/EgB?=
 =?us-ascii?Q?LiFttcN2Ib66dMkLqdPoG+tOZcqzAm5viChVuQFRKoRAex5jgfXlSlD2m2uS?=
 =?us-ascii?Q?Rkj/FVJCHn3FAcnnPrXuew3dp1GfOkSsGfRoe/Rtt2tMFFI1GSs5qvzHiYDl?=
 =?us-ascii?Q?KRrjDd9X4mEqUODuEQgCrtUe2y0hTGRmpKZWEDPuR3+/MCrh+aS8fo4EdZVT?=
 =?us-ascii?Q?LuM+NthmzcraMtxbr0mXVaEA+Yl5WH8jlpFcz01HOvFb43ysOphqZme3e9xe?=
 =?us-ascii?Q?n0PijLDZRK/XQ0ngDqGJpHNzPnCTYgOQ7gHys53Xu1p0eI27CfJYbtHQO9x3?=
 =?us-ascii?Q?YPIGYPDx+QePR9CYZruOn6cYu2hH8FklvhTN07azTm73FL75+PKdgc8s+URh?=
 =?us-ascii?Q?Kurn2mLp3jf3wBUMiE/MTghhVlgN0dB8O4jqmoznaCgV+axLq28Aai8Y1W68?=
 =?us-ascii?Q?rJu3ZQLhoyT6L/GTz9vfeFgjggisHHNs1HhqEC+m/1xUvAkce8Zt2fSqiPPk?=
 =?us-ascii?Q?8X49VeWfNBO4pmpCLp5hltmRCKP5kItZQZ7dGIHDsbJaM6dWsXjLzbo87+SF?=
 =?us-ascii?Q?sLIJ7Z03gnieb+OxOW6cxX7JOLU+3RKksliJEiIL01JpuuAdaBW9Sg6pVtcA?=
 =?us-ascii?Q?PaOO/XGTLNWsxTsxzQKMDT3IITEu8RfQfFSzJPg/eLYqcxfxBWptTX0wkvZ9?=
 =?us-ascii?Q?0SZh3Tb4+Nb6rlxTCQGDgQiDDn2OLeqaAVOWNZL6m3iCL683esYq+OEXaOQk?=
 =?us-ascii?Q?ko7lVMrEqJTVHa7bh4byoV+Y2lhqQfGt9Rm0mhKpJb07DA3GiSgzrB1+qL8/?=
 =?us-ascii?Q?9Fx4SOjfrmx98NyTPoO35eyHq1400tsd2xGXNZX7Omoh9HIixAsJ1LSBFT5T?=
 =?us-ascii?Q?T4ewFHyUWrFHsvcK28XLzKjO19NXceE+B83YcIRhzjirQVTxjFx411iJjs12?=
 =?us-ascii?Q?nFUoporFwoubrq+RpRk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(10070799003)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XVKi4fDcWSudsBye8d5AmK13gEUDNETSwjvzveu5nZYJ2oKjIh6qvaBJcV9i?=
 =?us-ascii?Q?mDP3m/vP/gVtVNEo+eo0e8kU29mdPV9Os1JLPAUVjPKOCUrNsrTFtdEqVOua?=
 =?us-ascii?Q?ehQVAEj1XWEQP/SxWqCLKaMR91eaWkml8BSSH6jD7VqfnuKS4jG28SpobTAw?=
 =?us-ascii?Q?/Nntuase7IbWqfjBZYS0pvNX0n3tqMchFVQ4exj6YDiWe6QwBscPI5vErfR6?=
 =?us-ascii?Q?i71d4Xbq+skz2uxI6oAY2SCdjjHCv6vf9ufD6yvSab+B9zWKvHEw3z0Viady?=
 =?us-ascii?Q?ckDR4YBlJDWiof3ZmahzbGcgDD+iHpJxCRANwCDeEW7WLAjBKtGP2FKuqRik?=
 =?us-ascii?Q?yiyS90yHTIxoA4nYc8fXNb2hk3u3IRziryV8tggAsp41jVB9Yk3dcQz7QgIm?=
 =?us-ascii?Q?7boSFtQPfv57Zkt8o94FEgMHv8PsekfFqzhnHIhVuOEo1Fb2rAEjDHzc3dXh?=
 =?us-ascii?Q?s0iFJZdXAGxyUiWYT5eKPappnLxEnrOMJIJkA43izl/DoXaf4M8HgvWWOWxo?=
 =?us-ascii?Q?gC1wfb2yK/vvSmvebJuLShhw+aeF6T54gf/aYJOy+Nu+aAUscABYH4W/j2S9?=
 =?us-ascii?Q?1QDYNFU2XwYzcEE2TSjq+/T06lzpCrch0MRNqiMdKV9DgGX2CFtIRCCYSRIq?=
 =?us-ascii?Q?ebP4IfUuB46zQRTMwSA44EEQ2dLko4qMSztnd9bVne2uorQn1XijsO4iKvwR?=
 =?us-ascii?Q?gXQa+FAQ45Pa/RQnBonKMvb4oLfZzZOlyap6PHafZ9XXzfbZW1IrecUPZKpS?=
 =?us-ascii?Q?k8GPBxdzRJ58FecG23aJ45UrM1AydUpur1TdXWbWPyvzcUc7Cz4XzECUzJZ+?=
 =?us-ascii?Q?EsZy2ibOl7dS3YyfWwKAKMLnjwfWeC2WIE9qjb7fTNC4sb+2VR8I/pl4ezxV?=
 =?us-ascii?Q?JzrYaeZBFnAJmAOf9pg/HC6IgIDDx7lP/oBHJfIYKGlUhQYybyJRs1FKaSJj?=
 =?us-ascii?Q?oN3xiYYmgAuFaGvsQvFCkQCIwCZn3bJSoK7B63/zIuZvt5eAsJC9DIdYuSFP?=
 =?us-ascii?Q?F4ipRx+PWFTKVVXWojfyR49KVN8OWpEZpUtw4Q1jKzwd3hUl16m7qk74JX9K?=
 =?us-ascii?Q?rNtOtkzADi1vzW9Du/Ni86Aq+CYI/0brKAk/mcq7J0wSeOkpR/ws/M69Zs6i?=
 =?us-ascii?Q?9F0lyYrLOclYwaoPbsmiTMvQRuqqbo7W7ldGxhf1v0WcwtklN0SQFz7x2p7t?=
 =?us-ascii?Q?V+RaXViQPPk6xXbjTQ84xac5DJhgoHwN1yDr6YKYXiGGwr41uNcqkap6fMMe?=
 =?us-ascii?Q?gCydV6DCftdf1G6u/fUeEIkuA9Du05i2ucTuMyV2a39NNFwvkQjoUrJ+WrAX?=
 =?us-ascii?Q?NRpjkXCD7oZvHIhUTDze1trjKGUAsOs+oxqld5IFutGon8NMYIeVorTtb6ov?=
 =?us-ascii?Q?JLPT9YsNjGh4D5O98IfzqAMbYM8Eg2iFfqcHKcKxb/xYZDBXzwSH7UHS8pJW?=
 =?us-ascii?Q?tfun/JqB02ooLVye1LRQxq3eSMGHN9/1N8nrs8g3DdGwxRPEnl5nzOLNrQ1f?=
 =?us-ascii?Q?1+/6oFPoy9F/dXCnhBaSFexpV7TLdbqs8sZyFHGriuN0JEknBVXmOBSkgXZz?=
 =?us-ascii?Q?j7wpfSQLrErCK1eD76ppvmboqREyfmwoiKSD4pMblrAr9zlD66wJVNOxR/ah?=
 =?us-ascii?Q?wd+PmI/mpTYuomgUAg90agpqsU7egtANtM/p8GFDq3EFjfLJd2ZpqBJdKJi6?=
 =?us-ascii?Q?dlhaXRt7LE4h/E01aua3IZnw2QO8OpQ3xeHpsa3jYsA/KWRx2vdEwf9f0SOJ?=
 =?us-ascii?Q?DWoLZEz9+Wago4dxC33e9mUD9XwXVrSMY3wNCQFIVw5qSUo0uy/ItKjj0WxP?=
X-MS-Exchange-AntiSpam-MessageData-1: qoMiQIkE2AOcfnhc83BGaFWzGf1WfbmhLAs=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6490efd-d08c-4820-bab4-08de541977d5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 09:35:50.0302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YUA9jjYw7f6UQBqmGyJFwvsYGssWsw/Jgp9FOyYYlV7o4HRqoj/40sbZcUeZG4O913gNjN1bg6m/w+Jn6fEaOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB12074

Hi Lee,

On Fri, Jan 09, 2026 at 02:14:32PM +0200, Vladimir Oltean wrote:
> > When I've thought about replacing the existing occurrences of the MFD
> > API being used outside of drivers/mfd, I have often thought of a
> > platform_add_device_simple() call which I believe would do what most
> > people of these use-cases actually want.
> 
> Would this platform_add_device_simple() share or duplicate code with
> mfd_add_devices()? Why not just liberalize mfd_add_devices() (the
> simplest solution)?

Sorry to nag you, but I would like to have a clear image of which way
this patch set needs to be heading for v2. My understanding is that
you're pushing for platform_device_add() while not completely rejecting
that MFD could be the correct model for this switch's sub-devices.

