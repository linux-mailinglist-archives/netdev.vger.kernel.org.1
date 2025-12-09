Return-Path: <netdev+bounces-244135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 659E2CB021E
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 15:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 74459301963B
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 14:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14ECD2797B5;
	Tue,  9 Dec 2025 14:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TCgJN11q"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010022.outbound.protection.outlook.com [52.101.56.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A5425A34F
	for <netdev@vger.kernel.org>; Tue,  9 Dec 2025 14:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765288814; cv=fail; b=uiEvC6c3np39rtZcOpz/4S2pG6VndqIWNMzjyoGKapu++2oYwyedkrme9WRT6365eP7j26RuU0rLoTQyKNG565a99qqe8UcUD1uHYu1ooFNMz83Gxn7ZLo7BxbSIepHfRPnI15aBGSV0yCerpQPQYpFELRLD81l9FSOSX7xyoiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765288814; c=relaxed/simple;
	bh=G5lUspIcCYa4Pdp7a7YEHWPIbCE3i8sKe3bjws7R5Iw=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=HmJy660Vteuhqgwop1GvrVTL2HLGIOqcm0pT7mZll3GvV5w3lJL3dQXPJ4TJTjPufNRXGbmWO7EwIPMdD7EPTC66iKxI+0ZZ+dxYo8d0vrkCqPaXK73RkMBMtgJ0qPMabzLrbf8qXZrws7JaoJTGK1S/WNaA8O38z1v2XehgpIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TCgJN11q; arc=fail smtp.client-ip=52.101.56.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WgtWMdVgAAkeybsus+ofCKVy7PxMWj6NNaBtJyrN5cFSWMp3q8gIiqoz2l3FyOvxjF/Vftw2b01JFzsNzkR0TfhLeijiu4CfwBTlsh3DnBUvDqyOEvXkgFBo9tDMrO5WPEx0z/uDsIs6ICSQOGZdq0UbpJiM4g50EE7ueWTFykNUghXuOVCdycmt6uagZwFfbHkXlUyI/jC1tp1hsgxHy3NpX1jC4YLW6HhyjcTJ2Ncd2Izm2gV6cW06IdK42ZlmkxY94lztQANYa6jNA3/kGJWyZZEQTbqUsHVSJ7Cfxa7hbAIe4easXJUqQsjIHHG5sNDth+A2nBHGR1zSs1gTTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PxDm6CrO7CCW3TLuPXzwqFn24kV2ZrKPQMVuTaV/uj0=;
 b=NuLxJtyRsnCdfOA4CeaZB6r94VBYbmkaYEiB2ROwfoW1/gtSBtvB2PSdlSAZ0pL53pD5x/IHGMl6nLG2naqa8TwvGKifkekZcGxPPYBBAIGuACHyOeSLAVzIv4FnbtAh5TNnveiRwoFZlgCSS6yXKqF8oJAko/fo8lcD72bpiT0vh/oGt0Jw6xwaqIyp7rBo2JQkNSvPve8uSsCLvue0p8NfjcF9rv4aGqnd5zXbVrnEji/hJ+j354XD01jHdUjc2npMFkoVARnyNsrIp/1GFQGk2xLiEpXy4iKEN3jM5vKynWzJcDIwHqxnK1lakREwsFVOJRx2XvLLVL2Z2OQ2PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxDm6CrO7CCW3TLuPXzwqFn24kV2ZrKPQMVuTaV/uj0=;
 b=TCgJN11q0fuPyE9FtSlAXRkzDh0zhPgeCMPwzOHVXRE9D+SQ0l94D3Jkd0BrN6nF0QFp4lOCfMHk9/eC/f49YWyUBXE2/r5yElBFuTmk1ady14ISoyBit8GJtWZsoqgYdGh/C45rTU1DPZ1k67bHAAZTiTuHwBnm9yxCq09wSoYkQvDLnoDrKZ6AKZE8eougBV+N18I6GVyXeJdk0tMnsg9MaSdUK2H/6cYRUSvmjuNSZgGgefQnYbmT2dra2X0PcwJB3guhBvcyYWvQ7BVB2z5PdyUrIRv1/l0YXy8WcoYO3YVLrk9P9F0QUHz0wxZTVFvAcfNrZS68czCrpZgFsw==
Received: from DM6PR07CA0071.namprd07.prod.outlook.com (2603:10b6:5:74::48) by
 LV8PR12MB9155.namprd12.prod.outlook.com (2603:10b6:408:183::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.7; Tue, 9 Dec 2025 14:00:05 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:5:74:cafe::c) by DM6PR07CA0071.outlook.office365.com
 (2603:10b6:5:74::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Tue,
 9 Dec 2025 14:00:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 14:00:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Dec
 2025 05:59:51 -0800
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Dec
 2025 05:59:45 -0800
References: <20251208190125.1868423-1-victor@mojatatu.com>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Victor Nogueira <victor@mojatatu.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <jhs@mojatatu.com>, <jiri@resnulli.us>,
	<xiyou.wangcong@gmail.com>, <horms@kernel.org>, <dcaratti@redhat.com>,
	<petrm@nvidia.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net 1/2] net/sched: ets: Remove drr class from the
 active list if it changes to strict
Date: Tue, 9 Dec 2025 14:42:10 +0100
In-Reply-To: <20251208190125.1868423-1-victor@mojatatu.com>
Message-ID: <87ikefwybc.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|LV8PR12MB9155:EE_
X-MS-Office365-Filtering-Correlation-Id: 11f44f5a-a2b0-4600-e749-08de372b4112
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NWp6A120122ELK9DseOW48HftR0PhHdK95QfKtn+eJ8KYvlFqbHLrLczZm7m?=
 =?us-ascii?Q?RK28yk3BsFx7oxPVHajEgyqO8OzYCLzyEeXm4e4FK/YQC34F+8SYmit2zk4k?=
 =?us-ascii?Q?I077qipSYf4E9uSPoUw67AS3BU3x9Gd5HuHjx2n0PWD83mCAEK1d/2CZLrr5?=
 =?us-ascii?Q?SSrxnHEzMSrxGI9+kN/TIvApDLrYylhuftjX8wR5UlHl1gLmgfZzKcm/nGdy?=
 =?us-ascii?Q?k4nEUTVm9NReKPZhevVaEqwPy1cijg/kmfmvHKpgg2GUvAFZyyhBPjH9tWqg?=
 =?us-ascii?Q?vUdXuDxfxmOuK19h1GTKliV9BSLXztoW2jFjDbgvRs3fqqpRaBZHI4rzrZX1?=
 =?us-ascii?Q?3KtgmvhdhSLVV6Dc9CUzMvnmykjnE1vJGM2UgIdzkPurfkO3sS/PXqQZV1a4?=
 =?us-ascii?Q?es4XmiQsZ4Hfl+sLMRDAm9K5hW4K2WNW4WIum1ra8OpZHIGPPboSuFgwZtLC?=
 =?us-ascii?Q?72spM7VFtF8N4Y0sDt90iGbh/IUjuCM0MO1GEJYH7Ig2mVRulXHLy5XS4RjE?=
 =?us-ascii?Q?vAJEIphJ08zv5Qn+aodvl9Tj4nc5O8D2Dj8HQlWYbdFDoQkAK9k3/kaPlXKy?=
 =?us-ascii?Q?FsYQZaVbg2b+l6WTZ5/l192nyjVwEkq+XlL0nWYp33/yDvASHSPqbB2hjRVN?=
 =?us-ascii?Q?alznPV6eIvwIzKtFGhsNgdKvEeazs3hV8dJQ94uGtsc1rqbf7BACMiUi59AB?=
 =?us-ascii?Q?eLMV5KOwkr0DLLD6EEbYkFQDIhtLjC2g/wb9CtKtR1M6x9lmNnPmm6ZQQeNv?=
 =?us-ascii?Q?Ri69aj18PMRmre5lkVZbvooLrCGy4bIOLdEb/xvKvYaBnuUK03MJ0/Zgvmnp?=
 =?us-ascii?Q?016cN0OsBRMq3+afJz4KNnP2IcwHVslh1tno/73IsROAsNTbpQ1n2o4i/Wpa?=
 =?us-ascii?Q?Xzs0Qpf2xYLifrXQHcz6aQpFieuE8AMyXYmKdGxypSBqoMmiTO1QrpLLkzZd?=
 =?us-ascii?Q?cf3gp2nsztcPv65tzTS9FSL7PcqGIvfHVVKIwx0ayKWSPRHkscqpQInTnU4x?=
 =?us-ascii?Q?rniyitrlRskx1XWOpmhdOlz1OUU/Cq232CdlZ8GsD+qge9N9QPP+JeJFBi4O?=
 =?us-ascii?Q?knKgcK4hKbGan7hMYfJAeSu3LhCGTSxhQ9avIQ9EVmQ6CgLgZVcp5nKjpyj/?=
 =?us-ascii?Q?IKd0eNkjz2h42io5jcr1w1crNO2nIkzPsKDJMeNbdUWOMblnZ1iH8KgeI9nV?=
 =?us-ascii?Q?/kORFKW5uObrNmX4RrdzYWzx5ZwuLjzX4u+sm9HcHeHLrEDNqLbLG9XAoJ+H?=
 =?us-ascii?Q?lk7QfprBucYIQ4s9t0zMQ1wcjVZsE31RsZiOPUAwBMBiw+2SrY+p0r63ihzt?=
 =?us-ascii?Q?Z775vf6o0+rC+RuJXORlfoyBDRqftp/kruF3HMCT09d3TfXpPCD0ZKzfTIXo?=
 =?us-ascii?Q?5P6XzrQBRcp0tk5k/gTF6y7SAoGXpaT3qTQdUTyEpCkbTSoaQ+A5w5SA+d73?=
 =?us-ascii?Q?NmUF7fOw3pjIRnbL0kfv+yJKTLqSmMf9e8bJqmNzAIJ26nCPQjaquzKjasJy?=
 =?us-ascii?Q?tiiLhOdxBAKHCuDSt/aJgsKFs3xZx9TZT2pazyGA1Pw2PEtzfb0tyH2mOAI3?=
 =?us-ascii?Q?JHV2dNRgDZHSBnnNSoI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 14:00:04.6620
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11f44f5a-a2b0-4600-e749-08de372b4112
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9155


Victor Nogueira <victor@mojatatu.com> writes:

> Whenever a user issues an ets qdisc change command, transforming a
> drr class into a strict one, the ets code isn't checking whether that
> class was in the active list and removing it. This means that, if a
> user changes a strict class (which was in the active list) back to a drr
> one, that class will be added twice to the active list [1].
>
> Doing so with the following commands:
>
> tc qdisc add dev lo root handle 1: ets bands 2 strict 1
> tc qdisc add dev lo parent 1:2 handle 20: \
>     tbf rate 8bit burst 100b latency 1s
> tc filter add dev lo parent 1: basic classid 1:2
> ping -c1 -W0.01 -s 56 127.0.0.1
> tc qdisc change dev lo root handle 1: ets bands 2 strict 2
> tc qdisc change dev lo root handle 1: ets bands 2 strict 1
> ping -c1 -W0.01 -s 56 127.0.0.1
>
> Will trigger the following splat with list debug turned on:
>
> [   59.279014][  T365] ------------[ cut here ]------------
> [   59.279452][  T365] list_add double add: new=ffff88801d60e350, prev=ffff88801d60e350, next=ffff88801d60e2c0.
> [   59.280153][  T365] WARNING: CPU: 3 PID: 365 at lib/list_debug.c:35 __list_add_valid_or_report+0x17f/0x220
> [   59.280860][  T365] Modules linked in:
> [   59.281165][  T365] CPU: 3 UID: 0 PID: 365 Comm: tc Not tainted 6.18.0-rc7-00105-g7e9f13163c13-dirty #239 PREEMPT(voluntary)
> [   59.281977][  T365] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
> [   59.282391][  T365] RIP: 0010:__list_add_valid_or_report+0x17f/0x220
> [   59.282842][  T365] Code: 89 c6 e8 d4 b7 0d ff 90 0f 0b 90 90 31 c0 e9 31 ff ff ff 90 48 c7 c7 e0 a0 22 9f 48 89 f2 48 89 c1 4c 89 c6 e8 b2 b7 0d ff 90 <0f> 0b 90 90 31 c0 e9 0f ff ff ff 48 89 f7 48 89 44 24 10 4c 89 44
> ...
> [   59.288812][  T365] Call Trace:
> [   59.289056][  T365]  <TASK>
> [   59.289224][  T365]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   59.289546][  T365]  ets_qdisc_change+0xd2b/0x1e80
> [   59.289891][  T365]  ? __lock_acquire+0x7e7/0x1be0
> [   59.290223][  T365]  ? __pfx_ets_qdisc_change+0x10/0x10
> [   59.290546][  T365]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   59.290898][  T365]  ? __mutex_trylock_common+0xda/0x240
> [   59.291228][  T365]  ? __pfx___mutex_trylock_common+0x10/0x10
> [   59.291655][  T365]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   59.291993][  T365]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   59.292313][  T365]  ? trace_contention_end+0xc8/0x110
> [   59.292656][  T365]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   59.293022][  T365]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   59.293351][  T365]  tc_modify_qdisc+0x63a/0x1cf0
>
> Fix this by always checking and removing an ets class from the active list
> when changing it to strict.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/tree/net/sched/sch_ets.c?id=ce052b9402e461a9aded599f5b47e76bc727f7de#n663
>
> Fixes: cd9b50adc6bb9 ("net/sched: ets: fix crash when flipping from 'strict' to 'quantum'")
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>

Reviewed-by: Petr Machata <petrm@nvidia.com>

