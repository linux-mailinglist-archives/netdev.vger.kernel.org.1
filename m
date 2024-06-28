Return-Path: <netdev+bounces-107714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAC491C10D
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 16:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45312283822
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 14:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E793F1C0046;
	Fri, 28 Jun 2024 14:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f1r+NMD0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6530FB645
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 14:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719585236; cv=fail; b=IybDf5dZosXabsOg+lFaiAlmqsA+WHQl0apCYpNGDKJD05GfARGwbvsUchSQ5tjE0yyQzXmecGxB3CEmO+QYmajCkGLUrU+ChZTPYMpten+blL0P9tt9vY6A+xkMNQLioSIUIAcFavSoNGA5ZGIIr26qbyFJVY2MmP/kzt3FJQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719585236; c=relaxed/simple;
	bh=hcbW6L0a8x1OgModYEr02gUZ/FM+YGYismBZcQ9uHJM=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=f4Q1gGKK1CIKUDlFiT1El/gJKEig08H19LlpL9GCKBXflcMjNxj+6lWjibSf3tUV+PPBzWe7wOdwFS9IqE8cS6njPfZa6rGAYdf4jW+DY8l3QJF+1mmMBX5TiYyLeKkpQQP+i3D61XdDAl97oEJFS3+3HoRfdyMrs40FU2k8voc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f1r+NMD0; arc=fail smtp.client-ip=40.107.220.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BhcKwWBypJtkfCeOznxU/BKqO0LWuov/v+nOEmcpbLac5+VPLKl6pjY1pdddOTg5OG245gTQBnDZ/hNztnAY+5/jTfDAWXJKxy3HHPhkjTiV90JsGfPVufx5Vavb14AINErBLMJQijdG0Ltqu0bNxcw6sSj+bxC2ltGVMMEonlxxaXBhRWuNBmGHPvbrvcRoN7kLU4R4jaQ3AAn5dRCi2yvkG3NxbGYdI4nBQLymdT+oW8ca7JUk37A2HZI7MPcuK4oW02Dxd3Uil/uw6cSwZ6lV3OlFgx7GC1cgx/TnUHlSOmUvnL0jMLxwfs6dvXBfZwx6JNneoJWBCMkBoQPhbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hcbW6L0a8x1OgModYEr02gUZ/FM+YGYismBZcQ9uHJM=;
 b=XDiBQ3z4/v+j7f7lySbAtNuviTV4yTBvaoCNR9dXYB6Wak7OMT+qZcRNxIQzGwVKwMyq9v9UKWvwX9w9G86Z2WtjWuPUucSWMMH49mz/vEUoxrguzl2O+Y948zqYWCGdgukfRza5V7Vs8vsU0am5nd+n7uIeE+ymDntDXE0pw1gkRi9jabo4ugnzmpmXiIh+8Yq0uJk2vRR+A1lfx0BTHGrAhLqjyzhjLc00SkDPPsKiJA1ezEYCYoCiXGva+l8InhvhWEnQP4IrkZlU5lpvqOv7hR9pqQzhUv7wW7b0WARs7dR2hocA+ol7Ai3J7zgwqFMvqLoXlBhhT3nxsgm0hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcbW6L0a8x1OgModYEr02gUZ/FM+YGYismBZcQ9uHJM=;
 b=f1r+NMD0ZzcjieTZc0hd9jG/QHLV18ZPos55Jgtf6rkeEeVcZM29xzEvFukqrlUlF+w1jDdTt+sqFGhcX6XXnX0dk+ND/7EYLyWBKmRfG64s0ef2RajM0h4wXVgpVZOrPQM4LhyWklYvPKiDdwuxT9Bov0qT3lw9P5DmMIyH0D5zGcoGESe/hYyLRhTxIhq7us3CjrrYTzj3YQCEcGtdhKinKmSmcH5b74u6Y5dBBH8asPr6eQeFfbRCZ/sjN9x6jOp0Yc865n2/o9VgpGKmumfdWFqC/utwrZFdFGABBzcgKcGmkCdyxQA2LuZ+CeP+c1HwnnNLWcBFTAcHMxXkbg==
Received: from BN9PR03CA0422.namprd03.prod.outlook.com (2603:10b6:408:113::7)
 by SJ2PR12MB8184.namprd12.prod.outlook.com (2603:10b6:a03:4f2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.37; Fri, 28 Jun
 2024 14:33:52 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:408:113:cafe::7) by BN9PR03CA0422.outlook.office365.com
 (2603:10b6:408:113::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26 via Frontend
 Transport; Fri, 28 Jun 2024 14:33:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Fri, 28 Jun 2024 14:33:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 28 Jun
 2024 07:33:34 -0700
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 28 Jun
 2024 07:33:31 -0700
References: <20240627185502.3069139-1-kuba@kernel.org>
 <20240627185502.3069139-4-kuba@kernel.org>
User-agent: mu4e 1.8.11; emacs 29.3
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <przemyslaw.kitszel@intel.com>, <petrm@nvidia.com>,
	<willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next v2 3/3] selftests: drv-net: rss_ctx: convert to
 defer()
Date: Fri, 28 Jun 2024 16:31:54 +0200
In-Reply-To: <20240627185502.3069139-4-kuba@kernel.org>
Message-ID: <87ikxt87d9.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|SJ2PR12MB8184:EE_
X-MS-Office365-Filtering-Correlation-Id: 063782ff-6b80-452c-ac99-08dc977f54e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Va4EiDXVwtKj7djYa7XJlonkcSVivAZA4QYO3kDr5mnL//Nsh2wjQlX6Vx5e?=
 =?us-ascii?Q?Wb0m8wGv7HkzelHxjfGeHmYcIZFKlcIe+jc/p5Y8CxnRAtJWD1hMWdSeBrom?=
 =?us-ascii?Q?VgRojEHLnP4BsrW3qc3DZH09mICiUiktsVjM+7EndXSC7wPgxaKgv/EEydGu?=
 =?us-ascii?Q?e9bMKCY9xfKXLtA/7C9cDtL47eqwNHf2L53vONllYN9K968ad/33bzsieCAy?=
 =?us-ascii?Q?wMV8G5D5L2WeGvPlMgdYL2GD0f8gvmi7/pcvmJFoVEXNvRw6P1PXwsjCPtTb?=
 =?us-ascii?Q?fGEq0F+ABNKSF+cExBF3pXMtqDNzAvy8bO72Ly3Ke2KKrO4eg88RK8hfKCA2?=
 =?us-ascii?Q?Fvas8Qf485vc0N4F+v7M0FI9OtFt90y7m2RML9POpyxEVwNOCKncYIfdwZaB?=
 =?us-ascii?Q?vMIGHm2aRi6dmPMl1jfMKUeAT8GAm4gAiynucIp67vsuXAwYf6c6oxSlFvhf?=
 =?us-ascii?Q?rbvqe/piQR5yVEbRRDRNahccU4PabvIMerZWdIJVqLNrY5aY9jA6w9eryS29?=
 =?us-ascii?Q?mQxuuxzwr0735qR+EbdPTp9X+/DE27BjQilEeIEsi2ESSFyFnJL1SO/t0ktr?=
 =?us-ascii?Q?gN57A2IPjUVfcVKft0xqe2OyF287fxWGKKuikWn/2Tri0fOxSamyl6Tuv/fC?=
 =?us-ascii?Q?coDJamgdNdXOcgaKnRJywGtRT/nnHFVky02WtHy/8qe2qsNgzAzfRLRGELOC?=
 =?us-ascii?Q?9YHBpPpi1lJ2cNPmzAY3x25nwViwDmILsVJe2unypr623ld+aT7U3LXcLE9e?=
 =?us-ascii?Q?sRe3FY5wUmau+E8WTlwahubd3xk0SUV3Aw8cUXLP00M8IaX3gnIHq5eTO0Ol?=
 =?us-ascii?Q?DIHCmXfHWDJ/mK01IstPS/SO+AR0G5irMn9RH15b38+DeYEEzi2Fw/6a219P?=
 =?us-ascii?Q?T102y1i+vQ8arOWgpnPSSz4CqN2sjnCNBPi4DBsgvfgf6VnwxRwfnb+0iDtC?=
 =?us-ascii?Q?9BspVXi9hTSgrbaun4fHI+/vjnFSnRnAvlnBu++efXWZ85SWAX7QK9aXhsTr?=
 =?us-ascii?Q?Ytr4154iUH0AkKLfbcQju9BtKLznc2pTa12pjrkOJQ3MSNdLsu60bP0apBwa?=
 =?us-ascii?Q?L8730Ad/+bm15Cloqns5xDHw/7wgIeiMfZs2ZoXFLWxny96jOK/TQPIHBjXk?=
 =?us-ascii?Q?m2OV5zc7QJ+NEapLMkdiE0Mb81GIe7wI+8YZPEU+NQb/fa276Gb/K7ohn1lc?=
 =?us-ascii?Q?dLRQxEpcrdT9ofZy3c2g0a5TN6dnrya58AJYjBHGJ4mn0JPnqEPFrahK5rm9?=
 =?us-ascii?Q?xSzEPAHYRLFsSCYCrAGRMbrya1ujRjZ9xb2op76fQgAg4UyTpalPqBYHf5oE?=
 =?us-ascii?Q?2Y/Qs2In6fo1dMSf+JqIu5XfIVERcXBcV03D7YDDTBL6X7AnnvtiAEgp3BZr?=
 =?us-ascii?Q?ULLVlNmW6whPJUzVcE5lWQvZDO0M6py5sX+YBak2XMHSPEalDrcSai/O1SSa?=
 =?us-ascii?Q?Cbu4jqGveZMEiSC2bbHsftcrI+uWflj/?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 14:33:51.8609
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 063782ff-6b80-452c-ac99-08dc977f54e1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8184


Jakub Kicinski <kuba@kernel.org> writes:

> Use just added defer().
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

All the whitespace changes make it look messy, but it's actually fairly
contained with diff -w.

Reviewed-by: Petr Machata <petrm@nvidia.com>

