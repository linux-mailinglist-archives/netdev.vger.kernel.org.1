Return-Path: <netdev+bounces-186081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9463AA9D05C
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 20:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D618017C545
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 18:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60ACB198E75;
	Fri, 25 Apr 2025 18:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mi9lmBW6"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D923188733
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 18:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745605081; cv=fail; b=tbKdWQSUli0tN5XMku9WplDAxJaqLZK6giJVzQQ+mqCTaXX3ZLs2ZPefGZEiYWkbMX1DsqsP3yhu04S46jjEh4hb3ZpC2DUo6CYhPOBjDB7m9uwytywK9ixZEhhrnfRv/Hns9dMvdgShmpwJRESwq2B4DeCwg9nSxlU7Mk5GgVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745605081; c=relaxed/simple;
	bh=bYGe7LyMjTMHj9bAnoJqgAb3Z4HEMe8EMBCL8Nf/uqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YYB7QdDEht3wV/3elK6i3z3XeypsSq+AFbDMtnvhDF/V5OB4kusM76452mhg13hssx6Gt+ePQO6dEgCKIZW13h1sAwrjSSJp/KShojH7qT+f7sezF8bhNfh1Ernn+VOyio8kIn2uLNf+s0DClLjdR3c2XQ/JfBixtMj17v+NHyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mi9lmBW6; arc=fail smtp.client-ip=40.107.244.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y28b7S0COkaPg175YOCm1iHzs6awx6c/130tfuMXvKtFiD6nSe8cQ46m7qypq1n3iG62UDs/ZAL4f4MmRrBaSOi8Vzo3zHEw6GSP80QyY9EoasfWB/ZwJXqq7Olk/zsNLIUWEz6LMybW9K1CTCIF1ilUnS2cMt/byhVobd876bJvvgeMyeIAxh0A/YcE/v4cSBS6IlZhmF27lTVuRt4/1+a8rviTQZuYh1fXHlSUoRaGZU65tcW72L3ii2nXZDNe/IsQKbTQe7ld6NORUr0BEFYBD39F2yyk4JzO5WzfvC565I/+JEDVyyB01ZE0gs4xk5HdMGyQ8LLKpoZBfRQtKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=73JsBfCT+XiqRcpy1jStzmnNOW+k8EVslz9AtfZ7bfo=;
 b=F9YBRjpkRBusizHNPVddLIXNDD2H5keYKc8qAiQ7SEIPYTiyrdkdeorQ4odE/d4rwDOXmJKnxhjaVU1ATPIlSKb/Cbj1rgZtyXP7S4DY/UwnbTj4/makJLcLVY8Gj7CgsZmBAtEmNU+0k1OnaFHzwoOsh8YvfZQSsFpkFjTinaovqvwJxov0rURTrb9I7i9FAlV9uFhpkV+RyOo8VOEt8HDJ+qx6azKcDMVEA2anNbw0299g+PBHgyVBu0nUYe1x8L1xTS10w8CnnHU8IvsYmeVmrl+txF4Fo44rpnQoFxqdARu62UIB7QpyrQ3OeBG8mqWmZISKyp1kfMmYzk+VKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73JsBfCT+XiqRcpy1jStzmnNOW+k8EVslz9AtfZ7bfo=;
 b=mi9lmBW68z4YwXbS/wkMQ8u1m1J8yOs9uG6Xmcps0LlInQMim3AG7tZ4vps2OreltE14wypOuaYXdJ+urco17fXkqymG6fniCydOW/GISl0w99Oamz8izX3f3elPf+6uM06TWqXqB555JVggQuBx/YTKbhtXMOZIfk+VvKyOvivg3qPgSLVzwzAFHAoqTfTUXdEz6q5/iN10IuYe5fDn0xet9fw/9nfWpxtug4+dEiI8/MYzDU4kYTYmk02Z+rB7vINNxDKwL2yne4+Nw4ZV4ZAThWCG2lu8Hfmjp6ylEtAs7O4m/oyJ9IVv0IkPe6th6WW54QPI4rt+6IVoARvpzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by DM4PR12MB7526.namprd12.prod.outlook.com (2603:10b6:8:112::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 18:17:53 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3a32:fdf9:cf10:e695]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3a32:fdf9:cf10:e695%4]) with mapi id 15.20.8655.038; Fri, 25 Apr 2025
 18:17:51 +0000
Date: Fri, 25 Apr 2025 21:17:40 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Ferenc Fejes <ferenc@fejes.dev>, dsahern@gmail.com
Cc: netdev <netdev@vger.kernel.org>, kuniyu@amazon.com
Subject: Re: [question] robust netns association with fib4 lookup
Message-ID: <aAvRxOGcyaEx0_V2@shredder>
References: <c28ded3224734ca62187ed9a41f7ab39ceecb610.camel@fejes.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c28ded3224734ca62187ed9a41f7ab39ceecb610.camel@fejes.dev>
X-ClientProxiedBy: TLZP290CA0010.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::9)
 To DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|DM4PR12MB7526:EE_
X-MS-Office365-Filtering-Correlation-Id: 86db8be4-b605-4846-fed2-08dd84257db4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KYwv0miHvLH5fJCPK0si/T7RJgpRXMpTa00g8mUnfopG1HquW0wsEjDSwMe3?=
 =?us-ascii?Q?Db3j9k7j7rkpwQqbOfEj4OldUSbp5NMPC3DnRn6JTQk+VyVxkB1OdC25R6Xs?=
 =?us-ascii?Q?ilnHI6j65jwIiAH+8s1Nv6exxcS17Fmcw38nG3G5Sz73p7rMTO7TPp+0JkWK?=
 =?us-ascii?Q?rSTfdFMbAwWDU7QTJlcn1cjkum+h9558N44BE3g3b2cpSo5oe2rlUvJsgMpH?=
 =?us-ascii?Q?j3A0V8LMcWxk7jnYQByaeHG76b6qqnzZNeqmapkwRFz3SSSDbEtOYHvb1xl3?=
 =?us-ascii?Q?Dc2xgOFyKO3yX+2+nKXvk+mZ5IEfio3frE0tAIcpn15VDwnsIJejjOq7ASU7?=
 =?us-ascii?Q?bpF+ixN2yclRpvUcojx/9Bq+skXeelhvvE6VPvTxMyVro8A6IrP+jaKiAEAR?=
 =?us-ascii?Q?JsDbh0b13YexLcbJ2GDChYlb6mEjf2S/J0XyPsnntx0r3bD206tzyc1al/Ul?=
 =?us-ascii?Q?JeK55gtclwJ0zciKcvO/MQtuG3PKpb6Bqw5T5K4NuYspOOQk1rAbP84mm4DK?=
 =?us-ascii?Q?VmOypeF/5adSX8dTVVNO3C4qsvN0YlfcBWkZgYC2ZTJtUBjJsxlKWh8n/5CR?=
 =?us-ascii?Q?ivsfiMFxkdUyknj+pOau2GkoKi1D+0uNPcz59KpQylKfFn9KGdcKz/ffCp5B?=
 =?us-ascii?Q?PA50YBD3uUWPeb9qBgqj0ryU5iiNzH1BsDwpZWLI3tXHDR37Yu23QgOASs7d?=
 =?us-ascii?Q?RGUJEFlSXp+amI5YT/3h4GXrnrcQq237TptdHRdT5CENXvkaQ23kpOHL87BI?=
 =?us-ascii?Q?oUspGeid0QPTSL3/CyPCAquSBcL+yP2mULusP8+U0VnsVOhQLbZd3hv4YW7z?=
 =?us-ascii?Q?WhBy/hnbwAP1zYgs1fAvvAhnQCr8yWINeFthFKYDB3AvpCreXFA1wVvud65/?=
 =?us-ascii?Q?CXA4ALh+wSGubnNb99dWuMfts++uaxh8NoSixW3bDIkFJuLhPY+rpQ7R6Zwh?=
 =?us-ascii?Q?SSePKbfhBrMW0YgbrWHleWBGumz3lo7RPFjhc5YU2coEqYTCW5TiNNEDiPvO?=
 =?us-ascii?Q?OcSIuazQ+mJySfAfKchbfVQ9elWp3WqKmzbC70XMJDc1oFaw5PDQZoLcvITY?=
 =?us-ascii?Q?089mOboe8ompKbElERTQmuKeiB95aV/vKEY41Y3mSKf3GSF0oUiFg+p3/Xxe?=
 =?us-ascii?Q?dWHojEgQ2ee86Tge4sQqWGQlhypoL5hyndL8layKhiR+ZLZOkmof8m1b9T5L?=
 =?us-ascii?Q?b2YcfgdnQc6VHC2Nc4yqUdDQ1tDBjfe4RNo+oqheVGkZ8jTsrkbmcE514J+4?=
 =?us-ascii?Q?/ze+VSgcytSMHeJXpOnFHlhAui0uYC9Mj35XeYOWmZNdt7gvi3yOU5dlTEPK?=
 =?us-ascii?Q?R0jX9okZNPcbP76CNSiNsIIsEQV6bnEURpyL8ZNQkQmL5Sg72pPyf4KB5V5X?=
 =?us-ascii?Q?yV4nWwH/WTssZCDFCHM8iMK7eszNnOB1zOnT7+6L+Sv11ocAq/mDtbGsQDnW?=
 =?us-ascii?Q?xLaZf6ggz0U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1hMj4BO5KLEyACoteOI/J7LYSlMInGWh5I01YreVKAY3r8MbF+jcZ9PbxIqc?=
 =?us-ascii?Q?KrUcO0Iy1FThDXyhrr3T9nL6p0I5Hq1A6kfHTJKXZA+Bgd1WB2CiqoLiU5Y6?=
 =?us-ascii?Q?uNNZpY0AoCwEX5PsdH1CJHZQo5MydH+ZDkVgsD6DII5cgM8vTzkoswCG892F?=
 =?us-ascii?Q?pgU5PX6Fb/j49yf1fSNR5snaBK+/JuRRoTxClJ1qGUKBqsTmume5dxD65Zi+?=
 =?us-ascii?Q?N9btfzWOSJYhnSlxPHomBBDJj91FX8pwh5A0yvQZxS/cJZFXB11zIb1DAsZq?=
 =?us-ascii?Q?Is2kQMyg75l094oDvb3WvSdS/Gi8QEFCZp+E6gRqJ/TLA81dD/clCUuyNF1Y?=
 =?us-ascii?Q?iFQBGjT9AzBEewauWNfhC7XcF7WY47qrceN9GO8GJG4mceERkVUWVMgNR4An?=
 =?us-ascii?Q?SRS/vm/RcDiFep3GNuTUy7X+8SNPYgR699xd8U7KzrkGaK7jDMXiJJZaIvbV?=
 =?us-ascii?Q?0tDknBa+cvAKst9394LMgqy7MyEeo7j4dEoXWAk4MQrvERnqCTvDtN9tvHdU?=
 =?us-ascii?Q?3yLOpechoT2EXaHOHcg2OUNioQ1ep90D9rgrsKJOtNVDnLxiM02xzx0JOdpi?=
 =?us-ascii?Q?FZbb/FcgjW4WJKzR5WJ5Z7jsIk2OShLRBNsGSuM2xgfgBfeeEUGEO7HD0JS5?=
 =?us-ascii?Q?V8F6fzuKj0T4kiUiY3kAtCi5nFPszdYHz6s13N2f8ddiEdWvq7ajm+cgahgV?=
 =?us-ascii?Q?b74JAjbQNdn5yEGnkaM7jcIQEMaHoFRYrGaSQMcBgBPFwDy6r5AlWNy1xzWY?=
 =?us-ascii?Q?RNt6j3S7dxc2M+SKpFOlyrjNXGpQDOqw9vlX+51UCRy/sl/xQp4cLyBdCzOj?=
 =?us-ascii?Q?ifvNleCtfNyHjawSpPfI5wnW+Z3x9D0bl39LNLUWRfM3kMrtvxd2oiQ4bOvm?=
 =?us-ascii?Q?b7ZCz8D2mU5KrZQMntvA50D50Fx796uMPDhtNZVW4209Ka20/X/TxW3Gx7cV?=
 =?us-ascii?Q?uz8r5IqazVYH5mbWOXmuoSgddny04YpdnmAd9AeAuEx3FP0WZrSOWgk3XkVm?=
 =?us-ascii?Q?xk8Y0Iyjxs9Rb4q++9mZFFGT5rBMmNB4tiCncObAEi/5SB8fnQUehnTJFeIL?=
 =?us-ascii?Q?E9KwajseMSUH61PCs+R3ImcFFNLz7P1TK/1fukhuRVt7fj41V3C0XtqPqOX3?=
 =?us-ascii?Q?Ul7C1OOt5vKksM9EE6eb6wZX/x7dzKfMmRuiXDVoWJTA6q8n4wzIQM7sqMq9?=
 =?us-ascii?Q?J5ewdHFVyTC0v5b22t0YEKvtfxAm3WhbxQcPoWGOhqL5A97mmN6p0rvIBuLm?=
 =?us-ascii?Q?j5ecYTCHSplVi5EjGr8zeyKzP3e+4WORVnX3wYK+1OgWYaGvaJzQSeOrojcN?=
 =?us-ascii?Q?aXnEzR5STB/N3yXmCFIExNgmhb9GitvvAVOwzN6OxMG2WilN6c0WT3t///x9?=
 =?us-ascii?Q?pwP1y1EFh6cZxOX94H9FzBJBrjHGr/6/3DDuadV8JmqU8/9yKWjEeWN6lsTl?=
 =?us-ascii?Q?Zl/CiYVZQHeWHrVVscy4IMH2zG7+iCKe1515pEZ9nNQYFNgDanXJo6x3a9SF?=
 =?us-ascii?Q?gP99670x/b0ZQZ9rsRDv13vY0uASbLsp9Hz1bZkAGF7le9obul61+68oUgFF?=
 =?us-ascii?Q?nBxDX7HPqipJ4Li5iabMIxXfTBe1an2vQy7AhLXT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86db8be4-b605-4846-fed2-08dd84257db4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 18:17:51.8678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 832JCkQPpLC7bVH058yZmggxOncUE5vPoJqNmYacaS7nwhb+q5Z3xsyQx0vtUnGnbapGZgq1sOk/U1euNipvmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7526

On Thu, Apr 24, 2025 at 01:33:08PM +0200, Ferenc Fejes wrote:
> Hi,
> 
> tl;dr: I want to trace fib4 lookups within a network namespace with eBPF.   This
> works well with fib6, as the struct net ptr passed as an argument to
> fib6_table_lookup [0], so I can read the inode from it and pass it to userspace.
> 
> 
> Additional context. I'm working on a fib table and fib rule lookup tracer
> application that hooks fib_table_lookup/fib6_table_lookup and fib_rules_lookup
> with fexit eBPF probes and gathers useful data from the struct flowi4 and flowi6
> used for the lookup as well as the resulting nexthop (gw, seg6, mpls tunnel) if
> the lookup is successful. If this works, my plan is to extend it to neighbour,
> fdb and mdb lookups.
> 
> Tracepoints exist for fib lookups v4 [1] and v6 [2] but in my tracer I would
> like to have netns filtering. For example: "check unsuccessful fib4 rule and
> table lookups in netns foo". Unfortunately I can't find a reliable way to
> associate netns info with fib4 lookups. The main problems are as follows.
> 
> Unlike fib6_table_lookup for v6, fib_table_lookup for v4 does not have a struct
> net argument. This makes sense, as struct net is not needed there. But without
> it, the netns association is not as easy as in the v6 case.
> 
> On the other hand, fib_lookup [3], which in most cases calls fib_table_lookup,
> has a struct net parameter. Even better, there is the struct fib_result ptr
> returned by fib_table_lookup. This would be the perfect candidate to hook into,
> but unfortunately it is an inline function.
> 
> If there are custom fib rules in the netns, __fib_lookup [4] is called, which is
> hookable. This has all the necessary info like netns, table and result. To use
> this I have to add the custom rule to the traced netns and remove it
> immediately. This will enforce the __fib_lookup codepath. But I feel that at
> some point this bug(?) will be fixed and the kernel will notice the absence of
> custom rules and switch back to the original codepath.
> 
> But this option is useless for tracing unsuccessful lookups. The stack looks
> like this:
> __fib_lookup                    <-- netns info available
>   fib_rules_lookup              <-- losing netns info... :-(
>     fib4_rule_action            <-- unsuccessful result available
>       fib_table_lookup          <-- source of unsuccessful result
> 
> My current workaround is to restore the netns info using the struct flowi4
> pointer. When we have the stack above, I use an eBPF hashmap and use the flowi4
> pointer as the key and netns as the value. Then in the fib_table_lookup I look
> up the netns id based on the value of the flowi4 pointer. Since this is the
> common case, it works, but looks like fib_table_lookup is called from other
> places as well (even its rare).
> 
> Is there any other way to get the netns info for fib4 lookups? If not, would it
> be worth an RFC to pass the struct net argument to fib_table_lookup as well, as
> is currently done in fib6_table_lookup?

I think it makes sense to make both tracepoints similar and pass the net
argument to trace_fib_table_lookup()

> Unfortunately this includes some callers to fib_table_lookup. The
> netns id would also be presented in the existing tracepoints ([1] and
> [2]). Thanks in advance for any suggestion.

By "netns id" you mean the netns cookie? It seems that some TCP trace
events already expose it (see include/trace/events/tcp.h). It would be
nice to finally have "perf" filter these FIB events based on netns.

David, any objections?

> 
> Best,
> Ferenc
> 
> 
> [0] https://elixir.bootlin.com/linux/v6.15-rc3/source/net/ipv6/route.c#L2221
> [1] https://elixir.bootlin.com/linux/v6.15-rc3/source/include/trace/events/fib.h
> [2] https://elixir.bootlin.com/linux/v6.14/source/include/trace/events/fib6.h
> [3] https://elixir.bootlin.com/linux/v6.15-rc3/source/include/net/ip_fib.h#L374

