Return-Path: <netdev+bounces-303310-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id a/NlLrL9Q2rWmwoAu9opvQ
	(envelope-from <netdev+bounces-303310-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 19:32:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E386E6EC1
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 19:32:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=KPWnA4q9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303310-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303310-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0525C30DB785
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 17:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41683DCDBF;
	Tue, 30 Jun 2026 17:25:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010001.outbound.protection.outlook.com [52.101.46.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B9D3DCD8B;
	Tue, 30 Jun 2026 17:25:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782840316; cv=fail; b=CiX/nvmss6WKnUiIOkqBlAFoiGsUQ+YUynLaXT5Tvg1Med/ADt6Ufjeig6R0xLQnGsNnMRA0i6d2X7MjjJniZJMpOw5QezlBcQfdZj6wn+YAMCxYEOJk+5g2Pay2sGZgiH65qkApp+z+kOZjZjfaiJpAiceT3Rgq+V4IrOmSXiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782840316; c=relaxed/simple;
	bh=18d4Trp3gGceICHKqDGxmfwDEq4eFddKKiSCg0ykr74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=okdUzIhteJ1xwJLP8sBKuJuQcbmVLPPlgje8tQUovWRjGU2A/bifv9B6rwrRQ44g1jLQ1uW7UxUweedxyMOPE3h0dLcmdCEyPoP/0e9EA343BRD/xS4/m6rHZAtN9wrZC7c4GGJDRFR30e+wHC9BZ7WoAsydGg9atF0nq7h2KOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KPWnA4q9; arc=fail smtp.client-ip=52.101.46.1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qEin6eig3umFfkoJk/uJg/Ud3dGAMFU7dGXQ67IFlobDHvP60v0bVPxmeZZxg7sHPbiZYwRP9udnRPhNt8a0Yl6fJYP4akzjKA9HXKCICLqgp5ZQCyGn4xADfMxOP8pQluiqAdX4RTE2T6983533k0GkhEYZY2Hh+Sid/dmq7QszFa7zRqBg7CnPWsUMKhfPJ95IppTso9WFOI7cdlVzrVb5igocGApdTsQhO5rHieMeBoPxyA1LyumoIqjtiIEDkL7chBRbw+bzCxXcOP+NPxdfqDxgXQYFcdisYfpSyrpIou14cFuIb2YTuWh6o9gcn86/24Djv5HsMae+4TB3mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+LBD0MCiEuKDrHldQOHG0maRh8726e8Re1WExyYZsY=;
 b=qjof+pVHZbA9MksWhKTYogxDnDFS6Hl4xaBw0kry+N/5xVTxNHwuxuueeTmrONwFDJ300fRVc+n3XPDhHXxxSC6ruuPzWDMI8weivW9Zoy8mhHlHJLmfQG9n4c1WtWOUCvtfLnQZPwihdb/H1dsMPSmkrqHCpT2mlVgRrnVo9Ek3uNbz0DU7qqHBsi+tSVUVXpntaL8e/NyXi0WL3dlnvev6K3tO5gNb52bOUZuarjBg8W2c4aTyOrqzUcg39u4spS96knpaoKvgzsWuMYwkh4NrC3gxqXpEj5lCcxMmdNDo7N+MJL3raVL9bRsXaMN/xXfJVEtcPLmnhHuvhfMdqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+LBD0MCiEuKDrHldQOHG0maRh8726e8Re1WExyYZsY=;
 b=KPWnA4q9N2ujyHCf+Dt04zjlfa4M0trcwaQ+rea4ZYV1T4bLgngbIUXurp4i7GFdSeY+NbRTuOZIfx6/o63ukqtupjyaRqCHo/mVWD2sJt+0kWOZZgvxkQKnV83QmTNY+lK9+DR7v6gNeuCOgHATo6sSkIdraQ/qKHj/5703EhRHBebD4pGE4lnV2/ZtXGw/j57gA5QxHstteaXx76UUPi1FJDb88yMkMUVK3PItsZU0E52WC4mb8xG36lQYzHMJloBttk6p+IsOxW/YoajUFkoaPqbbXE1SoIdGlhFOYrCpgpCo2mA7PQA2oRQzY0taRq4hsyAAa8X+ChT8XJy6Lg==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by LV8PR12MB9111.namprd12.prod.outlook.com (2603:10b6:408:189::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 17:25:08 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0181.008; Tue, 30 Jun 2026
 17:25:08 +0000
Date: Tue, 30 Jun 2026 20:24:57 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Pengfei Zhang <zhangfeionline@gmail.com>
Cc: dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	chenzhangqi@xiaomi.com, baohua@kernel.org,
	zhangpengfei16@xiaomi.com
Subject: Re: [PATCH v2 net-next] ipv4: fib: fix route re-dump in
 inet_dump_fib() on multi-batch dump
Message-ID: <20260630172457.GA1236802@shredder>
References: <20260630084220.2711025-1-zhangfeionline@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630084220.2711025-1-zhangfeionline@gmail.com>
X-ClientProxiedBy: FR2P281CA0118.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::10) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|LV8PR12MB9111:EE_
X-MS-Office365-Filtering-Correlation-Id: 046c4ef7-bb9c-4a9d-504b-08ded6cc8853
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|366016|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	tea0gnkMdtAVuLCMZnL+aSw9Z0//5GwLyTjTEu90JsMZQWl0FYvEoANz/m0PS6AifrjcuL7jUjInI3YJ4H1rMEJ6jwzOgrYCehVvdj5gl/cYUZs7YzY9l8g6fogyxDu1g9fdGXp5nW4r+rHU1hkGOK9woRLnrxyS5J4lBOim2oJtY6fopC6m0mga6A8euLEYnM/Q5GsC7tZWYg/1ewakTtXkCJS06mNJNGir0zh0w7LnAgZIuOaMvACp/bePmAygpxouYIiiigJQoxMCBMcvjpcgBmT6zrsIEIki6pbKZPhvPSUwKp/MKtg3Wo74Je6pUrdNCVI9f0UGsawEVmlcDj1H3FWf7Mn00M7kIh+0juW13pvlYGnIIOHw9qo0/ZZHp9h5pYUe1wejOix2I8e1xykRVvxN5qgCs7hnLkk6OS+owUlz6Jbqs8jTWUc27/i8sQKBZfXbMAXyG2OAZ/Q6Z6DHQ3AaW7dUmxbZDgl66Mey3NY0VQTg6FkuuqeSGpvu4dp0RSq09gYsmXMVvAe+S8QnolLUr4PXdWb8zjd8V4uyV8qgHI8K4MOVWLBKM34Cveech/SsH94aXIf+T5zU1wlcieqN6TbRlU0Cd/6CYca3u/8hlL5ASo9Ytz/kz4uH4ZRJbvNtoJdL8cORJoj4z7D5o8e6znDRky1LpEG3/NM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zU6lbolzk1zD+6QzpKy+dYxykzqA26n436sg8XmSuD1E5OVV4IbMk2oZO8N9?=
 =?us-ascii?Q?Hu3bL4GPWS5zUZLrtDsCHaJEw4nY0zfiKNHDRq8DB4/i3QPSdq4R9NbwyG05?=
 =?us-ascii?Q?puT+ta2jmD7ZCLurY58p9I29fmFMAhoYmWpXcO81xaZfJ1r/rEA+X5L3w/yd?=
 =?us-ascii?Q?wR7EnJpMfc6bvgjiDQE815Tvmv7WXwr+64dOmvgNZTGnh76BzGk2/njDb4ZS?=
 =?us-ascii?Q?Iu5xE/qSUtdMJ5oCxhcDezPHcwq/a2JxCs0mQYR8w5GOXrqija7hDe0ez6eI?=
 =?us-ascii?Q?capVGsOcAImROHg6Y4NADbwSJ7jkxTjBWw4GQEoPPptkpyrMbeIX4tozTZp2?=
 =?us-ascii?Q?tM5nB/m/V7Dky1v8TACBiR4SylTgr/0ASxOGwgzClGXw6Am7XD0oFTYGPo2D?=
 =?us-ascii?Q?VjnnC01TXQIod5Gc1ATLznY/QZDjKtXauMxAS46DI3zRJlDUAS6mpbANDy2t?=
 =?us-ascii?Q?5wJEM7oIWlO4h9MjM7JozMJDuNyIycxEDa47c8zaAnCBF0kZNtcTyJ4C5qpR?=
 =?us-ascii?Q?Jnf3XISpef4SmIdfdXVXvfEuDaTIBWIGi98NtVQ/Y16KU0Nbn28eAINeMjhU?=
 =?us-ascii?Q?EinZh8jpafy2vgeY6sqWx9QDdbIQFtvzccB4r9nIQF6gUrnKEa36oUUmEiqB?=
 =?us-ascii?Q?qMX4GbH2Ln2qN/gvyXTGUbJopa68spw3l4gSrA1Wan8QeTS65fsBPZ9uoCTS?=
 =?us-ascii?Q?k5gVGE7Pu8eadO8Gz1B+HgMaaP0HI2PM+hISiwO4WGN/liWYD3XoQma5oQK/?=
 =?us-ascii?Q?drz9O5vVnLb9oxL4F7L9VOMOfCj/OXfbhdq+D96akN1MlT2i8O0LHLnaeBnI?=
 =?us-ascii?Q?6Qckz5E8873szSmPL773Bs7aWhW9v/7vUR1CEMFIifEzqPQ/EGacS+FMbRpt?=
 =?us-ascii?Q?p2pXY1uxSfxtrkwujxdgwe3GIqDLpy5pmiEBAftFuQoVCxVqSnkVQ1z5DXAd?=
 =?us-ascii?Q?cAuZdA5ivmZa4vhPxGIpeo2MLFbOEHwGT86jO41cxJ9xHWd+mX9Co21YfMiE?=
 =?us-ascii?Q?sQ3Yi6nGKsRJWA4rMUwgme2Tqb8qmBp08z/joZ3Lvip7gPNqM+6rNVzdUKgE?=
 =?us-ascii?Q?Wzs14HWSyn6BKY0eRQltG7Lq/oO64tvTQdKuYmxCd3ND8anEZmJ/aPSt3Tpd?=
 =?us-ascii?Q?qgW+kgCLB2tBG/GiY5TDiSm6UBVNAxm7zrbO7fTv/UpHoVaC3Ti6Ov1RvA+i?=
 =?us-ascii?Q?FEiRjSuRQRpd24Ei2KiHTdHar/1wkepKA53wrvTJ/JtUMUvOFf0DzzKDDmGA?=
 =?us-ascii?Q?HOb5yztUHX41d72m+zQ9gbg1MJ2H2ovM94GdLZAAl4uD7VD7xjGFyZvdl4a6?=
 =?us-ascii?Q?CIuyrSuA1F1SY0ZtYGC6Ma66aKe7guqFyTXjaRG0dO5dLAOF5u4WkHEssROv?=
 =?us-ascii?Q?F4tYqPSw6s3V7Fp3e83/tDO1HUidxwZV1VZAr/n+H6aBIn3VOL+qSpQEmGT2?=
 =?us-ascii?Q?OLXLSuyoBXv/8a44YbqFeMpMzet/H0irVc+nCK77pQ2Zh9oyb5p04PJr0Lig?=
 =?us-ascii?Q?u9V4X8FiQe7m5Yu8mN9SqdfVfF8KgYyMT67h+gZvhIghn+BieuRoS4Ezc7UD?=
 =?us-ascii?Q?DhJW2WZVf/lBBDyUKKg4ahNcDoPQPHeHSezkmmSz/Tg3vXNr6MQjwki3bMow?=
 =?us-ascii?Q?51ipf8PAIWK6JVA+/dl40Lc80WMBJjypKx9pWviupltLoKeAdDJrScNgMgfV?=
 =?us-ascii?Q?FQL+E6aYGu3uPpyaDGAdCmRdVZVZZBuaNVtmIWkKg9m2B9sdLxjbNxmcKlLt?=
 =?us-ascii?Q?laLhZ4yO3A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 046c4ef7-bb9c-4a9d-504b-08ded6cc8853
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 17:25:08.4247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YOg/92QlPgjbDsoxFaA6WDRC79Qj63vIt+urrLNr8PDH7jIfSYXAHgKaeGiZn3fZ6Z+BvZhSt4xHHYJeIyrNmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9111
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303310-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:zhangfeionline@gmail.com,m:dsahern@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:chenzhangqi@xiaomi.com,m:baohua@kernel.org,m:zhangpengfei16@xiaomi.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,Nvidia.com:dkim,nvidia.com:from_mime,nvidia.com:email,shredder:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 03E386E6EC1

On Tue, Jun 30, 2026 at 04:42:20PM +0800, Pengfei Zhang wrote:
> inet_dump_fib() saves its progress in cb->args[1] as a positional
> index within the current hash chain.  Between batches, a concurrent
> fib_new_table() can insert a new table at the chain head, shifting
> all existing entries.  On resume the saved index lands on a different
> table, causing already-dumped tables to be re-dumped and the
> originally suspended table to restart from the beginning.
> 
> Fix by storing tb->tb_id in cb->args[1] instead of a positional
> index, mirroring the fix applied to inet6_dump_fib() in commit
> 9facb861dc6b ("ipv6: fib6: fix NULL deref in fib6_walk_continue()
> on multi-batch dump").
> 
> Signed-off-by: Pengfei Zhang <zhangfeionline@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

