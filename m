Return-Path: <netdev+bounces-152333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1079F3748
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 18:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53A1418918F0
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE2B14884F;
	Mon, 16 Dec 2024 17:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ay1F25cM"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9E9839F4
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 17:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734369430; cv=fail; b=bXTbn75q4i/e78uoPTqtBC7aoY88Z9QCnlpq3cGrCbPQhbI31EgiwiqzXAtLRHcg4g2h3VJVmkPneW00wIaIXSScyIkPebhCziA7uHcPqwRgdYyRKKsY99ttFLft58Wk0Xtzc4VW1sjaDWsvh6ju/SOoYwdWMTOWWlXqsKE5YrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734369430; c=relaxed/simple;
	bh=REk05iWLBpbPdtNMSczl2OBcTULdRNZY2J45cymAB1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ow5i8uqtTZOSyTtA14jzvli0rk3sPzOpTXuZWZQ0GQA2dMhAh9j7q9OfE37RWgOtBNM8hknO66p3oTmM7rqJt7F6+JNmU6y92IC7AQVszmByiWLbb18NM7ShqKIq0mBOMlk7GWPTAj8XzsDHSsq71eygvA84Af/A82BglGYjx74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ay1F25cM; arc=fail smtp.client-ip=40.107.220.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TNjW9fWXZQieOARvNJvp8aXSjCtHiD7jGZ41M1eb98VK7xZS6ERTks7Nv/XexRJ0xrTu2bsabQvy6Q25yudRj2+ExCvLYx2oDR5HF098Ffrbo3bEd+7Cv3QYDX/QfuhtbQh/1/aoO1Ci2tGqxirC21yY2Kcm2gQpvkpWiCm3OpomV+kmDo0nCzPD2Ceo6j9wqfGaTzBj1QXrGIihNkZz9dQS4Rfhz9XdN3HWuGHraer3tlHtcw9dGtu0ubNxvlDhtwLhC9ikb95ZuTOgko6srfEbx/J/0f4vAqJ5Hp+FMkFNwChhVcahO7zd3qY37A6yFIGTkdnjBGwdbPNdB0e27Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6kSi5jxN70ELCKoJ2xsYuINqbfantT4tmhyLd1uVzlk=;
 b=pJlZlLEtgksrkquvSDVLm5qEDldXRVhvbjrxR+APaEpvOeXWmgR/JltYQ/RYLio9GrB1/XirDEO3MwUDsjSWNHryVIWybH+s1MNUqTGa5MoK7NkwaFWW/GE9NoSYfGVW3LGsQ7LqzU+6i31VTYhZfRJj3HBlkmWomgsLk+35nWis9wHzFLy0Nnzf+4EjGIjMU1Br8kUJ2napsk6lHp/wG9MG/8srEW8SA19Z7Ep87AlJDf2dbifbDWP+/Xo3RLzmdPQ3DgG1gNcdl39O+JIVC3IkGaGwXIyerJBids8ZOJdbgD/PovzNFlxXJrvxhS9prX0+uUhihYyAOzOrePTENg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kSi5jxN70ELCKoJ2xsYuINqbfantT4tmhyLd1uVzlk=;
 b=Ay1F25cMekjLLfGf9XmTIMeojnGBTPr1Ip8vZrodzNUM9Hmayz2vYM0GNMdqmzbdrUHsAa6DCBJIwEJZ+EF5BE+Ij3KPelFzIHZxIL8ltwxrXllytXoclHq72p31p6izVO8xBTRj67Kv52eAqc9ptD1gy0449u2zENK/qEgjiJw7aOuwZ4zgtvYPPbiMzhR9rmdTRYqkl0VSwSQooXOZ1O8YfdTUBbBF6k+Ug1qKfiQzIG9ttfbFsrffE/JXxcD0VCNCSuuVD9Kw8qlIbRwBGqUJ4ReWnYF3OfI8hKx8Ji6Q9HkGO1Un5DcurGGJRz8h3HzvFFLPtpSrv86conuVPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by PH7PR12MB6859.namprd12.prod.outlook.com (2603:10b6:510:1b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Mon, 16 Dec
 2024 17:17:06 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3a32:fdf9:cf10:e695]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3a32:fdf9:cf10:e695%5]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 17:17:06 +0000
Date: Mon, 16 Dec 2024 19:16:55 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, dsahern@kernel.org, donald.hunter@gmail.com,
	horms@kernel.org, gnault@redhat.com, rostedt@goodmis.org,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	petrm@nvidia.com
Subject: Re: [PATCH net-next 0/9] net: fib_rules: Add flow label selector
 support
Message-ID: <Z2Bgh94m31sC7SIX@shredder>
References: <20241216171201.274644-1-idosch@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216171201.274644-1-idosch@nvidia.com>
X-ClientProxiedBy: FR5P281CA0051.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::20) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|PH7PR12MB6859:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d847dff-05aa-4c32-fe3e-08dd1df5770e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xM02tkneFqkRwAWkh3CYKzA6HI+cZjAIepdnMQW4fxdi50W59+/DGvaTjcDA?=
 =?us-ascii?Q?FHd9+m4D0mRnxPimSSkPY8PoSx0h4vxWVHPb7ktrDTvOMMnRES2VPL/B7nOx?=
 =?us-ascii?Q?McAArvYwFMjKafwYjA8Qod/VBJsd7uzaGwLXWvk5IdOsEF493VJhWV6chUh+?=
 =?us-ascii?Q?izw2SomnpMNLjMtSPUQFinCtDQZfdhGBUoJ0Y0MgcRo5pveFBKB9lcL3x3ro?=
 =?us-ascii?Q?R+tBq3YD7k7z6SA8Oa0C2e0yXIVwdfpeIrnbhfs+pG21jrcj01vPLu8/2ByG?=
 =?us-ascii?Q?74T/AAwj329e07Z4kX6f/mwjr5nv33hU37Hat2shbDKAfZ/06w398bC0eHBu?=
 =?us-ascii?Q?MgDeAoq0NKhccJNU9mWVU/iA/auDYnij4ewwL99YO010QGLWKty5k4cVK325?=
 =?us-ascii?Q?JbQsH7IlmXb1FoEOzJtZxzd6vdWgFutd+9QiaYhDGPxfbYrNjH4Sg+lsusRh?=
 =?us-ascii?Q?hlat4k9xqoNMuQENrrcwLTrbZlpKvt2NuPnuItQmT0x66ZES/n2Xgaj9ctyX?=
 =?us-ascii?Q?W14fPt1kc9CHrMtX0t9fB0epF9wEa8PKZYh3/QlKd9V75evTIDssUbkFN+pB?=
 =?us-ascii?Q?3yypmlWS4OOGhbaQpuGsx1mK2lHxC2MbL+z+g35WTDpgC1LkN/PyLx/1+Rjs?=
 =?us-ascii?Q?soLQACR1lk03VHrrKpO677+HCFCxfR9WR3cYV39Y1Fmc+5a0RcUCVTG0KSfO?=
 =?us-ascii?Q?TM+mDwpWhzv07QCa0ESLrDZKIR1/aoahtDY1RCKVnz/wOY35wbpsL+xx9Fs6?=
 =?us-ascii?Q?Eq9HZXsEqi0KWqHCMiMq9Q2nf77cj9lLloQFrQl3xhD/fa73P+S0KSgRpLHM?=
 =?us-ascii?Q?DNbPmuX0LCAkbLVvlQc2LYgzBzhhqhUKTASS9F2L3A2ckbVmbw+mFQSza8U8?=
 =?us-ascii?Q?4VAHA7W2TWWZhfY5bn6NDOC1PltSh/m4u9d/SeFZAETYgXBZsaHMaZTLnzWG?=
 =?us-ascii?Q?uxltp9ZLeWX31PC2zwA0ii1t/PaolaXpEPOZl+7d/orvM9TcwK2ugmWEXsp3?=
 =?us-ascii?Q?ajM55vQjlp2hRBFv2bSKQtPQ7zrOG5dp647s5wNPLANZKFX+zVPwc5Y/bOeX?=
 =?us-ascii?Q?ZqG8l+wRfqD1C7AE6Z82iVnwNgTpSOS17sQml/gPUTrNeVTv9vqsYko7Dmir?=
 =?us-ascii?Q?0gM37kw+T649BQzsLT2qLC9+rofAWx2tcReSViIX9Tlo3c3uE+n2H22wwpLd?=
 =?us-ascii?Q?Wf5u181NVXf6VkUX7qv9zwBPChm1dfEl2RJJiNTOh4rZorjzZzproC9vd1QQ?=
 =?us-ascii?Q?0JjzV7bZxDlzpTrN5SgG2cAZO3BT3Sl1gFq6ktR2RpgVtsbFBlY1dw99CouV?=
 =?us-ascii?Q?P5L4XlFQK5N/cYGiwZ9Sz1w3gMFvaSbf01fTG/7tR95DdhXL5ONUiEBYrYMV?=
 =?us-ascii?Q?AA5OlFPfswOTm8zxi4rzYIiTmmbD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XR9rWDeThpszsHpuqtsGi10g6OjNwpkFZ4uNuXNWhGVR0Y7ptnBWOzLCzgEG?=
 =?us-ascii?Q?0skBhyeP2OwKhiF3FpdsKhPyUtLb/5lRIPsSIVBr4YQ8E7Wo4HSx6in0mWww?=
 =?us-ascii?Q?9jeHn4dhURY8pFsCMjalOCOtu1pDsHdGD2Ki+p1xSQBbt1BG6xkRvjTEEH+J?=
 =?us-ascii?Q?vV1nlNXL3juwvqKBff7FwFkiE04/Pu8Lga0XKrMqEIlyt3f1q5oP3ydGztA1?=
 =?us-ascii?Q?R0h7PXp9KuqDSaiqNiU0qQ3J8meXstoaE3kB0NQp8TeSJ7Q4YIzncm0cohr0?=
 =?us-ascii?Q?W5lHkVvfpyc2k5kX/mL5NjFM56e9toBZCh+DEsSIrSzOlQQnEdzQ8ffCMbpB?=
 =?us-ascii?Q?4qLGlajT/DwFtS7GXmk4fKBIvP8TbtEYJyiywnGp5w1n2IACN5WZJBvUpCCc?=
 =?us-ascii?Q?93J4ti5bUyTyieRVq43QyIU5QlMNKbYAD2Ux6TB5CWQrpxv1Qy0yPcFQVot7?=
 =?us-ascii?Q?MfrhOGROY6T6fy6iwSRkm5fIqZuINMW/9mexQQ9FEG6X6QsgB+4tOG2tbgsr?=
 =?us-ascii?Q?oypg5uBK4W2VWw525gpEaBxEhwJREoAAaNKT4nS4WBAR+hvvt/MYA+Oz39lr?=
 =?us-ascii?Q?Vvl2pSx5Ox1sSGlP3uZNRMIMJs8HIgdDLbWr4y3oW/tyGGdNvCH/a3v1mj6F?=
 =?us-ascii?Q?Ruv8lhZPyVLplat/AVf9puUu7N0yjJBeGo+jN46McAGN1Vf91UGgd3ZMZRGu?=
 =?us-ascii?Q?ylhlLSxJxf+75kmLZN4/HvfMePQklkLzT/Gjn8AoN+dq0jtA3ZD+c11NHzVv?=
 =?us-ascii?Q?jxGrMTABiTIKfP8dZZBeUsKlt4fEEKbcAlOZ3C+yM8PRK7eu148PRDO8RCId?=
 =?us-ascii?Q?Jsiuu5fkDvWao+2ocftKOU8PjwV9nuTy2jkSpCXNWcYc1tE9ZTbhfKEsI7ti?=
 =?us-ascii?Q?7gRc6ElWCDe/fY4tozLj8iIHkCL3n9xaNqg/KasvF1YXWsCscmD5UXOmwN//?=
 =?us-ascii?Q?HibZs5w6GCYeAFimtLR3xlnE0UQ926peV+AJn7yLrh2hceVkDsTCzvdJolob?=
 =?us-ascii?Q?uRBoCatc+XQbIJx7bsMg0bbPC5Mb9vi7JIaaBOQG+0TWj5khtnLR4wHJgR+V?=
 =?us-ascii?Q?Vl1cNzfm8uPCgxOySQWp/IfiNI6MNNKySHmueMrmEQqHHDNMG1L+5/TpPkEY?=
 =?us-ascii?Q?YBQiM1Wj8WIkwcPv4kHFYU0VCUvYZeTczBxseCJ6ZmmCh0swwG2NrOuzlji7?=
 =?us-ascii?Q?P1zRBp3/RDLllGQ5MtHcl65mcodFYkeCGDsY2hWAuU0JWzMqfwgNArTW0GFq?=
 =?us-ascii?Q?IgYqDjyWuJRd4CdDY6VkdnsKr3PZL82/NiCL976ms+arXwNdI3cU2/qYEJ72?=
 =?us-ascii?Q?JvGsfNr0F1Qk81EsQYRqJXACRpCK5WTK7s6xoHKA5KoFFtqovK9pYqWViZhj?=
 =?us-ascii?Q?OwhmuNzjpIpP+e7Pnbtq9/vtSPqXp7c7rBerRWUeO9z1/vxouSjmlOkj/DcG?=
 =?us-ascii?Q?9FcCqAg7MFcxYwUtZqhs+PVQlz0U9geATilIHTom2CIn0Oyj1HrxAtYyTWhn?=
 =?us-ascii?Q?d4QQR40fM81mCOTSHvZ/5xoSlJd4oreKLK+f2Q+4UtV5JY5VmA9Bd/W39Hdg?=
 =?us-ascii?Q?wpF55AhCBUWGb6wwILT/dWtqkaVYS5tbm3JcekQh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d847dff-05aa-4c32-fe3e-08dd1df5770e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 17:17:05.9515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s0CZKfBnjgpERS9H4qjM0IFb7Ad/+0XtAG7S59uyGvYwv39Ot2wSqTTwU5p2Iul7cULLGtzPiHJUsZDwJayTNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6859

On Mon, Dec 16, 2024 at 07:11:52PM +0200, Ido Schimmel wrote:
> In some deployments users would like to encode path information into
> certain bits of the IPv6 flow label, the UDP source port and the DSCP
> and use this information to route packets accordingly.
> 
> Redirecting traffic to a routing table based on the flow label is not
> currently possible with Linux as FIB rules cannot match on it despite
> the flow label being available in the IPv6 flow key.
> 
> This patchset extends FIB rules to match on the flow label with a mask.
> Future patches will add mask attributes to L4 ports and DSCP matches.
> 
> Patches #1-#5 gradually extend FIB rules to match on the flow label.
> 
> Patches #6-#7 allow user space to specify a flow label in route get
> requests. This is useful for both debugging and testing.
> 
> Patch #8 adjusts the fib6_table_lookup tracepoint to print the flow
> label to the trace buffer for better observability.
> 
> Patch #9 extends the FIB rule selftest with flow label test cases while
> utilizing the route get functionality from patch #6.

Forgot to mention, iproute2 patches can be found here:
https://github.com/idosch/iproute2/tree/submit/flowlabel_rule_v1

