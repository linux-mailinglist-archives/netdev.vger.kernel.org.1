Return-Path: <netdev+bounces-183635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3B1A915AB
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 09:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0903A19E134F
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 07:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4171A3147;
	Thu, 17 Apr 2025 07:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="B5DP+G0T"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2051.outbound.protection.outlook.com [40.107.21.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0811DDC2B
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 07:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744876119; cv=fail; b=JEY4A8vm8+OG2PHZGTt5ssneVZQNYdVNTFuIVD4s92fEL2vAdkGG1Et0/Gn6oOEz/H8oKVaUz+O04C0+7NycqSePdc9d3i0lbjSEjEY52FuusErhugRc+tZoNfF8DoIA2jgkkWn4Bh5NW90pBmpJom1UAImS5Oos9qXcswRfcTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744876119; c=relaxed/simple;
	bh=TMTarhAverKBNkKuBkgmoO5qvi0S67BPLwDxQym3qb8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GUGcJ3NSo1p+ocDJYPcFsD3IGBqaHUuoodxL3mRrabiUxF+UCGfY9u2XFO2gfN++8N03Rf4N1e2csATCVz3PAQwTiOT1UlVboO4CdT6ErcAlzqfg/31G9o0Ftbxs1e/9ooNIZhhtCHbKFHEGgzUMWD4qKGdomOf7ccXN92HNDuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=B5DP+G0T; arc=fail smtp.client-ip=40.107.21.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RUcJcLrbFKLoJRSRvfSBwtLknMlreEEMmsLyZMar/l6MCO48iQps4gRfM9+RZWIWWJrpacfwFkF4rzU7Od47V4MeqGHVF1mLIfy82YmjtQLyV1v6BnJyvhKxNg/6+Pihcf0ytDKBWnLwJVokMACPznpaiWgb+VSo6tGOiMq2RrMwUcthoK70IvVMwB6ha21q8UotdInfZNg2E3IU7loX4P9E6rspUG917rEjc3RRHl3Ulh+hL8nD+CnnDWiWOoWMtxtm1qK8+thmvBrHTaeeRnmA7zYQM43SW9hLELnqPO5VoExVWJCObbsECdT9jobUgYKDp/bD2TV+O5Xv0zt5Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IO5cl1+RSYJEvOKQI7TVVyhHtYJRHzEAuOI5FpUC3xk=;
 b=Z2DSm+D3keARMvheYQqU9OxpR5a1iXovLC6Haz7cMEcYGR2B4yzgzNFqrVWZ9ztRdNdiczzvX0qlAB8wv5/yX/kajzPl/5tflUBB9bG0/end52P16OG4ukEfswOlu5v2PTpb37/yBsczy/3Z1eI/j+DtoUOfXvy2GmrZk/JOCLaoimyWhpkE4t96ki3HgB1cxFF5XvgD6/4KIi2kaScKdGMKXUYhrGCXMuLiPxosxdXuTCep+fcH3DJawzhff+MtD/MVOQECCm0n4hNF873r85b81I6ACGhpNIpm3S4749IgUgYokaoA7ADHdZD7Vk0SdrnoCIx1eSoK099H0GseEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IO5cl1+RSYJEvOKQI7TVVyhHtYJRHzEAuOI5FpUC3xk=;
 b=B5DP+G0TUiGE3DFRQcq9PHX7eDwNAxMNcPHGpR6iiwXisaBv/mr/ZDkxdsU3GbUeA75/ldLM6+55OJjHW0fAVtKsJsLImyrFSB4lY+9LXOjRPDh38hF4bfKlRWXriXUzSlzuRNMmMK3RI6HJ9ipVmyv8APYgMBPApPeiA9p6xlFiNTkhD4lzRei0ku3VtOTg7fXvaKuSe3x+Z/gM6QXC2NoVVGnFljavh5WvkUPBG8OQ2i3T56id/jmdiudvOxKpb2heTZiZnYWbgPNNykKyxoQWTxbBzkuS4Q5XnJcHXX/6y7vMxpc+rDdVm26PvNzBUcHFq09E7LSUQPw9gMmAmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from GVXP189MB2079.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:7::14) by
 AS4P189MB2064.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:514::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.34; Thu, 17 Apr 2025 07:48:32 +0000
Received: from GVXP189MB2079.EURP189.PROD.OUTLOOK.COM
 ([fe80::e733:a9e4:d1f5:1db5]) by GVXP189MB2079.EURP189.PROD.OUTLOOK.COM
 ([fe80::e733:a9e4:d1f5:1db5%4]) with mapi id 15.20.8632.036; Thu, 17 Apr 2025
 07:48:32 +0000
From: Tung Nguyen <tung.quang.nguyen@est.tech>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jmaloy@redhat.com,
	Tung Nguyen <tung.quang.nguyen@est.tech>,
	syzbot+ed60da8d686dc709164c@syzkaller.appspotmail.com
Subject: [PATCH net] tipc: fix NULL pointer dereference in tipc_mon_reinit_self()
Date: Thu, 17 Apr 2025 14:47:15 +0700
Message-ID: <20250417074826.578115-1-tung.quang.nguyen@est.tech>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::30)
 To GVXP189MB2079.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:7::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXP189MB2079:EE_|AS4P189MB2064:EE_
X-MS-Office365-Filtering-Correlation-Id: 72634158-f22e-464a-0949-08dd7d84400b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T6oyquOgOKkgbXy/UDSsLtukjEa7e7n+e5sXgXfaN0CDpHZxQbSDyXaoRMvS?=
 =?us-ascii?Q?x8ayQQnZ+XorNcEjJxxi1j+fqZYj8YstLwpX9PwGEqHTJsrzOs9O0cLIm0BS?=
 =?us-ascii?Q?67/G1Gd5Fw9oYEJjWLDoZgFQ+Kqu/PSOWof87JRfDfRUNAUa5K9jiFyhDmZL?=
 =?us-ascii?Q?Ht42WcZrXEl1qA2Wm/ngxIw2jqR/MCBKg59P56HdTSlz/zyRVxUi0/RbZEbX?=
 =?us-ascii?Q?gJubIF6rZlWWSbQxUkgj+uLIQRWM/E7LVy6hBYjcStLWOPzBy19wbuITgk/i?=
 =?us-ascii?Q?Y8dI7nZPdQ+/QpB8I8p9onmjCEEmWMBS+lOPrWhj96+wfIH+31QClLRs90JV?=
 =?us-ascii?Q?7mqVV3beRjNXI/rRLT7G8awtv7QCj9BwwqpTmcUZGna4Wdlo1dbG7wH0NqDZ?=
 =?us-ascii?Q?JQ6lI88qdEYmbXKTS4BTRB6yOrltFJ/9N5ZaEIw607AYes3vTm0/a565+M3n?=
 =?us-ascii?Q?8izIgPg/DXa5MCe6pp3lVRTjxXCZUSi7Xkz6YGlRqlAyTjZw8uwdk6humhdl?=
 =?us-ascii?Q?UeqNgV6vrtpIb69FvNiqRE5drbBLeDQjop6ttAStcAbNzsLzP/san/CMXX86?=
 =?us-ascii?Q?XNKvSxc7T4mkjgFgsRD5YrAG4BLIY3uNdVOCV9EZRpBUlB0SzO5T0by29IAa?=
 =?us-ascii?Q?q8Vx7TKl3eeBIoPDVI/5NKViYcv93ytiDY1SvMTlu5mHIHKCn8Z2rfnBpKzn?=
 =?us-ascii?Q?J4JvFjJecDDkWw8I4OKXJSWwan4eRuLaMazK9LH2jtfVVK66Jsml28T/uEAj?=
 =?us-ascii?Q?4g7y5Sb2CqYjk5kyXzf4oyyIsTPiulheNhN6WUwn8vZrsiPrT0LE9NYB/hpj?=
 =?us-ascii?Q?kJxPnA3idv1RQFa/PpmYDvjf/XYY2XoTOM1wnHcr2b2Yt8sCAI8JE2tg3bJI?=
 =?us-ascii?Q?SodEPfto8OCd/gFewWmvWQvmW/36GMN+cRZqqJyMuwJvaGRjX7VDy+gFEBmy?=
 =?us-ascii?Q?neqNfaZeS4R8TP2+g4t0s4xuI5+coXaweQyM4LpwtTbCdavrVhh2koZudjE/?=
 =?us-ascii?Q?2DC/ODQhWZRCiZaLJga2PM8PpZydaxDtVW6U6f0VTjOqn5RreMiocPiE11aB?=
 =?us-ascii?Q?2y3FvFy+tZJs8e78G9+wGYC7MqE6MGqms3Vdo2PynA+bUhl0vn7XP5TrUkU+?=
 =?us-ascii?Q?5LAbnBXcpIoGPzXkbyxu34cK+2RijJ7UYLZQMux4AeTSGrsNW4fhbdbxbCbo?=
 =?us-ascii?Q?JzfoD7DYlETBkjrKIOUJWtrekJpKczwS1w7F/8IG38NKeWH+R7EaDOQ9hXVx?=
 =?us-ascii?Q?8OjD/bGgdHzs3FVqn2Cz7TCdV3f/x8zRXGkm9xLPqOm5FH3xlvRDhSislkQp?=
 =?us-ascii?Q?+N7dLp+boKwXWSScKaheQ1kyLSuAGXGrGIneZyjjmrVOQwcoCKfLafiUJ394?=
 =?us-ascii?Q?vCNbXlORcD7R3FYvv3ghfnkEgfRfH8laPmXVET3XVTnMfm1SGF9/DWpZaLpH?=
 =?us-ascii?Q?vfOGdzGuObE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXP189MB2079.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nZP5cNEufERTB4NFLcApj48QE6I4U3U6sj0A0djeLw2m9RjCXPySokjlTIvn?=
 =?us-ascii?Q?ZwraKQMMzfOwg84xuWmmjUOYb8w4CRL5+XvCZrmtkdmlqGKZZo0PH3Fa2xO2?=
 =?us-ascii?Q?aUGONUOva66CEV1F3WDosh3fpj0u+pXY3eQejhXprxM53O1Ml9Ks7EcHiduU?=
 =?us-ascii?Q?9qEj6hX7xx6MnJ0vf7rwaJrssWRZNyU3cGsZrHxuhMvz7U6IFUon5gjDRZhI?=
 =?us-ascii?Q?IqT3qqhFaR+nQHefpsVhaQPmBapPwTOK39JwCcQLPxw7DZl6PfW7zOLtm85i?=
 =?us-ascii?Q?2OrFEqJSR58mqfOB8DC/wNd1SLy9+A2JIvFKGMmQv6buAa+/2REVRJkdZxkd?=
 =?us-ascii?Q?ui7zGxWQkX5gndztf0ps+YbpgNBIJvDxAODQzqx1j5WGr0YYO1MdC4NONyYr?=
 =?us-ascii?Q?/BUEqkllnW/PXZwwR4vp/vjj+YzdB4BXpfOQ9GtE2ZUmTy/a15zjWxDO1glG?=
 =?us-ascii?Q?lZPS+XQ1JwnuWZTWkx59qpLHrWPvNtnQpYYcx7aFpFN8F7qeJAOIePKTbiox?=
 =?us-ascii?Q?qtlbefif3g6BNURTdV2P1xMCaqg5Vxs9HNMtPAer15sZFVDEiw9lCNz5q8yU?=
 =?us-ascii?Q?fv/olqRmsemcxM6JW6oHIeQM7BrLLqEL1QHNxeimDEsUKQga/b9YSqFpaDrL?=
 =?us-ascii?Q?AzpE8pKJk8851ViyLwQe/RlFOzOjMm9QZPJMrGCtO8Ny939NYhN9ANE5cZJd?=
 =?us-ascii?Q?XXt/4PYQ9QjPomXd+J/Bg1yqKppcAED7JPFbL9tEE6XYvaF1PDBNC5EhHxgi?=
 =?us-ascii?Q?phnnxhIDnzc3H/EEwv6+FSrsdHkfZV5FjVjiqDd4NxHNw7BZdCtvHgi9LmnW?=
 =?us-ascii?Q?g/4HtrD1qAoRmRoiTavgoZ69VMPgxbGaZ6deBjAMM7sLHjOub5CndLM3Dfgp?=
 =?us-ascii?Q?QQvyW1PpPycJ7QUCKtQpFl6y2GS3989bBSvwfrXJXQi/aKaWPYmbU5nvtieV?=
 =?us-ascii?Q?iyvIrSydil+7golzXk9MGG2KbtlMmCh55HuAn8e8jgptPWj7O/Mp7XcreHWO?=
 =?us-ascii?Q?r4UnpbzupW6HDwx0hnD4tuPpHFn8ZSpqJ6BoxlejZSzmbcfvINq+KCvRUCMp?=
 =?us-ascii?Q?d0WusXMTc7GrA43toeRmhbDXeiubS3ed3dlb/FCF2t/I38OV8yShoFqdjlrJ?=
 =?us-ascii?Q?vb2C+aFEuv4jwlOfrfG9YLI5iSuFPgW1TUhW3NUjsKUXS/Ovtk8NdEwXgwNy?=
 =?us-ascii?Q?JckQPW3fpg4h3FvN9S794hq9VSxvxv7T30fmQF6hjLVpYfYlD9TaqedPfKxC?=
 =?us-ascii?Q?yUQZWxgKew2LG8MWfzeSWEp6QvzKWcVOye0j9rEWaRF0Rqkc9xY8hjyGpWyW?=
 =?us-ascii?Q?7U+jRCohwiJTxbDHe0Vkmx7H57o1u5Lj7z35balGvM+zZAus4WyrR0O+9XzE?=
 =?us-ascii?Q?4oFyWI0v9HNzA8tTIBVHSweKhQTTUj1qVXm/71+tRwIG3mKWCLxeLUnFu+y0?=
 =?us-ascii?Q?y6uUKGpYIU8LuqzzpZWSvEVYQpVEJ6vZoyS6b4CY8uRxaLxauYFiWSlqP+ue?=
 =?us-ascii?Q?aCTI5uXGHlqJK6t2R4ojFXHkZN6WCSGUuAUp722/Bsv6fDrIkERZsW2kXCgL?=
 =?us-ascii?Q?frMVBBuqXoYpxOlTMOIXP56ml1S/HJjHJ4yoZaUIwW6XrXnZE3UcUkBl89BZ?=
 =?us-ascii?Q?4uaOARuk84W/8GulM+6+MNncVwaskL0q4bt7UXlipytoEsVreisWzaoADx6o?=
 =?us-ascii?Q?+p+8EA=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 72634158-f22e-464a-0949-08dd7d84400b
X-MS-Exchange-CrossTenant-AuthSource: GVXP189MB2079.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 07:48:32.1865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AXfhCwHlRBF6PrexzxHupBEcNpG96IUwaw7FQNd/JWeh5A16fRPZvleVTJcvsCE0RKCD5VTPsji8AJqlbjPB1NVQnLcnaeu9cGfI0VXHXW4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P189MB2064

syzbot reported:

tipc: Node number set to 1055423674
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 3 UID: 0 PID: 6017 Comm: kworker/3:5 Not tainted 6.15.0-rc1-syzkaller-00246-g900241a5cc15 #0 PREEMPT(full)
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: events tipc_net_finalize_work
RIP: 0010:tipc_mon_reinit_self+0x11c/0x210 net/tipc/monitor.c:719
...
RSP: 0018:ffffc9000356fb68 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000003ee87cba
RDX: 0000000000000000 RSI: ffffffff8dbc56a7 RDI: ffff88804c2cc010
RBP: dffffc0000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000007
R13: fffffbfff2111097 R14: ffff88804ead8000 R15: ffff88804ead9010
FS:  0000000000000000(0000) GS:ffff888097ab9000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000f720eb00 CR3: 000000000e182000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 tipc_net_finalize+0x10b/0x180 net/tipc/net.c:140
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c2/0x780 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
...
RIP: 0010:tipc_mon_reinit_self+0x11c/0x210 net/tipc/monitor.c:719
...
RSP: 0018:ffffc9000356fb68 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000003ee87cba
RDX: 0000000000000000 RSI: ffffffff8dbc56a7 RDI: ffff88804c2cc010
RBP: dffffc0000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000007
R13: fffffbfff2111097 R14: ffff88804ead8000 R15: ffff88804ead9010
FS:  0000000000000000(0000) GS:ffff888097ab9000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000f720eb00 CR3: 000000000e182000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

There is a racing condition between workqueue created when enabling
bearer and another thread created when disabling bearer right after
that as follow:

enabling_bearer                          | disabling_bearer
---------------                          | ----------------
tipc_disc_timeout()                      |
{                                        | bearer_disable()
 ...                                     | {
 schedule_work(&tn->work);               |  tipc_mon_delete()
 ...                                     |  {
}                                        |   ...
                                         |   write_lock_bh(&mon->lock);
                                         |   mon->self = NULL;
                                         |   write_unlock_bh(&mon->lock);
                                         |   ...
                                         |  }
tipc_net_finalize_work()                 | }
{                                        |
 ...                                     |
 tipc_net_finalize()                     |
 {                                       |
  ...                                    |
  tipc_mon_reinit_self()                 |
  {                                      |
   ...                                   |
   write_lock_bh(&mon->lock);            |
   mon->self->addr = tipc_own_addr(net); |
   write_unlock_bh(&mon->lock);          |
   ...                                   |
  }                                      |
  ...                                    |
 }                                       |
 ...                                     |
}                                        |

'mon->self' is set to NULL in disabling_bearer thread and dereferenced
later in enabling_bearer thread.

This commit fixes this issue by validating 'mon->self' before assigning
node address to it.

Reported-by: syzbot+ed60da8d686dc709164c@syzkaller.appspotmail.com
Fixes: 46cb01eeeb86 ("tipc: update mon's self addr when node addr generated")
Signed-off-by: Tung Nguyen <tung.quang.nguyen@est.tech>
---
 net/tipc/monitor.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/tipc/monitor.c b/net/tipc/monitor.c
index e2f19627e43d..b45c5b91bc7a 100644
--- a/net/tipc/monitor.c
+++ b/net/tipc/monitor.c
@@ -716,7 +716,8 @@ void tipc_mon_reinit_self(struct net *net)
 		if (!mon)
 			continue;
 		write_lock_bh(&mon->lock);
-		mon->self->addr = tipc_own_addr(net);
+		if (mon->self)
+			mon->self->addr = tipc_own_addr(net);
 		write_unlock_bh(&mon->lock);
 	}
 }
-- 
2.43.0


