Return-Path: <netdev+bounces-263687-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKFvClL5p2mtmwAAu9opvQ
	(envelope-from <netdev+bounces-263687-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 10:20:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 928BF1FD7A8
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 10:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A8D0830C30EA
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 09:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF23B39182D;
	Wed,  4 Mar 2026 09:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gepErHvZ"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011061.outbound.protection.outlook.com [52.101.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C26E37E30F;
	Wed,  4 Mar 2026 09:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772615804; cv=fail; b=DH45EoUgBNDjBEhYe4viOzR18mBT8DzrZXzlL3hUAnUEN/XJQdVqx79aY0A1Zlikytij5vgm5zoBBdBRW1OSh5fXAoWR20tA3/AIMFE2xUTynAUfVBqssqAYPHp5N3PwaAMFmjEQdRnTuEFj8ruR2s4ab5IQaRCnwbVW+xd5Hxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772615804; c=relaxed/simple;
	bh=pRW97H8+MS6ohsnATXtQXaXCYMEKMl9AyvzDvcbF9Lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JqVeU+XVcytHlnvav0L/017h6x2ADR5ckkUP8XXUTdgsS2Za5e0uZLqQCUS2EBtVWJEsmo4luVJlkigWaYRhTmMiKPK8GFQ2P951bsngKL9VHtO+xRuBn3GeP4CGKEQk2U8dYKP1MfwXbnGqfzFuNRx9AvOpPK11O1aaKnNXfgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gepErHvZ; arc=fail smtp.client-ip=52.101.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SRZpUF9Ba3d06+Ht4eq3i6YbWIJ7O8nDbfL+b4EWc3wLDBgsq8iYejy9k//aIVkhZ8fE0SPCwH8U6kElr03jfoW1D3uOuJH2vQlzzpJxSEPp22elOqAgolJlhSGiXlbrNKjg36ICX/yg/uHJGFEGuzP2WwQyfWOWBgJUI1tAGPMdYGniwegqbzPe74rGqk+8iuaUfN8QIKynxALmupcAvVU1/A47nEv8Wd8D1JTeNfZCOgV4tq9J2cxpo6aI3aJipewrUX+8xfxr/Na2gRsPS/356/3cvnDoLEUS6e1Izm94AYPQqrb4PGgIMuQencmLYNqyIffTdYIBVq7yMaNxNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0IFaYjdFsiaHebJKVJsA3o2ChyEDVnpRm5LRTx5kPY=;
 b=ERkhU4d8SWipRtwsUQz/o4BS59Z8wcOjv5eP+MmDjyP4vzmipS3FzsPkjouVYmiYi5fgfw/eZ5EIFezWMWBM0vQYyp6D759d6wo0IlkqgB4pv700/i+fabVvQbLEZ2IP6lFVhOzBYn2bOmEcpVZPOzjwBKkk8t5wCxKo4uisXDWf6U0eqrexXfKk1wS7CL0SUURMpmAyYczZtNMJyDM2Waq2W5Gxu8TdAeKlr8Z2NZ2ZKxMMzvo/g9UydVbyhyvytJRgtwUEfxU61IpVSdTCYg9kob0uwLVCOSG+F97YwjJmZ+ZpycGJEwrmHBakqThn5gbJIX9MEp5N2P/C93fEtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0IFaYjdFsiaHebJKVJsA3o2ChyEDVnpRm5LRTx5kPY=;
 b=gepErHvZFOFzWCQRtI2ESzz4F8JEjNo0ewQBlKN/4fkqlIrXvZe5/H74sWOm07aouipXkxFXDSFGHenfl1hDCmsK12yllxUr7gQCFN+wnimsXq1Y7dBD/RnMezio2JGglO7cglWHz6cInPjpNik3+ljT+6xCDM4GvfwhXT6HGc7mW2hH1YLstOK6kx/G2A9uEZRruFqmny40gmdwcJPmQnH0GQDw2pQhLJuRut82P2NXPuMYmqQSZnu8qXt5UvI+c9YPBs8rfouKmt8oSm76xXYevjayz0U+ZoYiBngNpmQ2+Qs2gEMbNsbmA1WA+K6XA4F2fg/DynYvQz5lDkxgGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by SJ5PPFFA661D690.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9ab) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 09:16:39 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%5]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 09:16:39 +0000
Date: Wed, 4 Mar 2026 11:16:30 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, jiayuna.chen@linux.dev, jiayuna.chen@shopee.com,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	syzbot+334190e097a98a1b81bb@syzkaller.appspotmail.com,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v3 1/2] net: ipv6: fix panic when IPv4 route
 references loopback IPv6 nexthop
Message-ID: <20260304091630.GA1054438@shredder>
References: <20260303031318.339716-1-jiayuan.chen@linux.dev>
 <20260303031318.339716-2-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303031318.339716-2-jiayuan.chen@linux.dev>
X-ClientProxiedBy: TL2P290CA0010.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::8)
 To DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|SJ5PPFFA661D690:EE_
X-MS-Office365-Filtering-Correlation-Id: df46179f-04e1-4fc6-ab58-08de79cebe10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	xPcjYtdlO4OGR7q3QZt5O3xVSzyvMfWFvJMxOq7YyFf8qHYTlvM3PJlN0s9BnXZrK2ZlbQFdwXvILZ2bH0rBa69h3jIjnoIfXaWo/+IiuveQb1nWaUROKURrMl+Kdeg7JlfssewDwAeAQcsemyHRPjuXFtzjbK0OdpUyDUGVy2xvuclTINN4+S82apblzK1xlOIecK3dmb+HUMJ/CNaZ6+3U+L5gEgRWWGdhBWNb9e+bDf3oTTAhyqqGCUzSMQHjpZQP+emp1ROtKcz0rvrbgsf+v+gWaPDGibsWm9WaGFO1JRfpSEJ4RIU7NYv3faFSGODtU1KRbYfgMmCoWY9cJl6ZPwBU6GP2XlItxascN6Z+6jgwGmRhElqW3Gnp+llz/VzhlvwQm2McawAr6IB4wWMBvLefMJUB9fJuvjIugMuN70R36iTlK7V2btEjz6g5RrLaog2J2dFxsCnOhb7Nr73DTm1E+wx2TcpUw9NGZKWvmK7pHALGMe04AwTBYQ2y43MnGj/6BanKyPQxW/xIu+d92vQRXvWP4QrkZWowuVkh+XqQyyGIC2VyHSjQaK+tPRiDob1VRRTW0cYzXc/WeKFmI1P4kdStD5xpuy5kFnvNL65GR1jMrsgdMShwqNYz3unlmdKqeOISG3VRB+EOYe/c+CwqOq+YaLpSLuzEC7iGJvbEYuCfuHVHGCyFAs7ONvukcHVlNgrYVWVHT3rxRyl2n4BAAVgw/AUo7NiODwE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?enEVN6TSRRERM/amPlBkwXwOJ0te6QN7gShgxObwFBShg/6AklfgfGGZ4lbD?=
 =?us-ascii?Q?Xo5SK+pMzdLVefKnqs4zVFDxq+Ku58Y/QfoEdNi143+LW0YW7zdgDwc7bBAK?=
 =?us-ascii?Q?HZvxtTA1rSagEQx2/4BLyPO0FG8//4KbBbXA0iO2LRkYnMxpVqjGpI3fWOL9?=
 =?us-ascii?Q?0gde+i1k3sEwg3ECLSQnDS+XBVgez4cpSzQXPBe718Lxk8xmhRS8CzVFoDjR?=
 =?us-ascii?Q?HNKdPfizpiPBmWnOrPwCjrxB7ShpoyX3Z5fQIprEwUQEJXgehR4pXAdaQasu?=
 =?us-ascii?Q?fLqnf30Ayn0l5ruXPvFDyQVMdPuJCbCwuuHKi07GtCxaxYDRCLJ+SEMgbteu?=
 =?us-ascii?Q?E7PZ58XGcoXiXD8nUzdo4JuIRaD6MtFlxIrw2A8AVUWuu8DEEKyvb9C2qw/6?=
 =?us-ascii?Q?UVYB344cPQeMNh+SIER9zm7BBrfQOUwjMRWhMVjp6AtQlm2aE3U3dSN6l/Ff?=
 =?us-ascii?Q?9Y/iGZd/kyYPMYeufLj6HnP7v0NPROuDk52aNYH6BrL9eo0P4c++1mkTUyvc?=
 =?us-ascii?Q?ydjL1pmTFxVLFbju7MOP2o3Ju6G6sz/apfSIX46UFJ3Vy+1SogVscNGd+H7S?=
 =?us-ascii?Q?l2svWpEz96M/UFsyCB+Hsf+r/jiKnKgjne115UL7gzRsqV4qV0Mx5kYXxo6y?=
 =?us-ascii?Q?m1iXO91qjSP2Eldwr8eFUftKWbE82Z4LPsCfV/h6H+ptPvl4X3jNbliP5nsl?=
 =?us-ascii?Q?I9lmSLwO7d4rIAHSW3T7FCc1kuKCD8Plhg2wf779we8yOVZZfKko/bBLgClN?=
 =?us-ascii?Q?fHinWTuHAu6ChofHb90sV31Q5Q7CugnWGVlhQxC1mRy+TZKom9DbCBGKvFKV?=
 =?us-ascii?Q?xB6lPHTcTIK6mlr050H1JUqonCR66V/mLOiXAi8acLDDuCQAge4BCVZ1ZjI2?=
 =?us-ascii?Q?DraVS3lDEZnkf1qwB5LOSNdRRpx+oV/uPrawHnkGQNuGtxRy8iSU4Ef4j/Eq?=
 =?us-ascii?Q?6ergVEC2qYrz/C/wTS89vKeWGeKivo5R/xsfnguFzreBPIMyzvCQNKyCzScu?=
 =?us-ascii?Q?pgyKwqrpiHeErNTBJQ1iiUJw94RwEu12ZmUljE04Vv5N0AWA1zIZ/3RdVKvr?=
 =?us-ascii?Q?tCnnHhweHS1PabhEO1SmT7rNoam+Mkh/sQgW+oydVcW+FaxPLlwh8eahff4R?=
 =?us-ascii?Q?9M0BB05B5AbAICZrzWENkTfnwmgPNdw5j82Dv7X0/uC6/zSWupz7wxi6Fov8?=
 =?us-ascii?Q?gHaYuocfo+kDIahKrBs8M0tiBDvLgKTMtzr+VU8n/9O7x39geXF2cymTfyvF?=
 =?us-ascii?Q?pkrmXyu3f8KPBqprvQjxDtpW8vaTd8wKueklPw8ifh3I4+ViC7RRppXHGPC4?=
 =?us-ascii?Q?JWMnV4YedAPwRIqASgeR5C34mZQFMyYQP37lUzO0AMDmu2ZMKWUCMwBCU6zt?=
 =?us-ascii?Q?ts5ALIxVahHpNBOaULgYKIYrIrexHiCEqL9SUbEGhXS+4bCDNUP2r/Q+9r8/?=
 =?us-ascii?Q?cz3WK3nybKyBKZr3xFVmB+ev7rbCCvcgy6exnk2cgFhuYg5zhK/nouTQadq3?=
 =?us-ascii?Q?/hI/IciaAurysWRGBuhmP9aAyrHVYnv0E6t5SyNP0JNxLp1t+o0auj/WtAi3?=
 =?us-ascii?Q?sBWAdw/xg92KGVXHj2GhbJ6IdzIBQIXd60Gecboiar2h3eZMgahAKkqLGG4+?=
 =?us-ascii?Q?nJXxzEDp0P/CG98X9wDxDbqn6CyAdoSiLyOjbr1d3gBYd7rSvRoqEmIzNFOu?=
 =?us-ascii?Q?p5e9nu+jXUFOhshwSZWiAncJ5VFkF2KJoBjwo/vlhXcu60uQr0cDf3UQTm0U?=
 =?us-ascii?Q?acm8YhnfgA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df46179f-04e1-4fc6-ab58-08de79cebe10
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 09:16:39.3943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P23sC+MeoHbt9J2YVi9k2yZ7x+9efgTnhE/fhBj7mzkvsvInj7/LAM0Hsx/dppCUp+XUmOHuhyydar0wSlVXbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFFA661D690
X-Rspamd-Queue-Id: 928BF1FD7A8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263687-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,334190e097a98a1b81bb];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:email,Nvidia.com:dkim,appspotmail.com:email,shopee.com:email]
X-Rspamd-Action: no action

Code looks fine, but see a few comments below

On Tue, Mar 03, 2026 at 11:13:14AM +0800, Jiayuan Chen wrote:
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> 
> When a standalone IPv6 nexthop object is created with a loopback device
> (e.g., "ip -6 nexthop add id 100 dev lo"), fib6_nh_init() misclassifies
> it as a reject route. This is because nexthop objects have no destination
> prefix (fc_dst=::), causing fib6_is_reject() to match any loopback
> nexthop. The reject path skips fib_nh_common_init(), leaving
> nhc_pcpu_rth_output unallocated. If an IPv4 route later references this
> nexthop, __mkroute_output() dereferences NULL nhc_pcpu_rth_output and
> panics.
> 
> Simplify the check in fib6_nh_init() to only match explicit reject
> routes (RTF_REJECT) instead of using fib6_is_reject(). The loopback
> promotion heuristic in fib6_is_reject() is handled separately by
> ip6_route_info_create(). After this change, the three cases behave as
> follows:

s/ip6_route_info_create/ip6_route_info_create_nh/

> 
> 1. Explicit reject route ("ip -6 route add unreachable 2001:db8::/64"):
>    RTF_REJECT is set, enters reject path, skips fib_nh_common_init().
>    No behavior change.
> 
> 2. Implicit loopback reject route ("ip -6 route add 2001:db8::/32 dev lo"):
>    RTF_REJECT is not set, takes normal path, fib_nh_common_init() is
>    called. ip6_route_info_create() still promotes it to reject afterward.

Same here

>    nhc_pcpu_rth_output is allocated but unused, which is harmless.
> 
> 3. Standalone nexthop object ("ip -6 nexthop add id 100 dev lo"):
>    RTF_REJECT is not set, takes normal path, fib_nh_common_init() is
>    called. nhc_pcpu_rth_output is properly allocated, fixing the crash
>    when IPv4 routes reference this nexthop.
> 
> Suggested-by: Ido Schimmel <idosch@nvidia.com>
> Fixes: 7dd73168e273 ("ipv6: Always allocate pcpu memory in a fib6_nh")

AFAICT, even before this commit fib_nh_common_init() would be skipped for
nexthop objects that use the loopback device as their nexthop device. I
suggest blaming the commit that allowed user space to configure IPv4
routes with nexthop objects:

493ced1ac47c ("ipv4: Allow routes to use nexthop objects")

> Reported-by: syzbot+334190e097a98a1b81bb@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/698f8482.a70a0220.2c38d7.00ca.GAE@google.com/T/
> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> ---
>  net/ipv6/route.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index c0350d97307e..fb588a351609 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -3582,7 +3582,6 @@ int fib6_nh_init(struct net *net, struct fib6_nh *fib6_nh,
>  	netdevice_tracker *dev_tracker = &fib6_nh->fib_nh_dev_tracker;
>  	struct net_device *dev = NULL;
>  	struct inet6_dev *idev = NULL;
> -	int addr_type;
>  	int err;
>  
>  	fib6_nh->fib_nh_family = AF_INET6;
> @@ -3624,11 +3623,10 @@ int fib6_nh_init(struct net *net, struct fib6_nh *fib6_nh,
>  
>  	fib6_nh->fib_nh_weight = 1;
>  
> -	/* We cannot add true routes via loopback here,
> -	 * they would result in kernel looping; promote them to reject routes
> +	/* Only check RTF_REJECT, not fib6_is_reject(): the loopback
> +	 * promotion heuristic is handled by ip6_route_info_create().

Same here (FTR, I suggested a different comment in [1])

>  	 */
> -	addr_type = ipv6_addr_type(&cfg->fc_dst);
> -	if (fib6_is_reject(cfg->fc_flags, dev, addr_type)) {
> +	if (cfg->fc_flags & RTF_REJECT) {
>  		/* hold loopback dev/idev if we haven't done so. */
>  		if (dev != net->loopback_dev) {
>  			if (dev) {
> -- 
> 2.43.0
> 

[1] https://lore.kernel.org/netdev/20260302082551.GA814377@shredder/

