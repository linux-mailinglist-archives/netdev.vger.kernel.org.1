Return-Path: <netdev+bounces-261219-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QI6pAL3+n2n3fAQAu9opvQ
	(envelope-from <netdev+bounces-261219-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 09:05:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1601A2405
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 09:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 19DE930B6CBF
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 08:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5E7392C59;
	Thu, 26 Feb 2026 08:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mJrR6gj2"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010042.outbound.protection.outlook.com [52.101.56.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3E2392C22;
	Thu, 26 Feb 2026 08:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772092911; cv=fail; b=b6FTf0yYgf9C0TF+0Eet3pjcIORyyyAUf5GU8ZrpW1nII5ZeGDOfn4RnyiNmLvuG22iuXvtYbahBWBHmGGunCB1448xZyPhLKeSdq8YoOdrTIp1AfLVWf+i9Db/VmGp9YQaorU31qQjihBhQHZ+Vq99W43fWKQcGtK603Xfy478=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772092911; c=relaxed/simple;
	bh=towvVODpATeg5h2gO3uaPIyJNdUnPH67fDZ3lSIh9d4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lc7Emc9jJ031sel6dz08SMipF5jJxJfkdOCCcy7yc/vxYbWCjVxnkWXuL82VgSGurkYHSa9cUICEgRD3mlw7N5TMWwtGTMVPyj4e6TRKCs4uy+2d34FV5CGWeVdOd36TNLYsRT9llB6+C+6iRANinl3UMuQv/woPVPdzwKmwkkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mJrR6gj2; arc=fail smtp.client-ip=52.101.56.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oXnhNhivHHb4JEwi/uWlJeS2rljDinK7X+uJpcn9gvrbkUXqILUo9FiC+m/UVNZ4oxc+REgXuFRa663uTM8hHsds5qk1J0IHFvPKWYO2kSxHkJvEvXKzj8ObXtyUe2ZC5D/VqmxDFQLlbXCS3yv2jwGBf43tYWH9eKMqh07QqnjFcBxLi/mtHj2Lx6fiebzuVRDkB/pvwZKo9zFVH8WoCSj1N9N/iYKX0wjK2uifS83X5RI0bl4u079Wvld/aqayNQkBeGb25F89hJf8Vqy+djNeoemFxJeZ4YP9mRYbTMGMC7WY1b42i2slzTlCZXkYMM7nTTyInI1nPj+7HeekKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q2mHPJ3nuU6QWzHRKECaeijrMiqdYNfVaCq2YGUNkMY=;
 b=lWzzTn7uAqbRSPImyXsIx/gApkPpZhQV0e+adaVwwNCpSk736T7zQFC7HQvPWfEclUmxrWLymJveIODOzTOGocoKRJcbVWGiROSFc15AYs6AHNKcwfM7jjCLnPhM2oZpx65OAHDXVFJkA9OM2xrD8cMp5i9uWCpnsp6ROsgFC6Ibv+oaWOPFeZPwd323Hq2zwQw/6mvsM2H3bujNaoGT9RrZkvivMBE9wKJjNcv9BlH+FijUFYXOwiloqOYuDNBb3eQuarevDVFpbI0koBkx+I0n3c4SL//PP0B5dNjrkIed5YYrVd2UomNwVirA3KcI2ZU1EwheUnMTXHa0quTGrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2mHPJ3nuU6QWzHRKECaeijrMiqdYNfVaCq2YGUNkMY=;
 b=mJrR6gj2iORKMy7tvpVV0fykNeNPsGkZctl5BVAq0WhCQ51eUD3XA04PpcbOc7jGAlK5zuOPlV1F34NWcqMrp8dPzIOa1qSXX649bB8nQkCHfXaO6fpKiKVYiW4K3HAdWA0ve374BRZNzCnbh543EJOgJtoAnC/W44G2JTGq2M+NhHBhdqtinSZCqNi+kwmZ0TJ8PLd4atVSaj7SAxWj98oGU4e4lgIEYud4gs0ov+KXdUGWOPfNZ7dIAbXndgIJUtp44gI42cu6Zz6Jcub2cqA+cjwb4qQ/h65P3cBfTtEvXqNnweUoIGxrNri8zbNOv8X7f2gKjA8QEEtpL6vu1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by SJ1PR12MB6362.namprd12.prod.outlook.com (2603:10b6:a03:454::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Thu, 26 Feb
 2026 08:01:47 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%5]) with mapi id 15.20.9632.010; Thu, 26 Feb 2026
 08:01:47 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	dsahern@gmail.com,
	petrm@nvidia.com,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	Ido Schimmel <idosch@nvidia.com>
Subject: [RFC PATCH bpf-next 7/9] selftests/bpf: fib_lookup: Add IPv6 output route tests
Date: Thu, 26 Feb 2026 10:00:01 +0200
Message-ID: <20260226080003.524935-8-idosch@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260226080003.524935-1-idosch@nvidia.com>
References: <20260226080003.524935-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0164.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::6) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|SJ1PR12MB6362:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a02df10-5fba-4231-3b92-08de750d4a01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	AwQGV1ZXhE9KtqPf/v7mzcPu1HcvfhSqMoQUsf0NQAO3R0HAOG7LQL5K9JnwBG8m9oUM/0s9O3rAKb1N2jaMNmJ7/DzSf4OSLjLxAHI83fSBplTDr3+dijMtug9Fx/otdjVrI+4z8PXvhF0kN7eKseUwN82zcz5G4QSFluYhQIDE9/OcV5iereiPQ0x69JEKHstSFad08V3jmNu8Cg5l/lcp8s2VIAiZHa83FOyN7lJ4UOJseSydQ1X/07ZBx7bKsd/jJblrWywK4AXFQ4s3SWJw2npFTAg8xRLb6PKutH0mnUOTzjlOsqV6HgIvvA3Ba5yOByKVBzSLvFswV2HN1y8svzMgyoazqQ/3G3bndAh5OVhGPEu9FvZHPqk7V1a7Py0SxzKvtgnIjK0jm/fBBlPYgG1HBRX2XZhWCBGv0vBaztvNJkB+FMiFQBI12waoaZ3wlMv6cMXKI5w2oezOyq+qi0xWQgs9nr1OhWQmXdGcpfgt7X2wym6dpkyGk+BJqYTCCuo/5lNYU4dm4xl740ZSaawap+VqkWpEAsOxCGMe0DxmsPPUkTaDw1aJpiQSw1msaoM27eWbf7sAjp74C9nx/rJKyXHdFXHh/tvg1jU7rd0kMHOSt71eM8oCb1Ter3lptVc4w41pAKpyFLLtj9vZ090Ak7iySG/Ngpyq5ZktbEMvSiKW6vaczG/nF3xDn0HQwLgT6mfsups4kpR8x9uc7SdmJxwfjcqBYrLrcM4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c9gLhLhwsleyjq2aIwHib7sJapovS6Q1cpYyYFaomA0tojAPLe0Caxvdgljo?=
 =?us-ascii?Q?JsotpUv5b71fUmad636jRaEuuu6bfMYu1/MM0B4WU6oPOFjZg0+wdx3U/JQc?=
 =?us-ascii?Q?RatLooxy0mTOUT5hTcULf3XsEQAD14yL7d1e8V5ATzJEUjyJ52coPoN6rufY?=
 =?us-ascii?Q?lahG+oaQsvyfnJucfislXxSmnwKMpUTlax9ip/hJl1VeD0yfhu4KMTFeIkLA?=
 =?us-ascii?Q?NNfBea0zJl+d9pPekb6JVqBz8vowXsWFJyhvii91/+WL61h8WN75x5g3y5+W?=
 =?us-ascii?Q?5lcQeRc6lEGvsSN/PhqjMa2/3pRACKKeQJQubGtITmApCEZR4nUEPGt0zklN?=
 =?us-ascii?Q?1Q0QKRyAp9dUsRI/VUOTISudGlHPoJhP+Vzizhkglh/89UASB0B9A/oPSz+Z?=
 =?us-ascii?Q?7XMLaVnweD9bNBMzVUt8Tx9QCNtlKUi2W+hIt1C/FbM1laz552DM0+94wOlm?=
 =?us-ascii?Q?Da4J4gmKPxkhDw2Cdtxkr9HbXu4Uy3Lw+fnwdUxZ8j4jVoS7erWzXBrIX8z0?=
 =?us-ascii?Q?fFK8iQLhwPLy5XzzuZZ1mfvnOmi3Jka2qcATUlcqTJOVVgjkLHSoWpwa8Cfq?=
 =?us-ascii?Q?gABCjV/fDOiMIOBCdPrMzwra3zb3r6xbHEO8iD+mwSPn9oHKS5b5VsFTfwGB?=
 =?us-ascii?Q?fUu96OQeMi/scKDm382s4MtVPdmksUdrubLBUY15sr+SaaqsmxIcfkn1BsCT?=
 =?us-ascii?Q?r9S+HGrPYAo/IgFgNEBe0HcdO1Rah14APaqstC/EvxjoEDJOa6tc1RczVGpa?=
 =?us-ascii?Q?xu4t1Dhab1hv2YplGe9ZguLsB73JhM6owfjTRqxrGGPxvsgfTXRmCdynhWs1?=
 =?us-ascii?Q?JXJuK+gx3BpNgO5d20ZAViBTN4qrr+ZeugqFvTCTK1VQEj0cCvG0qv+sY6Ku?=
 =?us-ascii?Q?8Ixhxnu+Jxy85Ld5JzBMeJd/sVQ0VGMfBjkIDjf8b1/wqQ6sVOjfluMAit3x?=
 =?us-ascii?Q?69kwi/+C1cM01GMK9ZgxiOVT52gszfUvlBDEDLOBVbItczAlPaJ07B6JBe4P?=
 =?us-ascii?Q?JtqabYt+6XcUTzY4jq9Pn052YrTkDKG0XO6sdXehuowFd/LFS1C9BEn7IVOW?=
 =?us-ascii?Q?kU3/pysrHy8vOQve5EHW0LVGn6nPG/nsyLazEIN5T4Cw/AZZXh+LcunVJtaw?=
 =?us-ascii?Q?OLRKpIr3TcNNMdLFZrf2/cgOl7bijKfNLC5ACqTGw2GwjpYP9BNh6gHVkWiK?=
 =?us-ascii?Q?KMd9zpSN1gPpGG2iBcGmDo002Owq18s7SAQqV04dUSTz3KwZwXjlG5oilzNB?=
 =?us-ascii?Q?XHfA7ln/Cc+9ZSEnRi8OLXyxIMLBeVgsmbHDhv6aY6jy9I3IayWja7MND6Of?=
 =?us-ascii?Q?ECNwZ5IQz8GgrX2sj33sxNyXhrmOVNR4Ltgk11hjW87u07jGycT1fGeB033/?=
 =?us-ascii?Q?uEAnV9n3dqWbUz5vc9eAvSpKPYnQeiTgG5+eXISUgFOFvhUvN48C2r1L/KAZ?=
 =?us-ascii?Q?RVgNW37IXRslu3lUagH7CJ+zKjBoA2QRUwwLPwDsKceIgxEdquAlgvKAJyW6?=
 =?us-ascii?Q?rOQNvmBEdKVDDazooNwOgFvu4YVPLIDoMGNqBTS44m95xJHNhotB2Ll7c3J6?=
 =?us-ascii?Q?yyshtSScpjtZX2MGnvZpCqIN6ZFKOIashu7trNUj4GOZRR/1aRfqn3qO2a1R?=
 =?us-ascii?Q?n2V5UPWeK1+uTffKj5xi48yyzKfzTMNipmXlsw5V1DfjwqHxeRcgZjRuB6t3?=
 =?us-ascii?Q?jnZDPga+dQjkfNwCmwfVthxFLQGdpn+D4bD5gEd3ERevmnmcaiqUbDmsP2J3?=
 =?us-ascii?Q?bGAnze5mBg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a02df10-5fba-4231-3b92-08de750d4a01
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 08:01:47.1210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9x37gHVUMiJyOfQvw7q/BrERuq3ii8mJqGun1frrznYu8cnGN+QnGz9TdRHUREM5Z45jX3r5xTxtI7ORuHTn3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6362
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,gmail.com,nvidia.com,iogearbox.net,linux.dev,fomichev.me];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261219-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.986];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim]
X-Rspamd-Queue-Id: AC1601A2405
X-Rspamd-Action: no action

In a similar fashion to the IPv4 output route tests, add equivalent IPv6
tests.

Output without "bpf: fib_lookup: Honor oif in IPv6 output route
lookups":

 # ./test_progs -a fib_lookup
 [...]
 Testing IPv6 output route, without source, via second device test_fib_lookup:PASS:bpf_prog_test_run_opts 0 nsec
 test_fib_lookup:PASS:fib_lookup_ret 0 nsec
 test_fib_lookup:FAIL:ifindex does not match unexpected ifindex does not match: actual 10010 != expected 10020
 [...]
 Testing IPv6 output route, with source, via second device set_lookup_params:PASS:inet_pton(IPV6_IFACE_ADDR) 0 nsec
 test_fib_lookup:PASS:bpf_prog_test_run_opts 0 nsec
 test_fib_lookup:PASS:fib_lookup_ret 0 nsec
 test_fib_lookup:FAIL:ifindex does not match unexpected ifindex does not match: actual 10010 != expected 10020
 [...]
 Testing IPv6 output route, oif mismatch set_lookup_params:PASS:inet_pton(IPV6_IFACE_ADDR) 0 nsec
 test_fib_lookup:PASS:bpf_prog_test_run_opts 0 nsec
 test_fib_lookup:FAIL:fib_lookup_ret unexpected fib_lookup_ret: actual 0 != expected 4
 [...]
 #119     fib_lookup:FAIL
 Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED

Output with "bpf: fib_lookup: Honor oif in IPv6 output route lookups":

 # ./test_progs -a fib_lookup
 #119     fib_lookup:OK
 Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

That is, without the specified patch, unlike IPv4, IPv6 would always
resolve the most specific route with the lowest metric, even if its
nexthop device does not match the specified oif.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 .../selftests/bpf/prog_tests/fib_lookup.c     | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/fib_lookup.c b/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
index 6ceeecbdca43..9e933daf56d7 100644
--- a/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
@@ -45,6 +45,8 @@
 #define IFINDEX_VETH2		10020
 #define IPV4_OUTPUT_NET		"192.0.2.0"
 #define IPV4_OUTPUT_DST		"192.0.2.1"
+#define IPV6_OUTPUT_NET		"2001:db8:1::"
+#define IPV6_OUTPUT_DST		"2001:db8:1::1"
 
 struct fib_lookup_test {
 	const char *desc;
@@ -177,6 +179,34 @@ static const struct fib_lookup_test tests[] = {
 	  .expected_ret = BPF_FIB_LKUP_RET_NOT_FWDED,
 	  .lookup_flags = BPF_FIB_LOOKUP_OUTPUT | BPF_FIB_LOOKUP_SKIP_NEIGH,
 	  .ifindex = IFINDEX_VETH2, },
+	{ .desc = "IPv6 output route, without source, via first device",
+	  .daddr = IPV6_OUTPUT_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .lookup_flags = BPF_FIB_LOOKUP_OUTPUT | BPF_FIB_LOOKUP_SRC,
+	  .dmac = DMAC_INIT, .ifindex = IFINDEX_VETH1,
+	  .expected_ifindex = IFINDEX_VETH1, },
+	{ .desc = "IPv6 output route, without source, via second device",
+	  .daddr = IPV6_OUTPUT_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .lookup_flags = BPF_FIB_LOOKUP_OUTPUT | BPF_FIB_LOOKUP_SRC,
+	  .dmac = DMAC_INIT2, .ifindex = IFINDEX_VETH2,
+	  .expected_ifindex = IFINDEX_VETH2, },
+	{ .desc = "IPv6 output route, with source, via first device",
+	  .daddr = IPV6_OUTPUT_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .lookup_flags = BPF_FIB_LOOKUP_OUTPUT, .dmac = DMAC_INIT,
+	  .ifindex = IFINDEX_VETH1, .expected_ifindex = IFINDEX_VETH1, },
+	{ .desc = "IPv6 output route, with source, via second device",
+	  .daddr = IPV6_OUTPUT_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .lookup_flags = BPF_FIB_LOOKUP_OUTPUT, .dmac = DMAC_INIT2,
+	  .ifindex = IFINDEX_VETH2, .expected_ifindex = IFINDEX_VETH2, },
+	{ .desc = "IPv6 output route, oif match",
+	  .daddr = IPV6_NUD_STALE_ADDR,
+	  .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .lookup_flags = BPF_FIB_LOOKUP_OUTPUT | BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .ifindex = IFINDEX_VETH1, .expected_ifindex = IFINDEX_VETH1, },
+	{ .desc = "IPv6 output route, oif mismatch",
+	  .daddr = IPV6_NUD_STALE_ADDR,
+	  .expected_ret = BPF_FIB_LKUP_RET_NOT_FWDED,
+	  .lookup_flags = BPF_FIB_LOOKUP_OUTPUT | BPF_FIB_LOOKUP_SKIP_NEIGH,
+	  .ifindex = IFINDEX_VETH2, },
 };
 
 static int setup_netns(void)
@@ -254,6 +284,11 @@ static int setup_netns(void)
 	SYS(fail, "ip neigh add %s dev veth1 lladdr %s nud perm", IPV4_OUTPUT_DST, DMAC);
 	SYS(fail, "ip neigh add %s dev veth2 lladdr %s nud perm", IPV4_OUTPUT_DST, DMAC2);
 
+	SYS(fail, "ip route add %s/64 dev veth1 metric 100", IPV6_OUTPUT_NET);
+	SYS(fail, "ip route add %s/64 dev veth2 metric 200", IPV6_OUTPUT_NET);
+	SYS(fail, "ip neigh add %s dev veth1 lladdr %s nud perm", IPV6_OUTPUT_DST, DMAC);
+	SYS(fail, "ip neigh add %s dev veth2 lladdr %s nud perm", IPV6_OUTPUT_DST, DMAC2);
+
 	return 0;
 fail:
 	return -1;
-- 
2.53.0


