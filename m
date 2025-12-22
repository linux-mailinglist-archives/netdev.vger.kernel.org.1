Return-Path: <netdev+bounces-245677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 949FDCD517A
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 09:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DF03C300E7B8
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 08:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CBE30DEC1;
	Mon, 22 Dec 2025 08:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="khIGsqZh"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010027.outbound.protection.outlook.com [52.101.61.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D661DF248
	for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 08:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766391501; cv=fail; b=a2HAiR29iScGOQEFgxgebKr3xv43BHzgnH84g7301DuIvdhsUAJTC/od61LolHZyb4kIpX0CgrYuUw1ExqpKy58iCpWGeyEhOzKSNxY8j8ddla0Tnm+nIfiJRtuF5husbEpMlOgrwUp9Ktc4eVzkkgcwzSC3U5Wxoq2Pmm/Vbjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766391501; c=relaxed/simple;
	bh=p+wCRMDsGSmeP4KO2fYx7iF5vaA8KA5/wxZEowfZFd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FKYm0uvJgtaAJ6hGegJwNcnlmNkzxUNt2k1FDU8cEInO/MRsXehQKdhI/f2RCTwBHYK2rJ9UsMXIjcMHvYVs3bUtIihT4rv1jdglBs4IpaisOQgHe1oKAUnOwOnXRkxnZ5CW0w8mXUBgaK9ej3/pcZFx0YMkB9mIjy9fJ2mpE1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=khIGsqZh; arc=fail smtp.client-ip=52.101.61.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E2qmmuVOiS3cFA/DhCzA3vWWUdzxddqR7edKBNxVtRbJYNY5Wy3b7EycdNcrjWEZudCS6cSrvQt32YP283mn2PlBl6zFSBMrR0cAaP04nLdD2jyrJD8o0PDeg62KnSmeXR2Bs3dr6jldC0oUl0DPAtfIkxH64X9aeRytZptOvetxOQ9BOSbPCyU7QfAbUfTIHiqx2cYbITWNz55UcuYiLmI6uFMUpAjXiW3ZvTYlgNJo0F/c9bL1ogAcbASNbjkkv0ezChj1H89wto+RFZqb76fvWwXLvaQtRL21PEiryggb9SKpwz/Itvv4OrdRt4b3HoRuhbLgFmkw5yHfzlH4Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+wCRMDsGSmeP4KO2fYx7iF5vaA8KA5/wxZEowfZFd0=;
 b=KvNpKF0z4D3KQ/Lb1wF2PrqXyCVFKKKHR9lgpVd0iSZZ1NTmMF27ONPok1Fq/eDdfgmXqt0HuvB59WQa1FImPpstveffrAE6hON/299C8MLR8qP8Qm6JwRD9cYWgNwjUh2cAE+CcvGYL3vw0UxuJsH87SMOOsxyKhoZlk+LvLn0Av7+fTd8QaUEumeHh+b59+GGfGJofJ2x4EOm+4qdcZMqsD04ZCt4gWVmoMUrOhzok6EFTv83aDZm8LPKfi0x8gOwc8ZBKBR2UFbzfd+Asonm3rnKlIT/7mS7LDQ/w9C9VV1hwv4Vjow7QbkjBskAdchH015MvlfwB2ZPM8j6Hqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+wCRMDsGSmeP4KO2fYx7iF5vaA8KA5/wxZEowfZFd0=;
 b=khIGsqZh1yn5k/Jl9i6dpKwEGifUpSAbWI/EQPq1ztMoK2XUy4SG8a+BqOHYiy/lcrkRUIiI6/mKj9IaBDMV5BcpVfrL++l7EGU+JTxfmUkACsvYZnp3S0R+Cz9h0QkqC6PEmnDwD0oM1y+kDDeUKO6nuSuR02DXu4SRJaf6TB+Z8VdQleTFVnnK7xAkRiroQc994fYy4RQXCv5xNbW1D39MG1P9XeK/GbTL22QduZ7fvh7U0RPPvhD4bL5mjs4q+Veisrhw1hI9+KRkmUajAaFW5KFBYfWGy4yjqTzykrRbPG1+CqUXT/ciWmsYkbZdHaW965/x9WFZEI2PAC6x+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CY5PR12MB6455.namprd12.prod.outlook.com (2603:10b6:930:35::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Mon, 22 Dec
 2025 08:18:17 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%2]) with mapi id 15.20.9434.009; Mon, 22 Dec 2025
 08:18:16 +0000
Date: Mon, 22 Dec 2025 10:18:06 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net v3 1/2] net: fib: restore ECMP balance from loopback
Message-ID: <aUj-vqYEGRAjkiMr@shredder>
References: <20251221192639.3911901-1-vadim.fedorenko@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251221192639.3911901-1-vadim.fedorenko@linux.dev>
X-ClientProxiedBy: TL2P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::6)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CY5PR12MB6455:EE_
X-MS-Office365-Filtering-Correlation-Id: 28bc6a9a-d2ee-4e16-e7b8-08de4132a8b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yAwhrm3ZlLeCgRLuisOuerR7sUsstvqQzHj58AotXj/u1bW0sgbQ0qLK5tlZ?=
 =?us-ascii?Q?lKu1T9RQ9AsBXBCjJIlgk+KhU1OZkHI4/vkOkCsT+aZCjJ9PUD1YrtSA+0rX?=
 =?us-ascii?Q?7YCsr/KmOamYjgEE5l5hvZNiBv27HTxHKZOA33jXXkjZdq9EGS6rGIWJt31t?=
 =?us-ascii?Q?mXGl6hdhC1koQbvRkMdeez0+h28IwibLaJp2qL6/hElJlRBnl76ExS0kWL03?=
 =?us-ascii?Q?iBX1dWU7Pjt/dW4qk6oQWftZSQIROpXjgJE2v1ZYvJbBCFUs6AX1Nu0/MjCK?=
 =?us-ascii?Q?bWveWz4r10aYzDcZaWnek19vk6nBij4nHs/6DMMmobkrhHqnwjV5k7WIJwkt?=
 =?us-ascii?Q?aepUDFLJwtxeAvJI6JVdk3UNrs6jMXMKG03w4tO+1NZJ9sV4XezL7NLSl/Yj?=
 =?us-ascii?Q?qbqif3zakTkjKNqdeSu53dgc8GrESuMKlc+Xx7p+kOuSzlL+FwVJ1HYyHsvv?=
 =?us-ascii?Q?gU4OzWyD2qtTUGVgqMaJ0eX7pOw4Uqm9maP5S3O2Pm+g8X+mj4GeDcblVP5p?=
 =?us-ascii?Q?fS8IVXLuqJXWftPZLdl3LpWmOcx11fGOweaK8BAnoRyTbQrMyqUyet43p1CJ?=
 =?us-ascii?Q?jXW1k+bKH+kWeQulJiz6o3oH7QC3s0uEviJR0GQxpk+TGvTsLxfMpAhinnZl?=
 =?us-ascii?Q?9SRRSv25Kts+rqCRYuLf6lXiOrSaYv1UgT4pWQME2qHwDtFLmA3zeiI/zpMv?=
 =?us-ascii?Q?iudzTaXsCORBCgUSma1l6NuETOlP5VKVrup+z4a0PZdH+Uoa+pAP+91SaibT?=
 =?us-ascii?Q?Nx/UowiyCjVAwDerTyf9zZtfUIJQyat6SiRLbqMWDk/xuUWsB0zGbIRwaVR+?=
 =?us-ascii?Q?rB157BFLlCMBCJ1PVvCa1h3C+c+hhKcmmbFaS4sZ5ZGLu+UeNJouMQgInTsS?=
 =?us-ascii?Q?GqErTbyWyvyrK0LvBRNiIZu8gNt4tebfTjyFsmfx1JRHd4DFu5pauP/4Po+/?=
 =?us-ascii?Q?ZXxqINwr6FPnr9hsvsdUSOOuJ+SxmTCkXJwAiWbl02jLgWcTwY+lEsdt7YVO?=
 =?us-ascii?Q?Cxwm0KmAGrAuTDKsIbRUa0sUIURtZQaK9ztZdIW4cJSzcNGFcotxB36kK6Bp?=
 =?us-ascii?Q?Yy+73/QksC6X3o52tF9Tfc8eRXtc3LfByZ2pvrT1OH6PiOraAONmtUoAZ2NY?=
 =?us-ascii?Q?jspmwzJ4srbeS9LlcqtupADtBC+cNye8OuF/fgHXmu9o+IKUvvhSrs8KI9R7?=
 =?us-ascii?Q?XEuIzx3rPkdee5vxX/4n8T38MoQzkiI7yl3zUZvQQh/EaXdKYGOru4Fd+XJA?=
 =?us-ascii?Q?y4O+TkEl4Hi57Cn0G1QxvPWrlM9mciD8oawyrMxtQWnGHZ3pkj4072h/uKWt?=
 =?us-ascii?Q?/Lf4uufrjf5o/C6/92LtTeEoYvJ92rC9sVk9EIScLOF/Be1DUQ6rqf7VtjIz?=
 =?us-ascii?Q?5V2+57ztF88ysCDGXrtPlXXCi/+N2gpGN2F13O47WpUqBTnlqT0IJ4E90MiW?=
 =?us-ascii?Q?JsiEp5oc5RuNBGTrL35ngu6+zfbDHA4C?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oBMnhbWqaH9XMCgLxY13JSAbgqMGxPQdrAkbeDng61cYAcVoNhUdRI2h73zM?=
 =?us-ascii?Q?VQpGzcgS4sOj64c+C6VO1IMPwiOBcntBrYqeOMgkdI8KW+xDgWRlI00EoAkF?=
 =?us-ascii?Q?EZ1E6Ku3ThYJ8ZLCGZTHu1HZr4S70Z4RotSpDfCAV4FdXyrsdOPQTC0zMs1j?=
 =?us-ascii?Q?CovcHhWbJ72c8zKi4VMt9fMk/fNDXzLQmTqEBAfAx2FrrA62AR6uPMsz4KsD?=
 =?us-ascii?Q?O5RusAYA18fFoblQCJOr/rnUfOh/Dwkvd8LlCPwIYEjIopg4qPQUGxGKaqnC?=
 =?us-ascii?Q?OPEN6Ax3pclM5BiHkvsvPixweFqIG9Kk/7tt2BvPg7vLexB7cO1Vlt/SANXF?=
 =?us-ascii?Q?E/TA/3YTuLKwPPhst10LFt+wE14byiPN/A5PHGwxueeVW6PbFMupK4g/9Tav?=
 =?us-ascii?Q?47XGxWgSRcr7jbN2xWI4HntvWG3CbP77mKi6/EYjQP2R5mCgbDGiNUVWpiOz?=
 =?us-ascii?Q?+mnkt0y5eqomxhiQqIS9j7Hhk5M+6287a/MfuEkHspv6LXIU6xktQu/IH87I?=
 =?us-ascii?Q?LCBThabucNOTtnv7z/4MgKaCoOQUmBpkcoHyjup0wNJTRY9Wqzheaa5b3THT?=
 =?us-ascii?Q?TZYNcIh9jRt5Z2rUbVTQmKNwEUx1kDLTz7HfBf7QfVveORDorUQge6TtF7VX?=
 =?us-ascii?Q?w+hBcfrwS8rXk4JY/E2J3UxYVSLLzmyG3BrdEPhmpB4kT660zor3ObWDFisw?=
 =?us-ascii?Q?mcMfLOjfEo4TafiFQlDjN1PKUMie8lhh9L8Uk5IUFip9BMu96LNKkGCIBVtl?=
 =?us-ascii?Q?8eOo6ilnED51PgYJnILEiTJF3J7zYR+lfvaN3Cr1ReT5OU4s6ny+K9XfPRQF?=
 =?us-ascii?Q?I4wSTyMx/Wo7AF3KTLMBsiXKnnMxOot5qu7g+ZxpKtMpwTZc2czj4y1Y7OJe?=
 =?us-ascii?Q?fT2Nh/+9pc/yF5748i/SDi2avM0Cj0l/z7BQLeB0ch2TM3ytchmI9tZmTjKt?=
 =?us-ascii?Q?uZYpRdaHWXMJXlEDHQxbR24vTX/NLQbXWSg8hwaXfRkyVOkxIjVhDVjwbGAl?=
 =?us-ascii?Q?WozON57I+tS5lzJeQeGCX+eYE6castzJMd32YpcyHFNLCoE7877cOycjtwLv?=
 =?us-ascii?Q?bLAbG5ufp7NdiI8hKMWlpARqe/bpC/dgP0juG16z2SwYhP78EulTaqJG5c1J?=
 =?us-ascii?Q?Kw+CVMrU3RXE3Z8e3YNAP2qE3q8o7TLib+LV2ftwlT0JcUYRa5CHctLjgo5b?=
 =?us-ascii?Q?FMDADt+daTSC1vtmNfol+VvPt4ImystgK3rOM4rQIO2KrvQAurifFMUj9LYC?=
 =?us-ascii?Q?SezOraDP67Yo4FFyFLUcr5rUMrmBjz3HZkwU0hDT0DBxBoWRgVJ/71gGewhM?=
 =?us-ascii?Q?l5xiZLkO5hIiPPDNNnh9Tjxp6WRe6n5xtgoMzX4TZQyoDR99r4jtan24Hl7/?=
 =?us-ascii?Q?LWlncqDF2efll7q1f3MZEA8HKVoswoS9mlZmxxYy87XbZn8HIBCbOwkXGOsU?=
 =?us-ascii?Q?EUsVGXZAfKC/yYuXLVMZKiMkLTf7xssT89QwdzOL031sVEL2e/+8zmCzy0V3?=
 =?us-ascii?Q?wH4ymk3cY8kh2QASMcQptLwxtbhZmLfLn87KbS2EufC2NEVuWWmwc6R6bizT?=
 =?us-ascii?Q?mwVWlCl//oPzKp7R9NJX7f7pFJTL03snRj3k1ty/ceExQy8z25uE2NxY7cZa?=
 =?us-ascii?Q?aD4wrEMtmkCCB3W/udPyhlYx1cWiXtWpmXMdOwREhrgt7bA85218WIdAK7bQ?=
 =?us-ascii?Q?xuiZ1yBVHzagm390QBFzYOND4U3zz+lpZSs7sq8cEyOeV2LR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28bc6a9a-d2ee-4e16-e7b8-08de4132a8b5
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 08:18:16.8964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aWi9LCTLWeW/HBkoCizRHFZgA1FBckjhl0Jrq3hZ+uuiSnV29CZ9cOOeKAl1U1W5GBNBK0NP5q0yxt96ntrnqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6455

On Sun, Dec 21, 2025 at 07:26:38PM +0000, Vadim Fedorenko wrote:
> Preference of nexthop with source address broke ECMP for packets with
> source addresses which are not in the broadcast domain, but rather added
> to loopback/dummy interfaces. Original behaviour was to balance over
> nexthops while now it uses the latest nexthop from the group. To fix the
> issue introduce next hop scoring system where next hops with source
> address equal to requested will always have higher priority.

[...]

> Fixes: 32607a332cfe ("ipv4: prefer multipath nexthop that matches source address")
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

