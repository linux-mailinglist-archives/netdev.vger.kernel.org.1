Return-Path: <netdev+bounces-221741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A50B51BCF
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 17:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE29E545FE6
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 15:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D8D327A00;
	Wed, 10 Sep 2025 15:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OAOHKZgG"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012045.outbound.protection.outlook.com [52.101.66.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1909C324B0A;
	Wed, 10 Sep 2025 15:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757518507; cv=fail; b=D72ivrqEUaxuYKSTn4seS5atmJzbNOiYbp83VoBE5DfHogPDJGQQKfj/YOsS7aHFBhGCRgOjt55OCySuC9jSqyNZSNyR95GSHsG1uP35XOxfnlCkio2T3e8484GFm/HeDEus70m/5b5mwdQIBDghZQeDFhXYygYVzAjUhGvfVSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757518507; c=relaxed/simple;
	bh=bLIzAftzffG8QaklKflQNCRRuoocmUWZjkkYjYFGwag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JHhPjuDE1BqII3s7N2U+UgdRYmnQ6ca2ud9qFHjdIXB77706cbsmwWp52EAC8DVGOt0ie5ol7FQbNwe8OAoUlAJkXczbs2zbNa9G6niWrFImv+yfQsFPWcoRkoNpHyNtOA06jmM9+2oxgx40eyQrvatidrZiNos7RdsamHDfrgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OAOHKZgG; arc=fail smtp.client-ip=52.101.66.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gqbGTVZWoFw8VemABPomhLaS9+Z+KwAbVuuajEAQQ4Ax5YX66BK44U8GexGgZ2qrfF/sLclCaDp/r8NF9SodTqgFT6rwYTakHUlXphlVgt30oGN+os3gtQIiKfmH34t8c/QZNVIJZkAzSL44CUBz2ftcJ6nMAFjf8qWnICOIad/42gSgHwGvFpaq7LZ+vUqOpv4ts4fRxJD/yDP/KjBPDOdZLbWZtNEb1+L1bPm0iAFstXCeygzvulHFMTMuxeddvg4SuFjKcmJoVWvzV1xOArbs3yFhi3s1YV6glrE3d2WS8MvKJnZeRdHQ7rIE1wjCtUysd22/YzRTnMLjxesk9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bf47KHb2FpqYb38LDynRNEzXv3n90MIPY1PJPVaq/WM=;
 b=TO35ku8zGyWz4K4sM94LpFu0UXXz4RvXxWc1gye4rrv7no9vdF5m0oOUpV0QslZxZgKQl+FmAbJtqm0GJK+hffa+yzRopCIjdCDAQxutIZgVwmlsR5oO2KBqR+QGiS06xdXuu1dL+4Xq4YMTYNhCFvY12JdQbFa26xBSSOkw+nV2DawHS2qJOJNyG5cyFfnUl3wTNjVMQ8ODmc3H1irsw+L/AVJzGWo+lqyiPd3FUN2KdbV60fuh7jvOfAtWgeo4DoCYgHWwZwoVMWe9P8ioiH/oQxn6Au9b9oOP0N1ZVF9KYhSD8s+jXiO0hYkbxD+ZOozJSoA1gQqwwalbYyCyuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bf47KHb2FpqYb38LDynRNEzXv3n90MIPY1PJPVaq/WM=;
 b=OAOHKZgGDMhM02o1qKyU3vGy4R7WLXX+8F1PBym33SgBRn4kNrwA0nvJke9sQi18ZK7rJgaY+1UhGhxj9FntzFezhLce/skOZ9rK0YKa/EdgVzkDWK1B7XeZU6EPzII53aJI0TY8PI9TeXU75Cv3K3etQs1j0Tr22rknsxtlkojWTYSeXqQNAEVunO/HLJnjXNGtAODzSBmhfPzKof10rbn5Gj9vHOh7th1GTY/kM9XL+iIT9IlwSyCxk36HfrqBjFNHlT0JKzXA9I29GW9B76kEXwZinYc5RBAzDBGCSdwAzl+GDTMu/m7n2EGP2mWjsIR12IgtDy1A29BCiwgwYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM9PR04MB8507.eurprd04.prod.outlook.com (2603:10a6:20b:432::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Wed, 10 Sep
 2025 15:35:00 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9115.010; Wed, 10 Sep 2025
 15:35:00 +0000
Date: Wed, 10 Sep 2025 18:34:54 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Mark Brown <broonie@kernel.org>
Cc: Marco Felsch <m.felsch@pengutronix.de>,
	Jonas Rebmann <jre@pengutronix.de>, Andrew Lunn <andrew@lunn.ch>,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 1/4] dt-bindings: net: dsa: nxp,sja1105: Add reset-gpios
 property
Message-ID: <20250910153454.ibh6w7ntxraqvftb@skbuf>
References: <20250910-imx8mp-prt8ml-v1-0-fd04aed15670@pengutronix.de>
 <20250910-imx8mp-prt8ml-v1-1-fd04aed15670@pengutronix.de>
 <20250910125611.wmyw2b4jjtxlhsqw@skbuf>
 <20250910143044.jfq5fsv2rlsrr5ku@pengutronix.de>
 <20250910144328.do6t5ilfeclm2xa4@skbuf>
 <693c3d1e-a65b-47ea-9b21-ce1d4a772066@sirena.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <693c3d1e-a65b-47ea-9b21-ce1d4a772066@sirena.org.uk>
X-ClientProxiedBy: VI1P195CA0094.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::47) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM9PR04MB8507:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cc87ba1-2fdc-4aab-bc0b-08ddf07f9a7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|376014|7416014|366016|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pBPvpWBk1F5D3yg5SHB8w4zc8kD1yBeWuNduSx63Y1iTisir3Dw6ADgO3ZW6?=
 =?us-ascii?Q?rC+seaMPnpFVWl5yL1Mhi0T4+x34atSlu6Hr8ri7THwJzY+l8Sj6ASPGawsi?=
 =?us-ascii?Q?+E6GuyXyS/Jfqkf69aOweMpcf4pSyD+Rpe9lGah2NHlXkRMSrW6KTOjOjgCq?=
 =?us-ascii?Q?ncvB2e67wlWBgAE/J3fZrfNQDnrUh9M8kEiG4Uy2p4GfZRNh77hCxvmvAuMj?=
 =?us-ascii?Q?GZIs8xlwFlkKFF7JpksWgQFqfZ95l+C2SsmvvNl04buJnDHq2hPkqNPi8vUP?=
 =?us-ascii?Q?jztXblryjQe/nOWoaBvTEXmbSJFniGFWX9CMGE2yrR0Q4Z+4NYk/GDC97dTB?=
 =?us-ascii?Q?+8BNKAPKIZqkKxtDcTZVtc3DtXwlycT+vntvacEXk8CYDyhAa3EloKXgJID/?=
 =?us-ascii?Q?0U+q25UpRn52w2rlsvhw2X7jSxyFHV8/DPTRziL2glUa9qCLK/ummVtENEcm?=
 =?us-ascii?Q?Be7oJE5+36NKI9BH1i0Sk91256/n/vuF32tfo1C7llVNY8HAAh3cc7C1hjO2?=
 =?us-ascii?Q?IbaK1DyrygDC4j7GLY0S68s5rrM8eeQ+M8BUIHOs0veG7svZfsqzz6X0Vy/8?=
 =?us-ascii?Q?i/YbahYTuBRVEfkphjZtoPQ4Sgm5MRMSH7JnOfjE/b8HMtROhNPegNSMZ7P7?=
 =?us-ascii?Q?oE9zMia9wHinkUlnVpxRtxKrQCxJgxtjHPt5gH/RQ9Xo/LZ53UZrC/sGiScY?=
 =?us-ascii?Q?ElUCEinICPSiLZHQMEvk4ujYLLgWaVd0gE4DUP251EBSQZ+UQVVc+HIe8LIS?=
 =?us-ascii?Q?kyK/aDwJ3id1Vhf5PwqyK1F9J3gyEoFPMaTz096ZPrJHtywIqD3b0Ij/shu1?=
 =?us-ascii?Q?qyD2OnM20UfSjq5LJ8dEl6UOd88rOERphlM9wjlD9KW/oTxNGxElRpl9o9ee?=
 =?us-ascii?Q?PhzBGgFTY4oyvpHNKriAMFL7cAm34ppZirst0yT89UUK+wRzil+a/n7pHzUd?=
 =?us-ascii?Q?YrB31BVt5IHLLTDWLNcZiqSmYBY+ycswETiPV4UvMQ0PB7090LOqxNrkCdwx?=
 =?us-ascii?Q?GR84Qky2LZmlUTiX5fPoOmCn2k56O8uJyH0enbF6taQl7I8txulg+F1KwZdY?=
 =?us-ascii?Q?FsnPVqdqJBeVl6ytwruKNiI7ZhJxjew4pP2yMIxlrbFMfqgzjOe9V06eDDfU?=
 =?us-ascii?Q?NSQpFvk21a0CvwJ7Kk3uHDlHyKiNnEORYMLDin24N932rzu/8uEElvYBlNLz?=
 =?us-ascii?Q?jLm4Ddy4aW6wZNIIGMHAMkww7iqzHCbUKlsRRPkz1SbWzRgkxuTwSwcjR5V1?=
 =?us-ascii?Q?K9AO+4m/JfZ9eqj2E9JMAO/18GCVqVOymFhF5G9Say2vjqkQQyGex+gCH/6Y?=
 =?us-ascii?Q?7SSXUtAsUm84daDibHMCReXngKcYIdO5FvyUCDTuM8cS0GBX2oRMFkfeSGba?=
 =?us-ascii?Q?cTxVdwePoSJxWGnypkRh29L3R1G7T0pUU4VsF7/9zSbo9rEOTI7pvhHEcuwX?=
 =?us-ascii?Q?iEaOKCzd3mU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YxJrkdbZnSA7G2Tcqwb/wVAOli8JofjUb+oTwuuq9iDhZMZRlo5Q2grKBbbW?=
 =?us-ascii?Q?zuFFSgjJOtmGkSnOHTcaoB957TKCndwIZn9dNYw0TDwp0J7akqluraOnnAw3?=
 =?us-ascii?Q?jiODcSFoIj7tIlScyWUQ/dZtBj/od7UfrsW2pPQbHL1wpG5fFlri6q+a6MOa?=
 =?us-ascii?Q?vn7bIWOeM2SZaluV/xZjx53FYn38M1+7SMQ3v4+sdwmrzuMfku3ftpUPGgm9?=
 =?us-ascii?Q?10BemqNKvI/1TazgKlPx3TKbIw+b0jjpfpNyJiEOyU1LUNjvoTwv/n+3cw+v?=
 =?us-ascii?Q?POKMBFOwy+TzxvSVifnRn1VctegtzA9JPTJxmIRVQaZ6g8UyZ04Sy5HsM1KE?=
 =?us-ascii?Q?711KoXqLd7bUFaQ4/ssElTHqPotg6uAHhrrMWAgZucRKyTbpd/7jcJzeaDs9?=
 =?us-ascii?Q?dFkJiMrK6xfUjyIdupB5BG1Qdsrgs29874wfi/Bo8ssWfqDwkIXXCphQw66e?=
 =?us-ascii?Q?//0E0WIJLDVIeT0WawpQ7jhqqHp3SdDSSYe87HOmp/XTdk4/cbwrH8qS/4T5?=
 =?us-ascii?Q?/36rty5Xy1LZPXz8zp6fBuj2E0INpSoMI/TO7D354l2j4DWOFUS3ChNIl4G2?=
 =?us-ascii?Q?wf+Q/EOzUOto4cov8haBVVC3LkP1OJLlwsLbYmnqVJjpnqxq/iFAAXCRw69F?=
 =?us-ascii?Q?N0F+KWFb27Bgrf5yTd4exTcD9wKvHSMtiX+oUFZQ/Ublq6M06H1B6/Daee+a?=
 =?us-ascii?Q?XFQko4e5IazY9pgvPQ7X9DZ/kSHVqt6hxSJdhRURnw1U1GTdsuRk28QWrnN3?=
 =?us-ascii?Q?yo5u3AavskK9i/rQOPPKKr6vQizWzyxfYwbMB2HREFQsiUiEcfnMnXSivmGG?=
 =?us-ascii?Q?R+S6GAjZ1fi6Aux2I/qSsyqv/giSrfWHRaPVOSFisyb8sXvrZuthLd+LeQ0s?=
 =?us-ascii?Q?MSAYU9VSK3pwqY5mm8KPZ6rPVLk+cw5ahvW4hTKBYkIQRsa/PB4m95F+9xz3?=
 =?us-ascii?Q?5A6ZfNz1UFqPq8cJS4iXpP/GKwcoDJ1VmxhtuHBCQLCMsgg8nruBVNw6HlGd?=
 =?us-ascii?Q?9KR+9Sk4SegeC2TiOrwXbUqFujF08bPohdE+EdeyRa1nF58KEmjqI7yHVs+8?=
 =?us-ascii?Q?st4Y6g1umRujm/AoAkSLaxUbeDKPs6A5APkzCdol8i+EhJjEF5v+4p/L2u/7?=
 =?us-ascii?Q?8/BsJ5prZjgitETi0SvdLvMct0J5M5imN9/bXkdUHaWHrawUlO9FeSWamCr2?=
 =?us-ascii?Q?6bfd5oh3XdMJzTs24j6mTh6ID9fhS6ZwRqbl7dKCKLjpsbv3AQmZU4TD+ubm?=
 =?us-ascii?Q?bWza5AdnjNA1JjYurOGfIE4cowROvvTG9KOmiWhYrJnxtEFH5IMPZDQ647dj?=
 =?us-ascii?Q?n/pIOfYR1fmDsv3k5iVtSt5tspReA2L+8sj3qgWpu4CCv8iavt0Z1KaNgUZs?=
 =?us-ascii?Q?NZh1xx6qymWLBxptKS9Y7kLYQtwDGjHcqwWNlXbgjztXpmYUJZrobQwJ8omt?=
 =?us-ascii?Q?JK9WziL4sAlzsRxgHhmtsiwAy682lve09+qfoG4rQ2xPpLGp8qZ4i3ukOr9g?=
 =?us-ascii?Q?no2rs3AjkLOHb4sYmzc2sQP4KjXNUTIdiz9Ilu4VcQv3vOpCLm42Uxsw+HpQ?=
 =?us-ascii?Q?RSpudndPrOylhL+Q9j3thys1E5bWLEwvCceRQa56/+I9elwHRwJdmdiBY3UT?=
 =?us-ascii?Q?xzS6RH5fGXyJPZJ9C3OPJwSn7D8qY0m28WSWifnsK/zQemVVPkgE93jjWuqK?=
 =?us-ascii?Q?UhoTxA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cc87ba1-2fdc-4aab-bc0b-08ddf07f9a7a
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 15:35:00.1299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FmbMjI1WJCGu70BHZv0S/sX+DVH2pOu6umNMcLLxF8y4nAUZ3AZr48ucyTjxMRBWNfTI8nYBkj+Ck+4dEHKc4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8507

On Wed, Sep 10, 2025 at 04:09:05PM +0100, Mark Brown wrote:
> > And if you plan to do that from the GPIO function of your SoC, the SoC
> > might be busy doing other stuff, like booting, and no one might be
> > driving the RST_N voltage to a defined state.
> 
> I suspect you're reading too much into the datasheet there.  I suspect
> that what it's trying to say is that the reset signal only works with
> stable power and clocks, that it must be held low for the 5us while
> those conditions hold and that you have to do at least one cold reset
> after power on.  The above wording is pretty common in datasheets and I
> know in a bunch of cases it was carried forward kind of blindly rather
> than looking at the actual device requirements.

No, it doesn't say that, and I had discussions with the application
engineering team for this chip about this :-/

I can't comment on anything extrapolated outside of the SJA1105/SJA1110.

> > It really depends on a lot of factors including the reset timing and
> > supply voltage distribution of the PCB, but RST_N has essentially 2
> > purposes. One is ensuring proper POR sequencing, the other is cold
> > resetting at runtime. You can do the latter over SPI with identical
> > outcome, which leaves proper POR sequencing, which is not best served by
> > a GPIO in my experience.
> 
> I'm not sure not including the signal in the DT bindings is going to
> influence board designers much either way TBH.

Either way, something has to nudge at least the software developer
towards finding and reading the vendor's relevant documentation.

In that sense, 'reset-gpios' is misleading to say the least, because
everyone sees a reset GPIO and has the human tendency to think there
isn't anything more to be known about it (like I also did).

To be clear, I'm saying that supporting 'reset-gpios' in this driver was
a mistake, at least in the form where its supplies and clocks aren't
also under control. I'm not sure it's a mistake that we need to document,
and if we do, there need to be a lot more disclaimers. Also, I'm pretty
sure nothing will break if driver support for it is simply removed.

