Return-Path: <netdev+bounces-243397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 22791C9EFF8
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 13:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 93013348BF3
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 12:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D5C1940A1;
	Wed,  3 Dec 2025 12:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IELMA7pf"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012054.outbound.protection.outlook.com [52.101.66.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873FEB665;
	Wed,  3 Dec 2025 12:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764765279; cv=fail; b=UL4gNvLfurcMD39CPscVFssFk5eqwiTF4L4wEl5DRKHXylUu35QFo0/fgDkPNM/qyoQc6J/77G0vuFl1IUiSAYdupdXlGcZ4NSI4KxJS5f14z2MEzWOM5nG7g7CvCy/hm9vhpnAPj3hKYjAWjgYyBua2Q3+oXK2aRi3pJaVnfzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764765279; c=relaxed/simple;
	bh=HbmJ5VI30poGXNiFHWVT4U9IrLGbBekgTneq+1pAabg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qe/H5O2hNjeZPacP8KqN53TE+lVSbUnb57aUaOY3jF3XNpJIJPpVmYgkfH2gcz6ZyLkIOUDknXsrbF/gVmRG1OaXm5h0cIkrHJScdm77vCo1LgEXDBTNNpawjfEL5SJLvQ+wAhPpfl8faYuSj2+l8aCFLYLa9Mu8hyVvM+TMsnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IELMA7pf; arc=fail smtp.client-ip=52.101.66.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJCwH9jxtCV/6eAXAR27LrcwRSadOnuHm+Dmu+BrBAHUcJw6M0BXoq/LOY8etlpJiVdbXfIf/RsZra6GzWceo87TIUvB1gnVYmQm+VkTntyGKVMByYwJ1Rx2ydchpkoreTL3fm2qXNLij+vXG7yKqF4PTASd1tw1GDgP0LuNVoNysnOC7SbrFbm6+VBmvEwF51OAvSlfuKwmt37XU17tsFAGYnNuihCC/7wWHdYVK4ftVC/TW0VVYG7hJVl0shyPmJcKGSHC1CB4m/WKo0yD6Dv85KUi6b7g9/NKyMzE5CFyUmfCSp1ZgeE3f9715Zz3tCLzYNmg5kE1OP3LO7ZYIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCn5L43tywTSn+8hXU+jSTGhs5AY1uGNSFbIx2NVG/Q=;
 b=j6aBn/EFFit+VCNhGiX74t7Ix+w2v67tHC3BZEbK7BpC1llwDfjp/Vvl23csHQrSRqj3qJmtjpoaBmSM1j0mOfHYKRYNL3vtR9GqqSVRW76drm6mG9y90rE12VVyyssQ0U9RjImzFdCW4hkeTmWJ4DPVM9BYjPmYYMqEtImdKav6bokQM4ZF3Sl0DRUPagVsmES5Qnza7PFeqnx73U5PARaMy12gF8XQzL26PSB8GOjPO+JRYXm+j2DXrduo9uuUPy7q17wT9rDEJBsVVv4/rTNoP2frGujK5SP+kFlbiQDJsHHLW9biUXwlQBc05ywdJEm3HE/KsHG7KBPbTt2JzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCn5L43tywTSn+8hXU+jSTGhs5AY1uGNSFbIx2NVG/Q=;
 b=IELMA7pfdlcclXre3zJ21qlYlJbPLsdsbn0uDqg+QK8Yy/QArRsGGkJOcWDqLqkNCdOtV5v80BMmrfQVrmXmxXipxz9l6yMU5lpWcMIYn4FRYKKhjMBvAs3B/0hkxSoE+N9hbg/pwRu8rXUXnwH7sbodr++wMiWY+gEGYsFuDQ7QDock61GhW/2HDExXS/Z4Ki9asYp4sZpO/D4Ek7ggHfAiUMRo9oo7Jll6XJxMxxtClt8SflP6YJlvApVmzNShO5pRzH2/rnkvUISupcJkvwI7isOMlKZuQ1MTL2adt8rMInXE9S6Nz2h/I+efmQiiw+XYc2VGD+vjYyp3dJRy0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PAWPR04MB9717.eurprd04.prod.outlook.com (2603:10a6:102:380::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 12:34:34 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 12:34:34 +0000
Date: Wed, 3 Dec 2025 14:34:30 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Marek Vasut <marek.vasut@mailbox.org>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Andrew Lunn <andrew@lunn.ch>, Conor Dooley <conor+dt@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Klein <michael@fossekall.de>,
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org
Subject: Re: [net-next,PATCH 3/3] net: phy: realtek: Add property to enable
 SSC
Message-ID: <20251203123430.zq7sjxfwb5kkff7q@skbuf>
References: <20251130005843.234656-1-marek.vasut@mailbox.org>
 <20251130005843.234656-3-marek.vasut@mailbox.org>
 <aTAOe4c48zyIjVcb@shell.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTAOe4c48zyIjVcb@shell.armlinux.org.uk>
X-ClientProxiedBy: VI1P195CA0074.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::27) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|PAWPR04MB9717:EE_
X-MS-Office365-Filtering-Correlation-Id: e9cb67de-48e0-45fa-7b99-08de32685051
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|10070799003|1800799024|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7j6J+wD5trflEYruSAAMggv3yCNAxR8M7sLLHo+JAt+2f/+IAV1z9MhyytI4?=
 =?us-ascii?Q?8iASKoX+M6Tpix/fR5wyhuNOM//EYLs44G6PYmNa3MJlLvstKGx6cUalk/zz?=
 =?us-ascii?Q?xjDVXkHauJR6f5zhGhkzXVUaD4It/lZXcxkIqlYM/ruUXKS39UAc51iuWNz2?=
 =?us-ascii?Q?l9iEUsyVvGi2kVeYFFeme5AQjEIxXNH81OB8/l7QaI7R/gmp+9LATWxEcRJL?=
 =?us-ascii?Q?g3Ix77oof4l1PMzqA0nDYFGvTyhsmXby4WGGGCwXCRxZHbwQ21WYU283TIxs?=
 =?us-ascii?Q?f0gFepxbFCxK5ySpCXY77gWsMQFnoRbBjDYUm8gxPwuvQ07wsL9yq7MtnzFp?=
 =?us-ascii?Q?hBrUvh7WlynQtUsZVbba7KVBxUI58lTZn0GaSzOS4tpOHodUivrnJAifOoyg?=
 =?us-ascii?Q?Hs+ljO1fsx5ORi7MM8zRnfwZGp9gJuizYYLZO+ofHzDWSDrIgvmwwlvbvXOB?=
 =?us-ascii?Q?qPbrvsnTkg75ss64lTNLJgkRJgitxbpEJg4l21TgjyDgzfpggpg80Ntkp3tj?=
 =?us-ascii?Q?wleSc+nyXSnxSuMJiY2IoWf2+yLSNZLumkHbLdZvCDebHTA3wJxoXyfP+vX8?=
 =?us-ascii?Q?b1l27xvW+WvEIpFkshWce65aGo4WAnCjTNCVjRXO3+ljw2BRHM5yhMydJ5Gb?=
 =?us-ascii?Q?/iy67yI4X3jKMnwkzTAT8sKl8fg9Lvl/JxOLiKbO5/oOJGwFH78x6slRMY2S?=
 =?us-ascii?Q?k8TNb5oCb5PbjVdzqMUvD+K1GU8goRWK3Yv+CE7d6ApqNImWo17AzAPqCjeR?=
 =?us-ascii?Q?OMvwF/R3M8ghYVadLynSBephsuTuSH83aNtDbh6yvTPiP5stA5dm9Iv3QFDj?=
 =?us-ascii?Q?rgNj7Gaz4mumm8BjbCxjdeAtl+qpCVF4Rtj1YHsrqA7EaPWm1KjOuohTw40s?=
 =?us-ascii?Q?5BD1Sn3vSUh2Vj/LQsAF2e8XRU3yJzUVMcTNrkyVtt8l7NDRWJz3iNEUHU3j?=
 =?us-ascii?Q?OvmnGGkKDtYq5cwUFKuv5zNtH9NUN2mNk6mKsiAAB0jrpT6GKa3Neaetmyb/?=
 =?us-ascii?Q?JyNd9gxgMAXgJ1Mp6KWjJYidoSlGHBBxrVd9WIr7KA5TLn1WsNbOp9lHADUu?=
 =?us-ascii?Q?BVKWOhVwWEkevtf4oAbH1XOHxDEZ+B0QzLtDwR2TEgHYpjyFLeZi+2RVPh5A?=
 =?us-ascii?Q?BmWrFLL+Kje/nRn4MsqE3gmA32TN6Ss198xPCrk8vmINCB+gojGaR7dxqjWK?=
 =?us-ascii?Q?6bjgurOrPW6v3tLBactP+6hngC3nkSDV5BR+TM92vdKhHaHP5ila4HBZJ6xX?=
 =?us-ascii?Q?+fe2+x/+hgOQ5suKuBWmcwg8sOo4BmOy/NkpFNyeD5NZ+0SBxmZ+tR3MwW9W?=
 =?us-ascii?Q?nyZkY/hs01kWGd1w8YoUix0kDc2VpI40DE+M54ErLPP90ffV++pkT6wiQBhY?=
 =?us-ascii?Q?ta0In/kz46U4T3TUpvgESbmkKGTGvyS9hobtuU7hwdxRCPDGc56Sai/0MvuM?=
 =?us-ascii?Q?qNRBj+K+pxeKbRPp3LPhrClsNIbco+fh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(10070799003)(1800799024)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BPheD3WqxcmHq82Qi16LgzY3vsgAS+9vLvFfLnKBsaJ7E5oj/75GNchgm1vU?=
 =?us-ascii?Q?jSdIY4H2kY1JVY5HDQcOkOHaI/tSvxvWWSvn9PW+LZcWivjNeSLGh2SPXdOb?=
 =?us-ascii?Q?quNoXvpKssB0/8dxlDUJPJzvzZmyRCt07NZG+Y+zxUhba7HxSE+tcFsoQ6oH?=
 =?us-ascii?Q?jTPnx9KmWcKfxPSvnIuu0PxSFc6LhIoEk6EGXxlt/cqMY7w7lJ9Newqy83kw?=
 =?us-ascii?Q?YHUXBZUkfWCpd0JMdY2H3z/B2UfK50lyv/w09OJ85kNT+9WvBRAZYeVOrCgh?=
 =?us-ascii?Q?5RzqZPW6Qsgju7arQRo7RgE2ZvlvJV4WBy9pQD+q0j1rqpWK2hIksg6i72vD?=
 =?us-ascii?Q?rBcHujOU/v6l0eHwKaynQBUholCD7GR4ZDyHvOWh4TeohgJoxhHm8jEOYCI/?=
 =?us-ascii?Q?q8yoLqxZaSvzYah+muFc461vCCEbHqY0YLJI2ldvYkvwZsJpv24/br2w/ckz?=
 =?us-ascii?Q?d0NYK3Zkx/9B0tFHU/oswo00gcMhXRgkbLT/YfdzJtEKGijtbhf/xtaKjP08?=
 =?us-ascii?Q?x7QC2GnqCZ8cZjPTEjJS4sUbfZdzkRKh07ez+TKhRFW7i7z3Q5YJBxTG99GG?=
 =?us-ascii?Q?XsdIOOR8obVczd553S5Fxbk0EdTRl2Ef3MycroBsGgjL7qBGhUvQ2DHzWXD9?=
 =?us-ascii?Q?qyv55acuXzBLTtwghwRmKWg4Q4V2bZbzsJr9xO39lknhoMCdA38zhBsTZSzr?=
 =?us-ascii?Q?6pDVj3b2PTZoXNMP7CdbbWyhwkPbzk5MKvbDotF7z/zgb27Zu7KE7bYsieE5?=
 =?us-ascii?Q?GwnqghkO8hPozdeHW1PfUn9rjVGvsNic6vvBiSbuAz12JGQLml19ky1swFyz?=
 =?us-ascii?Q?njd4CgXY+/iOWFWkwyqU5DMnoeUZb1j3MpEZ66EusFCPJN+d9paSR7L+7TX6?=
 =?us-ascii?Q?mFsCQCe522Y20HjgacvGGUUHt7ZeCnaB7ctm3zpVQzGTuFWAXvcbP7HM+0lh?=
 =?us-ascii?Q?yXpkG2UncHDLNfvpuRBTYMwwyQeRaPVEvSH+q0MvRLTNyO4DProI73E1XKNb?=
 =?us-ascii?Q?7UNz+a/XR3CmMU4u+fuznmvQSdXYn1yV9IhRtCnFYYJkKQrP6O9ahv1r+MfI?=
 =?us-ascii?Q?bF7/RTEEb35TlvYLU3JuLyCGaxit+mMBZ3pFOw/19ctLlZgZv8soNCk9urDd?=
 =?us-ascii?Q?ENM38hZcWXV9L99+Z5OKG4Y5bt5YrVGgbqw9NbYbQQpginiD67RrhQu/mNsl?=
 =?us-ascii?Q?mW9XAXcmhXxjlRu4aFysK5sxlGggWJMETv1xPgsbRgspxjJM4VZtsSsc0o9r?=
 =?us-ascii?Q?VZvgw8IWxgv0z9JVUzVVsTm3A/aL/egdA2s8gPxT6FRS3kga++M8Kjs90BA+?=
 =?us-ascii?Q?efiu2WtDdihKL1oEqqAK2g4mXVvV4hEaGYtS6WcBfLyoGag9yTizMP2OUsUJ?=
 =?us-ascii?Q?NIqRhE0v/gbwGT3Yf1vKgQzeYwwIHo8zd0+A3Ugy1y1WqRxaQ7w3f3XLHC8K?=
 =?us-ascii?Q?a1U/5/qorwJFdVr/+RpqtR8bH952+RiChIZJA2kNwmrat95XkQuH3HjzCqye?=
 =?us-ascii?Q?XKD0EZ6zHZC6wTgulHjgytHt+/GlKaY3Tv2g3mOBAcmuyPcLA8ZmP/dhIaG4?=
 =?us-ascii?Q?ILuK4pKxPsafw9OulqjtXVUo9SHx520JD+vTEtHgrC1f2jCXnVVN9Byhqa7i?=
 =?us-ascii?Q?hzux6M79XpQUJ7suyjC8Jqv6+rb9o2cLHvUzo4pOwtmZwy0FTLIAqRiIGKQD?=
 =?us-ascii?Q?6Qy/IA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9cb67de-48e0-45fa-7b99-08de32685051
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 12:34:33.9534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8NUAQ1uqu9hxtBrgTAGLI1nfOc6iJ+kYyOG2mPYmVx4U/FjnGJZjiMN1Th/XU42fwWhPas/A2CP7J2HgMgrswQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9717

On Wed, Dec 03, 2025 at 10:18:35AM +0000, Russell King (Oracle) wrote:
> On Sun, Nov 30, 2025 at 01:58:34AM +0100, Marek Vasut wrote:
> > Add support for spread spectrum clocking (SSC) on RTL8211F(D)(I)-CG,
> > RTL8211FS(I)(-VS)-CG, RTL8211FG(I)(-VS)-CG PHYs. The implementation
> > follows EMI improvement application note Rev. 1.2 for these PHYs.
> > 
> > The current implementation enables SSC for both RXC and SYSCLK clock
> > signals. Introduce new DT property 'realtek,ssc-enable' to enable the
> > SSC mode.
> 
> Should there be separate properties for CLKOUT SSC enable and RXC SSC
> enable?

That's what we're trying to work out. I was going to try and give an
example (based on stmmac) why you wouldn't want RXC SSC but you'd still
want CLKOUT SSC, but it doesn't seem to hold water based on your feedback.
Having one device tree property to control both clocks is a bit simpler.

