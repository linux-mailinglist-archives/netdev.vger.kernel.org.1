Return-Path: <netdev+bounces-210835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED16B15069
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 17:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53E8E3AE615
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 15:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA876294A16;
	Tue, 29 Jul 2025 15:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ajd/XqJz"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013027.outbound.protection.outlook.com [40.107.162.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14388295522;
	Tue, 29 Jul 2025 15:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753804100; cv=fail; b=WCw71RCjZzy6eTN5jHnPBuhFjSLfoyguwq3ljj+NITEBp3WPwG++Z6Of9e0nYje87baE1nuB7HMkQ1nlVOD3aQfdszOBhef4WGX4QxjmB/8jknAouS3XDPuScq6b+vB8tq3ndMRxKH11Hs2KFoPUH/a5+9p6dJk4P9cLYPDpRhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753804100; c=relaxed/simple;
	bh=HQfseJlz1F79guhWbjSrAbMHdTJgms5D1Cl7T2qxGsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ggK/q7h7y+klExvw/Y12rHe/2gFA3Lt8T9Jmcc0w2UiHB/5XWL98O0ef5AsX870bJ/vcHtNOWI3oHNHKCqDRHd2sHXOkwfkAZo8a/QiQsbq/pd8mR3b3/TWFSH9CqutcBk7maegudn9A6ef/qRDTp15xnmZDRuCbO25M1x6stY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ajd/XqJz; arc=fail smtp.client-ip=40.107.162.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NN4bOeCnbfT+b6pBL+3bzvIg4UlhwkT8h8c1AWQ2Bonof4Bl1u/Aop72ZImHHL5lmJAcJs+khjyUt1v8AHxHss8hIlPqzqq5O/ELWAngaaROHBm1r4I4acRG3rUi7LmHOCTiMQ4k+XXqfyhKRiBlo//E1eSwnVMnrixcPwSIVxdudum9+KzASJ9BNVa+ukBQ22bgadM8BZ9L/TrCu6j7IU38/yfcp+qOrCFs5hN5cTyuTJmhKhPv/rqdltlXKJSPIuVyqresIFcNjv+OVoph7OnrGX+m1MxfwUFJsA3hS1b6lEYaHN+n5UWokNPmuDfPF4UU6S305CbvsE3eE34m9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TtU11MwECxWpB8N5IuL6lX8VNqiBkIskoL8EgWfrRiU=;
 b=pC95dyfjCRXFxnELGbFCmWkUPZm0670INKhALp0e3ozQmNesD3lI+mFIeYl9QXwhmTgfe+tTtOBPKOT+Mh4dCu7YgnX9WnTAX6ur3GuHLLCuaxmZ9bdcZlslS/9a2on8hY02rdgFG2t8RxLJ7Xj0ePao+U8qq+MyoXsn6SgMaWD8jAk107HDf887Ixhkoi/8j4hw9G1ww2GMjhZZl8iPJbK/pMfbwYiVnXOHWgXCK8gaU20LJU/w7THf86maS3iUBWAx4GMEdKnaZIHOio3Sj5Pqjaq2HMtIKZeXNPD5g4iQ3YaIxgfMvLA7uTLubl8/nhGOFcHjJVLbJCO9rp2Atg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtU11MwECxWpB8N5IuL6lX8VNqiBkIskoL8EgWfrRiU=;
 b=ajd/XqJzNcgtgBPxIqSnv9WDKcx6iH3i7RPuSiDfjbswJVZGURkgvIuJNLgjLjNxPC7A8PuNQBgGVDuE2gAE1/UmLc3SX6Iqkl3qCN27G6y8n+TMVxV17bUjKNRNfpb4XiwFdlyQK/Chbl84dTdudiYreYWzVfxMNF+J/RhvpwNk5Ibg1SLiI56HYkt3LwskYlOETRrcjhUPvoZCz1oKALK1885YO1pB29MLC0K+CK63gmvK1Tnp1XnNUc0s+i5t/BMWd7hy79A8Zlmu7CvetvgTX5ZOhfN64ZypBWozcJ1axSBcUe3dZ5oPU+KZrQQxSdhztSk55Fp2J73RSxTniA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA4PR04MB7518.eurprd04.prod.outlook.com (2603:10a6:102:e4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 15:48:15 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.8964.026; Tue, 29 Jul 2025
 15:48:15 +0000
Date: Tue, 29 Jul 2025 18:48:11 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jeongjun Park <aha310510@gmail.com>
Cc: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	yangbo.lu@nxp.com, anna-maria@linutronix.de, frederic@kernel.org,
	tglx@linutronix.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+7cfb66a237c4a5fb22ad@syzkaller.appspotmail.com
Subject: Re: [PATCH net v4] ptp: prevent possible ABBA deadlock in
 ptp_clock_freerun()
Message-ID: <20250729154811.a7lg26iuszzoo2sp@skbuf>
References: <20250728062649.469882-1-aha310510@gmail.com>
 <20250728062649.469882-1-aha310510@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728062649.469882-1-aha310510@gmail.com>
 <20250728062649.469882-1-aha310510@gmail.com>
X-ClientProxiedBy: VI1PR07CA0309.eurprd07.prod.outlook.com
 (2603:10a6:800:130::37) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA4PR04MB7518:EE_
X-MS-Office365-Filtering-Correlation-Id: 1273243e-a1b8-4d68-f40e-08ddceb7547d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|376014|10070799003|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?obpfzJNTqwqHevXJFfry8ZsfuNFS9T4sIjOxYey4F2ufXbo33JvZfYe44EOD?=
 =?us-ascii?Q?yWhbcaaiLPftfgIl5qKjtwoGQn7aXH5PiFCgOtQ8/qtQtFhKEgdOrgsHLWOp?=
 =?us-ascii?Q?jvXn712RFwm3o+eIHsPs5HeOibRJTeNxDRCuSVoS7YwzIl4sfZe3TXEV+Dzr?=
 =?us-ascii?Q?lLAEbWDQyR5wQR20U+aywszzMchMn48B+Av+OWPaevNImyjpknPOh1YjBgMH?=
 =?us-ascii?Q?yRpV64XTuFdKv+E0h7WH8vxBxrsYNl68Md4CQFNqlgoJ8PcruzHpXISzmJPu?=
 =?us-ascii?Q?bZ4E1lxV6NzyFBGSSS1iggZY+/5ySrImTTWA+S2gDRNy1Zp/dFANlaJBst9S?=
 =?us-ascii?Q?YwKGUwZwAU1acMOE39nyRZhmVuVMKXt4sY/2SiCfXE0wtyrFgj7paw8rt/hU?=
 =?us-ascii?Q?wHV6P2kkcfOYITK4v7R1bwrY9xhMbyjo4IiG/6WvzrxmNcxd8Z0LDVIuqZk1?=
 =?us-ascii?Q?KdGtUHp4f7wQ+s+rkh0kSBtsc8JFXfuYKn7szaCirj3FQwAFg5wN5a90Qs4V?=
 =?us-ascii?Q?fqXewe0TUSpQE3Y9BUS30koAMApFmUCuGVmcbqppN9yNz3LFhwUTSLm+oCM9?=
 =?us-ascii?Q?11EyVy34MU+ciE63QuYLPq1WUSHQsUyu25NbOpxtwGr6D67iXF9Djivi06+C?=
 =?us-ascii?Q?Gca8LnBoRbteiDhOCBfP0y0Hj/BUM/nRcBC6IflQvaErJAths04RC3yb7lnV?=
 =?us-ascii?Q?ZWXSN7jyltZCVvLL3CpyKvleL2+hRkiMUg5YCmiV4BarMuqOMAMRYBNm7Ypq?=
 =?us-ascii?Q?Qf13j0sipuhR+RgrAtI5cJe4LK5x2FF6kmWz4f0LP0Vjk5lVDKDt0Aww0TOQ?=
 =?us-ascii?Q?LcaoG/M7iSivupqqVImXt4cRUeLK2AlMMzMfMrhJDOvJPECLJhh4Umgu7wJP?=
 =?us-ascii?Q?YRuv0LUfOcSGdZFl13SC58mrirXMELTFSiy75yfTW5sQakI4gxG2iG7t9D4x?=
 =?us-ascii?Q?SMaFp/1nYeOQw9KCOAxdg5OG2m6jYRUrBRhXKatSufY6IN1Kvz6y7kKVhHuh?=
 =?us-ascii?Q?EYIV8CKNdwH0PiBfZrcHw3cEYXmgr6s5gKeQHVyMI+kFiYXZSUzRglxlDhbQ?=
 =?us-ascii?Q?+xWPGfWLbhnvVlqkIdjg5PpDvyr8Ly5XqWpYVnP90zupdyziHQ32G4JlD+SF?=
 =?us-ascii?Q?Mvs8BhV1kjrWm26gDH3WMSiGCbDwXww/2/YLn3uCw8ynayXAFrHW6Ujwacl0?=
 =?us-ascii?Q?2tz2cJkxUktnR7KF8380iL0sguJOtwEceqh2/7bWEmpBCHhlWCSFVuPcYWdv?=
 =?us-ascii?Q?54Vkw6rwuECZeSJm+AQLuPMipI7uK2ofJv/XuAzUg2A2KAhxiYg0giiZctrs?=
 =?us-ascii?Q?frDS5PrR/d93e/6jI/zzxmEuH5ZLkvxhgOIwbX0Ii9Qhk5GB945NBkjQIOS9?=
 =?us-ascii?Q?82935S4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(10070799003)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XUu27VxOm0n37C3ykifsGfcE1ALlddrdj90NUCYFF2l8ZSTSCDWdlATy2AMH?=
 =?us-ascii?Q?u5Fw8WKOPPmppIMq66DE6BZF+QCTk1D648F18YXQ6btAmRNO4PC06bHN5fnr?=
 =?us-ascii?Q?26yXOth34+FdXRfWc/LSXdF9uiytoKamQ/M2/qonTdkxUSyrKzS3WWrYIutH?=
 =?us-ascii?Q?kcdsyqD/CeaVFJivau1nYLJ0ZH4BAB7+MGiQkQUwhKhpY9/UazF9QJ1B20RO?=
 =?us-ascii?Q?d3znAgf11Pvzxx6Udt4iStqznxaKbw2h8laTJsqn66ZuGx7s/JdaG4u814ZS?=
 =?us-ascii?Q?i1ZUw6Yq6FqYLiaFnQ+XEHzrVkBdHlvfswRClWgeu6slg1qXN1r6fDxlnHse?=
 =?us-ascii?Q?qiwgZXltbS2hdhBOvLQgL7IQWFLaWp9KPSud+nvYOhHwQhyZx3yIN9vaHqxx?=
 =?us-ascii?Q?bUTsQkA80I4EGr8DrrMJ/sWjSAjMDFxgqKj4senWN0JdF+JM3loc0Pop12G9?=
 =?us-ascii?Q?JGLTz1R4N9/+bgIk97QE+y8DkHMgfyDlXxe7iJggwZxQ7Q4HpYWGBQP9sxr0?=
 =?us-ascii?Q?ML7Jx/UjV3FxxQf/YneFSBmmAWFWJyMiTqTCb8vMVgdtZkl8NCnu2vV8GXu6?=
 =?us-ascii?Q?nXIGsS3RILN0EJI20KPVPpklwkgKVpMdTyudjiBRcUvW7PVVV0YHcqUEYBHv?=
 =?us-ascii?Q?v6QVF2QnSyBWmoMVxvBlQJNA/gY0qZ2A9x3mqAhVMJrp6Qk05WhhyAgq4E/D?=
 =?us-ascii?Q?lZ8G5f8UPXCPwIW/96C4ZAEqdciwIl45HdzjMY30F1XZ2Cb8YwGbApX7PEQr?=
 =?us-ascii?Q?At/5YPgqMGdpvqGNipCVXcV1tbKIc/BAHlYtyK0JwyB+yFFbuBEhWbI2OQ6A?=
 =?us-ascii?Q?zj/x8uApdgAR8WJQbMNIhnYr1z3KizvskwEWAJcId8VjnZItnY1HIjjokdyF?=
 =?us-ascii?Q?htN6LeyYaZkoKCChdOYpaWOAW2Ljg1enL09IalSy0S8xY3u1ktBPVnWZUZRf?=
 =?us-ascii?Q?Po8wjiSKwfnoAW3voHl2n/d6++QvVCHX/wRI/feejWDmfcxmzRtDTL4Eu73P?=
 =?us-ascii?Q?moOmzJ/4XeIDK4tssbaIG5QZxm0PPUPl1RwAdHnguy8CKuYGB5d5fK6ByTr3?=
 =?us-ascii?Q?S8RktuvGDMa78kvXp51kTuBldgJjo5tGuAA2bDF6RTKRk2ZhvU1nh+sJvefV?=
 =?us-ascii?Q?ApW6ZUYVOyhcBYQprDLJsBqFBjHedjkHXmvQxFLlJoyA2nX+XgRsb7frhwzz?=
 =?us-ascii?Q?HWmOiBW9aRNx1dTK75wQH34C/Xd8U0uRjaU3ErBWAvWoU4BGdMm3HKci9GMF?=
 =?us-ascii?Q?fYmcehxjAAn9VBt0Af66PqQ6O1PtabXFWTKRuzhKqF2+DcOi2hinLZzmfLgF?=
 =?us-ascii?Q?0+ME7H04TfxGcwjiZpujS089PjPiiMz2S1gme1H8SEZJw0lWvrlO0SEBpXIc?=
 =?us-ascii?Q?spO2VhmVArjgIdgP7Iaxc3c3dFnUYTg0yawYwVrDrq+Dz1QN33/YiduCSNCO?=
 =?us-ascii?Q?vvByBpStnFP4wxfWyczpEkXDBevnhtliW9XeO+aDzPkmPOtnZ2qyWGaNXVgK?=
 =?us-ascii?Q?Bwzsy0RCK4AvERYtH5Z8i0wCzpXmPhJLHNsnKc9il/N9cqk9pgCpjEVi1ksL?=
 =?us-ascii?Q?HEPC01NnV5v6FR/vEmNuG4EuIYzRKOU+zxGGRa66XK8lBfoANU4RTIPyeq1w?=
 =?us-ascii?Q?UEFv1FdYN8wTf/lCf/KBXcuzQIB3uPArwSTzDiUkSGptfz/nCXiSF6a7Ap64?=
 =?us-ascii?Q?WW0HFQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1273243e-a1b8-4d68-f40e-08ddceb7547d
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 15:48:15.2204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HZ2faiP/aTbHi6NuNws8XLP6+/s9kctW1y5lBPA6oSObrwOhw1pwHndseB9NkFRTS4PlogtwaFEYFVBDcj99nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7518

On Mon, Jul 28, 2025 at 03:26:49PM +0900, Jeongjun Park wrote:
> syzbot reported the following ABBA deadlock:
> 
>        CPU0                           CPU1
>        ----                           ----
>   n_vclocks_store()
>     lock(&ptp->n_vclocks_mux) [1]
>         (physical clock)
>                                      pc_clock_adjtime()
>                                        lock(&clk->rwsem) [2]
>                                         (physical clock)
>                                        ...
>                                        ptp_clock_freerun()
>                                          ptp_vclock_in_use()
>                                            lock(&ptp->n_vclocks_mux) [3]
>                                               (physical clock)
>     ptp_clock_unregister()
>       posix_clock_unregister()
>         lock(&clk->rwsem) [4]
>           (virtual clock)
> 
> Since ptp virtual clock is registered only under ptp physical clock, both
> ptp_clock and posix_clock must be physical clocks for ptp_vclock_in_use()
> to lock &ptp->n_vclocks_mux and check ptp->n_vclocks.
> 
> However, when unregistering vclocks in n_vclocks_store(), the locking
> ptp->n_vclocks_mux is a physical clock lock, but clk->rwsem of
> ptp_clock_unregister() called through device_for_each_child_reverse()
> is a virtual clock lock.
> 
> Therefore, clk->rwsem used in CPU0 and clk->rwsem used in CPU1 are
> different locks, but in lockdep, a false positive occurs because the
> possibility of deadlock is determined through lock-class.
> 
> To solve this, lock subclass annotation must be added to the posix_clock
> rwsem of the vclock.
> 
> Reported-by: syzbot+7cfb66a237c4a5fb22ad@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=7cfb66a237c4a5fb22ad
> Fixes: 73f37068d540 ("ptp: support ptp physical/virtual clocks conversion")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> ---
> v4: Remove unnecessary lock class annotation and CC "POSIX CLOCKS and TIMERS" maintainer
> - Link to v3: https://lore.kernel.org/all/20250719124022.1536524-1-aha310510@gmail.com/
> v3: Annotate lock subclass to prevent false positives of lockdep
> - Link to v2: https://lore.kernel.org/all/20250718114958.1473199-1-aha310510@gmail.com/
> v2: Add CC Vladimir
> - Link to v1: https://lore.kernel.org/all/20250705145031.140571-1-aha310510@gmail.com/
> ---

For the general idea:

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

>  drivers/ptp/ptp_private.h | 5 +++++
>  drivers/ptp/ptp_vclock.c  | 7 +++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
> index a6aad743c282..b352df4cd3f9 100644
> --- a/drivers/ptp/ptp_private.h
> +++ b/drivers/ptp/ptp_private.h
> @@ -24,6 +24,11 @@
>  #define PTP_DEFAULT_MAX_VCLOCKS 20
>  #define PTP_MAX_CHANNELS 2048
>  
> +enum {
> +	PTP_LOCK_PHYSICAL = 0,
> +	PTP_LOCK_VIRTUAL,
> +};
> +
>  struct timestamp_event_queue {
>  	struct ptp_extts_event buf[PTP_MAX_TIMESTAMPS];
>  	int head;
> diff --git a/drivers/ptp/ptp_vclock.c b/drivers/ptp/ptp_vclock.c
> index 7febfdcbde8b..8ed4b8598924 100644
> --- a/drivers/ptp/ptp_vclock.c
> +++ b/drivers/ptp/ptp_vclock.c
> @@ -154,6 +154,11 @@ static long ptp_vclock_refresh(struct ptp_clock_info *ptp)
>  	return PTP_VCLOCK_REFRESH_INTERVAL;
>  }
>  
> +static void ptp_vclock_set_subclass(struct ptp_clock *ptp)
> +{
> +	lockdep_set_subclass(&ptp->clock.rwsem, PTP_LOCK_VIRTUAL);

Just not sure whether the PTP clock should be exposing this API, or the
POSIX clock, who actually owns the rwsem.

> +}
> +
>  static const struct ptp_clock_info ptp_vclock_info = {
>  	.owner		= THIS_MODULE,
>  	.name		= "ptp virtual clock",
> @@ -213,6 +218,8 @@ struct ptp_vclock *ptp_vclock_register(struct ptp_clock *pclock)
>  		return NULL;
>  	}
>  
> +	ptp_vclock_set_subclass(vclock->clock);
> +
>  	timecounter_init(&vclock->tc, &vclock->cc, 0);
>  	ptp_schedule_worker(vclock->clock, PTP_VCLOCK_REFRESH_INTERVAL);
>  
> --

