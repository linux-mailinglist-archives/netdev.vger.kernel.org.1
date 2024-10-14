Return-Path: <netdev+bounces-135236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 989B499D156
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 17:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4994428575F
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 15:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FA91B85D4;
	Mon, 14 Oct 2024 15:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="OSOtKaHj"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2056.outbound.protection.outlook.com [40.107.241.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591161B4F14;
	Mon, 14 Oct 2024 15:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918800; cv=fail; b=LfR4KuJ5O1vDTNBYMeqe8n9vVvdi8iwmXinJFU4pGo/ZVRWoWBGKcKdLUZRd3uwmjLhNle2FqEG3ARNqSNM5gZctIH0cPEHd+4rx/vlWIxvj1WyVY7+auaoiIkdzooXi2lvdwPXYl+7GDdoXoiUD39fP9Y4iQ/POIXK9CLrMZ0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918800; c=relaxed/simple;
	bh=Sro7sFxX1Dl+c+kHUEOB/UwzRmqFmvsQoikgx+h+igw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rqdZ+qE3/0xB62T4/108IG853G+vHgEWR3y7uWwDAxS9HgErhDW8y6fpfzmNd9edglbf5OnAeuqqWR3y3l3dsmuJSXXJr6U0GPJxOp/xjbW/IGwkOXNGZaGGfqPiHEIFJEKyOMXjIlSqf82HbYw+nPyI+rxGC0in0wMrDiboMk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=OSOtKaHj; arc=fail smtp.client-ip=40.107.241.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rBQh+XKLXfNwMOpN8jO89VCw4Rqa03m2Y4QPJSgXwMaOv+JDHxqjLpRm4bIrZD2EB+DVi++IdCEVxlAh8SMoH88TQVqIUJe8JTyxMYql1DSoogCCJUXVqIwZza1495wZjqg5FSSbCEuCeVSJq0fxdkURODYwomlHiDN6xWLvVQh8VaVFqfSQGh/AufEOS65bZuUGgdM8eMpdoUfvIGsZOxIjmgyJPMPkyVGT2kltMTHdYBkgtQIqunkOcrfqaVtf3yP5mJTbQupADtbxY6SnoSHR82MNeuK5gK9M1MvJdpiEGZ7V+C+CUR+CV5rN3v56NRknUxxqgnuw/GGaTdSvBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ycIg+E/wpAnSLvZg1OcUiBoAyq8QQYUbe/Z8/03mWcM=;
 b=DYbLtfExWt+aVq4EpsQab/NbIhKeNGTa90G2L41IT0QjzoJ4AAKT+iCzxJqH4GoiC3OCMGUsrgK4yW4KpTU5zIeyclkMYJdBAMYPX13VpgoKoYbniFhn3ZLjGjP0DYKWwdJLEEZrqzHei3LiJaFLI95Yov0CskgwctzQWfKmiPg8R7yhfyT+3VV+VQBrNdKrH2a5B2CDWL93sgtAzilBOICTq/6W3W8kTBYcZjD+8xiF+pygkASHE2HiofWMUCfZyt7luyxMijFIFeBm0BBTQLfhnbUxC9l2om4uG9VssHvDeK07UHSi3498Ep0plCQMabfdkQTOG1vvsBNjNSoRTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycIg+E/wpAnSLvZg1OcUiBoAyq8QQYUbe/Z8/03mWcM=;
 b=OSOtKaHjmA3KL02h8d10VrpBzYmRfjAn8YVSarDBCDA3hGH2dxOgm1pamDqvZLLkQPHNPiewwR9TG6x4nZMLN7GQLe6naP3Nx9PXJDEPIm6Y3YvUMX80Ss1CrCPhsqdXB8nB5BMjPxQt0huZXwPd75gp1aePYyjiNtItfbZx3uc9Oq7FCLLLkH9OkfMEuAjwDDkYxvfijPoBM8UNF8xbV9xzaWZ765k37OPNVAseDQXkYbbIEoFPw1PsvZYw3qRIwYm7ixI+gBqXUSxwMfmp2+4ZakMYrf08KjyfXWF6NvKBZCEcr0m1CcHVvSfiK+cgz5EdWRDdvvn838FVqmXRRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by DU0PR07MB8905.eurprd07.prod.outlook.com (2603:10a6:10:316::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 15:13:12 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5%4]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 15:13:12 +0000
From: Stefan Wiehler <stefan.wiehler@nokia.com>
To: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wiehler <stefan.wiehler@nokia.com>
Subject: [PATCH net v5 05/10] ip6mr: Lock RCU before ip6mr_get_table() call in ip6mr_new_table()
Date: Mon, 14 Oct 2024 17:05:51 +0200
Message-ID: <20241014151247.1902637-6-stefan.wiehler@nokia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241014151247.1902637-1-stefan.wiehler@nokia.com>
References: <20241014151247.1902637-1-stefan.wiehler@nokia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::6) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|DU0PR07MB8905:EE_
X-MS-Office365-Filtering-Correlation-Id: 3270b463-6167-4a91-f1e0-08dcec62b82d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ISCGpbM7nxUA4wYTWWmkNMw2M1mAnIpNCu5a5SaMp/UewarHquQT2YPEgUOr?=
 =?us-ascii?Q?+7Wdu7OvTZKtfgYcmD1fr5KswwfVcpkZEK4wicgryU1UnEDDawDF63E8Z10+?=
 =?us-ascii?Q?XpzUyGuXrl02NypgBtf1GJUM0nIfyggKmJVuN1JN/qbEGwCzmvId+xJs/nY8?=
 =?us-ascii?Q?/A+mwnB6XsnuQ5GxE7zNS+gWwQ4lTHGPx+2urlMIH7QVdk6z+sQiRxkafMj2?=
 =?us-ascii?Q?MCPr5bK2a/J1L/dwCJ2ncCXkBxDkLfsgV8FwqG6+dbby1Mm6zgSVLMC646Qn?=
 =?us-ascii?Q?BmIsrhHfbA9g/T1sBB1/MT3fr6js+9uLaNIpMy1oGa/eZ2o8LyfZQMzOCPiC?=
 =?us-ascii?Q?A0IGImuAwgaahyqchAIr82PP+vXSXdR6owBzeGwW3t3Dy7hzrUtd4sFT38Ah?=
 =?us-ascii?Q?huxcjeiUrOPGlxbzbbNfYlJ4QsNSuMgoXgpvw0fHUsotZA3hgqj1DMcntfT4?=
 =?us-ascii?Q?pNRoJmaM8Ve1FCKtduuRKOhCdi7CnWFhgOHLN3pLFbbocWopIcmPHUH6hLzP?=
 =?us-ascii?Q?KulvaIyaxLrD9um4JD4LJpuSx1FY8cShGf5zORQLcF8obsU/5TRaUPlpQmX8?=
 =?us-ascii?Q?UwG2ksLfWyDDymBN+0Vr+RqSddepR9HRG8Q4z8r3jRsjU3TldNKGABBinemw?=
 =?us-ascii?Q?LSOsDqb/3PddZcxlnflGcGlyWVOLM6stoGCicByEBRwV62uwfLaAVczJsfaN?=
 =?us-ascii?Q?fjyaFZxPw7gDEbVb2tI7A8jHnQUT8PxrUchpwwXMzrq6PlYEHre1X+TP8jCc?=
 =?us-ascii?Q?BiOhZ8mjqxDH2O4NS7YTnmX7xfI6acJdEPQi9zWv+y17vmFLT8vvJl5Y5+xX?=
 =?us-ascii?Q?gl+3Vm1tNghNBbB9vF9Qef1UsHCapl1yjGeEUuc0ff47wdRaxy8MLJahK1bc?=
 =?us-ascii?Q?o95fkSNn0XjkaUzFHeXobg2hMr/mLdIy6A5xGIacrFMkzxR6aORltuI7Zxb9?=
 =?us-ascii?Q?UJmHWyNdYlyBT2TPgs0IuJ4+BTLBgZfMLId64FsLfPSqUmpyE44bpW/rfn1x?=
 =?us-ascii?Q?C6YnX9fLoaeVINNApCG8VOOPIS9qrMmczLHPzHOlOwftBMuIif5t0J/Z9ZkQ?=
 =?us-ascii?Q?OkoicYeO+E2xuk2B9h6l2EPQrjUe3+2E650/aNBX3nDGpHiX8PKYvWYhW4Bv?=
 =?us-ascii?Q?PHpTHWHKBo5SmbnNLs96c/MZTPjGCkFU0jBBRgjfuinqNrGfFTpbCSnKC5iz?=
 =?us-ascii?Q?8Lknw7F9ZzDLKKtltxtuVSgONdCLeNbTBRnGr1/FCfR6jemybsM+OD469Yce?=
 =?us-ascii?Q?Tv2yH3YnJ8q4DYK/E55lmxOREfrne8nQHn5xjpGM64DqEOYs59TCAiESjUnb?=
 =?us-ascii?Q?xg9ZYV68rWIw6fCaBrAEuLvbcr8dSwopCEqJiMnf9l6JWA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/WsHPAjvtQOT+g8Lf7fPQBsCXDLm0zRFOx1lQdRkXvgEhZGV0eCT/3/yRQpk?=
 =?us-ascii?Q?CSpxIIeKat1HWU0xEMx/WhnWucMDUSjgJbU4e/zmqafSX+4C6A4ATK9NA6EE?=
 =?us-ascii?Q?u85tt0h2K9LnfxMQQeo8yruK8z3NWbNXZ7bvEZdMLiV3ywaKD141KP0KBUR6?=
 =?us-ascii?Q?ZI+2uZJkOAA2OgOldqufyVu6GZrVRMIVQDyVM8yd9TLl5M1W5lok5TbBoe6t?=
 =?us-ascii?Q?CNMBThO+bMpyamHA1/yt/bRw2l7P07FUbsgiXsrVVG+b/L05SpVDFQ2+CexF?=
 =?us-ascii?Q?P3Sv0SiYNgIn0YJUgH4cOzqrFXv/1lDEDEYd3RnFCD3awwz4nOReMSx+vxbB?=
 =?us-ascii?Q?wRBq3oWDMZWiIDhzSRJiE4+uXq25DR/NI60FLUCJkNvrbcR52OWbNC1o//8e?=
 =?us-ascii?Q?4OMsMMbh9h6MWQKuHw9dmRCAbZam83dPFP5MdyRykgSL34dBunXONLhUaWhL?=
 =?us-ascii?Q?5V8nrUptBeS8xlpg5w4RMWMuXR4uD5ZaVo1jOomiDFkUOwDBkg/mZUTOk2tZ?=
 =?us-ascii?Q?gVG4fbSS1KJxLRjOcvtXfqgTF4rExx6pzDsYOPDWmMwVs9mPGhROKWgFOffV?=
 =?us-ascii?Q?V9XWdvYLuLem3NLh0xO5jNdvLajAt7KIEi85xuw33XcGJJNJHnIKNUzSvASW?=
 =?us-ascii?Q?BO98Wo8TRRII8w7MSJY/r0SVuDpJvtTfwXpreHQhwcWT283uWXbJibkbKYAg?=
 =?us-ascii?Q?Seehrp1FIxQ47dxnS+tZ4uu1FqKa4pxfGDcVISuP2Ou2YW7bIlBDVFoIWpoQ?=
 =?us-ascii?Q?xWbevuIVftr+fhxfMijdma0lwlVUamCEeucCLEny2Qej6V8WxFhY6NKL8h8/?=
 =?us-ascii?Q?MwUMipMwe47CKNhvudfWCiB/kbP/wdT4lUrrKwNZD2WXRw4KxtV5VhYUYhob?=
 =?us-ascii?Q?PxzoXEAYAkcc81b5iNALU4NHnJk93n82cH9RIEZIwWjTS6bJ6faiB8fM4/cI?=
 =?us-ascii?Q?xpG3h2vUv08Yx5Vwj7nVTYb7R+9w8/uKSDV+2qppSPg/1/ESak6uwacV2Ocl?=
 =?us-ascii?Q?sq1vyqyRBmWoxqBZnW5F8oUQAiEKwL9r9n4Ns82xGLWB9I+bbANilFmC0Y8G?=
 =?us-ascii?Q?c6h36R+fND448CtbpDyjxYuwhuKcbTk7979nTKsjQDoCtWxD5mke7taTKxT1?=
 =?us-ascii?Q?VYkOFwBN56O3y5G0dOmgEucEKaASFjl0B+9wNYDwy9p4dPVMmbQqnRbaslg4?=
 =?us-ascii?Q?2HH/3k0BuvIxugOhtx/fIHxXKtGFcaTjh7Z4tQT5ZFY8AjBP7kb4dOIpgmwt?=
 =?us-ascii?Q?dqOeRUmDhM4A/ozL3QI2yV+3XTq9dOCj2+S+QMf0sbpo4Ri8tQ/zw0O5EWvw?=
 =?us-ascii?Q?/r0Y5nhxjr2Beb7/aK4pNItAhvKjjmiU34aaTwoTchMAKiRCgyzfCN9dUc81?=
 =?us-ascii?Q?7Gly6peEHxUdkawra0shRh70EYy2abVSg+3fNxtI6/lF5LxE7tPpXwZgcQhv?=
 =?us-ascii?Q?J5jil/Ht55Ncjb7K3Yfm14zkt6zb62PijNpNB0AiyEsXCbDNpx2ey4NKIhKD?=
 =?us-ascii?Q?4tWPxhQa5S00/19hnomUzTwg4lAbP1bGK/ubQYgE2HfvatG24ijoNXqxlXwB?=
 =?us-ascii?Q?z4yKENkAQK5kzORH1KuZIqQ/VUcknB7GoLwNJH9MqTc26NAfRb23CSjU5Rrf?=
 =?us-ascii?Q?8A=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3270b463-6167-4a91-f1e0-08dcec62b82d
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 15:13:12.1567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vg5ZIpKuWPTkkE6fewrDkT0bBgKfeL50uAvraE8CeGPlnO2UTrHEUXLSP11TLPmRxfTxeXjePl4iGU+bplDptYUDm84ZpD+Rj9QE3y/mRSU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB8905

When IPV6_MROUTE_MULTIPLE_TABLES is enabled, calls to ip6mr_get_table()
must be done under RCU or RTNL lock.

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
 net/ipv6/ip6mr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index c47564f0c868..5171d64e046b 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -382,7 +382,9 @@ static struct mr_table *ip6mr_new_table(struct net *net, u32 id)
 {
 	struct mr_table *mrt;
 
+	rcu_read_lock();
 	mrt = ip6mr_get_table(net, id);
+	rcu_read_unlock();
 	if (mrt)
 		return mrt;
 
-- 
2.42.0


