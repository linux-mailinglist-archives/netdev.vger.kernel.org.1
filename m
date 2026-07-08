Return-Path: <netdev+bounces-305789-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6ssHAIxCTmpOJwIAu9opvQ
	(envelope-from <netdev+bounces-305789-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 14:29:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE3D7264EE
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 14:28:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=rRWmJh5C;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305789-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305789-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A3FB2301477C
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 12:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17E543E492;
	Wed,  8 Jul 2026 12:28:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012067.outbound.protection.outlook.com [52.101.48.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7B743C7BC
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 12:28:56 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783513737; cv=fail; b=synl7Gcljxc6LBTywQP2wF/LFuamm//o4Pz1VywTpixvNBBhzJBIHnLZTfq++1RNRqulDUvKalX1Az9HS5GW9e2Mcazr7NJbHV7i+0OXcOywUQcPrnWo37aCvjv5zwSQypzwHsFPvS4Y5w6yOhlgRxsWPe8e5POXl/vS/Zm7U7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783513737; c=relaxed/simple;
	bh=3HrSZSqwlwULFXKT/DYU4pDltJ+q54I7UoFrAkbzPos=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=c01gQwK3orYOrbT6OMS6T9ZUnhWfOoPOUS5NajgOpBBihrr4QGLSKm3HjTB8J8caz6/bBSGUqwn4BqOJWyZ+mcWAfxb4rgIHrUqlffbUNV5fSeALafYnj0EGezfkYPzPYAkXgEbpv4GqII1YxAVOqKphG1UErOeW6SH2KWK5Bc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rRWmJh5C; arc=fail smtp.client-ip=52.101.48.67
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QaAiZu4Vdr1dczgMmYFEfENnPEz1seCO3LvK/+Qz13LOC4mg76fEhjOrc6mdq9S9XYHkjs1A1UHKVmtJlcLqNAg7c47YgohFvghZOgpt6HcTK/8kJbMaDzpQXn391cePV3oszj+lsxxpW+MV095Qn8tTmlDKNhpUX60UnnZ5yQa3YnbPSmDzeVPW7jmCNHdUlqEZ4D1avxTOGWcJFY6SZiJhmbio1K+YqjSCuiIiI3Ot87alIYxbyo04+jwISYqg6dl0O2kKlNKI1jhGhjxV1R52QhvcvRgAdtg0jsfvN7eFtdysuZ5gHAboopkcH6uinximacAvTVsD/WXMQx0hjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k0fG7mh+jjs4A9YUQTbDMGNtrhUE5njt7n/6UnVVTOE=;
 b=Ze27UuqnPkur4zUd4he9zzveN84pOUX3mvGkX2vhjnJMFL7OyJBaFHlgH+u+bHGqZNGj16vnXyDLiJUtkSH3MtOqEZ/wVL+oKKLlgYlxIXj7SXKbnOKD+0tojO4PA7iZ5zW2Tq9eqU0t1T8yMQhTkT8Bi+z+ryi16D9OKLWuU4Sa47ev6+nfz0a16Z/vXQUKvwIjGYdOBED9eoQxzZDXXwDEpDpj/k/zFK2Dj3L1uCW02FjuXm57h/XIAq2OaG5BpvrJ6azKoggiLgK8moy9/fpZSaNBS1D8Ajv7ngwzYW8a5jVYJd4A+fLsGvWOIFldtwAtVTgNM/yKpseTpo4J0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0fG7mh+jjs4A9YUQTbDMGNtrhUE5njt7n/6UnVVTOE=;
 b=rRWmJh5C5iGeBkqFKi8Ba6fW7FsTy0KbxaD7KWSflwjeFLxDk2fnTn6cMHDYP2KPRcZiXxEwhEFAKqIrO2ZOchIk8/kGrnizTmopEDGvrunu45XZC9UyS5gV7Hxm4ZsQzaR01F+ln67oTxI5CKReHd6izc7fcopNQbfFRKYTgL1E1qeD7DALI20hWz/KcCzdG76ylR5fmbYXSDP/FITnaTR+lAXT54/xCZdpUixGKVWNtQ8o8ERR7dlzvILAfchAL+sPFSuv5v9GT+OwQRPJDJkOOh3BFjIiHG0GiUyJBLuK0TEhdPBqVv4EwcdY3q7WyGonghKhikLDMRFqRR00Fw==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DM4PR12MB6637.namprd12.prod.outlook.com (2603:10b6:8:bb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 12:28:50 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0181.010; Wed, 8 Jul 2026
 12:28:50 +0000
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
Subject: [PATCH net-next v3 0/2] bridge: mcast: Fix a false positive lockdep splat
Date: Wed,  8 Jul 2026 15:28:18 +0300
Message-ID: <20260708122820.1298718-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::9) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DM4PR12MB6637:EE_
X-MS-Office365-Filtering-Correlation-Id: 97a1eef7-6b4b-439a-496a-08dedcec775d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	PWU0Afq5q461rOgNvDH5LqOQt6DQLz5AfxBz625DCo1azOnUOdIuZMTzejsswiZiCdn+nke75a7qmRNUBRbQS8lq/39WtCV0BJ0FQwxwFW4B31hgjBI/vXrCHvlr5pT8KzHqc3GNP1Uv8p2tw1qAWtjP2uQ4pd9kOS81z46e7jhZ/cNWRNL8NELtwe/7Xo/aGRWVHyjyw1IlwaiZsNzJ3DNAJYj5Z5w2i+p48PhcxcSaM9FYQeH0v5fI+OlD8v9SdVQ4oj926NH8kehqtPIJTOeHsmeTUX5v8sV3xDQ5UaN/wSIB7sAeRgMptysOVEc4K+sV0OlQYdDDFvVpiRLSwRpnOtSX5R1jkDrB2owIoBj+PwzAoOmPS2DuYzRsLl32LvFlVPFXRxpOZxFlG0phWuKMfQVniAQ9yJqxBzVk+cMnKg0hZQsZbApe0YI4FiYxJFlBSzRif4NRQ/9lEoE3UIo0/HUfPWC7zrUKSCsf10k8nSMrQVne+WBlK98w9iDYo2PuWfMWnsT0Ko+oLE+SODpKQtXgSWQHmRW7BpVYoVIZaDuS80CpDf7Fa/Vf5FqDrrCqpg6iKQnWe2Yb6juH1Lf1XYpO6/3enKJRHNTmNE+LzKC3kF7PkDx5D/qHO0eZkJqJnZ7kjT+lqgKYWrJdwLPX9zA8GwK8nvvJVTZ1cNo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kg0sIVJLYiLTNehkCzfqpLHpJGWz5OKBUyHneCXsfITJ/oxv4VmW9WAPkk8b?=
 =?us-ascii?Q?txRWPitig5CxQsopQgR1fbO/41iMWuefgXS3Ies6iPXHHea2cfb/X0YjinLt?=
 =?us-ascii?Q?8jPujZ9LAkXBtCvL28MU9vuuhVmpSJzxUiHL13/enDSXdDqhvYc6NoHSp+od?=
 =?us-ascii?Q?9EzjgOCV29xxcGFrWac1Zj5NzCfuda9PciSRoH26LpDGVzPhDsLCp3voZr6W?=
 =?us-ascii?Q?VrU58CFHkMCCEziISDPFaoYTkxiTFZnI5sAoocGCn0SAHsQwzaQbyHeFvcFc?=
 =?us-ascii?Q?ntUCX2oVs4mDUdSmcn6ziq3TlER8h/kwK5hHXHWNIJt3+SfysTRWCifnbxGm?=
 =?us-ascii?Q?cnxSg5/IoDLLwymduG5nmhJ3yFO2KUhVgWh8UOFku/Fs74BVL9Yf2vuGer6a?=
 =?us-ascii?Q?XWHsnHXjxoWATiy46R2udHPgEmPJOFjIm+y88IPpxrnpD8DF9Mi7uwljJzae?=
 =?us-ascii?Q?fiZoESpldOU0fQEksdjEHFrQMXXaIfcNY2sSBaBLFCx+MvuRm/zCHpmDpB2z?=
 =?us-ascii?Q?36Hk9Qa6ONxYtUxrwxQtnhfKdPTOJTgmdf8vUH/uT8Itg/FHdvM78+cB2x4y?=
 =?us-ascii?Q?l9iWrG5M8pgzW2/A9OvLRCiWs2ioReNTJuQNY1RZmOPcQGYXE2dSenooFsmP?=
 =?us-ascii?Q?7757BI23Fn7HwTNpCtieHl0jRQ4XqyOD4QuV+4OpCxHopIBa1Pyyb3NNVsVg?=
 =?us-ascii?Q?1VHjt4ZxmgBfhNslM4RUVip3oqYcLJcUAw4C54ILBAOZDzHSkdbKZwyy1mWl?=
 =?us-ascii?Q?gJQAo7fAKx+dqYVTlf0HCkgbilhtPpzUYx2ouc61nxq6YdNhzV4he1ad0laO?=
 =?us-ascii?Q?31pZXKXC/z24dIWzFJKvXi3QTVMfztO6d4vU0GES2PbLko/Px3hSG93fbWgB?=
 =?us-ascii?Q?LO0d7916TMf1lj6zWIM80YVc926RgBg+Gwl8YJtUNZc23T5gUuG2IQ5juBkD?=
 =?us-ascii?Q?0IcAxp3tpO2q9yJy1srj2DoUBUrftIvK9KA2ugEXbQMRuocLHjpjgtG/LsEb?=
 =?us-ascii?Q?7T/RnXjfEziB8zDWg/Itz3FnN2As9+6V2xIsBFFnmigGTP7VSXswXoljN2GY?=
 =?us-ascii?Q?H/6QCwT7UrA0h9y9hcIO2g0LXtTXAZDnmhl3xa0Inh9HU8pewYL+SNaWghRe?=
 =?us-ascii?Q?uHFLvmoaHlGUCbE3ypikBn7hg52CI6mdenM6gjL5UB4KC0eWTwTZ6+yZPBUK?=
 =?us-ascii?Q?kFegZNKBl+/kBOTJf9Oeez1l7cIomK8tuomHwhbt0lush0I7yFnwTqlBHlKV?=
 =?us-ascii?Q?qnTu3snB1cyXEdzt+1dwBua4lff4p5pLxk9UMA/U6fgRSbKK0UPikNYORTQt?=
 =?us-ascii?Q?eUhNghRNS952K/1ragUSOuKTkFiNFyF+94faeJTeqH5Ta3vNAzPA7viKCjH5?=
 =?us-ascii?Q?2xqqIwNtw7hb9or2FhzEM4UdepP4rbpcu9dmOzd5onGGN6Ic4dkPVT3YO/SK?=
 =?us-ascii?Q?6BPD+JdWSTY0OUKaHLTbOQw+rAFppIF9ie9Rqezh4o7T8oeO+hbe2QeR7kxG?=
 =?us-ascii?Q?LknZSQvWDrngpOnWWGICjqG/ov3pVtzHDNcmA0l844d0gLGvGtNmWa7DdDxg?=
 =?us-ascii?Q?9a7O4nKdKp5m9FS+792gu8bRtFzJMYAY0pUEO7zimf3uCTblO3UKncaccT7X?=
 =?us-ascii?Q?N1oiaTXwo+wU2EEQKDworFM6WIwIcstCKB0/a42ijbs6EWDKmv9OLZzYulnO?=
 =?us-ascii?Q?bvt3/Y6Ri1SC0OiqMjae/moI1vrg+stztWrdXMiiFHVwRq1yj1A3mDG32Tim?=
 =?us-ascii?Q?LrEZI1UrSg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97a1eef7-6b4b-439a-496a-08dedcec775d
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 12:28:50.7695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7KHE518LDgaCjks4qCTgmRnKhc/sowAWVa67VPyL2bIMYqZLgwRZhkxrHG64VYIOKYHF06HoPeMdtRmQcYyCiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6637
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305789-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:bridge@lists.linux.dev,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:horms@kernel.org,m:razor@blackwall.org,m:petrm@nvidia.com,m:idosch@nvidia.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:from_mime,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5DE3D7264EE

Patch #1 fixes false positive lockdep splat. See the commit message for
more details.

Patch #2 is small cleanup following the previous patch.

Targeting at net-next since this is a false positive that is only
visible with lockdep enabled and the change is not small / trivial.

v3:
  - Use skb_queue_splice_tail_init() (Eric).
  - Increment multicast stats from the workqueue.
  - Add patch #2.
  - Target at net-next.

v2: https://lore.kernel.org/netdev/20260430162604.1043756-1-idosch@nvidia.com/
  - Limit the queue to 1,000 skbs.
  - Edit the trace to avoid checkpatch errors.

v1: https://lore.kernel.org/netdev/20260426133435.207006-1-idosch@nvidia.com/

Ido Schimmel (2):
  bridge: mcast: Fix a false positive lockdep splat
  bridge: mcast: Remove unnecessary argument from
    br_multicast_alloc_query()

 net/bridge/br_multicast.c | 105 ++++++++++++++++++++++++++++++--------
 net/bridge/br_private.h   |   4 ++
 2 files changed, 89 insertions(+), 20 deletions(-)

-- 
2.54.0


