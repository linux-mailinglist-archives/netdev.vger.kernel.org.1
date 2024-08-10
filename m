Return-Path: <netdev+bounces-117435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D297D94DEE2
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 23:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E177B21D6B
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 21:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6009A141987;
	Sat, 10 Aug 2024 21:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gIHDBQH7"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6173AC2B;
	Sat, 10 Aug 2024 21:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723327008; cv=fail; b=kd03adZH5oy5Tt5eX6Llr6qE1ttbk+jwYl5vGqWwt3r+WpM9VOZLjuIrW/r9Iqx1QVs5uu5Ir31y235g/H6z2cDI646/JWVurAXzDPPKdULqsihSsI/pWG9qkgkl4d5CqJGwdj2fVGweTFH4h9xpBI44Q1QaRNrXbRKKZpzOAy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723327008; c=relaxed/simple;
	bh=iiFm1FIJk5c/b0UERTzvlZuSiLghqXRgDiio23U/ffg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TLJpoGwLTV9pVSpJs69jhqA50B4KarO2EA3lMGJkPegq21dXxccxK3z/PJoNlugImVV9iXPW3Qwe9xkVGiRV6aWnI6NdzPEa7HV3IXw+9sx1444sAjUYW0DEaBKODgBCCd9G17RIrXZwiBooi+7QfoSAe0hPHY2nW/Rzqs6tNcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gIHDBQH7; arc=fail smtp.client-ip=40.107.20.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fbDWO0ssZPi4Uw55k29ceDRCzbPOe9tzczBdvkR5tVxMdpms6/2T88oByTCu3Uf8nbcryOY8peC1k5hUc5+fFuwijge+P/G6bK58x/uyWHHirUjVhOgWpFtmlIqEOTBLQaYtfsaDcxwJMuhIUoHJ5Dkj7jH2Z8MG903y06mzc2b+6p1D/LONUq6oJR4VZIQEI5V1E+5RgcwfpmkLOprmMOPtugI6K7+EJiyG18/7riPAfF5nqXlCL4oJ0AvxEIhAdVLbtIDMZHVeaTugm/Qz1xPZ3a8gcXozgVVSquC/IKsKe9C4UOINlqAo9uy1s54xMvxOEyAy/69CQ5wVN8PoFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LWJRTQaLh26fXTpzoHm1UZ+ax5uYT656qVb6iad0Dic=;
 b=XzfarsneRkgtTV4f6qWUlXMkb8gD97EDGr/B3Ft1BrTrzngbUITqIhuK2dXUtvxacBB8GMKzegtHL1V96Jvmk4XD5gUsmTclnaDuaoYk3iGZLBA491x9zvNGU4UutCiDUTSdcZm9Ier7dCd5caHmQFnnWbTNQFdOYe3ASeyl3jR525rtLkHTn6nQyDcJX8dDT/xtELUmug+sHHMj5NMqQLytUsniHEfcrSr+Fs7szIQ0vtpxuD9AuDbzKce0XxkdLxGISpNNoaMbvHXYke+UBCXs0BnME/SiEckwI9Eeei20gm8bbctTvZIv6E+Ejv3aM8crIpPP1RlfMiBes2oFcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWJRTQaLh26fXTpzoHm1UZ+ax5uYT656qVb6iad0Dic=;
 b=gIHDBQH7ykE4BgxsrK5SbWXWeDtlwSseSkL5Z6TLnsGfjv7OZKeBeGoeSewIptQo03NdOwjsGCkz0sNpUH5/3YC2u3yAHrHdcCFOOWIWE8lCk/vjA5Ki26WBZnZ13s/XpGitMx8CRLtuBAD426rOEJpRAOwrEsV59iTbiICQS+UG+tT8O6nvA8do7bzfgU0sJtI7u1nE2tGcyflfo5cMz8f5OQfMnz4t67t4+I3r1vPV+sDjzvQ5O2Q0QYJCdHES1KGthLq9ZxvuAe3PPcq/BdVZ9GcDhMc/9y3i4gFV+w+rhlHiAloOxmmpIueNjBWqEkQa5/H8v+2B2c9ZTU6o4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI2PR04MB10857.eurprd04.prod.outlook.com (2603:10a6:800:271::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Sat, 10 Aug
 2024 21:56:41 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7849.015; Sat, 10 Aug 2024
 21:56:41 +0000
Date: Sat, 10 Aug 2024 17:56:32 -0400
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: net: fsl,qoriq-mc-dpmac: add missed
 property phys
Message-ID: <ZrfiEGWNb48t9HZz@lizhi-Precision-Tower-5810>
References: <20240809200654.3503346-1-Frank.Li@nxp.com>
 <01fb45b3-c77a-4dd6-9423-ba1fa5521e4e@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01fb45b3-c77a-4dd6-9423-ba1fa5521e4e@kernel.org>
X-ClientProxiedBy: BYAPR11CA0090.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI2PR04MB10857:EE_
X-MS-Office365-Filtering-Correlation-Id: 05a30c7e-31cf-4aaa-c8b3-08dcb987510e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o71fI90VhdaGkkLsQ3IB6+X7/PKNpO5uA5sB/5xU1lR+lfp72xGqmnDUICPQ?=
 =?us-ascii?Q?2gIjRDs0yN9pJakhgheQOfRtO43iZAd371wdH1PL9GJP9oqlpG7Lpd6J1GGY?=
 =?us-ascii?Q?XAGGgpQfpd2q+TgF+JZqsWYmnziJ5kc6IlIkxynBNXEQB4vVabmU8lxyvUml?=
 =?us-ascii?Q?C77Pv8UyiaDhSUbJC8/KK1CpnLQiC3Jl0WFBAANRFXp1UJ/kY2lEXPYn7nU2?=
 =?us-ascii?Q?Afj4D89D4swd5a9B9YX4Xy6lb5qWS+ZbpAlXf4xyLFLmgZUdvBCm7inI2Z9d?=
 =?us-ascii?Q?lm7D5QSSydLWKYhrKW4uROCS2dyqprmtSl8M4EFIomMn+KUqJg417CFYTtNe?=
 =?us-ascii?Q?Ol/it6zLnTWn7Gp+ZFCjpnjhzNG4CjO1F7BRk/5+B9qlCyX0A+MA0Yo1tBTk?=
 =?us-ascii?Q?vPMDvOMt+Mt7nk3nxAU3wc0+bFaXd6t91IiEMjQ8PPIFjThn2MuOVrLX57k+?=
 =?us-ascii?Q?jyd4fADQZw4ItS0mU2fr3zltmMI85Cn5dujmrJI0t+D2ZfoabIt8FmlnNwef?=
 =?us-ascii?Q?E9e5e5yPZ9mKPkYwaKXBYqkTxaW+eDP4/q97M4OUwZLB4dT4u1XGyflLTg1S?=
 =?us-ascii?Q?wfjMAa8vcrIqZc7o3tx/wyqBxJK6icbCtgmkRJ8IFdcpaONgcb4+daAWBorF?=
 =?us-ascii?Q?HU8E78Onk9C1ogA0RVF0Go00YxmcnKrr2T7MumB5YEtjDx/wqWGDHntMBj4r?=
 =?us-ascii?Q?iwoiMGOKucbKVEqeZj/GT5S18xTPM6PgN5B2DTP3NdENkEYSOaolc9YOxNe0?=
 =?us-ascii?Q?Y6OujSU7vHdavwou2hctHRodJZGJOdib6VLi1A6oKm1D+bFlU9q6Ty8S4ExA?=
 =?us-ascii?Q?fAv52ULnQqoqTkFWHsjpjXm5S/pXf7uf6jOFFpPAYtm/zwdNSrCrBnIMMUTe?=
 =?us-ascii?Q?dcX3jNp46klJE6XnaHPDYnUb9EyXWwuPeu+3rynOHDD4kU5vDVwPPsBzKeug?=
 =?us-ascii?Q?1jqAWjGuADYC45Mm/cC2j4n6XajQkFl6cuFSEnSaEMQ9OAAF1rQRFpcFbBR4?=
 =?us-ascii?Q?cQzGnRFngPmC8LZeP8q66OiuSBCY7OOAvKuZMyj0/1gY6BC+b9RlrOLvFPfc?=
 =?us-ascii?Q?RzjphTj/ZHwJ868KOTWjHUxdD4w7WsdnmiWwzbpOGsRIpgF/aiRwhyccH3mP?=
 =?us-ascii?Q?5bdxUHAw5P5BHc6VZl6uRwbviVBzwhj9BgaftvQPY/40h4WLk2nvEc+GLLFA?=
 =?us-ascii?Q?gHj9g3l8f5aCmeiTu4GDL6vRyDJuC52okFAzFkOBWY5kGjOO/kG539+LnZmu?=
 =?us-ascii?Q?AaMkQJJjDd8LpV/5s95vjdeWge+OvJPjQPEcUrvpY7+X5V79uOAsQbb29uYn?=
 =?us-ascii?Q?25qIf4H7XPCQlKVluR9N9ALKNSO5P7W+dLmlla+lyjmZS7e3lPlS/9b7l1aQ?=
 =?us-ascii?Q?pTETbLRaSsN9HchqFJGzV8/80O4cOtYx6jWE1jo//MZI+OTfhw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OH4wehAhKMl4U7Yp6WwUqPpEbeeDoJmYwX+f8V7zCsXEKUbO6+pQEkx2rYaO?=
 =?us-ascii?Q?Pgz2DrD256LJRZ5/cxA2whnjwgGdxDYHHNWIRr1cqg725Y7/x1uT20WFiKbg?=
 =?us-ascii?Q?sO4FDSTnzy9SV4xyJ/ELTol346FiKtZ2A8rmiU+K8Kpelvf9YwI6NQ4Vp1yC?=
 =?us-ascii?Q?llpSYGG74nyFe4oTdjsUzt6mRKSt5tsFgyTxHNXb/BWERlpgsgknczhQ/Axo?=
 =?us-ascii?Q?iu49wGwW3oNNcqdNEwud5WmnPP8gwuEzm2eCUDhE868W/AjNQCBKD+gJfkaY?=
 =?us-ascii?Q?TYdMnDSqLjh0fnf7zXEYpk3FGlYnipOdEJVuq5KVM1Dnf+RREbxs5lGHus7j?=
 =?us-ascii?Q?8GsWlIP64a3/uF0PuRWnp+fGRriVp3xOPfy+RFHbheZqROk/9tK3KJ7gh7Ir?=
 =?us-ascii?Q?q0c4imzMeEEfetBCln8oMWkWVLHsahicmA5vvO+F6ugazSVVwFIy9zftVrA2?=
 =?us-ascii?Q?zrVPRdv9wGro+UTj8AHw4MwZbID//acRcsyMhHa5prBxY7DlbHlnPnRoaxX9?=
 =?us-ascii?Q?1OI6pkdcIYCv5Zt+NbppE8j20YDpj3IFNBo8sWbhX1tZ2Y57TQdizZzVmyMP?=
 =?us-ascii?Q?pPDAUXH5wEcwNXhIUNhwsxiGr9pTBJWKhkZb/adictiwhkPT5gZ9AHrEn/pW?=
 =?us-ascii?Q?8EOWqLRlzA2Hp8Q2ItYrDEHIjcI5VwvIHn+N3pwUSMEFXBxIfVCNi5IpjR+0?=
 =?us-ascii?Q?TZ/4jjF1y7hNNx/r1IdAq4/ojqzm9+ZNr185xFWyJadbuQ95wQrs2Md1NqTz?=
 =?us-ascii?Q?v0boYRD96cvjTUn7qesKROSLWcAjbz3NvycMxH5WzyHdcAojo9onrof6G664?=
 =?us-ascii?Q?fYYes8iaTplAcF53ez3lAO3H93I4yMVzcxkhjKYxFKA37MPfT/nWtfgRLsno?=
 =?us-ascii?Q?iNd5ShqNCtUTFUqSUCvwuCOU5lJ/5gktGjpjuYuDHQlgNC4sf090k94LVqwL?=
 =?us-ascii?Q?MB2GBV+eXXNxYx+klIJsdM9yMzXm1a8j7MsrpPkrJo9vRITG7EolnXgTioN5?=
 =?us-ascii?Q?ZQnNnNeeQwWWj5yPmpVQvF0OuWaqIHX/+wr8yxkENHS69F1ytbCgMxMdI8NO?=
 =?us-ascii?Q?G0uBDWhYp0n1LGlhoer17gVZAHtW9qXmdhEs5rbwDNIeXn+/6KrHaRrDQWie?=
 =?us-ascii?Q?/p1jxJXCPL4Ln8Wn7CSz2hinjhspbvLOOotljdV6ZE20+m0vnUAn/qAVZL6U?=
 =?us-ascii?Q?wieIzt54DwoophEtHe/3zmDAoOA0vhUhRGJbsrJEj5JI0cSW4FZ29V9Kv8uW?=
 =?us-ascii?Q?kfIgRthIUpLNq0qipZ5IBjU0gvXhh/hbeEBiipB3YvjYLlIgyb32/dQ1ZN4v?=
 =?us-ascii?Q?wcu0FLnzZcu8wcLn9p4/kVGrngs2dQ8AW8/EnN1QOOz0ZwIYDFRfa+rhSO4z?=
 =?us-ascii?Q?oa1vtOeKUTVeXxAaBwTm4yTcC/wuySDEex1kle9cF/vPPL3UIJmmEsXfrkPg?=
 =?us-ascii?Q?T+97NLAbh3eXN32SlgXBBf6szcPoHqJirE440wQDMC8/CZVodCnLs18xoInB?=
 =?us-ascii?Q?gjFFputtIoi7hfvv0FlB5NWrIwgpqQm19oWyLvzYkbzBimAWDcpZ3UOSOqdJ?=
 =?us-ascii?Q?cANsBIfCulASrioGVygwUeSxRf02VBb7vAF/tK/+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05a30c7e-31cf-4aaa-c8b3-08dcb987510e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2024 21:56:41.4213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nbgHFQEEfAwlFS8oMWnGJ78Mi0CdEMQXwaV3fTDaLpqtkjkQ8MunYBoswPKF9a8HpU1NJGeqZ6BwnmLoR+3xdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10857

On Sat, Aug 10, 2024 at 01:46:25PM +0200, Krzysztof Kozlowski wrote:
> On 09/08/2024 22:06, Frank Li wrote:
> > Add missed property phys, which indicate how connect to serdes phy.
> > Fix below warning:
> > arch/arm64/boot/dts/freescale/fsl-lx2160a-honeycomb.dtb: fsl-mc@80c000000: dpmacs:ethernet@7: Unevaluated properties are not allowed ('phys' was unexpected)
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/net/fsl,qoriq-mc-dpmac.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/net/fsl,qoriq-mc-dpmac.yaml b/Documentation/devicetree/bindings/net/fsl,qoriq-mc-dpmac.yaml
> > index 6538e0ce90b28..25d657be6956f 100644
> > --- a/Documentation/devicetree/bindings/net/fsl,qoriq-mc-dpmac.yaml
> > +++ b/Documentation/devicetree/bindings/net/fsl,qoriq-mc-dpmac.yaml
> > @@ -38,6 +38,10 @@ properties:
> >
> >    managed: true
> >
> > +  phys:
> > +    description: A reference to the SerDes lane(s)
>
> This is not the same phy as phy-handle points to?

I go through source code and dts, it is not the same. phys connect to chip
internal serdas phys. phy-handle points to external ethernet phy, which is
connected by mdio bus generally.

Frank
>
> Best regards,
> Krzysztof
>

