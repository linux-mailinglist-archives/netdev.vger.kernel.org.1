Return-Path: <netdev+bounces-305790-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id H2WfHZtCTmpSJwIAu9opvQ
	(envelope-from <netdev+bounces-305790-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 14:29:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 714367264F7
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 14:29:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=abDDnre4;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305790-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305790-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5C16930011A0
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 12:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAA443E492;
	Wed,  8 Jul 2026 12:29:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010053.outbound.protection.outlook.com [52.101.85.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE763435A83
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 12:29:07 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783513749; cv=fail; b=bMUya0mDH1VekiSMaUIjFhYEUFnFgiaTaXce9ZcUyFXFdR/E6pim72KhnK8BMdECZ5kL2sQlOEf8Im7iLPXCIvokOcu2cPuRgVTCvdF/9GqV0/xLzo+UNSeiz+der3Z/e7DIsFJYO4tQLk3YMC8KpR0i2Vebwmn0RPtaXyqZD2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783513749; c=relaxed/simple;
	bh=cxslQo4IdbluiAFHUyLHcRu7o4cmz46hD79YdlZbakk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B6CF0rCBfaxYITcQQe75MDDI3E8NN6UDD5olz93BSRFJFfJ3RjSHwlXOh6WiJtIXGmqzy9piFNWn7ai0NOBafZxhfo5wrlrzfJPdSn1ZvPUudwHIvryaSexqPAF2ArlcYwrLXEutHSmQPCmPfh8uwdBARKjtOv15ra4GFWMkss0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=abDDnre4; arc=fail smtp.client-ip=52.101.85.53
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fXz/yjj2rQqDgFdmUH5bv4wHLMfKKyQ7qEAuNUuMPlbpn13hHHP1vuBb4RcoP03ziPPRVDr6AZbqDJb385X0NvYKYhJKVFXpFp7oZYD5fJH/YnimaCelxS+6P9JDdbhE3JWVt4eGK3fPyCLsvzHIb/ZgKbgwthpC1mCL7zFXCYUcGBp/5lx4rzhbcm8WVPDOHap5xcXVt9Wza8EyR88xHwLHw7Wa3AfSq3Nq9eHFfCOFGDT69adzDgxT9CMRDZAQNjFG/6qkRnMDKUvuR4yPHQK+TVgDfUfpaJ+hzXmW62DYTozlRRpqiWyHv2GIiJ86nq1YKzP4x9sKTbBfJg8bDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ONfYazt/fpuAmfCYa0KQcnoXRNXia+T7ckh3kbQy2jQ=;
 b=lf7xALIiD78RheDUavJzad9SqbvCXV3QStVimGbPNkc5g17VnDv4fmogrNv4fFJfZ57F/xnFh5ZIRQRUJWGLjijeV8NHEeb1SS4fNTGJ8+q+QQKORhP3gHDEvKVJSRCvU0iqX7sedca2MU21aBcXeC+tMEgnHHaSKBn5q9j25LwvVEosYpp2OlrnqnRD6lKC0lkn/Rx35FErmTw2mbHZ4wS0Fx4abDql8BefQNGxgmpFQqmkXs30wXtJxBgaQA+uCxVXPCFs1bXcnq87HtU8qnaZ4b+HVNxpwnAVRl37kLGx5gS78Y5VfZ58RY5fqc5Sn611J+L8EKeGPLxRkZ0FJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONfYazt/fpuAmfCYa0KQcnoXRNXia+T7ckh3kbQy2jQ=;
 b=abDDnre4cYaRshNN/sY2wEjjHx6fPuPyD0B1d1aWLHapWXpYjN0tna6Wc5nheUbIhoqgnTMjTMO1KUS1aqjcjhqKUAWGZIp8hZYkrDVluc5GPthjplRcmmxu8eHyA3RGIIVC4ECWsAWHBJxdu/ybGKBNmTKGcFjcplbNTLz3jun3akIDCYFHTH2waMQu/wP/MOzwb7f9ZNRD18e57xl90InQrvvMY3oCdRaJG2uWQfqqpfq+mt4v2AxKt3hU6w/F+oyoKne+vAKoAwN9fHGM2pRqJyjxdnV2oeest5EabGchBpk2j5ywKkNU0rdzQo7AAOtlIVYkALZX1Z37+1aZTw==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DM4PR12MB6637.namprd12.prod.outlook.com (2603:10b6:8:bb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 12:29:01 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0181.010; Wed, 8 Jul 2026
 12:29:01 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org,
	bridge@lists.linux.dev
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	razor@blackwall.org,
	petrm@nvidia.com,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next v3 1/2] bridge: mcast: Fix a false positive lockdep splat
Date: Wed,  8 Jul 2026 15:28:19 +0300
Message-ID: <20260708122820.1298718-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260708122820.1298718-1-idosch@nvidia.com>
References: <20260708122820.1298718-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0009.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::11) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DM4PR12MB6637:EE_
X-MS-Office365-Filtering-Correlation-Id: c27a8dcb-5918-469e-71df-08dedcec7d80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|22082099003|3023799007|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	5mxa41wAxJiA0XL+veF3AahTwAvDLV69vIHJm0q5LxVWBs3kDZ5QkRzaFEM4wuHnSHN/phSqfvUeDU/5V/VWwmZ84UQBDdzJxeatiJBF4MrJrMTZexZZsnGBKrq5Du+lPU1zQFZU0FzPv4kjhhbfmu7hA3VojhbUulBZyI16cLVmFXQ0+6IpdZEgGkSMcjYT2108RYVT6t7/tH8j0BqJgln1yXvRIcR4Cr5SgEaOtI3RqZezdDl/6zk0witPcvs/BfgCINqi29haRSi03QTNHa8Qby7Sdyhb/21aYlJgE0V3gPiqn4EgzN0b4mQll1GUQiGOiHcqn4K4LDTpM0qo3EdKQNZ7t25P9AfjTox2SHTuhG6HNO2wWIkrtGffxRZOcTqhvxdpJcv3HRqwfJUzHelmb6KEJG9c1wnXeqpNzLTaGbmlBjiy6aK3IH7o4BzPPo/6Uw+Xa8fvumaULBow7sCT+gCYOHNxY0n9ELjVj0p/iGeNnsOIAPBeJEznZw14sMLJdy2ugzGrNDO4oyXNJjN2n7SvTZMo8rokBziGszvLdsH6/j5ikfR8ew4uKox4iqwv6gVDyi+JLQG/uk/WpJAbFYZNCmt/7883nr4DqOgjKav4wgjbRn9e+Jc0kyhbYXch8LYZxWleVg6ahqJmD6ZSHmjrvh8vhxl/3ZWrUP4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(3023799007)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dpTxIjVTWDw06xt23OFPhCy9iuiGrbXlceKSOOcVniGVzks1CNlj/rdiKsxl?=
 =?us-ascii?Q?Hb+iJ+Tio+VZPRqiySShKSnxoW+EiwaQDZbe7cKxAyb8tenTU56GqK6d5/4e?=
 =?us-ascii?Q?7z5WMi9r7E7tfa6nCx8elVpolPQ1Ufbd3o+0DnMhArHHrnW+ySoEDKbAaX53?=
 =?us-ascii?Q?8NyjFTXYIQsGPirZ1se9Tyxi+bicalDGLk58gFSveSw4ChyItmM73lxNtX8J?=
 =?us-ascii?Q?GXTTRRket/a6NtwFOFtonD2KfFmuMFmxglD0P7vDSrQcQLgTWMEGA4QO+meK?=
 =?us-ascii?Q?HXXisY6anSgW9aTc/NMGL57brM//OBupaK5v1LkeRnnM3MG3otP0fI5SPyop?=
 =?us-ascii?Q?/v9oDYmPIqxsgM+a/4YCOKimG2T9Z832q2befuIZLT6VOo6s1ZbEG13TbsMP?=
 =?us-ascii?Q?TvzQQwGm73MTWfQHNvFxNFYrs2p2ibAdyob22wlaPB6rmRd3j3sNFxAwGRIh?=
 =?us-ascii?Q?5PGdNrnO+7mT/y3i0XlyLU0fIPoL/fI6T0WDWBMPcTbVU1x2OPDbt8NF/8K8?=
 =?us-ascii?Q?UXkOfuyXESPbqcQUXOy1qcp142Bw+HyFIdH3zAlOsgzNkkl+ZOwxu6CAIkJn?=
 =?us-ascii?Q?oW2+q8OBdLC1RJTvB1rkUxacu4V46EdgCjUFfrG3xYZKqlkBovJtMYgLFGFl?=
 =?us-ascii?Q?enMOObhHI6SkIYwDSJnWXTEXUR3WeQrVlZfzWC3ca75A/evGIsvLRSeEN5HK?=
 =?us-ascii?Q?9c2dk52mS/UZDbHqwbdAzZTY7N4OEg4zvIW/Ua0u9Yz/wv+EYATkOW4thJuZ?=
 =?us-ascii?Q?bGzejHKu0AnXJPrHLTRaWtTLvCf/gfCh1zA8uDDcs0Z87OaThqCu0sCjFiSD?=
 =?us-ascii?Q?zDUx0g5HOHgEuP4sJQh/txdQX3x0ehjb72Bd/92S7ABxZer9hOt3d//TKaSg?=
 =?us-ascii?Q?dAPG+c3sWBbvma9LjSGhkG+Idjr2JWbDwr5t09TnXsbmRIw1Kt3nbIwGoNgW?=
 =?us-ascii?Q?KDxrMaUBXNuKXQMWdHBfjLodcB8C86QDjyxQYjmDVKDXMY9wJo2EuA+mFDNy?=
 =?us-ascii?Q?R/K+IH3b7+nhaMDarcgR32qRuluDpEPcW6//gsfF0ZHwUVI9vtu0CdGPIsk1?=
 =?us-ascii?Q?ATbFV1BwegUinEaJctKT2sk1f/EaYvU54q6dBRvxAAq1WTzHL+loVLxsteTS?=
 =?us-ascii?Q?Ax1hf6KF99b1Re4CjXRj7FeBXGYUxUfiV4j4y0soXhtEHiUmvDbSfvd8Cl/C?=
 =?us-ascii?Q?/ckTMNqSMSUEsFV0k/+Y3hscG0gE1VCWuT9/ndZKomWKarKLsiCHszDjX1bQ?=
 =?us-ascii?Q?lMAwLlGwgp+Gxy5IlbzUhYgovfOdVqr2cjGhHciMnq7kXnp9nlnX4d1+oCEL?=
 =?us-ascii?Q?5vSDJqAJ0Lm+eR5fZe2oD/m34bHQAlbb1QUQ1MeXQ2h5x1J5cpX9RH7yZULL?=
 =?us-ascii?Q?782/yrS/uEJHrS9roSPNoiWDr6g8MwC0/evj1aWzrduTTab+Ts6+8463buVX?=
 =?us-ascii?Q?Xm7YT5WWAGnRYxlwxkbtvRegiy8UxceNqG1T1QfHSXY7TV4HwLcFS4oculvy?=
 =?us-ascii?Q?ncHQLGWk39/nJwfJDKTq4JAyA3uSxD1ht1DuTosWC2YWbKimY2IurFiPnnAB?=
 =?us-ascii?Q?PcHviIy6zr0NHAI3Z7zGQd9U5LiceTFf8gMfEq4mGOII0Drd2tmDp3jEISpc?=
 =?us-ascii?Q?pvolerE5LfWO7qATl5ye4rZLrrIPXLBKnhZ89aXoEod9wl8wZ7Pwwv71Dku3?=
 =?us-ascii?Q?0B6xlzgWENzOengtEZJwa/pEuxeGvPZx782rO1o4OU3xSSEC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c27a8dcb-5918-469e-71df-08dedcec7d80
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 12:29:01.1020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FS7Q451V6Ql70xgfD5UTqStYPKiVS2MVOY3+wnigpPVYHvzA3S26Z8bnceaE2WB2TxvVutFBQxo0Qj1sO6yN+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6637
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305790-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:bridge@lists.linux.dev,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:horms@kernel.org,m:razor@blackwall.org,m:petrm@nvidia.com,m:idosch@nvidia.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:from_mime,nvidia.com:email,nvidia.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 714367264F7

Connecting two bridges on the same system [1] can result in a lockdep
splat [2].

The report is a false positive. Multicast queries are built and
transmitted under the bridge multicast lock. When the outgoing port of
one bridge is configured on top of another bridge, the transmit path
re-enters bridge code and acquires the other bridge's multicast lock in
order to snoop the query. Both lock instances share a single lockdep
class, so lockdep flags the nested acquisition as an AA deadlock.

Giving each bridge its own lock class will not solve the problem: the
reverse topology would produce an ABBA splat with the same pair of
classes. It also consumes a lockdep key per bridge.

Instead, fix the problem by deferring the transmission of the queries to
a workqueue. Build the skb and update querier state under the lock as
before, then enqueue the skb on a per multicast context queue and
schedule the work.

Purge the queue when the multicast context is de-initialized. At this
stage the work cannot be requeued. There is no need to take a reference
on skb->dev since the work cannot outlive the bridge or the bridge port.

Use the high priority workqueue to reduce the delay between the enqueue
time and the transmission time. With default settings (i.e., querier
interval - 255 seconds, query interval - 125 seconds) the extra delay
should not be a problem.

Avoid the unlikely case of the queue growing endlessly by limiting it to
1,000 skbs. Use this number for the simple reason that this is the
default Tx queue length.

Use local_bh_{disable,enable}() to disable/enable softIRQs and migration
in order to avoid corrupting the multicast statistics (per-CPU
u64_stats).

[1]
ip link add name br1 up type bridge mcast_snooping 1 mcast_querier 1
ip link add name br0 up type bridge mcast_snooping 1 mcast_querier 1
ip link add link br0 name br0.10 up master br1 type vlan id 10

[2]
WARNING: possible recursive locking detected
7.0.0-virtme-gb50c64a58a90 #1 Not tainted
[...]
ip/339 is trying to acquire lock:
ffff888104f0b480 (&br->multicast_lock){+.-.}-{3:3}, at: br_ip6_multicast_query (net/bridge/br_multicast.c:3584)

but task is already holding lock:
ffff888104f03480 (&br->multicast_lock){+.-.}-{3:3}, at: br_multicast_port_query_expired (net/bridge/br_multicast.c:1904)

[...]

Call Trace:
[...]
br_ip6_multicast_query (net/bridge/br_multicast.c:3584)
br_multicast_ipv6_rcv (net/bridge/br_multicast.c:3988)
br_dev_xmit (net/bridge/br_device.c:98 (discriminator 1))
dev_hard_start_xmit (net/core/dev.c:3904)
__dev_queue_xmit (net/core/dev.c:4871)
vlan_dev_hard_start_xmit (net/8021q/vlan_dev.c:131 (discriminator 1))
dev_hard_start_xmit (net/core/dev.c:3904)
__dev_queue_xmit (net/core/dev.c:4871)
br_dev_queue_push_xmit (net/bridge/br_forward.c:60)
__br_multicast_send_query (net/bridge/br_multicast.c:1811 (discriminator 1))
br_multicast_send_query (net/bridge/br_multicast.c:1889)
br_multicast_port_query_expired (net/bridge/br_multicast.c:1914)
call_timer_fn (kernel/time/timer.c:1749)
[...]

Reported-by: syzbot+d7b7f1412c02134efa6d@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/000000000000c4c9d405f2643e01@google.com/
Reviewed-by: Petr Machata <petrm@nvidia.com>
Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_multicast.c | 87 +++++++++++++++++++++++++++++++++++----
 net/bridge/br_private.h   |  4 ++
 2 files changed, 83 insertions(+), 8 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 6b3ac473fd22..e39494b26ab1 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1774,6 +1774,64 @@ static void br_multicast_select_own_querier(struct net_bridge_mcast *brmctx,
 #endif
 }
 
+static u8 br_multicast_query_type(const struct sk_buff *skb)
+{
+	return skb->protocol == htons(ETH_P_IP) ? IGMP_HOST_MEMBERSHIP_QUERY :
+						  ICMPV6_MGM_QUERY;
+}
+
+static void br_multicast_port_query_queue_work(struct work_struct *work)
+{
+	struct net_bridge_mcast_port *pmctx;
+	struct sk_buff_head list;
+	struct sk_buff *skb;
+
+	pmctx = container_of(work, struct net_bridge_mcast_port,
+			     query_queue_work);
+
+	__skb_queue_head_init(&list);
+	spin_lock_bh(&pmctx->query_queue.lock);
+	skb_queue_splice_tail_init(&pmctx->query_queue, &list);
+	spin_unlock_bh(&pmctx->query_queue.lock);
+
+	while ((skb = __skb_dequeue(&list))) {
+		u8 query_type = br_multicast_query_type(skb);
+
+		local_bh_disable();
+		br_multicast_count(pmctx->port->br, pmctx->port, skb,
+				   query_type, BR_MCAST_DIR_TX);
+		NF_HOOK(NFPROTO_BRIDGE, NF_BR_LOCAL_OUT, dev_net(skb->dev),
+			NULL, skb, NULL, skb->dev, br_dev_queue_push_xmit);
+		local_bh_enable();
+	}
+}
+
+static void br_multicast_query_queue_work(struct work_struct *work)
+{
+	struct net_bridge_mcast *brmctx;
+	struct sk_buff_head list;
+	struct sk_buff *skb;
+
+	brmctx = container_of(work, struct net_bridge_mcast, query_queue_work);
+
+	__skb_queue_head_init(&list);
+	spin_lock_bh(&brmctx->query_queue.lock);
+	skb_queue_splice_tail_init(&brmctx->query_queue, &list);
+	spin_unlock_bh(&brmctx->query_queue.lock);
+
+	while ((skb = __skb_dequeue(&list))) {
+		u8 query_type = br_multicast_query_type(skb);
+
+		local_bh_disable();
+		br_multicast_count(brmctx->br, NULL, skb, query_type,
+				   BR_MCAST_DIR_RX);
+		netif_rx(skb);
+		local_bh_enable();
+	}
+}
+
+#define BR_MULTICAST_QUERY_QUEUE_LEN_MAX	1000
+
 static void __br_multicast_send_query(struct net_bridge_mcast *brmctx,
 				      struct net_bridge_mcast_port *pmctx,
 				      struct net_bridge_port_group *pg,
@@ -1783,6 +1841,7 @@ static void __br_multicast_send_query(struct net_bridge_mcast *brmctx,
 				      u8 sflag,
 				      bool *need_rexmit)
 {
+	struct sk_buff_head *queue;
 	bool over_lmqt = !!sflag;
 	struct sk_buff *skb;
 	u8 igmp_type;
@@ -1791,7 +1850,12 @@ static void __br_multicast_send_query(struct net_bridge_mcast *brmctx,
 	    !br_multicast_ctx_matches_vlan_snooping(brmctx))
 		return;
 
+	queue = pmctx ? &pmctx->query_queue : &brmctx->query_queue;
+
 again_under_lmqt:
+	if (skb_queue_len_lockless(queue) >= BR_MULTICAST_QUERY_QUEUE_LEN_MAX)
+		return;
+
 	skb = br_multicast_alloc_query(brmctx, pmctx, pg, ip_dst, group,
 				       with_srcs, over_lmqt, sflag, &igmp_type,
 				       need_rexmit);
@@ -1800,11 +1864,8 @@ static void __br_multicast_send_query(struct net_bridge_mcast *brmctx,
 
 	if (pmctx) {
 		skb->dev = pmctx->port->dev;
-		br_multicast_count(brmctx->br, pmctx->port, skb, igmp_type,
-				   BR_MCAST_DIR_TX);
-		NF_HOOK(NFPROTO_BRIDGE, NF_BR_LOCAL_OUT,
-			dev_net(pmctx->port->dev), NULL, skb, NULL, skb->dev,
-			br_dev_queue_push_xmit);
+		skb_queue_tail(queue, skb);
+		queue_work(system_highpri_wq, &pmctx->query_queue_work);
 
 		if (over_lmqt && with_srcs && sflag) {
 			over_lmqt = false;
@@ -1812,9 +1873,8 @@ static void __br_multicast_send_query(struct net_bridge_mcast *brmctx,
 		}
 	} else {
 		br_multicast_select_own_querier(brmctx, group, skb);
-		br_multicast_count(brmctx->br, NULL, skb, igmp_type,
-				   BR_MCAST_DIR_RX);
-		netif_rx(skb);
+		skb_queue_tail(queue, skb);
+		queue_work(system_highpri_wq, &brmctx->query_queue_work);
 	}
 }
 
@@ -1997,6 +2057,10 @@ void br_multicast_port_ctx_init(struct net_bridge_port *port,
 	pmctx->port = port;
 	pmctx->vlan = vlan;
 	pmctx->multicast_router = MDB_RTR_TYPE_TEMP_QUERY;
+
+	skb_queue_head_init(&pmctx->query_queue);
+	INIT_WORK(&pmctx->query_queue_work, br_multicast_port_query_queue_work);
+
 	timer_setup(&pmctx->ip4_mc_router_timer,
 		    br_ip4_multicast_router_expired, 0);
 	timer_setup(&pmctx->ip4_own_query.timer,
@@ -2038,6 +2102,8 @@ void br_multicast_port_ctx_deinit(struct net_bridge_mcast_port *pmctx)
 	del |= br_ip4_multicast_rport_del(pmctx);
 	br_multicast_rport_del_notify(pmctx, del);
 	spin_unlock_bh(&br->multicast_lock);
+	cancel_work_sync(&pmctx->query_queue_work);
+	__skb_queue_purge(&pmctx->query_queue);
 }
 
 int br_multicast_add_port(struct net_bridge_port *port)
@@ -4112,6 +4178,9 @@ void br_multicast_ctx_init(struct net_bridge *br,
 	seqcount_spinlock_init(&brmctx->ip6_querier.seq, &br->multicast_lock);
 #endif
 
+	skb_queue_head_init(&brmctx->query_queue);
+	INIT_WORK(&brmctx->query_queue_work, br_multicast_query_queue_work);
+
 	timer_setup(&brmctx->ip4_mc_router_timer,
 		    br_ip4_multicast_local_router_expired, 0);
 	timer_setup(&brmctx->ip4_other_query.timer,
@@ -4135,6 +4204,8 @@ void br_multicast_ctx_init(struct net_bridge *br,
 void br_multicast_ctx_deinit(struct net_bridge_mcast *brmctx)
 {
 	__br_multicast_stop(brmctx);
+	cancel_work_sync(&brmctx->query_queue_work);
+	__skb_queue_purge(&brmctx->query_queue);
 }
 
 void br_multicast_init(struct net_bridge *br)
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index d55ea9516e3e..f8f77a2d4891 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -131,6 +131,8 @@ struct net_bridge_mcast_port {
 	unsigned char			multicast_router;
 	u32				mdb_n_entries;
 	u32				mdb_max_entries;
+	struct sk_buff_head             query_queue;
+	struct work_struct              query_queue_work;
 #endif /* CONFIG_BRIDGE_IGMP_SNOOPING */
 };
 
@@ -167,6 +169,8 @@ struct net_bridge_mcast {
 	struct bridge_mcast_own_query	ip6_own_query;
 	struct bridge_mcast_querier	ip6_querier;
 #endif /* IS_ENABLED(CONFIG_IPV6) */
+	struct sk_buff_head             query_queue;
+	struct work_struct              query_queue_work;
 #endif /* CONFIG_BRIDGE_IGMP_SNOOPING */
 };
 
-- 
2.54.0


