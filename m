Return-Path: <netdev+bounces-297092-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3GMONg8uKGqw/gIAu9opvQ
	(envelope-from <netdev+bounces-297092-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 17:15:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 507A66619BA
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 17:15:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=FRfyinvb;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297092-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297092-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 10CF8303779B
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 14:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52CB3EA94C;
	Tue,  9 Jun 2026 14:55:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012053.outbound.protection.outlook.com [40.93.195.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5692435E931
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 14:55:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016927; cv=fail; b=OMH0nyk5S6cP0L6c8n5mlxp1qYZTjsZn7k04VEt9sFtO93PqkNY4L9xY9uAQ4rmwOE0iUjWF7ZZ+B1Ux4jqY4udd22Lum1fbYZK8Nj8CPWWfbZ/K9TfUNaHp1ZoqSQJA4AdfPoIxmR90DdM6XJkZgJfuaRbVVsca/4r5StACvk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016927; c=relaxed/simple;
	bh=KeRPOpeyLvAx9lkzn3qetr4QjfebarrUUXh3IbjxB0I=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=f5kr//Ae2c4snnU+tVsR2zWfxXEa1mUE+VKdWJ/fZQdlue/X92MmWg7oxafqUFp1pkI6hTXPIGErIOxTJZJP72zanQLa0esVyrfd10b8kjy4A7OYtIxmnQvIoGsyrtjw8jKZKhII6vCg2t0cE0qBzqtAdgX8Vz1mZIJU6/AGup0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FRfyinvb; arc=fail smtp.client-ip=40.93.195.53
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tNnyyeMTe/BBsVP9l9gTWO2iUNWzaqRXGI0MaQkqcnEY8Zv+hYgIMsvnGI+0Ppb876jggv5laqtr1AVVEdce/OPA7d3xbqzd2TZTuR3dRt08WCY25RZVlhFtU6kAiQCHBDk/qY7VToKV/84CRPLqQEF0SnA+EA/aLy8mSdV8kQAOFk1gD4OxLV1dMRuUlNvLcWrLRsNgqwJ6kX2i64SYsjzgbO0zWnHtpuytYvHM6ZcWrWSqiqHDD0cgK9UO4yeNEHqB4Lol4R2u2tn9ZD9bpUtSYhd7jz7tkFZY2E3Riz0BR7SwH6Vw1KDfgohXnR/KFRDHEyhLRF0Y1jysxtidZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3CcfmfihR5Oxkh5G/W/xNzEnAo8gTsFQZs9Zy7NLXA=;
 b=Z/E4RlVepExhWrVK8NadGdNMDZRlGKQxwhHcZSYxlvzeC2sCiUMoUv9o7CWMRwfhp4gE9OZO0ualntbcwbdT+3bM6bm3xkRnt79UIoTLUgW1CPz5MCznrBVN+0uWIT0kFrJTl/W1KivdikyUmLuyr77dZmXenv6Guuc02EdGWhWjFdWwPygUgclTsdGv2L50F7n/Qkw97Bk+jAN+Npq6QEhcLZDcWWJYF+SddWwDggeZa4YU3liSYR3NfFAS2JbZpvPTVGXmh8A+7J0zFbRonzQV0GYKS2+2Acqh95410bCo3qoIRJK2Q45BnI0cGW0UUj0anZoKWe8DkKQ+PIvK3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3CcfmfihR5Oxkh5G/W/xNzEnAo8gTsFQZs9Zy7NLXA=;
 b=FRfyinvb7oWUDzk008DTnaKPPv3MixJ4ZRaR5kLRUaoWPd954LsQyMhLtQpXpn0jtbITIThAE2sT5yalHwKnuPI8Y6apGqKWoGt0ZVhvmiebEQOxvbR6+zcPB+DVMLW/uiViWrfzkx7F8m7Ab6Hg+aWAXOXyREvswznZjIhE2qzxXqZXlJdUChNXwgsTD/jEfmdAvWqEm0mSeuA/Ni2Q0NxcO50nW7UNERU9OaU7uhSl6G2p6rAjyUTJQbATv3IAFpqkmrsu/XsxsWmyWCEZ0SCXDts6zvRnDGcp8ZL9mcuwDCs5ocL70Cy5SfPw9QaYrpOYzEoHM2nQu/COuVYNtg==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by IA0PR12MB8327.namprd12.prod.outlook.com (2603:10b6:208:40e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 14:55:20 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0092.010; Tue, 9 Jun 2026
 14:55:20 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	dsahern@kernel.org,
	horms@kernel.org,
	thinker.li@gmail.com,
	eilaimemedsnaimel@gmail.com,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net] ipv6: Fix a potential NPD in cleanup_prefix_route()
Date: Tue,  9 Jun 2026 17:54:48 +0300
Message-ID: <20260609145448.768318-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL0P290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::17) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|IA0PR12MB8327:EE_
X-MS-Office365-Filtering-Correlation-Id: 18d81ae4-6d14-44d7-32fc-08dec637205b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|11063799006|56012099006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	gKbph/nS2673C4gRFABywNLg+BLM0GIEs1SmKopynGFI7QYJ3yKJRizwqZkmC8yoUTPg1S7fu8+8IdCE/i4NPvGF5gC1DI12vMw6HM8pQ8wG2CxHgY0LCK8KNqFf+gOz6yJTIoW14D7vQkc+ZqU+WLAvKU8E5yVhJtRG+qc+W+m/MPRLQ+VRmP7olME2aV+HgB1jCwcWb5urtAljGjlHQ1CJvWgukuQOSGCjJdDFkluv2fBC+ZU1XiRapAwCyMGgk+8MlC0yMA9Xw7MbUJ+bmBSuSNyzM32r5lpyV52TOvtJ0VrQuTn7LY4TEOiGHfUycxLIERtoXnoIkQ5VLvJ9YWvpBdExusuIPsu9bMyOjHUg6wA6XevRtsOAqVzBFhkGQdOgiSi/4juafLwXKlWguzTiqou+kqG8RHNLc7oEbTpH2WC2OdHJjLSlM9VjfzhJZWpOqwEuKtbXH9rM5x4F0L+ZPOjsBAz16GwPUIC4Bss/Klh44CESV01OgRVq2mXCNDMVNUntvl6PE+7/y2KO2bRbHRRCyiJcUQyTVdp4kVns8KQO3dcu1nXutl/ZOQnVSZZzBmvNfg4nwXlOgeaBx5Ex7v538tQEm8Kd1Mx1ROBwkKzd3x4CnjIYH1JqPpNGKRw66vukRZmgXYNof00SvMX0yOU4f5BBeRY0eWkQKsFvJWJfctQQQqbfsd8bITkA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(11063799006)(56012099006)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xVzOGwzWe2BBQH5VDc2CnjTj/N/9cfYfulIei9geXD+09geeDOcWb0jxHIEP?=
 =?us-ascii?Q?JS9OsUbvylDUZA8+jHGv/20MD5nV4cBXNrCa+HrnV5mhVd2WAfgrcL/tgsoQ?=
 =?us-ascii?Q?+PAZXhIoui+mHyZoZSXVRJhsZfLvAnETlNWodslXSiaAuDgS0TEc4c1Yzn51?=
 =?us-ascii?Q?bMw4cwa/nmyOCG0IR8AMRsGO+HKbNxZ7OGLynwkrqlXCvKbf7Ss1bqNDEh5U?=
 =?us-ascii?Q?2YW7Y3orQ6XOVtd/tts0gEwtqXPLzGSEo5MqyBtg05QXJIKiotNPT5ud0e5y?=
 =?us-ascii?Q?skWLXCGFK8xbsahn+7geKuxqsIdwO6A6P934LqyBWjIopiduz7HP+A7KCsz/?=
 =?us-ascii?Q?6AGzp4naUBxbF7DFM2PWjsP7xfQWTEgwiEheNmIFMOOV/eIcqjPiR6Zr6dS+?=
 =?us-ascii?Q?/ZO0YUIL4lfErfDhdxG/WqQBG6vxWLHSa3MAkKpUnHh9HmNKxWA1FiYvaAas?=
 =?us-ascii?Q?CmgLim/AgMqsEFB2vxMZEDkmZQQ8JZmYlhP2BkGWIuqvEE68KbhfLZ+n1nKM?=
 =?us-ascii?Q?zl8xy+imc3LUm/yCFkcb+/bVT7e6gJKtuCmuD/gCZs/D/ynvvXXH/o/o9FNu?=
 =?us-ascii?Q?3rwd96MHQNZJ8+FdTudt97lOCwMGi9RGX+7gzvT7g+Cq7tTpy30D5WdOGmgI?=
 =?us-ascii?Q?Tgvb+psdqqsY5AjXQPaYmhGYwmnJRSRJPOiEUt9YcsIgHu4L22krzWzFjHQv?=
 =?us-ascii?Q?SdHivgUUyh7yoXA8cROq7uGgV8EPYoqA4wi4+mynboFGu6gwfAnECGC+Loj6?=
 =?us-ascii?Q?m1+DOTzdnM5Vqe3ny0OSNu4RI8FGIK9W64shCwI0PA870MSh9ApYzLtAXaHv?=
 =?us-ascii?Q?8kFyPRX+U6lJJUExMHwnEr6qj0fnc/FilTcFZ+e6fi2auISTYDFOKCtDaw/x?=
 =?us-ascii?Q?CPhcZNabhvUmtCasZL3or8YCNB+zce1rb3CYR3l6bbCj501OlCSnanNKwusY?=
 =?us-ascii?Q?XTUGHAEfiA9AAGfWjrCdszrEU9QI0oq/iYq8cJbhyy7xuB6eFhBBH5Br6n0a?=
 =?us-ascii?Q?StPq3wLJtOt+gEwCq1sQnxDxrj1n9fguoUGdHk6TjdpP2il6AtHpp+Q/P54H?=
 =?us-ascii?Q?fzseOwxbOuhfViayq5szuRYoXxrZIEy61Ei7VKX5UC2rhIt6N9EEqJzcGvHy?=
 =?us-ascii?Q?hueKIh9M3gPL8DLgcFk+SeXed4/qcmuTwNKQeISA2W5+inSy/5v1797VYWvj?=
 =?us-ascii?Q?E6iZ+ct5khRsI7/K7gGeh3LZKM9LPS+MluzoED3htiIhzgFCjpsixPxswJpY?=
 =?us-ascii?Q?hWqSn6S4/aEU83vtCtB3bPw6wyZiTnoL5NNatChxT61rS3+xGG6A27NBmovS?=
 =?us-ascii?Q?KC7lw8pira60tmq0d4Go52gEvKBvcY7VIXL99z7dXRSV6IuT3M3mz1FdSUqA?=
 =?us-ascii?Q?P22pOJkv9XiiPsYAuXIexKAOitwG8rp+5EqGM/hp880ZEwl1xk1+zstU9Onr?=
 =?us-ascii?Q?aVhhbNMwtMKdFwBPWIl2OT9wL6cu9FZUe5p4z6dJ72PDqC/CuoPxDazFGBmM?=
 =?us-ascii?Q?4Dmjk0QE4ZtOH4BaoM3mnW79Lmo7T9ZRfr4czL1nvDhlp0iu/Kcwipg7X25L?=
 =?us-ascii?Q?Wu2gmnsmYG/Qxlc3/jw3PP6wLGmV9uF/2CPgp/hb6IMdttxC36dai+253zOS?=
 =?us-ascii?Q?0RRHcTLSsi1fuOC4i6rHZ+gxsvAM5I9huSn/uAiPP45PHToJjIgfGmrodWpS?=
 =?us-ascii?Q?uk2iEg0czRpOT55PsnBwJxFn6pjrnGLLjZlNam4tuYqSxOuy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18d81ae4-6d14-44d7-32fc-08dec637205b
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 14:55:20.2603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bXNVBMCa+y7Ja4gOc+71WGHw0jOc80jJ21wYLNVkM4oVfrm2wdEIVowt1QokJNxx4dIMGLyTYzhBdkl6mJ+gKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8327
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,gmail.com,nvidia.com];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-297092-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:dsahern@kernel.org,m:horms@kernel.org,m:thinker.li@gmail.com,m:eilaimemedsnaimel@gmail.com,m:idosch@nvidia.com,m:thinkerli@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 507A66619BA

addrconf_get_prefix_route() can return the fib6_null_entry sentinel
entry which has a NULL fib6_table pointer. Therefore, before setting the
route's expiration time, check that we are not working with this entry,
as otherwise a NPD will be triggered [1].

Note that the other callers of addrconf_get_prefix_route() are not
susceptible to this bug:

1. addrconf_prefix_rcv(): Requests a route with the 'RTF_ADDRCONF |
   RTF_PREFIX_RT' flags which are not set on fib6_null_entry.

2. modify_prefix_route(): Fixed by commit a747e02430df ("ipv6: avoid
   possible NULL deref in modify_prefix_route()").

3. __ipv6_ifa_notify(): Calls ip6_del_rt() which specifically checks for
   fib6_null_entry and returns an error.

[1]
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000006: 0000 [#1] SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
[...]
Call Trace:
<TASK>
__kasan_check_byte (mm/kasan/common.c:573)
lock_acquire.part.0 (kernel/locking/lockdep.c:5842 (discriminator 1))
_raw_spin_lock_bh (kernel/locking/spinlock.c:182 (discriminator 1))
cleanup_prefix_route (net/ipv6/addrconf.c:1280)
ipv6_del_addr (net/ipv6/addrconf.c:1342)
inet6_addr_del.isra.0 (net/ipv6/addrconf.c:3119)
inet6_rtm_deladdr (net/ipv6/addrconf.c:4812)
rtnetlink_rcv_msg (net/core/rtnetlink.c:6997)
netlink_rcv_skb (net/netlink/af_netlink.c:2555)
netlink_unicast (net/netlink/af_netlink.c:1344)
netlink_sendmsg (net/netlink/af_netlink.c:1899)
__sock_sendmsg (net/socket.c:802 (discriminator 4))
____sys_sendmsg (net/socket.c:2698)
___sys_sendmsg (net/socket.c:2752)
__sys_sendmsg (net/socket.c:2784)
do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)

Fixes: 5eb902b8e719 ("net/ipv6: Remove expired routes with a separated list of routes.")
Reported-by: Ji'an Zhou <eilaimemedsnaimel@gmail.com>
Reviewed-by: David Ahern <dahern@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv6/addrconf.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index bb84a78b80f6..c9e5d3e48ab9 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1265,6 +1265,7 @@ static void
 cleanup_prefix_route(struct inet6_ifaddr *ifp, unsigned long expires,
 		     bool del_rt, bool del_peer)
 {
+	struct net *net = dev_net(ifp->idev->dev);
 	struct fib6_table *table;
 	struct fib6_info *f6i;
 
@@ -1273,9 +1274,10 @@ cleanup_prefix_route(struct inet6_ifaddr *ifp, unsigned long expires,
 					ifp->idev->dev, 0, RTF_DEFAULT, true);
 	if (f6i) {
 		if (del_rt)
-			ip6_del_rt(dev_net(ifp->idev->dev), f6i, false);
+			ip6_del_rt(net, f6i, false);
 		else {
-			if (!(f6i->fib6_flags & RTF_EXPIRES)) {
+			if (f6i != net->ipv6.fib6_null_entry &&
+			    !(f6i->fib6_flags & RTF_EXPIRES)) {
 				table = f6i->fib6_table;
 				spin_lock_bh(&table->tb6_lock);
 
-- 
2.54.0


