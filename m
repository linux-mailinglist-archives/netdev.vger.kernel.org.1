Return-Path: <netdev+bounces-134128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D062E99820B
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 11:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3C10B25A24
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 09:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63501C233D;
	Thu, 10 Oct 2024 09:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="OVzJilm0"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2055.outbound.protection.outlook.com [40.107.249.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9FE1BD4FD;
	Thu, 10 Oct 2024 09:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728551512; cv=fail; b=orCmSd1+Nyc1f/DJM/ZhbM0x06eEHTpSLY+I6Vapa7hOuAdgHU+tmTLslnwvxcvb2Pe4i0pAINgmsncbB4f3xGFlUjbT35ceGM9e0MJJYArS32NxXqrFAhk8mJ3EgWuLwI1S0Yy8DRL25ZZQou0++8nAdBX/oPaRuv/drzlhBBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728551512; c=relaxed/simple;
	bh=eQHygMMgvNeZSm6NrFOVvJy8TU/mGOXUnY+Pc8gr37I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jb+OWfe9Gl9gyX1LCxFi0XeQoT9VmC14/Hm6R74YyKQ2rEhqEeuSfhPwENWRzKMdGdzqX1BmSuvtxr+kxaZqPTVoE3AXqCu/MbpSbrPtugC20WeCgZ/BbIzwKOlHkhZvg02f31dd8tEqG0ZjjKZj9NfCAF9Xtv70cMN/e7slXwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=OVzJilm0; arc=fail smtp.client-ip=40.107.249.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jqJx6lE+8+YnUZb8nah06pGvoUBNrUbF6MMEl6OC5M6c7UpWHHctyEyJZBqkq1OmezcDCtG4PRTFIZexi7j8c4UgoI0Bwy6jeK8PMAmcm8zRbB5CyFUepbCljHIW9JduKrKyoE9FSyVdqigStRtt6ogTBpUC2EauqP45p/RmBCF/YmbFW0O6YU9BbWJTN598os4wfe0+5mWPPORu82NGLzwuSALfnsX9Mq+G9dk6UjUMbFybyyp7qXgP6wWaeNDdZfeLvxi2uHO7KRp30GyUSMkCnpMZYUx3+g1k1HLzzkc66QRFY2PSOfVfd+AYfgL2/NVwVd9qUNfaMB4otMUoNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0SKoqhpEI4x2dzpIhplvexTJZkBWoERG2IYvfdmjl+U=;
 b=jLiR8Q1czBuNbRjNngLNvGa9yz3nZxBmT7mx6YDBsY9S5CX8GbEPsDumIOe1W4aew7WFdvYlbSx2p1b+57MUuM0WReV1oNNsI7IoLRU3Hccq7zNL3EqcQXQpyfYQuHIxknoMbeL13tKqOJEex+1E6dcUTc5ZizK1cSKxnlGkOiXr/u3GZaKq9Z/WsM+CyblkskUOK6L8k4I4onXh2P9p1LquZ2ju0VW8hYu4JKxK7lAEh0A2A/pfGK53MXT9AHyKTE89hyOf2r6kMjUJDbPoEGv9+/IlT7DQHSKCY1ZXtuwSseYDR2pVjKvWo2D+x6ozTv1ZS9B3d9Lm7XtAZOJwQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0SKoqhpEI4x2dzpIhplvexTJZkBWoERG2IYvfdmjl+U=;
 b=OVzJilm0WeefKGqQn50W1phikXSXhW/7LAbnlsz7mh0HsJdpSUa+MpgUiZ1X+VkEMSda3j+EnQSTLi2a1AIIH+O7YjERkhUyiRubX0Ed7t1pLUEyuYOHDO6E9BmrDHKcEqT5Gcfz4k1lNYSLSzQ1Tv00HLZiR5HalofTaKycPBVOY9g82zxBvRWQcZblEJXT1afcbQKK2eTuN8l5gWNBIbyOwR4t0YV1BwaKhLnhF1qiAt4izCwh/LI/7V1DVWHVanSod6JnYXIoXaoqMjy0JYkuF9uj+eunSVXGXinc+ubIpm6/iPT9U5w3EkEmWFcb44K8MZ39erSfRCOBnlP6UQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by AS4PR07MB9630.eurprd07.prod.outlook.com (2603:10a6:20b:4fb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 09:11:47 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5%4]) with mapi id 15.20.8048.013; Thu, 10 Oct 2024
 09:11:47 +0000
From: Stefan Wiehler <stefan.wiehler@nokia.com>
To: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wiehler <stefan.wiehler@nokia.com>
Subject: [PATCH net v3 2/4] ip6mr: Lock RCU before ip6mr_get_table() call in ip6mr_ioctl()
Date: Thu, 10 Oct 2024 11:07:41 +0200
Message-ID: <20241010090741.1980100-4-stefan.wiehler@nokia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241010090741.1980100-2-stefan.wiehler@nokia.com>
References: <20241010090741.1980100-2-stefan.wiehler@nokia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0242.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::20) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|AS4PR07MB9630:EE_
X-MS-Office365-Filtering-Correlation-Id: 14db0767-6243-4c2a-8bda-08dce90b9143
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n2cKb7cGIv/jjVJ7eYZXfivo1RoLTeJBVzLqkJQtkV10it7gsJUKVmKokz0z?=
 =?us-ascii?Q?l5UgPvqq6vZHMimc0MyHDJLuPelURSY9XlOF06CUKHitI8FrDpWYW9zq9S8P?=
 =?us-ascii?Q?8IpPNHEg64gBV5fQeCeSKms5uO7G2zzHdIoNumVL8+eI6CmzXV9gS6xaSkk6?=
 =?us-ascii?Q?gP9z0kAu6WiG+BiQ+aRKg+zlAJEki9GniOFJx0B1vCh2gYdjreI6st8Z4flb?=
 =?us-ascii?Q?WAKuRQYomzAJfm5ALSz2fhPLyHlCsjsUIM+le4t3Swj+OiKsIv6JfzM6AAB5?=
 =?us-ascii?Q?VihnVy5Lk9DpyRqz/yTkqvdkk8ps//7Tz6RF8/B5HJg4ae2Q9JaYBJJ36ESf?=
 =?us-ascii?Q?3KFR1FKdb/87aS/ayhlufuAxNtp7ukj9kxX9i/aVGB0KYGomzT5Aqmt/nh+z?=
 =?us-ascii?Q?S56tyb0Jx4PHu5lI+/tdPVwhMyNb0z8Q+JEPW1KYWkIZZfmQQmvuaNTDLWFd?=
 =?us-ascii?Q?7jgdnJTRDUcD3oCVtsi6jcjH+KtxaatxJu1skw19s9GvlNvoo339RQLA0JIQ?=
 =?us-ascii?Q?yXeD2pC/DhN+M7UnqLfhUEqDXfwF8jdaEU/5F64hyyErditq6lFD7BU9mHoc?=
 =?us-ascii?Q?pB4ecHsrxnDj8krL+D7HHfbVSIdpL16nOQRBlF31MmIxfioRezdoo1JSbi/1?=
 =?us-ascii?Q?589uCCP1eO27om7sK96Oi4Jwyhr4vF4xmHwNoIQRiWAtpoq2dyQCadfIeIVr?=
 =?us-ascii?Q?Z9Rpf7RarANM3B77cAj2ZmS/ojAKuWNl97gQUBeSplaHftwDpCR0erv088uz?=
 =?us-ascii?Q?W2FAd1bE0WvRZ912i5i4YudoZhzVCDf0ypp/YFWCgDRWZ4Z/ktj4Kq2xwKwE?=
 =?us-ascii?Q?HxnFxe/98CfSnc4oejOu10g+gSwC40b25MWOpYfRoNiSFsm1zitXW51h0VoA?=
 =?us-ascii?Q?piZtuZiTngttH0CNE7mlYZ7fd04Rlzh5WpNA25axLdUYkBVEYhIAfMAOHS0I?=
 =?us-ascii?Q?iFlDeh5Kkkdbnec4IDaOvilRP9VSXXspRD9M3DV/iZoULqBmvrq9g0O7bY6g?=
 =?us-ascii?Q?FPKjRfZewE7IsUQQ5fqdBk+wmb3lPMOsGCR1bp6Ke8N93+t4OcwIOjt0o4fx?=
 =?us-ascii?Q?QEaAGVX+yYruVprgyVSvKiAO8jhUG63ABf9lmwmwMgA+8RYk5Q11xD3uGZ/6?=
 =?us-ascii?Q?JpG/w0s06IEZUWfoEUbt+A0ZlpXLU1aJ+TzS7SrVkycii0Ce5wiXk1kXBVZ6?=
 =?us-ascii?Q?j0L/4eIuJslggxVcivgoqAcPvjNpRrTgLrQ/ZT3mXimEMGA6+v4n9Cv71sx/?=
 =?us-ascii?Q?GcV5c24G0ZAW8aYbi0Y0yUvjyttw1Bsa7Y6uL9UeaSUS5JeMjN/uFWzYhIoF?=
 =?us-ascii?Q?u889coDTsCzF98lhGmqNE7nPvmmvSVHIISL1Nda6RVCeOQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I+PzBmuDEmhgOqbIIOvdje5QGMcFEB+Pn7khKRe93EdZc9R9SS+myL2ecK3S?=
 =?us-ascii?Q?U60oqQIos2OZZT82ejgYQDVAhi2DrGt9wv/6EvjDHcjPI5irMZa3ghBphXNM?=
 =?us-ascii?Q?4GmAFOwCDbWt4SZHPnLKRxavKN9qlBPBQJG5gVC5QaFNru4astSm4HgsVOVa?=
 =?us-ascii?Q?Xl1m4lb4UEQuOGXGL5iyyV6WCIK1FWT8f9SSjH5d6NXohSdOH6IZb7sUSMwW?=
 =?us-ascii?Q?sdc2YuvO5MWQeFjeJGvzu0BZ3DbKg2hVnqxMd4wVf/T9JXgZcBeB4UvcUqO7?=
 =?us-ascii?Q?HpwViy5Zw0CqUIN/ZB/MaI8xB7ttABy1W0cLbED1j3A5JQiWN2Cj4+DxOylM?=
 =?us-ascii?Q?rYMOd/3zVYFBwRDQ/45/4aT3SH8I3rP1VpPatRNYV40JBWaeNp+DEAOelYBE?=
 =?us-ascii?Q?1rK+kItQ69Jfs+mTKAT5ACb3aTZ+eL4pafqCm4Wsd0YM4vTdUPYLnGZsdoQx?=
 =?us-ascii?Q?mCe5wi37k4MgEaFZ0Iu1O8ky49XNgyu0qc9mdgrmkVqpJcGK1SouepWzDVTB?=
 =?us-ascii?Q?u7JKXpS42aMkZO5gLGnlwKXywZiD261WNHnNxoAkLlqM9BgPm5ZwAJbdlQ6c?=
 =?us-ascii?Q?dc8GFvSQKYJunWftsxzKKYcrtFqNlMHORFyoBK1uVVirJ/YxAqmKqXTjEBxD?=
 =?us-ascii?Q?QNQLiypsB40HplW8oNFUAJmTsKttVVE+hBTL9lGrSxtmqXJ1SvNbHQp85v1q?=
 =?us-ascii?Q?ycoOOUJuPRnxVymkOFQxGMDVi61vZOGM6kRjfRxfPcGca5DXE3KI+fbOVBh8?=
 =?us-ascii?Q?N9y/XN0pGJbnwS21E0LnkHGr3feNLj1SNlokcLYRQ0mwDEWyT6kPPQKxMcZU?=
 =?us-ascii?Q?AFfMgndFW33cesHeoI7IEGHwUUCBK76k6gQMhXkWJRq3q8UHiPkjrcqwfN6R?=
 =?us-ascii?Q?BKeF2aYunDKkR0YDLW8uQlbIoIAnWDpbStqzAHzT4edFMoGkZhDVF4GJspya?=
 =?us-ascii?Q?MD04+/w0Gn2FMMfiLiMAnf/VHOjAJnLX1d3YURALEnXr4oGGiF8cS1Y0KnIE?=
 =?us-ascii?Q?zlQm1yc8o4yRARM3ZK3v1PL4VK2u0aL8sr9YtHT//EqVgHRslhQ+l40rv67G?=
 =?us-ascii?Q?pfNz3K/c4ICkT5uPeqOeTQVmO7up+kxRNN3PS3czSNx6qpGMrb5CqDxI/Ty3?=
 =?us-ascii?Q?bdflF26+JzQFVD9dDjOdhLdl8FHdwNMgez8KwJbHvx5NNO6n+4ssASWifgkB?=
 =?us-ascii?Q?F2BMkz7tUGEpsbYrC2JQR8KcUK4Ox4ibVxtYQ5ifGQ5vOpSKj1LQMJuBtXan?=
 =?us-ascii?Q?qGwHGUmxGkl6v++xosXjZS4+RSYO5uN6ABPvn2rLU4yE09fkOiBocpIUEzQc?=
 =?us-ascii?Q?mLaxlUzOUH3DNIbGNlMbfPKy6k+gzPOALlrgvky5AlxhRD6WI9PJiiFNA+WI?=
 =?us-ascii?Q?w1Jvry3Pxffx9Bd7WJocL64kXSpwZGLiFjUjWhTCRPh02RGhvwIp+HhGiWws?=
 =?us-ascii?Q?mTmsKTmVWZ6rYOOwuI3fmgzn1Jce5ZaVT8qGw7Ydl9C2z9Z407eGW9c7RbCm?=
 =?us-ascii?Q?q0FqdFj9ootT7r2301FTqKsHFEoD5nYGEUS7bIiVa2sYjxnI2yRJUrKgKzly?=
 =?us-ascii?Q?jV9Pyhx8B04z1ovwieejok47m8cWHL0i1If1qNb+qKQ2TtpSJUV4M4PTez/U?=
 =?us-ascii?Q?vA=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14db0767-6243-4c2a-8bda-08dce90b9143
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 09:11:47.1573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lp9OvwEjp0Dfz25FFOQeRqyrQwsLcQji9iNqNKz1cqYwr+4FGjlYxGameNKRXE+chzHLod12sSQ0U7QcMQlvCdfcu0msYv+mzjTH6JGqNSc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR07MB9630

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
v3:
  - split into separate patches
v2: https://patchwork.kernel.org/project/netdevbpf/patch/20241001100119.230711-2-stefan.wiehler@nokia.com/
  - rebase on top of net tree
  - add Fixes tag
  - refactor out paths
v1: https://patchwork.kernel.org/project/netdevbpf/patch/20240605195355.363936-1-oss@malat.biz/
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


