Return-Path: <netdev+bounces-303574-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id H35hNdbpRGoX3AoAu9opvQ
	(envelope-from <netdev+bounces-303574-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 12:20:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 369696EC0CA
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 12:20:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=gdTBHvTy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303574-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303574-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DEFD6314ABA0
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 10:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2188403EA0;
	Wed,  1 Jul 2026 10:12:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010024.outbound.protection.outlook.com [52.101.56.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6016C3F4824;
	Wed,  1 Jul 2026 10:12:24 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782900745; cv=fail; b=Z/YWBgKXUSljNcjT7U56Fou+lgIyOKAY6pgU13cDLlWRuedMC0VY3eIAQ2AVLJr2z0X6RmQgHCMZx68Ecr/3wq4QpkR161StS4ZnW1FROVPYlSZ5sVES6JIlBvGPrDzx6g392IyaRWaPt4IKFNavQ4czJtPNFuqMv+33tIDHA/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782900745; c=relaxed/simple;
	bh=VEtH3cHk7Kf5a580yOw8HAFSxWOkXTL52p8JeXtofaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FETZyJRvllNa378dojaz7tBjQa24+ZEVZlHJtLjxgybo4GqCtnpA96ifpPOK4w0d/kucFuE5ACknRZN8rfJcG43NnEL6UogwhQMbUpDgv3m5tpeUDQ8nuoA+n+m3uIWIR/ev1aWDoyMXHfJgdc53GHOPPMdwEipDBqGylLQkuaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gdTBHvTy; arc=fail smtp.client-ip=52.101.56.24
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XCiyOA/P0OagOCIN5uFuolA/qMYUX4GUnoV6BX9LzJisMXqmy4dB0JZQgb3enWLY1MUgGDaesyfPZr8pAsyaWn8YC+DOMLAwqW7iuuqGoXwNqTvzsRlysfhBewJ1ycu3hOr8QAlDxlZTpgrDZ8HR355Q0zIPxbdlmG/prFZkymrkcj+Y/eSe4pD0P+5LigWHXRkKm/2If7gL0g3J6XYgqAkgbLe3wE50M7ZyMCH/hRgQFH8mJ1Qna/k8z/WAm45qc8+VjybQq/HPuWsZE8SK2zMxTej2thrxTxsdpJ+H8hhcZ0GdysfysmX3vkIhbFau+EzTwuL4hABM6fE7UgUALg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntQjv2F3wOml9GFm7VO6OfNsDD6Kqf3liLZ4Ga4TtYQ=;
 b=j2Ys5rdja5QhBrSpRDq+jUaKzEJGo3SAciP2S5tw1T4CdrEo1T2X1efa8urjfJFPXw/qT1bUup/oMwJZ7yvER1BwQGzxt2WeCrvW3ybp3AWDWzkH2WmthswGS+lkfomApa8m+dpPMX9EhuL2g+HMU8zPLWx0NCCJTIhs+r1jdQeg9cjcEx8i5cpQeZLlA2v/Eza3m1wROVhvJkJI446guyri1TCXsbcwc+M5/62vLF7nDTve3zypljVA/zq2PdgUqiMFp4VKDKfHYI1R2w990u2dxqajW13T+4IOkwfZ0U8Z1xF+gpTH6phm8x51uFQiUZxAM18Lc6dezUawTUJYNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntQjv2F3wOml9GFm7VO6OfNsDD6Kqf3liLZ4Ga4TtYQ=;
 b=gdTBHvTyOhtX87/vfdzgNdgz5cXX+7bn++S4IAWh+RpXWTTznEMCUjyj4wSjlhQxzAUhC4+maj0f3wg056yXUds8xGD0YUcPBTaIbhTydcS6P7xqqOIaVIaQig2UvqSUcEqUHffHP4WPql2EdTLLeIIWsF/cKRq0Kb0WfDnuAIKn4Rl8dEgW4MZvcdRaOa9xoPDD9ws+CRVoEWwzhvsI+vbFiY/T5VJkjVtP+bCOEXPSBvkvHNHVKhnM9IPphzlOgs/gd2BBnWY60uSNAGYD5TICGWEl0pkcXI/rYzIRdfPKHXlJrCAx27mvUCmXfYljuT8XEtoLTkHxHKaqPUAQoQ==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by BY5PR12MB4259.namprd12.prod.outlook.com (2603:10b6:a03:202::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 10:12:18 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 10:12:18 +0000
Date: Wed, 1 Jul 2026 13:12:08 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, davem@davemloft.net,
	dsahern@kernel.org, edumazet@google.com, horms@kernel.org,
	jedrzej.jagielski@intel.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, xiyou.wangcong@gmail.com
Subject: Re: [PATCH net-next v2] ipv4: igmp: remove multicast group from hash
 table on device destruction
Message-ID: <20260701101208.GA1357976@shredder>
References: <20260630165934.GA1227354@shredder>
 <20260630211527.3365952-1-kuniyu@google.com>
 <CADXeF1HY0EGdFwe6DXu21BmpYUQebHLp89kQ0MpDgb_DDGSaqQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADXeF1HY0EGdFwe6DXu21BmpYUQebHLp89kQ0MpDgb_DDGSaqQ@mail.gmail.com>
X-ClientProxiedBy: TL0P290CA0014.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::8)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|BY5PR12MB4259:EE_
X-MS-Office365-Filtering-Correlation-Id: 079f6f78-0454-45a2-7454-08ded7593b77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|23010399003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	w/C05ezc0daZJelSJjUHrjArsSa7y2BdB1i7FZnN1d1T2CLuls5sdbIf+fedXV5VlMAt1GJFKLcODz9mTOx1GTQ3KSRnp20DWRmb6YVKyBq02buiivwIuo9SwknroY64BHlBw4CRDc4xx9sc0FcmBKg1jcSkibAN1oVfyxgM6rO9KIh1Z6jARAGHx58xrbwCSrIFLZHYas9778L02Jbrcr8q9XcMOgPT7iuUMCbA5PkrU03DgIeiCg396wg8bCMmcgpaPd/TkPNVrrvAa8Ad4frrfbXFmrMWkkYC5by4HMEPArbFOjPvbRaIQ0OfgwrWWn0M4DX/QDjAo4d0nFE4DNYm6kwz3i/N+fEDOCFW3gkSDwQZDMGR+7c6s02Xi93WoGHEY1CMgGnybL9N0NsC/aK4yldQ4Fdwej+sGg3a6e2nom691Gw9ARsHaxbiQ8EbUSoxFQw3t17YciFq8XAmw8RWgFL4ROjTbSU+YWDn4gPJFH73fQeHJU6gDa7W5Z5j9B9VnO5f4Cl68vbvyectodP0Wzyb2fBzH6W1DUEjPmGS2SNjjs/rbQiOkbYMbY6Rubw2SH76WQRCtRIsWsNPL2o275Nqaj0+O0nQdOhJ4B6M1JV9Ak+GBTpGmRGzO4Sh0ZszUqMBaGFsfkKWfQ3f2XEhGVdsd790aKSpdZDV/WI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(23010399003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RPLIRoIvThGDDkp9R+CcDs64bZNFy0Pi4eilaYdK+VGZ0V2aEGsbcCxQR7NT?=
 =?us-ascii?Q?81DpWs81gBM0L24Pwhsogv/acSkjcjSvPE8tmDH/fER5FE1cq4EkDYnI27Li?=
 =?us-ascii?Q?LdvRUmvH3xxvwSm2FBe8LLSp510Zgx6M0PleQKDjkLNFxcxuwgDeJzUt0vjG?=
 =?us-ascii?Q?GcsBgzopIPZleZMDz+HT08w0eklrFCUsmDTYmc2YvLYeiPn9Y5yJ7v0yV5Az?=
 =?us-ascii?Q?Hm6NXLUCTHD+KHjJ6zlG815FcDtFMAjs9oPDWGfuTdHdtGtOsQLOBQdt6Dci?=
 =?us-ascii?Q?5ALBwl2RNKMM2E1sb2WRpRz41Ytr/POURmQv4TQzLfrfxQghGLi0LIlYjPDc?=
 =?us-ascii?Q?JWA9mQHwa41SFlk3iF6cacRSDiFliS7gCcnCcXGaQj8HkOR4S28NHdXJ/tbk?=
 =?us-ascii?Q?wzFxuZfQzrX6ZmPGwlHIC6O1a09qkEsngjyUIKnpZj0RCGVOQYc9TIKL9YHb?=
 =?us-ascii?Q?7m3Dg29VzLVeuN7kDWh1tWQ+Oz+zF4PKnCICvanPwuVPeqvNFeK/MTZ6OfyN?=
 =?us-ascii?Q?wu+omPQZzSUcBSzPVX2pcC9LhoeZtziAJbHrOnoMqcEQwaQ54O0Vn4plLxwi?=
 =?us-ascii?Q?B/6UaBnN+w1yDq23JsShKxzgh697hWFbnl9mjLhgCCQmePmI9Y3Dh+jROZxI?=
 =?us-ascii?Q?4k5ZcDZ8pUToEJA6+ITQUDB5mT+itSVOI8RhHguJR8N3IA3GMwDw1ws3Tzv1?=
 =?us-ascii?Q?m1qmhu0ye8jTc8ZkRUqNFr8M2VA5f3glSMsg/ocCthy5BJcrqmnbnkhmR1C9?=
 =?us-ascii?Q?IuiKW+pknMINrCD+Q0BspALW6zR63hsevkRyMLRA0q7+xR9yQB/3sFVWom6k?=
 =?us-ascii?Q?v7Oh3EQQT36XBYSRXwG6DMVggJFet56mMHCcM/gSla8nUASUGGLdIUnbGu9p?=
 =?us-ascii?Q?Gen5+lue2eCHxcVssDFXt7z5RSQ0gewyuy90EGUftC/n/H47Gq5ERyktR7fj?=
 =?us-ascii?Q?iRYZ7PsygMdeBipnO4sQx7Crat4FdHhXnV4g3iGbpOqD8KbYsx8piYbsnkDW?=
 =?us-ascii?Q?1QR1/hPGlK/ZmmruTAHJ9e30iPs9v0ZwvT0eZzJwYXGLpkXLuy3b3jD8nMwc?=
 =?us-ascii?Q?SKeSq5PurMXWM4aLWqnJOHMAWBz1mpKPYrpwTuL3kW2SNaSoRUvBbloT3Ed/?=
 =?us-ascii?Q?G3mmxblzt17Cd8kPr4Hb95dzKR7CsJ9Q5MKqy/XWsXDXncRLiqL1QurtxV77?=
 =?us-ascii?Q?4ZlwVdUFP5Y5Coz63uO1G5FPhiyQGS9YaHIKPS9UlDx4lcMSYBTLIQVQyCd2?=
 =?us-ascii?Q?49uGcjM9/ZQ7rMWmh73BG8vi5Ew6lWMxZ2gQYSFdIxzO11aCr4sEU+HFASzA?=
 =?us-ascii?Q?bSyAyTuJPTG+SM6CD4DMCfL90GCuSbNnZioO4VidydBDMeUOEVYbyqhZeaGF?=
 =?us-ascii?Q?uS96ukYAkasXlPz4q9y19ROg4TSLWKcHGA4H3S9emdd7XH3s/A74iznrLmLj?=
 =?us-ascii?Q?bZg3HyQhAphsAU+NG4Fx2XHSr3Rrz2eGu7JUHT4yhEYO3vzD7bSj5jLudP49?=
 =?us-ascii?Q?735a0zeGs+ihiq4ci+WyumpwMZsbWYkfjl4g5ceKGpjEpLzceZXb4/bLVKdY?=
 =?us-ascii?Q?GjotbWbZl4bakbTq5CEjizcTNBEcI9pzX58ohdF21dNdgjdU329mwDBwuZ5P?=
 =?us-ascii?Q?fZ3js5f1VJvhrJ8PJSqbpXyg/qtw/K+XWj9VhBWWJ2YeufzwX7bDfyOLfkhY?=
 =?us-ascii?Q?T1X82teQ1Kz4nccjF2M7ATMoQeOdOGV5HwS+69CgMZeukunl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 079f6f78-0454-45a2-7454-08ded7593b77
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 10:12:18.3994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qK8ok4fK1f4X/BbqKGleouhXvhhUTEfAJLG/3Li/SXTq/O4vuIdFmKAgSz8Kzh1cVHc5ZF2Tt6pNdbx6JsNZiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4259
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303574-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:yuyanghuang@google.com,m:kuniyu@google.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:horms@kernel.org,m:jedrzej.jagielski@intel.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:xiyou.wangcong@gmail.com,m:xiyouwangcong@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,intel.com,vger.kernel.org,redhat.com,gmail.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:from_mime,shredder:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 369696EC0CA

On Wed, Jul 01, 2026 at 09:41:53AM +0900, Yuyang Huang wrote:
> Thanks for the advise, I will try to add a trace in v3. For more
> reference, the issue is pointed out in the following discussion:
> 
> https://lore.kernel.org/netdev/95adff35-ee56-49d3-8567-382ac17810b3@redhat.com/#t

I'm aware, but we get a lot of patches with various claims and no traces
and some of these patches are completely unnecessary / wrong. A trace
tells the reviewer that the issue is real and that the author validated
the fix. Otherwise, it is up to the reviewer to check that this is not
yet another false-positive from some tool.

