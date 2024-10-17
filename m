Return-Path: <netdev+bounces-136699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C79DB9A2B32
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 19:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 846C0284133
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 17:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA011DFE10;
	Thu, 17 Oct 2024 17:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="bqtlc4nb"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2059.outbound.protection.outlook.com [40.107.247.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793651DFDB9;
	Thu, 17 Oct 2024 17:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729186905; cv=fail; b=hRvyk7HeVqUVTBHbksXeTbK8Ac+V87dF/JIRTPZGE04Kl7aJhxabKOG+PoMHE4Ky5ROpEssnS+Nqiyvfw06CCcN6Kw1bwoTdGzFr/bCqDsjQFZPpvB0F4l34yIBvNxfeZdiVvNcVBM0E2z2pThyhD2zaZFY8il9pVgGsXFTDs6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729186905; c=relaxed/simple;
	bh=Vwm1clT8MbVtl1RR/I5biF2mSzJHxssILe0ir1j4R+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Yvq4+T3sfTgW8LDz7QXtiMmg+c0QLmYl7XoLtO424x2eEV4KpZSH2hp0USYEzLmBaMV1LTXSeF9nqKiO/ynDUShAE9bnJVOidNkO3r2v7OYrvsAemk4e4fjNbBBzvB8K4kVdS3YUAQI3nSHvSjDtKaj0cP3PBbRotpYP5lQzz4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=bqtlc4nb; arc=fail smtp.client-ip=40.107.247.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zCq6Fbr0Gpr1lJsSpSccSkDNz6507aPef8H3pXspXoR6MAsCFW1bAWZKL4lJ9BcLlHMUOlrGJbmLSKbgTwiWKcGSWZVWKPGnjVUE0M5CkfzLkiupseQzu2A6ivtMrYgotutrkSLfFU/22ZsEjBA5VcYcfgBU8/8gB6CFWEEOQiLLLIrRTGqI7eZ6hp49Dmqj+eH4R+vePfeJKxHe1rMDUwBWtHAVMf6TT0EwfwNCm92wwnSlGoNR0/ALmvibHDG9ivsF4YnKq2ncXQHXf/d+JvCiFDLkElFRCM0NLNFNwllO6b68LL+mCJh/nfnDkDfB9sYHqPP7RW9pybID7Pvs3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0EvfKTMW8khsbijqZ9ycptxtJwZKAm/46ouiPwqDH2U=;
 b=UiMRXGdDDJeDGCtnWM0+opjJ5mOIPjHcHFORNECPt7txc18/ITwTyEJMuBq6eaoyHZtPARM7W61sM85DlAmKGDcU9B5nhlHtxpYRMKi3+E0T6AbrFa7v47OMrZ4vSqzHDLhH2TZNiFC/ngtoow4g65QggHirppi0bW5NtCkRGS3EzJO6vlbagIX2K8KmfjR3BCLbksRTnWg2E+PmETtIYoDkU6adzelAOpW5/rZFUb6PbUZ4w/hpwziw5VmA3fSyJVHXi6d2SFIvuVzDuRJh++aWf8GWg2jmGCy/8oRSRLlu8JJhm889bx/mxQCAMRkRfRwh2BlSJDD7GIKSSAndow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0EvfKTMW8khsbijqZ9ycptxtJwZKAm/46ouiPwqDH2U=;
 b=bqtlc4nbAUm8SI+WZ+BZ1To9UJG8WCdxQufzsM488Gtf7u3OCc0dUcm4wtyIzGbmsYwxssqMQ5M1A2OTtp5ZbYf8T/xUyVhIw6STUa1PXeKCmeJbVD6KD71F5J+tdWp7UGy+Y5j8DoEf3QSlxzUC1+dtPh2xtZaC1L7FcjUjZcqyH4WxMhidf81u8PVpVUa6I9sbQJSIpGY6+jUuMAGbC9VpPhRPjaS0sVoKakl8hfngXxL5egSoH5QPKABkLfrcMXbWF9Ow2da6prZ2Ywdjdv/whJPDe6+90JnG6cpAzGr5y+iP1thwpDcW91Zy99DB2hukQZY73JK6nzRsGC0Esw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by GV2PR07MB9009.eurprd07.prod.outlook.com (2603:10a6:150:b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Thu, 17 Oct
 2024 17:41:38 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5%4]) with mapi id 15.20.8069.018; Thu, 17 Oct 2024
 17:41:38 +0000
From: Stefan Wiehler <stefan.wiehler@nokia.com>
To: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wiehler <stefan.wiehler@nokia.com>
Subject: [PATCH net v6 00/10] Lock RCU before calling ip6mr_get_table()
Date: Thu, 17 Oct 2024 19:37:42 +0200
Message-ID: <20241017174109.85717-1-stefan.wiehler@nokia.com>
X-Mailer: git-send-email 2.42.0
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
X-MS-Office365-Filtering-Correlation-Id: ba1e8bd2-81fc-4147-1525-08dceed2f3b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LR1D0+tM68XtvrYsEOznBBLbUT1JQ3ZLh5Rvh0zHbHVQsRKYv76DExRe7+Q1?=
 =?us-ascii?Q?kJHrtGluor1/t2pFjMtt2K6jXNnVDeAd2cdVva+u2ao98XbgyHEiGCmDxSUV?=
 =?us-ascii?Q?QVckgiU1gxCS/mQ3qaTl2O6clSKWRTsnqXbQ+3VTsE38uFsb824oikKq1evQ?=
 =?us-ascii?Q?troFqZPRxRnip5HpPoy7a7dkdo0EHyZ1YoLx/pLyskCRRVlWA7Li/fSzB+Es?=
 =?us-ascii?Q?uHxkYI//UJHv5JjgVwtasGxs11rK49sSRUlWA02HHtbSsb1obOUvk5NXITYU?=
 =?us-ascii?Q?PED4i2SdaSeeqg8FAPI6Bfyb8ZUQYJsanIj51+bGjclAL5eJz0m89U2oko3m?=
 =?us-ascii?Q?Y/Nea8YEEEqPTIYd7dA53YVNR9AowNcaEGGvaFPa9Y4Nn0xy/DaoZwI5yrcJ?=
 =?us-ascii?Q?JJBCy9IPEnrOIdtJeIEEh7cu9oO5hmn7SurLYcUmfhi+xgz6QY6mWiFcPcQ5?=
 =?us-ascii?Q?7Die+Eh7QjW9II6qSlrTkIt8ESF6tAmu/v2C2ejAR2mC8RfdyPg62ipbQk/f?=
 =?us-ascii?Q?qEYdTTJhYYSKbYoVFTwgiVE+kHRpeoKJjrMy1iaB0x1Ic5k9abjuBbx2vSLo?=
 =?us-ascii?Q?ja6j+HKUZp0qKe7Lz67xmkzeLaiVzEZy9/fDdzQHis0E50pzs6pHhFE3a4zW?=
 =?us-ascii?Q?5T+TQYIgP5A19/UcDIJbzduxKXz5s5I+IufPEyUuTVWsupy+cWo9MysvvUDK?=
 =?us-ascii?Q?C8KdePBLck8qCdPgKZxDC/GyKX9gbxFoQm2SNST/wP6xuGPDIHgoyRLZTpgV?=
 =?us-ascii?Q?/mHU72XgB64lzSeGGIF2yuGRA9kCVbe+WO0dCVxzcACfg+HY75rbY4k43S3P?=
 =?us-ascii?Q?77BT+Ps6myJKggrp0pMc+oQv3bfm21YTMNQvzZl+uOSwjwyYvfFvcrUtGVO0?=
 =?us-ascii?Q?jEPaihKs9Tyj+PUitq28ZHeK1PpiAin5Nuta3f81V5gTYRhJeNfmoo7DOWAo?=
 =?us-ascii?Q?vxvEhja6xcEqC2ieeeFsX+sEAglsFJ4goWIaApQdU76PckidDblgc7jnWEQe?=
 =?us-ascii?Q?ZMv6PN11lbaPVZGnKSNGHG+sZLkfU6w5Abz4h0mF00MaN9DoljGfgxyMcWWP?=
 =?us-ascii?Q?KHWtV/cFdFDjKYV+N2grrJFYkZ8j32rKCDrWuyUhoKO5OLvVtlLsQekT/gdm?=
 =?us-ascii?Q?bRO5SUdVDIl3pIcPPvci2tJyqPG7KWV/RvFLpqyayYF921ZNC7ANEa7tFk1f?=
 =?us-ascii?Q?q0plHS3u4oPScRLZrwwgrDscNuTZESZ1nH9QJYlY6d2DW82mSoJ3LSQzqSIN?=
 =?us-ascii?Q?r623y6qsxd5A53pvHKg93MpEy6Ms9WrwY9MUHLv3spehpZqQbeIFP56yASMF?=
 =?us-ascii?Q?A1ep0F1A+43GKZU6G1w2ZqlZ678cU0uTmUPbK9iBmEua5QBzpPbmoKiDC/Bq?=
 =?us-ascii?Q?XsaJhXo29NMD4wQ4td5kz/sPQhMc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NK2NHq+4lYyRRNq6h+6siBMLIEiGWvpfOZk/uYGUA1wVSQUjevUU972G885L?=
 =?us-ascii?Q?DTO0ekDIMPtN/8NZviPdRjifkewZNxew5oCTFNyGiZ5pCY+Rs2TBgDzudWEB?=
 =?us-ascii?Q?3DqLVSlQhIieILESuWQuy8ycfsrB/bmpo6BPIq+Y8hxthGP69Kd+d2OPjhme?=
 =?us-ascii?Q?pkPr8kOTd+PS+Gcd9VUXZvm2wFEL348gxl/VJMZqwQG6ACmCZlpix8cL+6P1?=
 =?us-ascii?Q?S2IRSotlFVtaVFf8GbLWuRObyCzFQBRoU4PwcOAMmVGFuVWJkQMILucnEFqu?=
 =?us-ascii?Q?PGhzUYDY4Pg+lk+PS5xKOwDT9fGhWVKa8xYVtJbjYx+s/qCBBoNyw4pKapTg?=
 =?us-ascii?Q?PiBRd0H13OWU5rBsjIAYc2+qFtKiI2E+WXHoR1OD3Eu4004c+aIagpL5MojT?=
 =?us-ascii?Q?Ndk/ejfYtQ21Mv1j1dBJly6xCFGKnJgxibOfa4HIXZR78mnb2FILVHC64NUK?=
 =?us-ascii?Q?rD0EQUPlPqzN+nRxIMz22Yc9a2KjgoKhIrMLaq/ngT9bYzvyCu200sI/21vn?=
 =?us-ascii?Q?9bBfxDYcdqX7Jjoo3F+iROV2YhRKZaXscJN8jY5uWT+lsaFdvQJaonR21/BV?=
 =?us-ascii?Q?q9lsHF2o0qiQHbIDRv8b4yzGYVCIrTO3ZPHVIwCQZTgKdTfnP+hNHFI163ms?=
 =?us-ascii?Q?pOzqiAoRvbJzk/Jx0NZJXMLz+ed2vI7eQt6tFjvTE7OdhEnkW7XI+g9jRjpT?=
 =?us-ascii?Q?QQ56lye7npvsu27xku4J1PVbO3Ph7DmGUUs7xCb84QkctOjADSg32iXEykbj?=
 =?us-ascii?Q?ZYDFMU3UJP/6gL0VceiJ+IufcIj8ri2pThvxfE5pa0G/cn7mMSK7h8OUZzEc?=
 =?us-ascii?Q?jPWTLbEcaNuETID6OBMfFJz6UxyQZ8XdU70DfF2Li6ammslvWX1B1jsLSk4o?=
 =?us-ascii?Q?CgoexnvaYZUVLTjrmINHpYmISF3naLJQaGYjGgcmHy7v1TlAiOYkcNCZu2tz?=
 =?us-ascii?Q?hZE0b+g21Xeie6RZryi0GBYo93ZDzsZ/1wowdgRA/tAsOV7BjT5+vyOhyGfh?=
 =?us-ascii?Q?DPp2Djxp+CcXtzc4QXE1sVaL6FHVIHGsnbdd4oEbizv25AxNHFTlxAxynA0N?=
 =?us-ascii?Q?ulMXlNjzNr72pGd6IUVU/ddBqhV04zun2J/PvNh+YtgyTwi6PQcKzhGY3Chv?=
 =?us-ascii?Q?j7Rq7u8tm2eUVQAXfUnfwZBFdvTLdbFUuMUP3G6Rt6pmOZXP3aceNGAf/2M6?=
 =?us-ascii?Q?Jbmp9qYB9UM4gb7ggJWjloVMem0EuVpJ+8vsuusXPJR6CZ0BU+EsRJ2in2VK?=
 =?us-ascii?Q?H0HayHRojBivf/1kWWREIlRvCZFccwDbNeGsIjHYKLbdtaIFH/C7xA/xjXPv?=
 =?us-ascii?Q?4lvJp80VXIYVSxUhKFOQ7vnMr2A8gycw4osC31k7yvLEG6BM+EuvU11sa2n4?=
 =?us-ascii?Q?n5xDuHhk+ytmEI2ijHkpCd1zhmQCMkpcF0MN2aXCFyI3vQjWQOU2/k4+2w1O?=
 =?us-ascii?Q?k8mO+ua/fg4fQdlka4c/Wg75TPE7LaQb+IpwMmFo0tCmlKLKBr0IAAW4nt79?=
 =?us-ascii?Q?WVPNzPVw5I8ePchnDRDUHmF603VlCTa81zZyD0M1AoGyv1NHdJGe9EQ8G2kh?=
 =?us-ascii?Q?BL+GDqIE55gKO2DMO3pyEDvq/8f8MOqLNC9LWTCdVmE+X04FSYMZwxmZxJOJ?=
 =?us-ascii?Q?EQ=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba1e8bd2-81fc-4147-1525-08dceed2f3b3
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 17:41:37.9938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M4FXG9todmjN+yZDDLGpHhdYxNsKhLaVHYXOx2DujJc64d1jp/mavXZRtjpRM+kVILRNwWKIBRlqOCP9tBooH0MDSEtNC4WVWuCN2uTYvbk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR07MB9009

When IPV6_MROUTE_MULTIPLE_TABLES is enabled, calls to ip6mr_get_table()
must be done under RCU lock, except:
- call in ip6mr_rule_action is safe because fib_rules_lookup() holds RCU
  lock
- call in ip6mr_rtm_dumproute() is safe because rtnl_register_internal()
  holds the RTNL lock

Detected by Lockdep-RCU in the following two scenarios:

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
                  ...
  [   48.834802]  </TASK>

v6:
  - hold RCU/RTNL lock for the complete duration multicast routing
    tables are in use
  - fix duplicate newline
v5: https://patchwork.kernel.org/project/netdevbpf/cover/20241014151247.1902637-1-stefan.wiehler@nokia.com/
  - add missing RCU locks in ip6mr_new_table(), ip6mr_mfc_seq_start(),
    ip6_mroute_setsockopt(), ip6_mroute_getsockopt() and
    ip6mr_rtm_getroute()
  - fix double RCU unlock in ip6mr_compat_ioctl()
  - always jump to out label in ip6mr_ioctl()
v4: https://patchwork.kernel.org/project/netdevbpf/cover/20241011074811.2308043-3-stefan.wiehler@nokia.com/
  - mention in commit message that ip6mr_vif_seq_stop() would be called
    in case ip6mr_vif_seq_start() returns an error
  - fix unitialised use of mrt variable
  - revert commit b6dd5acde3f1 ("ipv6: Fix suspicious RCU usage warning
    in ip6mr")
v3: https://patchwork.kernel.org/project/netdevbpf/patch/20241010090741.1980100-2-stefan.wiehler@nokia.com/
  - split into separate patches
v2: https://patchwork.kernel.org/project/netdevbpf/patch/20241001100119.230711-2-stefan.wiehler@nokia.com/
  - rebase on top of net tree
  - add Fixes tag
  - refactor out paths
v1: https://patchwork.kernel.org/project/netdevbpf/patch/20240605195355.363936-1-oss@malat.biz/

Stefan Wiehler (10):
  ip6mr: Lock RCU before ip6mr_get_table() call in ip6mr_vif_seq_start()
  ip6mr: Lock RCU before ip6mr_get_table() call in ip6mr_ioctl()
  ip6mr: Lock RCU before ip6mr_get_table() call in ip6mr_compat_ioctl()
  ip6mr: Lock RCU before ip6mr_get_table() call in ip6mr_get_route()
  ip6mr: Lock RTNL before ip6mr_new_table() call in ip6mr_rules_init()
  ip6mr: Lock RCU before ip6mr_get_table() call in ip6mr_mfc_seq_start()
  ip6mr: Lock RCU before ip6mr_get_table() call in
    ip6_mroute_setsockopt()
  ip6mr: Lock RCU before ip6mr_get_table() call in
    ip6_mroute_getsockopt()
  ip6mr: Lock RCU before ip6mr_get_table() call in ip6mr_rtm_getroute()
  Revert "ipv6: Fix suspicious RCU usage warning in ip6mr"

 net/ipv6/ip6mr.c | 309 +++++++++++++++++++++++++++++------------------
 1 file changed, 190 insertions(+), 119 deletions(-)

-- 
2.42.0


