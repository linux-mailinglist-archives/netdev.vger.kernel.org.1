Return-Path: <netdev+bounces-136701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FEC9A2B36
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 19:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 106401F23463
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 17:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0391DFDA8;
	Thu, 17 Oct 2024 17:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="eZWdhm4H"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2077.outbound.protection.outlook.com [40.107.241.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8CA1DFE37;
	Thu, 17 Oct 2024 17:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729186927; cv=fail; b=lintn2jArGfYZeTpdKmzD10CPsBnUml4hBc6JyiUuYCkCa838kwPZngX/HO4idIiui5bwrxyeMroSuTZSJqx4mLNIGRKu7lbu5Cdiuwxvhis9BmbPHLuj+jG2/+qWaOEd453yrqoYov4G0kaom6O1O8UvEoOHFfwqFWZI6fxvEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729186927; c=relaxed/simple;
	bh=aG+3kbS0jDIXIc/fN7GNIJUny4PT6JMFy5HR6UVeoVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N0yEc8O+KDh1caEj5hQ5RpyZPvwy1+4P7n0GD4lLzVJ6w6nOvM3HolIO/IO9G8jeguNsAjLvvJQS/8UT74nILy6HDq6nip2Lj2uUOUEfQ1NNzVgjnRBHEsMtOL505MkQSsR1oISfixyseNHdEblIhTRyYHFOZnfzFlbbLJTzvyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=eZWdhm4H; arc=fail smtp.client-ip=40.107.241.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ecax/3+hNu8WDjdZt685KvWvUonL7Gdf3pvw51N3gaTwVwxPJylRnvb454thneMVObjJFkUYXfcgAJ1i5t7q06s2U8AiNlTXRli37zdWS01oFoR8/ekWak1e/k9SwM/SLmMPm2ViBEA3ajyH5Ey+7G/hNCQUaZWK4wscag9+xtCH8sML5oU/qrbog/vNKpREQDGyMVQuvOF6cOY79k9DyQedU2yORe0sox3WPHtroGCPEQWRLEDd6cL7ByzcfY5UrYo+NKSQU/Hjf4JNySq3WeL9cvkUnfd15WnBjl4Y0A985wM6PoquomipaMQMnlZFKOLbN4R7cATqL48b6rGjQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=czG4YTN92i2Zf0PpFjrqIaKBLv1DFfD2T6PPvoJU8kk=;
 b=vnIX87Nh6WNJEQGd2Ns5c5jjYySNXO6+zQSRt9P+N5CqDDoAM5gHrm3ZRpwn9tZgkfJr55ow5iCcfakLU377hk5t8F/GFhBypQWIkb07JoQm/HiPUbI/g8EpcOMx9ROjK9AIT1MZMzR2bFnqyCwJML3JYh7qBTPaI+pFSIT4Ou3Gf/ex3fXvkbsJr0bruEuTHww1K21ikSezb/da1rhdob9UfV8m+90ICw42xgIerWmiCVYmbSsR7GnvyY6m41HvZ6/nywQA4KFlVdZYyLbGYgMteCEOtfflIWxakj9ltA+r7L5dd6ZmA2dybbFOCcc2rkWN4nUWD6YuwvJvAaIeUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czG4YTN92i2Zf0PpFjrqIaKBLv1DFfD2T6PPvoJU8kk=;
 b=eZWdhm4H/u+0LqnsIeLcpwoJxIMvDvyAT+yzxsyyWJ7iE3Pr7K73onsLQ/TXn17bdOney4yBi8kkaPXQc1PqjlrL1PDq+gvioNhm6t3l0jhoPsFWbaWsaYB/3hFnc3+nlnm79fYTzOZGxZHTe7zzNy9MG9abB9rB3KfCfp42oCmqwWvYsLQ5idtLVb9hM0Y/hm+gKrRBURZb2EhlKUoSokjcUaxtRxH+sexs9jKbD2ZfRr4D4j8v3AfEI9UpK6UlkVkmDUcFOUT71BqyvGa/7LoFkIuW1sRepszhFzy/xLUrdRGaMUNWjINZHWj26Z++whf8rR8sCMv+P+r5rgECsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by GV2PR07MB9009.eurprd07.prod.outlook.com (2603:10a6:150:b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Thu, 17 Oct
 2024 17:41:53 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5%4]) with mapi id 15.20.8069.018; Thu, 17 Oct 2024
 17:41:53 +0000
From: Stefan Wiehler <stefan.wiehler@nokia.com>
To: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wiehler <stefan.wiehler@nokia.com>
Subject: [PATCH net v6 02/10] ip6mr: Lock RCU before ip6mr_get_table() call in ip6mr_ioctl()
Date: Thu, 17 Oct 2024 19:37:44 +0200
Message-ID: <20241017174109.85717-3-stefan.wiehler@nokia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 79c09f41-febf-4a29-8220-08dceed2f64e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Jn2gm2cdONILml6tQgKqQon1mDi1dLDEj9HkFr2CIqlMZZfSbzaJb5dWF1IW?=
 =?us-ascii?Q?LVepx/oZYucD2WHcxtrNm1ZC04/XY/Fha/Ytq+9F5ZO62zwr5ElcdAm12bF0?=
 =?us-ascii?Q?rF3MMX5Ut8TAKKFg9adjzrY7CWDt+GddJwGYJxczC+flpNUSa7hGJ/jp4spr?=
 =?us-ascii?Q?+r8oZuAKsCDTkfeAp71taHHxg0yxnrG1Ovp1Zy4Uhyt4+F8o1T20Kcio1OAi?=
 =?us-ascii?Q?vgbkEsRpshClXIGyN42lhoXgTv//1QT+nx95tqDKvb9BT+dAIBkylUy/qJls?=
 =?us-ascii?Q?/BboHeRYpVzONsKWlKzwmWZyeCobKVB3sK0wlbX+L1d/Ii6D5jgai5DwDf8c?=
 =?us-ascii?Q?dt8xYmR8XXQ2Exms+xBZ0dfqfvhmQ+D3RqNLZ4Nfu/8ZR3q8o9+TTcl4QPph?=
 =?us-ascii?Q?M6xxwdrelXQVcJb4rQYv4TWkoHIiMaeevzeIBVTEM/NG87lamOjT2r+xM5HB?=
 =?us-ascii?Q?nj/LMbeTBPpP2PauEJ6m4PN80iTcC81PbCrZDmjxbqDsJPe0aZu1Eg0KV/I3?=
 =?us-ascii?Q?bnVPVskR6FaJu2InRTaJXd+6Ij44GYW4sky8by/acvUPT2t4iGmjTTTsYaNk?=
 =?us-ascii?Q?ybAtRphvEECOFnBLl4jEbCgTokduGK6gxwt74oWPGNYaqHo1D+DLrzLBgB3o?=
 =?us-ascii?Q?lr+PEC5JPbESSGOoCFdUGSV8o5pTtxtAFVIbgBpq6xPUc8YTwoCXr/LgQEmD?=
 =?us-ascii?Q?GRzJnfCxoWiVAXaklilI9u9/0w9TSkI9EJMrZBjYsz8gMjWbXzzdXbK22Z2l?=
 =?us-ascii?Q?+TivzN6egQOsUN252+Xf3Ha+XAO4KJVI8H7r7y9TyzqFiG+VZLjAhT2NHC7I?=
 =?us-ascii?Q?ga2bwv/76m/LizuVtuVK313PYJTM2mI0i8X9/jCvwOZEgnPW5YDfYMBcsBpx?=
 =?us-ascii?Q?AF/gSpBQKONpnRfbIq2a2R71odf8dz62RvdtIRZcnQTJ0jEJ3Ei7CbmgTphB?=
 =?us-ascii?Q?gBk/KNlQHK8kNicEBLf7xdq4Lr0PPt1sylawM8cZdYo28wjVcqKjkI5RVICH?=
 =?us-ascii?Q?J9cHknldzikyo+wNwWM1j55D56dtQVcqwojxNvmiMncqxp8REeC0qavO/4n5?=
 =?us-ascii?Q?GORN2Y0iSdTeF3RpLdUhrC8/z/Ux0ZVH1btSZDPKGL8lMB8gvXm0P/aJ+wuI?=
 =?us-ascii?Q?glW0BNieC2yFyTLGIBDe6H0qEQcDd1d7kWCON2P7lrGTrEW7IRknXk6skxGY?=
 =?us-ascii?Q?Ucfnn87lTO9+aS5R34eRcENO/emT92yQGgu6rkiQlaz1g/VMljU4imwOZxSw?=
 =?us-ascii?Q?wMWPH5FnNKXWQSbwjSgnYYeoOh/51pblUI2UVM1P8ZEum+D5x/ztbO5Z9Ere?=
 =?us-ascii?Q?fTmFnMMcDmoZlVksgPS+c+DzgUYzbuJkftWQX991JJkcr0xAXWM2gCd7A0U+?=
 =?us-ascii?Q?LUPiNy0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r0SGaYCcVD5CLssolMMFozWhqpr3IQaXh8qFJZnpibBKIA+MAItkR43Zobi6?=
 =?us-ascii?Q?OP9g/MoAo0y5JG39tRYCENCWPUzj4PMq5CAK0UvbViEE+WAiAOdwI8zHob2a?=
 =?us-ascii?Q?t1jJpseXDOq8zJSJX19lqqp4EepXkFskkY7h+oB6mZ9VGnDdDUqFTZyscVi0?=
 =?us-ascii?Q?yRXIzLw3PYnsnMNtWBio+/GgW6HIMuxku18Oe6AFi+GICjgvY9F7E1WjIwCG?=
 =?us-ascii?Q?qaQBP+8AwcxsPKlxfzvrAXaojbGYG9uVLX+UPEIyRzkD1M50U+zOwHJBzM+o?=
 =?us-ascii?Q?crzHIqDW1FUF6/ODj0RTXNbeK5epik77tNy4D1BEPnffqIhuMPgyRYZyDoGg?=
 =?us-ascii?Q?Xdq7cqdPGpppOa+JugeOqCDOcT/qFfi0p+kV8O/BevOoxpNsuNZOrvs23APe?=
 =?us-ascii?Q?fEU29KzAaKcG8sUtxHju5Q1nxpv07iYYRBtLuWz+YmHZMdRhXyFAcY3+MWwF?=
 =?us-ascii?Q?RQXphjAierdknlSiNp9A6Ag1FDtW6HV7+ye4IfBYtOVU91ASFdbdWG3kEE7z?=
 =?us-ascii?Q?BrKLmhKh/5rnK6oc6kjVgsYiVE8qRif59txQXrDhNbVFBggxm2RfEBmnGDpG?=
 =?us-ascii?Q?4TnqXm2Kl1tYuSa1AH4gtwMUhGAGjSyAsro2nfHj+Qtz7wNDWzMDVHFrSB+V?=
 =?us-ascii?Q?qq8Lz6ByflJByjXii8kU3jJ2Y1vepVc9O/+KAHHafIS+UPZOwvLavWvN2oNC?=
 =?us-ascii?Q?rGK0iPmT4sT3Tysa4eQ3IeP3ldwcFsERs7r7O4NP5oOXVXDaV7bdasIW7Ibh?=
 =?us-ascii?Q?cUbIGw1tFnPzMSmtHeAM2Py44a5sSqOjvbyzdJGLbNCjUTUFj5a+mm3uJVYZ?=
 =?us-ascii?Q?NWOpnDcmwvoGXov+2b4g+zlNmkNSAZreWxDYki61BCJPNzE+p4O+tksdw+9d?=
 =?us-ascii?Q?s0U2cnE6d/SCjCL259V3838lUerUYtFCpdAsjvVYnBeuwSgnHrjdVd5ABezJ?=
 =?us-ascii?Q?F4YIvQWVwgiYW+7gI+I8/73H78azC0duae/yioHDAxvaesQtFZcHuAbe+dRM?=
 =?us-ascii?Q?XT7xJYhYAzWB5elE/XQVX2PAoOynVWJrS5Uju3aUGKKcNf022K1SMj/RYlqT?=
 =?us-ascii?Q?zGYxRSkiaOj4oMv66qcJVK/tTwg/LMnxjciR+jkPoXcgVxxXf4HQYp9flOfu?=
 =?us-ascii?Q?0M2iSnLMp9m4+C9vuTcv3KkHM9qelAR77GlwHE3GOqOGDTIey8AuJ1MTvvk/?=
 =?us-ascii?Q?GDqmyKnwooqFmllbgqxK0mqQQ3tdeurOHmRd4bjVWVH7NWYR8yaou1PsZBUl?=
 =?us-ascii?Q?Yxbhrs2r7x/DX1eHG4Yuvb5Ux3BgbK0X4vBqjVLXG3SFHMgj4GPjxOOgRH5S?=
 =?us-ascii?Q?2xKeAbl8cjlJ6Ha8AKE4r2/2wolvWm8S1zUn+q2uzBTbQYTCK8F5DCUAIdYR?=
 =?us-ascii?Q?65BVEnwvgGX9tLiW1EnriLnLrspN9o0j+DR81VcHjIc1bwTVV2KX2J8Zb+C+?=
 =?us-ascii?Q?FGf58Rs4PPhQ0rNsW08Q6b9aJXEUtgx+N/sqT72CEMFF4YjxAzVIrM9OmTAc?=
 =?us-ascii?Q?rXlHvM3V1HyqgE4qxeE/J4ev7E0EsH2Gn1htOFQdA5l2jYKikD51DqxiRUjD?=
 =?us-ascii?Q?PtgVpm3ZIO9Fxdyo7e2gXIt+oOWI4g8/4wBVLUpi6ga+MBewSOhhT7+OapNO?=
 =?us-ascii?Q?rQ=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c09f41-febf-4a29-8220-08dceed2f64e
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 17:41:42.3440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6PK7tNM3rGrKJ1Wd9jX1W5PmTN0F6OWf3xHM5CJrDG5hBzJhFAY+dIRjMNZevDEm4J9Ov1y0bUYJAWpkIcSm0sIOxicNrJiiBqiruAjMplw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR07MB9009

When IPV6_MROUTE_MULTIPLE_TABLES is enabled, multicast routing tables
must be read under RCU or RTNL lock.

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
                  ...
  [   48.834802]  </TASK>

Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
Fixes: d1db275dd3f6 ("ipv6: ip6mr: support multiple tables")
---
 net/ipv6/ip6mr.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 3acc4c8a226d..19ce010016b9 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1887,47 +1887,56 @@ int ip6mr_ioctl(struct sock *sk, int cmd, void *arg)
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
 			vr->ocount = READ_ONCE(vif->pkt_out);
 			vr->ibytes = READ_ONCE(vif->bytes_in);
 			vr->obytes = READ_ONCE(vif->bytes_out);
-			rcu_read_unlock();
-			return 0;
+			err = 0;
+			goto out;
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
 			sr->pktcnt = c->_c.mfc_un.res.pkt;
 			sr->bytecnt = c->_c.mfc_un.res.bytes;
 			sr->wrong_if = c->_c.mfc_un.res.wrong_if;
-			rcu_read_unlock();
-			return 0;
+			err = 0;
+			goto out;
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


