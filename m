Return-Path: <netdev+bounces-136704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA2B9A2B3C
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 19:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 407581C21EB1
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 17:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA811E0DE4;
	Thu, 17 Oct 2024 17:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="TgpmGOSe"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2077.outbound.protection.outlook.com [40.107.241.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2071E0B64;
	Thu, 17 Oct 2024 17:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729186938; cv=fail; b=fUB8HPg2MpA3J6uSMPojlHzYaBAqzsbX9L6qMNV8ySCo2P5ll0bo0tSXDLmvmmolqXnqat7vzZuNIjqSKmGcKocV7gIXvpQuPyknrzjlqTUwx7OhuC0KHolyXI91xcWejukBGHt/3WD4ifxpYU+AViqJr1Pb/27y7vcTtO/2H4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729186938; c=relaxed/simple;
	bh=CV7DLPOS3ZzbAX/Zx0kScfL8ePrssFXGJsUA6SSy2uY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kUGJ+cRPhnh5VH6RC9eTgzXcnR5GnserTw2nnn2/xvt0JVp8ZzFa3i3Lcw/GMQ22ZhKVvrLWO6ZRk39Tx/Z6fxgSDBJ2j56UC/I8WqLDqokoR/O+kKXaDgZhsgkY3BZVWDzJ9axQYggOTzjmkW4TZty7sbsM6fnxyWPQ+aHgdNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=TgpmGOSe; arc=fail smtp.client-ip=40.107.241.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oPAXuhbnf9CfAmeAL8bSv1BTZpgu76qXiZ4XancCldRvJ08lqacg1d2SDhesFMW88P6YtJvaLBSvsUVRsvBHe68gB5rkHS9qhIGo0kxbZ70bKoywZQ2m+90NlYiM70/M942sJ0WzQjWka2iCW8UkYsOSVNJEsr/hXFDY/Oxl0snsCRMMCFunaQV419ChhrQ76KjjBS0CeYyugMCwZoINRoHhyc5hizf0p1zfBdFlUzyI1Mk8h/gowwXq58cdjbqv8aYadJFLpv6loaQ5gtD/xgAl+wkF0l/viwYOFVtsjkLHb3LvIiLwAzLEzEiLoua6UgZWCRgbwEhgt8c80fAHig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yhFnquXnBlFEfFr68qI6NMcJ6v8CKDiUdj/NHobyRMg=;
 b=JN3CGzLkkqJk44Am1MUnbximyVHENvzxfDvDjwl+r9gGCDEVcIfGEaYa2wrQlOuY8WP5M9bHd7adYRYmPGfEFxYhbpbEZv/+bFRKsaOpY3FBTobYwFtTeinWhNepN7uA71RHzx+Fl6Bw9bpd/Zglp/BPcO4x7O26MSxVoyBlrM0VsC9rVzZxkbSD72o9R3ABbW21ljecEzCM7VkugYfALRiG8EzzYGYIxlupr99AqpR6QYHoOFe8r2Ak8Ii+f4agB+r5HCNcTbf5hT3HQMvSDel30lNurb66F1KqS7tAZ2rX4aAb//oVBELM0TBBRD1/FuusFQZmpNBlgI2ek9j4YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yhFnquXnBlFEfFr68qI6NMcJ6v8CKDiUdj/NHobyRMg=;
 b=TgpmGOSebIzjod6ifG1YUP74Hkz/R4TYZOEhpLSylDRY3ikVQrQZhHEQRVh2e42SADmkScRtgC1PSIvFYkPpZRXWGZCyIGNkiHlliSVwausMTlnv9tQjEXTXGfOaFeTAGXWQ2+zpnm2QKSF3QhMIFllBllp5vJa0dPoonqc1AwPvrzV6mqfV4TxZe3VYUQfT+KoHkZ/e5bwc5pyqTMDMuJm+LrEswZk0iQXZYSgDgsi1FHmTJy3Jb7ecJaWt6rZrprnrIP0q3RcjwzWbnViIlyfMQUcw0Qn3g3d2jAK6NZhnTF8OdnTUTNMNsalVqDbPZZiYm0N4zENJG9qW5Bs4Dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by GV2PR07MB9009.eurprd07.prod.outlook.com (2603:10a6:150:b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Thu, 17 Oct
 2024 17:42:01 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5%4]) with mapi id 15.20.8069.018; Thu, 17 Oct 2024
 17:42:01 +0000
From: Stefan Wiehler <stefan.wiehler@nokia.com>
To: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wiehler <stefan.wiehler@nokia.com>
Subject: [PATCH net v6 05/10] ip6mr: Lock RTNL before ip6mr_new_table() call in ip6mr_rules_init()
Date: Thu, 17 Oct 2024 19:37:47 +0200
Message-ID: <20241017174109.85717-6-stefan.wiehler@nokia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241017174109.85717-1-stefan.wiehler@nokia.com>
References: <20241017174109.85717-1-stefan.wiehler@nokia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0197.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::20) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|GV2PR07MB9009:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f7be4bb-d4f4-42bf-49be-08dceed2f6d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AT4SGStjSCIbXX7DG8zFXX4RNfiDUZ9X23/BEsUl/YMJZG0WNmzmN/6Z7NEB?=
 =?us-ascii?Q?pOo86YKPab4ttx8NDN3ahOeQw6qvAFMxb/xsJmwQb1wZy1cdMvTMmBh1o11b?=
 =?us-ascii?Q?PauUdml4a1wLemZpqrZGhHN0uSnBeZNRV4kSwRUWLSoSEdqkIj9nhraJbLKb?=
 =?us-ascii?Q?PVdW2FAwLJIKS4aE+eAYXFCwXUkA4GWod6ACyrx+ih/fPmb1ZBY3gDjEAJhN?=
 =?us-ascii?Q?5sOLHKkLPYwluwZPgACB9Th9KMTDA9sDFi0hNCgEAJGpkv0/CcCRAcQPgJdy?=
 =?us-ascii?Q?vXN4Q+LKkmM14VFBTDJZ7aDbsGO4zeAiYvXq2Rytu/XsDQQsy5LbTRvkLJFO?=
 =?us-ascii?Q?5MAHjbSVXli30kU3cwVrqjE78Fcj5fjHUva00UMGywjMsxCgMY46EmuK0Vcs?=
 =?us-ascii?Q?12pFqCLk7AqDB3XuJybUW/ldhup++fcw1vHJfJXjUJvV5PhRegZ/8nikrD4L?=
 =?us-ascii?Q?Ayk6IXnmvKmyBelglPGpYDySddzIkJU6XEayxolLTka/AWxj1+6W4G/gQ1KA?=
 =?us-ascii?Q?soervZfiSgmoRURodZQN/G72aNPbA7zuopnFnn9Z6IULgHWk+0Austr9dVmB?=
 =?us-ascii?Q?gzxuzk5H8PrZW1WYNKTRaYd79MUZCZsq7XlVZNo/pBvdaNWuJX7LUvY4MW0C?=
 =?us-ascii?Q?ufcv68zS11Rp9CuK1qY5LxOR9Or7j9Zbwwi6bWOeNqyeDF4webLpAffr+Ti/?=
 =?us-ascii?Q?OQV2OGkPFxZo0NkDgrejWHK3Sx9UaCDYQmhbzmLDor7X6nkLm6tQ3GgNS4Dd?=
 =?us-ascii?Q?8GOcmOeGIfLxtHH6+rjjqEkSBUdkRLSreYrKn831J+zKd0oRXeByxZLApA+K?=
 =?us-ascii?Q?3YvFv3Wh4Fk9tgbJ8GehWoUZJuqb2J3sa79CBBd1/T57l6DFqvcPwFkSSLf4?=
 =?us-ascii?Q?OFFcQrG8AUlFwmap7amP0kuwoEsgs6V2wJqWhs6onM0UnKfyO5YHumH20r9F?=
 =?us-ascii?Q?iwRk94YSfTPhfVpmdd2pBnfWpDyYWJBBkdHzmMyH7I3SetKBjXk9fK2oQouc?=
 =?us-ascii?Q?JjSnJKPH7BMeV1udenOSUVdSRL+NefjgtZVX9uTNZzU0KDHDRawntIWN6uP0?=
 =?us-ascii?Q?hSgIiL0ybvJzOYRKsAwIAjt82CW7i0Vzime4o2JyPjzUOAdbWPEg/RmMwLG4?=
 =?us-ascii?Q?US+hFlpkszarvZr81puhQPf10IPdRcd9kwsKkNXBFujpN5JxwhQvwIq8YYra?=
 =?us-ascii?Q?QoQebELgNKLQZv535C0wx37z1fpothxdyIDenxA9H/ZCUS2VWq061CFCivVC?=
 =?us-ascii?Q?yWusuV1RS5sTsGpr2IM9lW+Sl3BLo8GMI05klbug4GsvnqdIeVaGugCiuxYP?=
 =?us-ascii?Q?BWyur3ZHRg7LLE57lBmpA1ZaKyX8KMikyXXipRb9OTgXOw92VEIeCdE2nXKF?=
 =?us-ascii?Q?IykHkzE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JrAsSJGx5/FyULILmI6f+n9UF8/irNjl67FMp8321FfySgSfEaAf9jKJjWPa?=
 =?us-ascii?Q?xQcKVQzZBl4L4kGdSPpycl7DprCrf4rlHXo7v20z5jLKen9fVMkRXIOdRpaj?=
 =?us-ascii?Q?VbH+TkqEWlZKt9tMzhSsor+DEdyv9LhLAMkVa8SMj6I6vafU1g6vHp4FJq5o?=
 =?us-ascii?Q?PuG1G1pYND24fN3tMbhiYKmOB9HPTfKNStptmdpl+KPKavB6loUryYSVKI0Z?=
 =?us-ascii?Q?KTjY+tAGFa+4Jhh57fXS6VqCzAii/1M3FsY7k0pn/cWARpZy+I8AhSxMtdex?=
 =?us-ascii?Q?sXlxWfX/nMHdU/gOl6PcMCA6D9inGDQFi/ff2jyOYaQG+rJWsjb215Sbjbs5?=
 =?us-ascii?Q?0lpeiwy2/IOyU1f4DteCgPl6BFBC0qfjNwGT7jkFwwmvQVyvnXgxoPbfks6b?=
 =?us-ascii?Q?NrMmZCFlg+nlEbe2dYbS6tCftryTs9MheWJm8BKdMBDHOgu3QgzYWNLClrti?=
 =?us-ascii?Q?jTRVv+lV5xgtApYM8q7lIjOiEJHPjYJvquyMNnrf9u1BP2MS+GA8PyOnD4lJ?=
 =?us-ascii?Q?e/6J52gOJnffzSRNl04RJXtQ4W8cJ8D5Xhp55c0llWQfHSBaQlcXhcllCOiE?=
 =?us-ascii?Q?BcdiaZBWob7+ji2ll9bcqpCIbNa6n1QRZBvJ4uCSUljJseVjZJtWVsNKX/i5?=
 =?us-ascii?Q?ksTUOk+yynGDjMXZEERuX3X9AhxUDlYhgSFAyeG/hXlCov5wnH4bKCAR301/?=
 =?us-ascii?Q?JRWOkM3/S9AquwbLp/u7PgpfBJ3ZoXKSeAU0i2wrWv0wKnXnJHmFjjQg7+DO?=
 =?us-ascii?Q?ydQQVpdDj8PggwdKLxG5SSWjl5FITSDqVdDN/2n+JVt5KODDiOfrccCJ8O2i?=
 =?us-ascii?Q?3f8fRuRQ8l+EwLFjfyEb/kfXzPRqZCjyvF7v/p0PJFuXITvB5tpnP2m/qUgC?=
 =?us-ascii?Q?Wiwde9YW9sd42Vt+zHZ1u49+OiNrbcV8FkgdjGkEO1DgS2DhwLvXB7VUoHFS?=
 =?us-ascii?Q?zGGtBrdRygmOsY/SQDmbR+QjOqaagJNhyBkMtEDZALyXKs50trsplipzgG/2?=
 =?us-ascii?Q?nssV6tkwpTaZPsn/hbV/B8EZYzNgU21UvgIqcp8CCcbJPcZX0D+kFCrOcNcc?=
 =?us-ascii?Q?SMRCQqtG88CCGOgjDQ4X72TJWDpY8NpvVt7G0+/jr/FbxwA5Ih19exdob/VV?=
 =?us-ascii?Q?quikJD0v+U6M748oqblR3KundECQOfsDEWJWpa0whxYYCgbgzJYun6OqGQL0?=
 =?us-ascii?Q?toUj3UqYUcgxfoNq0VluKizYqoC/FYpP+qmTro8kquby6zUTlCDpe+/fE1Yn?=
 =?us-ascii?Q?r2mX/WzeqOD2yZZ7COXmLL1QVqAxz5pa6TfL/rWRErE1tYhjiVhyuoJvSaMN?=
 =?us-ascii?Q?QbH+AfXxrOh71tBuaVL9w8FbW5T6zErQCKK6XCEXyMuHZlzUegIPf8gkq+RR?=
 =?us-ascii?Q?8GDXII2UIdGjqXh03T8F8uTCWsP39xrn0qQ515sRfrNVSHONYmGfBbbzaje4?=
 =?us-ascii?Q?ZHgAGNaf7UC7XFQI4ROyfe+fbd/L/z8WPUoP+bLorfpafIC69Qg5OyCANciB?=
 =?us-ascii?Q?Ucahif8jt2In8bWsNnZVVxWXaxYY2WEtZ67PgxxHIlik4pZEqitIaT2LMd2B?=
 =?us-ascii?Q?jgpT11iV53m47waX9mgLAOFHQQArq58rcH4yzckwfCEGF4ci1h5qB9koPbP1?=
 =?us-ascii?Q?TA=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f7be4bb-d4f4-42bf-49be-08dceed2f6d8
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 17:41:43.2535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nj9a3DNXAKiS83upQccyOyxwCXWg3lEmk0Y/QwUbmxe9Vt1k3FjoGodD/JK2uE2U/fxmg9yeGVDjEKRIfhhWQzdlZ38wtE+HjaAWmG6bV6s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR07MB9009

When IPV6_MROUTE_MULTIPLE_TABLES is enabled, multicast routing tables
must be read under RCU or RTNL lock. Since mr_table_alloc() can sleep,
we call ip6mr_new_table() under the RTNL lock.

Detected by Lockdep-RCU:

  [   10.247131] WARNING: suspicious RCU usage
  [   10.247133] 6.1.103-49518b10de-nokia_sm_x86 #1 Not tainted
  [   10.247135] -----------------------------
  [   10.247137] /net/ipv6/ip6mr.c:131 RCU-list traversed in non-reader section!!
  [   10.247140]
                 other info that might help us debug this:

  [   10.247142]
                 rcu_scheduler_active = 2, debug_locks = 1
  [   10.247144] 1 lock held by swapper/0/1:
  [   10.247147]  #0: ffffffff82b374d0 (pernet_ops_rwsem){+.+.}-{3:3}, at: register_pernet_subsys+0x15/0x40
  [   10.247164]
                 stack backtrace:
  [   10.247166] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.1.103-49518b10de-nokia_sm_x86 #1
  [   10.247170] Hardware name: Nokia Asil/Default string, BIOS 0ACNA114 07/18/2024
  [   10.247175] Call Trace:
  [   10.247178]  <TASK>
  [   10.247181]  dump_stack_lvl+0xb7/0xe9
  [   10.247189]  lockdep_rcu_suspicious.cold+0x2d/0x64
  [   10.247198]  ip6mr_get_table+0x8a/0x90
  [   10.247203]  ip6mr_net_init+0x7c/0x200
  [   10.247209]  ops_init+0x37/0x1f0
  [   10.247215]  register_pernet_operations+0x129/0x230
  [   10.247221]  ? af_unix_init+0xca/0xca
  [   10.247227]  register_pernet_subsys+0x24/0x40
  [   10.247231]  ip6_mr_init+0x42/0xf2
  [   10.247235]  inet6_init+0x133/0x3b9
  [   10.247238]  do_one_initcall+0x74/0x290
  [   10.247247]  kernel_init_freeable+0x251/0x294
  [   10.247253]  ? rest_init+0x174/0x174
  [   10.247257]  kernel_init+0x16/0x12c
  [   10.247260]  ret_from_fork+0x1f/0x30
  [   10.247271]  </TASK>

Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
Fixes: d1db275dd3f6 ("ipv6: ip6mr: support multiple tables")
---
 net/ipv6/ip6mr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 017f9e31edfb..9bf42aafc7f0 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -236,11 +236,13 @@ static int __net_init ip6mr_rules_init(struct net *net)
 
 	INIT_LIST_HEAD(&net->ipv6.mr6_tables);
 
+	rtnl_lock();
 	mrt = ip6mr_new_table(net, RT6_TABLE_DFLT);
 	if (IS_ERR(mrt)) {
 		err = PTR_ERR(mrt);
 		goto err1;
 	}
+	rtnl_unlock();
 
 	err = fib_default_rule_add(ops, 0x7fff, RT6_TABLE_DFLT, 0);
 	if (err < 0)
@@ -254,6 +256,7 @@ static int __net_init ip6mr_rules_init(struct net *net)
 	ip6mr_free_table(mrt);
 	rtnl_unlock();
 err1:
+	rtnl_unlock();
 	fib_rules_unregister(ops);
 	return err;
 }
-- 
2.42.0


