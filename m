Return-Path: <netdev+bounces-134504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 736C7999E7E
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 09:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0DB61F24AA6
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 07:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B5720ADF1;
	Fri, 11 Oct 2024 07:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="A+Zb8GgA"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2066.outbound.protection.outlook.com [40.107.22.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3110320A5CE;
	Fri, 11 Oct 2024 07:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728632951; cv=fail; b=kH4nGgA7aYa7Ai5djcWy5cK+VFC1EPPJ9zNVBZFR+Ca8Y6sa9fBPhdhVhBQtBLrzogVzHvMmvdlVNIH0Ckup5MD3TJLU50aPmgKjjdVzVVOkJ72semtor0sJbESwYHHxWaEJJOsTg2RUg0d1zMGi7RJJ/Ib+NW3lF2pzmhmD1SM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728632951; c=relaxed/simple;
	bh=Ub3FhLOugsTudiJ21QKwCsdpS1c6AbFIk/qf8Sza/5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k9mON319qpOQuRK1FTcBdfzUsxPcKxnMfO9TXL8EES44+MeRGeBZGpuCCrc3V5F8UMH6/jM4z+FkDwWqStQT4NTYAXgmJXKI76z+LGSsN8GTvYJgDnxE7Zkk+/5WlcmSbUSVz4YgFuNsPheOlDuMprLn1W4RTAjN8M2ZZqknv5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=A+Zb8GgA; arc=fail smtp.client-ip=40.107.22.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cKoCsk/20tF+5SgBX4CvoUFK8HHpun9+3cfDuRU5sWrTdDpDAl7a9SwR6abLqGWlqhWEZVS7cAMyNrDBvg45AMiOkLeMM8QACzzdo8N63DHyaUKJzyXJMp7K3g8wsmmu1Df3Y5bWuVPEFRx2OJxv0scPZaOq6n5gnraREhlWK8iKZ/OQMIww25c8U/97ZRosKcxdhB1vaQpv2t7Dzv/nTF8zETPu8uv3iE5wWsIkGyFpXqIztejXxBx1IIzk5CEeBRWMi3XnR9wbHRnEFy3P10I3TS6dFm2RU4bYzwJmti6o9B9uZygEMaaUYBuw9nDfY1Oi7g9v1bq+sLq95gg2Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8YflvkPl4XBLYAWY6+EvgsWBUsmz7bpQmXcECT85pbk=;
 b=F10MH0ku3zTrAyZJDHu5H8MEqYnXsIHTZ11MGLfv65dpU8Mg054QbFNM3bQJogZHu7smp+hiNulnU0fAq7aoEo1XAZ/IVJn9YZ53u1u8DILtkkBVHnPSWphan8h7AvgyenNxRxIwfpq7hMJ3l3dqHcQ6d6ALoITtzagnFAIWwtwOJzQZugTTfNupl8KEJMfx/wMPNQVj7LNc0btCbytH9yn4bgwuTGRIPuf5SfRX2LUY+kKgDdZVURwjcvswXW19FZ3tqDbjzC8ZRiN5EHvhNsqOVr2zxYO1a5vhvwxvR1MigncIcK190FVObrUXe82kwadByyei99RRCxI/TzvbTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8YflvkPl4XBLYAWY6+EvgsWBUsmz7bpQmXcECT85pbk=;
 b=A+Zb8GgAD/rWwpni/nYiRTedIgHJn9LyujlpNnu2YqonviYyO/yKVOa3RSpFCBcid6fpaY+QaQRfwTtJrsZsUOWZ7xvb1NYi+h3V8o/1TolNl4ix9fA8KW3pVx2ypZLpMODiG0ANIQWiSgWtPtqeAAk3TGPXM42pUZsFxysQBuXZvpjf4nnNIH/IQ4A20o2xrVVGfBQ3h7N3nhQybycskyrVUljlT0LoZdK5LeyIeT0+JaWbvRtAz5dIwl2NMmmvjMGJQsw11k5fPaGHEDEl0aMsFllf6uB9qo48Gdx11pmmIF3wnIu6TW0EccOefEQDvN5nJBUo/+fsJDbe8nqgMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by PR3PR07MB6922.eurprd07.prod.outlook.com (2603:10a6:102:7e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 07:49:05 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5%4]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 07:49:05 +0000
From: Stefan Wiehler <stefan.wiehler@nokia.com>
To: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wiehler <stefan.wiehler@nokia.com>
Subject: [PATCH net v4 2/5] ip6mr: Lock RCU before ip6mr_get_table() call in ip6mr_ioctl()
Date: Fri, 11 Oct 2024 09:23:25 +0200
Message-ID: <20241011074811.2308043-6-stefan.wiehler@nokia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241011074811.2308043-3-stefan.wiehler@nokia.com>
References: <20241011074811.2308043-3-stefan.wiehler@nokia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0175.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::12) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|PR3PR07MB6922:EE_
X-MS-Office365-Filtering-Correlation-Id: 39622226-0726-4323-59ef-08dce9c92e4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2kMuBF3jzETtEU3aSCpFXE/J+/w9geClJ2Yb1wPebOwjyvDz+93sdsdS1EZE?=
 =?us-ascii?Q?1JlcLSiVGSFoJgXOlM1T8iGiiCpg2ueHRtuYOv5eGaTriDhaFcTxOP+8QONf?=
 =?us-ascii?Q?9SH8H1qHxsQ49ret90qN9LLLCVCzrO0tTpaPsSOtTKSa2CBTxFflZ+R8tA0V?=
 =?us-ascii?Q?LUStJISNGy14BUicjyzjRmmW/vpQWEFLHq4ww5hBAydupZh4uOhBt4ZaaD0B?=
 =?us-ascii?Q?Ck2rOKLBzSMV7+Q9aS9mIxOlQeq5PQPwVFxdBJfmqPUbOR4bsq9wV1LR623R?=
 =?us-ascii?Q?bOWmckpyFP24we9d90GbUkyOs9dG1GNWaVbowV3jw/w6bUrO8UD1pKYW4qJA?=
 =?us-ascii?Q?kCcuJyUlgC9yrdsdDmw74qtNPgSiws8irhmF5xP/dedw9KxOw6HDe6CspeRj?=
 =?us-ascii?Q?jKmRHWsEjeCTVz8eHGHIByn/NpZ+J0zvHSv6LYnQLbIL2RYq3JXlr7pMI5OR?=
 =?us-ascii?Q?Ch96qXQYvSb8OmTeumw7c2wdX1zL+I2jTeEdhoAdhkJ2ZzrxEe5/Rwjct8mE?=
 =?us-ascii?Q?iXoKCcYhVROUumJjWIQbVXXMz10KYZbCWu92OPLoOdV/VifBkgdJHzu4jWol?=
 =?us-ascii?Q?5kVy5/R5kDKUDbXDSq0F4VRV6qy6JPnigRteiob2yKnTBovMTDcf/s9/0X4T?=
 =?us-ascii?Q?1luVEaaPUIW/lz5jbPXYklB1cdGZ1O7tK9F/XQWkCj9MIAUcIEpkfcD22/6a?=
 =?us-ascii?Q?ePN4ZOZ2HqcHrqIRYWSkWwH/qUrAMn7RUf/QepYbTXhLe4AUqEO42orMn3ms?=
 =?us-ascii?Q?hk7PYlYuUYnnLERndIcTjOFfHdFfCFJNbNUfPk+sxMnqOlixgOpJSIHzvzVm?=
 =?us-ascii?Q?23bIMxKz7tuMHjwUJyBL/CirGmcFahaJEsSUp4SB1BlU1PwU/tGmHGL233DB?=
 =?us-ascii?Q?udG3Cl8q0AZdX7Fad8M11YBGBOS4Inc3Cr6d8PSQQ4GUuYQx5U30KJe6CPtt?=
 =?us-ascii?Q?JjT+lVLkN43KoFcmGAoHNULGlgtjcJs9tmbGSyHyWs4nbi40AYKRoTHXZ+OT?=
 =?us-ascii?Q?YCAE6AiDliIXNtY9xtlDH++V1+flRKbu+i8l0eApsFPKgUCYJfTnq58TsSyd?=
 =?us-ascii?Q?3ZoP6gPpc7My9/+/Yl/G9grB/+RzOyEpcuNAmFHjQvsfi+ZWIkhFt823LoFI?=
 =?us-ascii?Q?38ahUZE+N7EpsYJjTMMgzS51MeNLs3X5m2u3khY19IOaT9rdq4Sh9U8SbTYK?=
 =?us-ascii?Q?TBnBrpPoCZgSc6LA7FYnCqMFxCCZ/awuy1ojrmEFC97/X+E7JxKODkWsR5on?=
 =?us-ascii?Q?wllRnuCQcMEEckb2DqQYnLoudkl9zRmPjl+sW1U1kg1+CvyLYDbudeLhV1rD?=
 =?us-ascii?Q?ACYU3beW40DTVa1DAlYqzN16a8ZjGtPvYRPY4AbLwtMlXA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YmMpSHzv/CQ8bmElVklvAdfjuXTGflXxzrsfNxIhPcOU2Dnk1NVEqapIqQHK?=
 =?us-ascii?Q?K61BN9TmoxObKu3AEesHQtwVUoZ6+KeREvaGrraqKYXkEtuN72/108Oa8bVZ?=
 =?us-ascii?Q?Tjl3XddmgJv+vox+4GMrcmtbycOPy31esdoVoyKbe4edWTPKKPMVnkL9zuQp?=
 =?us-ascii?Q?Ae59M2n2FjbNLKDOx7DBY2UWMNfPZJ/nNjYElPm039z9zKTH07cDvtgNTEP1?=
 =?us-ascii?Q?8Jb7DhEYH2nWJLHUvCwybY30kixGbuTaSbVzZZchj6t1/jkEdTKvOYktKOvU?=
 =?us-ascii?Q?OQbBjU/ly/9E4AT3uKzL4ER88QgxyGPf82HPjadjqmwKiIssVrnsnq/UWn62?=
 =?us-ascii?Q?Sx6xqn0R4JZfY/16k8+mEF6x5LrTxINzrHI9J7uOBwIHNx9ajflVNO4LCpuA?=
 =?us-ascii?Q?DvIcuIMXvcfHP1TD3vT8YC1LJI7GhfZq3zE0B7WZ9tRX5NeL2Il0UlczY3Ij?=
 =?us-ascii?Q?BABj/UYZJhA5CUfqmohjqm3Nv/9kVhlv+KvzFVcTMDoplzzygsZcsynKe3ss?=
 =?us-ascii?Q?kDonqr0tRSJVYXl1Y1ED4Mapp5RR968N2dklKFnVGbC5fccxqxtHbZcGFXng?=
 =?us-ascii?Q?GkqtyRKc11KzVGxxh7gAvDqLDmQtqGBLxcDAfVhu/dTzfoMu+z8f/U7/XgU3?=
 =?us-ascii?Q?VZ585OVn97kPG7GxVoSluNvNqH68V5lHprHCypSieWRgJlFRJaN9a4wwrUTx?=
 =?us-ascii?Q?AVdqAhjqt+wpqj56bDB/SK0w3jZos3zTsPs/mwg2uur2CpPTpVO9Rz3k8aRu?=
 =?us-ascii?Q?wiDeY62fdzRkZLRW0fzLM/qXg2GjKea1kPnTffbyyALHtcpvlQecw4G0Jqoe?=
 =?us-ascii?Q?Vnb8hBYdAa9jxYTSYKtKorjAQpT+FdUxOhQ1OvtjfDqZ3+xp7rsAmuK5DQ/f?=
 =?us-ascii?Q?wtBki3swnJF6VHaLYhIeMVhkR4ugjuBUTnYEfVfcDrN223LHG5SItHQZItiT?=
 =?us-ascii?Q?m6DB1+YVyju0GnSnBtYrdSn9It8LReNUr4o7IkBwmHZAMnE+kxwdj0ajv4X7?=
 =?us-ascii?Q?sW7HqRnPtHXNtZNRaj/LC4hsy53ASdxwNWAagrYCU6vmdyVjNJYzGUnXtO7o?=
 =?us-ascii?Q?G6ISbyQD7bh58n2a1HiOMqxadu6WBllLIJt+VFVwfj8F9lS++SPi9T2NnlaC?=
 =?us-ascii?Q?w7sZYqVyxRhuPdjqpdaFBPFsaeFP8hX/F62dGyJexh5yznpRXPTJ0GH6P6F9?=
 =?us-ascii?Q?XU0tuCJhHKD8GfNa5dEGkNLwtwN/23odyjQm8vzWmOkGiEgsOMRqtdcer0WH?=
 =?us-ascii?Q?X+VumikFUsFK4YvNRQhLPgVBSOAQwCtRiJX0OJjZtcHVxwVpwOWnF6Wtp4ni?=
 =?us-ascii?Q?Ky3/i+FnBmT63wXibR/NCNBd8P/k07MQn9TB0mblL7scC5DjJNhychiZ3ZB1?=
 =?us-ascii?Q?T8J2T27gArs5ROUrSZOBQ7RiUZ4qmdhzVcanBqaK9BFi3hVXhqMYhcYnGisQ?=
 =?us-ascii?Q?k/OSDdYoFEd3j2scvApLYGcQ7JKHg2DfWNoS9aTrNWfpSrDza6ByC9tNFKd+?=
 =?us-ascii?Q?hmPnmC6oMrhJKD8vaBjYukDpCdUM5e/ZGPh1VpJTz2BVP0g8B3mm9OiqTuMl?=
 =?us-ascii?Q?whm9XDcd3YJ+UKXMgs68uxY8++VTYw12mVo/DaZw3YEfmVQ3Qta5LkJc+GUw?=
 =?us-ascii?Q?+g=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39622226-0726-4323-59ef-08dce9c92e4e
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 07:49:05.5045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ahZuHPJ+ygMQVDOfTq1pZiewLK5y9kaMHcnXD6ZnNj+qB9tpIIyflG2ICMzAjbWmLsxQCbuF07qQz49Zi/NoYkHQTLgA2beDGQH0LNXCQ24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB6922

When IPV6_MROUTE_MULTIPLE_TABLES is enabled, calls to
ip6mr_get_table() must be done under RCU or RTNL lock.

Detected by Lockdep-RCU:

  [   48.834645] WARNING: suspicious RCU usage
  [   48.834647] 6.1.103-584209f6d5-nokia_sm_x86 #1 Tainted: G S         O
  [   48.834649] -----------------------------
  [   48.834651] /net/ipv6/ip6mr.c:132 RCU-list traversed in non-reader section!!
  [   48.834654]
                 other info that might help us debug this:

  [   48.834656]
                 rcu_scheduler_active = 2, debug_locks = 1
  [   48.834658] no locks held by radvd/5777.
  [   48.834660]
                 stack backtrace:
  [   48.834663] CPU: 0 PID: 5777 Comm: radvd Tainted: G S         O       6.1.103-584209f6d5-nokia_sm_x86 #1
  [   48.834666] Hardware name: Nokia Asil/Default string, BIOS 0ACNA113 06/07/2024
  [   48.834673] Call Trace:
  [   48.834674]  <TASK>
  [   48.834677]  dump_stack_lvl+0xb7/0xe9
  [   48.834687]  lockdep_rcu_suspicious.cold+0x2d/0x64
  [   48.834697]  ip6mr_get_table+0x9f/0xb0
  [   48.834704]  ip6mr_ioctl+0x50/0x360
  [   48.834713]  ? sk_ioctl+0x5f/0x1c0
  [   48.834719]  sk_ioctl+0x5f/0x1c0
  [   48.834723]  ? find_held_lock+0x2b/0x80
  [   48.834731]  sock_do_ioctl+0x7b/0x140
  [   48.834737]  ? proc_nr_files+0x30/0x30
  [   48.834744]  sock_ioctl+0x1f5/0x360
  [   48.834754]  __x64_sys_ioctl+0x8d/0xd0
  [   48.834760]  do_syscall_64+0x3c/0x90
  [   48.834765]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
  [   48.834769] RIP: 0033:0x7fda5f56e2ac                                                                   [   48.834773] Code: 1e fa 48 8d 44 24 08 48 89 54 24 e0 48 89 44 24 c0 48 8d 44 24 d0 48 89 44 24 c8 b8 1 0 00 00 00 c7 44 24 b8 10 00 00 00 0f 05 <3d> 00 f0 ff ff 89 c2 77 0b 89 d0 c3 0f 1f 84
  00 00 00 00 00 48 8b
  [   48.834776] RSP: 002b:00007fff52d4bda8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
  [   48.834782] RAX: ffffffffffffffda RBX: 000000000171cd80 RCX: 00007fda5f56e2ac
  [   48.834784] RDX: 00007fff52d4bdb0 RSI: 0000000000008913 RDI: 0000000000000003
  [   48.834787] RBP: 000000000171cd30 R08: 0000000000000007 R09: 000000000000003c
  [   48.834789] R10: 0000000000000004 R11: 0000000000000246 R12: 0000000000000003
  [   48.834791] R13: 0000000000000000 R14: 0000000000000004 R15: 000000000040d43c
  [   48.834802]  </TASK>

Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
Fixes: d1db275dd3f6 ("ipv6: ip6mr: support multiple tables")
---
 net/ipv6/ip6mr.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 268e77196753..b18eb4ad21e4 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1884,18 +1884,23 @@ int ip6mr_ioctl(struct sock *sk, int cmd, void *arg)
 	struct mfc6_cache *c;
 	struct net *net = sock_net(sk);
 	struct mr_table *mrt;
+	int err;
 
+	rcu_read_lock();
 	mrt = ip6mr_get_table(net, raw6_sk(sk)->ip6mr_table ? : RT6_TABLE_DFLT);
-	if (!mrt)
-		return -ENOENT;
+	if (!mrt) {
+		err = -ENOENT;
+		goto out;
+	}
 
 	switch (cmd) {
 	case SIOCGETMIFCNT_IN6:
 		vr = (struct sioc_mif_req6 *)arg;
-		if (vr->mifi >= mrt->maxvif)
-			return -EINVAL;
+		if (vr->mifi >= mrt->maxvif) {
+			err = -EINVAL;
+			goto out;
+		}
 		vr->mifi = array_index_nospec(vr->mifi, mrt->maxvif);
-		rcu_read_lock();
 		vif = &mrt->vif_table[vr->mifi];
 		if (VIF_EXISTS(mrt, vr->mifi)) {
 			vr->icount = READ_ONCE(vif->pkt_in);
@@ -1905,12 +1910,11 @@ int ip6mr_ioctl(struct sock *sk, int cmd, void *arg)
 			rcu_read_unlock();
 			return 0;
 		}
-		rcu_read_unlock();
-		return -EADDRNOTAVAIL;
+		err = -EADDRNOTAVAIL;
+		goto out;
 	case SIOCGETSGCNT_IN6:
 		sr = (struct sioc_sg_req6 *)arg;
 
-		rcu_read_lock();
 		c = ip6mr_cache_find(mrt, &sr->src.sin6_addr,
 				     &sr->grp.sin6_addr);
 		if (c) {
@@ -1920,11 +1924,16 @@ int ip6mr_ioctl(struct sock *sk, int cmd, void *arg)
 			rcu_read_unlock();
 			return 0;
 		}
-		rcu_read_unlock();
-		return -EADDRNOTAVAIL;
+		err = -EADDRNOTAVAIL;
+		goto out;
 	default:
-		return -ENOIOCTLCMD;
+		err = -ENOIOCTLCMD;
+		goto out;
 	}
+
+out:
+	rcu_read_unlock();
+	return err;
 }
 
 #ifdef CONFIG_COMPAT
-- 
2.42.0


