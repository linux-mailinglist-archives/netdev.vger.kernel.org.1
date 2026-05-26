Return-Path: <netdev+bounces-291553-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id h+8JEH9CFWoOUAcAu9opvQ
	(envelope-from <netdev+bounces-291553-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 08:49:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAFD5D1518
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 08:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CB05300F127
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 06:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C763B3C3C16;
	Tue, 26 May 2026 06:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ncA2Ejy5"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010006.outbound.protection.outlook.com [52.101.56.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BE73C3BEF
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 06:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779778169; cv=fail; b=sfweDj7CaNgVrkB5sUhgOgGmRX9LriCq6dVkDdIpdxxCwGDDlHnHUkt7M1izL0JWymSmHsHySOByw9rB7Gc7cV04/0TOk687HvUx27PTQxvatl/1oG4tL4MHelQQplQkUd8hmqxp85xNGEnS1KSKbIdtOCHUtrfHtkKKqJij1xM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779778169; c=relaxed/simple;
	bh=1Lz1OwT58YSJb+mBaD+F5M2VW8nogphpbYieBqlACkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NZ7S1B/e7NrcgEa1EBu3M540L01suACCxeCUf3sCHuy3fAdXYcqjaiTUJUPIJfIqY3T4+Ug/yN+RtlY96+veF0WOdv5ccIcDZf/UPVixPm4lCtS6tK/zWDFgTWvF5FmhXfi1ysJvErlEg0XGm8dCS6RitvtanLoNPw3GpDgSsYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ncA2Ejy5; arc=fail smtp.client-ip=52.101.56.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FOsSxbjaXjiERASFb3dsR95RcdCr0HDqOE26LdqqbWsAM91dDR2gRdr3AFzGa+mW9id6+jJpEF8p8hx/91RaJr32Js4Aib/2y7vRsgVhlU8nzo1+dxGU59TVyROftqbmhic3FbaFq2/72rd+dVRyRWPhyvOmnxmgQReHV2A2AaT8XNaxbMyoUOfB3ve18Qoi0t4BC5UmRLA0zo6R7jaB0hM5YsSaX8gB/Fh6bdoImNgeAcN+70/PWWt+D15/SebmZFCV99zNBlKovC+Q3dLlGzJvl2Phc6iQy05QhFw5U0jtX7rg5o0I3XZVEW5u9PiclEz0Jn2ahoPMHAD4+tk1mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K18Rivmylrkb97MaRqZjXcGY487Dt6FIfLrqXtG636U=;
 b=Yp5lzT9mO4fisqqElCLn/e2g1aFzijXLD8lq+VvCYeprEAtwJIDa9lM9prFuCH57MlMAchN9aAK2bdxe0K7PtPuWGC5Metvsuo1mWBFwp6C0UnLUITsIaiBTkIc325qOH/LjMVsQK0twnuWw/nU6zoC1So/WbRuNgh9S2wZkbhJ/1j1U5//dvL2egxtQm9EQnprP0t8vJvoyPgl80mag8N4UViiWgf6gwjkk6JV/x2LbUfr7LS+XIEJOOIQQlWC4Gxm3j9YVCzgHF1mXQyMWjJemf75wNdpHR3N/lgRxv96vrzdnTKjxvAQ/7D0w0zuK7yQK3166s1/AcPbrvspHKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K18Rivmylrkb97MaRqZjXcGY487Dt6FIfLrqXtG636U=;
 b=ncA2Ejy5+C23JWhKn+X3nSVWFJbgfYDYLtrTRfKFrj8M4jGkDP95afunLHxeiWu6IvsJ5tBYPvfC9S0TIyqZZxgr3TMtadXMfpKSKT+h3zJB5GWVaxDnW9GRKKx1dAQKb7WcP/zgaNNIKcp+trUqBDTMw5Utj9ixHXIBgko1OQGDewbwL21eTbXPIU/tLwj7EyAU9p7r1QZ1kMAZU0ypzPxMJ7tXqhvdhusAG2WCWKSkChFvVMM6U5Svnio3ocUUvVv3TkylhMOHm48EBAK24xku+sdhNsWG3YmV9Oz542/c09+wrZjZPWdpniczi5waIKCn7viCD08Nh62MnCkCsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS7PR12MB6069.namprd12.prod.outlook.com (2603:10b6:8:9f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Tue, 26 May
 2026 06:49:19 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 06:49:18 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org,
	bridge@lists.linux.dev
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	razor@blackwall.org,
	horms@kernel.org,
	sdf@fomichev.me,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net 2/3] bridge: Fix sleep in atomic context in sysfs path
Date: Tue, 26 May 2026 09:48:17 +0300
Message-ID: <20260526064818.272516-3-idosch@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526064818.272516-1-idosch@nvidia.com>
References: <20260526064818.272516-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0381.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::9) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS7PR12MB6069:EE_
X-MS-Office365-Filtering-Correlation-Id: fab4b786-7b79-490f-3a66-08debaf2e90e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|6133799003|11063799006|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Ny7yixE/gx01pDlK5VxTBIWN+OT7qnz0P5sSzcibDv6/uRH8CfkA5kuQzDTlSu/MPhnCWVdJCXf43Zd4A0BiPV64b7d/VpvTdmNHl92LPI3wIglq7BQ0Rz2PiJ+0UXU9X926WD/ZDVM9CZGmJM69MJtTS3r+nq6ddTGP17wEfUhGkF1dO6nc3ekDRmAjtPsrKC6el5vzdK0OpAt21T3MoU4GzyFff2RrzFkrrLIcutBgvcKYCrvbvTBQvQywuHkhftj3ec0T5e9UmoCqQG2Qr+jHTBR/E7P1KtoFYhlhBfZAuU+g4CDcIsZP+SZqBSwrYDHJreDGKGppVQMhm+s703go/ZigdHHllSe3jIilpY/nnLPyM9UtrhILH/rVLrzZVMzLbBW8ATr9V2ZA/l+VxJwxUeeTYt3OeNIjR5MZ1wIbWWqJpefFABiNxm1kZlRjgDoitmroobnp/4tL/orwlpXMumUfw2RJRkb37WKNOS/hpNr72aSiY8odPEqSdIkHV4T9mDJKU1qCbn6ed3Snedh7jm7OBHq8H+keRAMzqKoikxyDArWzwn6ciAW7QDp/ZaJXZKYrxHypgIsUZ8cNTgRB/zHJSpiWupgiI0ax9ghptmNasTxdR66AVS2biLFyu0skf2Cds/BkPUF0hPhmLXZEhqTaEOSKOKt3ZxxlH5Ub9h096pms54q8kqca9UZp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(6133799003)(11063799006)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?snPOc6uEk4dcYELipxsSchft/qWIdX2ukFRp6Gykd7ROp7dCLxtFymNzYkF5?=
 =?us-ascii?Q?udtKZS9o+++cRmQ2SQ+FL5czjVjZyabnGDevuZSLuLvGyN88jWBBb3AAsygc?=
 =?us-ascii?Q?bij67WoGkxze4jGcW3c9EzocoYQ2EAzrFLmhjrgKg7com1zGGypEhjG13dfd?=
 =?us-ascii?Q?B7aJfFqHFKlfWFmMQUsb2KPPWkXF3vnjAIG5kz0YL+V0mUO3mkWgqkkDc+sd?=
 =?us-ascii?Q?IUcCIfWQjh9BrcLHyWExzl8kHaG5BhsfUPsacOXCUwYSkEYO6Oxbe2XpaFdM?=
 =?us-ascii?Q?UI1AIVnYuX+bth1q3F7+XcqSByTi7ZilX/jlRpn+oFinnScP71FB5RhZmcU9?=
 =?us-ascii?Q?iyH7+CFTq/+AvDVf2NbkuiUwLXk01DEsOz/zbhxg+zCGVo9uH3iArcc9pYMU?=
 =?us-ascii?Q?WlsnhiibxL/+b2IEnRz5BEnlG5Y2uVIOjOdJiRtlN1cWA5eJjCRDKeQrkJe2?=
 =?us-ascii?Q?b46cPRuyXHnHh/6+6qW/iuzCPj/nsNOmWhm14c/42FrdfiAGs82BDVH3ujXr?=
 =?us-ascii?Q?9G9q2odYhx6bBIUHLz9X/S72JRHpgVUYWcQXoCAcmGM57RlGWWrR6kIzKnmR?=
 =?us-ascii?Q?WYrO5zQ+/Xp/PXWtVlRHVNWTx/tr1xSB1oQst/CFVRdmcjWGauiNMgrTV2cm?=
 =?us-ascii?Q?4IMhLoj/mahdBZ6ama+4QfNZc6GrPz2roWsSEBmvz35gERw4ucoLyAskM4PR?=
 =?us-ascii?Q?TagVLAJ+7jq+fV70xa4/hKkqizXobaiUduvGrX2qtDwyby+mgybr3AlYDn5q?=
 =?us-ascii?Q?2SyI1G9j/UkNbbbg/8q5CXmT3k/HdneTc2okgQy1lg3+FriTEJaxbhEf4mP5?=
 =?us-ascii?Q?UjdSy5InQw3O96FdqcYdYXx6vRvDKzHKHUjXPOEKNBmtY7tgQwPq3YuOp+J+?=
 =?us-ascii?Q?UgQv3AOWFNBC73ksZLnMxGsRGqNAgFfCi7xOg3vPgdBxSXyI+HRvAAVVhURy?=
 =?us-ascii?Q?TmeqQmnSEFA0ZrdFSKlX13j4OYNoTlYLQnCyWsMndH6Kizk5Be8w+oRfGu1A?=
 =?us-ascii?Q?KYZ1cAHF7nmnk7SxVLb2rP/9/doIAwCgD5SFYknKwWDW1XGJVbZvOsI62ZOA?=
 =?us-ascii?Q?tHXNLklnftosIFkjELaxqcpdugq44jZxGx7kWDged0Sjc/TCJ8+Js78dD6wz?=
 =?us-ascii?Q?MxVfNTMxT9VNa+N156pjR1RxtlJRtGHnLfj/5FvzO6Nq4QDjOIQtLZ9w6Sfq?=
 =?us-ascii?Q?sRWnDROGKoeiUR9yyQRsTFhytBKqD9B/Rl8taEh2GcKKntD7t4YKd39aEtwc?=
 =?us-ascii?Q?xlIvxh8EgZl3LDUqUju+yO/YN+wVqHlBT1mlj2t7Jk4EhonaRgLI9sx6ie4k?=
 =?us-ascii?Q?6LT0+2OPcLvXPb93dErjYvjEJeXxFSC30FnsToH8qcUdnUSkvl8AK13EN+z8?=
 =?us-ascii?Q?yOUBncFLxJKoypcEA+C2Ai6unDe7rckCLdno14GZucdEToGRYXtPFHWeg3TR?=
 =?us-ascii?Q?EpeAKkBt+sTBwyJrrBynUB1bEnRoQdIe1DARl5B5X967T3TYKy+kdOH94AhR?=
 =?us-ascii?Q?upJBdzShTD2k5MdyPyi5Npucn/9+a+nj4RMAZiePk5tWTJVewcR+wagYMM5s?=
 =?us-ascii?Q?BcFcY/44QsTRzIA6ZjDLrOPwA/Jxsb7hz7iJ6JbVTspC+T6J/B8hce6c7jIn?=
 =?us-ascii?Q?LCm6maLrqnGSMMjKMrvwihAY1DBcLBaXNPTvmRT/GWMd8uFEwwylM7UVyx01?=
 =?us-ascii?Q?DUKM15DefNMUsPFXMS+LnL+eJ/FaqVsIF8f/uditi6iRt7Eo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fab4b786-7b79-490f-3a66-08debaf2e90e
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 06:49:18.9379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WCj6w8Cbx5KIjW/+EV4/NFiYajyIdWnEhKSk0kBCUbItX6tisJIX5gvpezDyXu1NTaGiVBnGRww/x8ozk8ExBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6069
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-291553-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8AAFD5D1518
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Since the start of the git history, brport_store() always acquired the
bridge lock. Back then this decision made sense: The bridge lock
protects the STP state of the bridge and its ports and at that time the
function was only used by two STP related attributes (cost and
priority).

Nowadays, brport_store() processes a lot more attributes and most of
them do not need the bridge lock:

* Bridge flags: Only require RTNL. Read locklessly by the data path.
  Annotations can be added in net-next.

* FDB port flushing: Only requires the FDB lock.

* Multicast attributes: Only require the multicast lock.

* Group forward mask: Only requires RTNL. Read locklessly by the data
  path. Annotations can be added in net-next.

* Backup port: Only requires RTNL. Read locklessly by the data path.

This is a problem as the bridge calls dev_set_promiscuity() when certain
bridge port flags change and this function can sleep since the commit
cited below, resulting in a splat such as [1].

Fix this by reducing the scope of the bridge lock and only take it when
processing the two STP related attributes that require it. Remove the
now stale comment from br_switchdev_set_port_flag(). The
SWITCHDEV_F_DEFER flag can be removed in net-next.

[1]
BUG: sleeping function called from invalid context at net/core/dev_addr_lists.c:1262
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 372, name: bash
preempt_count: 201, expected: 0
RCU nest depth: 0, expected: 0
5 locks held by bash/372:
#0: ffff88810c51c3f0 (sb_writers#7){.+.+}-{0:0}, at: ksys_write (fs/read_write.c:740)
#1: ffff888115ce9480 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter (fs/kernfs/file.c:343)
#2: ffff88810b9fd330 (kn->active#37){.+.+}-{0:0}, at: kernfs_fop_write_iter (fs/kernfs/file.c:80 fs/kernfs/file.c:344)
#3: ffffffffa59473a0 (rtnl_mutex){+.+.}-{4:4}, at: brport_store (net/bridge/br_sysfs_if.c:326)
#4: ffff8881099d2d58 (&br->lock){+...}-{3:3}, at: brport_store (./include/linux/spinlock.h:348 net/bridge/br_sysfs_if.c:345)
Preemption disabled at:
 0x0
Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
Call Trace:
<TASK>
dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
__might_resched.cold (kernel/sched/core.c:9163)
netif_rx_mode_run (net/core/dev_addr_lists.c:1262)
netif_rx_mode_sync (net/core/dev_addr_lists.c:1428)
dev_set_promiscuity (net/core/dev_api.c:289)
br_manage_promisc (net/bridge/br_if.c:135 net/bridge/br_if.c:172)
br_port_flags_change (net/bridge/br_if.c:242 net/bridge/br_if.c:747)
store_learning (net/bridge/br_sysfs_if.c:79 net/bridge/br_sysfs_if.c:235)
brport_store (net/bridge/br_sysfs_if.c:346)
kernfs_fop_write_iter (fs/kernfs/file.c:352)
new_sync_write (fs/read_write.c:595)
vfs_write (fs/read_write.c:688)
ksys_write (fs/read_write.c:740)
do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)

Fixes: 78cd408356fe ("net: add missing instance lock to dev_set_promiscuity")
Reviewed-by: Nikolay Aleksandrov <nikolay@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_switchdev.c |  1 -
 net/bridge/br_sysfs_if.c  | 30 ++++++++++++++++++++++--------
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index 18b558a931ad..ee3ad9dfbab9 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -99,7 +99,6 @@ int br_switchdev_set_port_flag(struct net_bridge_port *p,
 	attr.u.brport_flags.val = flags;
 	attr.u.brport_flags.mask = mask;
 
-	/* We run from atomic context here */
 	err = call_switchdev_notifiers(SWITCHDEV_PORT_ATTR_SET, p->dev,
 				       &info.info, extack);
 	err = notifier_to_errno(err);
diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
index 1f57c36a7fc0..d6df81fa0d13 100644
--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -86,16 +86,34 @@ static ssize_t show_path_cost(struct net_bridge_port *p, char *buf)
 	return sysfs_emit(buf, "%d\n", p->path_cost);
 }
 
-static BRPORT_ATTR(path_cost, 0644,
-		   show_path_cost, br_stp_set_path_cost);
+static int store_path_cost(struct net_bridge_port *p, unsigned long v)
+{
+	int ret;
+
+	spin_lock_bh(&p->br->lock);
+	ret = br_stp_set_path_cost(p, v);
+	spin_unlock_bh(&p->br->lock);
+	return ret;
+}
+
+static BRPORT_ATTR(path_cost, 0644, show_path_cost, store_path_cost);
 
 static ssize_t show_priority(struct net_bridge_port *p, char *buf)
 {
 	return sysfs_emit(buf, "%d\n", p->priority);
 }
 
-static BRPORT_ATTR(priority, 0644,
-			 show_priority, br_stp_set_port_priority);
+static int store_priority(struct net_bridge_port *p, unsigned long v)
+{
+	int ret;
+
+	spin_lock_bh(&p->br->lock);
+	ret = br_stp_set_port_priority(p, v);
+	spin_unlock_bh(&p->br->lock);
+	return ret;
+}
+
+static BRPORT_ATTR(priority, 0644, show_priority, store_priority);
 
 static ssize_t show_designated_root(struct net_bridge_port *p, char *buf)
 {
@@ -334,17 +352,13 @@ static ssize_t brport_store(struct kobject *kobj,
 			ret = -ENOMEM;
 			goto out_unlock;
 		}
-		spin_lock_bh(&p->br->lock);
 		ret = brport_attr->store_raw(p, buf_copy);
-		spin_unlock_bh(&p->br->lock);
 		kfree(buf_copy);
 	} else if (brport_attr->store) {
 		val = simple_strtoul(buf, &endp, 0);
 		if (endp == buf)
 			goto out_unlock;
-		spin_lock_bh(&p->br->lock);
 		ret = brport_attr->store(p, val);
-		spin_unlock_bh(&p->br->lock);
 	}
 
 	if (!ret) {
-- 
2.54.0


