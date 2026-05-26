Return-Path: <netdev+bounces-291552-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Mh3Mm5CFWrJTwcAu9opvQ
	(envelope-from <netdev+bounces-291552-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 08:49:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 655C45D1511
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 08:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AA8E5300B45E
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 06:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5593B4EA9;
	Tue, 26 May 2026 06:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cORzHGK0"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011009.outbound.protection.outlook.com [52.101.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9A21A285
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 06:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779778154; cv=fail; b=JcYqUDZ79GDS5DZcVm+D2gNm8vZpTPtUZMbXUvISOulOPrH4y+0BLBTuum3rHzaK78oupC/FfuzYHmAubZE/BQFOaMilzDMgi7z2XtOm2n7OwJgSfE562Xf75A5Xlsx72ak899/TZmssbSaMZ7blD6IheuyRQ9L2nqwoWTW/A4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779778154; c=relaxed/simple;
	bh=5o9fACHX3UytN3y3nqMMDDZ0BGArAM4zbtEsV+cEYN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hCVMOk+0MGt3Se5snC6vVOU2zHZFLJpdXFncOgqPCXtu4TCiBQi1gv7b3r9EHxAKuSqYz+cOP+rAHOxpIzR0S/Ol4rDXokHT5+9++fZGz2EaBH0UvZXHCkFIbIdP0Nmu7xixuBNienzysuvLV2DIBXNHBcg3bxzYKiJAjj3sfR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cORzHGK0; arc=fail smtp.client-ip=52.101.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KpD5dvzKF968T+ODcSXCaFUMjYu7xnwLQqCRUPUYdHHIh8Cl/6Okx+pASn/WElGrsgdWO3Kfl3O0wGxh1nlu9eG1p4JN80jv1ywy5iquy96wEvjl3l/XEnV9ZNln6dGbay4H+NzF4aMmWKN86X/WkyqLa6uu1oVgrT2vEojlL1ROsxDFPzhYhmjLfQqWnmc5lEaTPjlIXpjfCMPxE13s45sghE3uuNmmRsDePFNntHkKlZBwCL40kqisHGA2jazKvGLwZrxmeEcBVMQkXeM+EQfonxJ7o3deeepJbXDZ0Ij9DA+FmW4xcy0RDED8xI0vWlepg9Qm8NCN3doZubO+5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hz0we89G0pywJLYfOv8CMFcoAkFGl47rjwwWfnzl8iI=;
 b=WSHx8bVvPzyDXc9LQFCOdCD11Mno6sZbHDbazLwn4fniReKppw6F6JmsJegB2Li+gLwpujt5+sgX3JsudU7DoNQLEnBRIZym2VJXZWc7yUOTgsVDqziC6TnKfTzRHtTfhrsVRhAk7S+fFH5JaEdAL5FDtEIT7tIhKWWL6DjVXD2xJAxYlGAL1obbq98AhjczHlXNSIxnV/oynA2vTpnmvzMEYH+ZrjtYIOgeFhAXTiTGaSWJiZpFCuSrrcVY1zLRNrJK4o/EdIgV4CG0lj6xE354PJPOs6TXoIzx6XpjwPJpJmTCB6qfITJJPBXQYbriyU6LDP/2sdwLKbrjSCqwzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hz0we89G0pywJLYfOv8CMFcoAkFGl47rjwwWfnzl8iI=;
 b=cORzHGK0FTZtIpLS2SwHciD2VSvE+bnXGHFXCP5f5+QT/F2Z/DM5kK1Oc5n/vN7ABhYC3orTS1nqkel2uJFwwqGCNCYiOMDyl6hM2XtRlyT/zrlRdug8ycQh6Kle/lXXwiyyzWhcLnKZFcwKplE98ZNO1T5/yrOzYsLD5VtSGnHJZD8erH9XXicTwVMrp+3zLve4kqeG8+lH4PlPwCMdCjd1vDc5bY2s69388OrRKOVoY4p3oMEm4jDGX7/InDPWyQAcK27fBRUFQPvbwLnexPgeJH3HtlMWDxyF8S5OMwZC4EQeG/TY4DvZN3n4nrgZn3kqf7uS1bXNSmtFkF9cPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS7PR12MB6069.namprd12.prod.outlook.com (2603:10b6:8:9f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Tue, 26 May
 2026 06:49:08 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 06:49:08 +0000
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
Subject: [PATCH net 1/3] bridge: Fix sleep in atomic context in netlink path
Date: Tue, 26 May 2026 09:48:16 +0300
Message-ID: <20260526064818.272516-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526064818.272516-1-idosch@nvidia.com>
References: <20260526064818.272516-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0147.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::7) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS7PR12MB6069:EE_
X-MS-Office365-Filtering-Correlation-Id: 2300f2c5-f8ba-4772-e9df-08debaf2e2f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|6133799003|3023799007|11063799006|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	WGSV0DBtlGlJnpFqOfN47n/sif5+ZjZ0CQgN1MU4cNssqedcDJaU/x6cf5NbxrjGoofHZOfERzvVjBfGv5s5PyszJhAcycrA19d3rZ8NwwOVV1VtAjaXpld1aBsxdn+qLPmc7GR2r9yL/hUoJn0khBZKzvjuJymrQZDBHjMiGTF1RQX8RdDrXT8rSr5M8cp6DNwggjVgbnegSAUwxM4souyQbhlw2JriuDrDlZVq2v8ZHsenU3EbMlDBi/rmO5K93n1foRLoaBB6VhJDm0dSeWsZCnCAqaWTcfRrLvG7auO47wCldKlYMvmlhtjsV//TN5F79gUew576+aOpAHLFkzwxcPt+nsr0etziZy2S7gISFx++wH5zsaXRYsnGhBz7XPlDDU7atJNzuCgzS6UV6I6ViDps48tjyZa2sj8qyyc2St1E8KjYJ0qHEYLocOMwbsoDuGJjdU/6CNnDWHBLAuelkWNPoFcgLrgVTQ8LyP+MfY6z8EgjMpJ5HaPpK3LSJSCH2KpYRKNPVQclIIouw3zN0j3NbmzAq1RM4c2L4dgLnpV+7ZTpUOywMex4EK7jEaZCzjMK9xdt7P83wYkAnbkmGwCXSDaYaaReV7M/XlNWtwUlrSNjjXwhzb3ZKQiqPokaCzMGDb2ls693zZIvgLW4x0Fs0vb4yWvoo5EF2WTZ4R/aWTzca0U52niSS4Ld
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(6133799003)(3023799007)(11063799006)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WUjCCzakX7/248Mi2RK2Tua4nLVjM9B/qiygLHJKquzDGIEi/QwU7pl9HPH/?=
 =?us-ascii?Q?doF/iY42kouQZugkprBtFZSw42uaVTIVl6QaSNBPyOOr6rJ5oqy7220/JN6y?=
 =?us-ascii?Q?c0ZEUMLJifNBBuK0kKNNs1MdvODXTGReIznOJqD6fawHsJyYwlXETFUx7Vz0?=
 =?us-ascii?Q?JUSRDREUS+227VQk6t7e84GZq1yI7sbYk5ieaIgkj8yDG93wg/yeAyOwx/65?=
 =?us-ascii?Q?3KeEeED8pnvekUF8upJbTa3JRY5DgiLUWZjwXt/qo8CczFPHsi8aWTVRSTJS?=
 =?us-ascii?Q?9AP7A22+j0eT3TKN6Ohh3vYittRKnvUkbPjkyzj3IC6y3MghTXmFGwtKjUj2?=
 =?us-ascii?Q?Mc/TGxG21mujnYuyAAydcU/2c+/okuXq+JugzTxyzALz26KeHmoV7gkxks0I?=
 =?us-ascii?Q?dAwLOO8ptjGgxtrgakD0si8Ttom78KVDfsPe6uM343mE5cKdqez1QQhoYEr7?=
 =?us-ascii?Q?IGCsxgg+9uP4MvM9W+Db9m2BUUWX+zR+L3vICRzvYFFyMTXSBPY+rgvq8XWM?=
 =?us-ascii?Q?gVLAtxIIpzTQbh9M5XAx27+74/ccp1fQGA3iaehmaluPJuv2lcboAYJB87cS?=
 =?us-ascii?Q?dtdua6hJVkj8PnPMKFN9ZmJyyy6wFXqh/2TWihFSO8P5lNts/kWFUysvehLl?=
 =?us-ascii?Q?IDVyaASyqUSWcNUH+mk/LlgVz1OClX74Q6KRPBOH/9MNgdTmcCv61XwD5hBz?=
 =?us-ascii?Q?MSx/Q4QU7j0Z8xW2d8x+S9RMkJDoUpVuUDSNxlVxE05wooB/wRPaaPbdo7zJ?=
 =?us-ascii?Q?QIk/QmOZKCdDv22JZF3lvuyLyTLyMADsjzpK+SSFQdvxWVMA/mk5yIEAX2lZ?=
 =?us-ascii?Q?oujEl+4b9eBxNtEnTFB8enQMCNFuHP+drAMQfRIi/eERkw7IV5afqGqUBaNA?=
 =?us-ascii?Q?oV2tXZFCAhImdclY6EKsYFjstKtp7WED6+jzEQpJeFF0cOrOn2kQBtZtndV6?=
 =?us-ascii?Q?E6oQZp3J0oTLYEfrVx5bhn7OB5A9TJyzQXDx7bzqUjs45t9j8eYC78kjRb+3?=
 =?us-ascii?Q?U9ahOI+2JV9e5cIfR9ZQdpT07Zaj6Jv69EG1NMtuyod3sz3KFbu0++KNcgik?=
 =?us-ascii?Q?40MI/c02o7gv3LHHts9ZPto54xdDzG8GIpO3szIeuxsKvC87LdQgyJcLy0Iz?=
 =?us-ascii?Q?p/GSDh3iJ5Tc7vgiaKamIpPxkyewfAYoYdGa6HIfgjunbQCeSh1rDIxYyGvt?=
 =?us-ascii?Q?zaxop2nU7GYmEN7q43F68yA4nQMFMDlkwAPlGgXqs/aW4e99qjJYaOjSlnPs?=
 =?us-ascii?Q?Q59nnSIjIlmjPCPRDlMIvcBEjnICcg2VOfFwBGAUT6Vcc6MpIyA+uUsm4pIA?=
 =?us-ascii?Q?r14giYR23HqDExh8KhpTisV18EjeETyghJzVFZ0FxyJArpcYklgA5vIsfbFE?=
 =?us-ascii?Q?BGsJ1b9Ox+l3hGQsjrydKMT+5q5uvRWhM+h4GxxYu+BUbM5zi2GN6ZzKz/9U?=
 =?us-ascii?Q?ol/oedamnHcW2f2fJWpNL5swxzfVu48uGiV7Etspx+qzhVULXn07jTaTMwBX?=
 =?us-ascii?Q?Yfj/ZnC8JCGPDPiNQjkveb5n4yZGsTt2QG5Mx2BxP6gIq9ktO8FRPQn1UHjX?=
 =?us-ascii?Q?HOQ7hw8V542UV3/Ygi2QmkABCAW+xQv1qQbfqnYiuWiY8s+8CgXlyCxhqkLq?=
 =?us-ascii?Q?91gSIkeEvukOe5sITU0E/P6goDn9bzot820IR32ie6pLiyS3aVlK9WE4+4pK?=
 =?us-ascii?Q?kzTeQ5T1rfWo2QXO46TvbcyeTFda1huHQlsWrrxmcLu32vtq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2300f2c5-f8ba-4772-e9df-08debaf2e2f5
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 06:49:08.7561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yFF3AjTqWYrm5Nir1zAfEs8LzobNh3XiQTs/3HI0b4Y0qlCQIO5Wy9NgMRGxiEF0hZBC5Z7gdksnXAYgtY4MSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6069
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-291552-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 655C45D1511
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Since the introduction of the netlink configuration path for bridge
ports in commit 25c71c75ac87 ("bridge: bridge port parameters over
netlink"), br_setport() was always called with the bridge lock held
around it. Back then this decision made sense: The bridge lock protects
the STP state of the bridge and its ports and at that time the function
only processed three STP related netlink attributes (cost, priority and
state).

Nowadays, br_setport() processes a lot more attributes and most of them
do not need the bridge lock:

* Bridge flags: Only require RTNL. Read locklessly by the data path.
  Annotations can be added in net-next.

* FDB port flushing: Only requires the FDB lock.

* Multicast attributes: Only require the multicast lock.

* Group forward mask: Only requires RTNL. Read locklessly by the data
  path. Annotations can be added in net-next.

* Backup port and NHID: Only require RTNL. Read locklessly by the data
  path.

This is a problem as the bridge calls dev_set_promiscuity() when certain
bridge port flags change and this function can sleep since the commit
cited below, resulting in a splat such as [1].

Fix this by reducing the scope of the bridge lock and only take it when
processing the three STP related attributes that require it. This is
consistent with the multicast attributes where each attribute acquires
the multicast lock instead of having one critical section for all
relevant attributes.

[1]
BUG: sleeping function called from invalid context at net/core/dev_addr_lists.c:1262
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 356, name: bridge
preempt_count: 201, expected: 0
RCU nest depth: 0, expected: 0
2 locks held by bridge/356:
#0: ffffffff919473a0 (rtnl_mutex){+.+.}-{4:4}, at: rtnetlink_rcv_msg (net/core/rtnetlink.c:80 net/core/rtnetlink.c:7002)
#1: ffff888115072d58 (&br->lock){+...}-{3:3}, at: br_setlink (./include/linux/spinlock.h:348 net/bridge/br_netlink.c:1117)
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
br_setport (net/bridge/br_netlink.c:1000)
br_setlink (net/bridge/br_netlink.c:1118)
rtnl_bridge_setlink (net/core/rtnetlink.c:5572)
rtnetlink_rcv_msg (net/core/rtnetlink.c:7005)
netlink_rcv_skb (net/netlink/af_netlink.c:2550)
netlink_unicast (net/netlink/af_netlink.c:1318 net/netlink/af_netlink.c:1344)
netlink_sendmsg (net/netlink/af_netlink.c:1894)
__sock_sendmsg (net/socket.c:787 (discriminator 4) net/socket.c:802 (discriminator 4))
____sys_sendmsg (net/socket.c:2698)
___sys_sendmsg (net/socket.c:2752)
__sys_sendmsg (net/socket.c:2784)
do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)

Fixes: 78cd408356fe ("net: add missing instance lock to dev_set_promiscuity")
Reviewed-by: Nikolay Aleksandrov <nikolay@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_netlink.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index c04a4d0889ae..b9591dd755f9 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -1000,19 +1000,25 @@ static int br_setport(struct net_bridge_port *p, struct nlattr *tb[],
 	br_port_flags_change(p, changed_mask);
 
 	if (tb[IFLA_BRPORT_COST]) {
+		spin_lock_bh(&p->br->lock);
 		err = br_stp_set_path_cost(p, nla_get_u32(tb[IFLA_BRPORT_COST]));
+		spin_unlock_bh(&p->br->lock);
 		if (err)
 			return err;
 	}
 
 	if (tb[IFLA_BRPORT_PRIORITY]) {
+		spin_lock_bh(&p->br->lock);
 		err = br_stp_set_port_priority(p, nla_get_u16(tb[IFLA_BRPORT_PRIORITY]));
+		spin_unlock_bh(&p->br->lock);
 		if (err)
 			return err;
 	}
 
 	if (tb[IFLA_BRPORT_STATE]) {
+		spin_lock_bh(&p->br->lock);
 		err = br_set_port_state(p, nla_get_u8(tb[IFLA_BRPORT_STATE]));
+		spin_unlock_bh(&p->br->lock);
 		if (err)
 			return err;
 	}
@@ -1114,9 +1120,7 @@ int br_setlink(struct net_device *dev, struct nlmsghdr *nlh, u16 flags,
 			if (err)
 				return err;
 
-			spin_lock_bh(&p->br->lock);
 			err = br_setport(p, tb, extack);
-			spin_unlock_bh(&p->br->lock);
 		} else {
 			/* Binary compatibility with old RSTP */
 			if (nla_len(protinfo) < sizeof(u8))
@@ -1203,17 +1207,10 @@ static int br_port_slave_changelink(struct net_device *brdev,
 				    struct nlattr *data[],
 				    struct netlink_ext_ack *extack)
 {
-	struct net_bridge *br = netdev_priv(brdev);
-	int ret;
-
 	if (!data)
 		return 0;
 
-	spin_lock_bh(&br->lock);
-	ret = br_setport(br_port_get_rtnl(dev), data, extack);
-	spin_unlock_bh(&br->lock);
-
-	return ret;
+	return br_setport(br_port_get_rtnl(dev), data, extack);
 }
 
 static int br_port_fill_slave_info(struct sk_buff *skb,
-- 
2.54.0


