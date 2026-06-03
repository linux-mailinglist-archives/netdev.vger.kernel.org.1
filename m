Return-Path: <netdev+bounces-294702-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Z7abGjYBIGqAtwAAu9opvQ
	(envelope-from <netdev+bounces-294702-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 12:25:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0429063690E
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 12:25:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b="I/r07EQX";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294702-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-294702-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A5623306138A
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 10:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E5B37CD2A;
	Wed,  3 Jun 2026 10:19:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010065.outbound.protection.outlook.com [40.93.198.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD4D336896
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 10:19:01 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780481942; cv=fail; b=TIdIEhgveZnBAT66osYVELswpvBZaCWQvobEfc/6/bsz3xbyXMq5MrttfxQxgCAVTSoXIh5fcaPx1BmE/XY/6jYCYeitc3IbDnpoIrft1phCnLRpkCKjW8o619MH3tdvSGTVGDFhxo7s5zPExikKxIXNdHk9Db/j0piq8WKMTOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780481942; c=relaxed/simple;
	bh=pGqfM5jTVJXrbo/hruNxTrdlcgg7DAxYopXixQT6+Nw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AU1kCQCjxBKfOXfADhqjc+zVK7lx94+PBvFtSZlzALnsgZrqOm3kaCNfkmWDyO8ZL8Rfgz7O7QgJaT3a7eC6Gzz0iAopq3LZm/tFaSdDl8ov74Rt7ti6yO6ziiPRZAXIWYTxhxAEpDen9c3vzRaVlSmMEt3bA5/ZG9kJp2fAPnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I/r07EQX; arc=fail smtp.client-ip=40.93.198.65
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aMx6+uB7uqJwQX4WMtJKZ8eL+rrNCN21/iBX3ORsoHuSYchCJewPymG/NMsEVwjoOHrhl2xa+mVX+Bhjb3wv8zfZRNto2XfhSh/oIZLQ+hUe3VqW9VrHirNTy9JYVo2rNgA1oIcMNC3EztoTIhFi63+6bfTTqqzHXwPepGPsiZIuvTOmpvRr/qUy3O/l/qPeyCbT1T9cWahCL2Y2oeGsCAW6/3GCVI0rOheMcezGJtwh03erlSgPTUbnIIruhnFn0AWamH9XcW66FEuLCezI4uvEezceiWfKf1/OYamDZK1cpxd/m1AlhO8wHy+WrxbmhO7X+P+pVM1hbu3MCUmj9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dG1EiP19+amF62J8audo1BUaNUJbV+JAqosDY+lXDOA=;
 b=dU6fskRrkPHSQ55SPkkpqaQgFLoGdFIUwbYxub8EVlb4HzLywjDtfg4rQfx7xvOlmucAc5v47AhoZtbmigVh1PMvt3MK4E3Irqmqh6WUJjzFKeYLq5344EZbzKTNPNYvW8KqkWKY79GIuq1gqw+FI52/w56tPRLoY8s0+qIIhaR2cSsAK77x7dwlRxKGFPdFqxZTfGyjJwIzF6TPA8MnyzAfdk/UXo9NsrdvFSCoRlJm49mCjrLJ6B8G+6FSCQzyHGsXgjExt9lOOwaWdosD/oGndcyOcm+Sdz7fu3QsyoAOyFo0I01f9+fsxM1MRpu5ywGmyw+VO+NV/J/Ec6iTJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dG1EiP19+amF62J8audo1BUaNUJbV+JAqosDY+lXDOA=;
 b=I/r07EQXXHJfKLGkH9nE7VmvG04IolK2S142fhe1QcUkF5H2ij+5CmpFHONlSwORwMYxrAsVdSMiWucKjw4md12cF8HTJG/Ubxc6LXUpTgekZmOMrdn2SfcE75fe1+/54lbePzAkYE8/Xdcdo96Z28RPo/8a7ffmVmVBJm/HsHT2WRfGOu/cc1h48wH6uBjAtVIdf3gvZORTTmD3qW+x0i4rmXDRO/HDTs8RA/bXoX4ggiKhrq1cuERIsF68kQjfV4mRXZbbwmTCGqD+whx7oWfTdtvGyoz9WCzFVaPkQKtlCuh6qqk+NnLm8vNn9SxNBaoh5H7+hoRglWw2PEoTlQ==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 10:18:57 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 10:18:57 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	dsahern@kernel.org,
	leo@depthfirst.com,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net] ipv6: mcast: Fix use-after-free when processing MLD queries
Date: Wed,  3 Jun 2026 13:18:11 +0300
Message-ID: <20260603101811.612594-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::14) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS0PR12MB6608:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d0249e6-a757-440e-aaab-08dec15985ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|56012099006|11063799006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	+PB/qC3wwiOw8Z6Wi1TmUEDnKXVjFvfR0jYG6x394mBE9qKLX6zJPcrg0vVbkeI+9Y3l1BCpwaw4yuKz95nO45VqdI9nZmC812L5wZKApHTfqGOyjZcDlCinDZSTv25kcpzx3Pl/VEMId1+6lFYQMVYj5LQFIDnKefdkmw3vlci9GEVvl+mUWakYhA5Mk0kh1Rn2CeQ0YgitiHbkrPv6Vp6WDhbpaklL5avP313ZNhMPGGSDjnWGEmLv/eEdq5DrOdBDYajjNm03I8W7zp+doOXNmvFsKt5E250CRX/lAW2ObZ9PU5JjdoGCcKnccU1pXUtYAOZiU4TOBpAYcCbrrp4YKhBt+1i0TXbQxJE7Qf6WgG/iqx732I8hCB1bV8UiiQdSRqDJvJsVmRXc5c6BlDr68vyg4C4ZCb5wiT/W+903KL9vbH5rogH4b/6nQ/g4slwxaGI1ZsoY+kHEWBvmWNJaD6cI2KrMi+KTKldSPvEmLH3sNTduaItMbUJ/6boTk2nRdzhp3aB+ezP4dar3GP+oczHUO63IVEGEIN6+mZ3McOWVpwdc3dzxrqTvXXzrna/w4TfW7rbUDMZf0kKlRQkutBrkOo4jvI7WBtIRTREm0CtDc9I1dtIdAq6YZki2r4soy62yUzi5txJkN2EM6lcyPpdqf6nKhlLmQgqCF7jRODo1PyHTDHwGV/JQrDWU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099006)(11063799006)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2cT212SuT5o6OIpKJr+bwwSDEC8Y+utbk3ToBo4y5860LI7+eXdFJTp7rH5y?=
 =?us-ascii?Q?VZoCOYUt+QEUGLlDwtAqaxPHvl+iDQ2yn9frQycfMSS8Nj2ahZQ6esFBCUBX?=
 =?us-ascii?Q?nVR2DpOHEwVmtVdRnwbsMcauq21qg2iVSX1Us6NPBUxPBsqiTWU4o6K+KgKK?=
 =?us-ascii?Q?nLUshJ4B9vB7GpqYC22i2kYl3g5qdSa9y/2iWuK+LRt2CXOkMnu71pjj+YB8?=
 =?us-ascii?Q?FRYQ1QCEY9tzXT6nTtx/gXdqrFUsTfkw+vyUPqGAD0GCtbfgNrnk3bWcWu0W?=
 =?us-ascii?Q?XO9JUJWD5OinbF1nVhNSzy2gfavoUdqN1rTWM9swZJCxaXAKeZZ0MoKJYjcm?=
 =?us-ascii?Q?adbBuKpJOihFPo0LCrrRPna5IvFvuep/wB9tbuhWIQJS82F29KhEwJsBXyEQ?=
 =?us-ascii?Q?5jh6G2GO2x7xeJXOrsPXJb3iRIkep0VUhrdhQ18hVLE9xi/S/4QDro3Hw92V?=
 =?us-ascii?Q?wn6SYdqSDj/ktEc8SdKbLF7gPjGZx1E133BoVjBN8PRPt5DjdqB7P6Qmsf6j?=
 =?us-ascii?Q?ma8kmKkFCSzhpIsrB9R8iVyopL/e+fQcUXfR7PRGmMJ7x9kLOIzH94Y/4ERj?=
 =?us-ascii?Q?p4bvQVqrbq43LXklrR2bn00KTtPaWCFgha5Hc77ltsOyd4d2eimvGFjQpSsd?=
 =?us-ascii?Q?SaO7Qz6y6vcJQfwAJrCbG7tZ7K2PBleAXfRisI6xsNjbGcu5oJoW0jtzetW3?=
 =?us-ascii?Q?DTYVrAJC94IMU6/PiQ/+AdC+YKYltOVjKybLcKSMMyALxc1tXYqWO7U+4B5f?=
 =?us-ascii?Q?SJhexrRk/zRDTspfGHDtrM6CRJ2uomYM9tAsapvf4w1eWwFvFjGKES/SnHYT?=
 =?us-ascii?Q?tEGU5x9fkf0ckmWHsXWpq+i9jd1/wicfIAavUPk6u87JPDCK6/UKfk5aIRxb?=
 =?us-ascii?Q?2inLZoJzJeFhF1ilMh7lwPxffE+dXMbIl5cznLOxs8KvKYPbH4HGuh/umuF6?=
 =?us-ascii?Q?ColXr4AHF1hDhy39Of1xsZR+ZgcrDyOkb4s0pqBvBdXmr/7EKLwQta0QswUI?=
 =?us-ascii?Q?VOpZc5OVx/6J1oh0VNIzwFf6aXc20w7ZQVCaIKOuNas+nf00GWg2d8WUWjL1?=
 =?us-ascii?Q?2tl9RkodBdjp6I7P5YF/vA5BCdk7f4/WWuMs5ja1gZh7dqFgG2jG3MgY4E0E?=
 =?us-ascii?Q?xLrTL3c6S8INVmjzczD4LR8sEHMfKt3KTG2/K3ZKYKhOvPHoKy6A4BSGENNt?=
 =?us-ascii?Q?PhXdYWT0nLNLnM+RW5WELzM/h/lFKzvemP5EaUrl0DTUfpd4/RmA+R4PNe08?=
 =?us-ascii?Q?R+8Copquyxnxk/pgXAy0ld21yktKW0TYRRv0KEhwbAhvca3STwQ2UnElukz5?=
 =?us-ascii?Q?3Rmru4xMxgzvmWmk2rl/HT7yqXX9PIhf72WgpgJQmPot5h2J/ZrVgyOQCWOc?=
 =?us-ascii?Q?YbhCbvnR4DYvD211QXh+O84k+pzdGGp0PHYML7qBIG3g+70aWegR5SO2+d1C?=
 =?us-ascii?Q?Shs1u1jJYf5GSIlVwxvIfpRcZMb+/XfF/SfHHTOhx73GewBBULieP2bLP1AY?=
 =?us-ascii?Q?/4J3hGMvAekz0a362CfAMgVKzbV3UGSK4Ka10TKm93UX/+M3VT+TvedurZfR?=
 =?us-ascii?Q?Ms0+xlVWujyp7qcvco1liXJkVPCY1MxwT/i+UpvV0MuDbEKPXhywL+qg1Iwv?=
 =?us-ascii?Q?z9YnasVBdhv/2efgoy+pJSP9OrT0+xgL6HgIJSTR6SRrerCOIJ3NQPeqONLE?=
 =?us-ascii?Q?Ezq4i0e+z62+J1W0y8WrESZXz9VY9ZCw93arboyf+3u3Kg4J?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d0249e6-a757-440e-aaab-08dec15985ab
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 10:18:57.4611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jBk7Qof6FXyi6/QKUOKybTMUKIjwK54zlAllG5f4hZq9Lpju865qUYvyGQZXkCam22MtUf11IUwMxfwHjsdE7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6608
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294702-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:horms@kernel.org,m:dsahern@kernel.org,m:leo@depthfirst.com,m:idosch@nvidia.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email,Nvidia.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0429063690E

When processing an MLD query, a pointer to the multicast group address
is retrieved when initially parsing the packet. This pointer is later
dereferenced without being reloaded despite the fact that the skb header
might have been reallocated following the pskb_may_pull() calls, leading
to a use-after-free [1].

Fix by copying the multicast group address when the packet is initially
parsed.

[1]
BUG: KASAN: slab-use-after-free in __mld_query_work (net/ipv6/mcast.c:1512)
Read of size 8 at addr ffff8881154b8e90 by task kworker/4:1/118

Workqueue: mld mld_query_work
Call Trace:
<TASK>
dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
print_address_description.constprop.0 (mm/kasan/report.c:378)
print_report (mm/kasan/report.c:482)
kasan_report (mm/kasan/report.c:595)
__mld_query_work (net/ipv6/mcast.c:1512)
mld_query_work (net/ipv6/mcast.c:1563)
process_one_work (kernel/workqueue.c:3314)
worker_thread (kernel/workqueue.c:3397 kernel/workqueue.c:3478)
kthread (kernel/kthread.c:436)
ret_from_fork (arch/x86/kernel/process.c:158)
ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
</TASK>

[...]

Freed by task 118:
kasan_save_stack (mm/kasan/common.c:57)
kasan_save_track (mm/kasan/common.c:78)
kasan_save_free_info (mm/kasan/generic.c:584)
__kasan_slab_free (mm/kasan/common.c:253 mm/kasan/common.c:285)
kfree (./include/linux/kasan.h:235 mm/slub.c:2689 mm/slub.c:6251 mm/slub.c:6566)
pskb_expand_head (net/core/skbuff.c:2335)
__pskb_pull_tail (net/core/skbuff.c:2878 (discriminator 4))
__mld_query_work (net/ipv6/mcast.c:1495 (discriminator 1))
mld_query_work (net/ipv6/mcast.c:1563)
process_one_work (kernel/workqueue.c:3314)
worker_thread (kernel/workqueue.c:3397 kernel/workqueue.c:3478)
kthread (kernel/kthread.c:436)
ret_from_fork (arch/x86/kernel/process.c:158)
ret_from_fork_asm (arch/x86/entry/entry_64.S:245)

Fixes: 97300b5fdfe2 ("[MCAST] IPv6: Check packet size when process Multicast")
Reported-by: Leo Lin <leo@depthfirst.com>
Reviewed-by: David Ahern <dahern@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv6/mcast.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index 3330adcf26db..d9b855d5191b 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -1424,9 +1424,9 @@ void igmp6_event_query(struct sk_buff *skb)
 static void __mld_query_work(struct sk_buff *skb)
 {
 	struct mld2_query *mlh2 = NULL;
-	const struct in6_addr *group;
 	unsigned long max_delay;
 	struct inet6_dev *idev;
+	struct in6_addr group;
 	struct ifmcaddr6 *ma;
 	struct mld_msg *mld;
 	int group_type;
@@ -1458,8 +1458,8 @@ static void __mld_query_work(struct sk_buff *skb)
 		goto kfree_skb;
 
 	mld = (struct mld_msg *)icmp6_hdr(skb);
-	group = &mld->mld_mca;
-	group_type = ipv6_addr_type(group);
+	group = mld->mld_mca;
+	group_type = ipv6_addr_type(&group);
 
 	if (group_type != IPV6_ADDR_ANY &&
 	    !(group_type&IPV6_ADDR_MULTICAST))
@@ -1509,7 +1509,7 @@ static void __mld_query_work(struct sk_buff *skb)
 		}
 	} else {
 		for_each_mc_mclock(idev, ma) {
-			if (!ipv6_addr_equal(group, &ma->mca_addr))
+			if (!ipv6_addr_equal(&group, &ma->mca_addr))
 				continue;
 			if (ma->mca_flags & MAF_TIMER_RUNNING) {
 				/* gsquery <- gsquery && mark */
-- 
2.54.0


