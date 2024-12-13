Return-Path: <netdev+bounces-151599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 591EB9F02D3
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 03:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8927116ABEC
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 02:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCB6140E3C;
	Fri, 13 Dec 2024 02:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b="wt1CfV74"
X-Original-To: netdev@vger.kernel.org
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11020097.outbound.protection.outlook.com [52.101.128.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F5A139587;
	Fri, 13 Dec 2024 02:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734058596; cv=fail; b=ng5M5wuS26NeuYEIoNG5JMG34hT8lWfV/sZ+bYth3Wk8eoqmBNvoArNqPjnSOgf4yn0wVwl5SQCvdsQvEtCeWapITw77hDyyG+E3Tsos2G1TihFIMq82YCpWFPKTbtlM8Xk8Ml6EpyFXzDZUtzG6Oeh3U83W5aYye+5b56SfIuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734058596; c=relaxed/simple;
	bh=GAwOo/n+tkMkas50hzep+8KAXCJSgQA1EnViqHZKK+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aG0BgBjJM/av9g779+OIFiVKFJi1Hy5can1rjkxln+pskNzlmwhoc2KUqXnZIRYJCk/qPzCugQTNo5InyjJh1SZr+su7c6MjziJMtc1SaA1zKAXB5Oq2xtMgs8Fj43lqIg6V00VqGqBTsyInOCLorB77LbQ0PW5pKxCBIBhhfHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com; spf=pass smtp.mailfrom=fibocom.com; dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b=wt1CfV74; arc=fail smtp.client-ip=52.101.128.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fibocom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WjSiV5NwhvyGWgd5Ml23R0+9Tyx/Ry96BMSbtgDrLSZCNuoo0cFjtnYgCpaT9hwAccHWxCAX1H9XuoeNTbaHrQCLK7ZgRQaQemrqs6hivjPfxecLZb/EUtZRV2jWEQ3VXtLJXR0XyQfVDuMjprd+GoRe6z0HjMEzs7g19LNFIeIufdg9d7yBQiwt0kCMyakp7XwjGoSP5MOKa6odu0pBx8f9h0oumEGvcqSVGTj2lSnAc3N+6cOodBQKrxy72oMo9fKK3/3m5s3jZGVE2rleeFe9VuK67mdEjFmF/XTzwH+y4YQVoTqBBL/3LVHvKT4Lrc3PZWYqHegZvRGDi2/3zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FTg/cfpbpEdq4zqUU3lTcCM2xrPU0e0ELzEkGVCsKow=;
 b=GKpDrmdFNws/M1PMSedMjn/+C23WqFvPXApANQR8pQEEYOhYz8R3ePzxgpjIsbN01Yteis4pG2RRaLJUT0yrdkWQNXWwgP60yRl45WU70ZkAq7aXClyw53thJuoVXZQIjqXGj5cSHVEnz25QUdNtMKSlD6kXADP9cJYMbGcke1LW4LH1Wf7d/lwCYeeNUdKe27KEOSPIejyGMG6GrRVkygKKU8RIhhFOsbHMp7ZKB8zyLxBuSjhcfBWB8DST+4o2p2zQX1twn7Zozaf4HpffdKt08l+nAOpv4TTv/is7NMUC+liHPOPL6te6TkS32nAIs65hC7YWe3k33UFIhmXx5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTg/cfpbpEdq4zqUU3lTcCM2xrPU0e0ELzEkGVCsKow=;
 b=wt1CfV74bj1/foa/FJIGCyz5lSYnKQSrLhRnlRYl/wzvP750YpyfKqVBsblXZHW0ER9LS5jh9QSKEErFzmgdgNdipGjrSjXW8Qt3kdrG1O+2wEFe9uZuRyCIm00mwci24nF+jsqTcq1kjguKV44rPseIqstBRafVGH3W02kY3To=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com (2603:1096:400:1b5::6)
 by JH0PR02MB6869.apcprd02.prod.outlook.com (2603:1096:990:53::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Fri, 13 Dec
 2024 02:56:27 +0000
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b]) by TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b%5]) with mapi id 15.20.8230.016; Fri, 13 Dec 2024
 02:56:27 +0000
From: Jinjian Song <jinjian.song@fibocom.com>
To: mateusz.polchlopek@intel.com,
	Jinjian Song <jinjian.song@fibocom.com>,
	chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	haijun.liu@mediatek.com,
	m.chetan.kumar@linux.intel.com,
	ricardo.martinez@linux.intel.com,
	loic.poulain@linaro.org,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: andrew+netdev@lunn.ch,
	angelogioacchino.delregno@collabora.com,
	corbet@lwn.net,
	danielwinkler@google.com,
	helgaas@kernel.org,
	horms@kernel.org,
	korneld@google.com,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	matthias.bgg@gmail.com,
	netdev@vger.kernel.org
Subject: Re: [net-next v1] net: wwan: t7xx: Fix FSM command timeout issue
Date: Fri, 13 Dec 2024 10:55:55 +0800
Message-Id: <20241213025555.113779-1-jinjian.song@fibocom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <b409c23a-0b6f-458c-8e34-039338e799c0@intel.com>
References: <20241212105555.10364-1-jinjian.song@fibocom.com>
Content-Language: pl
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0204.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::13) To TY0PR02MB5766.apcprd02.prod.outlook.com
 (2603:1096:400:1b5::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR02MB5766:EE_|JH0PR02MB6869:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f1c9f12-82ab-4993-13b0-08dd1b21bc62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|7053199007|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RPgLwiyiOaZJ2i4J1GCdYubY8M8ndpjCyP2F8PKH09KaI8NXCap1l/9pvY+O?=
 =?us-ascii?Q?DOAUq46ico/kFXI62b2lOjOfPMFkil6b+IMi6Gy86SzMkTzob3cympbmI1ky?=
 =?us-ascii?Q?3DAdOsrq0P++2+BBobbTDqtHHs5E+Msyh9k0FaTiDW4fhxBAPt7w7xydAcNy?=
 =?us-ascii?Q?+R09UHe7+FknWvMeI66jbLLGrUw2nEOmIWBmEjjgVSNgViK6Am3M8WysG/iB?=
 =?us-ascii?Q?RY/zGdQIf/RCPMnF0XoX1s5BnN/ejsUv6slCYH8z5pE2tiRN1a3nBgTm6VF/?=
 =?us-ascii?Q?2BigygLrWwymipFoVDu2JtyaAmxC3Tqmd6Bau34eAAVhipVTVvat+BUeakVH?=
 =?us-ascii?Q?IhCwpYObARODpBIRTUFSUn+VaXQOrm83hahFBBY1gXGwBCLIDyumvIVl/Nnw?=
 =?us-ascii?Q?CpXWehgXT/e5T3Y3VUoTFoTpR+7zcAMOEzo8d8VFlzEPNg5WB5oVr68bqigK?=
 =?us-ascii?Q?jOeaQrYU+Qt0U9Cf2lOtqJHQuleUZuSyMHnpxv2bdDsyeoiyLJhbfg0zk2ib?=
 =?us-ascii?Q?s3O6EJDdAmBvkEZbm0sb+Dv6m7R6d+iH63ZLCqr8VkZLwrVNRXDJWdYzaI0R?=
 =?us-ascii?Q?PRJh5LScgMTGkVTquyce8NigC4B0I+SQQzHmn4dVAppEMVGlFc80RihxMIrx?=
 =?us-ascii?Q?bYY28/V+LKJXEz8oG2Mq9YIjOUQUdYhOhGcvQEi8dyhBn8EDdFhXgECt2XyT?=
 =?us-ascii?Q?e59+CtF1Py9GYdfHjjVITh+ZkQvFhq/MgAyY60/KN0yDc3oW8bcihZHW4omG?=
 =?us-ascii?Q?Wav3wJW5ddpqhyZ1KNl7DZlBlN2xp0pPDSdHiq9hA8gx43o1V1Ys1c8MD64D?=
 =?us-ascii?Q?ops24ui+SfWCEnXSD+19SPBDbGu3Pf14lka3k/OD9K4NI4/eH0tDARUc09Xv?=
 =?us-ascii?Q?WQfvxprKnCMFaYhDjGq5S3Iy4rpPp9xkHDDEAbbkzfJRfnPgT4uTLN5GoDXl?=
 =?us-ascii?Q?IK/Yx7wWhtt7/XF4uAF5aRwENrGor6Bb1gDPnkJyMJXDncQo3JpSsGGskYEw?=
 =?us-ascii?Q?NXLMuYZgZRGolKz9HDf+cW5JKXy9IuyNFLfQn3pzWUVxWlZnKzl8aBo8hVa5?=
 =?us-ascii?Q?443kCZEJL7tz/q19LqnObkLeQxXL4gosE1EEdqm+LaancocjlmLu2VsWoqMY?=
 =?us-ascii?Q?80DRM5SkSP2BR0743Om42xCqUE9aQ4YrpdxM9tUihwnazI8gBOr1evsq2PKL?=
 =?us-ascii?Q?zpbJGJdJ91qwnVUJ73qON4u4aOK0DKIvFr7QCtPj0gRMrUwuMdW8xO0ysdyT?=
 =?us-ascii?Q?zmXpto33ZuVnrtGLNXG2x9oi4blobbNTTkU9dvvNew1os18KNsNWrVbqvoA7?=
 =?us-ascii?Q?mTCEnttQekIzlkspReBwyWXv+jdlqN1We9es9JwLehmbde8jLWVDPGWNyVKs?=
 =?us-ascii?Q?CPVZVmVwy5rUcKs1Awy+kac5KJweWkuSSdsPRQ0PQ1OjlB26BemwksZ2sAef?=
 =?us-ascii?Q?ESCOp+2pRp4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR02MB5766.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(7053199007)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gC33ddMAtCcDXn34i4/N/J8k+iOj1siAmY+Klbuev+uSQP6P6GwWZjCgplM6?=
 =?us-ascii?Q?PXey6gPZEMQB7yqkTQdXdsumz/rZV4zw/AnKJwoXpVZ3xpsJV6rAEkU4apVI?=
 =?us-ascii?Q?iUG3+JoAv0X11WZHUGDHPs2YDdw1rXSZVy7omiYEOm1JIz0jmnjjFGqMOCo1?=
 =?us-ascii?Q?1aerNVI/gtNTUfstsySq0YuFHNUN40Lju4oqCM2lNb3ofdkHQDkq4YKHRc6S?=
 =?us-ascii?Q?UMkyrqUuGvqcWbS0kylILISl7nSUYMjjVxi1WMa7fYCT8oAL76G7uFh7D2k6?=
 =?us-ascii?Q?8xgbEFHo8z/8LoV82y1b4iyQeKCgP2pVeEAjEkqlOdN3zlikKi2wgQytiTCq?=
 =?us-ascii?Q?CdOPCN2tI7T2+BJZi+pVTQsZuMPQk5vAePv4W3RIfuh5c8Cy4mhW/Y4dlMqk?=
 =?us-ascii?Q?OPm06S+ia7f+9pl4iSBOuD+Ot2A/JCt3leW32jlhkIcQ8mrJShB56IWGBTHW?=
 =?us-ascii?Q?8AxDgFjHRsXk761UpOPFiAozlPmD8GIyBpj9NuytPrqRCIYvC4Xd1I8BaF95?=
 =?us-ascii?Q?SIrkNhKFN0YFzbJ/M6tsumBIembgqtk6FxQiLa2Tq3Ped7yRxw03mYFW2CtI?=
 =?us-ascii?Q?17S9K/hld/RZ17L1j03DrysNVjS+d+S8VbB4nidqfkcdcc0ckuUyRK99NYUE?=
 =?us-ascii?Q?hp4iXIBCo8dZPpFOVgl5hbgIxbjM1Z6pELjpvp6YjUty+tq/LCWRE2qZvTvG?=
 =?us-ascii?Q?D3eXfURMu+9lLWvRD5ITRKQ/242e20V/wVzJ5URxjzeo5SW7pgftmfHCngwg?=
 =?us-ascii?Q?YzsWPNqKT+F7S2+t4Cb3NPD6feJ9tkCZ+xazNxKaP8iJG17p4cO0n+ttDCNz?=
 =?us-ascii?Q?UJ7yS79hmugHcpf1u/v1in5pjkv4Xqw/WDXWcI+C5V+YutNXThE9T6XwYsFI?=
 =?us-ascii?Q?T68k8Zj9DcHMSuy/wGVvC74nd63SWLDR6ancaEsBx9RS1etnBM3TEVNEhdEk?=
 =?us-ascii?Q?zaRlGz4jNSSQdomI5cfm7FmMQvOL91cATaGhibvr1E00vom2aycybxwn9j2I?=
 =?us-ascii?Q?wDr5GDCAWnhc2dpzAKCHbIorSBCzRPpRBzfR0M4iZSgZwhtOGuGbw7tl405P?=
 =?us-ascii?Q?1Aeoa9/lUUgEmzBy71z4dDk6DX9SI65g2WYEP/1DYzbNOAiCcrE+NZ3GrHuH?=
 =?us-ascii?Q?6swPZ/yHx1fCEXordglbuzz3F+2X+SEWZdDyb2SP4FFdP+CkzG66ml+RVbVy?=
 =?us-ascii?Q?+ltadYc7POfM6+9WnsvbThQIo4VuYF5Dt81tc2zJDqV0nTSpvsSJk6/On8Y4?=
 =?us-ascii?Q?lRdmHh9ybmBmVxhS+uDxp+nbmb4XtKfv01ksEn+nqx1Z4Fx4hysNEFHGxIZg?=
 =?us-ascii?Q?FBZMd/rcbBEiNDEoDEMfPF98KqDBJIDkA0VIgPQAdwnfMK69z/OP/GsKwIU7?=
 =?us-ascii?Q?n2d4ML9JBGk0M8avWybDQDyACNIAvKitAO9KLhYQi7SbeJne+de4KgVteOvs?=
 =?us-ascii?Q?oKC2FWo1yVOjFjOMkphnjJxkOD7OnZaaExAvz7sM8b/vWBecwcsY9P24xvJP?=
 =?us-ascii?Q?BXNdpGsLXB8LoAQE97W5EcBR5ZmP4CbIw1kX1Kwi6B/B3kmsjxR79HwwA6op?=
 =?us-ascii?Q?p/NlqE77Y4+FGYxN8Hz848H1aWwpvjn/YCWp2pE/NT3rGyxuU7z+xUkjH8lm?=
 =?us-ascii?Q?aw=3D=3D?=
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f1c9f12-82ab-4993-13b0-08dd1b21bc62
X-MS-Exchange-CrossTenant-AuthSource: TY0PR02MB5766.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 02:56:27.0509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BDexC9zkpLyQNkLgMi72CeyATKYW1TvYrjhCus9mH4OjBYnOF8lfVkSynsZEdZyBd1BzCPt1xnt6pyioj0//7VgKyzCiNWkkKe6VyvhoKyI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR02MB6869

From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

>On 12/12/2024 11:55 AM, Jinjian Song wrote:
>> When driver processes the internal state change command, it use
>> asynchronous thread to process the command operation. If the main
>> thread detects that the task has timed out, the asynchronous thread
>> will panic when executing te completion notification because the
>> main thread completion object is released.
>> 
>[...]

>If this is a fix then should be targeted to net and not net-next
>and probably should have Fixes: tag.

Hi Mateusz,

Please let me request to net and add the Fixes: tag.

Thanks.

Jinjian,
Best Regards.

