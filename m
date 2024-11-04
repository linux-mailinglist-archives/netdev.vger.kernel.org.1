Return-Path: <netdev+bounces-141528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C199BB406
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 12:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D4E61C213D1
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 11:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB641B3949;
	Mon,  4 Nov 2024 11:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F6fTrKDv"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2049.outbound.protection.outlook.com [40.107.101.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A85F1B2199
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 11:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730721527; cv=fail; b=YFMVsJxggCTCppLFL+FKEwhDo6itOPwx+oDkDUoi9Oxct5WuQOuouafy2TJpuTVY+SpfBfmGgsYGRqbxDLQ91+iwOljGX1K+pl0c42sINoixLYWfAiIfdM8+12e/TOPO7khgxTZWvrWizvAXU1Z99xQwz9S7IQhvz9O/0Q3APT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730721527; c=relaxed/simple;
	bh=xieV/x0xSRd6kf0TSidB70M+O3Fz2Wsp3tSQRBil0eU=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=o9qthbaALMrM0DJt8x3g4rNPoquhTIL9WvNlls/iH/HysH70LbFaMRxtpF9/T1LMOHFtRJ54MeAJnmmsGkkpcna/9z0dm0iNtffAuJk+wOPGTIBTWcTRof3ypz43dEOjFEhQ+Qe0sA4+TtpaT52gPX74ysCyzfbKMiFnvEKD+zQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F6fTrKDv; arc=fail smtp.client-ip=40.107.101.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kgVbdLgcSh3d1IAZzN77cM3z8Fp71Ln3BGlducfoiAz25k78QXDXkIB89HShwxwntv23RNsHgNsLbtT2GOVtOUoMfsJB7h8+eab48/CaM1vR5KEN0Bq99OKWVfNva68Gjji8iVzy6mJnnbP817NineLaCiUpwQwZj2MyP9ieRyUkznVxRz+G1oFUhDpLWBYItvEIYAxAXG5NVRiss5KVgVdcZAdTXoJC8V4NhrgkFOc1m10bg85oO28OO+t0qovhCQwwj5o3tQuS35M0IVzLsDTjt1Dt15v73Fl7HruyjinaschMqwdWVRbpYZcxi4JzAI6Ak0ud7Y/CY9k9bOV2nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BrW/YZhfHf2lHV/+YTYmRpmcR1B/8tqtUZZzpjpLTtc=;
 b=TOoXycGcEjAGX0T8YyER0wyuFZqd0wIUsbFfU7uNwsgFPsvIXARxcsLCGgFtJgnlN/RrXFMiFZkTqnBUppZTxZqWRMmV/0JnJEL9/EHKSNiphcdNJUYEBsdqbLXTodHTbv5aR9yx7iAwAbvWe8cxRtpF4/Kqvkz3B1ikJEb33sUhraOZ3FRBvwb1eXcYV5PVvqMuNtIPZvk8fDkQmNap9fLL1gZ8iR5Fhg8SwE9Ss2SLB6ZVa6XRrUJjyw7egUu9Bvgc8sRLuso6BPsiYciHthNjt2tJBWREB08KUzMpOl+yrfs9Q+JRaCmtxZJgXNjN7/gYRGHCgakEF1M4dMqesA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nxp.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BrW/YZhfHf2lHV/+YTYmRpmcR1B/8tqtUZZzpjpLTtc=;
 b=F6fTrKDvB6UOA57AZdJBO9qxxbr/q9IvMs4zvR+Kd3LsF0ulrSyV8nMKHsgRFU4IvRKa2FgEiLafPIm+4YBLhIs2XNNWzIg0ygm5sgkyFiIWlxdMANEo1wE7jZdqzGpq/gBZjqjP4yfMw++mdBU7SON/iIxkAwkvnBUscAkxXsvUv5p+K6e0IE66+dHK3L1CDXF5cWLoC8S9XxjYXsLM31KVcalQ8Bez6k5JtDOwUDe5NuBaX9uPs4+itQirr4ZuwpqHdLnnFnr912yTKTxVeKVe/wU2xgp3XYubdJA/Tv3rJcVXxD71Uqq2AUkDrqB3ok5dNgEL9zZt1+mf1tot9A==
Received: from SJ0PR13CA0129.namprd13.prod.outlook.com (2603:10b6:a03:2c6::14)
 by PH7PR12MB6612.namprd12.prod.outlook.com (2603:10b6:510:210::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 11:58:42 +0000
Received: from SJ1PEPF00002310.namprd03.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::8b) by SJ0PR13CA0129.outlook.office365.com
 (2603:10b6:a03:2c6::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.17 via Frontend
 Transport; Mon, 4 Nov 2024 11:58:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002310.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Mon, 4 Nov 2024 11:58:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 4 Nov 2024
 03:58:30 -0800
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 4 Nov 2024
 03:58:24 -0800
References: <cover.1729786087.git.petrm@nvidia.com>
 <20241029121807.1a00ae7d@kernel.org>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>, Amit Cohen
	<amcohen@nvidia.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, "Andy
 Roulin" <aroulin@nvidia.com>, <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next v2 0/8] net: Shift responsibility for FDB
 notifications to drivers
Date: Mon, 4 Nov 2024 12:43:11 +0100
In-Reply-To: <20241029121807.1a00ae7d@kernel.org>
Message-ID: <87ldxzky77.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002310:EE_|PH7PR12MB6612:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a8ea73c-a425-4a56-ba82-08dcfcc8073b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ELNtO3ZFF83/WdU6caZQyW/7EdTPnnwqwerKefqxLXJKrHj2D+kKrsZkAUP1?=
 =?us-ascii?Q?ZmQ2jO8UrIBKo91gkw+VurJcsoSPz75Xnloj2TUjsVPOgYb4eA2QwNRBAbmL?=
 =?us-ascii?Q?Fz/kcb5G9oPo+eA2FdtTZtTr5cQPgy2C44zSjaUt1sSw2FZaFs7x4QF38CiT?=
 =?us-ascii?Q?VPyePeSe6534+TVlyuzpGX6o1NOFDVMSOlzlG9xbyVkd+YTuAKwgVBK9WNS0?=
 =?us-ascii?Q?79Diw8mh2CiOn0++Ka4YPkZMl5rjj2NshS/+pJAWGHPw/sgeWeOkIwQ9c7cu?=
 =?us-ascii?Q?7gf8mb6UXjW8qISqem12tFtdE+0+asbxpj08C+9ihCuHnZuw9yc5gerMZ10T?=
 =?us-ascii?Q?HcPajYsXVjgGgW8pU1Fb1+4HR2uB0vDDrOGqPMHJ5dwZFpIdfTQERZHwqbuX?=
 =?us-ascii?Q?RssKxCY3tUEHsdW62ABQ/3MVbkhqbttG0grwZSvBtOXV0QbG+YkvYz7Y6uYT?=
 =?us-ascii?Q?MGOw17nkR/UzwJhqE5DpjVh/T6DQ2q/6L06zUfSRQNjiz+/TwyUXEXc2cmae?=
 =?us-ascii?Q?QPqzo4IhLCKSF1M7FSK+3uFTnOlMZ3GNeOHzh5/Yf8bb87g1jsXb46DyCGB1?=
 =?us-ascii?Q?PoDGPK4ewqbedywZrTTIxMC2c7BIzynWgIrMVc91Ux20yiWXYbxMYsqHEqzH?=
 =?us-ascii?Q?vy+1BX6lREREyu+qWKui6mX0nbwbLUqwntu18ShM2BqVYF0MdvXZMcrosUag?=
 =?us-ascii?Q?8Rw0mzV/U7SaZ2lmKXKPTbIbHPhDpSFXDp9BTfcxensTtwc24QGmb6ptEaBu?=
 =?us-ascii?Q?AvNH80knEqvgFC2JPzIRGpcmktXBWpmOoEOgj6fa88l6m7XDWeNJGX5k64s5?=
 =?us-ascii?Q?uZil3LzPxbKprAA7t5GbJ0115Qb5/FUnnfoA7zBXZM2oGvI0bCkShOGq1Zwa?=
 =?us-ascii?Q?2tFcIX+fvKqFa5ReIC5WXJYd5NY7r9cQoAQZ6NzvdpZ1PYXyRJVpTJLwQw/0?=
 =?us-ascii?Q?idlf8rnGWA1uB7m16BQR7dCFV/oVdKdmRJl7ufQh4wUBibdwmhyNzrIM7BXs?=
 =?us-ascii?Q?zLw+mxAPR7EtGL+o7WgrwY0SgrzgYlUU1F+eTr9v3IOfK5ADDMeJae0C99yG?=
 =?us-ascii?Q?Za4ysb6norlHQ4Der77gjhOUw9E5viVuv7fpxhFj8Ala29ZXiKxOpHsiUR8w?=
 =?us-ascii?Q?jKDRvOz11MhCkKt09Gl7SjcXtPNE2x6RzA9/R7C68ZM8mqxAllNvF8OdBrvP?=
 =?us-ascii?Q?2D3LFa2f54/9w79umqs+8DFYKXTSuJsNKekDXrkokDG+aHRN89wllY1YwgfE?=
 =?us-ascii?Q?tFfZFKPCDUv5J7VUrE2dKwMwWHoNjhULX6yfAyO+gU6/hfVXNmxqpaLRwjhB?=
 =?us-ascii?Q?EGo+EqsvqjVR6ZtVeYPatKRkadbbu0hjmQLdkI/NBmHnnj+EsGtTeVm99gvF?=
 =?us-ascii?Q?IGmIPWa8JG49vBjRT71t08mfndZEvtemtS3KHI8e8Lhg0hEkwg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 11:58:42.4625
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a8ea73c-a425-4a56-ba82-08dcfcc8073b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002310.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6612


Jakub Kicinski <kuba@kernel.org> writes:

> On Thu, 24 Oct 2024 18:57:35 +0200 Petr Machata wrote:
>> Besides this approach, we considered just passing a boolean back from the
>> driver, which would indicate whether the notification was done. But the
>> approach presented here seems cleaner.
>
> Oops, I missed the v2, same question:
>
>   What about adding a bit to the ops struct to indicate that 
>   the driver will generate the notification? Seems smaller in 
>   terms of LoC and shifts the responsibility of doing extra
>   work towards more complex users.
>
> https://lore.kernel.org/all/20241029121619.1a710601@kernel.org/

Sorry for only responding now, I was out of office last week.

The reason I went with outright responsibility shift is that the
alternatives are more complex.

For the flag in particular, first there's no place to set the flag
currently, we'd need a field in struct net_device_ops. But mainly, then
you have a code that needs to corrently handle both states of the flag,
and new-style drivers need to remember to set the flag, which is done in
a different place from the fdb_add/del themselves. It might be fewer
LOCs, but it's a harder to understand system.

Responsibility shift is easy. "Thou shalt notify." Done, easy to
understand, easy to document. When cut'n'pasting, you won't miss it.

Let me know what you think.

