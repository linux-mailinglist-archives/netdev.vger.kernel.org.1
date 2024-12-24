Return-Path: <netdev+bounces-154135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F42C9FB918
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 05:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4D2B1650D5
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 04:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40460481CD;
	Tue, 24 Dec 2024 04:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b="cW8eqikx"
X-Original-To: netdev@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021093.outbound.protection.outlook.com [52.101.129.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02141392;
	Tue, 24 Dec 2024 04:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735013796; cv=fail; b=XVJ9sB4wsGgBeOnUsF5vV0L8gxALGQGyZJGgopgcrDD1e0KSpSUtJIZBMZVAUn7MohrLGBi6uau+yHIvQ4YhXaN5e2XQJIS/P1ztWd51j5+18DHCL2qYKl0TzYy1cw1HT+QZ2WRpMoRBDg7FUVoNVFNa/gyrNc550IOBDe8+mz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735013796; c=relaxed/simple;
	bh=bcsyRmkbZhhfqvn3Jk8mvbREVslmBOdAZ5y12D4HLMA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=F+zqRpdCZu/0QjSN7NMnTkZHPeS23ZPkq+9S5E7k4pzos8JECOS9944qHScdpAIgaR27pxzPBsdlGKg1o7WMf7y1FmMP7Cte9xvTT9MDfEMmqcgThNfupoDUEJKdYrXqWw7bDtVWDyXviqT9qeDJBEAWqih5wBv1fhs/OAbV6r8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com; spf=pass smtp.mailfrom=fibocom.com; dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b=cW8eqikx; arc=fail smtp.client-ip=52.101.129.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fibocom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qr/fW27COIcvY+0Tjz6zLVjP/d4mXwULKENFyrH/nX1TqPptL7BfWkdkVkEBuRvxOnyzXADpGH6M2BCSuXPGNsyErdEEirjxgEFqv4WRQfCczF1oqWHQwXhdWuN6WkIi5j7GTinkK2TpLBmi9TOe89AhlOlMBU3ybO9yr+QXZo8HurG9iWVlA5ChqAcnOlo273EnejZXgzwMdwCBUPOizMRQfPVR2qS7mfupm6swRW3z3RPFR7C4XtrcOE0DanNHAAnPFqcwnirxQBLbDzWM7LYqnShjPzCJSVUf5fG+HIyxarkXJXS5vR2XIzT/FwBnBGKzTRX+XtTvnQ/XPsR4yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46tUy/xxrsCz72grSsadUJH8lNfyCU9mpqso/FD9Efs=;
 b=OeTzTUFmmk+BgtoP3HAeuJfRT9F/tB58xRHDwrqsrpsmXLCMri5xr8jk+kbXxArkawtmwA+YfBoQHJit5mjsH+AXMt0WqR9gFCQEsnvjvXZwQfDbOcr37eqfVOCrkLFI+vDZTnfTM28thVMbPJZ3bjZ4xM87BVwt8GcX/VwofXJxOkILzj8CL4sspkXMG5s2+Lczn7oD0/a8alLcSKQamgmV/+M00QC2V1OHhBScnQxZoiL4J95UtDlvCte7dW5u5oNUwdL0/P/X169F5WYQ6WfmpkA3IRNopunSQ0KaFw4+8+wzYXh7aTaCF971RavqU8j1cMYp5+jPkyHYD4yBig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46tUy/xxrsCz72grSsadUJH8lNfyCU9mpqso/FD9Efs=;
 b=cW8eqikxMWYV5FlpKUEnKGX6bWnrJl6f/ZK4Fp0VQQbWwpnR8F38wR8LqJ81z1MlW/TQhXU1CvAzR+5VWA2q7fQLckHnMyUsV80w9xEkg6rlC1Ksrt8IrDtG2qBThvYKeqAkniToJ5JDGlhLkekvMAZbpetved1gVatbpqA7NsY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com (2603:1096:400:1b5::6)
 by KL1PR02MB7473.apcprd02.prod.outlook.com (2603:1096:820:123::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.21; Tue, 24 Dec
 2024 04:16:28 +0000
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b]) by TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b%5]) with mapi id 15.20.8272.013; Tue, 24 Dec 2024
 04:16:27 +0000
From: Jinjian Song <jinjian.song@fibocom.com>
To: chandrashekar.devegowda@intel.com,
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
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	angelogioacchino.delregno@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	matthias.bgg@gmail.com,
	corbet@lwn.net,
	linux-mediatek@lists.infradead.org,
	helgaas@kernel.org,
	danielwinkler@google.com,
	korneld@google.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jinjian Song <jinjian.song@fibocom.com>
Subject: [net v3] net: wwan: t7xx: Fix FSM command timeout issue
Date: Tue, 24 Dec 2024 12:15:52 +0800
Message-Id: <20241224041552.8711-1-jinjian.song@fibocom.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0188.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::9) To TY0PR02MB5766.apcprd02.prod.outlook.com
 (2603:1096:400:1b5::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR02MB5766:EE_|KL1PR02MB7473:EE_
X-MS-Office365-Filtering-Correlation-Id: dd4861fd-f05e-4a06-72d0-08dd23d1bc32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KVNk5XMuyvLOGWYcpoUTLM7SMJ6ehRfMRPnytQ/TvDpXYLw7H/fMJHLH3ITs?=
 =?us-ascii?Q?DSkKvWUkWX6wVd3JpcSNx6P1/BjdT/iYxs7jyhGNqJqQal9qzhuEuDk0L2N1?=
 =?us-ascii?Q?TIlUmkpUMQN33w7u6OZNnA4rxzO6Bn+2ZqIRw+5XJfbXrM3HTzayJu4QQ5xQ?=
 =?us-ascii?Q?T6q0B+EGpUkLL6lIQ3HlhuUi9EtiQpYFzEO3zKzvs0B2/WrH0qe5oOA9bJPV?=
 =?us-ascii?Q?kvqS18y78Ramm2OYBZEvIp9lFrRywq55LI7pv2zrPfq0RJz1wrQxqOPfEKlD?=
 =?us-ascii?Q?v0ThFuc8wG+6jXhz+F8HH5vVTndTVa0mAA4GMIXNckxyXyFz7iyWAdJMNaPc?=
 =?us-ascii?Q?/LY/W2xR8IdD4wKgMobpXa9QdXyY9UaNHYmBLUWcIDw5tqXl9iSCR8satm4M?=
 =?us-ascii?Q?x+erF4aoYbDmNAQoeoFTHkGEEgY5XXabYOmooYdAxGfrRlIl0WAnX+mtc16P?=
 =?us-ascii?Q?vcaH8wqSTdPTIgECkSfbkVKBy7ncfgDlB9I+g74G2cMf977ApXDA00UclKxa?=
 =?us-ascii?Q?d84S7JCWog6W2Wvf+Yiym7pyLt2ZDudoxdvd5lJwUWCiqrCbHGbzXO9gYFIT?=
 =?us-ascii?Q?4mj7I7OM0ag2rpf5z7uKx52rWR+zIJntnc5u1CxyEVbJfdDvRuJpxFLNGWjD?=
 =?us-ascii?Q?5xaAv1eAbPRAj1vPmPh8RBANIrYKYhQPwy/03AAQsTMxACvjPlWUMM6aECIQ?=
 =?us-ascii?Q?CTUrxvM58IOs7bp8N1GHpTBvlw7pX5GMfl7UZD6NpPza39L8Wns6jruMYbZ7?=
 =?us-ascii?Q?hijO6EMmOoJaXrtjCXRuZ9PhR1lJcNl9O66t2bxIxB5ibiDuuIKpjVcrDm6x?=
 =?us-ascii?Q?vOnK3xVHgb3B8qauTQQVurg/Z081a8FvXRR/398B78lnbQ/R0LtNxbt79Bpt?=
 =?us-ascii?Q?4x26FxixivK3FVTI6VzPpLFES8Wqhapwa+7J2vqoWXcXAIkbaHE0/i7z/H2I?=
 =?us-ascii?Q?z70o0lmgIr8excWJs+bpD9iWUkcBnrNdcJQYjh76U6k08wIvEx0Hs8nup1uG?=
 =?us-ascii?Q?JTziSSpgPuYWdUiH2h8b0G0V4TVlaiaUBonHvv3j0H1EeFtuoIVMKpyXLtZE?=
 =?us-ascii?Q?5RZGVFH4PDbM0p1OH1DnvLE7DKxXDpmWLQlMulsYQu6Nz+ZzL+YlPmxeOdyG?=
 =?us-ascii?Q?ZTj16jatBhR3Y91Lt9AkLPkHFf17OD8kJIfNR47Neq0+1XcjHYq0UdDZvzoy?=
 =?us-ascii?Q?tv4slXwI7iakhtm/rEZINTcKdZ9g13gCCGocW2asvMOkZ5liDoukb/hopUVX?=
 =?us-ascii?Q?JjXLFBBuzdZZOTVW9FDJCKgiYeGDjylrFKxrdytm/0DxtyD+TcIxQKat9VZn?=
 =?us-ascii?Q?Rx95zb+UgjDBh3o6n2lzkh5ofJ9XBmeEMiAVqJGMg5sfVIp/OH9ZLn8Nc7Hy?=
 =?us-ascii?Q?5+W7UM0mchixCIHcXtHvLY8jatqfXYzQL4L7ZMdC2zfW070A8hPy0LA4gJNg?=
 =?us-ascii?Q?39Rm6nc80GN0tCl1QVMNZYetsR7aljGuEikfmjQH+4sMG6Ud/KK7Ng=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR02MB5766.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jdo047TO1xFAPMhkgd8GF+gEz48wmcd3eaclKqc4LAZSwia1hhv1hPOLjUV5?=
 =?us-ascii?Q?eYtum01zOLL7XTQZvNf00GCA5QfdBjdn4S4FC/RWJsEWNpVxm0BvsUv1aAaZ?=
 =?us-ascii?Q?4xfmnQUMn7Hx8Kv0ssu+DCzFGPK0Fg4InAOMAto3qzc8w+/eVU6OqdH6Hu/k?=
 =?us-ascii?Q?S6/KON5gj6avWjD7Hkg0Dix9YXLfbWbf37VawJijR8wfUhOmQlVP9BjPnTj0?=
 =?us-ascii?Q?+fL6GBBWiBa4dZfGE0t6euxM1G68uk3ceOgLKvZWdEpFi8sfIQHhf0nEiC/k?=
 =?us-ascii?Q?SoAUF8jupdujJqNrxJ0bD7rNsYj+MovMHo5oqeecjNtD9wevyEC1vPgjPF0B?=
 =?us-ascii?Q?KDL6TEml19Yt+GnrBuvD+VCtI8ePjuflQfZwEPuD//XM+AMNGg6Yjp/HhsJa?=
 =?us-ascii?Q?6ofCJqBuIH1YbzQ7QlfF03pIKVdzuMzySrGRMPmnsohs0WH04aXHChaapBKK?=
 =?us-ascii?Q?hLTQ5gb/ZRBHSAh33DwDn0OM9qQq1Fzh+YjSBpz1O3cGSCOQA3CMJlEx1Np7?=
 =?us-ascii?Q?OgRx1jAsm92qFeb2LvXwfBKjl4yZSNUpbDn52dtQmRlgN0mGJE+wIAxov4ov?=
 =?us-ascii?Q?/FUS+X54mbcuRYYPXIDAgpQ1k9NN79SktPzPsZQ9utVqbFNszjWivCyOqLqW?=
 =?us-ascii?Q?gus5v6l1Idg1XqYRS+XrXVlJzKpfD+I2ng+MYvZNdCq9bM5As+qvFNVJT0/U?=
 =?us-ascii?Q?uKuQSX0N/cT+v1VwjUvUZR99/5d1PGiLW+Adj1QP9Uv8R6IBlaPs1DIz1wSI?=
 =?us-ascii?Q?grhz6LPVFG53iOFJJ2DJrIjKmD92eKD4QLFEQcJCjWuQ+6JuVUC3Dv5SwvO0?=
 =?us-ascii?Q?VNYYcLTkVJ7OoXvssZbVBeEuVDOflxd/NF1et1st0vzjnZQlGhrwsAYJ5Im9?=
 =?us-ascii?Q?Si43m43Hx4z8Qlxmjna5Q6CkHL6Ha0K2Rs6WIFCalCCrB/YOdXvhSQbIN7+6?=
 =?us-ascii?Q?EdsKuOM/nl49TR370p7gMTugzQyMvtWr+ZMCaCATi6PVU9xiiyEVQN3R/VMq?=
 =?us-ascii?Q?8wRjHzQ+kq2kH3fh+J3XL046QlXUbLnZBoiv1q3AHE8lngRJ1/uCH1KCWhuT?=
 =?us-ascii?Q?10mbZBd5AG2YTiiIdp8hjtMT+1vbL/aDzEusKMU2lciti9MnkXug3t/qfuNS?=
 =?us-ascii?Q?YS+TZm98UlKSMSZ/o/dF7uW4A2MNzU4xMjJXKeV7hLtxrF6kpgmgY209EU0h?=
 =?us-ascii?Q?obx1TK9QChKUpoQmYgEyzDa+iPE+Xn78D67g0Btl7B2fGBUfbRt3eNntpUt5?=
 =?us-ascii?Q?uD252f1MvTOy6u4cl2CT3KmZTaQpyWRVT7VV1QHMP8d5azGTRRA79UqiPpeN?=
 =?us-ascii?Q?rRLXOCM2PQT6mvniScAd9qEYMP9MMduZcJj0BD/zp9ixIHg1FMrgt753OAdN?=
 =?us-ascii?Q?YpRbQFJMUOY7mG+rm1EWbj7NW+GeYsR2xTBsyIlH8udJxBDkYy93FOK0M2JV?=
 =?us-ascii?Q?IFdnTRsGLVMRgk7ak/ezuraRo7eYG+6aNLfDVo6JOuUzJHVNDMSj6a10rcVX?=
 =?us-ascii?Q?/wYNyo5RWeT7HYsBFJSQcr5p1bH2QFEkFz1gulECnFZeRcRlb1D4xqSlPZk1?=
 =?us-ascii?Q?N+wHZelbsy9QMBB9mWcSRCdddPpLg09wosceCAjsof7N//fxJVLPy+3kbYGd?=
 =?us-ascii?Q?cA=3D=3D?=
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd4861fd-f05e-4a06-72d0-08dd23d1bc32
X-MS-Exchange-CrossTenant-AuthSource: TY0PR02MB5766.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2024 04:16:27.4310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NodBQZBX41TBwz/gtvH+e9dZQR6cUuSgcp8KT+kGN5fJW6FUym+7C9WdJnz9m8KcLF4ixLngm2MHQEVLsMKW2ql7FbO0++xT3Kt+JD1vDAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB7473

When driver processes the internal state change command, it use an
asynchronous thread to process the command operation. If the main
thread detects that the task has timed out, the asynchronous thread
will panic when executing the completion notification because the
main thread completion object has been released.

BUG: unable to handle page fault for address: fffffffffffffff8
PGD 1f283a067 P4D 1f283a067 PUD 1f283c067 PMD 0
Oops: 0000 [#1] PREEMPT SMP NOPTI
RIP: 0010:complete_all+0x3e/0xa0
[...]
Call Trace:
 <TASK>
 ? __die_body+0x68/0xb0
 ? page_fault_oops+0x379/0x3e0
 ? exc_page_fault+0x69/0xa0
 ? asm_exc_page_fault+0x22/0x30
 ? complete_all+0x3e/0xa0
 fsm_main_thread+0xa3/0x9c0 [mtk_t7xx (HASH:1400 5)]
 ? __pfx_autoremove_wake_function+0x10/0x10
 kthread+0xd8/0x110
 ? __pfx_fsm_main_thread+0x10/0x10 [mtk_t7xx (HASH:1400 5)]
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x38/0x50
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1b/0x30
 </TASK>
[...]
CR2: fffffffffffffff8
---[ end trace 0000000000000000 ]---

Use the reference counter to ensure safe release as Sergey suggests:
https://lore.kernel.org/all/da90f64c-260a-4329-87bf-1f9ff20a5951@gmail.com/

Fixes: 13e920d93e37 ("net: wwan: t7xx: Add core components")
Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
---
 drivers/net/wwan/t7xx/t7xx_state_monitor.c | 26 ++++++++++++++--------
 drivers/net/wwan/t7xx/t7xx_state_monitor.h |  5 +++--
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wwan/t7xx/t7xx_state_monitor.c b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
index 3931c7a13f5a..cbdbb91e8381 100644
--- a/drivers/net/wwan/t7xx/t7xx_state_monitor.c
+++ b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
@@ -104,14 +104,21 @@ void t7xx_fsm_broadcast_state(struct t7xx_fsm_ctl *ctl, enum md_state state)
 	fsm_state_notify(ctl->md, state);
 }
 
+static void fsm_release_command(struct kref *ref)
+{
+	struct t7xx_fsm_command *cmd = container_of(ref, typeof(*cmd), refcnt);
+
+	kfree(cmd);
+}
+
 static void fsm_finish_command(struct t7xx_fsm_ctl *ctl, struct t7xx_fsm_command *cmd, int result)
 {
 	if (cmd->flag & FSM_CMD_FLAG_WAIT_FOR_COMPLETION) {
-		*cmd->ret = result;
-		complete_all(cmd->done);
+		cmd->result = result;
+		complete_all(&cmd->done);
 	}
 
-	kfree(cmd);
+	kref_put(&cmd->refcnt, fsm_release_command);
 }
 
 static void fsm_del_kf_event(struct t7xx_fsm_event *event)
@@ -475,7 +482,6 @@ static int fsm_main_thread(void *data)
 
 int t7xx_fsm_append_cmd(struct t7xx_fsm_ctl *ctl, enum t7xx_fsm_cmd_state cmd_id, unsigned int flag)
 {
-	DECLARE_COMPLETION_ONSTACK(done);
 	struct t7xx_fsm_command *cmd;
 	unsigned long flags;
 	int ret;
@@ -487,11 +493,13 @@ int t7xx_fsm_append_cmd(struct t7xx_fsm_ctl *ctl, enum t7xx_fsm_cmd_state cmd_id
 	INIT_LIST_HEAD(&cmd->entry);
 	cmd->cmd_id = cmd_id;
 	cmd->flag = flag;
+	kref_init(&cmd->refcnt);
 	if (flag & FSM_CMD_FLAG_WAIT_FOR_COMPLETION) {
-		cmd->done = &done;
-		cmd->ret = &ret;
+		init_completion(&cmd->done);
+		kref_get(&cmd->refcnt);
 	}
 
+	kref_get(&cmd->refcnt);
 	spin_lock_irqsave(&ctl->command_lock, flags);
 	list_add_tail(&cmd->entry, &ctl->command_queue);
 	spin_unlock_irqrestore(&ctl->command_lock, flags);
@@ -501,11 +509,11 @@ int t7xx_fsm_append_cmd(struct t7xx_fsm_ctl *ctl, enum t7xx_fsm_cmd_state cmd_id
 	if (flag & FSM_CMD_FLAG_WAIT_FOR_COMPLETION) {
 		unsigned long wait_ret;
 
-		wait_ret = wait_for_completion_timeout(&done,
+		wait_ret = wait_for_completion_timeout(&cmd->done,
 						       msecs_to_jiffies(FSM_CMD_TIMEOUT_MS));
-		if (!wait_ret)
-			return -ETIMEDOUT;
 
+		ret = wait_ret ? cmd->result : -ETIMEDOUT;
+		kref_put(&cmd->refcnt, fsm_release_command);
 		return ret;
 	}
 
diff --git a/drivers/net/wwan/t7xx/t7xx_state_monitor.h b/drivers/net/wwan/t7xx/t7xx_state_monitor.h
index 7b0a9baf488c..6e0601bb752e 100644
--- a/drivers/net/wwan/t7xx/t7xx_state_monitor.h
+++ b/drivers/net/wwan/t7xx/t7xx_state_monitor.h
@@ -110,8 +110,9 @@ struct t7xx_fsm_command {
 	struct list_head	entry;
 	enum t7xx_fsm_cmd_state	cmd_id;
 	unsigned int		flag;
-	struct completion	*done;
-	int			*ret;
+	struct completion	done;
+	int			result;
+	struct kref		refcnt;
 };
 
 struct t7xx_fsm_notifier {
-- 
2.34.1


