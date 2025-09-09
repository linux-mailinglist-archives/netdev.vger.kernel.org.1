Return-Path: <netdev+bounces-221337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB388B50335
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 18:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C75B21C64601
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 16:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C383568E1;
	Tue,  9 Sep 2025 16:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aCHfg7DH"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2051.outbound.protection.outlook.com [40.107.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2559B35336F
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 16:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757436691; cv=fail; b=XVRmL9E93Hxr1BsfJ0FMpJ7Eecz+I9Uwqq9miXPMb7I9YZoubwibyNhW10INQs4ZdNsoUqQpKlEwmf9WJGQDShMyMBoUCjeeCGTRl13ZHEI/lDkDg7Xgtbf2khRZMig5muqLdwP3bd5ZVtDn3NOBWVn/rm3HUbxDGkK8QXkboMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757436691; c=relaxed/simple;
	bh=QFamWY4XmckOgmlxW4dxO2Bx+a991ZXa4+AYPvBZB54=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=YWgNCUKEbnkG7zi/adcZ1aKr4kRXGxxRi9zFpPTbxdlj5FREaZ06080S0cT9dgH5KuNmfggbcNcTC+nrW4RXwd8aj0l6AySksInZaicIRiC+Jp1300PN2QlzcVLLDDOB0NZWMXkcSDxq0VaWabVE06n0xbIS8t8PSvwcx7dxBf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aCHfg7DH; arc=fail smtp.client-ip=40.107.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nO5WDYQdVvh0dd5GGkNh3fpenpREEqz9Lj3YNNepOE7Kt9Mrg2Qi50fk8IqBTt0ltTMMf39stUsJA/NMl1dhdtxY2zz6mgTaKyXvVhHcX4TCEs7jDfr6OC94hdgLBjUA5W1JHBJBqc+IGrMKX7vHuZEJ4fY2zdx79m1ZjVrgrTTXlmmrdDjcfG2JxbWGfpij7styJVV1IupT4cj1s+rdR/tGmbqxnHT6mwoALIFashDQTCIvUSoyxjFYeKT+j+9VHkcxTza2q8ilQIKo2W6rVfTE+Wow7jAcCuskN79d70a21lbgFWnyD4yvpadlWYjbue6wVlVSCiE2Be/JE/NlTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLqlvEpzHTgOySCmc/qG6kLNqin4M+Cucn7IrXlQZyw=;
 b=Lpk3QBVWdMDWzcqUApUJUZg3OMch0GclCD9AVNhgIRGs7m1Ijl5ZvCIBxiCt19hfdedPT/lo2VjaYA+Egb76yKKqWziTim8b9J0cPjQ75DrxvgS82YPjxbB2QR3obV7tsJJp+Whhxsyc1+ND21VzRnnUhSXLj5/PZNKnpldvsGD6zt7a4FrgIQiD6MIT2eaU2iB4HJBtWj7SBm/rxlXD26IaCjRaPmSY8r3984zNprx7B0bOUT0pkDD+sllz71hpfTwPA5S+COoVj5yD7v/CDzoqSrCz6MP+WZsCothWrrmPE0hY2aVluwKst0cNb4kTbJ4YeGh4WnMRs9owSxHVdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLqlvEpzHTgOySCmc/qG6kLNqin4M+Cucn7IrXlQZyw=;
 b=aCHfg7DHcPlV0/HWE8cGswFszdz7RXHaELcTHO4NZOr45uz1Td34NY7KwDq6/SnOYRjo5GKk4NTWEnsJPXZRLZIfIJ4O1zqGhMYaJRZ/SE8GoPqcgnzvklu5+VuLa4ARLmJThm7/VE4JemeFdxXMz9188p6QSwPLCEC1oZXc3oKikXTlUzrvmjopF1BKJdrwyDvGdVOOTSL222erGcXSNJJ0M1U9vNeUBSn/hF4BIaK0Uq3JNaV2U8N+pUjpP0LdS/WgLs9O2YEOeh73zSacqPLERKZVW1DB3rwAHc2eMCFSDgIjcOAO6FpDGESTsAYyoJxhAh3AMajQgR1+EPiJ1Q==
Received: from SJ0PR13CA0023.namprd13.prod.outlook.com (2603:10b6:a03:2c0::28)
 by SA1PR12MB8095.namprd12.prod.outlook.com (2603:10b6:806:33f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 16:51:26 +0000
Received: from SN1PEPF00036F3C.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::ea) by SJ0PR13CA0023.outlook.office365.com
 (2603:10b6:a03:2c0::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.14 via Frontend Transport; Tue,
 9 Sep 2025 16:51:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF00036F3C.mail.protection.outlook.com (10.167.248.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Tue, 9 Sep 2025 16:51:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 9 Sep
 2025 09:50:53 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 9 Sep
 2025 09:50:46 -0700
References: <cover.1757004393.git.petrm@nvidia.com>
 <8087475009dce360fb68d873b1ed9c80827da302.1757004393.git.petrm@nvidia.com>
 <20250908191550.11beb208@kernel.org>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, Simon Horman <horms@kernel.org>, "Nikolay
 Aleksandrov" <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>,
	<bridge@lists.linux.dev>, <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next 02/10] net: bridge: BROPT_FDB_LOCAL_VLAN_0:
 Look up FDB on VLAN 0 on miss
Date: Tue, 9 Sep 2025 15:34:19 +0200
In-Reply-To: <20250908191550.11beb208@kernel.org>
Message-ID: <87ecsfr2oq.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3C:EE_|SA1PR12MB8095:EE_
X-MS-Office365-Filtering-Correlation-Id: 623b37c8-633f-42ac-5c75-08ddefc11ced
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XxZ5U+pd+t5uwfVaVErblnunYtJizPEAJsqIZDH+fpJ6ZPM0KzU0/tn9rmYo?=
 =?us-ascii?Q?nhwKuJo0rFgNcI9LrIgzUxCT7VT4Z6a0Lxd0aC9TQriLn4naOD0P4swPfJWj?=
 =?us-ascii?Q?m21hiR2DtG42DS1a4L93h216xAiZK05LuUbepKx310tjy30Hk3yBpWnf6za6?=
 =?us-ascii?Q?aMCa4eE68JGXLKTJhc0Ss0C2Pg5A6pGplcAKrmSiFwYqKLPNOiJZIIPXcwbD?=
 =?us-ascii?Q?6DD6cZUravpV2FVi67lI6CKE9z7tyUKeO4DX4qUs/M/lDa+mG8/RM0I9aOba?=
 =?us-ascii?Q?Y267MbsgpDn0IwHLoH6plhakLRAqA+IbgbRcnbmMQg2p4Mk6p6F/fU8b4Sip?=
 =?us-ascii?Q?xAVEu2iFDK8HatHXBVV3/kLuRO+MTe/3Q38nsQEElfDgrRdQ8PHePSuh71i4?=
 =?us-ascii?Q?PfnYCXG/6vLGA8gqocfi7hK5dOGOTYlQtGc8wuM6Ckp1K5+0V4hnF92ou594?=
 =?us-ascii?Q?/03JliESJFq2Rvc8P80ZW/uDR+U0zpg3JLVGzbQLe2j5GB4q62m7gR9Cyo7h?=
 =?us-ascii?Q?8/PzSlH4EZXT1pJR1x4Vd48Lwzrs3sBrOefDELm4bCEZum6+XBSbSlX4g3GQ?=
 =?us-ascii?Q?q4x94EOs9uzI3cqQdzVF7BZKwudKjr+XcjgFJG+fVAh9K8zL58Av1VUXq4Kv?=
 =?us-ascii?Q?aOarQPtNjJ8J4EwCADf/nk4jmZl7gpNOJXi31h9Hik2t8LVhlqXm1nJ9veio?=
 =?us-ascii?Q?c47wBbN2IL11U2g9vV566Ea2EJHawEuvcNnHJcB+wzY66Yl9x7QsFCIYS5/x?=
 =?us-ascii?Q?BRh5RK6TUOXoHpZAn4thutncec2C9sc8jwRgtFhP/yMdNNcKho7q8qvxzFNQ?=
 =?us-ascii?Q?3V/s6xmvgjiTj34Q9tIvDbAYKLbw/TmAGiV7ml/jfevArs41nVs7Zlr3dxef?=
 =?us-ascii?Q?gWf4exb7+Fuk94fzJvKTRurs0Ij40pL430s9uvnWGNcAZG2wtPIbii1L4S5I?=
 =?us-ascii?Q?pNZIzCH0K9H1eNwi2XC9ewrBeVnDYFklca2AZYsGDLK2E55aUbgb1TyrhBgL?=
 =?us-ascii?Q?AZ0jnt4XOvii4ENFrAAv3fgPqYx0oXHz2YIbHwrvGCRbNW+hY8m1sC0hDtHU?=
 =?us-ascii?Q?jVLz42h+sJejl8duyuHpDZV8MafxGM1PyDkugkZ3tHe4BXiVXnX03YiiWvAb?=
 =?us-ascii?Q?zvsGEHStInSFBSeDVnrVtrqAi3Q5vkRd51vKu4P5R1Or3MD5H9v8cLbZLAaT?=
 =?us-ascii?Q?I5rZY/OQMGt9CarC9e1WA/lfnQQ7KrO9/l0MGcAO7PRfg86SsZVn2MyXcNqo?=
 =?us-ascii?Q?zVYYuzH0/S1BPW30HSJVIlNQScs5PYG7ktpQ+ZO8OKxfcbaEhO/je1DhuvNd?=
 =?us-ascii?Q?9fWtHpIgPJn8j8iUK/mW2EGBJTI+m/SaKRtI6tsH6aEXbXpHmR07C/Ov5gL6?=
 =?us-ascii?Q?K7khXx0KdiLwp/IxiEqpEEny+MasjFxqZx4pViC1OF5hjXB14ozJEUvZHuz0?=
 =?us-ascii?Q?7mpc9vCv55HAI5ufsqeqMII2HPpXdSEMI3lUsBPUjU+Vbkzw8cXMlLmmvioC?=
 =?us-ascii?Q?MV5TjcQXsNZo3+AkdlEu9WmuWVweNyekxOVj?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 16:51:24.7649
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 623b37c8-633f-42ac-5c75-08ddefc11ced
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8095


Jakub Kicinski <kuba@kernel.org> writes:

> On Thu, 4 Sep 2025 19:07:19 +0200 Petr Machata wrote:
>>  		dst = br_fdb_find_rcu(br, eth_hdr(skb)->h_dest, vid);
>> +		if (unlikely(!dst && vid &&
>> +			     br_opt_get(br, BROPT_FDB_LOCAL_VLAN_0))) {
>
> What does the assembly look like for this? I wonder if we're not better
> off with:
>
> 	unlikely(!dst) && vid && br_opt..

Well, I don't see much there. A couple basic blocks end up reordered is
all I can glean out. I looked at GCC tree dumps which are more
transparent to me, and it's the same exact code in both cases, except
for variable naming, basic block numbering and branch prediction
annotations -- kinda obviously.

> Checking dst will be very fast here, and if we missed we're already 
> on the slow path. So maybe we're better off moving the rest of the
> condition out of the fast path, too?

GCC appears to compile unlikely(A && B && C) as unlikely(A) &&
unlikely(B) && unlikely(C). So it's really much of a muchness -- when we
annotate just !dst, it's going to assume 50/50 on those latter branches,
but we don't really care at that point anymore, because the first 90/10
is going to send us to the slow path. There's a bunch of 50/50 branches
because of __builtin_constant_p's, but those are optimized away in
middle-end. In the end it's the same code, just different basic block
layout decisions.

So we can do either.

