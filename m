Return-Path: <netdev+bounces-137863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE839AA23A
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 14:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FF79B2217A
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 12:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D00019D080;
	Tue, 22 Oct 2024 12:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DssaWrqv"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD62745945
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 12:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729600692; cv=fail; b=saDXzbTM8xNFp4jL3LBE0Gm6qtgZk0f3J3MGIicDgU0CElOdiWjw+daw2UvDWXaif73FzhAe4pzvllQLlD5eHy4Fmp0LN+uhEujeo6nBZtxPUA68NKxzr2KBsZv+IQUYOhLSg1fi1XF3D7c0JALbvPKUVA91lTP8aQY9xu55QgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729600692; c=relaxed/simple;
	bh=xoyyHXyq/3EWaOJqJqSMxoymZ2cAuTW1kt+uwnvAttE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EbEg5YiBIid51t8CJ/SOMyd1Icw86XSbJeqjlNVw3+Z4pQLBb486gCgvX5zlQZynOKaCgNK4tgCcWbHBaW6VYrLEx+fEBBPB+mxOr3l0U9ZCOp4IZEfaAklBopeg4rzVgI+9XoJjxgaQx8FEFycP2ned2WXAHWSh3Wl5KxofH74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DssaWrqv; arc=fail smtp.client-ip=40.107.243.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VA7OQ3xvIul6rXDRDULa8OPwr43QibwFZTot2wQe+B97r8Qe8Q+sBAVDN9lVw0cEjc+YGDSUNXSlJjBpCXE1iMAYHWYHOc8DUQs2kAQmPBwx6fa7M5BW0y9Cef8qw42g4kgRHGEU3AEcjnY8N13xirvkrJ30el1F3U0tmlvmDdFDNbb+sFfLnTmijvNecUiALRzyKj3p+800FCIFWd74paD9kKJgJfTio8kIzJ88q42amJDXkFms/y17lfwvewMLGS8DQpWt7NOJ5BCaGgrRFr45oEx89mWN16n5MiJjMLOFfvmgEtHpogr+ja1aN46Fk7+OqCUMWUNjQUfKmHwbDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gs1BzPe64vkJ0Z3/U0lKPKEJzrIR1uYdIsfoYSM2OCw=;
 b=usUfmYiEUMRWBMqZw1shwPBiXF/W1QVW+Ob/JecCJ50Ji7izcHDWdX7yD8sFGWMiWq1lMYDku3qyyUJKEXsYMd7NAbIZuVwFEY5B9x2tCLls8n+fbziBhaGWJvkhHJiDjecVP6daHjz6hnKPFQSfVyB8Wprxufc99WP55d0dLUvQGbBvE62jeuq46k/6m8JA3+upODD6bclo9ZQDTIOcnowiLLGgLLNoJSpp+YVO4UfZ2H/QC+aHj/H3vhyHy2K192WkJEH9rZX+iJfDdwgpirKzNi54lVgNifoIeeIkU7qO3W8XPsr4A+pKOKRmj8VCIYYAN83EGL94HogjeDh4CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gs1BzPe64vkJ0Z3/U0lKPKEJzrIR1uYdIsfoYSM2OCw=;
 b=DssaWrqvSvsqiEPh/SkvH3kNV0HfaC0+sKXa+onJK8V4LErYac6vanwrgTIaYYV7ljS6pUWXeMl0DkR4gR4V4aQ6tN55K5fHjsmS2FvFaqPUmqN/IQxVCvUfIIQK+LlMu6XlQ+QuTBsL2KeVtFGyZB8vNcI5nQq+2PlG1uQxdwuqFWmZPdyq0vSWhG4gU+QabJYKXCPBidkfIqUub5eHPI8GpwolcFB9f2nPnc5y4s/7sjSg9ocNgSnDlLzaw4FRYkYyyDSz3+1GToWS+rI1mM4nX9xfWYfJW9q6t4dzcAhpF9ycQ/cR+kPnWyOz9O6VFFrxqqla6ZhQkIEiD1Qu3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by BY5PR12MB4065.namprd12.prod.outlook.com (2603:10b6:a03:202::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Tue, 22 Oct
 2024 12:38:07 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%3]) with mapi id 15.20.8093.014; Tue, 22 Oct 2024
 12:38:07 +0000
Date: Tue, 22 Oct 2024 15:37:57 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH net-next 4/4] ipv4: Prepare ip_rt_get_source() to future
 .flowi4_tos conversion.
Message-ID: <ZxecpTV0c7T7tITi@shredder.mtl.com>
References: <cover.1729530028.git.gnault@redhat.com>
 <0a13a200f31809841975e38633914af1061e0c04.1729530028.git.gnault@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a13a200f31809841975e38633914af1061e0c04.1729530028.git.gnault@redhat.com>
X-ClientProxiedBy: LO4P123CA0220.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::9) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|BY5PR12MB4065:EE_
X-MS-Office365-Filtering-Correlation-Id: f944f456-efb6-4ddf-8a39-08dcf296616f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/c7oSBesVWYHJaEOnXQmopHdvwsEfiK6HzKbrOu8SoOXB9NSJeu+skFXYg72?=
 =?us-ascii?Q?Mt5cFl9+MJBt9ZI+qhWVDxe0GDigaxX3fEU65yxJm+SfIWXUouyAbOk0OYEp?=
 =?us-ascii?Q?049edDbkznGVyS2bWyUlCw6WoGuR5sG2TBf8m+Og8znNnlFKpjhQiknnW+no?=
 =?us-ascii?Q?86ff3xz15M+qz1+q2O5qSrQaeW9Sfw9OD97gSGP0uQIkBJsdScYBglaFmyig?=
 =?us-ascii?Q?NcE9MKw4NE9WBp254HtpNP/9D5FMrlUWlLDzQc0VSDBEso4KVB5lfNPl3jf+?=
 =?us-ascii?Q?J2LqC9MmKAEu+aviQn3jimNaK8bQF5NcM6HDk0iN42rM6JHfx27UgmHmBP1u?=
 =?us-ascii?Q?IWBUXDc2hr1XIMzU7D4rapZAarALfa9R2B2XxIfArAyNBndA1Zau6jD2B8QF?=
 =?us-ascii?Q?fJs89UWQSDR4psI0d1sb5ttuLTz3Gsa/5IwNroIZxfRMnfeOeH/JlazOC31D?=
 =?us-ascii?Q?vvOAvrfKOIUeJg9soWkzPYZqaVavDQ4ZQfCdPAebFsVSiyr2Gt8hxJiRSC3q?=
 =?us-ascii?Q?Pg7sKIhBOJpi40elvvqBq7KFukZ5FhxOQq9nT9JuN336BNeCBG+PDmaj4G1A?=
 =?us-ascii?Q?BuebuBa6NJk0p9tVDdE05Osv43u+yTdHSZ9kSZ+KOe31HwDkWFOq6AYIW4VK?=
 =?us-ascii?Q?0u2SlGB++qoHfB7B0ycfQZNS4gVbg+L+eOY9pbEZ5+3dygzL8zkM61c0ItKZ?=
 =?us-ascii?Q?aURnQhS7McNZ0M2QsuPBmhL9DUpXfHdBWrebSpSmnILSsCLZvqFSUhrDmsR1?=
 =?us-ascii?Q?ufwG+lLI4u5YmT2KJBH8uczztTLPGbyQ9ptE8KRv5IZHTSt0sb7hlDJL0ITy?=
 =?us-ascii?Q?5aIFbRTytymqzDD/Cle5sPNwbW3eJY5IjKXWBs8yMoRwAjBIXWnTRevOH8LY?=
 =?us-ascii?Q?PsgrVKx24+G1L1F53KmNw8hf/2pQCvZFvU+Tr+1/CLNxP3dCmflQSKqubYUp?=
 =?us-ascii?Q?dgJanEH5g/RTEPD4q/A+p+N4R4jsP3h8wf5dFnluNgS5HGmlKYiso6zsZ3uY?=
 =?us-ascii?Q?5HRJf7rz4Rt3Vpat2VGm0dEaw3JtfxEXPxkIFP8/D8zlLyTsOu2WafwTUvHa?=
 =?us-ascii?Q?VpDivAwHlAnmI7hsXaXGRWY+Idfrg2Efse89spmfvJQQeUjVX9k6WVDEzECK?=
 =?us-ascii?Q?bNp5adc1tH4TLgVH2pnSee7uGWDsHtfFZipOw7NHqBBr/c1t3yhG6nqWsXjA?=
 =?us-ascii?Q?sSYOTHcj+Dek1BxGm9jjWk/ncyzDXPvJaoVZUoln33OdN/GwvUceQGyL5BTw?=
 =?us-ascii?Q?ZY5PWhrSzL2Qs+rK6tuA8EnXAZdUbRp7UIHZMAoKdkztf2hRQoGoAOmmectq?=
 =?us-ascii?Q?O/lnZsbu7QozCJlFPHYpFCEv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jbyny0v0pwi2Dm2i5IamjJ1HeTMG95sRKTxY+XfRijL+QO8RmJbLje/LB3Bp?=
 =?us-ascii?Q?F6/WDgtVpZIvLWNYOEDbXbWWqAdfmIAscwy2YePgVcDz3pfnSz4oi1fxJniO?=
 =?us-ascii?Q?bpK9Jd+lSfZeN9JuE3jaFuM6/6QMe524ZU3gPLStZgdSaE80iJQ0uMs9ozrx?=
 =?us-ascii?Q?wPEc25pDdbEr8l27bYrLempQikYUtjONyzWfQX5T/RCAL9CSJafC1VyUC1cq?=
 =?us-ascii?Q?I49MIBzJ2IMp70u8KL4rR5XkPZF98GVJUklukh2zuP8Omnbq1oMMZ3kwxwTf?=
 =?us-ascii?Q?Tmc3tV7Ad8RA/5EFfUysA4NqFDrePQgRdAt2JzfO9qOSBuafnAQq0Fv5K718?=
 =?us-ascii?Q?6f9Yda43f2TYId6elA6vwJldWid+JvCc8btQ4QES5SvxBMT4s3I9aXQagpvH?=
 =?us-ascii?Q?wBVnsCPLUzoK0XB6eDFQPn1FUOS8DZ+aAoE1uF0aPsaAMwx9ZQaK+5WbYjpv?=
 =?us-ascii?Q?nTXxQ7rTXRLorVSi+IyIVhCqw8dDraL6QnO9Gl7E4lkdrIqCy+cW6ed0DRlu?=
 =?us-ascii?Q?ywWhAN1hKKCe0uIbJcfLqhWHS55qAsoz8DaZs/GmhyZ+dKJVfZ3JBDeV+H17?=
 =?us-ascii?Q?mKH0yOrwqrRPAymi/pULWdCAVnVZLd3FDIrXUQTIJnOInQwRgT2Kk/deFYDF?=
 =?us-ascii?Q?7A0sZR8Lp1kmrukykGOsaSkCv4mFROqxAxg3h0zLd4uEvKgcHOyQ90my5/4e?=
 =?us-ascii?Q?XFbrEBUmEqsgc8KcRQWCy/EBFipQq5uXEUB/DtMyMfDjBqXLInrlR0ltX/dq?=
 =?us-ascii?Q?R53QPYo0EsQk+hl00mhZ2B8Ku5ayPDWaOScQcawYGvlfyNFIBOoA9LIOLNxn?=
 =?us-ascii?Q?vL2QG+hUAof45dgoQIEM+5QyhThOENXvAfv0XifNNOvNc+uS4vBITmj14di/?=
 =?us-ascii?Q?ZzjzcoU8aWc63AlE+O4BunhH03fiS0klsWJQq/sZKZa0tiLMZ4Uhg3ap/2D3?=
 =?us-ascii?Q?agTNJ1mzJduxhOUiQwPnziCcXTkXn+OZVm/DciPP+O8GRh98LwCt7cwj8oeP?=
 =?us-ascii?Q?29HBYKeXa7Hksn6A30hiLxXu/URbYAEstnZO1SH9zVgMvFNRRqM90BRVz+XH?=
 =?us-ascii?Q?oQdMd0poyBp+8NLpynp/EJzjirAiZRtc6zJyvUnWkdj9sF6w7c+W0c1i6e2P?=
 =?us-ascii?Q?14uFTAM6VTB40OavKBB1WRW0/bUlkMUuFhOnxR2ZR33Ch9mT0jBDr/O7rcX+?=
 =?us-ascii?Q?efs5Y7CKJ9VI6C7cRr3dsE4ejhN9R+3ccE+9no8+f/klaw9sYce6EzP8Jqby?=
 =?us-ascii?Q?xBoD0lvUV3eCKO9kjtBQWzhMcv4V9B73OeHWKLA1KkYtE4dnrFBECG92YRAT?=
 =?us-ascii?Q?MJqbPl77vXlxlYSHzxBnLMJ27wSxPlm4tOKaGSrx9zslJLGKe/6OIN6q25wE?=
 =?us-ascii?Q?JlBCw3ugANoTSSuLzlvkNy1ntG+buC4JcnsNvo3umAvf4LfZ2AWrmOmlSL8y?=
 =?us-ascii?Q?/pZUNFiZ3p6hBszaV56SzVMi0kCuFu4DA5RxW6EvrJwF0j5IqsXB01H4Aq/a?=
 =?us-ascii?Q?19xhAMh5JVaIA7gr/TkhFAIVKditDR0nPs0lzIqXueFWyFrHM+BlQCQf898F?=
 =?us-ascii?Q?2I8+BA3ObftSUk35LCkcCUYktcQ1yZYOk6jXiwIB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f944f456-efb6-4ddf-8a39-08dcf296616f
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 12:38:07.4376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k4Y79S3Xq4ZFrGGNoEjfDK7XLM7xC8bo36hpgQJoLbmvc4YouZI0V7Rv+iH0gcPkeurFkZvWy2u9wppj8OukDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4065

On Tue, Oct 22, 2024 at 11:48:23AM +0200, Guillaume Nault wrote:
> Use ip4h_dscp() to get the DSCP from the IPv4 header, then convert the
> dscp_t value to __u8 with inet_dscp_to_dsfield().
> 
> Then, when we'll convert .flowi4_tos to dscp_t, we'll just have to drop
> the inet_dscp_to_dsfield() call.
> 
> Signed-off-by: Guillaume Nault <gnault@redhat.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

