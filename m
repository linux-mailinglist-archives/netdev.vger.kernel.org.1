Return-Path: <netdev+bounces-78265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 900B8874968
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 09:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADB9C1C209DE
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 08:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAEE6313F;
	Thu,  7 Mar 2024 08:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="kjKBHYg3"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2120.outbound.protection.outlook.com [40.107.243.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01F06311A
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 08:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709799493; cv=fail; b=VAwW7yEUWsipA5d/x1hAjZCqD+I2WHkoJjeUETsp7Avonqt2LMPOxerTyLZ7be43me5ZUJSqSLJH+w5cOjX6Tjk73F++yKHAHKmCIpog9CZ9xl/bPkmwLb4ElsgGI50sXbZIDeLJWshn04r7kYqc9d3n0gqaVhoH3ParhreWIsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709799493; c=relaxed/simple;
	bh=oQkwY0zE8FstJQJuSfa49xXPl9zFKG5iAnzdM+hj0xY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ool4fynrKZAh2o6WeZv94MnCczhi2va+nbHMKgrI6FCQVxSgXpOjVTdJ1rIQBkuRC2bJDrkdX0DKU4RPYnPSSDr7HqFq9RPAt7VLA+wYiKoAhERAD4rN+WtXyexKbzNc6XTMLAadqrBaen1gBU+p6FNinrp+EBSnapT88Dklw18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=kjKBHYg3; arc=fail smtp.client-ip=40.107.243.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dpT2hOPaWvE6J+508ZLoaS4BYhfNlO9OjYONUPbywDCUkcXqIN9uJwV305WnzcbTfMcMByV22hS6XXJ0XzeUv7jQtWhb424kalzFH2nRgn8+IcizmtXnEFXoEwryafm300HW1Vi6uTXQh3A4rju+/UV2jb6W4FS8+nedZMqEUmyRrff85JgodVSxlZHibdMzaFMa094IbvQ/k+rgtaFda4pvFFf+bzE+innKIquzFYyX1xNvup3YLkcPVt5i3/AtXG4lYDZYUUNfLlbI5jDFhFw84ueLtr4brkygOf25t4uoVCgpz/hs0dn8TH4goKw/2MdOEtii6uSAqM+/KCl10w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eqrq8ecukqB9l6RotS7kr+t7zR0PBCShe9tE0yZvDOU=;
 b=oTtabNWGlauLMMe7Cf9ScXmqrJOCnmfHMBrykB73tbKpXN7CI5ddFWGLEu+he9Bsk3ouNMUck/MKUsfJ7r/LYd8pMx3CBD2udVyQvTQy/Xzzbr5Toax9wQw1reozFOvia3XL9k//q86feD+GmK69GSg7HVK+rHhEug97up67b/CNTxzwydziJX6Quu3hvdFG0pCfDlJMnaNxCvZYFCbpZ9k9FzoMvJ2ix7XCwEPIHEustyYBNnNYXHGFnHA9jCYxkx/mhdMoHJ8Q7g6SBqyFYf32ik/EBekmNck+4V8bOau6eGy38JB63C1RBfjanXKhSSQ/stGMZ3E8CdcIlIucOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eqrq8ecukqB9l6RotS7kr+t7zR0PBCShe9tE0yZvDOU=;
 b=kjKBHYg3QLoCocw7J1ngEZ+ZHFpmJ9pLeS8tvRUKE3meMoXEWPiwRg1wPkEFTYnXlPoppHPgAQJZb6HQWO3dS69uF7VVIJd25Qn/nLsk9n7/nZhp8XkzCG3ITLpbTsp/pYCutNLZO4RDxRXkBLHdY1MDDs990tnPk7n4LVcLmgw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
 by CH3PR13MB6411.namprd13.prod.outlook.com (2603:10b6:610:198::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 08:18:06 +0000
Received: from BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::c57e:f9a:48ad:4ceb]) by BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::c57e:f9a:48ad:4ceb%7]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 08:18:06 +0000
Date: Thu, 7 Mar 2024 10:17:27 +0200
From: Louis Peens <louis.peens@corigine.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, David Miller <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Fei Qin <fei.qin@corigine.com>,
	netdev@vger.kernel.org, oss-drivers@corigine.com
Subject: Re: [PATCH net-next v2 1/4] devlink: add two info version tags
Message-ID: <Zel4F74EqG2YMf+w@LouisNoVo>
References: <20240228075140.12085-1-louis.peens@corigine.com>
 <20240228075140.12085-2-louis.peens@corigine.com>
 <Zd8js1wsTCxSLYxy@nanopsycho>
 <20240228203235.22b5f122@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228203235.22b5f122@kernel.org>
X-ClientProxiedBy: JNXP275CA0017.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::29)
 To BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR13MB4403:EE_|CH3PR13MB6411:EE_
X-MS-Office365-Filtering-Correlation-Id: b6258075-44e1-47d8-c942-08dc3e7f1dbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ms/7k58cch5Pge/jPb4Cv0n6VDhvRNobG0WtMdb8fCQhKNYcExY73bbHCR/QJTkJlR8WThJwBbR8HSOIHqznBuuzQ2Q8vm9iauh/JwnGZSHRGMQaayqssAepVe+MtwvevDrQ9ATflCiruP616RZGJfNyfW72eR8YOysJBvp/hnFUJjra4N62RgtujdsiIJ10VusZXucpGZyvWtvgTJk3C8IC3ugiYPIUm1gGv8fXHIE5Kt2fMmmRroEcsnOAGmlTMWi8Ffls7YNXsykqchUXT62RwoOqWxbvlWpDGCILyGIXR713jCd7Z63TMOnfxtM3DBFQugoNH8U2U9ev3EBJ2AIeLPPFOiXedj4Ytu3VDv0CBzG9xOPEfC5wSGuKxnC9OLKRXQ2RJZZlo6/mOK1zKqKWow/iXLCPqxv6Y8sjUgWdP/ZOfbTcsOa4zm2vP1LFZ2aXkddmqLabVhPFgCAY0sjvn2xLF4FaD87M5LUhyZfiLMi7x44wTM1XlpInXKc70h5e0r9zmaAOcFlFLYiaJCf6xiMasM/QRAVrZzkSQNzoNOY5QkWC4FPuxOWyIYfTjwBTuqwTVyao6Acu50ikriQwRUbnUQydhzJt9z/a5M+ym7aSBOg5UjAi48BThQGs2C8bMM4DmKCdbNPuvnsWAr2J1CeHRWn0b9bcylaJeHA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR13MB4403.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qtiKpHNKP332MFmyZS85d7KvBWRKmOOkYwYq/TrTR9UOnw+HygI14ujl1KxS?=
 =?us-ascii?Q?opkBbBy4VbgO5WrGp29xVzVHocxOsic86id9cI8LytMPSEnjTCkkutNNkZeK?=
 =?us-ascii?Q?ETn24gv12/gisPAqYI5W23cmkJtbr/8J+yHhuu62M9XsZ+EXelQZq6n4Nz1C?=
 =?us-ascii?Q?UIolbT1IXAc0LZx4QINXjfxoStw12O6aY6dTZPonx6xudkVG9HofDx8Ak0rJ?=
 =?us-ascii?Q?SPeldlhSpVIipKjbv653Pis2pSJs5s20iGB3AetMgsxXFmRArU6QHm7YX1mp?=
 =?us-ascii?Q?MiHaeCIMsH/1/yxzfhneHBYrmfyPHTcN8P0ZuOI8zGWuT8xsiAvPP/HHMgh9?=
 =?us-ascii?Q?8Ep+Vs6IEieM9RGTVAUKTC+5Wbl5zS/uN76JnVvLcQt/Cj7BIf66SfAsAR5i?=
 =?us-ascii?Q?09U8w/+fY3GOJVsLrharDzPCedeLYQ8GbnupWI+JXAyoajw1kFbrH8rXe57P?=
 =?us-ascii?Q?bqdrQoz4P26n6FaqOGUAOr6T+XdSFAsyhIWZh+EwqifROxJ/kOlOQRoOgpIC?=
 =?us-ascii?Q?5Va9NRKUH3IRD0GphH6n5ZcsKxuPT4x1Pdv8tGqz2XkU5u3j4c5/ClA3mlMa?=
 =?us-ascii?Q?nq9bamFQOUqJDSuMKPPj5wCtJ69ejwirLOaIV5pZDz0y4/B5iN+6RjVeLi2t?=
 =?us-ascii?Q?FR5Y0pjw1FZiNvWIYvm2w54awwks0+0pm0XOF8wfzRxqbGirsHHXJN/FgxIi?=
 =?us-ascii?Q?zHGGd+bFQhKmk69Fca/u+yfQwfbxX2whNyJyeHFRqmy5ryvnHm3QwDclwM9Q?=
 =?us-ascii?Q?nH/6bcaogkoJEdeGxyYwUOMnrPXRGL//WGS/dCYnAFvEYv5weV6Ocbk9fgkE?=
 =?us-ascii?Q?cjvS/FdF4ehRe4X9ZBIzH9AHlSS9AQJqpQuaLAJWU3hHlz5xCvMcGBHXpmDC?=
 =?us-ascii?Q?evw9V4pkeID6Wl9XZqXZ9+vit7kI4gxaWYKr7xt3E5decI97xP+Be7xcPmyr?=
 =?us-ascii?Q?ZYxs75eW4ix8AyjPBTRBHAaMuvR6RlSDqArx9G6zH4DxHYkH1d5b2gpH5Loq?=
 =?us-ascii?Q?q7QiYznSDgsJFbt3tWCYhlyoimqzq4Z3FCV93daXHzrW3+D6XuOalyBtIskq?=
 =?us-ascii?Q?w1ygPc0KH0QTRnQla1yICgyxXuN1Cf2T0+gjH4B3wAQo7QkUfhsVdd4PObRC?=
 =?us-ascii?Q?5zi8BFJwb+9WPiIgjPbkCOmbcV1kYdN4l0POCdEkT92b42AkZgjcvgmVkXA7?=
 =?us-ascii?Q?BZxwnXil8X2GgLg6h1lL1rZsPh8Sy+MIlLr2LOmKobavE0p0RfBMWjqvoiLO?=
 =?us-ascii?Q?qLVM+B998YXk78L4mtaW1oWYAecIbXW3guTKvSZJ8BAxzSokDdnFq40qJjHV?=
 =?us-ascii?Q?zUcgdG7ubZL57sv9lrYvgtCzAQB7vl2+OoE8ypeSN4TbEYimxJRjMaNh2/9l?=
 =?us-ascii?Q?5189Rzc2n1d5FUGP7Erp5jPMrgzmfDK9WXDBZy5uILKg1sCTXBEFuLLcUPHK?=
 =?us-ascii?Q?ar7xn5Ce3darShsgYr8tcmlK0wjuaSdlZLHybE+wtPft5VO8CpsOAjfsrnXj?=
 =?us-ascii?Q?DyJUBX1pjJVnsWjCAoOgYlqvw2mlNE5c/fW7qFiTH08bFoV5Q7BQ6TsW1Iuj?=
 =?us-ascii?Q?HPfBy4CiNQgCk1XC7Wk8X8/CN67EkTu+j4vdBIlV4p0kkf3zyrWLSKNIg9eG?=
 =?us-ascii?Q?JA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6258075-44e1-47d8-c942-08dc3e7f1dbd
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4403.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 08:18:06.4037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e0R02soma80x6q2i+nEKA0cwsBUm6iG/aa7SbfKrRus8CHJ63oXYT+1GXKOnYDDOuYtdy9L24UvQ05xxz589znQxwO9Y8MEpZUoI1CEH/mQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR13MB6411

On Wed, Feb 28, 2024 at 08:32:35PM -0800, Jakub Kicinski wrote:
> On Wed, 28 Feb 2024 13:14:43 +0100 Jiri Pirko wrote:
> > >+/* Part number for entire product */
> > >+#define DEVLINK_INFO_VERSION_GENERIC_PART_NUMBER       "part_number"  
> > 
> > /* Part number, identifier of board design */
> > #define DEVLINK_INFO_VERSION_GENERIC_BOARD_ID   "board.id"
> > 
> > Isn't this what you are looking for?
> 
> My memory is fading but AFAIR when I added the other IDs, back in my
> Netronome days, the expectation was that they would be combined
> together to form the part number.
> 
> Not sure why they need a separate one now, maybe they lost the docs,
> maybe requirements changed. Would be good to know... :)
Hi Jiri, Jakub, sorry for the delay in coming back to this. It did
indeed trigger a bit of an internal discussion about which number is
where and for what purpose. More detail at the end.
> 
> > "part_number" without domain (boards/asic/fw) does not look correct to
> > me. "Product" sounds very odd.
> 
> I believe Part Number is what PCI VPD calls it.
This is indeed where the decision to use "part_number" is coming from.
> 
> In addition to Jiri's questions:
> 
> > +/* Model of the board */
> > +#define DEVLINK_INFO_VERSION_GENERIC_BOARD_MODEL       "board.model"
> 
> What's the difference between this and:
> 
>  board.id
>  --------
>  
>  Unique identifier of the board design.
> 
> ? One is AMDA the other one is code name?
> You gotta provide more guidance how the two differ...
Carefully looking at this again revealed that "board.model" is indeed
the code name, and it probably shouldn't be a generic field. Or if it is
it should named better, and be called something like
'DEVLINK_INFO_VERSION_GENERIC_BOARD_CODENAME' instead. I do not know why
this was added in the first place, maybe it was a requirement at some
point, and I'm hesitant to just remove the user visible field now. But I
am happy to keep it local to the driver - it was moved based on Jiri's
suggestion - should have provided a better explanation then.

"board.id" is not the same thing as "part_number", or at least not closely
related anymore. Perhaps it was previously, but I can't find any
information on this.

"board.id" is the AMDA number, something like AMDA2001-1003, and it gets
combined with a few other fields to generate the product_id, exposed as
the devlink serial_number field. The AMDA number that is provided in the
"board.id" field is still used to identify firmware names from the
driver side.

"part_number" looks like this: CGX11-A2PSNM. This is a number that is
printed on the board, and also a field that can get exposed over BMC by
products that supports this.

While Fei was preparing the patch there was discussion about using
"board.id" instead for the part_number as they do seem quite similar in
purpose. The reason why we proposed a new field instead was that the
information in "board.id" can still be helpful for identification. If
there are some scripts out there that uses the "board.id" field, for
example to build up a firmware pathname, replacing it with the
"part_number" will break those.

V1 of the series did also have the "part_number" in the driver only,
Jiri requested moving it to devlink itself.

Proposal for V3 - Move both fields back to driver-only, and greatly
improve the commit message to explain the difference. Does this sound
reasonable?

