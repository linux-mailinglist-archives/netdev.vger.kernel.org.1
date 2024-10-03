Return-Path: <netdev+bounces-131654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D0198F274
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 17:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18A0C280E4C
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 15:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4034719F10C;
	Thu,  3 Oct 2024 15:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="E6IjxRmL"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010038.outbound.protection.outlook.com [52.101.69.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4200019F410
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 15:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727968976; cv=fail; b=nHI6i1pstV5u/eRwaaMOk2CateRsdRcIETpauEtLupKN93GLYxsHVs78+5JQEgi1IBILbVwQYoZtFDniKuGfcu2ctfPS/3yE6j5pWaVwpKTDyIVf3eUDhCOdv7Cl2qDsuoyYcsgDyRYdheld8OM0JWIvvsK0sGkdb1CH/c4ZxmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727968976; c=relaxed/simple;
	bh=aZZuBrAUKymfdU3non6sAdtJbAMc1EJXSQTCCvum8Kk=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e8gedd2Cs+q05no0YBCSRJRa7H1W8umnJRHXhZhv/mGx701qo+BylUdpDAUPm/2KjF9VrN4DzqdTxFs7M4rYLEk2j0mK7JL9ITP9srmHyrLAkFuKfIo30Im9BSCGL1IQhgpntBRt3hJr5proJFABz9TzWYxgu5RPKTcvfSQCzEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=E6IjxRmL; arc=fail smtp.client-ip=52.101.69.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LuJPHFFdSMfPQav628EqSBJR67bPOjPjNmGGutX1jlVZVgcXNi5SzN4/5JF++hLOqHfyUtlC2+X3OWC2IeyCoDL5k03ykfDAHuIipuRm8FgZETaiUQUoHobEFmfC0zZ+3ARq+Yv+GnLW+NRO5x67ToQOzghnKU8G2A69fAQfjs0r1gsjEGYZdWEaghPu0VhXLG8XqmxocatUC31Mc4MLJGYCRUJ8wsW+IXu4ne7WmwwFX/DDZPZJDmdZmuss9sFvb1S+eEobWBbPkMNw4JPKncN4NgkVQcKBcyL86jEW4cLZLVcUoTHlTzxj4hYrh8Yyqu5orpCzcqHVtfAWwWIqrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yaHCcTnTb87vYnXirmOt3ObyL4Id5CnhITUpk9C197Q=;
 b=EqK4fRVdK50bJknWiFrt5FNue9ROpXnz7wb/TOakYNQ5mOxTdKdWfFmm6L5kf7u2OcKkgo+l2TGzWxFQkFjWBEpVsYsg+3ZsZF868i0iBJu35ggNGo/SNxF8DRbxxoWsVKFfqnF004ovFZi4Kn3F7FuS60AyqQYhRSUzwDk3rGBbwDhePaAwwCd/DTVRPy3jio9ipSZMQIre6a5l1w+XJ4O2mMq2hjTf4l++rRpSL69AT2tOD3yNHdTNaZ+DQr8lB21wJtjU7jBUHNpNcF9TJDOSB1qtYdtx5XBSRDEkS8VlgHP8sJu+4A6ETHxYyJAYIHhWAG60sLRmSEfBrotuUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yaHCcTnTb87vYnXirmOt3ObyL4Id5CnhITUpk9C197Q=;
 b=E6IjxRmLGtS8W2h7DDSsl9nW0tqBTJ/whRGrbORl1aITVukkHbXYSsOisFHUx2XmiqzZsxx5I+h2jm4zYXMjBrvtBv2Z3g6pzFICDhAfdFiqI9Jfhk8b2rOBKeHhwvP/FK+oaFuFeN16ITrh8dm2zKkNRjenjvWqfe3olPcL+KG6hoOjH0ClzN1EMr/IfODUVoYaGRqtcvmz9k5EPvTW3PrAM8rMPYlEJZo+Q5d5zMkGT0vfOniln3vn2SnYMY1WRCLmCvmbB5yTuHxxu4CNcg7qji6Ru0LAwlY/FThVkxIXK6GqotvMU0/gxCzSp1BjclFHBW6gPeog+uGmrwncJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by GVXPR04MB11065.eurprd04.prod.outlook.com (2603:10a6:150:227::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 15:22:51 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.7982.033; Thu, 3 Oct 2024
 15:22:51 +0000
Date: Thu, 3 Oct 2024 18:22:48 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net-next v2 08/10] lib: packing: fix
 QUIRK_MSB_ON_THE_RIGHT behavior
Message-ID: <20241003152248.osrytygvz7nev2d3@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002-packing-kunit-tests-and-split-pack-unpack-v2-8-8373e551eae3@intel.com>
 <20241002-packing-kunit-tests-and-split-pack-unpack-v2-8-8373e551eae3@intel.com>
X-ClientProxiedBy: VI1P195CA0058.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::47) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|GVXPR04MB11065:EE_
X-MS-Office365-Filtering-Correlation-Id: c7319704-516d-4033-3b5b-08dce3bf3ea8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u72PKXZ5Htfd5vR64wANkpqvSGUuZ4AM7cGqavAnMCcCcz41MA+an9RBcpN3?=
 =?us-ascii?Q?26FFb7d/tal4M1aHJGP8m6EDkOzRNlCNtFdWxzlA98ZmNkkbDLK0fpfWyKgV?=
 =?us-ascii?Q?1UvAmqsKn5+dbD6yZEw+XDV2sbdtAV8HntGBc6sjCgvitP//r28vxFg3iR7N?=
 =?us-ascii?Q?Inz8XpnFmC7Ln6hLJx7JqKQlh7vDMd0ptceWSmqLRED5UGwu3+Vup7GjY9P6?=
 =?us-ascii?Q?Xw1XCW6yTGyhi2tTR7vkP88YH7VdBLhWfABQW/xOuewejNMlptNo2LMZQIXh?=
 =?us-ascii?Q?Okz/ahLsycfNZMapEyOy8SsUvSmjO9S1c077s3x0HGWruXJPKLyIkzs4CGEr?=
 =?us-ascii?Q?xryKIU1b5UGPH3TxnN0Udk2fKBNzcVskuz3BIRl321OSr7xRMA6UJObSzukn?=
 =?us-ascii?Q?GOR1+KTNQoIqH9eyrhT1dKKuv6Xzd/UkCsUISV1hPEkUi10xPN7E/XReCgrU?=
 =?us-ascii?Q?HkVy7zkd3NPUGWT+yrXMsjr6IsYIU8MTKsOlqK05+nPNskz4+g4MlI4qy1OL?=
 =?us-ascii?Q?muv4m7ApKC5XrXtbVM2ODC0LYz6pc0oXKSM9H8xYV2FLpejOE2ft7t6j2z4V?=
 =?us-ascii?Q?BsI0Q8Obd6DoUWi7bC3lRpadwNOHcQxBJQ43Ai00PjmjULeEq5LOQ6xZYLSj?=
 =?us-ascii?Q?h49ZL96ZgC6sTm44mwU+Fr9j4MFZmjE6+n7fxLdxRWyNyH1XkSORsKssXeqB?=
 =?us-ascii?Q?V1HQNSxuIOhoLx+4nVVoY9b7+J8vqWLtkNLzoTQBR5N10lT2dFwy7iWttLSH?=
 =?us-ascii?Q?nNAz0tVCYDK8ub/ngTxOIOKXUxSLqwS7/0Of490z0ozreEoRcaCItkFy0UG3?=
 =?us-ascii?Q?bYYVs1fIT52cmqs/x1rmtt/lKrzMBaPYDAtQXtVbzOr6S3QmZjdS/N/u11QA?=
 =?us-ascii?Q?CdYGKXWuv//0/+7zluDtuxERgMUo0WI2ck4yCKAvpHT3qwNDynVloDFGhwO0?=
 =?us-ascii?Q?+CpYkV3C3iOCltFaBq0mppa/scRrktu2Ht8d1Espfd0qO20HEdNA+eheoAfh?=
 =?us-ascii?Q?k38/GoUgE9p7fxci9tqvbvgZTlAhIzpRSy0ibQjyrYNAuF72I0NAkx+cVk5t?=
 =?us-ascii?Q?t5KMBIbibeCBP9I4en1IDZhRJoBm04DffXF7NSdTo29drnV/F4cNzmJB3bq0?=
 =?us-ascii?Q?FysOhc61eCUeAV1nz+N6m+rnd/Ap3Ggq8fyA21h67JNMmxxHJqmZuOYYJE/M?=
 =?us-ascii?Q?RgJSl3ZdVEjHaMffywr6/vi5rks2EVix+QwxMhslKage9zbs6PlccEH7GNeg?=
 =?us-ascii?Q?ngbclO5lbnroWoZYjV2pRUBk/vxd2x/04TIZ2b0SUg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?37bpp6mh0Y8rzSVxBBBzmqjc5n0gpG+5HNnefkgcQSaviZzvCl5fVYuPaLRR?=
 =?us-ascii?Q?CLvTxg9hl+i0osclZhX0ObvI1dJfxetpviTfQP842KUOma2SQnkaYSjaz6EI?=
 =?us-ascii?Q?b1llDNkc5OCjQkJyOflouNEw57ZINVHKHgcj7F+AxmLpFzJi+PEKaPHpFNHA?=
 =?us-ascii?Q?LsK2eUMo0InkmvQmVcRG+A3zWVqL0v3i6mOgvtQvHY3Oe3L+hcwfc8aTnDNw?=
 =?us-ascii?Q?qXyEthLiCnwNJT/PZ+F9r/jTMkZRxuGAKfYM8GHWqnx5dTLw6zBOakZSIpjF?=
 =?us-ascii?Q?pmggdSa6/MG2VCvFo1UHXueAtxiOru/cVqFfdGdQ5b/lDr6hsMHx6INTRaB1?=
 =?us-ascii?Q?OqIuXhcCWnL8zMQYdHkaP/nussIMIirvvz7gGPWiPaq0ScqODUK9uet9O3l7?=
 =?us-ascii?Q?QdBpwlX+1PXWeTFilwrqmUx8dFw75Zo5Q5vuNy+0guBV9p5w9yZ52InL5KV+?=
 =?us-ascii?Q?NeZcQyH7XcMGqqCuJJsdmRRiRl0njGk5ougz/ro1IC1W2c6dZcR8vboCyzOm?=
 =?us-ascii?Q?F3pQ7M8NtQrmZPURRT160zIFAwZziaH/EpP3ExhFkbW/d8TBT2W0WgPDtoDO?=
 =?us-ascii?Q?WweALjHjm6txdjgXFJ9loPJIvG8JBRS6SHpexjD3TtyLGEgTam13f93gWDWC?=
 =?us-ascii?Q?hP8PA68xx9rcBz3f68yoagXInQao6bdDlsrlFq6CUh+vUpXCDy9rykfvwUsT?=
 =?us-ascii?Q?Z39FA0EwM/RirQ043EYtzeusO4oIfDkUTZKUKuh11uwSHWTGl/QNHqepLPNZ?=
 =?us-ascii?Q?SqyG478mN6CUNmyfXExXbQu/O2AzBENlfcFmTLFCPKngJuzm9LPSrxd0S+ok?=
 =?us-ascii?Q?yeJDSe9jW4jDUyMV6WdUMtf59OAzkmPe2R234tYZv5RggeHo4zNJfOPnze1D?=
 =?us-ascii?Q?czI+02J2OVX3pXTbasSQbATKau9PAwD8rfdPVhR5r8BnQWl2Yums6+OG8WbS?=
 =?us-ascii?Q?kCzf4/ytc6VA4h+D6VCqNB2FQ5/y3rv6Xv/G2y8qN2wj3y77WWmXO8NYgVAr?=
 =?us-ascii?Q?hdYM2GGiGP/OIuoz+bkLhakBHu7nlR0IRdxVXrcSs+u6GsjxPOLQU4bwyS8U?=
 =?us-ascii?Q?uIKwG8mypZGEmL+R6eYnA+e12XuGQMhCk75+/MnwOUgwBak+MM2oy4Q4sfvo?=
 =?us-ascii?Q?wLmTXU1b9wB7pyVNoRlZNAV1j96vc1QLuyOlKFVlW45Q93VdeNF0/JfzA4rO?=
 =?us-ascii?Q?wA/EnV7uwsh9Kh33ME+Pa4e88zFvZq64B6YwasBzHPnupuaqLMBuGsMavBSP?=
 =?us-ascii?Q?MptuJ5j3CeYyaqnzScMXoZBaqeC4pKlqMWjeC8o6himT4aoxHXouZnqwn5xN?=
 =?us-ascii?Q?84V3HNjyztsce4ysfdYo2jnp+rI0P6XtBJ125HumpjSv75OZkWlKLLW1nrXL?=
 =?us-ascii?Q?G+jdqpT/MGXHZUFJrFw9AyW6tMuYn6oRNBMDooGI8/Yo/Z/DKY1u5Euwm2B0?=
 =?us-ascii?Q?0rhMDswP9dJHdw1MBYK+SjPw2vhxP4Qewg9kATdSjpxiQYp+SZ7ph/EE5YXf?=
 =?us-ascii?Q?4rn8bPCobLx8BeJPU1wSZlF/Su1FUZcsNC8UcRa8s7Kcfrm5J+xP8zg/VMBz?=
 =?us-ascii?Q?7BqCTreUTK8JAG07vP8H69YniyEup1gFE6pcsjeAFKt9X9oYqrGRyS6rmfIB?=
 =?us-ascii?Q?CQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7319704-516d-4033-3b5b-08dce3bf3ea8
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 15:22:51.1622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XRKNcMo7i83oGiDOYSobYulWJI4j6/9NhyHL6NU9wrLBDTYf+YWI+RdsUzxOntmKWgON8rGuETcy5XoV42vSpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11065

On Wed, Oct 02, 2024 at 02:51:57PM -0700, Jacob Keller wrote:
> The QUIRK_MSB_ON_THE_RIGHT quirk is intended to modify pack() and unpack()
> so that the most significant bit of each byte in the packed layout is on
> the right.
> 
> The way the quirk is currently implemented is broken whenever the packing
> code packs or unpacks any value that is not exactly a full byte.
> 
> The broken behavior can occur when packing any values smaller than one
> byte, when packing any value that is not exactly a whole number of bytes,
> or when the packing is not aligned to a byte boundary.
> 
> This quirk is documented in the following way:
> 
>   1. Normally (no quirks), we would do it like this:
> 
>   ::
> 
>     63 62 61 60 59 58 57 56 55 54 53 52 51 50 49 48 47 46 45 44 43 42 41 40 39 38 37 36 35 34 33 32
>     7                       6                       5                        4
>     31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10  9  8  7  6  5  4  3  2  1  0
>     3                       2                       1                        0
> 
>   <snip>
> 
>   2. If QUIRK_MSB_ON_THE_RIGHT is set, we do it like this:
> 
>   ::
> 
>     56 57 58 59 60 61 62 63 48 49 50 51 52 53 54 55 40 41 42 43 44 45 46 47 32 33 34 35 36 37 38 39
>     7                       6                        5                       4
>     24 25 26 27 28 29 30 31 16 17 18 19 20 21 22 23  8  9 10 11 12 13 14 15  0  1  2  3  4  5  6  7
>     3                       2                        1                       0
> 
>   That is, QUIRK_MSB_ON_THE_RIGHT does not affect byte positioning, but
>   inverts bit offsets inside a byte.
> 
> Essentially, the mapping for physical bit offsets should be reserved for a
> given byte within the payload. This reversal should be fixed to the bytes
> in the packing layout.
> 
> The logic to implement this quirk is handled within the
> adjust_for_msb_right_quirk() function. This function does not work properly
> when dealing with the bytes that contain only a partial amount of data.
> 
> In particular, consider trying to pack or unpack the range 53-44. We should
> always be mapping the bits from the logical ordering to their physical
> ordering in the same way, regardless of what sequence of bits we are
> unpacking.
> 
> This, we should grab the following logical bits:
> 
>   Logical: 55 54 53 52 51 50 49 48 47 45 44 43 42 41 40 39
>                   ^  ^  ^  ^  ^  ^  ^  ^  ^
> 
> And pack them into the physical bits:
> 
>    Physical: 48 49 50 51 52 53 54 55 40 41 42 43 44 45 46 47
>     Logical: 48 49 50 51 52 53                   44 45 46 47
>               ^  ^  ^  ^  ^  ^                    ^  ^  ^  ^
> 
> The current logic in adjust_for_msb_right_quirk is broken. I believe it is
> intending to map according to the following:
> 
>   Physical: 48 49 50 51 52 53 54 55 40 41 42 43 44 45 46 47
>    Logical:       48 49 50 51 52 53 44 45 46 47
>                    ^  ^  ^  ^  ^  ^  ^  ^  ^  ^
> 
> That is, it tries to keep the bits at the start and end of a packing
> together. This is wrong, as it makes the packing change what bit is being
> mapped to what based on which bits you're currently packing or unpacking.
> 
> Worse, the actual calculations within adjust_for_msb_right_quirk don't make
> sense.
> 
> Consider the case when packing the last byte of an unaligned packing. It
> might have a start bit of 7 and an end bit of 5. This would have a width of
> 3 bits. The new_start_bit will be calculated as the width - the box_end_bit
> - 1. This will underflow and produce a negative value, which will
> ultimate result in generating a new box_mask of all 0s.
> 
> For any other values, the result of the calculations of the
> new_box_end_bit, new_box_start_bit, and the new box_mask will result in the
> exact same values for the box_end_bit, box_start_bit, and box_mask. This
> makes the calculations completely irrelevant.
> 
> If box_end_bit is 0, and box_start_bit is 7, then the entire function of
> adjust_for_msb_right_quirk will boil down to just:
> 
>     *to_write = bitrev8(*to_write)
> 
> The other adjustments are attempting (incorrectly) to keep the bits in the
> same place but just reversed. This is not the right behavior even if
> implemented correctly, as it leaves the mapping dependent on the bit values
> being packed or unpacked.
> 
> Remove adjust_for_msb_right_quirk() and just use bitrev8 to reverse the
> byte order when interacting with the packed data.
> 
> In particular, for packing, we need to reverse both the box_mask and the
> physical value being packed. This is done after shifting the value by
> box_end_bit so that the reversed mapping is always aligned to the physical
> buffer byte boundary. The box_mask is reversed as we're about to use it to
> clear any stale bits in the physical buffer at this block.
> 
> For unpacking, we need to reverse the contents of the physical buffer
> *before* masking with the box_mask. This is critical, as the box_mask is a
> logical mask of the bit layout before handling the QUIRK_MSB_ON_THE_RIGHT.
> 
> Add several new tests which cover this behavior. These tests will fail
> without the fix and pass afterwards. Note that no current drivers make use
> of QUIRK_MSB_ON_THE_RIGHT. I suspect this is why there have been no reports
> of this inconsistency before.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com>

