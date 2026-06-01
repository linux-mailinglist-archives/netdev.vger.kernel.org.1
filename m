Return-Path: <netdev+bounces-293583-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qES5HSguHWo4WAkAu9opvQ
	(envelope-from <netdev+bounces-293583-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 09:00:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE62161A8BD
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 09:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A78F1303AAA5
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 06:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C083803C3;
	Mon,  1 Jun 2026 06:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jtfNaRdE"
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011023.outbound.protection.outlook.com [52.101.57.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B385B3803FD
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 06:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780296824; cv=fail; b=lHpZKB2JFn2JT0v5djckPM4/vWxaGwu0irEDIC0Qv1NHl+OfntdekKRhsVj+cmE7ndU2DMDX6K3SWHEnl5qFT0QniqNVuEbBVG6tncxHfsvTpz8GoznBV0F/Sd93ZdlOt1M27hE6RKgxF0hWoDl6YHHmxnjjwcMFYmeyHGBsx6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780296824; c=relaxed/simple;
	bh=1H6Ux4heFWOu/u19HqPyuNL+4AicRxGEXATCpEOePKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t8ioictK34nAkJM7oS8gaWZnJzNUZJMO4muELYtZLbzaiL5mrb8KeM2o78StPtbJl0fDqfoHdPTsWOT4p6BUHruTMERTdx+qys38HYoEeHPzQGZtmRvEH4rAkhNtuzJBkyScVRyn+v1y7Sc+tARDQLK9GMOw4bXUePZsESP8Zt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jtfNaRdE; arc=fail smtp.client-ip=52.101.57.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s04keFba6eav8go2ogODnj9HDHbptoNdsgr5lemXJaCn+lj4dAw9QynI+EC8tsds2SQWjmVfIdowKWRHmz2YuCGBY0hyBg+pTIDfoV3gRrNpUaPPWx6If82wrO3dUkygawbpbDAGXTHoK2giBwjM8um7q6YogCChrHLyf23hvCFHCmPanjEj7HTznjtOAC8B0CUppIzQAlVeWWzEn/XKU7p7hD96u+uZMl1FN6myOJDjq7PE8qNe1/4O+3RvU/+U9uhh5dgTf6jjcylPpJ8R/rk7e7J4kh6HS6tUDdNUtOcjM3cAjFo3yXxuLNf06eelHKC1vthaEVrq71hgDtigPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/fz5VYNnI2lWswd4e3y+ax0NPrKuZ5aVPPFYAq6rFc=;
 b=YHDqMdAgOcu8kwCh+Ud2yDfJRlFz9EfXox9ciIrUWtV8gm8m0H1oQkpG2XFjIeGBZgdwjWB/2SLy4iqnIrxESs1ZRoYqZGrCOhEWSWC67PlYIFOQygImaiYImjF1Qqmj7ch0J3eJA+EInE3CDpSz8PPUDdNXWhGxcVAnAaED7sQr/muIYeJVEPXGosiXanxiUhfS2ltwnbyux+ZV3ALTwRM9y1AxAUsEpJhKrKv0ZyH4e2Gf2g1oHP5UWZVs0f4Dd1B/RhKfWbOJjiqZmBv9HD90HDiOClfR5mg18IKi4K9DYpzf5CEBnw5C0QL6MmOnEokjEaSZRQWaa1NX8qyXIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/fz5VYNnI2lWswd4e3y+ax0NPrKuZ5aVPPFYAq6rFc=;
 b=jtfNaRdEIZOYa5Ze9yFR5WP3UYV1y8441Nz5bUIy14CkOXz+7APxlwb2Hgmqhu8kobmlF1plFv2jdtHY49uflv6/VMRDySkfeR7NDA2iTNcteUp37TSpcgW/4imvKkknHjB5fMuHAmhUoV+O72HDc11FRH77+12j4EB9hr6wVDpDXwXv+He1LDS3FaaSBL6JNJ2IpUBg2sAZGAzEaumxp53eJq7MpHQ1cNYllma3VQqDrxHt7y1KhyfqLP4f1jCpPil6JaCkv7iLBNFi23kUxR1n2XEVIaO+c6/NkqtNREZ2hLnUzN6BGrui2lTEWPZQKLzLzWWdBHeerc4ZYTa4oQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SJ5PPF3487F9737.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::990) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Mon, 1 Jun 2026
 06:53:39 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0071.015; Mon, 1 Jun 2026
 06:53:39 +0000
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
Subject: [PATCH net-next v2 1/2] ipv6: Honor oif when choosing nexthop for locally generated traffic
Date: Mon,  1 Jun 2026 09:52:59 +0300
Message-ID: <20260601065300.267960-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601065300.267960-1-idosch@nvidia.com>
References: <20260601065300.267960-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0109.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::8) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SJ5PPF3487F9737:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e6db156-329f-4057-2f5a-08debfaa8292
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099006|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info:
	exhOCpjGai0qR12B8NUTIb+EsAVb6pVyWeLHotiVidY4rHKhRlHAucGdY4n0H/kEhhfjHMZllZvITzwlxZ4bQrdcjA4g9dlHKyg6VUiC/INuBZQQGJ5/ZfozaU4f+VJcG7lP8kdX4exnd2mBCqSwfNpRi439yPzck/wQNf7N3U7bG0mdcEd9v3wXSEZ130XnT5fDgg2SIEUCG1pSaYZXLSSeRlhetbxXDOhSNmXxsJyj6hgbF8yWpK0/T33RI79exK1qZwYt2i0GG883a7PYYjEEKhwGEfjsteW2q/fGmMJe1Xzj0frAOCUFRSaSQXyYc1AI7oDlAzQmqsWAPOf7yAI2KsjralKJJLhCDwGXK5MpGcCm6YIHykKlSJQINggMiLGJqQ4Vwevr725LsFO1KEnF31dGkoGrS/oo4RvW67al3FoJKLQu32exD04OcLfvDjJJkXmShtylbnOnn4TY0KgPUzlg3gxi1pEbgoqGGlb90hNG3wW8JpDVRMX0zQv31MLPMdw1Tw46x1WoiJEviqtwqQyYAdZw8/0hQlNRa6HYGP+tpsJv/XhpzH+I+6A4TC6dWmJcJbEUhciwCwind4NwUv6N4cRzS5J5wcMevm6tGehY+iAhyS7Dm/u27b/w08bk9SdB/lw2QbcVOoMDfjbLix4ATrht4whNzRbde+Ac6dhpZkNDIr2wFsII7Hyu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z9DW5bOi+yY2vADcyZ11JnfwAa9yCIHEtQtBTZzOqTBuuuZZMI8OfuEhn9wi?=
 =?us-ascii?Q?anr7ErFGE5ol1CG7pmtSt1C/mIytBjQToCioxkq7Tt/jwIoIaFg7M7DChmWv?=
 =?us-ascii?Q?36v8Lfuk4BNpsBV5aZUPlCB79jGThSxpZ0Mn1nFWB6SkwsC7VrNvLuip5SWW?=
 =?us-ascii?Q?pDRMKP55uFxB3+6YqUYh4asHMok6YQeG+1eq1euJkLeetKHiFzllCF08lY74?=
 =?us-ascii?Q?15Dn8n7TDm5Fh51feFARs1C3O4AB0AN7JJQ/34UAbM+1rdKCJ7RQRcDh0yk7?=
 =?us-ascii?Q?S0QCGpCeQDQL04jGy4k6a2ZcLuAo5QElyUbHx9gN44tx+wEZWs5GSmvJUp/4?=
 =?us-ascii?Q?ROv7/o7/7xT8GS1v8lLtEt2inS0AzHGh2+t1Y4Gtf4wzQeLYXRkeGF4VsqWN?=
 =?us-ascii?Q?+5qAvBijUxV/6ou3Inea01uNtPU/OWU4EI9lbF1PfkSNLRvM1FzQ3m9nWtJP?=
 =?us-ascii?Q?nGDkY63DNrqGRE9TNMpEroINhzkmSh4svB6q5t8+vcs6esjpfjk8xz4L8gLM?=
 =?us-ascii?Q?k1tBvGp0M0QMs9fUGDoTYkhplSw2EgGvkfOfYMr2waZkvzgtKHoN1XIAoUGU?=
 =?us-ascii?Q?/GmC4jve0TYZlf6CXjSxjtqEDAISTBUcnDX/p3c4jiSJHsGK81fvOQbH947v?=
 =?us-ascii?Q?tAS/TwoOb91bPaT0clXroE8DZ7VHGfBcYf9U0E8c+Hip4o5Cey3NJaUNfBQn?=
 =?us-ascii?Q?VuACVWc+B1SVH7C9I7XbrB/nsDUBmdncb1UFIfkHem/4rBpDVMi6KziC+r61?=
 =?us-ascii?Q?GkfSarU9Z8YuXJwd2Pbr4gYSpt2X7yyQSa6AbT1EVPYeE28HW13QkJqwW9BB?=
 =?us-ascii?Q?235dw6yXFlXq6EQretH7v8i/r1m5gB/FmoFZN5TLJcqwxKMmB7Of2HLLWVUJ?=
 =?us-ascii?Q?jq/FCeereHFoZYk+RG8kd7sSgv/fIVWoiQCBVBX5R1KiYBUHbdILQb0lIWrV?=
 =?us-ascii?Q?GSUbbQJks0GPF46EssHGtxAUdJDCzzMLzcDaTD04TUngvUs6xuplZrwTXuOk?=
 =?us-ascii?Q?kryXrBYpEhZNRBZz+F51D2PzOCEXNHRGHmgMICn7X4grW7eZAC5g5d9xShWF?=
 =?us-ascii?Q?QBaeyuvOTEbO72c3MYCQ6lHHhpAuVa9RfWzQ6ppIB0nGafPVcthJ1JLUnxgO?=
 =?us-ascii?Q?OQW+K4S484bajVHrxClYMvu/CgKb7uMJCBR7z/B72BL/5OAz2JdxNAvTyKRx?=
 =?us-ascii?Q?a28FR/3srHHtoStwHcWfGbFUKIE2ZoNe7boVgzBwppqlr/Mx3jiUG4w/TgKx?=
 =?us-ascii?Q?+OgjrfixMEKFYEzCbyu1mAK/LKVtxA+JpN1gYXS7D6DW1Y0ihBbwbSXoa5eM?=
 =?us-ascii?Q?Y/cvVOlL5gbt4FGQw10Gp5ps29YrjwbO58l4ByiA/4tbAMO76Rjg7D+Q+4qx?=
 =?us-ascii?Q?Fd+izZ2YRP1tt+vdXPQilKnXtL4IPn85MkWWSWRcBIZYVBtFRDd4v3ZSj9RL?=
 =?us-ascii?Q?tVw0MSzP+Cvh3JDAJMX28hGSBs0FeeGHHaA05rPzpdwKIIvvDwFo1mlvkdYb?=
 =?us-ascii?Q?BEV2N7Hrw/JqUmA/XcdcfKM5aKdS9ccPwkjWl3mzoJH+GU48zs5B/kUbr59u?=
 =?us-ascii?Q?gNQ7kRycZsGGAFXhiCuWgp7ToBWHN+ZbcSpC/0D0WNST/VVRKiUSF2jGM/21?=
 =?us-ascii?Q?sxwnNLQb3FJkIJU3c9nXRJNHJYSQhDTh58rM8p8P0EFdsfR3rbYEG44OeaJh?=
 =?us-ascii?Q?c6+WT92n9YbcuIKmWlNH6nsi/MYGOtySNQdtXS0eRcOxr2z6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e6db156-329f-4057-2f5a-08debfaa8292
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 06:53:39.0480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uuDkNAYVg9IyJAWveMBEddB/loUFHKdd7m2GNO1tAI3Z1VEXimHZoxeItonwnac2DG6Pc0otn9iIhxJJh4gb1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF3487F9737
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-293583-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CE62161A8BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit 741a11d9e410 ("net: ipv6: Add RT6_LOOKUP_F_IFACE flag if oif is
set") made the kernel honor the oif parameter when specified as part of
output route lookup:

 # ip route add 2001:db8:1::/64 dev dummy1
 # ip route add ::/0 dev dummy2
 # ip route get 2001:db8:1::1 oif dummy2 fibmatch
 default dev dummy2 metric 1024 pref medium

Due to regression reports, the behavior was partially reverted in commit
d46a9d678e4c ("net: ipv6: Dont add RT6_LOOKUP_F_IFACE flag if saddr
set") to only honor the oif if source address is not specified:

 # ip route get 2001:db8:1::1 from 2001:db8:2::1 oif dummy2 fibmatch
 2001:db8:1::/64 dev dummy1 metric 1024 pref medium

That is, when source address is specified, the kernel will choose the
most specific route even if its nexthop device does not match the
specified oif.

This creates a problem for multipath routes. After looking up a route,
when source address is not specified, the kernel will choose a nexthop
whose nexthop device matches the specified oif:

 # sysctl -wq net.ipv6.conf.all.forwarding=1
 # ip route add 2001:db8:10::/64 nexthop via fe80::1 dev dummy1 nexthop via fe80::2 dev dummy2
 # for i in {1..100}; do ip route get 2001:db8:10::${i} oif dummy2; done | grep -o dummy[0-9] | sort | uniq -c
      100 dummy2

But will disregard the oif when source address is specified despite the
fact that a matching nexthop exists:

 # for i in {1..100}; do ip route get 2001:db8:10::${i} from 2001:db8:2::1 oif dummy2; done | grep -o dummy[0-9] | sort | uniq -c
      53 dummy1
      47 dummy2

This behavior differs from IPv4:

 # ip address add 192.0.2.1/32 dev lo
 # ip route add 198.51.100.0/24 nexthop via inet6 fe80::1 dev dummy1 nexthop via inet6 fe80::2 dev dummy2
 # for i in {1..100}; do ip route get 198.51.100.${i} from 192.0.2.1 oif dummy2; done | grep -o dummy[0-9] | sort | uniq -c
     100 dummy2

What happens is that fib6_table_lookup() returns a route with a matching
nexthop device (assuming it exists):

 # perf record -e fib6:fib6_table_lookup -- bash -c "for i in {1..100}; do ip route get 2001:db8:10::${i} from 2001:db8:2::1 oif dummy2; done > /dev/null"
 # perf script | grep -o dummy[0-9] | sort | uniq -c
      100 dummy2

But it is later overwritten during path selection in fib6_select_path()
which instead chooses a nexthop according to the calculated hash.

Solve this by telling fib6_select_path() to skip path selection if we
have an oif match during output route lookup (iif being
LOOPBACK_IFINDEX).

Behavior after the change:

 # sysctl -wq net.ipv6.conf.all.forwarding=1
 # ip route add 2001:db8:10::/64 nexthop via fe80::1 dev dummy1 nexthop via fe80::2 dev dummy2
 # for i in {1..100}; do ip route get 2001:db8:10::${i} from 2001:db8:2::1 oif dummy2; done | grep -o dummy[0-9] | sort | uniq -c
     100 dummy2

Note that enabling forwarding is only needed because we did not add
neighbor entries for the gateway addresses. When forwarding is disabled
and CONFIG_IPV6_ROUTER_PREF is not enabled in kernel config, the kernel
will treat non-existing neighbor entries as errors and perform
round-robin between the nexthops:

 # sysctl -wq net.ipv6.conf.all.forwarding=0
 # for i in {1..100}; do ip route get 2001:db8:10::${i} from 2001:db8:2::1 oif dummy2; done | grep -o dummy[0-9] | sort | uniq -c
      50 dummy1
      50 dummy2

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv6/route.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index b106e5fef9cb..14633fd72288 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2272,6 +2272,7 @@ struct rt6_info *ip6_pol_route(struct net *net, struct fib6_table *table,
 {
 	struct fib6_result res = {};
 	struct rt6_info *rt = NULL;
+	bool have_oif_match;
 	int strict = 0;
 
 	WARN_ON_ONCE((flags & RT6_LOOKUP_F_DST_NOREF) &&
@@ -2288,7 +2289,9 @@ struct rt6_info *ip6_pol_route(struct net *net, struct fib6_table *table,
 	if (res.f6i == net->ipv6.fib6_null_entry)
 		goto out;
 
-	fib6_select_path(net, &res, fl6, oif, false, skb, strict);
+	have_oif_match = fl6->flowi6_iif == LOOPBACK_IFINDEX &&
+			 oif == res.nh->fib_nh_dev->ifindex;
+	fib6_select_path(net, &res, fl6, oif, have_oif_match, skb, strict);
 
 	/*Search through exception table */
 	rt = rt6_find_cached_rt(&res, &fl6->daddr, &fl6->saddr);
-- 
2.54.0


