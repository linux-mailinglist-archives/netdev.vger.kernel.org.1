Return-Path: <netdev+bounces-169348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5076A438A8
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 10:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 170793BBE0D
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 09:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B570A1FCCFA;
	Tue, 25 Feb 2025 09:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K0a8FXF1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECEBDF71
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 09:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740474026; cv=fail; b=XwfYJqnLKf5IzKs0s9RxdMRvAHeBBMCRzj+jyttfSeyfTR0yMo+OPpuH4r5UWhG31cFrck9IVDGTq4CodP4ObzT3BJCcDLDqE3ICtrPl5GE/wjVZ/e0H8D7YGbUN4dhLju4NeWm3ZU61MY83fFraCadHFZnEG1i8xHTiGcyVWdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740474026; c=relaxed/simple;
	bh=eBrv0RkaFAiiUBCxtbJATxuRFGbupzStyBBYGhrv2HQ=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=PUFnIPPbbPwfFyx5W66l+aDjLI2D7RZK4Aukv0z6SRAkIeiBH6xgxZnoSZs+aoqWmkMGIzC8x6sTMNjlE9lRqllt0hrRLV91NzOxFte++QZR6L7ux/sn/pmv4UZeOreZItwx8RFtg9iVa9fAMaZQcifIVXmgfL9yfhpvHPwVCoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K0a8FXF1; arc=fail smtp.client-ip=40.107.236.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LA8pL15VL5o9RoWUpn5CkNFUy+xJRQ7mYbIuJ74aRTWUqFgzm4epY2/A80VtlOAbMpEGnKDPG/4+BGAfYXrs/BbYb4gwfREcbz/BkbufAL6pdSsQcBPnqSOxXH78NRhwbTQyzBpxudUcrFTudKpirY651mTD2e2+zWAnpvARADrbrcgBqp7ZwooQ/X+BPoj7phIPEHF6y3fwadpa6e829PIHrd81QRgtjZsMhqQfgjBlPn/B0Rxn3Zi8OX56DJ07NJNuDbAKkbbNeSRHANV0jyjO4M1yipW/imm8KRCFrH1tpE/7DVF6UdeaDV5Jjfxw4gIusZ9FN5sUk2nl0OPnxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ngvyi0ACCfgeMIVIK688GPHxr9v8bw3dTFuHkRSYdFA=;
 b=vnR5vQAb8LlzDU1Ms+l+R88O0GksMgoeUngWguqyVkv6YQv1EHPrIhypOub1QMD0K5MunsoUuYyzemqQmRBoHeMJ2+Oy1/Ro997ORWumaG329WHsk4eiotzll/na4UbPNPeCnDeZBoT0eKMQlitYeFP9spPYBtQ+t+r3X//n26BhULLgp3jkbMwghGEk2wCsprq1/ZxoMyq4q8DzaStfOEII/rFc6OekBkKk8yWvk8iz9hA4Y3/DUtoIz+qdv85jkkISPuirHgfNm6Uk/nQgEEMTQjgxlT+K33pON4TowYX95szYn78K2k/Ikf7kBQI8Pp94a/mhl4IpL8d+Gr0yzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ngvyi0ACCfgeMIVIK688GPHxr9v8bw3dTFuHkRSYdFA=;
 b=K0a8FXF1x/ZDGG/aFXOzwEhkfuMF5zpWNqXayQstzzmRgNbFqGD9NknhG8ss75sqdFpIQgMs0KQl3rIP0tjV4uxIidBK+N8jiDJvQSNur4Tif7IWtRB6vtpJdB/+XZCff8LPx8OR59hIaJC+PL9+Z5LoS6ggws1BV8euQRTEZGvwfVhrmfoC/63KFgQtMTKLE/V8FTDQv8hhRedjHYJoM420oYy4xnpktw7R6wvZogIOTPFvwA4SNZT6mKcIHxTBDn+vYIjaKKHchVbl5JbJoeOeYMLzNYinWHH6GMjOns8dVIRhA+lt6GzVTeI9LuorA3p8O7js3ZxY2v7HH09IDg==
Received: from MW3PR06CA0026.namprd06.prod.outlook.com (2603:10b6:303:2a::31)
 by MN2PR12MB4157.namprd12.prod.outlook.com (2603:10b6:208:1db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Tue, 25 Feb
 2025 09:00:20 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:303:2a:cafe::20) by MW3PR06CA0026.outlook.office365.com
 (2603:10b6:303:2a::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Tue,
 25 Feb 2025 09:00:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 09:00:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Feb
 2025 01:00:06 -0800
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 25 Feb
 2025 01:00:03 -0800
References: <20250224065241.236141-1-idosch@nvidia.com>
 <20250224065241.236141-6-idosch@nvidia.com> <87jz9fjt6o.fsf@nvidia.com>
 <Z7yeDXAK26NOEue4@shredder>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
CC: Petr Machata <petrm@nvidia.com>, <netdev@vger.kernel.org>,
	<stephen@networkplumber.org>, <dsahern@gmail.com>, <gnault@redhat.com>
Subject: Re: [PATCH iproute2-next 5/5] iprule: Add DSCP mask support
Date: Tue, 25 Feb 2025 09:58:19 +0100
In-Reply-To: <Z7yeDXAK26NOEue4@shredder>
Message-ID: <877c5ejt69.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|MN2PR12MB4157:EE_
X-MS-Office365-Filtering-Correlation-Id: decdf729-5812-41b2-de65-08dd557ad4e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5fIFiRhj1e52UcKhjG3Tb1rtMoqzESB5FRTBcOwUgUh4JSfMuTWovn37/5X+?=
 =?us-ascii?Q?RDwUR8hST5kgrxxMgZVWndLy1e5W3fdptKOISj3uOhb9kIofk0AhGolI5nNk?=
 =?us-ascii?Q?deUiyxZ0BBGOMPtI5ihTCAhYov6w+ScwuJ/aYyjmK2hbhZ3e1a4JloiGYKhJ?=
 =?us-ascii?Q?RDQAhSS5M5ZGjs+vo2RJ7J4Axx8v8+vwY9ovkKle2+FLZOnt3OBNZczUZvQw?=
 =?us-ascii?Q?I+eLpbNVcwTSvFRHjM04wRl7C01mbbQilz7eigc8TIVsAHe5IZP1p99gSdxv?=
 =?us-ascii?Q?0aDIH+iXzhuHkNBl2CI5K2LdH4qKV/GYh4GUM6qknwHJ/aOxD20BzhjGEBXj?=
 =?us-ascii?Q?+w5NUXfmF+K4OlAjw2rMh/dFRPsvsdXYPuTdDIeo2euNIxa785o85REmKK+F?=
 =?us-ascii?Q?9WjrTxS4JR26jWhIEZ91OoUL/RzejW5S8v1NixLMAhSgLVPJZPZAYgIwSt8q?=
 =?us-ascii?Q?noP6v/QojOzeT7p2yGc4miDlAT1gARkpruwzVutNWpRmtCGzmy7sRZQoTG/r?=
 =?us-ascii?Q?EN9PeY//qSyEPTBbUBXjWUVUMiWxAdeiDo1vxao1qkJDqybAfSXg4CkaB35o?=
 =?us-ascii?Q?giCzvYWAhDlcaVLdE9B+HyWxTyvXhfp0tbwvqI0ZRbkXS7/Fi/fYJrfpakFw?=
 =?us-ascii?Q?L5LdD13Tn8j6MRubZmuQbP2I2hIyablhf5EwKEhwnxywjbgcHxOO/oanMFQy?=
 =?us-ascii?Q?rcp9ypEFktx4g0LnGTw6a89nwYtNA5lu4HYA65iYuC4CWuDj8w30M1yW+5NA?=
 =?us-ascii?Q?gZJ0kDHldrPnrquPsfDB9PQuBsa4HbnMCR0anE+nUhRZ063KxVMp3BH7zzDi?=
 =?us-ascii?Q?SLf2FelWCJzRuCEPMnl1Nx/sYrRBhF+wxIS6gM9AmKJAMbThJR0b2dLZVkMM?=
 =?us-ascii?Q?uKFxczfPLmOvg3UF/p5I2OJVbb9pEtF1zb4w62xjOz4Hhrv4G31pM8KlMpMe?=
 =?us-ascii?Q?QcoPgjEOgSAjK5kKQm6QAjTP5vybHIiDyk5vJDIjepCwJHXafk2qdsGJYkQl?=
 =?us-ascii?Q?c1H185RNpMpTje9smrccH1LvAV1QdXMF9Y3CITm4hiknC6x1UCfRJtZgBsNC?=
 =?us-ascii?Q?B0osk8cym5qgTzttDAgKwlxceM0in7hVRpUkYQgpa2Iq63NJ0SwVVLcHY3u3?=
 =?us-ascii?Q?G6LenqBXti6idGj5e/2P16VA3CfBgRa7obLRFDjmbw/UOgJHv++tep2PEdyy?=
 =?us-ascii?Q?Y0Gzulv2LLz8h3Xy7NZYDsaRzWtAo9w/977pRPh4AyEhb+7tJKNPlTTQSEig?=
 =?us-ascii?Q?XvSa/8w3FYxGdCKxRQD3T8gVGmToj2muXtahkmoq7RqT9SJ6w0nAtO0bPbb4?=
 =?us-ascii?Q?29grTtCDYdl+sY8Cy9ZGvIkEDQ0I8G+E1ubJiIuVxVJqOT/UsTvK0m7/TSCA?=
 =?us-ascii?Q?MKHPT7+Ga/2m37QA6N2bdikGoG0xFA+Rw3qURLi9li1kf6ijE8c5F1kmeyte?=
 =?us-ascii?Q?9WI1KL7xeYarJrKbUucfoOxfNFChSRv7DFuG1QUtnlTQ2kl0XTKHwGLfgIjr?=
 =?us-ascii?Q?E/sB7gh2sEDx9ow=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 09:00:20.1383
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: decdf729-5812-41b2-de65-08dd557ad4e9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4157


Ido Schimmel <idosch@nvidia.com> writes:

> On Mon, Feb 24, 2025 at 03:35:51PM +0100, Petr Machata wrote:
>> 
>> Ido Schimmel <idosch@nvidia.com> writes:
>> 
>> > Add DSCP mask support, allowing users to specify a DSCP value with an
>> > optional mask. Example:
>> >
>> >  # ip rule add dscp 1 table 100
>> >  # ip rule add dscp 0x02/0x3f table 200
>> >  # ip rule add dscp AF42/0x3f table 300
>> >  # ip rule add dscp 0x10/0x30 table 400
>> >
>> > In non-JSON output, the DSCP mask is not printed in case of exact match
>> > and the DSCP value is printed in hexadecimal format in case of inexact
>> > match:
>> >
>> >  $ ip rule show
>> >  0:      from all lookup local
>> >  32762:  from all lookup 400 dscp 0x10/0x30
>> >  32763:  from all lookup 300 dscp AF42
>> >  32764:  from all lookup 200 dscp 2
>> >  32765:  from all lookup 100 dscp 1
>> >  32766:  from all lookup main
>> >  32767:  from all lookup default
>> >
>> > Dump can be filtered by DSCP value and mask:
>> >
>> >  $ ip rule show dscp 1
>> >  32765:  from all lookup 100 dscp 1
>> >  $ ip rule show dscp AF42
>> >  32763:  from all lookup 300 dscp AF42
>> >  $ ip rule show dscp 0x10/0x30
>> >  32762:  from all lookup 400 dscp 0x10/0x30
>> >
>> > In JSON output, the DSCP mask is printed as an hexadecimal string to be
>> > consistent with other masks. The DSCP value is printed as an integer in
>> > order not to break existing scripts:
>> >
>> >  $ ip -j -p -N rule show dscp 0x10/0x30
>> >  [ {
>> >          "priority": 32762,
>> >          "src": "all",
>> >          "table": "400",
>> >          "dscp": "16",
>> >          "dscp_mask": "0x30"
>> >      } ]
>> >
>> > The mask attribute is only sent to the kernel in case of inexact match
>> > so that iproute2 will continue working with kernels that do not support
>> > the attribute.
>> >
>> > Signed-off-by: Ido Schimmel <idosch@nvidia.com>
>> 
>> Reviewed-by: Petr Machata <petrm@nvidia.com>
>> 
>> > @@ -552,8 +560,24 @@ int print_rule(struct nlmsghdr *n, void *arg)
>> >  	if (tb[FRA_DSCP]) {
>> >  		__u8 dscp = rta_getattr_u8(tb[FRA_DSCP]);
>> >  
>> > -		print_string(PRINT_ANY, "dscp", " dscp %s",
>> > -			     rtnl_dscp_n2a(dscp, b1, sizeof(b1)));
>> 
>> Hm, this should have been an integer under -N. Too late for that :-/
>
> I assume you mean 16 vs "16" in the last example? It is a deliberate
> decision:
>
> https://lore.kernel.org/netdev/d3cd276a-b3b0-4ccc-9b51-dbedd841d7af@kernel.org/

Yeah, that's what I meant. I agree that if `ip` has it like that
throughout, it's better to respect it.

