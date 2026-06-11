Return-Path: <netdev+bounces-298181-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id h+lgH4DYKmoJyAMAu9opvQ
	(envelope-from <netdev+bounces-298181-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 17:47:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 100A66732D8
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 17:47:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=MQT123r+;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298181-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298181-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 64869300BB9B
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 15:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6D133469C;
	Thu, 11 Jun 2026 15:47:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012001.outbound.protection.outlook.com [52.101.53.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C4D37F8C0
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 15:47:01 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781192825; cv=fail; b=erO7DvCjaVShTy6tRXKraG1sH6f6i6AzCYMz955J9BbZiT1eWlrV6tV5mLIJ1/B2icbuVvuqtMHsmiImhrr808/klUuYNP5Pf0ajaTvXTxdB6P1gYGyt5Cmtl9t4/z52eRS1fl7xJi4vMTCWPF320O4draX6V/kb//o2Rn8B38o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781192825; c=relaxed/simple;
	bh=FygW1t34YgHVsTBWsyAeuWmetSM75k4lbNvRi1CwM48=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gKU630TH/8GYjvQTTOQk9kojOQfMo78lWhTOVEgoG0iIsRhVKkF5iYv28lljcBkdrQ8RRw+c88dU3UuA+E01qCrgQdKcvnOfaXwoaEUoJuLQGJreRA1aBjEQTmyq7iM1PrF8vuhaCVXJ6Obwmguv4wMQCoxFRzvWprPfyM5stlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MQT123r+; arc=fail smtp.client-ip=52.101.53.1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MUNacXJibpNHroXkKWZXPI65QAEXPFFmEnMYAvh3MY0dDzykXDPMo7QZrpEGwSf2gzIvMfxPdOTAfPmwKDmt/09loHMy/794BDbVoysV/cLVtxevLLxGWJXAKjhaluN4Mg/tMJbtYsr5NZ5GAhOQcFbCk2m1ws/8KwJfnH6Lpq/lBILiQV5lVjeRKNfVxkXplI+Rudyv2CrpiBzXMcNgekpe/0+LLyG/PcJVrcpdJK3UPIHlqiqGnSYVXI9hR35IZ4Flxctqq+1fHY6rdVNNjsAeqgqj0kTdRLC8ttqhblt0pEbgqb82IUJYqte8zQCumsbmE56V39isvMcOoZIG0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5nRBEwUi7Yc25gOwiGyNSIwXqjqSPWa5b4dRNgy7zmg=;
 b=NWqKruHDeEKbBFpUwENToCGNraq2I+3YY7+jf5pO/9qRYs+POXnpSaV2Kay8uyNfuQ997LjjwUVPJd4eWqWgTedOtv/vU0xQT7A1+dkHRvj+MRjPR8z8tUvA7wdV8CfO1lTypbpqZfV8/a1bmNiUbZEikaqHxqXvPCpApBfmySkDqIRTZaKeOJYTBSoK/mKeeSsIHKf6Ak5pho36m3DBtqYSwUPYENn3ROiXgw6jr/Fm3lJ6BfJn3amcxcEHCvisBQnDcntcIT1Pt4hahRSfRp7YrCg+10Zl0IJLJIs5nvLJ+FEDZRIaIGxRPHsEGTOHLagZNMNUKL0VJPiElYPTfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nRBEwUi7Yc25gOwiGyNSIwXqjqSPWa5b4dRNgy7zmg=;
 b=MQT123r+5kIMuzxerOwpuHfyTPvsdAiSqwG5UrCrvz3IxyXKw25Ci2CTikuBchlotAK1vWOJKLtLWIE/vTPAV8GzXX4VkaPg3F2G9HNaCzPDwv7423kN8riGQCe/aI1HHIXPNop+XxFmmsWEiuv4RXXZBg4BXstOI3kHi0RZtNVewrzLxdduHqYYUXGVI5/w7neffXWZQXX9MpR8NvYP/242EzTVqlf506j9ss3lUkSQz2Dbe8vtGyxPtHKnv42svmOqPIlRduy80IPRz+tStHWCfJIcqCuH/TXX7nmrHLDtFWEMKJ2AgjjadkSutcOM5IZS4GNq6Iu7AYygBTJBbA==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA3PR12MB9157.namprd12.prod.outlook.com (2603:10b6:806:39a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Thu, 11 Jun
 2026 15:46:57 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0092.010; Thu, 11 Jun 2026
 15:46:57 +0000
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
Subject: [PATCH net-next v3 0/3] ipv6: Honor oif when choosing nexthop for locally generated traffic
Date: Thu, 11 Jun 2026 18:46:02 +0300
Message-ID: <20260611154605.992528-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0023.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::12) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA3PR12MB9157:EE_
X-MS-Office365-Filtering-Correlation-Id: ba4b637d-b4e0-401a-1d37-08dec7d0ab28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	aoWNgtVDV/Kw1a3M/el7RfDFON08MTVA68nF9gmvckrDXUG7OoYm9HpHddPaE3IqV0vlZZB2nQjzZ/qL9x+W8liaUH47BJiCKQ2yg30jybJVuLHsW8QDGuN7dbG0z+KHlgfOiSAPUXTIjZlT+3s4iKMuVXbs6d0dCEkmCAOu3CsDEp6J1xNMMs+IM8e6oiHgFG7Zm+ppEw0BI4oOtNT7yYUPCgKncUUT4zjn2tPzh+aS+MzQKLf1rx8F8DzF/NbA6OnEhmE/QCqzF8lnnM+HT8iWxZo285jjYKEJHNzLewx0GofgkLDTnvfQGdxxiofk5hKDZuAXVJzjX0lM+5RcJ+jrsC6c7Kuj6uAW5jGmFOX20k2MR4XY+alreZbB1uR/MC1JXo9QKqtBDODH0l3b6RjxFrdsoHNppuNSYZQ/ixJxxzIffBMH8SHXB1Rl7pr1DiP2g/gjuucel5QoCXkoUsIMgMsRJnE6gfgyURe+KQjv4HK0vtVsjkso+bW1hG+Sx546+TTaDLJpsxh4t2XPE7j+SBWYU0Gfk0jDIc/1IINrmjGglCNca7cQtzGMVL8YSn2oaIDjMzJZiXfq4LhSIZHkGHA1o/Oy3eV/SQMqCSCCJbiXF4MKQ6DttNE01MLo6KpzxmJ/EIha2GGIXW2b7bxrwtZk4MHyIrauceZA+oeFZtMVU1URkkTOIEKei2vz90xrcExxvtYmvoF61cO/vw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(18002099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7JIQtEJN1ew+X3YYUaUf3rabui8qpYuMN16XcptOMhAP3q1tuznxDnSlrtKE?=
 =?us-ascii?Q?MRjAPMlDrWOcJMPEkcrAQ9ZMKOwUeJjzJRoDPWwjfBG7/id5cro1HhucIjyL?=
 =?us-ascii?Q?te74hwqZ+14zyYXt5eetrslu90W6QMkSeaaMZKbV8ZqCROZ3Z489XDo1NMrD?=
 =?us-ascii?Q?8JhTgpR6GS7gVjsa2XoMbDUdvpDfyV9CD+hqh9K2j0mEbwrmE+tjGItrxshh?=
 =?us-ascii?Q?443YwkBMfy9GhhMN48KV/NoZHzVyJpr+KYNaYBu0T9ssUo6dFt/8gKxkFnYo?=
 =?us-ascii?Q?hT/nQ9luKTXoIc7bSnjXq29HklgMnqSbb/Q3bQzQSBZ1oL6MDIcIqdyVYn+s?=
 =?us-ascii?Q?um3NmRD+gLSpftPta5jSmygT+Zc5hWf4Wb+djLuFsceMYX6JeGWVV00ATVXF?=
 =?us-ascii?Q?OUnT8guxhvDH15h9dptbKwolfVW1ZUkybP9b5Fky9Ewx5GJ5knVvz8n5BiTL?=
 =?us-ascii?Q?BP7e3YDdzDJKQGzqsXYzJY/u+3qWorwjwc/hxPfyomYwk2+t3igVYqHgzXji?=
 =?us-ascii?Q?2xWUHNz+iAslFJDFF0zS9L47u8GTJDcoDqg9vU/MzTS4isE/Izr9M9UFi0rq?=
 =?us-ascii?Q?y+UdS0R8IhGs6ev0zehzXRHlHJrZjkwwZbnbBs/buqdyNZzTHItvHr7TEkZ0?=
 =?us-ascii?Q?Pi8e1UZCZQxjOC9iO4tg6c9ln8aY8UyxJnHCWbHP5ikrqhW2lF12KMun5Nxe?=
 =?us-ascii?Q?j010WjBmReNDPQ8PE1fEX6QyJw0D+RYuX/V9dC9+1rxzAsLqLeSS5vAw0HJ7?=
 =?us-ascii?Q?Pn4FlCTQTNkNV7koIoACT8G5FmVu2xpolOgb7MYs2KmvOcnkhjXHC5jJ/QAa?=
 =?us-ascii?Q?sv1CS02XFaY8NRipxv8yxSirUuAeF0OwaQlAcy+l6fSHQw3v4Gc5aXOLaTXB?=
 =?us-ascii?Q?BLV1Sv6kmjj50+1W97jmDV4v8wmsAcfBEud4Qhx98x2oZGbae7BSlR1I43LN?=
 =?us-ascii?Q?51fIMJok7Dr7N2tNKR7TN4KljF0Idy6kpPnGQTL4G0OUTjLpQ64SkPrd2JPW?=
 =?us-ascii?Q?p+8daeTvyO2TwMQgljX8pUmRyK23uOkO/Zp4Lzt5UdavZR1E8at8ksyGw9eo?=
 =?us-ascii?Q?65sMhqSm1fVFOp9ADLM3tQ15Nk4pEuJxH6XgpQoEgjFTsxIMZPs7v3PIEnE/?=
 =?us-ascii?Q?vq8Y3gKMiDHjjT8PDUy5erwkMYsj2UvYBeeDOC+OhA6BhLjZCvSP9g3aSljX?=
 =?us-ascii?Q?KScVt3Mk5e+u3KCRSUUHb3uWwtzVxHio7/wha4ZRlNM2VhKDUk+fl92fx05p?=
 =?us-ascii?Q?QNO51d9jy6fghfXOpdY3BwVxDYmi7k7uV2sCes/nso3nFL6XsJDtj8F8EgSd?=
 =?us-ascii?Q?PlhX6eMoHwnT/SVsdyjV1u4O+xrpAr+1VayliywCw6fx6VYFDTcvWi8FIEdU?=
 =?us-ascii?Q?KCVrFTuDq6GkU8haaSVL6sTgbPUmH7gg1iTWJLY5zQUwVqztUGUn5RZQflwd?=
 =?us-ascii?Q?vZ0o1buJyTAxoTllYxkxl0BwPJNj2N+HF8Dlxe+RLusfWZ3kZbX9FODq7zBk?=
 =?us-ascii?Q?mHdhWvjGkV5ua+vpVB7q9uwxTn0lYy8XYs3ul9dyZLr6hdktCjGm5UV1DVVn?=
 =?us-ascii?Q?CdMX82DItGCtr/imr+m6R+1hjqMxQc5qzUHvodzw9sozX+FtFpg6pDGeq9J2?=
 =?us-ascii?Q?Iu39naP9M+nZ74Cif2T2HcFQc4lFiVcoFvqesICVNEJ4358uv1XjA5C2dSuF?=
 =?us-ascii?Q?8Bi0X1sN3EuUsY3E7up1+JAr+5Epj6FyfTPPxjB8VV91lsm7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba4b637d-b4e0-401a-1d37-08dec7d0ab28
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 15:46:57.4635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QzjR1iBA0b0NNzqmK5DMfIxKeQM+OtGWIkLi3ROGBN+cON3Ni4akdtdSxPeAFcK9MN82nwXzi1P0L+hZ8ijwiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9157
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
	TAGGED_FROM(0.00)[bounces-298181-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:dsahern@kernel.org,m:horms@kernel.org,m:willemb@google.com,m:idosch@nvidia.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:from_mime,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 100A66732D8

Patch #1 is a preparation patch following the comment from Sashiko on
v2. See details in the commit message.

Patch #2 aligns IPv6 with IPv4 and changes IPv6 route lookup to prefer a
nexthop whose nexthop device matches the specified oif.

Patch #3 adds a selftest.

v3:
- Add patch #1.
- Add tests with nexthop objects.

v2: https://lore.kernel.org/netdev/20260601065300.267960-1-idosch@nvidia.com/
- Add tests with VRFs.

v1: https://lore.kernel.org/netdev/20251224161801.824589-1-idosch@nvidia.com/

Ido Schimmel (3):
  ipv6: Select best matching nexthop object in fib6_table_lookup()
  ipv6: Honor oif when choosing nexthop for locally generated traffic
  selftests: fib_tests: Add test cases for route lookup with oif

 net/ipv6/route.c                         |  22 +-
 tools/testing/selftests/net/fib_tests.sh | 251 ++++++++++++++++++++++-
 2 files changed, 263 insertions(+), 10 deletions(-)

-- 
2.54.0


