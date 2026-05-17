Return-Path: <netdev+bounces-288727-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBtYN6awCWqElQQAu9opvQ
	(envelope-from <netdev+bounces-288727-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 14:12:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D32560E43
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 14:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B6FE8301107A
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 12:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623F934F49F;
	Sun, 17 May 2026 12:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IfiPY00x"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010034.outbound.protection.outlook.com [52.101.61.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2D2346E73
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 12:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779019928; cv=fail; b=mB8Vh0xp1jqUQ8CI70oac97c42LlDIYxzLzNF9QOkhrm3mtxAa3vmy8HsD2rJFbhbZot7MZ6hnqFtBiuu7URSPaRWOqeI9mjkHLwZufRR6iGfVYI7q/b4jibB5AnQaULlBOLKZ3wsnxgR2dCptUbuTcV7QpAW/zhJF2ArMFxObM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779019928; c=relaxed/simple;
	bh=vUveO2Ww7SPTunmGNT0vvhChFcDY5m4KtSjd5UkbZZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NPSqFJh94VdkYLk38RjRJHF1A4X4gmG6Z9ExgkZ/APfIy21oXuaaT2Optxq9/ptfPP0YS+TmSpzvt9czZw4NeTUjWKCQgBgG7ZInaYGnXHwrTLCcwBc3AxZsF+lrEXVtIhg3FKpeNkIuEriGBuF+YQ0V4dBrpTukjPgdYYo0Lao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IfiPY00x; arc=fail smtp.client-ip=52.101.61.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J2A2OEw06Odybz0D6Gb5QRjNLlCWvz8rcX6QabpT4nDQllIoEyK9Qz6ehUdIfwAUVuuB0iVNcgB9iVvkRNWhw6+nRzlc8ZOaFWnKOczbwERqvzMJ0VfHc2eBLItPjxqg3bRz4JEBxTXeedmEpr0yzp0wGmMd6ZX+cZPl5LxraI4Vf4/6Zo2JJelwjsp3YkRykkgAxS22uu+Japmx1LEDYP99gOLgXOFjZ0XFbmjylc2U9Pgt7GgxIuaSsouwOkVZi57U37croGX0HyyJ9GoLvPg8pFSZY52tkS9NddGa1KGvFtsmVrY/dOychK3fju1vZ78UZ3KxURe9iNAJNbOt8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9wK4RcPfHuasMFMszA99DrYQ6DN8FyUSyBlYSMrk7rQ=;
 b=icgsWsB8DQsg3nPHKPRcXCC+CbANoIaD8a3biPaZaRPnIO0IEnqI1RWbscp5BgJsFaFd5lzSsOCgnoZ7X2EJSKFh4wtUb2oaM7DpKWBJpae/pxklhv/1gbkQtq696cBIfrwNxgtU46JUG7IdDO3pP/MfLPxKT5b/7MHp+H2hc6fjbCAG8JrOdVp5xZ/Loptnrpm8LOi92vsIFzUlAtrS4Ix38imCjLLKNvnPLjJkYIsCiGy4r4P46l3+fGVhtxoTVchnw2Ja6tjMzAFeTMqGw6NE05HHWQK6oL2ZxZOIusAm6UxxcdI58PUmXgLJ7bTd4aFEyPCsGp40dzDWCY5i8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9wK4RcPfHuasMFMszA99DrYQ6DN8FyUSyBlYSMrk7rQ=;
 b=IfiPY00xVRbIqBK4OYIn/gBUWxKeSpULsF04ePv3jzvzdRl08jUgffS5sfiGQqfciOUz4CokQETr+qskzfr8Om0Lm0Q+HBzcQBsxKXbl3w5zvSltaq6vyeee6nxoSZ9SOIL9gVmbOz0rwb5VnXpRWLLDmpX7fpfHbFeBsjFqg4rwQQTI5WN+P7CbgsJJzrd9V9iG027SYkr6r53Wqxq+PpNEcvde7UndTzQ7zjhVi8bMgPEkm5/grvE4RMfyDhGvmhwnniJo97IsuMn0wif288oHn7BiGKABQd57LNoOE1HPFqKUOGUcXphBfiHdt/65qPriS6C28SP52jyLxEy3QQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by LV8PR12MB9112.namprd12.prod.outlook.com (2603:10b6:408:184::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Sun, 17 May
 2026 12:12:03 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0025.020; Sun, 17 May 2026
 12:12:03 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org,
	bridge@lists.linux-foundation.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	razor@blackwall.org,
	horms@kernel.org,
	dsahern@kernel.org,
	yongwang@nvidia.com,
	aroulin@nvidia.com,
	petrm@nvidia.com,
	tglx@kernel.org,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net 1/2] bridge: mcast: Fix a possible use-after-free when removing a bridge port
Date: Sun, 17 May 2026 15:11:21 +0300
Message-ID: <20260517121122.188333-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260517121122.188333-1-idosch@nvidia.com>
References: <20260517121122.188333-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL0P290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::13) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|LV8PR12MB9112:EE_
X-MS-Office365-Filtering-Correlation-Id: 03b93156-ba2d-4666-dcfd-08deb40d815f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|18002099003|22082099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	Jz542jAFEIW243TyoIOFoczLuDuyWy493oPIwUtzSteR1ZISH9+hmdngJSwxQ96igIKAePS2aMKPZCs8aZ4yRzFaujFmK3zi7VN37XvxDoPlwBXTTR/xjIn/lwMlVLgWfDcgOJYtc0DrHani27mAznt3gNA9eUrEc2QNRw5dpYtPB0UZXcMCZZyhOOulEgKbfFkLg8dWfxK43/tnCj1yb0VHn6nBU+QMiCRRYIuZQg5fMCWEg0YUl8LI+1DZ6HsOE8rV52L8H/G8OqgAd1dIV6M9st37qYekPUHlaHYncyeafkptokRIp3giyU+RcGANyLqw78hAQSHLlQeXcIc7Ei2ywjuayw9KloaIeXb7LVjU2qJzWooY+Y16uYKpXVO09TLmMgzVqb0m2bzx0AF0cE21IQBWBEYgq8Qy4Hzw/8Ify4Y5TBdCbIAgQUkAk83nXAIYbtlboGoT0kpdNcswLkUmiW1H2ykFoUKXSNVVhqWoy7EfHAvnhx5Wb9W6tqKdDyZwzJc/RbYvdSbYF2V57o3/lWcAof55Py1Gw+Fk1tR1uGID7xzfkmz62bXvYQ1DHP/0QF9tDhfnr/Ck3wWgS+ACC3NT9ZKMYvfiJGwQ47LpimojmUpC/TkrBSw1QS9is4T+Vho5Z+yua0RDw/E8oxRvmRuOkkOsrNEKLPPnFOSsSJrYKYcy7bFCIL9l2mHy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+OBbWl6n5Alv4/5W89ND6ZQKD74LEgWK09CiUSlqgjJEVHzhOhGKDlB6bW2y?=
 =?us-ascii?Q?niHaazsJvgk0bSsNydnkDAE6tazvIz6uxCUtKNpQQmUDXx7BDxBMkZwUex03?=
 =?us-ascii?Q?knf4ji2YMShNenIEDoYNy5L0zDQkHARv5zsbdbfDkqyvRdBqQu8/5WfJmctn?=
 =?us-ascii?Q?T2q7QBDg+KewuDTnNvicu/fhloZhMPrNgAGFNE+K7qifc4GkIlht3FNDd7gU?=
 =?us-ascii?Q?HAj/zQjFkJ1qaXVKz/w/srFVfinldfo1JqqAD2tJW5Ol9hNbhCdxVi68rXBh?=
 =?us-ascii?Q?OeOMGUp2nG2DYlGJ7/hIK67MrY/fkt1UVzswbkIDvtws/dB3WCxudUASrmJn?=
 =?us-ascii?Q?85ciE1INELNQhq++Jk77f01WSMKLr4IFDqzHr3QeFbb6wKy3uA/jScqX9aGv?=
 =?us-ascii?Q?esJnObiZ1TVn6VsGiwaTe8vLagBrqvHk5zaJRiTnuU4pdeoP2GHJZNNlUSVN?=
 =?us-ascii?Q?n2n7UXDKQTRVin17+Vy7rupVMnrwsa8AMszsd8BcYjSrqCKPjMxi0HeHLFy7?=
 =?us-ascii?Q?gm6JkLBYPwkAD9D5TBhBsKgihnwADeAPsNjxTsxPr9THkXy/BrNg8r0yOpsi?=
 =?us-ascii?Q?KCbbtdRo5dw0cPeiQHRaGO/pVLL/3dOa//2G4P5AWC4XJyjsS7EPnRGAUSiT?=
 =?us-ascii?Q?EhDHSjhihwLU4szv4ql4dx+s0ehBbEWM1JK30wMqSt3NasB2RAXUAoV6n4zt?=
 =?us-ascii?Q?vrll2LpCIGCVT/cpOqFT2flYUuxj8qKmIKfXHZjTdprQ8YRd/ly3kwgDP6hE?=
 =?us-ascii?Q?FrJBtcqccobny6Iq1QmOcUV2del+uN25pbn/SY/Fyo2ULe5XFdviihIRVxKp?=
 =?us-ascii?Q?gFtN4WlHKqmCDQr+Yisv8upvFPZBnA4fowuVuEV/A5NjJtzsfHQKSPdPO1c6?=
 =?us-ascii?Q?vUylaFfWFw4ibF3zN3E9DfFgZzMQLyqofHmz9xBsGoV2pTo0XqjZ5yHn8Cn9?=
 =?us-ascii?Q?Jwnd4HzNzgsy6gLxDDzj6HsSGVKH7DKky3aWwalC/Mn6wtt1zxFm+UxcYPnZ?=
 =?us-ascii?Q?rP40rK8pBnIBjuQ7UGaF4YvxL+PHYLngFXpp5S23tIRafETWEs6Wo80A4QzO?=
 =?us-ascii?Q?pWNMk1waqyJ5DZojXf7Cjh3ZZciy6gXLmOTOeqReM9jGAiv1Mn5mn08ZpTSy?=
 =?us-ascii?Q?0lnAExHOKv2u7sYj0NR3EwM3QlT5+IZmdSRh1yRRb+IjRxS2UnW4a9tJ4ukZ?=
 =?us-ascii?Q?9SYmdPCjYINf1zl/aJyCH27H/Xq3fffkX/9a29JQFjZxaZdLNxJFIYlSKEn8?=
 =?us-ascii?Q?IIM+4xzh4JTV1D7XP3YW5YFG0GCQJgxw+xYDNLcNjVdjzJxbosiVvIFcxy6a?=
 =?us-ascii?Q?h2FwQER8K+h0XNx09rljFb2OlOpmKomL0xPZ3V/91SNT7usuPGnesVmj3+Ff?=
 =?us-ascii?Q?xPXH+DrNqIIR30+wNS++iWzzHx8PtOUk4V3saSTdLFarwy4HW+6h/cvI46Ox?=
 =?us-ascii?Q?tsytD4srByQmfty5ZhkoKDEgotpr2cEWXTeh0klz0M8F/MRggtDJN4I11GkW?=
 =?us-ascii?Q?N9E+HVaEVwGEdXQzlrhm4WHwLuRjGNXT8XufeXUfQ1HZaKbG9FUGMVXlURiX?=
 =?us-ascii?Q?l66vgQ30ausif7YiNpfFwkzK+05vSvAcPajWVTjQubF6UOtcW7gRcKvISVjD?=
 =?us-ascii?Q?pKcr92elO273RBzHU3ZsWUYmNtoZDalvJdt/ok6WNm/AZiyE5BWvKMaJEVgE?=
 =?us-ascii?Q?PGkWecdaRSFDACKUxK8r+eGKTc55ff/93k7JQ9ov0KxvxG1M?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b93156-ba2d-4666-dcfd-08deb40d815f
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2026 12:12:03.2899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VCwWepjRpuet5x0tcaUkKmW5ReQXVYoCMOlnw05vWHbwXIqyuOiOZHoKWECD1sEVd9AMGBjaMjsQch0LEf6xEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9112
X-Rspamd-Queue-Id: 76D32560E43
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288727-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

When per-VLAN multicast snooping is enabled, the bridge iterates over
all the bridge ports, disables the per-port multicast context on each
port and enables the per-{port, VLAN} multicast contexts instead. The
reverse happens when per-VLAN multicast snooping is disabled.

When global multicast snooping is enabled, the bridge iterates over all
the bridge ports and enables the per-port multicast context on each
port. The reverse happens when multicast snooping is disabled.

The above scheme can result in a situation where both types of contexts
(per-port and per-{port, VLAN}) are enabled on a single bridge port:

 # ip link add name br1 up type bridge mcast_snooping 1 mcast_querier 1 vlan_filtering 1
 # ip link add name dummy1 up master br1 type dummy
 # ip link set dev br1 type bridge mcast_vlan_snooping 1
 # ip link set dev br1 type bridge mcast_snooping 0
 # ip link set dev br1 type bridge mcast_snooping 1

This is not intended and it is a problem since the commit cited below.
Prior to this commit, when removing a bridge port,
br_multicast_disable_port() would disable the per-port multicast context
and the per-{port, VLAN} multicast contexts would get disabled when
flushing VLANs.

After this commit, br_multicast_disable_port() only disables the
per-port multicast context if per-VLAN multicast snooping is disabled.
If both types of contexts were enabled on the port when it was removed,
the per-port multicast context would remain enabled when freeing the
bridge port, leading to a use-after-free [1].

Fix by preventing the bridge from enabling / disabling the per-port
multicast contexts when toggling global multicast snooping if per-VLAN
multicast snooping is enabled.

[1]
ODEBUG: free active (active state 0) object: ffff88810f8bda78 object type: timer_list hint: br_ip6_multicast_port_query_expired (net/bridge/br_multicast.c:1927)
WARNING: lib/debugobjects.c:629 at debug_print_object+0x1b1/0x3e0, CPU#5: swapper/5/0
[...]
Call Trace:
<IRQ>
__debug_check_no_obj_freed (lib/debugobjects.c:1116)
kfree (mm/slub.c:2620 mm/slub.c:6250 mm/slub.c:6565)
kobject_cleanup (lib/kobject.c:689)
rcu_do_batch (kernel/rcu/tree.c:2617)
rcu_core (kernel/rcu/tree.c:2869)
handle_softirqs (kernel/softirq.c:622)
__irq_exit_rcu (kernel/softirq.c:656 kernel/softirq.c:496 kernel/softirq.c:735)
irq_exit_rcu (kernel/softirq.c:752)
sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1061 (discriminator 47) arch/x86/kernel/apic/apic.c:1061 (discriminator 47))
</IRQ>

Fixes: 4b30ae9adb04 ("net: bridge: mcast: re-implement br_multicast_{enable, disable}_port functions")
Reported-by: syzbot+ae231e0552fa77b26ea1@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/87qznowlfs.ffs@tglx/
Reported-by: Thomas Gleixner <tglx@kernel.org>
Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_multicast.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 881d866d687a..2eef4f3345cd 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -4640,10 +4640,24 @@ static void br_multicast_start_querier(struct net_bridge_mcast *brmctx,
 	rcu_read_unlock();
 }
 
-static void br_multicast_del_grps(struct net_bridge *br)
+static void br_multicast_enable_all_ports(struct net_bridge *br)
 {
 	struct net_bridge_port *port;
 
+	if (br_opt_get(br, BROPT_MCAST_VLAN_SNOOPING_ENABLED))
+		return;
+
+	list_for_each_entry(port, &br->port_list, list)
+		__br_multicast_enable_port_ctx(&port->multicast_ctx);
+}
+
+static void br_multicast_disable_all_ports(struct net_bridge *br)
+{
+	struct net_bridge_port *port;
+
+	if (br_opt_get(br, BROPT_MCAST_VLAN_SNOOPING_ENABLED))
+		return;
+
 	list_for_each_entry(port, &br->port_list, list)
 		__br_multicast_disable_port_ctx(&port->multicast_ctx);
 }
@@ -4651,7 +4665,6 @@ static void br_multicast_del_grps(struct net_bridge *br)
 int br_multicast_toggle(struct net_bridge *br, unsigned long val,
 			struct netlink_ext_ack *extack)
 {
-	struct net_bridge_port *port;
 	bool change_snoopers = false;
 	int err = 0;
 
@@ -4668,7 +4681,7 @@ int br_multicast_toggle(struct net_bridge *br, unsigned long val,
 	br_opt_toggle(br, BROPT_MULTICAST_ENABLED, !!val);
 	if (!br_opt_get(br, BROPT_MULTICAST_ENABLED)) {
 		change_snoopers = true;
-		br_multicast_del_grps(br);
+		br_multicast_disable_all_ports(br);
 		goto unlock;
 	}
 
@@ -4676,8 +4689,7 @@ int br_multicast_toggle(struct net_bridge *br, unsigned long val,
 		goto unlock;
 
 	br_multicast_open(br);
-	list_for_each_entry(port, &br->port_list, list)
-		__br_multicast_enable_port_ctx(&port->multicast_ctx);
+	br_multicast_enable_all_ports(br);
 
 	change_snoopers = true;
 
-- 
2.54.0


