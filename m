Return-Path: <netdev+bounces-293584-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPnSGoQsHWo4WAkAu9opvQ
	(envelope-from <netdev+bounces-293584-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 08:53:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 053FF61A6FF
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 08:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8A85D3003981
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 06:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1F13803FD;
	Mon,  1 Jun 2026 06:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BBfW51vQ"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010007.outbound.protection.outlook.com [52.101.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261E81A0BF3
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 06:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780296833; cv=fail; b=dRMpY0Br7Zl0t4IGZAb+a7/1gBR9tnhI8X/+SAfe4Z7wNfQgJOzk2Vs7EAvEOAKJtJKj8isS+usNiX9qHPSZlzFaI5MNVpiAJ9Snuhvsgv2bY9t8ekruA911YX5Obn7/OWRyAtIuJ/nHkK2QWvEwzCIVOlLhrYfkc9tujL6mbKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780296833; c=relaxed/simple;
	bh=1SPDU4ynKQBJCkvAH0rfwBL5FLNdQq2FOPsn6qZ0sM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HuIWTk80xcBVAMSu3h8qjBovN45ltru7hFKnA/UH+pVrOO315nh+lQvA7jfOq9NGNAKovjzcTgnTeSanMnsGDkauxhfycKv77WiJ+ByIRxFBqXM7Ijxr1ELQqDe1SkKDpapAGhBpX3vZjbycMwCtET9ZX9FKnoAUnvObGrgoMlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BBfW51vQ; arc=fail smtp.client-ip=52.101.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mK9LPL5c950PV3EBDcbvZiBUq5tVG3osYFQwKs4YW3MLnyMz3nB6KlROMpfWuHEqtaKq/z37o0Yr5N2wVAbcKfuQLNdn+ny3gpw1U7CNzolb94U9R/DPL9nK4xQ+2K5pam1NABvUrzo53cbwku5SmKjf8E+X7GBeNgDv0tuFJ01n7k4vQl66xWeof+2Vf+KYiL/C5lnCH8Iyk3JZyVBYXZQ8zhos15lywGlpbNK5TeoKV74htjasRAoIkZR/99RNdxs3i3YTB2ZsnL6rB6uPvxmeo/fd0p+ysCp94ZzD5IrzP8GiWLoKEiQpy0uwLmjLoJ8dkEEydsWWS1LJ2MOiKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=otnuyosoSmm2F70xptdk64Q1j78uN/5N/BrVRd1qMH0=;
 b=hvZXjy4QnBTHcZN2Ya039UgBeQMM7k5gvGQseZjuU4vpUT98ZtTYHEIEz7r7lttwZr4BSKR+swyL3IlXVFs/vICvI+Qx0J0vaKSi8FbwmQ4TmUlrxZoUgVOnTKRluV2Y/1aSOHVk1bv76B3ZGM9VH+PDwI91mmOgY5168dLWPDsAE0HskHZoHO/1YcLgJFnxSPHnGp0hhGprahphgJh+oCdj9SJSZevzwC7beYp4TMwINvE32E5w0YBUC65WugXNhux/Kun6bnCGHxAueOD6lrh7aHJrP4rUX4LlawENzGDwaytxjpRd5JMphTlvdIW7eI+wxr3vh0GFfQLTvvBBjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otnuyosoSmm2F70xptdk64Q1j78uN/5N/BrVRd1qMH0=;
 b=BBfW51vQnhMKTGQTlT6oj8EROJjnBcyBtgDS7hXqCZH6FQACZ05q1RApg6jVyhfEfN964Vbt+k4S7chiS3jtZ9mmJmfg7JX3SKY4SARrmTVd2NaU5KeC8lJLx35GWySW6YjR2BD3Amzh8hD5GIErpIu942H1QDGulHSsnLK0re98du9bA9uNp82OxpgqNWQgK7g4LUmqmdyBJg3BHRAvvRDbaLqAoXYb2piEcCJgwZ8kO8PW4tpNtzDk59WW7hF5Zu3ILzf8He+u2t3pRqrfqkp1vQ/j6kz1rD7dhryGxDB79e7UtrJBVfGKAMl+3kpHWMqk5ilPYCJVwipOZuEo9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SJ5PPF3487F9737.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::990) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Mon, 1 Jun 2026
 06:53:48 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0071.015; Mon, 1 Jun 2026
 06:53:48 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	dsahern@kernel.org,
	horms@kernel.org,
	willemb@google.com,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next v2 2/2] selftests: fib_tests: Add test cases for route lookup with oif
Date: Mon,  1 Jun 2026 09:53:00 +0300
Message-ID: <20260601065300.267960-3-idosch@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601065300.267960-1-idosch@nvidia.com>
References: <20260601065300.267960-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::11) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SJ5PPF3487F9737:EE_
X-MS-Office365-Filtering-Correlation-Id: d4658e96-af36-422e-5cc8-08debfaa881d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|6133799003|18002099003|56012099006|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info:
	O7tPyyxwZLDzPHGGoqVG7iP+8eIzewBsLnLEC/+xn942zx5LpAp7ZTt03YMHayphgGGiJve+zUMYP2vFTCbGsYqtVRKLwEuYY/Ac3TbalKiVaFKWb2EkENx3VYfjAHhj/w21HrRwarhV8pSkbigyevLW2P1aFmu0UzCn/uEDyveCa6+l+3D+QE7CvlTtxQJUDDtupz29+58L6cmNkw9wgn3cbk/A7OqM1pp+Vxuk8ElHLiGMboXhrkIjHmDEy57YMx8q8nXYXZ+cSpl2kAlr/2YQkBOnLQAuJfVaxFJV5y/eB3Bgg6GzB78ykCtIVckT8tJspvu7zFmEb9XH6dg87w+lJ1ahHNyil6r509NKTP6brzbDHjpPxZJIaGhB6F6yx/DTbpYcU50MQjSuk7cvP4Krx2bB4kirp+atL8MlZeCOGQ59DrFFYAd4NclfrtPbBswfCMqv1dSiGl+NZSSpzMJUQbvgZTWs1XjOQu5lf1g1g2wjBw0i7ySKI+mTunJQzAMHTM9RyTCfEDfUEtI0GLy0qRLnQHCbfxQYlLTL4+RT6QxtSoL19wtwYFyfd0VLEyh+NkHMi165hJX8WNbW773YbqoTtDPdGAqPr3z2GkBrdUNTT0e2ldZC2xGOSzFweIyHG1PBOThfDE74ilhpf30QQGyTu+kw5GdbNeqIcTL+IudaSUvHXPwxqKx/jcgI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(6133799003)(18002099003)(56012099006)(11063799006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3xkLbtB4N804JyoD0sFNcj9NelerGIk0kkwJrIS/zHbU9c755B4Hyi44VebS?=
 =?us-ascii?Q?nv5tPnASx/uxule3uADs/BZFqEQejV1wHih3V7+Ezo7eKIrstKbX+9Hwg6Hc?=
 =?us-ascii?Q?59ULWPPHoarqEedQDDi+4vKGfi9KbTyMPAU3ZEZfR7x/Cx7dkX6saw7GV6KL?=
 =?us-ascii?Q?ocWi/1lHbtisAcmmLR6SvsIPyQy/ZZ3b6OAmqKVg/X4X01pCpeKS+wPQGWK5?=
 =?us-ascii?Q?56GznbdFiMjafweMLruRfhQAYTI1Bm9A3gYSEo/3aGIjrMQdPw8JPm0CiuB4?=
 =?us-ascii?Q?S0E8JkOWU3FTsSJrwXAYeWs8lpALPqdorY7BNuP5fZ3ptbVjqz1d5zzzgYK/?=
 =?us-ascii?Q?W1cvURAc5bZUQIB/OQltmEq4t+FludqY9AR1P0yToPsRZCqVJlVYSj/1tmOZ?=
 =?us-ascii?Q?bqwNVBJqWrmzLNUf5zZpGf/cIfkl7Pp3xrybv5MbT7Wq/FFNz/Xu6jJqdKbb?=
 =?us-ascii?Q?lX4cyZgjYC52oB5fWjZrNUTmfeU52xi0FBpr5KJCx/D8ignll66IG21iypCr?=
 =?us-ascii?Q?KMpZz+ZmC4/U4yhvcNuP89Rdtk9hQ5rfBw4uMzz3NUJaJ3BAJLzqBUf1W3g3?=
 =?us-ascii?Q?nIMjS80qqAgg2K+5VfJ44VogqHbYcyFwmSBO9X8Lh1Eggvap46gAlAJGqyvy?=
 =?us-ascii?Q?PMuR3xD1lha6IR+t1yJqxyQTZpNM2set0VQkUp+CYQMvaZtccyp9+qyVXbQq?=
 =?us-ascii?Q?RsKwDyqNee089iR5K9xtRDoRQQcUluNw60Q9sU3dhYBqj96qw4HZBJtSbw0U?=
 =?us-ascii?Q?xEy7g8W8RCM65BqmYJwdpAwUi6CPq4ui+uqAxWkmVCE2CHH53ddl0pBdLJNk?=
 =?us-ascii?Q?qOQNnwbZmMmZkTCYl/rxZrmiawjdMcF2YDbypnb2nWQQV4otR+LPbNVBGAAz?=
 =?us-ascii?Q?L3K+ZbOkXaX1H8p5gSKeEmGwg4DFsizZQeCufPeh9wwYHrUgQgJMp9a3C9x4?=
 =?us-ascii?Q?FIiICeHILySqXa5tP4it+1+5FpawMFXO3mP8pbqUVXKUnLearC/SIorq8mhQ?=
 =?us-ascii?Q?HB3T3eg0VTOG9jxSe1BxiRZxeIpa4x5TYk3ZZfNgWnr4GRNOOF8JYV8wgT7p?=
 =?us-ascii?Q?iBbwaefr9MglfHTLzPjY4bGjBPbeZWdPwVK7xsDi1kpp9w1bzCQ6utVsVA1g?=
 =?us-ascii?Q?WTSonCa88GE3HpdnjoDpwlCK8NtoPHe+ePCl9vxvXUt+ClXEofeO51Z4bpcf?=
 =?us-ascii?Q?Bvnb55UaszEU3hnlk0SSG9En9/xN9W0zzF2JwRB25p6JaAjERq6N2qeHht+m?=
 =?us-ascii?Q?sHpJ8tXyrQyBEcge0BSlOY2wolGQZzS4J7DsM64V+zHTBJUWXSPgU4k9jPhx?=
 =?us-ascii?Q?OuS8QTWbOJ44gMRLpmuNTPziD0HekURYVfDvXKVTC5WeZAQ4ZWJnMZLQM/Kt?=
 =?us-ascii?Q?++JufRIoVYaDOWQ78J9OU1l3NjQtqmSJ5c5v/BQKUbtwFXLvaeF1tEW02aKa?=
 =?us-ascii?Q?Ef0mfpKEZtIXk6JefCumsBLqAAdylZCDOwFupdA1X0TyU+xmcj+1p0sE6WVZ?=
 =?us-ascii?Q?7yUPcpx3+/JRHlY2jA6Okio7BTGVjM9wed7vxSMxzn+x2ydn/YzO+MS/jyDk?=
 =?us-ascii?Q?O17aNu7iTpuRmTzD1wvdTasnv/09WwHzCT6l/30yvqBNJSYbE/V9U8HxUFVG?=
 =?us-ascii?Q?5WHB6WZ4rq1l7YjpDjKllKZGrYUHSa1Fqz5PyhUmhrCFe3k/qPEQHWYbFlHl?=
 =?us-ascii?Q?AmHKcV+7b89gIIajOM1aVCUWJkwD297M1bNldyzKi5EFrOh2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4658e96-af36-422e-5cc8-08debfaa881d
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 06:53:48.3479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iSePtRYXQmrkyRSp9VDwl0ViAy3l2AJN2Rp5hOTE9zTHDDX+GMcBLI9OomfcdMy9KWwm/MG+bDoIb7Z8xGGPzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF3487F9737
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-293584-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 053FF61A6FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Test that both address families respect the oif parameter when a
matching multipath route is found, regardless of the presence of a
source address.

Output without "ipv6: Honor oif when choosing nexthop for locally
generated traffic":

 # ./fib_tests.sh -t "ipv4_mpath_oif ipv4_mpath_oif_vrf ipv6_mpath_oif ipv6_mpath_oif_vrf"

 IPv4 multipath oif test
     TEST: IPv4 multipath via first nexthop                              [ OK ]
     TEST: IPv4 multipath via second nexthop                             [ OK ]
     TEST: IPv4 multipath via first nexthop with source address          [ OK ]
     TEST: IPv4 multipath via second nexthop with source address         [ OK ]

 IPv4 multipath oif with VRF test
     TEST: IPv4 multipath via first nexthop                              [ OK ]
     TEST: IPv4 multipath via second nexthop                             [ OK ]
     TEST: IPv4 multipath via first nexthop with source address          [ OK ]
     TEST: IPv4 multipath via second nexthop with source address         [ OK ]

 IPv6 multipath oif test
     TEST: IPv6 multipath via first nexthop                              [ OK ]
     TEST: IPv6 multipath via second nexthop                             [ OK ]
     TEST: IPv6 multipath via first nexthop with source address          [FAIL]
     TEST: IPv6 multipath via second nexthop with source address         [FAIL]

 IPv6 multipath oif with VRF test
     TEST: IPv6 multipath via first nexthop                              [ OK ]
     TEST: IPv6 multipath via second nexthop                             [ OK ]
     TEST: IPv6 multipath via first nexthop with source address          [FAIL]
     TEST: IPv6 multipath via second nexthop with source address         [FAIL]

 Tests passed:  12
 Tests failed:   4

Output with "ipv6: Honor oif when choosing nexthop for locally generated
traffic":

 # ./fib_tests.sh -t "ipv4_mpath_oif ipv4_mpath_oif_vrf ipv6_mpath_oif ipv6_mpath_oif_vrf"

 IPv4 multipath oif test
     TEST: IPv4 multipath via first nexthop                              [ OK ]
     TEST: IPv4 multipath via second nexthop                             [ OK ]
     TEST: IPv4 multipath via first nexthop with source address          [ OK ]
     TEST: IPv4 multipath via second nexthop with source address         [ OK ]

 IPv4 multipath oif with VRF test
     TEST: IPv4 multipath via first nexthop                              [ OK ]
     TEST: IPv4 multipath via second nexthop                             [ OK ]
     TEST: IPv4 multipath via first nexthop with source address          [ OK ]
     TEST: IPv4 multipath via second nexthop with source address         [ OK ]

 IPv6 multipath oif test
     TEST: IPv6 multipath via first nexthop                              [ OK ]
     TEST: IPv6 multipath via second nexthop                             [ OK ]
     TEST: IPv6 multipath via first nexthop with source address          [ OK ]
     TEST: IPv6 multipath via second nexthop with source address         [ OK ]

 IPv6 multipath oif with VRF test
     TEST: IPv6 multipath via first nexthop                              [ OK ]
     TEST: IPv6 multipath via second nexthop                             [ OK ]
     TEST: IPv6 multipath via first nexthop with source address          [ OK ]
     TEST: IPv6 multipath via second nexthop with source address         [ OK ]

 Tests passed:  16
 Tests failed:   0

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/fib_tests.sh | 183 ++++++++++++++++++++++-
 1 file changed, 182 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
index 8f10de0eb985..1b2e9a0b21d0 100755
--- a/tools/testing/selftests/net/fib_tests.sh
+++ b/tools/testing/selftests/net/fib_tests.sh
@@ -12,7 +12,9 @@ TESTS="unregister down carrier nexthop suppress ipv6_notify ipv4_notify \
        ipv4_route_metrics ipv4_route_v6_gw rp_filter ipv4_del_addr \
        ipv6_del_addr ipv4_mangle ipv6_mangle ipv4_bcast_neigh fib6_gc_test \
        ipv4_mpath_list ipv6_mpath_list ipv4_mpath_balance ipv6_mpath_balance \
-       ipv4_mpath_balance_preferred fib6_ra_to_static fib6_temp_addr_renewal"
+       ipv4_mpath_balance_preferred ipv4_mpath_oif ipv4_mpath_oif_vrf \
+       ipv6_mpath_oif ipv6_mpath_oif_vrf fib6_ra_to_static \
+       fib6_temp_addr_renewal"
 
 VERBOSE=0
 PAUSE_ON_FAIL=no
@@ -2971,6 +2973,181 @@ ipv6_mpath_balance_test()
 	forwarding_cleanup
 }
 
+ipv4_mpath_oif_test_common()
+{
+	local get_param=$1; shift
+	local expected_oif=$1; shift
+	local test_name=$1; shift
+	local tmp_file
+
+	tmp_file=$(mktemp)
+
+	for i in {1..100}; do
+		$IP route get 203.0.113.${i} $get_param >> "$tmp_file"
+	done
+
+	[[ $(grep "$expected_oif" "$tmp_file" | wc -l) -eq 100 ]]
+	log_test $? 0 "$test_name"
+
+	rm "$tmp_file"
+}
+
+ipv4_mpath_oif_test()
+{
+	echo
+	echo "IPv4 multipath oif test"
+
+	setup
+
+	set -e
+	$IP link add dummy1 up type dummy
+	$IP address add 192.0.2.1/28 dev dummy1
+	$IP address add 192.0.2.17/32 dev lo
+
+	$IP route add 203.0.113.0/24 \
+		nexthop via 198.51.100.2 dev dummy0 \
+		nexthop via 192.0.2.2 dev dummy1
+	set +e
+
+	ipv4_mpath_oif_test_common "oif dummy0" "dummy0" \
+		"IPv4 multipath via first nexthop"
+
+	ipv4_mpath_oif_test_common "oif dummy1" "dummy1" \
+		"IPv4 multipath via second nexthop"
+
+	ipv4_mpath_oif_test_common "oif dummy0 from 192.0.2.17" "dummy0" \
+		"IPv4 multipath via first nexthop with source address"
+
+	ipv4_mpath_oif_test_common "oif dummy1 from 192.0.2.17" "dummy1" \
+		"IPv4 multipath via second nexthop with source address"
+
+	cleanup
+}
+
+ipv4_mpath_oif_vrf_test()
+{
+	echo
+	echo "IPv4 multipath oif with VRF test"
+
+	setup
+
+	set -e
+	$IP -4 rule add pref 32765 table local
+	$IP -4 rule del pref 0
+	$IP link add name vrf-123 up type vrf table 123
+	$IP link set dev dummy0 master vrf-123
+	$IP link add dummy1 up master vrf-123 type dummy
+	$IP address add 192.0.2.1/28 dev dummy1
+	$IP address add 192.0.2.17/32 dev vrf-123
+
+	$IP route add 203.0.113.0/24 vrf vrf-123 \
+		nexthop via 198.51.100.2 dev dummy0 \
+		nexthop via 192.0.2.2 dev dummy1
+	set +e
+
+	ipv4_mpath_oif_test_common "oif dummy0" "dummy0" \
+		"IPv4 multipath via first nexthop"
+
+	ipv4_mpath_oif_test_common "oif dummy1" "dummy1" \
+		"IPv4 multipath via second nexthop"
+
+	ipv4_mpath_oif_test_common "oif dummy0 from 192.0.2.17" "dummy0" \
+		"IPv4 multipath via first nexthop with source address"
+
+	ipv4_mpath_oif_test_common "oif dummy1 from 192.0.2.17" "dummy1" \
+		"IPv4 multipath via second nexthop with source address"
+
+	cleanup
+}
+
+ipv6_mpath_oif_test_common()
+{
+	local get_param=$1; shift
+	local expected_oif=$1; shift
+	local test_name=$1; shift
+	local tmp_file
+
+	tmp_file=$(mktemp)
+
+	for i in {1..100}; do
+		$IP route get 2001:db8:10::${i} $get_param >> "$tmp_file"
+	done
+
+	[[ $(grep "$expected_oif" "$tmp_file" | wc -l) -eq 100 ]]
+	log_test $? 0 "$test_name"
+
+	rm "$tmp_file"
+}
+
+ipv6_mpath_oif_test()
+{
+	echo
+	echo "IPv6 multipath oif test"
+
+	setup
+
+	set -e
+	$IP link add dummy1 up type dummy
+	$IP address add 2001:db8:2::1/64 dev dummy1
+	$IP address add 2001:db8:100::1/128 dev lo
+
+	$IP route add 2001:db8:10::/64 \
+		nexthop via 2001:db8:1::2 dev dummy0 \
+		nexthop via 2001:db8:2::2 dev dummy1
+	set +e
+
+	ipv6_mpath_oif_test_common "oif dummy0" "dummy0" \
+		"IPv6 multipath via first nexthop"
+
+	ipv6_mpath_oif_test_common "oif dummy1" "dummy1" \
+		"IPv6 multipath via second nexthop"
+
+	ipv6_mpath_oif_test_common "oif dummy0 from 2001:db8:100::1" "dummy0" \
+		"IPv6 multipath via first nexthop with source address"
+
+	ipv6_mpath_oif_test_common "oif dummy1 from 2001:db8:100::1" "dummy1" \
+		"IPv6 multipath via second nexthop with source address"
+
+	cleanup
+}
+
+ipv6_mpath_oif_vrf_test()
+{
+	echo
+	echo "IPv6 multipath oif with VRF test"
+
+	setup
+
+	set -e
+	$NS_EXEC sysctl -qw net.ipv6.conf.all.keep_addr_on_down=1
+	$IP -6 rule add pref 32765 table local
+	$IP -6 rule del pref 0
+	$IP link add name vrf-123 up type vrf table 123
+	$IP link set dev dummy0 master vrf-123
+	$IP link add dummy1 up master vrf-123 type dummy
+	$IP address add 2001:db8:2::1/64 dev dummy1
+	$IP address add 2001:db8:100::1/128 dev vrf-123
+
+	$IP route add 2001:db8:10::/64 vrf vrf-123 \
+		nexthop via 2001:db8:1::2 dev dummy0 \
+		nexthop via 2001:db8:2::2 dev dummy1
+	set +e
+
+	ipv6_mpath_oif_test_common "oif dummy0" "dummy0" \
+		"IPv6 multipath via first nexthop"
+
+	ipv6_mpath_oif_test_common "oif dummy1" "dummy1" \
+		"IPv6 multipath via second nexthop"
+
+	ipv6_mpath_oif_test_common "oif dummy0 from 2001:db8:100::1" "dummy0" \
+		"IPv6 multipath via first nexthop with source address"
+
+	ipv6_mpath_oif_test_common "oif dummy1 from 2001:db8:100::1" "dummy1" \
+		"IPv6 multipath via second nexthop with source address"
+
+	cleanup
+}
+
 ################################################################################
 # usage
 
@@ -3057,6 +3234,10 @@ do
 	ipv4_mpath_balance)		ipv4_mpath_balance_test;;
 	ipv6_mpath_balance)		ipv6_mpath_balance_test;;
 	ipv4_mpath_balance_preferred)	ipv4_mpath_balance_preferred_test;;
+	ipv4_mpath_oif)			ipv4_mpath_oif_test;;
+	ipv4_mpath_oif_vrf)		ipv4_mpath_oif_vrf_test;;
+	ipv6_mpath_oif)			ipv6_mpath_oif_test;;
+	ipv6_mpath_oif_vrf)		ipv6_mpath_oif_vrf_test;;
 	fib6_ra_to_static)		fib6_ra_to_static;;
 	fib6_temp_addr_renewal)		fib6_temp_addr_renewal;;
 
-- 
2.54.0


