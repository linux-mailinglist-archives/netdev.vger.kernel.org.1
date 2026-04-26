Return-Path: <netdev+bounces-281158-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AB3OCq4U7mkxqgAAu9opvQ
	(envelope-from <netdev+bounces-281158-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 15:35:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F56B469FF4
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 15:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2C4C73007895
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 13:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA77361656;
	Sun, 26 Apr 2026 13:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T3lFWJVB"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010012.outbound.protection.outlook.com [52.101.201.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F0D246BBA
	for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 13:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777210538; cv=fail; b=R9BneekA0Mz1tFyR5cA7z4Owd0zX8RkBL/LsYayQELiukuUPUuM/zHUt2a9jXyEx5k1LqqIq420kdAn/cwiUZXjxiWvsYz9C8F8vni87ic4MzU5ydt1WK7wZWL8QW3pLvgobK0yqRyBP47P9QptBGHTZUFUsFd69fwOHt5JdWxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777210538; c=relaxed/simple;
	bh=CQtzMdq/qb/+s9JuVQ5Biofe3vgJA4+YKFmHpiereQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XFdJ1QFcxA+kXFkuxs4ZVd3Tf9mtHx/79VMxYmE9qZi0KgxN0Le4PJlxQxQcYj8OQrvGmSnY8VFIjmbrgIrohkCf1vrhsb/oh23a9F6KkRtxzHBLDOiYsZ6khkGP/d409WmUF10HLNnk76vPs5x9Ne9zpv6MQsTBiIi4+NU4Cgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T3lFWJVB; arc=fail smtp.client-ip=52.101.201.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oj39N2ZFNaXqNFSuUul71RciCyrBtWt5cqY+jGs1zMGdlM1X6vImU16Cn6jci8IRdsIgfrm9fS8v85wL+UoWPszfyDE5QRx34mqm/DPgLzHJDEuaNrMsw1xyAdokVWoSmI1UCWOV20wZLwlhHjwfhWWA+9h/1/PvoBc+ypijfhC7erHpfZr9CHa5JCX0xIiO4/gADLxabl3ge0EtDKmST1qOjS8LZ/8iGOxv6qcaazerfgycR4I5yuhXYYIoIkzYddDiz/rn0W4QrTcMvvp3VJNr4YY7LyaViynIX5Q0m2JXhFX9acN5mb1cxg2FntRCjWVhSpV8DN/eDXNEcfWbgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wVZTy1JEEO7ijzyZnvkJjvDbg4mvhw3FmM3+eTtE/5w=;
 b=dgTYVNVzsUEbQMOeyPpbvhQ3VMc2wQRLO1Z8uO2vYVyse9fJ18o4WEMErHdbe4eDGTvNkYkh8O7BXpNHGzQlbk2OAmotbYTIK5fjif0qTRqHv0/XJpuKrSUZRNEZN48FChWTLJyrERUndI4g5IdC/+SAWyXjGfZuJ6+HG4KUS/rx/ui+cSSVISaGR/oN7xqh7O0Zj0vzFkF7+Lf7+xpk49KTlz3lFFrNxIEm/oCrFVmgdFqdn948WmQaZF38sKGPrSUAgJLEONI9ifvfnbZc2RtlrDHeMHO3yELx2AtTC7OKdKSRvP2uf7VnwSF7K0RkQ54la2dps91DI9euQYfxnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVZTy1JEEO7ijzyZnvkJjvDbg4mvhw3FmM3+eTtE/5w=;
 b=T3lFWJVBekAwxKcwKZPooLywqfaSBRZSqzSAgbPpJikijP/UOiZ+rjsvCUmLy1ncr2mCQLEi69g97QK/VzkTbGVh5/2tl41NEu6QRDlq0eGmPK4bWCAFjW+6QoiL9Un7f9ADh6qzj43eNnRj0+brWLaO37BP7DV2VORLU8CVlhiLWjd1AZkHYsiV9qDUxP/ffsBkEEaTt6tfI3OcSwUjB9BZQ8YrX0xBwAhRNObcbmt4j28DtetZkcIZP1BG5jz7amXKWic+RkJrGMaMP2ihagys915SW6gyYeZnoF9BnvLKzGK/X5mb7dF6QCkrdzOB4ndn+PM78ekyzJ2RTlqJDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CH2PR12MB4135.namprd12.prod.outlook.com (2603:10b6:610:7c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.13; Sun, 26 Apr
 2026 13:35:32 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9870.013; Sun, 26 Apr 2026
 13:35:32 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org,
	bridge@lists.linux.dev
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	razor@blackwall.org,
	horms@kernel.org,
	herbert@gondor.apana.org.au,
	linus.luessing@c0d3.blue,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net] bridge: mcast: Fix a false positive lockdep splat
Date: Sun, 26 Apr 2026 16:34:35 +0300
Message-ID: <20260426133435.207006-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL0P290CA0015.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::7)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CH2PR12MB4135:EE_
X-MS-Office365-Filtering-Correlation-Id: 509c90d5-a55c-4060-dd23-08dea398b076
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	04/goPYDRoI6Ljvmd7GXTq//YrTeB/dVE5koxa/4brw5hOZspeaTn2P9YYGkyYg9f+cWceRGNlXtBEC1oz1dX7YUUWywnl6wJFiqDiaToiqKuL+qgV/okZOFTzp/AMbVgFXqTI3OTSD1CD/ipNN1fdVZkE8I2nWL3pYrtHTUZZhvYlZZuyeRIfAP19gYo/q7ftxJmvZLXFat3z/zXzCDbAtqe1T+YiX7u8VzJWSJioqZz95vh8oYW1hiW+tjzTx2RS00NMbNfkBFFRBpuum8hydwLVhMOd8O2DHmLz8S54I6w6eqqOrR5+rQ+Jo8PSWXmzGSOGjhNX9Rm66WxXDg/lb+90SwubaE5BhrlNPFZBaIJMll/eFGEwINkdoCxfzNgaiQBf1UveooiLJS60lQ9gEIQkkDfACMXrL53Bb7mJYbZZ3vRwNMHSytFCxN/P7HUvuYFDlBbmeGppOS3GUnjxfWSIxi+8goYgM76KDq05Ipzyeco5krBpljVIJf0luliYSmefSoDnC7SZGSvoPKdLdjo76eNuZflp4mxe/HEG3+0b/a83AmAk65iQjt5ySfhUsgoD3iXfdZB4rLRi46pzfCkEjJEAoOAdLUObHbla8AaiZs2lodcQn7Pb1nXAf4HJ2HO2Vn3+qRRcP9SOTU2PRK6C2SXnIum/1PdPAlZvtIMsPFClSLfrcE+rolyx2tQS6ehHnWL8UTgrJrGJNIzD+Gg09YEZcJSHPkT1cA5pkkPcQ5OY3ku8OzNxqnSOqD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pjLSayw5HhlcahqpCw7IXVy+PKm1dWPGMd0Ucb6OY6G387+1zV4mgH7JbbQO?=
 =?us-ascii?Q?KBljtwaGFmWIB3zLeXG+W0JvRHOVJl1oJSJ4jP8h/FscwmOeWADMYmPdL9eE?=
 =?us-ascii?Q?G9UgmV+cVw3+CMOzFnjIMlsQJ3oeO5t0YF2yFjjrw6jylR4kB7IOkgUrR5nf?=
 =?us-ascii?Q?+sT1hip/BLenEGMdStZHg2E30FGX/znsr1h7AWkD8IzeLoUfKkONy9dLC8w6?=
 =?us-ascii?Q?f24+mgmIk4XroFzK0UJ6IhIP7OXKhcrTqaIYzIZK5tDRYee2V303hQd61g01?=
 =?us-ascii?Q?psO0Dav7zkMDkBdlFJgMLIhdgZl/6Ll7zJ1o/six75roq+YZrXVsohM04Zuc?=
 =?us-ascii?Q?B8vB5Gs1AftXO7BuLHCA3YP5eKhOwj2u1eu2RHHvF7O/5jXlnzexweOWTqjN?=
 =?us-ascii?Q?E6+FvAGVZEdE8MMvdnJNPzxxKZsZVLCWYjSwOF6UnW3BFB7eXKpRJnEMgsGN?=
 =?us-ascii?Q?N5XHPVtiMFYtZsHd5CCS3a8vSkNIiG327Y12AkFyyzdPUt+E4GUJnEzcLJu6?=
 =?us-ascii?Q?RLQ+SODrJ3eCfUBuUnr/rEE0kat6huVPSWlrtbygAQ3kh2a4Zr/kcwdS4H2r?=
 =?us-ascii?Q?Ut3ExvhuqHUf551TGgiW3kZZ1PWhqbvKjZR2hJwLsvLYlfpRyAFFHrClgb44?=
 =?us-ascii?Q?z5PnQdlQsSw3w0Vbm9ysT81GqCIzHKYb34iAefGoUTPELd5BhwB+yDjgdMAJ?=
 =?us-ascii?Q?OYKdZnpa9/+bsBXaXZaA7poZP6kQ67ukdyirV9njpQ1ujnz2vsvS0ZNDe7Xw?=
 =?us-ascii?Q?0iXwM9yBj3ciIWix3uDUw9D7SIJcl4sBwm/Obqk9ruzoEtXr7e+au1aRb5tN?=
 =?us-ascii?Q?CnQW4hz1I8FAgcjVCN2keUPXwo/HtPE9vhoXfSOeT8BHBFJHvlyBqm3/3vdo?=
 =?us-ascii?Q?wCjciPcnCQsgNadV6G+AyGEknHf6hFJv+tB0eFyicW4VaRW5ZVBTKW+OjB+2?=
 =?us-ascii?Q?1qkKsb7y6KajgVB/4Wxv/u7QYI+6/URcD58RBNyBmG2OBxLFGbAKIt5k5Io0?=
 =?us-ascii?Q?zQdfyFS8K2hXf8dbpkXfb+2g6zg+qrh61oF3P8E+bCNG1o8vrS04nMDl668m?=
 =?us-ascii?Q?Pa6+iilscHf1Dy7ORCR4aD1ZkMCJxG9K94SZsOI+ZU+wt+j3P5rftfg9Ztyn?=
 =?us-ascii?Q?bDM9THqi2yJGyftCV6Thdsk7w67PaI13OBhXhYl687nKw8RkWKRASOGVo4EB?=
 =?us-ascii?Q?75xtTU66sLGryskmSfTm1LFS0CYR0wZXXAr1icGgRIaGRn9GWxvAwNFmbefn?=
 =?us-ascii?Q?mgK/tAHIodttdL9LNDTw/gMYunXWqjgEHYS9W9MXJ9GhU5nN6uGTZXq2ijgj?=
 =?us-ascii?Q?0mlJI9HRwPcf2YBCFEybU28vUr/U7Ij1WHHge6lGvISsuQR2s/BJJxBkDPMj?=
 =?us-ascii?Q?il0eXyPJm1wtmCEYF0O5gvpRQa3w66a5wLfVqzfQo3oa9zyJ/nI6yItgFJE4?=
 =?us-ascii?Q?zo8prTnl5S0gHX/hbjM+7TodolF5ofZc0CK7IfEv71tXALuMC7eQl+V2quIF?=
 =?us-ascii?Q?h5IDgR+NEXAcYOztNdFxzhCvFzknKJ9FpkNX5UJ+VN6IDBGs4j9WjK4rbpII?=
 =?us-ascii?Q?+JeLNTCZ4uFPMHOq5ROBpd8aVOHzO5dQi/vfytUqnVbxzCi19zKjWWP4ZdyW?=
 =?us-ascii?Q?SbR+9pcYGi02xvVqSqx+z2V3gzTZa0RRSVxA7cluH7AuM1JsW2Vp4ntMOko7?=
 =?us-ascii?Q?SmDs8uq9fRB9qupGVf9aO4BdrqSdf03oDtTi84tmL7VxdLkl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 509c90d5-a55c-4060-dd23-08dea398b076
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2026 13:35:32.5297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TdJ+H10sRUlvCgdR565fd/lbOKcAezIq1j0b7+1yQ1awUKnObzqlQtQP4d7EfqvHPfiMDH+LbnRNpzztGRe3jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4135
X-Rspamd-Queue-Id: 8F56B469FF4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-281158-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,appspotmail.com:email]

Connecting two bridges on the same system [1] can result in a lockdep
splat [2].

The report is a false positive. Multicast queries are built and
transmitted under the bridge multicast lock. When the outgoing port of
one bridge is configured on top of another bridge, the transmit path
re-enters bridge code and acquires the other bridge's multicast lock in
order to snoop the query. Both lock instances share a single lockdep
class, so lockdep flags the nested acquisition as an AA deadlock.

Giving each bridge its own lock class will not solve the problem: the
reverse topology would produce an ABBA splat with the same pair of
classes. It also consumes a lockdep key per bridge.

Instead, fix the problem by deferring the transmission of the queries to
a workqueue. Build the skb and update querier state under the lock as
before, then enqueue the skb on a per multicast context queue and
schedule the work.

Flush the work when the multicast context is de-initialized. At this
stage the work cannot be requeued. There is no need to take a reference
on skb->dev since the work cannot outlive the bridge or the bridge port.

Use the high priority workqueue to reduce the delay between the enqueue
time and the transmission time. With default settings (i.e., querier
interval - 255 seconds, query interval - 125 seconds) the extra delay
should not be a problem.

[1]
ip link add name br1 up type bridge mcast_snooping 1 mcast_querier 1
ip link add name br0 up type bridge mcast_snooping 1 mcast_querier 1
ip link add link br0 name br0.10 up master br1 type vlan id 10

[2]
============================================
WARNING: possible recursive locking detected
7.0.0-virtme-gb50c64a58a90 #1 Not tainted
--------------------------------------------
ip/339 is trying to acquire lock:
ffff888104f0b480 (&br->multicast_lock){+.-.}-{3:3}, at: br_ip6_multicast_query (net/bridge/br_multicast.c:3584)

but task is already holding lock:
ffff888104f03480 (&br->multicast_lock){+.-.}-{3:3}, at: br_multicast_port_query_expired (net/bridge/br_multicast.c:1904)

[...]

Call Trace:
[...]
br_ip6_multicast_query (net/bridge/br_multicast.c:3584)
br_multicast_ipv6_rcv (net/bridge/br_multicast.c:3988)
br_dev_xmit (net/bridge/br_device.c:98 (discriminator 1))
dev_hard_start_xmit (./include/linux/netdevice.h:5343 ./include/linux/netdevice.h:5352 net/core/dev.c:3888 net/core/dev.c:3904)
__dev_queue_xmit (./include/linux/netdevice.h:3619 net/core/dev.c:4871)
vlan_dev_hard_start_xmit (net/8021q/vlan_dev.c:131 (discriminator 1))
dev_hard_start_xmit (./include/linux/netdevice.h:5343 ./include/linux/netdevice.h:5352 net/core/dev.c:3888 net/core/dev.c:3904)
__dev_queue_xmit (./include/linux/netdevice.h:3619 net/core/dev.c:4871)
br_dev_queue_push_xmit (net/bridge/br_forward.c:60)
__br_multicast_send_query (net/bridge/br_multicast.c:1811 (discriminator 1))
br_multicast_send_query (net/bridge/br_multicast.c:1889)
br_multicast_port_query_expired (./include/linux/spinlock.h:390 net/bridge/br_multicast.c:1914)
call_timer_fn (./arch/x86/include/asm/jump_label.h:37 ./include/trace/events/timer.h:127 kernel/time/timer.c:1749)
[...]

Fixes: eb1d16414339 ("bridge: Add core IGMP snooping support")
Reported-by: syzbot+d7b7f1412c02134efa6d@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/000000000000c4c9d405f2643e01@google.com/
Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_multicast.c | 39 +++++++++++++++++++++++++++++++++++----
 net/bridge/br_private.h   |  4 ++++
 2 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 881d866d687a..252c46977ed5 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1776,6 +1776,28 @@ static void br_multicast_select_own_querier(struct net_bridge_mcast *brmctx,
 #endif
 }
 
+static void br_multicast_port_query_queue_work(struct work_struct *work)
+{
+	struct net_bridge_mcast_port *pmctx;
+	struct sk_buff *skb;
+
+	pmctx = container_of(work, struct net_bridge_mcast_port,
+			     query_queue_work);
+	while ((skb = skb_dequeue(&pmctx->query_queue)))
+		NF_HOOK(NFPROTO_BRIDGE, NF_BR_LOCAL_OUT, dev_net(skb->dev),
+			NULL, skb, NULL, skb->dev, br_dev_queue_push_xmit);
+}
+
+static void br_multicast_query_queue_work(struct work_struct *work)
+{
+	struct net_bridge_mcast *brmctx;
+	struct sk_buff *skb;
+
+	brmctx = container_of(work, struct net_bridge_mcast, query_queue_work);
+	while ((skb = skb_dequeue(&brmctx->query_queue)))
+		netif_rx(skb);
+}
+
 static void __br_multicast_send_query(struct net_bridge_mcast *brmctx,
 				      struct net_bridge_mcast_port *pmctx,
 				      struct net_bridge_port_group *pg,
@@ -1804,9 +1826,8 @@ static void __br_multicast_send_query(struct net_bridge_mcast *brmctx,
 		skb->dev = pmctx->port->dev;
 		br_multicast_count(brmctx->br, pmctx->port, skb, igmp_type,
 				   BR_MCAST_DIR_TX);
-		NF_HOOK(NFPROTO_BRIDGE, NF_BR_LOCAL_OUT,
-			dev_net(pmctx->port->dev), NULL, skb, NULL, skb->dev,
-			br_dev_queue_push_xmit);
+		skb_queue_tail(&pmctx->query_queue, skb);
+		queue_work(system_highpri_wq, &pmctx->query_queue_work);
 
 		if (over_lmqt && with_srcs && sflag) {
 			over_lmqt = false;
@@ -1816,7 +1837,8 @@ static void __br_multicast_send_query(struct net_bridge_mcast *brmctx,
 		br_multicast_select_own_querier(brmctx, group, skb);
 		br_multicast_count(brmctx->br, NULL, skb, igmp_type,
 				   BR_MCAST_DIR_RX);
-		netif_rx(skb);
+		skb_queue_tail(&brmctx->query_queue, skb);
+		queue_work(system_highpri_wq, &brmctx->query_queue_work);
 	}
 }
 
@@ -1999,6 +2021,10 @@ void br_multicast_port_ctx_init(struct net_bridge_port *port,
 	pmctx->port = port;
 	pmctx->vlan = vlan;
 	pmctx->multicast_router = MDB_RTR_TYPE_TEMP_QUERY;
+
+	skb_queue_head_init(&pmctx->query_queue);
+	INIT_WORK(&pmctx->query_queue_work, br_multicast_port_query_queue_work);
+
 	timer_setup(&pmctx->ip4_mc_router_timer,
 		    br_ip4_multicast_router_expired, 0);
 	timer_setup(&pmctx->ip4_own_query.timer,
@@ -2038,6 +2064,7 @@ void br_multicast_port_ctx_deinit(struct net_bridge_mcast_port *pmctx)
 	del |= br_ip4_multicast_rport_del(pmctx);
 	br_multicast_rport_del_notify(pmctx, del);
 	spin_unlock_bh(&br->multicast_lock);
+	flush_work(&pmctx->query_queue_work);
 }
 
 int br_multicast_add_port(struct net_bridge_port *port)
@@ -4111,6 +4138,9 @@ void br_multicast_ctx_init(struct net_bridge *br,
 	seqcount_spinlock_init(&brmctx->ip6_querier.seq, &br->multicast_lock);
 #endif
 
+	skb_queue_head_init(&brmctx->query_queue);
+	INIT_WORK(&brmctx->query_queue_work, br_multicast_query_queue_work);
+
 	timer_setup(&brmctx->ip4_mc_router_timer,
 		    br_ip4_multicast_local_router_expired, 0);
 	timer_setup(&brmctx->ip4_other_query.timer,
@@ -4134,6 +4164,7 @@ void br_multicast_ctx_init(struct net_bridge *br,
 void br_multicast_ctx_deinit(struct net_bridge_mcast *brmctx)
 {
 	__br_multicast_stop(brmctx);
+	flush_work(&brmctx->query_queue_work);
 }
 
 void br_multicast_init(struct net_bridge *br)
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 361a9b84451e..2695b9128705 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -131,6 +131,8 @@ struct net_bridge_mcast_port {
 	unsigned char			multicast_router;
 	u32				mdb_n_entries;
 	u32				mdb_max_entries;
+	struct sk_buff_head             query_queue;
+	struct work_struct              query_queue_work;
 #endif /* CONFIG_BRIDGE_IGMP_SNOOPING */
 };
 
@@ -167,6 +169,8 @@ struct net_bridge_mcast {
 	struct bridge_mcast_own_query	ip6_own_query;
 	struct bridge_mcast_querier	ip6_querier;
 #endif /* IS_ENABLED(CONFIG_IPV6) */
+	struct sk_buff_head             query_queue;
+	struct work_struct              query_queue_work;
 #endif /* CONFIG_BRIDGE_IGMP_SNOOPING */
 };
 
-- 
2.53.0


