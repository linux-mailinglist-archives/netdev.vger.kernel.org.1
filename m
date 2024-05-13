Return-Path: <netdev+bounces-96302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 700418C4E3C
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 10:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93C6B1C21229
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 08:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB2821A06;
	Tue, 14 May 2024 08:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JdqBS+Tb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820FD1D54B
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 08:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715677039; cv=fail; b=u3h1GyuIYbqynxsZV2nyudObT31/Sa52HA8+vKzUf0vZMZi0aJyCFkQlZ2Ejhke4oDd86aUozs3Z6lMd1XVPwtOnlsaLGGQGbtrlZm/oOXSs+c921xPj/Ymu48EK7ri5cWDy5z1iR8ZKpf7+ogyD6ltE8BoWtXCgZ9NMoHG+Gjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715677039; c=relaxed/simple;
	bh=nQ140EO9xOeJ2V9qV+6RhxAcALcyiAxbYEUoMwyubuo=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=qoG3/RLbsee8HHL18J5Q7eZW79NUGyK/kIrtRj3aX9HzFIKYJSFmG1afTSHjy1g0pyPPJITBG/1r8GLEkojPvMXAdedehhdKmuZk5x107obd86e+WEvs75x7t599cOWca5LHeQTu1Izw5W+LKGzKPeKEu0K01+9UOTIHx6aI7AY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JdqBS+Tb; arc=fail smtp.client-ip=40.107.237.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BvwqzfbDmDEzqHIPrF82Y2BGaG6i0utUsiyCp2Qi4gM9zp7ib73j5fArZ5yHDHbpI8fitROayKE3oxepflUztcqi5IiH3RGk0/M8uHtkegaNgqVJfUbygcMXtzJJb9If7HQw5xmvscM8c+Ra+b7q8Ni3QhqObp73IDNiQ4gL8kTyzpv8SwxFtbk4TkJG6fuSuP/CUBfOz2n3WJQX/KnbxhNmibBRKBru/ivYL38tcR1p8vlYrT3Czhec0uKQB/uh35DSmW28jEgr8BFXb6AYmIsYP/34RAIMoJWzGOrxmx6xNGtJ9eVfjTiohEqEnk6w46JqABlsm2OfVwQVrrifng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqtIn2fsa4IW5gEUUX2H44+uAz3Vxr5MxIA9IOnxQBk=;
 b=Tti31LxQ5Odwv5UqiEPyMMRzuQi+UYTkMwOGDGew2JK+S02ZMGDE2Zaqrv7AkUWCKGRXMZcSuIDA3WfRXECD6RqoUS+urOtoNRWcZaJo7J/jasviYdFP2lYm5X08Ykw3xi+M+mVNdp0AJYS4+VF7guM/C1pByHn3+SHRJ67WxS5H0WlycDqp8jXEpis34Jh2aIEYuuSkLRnk9pwyd7OpK/Z2RF3ATy1QxVLmKKZNNfhj0zsCckdvTNVxSzIhAcSlbC7OcJrUV65gzMum1naT0h4VU1KOp6BdFmVDKKhlU+ZZldPiRxVmAgK/yS4//hx5iWml3Z4ft6k4QrRWtXErAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqtIn2fsa4IW5gEUUX2H44+uAz3Vxr5MxIA9IOnxQBk=;
 b=JdqBS+TbQzqqJCX9Bp/z5w3QKixYJLKYuaNLSvGd/nOCFDJ5l5BkdKfQkeRbdPvY1NUp5Yrboaoi1HSSwrXEuNftyhMQT3VIbeY9kENUOVgLzC80jIv/4o7n8Z8YqUMAJd2TxrUTPintVm6aUDr/JWBdmqS4bRvawANf0dig2XuF56eEJQY7y/VTkXS3nWxs1BupC1LpO1cgPeEbrZDaYvatz8Q0ORPM8eDX767QqJ+HQf0JbhQAntsoCpxnzOAzZbEqwold0pkp4a4QjE00JQHOR95A9GeIybA3p0OURTe8M5HUr4zucVmJJAZ1snEI2Ph5ugPQP46tnkKL83yTgg==
Received: from CH0P221CA0032.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::11)
 by SA0PR12MB7464.namprd12.prod.outlook.com (2603:10b6:806:24b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 08:57:11 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::a9) by CH0P221CA0032.outlook.office365.com
 (2603:10b6:610:11d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Tue, 14 May 2024 08:57:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.21 via Frontend Transport; Tue, 14 May 2024 08:57:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 14 May
 2024 01:56:56 -0700
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 14 May
 2024 01:56:52 -0700
References: <20240509160958.2987ef50@kernel.org>
User-agent: mu4e 1.8.11; emacs 29.3
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Florian Westphal <fw@strlen.de>, Simon Horman <horms@kernel.org>, "Hangbin
 Liu" <liuhangbin@gmail.com>, Jaehee Park <jhpark1013@gmail.com>, Petr Machata
	<petrm@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel
	<idosch@nvidia.com>, Davide Caratti <dcaratti@redhat.com>, Matthieu Baerts
	<matttbe@kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [TEST] Flake report
Date: Mon, 13 May 2024 18:52:25 +0200
In-Reply-To: <20240509160958.2987ef50@kernel.org>
Message-ID: <87a5kslqk4.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|SA0PR12MB7464:EE_
X-MS-Office365-Filtering-Correlation-Id: c073b7ac-92d7-4d18-e646-08dc73f3d7ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TmsQiYytQEMiFv8UsFCQ8T9viFvUbnFIFFtfq97I1xKw3zRfzPccnr+yJDZu?=
 =?us-ascii?Q?2MsH6Gr6NIxk+TFjAPNdRt6ZbDef9mne3EMs86wNXokgxHOwXWylC85oGX8C?=
 =?us-ascii?Q?gfCvhEqhSwza9KlVe1aQQuOaMaWJ+TMBsvbi5ba0eEqy54GLOP4VJWDh60pw?=
 =?us-ascii?Q?JZxYKNE+8U4nNXKYqPgCVttdVUm+f2XVEXkh3I8PNgsuABSTykl9u3FH8l5n?=
 =?us-ascii?Q?a3moZvcMItg2Nt4q7S8kKezhazK5uaPi9236LvVzXcaGMZ07S9+OxjFPVlKy?=
 =?us-ascii?Q?npICcYZ9hXfQ3fa4vzFQLMkUUBFoWPW9LfhOxi1O3//IrGNPxZiIn5V9TSYq?=
 =?us-ascii?Q?ruvsoiKFz8j3DJqlUetm8+8DWrrKn6jpkt+gFn5BPIzNAXXgMk6241YhiBun?=
 =?us-ascii?Q?uK4LAVt5p9dkwoq144PYg3oqFJ3CDzu4oGJYV/yT1cL99Eof/bmEwvWV8HFw?=
 =?us-ascii?Q?cc1B1vZxhOlf7jdxuz344KKPmSQRbZsQgjqJ6iIblI8gKCEV26Bss4v1W0lY?=
 =?us-ascii?Q?LflNVax+60Pv+FeKQMOSshb9LxZVp3mZYp23G2/p1fdMyMKAr70KCNyMM13t?=
 =?us-ascii?Q?CSj8dtqLR/gBV9Ar1ZgZyICdwYJqXKh4O6zYhaMtnlNxEP6M5zLZt9VX2V8I?=
 =?us-ascii?Q?v9+/WqtXCAwG42DJaK9USch/uBO2sLtPIwD0hjh5Wx0tGhqozgg9YuI1ymN2?=
 =?us-ascii?Q?spp37uQrCb4MQDW4IRRIG13RB/d/hcl3vY0/qIgL/0rf7oM/1FhcLqgALwt9?=
 =?us-ascii?Q?tqPIu5PdjeQZVI7oiZX5FKIkbrecmFzMm3EnEGE5Cx6nO36EcZUo4ANxxCxs?=
 =?us-ascii?Q?uW/CH6w4xowaty5ze0eQ6HddrMxv+q4h6Qlo+98auFYJdqBacvN1PzqBVoKE?=
 =?us-ascii?Q?9Kvx3gRHuNHrgKDdv8omHfXEJC8rovJ47tseU40XP84Bsjk1y/WMhoBNFkVe?=
 =?us-ascii?Q?X7oqacFt1DwqWFSPQeDQlt9kcxd2Y1k5t+soD9P5mTByk7dr6X56Bw4stwyd?=
 =?us-ascii?Q?Wjr7TA+jsHGMXALstGSEogog/a7ye/G0tMtX40D5NZSx8ok1GSD09D+Xo0u1?=
 =?us-ascii?Q?itoZTieZjrw6x0mc9zGPDpfeiVO5r7e+j8Vd9tbAtAZBQl94rA9XMOoj64Dt?=
 =?us-ascii?Q?uj4wl5xzioXKDMJTehTVq8f234JmrwysplNsJrxAk0b+V3LhSuLQTJdCyCpt?=
 =?us-ascii?Q?i2HUVdq7pgx2tUqMkpVFaD6CdQ4MHvXOhQLL4k1bdeM4nvyKqJm7tAp52fld?=
 =?us-ascii?Q?XgyYvyCnPKz20gCThkVwXqAo3uMBWRcSUcJ2fSrHWJTGW8wC7pAD55A6kdRi?=
 =?us-ascii?Q?87ltaCXcrxBpRPDSHluP8pLbZ9g8Xp8DhaDWQKoEo8uD7Kzw8/rnJkWxIehn?=
 =?us-ascii?Q?uDOHlg477D2nS6CgOSgvfDnKyFvl?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 08:57:11.5210
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c073b7ac-92d7-4d18-e646-08dc73f3d7ee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7464


Jakub Kicinski <kuba@kernel.org> writes:

> sch-tbf-ets-sh, sch-tbf-prio-sh
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> To: Petr Machata <petrm@nvidia.com>
>
> These fail way too often on non-debug kernels :(
> Perhaps we can extend the lower bound?

Hm, it sometimes goes even below -10%. It looks like we'd need to go as
low as -15%.

> vxlan-bridge-1d-sh
> ~~~~~~~~~~~~~~~~~~
> To: Ido Schimmel <idosch@nvidia.com>
> Cc: Petr Machata <petrm@nvidia.com>
>
> Flake fails almost always, with some form of "Expected to capture 0
> packets, got $X"
>
> mirror-gre-lag-lacp-sh
> ~~~~~~~~~~~~~~~~~~~~~~
> To: Petr Machata <petrm@nvidia.com>
>
> Often fails on debug with:
>
> # TEST: mirror to gretap: LAG first slave (skip_hw)                   [FAIL]
> # Expected to capture 10 packets, got 13.
>
> mirror-gre-vlan-bridge-1q-sh, mirror-gre-bridge-1d-vlan-sh
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> To: Petr Machata <petrm@nvidia.com>
>
> Same kind of failure as above but less often and both on debug and non-debug.

I'll look into these.

