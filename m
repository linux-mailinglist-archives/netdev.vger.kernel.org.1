Return-Path: <netdev+bounces-216797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4570B353A1
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 07:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F73A683B83
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 05:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8305A2EE296;
	Tue, 26 Aug 2025 05:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nPeRZd++"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81132F3C11
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 05:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756187820; cv=fail; b=Jsngsp5s2ZzxBm8ymAFUYi4S+wWc+uj864EPeFZCOSJaFP0/PeC+n+BrncYaSyNYTwWuBp2VnaJhEsfS4C12KhevXMvO2Au7r+g6GpV5sTrWC54SLyUUmp7h7fOz7ytI27PlpbDfPxzNcNSfLNjhBlEskOKDsld1rSOuCV1hF/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756187820; c=relaxed/simple;
	bh=qhCJW7MSJRphPDg8FCkzN6+VDG1562Xhn4jsyTLKaQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rPngyJcr71CWWYr2+TGj5S31j7VmnAa9UI6DmMBGfpQrO7F0sq1vsAwxyG37J9r9cGfd7e+tgozv3wp1k1tIRLQSpBtIM/kf82itckG73yXTZ7xGbs/vxKhU9podGsDbGN8n9kZNnoxv88PXiKgf0Ca6RpDpOio1sd6DnnfWuro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nPeRZd++; arc=fail smtp.client-ip=40.107.220.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ob5I5tFhk9zvIEp0QXspZMA1WkWIBT+IaPfiaKpzmFI28w4gmSmnzdkhkf8OT6tNMbryOF9+DYST4+u/UNhJNyYI8MpYyqekiDQX7EPujtrCfuEHeIveQf5BPfeVbuHQwY+bpHk50yVSLFXhkiyR5737c93cxyc4WCBMeuOvlrm94AijsLiUvWOP49jscwTWKpAGwrz0cEplbV3O1EtBYjuNsl3OJUO4oufidxlUAMB6fjTEk7yQGBp2QGHHbBZgYhYygsXIXSdWPHK9kMo6Y/kakhhwWbC1HFwZfjQzUTCRO2B5ZarkOOrTsfk4rC+YhQ3zmSFqK14B2n8MoKbkyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aKlSbtU8HGSUocACqenLoScpgMzn65YAyZPPgsNmqY0=;
 b=jifYvKeFK7eYQavJWt9Qh8bnMHuW4+vvOBY3oX9cGvIYmZtXvC6bcqagjkz3FAO7mHUZSAZTgqHn3XjEUo8I1A3sTC/YGiRe2f68iAUw+FOMYiy5eMyqwvX4FaNXUgmP5W0MMW7f9hPmhQRDgdi5LfpU123apV2ok1JtsFI6UAlpxZJ6lkClK/vD+mWvlUbLVCxB+in9rTsuA38FOggy+o1YFNja+SzZzpUEAEiH79Ge1J9riNMq1sCPGP/b33zYKz1DOJoQ5HsvkxuIeZsOAjhsijMArtqxiTjW9OcJFmXhtE27c3N3qYROrT0q1lLnjijs9pd1xrFFDaaABoj25w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKlSbtU8HGSUocACqenLoScpgMzn65YAyZPPgsNmqY0=;
 b=nPeRZd++qIYjFngbDJVQwVnCP/nVfFYub/1WkJKrtf3INzjHVLKiBtxdadFrDae9eeYG5B/LjosPENCyddK29Fx3kBciRik5r4g4xDFRf4i/9E2GfVXZE406ji328t/LlC8QGIot4Z8DBUuJWUdRqjrs4Sk+UCf17zE9ICzG0eGT1K/ucschXERHrNjJZcf3+2n1vYBbRQOovuXdVmFUSI+1j2W9ZqGRMIbQFekxSrUMFnxHzy/dUnBX3zcQEdIEDRBP8cPEo4ZEzLxSzBgp+OEYQiCyiJ/79gbF3KKywqWHN52s+KpdrgIXmzDaMg4xGqI+2AlUaSPgx0Tt/BIZ1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS0PR12MB8561.namprd12.prod.outlook.com (2603:10b6:8:166::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 05:56:56 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%6]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 05:56:56 +0000
Date: Tue, 26 Aug 2025 08:56:46 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Harald Welte <laforge@gnumonks.org>,
	David Ahern <dsahern@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>
Subject: Re: [PATCH v2 net-next] ipv4: Convert ->flowi4_tos to dscp_t.
Message-ID: <aK1MnoX4eNw4Ql-1@shredder>
References: <29acecb45e911d17446b9a3dbdb1ab7b821ea371.1756128932.git.gnault@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29acecb45e911d17446b9a3dbdb1ab7b821ea371.1756128932.git.gnault@redhat.com>
X-ClientProxiedBy: TL2P290CA0023.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::12) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS0PR12MB8561:EE_
X-MS-Office365-Filtering-Correlation-Id: dad81fbd-74c1-4dee-9ed0-08dde4655d20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?74Ii/AA6fZy37U217etJLfSyDBnpID8UA1xMFSaHriPTX/8kzFNctxi56i8p?=
 =?us-ascii?Q?gsWCkPAj4jS4VrlP3w3/NLmovQBaPXHhzl3avfHS5xGKYayRPCmmdS8AfzmP?=
 =?us-ascii?Q?UIZxasQCbz1vJNJAFfzw1lyaIw9/588BcX/JXgvca/dn32svweKYdXIttVml?=
 =?us-ascii?Q?/DJ9diUzR/9ZJNX+KqaIxaxWtrM48FnkPGzrRyVrlrlvH/VO4wCQxukpopGi?=
 =?us-ascii?Q?K1kbedUd+AVUGVh5SXuUtYElPc9vaeyDzcIVBK1DrCOogFH8MTRoeWrWrC+C?=
 =?us-ascii?Q?zioalOMxUXJHdmnIHQauUOSISfPQnNUnkUFPAcU0g9l/XbbZFLnasNaMZeOp?=
 =?us-ascii?Q?HFTYA/kxGl/S+nXKgpf/pc199mZ8Rm4K7jR4SyFpwcwzknqYlx/Vd3x9YfBf?=
 =?us-ascii?Q?0Tskuf+JzbX7dwwtHVPlzCMoBYJFZAN88QYyiGEpbF0o1+ZajAt3Cd11jvWU?=
 =?us-ascii?Q?fIhYyMJDhKVGYU+unkAJ0ABQbKe9gUSfdMm3KKhtdp0tQsa0UjcMXj2XuI02?=
 =?us-ascii?Q?VDs675acvjI57yjKrSd07iam0DKtKYTnvcSgSOD++trlAobNvMwZnb1rjx3U?=
 =?us-ascii?Q?W1dBd7Q0CJBSKMUTf2MLcct8fF6HGOPjheu6+LK6cN2NSkJFcvLB3h2ro2WX?=
 =?us-ascii?Q?i96j85gegSGJY0qohcbrnH8o8gkxTgTZDFDk4QdLr2ZPjmMyfYqr/Lc5in5l?=
 =?us-ascii?Q?5R9OmYNSmTFnH+k35ygYwMHXzSbVrTRakdbeaxtr4kDbLs79PWaLxivsFnBj?=
 =?us-ascii?Q?3+/IYPq1/KycZ+/XemF/NXXWxNC5auzv62JYysP+mxsAmZX6G+k3ZqV3ekgF?=
 =?us-ascii?Q?kcDp5VCXjhwYEI83UNREkWDrObABZIiIrPp6Vo4AlLcQlxnLRwpXDekB97Qx?=
 =?us-ascii?Q?Vw6pMCaNjKWPIw5p8pXS67+iYdN3Pq++2oOE/071SzP4gGG9Xe5AnaYP3C+Z?=
 =?us-ascii?Q?e1bMCyvJa19Vqk/CQ8EZmfr1+HNMfzlbqBxUoUpGCeYcWl5K7RPbMRqsfEu5?=
 =?us-ascii?Q?2tKIOwesFn5rimp/TusAh744QpD1kmsKwYTCAsIsfYPDnvZsut3p9RjyZBlB?=
 =?us-ascii?Q?FS+pv1SOSMn5b2meYNTj8ljAzl9LcW9rDPWPE3xfzamJzmYvlHEnTrdrCr8l?=
 =?us-ascii?Q?HfpLYkGkay8bxN2mAQEQRxqUomwkk4iR8HZI4Y/469qCE5TyDKnzVfJVeXH9?=
 =?us-ascii?Q?GG7o9+QJg/dhV/2nwx7YXRrs8UaIvzY9ZaJA9m6lQsoceNW4QMf8aOEB/r06?=
 =?us-ascii?Q?VevoL7BsqmcvJnPt3b+PvbqlQlS27XVNSUzzTEL7NdiQxAMeiKCO7jsPPUUn?=
 =?us-ascii?Q?e0FvD/VSi0M+TRnlMbVfbfxn856j24thGuoatsFKbOLH/aZy5fttoDb2a09+?=
 =?us-ascii?Q?5rlMub8WZA3d7BXU2lY0f3IEpVF3i9rBZDndWWtbCeYjgRcQvw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PtM6lwibWdIwZ9eg62O5Gu/dL0xC4HvcXv0COCoEsAdV3vbIl6c4D2CnAMbS?=
 =?us-ascii?Q?lNVGVs7dMgKeL2reSL72c3OVu4Pg5z+qVnbRDLlqyx3cfD7D8U6sUv8QVM74?=
 =?us-ascii?Q?1w4itU6aEVn318+pUmt5x/QdrRUkaVeycK7wrpMo4veLNqI72liFTpK+EQXh?=
 =?us-ascii?Q?udm+7Tdjt7nbF30B4k9jRZUKOWuJfJIxFMax1AVJYzskdnM1HKvDGSZYBJf3?=
 =?us-ascii?Q?N+Tgqg9OrTI50QQ2jEnHNku4csmtB8H9PfaCeRtBDrQcuNViIt/RxZqqw4Zs?=
 =?us-ascii?Q?k2K+i490j8D4SUJEn+rVB027e/QNHvGHHKkaDMn5KJ6PkAC5L5A8xNstBKGX?=
 =?us-ascii?Q?q8xiKsItCtLkGv2CWUamt7S1llqnCEDOMi1jQ7CBmYzyBAMffXuPSczS5ihP?=
 =?us-ascii?Q?wMkjJaabDfwrm1dT4J4dSdVtI4tJH/cm/vQasCTk4J3l/T6OmgvcbWKwk2oi?=
 =?us-ascii?Q?3EA6EnygHvHyTKXLOCpe9Sr1z9eUy8to0Z9PCyyHk0Ki2PCRnha6JsHWPgyq?=
 =?us-ascii?Q?gPfs/QUXU7iSNP0/3h0msrZnL+ElNVuwfxyxxcovBiiJliFoIyYEmIzc4FFv?=
 =?us-ascii?Q?7jQnFIqMtAmwW6VxEkcR4wKSAnA1TVuYwlF5xQXRD9AYU3rb1KexGShxoqi9?=
 =?us-ascii?Q?eV3bNHwEcx5rwhB+hjdHYObcHRvfsQxwEkp6sLyMTCGqAX7wHs7qYTSlXums?=
 =?us-ascii?Q?6VFSmkrbekEO6b/w8QTr/QDKxIK5Fs3JR00PwU2mWYkAHDluBxzUEXCA+ZuB?=
 =?us-ascii?Q?0aiwMbYKw7Eszw7P4YBPHn68ie/TO/ribe1OhWz1kZyW/XEmLx49KhPZX8dk?=
 =?us-ascii?Q?1KeaTUvrR1phelMlMGEAbKuzzHx3Nu6pxcSD85OE4jEloJ1G2bj/P/UfEcGE?=
 =?us-ascii?Q?ncy0mq0HPrX18gV+aIJj8Eb040ufrV/R9Z7OPKADOJ6OOKeUdx9ma7w4w4Ic?=
 =?us-ascii?Q?UPm8sPgqTeDDR+JVQg43clXt2bfP2ra3QjoYhEWcXrK1sBJPaIhkaDky7ATl?=
 =?us-ascii?Q?IQNw223er7N6iJwKQk4U4oSG3JIoUabeaOjWAni8SzSlPyLgfFt2fURploLG?=
 =?us-ascii?Q?ArENa4wmH28NLCb21Vk2x+rewpS6lhLBLqZ7D4brUnItUXNc6Stl2iGDbSrt?=
 =?us-ascii?Q?+2tq1Ndk2VmLv4q1Sj835aAN7FzXmBgSrsEFVW294Dp001XIT8Uw/2QCL3Uq?=
 =?us-ascii?Q?JALWm1oRS6TGSJ3sry+jMoOJ7Uz3sFQJ+VLUc+S9wVvha4esvpehK09+IVx1?=
 =?us-ascii?Q?+iXG2yaxqkOxHONofCXromIRV3/rhXz+vfmG1b7170wCdUR2yHpkVmtz2UlP?=
 =?us-ascii?Q?Dg4A+9sMzkQqFydWC2oyIBCaSVydyCz5ecPoGuQJUWmMAZ/o2Z3T+rgorbmf?=
 =?us-ascii?Q?7FJuL5y6VZqbcZ0XR83LO6XSHLEWenK7+RvMFz1U+/6dch0F+CibEDxy1ud9?=
 =?us-ascii?Q?OjmdxbDjf0u7LS/kHIO5KOACRGKUktYoVuWC9UWW6qEVkUr/H19hvstkIChZ?=
 =?us-ascii?Q?nAT8ucXdALjS7BsojFoZWap8hIT5wM8hUhzeJIUOC2AJjMbpv/a9nGGvAUYQ?=
 =?us-ascii?Q?4P2e78za5wZdj4o94MKynI0GjBsSzOp8AzMkhLlJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dad81fbd-74c1-4dee-9ed0-08dde4655d20
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 05:56:56.3462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c3UdP2PPQAXlpjyiPmx4yaZYXJkQ5BIfQSLcCfEDxz/A2nviJ58yO6pCqvZU4a1q58MNhSjcoW1NaUdwMNJcgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8561

On Mon, Aug 25, 2025 at 03:37:43PM +0200, Guillaume Nault wrote:
> Convert the ->flowic_tos field of struct flowi_common from __u8 to
> dscp_t, rename it ->flowic_dscp and propagate these changes to struct
> flowi and struct flowi4.
> 
> We've had several bugs in the past where ECN bits could interfere with
> IPv4 routing, because these bits were not properly cleared when setting
> ->flowi4_tos. These bugs should be fixed now and the dscp_t type has
> been introduced to ensure that variables carrying DSCP values don't
> accidentally have any ECN bits set. Several variables and structure
> fields have been converted to dscp_t already, but the main IPv4 routing
> structure, struct flowi4, is still using a __u8. To avoid any future
> regression, this patch converts it to dscp_t.
> 
> There are many users to convert at once. Fortunately, around half of
> ->flowi4_tos users already have a dscp_t value at hand, which they
> currently convert to __u8 using inet_dscp_to_dsfield(). For all of
> these users, we just need to drop that conversion.
> 
> But, although we try to do the __u8 <-> dscp_t conversions at the
> boundaries of the network or of user space, some places still store
> TOS/DSCP variables as __u8 in core networking code. Those can hardly be
> converted either because the data structure is part of UAPI or because
> the same variable or field is also used for handling ECN in other parts
> of the code. In all of these cases where we don't have a dscp_t
> variable at hand, we need to use inet_dsfield_to_dscp() when
> interacting with ->flowi4_dscp.
> 
> Changes since v1:
>   * Fix space alignment in __bpf_redirect_neigh_v4() (Ido).
> 
> Signed-off-by: Guillaume Nault <gnault@redhat.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

