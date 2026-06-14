Return-Path: <netdev+bounces-299196-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id foE8B22ILmqVyQQAu9opvQ
	(envelope-from <netdev+bounces-299196-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 12:54:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6591D680E1C
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 12:54:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=YkR18vJw;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299196-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299196-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6510A3006B22
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 10:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B249838F953;
	Sun, 14 Jun 2026 10:54:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011026.outbound.protection.outlook.com [52.101.57.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517623563FB;
	Sun, 14 Jun 2026 10:54:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781434472; cv=fail; b=li2QUGBAEoBMQemVUtDFRo5K+zuv2B7l9O2ja0wtxB9SUNsYDJwbDbp6n4IbNZpCWSB33bPx73VUSEE9xoSzTjNBIq1pKzwNG2en/JqrxYRufcd6m6wHTW7KKzuFgF2DkM7a7Brp07Ou7KOS3QsG/rYrQPyOeC9Vtw9SC7jBbP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781434472; c=relaxed/simple;
	bh=S3Ft8ub5MfUMa7keRFAxs521s1RuZKr0rkTLhR7emqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XCZh0vz563+wuoW4AS1TeV9o4u+fcpukxWNNMJ3yY+AS15v6nt2EYK/FIVKc4800YQDZ62Ybozw6ESW7e1N5XUoYjtVW2MvYvhFILpMX3PDuDFh+zgVxdXvs9XE+B/lVlBrluIEFyWiztT7de4pKAy9+YzrYNNKX8z9K4cqz5nI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YkR18vJw; arc=fail smtp.client-ip=52.101.57.26
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xzunobC/yPpJlDleWMWJRU4vzdt3YmKPlGJd6WyVMizwaRCdzRWxcFTWsUm32qJ/U6cz3Yi8pKy78cdckHrEfX/eKKc84BdLW8kXZH8FYqV26FJLJ/dIlRcm5yCfu1eSXT+4Z0TNu9x11os7CUu1vimYbPi8L1bnoybYvQCJRMM5zKeVBaRQtHsNUBpWjWnabCzfPNtuUlFZCg59Ekg9oVQbfiRocTP8j4l3aU4WeZg0oyHIn9XDxZBSK50FpAw4lC86ihsUlXqUqtAg2IAwwTAanmHBzFGtPi6IUulwTkY1RGeeIRFny39/sfpppMg4gWD36w+OGhBYV5puYCoRew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MmKZKZlq3/G78Fbn/AE1qTWB1nRVeMvE9NeJ2Ud14tM=;
 b=CSPbZSaxzunQCWD/TEIWY/UYe/0SBoaJ+1cMiNxp60plWaM6n5uMKyoSrX87NHrSSgi1c9vQuDfHEMAVVeH8iMh5NZqkrDHrpkasXDQad7d721j+Pb3yJ5Xha9kS/KGju7TvSm8cQgHZf0BOuszLqwnWYQpUc0Ni/30KZbCmk0Di22ZNQgPozmvxeDZJfrC6n6/e3UspXpbb/VwbPjbdeyCdcaP2Jbk7Gqi+nccN+ZhRdeFH4gZl246Ij+VMxZCjRh12QfPVMWjnSEf+vqjeboxv1czMDKNuznydky4XKS0P97J2rObv7K4XjCIn8G1kD++DH8WA2mLHjnfMDiAfvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MmKZKZlq3/G78Fbn/AE1qTWB1nRVeMvE9NeJ2Ud14tM=;
 b=YkR18vJwAySYFqp1h0Y6CktaGsEU3m2WEKG8NNnltIF8xNimmbZBhHeHV/hIXMHGIzg8yitgTpe1ieYGLmPmlda5GEXW8n4lLIi5qTYKC+OApOV/EOu2JYUNkpIqtkT0vk8yYTxxxbSG+Rs4Xp3LBxtQ4Mn9joaYh1xdN9a2cybJDuhsh4obtlHVDLIPdobQ2I/geTEa4+DSIFCR2PM5LO83SBpBObjOJHPIqH7iZj6h/bb4e2u6WFu1iwBtsqDuFSP2Q1AoCO+/w8FI6Sz4BT5tg4WMCcwTLrzDOiC7bZtkiHE9qhED9sxOgiOArRrqUScG0bEVnC5OpQy3NHxJ1Q==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS5PPFD22966BE3.namprd12.prod.outlook.com (2603:10b6:f:fc00::662) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Sun, 14 Jun
 2026 10:54:26 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0113.014; Sun, 14 Jun 2026
 10:54:26 +0000
Date: Sun, 14 Jun 2026 13:54:16 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: cedric.jehasse@luminex.be
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, bridge@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Cedric Jehasse <cedric.jehasse@gmail.com>
Subject: Re: [PATCH RFC] net: bridge: mcast: don't clear L2 host_joined on
 port group deletion
Message-ID: <20260614105416.GA178336@shredder>
References: <20260610-mdb_l2_host_joined_fix-v1-1-19746b0b8a5d@luminex.be>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610-mdb_l2_host_joined_fix-v1-1-19746b0b8a5d@luminex.be>
X-ClientProxiedBy: FR4P281CA0357.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::18) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS5PPFD22966BE3:EE_
X-MS-Office365-Filtering-Correlation-Id: 567cf5a6-8aaf-452d-1b9b-08deca034d55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|22082099003|18002099003|6133799003|56012099006|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info:
	Ph9JbivtcKAzTy+MWZgXVZwcst4GDX1baCCrjKheHmxponnfe/uWekxAe6YurZ0Tf7C+vfYfuqYLQQmeuoC2rGlVSJVDXHjMu29DwgUu7PtyhcuZYU0RBWpJZP9BoA8b4s/o9Q4jRlqzrMZKSoRdetT/+XMYeG6e3jEI8R6YMSRz6FpbgY4V1Rt4zNc9hDMevy4MsBj0mSMNa97sYdWOTCW1w0Gq0hIt5xkDho/fEEQkAWTEFqR4ksgwyk0YchCPaCqSzQUSEXl1xqYzYRYFjWm80yx2EHxIpNyf9jQ8+wQYvnuKHbeCdBkxlsy5qXhSILZdFQRtJx9aLpoJ4yq/QvM1UwqegSTP/Une7026wUdTQguAVRIUNqGX8rM1MQMQe2b9T6BqIkQaB81EaPKtyGhEdYXaBhrE1a0IO3t5SkC+JNd00fD8yquBzhNwG8SckAwWupge6R2xkzcban2THImmHvFIL61FCqYt/mE9AQ13IyqjcIvfZQ3w1Q5NJ9oMlWOoOkGUxyLZej/YIXmr43fCttSZBVlpxg/L82LghC+DA8HnrNiL+uvP2kyaO36umrIEylopJk91EggRhnvh8TCrdQzbkJ0W01NuSfWY4naqjX+SF7FrBxiql3tKyhC+EzeAH8ksKq7oMNICotc86VXbfFIiaATgXQ1yYhbWujJ8ucPlqdyfbqEFyzBCzcLZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(22082099003)(18002099003)(6133799003)(56012099006)(3023799007)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2WnlryAkxrTvsNDBBL4rmXVWFjCadQ3vLpUWYITu2r4LAkVh88STmFbhO1iH?=
 =?us-ascii?Q?cVYFK07TXrt6p9NNfSQXuDJLbpPOwZ2dkJIARl4hvtMORPIqUHlKQyi6OfZ4?=
 =?us-ascii?Q?2zlzDRvY/r1rrQENUojKjBMtkRb7yp2hngtCRuVxnrhnskCbpH+eMctEgMZH?=
 =?us-ascii?Q?IQZ/5bV0VTVt1WlvQNc5iXpGQ0EWmMa6FUtV8IziQdHShSJ+tNKUgfOKZ4eZ?=
 =?us-ascii?Q?Jd/JABtiOxd7talZurv8utbVu1J9RqKpvrfUMXJlmS1OzgbhpR0NNW8xcL4x?=
 =?us-ascii?Q?6vDJY+EgBn5/ssBOX/H8tEGgf3P0GL7LRNSC0KJogAiEHEm4ef5ZMkbAvfuH?=
 =?us-ascii?Q?yloaz58qIB4DO/8IB4Kh8ogye+gHHffPcRTSu6T44aEd3+hwc0jCGGgN33pQ?=
 =?us-ascii?Q?u1h9lu0NlKHoR0BxcEaPJG2AhwL9T0gzbOIh5le+7l594FPucua59awrJv2l?=
 =?us-ascii?Q?0A2nvmIOpsa+wf8fhgrDrJcLMzTXOYvRbbaNZJwjSQDF1ElrrjcoC9necTB4?=
 =?us-ascii?Q?vVDG+kGqDDiNxO9ubmdbb7yXq5G4GHnTM3hqeRlpS+1mpVxs7xz8OB4ISlPp?=
 =?us-ascii?Q?tAhJCaRb+XW4vub95tq6CTpyqdVlVWYZJHOMTh1qKOKfQc65vI2tnGRSXHZw?=
 =?us-ascii?Q?PFUU9Bbvc5CMHNH/qpHKTN1kITGsHM2oRS6lcdmib3zAA5Xr+TT1mdXwJ67d?=
 =?us-ascii?Q?Nl67l8JgxJwXSCX9CaDq3QlIWFxfmviPI9DwAG12QfB4xWozLZ8KVWYNzo1m?=
 =?us-ascii?Q?NVE8dMEerE7IjM05C1tuBeHXnk6LwVLCwce1K10JWFl6I1SQol9CtS9b+YWR?=
 =?us-ascii?Q?oFQXPWxVT1DAtBsRa/OSjnfdSekyYEuwQ6SZwIk620Tj50r+qsRSdpM6tIVU?=
 =?us-ascii?Q?aJfJQh5ZGGF+LZf5Kxoq84jD42NXpdppmvsKKyjaqGwjpeuMN34t37Xpta3d?=
 =?us-ascii?Q?BaQ0JCY+Gd2GoyjXKlEwnhfVy+jw2qdX6H7legf3XcH3qpyAKIu9kh/bqtii?=
 =?us-ascii?Q?eeSo+Ts0bIl/6XhA42tCZ3sWqlEQGrYse6tAYFoScyZKD8yUAU4I/rP0ETmu?=
 =?us-ascii?Q?MCe9ljAu/rRtN0YG6YRQVuowAM10Cd6A0xQuypRnlM6KB0l8YVhRxOoe/tyx?=
 =?us-ascii?Q?Y+eAlbnb9o7Oyetu26VblmKvwGmuWu3tfsczX66PlgwW40AkvZYzgmqor/qK?=
 =?us-ascii?Q?VGas9dSxW03U4KeuEpjlMDGWCFZExpITEAoeoUsZ/w7OURTtjnR2oUKXJ1l/?=
 =?us-ascii?Q?6Qud3O+MCGxrbey6Wxe1NCeouQuZpXVMl0frlncu5fbhl2WCsXyUHaskYzQf?=
 =?us-ascii?Q?6sSITcSK7H46htKYUx2DXHEpIE0yT5//hScvMjBobb23T9KdfYqDLOcKYpUb?=
 =?us-ascii?Q?sDcoj22DrEoXmhRBc+sgOadkk7zKXQFCXioc2WxNMxHZm1aYv6hK8ETObyOb?=
 =?us-ascii?Q?qQyRpfCHT9eQn1xHsFpOpJ1XZP2T2IcZnQj6NYFiw+Q5Q4opugK2AAO1d206?=
 =?us-ascii?Q?LBO9QNtyRbMaWBF/53ZUUKfc1xVw3zGuZ4aG/A3rdlT4IfYbz2uLWiOdfHE6?=
 =?us-ascii?Q?mXCA+zG69g9UPaBxxopvJQBJJWkLJwQi7ZneHJcGYei30zHR/tBpZxiu/+gP?=
 =?us-ascii?Q?luXX4LOUtemXkbq/ODcKUWK8AhcAnSkzHyQIqnvMUQZpFacWJRAm2Ab9ukw9?=
 =?us-ascii?Q?ZkhcWwEG1SCxaX6M/nwqZQivaUiLh+4E0MScsvz263PSR2S6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 567cf5a6-8aaf-452d-1b9b-08deca034d55
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2026 10:54:26.6152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KYVW2ImobOhipiMMgFAJpav1rf97WSWGUO+h5Df/Nr6O2jr/CX1AhtF72naSil/kFUCltT+9fIRNyacui1Vstw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFD22966BE3
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
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:cedric.jehasse@luminex.be,m:razor@blackwall.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:bridge@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:cedric.jehasse@gmail.com,m:cedricjehasse@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-299196-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[blackwall.org,davemloft.net,google.com,kernel.org,redhat.com,lists.linux.dev,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6591D680E1C

On Wed, Jun 10, 2026 at 10:31:23AM +0200, Cedric Jehasse via B4 Relay wrote:
> From: Cedric Jehasse <cedric.jehasse@luminex.be>
> 
> For a static L2 multicast group that has both a host entry and a port
> entry, deleting the port entry also removes the host entry, and the
> whole group then disappears from "bridge mdb show".
> 
> To reproduce:
>   bridge mdb add dev br0 port br0  grp 01:02:03:04:05:06 permanent
>   bridge mdb add dev br0 port swp1 grp 01:02:03:04:05:06 permanent
>   bridge mdb del dev br0 port swp1 grp 01:02:03:04:05:06 permanent
>   bridge mdb show # the "port br0" host entry is gone, too

Please show the output in the commit message and also show that this
differs from regular (*, G) entries where the host entry is not removed
following the deletion of the port entry.

> 
> br_multicast_del_pg() processes every non-(*,G) entry through the S,G
> path, which removes the port group from br->sg_port_tbl and then calls
> br_multicast_sg_del_exclude_ports(). L2 entries are stored in
> sg_port_tbl as well, so they take this path too.
> 
> When the last port is removed in br_multicast_sg_del_exclude_ports it
> sets "sgmp->host_joined = false", clearing the host membership directly
> and bypassing br_multicast_host_leave(). With host_joined now false and
> no ports left, br_multicast_del_pg() arms the group timer and
> br_multicast_group_expired() tears down the whole mdb entry -- even
> though the host membership was explicitly and permanently configured
> from user space.
> 
> Keep removing L2 port groups from sg_port_tbl, but skip the S,G
> EXCLUDE-mode handling for them. The host membership of an L2 group is
> managed solely via br_multicast_host_join() / br_multicast_host_leave().
> 
> Signed-off-by: Cedric Jehasse <cedric.jehasse@luminex.be>

The patch seems OK to me, but please add a test case in bridge_mdb.sh.

I checked the code and AFAICT this never worked, so target at net-next
without a fixes tag: Support for L2 multicast groups was added in
955062b03fa62, but at this point the mode handling already existed in
br_multicast_del_pg().

