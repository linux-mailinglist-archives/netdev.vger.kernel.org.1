Return-Path: <netdev+bounces-283546-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPGsIJfo9mnhZgIAu9opvQ
	(envelope-from <netdev+bounces-283546-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 08:17:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0CA4B4927
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 08:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59E0E3009142
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 06:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713B93A7F78;
	Sun,  3 May 2026 06:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sdntxNjb"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011022.outbound.protection.outlook.com [40.107.208.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1D22DF6F6;
	Sun,  3 May 2026 06:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777789075; cv=fail; b=VBwQf6JYz+oxZJMOSrGAcwg8H+MsPSNtRmY6lbltcp9nhxZ7aFvFw1EBRIftrkHtIYNijaksmQAuF//8fkZPAs1q2N5DWy1GG2RFOzLzKIcQCyE37NzQCLBRVcD2lcxLV7OwLBhc8388JoAfyulMNZo+cH+GhsmdyKNjmq4t0oE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777789075; c=relaxed/simple;
	bh=K2OX3injnGrAX95RtVKCJdJsWqc4mG98L93kkuMLIDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=plp5ZbVzUxhJF/axFNMLbJ2S0qx+3tGekSdLdjYEtTs8VePKNIidA8CexNStHLDcV8z709Qyw+5HSshSRpiluZPQPIkaeKWq4ofxTgmv5Dt9BHgNiLL6BZsjqt5PbpQoP3142vTpFx+TedxamnlAPhrD3wGWxwT0Iumf5mOHjgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sdntxNjb; arc=fail smtp.client-ip=40.107.208.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V2KGUxP8hkcpOdXffHqCQDvA/NyWGXp1cf5xlXIv+Kl9vxdtTvRjBq8DtSvc6jlmHeh/qzqKCC3RlgMV/q21vIz23EkzOI7iADJnRqvmv6skpTeoMHufnTLqHEHSfD3YjNHkuhjw92Bf6QV2AoVJL/CMBWvKLS4d3FCoHrMuDji6ff0mvQ+EOtXuCT95W+01BR/yaLQgv0cuaEKKNuLJPrEnTc+mwApCIStq2bu81yTDdRapvU7ndkvbwZzMqiIUkGDVPpTXBfzNLfr4NVGTym3gU50OVgANxni3QD0YaT9RR0Crc5gl+f4lxRpsB+clOERNUMEKe3D9wtWsYzbS7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srOsfNgEh5YCATa+U12uckKXA0FD57Kw1lLB3IUfVas=;
 b=ymK15fyh0QynwHK1Hu7JjjSr+QJaQ4/OH55WDJlT7XE+rdgM0t1sEvfcJfLbmz4T3TtRyX71Mj8Oq01Fx6IiINbk0BkgyZlhEwh/oDyMMTO+Pb5KWr+opeFnmWHd+dwxofnx91dO8JS7hCH5+fX5bTl8g89hgkariMItiyiO9OuK6mvkpQMMvev4PbCTpAFqNkK3SgpKxs6GNIUkltKs0FGMbp88Q7ZDYeuHuJ0tSlgqDCmKXDWf8jgmpreoWIikbKGlAdGMQPUOrmb02Lzsz8hyS7W16c6saTdVT19zx0qVR5RTAFTHwaSh5+nMpfr63tbr39sglX8Qp0Pdz3Gcgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srOsfNgEh5YCATa+U12uckKXA0FD57Kw1lLB3IUfVas=;
 b=sdntxNjbOodgQwlbpUBAGql/2NQ4Z0FIlDR3+NajtR+nYztxnzAtLxEmbVlVvem/IBc28v0y2UXmfPTZllQF+z9ohbKNEVIFOPMhIqeA5YTibHEfkVa7muOlJmPOv7WX0m4Lwk7rc7I/Ed5ZK+sh/vv+442fj0zOax3yKRFw8h7jPfygaOE+HWwqGhdcOPuye2ip7tALXFGzkioKtiKR+PjOWmBsHcnBzgyGTr3FZdcobb82rdSjs6iSMpZHmqIxrY2tVBU+1cf/QZYjhIjdgd1Ok63Rnoemk8wUpHzpB/5/qBp+KskNVqvOG37r20bXkuupU2ddQZRpn/0swrWDtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CY5PR12MB6430.namprd12.prod.outlook.com (2603:10b6:930:3a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.24; Sun, 3 May
 2026 06:17:50 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9870.023; Sun, 3 May 2026
 06:17:50 +0000
Date: Sun, 3 May 2026 09:17:40 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Vastargazing <vebohr@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: net: fib_nexthops: detect kernel splats from
 torture tests
Message-ID: <20260503061740.GA98182@shredder>
References: <20260502122219.262611-1-vebohr@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260502122219.262611-1-vebohr@gmail.com>
X-ClientProxiedBy: TL2P290CA0027.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::11) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CY5PR12MB6430:EE_
X-MS-Office365-Filtering-Correlation-Id: 32b878d9-95ac-461e-404a-08dea8dbb3f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	CeZVUk69sDiUl8gtj5N1kZ1TmM8NyvX/mAh3BFMAHH9f13WOqew4HCgwFj1ibG9ZlWYGB50R3R6Rf/0lFlKaOg307qzCmp6SWpVky0p3wb92OBHtDPCC7pO7g35SIH0DDFdnNZFHEqbLkPnCOEiA/DiEQVtjpcRP9MropFrRzV4b6BK1lI5HYnVXxtAacSCUsZMI/ilqexFMyShvbdn33+VzO56icHG5gGxXNzBj8tfvtlK+ZPSCRrktxCnD+yjqxn3S81S78ZENaduvXPmeJ+KaBrk1yTUjIrZeB4dKSUomoKuA1/O3LLCjR2UaC+S5ynE3LkYBWtdxHTRs5cY2DJYCfRZ3118JnM7pJY1jGctDZD1XHy702GDa8E1HU5lhfP1I9G6gPb1KruakTBpLJ11zB7SONOgUrJwJB7xSIyq6TMlFk/6Hi+p1Mrbs4wDyvELIqkC81Qg7JCIRw5Li+9nO12PnRPk3ThSKP6WLujvIwP2BmwuCZsGMZYyAUcZizVvKPbbJSDFgGliH6iS6ptZNtc3JDd5gSv+vswCGv21Isodu4fEyY6CVddhz8GNOZjDFFiFrFMHLVZ0Hd6dnEuZ6WZIcxLZnGjM+yC4MAHtmZ+ZdwDHPjn2L6eTgokvI5aIUUS25keABfBBQc3bnhrWkP7aJyQ4VpEH4SjKlCus59jiqwbg8QhsBNFavPNLa
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/tTNOm5pqiD82yhbXEDVXajyqI4j8j5JO3VxIPAq73BHI53+QfvskU0Aa6cw?=
 =?us-ascii?Q?OpHM4YfgLO4OIIrM7/VmDUMqgGGB/aFTgNt54lKg6NtKkFASdcW44IWNdnB2?=
 =?us-ascii?Q?qCljBCVM50ChYG0P/H9OOc8ivytIVuTX8aPWORcKWIfmMjZZ4LlyPUWE0sKa?=
 =?us-ascii?Q?qrLKnhyY6H5h4b35xeW6hqqVTyZ+5Wr6zIlU1RWoaJtjB4PVcQeRZqgfKvKF?=
 =?us-ascii?Q?NIRf0vWamCMoq0Y5/tCzN4PWUSWllSyTIqdm9/l8cNZdk9z5sXt6PqgCDrjW?=
 =?us-ascii?Q?n2J3taZyzpiG9/VlkcVBxo5bWKr64Mjo0vRSLbn6wHdEAUtpR+W65If2MJC3?=
 =?us-ascii?Q?iFFydAaP4rk/vmzi0YD1ZbdCu7n/D3PBOfFD7OuIA0as2sscxs86CUlWdUMi?=
 =?us-ascii?Q?n+ke9XOy73E4aY2VI9E/Q2ALw5pgAW5tU0G92xfu8Pixf7JQMERPOyzpoDRy?=
 =?us-ascii?Q?CSlaLeEV10GIv4l30cmFC8q98P5kELJynPgvDsi/4oUwv3zcchvIN54FuI5I?=
 =?us-ascii?Q?PpqH6TpztHDAdNeqkRjLB2006pcpVYKL2xcWmxBHnlGI7yVLIwuqPcsqTbBb?=
 =?us-ascii?Q?hHv033vIoDxZjEQCjT9rVg9VtpVuzhHdQz8t78RJzYUZtxsE+WrqpRlbh+yE?=
 =?us-ascii?Q?Ku6SPtKtpbT2c27LT0YeQht0K7g/TDSsBLIT3nwaV41noOLCxEuVvY4QF2jw?=
 =?us-ascii?Q?d8POhGIRhxUl+UTSPDaDOolgbCf0agIN62wmeBBOitiXy38cU23FDsvOCxHD?=
 =?us-ascii?Q?a1Cgg3YRON/qOz+86LQcF99TBgkrbl4j+j+O9YLrPRGpYLURGT86v9WjQ0RV?=
 =?us-ascii?Q?BJwrKhQKecgVG9eacWUv8jR3qxwodtNd7Qya0XW/88YM5Le1FQQOHkWyBrhM?=
 =?us-ascii?Q?v0rybOVCUvPeWfUvJ7E8l6k51vyjxKPf23mNmzq0V5CGXkP+fdxEnyhbHPNq?=
 =?us-ascii?Q?pY881puJxkJq3cWmFpcyXgcyON97HUwOpvP2Jcy1RXm8ekp8S/ZbHHNhh3Nd?=
 =?us-ascii?Q?nOE3zVQjB6kx3mMIGo7oiLXpwdIth29k+NnOVWDBHJVsMarz0l6jByA4EJka?=
 =?us-ascii?Q?3tlxi2ATtv6g+FtaFAHVnJyiGCkIgyeoDyNoaSBddr05wqLm5QCVVKxzrvzE?=
 =?us-ascii?Q?POvUlHW+IBl1y8mTeU6v29UNnJn6JLTxBVKP659dfJ/HKJQIOkSeWXgY+Bss?=
 =?us-ascii?Q?73LhhRnFvstpSGUK1V5Y80DS/8Je/WR5P/qVwU1lN1yqB7gR6DWl9ST2Eukn?=
 =?us-ascii?Q?aEeZmTcjDd50KLeJJGd4xpzNFffdi7o2ayrtBCwZtPvXljtLqBR7/PdGGlyM?=
 =?us-ascii?Q?oSczSrAe57sg8mMrvJIo1kyQimGuRugDI3GCCe2UGrEdGZPssEgOjurxLUeC?=
 =?us-ascii?Q?pue0OBgpQ3BrsIwbdy+qd7sTY7CEc9rsXwWuMvFYoKQTksIQReL+47e6KX0c?=
 =?us-ascii?Q?UW9CxiYwVBoEWJ4q4LTGli95uZAmqypatiYWQtJm8TzY/fKWeihazMbiSBuU?=
 =?us-ascii?Q?5SwydgMge9X2muy+ar8CaXLCaBF2Yjr6jLQ3FZPuX42CTvU525DVu/R58IvU?=
 =?us-ascii?Q?t2nYub8vZlggXbFIMV7PMpJeozOJChcvJeiZ5Asdin+hAHiKZcS3er7yly04?=
 =?us-ascii?Q?27hBd434+gDsgzgLZHft5A8U1r+4PLwkbhJlcwoncW7N+fPApQmvCg3MbG/E?=
 =?us-ascii?Q?t6wgc3L6arkDfmesTEpWYi5lVpwSnpoDjeiXvyofweTYBSmN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32b878d9-95ac-461e-404a-08dea8dbb3f6
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2026 06:17:50.5136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zx4DWTCdhKIZKB1x2Q3Vi+1dFrH4HFLjjRPsFH4hmOARhi4V0JJf0tiTdjk0HLzlbIpbJ7JhqFCbmEtc0rimXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6430
X-Rspamd-Queue-Id: DE0CA4B4927
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283546-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Sat, May 02, 2026 at 03:22:19PM +0300, Vastargazing wrote:
> The four nexthop torture subtests delete and re-add a group member
> while ping -f and mausezahn keep traffic flowing through the same
> group, so on each iteration the read side runs nh_grp_entry_stats_inc()
> while the write side goes through remove_nh_grp_entry(). That is the
> exact race fixed in commit b2662e7593e9 ("net: nexthop: fix percpu
> use-after-free in remove_nh_grp_entry").
> 
> The reason it never tripped these tests is the assertion. Each subtest
> ends with "if we did not crash, success", so a KASAN splat without
> panic_on_warn=1 lands in dmesg and the test still prints [OK]. The UAF
> above would have been visible to a KASAN run of fib_nexthops.sh; the
> torture loop just did not bother to look.

Do you have a trace?

The netdev CI and our internal CI run the test and look at the kernel
log for splats. Both did not flag it, most likely because per-CPU
allocations are not covered by KASAN.

> 
> Drop a marker into /dev/kmsg before each torture subtest, grep for
> KASAN/UBSAN/KCSAN/KFENCE/Oops/"kernel BUG at" lines once the load is
> killed, and fail the subtest with the offending lines printed if any
> match. The check is skipped when /dev/kmsg is not writable so the
> existing pass behaviour is preserved on restricted setups. No new
> TEST_PROGS, no new test mechanism, just close the assertion gap.

I prefer to avoid such random markers and rely on the system running the
tests to catch these issues.

