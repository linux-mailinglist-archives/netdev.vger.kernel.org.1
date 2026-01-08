Return-Path: <netdev+bounces-248001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4268ED01995
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 09:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AEA3A300180F
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 08:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E573815C1;
	Thu,  8 Jan 2026 08:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qn/USISC"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010045.outbound.protection.outlook.com [52.101.193.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F3637FF67
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 08:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767860072; cv=fail; b=tzWH0wnZ7UdyUfBh2TI4gcEe9Cj1d9IwWVa68NmHWWyTe4HRK4QonZh14VjuIPPJNmQoziFPgT5+SmLJXykbCEOUL0AfZuZmKnHtEGFhgp2hRngVhtwjkIXCIjsfVIrE1ITttqv6AjE9uLBxhtXX+cI6pUUX/cv+5+tuxrLEjK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767860072; c=relaxed/simple;
	bh=jukoWbh5ZrYGGwA55g0nlaaeQVl/x4q0MWTbwDzUqh4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VrGnAD2Y4pOTbGe7ECeQuyErCBC4wz44BGmQm4LNUR9D0zGnHPDmaFSNp/WUQuymEyzGDITlhzYBFf47rxDf7TPPIXTH745H/Qm2qNBVzwh677oGaYp5tk9e4PU1DPC/PsKzbJG7voKKYSZprmyf/X59T5VtJX5gSuKESIV75Wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Qn/USISC; arc=fail smtp.client-ip=52.101.193.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qlt8CZglieuILCXmooFqhFnTE0qbsZA7mMvKQBOYTRlU1HLiCQSwH7d6eUUR7nt4t4iq08ESDt2KsfIq90soJ2rxgHyDJkeU6wYOAZRZV+DsP4zfPoknOEq2yRCt7LB1h0cxd90/2TOaOAiwQm8be0DQ0Lo1gzilTRZYf/Old7FIRypjoqBwyeiok3DZ80FtKC9gJlAUIz4CO2x9AmtOSaLjdTaEw8S0+q616tUVp5ZS7C66I2gvTdhkpx4+cXC0YgOXxv/ArAWBIZin9CFSDirOA41aPA5N/b/+Rl/1xpzVszozG+Fesa5/8LNXzPGQRLhMFM6MasTwymSbd5WRTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZn7AyenmKB4jGE4XWdWF2qAH+VZbwcCXIqSJnqnhxQ=;
 b=MHM6VBKd/7FPaJivhIx5WctVZcaQpesbO9c5V55tMGsf2D88LXFhHBnr4R9O9TYVX3NDSjCaY0JsinHf/lqJOXM67WxP7X6lYK3VosYGP/E7/QUAxL+Xkxp5SZaGfCVXH17ySKOLGp+opL5g0CvQEPcH9t6B28jOorATcgmlGMhUZFFTp8CYepYNWfNbQ/TAhsui0+vlWZbrszPvvKHxjGa2bPz0JlkpRBJBN/Yb/ugUpBPBjlnr7Ff2KXmaoyGPGNztHkZaLPbU4rjEW4D6K4ecuC8/awwK2kB8avpezoQJiyDBwOwQAPpZaBYxuS0pYDpd5thPlEIQXZP3/VmBvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZn7AyenmKB4jGE4XWdWF2qAH+VZbwcCXIqSJnqnhxQ=;
 b=Qn/USISCAIlZCmK2ibexqjGd7yVTcB3aqyDIuOYHMH2nAKXB/WyJm4WdoWvK7RfNTHRIjWKh842o5ZOOHYuMDi5tqopykF/7FwlDRytnDZdm9U1pqpn0dh9roYJ7r8gWVI6SkiyHeEWIk9xpqf4dgkRj5V99mJ2VXKKvFZaW50lVqhD77NJq56gbU4OA1wItfgl+ZhHlpJJfCfu2nduX7Xygf+bAlpP+3quVcFObDHtxPWNde1GOv0zCsg9bbZ0oo9qFiBnCW3tQWXjbQPKZ5u6UJUgD8ufAxdR2pXIXKy1SN2HV5tIs0nC1E08WxJNvbPVZwW2qHKMmKe4+0L95ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB7003.namprd12.prod.outlook.com (2603:10b6:806:2c0::10)
 by CY8PR12MB7684.namprd12.prod.outlook.com (2603:10b6:930:87::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 08:14:09 +0000
Received: from SA0PR12MB7003.namprd12.prod.outlook.com
 ([fe80::4099:396e:1f40:169b]) by SA0PR12MB7003.namprd12.prod.outlook.com
 ([fe80::4099:396e:1f40:169b%4]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 08:14:09 +0000
Message-ID: <62889a99-65e8-40a2-86a8-da083915fbbf@nvidia.com>
Date: Thu, 8 Jan 2026 10:14:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ethtool: Clarify len/n_stats fields in/out
 semantics
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
 Simon Horman <horms@kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>
References: <20260105163923.49104-1-gal@nvidia.com>
 <20260106174816.0476e043@kernel.org>
 <8d5e3870-1918-4071-8442-1f7328b71a75@nvidia.com>
 <20260107183909.2611315d@kernel.org>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260107183909.2611315d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::15) To SA0PR12MB7003.namprd12.prod.outlook.com
 (2603:10b6:806:2c0::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7003:EE_|CY8PR12MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: 8703789e-5cd3-4d2f-c3cd-08de4e8de616
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1M4SDd2RStBVlE5dTJNcnlPMm9SZFpheEZLdkhoY25vSVhId2N0eTJpazBP?=
 =?utf-8?B?V1ROejZianR0d1JKc0w1UlRDWWZsYi9GejZ3VFBhbk5WM1JiY1JjSkxyTVhS?=
 =?utf-8?B?amVmK2ZEaHNVVDlsNElJNklOMURIbklvRGdGQ3dXSFh5TXh4TXc4Sm1sYXQ5?=
 =?utf-8?B?MTZxOEJIMHdWS3c1K1F2MExTRHZGcUhRUzN3VVp4b0lGeENlYVN2Z3VsSlFj?=
 =?utf-8?B?eldrRVNlS1RZaVEyeXZYcnlZNDRpeVVmZFZ2bTNjS2U3UWNMRmhsbXNZcXFR?=
 =?utf-8?B?U3RkNnovQ3BFa3NndllENm9ydUF2aGd1QUJHRVkyRm44VWVKOGY0Y25BUzhF?=
 =?utf-8?B?VE1IbUd2TEFoT2pKc0RaODlubzRtRFFML2dEUHJiMTJyckRGdUtja1VnZzNC?=
 =?utf-8?B?bTVUQkpqNzBIU2kzTzZSdEROZ3ZDc3BtanVlVGE0WGsrd3I3S2xzTHk4ZU1o?=
 =?utf-8?B?VGVnWnRvNFN6T3B2VlRqNTVvNFhwMFU5N2d6eWJ3SE5idW9LNXFnUkszNU1F?=
 =?utf-8?B?QVBWVkFmMmVEcitjTUZoUmk4NUpJeFkwUWFIZFNjWUNhVXpFZHRsU1YvcUd4?=
 =?utf-8?B?K3R5MFNjczltM2VGWkFySHZ1d1I2Z2lUNDhxVXlBKzU4RkxMbXVQY0tWczlB?=
 =?utf-8?B?RnZ2VTlGQjlTL2FHOFdPb09tQ1NGdE05VVBmVVE4UW50ejJheG5SR1hPS0Iv?=
 =?utf-8?B?NUxiRlJwSVNNVVlOZkV0WkpGNFB1aTBkdzE0MmNneTJFYmVLRVBFOEU2b09l?=
 =?utf-8?B?akpQUTA4L3FVajJVcWNMOWFabU81TUZIWXZQRkYvaTY5aXJsbTVkL3E3aHhL?=
 =?utf-8?B?WlNZa24wN3VlSm42Y29BWTc0K01YazE4eWV0b0lkd2dYZGdKVE9sc1VCZ0c5?=
 =?utf-8?B?dUJIWW5yRUtPTTZ1bzlOcTVIdFFNTUhDZ05qUkZ6anRWYXRQclMzUzlBMjBD?=
 =?utf-8?B?ajZQV2dCVHN2clZrK1prTjgweUJ0Mm40cUpkdlRKY1o0Szg0djJJakcvYWk2?=
 =?utf-8?B?N2lPOWRsdTEyOE5BVE84Ti81Yk4vWlZmWjZ4VGI1NUNRV2hxRkk0Yk5oYjhS?=
 =?utf-8?B?NENlQ0JUaWdoRWxrWCs2NzNJK2J5SnRmTCsxaGFBTnl0WDJINm9vU3pjT0dY?=
 =?utf-8?B?bFErV0dIZjVNSjNqb04zeVpqaW00SFF2YmZqL3l5OFlkOVpMYW1iY2tvek4v?=
 =?utf-8?B?SEJkSk1oT0xzMkRGYzRodFdxMElHayt3blRhN0VMQjI0VkI0N241TEpURDJC?=
 =?utf-8?B?ekZDWEluU1c5ODRUaDZBeXI3eVQybTJRclpBUkRQM0F6dkpzMlBNbkVoU015?=
 =?utf-8?B?WXoxMkJaZ0huUmxvSDc4U3JtVDZPejRYN1NPV014RDJVbjAyVFNNYnNGZmR5?=
 =?utf-8?B?dFRVZWg2aVVQQXMwajRzUkRrQ1JacU5VWUpoZEVMVjhoblkreEdFaXgzbzlu?=
 =?utf-8?B?K1JWazZOS3JTUVNCcVU0VTdoU2Q4Vy91cDF6clgwM3pCVmZJV1U4UjlEUW93?=
 =?utf-8?B?eUVNZ3RvM2lZNVo4UGJCYmJPWjN6cUhYalhvZEk5N1hITWNmT0IyVUpkT2xL?=
 =?utf-8?B?ZTM1Q2lCQXk5VGpaWmsrZjJ1VDVYMUk5eFhja2o0RU1nYjh3SkJMcU8vZVF2?=
 =?utf-8?B?NFBodTVMV1FIQndSZTdIZWRseE5NRzhVeC9UUWpHdEtrUmxOcUVaZmxFVkF4?=
 =?utf-8?B?Z1NGWlZJcEU5bzZFb0FEQzhFSzBYRlV5UWZTZVVOSmJ6WXI3bk93bXFJemRa?=
 =?utf-8?B?TnUySHpGN290bWF0RUg3MUdEUWJkT0FuUmNCNXk1MnQrRFg3bmR4K2NPRmVa?=
 =?utf-8?B?ZXZCOVB0V1hUZXZDcVFJRk1Xamw4STQ3QytrRll2SlpOWE9XK09PK2hSL1V2?=
 =?utf-8?B?V1Q4Nk5sZGpxbFNtQUE5NjVVZTQzQVRTZnZ0YlhZWko4S1AvWXpVWS9CSDQ1?=
 =?utf-8?Q?iD+DNIED8wJGDT6LIUCK5dFSPr/Oi7Pe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB7003.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGhyZXZRLzRvWDFWbm03U3NQNE5EdUFvblJlNFQycHRlZFlvdjUyb2NnTlov?=
 =?utf-8?B?Unh2aG5KKzRZVWhhOGhIYU13RXAxa2xVUWJIL3phS1Y3VlBKcUYvNFh6U1Nz?=
 =?utf-8?B?MllnKzBEai9UczFpY1FKOW9MVFJ5aVdEQzd4cHJQdUt3WFJGcnNSdi9BMmNl?=
 =?utf-8?B?Tms1S3Z1c2hOT2dRLy83NWFqZ0RsdE9JcmQyeWxSOGFTblhtNjBiTUJFVG1z?=
 =?utf-8?B?aFM0ZTRPM211aU43TVFyVVdFUGRkUStqTzA3NDFiN0lLTE90VTI3YUdob0xn?=
 =?utf-8?B?VDNOVVRZZ2NwbFh0THZOelJWVkgzQ0d2L0pqQlIzd294VWpxZ1cxWHpyK2hU?=
 =?utf-8?B?VXJWK1VncC9OS29QMkhKSGE2TmhEbXMrTmt2cmRTRSsrRW1kNUZEU1BYa2hB?=
 =?utf-8?B?T3Fxd3Y5emYxTTc4ckU1bnFGLzZyc01XNHdzSCtKbHdCcm5DQndqeWdEVzVj?=
 =?utf-8?B?SHQ3dFZjRFE3R3g3MW5KZzVEaUQvRnE3Y3FTM2lnUXZHR0M2NWdmYzdWSmds?=
 =?utf-8?B?R21Oa1dTbjIwZlB6NmF6eDNMQzgxZTU4TmU3ancyTmlOY3hGK3BwQXczSzIy?=
 =?utf-8?B?VHdIZW1rSHFSK1MwYjUvR3cveVZKWGpMbTdEenI3bXNwSkNtL3IzN1hwaWNC?=
 =?utf-8?B?SE8za3hYanh1TXF4dWhNWHBDUVpZa3laRjE5TGtMSjBHTGQ1TEhVWDFhSUEz?=
 =?utf-8?B?YlRjdFZUNGxvNnR2bXhUeit0MjFwT0VjRjhmenozKzhHNGVGcGdQMlJQNEpk?=
 =?utf-8?B?RGE3MUFWM2wzQTVTUFpwb0gwWURscHBreGNnblNXTEpWbmNlN052NThIdnds?=
 =?utf-8?B?U2JjRkd2UnoycW5Vd3RiWTNmOWNoaUkvM2Z0VGFLMnhtSmwzTGZYZTVaSzRl?=
 =?utf-8?B?ZGlGRWlXVlJ2bE9lbXhLTnphNU5NUG95SUUwL2syOFpsMjhGTGpYVndxWkZi?=
 =?utf-8?B?T0JBS1FRY3I5SWUwUkxwWTRuVnd1cW81NTZQYzhEV0JYMTlSWTZxWkRpZk4x?=
 =?utf-8?B?b1RwWnY1bVhwUUpadzFXMjZ1R0M4MVdyUEh4cGdhUG9YR3F6Z3dLeG5ZV210?=
 =?utf-8?B?cWlqM2NLVUJXbkNwb1JwNktaZFRJK3pIZ2d6ODdaS2tPVThWeWloVUVreThh?=
 =?utf-8?B?aHZlSzJ4VGwwcUoyMnBXTjdRNlY5WE9xNno3LzdLd3RONTdlSm5wTWE3NTRS?=
 =?utf-8?B?NWZaV245M0dXWTNsTUd1VTRGaTQ1cmR1bDNiaTd2aitiYkVwYnVTZlN5UUxB?=
 =?utf-8?B?RWEvbENNeFdJam45SE03dHd3eFRCMEphK3JiRmExT0hUeTloV2FZVEREV3hw?=
 =?utf-8?B?YzlJYVZsUktLVFlmc1ZlbXpOT1hGZU9YOGR1SE1COXk4eHI1TUtwKzR5djJv?=
 =?utf-8?B?OUNUcjJ3ZFVWK2ZPbThiV2syV1k3d1NuSDkxTllsb3hTRnZWK0JKOFJoc3JU?=
 =?utf-8?B?RDVKWkRmZy9qZ0FtVW40TGJUUzlHZXJwbWxlcllBc09zdWdlL2tnR28rOUlm?=
 =?utf-8?B?MWdGeEhvWWQrNEhpOU1pTEZPeStpQ0NaRDZoUDB3MzIzb1Q0TEFVZnBIejdo?=
 =?utf-8?B?RWJSZWRyZlFwSFpORlpTckZoUjZxWVpCZlJwUFo0ckhQQWxGeUdiOEpPY0E2?=
 =?utf-8?B?dnpwTERBbEYzVk8yNCtnRlRFUTUxeVlQSDROUkg4bFBnbWhaQUUzY3hOTTYr?=
 =?utf-8?B?R3dtUG55aTlDd01PYXdnMVJrNUxkOElZVUQ2cnN4c0svMzJhWThITnJ6My9z?=
 =?utf-8?B?aWRnbkRGRnd4VEJySE9hbEkzakE2UmpHR2ltc2JXTnZ3czhqdFh6RzcxaW8r?=
 =?utf-8?B?Y0pjanV0Qk94MCtXeTJCVnN3d3JZNW1wclFNRnMrR2swcnNORy9NQTNKS3hU?=
 =?utf-8?B?RktKRXBBOVIxdVJQMGtoZHNURGpzbG01ZmI2RE1LZzBPSjE4Mzh2SmNORW1i?=
 =?utf-8?B?WTZhQVE5anUvMC9KZXpOVFkyZU42OFFhVllZTDZYc0dFZlZid0lIUHBTVzVD?=
 =?utf-8?B?M2lQekl6YTZacERkYnlDZkhYTDJ5RHd4YWt0UE1MeWpuSmUxcGN4Vk41NGl4?=
 =?utf-8?B?cHd2WG5IK0Zmakk2YjhVa0gwdTB0Z3BmWlRJRS9LSlFZSVQwKzNjYXlCWXlD?=
 =?utf-8?B?UnU1Y1EzWFJaUW51eEhnKzMrbGR0cHVqRm1xK3FldVo5N0tyRUZvYjkwc2hj?=
 =?utf-8?B?SitKaGltZEJSbENnVkw5NitZNHMweTJNQ003WHdUdlFuUGUyQ2U2bjBqWW1G?=
 =?utf-8?B?bUlYNVJvVC96UVhzdjlManBGVldFVTJaUnRBamtwOE9Ea0sxMzgzNW5paWhL?=
 =?utf-8?Q?y+ExaAJ/lTLbZQn2Pd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8703789e-5cd3-4d2f-c3cd-08de4e8de616
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7003.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 08:14:09.3612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jB1MgtA6LjYWRVHTitLd91E7bTva4rEZ7pM5ZfStj2Od881UiU6wNA0sRrMpSRH/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7684

On 08/01/2026 4:39, Jakub Kicinski wrote:
> On Wed, 7 Jan 2026 10:51:46 +0200 Gal Pressman wrote:
>> On 07/01/2026 3:48, Jakub Kicinski wrote:
>>> On Mon, 5 Jan 2026 18:39:23 +0200 Gal Pressman wrote:  
>>>> - * @n_stats: On return, the number of statistics
>>>> + * @n_stats: On entry, the number of stats requested.
>>>> +	On return, the number of stats returned.
>>>>   * @data: Array of statistics  
>>>
>>> Missing a '*'  
>>
>> Ah, missed it, thanks!
>>
>>> But stepping back we should rephrase the comment to cover both
>>> directions instead of mechanically adding the corresponding "On entry"  
>>
>> What do you mean?
>> How would you phrase it?
> 
> Maybe just "number of stats"? 
> 
> If you want you can (in the body of the doc) go into the detail that
> setting the value on input is optional. And on output it will either 
> be the number of stats reported or 0 if there's a mismatch?

Will do.

> 
>>> FTR my recollection was that we never validated these field on entry and
>>> if that's the case 7b07be1ff1cb6 is quite questionable, uAPI-breakage
>>> wise.  
>>
>> Can you describe the breakage please?
>>
>> The kernel didn't look at this field on entry, but AFAICT, it was passed
>> from userspace since the beginning of time.
>>
>> As a precaution, the cited patch only looks at the input values if
>> they're different than zero, so theoretical apps that didn't fill them
>> shouldn't be affected.
>>
>> Maybe if the app deliberately put a wrong length value on the input buffer?
> 
> Not deliberately, but there used to be nothing illegal about
> malloc()'ing the area and only initializing cmd. n_stats was
> clearly defined as output only, and zeroing out the buffer
> was kinda pointless given that kernel was expected to override
> the stats area immediately with data.

Yes, passing an uninitialized buffer from userspace seems like bad
practice, but you're right.

> 
> Don't think we need to revert the change now, let's see if anyone
> complains (perhaps ethtool CLI is the main way people interact with
> the stats?) But there have been LWN articles about this sort of "start
> using an un-validate field" in the past. It's well understood to be
> a no-no.

I agree with this statement, but it's usually referring to not start
using unvalidated reserved fields.

In this case, since ethtool always used this value with input semantics,
it is slightly different.

